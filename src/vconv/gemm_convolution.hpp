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

#define PARTIAL 2 /*0:fwd 1:add bwd_w 2:add bwd_d*/

#include "cpu_isa_traits.hpp"
#include "c_types_map.hpp"
//#include "cpu_convolution_pd.hpp"
//#include "cpu_engine.hpp"
#include "primitive_attr.hpp"
#include "gemm_convolution_utils.hpp"
#include "gemm.hpp"
#include "scratchpad.hpp"
#include "consistency.hpp"

#if !defined(MKLDNN_GEMM_CONV_DBG)
#if !defined(NDEBUG)
#define MKLDNN_GEMM_CONV_DBG 0
#else
#define MKLDNN_GEMM_CONV_DBG 0
#endif
#endif

namespace mkldnn {
namespace impl {

//inline status_t set_format(memory_desc_t& desc_, memory_format_t fmt);
inline status_t set_format(memory_desc_wrapper& mdw, memory_format_t fmt) {
    memory_desc_t md = *mdw._md;
    md.format = fmt;
    status_t status = memory_desc_wrapper::compute_blocking(md);
    if (status != status::success) return status;
    *const_cast<memory_desc_t*>(mdw._md) = md;
    return status;
}

template <bool with_relu> struct _vconv_fwd_pd_t{
    typedef typename utils::conditional<with_relu,
            convolution_relu_desc_t, convolution_desc_t>::type base_desc_t;
    const base_desc_t      * desc() const {return &desc_;}
    const primitive_attr_t * attr() const {return &attr_;}

    // mkldnn_convolution_relu_desc_t adds 'float negative_slope;'
    //typedef _vconv_fwd_pd_t base_class;
    //typedef _vconv_fwd_pd_t hint_class;

    const convolution_desc_t& cdesc_() const;

    _vconv_fwd_pd_t( const base_desc_t *adesc, const primitive_attr_t *attr);

    virtual int n_inputs() const { return 2 + with_bias(); }
    virtual int n_outputs() const { return 1; }
    memory_desc_wrapper& src_pd()    { return src_mdw; }
    memory_desc_wrapper& weights_pd(){ return weights_mdw; }
    memory_desc_wrapper& bias_pd()   { return bias_mdw; }
    memory_desc_wrapper& dst_pd()    { return dst_mdw; }

    /* common conv aux functions */

    inline int MB() const { return cdesc_().src_desc.dims[0]; }

    inline int IC() const { return cdesc_().src_desc.dims[1]; }
    inline int OC() const { return cdesc_().dst_desc.dims[1]; }
    inline int G() const
    { return with_groups() ? cdesc_().weights_desc.dims[0] : 1; }

    inline int ID() const { return (ndims() == 5)
        ? cdesc_().src_desc.dims[2] : 1; }
    inline int IH() const { return cdesc_().src_desc.dims[ndims()-2]; }
    inline int IW() const { return cdesc_().src_desc.dims[ndims()-1]; }
    inline int OD() const { return (ndims() == 5)
        ? cdesc_().dst_desc.dims[2] : 1; }
    inline int OH() const { return cdesc_().dst_desc.dims[ndims()-2]; }
    inline int OW() const { return cdesc_().dst_desc.dims[ndims()-1]; }
    inline int KD() const { return (ndims() == 5)
        ? cdesc_().weights_desc.dims[2 + with_groups()] : 1; }
    inline int KH() const
    { return cdesc_().weights_desc.dims[ndims() - (2 - with_groups())]; }
    inline int KW() const
    { return cdesc_().weights_desc.dims[ndims() - (1 - with_groups())]; }

    inline int KSD() const { return (ndims() == 5) ? cdesc_().strides[0] : 1; }
    inline int KSH() const { return cdesc_().strides[ndims()-4]; }
    inline int KSW() const { return cdesc_().strides[ndims()-3]; }

    inline int KDD() const { return (ndims() == 5) ? cdesc_().dilates[0] : 0; }
    inline int KDH() const { return cdesc_().dilates[ndims()-4]; }
    inline int KDW() const { return cdesc_().dilates[ndims()-3]; }

    inline int padFront() const
    { return (ndims() == 5) ? cdesc_().padding[0][0] : 0; }
    inline int padBack() const
    { return (ndims() == 5) ? cdesc_().padding[1][0] : 0; }
    inline int padT() const { return cdesc_().padding[0][ndims()-4]; }
    inline int padB() const { return cdesc_().padding[1][ndims()-4]; }
    inline int padL() const { return cdesc_().padding[0][ndims()-3]; }
    inline int padR() const { return cdesc_().padding[1][ndims()-3]; }

    inline float negative_slope() const;

    inline bool with_bias() const
    { return !memory_desc_wrapper(cdesc_().bias_desc).is_zero(); }
    inline bool with_groups() const
    { return cdesc_().weights_desc.ndims == cdesc_().src_desc.ndims + 1; }

    inline int ndims() const { return cdesc_().src_desc.ndims; }

    bool has_zero_dim_memory() const {
        return false
            || memory_desc_wrapper(cdesc_().src_desc).has_zero_dim()
            || memory_desc_wrapper(cdesc_().dst_desc).has_zero_dim();
    }

    protected:
    const base_desc_t desc_;
    const primitive_attr_t attr_;
    memory_desc_wrapper src_mdw, weights_mdw, bias_mdw, dst_mdw;
};

template<> inline float
_vconv_fwd_pd_t<false>                  ::negative_slope() const
{ return 0.f; }
template<> inline float
_vconv_fwd_pd_t<true>                   ::negative_slope() const
{ return desc_.negative_slope; }

template<> inline const
convolution_desc_t & _vconv_fwd_pd_t<false> ::cdesc_() const
{ return desc_; }
template<> inline const
convolution_desc_t & _vconv_fwd_pd_t<true>  ::cdesc_() const
{ return desc_.convolution_desc; }

template<bool with_relu>
_vconv_fwd_pd_t<with_relu>::_vconv_fwd_pd_t(
        const base_desc_t *adesc, const primitive_attr_t *attr)
    : desc_(*adesc), attr_(*attr)
      , src_mdw( &cdesc_().src_desc )
      , weights_mdw( &cdesc_().weights_desc )
      , bias_mdw( &cdesc_().bias_desc )
      , dst_mdw( &cdesc_().dst_desc )
{}


namespace cpu {

// OLD: template <bool with_relu, bool run_jit, cpu_isa_t isa>
template <bool with_relu>
struct _gemm_convolution_fwd_t
//: public cpu_primitive_t
{
    struct pd_t
        : public _vconv_fwd_pd_t<with_relu>
    {
        pd_t(   //engine_t *engine,
                const typename pd_t::base_desc_t *adesc,
                // either mkldnn_convolution_desc_t
                //   or   mkldnn_convolution_relu_desc_t
                const primitive_attr_t *attr
                //const typename pd_t::base_class *hint_fwd_pd
            )
            : _vconv_fwd_pd_t<with_relu>(adesc, attr)
            , jcp_() {}

        //DECLARE_COMMON_PD_T(GEMM_IMPL_STR, _gemm_convolution_fwd_t<with_relu>);

        inline memory_format_t src_format() ///< the formats we support
        {
            using namespace memory_format;
            return (this->cdesc_().src_desc.ndims == 4) ? nchw : ncdhw;
        }
        inline memory_format_t wei_format() /// the formats we support
        {
            using namespace memory_format;
            return (this->cdesc_().src_desc.ndims == 4)
                ? this->with_groups() ? goihw : oihw
                : this->with_groups() ? goidhw : oidhw;
        }

        virtual status_t init() //override
        {
            using namespace prop_kind;
            using namespace memory_format;

            //assert(this->engine()->kind() == engine_kind::cpu);

            Consistency ok; // default never-verbose SCHK
#ifdef MKLDNN_GEMM_CONV_DBG
            //{
            //    char const* result;
            //    mkldnn_primitive_desc_query( this, mkldnn_query_impl_info_str, 0, &result );
            //    printf(" conv-fwd:%s:", result);
            //    fflush(stdout);
            //}
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
            AND_(this->src_pd().format() == src_format());
            AND_(this->dst_pd().format() == src_format());
            AND_(this->weights_pd().format() == wei_format());
            AND_(this->is_gemm_conv_format());
#undef AND_
#ifdef MKLDNN_REF_CONV_DBG
            if(ok){ printf("init-ok "); fflush(stdout); }
#endif
            return ok ? status::success : status::unimplemented;
        }

        jit_gemm_conv_conf_t jcp_;

    protected:
        virtual status_t set_default_params() //override
        {
            using namespace memory_format;
            if (this->src_pd().format() == any)
                CHECK(set_format( this->src_pd(),     src_format()));
            if (this->dst_pd().format() == any)
                CHECK(set_format( this->dst_pd(),     src_format()));
            if (this->weights_pd().format() == any)
                CHECK(set_format( this->weights_pd(), wei_format()));
            if (this->bias_pd().format() == any)
                CHECK(set_format( this->bias_pd(),    x));
            return status::success;
        }

        virtual bool is_gemm_conv_format() const {
            bool ok = true;
            //auto const &po = this->attr()->post_ops_;
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

    typedef float data_type;
    data_type const * pDataIn;
    data_type const * pDataKernel;
    data_type const * pDataBias;
    data_type       * pDataOut;
    _gemm_convolution_fwd_t(const pd_t *pd,
            //const input_vector &inputs, const output_vector &outputs
            const void* pDataIn,
            const void* pDataKernel,
            const void* pDataBias, // may be null
            void* pDataOut
            )
        //: cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd)
        : conf_(*pd)
        , pDataIn(      (data_type const *)pDataIn)
        , pDataKernel(  (data_type const *)pDataKernel)
        , pDataBias(    (data_type const *)pDataBias)
        , pDataOut(     (data_type       *)pDataOut)
        , scratchpad_(nullptr)
    {
        using namespace prop_kind;

        const auto &post_ops = conf_.attr()->post_ops_;
        const data_t one = 1.0, zero = 0.0;
        beta_ = post_ops.find(primitive_kind::sum) >= 0 ? one : zero;

        jit_gemm_convolution_utils::init_conf(
                conf_.jcp_, conf_.cdesc_(),
                conf_.src_pd(), conf_.weights_pd(), // NO bias_pd aka weights_pd(1)
                conf_.dst_pd(), omp_get_max_threads(),
                with_relu, conf_.negative_slope());

        size_t size = (size_t)conf_.jcp_.im2col_sz * sizeof(data_t);
        jit_gemm_convolution_utils::prepare_scratchpad(this->conf_.jcp_,
                &this->scratchpad_, size, this->conf_.jcp_.nthr);
    }

    ~_gemm_convolution_fwd_t() {
        delete this->scratchpad_;
    };

    typedef typename prec_traits<data_type::f32>::type data_t;

    virtual void execute(/*event_t *e*/) {
        execute_forward();
        //e->set_state(event_t::ready); // no engine --> no event
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

}//cpu::

#if PARTIAL >= 1
struct _vconv_bwd_data_pd_t{
    // mkldnn_convolution_relu_desc_t adds 'float negative_slope;'
    //typedef convolution_bwd_data_pd_t base_class;
    //typedef convolution_fwd_pd_t hint_class;
    _vconv_bwd_data_pd_t( const convolution_desc_t *adesc, const primitive_attr_t *attr)
        : desc_(*adesc), attr_(*attr)
          , diff_src_mdw    (cdesc_().diff_src_desc)
          , weights_mdw     (cdesc_().weights_desc )
          , diff_bias_mdw   (cdesc_().diff_bias_desc )
          , diff_dst_mdw    (cdesc_().diff_dst_desc )
    {}
    const convolution_desc_t *desc() const { return &desc_; }
    const convolution_desc_t cdesc_() const { return desc_; }

    memory_desc_wrapper& diff_src_pd()   { return diff_src_mdw; }
    memory_desc_wrapper& diff_dst_pd()   { return diff_dst_mdw; }
    memory_desc_wrapper& weights_pd()    { return weights_mdw; }
    memory_desc_wrapper& diff_bias_pd()  { return diff_bias_mdw; }

    virtual int n_inputs() const { return 2 + with_bias(); }
    virtual int n_outputs() const { return 1; }

    /* common conv aux functions */

    inline int MB() const { return desc_.diff_src_desc.dims[0]; }

    inline int IC() const { return desc_.diff_src_desc.dims[1]; }
    inline int OC() const { return desc_.diff_dst_desc.dims[1]; }
    inline int G() const
    { return with_groups() ? desc_.weights_desc.dims[0] : 1; }

    inline int ID() const { return (ndims() == 5)
        ? desc_.diff_src_desc.dims[2] : 1; }
    inline int IH() const { return desc_.diff_src_desc.dims[ndims()-2]; }
    inline int IW() const { return desc_.diff_src_desc.dims[ndims()-1]; }
    inline int OD() const { return (ndims() == 5)
        ? desc_.diff_dst_desc.dims[2] : 1; }
    inline int OH() const { return desc_.diff_dst_desc.dims[ndims()-2]; }
    inline int OW() const { return desc_.diff_dst_desc.dims[ndims()-1]; }
    inline int KD() const { return (ndims() == 5)
        ? desc_.weights_desc.dims[2 + with_groups()] : 1; }
    inline int KH() const
    { return desc_.weights_desc.dims[ndims() - (2 - with_groups())]; }
    inline int KW() const
    { return desc_.weights_desc.dims[ndims() - (1 - with_groups())]; }

    inline int KSD() const { return (ndims() == 5) ? desc_.strides[0] : 1; }
    inline int KSH() const { return desc_.strides[ndims()-4]; }
    inline int KSW() const { return desc_.strides[ndims()-3]; }

    inline int KDD() const { return (ndims() == 5) ? desc_.dilates[0] : 0; }
    inline int KDH() const { return desc_.dilates[ndims()-4]; }
    inline int KDW() const { return desc_.dilates[ndims()-3]; }

    inline int padFront() const
        { return (ndims() == 5) ? desc_.padding[0][0] : 0; }
    inline int padBack() const
        { return (ndims() == 5) ? desc_.padding[1][0] : 0; }
    inline int padT() const { return desc_.padding[0][ndims()-4]; }
    inline int padB() const { return desc_.padding[1][ndims()-4]; }
    inline int padL() const { return desc_.padding[0][ndims()-3]; }
    inline int padR() const { return desc_.padding[1][ndims()-3]; }

    inline bool with_bias() const
    { return !memory_desc_wrapper(desc_.bias_desc).is_zero(); }
    inline bool with_groups() const
    { return desc_.weights_desc.ndims == desc_.diff_src_desc.ndims + 1; }

    inline int ndims() const { return desc_.diff_src_desc.ndims; }
    virtual bool support_bias() const { return false; }

    bool has_zero_dim_memory() const {
        return false
            || memory_desc_wrapper(desc_.diff_src_desc).has_zero_dim()
            || memory_desc_wrapper(desc_.diff_dst_desc).has_zero_dim();
    }

    protected:
    const convolution_desc_t desc_;
    const primitive_attr_t   attr_;
    memory_desc_wrapper diff_src_mdw, weights_mdw, diff_bias_mdw, diff_dst_mdw;
};

namespace cpu {

struct gemm_convolution_bwd_data_t //: public cpu_primitive_t
{
    struct pd_t: public _vconv_bwd_data_pd_t {
        pd_t(   //engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr
                //const convolution_fwd_pd_t *hint_fwd_pd
            )
            : _vconv_bwd_data_pd_t(adesc, attr)
            , jcp_()
        {}

        //DECLARE_COMMON_PD_T(GEMM_IMPL_STR, gemm_convolution_bwd_data_t);

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

        virtual status_t init() //override
        {
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
            AND_(this->diff_src_pd().format() == src_format());
            AND_(this->diff_dst_pd().format() == src_format());
            AND_(this->weights_pd().format() == wei_format());
#undef AND_
            return ok ? status::success : status::unimplemented;
        }

        jit_gemm_conv_conf_t jcp_;

    protected:
        virtual status_t set_default_params() //override
        {
            using namespace memory_format;
            if (this->diff_src_pd().format() == any){
                memory_desc_wrapper& mdw = diff_src_pd();
                memory_format_t fmt = src_format();
                CHECK(set_format(mdw, fmt));
            }
            if (this->diff_dst_pd().format() == any)
                CHECK(set_format(this->diff_dst_pd(),   src_format()));
            if (this->weights_pd().format() == any)
                CHECK(set_format(this->weights_pd(),    wei_format()));
            return status::success;
        }
    };

    // all data types equal (and init() checks they're f32)
    typedef float data_type;
    data_type const* restrict pDataGradOut;
    data_type const* restrict pDataKernel;
    data_type      * restrict pDataGradIn;
    gemm_convolution_bwd_data_t(
            const pd_t *pd,
            //const input_vector &inputs, const output_vector &outputs
            const void* pDataGradOut,
            const void* pDataKernel,
            void* pDataGradIn
            )
        //: cpu_primitive_t(&conf_, inputs, outputs)
        : conf_(*pd)
        , pDataGradOut(     (data_type const*)pDataGradOut)
        , pDataKernel(      (data_type const*)pDataKernel)
        , pDataGradIn(      (data_type      *)pDataGradIn)
        , scratchpad_(nullptr)
    {
        using namespace prop_kind;

        jit_gemm_convolution_utils::init_conf(conf_.jcp_,
            *(conf_.desc()), conf_.diff_src_pd(), conf_.weights_pd(),
            conf_.diff_dst_pd(), omp_get_max_threads());

        size_t size = (size_t)conf_.jcp_.im2col_sz * sizeof(data_t);
        jit_gemm_convolution_utils::prepare_scratchpad(this->conf_.jcp_,
                &this->scratchpad_, size, this->conf_.jcp_.nthr);
    }

    ~gemm_convolution_bwd_data_t() {
        delete this->scratchpad_;
    };

    typedef typename prec_traits<data_type::f32>::type data_t;

    virtual void execute(/*event_t *e*/) {
        switch (conf_.desc()->prop_kind) {
        case prop_kind::backward_data:
            execute_backward_data();
            break;
        default:
            assert(!"invalid prop_kind");
        }
        //e->set_state(event_t::ready);
    }

private:
    void execute_backward_data();
    pd_t conf_;
    scratchpad_t *scratchpad_;
};
#endif // PARTIAL>=1 (include bwd_d)

#if PARTIAL >= 2
}//cpu::

struct _vconv_bwd_weights_pd_t{
    _vconv_bwd_weights_pd_t( const convolution_desc_t *adesc, const primitive_attr_t *attr)
        : desc_(*adesc), attr_(*attr)
          , src_mdw         (cdesc_().src_desc)
          , diff_weights_mdw(cdesc_().weights_desc )
          , diff_bias_mdw   (cdesc_().diff_bias_desc )
          , diff_dst_mdw    (cdesc_().diff_dst_desc )
    {}
    const convolution_desc_t *desc() const { return &desc_; }
    const convolution_desc_t cdesc_() const { return desc_; }

    memory_desc_wrapper& src_pd()           { return src_mdw; }
    memory_desc_wrapper& diff_dst_pd()      { return diff_dst_mdw; }
    memory_desc_wrapper& diff_weights_pd()  { return diff_weights_mdw; }
    memory_desc_wrapper& diff_bias_pd()     { return diff_bias_mdw; }

    virtual int n_inputs() const { return 2; }
    virtual int n_outputs() const { return 1 + with_bias(); }

    /* common conv aux functions */

    inline int MB() const { return desc_.src_desc.dims[0]; }

    inline int IC() const { return desc_.src_desc.dims[1]; }
    inline int OC() const { return desc_.diff_dst_desc.dims[1]; }
    inline int G() const
    { return with_groups() ? desc_.diff_weights_desc.dims[0] : 1; }

    inline int ID() const { return (ndims() == 5)
        ? desc_.src_desc.dims[2] : 1; }
    inline int IH() const { return desc_.src_desc.dims[ndims()-2]; }
    inline int IW() const { return desc_.src_desc.dims[ndims()-1]; }
    inline int OD() const { return (ndims() == 5)
        ? desc_.diff_dst_desc.dims[2] : 1; }
    inline int OH() const { return desc_.diff_dst_desc.dims[ndims()-2]; }
    inline int OW() const { return desc_.diff_dst_desc.dims[ndims()-1]; }
    inline int KD() const { return (ndims() == 5)
        ? desc_.diff_weights_desc.dims[2 + with_groups()] : 1; }
    inline int KH() const
    { return desc_.diff_weights_desc.dims[ndims() - (2 - with_groups())]; }
    inline int KW() const
    { return desc_.diff_weights_desc.dims[ndims() - (1 - with_groups())]; }

    inline int KSD() const { return (ndims() == 5) ? desc_.strides[0] : 1; }
    inline int KSH() const { return desc_.strides[ndims()-4]; }
    inline int KSW() const { return desc_.strides[ndims()-3]; }

    inline int KDD() const { return (ndims() == 5) ? desc_.dilates[0] : 0; }
    inline int KDH() const { return desc_.dilates[ndims()-4]; }
    inline int KDW() const { return desc_.dilates[ndims()-3]; }

    inline int padFront() const
        { return (ndims() == 5) ? desc_.padding[0][0] : 0; }
    inline int padBack() const
        { return (ndims() == 5) ? desc_.padding[1][0] : 0; }
    inline int padT() const { return desc_.padding[0][ndims()-4]; }
    inline int padB() const { return desc_.padding[1][ndims()-4]; }
    inline int padL() const { return desc_.padding[0][ndims()-3]; }
    inline int padR() const { return desc_.padding[1][ndims()-3]; }

    inline bool with_bias() const
    { return !memory_desc_wrapper(desc_.diff_bias_desc).is_zero(); }
    inline bool with_groups() const
    { return desc_.diff_weights_desc.ndims == desc_.diff_dst_desc.ndims + 1; }

    inline int ndims() const { return desc_.src_desc.ndims; }

    bool has_zero_dim_memory() const {
        return false
            || memory_desc_wrapper(desc_.src_desc).has_zero_dim()
            || memory_desc_wrapper(desc_.diff_dst_desc).has_zero_dim();
    }

    protected:
    const convolution_desc_t desc_;
    const primitive_attr_t   attr_;
    memory_desc_wrapper src_mdw, diff_weights_mdw, diff_bias_mdw, diff_dst_mdw;
};

namespace cpu {

struct gemm_convolution_bwd_weights_t //: public cpu_primitive_t
{
    struct pd_t: public _vconv_bwd_weights_pd_t {
        pd_t(   //engine_t *engine,
                const convolution_desc_t *adesc,
                const primitive_attr_t *attr
                //const convolution_fwd_pd_t *hint_fwd_pd
            )
            : _vconv_bwd_weights_pd_t(adesc, attr)
            , jcp_()
        {}

        //DECLARE_COMMON_PD_T(GEMM_IMPL_STR, gemm_convolution_bwd_weights_t);

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

        virtual status_t init() //override
        {
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
            AND_(this->src_pd().format() == src_format());
            AND_(this->diff_dst_pd().format() == src_format());
            AND_(this->diff_weights_pd().format() == wei_format());
#undef AND_
            return ok ? status::success : status::unimplemented;
        }

        jit_gemm_conv_conf_t jcp_;

    protected:
        virtual status_t set_default_params() //override
        {
            using namespace memory_format;
            if (this->src_pd().format() == any)
                CHECK(set_format(this->src_pd(),   src_format()));
            if (this->diff_dst_pd().format() == any)
                CHECK(set_format(this->diff_dst_pd(),  src_format()));
            if (this->diff_weights_pd().format() == any)
                CHECK(set_format(this->diff_weights_pd(),  wei_format()));
            if (this->diff_bias_pd().format() == any)
                CHECK(set_format(this->diff_bias_pd(), x));
            return status::success;
        }
    };

    typedef float data_type;
    data_type const* restrict pDataIn;
    data_type const* restrict pDataGradOut;
    data_type      * restrict pDataGradKernel;
    data_type      * restrict pDataGradBias;
    gemm_convolution_bwd_weights_t(
            const pd_t *pd,
            //const input_vector &inputs, const output_vector &outputs
            void const* pDataIn,
            void const* pDataGradOut,
            void      * pDataGradKernel,
            void      * pDataGradBias = nullptr /* libvednn does not support this */
            )
        //: cpu_primitive_t(&conf_, inputs, outputs)
        : conf_(*pd)
        , pDataIn(          (data_type const*)pDataIn)
        , pDataGradOut(     (data_type const*)pDataGradOut)
        , pDataGradKernel(  (data_type      *)pDataGradKernel)
        , pDataGradBias(    (data_type      *)pDataGradBias)
        , scratchpad_(nullptr)
    {
        using namespace prop_kind;

        jit_gemm_convolution_utils::init_conf(conf_.jcp_,
            *(conf_.desc()), conf_.src_pd(), conf_.diff_weights_pd(),
            conf_.diff_dst_pd(), omp_get_max_threads());
        const memory_desc_wrapper weights_d(conf_.diff_weights_pd());

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

    virtual void execute(/*event_t *e*/) {
        switch (conf_.desc()->prop_kind) {
        case prop_kind::backward_weights:
            execute_backward_weights();
            break;
        default:
            assert(!"invalid prop_kind");
        }
        //e->set_state(event_t::ready);
    }

private:
    void execute_backward_weights();
#define VE_OPENMP_BUG (defined(__ve) && 1)
#if VE_OPENMP_BUG
    void execute_backward_weights_bias();
#endif
    pd_t conf_;
    scratchpad_t *scratchpad_;
};
#endif // PARTIAL >=2 (incl bwd_d)

}
}
}

// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
#endif
