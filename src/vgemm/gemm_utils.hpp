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

#ifndef GEMM_UTILS_HPP
#define GEMM_UTILS_HPP

namespace mkldnn {
namespace impl {
namespace cpu {

namespace gemm_utils {
/**Sum the \c m*n values from \c p_src into \c p_dst, assuming the two-dimensional
 * arrays have leading dimensions ld_src and ld_dst, respectively. */
inline void sum_two_matrices(
        int m, int n, float *p_src, int ld_src, float *p_dst, int ld_dst)
{
    int i, j;
    for (j = 0; j < n; j++) {
        for (i = 0; i < m; i++) {
            p_dst[i + j * ld_dst] += p_src[i + j * ld_src];
        }
    }
}

#if defined(__ve)
void calc_nthr_nocopy_ve(int m, int n, int k,
        int nthrs, int *nthrs_m, int *nthrs_n, int *nthrs_k, int *BM, int *BN,
        int *BK);
#else
void calc_nthr_nocopy_avx512_common(int m,
        int n, int k, int nthrs, int *nthrs_m, int *nthrs_n, int *nthrs_k,
        int *BM, int *BN, int *BK);

void calc_nthr_nocopy_avx(int m, int n, int k,
        int nthrs, int *nthrs_m, int *nthrs_n, int *nthrs_k, int *BM, int *BN,
        int *BK);
#endif

#ifdef LIBRARY_COMPILE
void partition_unit_diff(
        int ithr, int nthr, int n, int *t_offset, int *t_block);
#else
/** Partition \c n values as equally as possible among \c nthr threads
 * and set the offset \c t_offset and number of values \c t_block for
 * \c ithr.
 * \pre 0 <= ithr < nthr. */
inline void partition_unit_diff(
        int ithr, int nthr, int n, int *t_offset, int *t_block)
{
    int band = n / nthr;
    if (band == 0)
        band = 1;
    int tail = n - band * nthr;
    if (tail < 0)
        tail = 0;

    if (ithr < tail) {
        band++;
        *t_offset = band * ithr;
        *t_block = band;
    } else {
        *t_offset = band * ithr + tail;
        *t_block = band;
    }

    if (*t_offset >= n) {
        *t_offset = 0;
        *t_block = 0;
    }

    if (*t_offset + *t_block > n) {
        *t_block = n - *t_offset;
    }
}
#endif
}//gemm_utils::
}}}//mkldnn::impl::cpu::
/* vim: set et ts=4 sw=4 cino=^=l0,\:0,N-s: */
#endif
