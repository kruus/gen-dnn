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

#ifndef CPU_REF_CONVOLUTION_HPP
#define CPU_REF_CONVOLUTION_HPP

#include <assert.h>

#include "common/c_types_map.hpp"
#include "common/primitive.hpp"
#include "common/type_helpers.hpp"
#include "common/utils.hpp"

#include "cpu/cpu_convolution_pd.hpp"
#include "cpu/ref_eltwise.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

template <impl::data_type_t src_type, impl::data_type_t wei_type = src_type,
        impl::data_type_t dst_type = src_type,
        impl::data_type_t acc_type = dst_type>
struct ref_convolution_fwd_t : public primitive_t {
    struct pd_t : public cpu_convolution_fwd_pd_t {
        using cpu_convolution_fwd_pd_t::cpu_convolution_fwd_pd_t;

#if defined(__ve)
        DECLARE_COMMON_PD_T(this->impl_name(), ref_convolution_fwd_t);

        // allow verbose debug of "why not"reason
        status_t init(engine_t *engine);

        // XXX get rid of unset, init ker_type_ in ref_convolution_fwd_t constructor?
        typedef enum { unset=-1, any=0, plain } ker_type_t;
        ker_type_t ker_type() const {return ker_type_;}
    private:
        ker_type_t ker_type_ = unset; // unset -- set during init(engine)
        void get_ker_type(ker_type_t &ker_type) const {
            using namespace utils;
            auto src_d = memory_desc_wrapper(src_md());
            const dnnl_dims_t &src_str = src_d.blocking_desc().strides;
            const dim_t src_ic_stride = src_str[1];

            auto weights_d = memory_desc_wrapper(weights_md());
            const dnnl_dims_t &weights_str = weights_d.blocking_desc().strides;
            // orig used src_d.ndims(), tougher calc.
            //const int gr_shift = with_groups() ? 1 : 0;
            //const int src_ndims = src_d.ndims();
            //const dim_t weights_kw_stride
            //    = (src_ndims >= 3) ? weights_str[src_ndims - 1 + gr_shift] : 0;
            //const int weights_ndims = weights_d.ndims();
            //AND_( src_ndims - 1 + gr_shift == weights_ndims - 1 );
            const int weights_ndims = weights_d.ndims();
            const dim_t weights_kw_stride = weights_ndims
                ? weights_str[weights_ndims - 1]: 0;

            ker_type = (src_d.is_plain() && weights_d.is_plain()
                    && src_ic_stride == 1 && weights_kw_stride == 1
                    ? plain: any);
        }
    private:
        // name() public, impl_name() private
        // impl_name() must be const, and may be called BEFORE init
        char const* impl_name() const {
            ker_type_t kt = ker_type_;
            if (kt == unset) {
                get_ker_type(kt);
            }
            return kt == any? "ref:any": "ref:plain";
        }
#else
        DECLARE_COMMON_PD_T("ref:any", ref_convolution_fwd_t);

        status_t init(engine_t *engine) {
            using namespace data_type;
            using smask_t = primitive_attr_t::skip_mask_t;

            bool ok = true && is_fwd()
                    && set_default_alg_kind(alg_kind::convolution_direct)
                    && expect_data_types(src_type, wei_type, data_type::undef,
                            dst_type, acc_type)
                    && IMPLICATION(with_bias(),
                            true
                                    && IMPLICATION(src_type == u8,
                                            utils::one_of(bias_md_.data_type,
                                                    f32, s32, s8, u8))
                                    && IMPLICATION(src_type == f32,
                                            bias_md_.data_type == f32))
                    && set_default_formats()
                    && attr()->has_default_values(smask_t::oscale
                            //| smask_t::zero_points_runtime
                            | smask_t::post_ops)
                    && output_scales_mask_ok() //&& zero_points_ok()
                    && post_ops_ok();
            return ok ? status::success : status::unimplemented;
        }
#endif

    protected:
        bool set_default_formats() {
            using namespace format_tag;
            // TODO VE libvednn defaults might be different
            auto dat_tag = utils::pick(ndims() - 3, nwc, nhwc, ndhwc);
            auto wei_tag = with_groups()
                    ? utils::pick(ndims() - 3, goiw, goihw, goidhw)
                    : utils::pick(ndims() - 3, oiw, oihw, oidhw);
            return set_default_formats_common(dat_tag, wei_tag, dat_tag);
        }

        bool output_scales_mask_ok() const {
            using namespace data_type;
            const auto &mask = attr()->output_scales_.mask_;
#if 0 && defined(__ve)
            // allow some 'useless' oscale settings for benchdnn tests
            // (esp if gemm convolutions are disabled ? XXX)
            return 1;
#else // standard setting restricts ref convolution output scale settings
            return IMPLICATION(!utils::one_of(src_type, s8, u8),
                           attr()->output_scales_.has_default_values())
                    && (mask == 0 || mask == 1 << 1);
#endif
        }

        bool post_ops_ok() const {
            // to be consistent with other primitives and documentation
            // the number and sequence of post op is limited
            using namespace dnnl::impl::primitive_kind;
            auto const &po = attr()->post_ops_;
            auto is_eltwise
                    = [&](int idx) { return po.entry_[idx].is_eltwise(); };

            switch (po.len_) {
                case 0: return true;
                case 1: return is_eltwise(0) || po.contain(sum, 0);
                case 2:
                    return (po.contain(sum, 0) && is_eltwise(1))
                            || (po.contain(sum, 1) && is_eltwise(0));
                default: return false;
            }
            return false;
        }
    };

    ref_convolution_fwd_t(const pd_t *apd) : primitive_t(apd) {
        //printf("+ref_convolution_fwd_t\n");
        for (int idx = 0; idx < dnnl_post_ops::capacity; ++idx)
            eltwises_[idx] = nullptr;
        auto &post_ops = pd()->attr()->post_ops_;
        for (int idx = 0; idx < post_ops.len_; ++idx) {
            const auto &e = post_ops.entry_[idx];
            if (e.kind != dnnl_sum)
                eltwises_[idx] = new ref_eltwise_scalar_fwd_t(e.eltwise);
        }
    }

    ~ref_convolution_fwd_t() {
        //printf("-ref_convolution_fwd_t\n");
        for (int idx = 0; idx < dnnl_post_ops::capacity; ++idx)
            if (eltwises_[idx] != nullptr) delete eltwises_[idx];
    }

    typedef typename prec_traits<src_type>::type src_data_t;
    typedef typename prec_traits<wei_type>::type wei_data_t;
    typedef typename prec_traits<dst_type>::type dst_data_t;
    typedef typename prec_traits<acc_type>::type acc_data_t;

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        execute_forward(ctx);
        return status::success;
    }

private:
#if defined(__ve)
    void execute_forward_plain(const exec_ctx_t &ctx) const;
    void execute_forward_any(const exec_ctx_t &ctx) const;
    void execute_forward(const exec_ctx_t &ctx) const {
        if (pd()->ker_type() == pd_t::plain)
            execute_forward_plain(ctx);
        else
            execute_forward_any(ctx);
    }
#else
    void execute_forward(const exec_ctx_t &ctx) const;
#endif
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
    ref_eltwise_scalar_fwd_t *eltwises_[dnnl_post_ops::capacity];
};

template <impl::data_type_t diff_src_type, impl::data_type_t wei_type,
        impl::data_type_t diff_dst_type,
        impl::data_type_t acc_type = diff_src_type>
struct ref_convolution_bwd_data_t : public primitive_t {
    struct pd_t : public cpu_convolution_bwd_data_pd_t {
        using cpu_convolution_bwd_data_pd_t::cpu_convolution_bwd_data_pd_t;

        DECLARE_COMMON_PD_T("ref:any", ref_convolution_bwd_data_t);

#if defined(__ve)
        status_t init(engine_t *engine);
#else
        status_t init(engine_t *engine) {
            bool ok = true && desc()->prop_kind == prop_kind::backward_data
                    && set_default_alg_kind(alg_kind::convolution_direct)
                    && expect_data_types(diff_src_type, wei_type,
                            data_type::undef, diff_dst_type, acc_type)
                    && set_default_formats()
                    && attr()->has_default_values(
                            primitive_attr_t::skip_mask_t::oscale)
                    && output_scales_mask_ok();

            return ok ? status::success : status::unimplemented;
        }
#endif

        virtual bool support_bias() const override { return true; }

    protected:
        bool set_default_formats() {
            using namespace format_tag;
            auto dat_tag = utils::pick(ndims() - 3, nwc, nhwc, ndhwc);
            auto wei_tag = with_groups()
                    ? utils::pick(ndims() - 3, goiw, goihw, goidhw)
                    : utils::pick(ndims() - 3, oiw, oihw, oidhw);
            return set_default_formats_common(dat_tag, wei_tag, dat_tag);
        }

        bool output_scales_mask_ok() const {
            using namespace data_type;
            const auto &mask = attr()->output_scales_.mask_;
            return 1 //&& IMPLICATION(!utils::one_of(diff_dst_type, s8, u8),
                    //       attr()->output_scales_.has_default_values())
                    && (mask == 0 || mask == 1 << 1);
        }
    };

    ref_convolution_bwd_data_t(const pd_t *apd) : primitive_t(apd) {
        //printf("+ref_convolution_bwd_data_t\n");
    }

    ~ref_convolution_bwd_data_t() {
        //printf("-ref_convolution_bwd_data_t\n");
    }

    typedef typename prec_traits<diff_src_type>::type diff_src_data_t;
    typedef typename prec_traits<wei_type>::type wei_data_t;
    typedef typename prec_traits<diff_dst_type>::type diff_dst_data_t;
    typedef typename prec_traits<acc_type>::type acc_data_t;

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        execute_backward_data(ctx);
        return status::success;
    }

private:
    void execute_backward_data(const exec_ctx_t &ctx) const;
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
};

template <impl::data_type_t src_type, impl::data_type_t diff_wei_type,
        impl::data_type_t diff_dst_type,
        impl::data_type_t acc_type = diff_wei_type>
struct ref_convolution_bwd_weights_t : public primitive_t {
    struct pd_t : public cpu_convolution_bwd_weights_pd_t {
        using cpu_convolution_bwd_weights_pd_t::
                cpu_convolution_bwd_weights_pd_t;

        DECLARE_COMMON_PD_T("ref:any", ref_convolution_bwd_weights_t);

#if defined(__ve)
        status_t init(engine_t *engine);
#else
        status_t init(engine_t *engine) {
            bool ok = true && desc()->prop_kind == prop_kind::backward_weights
                    && set_default_alg_kind(alg_kind::convolution_direct)
                    && expect_data_types(src_type, diff_wei_type, diff_wei_type,
                            diff_dst_type, acc_type)
                    && set_default_formats() && attr()->has_default_values();
            return ok ? status::success : status::unimplemented;
        }
#endif

    protected:
        bool set_default_formats() {
            using namespace format_tag;
            auto dat_tag = utils::pick(ndims() - 3, ncw, nchw, ncdhw);
            auto wei_tag = with_groups()
                    ? utils::pick(ndims() - 3, goiw, goihw, goidhw)
                    : utils::pick(ndims() - 3, oiw, oihw, oidhw);
            return set_default_formats_common(dat_tag, wei_tag, dat_tag);
        }
    };

    ref_convolution_bwd_weights_t(const pd_t *apd) : primitive_t(apd) {
        //printf("+ref_convolution_bwd_data_t\n");
    }

    ~ref_convolution_bwd_weights_t() {
        //printf("-ref_convolution_bwd_data_t\n");
    }

    typedef typename prec_traits<src_type>::type src_data_t;
    typedef typename prec_traits<diff_wei_type>::type diff_wei_data_t;
    typedef typename prec_traits<diff_dst_type>::type diff_dst_data_t;
    typedef typename prec_traits<acc_type>::type acc_data_t;

    virtual status_t execute(const exec_ctx_t &ctx) const override {
        execute_backward_weights(ctx);
        return status::success;
    }

private:
    void execute_backward_weights(const exec_ctx_t &ctx) const;
    const pd_t *pd() const { return (const pd_t *)primitive_t::pd().get(); }
};

} // namespace cpu
} // namespace impl
} // namespace dnnl

#if defined(__ve)
#include "cpu/ve/ref_convolution_init.hpp"
#endif

#endif

// vim: et ts=4 sw=4 cindent cino+=l0,\:4,N-s
