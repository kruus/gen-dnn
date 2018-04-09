/*******************************************************************************
* Copyright 2016-2018 Intel Corporation
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
#ifndef JITFUNCS
#ifdef DOXYGEN_SHOULD_SKIP_THIS
/** 100: do everything. 0 makes testing VERY VERY slow */
#define JITFUNCS 100
//#define JITFUNCS 0
#else
/** document the full version, please */
#define JITFUNCS 100
#endif
#endif

#include <assert.h>

#include "cpu_engine.hpp"
#include "cpu_memory.hpp"
#include "type_helpers.hpp"
#include "verbose.hpp"

#include "cpu_concat.hpp"
#include "cpu_sum.hpp"

// JITFUNCS removed -- frequent updates here make merges difficult
#include "cpu/ref_rnn.hpp"

#include "cpu/jit_avx512_core_u8s8s32x_1x1_convolution.hpp"
#include "cpu/jit_avx512_common_1x1_convolution.hpp"
#include "cpu/jit_avx512_common_convolution_winograd.hpp"
#include "cpu/jit_avx512_core_u8s8s32x_convolution.hpp"
#include "cpu/jit_avx512_common_convolution.hpp"
#include "cpu/jit_avx2_1x1_convolution.hpp"
#include "cpu/jit_sse42_1x1_convolution.hpp"
#include "cpu/jit_avx2_convolution.hpp"
#include "cpu/jit_sse42_convolution.hpp"
#include "cpu/gemm_convolution.hpp"
#include "cpu/gemm_u8s8s32x_convolution.hpp"
#include "cpu/ref_convolution_3d.hpp"
#include "cpu/ref_convolution.hpp"
#include "cpu/ref_deconvolution.hpp"
#include "cpu/jit_uni_eltwise.hpp"
#include "cpu/ref_eltwise.hpp"
#include "cpu/ref_softmax.hpp"
#include "cpu/jit_uni_pooling.hpp"
#include "cpu/jit_avx512_core_i8i8_pooling.hpp"
#include "cpu/ref_pooling.hpp"
#include "cpu/nchw_pooling.hpp"
#include "cpu/jit_avx512_common_lrn.hpp"
#include "cpu/jit_uni_lrn.hpp"
#include "cpu/ref_lrn.hpp"
#include "cpu/jit_uni_batch_normalization.hpp"
#include "cpu/ref_batch_normalization.hpp"
#include "cpu/ref_inner_product.hpp"
#include "cpu/gemm_inner_product.hpp"
#include "cpu/jit_uni_inner_product.hpp"
#include "cpu/jit_uni_dw_convolution.hpp"

namespace mkldnn {
namespace impl {
namespace cpu {

using namespace mkldnn::impl::status;

status_t cpu_engine_t::memory_primitive_desc_create(memory_pd_t **pd,
        const memory_desc_t *desc) {
    return safe_ptr_assign<memory_pd_t>(*pd,
            new cpu_memory_t::pd_t(this, desc));
}

status_t cpu_engine_t::view_primitive_desc_create(view_pd_t **view_pd,
            const memory_pd_t *memory_pd, const dims_t dims,
            const dims_t offsets) {
    assert(memory_pd->engine() == this);
    auto mpd = (const cpu_memory_t::pd_t *)memory_pd;
    /* FIXME: what if failed? */
    return safe_ptr_assign<view_pd_t>(*view_pd,
            new cpu_view_t::pd_t(this, mpd, dims, offsets));
}

using pd_create_f = mkldnn::impl::engine_t::primitive_desc_create_f;

namespace {
using namespace mkldnn::impl::data_type;

#if VERBOSE_PRIMITIVE_CREATE
/** A verbose version of primitive_desc_t::create<pd_t>. \sa primitive_desc.hpp */
template<typename prim>
#if !defined(_SX)
static
#endif
mkldnn::impl::status_t verbose_primitive_desc_create(
    mkldnn::impl::primitive_desc_t **pd,
    const mkldnn::impl::op_desc_t *adesc,
    const mkldnn::impl::primitive_attr_t *attr,
    mkldnn::impl::engine_t *engine,
    const mkldnn::impl::primitive_desc_t *hint_fwd)
{
    using namespace std;
    typedef typename prim::pd_t pd_t;
    mkldnn::impl::status_t ret = primitive_desc_t::create<pd_t>( pd, adesc,
            attr, engine, hint_fwd );
    if( ret == success )
        printf(" create<%s>::pd_t(pd,adesc,engine,hint_fwd) --> %d\n",
                (*pd)->name(), ret );
    return ret;
}
#define INSTANCE(...) &verbose_primitive_desc_create<__VA_ARGS__>
#else // original
#define INSTANCE(...) &primitive_desc_t::create<__VA_ARGS__::pd_t>
#endif

static const pd_create_f cpu_impl_list[] = {
    /* RNN */
    INSTANCE(ref_rnn_fwd_t),
    INSTANCE(ref_rnn_bwd_t),
    /* conv 3d */
    INSTANCE(ref_convolution_3d_fwd_t<f32>),
    INSTANCE(ref_convolution_3d_fwd_t<s16,s16, s32, s32>),
    INSTANCE(ref_convolution_3d_fwd_t<u8, s8, s32, s32>),
    INSTANCE(ref_convolution_3d_fwd_t<u8, s8, s8, s32>),
    INSTANCE(ref_convolution_3d_fwd_t<u8, s8, u8, s32>),
    INSTANCE(ref_convolution_3d_bwd_data_t<f32, f32, f32, f32>),
    INSTANCE(ref_convolution_3d_bwd_data_t<s32, s16, s16, s32>),
    INSTANCE(ref_convolution_3d_bwd_weights_t<f32, f32, f32, f32>),
    INSTANCE(ref_convolution_3d_bwd_weights_t<s16, s32, s16, s32>),
    /* conv */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_dw_convolution_fwd_t),
    INSTANCE(jit_avx512_common_dw_convolution_bwd_data_t),
    INSTANCE(jit_avx512_common_1x1_convolution_fwd_f32_t),
    INSTANCE(jit_avx512_common_1x1_convolution_bwd_data_f32_t),
    INSTANCE(jit_avx512_common_1x1_convolution_bwd_weights_t),
    INSTANCE(jit_avx512_common_1x1_convolution_fwd_s16s16s32_t),
    INSTANCE(jit_avx512_common_1x1_convolution_bwd_data_s16s16s32_t),
    INSTANCE(jit_avx512_common_convolution_winograd_fwd_t),
    INSTANCE(jit_avx512_common_convolution_winograd_bwd_data_t),
    INSTANCE(jit_avx512_common_convolution_winograd_bwd_weights_t),
    INSTANCE(jit_avx512_common_convolution_fwd_t<f32>),
    //INSTANCE(_jit_avx512_core_u8s8s32x_convolution_fwd_t<false, f32>),
    INSTANCE(jit_avx512_common_convolution_bwd_data_t<f32>),
    INSTANCE(jit_avx512_common_convolution_bwd_weights_t<f32>),
    INSTANCE(jit_avx2_dw_convolution_fwd_t),
    INSTANCE(jit_avx2_dw_convolution_bwd_data_t),
    INSTANCE(jit_avx2_1x1_convolution_fwd_t),
    INSTANCE(jit_avx2_1x1_convolution_bwd_data_t),
    INSTANCE(jit_avx2_1x1_convolution_bwd_weights_t),
    INSTANCE(jit_sse42_dw_convolution_fwd_t),
    INSTANCE(jit_sse42_dw_convolution_bwd_data_t),
    INSTANCE(jit_sse42_1x1_convolution_fwd_t),
    INSTANCE(jit_avx2_convolution_fwd_t),
    INSTANCE(jit_avx2_convolution_bwd_data_t),
    INSTANCE(jit_avx2_convolution_bwd_weights_t),
    INSTANCE(jit_sse42_convolution_fwd_t),
#endif
    INSTANCE(mkl_gemm_convolution_fwd_t),
    INSTANCE(mkl_gemm_convolution_bwd_data_t),
    INSTANCE(mkl_gemm_convolution_bwd_weights_t),
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_gemm_convolution_fwd_t),
    INSTANCE(jit_avx512_common_gemm_convolution_bwd_data_t),
    INSTANCE(jit_avx512_common_gemm_convolution_bwd_weights_t),
    INSTANCE(jit_avx2_gemm_convolution_fwd_t),
    INSTANCE(jit_avx2_gemm_convolution_bwd_data_t),
    INSTANCE(jit_avx2_gemm_convolution_bwd_weights_t),
#endif
    INSTANCE(ref_convolution_fwd_t<f32>),
    INSTANCE(ref_convolution_bwd_data_t<f32, f32, f32, f32>),
    INSTANCE(ref_convolution_bwd_weights_t<f32, f32, f32, f32>),
    /* conv (int) */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_convolution_fwd_t<s16, s16, s32>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_fwd_t<f32>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_fwd_t<s32>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_fwd_t<u8>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_fwd_t<s8>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_fwd_t<f32>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_fwd_t<s32>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_fwd_t<u8>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_fwd_t<s8>),
    INSTANCE(jit_avx512_common_convolution_bwd_data_t<s16, s16, s32>),
    INSTANCE(jit_avx512_common_convolution_bwd_weights_t<s16, s16, s32>),
#endif
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<false, s32>),
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<false, u8>),
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<false, s8>),
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<false, f32>),
    INSTANCE(ref_convolution_fwd_t<s16,s16, s32, s32>),
    INSTANCE(ref_convolution_fwd_t<u8, s8, s32, s32>),
    INSTANCE(ref_convolution_fwd_t<u8, s8, s8, s32>),
    INSTANCE(ref_convolution_fwd_t<u8, s8, u8, s32>),
    INSTANCE(ref_convolution_bwd_data_t<s32, s16, s16, s32>),
    INSTANCE(ref_convolution_bwd_weights_t<s16, s32, s16, s32>),
    /* deconv */
    INSTANCE(ref_deconvolution_bwd_weights_t),
    INSTANCE(ref_deconvolution_bwd_data_t),
    INSTANCE(ref_deconvolution_fwd_t),
    /* eltwise */
#if JITFUNCS > 99
    INSTANCE(jit_uni_eltwise_fwd_t<avx512_common>),
    INSTANCE(jit_uni_eltwise_bwd_t<avx512_common>),
    INSTANCE(jit_uni_eltwise_fwd_t<avx2>),
    INSTANCE(jit_uni_eltwise_bwd_t<avx2>),
    INSTANCE(jit_uni_eltwise_fwd_t<sse42>),
    INSTANCE(jit_uni_eltwise_bwd_t<sse42>),
#endif
    INSTANCE(ref_eltwise_fwd_t<f32>),
    INSTANCE(ref_eltwise_bwd_t<f32>),
    /* eltwise (int) */
    INSTANCE(ref_eltwise_fwd_t<s32>),
    INSTANCE(ref_eltwise_fwd_t<s16>),
    INSTANCE(ref_eltwise_fwd_t<s8>),
    INSTANCE(ref_eltwise_fwd_t<u8>),
    INSTANCE(ref_eltwise_bwd_t<s32>),
    INSTANCE(ref_eltwise_bwd_t<s16>),
    /* softmax */
    INSTANCE(ref_softmax_fwd_t<f32>),
    /* pool */
#if JITFUNCS > 99
    INSTANCE(jit_uni_pooling_fwd_t<avx512_common>),
    INSTANCE(jit_uni_pooling_bwd_t<avx512_common>),
    INSTANCE(jit_uni_pooling_fwd_t<avx2>),
    INSTANCE(jit_uni_pooling_bwd_t<avx2>),
    INSTANCE(jit_uni_pooling_fwd_t<sse42>),
    INSTANCE(jit_uni_pooling_bwd_t<sse42>),
#endif
    INSTANCE(nchw_pooling_fwd_t<f32>),
    INSTANCE(nchw_pooling_bwd_t<f32>),
    INSTANCE(ref_pooling_fwd_t<f32>),
    INSTANCE(ref_pooling_bwd_t<f32>),
    /* pool (int) */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_core_i8i8_pooling_fwd_t),
#endif
    INSTANCE(ref_pooling_fwd_t<s32>),
    INSTANCE(ref_pooling_fwd_t<s16, s32>),
    INSTANCE(ref_pooling_fwd_t<s8, s32>),
    INSTANCE(ref_pooling_fwd_t<u8, s32>),
    INSTANCE(ref_pooling_bwd_t<s32>),
    INSTANCE(ref_pooling_bwd_t<s16, s32>),
    /* lrn */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_lrn_fwd_t),
    INSTANCE(jit_avx512_common_lrn_bwd_t),
    INSTANCE(jit_uni_lrn_fwd_t<avx2>),
    INSTANCE(jit_uni_lrn_bwd_t<avx2>),
    INSTANCE(jit_uni_lrn_fwd_t<sse42>),
#endif
    INSTANCE(ref_lrn_fwd_t<f32>),
    INSTANCE(ref_lrn_bwd_t<f32>),
    /* batch normalization */
#if JITFUNCS > 99
    INSTANCE(jit_uni_batch_normalization_fwd_t<avx512_common>),
    INSTANCE(jit_uni_batch_normalization_bwd_t<avx512_common>),
    INSTANCE(jit_uni_batch_normalization_fwd_t<avx2>),
    INSTANCE(jit_uni_batch_normalization_bwd_t<avx2>),
    INSTANCE(jit_uni_batch_normalization_fwd_t<sse42>),
#endif
    INSTANCE(ref_batch_normalization_fwd_t<f32>),
    INSTANCE(ref_batch_normalization_bwd_t<f32>),
    /* inner product */
    INSTANCE(gemm_inner_product_fwd_t<f32>),
    INSTANCE(gemm_inner_product_bwd_data_t<f32>),
    INSTANCE(gemm_inner_product_bwd_weights_t<f32>),
#if JITFUNCS > 99
    INSTANCE(jit_uni_inner_product_fwd_t<avx512_common>),
    INSTANCE(jit_uni_inner_product_bwd_weights_t<avx512_common>),
    INSTANCE(jit_uni_inner_product_bwd_data_t<avx512_common>),
    INSTANCE(jit_uni_inner_product_fwd_t<avx2>),
    INSTANCE(jit_uni_inner_product_bwd_weights_t<avx2>),
    INSTANCE(jit_uni_inner_product_bwd_data_t<avx2>),
#endif
    INSTANCE(ref_inner_product_fwd_t<f32>),
    INSTANCE(ref_inner_product_bwd_data_t<f32, f32, f32, f32>),
    INSTANCE(ref_inner_product_bwd_weights_t<f32>),
    /* inner product (int) */
    INSTANCE(ref_inner_product_fwd_t<s16, s16, s32, s32>),
    INSTANCE(ref_inner_product_bwd_data_t<s32, s16, s16, s32>),
    INSTANCE(ref_inner_product_fwd_t<u8, s8, u8, s32>),
    /* conv_eltwise */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_dw_convolution_relu_t),
    INSTANCE(jit_avx512_common_convolution_winograd_relu_t),
    INSTANCE(jit_avx512_common_1x1_convolution_relu_f32_t),
    INSTANCE(jit_avx512_common_convolution_relu_t<f32>),
    INSTANCE(jit_avx2_dw_convolution_relu_t),
    INSTANCE(jit_avx2_1x1_convolution_relu_t),
    INSTANCE(jit_sse42_dw_convolution_relu_t),
    INSTANCE(jit_sse42_1x1_convolution_relu_t),
    INSTANCE(jit_avx2_convolution_relu_t),
    INSTANCE(jit_sse42_convolution_relu_t),
#endif
    INSTANCE(mkl_gemm_convolution_relu_t),
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_gemm_convolution_relu_t),
    INSTANCE(jit_avx2_gemm_convolution_relu_t),
#endif
    INSTANCE(ref_convolution_relu_t<f32>),
    /* conv_eltwise (int) */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_1x1_convolution_relu_s16s16s32_t),
    INSTANCE(jit_avx512_common_convolution_relu_t<s16, s16, s32>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_relu_t<f32>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_relu_t<s32>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_relu_t<s8>),
    INSTANCE(jit_avx512_core_u8s8s32x_1x1_convolution_relu_t<u8>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_relu_t<f32>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_relu_t<s32>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_relu_t<u8>),
    INSTANCE(jit_avx512_core_u8s8s32x_convolution_relu_t<s8>),
#endif
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<true, s32>),
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<true, u8>),
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<true, s8>),
    INSTANCE(_gemm_u8s8s32x_convolution_fwd_t<true, f32>),
    INSTANCE(ref_convolution_relu_t<s16, s16, s32, s32>),
    INSTANCE(ref_convolution_relu_t<u8, s8, s32, s32>),
    INSTANCE(ref_convolution_relu_t<u8, s8, s8, s32>),
    INSTANCE(ref_convolution_relu_t<u8, s8, u8, s32>),
    /* eol */
    nullptr,
};
#undef INSTANCE
}

const pd_create_f* cpu_engine_t::get_implementation_list() const {
    return cpu_impl_list;
}

cpu_engine_factory_t engine_factory;

status_t cpu_engine_t::submit(primitive_t *p, event_t *e,
        event_vector &prerequisites) {
    /* FIXME: this should live in primitive execute function... */
    if (mkldnn_verbose()->level) {
        double ms = get_msec();
        p->execute(e);
        ms = get_msec() - ms;
        printf("mkldnn_verbose,exec,%s,%g\n", p->pd()->info(), ms);
        fflush(0);
    } else {
        p->execute(e);
    }
    return success;
}

}
}
}

// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
