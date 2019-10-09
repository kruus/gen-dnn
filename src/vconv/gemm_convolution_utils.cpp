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

#include "gemm_convolution_utils.hpp"
#include "mkldnn_types.h"
#include "c_types_map.hpp"
#include "utils.hpp"
#include "type_helpers.hpp"

namespace mkldnn {
namespace impl {
namespace cpu {

namespace jit_gemm_convolution_utils {

using namespace mkldnn::impl::status;
using namespace mkldnn::impl::memory_format;
using namespace mkldnn::impl::utils;
using namespace prop_kind;
using namespace data_type;

void im2col_3d(jit_gemm_conv_conf_t const& jcp, const float *im, float *col, int od) {
    const size_t OHW = jcp.oh * jcp.ow;
    const size_t im_step = jcp.ih * jcp.iw * jcp.id;
    const size_t col_step = jcp.ks * OHW;

    OMP(parallel for)
    for (int ic = 0; ic < jcp.ic; ++ic) {
        const float *im_loc = im + ic * im_step;
        float *col_loc = col + ic * col_step;
        int id = od * jcp.stride_d - jcp.f_pad;
        for (int kd = 0; kd < jcp.kd; ++kd) {
            float *col_ = col_loc + kd * jcp.kh * jcp.kw * OHW;
            if (id < 0 || id >= jcp.id) {
                int ih_ = -jcp.t_pad;
                for (int kh = 0; kh < jcp.kh; ++kh) {
                    int ih = ih_;
                    for (int oh = 0; oh < jcp.oh; ++oh) {
                        if (ih < 0 || ih >= jcp.ih) {
                            ih += jcp.stride_h;
                            continue;
                        }
                        int iw_ = -jcp.l_pad;
                        for (int kw = 0; kw < jcp.kw; ++kw) {
                            int iw = iw_;
                            for (int ow = 0; ow < jcp.ow; ++ow) {
                                if (iw < 0 || iw >= jcp.iw) {
                                    iw += jcp.stride_w;
                                    continue;
                                }

                                const size_t col_idx = kw * OHW + oh * jcp.ow
                                    + ow;

                                col_[col_idx] = 0;
                                iw += jcp.stride_w;
                            }
                            iw_ += (1 + jcp.dilate_w);
                        }
                        ih += jcp.stride_h;
                    }
                    ih_ += (1 + jcp.dilate_h);
                    col_ += jcp.kw * OHW;
                }
            } else {
                const float *im_ = im_loc + id * jcp.ih * jcp.iw;
                int ih_ = -jcp.t_pad;
                for (int kh = 0; kh < jcp.kh; ++kh) {
                    int ih = ih_;
                    for (int oh = 0; oh < jcp.oh; ++oh) {
                        if (ih < 0 || ih >= jcp.ih) {
                            ih += jcp.stride_h;
                            continue;
                        }
                        int iw_ = -jcp.l_pad;
                        for (int kw = 0; kw < jcp.kw; ++kw) {
                            int iw = iw_;
                            for (int ow = 0; ow < jcp.ow; ++ow) {
                                if (iw < 0 || iw >= jcp.iw) {
                                    iw += jcp.stride_w;
                                    continue;
                                }

                                const size_t col_idx = kw * OHW + oh * jcp.ow
                                    + ow;
                                const size_t im_idx = ih * jcp.iw + iw;

                                col_[col_idx] = im_[im_idx];
                                iw += jcp.stride_w;
                            }
                            iw_ += (1 + jcp.dilate_w);
                        }
                        ih += jcp.stride_h;
                    }
                    ih_ += (1 + jcp.dilate_h);
                    col_ += jcp.kw * OHW;
                }
            }
            id += (1 + jcp.dilate_d);
        }
    }
}

void im2col(
    jit_gemm_conv_conf_t const& jcp, const float *im, float *col) {
    const size_t im_step = jcp.ih * jcp.iw;
    const size_t col_step = jcp.ks * jcp.os;

    if (jcp.ic != 1) {
        if(0){ // MAKE THIS SELECTABLE FROM jcp
            //auto im2col_common = [&](const float *im, float *col)
            {
                const size_t work_amount = jcp.ic;
                OMP(parallel)//;
                {
                    const int ithr = omp_get_thread_num();
                    const int nthr = omp_get_num_threads();

                    size_t start = 0, end = 0, ic = 0;
                    balance211(work_amount, nthr, ithr, start, end);
                    nd_iterator_init(start, ic, jcp.ic);

                    const float *im_ = im + ic * im_step;
                    float *col_ = col + ic * col_step;

                    for (size_t iwork = start; iwork < end; ++iwork)
                    {
                        for (int kh = 0; kh < jcp.kh; ++kh) {
                            for (int oh = 0; oh < jcp.oh; ++oh) {
                                const int ih = oh * jcp.stride_h
                                    - jcp.t_pad + kh * (1 + jcp.dilate_h);
                                if (ih < 0 || ih >= jcp.ih) continue;

                                for (int kw = 0; kw < jcp.kw; ++kw) {
                                    for (int ow = 0; ow < jcp.ow; ++ow) {
                                        const int iw = ow * jcp.stride_w
                                            - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                        if (iw < 0 || iw >= jcp.iw) continue;

                                        const size_t col_idx = ((kh * jcp.kw + kw) * jcp.oh+oh)
                                            * jcp.ow + ow;
                                        const size_t im_idx = ih*jcp.iw + iw;
                                        col_[col_idx] = im_[im_idx];
                                    }}
                            }}
                        im_ += im_step;
                        col_ += col_step;

                        nd_iterator_step(ic, jcp.ic);
                    }
                }
            };
            //im2col_common(im, col);
        }else{
#define UNROLL_IM2COL 8
            //auto im2col_common_unroll = [&](const float *im, float *col)
            {
                const size_t work_amount = floor(jcp.ic/UNROLL_IM2COL);
                int ic;
                const float *im_;
                float *col_;

                if(work_amount > 0) {
                    OMP(parallel)//;
                    {
                        const int ithr = omp_get_thread_num();
                        const int nthr = omp_get_num_threads();

                        size_t start = 0, end = 0, ichunk = 0;
                        balance211(work_amount, nthr, ithr, start, end);
                        nd_iterator_init(start, ichunk, work_amount);

                        ic = ichunk * UNROLL_IM2COL;
                        im_ = im + ic * im_step;
                        col_ = col + ic * col_step;

                        for (size_t iwork = start; iwork < end; ++iwork)
                        {
                            /* Where to put #pragma ivdep ? */
                            for (int kh = 0; kh < jcp.kh; ++kh) {
                                for (int oh = 0; oh < jcp.oh; ++oh) {
                                    const int ih = oh * jcp.stride_h
                                        - jcp.t_pad + kh * (1 + jcp.dilate_h);
                                    if (ih < 0 || ih >= jcp.ih) continue;

                                    for (int kw = 0; kw < jcp.kw; ++kw) {
                                        IVDEP()//;
                                        for (int ow = 0; ow < jcp.ow; ++ow) {
                                            const int iw = ow * jcp.stride_w
                                                - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                            if (iw < 0 || iw >= jcp.iw) continue;
                                            UNROLL(UNROLL_IM2COL)//;
                                            for(int i = 0; i < UNROLL_IM2COL; ++i) {
                                                const size_t col_idx =  i*col_step +
                                                    ((kh * jcp.kw + kw) * jcp.oh+oh)
                                                    * jcp.ow + ow;
                                                const size_t im_idx = i*im_step + ih*jcp.iw + iw;
                                                col_[col_idx] = im_[im_idx];
                                            }
                                        }}
                                }}
                            im_ += im_step * UNROLL_IM2COL;
                            col_ += col_step * UNROLL_IM2COL;

                            nd_iterator_step(ichunk, work_amount);
                        }
                    }}

                ic = UNROLL_IM2COL * work_amount;
                if(ic < jcp.ic) {
                    im_ = im + ic * im_step;
                    col_ = col + ic * col_step;

                    switch(jcp.ic - ic) {
                    case 1:
                    for (int kh = 0; kh < jcp.kh; ++kh) {
                        for (int oh = 0; oh < jcp.oh; ++oh) {
                            const int ih = oh * jcp.stride_h
                                - jcp.t_pad + kh * (1 + jcp.dilate_h);
                            if (ih < 0 || ih >= jcp.ih) continue;

                            for (int kw = 0; kw < jcp.kw; ++kw) {
                                IVDEP()//;
                                for (int ow = 0; ow < jcp.ow; ++ow) {
                                    const int iw = ow * jcp.stride_w
                                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                    if (iw < 0 || iw >= jcp.iw) continue;

                                    const size_t col_idx = ((kh * jcp.kw + kw) * jcp.oh+oh)
                                        * jcp.ow + ow;
                                    const size_t im_idx = ih*jcp.iw + iw;
                                    col_[col_idx] = im_[im_idx];
                                }}
                        }}
                    break;

                    case 2:
                    for (int kh = 0; kh < jcp.kh; ++kh) {
                        for (int oh = 0; oh < jcp.oh; ++oh) {
                            const int ih = oh * jcp.stride_h
                                - jcp.t_pad + kh * (1 + jcp.dilate_h);
                            if (ih < 0 || ih >= jcp.ih) continue;

                            for (int kw = 0; kw < jcp.kw; ++kw) {
                                IVDEP()//;
                                for (int ow = 0; ow < jcp.ow; ++ow) {
                                    const int iw = ow * jcp.stride_w
                                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                    if (iw < 0 || iw >= jcp.iw) continue;

                                    UNROLL(2)//;
                                    for(int i = 0; i < 2; ++i) {
                                        const size_t col_idx =  i*col_step +
                                            ((kh * jcp.kw + kw) * jcp.oh+oh)
                                            * jcp.ow + ow;
                                        const size_t im_idx = i*im_step + ih*jcp.iw + iw;
                                        col_[col_idx] = im_[im_idx];
                                    }
                                }}
                        }}
                    break;

                    case 3:
                    for (int kh = 0; kh < jcp.kh; ++kh) {
                        for (int oh = 0; oh < jcp.oh; ++oh) {
                            const int ih = oh * jcp.stride_h
                                - jcp.t_pad + kh * (1 + jcp.dilate_h);
                            if (ih < 0 || ih >= jcp.ih) continue;

                            for (int kw = 0; kw < jcp.kw; ++kw) {
                                IVDEP()//;
                                for (int ow = 0; ow < jcp.ow; ++ow) {
                                    const int iw = ow * jcp.stride_w
                                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                    if (iw < 0 || iw >= jcp.iw) continue;

                                    UNROLL(3)//;
                                    for(int i = 0; i < 3; ++i) {
                                        const size_t col_idx =  i*col_step +
                                            ((kh * jcp.kw + kw) * jcp.oh+oh)
                                            * jcp.ow + ow;
                                        const size_t im_idx = i*im_step + ih*jcp.iw + iw;
                                        col_[col_idx] = im_[im_idx];
                                    }
                                }}
                        }}
                    break;

                    case 4:
                    for (int kh = 0; kh < jcp.kh; ++kh) {
                        for (int oh = 0; oh < jcp.oh; ++oh) {
                            const int ih = oh * jcp.stride_h
                                - jcp.t_pad + kh * (1 + jcp.dilate_h);
                            if (ih < 0 || ih >= jcp.ih) continue;

                            for (int kw = 0; kw < jcp.kw; ++kw) {
                                IVDEP()//;
                                for (int ow = 0; ow < jcp.ow; ++ow) {
                                    const int iw = ow * jcp.stride_w
                                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                    if (iw < 0 || iw >= jcp.iw) continue;

                                    UNROLL(4)//;
                                    for(int i = 0; i < 4; ++i) {
                                        const size_t col_idx =  i*col_step +
                                            ((kh * jcp.kw + kw) * jcp.oh+oh)
                                            * jcp.ow + ow;
                                        const size_t im_idx = i*im_step + ih*jcp.iw + iw;
                                        col_[col_idx] = im_[im_idx];
                                    }
                                }}
                        }}
                    break;

                    case 5:
                    for (int kh = 0; kh < jcp.kh; ++kh) {
                        for (int oh = 0; oh < jcp.oh; ++oh) {
                            const int ih = oh * jcp.stride_h
                                - jcp.t_pad + kh * (1 + jcp.dilate_h);
                            if (ih < 0 || ih >= jcp.ih) continue;

                            for (int kw = 0; kw < jcp.kw; ++kw) {
                                IVDEP()//;
                                for (int ow = 0; ow < jcp.ow; ++ow) {
                                    const int iw = ow * jcp.stride_w
                                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                    if (iw < 0 || iw >= jcp.iw) continue;

                                    UNROLL(5)//;
                                    for(int i = 0; i < 5; ++i) {
                                        const size_t col_idx =  i*col_step +
                                            ((kh * jcp.kw + kw) * jcp.oh+oh)
                                            * jcp.ow + ow;
                                        const size_t im_idx = i*im_step + ih*jcp.iw + iw;
                                        col_[col_idx] = im_[im_idx];
                                    }
                                }}
                        }}
                    break;

                    case 6:
                    for (int kh = 0; kh < jcp.kh; ++kh) {
                        for (int oh = 0; oh < jcp.oh; ++oh) {
                            const int ih = oh * jcp.stride_h
                                - jcp.t_pad + kh * (1 + jcp.dilate_h);
                            if (ih < 0 || ih >= jcp.ih) continue;

                            for (int kw = 0; kw < jcp.kw; ++kw) {
                                IVDEP()//;
                                for (int ow = 0; ow < jcp.ow; ++ow) {
                                    const int iw = ow * jcp.stride_w
                                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                    if (iw < 0 || iw >= jcp.iw) continue;

                                    UNROLL(6)//;
                                    for(int i = 0; i < 6; ++i) {
                                        const size_t col_idx =  i*col_step +
                                            ((kh * jcp.kw + kw) * jcp.oh+oh)
                                            * jcp.ow + ow;
                                        const size_t im_idx = i*im_step + ih*jcp.iw + iw;
                                        col_[col_idx] = im_[im_idx];
                                    }
                                }}
                        }}
                    break;

                    case 7:
                    for (int kh = 0; kh < jcp.kh; ++kh) {
                        for (int oh = 0; oh < jcp.oh; ++oh) {
                            const int ih = oh * jcp.stride_h
                                - jcp.t_pad + kh * (1 + jcp.dilate_h);
                            if (ih < 0 || ih >= jcp.ih) continue;

                            for (int kw = 0; kw < jcp.kw; ++kw) {
                                IVDEP()//;
                                for (int ow = 0; ow < jcp.ow; ++ow) {
                                    const int iw = ow * jcp.stride_w
                                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                                    if (iw < 0 || iw >= jcp.iw) continue;

                                    UNROLL(7)//;
                                    for(int i = 0; i < 7; ++i) {
                                        const size_t col_idx =  i*col_step +
                                            ((kh * jcp.kw + kw) * jcp.oh+oh)
                                            * jcp.ow + ow;
                                        const size_t im_idx = i*im_step + ih*jcp.iw + iw;
                                        col_[col_idx] = im_[im_idx];
                                    }
                                }}
                        }}
                    break;

                    default:
                    printf("Bug - UNROLL IM2COL reset without changing remainder cases\n");
                    exit(1);
                    break;
                    }
                }
            };
            //im2col_common_unrolled(im, col);
        }
    } else if (jcp.ic == 1) {
        //auto im2col_1st = [&](const float *im, float *col)
        {
            const size_t work_amount = jcp.oh * jcp.kh;
            OMP(parallel)//;
            {
                const int ithr = omp_get_thread_num();
                const int nthr = omp_get_num_threads();

                size_t start = 0, end = 0;
                int oh = 0, kh = 0;
                balance211(work_amount, nthr, ithr, start, end);
                nd_iterator_init(start, kh, jcp.kh, oh, jcp.oh);

                for (size_t iwork = start; iwork < end; ++iwork)
                {
                    const int ih = oh * jcp.stride_h - jcp.t_pad + kh * (1 + jcp.dilate_h);
                    if (ih < 0 || ih >= jcp.ih) {
                        nd_iterator_step(kh, jcp.kh, oh, jcp.oh);
                        continue;
                    }

                    for (int kw = 0; kw < jcp.kw; ++kw) {
                        for (int ow = 0; ow < jcp.ow; ++ow) {
                            const int iw = ow * jcp.stride_w - jcp.l_pad + kw * (1 + jcp.dilate_w);
                            if (iw < 0 || iw >= jcp.iw) continue;

                            const size_t col_idx = ((kh*jcp.kw + kw)*jcp.oh+oh)*jcp.ow+ow;
                            const size_t im_idx = ih*jcp.iw + iw;
                            col[col_idx] = im[im_idx];
                        }}
                    nd_iterator_step(kh, jcp.kh, oh, jcp.oh);
                }
            }
        };
        //im2col_1st(im, col);
    }

}

/* col[oh][ow][kh][kw][ic] <-- im2col_u8(im[ih][iw][ic]) */
void im2col_u8(
    jit_gemm_conv_conf_t const& jcp, const uint8_t *im, uint8_t *col) {
    int num_thr = (jcp.mb != 1) ? omp_get_max_threads() : 1;
    MAYBE_UNUSED(num_thr);
    OMP(parallel num_threads(num_thr))//;
    {
        parallel_nd_in_omp(jcp.oh, jcp.ow,
            [&](int oh, int ow) {
#if defined(__ve)
            if(jcp.ic<256){
                PRAGMA_UNROLL//;
                for (int kh = 0; kh < jcp.kh; ++kh) {
                    const int ih = oh * jcp.stride_h
                        - jcp.t_pad + kh * (1 + jcp.dilate_h);
                    if (ih < 0 || ih >= jcp.ih) continue;

                    for (int kw = 0; kw < jcp.kw; ++kw) {
                        const int iw = ow * jcp.stride_w
                            - jcp.l_pad + kw * (1 + jcp.dilate_w);
                        if (iw < 0 || iw >= jcp.iw) continue;

                        const size_t col_idx = (((oh * jcp.ow + ow) * jcp.kh + kh)
                                * jcp.kw + kw) * jcp.ic;
                        const size_t im_idx
                            = (ih * jcp.iw + iw) * jcp.ngroups * jcp.ic;
                        ShortLoop()//;
                        for (int ic = 0; ic < jcp.ic; ++ic) {
                            col[col_idx + ic] = im[im_idx + ic];
                        }
                    }
                }
            }else{
                PRAGMA_UNROLL//;
                for (int kh = 0; kh < jcp.kh; ++kh) {
                    const int ih = oh * jcp.stride_h
                        - jcp.t_pad + kh * (1 + jcp.dilate_h);
                    if (ih < 0 || ih >= jcp.ih) continue;

                    for (int kw = 0; kw < jcp.kw; ++kw) {
                        const int iw = ow * jcp.stride_w
                            - jcp.l_pad + kw * (1 + jcp.dilate_w);
                        if (iw < 0 || iw >= jcp.iw) continue;

                        const size_t col_idx = (((oh * jcp.ow + ow) * jcp.kh + kh)
                                * jcp.kw + kw) * jcp.ic;
                        const size_t im_idx
                            = (ih * jcp.iw + iw) * jcp.ngroups * jcp.ic;
                        ShortLoopTest()//;
                        for (int ic = 0; ic < jcp.ic; ++ic) {
                            col[col_idx + ic] = im[im_idx + ic];
                        }
                    }
                }
            }
#else
            for (int kh = 0; kh < jcp.kh; ++kh) {
                const int ih = oh * jcp.stride_h
                    - jcp.t_pad + kh * (1 + jcp.dilate_h);
                if (ih < 0 || ih >= jcp.ih) continue;

                for (int kw = 0; kw < jcp.kw; ++kw) {
                    const int iw = ow * jcp.stride_w
                        - jcp.l_pad + kw * (1 + jcp.dilate_w);
                    if (iw < 0 || iw >= jcp.iw) continue;

                    const size_t col_idx = (((oh * jcp.ow + ow) * jcp.kh + kh)
                            * jcp.kw + kw) * jcp.ic;
                    const size_t im_idx
                        = (ih * jcp.iw + iw) * jcp.ngroups * jcp.ic;
#if defined(__ve)
                    _Pragma("_NEC shortloop_reduction")//;
#elif __GNUC__ < 8
                    OMP(parallel)
#else
                    PRAGMA_OMP_SIMD()//; // maybe OK for icc? not good for g++-7
#endif
                    for (int ic = 0; ic < jcp.ic; ++ic) {
                        col[col_idx + ic] = im[im_idx + ic];
                    }
                }
            }
#endif
        });
    }
}

/* im[ih][iw][ic] <-- col2im_s32(col[oh][ow][kh][kw][ic]) */
void col2im_s32(
    jit_gemm_conv_conf_t const& jcp, const int32_t *col, int32_t *im) {
    int num_thr = (jcp.mb != 1) ? omp_get_max_threads() : 1;

    OMP(parallel for num_threads(num_thr))//;
    for (int ithr = 0; ithr < num_thr; ithr++)
    {
        int h_nthr = nstl::min(jcp.ih, num_thr);
        int w_nthr = nstl::min(jcp.iw, num_thr/h_nthr);
        int h_ithr = 1, h_s = 0, h_e = 0, w_ithr = 1, w_s = 0, w_e = 0;
        if (ithr < h_nthr * w_nthr) {
            h_ithr = ithr / w_nthr;
            w_ithr = ithr % w_nthr;
            balance211(jcp.ih, h_nthr, h_ithr, h_s, h_e);
            balance211(jcp.iw, w_nthr, w_ithr, w_s, w_e);
        } else {
            h_ithr = w_ithr = -ithr;
            h_s = h_e = w_s = w_e = -1;
        }
        for (int ih = h_s; ih < h_e; ++ih) {
            for (int iw = w_s; iw < w_e; ++iw) {
#if defined(__ve)
                _Pragma("_NEC shortloop_reduction")//;
#else
                PRAGMA_OMP_SIMD()//;
#endif
                for (int ic = 0; ic < jcp.ic; ++ic) {
                    im[(ih * jcp.iw + iw) * jcp.ic + ic] = 0;
                }
            }
        }
        for (int oh = 0; oh < jcp.oh; ++oh) {
            for (int ow = 0; ow < jcp.ow; ++ow) {
                for (int kh = 0; kh < jcp.kh; ++kh) {
                    const int ih = oh * jcp.stride_h
                        - jcp.t_pad + kh * (1 + jcp.dilate_h);
                    if (ih < h_s || ih >= h_e) continue;

                    for (int kw = 0; kw < jcp.kw; ++kw) {
                        const int iw = ow * jcp.stride_w
                            - jcp.l_pad + kw * (1 + jcp.dilate_w);
                        if (iw < w_s || iw >= w_e) continue;

                        const size_t col_idx = (((oh * jcp.ow + ow) * jcp.kh
                                + kh) * jcp.kw + kw) * jcp.ic;
                        const size_t im_idx
                            = (ih * jcp.iw + iw) * jcp.ic;
#if defined(__ve)
                        _Pragma("_NEC shortloop_reduction")//;
#else
                        PRAGMA_OMP_SIMD()//;
#endif
                        for (int ic = 0; ic < jcp.ic; ++ic) {
                            im[im_idx + ic] += col[col_idx + ic];
                        }
                    }
                }
            }
        }
    }
}

void col2im_3d(
    jit_gemm_conv_conf_t const& jcp, const float *col, float *im, int od) {
    const size_t col_step = jcp.ks * jcp.os;
    const size_t im_step = jcp.ih * jcp.iw * jcp.id;

    int num_thr = (jcp.mb != 1) ? omp_get_max_threads() : 1;
    MAYBE_UNUSED(num_thr);
    OMP(parallel for  num_threads(num_thr))//;
    for (int ic = 0; ic < jcp.ic; ++ic) {
        const float *col_ = col;
        int id = od * jcp.stride_d - jcp.f_pad;
        for (int kd = 0; kd < jcp.kd; ++kd) {
        if (id < 0 || id >= jcp.id) {
            col_ += jcp.kh * jcp.kw * jcp.os;
            id += (1 + jcp.dilate_d);
            continue;
        }
        float *im_ = im + id * jcp.ih * jcp.iw;

        for (int oh = 0; oh < jcp.oh; ++oh) {
        for (int kh = 0; kh < jcp.kh; ++kh) {
            const int ih = oh * jcp.stride_h - jcp.t_pad
                + kh * (1 + jcp.dilate_h);
            if (ih < 0 || ih >= jcp.ih) continue;

            for (int ow = 0; ow < jcp.ow; ++ow) {
            for (int kw = 0; kw < jcp.kw; ++kw) {
                const int iw = ow * jcp.stride_w - jcp.l_pad
                    + kw * (1 + jcp.dilate_w);
                if (iw < 0 || iw >= jcp.iw) continue;

                const size_t col_idx = ((kh*jcp.kw + kw)*jcp.oh+oh)*jcp.ow+ow;
                const size_t im_idx = ih*jcp.iw + iw;
                im_[im_idx] += col_[col_idx];
            }
            }
        }
        }
        col_ += jcp.kh * jcp.kw * jcp.os;
        id += (1 + jcp.dilate_d);
        }
        col += col_step;
        im += im_step;
    }
}

void col2im(
    jit_gemm_conv_conf_t const& jcp, const float *col, float *im) {

    const size_t col_step = jcp.ks * jcp.os;
    const size_t im_step = jcp.ih * jcp.iw;
#if defined(__ve)
#define MYINT int64_t
#else
#define MYINT int
#endif
    const MYINT iS = jcp.ih * jcp.iw;
    const MYINT jcp_ic = jcp.ic;
    const MYINT jcp_kh = jcp.kh;
    const MYINT jcp_oh = jcp.oh;
    const MYINT jcp_ih = jcp.ih;
    const MYINT jcp_kw = jcp.kw;
    const MYINT jcp_ow = jcp.ow;
    const MYINT jcp_iw = jcp.iw;
    const MYINT jcp_dilate_h = jcp.dilate_h;
    const MYINT jcp_dilate_w = jcp.dilate_w;
    const MYINT jcp_stride_h = jcp.stride_h;
    const MYINT jcp_stride_w = jcp.stride_w;
    const MYINT jcp_t_pad = jcp.t_pad;
    const MYINT jcp_l_pad = jcp.l_pad;

    OMP(parallel for)//; no num_thr spec?  (jcp.mb != 1) ? omp_get_max_threads() : 1;
    for (MYINT ic = 0; ic < jcp_ic; ++ic) {
        float *im_ = im + ic * im_step;
        const float *col_ = col + ic * col_step;
#if defined(__ve)
        _Pragma("_NEC shortloop_reduction")//;
#else
        PRAGMA_OMP_SIMD()//;
#endif
        for (MYINT is = 0; is < iS; ++is) im_[is] = 0.;

        for (MYINT kh = 0; kh < jcp_kh; ++kh) {
        for (MYINT oh = 0; oh < jcp_oh; ++oh) {
            const MYINT ih = oh * jcp_stride_h - jcp_t_pad + kh * (1 + jcp_dilate_h);
            if (ih < 0 || ih >= jcp_ih) continue;
            IVDEP()//;
            for (MYINT kw = 0; kw < jcp_kw; ++kw) {
            //const MYINT kw_corr = kw * (1 + jcp_dilate_w) - jcp_l_pad;
            IVDEP()//;
            for (MYINT ow = 0; ow < jcp_ow; ++ow) {
                //const MYINT iw = ow * jcp_stride_w - jcp_l_pad + kw * (1 + jcp_dilate_w);
#define IW (ow * jcp_stride_w - jcp_l_pad + kw * (1 + jcp_dilate_w))
#if defined(__ve)
                //
                // nc++ has trouble vectorizing this loop
                //
                const MYINT iw = IW;
                if (iw < 0 || iw >= jcp_iw) continue;
                const size_t col_idx = ((kh*jcp_kw + kw)*jcp_oh+oh)*jcp_ow+ow;
                const size_t im_idx = ih*jcp_iw + iw;
                im_[im_idx] += (iw < 0 || iw >= jcp_iw? 0.0: col_[col_idx]);
#else
                const MYINT iw = IW;
                if (iw < 0 || iw >= jcp_iw) continue;
                const size_t col_idx = ((kh*jcp_kw + kw)*jcp_oh+oh)*jcp_ow+ow;
                const size_t im_idx = ih*jcp_iw + iw;
                im_[im_idx] += col_[col_idx];
#endif
#undef IW
            }
            }
        }
        }
    }
#undef MYINT
}

void init_conf(
        jit_gemm_conv_conf_t &jcp, const convolution_desc_t &cd,
        const memory_desc_wrapper &src_d, const memory_desc_wrapper &weights_d,
        const memory_desc_wrapper &dst_d, int max_threads,
        bool with_relu, float relu_negative_slope)
{

    const bool with_groups = weights_d.ndims() == src_d.ndims() + 1;
    jcp.prop_kind = cd.prop_kind;
    const int ndims = src_d.ndims();

    jcp.ngroups = with_groups ? weights_d.dims()[0] : 1;
    jcp.mb = src_d.dims()[0];

    jcp.oc = dst_d.dims()[1] / jcp.ngroups;
    jcp.ic = src_d.dims()[1] / jcp.ngroups;

    jcp.id = (ndims == 4) ? 1 : src_d.dims()[2];
    jcp.ih = src_d.dims()[ndims - 2];
    jcp.iw = src_d.dims()[ndims - 1];
    jcp.od = (ndims == 4) ? 1 : dst_d.dims()[2];
    jcp.oh = dst_d.dims()[ndims - 2];
    jcp.ow = dst_d.dims()[ndims - 1];

    jcp.kd = (ndims == 4) ? 1 : weights_d.dims()[with_groups + 2];
    jcp.kh = weights_d.dims()[with_groups + ndims - 2];
    jcp.kw = weights_d.dims()[with_groups + ndims - 1];

    jcp.f_pad = (ndims == 4) ? 0 : cd.padding[0][0];
    jcp.t_pad = cd.padding[0][ndims - 4];
    jcp.l_pad = cd.padding[0][ndims - 3];

    jcp.stride_d = (ndims == 4) ? 1 : cd.strides[0];
    jcp.stride_h = cd.strides[ndims - 4];
    jcp.stride_w = cd.strides[ndims - 3];

    jcp.dilate_d = (ndims == 4) ? 0 : cd.dilates[0];
    jcp.dilate_h = cd.dilates[ndims - 4];
    jcp.dilate_w = cd.dilates[ndims - 3];

    jcp.src_fmt = src_d.format();
    jcp.with_bias
        = cd.bias_desc.format != memory_format::undef
        || cd.diff_bias_desc.format != memory_format::undef;
    jcp.with_relu = with_relu;
    jcp.relu_negative_slope = relu_negative_slope;

    jcp.is = jcp.ih * jcp.iw;
    jcp.os = jcp.oh * jcp.ow;
    jcp.ks = jcp.kh * jcp.kw * jcp.kd;
    jcp.im2col_sz = !(jcp.oh == jcp.ih && jcp.ow == jcp.iw
                            && jcp.od == jcp.id && jcp.ks == 1)
        ? (ptrdiff_t)jcp.ic * jcp.ks * jcp.os
        : 0;

    bool do_outer_threading = false;
    bool is_int8_conv = (cd.src_desc.data_type == u8
            && cd.weights_desc.data_type == s8);
    if (is_int8_conv) {
        bool is_depthwise =
                utils::everyone_is(1, jcp.ic, jcp.oc) && jcp.ngroups != 1;
        do_outer_threading
                = (is_depthwise || (jcp.os / max_threads < 64 && jcp.mb != 1));
    } else {
        if (utils::one_of(jcp.prop_kind, forward_training, forward_inference))
            do_outer_threading = jcp.os / max_threads < 512
                && utils::implication(jcp.od == 1, (jcp.mb != 1 || jcp.ngroups > 2));
        else if (jcp.prop_kind == backward_data)
            do_outer_threading = (jcp.mb != 1 || jcp.ngroups > 2);
        else //(jcp.prop_kind == backward_weights)
            do_outer_threading = jcp.os / max_threads < 256
                       && (jcp.mb != 1 || jcp.ngroups > 2);
    }
    jcp.nthr = do_outer_threading ? max_threads : 1;
    jcp.need_wei_reduction = (jcp.mb != 1 && jcp.nthr != 1);

#if 0
    const size_t im2col_sz_per_thr = jcp.os * jcp.ks * jcp.ic;
    const size_t im2col_sz = nthr * im2col_sz_per_thr;

    *col = (src_t *)malloc(im2col_sz * sizeof(src_t), 64);
    if (*col == nullptr) return status::out_of_memory;

    OMP(parallel for)//;
    for (size_t i = 0; i < im2col_sz; ++i) (*col)[i] = (src_t)0;

    return status::success;
#endif
}

status_t prepare_scratchpad(jit_gemm_conv_conf_t const& jcp,
                scratchpad_t **scratchpad_, size_t size, const int nthr) {
    if (size > 0) {
        *scratchpad_ = create_scratchpad(nthr * size);
        if (*scratchpad_ == nullptr) return status::out_of_memory;
    } else {
        *scratchpad_ = nullptr;
    }
    return status::success;
}

void bwd_weights_balance(int ithr, int nthr, int ngroups, int mb, int &ithr_g,
        int &nthr_g, int &ithr_mb, int &nthr_mb) {
    nthr_g = nstl::min(ngroups, nthr);
    nthr_mb = nstl::min(mb, nthr / nthr_g);
    if (ithr / nthr_mb >= ngroups) {
        ithr_g = ithr_mb = -1;
    } else {
        ithr_g = ithr / nthr_mb;
        ithr_mb = ithr % nthr_mb;
    }
}

void bwd_weights_reduction_par(int ithr, int nthr,
        jit_gemm_conv_conf_t const& jcp,
        const float *weights_reduce_ws, float *weights) {
    const size_t weights_g_size = jcp.ic * jcp.oc * jcp.ks;

    size_t weights_start{0}, weights_end{0};
    balance211(weights_g_size, nthr, ithr, weights_start, weights_end);

    // Note: no omp directive here (called from one of jcp.nthr)
    for (int i = 0; i < nthr; ++i) {
        const float *ws_i = weights_reduce_ws + i * weights_g_size;
        for (size_t s = weights_start; s < weights_end; ++s)
            weights[s] = (i == 0 ? 0 : weights[s]) + ws_i[s];
    }
}

};

}
}
}
// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
