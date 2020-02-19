/*******************************************************************************
* Copyright 2017-2019 Intel Corporation
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

#include <assert.h>

#include "cpu_reorder_lists.hpp"
#include "cpu/simple_reorder.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

using namespace dnnl::impl::data_type;
using namespace dnnl::impl::format_tag;

#define REG_SR(idt, ifmt, odt, ofmt, ...) \
    simple_reorder_t<idt, ifmt, odt, ofmt, __VA_ARGS__>::pd_t::create

// clang-format off

/* conv reorders w/ compensation */
extern const impl_list_map_t comp_s8s8_impl_list_map {
    // f32 -> s8
    {{f32, s8, 3}, {
        REG_SR(f32, oiw, s8, OIw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oiw, s8, OIw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oiw, s8, OIw4o4i, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    }},
    {{f32, s8, 4}, {
        REG_SR(f32, any, s8, hwio, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, gOIw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, gOIw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, gOIw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oihw, s8, OIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwio, s8, OIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwio, s8, OIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oihw, s8, OIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwio, s8, OIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oihw, s8, OIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, Goiw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goiw, s8, Goiw8g, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    }},
    {{f32, s8, 5}, {
        REG_SR(f32, any, s8, hwigo, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, any, s8, dhwio, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goihw, s8, gOIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwigo, s8, gOIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goihw, s8, gOIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwigo, s8, gOIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goihw, s8, gOIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwigo, s8, gOIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oidhw, s8, OIdhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, dhwio, s8, OIdhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oidhw, s8, OIdhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, dhwio, s8, OIdhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, oidhw, s8, OIdhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, dhwio, s8, OIdhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goihw, s8, Goihw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwigo, s8, Goihw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goihw, s8, Goihw8g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, hwigo, s8, Goihw8g, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    }},
    {{f32, s8, 6}, {
        REG_SR(f32, any, s8, dhwigo, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goidhw, s8, gOIdhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goidhw, s8, gOIdhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(f32, goidhw, s8, gOIdhw4o4i, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    }},
    // s8 -> s8
    {{s8, s8, 3}, {
        REG_SR(s8, oiw, s8, OIw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oiw, s8, OIw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oiw, s8, OIw4o4i, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    }},
    {{s8, s8, 4}, {
        REG_SR(s8, any, s8, hwio, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goiw, s8, gOIw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goiw, s8, gOIw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goiw, s8, gOIw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwio, s8, OIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oihw, s8, OIhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwio, s8, OIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oihw, s8, OIhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, hwio, s8, OIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, oihw, s8, OIhw4o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goiw, s8, Goiw16g, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goiw, s8, Goiw8g, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    }},
    {{s8, s8, 5}, {
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
    }},
    {{s8, s8, 6}, {
        REG_SR(s8, any, s8, dhwigo, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goidhw, s8, gOIdhw4i16o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goidhw, s8, gOIdhw2i8o4i, fmt_order::keep, spec::conv_s8s8),
        REG_SR(s8, goidhw, s8, gOIdhw4o4i, fmt_order::keep, spec::conv_s8s8),

        nullptr,
    }},
};

} // namespace cpu
} // namespace impl
} // namespace dnnl
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
