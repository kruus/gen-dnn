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
 * remove lambdas */
#include "conv.hpp"
#include "../idiv.hpp"
#include "omp.h"

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

namespace conv {

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
    RT_ASSERT( b > 0 );
    // int i*B < A    iff    i < (A    )/B
    // int i*B > A    iff    i > (A+B-1)/A
    // A+iB >= c ... iB >= c-A  ... i >= (c-A + B-1 )/B
    beg = div_floor( c-a+b-1, b );
    if( beg < imin ) beg = imin;

    // A+iB < d ... iB < d-A    ... i < (d-A) / B
    end = div_floor( d-a+b-1, b );
    if( end > imax ) end = imax;
}

// n0_i_k_yy arranged loops row-wise, and had unit stride for ... kx (kw) and outc (ow)
#if 0
void corr1Csc( float const * __restrict__ const im, long const sc, float const alpha
               , float const * __restrict__ const krn, long const ksz
               , float * __restrict__ const out
               , long const outsz )
{
  for (long kx = 0; kx < ksz; ++kx) {
    for(long xx=0 ; xx<outsz; ++xx){
      creal const c=alpha*krn[kx];
      out[xx] += c * im[xx*sc+kx];
    }
  }
}
inline void corr_n0d_i_k_yy_00( Ndata0 &d, creal alpha, int const sr, int const sc )
{
  assert( d.kr < d.imr );
  assert( d.kc < d.imc );
  long outr = (d.imr - d.kr) / sr + 1;
  long outc = (d.imc - d.kc) / sc + 1;
  assert( outr <= d.imr );
  assert( outc <= d.imc );
  for(size_t i=0U; i<d.nIm; ++i){
    size_t const o = i/d.kd;
    size_t const kp = i - o*d.kd;
    for(size_t k=0U; k<d.nKrn; ++k){
      for (long ky = 0; ky < d.kr; ++ky) { // kernel col
        for(long yy = 0; yy < outr; ++yy) { // image/output row
          corr1Csc( d.im     + i*d.imr*d.imc + yy*sr*d.imc + ky*d.imc
                    , sc, alpha
                    , d.krn  + k*d.kd*d.kr*d.kc + kp*d.kr*d.kc + ky*d.kc
                    , d.kc
                    , d.out  + o*d.nKrn*outc*outr + k*outc*outr + yy*outc
                    , outc );
        }
      }
    }
  }
}
#endif

void refconv_4_fwd(const prb_t *p, dnn_mem_t &src_m,
                   dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m)
{
#define FWD_g_mb_oc_oh_ow \
  for (int g = 0; g < G; ++g) \
  for (int mb = 0; mb < MB; ++mb) \
  for (int oc = 0; oc < OC/G; ++oc) \
  for (int oh = 0; oh < OH; ++oh) \
  for (int ow = 0; ow < OW; ++ow)

  auto xdst_init = []( const prb_t *p,
                       const dnn_mem_t &bia_m, const dnn_mem_t &dst_m )
  {
    if (p->dir & FLAG_BIA){
#pragma omp parallel for collapse(5) schedule(static)
      FWD_g_mb_oc_oh_ow {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        size_t bia_off = bia_off_f(p, g, oc);
        float &d = ((float*)dst_m)[dst_off];
        d = ((float*)bia_m)[bia_off];
      }
    }else{
#pragma omp parallel for collapse(5) schedule(static)
      FWD_g_mb_oc_oh_ow {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        d = 0;
      }
    }
  };

  auto xdst_relu = []( const prb_t *p, const dnn_mem_t &dst_m )
  {
    if (p->merge == RELU ){
#pragma omp for collapse(5)
      FWD_g_mb_oc_oh_ow {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        d = (d < 0? 0: d);
      }
    }
  };
  auto dst_init = []( const prb_t *p, const dnn_mem_t &bia_m, const int bia_off,
                       const dnn_mem_t &dst_m,
                       const int mb, const int g, const int oc, const int oh ) {
    const float val = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off]: 0.f;
    for (int ow = 0; ow < OW; ++ow) {
      size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
      float &d = ((float*)dst_m)[dst_off];
      d = val;
    }
  };
  auto bias_relu = []( const prb_t *p, const dnn_mem_t &dst_m,
                       const int mb, const int g, const int oc, const int oh ) {
#if 0
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            if (p->merge == RELU && d < 0.f)
              d = 0.f;
          }
#else
    if (p->merge == RELU){
      for (int ow = 0; ow < OW; ++ow) {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        if (d < 0)
          d = 0;
      }
    }
#endif
  };
  // writing to dst[ p,mb,g,oc,oh,ow ]
#if 1 // revert back to old speed champ for short regr tests, and clean up
  // regr.sh-FWD 2.39x
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
        for (int kh = 0; kh < p->kh; ++kh) { // <--- write-aliasing
          int oh_beg, oh_end;
          oh_beg = div_floor(       + PH - kh*(p->dh+1) + SH - 1, SH);//(c-a+b-1)/b
          oh_end = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
          if (oh_beg < 0    ) oh_beg = 0;
          if (oh_end > OH) oh_end = OH;
          if( oh_beg >= oh_end ) continue;
          for (int kw = 0; kw < KW; ++kw) {
            for (int ic = 0; ic < IC/G; ++ic) { // <--- !!!
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              int ow_beg, ow_end;
              ow_beg = div_floor(       + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
              ow_end = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
              if (ow_beg < 0    ) ow_beg = 0;
              if (ow_end > OW) ow_end = OW;
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                const int iw = ow * SW - PW + kw * (p->dw + 1);
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1); //
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                }
              }
            }
          }
        }
        for (int oh = 0; oh < OH; ++oh) {
          bias_relu(p, dst_m, mb, g, oc, oh);
        }
      }
    }
  }
#else
#error "select one!"
#endif
}

/** 6.3 x w/ conditional hoisting and loop order
 * g,mb,ic,oc,kh,kw,oh,[ih],ow,[iw] */
void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
                     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
{
#if 1 // regr 1.91
  // + dilates: 1.81x
  const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
  const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
  const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
# pragma omp parallel for collapse(3) // dst_off_f(p, mb, g, oc, oh, ow);
  for (int mb = 0; mb < MB; ++mb) {
    for (int g = 0; g < G; ++g) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          int oh_beg, oh_end;
          // TODO: optimize, same as fwd
#define HOIST_OH 1
#if HOIST_OH==0
          hoist_ApiB_in( /* set     */ oh_beg, oh_end,
                         /*oh  in   */ oh_lowest, OH,
                         /*ih=A+ohB */ -PH + kh*(p->dh+1), SH, // B>0, ApiB OK
                         /*ih in    */ 0, IH);
#elif HOIST_OH==1 // see ref_conv3 for this version, ref_conv5 for yet another
    oh_beg = div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
    oh_end = div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
    if (oh_beg < 0    ) oh_beg = 0;
    if (oh_end > OH) oh_end = OH;
#else
#error "huh"
#endif
          for (int kw = 0; kw < KW; ++kw) {
            int ow_beg, ow_end;
#if HOIST_OH==0
            hoist_ApiB_in( /* set     */ ow_beg, ow_end,
                           /*ow  in   */ ow_lowest, OW,
                           /*iw=A+owB */ -PW + kw*(p->dw+1), SW, // B>0, ApiB OK
                           /*iw in    */ 0, IW);
#elif HOIST_OH==1
      ow_beg = div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
      ow_end = div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
      if (ow_beg < 0    ) ow_beg = 0;
      if (ow_end > OW) ow_end = OW;
#else
#error "huh"
#endif
      // TODO: figure out aliasing issues
#if 0
            for (int oh = oh_beg; oh < oh_end; ++oh) {
              const int ih  =  oh*SH - PH + kh * (p->dh+1);
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                float tmp=0.0f;
                for (int oc = 0; oc < OC/G; ++oc) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  tmp += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
                }
                const int iw  =  ow*SW - PW + kw * (p->dw+1);
                const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                float &ds = ((float*)diff_src_m)[src_off];
#pragma omp atomic
                ds += tmp;
              }
            }
#else
            // aliasing analysis does not seem easy. (between kh/ih and kh/iw)
            // src_off_f:
            //    ((mb * IC + g * IC/G + ic) * IH + ih) * IW
            // Q: when is ih for one kh equal to ih for some other kh?
            // Usual case has lots of aliasing happening!
            // Soln would be to split into 3 cases (each)
            // kh "left" kh "full-range" kh "right"
            //and the reorder to loops oh-first...
            //........
            //but this ends up looking a lot like plain refconv3
            int ih = oh_beg * SH - PH + kh * (p->dh+1);
            const int Aiw = kw * (p->dw+1) - PW;
            for (int oh = oh_beg; oh < oh_end; ++oh) {
              //const int ih  =  oh*SH - PH + kh * (p->dh+1);
              //int iw= ow_beg * SW - PW + kw * (p->dw+1);
              int iw = ow_beg * SW + Aiw;
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                float tmp=0.0f;
                for (int oc = 0; oc < OC/G; ++oc) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  tmp += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
                }
                //const int iw  =  ow*SW - PW + kw * (p->dw+1);
                //RT_ASSERT( iw == iw2 );
                const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                float &ds = ((float*)diff_src_m)[src_off];
#pragma omp atomic
                ds += tmp;
                iw += SW;
              }
              ih += SH;
            }
#endif
          }
        }
      }
    }
  }
#elif 1
#error "oops"
#endif
}

/** hoist and reorder loops.
 * g,mb,ic,oc,kh,kw,oh,[ih],ow,[iw] */
void refconv_4_bwd_w(const prb_t *p, dnn_mem_t &src_m,
                     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m)
{
#define BW4 15 
  //  Speedups Table
  //     Test: regr.sh 6 BWD_W, snake10(avx2)
  //     |   descr.............
  //         - 'tidy' means removine comments & dead code
  //  0 1.14
  //  1 1.14 tidy
  //  2 1.37 zero_wei & mb loop ouside
  //  3 1.27 tidy
  //  4 1.78 hoist oh,ow
  //  5 loop order tests XAF=1.88 XAG=2.15 XBF=1.95 XBG=1.92
  //                     YAF=1.86 YAG=1.95 YBF=1.98 YBG=1.99
  //                     ZAF=1.85 ZAG=2.26 ZBF=1.90 ZBG=1.79
  //                     best loop order for short tests is
  //                ZAG: omp(g,A:ic,kh,kw) hoist G:oc,Z:mb,oh,ow
  //                     changed Y to "better" posn (after hoist)
  //                     YAF=2.0 YAG=1.83 YBF=1.87 YBG=1.77
  //  50 1.97 tidy ZAG
  //  -------- mb ouside is not omp-safe !!!! (discovered later)
  //  6 1.82 alt mb:Z loop posn not better
  //  7 1.56 omp(g,oc,ic,kh,kw) ic&zero, mb,oh,ow ?? zeroing back inside
  //  8 1.54 ?? init bias inside loop
  //  9 1.79
  // 10 1.91,1.91 _nog offsets (FIXED) are now a non-optimization
  // 11 1.61 REMOVED (_nog) then fixed and omp experiments
  // 12 1.91
  // 13 2.28
  // 14 2.40
  // It is hard to measure any speed difference from modifying the bwd_w_bias_update
  auto bwd_w_bias_update = [](const prb_t* p, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m){
    if ((p->dir & FLAG_BIA)) {
    //memset( (float*)diff_bia_m, 0, diff_bia_m.size() ); // single loop, always equiv
    //zero_bia(p, diff_bia_m);
#if 0
#pragma omp parallel for collapse(2) //
    //#pragma omp parallel for collapse(2) // PT 3.6x
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        //#pragma omp parallel // PT 2.70x, 2.88x
        {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0.f; // optional (now done earlier)
          //# pragma omp for collapse(3)
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
#elif 0 // 4.2x can only collapse(1) for thread-safe write
# pragma omp parallel for collapse(1)
    for (int oc = 0; oc < OC     ; ++oc) {
      size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      db = 0.f; // optional (now done earlier)
      for (int mb = 0; mb < MB; ++mb) {
        for (int oh = 0; oh < OH; ++oh) {
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f_nog(p, mb, /*g,*/ oc, oh, ow);
            db += ((float*)diff_dst_m)[dst_off];
          }
        }
      }
    }
#elif 0 // 4.2x can only collapse(1) for thread-safe write
# pragma omp parallel for collapse(1)
    for (int oc = 0; oc < OC     ; ++oc) {
      size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      db = 0.f;
      for (int mb = 0; mb < MB; ++mb) {
        for (int oh = 0; oh < OH; ++oh) {
          for (int ow = 0; ow < OW; ++ow) {
            int ohw = oh * OW + ow;
            size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
            db += ((float*)diff_dst_m)[dst_off];
          }
        }
      }
    }
#elif 0 // 
    for (int oc = 0; oc < OC     ; ++oc) {
      {
        size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        db = 0.f;
#       pragma omp parallel for collapse(3) reduction(+:db)
        for (int mb = 0; mb < MB; ++mb) {
          for (int oh = 0; oh < OH; ++oh) {
            for (int ow = 0; ow < OW; ++ow) {
              int ohw = oh * OW + ow;
              size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
              db += ((float*)diff_dst_m)[dst_off];
            }
          }
        }
      }
    }
#elif 1
    for (int oc = 0; oc < OC     ; ++oc) {
      size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      db = 0.f;
# pragma omp parallel for collapse(2) reduction(+:db)
      for (int mb = 0; mb < MB; ++mb) {
        for (int ohw = 0; ohw < OH*OW; ++ohw) {
          size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
          db += ((float*)diff_dst_m)[dst_off];
        }
      }
    }
#else //
#error "choose one!"
#endif
    }
  }; // bwd_w_bias_update
// --------------------------------------------------impls
// -------------------------------------------------------
#if BW4==14 // tidy up, try some questionable omp mods
  // TODO I think the omp mods are WRONG
#if 1
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb)
  {
#pragma omp parallel for collapse(4)
#else
    //zero_bia(p, diff_bia_m);
#pragma omp parallel
    {
#pragma omp single
    zero_bia(p, diff_bia_m);
#pragma omp single
      zero_wei(p, diff_wei_m);
#pragma omp single //// makes omp for illegally nested?
      for (int mb = 0; mb < MB; ++mb) {
        if ((p->dir & FLAG_BIA)) {
//# pragma omp parallel
# pragma omp for
          for (int oc = 0; oc < OC     ; ++oc) {
            size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
            float &db = ((float*)diff_bia_m)[bia_off];
            for (int ohw = 0; ohw < OH*OW; ++ohw) {
              //for (int ow = 0; ow < OW; ++ow) {
              size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
              db += ((float*)diff_dst_m)[dst_off];
              //}
            }
          }
        }
      }
    }
    // NOTE: we've arrived at something very similar to ref_conv3, but
    //   mb-loop is outside omp-loop
    for (int mb = 0; mb < MB; ++mb) {
//#pragma omp parallel
#pragma omp for collapse(4)
#endif
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            int oh_beg, oh_end;
            oh_beg=div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
            oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
            if (oh_beg < 0    ) oh_beg = 0;
            if (oh_end > OH) oh_end = OH;
            int ow_beg, ow_end;
            ow_beg=div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
            ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
            if (ow_beg < 0    ) ow_beg = 0;
            if (ow_end > OW) ow_end = OW;
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0

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
                  // Here's the problem: multiple 'mb' might update the same 'dw'
#pragma omp atomic
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
#elif 1 || BW4==15 // tidy up, try some questionable omp mods
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
  zero_wei(p, diff_wei_m);
#pragma omp parallel
    {
      // NOTE: we've arrived at something very similar to ref_conv3, but
      //   mb-loop is outside omp-loop
        //#pragma omp parallel
#pragma omp for collapse(4)
        for (int g = 0; g < G; ++g) {
          for (int oc = 0; oc < OC/G; ++oc) {
            for (int kh = 0; kh < p->kh; ++kh) {
              for (int kw = 0; kw < KW; ++kw) {
                int oh_beg, oh_end;
                oh_beg=div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
                oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
                if (oh_beg < 0    ) oh_beg = 0;
                if (oh_end > OH) oh_end = OH;
                int ow_beg, ow_end;
                ow_beg=div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
                ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
                if (ow_beg < 0    ) ow_beg = 0;
                if (ow_end > OW) ow_end = OW;
                if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0

                for (int ic = 0; ic < IC/G; ++ic) { // B
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                  float &dw = ((float*)diff_wei_m)[wei_off];
                  //dw = 0.f; // 2.2x --> 2.0x
                  for (int mb = 0; mb < MB; ++mb) {
                    for (int oh = oh_beg; oh < oh_end; ++oh) {
                      const int ih = oh * SH - PH + kh * (p->dh + 1);
                      for (int ow = ow_beg; ow < ow_end; ++ow) {
                        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                        const int iw = ow * SW - PW + kw * (p->dw + 1);
                        size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                        // Here's the problem: multiple 'mb' might update the same 'dw'
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
      }
#else
#error "oops enable a code section!"
#endif
}

}//conv::

// vim: et ts=2 sw=2 cindent cino^=l0,\:0,N-s
