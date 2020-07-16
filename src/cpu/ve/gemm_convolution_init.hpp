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

#ifndef CPU_VE_GEMM_CONVOLUTION_INIT_HPP
#define CPU_VE_GEMM_CONVOLUTION_INIT_HPP

#ifndef CPU_GEMM_CONVOLUTION_HPP
#error "This file should be included from src/cpu/gemm_convolution.hpp"
#endif

// VE sometimes erroneously compiles long, complex logical expressions :(
#include "common/ve/consistency.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

inline status_t gemm_convolution_fwd_t::pd_t::init(engine_t *engine) {
    Consistency ok("gemm_convolution_fwd_t::pd_t::init");
#define AND_(...) SCHK(ok,(__VA_ARGS__))
    AND_(is_fwd());
    AND_(set_default_alg_kind(alg_kind::convolution_direct));
    AND_(expect_data_types(data_type::f32, data_type::f32,
                         data_type::f32, data_type::f32, data_type::f32));
    AND_(!has_zero_dim_memory());
    AND_(set_default_formats_common(dat_tag(), wei_tag(), dat_tag()));
    AND_(attr()->has_default_values(primitive_attr_t::skip_mask_t::post_ops));
    AND_(post_ops_ok());
    AND_(memory_desc_matches_tag(*src_md(), dat_tag()));
    AND_(memory_desc_matches_tag(*dst_md(), dat_tag()));
    AND_(memory_desc_matches_tag(*weights_md(), wei_tag()));
    if (!ok) return status::unimplemented;

    auto scratchpad = scratchpad_registry().registrar();
    return jit_gemm_convolution_utils::init_conf(jcp_, scratchpad,
            *desc(), src_md(), weights_md(0), dst_md(),
            dnnl_get_max_threads());
#undef AND_
}

inline status_t gemm_convolution_bwd_data_t::pd_t::init(engine_t *engine) {
    Consistency ok("gemm_convolution_bwd_data_t::pd_t::init");
#define AND_(...) SCHK(ok,(__VA_ARGS__))
    AND_(desc()->prop_kind == prop_kind::backward_data);
    AND_(set_default_alg_kind(alg_kind::convolution_direct));
    AND_(expect_data_types(data_type::f32, data_type::f32,
                data_type::undef, data_type::f32, data_type::f32));
    AND_(!has_zero_dim_memory());
    AND_(set_default_formats_common(
                dat_tag(), wei_tag(), dat_tag()));
    AND_(attr()->has_default_values());
    AND_(memory_desc_matches_tag(*diff_src_md(), dat_tag()));
    AND_(memory_desc_matches_tag(*diff_dst_md(), dat_tag()));
    AND_(memory_desc_matches_tag(*weights_md(), wei_tag()));
    if (!ok) return status::unimplemented;

    auto scratchpad = scratchpad_registry().registrar();
    return jit_gemm_convolution_utils::init_conf(jcp_, scratchpad,
            *desc(), diff_src_md(), weights_md(0), diff_dst_md(),
            dnnl_get_max_threads());
#undef AND_
}

inline status_t gemm_convolution_bwd_weights_t::pd_t::init(engine_t *engine) {
    Consistency ok("gemm_convolution_bwd_weights_t::pd_t::init");
#define AND_(...) SCHK(ok,(__VA_ARGS__))
    AND_(desc()->prop_kind == prop_kind::backward_weights);
    AND_(set_default_alg_kind(alg_kind::convolution_direct));
    AND_(expect_data_types(data_type::f32, data_type::f32,
                data_type::f32, data_type::f32, data_type::f32));
    AND_(!has_zero_dim_memory());
    AND_(set_default_formats_common(dat_tag(), wei_tag(), dat_tag()));
    AND_(attr()->has_default_values());
    AND_(memory_desc_matches_tag(*src_md(), dat_tag()));
    AND_(memory_desc_matches_tag(*diff_dst_md(), dat_tag()));
    AND_(memory_desc_matches_tag(*diff_weights_md(), wei_tag()));
    if (!ok) return status::unimplemented;

    auto scratchpad = scratchpad_registry().registrar();
    return jit_gemm_convolution_utils::init_conf(jcp_, scratchpad,
            *desc(), src_md(), diff_weights_md(0), diff_dst_md(),
            dnnl_get_max_threads());
}

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // CPU_VE_GEMM_CONVOLUTION_INIT_HPP
