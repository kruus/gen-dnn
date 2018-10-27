   1              		.ident "nc++ 1.5.2 (Build 11:19:31 Oct  2 2018)"
   2              		.file "sx_conv2.cpp"
   3              		.file 1 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp"
   4              		.file 2 "/opt/nec/ve/ncc/1.5.2/include/stdc-predef.h"
   5              		.file 3 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/conv.hpp"
   6              		.file 4 "/opt/nec/ve/ncc/1.5.2/include/stdint.h"
   7              		.file 5 "/opt/nec/ve/ncc/1.5.2/include/yvals.h"
   8              		.file 6 "/opt/nec/ve/ncc/1.5.2/include/necvals.h"
   9              		.file 7 "/opt/nec/ve/ncc/1.5.2/include/stdarg.h"
  10              		.file 8 "/opt/nec/ve/musl/include/stdint.h"
  11              		.file 9 "/opt/nec/ve/musl/include/bits/alltypes.h"
  12              		.file 10 "/opt/nec/ve/musl/include/bits/stdint.h"
  13              		.file 11 "/opt/nec/ve/musl/include/limits.h"
  14              		.file 12 "/opt/nec/ve/musl/include/features.h"
  15              		.file 13 "/opt/nec/ve/musl/include/bits/limits.h"
  16              		.file 14 "/opt/nec/ve/musl/include/assert.h"
  17              		.file 15 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/common.hpp"
  18              		.file 16 "/opt/nec/ve/ncc/1.5.2/include/stdlib.h"
  19              		.file 17 "/opt/nec/ve/musl/include/stdlib.h"
  20              		.file 18 "/opt/nec/ve/ncc/1.5.2/include/alloca.h"
  21              		.file 19 "/opt/nec/ve/ncc/1.5.2/include/stddef.h"
  22              		.file 20 "/opt/nec/ve/musl/include/stddef.h"
  23              		.file 21 "/opt/nec/ve/ncc/1.5.2/include/string.h"
  24              		.file 22 "/opt/nec/ve/ncc/1.5.2/include/stdio.h"
  25              		.file 23 "/opt/nec/ve/musl/include/stdio.h"
  26              		.file 24 "/opt/nec/ve/ncc/1.5.2/include/float.h"
  27              		.file 25 "/opt/nec/ve/ncc/1.5.2/include/ymath.h"
  28              		.file 26 "/opt/nec/ve/ncc/1.5.2/include/necmath.h"
  29              		.file 27 "/opt/nec/ve/ncc/1.5.2/include/math.h"
  30              		.file 28 "/opt/nec/ve/ncc/1.5.2/include/C++/xtgmath.h"
  31              		.file 29 "/opt/nec/ve/ncc/1.5.2/include/C++/xtr1common"
  32              		.file 30 "/opt/nec/ve/ncc/1.5.2/include/C++/cstdlib"
  33              		.file 31 "/opt/nec/ve/ncc/1.5.2/include/_math_builtin.h"
  34              		.file 32 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/include/mkldnn_os.h"
  35              		.file 33 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/dnn_types.hpp"
  36              		.file 34 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/include/mkldnn_types.h"
  37              		.file 35 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/mkldnn_common.hpp"
  38              		.file 36 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/include/mkldnn.h"
  39              		.file 37 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/mkldnn_debug.hpp"
  40              		.file 38 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/mkldnn_memory.hpp"
  41              	# ============ Begin  conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const =====
  42              		.text
  43              		.balign 16
  44              	# line 151
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** /*******************************************************************************
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * Copyright 2017 Intel Corporation
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** *
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * Licensed under the Apache License, Version 2.0 (the "License");
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * you may not use this file except in compliance with the License.
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * You may obtain a copy of the License at
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** *
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** *     http://www.apache.org/licenses/LICENSE-2.0
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** *
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * Unless required by applicable law or agreed to in writing, software
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * distributed under the License is distributed on an "AS IS" BASIS,
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * See the License for the specific language governing permissions and
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** * limitations under the License.
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** *******************************************************************************/
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** /** \file
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****  * sx vectorization ref_conv2.cpp */
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if ! defined(_SX)
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #define restrict
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #endif
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #include "conv/conv.hpp"
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** namespace conv {
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** void sxconv_2_fwd(const prb_t *p, dnn_mem_t &src_m,
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m)
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** {
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict psrc = (float*)src_m;
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict pwei = (float*)wei_m;
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict pbia = (float*)bia_m;
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict pdst = (float*)dst_m;
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t G = p->g;
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t MB = p->mb;
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IC = p->ic;
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IH = p->ih;
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IW = p->iw;
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OC = p->oc;
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH = p->oh;
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OW = p->ow;
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KH = p->kh;
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KW = p->kw;
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG = IC/G;
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG_KH_KW = ICOG * KH * KW;
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OCOG = OC / G;
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH_OW = OH * OW;
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PH = p->ph;
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PW = p->pw;
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SH = p->sh;
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SW = p->sw;
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DH = p->dh + 1;
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DW = p->dw + 1;
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SRC_STR_IC = src_off_f2(p, 0, 0, 1, 0, 0)
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      src_off_f2(p, 0, 0, 0, 0, 0);
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SRC_STR_KW = src_off_f2(p, 0, 0, 0, 0, 1)
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      src_off_f2(p, 0, 0, 0, 0, 0);
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t WEI_STR_IC = wei_off_f2(p, 0, 0, 1, 0, 0)
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      wei_off_f2(p, 0, 0, 0, 0, 0);
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t WEI_STR_KW = wei_off_f2(p, 0, 0, 0, 0, 1)
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      wei_off_f2(p, 0, 0, 0, 0, 0);
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #define LAMB 0
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if LAMB
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     auto ker_ic = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         const ssize_t ih0 = oh * SH - PH;
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         const ssize_t iw0 = ow * SW - PW;
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t kh = 0; kh < KH; ++kh) {
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t ih = ih0 + kh * DH;
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if (ih < 0 || ih >= IH) continue;
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kw = 0; kw < KW; ++kw) {
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t iw = iw0 + kw * DW;
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (iw < 0 || iw >= IW) continue;
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t src_off0 = src_off_f2(p, mb, g, 0, ih, iw); // ic=0
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t wei_off0=  wei_off_f2(p, g, oc, 0, kh, kw);
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //ssize_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw);
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     d +=  psrc[src_off0 + ic*SRC_STR_IC]
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         * pwei[wei_off0 + ic*WEI_STR_IC];
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     };
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #endif
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if 1 && LAMB// SX 1.17x
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     auto ker_kw = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t ih0 = oh * SH - PH;
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t iw0 = ow * SW - PW;
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kh = 0; kh < KH; ++kh) {
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = ih0 + kh * DH;
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (ih < 0 || ih >= IH) continue;
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0); // iw=0
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ssize_t wei_off0 = wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t kw = 0; kw < KW; ++kw) {
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw = iw0 + kw * DW;
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (iw < 0 || iw >= IW) continue;
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //ssize_t src_off = src_off0 + iw;
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //ssize_t wei_off = wei_off0 + kw;
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     d += psrc[src_off0 + iw] * pwei[wei_off0 + kw];
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     };
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #elif 1 // SX 1.12 x
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     auto ker_kw = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t ih0 = oh * SH - PH;
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t iw0 = ow * SW - PW;
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kh = 0; kh < KH; ++kh) {
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = ih0 + kh * DH;
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (ih < 0 || ih >= IH) continue;
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0); // iw=0
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t wei_off0=  wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t kw = 0; kw < KW; ++kw) {
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw = iw0 + kw * DW;
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (iw < 0 || iw >= IW) continue;
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     d +=  psrc[src_off0 + iw*SRC_STR_KW]
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         * pwei[wei_off0 + kw*WEI_STR_KW];
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     };
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #else // SX : seems no faster 0.86x
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     auto ker_kw = [&](float &d, ssize_t g, ssize_t mb, ssize_t oc, ssize_t oh, ssize_t ow) {
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t ih0 = oh * SH - PH;
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t iw0 = ow * SW - PW;
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t src_off0 = src_off_f2(p, mb, g, ic, 0, 0); // ih=iw=0
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t wei_off0=  wei_off_f2(p, g, oc, ic, 0, 0);// kh=kw=0
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t khkw = 0; khkw < KH*KW; ++khkw) {
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t kh = khkw / KW;
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t kw = khkw % KW;
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = ih0 + kh * DH;
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (ih < 0 || ih >= IH) continue;
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t iw = iw0 + kw * DW;
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (iw < 0 || iw >= IW) continue;
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d +=  psrc[src_off0 + ih*IW + iw]
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     * pwei[wei_off0 + kh*KW + kw];
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     };
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #endif
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     auto maybe_scale = [&](float &d) {
  45              		.loc	1 151 0
  47              	conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const:
  48              		.cfi_startproc
  49 0000 00000000 		st	%fp,0x0(,%sp)
  49      8B000911 
  50              		.cfi_def_cfa_offset	0
  51              		.cfi_offset	9,0
  52 0008 08000000 		st	%lr,0x8(,%sp)
  52      8B000A11 
  53 0010 18000000 		st	%got,0x18(,%sp)
  53      8B000F11 
  54 0018 20000000 		st	%plt,0x20(,%sp)
  54      8B001011 
  55 0020 00000000 		or	%fp,0,%sp
  55      8B000945 
  56              		.cfi_def_cfa_register	9
  57 0028 30FEFFFF 		lea	%s13,.L.1.2auto_size&0xffffffff
  57      00000D06 
  58 0030 00000000 		and	%s13,%s13,(32)0
  58      608D0D44 
  59 0038 FFFFFFFF 		lea.sl	%sp,.L.1.2auto_size>>32(%fp,%s13)
  59      8D898B06 
  60 0040 48000000 		brge.l.t	%sp,%sl,.L0.EoP
  60      888B3518 
  61 0048 18000000 		ld	%s61,0x18(,%tp)
  61      8E003D01 
  62 0050 00000000 		or	%s62,0,%s0
  62      80003E45 
  63 0058 3B010000 		lea	%s63,0x13b
  63      00003F06 
  64 0060 00000000 		shm.l	%s63,0x0(%s61)
  64      BD033F31 
  65 0068 08000000 		shm.l	%sl,0x8(%s61)
  65      BD030831 
  66 0070 10000000 		shm.l	%sp,0x10(%s61)
  66      BD030B31 
  67 0078 00000000 		monc
  67      0000003F 
  68 0080 00000000 		or	%s0,0,%s62
  68      BE000045 
  69              	.L0.EoP:
  70              	# End of prologue codes
  71              	# line 152
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         if (!p->attr.oscale.is_def()) {
  72              		.loc	1 152 0
  73 0088 00000000 		ld	%s0,0(,%s0)	# *(this).p
  73      80000001 
  74 0090 38000000 		lea	%s63,56
  74      00003F06 
  75 0098 00000000 		ld	%s0,0(,%s0)	# *(*(this).p)
  75      80000001 
  76 00a0 38000000 		lea	%s62,56
  76      00003E06 
  77 00a8 64000000 		ldl.zx	%s61,100(,%s0)	# prb_t.attr.oscale.policy
  77      8000BD03 
  78 00b0 00000000 		adds.w.sx	%s61,0,%s61
  78      BD003D4A 
  79 00b8 00000000 		cmps.w.sx	%s61,%s61,(0)1
  79      00BD3D7A 
  80 00c0 00000000 		or	%s60,0,(0)1
  80      00003C45 
  81 00c8 84000000 		cmov.w.eq	%s60,(63)0,%s61
  81      7FBD3C3B 
  82 00d0 00000000 		sll	%s60,%s60,%s63
  82      BCBF3C65 
  83 00d8 00000000 		sra.l	%s60,%s60,%s62
  83      BCBE3C77 
  84 00e0 00000000 		or	%s60,0,%s60
  84      BC003C45 
  85 00e8 98000000 		breq.w	0,%s60,.L0.0
  85      BC008418 
  86 00f0 38000000 		br.l	.L0.1
  86      00000F18 
  87              	.L0.2:
  88              	# line 159
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             using policy_t = attr_t::scale_t::policy_t;
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const auto &s = p->attr.oscale;
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if (s.policy == policy_t::COMMON) {
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d *= s.scale;
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             } else {
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 /* unsupported so far */
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 []() { SAFE(FAIL, CRIT); return 0; }();
  89              		.loc	1 159 0
  90 00f8 00000000 		adds.l	%s0,%fp,(60)1
  90      3C890059 
  91 0100 00000000 		lea	%s12,conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const::{lambda()#1}::operator()() const@LO
  91      00000C06 
  92 0108 00000000 		and	%s12,%s12,(32)0
  92      608C0C44 
  93 0110 00000000 		lea.sl	%s12,conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const::{lambda()#1}::operator()() const@H
  93      8C008C06 
  94 0118 00000000 		bsic	%lr,(,%s12)	# _ZZZN4conv12sxconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlRfE_clES5_ENKUlvE
  94      8C000A08 
  95 0120 08000000 		br.l	.L0.1
  95      00000F18 
  96              	.L0.1:
  97              	# line 162
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     };
  98              		.loc	1 162 0
  99              	# Start of epilogue codes
 100 0128 00000000 		or	%sp,0,%fp
 100      89000B45 
 101              		.cfi_def_cfa	11,8
 102 0130 18000000 		ld	%got,0x18(,%sp)
 102      8B000F01 
 103 0138 20000000 		ld	%plt,0x20(,%sp)
 103      8B001001 
 104 0140 08000000 		ld	%lr,0x8(,%sp)
 104      8B000A01 
 105 0148 00000000 		ld	%fp,0x0(,%sp)
 105      8B000901 
 106 0150 00000000 		b.l	(,%lr)
 106      8A000F19 
 107              	.L0.3:
 108              	# line 156
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             } else {
 109              		.loc	1 156 0
 110 0158 00000000 		ldu	%s62,0(,%s1)	# *(d)
 110      81003E02 
 111 0160 04000000 		ldu	%s63,4(,%s63)	# *(s).scale
 111      BF003F02 
 112 0168 00000000 		fmul.s	%s63,%s62,%s63
 112      BFBEBF4D 
 113 0170 00000000 		stu	%s63,0(,%s1)	# *(d)
 113      81003F12 
 114 0178 B0FFFFFF 		br.l	.L0.1
 114      00000F18 
 115              	.L0.0:
 116              	# line 154
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if (s.policy == policy_t::COMMON) {
 117              		.loc	1 154 0
 118 0180 64000000 		lea	%s63,100
 118      00003F06 
 119 0188 00000000 		adds.l	%s63,%s0,%s63
 119      BF803F59 
 120              	# line 155
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d *= s.scale;
 121              		.loc	1 155 0
 122 0190 00000000 		ldl.zx	%s62,0(,%s63)	# *(s).policy
 122      BF00BE03 
 123 0198 00000000 		adds.w.sx	%s62,0,%s62
 123      BE003E4A 
 124 01a0 B8FFFFFF 		breq.w	1,%s62,.L0.3
 124      BE018418 
 125 01a8 50FFFFFF 		br.l	.L0.2
 125      00000F18 
 126              		.cfi_endproc
 127              		.set	.L.1.2auto_size,	0xfffffffffffffe30	# 464 Bytes
 129              	# ============ End  conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const =======
 130              	# ============ Begin  _ZZN4conv14sxconv_2_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlRflllllE_clES5
 131              		.balign 16
 132              	# line 363
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     OMP(parallel for collapse(5))//;
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (ssize_t g = 0; g < G; ++g) {
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < OCOG; ++oc) {
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             float &d = pdst[dst_off];
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             d = 0.f;
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if LAMB
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if( ICOG > KW ){
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ker_ic(d, g, mb, oc, oh, ow);
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             } else {
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ker_kw(d, g, mb, oc, oh, ow);
 179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #else
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if( ICOG > KW ){
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih0 = oh * SH - PH;
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t iw0 = ow * SW - PW;
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t kh = 0; kh < KH; ++kh) {
 185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih = ih0 + kh * DH;
 186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (ih < 0 || ih >= IH) continue;
 187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     for (ssize_t kw = 0; kw < KW; ++kw) {
 189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t iw = iw0 + kw * DW;
 190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         if (iw < 0 || iw >= IW) continue;
 191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t src_off0 = src_off_f2(p, mb, g, 0, ih, iw); // ic=0
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t wei_off0=  wei_off_f2(p, g, oc, 0, kh, kw);
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
 196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw);
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             d +=  psrc[src_off0 + ic*SRC_STR_IC]
 198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                                 * pwei[wei_off0 + ic*WEI_STR_IC];
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         }
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     }
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             } else {
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih0 = oh * SH - PH;
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw0 = ow * SW - PW;
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     for (ssize_t kh = 0; kh < KH; ++kh) {
 207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t ih = ih0 + kh * DH;
 208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         if (ih < 0 || ih >= IH) continue;
 209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0); // iw=0
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         ssize_t wei_off0 = wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         for (ssize_t kw = 0; kw < KW; ++kw) {
 213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             const ssize_t iw = iw0 + kw * DW;
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             if (iw < 0 || iw >= IW) continue;
 215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t src_off = src_off0 + iw;
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t wei_off = wei_off0 + kw;
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             d += psrc[src_off0 + iw] * pwei[wei_off0 + kw];
 219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         }
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     }
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #endif
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if (p->dir & FLAG_BIA) {
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t bia_off = bia_off_f2(p, g, oc);
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d += pbia[bia_off];
 228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             maybe_scale(d);
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if (p->merge == RELU && d < 0.f)
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d = 0.f;
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     }
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     }
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** }
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** void sxconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict const pdiff_src = (float*)diff_src_m;
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const pwei = (float*)wei_m;
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const pdiff_dst = (float*)diff_dst_m;
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t G = p->g;
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t MB = p->mb;
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IC = p->ic;
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IH = p->ih;
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IW = p->iw;
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OC = p->oc;
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH = p->oh;
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OW = p->ow;
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KH = p->kh;
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KW = p->kw;
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PH = p->ph;
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PW = p->pw;
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SH = p->sh;
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SW = p->sw;
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DH = p->dh + 1;
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DW = p->dw + 1;
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG = IC/G;
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OCOG = OC / G;
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH_OW = OH * OW;
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if LAMB
 267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     auto ker = [&](float &ds, int g, int mb, int ic, int ih, int iw) {
 268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             int oh = ih - kh * (p->dh + 1) + p->ph;
 270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if (oh < 0 || oh % p->sh) continue;
 271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             oh /= p->sh;
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             if (oh >= p->oh) continue;
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (int kw = 0; kw < p->kw; ++kw) {
 275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 int ow = iw - kw * (p->dw + 1) + p->pw;
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (ow < 0 || ow % p->sw) continue;
 277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ow /= p->sw;
 278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (ow >= p->ow) continue;
 279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 //const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
 281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 //const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + 
 282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (int oc = 0; oc < OCOG; ++oc) {
 283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ds += pdiff_dst[dst_off] * pwei[wei_off];
 286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW]
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //    * pwei     [wei_off0 + oc*ICOG_KH_KW];
 288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     };
 292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #endif
 293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     OMP(parallel for collapse(5))//;
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (int g = 0; g < G; ++g) {
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ic = 0; ic < ICOG; ++ic) {
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int iw = 0; iw < IW; ++iw) {
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             float &ds = pdiff_src[src_off];
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             ds = 0;
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if LAMB
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             ker(ds, g, mb, ic, ih, iw);
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #else
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (int kh = 0; kh < p->kh; ++kh) {
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 int oh = ih - kh * (p->dh + 1) + p->ph;
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (oh < 0 || oh % p->sh) continue;
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 oh /= p->sh;
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (oh >= p->oh) continue;
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (int kw = 0; kw < p->kw; ++kw) {
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     int ow = iw - kw * (p->dw + 1) + p->pw;
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (ow < 0 || ow % p->sw) continue;
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ow /= p->sw;
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (ow >= p->ow) continue;
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const size_t dst_off0 = (((int)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const size_t wei_off0 = ((((int)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + k
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     for (int oc = 0; oc < OCOG; ++oc) {
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         //int dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         //int wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         ds += pdiff_dst[dst_off0 + oc*OH_OW]
 324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             * pwei     [wei_off0 + oc*ICOG_KH_KW];
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     }
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #endif
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     }
 333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     }
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** }
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** void sxconv_2_bwd_w(const prb_t *p, dnn_mem_t &src_m,
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const psrc = (float*)src_m;
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict const pdiff_wei = (float*)diff_wei_m;
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict const pdiff_bia = (float*)diff_bia_m;
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const pdiff_dst = (float*)diff_dst_m;
 342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t G = p->g;
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t MB = p->mb;
 344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IC = p->ic;
 345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IH = p->ih;
 346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IW = p->iw;
 347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OC = p->oc;
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH = p->oh;
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OW = p->ow;
 350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KH = p->kh;
 351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KW = p->kw;
 352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PH = p->ph;
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PW = p->pw;
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SH = p->sh;
 355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SW = p->sw;
 356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DH = p->dh + 1;
 357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DW = p->dw + 1;
 358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG = IC/G;
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OCOG = OC/G;
 361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH_OW = OH * OW;
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     ssize_t const IH_IW = IH * IW;
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     auto ker = [&](float &dw, ssize_t g, ssize_t oc, ssize_t ic, ssize_t kh, ssize_t kw) {
 133              		.loc	1 363 0
 135              	conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&, long, long, long, long, long)#1}::operator()(float&, long, long, long, long, long) const:
 136              		.cfi_startproc
 137 01b0 00000000 		st	%fp,0x0(,%sp)
 137      8B000911 
 138              		.cfi_def_cfa_offset	0
 139              		.cfi_offset	9,0
 140 01b8 08000000 		st	%lr,0x8(,%sp)
 140      8B000A11 
 141 01c0 18000000 		st	%got,0x18(,%sp)
 141      8B000F11 
 142 01c8 20000000 		st	%plt,0x20(,%sp)
 142      8B001011 
 143 01d0 00000000 		or	%fp,0,%sp
 143      8B000945 
 144              		.cfi_def_cfa_register	9
 145 01d8 30000000 		st	%s18,48(,%fp)
 145      89001211 
 146 01e0 00FFFFFF 		lea	%s13,.L.2.2auto_size&0xffffffff
 146      00000D06 
 147 01e8 00000000 		and	%s13,%s13,(32)0
 147      608D0D44 
 148 01f0 FFFFFFFF 		lea.sl	%sp,.L.2.2auto_size>>32(%fp,%s13)
 148      8D898B06 
 149 01f8 48000000 		brge.l.t	%sp,%sl,.L1.EoP
 149      888B3518 
 150 0200 18000000 		ld	%s61,0x18(,%tp)
 150      8E003D01 
 151 0208 00000000 		or	%s62,0,%s0
 151      80003E45 
 152 0210 3B010000 		lea	%s63,0x13b
 152      00003F06 
 153 0218 00000000 		shm.l	%s63,0x0(%s61)
 153      BD033F31 
 154 0220 08000000 		shm.l	%sl,0x8(%s61)
 154      BD030831 
 155 0228 10000000 		shm.l	%sp,0x10(%s61)
 155      BD030B31 
 156 0230 00000000 		monc
 156      0000003F 
 157 0238 00000000 		or	%s0,0,%s62
 157      BE000045 
 158              	.L1.EoP:
 159              	# End of prologue codes
 160              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t mb = 0; mb < p->mb; ++mb) {
 161              		.loc	1 364 0
 162 0240 00000000 		ld	%s63,0(,%s0)	# *(this).p
 162      80003F01 
 163 0248 00000000 		ld	%s63,0(,%s63)	# *(*(this).p)
 163      BF003F01 
 164 0250 04000000 		ldl.sx	%s62,4(,%s63)	# prb_t.__b_N4conv6desc_tE.mb
 164      BF003E03 
 165 0258 00000000 		or	%s62,0,%s62
 165      BE003E45 
 166 0260 C0020000 		brlt.l	0,%s62,.L1.0
 166      BE000218 
 167 0268 98010000 		br.l	.L1.1
 167      00000F18 
 168              	.L1.2:
 169              	# line 374
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t oh = 0; oh < p->oh; ++oh) {
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (ih < 0 || ih >= p->ih) continue;
 368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 //const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + oc) * OH + oh) * OW + 0;
 369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 //ssize_t const src_off0 = (((ssize_t)mb * IC + g * ICOG + 0 ) * IH + ih) * IW + 0;
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t ow = 0; ow < p->ow; ++ow) {
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw = ow * p->sw - p->pw + kw * (p->dw + 1);
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (iw < 0 || iw >= p->iw) continue;
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
 170              		.loc	1 374 0
 171 0270 00000000 		divs.l	%s57,%s59,%s58
 171      BABB397F 
 172 0278 00000000 		adds.l	%s57,%s57,%s56
 172      B8B93959 
 173 0280 00000000 		adds.l	%s57,%s57,%s55
 173      B7B93959 
 174 0288 00000000 		muls.l	%s57,%s57,%s54
 174      B6B9396E 
 175 0290 00000000 		adds.l	%s57,%s57,%s53
 175      B5B93959 
 176 0298 00000000 		muls.l	%s57,%s57,%s52
 176      B4B9396E 
 177 02a0 00000000 		adds.l	%s57,%s18,%s57
 177      B9923959 
 178              	# line 376
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     dw += pdiff_dst[dst_off] * psrc[src_off];
 179              		.loc	1 376 0
 180 02a8 00000000 		muls.l	%s57,4,%s57
 180      B904396E 
 181              	# line 375
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 182              		.loc	1 375 0
 183 02b0 00000000 		divs.l	%s42,%s51,%s58
 183      BAB32A7F 
 184 02b8 00000000 		adds.l	%s42,%s42,%s50
 184      B2AA2A59 
 185 02c0 00000000 		adds.l	%s42,%s42,%s49
 185      B1AA2A59 
 186 02c8 00000000 		muls.l	%s42,%s42,%s48
 186      B0AA2A6E 
 187 02d0 00000000 		adds.l	%s42,%s42,%s47
 187      AFAA2A59 
 188 02d8 00000000 		muls.l	%s42,%s42,%s46
 188      AEAA2A6E 
 189 02e0 00000000 		adds.l	%s42,%s60,%s42
 189      AABC2A59 
 190              	# line 376
 191              		.loc	1 376 0
 192 02e8 00000000 		muls.l	%s42,4,%s42
 192      AA042A6E 
 193 02f0 00000000 		ldu	%s41,0(,%s45)	# *(dw)
 193      AD002902 
 194 02f8 00000000 		ldu	%s42,0(%s42,%s44)	# float
 194      ACAA2A02 
 195 0300 00000000 		ldu	%s57,0(%s57,%s43)	# float
 195      ABB93902 
 196 0308 00000000 		fmul.s	%s57,%s42,%s57
 196      B9AAB94D 
 197 0310 00000000 		fadd.s	%s57,%s41,%s57
 197      B9A9B94C 
 198 0318 00000000 		stu	%s57,0(,%s45)	# *(dw)
 198      AD003912 
 199 0320 38000000 		br.l	.L1.3
 199      00000F18 
 200              	.L1.4:
 201 0328 30000000 		brle.l	0,%s61,.L1.3
 201      BD000618 
 202 0330 40FFFFFF 		br.l	.L1.2
 202      00000F18 
 203              	.L1.5:
 204 0338 00000000 		or	%s63,0,%s3
 204      83003F45 
 205 0340 00000000 		or	%s61,0,%s1
 205      81003D45 
 206 0348 00000000 		or	%s60,0,%s2
 206      82003C45 
 207 0350 38010000 		br.l	.L1.6
 207      00000F18 
 208              	.L1.3:
 209              	# line 370
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw = ow * p->sw - p->pw + kw * (p->dw + 1);
 210              		.loc	1 370 0
 211 0358 00000000 		adds.l	%s63,1,%s63
 211      BF013F59 
 212 0360 00000000 		adds.l	%s61,%s62,%s61
 212      BDBE3D59 
 213 0368 00000000 		adds.l	%s18,%s62,%s18
 213      92BE1259 
 214 0370 00000000 		adds.l	%s60,1,%s60
 214      BC013C59 
 215 0378 10000000 		brgt.l	0,%s63,.L1.7
 215      BF000118 
 216 0380 B8FFFFFF 		br.l	.L1.5
 216      00000F18 
 217              	.L1.7:
 218 0388 D0FFFFFF 		brgt.l	0,%s18,.L1.3
 218      92000118 
 219 0390 98FFFFFF 		br.l	.L1.4
 219      00000F18 
 220              	.L1.8:
 221 0398 00000000 		or	%s1,0,%s61
 221      BD000145 
 222 03a0 00000000 		or	%s2,0,%s60
 222      BC000245 
 223 03a8 00000000 		or	%s60,0,%s57
 223      B9003C45 
 224 03b0 00000000 		or	%s3,0,%s63
 224      BF000345 
 225 03b8 00000000 		or	%s63,0,%s40
 225      A8003F45 
 226 03c0 00000000 		or	%s61,0,%s39
 226      A7003D45 
 227 03c8 00000000 		or	%s18,0,%s38
 227      A6001245 
 228 03d0 B8FFFFFF 		br.l	.L1.7
 228      00000F18 
 229              	.L1.9:
 230 03d8 00000000 		or	%s57,0,(0)1
 230      00003945 
 231 03e0 B8FFFFFF 		brlt.l	0,%s46,.L1.8
 231      AE000218 
 232 03e8 A0000000 		br.l	.L1.6
 232      00000F18 
 233              	.L1.10:
 234 03f0 98000000 		brle.l	0,%s60,.L1.6
 234      BC000618 
 235 03f8 E0FFFFFF 		br.l	.L1.9
 235      00000F18 
 236              	.L1.1:
 237              	# line 381
 377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //dw += pdiff_dst[dst_off0 + ow] * psrc[src_off0 + iw];
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     };
 238              		.loc	1 381 0
 239              	# Start of epilogue codes
 240 0400 30000000 		ld	%s18,48(,%fp)
 240      89001201 
 241 0408 00000000 		or	%sp,0,%fp
 241      89000B45 
 242              		.cfi_def_cfa	11,8
 243 0410 18000000 		ld	%got,0x18(,%sp)
 243      8B000F01 
 244 0418 20000000 		ld	%plt,0x20(,%sp)
 244      8B001001 
 245 0420 08000000 		ld	%lr,0x8(,%sp)
 245      8B000A01 
 246 0428 00000000 		ld	%fp,0x0(,%sp)
 246      8B000901 
 247 0430 00000000 		b.l	(,%lr)
 247      8A000F19 
 248              	.L1.11:
 249              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t oh = 0; oh < p->oh; ++oh) {
 250              		.loc	1 364 0
 251 0438 00000000 		adds.l	%s63,1,%s63
 251      BF013F59 
 252 0440 00000000 		adds.l	%s56,%s60,%s56
 252      B8BC3859 
 253 0448 00000000 		adds.l	%s50,%s57,%s50
 253      B2B93259 
 254 0450 B8000000 		brgt.l	0,%s63,.L1.12
 254      BF000118 
 255 0458 A8FFFFFF 		br.l	.L1.1
 255      00000F18 
 256              	.L1.13:
 257 0460 00000000 		or	%s63,0,%s7
 257      87003F45 
 258 0468 00000000 		or	%s60,0,%s5
 258      85003C45 
 259 0470 00000000 		or	%s57,0,%s6
 259      86003945 
 260 0478 00000000 		or	%s18,0,%s4
 260      84001245 
 261 0480 B8FFFFFF 		br.l	.L1.11
 261      00000F18 
 262              	.L1.6:
 263              	# line 365
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 264              		.loc	1 365 0
 265 0488 00000000 		adds.l	%s63,1,%s63
 265      BF013F59 
 266 0490 00000000 		adds.l	%s60,%s61,%s60
 266      BCBD3C59 
 267 0498 00000000 		adds.l	%s53,%s61,%s53
 267      B5BD3559 
 268 04a0 00000000 		adds.l	%s47,1,%s47
 268      AF012F59 
 269 04a8 10000000 		brgt.l	0,%s63,.L1.14
 269      BF000118 
 270 04b0 B0FFFFFF 		br.l	.L1.13
 270      00000F18 
 271              	.L1.14:
 272 04b8 D0FFFFFF 		brgt.l	0,%s53,.L1.6
 272      B5000118 
 273 04c0 30FFFFFF 		br.l	.L1.10
 273      00000F18 
 274              	.L1.15:
 275 04c8 00000000 		or	%s4,0,%s18
 275      92000445 
 276 04d0 00000000 		or	%s5,0,%s60
 276      BC000545 
 277 04d8 00000000 		or	%s6,0,%s57
 277      B9000645 
 278 04e0 00000000 		or	%s7,0,%s63
 278      BF000745 
 279 04e8 00000000 		or	%s63,0,%s37
 279      A5003F45 
 280 04f0 00000000 		or	%s60,0,%s36
 280      A4003C45 
 281 04f8 00000000 		or	%s53,0,%s35
 281      A3003545 
 282 0500 B8FFFFFF 		br.l	.L1.14
 282      00000F18 
 283              	.L1.12:
 284 0508 00000000 		or	%s47,0,(0)1
 284      00002F45 
 285 0510 B8FFFFFF 		brlt.l	0,%s18,.L1.15
 285      92000218 
 286 0518 20FFFFFF 		br.l	.L1.11
 286      00000F18 
 287              	.L1.0:
 288              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t oh = 0; oh < p->oh; ++oh) {
 289              		.loc	1 364 0
 290 0520 00000000 		or	%s56,0,(0)1
 290      00003845 
 291 0528 00000000 		or	%s50,0,(0)1
 291      00003245 
 292              	# line 365
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 293              		.loc	1 365 0
 294 0530 18000000 		dldl.sx	%s53,24(,%s63)	# prb_t.__b_N4conv6desc_tE.oh
 294      BF00350B 
 295 0538 00000000 		or	%s45,0,%s1
 295      81002D45 
 296 0540 00000000 		or	%s49,0,%s3
 296      83003145 
 297 0548 00000000 		or	%s18,0,%s53
 297      B5001245 
 298 0550 00000000 		subs.l	%s37,0,%s18
 298      9200255B 
 299              	# line 366
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 if (ih < 0 || ih >= p->ih) continue;
 300              		.loc	1 366 0
 301 0558 28000000 		dldl.sx	%s53,40(,%s63)	# prb_t.__b_N4conv6desc_tE.sh
 301      BF00350B 
 302 0560 00000000 		or	%s55,0,%s4
 302      84003745 
 303 0568 00000000 		or	%s61,0,%s53
 303      B5003D45 
 304 0570 30000000 		dldl.sx	%s53,48(,%s63)	# prb_t.__b_N4conv6desc_tE.ph
 304      BF00350B 
 305 0578 00000000 		or	%s53,0,%s53
 305      B5003545 
 306 0580 38000000 		dldl.sx	%s47,56(,%s63)	# prb_t.__b_N4conv6desc_tE.dh
 306      BF002F0B 
 307 0588 00000000 		adds.w.sx	%s47,1,%s47
 307      AF012F4A 
 308 0590 00000000 		or	%s47,0,%s47
 308      AF002F45 
 309 0598 00000000 		muls.l	%s47,%s5,%s47
 309      AF852F6E 
 310              	# line 365
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 311              		.loc	1 365 0
 312 05a0 00000000 		subs.l	%s35,%s47,%s53
 312      B5AF235B 
 313              	# line 367
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 //const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + oc) * OH + oh) * OW + 0;
 314              		.loc	1 367 0
 315 05a8 0C000000 		dldl.sx	%s53,12(,%s63)	# prb_t.__b_N4conv6desc_tE.ih
 315      BF00350B 
 316 05b0 00000000 		or	%s53,0,%s53
 316      B5003545 
 317              	# line 365
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 318              		.loc	1 365 0
 319 05b8 00000000 		subs.l	%s36,%s35,%s53
 319      B5A3245B 
 320              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t oh = 0; oh < p->oh; ++oh) {
 321              		.loc	1 364 0
 322 05c0 00000000 		subs.l	%s53,0,%s62
 322      BE00355B 
 323 05c8 00000000 		or	%s63,0,%s53
 323      B5003F45 
 324              	# line 370
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw = ow * p->sw - p->pw + kw * (p->dw + 1);
 325              		.loc	1 370 0
 326 05d0 00000000 		dld	%s53,0(,%s0)	# *(this).p
 326      80003509 
 327 05d8 00000000 		dld	%s53,0(,%s53)	# *(*(this).p)
 327      B5003509 
 328 05e0 1C000000 		dldl.sx	%s47,28(,%s53)	# prb_t.__b_N4conv6desc_tE.ow
 328      B5002F0B 
 329 05e8 00000000 		or	%s46,0,%s47
 329      AF002E45 
 330 05f0 00000000 		subs.l	%s40,0,%s46
 330      AE00285B 
 331              	# line 371
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (iw < 0 || iw >= p->iw) continue;
 332              		.loc	1 371 0
 333 05f8 2C000000 		dldl.sx	%s47,44(,%s53)	# prb_t.__b_N4conv6desc_tE.sw
 333      B5002F0B 
 334 0600 00000000 		or	%s62,0,%s47
 334      AF003E45 
 335 0608 3C000000 		dldl.sx	%s47,60(,%s53)	# prb_t.__b_N4conv6desc_tE.dw
 335      B5002F0B 
 336 0610 00000000 		adds.w.sx	%s47,1,%s47
 336      AF012F4A 
 337 0618 00000000 		or	%s47,0,%s47
 337      AF002F45 
 338 0620 00000000 		muls.l	%s47,%s6,%s47
 338      AF862F6E 
 339              	# line 372
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 340              		.loc	1 372 0
 341 0628 10000000 		dldl.sx	%s42,16(,%s53)	# prb_t.__b_N4conv6desc_tE.iw
 341      B5002A0B 
 342 0630 00000000 		or	%s52,0,%s42
 342      AA003445 
 343              	# line 374
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 344              		.loc	1 374 0
 345 0638 08000000 		dldl.sx	%s42,8(,%s53)	# prb_t.__b_N4conv6desc_tE.ic
 345      B5002A0B 
 346 0640 00000000 		or	%s60,0,%s42
 346      AA003C45 
 347 0648 00000000 		muls.l	%s59,%s2,%s60
 347      BC823B6E 
 348 0650 00000000 		dldl.sx	%s42,0(,%s53)	# prb_t.__b_N4conv6desc_tE.g
 348      B5002A0B 
 349 0658 00000000 		or	%s58,0,%s42
 349      AA003A45 
 350 0660 0C000000 		dldl.sx	%s42,12(,%s53)	# prb_t.__b_N4conv6desc_tE.ih
 350      B5002A0B 
 351 0668 00000000 		or	%s54,0,%s42
 351      AA003645 
 352              	# line 375
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     dw += pdiff_dst[dst_off] * psrc[src_off];
 353              		.loc	1 375 0
 354 0670 14000000 		dldl.sx	%s42,20(,%s53)	# prb_t.__b_N4conv6desc_tE.oc
 354      B5002A0B 
 355 0678 00000000 		or	%s57,0,%s42
 355      AA003945 
 356 0680 00000000 		muls.l	%s51,%s2,%s57
 356      B982336E 
 357 0688 18000000 		dldl.sx	%s42,24(,%s53)	# prb_t.__b_N4conv6desc_tE.oh
 357      B5002A0B 
 358 0690 00000000 		or	%s48,0,%s42
 358      AA003045 
 359              	# line 371
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     if (iw < 0 || iw >= p->iw) continue;
 360              		.loc	1 371 0
 361 0698 34000000 		dldl.sx	%s53,52(,%s53)	# prb_t.__b_N4conv6desc_tE.pw
 361      B500350B 
 362 06a0 00000000 		or	%s53,0,%s53
 362      B5003545 
 363              	# line 370
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw = ow * p->sw - p->pw + kw * (p->dw + 1);
 364              		.loc	1 370 0
 365 06a8 00000000 		subs.l	%s38,%s47,%s53
 365      B5AF265B 
 366 06b0 00000000 		subs.l	%s39,%s38,%s52
 366      B4A6275B 
 367              	# line 376
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     //dw += pdiff_dst[dst_off0 + ow] * psrc[src_off0 + iw];
 368              		.loc	1 376 0
 369 06b8 08000000 		dld	%s53,8(,%s0)	# *(this).pdiff_dst
 369      80003509 
 370 06c0 00000000 		dld	%s44,0(,%s53)	# *(*(this).pdiff_dst)
 370      B5002C09 
 371 06c8 10000000 		dld	%s0,16(,%s0)	# *(this).psrc
 371      80000009 
 372 06d0 00000000 		dld	%s43,0(,%s0)	# *(*(this).psrc)
 372      80002B09 
 373 06d8 30FEFFFF 		br.l	.L1.12
 373      00000F18 
 374              		.cfi_endproc
 375              		.set	.L.2.2auto_size,	0xffffffffffffff00	# 256 Bytes
 377              	# ============ End  conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&, long, long, long, long, long)#1}::operator()(float&, long) const
 378              	# ============ Begin  _ZZZN4conv12sxconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlRfE_clES5_ENKUl
 379              		.data
 380              		.balign 16
 383              	.LP.__12_sx_conv2_cpp_26810457.0.__unnamed.0:
 384 0000 6C       		.byte	108
 385 0001 61       		.byte	97
 386 0002 6D       		.byte	109
 387 0003 62       		.byte	98
 388 0004 64       		.byte	100
 389 0005 61       		.byte	97
 390 0006 20       		.byte	32
 391 0007 5B       		.byte	91
 392 0008 5D       		.byte	93
 393 0009 28       		.byte	40
 394 000a 29       		.byte	41
 395 000b 2D       		.byte	45
 396 000c 3E       		.byte	62
 397 000d 61       		.byte	97
 398 000e 75       		.byte	117
 399 000f 74       		.byte	116
 400 0010 6F       		.byte	111
 401 0011 3A       		.byte	58
 402 0012 3A       		.byte	58
 403 0013 6F       		.byte	111
 404 0014 70       		.byte	112
 405 0015 65       		.byte	101
 406 0016 72       		.byte	114
 407 0017 61       		.byte	97
 408 0018 74       		.byte	116
 409 0019 6F       		.byte	111
 410 001a 72       		.byte	114
 411 001b 28       		.byte	40
 412 001c 29       		.byte	41
 413 001d 28       		.byte	40
 414 001e 29       		.byte	41
 415 001f 2D       		.byte	45
 416 0020 3E       		.byte	62
 417 0021 61       		.byte	97
 418 0022 75       		.byte	117
 419 0023 74       		.byte	116
 420 0024 6F       		.byte	111
 421 0025 00       		.zero	1
 422              		.section .rodata
 423              		.balign 16
 425              	.LP.__string.0:
 426 0000 40       		.byte	64
 427 0001 40       		.byte	64
 428 0002 40       		.byte	64
 429 0003 20       		.byte	32
 430 0004 65       		.byte	101
 431 0005 72       		.byte	114
 432 0006 72       		.byte	114
 433 0007 6F       		.byte	111
 434 0008 72       		.byte	114
 435 0009 20       		.byte	32
 436 000a 5B       		.byte	91
 437 000b 25       		.byte	37
 438 000c 73       		.byte	115
 439 000d 3A       		.byte	58
 440 000e 25       		.byte	37
 441 000f 64       		.byte	100
 442 0010 5D       		.byte	93
 443 0011 3A       		.byte	58
 444 0012 20       		.byte	32
 445 0013 27       		.byte	39
 446 0014 25       		.byte	37
 447 0015 73       		.byte	115
 448 0016 27       		.byte	39
 449 0017 20       		.byte	32
 450 0018 2D       		.byte	45
 451 0019 3E       		.byte	62
 452 001a 20       		.byte	32
 453 001b 25       		.byte	37
 454 001c 64       		.byte	100
 455 001d 0A       		.byte	10
 456 001e 00       		.zero	1
 457 001f 00       		.balign 8
 459              	.LP.__string.1:
 460 0020 31       		.byte	49
 461 0021 00       		.zero	1
 462              		.text
 463              		.balign 16
 464              	# line 159
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 465              		.loc	1 159 0
 467              	conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const::{lambda()#1}::operator()() const:
 468              		.cfi_startproc
 469 06e0 00000000 		st	%fp,0x0(,%sp)
 469      8B000911 
 470              		.cfi_def_cfa_offset	0
 471              		.cfi_offset	9,0
 472 06e8 08000000 		st	%lr,0x8(,%sp)
 472      8B000A11 
 473 06f0 18000000 		st	%got,0x18(,%sp)
 473      8B000F11 
 474 06f8 20000000 		st	%plt,0x20(,%sp)
 474      8B001011 
 475 0700 00000000 		or	%fp,0,%sp
 475      8B000945 
 476              		.cfi_def_cfa_register	9
 477 0708 20FEFFFF 		lea	%s13,.L.3.2auto_size&0xffffffff
 477      00000D06 
 478 0710 00000000 		and	%s13,%s13,(32)0
 478      608D0D44 
 479 0718 FFFFFFFF 		lea.sl	%sp,.L.3.2auto_size>>32(%fp,%s13)
 479      8D898B06 
 480 0720 48000000 		brge.l.t	%sp,%sl,.L2.EoP
 480      888B3518 
 481 0728 18000000 		ld	%s61,0x18(,%tp)
 481      8E003D01 
 482 0730 00000000 		or	%s62,0,%s0
 482      80003E45 
 483 0738 3B010000 		lea	%s63,0x13b
 483      00003F06 
 484 0740 00000000 		shm.l	%s63,0x0(%s61)
 484      BD033F31 
 485 0748 08000000 		shm.l	%sl,0x8(%s61)
 485      BD030831 
 486 0750 10000000 		shm.l	%sp,0x10(%s61)
 486      BD030B31 
 487 0758 00000000 		monc
 487      0000003F 
 488 0760 00000000 		or	%s0,0,%s62
 488      BE000045 
 489              	.L2.EoP:
 490              	# End of prologue codes
 491 0768 00000000 		lea	%s63,stderr@LO
 491      00003F06 
 492 0770 00000000 		and	%s63,%s63,(32)0
 492      60BF3F44 
 493 0778 00000000 		lea.sl	%s63,stderr@HI(,%s63)
 493      BF00BF06 
 494 0780 00000000 		ld	%s0,0(,%s63)	# stderr
 494      BF000001 
 495 0788 B0000000 		st	%s0,176(,%sp)
 495      8B000011 
 496 0790 00000000 		lea	%s1,.LP.__string.0@LO
 496      00000106 
 497 0798 00000000 		and	%s1,%s1,(32)0
 497      60810144 
 498 07a0 00000000 		lea.sl	%s1,.LP.__string.0@HI(,%s1)
 498      81008106 
 499 07a8 B8000000 		st	%s1,184(,%sp)
 499      8B000111 
 500 07b0 00000000 		lea	%s2,.LP.__12_sx_conv2_cpp_26810457.0.__unnamed.0@LO
 500      00000206 
 501 07b8 00000000 		and	%s2,%s2,(32)0
 501      60820244 
 502 07c0 00000000 		lea.sl	%s2,.LP.__12_sx_conv2_cpp_26810457.0.__unnamed.0@HI(,%s2)
 502      82008206 
 503 07c8 C0000000 		st	%s2,192(,%sp)
 503      8B000211 
 504 07d0 00000000 		lea	%s4,.LP.__string.1@LO
 504      00000406 
 505 07d8 00000000 		and	%s4,%s4,(32)0
 505      60840444 
 506 07e0 00000000 		lea.sl	%s4,.LP.__string.1@HI(,%s4)
 506      84008406 
 507 07e8 D0000000 		st	%s4,208(,%sp)
 507      8B000411 
 508 07f0 9F000000 		lea	%s3,159
 508      00000306 
 509 07f8 C8000000 		st	%s3,200(,%sp)
 509      8B000311 
 510 0800 00000000 		or	%s5,1,(0)1
 510      00010545 
 511 0808 D8000000 		st	%s5,216(,%sp)
 511      8B000511 
 512 0810 00000000 		lea	%s12,fprintf@LO
 512      00000C06 
 513 0818 00000000 		and	%s12,%s12,(32)0
 513      608C0C44 
 514 0820 00000000 		lea.sl	%s12,fprintf@HI(,%s12)
 514      8C008C06 
 515 0828 00000000 		bsic	%lr,(,%s12)	# fprintf
 515      8C000A08 
 516 0830 00000000 		or	%s0,0,(0)1
 516      00000045 
 517 0838 00000000 		lea	%s12,fflush@LO
 517      00000C06 
 518 0840 00000000 		and	%s12,%s12,(32)0
 518      608C0C44 
 519 0848 00000000 		lea.sl	%s12,fflush@HI(,%s12)
 519      8C008C06 
 520 0850 00000000 		bsic	%lr,(,%s12)	# fflush
 520      8C000A08 
 521 0858 00000000 		or	%s0,1,(0)1
 521      00010045 
 522 0860 00000000 		lea	%s12,exit@LO
 522      00000C06 
 523 0868 00000000 		and	%s12,%s12,(32)0
 523      608C0C44 
 524 0870 00000000 		lea.sl	%s12,exit@HI(,%s12)
 524      8C008C06 
 525 0878 00000000 		bsic	%lr,(,%s12)	# exit
 525      8C000A08 
 526 0880 00000000 		or	%s0,1,(0)1
 526      00010045 
 527              	# Start of epilogue codes
 528 0888 00000000 		or	%sp,0,%fp
 528      89000B45 
 529              		.cfi_def_cfa	11,8
 530 0890 18000000 		ld	%got,0x18(,%sp)
 530      8B000F01 
 531 0898 20000000 		ld	%plt,0x20(,%sp)
 531      8B001001 
 532 08a0 08000000 		ld	%lr,0x8(,%sp)
 532      8B000A01 
 533 08a8 00000000 		ld	%fp,0x0(,%sp)
 533      8B000901 
 534 08b0 00000000 		b.l	(,%lr)
 534      8A000F19 
 535              		.cfi_endproc
 536              		.set	.L.3.2auto_size,	0xfffffffffffffe20	# 480 Bytes
 538              	# ============ End  _ZZZN4conv12sxconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlRfE_clES5_ENKUlvE
 539              	# ============ Begin  conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 540 08b8 00000000 		.balign 16
 540      00000000 
 541              	# line 27
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict psrc = (float*)src_m;
 542              		.loc	1 27 0
 543              		.globl	conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 545              	conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 546              		.cfi_startproc
 547 08c0 00000000 		st	%fp,0x0(,%sp)
 547      8B000911 
 548              		.cfi_def_cfa_offset	0
 549              		.cfi_offset	9,0
 550 08c8 08000000 		st	%lr,0x8(,%sp)
 550      8B000A11 
 551 08d0 18000000 		st	%got,0x18(,%sp)
 551      8B000F11 
 552 08d8 20000000 		st	%plt,0x20(,%sp)
 552      8B001011 
 553 08e0 00000000 		or	%fp,0,%sp
 553      8B000945 
 554              		.cfi_def_cfa_register	9
 555 08e8 30000000 		st	%s18,48(,%fp)
 555      89001211 
 556 08f0 38000000 		st	%s19,56(,%fp)
 556      89001311 
 557 08f8 40000000 		st	%s20,64(,%fp)
 557      89001411 
 558 0900 48000000 		st	%s21,72(,%fp)
 558      89001511 
 559 0908 50000000 		st	%s22,80(,%fp)
 559      89001611 
 560 0910 58000000 		st	%s23,88(,%fp)
 560      89001711 
 561 0918 60000000 		st	%s24,96(,%fp)
 561      89001811 
 562 0920 68000000 		st	%s25,104(,%fp)
 562      89001911 
 563 0928 70000000 		st	%s26,112(,%fp)
 563      89001A11 
 564 0930 78000000 		st	%s27,120(,%fp)
 564      89001B11 
 565 0938 80000000 		st	%s28,128(,%fp)
 565      89001C11 
 566 0940 88000000 		st	%s29,136(,%fp)
 566      89001D11 
 567 0948 90000000 		st	%s30,144(,%fp)
 567      89001E11 
 568 0950 98000000 		st	%s31,152(,%fp)
 568      89001F11 
 569 0958 A0000000 		st	%s32,160(,%fp)
 569      89002011 
 570 0960 A8000000 		st	%s33,168(,%fp)
 570      89002111 
 571 0968 10FBFFFF 		lea	%s13,.L.4.2auto_size&0xffffffff
 571      00000D06 
 572 0970 00000000 		and	%s13,%s13,(32)0
 572      608D0D44 
 573 0978 FFFFFFFF 		lea.sl	%sp,.L.4.2auto_size>>32(%fp,%s13)
 573      8D898B06 
 574 0980 48000000 		brge.l.t	%sp,%sl,.L3.EoP
 574      888B3518 
 575 0988 18000000 		ld	%s61,0x18(,%tp)
 575      8E003D01 
 576 0990 00000000 		or	%s62,0,%s0
 576      80003E45 
 577 0998 3B010000 		lea	%s63,0x13b
 577      00003F06 
 578 09a0 00000000 		shm.l	%s63,0x0(%s61)
 578      BD033F31 
 579 09a8 08000000 		shm.l	%sl,0x8(%s61)
 579      BD030831 
 580 09b0 10000000 		shm.l	%sp,0x10(%s61)
 580      BD030B31 
 581 09b8 00000000 		monc
 581      0000003F 
 582 09c0 00000000 		or	%s0,0,%s62
 582      BE000045 
 583              	.L3.EoP:
 584              	# End of prologue codes
 585 09c8 B0000000 		st	%s0,176(,%fp)	# p
 585      89000011 
 586              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 587              		.loc	1 108 0
 588 09d0 B0000000 		lea	%s63,176
 588      00003F06 
 589 09d8 00000000 		adds.l	%s63,%fp,%s63
 589      BF893F59 
 590              	# line 27
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict psrc = (float*)src_m;
 591              		.loc	1 27 0
 592 09e0 B8000000 		st	%s1,184(,%fp)	# src_m
 592      89000111 
 593 09e8 C0000000 		st	%s2,192(,%fp)	# wei_m
 593      89000211 
 594 09f0 C8000000 		st	%s3,200(,%fp)	# bia_m
 594      89000311 
 595 09f8 D0000000 		st	%s4,208(,%fp)	# dst_m
 595      89000411 
 596              	# line 28
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict pwei = (float*)wei_m;
 597              		.loc	1 28 0
 598 0a00 A8010000 		ld	%s1,424(,%s1)	# *(src_m).data_
 598      81000101 
 599              	# line 29
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict pbia = (float*)bia_m;
 600              		.loc	1 29 0
 601 0a08 A8010000 		ld	%s2,424(,%s2)	# *(wei_m).data_
 601      82000201 
 602              	# line 30
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict pdst = (float*)dst_m;
 603              		.loc	1 30 0
 604 0a10 A8010000 		ld	%s26,424(,%s3)	# *(bia_m).data_
 604      83001A01 
 605              	# line 31
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t G = p->g;
 606              		.loc	1 31 0
 607 0a18 A8010000 		ld	%s54,424(,%s4)	# *(dst_m).data_
 607      84003601 
 608              	# line 28
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict pwei = (float*)wei_m;
 609              		.loc	1 28 0
 610 0a20 F0FFFFFF 		st	%s1,-16(,%fp)	# psrc
 610      89000111 
 611              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 612              		.loc	1 108 0
 613 0a28 00000000 		adds.l	%s62,%fp,(60)1
 613      3C893E59 
 614              	# line 29
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict pbia = (float*)bia_m;
 615              		.loc	1 29 0
 616 0a30 E8FFFFFF 		st	%s2,-24(,%fp)	# pwei
 616      89000211 
 617              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 618              		.loc	1 108 0
 619 0a38 E8FFFFFF 		lea	%s61,-24
 619      00003D06 
 620 0a40 00000000 		adds.l	%s61,%fp,%s61
 620      BD893D59 
 621              	# line 32
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t MB = p->mb;
 622              		.loc	1 32 0
 623 0a48 00000000 		ldl.sx	%s60,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 623      80003C03 
 624 0a50 00000000 		or	%s60,0,%s60
 624      BC003C45 
 625              	# line 33
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IC = p->ic;
 626              		.loc	1 33 0
 627 0a58 04000000 		ldl.sx	%s59,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 627      80003B03 
 628 0a60 00000000 		or	%s20,0,%s59
 628      BB001445 
 629              	# line 34
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IH = p->ih;
 630              		.loc	1 34 0
 631 0a68 08000000 		ldl.sx	%s59,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 631      80003B03 
 632 0a70 00000000 		or	%s59,0,%s59
 632      BB003B45 
 633              	# line 42
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 634              		.loc	1 42 0
 635 0a78 00000000 		divs.l	%s59,%s59,%s60
 635      BCBB3B7F 
 636              	# line 35
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IW = p->iw;
 637              		.loc	1 35 0
 638 0a80 0C000000 		ldl.sx	%s58,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 638      80003A03 
 639 0a88 00000000 		or	%s58,0,%s58
 639      BA003A45 
 640 0a90 E0FFFFFF 		st	%s58,-32(,%fp)	# IH
 640      89003A11 
 641              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 642              		.loc	1 108 0
 643 0a98 00000000 		adds.l	%s57,%fp,(59)1
 643      3B893959 
 644              	# line 36
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OC = p->oc;
 645              		.loc	1 36 0
 646 0aa0 10000000 		ldl.sx	%s56,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 646      80003803 
 647 0aa8 00000000 		or	%s56,0,%s56
 647      B8003845 
 648              	# line 52
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      src_off_f2(p, 0, 0, 0, 0, 0);
 649              		.loc	1 52 0
 650 0ab0 00000000 		muls.l	%s58,%s58,%s56
 650      B8BA3A6E 
 651              	# line 36
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OC = p->oc;
 652              		.loc	1 36 0
 653 0ab8 D8FFFFFF 		st	%s56,-40(,%fp)	# IW
 653      89003811 
 654              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 655              		.loc	1 108 0
 656 0ac0 D8FFFFFF 		lea	%s56,-40
 656      00003806 
 657 0ac8 00000000 		adds.l	%s56,%fp,%s56
 657      B8893859 
 658              	# line 37
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH = p->oh;
 659              		.loc	1 37 0
 660 0ad0 14000000 		ldl.sx	%s55,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 660      80003703 
 661 0ad8 00000000 		or	%s55,0,%s55
 661      B7003745 
 662              	# line 44
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH_OW = OH * OW;
 663              		.loc	1 44 0
 664 0ae0 00000000 		divs.l	%s21,%s55,%s60
 664      BCB7157F 
 665              	# line 38
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OW = p->ow;
 666              		.loc	1 38 0
 667 0ae8 18000000 		ldl.sx	%s55,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 667      80003703 
 668 0af0 00000000 		or	%s19,0,%s55
 668      B7001345 
 669              	# line 39
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KH = p->kh;
 670              		.loc	1 39 0
 671 0af8 1C000000 		ldl.sx	%s55,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 671      80003703 
 672 0b00 00000000 		or	%s18,0,%s55
 672      B7001245 
 673              	# line 40
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KW = p->kw;
 674              		.loc	1 40 0
 675 0b08 20000000 		ldl.sx	%s55,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 675      80003703 
 676 0b10 00000000 		or	%s53,0,%s55
 676      B7003545 
 677 0b18 00000000 		or	%s55,0,%s55
 677      B7003745 
 678 0b20 A0FFFFFF 		st	%s53,-96(,%fp)	# KH
 678      89003511 
 679              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 680              		.loc	1 108 0
 681 0b28 A0FFFFFF 		lea	%s53,-96
 681      00003506 
 682 0b30 00000000 		adds.l	%s53,%fp,%s53
 682      B5893559 
 683              	# line 41
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG = IC/G;
 684              		.loc	1 41 0
 685 0b38 24000000 		ldl.sx	%s52,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 685      80003403 
 686 0b40 00000000 		or	%s51,0,%s52
 686      B4003345 
 687 0b48 00000000 		or	%s52,0,%s52
 687      B4003445 
 688              	# line 56
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      wei_off_f2(p, 0, 0, 0, 0, 0);
 689              		.loc	1 56 0
 690 0b50 00000000 		mulu.l	%s52,%s55,%s52
 690      B4B73449 
 691 0b58 00000000 		or	%s52,0,%s52
 691      B4003445 
 692              	# line 41
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG = IC/G;
 693              		.loc	1 41 0
 694 0b60 D0FFFFFF 		st	%s51,-48(,%fp)	# KW
 694      89003311 
 695              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 696              		.loc	1 108 0
 697 0b68 D0FFFFFF 		lea	%s55,-48
 697      00003706 
 698 0b70 00000000 		adds.l	%s55,%fp,%s55
 698      B7893759 
 699              	# line 42
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 700              		.loc	1 42 0
 701 0b78 C8FFFFFF 		st	%s59,-56(,%fp)	# ICOG
 701      89003B11 
 702              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 703              		.loc	1 108 0
 704 0b80 C8FFFFFF 		lea	%s59,-56
 704      00003B06 
 705 0b88 00000000 		adds.l	%s59,%fp,%s59
 705      BB893B59 
 706              	# line 46
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PW = p->pw;
 707              		.loc	1 46 0
 708 0b90 30000000 		ldl.sx	%s51,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 708      80003303 
 709 0b98 00000000 		or	%s51,0,%s51
 709      B3003345 
 710 0ba0 C0FFFFFF 		st	%s51,-64(,%fp)	# PH
 710      89003311 
 711              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 712              		.loc	1 108 0
 713 0ba8 00000000 		adds.l	%s51,%fp,(58)1
 713      3A893359 
 714              	# line 47
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SH = p->sh;
 715              		.loc	1 47 0
 716 0bb0 34000000 		ldl.sx	%s50,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 716      80003203 
 717 0bb8 00000000 		or	%s50,0,%s50
 717      B2003245 
 718 0bc0 B8FFFFFF 		st	%s50,-72(,%fp)	# PW
 718      89003211 
 719              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 720              		.loc	1 108 0
 721 0bc8 B8FFFFFF 		lea	%s50,-72
 721      00003206 
 722 0bd0 00000000 		adds.l	%s50,%fp,%s50
 722      B2893259 
 723              	# line 48
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SW = p->sw;
 724              		.loc	1 48 0
 725 0bd8 28000000 		ldl.sx	%s49,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 725      80003103 
 726 0be0 00000000 		or	%s49,0,%s49
 726      B1003145 
 727 0be8 B0FFFFFF 		st	%s49,-80(,%fp)	# SH
 727      89003111 
 728              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 729              		.loc	1 108 0
 730 0bf0 B0FFFFFF 		lea	%s49,-80
 730      00003106 
 731 0bf8 00000000 		adds.l	%s49,%fp,%s49
 731      B1893159 
 732              	# line 49
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DH = p->dh + 1;
 733              		.loc	1 49 0
 734 0c00 2C000000 		ldl.sx	%s48,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 734      80003003 
 735 0c08 00000000 		or	%s48,0,%s48
 735      B0003045 
 736 0c10 A8FFFFFF 		st	%s48,-88(,%fp)	# SW
 736      89003011 
 737              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 738              		.loc	1 108 0
 739 0c18 A8FFFFFF 		lea	%s48,-88
 739      00003006 
 740 0c20 00000000 		adds.l	%s48,%fp,%s48
 740      B0893059 
 741              	# line 50
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t DW = p->dw + 1;
 742              		.loc	1 50 0
 743 0c28 38000000 		ldl.sx	%s47,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 743      80002F03 
 744 0c30 00000000 		adds.w.sx	%s47,1,%s47
 744      AF012F4A 
 745 0c38 00000000 		or	%s47,0,%s47
 745      AF002F45 
 746 0c40 90FFFFFF 		st	%s47,-112(,%fp)	# DH
 746      89002F11 
 747              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 748              		.loc	1 108 0
 749 0c48 90FFFFFF 		lea	%s47,-112
 749      00002F06 
 750 0c50 00000000 		adds.l	%s47,%fp,%s47
 750      AF892F59 
 751              	# line 51
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t SRC_STR_IC = src_off_f2(p, 0, 0, 1, 0, 0)
 752              		.loc	1 51 0
 753 0c58 3C000000 		ldl.sx	%s0,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 753      80000003 
 754 0c60 00000000 		adds.w.sx	%s0,1,%s0
 754      8001004A 
 755 0c68 00000000 		or	%s0,0,%s0
 755      80000045 
 756 0c70 98FFFFFF 		st	%s0,-104(,%fp)	# DW
 756      89000011 
 757              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 758              		.loc	1 108 0
 759 0c78 98FFFFFF 		lea	%s46,-104
 759      00002E06 
 760 0c80 00000000 		adds.l	%s46,%fp,%s46
 760      AE892E59 
 761 0c88 88FFFFFF 		lea	%s45,-120
 761      00002D06 
 762 0c90 00000000 		adds.l	%s45,%fp,%s45
 762      AD892D59 
 763              	# line 54
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      src_off_f2(p, 0, 0, 0, 0, 0);
 764              		.loc	1 54 0
 765 0c98 00000000 		or	%s44,1,(0)1
 765      00012C45 
 766 0ca0 88FFFFFF 		st	%s44,-120(,%fp)	# SRC_STR_KW
 766      89002C11 
 767              	# line 58
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         -                      wei_off_f2(p, 0, 0, 0, 0, 0);
 768              		.loc	1 58 0
 769 0ca8 00000000 		or	%s44,1,(0)1
 769      00012C45 
 770 0cb0 80FFFFFF 		st	%s44,-128(,%fp)	# WEI_STR_KW
 770      89002C11 
 771              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 772              		.loc	1 108 0
 773 0cb8 00000000 		adds.l	%s44,%fp,(57)1
 773      39892C59 
 774 0cc0 00000000 		adds.l	%s43,%fp,(56)1
 774      38892B59 
 775 0cc8 80FEFFFF 		st	%s59,-384(,%fp)
 775      89003B11 
 776 0cd0 80FEFFFF 		lea	%s59,-384
 776      00003B06 
 777 0cd8 00000000 		adds.l	%s59,%fp,%s59
 777      BB893B59 
 778 0ce0 40120000 		br.l	.L3.0
 778      00000F18 
 779              	.L3.1:
 780              	# line 212
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             const ssize_t iw = iw0 + kw * DW;
 781              		.loc	1 212 0
 782 0ce8 80000000 		mins.l	%s62,%s53,%s62
 782      BEB53E68 
 783 0cf0 B8000000 		br.l	.L3.2
 783      00000F18 
 784              	.L3.3:
 785              	# line 218
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         }
 786              		.loc	1 218 0
 787 0cf8 00000000 		or	%s61,1,(0)1
 787      00013D45 
 788 0d00 00000000 		or	%s58,0,%s39
 788      A7003A45 
 789 0d08 00000000 		lvl	%s61
 789      00BD00BF 
 790 0d10 00000035 		vldu.nc	%v53,0,%s58
 790      BA000082 
 791 0d18 00000000 		lvl	%s41
 791      00A900BF 
 792 0d20 00003C34 		vfsum.s	%v52,%v60
 792      000080EC 
 793 0d28 00000000 		or	%s61,1,(0)1
 793      00013D45 
 794 0d30 00000000 		lvl	%s61
 794      00BD00BF 
 795 0d38 00343533 		vfadd.s	%v51,%v53,%v52
 795      000080CC 
 796 0d40 00000000 		or	%s61,1,(0)1
 796      00013D45 
 797 0d48 00000000 		or	%s58,0,%s39
 797      A7003A45 
 798 0d50 00000000 		lvl	%s61
 798      00BD00BF 
 799 0d58 00000033 		vstu.nc	%v51,0,%s58
 799      BA000092 
 800 0d60 00000000 		or	%s52,0,%s40
 800      A8003445 
 801 0d68 00000000 		or	%s56,0,%s38
 801      A6003845 
 802 0d70 00000000 		or	%s53,0,%s37
 802      A5003545 
 803 0d78 00000000 		or	%s55,0,%s36
 803      A4003745 
 804 0d80 00000000 		or	%s57,0,%s35
 804      A3003945 
 805 0d88 00000000 		or	%s60,0,%s34
 805      A2003C45 
 806 0d90 00000000 		or	%s62,0,%s7
 806      87003E45 
 807 0d98 00000000 		or	%s63,0,%s6
 807      86003F45 
 808 0da0 D0020000 		br.l	.L3.4
 808      00000F18 
 809              	.L3.2:
 810              	# line 214
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 811              		.loc	1 214 0
 812 0da8 00000000 		lvl	%s62
 812      00BE00BF 
 813 0db0 003F003E 		vadds.l	%v62,%s63,%v63
 813      00BF208B 
 814 0db8 003E050F 		vfmk.l.ge	%vm15,%v62
 814      000000B4 
 815 0dc0 003D003B 		vadds.l	%v59,%s61,%v61
 815      00BD208B 
 816 0dc8 003B020F 		vfmk.l.lt	%vm15,%v59,%vm15
 816      00000FB4 
 817 0dd0 00000000 		or	%s52,0,%s60
 817      BC003445 
 818              	# line 218
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         }
 819              		.loc	1 218 0
 820 0dd8 0000003A 		vldu.nc	%v58,%s59,%s52
 820      B4BB0082 
 821 0de0 00000000 		or	%s52,0,%s58
 821      BA003445 
 822 0de8 00000039 		vldu.nc	%v57,4,%s52
 822      B4040082 
 823 0df0 3A393C3C 		vfmad.s	%v60,%v60,%v57,%v58,%vm15
 823      00008FE2 
 824              	# line 212
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             const ssize_t iw = iw0 + kw * DW;
 825              		.loc	1 212 0
 826 0df8 00000000 		adds.l	%s63,%s63,%s57
 826      B9BF3F59 
 827 0e00 00000000 		adds.l	%s60,%s60,%s56
 827      B8BC3C59 
 828 0e08 00000000 		adds.l	%s58,%s58,%s55
 828      B7BA3A59 
 829 0e10 00000000 		adds.l	%s61,%s61,%s54
 829      B6BD3D59 
 830 0e18 00000000 		subs.l	%s53,%s53,%s62
 830      BEB5355B 
 831 0e20 D8FEFFFF 		brge.l	0,%s53,.L3.3
 831      B5000518 
 832 0e28 C0FEFFFF 		br.l	.L3.1
 832      00000F18 
 833              	.L3.5:
 834 0e30 00000000 		or	%s61,0,%s33
 834      A1003D45 
 835 0e38 00000000 		muls.l	%s5,4,%s40
 835      A804056E 
 836 0e40 00000000 		or	%s36,0,%s55
 836      B7002445 
 837 0e48 00000000 		or	%s37,0,%s53
 837      B5002545 
 838 0e50 00000000 		adds.l	%s5,%s5,%s32
 838      A0850559 
 839 0e58 00000000 		muls.l	%s4,4,%s54
 839      B604046E 
 840 0e60 00000000 		or	%s38,0,%s56
 840      B8002645 
 841 0e68 00000000 		or	%s35,0,%s57
 841      B9002345 
 842 0e70 00000000 		adds.l	%s4,%s4,%s31
 842      9F840459 
 843 0e78 00000000 		subs.l	%s3,0,%s30
 843      9E00035B 
 844 0e80 00000000 		smvl	%s41
 844      0000292E 
 845 0e88 80000000 		mins.l	%s2,%s3,%s41
 845      A9830268 
 846              	# line 218
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         }
 847              		.loc	1 218 0
 848 0e90 00000000 		or	%s1,0,(0)1
 848      00000145 
 849 0e98 00000000 		or	%s40,0,%s52
 849      B4002845 
 850 0ea0 00000000 		lvl	%s41
 850      00A900BF 
 851 0ea8 0000003C 		vbrdu	%v60,%s1
 851      0081808C 
 852 0eb0 00000000 		or	%s53,0,%s3
 852      83003545 
 853 0eb8 00000000 		or	%s7,0,%s62
 853      BE000745 
 854 0ec0 00000000 		or	%s34,0,%s60
 854      BC002245 
 855 0ec8 00000000 		or	%s6,0,%s63
 855      BF000645 
 856 0ed0 00000000 		or	%s63,0,%s29
 856      9D003F45 
 857              	# line 212
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             const ssize_t iw = iw0 + kw * DW;
 858              		.loc	1 212 0
 859 0ed8 00000000 		muls.l	%s57,%s28,%s2
 859      829C396E 
 860 0ee0 00000000 		or	%s62,0,%s2
 860      82003E45 
 861 0ee8 00000000 		lvl	%s2
 861      008200BF 
 862 0ef0 00000032 		vseq	%v50
 862      00000099 
 863 0ef8 0032003F 		vmuls.l	%v63,%s28,%v50
 863      009C20DB 
 864 0f00 00000000 		or	%s60,0,%s4
 864      84003C45 
 865 0f08 00000000 		muls.l	%s56,%s59,%s2
 865      82BB386E 
 866 0f10 00000000 		or	%s58,0,%s5
 866      85003A45 
 867 0f18 00000000 		muls.l	%s55,4,%s2
 867      8204376E 
 868 0f20 00000000 		muls.l	%s54,%s28,%s2
 868      829C366E 
 869 0f28 0032003D 		vmuls.l	%v61,%s28,%v50
 869      009C20DB 
 870 0f30 78FEFFFF 		br.l	.L3.2
 870      00000F18 
 871              	.L3.6:
 872              	# line 210
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         ssize_t wei_off0 = wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
 873              		.loc	1 210 0
 874 0f38 00000000 		divs.l	%s54,%s56,%s55
 874      B7B8367F 
 875 0f40 00000000 		adds.l	%s54,%s54,%s53
 875      B5B63659 
 876 0f48 00000000 		adds.l	%s54,%s54,%s52
 876      B4B63659 
 877 0f50 00000000 		muls.l	%s54,%s54,%s51
 877      B3B6366E 
 878 0f58 00000000 		adds.l	%s54,%s18,%s54
 878      B6923659 
 879 0f60 00000000 		muls.l	%s54,%s54,%s50
 879      B2B6366E 
 880              	# line 211
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         for (ssize_t kw = 0; kw < KW; ++kw) {
 881              		.loc	1 211 0
 882 0f68 00000000 		divu.l	%s41,%s49,%s48
 882      B0B1296F 
 883 0f70 00000000 		addu.l	%s41,%s41,%s47
 883      AFA92948 
 884 0f78 00000000 		mulu.l	%s41,%s41,%s46
 884      AEA92949 
 885 0f80 00000000 		divu.l	%s41,%s41,%s48
 885      B0A9296F 
 886 0f88 00000000 		addu.l	%s41,%s41,%s45
 886      ADA92948 
 887 0f90 00000000 		mulu.l	%s41,%s41,%s44
 887      ACA92949 
 888 0f98 00000000 		or	%s40,0,%s57
 888      B9002845 
 889 0fa0 00000000 		addu.l	%s40,%s41,%s40
 889      A8A92848 
 890 0fa8 00000000 		mulu.l	%s40,%s40,%s43
 890      ABA82849 
 891 0fb0 00000000 		or	%s40,0,%s40
 891      A8002845 
 892 0fb8 78FEFFFF 		brlt.l	0,%s42,.L3.5
 892      AA000218 
 893 0fc0 B0000000 		br.l	.L3.4
 893      00000F18 
 894              	.L3.7:
 895 0fc8 A8000000 		brle.l	0,%s60,.L3.4
 895      BC000618 
 896 0fd0 68FFFFFF 		br.l	.L3.6
 896      00000F18 
 897              	.L3.8:
 898 0fd8 40FEFFFF 		st	%s47,-448(,%fp)	# spill 
 898      89002F11 
 899 0fe0 48FEFFFF 		ld	%s20,-440(,%fp)	# restore 
 899      89001401 
 900 0fe8 00000000 		or	%s1,0,%s39
 900      A7000145 
 901 0ff0 58FEFFFF 		ld	%s32,-424(,%fp)	# restore 
 901      89002001 
 902 0ff8 00000000 		or	%s29,0,%s21
 902      95001D45 
 903 1000 50FEFFFF 		ld	%s30,-432(,%fp)	# restore 
 903      89001E01 
 904 1008 00000000 		or	%s31,0,%s22
 904      96001F45 
 905 1010 60FEFFFF 		ld	%s27,-416(,%fp)	# restore 
 905      89001B01 
 906 1018 00000000 		or	%s26,0,%s24
 906      98001A45 
 907 1020 68FEFFFF 		ld	%s28,-408(,%fp)	# restore 
 907      89001C01 
 908 1028 70FEFFFF 		ld	%s33,-400(,%fp)	# restore 
 908      89002101 
 909 1030 60090000 		br.l	.L3.9
 909      00000F18 
 910              	.L3.10:
 911              	# line 203
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih0 = oh * SH - PH;
 912              		.loc	1 203 0
 913 1038 00000000 		adds.l	%s63,1,%s63
 913      BF013F59 
 914 1040 00000000 		adds.l	%s52,1,%s52
 914      B4013459 
 915 1048 A0000000 		brgt.l	0,%s63,.L3.11
 915      BF000118 
 916 1050 88FFFFFF 		br.l	.L3.8
 916      00000F18 
 917              	.L3.12:
 918 1058 00000000 		or	%s63,0,%s20
 918      94003F45 
 919 1060 00000000 		or	%s18,0,%s19
 919      93001245 
 920 1068 D0FFFFFF 		br.l	.L3.10
 920      00000F18 
 921              	.L3.4:
 922              	# line 206
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t ih = ih0 + kh * DH;
 923              		.loc	1 206 0
 924 1070 00000000 		adds.l	%s63,1,%s63
 924      BF013F59 
 925 1078 00000000 		adds.l	%s60,%s62,%s60
 925      BCBE3C59 
 926 1080 00000000 		adds.l	%s18,%s62,%s18
 926      92BE1259 
 927 1088 00000000 		adds.l	%s57,1,%s57
 927      B9013959 
 928 1090 10000000 		brgt.l	0,%s63,.L3.13
 928      BF000118 
 929 1098 C0FFFFFF 		br.l	.L3.12
 929      00000F18 
 930              	.L3.13:
 931 10a0 D0FFFFFF 		brgt.l	0,%s18,.L3.4
 931      92000118 
 932 10a8 20FFFFFF 		br.l	.L3.7
 932      00000F18 
 933              	.L3.14:
 934 10b0 00000000 		or	%s45,0,%s52
 934      B4002D45 
 935 10b8 00000000 		or	%s19,0,%s18
 935      92001345 
 936 10c0 00000000 		or	%s20,0,%s63
 936      BF001445 
 937 10c8 00000000 		or	%s63,0,%s27
 937      9B003F45 
 938 10d0 00000000 		or	%s60,0,%s26
 938      9A003C45 
 939 10d8 00000000 		or	%s18,0,%s25
 939      99001245 
 940 10e0 C0FFFFFF 		br.l	.L3.13
 940      00000F18 
 941              	.L3.11:
 942 10e8 00000000 		or	%s57,0,(0)1
 942      00003945 
 943 10f0 C0FFFFFF 		brlt.l	0,%s18,.L3.14
 943      92000218 
 944 10f8 40FFFFFF 		br.l	.L3.10
 944      00000F18 
 945              	.L3.15:
 946 1100 70FEFFFF 		st	%s33,-400(,%fp)	# spill 
 946      89002111 
 947 1108 68FEFFFF 		st	%s60,-408(,%fp)	# spill 
 947      89003C11 
 948 1110 60FEFFFF 		st	%s62,-416(,%fp)	# spill 
 948      89003E11 
 949 1118 58FEFFFF 		st	%s56,-424(,%fp)	# spill 
 949      89003811 
 950 1120 50FEFFFF 		st	%s57,-432(,%fp)	# spill 
 950      89003911 
 951 1128 48FEFFFF 		st	%s20,-440(,%fp)	# spill 
 951      89001411 
 952 1130 98FFFFFF 		ld	%s28,-104(,%fp)	# DW
 952      89001C01 
 953 1138 00000000 		or	%s21,0,%s59
 953      BB001545 
 954 1140 90FFFFFF 		ld	%s61,-112(,%fp)	# DH
 954      89003D01 
 955 1148 00000000 		or	%s22,0,%s54
 955      B6001645 
 956 1150 A8FFFFFF 		ld	%s58,-88(,%fp)	# SW
 956      89003A01 
 957 1158 00000000 		or	%s24,0,%s26
 957      9A001845 
 958 1160 B0FFFFFF 		ld	%s54,-80(,%fp)	# SH
 958      89003601 
 959 1168 B8FFFFFF 		ld	%s45,-72(,%fp)	# PW
 959      89002D01 
 960 1170 C0FFFFFF 		ld	%s41,-64(,%fp)	# PH
 960      89002901 
 961 1178 A0FFFFFF 		ld	%s40,-96(,%fp)	# KH
 961      89002801 
 962 1180 00000000 		subs.l	%s27,0,%s40
 962      A8001B5B 
 963 1188 D8FFFFFF 		ld	%s38,-40(,%fp)	# IW
 963      89002601 
 964 1190 E0FFFFFF 		ld	%s37,-32(,%fp)	# IH
 964      89002501 
 965 1198 E8FFFFFF 		ld	%s32,-24(,%fp)	# pwei
 965      89002001 
 966 11a0 F0FFFFFF 		ld	%s36,-16(,%fp)	# psrc
 966      89002401 
 967              	# line 204
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t iw0 = ow * SW - PW;
 968              		.loc	1 204 0
 969 11a8 00000000 		muls.l	%s54,%s57,%s54
 969      B6B9366E 
 970 11b0 00000000 		subs.l	%s25,%s54,%s41
 970      A9B6195B 
 971              	# line 206
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t ih = ih0 + kh * DH;
 972              		.loc	1 206 0
 973 11b8 00000000 		subs.l	%s26,%s25,%s37
 973      A5991A5B 
 974              	# line 205
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     for (ssize_t kh = 0; kh < KH; ++kh) {
 975              		.loc	1 205 0
 976 11c0 00000000 		muls.l	%s58,%s56,%s58
 976      BAB83A6E 
 977 11c8 00000000 		subs.l	%s29,%s58,%s45
 977      ADBA1D5B 
 978              	# line 212
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             const ssize_t iw = iw0 + kw * DW;
 979              		.loc	1 212 0
 980 11d0 00000000 		subs.l	%s33,%s29,%s38
 980      A69D215B 
 981              	# line 211
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         for (ssize_t kw = 0; kw < KW; ++kw) {
 982              		.loc	1 211 0
 983 11d8 24000000 		dldl.sx	%s58,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 983      BF003A0B 
 984 11e0 00000000 		or	%s43,0,%s58
 984      BA002B45 
 985              	# line 210
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         ssize_t wei_off0 = wei_off_f2(p, g, oc, ic, kh, 0); // kw=0
 986              		.loc	1 210 0
 987 11e8 08000000 		dldl.sx	%s58,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 987      BF003A0B 
 988 11f0 00000000 		or	%s57,0,%s58
 988      BA003945 
 989 11f8 00000000 		or	%s46,0,%s58
 989      BA002E45 
 990 1200 00000000 		muls.l	%s58,%s62,%s57
 990      B9BE3A6E 
 991 1208 00000000 		or	%s62,0,%s61
 991      BD003E45 
 992 1210 00000000 		muls.l	%s56,%s60,%s57
 992      B9BC386E 
 993 1218 00000000 		or	%s48,0,%s50
 993      B2003045 
 994 1220 0C000000 		dldl.sx	%s61,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 994      BF003D0B 
 995 1228 00000000 		or	%s51,0,%s61
 995      BD003345 
 996 1230 10000000 		dldl.sx	%s61,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 996      BF003D0B 
 997 1238 00000000 		or	%s50,0,%s61
 997      BD003245 
 998 1240 00000000 		or	%s61,0,%s53
 998      B5003D45 
 999              	# line 211
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         for (ssize_t kw = 0; kw < KW; ++kw) {
 1000              		.loc	1 211 0
 1001 1248 00000000 		mulu.l	%s49,%s61,%s20
 1001      94BD3149 
 1002 1250 20000000 		dldl.sx	%s61,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 1002      BF003D0B 
 1003 1258 00000000 		or	%s53,0,%s58
 1003      BA003545 
 1004 1260 00000000 		or	%s44,0,%s61
 1004      BD002C45 
 1005              	# line 203
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih0 = oh * SH - PH;
 1006              		.loc	1 203 0
 1007 1268 00000000 		subs.l	%s61,0,%s18
 1007      92003D5B 
 1008 1270 00000000 		or	%s18,0,%s40
 1008      A8001245 
 1009 1278 00000000 		or	%s63,0,%s61
 1009      BD003F45 
 1010              	# line 212
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             const ssize_t iw = iw0 + kw * DW;
 1011              		.loc	1 212 0
 1012 1280 00000000 		subs.l	%s30,0,%s42
 1012      AA001E5B 
 1013 1288 00000000 		muls.l	%s59,4,%s28
 1013      9C043B6E 
 1014 1290 00000000 		muls.l	%s61,4,%s29
 1014      9D043D6E 
 1015 1298 00000000 		adds.l	%s31,%s36,%s61
 1015      BDA41F59 
 1016 12a0 40FEFFFF 		ld	%s47,-448(,%fp)	# restore 
 1016      89002F01 
 1017 12a8 40FEFFFF 		br.l	.L3.11
 1017      00000F18 
 1018              	.L3.16:
 1019              	# line 203
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih0 = oh * SH - PH;
 1020              		.loc	1 203 0
 1021 12b0 00000000 		or	%s52,0,(0)1
 1021      00003445 
 1022 12b8 48FEFFFF 		brlt.l	0,%s18,.L3.15
 1022      92000218 
 1023 12c0 00000000 		or	%s1,0,%s39
 1023      A7000145 
 1024 12c8 00000000 		or	%s32,0,%s56
 1024      B8002045 
 1025 12d0 00000000 		or	%s30,0,%s57
 1025      B9001E45 
 1026 12d8 00000000 		or	%s29,0,%s59
 1026      BB001D45 
 1027 12e0 00000000 		or	%s27,0,%s62
 1027      BE001B45 
 1028 12e8 00000000 		or	%s28,0,%s60
 1028      BC001C45 
 1029 12f0 00000000 		or	%s31,0,%s54
 1029      B6001F45 
 1030 12f8 98060000 		br.l	.L3.9
 1030      00000F18 
 1031              	.L3.17:
 1032              	# line 194
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
 1033              		.loc	1 194 0
 1034 1300 80000000 		mins.l	%s60,%s55,%s60
 1034      BCB73C68 
 1035 1308 A8000000 		br.l	.L3.18
 1035      00000F18 
 1036              	.L3.19:
 1037              	# line 197
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                                 * pwei[wei_off0 + ic*WEI_STR_IC];
 1038              		.loc	1 197 0
 1039 1310 00000000 		or	%s55,1,(0)1
 1039      00013745 
 1040 1318 00000000 		or	%s41,0,%s39
 1040      A7002945 
 1041 1320 00000000 		lvl	%s55
 1041      00B700BF 
 1042 1328 00000031 		vldu.nc	%v49,0,%s41
 1042      A9000082 
 1043 1330 00000000 		lvl	%s42
 1043      00AA00BF 
 1044 1338 00003830 		vfsum.s	%v48,%v56
 1044      000080EC 
 1045 1340 00000000 		or	%s55,1,(0)1
 1045      00013745 
 1046 1348 00000000 		lvl	%s55
 1046      00B700BF 
 1047 1350 0030312F 		vfadd.s	%v47,%v49,%v48
 1047      000080CC 
 1048 1358 00000000 		or	%s55,1,(0)1
 1048      00013745 
 1049 1360 00000000 		or	%s42,0,%s39
 1049      A7002A45 
 1050 1368 00000000 		lvl	%s55
 1050      00B700BF 
 1051 1370 0000002F 		vstu.nc	%v47,0,%s42
 1051      AA000092 
 1052 1378 00000000 		or	%s56,0,%s40
 1052      A8003845 
 1053 1380 00000000 		or	%s57,0,%s38
 1053      A6003945 
 1054 1388 00000000 		or	%s59,0,%s37
 1054      A5003B45 
 1055 1390 00000000 		or	%s60,0,%s36
 1055      A4003C45 
 1056 1398 00000000 		or	%s62,0,%s35
 1056      A3003E45 
 1057 13a0 00000000 		or	%s63,0,%s34
 1057      A2003F45 
 1058 13a8 E8010000 		br.l	.L3.20
 1058      00000F18 
 1059              	.L3.18:
 1060 13b0 00000000 		or	%s62,0,%s63
 1060      BF003E45 
 1061 13b8 00000000 		lvl	%s60
 1061      00BC00BF 
 1062 13c0 00000037 		vldu.nc	%v55,%s61,%s62
 1062      BEBD0082 
 1063 13c8 00000000 		or	%s62,0,%s59
 1063      BB003E45 
 1064 13d0 00000036 		vldu.nc	%v54,%s58,%s62
 1064      BEBA0082 
 1065 13d8 37363838 		vfmad.s	%v56,%v56,%v54,%v55
 1065      000080E2 
 1066              	# line 194
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
 1067              		.loc	1 194 0
 1068 13e0 00000000 		adds.l	%s63,%s63,%s57
 1068      B9BF3F59 
 1069 13e8 00000000 		adds.l	%s59,%s59,%s56
 1069      B8BB3B59 
 1070 13f0 00000000 		subs.l	%s55,%s55,%s60
 1070      BCB7375B 
 1071 13f8 18FFFFFF 		brge.l	0,%s55,.L3.19
 1071      B7000518 
 1072 1400 00FFFFFF 		br.l	.L3.17
 1072      00000F18 
 1073              	.L3.21:
 1074 1408 00000000 		muls.l	%s41,4,%s41
 1074      A904296E 
 1075 1410 00000000 		or	%s38,0,%s57
 1075      B9002645 
 1076 1418 00000000 		or	%s40,0,%s56
 1076      B8002845 
 1077 1420 00000000 		adds.l	%s41,%s41,%s33
 1077      A1A92959 
 1078 1428 00000000 		muls.l	%s7,4,%s55
 1078      B704076E 
 1079 1430 00000000 		or	%s37,0,%s59
 1079      BB002545 
 1080 1438 00000000 		or	%s35,0,%s62
 1080      BE002345 
 1081 1440 00000000 		adds.l	%s7,%s7,%s32
 1081      A0870759 
 1082 1448 00000000 		subs.l	%s62,0,%s31
 1082      9F003E5B 
 1083 1450 00000000 		smvl	%s42
 1083      00002A2E 
 1084 1458 80000000 		mins.l	%s6,%s62,%s42
 1084      AABE0668 
 1085              	# line 197
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                                 * pwei[wei_off0 + ic*WEI_STR_IC];
 1086              		.loc	1 197 0
 1087 1460 00000000 		or	%s5,0,(0)1
 1087      00000545 
 1088 1468 00000000 		or	%s36,0,%s60
 1088      BC002445 
 1089 1470 00000000 		lvl	%s42
 1089      00AA00BF 
 1090 1478 00000038 		vbrdu	%v56,%s5
 1090      0085808C 
 1091 1480 00000000 		or	%s55,0,%s62
 1091      BE003745 
 1092 1488 00000000 		or	%s34,0,%s63
 1092      BF002245 
 1093 1490 00000000 		or	%s63,0,%s7
 1093      87003F45 
 1094              	# line 194
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
 1095              		.loc	1 194 0
 1096 1498 00000000 		muls.l	%s57,%s61,%s6
 1096      86BD396E 
 1097 14a0 00000000 		or	%s59,0,%s41
 1097      A9003B45 
 1098 14a8 00000000 		muls.l	%s56,%s58,%s6
 1098      86BA386E 
 1099 14b0 00000000 		or	%s60,0,%s6
 1099      86003C45 
 1100 14b8 F8FEFFFF 		br.l	.L3.18
 1100      00000F18 
 1101              	.L3.22:
 1102              	# line 192
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t wei_off0=  wei_off_f2(p, g, oc, 0, kh, kw);
 1103              		.loc	1 192 0
 1104 14c0 00000000 		divs.l	%s55,%s57,%s56
 1104      B8B9377F 
 1105 14c8 00000000 		adds.l	%s55,%s55,%s54
 1105      B6B73759 
 1106 14d0 00000000 		muls.l	%s55,%s55,%s53
 1106      B5B7376E 
 1107 14d8 00000000 		adds.l	%s55,%s55,%s52
 1107      B4B73759 
 1108 14e0 00000000 		muls.l	%s55,%s55,%s51
 1108      B3B7376E 
 1109 14e8 00000000 		adds.l	%s55,%s18,%s55
 1109      B7923759 
 1110              	# line 193
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 1111              		.loc	1 193 0
 1112 14f0 00000000 		divu.l	%s42,%s50,%s49
 1112      B1B22A6F 
 1113 14f8 00000000 		addu.l	%s42,%s42,%s47
 1113      AFAA2A48 
 1114 1500 00000000 		mulu.l	%s42,%s42,%s48
 1114      B0AA2A49 
 1115 1508 00000000 		divu.l	%s42,%s42,%s49
 1115      B1AA2A6F 
 1116 1510 00000000 		mulu.l	%s42,%s42,%s46
 1116      AEAA2A49 
 1117 1518 00000000 		addu.l	%s42,%s42,%s45
 1117      ADAA2A48 
 1118 1520 00000000 		mulu.l	%s42,%s42,%s44
 1118      ACAA2A49 
 1119 1528 00000000 		or	%s41,0,%s59
 1119      BB002945 
 1120 1530 00000000 		addu.l	%s41,%s42,%s41
 1120      A9AA2948 
 1121 1538 00000000 		or	%s41,0,%s41
 1121      A9002945 
 1122 1540 C8FEFFFF 		brlt.l	0,%s43,.L3.21
 1122      AB000218 
 1123 1548 48000000 		br.l	.L3.20
 1123      00000F18 
 1124              	.L3.23:
 1125 1550 40000000 		brle.l	0,%s60,.L3.20
 1125      BC000618 
 1126 1558 68FFFFFF 		br.l	.L3.22
 1126      00000F18 
 1127              	.L3.24:
 1128 1560 00000000 		or	%s63,0,%s4
 1128      84003F45 
 1129 1568 00000000 		or	%s60,0,%s1
 1129      81003C45 
 1130 1570 00000000 		or	%s59,0,%s3
 1130      83003B45 
 1131 1578 00000000 		or	%s55,0,%s19
 1131      93003745 
 1132 1580 00000000 		or	%s42,0,%s2
 1132      82002A45 
 1133 1588 A8040000 		br.l	.L3.25
 1133      00000F18 
 1134              	.L3.20:
 1135              	# line 188
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t iw = iw0 + kw * DW;
 1136              		.loc	1 188 0
 1137 1590 00000000 		adds.l	%s63,1,%s63
 1137      BF013F59 
 1138 1598 00000000 		adds.l	%s60,%s62,%s60
 1138      BCBE3C59 
 1139 15a0 00000000 		adds.l	%s18,%s62,%s18
 1139      92BE1259 
 1140 15a8 00000000 		adds.l	%s59,1,%s59
 1140      BB013B59 
 1141 15b0 10000000 		brgt.l	0,%s63,.L3.26
 1141      BF000118 
 1142 15b8 A8FFFFFF 		br.l	.L3.24
 1142      00000F18 
 1143              	.L3.26:
 1144 15c0 D0FFFFFF 		brgt.l	0,%s18,.L3.20
 1144      92000118 
 1145 15c8 88FFFFFF 		br.l	.L3.23
 1145      00000F18 
 1146              	.L3.27:
 1147 15d0 00000000 		or	%s41,0,%s45
 1147      AD002945 
 1148 15d8 00000000 		or	%s45,0,%s55
 1148      B7002D45 
 1149 15e0 00000000 		or	%s1,0,%s60
 1149      BC000145 
 1150 15e8 00000000 		or	%s2,0,%s42
 1150      AA000245 
 1151 15f0 00000000 		or	%s3,0,%s59
 1151      BB000345 
 1152 15f8 00000000 		or	%s59,0,%s41
 1152      A9003B45 
 1153 1600 00000000 		or	%s4,0,%s63
 1153      BF000445 
 1154 1608 00000000 		or	%s63,0,%s30
 1154      9E003F45 
 1155 1610 00000000 		or	%s60,0,%s29
 1155      9D003C45 
 1156 1618 00000000 		or	%s18,0,%s28
 1156      9C001245 
 1157 1620 00000000 		or	%s19,0,%s55
 1157      B7001345 
 1158 1628 98FFFFFF 		br.l	.L3.26
 1158      00000F18 
 1159              	.L3.28:
 1160 1630 00000000 		or	%s45,0,(0)1
 1160      00002D45 
 1161 1638 98FFFFFF 		brlt.l	0,%s42,.L3.27
 1161      AA000218 
 1162 1640 F0030000 		br.l	.L3.25
 1162      00000F18 
 1163              	.L3.29:
 1164 1648 E8030000 		brle.l	0,%s59,.L3.25
 1164      BB000618 
 1165 1650 E0FFFFFF 		br.l	.L3.28
 1165      00000F18 
 1166              	.L3.30:
 1167              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 1168              		.loc	1 239 0
 1169              	# Start of epilogue codes
 1170 1658 30000000 		ld	%s18,48(,%fp)
 1170      89001201 
 1171 1660 38000000 		ld	%s19,56(,%fp)
 1171      89001301 
 1172 1668 40000000 		ld	%s20,64(,%fp)
 1172      89001401 
 1173 1670 48000000 		ld	%s21,72(,%fp)
 1173      89001501 
 1174 1678 50000000 		ld	%s22,80(,%fp)
 1174      89001601 
 1175 1680 58000000 		ld	%s23,88(,%fp)
 1175      89001701 
 1176 1688 60000000 		ld	%s24,96(,%fp)
 1176      89001801 
 1177 1690 68000000 		ld	%s25,104(,%fp)
 1177      89001901 
 1178 1698 70000000 		ld	%s26,112(,%fp)
 1178      89001A01 
 1179 16a0 78000000 		ld	%s27,120(,%fp)
 1179      89001B01 
 1180 16a8 80000000 		ld	%s28,128(,%fp)
 1180      89001C01 
 1181 16b0 88000000 		ld	%s29,136(,%fp)
 1181      89001D01 
 1182 16b8 90000000 		ld	%s30,144(,%fp)
 1182      89001E01 
 1183 16c0 98000000 		ld	%s31,152(,%fp)
 1183      89001F01 
 1184 16c8 A0000000 		ld	%s32,160(,%fp)
 1184      89002001 
 1185 16d0 A8000000 		ld	%s33,168(,%fp)
 1185      89002101 
 1186 16d8 00000000 		or	%sp,0,%fp
 1186      89000B45 
 1187              		.cfi_def_cfa	11,8
 1188 16e0 18000000 		ld	%got,0x18(,%sp)
 1188      8B000F01 
 1189 16e8 20000000 		ld	%plt,0x20(,%sp)
 1189      8B001001 
 1190 16f0 08000000 		ld	%lr,0x8(,%sp)
 1190      8B000A01 
 1191 16f8 00000000 		ld	%fp,0x0(,%sp)
 1191      8B000901 
 1192 1700 00000000 		b.l	(,%lr)
 1192      8A000F19 
 1193              	.L3.31:
 1194 1708 50FFFFFF 		br.l	.L3.30
 1194      00000F18 
 1195              	.L3.32:
 1196              	# line 165
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 1197              		.loc	1 165 0
 1198 1710 00000000 		adds.l	%s63,1,%s63
 1198      BF013F59 
 1199 1718 00000000 		adds.l	%s60,1,%s60
 1199      BC013C59 
 1200 1720 68070000 		brgt.l	0,%s63,.L3.33
 1200      BF000118 
 1201 1728 E0FFFFFF 		br.l	.L3.31
 1201      00000F18 
 1202              	.L3.34:
 1203 1730 D8FDFFFF 		ld	%s63,-552(,%fp)	# restore 
 1203      89003F01 
 1204 1738 E0FDFFFF 		ld	%s20,-544(,%fp)	# restore 
 1204      89001401 
 1205 1740 D0FDFFFF 		ld	%s59,-560(,%fp)	# restore 
 1205      89003B01 
 1206 1748 C8FFFFFF 		br.l	.L3.32
 1206      00000F18 
 1207              	.L3.35:
 1208              	# line 166
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < OCOG; ++oc) {
 1209              		.loc	1 166 0
 1210 1750 00000000 		adds.l	%s63,1,%s63
 1210      BF013F59 
 1211 1758 00000000 		adds.l	%s62,1,%s62
 1211      BE013E59 
 1212 1760 E0060000 		brgt.l	0,%s63,.L3.36
 1212      BF000118 
 1213 1768 C8FFFFFF 		br.l	.L3.34
 1213      00000F18 
 1214              	.L3.37:
 1215 1770 F0FDFFFF 		ld	%s63,-528(,%fp)	# restore 
 1215      89003F01 
 1216 1778 F8FDFFFF 		ld	%s21,-520(,%fp)	# restore 
 1216      89001501 
 1217 1780 E8FDFFFF 		ld	%s57,-536(,%fp)	# restore 
 1217      89003901 
 1218 1788 C8FFFFFF 		br.l	.L3.35
 1218      00000F18 
 1219              	.L3.38:
 1220              	# line 167
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 1221              		.loc	1 167 0
 1222 1790 00000000 		adds.l	%s63,1,%s63
 1222      BF013F59 
 1223 1798 00000000 		adds.l	%s59,1,%s59
 1223      BB013B59 
 1224 17a0 60060000 		brgt.l	0,%s63,.L3.39
 1224      BF000118 
 1225 17a8 C8FFFFFF 		br.l	.L3.37
 1225      00000F18 
 1226              	.L3.40:
 1227 17b0 08FEFFFF 		ld	%s63,-504(,%fp)	# restore 
 1227      89003F01 
 1228 17b8 10FEFFFF 		ld	%s19,-496(,%fp)	# restore 
 1228      89001301 
 1229 17c0 00FEFFFF 		ld	%s58,-512(,%fp)	# restore 
 1229      89003A01 
 1230 17c8 C8FFFFFF 		br.l	.L3.38
 1230      00000F18 
 1231              	.L3.41:
 1232              	# line 168
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 1233              		.loc	1 168 0
 1234 17d0 00000000 		adds.l	%s63,1,%s63
 1234      BF013F59 
 1235 17d8 00000000 		adds.l	%s57,1,%s57
 1235      B9013959 
 1236 17e0 D0050000 		brgt.l	0,%s63,.L3.42
 1236      BF000118 
 1237 17e8 C8FFFFFF 		br.l	.L3.40
 1237      00000F18 
 1238              	.L3.43:
 1239 17f0 20FEFFFF 		ld	%s63,-480(,%fp)	# restore 
 1239      89003F01 
 1240 17f8 00000000 		or	%s57,0,%s30
 1240      9E003945 
 1241 1800 00000000 		or	%s59,0,%s29
 1241      9D003B45 
 1242 1808 00000000 		or	%s62,0,%s27
 1242      9B003E45 
 1243 1810 00000000 		or	%s60,0,%s28
 1243      9C003C45 
 1244 1818 28FEFFFF 		ld	%s18,-472(,%fp)	# restore 
 1244      89001201 
 1245 1820 00000000 		or	%s54,0,%s31
 1245      9F003645 
 1246 1828 18FEFFFF 		ld	%s61,-488(,%fp)	# restore 
 1246      89003D01 
 1247 1830 A0FFFFFF 		br.l	.L3.41
 1247      00000F18 
 1248              	.L3.44:
 1249 1838 00000000 		or	%s54,0,%s31
 1249      9F003645 
 1250 1840 00000000 		or	%s57,0,%s30
 1250      9E003945 
 1251 1848 00000000 		or	%s59,0,%s29
 1251      9D003B45 
 1252 1850 00000000 		or	%s60,0,%s28
 1252      9C003C45 
 1253 1858 00000000 		or	%s62,0,%s27
 1253      9B003E45 
 1254 1860 58040000 		br.l	.L3.45
 1254      00000F18 
 1255              	.L3.46:
 1256              	# line 169
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 1257              		.loc	1 169 0
 1258 1868 00000000 		adds.l	%s33,1,%s33
 1258      A1012159 
 1259 1870 00000000 		adds.l	%s56,1,%s32
 1259      A0013859 
 1260 1878 C0FFFFFF 		brgt.l	0,%s33,.L3.44
 1260      A1000118 
 1261 1880 70FFFFFF 		br.l	.L3.43
 1261      00000F18 
 1262              	.L3.47:
 1263              	# line 233
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 1264              		.loc	1 233 0
 1265 1888 00000000 		or	%s63,0,(0)1
 1265      00003F45 
 1266 1890 78FEFFFF 		ld	%s39,-392(,%fp)	# restore 
 1266      89002701 
 1267 1898 00000000 		stu	%s63,0(,%s39)	# *(d)
 1267      A7003F12 
 1268 18a0 C8FFFFFF 		br.l	.L3.46
 1268      00000F18 
 1269              	.L3.48:
 1270 18a8 78FEFFFF 		ld	%s39,-392(,%fp)	# restore 
 1270      89002701 
 1271              	# line 232
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d = 0.f;
 1272              		.loc	1 232 0
 1273 18b0 00000000 		ldu	%s18,0(,%s39)	# *(d)
 1273      A7001202 
 1274 18b8 00000000 		or	%s19,0,(0)1
 1274      00001345 
 1275 18c0 C8FFFFFF 		brgt.s	%s19,%s18,.L3.47
 1275      9293C118 
 1276 18c8 A0FFFFFF 		br.l	.L3.46
 1276      00000F18 
 1277              	.L3.49:
 1278 18d0 78FEFFFF 		st	%s1,-392(,%fp)	# spill 
 1278      89000111 
 1279 18d8 00000000 		or	%s0,0,%s23
 1279      97000045 
 1280              	# line 230
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 1281              		.loc	1 230 0
 1282 18e0 00000000 		lea	%s12,conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const@LO
 1282      00000C06 
 1283 18e8 00000000 		and	%s12,%s12,(32)0
 1283      608C0C44 
 1284 18f0 00000000 		lea.sl	%s12,conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const@HI(,%s12)
 1284      8C008C06 
 1285 18f8 00000000 		bsic	%lr,(,%s12)	# conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&)#1}::operator()(float&) const
 1285      8C000A08 
 1286              	# line 232
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d = 0.f;
 1287              		.loc	1 232 0
 1288 1900 B0000000 		ld	%s63,176(,%fp)	# p
 1288      89003F01 
 1289 1908 5C000000 		ldl.zx	%s63,92(,%s63)	# *(p).merge
 1289      BF00BF03 
 1290 1910 00000000 		adds.w.sx	%s63,0,%s63
 1290      BF003F4A 
 1291 1918 90FFFFFF 		breq.w	1,%s63,.L3.48
 1291      BF018418 
 1292 1920 48FFFFFF 		br.l	.L3.46
 1292      00000F18 
 1293              	.L3.50:
 1294              	# line 226
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 d += pbia[bia_off];
 1295              		.loc	1 226 0
 1296 1928 14000000 		ldl.sx	%s62,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 1296      BF003E03 
 1297 1930 00000000 		or	%s62,0,%s62
 1297      BE003E45 
 1298 1938 00000000 		muls.l	%s62,%s62,%s28
 1298      9CBE3E6E 
 1299 1940 00000000 		ldl.sx	%s63,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 1299      BF003F03 
 1300 1948 00000000 		or	%s63,0,%s63
 1300      BF003F45 
 1301 1950 00000000 		divs.l	%s63,%s62,%s63
 1301      BFBE3F7F 
 1302 1958 00000000 		adds.l	%s63,%s63,%s29
 1302      9DBF3F59 
 1303              	# line 227
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 1304              		.loc	1 227 0
 1305 1960 00000000 		ldu	%s62,0(,%s1)	# *(d)
 1305      81003E02 
 1306 1968 00000000 		muls.l	%s63,4,%s63
 1306      BF043F6E 
 1307 1970 00000000 		ldu	%s63,0(%s63,%s26)	# *(pbia)
 1307      9ABF3F02 
 1308 1978 00000000 		fadd.s	%s63,%s62,%s63
 1308      BFBEBF4C 
 1309 1980 00000000 		stu	%s63,0(,%s1)	# *(d)
 1309      81003F12 
 1310 1988 48FFFFFF 		br.l	.L3.49
 1310      00000F18 
 1311              	.L3.9:
 1312              	# line 225
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t bia_off = bia_off_f2(p, g, oc);
 1313              		.loc	1 225 0
 1314 1990 B0000000 		ld	%s63,176(,%fp)	# p
 1314      89003F01 
 1315 1998 48000000 		ldl.zx	%s55,72(,%s63)	# *(p).dir
 1315      BF00B703 
 1316 19a0 00000000 		adds.w.sx	%s55,0,%s55
 1316      B700374A 
 1317 19a8 04000000 		lea	%s53,4
 1317      00003506 
 1318 19b0 00000000 		and	%s53,%s55,%s53
 1318      B5B73544 
 1319 19b8 70FFFFFF 		brne.w	0,%s53,.L3.50
 1319      B5008318 
 1320 19c0 10FFFFFF 		br.l	.L3.49
 1320      00000F18 
 1321              	.L3.51:
 1322 19c8 40FEFFFF 		st	%s47,-448(,%fp)	# spill 
 1322      89002F11 
 1323 19d0 30FEFFFF 		st	%s58,-464(,%fp)	# spill 
 1323      89003A11 
 1324 19d8 38FEFFFF 		st	%s61,-456(,%fp)	# spill 
 1324      89003D11 
 1325 19e0 00000000 		or	%s1,0,%s39
 1325      A7000145 
 1326 19e8 00000000 		or	%s32,0,%s20
 1326      94002045 
 1327 19f0 00000000 		or	%s20,0,%s27
 1327      9B001445 
 1328 19f8 00000000 		or	%s30,0,%s21
 1328      95001E45 
 1329 1a00 00000000 		or	%s29,0,%s22
 1329      96001D45 
 1330 1a08 60FEFFFF 		ld	%s27,-416(,%fp)	# restore 
 1330      89001B01 
 1331 1a10 00000000 		or	%s31,0,%s24
 1331      98001F45 
 1332 1a18 68FEFFFF 		ld	%s28,-408(,%fp)	# restore 
 1332      89001C01 
 1333 1a20 00000000 		or	%s33,0,%s25
 1333      99002145 
 1334 1a28 68FFFFFF 		br.l	.L3.9
 1334      00000F18 
 1335              	.L3.25:
 1336              	# line 184
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih = ih0 + kh * DH;
 1337              		.loc	1 184 0
 1338 1a30 00000000 		adds.l	%s63,1,%s63
 1338      BF013F59 
 1339 1a38 00000000 		adds.l	%s59,%s60,%s59
 1339      BBBC3B59 
 1340 1a40 00000000 		adds.l	%s52,%s60,%s52
 1340      B4BC3459 
 1341 1a48 00000000 		adds.l	%s55,1,%s55
 1341      B7013759 
 1342 1a50 10000000 		brgt.l	0,%s63,.L3.52
 1342      BF000118 
 1343 1a58 70FFFFFF 		br.l	.L3.51
 1343      00000F18 
 1344              	.L3.52:
 1345 1a60 D0FFFFFF 		brgt.l	0,%s52,.L3.25
 1345      B4000118 
 1346 1a68 E0FBFFFF 		br.l	.L3.29
 1346      00000F18 
 1347              	.L3.53:
 1348 1a70 68FEFFFF 		st	%s28,-408(,%fp)	# spill 
 1348      89001C11 
 1349 1a78 60FEFFFF 		st	%s27,-416(,%fp)	# spill 
 1349      89001B11 
 1350 1a80 98FFFFFF 		ld	%s62,-104(,%fp)	# DW
 1350      89003E01 
 1351 1a88 00000000 		or	%s39,0,%s1
 1351      81002745 
 1352 1a90 90FFFFFF 		ld	%s60,-112(,%fp)	# DH
 1352      89003C01 
 1353 1a98 00000000 		or	%s21,0,%s30
 1353      9E001545 
 1354 1aa0 C8FFFFFF 		ld	%s43,-56(,%fp)	# ICOG
 1354      89002B01 
 1355 1aa8 00000000 		or	%s22,0,%s29
 1355      9D001645 
 1356 1ab0 40FEFFFF 		ld	%s47,-448(,%fp)	# restore 
 1356      89002F01 
 1357              	# line 194
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
 1358              		.loc	1 194 0
 1359 1ab8 00000000 		subs.l	%s45,0,%s43
 1359      AB002D5B 
 1360 1ac0 D0FFFFFF 		ld	%s42,-48(,%fp)	# KW
 1360      89002A01 
 1361 1ac8 00000000 		or	%s24,0,%s31
 1361      9F001845 
 1362 1ad0 00000000 		or	%s31,0,%s45
 1362      AD001F45 
 1363              	# line 188
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t iw = iw0 + kw * DW;
 1364              		.loc	1 188 0
 1365 1ad8 00000000 		subs.l	%s30,0,%s42
 1365      AA001E5B 
 1366 1ae0 D8FFFFFF 		ld	%s45,-40(,%fp)	# IW
 1366      89002D01 
 1367 1ae8 00000000 		or	%s25,0,%s33
 1367      A1001945 
 1368 1af0 E0FFFFFF 		ld	%s41,-32(,%fp)	# IH
 1368      89002901 
 1369 1af8 E8FFFFFF 		ld	%s33,-24(,%fp)	# pwei
 1369      89002101 
 1370 1b00 F0FFFFFF 		ld	%s40,-16(,%fp)	# psrc
 1370      89002801 
 1371              	# line 192
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t wei_off0=  wei_off_f2(p, g, oc, 0, kh, kw);
 1372              		.loc	1 192 0
 1373 1b08 B0000000 		dld	%s38,176(,%fp)	# p
 1373      89002609 
 1374 1b10 08000000 		dldl.sx	%s37,8(,%s38)	# *(p).__b_N4conv6desc_tE.ic
 1374      A600250B 
 1375 1b18 00000000 		or	%s36,0,%s37
 1375      A5002445 
 1376 1b20 00000000 		or	%s48,0,%s37
 1376      A5003045 
 1377 1b28 00000000 		muls.l	%s54,%s36,%s27
 1377      9BA4366E 
 1378 1b30 00000000 		or	%s27,0,%s20
 1378      94001B45 
 1379 1b38 00000000 		muls.l	%s57,%s36,%s28
 1379      9CA4396E 
 1380 1b40 00000000 		dldl.sx	%s37,0(,%s38)	# *(p).__b_N4conv6desc_tE.g
 1380      A600250B 
 1381 1b48 00000000 		or	%s28,0,%s52
 1381      B4001C45 
 1382 1b50 00000000 		or	%s56,0,%s37
 1382      A5003845 
 1383 1b58 00000000 		or	%s49,0,%s37
 1383      A5003145 
 1384 1b60 0C000000 		dldl.sx	%s37,12(,%s38)	# *(p).__b_N4conv6desc_tE.ih
 1384      A600250B 
 1385 1b68 00000000 		or	%s36,0,%s53
 1385      B5002445 
 1386 1b70 00000000 		or	%s53,0,%s37
 1386      A5003545 
 1387 1b78 10000000 		dldl.sx	%s37,16(,%s38)	# *(p).__b_N4conv6desc_tE.iw
 1387      A600250B 
 1388 1b80 00000000 		or	%s51,0,%s37
 1388      A5003345 
 1389              	# line 193
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 1390              		.loc	1 193 0
 1391 1b88 14000000 		dldl.sx	%s37,20(,%s38)	# *(p).__b_N4conv6desc_tE.oc
 1391      A600250B 
 1392 1b90 00000000 		or	%s37,0,%s37
 1392      A5002545 
 1393 1b98 00000000 		mulu.l	%s50,%s37,%s20
 1393      94A53249 
 1394 1ba0 20000000 		dldl.sx	%s37,32(,%s38)	# *(p).__b_N4conv6desc_tE.kh
 1394      A600250B 
 1395 1ba8 00000000 		or	%s20,0,%s32
 1395      A0001445 
 1396 1bb0 00000000 		or	%s32,0,%s40
 1396      A8002045 
 1397 1bb8 00000000 		or	%s46,0,%s37
 1397      A5002E45 
 1398 1bc0 24000000 		dldl.sx	%s38,36(,%s38)	# *(p).__b_N4conv6desc_tE.kw
 1398      A600260B 
 1399 1bc8 00000000 		or	%s44,0,%s38
 1399      A6002C45 
 1400              	# line 184
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih = ih0 + kh * DH;
 1401              		.loc	1 184 0
 1402 1bd0 00000000 		subs.l	%s18,0,%s18
 1402      9200125B 
 1403 1bd8 00000000 		or	%s63,0,%s18
 1403      92003F45 
 1404 1be0 00000000 		subs.l	%s41,%s36,%s41
 1404      A9A4295B 
 1405 1be8 00000000 		or	%s59,0,%s41
 1405      A9003B45 
 1406 1bf0 00000000 		or	%s41,0,%s52
 1406      B4002945 
 1407 1bf8 00000000 		or	%s52,0,%s36
 1407      A4003445 
 1408              	# line 188
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         const ssize_t iw = iw0 + kw * DW;
 1409              		.loc	1 188 0
 1410 1c00 00000000 		subs.l	%s29,%s41,%s45
 1410      ADA91D5B 
 1411 1c08 38FEFFFF 		ld	%s61,-456(,%fp)	# restore 
 1411      89003D01 
 1412 1c10 30FEFFFF 		ld	%s58,-464(,%fp)	# restore 
 1412      89003A01 
 1413 1c18 48FEFFFF 		br.l	.L3.52
 1413      00000F18 
 1414              	.L3.54:
 1415              	# line 182
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t iw0 = ow * SW - PW;
 1416              		.loc	1 182 0
 1417 1c20 B0FFFFFF 		ld	%s63,-80(,%fp)	# SH
 1417      89003F01 
 1418 1c28 00000000 		or	%s1,0,%s39
 1418      A7000145 
 1419 1c30 00000000 		or	%s32,0,%s56
 1419      B8002045 
 1420 1c38 00000000 		muls.l	%s63,%s63,%s57
 1420      B9BF3F6E 
 1421 1c40 C0FFFFFF 		ld	%s53,-64(,%fp)	# PH
 1421      89003501 
 1422 1c48 00000000 		or	%s30,0,%s57
 1422      B9001E45 
 1423 1c50 00000000 		or	%s29,0,%s59
 1423      BB001D45 
 1424 1c58 00000000 		subs.l	%s53,%s63,%s53
 1424      B5BF355B 
 1425              	# line 183
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t kh = 0; kh < KH; ++kh) {
 1426              		.loc	1 183 0
 1427 1c60 A8FFFFFF 		ld	%s63,-88(,%fp)	# SW
 1427      89003F01 
 1428 1c68 00000000 		or	%s27,0,%s62
 1428      BE001B45 
 1429 1c70 00000000 		or	%s28,0,%s60
 1429      BC001C45 
 1430 1c78 00000000 		muls.l	%s63,%s63,%s56
 1430      B8BF3F6E 
 1431 1c80 B8FFFFFF 		ld	%s52,-72(,%fp)	# PW
 1431      89003401 
 1432 1c88 00000000 		or	%s31,0,%s54
 1432      B6001F45 
 1433 1c90 00000000 		subs.l	%s52,%s63,%s52
 1433      B4BF345B 
 1434              	# line 184
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const ssize_t ih = ih0 + kh * DH;
 1435              		.loc	1 184 0
 1436 1c98 00000000 		or	%s55,0,(0)1
 1436      00003745 
 1437 1ca0 A0FFFFFF 		ld	%s18,-96(,%fp)	# KH
 1437      89001201 
 1438 1ca8 C8FDFFFF 		brlt.l	0,%s18,.L3.53
 1438      92000218 
 1439 1cb0 E0FCFFFF 		br.l	.L3.9
 1439      00000F18 
 1440              	.L3.45:
 1441              	# line 170
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             float &d = pdst[dst_off];
 1442              		.loc	1 170 0
 1443 1cb8 B0000000 		ld	%s63,176(,%fp)	# p
 1443      89003F01 
 1444 1cc0 14000000 		ldl.sx	%s53,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 1444      BF003503 
 1445 1cc8 00000000 		or	%s52,0,%s53
 1445      B5003445 
 1446 1cd0 00000000 		muls.l	%s51,%s52,%s62
 1446      BEB4336E 
 1447 1cd8 00000000 		muls.l	%s52,%s52,%s60
 1447      BCB4346E 
 1448 1ce0 00000000 		ldl.sx	%s50,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 1448      BF003203 
 1449 1ce8 00000000 		or	%s55,0,%s50
 1449      B2003745 
 1450 1cf0 00000000 		divs.l	%s52,%s52,%s55
 1450      B7B4347F 
 1451 1cf8 00000000 		adds.l	%s52,%s51,%s52
 1451      B4B33459 
 1452 1d00 00000000 		adds.l	%s52,%s52,%s59
 1452      BBB43459 
 1453 1d08 18000000 		ldl.sx	%s51,24(,%s63)	# *(p).__b_N4conv6desc_tE.oh
 1453      BF003303 
 1454 1d10 00000000 		or	%s51,0,%s51
 1454      B3003345 
 1455 1d18 00000000 		muls.l	%s51,%s52,%s51
 1455      B3B4336E 
 1456 1d20 00000000 		adds.l	%s51,%s51,%s57
 1456      B9B33359 
 1457 1d28 1C000000 		ldl.sx	%s52,28(,%s63)	# *(p).__b_N4conv6desc_tE.ow
 1457      BF003403 
 1458 1d30 00000000 		or	%s52,0,%s52
 1458      B4003445 
 1459 1d38 00000000 		muls.l	%s52,%s51,%s52
 1459      B4B3346E 
 1460 1d40 00000000 		adds.l	%s52,%s56,%s52
 1460      B4B83459 
 1461              	# line 171
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 1462              		.loc	1 171 0
 1463 1d48 00000000 		muls.l	%s52,4,%s52
 1463      B404346E 
 1464 1d50 00000000 		adds.l	%s39,%s52,%s54
 1464      B6B42759 
 1465              	# line 173
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if LAMB
 1466              		.loc	1 173 0
 1467 1d58 00000000 		or	%s52,0,(0)1
 1467      00003445 
 1468 1d60 00000000 		stu	%s52,0(,%s39)	# *(d)
 1468      A7003412 
 1469              	# line 181
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 const ssize_t ih0 = oh * SH - PH;
 1470              		.loc	1 181 0
 1471 1d68 C8FFFFFF 		ld	%s18,-56(,%fp)	# ICOG
 1471      89001201 
 1472 1d70 D0FFFFFF 		ld	%s42,-48(,%fp)	# KW
 1472      89002A01 
 1473 1d78 A8FEFFFF 		brgt.l	%s18,%s42,.L3.54
 1473      AA920118 
 1474 1d80 30F5FFFF 		br.l	.L3.16
 1474      00000F18 
 1475              	.L3.55:
 1476 1d88 28FEFFFF 		st	%s18,-472(,%fp)	# spill 
 1476      89001211 
 1477 1d90 20FEFFFF 		st	%s63,-480(,%fp)	# spill 
 1477      89003F11 
 1478 1d98 18FEFFFF 		st	%s61,-488(,%fp)	# spill 
 1478      89003D11 
 1479 1da0 00000000 		or	%s33,0,%s61
 1479      BD002145 
 1480 1da8 10FFFFFF 		br.l	.L3.45
 1480      00000F18 
 1481              	.L3.42:
 1482              	# line 169
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 1483              		.loc	1 169 0
 1484 1db0 00000000 		or	%s56,0,(0)1
 1484      00003845 
 1485 1db8 D0FFFFFF 		brlt.l	0,%s18,.L3.55
 1485      92000218 
 1486 1dc0 10FAFFFF 		br.l	.L3.41
 1486      00000F18 
 1487              	.L3.56:
 1488 1dc8 10FEFFFF 		st	%s19,-496(,%fp)	# spill 
 1488      89001311 
 1489 1dd0 08FEFFFF 		st	%s63,-504(,%fp)	# spill 
 1489      89003F11 
 1490 1dd8 00FEFFFF 		st	%s58,-512(,%fp)	# spill 
 1490      89003A11 
 1491 1de0 00000000 		or	%s47,0,%s59
 1491      BB002F45 
 1492 1de8 40FEFFFF 		st	%s47,-448(,%fp)	# spill 
 1492      89002F11 
 1493 1df0 00000000 		or	%s63,0,%s58
 1493      BA003F45 
 1494 1df8 B8FFFFFF 		br.l	.L3.42
 1494      00000F18 
 1495              	.L3.39:
 1496              	# line 168
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 1497              		.loc	1 168 0
 1498 1e00 00000000 		or	%s57,0,(0)1
 1498      00003945 
 1499 1e08 C0FFFFFF 		brlt.l	0,%s19,.L3.56
 1499      93000218 
 1500 1e10 80F9FFFF 		br.l	.L3.38
 1500      00000F18 
 1501              	.L3.57:
 1502 1e18 F8FDFFFF 		st	%s21,-520(,%fp)	# spill 
 1502      89001511 
 1503 1e20 F0FDFFFF 		st	%s63,-528(,%fp)	# spill 
 1503      89003F11 
 1504 1e28 E8FDFFFF 		st	%s57,-536(,%fp)	# spill 
 1504      89003911 
 1505 1e30 00000000 		or	%s63,0,%s57
 1505      B9003F45 
 1506 1e38 C8FFFFFF 		br.l	.L3.39
 1506      00000F18 
 1507              	.L3.36:
 1508              	# line 167
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 1509              		.loc	1 167 0
 1510 1e40 00000000 		or	%s59,0,(0)1
 1510      00003B45 
 1511 1e48 D0FFFFFF 		brlt.l	0,%s21,.L3.57
 1511      95000218 
 1512 1e50 00F9FFFF 		br.l	.L3.35
 1512      00000F18 
 1513              	.L3.58:
 1514 1e58 E0FDFFFF 		st	%s20,-544(,%fp)	# spill 
 1514      89001411 
 1515 1e60 D8FDFFFF 		st	%s63,-552(,%fp)	# spill 
 1515      89003F11 
 1516 1e68 D0FDFFFF 		st	%s59,-560(,%fp)	# spill 
 1516      89003B11 
 1517 1e70 00000000 		or	%s20,0,%s60
 1517      BC001445 
 1518 1e78 00000000 		or	%s63,0,%s59
 1518      BB003F45 
 1519 1e80 C0FFFFFF 		br.l	.L3.36
 1519      00000F18 
 1520              	.L3.33:
 1521              	# line 166
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < OCOG; ++oc) {
 1522              		.loc	1 166 0
 1523 1e88 00000000 		or	%s62,0,(0)1
 1523      00003E45 
 1524 1e90 C8FFFFFF 		brlt.l	0,%s20,.L3.58
 1524      94000218 
 1525 1e98 78F8FFFF 		br.l	.L3.32
 1525      00000F18 
 1526              	.L3.59:
 1527              	# line 230
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 1528              		.loc	1 230 0
 1529 1ea0 00000000 		adds.l	%s23,%fp,(61)1
 1529      3D891759 
 1530 1ea8 38FDFFFF 		ld	%s62,-712(,%fp)	# restore 
 1530      89003E01 
 1531 1eb0 00000000 		or	%s60,0,%s63
 1531      BF003C45 
 1532 1eb8 48FDFFFF 		ld	%s54,-696(,%fp)	# restore 
 1532      89003601 
 1533              	# line 165
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 1534              		.loc	1 165 0
 1535 1ec0 00000000 		subs.l	%s62,0,%s62
 1535      BE003E5B 
 1536 1ec8 00000000 		or	%s63,0,%s62
 1536      BE003F45 
 1537              	# line 166
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < OCOG; ++oc) {
 1538              		.loc	1 166 0
 1539 1ed0 00000000 		subs.l	%s59,0,%s20
 1539      94003B5B 
 1540              	# line 167
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 1541              		.loc	1 167 0
 1542 1ed8 00000000 		subs.l	%s57,0,%s21
 1542      9500395B 
 1543              	# line 168
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 1544              		.loc	1 168 0
 1545 1ee0 00000000 		subs.l	%s58,0,%s19
 1545      93003A5B 
 1546              	# line 169
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             const ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 1547              		.loc	1 169 0
 1548 1ee8 00000000 		subs.l	%s61,0,%s18
 1548      92003D5B 
 1549              	# line 194
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             //ssize_t src_off = src_off_f2(p, mb, g, ic, ih, iw);
 1550              		.loc	1 194 0
 1551 1ef0 00000000 		muls.l	%s52,4,%s52
 1551      B404346E 
 1552 1ef8 40FDFFFF 		ld	%s62,-704(,%fp)	# restore 
 1552      89003E01 
 1553 1f00 30FEFFFF 		st	%s52,-464(,%fp)	# spill 
 1553      89003411 
 1554 1f08 00000000 		muls.l	%s62,4,%s62
 1554      BE043E6E 
 1555 1f10 38FEFFFF 		st	%s62,-456(,%fp)	# spill 
 1555      89003E11 
 1556 1f18 70FFFFFF 		br.l	.L3.33
 1556      00000F18 
 1557              	.L3.0:
 1558 1f20 48FDFFFF 		st	%s54,-696(,%fp)	# spill 
 1558      89003611 
 1559 1f28 40FDFFFF 		st	%s58,-704(,%fp)	# spill 
 1559      89003A11 
 1560 1f30 38FDFFFF 		st	%s60,-712(,%fp)	# spill 
 1560      89003C11 
 1561 1f38 30FDFFFF 		st	%s63,-720(,%fp)	# spill 
 1561      89003F11 
 1562              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
 1563              		.loc	1 108 0
 1564 1f40 88FEFFFF 		st	%s49,-376(,%fp)
 1564      89003111 
 1565 1f48 90FEFFFF 		st	%s51,-368(,%fp)
 1565      89003311 
 1566 1f50 98FEFFFF 		st	%s48,-360(,%fp)
 1566      89003011 
 1567 1f58 A0FEFFFF 		st	%s50,-352(,%fp)
 1567      89003211 
 1568 1f60 A8FEFFFF 		st	%s53,-344(,%fp)
 1568      89003511 
 1569 1f68 B0FEFFFF 		st	%s47,-336(,%fp)
 1569      89002F11 
 1570 1f70 B8FEFFFF 		st	%s57,-328(,%fp)
 1570      89003911 
 1571 1f78 C0FEFFFF 		st	%s63,-320(,%fp)
 1571      89003F11 
 1572 1f80 C8FEFFFF 		st	%s55,-312(,%fp)
 1572      89003711 
 1573 1f88 D0FEFFFF 		st	%s46,-304(,%fp)
 1573      89002E11 
 1574 1f90 D8FEFFFF 		st	%s56,-296(,%fp)
 1574      89003811 
 1575 1f98 E0FEFFFF 		st	%s62,-288(,%fp)
 1575      89003E11 
 1576 1fa0 E8FEFFFF 		st	%s45,-280(,%fp)
 1576      89002D11 
 1577 1fa8 F0FEFFFF 		st	%s61,-272(,%fp)
 1577      89003D11 
 1578 1fb0 F8FEFFFF 		st	%s44,-264(,%fp)
 1578      89002C11 
 1579 1fb8 80000000 		lea	%s2,128
 1579      00000206 
 1580 1fc0 00000000 		or	%s1,0,%s59
 1580      BB000145 
 1581 1fc8 00000000 		or	%s0,0,%s43
 1581      AB000045 
 1582 1fd0 00000000 		lea	%s12,__vec_memcpy@LO
 1582      00000C06 
 1583 1fd8 00000000 		and	%s12,%s12,(32)0
 1583      608C0C44 
 1584 1fe0 00000000 		lea.sl	%s12,__vec_memcpy@HI(,%s12)
 1584      8C008C06 
 1585 1fe8 00000000 		bsic	%lr,(,%s12)	# __vec_memcpy
 1585      8C000A08 
 1586 1ff0 30FDFFFF 		ld	%s63,-720(,%fp)	# restore 
 1586      89003F01 
 1587 1ff8 38FDFFFF 		ld	%s60,-712(,%fp)	# restore 
 1587      89003C01 
 1588              	# line 151
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         if (!p->attr.oscale.is_def()) {
 1589              		.loc	1 151 0
 1590 2000 F8FFFFFF 		st	%s63,-8(,%fp)	# maybe_scale.p
 1590      89003F11 
 1591              	# line 165
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 1592              		.loc	1 165 0
 1593 2008 00000000 		or	%s63,0,(0)1
 1593      00003F45 
 1594 2010 90FEFFFF 		brlt.l	0,%s60,.L3.59
 1594      BC000218 
 1595 2018 40F6FFFF 		br.l	.L3.30
 1595      00000F18 
 1596              		.cfi_endproc
 1597              		.set	.L.4.2auto_size,	0xfffffffffffffb10	# 1264 Bytes
 1599              	# ============ End  conv::sxconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1600              	# ============ Begin  conv::sxconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1601              		.balign 16
 1602              	# line 242
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict const pdiff_src = (float*)diff_src_m;
 1603              		.loc	1 242 0
 1604              		.globl	conv::sxconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 1606              	conv::sxconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 1607              		.cfi_startproc
 1608 2020 00000000 		st	%fp,0x0(,%sp)
 1608      8B000911 
 1609              		.cfi_def_cfa_offset	0
 1610              		.cfi_offset	9,0
 1611 2028 08000000 		st	%lr,0x8(,%sp)
 1611      8B000A11 
 1612 2030 18000000 		st	%got,0x18(,%sp)
 1612      8B000F11 
 1613 2038 20000000 		st	%plt,0x20(,%sp)
 1613      8B001011 
 1614 2040 00000000 		or	%fp,0,%sp
 1614      8B000945 
 1615              		.cfi_def_cfa_register	9
 1616 2048 30000000 		st	%s18,48(,%fp)
 1616      89001211 
 1617 2050 38000000 		st	%s19,56(,%fp)
 1617      89001311 
 1618 2058 40000000 		st	%s20,64(,%fp)
 1618      89001411 
 1619 2060 48000000 		st	%s21,72(,%fp)
 1619      89001511 
 1620 2068 50000000 		st	%s22,80(,%fp)
 1620      89001611 
 1621 2070 58000000 		st	%s23,88(,%fp)
 1621      89001711 
 1622 2078 60000000 		st	%s24,96(,%fp)
 1622      89001811 
 1623 2080 68000000 		st	%s25,104(,%fp)
 1623      89001911 
 1624 2088 70000000 		st	%s26,112(,%fp)
 1624      89001A11 
 1625 2090 78000000 		st	%s27,120(,%fp)
 1625      89001B11 
 1626 2098 80000000 		st	%s28,128(,%fp)
 1626      89001C11 
 1627 20a0 88000000 		st	%s29,136(,%fp)
 1627      89001D11 
 1628 20a8 90000000 		st	%s30,144(,%fp)
 1628      89001E11 
 1629 20b0 98000000 		st	%s31,152(,%fp)
 1629      89001F11 
 1630 20b8 A0000000 		st	%s32,160(,%fp)
 1630      89002011 
 1631 20c0 A8000000 		st	%s33,168(,%fp)
 1631      89002111 
 1632 20c8 70FDFFFF 		lea	%s13,.L.5.2auto_size&0xffffffff
 1632      00000D06 
 1633 20d0 00000000 		and	%s13,%s13,(32)0
 1633      608D0D44 
 1634 20d8 FFFFFFFF 		lea.sl	%sp,.L.5.2auto_size>>32(%fp,%s13)
 1634      8D898B06 
 1635 20e0 48000000 		brge.l.t	%sp,%sl,.L4.EoP
 1635      888B3518 
 1636 20e8 18000000 		ld	%s61,0x18(,%tp)
 1636      8E003D01 
 1637 20f0 00000000 		or	%s62,0,%s0
 1637      80003E45 
 1638 20f8 3B010000 		lea	%s63,0x13b
 1638      00003F06 
 1639 2100 00000000 		shm.l	%s63,0x0(%s61)
 1639      BD033F31 
 1640 2108 08000000 		shm.l	%sl,0x8(%s61)
 1640      BD030831 
 1641 2110 10000000 		shm.l	%sp,0x10(%s61)
 1641      BD030B31 
 1642 2118 00000000 		monc
 1642      0000003F 
 1643 2120 00000000 		or	%s0,0,%s62
 1643      BE000045 
 1644              	.L4.EoP:
 1645              	# End of prologue codes
 1646              	# line 243
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const pwei = (float*)wei_m;
 1647              		.loc	1 243 0
 1648 2128 A8010000 		ld	%s52,424(,%s1)	# *(diff_src_m).data_
 1648      81003401 
 1649              	# line 244
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const pdiff_dst = (float*)diff_dst_m;
 1650              		.loc	1 244 0
 1651 2130 A8010000 		ld	%s46,424(,%s2)	# *(wei_m).data_
 1651      82002E01 
 1652              	# line 245
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t G = p->g;
 1653              		.loc	1 245 0
 1654 2138 A8010000 		ld	%s45,424(,%s3)	# *(diff_dst_m).data_
 1654      83002D01 
 1655              	# line 246
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t MB = p->mb;
 1656              		.loc	1 246 0
 1657 2140 00000000 		ldl.sx	%s32,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 1657      80002003 
 1658 2148 00000000 		or	%s25,0,%s32
 1658      A0001945 
 1659              	# line 247
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IC = p->ic;
 1660              		.loc	1 247 0
 1661 2150 04000000 		ldl.sx	%s63,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 1661      80003F03 
 1662 2158 00000000 		or	%s24,0,%s63
 1662      BF001845 
 1663              	# line 248
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IH = p->ih;
 1664              		.loc	1 248 0
 1665 2160 08000000 		ldl.sx	%s48,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 1665      80003003 
 1666 2168 00000000 		or	%s63,0,%s48
 1666      B0003F45 
 1667              	# line 262
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 1668              		.loc	1 262 0
 1669 2170 00000000 		divs.l	%s23,%s63,%s25
 1669      99BF177F 
 1670              	# line 249
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t IW = p->iw;
 1671              		.loc	1 249 0
 1672 2178 0C000000 		ldl.sx	%s63,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 1672      80003F03 
 1673 2180 00000000 		or	%s22,0,%s63
 1673      BF001645 
 1674              	# line 250
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OC = p->oc;
 1675              		.loc	1 250 0
 1676 2188 10000000 		ldl.sx	%s62,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 1676      80003E03 
 1677 2190 00000000 		or	%s21,0,%s62
 1677      BE001545 
 1678              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH = p->oh;
 1679              		.loc	1 251 0
 1680 2198 14000000 		ldl.sx	%s61,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 1680      80003D03 
 1681 21a0 00000000 		or	%s61,0,%s61
 1681      BD003D45 
 1682              	# line 264
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OH_OW = OH * OW;
 1683              		.loc	1 264 0
 1684 21a8 00000000 		divs.l	%s53,%s61,%s25
 1684      99BD357F 
 1685              	# line 252
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OW = p->ow;
 1686              		.loc	1 252 0
 1687 21b0 18000000 		ldl.sx	%s20,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 1687      80001403 
 1688 21b8 00000000 		or	%s60,0,%s20
 1688      94003C45 
 1689              	# line 253
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KH = p->kh;
 1690              		.loc	1 253 0
 1691 21c0 1C000000 		ldl.sx	%s19,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 1691      80001303 
 1692 21c8 00000000 		or	%s39,0,%s19
 1692      93002745 
 1693              	# line 265
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if LAMB
 1694              		.loc	1 265 0
 1695 21d0 00000000 		muls.l	%s59,%s60,%s39
 1695      A7BC3B6E 
 1696              	# line 254
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t KW = p->kw;
 1697              		.loc	1 254 0
 1698 21d8 20000000 		ldl.sx	%s18,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 1698      80001203 
 1699 21e0 00000000 		or	%s49,0,%s18
 1699      92003145 
 1700              	# line 263
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OCOG = OC / G;
 1701              		.loc	1 263 0
 1702 21e8 00000000 		muls.l	%s58,%s23,%s49
 1702      B1973A6E 
 1703              	# line 255
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t PH = p->ph;
 1704              		.loc	1 255 0
 1705 21f0 24000000 		ldl.sx	%s51,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 1705      80003303 
 1706 21f8 00000000 		or	%s57,0,%s51
 1706      B3003945 
 1707              	# line 263
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t OCOG = OC / G;
 1708              		.loc	1 263 0
 1709 2200 00000000 		muls.l	%s56,%s58,%s57
 1709      B9BA386E 
 1710 2208 D8080000 		brlt.l	0,%s25,.L4.0
 1710      99000218 
 1711 2210 80030000 		br.l	.L4.1
 1711      00000F18 
 1712              	.L4.2:
 1713              	# line 320
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         //int dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1714              		.loc	1 320 0
 1715 2218 80000000 		mins.l	%s60,%s55,%s60
 1715      BCB73C68 
 1716 2220 98000000 		br.l	.L4.3
 1716      00000F18 
 1717              	.L4.4:
 1718              	# line 325
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 1719              		.loc	1 325 0
 1720 2228 00000000 		or	%s61,1,(0)1
 1720      00013D45 
 1721 2230 00000000 		or	%s57,0,%s58
 1721      BA003945 
 1722 2238 00000000 		lvl	%s61
 1722      00BD00BF 
 1723 2240 0000003C 		vstu.nc	%v60,0,%s57
 1723      B9000092 
 1724 2248 58020000 		br.l	.L4.5
 1724      00000F18 
 1725              	.L4.6:
 1726 2250 00000000 		or	%s1,0,%s61
 1726      BD000145 
 1727 2258 00000000 		or	%s2,0,%s58
 1727      BA000245 
 1728              	# line 323
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             * pwei     [wei_off0 + oc*ICOG_KH_KW];
 1729              		.loc	1 323 0
 1730 2260 00000000 		lvl	%s52
 1730      00B400BF 
 1731 2268 00003F3B 		vfsum.s	%v59,%v63
 1731      000080EC 
 1732 2270 00000000 		or	%s61,1,(0)1
 1732      00013D45 
 1733 2278 00000000 		lvl	%s61
 1733      00BD00BF 
 1734 2280 003B3C3C 		vfadd.s	%v60,%v60,%v59
 1734      000080CC 
 1735 2288 00000000 		or	%s63,0,%s51
 1735      B3003F45 
 1736 2290 00000000 		or	%s62,0,%s50
 1736      B2003E45 
 1737 2298 00000000 		or	%s60,0,%s49
 1737      B1003C45 
 1738 22a0 00000000 		or	%s59,0,%s48
 1738      B0003B45 
 1739 22a8 00000000 		or	%s58,0,%s47
 1739      AF003A45 
 1740 22b0 78FFFFFF 		br.l	.L4.4
 1740      00000F18 
 1741              	.L4.3:
 1742 22b8 00000000 		or	%s62,0,%s63
 1742      BF003E45 
 1743 22c0 00000000 		lvl	%s60
 1743      00BC00BF 
 1744 22c8 0000003E 		vldu.nc	%v62,%s61,%s62
 1744      BEBD0082 
 1745 22d0 00000000 		or	%s62,0,%s59
 1745      BB003E45 
 1746 22d8 0000003D 		vldu.nc	%v61,%s58,%s62
 1746      BEBA0082 
 1747 22e0 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 1747      000080E2 
 1748              	# line 320
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         //int dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1749              		.loc	1 320 0
 1750 22e8 00000000 		adds.l	%s63,%s63,%s57
 1750      B9BF3F59 
 1751 22f0 00000000 		adds.l	%s59,%s59,%s56
 1751      B8BB3B59 
 1752 22f8 00000000 		subs.l	%s55,%s55,%s60
 1752      BCB7375B 
 1753 2300 50FFFFFF 		brge.l	0,%s55,.L4.6
 1753      B7000518 
 1754 2308 10FFFFFF 		br.l	.L4.2
 1754      00000F18 
 1755              	.L4.7:
 1756 2310 00000000 		or	%s46,0,%s55
 1756      B7002E45 
 1757 2318 00000000 		muls.l	%s46,4,%s46
 1757      AE042E6E 
 1758 2320 00000000 		or	%s61,0,%s1
 1758      81003D45 
 1759 2328 00000000 		or	%s48,0,%s59
 1759      BB003045 
 1760 2330 00000000 		adds.l	%s46,%s46,%s45
 1760      ADAE2E59 
 1761 2338 00000000 		subs.l	%s43,0,%s44
 1761      AC002B5B 
 1762 2340 00000000 		smvl	%s52
 1762      0000342E 
 1763 2348 80000000 		mins.l	%s42,%s43,%s52
 1763      B4AB2A68 
 1764              	# line 323
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                             * pwei     [wei_off0 + oc*ICOG_KH_KW];
 1765              		.loc	1 323 0
 1766 2350 00000000 		or	%s41,0,(0)1
 1766      00002945 
 1767 2358 00000000 		or	%s47,0,%s58
 1767      BA002F45 
 1768 2360 00000000 		or	%s58,0,%s2
 1768      82003A45 
 1769 2368 00000000 		or	%s49,0,%s60
 1769      BC003145 
 1770 2370 00000000 		or	%s51,0,%s63
 1770      BF003345 
 1771 2378 00000000 		or	%s50,0,%s62
 1771      BE003245 
 1772 2380 00000000 		lvl	%s52
 1772      00B400BF 
 1773 2388 0000003F 		vbrdu	%v63,%s41
 1773      00A9808C 
 1774 2390 00000000 		or	%s55,0,%s43
 1774      AB003745 
 1775 2398 00000000 		or	%s63,0,%s46
 1775      AE003F45 
 1776              	# line 320
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         //int dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1777              		.loc	1 320 0
 1778 23a0 00000000 		muls.l	%s57,%s1,%s42
 1778      AA81396E 
 1779 23a8 00000000 		or	%s59,0,%s60
 1779      BC003B45 
 1780 23b0 00000000 		muls.l	%s56,%s2,%s42
 1780      AA82386E 
 1781 23b8 00000000 		or	%s60,0,%s42
 1781      AA003C45 
 1782 23c0 F8FEFFFF 		br.l	.L4.3
 1782      00000F18 
 1783              	.L4.8:
 1784 23c8 00000000 		or	%s52,1,(0)1
 1784      00013445 
 1785 23d0 00000000 		or	%s51,0,%s58
 1785      BA003345 
 1786 23d8 00000000 		lvl	%s52
 1786      00B400BF 
 1787 23e0 0000003C 		vldu.nc	%v60,0,%s51
 1787      B3000082 
 1788 23e8 28FFFFFF 		brlt.l	0,%s53,.L4.7
 1788      B5000218 
 1789 23f0 38FEFFFF 		br.l	.L4.4
 1789      00000F18 
 1790              	.L4.9:
 1791 23f8 00000000 		or	%s55,0,%s57
 1791      B9003745 
 1792              	# line 318
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const size_t wei_off0 = ((((int)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + k
 1793              		.loc	1 318 0
 1794 2400 00000000 		adds.l	%s55,%s55,%s54
 1794      B6B73759 
 1795 2408 00000000 		or	%s55,0,%s55
 1795      B7003745 
 1796 2410 B8FFFFFF 		brlt.l	0,%s53,.L4.8
 1796      B5000218 
 1797 2418 88000000 		br.l	.L4.5
 1797      00000F18 
 1798              	.L4.10:
 1799 2420 80000000 		brge.w	%s57,%s19,.L4.5
 1799      93B98518 
 1800 2428 D0FFFFFF 		br.l	.L4.9
 1800      00000F18 
 1801              	.L4.11:
 1802              	# line 314
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ow /= p->sw;
 1803              		.loc	1 314 0
 1804 2430 00000000 		divs.w.sx	%s57,%s18,%s59
 1804      BB92397B 
 1805 2438 00000000 		muls.w.sx	%s56,%s59,%s57
 1805      B9BB384B 
 1806 2440 00000000 		subs.w.sx	%s56,%s18,%s56
 1806      B892385A 
 1807 2448 58000000 		brne.w	0,%s56,.L4.5
 1807      B8008318 
 1808 2450 D0FFFFFF 		br.l	.L4.10
 1808      00000F18 
 1809              	.L4.12:
 1810 2458 00000000 		or	%s63,0,%s6
 1810      86003F45 
 1811 2460 00000000 		or	%s60,0,%s7
 1811      87003C45 
 1812 2468 00000000 		or	%s18,0,%s5
 1812      85001245 
 1813 2470 00000000 		or	%s57,0,%s21
 1813      95003945 
 1814 2478 00000000 		or	%s56,0,%s22
 1814      96003845 
 1815 2480 00000000 		or	%s51,0,%s3
 1815      83003345 
 1816 2488 00000000 		or	%s55,0,%s4
 1816      84003745 
 1817 2490 B0030000 		br.l	.L4.13
 1817      00000F18 
 1818              	.L4.14:
 1819 2498 30000000 		br.l	.L4.15
 1819      00000F18 
 1820              	.L4.5:
 1821              	# line 312
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     int ow = iw - kw * (p->dw + 1) + p->pw;
 1822              		.loc	1 312 0
 1823 24a0 00000000 		adds.w.sx	%s63,1,%s63
 1823      BF013F4A 
 1824 24a8 00000000 		adds.w.sx	%s18,%s62,%s18
 1824      92BE124A 
 1825 24b0 00000000 		adds.l	%s60,4,%s60
 1825      BC043C59 
 1826 24b8 E0FFFFFF 		brgt.w	0,%s63,.L4.14
 1826      BF008118 
 1827 24c0 98FFFFFF 		br.l	.L4.12
 1827      00000F18 
 1828              	.L4.15:
 1829 24c8 D8FFFFFF 		brgt.w	0,%s18,.L4.5
 1829      92008118 
 1830 24d0 60FFFFFF 		br.l	.L4.11
 1830      00000F18 
 1831              	.L4.16:
 1832 24d8 00000000 		or	%s61,0,%s54
 1832      B6003D45 
 1833              	# line 318
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     const size_t wei_off0 = ((((int)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + k
 1834              		.loc	1 318 0
 1835 24e0 00000000 		adds.l	%s61,%s61,%s40
 1835      A8BD3D59 
 1836 24e8 00000000 		or	%s3,0,%s51
 1836      B3000345 
 1837 24f0 00000000 		muls.l	%s54,%s61,%s39
 1837      A7BD366E 
 1838 24f8 00000000 		or	%s4,0,%s55
 1838      B7000445 
 1839 2500 00000000 		or	%s5,0,%s18
 1839      92000545 
 1840 2508 00000000 		or	%s6,0,%s63
 1840      BF000645 
 1841 2510 00000000 		or	%s63,0,%s38
 1841      A6003F45 
 1842 2518 00000000 		or	%s18,0,%s37
 1842      A5001245 
 1843 2520 00000000 		or	%s7,0,%s60
 1843      BC000745 
 1844 2528 00000000 		or	%s60,0,%s56
 1844      B8003C45 
 1845 2530 00000000 		or	%s21,0,%s57
 1845      B9001545 
 1846 2538 00000000 		or	%s22,0,%s56
 1846      B8001645 
 1847 2540 88FFFFFF 		br.l	.L4.15
 1847      00000F18 
 1848              	.L4.17:
 1849 2548 90FFFFFF 		brlt.w	0,%s51,.L4.16
 1849      B3008218 
 1850 2550 F0020000 		br.l	.L4.13
 1850      00000F18 
 1851              	.L4.18:
 1852 2558 E8020000 		brge.w	%s54,%s20,.L4.13
 1852      94B68518 
 1853 2560 E8FFFFFF 		br.l	.L4.17
 1853      00000F18 
 1854              	.L4.19:
 1855              	# line 308
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 oh /= p->sh;
 1856              		.loc	1 308 0
 1857 2568 00000000 		divs.w.sx	%s54,%s18,%s55
 1857      B792367B 
 1858 2570 00000000 		muls.w.sx	%s52,%s55,%s54
 1858      B6B7344B 
 1859 2578 00000000 		subs.w.sx	%s52,%s18,%s52
 1859      B492345A 
 1860 2580 C0020000 		brne.w	0,%s52,.L4.13
 1860      B4008318 
 1861 2588 D0FFFFFF 		br.l	.L4.18
 1861      00000F18 
 1862              	.L4.1:
 1863              	# line 334
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 1864              		.loc	1 334 0
 1865              	# Start of epilogue codes
 1866 2590 30000000 		ld	%s18,48(,%fp)
 1866      89001201 
 1867 2598 38000000 		ld	%s19,56(,%fp)
 1867      89001301 
 1868 25a0 40000000 		ld	%s20,64(,%fp)
 1868      89001401 
 1869 25a8 48000000 		ld	%s21,72(,%fp)
 1869      89001501 
 1870 25b0 50000000 		ld	%s22,80(,%fp)
 1870      89001601 
 1871 25b8 58000000 		ld	%s23,88(,%fp)
 1871      89001701 
 1872 25c0 60000000 		ld	%s24,96(,%fp)
 1872      89001801 
 1873 25c8 68000000 		ld	%s25,104(,%fp)
 1873      89001901 
 1874 25d0 70000000 		ld	%s26,112(,%fp)
 1874      89001A01 
 1875 25d8 78000000 		ld	%s27,120(,%fp)
 1875      89001B01 
 1876 25e0 80000000 		ld	%s28,128(,%fp)
 1876      89001C01 
 1877 25e8 88000000 		ld	%s29,136(,%fp)
 1877      89001D01 
 1878 25f0 90000000 		ld	%s30,144(,%fp)
 1878      89001E01 
 1879 25f8 98000000 		ld	%s31,152(,%fp)
 1879      89001F01 
 1880 2600 A0000000 		ld	%s32,160(,%fp)
 1880      89002001 
 1881 2608 A8000000 		ld	%s33,168(,%fp)
 1881      89002101 
 1882 2610 00000000 		or	%sp,0,%fp
 1882      89000B45 
 1883              		.cfi_def_cfa	11,8
 1884 2618 18000000 		ld	%got,0x18(,%sp)
 1884      8B000F01 
 1885 2620 20000000 		ld	%plt,0x20(,%sp)
 1885      8B001001 
 1886 2628 08000000 		ld	%lr,0x8(,%sp)
 1886      8B000A01 
 1887 2630 00000000 		ld	%fp,0x0(,%sp)
 1887      8B000901 
 1888 2638 00000000 		b.l	(,%lr)
 1888      8A000F19 
 1889              	.L4.20:
 1890 2640 50FFFFFF 		br.l	.L4.1
 1890      00000F18 
 1891              	.L4.21:
 1892 2648 88040000 		br.l	.L4.22
 1892      00000F18 
 1893              	.L4.23:
 1894              	# line 295
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1895              		.loc	1 295 0
 1896 2650 00000000 		adds.l	%s63,1,%s63
 1896      BF013F59 
 1897 2658 00000000 		adds.w.sx	%s33,%s48,%s33
 1897      A1B0214A 
 1898 2660 00000000 		adds.l	%s41,%s47,%s41
 1898      A9AF2959 
 1899 2668 00000000 		adds.l	%s37,%s40,%s37
 1899      A5A82559 
 1900 2670 D8FFFFFF 		brgt.l	0,%s63,.L4.21
 1900      BF000118 
 1901 2678 C8FFFFFF 		br.l	.L4.20
 1901      00000F18 
 1902              	.L4.24:
 1903 2680 58FFFFFF 		ld	%s63,-168(,%fp)	# restore 
 1903      89003F01 
 1904 2688 68FFFFFF 		ld	%s48,-152(,%fp)	# restore 
 1904      89003001 
 1905 2690 50FFFFFF 		ld	%s47,-176(,%fp)	# restore 
 1905      89002F01 
 1906 2698 48FFFFFF 		ld	%s40,-184(,%fp)	# restore 
 1906      89002801 
 1907 26a0 40FFFFFF 		ld	%s37,-192(,%fp)	# restore 
 1907      89002501 
 1908 26a8 60FFFFFF 		ld	%s24,-160(,%fp)	# restore 
 1908      89001801 
 1909 26b0 38FFFFFF 		ld	%s35,-200(,%fp)	# restore 
 1909      89002301 
 1910 26b8 98FFFFFF 		br.l	.L4.23
 1910      00000F18 
 1911              	.L4.25:
 1912              	# line 296
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ic = 0; ic < ICOG; ++ic) {
 1913              		.loc	1 296 0
 1914 26c0 00000000 		adds.l	%s63,1,%s63
 1914      BF013F59 
 1915 26c8 00000000 		adds.l	%s48,%s56,%s48
 1915      B0B83059 
 1916 26d0 00000000 		adds.l	%s40,%s43,%s40
 1916      A8AB2859 
 1917 26d8 88030000 		brgt.l	0,%s63,.L4.26
 1917      BF000118 
 1918 26e0 A0FFFFFF 		br.l	.L4.24
 1918      00000F18 
 1919              	.L4.27:
 1920 26e8 98FFFFFF 		ld	%s63,-104(,%fp)	# restore 
 1920      89003F01 
 1921 26f0 90FFFFFF 		ld	%s56,-112(,%fp)	# restore 
 1921      89003801 
 1922 26f8 80FFFFFF 		ld	%s48,-128(,%fp)	# restore 
 1922      89003001 
 1923 2700 88FFFFFF 		ld	%s43,-120(,%fp)	# restore 
 1923      89002B01 
 1924 2708 A0FFFFFF 		ld	%s23,-96(,%fp)	# restore 
 1924      89001701 
 1925 2710 78FFFFFF 		ld	%s42,-136(,%fp)	# restore 
 1925      89002A01 
 1926 2718 70FFFFFF 		ld	%s41,-144(,%fp)	# restore 
 1926      89002901 
 1927 2720 A0FFFFFF 		br.l	.L4.25
 1927      00000F18 
 1928              	.L4.28:
 1929              	# line 297
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 1930              		.loc	1 297 0
 1931 2728 00000000 		adds.l	%s63,1,%s63
 1931      BF013F59 
 1932 2730 00000000 		adds.l	%s48,%s49,%s48
 1932      B0B13059 
 1933 2738 00000000 		adds.w.sx	%s47,1,%s47
 1933      AF012F4A 
 1934 2740 B0020000 		brgt.l	0,%s63,.L4.29
 1934      BF000118 
 1935 2748 A0FFFFFF 		br.l	.L4.27
 1935      00000F18 
 1936              	.L4.30:
 1937 2750 D0FFFFFF 		ld	%s63,-48(,%fp)	# restore 
 1937      89003F01 
 1938 2758 E0FFFFFF 		ld	%s49,-32(,%fp)	# restore 
 1938      89003101 
 1939 2760 C8FFFFFF 		ld	%s48,-56(,%fp)	# restore 
 1939      89003001 
 1940 2768 C0FFFFFF 		ld	%s47,-64(,%fp)	# restore 
 1940      89002F01 
 1941 2770 B0FFFFFF 		ld	%s58,-80(,%fp)	# restore 
 1941      89003A01 
 1942 2778 D8FFFFFF 		ld	%s22,-40(,%fp)	# restore 
 1942      89001601 
 1943 2780 A8FFFFFF 		ld	%s46,-88(,%fp)	# restore 
 1943      89002E01 
 1944 2788 B8FFFFFF 		ld	%s61,-72(,%fp)	# restore 
 1944      89003D01 
 1945 2790 98FFFFFF 		br.l	.L4.28
 1945      00000F18 
 1946              	.L4.31:
 1947              	# line 298
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int iw = 0; iw < IW; ++iw) {
 1948              		.loc	1 298 0
 1949 2798 00000000 		adds.l	%s63,1,%s63
 1949      BF013F59 
 1950 27a0 00000000 		adds.w.sx	%s35,1,%s35
 1950      A301234A 
 1951 27a8 00000000 		adds.w.sx	%s56,1,%s56
 1951      B801384A 
 1952 27b0 C0010000 		brgt.l	0,%s63,.L4.32
 1952      BF000118 
 1953 27b8 98FFFFFF 		br.l	.L4.30
 1953      00000F18 
 1954              	.L4.33:
 1955 27c0 00000000 		or	%s63,0,%s26
 1955      9A003F45 
 1956 27c8 00000000 		or	%s56,0,%s27
 1956      9B003845 
 1957 27d0 E8FFFFFF 		ld	%s50,-24(,%fp)	# restore 
 1957      89003201 
 1958 27d8 00000000 		or	%s21,0,%s25
 1958      99001545 
 1959 27e0 F0FFFFFF 		ld	%s52,-16(,%fp)	# restore 
 1959      89003401 
 1960 27e8 F8FFFFFF 		ld	%s54,-8(,%fp)	# restore 
 1960      89003601 
 1961 27f0 A8FFFFFF 		br.l	.L4.31
 1961      00000F18 
 1962              	.L4.34:
 1963              	# line 299
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 1964              		.loc	1 299 0
 1965 27f8 00000000 		adds.l	%s56,1,%s56
 1965      B8013859 
 1966 2800 00000000 		adds.l	%s58,4,%s58
 1966      BA043A59 
 1967 2808 00000000 		adds.w.sx	%s37,1,%s37
 1967      A501254A 
 1968 2810 98000000 		brgt.l	0,%s56,.L4.35
 1968      B8000118 
 1969 2818 A8FFFFFF 		br.l	.L4.33
 1969      00000F18 
 1970              	.L4.36:
 1971 2820 00000000 		or	%s56,0,%s24
 1971      98003845 
 1972 2828 00000000 		or	%s18,0,%s23
 1972      97001245 
 1973 2830 C8FFFFFF 		br.l	.L4.34
 1973      00000F18 
 1974              	.L4.37:
 1975 2838 30000000 		br.l	.L4.38
 1975      00000F18 
 1976              	.L4.13:
 1977              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 int oh = ih - kh * (p->dh + 1) + p->ph;
 1978              		.loc	1 306 0
 1979 2840 00000000 		adds.w.sx	%s63,1,%s63
 1979      BF013F4A 
 1980 2848 00000000 		adds.w.sx	%s18,%s60,%s18
 1980      92BC124A 
 1981 2850 00000000 		adds.l	%s56,%s57,%s56
 1981      B8B93859 
 1982 2858 E0FFFFFF 		brgt.w	0,%s63,.L4.37
 1982      BF008118 
 1983 2860 C0FFFFFF 		br.l	.L4.36
 1983      00000F18 
 1984              	.L4.38:
 1985 2868 D8FFFFFF 		brgt.w	0,%s18,.L4.13
 1985      92008118 
 1986 2870 F8FCFFFF 		br.l	.L4.19
 1986      00000F18 
 1987              	.L4.39:
 1988 2878 00000000 		or	%s63,0,%s36
 1988      A4003F45 
 1989 2880 00000000 		or	%s23,0,%s18
 1989      92001745 
 1990 2888 00000000 		or	%s18,0,%s35
 1990      A3001245 
 1991 2890 00000000 		or	%s24,0,%s56
 1991      B8001845 
 1992 2898 00000000 		or	%s56,0,%s34
 1992      A2003845 
 1993 28a0 C8FFFFFF 		br.l	.L4.38
 1993      00000F18 
 1994              	.L4.35:
 1995              	# line 302
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** #if LAMB
 1996              		.loc	1 302 0
 1997 28a8 00000000 		or	%s63,0,(0)1
 1997      00003F45 
 1998 28b0 00000000 		stu	%s63,0(,%s58)	# *(ds)
 1998      BA003F12 
 1999 28b8 C0FFFFFF 		brlt.w	0,%s18,.L4.39
 1999      92008218 
 2000 28c0 38FFFFFF 		br.l	.L4.34
 2000      00000F18 
 2001              	.L4.40:
 2002 28c8 00000000 		divs.w.sx	%s61,%s33,%s32
 2002      A0A13D7B 
 2003 28d0 F8FFFFFF 		st	%s54,-8(,%fp)	# spill 
 2003      89003611 
 2004 28d8 F0FFFFFF 		st	%s52,-16(,%fp)	# spill 
 2004      89003411 
 2005 28e0 E8FFFFFF 		st	%s50,-24(,%fp)	# spill 
 2005      89003211 
 2006 28e8 00000000 		or	%s25,0,%s21
 2006      95001945 
 2007 28f0 00000000 		or	%s26,0,%s63
 2007      BF001A45 
 2008 28f8 00000000 		or	%s27,0,%s56
 2008      B8001B45 
 2009 2900 00000000 		or	%s61,0,%s61
 2009      BD003D45 
 2010 2908 00000000 		addu.l	%s61,%s61,%s31
 2010      9FBD3D48 
 2011 2910 00000000 		addu.l	%s61,%s61,%s30
 2011      9EBD3D48 
 2012 2918 00000000 		mulu.l	%s61,%s61,%s29
 2012      9DBD3D49 
 2013 2920 00000000 		or	%s63,0,%s56
 2013      B8003F45 
 2014 2928 00000000 		addu.l	%s63,%s61,%s63
 2014      BFBD3F48 
 2015 2930 00000000 		mulu.l	%s63,%s63,%s28
 2015      9CBF3F49 
 2016 2938 00000000 		or	%s63,0,%s63
 2016      BF003F45 
 2017 2940 00000000 		or	%s56,0,%s54
 2017      B6003845 
 2018              	# line 299
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2019              		.loc	1 299 0
 2020 2948 00000000 		muls.l	%s63,4,%s63
 2020      BF043F6E 
 2021 2950 00000000 		adds.l	%s52,%s63,%s52
 2021      B4BF3459 
 2022 2958 00000000 		or	%s58,0,%s52
 2022      B4003A45 
 2023 2960 00000000 		or	%s37,0,%s50
 2023      B2002545 
 2024 2968 40FFFFFF 		br.l	.L4.35
 2024      00000F18 
 2025              	.L4.32:
 2026 2970 58FFFFFF 		brlt.l	0,%s21,.L4.40
 2026      95000218 
 2027 2978 20FEFFFF 		br.l	.L4.31
 2027      00000F18 
 2028              	.L4.41:
 2029 2980 E0FFFFFF 		st	%s49,-32(,%fp)	# spill 
 2029      89003111 
 2030 2988 D8FFFFFF 		st	%s22,-40(,%fp)	# spill 
 2030      89001611 
 2031 2990 D0FFFFFF 		st	%s63,-48(,%fp)	# spill 
 2031      89003F11 
 2032 2998 C8FFFFFF 		st	%s48,-56(,%fp)	# spill 
 2032      89003011 
 2033 29a0 C0FFFFFF 		st	%s47,-64(,%fp)	# spill 
 2033      89002F11 
 2034 29a8 B8FFFFFF 		st	%s61,-72(,%fp)	# spill 
 2034      89003D11 
 2035 29b0 B0FFFFFF 		st	%s58,-80(,%fp)	# spill 
 2035      89003A11 
 2036 29b8 A8FFFFFF 		st	%s46,-88(,%fp)	# spill 
 2036      89002E11 
 2037 29c0 00000000 		or	%s30,0,%s47
 2037      AF001E45 
 2038 29c8 00000000 		or	%s63,0,%s61
 2038      BD003F45 
 2039 29d0 00000000 		or	%s35,0,%s58
 2039      BA002345 
 2040              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 int oh = ih - kh * (p->dh + 1) + p->ph;
 2041              		.loc	1 306 0
 2042 29d8 00000000 		muls.l	%s48,%s48,%s57
 2042      B9B0306E 
 2043 29e0 00000000 		adds.l	%s34,%s48,%s46
 2043      AEB02259 
 2044 29e8 88FFFFFF 		br.l	.L4.32
 2044      00000F18 
 2045              	.L4.29:
 2046              	# line 298
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int iw = 0; iw < IW; ++iw) {
 2047              		.loc	1 298 0
 2048 29f0 00000000 		or	%s56,0,(0)1
 2048      00003845 
 2049 29f8 88FFFFFF 		brlt.l	0,%s22,.L4.41
 2049      96000218 
 2050 2a00 28FDFFFF 		br.l	.L4.28
 2050      00000F18 
 2051              	.L4.42:
 2052 2a08 A0FFFFFF 		st	%s23,-96(,%fp)	# spill 
 2052      89001711 
 2053 2a10 98FFFFFF 		st	%s63,-104(,%fp)	# spill 
 2053      89003F11 
 2054 2a18 90FFFFFF 		st	%s56,-112(,%fp)	# spill 
 2054      89003811 
 2055 2a20 88FFFFFF 		st	%s43,-120(,%fp)	# spill 
 2055      89002B11 
 2056 2a28 80FFFFFF 		st	%s48,-128(,%fp)	# spill 
 2056      89003011 
 2057 2a30 78FFFFFF 		st	%s42,-136(,%fp)	# spill 
 2057      89002A11 
 2058 2a38 70FFFFFF 		st	%s41,-144(,%fp)	# spill 
 2058      89002911 
 2059 2a40 00000000 		or	%s31,0,%s48
 2059      B0001F45 
 2060 2a48 00000000 		or	%s63,0,%s42
 2060      AA003F45 
 2061 2a50 00000000 		or	%s48,0,%s41
 2061      A9003045 
 2062 2a58 98FFFFFF 		br.l	.L4.29
 2062      00000F18 
 2063              	.L4.26:
 2064              	# line 297
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2065              		.loc	1 297 0
 2066 2a60 00000000 		or	%s47,0,(0)1
 2066      00002F45 
 2067 2a68 A0FFFFFF 		brlt.l	0,%s23,.L4.42
 2067      97000218 
 2068 2a70 50FCFFFF 		br.l	.L4.25
 2068      00000F18 
 2069              	.L4.43:
 2070 2a78 68FFFFFF 		st	%s48,-152(,%fp)	# spill 
 2070      89003011 
 2071 2a80 60FFFFFF 		st	%s24,-160(,%fp)	# spill 
 2071      89001811 
 2072 2a88 58FFFFFF 		st	%s63,-168(,%fp)	# spill 
 2072      89003F11 
 2073 2a90 50FFFFFF 		st	%s47,-176(,%fp)	# spill 
 2073      89002F11 
 2074 2a98 48FFFFFF 		st	%s40,-184(,%fp)	# spill 
 2074      89002811 
 2075 2aa0 40FFFFFF 		st	%s37,-192(,%fp)	# spill 
 2075      89002511 
 2076 2aa8 38FFFFFF 		st	%s35,-200(,%fp)	# spill 
 2076      89002311 
 2077              	# line 296
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ic = 0; ic < ICOG; ++ic) {
 2078              		.loc	1 296 0
 2079 2ab0 00000000 		or	%s48,0,(0)1
 2079      00003045 
 2080 2ab8 00000000 		or	%s63,0,%s35
 2080      A3003F45 
 2081 2ac0 00000000 		or	%s40,0,%s37
 2081      A5002845 
 2082 2ac8 98FFFFFF 		br.l	.L4.26
 2082      00000F18 
 2083              	.L4.22:
 2084 2ad0 A8FFFFFF 		brlt.l	0,%s24,.L4.43
 2084      98000218 
 2085 2ad8 78FBFFFF 		br.l	.L4.23
 2085      00000F18 
 2086              	.L4.0:
 2087 2ae0 00000000 		or	%s34,0,%s48
 2087      B0002245 
 2088 2ae8 00000000 		or	%s7,0,%s56
 2088      B8000745 
 2089 2af0 00000000 		or	%s56,0,%s34
 2089      A2003845 
 2090              	# line 295
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2091              		.loc	1 295 0
 2092 2af8 00000000 		or	%s41,0,(0)1
 2092      00002945 
 2093 2b00 00000000 		or	%s37,0,(0)1
 2093      00002545 
 2094 2b08 00000000 		or	%s29,0,%s63
 2094      BF001D45 
 2095 2b10 00000000 		or	%s28,0,%s62
 2095      BE001C45 
 2096              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 int oh = ih - kh * (p->dh + 1) + p->ph;
 2097              		.loc	1 306 0
 2098 2b18 00000000 		subs.w.sx	%s36,0,%s18
 2098      9200245A 
 2099              	# line 308
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 oh /= p->sh;
 2100              		.loc	1 308 0
 2101 2b20 38000000 		dldl.sx	%s34,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 2101      8000220B 
 2102 2b28 00000000 		adds.w.sx	%s34,1,%s34
 2102      A201224A 
 2103              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 int oh = ih - kh * (p->dh + 1) + p->ph;
 2104              		.loc	1 306 0
 2105 2b30 00000000 		subs.w.sx	%s34,0,%s34
 2105      A200225A 
 2106              	# line 308
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 oh /= p->sh;
 2107              		.loc	1 308 0
 2108 2b38 30000000 		dldl.sx	%s6,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 2108      8000060B 
 2109 2b40 28000000 		dldl.sx	%s55,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 2109      8000370B 
 2110              	# line 312
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     int ow = iw - kw * (p->dw + 1) + p->pw;
 2111              		.loc	1 312 0
 2112 2b48 00000000 		subs.w.sx	%s38,0,%s51
 2112      B300265A 
 2113              	# line 314
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ow /= p->sw;
 2114              		.loc	1 314 0
 2115 2b50 3C000000 		dldl.sx	%s5,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 2115      8000050B 
 2116 2b58 00000000 		adds.w.sx	%s5,1,%s5
 2116      8501054A 
 2117              	# line 312
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     int ow = iw - kw * (p->dw + 1) + p->pw;
 2118              		.loc	1 312 0
 2119 2b60 00000000 		subs.w.sx	%s62,0,%s5
 2119      85003E5A 
 2120              	# line 314
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ow /= p->sw;
 2121              		.loc	1 314 0
 2122 2b68 34000000 		dldl.sx	%s50,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 2122      8000320B 
 2123 2b70 2C000000 		dldl.sx	%s0,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 2123      8000000B 
 2124              	# line 295
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2125              		.loc	1 295 0
 2126 2b78 00000000 		subs.l	%s25,0,%s25
 2126      9900195B 
 2127 2b80 00000000 		or	%s63,0,%s25
 2127      99003F45 
 2128 2b88 00000000 		or	%s33,0,(0)1
 2128      00002145 
 2129              	# line 320
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         //int dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2130              		.loc	1 320 0
 2131 2b90 00000000 		subs.l	%s44,0,%s53
 2131      B5002C5B 
 2132              	# line 297
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2133              		.loc	1 297 0
 2134 2b98 00000000 		subs.l	%s42,0,%s23
 2134      97002A5B 
 2135              	# line 295
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2136              		.loc	1 295 0
 2137 2ba0 00000000 		muls.l	%s47,%s53,%s58
 2137      BAB52F6E 
 2138 2ba8 00000000 		or	%s58,0,%s6
 2138      86003A45 
 2139 2bb0 00000000 		muls.l	%s40,%s53,%s60
 2139      BCB5286E 
 2140              	# line 296
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int ic = 0; ic < ICOG; ++ic) {
 2141              		.loc	1 296 0
 2142 2bb8 00000000 		subs.l	%s35,0,%s24
 2142      9800235B 
 2143 2bc0 00000000 		muls.l	%s43,%s61,%s60
 2143      BCBD2B6E 
 2144              	# line 298
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (int iw = 0; iw < IW; ++iw) {
 2145              		.loc	1 298 0
 2146 2bc8 00000000 		subs.l	%s61,0,%s22
 2146      96003D5B 
 2147              	# line 299
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2148              		.loc	1 299 0
 2149 2bd0 00000000 		subs.l	%s54,0,%s21
 2149      9500365B 
 2150              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 int oh = ih - kh * (p->dh + 1) + p->ph;
 2151              		.loc	1 306 0
 2152 2bd8 00000000 		muls.l	%s57,4,%s57
 2152      B904396E 
 2153 2be0 00000000 		or	%s60,0,%s34
 2153      A2003C45 
 2154              	# line 320
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                         //int dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2155              		.loc	1 320 0
 2156 2be8 00000000 		muls.l	%s2,4,%s7
 2156      8704026E 
 2157 2bf0 00000000 		muls.l	%s1,4,%s59
 2157      BB04016E 
 2158 2bf8 00000000 		or	%s59,0,%s0
 2158      80003B45 
 2159 2c00 D0FEFFFF 		br.l	.L4.22
 2159      00000F18 
 2160              		.cfi_endproc
 2161              		.set	.L.5.2auto_size,	0xfffffffffffffd70	# 656 Bytes
 2163              	# ============ End  conv::sxconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2164              	# ============ Begin  conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2165 2c08 00000000 		.balign 16
 2165      00000000 
 2166              	# line 337
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const psrc = (float*)src_m;
 2167              		.loc	1 337 0
 2168              		.globl	conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2170              	conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 2171              		.cfi_startproc
 2172 2c10 00000000 		st	%fp,0x0(,%sp)
 2172      8B000911 
 2173              		.cfi_def_cfa_offset	0
 2174              		.cfi_offset	9,0
 2175 2c18 08000000 		st	%lr,0x8(,%sp)
 2175      8B000A11 
 2176 2c20 18000000 		st	%got,0x18(,%sp)
 2176      8B000F11 
 2177 2c28 20000000 		st	%plt,0x20(,%sp)
 2177      8B001011 
 2178 2c30 00000000 		or	%fp,0,%sp
 2178      8B000945 
 2179              		.cfi_def_cfa_register	9
 2180 2c38 30000000 		st	%s18,48(,%fp)
 2180      89001211 
 2181 2c40 38000000 		st	%s19,56(,%fp)
 2181      89001311 
 2182 2c48 40000000 		st	%s20,64(,%fp)
 2182      89001411 
 2183 2c50 48000000 		st	%s21,72(,%fp)
 2183      89001511 
 2184 2c58 58000000 		st	%s23,88(,%fp)
 2184      89001711 
 2185 2c60 60000000 		st	%s24,96(,%fp)
 2185      89001811 
 2186 2c68 68000000 		st	%s25,104(,%fp)
 2186      89001911 
 2187 2c70 70000000 		st	%s26,112(,%fp)
 2187      89001A11 
 2188 2c78 78000000 		st	%s27,120(,%fp)
 2188      89001B11 
 2189 2c80 80000000 		st	%s28,128(,%fp)
 2189      89001C11 
 2190 2c88 70FDFFFF 		lea	%s13,.L.6.2auto_size&0xffffffff
 2190      00000D06 
 2191 2c90 00000000 		and	%s13,%s13,(32)0
 2191      608D0D44 
 2192 2c98 FFFFFFFF 		lea.sl	%sp,.L.6.2auto_size>>32(%fp,%s13)
 2192      8D898B06 
 2193 2ca0 48000000 		brge.l.t	%sp,%sl,.L5.EoP
 2193      888B3518 
 2194 2ca8 18000000 		ld	%s61,0x18(,%tp)
 2194      8E003D01 
 2195 2cb0 00000000 		or	%s62,0,%s0
 2195      80003E45 
 2196 2cb8 3B010000 		lea	%s63,0x13b
 2196      00003F06 
 2197 2cc0 00000000 		shm.l	%s63,0x0(%s61)
 2197      BD033F31 
 2198 2cc8 08000000 		shm.l	%sl,0x8(%s61)
 2198      BD030831 
 2199 2cd0 10000000 		shm.l	%sp,0x10(%s61)
 2199      BD030B31 
 2200 2cd8 00000000 		monc
 2200      0000003F 
 2201 2ce0 00000000 		or	%s0,0,%s62
 2201      BE000045 
 2202              	.L5.EoP:
 2203              	# End of prologue codes
 2204 2ce8 B0000000 		st	%s0,176(,%fp)	# p
 2204      89000011 
 2205              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t mb = 0; mb < p->mb; ++mb) {
 2206              		.loc	1 363 0
 2207 2cf0 B0000000 		lea	%s63,176
 2207      00003F06 
 2208 2cf8 00000000 		adds.l	%s63,%fp,%s63
 2208      BF893F59 
 2209              	# line 337
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const psrc = (float*)src_m;
 2210              		.loc	1 337 0
 2211 2d00 B8000000 		st	%s1,184(,%fp)	# src_m
 2211      89000111 
 2212 2d08 C0000000 		st	%s2,192(,%fp)	# diff_wei_m
 2212      89000211 
 2213 2d10 C8000000 		st	%s3,200(,%fp)	# diff_bia_m
 2213      89000311 
 2214 2d18 D0000000 		st	%s4,208(,%fp)	# diff_dst_m
 2214      89000411 
 2215              	# line 338
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict const pdiff_wei = (float*)diff_wei_m;
 2216              		.loc	1 338 0
 2217 2d20 A8010000 		ld	%s1,424(,%s1)	# *(src_m).data_
 2217      81000101 
 2218              	# line 339
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict const pdiff_bia = (float*)diff_bia_m;
 2219              		.loc	1 339 0
 2220 2d28 A8010000 		ld	%s27,424(,%s2)	# *(diff_wei_m).data_
 2220      82001B01 
 2221              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float const * restrict const pdiff_dst = (float*)diff_dst_m;
 2222              		.loc	1 340 0
 2223 2d30 A8010000 		ld	%s40,424(,%s3)	# *(diff_bia_m).data_
 2223      83002801 
 2224              	# line 341
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t G = p->g;
 2225              		.loc	1 341 0
 2226 2d38 A8010000 		ld	%s4,424(,%s4)	# *(diff_dst_m).data_
 2226      84000401 
 2227              	# line 338
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     float       * restrict const pdiff_wei = (float*)diff_wei_m;
 2228              		.loc	1 338 0
 2229 2d40 F0FFFFFF 		st	%s1,-16(,%fp)	# psrc
 2229      89000111 
 2230              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t mb = 0; mb < p->mb; ++mb) {
 2231              		.loc	1 363 0
 2232 2d48 00000000 		adds.l	%s62,%fp,(60)1
 2232      3C893E59 
 2233              	# line 341
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     const ssize_t G = p->g;
 2234              		.loc	1 341 0
 2235 2d50 E8FFFFFF 		st	%s4,-24(,%fp)	# pdiff_dst
 2235      89000411 
 2236              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t mb = 0; mb < p->mb; ++mb) {
 2237              		.loc	1 363 0
 2238 2d58 E8FFFFFF 		lea	%s61,-24
 2238      00003D06 
 2239 2d60 00000000 		adds.l	%s61,%fp,%s61
 2239      BD893D59 
 2240 2d68 D0FFFFFF 		st	%s63,-48(,%fp)	# ker.p
 2240      89003F11 
 2241 2d70 D8FFFFFF 		st	%s61,-40(,%fp)	# ker.pdiff_dst
 2241      89003D11 
 2242 2d78 E0FFFFFF 		st	%s62,-32(,%fp)	# ker.psrc
 2242      89003E11 
 2243              	# line 384
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     OMP(parallel for collapse(5))//;
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (ssize_t g = 0; g < p->g; ++g) {
 2244              		.loc	1 384 0
 2245 2d80 00000000 		ldl.sx	%s0,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 2245      80000003 
 2246 2d88 00000000 		or	%s0,0,%s0
 2246      80000045 
 2247 2d90 00000000 		or	%s2,0,(0)1
 2247      00000245 
 2248 2d98 10090000 		brlt.l	0,%s0,.L5.0
 2248      80000218 
 2249 2da0 C8040000 		br.l	.L5.1
 2249      00000F18 
 2250              	.L5.2:
 2251              	# line 411
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < p->ic/p->g; ++ic) {
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kh = 0; kh < p->kh; ++kh) {
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kw = 0; kw < p->kw; ++kw) {
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ssize_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw);
 390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 //float &dw = ((float*)diff_wei_m)[wei_off];
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 float &dw = pdiff_wei[wei_off];
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 dw = 0;
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ker(dw, g, oc, ic, kh, kw);
 394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     }
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     if (!(p->dir & FLAG_BIA)) return;
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     OMP(parallel for collapse(2))//;
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     for (ssize_t g = 0; g < p->g; ++g) {
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             ssize_t bia_off = bia_off_f2(p, g, oc);
 406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             float &db = pdiff_bia[bia_off];
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             db = 0;
 408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t mb = 0; mb < p->mb; ++mb) {
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t oh = 0; oh < p->oh; ++oh) {
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t ow = 0; ow < p->ow; ++ow) {
 2252              		.loc	1 411 0
 2253 2da8 80000000 		mins.l	%s61,%s59,%s61
 2253      BDBB3D68 
 2254 2db0 60010000 		br.l	.L5.3
 2254      00000F18 
 2255              	.L5.4:
 2256              	# line 403
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
 2257              		.loc	1 403 0
 2258 2db8 00000000 		adds.l	%s63,1,%s63
 2258      BF013F59 
 2259 2dc0 00000000 		adds.l	%s60,%s62,%s60
 2259      BCBE3C59 
 2260 2dc8 00000000 		adds.l	%s54,%s61,%s54
 2260      B6BD3659 
 2261 2dd0 08030000 		brgt.l	0,%s63,.L5.5
 2261      BF000118 
 2262 2dd8 08040000 		br.l	.L5.6
 2262      00000F18 
 2263              	.L5.7:
 2264 2de0 00000000 		or	%s63,0,%s5
 2264      85003F45 
 2265 2de8 00000000 		or	%s62,0,%s4
 2265      84003E45 
 2266 2df0 00000000 		or	%s60,0,%s6
 2266      86003C45 
 2267 2df8 C0FFFFFF 		br.l	.L5.4
 2267      00000F18 
 2268              	.L5.8:
 2269              	# line 404
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             ssize_t bia_off = bia_off_f2(p, g, oc);
 2270              		.loc	1 404 0
 2271 2e00 00000000 		adds.l	%s62,1,%s62
 2271      BE013E59 
 2272 2e08 00000000 		adds.l	%s58,4,%s58
 2272      BA043A59 
 2273 2e10 00000000 		adds.l	%s50,1,%s50
 2273      B2013259 
 2274 2e18 40020000 		brgt.l	0,%s62,.L5.9
 2274      BE000118 
 2275 2e20 C0FFFFFF 		br.l	.L5.7
 2275      00000F18 
 2276              	.L5.10:
 2277 2e28 00000000 		or	%s62,0,%s3
 2277      83003E45 
 2278 2e30 D0FFFFFF 		br.l	.L5.8
 2278      00000F18 
 2279              	.L5.11:
 2280              	# line 409
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t oh = 0; oh < p->oh; ++oh) {
 2281              		.loc	1 409 0
 2282 2e38 00000000 		adds.l	%s63,1,%s63
 2282      BF013F59 
 2283 2e40 00000000 		adds.l	%s51,%s61,%s51
 2283      B3BD3359 
 2284 2e48 D8010000 		brgt.l	0,%s63,.L5.12
 2284      BF000118 
 2285 2e50 D8FFFFFF 		br.l	.L5.10
 2285      00000F18 
 2286              	.L5.13:
 2287 2e58 00000000 		or	%s63,0,%s2
 2287      82003F45 
 2288 2e60 00000000 		or	%s61,0,%s1
 2288      81003D45 
 2289 2e68 D0FFFFFF 		br.l	.L5.11
 2289      00000F18 
 2290              	.L5.14:
 2291              	# line 410
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t ow = 0; ow < p->ow; ++ow) {
 2292              		.loc	1 410 0
 2293 2e70 00000000 		adds.l	%s63,1,%s63
 2293      BF013F59 
 2294 2e78 00000000 		adds.l	%s62,1,%s62
 2294      BE013E59 
 2295 2e80 70010000 		brgt.l	0,%s63,.L5.15
 2295      BF000118 
 2296 2e88 D0FFFFFF 		br.l	.L5.13
 2296      00000F18 
 2297              	.L5.16:
 2298              	# line 413
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     db += pdiff_dst[dst_off];
 2299              		.loc	1 413 0
 2300 2e90 00000000 		or	%s61,1,(0)1
 2300      00013D45 
 2301 2e98 00000000 		or	%s60,0,%s58
 2301      BA003C45 
 2302 2ea0 00000000 		lvl	%s61
 2302      00BD00BF 
 2303 2ea8 0000003D 		vldu.nc	%v61,0,%s60
 2303      BC000082 
 2304 2eb0 00000000 		lvl	%s57
 2304      00B900BF 
 2305 2eb8 00003F3C 		vfsum.s	%v60,%v63
 2305      000080EC 
 2306 2ec0 00000000 		or	%s61,1,(0)1
 2306      00013D45 
 2307 2ec8 00000000 		lvl	%s61
 2307      00BD00BF 
 2308 2ed0 003C3D3B 		vfadd.s	%v59,%v61,%v60
 2308      000080CC 
 2309 2ed8 00000000 		or	%s61,1,(0)1
 2309      00013D45 
 2310 2ee0 00000000 		or	%s60,0,%s58
 2310      BA003C45 
 2311 2ee8 00000000 		lvl	%s61
 2311      00BD00BF 
 2312 2ef0 0000003B 		vstu.nc	%v59,0,%s60
 2312      BC000092 
 2313 2ef8 00000000 		or	%s62,0,%s56
 2313      B8003E45 
 2314 2f00 00000000 		or	%s63,0,%s55
 2314      B7003F45 
 2315 2f08 68FFFFFF 		br.l	.L5.14
 2315      00000F18 
 2316              	.L5.3:
 2317 2f10 00000000 		or	%s62,0,%s63
 2317      BF003E45 
 2318 2f18 00000000 		lvl	%s61
 2318      00BD00BF 
 2319 2f20 0000003E 		vldu.nc	%v62,4,%s62
 2319      BE040082 
 2320 2f28 003E3F3F 		vfadd.s	%v63,%v63,%v62
 2320      000080CC 
 2321              	# line 411
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 2322              		.loc	1 411 0
 2323 2f30 00000000 		adds.l	%s63,%s63,%s60
 2323      BCBF3F59 
 2324 2f38 00000000 		subs.l	%s59,%s59,%s61
 2324      BDBB3B5B 
 2325 2f40 50FFFFFF 		brge.l	0,%s59,.L5.16
 2325      BB000518 
 2326 2f48 60FEFFFF 		br.l	.L5.2
 2326      00000F18 
 2327              	.L5.17:
 2328              	# line 412
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 2329              		.loc	1 412 0
 2330 2f50 00000000 		divs.l	%s52,%s54,%s53
 2330      B5B6347F 
 2331 2f58 00000000 		or	%s56,0,%s62
 2331      BE003845 
 2332 2f60 00000000 		or	%s55,0,%s63
 2332      BF003745 
 2333 2f68 00000000 		adds.l	%s52,%s52,%s51
 2333      B3B43459 
 2334 2f70 00000000 		adds.l	%s52,%s52,%s50
 2334      B2B43459 
 2335 2f78 00000000 		muls.l	%s52,%s52,%s49
 2335      B1B4346E 
 2336 2f80 00000000 		adds.l	%s52,%s62,%s52
 2336      B4BE3459 
 2337 2f88 00000000 		muls.l	%s52,%s52,%s18
 2337      92B4346E 
 2338              	# line 411
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 2339              		.loc	1 411 0
 2340 2f90 00000000 		muls.l	%s52,4,%s52
 2340      B404346E 
 2341 2f98 00000000 		adds.l	%s52,%s52,%s48
 2341      B0B43459 
 2342 2fa0 00000000 		subs.l	%s62,0,%s47
 2342      AF003E5B 
 2343 2fa8 00000000 		smvl	%s57
 2343      0000392E 
 2344 2fb0 80000000 		mins.l	%s61,%s62,%s57
 2344      B9BE3D68 
 2345              	# line 413
 2346              		.loc	1 413 0
 2347 2fb8 00000000 		or	%s46,0,(0)1
 2347      00002E45 
 2348 2fc0 00000000 		lvl	%s57
 2348      00B900BF 
 2349 2fc8 0000003F 		vbrdu	%v63,%s46
 2349      00AE808C 
 2350 2fd0 00000000 		or	%s59,0,%s62
 2350      BE003B45 
 2351 2fd8 00000000 		or	%s63,0,%s52
 2351      B4003F45 
 2352              	# line 411
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 2353              		.loc	1 411 0
 2354 2fe0 00000000 		muls.l	%s60,4,%s61
 2354      BD043C6E 
 2355 2fe8 28FFFFFF 		br.l	.L5.3
 2355      00000F18 
 2356              	.L5.15:
 2357 2ff0 60FFFFFF 		brlt.l	0,%s18,.L5.17
 2357      92000218 
 2358 2ff8 78FEFFFF 		br.l	.L5.14
 2358      00000F18 
 2359              	.L5.18:
 2360 3000 00000000 		or	%s1,0,%s61
 2360      BD000145 
 2361 3008 00000000 		or	%s2,0,%s63
 2361      BF000245 
 2362 3010 00000000 		or	%s63,0,%s45
 2362      AD003F45 
 2363 3018 D8FFFFFF 		br.l	.L5.15
 2363      00000F18 
 2364              	.L5.12:
 2365              	# line 410
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t ow = 0; ow < p->ow; ++ow) {
 2366              		.loc	1 410 0
 2367 3020 00000000 		or	%s62,0,(0)1
 2367      00003E45 
 2368 3028 D8FFFFFF 		brlt.l	0,%s19,.L5.18
 2368      93000218 
 2369 3030 08FEFFFF 		br.l	.L5.11
 2369      00000F18 
 2370              	.L5.19:
 2371 3038 00000000 		or	%s63,0,%s44
 2371      AC003F45 
 2372              	# line 409
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t oh = 0; oh < p->oh; ++oh) {
 2373              		.loc	1 409 0
 2374 3040 00000000 		or	%s51,0,(0)1
 2374      00003345 
 2375 3048 00000000 		or	%s3,0,%s62
 2375      BE000345 
 2376 3050 D0FFFFFF 		br.l	.L5.12
 2376      00000F18 
 2377              	.L5.9:
 2378              	# line 407
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 2379              		.loc	1 407 0
 2380 3058 00000000 		or	%s63,0,(0)1
 2380      00003F45 
 2381 3060 00000000 		stu	%s63,0(,%s58)	# *(db)
 2381      BA003F12 
 2382 3068 D0FFFFFF 		brlt.l	0,%s20,.L5.19
 2382      94000218 
 2383 3070 90FDFFFF 		br.l	.L5.8
 2383      00000F18 
 2384              	.L5.20:
 2385              	# line 405
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             float &db = pdiff_bia[bia_off];
 2386              		.loc	1 405 0
 2387 3078 00000000 		divs.l	%s59,%s60,%s43
 2387      ABBC3B7F 
 2388              	# line 404
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             ssize_t bia_off = bia_off_f2(p, g, oc);
 2389              		.loc	1 404 0
 2390 3080 00000000 		divs.w.sx	%s57,%s42,%s41
 2390      A9AA397B 
 2391 3088 00000000 		or	%s4,0,%s62
 2391      BE000445 
 2392 3090 00000000 		or	%s5,0,%s63
 2392      BF000545 
 2393 3098 00000000 		or	%s6,0,%s60
 2393      BC000645 
 2394 30a0 00000000 		or	%s57,0,%s57
 2394      B9003945 
 2395 30a8 00000000 		subs.l	%s57,0,%s57
 2395      B900395B 
 2396 30b0 00000000 		or	%s62,0,%s57
 2396      B9003E45 
 2397 30b8 00000000 		muls.l	%s59,4,%s59
 2397      BB043B6E 
 2398 30c0 00000000 		adds.l	%s59,%s59,%s40
 2398      A8BB3B59 
 2399 30c8 00000000 		or	%s58,0,%s59
 2399      BB003A45 
 2400 30d0 88FFFFFF 		br.l	.L5.9
 2400      00000F18 
 2401              	.L5.5:
 2402 30d8 00000000 		or	%s50,0,(0)1
 2402      00003245 
 2403 30e0 98FFFFFF 		brlt.l	0,%s21,.L5.20
 2403      95000218 
 2404 30e8 D0FCFFFF 		br.l	.L5.4
 2404      00000F18 
 2405              	.L5.21:
 2406 30f0 E8FFFFFF 		ld	%s48,-24(,%fp)	# pdiff_dst
 2406      89003001 
 2407              	# line 403
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
 2408              		.loc	1 403 0
 2409 30f8 00000000 		or	%s60,0,(0)1
 2409      00003C45 
 2410 3100 00000000 		or	%s54,0,(0)1
 2410      00003645 
 2411              	# line 404
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             ssize_t bia_off = bia_off_f2(p, g, oc);
 2412              		.loc	1 404 0
 2413 3108 14000000 		dldl.sx	%s42,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 2413      BF002A0B 
 2414 3110 00000000 		divs.w.sx	%s59,%s42,%s41
 2414      A9AA3B7B 
 2415 3118 00000000 		or	%s21,0,%s59
 2415      BB001545 
 2416 3120 00000000 		or	%s62,0,%s42
 2416      AA003E45 
 2417              	# line 403
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
 2418              		.loc	1 403 0
 2419 3128 00000000 		subs.l	%s59,0,%s43
 2419      AB003B5B 
 2420 3130 00000000 		or	%s58,0,%s63
 2420      BF003A45 
 2421 3138 00000000 		or	%s63,0,%s59
 2421      BB003F45 
 2422              	# line 409
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t oh = 0; oh < p->oh; ++oh) {
 2423              		.loc	1 409 0
 2424 3140 04000000 		dldl.sx	%s59,4(,%s58)	# *(p).__b_N4conv6desc_tE.mb
 2424      BA003B0B 
 2425 3148 00000000 		or	%s20,0,%s59
 2425      BB001445 
 2426 3150 00000000 		subs.l	%s44,0,%s20
 2426      94002C5B 
 2427              	# line 410
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 for (ssize_t ow = 0; ow < p->ow; ++ow) {
 2428              		.loc	1 410 0
 2429 3158 18000000 		dldl.sx	%s59,24(,%s58)	# *(p).__b_N4conv6desc_tE.oh
 2429      BA003B0B 
 2430 3160 00000000 		or	%s19,0,%s59
 2430      BB001345 
 2431 3168 00000000 		subs.l	%s45,0,%s19
 2431      93002D5B 
 2432              	# line 411
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     ssize_t dst_off = dst_off_f2(p, mb, g, oc, oh, ow);
 2433              		.loc	1 411 0
 2434 3170 1C000000 		dldl.sx	%s59,28(,%s58)	# *(p).__b_N4conv6desc_tE.ow
 2434      BA003B0B 
 2435 3178 00000000 		or	%s18,0,%s59
 2435      BB001245 
 2436 3180 00000000 		subs.l	%s47,0,%s18
 2436      92002F5B 
 2437              	# line 412
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                     db += pdiff_dst[dst_off];
 2438              		.loc	1 412 0
 2439 3188 14000000 		dldl.sx	%s59,20(,%s58)	# *(p).__b_N4conv6desc_tE.oc
 2439      BA003B0B 
 2440 3190 00000000 		or	%s61,0,%s59
 2440      BB003D45 
 2441 3198 00000000 		dldl.sx	%s59,0(,%s58)	# *(p).__b_N4conv6desc_tE.g
 2441      BA003B0B 
 2442 31a0 00000000 		or	%s53,0,%s59
 2442      BB003545 
 2443 31a8 18000000 		dldl.sx	%s58,24(,%s58)	# *(p).__b_N4conv6desc_tE.oh
 2443      BA003A0B 
 2444 31b0 00000000 		or	%s49,0,%s58
 2444      BA003145 
 2445 31b8 20FFFFFF 		br.l	.L5.5
 2445      00000F18 
 2446              	.L5.22:
 2447              	# line 403
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
 2448              		.loc	1 403 0
 2449 31c0 00000000 		ldl.sx	%s41,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2449      BF002903 
 2450 31c8 00000000 		or	%s43,0,%s41
 2450      A9002B45 
 2451 31d0 20FFFFFF 		brlt.l	0,%s43,.L5.21
 2451      AB000218 
 2452 31d8 08000000 		br.l	.L5.6
 2452      00000F18 
 2453              	.L5.6:
 2454              	# line 419
 414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 }
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         }
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****     }
 419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** }
 2455              		.loc	1 419 0
 2456              	# Start of epilogue codes
 2457 31e0 30000000 		ld	%s18,48(,%fp)
 2457      89001201 
 2458 31e8 38000000 		ld	%s19,56(,%fp)
 2458      89001301 
 2459 31f0 40000000 		ld	%s20,64(,%fp)
 2459      89001401 
 2460 31f8 48000000 		ld	%s21,72(,%fp)
 2460      89001501 
 2461 3200 58000000 		ld	%s23,88(,%fp)
 2461      89001701 
 2462 3208 60000000 		ld	%s24,96(,%fp)
 2462      89001801 
 2463 3210 68000000 		ld	%s25,104(,%fp)
 2463      89001901 
 2464 3218 70000000 		ld	%s26,112(,%fp)
 2464      89001A01 
 2465 3220 78000000 		ld	%s27,120(,%fp)
 2465      89001B01 
 2466 3228 80000000 		ld	%s28,128(,%fp)
 2466      89001C01 
 2467 3230 00000000 		or	%sp,0,%fp
 2467      89000B45 
 2468              		.cfi_def_cfa	11,8
 2469 3238 18000000 		ld	%got,0x18(,%sp)
 2469      8B000F01 
 2470 3240 20000000 		ld	%plt,0x20(,%sp)
 2470      8B001001 
 2471 3248 08000000 		ld	%lr,0x8(,%sp)
 2471      8B000A01 
 2472 3250 00000000 		ld	%fp,0x0(,%sp)
 2472      8B000901 
 2473 3258 00000000 		b.l	(,%lr)
 2473      8A000F19 
 2474              	.L5.23:
 2475 3260 80FFFFFF 		br.l	.L5.6
 2475      00000F18 
 2476              	.L5.1:
 2477              	# line 400
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp **** 
 2478              		.loc	1 400 0
 2479 3268 B0000000 		ld	%s63,176(,%fp)	# p
 2479      89003F01 
 2480 3270 48000000 		ldl.zx	%s62,72(,%s63)	# *(p).dir
 2480      BF00BE03 
 2481 3278 00000000 		adds.w.sx	%s62,0,%s62
 2481      BE003E4A 
 2482 3280 04000000 		lea	%s61,4
 2482      00003D06 
 2483 3288 00000000 		and	%s61,%s62,%s61
 2483      BDBE3D44 
 2484 3290 D0FFFFFF 		breq.w	0,%s61,.L5.23
 2484      BD008418 
 2485 3298 28FFFFFF 		br.l	.L5.22
 2485      00000F18 
 2486              	.L5.24:
 2487 32a0 00000000 		or	%s40,0,%s18
 2487      92002845 
 2488 32a8 C0FFFFFF 		br.l	.L5.1
 2488      00000F18 
 2489              	.L5.25:
 2490              	# line 384
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t oc = 0; oc < p->oc/p->g; ++oc) {
 2491              		.loc	1 384 0
 2492 32b0 B0000000 		ld	%s63,176(,%fp)	# p
 2492      89003F01 
 2493 32b8 00000000 		ldl.sx	%s63,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2493      BF003F03 
 2494 32c0 00000000 		or	%s63,0,%s63
 2494      BF003F45 
 2495 32c8 00000000 		adds.l	%s2,1,%s2
 2495      82010259 
 2496 32d0 98030000 		brlt.l	%s2,%s63,.L5.26
 2496      BF820218 
 2497 32d8 C8FFFFFF 		br.l	.L5.24
 2497      00000F18 
 2498              	.L5.27:
 2499              	# line 385
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < p->ic/p->g; ++ic) {
 2500              		.loc	1 385 0
 2501 32e0 B0000000 		ld	%s63,176(,%fp)	# p
 2501      89003F01 
 2502 32e8 14000000 		ldl.sx	%s62,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 2502      BF003E03 
 2503 32f0 00000000 		ldl.sx	%s61,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2503      BF003D03 
 2504 32f8 00000000 		divs.w.sx	%s61,%s62,%s61
 2504      BDBE3D7B 
 2505 3300 00000000 		or	%s61,0,%s61
 2505      BD003D45 
 2506 3308 00000000 		adds.l	%s3,1,%s3
 2506      83010359 
 2507 3310 08030000 		brlt.l	%s3,%s61,.L5.28
 2507      BD830218 
 2508 3318 98FFFFFF 		br.l	.L5.25
 2508      00000F18 
 2509              	.L5.29:
 2510              	# line 386
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kh = 0; kh < p->kh; ++kh) {
 2511              		.loc	1 386 0
 2512 3320 B0000000 		ld	%s63,176(,%fp)	# p
 2512      89003F01 
 2513 3328 08000000 		ldl.sx	%s62,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 2513      BF003E03 
 2514 3330 00000000 		ldl.sx	%s61,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2514      BF003D03 
 2515 3338 00000000 		divs.w.sx	%s61,%s62,%s61
 2515      BDBE3D7B 
 2516 3340 00000000 		or	%s61,0,%s61
 2516      BD003D45 
 2517 3348 00000000 		adds.l	%s4,1,%s4
 2517      84010459 
 2518 3350 88020000 		brlt.l	%s4,%s61,.L5.30
 2518      BD840218 
 2519 3358 88FFFFFF 		br.l	.L5.27
 2519      00000F18 
 2520              	.L5.31:
 2521 3360 00000000 		or	%s60,0,%s61
 2521      BD003C45 
 2522 3368 B8FFFFFF 		br.l	.L5.29
 2522      00000F18 
 2523              	.L5.32:
 2524              	# line 387
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kw = 0; kw < p->kw; ++kw) {
 2525              		.loc	1 387 0
 2526 3370 B0000000 		ld	%s63,176(,%fp)	# p
 2526      89003F01 
 2527 3378 20000000 		ldl.sx	%s63,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2527      BF003F03 
 2528 3380 00000000 		or	%s63,0,%s63
 2528      BF003F45 
 2529 3388 00000000 		adds.l	%s5,1,%s5
 2529      85010559 
 2530 3390 00020000 		brlt.l	%s5,%s63,.L5.33
 2530      BF850218 
 2531 3398 C8FFFFFF 		br.l	.L5.31
 2531      00000F18 
 2532              	.L5.34:
 2533 33a0 A8FFFFFF 		ld	%s5,-88(,%fp)	# restore 
 2533      89000501 
 2534 33a8 C8FFFFFF 		ld	%s61,-56(,%fp)	# restore 
 2534      89003D01 
 2535 33b0 B0FFFFFF 		ld	%s4,-80(,%fp)	# restore 
 2535      89000401 
 2536 33b8 B8FFFFFF 		ld	%s3,-72(,%fp)	# restore 
 2536      89000301 
 2537 33c0 C0FFFFFF 		ld	%s2,-64(,%fp)	# restore 
 2537      89000201 
 2538 33c8 A8FFFFFF 		br.l	.L5.32
 2538      00000F18 
 2539              	.L5.35:
 2540 33d0 98FFFFFF 		ld	%s62,-104(,%fp)	# restore 
 2540      89003E01 
 2541 33d8 C8FFFFFF 		ld	%s0,-56(,%fp)	# restore 
 2541      89000001 
 2542 33e0 C0FFFFFF 		ld	%s2,-64(,%fp)	# restore 
 2542      89000201 
 2543 33e8 B8FFFFFF 		ld	%s3,-72(,%fp)	# restore 
 2543      89000301 
 2544 33f0 B0FFFFFF 		ld	%s4,-80(,%fp)	# restore 
 2544      89000401 
 2545 33f8 A8FFFFFF 		ld	%s5,-88(,%fp)	# restore 
 2545      89000501 
 2546              	.L5.36:
 2547              	# line 389
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 //float &dw = ((float*)diff_wei_m)[wei_off];
 2548              		.loc	1 389 0
 2549 3400 B0000000 		ld	%s63,176(,%fp)	# p
 2549      89003F01 
 2550 3408 C8FFFFFF 		st	%s0,-56(,%fp)	# spill 
 2550      89000011 
 2551 3410 C0FFFFFF 		st	%s2,-64(,%fp)	# spill 
 2551      89000211 
 2552 3418 B8FFFFFF 		st	%s3,-72(,%fp)	# spill 
 2552      89000311 
 2553 3420 B0FFFFFF 		st	%s4,-80(,%fp)	# spill 
 2553      89000411 
 2554 3428 A8FFFFFF 		st	%s5,-88(,%fp)	# spill 
 2554      89000511 
 2555 3430 A0FFFFFF 		st	%s6,-96(,%fp)	# spill 
 2555      89000611 
 2556 3438 14000000 		ldl.sx	%s61,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 2556      BF003D03 
 2557 3440 00000000 		or	%s61,0,%s61
 2557      BD003D45 
 2558 3448 00000000 		mulu.l	%s61,%s61,%s23
 2558      97BD3D49 
 2559 3450 00000000 		ldl.sx	%s60,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2559      BF003C03 
 2560 3458 00000000 		or	%s60,0,%s60
 2560      BC003C45 
 2561 3460 00000000 		divu.l	%s61,%s61,%s60
 2561      BCBD3D6F 
 2562 3468 00000000 		addu.l	%s61,%s61,%s24
 2562      98BD3D48 
 2563 3470 08000000 		ldl.sx	%s59,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 2563      BF003B03 
 2564 3478 00000000 		or	%s59,0,%s59
 2564      BB003B45 
 2565 3480 00000000 		mulu.l	%s59,%s61,%s59
 2565      BBBD3B49 
 2566 3488 00000000 		divu.l	%s60,%s59,%s60
 2566      BCBB3C6F 
 2567 3490 00000000 		addu.l	%s60,%s60,%s25
 2567      99BC3C48 
 2568 3498 20000000 		ldl.sx	%s61,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2568      BF003D03 
 2569 34a0 00000000 		or	%s61,0,%s61
 2569      BD003D45 
 2570 34a8 00000000 		mulu.l	%s61,%s60,%s61
 2570      BDBC3D49 
 2571 34b0 00000000 		addu.l	%s61,%s61,%s26
 2571      9ABD3D48 
 2572 34b8 24000000 		ldl.sx	%s63,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2572      BF003F03 
 2573 34c0 00000000 		or	%s63,0,%s63
 2573      BF003F45 
 2574 34c8 00000000 		mulu.l	%s63,%s61,%s63
 2574      BFBD3F49 
 2575 34d0 00000000 		addu.l	%s62,1,%s62
 2575      BE013E48 
 2576 34d8 00000000 		addu.l	%s63,%s63,%s62
 2576      BEBF3F48 
 2577 34e0 00000000 		or	%s63,0,%s63
 2577      BF003F45 
 2578              	# line 391
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 dw = 0;
 2579              		.loc	1 391 0
 2580 34e8 00000000 		muls.l	%s63,4,%s63
 2580      BF043F6E 
 2581 34f0 00000000 		adds.l	%s1,%s63,%s27
 2581      9BBF0159 
 2582              	# line 392
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ker(dw, g, oc, ic, kh, kw);
 2583              		.loc	1 392 0
 2584 34f8 00000000 		or	%s63,0,(0)1
 2584      00003F45 
 2585 3500 00000000 		stu	%s63,0(,%s1)	# *(dw)
 2585      81003F12 
 2586 3508 00000000 		or	%s62,0,%s62
 2586      BE003E45 
 2587 3510 98FFFFFF 		st	%s62,-104(,%fp)	# spill 
 2587      89003E11 
 2588              	# line 393
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 2589              		.loc	1 393 0
 2590 3518 00000000 		lea	%s12,conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&, long, long, long, long, long)#1}::operator()(float&, long, long, long, long, long) const@LO
 2590      00000C06 
 2591 3520 00000000 		and	%s12,%s12,(32)0
 2591      608C0C44 
 2592 3528 00000000 		lea.sl	%s12,conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&, long, long, long, long, long)#1}::operator()(float&, long, long, long, long, long) const@HI
 2592      8C008C06 
 2593 3530 00000000 		bsic	%lr,(,%s12)	# conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(float&, long, long, long, long, long)#1}::operator()(float&, long) const
 2593      8C000A08 
 2594              	# line 388
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****                 ssize_t wei_off = wei_off_f2(p, g, oc, ic, kh, kw);
 2595              		.loc	1 388 0
 2596 3538 00000000 		adds.l	%s28,1,%s28
 2596      9C011C59 
 2597 3540 A0FFFFFF 		ld	%s6,-96(,%fp)	# restore 
 2597      89000601 
 2598 3548 00000000 		adds.l	%s6,1,%s6
 2598      86010659 
 2599 3550 80FEFFFF 		brgt.l	0,%s28,.L5.35
 2599      9C000118 
 2600 3558 48FEFFFF 		br.l	.L5.34
 2600      00000F18 
 2601              	.L5.37:
 2602 3560 00000000 		or	%s26,0,%s5
 2602      85001A45 
 2603 3568 00000000 		subu.l	%s62,0,(63)0
 2603      7F003E58 
 2604 3570 00000000 		subs.l	%s63,0,%s63
 2604      BF003F5B 
 2605 3578 00000000 		or	%s28,0,%s63
 2605      BF001C45 
 2606 3580 00000000 		or	%s0,0,%s61
 2606      BD000045 
 2607 3588 78FEFFFF 		br.l	.L5.36
 2607      00000F18 
 2608              	.L5.33:
 2609 3590 00000000 		or	%s6,0,(0)1
 2609      00000645 
 2610 3598 B0000000 		ld	%s63,176(,%fp)	# p
 2610      89003F01 
 2611 35a0 24000000 		ldl.sx	%s63,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2611      BF003F03 
 2612 35a8 00000000 		or	%s63,0,%s63
 2612      BF003F45 
 2613 35b0 B0FFFFFF 		brlt.l	0,%s63,.L5.37
 2613      BF000218 
 2614 35b8 B8FDFFFF 		br.l	.L5.32
 2614      00000F18 
 2615              	.L5.38:
 2616 35c0 00000000 		or	%s25,0,%s4
 2616      84001945 
 2617 35c8 00000000 		or	%s61,0,%s60
 2617      BC003D45 
 2618 35d0 C0FFFFFF 		br.l	.L5.33
 2618      00000F18 
 2619              	.L5.30:
 2620              	# line 387
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kw = 0; kw < p->kw; ++kw) {
 2621              		.loc	1 387 0
 2622 35d8 00000000 		or	%s5,0,(0)1
 2622      00000545 
 2623 35e0 B0000000 		ld	%s63,176(,%fp)	# p
 2623      89003F01 
 2624 35e8 20000000 		ldl.sx	%s63,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2624      BF003F03 
 2625 35f0 00000000 		or	%s63,0,%s63
 2625      BF003F45 
 2626 35f8 C8FFFFFF 		brlt.l	0,%s63,.L5.38
 2626      BF000218 
 2627 3600 20FDFFFF 		br.l	.L5.29
 2627      00000F18 
 2628              	.L5.39:
 2629 3608 00000000 		or	%s24,0,%s3
 2629      83001845 
 2630 3610 C8FFFFFF 		br.l	.L5.30
 2630      00000F18 
 2631              	.L5.28:
 2632              	# line 386
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             for (ssize_t kh = 0; kh < p->kh; ++kh) {
 2633              		.loc	1 386 0
 2634 3618 00000000 		or	%s4,0,(0)1
 2634      00000445 
 2635 3620 B0000000 		ld	%s63,176(,%fp)	# p
 2635      89003F01 
 2636 3628 00000000 		ldl.sx	%s62,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2636      BF003E03 
 2637 3630 08000000 		ldl.sx	%s63,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 2637      BF003F03 
 2638 3638 00000000 		divs.w.sx	%s62,%s63,%s62
 2638      BEBF3E7B 
 2639 3640 00000000 		or	%s62,0,%s62
 2639      BE003E45 
 2640 3648 C0FFFFFF 		brlt.l	0,%s62,.L5.39
 2640      BE000218 
 2641 3650 90FCFFFF 		br.l	.L5.27
 2641      00000F18 
 2642              	.L5.40:
 2643 3658 00000000 		or	%s23,0,%s2
 2643      82001745 
 2644 3660 B8FFFFFF 		br.l	.L5.28
 2644      00000F18 
 2645              	.L5.26:
 2646              	# line 385
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****         for (ssize_t ic = 0; ic < p->ic/p->g; ++ic) {
 2647              		.loc	1 385 0
 2648 3668 00000000 		or	%s3,0,(0)1
 2648      00000345 
 2649 3670 B0000000 		ld	%s63,176(,%fp)	# p
 2649      89003F01 
 2650 3678 00000000 		ldl.sx	%s62,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2650      BF003E03 
 2651 3680 14000000 		ldl.sx	%s63,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 2651      BF003F03 
 2652 3688 00000000 		divs.w.sx	%s62,%s63,%s62
 2652      BEBF3E7B 
 2653 3690 00000000 		or	%s62,0,%s62
 2653      BE003E45 
 2654 3698 C0FFFFFF 		brlt.l	0,%s62,.L5.40
 2654      BE000218 
 2655 36a0 10FCFFFF 		br.l	.L5.25
 2655      00000F18 
 2656              	.L5.0:
 2657              	# line 393
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv2.cpp ****             }
 2658              		.loc	1 393 0
 2659 36a8 D0FFFFFF 		lea	%s63,-48
 2659      00003F06 
 2660 36b0 00000000 		adds.l	%s60,%fp,%s63
 2660      BF893C59 
 2661 36b8 00000000 		or	%s18,0,%s40
 2661      A8001245 
 2662 36c0 A8FFFFFF 		br.l	.L5.26
 2662      00000F18 
 2663              		.cfi_endproc
 2664              		.set	.L.6.2auto_size,	0xfffffffffffffd70	# 656 Bytes
 2666              	# ============ End  conv::sxconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
