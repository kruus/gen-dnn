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
  // on alexnet, this got me about 15x speedup
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

            // trick to easy calc of kh, kw loop limits is that division must
            // round more consistently.  'C' round-to-zero is not so useful!
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
                for (int kh = kh_beg; kh < kh_end; ++kh) {
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

/** inline the kernel.  regr 4.31x musek(avx) 4.91x FIXME */
static void refconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
{
#if 0 // WRONG
  const int lcm_w = lcm( p->sw, p->dw+1 );
  const int lcm_h = lcm( p->sh, p->dh+1 );
#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          hoist_AmiB_in( kh_beg, kh_end,
              /*kh  in   */ 0, p->kh,
              /*oh=A+khB */ (ih + p->ph), (p->dh+1),
              /*oh in   */ 0, p->oh*p->sh );
          { // jump kh_beg up to 1st non-skipped index
            int oh_beg = ih+p->ph - kh_beg * (p->dh+1); // must always be a mult of p->sh
            int rem_beg = oh_beg % p->sh;
            if (rem_beg){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg * (p->dh+1);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
            }
          }
          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            hoist_AmiB_in( kw_beg, kw_end,
                /*i  in   */ 0, p->kw,
                /*ow=A+iB */ (iw + p->pw), (p->dw+1),
                /*ow in   */ 0, p->ow*p->sw );
            { // jump kw_beg up to 1st non-skipped index
              int ow_beg = iw+p->pw - kw_beg * (p->dw+1);
              int rem_beg = ow_beg % p->sw;
              if (rem_beg){
                do {
                  ++kw_beg;
                  ow_beg = iw+p->pw - kw_beg * (p->dw+1);
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
              //
              // 3 nested loops, with NO conditional tests
              //
              //DPRINTF(".");
              //bool const s0 = kh_beg >= kh_end || p->sh <= 1; // this IMPLIES skips remains 0
              // next: loop over allowed oh values, THEN over kh
              int const khh = p->sh; // only for p->dh==0 !!!
              int const khh = lcm_h;
              for (int kh = kh_beg; kh < kh_end; kh += lcm_h) {
                //int oh = ih+p->ph - kh * (p->dh + 1) ; // loop vars: kh, ih
                //oh /= p->sh;
                const int oh = (ih+p->ph - kh * (p->dh + 1)) / p->sh;

                //int const kww = p->sw; // perhaps lcd of p-sh and p->dh+1 ? XXX
                for (int kw = kw_beg; kw < kw_end; kw += lcm_w) {
                  //int ow = iw+p->pw - kw * (p->dw + 1); // loop vars: iw, kw
                  ////if (ow < 0 || ow % p->sw) continue;
                  //ow /= p->sw;
                  ////if (ow >= p->ow) continue;
                  const int ow = (iw+p->pw - kw * (p->dw + 1)) / p->sw;

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
#elif 0 // OK -- change only if found to be borken! regr 2.42x
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            for (int kh = 0; kh < p->kh; ++kh) {
              int oh = ih - kh * (p->dh + 1) + p->ph;
              bool const ohok = oh >= 0 && oh % p->sh == 0;
              oh = oh / p->sh;

              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                bool const owok = ow >= 0 && ow % p->sw == 0;
                ow = ow / p->sw;
                if (!(ohok && owok && oh < p->oh && ow < p->ow)) continue;

                for (int oc = 0; oc < p->oc/p->g; ++oc) { // <---- moved
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
#elif 0 // some simplifications, printout, ... finally dkh == lcm_h/DH;
  // regr 2.42x
  const int gcd_h = gcd( p->sh, p->dh+1 );
  const int lcm_h = lcm( p->sh, p->dh+1 );
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            const bool doprt = true;

            int kh_beg, oh_beg, kh_end;
            //hoist_AmiB_in( kh_beg, kh_end,
            //    /*i  in      */ 0, p->kh,
            //    /*ohxsh=A+iB */ (ih + p->ph), (p->dh+1),
            //    /*ohxsh in   */ 0, p->oh*p->sh );
            //kh_beg = div_floor(    a      -      d      ,   b    ) + 1;
            //kh_end = div_floor(    a      -      c      ,   b    ) + 1;
            kh_end = div_floor((ih + p->ph) -      0      , p->dh+1) + 1;
            if (kh_end > p->kh) kh_end = p->kh;
            kh_beg = div_floor( (ih + p->ph) - p->oh*p->sh, p->dh+1) + 1;
            if (kh_beg < 0    ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+p->ph - kh_beg * (p->dh+1);
              int rem_beg = ohxsh % p->sh;
              if (rem_beg){
                // XXX closed-form formula ???  (should be easy now that know p->dh==0)
                // ref_conv4 has a strictly correct similar corrective example
                do {
                  ++kh_beg;
                  ohxsh = ih+p->ph - kh_beg * (p->dh+1);
                } while( ohxsh % p->sh != 0 && kh_beg < kh_end );
                //print(0, " ... kh_beg --> %d, ohxsh --> %d\n", kh_beg, ohxsh);
                DMUST( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
              }
            }
            RT_ASSERT( kh_beg >= 0 );
            //RT_ASSERT( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
            oh_beg = (ih+p->ph - kh_beg * (p->dh+1)) / p->sh;
            if( kh_beg < kh_end ){
                RT_ASSERT( oh_beg < p->oh );
                // no RT_ASSERT( oh_beg >= 0 );
            }
            int oha = ih - kh_beg * (p->dh+1) + p->ph;
            if(kh_beg < kh_end){
                RT_ASSERT( oha >= 0 );
                RT_ASSERT( oha % p->sh == 0 );
            }

            bool prt = false;
            //for (int kh = kh_beg; kh < kh_end; kh+=p->sw)
            //const int khh = lcm_h;
            int khh = 1;
            //if( p->dh== 0 ) khh = p->sh; // safe case
            int kh_prev = kh_beg;
            int dkh_prev = 0, dkh = 0;
            int ok=0, skip=0;
            for (int kh = kh_beg, oh0=ih+p->ph-kh_beg*(p->dh+1);
                    kh < kh_end;
                    oh0-=(p->dh+1)*khh, kh+=khh)
            {
              //int oh0 = ih - kh * (p->dh + 1) + p->ph;
              //int oh0 = oha; oha -= (p->dh+1)*khh;
              bool const ohok = oh0 >= 0 && oh0 % p->sh == 0;
              
              int oh = oh0 / p->sh;
              RT_ASSERT( oh <= oh_beg );
              RT_ASSERT( kh < kh_end );
              if(kh == kh_beg){
                  RT_ASSERT( oh == oha/p->sh );
                  RT_ASSERT( oh0 % p->sh == 0 );
                  RT_ASSERT( oh >= 0 );
                  RT_ASSERT( ohok );
                  // the *next* good kh is such that oh0 - N*DH is also a multiple of SH
                  // This happens when N*DH /SH*SH == N*DH,  (here N ~ dkh)
                  // or lowest N s.t. (N*DH) % SH == 0
              }
              RT_ASSERT( oh >= 0 ); // if not, kh_end may be incorrect
              //RT_ASSERT( oh0 % p->sh == 0 ); // <-- would be nice

              if(doprt && g==0 && mb==0 && ic==0 && iw==0){
                if(ohok){
                  dkh = kh-kh_prev;
                  if( dkh_prev != 0 ) RT_ASSERT( dkh == dkh_prev );
                  dkh_prev = dkh;
                  RT_ASSERT( oh < p->oh );
                  if( 1 ){
                    prt=true;
                    ++ok;
                    print(0, " kh,oh=%d,%d", kh,oh);
                  }
                  kh_prev = kh;
                }else{
                  if( oh0 >= 0 ){
                    RT_ASSERT( oh0 % p->sh != 0 ); // how is this possible?
                    prt=true;
                    ++skip;
                    print(0, " x%%%d<%d,%d>", oh0 % p->sh, kh, oh);
                  }
                }
              }

              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                bool const owok = ow >= 0 && ow % p->sw == 0;
                ow = ow / p->sw;

                if (!(ohok && owok && oh < p->oh && ow < p->ow)) continue;

                for (int oc = 0; oc < p->oc/p->g; ++oc) { // <---- moved
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  ds += ((float*)diff_dst_m)[dst_off]
                    * ((float*)wei_m)[wei_off];
                }
              }
            }
            if(doprt){
              RT_ASSERT( (ok + skip > 0)  ==  prt );
              int const DH = p->dh + 1;
              int const SH = p->sh;
              // discover truths ?
              if(prt){
                print(0, "\n\t\tok,skip=%d,%d; dkh=%d; sh,dh+1,ph=%d,%d,%d; ih=%d",
                      ok,skip, dkh, SH, DH, p->ph, ih);
                if(dkh > 0 && p->dh==0) RT_ASSERT( dkh == SH );
                if(dkh > 0 && SH==1) RT_ASSERT( dkh == 1 );
                // n if(dkh > 0) RT_ASSERT( dkh == SH );
                // n if(dkh > 0) RT_ASSERT( dkh % SH == 0 );
                //   kh,oh=0,3 kh,oh=1,2 kh,oh=2,1   ok,skip=3,0; dkh=1; sh,dh+1,ph=2,2,5; ih=1
                if(dkh > 0 && p->dh==0) {
                  // or dkh= N*DH/SH where N is lowest N>0 s.t. (N*DH) % SH == 0
                  // N = (N*DH + SH-1)/SH
                  RT_ASSERT( dkh % SH == 0 );
                  RT_ASSERT( (dkh * (DH)) % SH == 0 );
                  //int N = SH;
                  int N = lcm_h/DH;             // <-------- (whew, finally!)
                  print(0," dkh=%d  N=%d, DH=%d", dkh, N, DH );
                  RT_ASSERT( (N*DH) % SH == 0 );
                  RT_ASSERT( dkh == N );
                }else if(dkh > 0 && p->dh!=0) {
                  // or lowest N>0 s.t. (N*DH) % SH == 0
                  RT_ASSERT( (dkh * DH) % SH == 0 );
                  for(int i=1; i<dkh; ++i)
                      RT_ASSERT( (i * DH) % SH != 0 );
                  //int N = (DH)/lcm_h;
                  int N = lcm_h/DH;
                  print(0," dkh=%d  N=%d, DH=%d SH=%d lcm=%d gcd=%d\n", dkh, N, DH, SH, lcm_h, gcd_h );
                  RT_ASSERT(N>0);
                  RT_ASSERT( (N*DH) % SH == 0 );
                  RT_ASSERT( N == dkh );
                }

                // no if(kh_beg<kh_end) RT_ASSERT( dkh == 0 || dkh == SH );
                //  kh,oh=0,3 kh,oh=1,2 kh,oh=2,1    ok,skip=3,0; dkh=1; sh,dh+1,ph=2,2,5; ih=1
                // no if(dkh > 0) RT_ASSERT( dkh == lcm(SH, DH) );
                // no if(dkh > 0) RT_ASSERT( dkh == gcd(SH, DH) );
                // no if(dkh > 0) RT_ASSERT( dkh == lcm(SH, DH) * SH );
                if(dkh > 0 && p->dh!=0) print(0," %s", " dkh?");
                print(0, "%c",'\n');
              }
            }

          }
        }
      }
    }
  }
#elif 0 // remove a little bit of printout, use khh=lcm_h/(p->dh+1) step
  const int gcd_h = gcd( p->sh, p->dh+1 );
  const int lcm_h = lcm( p->sh, p->dh+1 );
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            const bool doprt = true;

            int kh_beg, oh_beg, kh_end;
            //hoist_AmiB_in( kh_beg, kh_end,
            //    /*i  in      */ 0, p->kh,
            //    /*ohxsh=A+iB */ (ih + p->ph), (p->dh+1),
            //    /*ohxsh in   */ 0, p->oh*p->sh );
            //kh_beg = div_floor(    a      -      d      ,   b    ) + 1;
            //kh_end = div_floor(    a      -      c      ,   b    ) + 1;
            kh_end = div_floor((ih + p->ph) -      0      , p->dh+1) + 1;
            if (kh_end > p->kh) kh_end = p->kh;
            kh_beg = div_floor( (ih + p->ph) - p->oh*p->sh, p->dh+1) + 1;
            if (kh_beg < 0    ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+p->ph - kh_beg * (p->dh+1);
              int rem_beg = ohxsh % p->sh;
              if (rem_beg){
                // XXX closed-form formula ???  (should be easy now that know p->dh==0)
                // ref_conv4 has a strictly correct similar corrective example
                do {
                  ++kh_beg;
                  ohxsh = ih+p->ph - kh_beg * (p->dh+1);
                } while( ohxsh % p->sh != 0 && kh_beg < kh_end );
                //print(0, " ... kh_beg --> %d, ohxsh --> %d\n", kh_beg, ohxsh);
                DMUST( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
              }
            }
            RT_ASSERT( kh_beg >= 0 );
            //RT_ASSERT( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
            oh_beg = (ih+p->ph - kh_beg * (p->dh+1)) / p->sh;
            if( kh_beg < kh_end ){
                RT_ASSERT( oh_beg < p->oh );
                // no RT_ASSERT( oh_beg >= 0 );
            }
            int oha = ih - kh_beg * (p->dh+1) + p->ph;
            if(kh_beg < kh_end){
                RT_ASSERT( oha >= 0 );
                RT_ASSERT( oha % p->sh == 0 );
            }

            bool prt = false;
            //for (int kh = kh_beg; kh < kh_end; kh+=p->sw)
            //const int khh = lcm_h;
            //int khh = 1; // safe bet
            //if( p->dh== 0 ) khh = p->sh; // safe case
            // NEW:
            int khh = lcm_h / (p->dh+1);
            int kh_prev = kh_beg;
            int dkh_prev = 0, dkh = 0;
            int ok=0, skip=0;
            for (int kh = kh_beg, oh0=ih+p->ph-kh_beg*(p->dh+1);
                    kh < kh_end;
                    oh0-=(p->dh+1)*khh, kh+=khh)
            {
              //int oh0 = ih - kh * (p->dh + 1) + p->ph;
              //int oh0 = oha; oha -= (p->dh+1)*khh;
              bool const ohok = oh0 >= 0 && oh0 % p->sh == 0;
              
              int oh = oh0 / p->sh;
              RT_ASSERT( oh <= oh_beg );
              RT_ASSERT( kh < kh_end );
              if(kh == kh_beg){
                  RT_ASSERT( oh == oha/p->sh );
                  RT_ASSERT( oh0 % p->sh == 0 );
                  RT_ASSERT( oh >= 0 );
                  RT_ASSERT( ohok );
                  // the *next* good kh is such that oh0 - N*DH is also a multiple of SH
                  // This happens when N*DH /SH*SH == N*DH,  (here N ~ dkh)
                  // or lowest N s.t. (N*DH) % SH == 0
              }
              RT_ASSERT( oh >= 0 ); // if not, kh_end may be incorrect
              //RT_ASSERT( oh0 % p->sh == 0 ); // <-- would be nice

              if(doprt && g==0 && mb==0 && ic==0 && iw==0){
                if(ohok){
                  dkh = kh-kh_prev;
                  if( dkh_prev != 0 ) RT_ASSERT( dkh == dkh_prev );
                  dkh_prev = dkh;
                  RT_ASSERT( oh < p->oh );
                  if( 1 ){
                    prt=true;
                    ++ok;
                    print(0, " kh,oh=%d,%d", kh,oh);
                  }
                  kh_prev = kh;
                }else{
                  if( oh0 >= 0 ){
                    RT_ASSERT( oh0 % p->sh != 0 ); // how is this possible?
                    prt=true;
                    ++skip;
                    print(0, " x%%%d<%d,%d>", oh0 % p->sh, kh, oh);
                  }
                }
              }

              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                bool const owok = ow >= 0 && ow % p->sw == 0;
                ow = ow / p->sw;

                if (!(ohok && owok && oh < p->oh && ow < p->ow)) continue;

                for (int oc = 0; oc < p->oc/p->g; ++oc) { // <---- moved
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  ds += ((float*)diff_dst_m)[dst_off]
                    * ((float*)wei_m)[wei_off];
                }
              }
            }
            if(doprt){
              RT_ASSERT( (ok + skip > 0)  ==  prt );
              int const DH = p->dh + 1;
              int const SH = p->sh;
              // discover truths ?
              if(prt){
                print(0, "\n\t\tok,skip=%d,%d; dkh=%d; sh,dh+1,ph=%d,%d,%d; ih=%d",
                      ok,skip, dkh, SH, DH, p->ph, ih);
                if(dkh > 0 && p->dh==0) RT_ASSERT( dkh == SH );
                if(dkh > 0 && SH==1) RT_ASSERT( dkh == 1 );
                if(dkh > 0) RT_ASSERT( dkh == lcm_h/DH ); // **************
                print(0, "%c",'\n');
              }
            }

          }
        }
      }
    }
  }
#elif 0 // clean up 'kh' calcs regr 2.64x
  const int gcd_h = gcd( p->sh, p->dh+1 );
  const int lcm_h = lcm( p->sh, p->dh+1 );
  const int khh = lcm_h / (p->dh+1);
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_beg, oh_beg, kh_end;
            kh_end = div_floor((ih + p->ph) -      0      , p->dh+1) + 1;
            if (kh_end > p->kh) kh_end = p->kh;
            kh_beg = div_floor( (ih + p->ph) - p->oh*p->sh, p->dh+1) + 1;
            if (kh_beg < 0    ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+p->ph - kh_beg * (p->dh+1);
              int rem_beg = ohxsh % p->sh;
              if (rem_beg){
                // XXX closed-form formula ???  (should be easy now that know p->dh==0)
                // ref_conv4 has a strictly correct similar corrective example
                do {
                  ++kh_beg;
                  ohxsh = ih+p->ph - kh_beg * (p->dh+1);
                } while( ohxsh % p->sh != 0 && kh_beg < kh_end );
                //print(0, " ... kh_beg --> %d, ohxsh --> %d\n", kh_beg, ohxsh);
                DMUST( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
              }
            }
            //RT_ASSERT( kh_beg >= 0 );
            oh_beg = (ih+p->ph - kh_beg * (p->dh+1)) / p->sh;

            for (int kh = kh_beg, oh0=ih+p->ph-kh_beg*(p->dh+1);
                    kh < kh_end;
                    oh0-=(p->dh+1)*khh, kh+=khh) // oh0 step == lcm_h
            {
              //bool const ohok = oh0 >= 0 && oh0 % p->sh == 0;
              // y RT_ASSERT( oh0 >= 0 ); // would be nice!
              // y RT_ASSERT( ohok ); // if true, then NO tests inside loop
              DMUST( oh0 >= 0 && oh0 % p->sh == 0 );
              int oh = oh0 / p->sh;
              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                bool const owok = ow >= 0 && ow % p->sw == 0;
                ow = ow / p->sw;

                if (!(/*ohok &&*/ owok && oh < p->oh && ow < p->ow)) continue;

                for (int oc = 0; oc < p->oc/p->g; ++oc) { // <---- moved
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
#elif 0 // removing oh0 variable? IMPOSSIBLE.
  // do same for kw loop, loop order (no diff)
  // bwd_d,regr.sh ~ 4.30x  YAHOO
  //const int gcd_h = gcd( p->sh, p->dh+1 );
  const int lcm_h = lcm( p->sh, p->dh+1 );
  const int khh = lcm_h / (p->dh+1);
  const int lcm_w = lcm( p->sw, p->dw+1 );
  const int kww = lcm_w / (p->dw+1);
  //const int ohh = khh/p->sh;
  // oh step MAY be irregular, I think. cannot elide oh0 variable
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_beg, oh_beg, kh_end;
            kh_end = div_floor((ih + p->ph) -      0      , p->dh+1) + 1;
            if (kh_end > p->kh) kh_end = p->kh;
            kh_beg = div_floor( (ih + p->ph) - p->oh*p->sh, p->dh+1) + 1;
            if (kh_beg < 0    ) kh_beg = 0;
            //RT_ASSERT( kh_beg >= 0 );
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+p->ph - kh_beg * (p->dh+1);
              int rem_beg = ohxsh % p->sh;
              if (rem_beg){
                do {
                  ++kh_beg;
                  ohxsh = ih+p->ph - kh_beg * (p->dh+1);
                } while( ohxsh % p->sh != 0 && kh_beg < kh_end );
                DMUST( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
              }
            }
            DMUST( kh_beg >= 0 );
            //oh_beg = (ih+p->ph - kh_beg*(p->dh+1)) / p->sh;
            if( kh_beg >= kh_end ) continue;

            int kw_beg, ow_beg, kw_end;
            kw_end = div_floor((iw + p->pw) -      0      , p->dw+1) + 1;
            if (kw_end > p->kw) kw_end = p->kw;
            kw_beg = div_floor( (iw + p->pw) - p->ow*p->sw, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
                int owxsw = iw+p->pw - kw_beg * (p->dw+1);
                int rem_beg = owxsw % p->sw;
                if (rem_beg){
                    do {
                        ++kw_beg;
                        owxsw = iw+p->pw - kw_beg * (p->dw+1);
                    } while( owxsw % p->sw != 0 && kw_beg < kw_end );
                    DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
                }
            }
            DMUST( kw_beg >= 0 );
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < p->oc/p->g; ++oc) { // <---- moved
              for (int kh = kh_beg, /*oh=oh_beg,*/ oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  /*oh-=ohh,*/ /*oh0-=(p->dh+1)*khh*/ oh0 -= lcm_h, kh += khh)
              {
                //if( kh == kh_beg ){ RT_ASSERT( oh == oh0 / p->sh ); }
                //bool const ohok = oh0 >= 0 && oh0 % p->sh == 0;
                // y RT_ASSERT( oh0 >= 0 ); // would be nice!
                // y RT_ASSERT( ohok ); // if true, then NO tests inside loop
                //DMUST( oh0 >= 0 && oh0 % p->sh == 0 );
                //int oh = oh0 / p->sh;
                //DMUST( oh < p->oh ); // didn't test earlier!
                //if(g==0 && mb==0 && ic==0 && iw==0) {print(0," oh0 oh00 oh   %d  %d  %d\n", oh0, oh00, oh); }
                //RT_ASSERT( oh == oh00 );

                //for (int kw = 0; kw < p->kw; ++kw)
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  //int ow = iw - kw * (p->dw + 1) + p->pw;
                  //bool const owok = ow >= 0 && ow % p->sw == 0;
                  //int ow = ow0 / p->sw;
                  //if (!(owok && ow < p->ow)) continue;

                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
#elif 0 // cleanup -- speed champion [so far]
  // bwd_d,regr.sh ~ 4.30x  YAHOO
  //const int gcd_h = gcd( p->sh, p->dh+1 );
  const int gcd_h = gcd( p->sh, p->dh+1 );
  const int lcm_h = lcm( p->sh, p->dh+1 );
  const int khh = lcm_h / (p->dh+1);

  const int gcd_w = gcd( p->sw, p->dw+1 );
  const int lcm_w = lcm( p->sw, p->dw+1 );
  const int kww = lcm_w / (p->dw+1);
#if 1
  auto klims = []( int& b, int& e, const int i, const int O, const int K,
          const int P, const int S, const int D ){
      // Note:  please call with D > 0; example D = (p->dh+1)
      //
      // find kernel loop limits [b,e) trying to have
      // b>=0, and output index
      // oh an exact multiple of S,
      // and oh [== ohxsh / S] < O
      e = (i+P) / D + 1;
      if (e > K) e = K;
      //b = div_floor( (i + P) - O*S, D) + 1; // -ves round down
      //if (b < 0 ) b = 0;
      b = i+P;
      b = (b >= O*S? (b - O*S) /  D + 1: 0);
      // jump b up to 1st non-skipped index
      int ohxsh = i+P - b * D;
      if (ohxsh % S){
          do {
              ++b;
              ohxsh = i+P - b * D;
          } while( ohxsh % S != 0 && b < e );
          DMUST( b >= e || (i+P - b * D) % S == 0 );
      }
      DMUST( b >= 0 );
      // kh_beg ~ b,  kh_end ~ e and oh_beg = i + P - b*D
  };
#else
  auto klims = []( int& b, int& e, const int i, const int O, const int K,
          const int P, const int S, const int D, const int GCD ){
      // use GCD to quickly skip "no solution" case
      e = (i+P) / D + 1;
      if (e > K) e = K;
      b = i+P;
      if ( b % GCD != 0 ) b = e; // no solutions possible
      else{
          //b = div_floor( (i + P) - O*S, D) + 1; // -ves round down
          //if (b < 0 ) b = 0;
          b = (b >= O*S? (b - O*S) /  D + 1: 0);
          // jump b up to 1st non-skipped index
          int ohxsh = i+P - b * D;
          if (ohxsh % S){
              do {
                  ++b;
                  ohxsh = i+P - b * D;
              } while( ohxsh % S != 0 && b < e );
              DMUST( b >= e || (i+P - b * D) % S == 0 );
          }
          DMUST( b >= 0 );
      }
      // kh_beg ~ b,  kh_end ~ e and oh_beg = i + P - b*D
  };
#endif
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            // quicktest for solutions to Diophantine (derived later)
            if( (ih+p->ph) % gcd_h || (iw+p->pw) % gcd_w )
                continue; // no integer solutions possible

            int kh_beg, /*oh_beg,*/ kh_end;
            klims(kh_beg, kh_end, ih, p->oh, p->kh, p->ph, p->sh, p->dh+1);
            if( kh_beg >= kh_end ) continue;

            int kw_beg, /*ow_beg,*/ kw_end;
            klims(kw_beg, kw_end, iw, p->ow, p->kw, p->pw, p->sw, p->dw+1);
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
#elif 0 // debug generic Diophantine soln for "klims" -- debug derivation
  /*
   * problem: Find the lowest khb >= kh_beg such that
   *          osh = ih+PH - khb*DH
   *      AND osh % SH == 0.
   *          Then oh_beg = osh / SH;
   *    First check if khb == kh_beg solves the problem.
   *    If not, formulate problem as linear equations in integers.
   *    Suppose osh = j * SH, for some integer j.
   * Diophantine approach ...
   *  see https://brilliant.org/wiki/linear-diophantine-equations-one-equation/
   *    Let o=osh
   *    and X=ih+PH - kh_beg*DH
   *    1)  o = X - k*D   s.t. k > 0
   *    2)  o == j*S      (integer j, j >= 0)
   *    i.e.    X - k*D = j*S
   *         or j*S + k*D = X,    for known integers S,D,X; unknown ints j,k
   */
  // bwd_d,regr.sh ~ 4.30x  YAHOO
  int const KH = p->kh;
  int const OH = p->oh;
  int const DH = p->dh + 1;
  int const SH = p->sh;
  int const PH = p->ph;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = lcm( SH, DH ); // = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  RT_ASSERT( khh == SH / gcd(SH,DH) );
  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
  int const DW = p->dw + 1;
  int const SW = p->sw;
  int const OW = p->ow;
  int const PW = p->pw;
  const int lcm_w = lcm( SW, DW );
  const int kww = lcm_w / DW;
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_end = (ih + PH) / DH + 1;
            if (kh_end > KH) kh_end = KH;
            int kh_beg = div_floor( (ih + PH) - OH*SH, DH) + 1;
            if (kh_beg < 0 ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+PH - kh_beg * DH;
              if (ohxsh % SH){
                do {
                  ++kh_beg;
                  ohxsh = ih+PH - kh_beg * DH;
                } while( ohxsh % SH != 0 && kh_beg < kh_end );
                DMUST( kh_beg >= kh_end || (ih+PH - kh_beg * DH) % SH == 0 );
              }
            }
            DMUST( kh_beg >= 0 );

            // soln existence check:
            if( (ih+PH) % gcd_h != 0 ) RT_ASSERT( kh_beg >= kh_end );
#if 1
            if(g==0 && mb==0 && ic==0 && iw==0) {
#if 1 // via equations
              /* problem: Find the lowest khb >= kh_beg such that
               *          osh = ih+PH - khb*DH
               *      AND osh % SH == 0.            i.e. osh = j*SH
               *          (Then oh_beg = osh / SH)
               * Diophantine: solve for unknown integers k,j ...
               *    k*DH + j*SH = X,     where X = ih+PH
               */
              int X = ih+PH;
              // Does a solution exist?
              //   If gcd(DH,SH) divides X, then yes
              if( X % gcd_h != 0 ){
                  RT_ASSERT( kh_beg >= kh_end );
                  kh_beg = kh_end;
              }else{
                // Any soln is good enough for now?
                //int khb = 0;
                // Approx solution for kh_beg without modulo constraint:
                ///int khb = div_floor( ih + PH - OH*SH, DH) + 1;
                ///if (khb < 0    ) khb = 0;
                int khb=0;
                // Check if khb solves the problem:
                int osh = ih+PH - khb * DH;
                if (osh % p->sh) { // move khb upward to exact soln
                  int ohxsh = ih+PH - kh_beg * DH;
                  print(0," kh_beg,ohxsh=%d,%d khb=%d",kh_beg,ohxsh, khb);
                  int X = ih+PH - khb*DH;
                  // Equns:  1)  o = X - k*DH   s.t. k>0 (increment to khb)
                  //   and   2)  o == j * SH    for some integer j
                  // i.e.  k*DH + j*SH = (X-o)+o = X, a Diophantine equation.
                  // solve k*DH + j*SH = X
                  //   1. divide by gcd(DH,SH)  (elide this step later?)
                  int const D = DH/gcd_h;
                  int const S = SH/gcd_h;
                  int const R = X /gcd_h;  // must evenly divide for soln to exist
                  //      now have equn k*D + j*S = R where gcd(D,S) is 1
                  //   2. solve k*D + j*S = 1
                  RT_ASSERT( gcd(D,S) == 1 );
                  int k, j, g;
                  extendedEuclid( k, D, j, S, g);
                  RT_ASSERT( k*gcd_h == ha );
                  RT_ASSERT( j*gcd_h == hb );
                  RT_ASSERT( g*gcd_h == hg );
                  if( gcd_h > 1 ) print(0," extendedEuclid: %d * [D=%d] + %d * [S=%d] = %d[gcd(D,S)]", k,D, j,S, g);
                  //RT_ASSERT( g = gcd_h/gcd_h );
                  RT_ASSERT(g==1);
                  RT_ASSERT( k*D + j*S == 1 );
                  //     Actually, have a family of solutions:
                  for(int m=0; m<5; ++m){
                    RT_ASSERT( (k+m*(S/g)) * D  + (j-m*(D/g)) * S == g );
                  }
                  //     and we want the one with k in [0,S/g)
                  RT_ASSERT( k < S/g );
                  //if( k < 0 ) k += (-k / (S/g));
                  if( k < 0 ){
                      int mk = (-k / (S/g)) + 1;
                      print(0," k=%d, mk=%d S/g=%d", k, mk, S/g);
                      k += mk * (S/g);
                      j -= mk * (D/g);
                      print(0," k'=%d, j'=%d", k, j);
                      RT_ASSERT( k*D + j*S == 1 );
                      RT_ASSERT( k >= 0 );
                      RT_ASSERT( k < S/g );
                  }
                  print(0,"%c",'\n');
                  // n RT_ASSERT( k < S/g );  // might be higher to force oh into range
                  //   3. multiply by R       (kR)D + (jR)S == R
                  //      and then by gcd_h   (kX)DH + (jX)SH = X
                  //      Adjust to desired soln...
                  k *= X;
                  j *= X;
                  RT_ASSERT( k*DH + j*SH == X );
                  print(0," [k=%d]*%d+[j=%d]*%d=[X=%d]", k,DH, j,SH, X);
                  // Adjust to lowest k>=0
                  {
                      RT_ASSERT( k > 0 );
                      int mk = k / (SH/gcd_h);
                      k -= mk * (SH/gcd_h);
                      j += mk * (DH/gcd_h);
                      print(0," [**k**=%d]*%d+[j=%d]*%d=[X=%d]", k,DH, j,SH, X);
                  }
                  RT_ASSERT( k*DH + j*SH == X ); // still have a soln
                  RT_ASSERT( k >= 0 && k < SH/gcd_h );
                  // now adjust j downwards st. j*SH < OH*SH (k can go up even more)
                  if( j >= OH ){
                      int mj = (j-OH) / (DH/gcd_h) + 1;
                      print(0," j=%d, mj=%d SH/gcd_h=%d", j, mj, SH/gcd_h);
                      k += mj * (SH/gcd_h);
                      j -= mj * (DH/gcd_h);
                      print(0," k'=%d, **j'**=%d", k, j);
                      print(0," [k=%d]*%d+[**j**=%d]*%d=[X=%d]", k,DH, j,SH, X);
                      RT_ASSERT( j < OH );
                      RT_ASSERT( j >= OH - (DH/gcd_h) );
                  }
                  RT_ASSERT( k*DH + j*SH == X ); // still have a soln
                  RT_ASSERT( j*SH < OH*SH );

                  //   4. identify solutions to original problem
                  //      kX   (and jX)
                  print(0, "g,R,X=%d,%d,%d", g, R,X);
                  print(0,"%c",'\n');
                  if( kh_beg < kh_end ) RT_ASSERT( k == kh_beg );
                }
              }
#elif 0// try to "guess" things   --- no way!
#endif
            }
#endif
            if( kh_beg >= kh_end ) continue;

            int kw_beg, /*ow_beg,*/ kw_end;
            kw_end = (iw + p->pw) / (p->dw+1) + 1;
            if (kw_end > p->kw) kw_end = p->kw;
            kw_beg = div_floor( (iw + p->pw) - p->ow*p->sw, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
              int owxsw = iw+p->pw - kw_beg * (p->dw+1);
              if (owxsw % p->sw){
                do {
                  ++kw_beg;
                  owxsw = iw+p->pw - kw_beg * (p->dw+1);
                } while( owxsw % p->sw != 0 && kw_beg < kw_end );
                DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
              }
            }
            DMUST( kw_beg >= 0 );
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
#elif 0 // use single extendedEuclid call (step 1)
  int const KH = p->kh;
  int const OH = p->oh;
  int const DH = p->dh + 1;
  int const SH = p->sh;
  int const PH = p->ph;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = lcm( SH, DH ); // = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  RT_ASSERT( khh == SH / gcd(SH,DH) );
  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  RT_ASSERT( hg == gcd_h );
  print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
  int const DW = p->dw + 1;
  int const SW = p->sw;
  int const OW = p->ow;
  int const PW = p->pw;
  const int lcm_w = lcm( SW, DW );
  const int kww = lcm_w / DW;
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_end = (ih + PH) / DH + 1;
            if (kh_end > KH) kh_end = KH;
            int kh_beg = div_floor( (ih + PH) - OH*SH, DH) + 1;
            if (kh_beg < 0 ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+PH - kh_beg * DH;
              if (ohxsh % SH){
                do {
                  ++kh_beg;
                  ohxsh = ih+PH - kh_beg * DH;
                } while( ohxsh % SH != 0 && kh_beg < kh_end );
                DMUST( kh_beg >= kh_end || (ih+PH - kh_beg * DH) % SH == 0 );
              }
            }
            DMUST( kh_beg >= 0 );

            // soln existence check:
            if( (ih+PH) % gcd_h != 0 ) RT_ASSERT( kh_beg >= kh_end );
#if 1
            if(g==0 && mb==0 && ic==0 && iw==0) {
#if 1 // via equations
              /* problem: Find the lowest khb >= kh_beg such that
               *          osh = ih+PH - khb*DH
               *      AND osh % SH == 0.            i.e. osh = j*SH
               *          (Then oh_beg = osh / SH)
               * Diophantine: solve for unknown integers k,j ...
               *    k*DH + j*SH = X,     where X = ih+PH
               */
              int X = ih+PH;
              // Does a solution exist?
              //   If gcd(DH,SH) divides X, then yes
              if( X % gcd_h != 0 ){
                  RT_ASSERT( kh_beg >= kh_end );
                  kh_beg = kh_end;
              }else{
                // Find any solution, in simplest possible way.
                //int khb = 0;
                // Approx solution for kh_beg without modulo constraint:
                ///int khb = div_floor( ih + PH - OH*SH, DH) + 1;
                ///if (khb < 0    ) khb = 0;
                int khb = 0;
                // Check if khb solves the problem:
                int osh = ih+PH - khb * DH;
                if (osh % p->sh != 0) // ok
                { // move khb upward to exact soln
                  int ohxsh = ih+PH - kh_beg * DH;
                  print(0," kh_beg,ohxsh=%d,%d khb=%d X=%d",kh_beg,ohxsh, khb, X);
                  int X = ih+PH - khb*DH;
                  RT_ASSERT( X % SH != 0 );
#if 0
                  int const D = DH/gcd_h;
                  int const S = SH/gcd_h;
                  int const R = X /gcd_h;  // must evenly divide for soln to exist
                  //      now have equn k*D + j*S = R where gcd(D,S) is 1
                  //   2. solve k*D + j*S = 1
                  RT_ASSERT( gcd(D,S) == 1 );
                  int k, j, g;
                  extendedEuclid( k, D, j, S, g);
                  RT_ASSERT( k*gcd_h == ha );
                  RT_ASSERT( j*gcd_h == hb );
                  RT_ASSERT( g*gcd_h == hg );
                  if( gcd_h > 1 ) print(0," extendedEuclid: %d * [D=%d] + %d * [S=%d] = %d[gcd(D,S)]", k,D, j,S, g);
                  //RT_ASSERT( g = gcd_h/gcd_h );
                  RT_ASSERT(g==1);
                  RT_ASSERT( k*D + j*S == 1 );
                  //     Actually, have a family of solutions:
                  for(int m=0; m<5; ++m){
                    RT_ASSERT( (k+m*(S/g)) * D  + (j-m*(D/g)) * S == g );
                  }
                  //     and we want the one with k in [0,S/g)
                  RT_ASSERT( k < S/g );
#if 0 // I'll do this adjustment later ...
                  //if( k < 0 ) k += (-k / (S/g));
                  if( k < 0 ){
                      int mk = (-k / (S/g)) + 1;
                      print(0," k=%d, mk=%d S/g=%d", k, mk, S/g);
                      k += mk * (S/g);
                      j -= mk * (D/g);
                      print(0," k'=%d, j'=%d", k, j);
                      RT_ASSERT( k*D + j*S == 1 );
                      RT_ASSERT( k >= 0 );
                      RT_ASSERT( k < S/g );
                  }
#endif
                  print(0,"%c",'\n');
                  // n RT_ASSERT( k < S/g );  // might be higher to force oh into range
                  //   3. multiply by R       (kR)D + (jR)S == R
                  //      and then by gcd_h   (kX)DH + (jX)SH = X
                  //      Adjust to desired soln...
                  k *= X;
                  j *= X;
                  int const mul = X / gcd_h;
                  RT_ASSERT( k == ha * mul );
                  RT_ASSERT( j == hb * mul );
#else
                  RT_ASSERT( ha*DH + hb*SH == gcd_h );
                  int const mul = X / gcd_h;
                  int k = ha*mul;
                  int j = hb*mul;
                  RT_ASSERT( k*DH + j*SH == X );
#endif
                  RT_ASSERT( k*DH + j*SH == X );
                  print(0," [k=%d]*%d+[j=%d]*%d=[X=%d]", k,DH, j,SH, X);
                  // Adjust to lowest k>=0
                  if( k < 0 ){
                      int mk = (-k) / (SH/gcd_h) + 1;
                      k += mk * (SH/gcd_h);
                      j -= mk * (DH/gcd_h);
                      print(0," [**k**=%d]*%d+[j=%d]*%d=[X=%d]", k,DH, j,SH, X);
                  }else if( k >= SH/gcd_h ) {
                      int mk = k / (SH/gcd_h);
                      k -= mk * (SH/gcd_h);
                      j += mk * (DH/gcd_h);
                      print(0," [**k**=%d]*%d+[j=%d]*%d=[X=%d]", k,DH, j,SH, X);
                  }
                  RT_ASSERT( k*DH + j*SH == X ); // still have a soln
                  RT_ASSERT( k >= 0 && k < SH/gcd_h );
                  // now adjust j downwards st. j*SH < OH*SH (k can go up even more)
                  if( j >= OH ){
                      int mj = (j-OH) / (DH/gcd_h) + 1;
                      print(0," j=%d, mj=%d SH/gcd_h=%d", j, mj, SH/gcd_h);
                      k += mj * (SH/gcd_h);
                      j -= mj * (DH/gcd_h);
                      print(0," k'=%d, **j'**=%d", k, j);
                      print(0," [k=%d]*%d+[**j**=%d]*%d=[X=%d]", k,DH, j,SH, X);
                      RT_ASSERT( j < OH );
                      RT_ASSERT( j >= OH - (DH/gcd_h) );
                  }
                  RT_ASSERT( k*DH + j*SH == X ); // still have a soln
                  RT_ASSERT( j*SH < OH*SH );

                  //   4. identify solutions to original problem
                  //      kX   (and jX)
                  print(0,"%c",'\n');
                  if( kh_beg < kh_end ) RT_ASSERT( k == kh_beg );
                }else{
                  // this case is still TBD
                  int ohxsh = ih+PH - kh_beg * DH;
                  print(0,"%% kh_beg,kh_end=%d,%d ohxsh=%d khb=%d",kh_beg,kh_end,ohxsh,khb);
                  if( kh_beg < kh_end && khb != kh_beg) print(0," %s", "<---------");
#if 0
                  if( kh_beg < kh_end ) RT_ASSERT( khb == kh_beg );
#if 1
                  khb = div_floor( ih + PH - OH*SH, DH) + 1;
                  int osh = ih+PH - khb * DH;
                  RT_ASSERT( osh % p->sh == 0 );
                  RT_ASSERT( osh/p->sh < p->oh );
                  if( kh_beg < kh_end ) RT_ASSERT( khb == kh_beg );
#endif
                  print(0,"%c",'\n');
#endif
                }
              }
#elif 0// try to "guess" things   --- no way!
#endif
            }
#endif
            if( kh_beg >= kh_end ) continue;

            int kw_beg, /*ow_beg,*/ kw_end;
            kw_end = (iw + p->pw) / (p->dw+1) + 1;
            if (kw_end > p->kw) kw_end = p->kw;
            kw_beg = div_floor( (iw + p->pw) - p->ow*p->sw, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
              int owxsw = iw+p->pw - kw_beg * (p->dw+1);
              if (owxsw % p->sw){
                do {
                  ++kw_beg;
                  owxsw = iw+p->pw - kw_beg * (p->dw+1);
                } while( owxsw % p->sw != 0 && kw_beg < kw_end );
                DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
              }
            }
            DMUST( kw_beg >= 0 );
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
#elif 0 // use single extendedEuclid call (step 2) and handle all cases
  int const KH = p->kh;
  int const OH = p->oh;
  int const DH = p->dh + 1;
  int const SH = p->sh;
  int const PH = p->ph;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = lcm( SH, DH ); // = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  RT_ASSERT( khh == SH / gcd(SH,DH) );
  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  RT_ASSERT( hg == gcd_h );
  print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
  int const DW = p->dw + 1;
  int const SW = p->sw;
  int const OW = p->ow;
  int const PW = p->pw;
  const int lcm_w = lcm( SW, DW );
  const int kww = lcm_w / DW;
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_end = (ih + PH) / DH + 1;
            if (kh_end > KH) kh_end = KH;
            int kh_beg = div_floor( (ih + PH) - OH*SH, DH) + 1;
            if (kh_beg < 0 ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+PH - kh_beg * DH;
              if (ohxsh % SH){
                do {
                  ++kh_beg;
                  ohxsh = ih+PH - kh_beg * DH;
                } while( ohxsh % SH != 0 && kh_beg < kh_end );
                DMUST( kh_beg >= kh_end || (ih+PH - kh_beg * DH) % SH == 0 );
              }
            }
            DMUST( kh_beg >= 0 );

            // soln existence check:
            if( (ih+PH) % gcd_h != 0 ) RT_ASSERT( kh_beg >= kh_end );
#if 1
            if(g==0 && mb==0 && ic==0 && iw==0) {
              // via equations
              /* problem: Find the lowest khb >= kh_beg such that
               *          osh = ih+PH - khb*DH
               *      AND osh % SH == 0.            i.e. osh = j*SH
               *          (Then oh_beg = osh / SH)
               * Diophantine: solve for unknown integers k,j ...
               *    k*DH + j*SH = X,     where X = ih+PH
               */
              int X = ih+PH;
              // Does a solution exist?
              //   If gcd(DH,SH) divides X, then yes
              if( X % gcd_h != 0 ){
                  RT_ASSERT( kh_beg >= kh_end );
                  kh_beg = kh_end;
              }else{
                // Find any solution, in simplest possible way.
                //int khb = 0;
                // Approx solution for kh_beg without modulo constraint:
                ///int khb = div_floor( ih + PH - OH*SH, DH) + 1;
                ///if (khb < 0    ) khb = 0;
                int khb = 0;
                // Check if khb solves the problem:
                int osh = ih+PH - khb * DH;
                //if (osh % p->sh != 0) // ok, somewhat simpler code
                // now all cases are handled ..............
                { // find a soln, and move khb up/down to match range constraints
                  int ohxsh = ih+PH - kh_beg * DH;
                  print(0," kh_beg,ohxsh=%d,%d khb=%d X=%d",kh_beg,ohxsh, khb, X);
                  int X = ih+PH - khb*DH;
                  // out-of-loop extendedEuclid --> one soln of k*DH + j*SH = X
                  RT_ASSERT( ha*DH + hb*SH == gcd_h );
                  RT_ASSERT( X % gcd_h == 0 ); // precondition for soln existence
                  int const mul = X / gcd_h;
                  int k = ha*mul;
                  int j = hb*mul;

                  RT_ASSERT( k*DH + j*SH == X );
                  print(0," [k=%d]*%d+[j=%d]*%d=[X=%d]", k,DH, j,SH, X);

                  // Adjust to lowest k>=0
                  int m = 0;
                  int const dk = SH/gcd_h;
                  int const dj = DH/gcd_h;
                  print(0," dk,dj=%d,%d", SH/gcd_h, DH/gcd_h);
                  if( k < 0 ){
                      m = (-k+ dk -1) / dk; // now also handles exact-modulus case
                  }else if( k >= SH/gcd_h ) {
                      m = - (k / dk);
                  }
                  k += m * dk;
                  j -= m * dj;
                  print(0," m=%d [**k**=%d]*%d+[j=%d]*%d=[X=%d]", m, k,DH, j,SH, X);
                  RT_ASSERT( k >= 0 );
                  RT_ASSERT( k < dk );
                  RT_ASSERT( k*DH + j*SH == X ); // still have a soln

                  // now adjust j downwards st. j*SH < OH*SH (k can go up even more)
                  if( j >= OH ){
                      m = (j-OH) / dj + 1;
                      k += m * dk;
                      j -= m * dj;
                      print(0," k'=%d, **j'**=%d", k, j);
                      print(0," [k=%d]*%d+[**j**=%d]*%d=[X=%d]", k,DH, j,SH, X);
                      RT_ASSERT( j < OH );
                      RT_ASSERT( j >= OH - (DH/gcd_h) );
                  }
                  RT_ASSERT( k*DH + j*SH == X ); // still have a soln
                  RT_ASSERT( j*SH < OH*SH );

                  //   4. identify solutions to original problem
                  //      kX   (and jX)
                  print(0,"%c",'\n');
                  if( kh_beg < kh_end ) RT_ASSERT( k == kh_beg );
                }
              }
            }
#endif
            if( kh_beg >= kh_end ) continue;

            int kw_beg, /*ow_beg,*/ kw_end;
            kw_end = (iw + p->pw) / (p->dw+1) + 1;
            if (kw_end > p->kw) kw_end = p->kw;
            kw_beg = div_floor( (iw + p->pw) - p->ow*p->sw, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
              int owxsw = iw+p->pw - kw_beg * (p->dw+1);
              if (owxsw % p->sw){
                do {
                  ++kw_beg;
                  owxsw = iw+p->pw - kw_beg * (p->dw+1);
                } while( owxsw % p->sw != 0 && kw_beg < kw_end );
                DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
              }
            }
            DMUST( kw_beg >= 0 );
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
#elif 0 // remove printing, check equiv for all cases
  int const KH = p->kh;
  int const OH = p->oh;
  int const DH = p->dh + 1;
  int const SH = p->sh;
  int const PH = p->ph;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = lcm( SH, DH ); // = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  RT_ASSERT( khh == SH / gcd(SH,DH) );
  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  RT_ASSERT( hg == gcd_h );
  print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
  int const DW = p->dw + 1;
  int const SW = p->sw;
  int const OW = p->ow;
  int const PW = p->pw;
  const int lcm_w = lcm( SW, DW );
  const int kww = lcm_w / DW;
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_end = (ih + PH) / DH + 1;
            if (kh_end > KH) kh_end = KH;
            int kh_beg = div_floor( (ih + PH) - OH*SH, DH) + 1;
            if (kh_beg < 0 ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+PH - kh_beg * DH;
              if (ohxsh % SH){
                do {
                  ++kh_beg;
                  ohxsh = ih+PH - kh_beg * DH;
                } while( ohxsh % SH != 0 && kh_beg < kh_end );
                DMUST( kh_beg >= kh_end || (ih+PH - kh_beg * DH) % SH == 0 );
              }
            }
            DMUST( kh_beg >= 0 );

            // soln existence check:
            if( (ih+PH) % gcd_h != 0 ) RT_ASSERT( kh_beg >= kh_end );
#if 1
            //if(g==0 && mb==0 && ic==0 && iw==0) {
              int X = ih+PH;
              int k;
              if( X % gcd_h != 0 ){ // Does a solution exist?
                  k = kh_end;
              }else{
                // Find any solution, in simplest possible way.
                int khb = 0;
                { // find a soln, and move khb up/down to match range constraints
                  int X = ih+PH;
                  int const mul = X / gcd_h;
                  k = ha*mul;
                  int j = hb*mul;
                  RT_ASSERT( k*DH + j*SH == X );

                  // Adjust to lowest k>=0
                  int const dk = SH/gcd_h;
                  int const dj = DH/gcd_h;
                  int m = (k<0? (-k+ dk -1) / dk
                          : k >= dk? - (k / dk)
                          : 0);
                  k += m * dk;
                  j -= m * dj;
                  RT_ASSERT( k >= 0 && k < dk);
                  RT_ASSERT( k*DH + j*SH == X ); // still have a soln

                  // now adjust j downwards st. j*SH < OH*SH (k can go up even more)
                  if( j >= OH ){
                      m = (j-OH) / dj + 1;
                      k += m * dk;
                      j -= m * dj;
                      RT_ASSERT( j < OH );
                      RT_ASSERT( j >= OH - (DH/gcd_h) );
                      RT_ASSERT( k*DH + j*SH == X ); // still have a soln
                  }
                  RT_ASSERT( j*SH < OH*SH );

                  //   4. identify solutions to original problem
                  //      kX   (and jX)
                  if( kh_beg < kh_end ) RT_ASSERT( k == kh_beg );
                }
              }
            //}
            if( kh_beg < kh_end ) RT_ASSERT( k == kh_beg );
            else                  RT_ASSERT( k >= kh_end );
#endif
            if( kh_beg >= kh_end ) continue;

            int kw_beg, /*ow_beg,*/ kw_end;
            kw_end = (iw + p->pw) / (p->dw+1) + 1;
            if (kw_end > p->kw) kw_end = p->kw;
            kw_beg = div_floor( (iw + p->pw) - p->ow*p->sw, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
              int owxsw = iw+p->pw - kw_beg * (p->dw+1);
              if (owxsw % p->sw){
                do {
                  ++kw_beg;
                  owxsw = iw+p->pw - kw_beg * (p->dw+1);
                } while( owxsw % p->sw != 0 && kw_beg < kw_end );
                DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
              }
            }
            DMUST( kw_beg >= 0 );
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
#elif 0 // replace w/ new kh limit calc (no looping)
  int const KH = p->kh;
  int const OH = p->oh;
  int const DH = p->dh + 1;
  int const SH = p->sh;
  int const PH = p->ph;
  const int gcd_h = gcd( SH, DH );
  const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
  const int khh = lcm_h / DH;
  RT_ASSERT( khh == SH / gcd(SH,DH) );
  const int jhh = lcm_h / SH;

  int ha, hb, hg;
  extendedEuclid( ha, DH, hb, SH, hg);
  RT_ASSERT( hg == gcd_h );
  print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
  int const DW = p->dw + 1;
  int const SW = p->sw;
  int const OW = p->ow;
  int const PW = p->pw;
  const int lcm_w = lcm( SW, DW );
  const int kww = lcm_w / DW;
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;

            int kh_end = (ih + PH) / DH + 1;
            if (kh_end > KH) kh_end = KH;
            int kh_beg;
#if 0
            kh_beg = div_floor( (ih + PH) - OH*SH, DH) + 1;
            if (kh_beg < 0 ) kh_beg = 0;
            { // jump kh_beg up to 1st non-skipped index
              int ohxsh = ih+PH - kh_beg * DH;
              if (ohxsh % SH){
                do {
                  ++kh_beg;
                  ohxsh = ih+PH - kh_beg * DH;
                } while( ohxsh % SH != 0 && kh_beg < kh_end );
                DMUST( kh_beg >= kh_end || (ih+PH - kh_beg * DH) % SH == 0 );
              }
            }
            DMUST( kh_beg >= 0 );
#else
            int k = kh_end;
            if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
              // 1. Find one soln (any)
              //int X = ih+PH;
              int const mul = (ih+PH) / gcd_h;
              k = ha*mul;
              int j = hb*mul;
              //DMUST( k*DH + j*SH == X );

              // 2. Adjust to lowest k>=0
              int const dk = SH/gcd_h;
              int const dj = DH/gcd_h;
              RT_ASSERT( dk == khh && dj == jhh );
              int m = (k<0? (-k+ dk -1) / dk
                  : k >= dk? - (k / dk)
                  : 0);
              if(m){
                k += m * dk;
                j -= m * dj;
              }
              //DMUST( k >= 0 && k < dk);
              //DMUST( k*DH + j*SH == X ); // still have a soln

              // 3. Adjust j downwards st. j*SH < OH*SH (k can go up even more)
              if( j >= OH ){
                m = (j-OH) / dj + 1;
                k += m * dk;
                j -= m * dj;
                //DMUST( j < OH );
                //DMUST( j >= OH - (DH/gcd_h) );
                //DMUST( k*DH + j*SH == X ); // still have a soln
              }
              //DMUST( j*SH < OH*SH );
            }
            //}
            //if( kh_beg < kh_end ) RT_ASSERT( k == kh_beg );
            //else                  RT_ASSERT( k >= kh_end );
            kh_beg = k;
#endif
            if( kh_beg >= kh_end ) continue;

            int kw_beg, /*ow_beg,*/ kw_end;
            kw_end = (iw + p->pw) / (p->dw+1) + 1;
            if (kw_end > p->kw) kw_end = p->kw;
            kw_beg = div_floor( (iw + p->pw) - p->ow*p->sw, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
              int owxsw = iw+p->pw - kw_beg * (p->dw+1);
              if (owxsw % p->sw){
                do {
                  ++kw_beg;
                  owxsw = iw+p->pw - kw_beg * (p->dw+1);
                } while( owxsw % p->sw != 0 && kw_beg < kw_end );
                DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
              }
            }
            DMUST( kw_beg >= 0 );
            if( kw_beg >= kw_end ) continue;

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
#elif 0 // shorten, do same for kw,ow loop. tweaks to kh calc
  int const KH = p->kh;
  int const OH = p->oh;
  int const DH = p->dh + 1;
  int const SH = p->sh;
  int const PH = p->ph;
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
  int const SW = p->sw;
  int const OW = p->ow;
  int const PW = p->pw;
  const int gcd_w = gcd( SW, DW );
  //const int lcm_w = lcm( SW, DW );
  const int lcm_w = SW * DW/gcd_w;
  const int kww = lcm_w / DW;
  const int jww = lcm_w / SW;
  int wa, wb, wg;
  extendedEuclid( wa, DW, wb, SW, wg);
  DMUST( wg == gcd_w );
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
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
            kw_end = (iw + p->pw) / (p->dw+1) + 1;
            if (kw_end > p->kw) kw_end = p->kw;
            kw_beg = div_floor( (iw + p->pw) - p->ow*p->sw, p->dw+1) + 1;
            if (kw_beg < 0    ) kw_beg = 0;
            { // jump kw_beg up to 1st non-skipped index
              int owxsw = iw+p->pw - kw_beg * (p->dw+1);
              if (owxsw % p->sw){
                do {
                  ++kw_beg;
                  owxsw = iw+p->pw - kw_beg * (p->dw+1);
                } while( owxsw % p->sw != 0 && kw_beg < kw_end );
                DMUST( kw_beg >= kw_end || (iw+p->pw - kw_beg * (p->dw+1)) % p->sw == 0 );
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

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
  int const KH = p->kh;
  int const OH = p->oh;
  int const DH = p->dh + 1;
  int const SH = p->sh;
  int const PH = p->ph;
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
  int const SW = p->sw;
  int const OW = p->ow;
  int const PW = p->pw;
  const int gcd_w = gcd( SW, DW );
  //const int lcm_w = lcm( SW, DW );
  const int lcm_w = SW * DW/gcd_w;
  const int kww = lcm_w / DW;
  const int jww = lcm_w / SW;
  int wa, wb, wg;
  extendedEuclid( wa, DW, wb, SW, wg);
  DMUST( wg == gcd_w );
  # pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          // calc kh_beg, kh_end here? 4.28x
          for (int iw = 0; iw < p->iw; ++iw) {
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

            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              for (int kh = kh_beg, oh0=ih+p->ph - kh_beg*(p->dh+1) ;
                  kh < kh_end;
                  oh0 -= lcm_h, kh += khh)
              {
                for (int kw = kw_beg, ow0=iw+p->pw - kw_beg*(p->dw+1) ;
                    kw < kw_end;
                    ow0 -= lcm_w, kw += kww)
                {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh0/p->sh, ow0/p->sw);
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
              int oh_beg = (ih+p->ph - kh_beg * (p->dh+1)) / p->sh;
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
                if( ohsh % SH == 0 && kh_beg < kh_end ) RT_ASSERT( ohsh == oh_beg * p->sh );
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

#elif 1 // kw_beg, oh_end loop ---> calculation (debug)
  //  MOVED to separate routine
  refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);

#elif 0 // regr 4.07x 4.17x
  // + dilates: 1.90x
#if 1 // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    return;
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
    RT_ASSERT(p->sh > 0 );
    RT_ASSERT(p->dh == 0);
    //bool const s0 = kh_beg >= kh_end || p->sh <= 1; // this IMPLIES skips remains 0
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      // next: loop over allowed oh values, THEN over kh
      int const khh = p->sh; // only for p->dh==0 !!!
      for (int kh = kh_beg; kh < kh_end; kh+=p->sh) { /// XXX increment maybe gcm(sh,dh+1) ?
        int oh = ih+p->ph - kh /* * (p->dh + 1) */; // loop vars: kh, ih
        RT_ASSERT( oh>=0 && oh % p->sh==0 ); 
        oh /= p->sh;
        RT_ASSERT( oh < p->oh );

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

#   pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
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
            RT_ASSERT( kh_beg >= 0 );
            // no RT_ASSERT( kh_beg % p->sh == 0 );
            RT_ASSERT( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );

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

#elif 0 // specialize to p->dh, p->dw == 0
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    //refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

  auto ker = [](
      const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &wei_m,
      float &ds, int g, int mb, int ic, int ih, int iw
      , const int kh_beg, const int kh_end
      , const int kw_beg, const int kw_end
      ) {
    RT_ASSERT(p->sh > 0 );
    RT_ASSERT(p->dh == 0);
    //bool const s0 = kh_beg >= kh_end || p->sh <= 1; // this IMPLIES skips remains 0
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      // next: loop over allowed oh values, THEN over kh
      int const khh = p->sh; // only for p->dh==0 !!!
      for (int kh = kh_beg; kh < kh_end; kh+=khh) { /// XXX increment maybe gcm(sh,dh+1) ?
        int oh = ih+p->ph - kh /* * (p->dh + 1) */; // loop vars: kh, ih
        RT_ASSERT( oh>=0 && oh % p->sh==0 ); 
        oh /= p->sh;
        RT_ASSERT( oh < p->oh );

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
            RT_ASSERT(oh_beg/p->sh <  p->oh);
            //NO RT_ASSERT( oh_beg % p->sh == (ih+p->ph) % p->sh );
            if ((oh_beg % p->sh)){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg /* * (p->dh+1) */;
                RT_ASSERT( oh_beg >= 0 );
                RT_ASSERT(oh_beg/p->sh <  p->oh);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
            }
            oh_beg /= p->sh;
          }
          RT_ASSERT( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );
#if 1
          oh_beg = ih+p->ph - kh_beg;
          RT_ASSERT( oh_beg == ih+p->ph - kh_beg ); // hi limit
          RT_ASSERT( oh_beg >= 0 );

          int khb2 =            (ih + p->ph) - p->oh*p->sh              + 1;
          if (khb2 < 0) khb2 = 0;
#if 0
          int ohb2 = ih+p->ph - kh_beg;       // <-- cheating !!!
          int ohb2s = (ohb2) / p->sh * p->sh; // ohb2 rounded DOWN to mult of p->sh
#else
          int ohb2 = ih+p->ph - khb2;
          int ohb2s = (ohb2) / p->sh * p->sh; // ohb2 rounded DOWN to mult of p->sh
#endif

          // test ohb2s calc:
          int khb2s = 0;
          if (kh_beg < kh_end && ohb2s != oh_beg )
          {
              printf("ohb2: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                      ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
              exit(0);
          }
          RT_ASSERT( kh_beg >= kh_end || ohb2s == oh_beg );

          if( kh_beg < kh_end ){
              khb2s =  (ih+p->ph) - ohb2s;
              if( khb2s != kh_beg )
              {
                  print(0,"khb2s: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                          ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
                  exit(0);
              }
              RT_ASSERT( kh_beg == khb2s );
          }
          RT_ASSERT( ohb2s <= oh_beg );

          khb2s = (ih + p->ph) - ohb2s;
          RT_ASSERT( khb2s >= 0 );
          //if( khb2s < 0 ) khb2s = 0;
          if( kh_beg < kh_end ) RT_ASSERT( khb2s == kh_beg );
          else                  RT_ASSERT( khb2s >= kh_end );
#elif 1 // wrong?
#if 0 // would need more careful calc.
          int oh_end = ih+p->ph - kh_end;
          if (!( (kh_beg >= kh_end) == (oh_beg <= oh_end) )){
              printf(" [kh_beg=%d] cf. [kh_end=%d], but oh_beg=%d, oh_end=%d\n",
                      kh_beg, kh_end, oh_beg, oh_end );
              exit(0);
          }
#endif
#if 1
          int khb2 = div_floor(ih + p->ph + 1 , p->sh) - p->oh;
          if (khb2 < 0) khb2 = 0;
          int khb2s = khb2 * p->sh;
          RT_ASSERT( khb2s >= kh_end || khb2s % p->sh == 0 );
#elif 1
          int khb2 = ih+p->ph + 1 - p->oh*p->sh;
          if (khb2 < 0) khb2 = 0;
          int khb2s = (khb2+p->sh-1)/p->sh *p->sh;
#endif
          int ohb2 = ih+p->ph - khb2s;
          RT_ASSERT( ohb2 >= 0 );
          if (ohb2 < 0) ohb2 = 0;
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
          RT_ASSERT( khb2 >= 0 );
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

#else
          //  oh_beg = (ih+p->ph - kh_beg)/p->sh ~  (ih+p->ph -  ((ih+p->ph) - p->oh*p->sh + 1))/p->sh
          //             = (p->oh * p->sh + 1)/p->sh ???
          //int ohb2 = (p->oh * p->sh + 1) / p->sh;
          //int khb2 = (ih+p->ph)/p->sh - ohb2s;
          //if (khb2 < 0) khb2 = 0;
          //int khb2s = khb2 * p->sh;
          //int ohb2s = ((ih+p->ph) - khb2s) / p->sh;
          //
          int ohb2 = div_floor(p->oh + p->sh - 1, p->sh);
          if( ohb2 < 0 ) ohb2 = 0;
          //ohb2 = p->oh*p->sh;
          int ohb2s = ohb2 * p->sh;
          print(0," oh_beg=%d ohb2=%d ohb2s=%d\n",oh_beg,ohb2, ohb2s);
          RT_ASSERT( ohb2s == oh_beg );
#endif
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
#if 0
              ker( p, diff_dst_m, wei_m,
                  ds, g, mb, ic, ih, iw
                  , kh_beg, kh_end, kw_beg, kw_end
                 );
#else
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
#endif
            }
          }
        }
      }
    }
  }
#elif 0 // remove kernel [again?] and some dead code and unused debug prints
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    //refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
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
            RT_ASSERT(oh_beg/p->sh <  p->oh);
            //NO RT_ASSERT( oh_beg % p->sh == (ih+p->ph) % p->sh );
            if ((oh_beg % p->sh)){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg /* * (p->dh+1) */;
                RT_ASSERT( oh_beg >= 0 );
                RT_ASSERT(oh_beg/p->sh <  p->oh);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
            }
            oh_beg /= p->sh;
          }
          RT_ASSERT( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );

          oh_beg = ih+p->ph - kh_beg;
          RT_ASSERT( oh_beg == ih+p->ph - kh_beg ); // hi limit
          RT_ASSERT( oh_beg >= 0 );

          int khb2 =            (ih + p->ph) - p->oh*p->sh              + 1;
          if (khb2 < 0) khb2 = 0;
          int ohb2 = ih+p->ph - khb2;
          int ohb2s = (ohb2) / p->sh * p->sh; // ohb2 rounded DOWN to mult of p->sh

          // test ohb2s calc:
          int khb2s = 0;
          if (kh_beg < kh_end && ohb2s != oh_beg )
          {
              printf("ohb2: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                      ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
              exit(0);
          }
          RT_ASSERT( kh_beg >= kh_end || ohb2s == oh_beg );

          if( kh_beg < kh_end ){
              khb2s =  (ih+p->ph) - ohb2s;
              if( khb2s != kh_beg )
              {
                  print(0,"khb2s: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                          ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
                  exit(0);
              }
              RT_ASSERT( kh_beg == khb2s );
          }
          RT_ASSERT( ohb2s <= oh_beg );

          khb2s = (ih + p->ph) - ohb2s;
          RT_ASSERT( khb2s >= 0 );
          //if( khb2s < 0 ) khb2s = 0;
          if( kh_beg < kh_end ) RT_ASSERT( khb2s == kh_beg );
          else                  RT_ASSERT( khb2s >= kh_end );

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
            if (kh_beg < kh_end && kw_beg < kw_end) {
              //DPRINTF(".");
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                // next: loop over allowed oh values, THEN over kh
                //int const khh = p->sh; // only for p->dh==0 !!!
                for (int kh = kh_beg; kh < kh_end; kh+=p->sh) {
                  const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;
                  //int const kww = p->sw; // perhaps lcd of p-sh and p->dh+1 ? XXX
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
#elif 0 // remove kernel [again?] and some dead code and unused debug prints
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    //refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          kh_end =            (ih + p->ph) - 0                        + 1;
          if (kh_end > p->kh) kh_end = p->kh;
#if 0
          kh_beg =            (ih + p->ph) - p->oh*p->sh              + 1;
          if (kh_beg < 0    ) kh_beg = 0;
          int oh_beg;
          { // jump kh_beg up to 1st non-skipped index
            //int oh_beg = ih+p->ph - kh_beg * (p->dh+1); // must always be a mult of p->sh
            oh_beg = ih+p->ph - kh_beg; // must always be a mult of p->sh
            RT_ASSERT( oh_beg >= 0 );
            RT_ASSERT(oh_beg/p->sh <  p->oh);
            //NO RT_ASSERT( oh_beg % p->sh == (ih+p->ph) % p->sh );
            if ((oh_beg % p->sh)){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg /* * (p->dh+1) */;
                RT_ASSERT( oh_beg >= 0 );
                RT_ASSERT(oh_beg/p->sh <  p->oh);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
            }
            oh_beg /= p->sh;
          }
          RT_ASSERT( kh_beg >= kh_end || (ih+p->ph - kh_beg * (p->dh+1)) % p->sh == 0 );

          oh_beg = ih+p->ph - kh_beg;
          RT_ASSERT( oh_beg == ih+p->ph - kh_beg ); // hi limit
          RT_ASSERT( oh_beg >= 0 );

          int khb2 =            (ih + p->ph) - p->oh*p->sh              + 1;
          if (khb2 < 0) khb2 = 0;
          int ohb2 = ih+p->ph - khb2;
          int ohb2s = (ohb2) / p->sh * p->sh; // ohb2 rounded DOWN to mult of p->sh

          // test ohb2s calc:
          int khb2s = 0;
          if (kh_beg < kh_end && ohb2s != oh_beg )
          {
              printf("ohb2: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                      ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
              exit(0);
          }
          RT_ASSERT( kh_beg >= kh_end || ohb2s == oh_beg );

          if( kh_beg < kh_end ){
              khb2s =  (ih+p->ph) - ohb2s;
              if( khb2s != kh_beg )
              {
                  print(0,"khb2s: ih=%d p->ph=%d p->sh=%d p->oh=%d     kh_beg=%d khb2=%d khb2s=%d    oh_beg=%d ohb2=%d ohb2s=%d\n",
                          ih,p->ph,p->sh,p->oh,  kh_beg,khb2,khb2s, oh_beg,ohb2,ohb2s);
                  exit(0);
              }
              RT_ASSERT( kh_beg == khb2s );
          }
          RT_ASSERT( ohb2s <= oh_beg );

          khb2s = (ih + p->ph) - ohb2s;
          RT_ASSERT( khb2s >= 0 );
          //if( khb2s < 0 ) khb2s = 0;
          if( kh_beg < kh_end ) RT_ASSERT( khb2s == kh_beg );
          else                  RT_ASSERT( khb2s >= kh_end );
#elif 0 // remove some debug printout
          kh_beg =            (ih + p->ph) - p->oh*p->sh              + 1;
          if (kh_beg < 0    ) kh_beg = 0;
          int oh_beg;
          { // jump kh_beg up to 1st non-skipped index
            //int oh_beg = ih+p->ph - kh_beg * (p->dh+1); // must always be a mult of p->sh
            oh_beg = ih+p->ph - kh_beg; // must always be a mult of p->sh
            RT_ASSERT( oh_beg >= 0 );
            RT_ASSERT(oh_beg/p->sh <  p->oh);
            //NO RT_ASSERT( oh_beg % p->sh == (ih+p->ph) % p->sh );
            if ((oh_beg % p->sh)){
              // maybe I need a custom hoister here... the following is hard to patch
              do {
                ++kh_beg;
                oh_beg = ih+p->ph - kh_beg /* * (p->dh+1) */;
                RT_ASSERT( oh_beg >= 0 );
                RT_ASSERT(oh_beg/p->sh <  p->oh);
              } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
            }
            oh_beg /= p->sh;
          }
          oh_beg = ih+p->ph - kh_beg;
          RT_ASSERT( oh_beg == ih+p->ph - kh_beg ); // hi limit
          RT_ASSERT( oh_beg >= 0 );

          int khb2 = ih+p->ph + 1 - p->oh*p->sh;
          if (khb2 < 0) khb2 = 0;

          int ohb2 = ih+p->ph - khb2;
          int ohb2s = (ohb2) / p->sh * p->sh;
          RT_ASSERT( kh_beg >= kh_end || ohb2s == oh_beg );

          int khb2s = (ih + p->ph) - ohb2s;
          RT_ASSERT( khb2s >= 0 );
          if( kh_beg < kh_end ) RT_ASSERT( khb2s == kh_beg );
          else                  RT_ASSERT( khb2s >= kh_end );
#elif 0 // use second method (calc) and remove assertions
          int oh_beg;
          int khb2 = ih+p->ph + 1 - p->oh*p->sh;
          if (khb2 < 0) khb2 = 0;
          int ohb2 = ih+p->ph - khb2;
          int ohb2s = (ohb2) / p->sh * p->sh;

          int khb2s = (ih + p->ph) - ohb2s;
          kh_beg = khb2s;
          oh_beg = ohb2s;
#elif 0 // change variable names
          int khb2 = ih+p->ph + 1 - p->oh*p->sh;
          if (khb2 < 0) khb2 = 0;
          int ohb2 = ih+p->ph - khb2;
          int oh_beg = (ohb2) / p->sh * p->sh;
          kh_beg = (ih + p->ph) - oh_beg;
#elif 0 // elide variable
          {
              int khb2 = ih+p->ph + 1 - p->oh*p->sh;
              if (khb2 < 0) khb2 = 0;
              int ohb2 = ih+p->ph - khb2;
              kh_beg = (ih+p->ph) - ohb2 / p->sh * p->sh;
          }
#elif 0 // expand and derive a simplification (now BORKEN !)
          { // new.  With a derivation of the alternate calculation.
            int khb2 = ih+p->ph + 1 - p->oh*p->sh;
            if (khb2 < 0) khb2 = 0;
            int ohb2 = ih+p->ph - khb2;
            RT_ASSERT( ohb2 >= 0 );
            kh_beg = (ih+p->ph) - ohb2 / p->sh * p->sh;
            const int oh_beg = (ih+p->ph - kh_beg) / p->sh;
            // expand ohb2:
            //   kh_beg = (ih+p->ph) - (ih+p->ph - khb2) / p->sh * p->sh
            //          = A - (A-B) /C*C, for A>=0, B>=0, C>0
            //   kh_beg-B = (A-B) - (A-B)/C*C
            //            = (A-B) % C            ! rem_floor, if A-B<0
            // So
            //   kh_beg = khb2 + (ih+p->ph - khb2) % p->sh
            //          = khb2 + ohb2 % p->sh
            RT_ASSERT( kh_beg == khb2 + ohb2 % p->sh );

            // But khb2 = ih+p->ph+1-p->oh*p->sh, so
            //   kh_beg = khb2 + (ih+p->ph - [ih+p->ph+1 - p->oh*p->sh]) % p->sh
            //   kh_beg = khb2 + (p->oh*p->sh-1) % p->sh
            //   kh_beg = khb2 + p->sh-1 ???
            //if( ih+p->ph + 1 - p->oh*p->sh >= 0 )
            if( ih+p->ph >= p->oh*p->sh - 1)
            //if( ih+p->ph >= p->oh*p->sh ) // also might be OK
            {
              RT_ASSERT( khb2 == ih+p->ph + 1 - p->oh*p->sh );
              RT_ASSERT( ohb2 ==  (p->oh*p->sh-1) );
              RT_ASSERT( kh_beg == khb2 + (p->oh*p->sh-1) % p->sh );
              RT_ASSERT( kh_beg == khb2 + p->sh-1 );
              //RT_ASSERT( kh_beg == (ih+p->ph + 1 - p->oh*p->sh) + p->sh-1 );
              RT_ASSERT( kh_beg == ih+p->ph - p->oh*p->sh + p->sh );
              RT_ASSERT( kh_beg >= p->sh - 1);
              //RT_ASSERT( kh_beg == ih+p->ph - (p->oh*p->sh-1) + p->sh-1 );
              //RT_ASSERT( oh_beg == (p->oh*p->sh - p->sh) / p->sh );
              RT_ASSERT( oh_beg == p->oh - 1 );
            } else {
              RT_ASSERT( khb2 == 0 );
              RT_ASSERT( ohb2 ==  ih+p->ph );
              RT_ASSERT( kh_beg == (ih+p->ph) % p->sh );
              //RT_ASSERT( oh_beg == ((ih+p->ph) - (ih+p->ph)%p->sh) / p->sh );
              //RT_ASSERT( oh_beg == ((ih+p->ph)/p->sh*p->sh) / p->sh );
              RT_ASSERT( oh_beg == (ih+p->ph) / p->sh );
            }
          }
#elif 0 // clean up simplified calc and test
          {
            int khb2 = ih+p->ph + 1 - p->oh*p->sh;
            if (khb2 < 0) khb2 = 0;
            int ohb2 = ih+p->ph - khb2;
            RT_ASSERT( ohb2 >= 0 );
            kh_beg = (ih+p->ph) - ohb2 / p->sh * p->sh;
            const int oh_beg = (ih+p->ph - kh_beg) / p->sh;

            int khb3 = ih+p->ph - p->oh*p->sh + p->sh;
            int ohb3 = p->oh - 1;
            if( khb3 < p->sh - 1 ){
              ohb3 = (ih+p->ph) / p->sh;
              khb3 = (ih+p->ph) % p->sh;
            }
            RT_ASSERT( khb3 == kh_beg );
            RT_ASSERT( ohb3 == oh_beg );
          }
#elif 1
          kh_beg = ih+p->ph - p->oh*p->sh + p->sh;
          int oh_beg = p->oh - 1;
          if( kh_beg < p->sh - 1 ){
            oh_beg = (ih+p->ph) / p->sh;
            kh_beg = (ih+p->ph) % p->sh;
          }
#elif 0 // Another simplification, but more multiply,divide
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
#elif 1 // remove comments
          {
            int const d = (ih+p->ph)/p->sh; //, r = (ih+p->ph)%p->sh;
            kh_beg = (ih+p->ph)%p->sh;
            int khccc = d + 1 - p->oh;
            if( khccc >= 0 ) kh_beg += khccc*p->sh;
          }
#endif

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
            if (kh_beg < kh_end && kw_beg < kw_end) {
              //DPRINTF(".");
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                // next: loop over allowed oh values, THEN over kh
                //int const khh = p->sh; // only for p->dh==0 !!!
                for (int kh = kh_beg; kh < kh_end; kh+=p->sh) {
                  const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;
                  //int const kww = p->sw; // perhaps lcd of p-sh and p->dh+1 ? XXX
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
#elif 0 // simplify the oh_beg calc and repeat for ow_beg
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    // This is no big deal, since mkl-dnn does not even allow you to
    // create the descriptors for it.
    //refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
#if 0
          kh_end =            (ih + p->ph) - 0                        + 1;
          if (kh_end > p->kh) kh_end = p->kh;
          {
            int d = (ih+p->ph)/p->sh; //, r = (ih+p->ph)%p->sh;
            kh_beg = (ih+p->ph)%p->sh;
            d += 1 - p->oh;
            if( d >= 0 ) kh_beg += d*p->sh;
          }
#else
          kh_end = (ih + p->ph);
          kh_beg = kh_end%p->sh;
          int d = kh_end/p->sh + 1 - p->oh;
          if( d >= 0 ) kh_beg += d*p->sh;
          if (++kh_end > p->kh) kh_end = p->kh;
#endif

          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            //hoist_AmiB_in( kw_beg, kw_end,
            //    /*i  in   */ 0, p->kw,
            //    /*ow=A+iB */ (iw + p->pw), (p->dw+1),
            //    /*ow in   */ 0, p->ow*p->sw );
#if 0
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
#else
          kw_end =            (iw + p->pw) - 0                        + 1;
          if (kw_end > p->kw) kw_end = p->kw;
          {
            int d = (iw+p->pw)/p->sw; //, r = (iw+p->pw)%p->sw;
            kw_beg = (iw+p->pw)%p->sw;
            d += 1 - p->ow;
            if( d >= 0 ) kw_beg += d*p->sw;
          }

#endif
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            if (kh_beg < kh_end && kw_beg < kw_end) {
              //DPRINTF(".");
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                // next: loop over allowed oh values, THEN over kh
                //int const khh = p->sh; // only for p->dh==0 !!!
                for (int kh = kh_beg; kh < kh_end; kh+=p->sh) {
                  const int oh = (ih+p->ph - kh /* * (p->dh + 1) */) / p->sh;
                  //int const kww = p->sw; // perhaps lcd of p-sh and p->dh+1 ? XXX
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
#elif 0 // clean up
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, kh_end;
          kh_end = (ih + p->ph);
          kh_beg = kh_end%p->sh;
          int d = kh_end/p->sh + 1 - p->oh;
          if( d >= 0 ) kh_beg += d*p->sh;
          if (++kh_end > p->kh) kh_end = p->kh;

          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
            kw_end = (iw + p->pw);
            kw_beg = kw_end%p->sw;
            int d = kw_end/p->sw + 1 - p->ow;
            if( d >= 0 ) kw_beg += d*p->sw;
            if (++kw_end > p->kw) kw_end = p->kw;

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
#elif 0 // speed up oh_beg re-calculation inside loop
  // regr-dilate: 2.50x
  // the stride calc for dilation is VERY tricky!
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          int kh_beg, oh_beg, kh_end;
          kh_end = (ih + p->ph);
          oh_beg= kh_end / p->sh;
          kh_beg = kh_end/*(ih+p->ph)*/ % p->sh;
          int khccc = oh_beg - p->oh + 1;
          //if( khccc >= 0 ) { kh_beg += khccc*p->sh; oh_beg -= khccc; }
          if( khccc < 0 ) khccc = 0;
          kh_beg += khccc*p->sh;
          oh_beg -= khccc;
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
          //const int oh_beg = (ih+p->ph - kh_beg) / p->sh;
          //print(0," oh_beg=%d r=%d khccc=%d\n", oh_beg, r, khccc);
          //if( oh_beg != (r - (khccc>0? khccc:0)) ) {print(0," %s","oops"); exit(0);}

          for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, ow_beg, kw_end;
            kw_end = (iw + p->pw);
            ow_beg = kw_end / p->sh;
            kw_beg = kw_end % p->sw;
            int kwccc = ow_beg - p->ow + 1;
            ///if( kwccc >= 0 ) { kw_beg += kwccc*p->sw; ow_beg -= kwccc; }
            if( kwccc < 0 ) kwccc = 0;
            kw_beg += kwccc*p->sw;
            ow_beg -= kwccc;
            ++kw_end;
            if (kw_end > p->kw) kw_end = p->kw;
            //const int ow_beg = (iw+p->pw - kw_beg) / p->sw;

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
#elif 0 // alternate oh_beg,ow_beg calc (simpler, same speed)
  // regr-dilate: 2.50x
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
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
#elif 1 // a new simplification of loop limits (same speed as above)
  // regr-dilate: 2.50x
  if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
    refconv_4_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    return;
  }

#   pragma omp parallel for collapse(4)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          //int ocend = (p->oc/p->g);
          register int kh_end = ih + p->ph;
          int oh_beg = p->oh - 1;
          int kh_beg = kh_end - p->oh*p->sh + p->sh;
          if( kh_beg < p->sh - 1 ){ // unlikely?
            oh_beg = kh_end / p->sh;
            kh_beg = kh_end % p->sh;
          }
          if (++kh_end > p->kh) kh_end = p->kh;
          //ocend = (kh_beg < kh_end? ocend: 0);
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0; // always!
            //if( ocend == 0 ) continue;

            register int kw_end = iw + p->pw;
            int ow_beg = p->ow - 1;
            int kw_beg = kw_end - p->ow*p->sw + p->sw;
            if( kw_beg < p->sw - 1 ){ // unlikely?
              ow_beg = kw_end / p->sw;
              kw_beg = kw_end % p->sw;
            }
            if (++kw_end > p->kw) kw_end = p->kw;
            //if (kw_beg >= kw_end ) continue;
            //ocend = (kw_beg < kw_end? ocend: 0);

            if( kh_beg >= kh_end || kw_beg >= kw_end ) continue;
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
