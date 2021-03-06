/*******************************************************************************
* Copyright 2016-2020 Intel Corporation
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

#include "dnnl_types.h"

#include "common/c_types_map.hpp"
#include "common/dnnl_thread.hpp"
#include "common/type_helpers.hpp"
#include "common/utils.hpp"

#include "common/bfloat16.hpp"
#include "cpu/gemm_convolution_utils.hpp"

#include "cpu/platform.hpp"
#include "cpu/ve/hoist.hpp"

#if defined(__ve)
typedef int64_t int_t;
#else
typedef int int_t;
#endif
#define FOR(VAR,END) for(int_t VAR=0; VAR < (END); ++VAR)
#define NOVEC _Pragma("_NEC novector")

namespace dnnl {
namespace impl {
namespace cpu {

using namespace dnnl::impl::status;
using namespace dnnl::impl::utils;
using namespace prop_kind;
using namespace data_type;

namespace jit_gemm_convolution_utils {
namespace {
//
// simplify generic hoist.hpp function for conv_gemm_conf_t &jcp arguments
//
/** Calc `oh` loop limits so `ih` lies within valid range.
 * Normally oh goes from 0..jcp.oh-1 and we only use
 * ```
 *    ih = oh * jcp.stride_h - jcp.t_pad + kh * (1 + jcp.dilate_h);
 *              [--- b ----] [------------  a  ------------------]
 * ```
 * with ih in valid range [0,jcp.ih) = [c,d) with an inner loop conditional
 *
 * This can be inverted to calculated the range of oh s.t. ih is valid
 *
 * (within this file, this is often simplified for special cases to
 *  use the 'saturate' function)
 */
inline __attribute((always_inline)) void compute_oh_bounds(
        conv_gemm_conf_t const& jcp, int& oh_beg, int& oh_end, int const kh) {
    oh_beg = div_floor( 0      + jcp.t_pad - kh * (jcp.dilate_h + 1) + jcp.stride_h - 1, jcp.stride_h);//(c-a+b-1)/b
    oh_end = div_floor( jcp.ih + jcp.t_pad - kh * (jcp.dilate_h + 1) + jcp.stride_h - 1, jcp.stride_h);//(d-a+b-1)/b
    if (oh_beg < 0      ) oh_beg = 0;
    if (oh_end > jcp.oh ) oh_end = jcp.oh;
    // do not need any more fixup of oh_beg and oh_end
    // because only care about oh_beg < oh_end cases.
}

/** Calc `ow` loop limits so `iw` lies within valid range [0,jcp,iw).
 * Normally ow goes from 0..jcp.ow-1 and we only use
 * ```
 *    iw = ow * jcp.stride_2 - jcp.t_pad + kw * (1 + jcp.dilate_w)
 *       = ow *      b       + a
 * ```
 * using an inner loop conditional to process only iw in valid range [c,d).
 *
 * This is inverted to calculated the range of ow s.t. iw will lie in [c,d).
 *
 * Naive solution as `ow=(iw-a)/b` neglects round incorrectly.
 * 
 * Instead the formula is based on `ow = (iw-a+b-1)/b` where
 * \c div_floor does round-to-negative-infinity integer division
 * for +ve numerator `b = jcp.stride_w`.
 */
inline __attribute((always_inline)) void compute_ow_bounds(
        conv_gemm_conf_t const& jcp, int& ow_beg, int& ow_end, int const kw) {
    // return for(ow_beg..ow_end) loop range such that linear mapping
    //    iw = a + ow * b satisfies (c=0) <= iw < (d=jcp.iw).
    //                  --c,d--  [-----------     -a      ---------]   [--- b ----]
    ow_beg = div_floor( 0      + jcp.l_pad - kw * (jcp.dilate_w + 1) + jcp.stride_w - 1, jcp.stride_w);//(c-a+b-1)/b
    ow_end = div_floor( jcp.iw + jcp.l_pad - kw * (jcp.dilate_w + 1) + jcp.stride_w - 1, jcp.stride_w);//(d-a+b-1)/b
    if (ow_beg < 0      ) ow_beg = 0;
    if (ow_end > jcp.ow ) ow_end = jcp.ow;
}
}//anon::

template <typename data_type_t>
void im2col_3d(const conv_gemm_conf_t &jcp, const data_type_t *im,
        data_type_t *col, int od) {
    // NOTE: like v0.16 im2col_3d compute_im2col_outer_padding lambda
    // nc++-3.0.25 has issues *except* at -O0 compile!
    //    inline warning about too complicated logic for masks
    // Workaround 1 : NOVEC on **all** loops
#if 0
    // kh,kw bounds calc (ok if kernel is very large!)
    int khb[jcp.oh] alignas(64);
    int khe[jcp.oh] alignas(64);
    int kwb[jcp.ow] alignas(64);
    int kwe[jcp.ow] alignas(64);
    for (int oh = 0; oh < jcp.oh; ++oh) {
        // trick to easy calc of kh, kw loop limits is that division must
        // // round more consistently.  'C' round-to-zero is not so useful!
        khb[oh] = div_floor( 0      - (jcp.oh * jcp.stride_h - jcp.t_pad) + jcp->dilate_h, jcp->dilate_h + 1 );
        khe[oh] = div_floor( jcp.ih - (jcp.oh * jcp.stride_h - jcp.t_pad) + jcp->dilate_h, jcp->dilate_h + 1 );
        if( khb[oh] < 0      ) khb[oh] = 0;
        if( khe[oh] > jcp.kh ) khe[oh] = jcp.kh;
    }
    for (int ow = 0; ow < jcp.ow; ++ow) {
        kwb[ow] = div_floor( 0      - (jcp.ow * jcp.stride_w - jcp.l_pad) + jcp->dilate_w, jcp->dilate_w + 1 );
        kwe[ow] = div_floor( jcp.iw - (jcp.ow * jcp.stride_w - jcp.l_pad) + jcp->dilate_w, jcp->dilate_w + 1 );
        if( kwb[ow] < 0      ) kwb[ow] = 0;
        if( kwe[ow] > jcp.kw ) kwe[ow] = jcp.kw;
    }
#endif
    parallel_nd(jcp.ic, [&jcp,im,col,od](int ic) {
        const size_t OHW = jcp.oh * jcp.ow;
        const size_t im_step = jcp.ih * jcp.iw * jcp.id;
        const size_t col_step = jcp.ks * OHW;

        const data_type_t *__restrict im_loc = im + ic * im_step;
        data_type_t *__restrict col_loc = col + ic * col_step;
#if 0 // Workaround 1 : NOVEC for all loops
        //
        // nc++-3.0.25 had very serious (mask-related?) issues compiling these loops
        //
        int id = od * jcp.stride_d - jcp.f_pad;
        NOVEC FOR(kd,jcp.kd) {
            data_type_t *__restrict col_ = col_loc + kd * jcp.kh * jcp.kw * OHW;
            if (id < 0 || id >= jcp.id) {
                int ih_ = -jcp.t_pad;
                NOVEC FOR(kh,jcp.kh) {
                    int ih = ih_;
                    NOVEC FOR(oh,jcp.oh) {
                        if (ih < 0 || ih >= jcp.ih) {
                            ih += jcp.stride_h;
                            continue;
                        }
                        int iw_ = -jcp.l_pad;
                        NOVEC FOR(kw,jcp.kw) {
                            int iw = iw_;
                            NOVEC FOR(ow,jcp.ow) {
                                if (iw < 0 || iw >= jcp.iw) {
                                    iw += jcp.stride_w;
                                    continue;
                                }

                                const size_t col_idx
                                        = kw * OHW + oh * jcp.ow + ow;

                                col_[col_idx] = data_type_t{0};
                                iw += jcp.stride_w;
                            }
                            iw_ += (1 + jcp.dilate_w);
                        }
                        ih += jcp.stride_h;
                    }
                    ih_ += (1 + jcp.dilate_h);
                    col_ += jcp.kw * OHW;
                }
            } else {
                const data_type_t *__restrict im_
                        = im_loc + id * jcp.ih * jcp.iw;
                int ih_ = -jcp.t_pad;
                NOVEC FOR(kh,jcp.kh) {
                    int ih = ih_;
                    NOVEC FOR(oh,jcp.oh) {
                        if (ih < 0 || ih >= jcp.ih) {
                            ih += jcp.stride_h;
                            continue;
                        }
                        int iw_ = -jcp.l_pad;
                        NOVEC FOR(kw,jcp.kw) {
                            int iw = iw_;
                            NOVEC FOR(ow,jcp.ow) {
                                if (iw < 0 || iw >= jcp.iw) {
                                    iw += jcp.stride_w;
                                    continue;
                                }

                                const size_t col_idx
                                        = kw * OHW + oh * jcp.ow + ow;
                                const size_t im_idx = ih * jcp.iw + iw;

                                col_[col_idx] = im_[im_idx];
                                iw += jcp.stride_w;
                            }
                            iw_ += (1 + jcp.dilate_w);
                        }
                        ih += jcp.stride_h;
                    }
                    ih_ += (1 + jcp.dilate_h);
                    col_ += jcp.kw * OHW;
                }
            }
            id += (1 + jcp.dilate_d);
        }
#elif 0 // Workaround 2 : calculate bounds to remove inner loop conditionals
        int id = od * jcp.stride_d - jcp.f_pad;
        NOVEC FOR(kd,jcp.kd) {
            data_type_t *__restrict col_ = col_loc + kd * jcp.kh * jcp.kw * OHW;
            if (id < 0 || id >= jcp.id) {
                FOR(kh,jcp.kh) {
                    int oh_beg, oh_end;
                    compute_oh_bounds(jcp, oh_beg, oh_end, kh);
                    for(int oh=oh_beg; oh<oh_end; ++oh) { // ih ok
                        FOR(kw,jcp.kw) {
                            int ow_beg, ow_end; // s.t. iw lies in [0,jcp.iw)
                            compute_ow_bounds(jcp, ow_beg, ow_end, kw);
                            for(int_t ow=ow_beg; ow<ow_end; ++ow) {
                                col_[oh * jcp.ow + kw * OHW + ow]
                                        = data_type_t{0};
                            }
                        }
                    }
                    col_ += jcp.kw * OHW;
                }
            } else {
                const data_type_t *__restrict im_
                        = im_loc + id * jcp.ih * jcp.iw;
                FOR(kh,jcp.kh) {
                    int oh_beg, oh_end;
                    compute_oh_bounds(jcp, oh_beg, oh_end, kh);
                    for(int oh=oh_beg; oh<oh_end; ++oh) { // ih ok
                        const int_t ih_IW_pad = (oh * jcp.stride_h - jcp.t_pad
                                + kh * (1 + jcp.dilate_h)) * jcp.iw - jcp.l_pad;
                        FOR(kw,jcp.kw) {
                            int ow_beg, ow_end; // s.t. iw lies in [0,jcp.iw)
                            compute_ow_bounds(jcp, ow_beg, ow_end, kw);
                            for(int_t ow=ow_beg; ow<ow_end; ++ow) {
                                col_[oh * jcp.ow + kw * OHW + ow]
                                        = im_[ih_IW_pad
                                        +     kw * (1 + jcp.dilate_w)
                                        +     ow * jcp.stride_w];
                            }
                        }
                    }
                    col_ += jcp.kw * OHW;
                }
            }
            id += (1 + jcp.dilate_d);
        }
#elif 1 // Workaround 3 : precalc ohb[], ohe[], owb[], owe[] bounds
        // (possibly calc this const data pre-parallel?)
        int oh_beg[jcp.kh], oh_end[jcp.kh];
        FOR(kh, jcp.kh) compute_oh_bounds(jcp, oh_beg[kh], oh_end[kh], kh);
        int ow_beg[jcp.kw], ow_end[jcp.kw];
        FOR(kw, jcp.kw) compute_ow_bounds(jcp, ow_beg[kw], ow_end[kw], kw);

        int id = od * jcp.stride_d - jcp.f_pad;
        NOVEC FOR(kd,jcp.kd) {
            data_type_t *__restrict col_ = col_loc + kd * jcp.kh * jcp.kw * OHW;
            if (id < 0 || id >= jcp.id) {
                FOR(kh,jcp.kh) {
                    for(int oh=oh_beg[kh]; oh<oh_end[kh]; ++oh) {
                        FOR(kw,jcp.kw) {
                            for(int_t ow=ow_beg[kw]; ow<ow_end[kw]; ++ow) {
                                col_[oh * jcp.ow + kw * OHW + ow]
                                        = data_type_t{0};
                            }
                        }
                    }
                    col_ += jcp.kw * OHW;
                }
            } else {
                const data_type_t *__restrict im_
                        = im_loc + id * jcp.ih * jcp.iw;
                FOR(kh,jcp.kh) {
                    for(int oh=oh_beg[kh]; oh<oh_end[kh]; ++oh) {
                        const int_t ih_IW_pad = (oh * jcp.stride_h - jcp.t_pad
                                + kh * (1 + jcp.dilate_h)) * jcp.iw - jcp.l_pad;
                        FOR(kw,jcp.kw) {
                            for(int_t ow=ow_beg[kw]; ow<ow_end[kw]; ++ow) {
                                col_[oh * jcp.ow + kw * OHW + ow]
                                        = im_[ih_IW_pad
                                        +     kw * (1 + jcp.dilate_w)
                                        +     ow * jcp.stride_w];
                            }
                        }
                    }
                    col_ += jcp.kw * OHW;
                }
            }
            id += (1 + jcp.dilate_d);
        }
#endif
    });
}

template void im2col_3d(
        const conv_gemm_conf_t &jcp, const float *im, float *col, int od);

template void im2col_3d(const conv_gemm_conf_t &jcp, const bfloat16_t *im,
        bfloat16_t *col, int od);

/* imtr[ic][od][oh][ow] <-- im[id][ih][iw][ic]*/
template <typename T>
void transpose_u8(const conv_gemm_conf_t &jcp, const T *__restrict im,
        T *__restrict imtr) {
    uint8_t shift = jcp.signed_input ? 128 : 0;
    const int_t ic_stride = jcp.id * jcp.ih * jcp.iw;
    const int_t IC = jcp.ngroups * jcp.ic;
    const int_t IHW = jcp.ih * jcp.iw;
    constexpr int_t ic_block = platform::get_cache_line_size();
    const int_t nb_ic = jcp.ic / ic_block;
    const int_t ic_blocked = nb_ic * ic_block;
    parallel_nd(jcp.id, jcp.ih, [&](int id, int ih) {
        const T *__restrict im_h = im + id * IHW * IC + ih * jcp.iw * IC;
        T *__restrict imtr_h = imtr + id * IHW + ih * jcp.iw;
        FOR(iw,jcp.iw) {
            const T *__restrict im_w = im_h + iw * IC;
            T *__restrict imtr_w = imtr_h + iw;
            FOR(icb,nb_ic) {
                const T *__restrict im_icb = im_w + icb * ic_block;
                T *__restrict imtr_icb = imtr_w + icb * ic_block * ic_stride;
                PRAGMA_OMP_SIMD()
                FOR(ic,ic_block) {
                    imtr_icb[ic * ic_stride] = im_icb[ic] + shift;
                }
            }
            for (int_t ic = ic_blocked; ic < jcp.ic; ic++) {
                imtr_w[ic * ic_stride] = im_w[ic] + shift;
            }
        }
    });
}

template void transpose_u8(const conv_gemm_conf_t &jcp,
        const int8_t *__restrict im, int8_t *__restrict imtr);
template void transpose_u8(const conv_gemm_conf_t &jcp,
        const uint8_t *__restrict im, uint8_t *__restrict imtr);

/* col[kd][kh][kw][g][ic][od][oh][ow] <-- im2col_u8_3d(im[id][ih][iw][g][ic]) */
template <typename T>
void im2col_u8_3d(const conv_gemm_conf_t &jcp, const T *__restrict imtr,
        uint8_t *__restrict col, int od) {
    uint8_t shift = jcp.signed_input ? 128 : 0;
    const int_t dd = 1 + jcp.dilate_d;
    const int dh = 1 + jcp.dilate_h;
    const int dw = 1 + jcp.dilate_w;
    const int_t sd = jcp.stride_d;
    const int sh = jcp.stride_h;
    const int sw = jcp.stride_w;
    const int_t fp = jcp.f_pad;
    const int tp = jcp.t_pad;
    const int lp = jcp.l_pad;
    const int_t col_ic_s = jcp.oh * jcp.ow;
    const int_t col_kw_s = jcp.ic * col_ic_s;
    const int_t col_kh_s = jcp.kw * col_kw_s;
    const int_t col_kd_s = jcp.kh * col_kh_s;
    const int_t IHW = jcp.ih * jcp.iw;
    const int_t OHW = jcp.oh * jcp.ow;

    if (sd == 1 && sh == 1 && sw == 1 && dd == 1 && dh == 1 && dw == 1)
        parallel_nd(jcp.kd, jcp.kh, jcp.kw, jcp.ic,
                [&](int_t const kd, int const kh, int const kw, int const ic) {
                    uint8_t *__restrict col_loc = col + kd * col_kd_s
                            + kh * col_kh_s + kw * col_kw_s + ic * col_ic_s;
                    const int_t id = od - fp + kd;
                    if (id < 0 || id >= jcp.id) {
                        for (ptrdiff_t i = 0; i < OHW; i++)
                            col_loc[i] = shift;
                        return;
                    }
                    const T *__restrict imtr_loc
                            = imtr + (ic * jcp.id + id) * IHW;
                    const int_t oh_start = saturate(0, jcp.oh, tp - kh);
                    const int_t oh_end = saturate(0, jcp.oh, jcp.ih + tp - kh);
                    const int_t ow_start = saturate(0, jcp.ow, lp - kw);
                    const int_t ow_end = saturate(0, jcp.ow, jcp.iw + lp - kw);
                    for (int_t oh = oh_start, ih = oh_start - tp + kh;
                            oh < oh_end; oh++, ih++) {
                        uint8_t *__restrict col_h = col_loc + oh * jcp.ow;
                        const T *__restrict imtr_h = imtr_loc + ih * jcp.iw;
                        for (int_t ow = ow_start, iw = ow_start - lp + kw;
                                ow < ow_end; ow++, iw++) {
                            col_h[ow] = imtr_h[iw];
                        }
                    }
                });
    else if (sd == 2 && sh == 2 && sw == 2 && dd == 1 && dh == 1 && dw == 1)
        parallel_nd(jcp.kd, jcp.kh, jcp.kw, jcp.ic,
                [&](int const kd, int const kh, int const kw, int const ic) {
                    uint8_t *__restrict col_loc = col + kd * col_kd_s
                            + kh * col_kh_s + kw * col_kw_s + ic * col_ic_s;
                    const int_t id = od * 2 - fp + kd;
                    if (id < 0 || id >= jcp.id) {
                        for (ptrdiff_t i = 0; i < OHW; i++)
                            col_loc[i] = shift;
                        return;
                    }
                    const T *__restrict imtr_loc
                            = imtr + (ic * jcp.id + id) * IHW;
                    const int_t oh_start
                            = saturate(0, jcp.oh, div_up(tp - kh, 2));
                    const int_t oh_end
                            = saturate(0, jcp.oh, div_up(jcp.ih + tp - kh, 2));
                    const int_t ow_start
                            = saturate(0, jcp.ow, div_up(lp - kw, 2));
                    const int_t ow_end
                            = saturate(0, jcp.ow, div_up(jcp.iw + lp - kw, 2));
                    for (int_t oh = oh_start, ih = oh_start * 2 - tp + kh;
                            oh < oh_end; ++oh, ih += 2) {
                        uint8_t *__restrict col_h = col_loc + oh * jcp.ow;
                        const T *__restrict imtr_h = imtr_loc + ih * jcp.iw;
                        for (int_t ow = ow_start, iw = ow_start * 2 - lp + kw;
                                ow < ow_end; ++ow, iw += 2) {
                            col_h[ow] = imtr_h[iw];
                        }
                    }
                });
    else
        parallel_nd(jcp.kd, jcp.kh, jcp.kw, jcp.ic,
                [&](int const kd, int const kh, int const kw, int const ic) {
                    uint8_t *__restrict col_loc = col + kd * col_kd_s
                            + kh * col_kh_s + kw * col_kw_s + ic * col_ic_s;
                    const int_t id = od * sd - fp + kd * dd;
                    if (id < 0 || id >= jcp.id) {
                        for (ptrdiff_t i = 0; i < OHW; i++)
                            col_loc[i] = shift;
                        return;
                    }
                    const T *__restrict imtr_loc
                            = imtr + (ic * jcp.id + id) * IHW;
                    const int_t oh_start
                            = saturate(0, jcp.oh, div_up(tp - kh * dh, sh));
                    const int_t oh_end = saturate(
                            0, jcp.oh, div_up(jcp.ih + tp - kh * dh, sh));
                    const int_t ow_start
                            = saturate(0, jcp.ow, div_up(lp - kw * dw, sw));
                    const int_t ow_end = saturate(
                            0, jcp.ow, div_up(jcp.iw + lp - kw * dw, sw));
                    for (int_t oh = oh_start, ih = oh_start * sh - tp + kh * dh;
                            oh < oh_end; ++oh, ih += sh) {
                        uint8_t *__restrict col_h = col_loc + oh * jcp.ow;
                        const T *__restrict imtr_h = imtr_loc + ih * jcp.iw;
                        for (int_t ow = ow_start,
                                 iw = ow_start * sw - lp + kw * dw;
                                ow < ow_end; ++ow, iw += sw) {
                            col_h[ow] = imtr_h[iw];
                        }
                    }
                });
}

template void im2col_u8_3d<int8_t>(const conv_gemm_conf_t &jcp,
        const int8_t *__restrict im, uint8_t *__restrict col, int od);

template void im2col_u8_3d<uint8_t>(const conv_gemm_conf_t &jcp,
        const uint8_t *__restrict im, uint8_t *__restrict col, int od);

namespace {
template <typename data_type_t>
void im2col_inner_thr_sw1(const conv_gemm_conf_t &jcp, const data_type_t *__restrict im,
        data_type_t *__restrict col, int ss, int sb, int cs, int cb) {
    assert( jcp.stride_w == 1 );
    const size_t im_step = jcp.is;
    const size_t col_step = jcp.ks * sb;
    const int_t dh = 1 + jcp.dilate_h;
    const int_t dw = 1 + jcp.dilate_w;
    const int_t sh = jcp.stride_h;
    //const int_t sw = jcp.stride_w;
    const int_t tp = jcp.t_pad;
    const int_t lp = jcp.l_pad;
    const int_t first_oh = ss / jcp.ow;
    const int_t last_oh = (ss + sb - 1) / jcp.ow;
    const int_t oh_begin = first_oh;
    const int_t oh_end = last_oh + 1;
    const int_t first_ow = ss % jcp.ow;
    const int_t last_ow = (ss + sb - 1) % jcp.ow;
    // TODO: optimize threading if jcp.ic*jcp.kh*jcp.kw*oh_range is small
    // comparing to number of threads
    const int oh_range = oh_end - oh_begin;
    // Generated code is more optimized for stride_w == 1
    // because innermost loop is by width
    parallel_nd(cb, jcp.kh, jcp.kw, oh_range,
            [&](int_t const ic, int_t const kh, int_t const kw, int_t const ohr) {
                const int_t oh = ohr + oh_begin;
                const int_t ih = oh * sh - tp + kh * dh;
                const int_t ow_start = (oh == first_oh) ? first_ow : 0;
                const int_t ow_end
                        = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                data_type_t *__restrict col_oh = col + ic * col_step
                        + (kh * jcp.kw + kw) * sb + oh * jcp.ow - ss;
                const data_type_t *__restrict im_
                        = im + (ic + cs) * im_step + ih * jcp.iw;
                const int_t iw_shift = kw * dw - lp;
                if (ih < 0 || ih >= jcp.ih)
                    for (int_t ow = ow_start; ow < ow_end; ow++)
                        col_oh[ow] = (data_type_t)0;
                else
                    for (int_t ow = ow_start; ow < ow_end; ow++) {
                        const int_t iw = ow + iw_shift;
                        //col_oh[ow] = (iw < 0 || iw >= jcp.iw
                        //        ? data_type_t{0}: im_[iw]);
                        if (iw < 0 || iw >= jcp.iw)
                            col_oh[ow] = (data_type_t)0;
                        else
                            col_oh[ow] = im_[iw];
                    }
            });
}
template <typename data_type_t>
void im2col_inner_thr(const conv_gemm_conf_t &jcp, const data_type_t *__restrict im,
        data_type_t *__restrict col, int ss, int sb, int cs, int cb) {
    const size_t im_step = jcp.is;
    const size_t col_step = jcp.ks * sb;
    const int_t dh = 1 + jcp.dilate_h;
    const int_t dw = 1 + jcp.dilate_w;
    const int_t sh = jcp.stride_h;
    const int_t sw = jcp.stride_w;
    const int_t tp = jcp.t_pad;
    const int_t lp = jcp.l_pad;
    const int_t first_oh = ss / jcp.ow;
    const int_t last_oh = (ss + sb - 1) / jcp.ow;
    const int_t oh_begin = first_oh;
    const int_t oh_end = last_oh + 1;
    const int_t first_ow = ss % jcp.ow;
    const int_t last_ow = (ss + sb - 1) % jcp.ow;
    // TODO: optimize threading if jcp.ic*jcp.kh*jcp.kw*oh_range is small
    // comparing to number of threads
    const int oh_range = oh_end - oh_begin;
    parallel_nd(cb, jcp.kh, jcp.kw, oh_range,
            [&](int_t ic, int_t const kh, int_t const kw, int_t const ohr) {
                const int_t oh = ohr + oh_begin;
                const int_t ih = oh * sh - tp + kh * dh;
                const int_t ow_start = (oh == first_oh) ? first_ow : 0;
                const int_t jcp_iw = jcp.iw;
                const int_t ow_end
                        = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                data_type_t *__restrict col_oh = col + ic * col_step
                        + (kh * jcp.kw + kw) * sb + oh * jcp.ow - ss;
                const data_type_t *__restrict im_
                        = im + (ic + cs) * im_step;
                if (ih < 0 || ih >= jcp.ih)
                    for (int_t ow = ow_start; ow < ow_end; ow++)
                        col_oh[ow] = (data_type_t)0;
                else UNROLL(8)
                    for (int_t ow = ow_start; ow < ow_end; ow++) {
                        const int_t iw = ow * sw - lp + kw * dw;
                        col_oh[ow] = (iw < 0 || iw >= jcp.iw
                                ? data_type_t{0}: im_[iw]);
                    }
            });
}
}//anon::

/* col[ic][kh][kw][oh][ow] <-- im2col(im[ic][ih][iw]) */
template <typename data_type_t>
void im2col(const conv_gemm_conf_t &jcp, const data_type_t *__restrict im,
        data_type_t *__restrict col, int ss, int sb, int cs, int cb) {
    // ss,sb ~ spatial start+step    cs,cb ~ ic start+step
    // inclusive spatial tile covers [ss,ss+sb-1]
    //      --> 2D tile [first_oh,last_oh] x [first_ow,last_ow]
    //      --> loop    [oh_begin,oh_end)  x [ow_begin,ow_end)
    // For loop order: ic, kh,kw, oh, ow(boundary-->0, interior from col_
    // mappings:        ih = oh*sh + (kh*dh-tp)
    //                  iw = ow, constrained to [lp-kw*dw, jcp.iw+lp-kw*dw)
    // Given kh, hoisting problem is:
    //          For what subrange of [oh_begin,oh_end) does linear fn
    //          ih=sh*oh+(kh*dh-tp) like within [0,jcp.ih) ?
    //          A:  [ohb,ohe)
    //          For [oh_begin,ohb) and [ohe,ohe_end), col_[ow] is set to zero
    //          For [ohb,ohe) :
    //                  For what subrange of [ow_begin,ow_end) does linear fn
    //                  iw = 1*ow+0 lie within [0+lp-kw*dw, jcp.iw+lp-kw*dw)?
    //                  --> equiv. iw' = ow+jp-kw*dw lie within [0,jcp.iw)?
    //                  A: [owb,owe)  For this subrange, set col_[ow]=im_[iw=ow]
    //
    //
    if (jcp.outer_threading) {
        const size_t im_step = jcp.is;
        const size_t col_step = jcp.ks * sb;
        const int_t dh = 1 + jcp.dilate_h;
        const int_t dw = 1 + jcp.dilate_w;
        const int_t sh = jcp.stride_h;
        const int_t sw = jcp.stride_w;
        const int_t tp = jcp.t_pad;
        const int_t lp = jcp.l_pad;
        const int_t first_oh = ss / jcp.ow;
        const int_t last_oh = (ss + sb - 1) / jcp.ow;
        const int_t oh_begin = first_oh;
        const int_t oh_end = last_oh + 1;
        const int_t first_ow = ss % jcp.ow;
        const int_t last_ow = (ss + sb - 1) % jcp.ow;

        if (sw == 1) {
            // Generated code is more optimized for stride_w == 1
            // because innermost loop is by width
            FOR(ic,cb) {
                const data_type_t *__restrict im_ic = im + (ic + cs) * im_step;
                FOR(kh,jcp.kh) {
                    FOR(kw,jcp.kw) {
                        data_type_t *__restrict col_k
                                = col + ic * col_step + (kh * jcp.kw + kw) * sb;
                        for (int_t oh = oh_begin; oh < oh_end; ++oh) {
                            const int_t ih = oh * sh - tp + kh * dh;
                            const data_type_t *__restrict im_
                                    = im_ic + ih * jcp.iw - lp + kw * dw;
                            const int_t ow_begin
                                    = (oh == first_oh) ? first_ow : 0;
                            const int_t ow_end
                                    = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                            data_type_t *__restrict col_
                                    = col_k + oh * jcp.ow - ss;
                            if (ih < 0 || ih >= jcp.ih)
                                for (int_t ow = ow_begin; ow < ow_end; ow++)
                                    col_[ow] = (data_type_t)0;
                            else {
#if 0
                                UNROLL(8)
                                for (int_t ow = ow_begin; ow < ow_end; ++ow) {
                                    const int_t iw = ow;
                                    col_[ow] = (iw < lp - kw * dw
                                            || iw >= jcp.iw + lp - kw * dw
                                            ? data_type_t{0}
                                            //: im_ic[ih*jcp.iw + ow*1 - kw*dw - lp];
                                            : im_[iw]
                                            // OK (could do same for next else-block)
                                            );
                                }
#else // nc++ full hoist, tiple loop split UNTESTED
                            { // iw = a + ow*b with a = - lp + kw * dw and b = sw = 1
                                const int iw_shift = kw * dw - lp;
                                int owlo, owhi;
                                //         sub_range  original__range  a  + ow * b  iw_range
                                hoist_ApiB(owlo,owhi, ow_begin,ow_end, iw_shift,1, 0,jcp.iw);
                                // triple loop-split needs owlo,owhi fully "in-range":
                                if (owlo > ow_end  ) owlo = ow_end;
                                if (owhi < ow_begin) owhi = ow_begin;
                                // triple loop-split (each with no inner conditionals
                                for (int ow = ow_begin; ow < owlo; ++ow) {
                                    col_[ow] = data_type_t{0};
                                }
                                for (int ow = owlo; ow < owhi; ++ow) {
                                    //const auto im_idx = ih*jcp.iw + ow*sw + iw_shift;
                                    // im_ has ih*jcp.iw + kw*dw-lp included
                                    col_[ow] = im_[ow];
                                }
                                for (int ow = owhi; ow < ow_end; ++ow) {
                                    col_[ow] = data_type_t{0};
                                }
                            }
#endif
                            }
                        }
                    }
                }
            }
        } else {
            FOR(ic,cb) {
                const data_type_t *__restrict im_ = im + (ic + cs) * im_step;
                FOR(kh,jcp.kh) {
                    FOR(kw,jcp.kw) {
                        data_type_t *__restrict col_k
                                = col + ic * col_step + (kh * jcp.kw + kw) * sb;
#if 1
                        for (int_t oh = oh_begin; oh < oh_end; oh++) {
                            const int_t ih = oh * sh - tp + kh * dh;
                            const int_t ow_begin
                                    = (oh == first_oh) ? first_ow : 0;
                            const int_t ow_end
                                    = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                            data_type_t *__restrict col_oh
                                    = col_k + oh * jcp.ow - ss;
                            if (ih < 0 || ih >= jcp.ih)
                                for (int_t ow = ow_begin; ow < ow_end; ow++)
                                    col_oh[ow] = (data_type_t)0;
                            else //UNROLL(8)
#if 0
                                for (int_t ow = ow_begin; ow < ow_end; ow++) {
                                    const int_t iw = ow * sw - lp + kw * dw;
                                    col_oh[ow] = (iw < 0 || iw >= jcp.iw
                                            ? data_type_t{0}
                                            : im_[ih * jcp.iw + iw]);
                                }
#else // nc++ full hoist, triple loop split UNTESTED
                            { // iw = a + ow*b with a = - lp + kw * dw and b = sw
                                const int iw_shift = kw * dw - lp;
                                int owlo, owhi;
                                //         sub_range  original__range  a  + ow * b  iw_range
                                hoist_ApiB(owlo,owhi, ow_begin,ow_end, iw_shift,sw, 0,jcp.iw);
                                // triple loop-split needs owlo,owhi fully "in-range":
                                if (owlo > ow_end  ) owlo = ow_end;
                                if (owhi < ow_begin) owhi = ow_begin;
                                // triple loop-split (each with no inner conditionals
                                for (int ow = ow_begin; ow < owlo; ++ow) {
                                    col_oh[ow] = data_type_t{0};
                                }
                                for (int ow = owlo; ow < owhi; ++ow) {
                                    //const auto im_idx = ih*jcp.iw + ow*sw + iw_shift;
                                    col_oh[ow] = im_[ih * jcp.iw + ow * sw + iw_shift];
                                }
                                for (int ow = owhi; ow < ow_end; ++ow) {
                                    col_oh[ow] = data_type_t{0};
                                }
                            }
#endif
                        }
#else // hoist at least ih range-check
                        int ohlo, ohhi; // ih = -tp+kh*dh + ih * sh
                        hoist_ApiB(ohlo,ohhi, oh_begin,oh_end, -tp+kh*dh, sh, 0,jcp.ih);
                        // to triple-split the loop, also enforce
                        if (ohlo > oh_end) ohlo = oh_end;
                        if (ohhi < oh_begin) ohhi = oh_begin;
                            const int_t ih = oh * sh - tp + kh * dh;
                            data_type_t *__restrict col_oh
                                    = col_k + oh * jcp.ow - ss;
                        for (int oh = oh_begin; oh < ohlo; ++oh) {
                            const int_t ow_begin
                                    = (oh == first_oh) ? first_ow : 0;
                            const int_t ow_end
                                    = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                            for (int_t ow = ow_begin; ow < ow_end; ow++)
                                col_oh[ow] = (data_type_t)0;
                        }
                        for (int oh = ohlo; oh < ohhi; ++oh) {
                            const int_t ow_begin
                                    = (oh == first_oh) ? first_ow : 0;
                            const int_t ow_end
                                    = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
#if 1 // orig
                            for (int_t ow = ow_begin; ow < ow_end; ow++) {
                                const int_t iw = ow * sw - lp + kw * dw;
                                col_oh[ow] = (iw < 0 || iw >= jcp.iw
                                        ? data_type_t{0}
                                        : im_[ih * jcp.iw + iw]);
                            }
#else // hoist iw condition
#endif
                        }
                        for (int oh = ohhi; oh < oh_end; ++oh) {
                            const int_t ow_begin
                                    = (oh == first_oh) ? first_ow : 0;
                            const int_t ow_end
                                    = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                            for (int_t ow = ow_begin; ow < ow_end; ow++)
                                col_oh[ow] = (data_type_t)0;
                        }

#endif
                    }
                }
            }
        }
    } else {
#if 0 // CRASH! WRONG? debug other block first!
        // older nc++ had trouble with many OpenMP clauses in single function
        if (jcp.stride_w == 1)
            // nc++-3.0.25, however, has segfault in this version!
            im2col_inner_thr_sw1(jcp, im, col, ss, sb, cs, cb);
        else
            im2col_inner_thr(jcp, im, col, ss, sb, cs, cb);
#else // still crash (orig) ex. --conv g1ic3ih224oc64oh112kh7sh2ph3
        const size_t im_step = jcp.is;
        const size_t col_step = jcp.ks * sb;
        const int dh = 1 + jcp.dilate_h;
        const int dw = 1 + jcp.dilate_w;
        const int sh = jcp.stride_h;
        const int sw = jcp.stride_w;
        const int tp = jcp.t_pad;
        const int lp = jcp.l_pad;
        const int first_oh = ss / jcp.ow;
        const int last_oh = (ss + sb - 1) / jcp.ow;
        const int oh_begin = first_oh;
        const int oh_end = last_oh + 1;
        const int first_ow = ss % jcp.ow;
        const int last_ow = (ss + sb - 1) % jcp.ow;

        // TODO: optimize threading if jcp.ic*jcp.kh*jcp.kw*oh_range is small
        // comparing to number of threads
        const int oh_range = oh_end - oh_begin;
        // Generated code is more optimized for stride_w == 1
        // because innermost loop is by width
        if (sw == 1)
            parallel_nd(cb, jcp.kh, jcp.kw, oh_range,
                    [&](int ic, int kh, int kw, int ohr) {
                        const int oh = ohr + oh_begin;
                        const int ih = oh * sh - tp + kh * dh;
                        const int ow_start = (oh == first_oh) ? first_ow : 0;
                        const int ow_end
                                = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                        data_type_t *__restrict col_oh = col + ic * col_step
                                + (kh * jcp.kw + kw) * sb + oh * jcp.ow - ss;
                        const data_type_t *__restrict im_
                                = im + (ic + cs) * im_step + ih * jcp.iw;
                        const int iw_shift = kw * dw - lp;
                        if (ih < 0 || ih >= jcp.ih)
                            for (int ow = ow_start; ow < ow_end; ow++)
                                col_oh[ow] = (data_type_t)0;
                        else
#if 0 // nc++ NOVEC workaround:
                            NOVEC for (int ow = ow_start; ow < ow_end; ow++) {
                                const int iw = ow + iw_shift;
                                if (iw < 0 || iw >= jcp.iw)
                                    col_oh[ow] = (data_type_t)0;
                                else
                                    col_oh[ow] = im_[iw];
                            }
#elif 0 // UNTESTED nc++ hoisting, but only to simplify inner loop conditional
                        {
                            // This changed segfault to pass, at least once.
                            // iw = a + ow*b with a=iw_shift, b=1
                            int owlo, owhi;
                            hoist_ApiB(owlo,owhi, ow_start,ow_end, iw_shift,1, ,jcp.iw);
                            for (int ow = ow_start; ow < ow_end; ++ow) {
                                // condition directly on loop variable instead of linear fn
                                col_oh[ow] = (ow >= owlo && ow <= owhi
                                        ? im_[ow*1+iw_shift]
                                        : data_type_t{0});
                            }
                        }
#elif 1 // hoist with triple-loop split "full solution"
                        { // iw = a + ow*b with a = - lp + kw * dw and b = sw = 1
                            int owlo, owhi;
                            //         sub_range  original__range  a  + ow * b  iw_range
                            hoist_ApiB(owlo,owhi, ow_start,ow_end, iw_shift,1, 0,jcp.iw);
                            // triple loop-split needs owlo,owhi fully "in-range":
                            if (owlo > ow_end) owlo = ow_end;
                            if (owhi < ow_start) owhi = ow_start;
                            // triple loop-split (each with no inner conditionals
                            for (int ow = ow_start; ow < owlo; ++ow) {
                                col_oh[ow] = data_type_t{0};
                            }
                            for (int ow = owlo; ow < owhi; ++ow) {
                                //const auto im_idx = ih*jcp.iw + ow*sw + iw_shift;
                                col_oh[ow] = im_[ow + iw_shift];
                            }
                            for (int ow = owhi; ow < ow_end; ++ow) {
                                col_oh[ow] = data_type_t{0};
                            }
                        }
#endif
                    });
        else
            parallel_nd(cb, jcp.kh, jcp.kw, oh_range,
                    [&](int ic, int kh, int kw, int ohr) {
                        const int oh = ohr + oh_begin;
                        const int ih = oh * sh - tp + kh * dh;
                        const int ow_start = (oh == first_oh) ? first_ow : 0;
                        const int ow_end
                                = (oh == last_oh) ? (last_ow + 1) : jcp.ow;
                        data_type_t *__restrict col_oh = col + ic * col_step
                                + (kh * jcp.kw + kw) * sb + oh * jcp.ow - ss;
                        const data_type_t *__restrict im_
                                = im + (ic + cs) * im_step; // + ih * jcp.iw !!
                        // + const int iw_shift = kw * dw - lp;
                        if (ih < 0 || ih >= jcp.ih)
                            for (int ow = ow_start; ow < ow_end; ow++)
                                col_oh[ow] = (data_type_t)0;
                        else
#if 0 // nc++ NOVEC workaround
                            NOVEC // nc++ workaround;
                            for (int ow = ow_start; ow < ow_end; ow++) {
                                const int iw = ow * sw - lp + kw * dw;
                                if (iw < 0 || iw >= jcp.iw)
                                    col_oh[ow] = (data_type_t)0;
                                else {
                                    const ptrdiff_t im_idx = ih * jcp.iw + iw;
                                    col_oh[ow] = im_[im_idx];
                                }
                            }
#elif 0 // nc++ simplify the inner loop conditional to directly use loop variable
                        // still segfaults without NOVEC
                        { // iw = a + ow*b with a = - lp + kw * dw and b = sw > 0
                            int const iw_shift = -lp + kw * dw;
                            int owlo, owhi;
                            hoist_ApiB(owlo,owhi, ow_start,ow_end, iw_shift,sw, 0,jcp.iw);
                            NOVEC for (int ow = ow_start; ow < ow_end; ++ow) {
                                const bool cond = (ow >= owlo && ow < owhi);
                                const auto im_idx = ih*jcp.iw + ow*sw + iw_shift;
                                col_oh[ow] = (cond? im_[im_idx]: data_type_t{0});
                            }
                        }
#elif 1 // nc++ full hoist (triple-loop split, NO mask ops inside loops)
                        // successfully negotiates one segfault run: --conv g1ic3ih224oc64oh112kh7sh2ph3
                        { // iw = a + ow*b with a = - lp + kw * dw and b = sw > 0
                            int const iw_shift = -lp + kw * dw;
                            int owlo, owhi;
                            //         sub_range  original__range  a  + ow * b  iw_range
                            hoist_ApiB(owlo,owhi, ow_start,ow_end, iw_shift,sw, 0,jcp.iw);
                            // triple loop-split needs owlo,owhi fully "in-range":
                            if (owlo > ow_end) owlo = ow_end;
                            if (owhi < ow_start) owhi = ow_start;
                            // triple loop-split (each with no inner conditionals
                            for (int ow = ow_start; ow < owlo; ++ow) {
                                col_oh[ow] = data_type_t{0};
                            }
                            for (int ow = owlo; ow < owhi; ++ow) {
                                const auto im_idx = ih*jcp.iw + ow*sw + iw_shift;
                                col_oh[ow] = im_[im_idx];
                            }
                            for (int ow = owhi; ow < ow_end; ++ow) {
                                col_oh[ow] = data_type_t{0};
                            }
                        }
#endif
                    });
#endif
    }
}

template void im2col(const conv_gemm_conf_t &jcp, const float *__restrict im,
        float *__restrict col, int hs, int hb, int ws, int wb);

template void im2col(const conv_gemm_conf_t &jcp,
        const bfloat16_t *__restrict im, bfloat16_t *__restrict col, int hs,
        int hb, int ws, int wb);

/* col[kh][kw][ic][oh][ow] <-- im2col_u8(im[ih][iw][ic]) */
// NOTE: OneDNN master collapses _u8 and _s32 versions of this
// into im2col_dt<orig_im_dt,orig_col_dt>.
//
// Note that this impl already does the [0,oh_start,oh_end,jcp.oh) loop partition
// of hoisting conditionals.
template <typename T>
void im2col_u8(const conv_gemm_conf_t &jcp, const T *__restrict im,
        T *__restrict imtr, uint8_t *__restrict col, int hs, int hb, int ws,
        int wb) {
    uint8_t shift = jcp.signed_input ? 128 : 0;
    const int dh = 1 + jcp.dilate_h;
    const int dw = 1 + jcp.dilate_w;
    const int sh = jcp.stride_h;
    const int sw = jcp.stride_w;
    const int im_iw_stride = jcp.ic * jcp.ngroups;
    const int im_ih_stride = jcp.iw * im_iw_stride;
    const int tp = jcp.t_pad;
    const int lp = jcp.l_pad;

    if (jcp.outer_threading && sh == 1 && sw == 1 && dh == 1 && dw == 1) {
        /* im[ih][iw][ic] --> imtr[ic][ih][iw] --> col[kh][kw][ic][oh][ow] */
        const int hp = hs - tp;
        const int wp = ws - lp;
        const int ih_start = saturate(0, jcp.ih, hp);
        const int ih_end = saturate(0, jcp.ih, hp + hb + jcp.kh);
        const int iw_start = saturate(0, jcp.iw, wp);
        const int iw_end = saturate(0, jcp.iw, wp + wb + jcp.kw);

        const int ihb = ih_end - ih_start;
        const int iwb = iw_end - iw_start;

        const int imtr_ic_stride = ihb * iwb;
        const ptrdiff_t imtr_idx_shift = ih_start * iwb + iw_start;
        for (int ic = 0; ic < jcp.ic; ic++) {
            const ptrdiff_t imtr_idx_ic = ic * imtr_ic_stride - imtr_idx_shift;
            for (int ih = ih_start; ih < ih_end; ih++) {
                const ptrdiff_t im_idx_ih = ic + ih * im_ih_stride;
                const ptrdiff_t imtr_idx_ih = imtr_idx_ic + ih * iwb;
                for (int iw = iw_start; iw < iw_end; iw++)
                    imtr[imtr_idx_ih + iw] = im[im_idx_ih + iw * im_iw_stride];
            }
        }

        const int col_ic_str = hb * wb;
        const int col_kw_stride = jcp.ic * col_ic_str;
        const int col_kh_stride = jcp.kw * col_kw_stride;

        const int oh_init = ih_start - hp;
        const int ow_init = iw_start - wp;
        for (int kh = 0; kh < jcp.kh; kh++) {
            const ptrdiff_t col_idx_kh = kh * col_kh_stride;
            const int oh_kh = oh_init - kh;
            const int oh_start = saturate(0, hb, oh_kh);
            const int oh_end = saturate(0, hb, oh_kh + ihb);
            for (int kw = 0; kw < jcp.kw; kw++) {
                const ptrdiff_t col_idx_kw
                        = col_idx_kh + kw * jcp.ic * col_ic_str;
                const int ow_kw = ow_init - kw;
                const int imtr_shift = oh_kh * iwb + ow_kw;
                const int ow_start = saturate(0, wb, ow_kw);
                const int ow_end = saturate(0, wb, ow_kw + iwb);
                for (int ic = 0; ic < jcp.ic; ic++) {
                    const ptrdiff_t col_idx_ic = col_idx_kw + ic * col_ic_str;
                    const int imtr_idx_ic = ic * imtr_ic_stride - imtr_shift;
                    for (int oh = 0; oh < oh_start; oh++) {
                        const ptrdiff_t col_idx_oh = col_idx_ic + oh * wb;
                        for (int ow = 0; ow < wb; ++ow)
                            col[col_idx_oh + ow] = shift;
                    }
                    for (int oh = oh_start; oh < oh_end; oh++) {
                        const ptrdiff_t col_idx_oh = col_idx_ic + oh * wb;
                        const ptrdiff_t imtr_idx_oh = imtr_idx_ic + oh * iwb;
                        for (int ow = 0; ow < ow_start; ++ow)
                            col[col_idx_oh + ow] = shift;
                        for (int ow = ow_start; ow < ow_end; ++ow)
                            col[col_idx_oh + ow]
                                    = imtr[imtr_idx_oh + ow] + shift;
                        for (int ow = ow_end; ow < wb; ++ow)
                            col[col_idx_oh + ow] = shift;
                    }
                    for (int oh = oh_end; oh < hb; oh++) {
                        const ptrdiff_t col_idx_oh = col_idx_ic + oh * wb;
                        for (int ow = 0; ow < wb; ++ow)
                            col[col_idx_oh + ow] = shift;
                    }
                }
            }
        }
    } else {
        parallel_nd(jcp.kh, jcp.kw, jcp.ic, hb,
                [&](int kh, int kw, int ic, int oh) {
                    const int hp = tp - kh * dh;
                    const int ih = (oh + hs) * sh - hp;
                    const ptrdiff_t col_idx_base
                            = (((kh * jcp.kw + kw) * jcp.ic + ic) * hb + oh)
                            * wb;
                    if (ih < 0 || ih >= jcp.ih)
                        for (int ow = 0; ow < wb; ow++)
                            col[col_idx_base + ow] = shift;
                    else {
                        const int wp = lp - kw * dw;
                        const int ow_start
                                = saturate(0, wb, div_up(wp, sw) - ws);
                        const int ow_end
                                = saturate(0, wb, div_up(jcp.iw + wp, sw) - ws);
                        for (int ow = 0; ow < ow_start; ow++)
                            col[col_idx_base + ow] = shift;
                        const int iw_base = ws * sw - wp;
                        const ptrdiff_t im_idx_base = ih * im_ih_stride + ic;
                        for (int ow = ow_start; ow < ow_end; ow++) {
                            const int iw = iw_base + ow * sw;
                            const ptrdiff_t im_idx
                                    = im_idx_base + iw * im_iw_stride;
                            col[col_idx_base + ow] = im[im_idx] + shift;
                        }
                        for (int ow = ow_end; ow < wb; ow++)
                            col[col_idx_base + ow] = shift;
                    }
                });
    }
}

template void im2col_u8<int8_t>(const conv_gemm_conf_t &jcp,
        const int8_t *__restrict im, int8_t *__restrict imtr,
        uint8_t *__restrict col, int hs, int hb, int ws, int wb);
template void im2col_u8<uint8_t>(const conv_gemm_conf_t &jcp,
        const uint8_t *__restrict im, uint8_t *__restrict imtr,
        uint8_t *__restrict col, int hs, int hb, int ws, int wb);

/* im[id][ih][iw][ic] <-- col2im_s32_3d(col[od][oh][ow][kd][kh][kw][ic]) */
void col2im_s32(const conv_gemm_conf_t &jcp, const int32_t *__restrict col,
        int32_t *__restrict im) {
    parallel(0, [&](const int ithr, const int nthr) {
        int d_nthr = nstl::min(jcp.id, nthr);
        int h_nthr = nstl::min(jcp.ih, nthr / d_nthr);
        int w_nthr = nstl::min(jcp.iw, nthr / (d_nthr * h_nthr));
        int d_ithr = 1, d_s = 0, d_e = 0, h_ithr = 1, h_s = 0, h_e = 0,
            w_ithr = 1, w_s = 0, w_e = 0;
        if (ithr < d_nthr * h_nthr * w_nthr) {
            d_ithr = ithr / (h_nthr * w_nthr);
            h_ithr = (ithr % (h_nthr * w_nthr)) / w_nthr;
            w_ithr = (ithr % (h_nthr * w_nthr)) % w_nthr;
            balance211(jcp.id, d_nthr, d_ithr, d_s, d_e);
            balance211(jcp.ih, h_nthr, h_ithr, h_s, h_e);
            balance211(jcp.iw, w_nthr, w_ithr, w_s, w_e);
        } else {
            d_nthr = h_ithr = w_ithr = -ithr;
            d_s = d_e = h_s = h_e = w_s = w_e = -1;
        }

        for (int_t id = d_s; id < d_e; ++id) {
            for (int_t ih = h_s; ih < h_e; ++ih) {
                for (int_t iw = w_s; iw < w_e; ++iw) {
                    PRAGMA_OMP_SIMD() PragmaQuote(_NEC shortloop_reduction)
                    FOR(ic,jcp.ic) {
                        im[((id * jcp.ih + ih) * jcp.iw + iw) * jcp.ic + ic]
                                = 0;
                    }
                }
            }
        }

        // TODO: reduce region: [0.. oh] --> [h_s * sh .. h_e * sh]
        FOR(od,jcp.od) {
            FOR(oh,jcp.oh) {
                FOR(ow,jcp.ow) {
                    FOR(kd,jcp.kd) {
                        const int id = od * jcp.stride_d - jcp.f_pad
                                + kd * (1 + jcp.dilate_d);
                        if (id < d_s || id >= d_e) continue;

                        FOR(kh,jcp.kh) {
                            const int ih = oh * jcp.stride_h - jcp.t_pad
                                    + kh * (1 + jcp.dilate_h);
                            if (ih < h_s || ih >= h_e) continue;

                            FOR(kw,jcp.kw) {
                                const int iw = ow * jcp.stride_w - jcp.l_pad
                                        + kw * (1 + jcp.dilate_w);
                                if (iw < w_s || iw >= w_e) continue;

                                const size_t col_idx
                                        = (((((od * jcp.oh + oh) * jcp.ow + ow)
                                                            * jcp.kd
                                                    + kd) * jcp.kh
                                                   + kh) * jcp.kw
                                                  + kw)
                                        * jcp.ic;
                                const size_t im_idx
                                        = ((id * jcp.ih + ih) * jcp.iw + iw)
                                        * jcp.ic;
                                PRAGMA_OMP_SIMD() IVDEP() PragmaQuote(_NEC shortloop_reduction)//;
                                FOR(ic,jcp.ic) {
                                    im[im_idx + ic] += col[col_idx + ic];
                                }
                            }
                        }
                    }
                }
            }
        }
    });
}

void col2im_3d(
        const conv_gemm_conf_t &jcp, const float *col, float *im, int od) {
    parallel_nd(jcp.ic, [&](int_t const ic) {
        const float *__restrict col_ = col + (size_t)ic * jcp.ks * jcp.os;
        float *__restrict im_ic = im + (size_t)ic * jcp.ih * jcp.iw * jcp.id;

#if 0 // Workaround for nc++-3.0.25 : NOVEC for **all** loops
        int_t id = od * jcp.stride_d - jcp.f_pad;
        NOVEC FOR(kd,jcp.kd) {
            if (id < 0 || id >= jcp.id) {
                col_ += jcp.kh * jcp.kw * jcp.os;
                id += (1 + jcp.dilate_d);
                continue;
            }

            float *__restrict im_ = im_ic + id * jcp.ih * jcp.iw;

            NOVEC FOR(oh,jcp.oh)
            NOVEC FOR(kh,jcp.kh) {
                const int_t ih = oh * jcp.stride_h - jcp.t_pad
                        + kh * (1 + jcp.dilate_h);
                if (ih < 0 || ih >= jcp.ih) continue;

                NOVEC FOR(ow,jcp.ow)
                NOVEC FOR(kw,jcp.kw) {
                    const int_t iw = ow * jcp.stride_w - jcp.l_pad
                            + kw * (1 + jcp.dilate_w);
                    if (iw < 0 || iw >= jcp.iw) continue;

                    const size_t col_idx
                            = ((kh * jcp.kw + kw) * jcp.oh + oh) * jcp.ow + ow;
                    const size_t im_idx = ih * jcp.iw + iw;
                    im_[im_idx] += col_[col_idx];
                }
            }

            col_ += jcp.kh * jcp.kw * jcp.os;
            id += (1 + jcp.dilate_d);
        }
#elif 1 // Workaround for nc++-3.0.25 : NOVEC for **all** loops
        int_t id = od * jcp.stride_d - jcp.f_pad;
        NOVEC FOR(kd,jcp.kd) {
            if (id < 0 || id >= jcp.id) {
                col_ += jcp.kh * jcp.kw * jcp.os;
                id += (1 + jcp.dilate_d);
                continue;
            }

            float *__restrict im_ = im_ic + id * jcp.ih * jcp.iw;

            NOVEC FOR(kh,jcp.kh) {
                //NOVEC FOR(oh,jcp.oh)
                int oh_beg, oh_end; // s.t. ih lies in [0,jcp.ih)
                compute_oh_bounds(jcp, oh_beg, oh_end, kh);
                for(int oh=oh_beg; oh<oh_end; ++oh) // with ih guaranteed in-bounds
                {
                    const int_t ih = oh * jcp.stride_h - jcp.t_pad
                            + kh * (1 + jcp.dilate_h);
                    //if (ih < 0 || ih >= jcp.ih) continue;
                    //assert (ih >= 0 || ih < jcp.ih)

                    FOR(kw,jcp.kw) {
                        //NOVEC FOR(ow,jcp.ow)
                        int ow_beg, ow_end; // s.t. iw lies in [0,jcp.iw)
                        compute_ow_bounds(jcp, ow_beg, ow_end, kw);
                        for(int ow=ow_beg; ow<ow_end; ++ow)
                        {
                            const int_t iw = ow * jcp.stride_w - jcp.l_pad
                                    + kw * (1 + jcp.dilate_w);
                            //if (iw < 0 || iw >= jcp.iw) continue;
                            //assert (iw >= 0 && iw < jcp.iw);

                            const size_t col_idx
                                    = ((kh * jcp.kw + kw) * jcp.oh + oh) * jcp.ow + ow;
                            const size_t im_idx = ih * jcp.iw + iw;
                            im_[im_idx] += col_[col_idx];
                        }
                    }
                }
            }

            col_ += jcp.kh * jcp.kw * jcp.os;
            id += (1 + jcp.dilate_d);
        }
#endif
    });
}

void col2im(const conv_gemm_conf_t &jcp, const float *col, float *im) {
    const size_t col_step = jcp.ks * jcp.os;
    const size_t im_step = jcp.ih * jcp.iw;
#if defined(__ve)
    typedef int64_t int_t;
#else
    typedef int int_t;
#endif
    const int_t iS = jcp.ih * jcp.iw;
    const int_t jcp_stride_h = jcp.stride_h;
    const int_t jcp_stride_w = jcp.stride_w;
    const int_t jcp_t_pad = jcp.t_pad;
    const int_t jcp_l_pad = jcp.l_pad;
    const int_t jcp_dilate_w = jcp.dilate_w;
    const int_t jcp_dilate_h = jcp.dilate_h;
    const int_t jcp_iw = jcp.iw;
    const int_t jcp_ih = jcp.ih;
    const int_t jcp_kh = jcp.kh;
    const int_t jcp_kw = jcp.kw;
    const int_t jcp_oh = jcp.oh;
    const int_t jcp_ow = jcp.ow;
    parallel_nd(jcp.ic, [&](int_t const ic) {
        float *__restrict im_ = im + ic * im_step;
        const float *__restrict col_ = col + ic * col_step;
        PRAGMA_OMP_SIMD()
        FOR(is,iS) im_[is] = 0.f;

        FOR(kh,jcp.kh) FOR(oh,jcp_oh) {
            const int_t ih
                    = oh * jcp_stride_h - jcp_t_pad + kh * (1 + jcp_dilate_h);
            if (ih < 0 || ih >= jcp_ih) continue;

            FOR(kw,jcp_kw)
            UNROLL(8) FOR(ow,jcp_ow) { // IVDEP() on this loop --> BWD_D segfault
                const int_t iw = ow * jcp_stride_w - jcp_l_pad
                        + kw * (1 + jcp_dilate_w);
                if (iw >= 0 && iw < jcp.iw) {
                    const size_t col_idx
                            = ((kh * jcp.kw + kw) * jcp.oh + oh) * jcp.ow + ow;
                    const size_t im_idx = ih * jcp_iw + iw;
                    im_[im_idx] += col_[col_idx];
                }
            }
        }
    });
}

status_t init_conf(conv_gemm_conf_t &jcp,
        memory_tracking::registrar_t &scratchpad, const convolution_desc_t &cd,
        const memory_desc_wrapper &src_d, const memory_desc_wrapper &weights_d,
        const memory_desc_wrapper &dst_d, int max_threads) {
    const bool with_groups = weights_d.ndims() == src_d.ndims() + 1;
    const int ndims = src_d.ndims();
    const int is_1d = ndims == 3;
    const int is_3d = ndims == 5;

    jcp.prop_kind = cd.prop_kind;

    jcp.ngroups = with_groups ? weights_d.dims()[0] : 1;
    jcp.mb = src_d.dims()[0];

    jcp.oc = dst_d.dims()[1] / jcp.ngroups;
    jcp.ic = src_d.dims()[1] / jcp.ngroups;
    jcp.id = is_3d ? src_d.dims()[2] : 1;
    jcp.ih = is_1d ? 1 : src_d.dims()[ndims - 2];
    jcp.iw = src_d.dims()[ndims - 1];
    jcp.od = is_3d ? dst_d.dims()[2] : 1;
    jcp.oh = is_1d ? 1 : dst_d.dims()[ndims - 2];
    jcp.ow = dst_d.dims()[ndims - 1];

    jcp.kd = is_3d ? weights_d.dims()[with_groups + 2] : 1;
    jcp.kh = is_1d ? 1 : weights_d.dims()[with_groups + ndims - 2];
    jcp.kw = weights_d.dims()[with_groups + ndims - 1];

    jcp.f_pad = is_3d ? cd.padding[0][0] : 0;
    jcp.t_pad = is_1d ? 0 : cd.padding[0][ndims - 4];
    jcp.l_pad = cd.padding[0][ndims - 3];

    jcp.stride_d = is_3d ? cd.strides[0] : 1;
    jcp.stride_h = is_1d ? 1 : cd.strides[ndims - 4];
    jcp.stride_w = cd.strides[ndims - 3];

    jcp.dilate_d = is_3d ? cd.dilates[0] : 0;
    jcp.dilate_h = is_1d ? 0 : cd.dilates[ndims - 4];
    jcp.dilate_w = cd.dilates[ndims - 3];

    jcp.with_bias = cd.bias_desc.format_kind != format_kind::undef
            || cd.diff_bias_desc.format_kind != format_kind::undef;

    jcp.is = jcp.ih * jcp.iw;
    jcp.os = jcp.oh * jcp.ow;
    jcp.ks = jcp.kh * jcp.kw * jcp.kd;

    jcp.signed_input = src_d.data_type() == data_type::s8;

    jcp.outer_threading = false;

    const bool is_bwd_d = jcp.prop_kind == backward_data;
    const bool is_bwd_w = jcp.prop_kind == backward_weights;
    const bool is_fwd = !is_bwd_d && !is_bwd_w;

    bool is_int8_conv = (is_fwd ? utils::one_of(src_d.data_type(), s8, u8)
                                : utils::one_of(dst_d.data_type(), s8, u8))
            && weights_d.data_type() == s8;

    bool is_bf16_conv = false
            || (is_fwd
                    && utils::everyone_is(
                            bf16, src_d.data_type(), weights_d.data_type()))
            || (is_bwd_d
                    && utils::everyone_is(
                            bf16, dst_d.data_type(), weights_d.data_type()))
            || (is_bwd_w
                    && utils::everyone_is(
                            bf16, src_d.data_type(), dst_d.data_type()));
    if (is_bf16_conv && !platform::has_data_type_support(bf16))
        return status::unimplemented;

    bool is_bf16_to_bf16_conv = is_bf16_conv
            && ((is_fwd && bf16 == dst_d.data_type())
                    || (is_bwd_d && bf16 == src_d.data_type())
                    || (is_bwd_w && bf16 == weights_d.data_type()));

    const int vlen = std::max(platform::get_vector_register_size(), 4);
    const int data_size = (is_int8_conv ? 1 : (is_bf16_conv ? 2 : 4));
    const int simd_w = vlen / data_size;

    jcp.os_block = jcp.os;
    jcp.oc_block = jcp.oc;
    jcp.ic_block = jcp.ic;
    jcp.loop_order = gemm_loop_rlb;
    jcp.nthr_oc = 1;

    jcp.oh_block = is_fwd ? jcp.oh : jcp.ih;
    jcp.ow_block = is_fwd ? jcp.ow : jcp.iw;

    using namespace memory_tracking::names;
    bool is_depthwise = jcp.ic == 1 && jcp.oc == 1 && jcp.ngroups != 1;

    // TODO: maybe mitigate blocking restriction
    const int L2 = platform::get_per_core_cache_size(2) / data_size;
    const int gemm_thrld = 64 * 1024;

    if (is_int8_conv) {
        if (is_fwd) {
            jcp.im2col_sz
                    = !everyone_is(true, jcp.ow == jcp.iw, jcp.oh == jcp.ih,
                              jcp.od == jcp.id, jcp.stride_w == 1,
                              jcp.stride_h == 1, jcp.stride_d == 1, jcp.ks == 1,
                              !jcp.signed_input)
                    ? (ptrdiff_t)jcp.ic * jcp.ks * jcp.os
                    : 0;

            const int wei_size = jcp.oc * jcp.ic * jcp.kh * jcp.kw;
            bool is_blocking_applicable = true && is_fwd && jcp.im2col_sz
                    && !is_3d && jcp.dilate_h == 0 && jcp.dilate_w == 0
                    && !is_depthwise && wei_size < L2 / 2;
            if (is_blocking_applicable) {
                // looking for oh and ow blocking
                int h_block {jcp.oh_block}, w_block {jcp.ow_block};
                const int ic = jcp.ic;
                const int oc = jcp.oc;
                const int iw = jcp.iw;
                const int ow = jcp.ow;
                const int oh = jcp.oh;
                const int os = oh * ow;

                // 1. cache requirement
                int row_size = ic * ow * jcp.ks + 2 * (ic * iw + oc * ow);
                // Heuristic rule: gemm needed a lot of memory for internal
                // usage
                row_size *= 5;
                // memory for accumulators
                row_size += oc * ow * sizeof(uint32_t);
                // memory for transposition
                row_size += ic * iw;

                h_block = nstl::max(1, nstl::min(oh, div_up(L2, row_size)));
                if (h_block == 1) {
                    int col_size = ic * jcp.ks + 2 * (ic + oc);
                    if (is_int8_conv) {
                        col_size *= 5;
                        col_size += oc * sizeof(uint32_t);
                        col_size += ic;
                    }
                    w_block = nstl::max(1, nstl::min(ow, div_up(L2, col_size)));
                }

                // 2. threading requirement
                if (h_block != oh) h_block = nstl::max(1, rnd_dn(h_block, 4));
                if (w_block != ow)
                    w_block = nstl::max(1, rnd_dn(w_block, simd_w));

                float thr_eff = 0.f;
                float thr_eff_treshold = 0.9f;
                if (w_block == ow) {
                    do {
                        int nb_h = div_up(oh, h_block);
                        size_t work = jcp.ngroups * jcp.mb * jcp.od * nb_h;
                        float disb = (float)oh / rnd_up(oh, h_block);
                        thr_eff = (float)work / rnd_up(work, max_threads);
                        thr_eff = (thr_eff + disb) / 2.f;
                        if (thr_eff >= thr_eff_treshold) break;
                        h_block = rnd_dn(h_block - 4, 4);
                    } while (h_block > 0);
                }
                if (thr_eff
                        < thr_eff_treshold) // we didn't find suitable h_block
                {
                    h_block = 1;
                    int nb_h = oh;
                    do {
                        int nb_w = div_up(ow, w_block);
                        size_t work_amount = jcp.ngroups * jcp.mb * nb_h * nb_w;
                        float disb = (float)ow / rnd_up(ow, w_block);
                        thr_eff = (float)work_amount
                                / rnd_up(work_amount, max_threads);
                        thr_eff = (thr_eff + disb) / 2.f;
                        if (thr_eff > thr_eff_treshold) break;
                        w_block = rnd_dn(w_block - simd_w, simd_w);
                    } while (w_block > 0);
                }
                h_block = nstl::max(1, h_block);
                w_block = nstl::max(1, w_block);
                const size_t inner_work
                        = div_up(os, simd_w) * div_up(oc, simd_w);
                const float inner_thr_eff
                        = (float)inner_work / rnd_up(inner_work, max_threads);
                if (thr_eff >= inner_thr_eff / 2 && h_block > 0
                        && w_block > 0) {
                    jcp.oh_block = h_block;
                    jcp.ow_block = w_block;
                    jcp.outer_threading = true;
                }
                // updating jcp.im2col_sz
                if (jcp.oh_block != 1) jcp.ow_block = ow;
                jcp.im2col_sz
                        = (ptrdiff_t)ic * jcp.ks * jcp.oh_block * jcp.ow_block;
            }
            //  For threading selection in bwd_d we do:
            //  1. Rough estimation of efficiency for inner and outer threading.
            //  2. Gemm size estimation in assumption that it does not work
            //  so effectively for small sizes.
            //  64K - this is heuristic gemm size per thread threshold.
            const int gemm_thrld = 64 * 1024;
            if (!jcp.outer_threading && !is_3d) {
                bool is_depthwise
                        = jcp.ic == 1 && jcp.oc == 1 && jcp.ngroups != 1;
                const size_t outer_work = jcp.ngroups * jcp.mb;
                const float outer_thr_eff
                        = (float)outer_work / rnd_up(outer_work, max_threads);
                const size_t inner_work
                        = div_up(jcp.is, simd_w) * div_up(jcp.ic, simd_w);
                const float inner_thr_eff
                        = (float)inner_work / rnd_up(inner_work, max_threads);
                jcp.outer_threading
                        = (is_depthwise
                                  || (jcp.is / max_threads < 64 && jcp.mb != 1))
                        && (outer_thr_eff / inner_thr_eff >= 1.f
                                || (jcp.os * jcp.ic * jcp.oc) / max_threads
                                        < gemm_thrld);
            }
            jcp.nthr = jcp.outer_threading ? max_threads : 1;
            scratchpad.book<int8_t>(
                    key_conv_gemm_col, jcp.nthr * jcp.im2col_sz);
            scratchpad.book<int32_t>(key_conv_int_dat_in_acc_dt,
                    jcp.nthr * jcp.oh_block * jcp.ow_block * jcp.oc);
            scratchpad.book<int8_t>(
                    key_conv_gemm_imtr, jcp.nthr * jcp.id * jcp.is * jcp.ic);
        } else if (is_bwd_d) {
            jcp.im2col_sz
                    = !everyone_is(true, jcp.ow == jcp.iw, jcp.oh == jcp.ih,
                              jcp.od == jcp.id, jcp.stride_w == 1,
                              jcp.stride_h == 1, jcp.stride_d == 1, jcp.ks == 1,
                              !jcp.signed_input)
                    ? (ptrdiff_t)jcp.ic * jcp.ks * jcp.os * jcp.od
                    : 0;

            bool is_depthwise = jcp.ic == 1 && jcp.oc == 1 && jcp.ngroups != 1;
            const size_t outer_work = jcp.ngroups * jcp.mb;
            const float outer_thr_eff
                    = (float)outer_work / rnd_up(outer_work, max_threads);
            const size_t inner_work
                    = div_up(jcp.is, simd_w) * div_up(jcp.ic, simd_w);
            const float inner_thr_eff
                    = (float)inner_work / rnd_up(inner_work, max_threads);
            jcp.outer_threading = !is_3d
                    && (is_depthwise
                            || (jcp.is / max_threads < 64 && jcp.mb != 1))
                    && (outer_thr_eff / inner_thr_eff >= 1.f
                            || (jcp.is * jcp.ic * jcp.oc) / max_threads
                                    < gemm_thrld);

            jcp.nthr = jcp.outer_threading ? max_threads : 1;
            scratchpad.book<int32_t>(
                    key_conv_gemm_col, jcp.nthr * jcp.im2col_sz);
            scratchpad.book<int32_t>(key_conv_int_dat_in_acc_dt,
                    jcp.nthr * jcp.is * jcp.id * jcp.ic);
        } else if (is_bwd_w) {
            assert(!"unimplemented prop_kind");
            return status::unimplemented;
        }
    } else {
        jcp.im2col_sz = !everyone_is(true, jcp.ow == jcp.iw, jcp.oh == jcp.ih,
                                jcp.od == jcp.id, jcp.stride_w == 1,
                                jcp.stride_h == 1, jcp.stride_d == 1,
                                jcp.ks == 1, !jcp.signed_input)
                ? (ptrdiff_t)jcp.ic * jcp.ks * jcp.os
                : 0;
        if (is_fwd) {
            const int sh = jcp.stride_h;
            const int sw = jcp.stride_w;
            const int spatial = jcp.mb * jcp.ngroups * jcp.od * jcp.os;
            int K = jcp.ic * jcp.ks;

            // There is some heuristics in the definition of
            // inner/outer threading cross point due to the nature of the
            // gemm implementation which we cannot control
            bool is_blocking_applicable = true
                    && DNNL_X64 // FIXME: workaround to avoid exhaustive search
                    && !is_bf16_conv // TODO: apply blocking to bf16
                    && !is_3d
                    && (!jcp.im2col_sz
                            // spatial is small
                            || spatial >= max_threads * simd_w
                            // inner threading work is greater then outer threading work
                            || jcp.os < jcp.mb * jcp.ngroups * jcp.od
                            // im2col is big
                            || (sw == 1 && K <= 0.05 * jcp.oc))
                    // heuristic condition
                    && (jcp.im2col_sz
                            || (jcp.ic / jcp.oc < 42
                                    && jcp.ic * jcp.oc * jcp.is < 1024));

            if (is_blocking_applicable) {
                const int min_oc_block = 8;
                const int min_os_block = simd_w;
                const float non_cache_access = 20;
                const float strided_im2col_k = 8;
                const float thr_disb_k = 8;
                const float thr_mem_eff_k {1}, oc_disb_k {1}, os_disb_k {1},
                        ic_disb_k {1}, reg_osb_disb_k {1}, gemm_eff_k {0.5},
                        gemm_calc_eff_k {1};
                const float k_sum = thr_disb_k + oc_disb_k + os_disb_k
                        + ic_disb_k + reg_osb_disb_k + thr_mem_eff_k
                        + gemm_eff_k + gemm_calc_eff_k;

                auto calc_max_icb = [=](int nthr_oc, int ocb, int osb,
                                            int oc_per_thr, int os_per_thr) {
                    const int block_out_size = ocb * osb;
                    // TODO: need more precise calculation if stride more than
                    // kernel size
                    const int inp_row_size = sh * sw * osb;
                    int max_icb = 1;
                    if (jcp.im2col_sz) {
                        const int col_row_size = jcp.ks * osb;
                        if (osb >= os_per_thr) { // one pass by os
                            const int wei_col_size = jcp.ks * ocb;
                            max_icb = L2 / (inp_row_size + col_row_size);
                            if (ocb < oc_per_thr) {
                                max_icb = nstl::min(max_icb,
                                        (L2 - block_out_size)
                                                / (col_row_size
                                                        + wei_col_size));
                            }
                        } else {
                            const int wei_col_size = jcp.ks * oc_per_thr;
                            max_icb = (L2 - block_out_size)
                                    / (inp_row_size + col_row_size
                                            + wei_col_size);
                        }
                    } else {
                        if (osb >= os_per_thr)
                            max_icb = L2 / inp_row_size;
                        else {
                            const int wei_col_size = jcp.ks * oc_per_thr;
                            max_icb = L2 / (inp_row_size + wei_col_size);
                        }
                    }
                    if (max_icb < jcp.ic) {
                        if (jcp.im2col_sz) {
                            const int col_row_size = jcp.ks * osb;
                            const int wei_col_size = jcp.ks * oc_per_thr;
                            max_icb = (L2 - block_out_size)
                                    / (inp_row_size + col_row_size
                                            + wei_col_size);
                        }
                    }
                    return max_icb;
                };

                auto est_eff = [=](int nthr_oc, int ocb, int osb, int &icb,
                                       int max_oc_per_thr, int max_os_per_thr) {
                    // for given nthr_oc, oc block:
                    // 1. find ic block to fit into cache
                    // 2. estimate efficiency basing on rules and heuristic:
                    // - Minimize im2col cost
                    // - ratio of FMA number to data size
                    // - gemm works better if M divided by 48 and N divided by 8
                    if (osb > max_os_per_thr || ocb > max_oc_per_thr)
                        return 0.f;

                    int sp_start {0}, sp_end {0}, oc_start {0}, oc_end {0};
                    int max_y {0}, max_oc {0};
                    size_t max_thr_size {0};
                    size_t min_thr_size {(size_t)spatial * jcp.oc + 1};

                    for (int i = 0; i < max_threads; i++) {
                        balance2D(max_threads, i, spatial, sp_start, sp_end,
                                jcp.oc, oc_start, oc_end, nthr_oc);
                        const size_t thr_size = (size_t)(sp_end - sp_start)
                                * (oc_end - oc_start);
                        if (thr_size > max_thr_size) {
                            max_y = (sp_end - sp_start);
                            max_oc = (oc_end - oc_start);
                            max_thr_size = thr_size;
                        }
                        if (thr_size < min_thr_size) min_thr_size = thr_size;
                    }
                    auto thr_disb = (float)min_thr_size / max_thr_size;

                    const int oc_per_thr = max_oc;
                    const int os_per_thr = max_y;
                    ocb = nstl::min(oc_per_thr, ocb);
                    const int os_max = nstl::min(jcp.os, os_per_thr);
                    osb = nstl::min(os_max, osb);

                    // -- selecting icb ---------------------
                    int max_ic_block = calc_max_icb(
                            nthr_oc, ocb, osb, oc_per_thr, os_per_thr);
                    // if we don't fit into cache then access to memory is
                    // expensive
                    int mem_access_cost
                            = (max_ic_block < 1) ? non_cache_access : 1;
                    max_ic_block = nstl::max(1, max_ic_block);
                    icb = nstl::max(1, jcp.ic / div_up(jcp.ic, max_ic_block));
                    int nb_ic = div_up(jcp.ic, icb);
                    int kb = icb * jcp.ks;
                    int kb_caligned = rnd_up(kb, simd_w);

                    // -- mem efficiency ------------
                    const size_t out_size
                            = oc_per_thr * rnd_up(os_per_thr, simd_w);
                    const size_t out_ops = mem_access_cost * out_size
                            * ((icb == jcp.ic) ? 1 : (2 * nb_ic - 1));
                    const int osb_caligned = rnd_up(osb, simd_w);
                    const size_t inp_size
                            = jcp.ic * rnd_up(os_per_thr * sh * sw, simd_w);
                    size_t inp_ops = 0;
                    size_t col_ops = 0;
                    // TODO: simplify calculations
                    if (jcp.im2col_sz) {
                        inp_ops = mem_access_cost * jcp.ks * inp_size;
                        const float col_tail_koeff = (float)osb_caligned / osb;
                        col_ops = mem_access_cost
                                * (jcp.ks * inp_size * col_tail_koeff
                                        + jcp.ks * inp_size * col_tail_koeff);
                        if (sw != 1) // im2col with strides is much slower
                            col_ops *= strided_im2col_k;
                    } else {
                        inp_ops = mem_access_cost * jcp.ks * inp_size;
                    }
                    // TODO: what about groups?
                    const size_t wei_size = oc_per_thr * rnd_up(K, simd_w);
                    const size_t wei_ops = mem_access_cost * wei_size;
                    // ratio of real FMA to number of memory ops
                    const float thr_mem_eff
                            = (((float)os_per_thr / simd_w) * oc_per_thr * K)
                            / (inp_ops + col_ops + wei_ops + out_ops);

                    auto oc_disb = (float)oc_per_thr / rnd_up(oc_per_thr, ocb);
                    auto os_disb = (float)os_max / rnd_up(os_max, osb);
                    auto ic_disb = (float)jcp.ic / rnd_up(jcp.ic, icb);

                    auto reg_osb_disb = (float)osb / rnd_up(osb, 3 * simd_w);

                    // Heuristics
                    const float gemm_eff = ((float)osb * ocb * kb)
                            / ((float)oc_per_thr * os_per_thr * K);

                    // number of FMA to memory size
                    const float gemm_calc_eff
                            = (((float)osb / simd_w) * ocb * kb)
                            / (osb_caligned * kb + ocb * kb_caligned
                                    + ocb * osb_caligned);

                    const float res_eff = pow(pow(thr_disb, thr_disb_k)
                                    * pow(oc_disb, oc_disb_k)
                                    * pow(os_disb, os_disb_k)
                                    * pow(ic_disb, ic_disb)
                                    * pow(reg_osb_disb, reg_osb_disb_k)
                                    * pow(thr_mem_eff, thr_mem_eff_k)
                                    * pow(gemm_eff, gemm_eff_k)
                                    * pow(gemm_calc_eff, gemm_calc_eff_k),
                            1.f / k_sum);
                    return res_eff;
                };

                /* find the best thread distribution and blocking with highest
                 * efficiency */
                int best_nthr_oc {1}, best_ocb {jcp.oc}, best_osb {jcp.os},
                        best_icb {jcp.ic};
                float best_thr_eff = est_eff(best_nthr_oc, best_ocb, best_osb,
                        best_icb, jcp.oc, jcp.os);

                int icb {best_icb};
                const int nthr_oc_max = max_threads;
                for (int nthr_oc = 1; nthr_oc <= nthr_oc_max; ++nthr_oc) {
                    const int max_oc_per_thr = div_up(jcp.oc, nthr_oc);
                    const int min_oc_per_thr
                            = nstl::min(min_oc_block, max_oc_per_thr);
                    const int max_os_per_thr = nstl::min(jcp.os,
                            div_up(spatial,
                                    nstl::max(1, max_threads / nthr_oc)));
                    const int min_os_per_thr
                            = nstl::min(min_os_block, max_os_per_thr);
                    for (int ocb = min_oc_per_thr; ocb <= max_oc_per_thr;
                            ocb += nstl::max(1,
                                    nstl::min(min_oc_block,
                                            max_oc_per_thr - ocb))) {
                        for (int osb = min_os_per_thr; osb <= jcp.os;
                                osb += nstl::max(1,
                                        nstl::min(min_os_block,
                                                max_os_per_thr - osb))) {
                            float thr_eff = est_eff(nthr_oc, ocb, osb, icb,
                                    max_oc_per_thr, max_os_per_thr);
                            if (thr_eff > best_thr_eff) {
                                best_thr_eff = thr_eff;
                                best_nthr_oc = nthr_oc;
                                best_ocb = ocb;
                                best_osb = osb;
                                best_icb = icb;
                            }
                        }
                    }
                }

                jcp.outer_threading = true;
                jcp.nthr_oc = best_nthr_oc;
                jcp.oc_block = best_ocb;
                jcp.os_block = best_osb;
                jcp.ic_block = best_icb;
                // TODO: define loop order
                // if im2col then gemm_loop_rlb and gemm_loop_lrb looks
                // preferable otherwise other loop orders are possible
                jcp.loop_order = gemm_loop_rlb;
            } else {
                const size_t outer_work_amount = jcp.ngroups * jcp.mb * jcp.od;
                const float outer_thr_eff = (float)outer_work_amount
                        / rnd_up(outer_work_amount, max_threads);
                const size_t inner_work_amount
                        = div_up(jcp.os, simd_w) * div_up(jcp.oc, simd_w);
                const float inner_thr_eff = (float)inner_work_amount
                        / rnd_up(inner_work_amount, max_threads);
                jcp.outer_threading = jcp.os / max_threads < 512
                        && IMPLICATION(
                                jcp.od == 1, jcp.mb != 1 || jcp.ngroups > 2)
                        && (outer_thr_eff / inner_thr_eff >= 1.f
                                || (jcp.os * jcp.ic * jcp.oc) / max_threads
                                        < gemm_thrld);
            }
            if (jcp.im2col_sz)
                jcp.im2col_sz = (ptrdiff_t)jcp.ic_block * jcp.ks * jcp.os_block;
        } else if (is_bwd_d) {
            const size_t outer_work_amount = jcp.ngroups * jcp.mb;
            const float outer_thr_eff = (float)outer_work_amount
                    / rnd_up(outer_work_amount, max_threads);
            const size_t inner_work
                    = div_up(jcp.is, simd_w) * div_up(jcp.ic, simd_w);
            const float inner_thr_eff
                    = (float)inner_work / rnd_up(inner_work, max_threads);
            jcp.outer_threading = (jcp.os / max_threads < 512 || jcp.ks < 64)
                    && (jcp.mb != 1 || jcp.ngroups > 2)
                    && (outer_thr_eff / inner_thr_eff >= 1.f
                            || (jcp.is * jcp.ic * jcp.oc) / max_threads
                                    < gemm_thrld);
        } else if (is_bwd_w)
            jcp.outer_threading = jcp.os / max_threads < 256
                    && (jcp.mb != 1 || jcp.ngroups > 2);

        jcp.nthr = jcp.outer_threading ? max_threads : 1;
        const size_t gemm_col_datatype_size = is_bf16_conv && !is_bwd_d
                ? sizeof(bfloat16_t)
                : sizeof(float);
        scratchpad.book(key_conv_gemm_col, jcp.nthr * jcp.im2col_sz,
                gemm_col_datatype_size);

        const int sizeof_cacheline_float = 16;
        if (is_bwd_w) {
            jcp.need_wei_reduction = jcp.mb != 1 && jcp.nthr != 1;
            scratchpad.book<float>(
                    key_conv_wei_reduction, jcp.nthr * weights_d.size());
        }

        if (is_bf16_to_bf16_conv) {
            size_t conv_acc_buffer_size = 0;
            if (is_fwd)
                conv_acc_buffer_size = jcp.nthr
                        * rnd_up(jcp.oc * jcp.oh_block * jcp.ow_block,
                                sizeof_cacheline_float);
            else if (is_bwd_d)
                conv_acc_buffer_size = jcp.nthr
                        * rnd_up(jcp.ic * jcp.ih * jcp.iw * jcp.id,
                                sizeof_cacheline_float);
            else if (is_bwd_w)
                conv_acc_buffer_size = weights_d.size();
            scratchpad.book<float>(
                    key_conv_int_dat_in_acc_dt, conv_acc_buffer_size);
            if ((is_fwd || is_bwd_w) && jcp.with_bias
                    && one_of(data_type::bf16, cd.diff_bias_desc.data_type,
                            cd.bias_desc.data_type))
                scratchpad.book<float>(
                        key_conv_bias_bf16_convert_wsp, jcp.ngroups * jcp.oc);
        }
    }
    // Heuristic threshold for requested scratchpad memory to avoid
    // possible crash on memory allocation:
    // 1Gb or size of the buffers already used for this convolution proportional
    // to the number of threads and multiplied by a heuristic coefficient (15)
    size_t scratchpad_limit_by_absolute_value = (size_t)1 << 30; // 1Gb
    size_t scratchpad_limit_by_tensor_sizes = 15 * max_threads
            * (src_d.size() + weights_d.size() + dst_d.size());

    size_t scratchpad_limit = nstl::min(scratchpad_limit_by_absolute_value,
            scratchpad_limit_by_tensor_sizes);
    if (scratchpad.size() > scratchpad_limit) return status::unimplemented;
    return status::success;
}

void bwd_weights_balance(int ithr, int nthr, int ngroups, int mb, int &ithr_g,
        int &nthr_g, int &ithr_mb, int &nthr_mb) {
    nthr_g = nstl::min(ngroups, nthr);
    nthr_mb = nstl::min(mb, nthr / nthr_g);
    if (ithr / nthr_mb >= ngroups) {
        ithr_g = ithr_mb = -1;
    } else {
        ithr_g = ithr / nthr_mb;
        ithr_mb = ithr % nthr_mb;
    }
}

void bwd_weights_reduction_par(int ithr, int nthr, const conv_gemm_conf_t &jcp,
        const float *weights_reduce_ws, float *weights) {
    const size_t weights_g_size = jcp.ic * jcp.oc * jcp.ks;

    size_t weights_start {0}, weights_end {0};
    balance211(weights_g_size, nthr, ithr, weights_start, weights_end);

    for (int i = 0; i < nthr; ++i) {
        const float *ws_i = weights_reduce_ws + i * weights_g_size;
        for (size_t s = weights_start; s < weights_end; ++s)
            weights[s] = (i == 0 ? 0 : weights[s]) + ws_i[s];
    }
}

} // namespace jit_gemm_convolution_utils

} // namespace cpu
} // namespace impl
} // namespace dnnl
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
