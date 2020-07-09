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

/** stack usage threshold (max array size) for channel offsets.
 *
 * \todo VE blocksz chooser for tmp arrays should have use a
 * template compiler-time const max size. Best value depends
 * on across/within/fwd/bwd. (Significant speed differences).
 * Compile-time bound on tmp stack arrays is frequently req'd
 * to allow nc++ to vectorize.
 *
 */
// oh, pragmas need this version (actual number, not constexpr)
#define STACK_ELEMS 4096
static dim_t constexpr stack_elems = STACK_ELEMS; // a generally decent value

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
        case eltwise_relu: d = relu_fwd(s, alpha); break;
        case eltwise_tanh: d = tanh_fwd(s); break;
        case eltwise_elu: d = elu_fwd(s, alpha); break;
        case eltwise_square: d = square_fwd(s); break;
        case eltwise_abs: d = abs_fwd(s); break;
        case eltwise_sqrt: d = sqrt_fwd(s); break;
        case eltwise_linear: d = linear_fwd(s, alpha, beta); break;
        case eltwise_bounded_relu: d = bounded_relu_fwd(s, alpha); break;
        case eltwise_soft_relu: d = soft_relu_fwd(s); break;
        case eltwise_logistic: d = logistic_fwd(s); break;
        case eltwise_exp: d = exp_fwd(s); break;
        case eltwise_gelu_tanh: d = gelu_tanh_fwd(s); break;
        case eltwise_swish: d = swish_fwd(s, alpha); break;
        case eltwise_log: d = log_fwd(s); break;
        case eltwise_clip: d = clip_fwd(s, alpha, beta); break;
        case eltwise_pow: d = pow_fwd(s, alpha, beta); break;
        case eltwise_gelu_erf: d = gelu_erf_fwd(s); break;

        case eltwise_relu_use_dst_for_bwd: d = relu_fwd(s, alpha); break;
        case eltwise_tanh_use_dst_for_bwd: d = tanh_fwd(s); break;
        case eltwise_elu_use_dst_for_bwd: d = elu_fwd(s, alpha); break;
        case eltwise_sqrt_use_dst_for_bwd: d = sqrt_fwd(s); break;
        case eltwise_logistic_use_dst_for_bwd: d = logistic_fwd(s); break;
        case eltwise_exp_use_dst_for_bwd: d = exp_fwd(s); break;

        default: assert(!"unknown eltwise alg_kind");
    }
    return d;
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

//
// TODO vectorize this one too  (same approach)
// 1. amalgamate c<C loops
// 2. inline the lamda (remove fn call)
// 3. move switch(alg_kind) outside the parallel_nd so most
//    math fns can be inlined (and vectorized)
//
// pretty much the same as for forward_dense
//
template <impl::data_type_t data_type>
void ref_eltwise_fwd_t<data_type>::execute_forward_nCspBc_padded(
        const exec_ctx_t &ctx) const {
    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);

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

    // unvectorizable on VE (compute_eltwise_scalar_fwd function reference)
    auto ker = [=](data_t &d, data_t s) {
        d = compute_eltwise_scalar_fwd(alg_kind, s, alpha, beta);
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
}

template <impl::data_type_t data_type>
void ref_eltwise_fwd_t<data_type>::execute_forward_generic(
        const exec_ctx_t &ctx) const {
    /* fast return */
    if (pd()->has_zero_dim_memory()) return;

    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);
#define ELT_FWD_GEN_VEC 2
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

    //printf("fwd eltwise generic\n");
    // How to cover this code (not possible in default benchdnn eltwise tests?)
    //   examples:
    // --dir=FWD_D --tag=ABx16a16b --alg=log --alpha=0 --beta=0 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=linear --alpha=0 --beta=0.25 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=linear --alpha=0.22 --beta=0.33 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=clip --alpha=0.11 --beta=0.88 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=log,sqrt --alpha=0 --beta=0 45x87x33x3
    // --dir=FWD_D --tag=ABx16a16b --alg=pow --alpha=0.25 --beta=3.14 45x87x33x3

#if !ELT_FWD_GEN_VEC
    // --dir=FWD_D --tag=ABx16a16b --alg=log --alpha=0 --beta=0 45x87x33x3
    // 19.15 ms
    parallel_nd(
            MB, C, D, H, W, [&](dim_t n, dim_t c, dim_t d, dim_t h, dim_t w) {
                auto data_off = DATA_OFF(data_d, n, c, d, h, w);
                dst[data_off] = compute_eltwise_scalar_fwd(
                        alg_kind, src[data_off], alpha, beta);
            });
#elif ELT_FWD_GEN_VEC == 1 // based on backward "first attempt"
    // 5.5 ms
    const ptrdiff_t nelems = static_cast<ptrdiff_t>(data_d.nelems(false));
    parallel(0, [&](const int ithr, const int nthr) {
            dim_t start = 0, end = 0;
            balance211(nelems, nthr, ithr, start, end);
            if (start == end) return;
            dim_t loff[MVL]; // array of logical offsets
            size_t data_off[MVL];      // array of physical offsets
            // also possible: coords iter and vec_off_p or so
            for (dim_t i = start; i < end; i+=MVL) {
                dim_t const vl = (end - i > MVL? MVL: end - i);
                ShortLoop() for(dim_t j=0; j<vl; ++j)
                    loff[j] = i+j;
                // vectorized offset calcs
                data_d.vec_off_l( &loff[0], vl, (dim_t*)&data_off[0]);
                ShortLoop() for(dim_t j=0; j<vl; ++j) {
                    data_t s  = src[data_off[j]];
                    data_t &d = dst[data_off[j]];
                    d = compute_eltwise_scalar_fwd(alg_kind, s, alpha, beta);
                }
            }
    });
#elif ELT_FWD_GEN_VEC == 2 // use larger inner loop size --> 1.01 ms
    //
    // This approach blocks not by MVL but some larger stack-centric size
    //
    const ptrdiff_t nelems = static_cast<ptrdiff_t>(data_d.nelems(false));
    dim_t const blksz = stack_friendly_blksz(nelems);
    assert( blksz <= /*constexpr*/ stack_elems );
    //printf(" nelems=%ld blksz=%ld\n",nelems, blksz);
#define Medium_ PragmaQuote(_NEC loop_count(STACK_ELEMS))
#if 1
    //
    //  0.92 ms ~ 10% faster  moving 'case' outside parallel_nd
    //
    if (alg_kind == eltwise_log) {
        parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk)
                {
                dim_t const start = blk * blksz;
                dim_t const end   = (start + blksz > nelems? nelems: start + blksz);
                dim_t const sz = end - start;
                //assert( sz <= /*constexpr*/ stack_elems );
                // Only need sz, but fixed-size array allows nc++ to make ivdep assumptions
                dim_t loff[stack_elems];
                size_t data_off[stack_elems];

                Medium_ for (int i=0; i<sz; ++i)
                loff[i] = start + i; // a win if sz > ~1
                data_d.vec_off_l( &loff[0], sz, (dim_t*)&data_off[0] );

                Medium_ for(dim_t i=0; i<sz; ++i) {
                    data_t s  = src[data_off[i]];
                    data_t &d = dst[data_off[i]];
                    d = log_fwd(s);
                }
                });
    }else
#endif
    parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk)
    {
        dim_t const start = blk * blksz;
        dim_t const end   = (start + blksz > nelems? nelems: start + blksz);
        dim_t const sz = end - start;
        //assert( sz <= /*constexpr*/ stack_elems );
        // Only need sz, butfixed-size array allows nc++ to make ivdep assumptions
        dim_t loff[stack_elems];
        size_t data_off[stack_elems];

#define Medium_ PragmaQuote(_NEC loop_count(STACK_ELEMS))
        Medium_ for (int i=0; i<sz; ++i)
            loff[i] = start + i; // a win if sz > ~1
        data_d.vec_off_l( &loff[0], sz, (dim_t*)&data_off[0] );

        switch(alg_kind){
#define CASE2(ALG,EXPR) case eltwise_##ALG: { \
            Medium_ for(dim_t i=0; i<sz; ++i) { \
                data_t s  = src[data_off[i]]; \
                /*data_t &d = dst[data_off[i]];*/ \
                dst[data_off[i]] = EXPR; \
            }} break
#define CASE(ALG,...) CASE2(ALG, ALG##_fwd(__VA_ARGS__))
#if 0 // long-hand
        case(eltwise_log): {
            Medium_ for(dim_t i=0; i<sz; ++i) {
                data_t s  = src[data_off[i]];
                data_t &d = dst[data_off[i]];
                d = log_fwd(s);
            }} break;
#else
        CASE(log, s);
#endif
        CASE(linear, s, alpha, beta);
        CASE(sqrt, s);
        CASE(clip, s, alpha, beta);
        case(eltwise_soft_relu): { // log1pf is NOT vectorized by nc++-3.0.27
            //float constexpr max_logf = 8.872284e+01f; // ::log(FLT_MAX) (move const outside loop)
            float constexpr max_logf = 88.0f; // need room for 1+exp
            Medium_ for(dim_t i=0; i<sz; ++i) {
#if 1 // same speed
                float const s  = src[data_off[i]];
                dst[data_off[i]] = (data_t)(s < max_logf? ::logf(1.0f + ::expf(s)) : s);
#elif 1 // 1.01 ms
                float const s  = src[data_off[i]];
                float d = s;
                if (s >= max_logf) d = s;
                else d = ::logf(1.0f + ::expf(s));
                dst[data_off[i]] = d;
#elif 0 // cannot convince __vec_expf to use non-all-ones-mask in %vm1 :(
                float const s  = src[data_off[i]];
                float d = s;
                if (s < max_logf) d = ::expf(s);
                if (s < max_logf) d += 1.0f;
                if (s < max_logf) d = ::logf(d);
                dst[data_off[i]] = data_t{d};
#endif
            }} break;
        case eltwise_logistic:
        case eltwise_logistic_use_dst_for_bwd: // identical
        { // logistic has VE limit-case issues
            float constexpr min_logistic = -87; // close to -log(FLT_MAX)
            Medium_ for(dim_t i=0; i<sz; ++i) {
                float s = src[data_off[i]];
                if (s < min_logistic) s = min_logistic;
                dst[data_off[i]] = logistic_fwd<data_t,float>(s);
            }} break;
        case eltwise_exp_use_dst_for_bwd: // lazy way
        case eltwise_exp: { // ovflw handling for VE
            float constexpr max_logf = 8.872284e+01f; // log(FLT_MAX)
            float constexpr float_inf = HUGE_VALF;
            Medium_ for(dim_t i=0; i<sz; ++i) {
                float s = src[data_off[i]];
                dst[data_off[i]] = (s > max_logf? float_inf : std::expf(s));
            }} break;

        default: {
            for(dim_t i=0; i<sz; ++i) {
                dst[data_off[i]] = data_t{0};
            }}
            printf(" Error: TBD eltwise fwd generic for %s\n", dnnl_alg_kind2str(alg_kind));
            assert(!" TBD missing alg_kind case for ref eltwise fwd generic");
#undef CASE
#undef CASE2
        }
    });
#elif ELT_FWD_GEN_VEC == 3 // move switch out by 2 loops

#endif // ELT_FWD_GEN_VEC
}

inline double fast_exp_64(const double x) noexcept {
        // Based on Schraudolph 1999, A Fast, Compact Approximation of the Exponential Function.
        // - Adapted to use 64-bit integer; reduces staircase effect.
        // - Valid for x in approx range (-700, 700).
        union{double d_; int64_t i_;} uid; //This could be moved to the thread scope.
        //BBBD(sizeof(uid)!=8)
        uid.i_ = int64_t(double((int64_t(1) << 52) / log(2.0)) * x + double((int64_t(1) << 52) * 1023 - 0)); //c=0 for 1.0 at zero.
        return uid.d_;
    }

template <impl::data_type_t data_type>
void ref_eltwise_fwd_t<data_type>::execute_forward_dense(
        const exec_ctx_t &ctx) const {
    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);

    const memory_desc_wrapper data_d(pd()->src_md());

    const ptrdiff_t nelems = static_cast<ptrdiff_t>(data_d.nelems(true));
    const auto alg_kind = pd()->desc()->alg_kind;
    const float alpha = pd()->desc()->alpha;
    const float beta = pd()->desc()->beta;

    src += data_d.offset0();
    dst += data_d.offset0();

    //printf("fwd eltwise dense\n");
    if (alg_kind == eltwise_relu) {
        // a fast path for relu as the most popular activation
        parallel_nd(
                nelems, [&](ptrdiff_t e) { dst[e] = relu_fwd(src[e], alpha); });
        return;
    }

    /** 0~ original 1~ current best 2~ experimental */
#if 0 // original: nc++ does not vectorize this (some unvectorizable func calls)
    parallel_nd(nelems, [&](ptrdiff_t e) {
        const data_t s = src[e];
        data_t &d = dst[e];
        d = compute_eltwise_scalar_fwd(alg_kind, s, alpha, beta);
    });
#else
    switch (alg_kind) {
        //case eltwise_relu: d = relu_fwd(s, alpha); break;
#define CASE2(ALG,EXPR) case eltwise_##ALG: { \
                /*asm("### eltwise fwd dense " #ALG);*/ \
                parallel_nd(nelems, [&](ptrdiff_t e) { \
                    const data_t s = src[e]; \
                    data_t &d = dst[e]; \
                    EXPR; \
                }); \
    } break
#define CASE(ALG,...) CASE2(ALG, d = ALG##_fwd(__VA_ARGS__))
//#define CASE(ALG,...) case eltwise_##ALG: { \
//                parallel_nd(nelems, [&](ptrdiff_t e) { \
//                    const data_t s = src[e]; \
//                    data_t &d = dst[e]; \
//                    d = ALG##_fwd(__VA_ARGS__); \
//                }); \
//    } break
        CASE(tanh, s);
        CASE(elu, s, alpha);
        CASE(square, s);
        CASE(abs, s);
        CASE(sqrt, s);
        CASE(linear, s, alpha, beta);

        // slow: CASE(bounded_relu, s, alpha);
        case eltwise_bounded_relu:
            {
                parallel(0, [&](const int ithr, const int nthr) {
                    dim_t start = 0, end = 0;
                    balance211(nelems, nthr, ithr, start, end);
                    if (start == end) return;
                    data_t const d_alpha = alpha;
                    for (dim_t i = start; i < end; i++) {
#if 1 // 0.02 ms (cf ~ 10 ms in WAY==1) XXX PERF timing?
                        data_t s = src[i];
                        //if /*constexpr*/ (std::is_signed<data_t>::value)
                        //    s = (s < 0? data_t{0}: s);
                        mkNonNegative(s);
                        s = (s > d_alpha? d_alpha: s);
                        dst[i] = s;
#else // perhaps a bit slower??
                        dst[i] = bounded_relu_fwd(src[i], alpha);
#endif
                    }
                });
            } break;

        // slow: CASE(soft_relu, s);
        case eltwise_soft_relu: { // moving const outside
                // soft relu is 
                parallel(0, [&](const int ithr, const int nthr) {
                    dim_t start = 0, end = 0;
                    balance211(nelems, nthr, ithr, start, end);
                    if (start == end) return;
                    float const max_logf = 8.872284e+01; // ::log(FLT_MAX)
                    for (dim_t i = start; i < end; i++) {
                        // log1pf is NOT vectorized by nc++-3.0.27
                        float const s = src[i];
                        dst[i] = (data_t)( s < max_logf ? ::logf(1.0f + ::expf(s)) : s);
                    }
                });
            } break;

        // both exp and logistic have 'inf' issues for VE vectorization
        //CASE2(logistic, d = compute_eltwise_scalar_fwd(alg_kind, s, alpha, beta));
        // VE default might not be checking input domain for vector math functions
        // XXX identical case! (merge) XXX
        case eltwise_logistic: {
            parallel_nd(nelems, [&](ptrdiff_t e) {
                float s = src[e];
                if (s < -87.0f) s = -87.0f;
                //if (s > +87.0f) s = +87.0f;
                data_t &d = dst[e];
                d = logistic_fwd<data_t,float>(s);
            });
            } break;

        // ovflw handling: CASE(exp, s);
        case eltwise_exp: {
            float const float_inf = HUGE_VALF;
            parallel_nd(nelems, [&](ptrdiff_t e) {
                float s = src[e];
                data_t &d = dst[e];
                d = (s > 87.0f? float_inf : std::expf(s));
            });
            } break;

        CASE(gelu_tanh, s);
        CASE(swish, s, alpha);
        CASE(log, s);
        CASE(clip, s, alpha, beta);

        // ovflw cases: CASE(pow, s, alpha, beta);
        // when input is -0, VE output is -inf, but ref output wants +inf
        // assert( signbit(powf(negzero,-1.0f)) ) FAILS at -O4, OK at -O0
        // XXX This is a WRONG WAY to appease benchdnn (should fix ref calc first) XXX
        //     and then readjust here. Perhaps compile ref calc at -O2 or so?
        case eltwise_pow: {
            if (beta == 0.0f){
                parallel_nd(nelems, [&](ptrdiff_t e) {dst[e] = alpha;});
            }else if (beta == 1.0f){
                parallel_nd(nelems, [&](ptrdiff_t e) {dst[e] = alpha * src[e];});
            }else if (beta == 0.5f){
                parallel_nd(nelems, [&](ptrdiff_t e) {dst[e] = alpha * sqrtf(src[e]);});
            }else if (beta == 1.5f){
                parallel_nd(nelems, [&](ptrdiff_t e) {float const s = src[e]; dst[e] = alpha * s * sqrtf(s);});
            }else if (beta == 2.0f){
                parallel_nd(nelems, [&](ptrdiff_t e) {float const s = src[e]; dst[e] = alpha * s * s;});
            }else if (beta < 0.f && beta == (float)(int)beta
                    && (-(int)beta & 0x1) ) {
                //printf(" beta<0 is a -ve odd integer\n");
                // when beta is a -ve odd integer, CORRECT powf(-0,beta) value is -inf
                // -O4 REF value is incorrect (-O0 is correct)
                //
                // (either/both fast-math and vector math funcs allow cheating on limit-cases)
                // (perhaps -O2 will give standards-compliant ::powf result? or an nc++ flag?)
                // alpha -ve/+ve is yet another corner case to fix
                if (alpha >= 0.0f) {
                    float const negzero = -0.0f;
                    float const fixup = HUGE_VALF;
                    parallel_nd(nelems, [&](ptrdiff_t e) {
                            float const s = src[e];
                            dst[e] = alpha * (s == negzero
                                    ? fixup : ::powf(s, beta));
                            });
                }else{
                    float const negzero = -0.0f;
                    float const fixup = HUGE_VALF;
                    parallel_nd(nelems, [&](ptrdiff_t e) {
                            float const s = src[e];
                            dst[e] = alpha * (::fabs(s) == 0.0f
                                    ? fixup : ::powf(s, beta));
                            });
                }
            }else{
                parallel_nd(nelems, [&](ptrdiff_t e) {
                        //dst[e] = pow_fwd(src[e], alpha, beta);
                        // beta=0.0f special case done above, avoit test...
                        dst[e] = alpha * ::powf(src[e], beta);
                });
            }
        } break;

        CASE(gelu_erf, s);
        CASE2(relu_use_dst_for_bwd, d = relu_fwd(s, alpha));
        CASE2(tanh_use_dst_for_bwd, d = tanh_fwd(s));
        CASE2(elu_use_dst_for_bwd, d = elu_fwd(s, alpha));
        CASE2(sqrt_use_dst_for_bwd, d = sqrt_fwd(s));

        //CASE2(logistic_use_dst_for_bwd, d = logistic_fwd(s));
        // VE vector outputs 1, not 0 for too-small input:
        case eltwise_logistic_use_dst_for_bwd:
        {
            parallel(0, [&src,&dst,&nelems](const int ithr, const int nthr) {
                dim_t start = 0, end = 0;
                balance211(nelems, nthr, ithr, start, end);
                if (start == end) return;
                //float const neg_max_logf = -8.872284e+01f; // ::log(FLT_MAX)
                float constexpr neg_max_logf = -87.0f; // exp(small x) ~ 0
                for (dim_t i = start; i < end; ++i) {
                    float s = src[i];
                    if (s < neg_max_logf) s = neg_max_logf;
                    dst[i] = logistic_fwd<data_t,float>(s);
                }
            });
        } break;

#define CASE_SPECIAL_BEG(ALG) \
        case eltwise_##ALG: \
        { \
            parallel(0, [&src,&dst,&nelems](const int ithr, const int nthr) { \
                dim_t start = 0, end = 0; \
                balance211(nelems, nthr, ithr, start, end); \
                if (start == end) return
#define CASE_SPECIAL_END }); } break

        // ovflw cases: CASE2(exp_use_dst_for_bwd, d = exp_fwd(s));
        // VE vector ovflw may not yield inf for large AND small inputs
        CASE_SPECIAL_BEG(exp_use_dst_for_bwd);
        float const float_inf = HUGE_VALF;
        float constexpr max_logf = 87.0f;
        for (dim_t i = start; i < end; ++i) {
            float s = src[i];
            dst[i] = (s > max_logf? float_inf: s < -max_logf? 0.0f: std::expf(s));
        }
        CASE_SPECIAL_END;

        default: assert(!"unknown eltwise alg_kind");
        parallel_nd(nelems, [&](ptrdiff_t e) {
                dst[e] = 0.f;
                });
    }
#undef CASE
#undef CASE2
#undef CASE_SPECIAL_BEG
#undef CASE_SPECIAL_END
#endif
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

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
