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

#ifndef CPU_VE_REF_BATCH_NORMALIZATION_HPP
#define CPU_VE_REF_BATCH_NORMALIZATION_HPP

#include <assert.h>

#include "common/c_types_map.hpp"
#include "common/ve/consistency.hpp"
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
            Consistency ok("ref_batch_normalization_fwd_t");
#define AND_(...) SCHKVV(ok,__VA_ARGS__)
#if 1 || defined(__ve)
            printf(" d_type=%d ; src, weights & diff_weights data_type are "
                    "%d %d %d ; use_scaleshift()=%d\n",
                    (int)d_type, (int)src_md()->data_type,
                    (int)weights_md()->data_type,
                    (int)diff_weights_md()->data_type,
                    (int)use_scaleshift() );
#endif
            AND_((is_fwd()));
            AND_((src_md()->data_type == d_type));
            AND_((platform::has_data_type_support(d_type)));
            AND_(IMPLICATION(use_scaleshift(),
                        weights_md()->data_type == f32));
            AND_((attr()->has_default_values() || with_relu_post_op()));
            if (!ok) return status::unimplemented;

            //if (src_md()->data_type == s8 && !stats_is_src())
            //    return status::unimplemented;
            //#define IMPLICATION(cause, effect) (!(cause) || !!(effect))
            //#define IMPLICATION(cause, effect) (!(cause) || (effect))
            //#define IMPLICATION(cause, effect) (!(!!(cause) && !(effect)))
            //#define IMPLICATION(cause, effect) (!((cause) && !(effect)))
            // cause = src_md()->data_type == s8
            // effect = stats_is_src()
            AND_(IMPLICATION(src_md()->data_type == s8,
                        stats_is_src()));
            if (!ok) return status::unimplemented;

            if (is_training() && fuse_norm_relu()) {
                init_default_ws(8);
                char s[80]; dnnl_md2fmt_str(s, 80, &ws_md_);
                printf( __FILE__ " ws %s\n", s);
            }

            printf(__FILE__ " fwd init!\n");
            return status::success;
#undef AND_
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
            Consistency ok("ref_batch_normalization_fwd_t");
#define AND_(...) SCHKVV(ok,__VA_ARGS__)
#if 1 || defined(__ve)
            printf(" d_type=%d ; src, weights & diff_weights data_type are "
                    "%d %d %d ; use_scaleshift()=%d\n",
                    (int)d_type, (int)src_md()->data_type,
                    (int)weights_md()->data_type,
                    (int)diff_weights_md()->data_type,
                    (int)use_scaleshift() );
#endif
            AND_((is_bwd()));
            AND_((set_default_formats_common()));
            AND_((utils::everyone_is(d_type, src_md()->data_type,
                            diff_src_md()->data_type)));
            AND_((platform::has_data_type_support(d_type)));
            AND_((IMPLICATION(use_scaleshift(),
                            utils::everyone_is(d_type, weights_md()->data_type,
                                    diff_weights_md()->data_type))));
            AND_((attr()->has_default_values()));
            if (!ok) return status::unimplemented;

            if (fuse_norm_relu()) {
                printf(" fuse_norm_relu! ");
                init_default_ws(8);
                //if (!compare_ws(hint_fwd_pd_)) return status::unimplemented;
                if(hint_fwd_pd_) {
                    memory_desc_t const& lhs = ws_md();
                    memory_desc_t const& rhs = hint_fwd_pd_->ws_md();
                    // to avoid changing src/common/type_helpers.hpp...
                    using dnnl::impl::utils::array_cmp;
                    AND_(lhs.ndims == rhs.ndims);
                    AND_(array_cmp(lhs.dims, rhs.dims, lhs.ndims));
                    AND_(lhs.data_type == rhs.data_type);
                    AND_(array_cmp(lhs.padded_dims, rhs.padded_dims, lhs.ndims));
                    AND_(array_cmp(lhs.padded_offsets, rhs.padded_offsets, lhs.ndims));
                    AND_(lhs.offset0 == rhs.offset0);
                    AND_(lhs.format_kind == rhs.format_kind);
                    AND_(types::memory_extra_desc_is_equal(lhs.extra, rhs.extra));

                    if (lhs.format_kind == format_kind::blocked)
                        AND_(types::blocking_desc_is_equal(lhs, rhs));
                    else if (lhs.format_kind == format_kind::wino)
                        AND_(types::wino_desc_is_equal(
                                lhs.format_desc.wino_desc, rhs.format_desc.wino_desc));
                    else if (lhs.format_kind == format_kind::rnn_packed)
                        AND_(types::rnn_packed_desc_is_equal(lhs.format_desc.rnn_packed_desc,
                                rhs.format_desc.rnn_packed_desc));
                }
                AND_(compare_ws(hint_fwd_pd_));
                if (!ok) return status::unimplemented;
            }

            printf(__FILE__ " bwd init!\n");
            return status::success;
#undef AND_
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

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
#endif
