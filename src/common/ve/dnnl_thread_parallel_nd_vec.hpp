/*******************************************************************************
* Copyright 2018-2020 Intel Corporation
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

#ifndef COMMON_DNNL_THREAD_PARALLEL_ND_HPP
#define COMMON_DNNL_THREAD_PARALLEL_ND_HPP

/* This header must be included by dnnl_thread_parallel_nd.hpp only */

/* Functions:
 *  This EXTENDS parallelization to vectorized functions of a few "dimensions"
 *  Original:   f_orig(T0 d0,T1 d1,T2 d2)   (func with 3 coords)
 *              When called multiple times, arrange items in
 *              **arrays** of common length VL, and call
 *
 *  Vector f:   f(T0 *v0, T1 *v1, T2* v2, int const VL);
 *
 *  - parallel_nd_vec(dims..., f)         - creates a parallel section and then
 *                                          calls for_nd_vec
 *  - for_nd_vec(ithr, nthr, dims*..., f) - multidimensional for loop for
 *                                          already created threads
 */


namespace dnnl {
namespace impl {

namespace utils {

template <typename T>
inline T void nd_iterator_init(T start) {
    return start;
}
template <typename T, typename U, typename W, typename... Args>
inline T nd_iterator_init(T start, U *x, const W &X, Args &&... tuple) {
    start = nd_iterator_init(start, utils::forward<Args>(tuple)...);
    x[0] = start % X;
    return start / X;
}

template<typename OFF>
inline bool nd_iterator_step_vec(OFF const &prv, OFF const &nxt) {
    return true;
}
template <typename U, typename W, typename... Args>
inline bool nd_iterator_step_vec(OFF const &prv, OFF const &nxt, U *x, const W &X, Args &&... tuple) {
    if (nd_iterator_step_vec(prv, nxt, utils::forward<Args>(tuple)...)) {
        if ((x[nxt] = x[prv] + 1) >= X ){
            x[nxt] = 0;
            return true;
        }
    }
    return false;
}

}//utils::


/* for_nd_vec section */

// XXX should use a vec[NDIMS][MVL] "coordinates" array instead,
// like memory_desc_wrapper_opt::VecPos, that can be sent directly to
// vector routines like void vec_off_v(VecPos & vp, dim_t * p_offsets, int const noff)
// (uses more stack mem)
//
// OR
//
// Should provide a vec_off_v that takes a variable number of args
// (uses stack mem as needed, but messy impl)
// Note: can use off(...) approach to convert to VecPos "on the fly"
//       (extra copy, but cleaner impl)
//
template <typename T0, typename F, int const MAX_VL=256>
void for_nd_vec(const int ithr, const int nthr, const T0 &D0, F f, int const vl=MAX_VL) {
    T0 start {0}, end {0};
    // XXX should there be a balance211_vec that also suggests a nice vl ?
    balance211(D0, nthr, ithr, start, end);
    //for (T0 d0 = start; d0 < end; ++d0)
    //    f(d0);
    T0 v0[MAX_VL];
    utils::nd_iterator_init_vec(start, v0, D0);
    for (T0 b0 = start; b0 < end; b0+=vl) { // b0 ~ blkwise
        b0len = (end - b0 < vl? end - b0: vl);
        for(int d0=0; d0<b0len; ++d0) { // fill vec of args
            v0[d0] = b0+d0;
        }
        f(v0, vl); // call f with vector of args
    }
}

template <typename T0, typename T1, typename F, int const MAX_VL=256>
void for_nd_vec(const int ithr, const int nthr, const T0 &D0, const T1 &D1, F f, int const vl=MAX_VL) {
    const size_t work_amount = (size_t)D0 * D1;
    if (work_amount == 0) return;
    size_t start {0}, end {0};
    balance211(work_amount, nthr, ithr, start, end);

    //T0 d0 {0};
    //T1 d1 {0};
    //utils::nd_iterator_init(start, d0, D0, d1, D1);
    T0 v0[MAX_VL];
    T1 v1[MAX_VL];
    utils::nd_iterator_init_vec(start, v0, D0, v1, D1); // init v0[0], v1[0]
    //for (size_t iwork = start; iwork < end; ++iwork) {
    //  f(d0, d1);
    //  utils::nd_iterator_step(d0, D0, d1, D1);
    //}
    size_t i0 = 1;
    for (size_t iwork = start; iwork < end; iwork += vl) {
        size_t ilen = (end - iwork < vl? end - iwork: vl);
        // continuation? init {v0,v1}[0] from {v0,v1}[vl-1]
        // init {v0,v1}[i] from {v0,v1}[i-1]
        for(size_t i=i0; i<ilen; ++i){
            size_t prv = (i0 == 0? vl: i) - 1;
            utils::nd_iterator_step_vec(prv, i, v0, D0, v1, D1);
        }
        f(v0, v1, ilen);
    }
}

template <typename T0, typename T1, typename T2, typename F>
void for_nd(const int ithr, const int nthr, const T0 &D0, const T1 &D1,
        const T2 &D2, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2;
    if (work_amount == 0) return;
    size_t start {0}, end {0};
    balance211(work_amount, nthr, ithr, start, end);

    T0 d0 {0};
    T1 d1 {0};
    T2 d2 {0};
    utils::nd_iterator_init(start, d0, D0, d1, D1, d2, D2);
    for (size_t iwork = start; iwork < end; ++iwork) {
        f(d0, d1, d2);
        utils::nd_iterator_step(d0, D0, d1, D1, d2, D2);
    }
}

template <typename T0, typename T1, typename T2, typename T3, typename F>
void for_nd(const int ithr, const int nthr, const T0 &D0, const T1 &D1,
        const T2 &D2, const T3 &D3, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2 * D3;
    if (work_amount == 0) return;
    size_t start {0}, end {0};
    balance211(work_amount, nthr, ithr, start, end);

    T0 d0 {0};
    T1 d1 {0};
    T2 d2 {0};
    T3 d3 {0};
    utils::nd_iterator_init(start, d0, D0, d1, D1, d2, D2, d3, D3);
    for (size_t iwork = start; iwork < end; ++iwork) {
        f(d0, d1, d2, d3);
        utils::nd_iterator_step(d0, D0, d1, D1, d2, D2, d3, D3);
    }
}

template <typename T0, typename T1, typename T2, typename T3, typename T4,
        typename F>
void for_nd(const int ithr, const int nthr, const T0 &D0, const T1 &D1,
        const T2 &D2, const T3 &D3, const T4 &D4, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2 * D3 * D4;
    if (work_amount == 0) return;
    size_t start {0}, end {0};
    balance211(work_amount, nthr, ithr, start, end);

    T0 d0 {0};
    T1 d1 {0};
    T2 d2 {0};
    T3 d3 {0};
    T4 d4 {0};
    utils::nd_iterator_init(start, d0, D0, d1, D1, d2, D2, d3, D3, d4, D4);
    for (size_t iwork = start; iwork < end; ++iwork) {
        f(d0, d1, d2, d3, d4);
        utils::nd_iterator_step(d0, D0, d1, D1, d2, D2, d3, D3, d4, D4);
    }
}

template <typename T0, typename T1, typename T2, typename T3, typename T4,
        typename T5, typename F>
void for_nd(const int ithr, const int nthr, const T0 &D0, const T1 &D1,
        const T2 &D2, const T3 &D3, const T4 &D4, const T5 &D5, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2 * D3 * D4 * D5;
    if (work_amount == 0) return;
    size_t start {0}, end {0};
    balance211(work_amount, nthr, ithr, start, end);

    T0 d0 {0};
    T1 d1 {0};
    T2 d2 {0};
    T3 d3 {0};
    T4 d4 {0};
    T5 d5 {0};
    utils::nd_iterator_init(
            start, d0, D0, d1, D1, d2, D2, d3, D3, d4, D4, d5, D5);
    for (size_t iwork = start; iwork < end; ++iwork) {
        f(d0, d1, d2, d3, d4, d5);
        utils::nd_iterator_step(d0, D0, d1, D1, d2, D2, d3, D3, d4, D4, d5, D5);
    }
}

/* parallel_nd section */

template <typename T0, typename F, int const MAX_VL=256>
void parallel_nd_vec(const T0 &D0, F f, int const vl=MAX_VL) {
    const size_t work_amount = (size_t)D0;
    int nthr = adjust_num_threads(dnnl_get_max_threads(), work_amount);
    if (nthr)
        parallel(nthr, [&](int ithr, int nthr) { for_nd_vec(ithr, nthr, D0, f, int const vl); });
}

template <typename T0, typename T1, typename F>
void parallel_nd(const T0 &D0, const T1 &D1, F f) {
    const size_t work_amount = (size_t)D0 * D1;
    int nthr = adjust_num_threads(dnnl_get_max_threads(), work_amount);
    if (nthr)
        parallel(nthr,
                [&](int ithr, int nthr) { for_nd(ithr, nthr, D0, D1, f); });
}

template <typename T0, typename T1, typename T2, typename F>
void parallel_nd(const T0 &D0, const T1 &D1, const T2 &D2, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2;
    int nthr = adjust_num_threads(dnnl_get_max_threads(), work_amount);
    if (nthr)
        parallel(nthr,
                [&](int ithr, int nthr) { for_nd(ithr, nthr, D0, D1, D2, f); });
}

template <typename T0, typename T1, typename T2, typename T3, typename F>
void parallel_nd(const T0 &D0, const T1 &D1, const T2 &D2, const T3 &D3, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2 * D3;
    int nthr = adjust_num_threads(dnnl_get_max_threads(), work_amount);
    if (nthr)
        parallel(nthr, [&](int ithr, int nthr) {
            for_nd(ithr, nthr, D0, D1, D2, D3, f);
        });
}

template <typename T0, typename T1, typename T2, typename T3, typename T4,
        typename F>
void parallel_nd(const T0 &D0, const T1 &D1, const T2 &D2, const T3 &D3,
        const T4 &D4, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2 * D3 * D4;
    int nthr = adjust_num_threads(dnnl_get_max_threads(), work_amount);
    if (nthr)
        parallel(nthr, [&](int ithr, int nthr) {
            for_nd(ithr, nthr, D0, D1, D2, D3, D4, f);
        });
}

template <typename T0, typename T1, typename T2, typename T3, typename T4,
        typename T5, typename F>
void parallel_nd(const T0 &D0, const T1 &D1, const T2 &D2, const T3 &D3,
        const T4 &D4, const T5 &D5, F f) {
    const size_t work_amount = (size_t)D0 * D1 * D2 * D3 * D4 * D5;
    int nthr = adjust_num_threads(dnnl_get_max_threads(), work_amount);
    if (nthr)
        parallel(nthr, [&](int ithr, int nthr) {
            for_nd(ithr, nthr, D0, D1, D2, D3, D4, D5, f);
        });
}

/* parallel_nd_in_omp section */

template <typename... Args>
void parallel_nd_in_omp(Args &&... args) {
#if DNNL_CPU_THREADING_RUNTIME == DNNL_RUNTIME_SEQ
    for_nd(0, 1, utils::forward<Args>(args)...);
#elif DNNL_CPU_THREADING_RUNTIME == DNNL_RUNTIME_OMP
    for_nd(omp_get_thread_num(), omp_get_num_threads(),
            utils::forward<Args>(args)...);
#elif (DNNL_CPU_THREADING_RUNTIME == DNNL_RUNTIME_TBB \
        || DNNL_CPU_THREADING_RUNTIME == DNNL_RUNTIME_THREADPOOL)
    assert(!"parallel_nd_in_omp() is not supported by this DNNL_CPU_RUNTIME");
#endif
}

} // namespace impl
} // namespace dnnl

#endif
