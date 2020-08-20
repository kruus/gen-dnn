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
#include "dnnl_debug.h"

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

    bool operator==(const reorder_impl_key_t &rhs) const {
        return src_dt == rhs.src_dt
            && dst_dt == rhs.dst_dt
            && ndims == rhs.ndims;
    }
private:
    enum { MAX_DT_NUM = 10 };
    size_t value() const {
        return ((size_t)ndims * MAX_DT_NUM + (size_t)src_dt) * MAX_DT_NUM
                + (size_t)dst_dt;
    }
};
using impl_list_map_t = std::map<reorder_impl_key_t, std::vector<rpd_create_f>>;

#ifndef NDEBUG // remove after development work XXX
static void once_info() {
    static bool once=false;
    if (once == false) {
        once == true;
        float fn127 = -127.f;
        float f0 = 0.f;
        float f127 = 127.f;
        float f128 = 128.f;
        float f255 = 255.f;
        printf(" Saturation:\n");
        printf(" uint8_t lbound is %d\n", (int)nstl::numeric_limits<uint8_t>::lowest());
        printf(" uint8_t ubound is %d\n", (int)nstl::numeric_limits<uint8_t>::max());
        float fs8low = (float)nstl::numeric_limits<int8_t>::lowest();
        float fs8max = (float)nstl::numeric_limits<int8_t>::max();
        float fu8low = (float)nstl::numeric_limits<uint8_t>::lowest();
        float fu8max = (float)nstl::numeric_limits<uint8_t>::max();
        float fs32low = (float)nstl::numeric_limits<int32_t>::lowest();
        float fs32max = (float)nstl::numeric_limits<int32_t>::max();
        printf(" float special values for lea.sl:\n");
        printf(" fs8low = %-6f ~ 0x%04x, decimal %d\n",
               fs8low, *(uint32_t*)&fs8low, *(int32_t*)&fs8low);
        printf(" fs8max = %-6f ~ 0x%04x, decimal %d\n",
               fs8max, *(uint32_t*)&fs8max, *(int32_t*)&fs8max);
        printf(" fs32low = %-6f ~ 0x%04x, decimal %d\n",
               fs32low, *(uint32_t*)&fs32low, *(int32_t*)&fs32low);
        printf(" fs32max = %-6f ~ 0x%04x, decimal %d\n",
               fs32max, *(uint32_t*)&fs32max, *(int32_t*)&fs32max);
        printf(" fu8low = %-6f ~ 0x%04x, decimal %d\n",
               fu8low, *(uint32_t*)&fu8low, *(int32_t*)&fu8low);
        printf(" fu8max = %-6f ~ 0x%04x, decimal %d\n",
               fu8max, *(uint32_t*)&fu8max, *(int32_t*)&fu8max);
        printf(" -127.f~ 0x%04x, decimal %d\n", *(uint32_t*)&fn127, *(int32_t*)&fn127);
        printf(" 0.f   ~ 0x%04x, decimal %d\n", *(uint32_t*)&f0   , *(int32_t*)&f0  );
        printf(" 127.f ~ 0x%04x, decimal %d\n", *(uint32_t*)&f127 , *(int32_t*)&f127);
        printf(" 128.f ~ 0x%04x, decimal %d\n", *(uint32_t*)&f128 , *(int32_t*)&f128);
        printf(" 255.f ~ 0x%04x, decimal %d\n", *(uint32_t*)&f255 , *(int32_t*)&f255);
    }
}
#endif // NDEBUG

#ifndef NDEBUG
// debug function used to detect and work around a symbol table clash
static void check_map(impl_list_map_t const& reo_map){
    // After fixing a "static initialization fiasco" life is much better
    constexpr int q = 1; // quiet?
    int nerr = 0;
    int nkv = 0;
    for(auto & kv: reo_map){
        ++nkv;
        auto const& k = kv.first;
        auto & v = kv.second;
        //
        // turned out it was not symbol clash but static init fiasco
        //
        // workaround: construct from function-local statics, with
        // fully determined construction order.
        //
        // Removing globals from library is usually a good idea :)
        //

        bool ok = true;
        if (!q) printf(" checking key %s_%s_%d, vector @ %p ...",
               dnnl_dt2str(k.src_dt), dnnl_dt2str(k.dst_dt),
               (int)k.ndims, (void*)(&v));
        if (v.size() == 0) {
            if (!q) {
                printf(" Error: key %s_%s_%d maps to vector<>[size=%d]\n",
                       dnnl_dt2str(k.src_dt), dnnl_dt2str(k.dst_dt),
                       (int)k.ndims, (int)v.size());
                fflush(stdout);
            }
            ok = false;
            ++nerr;
        }
        if (v.size() == 1) {
            if (!q) {
                printf(" Warning: key %s_%s_%d maps to vector<>[size=%d]\n",
                       dnnl_dt2str(k.src_dt), dnnl_dt2str(k.dst_dt),
                       (int)k.ndims, (int)v.size());
                fflush(stdout);
            }
            ok = false;
        }
        if (v.back() != nullptr) {
            if (!q) {
                printf(" Error: key %s_%s_%d vector<>.back() is not nullptr\n",
                       dnnl_dt2str(k.src_dt), dnnl_dt2str(k.dst_dt),
                       (int)k.ndims);
                fflush(stdout);
            }
            ok = false;
            ++nerr;
        }
        if (!q) {
            if (ok) printf(" OK\n");
            printf("reorder check_map: entries:%d failed:%d\n", nkv, nerr);
        }
    }
    if (nerr) {
        printf(" Fatal Error: some reorder lists seem corrupted.\n"
               " See %s routine check_map.", __FILE__);
        fflush(stdout);
        exit(13);
    }
}
#endif // NDEBUG

// clang-format off

// when splitting avoid statics an construct at run-time...
static impl_list_map_t const& regular_impl_list_map() {
    // Avoid "static initialization fiasco" :
    //   As function-level statics, these constructors are valuated at
    //   run-time, avoiding undefined construction ordering of libdnnl
    //   static objects.
    static const impl_list_map_t m = {
        // f32 -> bf16
        {{f32, bf16, 0}, reorder::f32_bf16_0()},
        // f32 -> f16
        {{f32, f16, 0}, reorder::f32_f16_0()},

        // f32 -> f32
        {{f32, f32, 0}, reorder::f32_f32_0()},
        {{f32, f32, 3}, reorder::f32_f32_3()},
        {{f32, f32, 4}, reorder::f32_f32_4()},
        {{f32, f32, 5}, reorder::f32_f32_5()},
        {{f32, f32, 6}, reorder::f32_f32_6()},

        // f32 -> s32
        {{f32, s32, 0}, reorder::f32_s32_0()},

        // f32 -> s8
        {{f32, s8, 0}, reorder::f32_s8_0()},

        // f32 -> u8
        {{f32, u8, 0}, reorder::f32_u8_0()},

        // bf16 ->
        {{bf16, data_type::undef, 0}, reorder::bf16_undef_0()},

        // f16 ->
        {{f16, data_type::undef, 0}, reorder::f16_undef_0()},

        // s32 ->
        {{s32, data_type::undef, 0}, reorder::s32_undef_0()},

        // s8 ->
        {{s8, data_type::undef, 0}, reorder::s8_undef_0()},

        // u8 ->
        // NOTE: original symbol had hash table collision within libdnnl.so ?
        // NOPE: it was "static initialization order fiasco".
        {{u8, data_type::undef, 0}, reorder::u8_undef_0()},

    };
    return m;
}

/* conv reorders w/ compensation */
// removing static globals (init order issues)
static impl_list_map_t const& comp_s8s8_impl_list_map() {
    static const impl_list_map_t m = {
        // f32 -> s8
        {{f32, s8, 3}, reorder::f32_s8_3()},
        {{f32, s8, 4}, reorder::f32_s8_4()},
        {{f32, s8, 5}, reorder::f32_s8_5()},
        {{f32, s8, 6}, reorder::f32_s8_6()},
        // s8 -> s8
        {{s8, s8, 3}, reorder::s8_s8_3()},
        {{s8, s8, 4}, reorder::s8_s8_4()},
        {{s8, s8, 5}, reorder::s8_s8_5()},
        {{s8, s8, 6}, reorder::s8_s8_6()},
    };
    return m;
}

// clang-format on

} // namespace

const rpd_create_f *cpu_engine_t::get_reorder_implementation_list(
        const memory_desc_t *src_md, const memory_desc_t *dst_md) const {

    static bool once=false;
    static impl_list_map_t const * p_regular_impl_list_map = nullptr;
    static impl_list_map_t const * p_comp_s8s8_impl_list_map = nullptr;
    if (once == false) {
        once = true;
        // Avoid initialization fiasco for library static objects (1st attempt)
        // Control construction order: creating lists "now" & "just once"
        p_regular_impl_list_map = &regular_impl_list_map();
        p_comp_s8s8_impl_list_map = &comp_s8s8_impl_list_map();
#ifndef NDEBUG
        if (0) { // debug checks
            printf("reorder: check regular_impl_list_map...\n");
            check_map(*p_regular_impl_list_map);
            printf("reorder: check comp_s8s8_impl_list_map...\n");
            check_map(*p_comp_s8s8_impl_list_map);
            // for development work -- move to dev/ XXX
            once_info(); // misc helper info for asm coding
        }
#endif // NDEBUG
    }
    const impl_list_map_t &impl_list
            = (dst_md->extra.flags & memory_extra_flags::compensation_conv_s8s8)
            ? *p_comp_s8s8_impl_list_map
            : *p_regular_impl_list_map;

    reorder_impl_key_t key {
            src_md->data_type, dst_md->data_type, src_md->ndims};

    {
        const auto it = impl_list.find(key);
        if (it != impl_list.cend()) {
            auto vec = it->second;
            //printf(" reo0[%u]",(unsigned)vec.size()); fflush(stdout);
            //printf(" reo0 key %s_%s_%d", dnnl_dt2str(key.src_dt),
            //       dnnl_dt2str(key.dst_dt), (int)key.ndims);
            //fflush(stdout);
            if (vec.size() == 0) {
                printf(" Error: this list is empty!\n"); fflush(stdout);
            }
            return it->second.data();
        }
    }

    {
        key.ndims = 0;
        const auto it = impl_list.find(key);
        if (it != impl_list.cend()) {
            auto vec = it->second;
            //printf(" reo1[%u]",(unsigned)vec.size()); fflush(stdout);
            //printf(" reo1 key %s_%s_%d", dnnl_dt2str(key.src_dt),
            //       dnnl_dt2str(key.dst_dt), (int)key.ndims);
            //fflush(stdout);
            if (vec.size() == 0) {
                printf(" Error: this list is empty!\n"); fflush(stdout);
            }
            return it->second.data();
        }
    }

    {
        key.dst_dt = data_type::undef;
        const auto it = impl_list.find(key);
        if (it != impl_list.cend()) {
            auto vec = it->second;
            //printf(" reo2[%u]",(unsigned)vec.size()); fflush(stdout);
            //printf(" reo2 key %s_%s_%d", dnnl_dt2str(key.src_dt),
            //       dnnl_dt2str(key.dst_dt), (int)key.ndims);
            //fflush(stdout);
            if (vec.size() == 0) {
                printf(" Error: this list is empty!\n"); fflush(stdout);
            }
            //for (auto ptr: vec) printf(" %0x08x",(intptr_t)ptr);
            //printf("\n"); fflush(stdout);
            return it->second.data();
        }
    }

    static const rpd_create_f empty_list[] = {nullptr};
    printf(" reo[mt]"); fflush(stdout);
    return empty_list;
}

} // namespace cpu
} // namespace impl
} // namespace dnnl
