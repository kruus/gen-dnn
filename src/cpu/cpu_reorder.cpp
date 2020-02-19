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

namespace dnnl {
namespace impl {
namespace cpu {

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
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
