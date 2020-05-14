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

#ifndef COMMON_MEMORY_DESC_WRAPPER_OPT_DEV_HPP
#define COMMON_MEMORY_DESC_WRAPPER_OPT_DEV_HPP

#include <array>

#include "common/memory_desc_wrapper.hpp"

namespace dnnl {
namespace impl {

/** for VE vectorization [or scalar] */
// customize options for off_l and off_v
#define VEC 0 // allow vectorization over dims_t[], for scalar off_*

// fast-division option -- need to see if it is a real speedup
#define FD_OFF_V 0 /* fastdiv? actually decent speed */
#define FD_OFF_L 0 /* fastdiv? about twice as slow? */

#define FD_VEC 0   /* try vectorizing fastdiv for vec_off_l routines */
// results: for 'noff' in vec_off_l <= 256, fastdiv is bad. (tried it in VEC_U32 section)
//          for vec_off_l >= 512, small improvement (not worth additional complexity)
// ** at best ** 4% speedup, but can be quite bad.
// LEAVE THIS OFF
#define VEC_U32 0 // check for u32 arithmetic in vec_off_* routines
// results: on VE, u32 and u64 arithmetic is essentially same speed
// BEST LEFT OFF

// do not change: vec_off_l public function (vec_off_v private for now)
#define OPTU64 1 /* 0 [signed dim_t original] is only partially supported, for debug */

#if OPTU64
#define MDW64 uint64_t
#define MDW32 uint32_t
#else
#define MDW64 dim_t
#define MDW32 int32_t
#endif

#ifndef MVL
#define MVL 256
#endif

#define NOVEC_ _Pragma("_NEC novector")
#define VEC_ _Pragma("_NEC vector")

#if 0
--softmax --axis=0 256x5555 (or 2560x555)
VEC     OFF_V   OFF_L   VOS     time    u64     vec_off(1)    | orig(*) 
0       0       0       0       365                           |  
0       0       0       1       365 --> 209 --> 8             | 1500
1       0       0       0       380                           |
1       0       0       1       380 --> 366                   |
0       1       0       0       455                           |
0       1       0       1       361 --> 231 -->               | 747
1       1       0       0       376                           |
1       1       0       1       349 --> 350                   |
(*) orig: set VE_FWD_GEN=0 in ref_softmax.cpp
(1) vec_off: set VECTOR_OFFSET_CALC* to 1 in ref_softmax.cpp
#endif

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
struct memory_desc_wrapper_opt_dev : public memory_desc_wrapper {

    /** constructor which takes a reference to a constant underlying C memory
     * descriptor \param md */
    memory_desc_wrapper_opt_dev(const memory_desc_t *md);
    memory_desc_wrapper_opt_dev(const memory_desc_t &md);

    /** vec_off_l uses a work area to pass "as-if-dense" coords to vec_off_v.
     * Potentially could be a set of vector registers.
     * (Or just call vec_off_v directly if modified and made public) */
    struct VecPos {
        uint64_t vp[DNNL_MAX_NDIMS][MVL];
    };
    struct VecPos32 {
        // can VE use packed reg [2*MVL] ?
        //     NO! packed int reg ops NOT available
        uint32_t vp[DNNL_MAX_NDIMS][MVL];
    };

public: // fastdiv support (experimental)
    // optimize divisions by inner_block sizes, blk.inner_blks[iblk]

    // scalar version;  vector of structs might be better
    //struct Magic { uint64_t mul, add, shr, div; };
    struct Magic { uint64_t mul; uint32_t add; uint32_t shr; uint32_t div; };
    typedef std::array<Magic, DNNL_MAX_NDIMS> DimsFastDiv;

    // struct-of-vecs, for vec_off_* routines
    struct DimsFastDivVec {
        // VE should use uint64_t for all fastdiv ops ?
        uint64_t mul[DNNL_MAX_NDIMS];
        uint32_t add[DNNL_MAX_NDIMS];
        uint32_t shr[DNNL_MAX_NDIMS];
        uint32_t div[DNNL_MAX_NDIMS];
    };

private:
    /** scalar loops might toy with this fastdiv, which has a
     * small amount of vectorization over [< ~6] "dimension".
     */
    static DimsFastDiv init_fastdiv(dims_t const divisors, int const len);
    /** Initially tried fastdiv. but it is not a good use case.
     * - Where it could be good:
     *   a- long list of numerators and scalar divisor
     *   b- long list of varying divisors
     * - we are in case (a), but the magic divisors need loading
     *   and currently scalar : vector ops ratio is bad.
     * - would need inner loops <em>many MVL long</em> to perhaps be useful.
     */
    static DimsFastDivVec init_fastdiv_vec(dims_t const divisors, int const len);

    // opt, in case you need the 32-bit version of an original 64-bit divisor...
    // (also probably avail elsewhere -- choose one or make a helper class if useful)
    static inline constexpr uint32_t fdivisor(DimsFastDiv const& fd, int const d){
        return fd[d].div;
    }
    static inline constexpr uint32_t fdivisor(DimsFastDivVec const& fd, int const d){
        return fd.div[d];
    }

    friend constexpr uint64_t operator/(uint64_t top, memory_desc_wrapper_opt_dev::Magic const& m);

    /** optimize u32/u32 division (ex by inner_block sizes, blk.inner_blks[iblk]).
     * \ret top / "divisor[d]" u32/u32 division via mul-add-shr, as ra 64-bit result. */
    template<typename INT>
    static inline constexpr uint64_t fdiv(INT const top, DimsFastDiv const& fd, int const d){
        return top / fd[d];
    }
    template<typename INT>
    static inline constexpr uint64_t fdiv(INT const top, DimsFastDivVec const& fd, int const d){
        return ((uint64_t)top * fd.mul[d] + fd.add[d]) >> fd.shr[d];
    }

public:

    /* vectorized offset section : additional API functions */

    void vec_off_l(dim_t const* const l_offsets, ///< vector of logical offsets [noff]
                   int const noff,               ///< we block by MVL any value OK.
                   dim_t * p_offsets,            ///< output: physical offsets [noff]
                   bool is_pos_padded = false) const {
        assert( noff > 0 && noff <= MVL );
        assert(is_blocking_desc());
#define SHORT_ _Pragma("_NEC vector") _Pragma("_NEC shortloop") _Pragma("_NEC assume")
#ifndef NDEBUG
        // negative and out-of-bounds input l_offsets create nonsense outputs
        SHORT_ for(int i=0;i<noff;++i) {
               assert( l_offsets[i] >= 0 );
               //assert( l_offsets[i] < size_or_padded_size );
        }
#endif
        if (noff <= 1) {
            if (noff == 1) {
                // noff == 1 does not admit vectorization over channels,
                // so use default (might vectorize a little over dims)
                p_offsets[0] = off_l(l_offsets[0]);
                // return;
            }
        } else { // yes, vector routines make sense

            int const nd = ndims();

#if VEC_U32
            if (offsets_u32) {
#if FD_VEC
                //DimsFastDivVec const& fdm = is_pos_padded ? fd_padded_dims_vec: fd_dims_vec;
                // oh. we are vectorizing over 'l', not 'd' ...
                DimsFastDiv const& fdm = is_pos_padded ? fd_padded_dims: fd_dims;
#else
                const auto dm32  = is_pos_padded ? padded_dims32: dims32;
#endif
                VecPos32 vp32; // tmp memory, to transfer vector content to vec_off_v
                // perhaps get rid of this by inlining, using up to 12 vec registers?
                for ( int lb = 0; lb < noff; lb += MVL ) { // XXX sometimes < MVL is faster/ lower latency
                    // vectorize over 'llen'
                    int llen = (noff-lb > MVL? MVL: noff-lb);
                    // load a vector register of logical offset inputs
                    uint32_t off[MVL];
                    _Pragma("_NEC vreg(off)");
                    SHORT_ for(int l=0; l<llen; ++l) off[l] = l_offsets[lb+l]; // VLD
                    // convert to coords [up to 12=DNNL_MAX_NDIMS]
                    NOVEC_ for (int d = 0; d < nd; ++d) { // reverse
                        const int rd = nd - 1 - d;        // dims
                        SHORT_ for(int l=0; l<llen; ++l) {   // l ~ logical offset
#if FD_VEC
                            // still mixed with fair amount of scalar code to
                            // load the "magics".   
                            uint32_t const div = fdiv(off[l], fdm, d );
                            vp32.vp[rd][l] = off[l] - div * fdivisor(fdm, d);
                            off[l] = div;
#else
                            // few scalar ops, looks good
                            vp32.vp[rd][l] = off[l] % dm32[rd]; // still div,mul,sub
                            off[l] = off[l] / dm32[rd];         // store vec reg to vp32
#endif
                        }
                    }
                    // "dense-layout" coords in vp --> output p_offset
                    vec_off_v(vp32, &p_offsets[lb], llen, is_pos_padded);
                }
            } else
#endif // VEC_U32
            {
                const auto dm  = is_pos_padded ? padded_dims(): dims();
                VecPos vp; // tmp memory, to transfer vector content to vec_off_v
                // perhaps get rid of this by inlining, using up to 12 vec registers?
                for ( int lb = 0; lb < noff; lb += MVL ) { // XXX sometimes < MVL is faster/ lower latency
                    // vectorize over 'llen'
                    int llen = (noff-lb > MVL? MVL: noff-lb);
                    // load a vector register of logical offset inputs
                    uint64_t off[MVL];
                    _Pragma("_NEC vreg(off)");
                    SHORT_ for(int l=0; l<llen; ++l) off[l] = l_offsets[lb+l];
                    // convert to coords [up to 12=DNNL_MAX_NDIMS]
                    NOVEC_ for (int d = 0; d < nd; ++d) {
                        const int rd = nd - 1 - d;          // reverse
                        // this loop vectorizes well, albeit u64 ops
                        SHORT_ for(int l=0; l<llen; ++l) { // l ~ logical offset
                            vp.vp[rd][l] = off[l] % dm[rd]; // does the right thing (div,mul,sub)
                            off[l] = off[l] / dm[rd];       // store vec reg to vp
                        }
                    }
#ifndef NDEBUG
                    if(1){ // test regularity of vp (as generated from ref_softmax.cpp)
                        NOVEC_ for (int d = 0; d < nd; ++d) {
                            SHORT_ for(int l=1; l<llen; ++l) { // l ~ logical offset
                                if( vp.vp[d][l] != vp.vp[d][0] && vp.vp[d][l] != vp.vp[d][0] )
                                    assert(nullptr == "axis not regular?");
                            }
                        }
                    }
#endif
                    // "dense-layout" coords in vp --> output p_offset
                    vec_off_v(vp, &p_offsets[lb], llen, is_pos_padded);
                }
            }
#undef SHORT_
        }
        return;
    }
private:
    /** vector-of-physical-offsets version of \c off_v.
     * Unlike \c off_v, we are \e private and can modify
     * our coords \c vp, to save memory.
     *
     * \note This only does a MVL-long section at a time
     */
    void vec_off_v( VecPos & vp,         // list of coords (from vec_off_l)
                      dim_t * p_offsets, // output physical offsets
                      int const noff,    // how many offsets in vp and p_offsets
                      bool is_pos_padded = false) const {
        assert(noff <= MVL);
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#if 0 // just to see if things compile ...
        for(int p=0; p<noff; ++p){
            p_offsets[p] = 0;
        }
#else
#ifndef NDEBUG
        unsigned nsame=0U;
        for (int i=0; i<blk.inner_nblks; ++i) {
            for (int j=i+1; j<blk.inner_nblks; ++j) {
                if (blk.inner_idxs[i] == blk.inner_idxs[j])
                    ++nsame;
            }
        }
        assert( nsame == 0U ); // inner_idxs[] MUST be distinct
#endif

#define Short_ PragmaQuote(_NEC vector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        assert( nd < 6 );
        if (is_pos_padded) {
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp.vp[d][l] += padded_offsets()[d];
               }
            }
        }

        //uint64_t phys_offset = offset0();
        // phys[] : vreg mirror of p_offsets[noff] output, until final vector store
        uint64_t phys[MVL];
        _Pragma("_NEC vreg(phys)")
        for(int l=0; l<noff; ++l)
            phys[l] = offset0();

        if (blk.inner_nblks > 0) {
#if 0
            // probably makes sense to reconsider if packed regs used (but then other things change too)
            if (size() < INT32_MAX){
                NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                    const int d = blk.inner_idxs[iblk];
                    VEC_ for(int l=0; l<noff; ++l) {
                        uint32_t const p = vp.vp[d][l] % (uint64_t)blk.inner_blks[iblk];
                        vp.vp[d][l] /= (uint32_t)blk.inner_blks[iblk];
                        phys[l] += p * (uint32_t)(ib_strides[iblk]);
                    }
                }
            }else
#endif
            {
                NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                    const int d = blk.inner_idxs[iblk];
                    VEC_ for(int l=0; l<noff; ++l) {
                        uint64_t const p = vp.vp[d][l] % (uint64_t)blk.inner_blks[iblk];
                        vp.vp[d][l] /= (uint64_t)blk.inner_blks[iblk];
                        phys[l] += p * ib_strides[iblk];
                    }
                }
            }
        }

        NOVEC_ for (int d = 0; d < nd; ++d) {
            uint64_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<noff; ++l) tmp[l] = vp.vp[d][l]; // VLD (nec.?)
            VEC_ for(int l=0; l<noff; ++l) {
                phys[l] += tmp[l] * (uint64_t)blk.strides[d];     // VMUL,VADD (extra vcopy)
            }
        }

        Short_ for(int l=0; l<noff; ++l)
            p_offsets[l] = phys[l]; // final vector store VST to output
#undef Short_
#endif
    }

#if VEC_U32
    void vec_off_v( VecPos32 & vp32,         // list of coords (from vec_off_l)
                      dim_t * p_offsets, // output physical offsets
                      int const noff,    // how many offsets in vp32 and p_offsets
                      bool is_pos_padded = false) const {
        assert(noff <= MVL);
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#ifndef NDEBUG
        unsigned nsame=0U;
        for (int i=0; i<blk.inner_nblks; ++i) {
            for (int j=i+1; j<blk.inner_nblks; ++j) {
                if (blk.inner_idxs[i] == blk.inner_idxs[j])
                    ++nsame;
            }
        }
        assert( nsame == 0U ); // inner_idxs[] MUST be distinct
#endif

#define Short_ PragmaQuote(_NEC vector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        assert( nd < 6 );
        if (is_pos_padded) {
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp32.vp[d][l] += padded_offsets32[d];
               }
            }
        }

        //uint64_t phys_offset = offset0();
        // phys[] : vreg mirror of p_offsets[noff] output, until final vector store
        uint64_t phys[MVL];
        _Pragma("_NEC vreg(phys)")
        for(int l=0; l<noff; ++l)
            phys[l] = offset0();

        if (blk.inner_nblks > 0) {
            NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                VEC_ for(int l=0; l<noff; ++l) {
#if 0 && FD_VEC
                    // the number of inner blocks is always pretty small, so added scalar overhead
                    // of fastdiv makes no sense.
                    uint32_t const div = fdiv(vp32.vp[d][l], fd_ibvec, d );
                    uint32_t const p = vp32.vp[d][l] - div * fdivisor(fd_ibvec, d);
                    vp32.vp[d][l] = div;
#else
                    uint32_t const p = vp32.vp[d][l] % ibs32[iblk]; // ibs32 ~ blk.inner_blocks
                    vp32.vp[d][l] /= ibs32[iblk];
#endif
                    phys[l] += p * ib_strides32[iblk];
                }
            }
        }

        NOVEC_ for (int d = 0; d < nd; ++d) {
            uint32_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<noff; ++l) tmp[l] = vp32.vp[d][l]; // VLD (nec.?)
            VEC_ for(int l=0; l<noff; ++l) {
                phys[l] += tmp[l] * blk_strides32[d];     // VMUL,VADD (extra vcopy) XXX check for vec reduc?
            }
        }

        Short_ for(int l=0; l<noff; ++l)
            p_offsets[l] = phys[l]; // final vector store VST to output
#undef Short_
    }
#endif // VEC_U32

public:

    /* offset section : REPLACE non-virtual base class versions */

#if FD_OFF_V == 0 // close to original
    /** returns physical offset by logical one. logical offset is represented by
     * an array \param pos. if \param is_pos_padded is true \param pos
     * represents the position in already padded area */
    dim_t off_v(const dims_t pos, bool is_pos_padded = false) const {
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#if ORIG
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
        dims_t pos_copy = {0};
        Short_ for (int d = 0; d < ndims(); ++d)
            pos_copy[d] = pos[d] + (is_pos_padded ? 0 : padded_offsets()[d]);
        dim_t phys_offset = offset0();
        if (blk.inner_nblks > 0) {
            dim_t blk_stride = 1;
            Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                dim_t p;
                if (pos_copy[d] <= INT32_MAX) {
                    p = (int32_t)pos_copy[d] % (int32_t)blk.inner_blks[iblk];
                    pos_copy[d] = (int32_t)pos_copy[d]
                            / (int32_t)blk.inner_blks[iblk];
                } else {
                    p = pos_copy[d] % blk.inner_blks[iblk];
                    pos_copy[d] /= blk.inner_blks[iblk];
                }
                phys_offset += p * blk_stride;
                blk_stride *= blk.inner_blks[iblk];
            }
        }
        Short_ for (int d = 0; d < ndims(); ++d) {
            const dim_t p = pos_copy[d];
            phys_offset += p * blk.strides[d];
        }
#undef Short_
        return phys_offset;
#else // NOT ORIG

#if VEC==0 // FD_OFF_V==0 VEC==0
//#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        MDW64 pos_copy[DNNL_MAX_NDIMS] = {0};
        Short_ for (int d = 0; d < nd; ++d)
            pos_copy[d] = pos[d] + (is_pos_padded ? 0 : padded_offsets()[d]);

        MDW64 phys_offset = offset0();

        if (blk.inner_nblks > 0) {
            Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                MDW64 p;
#if OPTU64
                if (pos_copy[d] <= UINT32_MAX)
                    //if ((pos_copy[d] & 0xFFffFFff00000000) == 0)
#else
                    if (pos_copy[d] <= INT32_MAX)
#endif

                    {
                        p = (MDW32)pos_copy[d] % (MDW32)blk.inner_blks[iblk];
                        pos_copy[d] = (MDW32)pos_copy[d] / (MDW32)blk.inner_blks[iblk];
                    } else {
                        p = pos_copy[d] % (MDW64)blk.inner_blks[iblk];
                        pos_copy[d] /= (MDW64)blk.inner_blks[iblk];
                    }
                phys_offset += p * ib_strides[iblk];
            }
        }

        Short_ for (int d = 0; d < nd; ++d) {
            const MDW64 p = pos_copy[d];
            phys_offset += p * (MDW64)blk.strides[d];
        }
#undef Short_
#if 0 && OPTU64 // identical speed
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

#else // D_OFF_V==0 VEC==1
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

#endif // VEC
        return phys_offset;
#endif // ORIG
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
                    auto const div = fdiv(pos_copy[d], fd_ib, iblk);
                    p = pos_copy[d] - (uint32_t)div * fdivisor(fd_ib,iblk); // remainder
                    // fdivisor is u32 blk.inner_blks, aka ibs32[iblk]
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
                        auto const div = fdiv(pos_copy[d], fd_ib, iblk);
                        p = pos_copy[d] - (uint32_t)div * fdivisor(fd_ib,iblk); // remainder
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
                    auto const div = fdiv(pos_copy[d], fd_ib, iblk); // u64 division result
                    pcrem[iblk] = (uint64_t)(pos_copy[d] - (uint32_t)div * fdivisor(fd_ib,iblk)); // remainder
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
        MDW64 pos[DNNL_MAX_NDIMS];
#if ORIG
        PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))//;
        for (int rd = 0; rd < ndims(); ++rd) {
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
        return off_v(pos, is_pos_padded);
#else

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
#if 0 // orig
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
        return off_v((dim_t*)pos, is_pos_padded);
#endif // ORIG
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
            MDW32 l_off = l_offset;
            Short_ for (int rd = 0; rd < ndims(); ++rd) {
                const int d = ndims() - 1 - rd;
#if 0 // fairly fast
                const uint32_t cur_dim = dm[d];
                //pos[d] = l_off % cur_dim;
                uint32_t div = l_off / cur_dim;
                //auto const div = fdiv(l_off, fdm, d);
#else // "fastdiv" here is ~ 50% slowdown
                //const uint32_t cur_dim = is_pos_padded ? padded_dims()[d] : dims()[d];
                const uint32_t cur_dim = dm[d];
                const uint32_t div = fdiv(l_off, fdm, d);
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
                    uint64_t const div = fdiv(l_off, fdm, d);
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
    /** inner block strides (and various other) get precalculated */
    void set_ib_info();

    static DimsFastDiv fdinit_ib(memory_desc_t const& md) {
        //assert(is_blocking_desc());
        assert( md.format_kind == format_kind::blocked );
        blocking_desc_t const &blk = md.format_desc.blocking;
        return init_fastdiv( blk.inner_blks, blk.inner_nblks );
    }

    static DimsFastDivVec fdinit_ib_vec(memory_desc_t const& md) {
        //assert(is_blocking_desc());
        assert( md.format_kind == format_kind::blocked );
        blocking_desc_t const &blk = md.format_desc.blocking;
        return init_fastdiv_vec( blk.inner_blks, blk.inner_nblks );
    }
#if FD_OFF_L
    static DimsFastDiv fdinit_padded_dims(memory_desc_t const& md) {
        assert( md.format_kind == format_kind::blocked );
        return init_fastdiv( md.padded_dims, md.ndims );
    }
    static DimsFastDiv fdinit_dims(memory_desc_t const& md) {
        assert( md.format_kind == format_kind::blocked );
        return init_fastdiv( md.dims, md.ndims );
    }
#endif
#if FD_VEC
    static DimsFastDivVec fdinit_padded_dims_vec(memory_desc_t const& md) {
        assert( md.format_kind == format_kind::blocked );
        return init_fastdiv_vec( md.padded_dims, md.ndims );
    }
    static DimsFastDivVec fdinit_dims_vec(memory_desc_t const& md) {
        assert( md.format_kind == format_kind::blocked );
        return init_fastdiv_vec( md.dims, md.ndims );
    }
#endif

    /** precalc inner block strides (load vec once vs inner multiplies) */
    MDW64 ib_strides[DNNL_MAX_NDIMS];

    /** quick test for uint32_t offset arithmetic */
    bool const offsets_u32;
    uint32_t ib_strides32[DNNL_MAX_NDIMS];      ///< u32 version
    uint32_t blk_strides32[DNNL_MAX_NDIMS];     ///< blk.strides
    uint32_t padded_offsets32[DNNL_MAX_NDIMS];  ///< if is_pos_padded, padded_offset()[]

#if FD_OFF_V
    DimsFastDiv fd_ib;    // scalar /: by md->format_desc.blocking.inner_blocks
#endif
#if FD_VEC
    DimsFastDivVec fd_ibvec; // vectorizing /: struct-of-vecs
#endif
#if FD_OFF_L || FD_VEC
    DimsFastDiv fd_dims;
    DimsFastDiv fd_padded_dims;
#endif
#if FD_VEC // for vec_off_l
    DimsFastDivVec fd_ib_vec;
    DimsFastDivVec fd_dims_vec;
    DimsFastDivVec fd_padded_dims_vec;
#endif


    const bool dims_small;        // fit in u32? XXX always true
    const bool padded_dims_small; // fit in u32? XXX always true
    uint32_t ibs32[DNNL_MAX_NDIMS];  ///< if padded_dims_small, blk.inner_blocks[]
    //const auto dm  = is_pos_padded ? padded_dims(): dims();
    uint32_t padded_dims32[DNNL_MAX_NDIMS];
    uint32_t dims32[DNNL_MAX_NDIMS];
};

// support functions

inline constexpr uint64_t operator/(uint64_t top, memory_desc_wrapper_opt_dev::Magic const& m){
#if defined(__ve)
    // depends on memory ordering -- this is OK for VE (reduce mem loads)
    uint64_t const xxx = *(uint64_t*)(&m.add);
    return (top * m.mul + (uint64_t)(uint32_t)xxx) >> (xxx>>32);
#else
    return ((top * m.mul + m.add) >> m.shr);
#endif
}

} // namespace impl
} // namespace dnnl

#undef MDW64
#undef MDW32

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
#endif // COMMON_MEMORY_DESC_WRAPPER_OPT_DEV_HPP
