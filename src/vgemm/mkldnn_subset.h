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
#ifndef MKLDNN_GEMM_SUBSET_H
#define MKLDNN_GEMM_SUBSET_H

#define TARGET_VANILLA 1
#define USE_CBLAS 1

#include "mkldnn_os.h"

#define CHAIn2(a,b) a b
#define CHAIN2(a,b) CHAIn2(a,b)

#define CONCAt2(a,b) a ## b
#define CONCAT2(a,b) CONCAt2(a,b)

#define STRINGIFy(s) #s
#define STRINGIFY(s) STRINGIFy(s)

#define PRAGMA_MACRo(x) _Pragma(#x)
#define PRAGMA_MACRO(x) PRAGMA_MACRo(x)

#if !defined(MKLDNN_TYPES_H) && !defined(MKLDNN_CONV_SUBSET_H) && !defined(TYPE_MAPPING_HPP)
#ifdef __cplusplus
extern "C" {
#endif
/** Status values returned by Intel(R) MKL-DNN functions. */
typedef enum {
    /** The operation was successful */
    mkldnn_success = 0,
    /** The operation failed due to an out-of-memory condition */
    mkldnn_out_of_memory = 1,
    /** The operation failed and should be retried */
    mkldnn_try_again = 2,
    /** The operation failed because of incorrect function arguments  */
    mkldnn_invalid_arguments = 3,
    /** The operation failed because a primitive was not ready for execution */
    mkldnn_not_ready = 4,
    /** The operation failed because requested functionality is not implemented
     */
    mkldnn_unimplemented = 5,
    /** Primitive iterator passed over last primitive descriptor */
    mkldnn_iterator_ends = 6,
    /** Primitive or engine failed on execution */
    mkldnn_runtime_error = 7,
    /** Queried element is not required for given primitive */
    mkldnn_not_required = 8,
} mkldnn_status_t;

/** Rounding mode */
typedef enum {
    /** Round nearest */
    mkldnn_round_nearest = 1,
    /** Round down */
    mkldnn_round_down = 2,
} mkldnn_round_mode_t;

#ifdef __cplusplus
}
#endif
#endif // !defined(MKLDNN_TYPES_H) && !defined(MKLDNN_CONV_SUBSET_H)
/* vim: set et ts=4 sw=4 cino=^=l0,\:0,N-s: */
#endif // MKLDNN_GEMM_SUBSET_H
