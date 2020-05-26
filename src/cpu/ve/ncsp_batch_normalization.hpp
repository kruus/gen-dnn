/*******************************************************************************
* Copyright 2018-2020 Intel Corporation
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

#ifndef CPU_VE_NCSP_BATCH_NORMALIZATION_HPP
#define CPU_VE_NCSP_BATCH_NORMALIZATION_HPP

#include <assert.h>

#include "common/c_types_map.hpp"
#include "common/ve/consistency.hpp"
#include "common/dnnl_thread.hpp"
#include "common/memory_tracking.hpp"
#include "common/primitive.hpp"
#include "common/type_helpers.hpp"
#include "common/utils.hpp"

#include "cpu/platform.hpp"

#include "cpu/cpu_batch_normalization_pd.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

template <data_type_t d_type>
struct ncsp_batch_normalization_fwd_t : public primitive_t {
    struct pd_t : public cpu_batch_normalization_fwd_pd_t {
        using cpu_batch_normalization_fwd_pd_t::
                cpu_batch_normalization_fwd_pd_t;

        DECLARE_COMMON_PD_T("ncsp_bnorm:any", ncsp_batch_normalization_fwd_t);

        status_t init(engine_t *engine) {
            using namespace data_type;
            using namespace prop_kind;
            using namespace format_tag;

            Consistency ok("nspc_batch_normalization_fwd_t");
#define AND_(...) SCHKVV(ok,(__VA_ARGS__))
            AND_(is_bwd());
            AND_(is_fwd());
            AND_(!has_zero_dim_memory());
            AND_(src_md()->data_type == d_type);
            AND_(platform::has_data_type_support(d_type));
            AND_(IMPLICATION(use_scaleshift(),
                        weights_md()->data_type == f32));
            AND_(memory_desc_matches_one_of_tag(
                    *src_md(), ncdhw, nchw, nc));
            AND_(attr()->has_default_values()
                    || this->with_relu_post_op());
#undef AND_
            if (!ok) return status::unimplemented;

            if (is_training() && fuse_norm_relu()) init_default_ws(8);

            init_scratchpad();

            return status::success;
        }

    private:
        void init_scratchpad() {
            using namespace memory_tracking::names;
            auto scratchpad = scratchpad_registry().registrar();
            if (!stats_is_src()) {
                scratchpad.template book<acc_data_t>(
                        key_bnorm_reduction, C() * dnnl_get_max_threads());

                if (!is_training()) {
                    scratchpad.template book<acc_data_t>(
                            key_bnorm_tmp_mean, C());
                    scratchpad.template book<acc_data_t>(
                            key_bnorm_tmp_var, C());
                }
            }

            if (d_type == data_type::bf16) {
                const int simd_w = 16;
                const bool has_spatial = utils::one_of(ndims(), 4, 5);
                const int SP = has_spatial ? D() * H() * W() : 1;
                const int nbufs = 2;
                const size_t bf16cvt_buf_sz = nbufs * dnnl_get_max_threads()
                        * utils::rnd_up(SP, simd_w);
                scratchpad.template book<acc_data_t>(
                        key_bnorm_bf16cvt, bf16cvt_buf_sz);
            }
        }
    };

    typedef typename prec_traits<d_type>::type data_t;
    typedef float acc_data_t;

    ncsp_batch_normalization_fwd_t(const pd_t *apd) : primitive_t(apd) {}
    ~ncsp_batch_normalization_fwd_t() {}

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        execute_forward(ctx);
        return status::success;
    }

private:
    void execute_forward(const exec_ctx_t &ctx) const;
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
};

template <data_type_t d_type>
struct ncsp_batch_normalization_bwd_t : public primitive_t {
    struct pd_t : public cpu_batch_normalization_bwd_pd_t {
        using cpu_batch_normalization_bwd_pd_t::
                cpu_batch_normalization_bwd_pd_t;

        DECLARE_COMMON_PD_T("ncsp_bnorm:any", ncsp_batch_normalization_bwd_t);

        status_t init(engine_t *engine) {
            using namespace data_type;
            using namespace format_tag;

            Consistency ok("nspc_batch_normalization_bwd_t");
#define AND_(...) SCHKVV(ok,(__VA_ARGS__))
#if defined(__ve)
            printf(" d_type=%d ; src, weights & diff_weights data_type are "
                    "%d %d %d ; use_scaleshift()=%d\n",
                    (int)d_type, (int)src_md()->data_type,
                    (int)weights_md()->data_type,
                    (int)diff_weights_md()->data_type,
                    (int)use_scaleshift() );
#endif
            AND_(is_bwd());
            AND_(!has_zero_dim_memory());
            AND_(set_default_formats_common());
            AND_(utils::everyone_is(d_type, src_md()->data_type,
                        diff_src_md()->data_type));
            AND_(platform::has_data_type_support(d_type));
            AND_(IMPLICATION(use_scaleshift(),
                        utils::everyone_is(f32, weights_md()->data_type,
                            diff_weights_md()->data_type)));
            AND_(memory_desc_matches_one_of_tag(
                            *src_md(), ncdhw, nchw, nc));
            AND_(memory_desc_matches_one_of_tag(
                            *diff_src_md(), ncdhw, nchw, nc));
            AND_(attr()->has_default_values());
            if (!ok) return status::unimplemented;

            if (fuse_norm_relu()) {
                init_default_ws(8);
                AND_(compare_ws(hint_fwd_pd_));
                if (!ok) return status::unimplemented;
            }
#undef AND_
            init_scratchpad();

            return status::success;
        }

    private:
        void init_scratchpad() {
            using namespace memory_tracking::names;
            auto scratchpad = scratchpad_registry().registrar();
            scratchpad.template book<acc_data_t>(
                    key_bnorm_reduction, 2 * C() * dnnl_get_max_threads());
            if (!(use_scaleshift() && desc()->prop_kind == prop_kind::backward))
                scratchpad.template book<acc_data_t>(
                        key_bnorm_tmp_diff_ss, 2 * C());

            if (d_type == data_type::bf16) {
                const int simd_w = 16;
                const bool has_spatial = utils::one_of(ndims(), 4, 5);
                const int SP = has_spatial ? D() * H() * W() : 1;
                const int nbufs = 2 + !use_global_stats();
                const size_t bf16cvt_buf_sz = nbufs * dnnl_get_max_threads()
                        * utils::rnd_up(SP, simd_w);
                scratchpad.template book<acc_data_t>(
                        key_bnorm_bf16cvt, bf16cvt_buf_sz);
            }
        }
    };

    typedef typename prec_traits<d_type>::type data_t;
    typedef float acc_data_t;

    ncsp_batch_normalization_bwd_t(const pd_t *apd) : primitive_t(apd) {}
    ~ncsp_batch_normalization_bwd_t() {}

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        execute_backward(ctx);
        return status::success;
    }

private:
    void execute_backward(const exec_ctx_t &ctx) const;
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
};

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+s,l0,\:4,N-s
#endif // CPU_VE_NCSP_BATCH_NORMALIZATION_HPP
