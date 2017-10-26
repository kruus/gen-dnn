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
                    ///for (int ow = 0; ow < p->ow; ++ow) { //}
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    ///const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    ///if ( (iw >= 0 && iw < p->iw)) { //}
                    if (ow >= 0 && ow < p->ow) {                                  ///<--
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
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
                  //for (int ow = 0; ow < p->ow; ++ow) { //}
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    //if ( (iw >= 0 && iw < p->iw)) { //}
                    d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                  }
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
          //for (int kh = 0; kh < p->kh; ++kh) { //}
          for (int kh = kh_beg; kh < kh_end; ++kh) {
            const int ih = oh * p->sh - p->ph + kh * (p->dh + 1); //
            //if ( (ih >= 0 && ih < p->ih) ) { //}
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
        //for (int ic = 0; ic < p->ic/p->g; ++ic) { // 13.4x }
        for (int kh = 0; kh < p->kh; ++kh) { //
          int oh_beg, oh_end;
          hoist_ApiB_in( oh_beg, oh_end,
                         /*oh  in   */ 0, p->oh,
                         /*ih=A+ohB */ - p->ph + kh * (p->dh + 1), p->sh,
                         /*ih in    */ 0, p->iw);
          if( oh_beg >= oh_end ) continue;
          //for (int ic = 0; ic < p->ic/p->g; ++ic) { // 13.0x }
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

/** 6.3 x w/ conditional hoisting and loop order
 * g,mb,ic,oc,kh,kw,oh,[ih],ow,[iw] */
void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
                     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
{
#if 0 // 1.0 x with or without
#define KERN 0
#if KERN
  auto ker = [](
                const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &wei_m,
                float &ds, int g, int mb, int ic, int ih, int iw) {
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
  };
#endif
# pragma omp parallel for collapse(5)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
#if KERN
            ker( p, diff_dst_m, wei_m,
                 ds, g, mb, ic, ih, iw);
#else
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
#endif
          }
        }
      }
    }
  }
#elif 0 // 2.5x loop order
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
      }
    }
  }
#elif 0 // 0.6x assertions
# pragma omp parallel for collapse(2)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
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
      }
    }
  }
#elif 0 // 0.56x separate ih,iw,kw loops and print
# pragma omp parallel for collapse(2)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0; ///printf(" Z "); /// cannot move into kh-loop
          }
        }
        //printf("\nk,i,oh= "); int ocount = 0; ///ooo
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int kh = 0; kh < p->kh; ++kh) {
            int oh0 = ih - kh * (p->dh + 1) + p->ph;
            int oh = oh0 / p->sh;
            if (oh * p->sh != oh0) continue;
            if (oh < 0 || oh >= p->oh) continue;
            //printf( "%d,%d,%d%s", kh,ih,oh, (++ocount%10==0?"\n        ":"  ")); ///ooo
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
      }
    }
  }
#elif 0 // loop order change -- tricky : 0.5x (with debug)
#if 1
  auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
    return oh * p->sh - p->ph + kh * (p->dh+1);
  };
  auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
    return ow * p->sw - p->pw + kw * (p->dw+1);
  };
  const int ahh= div_floor( p->ph - (p->kh-1)*(p->dh+1), p->sh );
  const int bhh= ahh*p->sh - p->ph + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( p->pw - (p->kw-1)*(p->dw+1), p->sw );
  const int bww= aww*p->sw - p->pw + (p->kw-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
#endif
# pragma omp parallel for collapse(2)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        printf("\nk,i,oh= "); int ocount = 0; ///ooo
        //        const int iw0 = rem_floor( - p->pw + kw * (p->dw + 1), p->sw);  ///<--
        //        for (int iw = iw0; iw < p->iw; iw += p->sw) {                   ///<--
        //          const int ow = (iw + p->pw - kw * (p->dw + 1)) / p->sw;       ///<--
        //          if (ow < 0 || ow >= p->ow) continue;                          ///<--
        //          }
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
          //const int oh0 = oh_lowest; // moved above!
          const int ih_lowest = ih_at(p, oh_lowest, kh);
          print(10, "bwd_d ih_lowest = %d\n", ih_lowest);
          // NO RT_ASSERT( ih_lowest==0 );
          printf(" kh=%d,oh_lowest=%d:   ",kh,oh_lowest);
          RT_ASSERT( oh_lowest >= 0 );
          for (int oh = oh_lowest; oh < p->oh; ++oh) {
            //const int ih = oh*p->sh - p->ph + kh * (p->dh+1);
            const int ih = ih_at(p, oh, kh);
            // NO RT_ASSERT( ih >= 0 );
            // NO RT_ASSERT( ih < p->ih );
            if (oh==oh_lowest) RT_ASSERT(ih == ih_lowest);
            if( ih < 0 || ih >= p->ih ) continue;
            RT_ASSERT( ih >= 0 && ih < p->ih );
            RT_ASSERT( oh >= 0 && oh < p->oh );
            RT_ASSERT( kh >= 0 && kh < p->kh );
            printf( "%d,%d,%d%s", kh,ih,oh, (++ocount%10==0?"\n        ":"  ")); ///ooo
            RT_ASSERT( ih == oh*p->sh + kh * (p->dh + 1) - p->ph );

            for (int iw = 0; iw < p->iw; ++iw) {
              const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
              float &ds = ((float*)diff_src_m)[src_off];
              for (int kw = 0; kw < p->kw; ++kw) {
                int ow = iw - kw * (p->dw + 1) + p->pw;
                if (ow < 0 || ow % p->sw) continue;
                ow /= p->sw;
                if (ow >= p->ow) continue;
                for (int oc = 0; oc < p->oc/p->g; ++oc) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
#elif 0 // 2.0x : cleanup debug and do "same" for ih,iw,kw loops (no hoist yet)
#if 1
  auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
    return oh * p->sh - p->ph + kh * (p->dh+1);
  };
  auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
    return ow * p->sw - p->pw + kw * (p->dw+1);
  };
  const int ahh= div_floor( p->ph - (p->kh-1)*(p->dh+1), p->sh );
  const int bhh= ahh*p->sh - p->ph + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( p->pw - (p->kw-1)*(p->dw+1), p->sw );
  const int bww= aww*p->sw - p->pw + (p->kw-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
#endif
# pragma omp parallel for collapse(3)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int oh = oh_lowest; oh < p->oh; ++oh) {
            //const int ih = oh*p->sh - p->ph + kh * (p->dh+1);
            const int ih = ih_at(p, oh, kh);
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
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
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
#elif 0 // 2.3x : cleanup and hoist
#if 1
  auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
    return oh * p->sh - p->ph + kh * (p->dh+1);
  };
  auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
    return ow * p->sw - p->pw + kw * (p->dw+1);
  };
  const int ahh= div_floor( p->ph - (p->kh-1)*(p->dh+1), p->sh );
  const int bhh= ahh*p->sh - p->ph + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( p->pw - (p->kw-1)*(p->dw+1), p->sw );
  const int bww= aww*p->sw - p->pw + (p->kw-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
#endif
# pragma omp parallel for collapse(3)
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int ih = 0; ih < p->ih; ++ih) {
          for (int iw = 0; iw < p->iw; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        int oh_beg, oh_end;
        int ow_beg, ow_end;
        for (int kh = 0; kh < p->kh; ++kh) {
          const int ih_lowest = ih_at(p, oh_lowest, kh);
          hoist_ApiB_in( /* set     */ oh_beg, oh_end,
                         /*oh  in   */ oh_lowest, p->oh,
                         /*ih=A+ohB */ -p->ph + kh*(p->dh+1), p->sh, // B>0, ApiB OK
                         /*ih in    */ 0, p->ih);
          for (int oh = oh_beg; oh < oh_end; ++oh) {
            const int ih  =  oh*p->sh - p->ph + kh * (p->dh+1);
            //const int ih = ih_at(p, oh, kh);
            //if( ih < 0 || ih >= p->ih ) continue;
            //RT_ASSERT( ih >= 0 && ih < p->ih );
        // ---- hoisting w for loop order change and test removal
        for (int kw = 0; kw < p->kw; ++kw) {
          const int iw_lowest = iw_at(p, ow_lowest, kw);
          hoist_ApiB_in( /* set     */ ow_beg, ow_end,
                         /*ow  in   */ ow_lowest, p->ow,
                         /*iw=A+owB */ -p->pw + kw*(p->dw+1), p->sw, // B>0, ApiB OK
                         /*iw in    */ 0, p->iw);
          for (int ow = ow_beg; ow < ow_end; ++ow) {
            const int iw  =  ow*p->sw - p->pw + kw * (p->dw+1);
              const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
              float &ds = ((float*)diff_src_m)[src_off];
              // ----
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
#elif 1 // 6.27 x : minor loop reordering --- OK.
  //auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
  //  return oh * p->sh - p->ph + kh * (p->dh+1);
  //};
  //auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
  //  return ow * p->sw - p->pw + kw * (p->dw+1);
  //};
  const int ahh= div_floor( p->ph - (p->kh-1)*(p->dh+1), p->sh );
  const int bhh= ahh*p->sh - p->ph + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( p->pw - (p->kw-1)*(p->dw+1), p->sw );
  const int bww= aww*p->sw - p->pw + (p->kw-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
# pragma omp parallel for collapse(3) // dst_off_f(p, mb, g, oc, oh, ow);
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
          if(oc==0)
#       pragma omp parallel for collapse(2)
            for (int ih = 0; ih < p->ih; ++ih) {
              for (int iw = 0; iw < p->iw; ++iw) {
                const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                float &ds = ((float*)diff_src_m)[src_off];
                ds = 0;
              }
            }
          for (int kh = 0; kh < p->kh; ++kh) {
            //const int ih_lowest = ih_at(p, oh_lowest, kh);
            int oh_beg, oh_end;
            hoist_ApiB_in( /* set     */ oh_beg, oh_end,
                           /*oh  in   */ oh_lowest, p->oh,
                           /*ih=A+ohB */ -p->ph + kh*(p->dh+1), p->sh, // B>0, ApiB OK
                           /*ih in    */ 0, p->ih);
            for (int kw = 0; kw < p->kw; ++kw) {
              int ow_beg, ow_end;
              //const int iw_lowest = iw_at(p, ow_lowest, kw);
              hoist_ApiB_in( /* set     */ ow_beg, ow_end,
                             /*ow  in   */ ow_lowest, p->ow,
                             /*iw=A+owB */ -p->pw + kw*(p->dw+1), p->sw, // B>0, ApiB OK
                             /*iw in    */ 0, p->iw);
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              for (int oh = oh_beg; oh < oh_end; ++oh) {
                const int ih  =  oh*p->sh - p->ph + kh * (p->dh+1);
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  const int iw  =  ow*p->sw - p->pw + kw * (p->dw+1);
                  const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &ds = ((float*)diff_src_m)[src_off];
                  ds += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
                }
              }
            }
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
#if 0 // 1.15 x PT 1.10 x
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
#elif 0 // memset PT 1.13 x
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

  memset( (float*)diff_bia_m, 0, diff_bia_m.size() );
# pragma omp parallel for collapse(3)
  for (int mb = 0; mb < p->mb; ++mb) {
    for (int g = 0; g < p->g; ++g) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        for (int oh = 0; oh < p->oh; ++oh) {
          for (int ow = 0; ow < p->ow; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            db += ((float*)diff_dst_m)[dst_off];
          }
        }
      }
    }
  }
#elif 0 // PT 0.814x zero mem up front, no group loop
  // PT 0.9x this allow for-mb to move outside the 'dw=0' init, [not yet useful]
#pragma omp parallel 
  for (int oc=0; oc < p->oc; ++oc) {
#if 1
    size_t bia_off = bia_off_f_nog(p, oc);
    float &db = ((float*)diff_bia_m)[bia_off];
    db = 0;
#endif
  }
#   pragma omp parallel for collapse(4)
  for (int oc=0; oc < p->oc; ++oc) {
    for (int ic = 0; ic < p->ic; ++ic) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < p->kw; ++kw) {
          size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
          float &dw = ((float*)diff_wei_m)[wei_off];
          dw = 0;
        }
      }
    }
  }

  //float const bia01 = (p->dir & FLAG_BIA? 1.0f: 0.0f);
#   pragma omp parallel for collapse(6)
            for (int mb = 0; mb < p->mb; ++mb) {
  for (int g = 0; g < p->g; ++g) {
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < p->kw; ++kw) {
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            float &dw = ((float*)diff_wei_m)[wei_off];
            //dw = 0;
            //for (int mb = 0; mb < p->mb; ++mb) {
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
#if 0
  if ((p->dir & FLAG_BIA)) { // ouch!
      size_t bia_off = bia_off_f(p, g, oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      db += ((float*)diff_dst_m)[dst_off];
  }
#endif
#if 0 // no better
      size_t bia_off = bia_off_f(p, g, oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      db += bia01 * ((float*)diff_dst_m)[dst_off];
#endif
                }
              }
            }
          }
        }
      }
    }
  }

  if (!(p->dir & FLAG_BIA)) return;
  for (int g = 0; g < p->g; ++g) {
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      size_t bia_off = bia_off_f(p, g, oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      db = 0;
#   pragma omp parallel for collapse(3)
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
#elif 0 // PT 1.0x just cleaning up above mess
  // PT 0.9x this allow for-mb to move outside the 'dw=0' init, [not yet useful]
  for (int oc=0; oc < p->oc; ++oc) {
    size_t bia_off = bia_off_f_nog(p, oc);
    float &db = ((float*)diff_bia_m)[bia_off];
    db = 0;
  }
#     pragma omp parallel for collapse(4)
  for (int oc=0; oc < p->oc; ++oc) {
    for (int ic = 0; ic < p->ic; ++ic) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < p->kw; ++kw) {
          size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
          float &dw = ((float*)diff_wei_m)[wei_off];
          dw = 0;
        }
      }
    }
  }

#   pragma omp parallel for collapse(6)
            for (int mb = 0; mb < p->mb; ++mb) {
  for (int g = 0; g < p->g; ++g) { // still with conditionals
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      for (int ic = 0; ic < p->ic/p->g; ++ic) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < p->kw; ++kw) {
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            float &dw = ((float*)diff_wei_m)[wei_off];
            //dw = 0;
            //for (int mb = 0; mb < p->mb; ++mb) {
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
  for (int g = 0; g < p->g; ++g) {
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
      size_t bia_off = bia_off_f(p, g, oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      //db = 0;
#   pragma omp parallel for collapse(3)
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
#elif 0 // PT 3.60x clean version
  // 4.5x(6t), 6.4x(1t) chg loop order, collapse. Hoist as in ref_conv3, move code 'up', early-continue
  // zero the entire wei_off memory as a first step (NO minibatch loop)
  //memset( (float*)diff_wei_m, 0, diff_wei_m.size() ); // now can move mb loop freely
# pragma omp parallel for collapse(2)
  for (int ic = 0; ic < p->ic; ++ic) { // dw = 0
    for (int oc=0; oc < p->oc; ++oc) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < p->kw; ++kw) {
          size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
          float &dw = ((float*)diff_wei_m)[wei_off];
          dw = 0;
        }
      }
    }
  }
# pragma omp parallel for collapse(4)
  for (int mb = 0; mb < p->mb; ++mb) { // hoisted conditionals + loop reorder
    for (int g = 0; g < p->g; ++g) {
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
          if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
          for (int ic = 0; ic < p->ic/p->g; ++ic) {
            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
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
  if (!(p->dir & FLAG_BIA)) return;

  //if ((p->dir & FLAG_BIA)) memset( (float*)diff_bia_m, 0, diff_bia_m.size() );
# pragma omp parallel for collapse(2)
  for (int g = 0; g < p->g; ++g) { // full update of diff_bia_m
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
#elif 0 // PT 3.59x playing with 'memset'
  for (int oc=0; oc < p->oc; ++oc) { // db = 0, dw = 0
#   pragma omp parallel
    {
      size_t bia_off = bia_off_f_nog(p, oc);
      float &db = ((float*)diff_bia_m)[bia_off];
      db = 0;
#     pragma omp for collapse(3) // dw = 0
      for (int ic = 0; ic < p->ic; ++ic) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < p->kw; ++kw) {
            size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
            float &dw = ((float*)diff_wei_m)[wei_off];
            dw = 0;
          }
        }
      }
    }
  }
# pragma omp parallel for collapse(4)
  for (int mb = 0; mb < p->mb; ++mb) {
    for (int g = 0; g < p->g; ++g) {
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
          if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
          for (int ic = 0; ic < p->ic/p->g; ++ic) {
            for (int oc = 0; oc < p->oc/p->g; ++oc) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
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
#pragma omp parallel for collapse(1) // PT 3.6x
  //for (int g = 0; g < p->g; ++g) {
    for (int oc = 0; oc < p->oc; ++oc) {
//#pragma omp parallel // PT 2.70x
      {
        size_t bia_off = bia_off_f_nog(p, /*g, */oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        //db = 0;
//# pragma omp for collapse(3)
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


#elif 0 // PT 3.7-4.3x hoist conditionals (including the modulus check !!)
# pragma omp parallel for collapse(2)
  for (int ic = 0; ic < p->ic; ++ic) { // dw = 0
    for (int oc=0; oc < p->oc; ++oc) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < p->kw; ++kw) {
          size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
          float &dw = ((float*)diff_wei_m)[wei_off];
          dw = 0;
        }
      }
    }
  }
//# pragma omp parallel for collapse(3) // PT 3.4x (and move down 'mb')
// 1.19x for no omp
# pragma omp parallel for collapse(4) // PT 4.0x (loop reorder
  for (int g = 0; g < p->g; ++g) {
    for (int ic = 0; ic < p->ic/p->g; ++ic) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int mb = 0; mb < p->mb; ++mb) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
              //#pragma omp parallel // PT 3.5x
              {
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
                if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
                //#pragma omp for collapse(2)
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                float &dw = ((float*)diff_wei_m)[wei_off];
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
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
  }
  if (!(p->dir & FLAG_BIA)) return;

#pragma omp parallel for collapse(2) // PT 3.6x
  for (int g = 0; g < p->g; ++g) {
    for (int oc = 0; oc < p->oc/p->g; ++oc) {
//#pragma omp parallel // PT 2.70x, 2.88x
      {
        size_t bia_off = bia_off_f(p, g, oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        db = 0;
//# pragma omp for collapse(3)
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
#elif 1 // PT 3.48x original loop merge attempt [old]
  // 7.3x(1t), 6.5x(6t) loop reorder and merge diff_wei and diff_dst loops
  // BUT might not scale to large # threads as well for small mb, g
  // zero the entire wei_off memory as a first step (NO minibatch loop)
  //memset( (float*)diff_wei_m, 0, diff_wei_m.size() ); // now can move mb loop freely
  for (int oc=0; oc < p->oc; ++oc) {
    size_t bia_off = bia_off_f_nog(p, oc);
    float &db = ((float*)diff_bia_m)[bia_off];
    db = 0;
#   pragma omp parallel for collapse(3)
    for (int ic = 0; ic < p->ic; ++ic) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < p->kw; ++kw) {
          size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
          float &dw = ((float*)diff_wei_m)[wei_off];
          dw = 0;
        }
      }
    }
  }

  if ((p->dir & FLAG_BIA)) memset( (float*)diff_bia_m, 0, diff_bia_m.size() );
# pragma omp parallel for collapse(3)
  for (int mb = 0; mb < p->mb; ++mb) {
    for (int g = 0; g < p->g; ++g) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        if ((p->dir & FLAG_BIA)) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          for (int oh = 0; oh < p->oh; ++oh) {
            for (int ow = 0; ow < p->ow; ++ow) {
              size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
              db += ((float*)diff_dst_m)[dst_off];
            }
          }
        }
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
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
            for (int ic = 0; ic < p->ic/p->g; ++ic) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
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
#elif 0 // PT 0.91x huh. this loop merge is now seeming really a bad idea.
  // 3.85x loop merge ??? not any better
  // 7.3x(1t), 6.5x(6t) loop reorder and merge diff_wei and diff_dst loops
  // BUT might not scale to large # threads as well for small mb, g
  // zero the entire wei_off memory as a first step (NO minibatch loop)
  //memset( (float*)diff_wei_m, 0, diff_wei_m.size() ); // now can move mb loop freely
#pragma ompo parallel for
  for (int oc=0; oc < p->oc; ++oc) {
    size_t bia_off = bia_off_f_nog(p, oc);
    float &db = ((float*)diff_bia_m)[bia_off];
    db = 0;
  }
# pragma omp parallel for collapse(4)
  for (int ic = 0; ic < p->ic; ++ic) {
    for (int oc=0; oc < p->oc; ++oc) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < p->kw; ++kw) {
          size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
          float &dw = ((float*)diff_wei_m)[wei_off];
          dw = 0;
        }
      }
    }
  }
#pragma parallel for collapse(4) // 0.76
  for (int g = 0; g < p->g; ++g) {
    for (int mb = 0; mb < p->mb; ++mb) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
      for (int oc = 0; oc < p->oc/p->g; ++oc) {
        if ((p->dir & FLAG_BIA)) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
//#pragma parallel for collapse(2)
          for (int oh = 0; oh < p->oh; ++oh) {
            for (int ow = 0; ow < p->ow; ++ow) {
              size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
              db += ((float*)diff_dst_m)[dst_off];
            }
          }
        }
//#pragma parallel for collapse(3) // 3.71x
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
              //#pragma omp parallel // PT 3.5x
              {
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
                if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
                //#pragma omp for collapse(2)
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                float &dw = ((float*)diff_wei_m)[wei_off];
//#pragma parallel for collapse(2) // 0.75x
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
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
  }
#else
#error "oops enable a code section!"
#endif
}

}//conv::

// vim: et ts=2 sw=2 cindent cino^=l0,\:0,N-s foldmethod=indent
