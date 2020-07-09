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
const std::vector<rpd_create_f> f32_f32_6 = {
        REG_FAST_DIRECT_COPY_F32_F32_COMMA

        DNNL_X64_ONLY(x64::jit_uni_reorder_create,)

        REG_SR_BIDIR(f32, any, f32, gOIdhw4i4o),
        REG_SR_BIDIR(f32, any, f32, gOIdhw4o4i),
        REG_SR_BIDIR(f32, any, f32, gOdhwi8o),
        REG_SR_BIDIR(f32, any, f32, gOIdhw8i8o),
        REG_SR_BIDIR(f32, any, f32, gOIdhw8o8i),

        REG_SR_BIDIR(f32, any, f32, gOidhw4o),
        REG_SR_BIDIR(f32, any, f32, gOidhw16o),
        REG_SR_BIDIR(f32, any, f32, gOdhwi16o),
        REG_SR_BIDIR(f32, any, f32, gOIdhw16o16i),
        REG_SR_BIDIR(f32, any, f32, gOIdhw16i16o),
        REG_SR_BIDIR(f32, any, f32, gIOdhw16o16i),

        REG_SR(f32, any, f32, any, fmt_order::any, spec::reference),

        nullptr,
    };

} // namespace reorder
} // namespace cpu
} // namespace impl
} // namespace dnnl

