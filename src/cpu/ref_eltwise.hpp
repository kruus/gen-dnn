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

#ifndef CPU_REF_ELTWISE_HPP
#define CPU_REF_ELTWISE_HPP

#include <assert.h>

#include "common/c_types_map.hpp"
#include "common/primitive.hpp"
#include "common/type_helpers.hpp"
#include "common/utils.hpp"

#include "cpu/platform.hpp"

#include "cpu/cpu_eltwise_pd.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

struct ref_eltwise_scalar_fwd_t {
public:
    ref_eltwise_scalar_fwd_t(
            alg_kind_t alg, float alpha, float beta, float scale);

    ref_eltwise_scalar_fwd_t(const post_ops_t::entry_t::eltwise_t &eltwise);

    float compute_scalar(float s);

#if defined(__ve)
    /** single vector-register version of \c compute_scalar.
     * \pre for now, \b unchecked, \c vl <= max vector register length.
     * \c dst==src is allowed : use simple `dst[i] = fn(src[i])` expressions. */
    void compute_vec_reg(float * const dst, float const* const src,
            int const vl);
#endif

    const alg_kind_t alg_;
    const float alpha_;
    const float beta_;
    const float scale_;
};

template <impl::data_type_t data_type>
struct ref_eltwise_fwd_t : public primitive_t {
    struct pd_t : public cpu_eltwise_fwd_pd_t {
        using cpu_eltwise_fwd_pd_t::cpu_eltwise_fwd_pd_t;

        DECLARE_COMMON_PD_T("ref:any", ref_eltwise_fwd_t);

        status_t init(engine_t *engine) {
            using namespace utils;

            auto src_d = memory_desc_wrapper(src_md());

            use_dense_ = src_d.is_dense()
                    || (src_d.is_dense(true) && is_zero_preserved());

            use_nCspBc_padded_ = !use_dense_
                    && src_d.blocking_desc().inner_nblks == 1
                    && one_of(src_d.blocking_desc().inner_blks[0], 8, 16)
                    && src_d.blocking_desc().inner_idxs[0] == 1
                    && src_d.only_padded_dim(1) && src_d.is_dense(true);

            if (has_zero_dim_memory()) use_dense_ = use_nCspBc_padded_ = false;

            bool ok = is_fwd() && data_type == desc()->data_desc.data_type
                    && platform::has_data_type_support(data_type)
                    && attr()->has_default_values();
            if (!ok) return status::unimplemented;

            return status::success;
        }

        bool use_dense_, use_nCspBc_padded_;
    };

    ref_eltwise_fwd_t(const pd_t *apd) : primitive_t(apd) {}
    typedef typename prec_traits<data_type>::type data_t;

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        if (pd()->use_dense_)
            execute_forward_dense(ctx);
        else if (pd()->use_nCspBc_padded_)
            execute_forward_nCspBc_padded(ctx);
        else
            execute_forward_generic(ctx);
        return status::success;
    }

private:
    void execute_forward_nCspBc_padded(const exec_ctx_t &ctx) const;
    void execute_forward_dense(const exec_ctx_t &ctx) const;
    void execute_forward_generic(const exec_ctx_t &ctx) const;
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
};

template <impl::data_type_t data_type>
struct ref_eltwise_bwd_t : public primitive_t {
    struct pd_t : public cpu_eltwise_bwd_pd_t {
        using cpu_eltwise_bwd_pd_t::cpu_eltwise_bwd_pd_t;

        DECLARE_COMMON_PD_T("ref:any", ref_eltwise_bwd_t);

        status_t init(engine_t *engine) {
            using namespace utils;

            bool ok = !is_fwd()
                    && everyone_is(data_type, desc()->data_desc.data_type,
                            desc()->diff_data_desc.data_type)
                    && platform::has_data_type_support(data_type)
                    && set_default_formats_common()
                    && attr()->has_default_values();
            if (!ok) return status::unimplemented;

            const memory_desc_wrapper diff_dst_d(diff_dst_md());
            //const bool same_fmt_ = diff_dst_d == memory_desc_wrapper(src_md());
            //if (!same_fmt_) printf(" eltwise-bwd-not-same-fmt(diff_dst,src) ");
            //if (!diff_dst_d.is_dense(true)) printf(" eltwise_bwd-not-diff_dst.is_dense ");
            //if (!diff_dst_d.is_dense())

            //use_dense_ = same_fmt_ && diff_dst_d.is_dense(true)
            //        && is_zero_preserved() && !has_zero_dim_memory();
            // try mirroring fwd logic (seeing generic chosen surprisingly)
            use_dense_ = diff_dst_d.is_dense()
                      || (diff_dst_d.is_dense(true) && is_zero_preserved());

            if (has_zero_dim_memory()) use_dense_ = false;
            if (diff_dst_d != memory_desc_wrapper(src_md())) use_dense_ = false;

            if (data_type == data_type::bf16) init_scratchpad();

            return status::success;
        }

        bool use_dense_;

    private:
        void init_scratchpad() {
            const memory_desc_wrapper data_d(src_md());
            const memory_desc_wrapper diff_data_d(diff_dst_md());
            using namespace memory_tracking::names;
            auto scratchpad = scratchpad_registry().registrar();
            const auto diff_dst_size = diff_data_d.nelems(true);
            scratchpad.template book<float>(
                    key_eltwise_src, data_d.nelems(true));
            scratchpad.template book<float>(
                    key_eltwise_diff_dst, diff_dst_size);
        }
    };

    ref_eltwise_bwd_t(const pd_t *apd) : primitive_t(apd) {}
    typedef typename prec_traits<data_type>::type data_t;

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        if (pd()->use_dense_)
            execute_backward_dense(ctx);
        else
            execute_backward_generic(ctx);
        return status::success;
    }

private:
    void execute_backward_dense(const exec_ctx_t &ctx) const;
    void execute_backward_generic(const exec_ctx_t &ctx) const;
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
};

} // namespace cpu
} // namespace impl
} // namespace dnnl

#endif

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
