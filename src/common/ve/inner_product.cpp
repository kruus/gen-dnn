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

#include <assert.h>

// seems to be a compile issue with init checks - using consistency.hpp to debug
// the problem disappeared.
//
//#include <iostream> // debug 'one_of' error
//#include <iomanip>

#include "dnnl.h"

#include "consistency.hpp"
#include "c_types_map.hpp"
#include "type_helpers.hpp"
#include "utils.hpp"

using namespace dnnl::impl;
using namespace dnnl::impl::utils;
using namespace dnnl::impl::status;
using namespace dnnl::impl::prop_kind;
using namespace dnnl::impl::types;


namespace {
status_t ip_desc_init(inner_product_desc_t *ip_desc, prop_kind_t prop_kind,
        const memory_desc_t *src_desc, const memory_desc_t *weights_desc,
        const memory_desc_t *bias_desc, const memory_desc_t *dst_desc) {
    Consistency ok("ip_desc_init");
#define AND_(...) SCHK(ok,__VA_ARGS__)
    AND_((!any_null(ip_desc, src_desc, weights_desc, dst_desc)));
    if (!ok) return invalid_arguments;

    auto id = inner_product_desc_t();
    id.primitive_kind = primitive_kind::inner_product;
    id.prop_kind = prop_kind;

    id.diff_src_desc = id.src_desc = zero_md();
    id.diff_dst_desc = id.dst_desc = zero_md();
    id.diff_weights_desc = id.weights_desc = zero_md();
    id.diff_bias_desc = id.bias_desc = zero_md();

    const bool is_fwd = one_of(prop_kind, forward_training, forward_inference);
    const bool with_bias
            = bias_desc && bias_desc->format_kind != format_kind::undef;

    bool runtime_dims_or_strides
            = memory_desc_wrapper(src_desc).has_runtime_dims_or_strides()
            || memory_desc_wrapper(weights_desc).has_runtime_dims_or_strides()
            || memory_desc_wrapper(dst_desc).has_runtime_dims_or_strides();
    if (with_bias)
        runtime_dims_or_strides = runtime_dims_or_strides
                || memory_desc_wrapper(bias_desc).has_runtime_dims_or_strides();
    AND_((!runtime_dims_or_strides));
    if (!ok) return unimplemented;

    (prop_kind == backward_data ? id.diff_src_desc : id.src_desc) = *src_desc;
    (is_fwd ? id.dst_desc : id.diff_dst_desc) = *dst_desc;
    (prop_kind == backward_weights ? id.diff_weights_desc : id.weights_desc)
            = *weights_desc;
    if (with_bias)
        (prop_kind == backward_weights ? id.diff_bias_desc : id.bias_desc)
                = *bias_desc;

    id.accum_data_type = types::default_accum_data_type(src_desc->data_type,
            weights_desc->data_type, dst_desc->data_type, prop_kind);
    AND_((!id.accum_data_type == data_type::undef));
    if (!ok) return invalid_arguments;

    AND_((memory_desc_wrapper(weights_desc).nelems()));
    AND_((one_of(src_desc->ndims, 2, 3, 4, 5) && dst_desc->ndims == 2));
    AND_((weights_desc->ndims == src_desc->ndims));
    AND_(((with_bias ? bias_desc->ndims == 1 : true)));
    AND_(((with_bias ? bias_desc->dims[0] == dst_desc->dims[1] : true)));
    AND_((src_desc->dims[0] == dst_desc->dims[0]));
    AND_((array_cmp(&src_desc->dims[1], &weights_desc->dims[1],
                    src_desc->ndims - 1)));
    AND_((dst_desc->dims[1] == weights_desc->dims[0]));
    if (!ok) return invalid_arguments;

    *ip_desc = id;
    return success;
#undef AND_
}
} // namespace

status_t dnnl_inner_product_forward_desc_init(inner_product_desc_t *ip_desc,
        prop_kind_t prop_kind, const memory_desc_t *src_desc,
        const memory_desc_t *weights_desc, const memory_desc_t *bias_desc,
        const memory_desc_t *dst_desc) {
    Consistency ok("dnnl_inner_product_forward_desc_init");
#define AND_(...) SCHK(ok,__VA_ARGS__)
#define SHOW(XXX) do{ std::cout<<std::setw(60)<<#XXX<<" is "<<XXX<<std::endl; }while(0)
    //printf("(int)prop_kind=%d, (int)forward_training=%d, (int)forward_inference=%d\n",
    //       (int)prop_kind, (int)forward_training, (int)forward_inference);
    //printf(" CHECKME: ip desc init prop_kind %s\n", dnnl_prop_kind2str(prop_kind));
    //SHOW(one_of(prop_kind,forward_training));
    //SHOW(one_of(prop_kind,forward_inference));
    //SHOW(one_of(prop_kind,forward_training,forward_inference));
    AND_((one_of(prop_kind, forward_training, forward_inference)));
    if (!ok)
        return invalid_arguments;
    return ip_desc_init(
            ip_desc, prop_kind, src_desc, weights_desc, bias_desc, dst_desc);
#undef AND_
}

status_t dnnl_inner_product_backward_data_desc_init(
        inner_product_desc_t *ip_desc, const memory_desc_t *diff_src_desc,
        const memory_desc_t *weights_desc, const memory_desc_t *diff_dst_desc) {
    return ip_desc_init(ip_desc, backward_data, diff_src_desc, weights_desc,
            nullptr, diff_dst_desc);
}

status_t dnnl_inner_product_backward_weights_desc_init(
        inner_product_desc_t *ip_desc, const memory_desc_t *src_desc,
        const memory_desc_t *diff_weights_desc,
        const memory_desc_t *diff_bias_desc,
        const memory_desc_t *diff_dst_desc) {
    return ip_desc_init(ip_desc, backward_weights, src_desc, diff_weights_desc,
            diff_bias_desc, diff_dst_desc);
}

// vim: et ts=4 sw=4 cindent cino+=l0,\:4,N-s
