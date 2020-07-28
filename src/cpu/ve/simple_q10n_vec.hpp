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

/** basic saturation functions, vectorized */
template <typename data_t, typename acc_t> inline
typename utils::enable_if<!nstl::is_integral<data_t>::value, void>::type
saturate(const acc_t *x,
        typename utils::remove_reference<data_t>::type *out,
        //data_t *out,
        unsigned const vl) {
    FOR_vl out[i] =  (data_t)x[i];
}

template <typename data_t, typename acc_t> inline
typename utils::enable_if<nstl::is_integral<data_t>::value, void>::type
        //typename utils::remove_reference<data_t>::type>::type
saturatev(const acc_t *x,
        typename utils::remove_reference<data_t>::type *out,
        //data_t *out,
        unsigned const vl) {
    FOR_vl {
        acc_t v = x[i];
        if (v < (acc_t)nstl::numeric_limits<data_t>::lowest())
            v = (acc_t)nstl::numeric_limits<data_t>::lowest();
        if (v > (acc_t)nstl::numeric_limits<data_t>::max())
            v = (acc_t)nstl::numeric_limits<data_t>::max();
        out[i] = static_cast<typename utils::remove_reference<data_t>::type>(v);
    }
}

template <typename data_t> inline
void saturatev(const float *x, float *out, unsigned const vl) {
    FOR_vl {
        float v = x[i];
        if (v < (double)nstl::numeric_limits<data_t>::lowest())
            v = (double)nstl::numeric_limits<data_t>::lowest();
        if (v > (double)nstl::numeric_limits<data_t>::max())
            v = (double)nstl::numeric_limits<data_t>::max();
        out[i] = v;
    }
}

template <typename data_t> inline
void saturatev(const double *x, double *out, unsigned const vl) {
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
        float scaled[MVL]; VREG(scaled);
        FOR_vl scaled[i] = (float)in[i];
        round_and_saturatev<out_t>(scaled, out, vl);
    }
};

template <typename in_t, typename out_t>
struct qzv_a1b0<in_t, out_t,
        typename utils::enable_if<true && nstl::is_integral<in_t>::value
        && !is_subset<in_t, out_t>::value>::type>
{
    void operator()(in_t const* in, const out_t *out, unsigned const vl) {
        saturatev<out_t>(in, out, vl); }
};

template <typename in_t, typename out_t>
struct qzv_a1b0<in_t, out_t,
        typename utils::enable_if<is_subset<in_t, out_t>::value>::type>
{
    void operator()(in_t const* in, const out_t *out, unsigned const vl) {
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
