/*******************************************************************************
* Copyright 2016-2017 Intel Corporation
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

#include "cpu_concat.hpp"
#include "cpu_sum.hpp"

#if JITFUNCS > 99
#include "jit_avx512_common_1x1_convolution.hpp"
#ifndef _WIN32
#include "jit_avx512_common_convolution_winograd.hpp"
#endif
#include "jit_avx512_common_convolution.hpp"
#include "jit_avx2_1x1_convolution.hpp"
#include "jit_sse42_1x1_convolution.hpp"
#include "jit_avx2_convolution.hpp"
#include "jit_avx512_core_u8s8u8_convolution.hpp"
#include "jit_sse42_convolution.hpp"
#endif
#include "gemm_convolution.hpp"
#include "ref_convolution.hpp"
#if JITFUNCS > 99
#include "jit_uni_eltwise.hpp"
#endif
#include "ref_eltwise.hpp"
#include "ref_softmax.hpp"
#if JITFUNCS > 99
#include "jit_uni_pooling.hpp"
#endif
#include "ref_pooling.hpp"
#include "nchw_pooling.hpp"
#if JITFUNCS > 99
#include "jit_avx512_common_lrn.hpp"
#include "jit_uni_lrn.hpp"
#endif
#include "ref_lrn.hpp"
#if JITFUNCS > 99
#include "jit_uni_batch_normalization.hpp"
#endif
#include "ref_batch_normalization.hpp"
#include "ref_inner_product.hpp"
#include "gemm_inner_product.hpp"
#if JITFUNCS > 99
#include "jit_uni_inner_product.hpp"
#include "jit_avx512_mic_s16s16s32_convolution.hpp"

#include "jit_reorder.hpp"
#endif
#include "simple_reorder.hpp"

#if VERBOSE_PRIMITIVE_CREATE
#include <iostream>
#include <typeinfo>
#include "mkldnn_io.hpp"
#endif

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

status_t cpu_engine_t::concat_primitive_desc_create(concat_pd_t **concat_pd,
        const memory_desc_t *output_d, int n, int concat_dim,
        const memory_pd_t **input_pds) {
    assert(input_pds[0]->engine() == this);
    auto i_pds = (const cpu_memory_t::pd_t **)input_pds;
    return safe_ptr_assign<concat_pd_t>(*concat_pd,
            new cpu_concat_t::pd_t(this, output_d, n, concat_dim, i_pds));
}

status_t cpu_engine_t::sum_primitive_desc_create(sum_pd_t **sum_pd,
        const memory_desc_t *output_d, int n, double* scale,
        const memory_pd_t **input_pds) {
    assert(input_pds[0]->engine() == this);
    auto i_pds = (const cpu_memory_t::pd_t **)input_pds;
    return safe_ptr_assign<sum_pd_t>(*sum_pd,
        new cpu_sum_t::pd_t(this, output_d, n, scale, i_pds));
}

using rpd_create_f = mkldnn::impl::engine_t::reorder_primitive_desc_create_f;
using pd_create_f = mkldnn::impl::engine_t::primitive_desc_create_f;

namespace {
using namespace mkldnn::impl::data_type;
using namespace mkldnn::impl::memory_format;

static const rpd_create_f cpu_reorder_impl_list[] = {
    /* fp32 <-> fp32 */
    simple_reorder_t<f32, any, f32, any, fmt_order::any, spec::direct_copy>::pd_t::create,
    simple_reorder_t<f32, any, f32, any, fmt_order::any, spec::direct_copy_except_dim_0>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, nChw8c, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, nChw8c, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, chwn, f32, nChw8c, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, chwn, f32, nChw8c, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, nChw16c, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, nChw16c, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<s32, nchw, s32, nChw16c, fmt_order::keep>::pd_t::create,
    simple_reorder_t<s32, nchw, s32, nChw16c, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, chwn, f32, nChw16c, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, chwn, f32, nChw16c, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, nChw8c, f32, nChw16c, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, nChw8c, f32, nChw16c, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, nhwc, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, nhwc, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, chwn, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, nchw, f32, chwn, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, oihw, f32, OIhw8i8o, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, oihw, f32, OIhw8i8o, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, oihw, f32, OIhw16i16o, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, oihw, f32, OIhw16i16o, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, goihw, f32, gOIhw8i8o, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, goihw, f32, gOIhw8i8o, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, goihw, f32, gOIhw16i16o, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, goihw, f32, gOIhw16i16o, fmt_order::reverse>::pd_t::create,
#ifndef TARGET_VANILLA
    jit_reorder_t<f32, OIhw8i8o, f32, OIhw8o8i, fmt_order::keep>::pd_t::create,
    jit_reorder_t<f32, OIhw8i8o, f32, OIhw8o8i, fmt_order::reverse>::pd_t::create,
#endif
    simple_reorder_t<f32, OIhw8i8o, f32, OIhw8o8i, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, OIhw8i8o, f32, OIhw8o8i, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, OIhw16i16o, f32, OIhw16o16i, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, OIhw16i16o, f32, OIhw16o16i, fmt_order::reverse>::pd_t::create,
#ifndef TARGET_VANILLA
    jit_reorder_t<f32, gOIhw8i8o, f32, gOIhw8o8i, fmt_order::keep>::pd_t::create,
    jit_reorder_t<f32, gOIhw8i8o, f32, gOIhw8o8i, fmt_order::reverse>::pd_t::create,
#endif
    simple_reorder_t<f32, gOIhw8i8o, f32, gOIhw8o8i, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, gOIhw8i8o, f32, gOIhw8o8i, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, gOIhw16i16o, f32, gOIhw16o16i, fmt_order::keep>::pd_t::create,
    simple_reorder_t<f32, gOIhw16i16o, f32, gOIhw16o16i, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<f32, any, f32, any, fmt_order::any, spec::reference>::pd_t::create,
    /* s32 <-> fp32 */
    simple_reorder_t<f32, any, s32, any, fmt_order::any, spec::reference>::pd_t::create,
    simple_reorder_t<s32, any, f32, any, fmt_order::any, spec::reference>::pd_t::create,
    /* s16 <-> fp32 */
    simple_reorder_t<f32, any, s16, any, fmt_order::any, spec::reference>::pd_t::create,
    simple_reorder_t<s16, any, f32, any, fmt_order::any, spec::reference>::pd_t::create,
    /* s8 <-> fp32 */
    simple_reorder_t<f32, any, s8, any, fmt_order::any, spec::reference>::pd_t::create,
    simple_reorder_t<s8, any, f32, any, fmt_order::any, spec::reference>::pd_t::create,
    /* u8 <-> fp32 */
    simple_reorder_t<f32, any, u8, any, fmt_order::any, spec::reference>::pd_t::create,
    simple_reorder_t<u8, any, f32, any, fmt_order::any, spec::reference>::pd_t::create,
    /* s16 <-> s16 */
    simple_reorder_t<s16, any, s16, any, fmt_order::any, spec::direct_copy>::pd_t::create,
    simple_reorder_t<s16, any, s16, any, fmt_order::any, spec::direct_copy_except_dim_0>::pd_t::create,
    simple_reorder_t<s16, oihw, s16, OIhw8i16o2i, fmt_order::keep>::pd_t::create,
    simple_reorder_t<s16, oihw, s16, OIhw8i16o2i, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<s16, goihw, s16, gOIhw8i16o2i, fmt_order::keep>::pd_t::create,
    simple_reorder_t<s16, goihw, s16, gOIhw8i16o2i, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<s16, OIhw8i16o2i, s16, OIhw8o16i2o, fmt_order::keep>::pd_t::create,
    simple_reorder_t<s16, OIhw8i16o2i, s16, OIhw8o16i2o, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<s16, gOIhw8i16o2i, s16, gOIhw8o16i2o, fmt_order::keep>::pd_t::create,
    simple_reorder_t<s16, gOIhw8i16o2i, s16, gOIhw8o16i2o, fmt_order::reverse>::pd_t::create,
    simple_reorder_t<s16, any, s16, any, fmt_order::any, spec::reference>::pd_t::create,
    /* eol */
    nullptr,
};

#if VERBOSE_PRIMITIVE_CREATE
/** A verbose version of primitive_desc_t::create<pd_t>. \sa primitive_desc.hpp */
template<typename prim>
static mkldnn::impl::status_t verbose_primitive_desc_create(
    mkldnn::impl::primitive_desc_t **pd,
    const mkldnn::impl::op_desc_t *adesc,
    mkldnn::impl::engine_t *engine,
    const mkldnn::impl::primitive_desc_t *hint_fwd)
{
    using namespace std;
    typedef typename prim::pd_t pd_t;
    mkldnn::impl::status_t ret = primitive_desc_t::create<pd_t>( pd, adesc, engine, hint_fwd );
    cout<<" create<"<<typeid(prim).name()<<">::pd_t(pd,adesc,engine,hint_fwd) --> "<<ret<<endl;
    return ret;
}
#define INSTANCE(...) &verbose_primitive_desc_create<__VA_ARGS__>
#else // original
#define INSTANCE(...) &primitive_desc_t::create<__VA_ARGS__::pd_t>
#endif
static const pd_create_f cpu_impl_list[] = {
    /* conv */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_1x1_convolution_fwd_f32_t),
    INSTANCE(jit_avx512_common_1x1_convolution_bwd_data_f32_t),
    INSTANCE(jit_avx512_common_1x1_convolution_bwd_weights_t),
    INSTANCE(jit_avx512_common_1x1_convolution_fwd_s16s16s32_t),
    INSTANCE(jit_avx512_common_1x1_convolution_bwd_data_s16s16s32_t),
#ifndef _WIN32
    INSTANCE(jit_avx512_common_convolution_winograd_fwd_t),
    INSTANCE(jit_avx512_common_convolution_winograd_bwd_data_t),
    INSTANCE(jit_avx512_common_convolution_winograd_bwd_weights_t),
#endif
    INSTANCE(jit_avx512_common_convolution_fwd_t<data_type::f32>),
    INSTANCE(jit_avx512_common_convolution_bwd_data_t<data_type::f32>),
    INSTANCE(jit_avx512_common_convolution_bwd_weights_t),
    INSTANCE(jit_avx2_1x1_convolution_fwd_t),
    INSTANCE(jit_avx2_1x1_convolution_bwd_data_t),
    INSTANCE(jit_avx2_1x1_convolution_bwd_weights_t),
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
    INSTANCE(ref_convolution_fwd_t<data_type::f32>),
    INSTANCE(ref_convolution_bwd_data_t<data_type::f32>),
    INSTANCE(ref_convolution_bwd_weights_t<data_type::f32>),
    /* conv (int) */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_convolution_fwd_t<data_type::s16,
             data_type::s16, data_type::s32>),
    INSTANCE(_jit_avx512_core_u8s8s32x_convolution_fwd_t<false, data_type::s32>),
    INSTANCE(_jit_avx512_core_u8s8s32x_convolution_fwd_t<false, data_type::s8>),
    INSTANCE(_jit_avx512_core_u8s8s32x_convolution_fwd_t<false, data_type::u8>),
    INSTANCE(jit_avx512_common_convolution_bwd_data_t<data_type::s16,
             data_type::s16, data_type::s32>),
#endif
    INSTANCE(ref_convolution_fwd_t<data_type::s16,data_type::s16,
            data_type::s32, data_type::s32>),
    INSTANCE(ref_convolution_fwd_t<data_type::u8, data_type::s8,
            data_type::s32, data_type::s32>),
    INSTANCE(ref_convolution_fwd_t<data_type::u8, data_type::s8,
            data_type::s32, data_type::s8>),
    INSTANCE(ref_convolution_fwd_t<data_type::u8, data_type::s8,
            data_type::s32, data_type::u8>),
    INSTANCE(ref_convolution_bwd_data_t<data_type::s16,data_type::s16,
            data_type::s32, data_type::s32>),
#if JITFUNCS > 99 /*was relu*/
    /* eltwise */
    INSTANCE(jit_uni_eltwise_fwd_t<avx512_common>),
    INSTANCE(jit_uni_eltwise_bwd_t<avx512_common>),
    INSTANCE(jit_uni_eltwise_fwd_t<avx2>),
    INSTANCE(jit_uni_eltwise_bwd_t<avx2>),
    INSTANCE(jit_uni_eltwise_fwd_t<sse42>),
    INSTANCE(jit_uni_eltwise_bwd_t<sse42>),
#endif
    INSTANCE(ref_eltwise_fwd_t<data_type::f32>),
    INSTANCE(ref_eltwise_bwd_t<data_type::f32>),
    /* eltwise (int) */
    INSTANCE(ref_eltwise_fwd_t<data_type::s32>),
    INSTANCE(ref_eltwise_fwd_t<data_type::s16>),
    INSTANCE(ref_eltwise_fwd_t<data_type::s8>),
    INSTANCE(ref_eltwise_fwd_t<data_type::u8>),
    INSTANCE(ref_eltwise_bwd_t<data_type::s32>),
    INSTANCE(ref_eltwise_bwd_t<data_type::s16>),
    /* softmax */
    INSTANCE(ref_softmax_fwd_t<data_type::f32>),
    /* pool */
#if JITFUNCS > 99
    INSTANCE(jit_uni_pooling_fwd_t<avx512_common>),
    INSTANCE(jit_uni_pooling_bwd_t<avx512_common>),
    INSTANCE(jit_uni_pooling_fwd_t<avx2>),
    INSTANCE(jit_uni_pooling_bwd_t<avx2>),
    INSTANCE(jit_uni_pooling_fwd_t<sse42>),
    INSTANCE(jit_uni_pooling_bwd_t<sse42>),
#endif
    INSTANCE(nchw_pooling_fwd_t<data_type::f32>),
    INSTANCE(nchw_pooling_bwd_t<data_type::f32>),
    INSTANCE(ref_pooling_fwd_t<data_type::f32>),
    INSTANCE(ref_pooling_bwd_t<data_type::f32>),
    /* pool (int) */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_core_i8i8_pooling_fwd_t),
#endif
    INSTANCE(ref_pooling_fwd_t<data_type::s32>),
    INSTANCE(ref_pooling_fwd_t<data_type::s16, data_type::s32>),
    INSTANCE(ref_pooling_fwd_t<data_type::s8, data_type::s32>),
    INSTANCE(ref_pooling_fwd_t<data_type::u8, data_type::s32>),
    INSTANCE(ref_pooling_bwd_t<data_type::s32>),
    INSTANCE(ref_pooling_bwd_t<data_type::s16, data_type::s32>),
    /* lrn */
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_lrn_fwd_t),
    INSTANCE(jit_avx512_common_lrn_bwd_t),
    INSTANCE(jit_uni_lrn_fwd_t<avx2>),
    INSTANCE(jit_uni_lrn_bwd_t<avx2>),
    INSTANCE(jit_uni_lrn_fwd_t<sse42>),
#endif
    INSTANCE(ref_lrn_fwd_t<data_type::f32>),
    INSTANCE(ref_lrn_bwd_t<data_type::f32>),
    /* batch normalization */
#if JITFUNCS > 99
    INSTANCE(jit_uni_batch_normalization_fwd_t<avx512_common>),
    INSTANCE(jit_uni_batch_normalization_bwd_t<avx512_common>),
    INSTANCE(jit_uni_batch_normalization_fwd_t<avx2>),
    INSTANCE(jit_uni_batch_normalization_bwd_t<avx2>),
    INSTANCE(jit_uni_batch_normalization_fwd_t<sse42>),
#endif
    INSTANCE(ref_batch_normalization_fwd_t<data_type::f32>),
    INSTANCE(ref_batch_normalization_bwd_t<data_type::f32>),
    /* inner product */
    INSTANCE(gemm_inner_product_fwd_t<data_type::f32>),
    INSTANCE(gemm_inner_product_bwd_data_t<data_type::f32>),
    INSTANCE(gemm_inner_product_bwd_weights_t<data_type::f32>),
#if JITFUNCS > 99
    INSTANCE(jit_uni_inner_product_fwd_t<avx512_common>),
    INSTANCE(jit_uni_inner_product_bwd_weights_t<avx512_common>),
    INSTANCE(jit_uni_inner_product_bwd_data_t<avx512_common>),
    INSTANCE(jit_uni_inner_product_fwd_t<avx2>),
    INSTANCE(jit_uni_inner_product_bwd_weights_t<avx2>),
    INSTANCE(jit_uni_inner_product_bwd_data_t<avx2>),
#endif
    INSTANCE(ref_inner_product_fwd_t<data_type::f32>),
    INSTANCE(ref_inner_product_bwd_data_t<data_type::f32>),
    INSTANCE(ref_inner_product_bwd_weights_t<data_type::f32>),
    /* inner product (int) */
    INSTANCE(ref_inner_product_fwd_t<data_type::s16, data_type::s16,
            data_type::s32, data_type::s32>),
    INSTANCE(ref_inner_product_bwd_data_t<data_type::s16, data_type::s16,
            data_type::s32, data_type::s32>),
    INSTANCE(ref_inner_product_fwd_t<data_type::u8, data_type::s8,
            data_type::s32, data_type::u8>),
#if JITFUNCS > 99
    /* conv_eltwise */
#ifndef _WIN32
    INSTANCE(jit_avx512_common_convolution_winograd_relu_t),
#endif
    INSTANCE(jit_avx512_common_1x1_convolution_relu_f32_t),
    INSTANCE(jit_avx512_common_1x1_convolution_relu_s16s16s32_t),
    INSTANCE(jit_avx512_common_convolution_relu_t<data_type::f32>),
    INSTANCE(jit_avx2_1x1_convolution_relu_t),
    INSTANCE(jit_sse42_1x1_convolution_relu_t),
    INSTANCE(jit_avx2_convolution_relu_t),
    INSTANCE(jit_sse42_convolution_relu_t),
#endif
    INSTANCE(mkl_gemm_convolution_relu_t),
#if JITFUNCS > 99
    INSTANCE(jit_avx512_common_gemm_convolution_relu_t),
    INSTANCE(jit_avx2_gemm_convolution_relu_t),
#endif
    INSTANCE(ref_convolution_relu_t<data_type::f32>),
    /* conv_eltwise (int) */
#if JITFUNCS > 99
    INSTANCE(_jit_avx512_core_u8s8s32x_convolution_fwd_t<true, data_type::s32>),
    INSTANCE(_jit_avx512_core_u8s8s32x_convolution_fwd_t<true, data_type::s8>),
    INSTANCE(_jit_avx512_core_u8s8s32x_convolution_fwd_t<true, data_type::u8>),
    INSTANCE(jit_avx512_common_convolution_relu_t<data_type::s16,
            data_type::s16, data_type::s32>),
#endif
    INSTANCE(ref_convolution_relu_t<data_type::s16, data_type::s16,
            data_type::s32, data_type::s32>),
    INSTANCE(ref_convolution_relu_t<data_type::u8, data_type::s8,
            data_type::s32, data_type::s32>),
    INSTANCE(ref_convolution_relu_t<data_type::u8, data_type::s8,
            data_type::s32, data_type::s8>),
    INSTANCE(ref_convolution_relu_t<data_type::u8, data_type::s8,
            data_type::s32, data_type::u8>),
    /* eol */
    nullptr,
};
#undef INSTANCE
}

const rpd_create_f* cpu_engine_t::get_reorder_implementation_list() const {
    return cpu_reorder_impl_list;
}

const pd_create_f* cpu_engine_t::get_implementation_list() const {
    return cpu_impl_list;
}

cpu_engine_factory_t engine_factory;

status_t cpu_engine_t::submit(primitive_t *p, event_t *e,
        event_vector &prerequisites) {
    p->execute(e);
    return success;
}

}
}
}

// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
