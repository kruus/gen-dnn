/*******************************************************************************
* Copyright 2017 NEC Laboratories America
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/
/** \file
 * sx vectorization ref_conv3.cpp */
#if defined(_SX)
#include "conv/conv.hpp"
#include "idiv.hpp"

namespace conv {

// BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
extern void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);

static void chk( bool cond, char const* msg, char const* file, int const lineno ){
    if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
}
static bool trivial( int const verb, bool const cond, char const* msg,
                     char const* file, int const lineno ){
    if (verb > verbose && cond){
        printf("@@@ trivial: %s : [%s:%d]\n", msg, file, lineno); fflush(stdout);
    }

    return cond;
}
//#define MUST( COND )
#define MUST( COND )    chk(    (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
#define PRINTF(...)     do{ printf(__VA_ARGS__); fflush(stdout);}while(0)
#define TRIVIAL( COND ) COND
//#define TRIVIAL( COND ) trivial(1, (COND), #COND, __PRETTY_FUNCTION__, __LINE__)

#if defined(NDEBUG)
#define DPRINTF(...)
#define DMUST(...)
#else
#define DPRINTF(...)  do{printf(__VA_ARGS__); fflush(stdout);}while(0)
#define DMUST(...)   MUST(__VA_ARGS__)
#endif

#define G  p->g
#define MB p->mb
#define IC p->ic
#define OC p->oc
#define KH p->kh
#define IH p->ih
#define OH p->oh
#define SH p->sh
#define PH p->ph
#define KW p->kw
#define IW p->iw
#define OW p->ow
#define SW p->sw
#define PW p->pw
#undef G
#undef MB
#undef IC
#undef OC
#undef KH
#undef IH
#undef OH
#undef SH
#undef PH
#undef KW
#undef IW
#undef OW
#undef SW
#undef PW


//const int DH = p->dh + 1;
//const int DW = p->dw + 1;

//----------------------------

/** greatest common denominator, a,b > 0 */
static int gcd(int a, int b)
{
    for (;;)
    {
        if (a == 0) return b;
        b %= a;
        if (b == 0) return a;
        a %= b;
    }
}

/** lowest common multiple, a,b > 0 */
static int lcm(int a, int b)
{
    int temp = gcd(a, b);

    return temp ? (a / temp * b) : 0;
}

/** Solve for integers j, k and g=gcd(a,b) such that ja + ky = g,
 * where a,b are integer constants.
 * This is a linear equation in integers, and is solved
 * via the extended Euclid algorithm.
 */
static void inline extendedEuclid( int& k, int a, int& j, int b, int& g)
{
  int x = 1, y = 0;
  int xLast = 0, yLast = 1;
  int q, r, m, n;
  while (a != 0) 
  {
    q = b / a;
    r = b % a;
    m = xLast - q * x;
    n = yLast - q * y;
    xLast = x; 
    yLast = y;
    x = m; 
    y = n;
    b = a; 
    a = r;
  }
  g = b;
  k = xLast;
  j = yLast;
}

/** hoist `A+iB in range [C,D)` condition out of a loop for i in [imin,imax].
 * When 
 * Original:
 * \code
 * for(i=imin; i<imax; ++i){       // original loop
 *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
 *   if( ApiB < c || ApiB > d ) continue;
 *   // Loop Body
 * }
 * \endcode
 * Transformed:
 * \code
 * int const ibeg, iend;
 * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
 * for(i=ibeg; i<iend; ++i){       // original loop
 *   int const ApiB = a + i*b;
 *   // GONE: if( ApiB < c || ApiB > d ) continue;
 *   // Loop Body
 * }
 * \endcode
 * \pre \c b > 0, (c, d?)
 */
static inline void hoist_ApiB_in( int& beg, int& end,
        const int imin, const int imax,
        const int a, const int b, const int c, const int d)
{
    DMUST( b > 0 );
    // int i*B < A    iff    i < (A    )/B
    // int i*B > A    iff    i > (A+B-1)/A
    // A+iB >= c ... iB >= c-A  ... i >= (c-A + B-1 )/B
#if 1
    beg = div_floor( c-a+b-1, b );
#else
    beg = c-a + b-1;
    if( beg >= 0 ){
        beg /= b;
    } else {
        int const fmul=(-beg + b)/b;
        RT_ASSERT( beg + fmul*b >= 0 );
        beg = (beg + fmul*b) / b - fmul;
    }
#endif
    //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), beg=%d? f+c-a+b-1=%d\n",
    //        imin,imax, a,b, c,d, beg, f+c-a+b-1);
    DMUST( a + (beg-1)*b < c );
    DMUST( a + (beg  )*b >= c );
    if( beg < imin ) beg = imin;

    // A+iB < d ... iB < d-A    ... i < (d-A) / B
#if 1
    end = div_floor( d-a+b-1, b );
#else
    end = d-a +b-1;
    if( end >= 0 ){
        end /= b;
    } else {
        int const fmul=(-end + b)/b;
        RT_ASSERT( end + fmul*b >= 0 );
        end = (end + fmul*b) / b - fmul;
    }
#endif
    //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), end=%d? f+d-a=%d\n",
    //        imin,imax, a,b, c,d, end, f+d-a);
    DMUST( a + (end-1)*b < d );
    DMUST( a + (end  )*b >= d );
    if( end > imax ) end = imax;
}

/** Integer \c i so A-iB is <em>just below</em> \c target.
 * \pre \c B>0 (unchecked). */
static inline int AmiB_lt_target( const int a, const int b, const int target)
{
    int ibelow = a-target + b;
    // XXX use idiv.hpp here too
    if( ibelow >= 0 ){
        ibelow /= b;
        //ibelow = div_floor( ibelow, b );
    } else {
        int const fmul=(-ibelow + b)/b;
        //RT_ASSERT( ibelow + fmul*b >= 0 );
        //RT_ASSERT( fmul == div_floor( -ibelow, b )+1 );
        ibelow = (ibelow + fmul                    *b) / b - fmul; // orig
        //ibelow = (ibelow + (div_floor(-ibelow,b)+1)*b) / b - (div_floor(-ibelow,b)+1);
        //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
        //ibelow = div_floor( ibelow, b );
        //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
    }
    DMUST( a - (ibelow-1)*b >= target );
    DMUST( a - (ibelow  )*b <  target );
    return ibelow;
}
/** Get range if \c i so A-iB is in [c,d), and then further
 * restrict to range [imin,imax).  Note that \c -B means as \c i
 * increases, we move from \c d-1 downwards to \c c. */
static inline void hoist_AmiB_in( int& beg, int& end,
        const int imin, const int imax,
        const int a, const int b, const int c, const int d)
{
    DMUST( b > 0 );
    beg = AmiB_lt_target( a, b, d );
    //RT_ASSERT( beg == div_floor( a-d+b, b) );
    //beg = div_floor( a-d+b, b); // possibly slower ?? do I have a cmov here? no!
    //beg = div_floor( a-d, b) + 1; // possibly slower ?? do I have a cmov here? no!
    if( beg < imin ) beg = imin;

    end = AmiB_lt_target( a, b, c );
    //RT_ASSERT( end == div_floor( a-c+b, b) );
    //end = div_floor( a-c+b, b);
    //end = div_floor( a-c, b) + 1;
    if( end > imax ) end = imax;
}
void sxconv_3_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
#define V 6
#if V==6
  const ssize_t G = p->g;
  const ssize_t MB = p->mb;
  const ssize_t IC = p->ic;
  const ssize_t IH = p->ih;
  const ssize_t IW = p->iw;
  const ssize_t OC = p->oc;
  const ssize_t OH = p->oh;
  const ssize_t OW = p->ow;
  const ssize_t KH = p->kh;
  const ssize_t KW = p->kw;
  const ssize_t PH = p->ph;
  const ssize_t PW = p->pw;
  const ssize_t SH = p->sh;
  const ssize_t SW = p->sw;
  const ssize_t DH = p->dh + 1;
  const ssize_t DW = p->dw + 1;

  const ssize_t ICOG = IC/G;
  const ssize_t ICOG_KH_KW = ICOG * KH * KW;
  const ssize_t OCOG = OC/G;
  const ssize_t OH_OW = OH * OW;
  const ssize_t IH_IW = IH * IW;

  MUST( p->kh > 0 && KW > 0 );
  MUST( p->dh >= 0 && p->dw >= 0 );
  MUST( SH >= 0 && SW >= 0 );
  float const * restrict const psrc = (float*)src_m;
  float const * restrict const pwei = (float*)wei_m;
  float const * restrict const pbia = (float*)bia_m;
  float       * restrict const pdst = (float*)dst_m;
# pragma omp parallel for collapse(4)
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t mb = 0; mb < MB; ++mb) {
      for (ssize_t oh = 0; oh < OH; ++oh) {
        for (ssize_t ow = 0; ow < OW; ++ow) {
          // ---- 1 omp thread ----
          float tmp[OCOG];
          if ((p->dir & FLAG_BIA) == 0){
            for (ssize_t oc = 0; oc < OCOG; ++oc)
              tmp[oc] = 0.f;
          }else{
            ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
            for (ssize_t oc = 0; oc < OCOG; ++oc)
              tmp[oc] = pbia[bia_off0 + oc];
          }
          // this alt to div_floor avoids negatives.
          // ... so it is correct for ussize_ts AND normal div.
          ssize_t kh_beg=0, kh_end=0;
          if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
          kh_end = 0;
          if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
          if (kh_end >= KH) kh_end = KH;

          ssize_t kw_beg=0, kw_end=0;
          if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
          if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
          if (kw_end >= KW) kw_end = KW;

          if( kw_beg < kw_end && kh_beg < kh_end ) {
            for (ssize_t kh = kh_beg; kh < kh_end; ++kh) {
              const ssize_t ih = oh * SH - PH + kh * DH;
              for (ssize_t kw = kw_beg; kw < kw_end; ++kw) {
                const ssize_t iw = ow * SW - PW + kw * DW;
                ssize_t const src_off0 =  ((mb * IC + g * ICOG + 0 ) * IH + ih) * IW + iw;
                for (ssize_t ic = 0; ic < ICOG; ++ic) {
                  ssize_t const wei_off0 = ((((ssize_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
                  float wei[OCOG];
                  float vsrc = psrc[src_off0 + ic * IH_IW];
                  for (ssize_t oc = 0; oc < OCOG; ++oc) {
                    wei[oc] = pwei[wei_off0 + oc * ICOG_KH_KW];
                    tmp[oc] += vsrc * wei[oc];
                  }
                }
              }
            }
          }
          //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
          if (p->merge == RELU) {
            for (size_t oc = 0; oc < OCOG; ++oc)
              tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
          }
          const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
          for (size_t oc = 0; oc < OCOG; ++oc)
            pdst[dst_off0 + oc * OH_OW] = tmp[oc];
        }
      }
    }
  }
#else
#error "please select one"
#endif
}

static void sxconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
{
#if 0 // shorten, do same for kw,ow loop. tweaks to kh calc
  int const KH = p->kh;
  int const OH = OH;
  int const DH = p->dh + 1;
  int const SH = SH;
  int const PH = PH;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  DMUST( khh == SH / gcd(SH,DH) );
  const int jhh = lcm_h / SH;
  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
  DMUST( hg == gcd_h );

  int const KW = p->kh;
  int const DW = p->dw + 1;
  int const SW = SW;
  int const OW = OW;
  int const PW = PW;
  const int gcd_w = gcd( SW, DW );
  //const int lcm_w = lcm( SW, DW );
  const int lcm_w = SW * DW/gcd_w;
  const int kww = lcm_w / DW;
  const int jww = lcm_w / SW;
  int wa, wb, wg;
  extendedEuclid( wa, DW, wb, SW, wg);
  DMUST( wg == gcd_w );
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_end = (ih + PH) / DH + 1;
            if (kh_end > KH) kh_end = KH;
            int kh_beg = kh_end;
            if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
              // 1. Find one soln (any)
              int const mul = (ih+PH) / gcd_h;
              kh_beg = ha*mul;
              int j = hb*mul;
              // 2. Adjust to lowest kh_beg>=0
#if 0 // ok
              int m = (kh_beg<0? (-kh_beg+ khh -1) / khh
                  : kh_beg >= khh? - (kh_beg / khh)
                  : 0);
              RT_ASSERT( kh_beg + m*khh == rem_floor( kh_beg, khh ) ); // adjust kh_beg in khh-steps
              RT_ASSERT( m == (rem_floor(kh_beg,khh) - kh_beg) / khh ); // y
              RT_ASSERT( m == - div_floor(kh_beg,khh) ); // y
              if(m){
                  kh_beg += m * khh;
                  j -= m * jhh;
              }
#elif 0 // ok
              int k2 = rem_floor( kh_beg, khh );
              int m = (k2-kh_beg) / khh;
              kh_beg = k2;
              j -= m * jhh;
#elif 1 // ok
              int m = div_floor(kh_beg, khh);
              kh_beg -= m * khh;
              j      += m * jhh;
#endif
              // 3. Adjust j downwards st. j*SH < OH*SH (kh_beg can go up even more)
              if( j >= OH ){
                m = (j-OH) / jhh + 1;
                kh_beg += m * khh;
                //j      -= m * jhh; // not needed
              }
            }
            if( kh_beg >= kh_end ) continue;
#if 0
            int kw_beg, /*ow_beg,*/ kw_end;
            kw_end = (iw + PW) / (p->dw+1) + 1;
            if (kw_end > KW) kw_end = KW;
            kw_beg = div_floor( (iw + PW) - OW*SW, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
              int owxsw = iw+PW - kw_beg * (p->dw+1);
              if (owxsw % SW){
                do {
                  ++kw_beg;
                  owxsw = iw+PW - kw_beg * (p->dw+1);
                } while( owxsw % SW != 0 && kw_beg < kw_end );
                DMUST( kw_beg >= kw_end || (iw+PW - kw_beg * (p->dw+1)) % SW == 0 );
              }
            }
            DMUST( kw_beg >= 0 );
#else
            int kw_end = (iw + PW) / DW + 1;
            if (kw_end > KW) kw_end = KW;
            int kw_beg = kw_end;
            if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
              int const mul = (iw+PW) / gcd_w;
              kw_beg = wa*mul;
              //int j = wb*mul;
              int m = div_floor(kw_beg, kww);
              kw_beg -= m * kww;
              int j = wb * mul + m * jww;
              if( j >= OW ){
                m = (j-OW) / jww + 1;
                kw_beg += m * kww;
                //j -= m * jww; // not needed
              }
            }
#endif
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < OC/G; ++oc) {
              for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  ds += ((float*)diff_dst_m)[dst_off]
                    * ((float*)wei_m)[wei_off];
                }
              }
            }

          }
        }
      }
    }
  }
#elif 1 // clean up
  float       * restrict const pdiff_src = (float*)diff_src_m;
  float const * restrict const pwei = (float*)wei_m;
  //float const * restrict const pbia = (float*)bia_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
#define G  p->g
#define MB p->mb
#define IC p->ic
#define OC p->oc
#define KH p->kh
#define IH p->ih
#define OH p->oh
#define SH p->sh
#define PH p->ph
#define KW p->kw
#define IW p->iw
#define OW p->ow
#define SW p->sw
#define PW p->pw
  //int const KH = p->kh;
  //int const OH = OH;
  //int const DH = p->dh + 1;
  //int const SH = SH;
  //int const PH = PH;
  size_t const DH = p->dh + 1;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  DMUST( khh == SH / gcd(SH,DH) );
  const int jhh = lcm_h / SH;
  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
  DMUST( hg == gcd_h );

  //int const KW = p->kh;
  //int const SW = SW;
  //int const OW = OW;
  //int const PW = PW;
  size_t const DW = p->dw + 1;
  const int gcd_w = gcd( SW, DW );
  //const int lcm_w = lcm( SW, DW );
  const int lcm_w = SW * DW/gcd_w;
  const int kww = lcm_w / DW;
  const int jww = lcm_w / SW;
  int wa, wb, wg;
  extendedEuclid( wa, DW, wb, SW, wg);
  DMUST( wg == gcd_w );
  const size_t OCOG = OC / G;
  const size_t ICOG = IC / G;
  const size_t ICOG_KH_KW = ICOG * KH * KW;
  const size_t OH_OW = OH * OW;
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = pdiff_src[src_off];
            ds = 0;

            size_t kh_end = (ih + PH) / DH + 1;
            if (kh_end > KH) kh_end = KH;
            size_t kh_beg = kh_end;
            if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
              int kh_ibeg = kh_end;
              int const mul = (ih+PH) / gcd_h;
              kh_ibeg = ha*mul;
              int m = div_floor(kh_ibeg, khh);
              kh_ibeg -= m * khh;
              int j = hb * mul + m * jhh; // var j --> 'm' again
              if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
              kh_beg = kh_ibeg;
            }
            if( kh_beg >= kh_end ) continue;

            size_t kw_end = (iw + PW) / DW + 1;
            if (kw_end > KW) kw_end = KW;
            size_t kw_beg = kw_end;
            if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
              int kw_ibeg;
              int const mul = (iw+PW) / gcd_w;
              kw_ibeg = wa * mul;
              int m = div_floor(kw_ibeg, kww);
              kw_ibeg -= m * kww;
              int j = wb * mul + m * jww;
              if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
              kw_beg = kw_ibeg;
            }
            if( kw_beg >= kw_end ) continue;

            for (size_t kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
                kh < kh_end;
                oh0 -= lcm_h, kh += khh)
            {
              for (size_t kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
                  kw < kw_end;
                  ow0 -= lcm_w, kw += kww)
              {
                const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh0/SH) * OW + ow0/SH;
                const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
                float d[OCOG], w[OCOG];
                for (size_t oc = 0; oc < OCOG; ++oc) {
                  //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
                  //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  //ds += pdiff_dst[dst_off] * pwei[wei_off];
                  d[oc] = pdiff_dst[dst_off0 + oc*OH_OW];
                  w[oc] = pwei     [wei_off0 + oc*ICOG_KH_KW];
                  ds += d[oc] * w[oc];
                }
              }
            }

          }
        }
      }
    }
  }
#undef G
#undef MB
#undef IC
#undef OC
#undef KH
#undef IH
#undef OH
#undef SH
#undef PH
#undef KW
#undef IW
#undef OW
#undef SW
#undef PW
#else
#error "select one"
#endif
}

void sxconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
  float       * restrict const pdiff_src = (float*)diff_src_m;
  float const * restrict const pwei = (float*)wei_m;
  //float const * restrict const pbia = (float*)bia_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
#if 1 // a new simplification of loop limits (same speed as above)
  // regr-dilate: 2.50x
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // FIXME can we call this even less?
    sxconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }
#define MAC 0
#if MAC
#define G  p->g
#define MB p->mb
#define IC p->ic
#define OC p->oc
#define KH p->kh
#define IH p->ih
#define OH p->oh
#define SH p->sh
#define PH p->ph
#define KW p->kw
#define IW p->iw
#define OW p->ow
#define SW p->sw
#define PW p->pw
#else
  const ssize_t G = p->g;
  const ssize_t MB = p->mb;
  const ssize_t IC = p->ic;
  const ssize_t IH = p->ih;
  const ssize_t IW = p->iw;
  const ssize_t OC = p->oc;
  const ssize_t OH = p->oh;
  const ssize_t OW = p->ow;
  const ssize_t KH = p->kh;
  const ssize_t KW = p->kw;
  const ssize_t PH = p->ph;
  const ssize_t PW = p->pw;
  const ssize_t SH = p->sh;
  const ssize_t SW = p->sw;
  const ssize_t DH = p->dh + 1;
  const ssize_t DW = p->dw + 1;
  const ssize_t ICOG = IC/G;
  const ssize_t ICOG_KH_KW = ICOG * KH * KW;
  const ssize_t OCOG = OC / G;
  const ssize_t OH_OW = OH * OW;
#endif
# pragma omp parallel for collapse(4)
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t mb = 0; mb < MB; ++mb) {
      for (ssize_t ic = 0; ic < ICOG; ++ic) {
        for (ssize_t ih = 0; ih < IH; ++ih) {
          register ssize_t kh_e = ih + PH;
          ssize_t oh_b = OH - 1;
          ssize_t kh_b = kh_e - OH*SH + SH;
          if( kh_b < SH - 1 ){ // unlikely?
            oh_b = kh_e / SH;
            kh_b = kh_e % SH;
          }
          if (++kh_e > KH) kh_e = KH;

          ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0);
          for (ssize_t iw = 0; iw < IW; ++iw) {
            register ssize_t kw_e = iw + PW;
            ssize_t ow_b = OW - 1;
            ssize_t kw_b = kw_e - OW*SW + SW;
            if( kw_b < SW - 1 ){ // unlikely?
              ow_b = kw_e / SW;
              kw_b = kw_e % SW;
            }
            if (++kw_e > KW) kw_e = KW;

            float tmp = 0.f;
            if( kh_b < kh_e && kw_b < kw_e ){
              for (ssize_t kh = kh_b, oh=oh_b; kh < kh_e; --oh, kh+=SH) {
                for (ssize_t kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw += SW) {
                  const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
                  const ssize_t dst_off0 = ((mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
                  for (ssize_t oc = 0; oc < OCOG; ++oc) {
                    //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
                    tmp += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
                  }
                }
              }
            }

            pdiff_src[src_off0+iw] = tmp; // MUST always be executed (even to store 0.f)
          }

        }
      }
    }
  }
#if MAC
#undef G
#undef MB
#undef IC
#undef OC
#undef KH
#undef IH
#undef OH
#undef SH
#undef PH
#undef KW
#undef IW
#undef OW
#undef SW
#undef PW
#endif
#else
#error "please enable one impl"
#endif
}

/** This one just reuses the hoisting function from FWD.
 * g,oc,ic,kh,kw,mb,oh,ow,[iw],[ih] */
void sxconv_3_bwd_w(const prb_t *p, dnn_mem_t &src_m,
    dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
#if 1
  const ssize_t G = p->g;
  const ssize_t MB = p->mb;
  const ssize_t IC = p->ic;
  const ssize_t IH = p->ih;
  const ssize_t IW = p->iw;
  const ssize_t OC = p->oc;
  const ssize_t OH = p->oh;
  const ssize_t OW = p->ow;
  const ssize_t KH = p->kh;
  const ssize_t KW = p->kw;
  const ssize_t PH = p->ph;
  const ssize_t PW = p->pw;
  const ssize_t SH = p->sh;
  const ssize_t SW = p->sw;
  const ssize_t DH = p->dh + 1;
  const ssize_t DW = p->dw + 1;
  const ssize_t ICOG = IC/G;
  const ssize_t ICOG_KH_KW = ICOG * KH * KW;
  const ssize_t OCOG = OC / G;
  const ssize_t OH_OW = OH * OW;
  const ssize_t IH_IW = IH * IW;
  const ssize_t KH_KW = KH * KW;
  const ssize_t SH_IW = SH * IW;
  float const * restrict const psrc = (float*)src_m;
  float       * restrict const pdiff_wei = (float*)diff_wei_m;
  float const * restrict const pdiff_bia = (float*)diff_bia_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
# pragma omp parallel
  {
#if 1 // SX leave this in!
#   pragma omp for collapse(3)
    for (ssize_t g = 0; g < G; ++g) {
      for (ssize_t oc = 0; oc < OCOG; ++oc) {
        for (ssize_t ic = 0; ic < ICOG; ++ic) {
          const ssize_t wei_off00 = ((((size_t)g * OCOG + oc) * ICOG + ic) * KH + 0) * KW + 0;
          for (ssize_t kh = 0; kh < KH; ++kh) {
            for (ssize_t kw = 0; kw < KW; ++kw) {
              pdiff_wei[wei_off00 + kh*KW + kw] = 0.f;
            }
          }
        }
      }
    }
#endif
    // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
#   pragma omp for collapse(4)
    for (ssize_t g = 0; g < G; ++g) {
      for (ssize_t oc = 0; oc < OCOG; ++oc) {
        //for (ssize_t ic = 0; ic < IC/G; ++ic)
          for (ssize_t kh = 0; kh < p->kh; ++kh) {
            for (ssize_t kw = 0; kw < KW; ++kw) {
              const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
              ssize_t oh_beg, oh_end;
              oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
              oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
              if (oh_beg < 0    ) oh_beg = 0;
              if (oh_end > OH) oh_end = OH;
              ssize_t ow_beg, ow_end;
              ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
              ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
              if (ow_beg < 0    ) ow_beg = 0;
              if (ow_end > OW) ow_end = OW;
              if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
              //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
              const size_t ow_emb = ow_end - ow_beg;

              float dw_ic[ICOG];
              //float dw_ic[ICOG][MB];
              for (ssize_t ic = 0; ic < ICOG; ++ic) {
                float tmp = 0.f;
                for (ssize_t mb = 0; mb < MB; ++mb) {
                  for (ssize_t oh = oh_beg; oh < oh_end; ++oh) {
                    const size_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh) * OW + ow_beg;
                    const ssize_t ih = ih0 + oh * SH;
                    const size_t iw_beg = ow_beg * SW - PW + kw * DW;
                    const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + iw_beg;
                    //const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + ow_beg * SW - PW + kw * DW;
                    for (size_t ow = 0; ow < ow_emb; ++ow) {
                     tmp += pdiff_dst[dst_off_beg+ow] * psrc[src_off_beg + ow*SW];
                    }
                  }
                }
                dw_ic[ic] = tmp;
              }
              const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
              for (ssize_t ic = 0; ic < ICOG; ++ic){
                pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
              }

            }
          }
      }
    }

    if ((p->dir & FLAG_BIA)) {
#   pragma omp for collapse(2) nowait
      for (ssize_t g = 0; g < G; ++g) {
        for (ssize_t oc = 0; oc < OCOG; ++oc) {
          ssize_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0;
          for (ssize_t mb = 0; mb < MB; ++mb) {
            const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
            for (ssize_t oh = 0; oh < OH; ++oh) {
              for (ssize_t ow = 0; ow < OW; ++ow) {
                db += pdiff_dst[dst_off00 + oh*OW + ow];
              }
            }
          }
        }
      }
    }
  }
#else
#error "select one"
#endif
}

}
#endif // defined(_SX)
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0,\:0,N-s
