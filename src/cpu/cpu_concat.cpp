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
#if USE_concat
#include "cpu/ref_concat.hpp"
#include "cpu/simple_concat.hpp"
#endif // USE_concat

namespace dnnl {
namespace impl {
namespace cpu {

#if !USE_concat
cpu_engine_t::get_concat_implementation_list() const override
{
    static const concat_primitive_desc_create_f empty_list[] = {nullptr};
    return empty_list;
}

#else

using cpd_create_f = dnnl::impl::engine_t::concat_primitive_desc_create_f;

namespace {
#define INSTANCE_CREATOR(...) __VA_ARGS__::pd_t::create,
static const cpd_create_f cpu_concat_impl_list[] = {
        // clang-format on
        INSTANCE_ref(simple_concat_t<data_type::f32>)
        INSTANCE_ref(simple_concat_t<data_type::u8>)
        INSTANCE_ref(simple_concat_t<data_type::s8>)
        INSTANCE_ref(simple_concat_t<data_type::s32>)
        INSTANCE_ref(simple_concat_t<data_type::bf16>)
        INSTANCE_ref(ref_concat_t)
        // clang-format off
        nullptr,
};
#undef INSTANCE
} // namespace

const cpd_create_f *cpu_engine_t::get_concat_implementation_list() const {
    return cpu_concat_impl_list;
}
#endif // USE_concat

} // namespace cpu
} // namespace impl
} // namespace dnnl
