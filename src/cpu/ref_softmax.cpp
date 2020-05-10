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
// internal compiler error?
//#pragma _NEC options "-floop-split"

#include <assert.h>
#include <float.h>
#include <math.h>

#include "common/c_types_map.hpp"
#include "common/dnnl_thread.hpp"
#include "common/type_helpers.hpp"
#include "common/bfloat16.hpp"

#include "cpu/ref_softmax.hpp"

#if defined(__ve)
// (should still work for x86, but with pragma warning)
// reference calcs hugely slowed by offset calcs
// 1. rearrange loops to split off "scalar" offset calcs.
// 1b. "batch" over channels
// 2. "batch" --> new vector-of-offsets API for memory_desc
// Maybe go back to cleaner loops, with vectorized offset calcs ?
#include "common/ve/memory_desc_wrapper_opt.hpp"
#define memory_desc_wrapper memory_desc_wrapper_opt

#else
// to compare with "original" times:
#include "common/memory_desc_wrapper.hpp"
#endif

namespace dnnl {
namespace impl {
namespace cpu {
#define VE_FWD_DENSE 1
#define VE_FWD_GEN   1   // 3x VE speedup on --softmax --axis=0 96x1000
#define VE_BWD_DENSE 1
#define VE_BWD_GEN   1
#define PRINT 1
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
#if defined(__ve)
        constexpr int unroll_factor = 256;
#else
        constexpr int unroll_factor = 32;
#endif

#if VE_FWD_DENSE
        for (int c = 0; c < channels_; ++c)
            //space_max = nstl::max(space_max, src_data[c]);
            //if( src_data[c] > space_max ) space_max = src_data[c];
            space_max = (src_data[c] > space_max? (float)src_data[c]: space_max);
#elif !defined(__INTEL_COMPILER) && !defined(__ve)
        // The code below makes the compiler generate maxps instruction.
        // rather than maxss, which is generated for the 'else' code path
        auto max_wrapper = [](float a, float b) { return nstl::max(a, b); };
        auto min_wrapper = [](int a, int b) { return nstl::min(a, b); };

        if (channels_ < unroll_factor) {
            float max_val = -FLT_MAX;
            for (int i = 0; i < channels_; i++) {
                max_val = max_wrapper(max_val, src_data[i]);
            }
            space_max = max_val;
        } else {
            float max_values[unroll_factor];

            for (int i = 0; i < unroll_factor; i++) {
                max_values[i] = src_data[i];
            }
            for (int i = unroll_factor; i < channels_; i += unroll_factor) {
                int offset = min_wrapper(i, channels_ - unroll_factor);
                for (int j = 0; j < unroll_factor; j++) {
                    max_values[j]
                            = max_wrapper(max_values[j], src_data[offset + j]);
                }
            }
            float max_val = -FLT_MAX;
            for (int i = 0; i < unroll_factor; i++) {
                max_val = max_wrapper(max_val, max_values[i]);
            }
            space_max = max_val;
        }
#else /* ic++ or nc++ */
        // Intel(R) C++ Compiler generates the maxps + shuffle pattern
        // for the max search which works faster
        for (int c = 0; c < channels_; ++c)
            space_max = nstl::max(space_max, (float)src_data[c]);
#endif

        // sub + exp + sum
#if VE_FWD_DENSE
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
#else
        int tail = channels_ % unroll_factor;
        for (int i = 0; i < channels_ - tail; i += unroll_factor) {
            PRAGMA_OMP_SIMD()
            for (int j = 0; j < unroll_factor; j++) {
                if (pd()->is_softmax()) {
                    float D = expf(src_data[i + j] - space_max);
                    space_denom += D;
                    dst_data[i + j] = D;
                } else if (pd()->is_logsoftmax()) {
                    float D = src_data[i + j] - space_max;
                    space_denom += expf(D);
                    dst_data[i + j] = D;
                }
            }
        }
        for (int i = channels_ - tail; i < channels_; i++) {
            if (pd()->is_softmax()) {
                float D = expf(src_data[i] - space_max);
                space_denom += D;
                dst_data[i] = D;
            } else if (pd()->is_logsoftmax()) {
                float D = src_data[i] - space_max;
                space_denom += expf(D);
                dst_data[i] = D;
            }
        }
#endif

        // scal
#if VE_FWD_DENSE
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
#else // VE definite vectorization bug in this section
        if (pd()->is_softmax()) {
            space_denom = space_denom ? (1.f / space_denom) : 1.f;
        } else if (pd()->is_logsoftmax()) {
            space_denom = logf(space_denom);
        }
        for (int c = 0; c < channels_; ++c) {
            if (pd()->is_softmax()) {
                dst_data[c] = dst_data[c] * space_denom;
            } else if (pd()->is_logsoftmax()) {
                dst_data[c] = dst_data[c] - space_denom;
            }
        }
#endif
    });
}

template <impl::data_type_t data_type>
void ref_softmax_fwd_t<data_type>::execute_forward_generic(
        const exec_ctx_t &ctx) const {

    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);
    auto const is_softmax = pd()->is_softmax();
    auto const is_logsoftmax = pd()->is_logsoftmax();
#if defined(__ve)
    constexpr int unroll_factor = 256;
#else
    constexpr int unroll_factor = 32;
#endif

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
#if VE_FWD_GEN
            // large-block
            // But we expect NON-BLOCKED formats for VE, which **do** have constant
            // channel-stride, and should be optimized (between "dense", inner~1
            // and this "generic", in>1 cases).
#define MVL 256
#define MEDIUM (16*MVL)
#define WHICH 0
            if (WHICH >= 0 && channels_ <= MVL) {
#define Short_ PragmaQuote(_NEC loop_count(MVL)) PragmaQuote(_NEC shortloop)
#if 0 // slower! even though ind. loops vectorize (128x5000)
                size_t coff[MVL];
                Short_ for (int c = 0; c < channels_; c++)
                    coff[c] = data_d.off_l(ou_in_offset + c * inner_size_);
                float vsrc[MVL]; VREG(vsrc); // vsrc is NOT pure register!
                Short_ for (int c = 0; c < channels_; c++) {
                    vsrc[c] = src[coff[c]];
                }
                float smax = src[coff[0]];
                Short_ for (int c = 0; c < channels_; c++) {
                    if( vsrc[c] > smax ) smax = vsrc[c];
                }

                float vdst[MVL]; VREG(vdst); // don't scatter until very end
                float denom = 0;
                if (is_softmax) {
                    Short_ for (int c = 0; c < channels_; c++) {
                        float D = expf(vsrc[c]- smax);
                        vdst[c] = D;
                        denom += D;
                    }
                    float const mul = 1.0 / denom;
                    Short_ for (int c = 0; c < channels_; c++)
                        dst[coff[c]] = vdst[c] * mul;
                } else if (is_logsoftmax) {
                    Short_ for (int c = 0; c < channels_; c++) {
                        float D = vsrc[c]- smax;
                        vdst[c] = D;
                        denom += expf(D);
                    }
                    denom = logf(denom);
                    Short_ for (int c = 0; c < channels_; c++)
                        dst[coff[c]] = vdst[c] - denom;
                }
                space_denom[in] = denom;
                space_max[in] = smax;
#else // older, faster [channels_ <= MVL]
#define VECTOR_OFFSET_CALC 1
                dim_t coff[MVL]; // physical offsets [padded/blocked mem layout]
#if VECTOR_OFFSET_CALC && defined(COMMON_MEMORY_DESC_WRAPPER_OPT_HPP)
                {   //
                    dim_t l_off[MVL];
                    // VREG(l_off); if can inline vec_off_l (asm?)
                    // logical offsets, "as if dense" inner dims
                    Short_ for (int c = 0; c < channels_; ++c)
                            l_off[c] = ou_in_offset + c * inner_size_;
                    data_d.vec_off_l( &l_off[0], channels_, &coff[0] );
                }
#else
                Short_ for (int c = 0; c < channels_; ++c)
                        // default: is_pos_padded=false
                        coff[c] = data_d.off_l(ou_in_offset + c * inner_size_);
#endif
                float smax = src[coff[0]];
                Short_ for (int c = 0; c < channels_; c++)
                        if( src[coff[c]] > smax ) smax = src[coff[c]];
                space_max[in] = smax;

                float denom = 0;
                if (is_softmax) {
                    Short_ for (int c = 0; c < channels_; c++) {
                        float D = expf(src[coff[c]] - smax);
                        denom += D;
                        dst[coff[c]] = D;
                    }
                } else if (is_logsoftmax) {
                    Short_ for (int c = 0; c < channels_; c++) {
                        float D = src[coff[c]] - smax;
                        denom += expf(D);
                        dst[coff[c]] = D;
                    }
                }
                if (is_logsoftmax) denom = logf(denom);

                // VE: both "Partially vectorized" until IVDEP (even wtih list_vector hint)
                if (is_softmax) {
                    float const mul = 1.0 / denom;
                    IVDEP() Short_ for (int c = 0; c < channels_; c++)
                            dst[coff[c]] = dst[coff[c]] * mul;
                } else if (is_logsoftmax) {
                    IVDEP() Short_ for (int c = 0; c < channels_; c++)
                            dst[coff[c]] = dst[coff[c]] - denom;
                }
                space_denom[in] = denom;
#endif
#undef Short_
            }
            // XXX add MEDIUM channels_ case here (reps w/ templated kernel trick?)
            else if( WHICH==1 || channels_ <= MEDIUM )
            {
#define Medium_ PragmaQuote(_NEC loop_count(MEDIUM))
                size_t coff[MEDIUM];
#if VECTOR_OFFSET_CALC && defined(COMMON_MEMORY_DESC_WRAPPER_OPT_HPP)
                {   // we need to BLOCK by MVL (or so)
                    dim_t l_off[MEDIUM];
                    // VREG(l_off); if can inline vec_off_l (asm?)
                    // logical offsets, "as if dense" inner dims
                    Medium_ for (int c = 0; c < channels_; ++c)
                            l_off[c] = ou_in_offset + c * inner_size_;
                    data_d.vec_off_l( &l_off[0], channels_, (dim_t*)&coff[0] );
                    //                [is_pos_padded=false]
                }
#else
                Medium_ for (int c = 0; c < channels_; ++c)
                    coff[c] = data_d.off_l(ou_in_offset + c * inner_size_);
#endif
                float smax = src[coff[0]];
                Medium_ for (int c = 0; c < channels_; c++)
                    if( src[coff[c]] > smax ) smax = src[coff[c]];

                float denom = 0;
                if (is_softmax) {
                    Medium_ for (int c = 0; c < channels_; c++) {
                        float D = expf(src[coff[c]] - smax);
                        denom += D;
                        dst[coff[c]] = D;
                    }
                } else if (is_logsoftmax) {
                    Medium_ for (int c = 0; c < channels_; c++) {
                        float D = src[coff[c]] - smax;
                        denom += expf(D);
                        dst[coff[c]] = D;
                    }
                }
                space_max[in] = smax;
                if (is_logsoftmax) denom = logf(denom);

                // VE: both "Partially vectorized" until IVDEP (even wtih list_vector hint)
                if (is_softmax) {
                    float const mul = 1.0 / denom;
                    IVDEP() Medium_ for (int c = 0; c < channels_; c++)
                        dst[coff[c]] = dst[coff[c]] * mul;
                } else if (is_logsoftmax) {
                    IVDEP() Medium_ for (int c = 0; c < channels_; c++)
                        dst[coff[c]] = dst[coff[c]] - denom;
                }
                space_denom[in] = denom;
#undef Medium_
            }
            else if( WHICH==2 || channels_ > MEDIUM )
            { // the initial max means a full scalar pass (not caching off_l func values)
                float smax = -FLT_MAX;
#define OUTER_
//#define INNER_ PragmaQuote(_NEC loop_count(MEDIUM)) PragmaQuote(_NEC list_vector) PragmaQuote(_NEC cncall)
#define INNER_ PragmaQuote(_NEC loop_count(MEDIUM)) PragmaQuote(_NEC list_vector)
                // cncall did not seem to work - unsure why.  constexpr?
#if 0
                // Hmmm the removed factor COULD be done blockwise.
                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    smax = nstl::max(smax, (float)src[off]);
                }
#else
                OUTER_ for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t data_off[MEDIUM];
                    int const cmax=( channels_ - c0 > MEDIUM? MEDIUM: channels_ - c0 );
                    // segfault XXX FIXME TODO
#if 0 && VECTOR_OFFSET_CALC && defined(COMMON_MEMORY_DESC_WRAPPER_OPT_HPP)
                    {
                        dim_t l_off[MEDIUM]; // logical offsets, "as if dense" inner dims
                        // VREG(l_off); if can inline vec_off_l (asm?)
                        INNER_ for (int c = 0; c < cmax; ++c)
                            l_off[c] = ou_in_offset + (c0 + c) * inner_size_;
                        // XXX Actually, the coords of l_off[0] can just
                        // increment the 'axis'th coord by one each time,
                        // so a much faster vec_off_l is possible XXX
                        data_d.vec_off_l( &l_off[0], channels_, &data_off[0] );
                        //                [is_pos_padded=false]
                    }
#else
                    PragmaQuote(_NEC novector)
                    for(int c=0; c<cmax; ++c){ // unvectorizable func call
                        data_off[c] = data_d.off_l(ou_in_offset + (c0 + c) * inner_size_);
                    }
#endif
                    INNER_ for(int c=0; c<cmax; ++c){ // unvectorizable func call
                        if( src[data_off[c]] > smax ) smax = src[data_off[c]];
                    }
                }
#endif
                float sdenom = 0.0;
#if 0 // older
                for (int c = 0; c < channels_; c++) { // unvec
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    if (is_softmax) {
                        float const D = expf(src[off] - smax);
                        sdenom += D;
                        dst[off] = D;
                    } else if (is_logsoftmax) {
                        float const D = src[off] - smax;
                        sdenom += expf(D);
                        dst[off] = D;
                    }
                }
#endif
                OUTER_ for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t data_off[MEDIUM];
                    int const cmax=( channels_ - c0 > MEDIUM? MEDIUM: channels_ - c0 );
#if 0 && VECTOR_OFFSET_CALC && defined(COMMON_MEMORY_DESC_WRAPPER_OPT_HPP)
                    {
                        dim_t l_off[MEDIUM]; // logical offsets, "as if dense" inner dims
                        // VREG(l_off); if can inline vec_off_l (asm?)
                        INNER_ for (int c = 0; c < cmax; ++c)
                            l_off[c] = ou_in_offset + (c0 + c) * inner_size_;
                        // XXX Actually, the coords of l_off[0] can just
                        // increment the 'axis'th coord by one each time,
                        // so a much faster vec_off_l is possible XXX
                        data_d.vec_off_l( &l_off[0], channels_, &data_off[0] );
                        //                [is_pos_padded=false]
                    }
#else
                    PragmaQuote(_NEC novector)
                    for(int c=0; c<cmax; ++c){ // unvectorizable func call
                        data_off[c] = data_d.off_l(ou_in_offset + (c0 + c) * inner_size_);
                    }
#endif
                    if (is_softmax) {
                        INNER_ for(int c=0; c<cmax; ++c){ // pd-> blocks vectorization
                            float const D = expf(src[data_off[c]] - smax);
                            sdenom += D;
                            dst[data_off[c]] = D;
                        }
                    } else if (is_logsoftmax) {
                        INNER_ for(int c=0; c<cmax; ++c){ // pd-> blocks vectorization
                            float const D = src[data_off[c]] - smax;
                            sdenom += expf(D);
                            dst[data_off[c]] = D;
                        }
                    }
                }
                space_max[in] = smax; // but actually do not need scratchpad? XXX

                if (is_softmax) {
                    space_denom[in] = sdenom; // but actually do not need to store XXX
                    sdenom = 1.0 / sdenom;
                } else if (is_logsoftmax) {
                    sdenom = logf(sdenom);
                    space_denom[in] = sdenom; // but actually do not need to store XXX
                }

#if 0 // old version
                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    if (is_softmax) {
                        dst[off] = dst[off] * sdenom;
                    } else if (is_logsoftmax) {
                        dst[off] = dst[off] - sdenom;
                    }
                }
#endif
                PragmaQuote(_NEC novovertake)
                OUTER_ for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t data_off[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? MEDIUM: channels_ - c0 );
                    PragmaQuote(_NEC novector)
                    for(int c=0; c<cmax; ++c){ // unvectorizable func call
                        data_off[c] = data_d.off_l(ou_in_offset + (c0 + c) * inner_size_);
                    }
                    if (is_softmax) {
                        PragmaQuote(_NEC vob)
                        INNER_ for (int c = 0; c < cmax; c++) {
                            dst[data_off[c]] = dst[data_off[c]] * sdenom;
                        }
                    } else if (is_logsoftmax) {
                        PragmaQuote(_NEC vob)
                        INNER_ for (int c = 0; c < cmax; c++) {
                            dst[data_off[c]] = dst[data_off[c]] - sdenom;
                        }
                    }
                }
#undef INNER_
#undef WHICH
#undef MVL
#undef MEDIUM
            }
#else // VE_FWD_GEN
            { // original way was JUST the following
                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    space_max[in] = nstl::max(space_max[in], (float)src[off]);
                }

                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    if (is_softmax) {
                        float D = expf(src[off] - space_max[in]);
                        space_denom[in] += D;
                        dst[off] = D;
                    } else if (is_logsoftmax) {
                        float D = src[off] - space_max[in];
                        space_denom[in] += expf(D);
                        dst[off] = D;
                    }
                }

                if (is_logsoftmax) {
                    space_denom[in] = logf(space_denom[in]);
                }

                for (int c = 0; c < channels_; c++) {
                    size_t off = data_d.off_l(ou_in_offset + c * inner_size_);
                    if (is_softmax) {
                        dst[off] = dst[off] / space_denom[in];
                    } else if (is_logsoftmax) {
                        dst[off] = dst[off] - space_denom[in];
                    }
                }
            } // end original way
#endif // VE_FWD_GEN
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
#if VE_BWD_GEN // precision issues
    parallel_nd(outer_size_, inner_size_, [&](int ou, int in) {
        dim_t const ou_in_offset = ou * channels_ * inner_size_ + in;
        if (pd()->is_softmax()) {
            typedef data_t acc_t; // double was 100x slower and no accuracty improvement
            //typedef float acc_t;
            data_t sbr = (data_t)0;
            //acc_t sbr = (acc_t)0;
#if VE_BWD_GEN // rewrite to allow some vectorization
            // time 91.8669 --> 0.104004 for
            // ./vetest.sh -B build-vej --benchdnn --softmax --verbose=10 --dir=BWD_D --axis=0 8192x64
            // which fails accuracy checks.
#define MVL 256
#define MEDIUM (16*MVL) /*potentially 16 vec regs*/
            if( channels_ <= MVL ){
                // the scalar loop dominates run-time.  although vector code looks great,
                // not visibly much faster than default!
                //asm("## short");
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
                //asm("## medium");
#define HELP_ PragmaQuote(_NEC loop_count(MEDIUM))
                dim_t diff_off[MEDIUM];
                dim_t data_off[MEDIUM];
                HELP_ for (int c = 0; c < channels_; ++c) { // Unvectorized
                    size_t const coff = ou_in_offset + c * inner_size_;
                    diff_off[c] = diff_d.off_l(coff);
                    data_off[c] = data_d.off_l(coff);
                }
                //PragmaQuote(_NEC nofuse)
                HELP_ for (int c = 0; c < channels_; ++c) {
                    sbr += (acc_t)(diff_dst[diff_off[c]]) * dst[data_off[c]];
                }
                HELP_ for (int c = 0; c < channels_; ++c) {
                    diff_src[diff_off[c]] = dst[data_off[c]]
                            * (diff_dst[diff_off[c]] - sbr);
                }
#undef HELP_
            }else{
                //asm("## long");
#define HELP_ PragmaQuote(_NEC loop_count(MEDIUM))
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    dim_t data_off[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? MEDIUM: channels_ - c0 );
                    //PragmaQuote(_NEC novector)
                    HELP_ for(int c=0; c<cmax; ++c){ // unvectorizable func call
                        size_t const coff = ou_in_offset + (c0 + c) * inner_size_;
                        diff_off[c] = diff_d.off_l(coff);
                        data_off[c] = data_d.off_l(coff);
                    }
                    //PragmaQuote(_NEC vob)
                    HELP_ for(int c=0; c<cmax; ++c){
                        sbr += (acc_t)(diff_dst[diff_off[c]]) * dst[data_off[c]];
                    }
                }
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    dim_t data_off[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? MEDIUM: channels_ - c0 );
                    HELP_ for(int c=0; c<cmax; ++c){ // unvectorizable func call
                        size_t const coff = ou_in_offset + (c0 + c) * inner_size_;
                        diff_off[c] = diff_d.off_l(coff);
                        data_off[c] = data_d.off_l(coff);
                    }
                    //PragmaQuote(_NEC vob)
                    HELP_ for(int c=0; c<cmax; ++c){
                        diff_src[diff_off[c]] = dst[data_off[c]]
                                * (diff_dst[diff_off[c]] - sbr);
                    }
                }
#undef HELP_
            }
#undef MVL
#undef MEDIUM
#else // original : offset function calls ==> scalar loops
            for (int c = 0; c < channels_; ++c) {
                auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
                auto off_data = data_d.off_l(ou_in_offset + c * inner_size_);
                sbr += diff_dst[off_diff] * dst[off_data];
            }
            for (int c = 0; c < channels_; ++c) {
                auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
                auto off_data = data_d.off_l(ou_in_offset + c * inner_size_);
                diff_src[off_diff] = dst[off_data] * (diff_dst[off_diff] - sbr);
            }
#endif
        } else if (pd()->is_logsoftmax()) {
            //typedef data_t acc_t; // double was 100x slower and no accuracty improvement
            typedef float acc_t;
            acc_t sbr = (acc_t)0;
#if VE_BWD_DENSE // rewrite to allow some vectorization
            // time 91.8669 --> 0.104004 for
            // ./vetest.sh -B build-vej --benchdnn --softmax --verbose=10 --dir=BWD_D --axis=0 8192x64
            // which fails accuracy checks.
#define MVL 256         /* max simd vector length */
#define MEDIUM (16*MVL) /*potentially 16 vec regs*/
            if( channels_ <= 1*MVL ){ // nc++-3.0.27 will not used packed vector :/
                // the scalar loop dominates run-time.  although vector code looks great,
                // not visibly much faster than default!
                //asm("## logshort");
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
                //asm("## logmedium");
                dim_t diff_off[MEDIUM];
                dim_t data_off[MEDIUM];
                float data_exp[MEDIUM];
                PragmaQuote(_NEC loop_count(MEDIUM))
                //PragmaQuote(_NEC novector)
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
                //asm("## loglong"); // ouch. double calc of offsets
#if 1 // orig
                PragmaQuote(_NEC novector)
                for (int c = 0; c < channels_; ++c) {
                    auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
                    sbr += diff_dst[off_diff];
                }
                for (int c = 0; c < channels_; ++c) {
                    auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
                    auto off_data = data_d.off_l(ou_in_offset + c * inner_size_);
                    diff_src[off_diff] = diff_dst[off_diff]
                            - expf(dst[off_data]) * sbr;
                }
#else
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? MEDIUM: channels_ - c0 );
                    //PragmaQuote(_NEC novector)
                    for(int c=0; c<cmax; ++c){ // unvectorizable func call
                        size_t const coff = ou_in_offset + (c0 + c) * inner_size_;
                        diff_off[c] = diff_d.off_l(coff);
                    }
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    for(int c=0; c<cmax; ++c){
                        sbr += diff_dst[diff_off[c]];
                    }
                } // blockwise sbr adds mul & div corrections (keep as original!)
                for (int c0 = 0; c0 < channels_; c0+=MEDIUM) {
                    dim_t diff_off[MEDIUM];
                    dim_t data_off[MEDIUM];
                    float data_exp[MEDIUM];
                    int const cmax=( c0 < channels_- MEDIUM? MEDIUM: channels_ - c0 );
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    //PragmaQuote(_NEC novector)
                    for(int c=0; c<cmax; ++c){ // unvectorizable func calls
                        size_t const coff = ou_in_offset + (c0 + c) * inner_size_;
                        data_off[c] = data_d.off_l(coff);
                        diff_off[c] = diff_d.off_l(coff);
                    }
                    {
                        data_t vdst[MEDIUM];
                        for(int c=0; c<cmax; ++c){
                            vdst[c] = dst[data_off[c]];   // gather
                        }
                        for(int c=0; c<cmax; ++c){
                            data_exp[c] = expf(vdst[c]);  // __vec_expf
                        }
                    }
                    PragmaQuote(_NEC loop_count(MEDIUM))
                    for(int c=0; c<cmax; ++c){ // gather, load, fma, scatter
                        diff_src[diff_off[c]] = diff_dst[diff_off[c]]
                                - data_exp[c] * sbr;
                    }
                }
#endif // orig
            }
#undef MVL
#undef MEDIUM
#else // original bwd logsoftmax: offset function calls ==> scalar loops
            // still unvectorized because of off_l on VE XXX TODO
            for (int c = 0; c < channels_; ++c) {
                auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
                sbr += diff_dst[off_diff];
            }
            for (int c = 0; c < channels_; ++c) {
                auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
                auto off_data = data_d.off_l(ou_in_offset + c * inner_size_);
                diff_src[off_diff] = diff_dst[off_diff]
                        - expf(dst[off_data]) * sbr;
            }
#endif
        }
    });
#else // original code
    parallel_nd(outer_size_, inner_size_, [&](int ou, int in) {
        dim_t ou_in_offset = ou * channels_ * inner_size_ + in;
        float sbr = 0;
        for (int c = 0; c < channels_; ++c) {
            auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
            if (pd()->is_softmax()) {
                auto off_data = data_d.off_l(ou_in_offset + c * inner_size_);
                sbr += diff_dst[off_diff] * dst[off_data];
            } else if (pd()->is_logsoftmax()) {
                sbr += diff_dst[off_diff];
            }
        }

        for (int c = 0; c < channels_; ++c) {
            auto off_diff = diff_d.off_l(ou_in_offset + c * inner_size_);
            auto off_data = data_d.off_l(ou_in_offset + c * inner_size_);
            if (pd()->is_softmax()) {
                diff_src[off_diff] = dst[off_data] * (diff_dst[off_diff] - sbr);
            } else if (pd()->is_logsoftmax()) {
                diff_src[off_diff]
                        = diff_dst[off_diff] - expf(dst[off_data]) * sbr;
            }
        }
    });
#endif
}

template struct ref_softmax_bwd_t<data_type::bf16>;
template struct ref_softmax_bwd_t<data_type::f32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
