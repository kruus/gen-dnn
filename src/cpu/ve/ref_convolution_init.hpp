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

#ifndef CPU_VE_REF_CONVOLUTION_INIT_HPP
#define CPU_VE_REF_CONVOLUTION__INIT_HPP

#ifndef CPU_REF_CONVOLUTION_HPP
#error "This file should be included from src/cpu/ref_convolution.hpp"
#endif

// VE sometimes erroneously compiles long, complex logical expressions :(
#include "common/ve/consistency.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

template <impl::data_type_t src_type, impl::data_type_t wei_type,
        impl::data_type_t dst_type, impl::data_type_t acc_type>
inline status_t ref_convolution_fwd_t<src_type,wei_type,dst_type,acc_type>
::pd_t::init(engine_t *engine) {
    using namespace data_type;
    Consistency ok("ref_convolution_fwd_t...init");
#define AND_(...) SCHKVV(ok,(__VA_ARGS__))
    AND_(is_fwd());
    AND_(set_default_alg_kind(alg_kind::convolution_direct));
    AND_(expect_data_types(src_type, wei_type, data_type::undef,
                dst_type, acc_type));
    if (ok && with_bias()) {
        if (src_type == u8)
            AND_(utils::one_of(bias_md_.data_type, f32, s32, s8, u8));
        if (src_type == f32)
            AND_(bias_md_.data_type == f32);
    }
    AND_(set_default_formats());
    AND_(attr()->has_default_values(
                primitive_attr_t::skip_mask_t::oscale
                | primitive_attr_t::skip_mask_t::post_ops));
    AND_(output_scales_mask_ok());
    AND_(post_ops_ok());
#undef AND_
    return ok ? status::success : status::unimplemented;
}

template <impl::data_type_t diff_src_type, impl::data_type_t wei_type,
        impl::data_type_t diff_dst_type, impl::data_type_t acc_type>
inline status_t ref_convolution_bwd_data_t<diff_src_type, wei_type,
       diff_dst_type,acc_type>::pd_t::init(engine_t *engine)
{
    Consistency ok("ref_convolution_bwd_data_t...init");
#define AND_(...) SCHKVV(ok,(__VA_ARGS__))
    AND_(desc()->prop_kind == prop_kind::backward_data);
    AND_(set_default_alg_kind(alg_kind::convolution_direct));
    AND_(expect_data_types(diff_src_type, wei_type,
                data_type::undef, diff_dst_type, acc_type));
    AND_(set_default_formats());
    AND_(attr()->has_default_values(primitive_attr_t::skip_mask_t::oscale));
    AND_(output_scales_mask_ok());
#undef AND_
    return ok ? status::success : status::unimplemented;
}

template <impl::data_type_t src_type, impl::data_type_t diff_wei_type,
        impl::data_type_t diff_dst_type, impl::data_type_t acc_type>
inline status_t ref_convolution_bwd_weights_t<src_type, diff_wei_type,
       diff_dst_type, acc_type>::pd_t::init(engine_t *engine)
{
    Consistency ok("ref_convolution_bwd_weights_t...init");
#define AND_(...) SCHKVV(ok,(__VA_ARGS__))
    AND_(desc()->prop_kind == prop_kind::backward_weights);
    AND_(set_default_alg_kind(alg_kind::convolution_direct));
    AND_(expect_data_types(src_type, diff_wei_type, diff_wei_type,
                diff_dst_type, acc_type));
    AND_(set_default_formats());
    AND_(attr()->has_default_values());
#undef AND_
    return ok ? status::success : status::unimplemented;
}

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
#endif
