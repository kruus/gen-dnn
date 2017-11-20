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
 * no lambda parms by reference, test_conv_regression avg speedup = 1.557 x */
#include "conv/conv.hpp"

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

namespace conv {

void refconv_2_fwd(const prb_t *p, dnn_mem_t &src_m,
                   dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
  auto ker = [](
                const prb_t *p, const dnn_mem_t &src_m, const dnn_mem_t &wei_m,
                float &d, int g, int mb, int oc, int oh, int ow) {
    for (int ic = 0; ic < IC/G; ++ic) {
      for (int kh = 0; kh < KH; ++kh) {
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
  };

#   pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int oh = 0; oh < OH; ++oh) {
          for (int ow = 0; ow < OW; ++ow) {
            size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            size_t bia_off = bia_off_f(p, g, oc);
            float &d = ((float*)dst_m)[dst_off];
            d = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off] : 0;
            ker( p, src_m, wei_m,
                 d, g, mb, oc, oh, ow);
            if (p->merge == RELU && d < 0)
              d = 0;
          }
        }
      }
    }
  }
}

void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
                     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
#if 0 // regr 1.0x
  auto ker = [](
                const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &wei_m,
                float &ds, int g, int mb, int ic, int ih, int iw) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int kh = 0; kh < KH; ++kh) {
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
#elif 1
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
            for (int kh = 0; kh < KH; ++kh) {
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

void refconv_2_bwd_w(const prb_t *p, dnn_mem_t &src_m,
                     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {

  auto ker = [](
                const prb_t *p, const dnn_mem_t &diff_dst_m, const dnn_mem_t &src_m,
                float &dw, int g, int oc, int ic, int kh, int kw) {
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
  };

#   pragma omp parallel for collapse(5)
  for (int g = 0; g < G; ++g) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int kh = 0; kh < KH; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
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
}

}
// vim: et ts=2 sw=2 cindent cino^=l0,\:0,N-s
