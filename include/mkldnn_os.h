/*******************************************************************************
* Copyright 2017 NEC Labs America
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
/** \file
 * handle various compiler/os retrictions */
#ifndef _MKLDNN_OS_H_
#define _MKLDNN_OS_H_

//#include "os_common.hpp" // not available -- we use mkldnn public API only.
#if 1
#if defined(SXAURORA)
#define strnlen strnlen_s
#endif

// How is the restrict keyword handled? (disallow it as you encounter errors, please)
#if !defined(restrict)
#if defined(_SX)
#elif defined(__ve)
#elif defined(__INTEL_COMPILER)
#elif defined(__GNUC__)
#define restrict
#elif defined(WIN32)
#else
#endif
#endif

// Any restrictions on the alignas attribute?
#ifdef __ve
#define alignas(x) alignas((x) > 16 ? 16 : (x))
#endif
#endif

// ENABLE_OPT_PRAGMAS
//    set to 0 to debug pragma-related incorrect assumptions
#if !defined(ENABLE_OPT_PRAGMAS)
//#warning "Unknown system: optimization pragmas NOT USED"
//#define ENABLE_OPT_PRAGMAS 0/*XXX*/
#define ENABLE_OPT_PRAGMAS 1
#endif

// ENABLE_OMP defaults to 1
#if !defined(ENABLE_OMP)
#if defined(_SX)
#elif defined(__ve) // OMP is not yet supported by ncc/nc++
//#define ENABLE_OMP 0  // at Dec. 25th 2017 release, ncc may support OMP
#elif defined(__INTEL_COMPILER)
#elif defined(__GNUC__)
#else
#endif
#if !defined(ENABLE_OMP)
#define ENABLE_OMP 1
#endif
#endif

// -------- compiler-specific pragmas --------
// __ve compile does something with pragma omp, but it is not officially supported,
// so we use C++11 _Pragma to emit pragmas from macros and customize pragmas to
// particular compilers.
//
// Allocation directives:
//   VREG          : hint that array fits into one simd register
//                   There may be many conditions on array access!
//   ALLOC_ON_VREG : hint that array fits into multiple simd registers
//   ALLOC_ON_ADB  : hint that array should be "cached" in special memory bank.
//
// Loop directives apply to an IMMEDIATELY FOLLOWING loop:
//   ShortLoop : hint that for-loop limit is less than max simd register length
//   RETAIN    : hint that array should be kept accesible (cached)
//   IVDEP     : pretend all ptrs are independent (restrict)
//
// TODO: SX pre-loop macros must be SINGLE ones, because sxcc REQUIRES
//       multiple #pragma cdir to be combined, comma-separated.
//       So you can only use ONE pre-loop macro.  If 2 macros,
//       compiler docs say **both** will be ignored!
//
// FIXME  SX alloc_on_vreg 2nd arg must be a compile-time constant
//
// Oh! ALLOC_ON_VREG cannot "decay" into RETAIN, because syntax is different
// -----------------------------------
#define BENCHDNN_YPRAGMA(str) do{int ypr=str;}while(0);
#define BENCHDNN_MPRAGMA(str) _Pragma(str)
#define BENCHDNN_STRINGIZE(...) #__VA_ARGS__
#define PragmaQuote(...) BENCHDNN_MPRAGMA(BENCHDNN_STRINGIZE(__VA_ARGS__))

#if ENABLE_OPT_PRAGMAS && defined(_SX)
// SX preprocessor generates _Pragma(XXX) and sxc++ might be ignoring
//    *some*, based on failure to produce some warning messages.
//#warning "SX optimization pragmas IN EFFECT"
#define VREG(...) PragmaQuote(cdir vreg(__VA_ARGS__))
#define ALLOC_ON_VREG(...) PragmaQuote(cdir alloc_on_vreg(__VA_ARGS__))
#define ALLOC_ON_ADB(...) PragmaQuote(cdir alloc_on_adb(__VA_ARGS__))
// Is there a pre-for-loop RETAIN for SX? For now, kludge as on_adb.
#define RETAIN(...) PragmaQuote(cdir on_adb(__VA_ARGS__))
#define RETAIN1st(var,...) PragmaQuote(cdir on_adb(var))
#define ShortLoop() _Pragma("cdir shortloop")
#define ShortLoopTest() /*?*/
#define IVDEP() _Pragma("cdir nodep")
#define UNROLL(x)

#elif ENABLE_OPT_PRAGMAS && defined(__ve)
#warning "__ve optimization pragmas IN EFFECT"
#define VREG(...) PragmaQuote(_NEC vreg(__VA_ARGS__))
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...) PragmaQuote(_NEC retain(__VA_ARGS__))
#define RETAIN1st(var,...) PragmaQuote(_NEC retain(var))
#define ShortLoop() _Pragma("_NEC shortloop")
#define ShortLoopTest() _Pragma("_NEC shortloop_reduction")
#define IVDEP() _Pragma("_NEC ivdep")
#define UNROLL(x) PragmaQuote(_NEC unroll(x))

// TODO
//#elif ENABLE_OPT_PRAGMAS && defined(__INTEL_COMPILER)

#elif ENABLE_OPT_PRAGMAS && defined(__GNUC__)
//#warning "__GNUC optimization pragmas IN EFFECT"
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define IVDEP() _Pragma("GCC ivdep")
#define UNROLL(x) PragmaQuote(GCC unroll x)

#else /* A new system might begin by ignoring the optimization pragmas */
#warning "Please check if _Pragma macros can be defined for this platorm"
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define IVDEP()
#define UNROLL(x)

#endif


#if ENABLE_OMP
#define OMP(...) PragmaQuote(omp __VA_ARGS__)
#if defined(__ve)
#warning "__ve enabling #pragma omp"
#endif
#if defined(_SX) // no support for "simd" pragmas
#else // defined(__GNUC) or intel or ...
#if defined(__ve)
#warning "__ve enabling #pragma [omp] simd"
#endif
#define PRAGMASIMD(...) PragmaQuote(simd __VA_ARGS__)
#define OMPSIMD(...) PragmaQuote(omp simd __VA_ARGS__)
#endif
#endif

#ifndef OMP
#define OMP(...)
#endif
#ifndef OMPSIMD
#define OMPSIMD(...)
#endif

#endif // _MKLDNN_OS_H_
