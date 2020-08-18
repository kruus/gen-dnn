#ifndef VE_ASM_H
#define VE_ASM_H

/** \group VE asm macros
 * - V   : vector register, 1st arg ~ 'final output'
 * - VT  : temporary vector register
 * - S   : scalar register, %s0 or %[input]
 * - VS  : vector or scalar register
 * - I   : Immediate value -64 to 63
 * - N   : Immediate vluae 0 to 127
 * - T   : temporary 32-bit value
 * - CVP : C void pointer  (if expr, may generate longish addr loads that are better precalculated)
 * - %s13,%s12,%s18,%s19 scratch registers
 * - Assume these assembler inline are non-recursive,
 *   so scratch regs can be re-used. Seq macros OK.
 */
//@{
#define STR0(...) #__VA_ARGS__
#define STR(...) STR0(__VA_ARGS__)
/** ? override to route assembler code elsewhere? */
#define ASM(A,...) asm(A __VA_ARGS__)
#define DOW(...) do{__VA_ARGS__}while(0)

#define VEOP(op,...) STR(op __VA_ARGS__) "\n\t"

#define in_immediate(VAR,CONSTEXPR) [VAR]"i"(CONSTEXPR)
#define in_scalar(VAR,...) [VAR]"r"(__VA_ARGS__)
#define inout_scalar(VAR,...) [VAR]"+r"(__VA_ARGS__)
#define out_scalar(VAR,...) [VAR]"=r"(__VA_ARGS__)

#define ve_lvl_N(Imm)   VEOP(lvl,       Imm)
#define ve_lvl_T(t)     VEOP(lea,       %s13,t) \
                        VEOP(lvl,       %s13)
#define ve_lvl(s)       VEOP(lvl,       s)

#define ve_for_by_MVL(S,vl
// usual stride=4 for int, float;
#define ve_ld_int_vis(      V,stride,CVP) VEOP(vldl.sx, V, stride, CVP) /*upper sx*/
#define ve_ld_uint_vis(     V,stride,CVP) VEOP(vldl,    V, stride, CVP) /*upper zeroed*/
#define ve_ld_float_vis(    V,stride,CVP) VEOP(vldu,    V, stride, CVP)
// 8 for double or long or packed
#define ve_ld8_vis(         V,stride,CVP) VEOP(vld,     V, stride, CVP)

#define ve_st_int_vis(  V,stride,CVP) VEOP(vstu,  V, stride, CVP)
#define ve_st_float_vis(V,stride,CVP) VEOP(vstu,  V, stride, CVP)
#define ve_st8_vis(     V,stride,CVP) VEOP(vst,   V, stride, CVP)
// .nc non-cache variants?

#define ve_int_to_float_vv(X,Y) VEOP(vcvt.s.w, X, Y)

#define ve_max_int(Vx,VSy,Vz) VEOP(vmaxs.w Vx,VSy,VZ)
#define ve_max_int_sx(Vx,VSy,Vz) VEOP(vmaxs.w.sx Vx,VSy,VZ)
#define ve_max_double(Vx,VSy,Vz) VEOP(vfmax.d Vx,Vy,Vz)
#define ve_max_float(Vx,VSy,Vz) VEOP(vfmax.s Vx,VSy,VZ)
#define ve_max_double(Vx,VSy,Vz) VEOP(vfmax.d Vx,Vy,Vz)

#define ve_min_int(Vx,VSy,Vz) VEOP(vmins.w Vx,VSy,VZ)
#define ve_min_int_sx(Vx,VSy,Vz) VEOP(vmins.w.sx Vx,VSy,VZ)
#define ve_min_float(Vx,VSy,Vz) VEOP(vfmin.s Vx,VSy,Vz)
#define ve_min_double(Vx,VSy,Vz) VEOP(vfmin.d Vx,VSy,Vz)

#define SHUFF(/*upper*/YZ,UL, /*lower*/yz,ul) /*YZ:0=Y,1=Z  UL:0=U,1=L*/ \
                4*(YZ*2 + UL) + (yz*2+ul)
//#define SHUFF_YUZU SHUFF(0,0, 1,0) /* x <-- Yupper, Zupper */
#define SHUFF_YUYU 0
#define SHUFF_YUYL 1 /* copy x <-- y */
#define SHUFF_YUZU 2
#define SHUFF_YUZL 3
#define SHUFF_YLYU 4 /* x <-- swap(y) */
#define SHUFF_YLYL 5
#define SHUFF_YLZU 6
#define SHUFF_YLZL 7
#define SHUFF_ZUYU 8
#define SHUFF_ZUYL 9
#define SHUFF_ZUZU 10
#define SHUFF_ZUZL 11 /* copy x <--z */
#define SHUFF_ZLYU 12
#define SHUFF_ZLYL 13
#define SHUFF_ZLZU 14
#define SHUFF_ZLZL 15

#if 0 // orig

#define s_negone(S)         ASM(STR(eqv S, 0,(0)1),:::STR(S));
//#define s_negone(S)         ASM(STR(eqv S, 0,(0)1),:STR(S));
//#define s_negone(S)         ASM(STR(eqv S, 0,(0)1));

#define s_zero(S)           ASM(STR(xor S, 0,(0)1));
#define s_addr_c(S,CVP)     ASM(STR(or S,0,%0)          ,::"r"(CVP):STR(S))

//#define pv_seq(V)		    ASM(STR(pvseq %V)           ,)
#define lea_c(S,CVP)        DOW(void* cvp=CVP; ASM(STR(or  S,0,%0) ,::"r"(cvp):STR(S)); );
#define lea_cx(S,CVP)       ASM(STR(or  S,0,%0) ,::"r"(CVP):STR(S) );
#define lvl(N)              ASM(STR(lea %s13,N\n\t) \
        /*                   */ STR(lvl %s13)           ,:::"%s13")
// VE assembler "I" Imm operands are -64 to 63
#define lvlImm(Imm)           ASM(STR(lvl %[vl]           ,::[vl]"i"(Imm):)) 
/** load 4*64 bits at Saddr into VM */
#define vm_ld(VM,Saddr) ASM(STR(ld %s12, 0(,Saddr)\n\t) STR(lvm VM,0,%s12\n\t) \
        /*               */ STR(ld %s13, 8(,Saddr)\n\t) STR(lvm VM,1,%s13\n\t) \
        /*               */ STR(ld %s18,16(,Saddr)\n\t) STR(lvm VM,2,%s18\n\t) \
        /*               */ STR(ld %s19,24(,Saddr)\n\t) STR(lvm VM,3,%s19\n\t) \
        /*               */ ,:::"%s12","%s13","%s18","%s19",STR(VM))
#define vm_st(VM,Saddr) ASM(STR(svm %s12,VM,0\n\t) STR(st %s12, 0(,Saddr)\n\t) \
        /*               */ STR(svm %s13,VM,1\n\t) STR(st %s13, 8(,Saddr)\n\t) \
        /*               */ STR(svm %s18,VM,2\n\t) STR(st %s18,16(,Saddr)\n\t) \
        /*               */ STR(svm %s19,VM,3\n\t) STR(st %s19,24(,Saddr)\n\t) \
        /*               */ ,:::"%s12","%s13","%s18","%s19","memory")
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

/* V = (VM? Va, VSb) -- ternary vector select, for i=1..VL */
#define v_mrg(V, VM,Va,VSb) ASM(STR(vmrg.l V,VSb,Vai, VM)   ,:::STR(V))
/* V =((i&1)==0)? (VM(m)[i]? Va[i] : S or VSb[i])
 *            : (VM(m+1)[i]? Va[i] : S or VSb[i]) */
#define pv_mrg(V, VMpair,Va,VSb) ASM(STR(vmrg.w V,VSb,Va, VMpair)  ,:::STR(V))

#define pv_seq_1032(V)      ASM(STR(pvseq V)           ,:::STR(V)) /*produce 1 0  3 2  5 4 ...*/
#define pv_swab(V,Vin)      ASM(STR(vshf V,Vin,Vin,4) ,:::STR(V)) /* 0 1 2 3 4 5...-> 1 0 3 2 5 4... */
#define pv_seq(V,VTswab)    DOW(pv_seq_1032(VTswab); \
        /*                   */ pv_swab(V,VTswab); )
#define pv_cvt_flt(V)       ASM(STR(pvcvt.s.w %V,%V)    ,:::STR(V))
#define pv_ld_c(V,CVP)      ASM(STR(vld V,8,%0)        ,::"r"(CVP):STR(V))
#define pv_st_c(V,CVP)      ASM(STR(vst V,8,%0)        ,::"r"(CVP):"memory")
#define pv_ld(V,S)          ASM(STR(vld V,8,S)         ,:::STR(V))    /* 8 ~ strided Sy==1 */
#define pv_st_c(V,CVP)      ASM(STR(vst V,8,%0)        ,::"r"(CVP):"memory")
#define pv_ld(V,S)          ASM(STR(vld V,8,S)         ,:::STR(V))    /* 8 ~ strided Sy==1 */
#define pv_st(V,S)          ASM(STR(vst V,8,S)         ,:::"memory")
#define pv_rotl_1(V,Vin,VTrot2) ASM(STR(vmv VTrot2,1,Vin\n\t) \
        /*                       */ STR(vshf V, VTrot2,Vin, 6\n\t) \
        /*                       */ ,:::STR(V));
#define pv_rotl_2(V,Vin)    ASM(STR(vmv %V,1,%Vin)      ,:::STR(V));
#define pv_rotl_2n(N,V,Vin) ASM(STR(vmv %V,N,%Vin)      ,:::STR(V));
#define pv_rotl_2nm1(N,V,Vin, VT0,VT1) ASM(STR(vmv VT0,N-1,Vin\n\t) /* Vin rotl 2N */ \
        /*                              */ STR(vmv VT1,N,Vin\n\t)   /* Vin rotl 2N-2 */ \
        /*                              */ STR(vshf V, VT1,VT0,6\n\t) /* shuffle */ \
        /*                              */ ,:::STR(V),STR(VT0),STR(VT1));
// assuming lvl(256)... rotl and set last 2 elements [510,511] to 64-bit 0
#define pv_movl_2_z255(V,Vin) ASM(STR(vmv V,1,Vin\n\t) \
        /*                 */ STR(lea %s13,0\n\t) \
        /*                 */ STR(lea %s12,255\n\t) \
        /*                 */ STR(lsv V(%s12),%s13\n\t) \
        /*                 */ ,:::"%s13",STR(V))
#define pv_rotr_2(V,Vin, Snegone) ASM(STR(vmv V,Snegone,Vin\n\t) \
        /*                         */ ,:::STR(V));
#define pv_rotr_1(V,Vin, Vrotr2,Snegone) ASM( \
        /*          */ STR(vmv Vrotr2,Snegone,Vin\n\t) \
        /*          */ STR(vshf V, Vin,Vrotr2,6\n\t) \
        /*          */ ,:::STR(V),STR(Vrotr2));
#define pv_movr_2(V,Vin, Snew64,Snegone) ASM(STR(vmv %V,Snegone,Vin\n\t) \
        /*                                */ STR(lsv V(0),Snew64\n\t) \
        /*                                */ ,:::"%s13",STR(V)) // ??
#define pv_clr_f0(V)        ASM(STR(lvs %s13,V(0)\n\t) \
        /*                   */ STR(and %s13,%s13,(32)1\n\t) \
        /*                   */ STR(lsv V(0),%s13) \
        /*                   */ ,:::"%s13",STR(V))
/** 0 1 ... 511 +---> 0 0 1 ... 510 */
#define pv_movr_1z(V,Vin, Vrotl2,Snegone) ASM(STR(vmv Vrotl2,Snegone,Vin\n\t) \
        /*                   */ STR(vshf V, Vin,Vrotl2,6\n\t) \
        /*                   */ STR(lvs %s13,V(0)\n\t) \
        /*                   */ STR(and %s13,%s13,(32)1\n\t) \
        /*                   */ STR(lsv V(0),%s13) \
        /*                   */ ,:::"%s13",STR(V))
/@}
#endif // orig
// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s filetype=c
#endif // VE_ASM_H
