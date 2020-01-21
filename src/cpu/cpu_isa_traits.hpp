/*******************************************************************************
* Copyright 2018-2019 Intel Corporation
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

#include "dnnl_thread.hpp"      // dnnl_get_max_threads
#include "dnnl_types.h"
#include "utils.hpp"

#if defined(_WIN32) && !defined(__GNUC__)
#   define STRUCT_ALIGN(al, ...) __declspec(align(al)) __VA_ARGS__
#elif defined(__ve)
#   define STRUCT_ALIGN(al, ...) __VA_ARGS__ __attribute__((__aligned__((al)>16? 16: (al))))
#else
#   define STRUCT_ALIGN(al, ...) __VA_ARGS__ __attribute__((__aligned__(al)))
#endif

#if TARGET_X86_JIT
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
#pragma warning(disable : 4267)
#endif

#include "xbyak/xbyak.h"
#include "xbyak/xbyak_util.h"
#endif

namespace dnnl {
namespace impl {
namespace cpu {

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

//typedef enum {
//    isa_any,
//    sse41,
//    avx,
//    avx2,
//    avx512_common,
//    avx512_core,
//    avx512_core_vnni,
//    avx512_mic,
//    avx512_mic_4ops,
//    avx512_core_bf16,
//    aurora,
//} cpu_isa_t;

enum cpu_isa_bit_t : unsigned {
    /** impls using only C/C++ code. Typicall ref impls, but may be built
     * to use external gemm routines (cblas/MKL). inline assembler only when
     * absolutely necessary (by checking compile flags). */
    vanilla_bit         = 1U << 0,
    /// @defgroup x86_jit_flags x86 JIT levels
    //@{
    x86_bit             = 1U << 1, ///< new, x86 jit like dnnl_cpu_isa_all
    sse41_bit           = 1u << 2,
    avx_bit             = 1u << 3,
    avx2_bit            = 1u << 4,
    avx512_common_bit   = 1u << 5,
    avx512_mic_bit      = 1u << 6,
    avx512_mic_4ops_bit = 1u << 7,
    avx512_core_bit     = 1u << 8,
    avx512_core_vnni_bit =1u << 9,
    avx512_core_bf16_bit =1u << 10,
    x86_11_bit          = 1u << 11, ///< future use
    x86_12_bit          = 1u << 12, ///< future use
    x86_13_bit          = 1u << 13, ///< future use
    x86_14_bit          = 1u << 14, ///< future use
    x86_15_bit          = 1u << 15, ///< future use
    x86_bits            = 0xffffu,               ///< set of x86 flags
    //x86_jit_bits        = 0xffffu ^ vanilla_bit, ///< set of x86 flags
    ///@}
    /// @defgroup VE_extensions VE extended capabilities
    ///@{
    ve_common_bit       = 1u << 16, ///< without libvednn support (slow, equiv vanilla)
    ve_vednn_bit        = 1u << 17, ///< DNNL_CPU_VE with libvednn support
    ve_vejit_bit        = 1u << 18, ///< TBD: VE with jit support (also via libvednn)
    ve_19_bit           = 1u << 19, ///< future use
    ve_bits             = 0xf0000u | vanilla_bit, ///< set of VE flags
    ///@}
};

// We leave all of them available, because mayiuse will simply return
// false if a cpu_isa_t doesn't make sense.
enum cpu_isa_t : unsigned {
    unknown             = 0,
    /** \enum vanilla
     * cpu-agnostic ref code only (possibly cblas/mkl calls).
     * \note non-jit builds may need to pull in some inline assembler.
     * lowest common denominator.
     * \todo could \c vanilla be 0x00 (avoiding vanilla_bit)?
     */
    vanilla             = vanilla_bit,
    /// @defgroup x86_jit_masks x86-specific jit masks
    //@{
    x86_any             = x86_bit | vanilla,
    sse41               = sse41_bit | x86_any,
    avx                 = avx_bit | sse41,
    avx2                = avx2_bit | avx,
    //
    avx512_common       = avx512_common_bit | vanilla,
    avx512_mic          = avx512_mic_bit | avx512_common,
    avx512_mic_4ops     = avx512_mic_4ops_bit | avx512_mic,
    //
    avx512_core         = avx512_core_bit | avx512_common,
    avx512_core_vnni    = avx512_core_vnni_bit | avx512_core,
    avx512_core_bf16    = avx512_core_bf16_bit | avx512_core_vnni,
    x86_all             = x86_bits,
    //@}
    /// @defgroup ve_jit_masks VE-specific implementation masks
    //@{
    ve_common = ve_common_bit | vanilla,
    vednn     = ve_vednn_bit | ve_common_bit,
    vejit     = ve_vejit_bit | vednn,
    ve_all    = ve_bits,
    //@}
    // following mappings handle cpu-agnostic settings
    /** \enum isa_any
     * "ANY" is a cpu-specific generic target.
     * - x86 : allow x86 jit with no vec ops
     * - VE  : same as "VANILLA" */
    /** \enum isa_all
     * "ALL" makes all optimizations for target cpu available.
     * - x86 : allow max instruction set for jit impls.
     * - VE  : allow libvednn with full jit capabilities */
#if DNNL_CPU == DNNL_CPU_X86
    isa_any = x86_any,
    isa_all = x86_bits,          // all varieties of x86 jit
#elif DNNL_CPU == DNNL_CPU_VE
    isa_any = ve_common,
    isa_all = ve_bits,           // all types of VE optimizations
#endif
};

template <cpu_isa_t>
struct cpu_isa_traits {}; /* ::vlen -> 32 (for avx2) */

template <>
struct cpu_isa_traits<vanilla> { // Note: should work for x86/VE cpu
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_vanilla;
    static constexpr const char *user_option_env = "VANILLA";
};

// "ANY" is cpu-specific
template <>
struct cpu_isa_traits<x86_any> {
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_any;
    static constexpr const char *user_option_env = "ANY";
};
template <>
struct cpu_isa_traits<ve_common> { // VE behavior same as VANILLA
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_any;
    static constexpr const char *user_option_env = "ANY";
    static constexpr int vlen_shift = 8;
    // 2 kB vector regs (256 double or 512 packed float)
    static constexpr int vlen = 256*8;
    static constexpr int n_vregs = 64;
};
//

/// x86-specific
//@{
template <>
struct cpu_isa_traits<sse41> {
#if TARGET_X86_JIT
    typedef Xbyak::Xmm Vmm;
#endif // TARGET_X86_JIT
    static constexpr int vlen_shift = 4;
    static constexpr int vlen = 16;
    static constexpr int n_vregs = 16;
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_sse41;
    static constexpr const char *user_option_env = "SSE41";
};

template <>
struct cpu_isa_traits<avx> {
#if TARGET_X86_JIT
    typedef Xbyak::Ymm Vmm;
#endif // TARGET_X86_JIT
    static constexpr int vlen_shift = 5;
    static constexpr int vlen = 32; // 256-bit regs --> 32 *bytes*
    static constexpr int n_vregs = 16;
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_avx;
    static constexpr const char *user_option_env = "AVX";
};

template <>
struct cpu_isa_traits<avx2> : public cpu_isa_traits<avx> {
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_avx2;
    static constexpr const char *user_option_env = "AVX2";
};

template <>
struct cpu_isa_traits<avx512_common> { // for convenience
#if TARGET_X86_JIT
    typedef Xbyak::Zmm Vmm;
#endif // TARGET_X86_JIT
    static constexpr int vlen_shift = 6;
    static constexpr int vlen = 64;
    static constexpr int n_vregs = 32;
};

template <>
struct cpu_isa_traits<avx512_core> : public cpu_isa_traits<avx512_common> {
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_avx512_core;
    static constexpr const char *user_option_env = "AVX512_CORE";
};

template <>
struct cpu_isa_traits<avx512_mic> : public cpu_isa_traits<avx512_common> {
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_avx512_mic;
    static constexpr const char *user_option_env = "AVX512_MIC";
};

template <>
struct cpu_isa_traits<avx512_mic_4ops> : public cpu_isa_traits<avx512_mic> {
    static constexpr dnnl_cpu_isa_t user_option_val
            = dnnl_cpu_isa_avx512_mic_4ops;
    static constexpr const char *user_option_env = "AVX512_MIC_4OPS";
};

template <>
struct cpu_isa_traits<avx512_core_vnni> : public cpu_isa_traits<avx512_core> {
    static constexpr dnnl_cpu_isa_t user_option_val
            = dnnl_cpu_isa_avx512_core_vnni;
    static constexpr const char *user_option_env = "AVX512_CORE_VNNI";
};

template <>
struct cpu_isa_traits<avx512_core_bf16> : public cpu_isa_traits<avx512_core> {
    static constexpr dnnl_cpu_isa_t user_option_val
            = dnnl_cpu_isa_avx512_core_bf16;
    static constexpr const char *user_option_env = "AVX512_CORE_BF16";
};

/// "ALL" --> isa_all **just** for x86 build --> x86_bits
template <>
struct cpu_isa_traits<x86_all> { // isa_all just for x86
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_all;
    static constexpr const char *user_option_env = "ALL";
};
//@}

template <>
struct cpu_isa_traits<vednn> : public cpu_isa_traits<ve_common> {
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_vednn;
    static constexpr const char *user_option_env = "VEDNN";
};

template <>
struct cpu_isa_traits<vejit> : public cpu_isa_traits<ve_common> {
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_vejit;
    static constexpr const char *user_option_env = "VEJIT";
};

/// "ALL" --> isa_all **just** for ve build --> ve_bits
template <>
struct cpu_isa_traits<ve_all> : public cpu_isa_traits<ve_common> {
    static constexpr dnnl_cpu_isa_t user_option_val = dnnl_cpu_isa_all;
    static constexpr const char *user_option_env = "ALL";
    static constexpr int vlen_shift = 8;
    static constexpr int vlen = 256*8; // 2 kByte vector regs (256 cwdouble or 512 packed float)
    static constexpr int n_vregs = 64;
};

cpu_isa_t DNNL_API get_max_cpu_isa(bool soft = false);
// END cpu_isa_traits (vector register defaults)

namespace {

/** Convert from public dnnl_cpu_isa value to internal bitflags value.
 * Since dnnl.h dnnl_cpu_isa values and cpu_isa values are now decoupled,
 * portable tests should *not* rely on equality between values of the
 * two enum types.
 * \return the appropriate cpu_isa enum value for the build target,
 *         or \c unknown.
 * \todo \c from_dnnl sig could use C++ enum as "cpu_isa_t from_dnnl(cpu_isa isa)" */
static inline cpu_isa_t from_dnnl(dnnl_cpu_isa_t isa){
    static int const verbose=0;
    using namespace dnnl::impl;
    using namespace dnnl::impl::cpu;

    // return \c unknown if unrecognized
    cpu_isa_t isa_to_set = unknown;
#define HANDLE_CASE(cpu_isa) \
    case cpu_isa_traits<cpu_isa>::user_option_val: isa_to_set = cpu_isa; break;

    // convert a dnnl.h \c isa value to internal \c cpu_isa_t
    switch (isa) {
        // Note cases here should match init_max_cpu_isa()
        // All target cpus support "VANILLA", "ANY", and "ALL"
        HANDLE_CASE(isa_all);
        HANDLE_CASE(vanilla);
        HANDLE_CASE(isa_any);   // for x86, adds generic x86 jit to vanilla
#if TARGET_X86
        HANDLE_CASE(sse41);     // x86 jit with vec ops
        HANDLE_CASE(avx);
        HANDLE_CASE(avx2);
        HANDLE_CASE(avx512_mic);
        HANDLE_CASE(avx512_mic_4ops);
        HANDLE_CASE(avx512_core);
        HANDLE_CASE(avx512_core_vnni);
        HANDLE_CASE(avx512_core_bf16);
#elif TARGET_VE
        HANDLE_CASE(vednn);     // vanilla + libvednn "C" api
        HANDLE_CASE(vejit);     // vednn + libvednn jit
#endif
        default: /*unknown*/ ;
    }
#undef HANDLE_CASE
    if(verbose)
        printf(" from_dnnl(0x%lx) --> cpu_isa_t(0x%lx)\n",
                (long)isa, (long)isa_to_set);
    return isa_to_set;
}


#if TARGET_X86_JIT
static Xbyak::util::Cpu cpu;
/** mayiuse is a runtime check that an ISA is available on the target CPU,
 * and we respect a \c soft runtime limit.  Build time x86 limits are mostly
 * enforced by \c cpu_engine (by pruning the impl lists at compile time).
 *
 * \note It is \b not a required side effect of \c mayiuse that \c get_max_cpu_isa be called.  Tests relying on this should \e explicitly call
 * \c get_max_cpu_isa(bool const soft).
 */
static inline bool mayiuse(const cpu_isa_t cpu_isa, const bool soft = false) {
    unsigned cpu_isa_mask = get_max_cpu_isa(soft);
    if ((cpu_isa_mask & cpu_isa) != cpu_isa) return false;

    using namespace Xbyak::util;

    switch (cpu_isa) {
        case isa_any: return true;
        case sse41: return cpu.has(Cpu::tSSE41);
        case avx: return cpu.has(Cpu::tAVX);
        case avx2: return cpu.has(Cpu::tAVX2);
        case avx512_common: return cpu.has(Cpu::tAVX512F);
        case avx512_core:
            return cpu.has(Cpu::tAVX512F) && cpu.has(Cpu::tAVX512BW)
                    && cpu.has(Cpu::tAVX512VL) && cpu.has(Cpu::tAVX512DQ);
        case avx512_core_vnni:
            return cpu.has(Cpu::tAVX512F) && cpu.has(Cpu::tAVX512BW)
                    && cpu.has(Cpu::tAVX512VL) && cpu.has(Cpu::tAVX512DQ)
                    && cpu.has(Cpu::tAVX512_VNNI);
        case avx512_mic:
            return cpu.has(Cpu::tAVX512F) && cpu.has(Cpu::tAVX512CD)
                    && cpu.has(Cpu::tAVX512ER) && cpu.has(Cpu::tAVX512PF);
        case avx512_mic_4ops:
            return mayiuse(avx512_mic, soft) && cpu.has(Cpu::tAVX512_4FMAPS)
                    && cpu.has(Cpu::tAVX512_4VNNIW);
        case avx512_core_bf16:
            return mayiuse(avx512_core_vnni, soft)
                    && cpu.has(Cpu::tAVX512_BF16);
        case isa_all: return false;
        default:
                      assert(!"unhandled x86 mayiuse");
                      return false;
    }
    return false;
}

#elif TARGET_X86 // and no jit, only "VANILLA" build is usable
static inline constexpr bool mayiuse(cpu_isa_t const cpu_isa, bool const soft=false) {
    //unsigned cpu_isa_mask = get_max_cpu_isa(soft);
    //if ((cpu_isa_mask & cpu_isa) != cpu_isa) return false;

    // for a vanilla build, we should only be able to set to vanilla?
    return cpu_isa == vanilla; // ??
}

#else // non-x86 target cpu
static inline constexpr bool mayiuse(cpu_isa_t const cpu_isa, bool const soft=false) {
#ifdef DNNL_ENABLE_MAX_CPU_ISA
    //unsigned cpu_isa_mask = get_max_cpu_isa(soft);
    //if ((cpu_isa_mask & cpu_isa) != cpu_isa) return false;
#if TARGET_X86
    return cpu_isa == vanilla; // ??
#elif TARGET_VE
    // soft limit for VE TBD XXX
    return (cpu_isa==isa_any? true
            : cpu_isa==vednn? (CPU_ISA >= CPU_ISA_VEDNN)
            : cpu_isa==vejit? (CPU_ISA >= CPU_ISA_VEJIT)
            : false
#else
#error "unhandled DNNL_CPU target cpu"
#endif
#else
    // non-x86 don't yet have a reason to call mayiuse...
    return ((void)soft,(void)cpu_isa, false);
#endif // DNNL_ENABLE_MAX_CPU_ISA
}

#endif // TARGET_* mayiuse variations
} // namespace

namespace {
inline unsigned int get_cache_size(int level, bool per_core = true){
    unsigned int l = level - 1;
#if TARGET_VE
    unsigned const cpuDataCacheLevels = 1;
#elif TARGET_X86_JIT
    unsigned const cpuDataCacheLevels = cpu.getDataCacheLevels();
#else
    unsigned const cpuDataCacheLevels = 0; // use default settings
#endif
    // Currently, if XByak is not able to fetch the cache topology
    // we default to 32KB of L1, 512KB of L2 and 1MB of L3 per core.
    if (cpuDataCacheLevels == 0){
        const int L1_cache_per_core = 32000;
        const int L2_cache_per_core = 512000;
        const int L3_cache_per_core = 1024000;
        int num_cores = per_core ? 1 : dnnl_get_max_threads();
        switch(l){
        case(0): return L1_cache_per_core * num_cores;
        case(1): return L2_cache_per_core * num_cores;
        case(2): return L3_cache_per_core * num_cores;
        default: return 0;
        }
    }
    if (l < cpuDataCacheLevels) {
#if TARGET_VE
        return cpu.getDataCacheSize(l)
                / (per_core ? cpu.getCoresSharingDataCache(l) : 1);
#else
        size_t const cpuDataCacheSize = 16*1024*1024;
        return cpuDataCacheSize
                / (per_core ? dnnl_get_max_threads() : 1);
#endif
    } else
        return 0;
}

inline bool isa_has_bf16(cpu_isa_t isa) {
    return TARGET_X86 \
            && isa == avx512_core_bf16;
}

} // namespace

/* whatever is required to generate string literals... */
#include "z_magic.hpp"
/* clang-format off */
#if TARGET_X86_JIT
#define JIT_IMPL_NAME_HELPER(prefix, isa, suffix_if_any) \
    ( (isa) == isa_any            ? (prefix STRINGIFY(x86)) \
    : (isa) == sse41              ? (prefix STRINGIFY(sse41)) \
    : (isa) == avx                ? (prefix STRINGIFY(avx)) \
    : (isa) == avx2               ? (prefix STRINGIFY(avx2)) \
    : (isa) == avx512_common      ? (prefix STRINGIFY(avx512_common)) \
    : (isa) == avx512_core        ? (prefix STRINGIFY(avx512_core)) \
    : (isa) == avx512_core_vnni   ? (prefix STRINGIFY(avx512_core_vnni)) \
    : (isa) == avx512_mic         ? (prefix STRINGIFY(avx512_mic)) \
    : (isa) == avx512_mic_4ops    ? (prefix STRINGIFY(avx512_mic_4ops)) \
    : (isa) == avx512_core_bf16   ? (prefix STRINGIFY(avx512_core_bf16)) \
    : (isa) == avx512_core_bf16   ? (prefix STRINGIFY(avx512_core_bf16)) \
    : prefix suffix_if_any)

#else
// non-jit so far has no use for this macro
#define JIT_IMPL_NAME_HELPER(prefix, isa, suffix_if_any) \
    prefix "OOPS_no_x86_jit" suffix_if_any
#endif // TARGET_X86_JIT
/* clang-format on */

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif
