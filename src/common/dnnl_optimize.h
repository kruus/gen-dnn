/*******************************************************************************
 * Copyright 2017 NEC Labs America
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not
* use this file except in compliance with the License.  You may obtain a copy
* of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
* WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
* License for the specific language governing permissions and limitations under
* the License.
*******************************************************************************/
#ifndef DNNL_OPTIMIZE_H
#define DNNL_OPTIMIZE_H
/** \file
 * Non-OpenMP optimization pragmas, \b only defining macros.
 *
 * These may be highly specific to particular compilers, and can
 * help speed up reference implementations, while expanding to
 * nothing in other cases.
 *
 * Can be turned OFF by defined ENABLE_OPT_PRAGMAS 0 before including
 */

#if defined(__ve)
#ifndef restrict
#define restrict __restrict
#endif
#endif

#if !defined(ENABLE_OPT_PRAGMAS)
#define ENABLE_OPT_PRAGMAS 1
#endif

#ifdef _MSC_VER // __pragma takes an unquoted arg UNTESTED (see z_magic.hpp)
// untested !!!
#define CXX_PRAGMA(...) __pragma(__VA_ARGS__)
#define EVAL_ARGS(...) __VA_ARGS__
#define PragmaQuote(...) CXX_PRAGMA(EVAL_ARGS(__VA_ARGS__))

#else // most compilers allow _Pragma("something") macros
#define CXX_PRAGMA(str) _Pragma(str)
#define STRINGIFY_ARGS(...) #__VA_ARGS__
#define PragmaQuote(...) CXX_PRAGMA(STRINGIFY_ARGS(__VA_ARGS__))
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
// -----------------------------------

//
// deprecated / unused
//#   define PRAGMASIMD(...) PragmaQuote(simd __VA_ARGS__)
//

#if ENABLE_OPT_PRAGMAS && defined(_SX)
#define VREG(...) PragmaQuote(cdir vreg(__VA_ARGS__))
#define ALLOC_ON_VREG(...) PragmaQuote(cdir alloc_on_vreg(__VA_ARGS__))
#define ALLOC_ON_ADB(...) PragmaQuote(cdir alloc_on_adb(__VA_ARGS__))
#define RETAIN(...) PragmaQuote(cdir on_adb(__VA_ARGS__))
#define RETAIN1st(var, ...) PragmaQuote(cdir on_adb(var))
#define ShortLoop() _Pragma("cdir shortloop")
#define ShortLoopTest()
#define IVDEP() _Pragma("cdir nodep")
#define UNROLL(x)
#define SIMD(...)

#elif ENABLE_OPT_PRAGMAS && defined(__ve)
#define VREG(...) PragmaQuote(_NEC vreg(__VA_ARGS__))
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...) PragmaQuote(_NEC retain(__VA_ARGS__))
#define RETAIN1st(var, ...) PragmaQuote(_NEC retain(var))
#define ShortLoop() _Pragma("_NEC shortloop")
#define ShortLoopTest() _Pragma("_NEC shortloop_reduction")
#define IVDEP() _Pragma("_NEC ivdep")
#define UNROLL(x) PragmaQuote(_NEC unroll(x))
#define SIMD(...) PragmaQuote(vector)

#elif ENABLE_OPT_PRAGMAS && defined(__INTEL_COMPILER)
#define IVDEP() _Pragma("ivdep")
#define UNROLL(x) PragmaQuote(unroll(x))
//  TODO 
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define SIMD(...) PragmaQuote(simd __VA_ARGS__)

#elif ENABLE_OPT_PRAGMAS && defined(_MSC_VER) && !defined(__clang__) \
        && !defined(__INTEL_COMPILER)
#warning "Please check if __pragma macros can be defined for this platorm"
#define IVDEP()
#define UNROLL(x)
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define SIMD(...)

#elif ENABLE_OPT_PRAGMAS && defined(__GNUC__)
//#warning "__GNUC optimization pragmas IN EFFECT"
#define IVDEP() _Pragma("GCC ivdep")
#define UNROLL(x) PragmaQuote(GCC unroll x)
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define SIMD(...)

#else /* A new system might begin by ignoring the optimization pragmas */
#if ENABLE_OPT_PRAGMAS
#warning "Please check if _Pragma macros can be defined for this platorm"
#endif
#define IVDEP()
#define UNROLL(x)
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define SIMD(...)

#endif

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // DNNL_OPTIMIZE_H
