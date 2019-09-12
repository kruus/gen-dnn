/*******************************************************************************
* Copyright 2018 Intel Corporation
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
#include "mkldnn_thread.hpp" // for crude cache size guesses, use omp_get_max_threads

#if defined(_WIN32) && !defined(__GNUC__)
#   define STRUCT_ALIGN(al, ...) __declspec(align(al)) __VA_ARGS__
#elif defined(__ve)
#   define STRUCT_ALIGN(al, ...) __VA_ARGS__ __attribute__((__aligned__((al)>16? 16: (al))))
#else
#   define STRUCT_ALIGN(al, ...) __VA_ARGS__ __attribute__((__aligned__(al)))
#endif

//@{
/** \ref JITFUNCS compile-time thresholds for x86 code.
 *
 * <em>gen-dnn</em> compile introduces "vanilla" target for a library that can run on any CPU.
 * It removes all jit and xbyak code, and runs... slowly.
 * This is set by compile time flag <b>-DTARGET_VANILLA</b>.
 * In this case we set JITFUNCS=JITFUNCS_NONE.
 *
 * Or you can compile with -DJITFUNCS=-1 equiv to JITFUNCS_NONE and we'll define TARGET_VANILLA
 * So vanilla ccompile should check for
 *   <B>defined(TARGET_VANILA) || (JITFUNCS==JITFUNCS_VANILLA)</B>
 *
 * <em>mkl-dnn</em> without <b>-DTARGET_VANILLA</B> you can set other <B>JITFUNCS_FOO</b>,
 * to compiles xbyak and includes all jit implementations for CPU type FOO (or lower)
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
#define JITFUNCS_NONE -1
#define JITFUNCS_ANY 0
#define JITFUNCS_SSE42 1
#define JITFUNCS_AVX 2
#define JITFUNCS_AVX2 3
#define JITFUNCS_AVX512 4
#define JITFUNCS_VANILLA 5
//@}

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
#define JITFUNCS JITFUNCS_NONE
#elif defined(JITFUNCS) && (JITFUNCS <= 0 || JITFUNCS == JITFUNCS_VANILLA) && !defined(TARGET_VANILLA)
/** synonom for JITFUNCS <= 0 */
#define TARGET_VANILLA
#endif

#ifndef JITFUNCS
/* default mkl-dnn compile works as usual, JITFUNCS_ANY means include all impls,
 * which is effectively same as JITFUNCS_AVX512. */
#define JITFUNCS JITFUNCS_ANY
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

typedef enum {
    isa_any,
    sse41,
    avx,
    avx2,
    avx512_common,
    avx512_core,
    avx512_core_vnni,
    avx512_mic,
    avx512_mic_4ops,
    avx512_core_bf16,
    aurora,
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

// cpu_isa_traits (now always exists)
template <cpu_isa_t> struct cpu_isa_traits {}; /* ::vlen -> 32 (for avx2) */

template <> struct cpu_isa_traits<sse41> {
#if !defined(TARGET_VANILLA)
    typedef Xbyak::Xmm Vmm;
#endif
    static constexpr int vlen_shift = 4;
    static constexpr int vlen = 16;
    static constexpr int n_vregs = 16;
};
template <> struct cpu_isa_traits<avx> {
#if !defined(TARGET_VANILLA)
    typedef Xbyak::Ymm Vmm;
#endif
    static constexpr int vlen_shift = 5;
    static constexpr int vlen = 32; // 256-bit regs --> 32 *bytes*
    static constexpr int n_vregs = 16;
};
template <> struct cpu_isa_traits<avx2>:
    public cpu_isa_traits<avx> {};

template <> struct cpu_isa_traits<avx512_common> {
#if !defined(TARGET_VANILLA)
    typedef Xbyak::Zmm Vmm;
#endif
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

template <> struct cpu_isa_traits<avx512_core_bf16>:
    public cpu_isa_traits<avx512_common> {};

template <> struct cpu_isa_traits<aurora> {
    static constexpr int vlen_shift = 8;
    static constexpr int vlen = 256*8; // 2 kByte vector regs (256 cwdouble or 512 packed float)
    static constexpr int n_vregs = 64;
};
// END cpu_isa_traits (vector register defaults)

inline bool isa_has_bf16(cpu_isa_t isa) {
#if defined(__ve)
    return false;
#else
    return isa == avx512_core_bf16;
#endif
}

#if defined(TARGET_VANILLA) || (defined(JITFUNCS) && JITFUNCS==JITFUNCS_VANILLA)
// should not include jit_generator.hpp (or any other jit stuff)
static inline constexpr bool mayiuse(const cpu_isa_t cpu_isa) {
#if defined(__ve)
    return cpu_isa == aurora;
#else
    return (void)cpu_isa,false;
#endif
}
#else

namespace {
static Xbyak::util::Cpu cpu;
static inline bool mayiuse(const cpu_isa_t cpu_isa) {
    using namespace Xbyak::util;

    switch (cpu_isa) {
    case sse41:
        return cpu.has(Cpu::tSSE41);
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
    case avx512_core_bf16:
        return true
            && mayiuse(avx512_core_vnni)
            && cpu.has(Cpu::tAVX512_BF16);
    case isa_any:
        return true;
    }
    return false;
}
}//anon::
#endif

namespace {
    inline unsigned int get_cache_size(int level, bool per_core = true){
	unsigned int l = level - 1;
#if defined(__ve)
        unsigned const cpuDataCacheLevels = 1;
#elif !defined(TARGET_VANILLA)
        unsigned const cpuDataCacheLevels = cpu.getDataCacheLevels();
#else
        unsigned const cpuDataCacheLevels = 0;
#endif
	// Currently, if XByak is not able to fetch the cache topology
	// we default to 32KB of L1, 512KB of L2 and 1MB of L3 per core.
	if (cpuDataCacheLevels == 0){
	    const int L1_cache_per_core = 32000;
	    const int L2_cache_per_core = 512000;
	    const int L3_cache_per_core = 1024000;
	    int num_cores = per_core ? 1 : mkldnn_get_max_threads();
	    switch(l){
	      case(0): return L1_cache_per_core * num_cores;
	      case(1): return L2_cache_per_core * num_cores;
	      case(2): return L3_cache_per_core * num_cores;
	      default: return 0;
	    }
	}
	if (l < cpuDataCacheLevels) {
#if defined(__ve)
	    return cpu.getDataCacheSize(l)
		/ (per_core ? cpu.getCoresSharingDataCache(l) : 1);
#else
            size_t const cpuDataCacheSize = 16*1024*1024;
	    return cpuDataCacheSize
		/ (per_core ? mkldnn_get_max_threads() : 1);
#endif
	} else
	    return 0;
    }
}//anon::
/* whatever is required to generate string literals... */
#include "z_magic.hpp"
#define JIT_IMPL_NAME_HELPER(prefix, isa, suffix_if_any) \
    (isa == sse41 ? prefix STRINGIFY(sse41) : \
    (isa == avx ? prefix STRINGIFY(avx) : \
    (isa == avx2 ? prefix STRINGIFY(avx2) : \
    (isa == avx512_common ? prefix STRINGIFY(avx512_common) : \
    (isa == avx512_core ? prefix STRINGIFY(avx512_core) : \
    (isa == avx512_core_vnni ? prefix STRINGIFY(avx512_core_vnni) : \
    (isa == avx512_mic ? prefix STRINGIFY(avx512_mic) : \
    (isa == avx512_mic_4ops ? prefix STRINGIFY(avx512_mic_4ops) : \
    (isa == avx512_core_bf16 ? prefix STRINGIFY(avx512_core_bf16) : \
    prefix suffix_if_any)))))))))

}
}
}

#endif
