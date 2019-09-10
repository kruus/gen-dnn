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

#include "mkldnn_types.h"

#include "c_types_map.hpp"
#include "gemm_convolution.hpp"
#include "utils.hpp"
#include "type_helpers.hpp"
#include "mkldnn_thread.hpp"

#if !defined(TARGET_VANILLA)
#error "this file should is specific to TARGET_VANILLA compilation"
#endif

using namespace mkldnn::impl::status;
using namespace mkldnn::impl::memory_format;
using namespace mkldnn::impl::utils;

namespace mkldnn {
namespace impl {
namespace cpu {

#if 1 // ncc has issues here. This loop was split from src/vanilla/gemm_convolution_bwd_w.cpp
void gemm_convolution_bwd_weights_t::execute_backward_weights_bias() {
    //auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto diff_dst = reinterpret_cast<const data_t *>(this->input_memory(1));
    //auto diff_weights = reinterpret_cast<data_t*>(this->memory(0));
    auto diff_bias = reinterpret_cast<data_t *>(this->memory(1));

    jit_gemm_conv_conf_t &jcp = this->conf_.jcp_;
    const int K = jcp.os * jcp.od;
    //const size_t src_step = jcp.ic * jcp.ih * jcp.iw * jcp.id;
    const size_t dst_step = jcp.oc * K;
    //const size_t weights_g_size = jcp.ic * jcp.oc * jcp.ks;

    //const int k = jcp.os;
    //const int N = jcp.oc;
    //const int M = jcp.ic * jcp.ks;
    //const int LDA = jcp.im2col_sz ? k : K;
    //const data_t zero = 0.0, one = 1.0;

    //data_t *col = nullptr, *wei_reduction = nullptr;
    //ptrdiff_t wei_offset = 0;
    //if (jcp.im2col_sz) {
    //    //col = (data_t *)this->scratchpad_->get();
    //    wei_offset = jcp.im2col_sz * jcp.nthr;
    //}
    //if (jcp.need_wei_reduction)
    //    //wei_reduction = (data_t *)this->scratchpad_->get() + wei_offset;
#if 0
    // weights update, omp loop, executed in src/vanilla/gemm_convolution_bwd_w.cpp
#endif
#if 1
    if (jcp.with_bias) {
        const size_t work_amount = jcp.ngroups * jcp.oc;
        OMP(parallel)//;
        {
            const int ithr = omp_get_thread_num();
            const int nthr = omp_get_num_threads();
            int g{0}, oc{0};
            size_t start = 0, end = 0;
            balance211(work_amount, nthr, ithr, start, end);
            nd_iterator_init(start, g, jcp.ngroups, oc, jcp.oc);
            for (size_t iwork = start; iwork < end; ++iwork) {
                data_t db = 0;
                size_t offset_ = (size_t)g*dst_step + (size_t)oc * K;
                for (int mb = 0; mb < jcp.mb; ++mb)
                {
                    size_t offset = offset_ + (size_t)mb*jcp.ngroups*dst_step;
                    for (int od = 0; od < jcp.od; ++od)
                        for (int oh = 0; oh < jcp.oh; ++oh)
#if defined(__ve)
                            _Pragma("_NEC shortloop_reduction")// not this is compelely orthogonal to omp reduce;
#else
                            PRAGMA_OMP_SIMD(reduction(+:db))//;
#endif
                            for (int ow = 0; ow < jcp.ow; ++ow)
                            {
                                db += diff_dst[offset];
                                offset ++;
                            }
                }
                //diff_bias[diff_bias_d.off(g*jcp.oc+oc)] = db;
                diff_bias[g*jcp.oc+oc] = db;
                nd_iterator_step(g, jcp.ngroups, oc, jcp.oc);
            }
        }
    }
#endif
}
#endif
}
}
}
// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
