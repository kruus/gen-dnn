/*******************************************************************************
* Copyright 2016-2019 Intel Corporation
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

#include "cpu_isa_traits.hpp"
#include "type_helpers.hpp"
#include "verbose.hpp"

#include "cpu_engine.hpp"
#include "cpu_memory_storage.hpp"
#include "cpu_stream.hpp"
#include "memory.hpp"

#if !(defined(TARGET_VANILLA) || (defined(JITFUNCS) && JITFUNCS<0))
#include "cpu/rnn/ref_rnn.hpp" // now requires jit
#include "cpu/jit_avx512_core_x8s8s32x_1x1_convolution.hpp"
#include "cpu/jit_avx512_common_1x1_convolution.hpp"
#include "cpu/jit_avx512_core_f32_wino_conv_4x3.hpp"
#include "cpu/jit_avx512_common_convolution_winograd.hpp"
#include "cpu/jit_avx512_core_x8s8s32x_convolution.hpp"
#include "cpu/jit_avx512_core_bf16_convolution.hpp"
#include "cpu/jit_avx512_core_bf16_1x1_convolution.hpp"
#include "cpu/jit_avx512_common_convolution.hpp"
#include "cpu/jit_avx2_1x1_convolution.hpp"
#include "cpu/jit_sse41_1x1_convolution.hpp"
#include "cpu/jit_avx2_convolution.hpp"
#include "cpu/jit_sse41_convolution.hpp"
#include "cpu/jit_avx512_core_x8s8s32x_deconvolution.hpp"
#include "cpu/jit_avx512_core_x8s8s32x_1x1_deconvolution.hpp"
#include "cpu/jit_uni_eltwise.hpp"
#include "cpu/jit_uni_pooling.hpp"
#include "cpu/jit_uni_i8i8_pooling.hpp"
#include "cpu/jit_avx512_common_lrn.hpp"
#include "cpu/jit_uni_lrn.hpp"
#include "cpu/jit_uni_dw_convolution.hpp"
#include "cpu/jit_avx512_core_u8s8s32x_wino_convolution.hpp"
#include "cpu/jit_avx512_core_f32_wino_conv_2x3.hpp"
#include "cpu/jit_uni_batch_normalization.hpp"
#include "cpu/jit_uni_batch_normalization_s8.hpp"
#include "cpu/jit_uni_softmax.hpp"
#include "cpu/gemm_bf16_convolution.hpp"
#include "cpu/gemm_bf16_inner_product.hpp"
#endif

#include "cpu/gemm_convolution.hpp"
#include "cpu/gemm_x8s8s32x_convolution.hpp"
#include "cpu/ref_convolution.hpp"
#include "cpu/ref_deconvolution.hpp"
#include "cpu/ref_shuffle.hpp"
#include "cpu/ref_eltwise.hpp"
#include "cpu/ref_softmax.hpp"
#include "cpu/ref_pooling.hpp"
#include "cpu/nchw_pooling.hpp"
#include "cpu/nhwc_pooling.hpp"
#include "cpu/ref_lrn.hpp"
#include "cpu/ref_batch_normalization.hpp"
#include "cpu/ncsp_batch_normalization.hpp"
#include "cpu/nspc_batch_normalization.hpp"
#include "cpu/ref_inner_product.hpp"
#include "cpu/gemm_inner_product.hpp"
#include "cpu/gemm_x8s8s32x_inner_product.hpp"


#if VEJIT > 0
#include "vanilla/vednnx_convolution.hpp"
#endif

namespace mkldnn {
namespace impl {
namespace cpu {

status_t cpu_engine_t::create_memory_storage(
        memory_storage_t **storage, unsigned flags, size_t size, void *handle) {
    return safe_ptr_assign<memory_storage_t>(
            *storage, new cpu_memory_storage_t(this, flags, size, handle));
}

status_t cpu_engine_t::create_stream(stream_t **stream, unsigned flags) {
    return safe_ptr_assign<stream_t>(*stream, new cpu_stream_t(this, flags));
}

using pd_create_f = mkldnn::impl::engine_t::primitive_desc_create_f;

namespace {
using namespace mkldnn::impl::data_type;

//@{
/** Debug support.
 *
 * 1. Conditionally include set of impls based on -DJITFUNCS value.
 *    - Compare JITFUNCS with JITFUNCS\_xxx for xxx == ANY SSE42 AVX2 or AVX512
 * 2. Set VERBOSE_PRIMITIVE_CREATE to print the names of created primitives.
 */
#if VERBOSE_PRIMITIVE_CREATE
/** A verbose version of primitive_desc_t::create<pd_t>. \sa primitive_desc.hpp.
 * Note: now you can also just call mkldnn_verbose_set(2) in cpu_engine constructor (or so),
 *       and get more detailed info about execution and construction.
 * So the only real use of this is to track failed/successful creations (and not the executions) */
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
    // primitive_desc_t::query(query_t what, int idx, void *result)
    // case query::impl_info_str: *(const char **)result = name(); break;
    // so can check (*pd)->query(query::impl_info_str) and see if it is a jit impl
    using namespace std;
    using namespace mkldnn::impl;
    using namespace mkldnn::impl::status;
    typedef typename prim::pd_t pd_t;
    auto const ret = primitive_desc_t::create<pd_t>( pd, adesc, attr, engine,
            hint_fwd );
    if( ret == success ) {
        // actually the new 'info' call has it all..
        printf(" prim %s\n", (*pd)->info());
        //printf(" created descriptor %s name %s\n\t%s\n",
        //        mkldnn_prim_kind2str(adesc->kind), (*pd)->name(),
        //        (*pd)->info());
        // above line better; older mkl-dnn used mkldnn_primitive_desc_query
        //char const* result;
        //mkldnn_primitive_desc_query( *pd, mkldnn_query_impl_info_str, 0, &result );
        //printf(" created descriptor %s\n", result);
        //fflush(stdout);
    }else if(ret == unimplemented && /*opt.*/ adesc->kind == pd_t::base_pkind){
        printf(" skip-%s", mkldnn_prim_kind2str(adesc->kind)); fflush(stdout);
        // partially construct (no init(), no init_info()) to get the name()
        //     This allows printing right-kind-but-skipped messages
        //                      [see src/common/primitive_desc.hpp]
        // TODO: primitive_desc.hpp can return an optional const char* name()
        //       result, sometimes, even if the full construction failed.
        //    Q: Is prop_kind a universal attribute of all prim? Probably not.
        using pd_op_desc_t = typename pkind_traits<pd_t::base_pkind>::desc_type;
        auto _pd = new pd_t(engine, (const pd_op_desc_t *)adesc, attr,
            reinterpret_cast<const typename pd_t::hint_class *> (hint_fwd));
        if (_pd != nullptr){ // get the 'name()' ~ short impl_name string
            char const* name = _pd->name();
            printf(":%s", name);
            delete _pd;
        }
        printf("\n"); fflush(stdout);
    }else{
        // printing wrong-kind msg not too interesting [and lengthy]
        //printf(" no-%s", mkldnn_prim_kind2str(adesc->kind)); fflush(stdout);
    }
    return ret;
}
// unfortunately, a one-liner as follows would create a temporary...
//#define INSTANCE_CREATOR(...) WrapCreate(verbose_primitive_desc_create<__VA_ARGS__>, #__VA_ARGS__)
// so we "lose" the asked for name ...
#define INSTANCE_CREATOR(...) verbose_primitive_desc_create<__VA_ARGS__>
#else
#define INSTANCE_CREATOR(...) primitive_desc_t::create<__VA_ARGS__::pd_t>
#endif


#if JITFUNCS >= JITFUNCS_AVX512
#define INSTANCE_avx512(...) &INSTANCE_CREATOR(__VA_ARGS__),
//#warning "jit avx512 YES"
#else
//#warning "INSTANCE_avx512 is NO-OP"
#define INSTANCE_avx512(...)
#endif

#if JITFUNCS >= JITFUNCS_AVX2
#define INSTANCE_avx2(...) &INSTANCE_CREATOR(__VA_ARGS__),
#else
#define INSTANCE_avx2(...)
#endif

#if JITFUNCS >= JITFUNCS_AVX
#define INSTANCE_avx(...) &INSTANCE_CREATOR(__VA_ARGS__),
#else
#define INSTANCE_avx(...)
#endif

#if JITFUNCS >= JITFUNCS_SSE42
#define INSTANCE_sse42(...) &INSTANCE_CREATOR(__VA_ARGS__),
#else
#define INSTANCE_sse42(...)
#endif

#if JITFUNCS >= JITFUNCS_SSE41
#define INSTANCE_sse41(...) &INSTANCE_CREATOR(__VA_ARGS__),
#else
#define INSTANCE_sse41(...)
#endif

#if JITFUNCS >= JITFUNCS_SSE41
#define INSTANCE_uni(...) &INSTANCE_CREATOR(__VA_ARGS__),
#else
#define INSTANCE_uni(...)
#endif

#if JITFUNCS >= JITFUNCS_ANY // i.e. any x86 cpu
#define INSTANCE_any(...) &INSTANCE_CREATOR(__VA_ARGS__),
#else
#define INSTANCE_any(...)
#endif

#if VEJIT > 0 // an implementation ONLY working for VE
#define INSTANCE_ve(...) &INSTANCE_CREATOR(__VA_ARGS__),
#else
#define INSTANCE_ve(...)
#endif

// JITFUNCS >= JIT_FUNCS_ANY (always include this impl)
#define INSTANCE(...) &INSTANCE_CREATOR(__VA_ARGS__),
//@}

static const pd_create_f cpu_impl_list[] = {
    /* RNN */
    INSTANCE_any(ref_rnn_fwd_f32_t)
    INSTANCE_any(ref_rnn_fwd_u8s8_t)
    INSTANCE_any(ref_rnn_bwd_f32_t)
    /* conv */
    INSTANCE_avx512(jit_avx512_common_dw_convolution_fwd_t)
    INSTANCE_avx512(jit_avx512_common_dw_convolution_bwd_data_t)
    INSTANCE_avx512(jit_avx512_common_dw_convolution_bwd_weights_t)
    INSTANCE_avx512(jit_avx512_common_1x1_convolution_fwd_f32_t)
    INSTANCE_avx512(jit_avx512_common_1x1_convolution_bwd_data_f32_t)
    INSTANCE_avx512(jit_avx512_common_1x1_convolution_bwd_weights_t)
    INSTANCE_avx512(jit_avx512_core_f32_wino_conv_2x3_fwd_t)
    INSTANCE_avx512(jit_avx512_core_f32_wino_conv_4x3_fwd_t)
    INSTANCE_avx512(jit_avx512_core_f32_wino_conv_4x3_bwd_data_t)
    INSTANCE_avx512(jit_avx512_core_f32_wino_conv_4x3_bwd_weights_t)
    INSTANCE_avx512(jit_avx512_common_convolution_winograd_fwd_t)
    INSTANCE_avx512(jit_avx512_common_convolution_winograd_bwd_data_t)
    INSTANCE_avx512(jit_avx512_common_convolution_winograd_bwd_weights_t)
    INSTANCE_avx512(jit_avx512_common_convolution_fwd_t<f32>)
    INSTANCE_avx512(jit_avx512_common_convolution_bwd_data_t<f32>)
    INSTANCE_avx512(jit_avx512_common_convolution_bwd_weights_t<f32>)
    INSTANCE_avx2(jit_avx2_dw_convolution_fwd_t)
    INSTANCE_avx2(jit_avx2_dw_convolution_bwd_data_t)
    INSTANCE_avx2(jit_avx2_dw_convolution_bwd_weights_t)
    INSTANCE_avx2(jit_avx2_1x1_convolution_fwd_t)
    INSTANCE_avx2(jit_avx2_1x1_convolution_bwd_data_t)
    INSTANCE_avx2(jit_avx2_1x1_convolution_bwd_weights_t)
    INSTANCE_sse41(jit_sse41_dw_convolution_fwd_t)
    INSTANCE_sse41(jit_sse41_dw_convolution_bwd_data_t)
    INSTANCE_sse41(jit_sse41_dw_convolution_bwd_weights_t)
    INSTANCE_sse41(jit_sse41_1x1_convolution_fwd_t)
    INSTANCE_avx2(jit_avx2_convolution_fwd_t)
    INSTANCE_avx2(jit_avx2_convolution_bwd_data_t)
    INSTANCE_avx2(jit_avx2_convolution_bwd_weights_t)
    INSTANCE_sse41(jit_sse41_convolution_fwd_t)
    INSTANCE_ve(vednnx_convolution_fwd_t)
    INSTANCE_ve(vednnx_convolution_bwd_data_t)
    INSTANCE_ve(vednnx_convolution_bwd_weights_t)
    INSTANCE(gemm_convolution_fwd_t)
    INSTANCE(gemm_convolution_bwd_data_t)
    INSTANCE(gemm_convolution_bwd_weights_t)
    INSTANCE(ref_convolution_fwd_t<f32>)
    INSTANCE(ref_convolution_bwd_data_t<f32, f32, f32, f32>)
    INSTANCE(ref_convolution_bwd_weights_t<f32, f32, f32, f32>)
    /* conv (bfloat16) */
    INSTANCE_uni(jit_uni_dw_convolution_fwd_t<avx512_core, bf16, bf16>)
    INSTANCE_uni(jit_uni_dw_convolution_fwd_t<avx512_core, bf16, f32>)
    INSTANCE_uni(jit_uni_dw_convolution_bwd_data_t<avx512_core, bf16, bf16>)
    INSTANCE_uni(jit_uni_dw_convolution_bwd_data_t<avx512_core, bf16, f32>)
    INSTANCE_uni(jit_uni_dw_convolution_bwd_weights_t<avx512_core, bf16, bf16>)
    INSTANCE_uni(jit_uni_dw_convolution_bwd_weights_t<avx512_core, bf16, f32>)
    INSTANCE_avx512(jit_avx512_core_bf16_1x1_convolution_fwd_t<f32>)
    INSTANCE_avx512(jit_avx512_core_bf16_1x1_convolution_fwd_t<bf16>)
    INSTANCE_avx512(jit_avx512_core_bf16_1x1_convolution_bwd_data_t<f32>)
    INSTANCE_avx512(jit_avx512_core_bf16_1x1_convolution_bwd_data_t<bf16>)
    INSTANCE_avx512(jit_avx512_core_bf16_1x1_convolution_bwd_weights_t<f32>)
    INSTANCE_avx512(jit_avx512_core_bf16_1x1_convolution_bwd_weights_t<bf16>)
    INSTANCE_avx512(jit_avx512_core_bf16_convolution_fwd_t)
    INSTANCE_avx512(jit_avx512_core_bf16_convolution_bwd_data_t)
    INSTANCE_avx512(jit_avx512_core_bf16_convolution_bwd_weights_t)
    INSTANCE_sse41(gemm_bf16_convolution_fwd_t<f32>)
    INSTANCE_sse41(gemm_bf16_convolution_fwd_t<bf16>)
    INSTANCE_sse41(gemm_bf16_convolution_bwd_data_t<f32>)
    INSTANCE_sse41(gemm_bf16_convolution_bwd_data_t<bf16>)
    INSTANCE_sse41(gemm_bf16_convolution_bwd_weights_t<f32>)
    INSTANCE_sse41(gemm_bf16_convolution_bwd_weights_t<bf16>)
    /* conv (int) */
    INSTANCE_avx512(jit_avx512_core_u8s8s32x_wino_convolution_fwd_t<f32>)
    INSTANCE_avx512(jit_avx512_core_u8s8s32x_wino_convolution_fwd_t<s32>)
    INSTANCE_avx512(jit_avx512_core_u8s8s32x_wino_convolution_fwd_t<s8>)
    INSTANCE_avx512(jit_avx512_core_u8s8s32x_wino_convolution_fwd_t<u8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<u8,f32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<u8,s32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<u8,u8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<u8,s8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<s8,f32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<s8,s32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<s8,u8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_convolution_fwd_t<s8,s8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<u8,f32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<u8,s32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<u8,u8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<u8,s8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<s8,f32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<s8,s32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<s8,u8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_convolution_fwd_t<s8,s8>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<u8, s32>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<u8, u8>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<u8, s8>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<u8, f32>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<s8, s32>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<s8, u8>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<s8, s8>)
    INSTANCE(_gemm_x8s8s32x_convolution_fwd_t<s8, f32>)
    INSTANCE(_gemm_u8s8s32x_convolution_bwd_data_t<s32>)
    INSTANCE(_gemm_u8s8s32x_convolution_bwd_data_t<u8>)
    INSTANCE(_gemm_u8s8s32x_convolution_bwd_data_t<s8>)
    INSTANCE(_gemm_u8s8s32x_convolution_bwd_data_t<f32>)
    INSTANCE(ref_convolution_fwd_t<u8, s8, f32, s32>)
    INSTANCE(ref_convolution_fwd_t<u8, s8, s32, s32>)
    INSTANCE(ref_convolution_fwd_t<u8, s8, s8, s32>)
    INSTANCE(ref_convolution_fwd_t<u8, s8, u8, s32>)
    INSTANCE(ref_convolution_bwd_data_t<f32, s8, u8, s32>)
    INSTANCE(ref_convolution_bwd_data_t<s32, s8, u8, s32>)
    INSTANCE(ref_convolution_bwd_data_t<s8, s8, u8, s32>)
    INSTANCE(ref_convolution_bwd_data_t<u8, s8, u8, s32>)
    /* deconv */
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<u8,f32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<u8,s32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<u8,u8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<u8,s8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<s8,f32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<s8,s32>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<s8,u8>)
    INSTANCE_avx512(jit_avx512_core_x8s8s32x_1x1_deconvolution_fwd_t<s8,s8>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<u8,s32>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<u8,u8>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<u8,s8>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<u8,f32>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<s8,s32>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<s8,u8>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<s8,s8>)
    INSTANCE_avx512(_jit_avx512_core_x8s8s32x_deconvolution_fwd_t<s8,f32>)
    INSTANCE(ref_deconvolution_bwd_weights_t)
    INSTANCE(ref_deconvolution_bwd_data_t)
    INSTANCE(ref_deconvolution_fwd_t)
    /* shuffle */
    INSTANCE(ref_shuffle_t<4>) /* f32 or s32 */
    INSTANCE(ref_shuffle_t<2>) /* bf16 */
    INSTANCE(ref_shuffle_t<1>) /* s8 or u8 */
    /* eltwise */
    INSTANCE_uni(jit_uni_eltwise_fwd_t<avx512_common, f32>)
    INSTANCE_uni(jit_uni_eltwise_bwd_t<avx512_common, f32>)
    INSTANCE_uni(jit_uni_eltwise_fwd_t<avx512_core, bf16>)
    INSTANCE_uni(jit_uni_eltwise_bwd_t<avx512_core, bf16>)
    INSTANCE_uni(jit_uni_eltwise_fwd_t<avx2, f32>)
    INSTANCE_uni(jit_uni_eltwise_bwd_t<avx2, f32>)
    INSTANCE_uni(jit_uni_eltwise_fwd_t<sse41, f32>)
    INSTANCE_uni(jit_uni_eltwise_bwd_t<sse41, f32>)
    INSTANCE(ref_eltwise_fwd_t<f32>)
    INSTANCE(ref_eltwise_bwd_t<f32>)
    INSTANCE_sse41(ref_eltwise_fwd_t<bf16>)
    INSTANCE_sse41(ref_eltwise_bwd_t<bf16>)
    /* eltwise (int) */
    INSTANCE(ref_eltwise_fwd_t<s32>)
    INSTANCE(ref_eltwise_fwd_t<s8>)
    INSTANCE(ref_eltwise_fwd_t<u8>)
    INSTANCE(ref_eltwise_bwd_t<s32>)
    /* softmax */
    INSTANCE_uni(jit_uni_softmax_fwd_t<avx512_common>)
    INSTANCE_uni(jit_uni_softmax_fwd_t<avx2>)
    INSTANCE_uni(jit_uni_softmax_fwd_t<sse41>)
    INSTANCE(ref_softmax_fwd_t<f32>)
    INSTANCE(ref_softmax_bwd_t<f32>)
    /* pool */
    INSTANCE_uni(jit_uni_pooling_fwd_t<avx512_core, bf16>)
    INSTANCE_uni(jit_uni_pooling_bwd_t<avx512_core, bf16>)
    INSTANCE_uni(jit_uni_pooling_fwd_t<avx512_common, f32>)
    INSTANCE_uni(jit_uni_pooling_bwd_t<avx512_common, f32>)
    INSTANCE_uni(jit_uni_pooling_fwd_t<avx, f32>)
    INSTANCE_uni(jit_uni_pooling_bwd_t<avx, f32>)
    INSTANCE_uni(jit_uni_pooling_fwd_t<sse41, f32>)
    INSTANCE_uni(jit_uni_pooling_bwd_t<sse41, f32>)

    INSTANCE_sse41(nchw_pooling_fwd_t<bf16>)
    INSTANCE_sse41(nchw_pooling_bwd_t<bf16>)
    INSTANCE(nchw_pooling_fwd_t<f32>)
    INSTANCE(nchw_pooling_bwd_t<f32>)

    INSTANCE_sse41(nhwc_pooling_fwd_t<bf16>)
    INSTANCE_sse41(nhwc_pooling_bwd_t<bf16>)
    INSTANCE(nhwc_pooling_fwd_t<f32>)
    INSTANCE(nhwc_pooling_bwd_t<f32>)

    INSTANCE(ref_pooling_fwd_t<f32>)
    INSTANCE(ref_pooling_bwd_t<f32>)
    INSTANCE_sse41(ref_pooling_fwd_t<bf16, f32>)
    INSTANCE_sse41(ref_pooling_bwd_t<bf16>)

    /* pool (int) */
    INSTANCE_uni(jit_uni_i8i8_pooling_fwd_t<avx512_core>)
    INSTANCE_uni(jit_uni_i8i8_pooling_fwd_t<avx2>)
    INSTANCE(ref_pooling_fwd_t<s32>)
    INSTANCE(ref_pooling_fwd_t<s8, s32>)
    INSTANCE(ref_pooling_fwd_t<u8, s32>)
    INSTANCE(ref_pooling_bwd_t<s32>)
    /* lrn */
    INSTANCE_avx512(jit_avx512_common_lrn_fwd_t<f32>)
    INSTANCE_avx512(jit_avx512_common_lrn_bwd_t<f32>)
    INSTANCE_avx512(jit_avx512_common_lrn_fwd_t<bf16>)
    INSTANCE_avx512(jit_avx512_common_lrn_bwd_t<bf16>)
    INSTANCE_uni(jit_uni_lrn_fwd_t<avx2>)
    INSTANCE_uni(jit_uni_lrn_bwd_t<avx2>)
    INSTANCE_uni(jit_uni_lrn_fwd_t<sse41>)
    INSTANCE(ref_lrn_fwd_t<f32>)
    INSTANCE(ref_lrn_bwd_t<f32>)
    INSTANCE_sse41(ref_lrn_fwd_t<bf16>)
    INSTANCE_sse41(ref_lrn_bwd_t<bf16>)
    /* batch normalization */
    INSTANCE_uni(jit_uni_batch_normalization_fwd_t<avx512_common>)
    INSTANCE_uni(jit_uni_batch_normalization_bwd_t<avx512_common>)
    INSTANCE_uni(jit_uni_batch_normalization_fwd_t<avx2>)
    INSTANCE_uni(jit_uni_batch_normalization_bwd_t<avx2>)
    INSTANCE_uni(jit_uni_batch_normalization_fwd_t<sse41>)
    INSTANCE_uni(jit_uni_batch_normalization_bwd_t<sse41>)
    INSTANCE(ncsp_batch_normalization_fwd_t<f32>)
    INSTANCE(ncsp_batch_normalization_bwd_t<f32>)
    INSTANCE_sse41(ncsp_batch_normalization_fwd_t<bf16>)
    INSTANCE_sse41(ncsp_batch_normalization_bwd_t<bf16>)
    INSTANCE(nspc_batch_normalization_fwd_t<f32>)
    INSTANCE(nspc_batch_normalization_bwd_t<f32>)
    INSTANCE_sse41(nspc_batch_normalization_fwd_t<bf16>)
    INSTANCE_sse41(nspc_batch_normalization_bwd_t<bf16>)
    INSTANCE(ref_batch_normalization_fwd_t<f32>)
    INSTANCE(ref_batch_normalization_bwd_t<f32>)
    INSTANCE_sse41(ref_batch_normalization_fwd_t<bf16>)
    INSTANCE_sse41(ref_batch_normalization_bwd_t<bf16>)
    /* batch normalization (int) */
    INSTANCE_uni(jit_uni_batch_normalization_s8_fwd_t<avx512_core>)
    INSTANCE_uni(jit_uni_batch_normalization_s8_fwd_t<avx2>)
    INSTANCE(ref_batch_normalization_fwd_t<s8>)
    /* inner product */
    INSTANCE(gemm_inner_product_fwd_t<f32>)
    INSTANCE(gemm_inner_product_bwd_data_t<f32>)
    INSTANCE(gemm_inner_product_bwd_weights_t<f32>)
    INSTANCE(ref_inner_product_fwd_t<f32>)
    INSTANCE(ref_inner_product_bwd_data_t<f32, f32, f32, f32>)
    INSTANCE(ref_inner_product_bwd_weights_t<f32>)
    /* inner product (bfloat16) */
    INSTANCE_sse41(gemm_bf16_inner_product_fwd_t<f32>)
    INSTANCE_sse41(gemm_bf16_inner_product_fwd_t<bf16>)
    INSTANCE_sse41(gemm_bf16_inner_product_bwd_data_t<f32>)
    INSTANCE_sse41(gemm_bf16_inner_product_bwd_data_t<bf16>)
    INSTANCE_sse41(gemm_bf16_inner_product_bwd_weights_t<f32>)
    INSTANCE_sse41(gemm_bf16_inner_product_bwd_weights_t<bf16>)
    /* inner product (int) */
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<u8, u8>)
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<u8, s8>)
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<u8, s32>)
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<u8, f32>)
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<s8, u8>)
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<s8, s8>)
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<s8, s32>)
    INSTANCE(gemm_x8s8s32x_inner_product_fwd_t<s8, f32>)
    INSTANCE(ref_inner_product_fwd_t<u8, s8, u8, s32>)
    INSTANCE(ref_inner_product_fwd_t<u8, s8, s8, s32>)
    INSTANCE(ref_inner_product_fwd_t<u8, s8, s32, s32>)
    INSTANCE(ref_inner_product_fwd_t<u8, s8, f32, s32>)
    /* eol */
    nullptr
};
#undef INSTANCE
}

const pd_create_f* cpu_engine_t::get_implementation_list() const {
    return cpu_impl_list;
}

}
}
}

// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
