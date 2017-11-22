/*******************************************************************************
* Copyright 2017 Intel Corporation
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

#ifndef _CONV_HPP
#define _CONV_HPP

#include <stdint.h>
#include <limits.h>
#include <assert.h>

#include "mkldnn.h"

#include "common.hpp"
#include "mkldnn_common.hpp"
#include "mkldnn_memory.hpp"

namespace conv {

enum { SRC = 0, WEI = 1, BIA = 2, DST = 3, ACC = 4, DAT_TOTAL };
const char *inp_type2str(int what);

enum alg_t { DIRECT, WINO };
alg_t str2alg(const char *str);
const char *alg2str(alg_t alg);

enum merge_t { NONE, RELU, };
merge_t str2merge(const char *str);
const char *merge2str(merge_t merge);

struct attr_t {
    enum round_mode_t {
        NEAREST = (int)mkldnn_round_nearest,
        DOWN = (int)mkldnn_round_down,
    };
    static round_mode_t str2rmode(const char *str);
    static const char *rmode2str(round_mode_t rmode);

    struct scale_t {
        enum policy_t { NONE = 0, COMMON, PER_OC, POLICY_TOTAL };
        static policy_t str2policy(const char *str);
        static const char *policy2str(policy_t policy);

        policy_t policy = NONE;
        float scale = 1.;

        int str2scale(const char *str, const char **end_s);
        void scale2str(char *buffer, char **end_b) const;

        bool is_def() const { return this->policy == NONE; }
    };

    round_mode_t irmode = round_mode_t::NEAREST;
    scale_t oscale;
    mkldnn_primitive_attr_t mkldnn_attr = NULL;

    bool is_def() const;
    int mkldnn_attr_recreate();
};

const size_t max_attr_len = 128;
int str2attr(attr_t *attr, const char *str);
void attr2str(const attr_t *attr, char *buffer);

struct desc_t {
    int g, mb;
    int ic, ih, iw;
    int oc, oh, ow;
    int kh, kw;
    int sh, sw;
    int ph, pw;
    int dh, dw;

    const char *name;
};
const size_t max_desc_len = 196;
int str2desc(desc_t *desc, const char *str);
void desc2str(const desc_t *d, char *buffer, bool canonical = false);

/** configuration structure, that controls initial data filling + error check
 *
 * dt defines convolution precision
 *
 * for each type (SRC, WEI, BIA, and DST) the values are filled as follows:
 * if (rand() > f_sparsity) then:
 *     v <-- f_base // it is guaranteed each kernel window
 *                  // has at least one non-zero element
 * else:
 *     v <-- f_min + rand() * f_step % (f_max - f_min)
 *
 *
 * on final check the resulting values should be in [min .. max] range, the
 * relative difference should not exceed eps
 */
typedef struct dt_conf_t {
    mkldnn_data_type_t dt;
    int min, max; /* representative */
    int f_min, f_max; /* fill range */
    int f_base; /* fill base, use 0 */
    int f_step; /* fill step, use 1 */
    double f_sparsity; /* amount of non-zeros, default 0.25 */
    double eps; /* acceptable error */
} _dt_conf_t[DAT_TOTAL];

extern const _dt_conf_t conf_f32;
extern const _dt_conf_t conf_f32_full;
extern const _dt_conf_t conf_f32_wino;
extern const _dt_conf_t conf_s16s16s32s32;
extern const _dt_conf_t conf_s32s16s16s32;
extern const _dt_conf_t conf_s16s32s16s32;
extern const _dt_conf_t conf_u8s8s32s32;
extern const _dt_conf_t conf_u8s8s8s32;
extern const _dt_conf_t conf_u8s8u8s32;

const dt_conf_t *str2cfg(const char *str);
const char *cfg2str(const dt_conf_t *cfg);

struct prb_t: public desc_t {
    prb_t(const desc_t &desc, dir_t dir, const dt_conf_t *cfg, alg_t alg,
            merge_t merge, const attr_t &attr, int mb = 0)
        : desc_t(desc), dir(dir), cfg(cfg), alg(alg), merge(merge), attr(attr)
        , ops(0) {
        if (mb) this->mb = mb;
        count_ops();
    }

    dir_t dir;
    const dt_conf_t *cfg;
    alg_t alg;
    merge_t merge;
    attr_t attr;

    double ops;

    void count_ops();
};
const size_t max_prb_len = max_attr_len + max_desc_len + 196;
void prb2str(const prb_t *p, char *buffer, bool canonical = false);

/* some extra control parameters which shouldn't be placed in prb_t */
extern const char *skip_impl; /* NULL or "" means do not skip anything */
extern bool allow_unimpl; /* true means do not treat unimplemented as error */
extern const char *perf_template; /* performance output template */

inline size_t src_off_f(const prb_t *p, int mb, int g, int ic, int ih, int iw)
{
    return (((size_t)mb * p->ic + g * p->ic/p->g + ic) * p->ih + ih) * p->iw
        + iw;
}

inline size_t src_off_f_nog(const prb_t *p, int mb, /*int g,*/ int ic, int ih, int iw)
{
    // ic now ranges over full range [0,p->ic)
    //                              vvvvvvvvvvvvvvvvvvv
    //return (((size_t)mb * p->ic + g * p->ic/p->g + ic) * p->ih + ih) * p->iw
    //    + iw;
    return (((size_t)mb * p->ic +   ic  ) * p->ih + ih) * p->iw + iw;
}

inline void inv_src_off_f(const prb_t *p, size_t off, int &mb, int &g, int &ic,
        int &ih, int &iw) {
    iw = off % p->iw; off /= p->iw;
    ih = off % p->ih; off /= p->ih;
    ic = off % (p->ic / p->g); off /= (p->ic / p->g);
    g = off % p->g; off /= p->g;
    mb = off % p->mb; off /= p->mb;
    assert(off == 0);
}

inline size_t wei_off_f(const prb_t *p, int g, int oc, int ic, int kh, int kw)
{
    return ((((size_t)g * p->oc / p->g + oc) * p->ic / p->g + ic) * p->kh + kh)
        * p->kw + kw;
}

/** A non-optimization if within an innermost loop.
 * Difficult to use, because 'g' must be common to oc and ic. */
inline constexpr size_t wei_off_f_nog(const prb_t *p, /*int g,*/ int oc, int ic, int kh, int kw)
{
    // (((g * p->oc/p->g) + oc)) *p->ic/p->g + ic) *p->kh + kh) *p->kw+kw
    // (( g * p->oc/p->g  + oc)) *p->ic/p->g + ic) *p->kh + kh) *p->kw+kw
    // ((       oc_nog        )) *p->ic/p->g + ic) *p->kh + kh) *p->kw+kw
    //
    // Now define ic_nog = g*p->ic/p->g + ic running from 0..p->ic
    // so  g  = ic_nog / (p->ic/p->g)
    // and ic = ic_nog % (p->ic/p->g)
    //
    // Similarly, oc = oc_nog%(p->ic/p->g)
    //
    // ((       oc_nog        )) *p->ic/p->g + ic_nog%(p->ic/p->g)) *p->kh + kh) *p->kw+kw
    return ((((size_t)oc) * p->ic/p->g + ic%(p->ic/p->g)) * p->kh + kh) * p->kw + kw;
}

inline void zero_wei( const prb_t *p, dnn_mem_t const& wei_m ){
#if 1
    // weight_off_f_nog is dense in oc,ic,kh,kw so all loops collapse into one!
    memset( (float*)wei_m, 0, wei_m.size() );
#else
# pragma omp parallel for collapse(4)
    for (int ic = 0; ic < p->ic; ++ic) { // dw = 0
        for (int oc=0; oc < p->oc; ++oc) {
            for (int kh = 0; kh < p->kh; ++kh) {
                for (int kw = 0; kw < p->kw; ++kw) {
                    size_t wei_off = wei_off_f_nog(p, /*g,*/ oc, ic, kh, kw);
                    *((float*)wei_m)[wei_off] = 0;
                }
            }
        }
    }
#endif
} 

inline void inv_wei_off_f(const prb_t *p, size_t off, int &g, int &oc, int &ic,
        int &kh, int &kw) {
    kw = off % p->kw; off /= p->kw;
    kh = off % p->kh; off /= p->kh;
    ic = off % (p->ic / p->g); off /= (p->ic / p->g);
    oc = off % (p->oc / p->g); off /= (p->oc / p->g);
    g = off % p->g; off /= p->g;
    assert(off == 0);
}

inline size_t bia_off_f(const prb_t *p, int g, int oc) {
    return (size_t)g * p->oc / p->g + oc;
}

/** occasionally it is useful [ex memset loops] to get largest possible
 * loop ranges by ignoring the loop over groups.
 *
 * When \c p->g groups is one, these are called "full" convolutions.
 * Groups segregate channels and saves parameters by *reuse* weights.
 * mkl-dnn (and most other implementations) assume the number of channels
 * is perfectly divisible by the groups.
 *
 * \code
 * 1. for (int g = 0; g < p->g; ++g)
 *   2. for (int oc = 0; oc < p->oc/p->g; ++oc)
 *     3. for (int ic = 0; ic < p->ic/p->g; ++ic)
 *       ... kh, kw, mb, oh, ow ...
 *       foo(   dst/src/bia(... g, ...)   );
 * \endcode
 * get transformed into possibly larger ranges as:
 * \code
 *   1. for (int oc = 0; oc < p->oc; ++oc)
 *     2. for (int ic = 0; ic < p->ic; ++ic)
 *       ... kh, kw, mb, oh, ow ...
 *       foo( dst/src/bia_nog( ... ); // *no* g
 * \endcode
 */
inline size_t bia_off_f_nog(const prb_t *p, /*int g,*/ int oc) {
    return (size_t)oc;
}

inline void zero_bia( const prb_t *p, dnn_mem_t const& bia_m ){
#if 0
    // bia_off_f_nog is just a single for-loop, so assume bia is dense
    // (I suppose it might be longer, but this is still likely fastest way)
    memset( (float*)bia_m, 0, bia_m.size() );
#else
    for (int oc=0; oc < p->oc; ++oc) {
        size_t bia_off = bia_off_f_nog(p, oc);
        float &db = ((float*)bia_m)[bia_off];
        db = 0;
    }
#endif
} 

inline void inv_bia_off_f(const prb_t *p, size_t off, int &g, int &oc) {
    oc = off % (p->oc / p->g); off /= (p->oc / p->g);
    g = off % p->g; off /= p->g;
    assert(off == 0);
}

inline size_t dst_off_f(const prb_t *p, int mb, int g, int oc, int oh, int ow)
{
    return (((size_t)mb * p->oc + g * p->oc/p->g + oc) * p->oh + oh) * p->ow
        + ow;
}

inline size_t dst_off_f_nog(const prb_t *p, int mb, /*int g,*/ int oc, int oh, int ow)
{
    // with no group, oc itself has full range of 0..p->oc
    //                            vvvvvvvvvvvvvvv
    //return (((size_t)mb * p->oc + g*p->oc/p->g+oc) * p->oh + oh) * p->ow + ow;
    return (((size_t)mb * p->oc + oc) * p->oh + oh) * p->ow + ow;
}
/** no group-loop + merge oh- and ow-loops into ohw in p->oh*p->ow */
inline size_t dst_off_f_nog_ohw(const prb_t *p, int mb, /*int g,*/ int oc, int ohw)
{
    //return (((size_t)mb * p->oc + oc) * p->oh + oh) * p->ow + ow;
    //  ohw runs through all values oh*p->ow + ow
    //return ((size_t)mb * p->oc + oc) * p->oh * p->ow   +   oh * p->ow + ow;
    return ((size_t)mb * p->oc + oc) * p->oh * p->ow   +   ohw;
}
inline void inv_dst_off_f(const prb_t *p, size_t off, int &mb, int &g, int &oc,
        int &oh, int &ow) {
    ow = off % p->ow; off /= p->ow;
    oh = off % p->oh; off /= p->oh;
    oc = off % (p->oc / p->g); off /= (p->oc / p->g);
    g = off % p->g; off /= p->g;
    mb = off % p->mb; off /= p->mb;
    assert(off == 0);
}

typedef void (*conv_fwd_fn)   (const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m);
typedef void (*conv_bwd_d_fn) (const prb_t *p, dnn_mem_t &diff_src_m,
        dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
typedef void (*conv_bwd_w_fn )(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m);

#define COMPUTE_REF_DECL( PFX ) \
extern void PFX##_fwd   (const prb_t *p, dnn_mem_t &src_m, dnn_mem_t &wei_m, \
                         dnn_mem_t &bia_m, dnn_mem_t &dst_m); \
extern void PFX##_bwd_d (const prb_t *p, dnn_mem_t &diff_src_m, dnn_mem_t &wei_m, \
                         dnn_mem_t &diff_dst_m); \
extern void PFX##_bwd_w (const prb_t *p, dnn_mem_t &src_m, dnn_mem_t &diff_wei_m, \
                         dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m);
COMPUTE_REF_DECL( compute_ref ) /* ref_conv.cpp */
COMPUTE_REF_DECL( refconv_2 )   /* ref_conv2.cpp */
COMPUTE_REF_DECL( refconv_3 )   /* ref_conv3.cpp */
COMPUTE_REF_DECL( refconv_4 )   /* ref_conv4.cpp */
COMPUTE_REF_DECL( refconv_5 )   /* ref_conv4.cpp */
COMPUTE_REF_DECL( refconv_99 )   /* ref_conv99.cpp */
#if defined(_SX)
COMPUTE_REF_DECL( sxconv_3 )   /* ref_conv3.cpp */
#endif

typedef struct {
    char const*   name;
    conv_fwd_fn   fwd;
    conv_bwd_d_fn bwd_d;
    conv_bwd_w_fn bwd_w;
} conv_impls_t;
/** list of TEST mode convolution impls.
 * TEST mode is distinct from bench_mode 'A', which runs **all** mkl-dnn impls.
 *
 * We expect to investigate convolutions in 'T'est mode, and if they are fast and
 * correct move them to mkl-dnn (and comment them out of general use in benchdnn).
 *
 * \sa bench_mode.
 */
conv_impls_t * get_ref_impls();
size_t constexpr get_nref_impls() { return 5U; }

void perf_report(const prb_t *p, const res_t *r, const char *pstr, const char *impl=nullptr);

bool maybe_skip(const char *impl_str);
int doit(const prb_t *p, res_t *res);
int bench(int argc, char **argv, bool main_bench = true);

}

// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
#endif
