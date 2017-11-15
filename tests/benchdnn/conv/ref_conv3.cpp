/*******************************************************************************
* Copyright 2017 Intel Corporation
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
  MUST( p->kh > 0 && p->kw > 0 );
  MUST( p->dh >= 0 && p->dw >= 0 );
  MUST( p->sh >= 0 && p->sw >= 0 );

#if 0 // original hoist, regr 4.72x
  auto ker = [](
      const prb_t *p, dnn_mem_t &src_m, dnn_mem_t &wei_m,
      float &d, const int g, const int mb, const int oc, const int oh, const int ow
      , const int kh_beg, const int kh_end, const int kw_beg, const int kw_end
      ) {
    for (int ic = 0; ic < p->ic/p->g; ++ic) {
      for (int kh = kh_beg; kh < kh_end; ++kh)
      {
        const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
        for (int kw = kw_beg; kw < kw_end; ++kw) {
          const int iw = ow * p->sw - p->pw + kw * (p->dw + 1); // loop vars: ow, kw
          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
        }
      }
    }
  };

  // writes go to  dst_off_f(p, mb, g, oc, oh, ow);
#   pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int oh = 0; oh < p->oh; ++oh) {
          for (int ow = 0; ow < p->ow; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            size_t bia_off = bia_off_f(p, g, oc);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0;
            int kh_beg, kh_end, kw_beg, kw_end;
            hoist_ApiB_in( kh_beg, kh_end,
                /*i  in   */ 0, p->kh,
                /*ih=A+iB */ (oh * p->sh - p->ph), (p->dh + 1),
                /*ih in   */ 0, p->ih);
            hoist_ApiB_in( kw_beg, kw_end,
                /*i  in   */ 0, p->kw,
                /*iw=A+iB */ (ow * p->sw - p->pw), (p->dw + 1),
                /*iw in   */ 0, p->iw);
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
#   pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int oh = 0; oh < p->oh; ++oh) {
          for (int ow = 0; ow < p->ow; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            size_t bia_off = bia_off_f(p, g, oc);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0.f;
            int kh_beg, kh_end, kw_beg, kw_end;

            kh_beg = div_floor( 0     - (oh * p->sh - p->ph) + p->dh, (p->dh+1) );
            kh_end = div_floor( p->ih - (oh * p->sh - p->ph) + p->dh, (p->dh+1) );
            if( kh_beg < 0     ) kh_beg = 0;
            if( kh_end > p->kh ) kh_end = p->kh;

            kw_beg = div_floor( 0     - (ow * p->sw - p->pw) + p->dw, (p->dw+1) );
            kw_end = div_floor( p->iw - (ow * p->sw - p->pw) + p->dw, (p->dw+1) );
            if( kw_beg < 0     ) kw_beg = 0;
            if( kw_end > p->kw ) kw_end = p->kw;

            if( kw_beg < kw_end && kh_beg < kh_end ) {

              for (int ic = 0; ic < p->ic/p->g; ++ic) {
                for (int kh = kh_beg; kh < kh_end; ++kh)
                {
                  const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                  for (int kw = kw_beg; kw < kw_end; ++kw) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
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

/** inline the kernel.  regr 4.31x musek(avx) 4.91x */
static void refconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
{
  const int lcm_w = lcm( p->sw, p->dw+1 );
  const int lcm_h = lcm( p->sh, p->dh+1 );
  const int DH = p->dh+1;
  const int SH = p->sh;
  const int PH = p->ph;
  const int OH = p->oh;
  const int DW = p->dw+1;
  const int SW = p->sw;
  const int PW = p->pw;
  const int OW = p->ow;
  //int const khh = SH; // only for DH==1 !!!
  int const khh = 1; // safe (if check conditions)
  int const kww = 1; // safe (if check conditions)
  //int const khh = lcm_h / SH;
  //int const kww = lcm_w / PW;
#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          hoist_AmiB_in( kh_beg, kh_end,
              /*kh  in   */ 0, p->kh,
              /*oh=A+khB */ (ih + PH), DH,
              /*oh in   */ 0, OH*SH );
          int const khb0 = kh_beg;
          { // jump kh_beg up to 1st non-skipped index
            // 
            int ohsh = ih+PH - kh_beg * DH; // must always be a mult of SH
            int rem_beg = ohsh % SH;
            if (rem_beg){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                ohsh = ih+PH - kh_beg * DH;
              } while( ohsh % SH != 0 && kh_beg < kh_end );
            }
            int oh_beg = ohsh / SH;
          }
          // problem: Find the lowest khb >= kh_beg such that
          //          osh = ih+PH - khb*DH
          //      AND osh % SH == 0.
          //          Then oh_beg = osh / SH;
          //
          // Alt: Let osh0 = (ih+PH - khb0 * DH)
          //      and ohb0 = osh/SH.
          //      Find the highest osh <= osh0 such that
          //      osh % SH == 0
          //  AND (ih+PH - osh) % DH = 0.
          //      Then kh_beg = (ih+PH - osh) / DH
          //       and oh_beg = osh / SH;
          //
          //
          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            hoist_AmiB_in( kw_beg, kw_end,
                /*i  in   */ 0, p->kw,
                /*ow=A+iB */ (iw + PW), DW,
                /*ow in   */ 0, OW*SW );
            { // jump kw_beg up to 1st non-skipped index
              int owsw = iw+PW - kw_beg * DW;
              int rem_beg = owsw % SW;
              if (rem_beg){
                do {
                  ++kw_beg;
                  owsw = iw+PW - kw_beg * DW;
                } while( owsw % SW != 0 && kw_beg < kw_end );
                //print(0, " ... kw_beg --> %d, ow_beg --> %d\n", kw_beg, ow_beg);
                DMUST( (kw_beg >= kw_end || (iw+PW - kw_beg * DW) % SW == 0) );
                int ow_beg = owsw / SW;
              }
            }
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            if( TRIVIAL(kh_beg >= kh_end || kw_beg >= kw_end) ){
              ; //DPRINTF("t");
            } else {
              //
              // 3 nested loops, with NO conditional tests
              //
              //DPRINTF(".");
              //bool const s0 = kh_beg >= kh_end || SH <= 1; // this IMPLIES skips remains 0
              // next: loop over allowed oh values, THEN over kh
              for (int kh = kh_beg; kh < kh_end; kh += khh) {
                int oh0 = ih+PH - kh * DH ; // loop vars: kh, ih
                if( oh0<0 || oh0%SH ) continue;
                int oh = oh0 / SH;
                ///const int oh = (ih+PH - kh * DH) / SH;

                for (int kw = kw_beg; kw < kw_end; kw += kww) {
                  int ow0 = iw+PW - kw * DW; // loop vars: iw, kw
                  if ( ow0<0 || ow0%SW ) continue;
                  int ow = ow0 / SW;
                  ///const int ow = (iw+PW - kw * DW) / SW;

                  for (int oc = 0; oc < p->oc/p->g; ++oc) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
  }
}
void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
    dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {

#if 1
    refconv_3_bwd_d_generic( p, diff_src_m, wei_m, diff_dst_m );

#elif 0 // regr 4.07x 4.17x
#if 1 // the stride calc for dilation is VERY tricky!
  if (p->dh != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
  }
#endif

  // [ejk] this is slightly wrong for dilation ( XXX CHECKME )
  // XXX TODO inline the kernel and play with loop ordering
  auto ker = [](
      const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &wei_m,
      float &ds, int g, int mb, int ic, int ih, int iw
      , const int kh_beg, const int kh_end
      , const int kw_beg, const int kw_end
      ) {
    RT_ASSERT(p->sh > 0);
    //bool const s0 = kh_beg >= kh_end || p->sh <= 1; // this IMPLIES skips remains 0
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      // next: loop over allowed oh values, THEN over kh
      //int const khh = p->sh; // only for p->dh==0 !!!
      for (int kh = kh_beg; kh < kh_end; kh+=p->sh) { /// XXX increment maybe gcm(sh,dh+1) ?
        int oh = ih+p->ph - kh /* * (p->dh + 1) */; // loop vars: kh, ih
        oh /= p->sh;

        int const kww = p->sw; // perhaps lcd of p-sh and p->dh+1 ? XXX
        for (int kw = kw_beg; kw < kw_end; kw += kww) {
          int ow = iw - kw * (p->dw + 1) + p->pw; // loop vars: iw, kw
          //if (ow < 0 || ow % p->sw) continue;
          ow /= p->sw;
          //if (ow >= p->ow) continue;

          size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          ds += ((float*)diff_dst_m)[dst_off]
            * ((float*)wei_m)[wei_off];
        }
      }
    }
  };

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          hoist_AmiB_in( kh_beg, kh_end,
              /*i  in   */ 0, p->kh,
              /*oh=A+iB */ (ih + p->ph), (p->dh+1),
              /*oh in   */ 0, p->oh*p->sh );
          { // jump kh_beg up to 1st non-skipped index
            int oh_beg = ih+p->ph - kh_beg * (p->dh+1);
            int rem_beg = oh_beg % p->sh;
            if (rem_beg){
              // XXX closed-form formula ???  (should be easy now that know p->dh==0)
              // ref_conv4 has a strictly correct similar corrective example
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg * (p->dh+1);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
              //print(0, " ... kh_beg --> %d, oh_beg --> %d\n", kh_beg, oh_beg);
              DMUST( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
            }
          }
          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            hoist_AmiB_in( kw_beg, kw_end,
                /*i  in   */ 0, p->kw,
                /*ow=A+iB */ (iw + p->pw), (p->dw+1),
                /*ow in   */ 0, p->ow*p->sw );
            { // jump kw_beg up to 1st non-skipped index
              //int iwpw = iw + p->pw;
              // XXX still have the modulus in the loop...
              int ow_beg = iw+p->pw - kw_beg * (p->dw+1);
              int rem_beg = ow_beg % p->sw;
              if (rem_beg){
                // XXX closed-form formula ???  (should be easy now that know p->dw==0)
                // XXX see ref_conv3.cpp skips counter for hints about how.
                do {
                  ++kw_beg;
                  ow_beg = iw+p->pw - kw_beg * (p->dw+1);
                } while( ow_beg % p->sw != 0 && kw_beg < kw_end );
                //print(0, " ... kw_beg --> %d, ow_beg --> %d\n", kw_beg, ow_beg);
                DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
              }
            }
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            if( TRIVIAL(kh_beg >= kh_end || kw_beg >= kw_end) ){
              DPRINTF("t");
            } else {
              DPRINTF(".");
              ker( p, diff_dst_m, wei_m,
                  ds, g, mb, ic, ih, iw
                  , kh_beg, kh_end, kw_beg, kw_end
                 );
            }
          }
        }
      }
    }
  }
#elif 0
  //  MOVED to separate routine
  refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
  //
#elif 0 // specialize to p->dh, p->dw == 0
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          //hoist_AmiB_in( kh_beg, kh_end,
          //    /*kh  in   */ 0, p->kh,
          //    /*oh=A+khB */ (ih + p->ph), (p->dh+1),
          //    /*oh in   */ 0, p->oh*p->sh );
          //kh_beg = div_floor( (ih + p->ph) - p->oh*p->sh, (p->dh+1) ) + 1;
          //kh_end = div_floor( (ih + p->ph) - 0          , (p->dh+1) ) + 1;
          kh_beg =            (ih + p->ph) - p->oh*p->sh              + 1;
          kh_end =            (ih + p->ph) - 0                        + 1;
          if (kh_beg < 0    ) kh_beg = 0;
          if (kh_end > p->kh) kh_end = p->kh;
          int oh_beg;
          { // jump kh_beg up to 1st non-skipped index
            //int oh_beg = ih+p->ph - kh_beg * (p->dh+1); // must always be a mult of p->sh
            oh_beg = ih+p->ph - kh_beg; // must always be a mult of p->sh
            RT_ASSERT( oh_beg >= 0 );
            //if (kh_beg<kh_end)
                RT_ASSERT(oh_beg/p->sh <  p->oh);
            //NO RT_ASSERT( oh_beg % p->sh == (ih+p->ph) % p->sh );
            if ((oh_beg % p->sh)){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg /* * (p->dh+1) */;
                RT_ASSERT( oh_beg >= 0 );
                //if (kh_beg<kh_end)
                    RT_ASSERT(oh_beg/p->sh <  p->oh);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
            }
            oh_beg /= p->sh;
          }
          //int khb2 = div_floor(ih + p->ph + 1 , p->sh) - p->oh;
          //if (khb2 < 0) khb2 = 0;
          //int khb2s = khb2 * p->sh;
          //RT_ASSERT( khb2s <= kh_beg && khb2s % p->sh == 0 );
          int khb2 = ih+p->ph + 1 - p->oh*p->sh;
          if (khb2 < 0) khb2 = 0;
          int khb2s = (khb2+p->sh-1)/p->sh *p->sh;
          int ohb2 = ih+p->ph - khb2s;
          RT_ASSERT( ohb2 >= 0 );
          //if (ohb2 < 0) ohb2 = 0;
          ohb2 = ohb2 / p->sh;
          int ohb2s = ohb2 * p->sh;
          if ( ohb2 != oh_beg )
          {
              printf("ohb2: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                      ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
              exit(0);
          }
          //const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;
          // --->  kh = ih+p->ph - oh*p->sh;
          khb2 = ih+p->ph  - (ohb2) * p->sh;
          if (khb2 < 0) khb2 = 0;
          khb2s = khb2/p->sh * p->sh;
          //RT_ASSERT( khb2 == khb2s );
          //if ( kh_beg < kh_end && khb2 != kh_beg )
          if ( khb2 != kh_beg )
          {
              printf("khb2s: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                      ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
              exit(0);
          }

          //  oh_beg = (ih+p->ph - kh_beg)/p->sh ~  (ih+p->ph -  ((ih+p->ph) - p->oh*p->sh + 1))/p->sh
          //             = (p->oh * p->sh + 1)/p->sh ???
          //int ohb2 = (p->oh * p->sh + 1) / p->sh;
          //int khb2 = (ih+p->ph)/p->sh - ohb2s;
          //if (khb2 < 0) khb2 = 0;
          //int khb2s = khb2 * p->sh;
          //int ohb2s = ((ih+p->ph) - khb2s) / p->sh;
          //
          //int ohb2 = div_floor(p->oh + p->sh - 1, p->sh);
          //if( ohb2 < 0 ) ohb2 = 0;
          //int ohb2s = ohb2 * p->sh;
          //int ohb2 = p->oh*p->sh;
          //printf(" oh_beg=%d ohb2=%d ohb2s=%d\n",oh_beg,ohb2, ohb2s);
          //RT_ASSERT( ohb2s == oh_beg );
          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            //hoist_AmiB_in( kw_beg, kw_end,
            //    /*i  in   */ 0, p->kw,
            //    /*ow=A+iB */ (iw + p->pw), (p->dw+1),
            //    /*ow in   */ 0, p->ow*p->sw );
            kw_beg =            (iw + p->pw) - p->ow*p->sw              + 1;
            kw_end =            (iw + p->pw) - 0                        + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            if (kw_end > p->kw) kw_end = p->kw;
            { // jump kw_beg up to 1st non-skipped index
              int ow_beg = iw+p->pw - kw_beg /* * (p->dw+1) */;
              if ((ow_beg % p->sw)){
                do {
                  ++kw_beg;
                  ow_beg = iw+p->pw - kw_beg /* * (p->dw+1) */;
                } while( ow_beg % p->sw != 0 && kw_beg < kw_end );
                //print(0, " ... kw_beg --> %d, ow_beg --> %d\n", kw_beg, ow_beg);
                DMUST( (kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0) );
              }
            }
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            if( TRIVIAL(kh_beg >= kh_end || kw_beg >= kw_end) ){
              ; //DPRINTF("t");
            } else {
              //DPRINTF(".");
              //bool const s0 = kh_beg >= kh_end || p->sh <= 1; // this IMPLIES skips remains 0
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                // next: loop over allowed oh values, THEN over kh
                //int const khh = p->sh; // only for p->dh==0 !!!
                for (int kh = kh_beg; kh < kh_end; kh+=p->sh) {
                  //int oh = ih+p->ph - kh * (p->dh + 1) ; // loop vars: kh, ih
                  //oh /= p->sh;
                  const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;

                  //int const kww = p->sw; // perhaps lcd of p-sh and p->dh+1 ? XXX
                  for (int kw = kw_beg; kw < kw_end; kw += p->sw) {
                    //int ow = iw+p->pw - kw * (p->dw + 1); // loop vars: iw, kw
                    ////if (ow < 0 || ow % p->sw) continue;
                    //ow /= p->sw;
                    ////if (ow >= p->ow) continue;
                    const int ow = (iw+p->pw - kw /* * (p->dw + 1) */) / p->sw;

                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
  }
#elif 0 // specialize to p->dh, p->dw == 0
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          //hoist_AmiB_in( kh_beg, kh_end,
          //    /*kh  in   */ 0, p->kh,
          //    /*oh=A+khB */ (ih + p->ph), (p->dh+1),
          //    /*oh in   */ 0, p->oh*p->sh );
          //kh_beg = div_floor( (ih + p->ph) - p->oh*p->sh, (p->dh+1) ) + 1;
          //kh_end = div_floor( (ih + p->ph) - 0          , (p->dh+1) ) + 1;
          // REPL kh_beg =            (ih + p->ph) - p->oh*p->sh              + 1;
          kh_end =            (ih + p->ph) - 0                        + 1;
          // REPL if (kh_beg < 0    ) kh_beg = 0;
          if (kh_end > p->kh) kh_end = p->kh;
#if 0 // first correct non-loop calc ...
          int oh_beg;
          { // jump kh_beg up to 1st non-skipped index
            //int oh_beg = ih+p->ph - kh_beg * (p->dh+1); // must always be a mult of p->sh
            oh_beg = ih+p->ph - kh_beg; // must always be a mult of p->sh
            RT_ASSERT( oh_beg >= 0 );
            //if (kh_beg<kh_end)
                RT_ASSERT(oh_beg/p->sh <  p->oh);
            //NO RT_ASSERT( oh_beg % p->sh == (ih+p->ph) % p->sh );
            if ((oh_beg % p->sh)){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg /* * (p->dh+1) */;
                RT_ASSERT( oh_beg >= 0 );
                //if (kh_beg<kh_end)
                    RT_ASSERT(oh_beg/p->sh <  p->oh);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
            }
            oh_beg /= p->sh;
          }
          //int khb2 = div_floor(ih + p->ph + 1 , p->sh) - p->oh;
          //if (khb2 < 0) khb2 = 0;
          //int khb2s = khb2 * p->sh;
          //RT_ASSERT( khb2s <= kh_beg && khb2s % p->sh == 0 );
          int khb2 = ih+p->ph + 1 - p->oh*p->sh;
          if (khb2 < 0) khb2 = 0;
          int khb2s = (khb2+p->sh-1)/p->sh *p->sh;
          int ohb2 = ih+p->ph - khb2s;
          RT_ASSERT( ohb2 >= 0 );
          //if (ohb2 < 0) ohb2 = 0;
          ohb2 = ohb2 / p->sh;
          int ohb2s = ohb2 * p->sh;
          if ( ohb2 != oh_beg )
          {
              printf("ohb2: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                      ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
              exit(0);
          }
          //const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;
          // --->  kh = ih+p->ph - oh*p->sh;
          khb2 = ih+p->ph  - (ohb2) * p->sh;
          if (khb2 < 0) khb2 = 0;
          khb2s = khb2/p->sh * p->sh;
          //RT_ASSERT( khb2 == khb2s );
          //if ( kh_beg < kh_end && khb2 != kh_beg )
          if ( khb2 != kh_beg )
          {
              printf("khb2s: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                      ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
              exit(0);
          }
#elif 0 // simplifications...
          {
            int khb2s = (kh_beg+p->sh-1)/p->sh *p->sh; // round kh_beg up to mult of p->sh
            int khbbb = ((ih+p->ph+p->sh)/p->sh - p->oh) * p->sh;
            if (khbbb < 0) khbbb = 0;
            RT_ASSERT( khbbb == khb2s );
            int ohb2 = (ih+p->ph - khb2s) / p->sh;
            //int ohb2x = (ih+p->ph)/p->sh - ((kh_beg+p->sh-1)/p->sh);
            //int ohb2x = (ih+p->ph)/p->sh - (khbbb/p->sh);
              //int khccc = ((ih+p->ph + p->sh)/p->sh - p->oh);
              int khccc = ((ih+p->ph)/p->sh + 1 - p->oh);
              if (khccc < 0) khccc = 0;
              int ohb2x = (ih+p->ph)/p->sh - (khccc);
            RT_ASSERT( ohb2x == ohb2 );
            //kh_beg = ih+p->ph  - ohb2 * p->sh;
            //kh_beg = ih+p->ph  -  (ih+p->ph)/p->sh*p->sh + khccc*p->sh;
            //kh_beg = khccc*p->sh + ((ih+p->ph)%p->sh);
            kh_beg = khccc*p->sh + ((ih+p->ph)%p->sh);
            if (kh_beg < 0) kh_beg = 0;
          }
#elif 1
          {
            int const d = (ih+p->ph)/p->sh; //, r = (ih+p->ph)%p->sh;
            kh_beg = (ih+p->ph)%p->sh;
            int khccc = d + 1 - p->oh;
            //if (khccc < 0) khccc = 0;
            //kh_beg = khccc*p->sh + r;
            //kh_beg = (khccc < 0? 0: khccc*p->sh) + r;
            //kh_beg += khccc < 0? 0: khccc*p->sh;
            if( khccc >= 0 ) kh_beg += khccc*p->sh;
            //kh_beg += (khccc < 0? 0: khccc*p->sh);
            //kh_beg += ((khccc < 0? 0: ~0) & khccc*p->sh);
            //RT_ASSERT( kh_beg >= 0 );
            //if (kh_beg < 0) kh_beg = 0;
          }
#endif

          //  oh_beg = (ih+p->ph - kh_beg)/p->sh ~  (ih+p->ph -  ((ih+p->ph) - p->oh*p->sh + 1))/p->sh
          //             = (p->oh * p->sh + 1)/p->sh ???
          //int ohb2 = (p->oh * p->sh + 1) / p->sh;
          //int khb2 = (ih+p->ph)/p->sh - ohb2s;
          //if (khb2 < 0) khb2 = 0;
          //int khb2s = khb2 * p->sh;
          //int ohb2s = ((ih+p->ph) - khb2s) / p->sh;
          //
          //int ohb2 = div_floor(p->oh + p->sh - 1, p->sh);
          //if( ohb2 < 0 ) ohb2 = 0;
          //int ohb2s = ohb2 * p->sh;
          //int ohb2 = p->oh*p->sh;
          //printf(" oh_beg=%d ohb2=%d ohb2s=%d\n",oh_beg,ohb2, ohb2s);
          //RT_ASSERT( ohb2s == oh_beg );
          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            //hoist_AmiB_in( kw_beg, kw_end,
            //    /*i  in   */ 0, p->kw,
            //    /*ow=A+iB */ (iw + p->pw), (p->dw+1),
            //    /*ow in   */ 0, p->ow*p->sw );
            // REPL kw_beg =            (iw + p->pw) - p->ow*p->sw              + 1;
            kw_end =            (iw + p->pw) - 0                        + 1;
            // REPL if (kw_beg < 0    ) kw_beg = 0;
            if (kw_end > p->kw) kw_end = p->kw;
#if 0
            { // jump kw_beg up to 1st non-skipped index
              int ow_beg = iw+p->pw - kw_beg /* * (p->dw+1) */;
              if ((ow_beg % p->sw)){
                do {
                  ++kw_beg;
                  ow_beg = iw+p->pw - kw_beg /* * (p->dw+1) */;
                } while( ow_beg % p->sw != 0 && kw_beg < kw_end );
                //print(0, " ... kw_beg --> %d, ow_beg --> %d\n", kw_beg, ow_beg);
                DMUST( (kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0) );
              }
            }
#else
          {
            int const d = (iw+p->pw)/p->sw; //, r = (iw+p->pw)%p->sw;
            kw_beg = (iw+p->pw)%p->sw;
            int kwccc = d + 1 - p->ow;
            //if (kwccc < 0) kwccc = 0;
            //kw_beg = kwccc*p->sw + r;
            //kw_beg = (kwccc < 0? 0: kwccc*p->sw) + r;
            if( kwccc >= 0 ) kw_beg += kwccc*p->sw;
            //kw_beg += (kwccc < 0? 0: kwccc*p->sw);
            //kw_beg += ((kwccc < 0? 0: ~0) & kwccc*p->sw);
          }
#endif
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            if( TRIVIAL(kh_beg >= kh_end || kw_beg >= kw_end) ){
              ; //DPRINTF("t");
            } else {
              //DPRINTF(".");
              //bool const s0 = kh_beg >= kh_end || p->sh <= 1; // this IMPLIES skips remains 0
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                // next: loop over allowed oh values, THEN over kh
                //int const khh = p->sh; // only for p->dh==0 !!!
                for (int kh = kh_beg; kh < kh_end; kh+=p->sh) {
                  //int oh = ih+p->ph - kh * (p->dh + 1) ; // loop vars: kh, ih
                  //oh /= p->sh;
                  const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;

                  //int const kww = p->sw; // perhaps lcd of p-sh and p->dh+1 ? XXX
                  for (int kw = kw_beg; kw < kw_end; kw += p->sw) {
                    //int ow = iw+p->pw - kw * (p->dw + 1); // loop vars: iw, kw
                    ////if (ow < 0 || ow % p->sw) continue;
                    //ow /= p->sw;
                    ////if (ow >= p->ow) continue;
                    const int ow = (iw+p->pw - kw /* * (p->dw + 1) */) / p->sw;

                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
  }
#elif 0 // specialize to p->dh, p->dw == 0
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          kh_end = (ih + p->ph);
          kh_beg = kh_end/*(ih+p->ph)*/ % p->sh;
          int khccc = kh_end/*(ih+p->ph)*/ / p->sh - p->oh + 1;
          if( khccc >= 0 ) kh_beg += khccc*p->sh;
          ++kh_end;
          if (kh_end > p->kh) kh_end = p->kh;

          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            kw_end = (iw + p->pw);
            kw_beg = kw_end/*(iw+p->pw)*/ % p->sw;
            int kwccc = kw_end/*(iw+p->pw)*/ / p->sw - p->ow + 1;
            if( kwccc >= 0 ) kw_beg += kwccc*p->sw;
            ++kw_end;
            if (kw_end > p->kw) kw_end = p->kw;

            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0; // always!

            if( kh_beg < kh_end && kw_beg < kw_end )
            {
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                for (int kh = kh_beg; kh < kh_end; kh+=p->sh) {
                  const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;
                  for (int kw = kw_beg; kw < kw_end; kw += p->sw) {
                    const int ow = (iw+p->pw - kw /* * (p->dw + 1) */) / p->sw;

                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
  }
#elif 0 // specialize to p->dh, p->dw == 0
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          kh_end = (ih + p->ph);
          kh_beg = kh_end/*(ih+p->ph)*/ % p->sh;
          int khccc = kh_end/*(ih+p->ph)*/ / p->sh - p->oh + 1;
          if( khccc >= 0 ) kh_beg += khccc*p->sh;
          ++kh_end;
          if (kh_end > p->kh) kh_end = p->kh;

          //int khb2 = ih+p->ph + 1 - p->oh*p->sh;
          //if (khb2 < 0) khb2 = 0;
          //int khb2s = (khb2+p->sh-1)/p->sh *p->sh;
          //int ohb2 = ih+p->ph - khb2s;
          //RT_ASSERT( ohb2 >= 0 );
          //if (ohb2 < 0) ohb2 = 0;
          //ohb2 = ohb2 / p->sh;
          //int ohb2s = ohb2 * p->sh;
          //int ohb2 = ih+p->ph - kh_beg;
          //if (ohb2 < 0) ohb2 = 0;
          //ohb2 /= p->sh; // <-------- this is "oh_beg"
          const int oh_beg = (ih+p->ph - kh_beg) / p->sh;

          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            kw_end = (iw + p->pw);
            kw_beg = kw_end/*(iw+p->pw)*/ % p->sw;
            int kwccc = kw_end/*(iw+p->pw)*/ / p->sw - p->ow + 1;
            if( kwccc >= 0 ) kw_beg += kwccc*p->sw;
            ++kw_end;
            if (kw_end > p->kw) kw_end = p->kw;
            const int ow_beg = (iw+p->pw - kw_beg) / p->sw;

            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0; // always!

            if( kh_beg < kh_end && kw_beg < kw_end )
            {
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                //int oh = ohb2;
                for (int kh = kh_beg, oh=oh_beg; kh < kh_end; --oh, kh+=p->sh) {
                  //const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;
                  //const int oh = ohb2 - (kh-kh_beg)/p->sh;
                  //if( kh == kh_beg ) RT_ASSERT( oh == ohb2 );
                  for (int kw = kw_beg, ow=ow_beg; kw < kw_end; --ow, kw += p->sw) {
                    //const int ow = (iw+p->pw - kw /* * (p->dw + 1) */) / p->sw;

                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
  }
#elif 1 // oh calc becomes --oh; regr BWD_D=8.23x, 7.83x
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          kh_end = (ih + p->ph);
          kh_beg = kh_end/*(ih+p->ph)*/ % p->sh;
          int khccc = kh_end/*(ih+p->ph)*/ / p->sh - p->oh + 1;
          if( khccc >= 0 ) kh_beg += khccc*p->sh;
          ++kh_end;
          if (kh_end > p->kh) kh_end = p->kh;
          const int oh_beg = (ih+p->ph - kh_beg) / p->sh;

          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            kw_end = (iw + p->pw);
            kw_beg = kw_end/*(iw+p->pw)*/ % p->sw;
            int kwccc = kw_end/*(iw+p->pw)*/ / p->sw - p->ow + 1;
            if( kwccc >= 0 ) kw_beg += kwccc*p->sw;
            ++kw_end;
            if (kw_end > p->kw) kw_end = p->kw;
            const int ow_beg = (iw+p->pw - kw_beg) / p->sw;

            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0; // always!

            if( kh_beg < kh_end && kw_beg < kw_end )
            {
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                for (int kh = kh_beg, oh=oh_beg; kh < kh_end; --oh, kh+=p->sh) {
                  for (int kw = kw_beg, ow=ow_beg; kw < kw_end; --ow, kw += p->sw) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
  }
#else
#error "please enable one impl"
#endif
}

/** This one just reuses the hoisting function from FWD.
 * g,oc,ic,kh,kw,mb,oh,ow,[iw],[ih] */
void refconv_3_bwd_w(const prb_t *p, dnn_mem_t &src_m,
    dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
#if 0
#define NEW 1
  auto ker = [](
      const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &src_m,
      float &dw, int g, int oc, int ic, int kh, int kw
#if NEW
      , const int oh_beg, const int oh_end, const int ow_beg, const int ow_end
#endif
      ) {
    for (int mb = 0; mb < p->mb; ++mb) {
#if !NEW
      for (int oh = 0; oh < p->oh; ++oh) {
        for (int ow = 0; ow < p->ow; ++ow) {
          const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
          const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
          if (ih < 0 || ih >= p->ih) continue;
          if (iw < 0 || iw >= p->iw) continue;
#else
          for (int oh = oh_beg; oh < oh_end; ++oh) {
            for (int ow = ow_beg; ow < ow_end; ++ow) {
              const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
              const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
#endif
              size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
              size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
              dw += ((float*)diff_dst_m)[dst_off]
                * ((float*)src_m)[src_off];
            }
          }
        }
      };

#   pragma omp parallel for collapse(5)
      for (int g = 0; g < p->g; ++g) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
          for (int ic = 0; ic < p->ic/p->g; ++ic) {
            for (int kh = 0; kh < p->kh; ++kh) {
              for (int kw = 0; kw < p->kw; ++kw) {
#if NEW
                int oh_beg, oh_end;
                hoist_ApiB_in( oh_beg, oh_end,
                    /*i  in   */ 0, p->oh,
                    /*ih=A+iB */ (kh * (p->dh+1) - p->ph), p->sh,
                    /*ih in   */ 0, p->ih);
                int ow_beg, ow_end;
                hoist_ApiB_in( ow_beg, ow_end,
                    /*i  in   */ 0, p->ow,
                    /*iw=A+iB */ (kw * (p->dw+1) - p->pw), p->sw,
                    /*iw in   */ 0, p->iw);
#endif
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                float &dw = ((float*)diff_wei_m)[wei_off];
                dw = 0;
                ker( p, diff_dst_m, src_m,
                    dw, g, oc, ic, kh, kw
#if NEW
                    , oh_beg, oh_end, ow_beg, ow_end
#endif
                   );
              }
            }
          }
        }
      }

      if (!(p->dir & FLAG_BIA)) return;

#   pragma omp parallel for collapse(2)
      for (int g = 0; g < p->g; ++g) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0;

          for (int mb = 0; mb < p->mb; ++mb) {
            for (int oh = 0; oh < p->oh; ++oh) {
              for (int ow = 0; ow < p->ow; ++ow) {
                size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                db += ((float*)diff_dst_m)[dst_off];
              }
            }
          }
        }
      }
    }
#elif 0 // just clean up.. musek(avx):regr 2.36x,2.0x
  {
    auto ker = [](
        const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &src_m,
        float &dw, int g, int oc, int ic, int kh, int kw
        , const int oh_beg, const int oh_end, const int ow_beg, const int ow_end
        ) {
      for (int mb = 0; mb < p->mb; ++mb) {
        for (int oh = oh_beg; oh < oh_end; ++oh) {
          for (int ow = ow_beg; ow < ow_end; ++ow) {
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
            const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            dw += ((float*)diff_dst_m)[dst_off]
              * ((float*)src_m)[src_off];
          }
        }
      }
    };

# pragma omp parallel for collapse(5)
    for (int g = 0; g < p->g; ++g) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
              int oh_beg, oh_end;
              hoist_ApiB_in( oh_beg, oh_end,
                  /*i  in   */ 0, p->oh,
                  /*ih=A+iB */ (kh * (p->dh+1) - p->ph), p->sh,
                  /*ih in   */ 0, p->ih);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                  /*i  in   */ 0, p->ow,
                  /*iw=A+iB */ (kw * (p->dw+1) - p->pw), p->sw,
                  /*iw in   */ 0, p->iw);
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              dw = 0;
              ker( p, diff_dst_m, src_m,
                  dw, g, oc, ic, kh, kw
                  , oh_beg, oh_end, ow_beg, ow_end
                 );
            }
          }
        }
      }
    }

    if (!(p->dir & FLAG_BIA)) return;

# pragma omp parallel for collapse(2)
    for (int g = 0; g < p->g; ++g) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        db = 0;

        for (int mb = 0; mb < p->mb; ++mb) {
          for (int oh = 0; oh < p->oh; ++oh) {
            for (int ow = 0; ow < p->ow; ++ow) {
              size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
              db += ((float*)diff_dst_m)[dst_off];
            }
          }
        }
      }
    }
  }
#elif 0 // inline kernel musek(avx):regr=2.68x
# pragma omp parallel
  {
#   pragma omp for collapse(5)
    for (int g = 0; g < p->g; ++g) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
              int oh_beg, oh_end;
              hoist_ApiB_in( oh_beg, oh_end,
                  /*i  in   */ 0, p->oh,
                  /*ih=A+iB */ (kh * (p->dh+1) - p->ph), p->sh,
                  /*ih in   */ 0, p->ih);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                  /*i  in   */ 0, p->ow,
                  /*iw=A+iB */ (kw * (p->dw+1) - p->pw), p->sw,
                  /*iw in   */ 0, p->iw);
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              dw = 0;

              //ker( p, diff_dst_m, src_m, dw, g, oc, ic, kh, kw , oh_beg, oh_end, ow_beg, ow_end);
              for (int mb = 0; mb < p->mb; ++mb) {
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
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
#   pragma omp for collapse(2) nowait
      for (int g = 0; g < p->g; ++g) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0;
          for (int mb = 0; mb < p->mb; ++mb) {
            for (int oh = 0; oh < p->oh; ++oh) {
              for (int ow = 0; ow < p->ow; ++ow) {
                size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                db += ((float*)diff_dst_m)[dst_off];
              }
            }
          }
        }
      }
    }
  }
#elif 1 // move zeroing up-front musek(avx):regr=4.46x
# pragma omp parallel
  {
#   pragma omp for collapse(5)
    for (int g = 0; g < p->g; ++g) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              dw = 0;
            }
          }
        }
      }
    }
#   pragma omp for collapse(4)
    for (int g = 0; g < p->g; ++g) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        //for (int ic = 0; ic < p->ic/p->g; ++ic)
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
              int oh_beg, oh_end;
              hoist_ApiB_in( oh_beg, oh_end,
                  /*i  in   */ 0, p->oh,
                  /*ih=A+iB */ (kh * (p->dh+1) - p->ph), p->sh,
                  /*ih in   */ 0, p->ih);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                  /*i  in   */ 0, p->ow,
                  /*iw=A+iB */ (kw * (p->dw+1) - p->pw), p->sw,
                  /*iw in   */ 0, p->iw);
              if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
        //for (int ic = 0; ic < p->ic/p->g; ++ic)

        for (int ic = 0; ic < p->ic/p->g; ++ic) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              //ker( p, diff_dst_m, src_m, dw, g, oc, ic, kh, kw , oh_beg, oh_end, ow_beg, ow_end);
              for (int mb = 0; mb < p->mb; ++mb) {
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
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
#   pragma omp for collapse(2) nowait
      for (int g = 0; g < p->g; ++g) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0;
          for (int mb = 0; mb < p->mb; ++mb) {
            for (int oh = 0; oh < p->oh; ++oh) {
              for (int ow = 0; ow < p->ow; ++ow) {
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
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0,\:0,N-s foldmethod=indent foldlevel=3
