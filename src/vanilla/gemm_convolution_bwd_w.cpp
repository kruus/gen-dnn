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

namespace mkldnn {
namespace impl {
namespace cpu {

#if ! USE_MKL && ! USE_CBLAS // provide empty stubs (init always will say "NO")
#pragma warning "gemm_convolution stubs only -- (no MKL or CBLAS)"

void gemm_convolution_bwd_weights_t::execute_backward_weights() {}

#else // some sort of gemm (jit? cblas?) is available

using namespace mkldnn::impl::status;
using namespace mkldnn::impl::memory_format;
using namespace mkldnn::impl::utils;


void gemm_convolution_bwd_weights_t::execute_backward_weights() {
    auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto diff_dst = reinterpret_cast<const data_t *>(this->input_memory(1));
    auto diff_weights = reinterpret_cast<data_t*>(this->memory(0));
#if ! VE_OPENMP_BUG
    auto diff_bias = reinterpret_cast<data_t *>(this->memory(1));
#endif

    jit_gemm_conv_conf_t &jcp = this->conf_.jcp_;
    const int K = jcp.os * jcp.od;
    const size_t src_step = jcp.ic * jcp.ih * jcp.iw * jcp.id;
    const size_t dst_step = jcp.oc * K;
    const size_t weights_g_size = jcp.ic * jcp.oc * jcp.ks;

    const int k = jcp.os;
    const int N = jcp.oc;
    const int M = jcp.ic * jcp.ks;
    const int LDA = jcp.im2col_sz ? k : K;
    const data_t zero = 0.0, one = 1.0;

    data_t *col = nullptr, *wei_reduction = nullptr;
    ptrdiff_t wei_offset = 0;
    if (jcp.im2col_sz) {
        col = (data_t *)this->scratchpad_->get();
        wei_offset = jcp.im2col_sz * jcp.nthr;
    }
    if (jcp.need_wei_reduction)
        wei_reduction = (data_t *)this->scratchpad_->get() + wei_offset;

    do{
    OMP(parallel num_threads(jcp.nthr))
    {
        const int ithr = omp_get_thread_num();
        const int nthr = omp_get_num_threads();

        int ithr_g, nthr_g, ithr_mb, nthr_mb;
        size_t g_start{0}, g_end{0}, mb_start{0}, mb_end{0};

        jit_gemm_convolution_utils::bwd_weights_balance(ithr, nthr,
                jcp.ngroups, jcp.mb, ithr_g, nthr_g, ithr_mb, nthr_mb);

        const int need_reduction = nthr_mb != 1;

        if (ithr_g != -1 && ithr_mb != -1) {
            balance211((size_t)jcp.ngroups, nthr_g, ithr_g, g_start, g_end);
            balance211((size_t)jcp.mb, nthr_mb, ithr_mb, mb_start, mb_end);

            assert(implication((g_end - g_start) > 1, need_reduction == 0));

            data_t *_col = col + (ptrdiff_t)ithr * jcp.im2col_sz;
            data_t *weights_reduce_base = wei_reduction
                    + ithr_g * nthr_mb * weights_g_size;
            data_t *weights_reduce = weights_reduce_base
                    + ithr_mb * weights_g_size;

            //# pragma omp parallel for if(jcp.nthr == 1)
            for (ptrdiff_t i = 0; i < jcp.im2col_sz; ++i) _col[i] = (data_t)0;

            for (size_t g = g_start; g < g_end; ++g) {
                data_t *_diff_weights = need_reduction
                        ? weights_reduce : (diff_weights + g * weights_g_size);
                for (size_t mb = mb_start; mb < mb_end; ++mb) {
                    const data_t *_src = src + (mb*jcp.ngroups+g)*src_step;
                    for (int od = 0; od < jcp.od; ++od) {
                    const data_t *_diff_dst = diff_dst
                            + (mb*jcp.ngroups+g)*dst_step + od * k;

                    if (jcp.im2col_sz) {
                        if (jcp.id == 1)
                            jit_gemm_convolution_utils::im2col(jcp, _src, _col);
                        else
                            jit_gemm_convolution_utils::im2col_3d(jcp, _src,
                                _col, od);
                    }

                    extended_sgemm(
                        "T", "N", &M, &N, &k, &one,
                        jcp.im2col_sz ? _col : _src + od * k,
                        &LDA, _diff_dst, &K,
                        mb == mb_start && od == 0 ? &zero : &one,
                        _diff_weights, &M);
                    }
                }
            }
            if (need_reduction) {
                OMP(barrier)//;
                data_t *weights_base = diff_weights + g_start * weights_g_size;
                jit_gemm_convolution_utils::bwd_weights_reduction_par(
                    ithr_mb, nthr_mb, jcp, weights_reduce_base, weights_base);
            }
        } else
            if (need_reduction) {
                OMP(barrier)//;
            }
    }
    }while(0);
#if VE_OPENMP_BUG
    if (jcp.with_bias) {
        execute_backward_weights_bias();
    }
#else
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
                    //OMPSIMD(reduction(+:db))//;
                    PRAGMA_OMP_SIMD(reduction(+:db))
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
