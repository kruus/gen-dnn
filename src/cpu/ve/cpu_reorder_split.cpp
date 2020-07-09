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

namespace {
using namespace dnnl::impl::data_type;
using namespace dnnl::impl::format_tag;

struct reorder_impl_key_t {
    data_type_t src_dt;
    data_type_t dst_dt; // data_type::undef if arbitrary
    int ndims; // 0 if arbitrary

    bool operator<(const reorder_impl_key_t &rhs) const {
        return value() < rhs.value();
    }

private:
    enum { MAX_DT_NUM = 10 };
    size_t value() const {
        return ((size_t)ndims * MAX_DT_NUM + (size_t)src_dt) * MAX_DT_NUM
                + (size_t)dst_dt;
    }
};

using impl_list_map_t = std::map<reorder_impl_key_t, std::vector<rpd_create_f>>;

// clang-format off

static const impl_list_map_t regular_impl_list_map {
    // f32 -> bf16
    {{f32, bf16, 0}, reorder::f32_bf16_0},
    // f32 -> f16
    {{f32, f16, 0}, reorder::f32_f16_0},

    // f32 -> f32
    {{f32, f32, 0}, reorder::f32_f32_0},
    {{f32, f32, 3}, reorder::f32_f32_3},
    {{f32, f32, 4}, reorder::f32_f32_4},
    {{f32, f32, 5}, reorder::f32_f32_5},
    {{f32, f32, 6}, reorder::f32_f32_6},

    // f32 -> s32
    {{f32, s32, 0}, reorder::f32_s32_0},

    // f32 -> s8
    {{f32, s8, 0}, reorder::f32_s8_0},

    // f32 -> u8
    {{f32, u8, 0}, reorder::f32_u8_0},

    // bf16 ->
    {{bf16, data_type::undef, 0}, reorder::bf16_undef_0},

    // f16 ->
    {{f16, data_type::undef, 0}, reorder::f16_undef_0},

    // s32 ->
    {{s32, data_type::undef, 0}, reorder::s32_undef_0},

    // s8 ->
    {{s8, data_type::undef, 0}, reorder::s8_undef_0},

    // u8 ->
    {{u8, data_type::undef, 0}, reorder::u8_undef_0},
};

/* conv reorders w/ compensation */
static const impl_list_map_t comp_s8s8_impl_list_map {
    // f32 -> s8
    {{f32, s8, 3}, reorder::f32_s8_3},
    {{f32, s8, 4}, reorder::f32_s8_4},
    {{f32, s8, 5}, reorder::f32_s8_5},
    {{f32, s8, 6}, reorder::f32_s8_6},
    // s8 -> s8
    {{s8, s8, 3}, reorder::s8_s8_3},
    {{s8, s8, 4}, reorder::s8_s8_4},
    {{s8, s8, 5}, reorder::s8_s8_5},
    {{s8, s8, 6}, reorder::s8_s8_6},
};

// clang-format on

} // namespace

const rpd_create_f *cpu_engine_t::get_reorder_implementation_list(
        const memory_desc_t *src_md, const memory_desc_t *dst_md) const {
    const impl_list_map_t &impl_list
            = (dst_md->extra.flags & memory_extra_flags::compensation_conv_s8s8)
            ? comp_s8s8_impl_list_map
            : regular_impl_list_map;

    reorder_impl_key_t key {
            src_md->data_type, dst_md->data_type, src_md->ndims};

    {
        const auto it = impl_list.find(key);
        if (it != impl_list.cend()) return it->second.data();
    }

    {
        key.ndims = 0;
        const auto it = impl_list.find(key);
        if (it != impl_list.cend()) return it->second.data();
    }

    {
        key.dst_dt = data_type::undef;
        const auto it = impl_list.find(key);
        if (it != impl_list.cend()) return it->second.data();
    }

    static const rpd_create_f empty_list[] = {nullptr};
    return empty_list;
}

} // namespace cpu
} // namespace impl
} // namespace dnnl
