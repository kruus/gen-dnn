/*******************************************************************************
* Copyright 2017 NEC Laboratories America
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
 * no lambda parms by reference, test_conv_regression avg speedup = 1.557 x */
#include "conv/conv.hpp"

#define G  p->g
#define MB p->mb
#define IC p->ic
#define OC p->oc

#define KH p->kh
#define IH p->ih
#define OH p->oh
#define SH p->sh
#define PH p->ph

#define KW p->kw
#define IW p->iw
#define OW p->ow
#define SW p->sw
#define PW p->pw

namespace conv {

// no effect for x86+gcc
//#define IVDEPx()
#define IVDEPx() IVDEP()

extern void compute_ref_fwd(const prb_t *p, dnn_mem_t &src_m,
        dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m);

void refconv_2_fwd(const prb_t *p, dnn_mem_t &src_m,
                   dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
    //char attr_buf[max_attr_len];
    //attr2str(&p->attr, attr_buf);
    //print(40,__FILE__ " fwd p->attr is %s\n", attr_buf);
  auto ker = []( const prb_t *p, const float * restrict psrc, const float * restrict pwei,
                 float &d, int g, int mb, int oc, int oh, int ow) {
    for (int ic = 0; ic < IC/G; ++ic) {
      for (int kh = 0; kh < KH; ++kh) {
        const int ih = oh * SH - PH + kh * (p->dh + 1);
        if (ih < 0 || ih >= IH) continue;

        IVDEPx()//;
        for (int kw = 0; kw < KW; ++kw) {
          const int iw = ow * SW - PW + kw * (p->dw + 1);
          if (iw < 0 || iw >= IW) continue;

          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          //d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
          d += psrc[src_off] * pwei[wei_off];
        }
      }
    }
  };
  auto maybe_scale = [](const prb_t *p, float &d, int oc) {
    if (!p->attr.oscale.is_def()) {
      using policy_t = attr_t::scale_t::policy_t;
      const auto &s = p->attr.oscale;
      if (s.policy == policy_t::COMMON) {
        d *= s.scale;
      } else {
        d *= p->scales[oc];
      }
    }
  };
  auto maybe_post_ops = [](const prb_t *p, float &d, float const dst) {
    const auto &ops = p->attr.post_ops;
    for (int idx = 0; idx < ops.len; ++idx) {
      using pk = attr_t::post_ops_t::kind_t;
      const auto &e = ops.entry[idx];
      switch (e.kind) {
        case pk::SUM:
          d += e.sum.scale * dst;
          break;
        case pk::RELU:
          d = e.eltwise.scale * (d < 0 ? 0 : d);
          break;
        default:
          assert(!"unknown attr::post_ops::kind");
      }
    }
  };
  const float* restrict const psrc = (float*)src_m;
  const float* restrict const pwei = (float*)wei_m;
  const float* restrict const pbia = (float*)bia_m;
  /* */ float* restrict const pdst = (float*)dst_m;
  OMP(parallel for collapse(5))//;
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int oc = 0; oc < OC/G; ++oc) {
        for (int oh = 0; oh < OH; ++oh) {
          for (int ow = 0; ow < OW; ++ow) {
            const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);

            float conv_res = 0;
            ker(p, psrc, pwei, conv_res, g, mb, oc, oh, ow);

            if (p->dir & FLAG_BIA) {
              const size_t bia_off = bia_off_f(p, g, oc);
              conv_res += pbia[bia_off];
            }

            if (p->merge == RELU && conv_res < 0)
              conv_res = 0;

            maybe_scale(p, conv_res, g * OC / G + oc);
            float &dst = pdst[dst_off];
            maybe_post_ops(p, conv_res, dst);

            pdst[dst_off] = conv_res;
          }
        }
      }
    }
  }
}

enum sz { precompute_size = 16 };

/* pre-computes arrays of oh(ow) and kh(kw) for traversing in kernel */
static inline void precompute_ok(int i, int O, int K, int S, int P, int D,
        int &num, int *_o, int *_k) {
  assert(K <= precompute_size);
  num = 0;
#pragma _NEC loop_count(precompute_size)
  for (int k = 0; k < K; ++k) { // nvc++ DOES vectorize this.  not gcc.
#if 0 // original
      int o = i - k * (D + 1) + P;
      if (o < 0 || o % S) continue;
      o /= S;
      if (o >= O) continue;
      _k[num] = k;
      _o[num] = o;
      ++num;
#else // avoid % because simd remainder might not exist
    int oi = i - k * (D + 1) + P;
    int o = oi / S;
    //if (o < 0 || o % S) continue; // this modification is very nice for nc++
    //if (o >= O) continue;
    if (oi < 0 || o >= O || oi != o*S) continue;
    _k[num] = k;
    _o[num] = o;
    ++num;         // nobody seems to generate a vgather here.
#endif
  }
};
#if 1 // see what gcc vectorizes (and what it does NOT!!!)
// this code is not even correct. but that's ok for now.
// This code gives nc++ MORE trouble thant the precompute_ok, above !
void precompute_ok2(int i, int O, int K, int S, int P, int D,
        int &num, int *_o, int *_k) {
  assert(K <= precompute_size);
  //alignas(16) float oo    [precompute_size];
  alignas(16) int oo    [precompute_size];
  alignas(16) int ooS   [precompute_size];
  alignas(16) int ooi   [precompute_size];
  //alignas(16) int gather[precompute_size] = {0}; // gcc does NOT like vectorizing with 'bool foo[]'
  alignas(16) bool gather[precompute_size] = {0}; // gcc does NOT like vectorizing with 'bool foo[]'
  //alignas(16) int gattmp[precompute_size] = {0};
  alignas(16) int kk    [precompute_size];
  //alignas(16) signed char ix [precompute_size];
  alignas(16) int ix [precompute_size];
  VREG(oo) VREG(ooS) VREG(ooi) VREG(gather) VREG(kk) VREG(ix)
#if 0
  for (int k = 0; k < precompute_size; ++k) kk[k] = k;
  OMPSIMD()//;
  IVDEP()
  for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
      oo[k] = (P + i) - k * (D+1);
      ooi[k] = (int)oo[k];
      //oo[k] = (oo[k]+S-1) * (float)(1.0/S);
      oo[k] = oo[k] / S;
      ooS[k] = ooi[k] * S; // tmp
      gather[k] = (ooi[k] >= 0 && ooi[k] < O && ooS[k] == ooi[k]);
  }
  // xform mask into gather indices 'ooS'
  int cnt = 0;
  IVDEP()//;
  for (ssize_t k = 0; k < 16; ++k) {
      if (gather[k]) {
          ix[cnt++] = k;
      }
  }
  num = cnt; // do not know how to force gather with gcc.
  if (cnt) {
      OMPSIMD(aligned(_o:16))//;
      IVDEP()//;
      for (size_t k = 0; k < 16; ++k) {
          _o[k] = (gather[k]? ooi[ix[k]]: 0);
          //gather[k] = gather[k] << 31;
          //gather[k] = gather[k] >> 31;
          //ooS[k] = ~0;
          //ooS[k] = (gather[k]? ooS[k]: 0);
          //if (gather[k]) _o[k] = ooi[ix[k]]; // gcc:NO
          //_o[k] = (ooS[k]? ooi[ix[k]]: 0);
      }
      OMPSIMD(aligned(_k:16))//;
      for (int k = 0; k < 16; ++k) {
          _k[k] = (gather[k]? kk[ix[k]]: 0);
          //if (gather[k]) _k[k] = kk[ix[k]]; // gcc:NO
      }
  }
#else
  int cnt = 0;
  OMPSIMD()//;
  IVDEP()//;
  for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
    kk[k] = k;
    ooi[k] = (P + i) - k * (D+1);
    //ooi[k] = (int)oo[k];
    //oo[k] = (oo[k]+S-1) * (float)(1.0/S);
    oo[k] = ooi[k] / S;
    ooS[k] = ooi[k] * S; // tmp
    gather[k] = (ooi[k] >= 0 && ooi[k] < O && ooS[k] == ooi[k]);
  }
#if 0
  OMPSIMD()//;
  IVDEP()//;
  for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
    if (gather[k]) _o[cnt] = ooi[k];
    if (gather[k]) _k[cnt] = kk[k];
    if (gather[k]) ++cnt;
  }
#elif 1
  for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
    if (gather[k])
      ix[cnt++] = k;
  }
  OMPSIMD(aligned(_o:16))//;
  IVDEP()//;
  ShortLoop() for (size_t i = 0; i < cnt; ++i) { // nc++ still no gather ?
    const int ii = ix[i];
    _o[i] = (gather[ii]? ooi[ii]: 0);
  }
  ShortLoop() for (size_t i = 0; i < cnt; ++i) {
    _k[i] = (gather[ix[i]]? kk[ix[i]]: 0);
  }
#elif 0
  for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
    if (gather[k]) {
      _o[cnt] = ooi[k];
      _k[cnt] = kk[k];
      ++cnt;
    }
  }
#endif
  num = cnt; // do not know how to force gather with gcc.
#endif
#if 0
  for (int k = 0; k < K; ++k) {
    int o = i - k * (D + 1) + P;
    if (o < 0 || o % S) continue;
    o /= S;
    if (o >= O) continue;
    _k[num] = k;
    _o[num] = o;
    ++num;
  }
#endif
};
#endif
#if 0
static inline void precompute_k(int i, int O, int K, int S, int P, int D,
                                 int &num, int *_k) {
#if 0
    num = 0;
    int kh_end = (ih + PH) / DH + 1;
    if (kh_end > KH) kh_end = KH;
    int kh_beg = kh_end;
    if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
        int const mul = (ih+PH) / gcd_h;
        kh_beg = ha*mul;
        int m = div_floor(kh_beg, khh);
        kh_beg -= m * khh;
        int j = hb * mul + m * jhh; // var j --> 'm' again
        if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
    }
    for (int k = kh_beg; k < kh_end; k += khh)
        _k[num++] = k;
#else
  num = 0;
  for (int k = 0; k < K; ++k) {
    int o = i - k * (D + 1) + P;
    if (o < 0 || o % S) continue;
    o /= S;
    if (o >= O) continue;
    _k[num] = k;
    //_o[num] = o;
    ++num;
  }
#endif
}
#endif

void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
                     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
  const bool fast = MAX2(KH, KW) <= precompute_size;
  float       * restrict const pdiff_src = (float*)diff_src_m;
  float const * restrict const pwei = (float*)wei_m;
  //float const * restrict const pbia = (float*)bia_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;

  auto ker_fast = [](const prb_t* p, const enum sz precompute_size,
                     const float* pdiff_dst, const float* pwei,
                     float &ds, int g, int mb, int ic, int ih, int iw) {
#if 1
    // after reflection, this might be decently fast.
    // next opt might be to use more mem and precompute kh_beg[ih] pre-OMP.
    alignas(16) int kh[precompute_size];
    alignas(16) int oh[precompute_size];
    alignas(16) int kw[precompute_size];
    alignas(16) int ow[precompute_size];
    int num_h, num_w;
    precompute_ok(ih, OH, KH, SH, PH, p->dh, num_h, oh, kh);
    //precompute_ok2(ih, OH, KH, SH, PH, p->dh, num_h, oh, kh);
    precompute_ok(iw, OW, KW, SW, PW, p->dw, num_w, ow, kw);
#elif 2
    // after reflection, this might be decently fast.
    // next opt might be to use more mem and precompute kh_beg[ih] pre-OMP.
    int kh[precompute_size], oh[precompute_size], num_h;
    int kw[precompute_size], ow[precompute_size], num_w;
    precompute_ok2(ih, OH, KH, SH, PH, p->dh, num_h, oh, kh);
    precompute_ok2(iw, OW, KW, SW, PW, p->dw, num_w, ow, kw);
#else
    // ouch.
    int kh[precompute_size];
    int oh[precompute_size];
    int kw[precompute_size];
    int ow[precompute_size];
    int num_w, num_h;
    precompute_k(ih, OH, KH, SH, PH, p->dh, num_h, kh); // use formula
    precompute_k(ih, OH, KH, SH, PH, p->dh, num_h, kh); // use formula
    int oh0 = (ih + PH - kh[0] * DH ) / SH;
    for (int h=0; h<num_h; ++h) {
        // linear, decrements by lcm_h/SH == DH/gcd_h == jhh
        //oh[h] = (ih + PH - kh[h] * DH) / SH;
        oh[h] = oh0 - h * jhh;
    }
    for (int w=0; w<num_w; ++w)
        ow[w] = iw + PW - kw[w] * DW; // linear, decrements by lcm_w
#endif

    IVDEPx() for (int oc = 0; oc < OC/G; ++oc) {
      for (int h = 0; h < num_h; ++h) {
        IVDEPx()//;
        for (int w = 0; w < num_w; ++w) {
          size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh[h], kw[w]);
          ds += pdiff_dst[dst_off] * pwei[wei_off];
        }
      }
    }
  };

  auto ker = [](const prb_t* p, float const* pdiff_dst, float const* pwei,
                float &ds, int g, int mb, int ic, int ih, int iw) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int kh = 0; kh < KH; ++kh) {
        int oh = ih - kh * (p->dh + 1) + PH;
        if (oh < 0 || oh % SH) continue;
        oh /= SH;
        if (oh >= OH) continue;

        IVDEPx() for (int kw = 0; kw < KW; ++kw) {
          int ow = iw - kw * (p->dw + 1) + PW;
          if (ow < 0 || ow % SW) continue;
          ow /= SW;
          if (ow >= OW) continue;

          size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
          size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
          ds += pdiff_dst[dst_off] * pwei[wei_off];
        }
      }
    }
  };

  OMP(parallel for collapse(5))//;
  for (int g = 0; g < G; ++g) {
    for (int mb = 0; mb < MB; ++mb) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int ih = 0; ih < IH; ++ih) {
          for (int iw = 0; iw < IW; ++iw) {
            size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
            float &ds = pdiff_src[src_off];
            ds = 0;
            if (fast)
              ker_fast(p, precompute_size, pdiff_dst, pwei,
                       ds, g, mb, ic, ih, iw);
            else
              ker(p, pdiff_dst, pwei, ds, g, mb, ic, ih, iw);
          }
        }
      }
    }
  }
}

static inline void compute_bounds(int I, int O, int k, int S, int P, int D,
        int &o_s, int &o_e) {
  const float tmp = P - k * (D + 1);
  o_s = MAX2(0, ceilf(tmp / S));
  o_e = MIN2(O, ceilf((I + tmp) / S));
};

void refconv_2_bwd_w(const prb_t *p, dnn_mem_t &src_m,
                     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {

  float const * restrict const psrc      = (float*)src_m;
  float const * restrict const pdiff_dst = (float*)diff_dst_m;
  float       * restrict const pdiff_wei = (float*)diff_wei_m;
  float       * restrict const pdiff_bia = (float*)diff_bia_m;
  auto ker = []( const prb_t *p,
                 const float * restrict pdiff_dst, const float* restrict psrc,
                 float &dw, int g, int oc, int ic, int kh, int kw) {
    int oh_s, oh_e, ow_s, ow_e;
    compute_bounds(IH, OH, kh, SH, PH, p->dh, oh_s, oh_e);
    compute_bounds(IW, OW, kw, SW, PW, p->dw, ow_s, ow_e);

    for (int mb = 0; mb < MB; ++mb) {
      for (int oh = oh_s; oh < oh_e; ++oh) {
        IVDEPx()//;
        for (int ow = ow_s; ow < ow_e; ++ow) {
          const int ih = oh * SH - PH + kh * (p->dh + 1);
          const int iw = ow * SW - PW + kw * (p->dw + 1);

          size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
          size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
          dw += pdiff_dst[dst_off] * psrc[src_off];
        }
      }
    }
  };

  OMP(parallel for collapse(5))//;
  for (int g = 0; g < G; ++g) {
    for (int oc = 0; oc < OC/G; ++oc) {
      for (int ic = 0; ic < IC/G; ++ic) {
        for (int kh = 0; kh < KH; ++kh) {
          for (int kw = 0; kw < KW; ++kw) {
            size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
            float &dw = pdiff_wei[wei_off];
            dw = 0;
            ker( p, pdiff_dst, psrc, dw, g, oc, ic, kh, kw);
          }
        }
      }
    }
  }

  if (!(p->dir & FLAG_BIA)) return;

  OMP(parallel for collapse(2))//;
  for (int g = 0; g < G; ++g) {
    for (int oc = 0; oc < OC/G; ++oc) {
      size_t bia_off = bia_off_f(p, g, oc);
      float &db = pdiff_bia[bia_off];
      db = 0;

      for (int mb = 0; mb < MB; ++mb) {
        for (int oh = 0; oh < OH; ++oh) {
          for (int ow = 0; ow < OW; ++ow) {
            const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
            db += pdiff_dst[dst_off];
            //db += pdiff_dst[dst_off_f(p, mb, g, oc, oh, ow)];
          }
        }
      }
    }
  }
}

}
// vim: et ts=2 sw=2 cindent cino=^=l0,\:0,N-s
