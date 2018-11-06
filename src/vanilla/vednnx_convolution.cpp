#include "vednnx_convolution.hpp"
#if VEJIT > 0

#include "vednnx.h"

#include "mkldnn_thread.hpp"
#include "mkldnn_traits.hpp"
#include "math_utils.hpp"

#if MKLDNN_REF_CONV_DBG
#include "mkldnn_io.h"
#include "string.h"
#include <unordered_set> // to track new ref_convolutions (potential to optimize?)
#endif

#include <iostream>

namespace mkldnn {
namespace impl {
namespace cpu {

using math::saturate;

#if MKLDNN_REF_CONV_DBG
// There are mkldnn_format_last^3 possible combinations, of which only
// a small percentage commonly occur.  We can restrict register optimized cases
// into a lookup table XXX eventually.
template<mkldnn_memory_format_t s, mkldnn_memory_format_t wb, mkldnn_memory_format_t d>
inline int constexpr cmem_fmt_tag() {
    mkldnn_memory_format_t const m=mkldnn_format_last;
    return ((s)*m + wb)*m + d;
}
inline int mem_fmt_tag(mkldnn_memory_format_t s, mkldnn_memory_format_t wb, mkldnn_memory_format_t d){
    mkldnn_memory_format_t const m=mkldnn_format_last;
    return ((s)*m + wb)*m + d;
}
// maintain a registry, and avoid outputting duplicates
static std::unordered_set<int> seen;

/** return a short substring of the possibly long convolution function name.
 * Layer conf_`->name()` can return a very long function name, like
 * `<retval> <namespaces>::LAYER_t<template args>::pd_t::name() [with ...]`.
 * So try to pick out just the **LAYER_t** portion.
 *
 * \deprecated mkl-dnn introduced name() and info() functions!
 */
static inline char const* short_impl(char const* impl_str)
{
    int const lenmax=64;
    static char buffer[lenmax];
    char *buf = &buffer[0];
    int rem_len = lenmax;
#define DPRINT(...) do \
    { \
        int n = snprintf(buf, rem_len, __VA_ARGS__); \
        if( n > rem_len ){ rem_len = 0; } \
        else { buf+=n; rem_len-=n; } \
    } while(0)
    if (impl_str == nullptr){
        DPRINT("noimpl");
        return &buffer[0];
    }
    /* search for a reasonable 'end' character */
    char const* q = strstr(impl_str, "(");     /* until __FUNCTION__ ( */
    char const* q2 = strstr(impl_str, "::pd_t::name");       /* common */
    if (q==nullptr || (q2 && q2 < q)) q = q2;
    q2 = strstr(impl_str, "<");         /* ignore template-spec if any */
    if (q==nullptr || (q2 && q2 < q)) q = q2;

    if( q==nullptr ){ /* give up */
        DPRINT("%s", impl_str);
        return &buffer[0];
    }

    /* search for a nice 'start' character */
    char const *p = impl_str;
    char const * p2;
    for( p2=q; p2>p; --p2) if(*p2==' ') break; /* ignore return type */
    if (*p2==' ') p = p2 + 1;
    for( p2=q; p2>p; --p2) if(*p2==':') break; /* ignore namespace */
    if (*p2==':') p = p2 + 1;

    /* copy range [p,q), and null-terminate */
    for(int i=0; i<lenmax; ++i){
        if( p+i < q ){
            buffer[i] = p[i];
        } else {
            buffer[i] = '\0';
            break;
        }
    }
    buffer[lenmax-1] = '\0';
    return &buffer[0];
#undef DPRINT
}
/** substring after the last ':' */
static inline char const* after_last_colon(const char* msg) {
    const char * last_colon = strrchr(msg, ':');
    return last_colon? last_colon+1: msg;
}

#endif // MKLDNN_REF_CONV_DBG

#if TARGET_VANILLA // uglify constructor with optional debug code
vednnx_convolution_fwd_t
::vednnx_convolution_fwd_t (const pd_t *pd, const input_vector &inputs,
                          const output_vector &outputs)
    : cpu_primitive_t(&conf_, inputs, outputs), conf_(*pd) {
#if MKLDNN_REF_CONV_DBG
    /* print "name" of impl if first time constructed */
    mkldnn_memory_format_t const sfmt = conf_.src_pd()->desc()->format;
    mkldnn_memory_format_t const wbfmt = conf_.weights_pd()->desc()->format;
    mkldnn_memory_format_t const dfmt = conf_.dst_pd()->desc()->format;
    int tag = mem_fmt_tag(sfmt,wbfmt,dfmt);
    auto ins = seen.insert( tag );
    if(ins.second){ // a one-line message
        printf("\n *** NEW FMTS for %s *** src %s,  wei|bia %s,  dst %s\n",
                    short_impl(conf_.name()),
                    after_last_colon(mkldnn_name_memory_format( sfmt )),
                    after_last_colon(mkldnn_name_memory_format( wbfmt )),
                    after_last_colon(mkldnn_name_memory_format( dfmt )));
    }
    if(ins.second){ // extra detail
#define LEN 500
        char sbuf[LEN], wbuf[LEN], dbuf[LEN]; // bias layout same as weights
        mkldnn_name_memory_desc( conf_.src_pd()->desc(),     sbuf, LEN );
        mkldnn_name_memory_desc( conf_.weights_pd()->desc(), wbuf, LEN );
        mkldnn_name_memory_desc( conf_.dst_pd()->desc(),     dbuf, LEN );
        printf(" _vednnx_conv( src         %s\n"
               "          , weight/bias %s\n"
               "          , dst         %s\n",
               &sbuf[0], &wbuf[0], &dbuf[0]);
#undef LEN
    }
#endif /* MKLDNN_REF_CONV_DBG */
}
#endif // TARGET_VANILLA (constructor)

void vednnx_convolution_fwd_t
::execute_forward() {
    using std::cout;
    using std::endl;
    auto src = reinterpret_cast<const src_data_t *>(this->input_memory(0));
    auto weights = reinterpret_cast<const wei_data_t *>(this->input_memory(1));
    auto bias = reinterpret_cast<const char *>(this->input_memory(2));
    auto dst = reinterpret_cast<dst_data_t *>(this->memory());

    const memory_desc_wrapper src_d(conf_.src_pd());
    const memory_desc_wrapper dst_d(conf_.dst_pd());
    const memory_desc_wrapper weights_d(conf_.weights_pd(0));
    const memory_desc_wrapper bias_d(conf_.weights_pd(1));

    const bool with_groups = conf_.with_groups();

    const int G = conf_.G();
    const int MB = conf_.MB();
    const int OD = conf_.OD();
    const int OH = conf_.OH();
    const int OW = conf_.OW();
    const int ID = conf_.ID();
    const int IH = conf_.IH();
    const int IW = conf_.IW();

    const int OC = conf_.OC() / G;
    const int IC = conf_.IC() / G;
    const int KD = conf_.KD(); //one
    const int KH = conf_.KH();
    const int KW = conf_.KW();

    const int KSD = conf_.KSD(); //one
    const int KSH = conf_.KSH();
    const int KSW = conf_.KSW();

    // important! libvednn convention!
    //if (KDW==0) KDW = 1;
    //if (KDH==0) KDH = 1;
    const int KDD = (conf_.KDD()? conf_.KDD(): 1); //zero
    const int KDH = (conf_.KDH()? conf_.KDH(): 1);
    const int KDW = (conf_.KDW()? conf_.KDW(): 1);

    const int padFront = conf_.padFront();
    const int padT = conf_.padT();
    const int padL = conf_.padL();

    const float nslope = conf_.negative_slope();

    const int ndims = conf_.cdesc()->src_desc.ndims;

    // assert memory_desc_wrapper dims OK ...
    vednnTensorParam_t tpIn {DTYPE_FLOAT, MB, IC*G, IW, IH}; // nb strange order
    vednnFilterParam_t tpKrn{DTYPE_FLOAT, IC, OC, KW, KH};
    vednnTensorParam_t tpOut{DTYPE_FLOAT, MB, OC*G, OW, OH};
    cout<<"tpIn {f32,"<<MB<<","<<IC*G<<","<<IW<<","<<IH<<"}"<<endl;
    cout<<"tpKrn{f32,"<<IC<<","<<OC<<","<<KW<<","<<KH<<"}"<<endl;
    cout<<"tpOut{f32,"<<MB<<","<<OC*G<<","<<OW<<","<<OH<<"}"<<endl;

    //vednnConvolutionParam_t parm{ G, KSW, KSH, padL, padT, KDW, KDH };
    vednnConvolutionParam_t parm{ G, KSW, KSH, padL, padT, KDW, KDH };
    cout<<"parm{g"<<G<<"_sw"<<KSW<<"sh"<<KSH<<"_pw"<<padL<<"ph"<<padT<<"_dw"<<KDW<<"dh"<<KDH<<"}"<<endl;

    vednnError_t status;
    if (bias){
        vednnBiasParam_t tpBias {DTYPE_FLOAT, OC*G};
        status =  vednnConvolutionForwardAddBias(
                &tpIn,   src,
                &tpKrn,  weights,
                &tpBias, bias,
                &tpOut,  dst,
                &parm, VEDNN_CONV_ALGORITHM_DIRECT );
        cout<<"FWD_B status"<<status<<endl;
    }else{
        status = vednnConvolutionForward(
                &tpIn,  src,
                &tpKrn, weights,
                &tpOut, dst,
                &parm, VEDNN_CONV_ALGORITHM_DIRECT );
        cout<<"FWD_D status"<<status<<endl;
    }
    assert(status == VEDNN_SUCCESS);
#if 0
        switch (conf_.cdesc()->bias_desc.data_type) {
        CASE(data_type::s8);
        CASE(data_type::u8);
        CASE(data_type::s32);
        CASE(data_type::f32);
        default: assert(!"unimplemented");
        }
#endif
}

void vednnx_convolution_bwd_data_t
        ::execute_backward_data() {
    auto diff_dst = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto weights = reinterpret_cast<const data_t *>(this->input_memory(1));
    auto diff_src = reinterpret_cast<data_t*>(this->memory());
    //auto bias = reinterpret_cast<const char *>(this->input_memory(2));

    const memory_desc_wrapper diff_dst_d(conf_.diff_dst_pd());
    const memory_desc_wrapper diff_src_d(conf_.diff_src_pd());
    const memory_desc_wrapper weights_d(conf_.weights_pd(0));
    const memory_desc_wrapper bias_d(conf_.weights_pd(1));

    const bool with_groups = conf_.with_groups();

    const int G = conf_.G();
    const int MB = conf_.MB();
    const int OD = conf_.OD();
    const int OH = conf_.OH();
    const int OW = conf_.OW();
    const int ID = conf_.ID();
    const int IH = conf_.IH();
    const int IW = conf_.IW();

    const int OC = conf_.OC() / G;
    const int IC = conf_.IC() / G;
    const int KD = conf_.KD();
    const int KH = conf_.KH();
    const int KW = conf_.KW();

    const int KSD = conf_.KSD();
    const int KSH = conf_.KSH();
    const int KSW = conf_.KSW();

    const int KDD = conf_.KDD(); //zero
    const int KDH = conf_.KDH();
    const int KDW = conf_.KDW();

    const int padFront = conf_.padFront();
    const int padT = conf_.padT();
    const int padL = conf_.padL();

    const int ndims = conf_.cdesc()->diff_src_desc.ndims;

#if 1 // vednn library call parms ...
    // assert memory_desc_wrapper dims OK ...
    // rv[1] = createTensorParam(&pConv->pParamGradIn, DTYPE_FLOAT, pNw->batchNum, pNw->inChannel, pNw->inWidth, pNw->inHeight);
    // rv[2] = createKernelParam(&pConv->pParamKernel, DTYPE_FLOAT, inChannelGroup, outChannelGroup, pNw->kernWidth, pNw->kernHeight);
    // rv[0] = createTensorParam(&pConv->pParamGradOut, DTYPE_FLOAT, pNw->batchNum, pNw->outChannel, pNw->outWidth, pNw->outHeight);
    // rv[3] = createConvolutionParam(&pConv->pParamConv, pNw->group, pNw->strideWidth, pNw->strideHeight, pNw->padWidth, pNw->padHeight, 1, 1);
    //
    vednnTensorParam_t tpGradIn {DTYPE_FLOAT, MB, IC*G, IW, IH}; // nb W, H order
    vednnFilterParam_t tpKrn    {DTYPE_FLOAT, IC, OC, KW, KH};
    vednnTensorParam_t tpGradOut{DTYPE_FLOAT, MB, OC*G, OW, OH}; // <-- calc ~ diff_src
    vednnConvolutionParam_t parm{ G, KSW, KSH, padL, padT, KDW, KDH };

    // mkl-dnn uses bias, but just for sanity checking
    vednnError_t const status
        = vednnConvolutionBackwardData(
                &tpGradIn , diff_dst,
                &tpKrn    , weights,
                &tpGradOut, diff_src,
                &parm, VEDNN_CONV_ALGORITHM_DIRECT );
    assert(status == VEDNN_SUCCESS);
    //Consistency ok("vednn-bkwd"); SHCKV(ok,status==VEDNN_SUCCESS); //?
#else
    auto ker = [=](acc_data_t &d, int g, int mb, int ic, int id, int ih,
            int iw) {
        for (int oc = 0; oc < OC; ++oc) {
            for (int kd = 0; kd < KD; ++kd) {
                for (int kh = 0; kh < KH; ++kh) {
                    for (int kw = 0; kw < KW; ++kw) {
                        if (iw + padL < kw * (1 + KDW)
                            || ih + padT < kh * (1 + KDH)
                            || id + padFront < kd * (1 + KDD))
                            continue;
                        int ow = iw - kw * (1 + KDW) + padL;
                        int oh = ih - kh * (1 + KDH) + padT;
                        int od = id - kd * (1 + KDD) + padFront;
                        if (ow % KSW != 0 || oh % KSH != 0 || od % KSD != 0 )
                            continue;

                        ow /= KSW;
                        oh /= KSH;
                        od /= KSD;

                        if (od < OD && oh < OH && ow < OW) {
                            if (ndims == 5)
                            d += (acc_data_t)diff_dst[diff_dst_d.off(mb, g*OC
                                + oc, od, oh, ow)] * (with_groups
                                ? weights[weights_d.off(g, oc, ic, kd, kh, kw)]
                                : weights[weights_d.off(oc, ic, kd, kh, kw)]);
                            else
                            d += (acc_data_t)diff_dst[diff_dst_d.off(mb, g*OC
                                + oc, oh, ow)] * (with_groups
                                ? weights[weights_d.off(g, oc, ic, kh, kw)]
                                : weights[weights_d.off(oc, ic, kh, kw)]);

                        }
                    }
                }
            }
        }
    };

    auto get_bias = [=, &bias](size_t off) -> acc_data_t {
        // We only do a sanity check here.
#       define CASE(dt) case dt: \
            return (acc_data_t)(*((const prec_traits<dt>::type *)bias + off))
        switch (conf_.desc()->bias_desc.data_type) {
        CASE(data_type::s8);
        CASE(data_type::u8);
        CASE(data_type::s32);
        CASE(data_type::f32);
        default: assert(!"unimplemented");
        }
#       undef CASE
        return 0; // <--- bias contributes nothing to gradient.
    };
    parallel_nd(G, MB, IC, ID, IH, IW,
        [&](int g, int mb, int ic, int id, int ih, int iw) {
        auto ds_idx = (ndims == 5)
            ? diff_src_d.off(mb, g*IC + ic, id, ih, iw)
            : diff_src_d.off(mb, g*IC + ic, ih, iw);
        acc_data_t a = bias
            ? get_bias(bias_d.off(g*IC + ic))
            : (acc_data_t)0;
        ker(a, g, mb, ic, id, ih, iw);
        diff_src[ds_idx] = saturate<diff_src_data_t>(a);
    });
#endif
}

void vednnx_convolution_bwd_weights_t
     ::execute_backward_weights() {
    auto src          = reinterpret_cast<const data_t *>(this->input_memory(0));
    auto diff_dst     = reinterpret_cast<const data_t *>(this->input_memory(1));
    auto diff_weights = reinterpret_cast<data_t *>(this->memory(0));
    auto diff_bias    = reinterpret_cast<data_t *>(this->memory(1));
    typedef data_t acc_data_t;

    const memory_desc_wrapper src_d(conf_.src_pd());
    const memory_desc_wrapper diff_dst_d(conf_.diff_dst_pd());
    const memory_desc_wrapper diff_weights_d(conf_.diff_weights_pd(0));
    const memory_desc_wrapper diff_bias_d(conf_.diff_weights_pd(1));

    const bool with_groups = conf_.with_groups();

    const int G = conf_.G();
    const int MB = conf_.MB();
    const int OD = conf_.OD();
    const int OH = conf_.OH();
    const int OW = conf_.OW();
    const int ID = conf_.ID();
    const int IH = conf_.IH();
    const int IW = conf_.IW();

    const int OC = conf_.OC() / G;
    const int IC = conf_.IC() / G;
    const int KD = conf_.KD();
    const int KH = conf_.KH();
    const int KW = conf_.KW();

    const int KSD = conf_.KSD();
    const int KSH = conf_.KSH();
    const int KSW = conf_.KSW();

    const int KDD = conf_.KDD(); //zero
    const int KDH = conf_.KDH();
    const int KDW = conf_.KDW();

    const int padFront = conf_.padFront();
    const int padT = conf_.padT();
    const int padL = conf_.padL();

    const int ndims = conf_.cdesc()->src_desc.ndims;

    using std::cout;
    using std::endl;
#if 1
    // bias update is simple because grad(bias) = grad(output)
    // so it is usually not calculated.
    // rv[0] = createTensorParam(&pConv->pParamIn, DTYPE_FLOAT, pNw->batchNum, pNw->inChannel, pNw->inWidth, pNw->inHeight);
    // rv[1] = createTensorParam(&pConv->pParamGradOut, DTYPE_FLOAT, pNw->batchNum, pNw->outChannel, pNw->outWidth, pNw->outHeight);
    // rv[2] = createKernelParam(&pConv->pParamGradKernel, DTYPE_FLOAT, inChannelGroup, outChannelGroup, pNw->kernWidth, pNw->kernHeight);
    // rv[3] = createConvolutionParam(&pConv->pParamConv, pNw->group, pNw->strideWidth, pNw->strideHeight, pNw->padWidth, pNw->padHeight, 1, 1);
    //
    vednnTensorParam_t tpIn     {DTYPE_FLOAT, MB, IC*G, IW, IH}; // nb strange order
    vednnTensorParam_t tpGradOut{DTYPE_FLOAT, MB, OC*G, OW, OH};
    vednnFilterParam_t tpGradKrn{DTYPE_FLOAT, IC, OC, KW, KH}; // <-- calc ~ diff_weights
    vednnConvolutionParam_t parm{ G, KSW, KSH, padL, padT, KDW, KDH };
    cout<<"parm{g"<<G<<"_sw"<<KSW<<"sh"<<KSH<<"_pw"<<padL<<"ph"<<padT<<"_dw"<<KDW<<"dh"<<KDH<<"}"<<endl;

    vednnError_t const status
        = vednnConvolutionBackwardFilter(
                &tpIn,      src,
                &tpGradOut, diff_dst,
                &tpGradKrn, diff_weights,
                &parm, VEDNN_CONV_ALGORITHM_DIRECT );
    cout<<"BWD_W status"<<status<<endl;
    assert(status == VEDNN_SUCCESS);

    // libvednn does not calculate bias gradient, but mkl-dnn does...
#if 1
    auto ker_bias = [=](acc_data_t &d, int g, int oc) {
        for (int mb = 0; mb < MB; ++mb) {
            // XXX next loops are over dense data, for nchw
            //for (int od = 0; od < OD; ++od) {
                for (int oh = 0; oh < OH; ++oh) {
                    for (int ow = 0; ow < OW; ++ow) {
                        //if (ndims == 5)
                        //d += (acc_data_t)diff_dst[diff_dst_d.off(
                        //    mb, g*OC + oc, od, oh, ow)];
                        //else
                        //d += (acc_data_t)diff_dst[diff_dst_d.off(
                        //    mb, g*OC + oc, oh, ow)];
                        // libvednn supports only nchw ...
                        d += (acc_data_t)diff_dst[ mb*G*OC*OH*OW
                            + (g*OC*oc)*OH*OW + oh*OW + ow ];
                    }
                }
            //}
        }
    };
#endif

    if(diff_bias){
        parallel_nd(G, OC, [&](int g, int oc) {
                acc_data_t db = 0;
#if 1
                ker_bias(db, g, oc);
#else
                int const MBsz = G*OC*OH*OW;
                int const OHOW = OH*OW;
                int const goc = g*OC + oc;
                for (int mb = 0; mb < MB; ++mb) {
                /**/for (int ohow=0; ohow<OHOW; ++ohow){
                /*  */ db += (acc_data_t)diff_dst[mb*MBsz + goc*OHOW + ohow];
                /**/}
                }
#endif
#if 1
                diff_bias[diff_bias_d.off(g*OC+oc)]
                    //= saturate<diff_wei_data_t>(db);
                    = saturate<data_t>(db);
#else
                // XXX replace fn call to 'off' w/ nchw inline formula XXX
                // libvednn bias is never padded, always dense, f32
                diff_bias[g*OC+oc] = db;
#endif
                });
    }
#else
    auto ker = [=](acc_data_t &d, int g, int oc, int ic, int kd, int kh, int kw) {
        for (int mb = 0; mb < MB; ++mb) {
            for (int od = 0; od < OD; ++od) {
                for (int oh = 0; oh < OH; ++oh) {
                    for (int ow = 0; ow < OW; ++ow) {
                        if (ow*KSW + kw * (1 + KDW) < padL
                            || oh*KSH + kh * (1 + KDH) < padT
                            || od*KSD + kd * (1 + KDD) < padFront
                            || ow*KSW + kw * (1 + KDW) >= IW + padL
                            || oh*KSH + kh * (1 + KDH) >= IH + padT
                            || od*KSD + kd * (1 + KDD) >= ID + padFront)
                            continue;

                        int id = od*KSD - padFront + kd * (1 + KDD);
                        int ih = oh*KSH - padT + kh * (1 + KDH);
                        int iw = ow*KSW - padL + kw * (1 + KDW);
                        if (ndims == 5)
                        d += (acc_data_t)diff_dst[diff_dst_d.off(
                            mb, g*OC + oc, od, oh, ow)]
                            * src[src_d.off(mb, g*IC + ic, id, ih, iw)];
                        else
                        d += (acc_data_t)diff_dst[diff_dst_d.off(
                            mb, g*OC + oc, oh, ow)]
                            * src[src_d.off(mb, g*IC + ic, ih, iw)];
                    }
                }
            }
        }
    };

    auto ker_bias = [=](acc_data_t &d, int g, int oc) {
        for (int mb = 0; mb < MB; ++mb) {
            for (int od = 0; od < OD; ++od) {
                for (int oh = 0; oh < OH; ++oh) {
                    for (int ow = 0; ow < OW; ++ow) {
                        if (ndims == 5)
                        d += (acc_data_t)diff_dst[diff_dst_d.off(
                            mb, g*OC + oc, od, oh, ow)];
                        else
                        d += (acc_data_t)diff_dst[diff_dst_d.off(
                            mb, g*OC + oc, oh, ow)];
                    }
                }
            }
        }
    };

    parallel_nd(G, OC, [&](int g, int oc) {
        if (diff_bias) {
            acc_data_t db = 0;
            ker_bias(db, g, oc);
            diff_bias[diff_bias_d.off(g*OC+oc)]
                = saturate<diff_wei_data_t>(db);
        }

        for (int ic = 0; ic < IC; ++ic) {
            for (int kd = 0; kd < KD; ++kd) {
                for (int kh = 0; kh < KH; ++kh) {
                    for (int kw = 0; kw < KW; ++kw) {
                        acc_data_t dw = 0;
                        ker(dw, g, oc, ic, kd, kh, kw);

                        if (ndims == 5)
                        {
                        auto idx = with_groups
                            ? diff_weights_d.off(g, oc, ic, kd, kh, kw)
                            : diff_weights_d.off(oc, ic, kd, kh, kw);
                        diff_weights[idx] = saturate<diff_wei_data_t>(dw);
                        } else {
                        auto idx = with_groups
                            ? diff_weights_d.off(g, oc, ic, kh, kw)
                            : diff_weights_d.off(oc, ic, kh, kw);
                        diff_weights[idx] = saturate<diff_wei_data_t>(dw);
                        }
                    }
                }
            }
        }
    });
#endif
}

}
}
}

// vim: et ts=4 sw=4 cindent cino=^l0,\:0,N-s
#endif // VEJIT > 0
