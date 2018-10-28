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
 * sx vectorization ref_conv2.cpp */
#if ! defined(_SX)
#define restrict
#endif

#include "conv/conv.hpp"
namespace conv {

void sxconv_2_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m)
{
    float const * restrict psrc = (float*)src_m;
    float const * restrict pwei = (float*)wei_m;
    float const * restrict pbia = (float*)bia_m;
    float       * restrict pdst = (float*)dst_m;
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
    const ssize_t ICOG = IC/G;
    const ssize_t ICOG_KH_KW = ICOG * KH * KW;
    const ssize_t OCOG = OC / G;
    const ssize_t OH_OW = OH * OW;
    const ssize_t PH = p->ph;
    const ssize_t PW = p->pw;
    const ssize_t SH = p->sh;
    const ssize_t SW = p->sw;
    const ssize_t DH = p->dh + 1;
    const ssize_t DW = p->dw + 1;
    const ssize_t SRC_STR_IC = src_off_f2(p, 0, 0, 1, 0, 0)
        -                      src_off_f2(p, 0, 0, 0, 0, 0);
    const ssize_t SRC_STR_KW = src_off_f2(p, 0, 0, 0, 0, 1)
        -                      src_off_f2(p, 0, 0, 0, 0, 0);
    const ssize_t WEI_STR_IC = wei_off_f2(p, 0, 0, 1, 0, 0)
        -                      wei_off_f2(p, 0, 0, 0, 0, 0);
    const ssize_t WEI_STR_KW = wei_off_f2(p, 0, 0, 0, 0, 1)
        -                      wei_off_f2(p, 0, 0, 0, 0, 0);
#define LAMB 0
#if LAMB
    auto ker_ic = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
        const ssize_t ih0 = oh * SH - PH;
        const ssize_t iw0 = ow * SW - PW;
        for (ssize_t kh = 0; kh < KH; ++kh) {
            const ssize_t ih = ih0 + kh * DH;
            if (ih < 0 || ih >= IH) continue;

            for (ssize_t kw = 0; kw < KW; ++kw) {
                const ssize_t iw = iw0 + kw * DW;
                if (iw < 0 || iw >= IW) continue;

                const ssize_t src_off0 = src_off_f2(p, mb, g, 0, ih, iw); // ic=0
                const ssize_t wei_off0=  wei_off_f2(p, g, oc, 0, kh, kw);
                for (ssize_t ic = 0; ic < ICOG; ++ic) {
                    //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
                    //ssize_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw);
                    d +=  psrc[src_off0 + ic*SRC_STR_IC]
                        * pwei[wei_off0 + ic*WEI_STR_IC];
                }
            }
        }
    };
#endif
#if 1 && LAMB// SX 1.17x
    auto ker_kw = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
        for (ssize_t ic = 0; ic < ICOG; ++ic) {
            const ssize_t ih0 = oh * SH - PH;
            const ssize_t iw0 = ow * SW - PW;
            for (ssize_t kh = 0; kh < KH; ++kh) {
                const ssize_t ih = ih0 + kh * DH;
                if (ih < 0 || ih >= IH) continue;

                ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0); // iw=0
                ssize_t wei_off0 = wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
                for (ssize_t kw = 0; kw < KW; ++kw) {
                    const ssize_t iw = iw0 + kw * DW;
                    if (iw < 0 || iw >= IW) continue;

                    //ssize_t src_off = src_off0 + iw;
                    //ssize_t wei_off = wei_off0 + kw;
                    d += psrc[src_off0 + iw] * pwei[wei_off0 + kw];
                }
            }
        }
    };
#elif 1 // SX 1.12 x
    auto ker_kw = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
        for (ssize_t ic = 0; ic < ICOG; ++ic) {
            const ssize_t ih0 = oh * SH - PH;
            const ssize_t iw0 = ow * SW - PW;
            for (ssize_t kh = 0; kh < KH; ++kh) {
                const ssize_t ih = ih0 + kh * DH;
                if (ih < 0 || ih >= IH) continue;

                const ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0); // iw=0
                const ssize_t wei_off0=  wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
                for (ssize_t kw = 0; kw < KW; ++kw) {
                    const ssize_t iw = iw0 + kw * DW;
                    if (iw < 0 || iw >= IW) continue;

                    d +=  psrc[src_off0 + iw*SRC_STR_KW]
                        * pwei[wei_off0 + kw*WEI_STR_KW];
                }
            }
        }
    };
#else // SX : seems no faster 0.86x
    auto ker_kw = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
        for (ssize_t ic = 0; ic < ICOG; ++ic) {
            const ssize_t ih0 = oh * SH - PH;
            const ssize_t iw0 = ow * SW - PW;
            const ssize_t src_off0 = src_off_f2(p, mb, g, ic, 0, 0); // ih=iw=0
            const ssize_t wei_off0=  wei_off_f2(p, g, oc, ic, 0, 0);// kh=kw=0
            for (ssize_t khkw = 0; khkw < KH*KW; ++khkw) {
                const ssize_t kh = khkw / KW;
                const ssize_t kw = khkw % KW;
                const ssize_t ih = ih0 + kh * DH;
                if (ih < 0 || ih >= IH) continue;

                const ssize_t iw = iw0 + kw * DW;
                if (iw < 0 || iw >= IW) continue;

                d +=  psrc[src_off0 + ih*IW + iw]
                    * pwei[wei_off0 + kh*KW + kw];
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

    OMP(parallel for collapse(5))//;
    for (ssize_t g = 0; g < G; ++g) {
    for (ssize_t mb = 0; mb < MB; ++mb) {
        for (ssize_t oc = 0; oc < OCOG; ++oc) {
        for (ssize_t oh = 0; oh < OH; ++oh) {
        for (ssize_t ow = 0; ow < OW; ++ow) {
            const ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
            float &d = pdst[dst_off];

            d = 0.f;
#if LAMB
            if( ICOG > KW ){
                ker_ic(d, g, mb, oc, oh, ow);
            } else {
                ker_kw(d, g, mb, oc, oh, ow);
            }
#else
            if( ICOG > KW ){
                const ssize_t ih0 = oh * SH - PH;
                const ssize_t iw0 = ow * SW - PW;
                for (ssize_t kh = 0; kh < KH; ++kh) {
                    const ssize_t ih = ih0 + kh * DH;
                    if (ih < 0 || ih >= IH) continue;

                    for (ssize_t kw = 0; kw < KW; ++kw) {
                        const ssize_t iw = iw0 + kw * DW;
                        if (iw < 0 || iw >= IW) continue;

                        const ssize_t src_off0 = src_off_f2(p, mb, g, 0, ih, iw); // ic=0
                        const ssize_t wei_off0=  wei_off_f2(p, g, oc, 0, kh, kw);
                        for (ssize_t ic = 0; ic < ICOG; ++ic) {
                            //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
                            //ssize_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw);
                            d +=  psrc[src_off0 + ic*SRC_STR_IC]
                                * pwei[wei_off0 + ic*WEI_STR_IC];
                        }
                    }
                }
            } else {
                for (ssize_t ic = 0; ic < ICOG; ++ic) {
                    const ssize_t ih0 = oh * SH - PH;
                    const ssize_t iw0 = ow * SW - PW;
                    for (ssize_t kh = 0; kh < KH; ++kh) {
                        const ssize_t ih = ih0 + kh * DH;
                        if (ih < 0 || ih >= IH) continue;

                        ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0); // iw=0
                        ssize_t wei_off0 = wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
                        for (ssize_t kw = 0; kw < KW; ++kw) {
                            const ssize_t iw = iw0 + kw * DW;
                            if (iw < 0 || iw >= IW) continue;

                            //ssize_t src_off = src_off0 + iw;
                            //ssize_t wei_off = wei_off0 + kw;
                            d += psrc[src_off0 + iw] * pwei[wei_off0 + kw];
                        }
                    }
                }
            }
#endif

            if (p->dir & FLAG_BIA) {
                const ssize_t bia_off = bia_off_f2(p, g, oc);
                d += pbia[bia_off];
            }

            maybe_scale(d);

            if (p->merge == RELU && d < 0.f)
                d = 0.f;
        }
        }
        }
    }
    }
}

void sxconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
    float       * restrict const pdiff_src = (float*)diff_src_m;
    float const * restrict const pwei = (float*)wei_m;
    float const * restrict const pdiff_dst = (float*)diff_dst_m;
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
#if LAMB
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

                //const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
                //const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
                for (int oc = 0; oc < OCOG; ++oc) {
                    size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                    size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                    ds += pdiff_dst[dst_off] * pwei[wei_off];
                    //ds += pdiff_dst[dst_off0 + oc*OH_OW]
                    //    * pwei     [wei_off0 + oc*ICOG_KH_KW];
                }
            }
        }
    };
#endif

    OMP(parallel for collapse(5))//;
    for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
        for (int ic = 0; ic < ICOG; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
        for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = pdiff_src[src_off];
            ds = 0;
#if LAMB
            ker(ds, g, mb, ic, ih, iw);
#else
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

                    const size_t dst_off0 = (((int)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
                    const size_t wei_off0 = ((((int)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
                    for (int oc = 0; oc < OCOG; ++oc) {
                        //int dst_off = dst_off_f(p, mb, g, oc, oh, ow);
                        //int wei_off = wei_off_f(p, g, oc, ic, kh, kw);
                        ds += pdiff_dst[dst_off0 + oc*OH_OW]
                            * pwei     [wei_off0 + oc*ICOG_KH_KW];
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

void sxconv_2_bwd_w(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
    float const * restrict const psrc = (float*)src_m;
    float       * restrict const pdiff_wei = (float*)diff_wei_m;
    float       * restrict const pdiff_bia = (float*)diff_bia_m;
    float const * restrict const pdiff_dst = (float*)diff_dst_m;
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
    const ssize_t OCOG = OC/G;
    const ssize_t OH_OW = OH * OW;
    ssize_t const IH_IW = IH * IW;
    auto ker = [&](float &dw, ssize_t g, ssize_t oc, ssize_t ic, ssize_t kh, ssize_t kw) {
        for (ssize_t mb = 0; mb < p->mb; ++mb) {
            for (ssize_t oh = 0; oh < p->oh; ++oh) {
                const ssize_t ih = oh * p->sh - p->ph + kh * (p->dh + 1);
                if (ih < 0 || ih >= p->ih) continue;
                //const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + oc) * OH + oh) * OW + 0;
                //ssize_t const src_off0 = (((ssize_t)mb * IC + g * ICOG + 0 ) * IH + ih) * IW + 0;
                for (ssize_t ow = 0; ow < p->ow; ++ow) {
                    const ssize_t iw = ow * p->sw - p->pw + kw * (p->dw + 1);
                    if (iw < 0 || iw >= p->iw) continue;

                    ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
                    ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
                    dw += pdiff_dst[dst_off] * psrc[src_off];
                    //dw += pdiff_dst[dst_off0 + ow] * psrc[src_off0 + iw];
                }
            }
        }
    };

    OMP(parallel for collapse(5))//;
    for (ssize_t g = 0; g < p->g; ++g) {
        for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
        for (ssize_t ic = 0; ic < p->ic/p->g; ++ic) {
            for (ssize_t kh = 0; kh < p->kh; ++kh) {
            for (ssize_t kw = 0; kw < p->kw; ++kw) {
                ssize_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw);
                //float &dw = ((float*)diff_wei_m)[wei_off];
                float &dw = pdiff_wei[wei_off];
                dw = 0;
                ker(dw, g, oc, ic, kh, kw);
            }
            }
        }
        }
    }

    if (!(p->dir & FLAG_BIA)) return;

    OMP(parallel for collapse(2))//;
    for (ssize_t g = 0; g < p->g; ++g) {
        for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
            ssize_t bia_off = bia_off_f2(p, g, oc);
            float &db = pdiff_bia[bia_off];
            db = 0;

            for (ssize_t mb = 0; mb < p->mb; ++mb) {
                for (ssize_t oh = 0; oh < p->oh; ++oh) {
                for (ssize_t ow = 0; ow < p->ow; ++ow) {
                    ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
                    db += pdiff_dst[dst_off];
                }
                }
            }
        }
    }
}

}
// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
