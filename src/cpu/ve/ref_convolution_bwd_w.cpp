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

/** \file nc++-3.0.25 had particular difficulties with this compilation. */
#if 0
#include "cpu/ve/ref_convolution_bwd_w-orig.ipp" // I guess I introduced an
#else

#include "cpu/ve/ref_convolution_util.hpp"
#include "cpu/ve/hoist.hpp"     // nc++: hoist linear conditions out of loops

namespace dnnl {
namespace impl {
namespace cpu {

// could try exact same version as v0.16 (same functionality)
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

    // make offset calls "look the same"
    auto off_gabx = (with_groups
            ? (ndims == 5? offg5d: ndims == 4? offg4d:
                ndims == 3? offg3d: oops)
            : (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops));
    auto off_abx = (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops);
    assert(3 <= ndims && ndims <= 5);

#define USE_KER_BIAS 1
#define USE_KER 1
#define ALLOW_KER_PLAIN 0

#if USE_KER_BIAS
    auto ker_bias = [&](int const g, int const oc) {
        acc_data_t db {0};
        NOVEC for_(int mb = 0; mb < MB; ++mb)
        NOVEC for_(int od = 0; od < OD; ++od)
        NOVEC for_(int oh = 0; oh < OH; ++oh)
        NOVEC for (int ow = 0; ow < OW; ++ow) {
            db += (acc_data_t) diff_dst[ off_abx(diff_dst_d,
                    0, mb, g * OC + oc, od, oh, ow)];
        }
        return db;
    };
#endif // USE_KER_BIAS

#if USE_KER
    auto ker = [&](int const g, int const oc, int const ic,
            int const kd, int const kh, int const kw) {
        register acc_data_t tmp = acc_data_t{0};

        // nc++ full hoist (vectorization workaround)
        int odlo, odhi, ohlo, ohhi, owlo, owhi;
        //         sub_range  range iw = a   + ow * b   iw_range
        hoist_ApiB(odlo,odhi, 0,OD, kd*KDD-padFront,KSD,  0,ID  );
        hoist_ApiB(ohlo,ohhi, 0,OH, kh*KDH-padT,    KSH,  0,IH  );
        hoist_ApiB(owlo,owhi, 0,OW, kw*KDW-padL,    KSW,  0,IW  );
        NOVEC for_(int mb = 0; mb < MB; ++mb)
        NOVEC for_(int od = odlo; od < odhi; ++od)
        NOVEC for_(int oh = ohlo; oh < ohhi; ++oh) // had typo here!
        NOVEC for (int ow = owlo; ow < owhi; ++ow) {
            int id = od * KSD - padFront + kd * KDD; // in [0,ID)
            int ih = oh * KSH - padT     + kh * KDH; // in [0,IH)
            int iw = ow * KSW - padL     + kw * KDW; // in [0,IW)
#if 0
            if(!( id >= 0 && id < ID && ih >= 0 && ih < IH && iw >=0 && iw < IW)) {
                printf("CHECK: hoist od[%d,%d) oh[%d,%d) ow[%d,%d) --> id,ih,iw=%d,%d,%d cf ID,IH,IW %d,%d,%d\n",
                        odlo,odhi, ohlo,ohhi, owlo,owhi, id,ih,iw,  ID,IH,IW);
            }
            assert( id >= 0 && id < ID
                 && ih >= 0 && ih < IH
                 && iw >=0 && iw < IW );
#endif
            dim_t doff = off_abx(diff_dst_d, 0, mb, g*OC+oc, od, oh, ow);
            dim_t soff = off_abx(src_d,      0, mb, g*IC+ic, id, ih, iw);
            acc_data_t const dd = diff_dst[doff];
            acc_data_t const ss = src[soff];
            tmp += dd * ss;
        }
        return tmp;
    };
#endif // USE_KER

    using cvt_wei = Cvt<diff_wei_data_t, is_int_conv>;

#if ALLOW_KER_PLAIN
    // TODO ||ize offset calcs for VE
    if (diff_bias) {
        //printf(" bias\n"); fflush(stdout);
        parallel_nd(G, OC, [&](int g, int oc) {
                // XXX: loss of precision when bias is a float...
#if USE_KER_BIAS
                acc_data_t const db = ker_bias(g, oc);
#else
                acc_data_t db = 0;
                {
                    NOVEC for_(int mb = 0; mb < MB; ++mb)
                    NOVEC for_(int od = 0; od < OD; ++od)
                    NOVEC for_(int oh = 0; oh < OH; ++oh)
                    NOVEC for (int ow = 0; ow < OW; ++ow) {
                        auto const diff_dst_off = off_abx(diff_dst_d
                                0, mb, g * OC + oc, od, oh, ow);
                        db += (acc_data_t) diff_dst[ diff_dst_off ];
                    }
                }
#endif
                auto const db_val = cvt_wei::rs(db);
                dim_t const db_idx = diff_bias_d.off(g * OC + oc);
                diff_bias[db_idx] = db_val;
        });
    }
#endif

    // XXX nc++-3.0.25 is ALWAYS segfaulting for this optimized kernel  ** DISABLED ** :(
    // ... but even disabling here and using the generic kernel segfaults (NO DIFFERENCE)
#if ALLOW_KER_PLAIN
    if (diff_dst_d.is_plain() && src_d.is_plain())
    {
        //printf(" plain\n"); fflush(stdout);
        // this one can have a problem
        parallel_nd(G, OC, [&](int g, int oc) {
#if 1
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
#endif
            NOVEC for_(int ic = 0; ic < IC; ++ic)
            NOVEC for_(int kd = 0; kd < KD; ++kd)
            NOVEC for_(int kh = 0; kh < KH; ++kh)
            NOVEC for (int kw = 0; kw < KW; ++kw) {
                acc_data_t dw = 0;
                //ker_plain(dw, g, oc, ic, kd, kh, kw);
                {
                    // always-6-args version:
                    const dim_t diff_dst_loc_off = off_abx(diff_dst_d, 0, 0, g * OC + oc, 0, 0, 0);
                    const dim_t src_loc_off      = off_abx(src_d,      0, 0, g * IC + ic, 0, 0, 0);

                    const diff_dst_data_t *__restrict diff_dst_loc
                            = diff_dst + diff_dst_loc_off;
                    const src_data_t      *__restrict src_loc
                            = src + src_loc_off;

#if 1 // orig inner loop conditional
                    NOVEC for_(dim_t mb = 0; mb < MB; ++mb)
                    NOVEC for_(dim_t od = 0; od < OD; ++od)
                    NOVEC for_(dim_t oh = 0; oh < OH; ++oh)
                    NOVEC for (dim_t ow = 0; ow < OW; ++ow) {
                        const dim_t id = od * KSD - padFront + kd * KDD;
                        const dim_t ih = oh * KSH - padT + kh * KDH;
                        const dim_t iw = ow * KSW - padL + kw * KDW;
                        if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0 || iw >= IW)
                            continue;
                        const dim_t diff_dst_off
                                = mb * diff_dst_mb_stride
                                + od * diff_dst_od_stride
                                + oh * diff_dst_oh_stride
                                + ow * diff_dst_ow_stride;
                        const dim_t src_off
                                = mb * src_mb_stride
                                + id * src_id_stride
                                + ih * src_ih_stride
                                + iw * src_iw_stride;
                        acc_data_t const dd = diff_dst_loc[diff_dst_off];
                        acc_data_t const ss = src_loc[src_off];
                        dw += dd * ss;
                    }
#else // nc++ full hoist
                    int odlo, odhi, ohlo, ohhi, owlo, owhi;
                    //         sub_range  range iw = a     + ow * b iw_range
                    hoist_ApiB(odlo,odhi, 0,OD, kd*KDD-padFront,KSD,  0,ID  );
                    hoist_ApiB(ohlo,ohhi, 0,OH, kh*KDH-padT,    KSH,  0,IH  );
                    hoist_ApiB(owlo,owhi, 0,OW, kw*KDW-padL,    KSW,  0,IW  );
                    NOVEC for_(int mb = 0; mb < MB; ++mb)
                    NOVEC for_(int od = odlo; od < odhi; ++od)
                    NOVEC for_(int oh = ohlo; oh < ohhi; ++oh)
                    NOVEC for (int ow = owlo; ow < owhi; ++ow) {
                        const dim_t id = od * KSD - padFront + kd * KDD;
                        const dim_t ih = oh * KSH - padT + kh * KDH;
                        const dim_t iw = ow * KSW - padL + kw * KDW;
                        //assert( id >= 0 && id < ID
                        //     && ih >= 0 && ih < IH
                        //     && iw >= 0 && iw < IW);
                        const dim_t diff_dst_off
                                = mb * diff_dst_mb_stride
                                + od * diff_dst_od_stride
                                + oh * diff_dst_oh_stride
                                + ow * diff_dst_ow_stride;
                        const dim_t src_off
                                = mb * src_mb_stride
                                + id * src_id_stride
                                + ih * src_ih_stride
                                + iw * src_iw_stride;
                        acc_data_t const dd = diff_dst_loc[diff_dst_off];
                        acc_data_t const ss = src_loc[src_off];
                        dw += dd * ss;
                    }
#endif
                }

#if 0
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
#else
                const dim_t idx = off_gabx(diff_weights_d, g, oc, ic, kd, kh, kw);
#endif
                diff_weights[idx] = cvt_wei::rs(dw);
            }
        });
    }else
#endif
    { // this one seems OK, nope it too segfaults with nc++-3.0.25
        //printf(" gen\n"); fflush(stdout);
        parallel_nd(G, OC, [&](int g, int oc) {
            if (diff_bias) {
#if USE_KER_BIAS
                diff_bias[ diff_bias_d.off(g * OC + oc) ]
                        = cvt_wei::rs(ker_bias(g, oc));
#else
#if 0
                acc_data_t const db = ker_bias(g, oc);
#else
                // XXX: loss of precision when bias is a float...
                acc_data_t db = 0;
                NOVEC for_(int mb = 0; mb < MB; ++mb)
                NOVEC for_(int od = 0; od < OD; ++od)
                NOVEC for_(int oh = 0; oh < OH; ++oh)
                NOVEC for (int ow = 0; ow < OW; ++ow) {
                    db += (acc_data_t) diff_dst[ off_abx(diff_dst_d,
                            0, mb, g * OC + oc, od, oh, ow)];
                }
#endif
                auto const db_val = cvt_wei::rs(db);
                dim_t const db_idx = diff_bias_d.off(g * OC + oc);
                diff_bias[db_idx] = db_val
#endif
            }

            NOVEC for_(int ic = 0; ic < IC; ++ic)
            NOVEC for_(int kd = 0; kd < KD; ++kd)
            NOVEC for_(int kh = 0; kh < KH; ++kh)
            NOVEC for (int kw = 0; kw < KW; ++kw) {
#if USE_KER
                acc_data_t dw = ker(g, oc, ic, kd, kh, kw);
#else
                acc_data_t dw {0};
                { // nc++ full hoist (vectorization workaround)
                    int odlo, odhi, ohlo, ohhi, owlo, owhi;
                    hoist_ApiB(odlo,odhi, 0,OD, kd*KDD-padFront,KSD,  0,ID  );
                    hoist_ApiB(ohlo,ohhi, 0,OH, kh*KDH-padT,    KSH,  0,IH  );
                    hoist_ApiB(owlo,owhi, 0,OW, kw*KDW-padL,    KSW,  0,IW  );
                    NOVEC for_(int mb = 0; mb < MB; ++mb)
                    NOVEC for_(int od = odlo; od < odhi; ++od)
                    NOVEC for_(int oh = ohlo; oh < ohhi; ++oh)
                    NOVEC for (int ow = owlo; ow < owhi; ++ow) {
                        int const id = od * KSD - padFront + kd * KDD; // in [0,ID)
                        int const ih = oh * KSH - padT     + kh * KDH; // in [0,IH)
                        int const iw = ow * KSW - padL     + kw * KDW; // in [0,IW)
                        //assert( id >= 0 && id < ID
                        //     && ih >= 0 && ih < IH
                        //     iw >=0 && iw < IW );
                        auto const dd_off = off_abx(diff_dst_d, 0, mb, g*OC+oc,
                                od, oh, ow);
                        auto const src_off = off_abx(src_d, 0, mb, g*IC+ic,
                                id, ih, iw);
                        assert( src_off >= 0 && src_off < src_d.nelems() );
                        dw += (acc_data_t)diff_dst[dd_off] * src[src_off];
                    }
                }
#endif
                auto const dw_val = cvt_wei::rs(dw);
                const dim_t dw_off = off_gabx(diff_weights_d, g, oc, ic,
                        kd, kh, kw);
                diff_weights[dw_off] = dw_val;
            }
        });
    }
}

using namespace data_type;
template struct ref_convolution_bwd_weights_t<f32, f32, f32, f32>;
template struct ref_convolution_bwd_weights_t<bf16, bf16, bf16, f32>;
template struct ref_convolution_bwd_weights_t<bf16, f32, bf16, f32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl
#endif // use this file?
// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
