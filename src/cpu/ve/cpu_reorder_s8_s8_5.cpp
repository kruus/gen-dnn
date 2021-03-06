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
const std::vector<rpd_create_f>& s8_s8_5() {
    static const std::vector<rpd_create_f> v = {
        REG_SR(s8, any, s8, hwigo, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, any, s8, dhwio, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goihw, s8, gOIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwigo, s8, gOIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goihw, s8, gOIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwigo, s8, gOIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goihw, s8, gOIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwigo, s8, gOIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oidhw, s8, OIdhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, dhwio, s8, OIdhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oidhw, s8, OIdhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, dhwio, s8, OIdhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oidhw, s8, OIdhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, dhwio, s8, OIdhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goihw, s8, Goihw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwigo, s8, Goihw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goihw, s8, Goihw8g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwigo, s8, Goihw8g, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    };
    return v;
}

} // namespace reorder
} // namespace cpu
} // namespace impl
} // namespace dnnl

