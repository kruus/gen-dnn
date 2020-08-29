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

#include "common/c_types_map.hpp"
#include "common/dnnl_thread.hpp"
#include "common/dnnl_traits.hpp"
#include "common/math_utils.hpp"
#include "common/type_helpers.hpp"

#include "cpu/simple_q10n.hpp"

#include "cpu/ref_convolution.hpp"

// set all to zero for original code
#define OFFSET_CALLS 1
#define CVT_ROUND_SATURATE 1

// VE hoisting --> 96 fails in test_convolution_backward_weights_f32
// remove hoisting, for now.  incorrect outputs seem to be zeros.
// HOIST_COND0 --> 1 fail, both --> 96 fails
// Note: independent dev/hoi.cpp verifies hoist_ApiB results are correct,
//       so this is an nc++ bug for more complicated cases.
#define HOIST_COND0 0
#define HOIST_COND1 0

#define INLINE_KER_BIAS 1
#define INLINE_KER_PLAIN 1
#define INLINE_KER 1

#if OFFSET_CALLS || CVT_ROUND_SATURATE
#include "cpu/ve/ref_convolution_util.hpp"
#endif

#if HOIST_COND0 || HOIST_COND1
#include "cpu/ve/hoist.hpp"
#endif

namespace dnnl {
namespace impl {
namespace cpu {

template <data_type_t src_type, data_type_t diff_wei_type,
        data_type_t diff_dst_type, data_type_t acc_type>
void ref_convolution_bwd_weights_t<src_type, diff_wei_type, diff_dst_type,
        acc_type>::execute_backward_weights(const exec_ctx_t &ctx) const {
    auto diff_dst = CTX_IN_MEM(const diff_dst_data_t *, DNNL_ARG_DIFF_DST);
    auto src = CTX_IN_MEM(const src_data_t *, DNNL_ARG_SRC);
    auto diff_weights = CTX_OUT_MEM(diff_wei_data_t *, DNNL_ARG_DIFF_WEIGHTS);
    auto diff_bias = CTX_OUT_MEM(diff_wei_data_t *, DNNL_ARG_DIFF_BIAS);

    const memory_desc_wrapper src_d(pd()->src_md());
    const memory_desc_wrapper diff_dst_d(pd()->diff_dst_md());
    const memory_desc_wrapper diff_weights_d(pd()->diff_weights_md(0));
    const memory_desc_wrapper diff_bias_d(pd()->diff_weights_md(1));

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
#if OFFSET_CALLS
    //assert(3 <= ndims && ndims <= 5);
    auto off_gabx = (with_groups
            ? (ndims == 5? offg5d: ndims == 4? offg4d:
                ndims == 3? offg3d: oops)
            : (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops));
    auto off_abx = (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops);
#endif
#if CVT_ROUND_SATURATE
    using cvt_wei = Cvt<diff_wei_data_t, is_int_conv>;
#endif

#if ! INLINE_KER
    auto ker = [=](acc_data_t &d, int g, int oc, int ic, int kd, int kh,
                       int kw) {
#if HOIST_COND0
        // introducing array helped sometimes
        int olim[6];
        // nc++ full hoist (buggy?)
        //int odlo, odhi, ohlo, ohhi, owlo, owhi;
        //         sub_range  range iw = a   + ow * b   iw_range
        assert( KSD > 0 );
        assert( KSH > 0 );
        assert( KSW > 0 );
        // following 3 lines did not remove bug
        int const d_shift = kd * KDD - padFront;
        int const h_shift = kh * KDH - padT;
        int const w_shift = kw * KDW - padL;
        hoist_ApiB(olim[0],olim[1], 0,OD, d_shift, KSD,  0,ID  );
        hoist_ApiB(olim[2],olim[3], 0,OH, h_shift, KSH,  0,IH  );
        hoist_ApiB(olim[4],olim[5], 0,OW, w_shift, KSW,  0,IW  );
        // should not be required:
        if (olim[0] > ID) olim[0] = ID;
        if (olim[2] > IH) olim[2] = IH;
        if (olim[4] > IW) olim[4] = IW;
        if (olim[1] < olim[0]) olim[1] = olim[0];
        if (olim[3] < olim[2]) olim[3] = olim[2];
        if (olim[5] < olim[4]) olim[5] = olim[4];

        for_(int mb = 0; mb < MB; ++mb)
        for_(int od = olim[0]; od < olim[1]; ++od)
        for_(int oh = olim[2]; oh < olim[3]; ++oh)
        for (int ow = olim[4]; ow < olim[5]; ++ow)
#else
        for_(int mb = 0; mb < MB; ++mb)
        for_(int od = 0; od < OD; ++od)
        for_(int oh = 0; oh < OH; ++oh)
        for (int ow = 0; ow < OW; ++ow)
#endif
        {
#if 0
            if (ow * KSW + kw * KDW < padL || oh * KSH + kh * KDH < padT
                    || od * KSD + kd * KDD < padFront
                    || ow * KSW + kw * KDW >= IW + padL
                    || oh * KSH + kh * KDH >= IH + padT
                    || od * KSD + kd * KDD >= ID + padFront)
                continue;
#endif

            int id = od * KSD - padFront + kd * KDD;
            int ih = oh * KSH - padT + kh * KDH;
            int iw = ow * KSW - padL + kw * KDW;
#if HOIST_COND0
            assert (id >= 0 && id < ID );
            assert (ih >= 0 && ih < IH );
            assert (iw >= 0 && iw < IW );
#else
            if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0 || iw >= IW)
                continue;
#endif
#if OFFSET_CALLS
            acc_data_t const dd = diff_dst[ off_abx(
                    diff_dst_d, 0, mb, g*OC+oc, od, oh, ow) ];
            acc_data_t const ss = src[ off_abx(
                    src_d, 0, mb, g*IC+ic, id, ih, iw) ];
            d += dd * ss;
#else
            if (ndims == 5)
                d += (acc_data_t)diff_dst[diff_dst_d.off(
                             mb, g * OC + oc, od, oh, ow)]
                        * src[src_d.off(mb, g * IC + ic, id, ih, iw)];
            else if (ndims == 4)
                d += (acc_data_t)diff_dst[diff_dst_d.off(
                             mb, g * OC + oc, oh, ow)]
                        * src[src_d.off(mb, g * IC + ic, ih, iw)];
            else if (ndims == 3)
                d += (acc_data_t)diff_dst[diff_dst_d.off(mb, g * OC + oc, ow)]
                        * src[src_d.off(mb, g * IC + ic, iw)];
            else
                assert(false);
#endif
        }
    };
#endif // ! INLINE_KER

#if ! INLINE_KER_PLAIN
    auto ker_plain = [=](acc_data_t &d, int g, int oc, int ic, int kd, int kh,
                             int kw) {
        assert(3 <= ndims && ndims <= 5);
        // help compiler optimize the code
        // constants for plain layouts kernel
        const dnnl_dims_t &diff_dst_str = diff_dst_d.blocking_desc().strides;
        const dim_t diff_dst_mb_stride = diff_dst_str[0];
        const dim_t diff_dst_ow_stride = diff_dst_str[ndims - 1];
        const dim_t diff_dst_oh_stride
                = (ndims >= 4) ? diff_dst_str[ndims - 2] : 0;
        const dim_t diff_dst_od_stride
                = (ndims >= 5) ? diff_dst_str[ndims - 3] : 0;
        const dnnl_dims_t &src_str = src_d.blocking_desc().strides;
        const dim_t src_mb_stride = src_str[0];
        const dim_t src_iw_stride = src_str[ndims - 1];
        const dim_t src_ih_stride = (ndims >= 4) ? src_str[ndims - 2] : 0;
        const dim_t src_id_stride = (ndims >= 5) ? src_str[ndims - 3] : 0;

#if OFFSET_CALLS
        const dim_t diff_dst_loc_off = off_abx(diff_dst_d, 0, 0, g * OC + oc, 0, 0, 0);
        const dim_t src_loc_off      = off_abx(src_d,      0, 0, g * IC + ic, 0, 0, 0);
#else
        const dim_t diff_dst_loc_off = (ndims == 5)
                ? diff_dst_d.off(0, g * OC + oc, 0, 0, 0)
                : (ndims == 4)
                        ? diff_dst_d.off(0, g * OC + oc, 0, 0)
                        : (ndims == 3) ? diff_dst_d.off(0, g * OC + oc, 0) : 0;

        const dim_t src_loc_off = (ndims == 5)
                ? src_d.off(0, g * IC + ic, 0, 0, 0)
                : (ndims == 4)
                        ? src_d.off(0, g * IC + ic, 0, 0)
                        : (ndims == 3) ? src_d.off(0, g * IC + ic, 0) : 0;
#endif

        const diff_dst_data_t *__restrict diff_dst_loc
                = diff_dst + diff_dst_loc_off;
        const src_data_t *__restrict src_loc = src + src_loc_off;

#if HOIST_COND1
        int olim[6];
        //int odlo, odhi, ohlo, ohhi, owlo, owhi;
        //         sub_range  range iw = a     + ow * b iw_range
        hoist_ApiB(olim[0],olim[1], 0,OD, kd*KDD-padFront,KSD,  0,ID  );
        hoist_ApiB(olim[2],olim[3], 0,OH, kh*KDH-padT,    KSH,  0,IH  );
        hoist_ApiB(olim[4],olim[5], 0,OW, kw*KDW-padL,    KSW,  0,IW  );
        for_(dim_t mb = 0; mb < MB; ++mb) {
        for_(int od = olim[0]; od < olim[1]; ++od) {
        for_(int oh = olim[2]; oh < olim[3]; ++oh) {
        for (int ow = olim[4]; ow < olim[5]; ++ow) {
#else
        for_(dim_t mb = 0; mb < MB; ++mb) {
        for_(dim_t od = 0; od < OD; ++od) {
        for_(dim_t oh = 0; oh < OH; ++oh) {
        for (dim_t ow = 0; ow < OW; ++ow) {
#endif
            const dim_t id = od * KSD - padFront + kd * KDD;
            const dim_t ih = oh * KSH - padT + kh * KDH;
            const dim_t iw = ow * KSW - padL + kw * KDW;
#if HOIST_COND1
            assert (id >= 0 && id < ID );
            assert (ih >= 0 && ih < IH );
            assert (iw >= 0 && iw < IW );
#else
            if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0 || iw >= IW)
                continue;
#endif
            const dim_t diff_dst_off = mb * diff_dst_mb_stride
                    + od * diff_dst_od_stride + oh * diff_dst_oh_stride
                    + ow * diff_dst_ow_stride;
            const dim_t src_off = mb * src_mb_stride + id * src_id_stride
                    + ih * src_ih_stride + iw * src_iw_stride;
            d += (acc_data_t)diff_dst_loc[diff_dst_off] * src_loc[src_off];
        }}}}
    };
#endif // ! INLINE_KER_PLAIN

#if ! INLINE_KER_BIAS
    auto ker_bias = [=](acc_data_t &d, int g, int oc) {
        for_(int mb = 0; mb < MB; ++mb)
        for_(int od = 0; od < OD; ++od)
        for_(int oh = 0; oh < OH; ++oh)
        for (int ow = 0; ow < OW; ++ow) {
#if OFFSET_CALLS
            d += (acc_data_t) diff_dst[ off_abx(diff_dst_d,
                    0, mb, g * OC + oc, od, oh, ow)];
#else
            if (ndims == 5)
                d += (acc_data_t)
                        diff_dst[diff_dst_d.off(mb, g * OC + oc, od, oh, ow)];
            else if (ndims == 4)
                d += (acc_data_t)
                        diff_dst[diff_dst_d.off(mb, g * OC + oc, oh, ow)];
            else if (ndims == 3)
                d += (acc_data_t)diff_dst[diff_dst_d.off(mb, g * OC + oc, ow)];
            else
                assert(false);
#endif
        }
    };
#endif // ! INLINE_KER_BIAS

    // TODO ||ize offset calcs for VE
    //printf(" rconv-bwd-%s-%s ", (diff_bias? "B":""), (is_int_conv? "I":""));
    parallel_nd(G, OC, [=](int g, int oc) {
        if (diff_bias) {
            // XXX: loss of precision when bias is a float...
            acc_data_t db = 0;
#if INLINE_KER_BIAS
            for_(int mb = 0; mb < MB; ++mb)
            for_(int od = 0; od < OD; ++od)
            for_(int oh = 0; oh < OH; ++oh)
            for (int ow = 0; ow < OW; ++ow) {
#if OFFSET_CALLS
                db += (acc_data_t) diff_dst[ off_abx(diff_dst_d,
                        0, mb, g * OC + oc, od, oh, ow)];
#else
                if (ndims == 5)
                    db += (acc_data_t)
                            diff_dst[diff_dst_d.off(mb, g * OC + oc, od, oh, ow)];
                else if (ndims == 4)
                    db += (acc_data_t)
                            diff_dst[diff_dst_d.off(mb, g * OC + oc, oh, ow)];
                else if (ndims == 3)
                    db += (acc_data_t)diff_dst[diff_dst_d.off(mb, g * OC + oc, ow)];
                else
                    assert(false);
#endif
            }
#else
            ker_bias(db, g, oc);
#endif // INLINE_KER_BIAS
#if CVT_ROUND_SATURATE
            diff_bias[diff_bias_d.off(g * OC + oc)] = cvt_wei::rs(db);
#else
            if (is_int_conv)
                diff_bias[diff_bias_d.off(g * OC + oc)]
                        = round_and_saturate<diff_wei_data_t>(db);
            else
                diff_bias[diff_bias_d.off(g * OC + oc)]
                        = saturate<diff_wei_data_t>(db);
#endif
        }

        for_(int ic = 0; ic < IC; ++ic)
        for_(int kd = 0; kd < KD; ++kd)
        for_(int kh = 0; kh < KH; ++kh)
        for (int kw = 0; kw < KW; ++kw) {
            acc_data_t dw = 0;
            if (diff_dst_d.is_plain() && src_d.is_plain()) {
#if INLINE_KER_PLAIN
    //auto ker_plain = [=](acc_data_t &d, int g, int oc, int ic, int kd, int kh,
    //                         int kw)
        assert(3 <= ndims && ndims <= 5);
        // help compiler optimize the code
        // constants for plain layouts kernel
        const dnnl_dims_t &diff_dst_str = diff_dst_d.blocking_desc().strides;
        const dim_t diff_dst_mb_stride = diff_dst_str[0];
        const dim_t diff_dst_ow_stride = diff_dst_str[ndims - 1];
        const dim_t diff_dst_oh_stride
                = (ndims >= 4) ? diff_dst_str[ndims - 2] : 0;
        const dim_t diff_dst_od_stride
                = (ndims >= 5) ? diff_dst_str[ndims - 3] : 0;
        const dnnl_dims_t &src_str = src_d.blocking_desc().strides;
        const dim_t src_mb_stride = src_str[0];
        const dim_t src_iw_stride = src_str[ndims - 1];
        const dim_t src_ih_stride = (ndims >= 4) ? src_str[ndims - 2] : 0;
        const dim_t src_id_stride = (ndims >= 5) ? src_str[ndims - 3] : 0;

#if OFFSET_CALLS
        const dim_t diff_dst_loc_off = off_abx(diff_dst_d, 0, 0, g * OC + oc, 0, 0, 0);
        const dim_t src_loc_off      = off_abx(src_d,      0, 0, g * IC + ic, 0, 0, 0);
#else
        const dim_t diff_dst_loc_off = (ndims == 5)
                ? diff_dst_d.off(0, g * OC + oc, 0, 0, 0)
                : (ndims == 4)
                        ? diff_dst_d.off(0, g * OC + oc, 0, 0)
                        : (ndims == 3) ? diff_dst_d.off(0, g * OC + oc, 0) : 0;

        const dim_t src_loc_off = (ndims == 5)
                ? src_d.off(0, g * IC + ic, 0, 0, 0)
                : (ndims == 4)
                        ? src_d.off(0, g * IC + ic, 0, 0)
                        : (ndims == 3) ? src_d.off(0, g * IC + ic, 0) : 0;
#endif

        const diff_dst_data_t *__restrict diff_dst_loc
                = diff_dst + diff_dst_loc_off;
        const src_data_t *__restrict src_loc = src + src_loc_off;

#if HOIST_COND1
        int olim[6];
        //int odlo, odhi, ohlo, ohhi, owlo, owhi;
        //         sub_range  range iw = a     + ow * b iw_range
        hoist_ApiB(olim[0],olim[1], 0,OD, kd*KDD-padFront,KSD,  0,ID  );
        hoist_ApiB(olim[2],olim[3], 0,OH, kh*KDH-padT,    KSH,  0,IH  );
        hoist_ApiB(olim[4],olim[5], 0,OW, kw*KDW-padL,    KSW,  0,IW  );
        for_(dim_t mb = 0; mb < MB; ++mb)
        for_(int od = olim[0]; od < olim[1]; ++od)
        for_(int oh = olim[2]; oh < olim[3]; ++oh)
        for (int ow = olim[4]; ow < olim[5]; ++ow)
#else
        for_(dim_t mb = 0; mb < MB; ++mb)
        for_(dim_t od = 0; od < OD; ++od)
        for_(dim_t oh = 0; oh < OH; ++oh)
        for (dim_t ow = 0; ow < OW; ++ow)
#endif
        {
            const dim_t id = od * KSD - padFront + kd * KDD;
            const dim_t ih = oh * KSH - padT + kh * KDH;
            const dim_t iw = ow * KSW - padL + kw * KDW;
#if HOIST_COND1
            assert (id >= 0 && id < ID );
            assert (ih >= 0 && ih < IH );
            assert (iw >= 0 && iw < IW );
#else
            if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0 || iw >= IW)
                continue;
#endif
            const dim_t diff_dst_off = mb * diff_dst_mb_stride
                    + od * diff_dst_od_stride + oh * diff_dst_oh_stride
                    + ow * diff_dst_ow_stride;
            const dim_t src_off = mb * src_mb_stride + id * src_id_stride
                    + ih * src_ih_stride + iw * src_iw_stride;
            dw += (acc_data_t)diff_dst_loc[diff_dst_off] * src_loc[src_off];
        }
#else
                ker_plain(dw, g, oc, ic, kd, kh, kw);
#endif // INLINE_KER_PLAIN
            } else {
#if INLINE_KER
    //auto ker = [=](acc_data_t &d, int g, int oc, int ic, int kd, int kh,
    //                   int kw) 
#if HOIST_COND0
        int olim[6]; // better ??
        // nc++ full hoist (vectorization workaround)
        //int odlo, odhi, ohlo, ohhi, owlo, owhi;
        //         sub_range  range iw = a   + ow * b   iw_range
        hoist_ApiB(olim[0],olim[1], 0,OD, kd*KDD-padFront,KSD,  0,ID  );
        hoist_ApiB(olim[2],olim[3], 0,OH, kh*KDH-padT,    KSH,  0,IH  );
        hoist_ApiB(olim[4],olim[5], 0,OW, kw*KDW-padL,    KSW,  0,IW  );
        for_(int mb = 0; mb < MB; ++mb)
        for_(int od = olim[0]; od < olim[1]; ++od)
        for_(int oh = olim[2]; oh < olim[3]; ++oh)
        for (int ow = olim[4]; ow < olim[5]; ++ow)
#else
        for_(int mb = 0; mb < MB; ++mb)
        for_(int od = 0; od < OD; ++od)
        for_(int oh = 0; oh < OH; ++oh)
        for (int ow = 0; ow < OW; ++ow)
#endif
        {
#if 0
            if (ow * KSW + kw * KDW < padL || oh * KSH + kh * KDH < padT
                    || od * KSD + kd * KDD < padFront
                    || ow * KSW + kw * KDW >= IW + padL
                    || oh * KSH + kh * KDH >= IH + padT
                    || od * KSD + kd * KDD >= ID + padFront)
                continue;
#endif

            int id = od * KSD - padFront + kd * KDD;
            int ih = oh * KSH - padT + kh * KDH;
            int iw = ow * KSW - padL + kw * KDW;
#if HOIST_COND0
            assert (id >= 0 && id < ID );
            assert (ih >= 0 && ih < IH );
            assert (iw >= 0 && iw < IW );
#else
            if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0 || iw >= IW)
                continue;
#endif
#if OFFSET_CALLS
            acc_data_t const dd = diff_dst[ off_abx(
                    diff_dst_d, 0, mb, g*OC+oc, od, oh, ow) ];
            acc_data_t const ss = src[ off_abx(
                    src_d, 0, mb, g*IC+ic, id, ih, iw) ];
            dw += dd * ss;
#else
            if (ndims == 5)
                dw += (acc_data_t)diff_dst[diff_dst_d.off(
                             mb, g * OC + oc, od, oh, ow)]
                        * src[src_d.off(mb, g * IC + ic, id, ih, iw)];
            else if (ndims == 4)
                dw += (acc_data_t)diff_dst[diff_dst_d.off(
                             mb, g * OC + oc, oh, ow)]
                        * src[src_d.off(mb, g * IC + ic, ih, iw)];
            else if (ndims == 3)
                dw += (acc_data_t)diff_dst[diff_dst_d.off(mb, g * OC + oc, ow)]
                        * src[src_d.off(mb, g * IC + ic, iw)];
            else
                assert(false);
#endif
        }
#else
                ker(dw, g, oc, ic, kd, kh, kw);
#endif // INLINE_KER
            }

#if OFFSET_CALLS
            const dim_t idx = off_gabx(diff_weights_d, g, oc, ic, kd, kh, kw);
#else
            dim_t idx {0};
            if (ndims == 5)
                idx = with_groups ? diff_weights_d.off(g, oc, ic, kd, kh, kw)
                                  : diff_weights_d.off(oc, ic, kd, kh, kw);
            else if (ndims == 4)
                idx = with_groups ? diff_weights_d.off(g, oc, ic, kh, kw)
                                  : diff_weights_d.off(oc, ic, kh, kw);
            else if (ndims == 3)
                idx = with_groups ? diff_weights_d.off(g, oc, ic, kw)
                                  : diff_weights_d.off(oc, ic, kw);
            else
                assert(false);
#endif
#if CVT_ROUND_SATURATE
            diff_weights[idx] = cvt_wei::rs(dw);
#else
            if (is_int_conv)
                diff_weights[idx] = round_and_saturate<diff_wei_data_t>(dw);
            else
                diff_weights[idx] = saturate<diff_wei_data_t>(dw);
#endif
        }
    });
}

using namespace data_type;

template struct ref_convolution_bwd_weights_t<f32, f32, f32, f32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino+=l0,\:4,N-s
