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

template <data_type_t src_type, data_type_t wei_type, data_type_t dst_type,
        data_type_t acc_type>
void ref_convolution_fwd_t<src_type, wei_type, dst_type,
        acc_type>::execute_forward(const exec_ctx_t &ctx) const {
    auto src = CTX_IN_MEM(const src_data_t *, DNNL_ARG_SRC);
    auto weights = CTX_IN_MEM(const wei_data_t *, DNNL_ARG_WEIGHTS);
    auto bias = CTX_IN_MEM(const char *, DNNL_ARG_BIAS);
    auto dst = CTX_OUT_MEM(dst_data_t *, DNNL_ARG_DST);

    const memory_desc_wrapper src_d(pd()->src_md());
    const memory_desc_wrapper dst_d(pd()->dst_md());
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

    const int ndims = pd()->desc()->src_desc.ndims;

    using namespace data_type;
    bool constexpr is_int_conv = utils::one_of(src_type, s32, s8, u8);

    auto maybe_oscale = [=](float &d, int g, int oc) {
        // scale_idx_mult = 1 for per_oc scales and 0, otherwise
        const int scale_idx_mult
                = pd()->attr()->output_scales_.mask_ == (1 << 1);
        const float *scales = pd()->attr()->output_scales_.scales_;
        d *= scales[(g * OC + oc) * scale_idx_mult];
    };

    auto maybe_postops = [=](float &d, dst_data_t dst) {
        // Sum and post ops:
        const post_ops_t &ops = pd()->attr()->post_ops_;
        for (int idx = 0; idx < ops.len_; ++idx) {
            const auto &e = ops.entry_[idx];
            if (e.kind == dnnl_sum)
                d += e.sum.scale * dst;
            else
                d = eltwises_[idx]->compute_scalar(d);
        }
    };

    // make offset calls "look the same". We suffer a fn call anyway for the offset.
    auto off_abxg = (with_groups
            ? (ndims == 5? offg5d: ndims == 4? offg4d:
                ndims == 3? offg3d: oops)
            : (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops));
    auto off_abx = (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops);

    auto ker = [=](int g, int mb, int oc, int od, int oh, int ow) {
        acc_data_t d = 0;
        for_(int ic = 0; ic < IC; ++ic)
        for_(int kd = 0; kd < KD; ++kd)
        for_(int kh = 0; kh < KH; ++kh)
        for (int kw = 0; kw < KW; ++kw) {
            const int id = od * KSD - padFront + kd * KDD;
            const int ih = oh * KSH - padT + kh * KDH;
            const int iw = ow * KSW - padL + kw * KDW;

            if (id < 0 || id >= ID) continue;
            if (ih < 0 || ih >= IH) continue;
            if (iw < 0 || iw >= IW) continue;

#if 0
            if (ndims == 5)
                d += (acc_data_t)src[src_d.off(mb, g * IC + ic, id, ih, iw)]
                        * (with_groups ? weights[weights_d.off(
                                   g, oc, ic, kd, kh, kw)]
                                       : weights[weights_d.off(
                                               oc, ic, kd, kh, kw)]);
            else if (ndims == 4)
                d += (acc_data_t)src[src_d.off(mb, g * IC + ic, ih, iw)]
                        * (with_groups ? weights[weights_d.off(
                                   g, oc, ic, kh, kw)]
                                       : weights[weights_d.off(
                                               oc, ic, kh, kw)]);
            else if (ndims == 3)
                d += (acc_data_t)src[src_d.off(mb, g * IC + ic, iw)]
                        * (with_groups ? weights[weights_d.off(g, oc, ic, kw)]
                                       : weights[weights_d.off(oc, ic, kw)]);
            else
                assert(false);
#else
            acc_data_t const ss = src[ off_abx(
                    src_d, 0, mb, g * IC + ic, id, ih, iw) ];
            acc_data_t const ww = weights[ off_abxg(
                    weights_d, g, oc, ic, kd, kh, kw) ];
            d += ss * ww;
#endif
        }
        return d;
    };

    // help compiler optimize the code
    // constants for plain layouts kernel
    const dnnl_dims_t &src_str = src_d.blocking_desc().strides;
    const dim_t src_ic_stride = src_str[1];
    const dim_t src_id_stride = (ndims == 5) ? src_str[2] : 0;
    const dim_t src_ih_stride = (ndims >= 4) ? src_str[ndims - 2] : 0;
    const dim_t src_iw_stride = (ndims >= 3) ? src_str[ndims - 1] : 0;
    const dnnl_dims_t &weights_str = weights_d.blocking_desc().strides;
    const int gr_shift = with_groups ? 1 : 0;
    const dim_t weights_ic_stride = weights_str[1 + gr_shift];
    const dim_t weights_kd_stride
            = (ndims == 5) ? weights_str[2 + gr_shift] : 0;
    const dim_t weights_kh_stride
            = (ndims >= 4) ? weights_str[ndims - 2 + gr_shift] : 0;
    const dim_t weights_kw_stride
            = (ndims >= 3) ? weights_str[ndims - 1 + gr_shift] : 0;

    auto ker_plain = [=](int g, int mb, int oc, int od, int oh, int ow) {
        assert(3 <= ndims && ndims <= 5);
        acc_data_t d = 0;

        const dim_t src_loc_off = off_abx(src_d, 0, mb, g * IC, 0, 0, 0);
        const dim_t weights_loc_off = off_abxg(weights_d, g, oc, 0, 0, 0, 0);

        const src_data_t *__restrict src_loc = src + src_loc_off;
        const wei_data_t *__restrict weights_loc = weights + weights_loc_off;

        if (IC > KW) {
            for_(dim_t kd = 0; kd < KD; ++kd)
            for_(dim_t kh = 0; kh < KH; ++kh)
            for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                        || iw >= IW)
                    continue;
                for (int ic = 0; ic < IC; ++ic) {
                    const dim_t src_off = ic + id * src_id_stride
                            + ih * src_ih_stride + iw * src_iw_stride;
                    const dim_t weights_off = ic * weights_ic_stride
                            + kd * weights_kd_stride + kh * weights_kh_stride
                            + kw;
                    d += (acc_data_t)src_loc[src_off]
                            * weights_loc[weights_off];
                }
            }
        } else {
            for_(dim_t ic = 0; ic < IC; ++ic)
            for_(dim_t kd = 0; kd < KD; ++kd)
            for_(dim_t kh = 0; kh < KH; ++kh)
            for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                        || iw >= IW)
                    continue;
                const dim_t src_off = ic + id * src_id_stride
                        + ih * src_ih_stride + iw * src_iw_stride;
                const dim_t weights_off = ic * weights_ic_stride
                        + kd * weights_kd_stride + kh * weights_kh_stride + kw;
                d += (acc_data_t)src_loc[src_off]
                        * weights_loc[weights_off];
            }
        }
        return d;
    };

    // TODO ||ize offset calcs for VE
    parallel_nd(G, MB, OC, OD, OH, OW,
            [&](int g, int mb, int oc, int od, int oh, int ow) {
                float a = bias ? get_bias(bias, bias_d.off(g * OC + oc),
                                  pd()->desc()->bias_desc.data_type)
                               : 0;

                if (src_d.is_plain() && weights_d.is_plain()
                        && src_ic_stride == 1 && weights_kw_stride == 1)
                    a += ker_plain(g, mb, oc, od, oh, ow);
                else
                    a += ker(g, mb, oc, od, oh, ow);

                const dim_t dst_off = off_abx(dst_d, 0, mb, g * OC + oc, od, oh, ow);

                maybe_oscale(a, g, oc);
                maybe_postops(a, dst[dst_off]);

                using cvt_dst = Cvt<dst_data_t, is_int_conv>;
                dst[dst_off] = cvt_dst::qs(a);
            });
}

using namespace data_type;

template struct ref_convolution_fwd_t<f32>;
template struct ref_convolution_fwd_t<bf16,bf16,bf16,f32>;
template struct ref_convolution_fwd_t<bf16,bf16,f32,f32>;

template struct ref_convolution_fwd_t<u8, s8, f32, s32>;
template struct ref_convolution_fwd_t<u8, s8, s32, s32>;
template struct ref_convolution_fwd_t<u8, s8, s8, s32>;
template struct ref_convolution_fwd_t<u8, s8, u8, s32>;
template struct ref_convolution_fwd_t<s8, s8, f32, s32>;
template struct ref_convolution_fwd_t<s8, s8, s32, s32>;
template struct ref_convolution_fwd_t<s8, s8, s8, s32>;
template struct ref_convolution_fwd_t<s8, s8, u8, s32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
