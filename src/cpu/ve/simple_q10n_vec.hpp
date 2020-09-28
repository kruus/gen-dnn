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

// XXX standardize this macro (platform.hpp?)
#ifndef MVL
#if defined(__ve)
#define MVL 256
#else
#define MVL 16
#endif
#endif

// having issues with missing header include (perhaps)
// or maybe typos in re.in batch file :(
#define VE_MONOLITHIC 0

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

//
// Note: nc++ won't inline fns with extended asm.
//       So may have to explicitly "vcvt.w.s.sx.rz in higher level
//           routines for best performance.
//       A first example: simple_q10n_ve_f32_int.hpp
//           with various hand-written qzv_a1b0 "kernels"
// Note: even when inlined, such functions stop "higher-level optimizations"
//       whatever those are (perhaps further inlining?)
#define VE_NOINLINE __attribute__((noinline))
static void mxcsr_roundv VE_NOINLINE (float const* const f, int * const out, unsigned const vl)
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
        "svob\n\t" // memory
     :                                        // outputs
     //: "=m"(*(const int (*)[])out)//  error: dummy output "must be modifiable"?*/
     : [f]"r"(f), [vl]"r"(vl), [out]"r"(out)  // inputs
     , "m"( /*dummy input*/ *(const float (*)[]) f)
     : "%v63", "memory"                // clobbers, %vl unknown
    );
    // expt: can I get rid of "memory" (causes many spills) ??
#define VE_ROUND_FLOAT_TO_INT(F,VL,OUT) \
    asm("\t# VE_ROUND_FLOAT_TO_INT(F,VL,OUT)\n\t" \
            "lvl %[vl]\n\t" \
            "vldu %v63, 4, %[f]\n\t" \
            "vcvt.w.s.sx.rz %v63, %v63\n\t" \
            "vstl %v63, 4, %[out]\n\t" \
            : "m"(*(const int (*)[]) OUT) \
            : [f]"r"(F), [vl]"r"(VL), [out]"r"(OUT), \
              "m"( /*dummy input*/ *(const float (*)[]) F) \
            : "%v63"  /*, "memory" causes many spills? */ \
       )
#if 1
    // double-check:
    if(0){
        assert(vl <= MVL );
        static int nerr=0;
        if (nerr < 50) {
            for(int i=0; i<vl; ++i){
                if (out[i] != nearbyintf(f[i])){
                    printf( " nerabyintf(%f)=%d, but vcvt-->%d\n",
                            f[i], (int)nearbyintf(f[i]), (int)out[i]);
                    ++nerr;
                }
                if (nerr > 10) break;
            }
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
    void operator()(in_t const* in, out_t *out, unsigned const len) {
        size_t const blk = MVL;
        for (size_t b=0; b<len; b+=blk){
            size_t vl = (len-b > blk? blk: len-b);
            float scaled[MVL]; VREG(scaled);
            FOR_vl scaled[i] = (float)in[i];
            round_and_saturatev<out_t>(scaled, out, vl);
        }
    }
};

//
// NOTE: qzv_a1b0 for float --> int32_t, int8_t, uint8_t
//       moved to ve/simple_q10n_ve_f32_int.hpp header.
//       These use inline assembly, though.
//       VE operations with u8, s8 will always be slow,
//       since these types are not vectorizable.
//       (vec ops need alignment 4, and 8 is even better)
//
template <typename out_t>
struct qzv_a1b0<float, out_t,
        typename utils::enable_if<nstl::is_integral<out_t>::value
        //&& !nstl::is_same<out_t,int32_t>::value
        && sizeof(out_t) != 1
    >::type>
{
    void operator()(float const* in, out_t *out, unsigned const len) {
        size_t const blk = MVL;
        // VE vector float round has strange limit behaviour, so best
        // is to saturate first, round to int32_t, then cvt to out_t.
        float const lbound = (float)nstl::numeric_limits<out_t>::lowest();
        float const ubound = (float)nstl::numeric_limits<out_t>::max();
        NOVECTOR for (size_t b=0; b<len; b+=blk){
            size_t vl = (len-b > blk? blk: len-b);
            float sat[MVL];
            ShortLoop() for (size_t j=0; j<vl; ++j) {
                sat[j] = (in[b+j] < lbound? lbound: in[b+j]);
                sat[j] = (sat[j] > ubound? ubound: sat[j]);
            } // vectorizable
            int rnd[MVL];
            mxcsr_roundv(&sat[0], &rnd[0], vl);
            //VE_ROUND_FLOAT_TO_INT(&sat[0], vl, &rnd[0]);
            // if sizeof(out_t) < 4, following is NOT vectorizable
            NOVECTOR UNROLL(4) for (size_t j=0; j<vl; ++j)
                    out[b+j] = (out_t)rnd[j]; // not good if out_t is u32
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

#ifdef VE_MONOLITHIC
#include "cpu/ve/simple_q10n_ve_f32_int.hpp"
#endif // VE_MONOLITHIC

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s filetype=cpp
#endif // CPU_VE_SIMPLE_Q10N_VEC_HPP
