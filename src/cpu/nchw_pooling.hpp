/*******************************************************************************
* Copyright 2017-2018 Intel Corporation
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

#ifndef CPU_NCHW_POOLING_HPP
#define CPU_NCHW_POOLING_HPP

#include <assert.h>

#include "c_types_map.hpp"
#include "cpu_pooling_pd.hpp"
#include "cpu_engine.hpp"
#include "type_helpers.hpp"
#include "utils.hpp"
#include "consistency.hpp"

namespace mkldnn {
namespace impl {
namespace cpu {

using namespace mkldnn::impl::memory_format;

template <impl::data_type_t data_type>
struct nchw_pooling_fwd_t: public cpu_primitive_t {
    struct pd_t: public cpu_pooling_fwd_pd_t {
        pd_t(engine_t *engine, const pooling_desc_t *adesc,
                const primitive_attr_t *attr,
                const pooling_fwd_pd_t *hint_fwd_pd)
            : cpu_pooling_fwd_pd_t(engine, adesc, attr, hint_fwd_pd) {}

        DECLARE_COMMON_PD_T("nchw_pooling:any", nchw_pooling_fwd_t);

        virtual status_t init() override {
            using namespace prop_kind;
            using namespace alg_kind;
            assert(engine()->kind() == engine_kind::cpu);
            auto src_format = src_pd()->desc()->format;
            //bool ok = true
            Consistency ok;
#define AND_(...) SCHKV(ok,__VA_ARGS__)
            AND_(set_default_params() == status::success);
            AND_(utils::one_of(desc()->prop_kind, forward_training,
                        forward_inference));
            AND_(utils::one_of(desc()->alg_kind, pooling_max,
                        pooling_avg_include_padding,
                        pooling_avg_exclude_padding));
            AND_(!has_zero_dim_memory());
            AND_(utils::everyone_is(data_type, src_pd()->desc()->data_type,
                        dst_pd()->desc()->data_type));
            AND_(utils::one_of(src_format, nchw, ncdhw));
            AND_(src_format == dst_pd()->desc()->format); // __ve extra-() bug!
            AND_(attr()->has_default_values());
#undef AND_
            if (!ok) return status::unimplemented;

            bool is_training = desc_.prop_kind == forward_training;
            if (desc()->alg_kind == pooling_max && is_training) {
                auto indices_desc = *dst_pd()->desc();
                indices_desc.data_type = pooling_index_data_type(desc());
                ws_pd_ = cpu_memory_t::pd_t(engine_, &indices_desc);
            }

            return status::success;
        }
    };

    nchw_pooling_fwd_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {}
    typedef typename prec_traits<data_type>::type data_t;

    virtual void execute(event_t *e) {
        execute_forward();
        e->set_state(event_t::ready);
    }

private:
    void execute_forward();
    pd_t conf_;
};

template <impl::data_type_t data_type>
struct nchw_pooling_bwd_t: public cpu_primitive_t {
    struct pd_t: public cpu_pooling_bwd_pd_t {
        pd_t(engine_t *engine, const pooling_desc_t *adesc,
                const primitive_attr_t *attr,
                const pooling_fwd_pd_t *hint_fwd_pd)
            : cpu_pooling_bwd_pd_t(engine, adesc, attr, hint_fwd_pd) {}

        DECLARE_COMMON_PD_T("nchw:any", nchw_pooling_bwd_t);

        virtual status_t init() override {
            using namespace prop_kind;
            using namespace alg_kind;
            assert(engine()->kind() == engine_kind::cpu);
            auto diff_dst_format = diff_dst_pd()->desc()->format;
            //bool ok = true
            Consistency ok;
#define AND_(...) SCHKV(ok,__VA_ARGS__)
            AND_(set_default_params() == status::success);
            AND_(utils::one_of(desc()->prop_kind, backward_data));
            AND_(utils::one_of(desc()->alg_kind, pooling_max,
                        pooling_avg_include_padding,
                        pooling_avg_exclude_padding));
            AND_(!has_zero_dim_memory());
            AND_(utils::everyone_is(data_type,
                        diff_dst_pd()->desc()->data_type,
                        diff_src_pd()->desc()->data_type));
            AND_(utils::one_of(diff_dst_format, nchw, ncdhw));
            AND_((diff_dst_format == diff_src_pd()->desc()->format));
            AND_(attr()->has_default_values());
#undef AND_
            if (!ok) return status::unimplemented;

            if (desc()->alg_kind == pooling_max) {
                //bool ws_ok = true
                Consistency ws_ok("max pooling inconsistent");
#define AND_(...) SCHKV(ok,__VA_ARGS__)
                AND_(hint_fwd_pd_);
                AND_(hint_fwd_pd_->workspace_pd());
                AND_(utils::one_of(
                            hint_fwd_pd_->workspace_pd()->desc()->format,
                            nchw, ncdhw, nChw8c, nChw16c, nCdhw8c, nCdhw16c));
#undef AND_
                if (!ws_ok) return status::unimplemented;

                ws_pd_ = *(cpu_memory_t::pd_t*)hint_fwd_pd_->workspace_pd();
            }

            return status::success;
        }
    };

    nchw_pooling_bwd_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {}
    typedef typename prec_traits<data_type>::type data_t;

    virtual void execute(event_t *e) {
        execute_backward();
        e->set_state(event_t::ready);
    }

private:
    void execute_backward();
    pd_t conf_;
};

}
}
}

// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
#endif
