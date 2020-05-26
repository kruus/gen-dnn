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

#ifndef CPU_REF_BATCH_NORMALIZATION_HPP
#define CPU_REF_BATCH_NORMALIZATION_HPP

#if defined(__ve) // debugging why UNIMPLEMENTED_FAILED in benchdnn regression_large
#include "cpu/ve/ref_batch_normalization.hpp"
#else
#include <assert.h>

#include "common/c_types_map.hpp"
#include "common/primitive.hpp"
#include "common/type_helpers.hpp"
#include "common/utils.hpp"

#include "cpu/platform.hpp"

#include "cpu/cpu_batch_normalization_pd.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

template <data_type_t d_type>
struct ref_batch_normalization_fwd_t : public primitive_t {
    struct pd_t : public cpu_batch_normalization_fwd_pd_t {
        pd_t(const batch_normalization_desc_t *adesc,
                const primitive_attr_t *attr,
                const batch_normalization_fwd_pd_t *hint_fwd_pd)
            : cpu_batch_normalization_fwd_pd_t(adesc, attr, hint_fwd_pd) {}

        DECLARE_COMMON_PD_T("bnorm_ref:any", ref_batch_normalization_fwd_t);

        status_t init(engine_t *engine) {
            using namespace data_type;
            bool ok = is_fwd() && src_md()->data_type == d_type
                    && platform::has_data_type_support(d_type)
                    && IMPLICATION(
                            use_scaleshift(), weights_md()->data_type == f32)
                    && (attr()->has_default_values() || with_relu_post_op());
            if (!ok) return status::unimplemented;

            if (src_md()->data_type == s8 && !stats_is_src())
                return status::unimplemented;

            if (is_training() && fuse_norm_relu()) init_default_ws(8);

            return status::success;
        }
    };

    ref_batch_normalization_fwd_t(const pd_t *apd) : primitive_t(apd) {}

    typedef typename prec_traits<d_type>::type data_t;

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        execute_forward(ctx);
        return status::success;
    }

private:
    void execute_forward(const exec_ctx_t &ctx) const;
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
};

template <data_type_t d_type>
struct ref_batch_normalization_bwd_t : public primitive_t {
    struct pd_t : public cpu_batch_normalization_bwd_pd_t {
        pd_t(const batch_normalization_desc_t *adesc,
                const primitive_attr_t *attr,
                const batch_normalization_fwd_pd_t *hint_fwd_pd)
            : cpu_batch_normalization_bwd_pd_t(adesc, attr, hint_fwd_pd) {}

        DECLARE_COMMON_PD_T("bnorm_ref:any", ref_batch_normalization_bwd_t);

        status_t init(engine_t *engine) {
            using namespace data_type;
            bool ok = is_bwd() && set_default_formats_common()
                    && utils::everyone_is(d_type, src_md()->data_type,
                            diff_src_md()->data_type)
                    && platform::has_data_type_support(d_type)
                    && IMPLICATION(use_scaleshift(),
                            utils::everyone_is(d_type, weights_md()->data_type,
                                    diff_weights_md()->data_type))
                    && attr()->has_default_values();
            if (!ok) return status::unimplemented;

            if (fuse_norm_relu()) {
                init_default_ws(8);
                if (!compare_ws(hint_fwd_pd_)) return status::unimplemented;
            }

            return status::success;
        }
    };

    ref_batch_normalization_bwd_t(const pd_t *apd) : primitive_t(apd) {}
    typedef typename prec_traits<d_type>::type data_t;

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

#endif // not VE
// vim: et ts=4 sw=4 cindent cino+=l0,\:4,N-s
#endif // CPU_REF_BATCH_NORMALIZATION_HPP
