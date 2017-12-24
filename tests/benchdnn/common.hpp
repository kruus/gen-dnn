/*******************************************************************************
* Copyright 2017 Intel Corporation
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

#ifndef _COMMON_HPP
#define _COMMON_HPP

#include <assert.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <math.h>

// How is the restrict keyword handled?
#if !defined(restrict)
#if defined(_SX)
#elif defined(__ve)
//#elif defined(__INTEL_COMPILER)
//#elif defined(__GNUC__)
#else
#define restrict
#endif
#endif

// ENABLE_OPT_PTRAGMAS
//    set to 0 to debug pragma-related incorrect assumptions
#if !defined(ENABLE_OPT_PRAGMAS)
#if defined(_SX)
#define ENABLE_OPT_PRAGMAS 1
#elif defined(__ve)
#define ENABLE_OPT_PRAGMAS 1
#elif defined(__INTEL_COMPILER)
#define ENABLE_OPT_PRAGMAS 1
#elif defined(__GNUC__)
#define ENABLE_OPT_PRAGMAS 1
#else
#define ENABLE_OPT_PRAGMAS 0/*XXX*/
#endif
#endif

// ENABLE_OMP defaults to 1
#if !defined(ENABLE_OMP)
#if defined(_SX)
#elif defined(__ve)
#define ENABLE_OMP 0
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
#warning "SX optimization pragmas IN EFFECT"
#define VREG(...) PragmaQuote(cdir vreg(__VA_ARGS__))
#define ALLOC_ON_VREG(...) PragmaQuote(cdir alloc_on_vreg(__VA_ARGS__))
#define ALLOC_ON_ADB(...) PragmaQuote(cdir alloc_on_adb(__VA_ARGS__))
// Is there a pre-for-loop RETAIN for SX? For now, kludge as on_adb.
#define RETAIN(...) PragmaQuote(cdir on_adb(__VA_ARGS__))
#define RETAIN1st(var,...) PragmaQuote(cdir on_adb(var))
#define ShortLoop() _Pragma("cdir shortloop")
#define ShortLoopTest() /*?*/
#define IVDEP() _Pragma("cdir nodep")

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

// TODO
//#elif ENABLE_OPT_PRAGMAS && defined(__INTEL_COMPILER)
#elif ENABLE_OPT_PRAGMAS && defined(__GNUC__)
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define IVDEP() _Pragma("GCC ivdep")

#else /* A new system might begin by ignoring the optimization pragmas */
#warning "Please check if _Pragma macros can be defined for this platorm"
#define VREG(...)
#define ALLOC_ON_VREG(...)
#define ALLOC_ON_ADB(...)
#define RETAIN(...)
#define ShortLoop()
#define ShortLoopTest()
#define IVDEP()

#endif


#if ENABLE_OMP
#define OMP(...) PragmaQuote(omp __VA_ARGS__)
#else
#define OMP(...)
#endif

// -----------------------------------


#define OK 0
#define FAIL 1

#ifdef _WIN32
#define strncasecmp _strnicmp
#define strcasecmp _stricmp
#define __PRETTY_FUNCTION__ __FUNCSIG__
#endif

/** \deprecated -- rdbutso REMOVED the 'ticks' functionality as the easiest fix :) */
#define USE_RDPMC 0
#define USE_RDTSC 0

enum { CRIT = 1, WARN = 2 };

#define SAFE(f, s) do { \
    int status = f; \
    if (status != OK) { \
        if (s == CRIT || s == WARN) { \
            fflush(0), fprintf(stderr, "@@@ error [%s:%d]: '%s' -> %d\n", \
                    __PRETTY_FUNCTION__, __LINE__, \
                    #f, status), fflush(0); \
            if (s == CRIT) exit(1); \
        } \
        return status; \
    } \
} while(0)

#define RT_ASSERT( COND ) do { \
    bool const rt_assert_cond = (COND); \
    if( ! rt_assert_cond ) { \
        fflush(0), fprintf(stderr, "@@@ error [%s:%d]: '%s' -> false\n", \
                __PRETTY_FUNCTION__, __LINE__, #COND), fflush(0); \
        exit(1); \
    } \
}while(0)


#define ABS(a) ((a)>0?(a):(-(a)))

#define MIN2(a,b) ((a)<(b)?(a):(b))
#define MAX2(a,b) ((a)>(b)?(a):(b))

#define MIN3(a,b,c) MIN2(a,MIN2(b,c))
#define MAX3(a,b,c) MAX2(a,MAX2(b,c))

#define STRINGIFy(s) #s
#define STRINGIFY(s) STRINGIFy(s)

#define CONCAt2(a,b) a ## b
#define CONCAT2(a,b) CONCAt2(a,b)

#if ! defined(_SX)
inline void *zmalloc(size_t size, size_t align) {
    void *ptr;
#ifdef _WIN32
    ptr = _aligned_malloc(size, align);
    int rc = ((ptr) ? 0 : errno);
#else
    // TODO. Heuristics: Increasing the size to alignment increases
    // the stability of performance results.
    if (size < align)
        size = align;
    int rc = ::posix_memalign(&ptr, align, size);
#endif /* _WIN32 */
    return rc == 0 ? ptr : 0;
}
inline void zfree(void *ptr) {
#ifdef _WIN32
    _aligned_free(ptr);
#else
    return ::free(ptr);
#endif /* _WIN32 */
}

#else // SX architecture does not have/need posix_memalign
inline void *zmalloc(size_t size, size_t align) {
    return ::malloc(size);
}
inline void zfree(void *ptr) { return ::free(ptr); }
#endif

/** generic benchmarking operating modes/modifiers.
 * \p CORR 'C'orrectness - executes default mkldnn convolution and reference impl
 * \p PERF 'P'erformance - loops execution of default mkldnn convolution for timings
 * \p ALL  'A'll         - 'C' or 'P' modifier -- add *all* mkldnn impls [if any]
 * \p TEST 'T'est        - 'C' or 'P' modifier -- add extra *test* benchdnn impls [if any]
 */
enum bench_mode_t { MODE_UNDEF = 0x0, CORR = 0x1, PERF = 0x2, TEST=0x4, ALL=0x8 };
const char *bench_mode2str(bench_mode_t mode);
bench_mode_t str2bench_mode(const char *str);

extern int verbose;
extern bench_mode_t bench_mode;

#define print(v, fmt, ...) do { \
    if (verbose >= v) { \
        printf(fmt, __VA_ARGS__); \
        /* printf("[%d][%s:%d]" fmt, v, __func__, __LINE__, __VA_ARGS__); */ \
        fflush(0); \
    } \
} while (0)

struct test_stats;      ///< optional, opaque
struct stat_t {
    int tests;          ///< count convolution problem specs
    int impls;          ///< count convolution impls (==tests if not iterating over impls)
    int passed;
    int failed;
    int skipped;
    int mistrusted;
    int unimplemented;
    int test_fail;      ///< --mode=TEST failure count
    test_stats *ts;     ///< optional --mode=TEST stats
};
extern stat_t benchdnn_stat;

enum prim_t {
    SELF, CONV, IP, DEF = CONV,
};

enum dir_t {
    DIR_UNDEF = 0,
    FLAG_DAT = 1, FLAG_WEI = 2, FLAG_BIA = 4,
    FLAG_FWD = 32, FLAG_BWD = 64,
    FWD_D = FLAG_FWD + FLAG_DAT,
    FWD_B = FLAG_FWD + FLAG_DAT + FLAG_BIA,
    BWD_D = FLAG_BWD + FLAG_DAT,
    BWD_W = FLAG_BWD + FLAG_WEI,
    BWD_WB = FLAG_BWD + FLAG_WEI + FLAG_BIA,
};
dir_t str2dir(const char *str);
const char *dir2str(dir_t dir);

enum res_state_t { UNTESTED = 0, PASSED, SKIPPED, MISTRUSTED, UNIMPLEMENTED,
    FAILED };
const char *state2str(res_state_t state);

bool str2bool(const char *str);
const char *bool2str(bool value);

bool match_regex(const char *str, const char *pattern);

/* perf */
extern double max_ms_per_prb; /** maximum time spends per prb in ms */
extern int min_times_per_prb; /** minimal amount of runs per prb */
extern int fix_times_per_prb; /** if non-zero run prb that many times */

struct benchdnn_timer_t {
    enum mode_t { min = 0, avg = 1, max = 2, n_modes };

    benchdnn_timer_t() { reset(); }

    void reset(); /** fully reset the measurements */

    void start(); /** restart timer */
    void stop(); /** stop timer & update statistics */

    void stamp() { stop(); }

    int times() const { return times_; }

    double total_ms() const { return ms_[avg]; }

    double ms(mode_t mode = benchdnn_timer_t::min) const
    { return ms_[mode] / (mode == avg ? times_ : 1); }

    long long ticks(mode_t mode = min) const
    { return ticks_[mode] / (mode == avg ? times_ : 1); }

    benchdnn_timer_t &operator=(const benchdnn_timer_t &rhs);

    int times_;
    long long ticks_[n_modes], ticks_start_;
    double ms_[n_modes], ms_start_;
#if USE_RDPMC || USE_RDTSC
    long long ticks_[n_modes], ticks_start_;
#endif
};

/** result structure. \c errors / \c total now now valid only for
 * current impl within a single \c doit test. */
struct res_t {
    res_state_t state;          ///< final status of one or more impls
    int errors, total;          ///< elementwise compare errors/total
    benchdnn_timer_t timer;
};

#endif
