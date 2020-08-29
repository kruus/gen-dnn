/*******************************************************************************
* Copyright 2016-2020 Intel Corporation
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

#include <assert.h>
#include <type_traits>

#include "common/c_types_map.hpp"
#include "common/dnnl_thread.hpp"
#include "common/math_utils.hpp"
#include "common/type_helpers.hpp"

#include "cpu/ref_eltwise.hpp"
#include "cpu/ve/ref_convolution_util.hpp" //cvt interface to simple_q10n
#if defined(__ve)
#include "common/ve/memory_desc_wrapper_opt.hpp"
#include "common/dnnl_optimize.h"
#endif

namespace dnnl {
namespace impl {
namespace cpu {

#define DATA_OFF(f, n, c, d, h, w) \
    (ndims == 1) \
            ? (f).off(n) \
            : ((ndims == 2) ? (f).off(n, c) \
                            : ((ndims == 3) ? (f).off(n, c, w) \
                                            : ((ndims == 4) ? (f).off( \
                                                       n, c, h, w) \
                                                            : (f).off(n, c, d, \
                                                                    h, w))))

using namespace alg_kind;
using namespace math;

#ifndef MVL
#define MVL 256 /*FIXME*/
#endif

/** \file
 * should investigate:
 *
 * - vectorized log1pf
 * - "direct" impl of soft_relu (run Remez Exchange)
 * - generic impl offset calc NOT using memory_desc_wrapper_opt vectorization
 * - possible to reduce lambda usage more w/ helper structs? reduce code duplication?
 */
namespace {

// oh, pragmas need this version (actual number, not constexpr)
#define STACK_ELEMS 4096
#define Medium_ PragmaQuote(_NEC loop_count(STACK_ELEMS))
#define MFOR(VAR,SZ) Medium_ for(int VAR=0; VAR<SZ; ++VAR)

/** stack usage threshold (max array size) for channel offsets.
 *
 * \todo VE blocksz chooser for tmp arrays should have use a
 * template compiler-time const max size. Best value depends
 * on across/within/fwd/bwd. (Significant speed differences).
 * Compile-time bound on tmp stack arrays is frequently req'd
 * to allow nc++ to vectorize.
 *
 */
static dim_t constexpr stack_elems = STACK_ELEMS; // a generally decent value

// ve vectorized fns -- specialized for IN,OUT size because
// VE can vectorize only u32,s32,float,double loops
template<typename T> struct is_vectorizable
: std::conditional<(std::is_same<T,float>::value
    || (std::is_integral<T>::value && sizeof(T) >= 4)
    || std::is_same<T,double>::value
    || std::is_same<T,long double>::value),
    std::true_type,
    std::false_type>::type
{};
static_assert( is_vectorizable<float>::value, "ohoh");
static_assert( !is_vectorizable<char>::value, "ohoh");
static_assert( !is_vectorizable<bfloat16_t>::value, "ohoh");

// emulate 'if constexpr', pre c++17 (and eliminate < 0 warning for unsigned)
template<typename T> inline static
        typename std::enable_if<std::is_signed<T>::value, void>::type
        mkNonNegative(T &x) {
            x = (x < T{0}? T{0}: x);
        }
template<typename T> inline static
        typename std::enable_if<!std::is_signed<T>::value, void>::type
        mkNonNegative(T &x) {
            ;
        }

static inline double fast_exp_64(const double x) noexcept {
        // Based on Schraudolph 1999, A Fast, Compact Approximation of the Exponential Function.
        // - Adapted to use 64-bit integer; reduces staircase effect.
        // - Valid for x in approx range (-700, 700).
        union{double d_; int64_t i_;} uid; //This could be moved to the thread scope.
        //BBBD(sizeof(uid)!=8)
        uid.i_ = int64_t(double((int64_t(1) << 52) / log(2.0)) * x + double((int64_t(1) << 52) * 1023 - 0)); //c=0 for 1.0 at zero.
        return uid.d_;
    }

// VE optimization level may omit input arg range checks for speed.
// this can cause tests to fail where inputs are illegal, or when
// inputs approach +/-inf, NaN, +/-0 limit cases.
#define NO_RANGE_CHECKS 0
#define TU_MATH_FN template <typename T, \
        typename U = typename utils::remove_reference<T>::type> \
        static inline U
#define TAU_MATH_FN template <typename T, typename A, \
        typename U = typename utils::remove_reference<T>::type> \
        static inline U

// begin with all ve math funcs same as unchecked src/common/math_utils.hpp
// override "as needed" for VE
// note: also override as you use ve_ALG_fwd<T,U> syntax (to specify U)
//       also override to let nc++ inline (grrrr!)
TU_MATH_FN ve_tanh_fwd(T const s) { return (U)(::tanhf((float)s)); }
TU_MATH_FN ve_square_fwd(T const s) { return (U)(s*s); }
TU_MATH_FN ve_abs_fwd(T const s) { return s > T{0}? (U)s : (U)-s; }
TU_MATH_FN ve_sqrt_fwd(T const s) { return (U)(::sqrtf((float)s)); }
TU_MATH_FN ve_log_fwd(T const s) { return (U)::logf((float)s); }
TAU_MATH_FN ve_linear_fwd(T const s, A const alpha, A const beta) {
    return (U)(alpha * s + beta);
}
TAU_MATH_FN ve_clip_fwd(T const s, A const alpha, A const beta) {
    //A as = A{s}; // narrowing, if s32-->float
    A as = (A)s; // XXX a simple (not best) approach
    as = (as > alpha? as: alpha);
    return (U)(as > beta? beta : as);
}
TAU_MATH_FN ve_relu_fwd(T s, A alpha) {
    return s > T{0}? (U)s: (U)(s * alpha);
}
TAU_MATH_FN ve_elu_fwd(T const s, A const alpha) {
    return s > T{0}? (U)s : (U)(alpha * (::expm1f((float)s)));
}
TAU_MATH_FN ve_bounded_relu_fwd(T s, A alpha) {
    //T const t_alpha{alpha};
    T const t_alpha = (T)alpha; // narrowing float alpha-->int OK
    mkNonNegative(s);
    s = (s > t_alpha? t_alpha: s); // same-type important for vectorization
    return (U)s;
}
inline float ve_soft_relu_flt_fwd(float const s){
    return s < 20.f? ::logf(1.0f + ::expf(s)): s;
}
// seems to inline OK
TU_MATH_FN ve_soft_relu_fwd(T s) {
#if NO_RANGE_CHECKS
    return (U)::logf(1.0f + ::expf((float)s));
#else
    //float const max_logf = 8.872284e+01; // ::log(FLT_MAX)
    //float const max_logf = 20.0f; // ::log(FLT_MAX)
    //float fs = (float)s; // narrowing int-->float is OK
    //return (U)(fs < max_logf? ::logf(1.0f + ::expf(fs)): fs);
#if 1 // normal
    // after 20, output value is equal to input with err < 2e-9 already
    float const fs = (float)s; // narrowing int-->float is OK
    return (U)( s < T{20}? ::logf(1.0f + ::expf(fs)): fs );
#else //debug
    float const max_logf = 20.0f; // ::log(FLT_MAX)
    float fs = (float)s; // narrowing int-->float is OK
    //printf("v"); fflush(stdout);
    float x = (fs < max_logf? ::logf(1.0f + ::expf(fs)): fs);
    float gold = (s < (T)logf(FLT_MAX)? (T)log1pf(::expf(fs)) : s);
    float diff = x - gold;
    if (fabs(diff) > 1e-7){
        printf(" soft_relu(x=%g) = %15.9f differs from gold %15.9f by %g\n",x,gold,diff);
    }
    //assert( fabs(x - log1pf(::expf(fs))) < 1.e-6f );
    return (U)x;
#endif
#endif
}
template <typename T, typename U = typename utils::remove_reference<T>::type>
static inline U ve_logistic_fwd(T const s) {
#if 0 // old
    //float fs{s};
    float fs = (float)s; // narrowing int-->float is OK
#if !NO_RANGE_CHECKS
    float constexpr neg_max_logf = -87.0f; // exp(small x) ~ 0
    if (fs < neg_max_logf) fs = neg_max_logf;
#endif
    return logistic_fwd<float,U>(fs);
#else // new. expand math::logistic_fwd ...
    float x = -(float)s; // narrowing int-->float is OK
#if !NO_RANGE_CHECKS
    float constexpr max_logf = 87.0f; // exp(small x) ~ 0
    if (x > max_logf) x = max_logf;
#endif
    x = ::expf(x);
    return (U)(1. / (1 + x));
#endif
}
// ve_exp_fwd I never got to behave nicely with int U round/saturate
// (left for caller)
TU_MATH_FN ve_exp_fwd(T s) {
    float fs = (float)s; // narrowing int-->float is OK
#if NO_RANGE_CHECKS
    return ::expf(fs);
#elif 0 // simpler version
    float constexpr neg_max_logf = -87.0f; // exp(small x) ~ 0
    if (fs < neg_max_logf) fs = neg_max_logf;
    return exp_fwd<float,U>(fs);
#else // check both +/- inf limits
    //printf("v"); fflush(stdout);
    float constexpr float_inf = HUGE_VALF;
    float constexpr max_logf = 87.0f;
    return fs > max_logf? float_inf: fs < -max_logf? 0.0f: std::expf(fs);
    //return int_rs<U,float>(fs > max_logf? float_inf: fs < -max_logf? 0.0f: std::expf(fs));
#endif
}
#define ve_gelu_tanh_fwd(...) gelu_tanh_fwd(__VA_ARGS__)
#define ve_swish_fwd(...) swish_fwd(__VA_ARGS__)


#if 0
#define ve_pow_fwd(...) pow_fwd(__VA_ARGS__)
#else
TAU_MATH_FN ve_pow_fwd(T s, A alpha, A beta) {
    U ret;
    if (beta == A{0}) {
        ret = alpha;
    } else if (beta == A{1}) {
        ret = alpha * s;
    } else if (beta == 0.5f) {
#if 1 || NO_RANGE_CHECKS // let's keep the -NaN
        float const fs = (float)s;
#else
        float fs = (float)s; // narrowing int-->float is OK
        mkNonNegative(fs);
#endif
        ret = alpha * sqrtf(fs);
    } else if (beta == 1.5f) {
#if 1 || NO_RANGE_CHECKS // let's keep the -NaN
        float const fs = (float)s;
#else
        float fs = (float)s; // narrowing int-->float is OK
        mkNonNegative(fs);
#endif
        ret = alpha * fs * sqrtf(fs);
    } else if (beta == A{2}) {
        ret = alpha * s * s;
#if !NO_RANGE_CHECKS
    } else if (beta < 0.f && beta == (float)(int)beta && (-(int)beta & 0x1) ) {
        //printf(" beta<0 is a -ve odd integer\n");
        // CORRECT powf(-0,beta) value is -inf
        // -O4 REF value is incorrect (-O0 is correct)
        //
        // (either/both fast-math and vector math funcs allow cheating on limit-cases)
        // (perhaps -O2 will give standards-compliant ::powf result? or an nc++ flag?)
        // alpha -ve/+ve is yet another corner case to fix
        float const fs = s;
        if (alpha >= 0.0f) {
            float const negzero = -0.0f;
            float const fixup = HUGE_VALF;
            ret = alpha * (fs == negzero
                    ? fixup : ::powf(fs, beta));
            //if (ret !=  alpha*::powf(fs,beta)) printf(" powf fixup+ fs=%g powf=%g ret=%g\n", fs, alpha*::powf(fs,beta), ret);
        }else{
            float const fixup = HUGE_VALF;
            ret = alpha * (::fabs(fs) == 0.0f
                    ? fixup : ::powf(fs, beta));
            //if (ret !=  alpha*::powf(fs,beta)) printf(" powf fixup fs=%g powf=%g ret=%g\n", fs, alpha*::powf(fs,beta), ret);
        }
#endif
    }else{
        //dst[e] = pow_fwd(src[e], alpha, beta);
        // beta=0.0f special case done above, avoid test...
        ret = alpha * ::powf((float)s, beta);
    }
    return ret;
}
// above is SLOW -- eltwise_fwd primitive avoids this by vectorizing
// each special case individually, according to eltwise_pow_subcase(alg,alpha,beta)
TAU_MATH_FN ve_pow1_fwd(T s, A alpha, A beta) { // beta==-2.f
    //return alpha / (s * s);  // VE maps +/-0 --> -nan (oops)
    float fs = s;
    float constexpr fixup = HUGE_VALF;
    fs = alpha * (fs==0.0f ? fixup: 1.0f / (fs * fs));
    // but really s==0 should return +/-inf !!!
    return fs;
}
TAU_MATH_FN ve_pow2_fwd(T s, A alpha, A beta) { // beta==-1.f
    //return alpha / s; // VE maps +/-0 --> -nan (oops)
    float fs = s;
    float constexpr fixup = HUGE_VALF;
    fs = alpha * (fs==0.0f ? fixup: 1.0f / fs);
    // but really s==+/-0 should return +/-inf !!!
    return fs;
}
TAU_MATH_FN ve_pow3_fwd(T s, A alpha, A beta) { // beta==0.f
    return alpha;
}
TAU_MATH_FN ve_pow4_fwd(T s, A alpha, A beta) { // beta==0.5f
    // no range check (?)
    return alpha * ::sqrtf((float)s);
}
TAU_MATH_FN ve_pow5_fwd(T s, A alpha, A beta) { // beta==1.f
    return alpha * s;
}
TAU_MATH_FN ve_pow6_fwd(T s, A alpha, A beta) { // beta==1.5f
    return alpha * s * ::sqrtf((float)s);
}
TAU_MATH_FN ve_pow7_fwd(T s, A alpha, A beta) { // beta==2.f
    return alpha * s * s;
}
TAU_MATH_FN ve_pow8_fwd(T s, A alpha, A beta) { // beta==-ve odd integer not -1, alpha >= 0.f
    float fs = s;
    assert( alpha >= 0.f );
#if 0
    fs = alpha * ::powf(fs, beta);
//[   1][0x0x0x1] src:       -7 fp0:     -inf fp:     -inf dt:-0.0028863 diff:     inf rdiff:    -nan
//[  13][0x0x4x1] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
//[  33][0x0x11x0] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
//[  53][0x0x17x2] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
//[  69][0x0x23x0] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
//[  93][0x0x31x0] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
//[ 173][0x0x57x2] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
//[ 233][0x0x77x2] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
//[ 241][0x0x80x1] src:       -0 fp0:      inf fp:      inf dt:     -inf diff:     inf rdiff:    -nan
#elif 1 // agreement with ref calc...
    float constexpr fixup = HUGE_VALF;
    fs = (fs == 0.f ? fixup : alpha * ::powf(fs, beta));
#else
    // following agrees with ref calc but is imprecise for input fs ~ 1.31316e-05
    if (fs >= -0.f) fs =  alpha * ::expf( beta * ::logf( fs));
    else            fs = -alpha / ::expf(-beta * ::logf(-fs));
#endif
    return fs;
}
TAU_MATH_FN ve_pow9_fwd(T s, A alpha, A beta) { // beta==-ve odd integer not -1, alpha < 0.f
    float fs = s;
    assert( alpha < 0.f );
#if 0
    fs = alpha * ::powf(fs, beta);
//[   1][0x0x0x1] src:       -7 fp0:      inf fp:      inf dt: 0.0028863 diff:     inf rdiff:    -nan
//[  13][0x0x4x1] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
//[  33][0x0x11x0] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
//[  53][0x0x17x2] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
//[  69][0x0x23x0] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
//[  93][0x0x31x0] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
//[ 173][0x0x57x2] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
//[ 233][0x0x77x2] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
//[ 241][0x0x80x1] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
#elif 1 // wrong outputs that agree with benchdnn ref calc
    float constexpr fixup = -HUGE_VALF;
    fs = (fs == 0.f ? fixup : alpha * ::powf(fs, beta));
#elif 0 // ?? the following has more correct results than ref calc that returns -inf for -ve inputs
    float constexpr negzero = -0.0f;
    float constexpr fixup = HUGE_VALF;
    fs = alpha * (fs == negzero ? fixup : ::powf(fs, beta));
#else
    // following agrees with ref calc but is imprecise for input fs ~ 1.31316e-05
    if (fs >= -0.f) fs =  alpha * ::expf( beta * ::logf( fs));
    else            fs = -alpha / ::expf(-beta * ::logf(-fs));
#endif
    return fs;
}
TAU_MATH_FN ve_pow10_fwd(T s, A alpha, A beta) { // beta==any other
    return alpha * ::powf((float)s, beta);
}
#endif
#define ve_gelu_erf_fwd(...) gelu_erf_fwd(__VA_ARGS__)

// use_dst_for_bwd versions punt to previous ve_ versions
#define ve_relu_use_dst_for_bwd(...) ve_relu_fwd(__VA_ARGS__)
#define ve_tanh_use_dst_for_bwd(...) ve_tanh_fwd(__VA_ARGS__)
#define ve_elu_use_dst_for_bwd(...) ve_elu_fwd(__VA_ARGS__)
#define ve_sqrt_use_dst_for_bwd(...) ve_sqrt_fwd(__VA_ARGS__)
#define ve_logistic_use_dst_for_bwd(...) ve_logistic_fwd(__VA_ARGS__)
#define ve_exp_use_dst_for_bwd(...) ve_exp_fwd(__VA_ARGS__)

template<typename OUT, typename IN, typename OFFSET, typename SZ> inline
typename std::enable_if<
is_vectorizable<OUT>::value &&
is_vectorizable<IN>::value, void>::type
vet_logistic_fwd(IN const *src, OUT *dst, OFFSET *data_off, SZ const vl)
{
    float constexpr max_logf = 87.0f; // exp(small x) ~ 0
    Medium_ for(SZ i=0; i<vl; ++i) {
        float x = -(float)src[data_off[i]]; // narrowing int-->float is OK
        if (x > max_logf) x = max_logf;
        dst[data_off[i]] = (OUT)(1.f / (1.f + ::expf(x)));
    }
}

template<typename OUT, typename IN, typename OFFSET, typename SZ> inline
typename std::enable_if<
!(is_vectorizable<OUT>::value &&
    is_vectorizable<IN>::value), void>::type
vet_logistic_fwd(IN const *src, OUT *dst, OFFSET *data_off, SZ const vl)
{
    float x[stack_elems];
    Medium_ for(SZ i=0; i<vl; ++i) {//unvec
        x[i] = src[data_off[i]];
    }
    // vec_logistic_fwd(x, vl) //?
    Medium_ for(SZ i=0; i<vl; ++i) {//vec
        float constexpr max_logf = 87.0f; // exp(small x) ~ 0
        x[i] = -x[i];
        if (x[i] > max_logf) x[i] = max_logf;
        x[i] = 1.f / (1.f + ::expf(x[i]));
    }
    Medium_ for(SZ i=0; i<vl; ++i) {//unvec
        dst[data_off[i]] = x[i];
    }
}

static inline dim_t stack_friendly_blksz(dim_t const hi){
    // borrow from ve/ref_lrn.cpp
    dim_t ret = (hi>0? hi: 1);
    if (hi > stack_elems) {
        ret = stack_elems;
        dim_t const nFull = hi/stack_elems;
        dim_t const rem   = hi%stack_elems;
        if (rem < stack_elems/4) {
            dim_t const nLoops = nFull + (rem!=0);
            ret = (hi+nLoops-1) / nLoops;
            //printf("+%d",(int)ret); // rough equipartition
            if (ret < stack_elems - MVL) {
                ret = (ret+MVL-1)/MVL*MVL;
                //printf("^%d",(int)ret); // round up
            }
        }
    }
    assert( ret <= stack_elems );
    return ret;
}
/** but also want blksz low enough that max_threads can actually be used...
 * XXX return to this with measurements XXX. */
static inline dim_t stack_friendly_blksz(dim_t const hi, dim_t const other_work){
    dim_t stack_lim = (other_work*hi/dnnl_get_max_threads());
    // adjust following, which assumes one MVL is "enough work"
    // here MVL ~ min desirable blksz (but we can go lower, a bit)
    if (stack_lim < MVL) stack_lim = MVL;
    stack_lim = (stack_lim+(MVL-1)) / MVL * MVL;
    if (stack_lim > stack_elems) stack_lim = stack_elems;

    // now heuristic with possibly smaller version of stack_elems
    dim_t ret = (hi>0? hi: 1);
    if (hi > stack_lim) {
        ret = (stack_lim+31)/32*32;
        dim_t const nFull = hi/stack_lim;
        dim_t const rem   = hi%stack_lim;
        if (rem < MVL/4) {
            dim_t const nLoops = nFull + (rem!=0);
            ret = (hi+nLoops-1) / nLoops;
            //printf("+%d",(int)ret); // rough equipartition
            if (ret < stack_lim - MVL) {
                ret = (ret+MVL-1)/MVL*MVL;
                //printf("^%d",(int)ret); // round up
            }
        }
        ret = (ret+31)/32*32;
    }
    //assert( ret < stack_elems );
    return ret;
}

static float compute_eltwise_scalar_fwd(
    const alg_kind_t alg, float s, float alpha, float beta) {
    float d = 0.f;
    switch (alg) {
        case eltwise_relu: d = ve_relu_fwd(s, alpha); break;
        case eltwise_tanh: d = ve_tanh_fwd(s); break;
        case eltwise_elu: d = ve_elu_fwd(s, alpha); break;
        case eltwise_square: d = ve_square_fwd(s); break;
        case eltwise_abs: d = ve_abs_fwd(s); break;
        case eltwise_sqrt: d = ve_sqrt_fwd(s); break;
        case eltwise_linear: d = ve_linear_fwd(s, alpha, beta); break;
        case eltwise_bounded_relu: d = ve_bounded_relu_fwd(s, alpha); break;
        case eltwise_soft_relu: d = ve_soft_relu_fwd(s); break;
        case eltwise_logistic: d = ve_logistic_fwd(s); break;
        case eltwise_exp: d = ve_exp_fwd(s); break;
        case eltwise_gelu_tanh: d = ve_gelu_tanh_fwd(s); break;
        case eltwise_swish: d = ve_swish_fwd(s, alpha); break;
        case eltwise_log: d = ve_log_fwd(s); break;
        case eltwise_clip: d = ve_clip_fwd(s, alpha, beta); break;
        case eltwise_pow: d = ve_pow_fwd(s, alpha, beta); break;
        case eltwise_gelu_erf: d = ve_gelu_erf_fwd(s); break;

        case eltwise_relu_use_dst_for_bwd: d = ve_relu_fwd(s, alpha); break;
        case eltwise_tanh_use_dst_for_bwd: d = ve_tanh_fwd(s); break;
        case eltwise_elu_use_dst_for_bwd: d = ve_elu_fwd(s, alpha); break;
        case eltwise_sqrt_use_dst_for_bwd: d = ve_sqrt_fwd(s); break;
        case eltwise_logistic_use_dst_for_bwd: d = ve_logistic_fwd(s); break;
        case eltwise_exp_use_dst_for_bwd: d = ve_exp_fwd(s); break;

        default: assert(!"unknown eltwise alg_kind");
    }
    return d;
}

/** for alg_kind pow, you may precalculate and re-use the "beta" subcases.
 */
static inline int eltwise_pow_subcase(const alg_kind_t alg, float const alpha, float const beta){
    int ret = 0;
    if (alg == eltwise_pow) {
        ret = (beta==-2.f? 1
            : beta==-1.f? 2
            : beta==0.f? 3
            : beta==0.5f? 4
            : beta==1.f? 5
            : beta==1.5f? 6
            : beta==2.f? 7
            : (beta < 0.f && beta == (float)(int)beta && (-(int)beta & 0x1) )? 8
            // 9 ~ subcase dep't on alpha XXX try to remove (later)
            : 10);
        if (ret==8 && alpha<0.f) ++ret; 
    }
    return ret;
}

#if 0 // trouble trying to vectorize cvt::rs , ohoh
template<typename data_t> inline 
typename utils::enable_if<(!nstl::is_integral<data_t>::value), void>::type
rs_float_to_int_to_notbigger(data_t *flt_out, float const *f_in, int const vl)
{
    for(int i=0; i<vl; ++i) flt_out[i] = f_in[i]; // for float, not double or bf16
}

template<typename data_t>
typename utils::enable_if<(nstl::is_same<data_t,int32_t>::value), void>::type
rs_float_to_int_to_notbigger(data_t *i32_out, float const *f_in, int const vl)
{
    assert( vl <= MVL );
    mxcsr_roundv(f_in, i32_out, vl);
}

template<typename data_t>
typename utils::enable_if< (std::is_integral<data_t>::value
&& sizeof(data_t) ==1), void>::type
rs_float_to_int_to_notbigger(data_t *i8_out, float const *f_in, int const vl)
{
    assert( vl <= MVL );
    int iround[MVL];
    mxcsr_roundv(f_in, iround, vl);
    for(int i=0; i<vl; ++i) {
        if (iround[i] < (int)nstl::numeric_limits<data_t>::lowest())
            iround[i] = (int)nstl::numeric_limits<data_t>::lowest();
        if (iround[i] > (int)nstl::numeric_limits<data_t>::max())
            iround[i] = (int)nstl::numeric_limits<data_t>::max();
    }
    // trying to get f32|s32-->u8 correct -- VE sporadic segfaults
    NOVEC for(int i=0; i<vl; ++i) {
        i8_out[i] = iround[i];
    }
}
#endif


/** vector version of compute_eltwise_scalar_fwd.
 * \pre do NOT require vl <= maximum vector register length [at least for now]
 * \todo check VE other opportunities for compute_eltwise_vector_fwd.
 * \todo increase inline size limits to accomodate this fn (or make it a fn call)
 *
 * - VE .s has no function calls, but still has linear "switch" tests (ouch)
 */
static void compute_eltwise_vector_fwd( const alg_kind_t alg,
        float alpha, float beta, float const scale,
        float * const d, float const* const s, int const vl,
        int const subalg=0/*can be in [1,15] for eltwise_pow dispatch*/) {
    switch (alg+subalg) {
#define vfor(...) for(int i=0; i<vl; ++i) { \
    d[i] = (__VA_ARGS__)*scale; \
} break

//#define vfor(...) ShortLoop() for(int i=0; i<vl; ++i) {d[i] = (__VA_ARGS__)*scale;} break
        //case eltwise_relu: vfor(ve_relu_fwd(s[i], alpha));
        case eltwise_relu_use_dst_for_bwd:
        case eltwise_relu: vfor(s[i] > 0.f? s[i]: s[i] * alpha);
        case eltwise_tanh_use_dst_for_bwd:
        case eltwise_tanh: vfor(::tanhf(s[i]));
        case eltwise_elu_use_dst_for_bwd:
#if 1
        // ouch HORRIBLE %vm save,restore -- seems unavoidable
        case eltwise_elu: vfor(s[i] > 0.f? s[i]: alpha * ::expm1f(s[i]));
#elif 1
        // mask spill/restore (even w/ alt method)
        case eltwise_elu: {
            for(int i=0; i<vl; ++i) {
                float fs = s[i];
                if (fs < 0.f) fs = alpha * ::expm1f(fs);
                d[i] = alpha * fs;
            }} break;
#elif 1
        // vector spill/restore (even w/ alt method)
        case eltwise_elu: { float fs;
            vfor( fs = (::expf(s[i])-1.f), fs = (fs < 0.f? fs : s[i]),
                alpha * fs );
        } break;
#elif 1 // ouch vector (or VM) save/restore around __vec_expm1f call
        case eltwise_elu: {
            for(int b=0; b<vl; b+=MVL) {
                int const rvl = (b+MVL < vl? MVL: b+MVL);
                float vr_s[MVL]; VREG(vr_s);
                float vr_d[MVL]; VREG(vr_d);
                ShortLoop() for(int i=0; i<rvl; ++i) {
                    vr_s[i] = s[b+i];
                    // because the vec call clobbers there is no way
                    // to avoid a spill/restore
                    vr_d[i] = alpha * ::expm1f(vr_s[i]);
                    if (vr_s[i] >= 0.f) vr_d[i] = vr_s[i];
                    d[b+i] = vr_d[i];
                }
            }
        } break;
#endif
        case eltwise_square: vfor(s[i]*s[i]);
        case eltwise_abs: vfor(s[i] > 0.f? s[i]: -s[i]);
        case eltwise_sqrt_use_dst_for_bwd:
        case eltwise_sqrt: vfor(::sqrtf(s[i])); // VE does it in double, then cvts back to float
        case eltwise_linear: vfor(alpha * s[i] + beta);
        case eltwise_bounded_relu: { float fs;
            vfor(fs = (s[i] > 0.f? s[i]: 0.f), (fs > alpha? alpha : fs));
        }
        case eltwise_clip: { float fs;
            vfor(fs = (s[i] > alpha? s[i]: alpha), (fs > beta? beta : fs));
        }
        case eltwise_soft_relu: vfor(s[i] < 20.f? ::logf(1.0f + ::expf(s[i])): s[i]);
        case eltwise_logistic_use_dst_for_bwd:
        case eltwise_logistic: {
            float constexpr float_inf = HUGE_VALF;
            float constexpr max_logf = 87.0f;
            float x;
            //vfor(s[i] > max_logf? float_inf: s[i] < -max_logf? 0.0f: std::expf(s[i]));
            vfor(x = -(float)s[i],
                x = (x < max_logf? x: max_logf),
                x = ::expf(x),
                (1.f / (1.f + x)) );
        }
        case eltwise_exp_use_dst_for_bwd:
        case eltwise_exp: {
            float constexpr float_inf = HUGE_VALF;
            float constexpr max_logf = 87.0f;
            vfor(s[i] > max_logf? float_inf: s[i] < -max_logf? 0.0f: std::expf(s[i]));
        }
        case eltwise_gelu_tanh: { //vfor(ve_gelu_tanh_fwd(s[i]));
            constexpr float sqrt_2_over_pi = 0.797884;
            constexpr float fitting_const = 0.044715;
            for (int i=0; i<vl; ++i) {
                float v = ::tanhf(sqrt_2_over_pi * s[i] * (1 + fitting_const * s[i] * s[i]));
                d[i] = 0.5 * s[i] * (1. + v);
            }
            break;
        }
        case eltwise_swish: vfor(s[i] / (1.0f + ::expf(-alpha * s[i])));
        case eltwise_log: vfor(::logf(s[i]));
        case eltwise_pow: { float fs;
            if (beta == -2.f) {vfor(alpha / (s[i]*s[i]));}
            if (beta == -1.f) {vfor(alpha / s[i]);}
            if (beta == 0.f) {vfor(alpha);}
            if (beta == 0.5f) {vfor(alpha * ::sqrtf(
                        s[i] < 0.f? 0.f: s[i]));}
            if (beta == 1.f) {vfor(alpha * s[i]);}
            if (beta == 1.5f) {vfor(fs = (s[i]<0.f? 0.f: s[i]),
                    alpha * fs * ::sqrtf(fs));}
            if (beta == 2.0f) {vfor(alpha * s[i] * s[i]);}
            if (beta < 0.f && beta == (float)(int)beta && (-(int)beta & 0x1) ) {
                // nc++ diffficulties with ::powf, except at -O0
                //printf(" beta<0 is a -ve odd integer\n");
                float const fixup = HUGE_VALF;
                vfor(alpha * (s[i] == 0.f? fixup : ::powf(s[i], beta)));
            }
            vfor(alpha * ::powf(s[i], beta));
        }
        case eltwise_pow+1: vfor(alpha / (s[i] * s[i]));        // beta==-2.f
        case eltwise_pow+2: vfor(alpha / s[i]);                 // beta==-1.f
        case eltwise_pow+3: vfor(alpha);                        // beta==0.f
        case eltwise_pow+4: vfor(alpha * ::sqrtf(s[i]));        // beta==0.5f
        case eltwise_pow+5: vfor(alpha * s[i]);                 // beta==1.f
        case eltwise_pow+6: vfor(alpha * s[i] * ::sqrtf(s[i])); // beta=1.5f
        case eltwise_pow+7: vfor(alpha * s[i] * s[i]);          // beta==2.f
        case eltwise_pow+8: { // beta < 0 is a -ve odd integer && alpha >= 0.f
            float constexpr fixup = HUGE_VALF;
            //float constexpr negzero = -0.0f;
            //vfor(alpha * (s[i] == negzero? fixup : ::powf(s[i], beta)));
            vfor(alpha * (s[i] == 0.f? fixup : ::powf(s[i], beta)));
        }
        case eltwise_pow+9: { // beta < 0 is a -ve odd integer && alpha < 0.f
            float constexpr fixup = HUGE_VALF;
            //vfor(alpha * (::fabs(s[i]) == 0.0f? fixup : ::powf(s[i], beta)));
            vfor(alpha * (s[i] == 0.f? fixup : ::powf(s[i], beta)));
        }
        case eltwise_pow+10: vfor(alpha * ::powf(s[i], beta)); //any other beta

    case eltwise_gelu_erf: vfor(ve_gelu_erf_fwd(s[i]));

#undef vfor
        default: assert(!"unknown eltwise alg_kind");
    }
}

static float compute_eltwise_scalar_bwd(
        const alg_kind_t alg, float dd, float s, float alpha, float beta) {
    float ds = 0.f;
    switch (alg) {
        case eltwise_relu: ds = relu_bwd(dd, s, alpha); break;
        case eltwise_tanh: ds = tanh_bwd(dd, s); break;
        case eltwise_elu: ds = elu_bwd(dd, s, alpha); break;
        case eltwise_square: ds = square_bwd(dd, s); break;
        case eltwise_abs: ds = abs_bwd(dd, s); break;
        case eltwise_sqrt: ds = sqrt_bwd(dd, s); break;
        case eltwise_linear: ds = linear_bwd(dd, s, alpha, beta); break;
        case eltwise_bounded_relu: ds = bounded_relu_bwd(dd, s, alpha); break;
        case eltwise_soft_relu: ds = soft_relu_bwd(dd, s); break;
        case eltwise_logistic: ds = logistic_bwd(dd, s); break;
        case eltwise_exp: ds = exp_bwd(dd, s); break;
        case eltwise_gelu_tanh: ds = gelu_tanh_bwd(dd, s); break;
        case eltwise_swish: ds = swish_bwd(dd, s, alpha); break;
        case eltwise_log: ds = log_bwd(dd, s); break;
        case eltwise_clip: ds = clip_bwd(dd, s, alpha, beta); break;
        case eltwise_pow: ds = pow_bwd(dd, s, alpha, beta); break;
        case eltwise_gelu_erf: ds = gelu_erf_bwd(dd, s); break;

        case eltwise_relu_use_dst_for_bwd:
            ds = relu_bwd_use_dst(dd, s, alpha);
            break;
        case eltwise_tanh_use_dst_for_bwd: ds = tanh_bwd_use_dst(dd, s); break;
        case eltwise_elu_use_dst_for_bwd:
            ds = elu_bwd_use_dst(dd, s, alpha);
            break;
        case eltwise_sqrt_use_dst_for_bwd: ds = sqrt_bwd_use_dst(dd, s); break;
        case eltwise_logistic_use_dst_for_bwd:
            ds = logistic_bwd_use_dst(dd, s);
            break;
        case eltwise_exp_use_dst_for_bwd: ds = exp_bwd_use_dst(dd, s); break;

        default: assert(!"unknown eltwise alg_kind");
    }
    return ds;
}
} //namespace <anon>

ref_eltwise_scalar_fwd_t::ref_eltwise_scalar_fwd_t(
        alg_kind_t alg, float alpha, float beta, float scale)
    : alg_(alg), alpha_(alpha), beta_(beta), scale_(scale) {
    assert(utils::one_of(alg_, eltwise_relu, eltwise_tanh, eltwise_elu,
            eltwise_square, eltwise_abs, eltwise_sqrt, eltwise_linear,
            eltwise_bounded_relu, eltwise_soft_relu, eltwise_logistic,
            eltwise_exp, eltwise_gelu_tanh, eltwise_swish, eltwise_log,
            eltwise_clip, eltwise_pow, eltwise_gelu_erf,
            eltwise_relu_use_dst_for_bwd, eltwise_tanh_use_dst_for_bwd,
            eltwise_elu_use_dst_for_bwd, eltwise_sqrt_use_dst_for_bwd,
            eltwise_logistic_use_dst_for_bwd, eltwise_exp_use_dst_for_bwd));
}

ref_eltwise_scalar_fwd_t::ref_eltwise_scalar_fwd_t(
        const post_ops_t::entry_t::eltwise_t &eltwise)
    : ref_eltwise_scalar_fwd_t(
            eltwise.alg, eltwise.alpha, eltwise.beta, eltwise.scale) {}

float ref_eltwise_scalar_fwd_t::compute_scalar(float s) {
    return compute_eltwise_scalar_fwd(alg_, s, alpha_, beta_) * scale_;
}

// pow subcase not exposed XXX
void ref_eltwise_scalar_fwd_t::compute_vec_reg(
    float * const dst, float const* const src, int const vl) {
    compute_eltwise_vector_fwd(alg_, alpha_, beta_, scale_, dst, src, vl);
}

//
// TODO vectorize this one too  (same approach)
// 1. amalgamate c<C loops
// 2. inline the lamda (remove fn call)
// 3. move switch(alg_kind) outside the parallel_nd so most
//    math fns can be inlined (and vectorized)
//
// pretty much the same as for forward_dense
// XXX for VE, this needs multi-block to use vector length >8.
//     jit might try 2d-vector load, o/w could merge 32x8 blocks
//     of source and then calculate and split into dst[]
//
template <impl::data_type_t data_type>
void ref_eltwise_fwd_t<data_type>::execute_forward_nCspBc_padded(
        const exec_ctx_t &ctx) const {
    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);

    bool constexpr is_int_dt = utils::one_of(data_type, data_type::s32, data_type::s8, data_type::u8);
    using cvt = Cvt<data_t, is_int_dt>;

    const memory_desc_wrapper data_d(pd()->src_md());
    const blocking_desc_t &blk = data_d.blocking_desc();
    const dim_t block = blk.inner_blks[0];

    const dim_t MB = pd()->MB();
    const dim_t C = pd()->C() / block;
    const dim_t C_PADDED = data_d.padded_dims()[1] / block;
    const dim_t tail = pd()->C() % block;
    const dim_t SP = pd()->D() * pd()->H() * pd()->W();
    const auto alg_kind = pd()->desc()->alg_kind;
    const float alpha = pd()->desc()->alpha;
    const float beta = pd()->desc()->beta;
#define ELT_FWD_BLK_VEC 0
    if(0){
        if (src!=dst) printf("fwd eltwise nCsp8c_padded %d\n", ELT_FWD_BLK_VEC);
        else printf("fwd eltwise generic nCsp8c_padded %d, src=dst\n", ELT_FWD_BLK_VEC);
    }

#if ELT_FWD_BLK_VEC==0
    // unvectorizable on VE (compute_eltwise_scalar_fwd function reference)
    auto ker = [=](data_t &d, data_t s) {
        //d = compute_eltwise_scalar_fwd(alg_kind, s, alpha, beta);
        float f = compute_eltwise_scalar_fwd(alg_kind, s, alpha, beta);
        if (is_int_dt) d = cvt::rs(f);
        else d = f;
    };

    parallel_nd(MB, C_PADDED, SP, [&](dim_t n, dim_t c, dim_t sp) {
        auto d_off = (n * C_PADDED * SP + c * SP + sp) * block;
        if (c < C) {
            for (dim_t v = 0; v < block; v++)
                ker(dst[d_off + v], src[d_off + v]);
        } else {
            for (dim_t v = 0; v < tail; v++)
                ker(dst[d_off + v], src[d_off + v]);
        }
    });
#else
#error "ELT_FWD_BLK_VEC value TBD"
#endif // ELT_FWD_BLK_VEC
#undef ELT_FWD_BLK_VEC
}

template <impl::data_type_t data_type>
void ref_eltwise_fwd_t<data_type>::execute_forward_generic(
        const exec_ctx_t &ctx) const {
    /* fast return */
    if (pd()->has_zero_dim_memory()) return;

    bool constexpr is_int_dt = utils::one_of(data_type, data_type::s32, data_type::s8, data_type::u8);
    using cvt = Cvt<data_t, is_int_dt>;

    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);
#define ELT_FWD_GEN_VEC 2
    // 1 was removed
    // for f32 exp log
    // 0 : 20.1 22.16
    // 1 : 2.8  3.8
    // 2 : ~same
    // 85x87x99x3 exp(x), log(x), 0.25*pow(x,-0.6), logistic_dst
    // 0 : f32 timings
    // 1 : 25.71 31.39 42.94 38.24
    // 2 :  1.16  1.15 37.56  4.05
    // added eltwise_pow_subcase support
    // 0 : 108.6 113.8 121.2 132.2  
    // 2 :  1.16  1.15  1.27  4.05
    //                        1.18 (inlined math::logistic_fwd)
    //   :  1.16  1.14  1.27  1.17
    // u8 time, logistic_dst, exp_dst
    // 0 : 120.3 113.3
    // 1 : 38.06 31.86
    // 2 :  4.47 18.05
    //      4.09 11.09 manual loop-splitting (some can vectorize)
    //           11.07 manual loop-blocking (not kept)
    //           ^^^^^ SHOULD be better, but saturation is a nonvec func call,
    //           and mxcsr_roundv vector version does not work properly
    //           (at least with nc++ extended asm -- should try clang)
    if(0){
        if (src!=dst) printf("fwd eltwise generic %d\n", ELT_FWD_GEN_VEC);
        else printf("fwd eltwise generic %d, src=dst\n", ELT_FWD_GEN_VEC);
    }

#if !ELT_FWD_GEN_VEC
    const memory_desc_wrapper data_d(pd()->src_md());
#else
    const memory_desc_wrapper_opt data_d(pd()->src_md());
#endif

    const dim_t MB = pd()->MB();
    const dim_t C = pd()->C();
    const dim_t D = pd()->D();
    const dim_t H = pd()->H();
    const dim_t W = pd()->W();
    const auto alg_kind = pd()->desc()->alg_kind;
    const float alpha = pd()->desc()->alpha;
    const float beta = pd()->desc()->beta;
    const int ndims = pd()->desc()->data_desc.ndims;

    // How to cover this code (not possible in default benchdnn eltwise tests?)
    //   examples:
    // --dir=FWD_D --tag=ABx16a16b --alg=log --alpha=0 --beta=0 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=linear --alpha=0 --beta=0.25 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=linear --alpha=0.22 --beta=0.33 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=clip --alpha=0.11 --beta=0.88 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=log,sqrt --alpha=0 --beta=0 45x87x33x3
    // NO --dir=FWD_D --tag=ABx16a16b --alg=pow --alpha=0.25 --beta=3.14 45x87x33x3

#if ELT_FWD_GEN_VEC==0
    // --dir=FWD_D --tag=ABx16a16b --alg=log --alpha=0 --beta=0 45x87x33x3
    // 19.15 ms
    parallel_nd(
            MB, C, D, H, W, [&](dim_t n, dim_t c, dim_t d, dim_t h, dim_t w) {
                auto data_off = DATA_OFF(data_d, n, c, d, h, w);
                float f = compute_eltwise_scalar_fwd( alg_kind, src[data_off], alpha, beta);
                if (is_int_dt) f = cvt::rs(f);
                dst[data_off] = f;
            });
#elif ELT_FWD_GEN_VEC == 1
#error "historical code  -- removed, do not use"
#elif ELT_FWD_GEN_VEC == 3 // debug compute_eltwise_vector_fwd
#elif ELT_FWD_GEN_VEC == 2 // use larger inner loop size --> 1.01 ms
    //
    // This approach blocks not by MVL but some larger stack-centric size
    //
    const ptrdiff_t nelems = static_cast<ptrdiff_t>(data_d.nelems(false));
    int const blksz = stack_friendly_blksz(nelems);
    assert( blksz <= /*constexpr*/ stack_elems );

    // determine pow exponent beta subcase before loop.
    // zero if not eltwise_pow
    int const pow_subcase = eltwise_pow_subcase(alg_kind, alpha, beta);
    //printf(" nelems=%ld blksz=%ld subcase=%d\n",nelems, blksz, pow_subcase);
    // beta > 0 preserves zeros, so 4--7 are dense
    assert( ! (pow_subcase >= 4 && pow_subcase <= 7) );

#define SWITCH_OUTSIDE 0
    // 0 : log 0.252 ms  1.13 
    // 1 : log 0.253 ms  1.14
    // and have much fewer
#if SWITCH_OUTSIDE
    // this style seems same speed and lots of functions.
    // save on the linear 'switch' cases being traversed many times.
    if (alg_kind == eltwise_log) {
        parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk) {
            dim_t const start = blk * blksz;
            dim_t const end   = (start + blksz > nelems? nelems: start + blksz);
            int const sz = end - start;
            //assert( sz <= /*constexpr*/ stack_elems );
            // Only need sz, but fixed-size array allows nc++ to make ivdep assumptions
            dim_t loff[stack_elems];
            size_t data_off[stack_elems];

            Medium_ for (int i=0; i<sz; ++i)
                    loff[i] = start + i; // a win if sz > ~1
            data_d.vec_off_l( &loff[0], sz, (dim_t*)&data_off[0] );

            Medium_ for(dim_t i=0; i<sz; ++i) {
                data_t s  = src[data_off[i]];
                //data_t &d = dst[data_off[i]];
                //d = ve_log_fwd(s);
                dst[data_off[i]] = (data_t)::logf((float)s);
            }
        });
    }else
#endif
        parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk) {
            dim_t const start = blk * blksz;
            dim_t const end   = (start + blksz > nelems? nelems: start + blksz);
            int const sz = end - start;
            //assert( sz <= /*constexpr*/ stack_elems );
            // Only need sz, butfixed-size array allows nc++ to make ivdep assumptions
            dim_t loff[stack_elems];
            size_t data_off[stack_elems];

            Medium_ for (int i=0; i<sz; ++i)
                    loff[i] = start + i; // a win if sz > ~1
            data_d.vec_off_l( &loff[0], sz, (dim_t*)&data_off[0] );

            switch(alg_kind + pow_subcase){
#define CASE2(ALG,EXPR) case eltwise_##ALG: { \
    Medium_ for(int i=0; i<sz; ++i) { \
        data_t const s  = src[data_off[i]]; \
        /*data_t &d = dst[data_off[i]];*/ \
        dst[data_off[i]] = EXPR; \
    }} break
#define ARG(...) __VA_ARGS__
//#define CASE(ALG,...) CASE2(ALG, ARG(ve_##ALG##_fwd<data_t,float>)(__VA_ARGS__))
#define CASE(ALG,...) CASE2(ALG, ve_##ALG##_fwd(__VA_ARGS__))
                CASE(log, s);
                CASE(linear, s, alpha, beta);
                CASE(sqrt, s);
                CASE(clip, s, alpha, beta);
                CASE(soft_relu, s);
                case eltwise_logistic_use_dst_for_bwd: // identical
#if 0
                CASE(logistic, s);
#elif 1 // devel
                case eltwise_logistic: {
                    // logistic has VE limit-case issues
                    if (is_vectorizable<data_t>::value) { // s32, f32
                        float constexpr max_logf = 87.0f; // exp(small x) ~ 0
                        Medium_ for(int i=0; i<sz; ++i) {
                            float x = -(float)src[data_off[i]]; // narrowing int-->float is OK
                            if (x > max_logf) x = max_logf;
                            dst[data_off[i]] = 1.f / (1.f + ::expf(x));
                        }
                    } else { // s8,u8,bf16
                        float x[stack_elems];
                        Medium_ for(int i=0; i<sz; ++i) {//unvec
                            x[i] = src[data_off[i]];
                        }
                        Medium_ for(int i=0; i<sz; ++i) {//vec
                            float constexpr max_logf = 87.0f; // exp(small x) ~ 0
                            x[i] = -x[i];
                            if (x[i] > max_logf) x[i] = max_logf;
                            x[i] = 1.f / (1.f + ::expf(x[i]));
                        }
                        Medium_ for(int i=0; i<sz; ++i) {//unvec
                            dst[data_off[i]] = x[i];
                        }
                    }
                } break;
#elif 1 // can we push the above speedups into a templated helper nicely?
                // The following runs ~ same speed BUT is NOT inlined
                case eltwise_logistic: {
                    vet_logistic_fwd(src, dst, &data_off[0], sz);
                } break;
#endif

                case eltwise_exp_use_dst_for_bwd: // lazy way
                // NO! CASE(exp, s); // issues with u8,s8 output
                case eltwise_exp: { // ovflw handling for VE
                    //float constexpr max_logf = 8.872284e+01f; // log(FLT_MAX)
                    float constexpr max_logf = 87.0f;
                    float constexpr float_inf = HUGE_VALF;
                    if (is_vectorizable<data_t>::value) { // f32,s32
                        // s32 seems OK without cvt::rs step
                        Medium_ for(int i=0; i<sz; ++i) {//unvec for bf16
                            float s = src[data_off[i]];
                            s = (s > max_logf? float_inf : ::expf(s));
                            dst[data_off[i]] = s;
                        }
                    } else if(std::is_integral<data_t>::value) { // u8, s8
                        // u8,s8 are not vectorizable and must cvt::rs
                        // but to use VREG, must block the loops
                        // manual loop blocking no big improvement (and more LOC)
                        float s[stack_elems];
                        Medium_ for(int i=0; i<sz; ++i) {
                            s[i] = src[data_off[i]];
                        }
                        Medium_ for(int i=0; i<sz; ++i) { //vec
                            s[i] = (s[i] > max_logf? float_inf : ::expf(s[i]));
                        }
                        data_t d[stack_elems];
#if 0 // doing better seems a whole new kettle of fish :(
                        // cvt::rs was not being inlined (why!?) expected 3-4x faster!
                        Medium_ for(int i=0; i<sz; ++i) {//unvec
                            // but really it should be inlined (much slower than expected)
                            //d[i] = cvt::rs(s[i]);
                        }
#elif 1
                        Medium_ for(int i=0; i<sz; ++i) {//unvec
                            s[i] = mxcsr_round(s[i]);
                        }
                        if (sizeof(data_t) < 4) { // a few more vector ops?
                            Medium_ for(int i=0; i<sz; ++i) {//vec
                                if (s[i] < (int)nstl::numeric_limits<data_t>::lowest())
                                    s[i] = (int)nstl::numeric_limits<data_t>::lowest();
                                if (s[i] > (int)nstl::numeric_limits<data_t>::max())
                                    s[i] = (int)nstl::numeric_limits<data_t>::max();
                            }
                        }
                        Medium_ for(int i=0; i<sz; ++i) {//unvec
                            d[i] = s[i];
                        }
#else
                        for (int ii=0; ii<sz; ii+=MVL) { // block and use vector version (inlined ?)
                            int const vl = (ii - sz >= MVL? MVL: ii - sz);
                            rs_float_to_int_to_notbigger<data_t>(&d[ii], &s[ii], vl);
                        }
#endif
                        Medium_ for(int i=0; i<sz; ++i) {//vec for s32
                            dst[data_off[i]] = d[i];
                        }
                    } else { // unrecognized type (bf16?) (code not used)
                        float s[stack_elems]; VREG(s);
                        Medium_ for(int i=0; i<sz; ++i) {//unvec for bf16
                            s[i] = src[data_off[i]];
                        }
                        Medium_ for(int i=0; i<sz; ++i) { //vec
                            s[i] = (s[i] > max_logf? float_inf : ::expf(s[i]));
                        }
                        Medium_ for(int i=0; i<sz; ++i) {//unvec for bf16
                            dst[data_off[i]] = s[i];
                        }
                    }
                } break;

                CASE(pow, s, alpha, beta);
#define SUBCASE2(ALG,WHICH,EXPR) case eltwise_##ALG + WHICH: { \
    Medium_ for(int i=0; i<sz; ++i) { \
        data_t const s  = src[data_off[i]]; \
        /*data_t &d = dst[data_off[i]];*/ \
        dst[data_off[i]] = EXPR; \
    }} break
#define SUBCASE(ALG,WHICH,...) SUBCASE2(ALG, WHICH, ve_##ALG##WHICH##_fwd(__VA_ARGS__))
                // actually some of these never execute because they
                // may be zero-preserving and use 'dense' impl
                SUBCASE(pow, 1, s, alpha, beta); // beta==-2.f
                SUBCASE(pow, 2, s, alpha, beta); // beta==-1.f
                SUBCASE(pow, 3, s, alpha, beta); // beta==0.f
                SUBCASE(pow, 4, s, alpha, beta); // beta==0.5f
                SUBCASE(pow, 5, s, alpha, beta); // beta==1.f
                SUBCASE(pow, 6, s, alpha, beta); // beta==1.5f
                SUBCASE(pow, 7, s, alpha, beta); // beta==2.f
                SUBCASE(pow, 8, s, alpha, beta); // beta==-ve odd int not -1, alpha >= 0.f
                SUBCASE(pow, 9, s, alpha, beta); // beta==-ve odd int not -1, other alpha
                SUBCASE(pow, 10, s, alpha, beta); // beta==any other
#undef SUBCASE
#undef SUBCASE2

                default: {
                    for(int i=0; i<sz; ++i) {
                        dst[data_off[i]] = data_t{0};
                    }}
                printf(" Error: TBD eltwise fwd generic for %s\n", dnnl_alg_kind2str(alg_kind));
                assert(!" TBD missing alg_kind case for ref eltwise fwd generic");
#undef CASE
#undef CASE2
            }
        });
#else //ELT_FWD_GEN_VEC == 3 // move switch out by 2 loops
#error "TBD"
#endif // ELT_FWD_GEN_VEC
}

template <impl::data_type_t data_type>
void ref_eltwise_fwd_t<data_type>::execute_forward_dense(
        const exec_ctx_t &ctx) const {
    bool constexpr is_int_dt = utils::one_of(data_type, data_type::s32, data_type::s8, data_type::u8);
    using cvt = Cvt<data_t, is_int_dt>;

    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);

    const auto alg_kind = pd()->desc()->alg_kind;
    const float alpha = pd()->desc()->alpha;
    const float beta = pd()->desc()->beta;

#define ELT_FWD_DEN_VEC 2
    // s8,u8,s32,f32 relu          | s8,u8,s32,f32 exp
    //          ? different -time:   24.4  24.3  24.3
    // 0 : 19.44 19.33 19.22 17.63 | 41.4  46,4  41.4  14.89
    // 1 :  1.37  1.45 0.073 0.070 | 10.63 10.67 10.01 0.14
#if ELT_FWD_DEN_VEC==0
    const memory_desc_wrapper data_d(pd()->src_md());
    if(0) printf(" fwd eltwise dense %d %s\n",
        ELT_FWD_DEN_VEC, (src==dst?"src=dst":""));
#else
    const memory_desc_wrapper_opt data_d(pd()->src_md());
    int const pow_subcase = eltwise_pow_subcase(alg_kind, alpha, beta);
    if(0) printf(" fwd eltwise dense %d %s subcase %d\n",
        ELT_FWD_DEN_VEC, (src==dst?"src=dst":""), pow_subcase);
#endif

    const ptrdiff_t nelems = static_cast<ptrdiff_t>(data_d.nelems(true));
    src += data_d.offset0();
    dst += data_d.offset0();

#define CASE2(ALG,EXPR) case eltwise_##ALG: { \
                /*asm("### eltwise fwd dense " #ALG);*/ \
                parallel_nd(nelems, [&](ptrdiff_t e) { \
                    data_t s = src[e]; \
                    data_t &d = dst[e]; \
                    EXPR; \
                }); \
    } break
#define CASE(ALG,...) CASE2(ALG, d = ve_##ALG##_fwd(__VA_ARGS__))

    // a simpler alt to CASE_XY and CASE_XY_NO_RS, with simpler parallelization
#define CASE_YX_FLT(ALG,EXPR) case eltwise_##ALG: { \
                parallel_nd(nelems, [&](ptrdiff_t e) { \
                    float x = src[e]; \
                    data_t &y = dst[e]; \
                    EXPR; \
                }); \
    } break
                // actually some of these never execute because they

        // eval EXPR as float, then round and saturate (if nec) to data_type
#define CASE2_CVT_RS(ALG,EXPR) case eltwise_##ALG: { \
                /*asm("### eltwise fwd dense " #ALG);*/ \
                parallel_nd(nelems, [&](ptrdiff_t e) { \
                    const float s = (float)src[e]; \
                    EXPR; \
                }); \
    } break
#define CASE_CVT_RS(ALG,...) CASE2_CVT_RS(ALG, dst[e] = cvt::rs(__VA_ARGS__))

        /** y=fn(x), where y and x \b may be aliased */
#define CASE_YX(ALG,...) /* ... can be simply y = expr(x) */ \
        case eltwise_##ALG: \
            parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk) { \
                dim_t const start = blk * blksz; \
                dim_t const end   = (start + blksz > nelems? nelems: start + blksz); \
                if (is_vectorizable<data_t>::value) { /* f32, s32 */ \
                    Medium_ for(dim_t e=start; e<end; ++e) { \
                        float x = src[e]; \
                        data_t& y = dst[e]; \
                        __VA_ARGS__; \
                    } \
                } else { \
                    int const sz = end - start; \
                    float f[stack_elems]; \
                    MFOR(i,sz) f[i] = src[start+i]; /* unvec */ \
                    MFOR(i,sz){ \
                        float x = f[i]; \
                        float& y = f[i]; \
                        __VA_ARGS__; \
                    } \
                    if(is_int_dt) { /* u8, s8, bf16 ? */ \
                        MFOR(i,sz) f[i] = cvt::int_rs(f[i]); /* fast approx */ \
                    } \
                    MFOR(i,sz) dst[start+i] = f[i]; /* unvec */ \
                } \
            }); \
            break
#define CASE_YX_NO_RS(ALG,...) /* ... can be simply y = expr(x) */ \
        case eltwise_##ALG: \
            parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk) { \
                dim_t const start = blk * blksz; \
                dim_t const end   = (start + blksz > nelems? nelems: start + blksz); \
                if (is_vectorizable<data_t>::value) { /* f32, s32 */ \
                    Medium_ for(dim_t e=start; e<end; ++e) { \
                        float x = src[e]; \
                        data_t& y = dst[e]; \
                        __VA_ARGS__; \
                    } \
                } else { \
                    int const sz = end - start; \
                    float f[stack_elems]; \
                    MFOR(i,sz) f[i] = src[start+i]; /* unvec */ \
                    MFOR(i,sz){ \
                        float x = f[i]; \
                        float& y = f[i]; \
                        __VA_ARGS__; \
                    } \
                    /*MFOR(i,sz) f[i] = cvt::int_rs(f[i]);*/ \
                    MFOR(i,sz) dst[start+i] = f[i]; /* unvec */ \
                } \
            }); \
            break

    // a fast path for relu as the most popular activation
    if (alg_kind == eltwise_relu) {
        // 0.0688
        parallel_nd( nelems, [&](ptrdiff_t e) { dst[e] = relu_fwd(src[e], alpha); });
        // 0.0693, 0.0690 // XXX retry with bf16 on x86 XXX
        //parallel_nd( nelems, [&](ptrdiff_t e) { float fs = src[e];
        //             dst[e] = (data_t)(fs > 0.f? fs: alpha * fs);});
        return;
    }

#if ELT_FWD_DEN_VEC==0 // original: nc++ does not vectorize this (some unvectorizable func calls)
    parallel_nd(nelems, [&](ptrdiff_t e) {
        const data_t s = src[e];
#if 0
        dst[e] = compute_eltwise_scalar_fwd(alg_kind, s, alpha, beta);
#else // 
        float f = compute_eltwise_scalar_fwd( alg_kind, s, alpha, beta);
        if (is_int_dt) f = cvt::rs(f);
        dst[e] = f;
#endif
    });
#elif ELT_FWD_DEN_VEC==1
    //
    // This approach blocks not by MVL but some larger stack-centric size
    //
    int const blksz = stack_friendly_blksz(nelems);
    assert( blksz <= /*constexpr*/ stack_elems );

    parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk) {
        dim_t const start = blk * blksz;
        dim_t const end   = (start + blksz > nelems? nelems: start + blksz);
        int const sz = end - start;
        float s[stack_elems], d[stack_elems];
        Medium_ for (int i=0; i<sz; ++i)
            s[i] = src[start+i];
        compute_eltwise_vector_fwd(alg_kind, alpha, beta,
            1.0f, d, s, sz, pow_subcase);
        if (is_int_dt) Medium_ for (int i=0; i<sz; ++i)
                d[i] = cvt::rs(d[i]);
        
        Medium_ for (int i=0; i<sz; ++i)
                dst[start+i] = d[i];
    });
#elif ELT_FWD_DEN_VEC==2
    int const blksz = stack_friendly_blksz(nelems);
    assert( blksz <= /*constexpr*/ stack_elems );
    switch (alg_kind + pow_subcase) {
        //case eltwise_relu: d = relu_fwd(s, alpha); break;
        //CASE(linear, s, alpha, beta); // 0.069
        CASE2(linear, d = alpha * s + beta); // 0.059

        case eltwise_tanh_use_dst_for_bwd: // fall-through
        // 1.73 1.81 0.217 0.212 for s8,u8,s32,f32
        //CASE(tanh, s); // 1.71 1.79 0.216 0.212
        CASE2(tanh, d = ::tanhf(s)); // 1.70 1.78 0.212 0.212
        //CASE_YX_NO_RS(tanh, y = ::tanhf(x)); // 1.87 1.94 0.215 0.216

        //CASE(square, s); // 0.069
        CASE2(square, d = s * s); // 0.0678 0.0681

        //CASE(abs, s); // 0.072
        //CASE2(abs, if (s < data_t{0}) s = -s; d = s); // 0.0680 0.0677
        CASE_YX_NO_RS(abs, if (x < 0.f) x = -x; y = x); // 0.0673, go figure

        //CASE2(elu_use_dst_for_bwd, d = ve_elu_fwd(s, alpha));
        case eltwise_elu_use_dst_for_bwd:
        // 12.57 12.72 0.340 0.335
        //CASE(elu, s, alpha); // 12.57 12.71 0.322 0.317
        // 1.99 2.07 0.345 0.342
        // 2.01 2.10 0.346 0.343
        CASE_YX_NO_RS(elu, y = (x > 0.f? x: alpha * ::expm1f(x)));

        case eltwise_sqrt_use_dst_for_bwd:
        // 22.47 22.43 22.35 0.081 very old DEN_VEC u8,s8,s32,f32 ms
        // 15.10 14.97 14.95 0.09
        //CASE_CVT_RS(sqrt, ::sqrtf(s));
        // wrong, no rs for int:
        //CASE(sqrt, s); 
        // 1.75 1.82 0.083 0.082
        CASE_YX(sqrt, y = ::sqrtf(x));

        case eltwise_exp_use_dst_for_bwd:
        // 1.79 1.87 0.109 0.107
        CASE_YX(exp,
            float constexpr max_logf  = 87.f; // good enough
            float constexpr float_inf = HUGE_VALF;
            y = (x > max_logf? float_inf: ::expf(x))
            );

        CASE(bounded_relu, s, alpha); // 0.0700
        // 0.0733
        // check if ok for bf16 (on x86 XXX)
        //CASE2(bounded_relu, d = (s > data_t{alpha}? data_t{alpha}: s > data_t{0}? s: data_t{0}));
        //0.0828
        //CASE_YX_NO_RS(bounded_relu, y = (x > alpha? alpha: x > 0.f? x: 0.f));

        //CASE(soft_relu, s); // 0.184
        CASE_YX_NO_RS(soft_relu, // 0.179
            float constexpr max_logf  = 87.f;
            y = (x < max_logf? ::logf(1.0f + ::expf(x)): x));
        //CASE_YX_NO_RS(soft_relu, // 0.179, but wrong result?
        //    float constexpr max_logf  = 87.f;
        //    y = (x < max_logf? ::log1pf(x): x));

        case eltwise_logistic_use_dst_for_bwd:
        CASE(logistic, s); // 1.50 1.59 0.128 0.125 nothing much better
        // 1.76 1.84 0.117 0.112
        //CASE_YX_NO_RS(logistic, x = -x; if (x > 87.0f) x = 87.0f; x =  ::expf(x);
        //    y = 1.f / (1.f + x));
        // 1.79 1.87 0.129 0.126
        //CASE_YX(logistic, y = ve_logistic_fwd<float>(x));

        //CASE(gelu_tanh, s); // 0.251, 0.250
        //CASE2(gelu_tanh, // 0.247
        //      constexpr float sqrt_2_over_pi = 0.797884;
        //      constexpr float fitting_const = 0.044715;
        //      const float v = tanh_fwd(sqrt_2_over_pi * s * (1 + fitting_const * s * s));
        //      d =  s * (v * 0.5f + 0.5f));
        //CASE_YX_NO_RS(gelu_tanh, // 0.247, 0.247, 0.250
        //      constexpr float sqrt_2_over_pi = 0.797884;
        //      constexpr float fitting_const = 0.044715;
        //      const float v = ::tanhf(sqrt_2_over_pi * x * (fitting_const * (x * x) + 1.f));
        //      y =  x * (v * 0.5f + 0.5f));
        CASE_YX_FLT(gelu_tanh, // 0.246
              constexpr float sqrt_2_over_pi = 0.797884;
              constexpr float fitting_const = 0.044715;
              const float v = ::tanhf(sqrt_2_over_pi * x * (fitting_const * (x * x) + 1.f));
              y =  x * (v * 0.5f + 0.5f));

        CASE(swish, s, alpha); // 0.114, 0.112
        //CASE2(swish, d = s / (1.f + ::expf(-alpha * s))); // 0.113
        //CASE_YX_NO_RS(swish, y = x / (1.f + ::expf(-alpha * x))); // 0.113
        //CASE_YX_FLT(swish, y = x / (1.f + ::expf(-alpha * x))); // 0.114, 0.114

        //CASE(log, s); // 0.117, 0.112
        CASE2(log, d = ::logf(s)); // 0.113
        //CASE_YX_NO_RS(log, y = ::logf(x)); // 0.112
        //CASE_YX_FLT(log, y = ::logf(x)); // 0.115, 0.114

        CASE(clip, s, alpha, beta); // 0.0773, 0.0760
        //CASE2(clip, float fs = s; // 0.0805
        //      d = (fs > beta? beta: fs > alpha? fs: alpha));
        //CASE_YX_NO_RS(clip, y = (x > beta? beta: x > alpha? x: alpha)); // 0.083
        //CASE_YX_FLT(clip, y = (x > beta? beta: x > alpha? x: alpha)); // 0.0798, 0.0795

        CASE(gelu_erf, s); // 0.326, 0.325
        //CASE2(gelu_erf,  // 0.325
        //      constexpr float sqrt_2_over_2 = 0.707106769084930419921875f;
        //      float v = s * sqrt_2_over_2;
        //      d = (data_t)(0.5f * s * (1.f + ::erff(v))));
        //CASE_YX_NO_RS(gelu_erf,  // 0.326
        //      constexpr float sqrt_2_over_2 = 0.707106769084930419921875f;
        //      y = 0.5f * x * (1.f + ::erff(sqrt_2_over_2 * x)));
        //CASE_YX_FLT(gelu_erf,  // 0.325
        //      constexpr float sqrt_2_over_2 = 0.707106769084930419921875f;
        //      y = 0.5f * x * (1.f + ::erff(sqrt_2_over_2 * x)));

#define CASE_SPECIAL_BEG(ALG) \
        case eltwise_##ALG: \
        { \
            parallel(0, [&src,&dst,&nelems](const int ithr, const int nthr) { \
                dim_t start = 0, end = 0; \
                balance211(nelems, nthr, ithr, start, end); \
                if (start == end) return
#define CASE_SPECIAL_END }); } break

        //CASE2(relu_use_dst_for_bwd, d = ve_relu_fwd(s, alpha)); // 0.075
        //CASE2(relu_use_dst_for_bwd, float fs = s; // 1.50 1.61 0.0711 0.0693
        //      dst[e] = (data_t)(fs > 0.f? fs: fs * alpha));
        //CASE_YX_NO_RS(relu_use_dst_for_bwd, // 3.02 2.94 0.0710 0.0685 ! ?
        //             y = (data_t)(x > 0.f? x: alpha * x));
        CASE_YX_FLT(relu_use_dst_for_bwd, //
                     y = (data_t)(x > 0.f? x: alpha * x));

        CASE(pow, s, alpha, beta); // for completeness
#define SUBCASE2(ALG,WHICH,EXPR) case eltwise_##ALG + WHICH: { \
    /*asm("### eltwise fwd dense " #ALG);*/ \
    parallel_nd(nelems, [&](ptrdiff_t e) { \
                const data_t s = src[e]; \
                data_t &d = dst[e]; \
                EXPR; \
                }); \
} break
#define SUBCASE(ALG,WHICH,...) SUBCASE2(ALG, WHICH, d = ve_##ALG##WHICH##_fwd(__VA_ARGS__))
        SUBCASE(pow, 1, s, alpha, beta); // beta==-2.f (generic impl)
        SUBCASE(pow, 2, s, alpha, beta); // beta==-1.f (generic impl)
        SUBCASE(pow, 3, s, alpha, beta); // beta==0.f (generic impl)
        SUBCASE(pow, 4, s, alpha, beta); // beta==0.5f  0.235
        SUBCASE(pow, 5, s, alpha, beta); // beta==1.f   0.0895
        SUBCASE(pow, 6, s, alpha, beta); // beta==1.5f  0.0703
        SUBCASE(pow, 7, s, alpha, beta); // beta==2.f   0.0934
        SUBCASE(pow, 8, s, alpha, beta); // beta==-ve odd int not -1, alpha >= 0.f
        SUBCASE(pow, 9, s, alpha, beta); // beta==-ve odd int not -1, other alpha
        SUBCASE(pow, 10, s, alpha, beta); // beta==any other
#undef SUBCASE
#undef SUBCASE2

        default: assert(!"unknown eltwise alg_kind");
        parallel_nd(nelems, [&](ptrdiff_t e) {
                dst[e] = 0.f;
                });
    }
#undef CASE
#undef CASE2
#undef CASE_SPECIAL_BEG
#undef CASE_SPECIAL_END
#else
#error "ELT_FWD_DEN_VEC value TBD"
#endif // ELT_FWD_DEN_VEC
}

template <impl::data_type_t data_type>
void ref_eltwise_bwd_t<data_type>::execute_backward_generic(
        const exec_ctx_t &ctx) const {
    /* fast return */
    if (pd()->has_zero_dim_memory()) return;

    auto src = pd()->use_dst() ? CTX_IN_MEM(const data_t *, DNNL_ARG_DST)
                               : CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto diff_dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DIFF_DST);
    auto diff_src = CTX_OUT_MEM(data_t *, DNNL_ARG_DIFF_SRC);

#define ELT_BKW_GEN_VEC 1
    // --eltwise --dir=BWD_D --tag=aBx16b,aBx8b --alg=log --alpha=0 --beta=0 45x87x33x3
    // 0 : 266 266 ms (--mode=C timings)
    // 1 : (nonvec) 24.9 24.9 ms 
    // 1 : (   vec) 5.15 5.19 ms ~ 50x speedup from orig (much more could be done for VE)
#if !ELT_BKW_GEN_VEC
    const memory_desc_wrapper data_d(pd()->src_md());
    const memory_desc_wrapper diff_data_d(pd()->diff_src_md());
#else
    const memory_desc_wrapper_opt data_d(pd()->src_md());
    const memory_desc_wrapper_opt diff_data_d(pd()->diff_src_md());
#endif

    const dim_t MB = pd()->MB();
    const dim_t C = pd()->C();
    const dim_t D = pd()->D();
    const dim_t H = pd()->H();
    const dim_t W = pd()->W();
    const auto alg_kind = pd()->desc()->alg_kind;
    const float alpha = pd()->desc()->alpha;
    const float beta = pd()->desc()->beta;
    const int ndims = pd()->desc()->data_desc.ndims;
    //printf(" bwd eltwise generic nelems=%ld nelems(true)=%ld NCDHW=%ld\n",
    //        (long)data_d.nelems(false), (long)data_d.nelems(true),
    //        (long)MB*C*D*H*W );
    // some benchdnn cases that excercise bwd generic eltwise:
    //           --tag=aBx16b,aBx8b --alg=log,sqrt

#if !ELT_BKW_GEN_VEC
    parallel_nd(
            MB, C, D, H, W, [&](dim_t n, dim_t c, dim_t d, dim_t h, dim_t w) {
                auto data_off = DATA_OFF(data_d, n, c, d, h, w);
                auto diff_data_off = DATA_OFF(diff_data_d, n, c, d, h, w);
                //printf( " %-8ld data_off=%-8ld diff_data_off=%-8ld ncdhw{%ld,%ld,%ld,%ld,%ld}\n",
                //        (((n * C + c) * D + d) * H + h) * W +w,
                //        data_off, diff_data_off, n,c,d,h,w );
                data_t s = src[data_off];
                data_t dd = diff_dst[diff_data_off];
                data_t &ds = diff_src[diff_data_off];
                ds = compute_eltwise_scalar_bwd(alg_kind, dd, s, alpha, beta);
            });
#else
    // 1. block over MB and C (and D?), see src/cpu/ref_softmax (or ve/ version?) to
    // nelems ~ logical number of elements
    const ptrdiff_t nelems = static_cast<ptrdiff_t>(data_d.nelems(false));
    parallel(0, [&](const int ithr, const int nthr) {
            dim_t start = 0, end = 0;
            balance211(nelems, nthr, ithr, start, end);
            if (start == end) return;
#define MVL 256
            dim_t loff[MVL]; // array of logical offsets
            size_t data_off[MVL];      // array of physical offsets
            size_t diff_data_off[MVL]; // array of physical offsets
            // also possible: coords iter and vec_off_p or so
            for (dim_t i = start; i < end; i+=MVL) {
                dim_t const vl = (end - i > MVL? MVL: end - i);
                ShortLoop() for(dim_t j=0; j<vl; ++j)
                    loff[j] = i+j;
                // vectorized offset calcs
                data_d     .vec_off_l( &loff[0], vl, (dim_t*)&data_off[0]);
                // "Inline halted: code size" ...
                diff_data_d.vec_off_l( &loff[0], vl, (dim_t*)&diff_data_off[0]);
#if 0 // unvectorized initial version :
                ShortLoop() for(dim_t j=0; j<vl; ++j) {
                    //printf( "%-8ld data_off=%-8ld diff_data_off=%-8ld start,end,i,j=%ld,%ld,%ld,%ld\n",
                    //        loff[j], data_off[j], diff_data_off[j], start, end, i, j);
                    data_t s   = src     [data_off     [j]];
                    data_t dd  = diff_dst[diff_data_off[j]];
                    data_t &ds = diff_src[diff_data_off[j]];
                    ds = compute_eltwise_scalar_bwd(alg_kind, dd, s, alpha, beta);
                }
#else // What alg_kind does bwd generic hit, for vectorization?
                // pow, sqrt, log, sqrt_dst for sure
                // nc++ prefers cases outside of loop so function calls
                //      can individually be inlined & vectorized.
                //
                // TODO compare with moving switch outside one more for loop
                //
                switch(alg_kind) {
#define CASE_BEG(ALG_KIND) \
                    case ALG_KIND: \
                    { \
                            ShortLoop() for(dim_t j=0; j<vl; ++j) { \
                                data_t s   = src     [data_off     [j]]; \
                                data_t dd  = diff_dst[diff_data_off[j]]; \
                                data_t &ds = diff_src[diff_data_off[j]]
#define CASE_END }} break
#define SRC src[data_off[j]]
#define DIFF_DST diff_dst[diff_data_off[j]]
#define DIFF_SRC diff_src[diff_data_off[j]]

#define CASE2(ALG,EXPR) case eltwise_##ALG: { \
    ShortLoop() for(dim_t j=0; j<vl; ++j) { \
        data_t s   = src     [data_off     [j]]; \
        data_t dd  = diff_dst[diff_data_off[j]]; \
        data_t &ds = diff_src[diff_data_off[j]]; \
        EXPR; /* ex. ds = relu_bwd(dd,s,alpha); */ \
    }} break
#define CASE(ALG,...) CASE2(ALG, ds = ALG##_bwd(__VA_ARGS__))

#if 1 // full set of cases: (as in dense case, below)
        CASE(relu, dd, s, alpha);
        CASE(tanh, dd, s);
        CASE(elu, dd, s, alpha);
        CASE(square, dd, s);
        CASE(abs, dd, s);
        CASE(sqrt, dd, s);
        CASE(linear, dd, s, alpha, beta);
        //
        CASE(bounded_relu, dd, s, alpha);
        CASE(soft_relu, dd, s);
        CASE(logistic, dd, s);
        // ovflw cases: CASE(exp, dd, s);
        case eltwise_exp: {
            float const float_inf = HUGE_VALF;
            ShortLoop() for(dim_t j=0; j<vl; ++j) {
                data_t const s   = src     [data_off     [j]];
                DIFF_SRC = (data_t)( DIFF_DST *
                    (s > 87.0f? float_inf : std::expf(s))
                    );
            }} break;
        //
        CASE(gelu_tanh, dd, s);
        CASE(swish, dd, s, alpha);
        CASE(log, dd, s);
        CASE(clip, dd, s, alpha, beta);
        CASE(pow, dd, s, alpha, beta);
        CASE(gelu_erf, dd, s);
        //
        CASE2(relu_use_dst_for_bwd, ds = relu_bwd_use_dst(dd, s, alpha));
        CASE2(tanh_use_dst_for_bwd, ds = tanh_bwd_use_dst(dd, s));
        CASE2(elu_use_dst_for_bwd, ds = elu_bwd_use_dst(dd, s, alpha));
        CASE2(sqrt_use_dst_for_bwd, ds = sqrt_bwd_use_dst(dd, s));
        CASE2(logistic_use_dst_for_bwd, ds = logistic_bwd_use_dst(dd, s));
        CASE2(exp_use_dst_for_bwd, ds = exp_bwd_use_dst(dd, s));

#else // an initial set of encountered cases ..

#if 1
                    CASE(pow, dd, s, alpha, beta);
#elif 1 // pow_bwd ... "Structure pointer inhibits" message (for bf16?)
                    // --tag=aBx16b --alg=pow --alpha=0.25 --beta=3.14 45x87x33x3
                    // 36.9 ms
                    CASE_BEG(eltwise_pow);
                    ds = pow_bwd(dd, s, alpha, beta);
                    CASE_END;
#elif 1 // hmm, is it template depth?
                    // this one is still 36.9 ms
                    case eltwise_pow:
                    {
                        if (beta==0) {
                            ShortLoop() for(dim_t j=0; j<vl; ++j) {
                                DIFF_SRC = 0;
                            }
                        }else{
                            // XXX alpha*beta NOT moved out and up :(
                            ShortLoop() for(dim_t j=0; j<vl; ++j) {
                                DIFF_SRC = DIFF_DST * pow_fwd(SRC, alpha*beta, beta-1);
                            }
                        }
                    } break;
#endif

                    CASE(sqrt, dd, s);
                    //CASE_BEG(eltwise_sqrt);
                    //ds = sqrt_bwd(dd, s);
                    //CASE_END;

                    CASE(gelu_tanh, dd, s);
                    //CASE_BEG(eltwise_gelu_tanh);
                    //ds = gelu_tanh_bwd(dd, s);
                    //CASE_END;

#if 1
                    CASE(log, dd, s);
#elif 1
                    CASE_BEG(eltwise_log);
                    ds = log_bwd(dd, s);
                    CASE_END;
#elif 1 // longhand, for compiler diagnostics...
                    case eltwise_log:
                    {
                        ShortLoop()//;
                        for(dim_t j=0; j<vl; ++j) {
                            DIFF_SRC = log_bwd( DIFF_DST, SRC );
                        }
                    } break;
#endif

                    CASE_BEG(eltwise_sqrt_use_dst_for_bwd);
                    ds = sqrt_bwd_use_dst(dd, s);
                    CASE_END;

#endif // an initial set of encountered cases ..

                    default:
                    ShortLoop() for(dim_t j=0; j<vl; ++j) {
                        //data_t s   = src     [data_off     [j]];
                        //data_t dd  = diff_dst[diff_data_off[j]];
                        data_t &ds = diff_src[diff_data_off[j]];
                        ds = data_t{0};
                    }
                    printf("\nError: unhandled elwise bwd generic case %s\n",
                            dnnl_alg_kind2str(alg_kind));
                    //assert(!"unhandled eltwise bwd generic case");
                }
#endif
            }
    });
#undef CASE_BEG
#undef CASE_END
#undef SRC
#undef DIFF_DST
#undef DIFF_SRC
#undef CASE
#undef CASE2
#endif // ELT_BKW_GEN_VEC
#undef ELT_BKW_GEN_VEC
}

//template <>
//void ref_eltwise_bwd_t<data_type::f32>::execute_backward_dense(
// Original had an f32 partial specialization, which was slow.
// nc++ left the math inlines as fn calls, so had only scalar loops.
//
// However [reason unknown] when non-specialized, the inlines are expanded
// and VE begins to vectorize nicely.
//
// The remaining bf16 specialization is of little interest for VE
//
template <impl::data_type_t data_type>
void ref_eltwise_bwd_t<data_type>::execute_backward_dense(
        const exec_ctx_t &ctx) const {
    auto src = pd()->use_dst() ? CTX_IN_MEM(const data_t *, DNNL_ARG_DST)
                               : CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto diff_dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DIFF_DST);
    auto diff_src = CTX_OUT_MEM(data_t *, DNNL_ARG_DIFF_SRC);

    const memory_desc_wrapper data_d(pd()->src_md());
    const memory_desc_wrapper diff_data_d(pd()->diff_src_md());

    const auto nelems = data_d.nelems(true);
    const auto alg_kind = pd()->desc()->alg_kind;
    const float alpha = pd()->desc()->alpha;
    const float beta = pd()->desc()->beta;

    src += data_d.offset0();
    diff_dst += diff_data_d.offset0();
    diff_src += diff_data_d.offset0();

#if 0 // orig: nc++ did not vectorize if some 'switch' cases have func calls
    parallel(0, [&](const int ithr, const int nthr) {
        dim_t start = 0, end = 0;
        balance211(nelems, nthr, ithr, start, end);
        if (start == end) return;

        for (dim_t i = start; i < end; i++) {
            diff_src[i] = compute_eltwise_scalar_bwd(
                    alg_kind, diff_dst[i], src[i], alpha, beta);
        }
    });
#else
    switch(alg_kind) {
        // TODO comparing ovhd (small size src), I guess it might be good
        //      to compare with the non-balancing version of CASE in FWD code
#define CASE2(ALG,EXPR) case eltwise_##ALG: { \
    parallel(0, [&](const int ithr, const int nthr) { \
            dim_t start = 0, end = 0; \
            balance211(nelems, nthr, ithr, start, end); \
            if (start == end) return; \
            \
            for (dim_t i = start; i < end; i++) { \
                auto const s = src[i]; \
                auto const dd = diff_dst[i]; \
                data_t &ds = diff_src[i]; \
                EXPR; /*ex. ds = relu_bwd(dd,s,alpha); */ \
            } \
        }); \
    } break
#define CASE(ALG,...) CASE2(ALG, ds = ALG##_bwd(__VA_ARGS__))
#if 0
        CASE(relu, dd, s, alpha);
#else // original longhand equivalent (for looking at asm code)
        case eltwise_relu: {
            parallel(0, [&](const int ithr, const int nthr) {
                dim_t start = 0, end = 0;
                balance211(nelems, nthr, ithr, start, end);
                if (start != end) {
                    for (dim_t i = start; i < end; i++) {
                        diff_src[i] = relu_bwd(diff_dst[i], src[i], alpha);
                    }
                }
            });
        } break;
#endif
        CASE(tanh, dd, s);
        CASE(elu, dd, s, alpha);
        CASE(square, dd, s);
        CASE(abs, dd, s);
        CASE(sqrt, dd, s);
        CASE(linear, dd, s, alpha, beta);
        //
        CASE(bounded_relu, dd, s, alpha);
        CASE(soft_relu, dd, s);
        CASE(logistic, dd, s);
        // ovflw cases: CASE(exp, dd, s);
        case eltwise_exp: {
            float const float_inf = HUGE_VALF;
            parallel_nd(nelems, [&](ptrdiff_t e) {
                auto const s = src[e];
                auto const dd = diff_dst[e];
                data_t &ds = diff_src[e];
                ds = (data_t)( dd *
                        (s > 87.0f? float_inf : std::expf(s))
                        );
            });
            } break;
        //
        CASE(gelu_tanh, dd, s);
        CASE(swish, dd, s, alpha);
        CASE(log, dd, s);
        CASE(clip, dd, s, alpha, beta);
        CASE(pow, dd, s, alpha, beta);
        CASE(gelu_erf, dd, s);
        //
        CASE2(relu_use_dst_for_bwd, ds = relu_bwd_use_dst(dd, s, alpha));
        CASE2(tanh_use_dst_for_bwd, ds = tanh_bwd_use_dst(dd, s));
        CASE2(elu_use_dst_for_bwd, ds = elu_bwd_use_dst(dd, s, alpha));
        CASE2(sqrt_use_dst_for_bwd, ds = sqrt_bwd_use_dst(dd, s));
        CASE2(logistic_use_dst_for_bwd, ds = logistic_bwd_use_dst(dd, s));
        CASE2(exp_use_dst_for_bwd, ds = exp_bwd_use_dst(dd, s));
    }
#undef CASE
#undef CASE2
#endif
}

// VE doesn't care about bf16 impl
template <>
void ref_eltwise_bwd_t<data_type::bf16>::execute_backward_dense(
        const exec_ctx_t &ctx) const {
    using namespace memory_tracking::names;

    auto src = pd()->use_dst() ? CTX_IN_MEM(const data_t *, DNNL_ARG_DST)
                               : CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto diff_dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DIFF_DST);
    auto diff_src = CTX_OUT_MEM(data_t *, DNNL_ARG_DIFF_SRC);

    auto scratchpad = ctx.get_scratchpad_grantor();
    auto s_f = scratchpad.template get<float>(key_eltwise_src);
    auto dd_f = scratchpad.template get<float>(key_eltwise_diff_dst);

    const memory_desc_wrapper data_d(pd()->src_md());
    const memory_desc_wrapper diff_data_d(pd()->diff_src_md());

    const auto nelems = data_d.nelems(true);
    const auto alg_kind = pd()->desc()->alg_kind;
    const float alpha = pd()->desc()->alpha;
    const float beta = pd()->desc()->beta;

    src += data_d.offset0();
    diff_dst += diff_data_d.offset0();
    diff_src += diff_data_d.offset0();

    parallel(0, [&](const int ithr, const int nthr) {
        dim_t start = 0, end = 0;
        balance211(nelems, nthr, ithr, start, end);
        if (start == end) return;

        cvt_bfloat16_to_float(s_f + start, src + start, end - start);
        cvt_bfloat16_to_float(dd_f + start, diff_dst + start, end - start);

        for (dim_t i = start; i < end; i++) {
            dd_f[i] = compute_eltwise_scalar_bwd(
                    alg_kind, dd_f[i], s_f[i], alpha, beta);
        }

        cvt_float_to_bfloat16(diff_src + start, dd_f + start, end - start);
    });
}

template struct ref_eltwise_fwd_t<data_type::f32>;
template struct ref_eltwise_fwd_t<data_type::bf16>;
template struct ref_eltwise_fwd_t<data_type::s32>;
template struct ref_eltwise_fwd_t<data_type::s8>;
template struct ref_eltwise_fwd_t<data_type::u8>;

template struct ref_eltwise_bwd_t<data_type::f32>;
template struct ref_eltwise_bwd_t<data_type::bf16>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino+=t0,+2s,jl1,(\:s,N-s
