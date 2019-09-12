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

#include <assert.h>
#include <math.h>

#include "c_types_map.hpp"
#include "mkldnn_thread.hpp"
#include "type_helpers.hpp"

#include "ref_lrn.hpp"

namespace mkldnn {
namespace impl {
namespace cpu {

static inline float fast_negative_powf(float omega, float beta) {
    float Y;
    if (beta == 0.75f) {
        Y = 1.0f / sqrtf(omega);
        Y *= sqrtf(Y);
    } else {
        Y = 1.0f /powf(omega, beta);
    }
    return Y;
};

template <impl::data_type_t data_type>
template <mkldnn_memory_format_t fmt>
void ref_lrn_fwd_t<data_type>::execute_forward() {
    using namespace alg_kind;
    using namespace memory_format;

    auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto dst = reinterpret_cast<data_t*>(this->memory(0));
    auto ws = reinterpret_cast<data_t*>(this->memory(1));

    const memory_desc_wrapper data_d(conf_.src_pd());
    const memory_desc_wrapper ws_d(conf_.workspace_pd());
    MAYBE_UNUSED(ws_d);

    const int C = conf_.C();
    const int H = conf_.H();
    const int W = conf_.W();
    const size_t stride_mb = data_d.blocking_desc().strides[0][0];
    const bool across_channels = conf_.desc()->alg_kind == lrn_across_channels;
    constexpr int blksize = fmt == nChw16c ? 16 : 8;

    /** VE_VEC should be left at zero --
     * LRN length is typically 5, so vectorizing along this loop is a bad choice.
     * Instead, the parallelization should be done over \c (mb,oh,ow) leaving
     * threads with \c +/-half loop and an oc loop in the kernel. */
#define KER_OC 1 /* 1 vectorizes across 0..C (not size) **much** faster */
#define VE_VEC 0 /* if KER_OC==0, original used another lambda */
#if KER_OC==0 || !defined(__ve) // still used in one place (convenience)
    auto data_off = [&](int mb, int c, int h, int w) -> size_t {
        switch (fmt) {
        case nChw16c:
        case nChw8c: return mb * stride_mb + c / blksize * H * W * blksize
                     + h * W * blksize + w * blksize + c % blksize;
        case nchw: return mb * stride_mb + c * H * W + h * W + w;
        case nhwc: return mb * stride_mb + h * W * C + w * C + c;
        default: return data_d.off(mb, c, h, w);
        }
    };
#endif

#define DATA_OFF_NCHW(mb,c,h,w) ((uint64_t)mb * (uint64_t)stride_mb + (uint64_t)c * (uint64_t)H * (uint64_t)W + (uint64_t)h * (uint64_t)W + (uint64_t)w)
#define DATA_OFF_NHWC(mb,c,h,w) (mb * stride_mb + h * W * C + w * C + c)
#define DATA_OFF_nChwNc(mb,c,h,w) (mb * stride_mb + c / blksize * H * W * blksize \
        + h * W * blksize + w * blksize + c % blksize)
    // very slow -- function call prohibits vectorization
#define DATA_OFF_ANY(mb,c,h,w) data_d.off(mb,c,h,w)

#define DATA_OFF(mb,c,h,w) ( \
        fmt==nchw?                      DATA_OFF_NCHW(mb,c,h,w) \
        :fmt==nhwc?                     DATA_OFF_NHWC(mb,c,oh,ow) \
        :fmt==nChw16c || fmt==nChw8c?   DATA_OFF_nChwNc(mb,c,oh,ow) \
        :                               DATA_OFF_ANY(mb,c,oh,ow) \
        )

#if KER_OC==0 // original, and vectorization across 'size' (very bad)
    // XXX pass off (not d), because d and ws can both be calculated from off?
    auto ker = [=](data_t *d, int const mb, int const oc, int const oh, int const ow) {
        const float alpha = static_cast<float>(conf_.desc()->lrn_alpha);
        const float beta = static_cast<float>(conf_.desc()->lrn_beta);
        const float k = static_cast<float>(conf_.desc()->lrn_k);

        const int size = conf_.desc()->local_size;
        const int half_size = (size - 1) / 2;

        float sum = 0;
        if (across_channels) {
            const int c_st = nstl::max(oc - half_size + 0, 0);
            const int c_en = nstl::min(oc + half_size + 1, C);
#if VE_VEC==0 // original (never vectorizable)
            _Pragma("_NEC novector")//;
            for (int c = c_st; c < c_en; ++c) {
                const float s = src[DATA_OFF(mb, c, oh, ow)];
                sum += s * s;
            }
#elif 1 // VE mods
            if(0) for (int c = c_st; c < c_en; ++c) {
                const float s = src[data_off(mb, c, oh, ow)];
                sum += s * s;
            }else if(fmt==nchw && 0){
                uint64_t src_off[c_en-c_st];
                // VE vectorizable
                //asm("### nchw across channels");
                for (int c = c_st; c < c_en; ++c) {
                    src_off[c-c_st] = DATA_OFF_NCHW(mb,c,oh,ow);
                    const float s = src[src_off[c-c_st]];
                    sum += s * s;
                }
            }else if(fmt==nchw && 1){
                //asm("### nchw across channels");
                for (int c = c_st; c < c_en; ++c) {
                    const float s = src[DATA_OFF_NCHW(mb,c,oh,ow)];
                    sum += s * s;
                }
            }
            else if(fmt==nhwc){
                uint64_t src_off[c_en-c_st];
                //asm("### nhwc across channels");
                // "Unvectorized" (it is quite short)
                for (int c = c_st; c < c_en; ++c) {
                    src_off[c-c_st] = DATA_OFF_NHWC(mb,c,oh,ow);
                    const float s = src[src_off[c-c_st]];
                    sum += s * s;
                }
            }
            else if(fmt==nChw16c || fmt==nChw8c){
                uint64_t src_off[c_en-c_st];
                // VE vectorizable
                //asm("### nChwNc across channels");
                for (int c = c_st; c < c_en; ++c) {
                    src_off[c-c_st] = DATA_OFF_nChwNc(mb,c,oh,ow);
                    const float s = src[src_off[c-c_st]];
                    sum += s * s;
                }
            }
            else{
                uint64_t src_off[c_en-c_st];
                //asm("### across channels");
                // not vectorizable
                for (int c = c_st; c < c_en; ++c) {
                    src_off[c-c_st] = DATA_OFF_ANY(mb,c,oh,ow);
                    const float s = src[src_off[c-c_st]];
                    //const float s = src[DATA_OFF_ANY(mb,c,h,w)];
                    sum += s * s;
                }
            }
#else // not quite as good ??? (must compare)
            if( fmt==nchw || fmt==nhwc || fmt==nChw16c || fmt==nChw8c ){
                uint64_t src_off[c_en-c_st];
                asm("###1");
                if(fmt==nchw){
                    for (int c = c_st; c < c_en; ++c) {
                        src_off[c-c_st] = DATA_OFF_NCHW(mb,c,oh,ow);
                    }
                }else if(fmt==nhwc){
                    for (int c = c_st; c < c_en; ++c) {
                        src_off[c-c_st] = DATA_OFF_NHWC(mb,c,oh,ow);
                    }
                }else{ // (fmt==nChw16c || fmt==nChw8c)
                    for (int c = c_st; c < c_en; ++c) {
                        src_off[c-c_st] = DATA_OFF_nChwNc(mb,c,oh,ow);
                    }
                }
                for (int c = c_st; c < c_en; ++c) {
                    const float s = src[src_off[c-c_st]];
                    sum += s * s;
                }
            }else{
                asm("###2");
                for (int c = c_st; c < c_en; ++c) {
                    const float s = src[DATA_OFF_ANY(mb,c,oh,ow)];
                    sum += s * s;
                }
            }
#endif


        } else {
            asm("### sum_oc");
            int h_st = nstl::max(oh - half_size + 0, 0);
            int h_en = nstl::min(oh + half_size + 1, H);
            int w_st = nstl::max(ow - half_size + 0, 0);
            int w_en = nstl::min(ow + half_size + 1, W);
#if !VE_VEC
            for (int h = h_st; h < h_en; ++h) {
                for (int w = w_st; w < w_en; ++w) { // vectorized (ohoh?)
                    const float s = src[DATA_OFF(mb, oc, h, w)];
                    sum += s * s;
                }
            }
#else // VE mods (vectorization)
            if(fmt==nchw){
                uint64_t src_off[(h_en-h_st)*(w_en-w_st)];
                for (uint64_t h = h_st; h < h_en; ++h) {
                    for (uint64_t w = w_st; w < w_en; ++w) {
                        uint64_t const hw_seq = (h-h_st)*(w_en-w_st)+(w-w_st);
                        src_off[hw_seq] = DATA_OFF_NCHW(mb,oc,h,w);
                        const float s = src[src_off[hw_seq]];
                        sum += s * s;
                    }
                }
                //for (int i=0; i<(h_en-h_st)*(w_en-w_st); ++i){
                //    const float s = src[src_off[i]];
                //    sum += s * s;
                //}
            }else if(fmt==nhwc){
                uint64_t src_off[(h_en-h_st)*(w_en-w_st)];
                for (uint64_t h = h_st; h < h_en; ++h) {
                    for (uint64_t w = w_st; w < w_en; ++w) {
                        uint64_t const hw_seq = (h-h_st)*(w_en-w_st)+(w-w_st);
                        src_off[hw_seq] = DATA_OFF_NHWC(mb,oc,h,w);
                        const float s = src[src_off[hw_seq]];
                        sum += s * s;
                    }
                }
            }else if(fmt==nChw16c || fmt==nChw8c){
                uint64_t src_off[(h_en-h_st)*(w_en-w_st)];
                for (uint64_t h = h_st; h < h_en; ++h) {
                    for (uint64_t w = w_st; w < w_en; ++w) {
                        uint64_t const hw_seq = (h-h_st)*(w_en-w_st)+(w-w_st);
                        src_off[hw_seq] = DATA_OFF_nChwNc(mb,oc,h,w);
                        const float s = src[src_off[hw_seq]];
                        sum += s * s;
                    }
                }
            }else{
                // VE non-vectorizable
                for (int h = h_st; h < h_en; ++h) {
                    for (int w = w_st; w < w_en; ++w) {
                        const float s = src[DATA_OFF_ANY(mb, oc, h, w)];
                        sum += s * s;
                    }
                }
            }
#endif
        }
        asm("### finish");
        const int summands = across_channels ? size : size * size;
        sum = k + alpha * sum / summands;
        size_t off = data_off(mb, oc, oh, ow);
        if (ws)
            ws[off] = static_cast<data_t>(sum);
        d[0] = static_cast<data_t>(src[off] * fast_negative_powf(sum, beta));
    };
#endif // KER_OC==0

#if KER_OC==1
    auto ker_oc = [=](int const mb, int const oh, int const ow) {
        const float alpha = static_cast<float>(conf_.desc()->lrn_alpha);
        const float beta = static_cast<float>(conf_.desc()->lrn_beta);
        const float k = static_cast<float>(conf_.desc()->lrn_k);

        const int size = conf_.desc()->local_size;
        const int half_size = (size - 1) / 2;
        const int summands = across_channels ? size : size * size;

        if (across_channels) {
            //printf("##### LRN_ACROSS_C ######\n");
            // blocking loop i_oc would require some overlap of doffs,
            // (i.e. not 256, but blk_oc_max = 256-size)
            //const int64_t blk_oc_max = 256U;
            //const int64_t blk_oc = 256U; // XXX equipartition for VE
            //for(int64_t b_oc=0; b_oc<C; b_oc+=blk_oc){ // oc blocking
            //    int64_t doffs[blk_oc_max];
            //    const int64_t vl=(C-b_oc < 256? C-b_oc: 256);
            //}

            asm("### ker_oc across channels");
            int64_t doffs[C]; // central offsets
            ShortLoop() for(int i_oc=0; i_oc<C; ++i_oc){
                doffs[i_oc] = DATA_OFF(mb,i_oc,oh,ow);
            }
            // vectorize over i_oc (likely larger)
            ShortLoop()//;
            for(int i_oc=0; i_oc<C; ++i_oc){
                float sum = 0;
#if 1
                const int c_st = (i_oc-half_size   > 0? i_oc-half_size: 0);
                const int c_en = (i_oc+half_size+1 < C? i_oc+half_size+1: C);
                _Pragma("_NEC novector") UNROLL(5)//;
                for (int c = c_st; c < c_en; ++c) {
                    const float s = src[doffs[c]];
                    sum += s * s;
                }
#else
#endif
                sum = k + alpha * sum / summands;
                const size_t off = doffs[i_oc];
                //auto d = &dst[off];
                //size_t off = data_off(mb, i_oc, oh, ow);
                if (ws)
                    ws[off] = static_cast<data_t>(sum);
                //d[0] = static_cast<data_t>(src[off] * fast_negative_powf(sum, beta));
                dst[off] = static_cast<data_t>(src[off] * fast_negative_powf(sum, beta));
            }
        } else {
            asm("### ker_oc across H, W");
            //printf("##### LRN_ACROSS_HW ######\n");
            // XXX if data_t is 32-bits or more, doffs[] can be stored into dst[off]
            //     memory (avoid temporary buffer)
            int doffs[2*half_size+1];
            // vectorize over i_oc (likely larger)
            ShortLoopTest()//;
            for(int i_oc=0; i_oc<C; ++i_oc){
                int h_st = nstl::max(oh - half_size + 0, 0);
                int h_en = nstl::min(oh + half_size + 1, H);
                int w_st = nstl::max(ow - half_size + 0, 0);
                int w_en = nstl::min(ow + half_size + 1, W);
                float sum = 0;
                _Pragma("_NEC novector") UNROLL(5)//;
                for (int h = h_st; h < h_en; ++h) {
                    _Pragma("_NEC novector") UNROLL(5)//;
                    for (int w = w_st; w < w_en; ++w) {
                        doffs[(h-h_st) * (w_en-w_st) + (w-w_st)] = DATA_OFF(mb,i_oc,h,w);
                    }
                }
                //ShortLoopTest()//;
                _Pragma("_NEC novector") UNROLL(5)//;
                for (int hw=0; hw<(h_en-h_st) * (w_en-w_st); ++hw){
                        const float s = src[doffs[hw]];
                        sum += s * s;
                }
                sum = k + alpha * sum / summands;
                const size_t off = doffs[i_oc];
                if (ws)
                    ws[off] = static_cast<data_t>(sum);
                dst[off] = static_cast<data_t>(src[off] * fast_negative_powf(sum, beta));
            }
        }
    };
#endif // KER_OC==1

    const int MB = conf_.MB();
#if 0 // historical
    OMP(parallel for collapse(4) schedule(static))//;
    for (int mb = 0; mb < MB; ++mb) {
        for (int c = 0; c < C; ++c) {
            for (int h = 0; h < H; ++h) {
                for (int w = 0; w < W; ++w) {
                    ker(&dst[data_d.off(mb, c, h, w)], mb, c, h, w);
                }
            }
        }
    }
#elif KER_OC // vectorize over channels C --> simple-test-c over double speed
    parallel_nd(MB, H, W, ker_oc );
#else // novector gives fastest (hard to vectorize across 'size' channels)
    if (fmt == nchw) {
        parallel_nd(MB, H, W, C,
            [&](int mb, int h, int w, int c) {
            const size_t off = DATA_OFF_NCHW(mb,c,h,w);
            ker(&dst[off], mb, c, h, w);
        });
    }else if (fmt == nhwc) {
        parallel_nd(MB, H, W, C,
            [&](int mb, int h, int w, int c) {
            const size_t off = DATA_OFF_NHWC(mb,c,h,w);
            ker(&dst[off], mb, c, h, w);
        });
    }else if (fmt == nChw16c || fmt == nChw8c) {
        parallel_nd(MB, utils::div_up(C, blksize), H, W,
            [&](int mb, int c_blk, int h, int w) {
            int c = c_blk * blksize;
            const size_t off = DATA_OFF_nChwNc(mb,c,h,w);
#if defined(__ve)
            //ShortLoop()// short, but ker is internally vectorized;
            _Pragma("_NEC novector");
#else
            PRAGMA_OMP_SIMD()//;
#endif
            for (int cc = 0; cc < nstl::min(blksize, C - c); ++cc)
                ker(&dst[off + cc], mb, c + cc, h, w);
        });
    } else {
        parallel_nd(MB, C, H, W,
            [&](int mb, int c, int h, int w) {
            const size_t off = DATA_OFF_ANY(mb, c, h, w);
            ker(&dst[off], mb, c, h, w);
        });
    }
#endif
}

template <impl::data_type_t data_type>
template <mkldnn_memory_format_t fmt>
void ref_lrn_bwd_t<data_type>::execute_backward() {
    using namespace alg_kind;
    using namespace memory_format;

    auto src = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto diff_dst = reinterpret_cast<const data_t *>(this->input_memory(1));
    auto diff_src = reinterpret_cast<data_t*>(this->memory(0));

    const memory_desc_wrapper data_d(conf_.src_pd());
    const memory_desc_wrapper diff_data_d(conf_.diff_dst_pd());
    MAYBE_UNUSED(diff_data_d);

    const int MB = conf_.MB();
    const int C = conf_.C();
    const int H = conf_.H();
    const int W = conf_.W();
    const size_t stride_mb = data_d.blocking_desc().strides[0][0];
    constexpr int blksize = fmt == nChw16c ? 16 : 8;

    const float alpha = static_cast<float>(conf_.desc()->lrn_alpha);
    const float beta = static_cast<float>(conf_.desc()->lrn_beta);
    const float k = static_cast<float>(conf_.desc()->lrn_k);
    const int kernel_size = conf_.desc()->local_size;
    const int half_ksize = (kernel_size - 1) / 2;

    auto data_off = [&](int mb, int c, int h, int w) -> size_t {
        switch (fmt) {
        case nChw16c:
        case nChw8c: return mb * stride_mb + c/blksize * H * W * blksize
                     + h * W * blksize + w * blksize + c%blksize;
        case nchw: return mb * stride_mb + c * H * W + h * W + w;
        case nhwc: return mb * stride_mb + h * W * C + w * C + c;
        default: return data_d.off(mb, c, h, w);
        }
    };

    auto ker = [=](data_t *d, int mb, int oc, int oh, int ow) {
        const int c_st = nstl::max(oc - half_ksize + 0, 0);
        const int c_en = nstl::min(oc + half_ksize + 1, C);

        float A = 0, B = 0, omega_mid = 0;
        for (int c = c_st; c < c_en; c++) {
            float sum = 0.0;
            const int i_st = nstl::max(c - half_ksize, 0);
            const int i_en = nstl::min(c + kernel_size - half_ksize, C);

            for (int i = i_st; i < i_en; ++i) {
                const float value = src[data_off(mb, i, oh, ow)];
                sum += value * value;
            }
            const float omega = static_cast<float>(k + sum * alpha / kernel_size);
            if (c == oc) omega_mid = omega;
            float t = src[data_off(mb, c, oh, ow)]
                   * fast_negative_powf(omega, beta);
            B += 1.0f / omega * t * diff_dst[data_off(mb, c, oh, ow)];
        }

        const size_t off = data_off(mb, oc, oh, ow);
        A = fast_negative_powf(omega_mid, beta) * diff_dst[off];
        B *= src[off];
        B *= (2.0f * alpha * beta) / kernel_size;
        *d = static_cast<data_t>(A - B); // final cast down to data_t
    };

#if 0
    OMP(parallel for collapse(4) schedule(static))//;
    for (int mb = 0; mb < MB; ++mb) {
        for (int c = 0; c < C; ++c) {
            for (int h = 0; h < H; ++h) {
                for (int w = 0; w < W; ++w) {
                    ker(&diff_src[diff_data_d.off(mb, c, h, w)], mb, c, h, w);
                }
            }
        }
    }
#else
    if (fmt == nChw16c || fmt == nChw8c) {
        parallel_nd(MB, utils::div_up(C, blksize), H, W,
            [&](int mb, int c_blk, int h, int w) {
            int c = c_blk * blksize;
            const size_t off = mb * stride_mb + c * H * W +
                (h * W + w) * blksize;
#if defined(__ve)
            ShortLoop()//;
#else
            PRAGMA_OMP_SIMD()//;
#endif
            for (int cc = 0; cc < nstl::min(blksize, C - c); ++cc)
                ker(&diff_src[off + cc], mb, c + cc, h, w);
        });
    } else if (fmt == nhwc) {
        parallel_nd(MB, H, W, C,
            [&](int mb, int h, int w, int c) {
            const size_t off = mb * stride_mb + h * W * C + w * C + c;
            ker(&diff_src[off], mb, c, h, w);
        });
    } else {
        parallel_nd(MB, C, H, W,
            [&](int mb, int c, int h, int w) {
            const size_t off = data_off(mb, c, h, w);
            ker(&diff_src[off], mb, c, h, w);
        });
    }
#endif
}

template void ref_lrn_fwd_t<data_type::f32>::execute_forward<memory_format::nChw16c>();
template void ref_lrn_fwd_t<data_type::f32>::execute_forward<memory_format::nChw8c>();
template void ref_lrn_fwd_t<data_type::f32>::execute_forward<memory_format::nchw>();
template void ref_lrn_fwd_t<data_type::f32>::execute_forward<memory_format::nhwc>();
template void ref_lrn_fwd_t<data_type::f32>::execute_forward<memory_format::any>();
template void ref_lrn_bwd_t<data_type::f32>::execute_backward<memory_format::nChw16c>();
template void ref_lrn_bwd_t<data_type::f32>::execute_backward<memory_format::nChw8c>();
template void ref_lrn_bwd_t<data_type::f32>::execute_backward<memory_format::nchw>();
template void ref_lrn_bwd_t<data_type::f32>::execute_backward<memory_format::nhwc>();
template void ref_lrn_bwd_t<data_type::f32>::execute_backward<memory_format::any>();

}
}
}
// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
