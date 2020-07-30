/*******************************************************************************
* Copyright 2020 NEC Labs America LLC
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

#ifndef CPU_VE_SIMPLE_Q10N_VEC_HPP
#define CPU_VE_SIMPLE_Q10N_VEC_HPP
// this file should be included from cpu/simple_q10n.hpp
//
// NOTE: quantization has been greatly rewritten at some point after v1.4
//

#include "common/dnnl_optimize.h" // ShortLoop() etc.

#ifndef NOVECTOR
#if defined(__ve)
#define NOVECTOR _Pragma("_NEC novector")
#else
#define NOVECTOR
#endif
#endif

// XXX standardize this macro
#ifndef MVL
#if defined(__ve)
#define MVL 256
#else
#define MVL 16
#endif
#endif

namespace dnnl {
namespace impl {
namespace cpu {


/** \file vectorized quantization operations.
 * These extend \ref simple_q10n.hpp to operate on vector-register-sized
 * data.   Maybe block and extend to arbitrary length later?
 * There are some differences, in that vector ops always \b modify 'out[]'
 * instead of returning a value.  (scalar code could potentially write the
 * return value somewhere else). */

/* Vector Quantization, for register-limited vector size */
#define FOR_vl ShortLoop() for (int i=0; i<vl; ++i)

inline void mxcsr_roundv(float const* const f, int * const out, unsigned const vl)
    ATTR_NO_MSAN
{
#if DNNL_X64
    FOR_vl out[i] = _mm_cvtss_si32(_mm_load_ss(&f)); // BAD! (laziness)
#elif defined(__ve)
#if 0
    FOR_vl out[i] = (int)nearbyintf(f[i]);
#else
    //cvt.[output form].[input form]...
    //float->int|long:  cvt.w.{s|d}{.s|.sx}{.NONE|.rp|.rm|.re|.ra}, %sx, {%sy|I}
    //                                  NONE ~ according to PSW
    //double->long:     cvt.l.d[.rd]
    //int->float:       cvt.{d.w|s.w|d.l}
    //float->flat:      cvt.{s|d|q}.{s|d|q}
    asm("lvl %[vl]\n"
        "vldu %v63, 4, %[f]\n\t"           // float 0:31
        "vcvt.w.s.sx.rz %v63, %v63\n\t"    // VFIX op --> int32 in 32:63 of v64
        "vstl %v63, 4, %[out]\n\t"         // [sx into 0:31] , store 32:63 to out
     :                                        // outputs
     : [f]"r"(f), [vl]"r"(vl), [out]"r"(out)  // inputs
     : "%v63", "memory"                // clobbers, %vl unknown
    );
    // expt: can I get rid of "memory" (causes many spills) ??
#define VE_ROUND_FLOAT_TO_INT(F,VL,OUT) \
    asm("\t# VE_ROUND_FLOAT_TO_INT(F,VL,OUT)\n\t" \
            "lvl %[vl]\n\t" \
            "vldu %v63, 4, %[f]\n\t" \
            "vcvt.w.s.sx.rz %v63, %v63\n\t" \
            "vstl %v63, 4, %[out]\n\t" \
            : "m"( /*dummy output*/ *(const int (*)[]) OUT) \
            : [f]"r"(F), [vl]"r"(VL), [out]"r"(OUT), \
              "m"( /*dummy input*/ *(const float (*)[]) F) \
            : "%v63"  /*, "memory" causes many spills? */ \
       )
#if 0
    // double-check:
    if(1){
        int nerr=0;
        for(int i=0; i<vl; ++i){
            if (out[i] != nearbyintf(f[i])){
                printf( " nerabyintf(%f)=%d, but vcvt-->%d\n",
                        f[i], (int)nearbyintf(f[i]), out[i]);
                ++nerr;
            }
            if (nerr > 10) break;
        }
    }
#endif

#endif
#else
    FOR_vl out[i] = (int)nearbyintf(f[i]);
#endif
}

/** basic saturation functions, vectorized.
 * Attempt to handle trivial or special cases. */

template <typename data_t, typename acc_t> inline
typename utils::enable_if<!nstl::is_integral<data_t>::value, void>::type
// ex. anything --> float|double  (double-->float follows
saturatev(const acc_t *x, data_t *out, unsigned const vl) {
    FOR_vl out[i] =  (data_t)x[i];
}
template <> inline void // double --> float might saturate
saturatev(const double *x, float *out, unsigned const vl) {
    FOR_vl {
        double v = x[i];
        if (v < nstl::numeric_limits<float>::lowest())
            v = nstl::numeric_limits<float>::lowest();
        if (v > nstl::numeric_limits<float>::max())
            v = nstl::numeric_limits<float>::max();
        out[i] = v; // now should not yield +/- inf
    }
}

template <typename data_t, typename acc_t> inline
typename utils::enable_if<nstl::is_integral<data_t>::value
// integer --> same-or-larger-integer-type never saturates
&& (nstl::is_same<data_t,acc_t>::value
        || (nstl::is_integral<acc_t>::value && sizeof(data_t) > sizeof(acc_t)))
, void>::type
saturatev(const acc_t *x, data_t *out, unsigned const vl) {
    FOR_vl {
        out[i] = static_cast<data_t>(x[i]);
    }
}

template <typename data_t, typename acc_t> inline
typename utils::enable_if<nstl::is_integral<data_t>::value
&& !nstl::is_same<data_t,acc_t>::value
&& sizeof(data_t) < sizeof(acc_t), void>::type
saturatev(const acc_t *x, data_t *out, unsigned const vl) {
    // size-reducing, integer-output saturate
    // ex float-->s8, s32-->s8, ...
    acc_t v[MVL]; // saturate in bigger type (may vectorize)
    FOR_vl {
        v[i] = x[i];
        if (v[i] < (acc_t)nstl::numeric_limits<data_t>::lowest())
            v[i] = (acc_t)nstl::numeric_limits<data_t>::lowest();
        if (v[i] > (acc_t)nstl::numeric_limits<data_t>::max())
            v[i] = (acc_t)nstl::numeric_limits<data_t>::max();
    }
    // trying to get f32|s32-->u8 correct -- VE sporadic segfaults
    FOR_vl { // unvectorized if sizeof(data_t) < 4 on VE Aurora
        out[i] = static_cast<data_t>(v[i]);
    }
}

template <typename data_t, typename acc_t> inline
typename utils::enable_if<nstl::is_integral<data_t>::value
&& !nstl::is_same<data_t,acc_t>::value
&& sizeof(data_t) == sizeof(acc_t), void>::type
saturatev(const acc_t *x, data_t *out, unsigned const vl) {
    // makes sense for float-->[u]int32
    // int<-->int' may be nonsense (s8<-->u8 are below)
    acc_t v[MVL];
    FOR_vl {
        v[i] = x[i];
        if (v[i] < (acc_t)nstl::numeric_limits<data_t>::lowest())
            v[i] = (acc_t)nstl::numeric_limits<data_t>::lowest();
        if (v[i] > (acc_t)nstl::numeric_limits<data_t>::max())
            v[i] = (acc_t)nstl::numeric_limits<data_t>::max();
    }
    FOR_vl { // f32-->s32 would vectorize this
        out[i] = static_cast<data_t>(v[i]);
    }
}
// VE bug-hunting... saturate(round) gives us int* x, and see u8/s8 segfaults
// is u32 an output type? might not work nicely for that.
#if 0 // now handled above
template <> inline void
saturatev<int,int>(const int *x, int *out, unsigned const vl) {
    FOR_vl {
        out[i] = x[i];
    }
}
#endif
#if 0
template <typename data_t> inline
void saturatev(const int *x, data_t *out, unsigned const vl) {
    int v[MVL];
    FOR_vl {
        int v[i] = x[i];
        if (v[i] < (double)nstl::numeric_limits<data_t>::lowest())
            v[i] = (double)nstl::numeric_limits<data_t>::lowest();
        if (v[i] > (double)nstl::numeric_limits<data_t>::max())
            v[i] = (double)nstl::numeric_limits<data_t>::max();
    }
    FOR_vl { // if out is 16- or 8-bit, VE cannot vectorize...
        out[i] = (data_t)v;
    }
}
#endif
#if 1
// For temporaries, VE might prefer to work in vectorizable 'int' register
// for just a wee bit longer... before some unvectorizable final downcast.
// This might help up the vectorization ratio in some cases.
template <typename data_t> inline // VE should vectorize
typename utils::enable_if<nstl::is_integral<data_t>::value
&& sizeof(data_t) < sizeof(int), void>::type
saturatev(const int *x, int *out, unsigned const vl) {
    FOR_vl {
        float v = x[i];
        if (v < (double)nstl::numeric_limits<data_t>::lowest())
            v = (double)nstl::numeric_limits<data_t>::lowest();
        if (v > (double)nstl::numeric_limits<data_t>::max())
            v = (double)nstl::numeric_limits<data_t>::max();
        out[i] = v;
    }
}
#endif

/** special float<-->float but saturating to some other limits */
template <typename data_t> inline void
saturatev(const float *x, float *out, unsigned const vl) {
    FOR_vl {
        float v = x[i];
        if (v < (float)nstl::numeric_limits<data_t>::lowest())
            v = (float)nstl::numeric_limits<data_t>::lowest();
        if (v > (float)nstl::numeric_limits<data_t>::max())
            v = (float)nstl::numeric_limits<data_t>::max();
        out[i] = v;
    }
}

/** special double<-->double but saturating to some other limits */
template <typename data_t> inline void
saturatev(const double *x, double *out, unsigned const vl) {
    FOR_vl {
        double v = x[i];
        if (v < (double)nstl::numeric_limits<data_t>::lowest())
            v = (double)nstl::numeric_limits<data_t>::lowest();
        if (v > (double)nstl::numeric_limits<data_t>::max())
            v = (double)nstl::numeric_limits<data_t>::max();
        out[i] = v;
    }
}

template <> inline void
saturatev<int8_t, uint8_t>(const uint8_t *x, int8_t *out, unsigned const vl) {
    FOR_vl out[i] = x[i] <= 127u ? x[i] : 127;
}

template <> inline void
saturatev<uint8_t, int8_t>(const int8_t *x, uint8_t *out, unsigned const vl) {
    FOR_vl out[i] = x[i] >= 0 ? x[i] : 0;
}

template <typename out_t>
typename utils::enable_if<nstl::is_integral<out_t>::value, void>::type
out_roundv(float const* v, out_t *out, unsigned const vl) {
    mxcsr_roundv(v, out, vl);
}

template <typename out_t>
typename utils::enable_if<nstl::is_integral<out_t>::value, void>::type
out_roundv(double const* v, out_t *out, unsigned const vl) {
    //float f[MVL]; VREG(f);
    //FOR_vl f[i] = (float)in[i];
    mxcsr_roundv(in, out, vl); // extend!
}

template <typename out_t>
typename utils::enable_if<!nstl::is_integral<out_t>::value, void>::type
out_round(float const* v, out_t *out, unsigned const vl) {
    FOR_vl out[i] = in[i];
}

template <typename out_t> inline
void round_and_saturatev(float const* f, out_t *out, unsigned const vl) {
    int itmp[MVL]; VREG(itmp);
    out_roundv<int>(f, itmp, vl);
    saturatev<out_t>(itmp, out, vl);
}

/* Quantization with alpha == 1 and beta == 0 */
template <typename in_t, typename out_t, typename enabled = void>
struct qzv_a1b0 {
    void operator()(in_t const* in, out_t *out, unsigned const vl) {
        size_t const blk = MVL;
        for (size_t i=0; i<vl; i+=blk){
            for(size_t j=0; j<blk; ++j) {
                float scaled[MVL]; VREG(scaled);
                FOR_vl scaled[i] = (float)in[i];
                round_and_saturatev<out_t>(scaled, out, vl);
            }
        }
    }
};
template <typename out_t>
struct qzv_a1b0<float, out_t,
        typename utils::enable_if<nstl::is_integral<out_t>::value
        && (sizeof(out_t) < 4) >::type>
        // float --> (< 4-byte) int
{
    void operator()(float const* in, out_t *out, unsigned const len) {
        size_t const blk = MVL;
#if 1
        // change to saturate, then round, like trunk
        float const lbound = (float)nstl::numeric_limits<out_t>::lowest();
        float const ubound = (float)nstl::numeric_limits<out_t>::max();
        NOVECTOR for (size_t i=0; i<len; i+=blk){
            size_t vl = (len-i > blk? blk: len-i);
            float sat[MVL];
            ShortLoop() for (size_t j=0; j<vl; ++j) {
                float f = in[i+j];
                if (f < lbound) f = lbound;
                if (f > ubound) f = ubound;
                sat[i] = f;
            } // vectorizable
            int rnd[MVL];
            mxcsr_roundv(&sat[0], &rnd[0], vl);
            //VE_ROUND_FLOAT_TO_INT(&sat[0], vl, &rnd[0]);
            // if sizeof(out_t) < 4, following is NOT vectorizable
            NOVECTOR UNROLL(4) for (size_t j=0; j<vl; ++j)
                    out[i+j] = (out_t)rnd[j]; // not good if out_t is u32
        }
#else // NO NO NO round to int must be saturated
        //
        // I find that for +/-(too bit) float,
        // vcvt seems to produce "0" as rounded value.
        // NOT USEFUL ?
        //
        // VE should produce better code with int32_t lbound,ubound
        int const lbound = (int)nstl::numeric_limits<out_t>::lowest();
        int const ubound = (int)nstl::numeric_limits<out_t>::max();
        NOVECTOR for (size_t i=0; i<len; i+=blk){
            size_t vl = (len-i > blk? blk: len-i);
            int rnd[MVL];
            mxcsr_roundv(&in[i], &rnd[0], vl);
            // now this vectorizes (vmin,vmax ?)
            ShortLoop() for (int j=0; i<vl; ++j) {
                int r = rnd[i];
                if (r < lbound) r = lbound;
                if (r > ubound) r = ubound;
                rnd[i] = r;
            }
            // scalar loop to write small-int output
            NOVECTOR UNROLL(4) for (size_t j=0; j<vl; ++j)
                    out[i+j] = (out_t)rnd[j];
        }
#endif
    }
};
#if 1 // WIP
// f32->u8 direct 6x2x1024x4x102 --mode=C
// 0 --> 6.34595 (cf. generic w/ oscale=1 or 2 of 23.27 ms)
// 1 --> 6.35303
//   -->  w/ st1b asm loop
template <>
struct qzv_a1b0<float, uint8_t, void>
{
    void operator()(float const* in, uint8_t *out, unsigned const len) {
        size_t const blk = MVL;
        // change to saturate, then round, like trunk
        float const lbound = (float)nstl::numeric_limits<uint8_t>::lowest();
        float const ubound = (float)nstl::numeric_limits<uint8_t>::max();
        NOVECTOR for (size_t i=0; i<len; i+=blk){
            size_t vl = (len-i > blk? blk: len-i);
            // TODO mxcsr_roundv(float*, float lbound, float ubound, vl, int*) ??
            // (all in one asm construct)
            // first convert to int32, vector kernel
            int32_t sat[MVL] __attribute__((aligned(8))); // later might used packed ops?
            asm("\t# VE_ROUND_FLOAT_TO_INT_SAT_U8\n\t"
                    "lvl %[vl]\n\t"
                    "vldu.nc %v63, 4, %[in]\n\t"
                    "\n"
                    "# if too low, use (float) uint8_t.lowet() = 0.f\n\t"
                    //"lea.sl  %s12,%[lbound]\n\t"
                    "and %s12, 0, (0)1\n\t"
                    "vfcmp.s %v62, %s12, %v63\n\t"
                    "vfmk.s.gt %vm15, %v62\n\t"
                    "# Might vfmk.f.gt %vm15, %v63 be shorter and ok enough?\n\t"
                    //"and %s12, 0, (0)1 # again ?\n\t"
                    "vbrdu %v63, %s12, %vm15\n\t"
                    "\n"
                    "# if too high, cap at 255.f ~ uint8_t.max()\n\t"
                    //"lea.sl  %s12,%[ubound]\n\t"
                    "lea.sl  %s12,1132396544\t\t# (i32)255.0f\n\t"
                    "vfcmp.s %v62, %s12, %v63\n\t"
                    "vfmk.s.lt %vm15, %v62\n\t"
                    //"lea.sl  %s12,1132396544\t\t# 255.0f (?) again ?\n\t"
                    "vbrdu %v63, %s12, %vm15\n\t"
                    "\n"
                    "# cvt float to int32, like nearbyintf\n\t"
                    "vcvt.w.s.sx.rz %v62, %v63\n\t"
                    "vstl %v62, 4, %[out] # int32 output in lower half\n\t"
                    : "=m"( /*dummy output*/ *(int (*)[vl]) &sat[0] )
                    : [in]"r"(&in[i]), [vl]"r"(vl), [out]"r"(&sat[0])
                    //, [lbound]"r"(lbound), [ubound]"r"(ubound)
                    //, [lbound2]"r"(lbound), [ubound2]"r"(ubound)
                    , "m"( /*dummy input*/ *(const float (*)[vl]) &in[i])
                    : "%v62", "%v63", "%vm15"
                    , "%s12", "%s13"
               ); // still circa 10 ms (--mode=C); was 12 ms --mode=P

            if (1) { // claim: sat[i] for uint8_t all have highest 56 bits zero
                for(int j=0; j<vl; ++j)
                    assert( (sat[j] & 0xff) == sat[j] );
            }
           
#if 1 // bad -- asm halts optimization
            //unsigned j4 = vl/4*4; // asm kills optimization...
            uint8_t *o = &out[i];
            int32_t const *s = &sat[0];
            int j=0;
#if 0 // concept test only
            // util: memcpy_reduce<int32_t
            s = &sat[0];
            uint64_t tmp[MVL/(sizeof(uint64_t)/sizeof(uint8_t))];
            uint64_t *t = &tmp[0];
            // NOTE: vsrl sat[], [{0,1,2,...}*8] would do all the shifts,
            //   leaving ready to '&' in sets of 8.
            // - then write to mem[0..vl-1],
            // - reread mem with vl=8 and vrand {vector-reduce-and)
            // - write vrand results into tmp[0..vl/8-1]
            // - (remainder as usual)
            asm("# j8 loop");
            NOVECTOR for (int j8=vl/8; j8; ++t, s+=4, --j8){
                // order might be reversed
                *t = s[0]
                        + (s[1] << 8)
                        + (s[2] << 16)
                        + (s[3] << 24)
                        + (s[4] << 32)
                        + (s[5] << 40)
                        + (s[6] << 48)
                        + (s[7] << 56);
            }
            asm("# j8 remainder loop");
            // bytewise remainder loop
            uint8_t *b = (uint8_t *)t;
            for(int j=(vl&0x7); j; ++b, ++s, --j){
                *b = reinterpret_cast<uint8_t>(*s);
            }
            if (1) { // check above loops
                s = &sat[0];
                uint8_t *b = &tmp[0];
                int nerr = 0;
                for (int j=0; j<vl; ++j) {
                    //assert( b[j] == s[j] ); // equality, for uint8_t
                    if( b[j] != s[j] ){
                        printf(" oops b[%d] != s[%d] (0x%04x vs. 0x%04x)\n",
                                j, j, (int)b[j], (int)s[j] );
                        ++nerr;
                    }
                }
                if (nerr) {
                    fflush(stdout);
                    exit(13);
                }
            }
            // Once above is verified, optimized ...
            // now COULD use memcpy from &tmp[0] --> out
            // which will go fast if out is well-aligned
            //__builtin_memcpy( (void*)&out[i], (void const*)&tmp[0], vl );
#endif
#if 0
            NOVECTOR for (int j=vl; --j>=0; ++o, ++s){
                *o = (uint8_t) *s; // *s << 56 >> 56
                //*o = *s; // still "*s << 56 >> 56"
            }
#else
            if(vl) {
                s = &sat[0];
                o = &out[i];
                // if align of out[i] is 4, try vector-pack, vector write XXX
                asm("# scalar s32-->u8 bytwise copy\n\t"
                    "adds.l     %[s], -4, %[s]          # --s\n\t"
                    "adds.l     %[o], -1, %[o]          # --o\n\t"
                    "scalar_copy:\n\t"
                    "adds.l     %[s], 4, %[s]           # ++s\n\t"
                    "ldl.sx     %s63, 0(,%[s])          # s63 = load *s\n\t"
                    "adds.l     %[o], 1, %[o]           # ++o\n\t"
                    "sll        %s63, %s63, 56          # s63 = (uint8_t)s63 step 1\n\t"
                    "srl        %s63, %s63, 56          # s63 = (uint8_t)s63 step 2\n\t"
                    //"and        %s63, %s63, (56)0       # 1-op cvt, not req for u8\n\t"
                    "adds.w.sx  %[j], -1, %[j]          # --j\n\t"
                    "st1b       %s63, 0(,%[o])          # *o = (uint8_t)*o\n\t"
                    "brle.w.t   0, %[j], scalar_copy\n\t"
                    : "=m"( /*dummy output*/ *(uint8_t (*)[vl]) &out[0] )
                    : [s]"r"(s), [o]"r"(o)
                    , [j]"r"(vl) 
                    , "m"( /*dummy input*/ *(const uint32_t (*)[vl]) &sat[0])
                    : "%s63"
               );
               // exit with s,o pointing at last-copied items (NOT "end")
               if (1) { //check above asm
                   s = &sat[0];
                   o = &out[i];
                   int nerr = 0;
                   for(int j=0; j<vl; ++j){
                       if ((int32_t)o[j] != (int32_t)s[j]) {
                           printf(" oops o[%d] != s[%d] (0x%04x vs. 0x%04x)\n",
                                  j, j, (int)o[j], (int)s[j]);
                          ++nerr;
                       }
                   }
                   if (nerr) {
                       fflush(stdout);
                       exit(13);
                   }
               }
            }
#if 0
            .L361.7:
                    adds.l  %s63,4,%s63
                    adds.l  %s62,1,%s62
# line 423
                    ldl.sx  %s59,0(,%s63)   # *(s)
# line 422
                    adds.w.sx       %s61,1,%s61
# line 423
                    sll     %s59,%s59,56
                    or      %s58,0,%s61
                    srl     %s59,%s59,56
# line 422
                    cmpu.l  %s58,%s58,%s60
# line 423
                    st1b    %s59,0(,%s62)   # *(o)
                    brlt.l  %s58,0,.L361.7
                    br.l    .L361.6
#endif
#endif

#elif 0 // still mis-optimized. tons of "or %sX, 0, %sX" (useless crap)
            unsigned const j4 = vl >> 2 << 2;
            uint8_t * oa = &out[i];
            int32_t const* sa = &sat[0];
            if (j4) {
                uint8_t * ob = (uint8_t*)(void*)((intptr_t)oa + sizeof(uint8_t));
                int32_t const* sb = (int32_t const*)(void const*)((intptr_t)sa + sizeof(int32_t));
                uint8_t * oc = (uint8_t*)(void*)((intptr_t)oa + 2*sizeof(uint8_t));
                int32_t const* sc = (int32_t const*)(void const*)((intptr_t)sa + 2*sizeof(int32_t));
                uint8_t * od = (uint8_t*)(void*)((intptr_t)oa + 3*sizeof(uint8_t));
                int32_t const* sd = (int32_t const*)(void const*)((intptr_t)sa + 3*sizeof(int32_t));
                NOVECTOR for (int j=0; j<j4; j+=4){
                    *oa = (uint8_t)*sa;
                    *ob = (uint8_t)*sb;
                    *oc = (uint8_t)*sc;
                    *od = (uint8_t)*sd;
                    oa = (uint8_t*)(void*)((intptr_t)oa + (4*sizeof(uint8_t)) );
                    ob = (uint8_t*)(void*)((intptr_t)ob + (4*sizeof(uint8_t)) );
                    oc = (uint8_t*)(void*)((intptr_t)oc + (4*sizeof(uint8_t)) );
                    od = (uint8_t*)(void*)((intptr_t)od + (4*sizeof(uint8_t)) );
                    sa = (int32_t const*)(void const*)((intptr_t)sa + (4*sizeof(int32_t)) );
                    sb = (int32_t const*)(void const*)((intptr_t)sb + (4*sizeof(int32_t)) );
                    sc = (int32_t const*)(void const*)((intptr_t)sc + (4*sizeof(int32_t)) );
                    sd = (int32_t const*)(void const*)((intptr_t)sd + (4*sizeof(int32_t)) );
                }
            }
            NOVECTOR for (int j=j4; j<vl; ++j){
                *oa = (uint8_t)*sa;
                oa = (uint8_t*)(void*)((intptr_t)oa + (sizeof(uint8_t)) );
                sa = (int32_t const*)(void const*)((intptr_t)sa + (sizeof(int32_t)) );
            }

#endif
        }
    }
};
#endif // WIP
template <>
struct qzv_a1b0<float, int32_t, void>
{
    void operator()(float const* in, int32_t *out, unsigned const len) {
        size_t const blk = MVL;
        // change to saturate, then round, like trunk
        float const lbound = (float)nstl::numeric_limits<int32_t>::lowest();
        float const ubound = (float)nstl::numeric_limits<int32_t>::max();
        NOVECTOR for (size_t i=0; i<len; i+=blk){
            size_t vl = (len-i > blk? blk: len-i);
            // TODO mxcsr_roundv(float*, float lbound, float ubound, vl, int*) ??
            // (all in one asm construct)
#if 1 // huge asm ... assuming vcvt.w.s does "whatever" for over/underflow
#if 0 // essential ubound,lbound code
             lea.sl  %s55,-822083584  and s54
                     lea.sl  %s59,1325400064
            vldu.nc %v63,4,%s59
                    vfcmp.s %v62,%s55,%v63      # s55=s54= -something
                    vfmk.s.gt       %vm15,%v62
                    vbrdu   %v63,%s54,%vm15
                    vfcmp.s %v61,%s59,%v63
                    vfmk.s.lt       %vm15,%v61
                    vbrdu   %v63,%s51,%vm15
#endif
#if 1 // VE MUST USE careful version (seems correct)
                    // cannot cvt to int then sat, because
                    // vcvt might give zero for over/underflow !!!
                    //
                    // moving lbound, ubound into asm helps
                    // reduce spill by a lot.
                    // --mode=C 0.91 ms, (was ~12 ms)
            asm("\t# VE_ROUND_FLOAT_TO_INT\n\t"
                    "lvl %[vl]\n\t"
                    "vldu.nc %v63, 4, %[in]\n\t"
                    "\n"
                    "# if too low, use (float) int32_t.lowet()\n\t"
                    "lea.sl  %s63,-822083584\n\t"
                    //"vfcmp.s %v62, %[lbound], %v63\n\t"
                    "vfcmp.s %v62, %s63, %v63\n\t"
                    "vfmk.s.gt %vm15, %v62\n\t"
                    //"lea.sl  %s62,-822083584\n\t"
                    //"vbrdu %v63, %[lbound2], %vm15\n\t"
                    "vbrdu %v63, %s63, %vm15\n\t"
                    "\n"
                    "# if too high, use (float) int32_t.max()\n\t"
                    "lea.sl  %s63,1325400064\n\t"
                    //"vfcmp.s %v62, %[ubound], %v63\n\t"
                    "vfcmp.s %v62, %s63, %v63\n\t"
                    "vfmk.s.lt %vm15, %v62\n\t"
                    //"vbrdu %v63, %[ubound2], %vm15\n\t"
                    //"lea.sl  %s62,1325400064\n\t"
                    "vbrdu %v63, %s63, %vm15\n\t"
                    "\n"
                    "# cvt float to int, like nearbyintf\n\t"
                    "vcvt.w.s.sx.rz %v62, %v63\n\t"
                    "vstl %v62, 4, %[out] # int32 output in lower half\n\t"
                    : "=m"( /*dummy output*/ *(int (*)[vl]) &out[i] )
                    : [in]"r"(&in[i]), [vl]"r"(vl), [out]"r"(&out[i])
                    //, [lbound]"r"(lbound), [ubound]"r"(ubound)
                    //, [lbound2]"r"(lbound), [ubound2]"r"(ubound)
                    , "m"( /*dummy input*/ *(const float (*)[vl]) &in[i])
                    : "%v62", "%v63", "%vm15"
                    , "%s63" //, "%s62"
               ); // still circa 10 ms (--mode=C); was 12 ms --mode=P
#else // VE CANNOT ignore lbound,ubound even for int32_t output
            //
            // OH NO. for +/-large_float, output seems to be zero.
            // MUST saturate to int limit first (uggh)
            //
            asm("\t# VE_ROUND_FLOAT_TO_INT\n\t"
                    "lvl %[vl]\n\t"
                    "vldu.nc %v63, 4, %[in]\n\t"
                    "# ignore saturation for int32_t output ??\n\t"
                    "# cvt float to int, to agree with nearbyintf"
                    "vcvt.w.s.sx.rz %v63, %v63\n\t"
                    "vstl.ot %v63, 4, %[out] # int32 output in lower half\n\t"
                    :
                    : [in]"r"(&in[i]), [vl]"r"(vl), [out]"r"(&out[i])
                    : "%v63", "%vm15"
               );
#endif
#else // older (small asm)
            float sat[MVL];
            ShortLoop() for (size_t j=0; j<vl; ++j) {
#if 0 // horrible asm
                sat[j] = (in[i+j] < lbound? lbound:
                        in[i+j] > ubound? ubound
                        : in[i+j]);
#else // better (but still many spills here (not hoisted)
                float v = in[i+j];
                if (v < lbound) v = lbound;
                if (v > ubound) v = ubound;
                sat[i] = v;
#endif
            } // vectorizable
            // no need for temporary 'int' vector
#if 0
            //mxcsr_roundv(&sat[0], &out[i], vl);
#elif 0
            VE_ROUND_FLOAT_TO_INT(&sat[0], vl, &out[i]);
#elif 0
            //  following still has HORRIBLE spills (many scalar regs)
            asm("\t# VE_ROUND_FLOAT_TO_INT\n\t"
                    "lvl %[vl]\n\t"
                    "vldu %v63, 4, %[f]\n\t"
                    "vcvt.w.s.sx.rz %v63, %v63\n\t"
                    "vstl %v63, 4, %[out]\n\t"
                    : "=m"( /*dummy output*/ *(int (*)[vl]) &out[i] )
                    : [f]"r"(&sat[0]), [vl]"r"(vl), [out]"r"(&out[i]),
                    "m"( /*dummy input*/ *(const float (*)[vl]) sat)
                    : "%v63"  /*, "memory" causes many spills? */
               );
#else
            // even with no claims about mem clobber, still horrible spills.
            asm("\t# VE_ROUND_FLOAT_TO_INT\n\t"
                    "lvl %[vl]\n\t"
                    "vldu %v63, 4, %[f]\n\t"
                    "vcvt.w.s.sx.rz %v63, %v63\n\t"
                    "vstl %v63, 4, %[out]\n\t"
                    :
                    : [f]"r"(&sat[0]), [vl]"r"(vl), [out]"r"(&out[i])
                    : "%v63"
               );
#endif
#endif
        }
    }
};

template <typename in_t, typename out_t>
struct qzv_a1b0<in_t, out_t,
        typename utils::enable_if<true && nstl::is_integral<in_t>::value
        && !is_subset<in_t, out_t>::value>::type>
{
    void operator()(in_t const* in, out_t *out, unsigned const vl) {
        saturatev<out_t>(in, out, vl); }
};

template <typename in_t, typename out_t>
struct qzv_a1b0<in_t, out_t,
        typename utils::enable_if<is_subset<in_t, out_t>::value>::type>
{
    void operator()(in_t const* in, out_t *out, unsigned const vl) {
        FOR_vl out[i] = (out_t)in[i]; }
};

/* Quantization with alpha == 1 */
template <typename in_t, typename out_t>
struct qzv_a1 {
    void operator()(in_t const* in, out_t *out,
            unsigned const vl, float const beta) {
        float scaled[MVL]; VREG(scaled);
        FOR_vl scaled[i] = (float)in[i] + beta * out[i];
        round_and_saturatev<out_t>(scaled, out, vl);
    }
};

template <typename in_t>
struct qzv_a1<in_t, float> {
    void operator()(in_t const* in, float *out,
            unsigned const vl, float const beta) {
        FOR_vl out[i] = (float)in[i] + beta * out[i];
    }
};

/* Quantization with beta == 0 */
template <typename in_t, typename out_t>
struct qzv_b0 {
    void operator()(in_t const* in, out_t *out,
            unsigned const vl, float const alpha) {
        float scaled[MVL]; VREG(scaled);
        FOR_vl scaled[i] = alpha * in[i];
        round_and_saturatev<out_t>(scaled, out, vl);
    }
};

template <typename in_t>
struct qzv_b0<in_t, float> {
    void operator()(in_t const* in, float *out,
            unsigned const vl, float const alpha) {
        FOR_vl out[i] = alpha * in[i];
    }
};

/* Quantization with general alpha, beta */
template <typename in_t, typename out_t>
struct qzv {
    void operator()(in_t const* in, out_t *out,
            unsigned const vl, float const alpha, float const beta) {
        float scaled[MVL];
        FOR_vl scaled[i] = alpha * in[i] + (beta ? beta * out[i] : 0.f);
        round_and_saturatev<out_t>(scaled, out, vl);
        //printf(" rsv scaled[0]=%f --> out[0]=%ld\n", scaled[0], (long)out[0]);
    }
};

template <typename in_t>
struct qzv<in_t, float> {
    void operator()(in_t const* in, float *out,
            unsigned const vl, float const alpha, float const beta) {
        FOR_vl out[i] = alpha * in[i] + (beta ? beta * out[i] : 0.f);
    }
};

template <>
struct qzv<bfloat16_t, bfloat16_t> {
    void operator()(bfloat16_t const* in, bfloat16_t *out,
            unsigned const vl, float const alpha, float const beta) {
        FOR_vl out[i] = (bfloat16_t)(alpha * (float)in[i]
                + (beta ? beta * (float)out[i] : 0.f));
    }
};

template <>
struct qzv<float, bfloat16_t> {
    void operator()(float const* in, bfloat16_t *out,
            unsigned const vl, float const alpha, float const beta) {
        FOR_vl out[i] = (bfloat16_t)(alpha * in[i]
                + (beta ? beta * out[i] : 0.f));
    }
};

template <>
struct qzv<float16_t, float16_t> {
    operator()(float16_t const* in, float16_t *out,
            unsigned const vl, float const alpha, float const beta) {
        FOR_vl out[i] = (float16_t)(alpha * (float)in[i]
                + (beta ? beta * (float)out[i] : 0.f));
    }
};

template <>
struct qzv<float, float16_t> {
    float operator()(float const* in, float16_t *out,
            unsigned const vl, float const alpha, float const beta) {
        FOR_vl out[i] = (float16_t)(alpha * in[i]
                + (beta ? beta * out[i] : 0.f));
    }
};

#undef FOR_vl

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s filetype=cpp
#endif // CPU_VE_SIMPLE_Q10N_VEC_HPP
