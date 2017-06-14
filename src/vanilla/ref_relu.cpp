/*******************************************************************************
* Copyright 2016-2017 Intel Corporation
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
#include <math.h>

#include "c_types_map.hpp"
#include "type_helpers.hpp"

#include "ref_relu.hpp"

#define REF_RELU_DBG 0
#if REF_RELU_DBG
#include <iostream>
#include "mkldnn_io.h"
#endif

namespace mkldnn {
namespace impl {
namespace cpu {

template <impl::data_type_t data_type>
ref_relu_fwd_t<data_type>::ref_relu_fwd_t(const pd_t *pd,
        const input_vector &inputs, const output_vector &outputs)
: cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {
#if REF_RELU_DBG
    using namespace std;
    cout<<"\n+relu_fwd_t:"
        <<"\n            kind()="<<this->kind() // mkldnn:impl::primitive_kind_t
        <<"\n            inputs,outputs.size()="<<this->inputs().size()<<","<<this->outputs().size()
        <<"\n            conf_.n_inputs(),n_outputs()"<<conf_.n_inputs()<<","<<conf_.n_outputs();
#if REF_RELU_DBG > 1
    if(conf_.n_inputs() > 0){
        cout<<"\n            input_pd(0)->kind() "<<conf_.input_pd(0)->kind()
            <<"\n           *           ->desc() "<<*conf_.input_pd(0)->desc()
            ;
    }
    if(conf_.n_outputs() > 0){
        cout<<"\n            output_pd(0)->kind() "<<conf_.output_pd(0)->kind()
            <<"\n           *            ->desc() "<<*conf_.output_pd(0)->desc()
            ;
    }
#endif
    cout<<endl;
#endif
}
template <impl::data_type_t data_type>
void ref_relu_fwd_t<data_type>::execute_forward_generic() {
    auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto dst = reinterpret_cast<data_t*>(this->memory(0));

    const memory_desc_wrapper data_d(conf_.src_pd());

    const int MB = conf_.MB();
    const int C = conf_.C();
    const int H = conf_.H();
    const int W = conf_.W();
    const double negative_slope = conf_.desc()->negative_slope;

#   pragma omp parallel for collapse(4) schedule(static)
    for (int n = 0; n < MB; ++n) {
        for (int c = 0; c < C; ++c) {
            for (int h = 0; h < H; ++h) {
                for (int w = 0; w < W; ++w) {
                    auto d_off = data_d.off(n, c, h, w);
                    data_t s = src[d_off];
                    data_t &d = dst[d_off];
                    d = (s > 0) ? s : static_cast<data_t>(s * negative_slope);
                }
            }
        }
    }
}

template <impl::data_type_t data_type>
void ref_relu_fwd_t<data_type>::execute_forward_dense() {
    auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto dst = reinterpret_cast<data_t*>(this->memory(0));

    const memory_desc_wrapper data_d(conf_.src_pd());
#if REF_RELU_DBG
    { char buf[1024]; mkldnn_name_memory_desc(data_d._md,buf,1024); std::cout<<"\nref_relu_fwd_t<>::execut_forward_dense() data_d = "<<buf<<std::endl; }
#endif

    const size_t nelems = data_d.nelems();
    const double negative_slope = conf_.desc()->negative_slope;

    src += data_d.blocking_desc().offset_padding;
    dst += data_d.blocking_desc().offset_padding;

#   pragma omp parallel for schedule(static)
    for (size_t e = 0; e < nelems; ++e) {
        dst[e] = static_cast<data_t>(src[e] * ((src[e] > 0) ? 1. : negative_slope));
    }
}

template <impl::data_type_t data_type>
void ref_relu_bwd_t<data_type>::execute_backward_generic() {
    auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto diff_dst = reinterpret_cast<const data_t *>(this->input_memory(1));
    auto diff_src = reinterpret_cast<data_t*>(this->memory(0));

    const memory_desc_wrapper data_d(conf_.src_pd());
    const memory_desc_wrapper diff_data_d(conf_.diff_src_pd());

    const int MB = conf_.MB();
    const int C = conf_.C();
    const int H = conf_.H();
    const int W = conf_.W();
    const double negative_slope = conf_.desc()->negative_slope;

#   pragma omp parallel for collapse(4) schedule(static)
    for (int n = 0; n < MB; ++n) {
        for (int c = 0; c < C; ++c) {
            for (int h = 0; h < H; ++h) {
                for (int w = 0; w < W; ++w) {
                    auto data_off = data_d.off(n, c, h, w);
                    auto diff_data_off = diff_data_d.off(n, c, h, w);
                    data_t s = src[data_off];
                    data_t dd = diff_dst[diff_data_off];
                    data_t &ds = diff_src[diff_data_off];
                    ds = static_cast<data_t>(dd * ((s > 0) ? 1. : negative_slope));
                }
            }
        }
    }
}

template <impl::data_type_t data_type>
void ref_relu_bwd_t<data_type>::execute_backward_dense() {
    auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto diff_dst = reinterpret_cast<const data_t *>(this->input_memory(1));
    auto diff_src = reinterpret_cast<data_t*>(this->memory(0));

    const memory_desc_wrapper data_d(conf_.src_pd());
    const memory_desc_wrapper diff_data_d(conf_.diff_src_pd());

    const size_t nelems = data_d.nelems();
    const double negative_slope = conf_.desc()->negative_slope;

    src += data_d.blocking_desc().offset_padding;
    diff_dst += diff_data_d.blocking_desc().offset_padding;
    diff_src += diff_data_d.blocking_desc().offset_padding;

#   pragma omp parallel for schedule(static)
    for (size_t e = 0; e < nelems; ++e) {
        diff_src[e] = static_cast<data_t>(diff_dst[e] * ((src[e] > 0) ? 1. : negative_slope));
    }
}

template struct ref_relu_fwd_t<data_type::f32>;
template struct ref_relu_fwd_t<data_type::s32>;
template struct ref_relu_fwd_t<data_type::s16>;
template struct ref_relu_fwd_t<data_type::s8>;
template struct ref_relu_fwd_t<data_type::u8>;

template struct ref_relu_bwd_t<data_type::f32>;

}
}
}

// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
