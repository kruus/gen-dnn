#ifndef VEDNNX_CONVOLUTION_HPP
#define VEDNNX_CONVOLUTION_HPP
/** \file
 * \todo set libvednn parm struct as pd_t (set once), and use the libvednnx
 *       *_ok function during init functions.
 */
#if !defined(VEJIT)
#define VEJIT 0
#endif
#if VEJIT > 0

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

struct vednnx_convolution_fwd_t: public cpu_primitive_t {
    // no template parms for libvednn...
    static const bool with_relu=false;
    //typedef mkldnn::impl::data_type::f32 src_type;
    //typedef src_type wei_type;
    //typedef src_type dst_type;
    //typedef dst_type acc_type;
    static const data_type_t src_type = impl::data_type::f32;
    static const data_type_t wei_type = src_type;
    static const data_type_t dst_type = src_type;
    static const data_type_t acc_type = dst_type;

    struct pd_t: public _cpu_convolution_fwd_pd_t<with_relu> {
        pd_t(engine_t *engine,
                const typename pd_t::base_desc_t *adesc,
                const primitive_attr_t *attr,
                const typename pd_t::base_class *hint_fwd_pd)
            : _cpu_convolution_fwd_pd_t<false/*with_relu*/>(engine, adesc, attr,
                    hint_fwd_pd) {
                //printf(" ve_conv pd_t "); fflush(stdout);
            }

        DECLARE_COMMON_PD_T("ve-fwd:nchw", vednnx_convolution_fwd_t);

        inline memory_format_t src_format()
        {
            using namespace memory_format;
            //return (this->desc()->diff_src_desc.ndims == 4) ? nchw : ncdhw;
            return nchw;
        }
        inline memory_format_t wei_format()
        {
            using namespace memory_format;
            //return (this->desc()->diff_src_desc.ndims == 4)
            //    ? this->with_groups() ? goihw : oihw
            //    : this->with_groups() ? goidhw : oidhw;
            return this->with_groups() ? goihw : oihw;
        }
        virtual status_t init() override {
            using namespace prop_kind;
            using namespace data_type;
            assert(this->engine()->kind() == engine_kind::cpu);
            Consistency ok("ve_conv init"); // default here is never-verbose, SCHK
#define AND_(...) SCHKVV(ok,__VA_ARGS__)
            AND_(this->set_default_params() == status::success);
            AND_(utils::one_of(this->cdesc_().prop_kind, forward_training,
                        forward_inference));
            AND_(this->cdesc_().alg_kind == alg_kind::convolution_direct);
            AND_(!has_zero_dim_memory());
            AND_(utils::everyone_is(data_type::f32,
                        this->cdesc_().src_desc.data_type,
                        this->cdesc_().weights_desc.data_type,
                        this->cdesc_().dst_desc.data_type));
            AND_(utils::implication(this->with_bias(), data_type::f32
                        == this->cdesc_().bias_desc.data_type));
            AND_(this->src_pd_.desc()->format == src_format());
            AND_(this->dst_pd_.desc()->format == src_format());
            AND_(this->weights_pd_.desc()->format == wei_format());
            AND_(utils::implication(this->with_bias(), data_type::f32
                        == this->cdesc_().bias_desc.data_type));
            // libvednn convolution ONLY supports nchw memory format
            // TODO: add aligned-pointers new format to allow fast VE impls
            //       to do 512-float vector loads w/o ptr-align checks


#if 1 // not really needed, but just to verify some more invariants...
            // libvednn does not support 3d convolutions
            AND_(this->cdesc()->src_desc.ndims < 5);
            AND_(this->cdesc()->dst_desc.ndims < 5);
            int const depth_no3d=1;
            AND_(this->ID() == depth_no3d);
            AND_(this->OD() == depth_no3d);
            AND_(this->KD() == depth_no3d);
            AND_(this->KSD() == depth_no3d);
            //std::cout<<"KDD()="<<this->KDD()<<std::endl;
            AND_(this->KDD() == 0);      // see src/common/convolution_pd.hpp
            AND_(this->padFront() == 0);
#endif

            // check for rounding=nearest, no post_ops, scaling=1.0
            // TODO: libvednn does not support postops (relu/scaling)
            //   TODO: allow them by implementing them sequentially
            //         (really only a speedup for jit case, I think,
            //          but might make specifying some nets a bit easier)
            AND_(this->attr()->has_default_values());
#undef AND_
            return ok ? status::success : status::unimplemented;
        }

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

    };

    vednnx_convolution_fwd_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs)
#ifdef TARGET_VANILLA
        ; /* moved to .cpp file for more control & debug */
#else
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd)
        {}
#endif
    //~vednnx_convolution_fwd_t() {} // no scratch mem

    typedef typename prec_traits<data_type::f32>::type data_t;
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

struct vednnx_convolution_bwd_data_t: public cpu_primitive_t {
    // no template parms for libvednn...
    static const bool with_relu=false;
    struct pd_t: public cpu_convolution_bwd_data_pd_t {
        pd_t(engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr,
                const convolution_fwd_pd_t *hint_fwd_pd)
            : cpu_convolution_bwd_data_pd_t(engine, adesc, attr, hint_fwd_pd)
        {}

        DECLARE_COMMON_PD_T("ve-bwd:nchw", vednnx_convolution_bwd_data_t);

        inline memory_format_t src_format()
        {
            using namespace memory_format;
            //return (this->desc()->diff_src_desc.ndims == 4) ? nchw : ncdhw;
            return nchw;
        }
        inline memory_format_t wei_format()
        {
            using namespace memory_format;
            //return (this->desc()->diff_src_desc.ndims == 4)
            //    ? this->with_groups() ? goihw : oihw
            //    : this->with_groups() ? goidhw : oidhw;
            return this->with_groups() ? goihw : oihw;
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
            // check for rounding=nearest, no post_ops, scaling=1.0
            AND_(this->attr()->has_default_values());
#if 1 // not really needed, but just to verify some more invariants...
            // libvednn does not support 3d convolutions
            AND_(this->cdesc()->src_desc.ndims < 5);
            AND_(this->cdesc()->dst_desc.ndims < 5);
            int const depth_no3d=1;
            AND_(this->ID() == depth_no3d);
            AND_(this->OD() == depth_no3d);
            AND_(this->KD() == depth_no3d);
            AND_(this->KSD() == depth_no3d);
            //std::cout<<"KDD()="<<this->KDD()<<std::endl;
            AND_(this->KDD() == 0);      // see src/common/convolution_pd.hpp
            AND_(this->padFront() == 0);
#endif

#undef AND_
            return ok ? status::success : status::unimplemented;
        }
        virtual bool support_bias() const override { return true; }

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
    };// pd_t

    vednnx_convolution_bwd_data_t(const pd_t *pd, const input_vector &inputs,
              const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd)
    { /*no scratch space*/ }

    //~vednnx_convolution_bwd_data_t() {} //delete this->scratchpad_;

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
};

struct vednnx_convolution_bwd_weights_t: public cpu_primitive_t {
    struct pd_t: public cpu_convolution_bwd_weights_pd_t {
        pd_t(engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr,
                const convolution_fwd_pd_t *hint_fwd_pd)
            : cpu_convolution_bwd_weights_pd_t(engine, adesc, attr, hint_fwd_pd)
        {}

        DECLARE_COMMON_PD_T("ve-bww:nchw", vednnx_convolution_bwd_weights_t);

        inline memory_format_t src_format()
        {
            using namespace memory_format;
            //return (this->desc()->diff_src_desc.ndims == 4) ? nchw : ncdhw;
            return nchw;
        }
        inline memory_format_t wei_format()
        {
            using namespace memory_format;
            //return (this->desc()->diff_src_desc.ndims == 4)
            //    ? this->with_groups() ? goihw : oihw
            //    : this->with_groups() ? goidhw : oidhw;
            return this->with_groups() ? goihw : oihw;
        }
        virtual status_t init() override {
            using namespace prop_kind;
            assert(this->engine()->kind() == engine_kind::cpu);
            Consistency ok;
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
            AND_(this->attr()->has_default_values());
#if 1 // not really needed, but just to verify some more invariants...
            // libvednn does not support 3d convolutions
            AND_(this->cdesc()->src_desc.ndims < 5);
            AND_(this->cdesc()->dst_desc.ndims < 5);
            int const depth_no3d=1;
            AND_(this->ID() == depth_no3d);
            AND_(this->OD() == depth_no3d);
            AND_(this->KD() == depth_no3d);
            AND_(this->KSD() == depth_no3d);
            //std::cout<<"KDD()="<<this->KDD()<<std::endl;
            AND_(this->KDD() == 0);      // see src/common/convolution_pd.hpp
            AND_(this->padFront() == 0);
#endif

#undef AND_
            return ok ? status::success : status::unimplemented;
        }

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

    vednnx_convolution_bwd_weights_t(const pd_t *pd, const input_vector &inputs,
            const output_vector &outputs)
        : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {}

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
    pd_t conf_;
};
}
}
}

#endif // VEJIT > 0
// vim: et ts=4 sw=4 cindent cino=^l0,\:0,N-s
#endif // VEDNNX_CONVOLUTION_HPP
