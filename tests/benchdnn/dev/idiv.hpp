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

// normal C99 and C++11 integer division works like this:
static_assert(  5/3 == 1, "oops");
static_assert(  4/3 == 1, "oops");
static_assert(  3/3 == 1, "oops");
static_assert(  2/3 == 0, "oops");
static_assert(  1/3 == 0, "oops");
static_assert(  0/3 == 0, "oops");
static_assert( -1/3 == 0, "oops"); // not "-1"
static_assert( -2/3 == 0, "oops");
static_assert( -3/3 ==-1, "oops");
static_assert(  5/-3 ==-1, "oops");
static_assert(  4/-3 ==-1, "oops");
static_assert(  3/-3 ==-1, "oops");
static_assert(  2/-3 == 0, "oops");
static_assert(  1/-3 == 0, "oops"); // not "-1"
static_assert(  0/-3 == 0, "oops");
static_assert( -1/-3 == 0, "oops");
static_assert( -2/-3 == 0, "oops");
static_assert( -3/-3 == 1, "oops");
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
    //return (n + ((n>=0)? 0: 1-d)) / d;
    //
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
    //return (n<0? -n: -n+d+1) / -d;
    //return (n<=0? n: n-d-1) / d;
    // n>0 and d<0:
    // 1/-3:    use 3/-3 instead
    //  let's go for branchless again...
    //return (n + (n<=0? 0: 0-d-1)) / d;  // already branchless!
    // movl	%esi, %ecx
	// testl	%edi, %edi
	// movl	$0, %eax
	// notl	%ecx
	// cmovg	%ecx, %eax
	// addl	%edi, %eax
	// cltd
	// idivl	%esi

    //
    // no change...
    //return (n - ((n>0)? d+(n>0): (n>0))) / d;
    //return (n - ((n>0) + (n>0? d: -(n>0)))) / d;
    //return (n + (n<=0? 0: -d-1)) / d;  // already branchless!
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
    //return (n - (n>0? 1: 0) - (n>0? d: 0)) / d; // shortest branchless
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
    //return (n<0? -n: -n+d+1) / -d;          // 10 ins, branchless
    //return ((n<0? 0: d+1) - n) / -d;      // 9 instrns
    //return ((n>=0? d+1: 0) - n) / -d;     // 9 instrns
    //return ((n>=0) + (n>=0? d: (n>=0)) - n) / -d;     // ouch
    return ((n<0? 0: d+1) - n) / -d;      // also 8 instrns
    // leal	1(%rsi), %eax
	// testl	%edi, %edi
	// movl	$0, %edx
	// cmovs	%edx, %eax
	// negl	%esi
	// subl	%edi, %eax
	// cltd
	// idivl	%esi

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
#if 1
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
    return (n - 1 + (d>0) + (n<0) - ((d>0)==(n<0)? d: 0)) / d;
    // 15 instrns
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
