/*******************************************************************************
* Copyright 2020 NEC Labs America
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
#ifndef CPU_TARGET_H
#define CPU_TARGET_H
/** \file
 * extra build-time cpu/isa macros, based dnnl_config.h ONLY.
 * Some appear frequently, so short 0/1 values are preferred.
 * \sa dnnl_config.h */
#include "dnnl_config.h"

// TARGET_cpu[_subtype] 0/1 values establish uniform names based on
// CMAKE_SYSTEM_PROCESSOR and DNNL_ISA build option.
/// default build always is TARGET_X86_JIT
#define TARGET_X86_JIT DNNL_TARGET_X86_JIT
/// VANILLA "ref impls" build is a new option (equiv DNNL_X86_64?)
#define TARGET_X86 DNNL_TARGET_X86
/// A cross-compile target, uniform name for defined(__ve)
#define TARGET_VE DNNL_TARGET_VE

// Implies presence of intel intrinsics header.
#if defined(__x86_64__) || defined(_M_X64)
#define DNNL_X86_64
#endif

// other common variables come from cmakedefine
#if defined(DNNL_USE_MKL) && !defined(USE_MKL)
#define USE_MKL DNNL_USE_MKL
#endif
#if defined(DNNL_USE_CBLAS) && !defined(USE_CBLAS)
#define USE_CBLAS DNNL_USE_CBLAS
#endif

#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_BATCH_NORMALIZATION)
#define USE_batch_normalization 1
#else
#define USE_batch_normalization 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_BINARY)
#define USE_binary 1
#else
#define USE_binary 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_CONCAT)
#define USE_concat 1
#else
#define USE_concat 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_CONVOLUTION)
#define USE_convolution 1
#else
#define USE_convolution 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_DECONVOLUTION)
#define USE_deconvolution 1
#else
#define USE_deconvolution 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_ELTWISE)
#define USE_eltwise 1
#else
#define USE_eltwise 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_GEMM)
#define USE_gemm 1
#else
#define USE_gemm 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_INNER_PRODUCT)
#define USE_inner_product 1
#else
#define USE_inner_product 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_LAYER_NORMALIZATION)
#define USE_layer_normalization 1
#else
#define USE_layer_normalization 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_LRN)
#define USE_lrn 1
#else
#define USE_lrn 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_LOGSOFTMAX)
#define USE_logsoftmax 1
#else
#define USE_logsoftmax 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_MATMUL)
#define USE_matmul 1
#else
#define USE_matmul 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_POOLING)
#define USE_pooling 1
#else
#define USE_pooling 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_REORDER)
#define USE_reorder 1
#else
#define USE_reorder 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_RESAMPLING)
#define USE_resampling 1
#else
#define USE_resampling 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_RNN)
#define USE_rnn 1
#else
#define USE_rnn 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_SHUFFLE)
#define USE_shuffle 1
#else
#define USE_shuffle 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_SUM)
#define USE_sum 1
#else
#define USE_sum 0
#endif
#if defined(DNNLPRIM_ALL) or defined(DNNLPRIM_SOFTMAX)
#define USE_softmax 1
#else
#define USE_softmax 0
#endif

// expand to code [or nothing] depending on 0/1 flag USE_kind
#define IF_USE_KIND0(kind, ...)
#define IF_USE_KIND1(kind, ...) __VA_ARGS__
#define IF_USE_KIND(kind, ...) CONCAT2(IF_USE_KIND, USE_##kind)(kind, __VA_ARGS__)

#endif // CPU_TARGET_H
