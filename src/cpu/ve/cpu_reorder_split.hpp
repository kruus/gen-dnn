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

#ifndef CPU_VE_CPU_REORDER_SPLIT_HPP
#define CPU_VE_CPU_REORDER_SPLIT_HPP
#include <map>
#include <vector>

#include "common/memory.hpp"
#include "common/type_helpers.hpp"

#include "cpu/cpu_engine.hpp"
#include "cpu/cpu_reorder_pd.hpp"

#include "cpu/simple_reorder.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

using rpd_create_f = dnnl::impl::engine_t::reorder_primitive_desc_create_f;

/** Split the reorder map values so each one is compiled separately.
 * nc++ spends an inordinate amount of time doing ipa amongst some huge
 * number of functions. */
namespace reorder {
    using namespace dnnl::impl::data_type;
    using namespace dnnl::impl::format_tag;
    // values for regular_impl_list_map
    extern const std::vector<rpd_create_f> f32_bf16_0;
    extern const std::vector<rpd_create_f> f32_f16_0;
    extern const std::vector<rpd_create_f> f32_f32_0;
    extern const std::vector<rpd_create_f> f32_f32_3;
    extern const std::vector<rpd_create_f> f32_f32_4;
    extern const std::vector<rpd_create_f> f32_f32_5;
    extern const std::vector<rpd_create_f> f32_f32_6;
    extern const std::vector<rpd_create_f> f32_s32_0;
    extern const std::vector<rpd_create_f> f32_s8_0;
    extern const std::vector<rpd_create_f> f32_u8_0;
    extern const std::vector<rpd_create_f> bf16_undef_0;
    extern const std::vector<rpd_create_f> f16_undef_0;
    extern const std::vector<rpd_create_f> s32_undef_0;
    extern const std::vector<rpd_create_f> s8_undef_0;
    extern const std::vector<rpd_create_f> u8_undef_0;
    // values for comp_s8s8_impl_list_map
    extern const std::vector<rpd_create_f> f32_s8_3;
    extern const std::vector<rpd_create_f> f32_s8_4;
    extern const std::vector<rpd_create_f> f32_s8_5;
    extern const std::vector<rpd_create_f> f32_s8_6;
    extern const std::vector<rpd_create_f> s8_s8_3;
    extern const std::vector<rpd_create_f> s8_s8_4;
    extern const std::vector<rpd_create_f> s8_s8_5;
    extern const std::vector<rpd_create_f> s8_s8_6;
}

} // namespace cpu
} // namespace impl
} // namespace dnnl

#define REG_SR(idt, ifmt, odt, ofmt, ...) \
    simple_reorder_t<idt, ifmt, odt, ofmt, __VA_ARGS__>::pd_t::create

#define REG_SR_BIDIR(idt, ifmt, odt, ofmt) \
    REG_SR(idt, ifmt, odt, ofmt, fmt_order::keep), \
            REG_SR(idt, ifmt, odt, ofmt, fmt_order::reverse)

#define REG_SR_DIRECT_COPY(idt, odt) \
    REG_SR(idt, any, odt, any, fmt_order::any, spec::direct_copy), \
            REG_SR(idt, any, odt, any, fmt_order::any, \
                    spec::direct_copy_except_dim_0)

#if !DNNL_X64 || (defined(__INTEL_COMPILER) || (defined(__GNUC__) && !defined(__clang__)))
//#if              (defined(__INTEL_COMPILER) || (defined(__GNUC__) && !defined(__clang__)))
//#if !defined(__ve) && (defined(__INTEL_COMPILER) || (defined(__GNUC__) && !defined(__clang__)))
/* Direct copy for icc which is faster than jitted code;
 * Direct copy for gcc which might or might not be faster than jitted
 * code, but still worth it because doesn't require jitting, i.e. much
 * faster creation time. This is tentative solution and should be
 * removed later (when we will cache jitted code?...). */
#define REG_FAST_DIRECT_COPY_F32_F32_COMMA REG_SR_DIRECT_COPY(f32, f32),
#else
#define REG_FAST_DIRECT_COPY_F32_F32_COMMA
#endif

/* regular reorders */
#if !DNNL_X64 || defined(__INTEL_COMPILER)
//#if              defined(__INTEL_COMPILER)
/* direct copy for icc, which is faster than jitted code */
#define REG_FAST_DIRECT_COPY_COMMA(sdt, ddt) REG_SR_DIRECT_COPY(sdt, ddt),
#else
#define REG_FAST_DIRECT_COPY_COMMA(sdt, ddt)
#endif

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // CPU_VE_CPU_REORDER_SPLIT_HPP
