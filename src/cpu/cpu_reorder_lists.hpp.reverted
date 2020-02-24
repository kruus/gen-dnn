/*******************************************************************************
* Copyright 2020 Intel Corporation
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

#ifndef CPU_REORDER_LISTS_HPP
#define CPU_REORDER_LISTS_HPP

#include <assert.h>
#include <map>
#include <vector>

#include "cpu_engine.hpp"

#endif // CPU_REORDER_LISTS_HPP

namespace dnnl {
namespace impl {
namespace cpu {

namespace {

struct reorder_impl_key_t {
    dnnl::impl::data_type_t src_dt;
    dnnl::impl::data_type_t dst_dt; // data_type::undef if arbitrary
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
} // anon::

using rpd_create_f = dnnl::impl::engine_t::reorder_primitive_desc_create_f;
using impl_list_map_t = std::map<reorder_impl_key_t, std::vector<rpd_create_f>>;

// lists were split because of insane compile times (VE- ipa phase overwhelmed)
// so far just two [easy] lists...
extern const impl_list_map_t  regular_impl_list_map;
extern const impl_list_map_t  comp_s8s8_impl_list_map;

} // namespace cpu
} // namespace impl
} // namespace dnnl
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
