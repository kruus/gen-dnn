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

#ifndef CPU_JIT_GEMM_CONVOLUTION_HPP
#define CPU_JIT_GEMM_CONVOLUTION_HPP

#include "c_types_map.hpp"
#include "cpu_convolution_pd.hpp"
#include "cpu_engine.hpp"
#include "cpu_isa_traits.hpp"
#include "gemm_convolution_utils.hpp"
#include "gemm/gemm.hpp"
#include "scratchpad.hpp"
#include "consistency.hpp"

#if !defined(MKLDNN_GEMM_CONV_DBG)
#if !defined(NDEBUG)
#define MKLDNN_GEMM_CONV_DBG 1
#else
#define MKLDNN_GEMM_CONV_DBG 1
#endif
#endif

namespace mkldnn {
namespace impl {
namespace cpu {

// OLD: template <bool with_relu, bool run_jit, cpu_isa_t isa>
template <bool with_relu>
struct _gemm_convolution_fwd_t: public cpu_primitive_t {
    struct pd_t: public _cpu_convolution_fwd_pd_t<with_relu> {
        pd_t(engine_t *engine,
                const typename pd_t::base_desc_t *adesc,
                const primitive_attr_t *attr,
                const typename pd_t::base_class *hint_fwd_pd)
            : _cpu_convolution_fwd_pd_t<with_relu>(engine, adesc, attr,
                    hint_fwd_pd)
            , jcp_() {}

        DECLARE_COMMON_PD_T(GEMM_IMPL_STR, _gemm_convolution_fwd_t<with_relu>);

        inline memory_format_t src_format()
        {
            using namespace memory_format;
            return (this->cdesc_().src_desc.ndims == 4) ? nchw : ncdhw;
        }
        inline memory_format_t wei_format()
        {
            using namespace memory_format;
            return (this->cdesc_().src_desc.ndims == 4)
                ? this->with_groups() ? goihw : oihw
                : this->with_groups() ? goidhw : oidhw;
        }

        virtual status_t init() override {
            using namespace prop_kind;
            using namespace memory_format;

            assert(this->engine()->kind() == engine_kind::cpu);

            Consistency ok; // default never-verbose SCHK
#ifdef MKLDNN_GEMM_CONV_DBG
            {
                char const* result;
                mkldnn_primitive_desc_query( this, mkldnn_query_impl_info_str, 0, &result );
                printf(" conv-fwd:%s:", result);
                fflush(stdout);
            }
#endif
#define AND_(...) SCHKV(ok,__VA_ARGS__)
            AND_(this->set_default_params() == status::success);
            AND_(utils::one_of(this->cdesc_().prop_kind, forward_training,
                        forward_inference));
            AND_(this->cdesc_().alg_kind == alg_kind::convolution_direct);
            AND_(!this->has_zero_dim_memory());
            AND_(utils::everyone_is(data_type::f32,
                        this->cdesc_().src_desc.data_type,
                        this->cdesc_().weights_desc.data_type,
                        this->cdesc_().dst_desc.data_type));
            AND_(utils::implication(this->with_bias(), data_type::f32
                        == this->cdesc_().bias_desc.data_type));
            AND_(this->src_pd_.desc()->format == src_format());
            AND_(this->dst_pd_.desc()->format == src_format());
            AND_(this->weights_pd_.desc()->format == wei_format());
            AND_(this->is_gemm_conv_format());
#undef AND_
#ifdef MKLDNN_REF_CONV_DBG
            if(ok){ printf("init-ok "); fflush(stdout); }
#endif
            return ok ? status::success : status::unimplemented;
        }

        jit_gemm_conv_conf_t jcp_;

    protected:
        virtual status_t set_default_params() override {
            using namespace memory_format;
            if (this->src_pd_.desc()->format == any)
                CHECK(this->src_pd_.set_format(src_format()));
            if (this->dst_pd_.desc()->format == any)
                CHECK(this->dst_pd_.set_format(src_format()));
            if (this->weights_pd_.desc()->format == any)
                CHECK(this->weights_pd_.set_format(wei_format()));
            if (this->bias_pd_.desc()->format == any)
                CHECK(this->bias_pd_.set_format(x));
            return status::success;
        }

        virtual bool is_gemm_conv_format() const {
            bool ok = true;
            auto const &po = this->attr()->post_ops_;
            switch (po.len_) {
                using namespace mkldnn::impl::primitive_kind;
            case 0: // no post_ops
                break;
            case 1:
                ok = ok && // sum OR relu
                        (po.entry_[0].is_relu() || po.entry_[0].is_sum());
                break;
            case 2:
                ok = ok && // sum->relu
                        (po.entry_[0].is_sum() && po.entry_[1].is_relu());
                break;
            default: ok = false;
            }
            return ok;
        }
    };

    _gemm_convolution_fwd_t(const pd_t *pd, const input_vector &inputs,
           const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd)
        , scratchpad_(nullptr)
    {
        using namespace prop_kind;

        const auto &post_ops = conf_.attr()->post_ops_;
        const data_t one = 1.0, zero = 0.0;
        beta_ = post_ops.find(primitive_kind::sum) >= 0 ? one : zero;

        jit_gemm_convolution_utils::init_conf(conf_.jcp_,
            *(conf_.cdesc()), conf_.src_pd(), conf_.weights_pd(0),
            conf_.dst_pd(), omp_get_max_threads(), with_relu,
            conf_.negative_slope());

        size_t size = (size_t)conf_.jcp_.im2col_sz * sizeof(data_t);
        jit_gemm_convolution_utils::prepare_scratchpad(this->conf_.jcp_,
                &this->scratchpad_, size, this->conf_.jcp_.nthr);
    }

    ~_gemm_convolution_fwd_t() {
        delete this->scratchpad_;
    };

    typedef typename prec_traits<data_type::f32>::type data_t;

    virtual void execute(event_t *e) {
        execute_forward();
        e->set_state(event_t::ready);
    }

private:
    void execute_forward();
    pd_t conf_;
    scratchpad_t *scratchpad_;
    data_t beta_;
};

using gemm_convolution_fwd_t =
                         _gemm_convolution_fwd_t<false>;
using gemm_convolution_relu_t =
                         _gemm_convolution_fwd_t<true>;

struct gemm_convolution_bwd_data_t: public cpu_primitive_t {
    struct pd_t: public cpu_convolution_bwd_data_pd_t {
        pd_t(engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr,
                const convolution_fwd_pd_t *hint_fwd_pd)
            : cpu_convolution_bwd_data_pd_t(engine, adesc, attr, hint_fwd_pd)
            , jcp_()
        {}

        DECLARE_COMMON_PD_T(GEMM_IMPL_STR, gemm_convolution_bwd_data_t);

        inline memory_format_t src_format()
        {
            using namespace memory_format;
            return (this->desc()->diff_src_desc.ndims == 4) ? nchw : ncdhw;
        }
        inline memory_format_t wei_format()
        {
            using namespace memory_format;
            return (this->desc()->diff_src_desc.ndims == 4)
                ? this->with_groups() ? goihw : oihw
                : this->with_groups() ? goidhw : oidhw;
        }

        virtual status_t init() override {
            using namespace prop_kind;
            using namespace memory_format;

            assert(this->engine()->kind() == engine_kind::cpu);

            //bool ok = true
            Consistency ok; // default here is never-verbose
#define AND_(...) SCHKV(ok,__VA_ARGS__)
            AND_(this->set_default_params() == status::success);
            AND_(this->desc()->prop_kind == backward_data);
            AND_(this->desc()->alg_kind == alg_kind::convolution_direct);
            AND_(!this->has_zero_dim_memory());
            AND_(utils::everyone_is(data_type::f32,
                        this->desc()->diff_src_desc.data_type,
                        this->desc()->weights_desc.data_type,
                        this->desc()->diff_dst_desc.data_type));
            AND_(this->diff_src_pd_.desc()->format == src_format());
            AND_(this->diff_dst_pd_.desc()->format == src_format());
            AND_(this->weights_pd_.desc()->format == wei_format());
#undef AND_
            return ok ? status::success : status::unimplemented;
        }

        jit_gemm_conv_conf_t jcp_;

    protected:
        virtual status_t set_default_params() override {
            using namespace memory_format;
            if (this->diff_src_pd_.desc()->format == any)
                CHECK(this->diff_src_pd_.set_format(src_format()));
            if (this->diff_dst_pd_.desc()->format == any)
                CHECK(this->diff_dst_pd_.set_format(src_format()));
            if (this->weights_pd_.desc()->format == any)
                CHECK(this->weights_pd_.set_format(wei_format()));
            return status::success;
        }
    };

    gemm_convolution_bwd_data_t(const pd_t *pd, const input_vector &inputs,
              const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd)
        , scratchpad_(nullptr)
    {
        using namespace prop_kind;

        jit_gemm_convolution_utils::init_conf(conf_.jcp_,
            *(conf_.desc()), conf_.diff_src_pd(), conf_.weights_pd(0),
            conf_.diff_dst_pd(), omp_get_max_threads());

        size_t size = (size_t)conf_.jcp_.im2col_sz * sizeof(data_t);
        jit_gemm_convolution_utils::prepare_scratchpad(this->conf_.jcp_,
                &this->scratchpad_, size, this->conf_.jcp_.nthr);
    }

    ~gemm_convolution_bwd_data_t() {
        delete this->scratchpad_;
    };

    typedef typename prec_traits<data_type::f32>::type data_t;

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
    scratchpad_t *scratchpad_;
};

struct gemm_convolution_bwd_weights_t: public cpu_primitive_t {
    struct pd_t: public cpu_convolution_bwd_weights_pd_t {
        pd_t(engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr,
                const convolution_fwd_pd_t *hint_fwd_pd)
            : cpu_convolution_bwd_weights_pd_t(engine, adesc, attr, hint_fwd_pd)
            , jcp_()
        {}

        DECLARE_COMMON_PD_T(GEMM_IMPL_STR, gemm_convolution_bwd_weights_t);

        inline memory_format_t src_format()
        {
            using namespace memory_format;
            return (this->desc()->src_desc.ndims == 4) ? nchw : ncdhw;
        }
        inline memory_format_t wei_format()
        {
            using namespace memory_format;
            return (this->desc()->src_desc.ndims == 4)
                ? this->with_groups() ? goihw : oihw
                : this->with_groups() ? goidhw : oidhw;
        }

        virtual status_t init() override {
            using namespace prop_kind;
            using namespace memory_format;

            assert(this->engine()->kind() == engine_kind::cpu);

            Consistency ok; // default here is never-verbose
#define AND_(...) SCHKV(ok,__VA_ARGS__)
            AND_(this->set_default_params() == status::success);
            AND_(this->desc()->prop_kind == backward_weights);
            AND_(this->desc()->alg_kind == alg_kind::convolution_direct);
            AND_(!this->has_zero_dim_memory());
            AND_(utils::everyone_is(data_type::f32,
                        this->desc()->src_desc.data_type,
                        this->desc()->diff_weights_desc.data_type,
                        this->desc()->diff_dst_desc.data_type));
            AND_(utils::implication(this->with_bias(),
                        data_type::f32 == this->desc()->diff_bias_desc.data_type));
            AND_(this->src_pd_.desc()->format == src_format());
            AND_(this->diff_dst_pd_.desc()->format == src_format());
            AND_(this->diff_weights_pd_.desc()->format == wei_format());
#undef AND_
            return ok ? status::success : status::unimplemented;
        }

        jit_gemm_conv_conf_t jcp_;

    protected:
        virtual status_t set_default_params() override {
            using namespace memory_format;
            if (this->src_pd_.desc()->format == any)
                CHECK(this->src_pd_.set_format(src_format()));
            if (this->diff_dst_pd_.desc()->format == any)
                CHECK(this->diff_dst_pd_.set_format(src_format()));
            if (this->diff_weights_pd_.desc()->format == any)
                CHECK(this->diff_weights_pd_.set_format(wei_format()));
            if (this->diff_bias_pd_.desc()->format == any)
                CHECK(this->diff_bias_pd_.set_format(x));
            return status::success;
        }
    };

    gemm_convolution_bwd_weights_t(const pd_t *pd, const input_vector &inputs,
              const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd)
        , scratchpad_(nullptr)
    {
        using namespace prop_kind;

        jit_gemm_convolution_utils::init_conf(conf_.jcp_,
            *(conf_.desc()), conf_.src_pd(), conf_.diff_weights_pd(0),
            conf_.diff_dst_pd(), omp_get_max_threads());
        const memory_desc_wrapper weights_d(conf_.diff_weights_pd(0));

        size_t size = (size_t)conf_.jcp_.im2col_sz  * sizeof(data_t);
        if (conf_.jcp_.need_wei_reduction)
            size += (size_t)conf_.jcp_.ngroups * weights_d.size();

        jit_gemm_convolution_utils::prepare_scratchpad(this->conf_.jcp_,
                &this->scratchpad_, size, conf_.jcp_.nthr);
    }

    ~gemm_convolution_bwd_weights_t() {
        delete this->scratchpad_;
     };

    typedef typename prec_traits<data_type::f32>::type data_t;

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
#if defined(TARGET_VANILLA)
    // split (for VE) part of the above function into a separate file.
    void execute_backward_weights_bias();
#endif
    pd_t conf_;
    scratchpad_t *scratchpad_;
};

}
}
}

// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
#endif
