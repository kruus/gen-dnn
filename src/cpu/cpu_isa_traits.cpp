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

#include <atomic>
#include <cstring>
#include <mutex>

#include "cpu_isa_traits.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

#ifdef DNNL_ENABLE_MAX_CPU_ISA

// A setting (basically a value) that can be set() multiple times until the
// time first time the get() method is called. The set() method is expected to
// be as expensive as a busy-waiting spinlock. The get() method is expected to
// be asymptotically as expensive as a single lock-prefixed memory read. The
// get() method also has a 'soft' mode when the setting is not locked for
// re-setting. This is used for testing purposes.
template <typename T>
struct set_before_first_get_setting_t {
private:
    T value_;
    bool initialized_;
    std::atomic<unsigned> state_;
    enum : unsigned { idle = 0, busy_setting = 1, locked_after_a_get = 2 };
    static int const verbose = 0;

public:
    set_before_first_get_setting_t(T init = T(0))
        : value_ {init}, initialized_ {false}, state_ {0} {}

    bool set(T new_value) {
        if (verbose) printf(" cpu_isa set(%lx)? ", (long)new_value);
        if (state_.load() == locked_after_a_get) return false;

        while (true) {
            unsigned expected = idle;
            if (state_.compare_exchange_weak(expected, busy_setting)) break;
            if (expected == locked_after_a_get) return false;
        }

        if (verbose) printf(" YES!\n");
        value_ = new_value;
        initialized_ = true;
        state_.store(idle);
        return true;
    }

    bool initialized() { return initialized_; }

    T get(bool soft = false) {
        if (!soft && state_.load() != locked_after_a_get) {
            while (true) {
                unsigned expected = idle;
                if (state_.compare_exchange_weak(expected, locked_after_a_get))
                    break;
                if (expected == locked_after_a_get) break;
            }
        }
        if (verbose)
            printf(" cpu_isa GET set-once value 0x%lx, then state-->%d\n",
                    (long)value_, (int)state_.load());
        return value_;
    }
};

set_before_first_get_setting_t<cpu_isa_t> &max_cpu_isa() {
    static set_before_first_get_setting_t<cpu_isa_t> max_cpu_isa_setting;
    //printf(" max_cpu_isa_setting @ 0x%08llx ",(long long)&max_cpu_isa_setting);
    return max_cpu_isa_setting;
}

bool init_max_cpu_isa() {
    static int const verbose = 0;
    if (verbose) printf("  init_max_cpu_isa!");
    if (max_cpu_isa().initialized()) {
        if (verbose) printf("  (already initialized!)");
        return false;
    }
    if (verbose) printf("  (not yet initialized!)");

    cpu_isa_t max_cpu_isa_val = (DNNL_CPU == DNNL_CPU_VE ? ve_all : isa_all);

    char buf[64];
    if (getenv("DNNL_MAX_CPU_ISA", buf, sizeof(buf)) > 0) {
#define IF_HANDLE_CASE(cpu_isa) \
    if (std::strcmp(buf, cpu_isa_traits<cpu_isa>::user_option_env) == 0) \
    max_cpu_isa_val = cpu_isa
#define ELSEIF_HANDLE_CASE(cpu_isa) else IF_HANDLE_CASE(cpu_isa)
        static const int verbose = 1;
        // allow case-insensitive compare
        for (size_t i = 0u; i < sizeof(buf) && buf[i]; ++i)
            buf[i] = toupper(i);

        IF_HANDLE_CASE(isa_all); // "ALL" CPU-specific
        ELSEIF_HANDLE_CASE(vanilla); // "VANILLA"
        ELSEIF_HANDLE_CASE(
                isa_any); // "ANY" (x86 jit ok, no vec ops; ve same as vanilla)
#if TARGET_X86
        ELSEIF_HANDLE_CASE(sse41);
        ELSEIF_HANDLE_CASE(avx);
        ELSEIF_HANDLE_CASE(avx2);
        ELSEIF_HANDLE_CASE(avx512_mic);
        ELSEIF_HANDLE_CASE(avx512_mic_4ops);
        ELSEIF_HANDLE_CASE(avx512_core);
        ELSEIF_HANDLE_CASE(avx512_core_vnni);
        ELSEIF_HANDLE_CASE(avx512_core_bf16);
        else if (verbose)
                printf("Bad DNNL_MAX_CPU_ISA=%s environment for x86", buf);
#elif TARGET_VE
        ELSEIF_HANDLE_CASE(vednn);
        ELSEIF_HANDLE_CASE(vejit);
        else if (verbose)
                printf("Bad DNNL_MAX_CPU_ISA=%s environment value for VE", buf);
#endif

#undef IF_HANDLE_CASE
#undef ELSEIF_HANDLE_CASE
    }

    if (verbose)
        printf(" init_max_cpu_isa-->cpu_isa(%lx)\n", (long)max_cpu_isa_val);
    return max_cpu_isa().set(max_cpu_isa_val);
}
#endif // DNNL_ENABLE_MAX_CPU_ISA

#if defined(DNNL_ENABLE_MAX_CPU_ISA)
cpu_isa_t get_max_cpu_isa(bool soft) {
    MAYBE_UNUSED(soft);
    init_max_cpu_isa();
    return max_cpu_isa().get(soft);
}

#else // could be constexpr
cpu_isa_t get_max_cpu_isa(bool soft) {
    MAYBE_UNUSED(soft);
    cpu_isa_t ret = unknown
#if TARGET_X86
            ret
            = isa_all;
#elif TARGET_VE // "isa_all" is not set up be cmake, it is only for x86
            ret
            = isa_ve_all;
#endif
    static_assert(ret != unknown, "unhandled get_max_cpu_isa case");
    return ret;
    ;
}
#endif // defined(DNNL_ENABLE_MAX_CPU_ISA)

} // namespace cpu
} // namespace impl
} // namespace dnnl

extern "C" {
/** set max_cpu_isa() to the \c cpu_isa_t mask corresponding to a
 * \c dnnl_cpu_isa_t.
 * When a \c cpu_isa trait field matches the dnnl \c isa value,
 * remember \c cpu_isa value.
 *
 * This decouples dnnl cpu_isa values [public] from cpu_isa [internal] ones.
 *
 * \c max_cpu_isa() ensures we set a value at most once (subsequent calls
 * should fail).
 */
dnnl_status_t dnnl_set_max_cpu_isa(dnnl_cpu_isa_t isa) {
    using namespace dnnl::impl::status;
#ifdef DNNL_ENABLE_MAX_CPU_ISA
    using namespace dnnl::impl;
    using namespace dnnl::impl::cpu;

    static int const verbose = 0;
    // XXX see if we can get rid of from_dnnl, at least in the header (see also tests/gtests/test_isa_*)
    cpu_isa_t isa_to_set = ::dnnl::impl::cpu::from_dnnl(isa);
    if (isa_to_set == unknown) return invalid_arguments;
    if (verbose)
        printf(" dnnl_set_max_cpu_isa(0x%lx) --> cpu_isa_t(0x%lx)\n", (long)isa,
                (long)isa_to_set);

    if (::dnnl::impl::cpu::max_cpu_isa().set(isa_to_set))
        return success;
    else
        return invalid_arguments;
#else
    return unimplemented;
#endif // DNNL_ENABLE_MAX_CPU_ISA
}
} // extern "C"

// vim: et ts=4 sw=4 cindent cino+=l0,\:4,N-s
