/*******************************************************************************
* Copyright 2019-2020 Intel Corporation
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

#if TARGET_X86_JIT
#include "cpu/jit_uni_layer_normalization.hpp"
#endif // TARGET_X86_JIT
#include "cpu/ref_layer_normalization.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

using pd_create_f = engine_t::primitive_desc_create_f;

namespace {
using namespace dnnl::impl::data_type;

/// @copydoc INSTANCE_CREATOR
#define INSTANCE_CREATOR(...) DEFAULT_INSTANCE_CREATOR(__VA_ARGS__)
static const pd_create_f impl_list[] = {
        // clang-format off
        INSTANCE(jit_uni_layer_normalization_fwd_t)
        INSTANCE(jit_uni_layer_normalization_bwd_t)
        INSTANCE_ref(ref_layer_normalization_fwd_t<f32>)
        INSTANCE_ref(ref_layer_normalization_bwd_t<f32>)
        INSTANCE_ref(ref_layer_normalization_fwd_t<bf16>)
        INSTANCE_ref(ref_layer_normalization_bwd_t<bf16>)
        // clang-format on
        /* eol */
        nullptr,
};
} // namespace

const pd_create_f *get_layer_normalization_impl_list(
        const layer_normalization_desc_t *desc) {
    UNUSED(desc);
    return impl_list;
}

} // namespace cpu
} // namespace impl
} // namespace dnnl
