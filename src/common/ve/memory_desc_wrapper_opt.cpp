
#include "memory_desc_wrapper_opt.hpp"
#include "ve_fastdiv.h"

namespace dnnl {
namespace impl {

using wo = memory_desc_wrapper_opt;
/** optimize divisions by inner_block sizes, blk.inner_blks[iblk] */
wo::DimsFastDiv wo::init_fastdiv(dims_t const d, int const len){
    DimsFastDiv ret{{0,0,0,0}};
    NOVEC_ for (int i = 0; i < len; ++i){
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
/** vectorizable variant */
wo::DimsFastDivVec wo::init_fastdiv_vec(dims_t const d, int const len){
    DimsFastDivVec ret{{0},{0},{0},{0}};
    NOVEC_ for (int i = 0; i < len; ++i){
        struct ve_fastdiv f;
        vednn_fastdiv( &f, d[i] );
        ret.mul[i] = f.mul;
        ret.add[i] = f.add;
        ret.shr[i] = f.shift;
        ret.div[i] = f.shift;
    }
    return ret;
}

wo::memory_desc_wrapper_opt(const memory_desc_t *md)
        : memory_desc_wrapper(md)
          , ib_strides()
          , offsets_u32( nelems(true/*padded*/) <= UINT32_MAX )
          // if offset_u32, also set
          , blk_strides32()
          , padded_offsets32()
#if VEC_U32
          , ibs32()
          , ib_strides32()
#endif
          , dims_small(all_dims_u32(false))
          , padded_dims_small(all_dims_u32(true))
#if VEC_U32
          , padded_dims32()
          , dims32()
#endif
          { 
              set_ib_info();
          }

wo::memory_desc_wrapper_opt(const memory_desc_t &md)
        : memory_desc_wrapper_opt(&md) // delegate
{}

void wo::set_ib_info() {
    // reverse order -- does not vectorize
    const blocking_desc_t &blk = blocking_desc();
    const int ibs = blk.inner_nblks;
    if(ibs > 0){
        uint64_t ib_stride = 1U;
        PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(4))//;
        for (int iblk = ibs - 1; iblk >= 0; --iblk) {
            ib_strides[iblk] = ib_stride;
            ib_stride *= (uint64_t) blk.inner_blks[iblk];
        }
#if VEC_U32
        if (offsets_u32) {
            for (int iblk = 0; iblk < ibs; ++iblk) {
                ib_strides32[iblk] = (uint32_t)ib_strides[iblk];
                ibs32[iblk] = (uint32_t)blk.inner_blks[iblk];
            }
        }
#endif
    }
    if (offsets_u32) { // not really inner info, here anyway.
        for (int d = 0; d < ndims(); ++d) {
            blk_strides32[d] = (uint32_t)blk.strides[d];
            padded_offsets32[d] = (uint32_t)padded_offsets()[d];
        }
    }
#if VEC_U32
    if (dims_small) { // always true?
        for (int d = 0; d < ndims(); ++d) {
            padded_dims32[d] = padded_dims()[d];
            dims32[d] = dims()[d];
        }
    }
#endif
}

} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
