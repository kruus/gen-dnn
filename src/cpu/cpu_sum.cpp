/*******************************************************************************
* Copyright 2017-2020 Intel Corporation
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
#include "cpu_target.h"
#if USE_sum
#include "cpu/ref_sum.hpp"
#include "cpu/simple_sum.hpp"
#if TARGET_X86_JIT // && DNNL_ENABLE_BFLOAT16
#include "jit_avx512_core_bf16_sum.hpp"
#endif // TARGET_X86_JIT
#endif // USE_sum

namespace dnnl {
namespace impl {
namespace cpu {

#if !USE_sum
cpu_engine_t const sum_primitive_desc_create_f *
get_sum_implementation_list() const override
{
    static const sum_primitive_desc_create_f empty_list[] = {nullptr};
    return empty_list;
}

#else

using spd_create_f = dnnl::impl::engine_t::sum_primitive_desc_create_f;

namespace {
#define INSTANCE_CREATOR(...) __VA_ARGS__::pd_t::create,
static const spd_create_f cpu_sum_impl_list[] = {
        // clang-format on
        INSTANCE(jit_bf16_sum_t<data_type::bf16, data_type::bf16>)
        INSTANCE(jit_bf16_sum_t<data_type::bf16, data_type::f32>)
        INSTANCE_ref(simple_sum_t<data_type::bf16>)
        INSTANCE_ref(simple_sum_t<data_type::bf16, data_type::f32>)
        INSTANCE_ref(simple_sum_t<data_type::f32>)
        INSTANCE_ref(ref_sum_t)
        // clang-format off
        nullptr,
};
#undef INSTANCE
} // namespace

const spd_create_f *cpu_engine_t::get_sum_implementation_list() const {
    return cpu_sum_impl_list;
}
#endif // USE_sum

} // namespace cpu
} // namespace impl
} // namespace dnnl
