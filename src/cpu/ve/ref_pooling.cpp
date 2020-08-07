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

#include <assert.h>
#include <math.h>

#include "common/c_types_map.hpp"
#include "common/dnnl_thread.hpp"
#include "common/nstl.hpp"
#include "common/type_helpers.hpp"
#include "common/ve/memory_desc_wrapper_opt.hpp" // we use CoordsFor vectorization helper.

#include "cpu/simple_q10n.hpp"
#include "cpu/ref_pooling.hpp"
//#include "cpu/ve/hoist.hpp"

#define IMPL 0
//#define IMPL 10 // old #1 to see old behavior, w/ debug
//#define IMPL 51? // old #2
#define DO_DBG 0
// after bugfixes (and assertions!) --> 200 ms

// many other fwd impls in ref_pooling.cpp.0-....
// 0 close to original
// 1 inner-loop rewrite (old)
// 2 inner-loop rewrite (old)
// 3 outer loop vec, inner loop~0
// 4 outer loop vec, inner loop~2
// 5 ker_maxb
// 6 ker_maxc
// VE timings:
// test case: --tag=aBx16b --alg=MAX,AVG_NP,AVG_P --dir=FWD_D,BWD_D mb1ic32_ih300iw500_oh151ow251_kh3kw3_sh2sw2_ph1pw1
//      fwd-max bwd-max fwd-avg bwd-avg
// 00   532     1232    480     628
// 01   531     430     
// 11   599     419
// 21   705     434
// 21'  636
// 31   557     418
// 41   572     423
// 51  *421*    421  XXX TODO take IMPL==5 and try for masked vector findmax asm (should be possible)
// 61   508     429
// 50:3 204     587 ***
// 51:0 190     478
// 51:1 189             (VecPos32)
// 51:2 189             (vp[][] base pointers outside inner loop)
// 51:10 194
// 51:11 186    // max vec movement out of inner loop (scalar read vs recalc)
// 52 = cleanup of 51:11
// 52:1 slightly better (kdd_ohw store w/ more compact memory pattern)
// Observed?
//   little effect of gathering into local vec and later scattering ? (sometimes this is a good idea)

// backwards 0~original, 1~outer vec offsets
#define BIMPL 1
// 0 ~ 1232 ms
// 1 ~ 430 ms (even without inner-loops vectorized)

#ifndef MVL
#if defined(__ve)
#define MVL 256
#else
#define MVL 32
#endif
#endif
#define LISTVEC PragmaQuote(_NEC list_vector)
#define NOVEC   PragmaQuote(_NEC novector);

namespace dnnl {
namespace impl {
namespace cpu {

static inline dim_t get_offset(
        const memory_desc_wrapper &mdw, int n, int c, int d, int h, int w) {
    switch (mdw.ndims()) {
        case 3: return mdw.off(n, c, w);
        case 4: return mdw.off(n, c, h, w);
        case 5: return mdw.off(n, c, d, h, w);
        default: assert(!"Invalid tensor dimension in pooling");
    }
    return 0;
}

using namespace nstl;

#if 0 
static void mdw_prt(char const* msg, memory_desc_wrapper const& mdw){
    char a[128], b[128];
    dnnl_md2fmt_str(a,128,mdw.md_);
    dnnl_md2dim_str(b,100,mdw.md_);
    printf(" %s %s %s\n", msg, a, b);
    fflush(stdout);
}
#endif

template <data_type_t data_type, data_type_t acc_type>
void ref_pooling_fwd_t<data_type, acc_type>::execute_forward(
        const exec_ctx_t &ctx) const {
    int constexpr v = 0; // verbose?

    auto src = CTX_IN_MEM(const data_t *, DNNL_ARG_SRC);
    auto dst = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);
    auto ws = CTX_OUT_MEM(unsigned char *, DNNL_ARG_WORKSPACE);

    const memory_desc_wrapper src_d(pd()->src_md());
    const memory_desc_wrapper dst_d(pd()->dst_md());
    const memory_desc_wrapper ws_d(pd()->workspace_md());

    assert( src_d.ndims() >= 3 );
    assert( src_d.ndims() <= 5 );
    assert( dst_d.ndims() == src_d.ndims() );
    assert( src_d.format_kind() == format_kind::blocked );
    assert( dst_d.format_kind() == format_kind::blocked );

    const memory_desc_wrapper_opt src_d_opt(src_d.md_);
    const memory_desc_wrapper_opt dst_d_opt(dst_d.md_);
    const memory_desc_wrapper_opt *ws_d_opt{nullptr};


    auto alg = pd()->desc()->alg_kind;
    const data_type_t ws_dt = ws ? ws_d.data_type() : data_type::undef;

    if (ws) assert(ws_dt == data_type::u8 || ws_dt == data_type::s32);
    if (ws) {
        //mdw_prt("yes ws:", ws_d);
        assert(ws_dt == data_type::u8 || ws_dt == data_type::s32);
        assert(alg == alg_kind::pooling_max);
        assert( ws_d.format_kind() == format_kind::blocked );
        // avoid init and setup cost if possible
        ws_d_opt = new memory_desc_wrapper_opt(ws_d.md_);
    } // else NO guarantees on ws_d content

    const int ID = pd()->ID();
    const int IH = pd()->IH();
    const int IW = pd()->IW();
    const int KD = pd()->KD();
    const int KH = pd()->KH();
    const int KW = pd()->KW();
    const int SD = pd()->KSD();
    const int SH = pd()->KSH();
    const int SW = pd()->KSW();
    const int padF = pd()->padFront();
    const int padT = pd()->padT();
    const int padL = pd()->padL();

    typedef CoordsForNd<6,uint64_t,uint64_t> Coords;

#ifndef NDEBUG
    if (ws && ws_dt == data_type::u8) {
        assert( KD * KH * KW <= numeric_limits<typename prec_traits<
                data_type::u8>::type>::max());
    }
#endif

    auto set_ws = [=](int mb, int oc, int od, int oh, int ow, int value) {
        dim_t off = -1; // "invalid" return offset
        if (ws) {
            off = get_offset(ws_d, mb, oc, od, oh, ow);
            //if (v>0 && IH==0) printf(" set_ws @ %ld to %d\n",off,value);
            if (ws_dt == data_type::u8) {
                //assert(0 <= value
                //        && value <= numeric_limits<typename prec_traits<
                //                        data_type::u8>::type>::max());
                ws[off] = value;
            } else
                reinterpret_cast<int *>(ws)[off] = value;
        }
        return off;
    };

    auto set_ws_off = [=](dim_t ws_off, int value) {
        //if (v>0 && IH==0) printf(" set_ws_off @ %ld to %d\n",ws_off,value);
        if (ws && ws_off >= 0) {
            if (ws_dt == data_type::u8) {
                assert(0 <= value
                        && value <= numeric_limits<typename prec_traits<
                                        data_type::u8>::type>::max());
                ws[ws_off] = value;
            } else
                reinterpret_cast<int *>(ws)[ws_off] = value;
        }
    };

    auto ker_avg = [=](data_t *d, int mb, int oc, int od, int oh, int ow) {
        auto id_start = max(od * SD - padF, 0);
        auto ih_start = max(oh * SH - padT, 0);
        auto iw_start = max(ow * SW - padL, 0);
        auto id_end = min(od * SD - padF + KD, ID);
        auto ih_end = min(oh * SH - padT + KH, IH);
        auto iw_end = min(ow * SW - padL + KW, IW);

        auto num_summands = (alg == alg_kind::pooling_avg_include_padding)
                ? KW * KH * KD
                : (id_end - id_start) * (ih_end - ih_start)
                        * (iw_end - iw_start);

        acc_data_t dst = 0;
        for_(int id = id_start; id < id_end; ++id)
        for_(int ih = ih_start; ih < ih_end; ++ih)
        for (int iw = iw_start; iw < iw_end; ++iw) {
            const auto off = get_offset(src_d, mb, oc, id, ih, iw);
            dst += src[off];
        }

        d[0] = out_round<data_t>((float)dst / num_summands);
    };

    const int MB = pd()->MB();
    const int OC = pd()->C();
    const int OD = pd()->OD();
    const int OH = pd()->OH();
    const int OW = pd()->OW();
    if( 1 || v) {
        char d[100], s[100], w[100], dd[100], ss[100], ww[100];
        dnnl_md2fmt_str(d,100,dst_d.md_);
        dnnl_md2fmt_str(s,100,src_d.md_);
        if (ws) dnnl_md2fmt_str(w,100,ws_d.md_);
        else { w[0] = 'x'; w[1] = '\0'; }
        dnnl_md2dim_str(dd,100,dst_d.md_);
        dnnl_md2dim_str(ss,100,src_d.md_);
        if (ws) dnnl_md2dim_str(ww,100,ws_d.md_);
        else { w[0] = 'x'; w[1] = '\0'; }
        //printf(" MB,OC=%d,%d ID,IH,IW=%d,%d,%d --> OD,OH,OW=%d,%d,%d\n"
        //    " dst %s %s\nsrc %s %s\nwd %s %s\n",
        //    MB,OC, ID,IH,IW, OD,OH,OW, d, dd, s, ss, w, ww);
    }

#if IMPL>=10 // an older impl, TestZeroDim (what is it supposed to do?)
    auto ker_max = [&](data_t *d, int const mb, int const oc, int const od, int const oh, int const ow, dim_t const ws_off) {
#if IMPL==10
        if(v>0) {
            printf(" d[%4ld]: dcrd %d,%d,%d,%d,%d ",(long)((data_t*)d-(data_t*)dst),mb,oc,od,oh,ow);
        }
#if DO_DBG
        bool gotmax=false;
        int kdmax=-1, khmax=-1, kwmax=-1, kkpos=-1;
        int idmax=-1, ihmax=-1, iwmax=-1;
#endif
        for (int kd = 0; kd < KD; ++kd) {
            const int id = od * SD - padF + kd;
            if (id < 0 || id >= ID) continue;
            for (int kh = 0; kh < KH; ++kh) {
                const int ih = oh * SH - padT + kh;
                if (ih < 0 || ih >= IH) continue;
                for (int kw = 0; kw < KW; ++kw) {
                    const int iw = ow * SW - padL + kw;
                    if (iw < 0 || iw >= IW) continue;

                    const auto off = get_offset(src_d, mb, oc, id, ih, iw);
                    auto s = src[off];
                    if (s > d[0]) {
#if DO_DBG
                        gotmax=true;
                        kdmax = kd; khmax = kh; kwmax = kw; kkpos = (kd * KH + kh) * KW + kw;
                        idmax = id; ihmax = ih; iwmax = iw;
#endif
                        d[0] = s;
                        set_ws_off(ws_off, (kd * KH + kh) * KW + kw);
                    }
                }
            }
        }
#if DO_DBG
        if(v>0) printf(" src-dhw %3d %3d %3d gotmax? %d krn-dhw %3d %3d %3d kkpos=%d shift-dhw %3d %3d %3d\n",
                idmax, ihmax, iwmax, (int)gotmax, kdmax, khmax, kwmax, kkpos, od*SD-padF, oh*SH-padT, ow*SW-padL);
#endif
#elif IMPL==11
        int const id0 = od * SD - padF; // input coord for kernel coord kd==0
        int const ih0 = oh * SH - padT;
        int const iw0 = ow * SW - padL;
        // src coords always used, kern coords calc only for max src value
#define DEFINE_IN_RANGE(var_st, var_end, shift, ksz, isz) \
        auto var_st  = (shift       >   0 ? shift: 0); \
        auto var_end = (shift + ksz < isz ? shift + ksz: isz);
        // src spatial window ranges
        DEFINE_IN_RANGE(d_st, d_en, id0, KD, ID);
        DEFINE_IN_RANGE(h_st, h_en, ih0, KH, IH);
        DEFINE_IN_RANGE(w_st, w_en, iw0, KW, IW);
        // NB: scrd loops over source coords, id,ih,iw, NOT kd,kh,kw

        auto const dm = src_d_opt.ndims();
        typedef CoordsForNd<6,uint64_t,uint64_t> Coords;
        auto scrd= (dm >= 5)? Coords::mk(mb,mb+1, oc,oc+1, d_st,d_en, h_st,h_en, w_st,w_en)
            : (dm >= 4)? Coords::mk(mb,mb+1, oc,oc+1, h_st,h_en, w_st,w_en)
            : Coords::mk(mb,mb+1, oc,oc+1, w_st,w_en); // dm>=3
        // scrd coords reflect mb,oc,id,ih,iw
        data_t srcmax = numeric_limits<data_t>::lowest();
        int kkpos=0;
        dim_t srcp[MVL];
        NOVEC for ( ; scrd; ++scrd) {
            const unsigned vl=scrd.get_vl(); // vl ~ id,ih,iw coords
            // still uses vfrmax (VFMAX op)
            src_d_opt.vec_off_vtmp(scrd.base(), (dim_t *)&srcp[0], vl);
            int jmax = -1;
            ShortLoop() for(unsigned j=0U; j<vl; ++j) {
                auto const s= src[srcp[j]];
                if ( s > srcmax ) {
                    srcmax = s;
                    jmax = j;
                }
            }
            if(jmax >= 0 && ws_off >= 0){
                // given imax, calc kd,kh,kw --> kpos --> ws
                //kd = dm >= 5? scrd.vp[dm-3][jmax] - id0: 0;
                //kh = dm >= 4? scrd.vp[dm-2][jmax] - ih0: 0;
                //kw =          scrd.vp[dm-1][jmax] - iw0   ;
                //assert( kd >= 0 && kd < KD );
                //assert( kh >= 0 && kh < KH );
                //assert( kw >= 0 && kw < KW );
                //auto off = get_offset(ws_d, mb, oc, od, oh, ow);
                //assert( off == ws_off );
                //set_ws_off(ws_off, (kd * KH + kh) * KW + kw);
                //kkpos = (kd * KH + kh) * KW + kw;
                kkpos = ((dm >= 5? scrd.vp[dm-3][jmax] - id0: 0)//kd
                        * KH
                        + (dm >= 4? scrd.vp[dm-2][jmax] - ih0: 0))//kh
                        * KW
                        + (scrd.vp[dm-1][jmax] - iw0);//kw
            }
        }
        d[0] = srcmax;
        set_ws_off(ws_off, kkpos);
#endif
    };
#endif // IMPL >= 10

    if (alg == alg_kind::pooling_max) {
#if IMPL>=10
        parallel_nd(MB, OC, OD, OH, OW,
                [&](int mb, int oc, int od, int oh, int ow) {
                    data_t *d = &dst[get_offset(dst_d, mb, oc, od, oh, ow)];
                    d[0] = numeric_limits<data_t>::lowest();
                    dim_t ws_off = set_ws(mb, oc, od, oh, ow, 0);
                    ker_max(d, mb, oc, od, oh, ow, ws_off);
                });
#else
        // options (fine-tune)
#define SCRD 2
        // 0 : 198 ms
        // 1 : 194 ms
        // 2 :
        auto elems = (size_t)MB * OC * OD * OH * OW;
        bool force_sequential = 0; // 1 for debug
        parallel((force_sequential? 1: 0), [&](int ithr, int nthr) {
            size_t start, end;
            balance211(elems, nthr, ithr, start, end);

            // let's use 32-bit Crd (Pos can still be u64)
            // oh. Pos u64 stilll required by memory_desc_wrapper_opt :)
            typedef CoordsForNd<6,uint32_t,int64_t> Coords32;
            auto const dm = dst_d.ndims();
            Coords32 dcrd(dst_d.dims(), dm, start, end);
            Coords32 scrd;

            //assert( dcrd.get_sz() >= 0 );

            // fast-path a limit case.
            bool zero_dim_src = (ID * IH * IW <= 0);

            for( ; dcrd; ++dcrd ) { // in vec-length chunks of dst coordinates
                int const dvl = dcrd.get_vl();
                dim_t dstp[MVL]; //destination physical offsets
                dst_d_opt.vec_off_v(dcrd.base(), &dstp[0], dvl, false/*pad*/);
                dim_t ws_off[MVL]; 
                if (ws) {
                    ws_d_opt->vec_off_v(dcrd.base(), &ws_off[0], dvl, false/*pad*/);
                }

                //
                // input tensors with zero dimension get no special treatment
                // - the kernel overlap with input has zero effective elements
                // - output is then '...<data_t>::lowest()'
                //   - with any workspace filled with zeroes.
                // - i.e. no "broadcasting" semantics
                //   - does NOT do "avg/max over *existing* input coords"
                //
                if (zero_dim_src) {
                    if(v) std::cout<<" zero_dim_src "<<dcrd.lim_str("dcrd")<<"  "<<dcrd.coord_str("dcrd")<<std::endl;
                    ShortLoop() for(int i=0U; i<dvl; ++i)
                        dst[dstp[i]] = numeric_limits<data_t>::lowest();
                    if (ws)
                        ShortLoop() for(int i=0U; i<dvl; ++i)
                            ws[ws_off[i]] = 0; // VE: u8 is unvectorizable
                    continue;
                }

                // spatial coords of src, dst as raw int pointers
                //      VE mixed ops w/ unsigned and signed are clunky
                static_assert( sizeof(dcrd.vp[dm-1][0]) == sizeof(int),
                        "require VecPos32");
#if SCRD>=2
                int const* const mb_ptr = reinterpret_cast<int const*>
                        (&dcrd.vp[0][0]); 
#endif
                int const* const o_spatial0 = reinterpret_cast<int const*>
                        (&dcrd.vp[2][0]);
                int const* const s_spatial0 = reinterpret_cast<int const*>
                        (&scrd.vp[2][0]); 
#define DEFINE_IN_RANGE_VEC(idx, var_st, var_en, shift, ksz, isz) \
                    var_st[idx] = (shift[idx]       >   0 ? shift[idx]: 0); \
                    var_en[idx] = (shift[idx] + ksz < isz ? shift[idx] + ksz: isz); \
                    /* for prettiness*/ var_en[idx] = (var_en[idx] < 0? 0: var_en[idx]); \
                    var_st[idx] = (var_st[idx] > var_en[idx]? var_en[idx]: var_st[idx])
                // Warning: 1st two lines OK for for-loops, but CoordsForNd
                //   **assumes** var_st <= var_en, to make things quicker.

#if SCRD>0
                data_t dst_reg[MVL]; VREG(dst_reg); // oh, we write this as mem :(
#endif
                int kk_dhw[3*MVL]; // if (ws), max-coord memory (vector kpos post-calc)
                // vector precalc constants(--> mem)
                int sz[MVL]; // sz < kern ovlp <= KD*KH*KW (small)
                int iw0[MVL], w_st[MVL], w_en[MVL];
                int ih0[MVL], h_st[MVL], h_en[MVL];
                int id0[MVL], d_st[MVL], d_en[MVL];

                // actually, kernel size fits in int32_t
                ShortLoop() for(int i=0; i<dvl; ++i)
                        sz[i] = 1;
                int const* o_spatial = o_spatial0;
                {
                    if (dm >= 5) {
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            //assert( o_spatial[i] == dcrd.vp[dm-3][i] );
                            id0[i] = o_spatial[i]/*od*/ * SD - padF;
                            // NB: scrd loops over source coords, id,ih,iw, NOT kd,kh,kw
                            //id = od * SD - padF + kd ~ id0 + kd   (or kd = id - id0), etc.
                            DEFINE_IN_RANGE_VEC(i, d_st, d_en, id0, KD, ID);
                            sz[i] *= d_en[i] - d_st[i];
                        }
                        o_spatial += dcrd.MaxVl;
                    }
                    if (dm >= 4) {
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            //assert( o_spatial[i] == dcrd.vp[dm-2][i] );
                            ih0[i] = o_spatial[i]/*oh*/ * SH - padT;
                            DEFINE_IN_RANGE_VEC(i, h_st, h_en, ih0, KH, IH);
                            sz[i] *= h_en[i] - h_st[i];
                        }
                        o_spatial += dcrd.MaxVl;
                    }
                    ShortLoop() for(int i=0; i<dvl; ++i) {
                        //assert( o_spatial[i] == dcrd.vp[dm-1][i] );
                        iw0[i] = dcrd.vp[dm-1][i]/*ow*/ * SW - padL;
                        DEFINE_IN_RANGE_VEC(i, w_st, w_en, iw0, KW, IW);
                        sz[i] *= w_en[i] - w_st[i];
                    }
                }

                // linear write pattern for remembering kk_dhw[] a bit faster
                auto pkk_dhw = &kk_dhw[0];
                for (int i=0U; i<dvl; ++i) {
#if SCRD<=1
                    int const mb = dcrd.vp[0][i];
                    int const oc = dcrd.vp[1][i];
#endif

                    // set up kernel-window vector iterator into src coords
                    { // "raw" CoordsForNd api faster
                        auto rlo = scrd.raw_lo(); // pointer
                        auto rhi = scrd.raw_hi();
#if SCRD<=1
                        *rlo++ = mb; *rhi++ = mb+1;     // mb
                        *rlo++ = oc; *rhi++ = oc+1;     // oc
#else
                        *rlo++ = mb_ptr[i];             // copy mb
                        *rhi++ = mb_ptr[i]+1;           // from dcrd.
                        *rlo++ = mb_ptr[(int)dcrd.MaxVl+i];  // also oc
                        *rhi++ = mb_ptr[(int)dcrd.MaxVl+i] + 1;
#endif
#if 0 // 201/200
                        if (dm >= 5) {                  // id
                            *rlo++ = d_st[i];
                            *rhi++ = d_en[i];
                        }
                        if (dm >= 4) {                  // ih
                            *rlo++ = h_st[i];
                            *rhi++ = h_en[i];
                        }
                        *rlo++ = w_st[i];
                        *rhi++ = w_en[i];               // iw
#else // 200
                        switch(dm) {
                            case(5): *rlo++ = d_st[i];  // id
                                     *rhi++ = d_en[i];
                            case(4): *rlo++ = h_st[i];  // ih
                                     *rhi++ = h_en[i];
                            default: *rlo++ = w_st[i];  // iw
                                     *rhi++ = w_en[i]; 
                        }
#endif
                        *scrd.raw_sz() = sz[i]; // krn ovlp sz precalc'ed
                        *scrd.raw_dim() = dm;
                        scrd.init_nd(0);
                    }

                    // search krn window for srcmax and kkpos (krn posn of max)
                    //int kkpos = 0;
                    data_t srcmax = numeric_limits<data_t>::lowest();
                    dim_t srcp[MVL];
                    int * psave = nullptr;
                    NOVEC for ( ; scrd; ++scrd) {
                        const unsigned svl=scrd.get_vl(); // svl ~ id,ih,iw coords
                        // calc phy src offsets
                        // Orig: src_d_opt.vec_off_vtmp(scrd.base(), (dim_t *)&srcp[0], svl);
                        // Now preserve vp[][] because later use srcmx coords
                        src_d_opt.vec_off_v(scrd.base(), (dim_t *)&srcp[0], svl);

                        int jmax = -1;
                        ShortLoop() for(unsigned j=0U; j<svl; ++j) {
                            auto const s= src[srcp[j]];
                            if ( s > srcmax ) { // VE vfrmax (VFMAX) op
                                srcmax = s;
                                jmax = j;
                            }
                        }
                        //assert( jmax < scrd.get_pos() + svl );

                        if (jmax >= 0 && ws) {
                            // NB: scrd loops over source coords, id,ih,iw, NOT kd,kh,kw
                            //id = od * SD - padF + kd ~ id0 + kd   (or kd = id - id0), etc.
                            // Remember max SOURCE COORDS in pkk_dhw (point to kk_hdw[]);
                            int const* s_spatial = s_spatial0; // ptr within scrd.
                            psave = pkk_dhw; // phk_dhw moves fwd *after* scrd iter
                            // save spatial ih coords with scalar writes
#if 0 // 203
                            if (dm >=5 ) {
                                *psave++ = s_spatial[jmax];
                                s_spatial += scrd.MaxVl;
                            }
                            if (dm >=4 ) {
                                *psave++ = s_spatial[jmax];
                                s_spatial += scrd.MaxVl;
                            }
                            *psave++ = s_spatial[jmax];
#else // 200
                            switch(dm) { // compact VE scalar code
                                case(5):
                                    *psave++ = s_spatial[jmax];
                                    s_spatial += scrd.MaxVl;
                                case(4):
                                    *psave++ = s_spatial[jmax];
                                    s_spatial += scrd.MaxVl;
                                default:
                                    *psave++ = s_spatial[jmax];
                            }
#endif
                        }
                    }// iter over krn window for max

#if SCRD==0
                    dst[dstp[i]] = srcmax;
#else
                    // vec scatter later seems very slightly faster on VE
                    dst_reg[i] = srcmax;
#endif

                    if (ws) {
                        // equiv. if(!gotmax)
                        // equiv. if(!scrd.get_sz());
                        if (!psave)
                        {
                            // if NO max pos, flag it to skip determining a ws value
                            *pkk_dhw = -1; // illegal: src coords all >= 0
                        }
                        
                        // point to next 1-,2-, or 3-value coords save locn
                        pkk_dhw += dm - 2; // mb: psave may or may not have been set!
                    }


                }//i=1..dvl-1 of dst+ws
#if SCRD>0
                ShortLoop() for(int i=0; i<dvl; ++i) { // as vec-scatter op
                    dst[dstp[i]] = dst_reg[i];
                }
#endif
                if (ws) {

                    // VE prefers conditionals moved out, for vectorization
                    // each dvl<MVL "loop" is one or more simple vector ops
                    //
                    int kkpos[MVL]; VREG(kkpos);
                    ShortLoop() for(int i=0; i<dvl; ++i)
                            kkpos[i] = 0; // default "no max" value for ws

                    // given jmax, calc kd,kh,kw --> kpos --> ws
                    // NB: scrd loops over source coords, id,ih,iw, NOT kd,kh,kw
                    //id = od * SD - padF + kd ~ id0 + kd   (or kd = id - id0), etc.
                    // Remember max SOURCE COORDS in pkk_dhw (point to kk_hdw[]);
                    //
                    {
                        // Flag if no max found: first_spatial[i] = kk_khw[(dm-2)*i];
                        // if first_spatial < 0, this flags "no kkpos" (use zero); 
                        // when vectorizing, just live with possible excess reads
                        // XXX is fall-through switch version possible? (and still vectorized) maybe not.
                        if (dm >= 5) {
                            NOVEC ShortLoop() for(int i=0; i<dvl; ++i) {
                                int d = kk_dhw[3*i];
                                if (d >= 0) {
                                    int h = kk_dhw[3*i+1];
                                    int w = kk_dhw[3*i+2];
                                    kkpos[i] = ((d - id0[i]) * KH
                                            + (h - ih0[i])) * KW
                                            + (w - iw0[i]);
                                }
                            }
                        }else if (dm >= 4) {
                            NOVEC ShortLoop() for(int i=0; i<dvl; ++i) {
                                // Note: if align 8, single-load uint64_t and shift XXX
                                int h = kk_dhw[2*i];
                                if (h >= 0) {
                                    int w = kk_dhw[2*i+1];
                                    kkpos[i] = (h - ih0[i]) * KW
                                            + (w - iw0[i]);
                                }
                            }
                        }else{
                            NOVEC ShortLoop() for(int i=0; i<dvl; ++i) {
                                int w = kk_dhw[i];
                                if (w >= 0) {
                                    kkpos[i] = w - iw0[i];
                                }
                            }
                        }
                    } // end non-trivial, normal kkpos[i] calculation
                    if (ws_dt == data_type::u8) {
#ifndef NDEBUG
                        int kkmin = 999;
                        int kkmax = -1;
#endif
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            //assert(0 <= value
                            //        && value <= numeric_limits<typename prec_traits<
                            //        data_type::u8>::type>::max());
                            ws[ws_off[i]] = kkpos[i];
#ifndef NDEBUG
                            if (kkpos[i] < kkmin ) kkmin = kkpos[i];
                            if (kkpos[i] > kkmax ) kkmax = kkpos[i];
#endif
                        }
#ifndef NDEBUG
                        assert( 0 <= kkmin );
                        assert( kkmax <= numeric_limits<typename prec_traits<
                                data_type::u8>::type>::max());
#endif
                    } else {
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            reinterpret_cast<int *>(ws)[ws_off[i]] = kkpos[i];
                        }
                    }
                }
            } // for dcrd
        });
#endif //IMPL
#undef DEFINE_IN_RANGE_VEC
#undef SCRD
    } else {
        parallel_nd(MB, OC, OD, OH, OW,
                [&](int mb, int oc, int od, int oh, int ow) {
                    data_t *d = &dst[get_offset(dst_d, mb, oc, od, oh, ow)];
                    d[0] = 0;
                    ker_avg(d, mb, oc, od, oh, ow);
                });
    }
}

template <data_type_t data_type>
void ref_pooling_bwd_t<data_type>::execute_backward(
        const exec_ctx_t &ctx) const {

    auto diff_dst = CTX_IN_MEM(const data_t *, DNNL_ARG_DIFF_DST);
    auto ws = CTX_IN_MEM(const unsigned char *, DNNL_ARG_WORKSPACE);
    auto diff_src = CTX_OUT_MEM(data_t *, DNNL_ARG_DIFF_SRC);

    const memory_desc_wrapper diff_dst_d(pd()->diff_dst_md());
    const memory_desc_wrapper diff_src_d(pd()->diff_src_md());
    const memory_desc_wrapper ws_d(pd()->workspace_md());

    const memory_desc_wrapper_opt diff_src_d_opt(diff_src_d.md_);
    const memory_desc_wrapper_opt diff_dst_d_opt(diff_dst_d.md_);
    memory_desc_wrapper_opt *ws_d_opt{nullptr};

    const auto alg = pd()->desc()->alg_kind;

    if (ws) {
        //mdw_prt("yes ws:", ws_d);
        assert(alg == alg_kind::pooling_max);
        assert( ws_d.format_kind() == format_kind::blocked );
        // avoid init and setup cost if possible
        ws_d_opt = new memory_desc_wrapper_opt(ws_d.md_);
    }else{
        //mdw_prt("no ws:", ws_d);
    }

    const int ID = pd()->ID();
    const int IH = pd()->IH();
    const int IW = pd()->IW();
    const int KD = pd()->KD();
    const int KH = pd()->KH();
    const int KW = pd()->KW();
    const int SD = pd()->KSD();
    const int SH = pd()->KSH();
    const int SW = pd()->KSW();
    const int padF = pd()->padFront();
    const int padT = pd()->padT();
    const int padL = pd()->padL();

    auto ker_zero = [=](int mb, int oc) {
        for_(int id = 0; id < ID; ++id)
        for_(int ih = 0; ih < IH; ++ih)
        for (int iw = 0; iw < IW; ++iw) {
            const auto off = get_offset(diff_src_d, mb, oc, id, ih, iw);
            diff_src[off] = data_type_t(0);
        }
    };

    auto ker_max
            = [=](const data_t *d, int mb, int oc, int od, int oh, int ow) {
                  const auto ws_off = get_offset(ws_d, mb, oc, od, oh, ow);
                  const int index = ws_d.data_type() == data_type::u8
                          ? (int)ws[ws_off]
                          : ((int *)ws)[ws_off];
                  const int kd = (index / KW) / KH;
                  const int kh = (index / KW) % KH;
                  const int kw = index % KW;
                  const int id = od * SD - padF + kd;
                  const int ih = oh * SH - padT + kh;
                  const int iw = ow * SW - padL + kw;

                  // If padding area could fit the kernel,
                  // then input displacement would be out of bounds.
                  // No need to back propagate there as padding is
                  // virtual in pooling_max case.
                  if (id < 0 || id >= ID) return;
                  if (ih < 0 || ih >= IH) return;
                  if (iw < 0 || iw >= IW) return;

                  const auto off = get_offset(diff_src_d, mb, oc, id, ih, iw);
                  diff_src[off] += d[0];
              };

    auto ker_avg = [=](const data_t *d, int mb, int oc, int od, int oh,
                           int ow) {
        auto id_start = max(od * SD - padF, 0);
        auto ih_start = max(oh * SH - padT, 0);
        auto iw_start = max(ow * SW - padL, 0);
        auto id_end = min(od * SD - padF + KD, ID);
        auto ih_end = min(oh * SH - padT + KH, IH);
        auto iw_end = min(ow * SW - padL + KW, IW);

        auto num_summands = (alg == alg_kind::pooling_avg_include_padding)
                ? KW * KH * KD
                : (id_end - id_start) * (ih_end - ih_start)
                        * (iw_end - iw_start);

        for_(int id = id_start; id < id_end; ++id)
        for_(int ih = ih_start; ih < ih_end; ++ih)
        for (int iw = iw_start; iw < iw_end; ++iw) {
            const auto off = get_offset(diff_src_d, mb, oc, id, ih, iw);
            diff_src[off] += d[0] / num_summands;
        }
    };

    const int MB = pd()->MB();
    const int OC = pd()->C();
    const int OD = pd()->OD();
    const int OH = pd()->OH();
    const int OW = pd()->OW();

    int ow_start = max(0, utils::div_up(padL - KW + 1, SW));
    int ow_end = min(OW, 1 + (padL + IW - 1) / SW);

    int oh_start = max(0, utils::div_up(padT - KH + 1, SH));
    int oh_end = min(OH, 1 + (padT + IH - 1) / SH);

    int od_start = max(0, utils::div_up(padF - KD + 1, SD));
    int od_end = min(OD, 1 + (padF + ID - 1) / SD);

    typedef CoordsForNd<6,uint64_t,uint64_t> Coords;

    if (alg == alg_kind::pooling_max) {
        parallel_nd(MB, OC, [&](int mb, int oc) {
            ker_zero(mb, oc);
            for_(int od = od_start; od < od_end; ++od)
            for_(int oh = oh_start; oh < oh_end; ++oh)
            for (int ow = ow_start; ow < ow_end; ++ow) {
                const data_t *d
                        = &diff_dst[get_offset(diff_dst_d, mb, oc, od, oh, ow)];
                ker_max(d, mb, oc, od, oh, ow);
            }
        });
#define BIMPL 1
#if BIMPL==0
        parallel_nd(MB, OC, [&](int mb, int oc) {
            ker_zero(mb, oc);
            for_(int od = od_start; od < od_end; ++od)
            for_(int oh = oh_start; oh < oh_end; ++oh)
            for (int ow = ow_start; ow < ow_end; ++ow) {
                const data_t *d
                        = &diff_dst[get_offset(diff_dst_d, mb, oc, od, oh, ow)];
                //printf("ker_max(%p,%d,%d,%d,%d,%d)\n",(void*)d,mb,oc,od,oh,ow);
                ker_max(d, mb, oc, od, oh, ow);
            }
        });
#elif BIMPL==1 // small amount of vectorization calls
        //parallel_nd(MB, OC, [&](int mb, int oc) {
        auto nouter = (dim_t)MB * OC;
        auto ninner = (dim_t)(od_end - od_start) * (oh_end - oh_start) * (ow_end - ow_start);
        bool force_sequential = 0; // 1 for debug
        parallel((force_sequential? 1: 0), [&](int ithr, int nthr) {
            auto ddim = diff_dst_d.ndims();
            //assert(diff_src_d.ndims() == ddim);

            Coords icrd;
            icrd.iter_range(0, 0,1, 0,1); // md and oc dimension placeholders
            { // add spatial coords
                int c=2; // next coord whose limits we'll add
                if (ddim >= 5) icrd.iter_range(c++, 0, ID);
                if (ddim >= 4) icrd.iter_range(c++, 0, IH);
                icrd.iter_range(c++, 0, IW);
                icrd.finalize(); // done adding dims, recalculate full size.
            }

            Coords dcrd;
            dcrd.iter_range(0, 0,1, 0,1); // md and oc dimension placeholders
            //assert( dcrd.get_dim() == 2 );
            //printf(" ddim=%d dcrd.get_dim()=%d\n", (int)ddim, (int)dcrd.get_dim());
            { // add spatial coords
                int c=2; // next coord whose limits we'll add
                if (ddim >= 5) dcrd.iter_range(c++, od_start, od_end);
                if (ddim >= 4) dcrd.iter_range(c++, oh_start, oh_end);
                dcrd.iter_range(c++, ow_start, ow_end);
                dcrd.finalize(); // done adding dims, recalculate full size.
            }
            //printf(" ddim=%d dcrd.get_dim()=%d\n", (int)ddim, (int)dcrd.get_dim());
            // Note: vl still zero, and vp[][] unset, until init_nd(start[,end])
            //std::cout<<dcrd.lim_str()<<"  "<<dcrd.coord_str()<<std::endl;
            ///std::cout.flush();
            //assert( ddim == dcrd.get_dim() );
            //assert( ninner == dcrd.get_sz() );

            dim_t ostart, oend;
            balance211(nouter, nthr, ithr, ostart, oend);
            for(size_t oo=ostart; oo<oend; ++oo){ // outer coords
                int const mb = oo / OC;
                int const oc = oo % OC;

#if 0
                ker_zero(mb, oc);
#else
                // if dense, much faster (don't care about internal order) XXX
                icrd.fix_coord(0,mb).fix_coord(1,oc); // sz unchanged
                //icrd.init_nd(0);
                //std::cout<<icrd.lim_str("icrd")<<"  "<<icrd.coord_str("icrd")<<std::endl; std::cout.flush();
                for ( icrd.init_nd(0); icrd; ++icrd) { // inner coords
                    auto const vl = icrd.get_vl();
                    dim_t diff_src_off[MVL];
                    diff_src_d_opt.vec_off_v(icrd.base(), &diff_src_off[0],
                            vl, false/*pad*/);
                    for (int i=0; i<vl; ++i)
                        diff_src[diff_src_off[i]] = data_t{0};
                }
#endif

                // dcrd has mb,oc coords fixed.
                dcrd.fix_coord(0,mb).fix_coord(1,oc); // sz unchanged
                //dcrd.init_nd(0);
                //std::cout<<dcrd.lim_str()<<"  "<<dcrd.coord_str()<<std::endl; std::cout.flush();
                for (dcrd.init_nd(0); dcrd; ++dcrd) { // inner coords
                    int const vl = dcrd.get_vl();
                    dim_t diff_dst_off[MVL];
                    diff_dst_d_opt.vec_off_v(dcrd.base(), &diff_dst_off[0],
                            vl, false/*pad*/);
                    for (int i=0; i<vl; ++i) {
                        int c = 1; // after oc-dim, have spatial coords
                        int const od = ddim >= 5? dcrd.vp[++c][i]: 0;
                        int const oh = ddim >= 4? dcrd.vp[++c][i]: 0;
                        int const ow = dcrd.vp[++c][i];
                        const data_t * d = &diff_dst[diff_dst_off[i]];
                        //printf("i=%d ker_max(%p,%d,%d,%d,%d,%d)\n",i,(void*)d,mb,oc,od,oh,ow);
                        //assert( dcrd.vp[0][i] == mb );
                        //assert( dcrd.vp[1][i] == oc );
                        //assert( diff_dst_off[i] == get_offset(diff_dst_d,mb,oc,od,oh,ow) );
                        ker_max(d, mb, oc, od, oh, ow);
                    }
                }
            }
        });
#else
#error "BIMPL unknown"
#endif
    } else {
        parallel_nd(MB, OC, [&](int mb, int oc) {
            ker_zero(mb, oc);
            for_(int od = od_start; od < od_end; ++od)
            for_(int oh = oh_start; oh < oh_end; ++oh)
            for (int ow = ow_start; ow < ow_end; ++ow) {
                const data_t *d
                        = &diff_dst[get_offset(diff_dst_d, mb, oc, od, oh, ow)];
                ker_avg(d, mb, oc, od, oh, ow);
            }
        });
    }
}

template struct ref_pooling_fwd_t<data_type::f32>;
template struct ref_pooling_fwd_t<data_type::s32>;
template struct ref_pooling_fwd_t<data_type::bf16, data_type::f32>;
template struct ref_pooling_fwd_t<data_type::s8, data_type::s32>;
template struct ref_pooling_fwd_t<data_type::u8, data_type::s32>;

template struct ref_pooling_bwd_t<data_type::f32>;
template struct ref_pooling_bwd_t<data_type::s32>;
template struct ref_pooling_bwd_t<data_type::bf16>;
} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
