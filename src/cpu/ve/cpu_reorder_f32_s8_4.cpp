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
const std::vector<rpd_create_f> f32_s8_4 = {
        REG_SR(f32, any, s8, hwio, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, any, s8, wigo, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, gOIw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, wigo, s8, gOIw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, gOIw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, wigo, s8, gOIw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, gOIw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, wigo, s8, gOIw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oihw, s8, OIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwio, s8, OIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwio, s8, OIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oihw, s8, OIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwio, s8, OIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oihw, s8, OIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, Goiw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, wigo, s8, Goiw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, Goiw8g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, wigo, s8, Goiw8g, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    };

} // namespace reorder
} // namespace cpu
} // namespace impl
} // namespace dnnl

