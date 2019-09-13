/*******************************************************************************
* Copyright 2018 Intel Corporation
* MODIFICATIONS Copyright 2019 NEC Labs America
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

#ifndef CPU_ISA_TRAITS_HPP
#define CPU_ISA_TRAITS_HPP
/** \file
 * This file has been branched off of jit_generator.hpp to provide those "jit"
 * utilities/macros that are also useful to non-jit programs.
 */

#include <type_traits>
#include "mkldnn_subset.hpp"
#include "mkldnn_thread.hpp" // for crude cache size guesses, use omp_get_max_threads

#if defined(_WIN32) && !defined(__GNUC__)
#   define STRUCT_ALIGN(al, ...) __declspec(align(al)) __VA_ARGS__
#elif defined(__ve)
#   define STRUCT_ALIGN(al, ...) __VA_ARGS__ __attribute__((__aligned__((al)>16? 16: (al))))
#else
#   define STRUCT_ALIGN(al, ...) __VA_ARGS__ __attribute__((__aligned__(al)))
#endif

#if defined(TARGET_VANILLA) && !defined(JITFUNCS)
/** In principle could have multiple TARGETS.
 * For example: VANILLA, and later perhaps SSE42, AVX2, AVX512.
 * Default is "compile everything".
 * These TARGETS can be set in cmake to generate reduced-functionality libmkldnn.
 * Which jit impls get included in the engine is capped by a single value.
 *
 *
 * For example, TARGET_VANILLA includes NO Intel JIT code at all, and is suitable
 * for [cross-]compiling for other platforms.
 *
 * \note TARGET_VANILLA impls are not *yet* optimized for speed! */
#define JITFUNCS 0
#endif

#ifndef JITFUNCS
/* default mkl-dnn compile works as usual, 100 means include all impls */
#define JITFUNCS 100
#endif

//#if JITFUNCS == 0
//#warning "JITFUNCS == 0"
//#endif

#if !defined(TARGET_VANILLA)
#define XBYAK64
#define XBYAK_NO_OP_NAMES
/* in order to make selinux happy memory that would be marked with X-bit should
 * be obtained with mmap */
#define XBYAK_USE_MMAP_ALLOCATOR
#if defined(_MSC_VER) && !defined(__INTEL_COMPILER)
/* turn off `size_t to other-type implicit casting` warning
 * currently we have a lot of jit-generated instructions that
 * take uint32_t, but we pass size_t (e.g. due to using sizeof).
 * FIXME: replace size_t parameters with the appropriate ones */
#pragma warning (disable: 4267)
#endif

#include "xbyak/xbyak.h"
#include "xbyak/xbyak_util.h"
#endif

namespace mkldnn {
namespace impl {
namespace cpu {

//@{
/** \ref JITFUNCS compile-time thresholds.
 *
 * <em>gen-dnn</em> compile introduces "vanilla" target for a library that can run on any CPU.
 * It removes all jit and xbyak code, and runs... slowly.
 *
 * This is set by compile time flags <b>-DTARGET_VANILLA -DJITFUNCS=0</b>.
 *
 * <em>mkl-dnn</em> compile by default uses <b>-DJITFUNCS=100</b>,
 * which compiles xbyak and includes all jit implementations.
 *
 * To remove a subset of implementations from libmkldnn (well, at least remove them from the
 * default list in \ref cpu_engine.cpp ) you can compare the JITFUNCS value with these
 * thresholds.
 *
 * - Example:
 *   - '#if JITFUNCS >= JITFUNCS_AVX2'
 *     - for a code block enabled for AVX2 or higher CPU
 *
 * Default jit compile has JITFUNCS=100,
 *
 * *WIP* \sa cpu_isa_t
 */
#define JITFUNCS_ANY 0
#define JITFUNCS_SSE42 1
#define JITFUNCS_AVX 1
#define JITFUNCS_AVX2 2
#define JITFUNCS_AVX512 3
//@}

typedef enum {
    isa_any,
    sse42,
    avx,
    avx2,
    avx512_common,
    avx512_core,
    avx512_core_vnni,
    avx512_mic,
    avx512_mic_4ops,
} cpu_isa_t;

// generic, from jit_generator.hpp
typedef enum {
    PAGE_4K = 4096,
    PAGE_2M = 2097152,
} cpu_page_size_t;

#if defined(__ve)
    enum { CACHE_LINE_SIZE = 128 }; // is ADB cache line size the relevant quantity?
#else
    enum { CACHE_LINE_SIZE = 64 };
#endif

template <cpu_isa_t> struct cpu_isa_traits {}; /* ::vlen -> 32 (for avx2) */
#if !defined(TARGET_VANILLA)
template <> struct cpu_isa_traits<sse42> {
    typedef Xbyak::Xmm Vmm;
    static constexpr int vlen_shift = 4;
    static constexpr int vlen = 16;
    static constexpr int n_vregs = 16;
};
template <> struct cpu_isa_traits<avx> {
    typedef Xbyak::Ymm Vmm;
    static constexpr int vlen_shift = 5;
    static constexpr int vlen = 32;
    static constexpr int n_vregs = 16;
};
template <> struct cpu_isa_traits<avx2>:
    public cpu_isa_traits<avx> {};

template <> struct cpu_isa_traits<avx512_common> {
    typedef Xbyak::Zmm Vmm;
    static constexpr int vlen_shift = 6;
    static constexpr int vlen = 64;
    static constexpr int n_vregs = 32;
};
template <> struct cpu_isa_traits<avx512_core>:
    public cpu_isa_traits<avx512_common> {};

template <> struct cpu_isa_traits<avx512_mic>:
    public cpu_isa_traits<avx512_common> {};

template <> struct cpu_isa_traits<avx512_mic_4ops>:
    public cpu_isa_traits<avx512_common> {};
#endif // cpu_isa_traits (vector register defaults)

#if defined(TARGET_VANILLA)
// should not include jit_generator.hpp (or any other jit stuff)
static inline constexpr bool mayiuse(const cpu_isa_t /*cpu_isa*/) {
    return true;
}
#else

namespace {
static Xbyak::util::Cpu cpu;
static inline bool mayiuse(const cpu_isa_t cpu_isa) {
    using namespace Xbyak::util;

    switch (cpu_isa) {
    case sse42:
        return cpu.has(Cpu::tSSE42);
    case avx:
        return cpu.has(Cpu::tAVX);
    case avx2:
        return cpu.has(Cpu::tAVX2);
    case avx512_common:
        return cpu.has(Cpu::tAVX512F);
    case avx512_core:
        return true
            && cpu.has(Cpu::tAVX512F)
            && cpu.has(Cpu::tAVX512BW)
            && cpu.has(Cpu::tAVX512VL)
            && cpu.has(Cpu::tAVX512DQ);
    case avx512_core_vnni:
        return true
            && cpu.has(Cpu::tAVX512F)
            && cpu.has(Cpu::tAVX512BW)
            && cpu.has(Cpu::tAVX512VL)
            && cpu.has(Cpu::tAVX512DQ)
            && cpu.has(Cpu::tAVX512_VNNI);
    case avx512_mic:
        return true
            && cpu.has(Cpu::tAVX512F)
            && cpu.has(Cpu::tAVX512CD)
            && cpu.has(Cpu::tAVX512ER)
            && cpu.has(Cpu::tAVX512PF);
    case avx512_mic_4ops:
        return true
            && mayiuse(avx512_mic)
            && cpu.has(Cpu::tAVX512_4FMAPS)
            && cpu.has(Cpu::tAVX512_4VNNIW);
    case isa_any:
        return true;
    }
    return false;
}
}//anon::
#endif // mayiuse

namespace {
/** To avoid pulling in Xbyak, we \em guess the cache sizes for TARGET_VANILLA.
 * \sa jit_generator.hpp for a more informed version.
 * TODO: think about whether this can be done better, or maybe
 *       disconnected from Xbyak a bit more.
 * For now, the only non-jit files using cache info are the
 * batch normalization routines in {cpu,ncsp}_batch_normalization.cpp
 */
inline unsigned int get_cache_size(int level, bool per_core = true){
    unsigned int l = level - 1;
#if !defined(TARGET_VANILLA)
    // Currently, if XByak is not able to fetch the cache topology
    // we default to 32KB of L1, 512KB of L2 and 1MB of L3 per core.
    if (cpu.data_cache_levels == 0){
#endif
        const int L1_cache_per_core = 32000;
        const int L2_cache_per_core = 512000;
        const int L3_cache_per_core = 1024000;
        int num_cores = per_core ? 1 : omp_get_max_threads();
        switch(l){
        case(0): return L1_cache_per_core * num_cores;
        case(1): return L2_cache_per_core * num_cores;
        case(2): return L3_cache_per_core * num_cores;
        default: return 0;
        }
#if !defined(TARGET_VANILLA)
    }
    if (l < cpu.data_cache_levels) {
        return cpu.data_cache_size[l]
            / (per_core ? cpu.cores_sharing_data_cache[l] : 1);
    } else
        return 0;
#endif
}
}//anon::

/* whatever is required to generate string literals... */
#define JIT_IMPL_NAME_HELPER(prefix, isa, suffix_if_any) \
    (isa == sse42 ? prefix STRINGIFY(sse42) : \
    (isa == avx ? prefix STRINGIFY(avx) : \
    (isa == avx2 ? prefix STRINGIFY(avx2) : \
    (isa == avx512_common ? prefix STRINGIFY(avx512_common) : \
    (isa == avx512_core ? prefix STRINGIFY(avx512_core) : \
    (isa == avx512_mic ? prefix STRINGIFY(avx512_mic) : \
    (isa == avx512_mic_4ops ? prefix STRINGIFY(avx512_mic_4ops) : \
    prefix suffix_if_any)))))))

}
}
}

#endif
