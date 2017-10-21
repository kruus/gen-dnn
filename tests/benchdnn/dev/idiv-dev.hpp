/** \file
 * Fast integer division, rounding toward -ve infinity.
 * If it compiles, the functions are correct (static assertions).
 */
#ifndef IDIV_HPP
#define IDIV_HPP

// fwd decl

/** Truncate integer \c n / \c d \f$\forall n, d>0\f$ toward \f$-\infty\f$,
 * unchecked. About 8 branchless instrns on Intel w/ cmov. */

constexpr int div_floor( int const n, int const d );

/** Truncate integer \c n / \c d \f$\forall n, d<0\f$ toward \f$-\infty\f$,
 * unchecked. About 8 branchless instrns on Intel w/ cmov. */

constexpr int div_floorn( int const n, int const d );

/** Truncate integer \c n / \c d (any signs) \f$\forall n, d!=0\f$
 * toward \f$-\infty\f$. About 15 branchless instrns on Intel w/ cmov. */

inline constexpr int div_floorx( int const n, int const d );

/** I suggest 2 versions, branchless and 1-branch, you will have
 * to time to see which one is fastest.  A branching impl may work
 * better because inner loop limits vary smoothly and should be
 * pretty predictable -- they only take an alternate branch when
 * \em something changes sign!
 */
#define IDIV_BRANCHLESS 0

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
// and modulus...
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
#if 1 // remainder-based
    //return (n>=0? n/d: n/d - (n%d!=0));       // branch, 2 rets
    //return (n>=0? n/d: n/d - (n%d<0?1:0));    // branch, 2 ret, a bit better
    //return (n>=0? n/d: n/d - (n%d<0));          // equiv
    //return (n/d) + (n>=0? 0: - (n%d<0));
    return (n/d) - (n%d<0? 1: 0);               // WOW (uses "free" rem part of idiv)
    /* 0000000000000000 <test_div_floor(int, int)>:
0:	89 f8                	mov    %edi,%eax
2:	99                   	cltd   
3:	f7 fe                	idiv   %esi
5:	c1 ea 1f             	shr    $0x1f,%edx
8:	29 d0                	sub    %edx,%eax
a:	c3                   	retq   
     */
#elif 0
#if ! IDIV_BRANCHLESS
    // Method: -1-->3? -2-->4? -3-->5?
    //   -1/3 --> (3-(-1)-1)=3 --> -(3/3)=-1
    //   -2/3 --> (3-(-2)-1)=4 --> -(4/3)=-1
    //   -3/3 --> (3-(-3)-1)=5 --> -(5/3)=-1
    //   -4/3 --> (3-(-4)-1)=6 --> -(5/3)=-2
    //return (n<0? -((d-n-1)/d): n/d);

    // Alt Method:
    //  -1/3 --> -3/3, -2/3 --> -4/3, etc.
    //return (n<0? (n-d+1)/d: n/d);         // good demo of procedure
    //
    //return (n>=0? n: (n-d+1)) / d;
    //
    // branchless, but w/ mutiply
    //return (n + (n<0) * (1-d)) / d;
    //return (n + (n<0) * (-d+(n<0))) / d;
    //return (n + (n<0) * (-d) + (n<0)) / d;
    //return (n + (n<0) - (n<0) * (d)) / d;
    //
    // now back to a (shorter) branch
    return (n + ((n>=0)? 0: 1-d)) / d;
    //   xorl	%eax, %eax
    //   testl	%edi, %edi
    //   jns	.L2
    //   movl	$1, %eax
    //   subl	%esi, %eax
    // .L2: 
    //   addl	%edi, %eax
    //   cltd
    //   idivl	%esi
    //
#else // IDIV_BRANCHLESS
    // ... YAHOO ... this is branchless (via cmov op) and short
    return (n + (n<0) - (n<0? d: n<0)) / d;
    // movl	%edi, %edx
	// shrl	$31, %edx
	// testl	%edi, %edi
	// leal	(%rdi,%rdx), %eax
	// cmovs	%esi, %edx
	// subl	%edx, %eax
	// cltd
	// idivl	%esi
#endif // IDIV_BRANCHLESS
#else // try some bit twiddle approaches
    //return (n-rem_floor(n,d)) / d; // not so nice
    //return (n + (n<0) - (n<0? d: 0)) / d;
    //return (n + (n<0) - (d & (n<0? ~0: 0))) / d; // longer
    /* 0000000000000000 <test_div_floor(int, int)>:
0:	89 fa                	mov    %edi,%edx
2:	c1 ea 1f             	shr    $0x1f,%edx
5:	8d 04 17             	lea    (%rdi,%rdx,1),%eax
8:	f7 da                	neg    %edx
a:	21 f2                	and    %esi,%edx
c:	29 d0                	sub    %edx,%eax
e:	99                   	cltd   
f:	f7 fe                	idiv   %esi
11:	c3                   	retq   
     */
    //return (n + ((n<0)? 1-d: 0)) / d;
    //return (n + ((n<0? ~0: 0) & (1-d))) / d; // longer
    /* 0000000000000000 <test_div_floor(int, int)>:
0:	b8 01 00 00 00       	mov    $0x1,%eax
5:	89 fa                	mov    %edi,%edx
7:	c1 fa 1f             	sar    $0x1f,%edx
a:	29 f0                	sub    %esi,%eax
c:	21 d0                	and    %edx,%eax
e:	01 f8                	add    %edi,%eax
10:	99                   	cltd   
11:	f7 fe                	idiv   %esi
13:	c3                   	retq   
     */
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
/** Truncate integer \c n / \c d \f$\forall n, d<0\f$
 * toward \f$-\infty\f$.
 * \pre d != 0 (unchecked)
 */
inline constexpr int div_floorn( int const n, int const d )
{
#if 1 // remainder-based correction
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
#elif 0 // ! IDIV_BRANCHLESS
    // n>0 and d<0:
    // 1/-3:    use 3/-3 instead
    // basic versions:
    //   return (n<=0? n: n-d-1) / d;      // branch, 2 ret
    //   return (n<=0? -n: -n+d+1) / -d;      // cmov + negs
    //return (n<=0? n: n-d-1) / d;      // branch, 2 ret
    //return ((n>=0?1:0) - n + (n>=0? d: 0)) / -d; // ugly
    //return (n - ((1-n<=0)? (1-(n<=0))+d: (1-(n<=0)))) / d; // ouch
#elif 0 // IDIV_BRANCHLESS
    //return (n + (n<=0? 0: 0-d-1)) / d;  // already branchless!
    //return (n - (n<=0? 0: d+1)) / d;    // save a 'neg', 8 instrs, 0x34 bytes
    /* 0000000000000020 <test_div_floorn(int, int)>:
20:	8d 46 01             	lea    0x1(%rsi),%eax
23:	85 ff                	test   %edi,%edi
25:	ba 00 00 00 00       	mov    $0x0,%edx
2a:	0f 4e c2             	cmovle %edx,%eax
2d:	29 c7                	sub    %eax,%edi
2f:	89 f8                	mov    %edi,%eax
31:	99                   	cltd   
32:	f7 fe                	idiv   %esi
34:	c3                   	retq   
     */
    //return (n - (n>0? d+(n>0): (n>0))) / d;         // equiv
    //return (n - (n>0? d+1: 0)) / d;                 // equiv
    //
    //return ((n + (n<=0) - (n<=0? 0: d)) - 1) / d;
    //return (n - ( 1-(n<=0) + (n<=0? 0: d))) / d;
    //return (n + (n<=0) - 1 - ((n<=0? 0: d))) / d;     // 57-49
    //return (n - ((n<=0? 1-(n<=0): d+1-(n<=0)))) / d;    // 56-49
    //return (n - (n<=0? 0: d+1)) / d;    // 56-49
    //return (n - (n<0? 0: d+1)) / d;  // also correct (cmovs vs cmovle)
    //return (n - ((n<=0? 1-(n<=0): d+1))) / d;
    //return (n - ( 1 + (n<=0? -(n<=0): d))) / d;
    //return (n - 1 - (n<=0? -(n<=0): d)) / d;    // 7 instrns
    //return (n - 1 - (n<=0? -1: d)) / d;    // 0x32 byt, 7 ins
    /* 0000000000000020 <test_div_floorn(int, int)>:
20:	8d 47 ff             	lea    -0x1(%rdi),%eax
23:	85 ff                	test   %edi,%edi
25:	ba ff ff ff ff       	mov    $0xffffffff,%edx
2a:	0f 4f d6             	cmovg  %esi,%edx
2d:	29 d0                	sub    %edx,%eax
2f:	99                   	cltd   
30:	f7 fe                	idiv   %esi
32:	c3                   	retq   
     */
    //return (n - 1 - (n<=0? (n>0): d)) / d;
    //return (n - (n>0?1:0) - (n>0?d:0)) / d; // ouch 2 cmov
    //return (n - (n>0) - (n>0? d: 0)) / d; // ouch
    //return (n - (n>0) - (n>0? d: (n>0))) / d; // ouch
    //return (n - ((n>0) + (n>0? d: n>0))) / d; // ouch
    //return (- 1 - (n<=0? -1: d) + n) / d; // 0x33 byt, 8 ins
    //return (n - (n<=0? (1-(n<=0)): d+(1-(n<=0))) / d;
    //return (n - (n<=0? (1-(n<=0)): (1-(n<=0))+d)) / d;
    //return (n - ((1-n<=0)? (1-(n<=0))+d: (1-(n<=0)))) / d; // ouch
    //return (n - ((n>0?1:0)? (n>0?1:0)+d: (n>0?1:0))) / d; 
    //return (n - (n>0?1:0) - ((n>0)? d: 0)) / d; // 2 cmov
    //return (n - ((n>0)? (n>0)+d: (n>0))) / d; 
    // wrong return (n - ((n<0)? 1-(n<0): 1-(n>0)+d)) / d; 
    //return (n - (n<0? 0: (1-(n<0))+d)) / d;    // save a 'neg', 8 instrs
    //return (n - (n<0? (1-(n<0)): (1-(n<0))+d)) / d;    // save a 'neg', 8 instrs

    //
    // no change...
    //return (n - ((n>0)? d+(n>0): (n>0))) / d;
    //return (n - ((n>0) + (n>0? d: -(n>0)))) / d;
    //return (n - ( (n>0) + ((n>0)? d: 0))) / d;
    //return (n - (n>0) - ((n>0)? d: 0)) / d;
    //return (n - (n>0) - ((n>0)? d: (n>0))) / d;
    // xorl	%edx, %edx
	// testl	%edi, %edi
	// movl	%edi, %eax
	// setg	%dl
	// subl	%edx, %eax
	// testl	%edi, %edi
	// cmovg	%esi, %edx
	// subl	%edx, %eax
	// cltd
	// idivl	%esi
    //
    //return (n - (n>0? 1: 0) - (n>0? d: 0)) / d; // 2 cmov
    // leal	-1(%rdi), %eax
	// testl	%edi, %edi
	// movl	$0, %edx
	// cmovle	%edi, %eax
	// cmovg	%esi, %edx
	// subl	%edx, %eax
	// cltd
	// idivl	%esi
    //
    //return (n - (n>0? 1: n>0) - (n>0? d: n>0)) / d; // longer
    //
    // Try with -d as divisor ......................
    //return (n<0? -n: -n+d+1) / -d;            // 10 ins, branchless
    /* 0000000000000020 <test_div_floorn(int, int)>:
20:	89 f0                	mov    %esi,%eax
22:	89 fa                	mov    %edi,%edx
24:	29 f8                	sub    %edi,%eax
26:	f7 da                	neg    %edx
28:	83 c0 01             	add    $0x1,%eax
2b:	85 ff                	test   %edi,%edi
2d:	0f 48 c2             	cmovs  %edx,%eax
30:	f7 de                	neg    %esi
32:	99                   	cltd   
33:	f7 fe                	idiv   %esi
35:	c3                   	retq   
     */
    //return ((n<0? 0: d+1) - n) / -d;          // 9 instrns
    //return ((n>=0? d+1: 0) - n) / -d;         // 9 instrns
    //return ((n>=0) + (n>=0? d: (n>=0)) - n) / -d;     // 0x37 byt, 11 ins
    // *** return ((n<0? 0: d+1) - n) / -d;     // 8 instrns ***
    //return ((n<0? 0: d+1) - n) / -d;
    //return ((n>0? d+1: 0) - n) / -d;          // equiv
    //return ((n>=0? d+1: 0) - n) / -d;         // equiv
    //return ((n>0? d+(n>0): 0) - n) / -d;      // equiv
    //return ((n>=0? d+(n>=0): (n>=0)) - n) / -d;  // equiv
    //return ((n>=0? d: 0) + (n>=0?1:0) - n) / -d; // equiv
    /* 0000000000000020 <test_div_floorn(int, int)>:
20:	8d 46 01             	lea    0x1(%rsi),%eax
23:	85 ff                	test   %edi,%edi
25:	ba 00 00 00 00       	mov    $0x0,%edx
2a:	0f 48 c2             	cmovs  %edx,%eax
2d:	f7 de                	neg    %esi
2f:	29 f8                	sub    %edi,%eax
31:	99                   	cltd   
32:	f7 fe                	idiv   %esi
34:	c3                   	retq   
     */
    // leal	1(%rsi), %eax
	// testl	%edi, %edi
	// movl	$0, %edx
	// cmovs	%edx, %eax
	// negl	%esi
	// subl	%edi, %eax
	// cltd
	// idivl	%esi
    //return ((n>=0? d: 0) + (n>=0?1:0) - n) / -d; // equiv
    //return ((n>=0? d: 0) -n + (n>=0)) / -d; // possibly shorter machine code?
    /* 0000000000000020 <test_div_floorn(int, int)>:
20:	b8 00 00 00 00       	mov    $0x0,%eax
25:	85 ff                	test   %edi,%edi
27:	0f 49 c6             	cmovns %esi,%eax
2a:	f7 de                	neg    %esi
2c:	29 f8                	sub    %edi,%eax
2e:	f7 d7                	not    %edi
30:	c1 ef 1f             	shr    $0x1f,%edi
33:	01 f8                	add    %edi,%eax
35:	99                   	cltd   
36:	f7 fe                	idiv   %esi
38:	c3                   	retq   
     */
    //return ((n<=0? -1: d) +1 -n) / -d;    // 0x34 byt, 8 ins
    /* 0000000000000020 <test_div_floorn(int, int)>:
20:	8d 46 01             	lea    0x1(%rsi),%eax
23:	85 ff                	test   %edi,%edi
25:	ba 00 00 00 00       	mov    $0x0,%edx
2a:	0f 4e c2             	cmovle %edx,%eax
2d:	f7 de                	neg    %esi
2f:	29 f8                	sub    %edi,%eax
31:	99                   	cltd   
32:	f7 fe                	idiv   %esi
34:	c3                   	retq   
     */
    return ((n<=0? -1: d) - (n-1)) / -d; // perhaps very slightly better
    /* 0000000000000020 <test_div_floorn(int, int)>:
20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
25:	85 ff                	test   %edi,%edi
27:	0f 4f c6             	cmovg  %esi,%eax
2a:	83 ef 01             	sub    $0x1,%edi
2d:	f7 de                	neg    %esi
2f:	29 f8                	sub    %edi,%eax
31:	99                   	cltd   
32:	f7 fe                	idiv   %esi
34:	c3                   	retq   
     */
#endif // IDIV_BRANCHLESS

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
/** \ret r in (d,0] st n=d*k+r for some integer k
 * \pre d<0 (unchecked) */
inline constexpr int rem_floorn( int const n, int const d )
{
#if 0
    return n - d*div_floorn(n,d);
    /* 0000000000000030 <test_rem_floorn(int, int)>:
30:	89 f8                	mov    %edi,%eax
32:	99                   	cltd   
33:	f7 fe                	idiv   %esi
35:	85 d2                	test   %edx,%edx
37:	0f 9f c2             	setg   %dl
3a:	0f b6 d2             	movzbl %dl,%edx
3d:	29 d0                	sub    %edx,%eax
3f:	0f af f0             	imul   %eax,%esi        <---
42:	89 f8                	mov    %edi,%eax
44:	29 f0                	sub    %esi,%eax
46:	c3                   	retq   
     */
#else
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
    //return n%d +   (d & (n>0 && n%d>0? ~0: 0));
    //return n%d +   (d & (!(n>0 && n%d>0)? 0: ~0)); // oops?
    //return n%d +   (d & (n>0 && n%d!=0? ~0: 0));
    //return n%d +   (d & (n>=0 && n%d!=0? ~0: 0));
    //return n%d +   (d & (n<0 || n%d==0? 0: ~0));
    //return n%d +   (d & (n<0? 0: n%d==0? 0: ~0));
    //return n%d +   (d & (n<0? 0:   n%d==0? n%d: ~0));
    //return n%d +   (d & (n<0? 0:   n%d==0? n%d: ~(n%d==0?1:0)));
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
    //return n%d +   (d & (n<0? 0: n%d==0? 0: ~(n%d==0)));
    //return n%d +   (d & (n<0? 0: n%d!=0? ~0: 0));
    //return n%d +   (d & (n<0? 0: n%d!=0? ~(1-(n%d!=0)): 0));
    //return n%d +   (d & ( n%d!=0? ~(n<0?-1:0): 0));
    //return n%d +   (d & (n%d==0? 0: ~(-(n<0))));
    //return n%d +   (d & ((n<0 || n%d==0? 0: ~(n%d==0))));
    //return n%d +   (d & ((n<0 || n%d==0? 0: ~(n<0 || n%d==0))));
    //return n%d +   (d & (n>0 && n%d>0? ~(1-(n>0 && n%d>0)): 0));

#endif
}
/** Truncate integer \c n / \c d (any signs) \f$\forall n, d!=0\f$
 * toward \f$-\infty\f$.
 * \pre d != 0 (unchecked)
 */
inline constexpr int div_floorx( int const n, int const d )
{
#if 1 // remainder-based
    //return d>0? div_floor(n,d): div_floorn(n,d);
    /* 0000000000000020 <test_div_floorx(int, int)>:
20:	89 f8                	mov    %edi,%eax
22:	99                   	cltd   
23:	f7 fe                	idiv   %esi
25:	85 f6                	test   %esi,%esi
27:	7e 07                	jle    30 <test_div_floorx(int, int)+0x10>
29:	c1 ea 1f             	shr    $0x1f,%edx
2c:	29 d0                	sub    %edx,%eax
2e:	c3                   	retq   
2f:	90                   	nop
30:	85 d2                	test   %edx,%edx
32:	0f 9f c2             	setg   %dl
35:	0f b6 d2             	movzbl %dl,%edx
38:	29 d0                	sub    %edx,%eax
3a:	c3                   	retq   
     */
    //return d>0? (n/d) - (n%d<0? 1: 0): (n/d) - (n%d>0? 1: 0); // expand
    //return (n/d) - (d>0? (n%d<0? 1: 0): (n%d>0? 1: 0)); // equiv
    //return ((n/d) - (
    //            (n%d==0) ? 0
    //            : n%d<0 && d>0? 1
    //            : n%d>0 && d<=0? 1
    //            : 0));
    //return ((n/d) - ( n%d<0 ? (d>0? 1: 0) : n%d>0 ? (d<0? 1: 0) : 0));
    //return ((n/d) - ( (n%d==0) ? 0 : n%d<0 && d>0? 1 : n%d>0 && !(d>0)? 1 : 0));
    //return ((n/d) - ( (n%d==0) ? 0 : n%d<0 && d>0? 1 : !(n%d<0) && !(d>0)? 1 : 0));
    // after reusing number of logical expressions, get to 1 branch again
    //return ((n/d) - ( (n%d==0) ? 0 : n%d<0 == d>0? 1 : 0));
    /* 0000000000000020 <test_div_floorx(int, int)>:
20:	89 f8                	mov    %edi,%eax
22:	99                   	cltd   
23:	f7 fe                	idiv   %esi
25:	85 d2                	test   %edx,%edx
27:	74 10                	je     39 <test_div_floorx(int, int)+0x19>
29:	f7 d2                	not    %edx
2b:	c1 ea 1f             	shr    $0x1f,%edx
2e:	85 f6                	test   %esi,%esi
30:	40 0f 9f c7          	setg   %dil
34:	31 fa                	xor    %edi,%edx
36:	0f b6 d2             	movzbl %dl,%edx
39:	29 d0                	sub    %edx,%eax
3b:	c3                   	retq   
     */
    // NOPE return ((n/d) - ( n%d<0 == d>0? 1 : 0));
    //return ((n/d) - ( (n%d==0) ? 0 : n%d<0 == d>0? !(n%d==0) : 0));
    //return ((n/d) - (                  n%d<0 == d>0? !(n%d==0) : 0)); // branchless
    return ((n/d) - (n%d<0 == d>0? !(n%d==0) : 0)); // branchless and no cmov

#elif 0
    return (n - 1 + (d>0) + (n<0) - ((d>0)==(n<0)? d: 0)) / d;
    // 15 instrns
    /* 0000000000000040 <test_div_floorx(int, int)>:
40:	89 fa                	mov    %edi,%edx
42:	31 c0                	xor    %eax,%eax
44:	c1 ea 1f             	shr    $0x1f,%edx
47:	85 f6                	test   %esi,%esi
49:	0f 9f c0             	setg   %al
4c:	8d 44 07 ff          	lea    -0x1(%rdi,%rax,1),%eax
50:	01 d0                	add    %edx,%eax
52:	85 f6                	test   %esi,%esi
54:	0f 9e c1             	setle  %cl
57:	38 d1                	cmp    %dl,%cl
59:	ba 00 00 00 00       	mov    $0x0,%edx
5e:	0f 45 d6             	cmovne %esi,%edx
61:	29 d0                	sub    %edx,%eax
63:	99                   	cltd   
64:	f7 fe                	idiv   %esi
66:	c3                   	retq   
     */
    //return d>0? div_floor(n,d): div_floorn(n,d); // 1 branch , 101-79 instrns
    //return (d>0? (n + (n<0) - (n<0? d: n<0))
    //        :  ((n<0? 0: d+1) - n))  /  (d>0?d:-d);
    //return ((n<0) + (d>0? (n - (n<0? d: n<0))
    //        :  ((n<0? -1: d+1) - n)))
    //    /  (d>0?d:-d);
    //return (d>0? (n + (n<0)   - (n<0? d: 0))
    //        :  -n + (n<0?0:1) + (n<0? 0: d))  /  (d>0?d:-d);
    //return ( (d>0? n: -n)                     // ouch, 2 branches
    //        + (d>0? ((n<0) - (n<0? d: n<0))
    //            :   ((n<0? 0: d+1)))
    //       )/  (d>0?d:-d);
    //  use alt ok expr for div_floorn ...
    //return (n + (d>0? n<0: -(n>0))
    //        - (d>0? ((n<0? d: n<0))
    //            :   ((n>0? d: n>0))))  /  d;
    //return (n + (d>0? n<0: -(n>0))
    //        - (d>0? ((n<0? d: 0))
    //            :   ((n>0? d: 0))))  /  d;
    //return (n + (d>0? n<0: -(n>0))
    //        - (((d>0) & (n<0)) | ((d<0) & (n>0))? d: 0)
    //        )  /  d;
    //return (n + (d>0? n<0: -!(n<0)) // 105-79 instrns
    //        - (d>0? ( (n<0)? d: 0)
    //            :   (!(n<0)? d: 0)))  /  d;
    //return d>0
    //    ? (n + (n<0)       - (n<0? d: n<0)) / d
    //    : (n - (n>0? 1: 0) - (n>0? d: 0)) / d
    //    //: ((n<0? 0: d+1) - n) / -d      // also 8 instrns
    //    ;
    //return ((d>0
    //    ? (1 + (n<0? 0: -1) - (n<0? d: 0)) 
    //    : (0 + (n<0? 0: -1) - (n<0? 0: d))) + n) / d;
    //return ((d>0
    //    ? ((n<0? 0: -1) - (n<0? d: 0)) 
    //    : ((n<0? 0: -1) - (n<0? 0: d))) + n + (d>0)) / d;
    //return (n + (d>0) - (d>0
    //    ? ((n<0? d: 0)) 
    //    : ((n<0? 0: d)))
    //        + (n<0? 0: -1)) / d;
    //return (n -1 + (n<0) + (d>0)
    //        - (d>0 ? ((n<0? d: 0)) : ((n<0? 0: d)))
    //        ) / d;
    //
    // YAHOO... branchless
    //return (n - 1 + (n<0) + (d>0) - ( (d>0==n<0)? d: 0 )) / d;
    //return ((n<0) + (d>0) - (d>0 == n<0? d: 0) + n - 1) / d;
    //return ((n<0) + (d>0) - ((d>0!=n<0)? 0: d) + n - 1) / d;
    //return ((n<0) + (d>0) - ((d>0) - (n<0)? 0: d) + n - 1) / d;
    //return (n-1 + (d>0) + (n<0) - ((d>0) - (n<0)? 0: d)) / d;
    //return (n - 1 + (d>0) + (n<0) - ((d>0)==(n<0)? d: 0)) / d;
    // movl	%edi, %edx
	// xorl	%eax, %eax
	// shrl	$31, %edx
	// testl	%esi, %esi
	// setg	%al
	// leal	-1(%rdi,%rax), %eax
	// addl	%edx, %eax
	// testl	%esi, %esi
	// setle	%cl
	// cmpb	%dl, %cl
	// movl	$0, %edx
	// cmovne	%esi, %edx
	// subl	%edx, %eax
	// cltd
	// idivl	%esi
#elif 0
    return (n>=0 == d>=0)?     n/d
        :  (n<0 && d>0)?       (n - d + 1) / d
        :  /*(n>0 && d<0) ?*/  (n - d - 1) / d ;
#elif 0
    // sign(d), branchless:  (d>0) - (d<0)
    return (n>=0 == d>=0)? n/d
        :  (n-d+ ((d>0)-(d<0)) )/d ;
#elif 1
    return (n>=0 == d>=0? n
            :             n - d + (d>0)-(d<0)
           ) / d;
    // Would want to check assembly before continuing.
#else
    //return (n + (n>=0 == d>=0? 0
    //            : - d + (d>0)-(d<0))) / d;
    return d>0? div_floor(n,d)
        : div_floorn(n,d);
#endif
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

inline constexpr int rem_floorx( int const n, int const d )
{
    //return n - d*div_floor(n,d); // correct, but not so good (has Multiply)
    //return d>0? rem_floor(n,d): rem_floorn(n,d);
    //return d<0? rem_floorn(n,d): rem_floor(n,d);
#if 0
  80:	89 f8                	mov    %edi,%eax
  82:	99                   	cltd   
  83:	f7 fe                	idiv   %esi
  85:	85 f6                	test   %esi,%esi
  87:	7e 0f                	jle    98 <test_rem_floorx(int, int)+0x18>
  89:	89 d0                	mov    %edx,%eax
  8b:	c1 f8 1f             	sar    $0x1f,%eax
  8e:	21 c6                	and    %eax,%esi
  90:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
  93:	c3                   	retq   
  94:	0f 1f 40 00          	nopl   0x0(%rax)
  98:	85 d2                	test   %edx,%edx
  9a:	b8 00 00 00 00       	mov    $0x0,%eax
  9f:	0f 4e f0             	cmovle %eax,%esi
  a2:	8d 04 32             	lea    (%rdx,%rsi,1),%eax
  a5:	c3                   	retq   
0000000000000080 <test_rem_floorx(int, int)>:
  80:	89 f8                	mov    %edi,%eax
  82:	99                   	cltd   
  83:	f7 fe                	idiv   %esi
  85:	85 f6                	test   %esi,%esi
  87:	7e 0f                	jle    98 <test_rem_floorx(int, int)+0x18>
  89:	89 d0                	mov    %edx,%eax
  8b:	c1 f8 1f             	sar    $0x1f,%eax
  8e:	21 c6                	and    %eax,%esi
  90:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
  93:	c3                   	retq   
  94:	0f 1f 40 00          	nopl   0x0(%rax)
  98:	85 d2                	test   %edx,%edx
  9a:	b8 00 00 00 00       	mov    $0x0,%eax
  9f:	0f 4e f0             	cmovle %eax,%esi
  a2:	8d 04 32             	lea    (%rdx,%rsi,1),%eax
  a5:	c3                   	retq   
#endif
    //return d<0? //rem_floorn(n,d)
    //    n%d + (d & (n%d>0? ~0: 0))
    //    : //rem_floor(n,d);
    //    n%d + (d & (n%d<0? ~0: 0) );
#if 0
    return n%d + (d & (d<0? (n%d>0? ~0: 0): (n%d<0? ~0: 0)));
0000000000000080 <test_rem_floorx(int, int)>:
  80:	89 f8                	mov    %edi,%eax
  82:	99                   	cltd   
  83:	f7 fe                	idiv   %esi
  85:	89 d0                	mov    %edx,%eax
  87:	c1 f8 1f             	sar    $0x1f,%eax
  8a:	85 f6                	test   %esi,%esi
  8c:	78 0a                	js     98 <test_rem_floorx(int, int)+0x18>
  8e:	21 c6                	and    %eax,%esi
  90:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
  93:	c3                   	retq   
  94:	0f 1f 40 00          	nopl   0x0(%rax)
  98:	31 c0                	xor    %eax,%eax
  9a:	85 d2                	test   %edx,%edx
  9c:	0f 9f c0             	setg   %al
  9f:	f7 d8                	neg    %eax
  a1:	21 c6                	and    %eax,%esi
  a3:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
  a6:	c3                   	retq   
#endif
#if 1
    //return n%d + (d & (d<0? (n%d>0? ~0: 0): (n%d<0? ~0: 0)));
    // same return n%d + (d & (d<0? (n%d>0? ~(1-(d<0)): 1-(d<0)): (n%d<0? ~(d<0): (d<0))));
    //return n%d + (d & ( d<0?
    //            (n%d>0? ~0: 0)
    //            :
    //            (n%d<0? ~0: 0)
    //            ));
    //return n%d + (d & ( ((d<0) && (n%d>0)) ? ~0 : (!(d<0) && (n%d<0)) ? ~0 : 0));
    //return n%d + (n%d==0? 0 : (d & ( ((d<0)&&(n%d>0)) || (!(d<0)&&(n%d<0)) ? ~0: 0 ))); // 2 branches
    //return n%d + (d & ( ((d<0) && (n%d>0) || ((d>0) && (n%d<0)) ? ~0 : 0))); // longer
    //return n%d + (d & ( ((d>>31)&&(n%d>0) || ((d>0)&&(n%d>>31)) ? ~0 : 0))); // longer
    // ?? return n%d + (d & ( ((d^(n%d)>>31)!=0) || ((d>0)&&(n%d>>31)) ? ~0 : 0));
    return n%d + (d & ( diffsign(n%d,d/*!=0*/) ? ~0 : 0));
    /* 0000000000000090 <test_rem_floorx(int, int)>:
90:	89 f8                	mov    %edi,%eax
92:	31 c9                	xor    %ecx,%ecx
94:	99                   	cltd   
95:	f7 fe                	idiv   %esi
97:	89 f0                	mov    %esi,%eax
99:	31 d0                	xor    %edx,%eax
9b:	c1 f8 1f             	sar    $0x1f,%eax
9e:	85 d2                	test   %edx,%edx
a0:	0f 95 c1             	setne  %cl
a3:	21 c8                	and    %ecx,%eax
a5:	f7 d8                	neg    %eax
a7:	21 c6                	and    %eax,%esi
a9:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
ac:	c3                   	retq   
     */
    // improved diffsign...
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
#endif
}
#ifdef TEST_MAIN
#include <iostream>
#include <cstdlib>  // atoi
#if defined(_INTEL_COMPILER) 
# define GCC_VERSION 0 
# define restrict __restrict__ 
# define ASM_COMMENT(X) asm volatile ("#" X) 
#elif defined(_SX) 
# define __restrict__ restrict 
# define GCC_VERSION 0 
# define ASM_COMMENT(X) 
# define SX_SIMD 256 
#elif defined(__GNUC__) 
# define ASM_COMMENT(X) asm volatile ("#" #X) 
# define GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) 
# define restrict __restrict__ 
#endif 

// The following seems sufficient for seeing the actual assembly code.
int test_div_floor( int n, int d){
    ASM_COMMENT( "divfp" );
    return div_floor(n,d);
}
int test_div_floorn( int n, int d){
    ASM_COMMENT( "divfn" );
    return div_floorn(n,d);
}
int test_div_floorx( int n, int d){
    ASM_COMMENT( "divfx" );
    return div_floorx(n,d);
}
using namespace std;
int main(int argc, char** argv){
    int s=0;
    int a = argc;
    int d = a-5;
    if( argc > 1 ) s = atoi(argv[1]);
    if( argc > 2 ) a = atoi(argv[2]);
    if( argc > 3 ) d = atoi(argv[3]);
    int dp = (d>=0? d: -d);
    int dn = (d> 0? -d: d);
#if 0 // compiler mixes up assembly too much.
    ASM_COMMENT("normal division");
    int aod = a/d;
    ASM_COMMENT("div_floor");
    int divfp = div_floor (a , dp);
    ASM_COMMENT("div_floorn");
    int divfn = div_floorn(a , dn);
    ASM_COMMENT("div_floorx");
    int divfx = div_floorx(a , d);
    ASM_COMMENT("printout");
    if (aod != 255){
        printf("%6s %6s %6s %6s\n",
                "a/d", "divf+", "divf-", "divfx");
        printf("%3d/%-3d %3d/%-3d %3d/%-3d %3d/%-3d\n",
                a,d, a,dp, a,dn, a,d);
        printf("%7d %7d %7d %7d\n",
                 aod ,  divfp ,  divfn ,  divfx );
    }
#endif
#if 1
    int aod;
    char const* msg = "huh?";
    switch(s){
    case(0): {
                 msg =       "normal division";
                 ASM_COMMENT("normal division");
                 aod = a/d;
                 ASM_COMMENT("printout");
             }
             break;
    case(1): {
                 d = dp;
                 msg =       "divf+ (div_floor)";
                 ASM_COMMENT("divf+ (div_floor)");
                 aod = div_floor(a,d);
                 ASM_COMMENT("printout");
             }
             break;
    case(2): {
                 d = dn;
                 msg =       "divf- (div_floorn)";
                 ASM_COMMENT("divf- (div_floorn)");
                 aod = div_floorn(a,d);
                 ASM_COMMENT("printout");
             }
             break;
    default: {
                 msg =       "divf- (div_floorn)";
                 ASM_COMMENT("divf- (div_floorn)");
                 aod = div_floor(a,d);
                 ASM_COMMENT("printout");
             }
             break;
    }
    if (aod != 255) cout<<a<<" over "<<d<<" = "<<aod<<" : method "<<msg<<endl;
#endif
}
#endif // TEST_MAIN
// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
#endif //IDIV_HPP
