#ifndef VE_FASTDIV_H
#define VE_FASTDIV_H
/* Copyright (c) 2019 by NEC Corporation
 * This file is part of ve-jit */
/** \file
 * lean-and-mean VE-specific fastdiv support.
 * - At VL=256, this is ~ 4x as fast as using VDIV
 * - API simplified from ve-jit "expanded" division code.
 * - Please modify the original source in project ve-jit if
 *   you change ve_fastdiv.h or ve_fastdiv.c
 *
 * - Have \b no timing or support for integer division
 *   - usually signed division (VDVS) will be even slower than VDIV.
 *   - usually you begin by first trying to avoid this operation.
 *   - and often the integer division that's most useful does not
 *     follow C convention.
 *     - mathematically (e.g. bounding a linear function of loop index)
 *       round-to-negative-infinity is what you really want to use.
 */
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/** divide-by-\c _odiv via mul-add-shift. */
struct ve_fastdiv {
    // mul is uint32_t for vednn_fastdiv method,
    // but can be uint64_t for bounded method.
    uint64_t mul;
    uint32_t add;
    uint32_t shift;
    uint32_t _odiv;  /* save original divisor for modulo calc */
};

/** Fast \b uint32_t \c N/odiv division for VE.
 *
 * - For \c N in \b uint32_t range, \c (uint64_t)N&lt;UINT32_MAX,
 *   - but in a \c uint64_t scalar or vector register,
 * - find \c N/odiv by evaluating
 *   - \f$(N * mul + add) >> shift\f$
 * - using \b uint64_t intermediates.
 *
 * - Do not use for signed ops.
 * - \b Do use it for vector ops.
 * - \b Do use an additional mul-sub for a fast divmod op.
 * - \b VE does not provide any double-wide multiply ops, sigh,
 *   which is why the mul-add-shift must be done in \c uint64_t
 *
 * For scalars, the compiler will automatically use a similar approach
 * for compile-time constants, but it can help in case of
 * runtime scalar division with very high repetition count.
 *
 * Note: extension to uint64_t N is complicated because VE lacks ops
 * involved the 128-bit multiplication result.  This works by maintaining
 * all intermediates within 64-bit range, so it is different from algs
 * used for x86.
 *
 * Power of two \c odiv should give mul by 1 and add zero.
 *
 * Essential number of jit ops is 3 in worst case, but better if
 * \c mul is one or \add is zero or \c shift is zero.
 *
 * - Extracted results from tdivmod test in ve-jit, which
 *   actually measures modulus operation.
 *   - where \c nc++ shows scalar over twice as fast (3667-->1454)
 *   - and 1st col shows [full-length] VE vector op about 4x faster (45-->12)
 * ```
 * Results:
 *     VE Aurora (host aurora-ds02)
 * 
 * cyc2ns = 1.250000 __cycle=2975890480067434, __cycle=2975890480067438
 * clang++ -O3 ...                    nc++ -std=gnu++11 -O3
 * series_len = 256                              g++
 * ----------------------------       --------   --------
 * builtin_npot_cyc    : 3654.4ns     3667.3ns   1789.5ns  for(){% operator}
 * fd21_npot_cyc       : 1454.1 ns    1454.1ns   538.7 ns  for(){multiply-shift}
 * vfdiv_npot_cyc      : 45.3 ns                           vbrd,vdiv,vmul,vsub
 * vfd21_npot_cyc      : 11.6 ns                           
 * branchless_npot_cyc : 1634.7 ns    1669.1ns   694.4 ns
 * ```
 * Note that for a vector-of-divisors, you should use 3 separate vectors
 *      An array-of-struct will be much slower.
 */
void vednn_fastdiv(struct ve_fastdiv *d, uint32_t const divisor);

/** For \c divisor<=bound O(2^21), we may be able
 * to find a \c fastdiv that has \c add==0.
 *
 * If used, this alt method uses a 42-bit multiplier and right-shift of 21.
 *
 * The general 3-op method has 32-bit multiplier and larger shift, but often
 * the \c add is zero, so it is prefered because VE might be able to load the
 * multiplier scalar register in one op.
 *
 * Remember that if your vector register is sequential beginning at N,
 * you might need and additional safety margin,
 * like \c bound of \f$N_{max} + VL\f$. */
void vednn_fastdiv_bounded(struct ve_fastdiv *d, uint32_t const divisor, uint32_t bound);

#ifdef __cplusplus
}//extern "C"
#endif
// vim: ts=4 sw=4 et cindent cino=^=l0,\:.5s,=-.5s,N-s,g.5s,b1 cinkeys=0{,0},0),\:,0#,!^F,o,O,e,0=break
#endif //VE_FASTDIV_H
