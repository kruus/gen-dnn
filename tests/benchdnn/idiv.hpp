/** \file
 * Fast integer division, rounding toward -ve infinity.
 * If it compiles, the functions are correct (static assertions).
 * Remainder-based tests were branchless AND no cmov (and short).
 * Older sign-based fixups are in dev/idiv_dev.hpp
 */
#ifndef IDIV_HPP
#define IDIV_HPP

//#include <limits> // some bit-twiddle hacks want # bits in int

// fwd decl

/** Truncate integer \c n / \c d \f$\forall n, d>0\f$ toward \f$-\infty\f$,
 * unchecked.  These are fast, inlinable constexpr 1-line functions.
 * Use prior knowledge of signed-ness to choose the correct [fastest!]
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
/** Euclidean remainder for \c d> 0 returns \b\c r in [0,k)
 * st \c n \c =d*k+r for some int \c k. [\c k is div_floor(n,d)]. */
constexpr int rem_floor( int const n, int const d );

/** Truncate integer \c n / \c d \f$\forall n, d<0\f$ toward \f$-\infty\f$,
 * unchecked. About 8 branchless instrns on Intel w/ cmov. */
constexpr int div_floorn( int const n, int const d );
/** For \c d<0, returns \c r in (d,0] st \c n \c =d*k+r. This is so
 * \f$n=d*\textrm{div_{floor*}}(n,d) + \textrm{rem_{floor*}}\f$ holds. */
inline constexpr int rem_floorn( int const n, int const d );

/** Truncate integer \c n / \c d (any signs) \f$\forall n, d!=0\f$
 * toward \f$-\infty\f$. About 15 branchless instrns on Intel w/ cmov. */
constexpr int div_floorx( int const n, int const d );

/** return d>0? rem_floor(n,d): rem_floorn(n,d). Returned remainder
 * is always in open range including zero until \c d, for +ve or -ve \c d. */
inline constexpr int rem_floorx( int const n, int const d );

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

/** For \c b!=0, return nonzero if \c a!=0 and \c sign(a)!=sign(b).
 * \pre b!=0 (unchecked)
 * /note this is not a general-purpose "non-zero and different-signs"
 * test.
 *
 * If b==0, return result is <em>don't care</em>.  This is why
 * it has a strange name.  Machine code is pretty simple for Intel:
 * \code 
 * 0000000000000000 <test_nzdiffsign_bnz(int, int)>:
0:	31 fe                	xor    %edi,%esi
2:	c1 fe 1f             	sar    $0x1f,%esi
5:	89 f0                	mov    %esi,%eax
7:	21 f8                	and    %edi,%eax
9:	c3                   	retq   
 * \endcode
 */
static inline constexpr int nzdiffsign_bnz( int const a, int const b )
{
#if (-1 >> 1 == -1)
    //return a!=0 && b!=0 && (a^b)<0; // ok, but long
    //return ( ((a^b)>>31) & (a!=0) );
    /* 
0:	31 fe                	xor    %edi,%esi
2:	31 c0                	xor    %eax,%eax
4:	c1 fe 1f             	sar    $0x1f,%esi
7:	85 ff                	test   %edi,%edi
9:	0f 95 c0             	setne  %al
c:	21 f0                	and    %esi,%eax
e:	c3                   	retq   
     */
    //return ( ((a^b)<0) & (a!=0) );
    return ( ((a^b)>>31) & a );
#else
#error "bit-twiddling hacks insufficient"
#endif
}
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
#if 1
    return (n/d) - (n%d<0? 1: 0);
    /* 0000000000000000 <test_div_floor(int, int)>:
0:	89 f8                	mov    %edi,%eax
2:	99                   	cltd   
3:	f7 fe                	idiv   %esi
5:	c1 ea 1f             	shr    $0x1f,%edx
8:	29 d0                	sub    %edx,%eax
a:	c3                   	retq   
     */
#else
    return (n + ((n>=0)? 0: 1-d)) / d; // 2-insn branch
    // bit-twiddling of "add-to-n" fixups ...
    //return (n-rem_floor(n,d)) / d; // not so nice
    //return (n + (n<0) - (d & (n<0? ~0: 0))) / d; // longer
    //return (n + ((n<0? ~0: 0) & (1-d))) / d; // longer
#endif
}
/**
 * best impls are from
 * [stackoverflow](https://stackoverflow.com/questions/1135388/fast-euclidean-division-in-c)
 *
 * Consider
 * \code
 * return n%d + (n%d<0? d: 0); // instructive
 *              ^^^^^^^^^^^^^
 * \endcode
 * - to get rid of cmov in final generic version,
 *   mask 'd' with sign bit, using a bit-twiddle hack:
 *   - propagate sign bit everywhere and <em>logical and</em>
 *
 */
inline constexpr int rem_floor( int const n, int const d )
{
#if 1 // I think this one is totally portable, and code is identical to next
    return (n%d + (d & (n%d<0? ~0: 0) ));
#elif ~(-1) == 0 /* best code, without numeric_limits */
    // only assumes 2-s complement
    //return (n%d +   (d & (-(n%d<0)        ) ));
    //return (n%d + (d & (n%d<0? 0xFFffFFff: 0) )); // test!
    /* 0000000000000010 <test_rem_floor(int, int)>:
10:	89 f8                	mov    %edi,%eax
12:	99                   	cltd   
13:	f7 fe                	idiv   %esi
15:	89 d0                	mov    %edx,%eax
17:	c1 f8 1f             	sar    $0x1f,%eax
1a:	21 c6                	and    %eax,%esi
1c:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
1f:	c3                   	retq   
     */
#elif -1 >> 1 == -1 /* have signed arithmetic shift? */
    // same code as above
    return n%d + ((n%d>>(std::numeric_limits<int>::digits)) & d);
    // (also OK with    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ bits-1)
#elif 1 /* instructive, fall-back only */
    return n%d + ((n%d<0? d: 0)); // generates a cmov
    /* 0000000000000010 <test_rem_floor(int, int)>:
10:	89 f8                	mov    %edi,%eax
12:	99                   	cltd   
13:	f7 fe                	idiv   %esi
15:	b8 00 00 00 00       	mov    $0x0,%eax
1a:	85 d2                	test   %edx,%edx
1c:	0f 49 f0             	cmovns %eax,%esi    <----
1f:	8d 04 32             	lea    (%rdx,%rsi,1),%eax
22:	c3                   	retq   
     */
#elif 0 /* BAD, demo only! */
    return n - d*div_floor(n,d); // has Multiply
#endif
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
// too big for int: FAIL...
//     static_assert( div_floor(3111888111,1) == 3111888111, "oops");
static_assert( div_floor(2000444000,1) == 2000444000, "oops");
static_assert( div_floor(-2000444000,1) == -2000444000, "oops");
#define DIVREM(n,d) \
static_assert( rem_floor(n,d) >=0 && rem_floor(n,d) < d, "Oops " #n " " #d); \
static_assert( n == d*div_floor(n,d) + rem_floor(n,d),   "Oops " #n " " #d )
DIVREM( 5,3); // 2
DIVREM( 4,3); // 1
DIVREM( 3,3); // 0
DIVREM( 2,3); // 2
DIVREM( 1,3); // 1
DIVREM( 0,3); // 0
DIVREM(-1,3); // 2
DIVREM(-2,3); // 1
DIVREM(-3,3); // 0
DIVREM(-4,3); // 2
DIVREM(-5,3); // 1
DIVREM( 2000444000,1);
DIVREM(-2000444000,1);

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
/** \ret r in (d,0] st n=d*k+r for some integer k
 * \pre d<0 (unchecked) */
inline constexpr int rem_floorn( int const n, int const d )
{
    //return n - d*div_floorn(n,d);
    //return n%d + (n%d > 0? d: 0);  // correct
    return n%d + (n%d <= 0? 0: d); // same
    /* 0000000000000030 <test_rem_floorn(int, int)>:
30:	89 f8                	mov    %edi,%eax
32:	99                   	cltd   
33:	f7 fe                	idiv   %esi
35:	b8 00 00 00 00       	mov    $0x0,%eax
3a:	85 d2                	test   %edx,%edx
3c:	0f 4e f0             	cmovle %eax,%esi                <-- cmov
3f:	8d 04 32             	lea    (%rdx,%rsi,1),%eax
42:	c3                   	retq   
     */
    //return n%d + (d & (-(n%d>0)    )); //no cmov but long
    //return n%d +   (d & (n%d>0? ~0: 0)); // trick
    /* 0000000000000030 <test_rem_floorn(int, int)>:
30:	89 f8                	mov    %edi,%eax
32:	99                   	cltd   
33:	f7 fe                	idiv   %esi
35:	31 c0                	xor    %eax,%eax
37:	85 d2                	test   %edx,%edx
39:	0f 9f c0             	setg   %al
3c:	f7 d8                	neg    %eax
3e:	21 c6                	and    %eax,%esi
40:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
43:	c3                   	retq   
     */
    //return n%d +   (d & (n<0? 0:   n%d==0? 0: ~(n%d==0)));
    /* 0000000000000030 <test_rem_floorn(int, int)>:
30:	89 f8                	mov    %edi,%eax
32:	f7 d7                	not    %edi
34:	99                   	cltd   
35:	f7 fe                	idiv   %esi
37:	85 d2                	test   %edx,%edx
39:	0f 95 c1             	setne  %cl
3c:	c1 ef 1f             	shr    $0x1f,%edi
3f:	21 cf                	and    %ecx,%edi
41:	f7 df                	neg    %edi
43:	21 fe                	and    %edi,%esi
45:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
48:	c3                   	retq   
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
#define DIVREMn(n,d) \
static_assert( rem_floorn(n,d) <= 0 && rem_floorn(n,d) > d,  "Oops " #n " " #d ); \
static_assert( n == d*div_floorn(n,d) + rem_floorn(n,d),   "Oops " #n " " #d )
DIVREMn( 5,-3); // div_floor(5,-3)=-2, 5-(-3)*(-2) = -1
DIVREMn( 4,-3); // 4-(-3)*(-2) = -2
DIVREMn( 3,-3); // 3-(-3)*(-1) = 0
DIVREMn( 2,-3); // 2-(-3)*(-1) = -1
DIVREMn( 1,-3); // 1-(-3)*(-1) = -2
DIVREMn( 0,-3); // 0-(-3)*( 0) = 0
DIVREMn(-1,-3); // 1-(-3)*( 0) = -1
DIVREMn(-2,-3); // 2-(-3)*( 0) = -2
DIVREMn(-3,-3); // 3-(-3)*(-1) = 0
DIVREMn(-4,-3);
DIVREMn(-5,-3);
DIVREMn( 2000444000,-1);
DIVREMn(-2000444000,-1);

/** Truncate integer \c n / \c d (any signs) \f$\forall n, d!=0\f$
 * toward \f$-\infty\f$.
 * \pre d != 0 (unchecked)
 */
inline constexpr int div_floorx( int const n, int const d )
{
    //return n/d - (n%d<0 == d>0? !(n%d==0) : 0); // branchless and no cmov
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
    //return n/d - (nzdiffsign_bnz(n%d,d/*!=0*/)? !(n%d==0) : 0);
    /* 0000000000000060 <test_div_floorx(int, int)>:
60:	89 f8                	mov    %edi,%eax
62:	99                   	cltd   
63:	f7 fe                	idiv   %esi
65:	31 d6                	xor    %edx,%esi
67:	c1 fe 1f             	sar    $0x1f,%esi
6a:	85 d6                	test   %edx,%esi
6c:	0f 95 c2             	setne  %dl
6f:	0f b6 d2             	movzbl %dl,%edx
72:	29 d0                	sub    %edx,%eax
74:	c3                   	retq   
     */
    return n/d - (nzdiffsign_bnz(n%d,d/*!=0*/)? 1 : 0); //same
}
#define TEST_nzdiffsign_bnz(a,b) /* a,b > 0 */ \
static_assert( !nzdiffsign_bnz(a,b), "oops sign" " +" #a " +" #b); \
static_assert( !nzdiffsign_bnz(-a,-b), "oops sign" " -" #a " -" #b); \
static_assert(  nzdiffsign_bnz(a,-b), "oops sign" " +" #a " -" #b); \
static_assert(  nzdiffsign_bnz(-a,b), "oops sign" " -" #a " +" #b);
TEST_nzdiffsign_bnz(1,1);
TEST_nzdiffsign_bnz(2000111000,1);
TEST_nzdiffsign_bnz(1, 2000111000);
TEST_nzdiffsign_bnz(2000111000, 2000111000);
static_assert( !nzdiffsign_bnz(0,1), "oops");
static_assert( !nzdiffsign_bnz(0,-1), "oops");
static_assert( !nzdiffsign_bnz(0,2000111000), "oops");
static_assert( !nzdiffsign_bnz(0,-2000111000), "oops");
//static_assert( !nzdiffsign_bnz(0,0), "oops");
int test_nzdiffsign_bnz( int const a, int const b )
{
    return nzdiffsign_bnz(a,b);
}
/** \pre d!=0 (unchecked) */
inline constexpr int rem_floorx( int const n, int const d )
{
    //return n - d*div_floor(n,d); // correct, but not so good (has Multiply)
    //return d>0? rem_floor(n,d): rem_floorn(n,d);
    //return d<0? rem_floorn(n,d): rem_floor(n,d);
    //return n%d + (d & (d<0? (n%d>0? ~0: 0): (n%d<0? ~0: 0)));
    // same return n%d + (d & (d<0? (n%d>0? ~(1-(d<0)): 1-(d<0)): (n%d<0? ~(d<0): (d<0))));
    //return n%d + (d & ( ((d>>31)&&(n%d>0) || ((d>0)&&(n%d>>31)) ? ~0 : 0))); // longer
    // ?? return n%d + (d & ( ((d^(n%d)>>31)!=0) || ((d>0)&&(n%d>>31)) ? ~0 : 0));
    //
    // pretty good, no cmov ...
    //return n%d + (d & ( nzdiffsign_bnz(n%d,d/*!=0*/) ? ~0 : 0));
    /* 0000000000000090 <test_rem_floorx(int, int)>:
90:	89 f8                	mov    %edi,%eax
92:	99                   	cltd   
93:	f7 fe                	idiv   %esi
95:	89 f0                	mov    %esi,%eax
97:	31 d0                	xor    %edx,%eax
99:	c1 f8 1f             	sar    $0x1f,%eax
9c:	85 d0                	test   %edx,%eax
9e:	0f 95 c0             	setne  %al
a1:	0f b6 c0             	movzbl %al,%eax
a4:	f7 d8                	neg    %eax
a6:	21 c6                	and    %eax,%esi
a8:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
ab:	c3                   	retq   
     */
    return n%d + ( nzdiffsign_bnz(n%d, d/*!=0*/)? d: 0);
    /* shorter, but with cmov 0000000000000090 <test_rem_floorx(int, int)>:
90:	89 f8                	mov    %edi,%eax
92:	89 f1                	mov    %esi,%ecx
94:	99                   	cltd   
95:	f7 fe                	idiv   %esi
97:	31 d1                	xor    %edx,%ecx
99:	c1 f9 1f             	sar    $0x1f,%ecx
9c:	21 d1                	and    %edx,%ecx
9e:	0f 45 ce             	cmovne %esi,%ecx
a1:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
a4:	c3                   	retq   
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
#define DIVREMx(n,d) /*DIVREM(n,d); DIVREMn(n,d); */ \
static_assert( rem_floorx(n,d) >=0 && rem_floorx(n,d) < d, "Oops " #n " " #d); \
static_assert( n == d*div_floorx(n,d) + rem_floorx(n,d),   "Oops " #n " " #d ); \
static_assert( rem_floorx(n,-d) <= 0 && rem_floorx(n,-d) > -d,  "Oops " #n " -" #d ); \
static_assert( n == (-d)*div_floorx(n,-d) + rem_floorx(n,-d),   "Oops " #n " -" #d )
DIVREMx( 5,3);
DIVREMx( 4,3);
DIVREMx( 3,3);
DIVREMx( 2,3);
DIVREMx( 1,3);
DIVREMx( 0,3);
DIVREMx(-1,3);
DIVREMx(-2,3);
DIVREMx(-3,3);
DIVREMx(-4,3);
DIVREMx(-5,3);
DIVREMx( 2000444000,1);
DIVREMx(-2000444000,1);
// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
#endif //IDIV_HPP
