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
 * ref_conv3.cpp --[SX-ACE]--> sx_conv3.cpp --[post_ops]--> sx_conv5.cpp */
#if !defined(__ve)
#include "conv/conv.hpp"
#include "idiv.hpp"

#include <iostream>
using namespace std;

namespace conv {

// BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
extern void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
extern void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
extern void sxconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
extern void sxconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);

void refconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);

extern void refconv_4_bwd_w(const prb_t *p, dnn_mem_t &src_m,
    dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m);

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
#if 0
  // During above, xlast alternates +ve, -ve, ...
  // Let's always provide the solution such that k >= 0 ...
  if (xLast < 0){
    //xLast += b0/b; yLast -= a0/b;
    // lowest common multiples (b/gcd and a/gcd) are in x,y
    xLast += x;
    yLast += y;
  }
#endif
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
    beg = div_floor( c-a+b-1, b );
    DMUST( a + (beg-1)*b < c );
    DMUST( a + (beg  )*b >= c );
    if( beg < imin ) beg = imin;
    end = div_floor( d-a+b-1, b );
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

void sxconv_5_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
#define V 13 // from sx_conv3.cpp
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
  const ssize_t OCOG = OC/G;
  const ssize_t KH_KW = KH * KW;
  const ssize_t ICOG_KH_KW = ICOG * KH_KW;
  const ssize_t OH_OW = OH * OW;
  const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
  const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
  const ssize_t IH_IW = IH * IW;
  const ssize_t SH_IW = SH * IW;
  const ssize_t DH_IW = DH * IW;

  ssize_t khb[OH] alignas(64), khe[OH] alignas(64), kwb[OW] alignas(64), kwe[OW] alignas(64);
  ALLOC_ON_VREG(khb,OH) ALLOC_ON_VREG(khe,OH) ALLOC_ON_VREG(kwb,OW) ALLOC_ON_VREG(kwe,OW)
  ssize_t ksrc[KH*KW] alignas(64);
  int ss[ICOG_KH_KW] alignas(64);

  MUST( p->kh > 0 && KW > 0 );
  MUST( p->dh >= 0 && p->dw >= 0 );
  MUST( SH >= 0 && SW >= 0 );
  float const * restrict const psrc = (float*)src_m;
  float const * restrict const pwei = (float*)wei_m;
  float const * restrict const pbia = (float*)bia_m;
  float       * restrict const pdst = (float*)dst_m;

  OMP(parallel) {
    int kokh[KH] alignas(16); VREG(kokh)//;
    int kokw[KW] alignas(16); VREG(kokw)//;
    int kok2[KH*KW] alignas(16); VREG(kok2)//;
    int sok2[ICOG*KH*KW] alignas(16);
    //float zer[ICOG*KH*KW] alignas(16);
    //float src[ICOG*KH*KW]; ALLOC_ON_VREG(src)//;
    float src[ICOG*KH*KW] alignas(16); ALLOC_ON_VREG(src)//;
    float tmp[OCOG] alignas(16);       ALLOC_ON_VREG(tmp,OCOG)//; // roughly double the speed;

    int khkw_begend[4] alignas(16);
    int khkw_muls[4]   alignas(16) = {1, KH, (1<<16), (1<<16)*p->kw};
    VREG(khkw_begend) VREG(khkw_muls)//;

    ssize_t khash, w0, s0, s00;
    ssize_t khash_prv = ~0;
    float sum;

    OMP(single nowait) for (int oh = 0; oh < OH; ++oh) {
      khb[oh] = div_floor( 0  - (oh * SH - PH) + p->dh, (p->dh+1) );
      khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
      if( khb[oh] < 0     ) khb[oh] = 0;
      if( khe[oh] > p->kh ) khe[oh] = p->kh;
    }
    OMP(single nowait) for (int ow = 0; ow < OW; ++ow) {
      kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, (p->dw+1) );
      kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
      if( kwb[ow] < 0  ) kwb[ow] = 0;
      if( kwe[ow] > KW ) kwe[ow] = KW;
    }
    OMP(single nowait)
    {
      for (int kh = 0; kh < KH; ++kh) {
        for (int kw = 0; kw < KW; ++kw) {
          ksrc[kh*KW+kw] = kh*DH_IW + kw*DW;
        }
      }
      for (ssize_t ic = 0; ic < ICOG; ++ic) {
        ShortLoop() OMP(simd) for (ssize_t khkw = 0; khkw < KH_KW; ++khkw) {
          ss[ic*KH_KW + khkw] = ic*IH_IW + ksrc[khkw];
        }
      }
    }
    OMP(barrier)//;

    OMP(for collapse(4))//;
    for (ssize_t g = 0; g < G; ++g) {
      for (ssize_t mb = 0; mb < MB; ++mb) {
        for (ssize_t oh = 0; oh < OH; ++oh) {
          for (ssize_t ow = 0; ow < OW; ++ow) {
            // ---- 1 omp thread ----
            if ((p->dir & FLAG_BIA) == 0){
              for (ssize_t oc = 0; oc < OCOG; ++oc)
                tmp[oc] = 0.f;
            }else{
              ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
              for (ssize_t oc = 0; oc < OCOG; ++oc)
                tmp[oc] = pbia[bia_off0 + oc];
            }
            bool const khw_ok = ( khb[oh] < khe[oh] && kwb[ow] < kwe[ow] );
            if (khw_ok)
            {
              khkw_begend[0] = khb[oh];
              khkw_begend[1] = khe[oh];
              khkw_begend[2] = kwb[ow];
              khkw_begend[3] = kwe[ow];
              khash = 0;
              OMPSIMD()
              for (size_t i=0; i<4; ++i)
                khash += khkw_begend[i] * khkw_muls[i];
              if (khash != khash_prv){
                khash_prv = khash;
                ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) { kokh[kh] = (kh>=khb[oh] && kh<khe[oh]); }
                ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) { kokw[kw] = (kw>=kwb[ow] && kw<kwe[ow]); }
                ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
                  ShortLoop() OMP(simd) for (ssize_t kw = 0; kw < KW; ++kw) {
                    //kok2[kh*KW+kw] = (kh>=khb[oh] && kw>=kwb[ow]) && (kh<khe[oh] && kw<kwe[ow]);
                    kok2[kh*KW+kw] = kokh[kh] && kokw[kw];
                  }
                }
                for (ssize_t ic = 0; ic < ICOG; ++ic) {
                  ShortLoop() OMP(simd) for (ssize_t khkw = 0; khkw < KH_KW; ++khkw) {
                    sok2[ic*KH_KW + khkw] = kok2[khkw];
                  }
                }
              }

              const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
              const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-PW+0*DW); //ic,kh,kw=0
              //IVDEP()//;
              for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
                src[ickhkw] = (sok2[ickhkw]? psrc[s0 + ss[ickhkw]]: 0.f);
              }
              // this would fail if wei access also needed protection. (but it doesn't)
              for (ssize_t oc = 0; oc < OCOG; ++oc) {
                const float * restrict const wei = &pwei[w0 + oc * ICOG_KH_KW]; //?? align
                IVDEP() for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
                  tmp[oc] += src[ickhkw] * wei[ickhkw];
                }
              }
            }
            //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
            if (p->merge == RELU) {
              OMP(simd) for (ssize_t oc = 0; oc < OCOG; ++oc)
                tmp[oc] = (tmp[oc] >0.f? tmp[oc]: 0.f);
            }

#if 0
            for (ssize_t oc = 0; oc < OCOG; ++oc) {
              // original : conv_res instead of tmp[oc]
              maybe_scale(p, conv_res, g * OC / G + oc);
              float &dst = pdst[dst_off];
              maybe_post_ops(p, conv_res, dst);
            }
#endif

            //maybe_scale(p, tmp[oc], g * OCOG + oc);
            {
              // THIS has a lot of common code !!
              if (!p->attr.oscale.is_def()) {
                using policy_t = attr_t::scale_t::policy_t;
                const auto &s = p->attr.oscale;
                float scale = 1.0f;
                if (s.policy == policy_t::COMMON) {
                  if (s.scale != 1.0f) {
                    for (ssize_t oc = 0; oc < OCOG; ++oc) {
                      tmp[oc] *= s.scale;
                    }
                  }
                } else {
                  for (ssize_t oc = 0; oc < OCOG; ++oc) {
                    tmp[oc] *= p->scales[ g*OCOG + oc ];
                  }
                }
              }
            }

            const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
            //maybe_post_ops(p, conv_res, dst);
            {
              const auto &ops = p->attr.post_ops;
              for (int idx = 0; idx < ops.len; ++idx) {
                using pk = attr_t::post_ops_t::kind_t;
                const auto &e = ops.entry[idx];
                switch (e.kind) {
                  case pk::SUM:
                    for (ssize_t oc = 0; oc < OCOG; ++oc) {
                      //float &dst = pdst[dst_off0 + oc * OH_OW];
                      tmp[oc] += e.sum.scale * pdst[dst_off0 + oc * OH_OW];
                    }
                    break;
                  case pk::RELU:
                    for (ssize_t oc = 0; oc < OCOG; ++oc) {
                      tmp[oc] = e.eltwise.scale * (tmp[oc] > 0.f ? tmp[oc] : 0.f);
                    }
                    break;
                  default:
                    assert(!"unknown attr::post_ops::kind");
                }
              }
            }
            // final unpack of tmp[oc] into destination
            for (ssize_t oc = 0; oc < OCOG; ++oc) {
              pdst[dst_off0 + oc * OH_OW] = tmp[oc];
            }
          }
        }
      }
    }
  }
}

void sxconv_5_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
{
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
  int khb[IH];
  int khe[IH];
  int kwb[IW];
  int kwe[IW];

  int const DH = p->dh + 1;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  DMUST( khh == SH / gcd(SH,DH) );
  const int jhh = lcm_h / SH;
  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  DMUST( hg == gcd_h );

  int const DW = p->dw + 1;
  const int gcd_w = gcd( SW, DW );
  const int lcm_w = SW * DW/gcd_w;
  const int kww = lcm_w / DW;
  const int jww = lcm_w / SW;
  int wa, wb, wg;
  extendedEuclid( wa, DW, wb, SW, wg);
  DMUST( wg == gcd_w );

  const int OCOG = OC / G;
  const int ICOG = IC / G;
  const int OH_OW = OH * OW;
  const int ICOG_KH_KW = ICOG * KH * KW;

  for (int ih = 0; ih < IH; ++ih) {
    khe[ih] = (ih + PH) / DH + 1;
    if (khe[ih] > KH) khe[ih] = KH;
    khb[ih] = khe[ih];
    if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
      int kh_ibeg = khe[ih];
      int const mul = (ih+PH) / gcd_h;
      kh_ibeg = ha*mul;
      int m = div_floor(kh_ibeg, khh);
      kh_ibeg -= m * khh;
      int j = hb * mul + m * jhh; // var j --> 'm' again
      if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
      khb[ih] = kh_ibeg;
    }
  }
  for (int iw = 0; iw < IW; ++iw) {
    kwe[iw] = (iw + PW) / DW + 1;
    if (kwe[iw] > KW) kwe[iw] = KW;
    kwb[iw] = kwe[iw];
    if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
      int kw_ibeg = kwe[iw];
      int const mul = (iw+PW) / gcd_w;
      kw_ibeg = wa * mul;
      int m = div_floor(kw_ibeg, kww);
      kw_ibeg -= m * kww;
      int j = wb * mul + m * jww;
      if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
      kwb[iw] = kw_ibeg;
    }
  }

  OMP(parallel for collapse(5))//;
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = pdiff_src[src_off];
            ds = 0;

            int kh_beg = khb[ih];
            int kh_end = khe[ih];
            if( kh_beg >= kh_end ) continue;

            int kw_beg = kwb[iw];
            int kw_end = kwe[iw];
            if( kw_beg >= kw_end ) continue;

            int oh0=ih+PH - kh_beg*DH;
            size_t d_oc1h = dst_off_f(p, mb, g, 0, oh0/SH, 0);
            const size_t w_oc00 = wei_off_f(p, g, 0, ic, 0, 0);
            // using next line is maybe a wee bit slower
            //size_t w_oc1h = wei_off_f(p, g, 0, ic, kh_beg, 0);
            ShortLoop() for (int kh = kh_beg; kh < kh_end; kh += khh) {
              int ow0=iw+PW - kw_beg*DW;
              //size_t w_oc1h = w_oc1h0;
              //if(g==0&&mb==0&&ic==0) cout<<" kh="<<kh<<" oh0="<<oh0<<" (oh0/SH)*OW="<<(oh0/SH)*OW<<" jhh="<<jhh<<endl;

              ShortLoop() for (int kw = kw_beg; kw < kw_end; kw += kww) {
                //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
                //const size_t w_oc0 = wei_off_f(p, g, 0, ic, kh, kw);
                const size_t w_oc0 = w_oc00 + kh*KW + kw;
                //const size_t w_oc0b = w_oc1h + kw;
                //RT_ASSERT( w_oc0b == w_oc0 );
                const size_t d_oc0b = d_oc1h + ow0/SW;
                for (int oc = 0; oc < OC/G; ++oc) {
                  //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
                  //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  //ds += pdiff_dst[dst_off] * pwei[wei_off];
                  //ds += pdiff_dst[d_oc0 + oc*OH_OW] * pwei[w_oc0 + oc*ICOG_KH_KW];
                  ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0 + oc*ICOG_KH_KW];
                  //ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0b + oc*ICOG_KH_KW];
                }
                ow0 -= lcm_w;
              }
              oh0 -= lcm_h;
              d_oc1h -= jhh*OW; // jhh ~ lcm_h/SH
              //w_oc1h += khh*KW;
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
}

/** Special-case the non-dilation BWD_D code.
 * In this case, the postive integer conditional hoistings were
 * previously derived (ex. \ref ref_conv3.cpp).  They should agree
 * with \c sx_conv_5_fwd hoistings, specialized for DH=1 [DW=1],
 * but have been simplified a bit further.
 */
void sxconv_5_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
  // regr-dilate: 2.50x
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // FIXME can we call this even less?
    //refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    sxconv_5_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }
  float       * restrict const pdiff_src = (float*)diff_src_m;
  float const * restrict const pwei = (float*)wei_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
#define MAC 0
  // SX: MAC=0 ./regr.sh BWD_D 17.0x ---> MAC=1 10.55x; MAC=1+int 
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
  const ssize_t ICOG = IC/G;
  const ssize_t ICOG_KH_KW = ICOG * KH * KW;
  const ssize_t OCOG = OC / G;
  const ssize_t OH_OW = OH * OW;
#else
  const int G = p->g;
  const int MB = p->mb;
  const int IC = p->ic;
  const int IH = p->ih;
  const int IW = p->iw;
  const int OC = p->oc;
  const int OH = p->oh;
  const int OW = p->ow;
  const int KH = p->kh;
  const int KW = p->kw;
  const int PH = p->ph;
  const int PW = p->pw;
  const int SH = p->sh;
  const int SW = p->sw;
  const int DH = p->dh + 1;
  const int DW = p->dw + 1;
  const ssize_t ICOG = IC/G;
  const ssize_t ICOG_KH_KW = ICOG * KH * KW;
  const ssize_t OCOG = OC / G;
  const ssize_t OH_OW = OH * OW;
#endif
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
  OMP(parallel for collapse(4))//;
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t mb = 0; mb < MB; ++mb) {
      for (ssize_t ic = 0; ic < ICOG; ++ic) {
        for (ssize_t ih = 0; ih < IH; ++ih) {

          ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0);
          for (ssize_t iw = 0; iw < IW; ++iw) {

            const int kh_e = khe[ih];
            const int kw_e = kwe[iw];
            float tmp = 0.f;

            if( khb[ih] < kh_e && kwb[iw] < kw_e ) {
              const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + 0) * KW + 0;
              const ssize_t d0 = ((mb * OC + g * OCOG + 0) * OH + 0) * OW + 0;
              for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
                for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
                  //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
                  //const ssize_t dst_off0 = ((mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
                  const ssize_t wei_off0 = w0 + (ssize_t)((float)kh*KW+(float)kw);
                  const ssize_t dst_off0 = d0 + (ssize_t)((float)oh*OW+(float)ow);
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
}

/** This one simplifies the hoisting function much
 * like \c sxconv_5_fwd.
 *
 * - simplify:
 * 1. When is oh_beg >= 1?
 *   - (PH - kh*DH +SH-1) / SH >= 1
 *   - PH - kh*DH + SH-1 >= SH
 *   - PH - kh*DH - 1 >= 0
 *   - kh*DH <= PH -1
 *   - kh*DH < PH
 *   - In this case, we can set oh_beg=(PH - kh*DH +SH-1) / SH,
 *     - and it is OK if this value is > OH.
 * 2. When is oh_end >= OH?
 *   - (IH + PH - kh*DH + SH - 1) / SH >= OH
 *   - IH + PH - kh*DH + SH - 1 >= OH*SH
 *   - kh*DH + 1 <= IH+PH+SH - OH*SH
 *   - kh*DH + OH*SH < IH+PH+SH
 *   - In this case, we may set oh_end = OH,
 * 3. When is oh_end >= 1?
 *   - this is a bit simpler: OH-->1 in above...
 *   - kh*DH < IH+PH
 *   - If this is *not* the case, we can set oh_end=0
 *     - otherwise (IH + PH - kh*DH + SH - 1) / SH
 *       - (subject to oh_end <= OH)
 */
void sxconv_5_bwd_w(const prb_t *p, dnn_mem_t &src_m,
    dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
#if 1
  refconv_4_bwd_w(p, src_m, diff_wei_m, diff_bia_m, diff_dst_m);
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
  const ssize_t IH_IW = IH * IW;
  const ssize_t KH_KW = KH * KW;
  const ssize_t SH_IW = SH * IW;
  float const * restrict const psrc = (float*)src_m;
  float       * restrict const pdiff_wei = (float*)diff_wei_m;
  float       * restrict const pdiff_bia = (float*)diff_bia_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
#if 1
  // It is hard to measure any speed difference from modifying the bwd_w_bias_update
  auto bwd_w_bias_update = [&](const prb_t* p, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m){
    if ((p->dir & FLAG_BIA)) {
      for (int oc = 0; oc < OC     ; ++oc) {
        size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
        float &db = pdiff_bia[bia_off];
        db = 0.f;
        OMP(parallel for collapse(2) reduction(+:db))//;
        for (int mb = 0; mb < MB; ++mb) {
          for (int ohw = 0; ohw < OH*OW; ++ohw) {
            size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
            db += ((float*)diff_dst_m)[dst_off];
          }
        }
      }
    }
  };
#endif
  // 6 is a safe one
#define BW 6
  // SX BWD_WB tests
  // 6 3.34x
#if BW==0
  OMP(parallel)
  {
    OMP(for collapse(3))//;
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
    // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
    OMP(for collapse(4))//;
    for (ssize_t g = 0; g < G; ++g) {
      for (ssize_t oc = 0; oc < OCOG; ++oc) {
        //for (ssize_t ic = 0; ic < IC/G; ++ic)
          for (ssize_t kh = 0; kh < p->kh; ++kh) {
            for (ssize_t kw = 0; kw < KW; ++kw) {
              const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
              // SX TODO simplify these to positive-integer solutions !!!
              ssize_t oh_beg, oh_end;
              oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
              oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
              if (oh_beg < 0    ) oh_beg = 0;
              if (oh_end > OH) oh_end = OH;
#if 0 // establish non-negative equivalencies
              RT_ASSERT( (oh_beg >= 1) == (kh*DH < PH) );
              RT_ASSERT( (oh_end >= 1) == (kh*DH < IH+PH) );
              RT_ASSERT( (oh_end >= OH) == (kh*DH + OH*SH < IH+PH+SH) ); // ???
              size_t ohb2 = 0;
              if( kh*DH < PH ) ohb2 = ((PH-kh*DH) + SH-1)/ SH;
              RT_ASSERT( ohb2 == oh_beg );
              size_t ohe2 = 0;
              if( kh*DH < IH+PH ) {
                ohe2 = ((IH + PH - kh*DH) + SH-1) / SH;
                RT_ASSERT( ohe2 >= 1 );
              }
              if( ohe2 >= OH ) {
                ohe2 = OH;
                RT_ASSERT( (kh*DH + OH*SH < IH+PH+SH) );
              }
              // note: oh_end from div_floor and signed integer was allowed to be -ve
              RT_ASSERT( (oh_end<0 && ohe2==0) || (oh_end>=0 && ohe2==oh_end ) );
#endif
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
      OMP(for collapse(2) nowait)//;
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
#endif
#if BW==1
  // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
  OMP(parallel for collapse(4))//;
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t oc = 0; oc < OCOG; ++oc) {
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
          //if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
          //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
          const size_t ow_emb = ow_end - ow_beg;

          float dw_ic[ICOG];
          for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
          if (ow_beg < ow_end && oh_beg < oh_end) {
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
    OMP(for collapse(2) nowait)//;
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
#endif
#if BW==2
  // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
  OMP(parallel for collapse(4))//;
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t oc = 0; oc < OCOG; ++oc) {
      ShortLoop()for (ssize_t kh = 0; kh < p->kh; ++kh) {
        ShortLoop()for (ssize_t kw = 0; kw < KW; ++kw) {
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
          //if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
          //const size_t iw_beg = ow_beg * SW - PW + kw * DW;

          float dw_ic[ICOG];
          for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
          if (ow_beg < ow_end && oh_beg < oh_end) {
            ow_end -= ow_beg;
            oh_end -= oh_beg;
            const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
            const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW - PW + kw*DW;
            for (ssize_t ic = 0; ic < ICOG; ++ic) {
              float tmp = 0.f;
              for (ssize_t mb = 0; mb < MB; ++mb) {
                //const ssize_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
                const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
                //const ssize_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW - PW + kw*DW;
                const ssize_t src_off_beg = s00 + mb*IC*IH*IW + ic*IH*IW;
#if 1
                for (ssize_t oh = 0; oh < oh_end; ++oh) {
                  for (size_t ow = 0; ow < ow_end; ++ow) {
                    tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW];
                  }
                }
#elif 0
                if(oh_end < 256 && ow_end < 256){ // ShortLoop is faster, but speed destroyed by 'if'
                  ShortLoop()for (ssize_t oh = 0; oh < oh_end; ++oh) {
                    ShortLoop()for (size_t ow = 0; ow < ow_end; ++ow) {
                      tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW];
                    }
                  }
                }else{
                  for (ssize_t oh = 0; oh < oh_end; ++oh) {
                    for (size_t ow = 0; ow < ow_end; ++ow) {
                      tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW];
                    }
                  }
                }
#elif 0 // slower
                float s[oh_end*ow_end];
                float d[oh_end*ow_end];
                for (ssize_t oh = 0; oh < oh_end; ++oh) {
                  for (size_t ow = 0; ow < ow_end; ++ow) {
                    d[oh*ow_end+ow] = pdiff_dst[dst_off_beg + oh*OW + ow];
                    s[oh*ow_end+ow] = psrc[src_off_beg + oh*SH_IW + ow*SW];
                  }
                }
                for (ssize_t o = 0; o < ow_end*oh_end; ++o) {
                  tmp += d[o] * s[o];
                }
#elif 0 // very slow
                float s[OH][OW], d[OH][OW];
                for (ssize_t oh = 0; oh < OH; ++oh) {
                  for (size_t ow = 0; ow < OW; ++ow) {
                    d[oh][ow] = (oh<oh_end && ow<ow_end ? pdiff_dst[dst_off_beg + oh*OW + ow]: 0.f);
                    s[oh][ow] = (oh<oh_end && ow<ow_end ? psrc[src_off_beg + oh*SH_IW + ow*SW]: 0.f);
                  }
                }
                for (ssize_t oh = 0; oh < OH; ++oh)
                  for (size_t ow = 0; ow < OW; ++ow)
                    tmp += d[oh][ow] * s[oh][ow];
#endif
              }
              dw_ic[ic] = tmp;
            }
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
    OMP(for collapse(2) nowait)//;
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
#endif
#if BW==3
  // loop order change, much better 24x for regr.sh BWD_WB
  // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
  OMP(parallel for collapse(4))//;
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t oc = 0; oc < OCOG; ++oc) {
      ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
        ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
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
          float dw_ic[ICOG];
          for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
          if (ow_beg < ow_end && oh_beg < oh_end) {
            ow_end -= ow_beg;
            oh_end -= oh_beg;
            const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
            const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW - PW + kw*DW;
            for (ssize_t mb = 0; mb < MB; ++mb) {
              const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
              const ssize_t s0 = s00 + mb*IC*IH*IW;
              for (ssize_t oh = 0; oh < oh_end; ++oh) {
                for (size_t ow = 0; ow < ow_end; ++ow) {
                  for (ssize_t ic = 0; ic < ICOG; ++ic) {
                    dw_ic[ic] += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW];
                  }
                }
              }
            }
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
    OMP(for collapse(2) nowait)//;
    for (ssize_t g = 0; g < G; ++g) {
      for (ssize_t oc = 0; oc < OCOG; ++oc) {
        const ssize_t bia_off = bia_off_f(p, g, oc);
        pdiff_bia[bia_off] = 0.f;
        const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
        for (ssize_t mb = 0; mb < MB; ++mb) {
          //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
          for (ssize_t oh = 0; oh < OH; ++oh) {
            for (ssize_t ow = 0; ow < OW; ++ow) {
              //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
              pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
            }
          }
        }
      }
    }
  }
#endif
#if BW==5// loop order change, much better 24x for regr.sh BWD_WB
  // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
  OMP(parallel for collapse(4))//;
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t oc = 0; oc < OCOG; ++oc) {
      ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
        ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
          const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
          typedef int hoist_t; /*but it could even be unsigned int, now*/
#if 1 // SX 24.5x BWD_WB regr.sh
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
          //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
#elif 0 // SX 24.3x
          // equiv, but OK for unsigned hoist_t and "normal" division op
          typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
          hoist_t oh_beg = 0, oh_end=0;
          if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
          if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
          if( oh_end >= OH ) oh_end = OH;
          hoist_t ow_beg = 0, ow_end=0;
          if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
          if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
          if( ow_end >= OW ) ow_end = OW;
#elif 1 // SX 24.1x
          const ssize_t oh_beg = ( kh*DH < PH ? ((PH-kh*DH) + SH-1)/ SH : 0 );
          ssize_t oh_end = ( kh*DH < IH+PH ? ((IH + PH - kh*DH) + SH-1) / SH : 0 );
          if( oh_end >= OH ) oh_end = OH;
          const ssize_t ow_beg = ( kw*DW < PW ? ((PW-kw*DW) + SW-1)/ SW : 0 );
          ssize_t ow_end = ( kw*DW < IW+PW ? ((IW + PW - kw*DW) + SW-1) / SW : 0 );
          if( ow_end >= OW ) ow_end = OW;
#endif
          float dw_ic[ICOG];
          RETAIN(dw_ic)ShortLoopTest()for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
          if (ow_beg < ow_end && oh_beg < oh_end) {
            ow_end -= ow_beg;
            oh_end -= oh_beg;
            const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
            const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW - PW + kw*DW;
            for (ssize_t mb = 0; mb < MB; ++mb) {
              const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
              const ssize_t s0 = s00 + mb*IC*IH*IW;
              for (ssize_t oh = 0; oh < oh_end; ++oh) {
                for (size_t ow = 0; ow < ow_end; ++ow) {
                  RETAIN(dw_ic)for (ssize_t ic = 0; ic < ICOG; ++ic) {
                    dw_ic[ic] += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW];
                  }
                }
              }
            }
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
    OMP(for collapse(2) nowait)//;
    for (ssize_t g = 0; g < G; ++g) {
      for (ssize_t oc = 0; oc < OCOG; ++oc) {
        const ssize_t bia_off = bia_off_f(p, g, oc);
        pdiff_bia[bia_off] = 0.f;
        const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
        for (ssize_t mb = 0; mb < MB; ++mb) {
          //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
          for (ssize_t oh = 0; oh < OH; ++oh) {
            for (ssize_t ow = 0; ow < OW; ++ow) {
              //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
              pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
            }
          }
        }
      }
    }
  }
#endif
#if BW==6 // from ref_conv4
  int ohb[KH], ohe[KH], owb[KW], owe[KW], ook[KH_KW];
  for(int kh=0; kh<KW; ++kh){
    int oh_beg, oh_end;
    oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
    oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
    if (oh_beg < 0    ) oh_beg = 0;
    if (oh_end > OH) oh_end = OH;
    ohb[kh] = oh_beg;
    ohe[kh] = oh_end;
  }
  for(int kw=0; kw<KW; ++kw){
    int ow_beg, ow_end;
    ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
    ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
    if (ow_beg < 0    ) ow_beg = 0;
    if (ow_end > OW) ow_end = OW;
    owb[kw] = ow_beg;
    owe[kw] = ow_end;
  }
  for (int kh = 0; kh < KH; ++kh) {
    for (int kw = 0; kw < KW; ++kw) {
      ook[kh*KW+kw] = (ohb[kh] < ohe[kh] && owb[kw] < owe[kw]);
    }
  }
#if 0
#define PREZERO 1
#if PREZERO
#if 0
  OMP(for collapse(3))//;
  for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t oc = 0; oc < OCOG; ++oc) {
      for (ssize_t ic = 0; ic < ICOG; ++ic) {
        const ssize_t wei_off00 = (((g * OCOG + oc) * ICOG + ic) * KH + 0) * KW + 0;
        for (ssize_t kh = 0; kh < KH; ++kh) {
          for (ssize_t kw = 0; kw < KW; ++kw) {
            pdiff_wei[wei_off00 + kh*KW + kw] = 0.f;
          }
        }
      }
    }
  }
#else
  zero_wei(p, diff_wei_m);
#endif
#endif
#if 1
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
#else
  if ((p->dir & FLAG_BIA)) {
    OMP(for collapse(2) nowait)//;
    for (ssize_t g = 0; g < G; ++g) {
      for (ssize_t oc = 0; oc < OCOG; ++oc) {
        ssize_t bia_off = bia_off_f2(p, g, oc);
        //float &db = pdiff_bia[bia_off];
        pdiff_bia[bia_off] = 0.f;
        for (ssize_t mb = 0; mb < MB; ++mb) {
          const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
          for (ssize_t oh = 0; oh < OH; ++oh) {
            for (ssize_t ow = 0; ow < OW; ++ow) {
              pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
            }
          }
        }
      }
    }
  }
#endif
#endif
#define TMP_IC 0
#if TMP_IC==0
  zero_wei(p, diff_wei_m);
#endif
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
  //for (int mb = 0; mb < MB; ++mb) // <------ XXX WRONG position. not omp-safe
  OMP(parallel)
  {
    OMP(for collapse(4))//;
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
#if 0
            int oh_beg, oh_end;
            oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
            oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
            if (oh_beg < 0    ) oh_beg = 0;
            if (oh_end > OH) oh_end = OH;
            RT_ASSERT( oh_beg == ohb[kh] );
            RT_ASSERT( oh_end == ohe[kh] );
            int ow_beg, ow_end;
            ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
            ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
            if (ow_beg < 0    ) ow_beg = 0;
            if (ow_end > OW) ow_end = OW;
            RT_ASSERT( ow_beg == owb[kw] );
            RT_ASSERT( ow_end == owe[kw] );
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
#else
            if( !ook[kh*KW+kw] ) continue;
            const int oh_beg = ohb[kh];
            const int oh_end = ohe[kh];
            const int ow_beg = owb[kw];
            const int ow_end = owe[kw];
#endif
            //if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0

            const int iw0 = - PW + kw * (p->dw+1);
            const int ih0 = - PH + kh * (p->dh + 1);
#if TMP_IC
            float tmp[ICOG];
            for (int ic = 0; ic < IC/G; ++ic) tmp[ic] = 0.f; // MUST always execute!
#endif
            RETAIN(tmp)//;
              for (int mb = 0; mb < MB; ++mb) // OK inside
              {
                size_t d_00 = dst_off_f(p, mb, g, oc, 0, 0);
            for (int ic = 0; ic < IC/G; ++ic) { // B
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
              float &dw = pdiff_wei[wei_off];
              //dw = 0.f; // 2.2x --> 2.0x
                size_t s_00 = src_off_f(p, mb, g, ic, 0, 0) + iw0;
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  //const int ih = ih0 + oh * SH; // - PH + kh * (p->dh + 1);
                  //const int s0h = s_00 + ih*IW;
                  const int s0h = s_00 + (ih0 + oh * SH) * IW;
                  const int d0h = d_00 + oh*OW;
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    //const size_t dst_off = d_00 + oh*OW + ow;
                    //const size_t dst_off = d0h + ow;
                    //const int iw = iw0 + ow * SW; // - PW + kw * (p->dw + 1);
                    //const int iw = ow * SW; // - PW + kw * (p->dw + 1);
                    //size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    //size_t src_off = s_00 + ih*IW+iw;
                    //size_t src_off = s0h + ow*SW;
//#if TMP_IC
//                    tmp[ic] += pdiff_dst[dst_off] * psrc[src_off];
//#else
//                    dw += pdiff_dst[dst_off] * psrc[src_off];
//#endif
#if TMP_IC
                    tmp[ic] += pdiff_dst[d0h + ow] * psrc[s0h + ow*SW];
#else
                    dw += pdiff_dst[d0h + ow] * psrc[s0h + ow*SW];
#endif
                  }
                }
              }
            }
#if TMP_IC
            size_t wei_off = wei_off_f2(p, g, oc, 0, kh, kw); // WRITTEN
            for (int ic = 0; ic < ICOG; ++ic) { // B
              pdiff_wei[wei_off + ic*KH_KW] = tmp[ic];
            }
#endif
          }
        }
      }
    }
  }
#endif
#if BW==7 // from ref_conv4 XXX NOT OMP-SAFE XXX ???
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
  for (int mb = 0; mb < MB; ++mb) // <---- wrong ???
  {
    OMP(parallel for collapse(4))//;
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            int oh_beg, oh_end;
            oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
            oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
            if (oh_beg < 0    ) oh_beg = 0;
            if (oh_end > OH) oh_end = OH;
            int ow_beg, ow_end;
            ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
            ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
            if (ow_beg < 0    ) ow_beg = 0;
            if (ow_end > OW) ow_end = OW;
#if TMP_IC
            if( oh_beg < oh_end || ow_beg < ow_end )
#else
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
            else
#endif
            {
#if TMP_IC
              float tmp[ICOG];
              for (int ic = 0; ic < IC/G; ++ic) tmp[ic] = 0.f; // MUST always execute!
#endif

              for (int ic = 0; ic < IC/G; ++ic) { // B
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                float &dw = pdiff_wei[wei_off];
                //dw = 0.f; // 2.2x --> 2.0x
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
#if TMP_IC
                    tmp[ic] += pdiff_dst[dst_off] * psrc[src_off];
#else
                    dw += pdiff_dst[dst_off] * psrc[src_off];
#endif
                  }
                }
              }
            }
#if TMP_IC
            size_t wei_off = wei_off_f2(p, g, oc, 0, kh, kw); // WRITTEN
            for (int ic = 0; ic < ICOG; ++ic) { // B
              pdiff_wei[wei_off + ic*KH_KW] = tmp[ic];
            }
#endif
          }
        }
      }
    }
  }
#endif
#endif
}

#if 0
#elif 0
              for (int ic = 0; ic < IC/G; ++ic) { // B
                //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                //float &dw = ((float*)diff_wei_m)[wei_off];
                //dw = 0.f; // 2.2x --> 2.0x
                float tmp = 0.f;
#if 1 // a1/a3 1.50,1.15
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    tmp += pdiff_dst[dst_off] * psrc[src_off];
                  }
                }
#elif 0
                for (size_t oh = oh_beg; oh < oh_end; ++oh) {
                  const size_t ih = oh * SH - PH + kh * (p->dh + 1);
                  for (size_t ow = ow_beg; ow < ow_end; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    const size_t iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    tmp += pdiff_dst[dst_off] * psrc[src_off];
                  }
                }
#elif 1
                for (size_t oh = oh_beg, ih=ih_beg; oh < oh_end; ih+=SH, ++oh) {
                  //const size_t ih = oh * SH - PH + kh * (p->dh + 1);
                  for (size_t ow = ow_beg, iw=iw_beg; ow < ow_end; iw+=SW, ++ow) {
                    size_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
                    size_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
                    tmp += pdiff_dst[dst_off] * psrc[src_off];
                  }
                }
#endif
                size_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw); // WRITTEN
                pdiff_wei[wei_off] = tmp;
              }
#elif 0 // a1,a3 1.4,1.1
              for (int ic = 0; ic < IC/G; ++ic) { // B
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                float &dw = ((float*)diff_wei_m)[wei_off];
                //dw = 0.f; // 2.2x --> 2.0x
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    dw += ((float*)diff_dst_m)[dst_off]
                      * ((float*)src_m)[src_off];
                  }
                }
              }
#elif 0 // 1.3,3.3
              for (int ic = 0; ic < ICOG; ++ic) { // B
                tmp[ic] = 0.f;
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * SH - PH + kh * DH;
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    size_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
                    const int iw = ow * SW - PW + kw * DW;
                    size_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
                    //dw += ((float*)diff_dst_m)[dst_off] * ((float*)src_m)[src_off];
                    tmp[ic] += pdiff_dst[dst_off] * psrc[src_off];
                  }
                }
              }
              size_t wei_off = wei_off_f2(p, g, oc, 0, kh, kw); // WRITTEN
              for (int ic = 0; ic < ICOG; ++ic) { // B
                pdiff_wei[wei_off + ic] = tmp[ic];
              }
#elif 0 // 1.3,3.3
              float tmp[ICOG];
              for (int ic = 0; ic < ICOG; ++ic) { // B
                tmp[ic] = 0.f;
                for (int oh = oh_beg, ih=ih_beg; oh < oh_end; ih+=SH, ++oh) {
                  for (int ow = ow_beg, iw=iw_beg; ow < ow_end; iw+=SW, ++ow) {
                    size_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
                    size_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
                    //dw += ((float*)diff_dst_m)[dst_off] * ((float*)src_m)[src_off];
                    tmp[ic] += pdiff_dst[dst_off] * psrc[src_off];
                  }
                }
              }
#endif
}
#endif // defined(__ve)
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0\:0N-s
