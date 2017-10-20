/** \file
 * Fast integer division, rounding toward -ve infinity.
 * If it compiles, the functions are correct (static assertions).
 * Remainder-based tests were branchless AND no cmov (and short).
 * Older sign-based fixups are in dev/idiv_dev.hpp
 */
#ifndef IDIV_HPP
#define IDIV_HPP

// fwd decl

/** Truncate integer \c n / \c d \f$\forall n, d>0\f$ toward \f$-\infty\f$,
 * unchecked.  Use prior knowledge of signed-ness to choose the correct
 * function call.
 *
 * Intel+gcc
 * | Routine   | \~instrns | \~bytes (hex) | trunc \f$\rightarrow -infty\f$
 * | :------------ | :-------- | :------------ | :-------------------------
 * | n/d in C++11 or C99 | 1   | ??            | n>0, d>0
 * | **div_floor** | 5         | 0a            | any n, d>0
 * | div_floorn    | 7         | 1f            | any n, d<0
 * | div_floorx    | 15        | 40            | any n, any d!=0
 */
constexpr int div_floor( int const n, int const d );

/** Truncate integer \c n / \c d \f$\forall n, d<0\f$ toward \f$-\infty\f$,
 * unchecked. About 8 branchless instrns on Intel w/ cmov. */

constexpr int div_floorn( int const n, int const d );

/** Truncate integer \c n / \c d (any signs) \f$\forall n, d!=0\f$
 * toward \f$-\infty\f$. About 15 branchless instrns on Intel w/ cmov. */

inline constexpr int div_floorx( int const n, int const d );

// normal C99 and C++11 integer division works like this:
static_assert(  5/3 == 1, "oops"); // mod:2
static_assert(  4/3 == 1, "oops"); // mod:1
static_assert(  3/3 == 1, "oops"); // mod:0
static_assert(  2/3 == 0, "oops"); // mod:2
static_assert(  1/3 == 0, "oops"); // mod:1
static_assert(  0/3 == 0, "oops"); // mod:0
static_assert( -1/3 == 0, "oops"); // want "-1", mod:-1 
static_assert( -2/3 == 0, "oops"); // want "-1", mod:-2
static_assert( -3/3 ==-1, "oops"); // want "-1", mod:0  OK
static_assert( -4/3 ==-1, "oops"); // want "-2", mod:-1

static_assert(  5/-3 ==-1, "oops"); // mod:2  want: -2
static_assert(  4/-3 ==-1, "oops"); // mod:1  want: -2
static_assert(  3/-3 ==-1, "oops"); // mod:0  want: -1 (OK)
static_assert(  2/-3 == 0, "oops"); // mod:2  want: -1
static_assert(  1/-3 == 0, "oops"); // mod:1  want: -1
static_assert(  0/-3 == 0, "oops"); // mod:0  want: 0
static_assert( -1/-3 == 0, "oops"); // mod:-1 want: 0 (OK)
static_assert( -2/-3 == 0, "oops"); // mod:-2 want: 0 (OK)
static_assert( -3/-3 == 1, "oops"); // mod:0  want: 1 (OK)
static_assert( -4/-3 == 1, "oops"); // mod:-1 want: 1 (OK)
// and modulus... (for C++11 / C99 at least)
static_assert(  5%3 == 2, "oops");
static_assert(  4%3 == 1, "oops");
static_assert(  3%3 == 0, "oops");
static_assert(  2%3 == 2, "oops");
static_assert(  1%3 == 1, "oops");
static_assert(  0%3 == 0, "oops");
static_assert( -1%3 ==-1, "oops"); // -1/3*3 + X = -1 --> X = -1 - (0)
static_assert( -2%3 ==-2, "oops");
static_assert( -3%3 == 0, "oops");
static_assert(  5%-3 == 2, "oops");
static_assert(  4%-3 == 1, "oops");
static_assert(  3%-3 == 0, "oops");
static_assert(  2%-3 == 2, "oops");
static_assert(  1%-3 == 1, "oops");
static_assert(  0%-3 == 0, "oops");
static_assert( -1%-3 ==-1, "oops");
static_assert( -2%-3 ==-2, "oops");
static_assert( -3%-3 == 0, "oops");
static_assert( -4%-3 ==-1, "oops");
/** Truncate integer \c n / \c d \f$\forall n, d>0\f$ toward \f$-\infty\f$.
 * In C99 and C++11 integer division always truncates -ves toward 0.
 * so:
 *         5/3=1,     4/3=1,   3/3=1
 *         2/3=0,     1/3=0,   0/3=0
 * , but **-1/3=0**, -2/3=0,  -3/3=-1
 *
 * When dealing with integer inequalities, we often need to
 * always truncate the division downward,
 * towards \f$-\infty\f$.  This happens when we deal with
 * integer.
 * \pre d > 0 (unchecked)
 * \note This fast case often applies to strided "forward"
 *       index calculations.  Any-valued strides should use
 *       \c div_floorx. Negative strides can use \c div_floorn.
 */
inline constexpr int div_floor( int const n, int const d )
{
    return (n/d) - (n%d<0? 1: 0);
    /* 0000000000000000 <test_div_floor(int, int)>:
0:	89 f8                	mov    %edi,%eax
2:	99                   	cltd   
3:	f7 fe                	idiv   %esi
5:	c1 ea 1f             	shr    $0x1f,%edx
8:	29 d0                	sub    %edx,%eax
a:	c3                   	retq   
     */
}
static_assert( div_floor( 5,3) ==  1, "oops");
static_assert( div_floor( 4,3) ==  1, "oops");
static_assert( div_floor( 3,3) ==  1, "oops");
static_assert( div_floor( 2,3) ==  0, "oops");
static_assert( div_floor( 1,3) ==  0, "oops");
static_assert( div_floor( 0,3) ==  0, "oops");
static_assert( div_floor(-1,3) == -1, "oops");
static_assert( div_floor(-2,3) == -1, "oops");
static_assert( div_floor(-3,3) == -1, "oops");
static_assert( div_floor(-4,3) == -2, "oops");
static_assert( div_floor(-5,3) == -2, "oops");

/** Truncate integer \c n / \c d \f$\forall n, d<0\f$
 * toward \f$-\infty\f$.
 * \pre d != 0 (unchecked)
 */
inline constexpr int div_floorn( int const n, int const d )
{
    return (n/d) - (n%d>0? 1: 0); 
    /* 0000000000000010 <test_div_floorn(int, int)>:
10:	89 f8                	mov    %edi,%eax
12:	99                   	cltd   
13:	f7 fe                	idiv   %esi
15:	85 d2                	test   %edx,%edx
17:	0f 9f c2             	setg   %dl
1a:	0f b6 d2             	movzbl %dl,%edx
1d:	29 d0                	sub    %edx,%eax
1f:	c3                   	retq   
     */
}
static_assert( div_floorn(-6,-3) ==  2, "oops");
static_assert( div_floorn(-5,-3) ==  1, "oops");
static_assert( div_floorn(-4,-3) ==  1, "oops");
static_assert( div_floorn(-3,-3) ==  1, "oops");
static_assert( div_floorn(-2,-3) ==  0, "oops");
static_assert( div_floorn(-1,-3) ==  0, "oops");
static_assert( div_floorn( 0,-3) ==  0, "oops");
static_assert( div_floorn( 1,-3) == -1, "oops");
static_assert( div_floorn( 2,-3) == -1, "oops");
static_assert( div_floorn( 3,-3) == -1, "oops");
static_assert( div_floorn( 4,-3) == -2, "oops");
static_assert( div_floorn( 5,-3) == -2, "oops");
static_assert( div_floorn( 6,-3) == -2, "oops");
static_assert( div_floorn( 7,-3) == -3, "oops");

/** Truncate integer \c n / \c d (any signs) \f$\forall n, d!=0\f$
 * toward \f$-\infty\f$.
 * \pre d != 0 (unchecked)
 */
inline constexpr int div_floorx( int const n, int const d )
{
    return n/d - (n%d<0 == d>0? !(n%d==0) : 0); // branchless and no cmov
    /* 0000000000000020 <test_div_floorx(int, int)>:
20:	89 f8                	mov    %edi,%eax
22:	99                   	cltd   
23:	f7 fe                	idiv   %esi
25:	89 d1                	mov    %edx,%ecx
27:	f7 d1                	not    %ecx
29:	c1 e9 1f             	shr    $0x1f,%ecx
2c:	85 f6                	test   %esi,%esi
2e:	40 0f 9f c6          	setg   %sil
32:	31 f1                	xor    %esi,%ecx
34:	85 d2                	test   %edx,%edx
36:	0f 95 c2             	setne  %dl
39:	0f b6 d2             	movzbl %dl,%edx
3c:	21 d1                	and    %edx,%ecx
3e:	29 c8                	sub    %ecx,%eax
40:	c3                   	retq   
     */
}
static_assert( div_floorx( 5,3) ==  1, "oops");
static_assert( div_floorx( 4,3) ==  1, "oops");
static_assert( div_floorx( 3,3) ==  1, "oops");
static_assert( div_floorx( 2,3) ==  0, "oops");
static_assert( div_floorx( 1,3) ==  0, "oops");
static_assert( div_floorx( 0,3) ==  0, "oops");
static_assert( div_floorx(-1,3) == -1, "oops");
static_assert( div_floorx(-2,3) == -1, "oops");
static_assert( div_floorx(-3,3) == -1, "oops");
static_assert( div_floorx(-4,3) == -2, "oops");
static_assert( div_floorx(-5,3) == -2, "oops");

static_assert( div_floorn( 7,-3) == -3, "oops");
static_assert( div_floorn( 6,-3) == -2, "oops");
static_assert( div_floorx( 5,-3) == -2, "oops");
static_assert( div_floorx( 4,-3) == -2, "oops");
static_assert( div_floorx( 3,-3) == -1, "oops");
static_assert( div_floorx( 2,-3) == -1, "oops");
static_assert( div_floorx( 1,-3) == -1, "oops");
static_assert( div_floorx( 0,-3) ==  0, "oops");
static_assert( div_floorx(-1,-3) ==  0, "oops");
static_assert( div_floorx(-2,-3) ==  0, "oops");
static_assert( div_floorx(-3,-3) ==  1, "oops");
static_assert( div_floorx(-4,-3) ==  1, "oops");
static_assert( div_floorx(-5,-3) ==  1, "oops");
static_assert( div_floorx(-6,-3) ==  2, "oops");

// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
#endif //IDIV_HPP
