/*******************************************************************************
* Copyright 2016-2020 Intel Corporation, 2020 NEC Labs America
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

#ifndef COMMON_MEMORY_DESC_WRAPPER_OPT_HPP
#define COMMON_MEMORY_DESC_WRAPPER_OPT_HPP

#include <array>

#include "common/memory_desc_wrapper.hpp"
#include "ve_fastdiv.h"

namespace dnnl {
namespace impl {

/** for VE vectorization [or scalar] */
#define VEC 0
#define FD_OFF_V 1 // actually decent speed
#define FD_OFF_L 0 /* about twice as slow? */
#define VEC_OF_STRUCTS 1 /* zero may vectorize more */

#define MVL 256
#define NOVEC_ _Pragma("_NEC novector")
#define VEC_ _Pragma("_NEC vector")

#if 0
VEC     OFF_V   OFF_L   VOS     time    u64
0       0       0       0       365
0       0       0       1       365 --> 209  *** best
1       0       0       0       380
1       0       0       1       380 --> 366
0       1       0       0       455
0       1       0       1       361 --> 231 (best, but using FASTDIV)
1       1       0       0       376
1       1       0       1       349 --> 350
#endif

#if VEC_OF_STRUCTS
    // scalar version;  vector of structs might be better
    //struct Magic { uint64_t mul, add, shr, div; };
    struct Magic { uint64_t mul; uint32_t add; uint32_t shr; uint32_t div; };
    typedef std::array<Magic, DNNL_MAX_NDIMS> DimsFastDiv;

    /** optimize divisions by inner_block sizes, blk.inner_blks[iblk] */
    static DimsFastDiv init_fastdiv(dims_t const d, int const len){
        DimsFastDiv ret{{0,0,0}};
        for (int i = 0; i < len; ++i){
            assert( (uint32_t)d[i] <= UINT32_MAX );
            struct ve_fastdiv f;
            vednn_fastdiv( &f, d[i] );
            ret[i].mul = f.mul;         // first mul
            ret[i].add = f.add;         // then add
            ret[i].shr = f.shift;       // then shift
            ret[i].div = (uint32_t)d[i]; // to calculate "divide-by-div"
        }
        return ret;
    }

#if 0 // simple, but 3 loads, somewhat ugly asm
    static inline constexpr operator/(uint64_t top, Magic const& m){
        return (top * m.mul + m.add) >> m.shr;
    }
#else
    // use just two loads, *** OK for VE endian-ness ***
    // asm looks nice now
    //
    // Ex. when inlined in ref_softmax.s :
    //        .loc    191 58 0
    //        ld      %s55,0(,%s55)   # *(m$1032).mul
    //# line 59
    //        .loc    191 59 0
    //        ld      %s54,0(,%s54)   # unsigned long
    //# line 187
    //        .loc    191 187 0
    //        ld      %s53,-96(%s62,%fp)      # pos_copy
    //        and     %s52,%s54,(32)0
    //        srl     %s54,%s54,32
    //        or      %s51,0,%s53
    //        mulu.l  %s51,%s55,%s51
    //        addu.l  %s51,%s52,%s51
    //        srl     %s54,%s51,%s54
    //        adds.w.sx       %s54,0,%s54
    //# line 193
    //        .loc    191 193 0
    //        st      %s54,-96(%s62,%fp)      # pos_copy
    //
    /** Fastdiv top and m correspond to uint32_t values.
     * \return \c top/"m" value also is in uint32_t range.
     * Inner calc must be done in uint64_t. */
    static inline constexpr uint64_t operator/(uint64_t top, Magic const& m){
        uint64_t const mul = m.mul;
        uint64_t const xxx = *(uint64_t*)(&m.add);
        //uint64_t add = (uint64_t)(uint32_t)xxx;
        //uint64_t shr = xxx >> 32;
        return (top * mul + (uint64_t)(uint32_t)xxx) >> (xxx>>32);
    }
#endif

    // to unify over VEC_OF_STRUCTS choice:
    // fastdiv, top is a uint32_t scalar, divide by d'th fastdiv info.
#define FDIV(top,fd,d) (top / fd[d]);
#define FDIVISOR(fd,d) (fd[d].div)

#else // not VEC_OF_STRUCTS
    // struct-of-vecs, in case vectorization can help
    struct DimsFastDiv {
        // VE should use uint64_t for all fastdiv ops
        uint64_t mul[DNNL_MAX_NDIMS];
        uint32_t add[DNNL_MAX_NDIMS];
        uint32_t shr[DNNL_MAX_NDIMS];
        uint32_t div[DNNL_MAX_NDIMS];
    };

    /** optimize divisions by inner_block sizes, blk.inner_blks[iblk] */
    static DimsFastDiv init_fastdiv(dims_t const d, int const len){
        DimsFastDiv ret{{0},{0},{0}};
        for (int i = 0; i < len; ++i){
            struct ve_fastdiv f;
            vednn_fastdiv( &f, d[i] );
            ret.mul[i] = f.mul;
            ret.add[i] = f.add;
            ret.shr[i] = f.shift;
            ret.div[i] = f.shift;
        }
        return ret;
    }

    // to unify over VEC_OF_STRUCTS choice:
    // fastdiv, top is a uint32_t scalar, divide by d'th fastdiv info.
#define FDIV(top,fd,d) (((uint64_t)top * fd.mul[d] + fd.add[d]) >> fd.shr[d]);
#define FDIVISOR(fd,d) (fd.div[d])

#endif // VEC_OF_STRUCTS

/** If the purpose of memory_desc_wrapper is to calculate offsets, this
 * optimization tries to speed up calls to `off_l` and `off_v`.
 *
 * On VE, when we have u64 / u32 division, we can replace `operator /` with a
 * faster unsigned multiply-add-shift sequence.
 *
 * - Assumption:
 *   - offset calculations actually can be done with \e unsigned division,
 *     i.e. `dims_t pos` values are >= 0.  I believe all the quantities
 *     for offset calculations are positive.  This is not true in other
 *     contexts (like convolution offsets, which must handle -ve values).
 * - Tradeoffs wrt memory_desc_wrapper:
 *   - Increased construction time \e once
 *   - Faster off_v (off_l) for non-huge tensors \e many times
 *
 * \note Use this object locally, as it redefines non-virtual base functions
 *
 * \note \b VE is \b limiting fastdiv to u32/u32 because we cannot get the
 *       high bits of u64 multiply.  But \b x86 can, and \e should extend
 *       fastdiv for u64/u32 (or u64/u64, if easier)
 *
 * \sa ve_fastdiv.h
 */
struct memory_desc_wrapper_opt : public memory_desc_wrapper {

public:

    /** constructor which takes a reference to a constant underlying C memory
     * descriptor \param md */
    memory_desc_wrapper_opt(const memory_desc_t *md)
            : memory_desc_wrapper(md)
#if FD_OFF_V
              , ib(init_ib(*md))
#endif
#if FD_OFF_L
              , fd_dims(init_dims(*md))
              , fd_padded_dims(init_padded_dims(*md))
#endif
              , dims_small(all_dims_u32(false))
              , padded_dims_small(all_dims_u32(true))
    { set_ib_strides(); }
    memory_desc_wrapper_opt(const memory_desc_t &md)
            : memory_desc_wrapper(md)
#if FD_OFF_V
              , ib(init_ib(md))
#endif
#if FD_OFF_L
              , fd_dims(init_dims(md))
              , fd_padded_dims(init_padded_dims(md))
#endif
              , dims_small(all_dims_u32(false))
              , padded_dims_small(all_dims_u32(true))
    { set_ib_strides(); }


public:

    /* offset section : replace non-virtual base class versions */

    struct VecPos {
        uint64_t vp[DNNL_MAX_NDIMS][MVL]; // XXX could be DNNL_MAX_NDIMS vector registers
    };

    void vec_off_l(dim_t const* const l_offsets, ///< vector of logical offsets [noff]
                   int const noff,               ///< restricted to 0..MVL at a time [remove restriction later]
                   dim_t * p_offsets,            ///< output: physical offsets [noff]
                   bool is_pos_padded = false) const {
        assert( noff > 0 && noff <= MVL );
        assert(is_blocking_desc());
#ifndef NDEBUG
        // negative and out-of-bounds input l_offsets create nonsense outputs
        SHORT_ for(int i=0;i<noff;++i) {
               assert( l_offsets[i] >= 0 );
               //assert( l_offsets[i] < size_or_padded_size );
        }
#endif
        VecPos vp;
#define SHORT_ _Pragma("_NEC vector") _Pragma("_NEC shortloop") _Pragma("_NEC assume")
        uint64_t off[MVL];
        uint64_t rem[MVL];
        uint64_t div[MVL];
        _Pragma("_NEC vreg(off)");
        _Pragma("_NEC vreg(rem)");
        _Pragma("_NEC vreg(div)");
        SHORT_ for(int i=0;i<noff;++i) {
            off[i] = l_offsets[i];
        }

        int const nd = ndims();
        const auto dm  = is_pos_padded ? padded_dims(): dims();
        NOVEC_ for (int d = 0; d < nd; ++d) {
            const int rd = nd - 1 - d;          // reverse
            const dim_t cur_dim = dm[rd];       // dims
            /* switch to faster 32-bit division when possible. */
            SHORT_ for(int l=0; l<noff; ++l) { // l ~ logical offset
                rem[l] = off[l] % cur_dim; /* does the right thing (div,mul,sub) */
                off[l] = off[l] / cur_dim;
                vp.vp[rd][l] = rem[l];
            }
        }
#undef SHORT_
        // now have "dense-layout" coords in vp.
        // correct for inner blocking and back to physical offset.
        // (vector version of "off_v")
        vec_off_v(vp, p_offsets, noff, is_pos_padded);
    }
private:
    /** vector-of-physical-offsets version of \c off_v.
     * Unlike \c off_v, we are \e private and can modify
     * our coords \c vp, to save memory. */
    void vec_off_v( VecPos & vp,         // list of coords (from vec_off_l)
                      dim_t * p_offsets, // output physical offsets
                      int const noff,    // how many offsets in vp and p_offsets
                      bool is_pos_padded = false) const {
        assert(npos <= MVL);
#if 0 // just to see if things compile ...
        for(int p=0; p<noff; ++p){
            p_offsets[p] = 0;
        }
#else
        assert(is_blocking_desc());
#ifndef NDEBUG
        for (int i=0; i<blk.inner_nblks; ++i) {
            for (int j=i+1; j<blk.inner_nblks; ++j) {
                if (blk.inner_idxs[i] == blk.inner_idxs[j])
                    ++nsame;
            }
        }
        assert( nsame == 0 ); // inner_idxs[] MUST be distinct
#endif
        const blocking_desc_t &blk = blocking_desc();

#define Short_ PragmaQuote(_NEC vector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        assert( nd < 6 );
        if (is_pos_padded) {
            NOVEC_ for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp.vp[d][l] += padded_offsets()[d];
               }
            }
        }

        //uint64_t phys_offset = offset0();
        // phys[] : vreg mirror of p_offsets[noff] output, until final vector store
        dim_t phys[MVL];
        _Pragma("_NEC vreg(phys)")
        for(int l=0; l<noff; ++l)
            phys[l] = offset0();

        if (blk.inner_nblks > 0) {
            NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];

                //uint64_t p;
                dim_t p[MVL];
                _Pragma("_NEC vreg(p)")

                //if (pos_copy[d] <= UINT32_MAX) ...
                VEC_ for(int l=0; l<noff; ++l) {
                    //p = pos_copy[d] % (uint64_t)blk.inner_blks[iblk];
                    p[l] = vp.vp[d][l] % (uint64_t)blk.inner_blks[iblk];

                    //pos_copy[d] /= (uint64_t)blk.inner_blks[iblk];
                    // XXX elide (ok if inner_idxs do not repeat)
                    //vp.vp[d][l] /= (uint64_t)blk.inner_blks[iblk];

                    //phys_offset += p * ib_strides[iblk];
                    phys[l] += p[l] * ib_strides[iblk];
                }
            }
        }

        NOVEC_ for (int d = 0; d < nd; ++d) {
            dim_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<noff; ++l) tmp[l] = vp.vp[d][l]; // VLD (nec.?)
            VEC_ for(int l=0; l<noff; ++l) {
                phys[l] += tmp[l] * blk.strides[d];     // VMUL,VADD (extra vcopy)
            }
        }

        for(int l=0; l<noff; ++l)
            p_offsets[l] = phys[l]; // final vector store VST to output
#undef Short_
#endif
    }
public:

#if FD_OFF_V == 0 // close to original
    /** returns physical offset by logical one. logical offset is represented by
     * an array \param pos. if \param is_pos_padded is true \param pos
     * represents the position in already padded area */
    dim_t off_v(const dims_t pos, bool is_pos_padded = false) const {
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();

#if VEC // FD_OFF_V==0 VEC==1
        /* for VE, unrolling seemed more effective than vectorization
         * [for a few softmax tests, low dimensional tensors] */
#define Short_ PragmaQuote(_NEC loop_count(6)) IVDEP() ShortLoop()
        const int nd = ndims();
        uint64_t pos_copy[DNNL_MAX_NDIMS];
        Short_ for (int d = 0; d < ndims(); ++d)
            pos_copy[d] = pos[d] + (is_pos_padded ? 0 : padded_offsets()[d]);

        uint64_t phys_offset = offset0();

        if (blk.inner_nblks > 0) {
            Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                uint64_t p;
                if (pos_copy[d] <= INT32_MAX) {
                    uint32_t const divisor = blk.inner_blks[iblk];
                    p = (uint32_t)pos_copy[d] % divisor;
                    pos_copy[d] = (uint32_t)pos_copy[d] / divisor;
                } else {
                    p = pos_copy[d] % (uint64_t)blk.inner_blks[iblk];
                    pos_copy[d] /= (uint64_t)blk.inner_blks[iblk];
                }
                phys_offset += p * ib_strides[iblk];
            }
        }

        Short_ for (int d = 0; d < ndims(); ++d) {
            const dim_t p = pos_copy[d];
            phys_offset += p * blk.strides[d];
        }
#undef Short_
#else // not VEC; FD_OFF_V==0 VEC==0
//#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        uint64_t pos_copy[DNNL_MAX_NDIMS];
        Short_ for (int d = 0; d < nd; ++d)
            pos_copy[d] = pos[d] + (is_pos_padded ? 0 : padded_offsets()[d]);

        uint64_t phys_offset = offset0();

        if (blk.inner_nblks > 0) {
#if 0 // identical speed
            bool all_small = true;
            Short_ PragmaQuote(_NEC assume) for (int d = 0; d < nd; ++d) {
                if (pos_copy[d] >> 32){
                    all_small = false;
                    break;
                }
            }
            if (all_small) {
                Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                    const int d = blk.inner_idxs[iblk];
                    uint64_t p;
                    p = pos_copy[d] % (uint32_t)blk.inner_blks[iblk];
                    pos_copy[d] = pos_copy[d] / (uint32_t)blk.inner_blks[iblk];
                    phys_offset += p * ib_strides[iblk];
                }
            } else
#endif
            {
                Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                    const int d = blk.inner_idxs[iblk];
                    uint64_t p;
                    //if (pos_copy[d] <= UINT32_MAX)
                    if ((pos_copy[d] & 0xFFffFFff00000000) == 0)
                    {
                        // VE u32 conversion inefficient XXX
                        //   (sll;and;srr --- but we already know it is in range)
                        //   (reinterpret_cast, masking not possible at reg level)
                        //   asm candidate?
                        p = (uint32_t)pos_copy[d] % (uint32_t)blk.inner_blks[iblk];
                        pos_copy[d] = (uint32_t)pos_copy[d] / (uint32_t)blk.inner_blks[iblk];
                    } else {
                        p = pos_copy[d] % (uint64_t)blk.inner_blks[iblk];
                        pos_copy[d] /= (uint64_t)blk.inner_blks[iblk];
                    }
                    phys_offset += p * ib_strides[iblk];
                }
            }
        }

        Short_ for (int d = 0; d < nd; ++d) {
            phys_offset += pos_copy[d] * blk.strides[d];
        }
#undef Short_
#endif // VEC
        return phys_offset;
    }

#else // yes, FD_OFF_V
    /** returns physical offset by logical one. logical offset is represented by
     * an array \param pos. if \param is_pos_padded is true \param pos
     * represents the position in already padded area */
    dim_t off_v(const dims_t pos, bool is_pos_padded = false) const {
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();

#if VEC == 0 // VEC==0 && FD_OFF_V==1
        uint64_t pos_copy[DNNL_MAX_NDIMS];
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
//#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC loop_count(6))
//#define Short_
        const int nd = ndims();
        //bool bigpos = false;
        Short_ for (int d = 0; d < nd; ++d)
            pos_copy[d] = pos[d] + (is_pos_padded ? 0 : padded_offsets()[d]);

        uint64_t phys_offset = offset0();

        if (blk.inner_nblks > 0) {
#if 0
#if 1
            bool bigpos = false;
            Short_ for (int d = 0; d < nd; ++d)
                if (pos_copy[d] > UINT32_MAX) bigpos = true;
#elif 1 // from vectorize part.
            bool bigpos = false;
            Short_ PragmaQuote(_NEC assume) for (int d = 0; d < nd; ++d) {
                if (pos_copy[d] >> 32){
                    bigpos = true;
                    break;
                }
            }
#endif
            if (!bigpos)
            { // all pos <= UINT32_MAX
                /* pos_copy[] all small, so do a u32 / u32 fast division. */
                Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                    const int d = blk.inner_idxs[iblk];
                    uint64_t p; // ends up as remainder
                    /* Compute d = pos_copy[d] / blk.inner_blks[iblk] as mul-add-shift */
                    auto const div = FDIV(pos_copy[d], ib, iblk);
                    p = pos_copy[d] - (uint32_t)div * FDIVISOR(ib,iblk); // remainder
                    pos_copy[d] = div;
                    phys_offset += p * ib_strides[iblk];
                }
            } else
#endif
            {
                Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                    const int d = blk.inner_idxs[iblk];
                    uint64_t p;
                    if (pos_copy[d] <= UINT32_MAX) {
                        // fastdiv by blk.inner_blks[iblk]
                        auto const div = FDIV(pos_copy[d], ib, iblk);
                        p = pos_copy[d] - (uint32_t)div * FDIVISOR(ib,iblk); // remainder
                        pos_copy[d] = div;
                    } else {
                        p = pos_copy[d] % (uint64_t)blk.inner_blks[iblk];
                        pos_copy[d] /= (uint64_t)blk.inner_blks[iblk];
                    }
                    phys_offset += p * ib_strides[iblk];
                }
            }
        }

        Short_ for (int d = 0; d < nd; ++d) {
            const uint64_t p = pos_copy[d];
            phys_offset += p * blk.strides[d];
        }
#undef Short_

#else // VEC-torized version VEC==1 && FD_OFF_V==1

        // assume all blk.inner_idxs[] are different
        // This vectorization is decent, sm.in --> 370 ms, cf. non-vector 330 ms
#define Short_ PragmaQuote(_NEC loop_count(6)) IVDEP() ShortLoop()
        uint64_t pos_copy[DNNL_MAX_NDIMS];
        VREG(pos_copy)//;
        const int nd = ndims();
        //Short_ for (int d = 0; d < nd; ++d)
        //    pos_copy[d] = pos[d] + (is_pos_padded ? 0 : padded_offsets()[d]);
        Short_ for (int d = 0; d < nd; ++d)
            pos_copy[d] = pos[d];
        if (is_pos_padded)
            Short_ for (int d = 0; d < nd; ++d)
                pos_copy[d] += padded_offsets()[d];

        uint64_t phys_offset = offset0();

        int const ibs = blk.inner_nblks;
        if (ibs > 0) {
            bool all_small = true;
            Short_ PragmaQuote(_NEC assume) for (int d = 0; d < nd; ++d) {
                if (pos_copy[d] >> 32){
                    all_small = false;
                    break;
                }
            }

            uint64_t pcrem[DNNL_MAX_NDIMS]; VREG(pcrem); // pos_copy modulo inner block size
            if (all_small) {
                Short_ for (int iblk = 0; iblk < ibs; ++iblk) {
                    const int d = blk.inner_idxs[iblk];
                    auto const div = FDIV(pos_copy[d], ib, iblk); // u64 division result
                    pcrem[iblk] = (uint64_t)(pos_copy[d] - (uint32_t)div * FDIVISOR(ib,iblk)); // remainder
                    pos_copy[d] = div;
                }
            }else{
                Short_ for (int iblk = 0; iblk < ibs; ++iblk) {
                    const int d = blk.inner_idxs[iblk];
                    pcrem[iblk] = pos_copy[d] % (uint64_t)blk.inner_blks[iblk];
                    pos_copy[d] /= (uint64_t)blk.inner_blks[iblk];
                }
            }
            // ib_strides[] have been precalculated
            uint64_t sum = 0;
            Short_ for (int iblk = 0; iblk < ibs; ++iblk)
                    sum += pcrem[iblk] * ib_strides[iblk];
            phys_offset += sum;
        }

        Short_ for (int d = 0; d < nd; ++d) {
            phys_offset += pos_copy[d] * blk.strides[d];
        }
#undef Short_
#endif
        return phys_offset;
    }
#endif // FD_OFF_V

#if 1 // FD_OFF_L
    bool all_dims_u32(bool const is_pos_padded = false) {
        bool all_u32 = true;
        const auto dm = is_pos_padded ? padded_dims(): dims();
        for (int d = 0; d < ndims(); ++d)
            if( (uint64_t)dm[d] > UINT32_MAX ) all_u32 = false;
        return all_u32;
    }
#endif

#if ! FD_OFF_L
    dim_t off_l(dim_t l_offset, bool is_pos_padded = false) const {
        assert(is_blocking_desc());
        assert(l_offset >= 0);
        dims_t pos;
//#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(4))
#if 0 // SLOWS DOWN IF INCLUDE "fast version"
        //const bool all_dims_small = is_pos_padded ? padded_dims_small : dims_small;
        //const bool all_u32 = all_dims_small && (uint64_t)l_offset < UINT32_MAX;
        if ((uint64_t)l_offset <= UINT32_MAX
            && (is_pos_padded ? padded_dims_small : dims_small))
        {
            uint32_t l_off = l_offset;
            const auto dm  = is_pos_padded ? padded_dims(): dims();
            int nd = ndims();
            Short_ for (int rd = 0; rd < nd; ++rd) {
                const int d = nd - 1 - rd;
                const uint32_t cur_dim = dm[nd - 1 - rd];
                pos[d] = l_off % cur_dim;
                l_off = l_off / cur_dim;
            }
        }else
#endif
        {
#if 0
            Short_ for (int rd = 0; rd < ndims(); ++rd) {
                const int d = ndims() - 1 - rd;
                const dim_t cur_dim = is_pos_padded ? padded_dims()[d] : dims()[d];
                /* switch to faster 32-bit division when possible. */
                if (l_offset <= INT32_MAX && cur_dim <= INT32_MAX) {
                    pos[d] = (int32_t)l_offset % (int32_t)cur_dim;
                    l_offset = (int32_t)l_offset / (int32_t)cur_dim;
                } else {
                    pos[d] = l_offset % cur_dim;
                    l_offset /= cur_dim;
                }
            }
#else
            int const nd = ndims();
            const auto dm  = is_pos_padded ? padded_dims(): dims();
            Short_ for (int rd = 0; rd < nd; ++rd) {
                const int d = nd - 1 - rd;
                const dim_t cur_dim = dm[d];
#if 1 // THIS IS GOOD FOR VE TOO
                /* switch to faster 32-bit division when possible. */
                if (l_offset <= INT32_MAX && cur_dim <= INT32_MAX) {
                    pos[d] = (int32_t)l_offset % (int32_t)cur_dim;
                    l_offset = (int32_t)l_offset / (int32_t)cur_dim;
                } else
#endif
                {
                    pos[d] = l_offset % cur_dim;
                    l_offset /= cur_dim;
                }
            }
#endif
        }
#undef Short_
        return off_v(pos, is_pos_padded);
    }
#else // fastdiv is a SLOWDONW for VE
    /** returns physical offset by logical one. logical offset is represented by
     * a scalar \param l_offset. if \param is_pos_padded is true, \param
     * l_offset represents logical offset in already padded area */
    dim_t off_l(dim_t l_offset, bool is_pos_padded = false) const {
        assert(is_blocking_desc());
        assert(l_offset >= 0);
        dims_t pos;
        // fastdiv info:
        const auto dm  = is_pos_padded ? padded_dims(): dims();
        const auto fdm = is_pos_padded ? fd_padded_dims : fd_dims;
//#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(3))
//#define Short_ PragmaQuote(_NEC novector)
//#define Short_
#if 1
        const bool all_dims_small = is_pos_padded ? padded_dims_small : dims_small;
        const bool all_fastdiv = all_dims_small && (uint64_t)l_offset < UINT32_MAX;
        if(all_fastdiv)
        {
            uint32_t l_off = l_offset;
            Short_ for (int rd = 0; rd < ndims(); ++rd) {
                const int d = ndims() - 1 - rd;
#if 0 // fairly fast
                const uint32_t cur_dim = dm[d];
                //pos[d] = l_off % cur_dim;
                uint32_t div = l_off / cur_dim;
                //auto const div = FDIV(l_off, fdm, d);
#else // "fastdiv" here is ~ 50% slowdown
                //const uint32_t cur_dim = is_pos_padded ? padded_dims()[d] : dims()[d];
                const uint32_t cur_dim = dm[d];
                const uint32_t div = FDIV(l_off, fdm, d);
#endif
                pos[d] = l_off - div * cur_dim;
                l_off = div;
            }
        }else
#endif
        {
            uint64_t l_off = l_offset;
            Short_ for (int rd = 0; rd < ndims(); ++rd) {
                const int d = ndims() - 1 - rd;
                const uint64_t cur_dim = dm[d];
                /* switch to faster 32-bit division when possible. */
                if (l_off <= UINT32_MAX && cur_dim <= UINT32_MAX) {
                    //pos[d] = (int32_t)l_offset % (int32_t)cur_dim;
                    //l_offset = (int32_t)l_offset / (int32_t)cur_dim;
                    uint64_t const div = FDIV(l_off, fdm, d);
                    pos[d] = l_off - (uint32_t)div * (uint32_t)cur_dim;
                    l_off = div;
                } else {
                    //pos[d] = l_offset % cur_dim;
                    //l_offset /= cur_dim;
                    pos[d] = l_off % cur_dim;
                    l_off /= cur_dim;
                }
            }
        }
#undef Short_
        // pos[] dimensional positions now ok for unblocked layout.
        // Now adjust for blocked dimensions, and return physical offset.
        return off_v(pos, is_pos_padded);
    }
#endif // FD_OFF_L

    // following call off_v, and we want OUR version to be used:

    /** returns physical offset by logical one. logical offset is represented by
     * a tuple of indices (\param xn, ..., \param x1, \param x0) */
    template <typename... Args>
    dim_t off(Args... args) const {
        assert(sizeof...(args) == ndims());
        dims_t pos = {args...};
        return off_v(pos, false);
    }

    /** returns physical offset by logical one. logical offset is represented by
     * a tuple of indices (\param xn, ..., \param x1, \param x0) in already
     * padded area */
    template <typename... Args>
    dim_t off_padding(Args... args) const {
        assert(sizeof...(args) == ndims());
        dims_t pos = {args...};
        return off_v(pos, true);
    }

private:
    /** inner block strides get precalculated */
    void set_ib_strides() {
        // reverse order -- does not vectorize
        const blocking_desc_t &blk = blocking_desc();
        const int ibs = blk.inner_nblks;
        uint64_t ib_stride = 1U;
        PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(4))
        for (int iblk = ibs - 1; iblk >= 0; --iblk) {
            ib_stride *= (uint64_t) blk.inner_blks[iblk];
            ib_strides[iblk] = ib_stride * blk.inner_blks[iblk];
        }
    }

    static DimsFastDiv init_ib(memory_desc_t const& md) {
        //assert(is_blocking_desc());
        assert( md.format_kind == format_kind::blocked );
        //const blocking_desc_t &blk = blocking_desc();
        blocking_desc_t const &blk = md.format_desc.blocking;
        return init_fastdiv( blk.inner_blks, blk.inner_nblks );
    }

#if FD_OFF_L
    static DimsFastDiv init_padded_dims(memory_desc_t const& md) {
        assert( md.format_kind == format_kind::blocked );
        return init_fastdiv( md.padded_dims, md.ndims );
    }

    static DimsFastDiv init_dims(memory_desc_t const& md) {
        assert( md.format_kind == format_kind::blocked );
        return init_fastdiv( md.dims, md.ndims );
    }
#endif

    uint64_t ib_strides[DNNL_MAX_NDIMS];
#if FD_OFF_V
    DimsFastDiv ib; // for md->format_desc.blocking.inner_blocks
#endif
#if FD_OFF_L
    DimsFastDiv fd_dims;
    DimsFastDiv fd_padded_dims;
#endif

    const bool dims_small;        // fit in u32?
    const bool padded_dims_small; // fit in u32?
};

} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino+=+2s,l0,\:4,N-s
#endif // COMMON_MEMORY_DESC_WRAPPER_OPT_HPP
