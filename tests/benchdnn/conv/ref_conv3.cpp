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
 * precalc inner kernel loop limits to avoid conditionals */
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
void refconv_3_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
  MUST( p->kh > 0 && KW > 0 );
  MUST( p->dh >= 0 && p->dw >= 0 );
  MUST( SH >= 0 && SW >= 0 );

#if 0
  refconv_2_fwd(p, src_m, wei_m, bia_m, dst_m);

#elif 0 // original hoist, regr 4.72x
  auto ker = [](
      const prb_t *p, dnn_mem_t &src_m, dnn_mem_t &wei_m,
      float &d, const int g, const int mb, const int oc, const int oh, const int ow
      , const int kh_beg, const int kh_end, const int kw_beg, const int kw_end
      ) {
    for (int ic = 0; ic < IC/G; ++ic) {
      for (int kh = kh_beg; kh < kh_end; ++kh)
      {
        const int ih = oh * SH - PH + kh * (p->dh + 1);
        for (int kw = kw_beg; kw < kw_end; ++kw) {
          const int iw = ow * SW - PW + kw * (p->dw + 1); // loop vars: ow, kw
          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
        }
      }
    }
  };

  // writes go to  dst_off_f(p, mb, g, oc, oh, ow);
  OMP(parallel for collapse(5))//;
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int oh = 0; oh < OH; ++oh) {
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            size_t bia_off = bia_off_f(p, g, oc);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0;
            int kh_beg, kh_end, kw_beg, kw_end;
            hoist_ApiB_in( kh_beg, kh_end,
                /*i  in   */ 0, p->kh,
                /*ih=A+iB */ (oh * SH - PH), (p->dh + 1),
                /*ih in   */ 0, IH);
            hoist_ApiB_in( kw_beg, kw_end,
                /*i  in   */ 0, KW,
                /*iw=A+iB */ (ow * SW - PW), (p->dw + 1),
                /*iw in   */ 0, IW);
            if( kw_beg < kw_end && kh_beg < kh_end ) {
              ker( p, src_m, wei_m,
                  d, g, mb, oc, oh, ow
                  , kh_beg, kh_end, kw_beg, kw_end
                 );
            }
            if (p->merge == RELU && d < 0)
              d = 0;
          }
        }
      }
    }
  }
#elif 1 // inline kernel, longhand hoist, short-circuit --> regr 8.28x
  // musek(avx):regr 14.0x
  // writes go to  dst_off_f(p, mb, g, oc, oh, ow);
  // on alexnet, this got me about 15x speedup
  // regr.sh-FWD 2.42x,2.38x
  int khb[OH] alignas(64);
  int khe[OH] alignas(64);
  int kwb[OW] alignas(64);
  int kwe[OW] alignas(64);
  const int ICOG = IC / G;
  const int OCOG = OC / G;
  const int DH   = p->dh + 1;
  const int DW   = p->dw + 1;
  for (int oh = 0; oh < OH; ++oh) {
    // trick to easy calc of kh, kw loop limits is that division must
    // round more consistently.  'C' round-to-zero is not so useful!
    khb[oh] = div_floor( 0  - (oh * SH - PH) + p->dh, DH );
    khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, DH );
    if( khb[oh] < 0  ) khb[oh] = 0;
    if( khe[oh] > KH ) khe[oh] = KH;
  }
  for (int ow = 0; ow < OW; ++ow) {
    kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, DW );
    kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, DW );
    if( kwb[ow] < 0  ) kwb[ow] = 0;
    if( kwe[ow] > KW ) kwe[ow] = KW;
  }
  OMP(parallel for collapse(5))//;
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OCOG; ++oc) {
        for (int oh = 0; oh < OH; ++oh) {
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            size_t bia_off = bia_off_f(p, g, oc);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0.f;
            if( kwb[ow] < kwe[ow] && khb[oh] < khe[oh] ) {
              int ih0 = oh * SH - PH;
              int iw0 = ow * SW - PW;

              for (int ic = 0; ic < ICOG; ++ic) {
                for (int kh = khb[oh]; kh < khe[oh]; ++kh) {
                  //const int ih = oh * SH - PH + kh * DH;
                  const int ih = ih0 + kh * DH;
                  for (int kw = kwb[ow]; kw < kwe[ow]; ++kw) {
                    //const int iw = ow * SW - PW + kw * DW;
                    const int iw = iw0 + kw * DW;
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                  }
                }
              }
            }
            if (p->merge == RELU && d < 0.f)
                d = 0.f;
          }
        }
      }
    }
  }
#else
#error "please select one"
#endif
}

/** inline the kernel.  original guesswork did not do dilation properly.
 * \verbatim
 * **Problem**: Find the lowest khb >= kh_beg such that
 *          osh = ih+PH - khb*DH
 *      AND osh % SH == 0.            i.e. osh = j*SH
 *          (Then oh_beg = osh / SH)
 * Diophantine: solve for unknown integers k,j ...
 *    k*DH + j*SH = X,     where X = ih+PH
 * \endverbatim
 * - One solution is obtained via extendedEuclid Algorithm (outside of loops)
 * - First we quickly check for "no possible solutions"
 * - Then k is adjusted up to "just past zero"
 * - and if j*SH is too big, j is adjusted to "just below OH" (and k goes up)
 *
 * Here is an unoptimized sketch of the calculation
\verbatim
// Calc based on Diophantine equation approach (not optimized)
int k = kh_end;
if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?

    // 1. Find one soln (any)
    int const mul = (ih+PH) / gcd_h;
    k = ha*mul;
    int j = hb*mul;
    DMUST( k*DH + j*SH == X );

    // 2. Adjust to lowest k>=0
    int const dk = SH/gcd_h;
    int const dj = DH/gcd_h;
    int m = (k<0? (-k+ dk -1) / dk
          : k >= dk? - (k / dk)
          : 0);
    if(m){
        k += m * dk;
        j -= m * dj;
    }
    DMUST( k >= 0 && k < dk);
    DMUST( k*DH + j*SH == X ); // still have a soln

    // 3. Adjust j downwards st. j*SH < OH*SH (k can go up even more)
    if( j >= OH ){
        m = (j-OH) / dj + 1;
        k += m * dk;
        j -= m * dj;
        DMUST( j < OH );
        DMUST( j >= OH - (DH/gcd_h) );
        DMUST( k*DH + j*SH == X ); // still have a soln
    }
    DMUST( j*SH < OH*SH );
    }
}
kh_beg = k;
\endverbatim
 * Discovering such formulas <em>by guesswork</em> did not work out
 * well for me at all !
 */
//static
void refconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
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
  OMP(parallel for collapse(5))//;
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
  //int const KH = p->kh;
  //int const OH = OH;
  //int const DH = p->dh + 1;
  //int const SH = SH;
  //int const PH = PH;
  int const DH = p->dh + 1;
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
  int const DW = p->dw + 1;
  const int gcd_w = gcd( SW, DW );
  //const int lcm_w = lcm( SW, DW );
  const int lcm_w = SW * DW/gcd_w;
  const int kww = lcm_w / DW;
  const int jww = lcm_w / SW;
  int wa, wb, wg;
  extendedEuclid( wa, DW, wb, SW, wg);
  DMUST( wg == gcd_w );
  OMP(parallel for collapse(5))//;
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
              int const mul = (ih+PH) / gcd_h;
              kh_beg = ha*mul;
              int m = div_floor(kh_beg, khh);
              kh_beg -= m * khh;
              int j = hb * mul + m * jhh; // var j --> 'm' again
              if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
            }
            if( kh_beg >= kh_end ) continue;

            int kw_end = (iw + PW) / DW + 1;
            if (kw_end > KW) kw_end = KW;
            int kw_beg = kw_end;
            if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
              int const mul = (iw+PW) / gcd_w;
              kw_beg = wa * mul;
              int m = div_floor(kw_beg, kww);
              kw_beg -= m * kww;
              int j = wb * mul + m * jww;
              if (j >= OW) kw_beg += (j-OW)/jww * kww + kww;
            }
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < OC/G; ++oc) {
              for (int kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
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
#else
#error "select one"
#endif
}
#if 0// try to "guess" things   --- no way!
              int oh_beg = (ih+PH - kh_beg * (p->dh+1)) / SH;
              int khb0 = div_floor( (ih + PH) - OH*SH, DH) + 1;
              int khb = khb0;
              if( khb > 0 ){
                // Want first khb >= khb0 such that
                //   ohsh = (ih+PH - khb*DH) is a multiple of SH
                //     [ and >= 0, and < oh_end ]

                // or smallest N>=0 s.t.
                //   khb' = (ih+PH - (khb+N)*DH) has khb'/SH*SH == khb'
                //
                //int ohsh = (ih+PH - khb * (DH));
                //       ~ (ih+PH - ((ih + PH) - OH*SH + DH))
                //       ~ OH*SH - (DH)
                //int ohsh = OH*SH - (DH);
                //if( ohsh % SH != 0 ) ohsh -= lcm_h;
                int ohsh = (ih+PH - khb * (DH));
                if( ohsh % SH != 0 ) ohsh -= ohsh % SH;
                if( ohsh % SH == 0 && kh_beg < kh_end ) RT_ASSERT( ohsh == oh_beg * SH );
                RT_ASSERT( ohsh %SH == 0 );
                //int khb2 = div_floor( (ih+PH) - ohsh + DH , DH );
                //int khb2 = div_floor( (ih+PH) - div_floor(ohsh,SH)*SH + DH-1 , DH ); // almost!
                int khb2 = div_floor( (ih+PH) - div_floor(ih+PH-ohsh,SH)*SH + DH-1 , DH ); // almost!
                print(0, "\n\t\t SH,DH,PH,OH=%d,%d,%d,%d; ih=%d; oh_beg=%d, ohsh=%d, ohsh/SH=%d lcm_h=%d khh=%d khb=%d,%d, khbeg,end=%d,%d",
                    SH,DH,PH,OH, ih, oh_beg,ohsh,ohsh/SH, lcm_h,khh, khb,khb2, kh_beg,kh_end);
                if( kh_beg < kh_end ) RT_ASSERT( khb2 == kh_beg );
                ohsh = (ih+PH - khb2 * (DH));
                print(0, " ohsh'=%d ", ohsh);
                //ohsh -= ohsh % SH;
                //if( kh_beg < kh_end ) RT_ASSERT( rem_floor(ohsh, SH) != 0 );
                // n RT_ASSERT( oh_beg == ohsh/SH );
                //if( !( oh_beg == ohsh/SH )){
                //  print(0, "\n\t\t SH,DH,PH,OH=%d,%d,%d,%d; ih=%d; oh_beg=%d, ohsh=%d, ohsh/SH=%d lcm_h=%d khh=%d khb=%d, khbeg,end=%d,%d\n",
                //      SH, DH, PH, OH, ih, oh_beg, ohsh, ohsh/SH, lcm_h, khh, khb, kh_beg,kh_end);
                //}
                //if( kh_beg < kh_end ) RT_ASSERT( oh_beg == ohsh/SH );
                //RT_ASSERT( kh_beg == khb );
                print(0,"%c",'\n');
              }
#endif






void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
#if 0
    refconv_2_bwd_d(p, diff_src_m, wei_m, diff_dst_m);

#elif 0 // kw_beg, oh_end loop ---> calculation (debug)
  //  MOVED to separate routine
  refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);

  // many impls moved to ref_conv3.cpp.v2 "historical" code
#elif 1 // a new simplification of loop limits (same speed as above)
  // regr-dilate: 2.50x
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // FIXME can we call this even less?
    refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

  int khb[IH], khe[IH], ohb[IH];
  for (int ih = 0; ih < IH; ++ih) {
    //int ocend = (OC/G);
    khe[ih] = ih + PH;
    ohb[ih] = OH - 1;
    khb[ih] = khe[ih] - OH*SH + SH;
    if( khb[ih] < SH - 1 ){ // unlikely?
      ohb[ih] = khe[ih] / SH;
      khb[ih] = khe[ih] % SH;
    }
    if (++khe[ih] > p->kh) khe[ih] = p->kh;
  }
  int kwb[IW], kwe[IW], owb[IW];
  for (int iw = 0; iw < IW; ++iw) {
    kwe[iw] = iw + PW;
    owb[iw] = OW - 1;
    kwb[iw] = kwe[iw] - OW*SW + SW;
    if( kwb[iw] < SW - 1 ){ // unlikely?
      owb[iw] = kwe[iw] / SW;
      kwb[iw] = kwe[iw] % SW;
    }
    if (++kwe[iw] > KW) kwe[iw] = KW;
  }

  OMP(parallel for collapse(5))//;
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            const int kh_e = khe[ih];
            const int kw_e = kwe[iw];
            float tmp = 0.f;

            if( khb[ih] < kh_e && kwb[iw] < kw_e ) {
              for (int oc = 0; oc < OC/G; ++oc) {
                for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
                  for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    tmp += ((float*)diff_dst_m)[dst_off]
                      * ((float*)wei_m)[wei_off];
                  }
                }
              }
            }

            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off]; // WRITTEN
            ds = tmp;
          }
        }
      }
    }
  }
#else
#error "please enable one impl"
#endif
}

/** This one just reuses the hoisting function from FWD.
 * g,oc,ic,kh,kw,mb,oh,ow,[iw],[ih] */
void refconv_3_bwd_w(const prb_t *p, dnn_mem_t &src_m,
    dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
#if 0 // same, but tidy code
  // regr.sh-BWD_W 2.51x,2.51x
  // TRY : nog offset?
  const int DH = p->dh + 1;
  const int DW = p->dw + 1;

  OMP(parallel)//;
  {
    OMP(for collapse(5))//;
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int ic = 0; ic < IC/G; ++ic) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              dw = 0;
            }
          }
        }
      }
    }
    // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
    OMP(for collapse(4))//;
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        //for (int ic = 0; ic < IC/G; ++ic)
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
              int oh_beg, oh_end;
              oh_beg = div_floor(    + PH - kh*DH + SH - 1, SH);//(c-a+b-1)/b
              oh_end = div_floor( IH + PH - kh*DH + SH - 1, SH);//(d-a+b-1)/b
              if (oh_beg < 0    ) oh_beg = 0;
              if (oh_end > OH) oh_end = OH;
              int ow_beg, ow_end;
              ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
              ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
              if (ow_beg < 0    ) ow_beg = 0;
              if (ow_end > OW) ow_end = OW;
              if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;

              for (int ic = 0; ic < IC/G; ++ic) { // involved in WRITE
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
                float &dw = ((float*)diff_wei_m)[wei_off];
                for (int mb = 0; mb < MB; ++mb) {
                  for (int oh = oh_beg; oh < oh_end; ++oh) {
                    for (int ow = ow_beg; ow < ow_end; ++ow) {
                      const int ih = oh * SH - PH + kh * DH;
                      const int iw = ow * SW - PW + kw * DW;
                      size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                      size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                      dw += ((float*)diff_dst_m)[dst_off]
                        * ((float*)src_m)[src_off];
                    }
                  }
                }

              }
            }
          }
      }
    }

    if ((p->dir & FLAG_BIA)) {
      OMP(for collapse(2) nowait)//;
      for (int g = 0; g < G; ++g) {
        for (int oc = 0; oc < OC/G; ++oc) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0;
          for (int mb = 0; mb < MB; ++mb) {
            for (int oh = 0; oh < OH; ++oh) {
              for (int ow = 0; ow < OW; ++ow) {
                size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                db += ((float*)diff_dst_m)[dst_off];
              }
            }
          }
        }
      }
    }
  }
#elif 1 // same, but tidy code
  // regr.sh-BWD_W 2.51x,2.51x
  // TRY : nog offset?
  const int DH = p->dh + 1;
  const int DW = p->dw + 1;

  // precalc nice loop limits
  ssize_t ohw_begend[KH*KW][4];
  const ssize_t ohw_muls[4] = { OW, 1, (1<<24)*OW, (1<<24) };
  bool ook[KH*KW];
  for (int kh = 0; kh < p->kh; ++kh) {
    for (int kw = 0; kw < p->kw; ++kw) {
      int oh_beg, ow_beg, oh_end, ow_end;
      oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);
      ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
      oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
      ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
      if (oh_beg < 0 ) oh_beg = 0;
      if (ow_beg < 0 ) ow_beg = 0;
      if (oh_end > OH) oh_end = OH;
      if (ow_end > OW) ow_end = OW;
      const int khkw = kh*KW+kw;
      ohw_begend[khkw][0] = oh_beg;
      ohw_begend[khkw][1] = ow_beg;
      ohw_begend[khkw][2] = oh_end;
      ohw_begend[khkw][3] = ow_end;
      ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
    }
  }

  OMP(parallel)//;
  {
    OMP(for collapse(5))//;
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int ic = 0; ic < IC/G; ++ic) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              dw = 0;
            }
          }
        }
      }
    }
    // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
    OMP(for collapse(4))//;
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        //for (int ic = 0; ic < IC/G; ++ic)
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
#if 0
              int oh_beg, oh_end;
              oh_beg = div_floor(    + PH - kh*DH + SH - 1, SH);//(c-a+b-1)/b
              oh_end = div_floor( IH + PH - kh*DH + SH - 1, SH);//(d-a+b-1)/b
              if (oh_beg < 0    ) oh_beg = 0;
              if (oh_end > OH) oh_end = OH;
              int ow_beg, ow_end;
              ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
              ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
              if (ow_beg < 0    ) ow_beg = 0;
              if (ow_end > OW) ow_end = OW;
              if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
#else
              const int khkw = kh*KW+kw;
              if( ! ook[khkw] ) continue;
              int oh_beg = ohw_begend[khkw][0];
              int ow_beg = ohw_begend[khkw][1];
              int oh_end = ohw_begend[khkw][2];
              int ow_end = ohw_begend[khkw][3];
#endif

              for (int ic = 0; ic < IC/G; ++ic) { // involved in WRITE
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
                float &dw = ((float*)diff_wei_m)[wei_off];
                for (int mb = 0; mb < MB; ++mb) {
                  for (int oh = oh_beg; oh < oh_end; ++oh) {
                    const int ih = oh * SH - PH + kh * DH;
                    for (int ow = ow_beg; ow < ow_end; ++ow) {
                      size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                      const int iw = ow * SW - PW + kw * DW;
                      size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                      dw += ((float*)diff_dst_m)[dst_off]
                        * ((float*)src_m)[src_off];
                    }
                  }
                }

              }
            }
          }
      }
    }

    if ((p->dir & FLAG_BIA)) {
      OMP(for collapse(2) nowait)//;
      for (int g = 0; g < G; ++g) {
        for (int oc = 0; oc < OC/G; ++oc) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0;
          for (int mb = 0; mb < MB; ++mb) {
            for (int oh = 0; oh < OH; ++oh) {
              for (int ow = 0; ow < OW; ++ow) {
                size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                db += ((float*)diff_dst_m)[dst_off];
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
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0,\:0,N-s
