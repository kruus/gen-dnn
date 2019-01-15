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

namespace conv {

// BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
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

#if 1 || defined(NDEBUG)
#define DPRINTF(...)
#define DMUST(...)
#else
#define DPRINTF(...)  do{printf(__VA_ARGS__); fflush(stdout);}while(0)
#define DMUST(...)   MUST(__VA_ARGS__)
#endif

/** hoist `A+iB in range [C,D)` condition out of a loop.
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
    RT_ASSERT( b > 0 );
    // int i*B < A    iff    i < (A    )/B
    // int i*B > A    iff    i > (A+B-1)/A
    // A+iB >= c ... iB >= c-A  ... i >= (c-A + B-1 )/B
    beg = c-a + b-1;
    if( beg >= 0 ){
        beg /= b;
    } else {
        int const fmul=(-beg + b)/b;
        RT_ASSERT( beg + fmul*b >= 0 );
        beg = (beg + fmul*b) / b - fmul;
    }
    //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), beg=%d? f+c-a+b-1=%d\n",
    //        imin,imax, a,b, c,d, beg, f+c-a+b-1);
    MUST( a + (beg-1)*b < c );
    MUST( a + (beg  )*b >= c );
    if( beg < imin ) beg = imin;

    // A+iB < d ... iB < d-A    ... i < (d-A) / B
    end = d-a +b-1;
    if( end >= 0 ){
        end /= b;
    } else {
        int const fmul=(-end + b)/b;
        RT_ASSERT( end + fmul*b >= 0 );
        end = (end + fmul*b) / b - fmul;
    }
    //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), end=%d? f+d-a=%d\n",
    //        imin,imax, a,b, c,d, end, f+d-a);
    MUST( a + (end-1)*b < d );
    MUST( a + (end  )*b >= d );
    if( end > imax ) end = imax;
}
void refconv_3_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
    MUST( p->kh > 0 && p->kw > 0 );
    MUST( p->dh >= 0 && p->dw >= 0 );
    MUST( p->sh >= 0 && p->sw >= 0 );
    int kh_beg, kh_end, kw_beg, kw_end;

    auto ker = [](
            const prb_t *p, dnn_mem_t &src_m, dnn_mem_t &wei_m,
            float &d, const int g, const int mb, const int oc, const int oh, const int ow
            , const int kh_beg, const int kh_end, const int kw_beg, const int kw_end
            ) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
#if 0 && !defined(NDEBUG)
            RT_ASSERT( kh_beg >= 0 );
            RT_ASSERT( kh_end <= p->kh );
            for (int kh = 0; kh < p->kh; ++kh)
            {
                const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                // ih < p->ih when...
                //   (oh*p->sh - p->ph) + kh * (p->dh+1) < p->ih
                //   kh * (p->dh+1) < (p->ph - oh*p->sh - p->ih)
                //   kh * A         < B
                //   kh < (B+A-1)/ A
                //   kh < (p->ph - oh*p->sh - p->ih + p->dh) / (p->dh+1)
                // ih >= 0 when...
                //   (oh*p->sh - p->ph) + kh * (p->dh+1) >= 0
                //   kh * (p->dh+1) >= (p->ph - oh*p->sh)
                //   kh >= (p->ph - oh*p->sh + p->dh) / (p->dh+1)
                if (ih < 0 )      { DPRINTF("<<< kh=%d kh_beg=%d ih=%d\n", kh,kh_beg,ih);MUST( kh < kh_beg ); continue; }
                if (ih >= p->ih ) { DPRINTF(">>> kh=%d kh_beg=%d ih=%d\n", kh,kh_beg,ih); MUST( kh >= kh_end ); continue; }
                MUST( ih>=0 && ih < p->ih);
                //PRINTF("=== kh=%d kh_beg=%d kh_end=%d ih=%d\n", kh,kh_beg,kh_end,ih);
                MUST( kh>=kh_beg && kh<kh_end );

                for (int kw = 0; kw < p->kw; ++kw) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1); // loop vars: ow, kw
                    //if (iw < 0 || iw >= p->iw) continue;
                    if (iw < 0 )      { DPRINTF("<<< kw=%d kw_beg=%d iw=%d\n", kw,kw_beg,iw); MUST( kw < kw_beg ); continue; }
                    if (iw >= p->iw ) { DPRINTF(">>> kw=%d kw_beg=%d iw=%d\n", kw,kw_beg,iw); MUST( kw >= kw_end ); continue; }
                    MUST( iw>=0 && iw < p->iw);
                    //PRINTF("=== kw=%d kw_beg=%d kw_end=%d iw=%d\n", kw,kw_beg,kw_end,iw);
                    MUST( kw>=kw_beg && kw<kw_end );

                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                }
            }
#else
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
#endif
        }
    };

    OMP(parallel for collapse(4))//;
    for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int oh = 0; oh < p->oh; ++oh) {
#if 0
        //(p->ph - oh*p->sh) < 0 //(p->dh+1)/*0*/
        kh_beg = (p->ph - oh*p->sh + p->dh) / (p->dh+1);
        kh_beg = (p->ph - oh*p->sh        ) / (p->dh+1);
        if( kh_beg < 0 ) kh_beg = 0;
        kh_end =  (p->ih + p->ph - oh*p->sh +p->dh) / (p->dh+1);
        kh_end = (kh_end > p->kh? p->kh: kh_end);
#else
        hoist_ApiB_in( kh_beg, kh_end,
                /*i  in   */ 0, p->kh,
                /*ih=A+iB */ (oh * p->sh - p->ph), (p->dh + 1),
                /*ih in   */ 0, p->ih);
#endif
        for (int ow = 0; ow < p->ow; ++ow) {
#if 0
            kw_beg = (p->pw - ow*p->sw +p->dw) / (p->dw+1);
            if (kw_beg < 0) kw_beg = 0;
            kw_end =  (p->iw + p->pw - ow*p->sw +p->dw) / (p->dw+1);
            kw_end = (kw_end > p->kw? p->kw: kw_end);
#else
            hoist_ApiB_in( kw_beg, kw_end,
                    /*i  in   */ 0, p->kw,
                    /*iw=A+iB */ (ow * p->sw - p->pw), (p->dw + 1),
                    /*iw in   */ 0, p->iw);
#endif
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            size_t bia_off = bia_off_f(p, g, oc);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0;
            if( TRIVIAL(kh_beg >= kh_end) ){
                DPRINTF("t");
            } else {
                DPRINTF(".");
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
}

/** if \c a<0 add some \c mult to make result non-negative.
 * oops, does not return the fudge, \c 0 or \c (-a/mult).
 * But maybe useful for modulo arithmetic with negatives. */
static inline int constexpr mk_nonneg( const int a, const int mult )
{
    return a >= 0? a: a + (-a / mult + 1) * mult;
}

/** Integer \c i so A-iB is <em>just below</em> \c target.
 * \pre \c B>0 (unchecked). */
static inline int AmiB_lt_target( const int a, const int b, const int target)
{
    int ibelow = a-target + b;
    if( ibelow >= 0 ){
        ibelow /= b;
    } else {
        int const fmul=(-ibelow + b)/b;
        RT_ASSERT( ibelow + fmul*b >= 0 );
        ibelow = (ibelow + fmul*b) / b - fmul;
    }
    MUST( a - (ibelow-1)*b >= target );
    MUST( a - (ibelow  )*b <  target );
    return ibelow;
}
/** Get range if \c i so A-iB is in [c,d), and then further
 * restrict to range [imin,imax).  Note that \c -B means as \c i
 * increases, we move from \c d-1 downwards to \c c. */
static inline void hoist_AmiB_in( int& beg, int& end,
        const int imin, const int imax,
        const int a, const int b, const int c, const int d)
{
    RT_ASSERT( b > 0 );
#if 0
    // int i*B < A    iff    i < (A    )/B
    // int i*B > A    iff    i > (A+B-1)/A
    // A-iB < d ... iB > A-d    ... i < (A-d) / B
    beg = a-d + b;
    if( beg >= 0 ){
        beg /= b;
    } else {
        int const fmul=(-beg + b)/b;
        RT_ASSERT( beg + fmul*b >= 0 );
        beg = (beg + fmul*b) / b - fmul;
    }
    print(0, "i in [%d,%d), lin(a,b)=%d-i*%d in [c,d]=[%d,%d), beg=%d? a-d+b=%d\n",
            imin,imax, a,b, c,d, beg, a-d+b);
    MUST( a - (beg-1)*b >= d );
    MUST( a - (beg  )*b < d );
#else
    beg = AmiB_lt_target( a, b, d );
#endif
    if( beg < imin ) beg = imin;

#if 0
    // A-iB >= c ... iB <= c-A  ... i <= (c-A + B-1 )/B
    end = a-c +b;
    if( end >= 0 ){
        end /= b;
    } else {
        print(0, "huh////===\n", "");
        int const fmul=(-end + b)/b;
        RT_ASSERT( end + fmul*b >= 0 );
        end = (end + fmul*b) / b - fmul;
    }
    print(0, "i in [%d,%d), lin(a,b)=%d-i*%d in [c,d]=[%d,%d), end=%d? a-c+b=%d\n",
            imin,imax, a,b, c,d, end, a-c+b);
    MUST( a - (end-1)*b >= c );
    MUST( a - (end  )*b <  c );
#else
    end = AmiB_lt_target( a, b, c );
#endif
    if( end > imax ) end = imax;
}
void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {

    if (p->dh > 0) { // A fast version here does not support dilation
        // This is no big deal, since mkl-dnn does not even allow you to
        // create the descriptors for it.
        refconv_2_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
    }

    auto ker = [](
                  const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &wei_m,
                  const int ihph,
                  float &ds, int g, int mb, int ic, int ih, int iw
                  , const int kh_beg, const int kh_end
                  , const int kw_beg, const int kw_end
                  ) {
        RT_ASSERT(p->sh > 0);
        bool const s0 = kh_beg >= kh_end || p->sh <= 1; // this IMPLIES skips remains 0
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
            int skips = 0;
#if 0 // streamlined -- TODO cannot get rid of one inner conditional !!!
            // next: loop over allowed oh values, THEN over kh
            for (int kh = kh_beg; kh < kh_end; ++kh) {
                int oh = ihph - kh * (p->dh + 1); // loop vars: kh, ih
                if (oh % p->sh) continue;
                oh /= p->sh;

                for (int kw = 0; kw < p->kw; ++kw) {
                    int ow = iw - kw * (p->dw + 1) + p->pw; // loop vars: iw, kw
                    if (ow < 0 || ow % p->sw) continue;
                    ow /= p->sw;
                    if (ow >= p->ow) continue;

                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    ds += ((float*)diff_dst_m)[dst_off]
                        * ((float*)wei_m)[wei_off];
                }
            }
#elif 0 // Closer to getting rid of inner conditional
            // next: loop over allowed oh values, THEN over kh
            int const khh = p->sh; // perhaps lcm of p-sh and p->dh+1 ? XXX
            for (int kh = kh_beg; kh < kh_end; kh+=khh) {
                int oh = ihph - kh * (p->dh + 1); // loop vars: kh, ih
                // XXX This is WRONG.  You can still hoist by making a
                //     *list* of OK weight indices kh,kw in caller.
                //  But then this turns into a loop over indirect indices.
                //if (oh % p->sh){
                //    RT_ASSERT( (kh-kh_beg) % p->sh != 0 );
                //    continue;
                //}else{
                //    RT_ASSERT( (kh-kh_beg) % p->sh == 0 );
                //}
                oh /= p->sh;

                for (int kw = 0; kw < p->kw; ++kw) {
                    int ow = iw - kw * (p->dw + 1) + p->pw; // loop vars: iw, kw
                    if (ow < 0 || ow % p->sw) continue;
                    ow /= p->sw;
                    if (ow >= p->ow) continue;

                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    ds += ((float*)diff_dst_m)[dst_off]
                        * ((float*)wei_m)[wei_off];
                }
            }
#else // assertions
            //for (int kh = 0; kh < p->kh; ++kh) {
            for (int kh = kh_beg; kh < kh_end; ++kh) {
            //for (int kh = kh_beg; kh < kh_end; kh+=p->sh) {
                int oh = ihph - kh * (p->dh + 1); // loop vars: kh, ih
                // oh >= 0      ... ihph - kh*A >= 0
                //              ,,, kh <= ihph/A
                //              ... kh <  ihph/A + 1
                //              ... kh <  (ihph+p->dh) / (p->dh+1) + 1
                // oh/p->sh < p->oh     ... iph-kh*A < ohsh
                //                      ... kh*A > ohsh - iph
                //                      ... kh > (iph - ohsh) / A
                //                      ... kh > (iph - ohsh +A) / A
                //RT_ASSERT( oh >= 0 );
                if (oh < 0) {
                    //if (kh<kh_end) print(0, " kh=%d kh_end=%d\n",kh,kh_end);
                    //RT_ASSERT(kh >= kh_end);
                    continue;
                }
                MUST( kh < kh_end );
                //NO RT_ASSERT( oh % p->sh == 0 );
                if( kh == kh_beg )
                {
#if 0
                    RT_ASSERT( oh % p->sh == 0 ); // don't think this is really correct!
#elif 0
                    int rem = oh % p->sh;
                    int guess = 0;
                    //int g = AmiB_lt_target( ihph, p->dh+1, p->oh );
                    //g = mk_nonneg( g, p->sh );
                    //int guess = g % p->sh;

                    if( rem != guess ){
                        print(0, "oh=%d sh=%d dh=%d g=%d,  oh%%sh=%d guess=%d\n",
                                oh, p->sh, p->dh, g,  rem, guess);
                        RT_ASSERT( rem == guess );
                    }
#endif
                }
                if (oh % p->sh) {
                    ++skips;
                    //if (!s0) print(0, " s%d", oh);
                    //if( skips >= kh_end - kh_beg ){} ... YES (can skip ALL)
                    continue;
                }else{
                    //if (!s0) print(0, "ih=%d kh=%d oh=%d\n", ih,kh,oh);
                    //if (!s0) print(0, " %d", oh);
                    //++noskips
                }
                oh /= p->sh;
                if (oh >= p->oh) {
                    //if(kh>=kh_beg)print(0,"OOPS: kh=%d kh_beg=%d -> oh/p->sh=%d >= p->oh=%d\n",kh,kh_beg,oh,p->oh);
                    //RT_ASSERT(kh < kh_beg);
                    continue;
                }
                if( kh < kh_beg) print(0,"OOPS: kh=%d kh_beg=%d\n",kh,kh_beg);
                MUST( kh >= kh_beg );

#if 0
                for (int kw = 0; kw < p->kw; ++kw) {
                    int ow = iw - kw * (p->dw + 1) + p->pw; // loop vars: iw, kw
                    if (ow < 0 || ow % p->sw) continue;
                    ow /= p->sw;
                    if (ow >= p->ow) continue;

                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    ds += ((float*)diff_dst_m)[dst_off]
                        * ((float*)wei_m)[wei_off];
                }
#else
                for (int kw = kw_beg; kw < kw_end; kw += p->sw) {
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
#endif
#endif
#if 0
            // check expected number of skips (only exact for p->dh==0)
            if( kh_beg < kh_end && skips > 0){
                // XXX only because BWD_D dilation not here yet!
                int expect = (kh_end-kh_beg) /p->sh *(p->sh-1);
                int rem = (kh_end-kh_beg) %p->sh;
                if (rem > 1) expect += rem-1;
                if (skips != expect){
                    print(0, "kh_beg=%d kh_end=%d skips=%d != expected=%d\n",
                            kh_beg, kh_end, skips, expect);
                    RT_ASSERT( skips == expect );
                }
            }
#else
            if(p->sh){
                //print(0," skips=%d DBG p->sh=%d p->dh=%d\n", skips, p->sh, p->dh);
            }
            if (kh_beg >= kh_end ) RT_ASSERT( skips == 0 );
            if (p->sh <= 1 )       RT_ASSERT( skips == 0 );
            // NO if (p->kh < p->sh )    RT_ASSERT( skips == 0 );
            RT_ASSERT( skips==0 || (skips>0 && p->sh > 1) );
            RT_ASSERT( skips==0 || (skips>0 && kh_beg<kh_end) );
            // NO RT_ASSERT( skips==0 || (skips>0 && p->kh<p->sh) );
            if( skips == 0 ){
                // NO     RT_ASSERT( kh_beg>=kh_end || p->sh<=1 );
                // better RT_ASSERT( kh_beg>=kh_end || p->sh<=1 || p->kh<p->sh );
            }
            //RT_ASSERT( skips > 0 && kw_beg<kw_end);
#endif
        }
    };

        OMP(parallel for collapse(4))//;
    for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
            const int ihph = ih + p->ph;
            int kh_beg, kh_end;
#if 0
            const int ohsh = p->oh * p->sh;
            //kh_beg = 0;
            //kh_beg = (ihph - p->oh*p->sh + 5*(p->dh+1) + p->dh) / (p->dh+1) -5;
            kh_beg = ((ihph - ohsh + 500*(p->dh+1) +p->dh+1) / (p->dh+1)) -500;
            //int below =  (ihph - (kh_beg-1) * (p->dh+1));
            //int above =  (ihph - (kh_beg  ) * (p->dh+1));
            //if (!( below/p->sh >= p->oh && above/p->sh < p->oh)){
            //    print(0, "sh=%d dh=%d, a=ihph=%d b=%d kh_beg=%d, target=%d above=%d, below=%d\n",
            //            p->sh, p->dh, ihph, p->dh+1, kh_beg, p->oh, above, below);
            //}
            MUST( (ihph - (kh_beg-1) *  (p->dh+1)) / p->sh >= p->oh );
            MUST( (ihph - (kh_beg  ) *  (p->dh+1)) / p->sh <  p->oh );
            MUST( (ihph - (kh_beg-1) *  (p->dh+1)) >= ohsh );
            MUST( (ihph - (kh_beg  ) *  (p->dh+1)) <  ohsh );
            if( kh_beg < 0 ) kh_beg = 0;

            // oh = ihph - kh * A >= 0 ==> kh <= ihph / A
            //kh_end = p->kh;
            //kh_end = (ihph) / (p->dh+1) + 1;
            int kh_end = (ihph + p->dh+1) / (p->dh+1);
            MUST( ihph - (kh_end-1) * (p->dh+1) >= 0 );
            MUST( ihph - (kh_end  ) * (p->dh+1) <  0 );
            if (kh_end > p->kh) kh_end = p->kh;
            //print(0, "kh_beg=%d, kh_end=%d : test hoist A-iB...\n", kh_beg,kh_end);
#else
            hoist_AmiB_in( kh_beg, kh_end,
                    /*i  in   */ 0, p->kh,
                    /*oh=A+iB */ (ih + p->ph), (p->dh+1),
                    /*oh in   */ 0, p->oh*p->sh );
            //RT_ASSERT( kh_beg == b );
            //RT_ASSERT( kh_end == e );
#endif
#if 1
            // XXX still have the modulus in the loop...
            int oh_beg = ihph - kh_beg * (p->dh+1);
            int rem_beg = oh_beg % p->sh;
            if (rem_beg){
                //print(0, "kh_beg=%d oh_beg=%d guess rem=%d sh=%d", kh_beg, oh_beg, rem_beg, p->sh);
                // XXX closed-form formula ???
                do {
                    ++kh_beg;
                    oh_beg = ihph - kh_beg * (p->dh+1);
                } while( oh_beg % p->sh != 0 && kh_beg < kh_end );
                //print(0, " ... kh_beg --> %d, oh_beg --> %d\n", kh_beg, oh_beg);
                RT_ASSERT( kh_beg >= kh_end || (ihph - kh_beg * (p->dh+1)) % p->sh == 0 );
                //if (kh_beg < 0) kh_beg = 0; 
            }
#endif
        for (int iw = 0; iw < p->iw; ++iw) {
            int kw_beg, kw_end;
#if 0
            kw_beg=0;
            kw_end=p->kw;
#else
            hoist_AmiB_in( kw_beg, kw_end,
                    /*i  in   */ 0, p->kw,
                    /*ow=A+iB */ (iw + p->pw), (p->dw+1),
                    /*ow in   */ 0, p->ow*p->sw );
            {
                int iwpw = iw + p->pw;
                // XXX still have the modulus in the loop...
                int ow_beg = iwpw - kw_beg * (p->dw+1);
                int rem_beg = ow_beg % p->sw;
                if (rem_beg){
                    //print(0, "kw_beg=%d ow_beg=%d guess rem=%d sw=%d", kw_beg, ow_beg, rem_beg, p->sw);
                    // XXX closed-form formula ???
                    do {
                        ++kw_beg;
                        ow_beg = iwpw - kw_beg * (p->dw+1);
                    } while( ow_beg % p->sw != 0 && kw_beg < kw_end );
                    //print(0, " ... kw_beg --> %d, ow_beg --> %d\n", kw_beg, ow_beg);
                    RT_ASSERT( kw_beg >= kw_end || (iwpw - kw_beg * (p->dw+1)) % p->sw == 0 );
                    //if (kh_beg < 0) kh_beg = 0; 
                }
            }
#endif
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            ker( p, diff_dst_m, wei_m, ihph,
                 ds, g, mb, ic, ih, iw
                 , kh_beg, kh_end, kw_beg, kw_end
               );
        }
        }
        }
    }
    }
}

void refconv_3_bwd_w(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {

    auto ker = [](
                   const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &src_m,
                   float &dw, int g, int oc, int ic, int kh, int kw) {
        for (int mb = 0; mb < p->mb; ++mb) {
            for (int oh = 0; oh < p->oh; ++oh) {
            for (int ow = 0; ow < p->ow; ++ow) {
                const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                if (ih < 0 || ih >= p->ih) continue;
                if (iw < 0 || iw >= p->iw) continue;

                size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                dw += ((float*)diff_dst_m)[dst_off]
                    * ((float*)src_m)[src_off];
            }
            }
        }
    };

    OMP(parallel for collapse(5))//;
    for (int g = 0; g < p->g; ++g) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
            for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                float &dw = ((float*)diff_wei_m)[wei_off];
                dw = 0;
                ker( p, diff_dst_m, src_m,
                     dw, g, oc, ic, kh, kw);
            }
            }
        }
        }
    }

    if (!(p->dir & FLAG_BIA)) return;

    OMP(parallel for collapse(2))//;
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
// vim: et ts=4 sw=4 cindent nopaste ai cino=l0,\:0,N-s
