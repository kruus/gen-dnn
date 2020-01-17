/*******************************************************************************
* Copyright 2019 Intel Corporation
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

#include "gtest/gtest.h"

#include "dnnl.hpp"
#include "src/cpu/cpu_isa_traits.hpp"

namespace dnnl {

#if TARGET_X86_JIT // dnnl original
class isa_set_once_test : public ::testing::Test {};
TEST(isa_set_once_test, TestISASetOnce) {
    auto st = set_max_cpu_isa(cpu_isa::sse41);
    ASSERT_TRUE(st == status::success || st == status::unimplemented);
    ASSERT_TRUE(impl::cpu::mayiuse(impl::cpu::sse41));
    st = set_max_cpu_isa(cpu_isa::sse41);
    ASSERT_TRUE(st == status::invalid_arguments || st == status::unimplemented);
};

#elif TARGET_X86 // without jit
// added so at least something gets tested.  Ref impls for vanilla
// may not exist for everything you want, though :) XXX
class isa_set_once_vanilla : public ::testing::Test {};
TEST(isa_set_once_vanilla, TestISASetOnceVanilla) {
    auto st = set_max_cpu_isa(cpu_isa::vanilla);
    ASSERT_TRUE(st == status::success || st == status::unimplemented);
    ASSERT_TRUE(impl::cpu::mayiuse(impl::cpu::vanilla));
    st = set_max_cpu_isa(cpu_isa::vanilla);
    ASSERT_TRUE(st == status::invalid_arguments || st == status::unimplemented);
};

#elif TARGET_VE
class isa_set_once_ve : public ::testing::Test {};
TEST(isa_set_once_ve, TestISASetOnceVE) {
    auto st = set_max_cpu_isa(cpu_isa::vednn);
    ASSERT_TRUE(st == status::success || st == status::unimplemented);
    ASSERT_TRUE(impl::cpu::mayiuse(impl::cpu::vednn));
    st = set_max_cpu_isa(cpu_isa::vednn);
    ASSERT_TRUE(st == status::invalid_arguments || st == status::unimplemented);
};
#endif

} // namespace dnnl
