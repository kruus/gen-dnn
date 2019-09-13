/*******************************************************************************
* Copyright 2018 Intel Corporation
* MODIFICATIONS Copyright 2019 NEC Labs America
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
#ifndef MKLDNN_GEMM_SUBSET_HPP
#define MKLDNN_GEMM_SUBSET_HPP
#include "mkldnn_subset.h"

#if !defined(TYPE_MAPPING_HPP) && !defined(MKLDNN_CONV_SUBSET_HPP)
namespace mkldnn {
namespace impl {

using status_t = mkldnn_status_t;
namespace status {
    const status_t success = mkldnn_success;
    const status_t out_of_memory = mkldnn_out_of_memory;
    const status_t try_again = mkldnn_try_again;
    const status_t invalid_arguments = mkldnn_invalid_arguments;
    const status_t not_ready = mkldnn_not_ready;
    const status_t unimplemented = mkldnn_unimplemented;
    const status_t iterator_ends = mkldnn_iterator_ends;
    const status_t runtime_error = mkldnn_runtime_error;
    const status_t not_required = mkldnn_not_required;
}

using round_mode_t = mkldnn_round_mode_t;
namespace round_mode {
    const round_mode_t nearest = mkldnn_round_nearest;
    const round_mode_t down = mkldnn_round_down;
}


}} // mkldnn::impl::
#endif // !defined(TYPE_MAPPING_HPP) && !defined(MKLDNN_CONV_SUBSET_HPP)
/* vim: set et ts=4 sw=4 cino=^=l0,\:0,N-s: */
#endif // MKLDNN_GEMM_SUBSET_HPP
