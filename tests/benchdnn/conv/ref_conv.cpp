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

#include "conv/conv.hpp"
#define PTRMOD 0
namespace conv {

void compute_ref_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
#if PTRMOD==1
    float const * restrict psrc = (float*)src_m;
    float const * restrict pwei = (float*)wei_m;
    float const * restrict pbia = (float*)bia_m;
    float       * restrict pdst = (float*)dst_m;
#endif
#if PTRMOD==1
    auto ker = [&](float &d, int g, int mb, int oc, int oh, int ow) {
            for (int kh = 0; kh < p->kh; ++kh) {
                const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                if (ih < 0 || ih >= p->ih) continue;

                for (int kw = 0; kw < p->kw; ++kw) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    if (iw < 0 || iw >= p->iw) continue;

        for (int ic = 0; ic < p->ic/p->g; ++ic) {
                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    d += psrc[src_off] * pwei[wei_off];
                }
            }
        }
    };
#else
    auto ker = [&](float &d, int g, int mb, int oc, int oh, int ow) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
            for (int kh = 0; kh < p->kh; ++kh) {
                const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                if (ih < 0 || ih >= p->ih) continue;

                for (int kw = 0; kw < p->kw; ++kw) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    if (iw < 0 || iw >= p->iw) continue;

                    size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
                }
            }
        }
    };
#endif

    auto maybe_scale = [&](float &d) {
        if (!p->attr.oscale.is_def()) {
            using policy_t = attr_t::scale_t::policy_t;
            const auto &s = p->attr.oscale;
            if (s.policy == policy_t::COMMON) {
                d *= s.scale;
            } else {
                /* unsupported so far */
                []() { SAFE(FAIL, CRIT); return 0; }();
            }
        }
    };

#   pragma omp parallel for collapse(5)
    for (size_t g = 0; g < p->g; ++g) {
    for (size_t mb = 0; mb < p->mb; ++mb) {
        for (size_t oc = 0; oc < p->oc/p->g; ++oc) {
        for (size_t oh = 0; oh < p->oh; ++oh) {
        for (size_t ow = 0; ow < p->ow; ++ow) {
            const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
#if PTRMOD==1
            float &d = pdst[dst_off];
#else
            float &d = ((float*)dst_m)[dst_off];
#endif

            d = 0;
            ker(d, g, mb, oc, oh, ow);

            if (p->dir & FLAG_BIA) {
                const size_t bia_off = bia_off_f(p, g, oc);
                d += ((float*)bia_m)[bia_off];
            }

            maybe_scale(d);

            if (p->merge == RELU && d < 0)
                d = 0;
        }
        }
        }
    }
    }
}

void compute_ref_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
#if PTRMOD==0
  const size_t G = p->g;
  const size_t MB = p->mb;
  const size_t IC = p->ic;
  const size_t IH = p->ih;
  const size_t IW = p->iw;
  const size_t ICOG = IC/G;
#endif
#if PTRMOD==1
  float       * restrict const pdiff_src = (float*)diff_src_m;
  float const * restrict const pwei = (float*)wei_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
  const size_t G = p->g;
  const size_t MB = p->mb;
  const size_t IC = p->ic;
  const size_t IH = p->ih;
  const size_t IW = p->iw;
  const size_t OC = p->oc;
  const size_t OH = p->oh;
  const size_t OW = p->ow;
  const size_t KH = p->kh;
  const size_t KW = p->kw;
  const size_t ICOG = IC/G;
  const size_t ICOG_KH_KW = ICOG * KH * KW;
  const size_t OCOG = OC / G;
  const size_t OH_OW = OH * OW;
#endif
#if PTRMOD==1
    auto ker = [&](float &ds, int g, int mb, int ic, int ih, int iw) {
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

                    const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
                    size_t const wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
        for (size_t oc = 0; oc < OCOG; ++oc) {
                    //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    ds += pdiff_dst[dst_off0 + oc*OH_OW]
                        * pwei     [wei_off0 + oc*ICOG_KH_KW];
                }
            }
        }
    };
#else
    auto ker = [&](float &ds, int g, int mb, int ic, int ih, int iw) {
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

#   pragma omp parallel for collapse(5)
    for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
        for (int ic = 0; ic < ICOG; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
        for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
#if PTRMOD==1
            float &ds = pdiff_src[src_off];
#else
            float &ds = ((float*)diff_src_m)[src_off];
#endif
            ds = 0;
            ker(ds, g, mb, ic, ih, iw);
        }
        }
        }
    }
    }
}

void compute_ref_bwd_w(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
#if PTRMOD==1
  float const * restrict const psrc = (float*)src_m;
  float       * restrict const pdiff_wei = (float*)diff_wei_m;
  float const * restrict const pdiff_bia = (float*)diff_bia_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
  const size_t G = p->g;
  const size_t MB = p->mb;
  const size_t IC = p->ic;
  const size_t IH = p->ih;
  const size_t IW = p->iw;
  const size_t OC = p->oc;
  const size_t OH = p->oh;
  const size_t OW = p->ow;
  const size_t KH = p->kh;
  const size_t KW = p->kw;
  const size_t ICOG = IC/G;
  const size_t ICOG_KH_KW = ICOG * KH * KW;
  const size_t OCOG = OC/G;
  const int OH_OW = OH * OW;
  size_t const IH_IW = IH * IW;
    auto ker = [&](float &dw, int g, int oc, int ic, int kh, int kw) {
        for (int mb = 0; mb < p->mb; ++mb) {
            for (int oh = 0; oh < p->oh; ++oh) {
                const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                if (ih < 0 || ih >= p->ih) continue;
                const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + oc) * OH + oh) * OW + 0;
                size_t const src_off0 = (((size_t)mb * IC + g * ICOG + 0 ) * IH + ih) * IW + 0;
                for (int ow = 0; ow < p->ow; ++ow) {
                    const int iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    if (iw < 0 || iw >= p->iw) continue;

                    //size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
                    //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    dw += pdiff_dst[dst_off0 + ow]
                        * psrc     [src_off0 + iw];
                }
            }
        }
    };
#else
    auto ker = [&](float &dw, int g, int oc, int ic, int kh, int kw) {
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
#endif

#   pragma omp parallel for collapse(5)
    for (int g = 0; g < p->g; ++g) {
        for (int oc = 0; oc < p->oc/p->g; ++oc) {
        for (int ic = 0; ic < p->ic/p->g; ++ic) {
            for (int kh = 0; kh < p->kh; ++kh) {
            for (int kw = 0; kw < p->kw; ++kw) {
                size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                float &dw = ((float*)diff_wei_m)[wei_off];
                dw = 0;
                ker(dw, g, oc, ic, kh, kw);
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

}
// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
