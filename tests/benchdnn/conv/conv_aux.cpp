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

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <math.h>

#include "mkldnn.h"

#include "mkldnn_common.hpp"
#include "mkldnn_debug.hpp"
#include "conv/conv.hpp"
#include "../idiv.hpp"

#include <cstdarg>

#if defined(_SX) /* missing function */
static size_t strnlen(const char *s, size_t max_len)
{
    size_t i = 0;
    for(; (i < max_len) && s[i]; ++i);
    return i;
}
#elif defined(SXAURORA)
#define strnlen strnlen_s
#endif

namespace conv {

alg_t str2alg(const char *str) {
#define CASE(_alg) if (!strcasecmp(STRINGIFY(_alg), str)) return _alg
    CASE(DIRECT);
    CASE(WINO);
#undef CASE
    assert(!"unknown algorithm");
    printf("--alg=%s unknown, assuming DIRECT\n", str);
    return DIRECT;
}

const char *alg2str(alg_t alg) {
    if (alg == DIRECT) return "direct";
    if (alg == WINO) return "wino";
    assert(!"unknown algorithm");
    return "unknown algorithm";
}

merge_t str2merge(const char *str) {
#define CASE(_mrg) if (!strcasecmp(STRINGIFY(_mrg), str)) return _mrg
    CASE(NONE);
    CASE(RELU);
#undef CASE
    assert(!"unknown merge");
    return NONE;
}


const char *merge2str(merge_t merge) {
    if (merge == NONE) return "none";
    if (merge == RELU) return "relu";
    assert(!"unknown merge");
    return "unknown merge";
}

static inline int compute_out(int i, int k, int s, int p, int d) {
    const int A = i - ((k-1) * (d+1) + 1);
    return (A + 2 * p) / s + 1;
    // padding left + right, so 2*p
};

// (i - ((k-1)*(d+1)+1) + 2*p) /s +1 >= o   (equality may not be possible)
//  i - ((k-1)*(d+1)+1) + 2*p  >= (o-1)*s
//                        2*p  >= (o-1)*s - i + ((k-1)*(d+1)+1)
//                          p  >= ((o-1)*s - i + ((k-1)*(d+1)+1)   +1   ) / 2
static int compute_pad(int o, int i, int k, int s, int d) {
//    if 2A >= B, if B is even, all is fine.
//                if B is odd, want A = (B+1)/2
//    so we correct the old formula ...
    const int A = i - ((k-1) * (d+1) + 1);
    const int top = (o-1)*s - A; 
#if 0 // perhaps safer?
    int ret = (top+1)/2; // round UP
    int ret0 = div_floorx(top+1, 2); 
    if ( (A+2*ret)/s+1 < o ) ++ret0;  // explicit verification that consistent o is >=
    RT_ASSERT( ret == ret0 );
#else // should still work, depending on how careful str2desc fixups are
    int ret = (top)/2;   // rounded-down padding
#endif
    return ret;
};

void dbg_out(int i, int k, int s, int p, int d, int o){
    print(0, " o = ([i=%d] - [k-1,d+1](%d*%d+1) + (2p=%d) / %d + 1\n"
          "    = (%d+ (2p=%d)) / %d + 1\n"
          "    = %d, with pad of %d\n",
          i, k-1, d+1, 2*p, s,
          i - ((k-1)*(d+1)+1), 2*p, s,
          (i - ((k-1)*(d+1)+1) + 2*p) / s + 1, p
         );
}

int str2desc(desc_t *desc, const char *str) {
    desc_t d{0};

    /* canonical form:
     * dYgXmbXicXihXiwXocXohXowXkhXkwXshXswXphXpwXdhXdwXnS
     *
     * where: Y = {fb, fd, bd, bw, bb}, X is number, S - string
     * note: symbol `_` is ignored
     *
     * implicit rules:
     *  - default values:
     *      mb = 2, g = 1, d = fd, sh = sw = 1, dh = dw = 0, S="wip"
     *  - if H is undefined => H = W
     *  - if W is undefined => W = H
     *  - if `output` is undefined => compute output
     *  - if padding is undefined => compute trivial padding
     */

    d.g = 1; d.mb = 2; d.sh = d.sw = 1; d.dh = d.dw = 0;
    d.name = "\"wip\"";

    auto fail = [&](char const* fmt, ...){
        const int len = 256;
        char buf[len];
        char *b = &buf[0];
        int l = len;
        int o = snprintf(b, l, " str2desc: %s\n"
                /*          */ "           ", str);
        b += o; l -= o;
        va_list args;
        va_start(args, fmt);
        o = vsnprintf(b, l, fmt, args);
        //b += o; l -= o;
        va_end(args);
        print(0,"%s\n",buf);
        return FAIL;
    };

    const char *s = str;
    assert(s);

#   define CASE_NN(p, c) do { \
        if (!strncmp(p, s, strlen(p))) { \
            ok = 1; s += strlen(p); \
            char *end_s; d. c = static_cast<int>(strtol(s, &end_s, 10)); s += (end_s - s); \
            /* printf("@@@debug: %s: %d\n", p, d. c); */ \
        } \
    } while (0)
#   define CASE_N(c) CASE_NN(#c, c)
    while (*s) {
        int ok = 0;
        CASE_N(g); CASE_N(mb);
        CASE_N(ic); CASE_N(ih); CASE_N(iw);
        CASE_N(oc); CASE_N(oh); CASE_N(ow);
        CASE_N(kh); CASE_N(kw);
        CASE_N(sh); CASE_N(sw);
        CASE_N(ph); CASE_N(pw);
        CASE_N(dh); CASE_N(dw);
        if (*s == 'n') { d.name = s + 1; break; }
        if (*s == '_') ++s;
        if (!ok) return fail("unparsed desc is %s\n", s);
    }
#   undef CASE_NN
#   undef CASE_N

    if (d.ic < 1 || d.oc < 1) return fail(" need ic, oc > 0");
    if (d.sh < 1 || d.sw < 1) return fail(" need sh, sw > 0");
    if (d.oc % d.g != 0) return fail(" oc must be a multiple of g");

    const bool no_h = (d.ih | d.kh | d.oh | d.ph | d.dh) == 0 && d.sh == 1;
    const bool no_w = (d.iw | d.kw | d.ow | d.pw | d.dw) == 0 && d.sw == 1;

    bool strange = false;

    //print(0, "INIT:  i,k,s,p,d %d,%d,%d,%d,%d, oh=%d\n", d.ih, d.kh, d.sh, d.ph, d.dh, d.oh );
    if (!no_h) {
        // Force user to fix nonsense spec strings
        if (!d.ih || !d.kh ) return FAIL;                      // required!
        if ( d.sh<1 || d.ih<0 || d.oh<0 || d.ph<0 )
            return fail(" range! sh%d_ih%d_oh%d_ph%d\n", d.sh,d.ih,d.oh,d.ph);
        if (d.oh<=0) // illegal/unset
            d.oh = compute_out(d.ih, d.kh, d.sh, d.ph, d.dh);
        if (d.oh<=0){ // illegal/unset (may be -ve because of too-low pad?)
            int tgt_out = (d.oh > 0? d.oh: 1);
            int tgt_pad = compute_pad(tgt_out, d.ih, d.kh, d.sh, d.dh);
            if (d.ph < tgt_pad) { // oh-oh.  ++padding to get to tgt_oh
                d.oh = tgt_out;
                d.ph = tgt_pad;
            }
        }
        if (!d.ph && d.oh < compute_out(d.ih, d.kh, d.sh, d.ph, d.dh)){
            d.ph = compute_pad(d.oh, d.ih, d.kh, d.sh, d.dh);
        }
    }

    if (!no_w) {
        if (!d.iw || !d.kw) return FAIL;
        if ( d.sh<1 || d.ih<0 || d.oh<0 || d.ph<0 ){
            return fail(" range! sw%d_iw%d_ow%d_pw%d\n", d.sw,d.iw,d.ow,d.pw);
        }
        if (d.ow<=0) // illegal/unset
            d.ow = compute_out(d.iw, d.kw, d.sw, d.pw, d.dw);

            int tgt_out = (d.ow > 0? d.ow: 1);
            int tgt_pad = compute_pad(tgt_out, d.iw, d.kw, d.sw, d.dw);
            if (d.pw < tgt_pad) { // oh-oh.  ++padding to get to tgt_ow
                d.ow = tgt_out;
                d.pw = tgt_pad;
            }
        if (!d.pw && d.ow != compute_out(d.iw, d.kw, d.sw, d.pw, d.dw))
            d.pw = compute_pad(d.ow, d.iw, d.kw, d.sw, d.dw);
    }

    if (no_w) {
        d.iw = d.ih;
        d.kw = d.kh;
        d.ow = d.oh;
        d.pw = d.ph;
        d.sw = d.sh;
        d.dw = d.dh;
    } else if (no_h) {
        d.ih = d.iw;
        d.kh = d.kw;
        d.oh = d.ow;
        d.ph = d.pw;
        d.sh = d.sw;
        d.dh = d.dw;
    }

    // patch things to consistency a bit more
    int ddow = compute_out(d.iw, d.kw, d.sw, d.pw, d.dw);
    int ddoh = compute_out(d.ih, d.kh, d.sh, d.ph, d.dh);
    if( d.ow < ddow ) d.ow = ddow; // allow making output bigger
    if( d.oh < ddoh ) d.oh = ddoh;
    if( d.ow < 1 ) d.ow = 1;
    if( d.oh < 1 ) d.oh = 1;
    strange = strange || (ddow > d.ow || ddoh > d.oh || d.ow <= 0 || d.oh <= 0);
#ifndef NDEBUG
    if (0 || strange){
        if (strange) print(0," %s\n", "STRANGE");
        print(0, "       i,k,s,p,d %d,%d,%d,%d,%d -> oh=%d, but have d.oh=%d\n",
              d.ih, d.kh, d.sh, d.ph, d.dh, ddoh, d.oh );
        print(0, "       i,k,s,p,d %d,%d,%d,%d,%d -> ow=%d, but have d.ow=%d\n",
              d.iw, d.kw, d.sw, d.pw, d.dw, ddow, d.ow );
        print(0, " ow = ([ih=%d] - [k-1,d+1](%d*%d+1) + (2p=%d) / %d + 1\n"
              "    = %d / %d + 1\n",
              d.iw, d.kw-1, d.dw+1, 2*d.pw, d.sw,
              d.iw - ((d.kw-1)*(d.dw+1)+1), d.sw );
        print(0, "       i,k,s,p,d %d,%d,%d,%d,%d -> oh=%d\n",
              d.ih, d.kh, d.sh, d.ph, d.dh, d.oh );
    }
#endif

    if( strange ){
        printf("Error: Tried to make things consistent,"
               " but still bad output width/height\n");
        printf("       i,k,s,p,d %d,%d,%d,%d,%d -> ow=%d\n",
               d.iw, d.kw, d.sw, d.pw, d.dw, d.ow );
        printf("       i,k,s,p,d %d,%d,%d,%d,%d -> oh=%d\n",
               d.ih, d.kh, d.sh, d.ph, d.dh, d.oh );
        return FAIL;
    }

    *desc = d;
    return OK;
}

void desc2str(const desc_t *d, char *buffer, bool canonical) {
    int rem_len = max_desc_len;
#   define DPRINT(...) do { \
        int l = snprintf(buffer, rem_len, __VA_ARGS__); \
        buffer += l; rem_len -= l; \
    } while(0)

    if (canonical || d->g != 1) DPRINT("g%d", d->g);
    if (canonical || d->mb != 2) DPRINT("mb%d", d->mb);

    const bool half_form = d->ih == d->iw && d->kh == d->kw && d->oh == d->ow
        && d->sh == d->sw && d->ph == d->pw && d->dh == d->dw;

    if (!canonical && half_form) {
        DPRINT("ic%dih%doc%doh%dkh%d", d->ic, d->ih, d->oc, d->oh, d->kh);
        if (d->sh != 1) DPRINT("sh%d", d->sh);
        if (d->ph != 0) DPRINT("ph%d", d->ph);
        if (d->dh != 0) DPRINT("dh%d", d->dh);
    } else {
        DPRINT("ic%dih%diw%doc%doh%dow%dkh%dkw%d",
                d->ic, d->ih, d->iw, d->oc, d->oh, d->ow, d->kh, d->kw);
        if (canonical || d->sh != 1 || d->sw != 1)
            DPRINT("sh%dsw%d", d->sh, d->sw);
        if (canonical || d->ph != 0 || d->sh != 0)
            DPRINT("ph%dpw%d", d->ph, d->pw);
        if (canonical || d->dh != 0 || d->dw != 0)
            DPRINT("dh%ddw%d", d->dh, d->dw);
    }

    DPRINT("n%s", d->name);

#   undef DPRINT
}

void prb_t::count_ops() {
    if (ops > 0) return;

    double sp_ops = 0;
    for (int oh = 0; oh < this->oh; ++oh) {
    for (int ow = 0; ow < this->ow; ++ow) {
        for (int kh = 0; kh < this->kh; ++kh) {
            const int ih = oh * this->sh - this->ph + kh * (this->dh + 1);
            if (ih < 0 || ih >= this->ih) continue;
            for (int kw = 0; kw < this->kw; ++kw) {
                const int iw = ow * this->sw - this->pw + kw * (this->dw + 1);
                if (iw < 0 || iw >= this->iw) continue;
                sp_ops += 1;
            }
        }
    }
    }

    ops = 2 * this->mb * this->oc * this->ic / this->g * sp_ops;
    //print(0, " ops=%f\n",ops);
}

void prb_t::generate_oscales() {
    if (attr.oscale.policy != attr_t::scale_t::policy_t::PER_OC) return;

    scales = (float *)zmalloc(sizeof(float) * oc, 64);
    SAFE_V(scales != NULL ? OK : FAIL);

    const float K = 32;
    /* scale in [1/K .. K], with starting point at oscale.scale */
    float s[2] = {attr.oscale.scale, attr.oscale.scale/2};
    for (int i = 0; i < oc; ++i) {
        int si = i % 2; // 0 -> left, 1 -> right
        scales[i] = s[si];
        if (si == 0) {
            s[si] /= 2.;
            if (s[si] < 1./K) s[si] *= K*K; // turn around to become ~K
        } else {
            s[si] *= 2.;
            if (s[si] > K) s[si] /= K*K; // turn around to become ~K
        }
    }
}

void prb2str(const prb_t *p, char *buffer, bool canonical) {
    char desc_buf[max_desc_len], attr_buf[max_attr_len];
    char dir_str[32] = {0}, cfg_str[32] = {0}, alg_str[32] = {0},
         merge_str[32] = {0};
    desc2str(p, desc_buf, canonical);
    snprintf(dir_str, sizeof(dir_str), "--dir=%s ", dir2str(p->dir));
    snprintf(cfg_str, sizeof(cfg_str), "--cfg=%s ", cfg2str(p->cfg));
    snprintf(alg_str, sizeof(alg_str), "--alg=%s ", alg2str(p->alg));
    snprintf(merge_str, sizeof(merge_str), "--merge=%s ", merge2str(p->merge));
    bool is_attr_def = p->attr.is_def();
    if (!is_attr_def) {
        int len = snprintf(attr_buf, max_attr_len, "--attr=\"");
        attr2str(&p->attr, attr_buf + len);
        len = (int)strnlen(attr_buf, max_attr_len);
        snprintf(attr_buf + len, max_attr_len - len, "\" ");
    }
    snprintf(buffer, max_prb_len, "%s%s%s%s%s%s",
            p->dir == FWD_B ? "" : dir_str,
            p->cfg == conf_f32 ? "" : cfg_str,
            p->alg == DIRECT ? "" : alg_str,
            p->merge == NONE ? "" : merge_str,
            is_attr_def ? "" : attr_buf,
            desc_buf);
}

}
// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
