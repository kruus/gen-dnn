#line 10000
/*******************************************************************************
* Copyright 2017-2020 Intel Corporation
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

#include <cstring>

#include "common/dnnl_thread.hpp"

#include "cpu/simple_concat.hpp"
#if defined(__ve)
#include "common/dnnl_optimize.h" // omp-related pragmas, mostly
#endif

#ifndef NOVEC_
#define NOVEC_ PragmaQuote(_NEC novector)
#endif
namespace dnnl {
namespace impl {
namespace cpu {

namespace {
 
// what is sizeof(bfloat) ?  It memcpy-able
// nc++ may do better with template-inline memcpy wrapper for compile-time type T*
template<typename T>
static inline void memcpy_wrap(T * o, T const* i, size_t sz){
    static_assert( std::is_trivially_copyable<T>::value, "memcpy_wrap<T> should *not* use memcpy" );
    //asm("### memcpy");
    std::memcpy(&o[0], &i[0], sz * sizeof(T));
}
// VE can avoid memcpy fn call for nicely-aligned vectorizable types
// but AL_CPY for u8 (for example) will not vectorize (use generic memcpy)
#define AL_CPY IVDEP() for(size_t e=0; e<sz; ++e) o[e] = i[e]
//#define AL_CPY PragmaQuote(_NEC packed) for(size_t e=0; e<sz; ++e) o[e] = i[e]
template<>
inline void memcpy_wrap(double *o, double const* i, size_t sz){ AL_CPY; }
template<>
inline void memcpy_wrap(float *o, float const* i, size_t sz){ AL_CPY; }
//template<>
//inline void memcpy_wrap(float (*o)[stack_elems], float const (*i)[stack_elems], size_t sz){ AL_CPY; }
template<>
inline void memcpy_wrap(uint32_t *o, uint32_t const* i, size_t sz){ AL_CPY; }
template<>
inline void memcpy_wrap(int32_t *o, int32_t const* i, size_t sz){ AL_CPY; }
template<>
inline void memcpy_wrap(uint64_t *o, uint64_t const* i, size_t sz){ AL_CPY; }
template<>
inline void memcpy_wrap(int64_t *o, int64_t const* i, size_t sz){ AL_CPY; }
// We must also AVOID memcpy for some object types:
// bfloat16 ...
//template<>
//inline void memcpy_wrap(double *o, double const* i, size_t sz){ AL_CPY; }

#ifndef MVL
#define MVL 256
#endif

#define STACK_ELEMS 8192
static dim_t constexpr stack_elems = STACK_ELEMS; // a generally decent value

static inline dim_t stack_friendly_blksz(dim_t const hi){
    // borrow from ve/ref_lrn.cpp
    dim_t ret = (hi>0? hi: 1);
    if (hi > stack_elems) {
        ret = stack_elems;
        dim_t const nFull = hi/stack_elems;
        dim_t const rem   = hi%stack_elems;
        if (rem < stack_elems/4) {
            dim_t const nLoops = nFull + (rem!=0);
            ret = (hi+nLoops-1) / nLoops;
            //printf("+%d",(int)ret); // rough equipartition
            if (ret < stack_elems - MVL) {
                ret = (ret+MVL-1)/MVL*MVL;
                //printf("^%d",(int)ret); // round up
            }
        }
    }
    assert( ret <= stack_elems );
    return ret;
}
/** but also want blksz low enough that max_threads can actually be used...
 * XXX return to this with measurements XXX. */
static inline dim_t stack_friendly_blksz(dim_t const hi, dim_t const other_work){
    dim_t stack_lim = (other_work*hi/dnnl_get_max_threads());
    // adjust following, which assumes one MVL is "enough work"
    // here MVL ~ min desirable blksz (but we can go lower, a bit)
    if (stack_lim < MVL) stack_lim = MVL;
    stack_lim = (stack_lim+(MVL-1)) / MVL * MVL;
    if (stack_lim > stack_elems) stack_lim = stack_elems;

    // now heuristic with possibly smaller version of stack_elems
    dim_t ret = (hi>0? hi: 1);
    if (hi > stack_lim) {
        ret = (stack_lim+31)/32*32;
        dim_t const nFull = hi/stack_lim;
        dim_t const rem   = hi%stack_lim;
        if (rem < MVL/4) {
            dim_t const nLoops = nFull + (rem!=0);
            ret = (hi+nLoops-1) / nLoops;
            //printf("+%d",(int)ret); // rough equipartition
            if (ret < stack_lim - MVL) {
                ret = (ret+MVL-1)/MVL*MVL;
                //printf("^%d",(int)ret); // round up
            }
        }
        ret = (ret+31)/32*32;
    }
    //assert( ret < stack_elems );
    return ret;
}
} // anon::

using namespace memory_tracking::names;

template <data_type_t data_type>
status_t simple_concat_t<data_type>::execute(const exec_ctx_t &ctx) const {
    int constexpr dbg = 0;
    auto scratchpad = ctx.get_scratchpad_grantor();
    auto iptrs = scratchpad.template get<const data_t *>(key_concat_iptrs);
    auto optrs = scratchpad.template get<data_t *>(key_concat_optrs);
    auto nelems_to_copy = scratchpad.template get<dim_t>(key_concat_nelems);
    auto is = scratchpad.template get<strides_t>(key_concat_istrides);

    const int num_arrs = pd()->n_inputs();
    const int *perm = pd()->perm_, *iperm = pd()->iperm_;
    const int concat_dim = pd()->concat_dim();
    auto o_base_ptr = CTX_OUT_MEM(data_t *, DNNL_ARG_DST);
    if(dbg>0) printf("perm[concat_dim=%d]=%d sizeof(data_t)=%d",
            (int)concat_dim,(int)perm[concat_dim], (int)sizeof(data_t));

    for (int a = 0; a < num_arrs; ++a) {
        const memory_desc_wrapper i_d(pd()->src_md(a));
        const memory_desc_wrapper o_d(pd()->src_image_md(a));

        iptrs[a] = CTX_IN_MEM(const data_t *, DNNL_ARG_MULTIPLE_SRC + a)
                + i_d.blk_off(0);
        optrs[a] = o_base_ptr + o_d.blk_off(0);
        nelems_to_copy[a] = pd()->nelems_to_concat(i_d);
        NOVEC_ for (int i = 0; i < DNNL_MAX_NDIMS; i++) {
            if (i < perm[concat_dim])
                // blocks vectorizn :
                is[a][i] = size_t(i_d.blocking_desc().strides[iperm[i]]);
            else
                is[a][i] = 0;
        }
    }

    const memory_desc_wrapper o_d(pd()->dst_md(0));

    strides_t os = {0};
    bool has_outer_loop = false;
    NOVEC_ for (int i = 0; i < perm[concat_dim]; i++) {
        os[i] = o_d.blocking_desc().strides[iperm[i]];
        // CAVEAT: if this impl supports not matching stag and dtag, strides
        // should be taken into account for this condition.
        if (o_d.padded_dims()[iperm[i]] != 1) has_outer_loop = true;
    }

    // Applies when concat axis is the outermost dimension, e.g. concat_axis = 0
    // or concat_axis = 1, and dims[0] = 1;
    if (!has_outer_loop) {
        if(dbg>0) {
        printf(" num_arrs=%ld,nelems", (long)num_arrs);
        for(unsigned a=0; a<num_arrs; ++a)
            printf("%c%lu", (a==0?'{':','), (long unsigned)nelems_to_copy[a]);
        printf("}");
        }
#if 0 // orig
        for (int a = 0; a < num_arrs; ++a) {
            const data_t *i = &iptrs[a][0];
            data_t *o = &optrs[a][0];
#define Medium_ PragmaQuote(_NEC loop_count(STACK_ELEMS))
#if 0 // tough to see where asm code is... and it is not vectorized for small types by nc++
            parallel_nd(nelems_to_copy[a], [&](dim_t e) {
                        o[e] = i[e];
                        });
#elif 1
            const ptrdiff_t nelems = static_cast<ptrdiff_t>(nelems_to_copy[a]);
            dim_t const blksz = stack_friendly_blksz(nelems,1);
            assert( blksz <= /*constexpr*/ stack_elems );
            parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk) {
                dim_t const start = blk * blksz;
                dim_t const end   = (start + blksz > nelems? nelems: start + blksz);
                dim_t const sz = end - start;
#if 0 // never memcpy, really great if nc++ "naturally" vectorizes data_t
                Medium_ for(dim_t e=start; e<end; ++e) {
                    o[e] = i[e];
                }
#elif 0 // memcpy always
                memcpy(&o[start], &i[start], sz*sizeof(data_t));
#elif 1 // memcpy if convenient, esp. if sizeof(data_t) < 4
                // illegal : data_t (*o0)[stack_elems] = &o[start];
                memcpy_wrap(&o[start], &i[start], sz);
#endif
            });
#endif
#else // cleaned up a bit, no changes yet
        NOVEC_ for (int a = 0; a < num_arrs; ++a) {
            const data_t *i = &iptrs[a][0];
            data_t *o = &optrs[a][0];
#define Medium_ PragmaQuote(_NEC loop_count(STACK_ELEMS))
            const ptrdiff_t nelems = static_cast<ptrdiff_t>(nelems_to_copy[a]);
            // XXX check sanity/speed of blksz heuristic as nelems changes XXX
            dim_t const blksz = stack_friendly_blksz(nelems,1);
            assert( blksz <= /*constexpr*/ stack_elems );
            parallel_nd(utils::div_up(nelems, blksz), [&](dim_t const blk) {
                dim_t const start = blk * blksz;
                dim_t const end   = (start + blksz > nelems? nelems: start + blksz);
                dim_t const sz = end - start;
                memcpy_wrap(&o[start], &i[start], sz);
            });
#endif
        }
        return status::success;
    }

    dims_t phys_dims;
    ShortLoop() for (int i = 0; i < DNNL_MAX_NDIMS; i++) {
        if (i < perm[concat_dim])
            phys_dims[i]
                    = o_d.padded_dims()[iperm[i]] / pd()->blocks_[iperm[i]];
        else
            phys_dims[i] = 1;
    }

    if(dbg>0) {
        printf(" phys_dims{%ld,%ld,%ld,%ld,%ld},num_arrs=%ld,nelems",
                phys_dims[0], phys_dims[1], phys_dims[2], phys_dims[3],
                phys_dims[4], (long)num_arrs);
        for(unsigned a=0; a<num_arrs; ++a)
            printf("%c%lu", (a==0?'{':','), (long unsigned)nelems_to_copy[a]);
        printf("}");
    }
    parallel_nd(phys_dims[0], phys_dims[1], phys_dims[2], phys_dims[3],
            phys_dims[4], num_arrs,
            [&](dim_t n0, dim_t n1, dim_t n2, dim_t n3, dim_t n4, int a) {
                // XXX: this code may access uninitialized values in is[*][0-4] --
                // that's why we have to set them to zero although this is
                // probably benign
                size_t in_off = is[a][0] * n0 + is[a][1] * n1 + is[a][2] * n2
                        + is[a][3] * n3 + is[a][4] * n4;
                size_t out_off = os[0] * n0 + os[1] * n1 + os[2] * n2
                        + os[3] * n3 + os[4] * n4;
                const data_t *i = &iptrs[a][in_off];
                data_t *o = &optrs[a][out_off];
#if defined(__ve) // use the memcpy_wrap method developed above... (avoid fn call for easy cases)
                memcpy_wrap(o, i, nelems_to_copy[a]);
#elif defined(__GNUC__) && !defined(__INTEL_COMPILER)
                std::memcpy(o, i, nelems_to_copy[a] * sizeof(data_t));
#else
                PRAGMA_OMP_SIMD()
                for (dim_t e = 0; e < nelems_to_copy[a]; ++e) o[e] = i[e];
#endif
            });

    return status::success;
}

template struct simple_concat_t<data_type::f32>;
template struct simple_concat_t<data_type::u8>;
template struct simple_concat_t<data_type::s8>;
template struct simple_concat_t<data_type::s32>;
template struct simple_concat_t<data_type::bf16>;

} // namespace cpu
} // namespace impl
} // namespace dnnl
