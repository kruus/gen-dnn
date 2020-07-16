/*******************************************************************************
* Copyright 2019-2020 Intel Corporation
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
#include <float.h>
#include <math.h>

#include "common/c_types_map.hpp"
#include "common/dnnl_thread.hpp"
#include "common/math_utils.hpp"
#include "common/nstl.hpp"
#include "common/type_helpers.hpp"
#include "common/ve/memory_desc_wrapper_opt.hpp" // we use CoordsFor vectorization helper.
#include "cpu/simple_q10n.hpp"

#include "cpu/ref_binary.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

typedef struct {
    alg_kind_t alg;
    bool do_sum;
    float sum_scale;
    const std::unique_ptr<ref_eltwise_scalar_fwd_t> &eltwise_ker;
    const scales_t *scales;
    bool do_scale_src0;
    bool do_scale_src1;
} params_t;

template <typename data_t>
data_t compute_alg(data_t x, data_t y, alg_kind_t alg) {
    data_t d = 0;
    if (alg == alg_kind::binary_add) {
        d = x + y;
    } else if (alg == alg_kind::binary_mul) {
        d = x * y;
    } else if (alg == alg_kind::binary_max) {
        d = nstl::max(x, y);
    } else if (alg == alg_kind::binary_min) {
        d = nstl::min(x, y);
    } else {
        assert(!"not supported operation!");
    }
    return d;
}

template <typename data_t> static inline
void compute_alg_v(data_t z[MVL], data_t x[MVL], data_t y[MVL], alg_kind_t alg, dim_t const vl) {
    if (alg == alg_kind::binary_add) {
        ShortLoop() for(int i=0; i<vl; ++i) z[i] = x[i] + y[i];
    } else if (alg == alg_kind::binary_mul) {
        ShortLoop() for(int i=0; i<vl; ++i) z[i] = x[i] * y[i];
    } else if (alg == alg_kind::binary_max) {
        ShortLoop() for(int i=0; i<vl; ++i) z[i] = (x[i] < y[i]? y[i]: x[i]);
    } else if (alg == alg_kind::binary_min) {
        ShortLoop() for(int i=0; i<vl; ++i) z[i] = (x[i] < y[i]? x[i]: y[i]);
    } else {
        assert(!"not supported operation!");
        ShortLoop() for(int i=0; i<vl; ++i) z[i] = data_t{0};
    }
}

template <typename src0_data_t, typename src1_data_t, typename dst_data_t>
typename utils::enable_if<nstl::is_integral<src0_data_t>::value>::type
perform_op(
        dst_data_t *dst, src0_data_t x, src1_data_t y, const params_t &params) {
    float x_f = (float)x;
    float y_f = (float)y;
    float dst_f = (float)dst[0];

    if (params.do_scale_src0) x_f *= params.scales[0].scales_[0];
    if (params.do_scale_src1) y_f *= params.scales[1].scales_[0];

    float acc = compute_alg<float>(x_f, y_f, params.alg);
    float scaled_dst = params.do_sum ? params.sum_scale * dst_f : 0.f;
    acc += scaled_dst;
    if (params.eltwise_ker) acc = params.eltwise_ker->compute_scalar(acc);
    // inlined, but nearbyintf can kill vectorization
    // vector versions in src/cpu/simple_q10n.hpp would need more work
    dst[0] = qz_a1b0<float, dst_data_t>()(acc);
}

template <typename src0_data_t, typename src1_data_t, typename dst_data_t>
typename utils::enable_if<!nstl::is_integral<src0_data_t>::value>::type
perform_op(
        dst_data_t *dst, src0_data_t x, src1_data_t y, const params_t &params) {
    float acc = compute_alg<float>(x, y, params.alg);
    float scaled_dst = params.do_sum ? params.sum_scale * dst[0] : 0.f;
    acc += scaled_dst;
    if (params.eltwise_ker) acc = params.eltwise_ker->compute_scalar(acc);
    dst[0] = (dst_data_t)acc;
}

/** suggest single vector-register op loop */
#define short_for(VAR,VL) ShortLoop() for(int VAR=0; VAR<VL; ++VAR)

template <typename src0_data_t, typename src1_data_t, typename dst_data_t>
typename utils::enable_if<nstl::is_integral<src0_data_t>::value>::type
perform_op_v(dst_data_t * const dst, src0_data_t const* const x, src1_data_t const* const y,
           const params_t &params, const dim_t ox[MVL], const dim_t oy[MVL],
           const dim_t vl) {
    float acc[MVL];
    float x_f[MVL], y_f[MVL], dst_f[MVL];
    // VE perorms loop fusions, but is less willing to split loops
    // consulting manual, could use -floop-split to change the default
    // This should be particular good for Shortloop() (if compiler
    // actually respects that pragma!)
    short_for(i,vl){
        x_f[i] = (float)x[ox[i]];
        y_f[i] = (float)y[oy[i]];
    }
    if (params.do_sum) short_for(i,vl) // start read early
        dst_f[i] = (float)dst[ox[i]];
    if (params.do_scale_src0) short_for(i,vl)
        x_f[i] *= params.scales[0].scales_[0];
    if (params.do_scale_src1) short_for(i,vl)
        y_f[i] *= params.scales[1].scales_[0];
    compute_alg_v<float>(acc, x_f, y_f, params.alg, vl);
    if (params.do_sum) short_for(i,vl)
        acc[i] += dst_f[i] * params.sum_scale;
#if 0 // orig
    if (params.eltwise_ker) short_for(i,vl) // unvec fn call
        acc[i] = params.eltwise_ker->compute_scalar(acc[i]);
#else
    // [VE extension] single vector-fn call (too bad no vector "fastcall" ABI)
    if (params.eltwise_ker) // still have extra VST,VLD,fn_call overhead
        params.eltwise_ker->compute_vec_reg(acc, acc, vl);
#endif
    short_for(i,vl) // unvec fn call (consider vectorized fn call!)
        dst[ox[i]] = qz_a1b0<float, dst_data_t>()(acc[i]);
}

template <typename src0_data_t, typename src1_data_t, typename dst_data_t>
typename utils::enable_if<!nstl::is_integral<src0_data_t>::value>::type
perform_op_v(dst_data_t * const dst,
             src0_data_t const* const x,
             src1_data_t const* const y,
             params_t const& params,
             dim_t const ox[MVL],
             dim_t const oy[MVL],
             dim_t const vl) {
    float acc[MVL];
    float x_f[MVL], y_f[MVL], dst_f[MVL];
    short_for(i,vl){
        x_f[i] = (float)x[ox[i]];
        y_f[i] = (float)y[oy[i]];
    }
    if (params.do_sum) short_for(i,vl) // start read early
        dst_f[i] = (float)dst[ox[i]];
    compute_alg_v<float>(acc, x_f, y_f, params.alg, vl);
    if (params.do_sum) short_for(i,vl)
        acc[i] += dst_f[i] * params.sum_scale;
#if 0 // older
    if (params.eltwise_ker) short_for(i,vl) // unvec fn call :(
        acc[i] = params.eltwise_ker->compute_scalar(acc[i]);
#else // new vector-fn call
    if (params.eltwise_ker) // still have extra VST,VLD,fn_call overhead
        params.eltwise_ker->compute_vec_reg(acc, acc, vl);
#endif
    short_for(i,vl)
        dst[ox[i]] = (dst_data_t)acc[i];
}
#undef short_for

#if 0 // compile-time alg? probably not as big a win as vectorizn
// I guess it would just remove some branches from the loop.
template<int alg> struct ComputeOp{
    template<typename T> T operator()(T const x, T const y){
        assert(!"not supported operation!");
        return 0;
    }
};
template<> struct ComputeOp<alg_kind::binary_add>{
    template<typename T> T operator()(T const x, T const y){
        return x + y;
    }
};
template<> struct ComputeOp<alg_kind::binary_mul>{
    template<typename T> T operator()(T const x, T const y){
        return x * y;
    }
};
template<> struct ComputeOp<alg_kind::binary_max>{
    template<typename T> T operator()(T const x, T const y){
        return x < y? y : x;
    }
};
template<> struct ComputeOp<alg_kind::binary_min>{
    template<typename T> T operator()(T const x, T const y){
        return x < y? x : y;
    }
};

template <typename src0_data_t, typename src1_data_t, typename dst_data_t, alg_kind_t alg>
typename utils::enable_if<nstl::is_integral<src0_data_t>::value>::type
perform_op_ct(
        dst_data_t *dst, src0_data_t x, src1_data_t y, const params_t &params) {
    assert( params.alg == alg );
    float x_f = (float)x;
    float y_f = (float)y;
    float dst_f = (float)dst[0];

    if (params.do_scale_src0) x_f *= params.scales[0].scales_[0];
    if (params.do_scale_src1) y_f *= params.scales[1].scales_[0];

    float acc = compute_alg_ct<float,alg>(x_f, y_f);
    float scaled_dst = params.do_sum ? params.sum_scale * dst_f : 0.f;
    acc += scaled_dst;
    if (params.eltwise_ker) acc = params.eltwise_ker->compute_scalar(acc);
    dst[0] = qz_a1b0<float, dst_data_t>()(acc);
}

template <typename src0_data_t, typename src1_data_t, typename dst_data_t, alg_kind_t alg>
typename utils::enable_if<!nstl::is_integral<src0_data_t>::value>::type
perform_op_ct(
        dst_data_t *dst, src0_data_t x, src1_data_t y, const params_t &params) {
    assert( params.alg == alg );
    float acc = compute_alg<float,alg>(x, y);
    float scaled_dst = params.do_sum ? params.sum_scale * dst[0] : 0.f;
    acc += scaled_dst;
    if (params.eltwise_ker) acc = params.eltwise_ker->compute_scalar(acc);
    dst[0] = (dst_data_t)acc;
}
#endif

/** \todo split a dense impl out from existing ref_binary generic impl */
template <data_type_t src0_type, data_type_t src1_type, data_type_t dst_type>
void ref_binary_t<src0_type, src1_type, dst_type>::execute_ref(
        const exec_ctx_t &ctx) const {
    const auto src0 = CTX_IN_MEM(const src0_data_t *, DNNL_ARG_SRC_0);
    const auto src1 = CTX_IN_MEM(const src1_data_t *, DNNL_ARG_SRC_1);
    auto dst = CTX_OUT_MEM(dst_data_t *, DNNL_ARG_DST);

#if 0
    const memory_desc_wrapper src0_d(pd()->src_md(0));
    const memory_desc_wrapper src1_d(pd()->src_md(1));
#else
    const memory_desc_wrapper_opt src0_d(pd()->src_md(0));
    const memory_desc_wrapper_opt src1_d(pd()->src_md(1));
#endif

    const auto alg = pd()->desc()->alg_kind;

    // 0:src0 1:src1
    constexpr int nargs = 2;
    scales_t scales[nargs];
    int args[nargs] = {DNNL_ARG_SRC_0, DNNL_ARG_SRC_1};

    if (nstl::is_integral<src0_data_t>::value)
        scales[0] = pd()->attr()->scales_.get(args[0]);

    if (nstl::is_integral<src0_data_t>::value)
        scales[1] = pd()->attr()->scales_.get(args[1]);

    bool do_scale_src0 = !scales[0].has_default_values();
    bool do_scale_src1 = !scales[1].has_default_values();

    const dims_t &dims_bcast = pd()->broadcast_dims();
    const dims_t &dims_A = src0_d.dims();
    const int ndims = pd()->ndims();
    const auto nelems_A = src0_d.nelems();
    const bool is_tensor_op = pd()->is_tensor_op();

    const auto &po = pd()->attr()->post_ops_;
    const bool do_sum = po.contain(primitive_kind::sum, 0)
            && po.entry_[0].sum.scale != 0.f;
    const float sum_scale = do_sum ? po.entry_[0].sum.scale : 0.f;

    params_t params {alg, do_sum, sum_scale, eltwise_ker_, scales,
            do_scale_src0, do_scale_src1};

    auto map_idx_B = [&](dim_t off) {
        dims_t dims;
        for (int d = ndims - 1; d >= 0; --d) {
            dims[d] = off % dims_A[d];
            off /= dims_A[d];
        }
        assert(off == 0);

        for (int d = 0; d < ndims; ++d) {
            dims[d] *= (!dims_bcast[d]);
        }

        return src1_d.off_v(dims);
    };

#if 0
    parallel_nd(nelems_A, [&](dim_t i) {
        auto off_A = src0_d.off_l(i);
        auto off_B = is_tensor_op ? src1_d.off_l(i) : map_idx_B(i);
        perform_op(&dst[off_A], src0[off_A], src1[off_B], params);
    });
#elif 1 // vectorize the offset calculations
    parallel(0, [&](const int ithr, const int nthr) {
        dim_t start = 0, end = 0;
        balance211(nelems_A, nthr, ithr, start, end);
        if (start == end) return;
#define MVL 256
        dim_t loff_A[MVL], poff_A[MVL], loff_B[MVL], poff_B[MVL];
        // also possible: coords iter and vec_off_p or so
        // Hmm. B broadcast supprot really want dims, so got with coords iter here.
        typedef CoordsForNd<6,uint64_t,uint64_t> Coords;
        Coords cA(&dims_A[0], ndims, start, end);
        Coords::Base cB; // workspace, if !is_tensor_op for B
        Coords::Base *pcB = (is_tensor_op? &cA.base(): &cB);
        NOVEC_ for ( ; cA; ++cA) {
            dim_t const vl = cA.get_vl();

            if (!is_tensor_op) { // copy A coords, coords of broadcast dims set to zero
                NOVEC_ for(int d=0; d<ndims; ++d)
                    ShortLoop() for (int i=0; i<vl; ++i)
                        cB.vp[d][i] = cA.vp[d][i] * (!dims_bcast[d]);
            }

            dim_t poff_A[MVL];
            dim_t poff_B[MVL];
            src0_d.vec_off_v(cA.base(), (dim_t *)&poff_A[0], vl);
            src1_d.vec_off_v(*pcB,      (dim_t *)&poff_B[0], vl);

#if 0
            ShortLoop() for (int i=0; i<vl; ++i) {
                // inlined, but still "ref to this fn inhibits optimization"
                perform_op(&dst[poff_A[i]], src0[poff_A[i]], src1[poff_B[i]], params);
            }
#elif 1
            //perform_op_v(dst,src0,src1,params);
            //perform_op_v(dst,src0,src1,params, vl);
            perform_op_v(dst,src0,src1,params, poff_A,poff_B,vl);
#endif
        }
    });
#undef MVL
#endif
}

using namespace data_type;

template struct ref_binary_t<f32>;
template struct ref_binary_t<bf16>;
template struct ref_binary_t<s8, u8, s8>;
template struct ref_binary_t<s8, s8, s8>;
template struct ref_binary_t<u8, s8, u8>;
template struct ref_binary_t<u8, u8, u8>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino+=l0,\:4,N-s
