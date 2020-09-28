/*******************************************************************************
* Copyright 2016-2020 Intel Corporation
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
 * ref:any fwd convolution
 */
// this is impl 4, for "plain" (stridable phys address calc) of ref_convolution.cpp.2
// conv.in timings for ref:plain of conv.in beginning at ref:plain ih90 tests:
// 37.62 38.87 32.13 65.68 65.61 plain-postops 18.62 18.62 18.53 97.88
//
// older timings (dev codes)
// & historical runs
// errors:
// 0 : rconv-0.log OK, mistrusted 3 of conv.in mode=C Real Time 17.934
// 1 : rconv-1.log seg fault in --conv g32ic32ih112oc32oh112kh3ph1n"mobilenet:conv2_1/dw"
// 1 : rconv-1.log OK RTime 15.98 s
// 2 : rconv-2.log OK 15.72 s
// 3 : rconv-3.log OK 15.43 s
// 4 : rconv-4.log OK 15.23 s
// 5 : rconv-5.log OK  3.52 s
// 6 : rconv-6.log OK  2.42 s

// conv-gemm.in
// gemm :       190,213,145,265 (191,194,120)
//   add --skip-impl=gemm to run ref impls?
//   NO. comment them out in cpu_convolution_list.cpp
//   Perhaps benchdnn should use iterator api to continue trying
//   to find a non-skipped impl.
//
//   Cannot skip gemm convolution and still run the ref impl (lower) !)
// conv.in (much smaller tests when no gemm impl present)
// -1 : 48.5984 75.4461 68.4999 107.548 31.2228 24.5472 25.612  24.4907 203.698
//  0 : 48.6771 84.7707 87.7413 108.005 40.8471 24.7904 25.6382 24.2934 215.264
//  1 : xx.5149 51.7053 43.977  73.167  39.4347 18.7586 18.9639 18.6456 132.379
//  2 : 32.7245 40.2169 38.188  63.3137 36.6195 16.373  16.5362 16.4141 102.588
//  3 : 31.4836 38.6193 31.9966 59.813  32.5218 15.7574 15.9223 15.7973 95.3827
//  --- add a FWD_D test
//  3 : 31.3331 38.3888 31.7553 59.4035 59.3386 32.1725 15.4924 15.4991 15.491 92.2239
//  4 : 30.8901 37.9487 31.4165 58.203 58.1731 32.5846 15.2864 15.2907 15.2818 89.9907
// 4 : 30.9838 39.6846 32.9677 58.3858 58.3249 32.5824 15.3221 15.3263 15.3218 89.7068
// fix test_convolution_forward_u8s8s32 and test_convolution_eltwise_forward_x8s8f32s32 bugs
// for "most advanced" of each impl ...
// ...........................................
//  3     : 41.21 47.58 39.59 76.27 76.19
//        : 14477 3208. 190.8 18254 18259 34.30 postops-plain: 20.47 20.47 20.47 120.1
//  4plain: 38.61 42.98 38.35  68.23 68.16
//     any: 13528 3081. 182.6 17049 17050 33.01 postops-plain: 19.09 19.11 19.10 103.5
//  5     : 41.06 46.42 39.19 75.12 75.06  3.38 postops-plain: 20.33 20.34 20.33 118.1
//     any: 377.6 168.4 144.3 524.2 524.1 
//  6plain: 42.34 50.19 44.38  79.06 79.03
//          179.1 92.30 72.30 256.04 255.92 (wcrd for inner)
//  6any  : 240.82 86.59 66.90 337.87 337.93 1.70 postops-plain 20.91 20.96 20.87 125.91
//        : 233.44 78.32 55.64 321.82 321.73 1.51 postops-plain 87.41 87.41 87.41,628.67
//   --> use wcrd only for generic kernel (vectorize offset calcs)
//       because ker_plain6 vectorizes well with nc++
//   --> revert to 4 for ker_plain? what is the main diff?
//6:-1 : 43.82 54.13 44.51 83.62  83.58
//  any: 248.5 85.25 58.90 341.5 332.45 1.63 postops-plain: 21.69 21.71 21.71 135.1
//6:0  : 76.53 78.86 60.23 140.6 140.5 
//  any: 233.7 79.04 57.25 322.4 322.2 1.52 postops-plain: 37.77 37.77 37.77 264.3
//6:1  : 173.1 96.14 77.00 252.1 251.1
//  any: 233.6 79.36 57.51 321.9 321.8 1.51 postops-plain 85.06 85.55 84.42 616.0
//6:2  : 181.4 100.6 78.92 259.2 250.2 259.2
//  any: 233.7 78.35 56.91 322.0 321.9 1.51 postops-plain 88.61 88.46 88.61 637.3
//  --> use 4 for plain, and 6:1 for small improvement of 'any'
//6:0 with unsigned IKLIMS macro: (above used div_floor)
//       40.78 45.75 38.11 74.46 74.41
//       235.9 81.27 57.63 325.6 325.6 1.57 postops-plain: 20.19 10.19 10.19 116.5
// Enabling more IKLIMS test cases, I find that NOT using the fn call leads to
// miscompilation !!!  Only hoist_ApiB(...) fn call avoided all segfaults.

#include "cpu/ve/ref_convolution_util.hpp"
#include "cpu/ve/hoist.hpp"     // nc++: hoist linear conditions out of loops
#include <iostream> // tmp debug


#include "common/ve/memory_desc_wrapper_opt.hpp"

#define PRAG(...) PragmaQuote(_NEC __VA_ARGS__)
#define LISTVEC PRAG(list_vector)
#define VFOR(VAR,LIM) ShortLoop() for(int VAR = 0; VAR < LIM; ++VAR)

#if 0
static int verbose=0; // 0 = print all, increase to reduce verbosity
static int file_errors=0;
static bool chk( bool cond, char const* msg, char const* file, int const lineno ){
    if (!cond){
        printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno);
        ++file_errors;
        //exit(1);
    }
    return cond;
}
static bool trivial( int const verb, bool const cond, char const* msg,
                             char const* file, int const lineno ){
        if (verb > verbose && cond){
                    printf("@@@ trivial: %s : [%s:%d]\n", msg, file, lineno); fflush(stdout);
                        }

            return cond;
}
//#define MUST( COND )
#define MUST( COND )    chk(    (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
#define PRINTF(...)     do{ printf(__VA_ARGS__); fflush(stdout);}while(0)
#define TRIVIAL( COND ) COND
//#define TRIVIAL( COND ) trivial(1, (COND), #COND, __PRETTY_FUNCTION__, __LINE__)

#define CONV_CHECK(EXPR) do {if (!(EXPR)) {printf(" FAILED: " #EXPR "\n");}} while(0)
#if defined(NDEBUG)
#define DPRINTF(...)
#define DMUST(...) 1
#else
#define DPRINTF(...)  do{printf(__VA_ARGS__); fflush(stdout);}while(0)
#define DMUST(...)    MUST(__VA_ARGS__)
#endif

inline ALWAYS_INLINE void hoist_ApiBx(
        int& ilo, int& ihi,                     // sub-for-loop outputs
        const int ibeg, const int iend,         // orig for(i=ibeg;i<iend;++i) <-- stride 1
        const int a,    const int b,            // linear fn o=a+ib
        const int obeg, const int oend)         // linear fn range [obeg,oend)
{
    // div_floor approach for int args, not the unsigned generalization
    int err = 0;
    if(!MUST( b > 0 )) ++err;
    ilo = div_floor( obeg -a+b-1, b );
    if(!MUST( a + (ilo-1) * b < obeg )) ++err;
    if(!MUST( a + (ilo  ) * b >= obeg )) ++err;
    ihi = div_floor( oend -a+b-1, b );
    if(!MUST( a + (ihi-1) * b < oend )) ++err;
    if(!MUST( a + (ihi  ) * b >= oend )) ++err;
    if(err) printf(" hoist err: ibeg,iend=%d,%d  a,b=%d,%d  obeg,oend=%d,%d  ilo=%d ihi=%d\n",
            ibeg,iend,a,b,obeg,oend,ilo,ihi);
    if( ilo < ibeg ) ilo = ibeg;
    else if( ilo > iend ) ilo = iend; // intentionally NOT enforced
    if( ihi >= iend ) ihi = iend;
    else if( ihi < ibeg ) ihi = ibeg; // intentionally NOT enforced
}

// vector window-tile access macros
#define DHW_W 0
#define DHW_H 1
#define DHW_D 2
// which = 0,1,2 for w, h, d respectively
// following COULD be done reasonably, but nc++ precalculates
// most pointers, using mem load instead "lea" calc (could use single reg).
// so still fair amount of register spill,restore and mem loads
#define DHW_SHIFT(which,idx)    dhw[((which*3  )*MVL)+idx]
#define DHW_ST(which,idx)       dhw[((which*3+1)*MVL)+idx]
#define DHW_EN(which,idx)       dhw[((which*3+2)*MVL)+idx]

#define DEFINE_IN_RANGE_VEC(idx, which, ksz, isz) \
    DHW_ST(which,idx) = (DHW_SHIFT(which,idx)       >   0 \
            ? DHW_SHIFT(which,idx): 0); \
    DHW_EN(which,idx) = (DHW_SHIFT(which,idx) + ksz < isz \
            ? DHW_SHIFT(which,idx) + ksz: isz); \
    if (DHW_EN(which,idx) < DHW_ST(which,idx)) \
            DHW_EN(which,idx) = DHW_ST(which,idx)

// macro version of window_precalc
#define POOL_WINDOW_LOOP(d_spatial, dvl, STRIDE, PAD, KSZ, ISZ, p_off, p_st, p_en, ssz) do \
{ \
    ShortLoop() for(int i=0; i<dvl; ++i) { \
        p_off[i] = d_spatial[i]/*od or oh or ow*/ * STRIDE - PAD; \
        p_st[i] = (p_off[i] > 0? p_off[i]: 0); \
        p_en[i] = (p_off[i] + KSZ < ISZ? p_off[i] + KSZ: ISZ); \
        if (p_en[i] < p_st[i]) p_en[i] = p_st[i]; \
        ssz[i] *= p_en[i] - p_st[i]; \
    } \
} while(0)

// alternate precalc loop, that backward avg-pooling really prefers !

// expects SD,KD,ID,padF, etc int consts defined as usual
// dcrd info passed in as dm~dcrd.get_dim() dvl~dcrd.get_vl(),
// and d_spatial0 ~ (int32_t*)&dcrd.vp[2][0].
#define POOL_WINDOW_PRECALC(dm, dvl, d_spatial0, ssz, dhw) do \
{ \
    int const* d_spatial = d_spatial0; \
    int * p_off; /* input coord offset (from destination coord) */ \
    int * p_st; /* input coord start */ \
    int * p_en; /* input coord end, >= start*/ \
    ShortLoop() for(int i=0; i<dvl; ++i) \
        ssz[i] = 1; \
    if (dm >= 5) { \
        p_off = dhw + 6*MVL; \
        p_st  = dhw + 7*MVL; \
        p_en  = dhw + 8*MVL; \
        POOL_WINDOW_LOOP(d_spatial, dvl, SD, padF, KD, ID, \
                p_off, p_st, p_en, ssz); \
        d_spatial += MVL; /*dcrd.MaxVl*/ \
    } \
    if (dm >= 4) { \
        p_off = dhw + 3*MVL; \
        p_st  = dhw + 4*MVL; \
        p_en  = dhw + 5*MVL; \
        POOL_WINDOW_LOOP(d_spatial, dvl, SH, padT, KH, IH, \
                p_off, p_st, p_en, ssz); \
        d_spatial += MVL; /*dcrd.MaxVl*/ \
    } \
    p_off = dhw + 0*MVL; \
    p_st  = dhw + 1*MVL; \
    p_en  = dhw + 2*MVL; \
    POOL_WINDOW_LOOP(d_spatial, dvl, SW, padL, KW, IW, \
            p_off, p_st, p_en, ssz); \
} while(0)

// SCRD_LIMITS macro uses POOL_WINDOW_PRECALC constants to set up
// iterator limits for pooling window overlapped with src
//
// pack up the i'th overlapped pooling window limits into rlo,rhi vectors.
// mb_ptr ~ &dcrd.vp[0][0]
// dhw ~ precalc offset,start,end vector data for ovlp window limits
// ssz ~ precalc window num-elements
// dm ~ dimension (3,4,5)
// scrd ~ (output) initialized CONV WINDOW src-coordinate-iterator mb,icxg[,d[,h]],w
// wcrd ~ [g,]oc,ic[,kd,[,kh]],kw
#define SCRD_LIMITS(i, mb_ptr, dhw, ssz, dm, scrd) do \
{ \
    int32_t* slo = (int32_t*)scrd.raw_lo(); \
    int32_t* shi = (int32_t*)scrd.raw_hi(); \
    auto const* crds = &mb_ptr[i]; \
    slo[0] = *crds; /*MB*/ \
    shi[0] = *crds+1; \
    slo[1] = 0; \
    shi[1] = 1; /*placehoder for ic < ICxG*/ \
    auto const* precalc = &dhw[i]; /* for(w,h,d): shift, start ,end vectors*/ \
    if (dm >= 5) { \
        slo[2] = precalc[(DHW_D*3+1)*MVL];  \
        shi[2] = precalc[(DHW_D*3+2)*MVL]; \
        slo[3] = precalc[(DHW_H*3+1)*MVL]; \
        shi[3] = precalc[(DHW_H*3+2)*MVL]; \
        slo[4] = precalc[(DHW_W*3+1)*MVL]; \
        shi[4] = precalc[(DHW_W*3+2)*MVL]; \
    } else if (dm >= 4) { \
        slo[2] = precalc[(DHW_H*3+1)*MVL]; \
        shi[2] = precalc[(DHW_H*3+2)*MVL]; \
        slo[3] = precalc[(DHW_W*3+1)*MVL]; \
        shi[3] = precalc[(DHW_W*3+2)*MVL]; \
    } else { \
        slo[2] = precalc[(DHW_W*3+1)*MVL]; \
        shi[2] = precalc[(DHW_W*3+2)*MVL];  \
    } \
    *scrd.raw_sz() = ssz[i]; \
    *scrd.raw_dim() = dm; \
    scrd.init_nd(0); \
} while(0)
#endif

namespace dnnl {
namespace impl {
namespace cpu {

//using math::get_bias;

//typedef CoordsForNd<6,uint64_t,uint64_t> Coords;
// let's use 32-bit Crd (Pos can still be u64)
// oh. Pos u64 stilll required by memory_desc_wrapper_opt

// 32-bit coordinate ranges, 64-bit logical/physical offsets, iterable
typedef CoordsForNd<6,uint32_t,int64_t> Coords32;
// src-pixel coords (mb,oc,id,ih,iw when they are valid)

// Sometimes just need raw coordinate memory.
// (generated from other Coords32 etc.).
typedef memory_desc_wrapper_opt::VecPos32 VecPos32;
// a.k.a. CoordRegs<uint32_t, 6>,
// cast to int32_t* sometimes avoids VE conversion nonsense

//namespace {

//}//anon::

template <data_type_t src_type, data_type_t wei_type, data_type_t dst_type,
        data_type_t acc_type>
void ref_convolution_fwd_t<src_type, wei_type, dst_type,
        acc_type>::execute_forward_plain(const exec_ctx_t &ctx) const {
    auto src = CTX_IN_MEM(const src_data_t *, DNNL_ARG_SRC);
    auto weights = CTX_IN_MEM(const wei_data_t *, DNNL_ARG_WEIGHTS);
    auto bias = CTX_IN_MEM(const char *, DNNL_ARG_BIAS);
    auto dst = CTX_OUT_MEM(dst_data_t *, DNNL_ARG_DST);

    typedef typename ref_convolution_fwd_t<src_type, wei_type, dst_type,
            acc_type>::pd_t mypd_t;
    mypd_t const* mypd = pd();
    assert( mypd->ker_type() == pd_t::plain); // "ref:plain"

    const memory_desc_wrapper src_d(mypd->src_md());
    const memory_desc_wrapper dst_d(mypd->dst_md());
    const memory_desc_wrapper weights_d(mypd->weights_md(0));
    const memory_desc_wrapper bias_d(mypd->weights_md(1));

    const bool with_groups = mypd->with_groups();

    const int G = mypd->G();
    const int MB = mypd->MB();
    const int OD = mypd->OD();
    const int OH = mypd->OH();
    const int OW = mypd->OW();
    const int ID = mypd->ID();
    const int IH = mypd->IH();
    const int IW = mypd->IW();

    const int OCxG = mypd->OC();        // all channels
    const int ICxG = mypd->IC();
    const int OC = OCxG / G;            // channels per group
    const int IC = ICxG / G;
    //printf(" g%dic%doc%d IC,OC(per group)=%d,%d\n", G,ICxG,OCxG, IC,OC);
    const int KD = mypd->KD();
    const int KH = mypd->KH();
    const int KW = mypd->KW();

    const int KSD = mypd->KSD();
    const int KSH = mypd->KSH();
    const int KSW = mypd->KSW();

    const int KDD = mypd->KDD() + 1;
    const int KDH = mypd->KDH() + 1;
    const int KDW = mypd->KDW() + 1;

    const int padFront = mypd->padFront();
    const int padT = mypd->padT();
    const int padL = mypd->padL();

    const int ndims = mypd->desc()->src_desc.ndims;

    using namespace data_type;
    bool constexpr is_int_conv = utils::one_of(src_type, s32, s8, u8);

    // scale_idx_mult = 1 for per_oc scales and 0, otherwise
    const int scale_idx_mult
            = mypd->attr()->output_scales_.mask_ == (1 << 1);
    const float *scales = mypd->attr()->output_scales_.scales_;


    const post_ops_t& ops = mypd->attr()->post_ops_;

    auto maybe_postops_vec3 = [&](float *a, float const *dst_float, int const dvl) {
        NOVEC //;PRAG(unroll(dnnl_post_ops::capacity))//;
        for (int idx = 0; idx < ops.len_; ++idx) {
            const auto &e = ops.entry_[idx];
            if (e.kind == dnnl_sum) {
                VFOR(i,dvl) {
                    a[i] += e.sum.scale * dst_float[i];
                }
            } else {
#if 0 //orig
                VFOR(i,dvl) {
                    a[i] = eltwises_[idx]->compute_scalar(a[i]);
                }
#elif 1
                // may see +/-0, +/-inf "limit cases" difference for nc++
                eltwises_[idx]->compute_vec_reg(a, a, dvl);
                //using cvt = Cvt<data_t, is_int_dt>;
                // conv postops are pure-float!
#else // assumes dvl small:
                assert( dvl <= MVL );
                float tmp[MVL];
                eltwises_[idx]->compute_vec_reg(tmp, a, dvl);
                VFOR(i,dvl) a[i] = tmp[i];
#endif
            }
        }
    };

    // Sum and post ops:

    // make offset calls "look the same". We suffer a fn call anyway for the offset.
    auto off_abxg = (with_groups
            ? (ndims == 5? offg5d: ndims == 4? offg4d:
                ndims == 3? offg3d: oops)
            : (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops));
    auto off_abx = (ndims == 5? off5d: ndims == 4? off4d:
                ndims == 3? off3d: oops);

    auto ker = [=](int g, int mb, int oc, int od, int oh, int ow) {
        acc_data_t d = 0;
        for_(int ic = 0; ic < IC; ++ic)
        for_(int kd = 0; kd < KD; ++kd)
        for_(int kh = 0; kh < KH; ++kh)
        for (int kw = 0; kw < KW; ++kw) {
            const int id = od * KSD - padFront + kd * KDD;
            const int ih = oh * KSH - padT + kh * KDH;
            const int iw = ow * KSW - padL + kw * KDW;

            if (id < 0 || id >= ID) continue;
            if (ih < 0 || ih >= IH) continue;
            if (iw < 0 || iw >= IW) continue;

#if 0
            if (ndims == 5)
                d += (acc_data_t)src[src_d.off(mb, g * IC + ic, id, ih, iw)]
                        * (with_groups ? weights[weights_d.off(
                                   g, oc, ic, kd, kh, kw)]
                                       : weights[weights_d.off(
                                               oc, ic, kd, kh, kw)]);
            else if (ndims == 4)
                d += (acc_data_t)src[src_d.off(mb, g * IC + ic, ih, iw)]
                        * (with_groups ? weights[weights_d.off(
                                   g, oc, ic, kh, kw)]
                                       : weights[weights_d.off(
                                               oc, ic, kh, kw)]);
            else if (ndims == 3)
                d += (acc_data_t)src[src_d.off(mb, g * IC + ic, iw)]
                        * (with_groups ? weights[weights_d.off(g, oc, ic, kw)]
                                       : weights[weights_d.off(oc, ic, kw)]);
            else
                assert(false);
#else
            acc_data_t const ss = src[ off_abx(
                    src_d, 0, mb, g * IC + ic, id, ih, iw) ];
            acc_data_t const ww = weights[ off_abxg(
                    weights_d, g, oc, ic, kd, kh, kw) ];
            d += ss * ww;
#endif
        }
        return d;
    };

    // help compiler optimize the code
    // constants for plain layouts kernel
    const dnnl_dims_t &src_str = src_d.blocking_desc().strides;
    const dim_t src_ic_stride = src_str[1];
    const dim_t src_id_stride = (ndims == 5) ? src_str[2] : 0;
    const dim_t src_ih_stride = (ndims >= 4) ? src_str[ndims - 2] : 0;
    const dim_t src_iw_stride = (ndims >= 3) ? src_str[ndims - 1] : 0;
    const dnnl_dims_t &weights_str = weights_d.blocking_desc().strides;
    const int gr_shift = with_groups ? 1 : 0;
    const dim_t weights_ic_stride = weights_str[1 + gr_shift];
    const dim_t weights_kd_stride
            = (ndims == 5) ? weights_str[2 + gr_shift] : 0;
    const dim_t weights_kh_stride
            = (ndims >= 4) ? weights_str[ndims - 2 + gr_shift] : 0;
    const dim_t weights_kw_stride
            = (ndims >= 3) ? weights_str[ndims - 1 + gr_shift] : 0;

    auto ker_plain = [&](int const g, int const mb, int const oc, int const od, int const oh, int const ow) {
        assert(3 <= ndims && ndims <= 5);
        acc_data_t d = 0;
        const src_data_t * __restrict src_loc;
        const wei_data_t * __restrict weights_loc;
        {
            const dim_t src_loc_off = off_abx(src_d, 0, mb, g * IC, 0, 0, 0);
            src_loc = src + src_loc_off;
            const dim_t weights_loc_off = off_abxg(weights_d, g, oc, 0, 0, 0, 0);
            weights_loc = weights + weights_loc_off;
        }
        //assert(  g >= 0 &&  g <  G );
        //assert( mb >= 0 && mb < MB );
        //assert( oc >= 0 && oc < OC );
        //assert( od >= 0 && od < OD );
        //assert( oh >= 0 && oh < OH );
        //assert( ow >= 0 && ow < OW );

        if (IC > KW) {
            for_(dim_t kd = 0; kd < KD; ++kd)
            for_(dim_t kh = 0; kh < KH; ++kh)
            for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                //if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                //        || iw >= IW)
                //    continue;
                if (id < 0 || id >= ID) continue;
                if (ih < 0 || ih >= IH) continue;
                if (iw < 0 || iw >= IW) continue;
                for (int ic = 0; ic < IC; ++ic) {
                    const dim_t src_off = ic + id * src_id_stride
                            + ih * src_ih_stride + iw * src_iw_stride;
                    const dim_t weights_off = ic * weights_ic_stride
                            + kd * weights_kd_stride + kh * weights_kh_stride
                            + kw;
                    d += (acc_data_t)src_loc[src_off]
                            * weights_loc[weights_off];
                }
            }
        } else {
            NOVEC for_(dim_t ic = 0; ic < IC; ++ic)
            NOVEC for_(dim_t kd = 0; kd < KD; ++kd)
            NOVEC for_(dim_t kh = 0; kh < KH; ++kh)
            //NOVEC // REQUIRED for VE to avoid [some, NOT ALL] segfaults :(
            NOVEC for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                //if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                //        || iw >= IW)
                //    continue;
                if (id < 0 || id >= ID) continue;
                if (ih < 0 || ih >= IH) continue;
                if (iw < 0 || iw >= IW) continue;
                asm("###"); // this too is required to avoid segfaultj
                const dim_t src_off = ic + id * src_id_stride
                        + ih * src_ih_stride + iw * src_iw_stride;
                const dim_t weights_off = ic * weights_ic_stride
                        + kd * weights_kd_stride + kh * weights_kh_stride + kw;
                d += (acc_data_t)src_loc[src_off]
                        * weights_loc[weights_off];
            }
        }
        return d;
    };
#if 0 // devel version
    // pooling has a more advanced "iterate over source pre-image tile" method
    // but for strided offset calc, the compiler does a good job vectorizing
    // (well... apart from bugs circumvented by asm("#") to reduce optimization)
    auto ker_plain6 = [&](int const g, int const mb, int const oc,
            int const od, int const oh, int const ow) {
        //assert(3 <= ndims && ndims <= 5);
        acc_data_t d = 0;
        const src_data_t * __restrict src_loc;
        const wei_data_t * __restrict weights_loc;
        {
            const dim_t src_loc_off = off_abx(src_d, 0, mb, g * IC, 0, 0, 0);
            src_loc = src + src_loc_off;
            const dim_t weights_loc_off = off_abxg(weights_d, g, oc, 0, 0, 0, 0);
            weights_loc = weights + weights_loc_off;
        }
        //assert(  g >= 0 &&  g <  G );
        //assert( mb >= 0 && mb < MB );
        //assert( oc >= 0 && oc < OC );
        //assert( od >= 0 && od < OD );
        //assert( oh >= 0 && oh < OH );
        //assert( ow >= 0 && ow < OW );

#if OPT6<0 // ~ original impl
        if (IC > KW) {
            for_(dim_t kd = 0; kd < KD; ++kd)
            for_(dim_t kh = 0; kh < KH; ++kh)
            for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                        || iw >= IW)
                    continue;
                //if (id < 0 || id >= ID) continue;
                //if (ih < 0 || ih >= IH) continue;
                //if (iw < 0 || iw >= IW) continue;
                for (int ic = 0; ic < IC; ++ic) {
                    const dim_t src_off = ic + id * src_id_stride
                            + ih * src_ih_stride + iw * src_iw_stride;
                    const dim_t weights_off = ic * weights_ic_stride
                            + kd * weights_kd_stride + kh * weights_kh_stride
                            + kw;
                    d += (acc_data_t)src_loc[src_off]
                            * weights_loc[weights_off];
                }
            }
        } else {
            NOVEC for_(dim_t ic = 0; ic < IC; ++ic)
            NOVEC for_(dim_t kd = 0; kd < KD; ++kd)
            NOVEC for_(dim_t kh = 0; kh < KH; ++kh)
            //NOVEC // REQUIRED for VE to avoid [some, NOT ALL] segfaults :(
            NOVEC for (dim_t kw = 0; kw < KW; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                //if (id < 0 || id >= ID || ih < 0 || ih >= IH || iw < 0
                //        || iw >= IW)
                //    continue;
                if (id < 0 || id >= ID) continue;
                if (ih < 0 || ih >= IH) continue;
                if (iw < 0 || iw >= IW) continue;
                asm("###"); // this too is required to avoid VE segfault
                const dim_t src_off = ic + id * src_id_stride
                        + ih * src_ih_stride + iw * src_iw_stride;
                const dim_t weights_off = ic * weights_ic_stride
                        + kd * weights_kd_stride + kh * weights_kh_stride + kw;
                d += (acc_data_t)src_loc[src_off]
                        * weights_loc[weights_off];
            }
        }
#endif //OPT6<0
#if OPT6>=0
        // new vectorization, based on ker6
        // currently, using Coords32 to lump the for loops
        // is SLOWER than nc++'s vectorization of the nested loops.
        // (even with 'asm' and NOVEC, it seems).
        Coords32 crd; // ic, [[kd,] kh,] kw
#if OPT6==0
        int kd_st=0, kd_en=1; // id_0 a.k.a A or ocrd*STRIDE-PAD
        int kh_st=0, kh_en=1;
        int kw_st=0, kw_en=1;
#endif
        int id_0=0, ih_0=0, iw_0=0;
        {
#if OPT6>=1
            int kd_st=0, kd_en=1; // id_0 a.k.a A or ocrd*STRIDE-PAD
            int kh_st=0, kh_en=1;
            int kw_st=0, kw_en=1;
#endif
            if (ndims >= 5)
                IKLIMS(od, KSD, padFront, KDD, KD, ID, kd_st, kd_en, id_0);
            if (ndims >= 4)
                IKLIMS(oh, KSH, padT    , KDH, KH, IH, kh_st, kh_en, ih_0);
            if (1) //ndims >= 3
                IKLIMS(ow, KSW, padL    , KDW, KW, IW, kw_st, kw_en, iw_0);
            //assert( weights_d.ndims() == dm + (with_groups? 1: 0) );
            //       dcrd  // mb, OCxG, [[od,] oh,] ow
            {
                auto const dm = dst_d.ndims(); // MB, OCxG, OD?, OH?, OW
                auto * rlo = crd.raw_lo();
                auto * rhi = crd.raw_hi();
                Coords32::pos_t sz = Coords32::pos_t{1};
                *rlo++ = 0;
                *rhi++ = IC;
                sz *= IC;
                if (dm >= 5) {
                    *rlo++ = kd_st;
                    *rhi++ = kd_en;
                    sz *= kd_en - kd_st;
                }
                if (dm >= 4) {
                    *rlo++ = kh_st;
                    *rhi++ = kh_en;
                    sz *= kh_en - kh_st;
                }
                if (1) {
                    *rlo++ = kw_st;
                    *rhi++ = kw_en;
                    sz *= kw_en - kw_st;
                }
                *crd.raw_sz() = sz;
                *crd.raw_dim() = weights_d.ndims();
                crd.init_nd(0);
            }
        }

#if OPT6==0 // JUST the loop-limit-precalc...
        if (IC > KW) {
            for_(dim_t kd = kd_st; kd < kd_en; ++kd)
            for_(dim_t kh = kh_st; kh < kh_en; ++kh)
            for (dim_t kw = kw_st; kw < kw_en; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                for (int ic = 0; ic < IC; ++ic) {
                    const dim_t src_off = ic + id * src_id_stride
                            + ih * src_ih_stride + iw * src_iw_stride;
                    const dim_t weights_off = ic * weights_ic_stride
                            + kd * weights_kd_stride + kh * weights_kh_stride
                            + kw;
                    d += (acc_data_t)src_loc[src_off]
                            * weights_loc[weights_off];
                }
            }
        } else {
            for_(dim_t ic = 0; ic < IC; ++ic)
            for_(dim_t kd = kd_st; kd < kd_en; ++kd)
            for_(dim_t kh = kh_st; kh < kh_en; ++kh)
            for (dim_t kw = kw_st; kw < kw_en; ++kw) {
                const dim_t id = od * KSD - padFront + kd * KDD;
                const dim_t ih = oh * KSH - padT + kh * KDH;
                const dim_t iw = ow * KSW - padL + kw * KDW;
                const dim_t src_off = ic + id * src_id_stride
                        + ih * src_ih_stride + iw * src_iw_stride;
                const dim_t weights_off = ic * weights_ic_stride
                        + kd * weights_kd_stride + kh * weights_kh_stride + kw;
                d += (acc_data_t)src_loc[src_off]
                        * weights_loc[weights_off];
            }
        }
#else // OPT6 > 0
        int const* pw = reinterpret_cast<int const*>(&crd.vp[0][0]);
        int const ws_ic = weights_ic_stride;
        int const ws_kd = weights_kd_stride;
        int const ws_kh = weights_kh_stride;
        int const ws_kw = weights_kw_stride;
        for( ; crd; ++crd) // crd ~ ic[,kd,[,kh]],kw
        {
            int const wvl = crd.get_vl();
            dim_t wei_off[MVL]; VREG(wei_off);
            dim_t src_off[MVL]; VREG(src_off);
            int const* restrict const vic = &pw[0*MVL];
            if (dm >= 5) {
#if OPT6==1
                VFOR(w,wvl) { //vec : crd --> wei/src_off[]
                    {
                        int const ic = pw[0*MVL+w];
                        src_off[w] = ic;
                        wei_off[w] = ic * ws_ic;
                    }
                    {
                        int kd = pw[1*MVL+w];
                        wei_off[w] += kd * ws_kd;
                        //int const id = id_0 + kd * KDD;
                        kd = kd * KDD + id_0;
                        src_off[w] += kd * src_id_stride;
                    }
                    {
                        int const kh = pw[2*MVL+w];
                        wei_off[w] += kh * ws_kh;
                        int const ih = ih_0 + kh * KDH;
                        src_off[w] += ih * src_ih_stride;
                    }
                    {
                        int const kw = pw[3*MVL+w];
                        wei_off[w] += kw;
                        int const iw = iw_0 + kw * KDW;
                        src_off[w] += iw * src_iw_stride;
                    }
                }
#else
                int const* restrict const vkd = &pw[1*MVL];
                int const* restrict const vkh = &pw[2*MVL];
                int const* restrict const vkw = &pw[3*MVL];
                VFOR(w,wvl) { //vec : crd --> wei/src_off[]
                    wei_off[w] = vic[w] * weights_ic_stride
                            + vkd[w] * weights_kd_stride
                            + vkh[w] * weights_kh_stride
                            + vkw[w];
                    src_off[w] = vic[w]
                            + (id_0 + vkd[w] * KDD)/*id*/ * src_id_stride
                            + (ih_0 + vkh[w] * KDH)/*ih*/ * src_ih_stride
                            + (iw_0 + vkw[w] * KDW)/*iw*/ * src_iw_stride;
                }
#endif
            } else if (dm >= 4) {
#if OPT6==1
                VFOR(w,wvl) { //vec : crd --> wei/src_off[]
                    int const ic = pw[0*MVL+w];
                    int const kh = pw[1*MVL+w];
                    int const kw = pw[2*MVL+w];
                    wei_off[w] = ic * ws_ic
                            + kh * ws_kh + kw;
                    int const ih = ih_0 + kh * KDH;
                    int const iw = iw_0 + kw * KDW;
                    src_off[w] = ic + ih * src_ih_stride
                            + iw * src_iw_stride;
                }
#else
                int const* restrict const vkh = &pw[1*MVL];
                int const* restrict const vkw = &pw[2*MVL];
                VFOR(w,wvl) { //vec : crd --> wei/src_off[]
                    wei_off[w] = vic[w] * ws_ic
                            //+ vkd[w] * ws_kd
                            + vkh[w] * ws_kh
                            + vkw[w];
                    src_off[w] = vic[w]
                            //+ (id_0 + vkd[w] * KDD)/*id*/ * src_id_stride
                            + (ih_0 + vkh[w] * KDH)/*ih*/ * src_ih_stride
                            + (iw_0 + vkw[w] * KDW)/*iw*/ * src_iw_stride;
                }
#endif
            } else { // dm >= 3
#if OPT6==1
                VFOR(w,wvl) { //vec : crd --> wei/src_off[]
                    int const ic = pw[0*MVL+w];
                    int const kw = pw[1*MVL+w];
                    wei_off[w] = ic * ws_ic + kw;
                    int const iw = iw_0 + kw * KDW;
                    src_off[w] = ic + iw * src_iw_stride;
                }
#else
                //int const* restrict const vkd = &pw[1*MVL];
                //int const* restrict const vkh = &pw[1*MVL];
                int const* restrict const vkw = &pw[1*MVL];
                VFOR(w,wvl) { //vec : crd --> wei/src_off[]
                    wei_off[w] = vic[w] * weights_ic_stride
                            //+ vkd[w] * weights_kd_stride
                            //+ vkh[w] * weights_kh_stride
                            + vkw[w];
                    src_off[w] = vic[w]
                            //+ (id_0 + vkd[w] * KDD)/*id*/ * src_id_stride
                            //+ (ih_0 + vkh[w] * KDH)/*ih*/ * src_ih_stride
                            + (iw_0 + vkw[w] * KDW)/*iw*/ * src_iw_stride;
                }
#endif
            }
            VFOR(w,wvl) {
                acc_data_t const ss = src_loc[src_off[w]];
                acc_data_t const ww = weights_loc[wei_off[w]];
                d += ss * ww;
            }
        }//for-crd
#endif
#endif // OPT6>=0
        return d;
    };
#endif

    auto elems = (size_t)MB * OCxG * OD * OH * OW;
    auto dst_dopt = memory_desc_wrapper_opt(dst_d.md_);
    auto bias_dopt = memory_desc_wrapper_opt(
            bias? bias_d.md_: dst_d.md_/*useless*/);
    auto src_dopt = memory_desc_wrapper_opt(src_d.md_);
    auto weights_dopt = memory_desc_wrapper_opt(weights_d.md_);

    auto const bias_data_type = mypd->desc()->bias_desc.data_type;
    if (bias) {
        assert( bias_data_type == data_type::s8
                || bias_data_type == data_type::u8
                || bias_data_type == data_type::s32
                || bias_data_type == data_type::f32);
        assert( bias_d.ndims() == 1 );
    } else {
        assert( bias_data_type == data_type::undef );
    }

    auto kern4 = [&](int ithr, int nthr) {
        //1b2: 31.3331 38.3888 31.7553 59.4035 59.3386 32.1725 15.4924 15.4991 15.491 92.2239
        size_t start, end;
        balance211(elems, nthr, ithr, start, end);
        auto const dm = dst_d.ndims(); // MB, OCxG, OD?, OH?, OW
        assert( dm >= 3 && dm <= 5 );

        Coords32 dcrd(dst_dopt.dims(), dm, start, end);
        // avoid mixing unsigned and int ops VE
        int const* const restrict dcrd_outer0 = reinterpret_cast<int const*>
                (&dcrd.vp[0][0]); 

        int dim_zeros[MVL]; // Coords32, so int loop index OK
        {
            // dcrd.get_vl() never increases, so can init outside dcrd-loop
            int dvl=dcrd.get_vl();
            VFOR(i,dvl) dim_zeros[i] = 0;
        }


        NOVEC for ( ; dcrd; ++dcrd) { // in vec-length chunks of dst coords
            int const dvl = dcrd.get_vl();
            dim_t dst_off[MVL]; // vectorized phys-offset calc
            float dst_gather[MVL]; // gather dst values (MIGHT be used for post_ops)
            dst_dopt.vec_off_v(dcrd.base(), &dst_off[0], dvl, false/*pad*/);
            VFOR(i,dvl) dst_gather[i] = dst[dst_off[i]];

            typedef int const *coord_register_t; // VE: avoid mix signed/unsigned
#define COORD_VEC_REGISTER(VAR, ...) coord_register_t VAR = (__VA_ARGS__)
            auto dcrd_i = dcrd_outer0 + MVL; // also 1 dim before spatial coords
            COORD_VEC_REGISTER(v_ocxg, dcrd_outer0 + MVL);

            float a[MVL]; // accumulator
            if (bias) {
                // bias "coord" is the 1-D set of dcrd.vp[1][i] "OCxG" values
                // low-level offsets from logical bias coords in a VecPos32
                VecPos32 bias_vp; 
                dim_t bias_off[MVL];
                VFOR(i,dvl) bias_vp.vp[0][i] = v_ocxg[i];
                bias_dopt.vec_off_vtmp(bias_vp, &bias_off[0],
                        dvl, false/*pad*/);
                // bias is const char* : coerce the gather & cvt to float a[]
#define CASE(dt) case dt: VFOR(i,dvl) a[i] = (float)((const prec_traits<dt>::type *)bias)[bias_off[i]]; break
                switch(bias_data_type) {
                    CASE(data_type::s8);
                    CASE(data_type::u8);
                    CASE(data_type::s32);
                    CASE(data_type::f32);
                }
#undef CASE
            } else {
                VFOR(i,dvl) a[i] = 0.f;
            }

            {
                int v_g[MVL];
                int v_oc[MVL];
                VFOR(i,dvl) {
                    v_g[i] = v_ocxg[i] / OC;
                    v_oc[i] = v_ocxg[i] % OC;
                }
                COORD_VEC_REGISTER(v_mb, dcrd_outer0);
                // v_ocxg already set
                COORD_VEC_REGISTER(v_od, (dm >= 5? (dcrd_i+=MVL): dim_zeros));
                COORD_VEC_REGISTER(v_oh, (dm >= 4? (dcrd_i+=MVL): dim_zeros));
                COORD_VEC_REGISTER(v_ow, dcrd_i+=MVL); // always exists, dm >= 3
#undef COORD_VEC_REGISTER

                VFOR(i,dvl) { // fn calls, novec
                    a[i] += ker_plain(v_g[i], v_mb[i], v_oc[i], v_od[i], v_oh[i], v_ow[i]);
                }
            }

            //maybe_oscale(a, g, oc);
            //VFOR(i,dvl) a[i] *= scales[v_ocxg[i] * scale_idx_mult];
            if (scale_idx_mult) VFOR(i,dvl) a[i] *= scales[v_ocxg[i]];
            else                VFOR(i,dvl) a[i] *= scales[0];

            maybe_postops_vec3(a, dst_gather, dvl); // faster as lambda? go figure

            VFOR(i,dvl) {
                // technically wrong for OPT==1, but faster !!!
                using cvt_dst = Cvt<dst_data_t, is_int_conv>;
                dst_gather[i] = cvt_dst::qs(a[i]);
                dst[dst_off[i]] = dst_gather[i];
            }
        }
    };

    bool constexpr force_sequential = 0; // 1 for debug
    parallel((force_sequential? 1: 0), kern4);
}

using namespace data_type;

template struct ref_convolution_fwd_t<f32>;
template struct ref_convolution_fwd_t<bf16,bf16,bf16,f32>;
template struct ref_convolution_fwd_t<bf16,bf16,f32,f32>;

template struct ref_convolution_fwd_t<u8, s8, f32, s32>;
template struct ref_convolution_fwd_t<u8, s8, s32, s32>;
template struct ref_convolution_fwd_t<u8, s8, s8, s32>;
template struct ref_convolution_fwd_t<u8, s8, u8, s32>;
template struct ref_convolution_fwd_t<s8, s8, f32, s32>;
template struct ref_convolution_fwd_t<s8, s8, s32, s32>;
template struct ref_convolution_fwd_t<s8, s8, s8, s32>;
template struct ref_convolution_fwd_t<s8, s8, u8, s32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
