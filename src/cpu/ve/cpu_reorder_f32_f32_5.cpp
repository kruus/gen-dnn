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
const std::vector<rpd_create_f>& f32_f32_5() {
    static const std::vector<rpd_create_f> v = {
        DNNL_X64_ONLY(x64::wino_reorder_t<f32, f32>::pd_t::create,)
        rnn_weights_reorder_t<f32, f32>::pd_t::create,

        REG_FAST_DIRECT_COPY_F32_F32_COMMA

        DNNL_X64_ONLY(x64::jit_uni_reorder_create,)

        REG_SR_BIDIR(f32, any, f32, nCdhw16c),
        REG_SR_BIDIR(f32, any, f32, nCdhw8c),
        REG_SR_BIDIR(f32, any, f32, nCdhw4c),

        REG_SR_BIDIR(f32, nCdhw4c, f32, nCdhw16c),
        REG_SR_BIDIR(f32, nCdhw8c, f32, nCdhw16c),

        REG_SR_BIDIR(f32, any, f32, gOIhw4i4o),
        REG_SR_BIDIR(f32, any, f32, gOIhw4o4i),
        REG_SR_BIDIR(f32, any, f32, gOhwi8o),
        REG_SR_BIDIR(f32, any, f32, gOIhw8i8o),
        REG_SR_BIDIR(f32, any, f32, gOIhw8o8i),

        REG_SR_BIDIR(f32, any, f32, gOihw4o),
        REG_SR_BIDIR(f32, any, f32, gOihw16o),
        REG_SR_BIDIR(f32, any, f32, gOhwi4o),
        REG_SR_BIDIR(f32, any, f32, gOhwi16o),
        REG_SR_BIDIR(f32, any, f32, gOIhw16o16i),
        REG_SR_BIDIR(f32, any, f32, gOIhw16i16o),
        REG_SR_BIDIR(f32, any, f32, gIOhw16o16i),

        REG_SR_BIDIR(f32, any, f32, OIdhw4i4o),
        REG_SR_BIDIR(f32, any, f32, OIdhw4o4i),
        REG_SR_BIDIR(f32, any, f32, Odhwi8o),
        REG_SR_BIDIR(f32, any, f32, OIdhw8i8o),
        REG_SR_BIDIR(f32, any, f32, OIdhw8o8i),

        REG_SR_BIDIR(f32, any, f32, Oidhw4o),
        REG_SR_BIDIR(f32, any, f32, Oidhw16o),
        REG_SR_BIDIR(f32, any, f32, Odhwi16o),
        REG_SR_BIDIR(f32, any, f32, OIdhw16o16i),
        REG_SR_BIDIR(f32, any, f32, OIdhw16i16o),
        REG_SR_BIDIR(f32, any, f32, IOdhw16o16i),

        REG_SR_BIDIR(f32, any, f32, gOIhw4i16o4i),

        REG_SR(f32, any, f32, any, fmt_order::any, spec::reference),

        nullptr,
    };
    return v;
}

// to produce nicer VE diagnostics:
template class simple_reorder_t<f32,any, f32,any, fmt_order::any, spec::direct_copy>;
template class simple_reorder_t<f32,any, f32,any, fmt_order::any, spec::reference>;

} // namespace reorder
} // namespace cpu
} // namespace impl
} // namespace dnnl

