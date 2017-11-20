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
#if 0 // 1.37x regr 1.44x; regr.sh-FWD 1.31x,1.31x
#pragma omp parallel for collapse(5)
  FWD_g_mb_oc_oh_ow {
    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
    size_t bia_off = bia_off_f(p, g, oc);
    float &d = ((float*)dst_m)[dst_off];
    d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
    // copy from ref_conv2 kernel ...
    for (int ic = 0; ic < IC/G; ++ic) {
      for (int kh = 0; kh < p->kh; ++kh) {
        const int ih = oh * SH - PH + kh * (p->dh + 1);
        if (ih < 0 || ih >= IH) continue;

        for (int kw = 0; kw < KW; ++kw) {
          const int iw = ow * SW - PW + kw * (p->dw + 1);
          if (iw < 0 || iw >= IW) continue;

          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
        }
      }
    }
    // *******************       writing to dst[ p,mb,g,oc,oh,ow ]
    if (p->merge == RELU && d < 0) d = 0;
  }
#elif 0 // 1.37x regr 1.71x... 1.88x,1.91x regrs.sh-FWD 1.46x,1.44x ****************
#pragma omp parallel for collapse(5)
  FWD_g_mb_oc_oh_ow {
    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
    size_t bia_off = bia_off_f(p, g, oc);
    float &d = ((float*)dst_m)[dst_off];
    d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
    for (int ic = 0; ic < IC/G; ++ic) {
      for (int kh = 0; kh < p->kh; ++kh) {
        const int ih = oh * SH - PH + kh * (p->dh + 1);
        const bool ihok = ih >= 0 && ih < IH;
        for (int kw = 0; kw < KW; ++kw) {
          const int iw = ow * SW - PW + kw * (p->dw + 1);
          const bool ihwok = ihok && iw >= 0 && iw < IW;

          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          //d += ihwok? ((float *)src_m)[src_off] * ((float *)wei_m)[wei_off]
          //      : 0.f; // 1.71x
          d = ihwok? ((float *)src_m)[src_off] * ((float *)wei_m)[wei_off] + d
            : d; // 1.88x
        }
      }
    }
    // *******************       writing to dst[ p,mb,g,oc,oh,ow ]
    if (p->merge == RELU && d < 0) d = 0;
    //const bool z =  p->merge == RELU && d < 0;
    //d = z? 0.f: d;
  }
#elif 0 // not faster; regr.sh-FWD 1.48x,1.44x
  //const int n = omp_get_num_threads();
  //omp_set_nested(true);
  //float tmp = 0.f;
//#pragma omp parallel for collapse(5) reduction(+:tmp)
//#pragma omp parallel for collapse(5) num_threads((n+1)/2)
#pragma omp parallel for collapse(5)
  FWD_g_mb_oc_oh_ow {
    //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
    //float &d = ((float*)dst_m)[dst_off];
    //size_t bia_off = bia_off_f(p, g, oc);
    //d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
    float tmp = 0.f;
    //#pragma omp parallel for num_threads(2) private(tmp)
    for (int ic = 0; ic < IC/G; ++ic) {
      for (int kh = 0; kh < p->kh; ++kh) {
        const int ih = oh * SH - PH + kh * (p->dh + 1);
        const bool ihok = ih >= 0 && ih < IH;
        for (int kw = 0; kw < KW; ++kw) {
          const int iw = ow * SW - PW + kw * (p->dw + 1);
          const bool ihwok = ihok && iw >= 0 && iw < IW;

          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          //d += ihwok? ((float *)src_m)[src_off] * ((float *)wei_m)[wei_off]
          //      : 0.f; // 1.71x
          //d = ihwok? ((float *)src_m)[src_off] * ((float *)wei_m)[wei_off] + d
          //      : d; // 1.88x
          tmp +=  ihwok? ((float *)src_m)[src_off] * ((float *)wei_m)[wei_off]: 0.f;
        }
      }
    }
    // *******************       writing to dst[ p,mb,g,oc,oh,ow ]
    size_t bia_off = bia_off_f(p, g, oc);
    tmp += (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0.f;
    if (p->merge == RELU && tmp < 0) tmp = 0;
    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
    float &d = ((float*)dst_m)[dst_off];
    //#pragma omp atomic
    d = tmp;
    //if (p->merge == RELU && d < 0) d = 0;
    //const bool z =  p->merge == RELU && d < 0;
    //d = z? 0.f: d;
  }
#elif 0 //xdst_init loop? 1.34x, 1.42x (slower); regr.sh-FWD 1.23x,1.25x1.23x
  if(1){
      xdst_init(p, bia_m, dst_m); // either 0 or bias, dep on (p->dir & FLAG_BIA)
  }else{
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
  }
#pragma omp parallel for collapse(5) schedule(static)
  FWD_g_mb_oc_oh_ow {
    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
    float &d = ((float*)dst_m)[dst_off];
    //size_t bia_off = bia_off_f(p, g, oc);
    //d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
    //RT_ASSERT( d == ((p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0) );
    for (int ic = 0; ic < IC/G; ++ic) {
      for (int kh = 0; kh < p->kh; ++kh) {
        const int ih = oh * SH - PH + kh * (p->dh + 1);
        const bool ihok = ih >= 0 && ih < IH;
        for (int kw = 0; kw < KW; ++kw) {
          const int iw = ow * SW - PW + kw * (p->dw + 1);
          const bool ihwok = ihok && iw >= 0 && iw < IW;

          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          d += ihwok? ((float *)src_m)[src_off] * ((float *)wei_m)[wei_off]
            : 0.f; // 1.71x; 1.44x
          //d = ihwok? d + ((float *)src_m)[src_off] * ((float *)wei_m)[wei_off]
          //      : d; // 1.88x; 1.42x (no big diff)
        }
      }
    }
    // *******************       writing to dst[ p,mb,g,oc,oh,ow ]
    if (p->merge == RELU && d < 0) d = 0;
    //const bool z =  p->merge == RELU && d < 0;
    //d = z? 0.f: d;
  }
#elif 0 // WRONG omp || construction !!! ??? regr.sh-FWD 1.18x
#pragma omp parallel
  {
    if(0){
      xdst_init(p, bia_m, dst_m); // either 0 or bias, dep on (p->dir & FLAG_BIA)
    }else{
      if (p->dir & FLAG_BIA){
#pragma omp for collapse(5) schedule(static)
        FWD_g_mb_oc_oh_ow {
          size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
          size_t bia_off = bia_off_f(p, g, oc);
          float &d = ((float*)dst_m)[dst_off];
          d = ((float*)bia_m)[bia_off];
        }
      }else{
#pragma omp for collapse(5) schedule(static)
        FWD_g_mb_oc_oh_ow {
          size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
          float &d = ((float*)dst_m)[dst_off];
          d = 0;
        }
      }
    }
#pragma omp for collapse(5) schedule(static)
    FWD_g_mb_oc_oh_ow {
      size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
      float &d = ((float *)dst_m)[dst_off];
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int kh = 0; kh < p->kh; ++kh) {
          const int ih = oh * SH - PH + kh * (p->dh + 1);
          bool const ihok = ih >= 0 && ih < IH;
          for (int kw = 0; kw < KW; ++kw) {
            const int iw = ow * SW - PW + kw * (p->dw + 1);
            bool const iwok = ihok && iw >= 0 && iw < IW;

            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            d = (iwok? d + ((float *)src_m)[src_off]
                 * ((float *)wei_m)[wei_off]: d);
          }
        }
      }
    }
  }
#elif 0 // split off zero and relu loops (remove conditional --> PTfwd=1.474 regr 1.46x
  // regr 1.0x; regr.sh-FWD 1.02x
  xdst_init(p, bia_m, dst_m);
#pragma omp parallel
# pragma omp for collapse(5)
  FWD_g_mb_oc_oh_ow {
    //size_t bia_off = bia_off_f(p, g, oc);
    // *******************       writing to dst[ p,mb,g,oc,oh,ow ]
    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
    float &d = ((float*)dst_m)[dst_off];
    //d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
    for (int kh = 0; kh < p->kh; ++kh) { //
      const int ih = oh * SH - PH + kh * (p->dh + 1); //
      if ( (ih >= 0 && ih < IH) ) { //2
        for (int ic = 0; ic < IC/G; ++ic) {
          for (int kw = 0; kw < KW; ++kw) {
            const int iw = ow * SW - PW + kw * (p->dw + 1);
            if ( (iw >= 0 && iw < IW))
            {
              size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
            }
          }
        }
      } //2
    } //
    //if (p->merge == RELU && d < 0) d = 0;
  }
  xdst_relu(p, dst_m);

#elif 0 // regr 1.31x; 1.21x; regr.sh-FWD 1.22x
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
#if 1
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh); // move d init up
#else
          for (int ow = 0; ow < OW; ++ow) {
            size_t bia_off = bia_off_f(p, g, oc);
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
          }
#endif
          //for (int kh = 0; kh < p->kh; ++kh)
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            //d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
            for (int kh = 0; kh < p->kh; ++kh) { //
              const int ih = oh * SH - PH + kh * (p->dh + 1); //
              if ( (ih >= 0 && ih < IH) ) { //2
                for (int ic = 0; ic < IC/G; ++ic) {
                  for (int kw = 0; kw < KW; ++kw) {
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    if ( (iw >= 0 && iw < IW))
                    {

                      size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                      size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
              } //2
            } //
            //if (p->merge == RELU && d < 0)
            //  d = 0;
          }
#if 1 //OK?
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            if (p->merge == RELU && d < 0)
              d = 0;
          }
#endif
        }
      }
    }
  }
#elif 0 // 1.64 x PT=1.47x; regr 1.23x ok; regr.sh-FWD 1.22x,1.22x
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          //for (int ic = 0; ic < IC/G; ++ic) 1.53 x
          for (int kh = 0; kh < p->kh; ++kh) { //
  // writing to dst[ p,mb,g,oc,oh,ow ] so above loop is DANGEROUS
            const int ih = oh * SH - PH + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < IH) ) { //2
              for (int ic = 0; ic < IC/G; ++ic) // 1.65 x
                for (int ow = 0; ow < OW; ++ow) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  //for (int ic = 0; ic < IC/G; ++ic) // 1.61 x
                  for (int kw = 0; kw < KW; ++kw) {
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    if ( (iw >= 0 && iw < IW))
                    {
                      size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                      size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
            }
          }
#if 1
          bias_relu(p, dst_m, mb, g, oc, oh);
#else
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            float &d = ((float*)dst_m)[dst_off];
            if (p->merge == RELU && d < 0)
              d = 0;
          }
#endif
        }
      }
    }
  }
#elif 0 // 3.20 x PT=2.0x   (always do offset calcs... maybe allows constant propagation?)
  // regr 1.22x 1.84x; regr.sh-FWD 1.79x *************************************************
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { //
            const int ih = oh * SH - PH + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < IH) ) { //2
              for (int ic = 0; ic < IC/G; ++ic) // 1.65 x
                for (int ow = 0; ow < OW; ++ow) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  for (int kw = 0; kw < KW; ++kw) {
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    if ( (iw >= 0 && iw < IW))
                    {
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
            }
          }
          bias_relu(p, dst_m, mb, g, oc, oh);
        }
      }
    }
  }
#elif 0 // same? regr 1.84x; regr.sh-FWD 1.79x
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) { // safe: oh,ow
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { // <--- unsafe, collapse <= 4
            const int ih = oh * SH - PH + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < IH) ) { //2
              for (int ic = 0; ic < IC/G; ++ic) // 1.65 x PT:
                for (int ow = 0; ow < OW; ++ow) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); //DST
                  float &d = ((float*)dst_m)[dst_off];
                  for (int kw = 0; kw < KW; ++kw) {
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    if ( (iw >= 0 && iw < IW))
                    {
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
            }
          }
          bias_relu(p, dst_m, mb, g, oc, oh);
        }
      }
    }
  }
#elif 0 // UNSAFE 6.09 x g,mb,oc,oh,ic,kw,ow. regr 1.84x
  // loop order change regr.sh-FWD  2.11x **********************************
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { // <-- write aliasing!
            const int ih = oh * SH - PH + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < IH) ) { //2
              for (int ic = 0; ic < IC/G; ++ic) {
                for (int kw = 0; kw < KW; ++kw) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  for (int ow = 0; ow < OW; ++ow) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    if ( (iw >= 0 && iw < IW)) {
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
              }
            }
          }
          bias_relu(p, dst_m, mb, g, oc, oh);
        }
      }
    }
  }
#elif 0 // UNSAFE 2.97 x (replace loop over ow with loop over iw: not so good, strided index)
  // regr 1.87x; iw calc-->loop regr.sh-FWD 1.70x
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          for (int kh = 0; kh < p->kh; ++kh) { // <--- write-aliasing
            const int ih = oh * SH - PH + kh * (p->dh + 1); //
            if ( (ih >= 0 && ih < IH) ) { //2
              for (int ic = 0; ic < IC/G; ++ic) {
                for (int kw = 0; kw < KW; ++kw) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  const int iw0 = rem_floor( - PW + kw * (p->dw + 1), SW);  ///<--
                  for (int iw = iw0; iw < IW; iw += SW) {                   ///<--
                    const int ow = (iw + PW - kw * (p->dw + 1)) / SW;       ///<--
                    //if (ow < 0 || ow >= OW) continue;                          ///<--
                    ///for (int ow = 0; ow < OW; ++ow) { //}
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    float &d = ((float*)dst_m)[dst_off];
                    ///const int iw = ow * SW - PW + kw * (p->dw + 1);
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    ///if ( (iw >= 0 && iw < IW)) { //}
                    if (ow >= 0 && ow < OW) {                                  ///<--
                      d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                    }
                  }
                }
              }
            }
          }
          bias_relu(p, dst_m, mb, g, oc, oh);
        }
      }
    }
  }
#elif 0 // hoist kh ? regr.sh-FWD 2.26x 2.25x *****************************************
  // safe:collapse(3): regr 2.36x
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        size_t bia_off = bia_off_f(p, g, oc);
        for (int oh = 0; oh < OH; ++oh) {
          dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
          int kh_beg, kh_end;
          hoist_ApiB_in( kh_beg, kh_end,
                         /*kh  in   */ 0, p->kh,
                         /*ih=A+khB */ oh * SH - PH, p->dh+1,
                         /*ih in    */ 0, IH);
          //for (int kh = 0; kh < p->kh; ++kh) { //}
          for (int kh = kh_beg; kh < kh_end; ++kh) { // <--- write-aliasing
            const int ih = oh * SH - PH + kh * (p->dh + 1); //
            //if ( (ih >= 0 && ih < IH) ) { //}
            for (int kw = 0; kw < KW; ++kw) {
              for (int ic = 0; ic < IC/G; ++ic) { // <--- !!!
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                int ow_beg, ow_end;
                hoist_ApiB_in( ow_beg, ow_end,
                               /*ow  in   */ 0, OW,
                               /*iw=A+owB */ - PW + kw * (p->dw + 1), SW,
                               /*iw in    */ 0, IW);
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                }
              }
            }
          }
          bias_relu(p, dst_m, mb, g, oc, oh);
        }
      }
    }
  }
#elif 0 // w/ atomic update, and difft hoist order regr 1.35x; 1.17
  // UNSAFE: 14.5 x hoist kh,ih, change loop order, add back early test for oh_beg/end
  // FAILS for mb1ic16ih8iw7oc16oh1ow1kh5kw5sh4sw3ph5pw7dh3dw4n
  // FAILS for g2ic16ih8iw7oc16oh1ow1kh5kw5sh4sw3ph5pw7dh3dw4n
  // found a typo, remove atomic
  // regr.sh-FWD 2.43x 2.43x ********************************************************
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
#if 0 // no real effect on speed ?
          hoist_ApiB_in( oh_beg, oh_end,
                         /*oh  in   */ 0, OH,
                         /*ih=A+ohB */ - PH + kh * (p->dh + 1), SH,
                         /*ih in    */ 0, IH);       // TYPE (was IW)
#else
    oh_beg = div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
    oh_end = div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
    if (oh_beg < 0    ) oh_beg = 0;
    if (oh_end > OH) oh_end = OH;
#endif
          if( oh_beg >= oh_end ) continue;
          for (int kw = 0; kw < KW; ++kw) {
            for (int ic = 0; ic < IC/G; ++ic) { // <--- !!!
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              int ow_beg, ow_end;
#if 0
              hoist_ApiB_in( ow_beg, ow_end,
                             /*ow  in   */ 0, OW,
                             /*iw=A+owB */ - PW + kw * (p->dw + 1), SW,
                             /*iw in    */ 0, IW);
#else
      ow_beg = div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
      ow_end = div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
      if (ow_beg < 0    ) ow_beg = 0;
      if (ow_end > OW) ow_end = OW;
#endif
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                const int iw = ow * SW - PW + kw * (p->dw + 1);
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1); //
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  float &d = ((float*)dst_m)[dst_off];
                  size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  const float dd = ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
//#pragma omp atomic update
                  d += dd;
                  //d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
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
#elif 0 // regr 2.22x, 4.72x, 4.14x, 4.7x  (demo code)
  // kh,kw loops outside omp
  // PTf=2.147 safe.... and ugly... determining bounds for kh, kw looks better
  xdst_init(p, bia_m, dst_m);
  // 15 x hoist kh,ih, change loop order, add back early test for oh_beg/end
  // writing to dst[ p,mb,g,oc,oh,ow ]
  // regr.sh-FWD 2.18x 2.08x [mod] 2.11x [collapse5] 2.09 [mod] ...
  // regr.sh-FWD 2.09x
  for (int kh = 0; kh < p->kh; ++kh) { // <-- move write-aliasing step OUTSIDE omp
    int oh_beg, oh_end;
#if 0
    hoist_ApiB_in( oh_beg, oh_end,
                   /*oh  in   */ 0, OH,
                   /*ih=A+ohB */ - PH + kh * (p->dh + 1), SH,
                   /*ih in    */ 0, IW);
#else
    oh_beg = div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
    oh_end = div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
    if (oh_beg < 0    ) oh_beg = 0;
    if (oh_end > OH) oh_end = OH;
#endif
    if( oh_beg >= oh_end ) continue;
    for (int kw = 0; kw < KW; ++kw) {
      int ow_beg, ow_end;
#if 0
      hoist_ApiB_in( ow_beg, ow_end,
                     /*ow  in   */ 0, OW,
                     /*iw=A+owB */ - PW + kw * (p->dw + 1), SW,
                     /*iw in    */ 0, IW);
#else
      ow_beg = div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
      ow_end = div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
      if (ow_beg < 0    ) ow_beg = 0;
      if (ow_end > OW) ow_end = OW;
#endif
      if( ow_beg >= ow_end ) continue;
# pragma omp parallel for collapse(3)
      for (int mb = 0; mb < MB; ++mb) {
        for (int g = 0; g < G; ++g) {
          for (int oc = 0; oc < OC/G; ++oc) {

            for (int oh = oh_beg; oh < oh_end; ++oh) {
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                for (int ic = 0; ic < IC/G; ++ic) { // 13.0x
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  const int ih = oh * SH - PH + kh * (p->dh + 1); //
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // written (OHOH)
                  float &d = ((float*)dst_m)[dst_off];
                  d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                }
              }
            }
            // Cannot do relu calc here.
            // Why? Because kh,kw loops are OUTSIDE !!!
          }
        }
      }
    }
  }
#if 0
#pragma omp parallel for collapse(4)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int oh = 0; oh < OH; ++oh) {
          bias_relu(p,  dst_m, mb, g, oc, oh);
        }
      }
    }
  }
#else
  xdst_relu(p, dst_m);
#endif
#elif 0 // regr 2.22x, 4.72x, 4.14x, 4.55; regr.sh-FWD 2.21x,2.12x,1.72x
  // musek (avx) regr FWD 7.08x
  // PTf=2.147 safe.... and ugly... determining bounds for kh, kw looks better
  xdst_init(p, bia_m, dst_m);
  // 15 x hoist kh,ih, change loop order, add back early test for oh_beg/end
  // writing to dst[ p,mb,g,oc,oh,ow ]
  for (int kh = 0; kh < p->kh; ++kh) { //
    int oh_beg, oh_end;
    oh_beg = div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
    oh_end = div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
    if (oh_beg < 0    ) oh_beg = 0;
    if (oh_end > OH) oh_end = OH;
    if( oh_beg >= oh_end ) continue;

    for (int kw = 0; kw < KW; ++kw) {
      int ow_beg, ow_end;
      ow_beg = div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
      ow_end = div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
      if (ow_beg < 0    ) ow_beg = 0;
      if (ow_end > OW) ow_end = OW;

      if( ow_beg >= ow_end ) continue;
# pragma omp parallel for collapse(5) // 3: regr 4.80x
      FWD_g_mb_oc_oh_ow {
        // d = HERE --> perhaps slower
        for (int ic = 0; ic < IC/G; ++ic) { // 13.0x
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          const int ih = oh * SH - PH + kh * (p->dh + 1); //
          const int iw = ow * SW - PW + kw * (p->dw + 1);
          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // written
          float &d = ((float*)dst_m)[dst_off];
          d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
        }
      }
    }
  }
  xdst_relu(p, dst_m);
#elif 0 // join omp-||, musek 7.8x; regr.sh-FWD 2.16x,1.68x
#pragma omp parallel
  {
    //xdst_init(p, bia_m, dst_m);
    if (p->dir & FLAG_BIA){
#pragma omp for collapse(5) schedule(static)
      FWD_g_mb_oc_oh_ow {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        size_t bia_off = bia_off_f(p, g, oc);
        float &d = ((float*)dst_m)[dst_off];
        d = ((float*)bia_m)[bia_off]; // copy the bias vector
      }
    }else{
#pragma omp for collapse(5) schedule(static)
      FWD_g_mb_oc_oh_ow {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        d = 0;
      }
    }
    for (int kh = 0; kh < p->kh; ++kh) {
      int oh_beg, oh_end;
      oh_beg = div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
      oh_end = div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
      if (oh_beg < 0    ) oh_beg = 0;
      if (oh_end > OH) oh_end = OH;
      if( oh_beg >= oh_end ) continue;

      for (int kw = 0; kw < KW; ++kw) {
        int ow_beg, ow_end;
        ow_beg = div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
        ow_end = div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
        if (ow_beg < 0    ) ow_beg = 0;
        if (ow_end > OW) ow_end = OW;

        if( ow_beg >= ow_end ) continue;
# pragma omp for collapse(5) schedule(static) // 3: regr 4.80x
        FWD_g_mb_oc_oh_ow {
          for (int ic = 0; ic < IC/G; ++ic) { // 13.0x
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            const int ih = oh * SH - PH + kh * (p->dh + 1); //
            const int iw = ow * SW - PW + kw * (p->dw + 1);
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // written (OHOH)
            float &d = ((float*)dst_m)[dst_off];
            d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
          }
        }
      }
    }
    //xdst_relu(p, dst_m);
    if (p->merge == RELU ){
#pragma omp for collapse(5) schedule(static)
      FWD_g_mb_oc_oh_ow {
        size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
        float &d = ((float*)dst_m)[dst_off];
        d = (d < 0? 0: d);
      }
    }
  }
#elif 1 // revert back to old speed champ for short regr tests, and clean up
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
#if 0 // copied from ref_conv2.cpp
  auto ker = [](
                const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &wei_m,
                float &ds, int g, int mb, int ic, int ih, int iw) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int kh = 0; kh < p->kh; ++kh) {
        int oh = ih - kh * (p->dh + 1) + PH;
        if (oh < 0 || oh % SH) continue;
        oh /= SH;
        if (oh >= OH) continue;

        for (int kw = 0; kw < KW; ++kw) {
          int ow = iw - kw * (p->dw + 1) + PW;
          if (ow < 0 || ow % SW) continue;
          ow /= SW;
          if (ow >= OW) continue;

          size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          ds += ((float*)diff_dst_m)[dst_off]
            * ((float*)wei_m)[wei_off];
        }
      }
    }
  };

#   pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            ker( p, diff_dst_m, wei_m,
                 ds, g, mb, ic, ih, iw);
          }
        }
      }
    }
  }
#elif 0 // dilate-regr 0.95x
#define KERN 0
#if KERN
  auto ker = [](
                const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &wei_m,
                float &ds, int g, int mb, int ic, int ih, int iw) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int kh = 0; kh < p->kh; ++kh) {
        int oh = ih - kh * (p->dh + 1) + PH;
        if (oh < 0 || oh % SH) continue;
        oh /= SH;
        if (oh >= OH) continue;

        for (int kw = 0; kw < KW; ++kw) {
          int ow = iw - kw * (p->dw + 1) + PW;
          if (ow < 0 || ow % SW) continue;
          ow /= SW;
          if (ow >= OW) continue;

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
    for (int g = 0; g < G; ++g) {
  for (int mb = 0; mb < MB; ++mb) {
    // mb-loop here?
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw); // <-- WRITTEN
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
#if KERN
            ker( p, diff_dst_m, wei_m,
                 ds, g, mb, ic, ih, iw);
#else
            for (int oc = 0; oc < OC/G; ++oc) {
              for (int kh = 0; kh < p->kh; ++kh) {
                int oh = ih - kh * (p->dh + 1) + PH;
                if (oh < 0 || oh % SH) continue;
                oh /= SH;
                if (oh >= OH) continue;

                for (int kw = 0; kw < KW; ++kw) {
                  int ow = iw - kw * (p->dw + 1) + PW;
                  if (ow < 0 || ow % SW) continue;
                  ow /= SW;
                  if (ow >= OW) continue;

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
#elif 0 // 2.5x loop order regr 2.3 x       <-- safe and somewhat faster
  // + dilates:  1.77x
  //RT_ASSERT( p->dh == 0 && p->dw == 0 );
# pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            for (int kh = 0; kh < p->kh; ++kh) {
              int oh = ih - kh * (p->dh + 1) + PH;
              if (oh < 0 || oh % SH) continue;
              oh /= SH;
              if (oh >= OH) continue;

              for (int kw = 0; kw < KW; ++kw) {
                int ow = iw - kw * (p->dw + 1) + PW;
                if (ow < 0 || ow % SW) continue;
                ow /= SW;
                if (ow >= OW) continue;

                for (int oc = 0; oc < OC/G; ++oc) { // <---- moved
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
#elif 0 // 2.1x
  // + dilates:  1.87x
  //RT_ASSERT( p->dh == 0 && p->dw == 0 );
# pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            for (int kh = 0; kh < p->kh; ++kh) {
              int oh = ih - kh * (p->dh + 1) + PH;
              bool const ohok = oh >= 0 && oh % SH == 0;
              oh = oh / SH;

              for (int kw = 0; kw < KW; ++kw) {
                int ow = iw - kw * (p->dw + 1) + PW;
                bool const owok = ow >= 0 && ow % SW == 0;
                ow = ow / SW;
                if (!(ohok && owok && oh < OH && ow < OW)) continue;
                // test fail 40 ??? why ...
                //if (!(ohok && owok && (oh=oh/SH)<OH && (ow=ow/SW)<OW)) continue;

                for (int oc = 0; oc < OC/G; ++oc) { // <---- moved
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
#pragma omp atomic
                  ds += ((float*)diff_dst_m)[dst_off] // <---- should be ATOMIC !!!
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
  // + dilates: 0.58x 
# pragma omp parallel for collapse(2)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        // bounds, then branch (easy case: p-dh == 0)
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
            // for oh ...
            //   ih = ...; 
            //   kh_beg/end mod for SH edge cases
            for (int kh = 0; kh < p->kh; ++kh) {
              int oh0 = ih - kh * (p->dh + 1) + PH;
              //if (oh0 % SH) continue;
              int oh = oh0 / SH;
              if (oh < 0 || oh >= OH) continue;
              if (oh * SH != oh0) continue;
              RT_ASSERT( ih == oh*SH + kh * (p->dh + 1) - PH );
              //const int iih = oh + kh * (p->dh + 1) - PH;
              //RT_ASSERT( iih == ih );
              //if (oh < 0 ) continue;
              //RT_ASSERT( SH > 0 );
              ////if (oh % SH) continue;             ///<---
              //RT_ASSERT( oh/SH*SH == oh );
              //oh /= SH;
              //RT_ASSERT( oh*SH == oh*SH );
              ////if (oh * SH != oh) continue;
              //RT_ASSERT( ih == oh*SH + kh * (p->dh + 1) - PH );
              //if (oh >= OH) continue;

              for (int kw = 0; kw < KW; ++kw) {
                int ow = iw - kw * (p->dw + 1) + PW;
                if (ow < 0 || ow % SW) continue;
                ow /= SW;
                if (ow >= OW) continue;
                for (int oc = 0; oc < OC/G; ++oc) {
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
  // + dilates: 0.21x
# pragma omp parallel for collapse(2)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0; ///printf(" Z "); /// cannot move into kh-loop
          }
        }
        printf("\nk,i,oh= "); int ocount = 0; ///ooo
        for (int ih = 0; ih < IH; ++ih) {
          for (int kh = 0; kh < p->kh; ++kh) {
            int oh0 = ih - kh * (p->dh + 1) + PH;
            int oh = oh0 / SH;
            if (oh * SH != oh0) continue;
            if (oh < 0 || oh >= OH) continue;
            printf( "%d,%d,%d%s", kh,ih,oh, (++ocount%10==0?"\n        ":"  ")); ///ooo
            RT_ASSERT( ih == oh*SH + kh * (p->dh + 1) - PH );

            for (int iw = 0; iw < IW; ++iw) {
              for (int kw = 0; kw < KW; ++kw) {
                int ow = iw - kw * (p->dw + 1) + PW;
                if (ow < 0 || ow % SW) continue;
                ow /= SW;
                if (ow >= OW) continue;
                for (int oc = 0; oc < OC/G; ++oc) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  float &ds = ((float*)diff_src_m)[src_off];
#pragma omp atomic
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
#elif 0 // loop order change -- tricky : 0.5x (with debug), 0.60x (w/o debug)
  // + dilates:  0.66x
#if 1
  auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
    return oh * SH - PH + kh * (p->dh+1);
  };
  auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
    return ow * SW - PW + kw * (p->dw+1);
  };
  const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
  const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
  const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  print(0, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
#endif
# pragma omp parallel for collapse(2)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        printf("\nk,i,oh= "); int ocount = 0; ///ooo
        //        const int iw0 = rem_floor( - PW + kw * (p->dw + 1), SW);  ///<--
        //        for (int iw = iw0; iw < IW; iw += SW) {                   ///<--
        //          const int ow = (iw + PW - kw * (p->dw + 1)) / SW;       ///<--
        //          if (ow < 0 || ow >= OW) continue;                          ///<--
        //          }
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          ///int oh00 = ih + PH - kh * (p->dh + 1);
          ///int oh = oh00 / SH
          // lowest oh is for ih="near zero" kh=p->kh-1:
          //     oh = (ih + PH - (p->kh-1)*(p->dh+1)) / SH; // almost OK
          //     oh = (ih + PH - (p->kh-1)*(p->dh+1)) / SH; // almost OK
          //const int a = div_floor( PH - (p->kh-1)*(p->dh+1), SH );
          //const int b = a*SH - PH + (p->kh-1) * (p->dh+1);
          //const int oh0 = (b>0? b: 0); /// oh wow, oh0 is INDEPENDENT of all loop vars
          //const int oh0 = oh_lowest; // moved above!
          const int ih_lowest = ih_at(p, oh_lowest, kh);
          //print(10, "bwd_d ih_lowest = %d\n", ih_lowest);
          // NO RT_ASSERT( ih_lowest==0 );
          //printf(" kh=%d,oh_lowest=%d:   ",kh,oh_lowest);
          //RT_ASSERT( oh_lowest >= 0 );
          for (int oh = oh_lowest; oh < OH; ++oh) {
            //const int ih = oh*SH - PH + kh * (p->dh+1);
            const int ih = ih_at(p, oh, kh);
            // NO RT_ASSERT( ih >= 0 );
            // NO RT_ASSERT( ih < IH );
            //if (oh==oh_lowest) RT_ASSERT(ih == ih_lowest);
            if( ih < 0 || ih >= IH ) continue;
            //RT_ASSERT( ih >= 0 && ih < IH );
            //RT_ASSERT( oh >= 0 && oh < OH );
            //RT_ASSERT( kh >= 0 && kh < p->kh );
            //printf( "%d,%d,%d%s", kh,ih,oh, (++ocount%10==0?"\n        ":"  ")); ///ooo
            //RT_ASSERT( ih == oh*SH + kh * (p->dh + 1) - PH );

            for (int iw = 0; iw < IW; ++iw) {
              const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
              float &ds = ((float*)diff_src_m)[src_off];
              for (int kw = 0; kw < KW; ++kw) {
                int ow = iw - kw * (p->dw + 1) + PW;
                if (ow < 0 || ow % SW) continue;
                ow /= SW;
                if (ow >= OW) continue;
                for (int oc = 0; oc < OC/G; ++oc) {
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
#elif 0 // remove debug for kh,oh,ih loops
  // + dilates: 0.99x
#if 1
  auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
    return oh * SH - PH + kh * (p->dh+1);
  };
  auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
    return ow * SW - PW + kw * (p->dw+1);
  };
  const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
  const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
  const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
          // lowest oh is for ih="near zero" kh=p->kh-1:
          //     oh = (ih + PH - (p->kh-1)*(p->dh+1)) / SH; // almost OK
          //     oh = (ih + PH - (p->kh-1)*(p->dh+1)) / SH; // almost OK
          //const int a = div_floor( PH - (p->kh-1)*(p->dh+1), SH );
          //const int b = a*SH - PH + (p->kh-1) * (p->dh+1);
          //const int oh0 = (b>0? b: 0); /// oh wow, oh0 is INDEPENDENT of all loop vars
          //const int oh0 = oh_lowest; // moved above!
  const int lcm_w = lcm( SW, p->dw+1 );
  const int lcm_h = lcm( SH, p->dh+1 );
#endif
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          //const int ih_lowest = ih_at(p, oh_lowest, kh);
          for (int oh = oh_lowest; oh < OH; ++oh) {
            //const int ih = oh*SH - PH + kh * (p->dh+1);
            const int ih = ih_at(p, oh, kh);
            // no RT_ASSERT( ih >= 0 );
            // no RT_ASSERT( ih < IH );
            if( ih < 0 || ih >= IH ) continue;
#if 0         
            for (int iw = 0; iw < IW; ++iw) {
              const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
              float &ds = ((float*)diff_src_m)[src_off];
              for (int kw = 0; kw < KW; ++kw) {
                int ow = iw - kw * (p->dw + 1) + PW;
                if (ow < 0 || ow % SW) continue;
                ow /= SW;
                if (ow >= OW) continue;
                for (int oc = 0; oc < OC/G; ++oc) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  ds += ((float*)diff_dst_m)[dst_off]
                    * ((float*)wei_m)[wei_off];
                }
              }
            }

#else
            for (int kw = 0; kw < KW; ++kw) {
              for (int ow = ow_lowest; ow < OW; ++ow) {
                const int iw = iw_at(p, ow, kw);
                if ( iw < 0 || iw >= IW ) continue;

                //int ow = iw - kw * (p->dw + 1) + PW;
                //if (ow < 0 || ow % SW) continue;
                //ow /= SW;
                //if (ow >= OW) continue;
                //RT_ASSERT( ow * SW == iw - kw * (p->dw + 1) + PW );
                const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                float &ds = ((float*)diff_src_m)[src_off];
                for (int oc = 0; oc < OC/G; ++oc) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
#pragma omp atomic
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
#elif 0 // cleanup, do "same" for ih,iw,kw loops (no hoist yet)
  // + dilates: 1.01x
#if 1
  auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
    return oh * SH - PH + kh * (p->dh+1);
  };
  auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
    return ow * SW - PW + kw * (p->dw+1);
  };
  const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
  const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
  const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
          // lowest oh is for ih="near zero" kh=p->kh-1:
          //     oh = (ih + PH - (p->kh-1)*(p->dh+1)) / SH; // almost OK
          //     oh = (ih + PH - (p->kh-1)*(p->dh+1)) / SH; // almost OK
          //const int a = div_floor( PH - (p->kh-1)*(p->dh+1), SH );
          //const int b = a*SH - PH + (p->kh-1) * (p->dh+1);
          //const int oh0 = (b>0? b: 0); /// oh wow, oh0 is INDEPENDENT of all loop vars
          //const int oh0 = oh_lowest; // moved above!
  const int lcm_w = lcm( SW, p->dw+1 );
  const int lcm_h = lcm( SH, p->dh+1 );
#endif
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = ((float*)diff_src_m)[src_off];
            ds = 0;
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          //const int ih_lowest = ih_at(p, oh_lowest, kh);
          for (int oh = oh_lowest; oh < OH; ++oh) {
            //const int ih = oh*SH - PH + kh * (p->dh+1);
            const int ih = ih_at(p, oh, kh);
            // no RT_ASSERT( ih >= 0 );
            // no RT_ASSERT( ih < IH );
            if( ih < 0 || ih >= IH ) continue;

            for (int kw = 0; kw < KW; ++kw) {
              for (int ow = ow_lowest; ow < OW; ++ow) {
                const int iw = iw_at(p, ow, kw);
                if ( iw < 0 || iw >= IW ) continue;

                //int ow = iw - kw * (p->dw + 1) + PW;
                //if (ow < 0 || ow % SW) continue;
                //ow /= SW;
                //if (ow >= OW) continue;
                //RT_ASSERT( ow * SW == iw - kw * (p->dw + 1) + PW );
                const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                float &ds = ((float*)diff_src_m)[src_off];
                for (int oc = 0; oc < OC/G; ++oc) {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
#pragma omp atomic
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
#elif 0 // 2.3x : cleanup and hoist; regr(atomic!) 0.92x
  // + dilates: 1.76x
#if 1
  auto constexpr ih_at = []( const prb_t *p, const int oh, const int kh ){
    return oh * SH - PH + kh * (p->dh+1);
  };
  auto constexpr iw_at = []( const prb_t *p, const int ow, const int kw ){
    return ow * SW - PW + kw * (p->dw+1);
  };
  const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
  const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
  const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
#endif
# pragma omp parallel for collapse(3)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
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
                         /*oh  in   */ oh_lowest, OH,
                         /*ih=A+ohB */ -PH + kh*(p->dh+1), SH, // B>0, ApiB OK
                         /*ih in    */ 0, IH);
          for (int oh = oh_beg; oh < oh_end; ++oh) {
            const int ih  =  oh*SH - PH + kh * (p->dh+1);
            //const int ih = ih_at(p, oh, kh);
            //if( ih < 0 || ih >= IH ) continue;
            //RT_ASSERT( ih >= 0 && ih < IH );
            // ---- hoisting w for loop order change and test removal
            for (int kw = 0; kw < KW; ++kw) {
              const int iw_lowest = iw_at(p, ow_lowest, kw);
              hoist_ApiB_in( /* set     */ ow_beg, ow_end,
                             /*ow  in   */ ow_lowest, OW,
                             /*iw=A+owB */ -PW + kw*(p->dw+1), SW, // B>0, ApiB OK
                             /*iw in    */ 0, IW);
              for (int ow = ow_beg; ow < ow_end; ++ow) {
                const int iw  =  ow*SW - PW + kw * (p->dw+1);
                const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                float &ds = ((float*)diff_src_m)[src_off];
                float tmpds = 0.f;
                // ----
                for (int oc = 0; oc < OC/G; ++oc) {
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                  tmpds += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
                  //ds += ((float*)diff_dst_m)[dst_off]
                  //  * ((float*)wei_m)[wei_off];
                }
#pragma omp atomic
                ds += tmpds;
              }
            }
          }
        }
      }
    }
  }
#elif 0 // regr 6.36x but with atomic, only 1.46x,1.53x
  // + dilates: 1.42x
  const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
  const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
  const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
  const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
  const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
  const int ow_lowest = (bww>0? bww: 0);
  //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
# pragma omp parallel for collapse(3) // dst_off_f(p, mb, g, oc, oh, ow);
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int oc = 0; oc < OC/G; ++oc) {
          if(oc==0)
//#       pragma omp parallel for collapse(2)
            for (int ih = 0; ih < IH; ++ih) {
              for (int iw = 0; iw < IW; ++iw) {
                const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                float &ds = ((float*)diff_src_m)[src_off];
                ds = 0;
              }
            }
          for (int kh = 0; kh < p->kh; ++kh) {
            int oh_beg, oh_end;
            hoist_ApiB_in( /* set     */ oh_beg, oh_end,
                           /*oh  in   */ oh_lowest, OH,
                           /*ih=A+ohB */ -PH + kh*(p->dh+1), SH, // B>0, ApiB OK
                           /*ih in    */ 0, IH);
            for (int kw = 0; kw < KW; ++kw) {
              int ow_beg, ow_end;
              hoist_ApiB_in( /* set     */ ow_beg, ow_end,
                             /*ow  in   */ ow_lowest, OW,
                             /*iw=A+owB */ -PW + kw*(p->dw+1), SW, // B>0, ApiB OK
                             /*iw in    */ 0, IW);
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              for (int oh = oh_beg; oh < oh_end; ++oh) {
                const int ih  =  oh*SH - PH + kh * (p->dh+1);
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  const int iw  =  ow*SW - PW + kw * (p->dw+1);
                  const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                  float &ds = ((float*)diff_src_m)[src_off];
                  size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
#pragma omp atomic // CORRECT, but 1.46x speed (ouch)
                  ds += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
                }
              }
            }
          }
        }
      }
    }
  }
#elif 1 // regr 1.91
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
#define BW4 14 
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
#if BW4==0 // 1.15 x PT 1.10 x regr,BWD_W=1.11x
#   pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            float &dw = ((float*)diff_wei_m)[wei_off];
            dw = 0;
            for (int mb = 0; mb < MB; ++mb) {
              for (int oh = 0; oh < OH; ++oh) {
                for (int ow = 0; ow < OW; ++ow) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  if (ih < 0 || ih >= IH) continue;
                  if (iw < 0 || iw >= IW) continue;

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

#if 0 // GOOD
#   pragma omp parallel for collapse(2)
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
#elif 0 // GOOD
  if ((p->dir & FLAG_BIA)) {
      for (int g = 0; g < G; ++g) {
          for (int oc = 0; oc < OC/G; ++oc) {
              size_t bia_off = bia_off_f(p, g, oc);
              float &db = ((float*)diff_bia_m)[bia_off];
              db = 0;
          }
      }
      for (int g = 0; g < G; ++g) {
          for (int oc = 0; oc < OC/G; ++oc) {
              size_t bia_off = bia_off_f(p, g, oc);
              float &db = ((float*)diff_bia_m)[bia_off];
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
#elif 0 // GOOD
  if ((p->dir & FLAG_BIA)) {
      for (int oc = 0; oc < OC; ++oc) {
          size_t bia_off = bia_off_f_nog(p, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          db = 0;
      }
      for (int g = 0; g < G; ++g) {
          for (int oc = 0; oc < OC/G; ++oc) {
              size_t bia_off = bia_off_f(p, g, oc);
              float &db = ((float*)diff_bia_m)[bia_off];
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
#elif 0 // GOOD
  if ((p->dir & FLAG_BIA)) {
      zero_bia(p, diff_bia_m);
      for (int g = 0; g < G; ++g) {
          for (int oc = 0; oc < OC/G; ++oc) {
              size_t bia_off = bia_off_f(p, g, oc);
              float &db = ((float*)diff_bia_m)[bia_off];
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
#else // GOOD
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
#endif
#elif BW4==1 // memset PT 1.13x, 1.18x
#   pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            float &dw = ((float*)diff_wei_m)[wei_off];
            dw = 0;
            for (int mb = 0; mb < MB; ++mb) {
              for (int oh = 0; oh < OH; ++oh) {
                for (int ow = 0; ow < OW; ++ow) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  if (ih < 0 || ih >= IH) continue;
                  if (iw < 0 || iw >= IW) continue;

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
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==2 // PT 1.11x zero wei first, so mb loop can move upwards (omp-safe:1.08x)
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb) {
#   pragma omp parallel for collapse(5) // oh. mb aliases updated wei (atomicity of +=)
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int ic = 0; ic < IC/G; ++ic) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              //dw = 0;
              //for (int mb = 0; mb < MB; ++mb)
              for (int oh = 0; oh < OH; ++oh) {
                for (int ow = 0; ow < OW; ++ow) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  if (ih < 0 || ih >= IH) continue;
                  if (iw < 0 || iw >= IW) continue;

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
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==3 // PT 1.0x just cleaning up above mess. regr 1.07x
  // PT 0.9x this allow for-mb to move outside the 'dw=0' init, [not yet useful]
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb) {
#   pragma omp parallel for collapse(5)
    for (int g = 0; g < G; ++g) { // still with conditionals
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int ic = 0; ic < IC/G; ++ic) {
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              for (int oh = 0; oh < OH; ++oh) {
                for (int ow = 0; ow < OW; ++ow) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  if (ih < 0 || ih >= IH) continue;
                  if (iw < 0 || iw >= IW) continue;

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
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==4 // PT 3.60x 3.74x HOIST the conditionals! (safe:4.2x) regr 2.56x
  // 4.5x(6t), 6.4x(1t) chg loop order, collapse. Hoist as in ref_conv3, move code 'up', early-continue
  // zero the entire wei_off memory as a first step (NO minibatch loop)
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb) { // hoisted conditionals + loop reorder
#   pragma omp parallel for collapse(3)
    for (int g = 0; g < G; ++g) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < KW; ++kw) {
          int oh_beg, oh_end;
          hoist_ApiB_in( oh_beg, oh_end,
                         /*i  in   */ 0, OH,
                         /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                         /*ih in   */ 0, IH);
          int ow_beg, ow_end;
          hoist_ApiB_in( ow_beg, ow_end,
                         /*i  in   */ 0, OW,
                         /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                         /*iw in   */ 0, IW);
          if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
          for (int ic = 0; ic < IC/G; ++ic) {
            for (int oc = 0; oc < OC/G; ++oc) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              for (int oh = oh_beg; oh < oh_end; ++oh) {
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
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
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==5 // PT 4.4x regr 3.40x
  zero_wei(p, diff_wei_m);
#define Y /* mb: X,Y,Z */
#define B /* ic: A,B */
#define G /* oc: F,G */
#ifdef X
  for (int mb = 0; mb < MB; ++mb) {           // X
#endif
#if defined(B) && defined(G)
# pragma omp parallel for collapse(3) // <-- BG
#else
# pragma omp parallel for collapse(4)
#endif
    for (int g = 0; g < G; ++g) {
#ifdef A
      for (int ic = 0; ic < IC/G; ++ic) {       // A
#endif
#ifdef F
        for (int oc = 0; oc < OC/G; ++oc) {          // F
#endif
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
//#ifdef Y
//       for (int mb = 0; mb < MB; ++mb) {      // Y
//#endif
              int oh_beg, oh_end;
              hoist_ApiB_in( oh_beg, oh_end,
                             /*i  in   */ 0, OH,
                             /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                             /*ih in   */ 0, IH);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                             /*i  in   */ 0, OW,
                             /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                             /*iw in   */ 0, IW);
              if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
#ifdef Y
       for (int mb = 0; mb < MB; ++mb) {      // Y
#endif
#ifdef B
       for (int ic = 0; ic < IC/G; ++ic) {       // B
#endif
#ifdef G
       for (int oc = 0; oc < OC/G; ++oc) {            // G
#endif
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
              float &dw = ((float*)diff_wei_m)[wei_off];
//#ifdef Z
//       for (int mb = 0; mb < MB; ++mb) {      // Z
//#endif
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
          }
        }
      }
    }
  }
#undef A
#undef B
#undef F
#undef G
#undef X
#undef Y
#undef Z
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==50 // tidy, use ZAG
  zero_wei(p, diff_wei_m);
# pragma omp parallel for collapse(3) // <-- BG
  for (int g = 0; g < G; ++g) {
    for (int ic = 0; ic < IC/G; ++ic) {       // A
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < KW; ++kw) {
          int oh_beg, oh_end;
          hoist_ApiB_in( oh_beg, oh_end,
                         /*i  in   */ 0, OH,
                         /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                         /*ih in   */ 0, IH);
          int ow_beg, ow_end;
          hoist_ApiB_in( ow_beg, ow_end,
                         /*i  in   */ 0, OW,
                         /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                         /*iw in   */ 0, IW);
          if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
          for (int oc = 0; oc < OC/G; ++oc) {            // G
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
            float &dw = ((float*)diff_wei_m)[wei_off];
            for (int mb = 0; mb < MB; ++mb) {      // Z
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
          }
        }
      }
    }
  }
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==6 // 4.8x work regr 3.43x
  zero_wei(p, diff_wei_m);
  //for (int mb = 0; mb < MB; ++mb) // X
# pragma omp parallel for collapse(4)
  for (int g = 0; g < G; ++g) {
    //for (int ic = 0; ic < IC/G; ++ic) { // A
      for (int oc = 0; oc < OC/G; ++oc) { // F
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < KW; ++kw) {
          {
            int oh_beg, oh_end;
            hoist_ApiB_in( oh_beg, oh_end,
                           /*i  in   */ 0, OH,
                           /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                           /*ih in   */ 0, IH);
            int ow_beg, ow_end;
            hoist_ApiB_in( ow_beg, ow_end,
                           /*i  in   */ 0, OW,
                           /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                           /*iw in   */ 0, IW);
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue;
              //for (int mb = 0; mb < MB; ++mb) //
      for (int ic = 0; ic < IC/G; ++ic) { // B
      //for (int oc = 0; oc < OC/G; ++oc) { // G
              for (int mb = 0; mb < MB; ++mb) // new: 2.09 ic,oc:1.83
              {
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                float &dw = ((float*)diff_wei_m)[wei_off];
              //for (int mb = 0; mb < MB; ++mb) // ZBF: 2.14,  ic,oc:2.02
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
            }
          }
        }
      }
    }
  }
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==7 // 6.3x tidy, correct an omp ERROR safe:5.2-5.6x
    // moving zeroing back into loop does no good
    //for (int mb = 0; mb < MB; ++mb) {// **FAIL** with zeroing inside loop
#pragma omp parallel for collapse(5)
      for (int g = 0; g < G; ++g) {
        for (int ic = 0; ic < IC/G; ++ic) { // A 1.57
        for (int oc = 0; oc < OC/G; ++oc) { // F
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
              //for (int ic = 0; ic < IC/G; ++ic) { // new posn: 1.54
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                float &dw = ((float*)diff_wei_m)[wei_off];
                dw = 0.f;
                {
                  int oh_beg, oh_end;
                  hoist_ApiB_in( oh_beg, oh_end,
                                 /*i  in   */ 0, OH,
                                 /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                                 /*ih in   */ 0, IH);
                  int ow_beg, ow_end;
                  hoist_ApiB_in( ow_beg, ow_end,
                                 /*i  in   */ 0, OW,
                                 /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                                 /*iw in   */ 0, IW);
                  if( oh_beg >= oh_end || ow_beg >= ow_end ) continue;
                  for (int mb = 0; mb < MB; ++mb) {// ~ Z
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
              }
            }
          }
        }
      }
    }
    bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==8 // 5.0-5.3x   JUST merging loops... (limited ||ism) safe:4.8x 4.90x
  // PASSES regr.sh-BWD_W 2.0x
  zero_bia(p, diff_bia_m);
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb) {
# pragma omp parallel for collapse(2)
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        if ((p->dir & FLAG_BIA)) {
          size_t bia_off = bia_off_f(p, g, oc);
          float &db = ((float*)diff_bia_m)[bia_off];
          for (int oh = 0; oh < OH; ++oh) {
            for (int ow = 0; ow < OW; ++ow) {
              size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
              db += ((float*)diff_dst_m)[dst_off];
            }
          }
        }
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            int oh_beg, oh_end;
            hoist_ApiB_in( oh_beg, oh_end,
                           /*i  in   */ 0, OH,
                           /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                           /*ih in   */ 0, IH);
            int ow_beg, ow_end;
            hoist_ApiB_in( ow_beg, ow_end,
                           /*i  in   */ 0, OW,
                           /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                           /*iw in   */ 0, IW);
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue;
            for (int ic = 0; ic < IC/G; ++ic) {
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              for (int oh = oh_beg; oh < oh_end; ++oh) {
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  const int ih = oh * SH - PH + kh * (p->dh + 1);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
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
#elif BW4==9 // PT 2.5x all attempts to move omp loops "inward" slowed things down
  // bias loop merge ?? not a winner
  zero_wei(p, diff_wei_m);
  //zero_bia(p, diff_bia_m);
//#pragma omp parallel for collapse(4) // 0.76
    //for (int mb = 0; mb < MB; ++mb)
  for (int g = 0; g < G; ++g) {
    for (int oc = 0; oc < OC/G; ++oc) {
#if 1 // 1.83x,1.79x
      if ((p->dir & FLAG_BIA)) {
        size_t bia_off = bia_off_f(p, g, oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        db = 0.f; // no big diff
//#pragma omp parallel for collapse(3) reduction(+:db) // 1.77-->1.76
        for (int mb = 0; mb < MB; ++mb) {
          for (int oh = 0; oh < OH; ++oh) {
            for (int ow = 0; ow < OW; ++ow) {
              size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
              db += ((float*)diff_dst_m)[dst_off];
            }
          }
        }
      }
#endif
      for (int mb = 0; mb < MB; ++mb) { // writing wei_off_f(p, g, oc, ic, kh, kw)
#pragma omp parallel for collapse(3)
        for (int ic = 0; ic < IC/G; ++ic) { // PT 1.76x
          for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < KW; ++kw) {
              //#pragma omp parallel // PT 3.5x
              {
                int oh_beg, oh_end;
                hoist_ApiB_in( oh_beg, oh_end,
                               /*i  in   */ 0, OH,
                               /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                               /*ih in   */ 0, IH);
                int ow_beg, ow_end;
                hoist_ApiB_in( ow_beg, ow_end,
                               /*i  in   */ 0, OW,
                               /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                               /*iw in   */ 0, IW);
                if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0

                //#pragma omp for collapse(2)
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                float &dw = ((float*)diff_wei_m)[wei_off];
                //#pragma omp parallel for collapse(2) // 0.75x
                for (int oh = oh_beg; oh < oh_end; ++oh) {
                  for (int ow = ow_beg; ow < ow_end; ++ow) {
                    const int ih = oh * SH - PH + kh * (p->dh + 1);
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    const int iw = ow * SW - PW + kw * (p->dw + 1);
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
  //bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
#elif BW4==100 // FAILING new g,mb tests
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb) {// 2.5x
# pragma omp parallel for collapse(4)
    for (int ic = 0; ic < IC; ++ic)         //---
      for (int oc = 0; oc < OC; ++oc) {     //---
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            {
              int oh_beg, oh_end;
              hoist_ApiB_in( oh_beg, oh_end,
                             /*i  in   */ 0, OH,
                             /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                             /*ih in   */ 0, IH);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                             /*i  in   */ 0, OW,
                             /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                             /*iw in   */ 0, IW);
              if( oh_beg >= oh_end || ow_beg >= ow_end ) continue;
              size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
              float &dw = ((float*)diff_wei_m)[wei_off];
              for (int oh = oh_beg; oh < oh_end; ++oh) {
                const int ih = oh * SH - PH + kh * (p->dh + 1);
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  size_t dst_off = dst_off_f_nog(p, mb, /*g,*/ oc, oh, ow);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  size_t src_off = src_off_f_nog(p, mb, /*g,*/ ic, ih, iw);
                  dw += ((float*)diff_dst_m)[dst_off]
                    * ((float*)src_m)[src_off];
                }
              }
            }
          }
        }
      }
  }
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==101 // A:2.09 B:1.98 C:  devel version
  zero_wei(p, diff_wei_m);
# pragma omp parallel for collapse(3)
  //AB: for (int g = 0; g < G; ++g) {
    //AB: for (int ic = 0; ic < IC/G; ++ic) {
    for (int ic_nog = 0; ic_nog < IC; ++ic_nog) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < KW; ++kw) {
          int oh_beg, oh_end;
          hoist_ApiB_in( oh_beg, oh_end,
                         /*i  in   */ 0, OH,
                         /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                         /*ih in   */ 0, IH);
          int ow_beg, ow_end;
          hoist_ApiB_in( ow_beg, ow_end,
                         /*i  in   */ 0, OW,
                         /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                         /*iw in   */ 0, IW);
          if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
          int const g = ic_nog / (IC/G);      // C
          for (int oc = 0; oc < OC/G; ++oc) {
            //A: size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
            int oc_nog = g * OC/G + oc;
            //AB: int ic_nog = g * IC/G + ic;
//#RT_ASSERT( wei_off_f_nog(p, oc_nog, ic_nog, kh, kw) == wei_off );
            size_t wei_off = wei_off_f_nog(p, /*g,*/ oc_nog, ic_nog, kh, kw);
            //size_t wei_off = wei_off_f_nog(p, oc, ic, kh, kw);
            float &dw = ((float*)diff_wei_m)[wei_off];
            for (int mb = 0; mb < MB; ++mb) {      // Z
              for (int oh = oh_beg; oh < oh_end; ++oh) {
                const int ih = oh * SH - PH + kh * (p->dh + 1);
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  //A: size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
//#RT_ASSERT( dst_off_f_nog(p, mb, g*OC/G+oc, oh, ow) == dst_off );
                  //B: size_t dst_off = dst_off_f_nog(p, mb, /*g,*/ oc_nog oh, ow);
                  size_t dst_off = dst_off_f_nog(p, mb, oc_nog, oh, ow);
                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  //A: size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
//#RT_ASSERT( src_off_f_nog(p, mb, /*g,*/ g*IC/G+ic, ih, iw) == src_off );
                  //B:size_t src_off = src_off_f_nog(p, mb, /*g,*/ ic_nog, ih, iw);
                  size_t src_off = src_off_f_nog(p, mb, ic_nog, ih, iw);
                  dw += ((float*)diff_dst_m)[dst_off]
                    * ((float*)src_m)[src_off];
                }
              }
            }
          }
        }
      }
    }
  //AB:}
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==10 // A:2.09 B:1.98 C:
  // RESULT: _nog offsets are a NON-OPTIMIZATION because wei_off_f_nog is too klunky
  zero_wei(p, diff_wei_m);
# pragma omp parallel for collapse(3)
    for (int ic_nog = 0; ic_nog < IC; ++ic_nog) {
      for (int kh = 0; kh < p->kh; ++kh) {
        for (int kw = 0; kw < KW; ++kw) {
          int oh_beg, oh_end;
          hoist_ApiB_in( oh_beg, oh_end,
                         /*i  in   */ 0, OH,
                         /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                         /*ih in   */ 0, IH);
          int ow_beg, ow_end;
          hoist_ApiB_in( ow_beg, ow_end,
                         /*i  in   */ 0, OW,
                         /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                         /*iw in   */ 0, IW);
          if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
          //int const g = ic_nog / (IC/G);      // C
          int const oc_nog0 = ic_nog / (IC/G) * (OC/G);
          for (int oc = 0; oc < OC/G; ++oc) {
            //int oc_nog = g * OC/G + oc;
            int oc_nog = oc_nog0 + oc;
            size_t wei_off = wei_off_f_nog(p, /*g,*/ oc_nog, ic_nog, kh, kw);

            float &dw = ((float*)diff_wei_m)[wei_off];
            for (int mb = 0; mb < MB; ++mb) {      // Z
              for (int oh = oh_beg; oh < oh_end; ++oh) {
                const int ih = oh * SH - PH + kh * (p->dh + 1);
                for (int ow = ow_beg; ow < ow_end; ++ow) {
                  size_t dst_off = dst_off_f_nog(p, mb, oc_nog, oh, ow);

                  const int iw = ow * SW - PW + kw * (p->dw + 1);
                  size_t src_off = src_off_f_nog(p, mb, ic_nog, ih, iw);

                  dw += ((float*)diff_dst_m)[dst_off]
                    * ((float*)src_m)[src_off];
                }
              }
            }
          }
        }
      }
    }
  //AB:}
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);

#elif BW4==110 // _nog --> FAILS reverted to case 6 with mb loop up front
  // then expand bias loop (oc,mb,ohw) and merge w/ mb loop
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb)
  {
    if ((p->dir & FLAG_BIA)) {
      for (int oc = 0; oc < OC     ; ++oc) {
        size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        db = 0.f;
# pragma omp parallel for
        for (int ohw = 0; ohw < OH*OW; ++ohw) {
          size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
          db += ((float*)diff_dst_m)[dst_off];
        }
      }
    }
  //}
  //for (int mb = 0; mb < MB; ++mb)
#pragma omp parallel
  //{
# pragma omp for collapse(4)
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) { // F
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            {
              int oh_beg, oh_end;
              hoist_ApiB_in( oh_beg, oh_end,
                             /*i  in   */ 0, OH,
                             /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                             /*ih in   */ 0, IH);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                             /*i  in   */ 0, OW,
                             /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                             /*iw in   */ 0, IW);
              if( oh_beg >= oh_end || ow_beg >= ow_end ) continue;
              for (int ic = 0; ic < IC/G; ++ic) { // B
                {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                  float &dw = ((float*)diff_wei_m)[wei_off];
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
              }
            }
          }
        }
      }
    }
  }
  bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
#elif BW4==11 // _nog --> FAILS reverted to case 6 with mb loop up front
  // then expand bias loop (oc,mb,ohw) and merge w/ mb loop
  // fancier omp mostly made thing worse.
  zero_wei(p, diff_wei_m);
  for (int mb = 0; mb < MB; ++mb)
  {
    if ((p->dir & FLAG_BIA)) {
#pragma omp parallel for schedule(static) if(OC > OH*OW)
      for (int oc = 0; oc < OC     ; ++oc) {
        size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
        float &db = ((float*)diff_bia_m)[bia_off];
        db = 0.f;
# pragma omp parallel for schedule(static,512) if(OC <= OH*OW && OH*OW > 1024)
        for (int ohw = 0; ohw < OH*OW; ++ohw) {
          size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
          db += ((float*)diff_dst_m)[dst_off];
        }
      }
    }
  }
    const bool bigoc = OC/G >= G*IC*p->kh*KW;
# pragma omp parallel for schedule(static,1) if( bigoc )
      for (int oc = 0; oc < OC/G; ++oc) { // F
# pragma omp parallel for collapse(4) if( !bigoc )
    for (int g = 0; g < G; ++g) {
              for (int ic = 0; ic < IC/G; ++ic) { // B
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            {
              int oh_beg, oh_end;
              hoist_ApiB_in( oh_beg, oh_end,
                             /*i  in   */ 0, OH,
                             /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                             /*ih in   */ 0, IH);
              int ow_beg, ow_end;
              hoist_ApiB_in( ow_beg, ow_end,
                             /*i  in   */ 0, OW,
                             /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                             /*iw in   */ 0, IW);
              if( oh_beg >= oh_end || ow_beg >= ow_end ) continue;
              //for (int ic = 0; ic < IC/G; ++ic) { // B
                {
                  size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
                  float &dw = ((float*)diff_wei_m)[wei_off];
  for (int mb = 0; mb < MB; ++mb){
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
              }
            }
          }
        }
      }
    }
  }
  //bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
#elif BW4==12 // regr 3.94x; regr.sh-BWD_W 1.69x
  //  FAILS
  zero_wei(p, diff_wei_m);
    //# pragma omp parallel for
//#pragma omp parallel
  {
    if ((p->dir & FLAG_BIA)) {
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
    }
  }
  for (int mb = 0; mb < MB; ++mb) {
#pragma omp parallel for collapse(4)
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            int oh_beg, oh_end;
            hoist_ApiB_in( oh_beg, oh_end,
                           /*i  in   */ 0, OH,
                           /*ih=A+iB */ (kh * (p->dh+1) - PH), SH,
                           /*ih in   */ 0, IH);
            int ow_beg, ow_end;
            hoist_ApiB_in( ow_beg, ow_end,
                           /*i  in   */ 0, OW,
                           /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                           /*iw in   */ 0, IW);
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue;
            for (int ic = 0; ic < IC/G; ++ic) { // B
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
              float &dw = ((float*)diff_wei_m)[wei_off];
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
          }
        }
      }
    }
  }
#elif BW4==13 // 5.28x   nog? loop-amalg?  (no big diff) safe:5.7-5.9x  regr 5.42x 5.28x
  // PT 4.5-4.6x 4.9x loop merge?
  // PT 4.6x original loop merge attempt [old]
  // 7.3x(1t), 6.5x(6t) loop reorder and merge diff_wei and diff_dst loops
  // BUT might not scale to large # threads as well for small mb, g
  // zero the entire wei_off memory as a first step (NO minibatch loop)
  //memset( (float*)diff_wei_m, 0, diff_wei_m.size() ); // now can move mb loop freely
  // regr.sh-BWD_W 1.71x [hoist'] 1.78x
  //  FAILS 39  -- g, mb tests !
  zero_bia(p, diff_bia_m);
#pragma omp parallel
  {
#pragma omp single
    zero_wei(p, diff_wei_m);
    for (int mb = 0; mb < MB; ++mb) {
      if ((p->dir & FLAG_BIA)) {
# pragma omp for nowait
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
  for (int mb = 0; mb < MB; ++mb) {
#pragma omp parallel
#pragma omp for collapse(4)
    for (int g = 0; g < G; ++g) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int kh = 0; kh < p->kh; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            int oh_beg, oh_end;
#if 0 // Try faster hoist? <<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>
            hoist_ApiB_in( oh_beg, oh_end,
                           /*oh  in   */ 0, OH,
                           /*ih=A+ohB */ - PH + kh * (p->dh + 1), SH,
                           /*ih in    */ 0, IH);       // TYPE (was IW)
#else
            oh_beg=div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
            oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
            if (oh_beg < 0    ) oh_beg = 0;
            if (oh_end > OH) oh_end = OH;
#endif
            int ow_beg, ow_end;
#if 0
            hoist_ApiB_in( ow_beg, ow_end,
                           /*i  in   */ 0, OW,
                           /*iw=A+iB */ (kw * (p->dw+1) - PW), SW,
                           /*iw in   */ 0, IW);
#else
            ow_beg=div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
            ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
            if (ow_beg < 0    ) ow_beg = 0;
            if (ow_end > OW) ow_end = OW;
#endif
            if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
            for (int ic = 0; ic < IC/G; ++ic) { // B
              size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
              float &dw = ((float*)diff_wei_m)[wei_off];
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
          }
        }
      }
    }
  }
#elif BW4==14 // tidy up, try some questionable omp mods
#if 0
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
//#pragma omp single //// makes omp for illegally nested?
      for (int mb = 0; mb < MB; ++mb) {
        if ((p->dir & FLAG_BIA)) {
# pragma omp for nowait
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
#pragma omp parallel
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
#else
#error "oops enable a code section!"
#endif
}

}//conv::

// vim: et ts=2 sw=2 cindent cino^=l0,\:0,N-s foldmethod=indent foldlevel=3
