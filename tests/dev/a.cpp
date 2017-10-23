
//#include "./idiv_test.hpp" // experiments
#include "../benchdnn/idiv.hpp" // clean version
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

using namespace std;

// The following seems sufficient for seeing the actual assembly code.
int test_div_floor( int n, int d){
    ASM_COMMENT( "divfp" );
    return div_floor(n,d);
}
int test_rem_floor( int n, int d){
    ASM_COMMENT( "remfp" );
    return rem_floor(n,d);
}
int test_div_floorn( int n, int d){
    ASM_COMMENT( "divfn" );
    return div_floorn(n,d);
}
int test_rem_floorn( int n, int d){
    ASM_COMMENT( "remfp" );
    return rem_floorn(n,d);
}
int test_div_floorx( int n, int d){
    ASM_COMMENT( "divfx" );
    return div_floorx(n,d);
}
int test_rem_floorx( int n, int d){
    ASM_COMMENT( "remfp" );
    return rem_floorx(n,d);
}
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

/** A general linear integer function (no conditions on stride).
 * Hmm. while this is ok for readability, it might force evals and
 * memory colocations that are actually not so great.  Results
 * may vary between compilers!
 */
struct MIplusB {
    int const m; ///< slope (stride)
    int const b; ///< intercept (starting offset)

    /** Line \f$m \times i + b\f$ with slope \c m and intercept \c b.
     * Strided \e index calculation in a loop over \c i
     * :  \f$index = b_{start} + i \times m_{stride}\f$.
     * If stride \c m is known to be positive,
     * some speedups might be possible.
     */
    MIplusB( int const m, int const b ) : m(m), b(b) {}

    /** Evaluate \e offset for "loop index" \c i */
    int operator()( int const i ) const { return m*i+b; }

    /** Given target \c t, what index i yields mi+b just greater than \c t?
     * \f$i\ni m\times(i-1)+b < t \textrm{and} m\times i+b >= t\f$.
     */
    int ix_ge( int const t ){
        //int ret = (t-b) / m; // only OK if (t-b) is +ve
        int ret = div_floor( t-b, m );
    }
};
// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
