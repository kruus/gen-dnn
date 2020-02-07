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
#include "dnnl_debug.h"
#include "src/cpu/cpu_isa_traits.hpp"

#include <iostream>
using std::cout;
using std::endl;

namespace dnnl {

//
// choose a dnnl_cpu_isa and cpu_isa type good for the build target
//
#if TARGET_X86_JIT && CPU_ISA >= CPU_ISA_SSE41
#define ISA sse41 /* dnnl original value */
#warning "isa_set_once_test using dnnl_cpu_isa_sse41"
#elif TARGET_X86_JIT
#define ISA any
#warning "isa_set_once_test using dnnl_cpu_isa_any"
#elif TARGET_X86
#define ISA vanilla
#warning "isa_set_once_test using dnnl_cpu_isa_vanilla"
#elif TARGET_VE
#define ISA vanilla
#warning "isa_set_once_test using dnnl_cpu_isa_any"
#else
#error "Please choose an appropriate dnnl_cpu_isa_FOO for this build target"
#endif

#define STR_(...) #__VA_ARGS__
#define STR(...) STR_(__VA_ARGS__)

// NOTE: original used a cpu_isa value for set_max_cpu_isa, however, it
// is easy (usual) for some inconsistencies to creep into the match between
// dnnl_cpu_isa *public* values and cpu_isa *internal* ones.
//
// Note that there is some code effort expended to decouple the two
// set of values :)
//
// Note: this test ASSUMES that 'mayiuse' invokes 'get_max_cpu_isa',
//       which "locks in" the cpu_isa value from further change.
//
// Better would be to also call get_max_cpu_isa explicitly, to
// allow mayiuse to have trivial implementations.
//
class isa_set_once_test : public ::testing::Test {
    virtual void SetUp() {
        cout<<" Test using cpuisa_flags ISA = "<<STR(ISA)<<endl;
    }
};

TEST(isa_set_once_test, TestISASetOnce) {
    // The internal flags value, arg of mayiuse(cpu_isa_t) from cpu_isa_traits.hpp
    using dnnl::impl::cpu::mayiuse; // decl as a static inline in dnnl::impl::cpu::anon
#if 1
    // The dnnl.h enum value
#define PUBLIC_ISA CONCAT2(dnnl_cpu_isa_,ISA) /* MUST use dnnl_isa_FOO dnnl.h value */
    impl::cpu::cpu_isa_t cpuisa_flags = impl::cpu::from_dnnl(PUBLIC_ISA);
    printf("%s 0x%lx --> cpu_isa_t cpuisa_flags = 0x%lx\n", STRINGIFY(PUBLIC_ISA),
            (long)PUBLIC_ISA, (long)cpuisa_flags);
#endif
    ASSERT_TRUE(cpuisa_flags != impl::cpu::unknown);

    static const bool c_api = 1; // Both must compile
    if( c_api ){
        // test the 'C' interface (can do either the C or C++ version, not both)
        // used extern "C" version of set_max_cpu_isa
        auto st = dnnl_set_max_cpu_isa(PUBLIC_ISA);
        printf("first time calling dnnl_set_max_cpu_isa(0x%lx) returned %s\n",
                (long)PUBLIC_ISA, dnnl_status2str(st));
        ASSERT_TRUE(st == dnnl_success || st == dnnl_unimplemented);

        // safer: also call get_max_cpu_isa directly
        printf(" get_max_cpu_isa() returns %d\n",(int)impl::cpu::get_max_cpu_isa());
        ASSERT_TRUE(impl::cpu::get_max_cpu_isa() != impl::cpu::unknown);
        // this now becomes a secondary test,
        // desirable, but not really absolutely necessary
        ASSERT_TRUE(mayiuse(cpuisa_flags));

        st = dnnl_set_max_cpu_isa(PUBLIC_ISA);
        printf("second time calling dnnl_set_max_cpu_isa(0x%lx) returned %s\n",
                (long)PUBLIC_ISA, dnnl_status2str(st));
        ASSERT_TRUE(st == dnnl_invalid_arguments || st == dnnl_unimplemented);
    }else{
        // equivalent C++ test
        // The C++ version of dnnl.h enum value, arg of set_max_cpu_isa(cpu_isa) in dnnl.hpp.
        // These values are always equivalent to the dnnl.h values.
        dnnl::cpu_isa cpuisa = static_cast<dnnl::cpu_isa>(PUBLIC_ISA);
        using dnnl::set_max_cpu_isa;
        // The C++ function static casts back to dnnl_cpu_isa_t and calls the extern "C" function
        auto st = set_max_cpu_isa(cpuisa);
        //printf("first time calling dnnl::set_max_cpu_isa(0x%lx) returned %s\n",
        //        (long)cpuisa, dnnl_status2str(static_cast<dnnl_status_t>(st)));
        ASSERT_TRUE(st == status::success || st == status::unimplemented);

        // safer: also call get_max_cpu_isa directly
        ASSERT_TRUE(impl::cpu::get_max_cpu_isa() != impl::cpu::unknown);
        // this now becomes a secondary test,
        // desirable, but not really absolutely necessary
        ASSERT_TRUE(mayiuse(cpuisa_flags));

        st = set_max_cpu_isa(cpuisa);
        //printf("second time calling dnnl::set_max_cpu_isa(0x%lx) returned %s\n",
        //        (long)cpuisa, dnnl_status2str(static_cast<dnnl_status_t>(st)));
        ASSERT_TRUE(st == status::invalid_arguments || st == status::unimplemented);
    }

};

} // namespace dnnl
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
