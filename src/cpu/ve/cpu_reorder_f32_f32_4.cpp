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

namespace dnnl {
namespace impl {
namespace cpu {
namespace reorder {

// clang-format off

// f32 -> bf16
const std::vector<rpd_create_f> f32_f32_4 = {
        DNNL_X64_ONLY(x64::wino_reorder_t<f32, f32>::pd_t::create,)

        REG_FAST_DIRECT_COPY_F32_F32_COMMA

        DNNL_X64_ONLY(x64::jit_uni_reorder_create,)

        REG_SR_BIDIR(f32, any, f32, nChw16c),
        REG_SR_BIDIR(f32, any, f32, nChw8c),
        REG_SR_BIDIR(f32, any, f32, nChw4c),

        REG_SR_BIDIR(f32, nChw4c, f32, nChw16c),
        REG_SR_BIDIR(f32, nChw8c, f32, nChw16c),

        REG_SR_BIDIR(f32, any, f32, gOIw4i4o),
        REG_SR_BIDIR(f32, any, f32, gOIw4o4i),
        REG_SR_BIDIR(f32, any, f32, gOIw8i8o),
        REG_SR_BIDIR(f32, any, f32, gOIw8o8i),

        REG_SR_BIDIR(f32, any, f32, gOIw16o16i),
        REG_SR_BIDIR(f32, any, f32, gOIw16i16o),
        REG_SR_BIDIR(f32, any, f32, gIOw16o16i),

        REG_SR_BIDIR(f32, any, f32, OIhw4i4o),
        REG_SR_BIDIR(f32, any, f32, OIhw4o4i),
        REG_SR_BIDIR(f32, any, f32, Ohwi8o),

        REG_SR_BIDIR(f32, any, f32, OIhw8i8o),
        REG_SR_BIDIR(f32, any, f32, OIhw8o8i),

        REG_SR_BIDIR(f32, any, f32, Oihw4o),
        REG_SR_BIDIR(f32, any, f32, Oihw16o),
        REG_SR_BIDIR(f32, any, f32, Ohwi4o),
        REG_SR_BIDIR(f32, any, f32, Ohwi16o),
        REG_SR_BIDIR(f32, any, f32, OIhw16o16i),
        REG_SR_BIDIR(f32, any, f32, OIhw16i16o),
        REG_SR_BIDIR(f32, any, f32, IOhw16o16i),

        REG_SR_BIDIR(f32, any, f32, OIhw4i16o4i),

        REG_SR(f32, any, f32, any, fmt_order::any, spec::reference),

        nullptr,
    };

} // namespace reorder
} // namespace cpu
} // namespace impl
} // namespace dnnl

