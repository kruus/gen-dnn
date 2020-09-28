/*******************************************************************************
* Copyright 2017-2020 NEC Labs America LLC
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

#ifndef HOIST_HPP
#define HOIST_HPP

#include "common/ve/idiv.hpp"
#include <assert.h>

#ifndef ALWAYS_INLINE
#define ALWAYS_INLINE
//#define ALWAYS_INLINE __attribute((always_inline))
#endif

namespace dnnl {
namespace impl {
namespace cpu {

namespace {
/** hoist linear for loop condition
 * \f$\{i \in [i_{beg},i_{end} \mathrm{and} o \def a+i \cdot b \in [o_{beg},o_{end}\}\f$
 * to a (returned) sub-for-subloop range \f$[i_{lo},i_{hi})\f$ .
 * \pre b>0, ibeg<=iend, obeg<=oend UNCHECKED
 * \return ilo,ihi
 * \post iff ilo<ihi, then ibeg<=ilo<ihi<=iend and o=a+i*b is in [obeg,oend)
 *
 * Caution: if the original for loop has an 'else' block to process
 * out-of-range a+i*b, and you wish to split off "before" and "after" loops,
 * then you may need to \b explicitly enfore ilo <= iend and ihi >= ibeg.
 *
 * Original:
 * \code
 * for(i=ibeg; i<iend; ++i){       // original loop
 *   int const o = a + i * b;      // linear fn w/ b>0
 *   if( o >= o_beg && o < o_end ) {
 *     // Loop Body
 *   }
 * }
 * \endcode
 * Transformed:
 * \code
 * int const ibeg, iend;
 * hoist_ApiB( ilo,ihi, ibeg,iend, a,b, obeg,oend );
 * for(i=ilo; i<ihi; ++i){         // sub-loop
 *   int const o = a + i*b;        // linear fn.
 *   assert( o >= o_beg && o < o_end );
 *   // Loop Body
 * }
 * \endcode
 *
 * This supports arbitrary for loop ranges (unlike compute_oh_bounds, for example).
 */
inline ALWAYS_INLINE void hoist_ApiB(
        int& ilo, int& ihi,                     // sub-for-loop outputs
        const int ibeg, const int iend,         // orig for(i=ibeg;i<end;i+=...)
        const int a,    const int b,            // linear fn o=a+ib
        const int obeg, const int oend)         // linear fn range [obeg,oend)
{
    // div_floor approach for int args, not the unsigned generalization
    //assert( b > 0 );
    ilo = div_floor( obeg +b-1-a, b );
    ihi = div_floor( oend +b-1-a, b );
    //if( ilo < ibeg ) ilo = ibeg;
    ilo = (ilo < ibeg? ibeg: ilo);
    //else if( ilo > iend ) ilo = iend; // intentionally NOT enforced
    //if( ihi > iend ) ihi = iend;
    ihi = (ihi > iend? iend: ihi);
    //else if( ihi < ibeg ) ihi = ibeg; // intentionally NOT enforced
}

}//anon::
} // namespace cpu
} // namespace impl
} // namespace dnnl
/** \page ConditionalHoisting  Hoisting Linear Tests out of Loops
 * VE compiler often has difficulty when vectorizing loops with vector
 * stores gaurded by conditionals.  Antagonistic cases may store data
 * past array bounds, cause segfaults.   The VE VST (vector store) is
 * not maskable.
 *
 * Both SX mainframe (sxc++) and SX Aurora (nc++) vectorizations benefit
 * from such code modifications.
 *
 * Here we show a frequent case and one way to rewrite the code to remove
 * inner loop conditionals.
 *
 * Original:
 * \code
 * for(i=imin; i<imax; ++i){       // original loop
 *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
 *   if( ApiB < c || ApiB >= d ) continue;
 *   // Loop Body
 * }
 * \endcode
 *
 * Transformed:
 * \code
 * int const ibeg, iend;
 * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
 * for(i=ibeg; i<iend; ++i){       // original loop
 *   int const ApiB = a + i*b;
 *   // GONE: if( ApiB < c || ApiB >= d ) continue;
 *   // Loop Body
 * }
 * \endcode
 *
 * For \c kh, for example, we replaced and simplified the \em hoist routine
 * in steps:
 *
 * \ref ref_conv2.cpp
 * \code
 *  for (int kh = 0; kh < p->kh; ++kh) {
 *      const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 *      if (ih < 0 || ih >= p->ih) continue;
 *      // etc
 * \endcode
 * With hoisting, \ref refconv3_fwd
 * \code   
 * int kh_beg, kh_end;
 * hoist_ApiB_in( kh_beg, kh_end,
 *                0, p->kh                          // i  in  [0, p->kh)
 *               (oh * p->sh - p->ph), (p->dh + 1), // ih=A+iB
 *               0, p->ih);                         // ih in [0, p->ih)
 * //if (kh_beg >= kh_end) continue;
 * for (int kh = kh_beg; kh < kh_end; ++kh) {
 *     const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 *     // etc
 * \endcode
 * which simplifies to
 * \code
 * //                  +--- ih must lie in [0,IH)
 * //                  |
 * //                  V  [_______ -a+b-1 _______]  [__ b __]
 * kh_beg = div_floor( 0  - (oh * SH - PH) + p->dh, (p->dh+1) );
 * kh_end = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 * if( kh_beg < 0     ) kh_beg = 0;
 * if( kh_end > p->kh ) kh_end = p->kh;
 * // correct kh_beg, kh_end at other limits irrelevant:
 * //    if (kh_beg >= kh_end) continue;
 * for (int kh = kh_beg; kh < kh_end; ++kh) {
 *     const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 *     // etc, with ih guaranteed not to exceed bounds
 * \endcode
 *
 * A key feature for the mathematics of such formulas is that integer
 * rounding \b must be toward negative infinity.  Unfortunately, C99
 * and C++11 round toward zero.  So div_floor, which has been optimized
 * for x86, may have conditionals that don't behave so well for other
 * chips.
 *
 * \c div_floor(i,j) rounds integer division \c i/j toward negative infinity
 * for any \c j>0.  It was developed to produce decent x86 code.
 * \sa idiv.hpp
 *
 * We now derive a way to do all calculations with positive integers,
 * avoiding negatives.  Such a calculation is now correct when evaluated
 * with unsigned integers, and also allows normal division to be used.
 *
 * - First, solve for \c kh, assuming div_floor rounding.
 *   - ih = oh * p->sh - p->ph + kh * (p->dh + 1)
 *   - \f$ih = oh*SH - PH + kh*DH\f$
 *   - \f$kh*DH = ih + PH - oh*SH\f$
 *   - \f$kh = div\_floor( ih+PH-oh*SH+DH-1, DH )\f$, which we'll loosely call
 *   - \f$kh(ih,oh) \approx (ih+DH-1+PH-oh*SH) / DH\f$
 *                  (equality for +ve numerator & denominator)
 *
 * - \f$kh_{beg}\f$, the lowest \c kh value, is associated with the lowest
 *   possible \c oh.
 *   - We avoid testing for values of zero, since division values of zero can
 *     result by rounding negative integers upward
 * - Consider \f$kh(ih,oh) >= L\f$, C=0, L=1:
 *   - \f$ (C + DH-1+PH-oh*SH) / DH >= L\f$  (for +ve numerator & denominator)
 *   - \f$ C + DH-1+PH-oh*SH >= L*DH\f$
 *   - \f$ C+PH-1 - oh*SH >= 0\f$
 *   - \f$ oh*SH <= C+PH-1 \f$
 *   - \f$ oh*SH < C+PH \f$
 * - Therefore if \f$oh*SH < C+PH\f$, (C=0) we use the formula
 *   \f$kh_{beg}=(C+DH-1+[PH-oh*SH]) / DH\f$.
 *   - (and cap it at KH)
 *   - Notice that both numerator and denominator are both strictly positive.
 *   - So this formula is correct for signed/unsigned integers.
 * - Otherwise, \f$kh_{beg} = 0\f$, the lowest possible value.
 * - We don't need to set \f$kh_{beg} > KH\f$, because only the
 *   \f$kh_{beg} < kh_{end}\f$ affects the rewritten \c for loop.
 *
 *
 * - Now Consider \f$kh_{end} >= KH\f$, where KH is the highest valid value for \f$kh_{end}\f$
 *   - The largest \f$kh\f$ occurs when \c ih has it's largest possible value, \c IH.
 * - Let's first check for \f$kh(IH,oh) >= KH\f$
 *   - \f$ (IH + DH-1 + PH - oh*SH) / DH >= KH \f$
 *   - \f$ IH + DH - 1 + PH - oh*SH  >= KH*DH \f$
 *   - \f$ KH*DH + oh*SH + 1 <= IH+PH+DH \f$, now RHS and LHS are strictly positive
 *   - \f$ KH*DH + oh*SH < IH+PH+DH \f$
 *      - NEW: actually largest possible input value is \f$i_{beg}\f$ plus a multiple of DH
 *        1. after capping \f$k_{beg}\f$ between [0,KH], calculate
 *           \f$i_{beg} = oh*SH - PH + k_{beg} * DH\f$
 *        2. max i possible is \f$i_{max} = i_{beg} + (IH-i_{beg})/DH*DH\f$
 *        3. use \f$i_{max}\f$ in place of IH ...
 *           so when KH*DH + oh*SH < i_{max} + PH + DH,
 *           then \f$kh_{end} = KH\f$
 *   - When the above condition holds, we can set \f$kh_{end} = KH\f$ (maximal value)
 * - Otherwise we can also check for \f$kh(ih,oh) >= 1\f$, so that we can safely use
 *   division with positive integers.
 *   - Replacing 'KH' with '1' in above...  \f$ 1*DH + oh*SH < i_{max}+PH+DH \f$
 *   - So when \f$oh*SH < i_{max}+PH\f$, \f$kh_{end} =  (DH-1 + [i_{max}+PH - oh*SH]) / DH \f$
 *     will be \f$ > 0\f$.
 *     - Otherwise we can set \f$kh_{end} = 0\f$
 *
 * So the \em long-hand +ve integer solutions for \c kh_beg and \c kh_end are:
 *
 * \code
 * if( oh*SH < PH )
 *   kh_beg = (p->dh + (PH - oh * SH)) / DH;
 * else
 *   kh_beg = 0;
 * \endcode
 * and a slightly longer version for \f$kh_{end}\f$ :
 * \code
 * if (oh*SH + KH*DH < IH + PH + DH)
 *   kh_end = KH;
 * else if (oh*SH >= IH+PH)
 *   kh_end = 0;
 * else
 *   kh_end = ([IH+PH - oh*SH] + DH-1) / DH;
 * \endcode
 *
 * \note well, sometimes it's more useful to iterate over kh, and instead determine
 *       [oh_beg,oh_end) for a possibly longer inner loop!
 *
 * This approach might be a tiny bit faster than the signed-integer \e idiv method.
 *
 * \ref sxconv_4_fwd shows how this can be done, and results in big speedups for sxc++,
 * whose compiler can vectorize the few remaining simple conditionals quite well (apparently).
 *
 * Other SX optimizations include using unit-stride temporaries, since complex expressions
 * with multiple strided vectors are sometimes not vectorized very well.
 */

// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
#endif //HOIST_HPP
