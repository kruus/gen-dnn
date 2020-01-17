/*******************************************************************************
* Copyright 2020 NEC Labs America
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
#ifndef CPU_TARGET_H
#define CPU_TARGET_H
/** \file
 * extra build-time cpu/isa macros, based dnnl_config.h ONLY.
 */

#include "dnnl_config.h"

#if defined(TARGET_VANILLA)
#error "NEW WAY gets TARGET_VANILLA etc from dnnl_config.h ONLY, no -DTARGET_VANILLA"
#endif
#if defined(JITFUNCS)
#error "NEW WAY gets TARGET_VANILLA etc from dnnl_config.h ONLY, no -DJITFUNCS=n"
#endif

//
// TARGET_VANILLA is same as DNNL_TARGET_VANILLA (always defined)
//
//#define TARGET_VANILLA DNNL_TARGET_VANILLA
//
// oh, now this is always defined... temp. compatibility fix XXX
//
#if DNNL_TARGET_VANILLA
#define TARGET_VANILLA
#warning "compat TARGET_VANILLA defined"
#else
#warning "TARGET_VANILLA undefined"
#endif

/// @defgroup cpu_target DNNL cpu and JIT macros
/**
 * <em>gen-dnn</em> compile introduces "vanilla" target for a library that
 * can run on any CPU.
 * It removes all xbyak code, and runs... slowly.
 * This can be set by compile time flag <b>-DTARGET_VANILLA</b>.
 * In this case we set JITFUNCS=JITFUNCS_NONE.
 * In a few spots compiler-specific inline asm might be required.
 *
 * \sa dnnl_config.h
 *
 * JITFUNCS are a coarser-granularity of CPU_ISA tests, because they cause compile-time
 * mods.  If possible, they should disappear and DNNL_ISA values be tested directly.
 */
//@{
/**
 * To remove a subset of implementations from libmkldnn (well, at least remove them from the
 * default list in \ref cpu_engine.cpp ) you can compare the JITFUNCS value with these
 * thresholds. This also affects the test and example code, since some tests may become
 * impossible to support.   A better way, if you can use it, is to use runtime CPU
 * dispatch.
 *
 * - Example:
 *   - '\#if JITFUNCS >= JITFUNCS_AVX2'
 *     - for a code block enabled only for AVX2 or higher CPU
 *   - New way might be:
 *     - '\#if DNNL_TARGET_X86 && DNNL_ISA >= DNNL_ISA_AVX2'
 *
 * Default jit compile has JITFUNCS=100,
 *
 * *WIP* \sa cpu_isa_t
 *
 * \deprecated
 */
#define JITFUNCS_NONE -1        /* remove? (or rename as JITFUNCS_VANILLA)? */
#define JITFUNCS_ANY 0          /* xbyak jit supporting old x86 cpus (no vector ops) useful? */
#define JITFUNCS_SSE41 1
#define JITFUNCS_SSE42 2 /* \deprecated? used? */
#define JITFUNCS_AVX 3
#define JITFUNCS_AVX2 4
#define JITFUNCS_AVX512 5       /* xbyak jit supporting latest x86 cpus */
/* no-xbyak builds start here, mostly C/C++ code only, rarely some inline asm,
 * and possibly linking to external libs for optimized kernels/impls. */
#define JITFUNCS_VANILLA 6
#define JITFUNCS_VE 7           /* allow libvednn+jit */
//@}

//
// JITFUNCS support should move to CPU_ISA checks (i.e. "derived from" for compatibility (temp.))
//
// JITFUNCS build limit for cpu_isa_t has coarser granularity than DNNL_ISA, so
// easier to handle. Ex. no JITFUNCS_MIC* compile time limit for JITFUNCS.
//
// VANILLA, ANY and ALL should be available for all cpus, but do different things
//
// ALL THIS JITFUNCS CRAP MUST GO AWAY !!! XXX
//
#if DNNL_ISA == DNNL_ISA_VANILLA
#if DNNL_TARGET_X86
#define JITFUNCS JITFUNCS_VANILLA
#warning "vanilla compat x86 JITFUNCS_NONE"
#elif DNNL_TARGET_VE
#define JITFUNCS JITFUNCS_VANILLA
#warning "vanilla compat ve JITFUNCS_VANILLA"
#endif // DNNL_TARGET

#elif DNNL_ISA == DNNL_ISA_ANY
#if DNNL_TARGET_X86
#define JITFUNCS JITFUNCS_ANY
#warning "any compat x86 JITFUNCS_ANY"
#elif DNNL_TARGET_VE
#define JITFUNCS JITFUNCS_VANILLA
#warning "any compat ve JITFUNCS_VANILLA"
#endif // DNNL_TARGET

#elif DNNL_ISA == DNNL_ISA_ALL
#if DNNL_TARGET_X86
#define JITFUNCS JITFUNCS_AVX512
#warning "all compat x86 JITFUNCS_AVX512"
#elif DNNL_TARGET_VE
#define JITFUNCS JITFUNCS_VE /* ? */
#warning "all compat ve JITFUNCS_VE /* ? */"
#endif // DNNL_TARGET

#elif DNNL_ISA == DNNL_ISA_SSE41 /* || DNNL_ISA == DNNL_ISA_SSE42 ? */
#define JITFUNCS JITFUNCS_SSE41
#warning "compat JITFUNCS_SSE41"
#elif DNNL_ISA == DNNL_ISA_AVX
#define JITFUNCS JITFUNCS_AVX
#warning "compat JITFUNCS_AVX"
#elif DNNL_ISA == DNNL_ISA_AVX2
#define JITFUNCS JITFUNCS_AVX2
#warning "compat JITFUNCS_AVX2"
#elif DNNL_ISA == DNNL_ISA_AVX512_MIC
#define JITFUNCS JITFUNCS_AVX2 /* not needed ? */
#warning "compat JITFUNCS_AVX2 /* not needed ? */"
#elif DNNL_ISA == DNNL_ISA_AVX512_MIC_4OPS
#define JITFUNCS JITFUNCS_AVX2 /* not needed ? */
#warning "compat JITFUNCS_AVX2 /* not needed ? */"
#elif DNNL_ISA == DNNL_ISA_AVX512_CORE
#define JITFUNCS JITFUNCS_AVX512
#warning "compat JITFUNCS_AVX512"
#elif DNNL_ISA == DNNL_ISA_AVX512_CORE_VNNI
#define JITFUNCS JITFUNCS_AVX512
#warning "compat JITFUNCS_AVX512"
#elif DNNL_ISA == DNNL_ISA_AVX512_CORE_BF16
#define JITFUNCS JITFUNCS_AVX512
#warning "compat JITFUNCS_AVX512"
#else
#error "unhandled DNNL_ISA value for compatibility setting of JITFUNCS"
#endif
/** \addtogroup cpu_target
 * Default cpu-specific builds allow max level of jit / external libs
 * available for your DNNL_CPU target
 */
#if !defined(TARGET_VANILLA) && !defined(JITFUNCS)
#warning "neither TARGET_VANILLA nor JITFUNCS was set"
#if DNNL_CPU == DNNL_CPU_X86
#define JITFUNCS JITFUNCS_AVX512
#elif DNNL_CPU == DNNL_CPU_VE
#define JITFUNCS_JITFUNCS_VE
#endif
#endif

#warning "compat-mode JITFUNCS was set based on DNNL_ISA value"

#if defined(TARGET_VANILLA) && !defined(JITFUNCS)
#warning "TARGET_VANILLA --> auto JITFUNCS"
/** \addto group cpu_target
 * Here we expand on cmake variables transmitted to \ref dnnl_config.h.
 * `cmake/options.cmake` describes various build options.
 *
 * Relation to cmake:
 *
 * - This file expands on the generated file, \ref dnnl_config.h
 * - The target cpu is autodetermined from \${CMAKE_SYSTEM_PROCESSOR}.
 * - You can tell cmake about desired maximum ISA/libraries with
 *   `cmake -DDNNL_ISA=`<em>string</em>.
 * - DNNL_ISA quickly, but only \e partially, limits available impls.
 *   - This is because for code deduplication, implementations like the
 *     `jit_uni_*` can decide to handle different ISAs internally.
 * - So you should \e also use runtime CPU dispatch (REF) to fully limit
 *   the ISA
 *   - Some build pruning may still be authoritative, like the drastic
 *     DNNL_ISA=VANILLA option that elides \e all JIT (xbyak) support.
 *
 * What we add to dnnl_config.h:
 *
 * - preprocessor macro booleans for desired build:
 *   - shorter versions of various `TARGET_condition` macros, like
 *     TARGET_X86, TARGET_VE, TARGET_X86_JIT
 *   - some `DNNL_ENABLE_code` macros that disable larger feature sets,
 *     like DNNL_ENABLE_RNN, DNNL_ENABLE_BFLOAT16.  These can help ports
 *     to new CPUs.
 *   - TODO a compile time MAYIUSE_foo, similar to \c mayiuse(cpu_isa,soft)
 *
 * \note builds like `cmake -DDNNL_ISA=VANILLA` may end up running much slower
 * reference implementations.
 *
 * \deprecated TARGET_VANILLA and old JITFUNCS have been replaced by the new
 * cmake build options.  We rely much less on transmitting options via
 * CFLAGS/CXXFLAGS.  The new boolean preprocessor defines are more readable,
 * \e positive tests covering many more conditions.
 */
#if DNNL_CPU == DNNL_CPU_X86
#define JITFUNCS JITFUNCS_VANILLA/*used to be JITFUNCS_NONE*/
#elif DNNL_CPU == DNNL_CPU_VE
#define JITFUNCS JITFUNCS_VANILLA
#endif
#endif

// hmmm. not quite right... perhaps !defined(TARGET_VANILLA) should become a
// positive TARGET_XBYAK test instead
// Idea:
//     JITFUNCS == JITFUNCS_ANY(0) now means xbyak is enabled, but possibly with no vector ops
//     --- see whether this might handle bfloat or other "simple" jit operations.
#if defined(JITFUNCS) && !defined(TARGET_VANILLA)
#if JITFUNCS == JITFUNCS_NONE
#define TARGET_VANILLA
#warning "JITFUNCS_NONE implies TARGET_VANILLA"
#elif JITFUNCS == JITFUNCS_VANILLA
#warning "JITFUNCS_VANILA implies TARGET_VANILLA"
#define TARGET_VANILLA
#elif JITFUNCS == JITFUNCS_VE
#warning "JITFUNCS_VE implies TARGET_VANILLA"
#define TARGET_VANILLA
#else
#warning "JITFUNCS --> ** NOT DEFINING ** TARGET_VANILLA"
#endif
#endif

#if 0 // old -- now DNNL_TARGET_X86_JIT is set by cmake, in dnnl_config.h
// set DNNL_ENABLE_XBYAK = 0 or 1 (shorthand)
#if (JITFUNCS >= JITFUNCS_ANY && JITFUNCS <= JITFUNCS_AVX2)
#define DNNL_ENABLE_XBYAK 1
#warning "JITFUNCS value implis need x86 xbyak jit support"
#if defined(TARGET_VANILLA)
#error "-DTARGET_VANILLA is incompatible with JITFUNCS being one of the x86 SIMD types"
#endif
#else
#define DNNL_ENABLE_XBYAK 0
#endif
#endif

#ifndef JITFUNCS
/* default mkl-dnn compile works as usual, JITFUNCS_ANY means include all impls,
 * which is effectively same as JITFUNCS_AVX512. */
#define JITFUNCS JITFUNCS_ANY
#error "Hmmm. Shouldn't JITFUNCS be defined by now? (historical check)"
#endif

#if JITFUNCS == 0
#warning "JITFUNCS == 0"
#endif

#if defined(__x86_64__) || defined(_M_X64)
#define DNNL_X86_64
#elif defined(__ve)
#define DNNL_VE // not yet used
#endif

#if defined(DNNL_X86_64) && (JITFUNCS==JITFUNCS_NONE || JITFUNCS > JITFUNCS_VANILLA)
#error "compiler incompatible with JITFUNCS > JITFUNCS_VANILLA (which are all non-x86 builds)"
#endif

// sanity checks...
#ifdef TARGET_VANILLA
#warning "cpu_target DONE TARGET_VANILLA defined"
#else
#warning "cpu_target DONE TARGET_VANILLA undefined"
#endif

// compat mode shortcuts, easier to read
#define TARGET_X86      DNNL_TARGET_X86
#define TARGET_X86_JIT  DNNL_TARGET_X86_JIT
#define TARGET_VE       DNNL_TARGET_VE
#define TARGET_VEDNN    DNNL_TARGET_VEDNN
#define TARGET_VEJIT    DNNL_TARGET_VEJIT
#define TARGET_BFLOAT16 DNNL_ENABLE_BFLOAT16/*maybe*/
#define TARGET_RNN      DNNL_ENABLE_RNN/*maybe*/

#if !TARGET_X86 && !TARGET_VE
#error "cpu target no true TARGET_foo !"
#endif
#if TARGET_X86 + TARGET_VE != 1
#error "exactly one of TARGET_VE and TARGET_X86 should be set"
#endif
#if 1 // verbose compiler warnings, for debug
#if TARGET_X86
#warning "cpu target TARGET_X86 !"
#endif
#if TARGET_X86_JIT
#warning "cpu target TARGET_X86_JIT !"
#endif
#if TARGET_VE
#warning "cpu target TARGET_VE !"
#endif
#if TARGET_VEDNN
#warning "cpu target TARGET_VEDNN !"
#endif
#if TARGET_VEJIT
#warning "cpu target TARGET_VEJIT !"
#endif
#if DNNL_ENABLE_RNN
#warning "DNNL_ENABLE_RNN is TRUE"
#else
#warning "DNNL_ENABLE_RNN is FALSE"
#endif
#if DNNL_ENABLE_BFLOAT16
#warning "DNNL_ENABLE_BLOAT16 is TRUE"
#else
#warning "DNNL_ENABLE_BLOAT16 is FALSE"
#endif
#endif // verbose compiler warnings
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // CPU_TARGET_H
