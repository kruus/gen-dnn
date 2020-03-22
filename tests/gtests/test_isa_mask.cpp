/*******************************************************************************
* Copyright 2019-2020 Intel Corporation
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

#include <map>
#include <set>

#include "dnnl.h"
//#include "dnnl_test_common.hpp"
#include "gtest/gtest.h"

#include "dnnl.hpp"
#include "src/cpu/cpu_isa_traits.hpp"

#define DEBUG_ISA_MASK 0

#if DEBUG_ISA_MASK
#include "dnnl_debug.h"
#endif

namespace dnnl {

using namespace impl::cpu;

const std::set<cpu_isa_t> cpu_isa_set
        = {vanilla, isa_any, sse41, avx, avx2, avx512_mic, avx512_mic_4ops,
                avx512_core, avx512_core_vnni, avx512_core_bf16, isa_all};

struct isa_compat_info {
    cpu_isa_t this_isa;
    std::set<cpu_isa_t> cpu_isa_compatible;
};

// This mostly duplicates isa_traits, but the idea is to *not* rely on that
// information...
static std::map<cpu_isa, isa_compat_info> isa_compatibility_table = {
        // generic...
        {cpu_isa::vanilla, {vanilla, {vanilla}}},
        {cpu_isa::any, {isa_any, {vanilla, isa_any}}},
        {cpu_isa::all, {isa_all, {vanilla, isa_any, isa_all}}},
        // x86-specific...
        {cpu_isa::sse41, {sse41, {vanilla, isa_any, sse41}}},
        {cpu_isa::avx, {avx, {vanilla, isa_any, sse41, avx}}},
        {cpu_isa::avx2, {avx2, {vanilla, isa_any, sse41, avx, avx2}}},
        {cpu_isa::avx512_mic,
                {avx512_mic, {vanilla, isa_any, sse41, avx, avx2, avx512_mic}}},
        {cpu_isa::avx512_mic_4ops,
                {avx512_mic_4ops,
                        {vanilla, isa_any, sse41, avx, avx2, avx512_mic,
                                avx512_mic_4ops}}},
        {cpu_isa::avx512_core,
                {avx512_core,
                        {vanilla, isa_any, sse41, avx, avx2, avx512_core}}},
        {cpu_isa::avx512_core_vnni,
                {avx512_core_vnni,
                        {vanilla, isa_any, sse41, avx, avx2, avx512_core,
                                avx512_core_vnni}}},
        {cpu_isa::avx512_core_bf16,
                {avx512_core_bf16,
                        {vanilla, isa_any, sse41, avx, avx2, avx512_core,
                                avx512_core_vnni, avx512_core_bf16}}}};

class isa_test : public ::testing::TestWithParam<cpu_isa> {
protected:
    virtual void SetUp() {
        auto isa = ::testing::TestWithParam<cpu_isa>::GetParam();

        // soft version of mayiuse that allows resetting the max_cpu_isa
        auto test_mayiuse = [](cpu_isa_t isa) { return mayiuse(isa, true); };
        auto toc = [](cpu_isa isa) { return static_cast<dnnl_cpu_isa_t>(isa); };

        status st = set_max_cpu_isa(isa);
        // equiv: status st = (status)dnnl_set_max_cpu_isa(toc(isa));

        // status::unimplemented if the feature was disabled at compile time
        if (st == status::unimplemented) return;

        ASSERT_TRUE(st == status::success);

        auto info = isa_compatibility_table[isa];
        bool const ok_this_isa = test_mayiuse(info.this_isa);
#if DEBUG_ISA_MASK
        printf(" DNNL_BUILD_STRING: %s\n",DNNL_BUILD_STRING);
        printf(" Consider isa=%-8x --> set_max_cpu_isa(%s) OK\n",
                isa, dnnl_cpu_isa2str(toc(isa)));
        printf(" info[isa]={this_isa=%-8x, ", (int)info.this_isa);
        char const* sep = "{";
        for(auto compat : info.cpu_isa_compatible){
            printf("%s%x", sep, (int)compat);
            sep = ", ";
        }
        printf("}}\n");
        printf(" this_isa=%x status: %smayiuse(%x)\n",
                info.this_isa, (ok_this_isa? " ": "!"), info.this_isa);
#endif
        for (auto cur_isa : cpu_isa_set) { // vanilla, isa_any, sse41, ..., isa_all
            bool const ok_cur_isa = test_mayiuse(cur_isa);
            bool const compatible =
                    info.cpu_isa_compatible.find(cur_isa)
                    != info.cpu_isa_compatible.end();
#if DEBUG_ISA_MASK
            printf("  Can%3s use %-8x and it is %3s in compatibility list\n",
                    (ok_cur_isa? "": "not"), cur_isa, (compatible? "": "not"));
#endif
            if (compatible) {
                ASSERT_TRUE(!ok_this_isa || ok_cur_isa)
                        << (test_mayiuse(info.this_isa) ? "can" : "cannot")
                        << " use this_isa=" << (void *)isa << ", and "
                        << (test_mayiuse(cur_isa) ? "can" : "cannot")
                        << " use [compatible] cur_isa=" << (void *)cur_isa;
            } else {
                ASSERT_TRUE(!ok_cur_isa)
                        << " cur_isa=" << (void *)cur_isa
                        << " not in compat table"
                        << ", but "
                        << (test_mayiuse(cur_isa) ? "can" : "cannot")
                        << " use cur_isa=" << (void *)cur_isa << " (fix "
                        << __FILE__ << ")";
            }
        }
    } // namespace dnnl
};

TEST_P(isa_test, TestISA) {}
#if TARGET_X86
INSTANTIATE_TEST_SUITE_P(TestISACompatibility, isa_test,
        ::testing::Values(cpu_isa::vanilla, cpu_isa::sse41, cpu_isa::avx,
                cpu_isa::avx2, cpu_isa::avx512_mic, cpu_isa::avx512_mic_4ops,
                cpu_isa::avx512_core, cpu_isa::avx512_core_vnni,
                cpu_isa::avx512_core_bf16));
#else // non-x86 : just use the generic values
INSTANTIATE_TEST_SUITE_P(TestISACompatibility, isa_test,
        ::testing::Values(cpu_isa::vanilla,
                cpu_isa::any,
                cpu_isa::all
                ));
#endif

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
} // namespace dnnl
