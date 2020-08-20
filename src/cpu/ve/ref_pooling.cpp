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
//#include <iostream>

//// TODO common code : 3 times inner pooling window vector precalc and iterator init

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

    const int MB = pd()->MB();
    const int OC = pd()->C();
    const int OD = pd()->OD();
    const int OH = pd()->OH();
    const int OW = pd()->OW();
    if (1 || v) {
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

    if (alg == alg_kind::pooling_max) {
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

                // input tensors with zero dimension get no special treatment
                // - the kernel overlap with input has zero effective elements
                // - output is then '...<data_t>::lowest()'
                //   - with any workspace filled with zeroes.
                // - i.e. no "broadcasting" semantics
                //   - does NOT do "avg/max over *existing* input coords"
                //
                if (zero_dim_src) {
                    //if(v) std::cout<<" zero_dim_src "<<dcrd.lim_str("dcrd")<<"  "<<dcrd.coord_str("dcrd")<<std::endl;
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
                int const* const mb_ptr = reinterpret_cast<int const*>
                        (&dcrd.vp[0][0]); 
                int const* const o_spatial0 = reinterpret_cast<int const*>
                        (&dcrd.vp[2][0]);
                int const* const s_spatial0 = reinterpret_cast<int const*>
                        (&scrd.vp[2][0]); 

                data_t dst_reg[MVL]; VREG(dst_reg); // oh, we write this as mem :(
                int kk_dhw[3*MVL]; // if (ws), max-coord memory (vector kpos post-calc)

                // vector precalc constants (vector calc --> mem)
                int sz[MVL]; // sz < kern ovlp <= KD*KH*KW (small)
                int dhw[9*MVL]; // nc++ slightly prefers single array over 9
#define DHW_W 0
#define DHW_H 1
#define DHW_D 2
                // which = 0,1,2 for w, h, d respectively
                // following COULD be done reasonably, but nc++ precalculates
                // most pointers, using mem load instead "lea" calc (could use single reg).
                // so still fair amount of register spill,restore and mem loads
#define DHW_SHIFT(which,idx)    dhw[((which*3  )*MVL)+idx]
#define DHW_ST(which,idx)       dhw[((which*3+1)*MVL)+idx]
//#define DHW_ST(which,idx)       ((int32_t*)&dhw[((which*3+1)*MVL)])[idx]
#define DHW_EN(which,idx)       dhw[((which*3+2)*MVL)+idx]
#define DEFINE_IN_RANGE_VEC(idx, which, ksz, isz) \
                    DHW_ST(which,idx) = (DHW_SHIFT(which,idx)       >   0 \
                            ? DHW_SHIFT(which,idx): 0); \
                    DHW_EN(which,idx) = (DHW_SHIFT(which,idx) + ksz < isz \
                            ? DHW_SHIFT(which,idx) + ksz: isz); \
                    if (DHW_EN(which,idx) < DHW_ST(which,idx)) \
                            DHW_EN(which,idx) = DHW_ST(which,idx)

                // actually, kernel size fits in int32_t
                ShortLoop() for(int i=0; i<dvl; ++i)
                        sz[i] = 1;
                int const* o_spatial = o_spatial0;
                {
                    if (dm >= 5) {
                        int s[MVL], e[MVL], sh[MVL]; VREG(s); VREG(e); VREG(sh);
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            // Why is nc++ doing masking and merging instead of vector max?
                            // I'd like to use the VCMS op for int32 max/min !
                            //
                            // There seem to be a LOT of scalar indexing calcs.
                            //assert( o_spatial[i] == dcrd.vp[dm-3][i] );
                            DHW_SHIFT(DHW_D,i) = o_spatial[i]/*od*/ * SD - padF;
                            // NB: scrd loops over source coords, id,ih,iw, NOT kd,kh,kw
                            //id = od * SD - padF + kd ~ id0 + kd   (or kd = id - id0), etc.
                            DEFINE_IN_RANGE_VEC(i, DHW_D, KD, ID);
                            sz[i] *= DHW_EN(DHW_D,i) - DHW_ST(DHW_D,i);
                        }
                        o_spatial += dcrd.MaxVl;
                    }
                    if (dm >= 4) {
                        //assert( (void*)o_spatial == (void*)&dcrd.vp[dm-2][0] );
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            DHW_SHIFT(DHW_H,i) = o_spatial[i]/*oh*/ * SH - padT;
                            DEFINE_IN_RANGE_VEC(i, DHW_H, KH, IH);
                            sz[i] *= DHW_EN(DHW_H,i) - DHW_ST(DHW_H,i);
                        }
                        o_spatial += dcrd.MaxVl;
                    }
                    ShortLoop() for(int i=0; i<dvl; ++i) {
                        //assert( o_spatial[i] == dcrd.vp[dm-1][i] );
                        DHW_SHIFT(DHW_W,i) = dcrd.vp[dm-1][i]/*ow*/ * SW - padL;
                        DEFINE_IN_RANGE_VEC(i, DHW_W, KW, IW);
                        sz[i] *= DHW_EN(DHW_W,i) - DHW_ST(DHW_W,i);
                    }
                }

                // linear write pattern for remembering kk_dhw[] a bit faster
                auto pkk_dhw = &kk_dhw[0];

                NOVEC ShortLoop() for (int i=0U; i<dvl; ++i) {
                    // set up kernel-window vector iterator into src coords
                    { // "raw" CoordsForNd api faster
                        // mem-to-mem copy of uint32_t <-- int does useless sll 32, srl 32 to
                        // USELESSLY add 2 ops.   (Expect just "load" + "store", 2 ops).
                        // nc++ optimization is to keep same-signedness:
                        //auto rlo = scrd.raw_lo(); // pointer
                        //auto rhi = scrd.raw_hi();
                        //  code looks better for nc++ with ...
                        int32_t* restrict rlo = (int32_t*)scrd.raw_lo(); // pointer
                        int32_t* restrict rhi = (int32_t*)scrd.raw_hi();
                        rlo[0] = mb_ptr[i];
                        rhi[0] = mb_ptr[i]+1;
                        rlo[1] = mb_ptr[(int)dcrd.MaxVl+i];  // also oc
                        rhi[1] = mb_ptr[(int)dcrd.MaxVl+i] + 1;
                        if (dm >= 5) {
                            // VE loads int with .sx into high bits, then uselessly
                            // sll,srr by 32 to clear the bits, then stores the lower 32 bits.
                            // same-signed for mem-to-mem int/uint32_t SKIPS the compiler shifting nonsense.
                            //          4 scalar ops to 2 ops ~ "ldl.sx...; stl..."
                            rlo[2] = DHW_ST(DHW_D,i);  // id
                            rhi[2] = DHW_EN(DHW_D,i);
                            rlo[3] = DHW_ST(DHW_H,i);  // ih
                            rhi[3] = DHW_EN(DHW_H,i);
                            rlo[4] = DHW_ST(DHW_W,i);  // iw
                            rhi[4] = DHW_EN(DHW_W,i);
                        } else if (dm >= 4) {
                            rlo[2] = DHW_ST(DHW_H,i);  // ih
                            rhi[2] = DHW_EN(DHW_H,i);
                            rlo[3] = DHW_ST(DHW_W,i);  // iw
                            rhi[3] = DHW_EN(DHW_W,i);
                        } else { // dm == 3
                            rlo[2] = DHW_ST(DHW_W,i);  // iw
                            rhi[2] = DHW_EN(DHW_W,i); 
                        }
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
                        ShortLoop() for(int j=0U; j<svl; ++j) {
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
                        }
                    }// iter over krn window for max

                    // vec scatter later seems very slightly faster on VE
                    dst_reg[i] = srcmax;

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
                ShortLoop() for(int i=0; i<dvl; ++i) { // post-loop vec-scatter op
                    dst[dstp[i]] = dst_reg[i];
                }
                if (ws) {
                    // VE prefers conditionals moved out, for vectorization
                    // each dvl<MVL "loop" is one or more simple vector ops
                    //
                    int kkpos[MVL]; VREG(kkpos);
                    ShortLoop() for(int i=0; i<dvl; ++i) {
                        kkpos[i] = 0; // default "no max" value for ws
                        // NOTE: benefit for bkwd if use a flag (-1) instead
                        // also, VE would really like ws data to be
                        // always int and never u8.
                    }

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
                            ShortLoop() for(int i=0; i<dvl; ++i) {
                                int d = kk_dhw[3*i];
                                if (d >= 0) {
                                    int h = kk_dhw[3*i+1];
                                    int w = kk_dhw[3*i+2];
                                    kkpos[i] = ((d - DHW_SHIFT(DHW_D,i)) * KH
                                            + (h - DHW_SHIFT(DHW_H,i))) * KW
                                            + (w - DHW_SHIFT(DHW_W,i));
                                }
                            }
                        }else if (dm >= 4) {
                            ShortLoop() for(int i=0; i<dvl; ++i) {
                                // Note: if align 8, single-load uint64_t and shift XXX
                                int h = kk_dhw[2*i];
                                if (h >= 0) {
                                    int w = kk_dhw[2*i+1];
                                    kkpos[i] = (h - DHW_SHIFT(DHW_H,i)) * KW
                                            + (w - DHW_SHIFT(DHW_W,i));
                                }
                            }
                        }else{
                            ShortLoop() for(int i=0; i<dvl; ++i) {
                                int w = kk_dhw[i];
                                if (w >= 0) {
                                    kkpos[i] = w - DHW_SHIFT(DHW_W,i);
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
    } else {
        auto elems = (size_t)MB * OC * OD * OH * OW;
        bool force_sequential = 0; // 1 for debug
        parallel((force_sequential? 1: 0), [&](int ithr, int nthr) {
            size_t start, end;
            balance211(elems, nthr, ithr, start, end);

            // let's use 32-bit Crd (Pos can still be u64)
            // oh. Pos u64 stilll required by memory_desc_wrapper_opt
            typedef CoordsForNd<6,uint32_t,int64_t> Coords32;
            auto const dm = dst_d.ndims();
            Coords32 dcrd(dst_d.dims(), dm, start, end);
            Coords32 scrd;
            // fast-path a limit case.
            bool zero_dim_src = (ID * IH * IW <= 0);

            for( ; dcrd; ++dcrd ) { // in vec-length chunks of dst coordinates
                int const dvl = dcrd.get_vl();
                dim_t dstp[MVL]; //destination physical offsets
                dst_d_opt.vec_off_v(dcrd.base(), &dstp[0], dvl, false/*pad*/);

                //
                // input tensors with zero dimension get no special treatment
                // - the kernel overlap with input has zero effective elements
                // - output is then '...<data_t>::lowest()'
                //   - with any workspace filled with zeroes.
                // - i.e. no "broadcasting" semantics
                //   - does NOT do "avg/max over *existing* input coords"
                //
                if (zero_dim_src) {
                    data_t const zero = out_round<data_t>( 0.0f );
                    //if(v) std::cout<<" zero_dim_src "<<dcrd.lim_str("dcrd")<<"  "<<dcrd.coord_str("dcrd")<<std::endl;
                    ShortLoop() for(int i=0U; i<dvl; ++i) {
                        dst[dstp[i]] = zero;
                    }
                    continue;
                }
                static_assert( sizeof(dcrd.vp[dm-1][0]) == sizeof(int),
                        "require VecPos32");
                int const* const mb_ptr = reinterpret_cast<int const*>
                        (&dcrd.vp[0][0]); 
                int const* const o_spatial0 = reinterpret_cast<int const*>
                        (&dcrd.vp[2][0]);

                // pooling-window vector precalc constants (--> mem)
                int sz[MVL]; // sz < kern ovlp <= KD*KH*KW (small)
                int dhw[9*MVL]; // jit might use 9 vector regs
                float inv_num_summands[MVL];

                // pool-window constants, vectorized precalculations
                ShortLoop() for(int i=0; i<dvl; ++i)
                        sz[i] = 1;
                int const* o_spatial = o_spatial0;
                {
                    if (dm >= 5) {
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            //assert( o_spatial[i] == dcrd.vp[dm-3][i] );
                            DHW_SHIFT(DHW_D,i) = o_spatial[i]/*od*/ * SD - padF;
                            // NB: scrd loops over source coords, id,ih,iw, NOT kd,kh,kw
                            //id = od * SD - padF + kd ~ id0 + kd   (or kd = id - id0), etc.
                            DEFINE_IN_RANGE_VEC(i, DHW_D, KD, ID);
                            sz[i] *= DHW_EN(DHW_D,i) - DHW_ST(DHW_D,i);
                        }
                        o_spatial += dcrd.MaxVl;
                    }
                    if (dm >= 4) {
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            //assert( o_spatial[i] == dcrd.vp[dm-2][i] );
                            DHW_SHIFT(DHW_H,i) = o_spatial[i]/*oh*/ * SH - padT;
                            DEFINE_IN_RANGE_VEC(i, DHW_H, KH, IH);
                            sz[i] *= DHW_EN(DHW_H,i) - DHW_ST(DHW_H,i);
                        }
                        o_spatial += dcrd.MaxVl;
                    }
                    ShortLoop() for(int i=0; i<dvl; ++i) {
                        //assert( o_spatial[i] == dcrd.vp[dm-1][i] );
                        DHW_SHIFT(DHW_W,i) = dcrd.vp[dm-1][i]/*ow*/ * SW - padL;
                        DEFINE_IN_RANGE_VEC(i, DHW_W, KW, IW);
                        sz[i] *= DHW_EN(DHW_W,i) - DHW_ST(DHW_W,i);
                    }
                }
                if (alg == alg_kind::pooling_avg_include_padding) {
                    ShortLoop() for (int i=0; i<dvl; ++i)
                            inv_num_summands[i] = 1.0f / (KW * KH * KD);
                } else {
                    ShortLoop() for (int i=0; i<dvl; ++i)
                            inv_num_summands[i] = 1.0f / sz[i];
                }

                acc_data_t sum[MVL]; VREG(sum); // accumulate over pooling window
                ShortLoop() for (int i=0; i<dvl; ++i)
                        sum[i] = acc_data_t{0};

                NOVEC for (int i=0U; i<dvl; ++i) {

                    // set up kernel-window vector iterator into src coords
                    // and related constants.
                    { // "raw" CoordsForNd api
                        // decent nc++ scalar code (at expense of readability)
                        int32_t* restrict rlo = (int32_t*)scrd.raw_lo(); // pointer
                        int32_t* restrict rhi = (int32_t*)scrd.raw_hi();
                        rlo[0] = mb_ptr[i];
                        rhi[0] = mb_ptr[i]+1;
                        rlo[1] = mb_ptr[(int)dcrd.MaxVl+i];  // also oc
                        rhi[1] = mb_ptr[(int)dcrd.MaxVl+i] + 1;
                        if (dm >= 5) {
                            rlo[2] = DHW_ST(DHW_D,i);  // id
                            rhi[2] = DHW_EN(DHW_D,i);
                            rlo[3] = DHW_ST(DHW_H,i);  // ih
                            rhi[3] = DHW_EN(DHW_H,i);
                            rlo[4] = DHW_ST(DHW_W,i);  // iw
                            rhi[4] = DHW_EN(DHW_W,i);
                        } else if (dm >= 4) {
                            rlo[2] = DHW_ST(DHW_H,i);  // ih
                            rhi[2] = DHW_EN(DHW_H,i);
                            rlo[3] = DHW_ST(DHW_W,i);  // iw
                            rhi[3] = DHW_EN(DHW_W,i);
                        } else { // dm == 3
                            rlo[2] = DHW_ST(DHW_W,i);  // iw
                            rhi[2] = DHW_EN(DHW_W,i); 
                        }
                        *scrd.raw_sz() = sz[i]; // krn ovlp sz precalc'ed
                        *scrd.raw_dim() = dm;
                        scrd.init_nd(0);
                    }

                    acc_data_t ssum{0};
                    {
                        dim_t srcp[MVL];    // src phys offsets
                        // VE note: ++src is not inlined, creating vector reg spill
                        NOVEC for ( ; scrd; ++scrd) {
                            const unsigned svl=scrd.get_vl(); // svl ~ id,ih,iw coords
                            // calc phy src offsets, (ok to clobber scrd.vp coords)
                            src_d_opt.vec_off_vtmp(scrd.base(), (dim_t *)&srcp[0], svl);

                            ShortLoop() for(int j=0U; j<svl; ++j) { // vec
                                ssum += src[srcp[j]];
                            }
                        }
                    }
                    sum[i] = ssum;

                }

                data_t dst_reg[MVL]; VREG(dst_reg);
                // convert sum to output data_t
                //      hopefully out_round vectorizes
                ShortLoop() for(int i=0; i<dvl; ++i) {
                    dst_reg[i] = out_round<data_t>( (float)sum[i] * inv_num_summands[i] );
                }
                // post-loop vec-scatter
                ShortLoop() for(int i=0; i<dvl; ++i) {
                    dst[dstp[i]] = dst_reg[i];
                }

            } // for dcrd, destination coords
        });
    }
#undef DHW_D
#undef DHW_H
#undef DHW_W
#undef DHW_SHIFT
#undef DHW_ST
#undef DHW_EN
#undef DEFINE_IN_RANGE_VEC
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

    if (alg == alg_kind::pooling_max) {
        typedef CoordsForNd<6,uint64_t,uint64_t> Coords;
        typedef CoordsForNd<6,uint32_t,int64_t> Coords32;
        // src-pixel coords (mb,oc,id,ih,iw when they are valid)
        // do NOT need pooling window coord iterator into diff_src.
        typedef memory_desc_wrapper_opt::VecPos32 VecPos32;
        // a.k.a. CoordRegs<uint32_t, 6>,
        // cast to int32_t* sometimes avoids VE conversion nonsense

        auto nouter = (dim_t)MB * OC;
        auto ninner = (dim_t)(od_end - od_start) * (oh_end - oh_start) * (ow_end - ow_start);
        bool force_sequential = 0; // 1 for debug
        parallel((force_sequential? 1: 0), [&](int ithr, int nthr) {
            auto dm = diff_dst_d.ndims();
            //assert(diff_src_d.ndims() == dm);

            dim_t ostart, oend;
            balance211(nouter, nthr, ithr, ostart, oend);

            // ker_zero iterator alloc & init
            Coords icrd;
            icrd.iter_range(0, 0,1, 0,1); // mb and oc dimension placeholders
            { // add spatial coords
                int c=2; // next coord whose limits we'll add
                if (dm >= 5) icrd.iter_range(c++, 0, ID);
                if (dm >= 4) icrd.iter_range(c++, 0, IH);
                icrd.iter_range(c++, 0, IW);
                icrd.finalize(); // done adding dims, recalculate full size.
            }

            // re-use icrd mem for pooling inner iterator

            // ker_max outer iterator alloc & init
            Coords32 dcrd;
            static_assert( sizeof(dcrd.vp[0][0]) == sizeof(int),
                    "require VecPos32");
            dcrd.iter_range(0, 0,1, 0,1); // md and oc dimension placeholders
            //assert( dcrd.get_dim() == 2 );
            //printf(" dm=%d dcrd.get_dim()=%d\n", (int)dm, (int)dcrd.get_dim());
            { // add spatial coords
                int c=2; // next coord whose limits we'll add
                if (dm >= 5) dcrd.iter_range(c++, od_start, od_end);
                if (dm >= 4) dcrd.iter_range(c++, oh_start, oh_end);
                dcrd.iter_range(c++, ow_start, ow_end);
                dcrd.finalize(); // done adding dims, recalculate full size.
            }

            VecPos32 src_vp; 
            // Vector calc src pixel offsets from src_vp
            dim_t diff_src_off[MVL];    // phys offsets

            for(size_t oo=ostart; oo<oend; ++oo){ // outer coords

                int const mb = oo / OC;
                int const oc = oo % OC;

                // ker_zero : zero diff_src output
                {
                    // if dense, could be much faster (don't care about internal order) XXX
                    icrd.fix_coord(0,mb).fix_coord(1,oc); // sz unchanged
                    //icrd.init_nd(0);
                    //std::cout<<icrd.lim_str("icrd")<<"  "<<icrd.coord_str("icrd")<<std::endl; std::cout.flush();
                    data_t const zero = data_t{0};
                    for ( icrd.init_nd(0); icrd; ++icrd) { // inner coords
                        auto const vl = icrd.get_vl();
                        dim_t diff_src_off[MVL];
                        diff_src_d_opt.vec_off_v(icrd.base(), &diff_src_off[0],
                                vl, false/*pad*/);
                        ShortLoop() for (int i=0; i<vl; ++i)
                            diff_src[diff_src_off[i]] = zero;
                    }
                }

                // dcrd has mb,oc coords fixed; spatial ranges unchanged
                dcrd.fix_coord(0,mb).fix_coord(1,oc); // sz unchanged
                //dcrd.init_nd(0);
                //std::cout<<dcrd.lim_str()<<"  "<<dcrd.coord_str()<<std::endl; std::cout.flush();
                for (dcrd.init_nd(0); dcrd; ++dcrd) { // outer diff_dst loop
                    int const dvl = dcrd.get_vl();

                    // vectorized diff_dst physical offsets
                    dim_t diff_dst_off[MVL];
                    diff_dst_d_opt.vec_off_v(dcrd.base(), &diff_dst_off[0],
                            dvl, false/*pad*/);

                    int const* const d_mb_ptr = reinterpret_cast<int const*>
                            (&dcrd.vp[0][0]); 
                    int const* const __restrict__ d_spatial0 = reinterpret_cast<int const*>
                            (&dcrd.vp[2][0]);

                    //assert( ws_d_opt );
                    int index[MVL];
                    // convert ws(mb,oc,od,oh,ow) data --> kd x kh x kw index
                    {
                        // ws position-of-max lookup.
                        //      offsets via mb,oc,od,oh,ow dcrd.vp[][i]
                        dim_t ws_off[MVL];
                        ws_d_opt->vec_off_v(dcrd.base(), &ws_off[0],
                                dvl, false/*pad*/);
                        // if use off_vtmp --> dcrd.vp[][] might be clobbered

                        if (ws_d.data_type() == data_type::u8) {
                            ShortLoop() for (int i=0; i<dvl; ++i) { // VE scalar loop
                                index[i] =(int)ws[ws_off[i]];
                            }
                        }else{
                            ShortLoop() for (int i=0; i<dvl; ++i) { // VE vec gather
                                index[i] = ((int *)ws)[ws_off[i]];
                            }
                        }
                    }

                    // convert ws_off into kd,kh,kw, then id,ih,iw
                    // pre-image coords.  If in-range, then coadd
                    // diff_dst into diff_src
                    // Q: could forward ws[] output not hold a flag value for "no max data" ?
                    //    Example ws[...]==-1 means "do not modify diff_src"
                    //
                    // For single-pixel pre-image, VecPos + mask suffices.
                    //     (no pooling window iterator)
                    //bool s_ok[MVL];     // in principle, src ok ~ mask register
                    int s_ok[MVL];     // in principle, src ok ~ mask register


#define SRC_VP(DIM,I) src_vp.vp[DIM][I]
                    // Q: is this better for nc++? No - "unknown dependency" fails to vectorize
//#define SRC_VP(DIM,I) ((int* restrict)(void*)src_vp.vp)[(DIM*src_vp.MaxVl) + (I)]
//#define SRC_VP(DIM,I) reinterpret_cast<int* restrict>(src_vp.vp)[(DIM*src_vp.MaxVl) + (I)]
//#define SRC_VP_RESTRICT(DIM,I) reinterpret_cast<int* restrict>(&src_vp.vp[(DIM*src_vp.MaxVl) + (I)])
//#define SRC_VP(DIM,I) (*SRC_VP_RESTRICT(DIM,I))
                    ShortLoop() for (int i=0; i<dvl; ++i) {
                        SRC_VP(0,i) = mb;
                        SRC_VP(1,i) = oc;
                    }
                    if (dm>=5) {
                        ShortLoop() IVDEP() for (int i=0; i<dvl; ++i) {
                            const int kd = (index[i] / KW) / KH;
                            const int kh = (index[i] / KW) % KH;
                            const int kw = index[i] % KW;
                            const int od = d_spatial0[0*dcrd.MaxVl + i];
                            const int oh = d_spatial0[1*dcrd.MaxVl + i];
                            const int ow = d_spatial0[2*dcrd.MaxVl + i];
                            const int id = od * SD - padF + kd;
                            const int ih = oh * SH - padT + kh;
                            const int iw = ow * SW - padL + kw;
                            SRC_VP(2,i) = id;
                            SRC_VP(3,i) = ih;
                            SRC_VP(4,i) = iw;
                            // DOES set up mask, but high mask reg usage
#if 0
                            s_ok[i] = (id >= 0 && id < ID
                                    && ih >= 0 && ih < IH
                                    && iw >= 0 && iw < IW);
#elif 0
                            s_ok[i] = (id|ih|iw) >= 0
                                    && id < ID && ih < IH && iw < IW;
#else
                            s_ok[i] = (id | ih | iw 
                                    | (ID-id-1) | (IH-ih-1) | (IW-iw-1)
                                    ) >= 0;
#endif
                        }
                    } else if (dm>=4) {
                        ShortLoop() for (int i=0; i<dvl; ++i) {
                            const int kh = index[i] / KW;
                            const int kw = index[i] % KW;
                            const int oh = d_spatial0[0*dcrd.MaxVl + i];
                            const int ow = d_spatial0[1*dcrd.MaxVl + i];
                            const int ih = oh * SH - padT + kh;
                            const int iw = ow * SW - padL + kw;
                            SRC_VP(2,i) = ih;
                            SRC_VP(3,i) = iw;
#if 0
                            s_ok[i] = (ih >= 0 && ih < IH
                                    && iw >= 0 && iw < IW);
#else
                            s_ok[i] = (ih | iw | (IH-ih-1) | (IW-iw-1)) >= 0;
#endif
                        }
                    } else {
                        //assert( dm == 3 );
                        ShortLoop() for (int i=0; i<dvl; ++i) {
                            const int kw = index[i];
                            const int ow = d_spatial0[0*dcrd.MaxVl + i];
                            const int iw = ow * SW - padL + kw;
                            SRC_VP(2,i) = iw;
#if 0
                            s_ok[i] = (iw >= 0 && iw < IW);
#else
                            s_ok[i] = (iw | (IW-iw-1)) >= 0;
#endif
                        }
                    }
#undef SRC_VP

                    // when s_ok[i], cooad gradient into pre-image pixel
                    {
                        diff_src_d_opt.vec_off_v(src_vp, &diff_src_off[0],
                                dvl, false/*pad*/);

                        // when s_ok[i], coadd gradient into diff_src pixel
                        ShortLoop() IVDEP() LISTVEC for (int i=0; i<dvl; ++i) {
#if 1
                            if (s_ok[i]) {
                                diff_src[diff_src_off[i]] += diff_dst[diff_dst_off[i]];
                            }
#else // incorrect code from nc++
                            auto const tmp_d = diff_dst[diff_dst_off[i]];
                            auto /* */ tmp_s = diff_src[diff_src_off[i]];
                            if (s_ok[i]) {
                                tmp_s += tmp_d;
                            }
                            diff_src[diff_src_off[i]] = tmp_s;
#endif
                        }
                    }

                }

            }
        });
    } else {
        // Unlike maxpooling, avgpooling iterates over pooling window.
        // So impl is more like fwd, with full "inner iterator"
        //typedef CoordsForNd<6,uint64_t,uint64_t> Coords;
        typedef CoordsForNd<6,uint32_t,int64_t> Coords32;

        //parallel_nd(MB, OC, [&](int mb, int oc)
        auto nouter = (dim_t)MB * OC;
        auto ninner = (dim_t)(od_end - od_start) * (oh_end - oh_start) * (ow_end - ow_start);
        bool force_sequential = 0; // 1 for debug
        parallel((force_sequential? 1: 0), [&](int ithr, int nthr) {
            auto dm = diff_dst_d.ndims();
            //assert(diff_src_d.ndims() == dm);

            Coords32 icrd;
            icrd.iter_range(0, 0,1, 0,1); // md and oc dimension placeholders
            { // add spatial coords
                int c=2; // next coord whose limits we'll add
                if (dm >= 5) icrd.iter_range(c++, 0, ID);
                if (dm >= 4) icrd.iter_range(c++, 0, IH);
                icrd.iter_range(c++, 0, IW);
                icrd.finalize(); // done adding dims, recalculate full size.
            }

            Coords32 dcrd;
            dcrd.iter_range(0, 0,1, 0,1); // md and oc dimension placeholders
            //assert( dcrd.get_dim() == 2 );
            //printf(" dm=%d dcrd.get_dim()=%d\n", (int)dm, (int)dcrd.get_dim());
            { // add spatial coords
                int c=2; // next coord whose limits we'll add
                if (dm >= 5) dcrd.iter_range(c++, od_start, od_end);
                if (dm >= 4) dcrd.iter_range(c++, oh_start, oh_end);
                dcrd.iter_range(c++, ow_start, ow_end);
                dcrd.finalize(); // done adding dims, recalculate full size.
            }
            //printf(" dm=%d dcrd.get_dim()=%d\n", (int)dm, (int)dcrd.get_dim());
            // Note: vl still zero, and vp[][] unset, until init_nd(start[,end])
            //std::cout<<dcrd.lim_str()<<"  "<<dcrd.coord_str()<<std::endl; std::cout.flush();
            //assert( dm == dcrd.get_dim() );
            //assert( ninner == dcrd.get_sz() );

            dim_t ostart, oend;
            balance211(nouter, nthr, ithr, ostart, oend);
            for(size_t oo=ostart; oo<oend; ++oo){ // outer coords
                int const mb = oo / OC;
                int const oc = oo % OC;

                //ker_zero(mb, oc);
                // if dense, could be much faster (don't care about internal order) XXX
                icrd.fix_coord(0,mb).fix_coord(1,oc); // sz unchanged
                //icrd.init_nd(0);
                //std::cout<<icrd.lim_str("icrd")<<"  "<<icrd.coord_str("icrd")<<std::endl; std::cout.flush();
                for ( icrd.init_nd(0); icrd; ++icrd) { // inner coords
                    auto const vl = icrd.get_vl();
                    dim_t diff_src_off[MVL];
                    diff_src_d_opt.vec_off_v(icrd.base(), &diff_src_off[0],
                            vl, false/*pad*/);
                    ShortLoop() for (int i=0; i<vl; ++i)
                        diff_src[diff_src_off[i]] = data_t{0};
                }

                // dcrd has mb,oc coords fixed.
                dcrd.fix_coord(0,mb).fix_coord(1,oc); // sz unchanged
                //dcrd.init_nd(0);
                //std::cout<<dcrd.lim_str()<<"  "<<dcrd.coord_str()<<std::endl; std::cout.flush();
                for (dcrd.init_nd(0); dcrd; ++dcrd) { // inner coords
                    int const dvl = dcrd.get_vl();
                    data_t diff_dst_data[MVL];
                    dim_t diff_dst_off[MVL];
                    {
                        diff_dst_d_opt.vec_off_v(dcrd.base(), &diff_dst_off[0],
                                dvl, false/*pad*/);
                        ShortLoop() for (int i=0; i<dvl; ++i) {
                            diff_dst_data[i] = diff_dst[diff_dst_off[i]];
                        }
                    }

                    // vector precalc of inner pooling-window iterator things
                    static_assert( sizeof(dcrd.vp[0][0]) == 4,
                            "need 4-byte coords in dcrd");
                    int const* const d_mb_ptr = reinterpret_cast<int const*>
                            (&dcrd.vp[0][0]); 
                    int const* const __restrict__ d_spatial0 = reinterpret_cast<int const*>
                            (&dcrd.vp[2][0]);

                    int psz[MVL]; // pooling window sz = kern ovlp <= KD*KH*KW (small)
                    int dhw[9*MVL]; // nc++ slightly prefers single array over 9
#define DHW_W 0
#define DHW_H 1
#define DHW_D 2
                    // which = 0,1,2 for w, h, d respectively
                    // following COULD be done reasonably, but nc++ precalculates
                    // most pointers, using mem load instead "lea" calc (could use single reg).
                    // so still fair amount of register spill,restore and mem loads
#define DHW_SHIFT(which,idx)    dhw[((which*3  )*MVL)+idx]
#define DHW_ST(which,idx)       dhw[((which*3+1)*MVL)+idx]
                    //#define DHW_ST(which,idx)       ((int32_t*)&dhw[((which*3+1)*MVL)])[idx]
#define DHW_EN(which,idx)       dhw[((which*3+2)*MVL)+idx]
#define DEFINE_IN_RANGE_VEC(idx, which, ksz, isz) \
                    DHW_ST(which,idx) = (DHW_SHIFT(which,idx)       >   0 \
                            ? DHW_SHIFT(which,idx): 0); \
                    DHW_EN(which,idx) = (DHW_SHIFT(which,idx) + ksz < isz \
                            ? DHW_SHIFT(which,idx) + ksz: isz); \
                    if (DHW_EN(which,idx) < DHW_ST(which,idx)) \
                            DHW_EN(which,idx) = DHW_ST(which,idx)

                    // actually, kernel size fits in int32_t
                    ShortLoop() for(int i=0; i<dvl; ++i)
                            psz[i] = 1;
                    int const* restrict d_spatial = d_spatial0;
                    {
                        if (dm >= 5) {
                            //assert( (void*)d_spatial == (void*)&dcrd.vp[dm-3][0] );
                            ShortLoop() for(int i=0; i<dvl; ++i) {
                                DHW_SHIFT(DHW_D,i) = d_spatial[i]/*od*/ * SD - padF;
                                DEFINE_IN_RANGE_VEC(i, DHW_D, KD, ID);
                                psz[i] *= DHW_EN(DHW_D,i) - DHW_ST(DHW_D,i);
                            }
                            d_spatial += dcrd.MaxVl;
                        }
                        if (dm >= 4) {
                            //assert( (void*)d_spatial == (void*)&dcrd.vp[dm-2][0] );
                            ShortLoop() for(int i=0; i<dvl; ++i) {
                                DHW_SHIFT(DHW_H,i) = d_spatial[i]/*oh*/ * SH - padT;
                                DEFINE_IN_RANGE_VEC(i, DHW_H, KH, IH);
                                psz[i] *= DHW_EN(DHW_H,i) - DHW_ST(DHW_H,i);
                            }
                            d_spatial += dcrd.MaxVl;
                        }
                        //assert( (void*)d_spatial == (void*)&dcrd.vp[dm-1][0] );
                        ShortLoop() for(int i=0; i<dvl; ++i) {
                            DHW_SHIFT(DHW_W,i) = dcrd.vp[dm-1][i]/*ow*/ * SW - padL;
                            DEFINE_IN_RANGE_VEC(i, DHW_W, KW, IW);
                            psz[i] *= DHW_EN(DHW_W,i) - DHW_ST(DHW_W,i);
                        }
                    }

                    NOVEC ShortLoop() for (int i=0; i<dvl; ++i) {

                        Coords32 scrd; // pooling coords, in src
                        //                      unstrided square/rectangular block
                        { // "raw" CoordsForNd api faster
                            // mem-to-mem copy of uint32_t <-- int does useless sll 32, srl 32 to
                            // USELESSLY add 2 ops.   (Expect just "load" + "store", 2 ops).
                            // nc++ optimization is to keep same-signedness:
                            //auto rlo = scrd.raw_lo(); // pointer
                            //auto rhi = scrd.raw_hi();
                            //  code looks better for nc++ with ...
                            int32_t* restrict rlo = (int32_t*)scrd.raw_lo(); // pointer
                            int32_t* restrict rhi = (int32_t*)scrd.raw_hi();
                            rlo[0] = d_mb_ptr[i];
                            rhi[0] = d_mb_ptr[i]+1;
                            rlo[1] = d_mb_ptr[(int)dcrd.MaxVl+i];  // also oc
                            rhi[1] = d_mb_ptr[(int)dcrd.MaxVl+i] + 1;
                            if (dm >= 5) {
                                // VE loads int with .sx into high bits, then uselessly
                                // sll,srr by 32 to clear the bits, then stores the lower 32 bits.
                                // same-signed for mem-to-mem int/uint32_t SKIPS the compiler shifting nonsense.
                                //          4 scalar ops to 2 ops ~ "ldl.sx...; stl..."
                                rlo[2] = DHW_ST(DHW_D,i);  // id
                                rhi[2] = DHW_EN(DHW_D,i);
                                rlo[3] = DHW_ST(DHW_H,i);  // ih
                                rhi[3] = DHW_EN(DHW_H,i);
                                rlo[4] = DHW_ST(DHW_W,i);  // iw
                                rhi[4] = DHW_EN(DHW_W,i);
                            } else if (dm >= 4) {
                                rlo[2] = DHW_ST(DHW_H,i);  // ih
                                rhi[2] = DHW_EN(DHW_H,i);
                                rlo[3] = DHW_ST(DHW_W,i);  // iw
                                rhi[3] = DHW_EN(DHW_W,i);
                            } else { // dm == 3
                                rlo[2] = DHW_ST(DHW_W,i);  // iw
                                rhi[2] = DHW_EN(DHW_W,i); 
                            }
                            *scrd.raw_sz() = psz[i]; // krn ovlp sz precalc'ed
                            *scrd.raw_dim() = dm;
                            scrd.init_nd(0);
                        }

                        auto num_summands = (alg == alg_kind::pooling_avg_include_padding)
                                ? KW * KH * KD : psz[i];

                        //const data_t * d = &diff_dst[diff_dst_off[i]];
                        const data_t grad = diff_dst_data[i] / num_summands;
                        {
                            dim_t diff_src_off[MVL];    // diff_src phys offsets
                            data_t diff_src_data[MVL]; VREG(diff_src_data)
                            NOVEC for ( ; scrd; ++scrd) {
                                const unsigned svl=scrd.get_vl(); // svl ~ id,ih,iw coords
                                diff_src_d_opt.vec_off_vtmp(scrd.base(), (dim_t *)&diff_src_off[0], svl);
                                //LISTVEC helps a bit, but 2 gathers, 2 scatters??
                                // A: ivdep
                                ShortLoop() LISTVEC IVDEP() for (int j=0U; j<svl; ++j) {
                                    diff_src[diff_src_off[j]] += grad;
                                }
                            }
                        }
                    }// i in [0,dvl)
                }// dcrd
            }// [oostart,ooend) outer loop
        });
    } // avg pooling
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
