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

#include "cpu/ve/cpu_reorder_split.hpp"
#include "cpu/rnn/rnn_reorders.hpp"

#include "cpu/ve/simple_q10n_ve_f32_int.hpp" // assembler specialization

namespace dnnl {
namespace impl {
namespace cpu {
namespace reorder {

// clang-format off

// f32 -> bf16
const std::vector<rpd_create_f>& f32_u8_0() {
    static const std::vector<rpd_create_f> v{
        rnn_data_reorder_t<f32, u8>::pd_t::create,

        REG_FAST_DIRECT_COPY_COMMA(f32, u8)

        DNNL_X64_ONLY(x64::jit_uni_reorder_create,)

        REG_SR_BIDIR(f32, any, u8, nChw16c),

        REG_SR(f32, any, u8, any, fmt_order::any, spec::reference),

        nullptr,
    };
    return v;
}

} // namespace reorder
} // namespace cpu
} // namespace impl
} // namespace dnnl

