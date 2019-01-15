/*******************************************************************************
* Copyright 2016-2018 Intel Corporation
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

#ifndef CPU_REF_CONVOLUTION_HPP
#define CPU_REF_CONVOLUTION_HPP

#include <assert.h>

#include "c_types_map.hpp"
#include "cpu_convolution_pd.hpp"
#include "cpu_engine.hpp"
#include "type_helpers.hpp"
#include "utils.hpp"
#include "consistency.hpp"

#if !defined(MKLDNN_REF_CONV_DBG)
#if !defined(NDEBUG)
#define MKLDNN_REF_CONV_DBG 1
#else
#define MKLDNN_REF_CONV_DBG 1
#endif
#endif

namespace mkldnn {
namespace impl {
namespace cpu {

template <bool with_relu, impl::data_type_t src_type,
         impl::data_type_t wei_type = src_type,
         impl::data_type_t dst_type = src_type,
         impl::data_type_t acc_type = dst_type>
struct _ref_convolution_fwd_t: public cpu_primitive_t {
    struct pd_t: public _cpu_convolution_fwd_pd_t<with_relu> {
        pd_t(engine_t *engine,
                const typename pd_t::base_desc_t *adesc,
                const primitive_attr_t *attr,
                const typename pd_t::base_class *hint_fwd_pd)
            : _cpu_convolution_fwd_pd_t<with_relu>(engine, adesc, attr,
                    hint_fwd_pd)
        {}

        DECLARE_COMMON_PD_T("ref:any", _ref_convolution_fwd_t);

        virtual status_t init() override {
            using namespace prop_kind;
            using namespace data_type;
            assert(this->engine()->kind() == engine_kind::cpu);
            Consistency ok("ref_conv init"); // default here is never-verbose, SCHK
#define AND_(...) SCHKV(ok,__VA_ARGS__)
            AND_(this->set_default_params() == status::success);
            AND_(utils::one_of(this->cdesc_().prop_kind, forward_training,
                        forward_inference));
            AND_(this->cdesc_().alg_kind == alg_kind::convolution_direct);
            AND_(this->cdesc_().src_desc.data_type == src_type);
            AND_(this->cdesc_().weights_desc.data_type == wei_type);
            AND_(this->cdesc_().accum_data_type == acc_type);
            AND_(this->cdesc_().dst_desc.data_type == dst_type);
            AND_(utils::implication(this->with_bias(), true
                        && utils::implication(src_type == u8,
                            utils::one_of(this->cdesc_().bias_desc.data_type,
                                f32, s32, s8, u8))
                        && utils::implication(src_type == f32,
                            this->cdesc_().bias_desc.data_type == f32)));
            AND_(this->attr()->has_default_values());
#undef AND_
            return ok ? status::success : status::unimplemented;
        }
    };

#if defined(TARGET_VANILLA)
    // moved to .cpp for extra debug
    _ref_convolution_fwd_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs);
#else
    _ref_convolution_fwd_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs)
#ifdef TARGET_VANILLA
        ; /* moved to .cpp file for more control & debug */
#else
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {}
#endif

    typedef typename prec_traits<src_type>::type src_data_t;
    typedef typename prec_traits<wei_type>::type wei_data_t;
    typedef typename prec_traits<dst_type>::type dst_data_t;
    typedef typename prec_traits<acc_type>::type acc_data_t;

    virtual void execute(event_t *e) {
        switch (conf_.cdesc()->prop_kind) {
        case prop_kind::forward_training:
        case prop_kind::forward_inference:
            execute_forward();
            break;
        default:
            assert(!"invalid prop_kind");
        }
        e->set_state(event_t::ready);
    }

private:
    void execute_forward();
    pd_t conf_;
};

template <impl::data_type_t src_type, impl::data_type_t wei_type = src_type,
         impl::data_type_t dst_type = src_type,
         impl::data_type_t acc_type = dst_type>
using ref_convolution_fwd_t = _ref_convolution_fwd_t<false, src_type, wei_type,
      dst_type, acc_type>;

template <impl::data_type_t src_type, impl::data_type_t wei_type = src_type,
         impl::data_type_t dst_type = src_type,
         impl::data_type_t acc_type = dst_type>
using ref_convolution_relu_t = _ref_convolution_fwd_t<true, src_type, wei_type,
      dst_type, acc_type>;

template <impl::data_type_t diff_src_type, impl::data_type_t wei_type,
         impl::data_type_t diff_dst_type,
         impl::data_type_t acc_type = diff_src_type>
struct ref_convolution_bwd_data_t: public cpu_primitive_t {
    struct pd_t: public cpu_convolution_bwd_data_pd_t {
        pd_t(engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr,
                const convolution_fwd_pd_t *hint_fwd_pd)
            : cpu_convolution_bwd_data_pd_t(engine, adesc, attr, hint_fwd_pd)
        {}

        DECLARE_COMMON_PD_T("ref:any", ref_convolution_bwd_data_t);

        virtual status_t init() override {
            using namespace prop_kind;
            assert(this->engine()->kind() == engine_kind::cpu);
            Consistency ok; // default here is never-verbose
#ifdef MKLDNN_REF_CONV_DBG
            {
                char const* result;
                mkldnn_primitive_desc_query( this, mkldnn_query_impl_info_str, 0, &result );
                printf(" conv-fwd:%s:", result);
                fflush(stdout);
            }
#endif
#define AND_(...) SCHKV(ok,__VA_ARGS__)
            AND_(this->set_default_params() == status::success);
            AND_(this->desc()->prop_kind == backward_data);
            AND_(this->desc()->alg_kind == alg_kind::convolution_direct);
            AND_(this->desc()->diff_dst_desc.data_type == diff_dst_type);
            AND_(this->desc()->weights_desc.data_type == wei_type);
            AND_(this->desc()->accum_data_type == acc_type);
            AND_(this->desc()->diff_src_desc.data_type == diff_src_type);
            AND_(this->attr()->has_default_values());
#undef AND_
#ifdef MKLDNN_REF_CONV_DBG
            if(ok){ printf("init-ok "); fflush(stdout); }
#endif
            return ok ? status::success : status::unimplemented;
        }

        virtual bool support_bias() const override { return true; }
    };

    ref_convolution_bwd_data_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {}

    typedef typename prec_traits<diff_src_type>::type diff_src_data_t;
    typedef typename prec_traits<wei_type>::type wei_data_t;
    typedef typename prec_traits<diff_dst_type>::type diff_dst_data_t;
    typedef typename prec_traits<acc_type>::type acc_data_t;

    virtual void execute(event_t *e) {
        switch (conf_.desc()->prop_kind) {
        case prop_kind::backward_data:
            execute_backward_data();
            break;
        default:
            assert(!"invalid prop_kind");
        }
        e->set_state(event_t::ready);
    }

private:
    void execute_backward_data();
    pd_t conf_;
};

template <impl::data_type_t src_type, impl::data_type_t diff_wei_type,
         impl::data_type_t diff_dst_type,
         impl::data_type_t acc_type = diff_wei_type>
struct ref_convolution_bwd_weights_t: public cpu_primitive_t {
    struct pd_t: public cpu_convolution_bwd_weights_pd_t {
        pd_t(engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr,
                const convolution_fwd_pd_t *hint_fwd_pd)
            : cpu_convolution_bwd_weights_pd_t(engine, adesc, attr, hint_fwd_pd)
        {}

        DECLARE_COMMON_PD_T("ref:any", ref_convolution_bwd_weights_t);

        virtual status_t init() override {
            using namespace prop_kind;
            assert(this->engine()->kind() == engine_kind::cpu);
            Consistency ok;
            OK_AND(this->set_default_params() == status::success);
            OK_AND(this->desc()->prop_kind == backward_weights);
            OK_AND(this->desc()->alg_kind == alg_kind::convolution_direct);
            OK_AND(this->desc()->src_desc.data_type == src_type);
            OK_AND(this->desc()->diff_weights_desc.data_type == diff_wei_type);
            OK_AND(this->desc()->diff_dst_desc.data_type == diff_dst_type);
            OK_AND(this->desc()->accum_data_type == acc_type);
            OK_AND(utils::implication(this->with_bias(),
                        this->desc()->diff_bias_desc.data_type
                        == diff_wei_type));
            OK_AND(this->attr()->has_default_values());
            return ok ? status::success : status::unimplemented;
        }
    };

    ref_convolution_bwd_weights_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {}

    typedef typename prec_traits<src_type>::type src_data_t;
    typedef typename prec_traits<diff_wei_type>::type diff_wei_data_t;
    typedef typename prec_traits<diff_dst_type>::type diff_dst_data_t;
    typedef typename prec_traits<acc_type>::type acc_data_t;

    virtual void execute(event_t *e) {
        switch (conf_.desc()->prop_kind) {
        case prop_kind::backward_weights:
            execute_backward_weights();
            break;
        default:
            assert(!"invalid prop_kind");
        }
        e->set_state(event_t::ready);
    }

private:
    void execute_backward_weights();
    pd_t conf_;
};

}
}
}

#endif

// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
