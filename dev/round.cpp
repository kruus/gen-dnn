
#include <iostream>
#include <iomanip>
#include <cstdint>
//#include <cmath>
#include <limits>

#include <assert.h>
#include <stdio.h>
#include <fenv.h>               // fegetround...
#include <math.h>

using namespace std;

#define CHECK(...) do {if(!(__VA_ARGS__)){ \
    printf(" Oops. failed CHECK: %s\n", #__VA_ARGS__); \
    ++err; \
}}while(0)
#define FOR(var,lim) for(int i=0; i<(lim); ++i)
#define NOVEC _Pragma("_NEC novector")

void set_floats(float (&x)[256]){
    FOR(i,60) x[    i] = -30+i;
    FOR(i,60) x[ 60+i] = -30+i+0.25;
    FOR(i,60) x[120+i] = -30+i+0.50;
    FOR(i,60) x[180+i] = -30+i+0.75;
    FOR(i,16) x[240+i] = 0;
    x[240] = numeric_limits<float>::infinity();
    x[241] = -numeric_limits<float>::infinity();
    x[242] = 0.f;
    x[243] = -0.f;
    x[244] = numeric_limits<float>::quiet_NaN();
    x[245] = numeric_limits<float>::signaling_NaN();
    x[246] = numeric_limits<float>::min();
    x[247] = numeric_limits<float>::lowest();
    x[248] = numeric_limits<float>::max();
    x[249] = numeric_limits<float>::epsilon();
    x[250] = numeric_limits<float>::round_error();
    x[251] = numeric_limits<float>::denorm_min();
    x[252] = numeric_limits<int>::min();
    x[253] = numeric_limits<int>::max();
}
unsigned testround(){
    unsigned err=0;
    CHECK( "this should fail" == nullptr );
    CHECK( true,"this should fail too"==nullptr );
    float x[256];
    set_floats(x);
    // lrint for inf/nan/out-of-range raises FE_INVALID and returns impl-defined value
    // nearbyint is a rint functions that never raises 'inexact'
    // effect...................func..................................
    // round-to-zero            trunc (or rint with FE_DOWNWARD)
    // round-up                 ceil  (or rint with FE_UPWARD)
    // round-down               floor (or rint with FE_TOWARDZERO)
    // to-nearest-ties-even     rint with FE_TONEAREST
    // to-nearest-ties-away0    round
    printf(" nearbyintf should use current rounding mode (FE_TONEAREST), VE ties to zero\n");
    CHECK( nearbyintf(-1.5) == -1 );
    CHECK( nearbyintf(-0.5) == 0 );
    CHECK( nearbyintf(0.5) == 0 );
    CHECK( nearbyintf(1.5) == 1 );

    // novec and vec round
    int expect[256];
    NOVEC FOR(i,256) expect[i] = x[i];
    // cvt.w.s.sx.rz   oops round to zero mode !!! ignores fegetround() ?
    int fix[256];
    asm("## round1");
    FOR(i,256) fix[i] = x[i];
    // vcvt.w.s.sx.rz :
    //   w ~ word, 32-bit output
    //   s ~ float input
    //   sx ~ sign-extend output
    //   rz ~ round to zero
    // check
    NOVEC FOR(i,256){
        if(!(fix[i] == expect[i])){
            printf(" x[%3u] = %-12g novec fix %-10d expect %-10d\n");
        }
        CHECK(fix[i] == expect[i]);
    }
    return err;
}


// This is NOT inlined.
// So "inlining" of asm MUST be done by macros (painful)
static inline void __attribute__((always_inline)) fix_func
(float (&x)[256]/*input*/, int (&y)[256]/*output*/)
{
#if 0
    FOR(i,256) y[i] = x[i];
//# line 88
//	adds.l	%s0,%s0,(0)1
//	lea	%s63,256
//	or	%s0,0,%s0
//	lvl	%s63
//	vldu	%v63,4,%s0
//	adds.l	%s1,%s1,(0)1
//	or	%s1,0,%s1
//	vcvt.w.s.sx.rz	%v62,%v63
//	vstl	%v62,4,%s1              // VERY SURPRISING (not vstu)
#else
    // does not work ???
    asm(//"## fix_func\n"
            "lvl %[vl]\n\t"
            "vldu %v0,4,%[pfloat]\n\t"
            "vcvt.w.s.sx.rz %v1, %v0\n\t"
            "vstl %v1,4,%[pint]\n\t"
            : /*out*/ //"=m"(y[0])
            : /*in*/ [vl]"r"(256) [pfloat]"r"(&x[0]) [pint]"r"(&y[0]) //"m"(x[0])
            //: /*in*/ [vl]"r"(256)
            : /*clobber*/ "%v0", "%v1" //, "memory"
       );
//# End of prologue codes
//# line 90
//	lea	%s59,256
//	or	%s58,0,%s1
//	or	%s57,0,%s0
//	lvl %s59   
//	vldu %v33,4,%s57       
//	vcvt.w.s.sx.rz %v34, %v33
//	vstu %v34,4,%s58     
#endif
    //printf(" x[0] = %g --> fix %d\n", x[0], y[0]);
}
#if 1
#define AL8 __attribute__((aligned(8)))
#define STR0(s...) #s
#define STR(s...) STR0(s)
#define ASM(A,X...) asm(A X)
#define s_addr_c(S,CVP)     ASM(STR(or S,0,%0)          ,::"r"(CVP):STR(S))
#define lvl(N)              ASM(STR(lea %s13,N\n\t) \
        /*                   */ STR(lvl %s13)           ,:::"%s13")
/** load 4*64 bits at Saddr into VMa, and the next 4*64 bits into VMb.
 * For pack vector masks, VMa should be an even numbered Vector Mask register,
 * and VMb should be the next higher one. */
#define vm_ld2(VMa,VMb,Saddr) ASM(STR(ld %s12, 0(,Saddr)\n\t) STR(lvm VMa,0,%s12\n\t) \
        /*                     */ STR(ld %s13, 8(,Saddr)\n\t) STR(lvm VMa,1,%s13\n\t) \
        /*                     */ STR(ld %s12,16(,Saddr)\n\t) STR(lvm VMa,2,%s12\n\t) \
        /*                     */ STR(ld %s13,24(,Saddr)\n\t) STR(lvm VMa,3,%s13\n\t) \
        /*                     */ STR(ld %s12,32(,Saddr)\n\t) STR(lvm VMb,0,%s12\n\t) \
        /*                     */ STR(ld %s13,40(,Saddr)\n\t) STR(lvm VMb,1,%s13\n\t) \
        /*                     */ STR(ld %s12,48(,Saddr)\n\t) STR(lvm VMb,2,%s12\n\t) \
        /*                     */ STR(ld %s13,56(,Saddr)\n\t) STR(lvm VMb,3,%s13\n\t) \
        /*                     */ ,:::STR(%s12),STR(%s13),STR(VMa),STR(VMb))
#define vm_st2(VMa,VMb,Saddr) ASM( \
        STR(svm %s12,VMa,0\n\t) STR(st %s12, 0(,Saddr)\n\t) \
        STR(svm %s13,VMa,1\n\t) STR(st %s13, 8(,Saddr)\n\t) \
        STR(svm %s18,VMa,2\n\t) STR(st %s18,16(,Saddr)\n\t) \
        STR(svm %s19,VMa,3\n\t) STR(st %s19,24(,Saddr)\n\t) \
        STR(svm %s12,VMb,0\n\t) STR(st %s12,32(,Saddr)\n\t) \
        STR(svm %s13,VMb,1\n\t) STR(st %s13,40(,Saddr)\n\t) \
        STR(svm %s18,VMb,2\n\t) STR(st %s18,48(,Saddr)\n\t) \
        STR(svm %s19,VMb,3\n\t) STR(st %s19,56(,Saddr)\n\t) \
        ,:::"%s12","%s13","%s18","%s19","memory")
#define pv_ld(V,S)          ASM(STR(vld V,8,S)         ,:::STR(V)) // 8 ~ strided Sy==1
#define pv_st(V,S)          ASM(STR(vst V,8,S)         ,:::"memory")
#define pvor_msk(Vdst,Vsrc,VM) ASM(STR(pvor Vdst,(0)1,Vsrc,VM) ,:::STR(Vdst))

// load 32-bit mem values, cvt float-->int32/int64 (round-zero), store 32-bit mem values
#define vldu(V,S) ASM(STR(vldu V,4,%[ptr32]) ,::[ptr32]"r"(S):STR(V))
#define vcvt_w_s_sx_rd(Vint,Vfloat,rd) ASM(STR(vcvt.w.s.sx.rd Vint,Vfloat) ,:::STR(Vint))
#define vcvt_w_s_sx_rz(Vint,Vfloat) vcvt_w_s_sz_rd(Vint,Vfloat,rz)
// Rounding Modes: NONE(according to PSW),rz,rp,rm,rn,ra
#define vcvt_w_s_sx(Vint,Vfloat,rd) ASM(STR(vcvt.w.s.sx Vint,Vfloat) ,:::STR(Vint))
#define vstu(V,S) ASM(STR(vstu V,4,%[ptr32]) ,::[ptr32]"r"(S):STR(V))
#define vstl(V,S) ASM(STR(vstl V,4,%[ptr32]) ,::[ptr32]"r"(S):STR(V))
#define vcvt_float_int(x,y,rd) do { \
    asm("## vcvt float " STR(x) "[] --> int " STR(y) "[] rounding " STR(rd)); \
    lvl(256); /* %s12 used by macros as tmp reg */ \
    vldu(%v33,x); \
    vcvt_w_s_sx_rd(%v34,%v33,rd); \
    vstl(%v34,y); \
}while(0)

#define FIX_MACRO0(x,y) do { \
    asm("### fix_macro0 float " STR(x) "[] --> int " STR(y) "[]\n\t" \
            "lvl %[vl]\n" \
            "\tvldu %v33,4,%[pfloat]\n" \
            "\tvcvt.w.s.sx.rz %v34, %v33\n" \
            "\tvstl %v34,4,%[pint]\n" \
            : /*out*/  \
            : /*in*/ [vl]"r"(256) [pint]"r"(&y[0]) [pfloat]"r"(&x[0]) \
            : /*clobber*/ "%v33", "%v34" \
       ); \
}while(0)
#define FIX_MACRO1(x,y) do { \
    asm("### fix_macro1 float " STR(x) "[] --> int " STR(y) "[]\n\t" \
        "lvl %[vl]\n" \
        "\tvldu %v33,4,%[pfloat]\n" \
        "\tvcvt.w.s.sx.rz %v34, %v33\n" \
        "\tvstl %v34,4,%[pint]\n" \
        : /*out*/  \
        : /*in*/ [vl]"r"(256) [pint]"r"(y) [pfloat]"r"(x) \
        : /*clobber*/ "%v33", "%v34" \
       ); \
}while(0)
/* FIX_MACRO1 yields
	# line 159
	lea	%s63,-3072
	adds.l	%s59,%fp,(54)1
	adds.l	%s58,%fp,%s63
	lea	%s60,256
	lvl %s60   
	vldu %v33,4,%s58       
	vcvt.w.s.sx.rz %v34, %v33
	vstl %v34,4,%s59     
 */
#endif

unsigned testround2(){
    unsigned err=0;
    float x[256];
    set_floats(x);

    int expect[256];
    NOVEC FOR(i,256) expect[i] = x[i];
    int fix[256];
    FOR(i,256) fix[i] = 0;
    fix_func(x,fix); // not inlined?
    //fix_func(&x[0],&fix[0]);
    FIX_MACRO0(x,fix);  // better, but extra scalar reg copies
    FIX_MACRO1(x,fix);  // best,
    vcvt_float_int(x,fix,rz); // equally good, easier to develop/use?
    NOVEC FOR(i,256){
        volatile int* ex = &expect[0];
        volatile int* fx = &fix[0];
        if(!(fx[i] == ex[i])){
            printf(" x[%3u] = %-12g novec fix %-10d expect %-10d\n",
                    (unsigned)i, x[i], fix[i], expect[i]);
        }
        CHECK(fix[i] == expect[i]);
    }
    return err;
}
int main(int,char**){
    if(1){
        int const rounding_mode = fegetround();
        printf(" default fegetround() is %#x.  {FE_DOWNWARD, FE_TONEAREST,"
                " FE_TOWARDZERO, FE_UPWARD} = {%#x, %#x, %#x, %#x}\n",
                rounding_mode, FE_DOWNWARD, FE_TONEAREST,
                FE_TOWARDZERO, FE_UPWARD);
    }
    unsigned errors;
    errors = testround();
    printf(" testround failed:%u\n\n", errors);
    errors = testround2();
    printf(" testround2:%u\n\n", errors);
    cout<<"\nGoodbye"<<endl;
    return 0;
}
// vim: et ts=4 sw=4 nopaste cindent cino=+2s,^=l0,\:0,N-s
