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
 * remove lambdas */
#include "conv.hpp"
#include "../idiv.hpp"

namespace conv {

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
    //DMUST( a + (beg-1)*b < c );
    //DMUST( a + (beg  )*b >= c );
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
    //DMUST( a + (end-1)*b < d );
    //DMUST( a + (end  )*b >= d );
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
                   dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {

  auto bias_zero = []( const prb_t *p, const dnn_mem_t &bia_m,
                       const size_t bia_off, const dnn_mem_t &dst_m,
                       const int mb, const int g, const int oc, const int oh ) {
    if (p->dir & FLAG_BIA){
      for (int ow = 0; ow < p->ow; ++ow) {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
      }
    } else {
      for (int ow = 0; ow < p->ow; ++ow) {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        d = 0;
      }
    }
  };
  auto bias_relu = []( const prb_t *p, const dnn_mem_t &bia_m,
                       const size_t bia_off, const dnn_mem_t &dst_m,
                       const int mb, const int g, const int oc, const int oh ) {
    if (p->merge == RELU){
      for (int ow = 0; ow < p->ow; ++ow) {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        if (d < 0)
          d = 0;
      }
    }
  };
#   pragma omp parallel for collapse(3)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
#if 0 // 1.50 x
        for (int oh = 0; oh < p->oh; ++oh) {
          for (int ow = 0; ow < p->ow; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
            for (int kh = 0; kh < p->kh; ++kh) { //
              const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
              if ( (ih >= 0 && ih < p->ih) ) { //2
                for (int ic = 0; ic < p->ic/p->g; ++ic) {
                  for (int kw = 0; kw < p->kw; ++kw) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    if ( (iw >= 0 && iw < p->iw))
                    {
                      size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                      size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
              } //2
            } //
            if (p->merge == RELU && d < 0)
              d = 0;
          }
        }
#elif 0 // 1.54 x
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          //for (int kh = 0; kh < p->kh; ++kh)
          for (int ow = 0; ow < p->ow; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            //d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
            for (int kh = 0; kh < p->kh; ++kh) { //
              const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
              if ( (ih >= 0 && ih < p->ih) ) { //2
                for (int ic = 0; ic < p->ic/p->g; ++ic) {
                  for (int kw = 0; kw < p->kw; ++kw) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    if ( (iw >= 0 && iw < p->iw))
                    {

                      size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                      size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
              } //2
            } //
            if (p->merge == RELU && d < 0)
              d = 0;
          }
        }
#elif 0 // 1.64 x
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          //for (int ic = 0; ic < p->ic/p->g; ++ic) 1.53 x
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int ic = 0; ic < p->ic/p->g; ++ic) // 1.65 x
                for (int ow = 0; ow < p->ow; ++ow) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  //for (int ic = 0; ic < p->ic/p->g; ++ic) // 1.61 x
                  for (int kw = 0; kw < p->kw; ++kw) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    if ( (iw >= 0 && iw < p->iw))
                    {
                      size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                      size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
            }
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
#if 0
          for (int ow = 0; ow < p->ow; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            if (p->merge == RELU && d < 0)
              d = 0;
          }
#endif
        }
#elif 0 // 3.20 x
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int ic = 0; ic < p->ic/p->g; ++ic) // 1.65 x
                for (int ow = 0; ow < p->ow; ++ow) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  for (int kw = 0; kw < p->kw; ++kw) {
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    if ( (iw >= 0 && iw < p->iw))
                    {
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
            }
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // assert
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int ic = 0; ic < p->ic/p->g; ++ic) // 1.65 x
                for (int ow = 0; ow < p->ow; ++ow) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  for (int kw = 0; kw < p->kw; ++kw) {
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    if ( (iw >= 0 && iw < p->iw))
                    {
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
            }
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // 6.09 x
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int ic = 0; ic < p->ic/p->g; ++ic) {
                for (int kw = 0; kw < p->kw; ++kw) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  for (int ow = 0; ow < p->ow; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    if ( (iw >= 0 && iw < p->iw)) {
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
              }
            }
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // 2.97 x (replace loop over ow with loop over iw: not so good, strided index)
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int ic = 0; ic < p->ic/p->g; ++ic) {
                for (int kw = 0; kw < p->kw; ++kw) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  const int iw0 = rem_floor( - p->pw + kw * (p->dw + 1), p->sw);  ///<--
                  for (int iw = iw0; iw < p->iw; iw += p->sw) {                   ///<--
                    const int ow = (iw + p->pw - kw * (p->dw + 1)) / p->sw;       ///<--
                    //if (ow < 0 || ow >= p->ow) continue;                          ///<--
                    ///for (int ow = 0; ow < p->ow; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    ///const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    ///if ( (iw >= 0 && iw < p->iw)) {
                    if (ow >= 0 && ow < p->ow) {                                  ///<--
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                      ///}
                      ///}
                  }
                  }
                }
              }
            }
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // 5.92 x (hoist ow, maybe slower)
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int ic = 0; ic < p->ic/p->g; ++ic) {
                for (int kw = 0; kw < p->kw; ++kw) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  int ow_beg, ow_end;
                  hoist_ApiB_in( ow_beg, ow_end,
                                 /*ow  in   */ 0, p->ow,
                                 /*iw=A+owB */ - p->pw + kw * (p->dw + 1), p->sw,
                                 /*iw in    */ 0, p->iw);
                  //for (int ow = 0; ow < p->ow; ++ow) {
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    //if ( (iw >= 0 && iw < p->iw)) {
                    d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    //}
                  }
                  //}
                }
              }
            }
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // 6.60 x
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int kw = 0; kw < p->kw; ++kw) {
                for (int ic = 0; ic < p->ic/p->g; ++ic) { // <--- !!!
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  int ow_beg, ow_end;
                  hoist_ApiB_in( ow_beg, ow_end,
                                 /*ow  in   */ 0, p->ow,
                                 /*iw=A+owB */ - p->pw + kw * (p->dw + 1), p->sw,
                                 /*iw in    */ 0, p->iw);
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                  }
                }
              }
            }
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // 6.3 x hoist kh ?
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          int kh_beg, kh_end;
                  hoist_ApiB_in( kh_beg, kh_end,
                                 /*kh  in   */ 0, p->kh,
                                 /*ih=A+khB */ oh * p->sh - p->ph, p->dh+1,
                                 /*ih in    */ 0, p->ih);
          //for (int kh = 0; kh < p->kh; ++kh) { //
          for (int kh = kh_beg; kh < kh_end; ++kh) { //
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            //if ( (ih >= 0 && ih < p->ih) ) { //2
              for (int kw = 0; kw < p->kw; ++kw) {
                for (int ic = 0; ic < p->ic/p->g; ++ic) { // <--- !!!
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  int ow_beg, ow_end;
                  hoist_ApiB_in( ow_beg, ow_end,
                                 /*ow  in   */ 0, p->ow,
                                 /*iw=A+owB */ - p->pw + kw * (p->dw + 1), p->sw,
                                 /*iw in    */ 0, p->iw);
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                  }
                }
              }
            //}
          }
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // 7.9 x loop over ih,kh ?
        for (int oh = 0; oh < p->oh; ++oh) {
            bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
        for (int kh = 0; kh < p->kh; ++kh) { //
            int oh_beg, oh_end;
            hoist_ApiB_in( oh_beg, oh_end,
                           /*oh  in   */ 0, p->oh,
                           /*ih=A+ohB */ - p->ph + kh * (p->dh + 1), p->sh,
                           /*ih in    */ 0, p->iw);
                //for (int ih = 0; kh < p->kh; ++kh) //
                //          const int oh0 = rem_floor( - p->pw + kw * (p->dw + 1), p->dh+1);  ///<--
                //          for (int iw = iw0; iw < p->iw; iw += p->sw)                   ///<--
                //            const int ow = (iw + p->pw - kw * (p->dw + 1)) / p->sw;       ///<--
                //            //if (ow < 0 || ow >= p->ow) continue;                          ///<--
                //const int kkh = ( ih + p->ph - oh * p->sh) / (p->dh + 1);
                ////const int kkh = div_floor( ih + p->ph - oh * p->sh , p->dh + 1);
                //RT_ASSERT( kkh == kh );
                //if (kh < 0 || kh >= p->kh) continue;
                //if (ih < 0 || ih >= p->ih) continue;
                for (int kw = 0; kw < p->kw; ++kw) {
                    for (int ic = 0; ic < p->ic/p->g; ++ic) { // <--- !!!
                        size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                        int ow_beg, ow_end;
                        hoist_ApiB_in( ow_beg, ow_end,
                                       /*ow  in   */ 0, p->ow,
                                       /*iw=A+owB */ - p->pw + kw * (p->dw + 1), p->sw,
                                       /*iw in    */ 0, p->iw);
                        for (int ow = ow_beg; ow < ow_end; ++ow) {
                            const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
            for (int oh = oh_beg; oh < oh_end; ++oh) {
                const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
                            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                            float &d = ((float*)dst_m)[dst_off];
                            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                            d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                        }
                    }
                }
            }
        }
        for (int oh = 0; oh < p->oh; ++oh) {
            bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 0 // 14.5 x hoist kh,ih, change loop order, add back early test for oh_beg/end
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
        for (int kh = 0; kh < p->kh; ++kh) { //
          int oh_beg, oh_end;
          hoist_ApiB_in( oh_beg, oh_end,
                         /*oh  in   */ 0, p->oh,
                         /*ih=A+ohB */ - p->ph + kh * (p->dh + 1), p->sh,
                         /*ih in    */ 0, p->iw);
          if( oh_beg >= oh_end ) continue;
          for (int kw = 0; kw < p->kw; ++kw) {
            for (int ic = 0; ic < p->ic/p->g; ++ic) { // <--- !!!
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                             /*ow  in   */ 0, p->ow,
                             /*iw=A+owB */ - p->pw + kw * (p->dw + 1), p->sw,
                             /*iw in    */ 0, p->iw);
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                }
              }
            }
          }
        }
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#elif 1 // 15 x hoist kh,ih, change loop order, add back early test for oh_beg/end
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_zero(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
        //for (int ic = 0; ic < p->ic/p->g; ++ic) { // 13.4x
        for (int kh = 0; kh < p->kh; ++kh) { //
          int oh_beg, oh_end;
          hoist_ApiB_in( oh_beg, oh_end,
                         /*oh  in   */ 0, p->oh,
                         /*ih=A+ohB */ - p->ph + kh * (p->dh + 1), p->sh,
                         /*ih in    */ 0, p->iw);
          if( oh_beg >= oh_end ) continue;
          //for (int ic = 0; ic < p->ic/p->g; ++ic) { // 13.0x
          for (int kw = 0; kw < p->kw; ++kw) {
            for (int ic = 0; ic < p->ic/p->g; ++ic) { // 13.0x
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                             /*ow  in   */ 0, p->ow,
                             /*iw=A+owB */ - p->pw + kw * (p->dw + 1), p->sw,
                             /*iw in    */ 0, p->iw);
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
                  size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                }
              }
            }
          }
        }
        for (int oh = 0; oh < p->oh; ++oh) {
          bias_relu(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
        }
#endif
      }
    }
  }
}

void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
                     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
{
  const int a = div_floor( p->ph - (p->kh-1)*(p->dh+1), p->sh );
  const int b = a*p->sh - p->ph + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (b>0? b: 0); /// oh wow, oh0 is INDEPENDENT of all loop vars
#   pragma omp parallel for collapse(2)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
#if 0
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            {
              for (int oc = 0; oc < p->oc/p->g; ++oc) {
                for (int kh = 0; kh < p->kh; ++kh) {
                  int oh = ih - kh * (p->dh + 1) + p->ph;
                  if (oh < 0 || oh % p->sh) continue;
                  oh /= p->sh;
                  if (oh >= p->oh) continue;

                  for (int kw = 0; kw < p->kw; ++kw) {
                    int ow = iw - kw * (p->dw + 1) + p->pw;
                    if (ow < 0 || ow % p->sw) continue;
                    ow /= p->sw;
                    if (ow >= p->ow) continue;

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
#elif 0 // 2.5x loop order
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            for (int kh = 0; kh < p->kh; ++kh) {
              int oh = ih - kh * (p->dh + 1) + p->ph;
              if (oh < 0 || oh % p->sh) continue;
              oh /= p->sh;
              if (oh >= p->oh) continue;

              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                if (ow < 0 || ow % p->sw) continue;
                ow /= p->sw;
                if (ow >= p->ow) continue;

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
#elif 0 // 2.4x loop order
        // bounds, then branch (easy case: p-dh == 0)
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            // for oh ...
            //   ih = ...; 
            //   kh_beg/end mod for p->sh edge cases
            for (int kh = 0; kh < p->kh; ++kh) {
              int oh0 = ih - kh * (p->dh + 1) + p->ph;
              //if (oh0 % p->sh) continue;
              int oh = oh0 / p->sh;
              if (oh < 0 || oh >= p->oh) continue;
              if (oh * p->sh != oh0) continue;
              RT_ASSERT( ih == oh*p->sh + kh * (p->dh + 1) - p->ph );
              //const int iih = oh + kh * (p->dh + 1) - p->ph;
              //RT_ASSERT( iih == ih );
              //if (oh < 0 ) continue;
              //RT_ASSERT( p->sh > 0 );
              ////if (oh % p->sh) continue;             ///<---
              //RT_ASSERT( oh/p->sh*p->sh == oh );
              //oh /= p->sh;
              //RT_ASSERT( oh*p->sh == oh*p->sh );
              ////if (oh * p->sh != oh) continue;
              //RT_ASSERT( ih == oh*p->sh + kh * (p->dh + 1) - p->ph );
              //if (oh >= p->oh) continue;

              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                if (ow < 0 || ow % p->sw) continue;
                ow /= p->sw;
                if (ow >= p->ow) continue;
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
#elif 0 // separate ih,iw,kw loops and print
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0; ///printf(" Z "); /// cannot move into kh-loop
          }
        }
        printf("\nk,i,oh= "); int ocount = 0; ///ooo
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int kh = 0; kh < p->kh; ++kh) {
            int oh0 = ih - kh * (p->dh + 1) + p->ph;
            int oh = oh0 / p->sh;
            if (oh < 0 || oh >= p->oh) continue;
            if (oh * p->sh != oh0) continue;
            printf( "%d,%d,%d%s", kh,ih,oh, (++ocount%10==0?"\n        ":"  ")); ///ooo
            RT_ASSERT( ih == oh*p->sh + kh * (p->dh + 1) - p->ph );

            for (int iw = 0; iw < p->iw; ++iw) {
              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                if (ow < 0 || ow % p->sw) continue;
                ow /= p->sw;
                if (ow >= p->ow) continue;
                for (int oc = 0; oc < p->oc/p->g; ++oc) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  float &ds = ((float*)diff_src_m)[src_off];
                  ds += ((float*)diff_dst_m)[dst_off]
                    * ((float*)wei_m)[wei_off];
                }
              }
            }
          }
        }
#elif 0 // loop order change -- tricky
        printf("\nk,i,oh= "); int ocount = 0; ///ooo
#if 0
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int kh = 0; kh < p->kh; ++kh) {
            int oh0 = ih - kh * (p->dh + 1) + p->ph;
            int oh = oh0 / p->sh;
            if (oh < 0 || oh >= p->oh) continue;
            if (oh * p->sh != oh0) continue;
            printf( "%s%d,%d,%d", (++ocount%10==1?"\n       ":"  "), kh,ih,oh ); ///ooo
            RT_ASSERT( ih == oh*p->sh + kh * (p->dh + 1) - p->ph );
#else
        //        const int iw0 = rem_floor( - p->pw + kw * (p->dw + 1), p->sw);  ///<--
        //        for (int iw = iw0; iw < p->iw; iw += p->sw) {                   ///<--
        //          const int ow = (iw + p->pw - kw * (p->dw + 1)) / p->sw;       ///<--
        //          if (ow < 0 || ow >= p->ow) continue;                          ///<--
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          ///int oh00 = ih + p->ph - kh * (p->dh + 1);
          ///int oh = oh00 / p->sh
          // lowest oh is for ih="near zero" kh=p->kh-1:
          //     oh = (ih + p->ph - (p->kh-1)*(p->dh+1)) / p->sh; // almost OK
          //     oh = (ih + p->ph - (p->kh-1)*(p->dh+1)) / p->sh; // almost OK
          //const int a = div_floor( p->ph - (p->kh-1)*(p->dh+1), p->sh );
          //const int b = a*p->sh - p->ph + (p->kh-1) * (p->dh+1);
          //const int oh0 = (b>0? b: 0); /// oh wow, oh0 is INDEPENDENT of all loop vars
          const int oh0 = oh_lowest; // moved above!
          printf(" kh=%d,oh0=%d:   ",kh,oh0);
          RT_ASSERT( oh0 >= 0 );
          for (int oh = oh0; oh < p->oh; ++oh) {
            const int ih = oh*p->sh - p->ph + kh * (p->dh+1);
            if( ih < 0 || ih >= p->ih ) continue;
            RT_ASSERT( ih >= 0 && ih < p->ih );
            RT_ASSERT( oh >= 0 && oh < p->oh );
            RT_ASSERT( kh >= 0 && kh < p->kh );
            printf( "%d,%d,%d%s", kh,ih,oh, (++ocount%10==0?"\n        ":"  ")); ///ooo
            RT_ASSERT( ih == oh*p->sh + kh * (p->dh + 1) - p->ph );
#endif
            for (int iw = 0; iw < p->iw; ++iw) {
              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                if (ow < 0 || ow % p->sw) continue;
                ow /= p->sw;
                if (ow >= p->ow) continue;
                for (int oc = 0; oc < p->oc/p->g; ++oc) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
                  ds += ((float*)diff_dst_m)[dst_off]
                    * ((float*)wei_m)[wei_off];
                }
              }
            }
          }
        }
#elif 1 // cleanup debug and do "same" for ih,iw,kw loops XXX
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int oh = oh_lowest; oh < p->oh; ++oh) {
            const int ih = oh*p->sh - p->ph + kh * (p->dh+1);
            if( ih < 0 || ih >= p->ih ) continue;

            for (int iw = 0; iw < p->iw; ++iw) {
              const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
              float &ds = ((float*)diff_src_m)[src_off];
              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                if (ow < 0 || ow % p->sw) continue;
                ow /= p->sw;
                if (ow >= p->ow) continue;
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
#elif 1
#error "oops"
#endif
      }
    }
  }
}

void refconv_4_bwd_w(const prb_t *p, dnn_mem_t &src_m,
                     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m)
{
#   pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < p->kw; ++kw) {
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            float &dw = ((float*)diff_wei_m)[wei_off];
            dw = 0;
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

}//conv::

// vim: et ts=2 sw=2 cindent cino^=l0,\:0,N-s
