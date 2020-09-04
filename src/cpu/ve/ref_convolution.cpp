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

#define FWD_IMPL 4
// errors:
// 0 : rconv-0.log OK, mistrusted 3 of conv.in mode=C Real Time 17.934
// 1 : rconv-1.log seg fault in --conv g32ic32ih112oc32oh112kh3ph1n"mobilenet:conv2_1/dw"
// 1 : rconv-1.log OK RTime 15.98 s
// 2 : rconv-2.log OK 15.72 s
// 3 : rconv-3.log OK 15.43 s
// 4 : rconv-4.log OK 15.23 s
#define ELT_SCALAR (FWD_IMPL>=3)
// conv-gemm.in
// gemm :       190,213,145,265 (191,194,120)
//   add --skip-impl=gemm to run ref impls?
//   NO. comment them out in cpu_convolution_list.cpp
//   Perhaps benchdnn should use iterator api to continue trying
//   to find a non-skipped impl.
//
//   Cannot skip gemm convolution and still run the ref impl (lower) !)
// conv.in (much smaller tests when no gemm impl present)
// -1 : 48.5984 75.4461 68.4999 107.548 31.2228 24.5472 25.612  24.4907 203.698
//  0 : 48.6771 84.7707 87.7413 108.005 40.8471 24.7904 25.6382 24.2934 215.264
//  1 : xx.5149 51.7053 43.977  73.167  39.4347 18.7586 18.9639 18.6456 132.379
//  2 : 32.7245 40.2169 38.188  63.3137 36.6195 16.373  16.5362 16.4141 102.588
//  3 : 31.4836 38.6193 31.9966 59.813  32.5218 15.7574 15.9223 15.7973 95.3827
//  --- add a FWD_D test
//  3 : 31.3331 38.3888 31.7553 59.4035 59.3386 32.1725 15.4924 15.4991 15.491 92.2239
//  4 : 30.8901 37.9487 31.4165 58.203 58.1731 32.5846 15.2864 15.2907 15.2818 89.9907
// 4 : 30.9838 39.6846 32.9677 58.3858 58.3249 32.5824 15.3221 15.3263 15.3218 89.7068
// fix test_convolution_forward_u8s8s32 and test_convolution_eltwise_forward_x8s8f32s32 bugs
// for "most advanced" of each impl ...
#if FWD_IMPL==-1
#include "cpu/ve/ref_convolution_fwd_orig.ipp"
#else

#include "cpu/ve/ref_convolution_util.hpp"
#include "cpu/ve/hoist.hpp"     // nc++: hoist linear conditions out of loops
#include <iostream> // tmp debug


#if FWD_IMPL>0
#include "common/ve/memory_desc_wrapper_opt.hpp"
#define LISTVEC PragmaQuote(_NEC list_vector)
#endif // FWD_IMPL

#define VFOR(VAR,LIM) ShortLoop() for(int VAR = 0; VAR < LIM; ++VAR)
#define PRAG(...) PragmaQuote(_NEC __VA_ARGS__)

namespace dnnl {
namespace impl {
namespace cpu {

using math::get_bias;

#if FWD_IMPL>0
typedef CoordsForNd<6,uint64_t,uint64_t> Coords;

// let's use 32-bit Crd (Pos can still be u64)
// oh. Pos u64 stilll required by memory_desc_wrapper_opt
typedef CoordsForNd<6,uint32_t,int64_t> Coords32;
// src-pixel coords (mb,oc,id,ih,iw when they are valid)

// When you don't need a full iterator (bkwd max-pool)
typedef memory_desc_wrapper_opt::VecPos32 VecPos32;
// a.k.a. CoordRegs<uint32_t, 6>,
// cast to int32_t* sometimes avoids VE conversion nonsense
#endif

//namespace {

#if 0
template <typename dst_data_t> inline
void maybe_postops_vec(
        float *d, dst_data_t const *dst_value, int const dvl,
        post_ops_t const& ops,
        ref_eltwise_scalar_fwd_t * const eltwises_[dnnl_post_ops::capacity]
        )
{
    //printf(" eltwise_@%p\n", (void*)eltwises_);
#if 0 //
    NOVEC for (int i=0; i<dvl; ++i) {
        NOVEC for (int idx = 0; idx < ops.len_; ++idx) {
            const auto &e = ops.entry_[idx];
            if (e.kind == dnnl_sum) {
                d[i] += e.sum.scale * dst_value[i];
            } else {
                dst_data_t const dst_val = dst_value[i];
                float a = d[i];
                a = eltwises_[idx]->compute_scalar(a);
                d[i] = a;
            }
        }
    }
#elif 1 //
        NOVEC PRAG(unroll(dnnl_post_ops::capacity))//;
        for (int idx = 0; idx < ops.len_; ++idx) {
            const auto &e = ops.entry_[idx];
            if (e.kind == dnnl_sum) {
                VFOR(i,dvl) {
                    d[i] += e.sum.scale * dst_value[i];
                }
            } else {
                VFOR(i,dvl) {
                    d[i] = eltwises_[idx]->compute_scalar(d[i]);
                }
            }
        }
#endif
};
#endif

//}//anon::

template <data_type_t src_type, data_type_t wei_type, data_type_t dst_type,
        data_type_t acc_type>
void ref_convolution_fwd_t<src_type, wei_type, dst_type,
        acc_type>::execute_forward(const exec_ctx_t &ctx) const {
    //printf("\nFWD_IMPL=%d\n", (int)FWD_IMPL); fflush(stdout);
    auto src = CTX_IN_MEM(const src_data_t *, DNNL_ARG_SRC);
    auto weights = CTX_IN_MEM(const wei_data_t *, DNNL_ARG_WEIGHTS);
    auto bias = CTX_IN_MEM(const char *, DNNL_ARG_BIAS);
    auto dst = CTX_OUT_MEM(dst_data_t *, DNNL_ARG_DST);

    typedef typename ref_convolution_fwd_t<src_type, wei_type, dst_type,
            acc_type>::pd_t mypd_t;
    mypd_t const* mypd = pd();

    // debug mem corruption?
    //assert( src );
    //assert( weights );
    //assert( dst );
    //assert( mypd != nullptr );
    //assert( mypd->attr() != nullptr );

    const memory_desc_wrapper src_d(mypd->src_md());
    const memory_desc_wrapper dst_d(mypd->dst_md());
    const memory_desc_wrapper weights_d(mypd->weights_md(0));
    const memory_desc_wrapper bias_d(mypd->weights_md(1));

    const bool with_groups = mypd->with_groups();

    const int G = mypd->G();
    const int MB = mypd->MB();
    const int OD = mypd->OD();
    const int OH = mypd->OH();
    const int OW = mypd->OW();
    const int ID = mypd->ID();
    const int IH = mypd->IH();
    const int IW = mypd->IW();

    const int OCxG = mypd->OC();        // all channels
    const int ICxG = mypd->IC();
    const int OC = OCxG / G;            // channels per group
    const int IC = ICxG / G;
    printf(" g%dic%doc%d IC,OC(per group)=%d,%d\n", G,ICxG,OCxG, IC,OC);
    const int KD = mypd->KD();
    const int KH = mypd->KH();
    const int KW = mypd->KW();

    const int KSD = mypd->KSD();
    const int KSH = mypd->KSH();
    const int KSW = mypd->KSW();

    const int KDD = mypd->KDD() + 1;
    const int KDH = mypd->KDH() + 1;
    const int KDW = mypd->KDW() + 1;

    const int padFront = mypd->padFront();
    const int padT = mypd->padT();
    const int padL = mypd->padL();

    const int ndims = mypd->desc()->src_desc.ndims;

    using namespace data_type;
    bool constexpr is_int_conv = utils::one_of(src_type, s32, s8, u8);

    // scale_idx_mult = 1 for per_oc scales and 0, otherwise
    const int scale_idx_mult
            = mypd->attr()->output_scales_.mask_ == (1 << 1);
    const float *scales = mypd->attr()->output_scales_.scales_;

#if FWD_IMPL<=1
    auto maybe_oscale = [=](float &d, int g, int oc) {
        const int scale_idx_mult
                = mypd->attr()->output_scales_.mask_ == (1 << 1);
        const float *scales = mypd->attr()->output_scales_.scales_;
        // scale_idx_mult = 1 for per_oc scales and 0, otherwise
        d *= scales[(g * OC + oc) * scale_idx_mult];
    };
#endif

    const post_ops_t& ops = mypd->attr()->post_ops_;

#if FWD_IMPL<=2
    auto maybe_postops = [&](float &d, dst_data_t const dst_value) {
        // Sum and post ops:
        NOVEC for (int idx = 0; idx < ops.len_; ++idx) {
            const auto &e = ops.entry_[idx];
            if (e.kind == dnnl_sum)
                d += e.sum.scale * dst_value;
            else
                d = eltwises_[idx]->compute_scalar(d);
        }
    };
#endif

#if FWD_IMPL>=2
    auto maybe_postops_vec2 = [&](float *d, dst_data_t const *dst_value, int const dvl) {
        NOVEC //;PRAG(unroll(dnnl_post_ops::capacity))//;
        for (int idx = 0; idx < ops.len_; ++idx) {
            const auto &e = ops.entry_[idx];
            if (e.kind == dnnl_sum) {
                VFOR(i,dvl) {
                    d[i] += e.sum.scale * dst_value[i];
                }
            } else {
                VFOR(i,dvl) {
                    d[i] = eltwises_[idx]->compute_scalar(d[i]);
                }
            }
        }
    };
#endif

#if FWD_IMPL>=3
    auto maybe_postops_vec3 = [&](float *a, float const *dst_float, int const dvl) {
        NOVEC //;PRAG(unroll(dnnl_post_ops::capacity))//;
        for (int idx = 0; idx < ops.len_; ++idx) {
            const auto &e = ops.entry_[idx];
            if (e.kind == dnnl_sum) {
                VFOR(i,dvl) {
                    a[i] += e.sum.scale * dst_float[i];
                }
            } else {
#if 0 //orig
                VFOR(i,dvl) {
                    a[i] = eltwises_[idx]->compute_scalar(a[i]);
                }
#elif 1 //new BUGGY sometimes
                eltwises_[idx]->compute_vec_reg(a, a, dvl);
                //using cvt = Cvt<data_t, is_int_dt>; // postops are pure-float!
#else
                float tmp[MVL];
                eltwises_[idx]->compute_vec_reg(tmp, a, dvl);
                VFOR(i,dvl) a[i] = tmp[i];
#endif
            }
        }
    };
#endif

    // Sum and post ops:

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

    // pooling has a more advanced "iterate over source pre-image tile" method TODO
    auto ker_plain = [&](int const g, int const mb, int const oc, int const od, int const oh, int const ow) {
        assert(3 <= ndims && ndims <= 5);
        acc_data_t d = 0;
        const src_data_t * __restrict src_loc;
        const wei_data_t * __restrict weights_loc;
        {
            const dim_t src_loc_off = off_abx(src_d, 0, mb, g * IC, 0, 0, 0);
            src_loc = src + src_loc_off;
            const dim_t weights_loc_off = off_abxg(weights_d, g, oc, 0, 0, 0, 0);
            weights_loc = weights + weights_loc_off;
        }
        assert(  g >= 0 &&  g <  G );
        assert( mb >= 0 && mb < MB );
        assert( oc >= 0 && oc < OC );
        assert( od >= 0 && od < OD );
        assert( oh >= 0 && oh < OH );
        assert( ow >= 0 && ow < OW );

        if (IC > KW) {
            for_(dim_t kd = 0; kd < KD; ++kd)
            for_(dim_t kh = 0; kh < KH; ++kh)
            for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                //if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                //        || iw >= IW)
                //    continue;
                if (id < 0 || id >= ID) continue;
                if (ih < 0 || ih >= IH) continue;
                if (iw < 0 || iw >= IW) continue;
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
            NOVEC for_(dim_t ic = 0; ic < IC; ++ic)
            NOVEC for_(dim_t kd = 0; kd < KD; ++kd)
            NOVEC for_(dim_t kh = 0; kh < KH; ++kh)
            //NOVEC // REQUIRED for VE to avoid [some, NOT ALL] segfaults :(
            NOVEC for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                //if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                //        || iw >= IW)
                //    continue;
                if (id < 0 || id >= ID) continue;
                if (ih < 0 || ih >= IH) continue;
                if (iw < 0 || iw >= IW) continue;
                asm("###"); // this too is required to avoid segfaultj
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

#if FWD_IMPL > 0 // common "iterator" setup
    // 32-bit coordinate ranges, 64-bit logical/physical offsets
    auto elems = (size_t)MB * OCxG * OD * OH * OW;
    auto dst_dopt = memory_desc_wrapper_opt(dst_d.md_);
    auto bias_dopt = memory_desc_wrapper_opt(
            bias? bias_d.md_: dst_d.md_/*useless*/);
#if FWD_IMPL==1
#warning "ref_convolution FWD_IMPL==1"
    auto kern1 = [&](int ithr, int nthr) {
#define DBG 0
#define TRY_DST_VEC 1
        // 0 ~ plain    321.204 523.636 447.257 682.423 | 309.768 162.354 162.404 212.127
        // 1 ~ gather   319.689 521.018 444.751 671.041 | 309.212 160.44  160.544 207.727
#define TRY_BIAS_VEC 2
        // oh. add maybe_oscale tests too...
        // 0 ~ scalar 326.504 522.053 444.163 688.857 | 306.638 163.79  171.25 163.849 215.869
        // 1 ~ vec    281.155 391.514 301.232 559.445 | 259.027 142.872 148.047 144.122 171.174
        // 2 ~ maybe_oscale inline
        //            281.457 391.432 300.939 559.421 | 259.063 142.84 148.035 144.144 171.229
        //              (no effect)
        // Remeasure DST,BIAS settings with force_sequential==0:
        // 0,0  40.8026 63.6244 51.8002 84.347  | 34.649  20.951  21.8545 21.3542 28.1471
        // 1,0  40.8036 63.6164 51.768  85.2347 | 34.8757 20.9518 21.8531 21.3536 28.1453
        // 1,1  37.0265 51.8556 42.2909 74.5562 | 40.5033 18.7342 19.2446 18.8925 23.1774
        // 1,2  36.9422 51.8987 42.3375 74.7361 | 40.4855 18.7346 19.243  18.8942 23.1237
        size_t start, end;
        balance211(elems, nthr, ithr, start, end);
        auto const dm = dst_d.ndims(); // MB, OCxG, OD?, OH?, OW
        assert( dm >= 3 && dm <= 5 );

        Coords32 dcrd(dst_dopt.dims(), dm, start, end);
        // vectorized phys-offset calc, & gather
        if(0) std::cout<<" fwd-conv "<<dcrd.lim_str("dcrd")<<"  "<<dcrd.coord_str("dcrd")<<std::endl;
        // VE code is horrible when mixing int/int32 ops:
        int const* const restrict dcrd_outer0 = reinterpret_cast<int const*>
                (&dcrd.vp[0][0]); 
        //int const* const dcrd_space0 = reinterpret_cast<int const*>
        //        (&dcrd.vp[2][0]);

        NOVEC for ( ; dcrd; ++dcrd) { // in vec-length chunks of dst coords
            int const dvl = dcrd.get_vl();

            dim_t dst_off[MVL];
            dst_dopt.vec_off_v(dcrd.base(), &dst_off[0], dvl, false/*pad*/);

#if TRY_BIAS_VEC>0
            // corresponding chunk of bias_off[] TODO
            // bias "coord" is the 1-D set of dcrd.vp[1][i] "OCxG" values.
            // Just copy them into a VecPos32 and use low-level offset calc.
            dim_t bias_off[MVL];
            if (bias) {
                VecPos32 bias_vp; 
                assert( bias_d.ndims() == 1 );
                ShortLoop() for (int i=0; i<dvl; ++i) {
                    // copy dimension 1 of dcrd --> 1-D bias coord in [0,OCxG)
                    bias_vp.vp[0][i] = (dcrd_outer0 + 1 * MVL)[i];
                }
                // vectorized bias_off calc for this chunk of output coords
                bias_dopt.vec_off_vtmp(bias_vp, &bias_off[0],
                        dvl, false/*pad*/);
            }
#endif // TRY_BIAS_VEC

#if DBG
            {
                int errs = 0;
                for (int i=0; i<dvl; ++i) {
                    int const* dcrd_i = dcrd_outer0 + i;
                    int const mb = dcrd_i[0];
                    int const ocxg = dcrd_i[MVL];
                    int const  g = ocxg / OC;
                    int const oc = ocxg % OC;
                    // spatial coords:
                    dcrd_i += MVL; // coord one before spatial
                    int const od = (dm >= 5? *(dcrd_i+=MVL): 0);
                    int const oh = (dm >= 4? *(dcrd_i+=MVL): 0);
                    int const ow = *(dcrd_i+=MVL);
                    auto dst_off_ref = off_abx(dst_d, 0, mb, g * OC + oc, od, oh, ow);
                    if (dst_off[i] != dst_off_ref) {
                        printf("error: i=%d mb=%d g,oc,ocxg=%d,%d,%d od,oh,ow=%d,%d,%d\n",
                                i, mb, g,oc,ocxg, od,oh,ow);
                        if (++errs > 10) break;
                    }
                }
                assert(errs == 0);
            }
#endif

#if TRY_DST_VEC>0
            dst_data_t dst_gather[MVL];
            for (int i=0; i<dvl; ++i) {
                dst_gather[i] = dst[dst_off[i]];
            }
#endif

            for (int i=0; i<dvl; ++i) {
                int const* dcrd_i = dcrd_outer0 + i;
                int const mb = dcrd_i[0];
                int const ocxg = dcrd_i[MVL];
                // nb: dcrd "OCxG" coord --> g and oc decomposition
                int const  g = ocxg / OC;
                int const oc = ocxg % OC;
                // spatial coords:
                dcrd_i += MVL; // coord one before spatial
                int const od = (dm >= 5? *(dcrd_i+=MVL): 0);
                int const oh = (dm >= 4? *(dcrd_i+=MVL): 0);
                int const ow = *(dcrd_i+=MVL);

#if TRY_BIAS_VEC==0
                float a = (bias ? get_bias(bias, bias_d.off(ocxg),
                            mypd->desc()->bias_desc.data_type)
                        : 0);
#else
                float a = (bias ? get_bias(bias, bias_off[i],
                            mypd->desc()->bias_desc.data_type)
                        : 0);
#endif

                if (src_d.is_plain() && weights_d.is_plain()
                        && src_ic_stride == 1 && weights_kw_stride == 1)
                    a += ker_plain(g, mb, oc, od, oh, ow);
                else
                    a += ker(g, mb, oc, od, oh, ow);

                // TODO: break loop HERE, using float a[MVL].
                //      vectorize maybe_oscale & maybe_postops
                //       ? check if maybe_oscale does anything ?
                //       ? inline maybe_postops ?
                // NB: need vector version of eltwises_ !!

#if DBG
                const dim_t dst_off_ref = off_abx(dst_d, 0, mb, g * OC + oc, od, oh, ow);
                assert( dst_off_ref == dst_off[i] );
#endif

#if TRY_DST_VEC<2
                maybe_oscale(a, g, oc);
#else
                //a *= scales[(g * OC + oc) * scale_idx_mult];
                a *= scales[ocxg * scale_idx_mult];
#endif

#if TRY_DST_VEC==0
                maybe_postops(a, dst[dst_off[i]]);
#else
                maybe_postops(a, dst_gather[i]);
#endif

                using cvt_dst = Cvt<dst_data_t, is_int_conv>;
#if TRY_DST_VEC==0
                dst[dst_off[i]] = cvt_dst::qs(a);
#else
                dst_gather[i] = cvt_dst::qs(a);
#endif
            }
#if TRY_DST_VEC>0
            for (int i=0; i<dvl; ++i) { // scatter
                dst[dst_off[i]] = dst_gather[i];
            }
#endif
        }
    };
#elif FWD_IMPL==2
#warning "ref_convolution FWD_IMPL==2"
    auto kern2 = [&](int ithr, int nthr) {
#define DBG 0
#define VEC_CRD 2
        // 0 same as FWD_IMPL==2 otions 1,2
        //0 36.1292 53.2327 46.5454 72.4565 | 44.0839 18.3425 18.8063 18.4794 22.2922
        // 0+dbg  (~same)
        //1 33.9768 47.1865 39.7339 66.9513 | 33.1597 17.9555 17.6643 17.6145 21.5073
        //  33.9777 47.1926 39.7299 66.9484 | 33.1676 17.956  17.6644 17.6152 21.4942
        //2 33.1341 42.588  37.9946 64.5071 | 34.757  16.6386 16.8067 16.6719 18.6816
        size_t start, end;
        balance211(elems, nthr, ithr, start, end);
        auto const dm = dst_d.ndims(); // MB, OCxG, OD?, OH?, OW
        assert( dm >= 3 && dm <= 5 );

        Coords32 dcrd(dst_dopt.dims(), dm, start, end);
        // vectorized phys-offset calc, & gather
        if(0) std::cout<<" fwd-conv "<<dcrd.lim_str("dcrd")<<"  "<<dcrd.coord_str("dcrd")<<std::endl;
        // VE code is horrible when mixing int/int32 ops:
        int const* const restrict dcrd_outer0 = reinterpret_cast<int const*>
                (&dcrd.vp[0][0]); 
        //int const* const dcrd_space0 = reinterpret_cast<int const*>
        //        (&dcrd.vp[2][0]);

        NOVEC for ( ; dcrd; ++dcrd) { // in vec-length chunks of dst coords
            auto const dvl = dcrd.get_vl();

            dim_t dst_off[MVL];
            dst_dopt.vec_off_v(dcrd.base(), &dst_off[0], dvl, false/*pad*/);

            dim_t bias_off[MVL];
            if (bias) {
                // bias "coord" is the 1-D set of dcrd.vp[1][i] "OCxG" values.
                // Just copy them into a VecPos32 and use low-level offset calc.
                VecPos32 bias_vp; 
                assert( bias_d.ndims() == 1 );
                ShortLoop() for (int i=0; i<dvl; ++i) {
                    // copy dimension 1 of dcrd --> 1-D bias coord in [0,OCxG)
                    bias_vp.vp[0][i] = (dcrd_outer0 + 1 * MVL)[i];
                }
                // vectorized bias_off calc for this chunk of output coords
                bias_dopt.vec_off_vtmp(bias_vp, &bias_off[0],
                        dvl, false/*pad*/);
            }

#if VEC_CRD>0 || (VEC_CRD==0 && DBG)
            int dim_zeros[MVL];
            for (int i=0; i<dvl; ++i) dim_zeros[i] = 0;
            int v_g[MVL];
            int v_oc[MVL];
            // transform scalar loads of mb, ocxg, g, oc, od, oh, ow
            // into vectorized pre-loop pseudo-register settings
            /** Suggestive mnemonic for possible vector registers.
             * point to individual vector coordinate pseudo-register content.
             * Inner loops calling functions will force these to be backed by
             * real memory, but jit impl would avoid such spillage. */
//#define COORD_VEC_REGISTER(VAR, ...) \
//            int const (*VAR)[MVL] \
//                = (int const (*)[MVL]) (__VA_ARGS__)
// However, nc++ does not allow array variable initialization as pointer cast
// (Does work as func arg though, as in C)
            typedef int const *coord_register_t;
#define COORD_VEC_REGISTER(VAR, ...) coord_register_t VAR = (__VA_ARGS__)
            auto dcrd_i = dcrd_outer0;
            COORD_VEC_REGISTER(v_mb, dcrd_i);
            COORD_VEC_REGISTER(v_ocxg, dcrd_i + MVL);
            dcrd_i += MVL; // point 1 dim before spatial coords
            COORD_VEC_REGISTER(v_od, (dm >= 5? (dcrd_i+=MVL): dim_zeros));
            COORD_VEC_REGISTER(v_oh, (dm >= 4? (dcrd_i+=MVL): dim_zeros));
            COORD_VEC_REGISTER(v_ow, dcrd_i+=MVL); // always exists, dm >= 3
            for (int i=0; i<dvl; ++i) {
                v_g[i] = v_ocxg[i] / OC;
                v_oc[i] = v_ocxg[i] % OC;
            }
#endif

            dst_data_t dst_gather[MVL];
            for (int i=0; i<dvl; ++i) {
                dst_gather[i] = dst[dst_off[i]];
            }
#if VEC_CRD==0
            for (int i=0; i<dvl; ++i) {
                int const* dcrd_i = dcrd_outer0 + i;
                int const mb = dcrd_i[0];
                int const ocxg = dcrd_i[MVL];
                // nb: dcrd "OCxG" coord --> g and oc decomposition
                int const  g = ocxg / OC;
                int const oc = ocxg % OC;
                // spatial coords:
                dcrd_i += MVL; // coord one before spatial
                int const od = (dm >= 5? *(dcrd_i+=MVL): 0);
                int const oh = (dm >= 4? *(dcrd_i+=MVL): 0);
                int const ow = *(dcrd_i+=MVL);

#if DBG
                assert( v_mb[i] == mb );
                assert( v_ocxg[i] == ocxg );
                assert( v_g[i] == g );
                assert( v_oc[i] == oc );
                assert( v_od[i] == od );
                assert( v_oh[i] == oh );
                assert( v_ow[i] == ow );
#endif
                float a = (bias ? get_bias(bias, bias_off[i],
                            mypd->desc()->bias_desc.data_type)
                        : 0);

                if (src_d.is_plain() && weights_d.is_plain()
                        && src_ic_stride == 1 && weights_kw_stride == 1)
                    a += ker_plain(g, mb, oc, od, oh, ow);
                else
                    a += ker(g, mb, oc, od, oh, ow);

                // TODO: break loop HERE, using float a[MVL].
                //      vectorize maybe_oscale & maybe_postops
                //       ? check if maybe_oscale does anything ?
                //       ? inline maybe_postops ?
                // NB: need vector version of eltwises_ !!

                //maybe_oscale(a, g, oc);
                //a *= scales[(g * OC + oc) * scale_idx_mult];
                a *= scales[ocxg * scale_idx_mult];

                maybe_postops(a, dst_gather[i]);

                using cvt_dst = Cvt<dst_data_t, is_int_conv>;
                dst_gather[i] = cvt_dst::qs(a);
            }
#elif VEC_CRD==1
            for (int i=0; i<dvl; ++i) {
                float a = (bias ? get_bias(bias, bias_off[i],
                            mypd->desc()->bias_desc.data_type)
                        : 0);

                if (src_d.is_plain() && weights_d.is_plain()
                        && src_ic_stride == 1 && weights_kw_stride == 1)
                    a += ker_plain(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
                else
                    a += ker(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);

                // TODO: break loop HERE, using float a[MVL].
                //      vectorize maybe_oscale & maybe_postops
                //       ? check if maybe_oscale does anything ?
                //       ? inline maybe_postops ?
                // NB: need vector version of eltwises_ !!

                //maybe_oscale(a, g, oc);
                //a *= scales[(g * OC + oc) * scale_idx_mult];
                a *= scales[v_ocxg[i] * scale_idx_mult];

                maybe_postops(a, dst_gather[i]);

                using cvt_dst = Cvt<dst_data_t, is_int_conv>;
                dst_gather[i] = cvt_dst::qs(a);
            }
#elif VEC_CRD==2
            float a[MVL];
            if (bias) {
                auto const bias_data_type = mypd->desc()->bias_desc.data_type;
                ShortLoop() for (int i=0; i<dvl; ++i)
                    a[i] = get_bias(bias, bias_off[i], bias_data_type);
            } else {
                ShortLoop() for (int i=0; i<dvl; ++i)
                    a[i] = 0.f;
            }
            ShortLoop() for (int i=0; i<dvl; ++i) {
                if (src_d.is_plain() && weights_d.is_plain()
                        && src_ic_stride == 1 && weights_kw_stride == 1)
                    a[i] += ker_plain(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
                else
                    a[i] += ker(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
            }

            //maybe_oscale(a, g, oc);
            //a *= scales[(g * OC + oc) * scale_idx_mult];
            ShortLoop() for (int i=0; i<dvl; ++i) // vec
                a[i] *= scales[v_ocxg[i] * scale_idx_mult];

#if 0
            // 33.1433 42.5974 38.0082 64.504 34.7634 16.6391 16.8048 16.6713 106.409
            ShortLoop() for (int i=0; i<dvl; ++i) { // novec
                maybe_postops(a[i], dst_gather[i]);
            }
#elif 0 // expand the lambda
            // 33.3003 44.3341 34.5492 64.9665 36.8885 16.7248 16.8914 16.7544 107.789
            NOVEC ShortLoop() for (int i=0; i<dvl; ++i) {
                NOVEC for (int idx = 0; idx < ops.len_; ++idx) {
                    const auto &e = ops.entry_[idx];
                    if (e.kind == dnnl_sum)
                        a[i] += e.sum.scale * dst_gather[i];
                    else
                        a[i] = eltwises_[idx]->compute_scalar(a[i]);
                }
            }
#elif 0 // move vector loop in, conditional out :
            // 34.5431 46.0956 36.6813 68.0721 41.0491 17.1908 17.3588 17.2288 112.347
            // 34.5444 46.104 36.6893 68.0784 41.0519 17.1936 17.3611 17.2285 112.352
            NOVEC PRAG(unroll(dnnl_post_ops::capacity))//;
            for (int idx = 0; idx < ops.len_; ++idx) {
                const auto &e = ops.entry_[idx];
                if (e.kind == dnnl_sum) {
                    VFOR(i,dvl) a[i] += e.sum.scale * dst_gather[i];
                } else { // still unvec...
                    VFOR(i,dvl) a[i] = eltwises_[idx]->compute_scalar(a[i]);
                }
            }
#else
            // 33.572 46.6966 34.5849 65.733 39.2344 16.7971 16.9612 16.8291 107.548
            // 33.5794 46.6989 34.4488 65.676 39.2319 16.7932 16.9586 16.8314 107.6
            //maybe_postops_vec(a, dst_gather, dvl, ops, this->eltwises_);
            // 32.7192 40.2176 38.1839 63.3171 36.6173 16.3757 16.5399 16.4139 102.625
            // 32.7252 40.2222 38.1701 63.3176 36.6168 16.3745 16.5364 16.4146 102.601 
            maybe_postops_vec2(a, dst_gather, dvl);
#endif
            ShortLoop() for (int i=0; i<dvl; ++i) { //vec
                using cvt_dst = Cvt<dst_data_t, is_int_conv>;
                dst_gather[i] = cvt_dst::qs(a[i]);
            }
#else
#error "VEC_CRD to be done"
#endif
            for (int i=0; i<dvl; ++i) { // scatter
                dst[dst_off[i]] = dst_gather[i];
            }
        }
    };
#elif FWD_IMPL==3
#warning "ref_convolution FWD_IMPL==3"
    auto const bias_data_type = mypd->desc()->bias_desc.data_type;
    if (bias) assert( bias_data_type == data_type::s8
            || bias_data_type == data_type::u8
            || bias_data_type == data_type::s32
            || bias_data_type == data_type::f32);
    else assert( bias_data_type == data_type::undef );
    auto kern3 = [&](int ithr, int nthr) {
        // 1 0 2 had a bug in test_convolution_forward_u8s8s32
#define OPT 1
#define OPTx 0
#define OPTb 2
        //0 : 32.7361 43.3405 34.1239 63.0885 32.5495 16.3621 16.527  16.4015 102.718
        //1 : 31.4836 38.6193 31.9966 59.813 32.5218 15.7574 15.9223 15.7973 95.3827
        //  : 31.4821 38.6191 31.9966 59.8161 32.5977 15.7581 15.9239 15.7982 95.3821
        //  : 31.4858 38.6194 31.9952 59.8086 32.5793 15.7572 15.9227 15.798 95.3642
        //1x: 32.9435 43.0106 33.6597 63.2534 32.855 16.346 16.557 16.4326 103.161
        //    32.212 41.9858 34.2578 61.8911 32.6914 16.1272 16.2886 16.1622 99.6881
        //    32.2111 41.9832 34.2584 61.866 32.6232 16.1219 16.2834 16.1595 99.6254
        //2 : 32.3051 41.8717 34.0609 62.1326 32.677 16.1713 16.3332 16.2089 100.276
        //    31.4576 38.5397 31.7452 59.4827 31.9314 15.6437 15.7981 15.6827 94.2623 (float[] tmp)
        //    31.4569 38.5441 31.7429 59.4799 31.9414 15.6887 15.8483 15.7256 94.8569
        //2x: xxxx 32.7346 43.316 34.1261 63.0803 32.5479 16.3638 16.5284 16.4005 102.722
        //    31.7093 39.5492 32.4717 60.1338 32.7817 15.7927 15.9609 15.8336 95.8761
        //---------------------------------------------
        //1  : 31.8091 39.1734 32.5202 60.4456 59.774 32.6867 15.8667 16.0269 15.9022 96.7785
        //compute_scalar --> compute_vec_reg
        //1  : 31.8089 39.1765 32.5195 60.4395 59.7695 32.686 15.6778 15.6871 15.6779 94.4842
        //1b : 31.8773 39.2112 32.5576 60.9185 60.2438 32.7996 15.7669 15.7766 15.7684 95.4458
        //1b2: 31.3331 38.3888 31.7553 59.4035 59.3386 32.1725 15.4924 15.4991 15.491 92.2239
        size_t start, end;
        balance211(elems, nthr, ithr, start, end);
        auto const dm = dst_d.ndims(); // MB, OCxG, OD?, OH?, OW
        assert( dm >= 3 && dm <= 5 );

        Coords32 dcrd(dst_dopt.dims(), dm, start, end);
        // avoid mixing unsigned and int ops VE
        int const* const restrict dcrd_outer0 = reinterpret_cast<int const*>
                (&dcrd.vp[0][0]); 

        NOVEC for ( ; dcrd; ++dcrd) { // in vec-length chunks of dst coords
            int const dvl = dcrd.get_vl();

#if OPT==0 || OPT==1
            dim_t dst_off[MVL]; // vectorized phys-offset calc
            dst_dopt.vec_off_v(dcrd.base(), &dst_off[0], dvl, false/*pad*/);
#endif

#if OPTb==0
            dim_t bias_off[MVL];
            {
                // bias "coord" is the 1-D set of dcrd.vp[1][i] "OCxG" values.
                // Just copy them into a VecPos32 and use low-level offset calc.
                VecPos32 bias_vp; 
                if(bias) assert( bias_d.ndims() == 1 );
                ShortLoop() for (int i=0; i<dvl; ++i) {
                    // copy dimension 1 of dcrd --> 1-D bias coord in [0,OCxG)
                    bias_vp.vp[0][i] = (dcrd_outer0 + 1 * MVL)[i];
                }
                // vectorized bias_off calc for this chunk of output coords
                bias_dopt.vec_off_vtmp(bias_vp, &bias_off[0],
                        dvl, false/*pad*/);
            }
#endif

            int dim_zeros[MVL];
            VFOR(i,dvl) dim_zeros[i] = 0;
            int v_g[MVL];
            int v_oc[MVL];
            typedef int const *coord_register_t;
            // transform scalar loads of mb, ocxg, g, oc, od, oh, ow
            // into vectorized pre-loop pseudo-register settings
            /* Suggestive mnemonic for possible vector registers.
             * point to individual vector coordinate pseudo-register content.
             * Inner loops calling functions will force these to be backed by
             * real memory, but jit impl would avoid such spillage. */
//#define COORD_VEC_REGISTER(VAR, ...) int const (*VAR)[MVL] = (int const (*)[MVL]) (__VA_ARGS__)
// disallowed: array variable initialization as pointer cast (ok for fn args, though)
#define COORD_VEC_REGISTER(VAR, ...) coord_register_t VAR = (__VA_ARGS__)
            auto dcrd_i = dcrd_outer0;
            COORD_VEC_REGISTER(v_mb, dcrd_i);
            dcrd_i += MVL; // also 1 dim before spatial coords
            COORD_VEC_REGISTER(v_ocxg, dcrd_i);
            COORD_VEC_REGISTER(v_od, (dm >= 5? (dcrd_i+=MVL): dim_zeros));
            COORD_VEC_REGISTER(v_oh, (dm >= 4? (dcrd_i+=MVL): dim_zeros));
            COORD_VEC_REGISTER(v_ow, dcrd_i+=MVL); // always exists, dm >= 3
            VFOR(i,dvl) {
                v_g[i] = v_ocxg[i] / OC;
                v_oc[i] = v_ocxg[i] % OC;
            }

#if OPT==0
            dst_data_t dst_gather[MVL]; // gather dst values (MIGHT be used for post_ops)
            VFOR(i,dvl) dst_gather[i] = dst[dst_off[i]];
#endif
#if OPT==1
            // actually compute_scalar operates on float input
            // and ops.entry_[idx].sum.scale is also float
            // so convert to float right away
            float dst_gather[MVL]; // gather dst values (MIGHT be used for post_ops)
            VFOR(i,dvl) dst_gather[i] = dst[dst_off[i]];
#endif
            float a[MVL];
            if (bias) {
#if OPTb>=1
                dim_t bias_off[MVL];
                {
                    // bias "coord" is the 1-D set of dcrd.vp[1][i] "OCxG" values.
                    // Just copy them into a VecPos32 and use low-level offset calc.
                    VecPos32 bias_vp; 
                    assert( bias_d.ndims() == 1 );
                    ShortLoop() for (int i=0; i<dvl; ++i) {
                        // copy dimension 1 of dcrd --> 1-D bias coord in [0,OCxG)
                        bias_vp.vp[0][i] = (dcrd_outer0 + 1 * MVL)[i];
                    }
                    // vectorized bias_off calc for this chunk of output coords
                    bias_dopt.vec_off_vtmp(bias_vp, &bias_off[0],
                            dvl, false/*pad*/);
                }
#endif
#if OPTb<=1
                VFOR(i,dvl) a[i] = get_bias(bias, bias_off[i], bias_data_type);
#else
                // bias is const char* : coerce the gather & cvt to float a[]
#define CASE(dt) case dt: VFOR(i,dvl) a[i] = (float)((const prec_traits<dt>::type *)bias)[bias_off[i]]; break
                switch(bias_data_type) {
                    CASE(data_type::s8);
                    CASE(data_type::u8);
                    CASE(data_type::s32);
                    CASE(data_type::f32);
                }
#endif
            } else {
                VFOR(i,dvl) a[i] = 0.f;
            }
            VFOR(i,dvl) { // fn calls, novec
                if (src_d.is_plain() && weights_d.is_plain()
                        && src_ic_stride == 1 && weights_kw_stride == 1)
                    a[i] += ker_plain(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
                else
                    a[i] += ker(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
            }

            //maybe_oscale(a, g, oc);
            VFOR(i,dvl) a[i] *= scales[v_ocxg[i] * scale_idx_mult];

            // NOTES: in eltwise I now usually do something like:
            // using cvt = Cvt<data_t, is_int_dt>;
            // if (is_int_dt) ydata_t[i] = cvt::rs(xfloat);
            // NOTE: looking here I may want to saturate bf16 (XXX check on x86)
#if OPT==0
            maybe_postops_vec2(a, dst_gather, dvl); // faster as lambda, go figure
#endif
#if OPT==1
            maybe_postops_vec3(a, dst_gather, dvl); // faster as lambda, go figure
#endif
#if OPT>=2
            dim_t dst_off[MVL]; // vectorized phys-offset calc
            dst_dopt.vec_off_v(dcrd.base(), &dst_off[0], dvl, false/*pad*/);
            if (ops.len_) {
                float dst_gather[MVL]; // gather dst values (MIGHT be used for post_ops)
                VFOR(i,dvl) dst_gather[i] = dst[dst_off[i]];
                maybe_postops_vec3(a, dst_gather, dvl); // faster as lambda, go figure
            }
#endif

            using cvt_dst = Cvt<dst_data_t, is_int_conv>;
#if OPT==0 || OPT==1
#if OPTx==0 // technically wrong for OPT==1, but faster !!!
            VFOR(i,dvl) {
                dst_gather[i] = cvt_dst::qs(a[i]);
                dst[dst_off[i]] = dst_gather[i];
            }
#else
            VFOR(i,dvl) {
                auto const x = cvt_dst::qs(a[i]);
                dst[dst_off[i]] = x;
            }
#endif
#elif OPT==2
#if OPTx==0
            //dst_data_t dst_gather[MVL]; // technically correct
            float dst_gather[MVL];
            VFOR(i,dvl) {
                dst_gather[i] = cvt_dst::qs(a[i]);
                dst[dst_off[i]] = dst_gather[i];
            }
#else
            VFOR(i,dvl) {
                auto const x = cvt_dst::qs(a[i]);
                dst[dst_off[i]] = x;
            }
#endif
#elif OPT==3 // very slow!
            float x[MVL];
            if (is_int_conv) { // qz_a1b0 is it different from round,saturate? maybe some bias?
                VFOR(i,dvl) {
                    x[i]= qz_a1b0<float,dst_data_t>()(a[i]);
                }
            }else{
                VFOR(i,dvl) {
                    x[i] = saturate<dst_data_t>(a[i]);
                }
            }
            VFOR(i,dvl) {
                dst[dst_off[i]] = x[i];
            }
#endif
#undef COORD_VEC_REGISTER
#undef OPT
        }
    };
#elif FWD_IMPL==4
#warning "ref_convolution FWD_IMPL==4"
    auto const bias_data_type = mypd->desc()->bias_desc.data_type;
    if (bias) assert( bias_data_type == data_type::s8
            || bias_data_type == data_type::u8
            || bias_data_type == data_type::s32
            || bias_data_type == data_type::f32);
    else assert( bias_data_type == data_type::undef );
    auto kern4 = [&](int ithr, int nthr) {
        //1b2: 31.3331 38.3888 31.7553 59.4035 59.3386 32.1725 15.4924 15.4991 15.491 92.2239
        size_t start, end;
        balance211(elems, nthr, ithr, start, end);
        auto const dm = dst_d.ndims(); // MB, OCxG, OD?, OH?, OW
        assert( dm >= 3 && dm <= 5 );

        Coords32 dcrd(dst_dopt.dims(), dm, start, end);
        // avoid mixing unsigned and int ops VE
        int const* const restrict dcrd_outer0 = reinterpret_cast<int const*>
                (&dcrd.vp[0][0]); 
        int dim_zeros[MVL]; // Coords32 !
        int v_g[MVL];
        int v_oc[MVL];
        dim_t dst_off[MVL]; // vectorized phys-offset calc
        float dst_gather[MVL]; // gather dst values (MIGHT be used for post_ops)
        dim_t bias_off[MVL];
        float a[MVL];
        {
            int dvl=dcrd.get_vl();
            VFOR(i,dvl) dim_zeros[i] = 0;
        }

        typedef int const *coord_register_t;
#define COORD_VEC_REGISTER(VAR, ...) coord_register_t VAR = (__VA_ARGS__)

        NOVEC for ( ; dcrd; ++dcrd) { // in vec-length chunks of dst coords
            int const dvl = dcrd.get_vl();

            dst_dopt.vec_off_v(dcrd.base(), &dst_off[0], dvl, false/*pad*/);
            auto dcrd_i = dcrd_outer0;
            COORD_VEC_REGISTER(v_mb, dcrd_i);
            dcrd_i += MVL; // also 1 dim before spatial coords
            COORD_VEC_REGISTER(v_ocxg, dcrd_i);
            COORD_VEC_REGISTER(v_od, (dm >= 5? (dcrd_i+=MVL): dim_zeros));
            COORD_VEC_REGISTER(v_oh, (dm >= 4? (dcrd_i+=MVL): dim_zeros));
            COORD_VEC_REGISTER(v_ow, dcrd_i+=MVL); // always exists, dm >= 3

            VFOR(i,dvl) {
                dst_gather[i] = dst[dst_off[i]];
                v_g[i] = v_ocxg[i] / OC;
                v_oc[i] = v_ocxg[i] % OC;
            }

            if (bias) {
                {
                    // bias "coord" is the 1-D set of dcrd.vp[1][i] "OCxG" values.
                    // Just copy them into a VecPos32 and use low-level offset calc.
                    VecPos32 bias_vp; 
                    assert( bias_d.ndims() == 1 );
                    ShortLoop() for (int i=0; i<dvl; ++i) {
                        // copy dimension 1 of dcrd --> 1-D bias coord in [0,OCxG)
                        bias_vp.vp[0][i] = (dcrd_outer0 + 1 * MVL)[i];
                    }
                    // vectorized bias_off calc for this chunk of output coords
                    bias_dopt.vec_off_vtmp(bias_vp, &bias_off[0],
                            dvl, false/*pad*/);
                }
                // bias is const char* : coerce the gather & cvt to float a[]
#define CASE(dt) case dt: VFOR(i,dvl) a[i] = (float)((const prec_traits<dt>::type *)bias)[bias_off[i]]; break
                switch(bias_data_type) {
                    CASE(data_type::s8);
                    CASE(data_type::u8);
                    CASE(data_type::s32);
                    CASE(data_type::f32);
                }
#undef CASE
            } else {
                VFOR(i,dvl) a[i] = 0.f;
            }

            VFOR(i,dvl) { // fn calls, novec
                if (src_d.is_plain() && weights_d.is_plain()
                        && src_ic_stride == 1 && weights_kw_stride == 1)
                    a[i] += ker_plain(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
                else
                    a[i] += ker(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
            }

            //maybe_oscale(a, g, oc);
            //VFOR(i,dvl) a[i] *= scales[v_ocxg[i] * scale_idx_mult];
            if (scale_idx_mult)
                VFOR(i,dvl) a[i] *= scales[v_ocxg[i]];
            else
                VFOR(i,dvl) a[i] *= scales[0];

            maybe_postops_vec3(a, dst_gather, dvl); // faster as lambda? go figure

            using cvt_dst = Cvt<dst_data_t, is_int_conv>;
            // technically wrong for OPT==1, but faster !!!
            VFOR(i,dvl) {
                dst_gather[i] = cvt_dst::qs(a[i]);
                dst[dst_off[i]] = dst_gather[i];
            }
#undef COORD_VEC_REGISTER
        }
    };
#else
#error "FWD_IMPL not implemented"
#endif // FWD_IMPL choice
#endif // FWD_IMPL>0

#if FWD_IMPL==0
#warning "ref_convolution.cpp FWD_IMPL==0"
    // TODO ||ize offset calcs for VE
    parallel_nd(G, MB, OC, OD, OH, OW,
            [&](int g, int mb, int oc, int od, int oh, int ow) {
                float a = bias ? get_bias(bias, bias_d.off(g * OC + oc),
                                  mypd->desc()->bias_desc.data_type)
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
#elif FWD_IMPL==1
    bool constexpr force_sequential = 0; // 1 for debug
    parallel((force_sequential? 1: 0), kern1);
#elif FWD_IMPL==2
    bool constexpr force_sequential = 0; // 1 for debug
    parallel((force_sequential? 1: 0), kern2);
#elif FWD_IMPL==3
    bool constexpr force_sequential = 0; // 1 for debug
    parallel((force_sequential? 1: 0), kern3);
#elif FWD_IMPL==4
    bool constexpr force_sequential = 0; // 1 for debug
    parallel((force_sequential? 1: 0), kern4);
#else
#error "unknown FWD_IMPL"
#endif
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
#endif // FWD_IMP==-1
