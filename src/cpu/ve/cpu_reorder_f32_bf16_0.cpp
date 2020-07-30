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

namespace dnnl {
namespace impl {
namespace cpu {
namespace reorder {

// clang-format off

// f32 -> bf16
const std::vector<rpd_create_f>& f32_bf16_0() {
    static const std::vector<rpd_create_f> v = {
        rnn_weights_reorder_t<f32, bf16>::pd_t::create,

        DNNL_X64_ONLY(x64::jit_uni_reorder_create,)

        REG_SR_BIDIR(f32, any, bf16, nChw16c),
        REG_SR_BIDIR(f32, any, bf16, nCdhw16c),

        REG_SR(f32, oihw, bf16, OIhw8i16o2i, fmt_order::keep),
        REG_SR(f32, goihw, bf16, gOIhw8i16o2i, fmt_order::keep),
        REG_SR(f32, oihw, bf16, OIhw8o16i2o, fmt_order::keep),
        REG_SR(f32, goihw, bf16, gOIhw8o16i2o, fmt_order::keep),
        REG_SR(f32, oihw, bf16, IOhw8o16i2o, fmt_order::keep),
        REG_SR(f32, goihw, bf16, gIOhw8o16i2o, fmt_order::keep),
        REG_SR(f32, oihw, bf16, OIhw16i16o, fmt_order::keep),
        REG_SR(f32, goihw, bf16, gOIhw16i16o, fmt_order::keep),

        REG_SR(f32, any, bf16, any, fmt_order::any, spec::reference),

        nullptr,
    };
    return v;
}

} // namespace reorder
} // namespace cpu
} // namespace impl
} // namespace dnnl
