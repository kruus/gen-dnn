/*******************************************************************************
* Copyright 2019 Intel Corporation
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

#include "cpu_engine.hpp"

#if DNNL_TARGET_X86_JIT
#include "cpu/jit_avx512_common_lrn.hpp"
#include "cpu/jit_uni_lrn.hpp"
#endif // DNNL_TARGET_X86_JIT
#include "cpu/ref_lrn.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

using pd_create_f = engine_t::primitive_desc_create_f;

namespace {
using namespace dnnl::impl::data_type;

/// @copydoc INSTANCE_CREATOR
#define INSTANCE_CREATOR(...) DEFAULT_INSTANCE_CREATOR(__VA_ARGS__)
static const pd_create_f impl_list[] = {
        INSTANCE_avx512(jit_avx512_common_lrn_fwd_t<f32>)
        INSTANCE_avx512(jit_avx512_common_lrn_bwd_t<f32>)
#if DNNL_ENABLE_BFLOAT16
        INSTANCE_avx512(jit_avx512_common_lrn_fwd_t<bf16>)
        INSTANCE_avx512(jit_avx512_common_lrn_bwd_t<bf16>)
#endif // DNNL_ENABLE_BFLOAT16
        INSTANCE_avx2(jit_uni_lrn_fwd_t<avx2>)
        INSTANCE_avx2(jit_uni_lrn_bwd_t<avx2>)
        INSTANCE_sse41(jit_uni_lrn_fwd_t<sse41>)
        INSTANCE(ref_lrn_fwd_t<f32>)
        INSTANCE(ref_lrn_bwd_t<f32>)
#if DNNL_ENABLE_BFLOAT16
        INSTANCE(ref_lrn_fwd_t<bf16>)
        INSTANCE(ref_lrn_bwd_t<bf16>)
#endif // DNNL_ENABLE_BFLOAT16
        /* eol */
        nullptr,
};
} // namespace

const pd_create_f *get_lrn_impl_list(const lrn_desc_t *desc) {
    UNUSED(desc);
    return impl_list;
}

} // namespace cpu
} // namespace impl
} // namespace dnnl
