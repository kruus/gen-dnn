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

#include "cpu/ve/ref_convolution_util.hpp"
#include "cpu/ve/hoist.hpp"     // nc++: hoist linear conditions out of loops

namespace dnnl {
namespace impl {
namespace cpu {

using math::get_bias;

template <data_type_t diff_src_type, data_type_t wei_type,
        data_type_t diff_dst_type, data_type_t acc_type>
void ref_convolution_bwd_data_t<diff_src_type, wei_type, diff_dst_type,
        acc_type>::execute_backward_data(const exec_ctx_t &ctx) const {
    auto diff_dst = CTX_IN_MEM(const diff_dst_data_t *, DNNL_ARG_DIFF_DST);
    auto weights = CTX_IN_MEM(const wei_data_t *, DNNL_ARG_WEIGHTS);
    auto bias = CTX_IN_MEM(const char *, DNNL_ARG_BIAS);
    auto diff_src = CTX_OUT_MEM(diff_src_data_t *, DNNL_ARG_DIFF_SRC);

    const memory_desc_wrapper diff_dst_d(pd()->diff_dst_md());
    const memory_desc_wrapper diff_src_d(pd()->diff_src_md());
    const memory_desc_wrapper weights_d(pd()->weights_md(0));
    const memory_desc_wrapper bias_d(pd()->weights_md(1));

    const bool with_groups = pd()->with_groups();

    const int G = pd()->G();
    const int MB = pd()->MB();
    const int OD = pd()->OD();
    const int OH = pd()->OH();
    const int OW = pd()->OW();
    const int ID = pd()->ID();
    const int IH = pd()->IH();
    const int IW = pd()->IW();

    const int OC = pd()->OC() / G;
    const int IC = pd()->IC() / G;
    const int KD = pd()->KD();
    const int KH = pd()->KH();
    const int KW = pd()->KW();

    const int KSD = pd()->KSD();
    const int KSH = pd()->KSH();
    const int KSW = pd()->KSW();

    const int KDD = pd()->KDD() + 1;
    const int KDH = pd()->KDH() + 1;
    const int KDW = pd()->KDW() + 1;

    const int padFront = pd()->padFront();
    const int padT = pd()->padT();
    const int padL = pd()->padL();

    const int ndims = pd()->desc()->diff_src_desc.ndims;

    using namespace data_type;
    bool constexpr is_int_conv = utils::one_of(diff_dst_type, s32, s8, u8);

    auto maybe_oscale = [=](float &d, int g, int ic) {
        /* scale_idx_mult = 1 for per_oc scales and 0, otherwise */
        const int scale_idx_mult
                = pd()->attr()->output_scales_.mask_ == (1 << 1);
        const float *scales = pd()->attr()->output_scales_.scales_;
        d *= scales[(g * OC + ic) * scale_idx_mult];
    };

    // make offset calls "look the same"
    auto off_gabx = (with_groups
            ? (ndims == 5? offg5d: ndims == 4? offg4d:
                ndims == 3? offg3d: oops)
            : (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops));
    auto off_abx = (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops);

    auto ker = [&](int g, int mb, int ic, int id, int ih, int iw) {
        //printf("k"); fflush(stdout);
        acc_data_t d = 0;
        for_(int oc = 0; oc < OC; ++oc)
        for_(int kd = 0; kd < KD; ++kd)
        for_(int kh = 0; kh < KH; ++kh)
        for (int kw = 0; kw < KW; ++kw) {
            if (iw + padL < kw * KDW || ih + padT < kh * KDH
                    || id + padFront < kd * KDD)
                continue;
            int ow = iw - kw * KDW + padL;
            int oh = ih - kh * KDH + padT;
            int od = id - kd * KDD + padFront;
            // hoisting this conditional can be a little more complex! See
            // ex. ref_conv3.cpp for handling ow_beg/end and ow inner loop
            if (ow % KSW != 0 || oh % KSH != 0 || od % KSD != 0) continue;

            ow /= KSW;
            oh /= KSH;
            od /= KSD;

            if (od < OD && oh < OH && ow < OW) {
                // single-statement approach had issues?
                acc_data_t const dd = diff_dst[ off_abx(
                        diff_dst_d, 0, mb, g * OC + oc, od, oh, ow)];
                acc_data_t const ww = weights[off_gabx(
                        weights_d, g, oc, ic, kd, kh, kw)];
                d += dd * ww;
            }
        }
        return d;
    };

    // help compiler optimize the code
    // constants for plain layouts kernel
    const dnnl_dims_t &diff_dst_str = diff_dst_d.blocking_desc().strides;
    const dim_t diff_dst_oc_stride = diff_dst_str[1];
    const dim_t diff_dst_ow_stride = diff_dst_str[ndims - 1];
    const dim_t diff_dst_oh_stride = (ndims >= 4) ? diff_dst_str[ndims - 2] : 0;
    const dim_t diff_dst_od_stride = (ndims >= 5) ? diff_dst_str[ndims - 3] : 0;

    const dnnl_dims_t &weights_str = weights_d.blocking_desc().strides;
    const int gr_shift = with_groups ? 1 : 0;
    const dim_t weights_oc_stride = weights_str[0 + gr_shift];
    const dim_t weights_kw_stride = weights_str[ndims - 1 + gr_shift];
    const dim_t weights_kh_stride
            = (ndims >= 4) ? weights_str[ndims - 2 + gr_shift] : 0;
    const dim_t weights_kd_stride
            = (ndims >= 4) ? weights_str[ndims - 3 + gr_shift] : 0;

    auto ker_plain = [&](int g, int mb, int ic, int id, int ih, int iw) {
        //printf("p"); fflush(stdout);
        assert(3 <= ndims && ndims <= 5);
        acc_data_t d = 0;
        const dim_t diff_dst_loc_off = off_abx(diff_dst_d, 0, mb, g*OC, 0, 0, 0);
        const dim_t weights_loc_off = off_gabx(weights_d, g, 0, ic, 0, 0, 0);

        const diff_dst_data_t *__restrict diff_dst_loc
                = diff_dst + diff_dst_loc_off;
        const wei_data_t *__restrict weights_loc = weights + weights_loc_off;

        if (OC > KW) {
            for_(dim_t kd = 0; kd < KD; ++kd)
            for_(dim_t kh = 0; kh < KH; ++kh)
            for (dim_t kw = 0; kw < KW; ++kw) {
                dim_t ow = iw - kw * KDW + padL;
                dim_t oh = ih - kh * KDH + padT;
                dim_t od = id - kd * KDD + padFront;
                if (ow < 0 || oh < 0 || od < 0 || ow % KSW != 0 || oh % KSH != 0
                        || od % KSD != 0)
                    continue;
                ow /= KSW;
                oh /= KSH;
                od /= KSD;
                if (od >= OD || oh >= OH || ow >= OW) continue;
                for (dim_t oc = 0; oc < OC; ++oc) { // vec!
                    const dim_t diff_dst_off = oc
                            + od * diff_dst_od_stride
                            + oh * diff_dst_oh_stride
                            + ow * diff_dst_ow_stride;
                    const dim_t weights_off
                            = oc * weights_oc_stride
                            + kd * weights_kd_stride
                            + kh * weights_kh_stride
                            + kw;
                    d += (acc_data_t)diff_dst_loc[diff_dst_off]
                            * weights_loc[weights_off];
                }
            }
        } else {
            for_(dim_t oc = 0; oc < OC; ++oc)
            for_(dim_t kd = 0; kd < KD; ++kd)
            for_(dim_t kh = 0; kh < KH; ++kh)
            for (dim_t kw = 0; kw < KW; ++kw) {
                dim_t ow = iw - kw * KDW + padL;
                dim_t oh = ih - kh * KDH + padT;
                dim_t od = id - kd * KDD + padFront;
                if (ow < 0 || oh < 0 || od < 0 || ow % KSW != 0 || oh % KSH != 0
                        || od % KSD != 0)
                    continue;
                ow /= KSW;
                oh /= KSH;
                od /= KSD;
                if (od >= OD || oh >= OH || ow >= OW) continue;
                const dim_t diff_dst_off = oc + od * diff_dst_od_stride
                        + oh * diff_dst_oh_stride + ow * diff_dst_ow_stride;
                const dim_t weights_off = oc * weights_oc_stride
                        + kd * weights_kd_stride + kh * weights_kh_stride + kw;
                d += (acc_data_t)diff_dst_loc[diff_dst_off]
                        * weights_loc[weights_off];
            }
        }
        return d;
    };

    // TODO ||ize offset calcs for VE
    parallel_nd(G, MB, IC, ID, IH, IW,
            [&](int g, int mb, int ic, int id, int ih, int iw) {
                float a = bias ? get_bias(bias, bias_d.off(g * IC + ic),
                                  pd()->desc()->bias_desc.data_type)
                               : 0;

                if (diff_dst_d.is_plain() && weights_d.is_plain()
                        && diff_dst_oc_stride == 1 && weights_kw_stride == 1)
                    a += ker_plain(g, mb, ic, id, ih, iw);
                else
                    a += ker(g, mb, ic, id, ih, iw);

#if 0
                auto ds_idx = (ndims == 5)
                        ? diff_src_d.off(mb, g * IC + ic, id, ih, iw)
                        : (ndims == 4) ? diff_src_d.off(mb, g * IC + ic, ih, iw)
                                       : diff_src_d.off(mb, g * IC + ic, iw);
#else
                auto ds_idx = off_abx(diff_src_d, 0, mb, g * IC + ic, id, ih, iw);
#endif

                maybe_oscale(a, g, ic);
                // NB: no bwd_d postops data -- see dev_guide_convolution.html

                using cvt_src = Cvt<diff_src_data_t, is_int_conv>;
                diff_src[ds_idx] = cvt_src::rs(a);
            });
}

using namespace data_type;

template struct ref_convolution_bwd_data_t<f32, f32, f32, f32>;
template struct ref_convolution_fwd_t<bf16,bf16,bf16,f32>;
template struct ref_convolution_fwd_t<bf16,bf16,f32,f32>;

template struct ref_convolution_bwd_data_t<f32, s8, u8, s32>;
template struct ref_convolution_bwd_data_t<s32, s8, u8, s32>;
template struct ref_convolution_bwd_data_t<s8, s8, u8, s32>;
template struct ref_convolution_bwd_data_t<u8, s8, u8, s32>;
template struct ref_convolution_bwd_data_t<f32, s8, s8, s32>;
template struct ref_convolution_bwd_data_t<s32, s8, s8, s32>;
template struct ref_convolution_bwd_data_t<s8, s8, s8, s32>;
template struct ref_convolution_bwd_data_t<u8, s8, s8, s32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
