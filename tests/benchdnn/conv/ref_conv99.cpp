/*******************************************************************************
* Copyright 2017 Intel Corporation
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

/** \file
 * precalc inner kernel loop limits to avoid conditionals */
#include "conv/conv.hpp"
#include "idiv.hpp"

namespace conv {

#if 0
// BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
extern void refconv_4_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m);

extern void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);

extern void refconv_3_bwd_w(const prb_t *p, dnn_mem_t &src_m,
    dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m);
#endif

// ---------------------------------------------------------------

void refconv_99_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
    refconv_3_fwd(p, src_m, wei_m, bia_m, dst_m);
}

void refconv_99_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
    refconv_3_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
}

void refconv_99_bwd_w(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
    refconv_3_bwd_w(p, src_m, diff_wei_m, diff_bia_m, diff_dst_m);
}


}
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0,\:0,N-s foldmethod=indent foldlevel=3
