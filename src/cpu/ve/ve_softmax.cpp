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

#include <assert.h>
#include <float.h>
#include <math.h>

#include "common/c_types_map.hpp"
#include "common/dnnl_thread.hpp"
#include "common/type_helpers.hpp"
#include "common/bfloat16.hpp"

#include "cpu/ref_softmax.hpp"

namespace dnnl {
namespace impl {
namespace cpu {
#define PRINT 0
#define MVL 256
template <impl::data_type_t data_type>
void ref_softmax_fwd_t<data_type>::execute_forward_dense(
        const exec_ctx_t &ctx) const {
    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);
#if PRINT
    fprintf(stderr,"sofmax_fwd_dense outer %d channels %d inner %d\n",
            (int)outer_size_,(int)channels_,(int)inner_size_);
#endif

    const auto ou_stride = pd()->outer_stride();

    parallel_nd(outer_size_, [&](int ou) {
        const data_t *src_data = src + ou * ou_stride;
        data_t *dst_data = dst + ou * ou_stride;
        float space_max = -FLT_MAX;
        float space_denom = 0;

        for (int c = 0; c < channels_; ++c)
            //space_max = nstl::max(space_max, src_data[c]);
            //if( src_data[c] > space_max ) space_max = src_data[c];
            space_max = (src_data[c] > space_max? (float)src_data[c]: space_max);

        // sub + exp + sum
        if (pd()->is_softmax()) {
            for (int c = 0; c < channels_; ++c) {
                space_denom += dst_data[c] = expf(src_data[c] - space_max);
            }
        } else if (pd()->is_logsoftmax()) {
            for (int c = 0; c < channels_; ++c) {
                float D = dst_data[c] = src_data[c] - space_max;
                space_denom += expf(D);
            }
        }

        // scal
        if (pd()->is_softmax()) {
            space_denom = space_denom ? (1.f / space_denom) : 1.f;
            // '*=', '-='  :  not avail for bfloat16
            for (int c = 0; c < channels_; ++c) {
                dst_data[c] = dst_data[c] * space_denom;
            }
        } else if (pd()->is_logsoftmax()) {
            space_denom = logf(space_denom);
            for (int c = 0; c < channels_; ++c) {
                dst_data[c] = dst_data[c] - space_denom;
            }
        }
    });
}

template <impl::data_type_t data_type>
void ref_softmax_fwd_t<data_type>::execute_forward_generic(
        const exec_ctx_t &ctx) const {

    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);

    const memory_desc_wrapper data_d(pd()->src_md());
#if PRINT
    fprintf(stderr,"sofmax_fwd_generic outer %d channels %d inner %d\n",
            (int)outer_size_,(int)channels_,(int)inner_size_);
#endif

    parallel_nd(outer_size_, [&](int ou) {
        float space_max_val = 0, space_denom_val = 0;
        float *space_max = &space_max_val, *space_denom = &space_denom_val;
        if (inner_size_ > 1) {
            using namespace memory_tracking::names;
            space_max = ctx.get_scratchpad_grantor().template get<float>(
                                key_softmax_reduction)
                    + ou * 2 * inner_size_;
            space_denom = space_max + inner_size_;
        }

        utils::array_set(space_max, -FLT_MAX, inner_size_);
        utils::array_set(space_denom, 0, inner_size_);

        for (int in = 0; in < inner_size_; in++) {
            dim_t const ou_in_offset = ou * channels_ * inner_size_ + in;
            if (channels_ <= MVL) {
                size_t coff0[MVL];
                // unfortunately we do NOT have any guarantee that coff[c] will have any
                // repeatable pattern for arbitrary ou/in values :(
                for (int c = 0; c < channels_; c++) {
                    coff0[c] = data_d.off_l(ou_in_offset + c * inner_size_);
                }
                // But we expect NON-BLOCKED formats for VE, which **do** have constant
                // channel-stride, and should be optimized (between "dense", inner~1
                // and this "generic", in>1 cases).
                size_t coff[MVL];
                VREG(coff);
                ShortLoop() for (int c = 0; c < channels_; ++c)
                        coff[c] = coff0[c];
                ShortLoop() for (int c = 0; c < channels_; c++)
                    // nstl::max --> undetected Max/Min Idiom
                    if( src[coff[c]] > space_max[in] )
                       space_max[in]= src[coff[c]];
                    
                if (pd()->is_softmax()) {
                    ShortLoop() for (int c = 0; c < channels_; c++) {
                        float D = expf(src[coff[c]] - space_max[in]);
                        space_denom[in] += D;
                        dst[coff[c]] = D;
                    }
                } else if (pd()->is_logsoftmax()) {
                    ShortLoop() for (int c = 0; c < channels_; c++) {
                        float D = src[coff[c]] - space_max[in];
                        space_denom[in] += expf(D);
                        dst[coff[c]] = D;
                    }
                }
                if (pd()->is_logsoftmax()) space_denom[in] = logf(space_denom[in]);

                // VE: both "Partially vectorized" until IVDEP (even wtih list_vector hint)
                if (pd()->is_softmax()) {
                    float const mul = 1.0 / space_denom[in];
                    //PragmaQuote(_NEC list_vector)/*not enough*/
                    IVDEP() ShortLoop() for (int c = 0; c < channels_; c++)
                        dst[coff[c]] = dst[coff[c]] * mul;
                } else if (pd()->is_logsoftmax()) {
                    float const sub = space_denom[in];
                    IVDEP() ShortLoop() for (int c = 0; c < channels_; c++)
                        dst[coff[c]] = dst[coff[c]] - sub;
                }
            }
            // XXX add MEDIUM channels_ case here (reps w/ templated kernel trick?)
            else
            { // the initial max means a full scalar pass (not caching off_l func values)
                // Hmmm the removed factor COULD be done blockwise.
                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    space_max[in] = nstl::max(space_max[in], (float)src[off]);
                }

                // XXX TODO see bwd generic for better vectorization
                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    if (pd()->is_softmax()) {
                        float D = expf(src[off] - space_max[in]);
                        space_denom[in] += D;
                        dst[off] = D;
                    } else if (pd()->is_logsoftmax()) {
                        float D = src[off] - space_max[in];
                        space_denom[in] += expf(D);
                        dst[off] = D;
                    }
                }

                if (pd()->is_logsoftmax()) {
                    space_denom[in] = logf(space_denom[in]);
                }

                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    if (pd()->is_softmax()) {
                        dst[off] = dst[off] / space_denom[in];
                    } else if (pd()->is_logsoftmax()) {
                        dst[off] = dst[off] - space_denom[in];
                    }
                }
            } // end original way
        }
    });
}

template struct ref_softmax_fwd_t<data_type::bf16>;
template struct ref_softmax_fwd_t<data_type::f32>;

// softmax along last physical dimension
template <impl::data_type_t data_type>
void ref_softmax_bwd_t<data_type>::execute_backward_dense(
        const exec_ctx_t &ctx) const {
    auto dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DST);
    auto diff_dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DIFF_DST);
    auto diff_src = CTX_OUT_MEM(data_t *, DNNL_ARG_DIFF_SRC);

    const auto ou_stride = pd()->outer_stride();

#if PRINT
    fprintf(stderr,"sofmax_bwd_dense outer %d channels %d inner %d\n",
            (int)outer_size_,(int)channels_,(int)inner_size_);
#endif
    parallel_nd(outer_size_, [&](int ou) {
        float sbr = 0;
        size_t off = ou * ou_stride;
        if (pd()->is_softmax()) {
            for (size_t loff = off; loff < off + channels_; ++loff)
                sbr += diff_dst[loff] * dst[loff];
            for (size_t loff = off; loff < off + channels_; ++loff)
                diff_src[loff] = dst[loff] * (diff_dst[loff] - sbr);
        } else if (pd()->is_logsoftmax()) {
            for (size_t loff = off; loff < off + channels_; ++loff)
                sbr += diff_dst[loff];
            for (size_t loff = off; loff < off + channels_; ++loff)
                diff_src[loff] = diff_dst[loff] - expf(dst[loff]) * sbr;
        }
    });
}

template <impl::data_type_t data_type>
void ref_softmax_bwd_t<data_type>::execute_backward_generic(
        const exec_ctx_t &ctx) const {
    auto dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DST);
    auto diff_dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DIFF_DST);
    auto diff_src = CTX_OUT_MEM(data_t *, DNNL_ARG_DIFF_SRC);

    const memory_desc_wrapper diff_d(pd()->diff_src_md());
    const memory_desc_wrapper data_d(pd()->dst_md());

#if PRINT
    fprintf(stderr,"sofmax_bwd_generic outer %d channels %d inner %d\n",
            (int)outer_size_,(int)channels_,(int)inner_size_);
#endif
    parallel_nd(outer_size_, inner_size_, [&](int ou, int in) {
        dim_t const ou_in_offset = ou * channels_ * inner_size_ + in;
        if (pd()->is_softmax()) {
            typedef data_t acc_t; // double was 100x slower and no accuracty improvement
            //typedef float acc_t;
            data_t sbr = (data_t)0;
            //acc_t sbr = (acc_t)0;
            // time 91.8669 --> 0.104004 for
            // ./vetest.sh -B build-vej --benchdnn --softmax --verbose=10 --dir=BWD_D --axis=0 8192x64
            // which fails accuracy checks.
#define MEDIUM (16*MVL) /*potentially 16 vec regs*/
            if( channels_ <= MVL ){
                // the scalar loop dominates run-time.  although vector code looks great,
                // not visibly much faster than default!
                asm("## short");
                dim_t diff_off[MVL];
                dim_t data_off[MVL];
                for (int c = 0; c < channels_; ++c) { // Unvectorized
                    size_t const coff = ou_in_offset + c * inner_size_;
                    diff_off[c] = diff_d.off_l(coff);
                    data_off[c] = data_d.off_l(coff);
                }
                ShortLoop() for (int c = 0; c < channels_; ++c) {
                    sbr += (acc_t)(diff_dst[diff_off[c]]) * dst[data_off[c]];
                }
                ShortLoop() for (int c = 0; c < channels_; ++c) {
                    diff_src[diff_off[c]] = dst[data_off[c]]
                            * (diff_dst[diff_off[c]] - sbr);
                }
            }else if( channels_ < MEDIUM ){
                asm("## medium");
                dim_t diff_off[MEDIUM];
                dim_t data_off[MEDIUM];
                PragmaQuote(_NEC loop_count(MEDIUM))
                for (int c = 0; c < channels_; ++c) { // Unvectorized
                    size_t const coff = ou_in_offset + c * inner_size_;
                    diff_off[c] = diff_d.off_l(coff);
                    data_off[c] = data_d.off_l(coff);
                }
                PragmaQuote(_NEC nofuse)
                PragmaQuote(_NEC loop_count(MEDIUM))
                for (int c = 0; c < channels_; ++c) {
                    sbr += (acc_t)(diff_dst[diff_off[c]]) * dst[data_off[c]];
                }
                PragmaQuote(_NEC loop_count(MEDIUM))
                for (int c = 0; c < channels_; ++c) {
                    diff_src[diff_off[c]] = dst[data_off[c]]
                            * (diff_dst[diff_off[c]] - sbr);
                }
            }else{
                asm("## long");
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    dim_t data_off[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? c0+MEDIUM: channels_ );
                    PragmaQuote(_NEC novector)
                    for(int c=c0; c<cmax; ++c){ // unvectorizable func call
                        size_t const coff = ou_in_offset + c * inner_size_;
                        diff_off[c] = diff_d.off_l(coff);
                        data_off[c] = data_d.off_l(coff);
                    }
                    PragmaQuote(_NEC vob)
                    for(int c=c0; c<cmax; ++c){
                        sbr += (acc_t)(diff_dst[diff_off[c]]) * dst[data_off[c]];
                    }
                }
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    dim_t data_off[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? c0+MEDIUM: channels_ );
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    for(int c=c0; c<cmax; ++c){ // unvectorizable func call
                        size_t const coff = ou_in_offset + c * inner_size_;
                        diff_off[c] = diff_d.off_l(coff);
                        data_off[c] = data_d.off_l(coff);
                    }
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    for(int c=c0; c<cmax; ++c){ // unvectorizable func call
                        diff_src[diff_off[c]] = dst[data_off[c]]
                                * (diff_dst[diff_off[c]] - sbr);
                    }
                }
            }
#undef MEDIUM
        } else if (pd()->is_logsoftmax()) {
            //typedef data_t acc_t; // double was 100x slower and no accuracty improvement
            typedef float acc_t;
            acc_t sbr = (acc_t)0;
            // time 91.8669 --> 0.104004 for
            // ./vetest.sh -B build-vej --benchdnn --softmax --verbose=10 --dir=BWD_D --axis=0 8192x64
            // which fails accuracy checks.
#define MEDIUM (16*MVL) /*potentially 16 vec regs*/
            if( channels_ <= 1*MVL ){ // nc++-3.0.27 will not used packed vector :/
                // the scalar loop dominates run-time.  although vector code looks great,
                // not visibly much faster than default!
                asm("## logshort");
                dim_t diff_off[1*MVL];
                dim_t data_off[1*MVL];
                float data_exp[1*MVL];
#define Short() PragmaQuote(_NEC shortloop)
//#define Short() PragmaQuote(_NEC loop_count(2*MVL))
#define Vpack() PragmaQuote(_NEC packed_vector)
#define PVREG(array_name) PragmaQuote(_NEC pvreg(array_name))
                // unvectorized
                Short()for (int c = 0; c < channels_; ++c) {
                    size_t const coff = ou_in_offset + c * inner_size_;
                    data_off[c] = data_d.off_l(coff);
                    //data_exp[c] = expf( dst[data_d.off_l(coff)] );
                    diff_off[c] = diff_d.off_l(coff);
                }
                data_t vdst[1*MVL]; VREG(vdst);
                Short() for (int c = 0; c < channels_; ++c) {
                    vdst[c] = dst[data_off[c]];         // gather
                    data_exp[c] = expf( vdst[c] );      // __vec_expf
                }
                Short()for (int c = 0; c < channels_; ++c) {
                    sbr += diff_dst[diff_off[c]]; // gather, vec reduction
                }
                Short()for (int c = 0; c < channels_; ++c) {
                    // gather, load, fused-neg-mul-sub, scatter
                    diff_src[diff_off[c]] = diff_dst[diff_off[c]]
                            - data_exp[c] * sbr;
                }
            }else if( channels_ < MEDIUM ){
                asm("## logmedium");
                dim_t diff_off[MEDIUM];
                dim_t data_off[MEDIUM];
                float data_exp[MEDIUM];
                PragmaQuote(_NEC loop_count(MEDIUM))
                PragmaQuote(_NEC novector)
                for (int c = 0; c < channels_; ++c) { // Unvectorized
                    size_t const coff = ou_in_offset + c * inner_size_;
                    data_off[c] = data_d.off_l(coff);
                    diff_off[c] = diff_d.off_l(coff);
                }
                // nc++ DOES have an __vec_expf ... how to get it?
                {
                    data_t vdst[MEDIUM];
                    for (int c = 0; c < channels_; ++c) { // sneaky: allows __vec_expf
                        // NO data_exp[c] = expf( dst[data_off[c]] );
                        vdst[c] = dst[data_off[c]];
                        data_exp[c] = expf( vdst[c] );
                    }
                }
                PragmaQuote(_NEC loop_count(MEDIUM))
                for (int c = 0; c < channels_; ++c) {
                    sbr += diff_dst[diff_off[c]];
                }
                PragmaQuote(_NEC loop_count(MEDIUM))
                for (int c = 0; c < channels_; ++c) {
                    diff_src[diff_off[c]] = diff_dst[diff_off[c]]
                            - data_exp[c] * sbr;
                }
            }else{
                asm("## loglong"); // ouch. double calc of offsets
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? c0+MEDIUM: channels_ );
                    PragmaQuote(_NEC novector)
                    for(int c=c0; c<cmax; ++c){ // unvectorizable func call
                        size_t const coff = ou_in_offset + c * inner_size_;
                        diff_off[c] = diff_d.off_l(coff);
                    }
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    for(int c=c0; c<cmax; ++c){
                        sbr += diff_dst[diff_off[c]];
                    }
                } // blockwise sbr adds mul & div corrections (keep as original!)
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    dim_t data_off[MEDIUM];
                    float data_exp[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? c0+MEDIUM: channels_ );
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    PragmaQuote(_NEC novector)
                    for(int c=c0; c<cmax; ++c){ // unvectorizable func calls
                        size_t const coff = ou_in_offset + c * inner_size_;
                        data_off[c] = data_d.off_l(coff);
                        //data_exp[c] = expf( dst[data_d.off_l(coff)] );
                        diff_off[c] = diff_d.off_l(coff);
                    }
                    {
                        data_t vdst[MEDIUM];
                        for(int c=c0; c<cmax; ++c){
                            vdst[c] = dst[data_off[c]];         // gather
                            data_exp[c] = expf( vdst[c] );       // __vec_expf
                        }
                    }
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    for(int c=c0; c<cmax; ++c){ // gather, load, fma, scatter
                        diff_src[diff_off[c]] = diff_dst[diff_off[c]]
                                - data_exp[c] * sbr;
                    }
                }
            }
#undef MEDIUM
        }
    });
}

template struct ref_softmax_bwd_t<data_type::bf16>;
template struct ref_softmax_bwd_t<data_type::f32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
