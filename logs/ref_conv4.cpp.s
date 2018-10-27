   1              		.ident "nc++ 1.5.2 (Build 11:19:31 Oct  2 2018)"
   2              		.file "ref_conv4.cpp"
   3              		.file 1 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp"
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
  41              		.file 39 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/../idiv.hpp"
  42              		.file 40 "/opt/nec/ve/ncc/1.5.2/include/omp.h"
  43              	# ============ Begin  _ZZN4conv13refconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_RKS3_iS6_iii
  44              		.text
  45              		.balign 16
  46              	# line 198
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** /*******************************************************************************
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * Copyright 2017 NEC Laboratories America
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** *
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * Licensed under the Apache License, Version 2.0 (the "License");
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * you may not use this file except in compliance with the License.
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * You may obtain a copy of the License at
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** *
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** *     http://www.apache.org/licenses/LICENSE-2.0
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** *
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * Unless required by applicable law or agreed to in writing, software
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * distributed under the License is distributed on an "AS IS" BASIS,
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * See the License for the specific language governing permissions and
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** * limitations under the License.
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** *******************************************************************************/
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** /** \file
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * remove lambdas */
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #include "conv.hpp"
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #include "../idiv.hpp"
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #include "omp.h"
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define G  p->g
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define MB p->mb
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define IC p->ic
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define OC p->oc
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define KH p->kh
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define IH p->ih
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define OH p->oh
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define SH p->sh
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define PH p->ph
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define KW p->kw
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define IW p->iw
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define OW p->ow
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define SW p->sw
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define PW p->pw
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** //const int DH = p->dh + 1;
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** //const int DW = p->dw + 1;
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** namespace conv {
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** extern void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** extern void sxconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** extern void sxconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** extern void sxconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** /** greatest common denominator, a,b > 0 */
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** static int gcd(int a, int b)
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (;;)
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     {
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         if (a == 0) return b;
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         b %= a;
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         if (b == 0) return a;
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         a %= b;
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** }
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** /** lowest common multiple, a,b > 0 */
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** static int lcm(int a, int b)
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     int temp = gcd(a, b);
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     return temp ? (a / temp * b) : 0;
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** }
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** /** hoist `A+iB in range [C,D)` condition out of a loop for i in [imin,imax].
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * When 
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * Original:
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * \code
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * for(i=imin; i<imax; ++i){       // original loop
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  *   if( ApiB < c || ApiB > d ) continue;
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  *   // Loop Body
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * }
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * \endcode
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * Transformed:
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * \code
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * int const ibeg, iend;
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * for(i=ibeg; i<iend; ++i){       // original loop
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  *   int const ApiB = a + i*b;
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  *   // GONE: if( ApiB < c || ApiB > d ) continue;
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  *   // Loop Body
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * }
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * \endcode
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * \pre \c b > 0, (c, d?)
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  */
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** static inline void hoist_ApiB_in( int& beg, int& end,
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         const int imin, const int imax,
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         const int a, const int b, const int c, const int d)
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     RT_ASSERT( b > 0 );
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     // int i*B < A    iff    i < (A    )/B
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     // int i*B > A    iff    i > (A+B-1)/A
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     // A+iB >= c ... iB >= c-A  ... i >= (c-A + B-1 )/B
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     beg = div_floor( c-a+b-1, b );
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if( beg < imin ) beg = imin;
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     // A+iB < d ... iB < d-A    ... i < (d-A) / B
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     end = div_floor( d-a+b-1, b );
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if( end > imax ) end = imax;
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** }
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** // n0_i_k_yy arranged loops row-wise, and had unit stride for ... kx (kw) and outc (ow)
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 0
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** void corr1Csc( float const * __restrict__ const im, long const sc, float const alpha
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                , float const * __restrict__ const krn, long const ksz
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                , float * __restrict__ const out
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                , long const outsz )
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (long kx = 0; kx < ksz; ++kx) {
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for(long xx=0 ; xx<outsz; ++xx){
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       creal const c=alpha*krn[kx];
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       out[xx] += c * im[xx*sc+kx];
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** }
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** inline void corr_n0d_i_k_yy_00( Ndata0 &d, creal alpha, int const sr, int const sc )
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   assert( d.kr < d.imr );
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   assert( d.kc < d.imc );
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   long outr = (d.imr - d.kr) / sr + 1;
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   long outc = (d.imc - d.kc) / sc + 1;
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   assert( outr <= d.imr );
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   assert( outc <= d.imc );
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for(size_t i=0U; i<d.nIm; ++i){
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     size_t const o = i/d.kd;
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     size_t const kp = i - o*d.kd;
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for(size_t k=0U; k<d.nKrn; ++k){
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (long ky = 0; ky < d.kr; ++ky) { // kernel col
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for(long yy = 0; yy < outr; ++yy) { // image/output row
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           corr1Csc( d.im     + i*d.imr*d.imc + yy*sr*d.imc + ky*d.imc
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     , sc, alpha
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     , d.krn  + k*d.kd*d.kr*d.kc + kp*d.kr*d.kc + ky*d.kc
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     , d.kc
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     , d.out  + o*d.nKrn*outc*outr + k*outc*outr + yy*outc
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     , outc );
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** }
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** void refconv_4_fwd(const prb_t *p, dnn_mem_t &src_m,
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                    dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m)
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define FWD_g_mb_oc_oh_ow \
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int g = 0; g < G; ++g) \
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int mb = 0; mb < MB; ++mb) \
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int oc = 0; oc < OC/G; ++oc) \
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int oh = 0; oh < OH; ++oh) \
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int ow = 0; ow < OW; ++ow)
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   auto xdst_init = []( const prb_t *p,
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                        const dnn_mem_t &bia_m, const dnn_mem_t &dst_m )
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   {
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (p->dir & FLAG_BIA){
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(parallel for collapse(5) schedule(static))//;
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       FWD_g_mb_oc_oh_ow {
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t bia_off = bia_off_f(p, g, oc);
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         float &d = ((float*)dst_m)[dst_off];
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         d = ((float*)bia_m)[bia_off];
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }else{
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(parallel for collapse(5) schedule(static))//;
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       FWD_g_mb_oc_oh_ow {
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         float &d = ((float*)dst_m)[dst_off];
 180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         d = 0;
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   };
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   auto xdst_relu = []( const prb_t *p, const dnn_mem_t &dst_m )
 186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   {
 187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (p->merge == RELU ){
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(for collapse(5))//;
 189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       FWD_g_mb_oc_oh_ow {
 190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         float &d = ((float*)dst_m)[dst_off];
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         d = (d < 0? 0: d);
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   };
 196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   auto dst_init = []( const prb_t *p, const dnn_mem_t &bia_m, const int bia_off,
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                        const dnn_mem_t &dst_m,
 198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                        const int mb, const int g, const int oc, const int oh ) {
  47              		.loc	1 198 0
  49              	conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, dnn_mem_t const&, int, int, int, int)#1}::operator()(conv::prb_t const*, dnn_mem_t const&, int, dnn_mem_t const&, int, int, int, int) const:
  50              		.cfi_startproc
  51 0000 00000000 		st	%fp,0x0(,%sp)
  51      8B000911 
  52              		.cfi_def_cfa_offset	0
  53              		.cfi_offset	9,0
  54 0008 08000000 		st	%lr,0x8(,%sp)
  54      8B000A11 
  55 0010 18000000 		st	%got,0x18(,%sp)
  55      8B000F11 
  56 0018 20000000 		st	%plt,0x20(,%sp)
  56      8B001011 
  57 0020 00000000 		or	%fp,0,%sp
  57      8B000945 
  58              		.cfi_def_cfa_register	9
  59 0028 30000000 		st	%s18,48(,%fp)
  59      89001211 
  60 0030 00FFFFFF 		lea	%s13,.L.1.2auto_size&0xffffffff
  60      00000D06 
  61 0038 00000000 		and	%s13,%s13,(32)0
  61      608D0D44 
  62 0040 FFFFFFFF 		lea.sl	%sp,.L.1.2auto_size>>32(%fp,%s13)
  62      8D898B06 
  63 0048 48000000 		brge.l.t	%sp,%sl,.L0.EoP
  63      888B3518 
  64 0050 18000000 		ld	%s61,0x18(,%tp)
  64      8E003D01 
  65 0058 00000000 		or	%s62,0,%s0
  65      80003E45 
  66 0060 3B010000 		lea	%s63,0x13b
  66      00003F06 
  67 0068 00000000 		shm.l	%s63,0x0(%s61)
  67      BD033F31 
  68 0070 08000000 		shm.l	%sl,0x8(%s61)
  68      BD030831 
  69 0078 10000000 		shm.l	%sp,0x10(%s61)
  69      BD030B31 
  70 0080 00000000 		monc
  70      0000003F 
  71 0088 00000000 		or	%s0,0,%s62
  71      BE000045 
  72              	.L0.EoP:
  73              	# End of prologue codes
  74              	# line 199
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     const float val = (p->dir & FLAG_BIA) ? ((float*)bia_m)[bia_off]: 0.f;
  75              		.loc	1 199 0
  76 0090 48000000 		ldl.zx	%s63,72(,%s1)	# *(p).dir
  76      8100BF03 
  77 0098 00000000 		adds.w.sx	%s63,0,%s63
  77      BF003F4A 
  78 00a0 04000000 		lea	%s62,4
  78      00003E06 
  79 00a8 00000000 		and	%s62,%s63,%s62
  79      BEBF3E44 
  80 00b0 C8010000 		brne.w	0,%s62,.L0.0
  80      BE008318 
  81 00b8 00000000 		or	%s63,0,(0)1
  81      00003F45 
  82 00c0 A0010000 		br.l	.L0.1
  82      00000F18 
  83              	.L0.2:
  84 00c8 18000000 		br.l	.L0.3
  84      00000F18 
  85              	.L0.4:
  86              	# line 200
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int ow = 0; ow < OW; ++ow) {
  87              		.loc	1 200 0
  88 00d0 80000000 		mins.w.sx	%s62,%s59,%s62
  88      BEBB3E78 
  89 00d8 48000000 		br.l	.L0.5
  89      00000F18 
  90              	.L0.3:
  91              	# line 205
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       float &d = ((float*)dst_m)[dst_off];
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       d = val;
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   };
  92              		.loc	1 205 0
  93              	# Start of epilogue codes
  94 00e0 30000000 		ld	%s18,48(,%fp)
  94      89001201 
  95 00e8 00000000 		or	%sp,0,%fp
  95      89000B45 
  96              		.cfi_def_cfa	11,8
  97 00f0 18000000 		ld	%got,0x18(,%sp)
  97      8B000F01 
  98 00f8 20000000 		ld	%plt,0x20(,%sp)
  98      8B001001 
  99 0100 08000000 		ld	%lr,0x8(,%sp)
  99      8B000A01 
 100 0108 00000000 		ld	%fp,0x0(,%sp)
 100      8B000901 
 101 0110 00000000 		b.l	(,%lr)
 101      8A000F19 
 102              	.L0.6:
 103 0118 C8FFFFFF 		br.l	.L0.3
 103      00000F18 
 104              	.L0.5:
 105              	# line 203
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 106              		.loc	1 203 0
 107 0120 00000000 		lvl	%s62
 107      00BE00BF 
 108 0128 0000003F 		vbrdu	%v63,%s63
 108      00BF808C 
 109 0130 00000000 		or	%s58,0,%s61
 109      BD003A45 
 110 0138 0000003F 		vstu.nc	%v63,4,%s58
 110      BA040092 
 111              	# line 200
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int ow = 0; ow < OW; ++ow) {
 112              		.loc	1 200 0
 113 0140 00000000 		adds.l	%s61,%s61,%s60
 113      BCBD3D59 
 114 0148 00000000 		subs.w.sx	%s59,%s59,%s62
 114      BEBB3B5A 
 115 0150 C8FFFFFF 		brge.w	0,%s59,.L0.6
 115      BB008518 
 116 0158 78FFFFFF 		br.l	.L0.4
 116      00000F18 
 117              	.L0.7:
 118 0160 00000000 		or	%s5,0,%s5
 118      85000545 
 119              	# line 201
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 120              		.loc	1 201 0
 121 0168 14000000 		dldl.sx	%s58,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 121      81003A0B 
 122 0170 00000000 		or	%s57,0,%s58
 122      BA003945 
 123 0178 00000000 		mulu.l	%s57,%s5,%s57
 123      B9853949 
 124 0180 00000000 		muls.w.sx	%s6,%s58,%s6
 124      86BA064B 
 125 0188 00000000 		dldl.sx	%s58,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 125      81003A0B 
 126 0190 00000000 		divs.w.sx	%s58,%s6,%s58
 126      BA863A7B 
 127 0198 00000000 		or	%s58,0,%s58
 127      BA003A45 
 128 01a0 00000000 		addu.l	%s58,%s57,%s58
 128      BAB93A48 
 129 01a8 00000000 		or	%s7,0,%s7
 129      87000745 
 130 01b0 00000000 		addu.l	%s7,%s58,%s7
 130      87BA0748 
 131 01b8 18000000 		dldl.sx	%s1,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 131      8100010B 
 132 01c0 00000000 		or	%s1,0,%s1
 132      81000145 
 133 01c8 00000000 		mulu.l	%s1,%s7,%s1
 133      81870149 
 134 01d0 F0000000 		dldl.sx	%s58,240(,%fp)	# oh
 134      89003A0B 
 135 01d8 00000000 		or	%s58,0,%s58
 135      BA003A45 
 136 01e0 00000000 		addu.l	%s58,%s1,%s58
 136      BA813A48 
 137 01e8 00000000 		or	%s57,0,%s18
 137      92003945 
 138 01f0 00000000 		mulu.l	%s57,%s58,%s57
 138      B9BA3949 
 139 01f8 00000000 		or	%s57,0,%s57
 139      B9003945 
 140              	# line 200
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int ow = 0; ow < OW; ++ow) {
 141              		.loc	1 200 0
 142 0200 00000000 		muls.l	%s57,4,%s57
 142      B904396E 
 143 0208 00000000 		subs.w.sx	%s18,0,%s18
 143      9200125A 
 144              	# line 202
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       d = val;
 145              		.loc	1 202 0
 146 0210 A8010000 		dld	%s4,424(,%s4)	# *(dst_m).data_
 146      84000409 
 147              	# line 200
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 148              		.loc	1 200 0
 149 0218 00000000 		adds.l	%s57,%s4,%s57
 149      B9843959 
 150 0220 00000000 		subs.w.sx	%s18,0,%s18
 150      9200125A 
 151 0228 00000000 		smvl	%s58
 151      00003A2E 
 152 0230 80000000 		mins.w.sx	%s62,%s18,%s58
 152      BA923E78 
 153 0238 00000000 		or	%s59,0,%s18
 153      92003B45 
 154 0240 00000000 		or	%s61,0,%s57
 154      B9003D45 
 155 0248 00000000 		or	%s58,0,%s62
 155      BE003A45 
 156 0250 00000000 		muls.l	%s60,4,%s58
 156      BA043C6E 
 157 0258 C8FEFFFF 		br.l	.L0.5
 157      00000F18 
 158              	.L0.1:
 159 0260 1C000000 		ldl.sx	%s18,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 159      81001203 
 160 0268 F8FEFFFF 		brlt.w	0,%s18,.L0.7
 160      92008218 
 161 0270 58FEFFFF 		br.l	.L0.2
 161      00000F18 
 162              	.L0.0:
 163 0278 00000000 		or	%s3,0,%s3
 163      83000345 
 164              	# line 199
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int ow = 0; ow < OW; ++ow) {
 165              		.loc	1 199 0
 166 0280 A8010000 		ld	%s2,424(,%s2)	# *(bia_m).data_
 166      82000201 
 167 0288 00000000 		muls.l	%s3,4,%s3
 167      8304036E 
 168 0290 00000000 		ldu	%s63,0(%s3,%s2)	# float
 168      82833F02 
 169 0298 C8FFFFFF 		br.l	.L0.1
 169      00000F18 
 170              		.cfi_endproc
 171              		.set	.L.1.2auto_size,	0xffffffffffffff00	# 256 Bytes
 173              	# ============ End  _ZZN4conv13refconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_RKS3_iS6_iiiiE
 174              	# ============ Begin  _ZZN4conv13refconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_RKS3_iiiiE_c
 175              		.balign 16
 176              	# line 207
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   auto bias_relu = []( const prb_t *p, const dnn_mem_t &dst_m,
 207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                        const int mb, const int g, const int oc, const int oh ) {
 177              		.loc	1 207 0
 179              	conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, int, int, int)#1}::operator()(conv::prb_t const*, dnn_mem_t const&, int, int, int, int) const:
 180              		.cfi_startproc
 181 02a0 00000000 		st	%fp,0x0(,%sp)
 181      8B000911 
 182              		.cfi_def_cfa_offset	0
 183              		.cfi_offset	9,0
 184 02a8 08000000 		st	%lr,0x8(,%sp)
 184      8B000A11 
 185 02b0 18000000 		st	%got,0x18(,%sp)
 185      8B000F11 
 186 02b8 20000000 		st	%plt,0x20(,%sp)
 186      8B001011 
 187 02c0 00000000 		or	%fp,0,%sp
 187      8B000945 
 188              		.cfi_def_cfa_register	9
 189 02c8 30000000 		st	%s18,48(,%fp)
 189      89001211 
 190 02d0 00FFFFFF 		lea	%s13,.L.2.2auto_size&0xffffffff
 190      00000D06 
 191 02d8 00000000 		and	%s13,%s13,(32)0
 191      608D0D44 
 192 02e0 FFFFFFFF 		lea.sl	%sp,.L.2.2auto_size>>32(%fp,%s13)
 192      8D898B06 
 193 02e8 48000000 		brge.l.t	%sp,%sl,.L1.EoP
 193      888B3518 
 194 02f0 18000000 		ld	%s61,0x18(,%tp)
 194      8E003D01 
 195 02f8 00000000 		or	%s62,0,%s0
 195      80003E45 
 196 0300 3B010000 		lea	%s63,0x13b
 196      00003F06 
 197 0308 00000000 		shm.l	%s63,0x0(%s61)
 197      BD033F31 
 198 0310 08000000 		shm.l	%sl,0x8(%s61)
 198      BD030831 
 199 0318 10000000 		shm.l	%sp,0x10(%s61)
 199      BD030B31 
 200 0320 00000000 		monc
 200      0000003F 
 201 0328 00000000 		or	%s0,0,%s62
 201      BE000045 
 202              	.L1.EoP:
 203              	# End of prologue codes
 204              	# line 216
 208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 0
 209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             float &d = ((float*)dst_m)[dst_off];
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (p->merge == RELU && d < 0.f)
 213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               d = 0.f;
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #else
 216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (p->merge == RELU){
 205              		.loc	1 216 0
 206 0330 5C000000 		ldl.zx	%s63,92(,%s1)	# *(p).merge
 206      8100BF03 
 207 0338 00000000 		adds.w.sx	%s63,0,%s63
 207      BF003F4A 
 208 0340 B8010000 		breq.w	1,%s63,.L1.0
 208      BF018418 
 209 0348 20000000 		br.l	.L1.1
 209      00000F18 
 210              	.L1.2:
 211 0350 18000000 		br.l	.L1.1
 211      00000F18 
 212              	.L1.3:
 213              	# line 217
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int ow = 0; ow < OW; ++ow) {
 214              		.loc	1 217 0
 215 0358 80000000 		mins.w.sx	%s61,%s59,%s61
 215      BDBB3D78 
 216 0360 48000000 		br.l	.L1.4
 216      00000F18 
 217              	.L1.1:
 218              	# line 225
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         float &d = ((float*)dst_m)[dst_off];
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         if (d < 0)
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           d = 0;
 222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   };
 219              		.loc	1 225 0
 220              	# Start of epilogue codes
 221 0368 30000000 		ld	%s18,48(,%fp)
 221      89001201 
 222 0370 00000000 		or	%sp,0,%fp
 222      89000B45 
 223              		.cfi_def_cfa	11,8
 224 0378 18000000 		ld	%got,0x18(,%sp)
 224      8B000F01 
 225 0380 20000000 		ld	%plt,0x20(,%sp)
 225      8B001001 
 226 0388 08000000 		ld	%lr,0x8(,%sp)
 226      8B000A01 
 227 0390 00000000 		ld	%fp,0x0(,%sp)
 227      8B000901 
 228 0398 00000000 		b.l	(,%lr)
 228      8A000F19 
 229              	.L1.5:
 230 03a0 C8FFFFFF 		br.l	.L1.1
 230      00000F18 
 231              	.L1.4:
 232 03a8 00000000 		or	%s62,0,%s63
 232      BF003E45 
 233              	# line 221
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 234              		.loc	1 221 0
 235 03b0 00000000 		lvl	%s61
 235      00BD00BF 
 236 03b8 0000003F 		vldu.nc	%v63,4,%s62
 236      BE040082 
 237 03c0 00000000 		or	%s62,0,(0)1
 237      00003E45 
 238 03c8 003F003E 		vfmax.s	%v62,%s62,%v63
 238      00BEA0BD 
 239 03d0 00000000 		or	%s62,0,%s63
 239      BF003E45 
 240 03d8 0000003E 		vstu.nc	%v62,4,%s62
 240      BE040092 
 241              	# line 217
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int ow = 0; ow < OW; ++ow) {
 242              		.loc	1 217 0
 243 03e0 00000000 		adds.l	%s63,%s63,%s60
 243      BCBF3F59 
 244 03e8 00000000 		subs.w.sx	%s59,%s59,%s61
 244      BDBB3B5A 
 245 03f0 B0FFFFFF 		brge.w	0,%s59,.L1.5
 245      BB008518 
 246 03f8 60FFFFFF 		br.l	.L1.3
 246      00000F18 
 247              	.L1.6:
 248 0400 00000000 		or	%s3,0,%s3
 248      83000345 
 249              	# line 220
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           d = 0;
 250              		.loc	1 220 0
 251 0408 14000000 		dldl.sx	%s62,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 251      81003E0B 
 252 0410 00000000 		or	%s58,0,%s62
 252      BE003A45 
 253 0418 00000000 		mulu.l	%s58,%s3,%s58
 253      BA833A49 
 254 0420 00000000 		muls.w.sx	%s62,%s4,%s62
 254      BE843E4B 
 255 0428 00000000 		dldl.sx	%s57,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 255      8100390B 
 256 0430 00000000 		divs.w.sx	%s57,%s62,%s57
 256      B9BE397B 
 257 0438 00000000 		or	%s57,0,%s57
 257      B9003945 
 258 0440 00000000 		addu.l	%s57,%s58,%s57
 258      B9BA3948 
 259 0448 00000000 		or	%s5,0,%s5
 259      85000545 
 260 0450 00000000 		addu.l	%s5,%s57,%s5
 260      85B90548 
 261 0458 18000000 		dldl.sx	%s1,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 261      8100010B 
 262 0460 00000000 		or	%s1,0,%s1
 262      81000145 
 263 0468 00000000 		mulu.l	%s1,%s5,%s1
 263      81850149 
 264 0470 00000000 		or	%s6,0,%s6
 264      86000645 
 265 0478 00000000 		addu.l	%s6,%s1,%s6
 265      86810648 
 266 0480 00000000 		or	%s62,0,%s18
 266      92003E45 
 267 0488 00000000 		mulu.l	%s62,%s6,%s62
 267      BE863E49 
 268 0490 00000000 		or	%s62,0,%s62
 268      BE003E45 
 269              	# line 217
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 270              		.loc	1 217 0
 271 0498 00000000 		muls.l	%s62,4,%s62
 271      BE043E6E 
 272 04a0 00000000 		subs.w.sx	%s18,0,%s18
 272      9200125A 
 273              	# line 220
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           d = 0;
 274              		.loc	1 220 0
 275 04a8 A8010000 		dld	%s2,424(,%s2)	# *(dst_m).data_
 275      82000209 
 276              	# line 217
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 277              		.loc	1 217 0
 278 04b0 00000000 		adds.l	%s62,%s2,%s62
 278      BE823E59 
 279 04b8 00000000 		subs.w.sx	%s18,0,%s18
 279      9200125A 
 280 04c0 00000000 		smvl	%s58
 280      00003A2E 
 281 04c8 80000000 		mins.w.sx	%s61,%s18,%s58
 281      BA923D78 
 282 04d0 00000000 		or	%s59,0,%s18
 282      92003B45 
 283 04d8 00000000 		or	%s63,0,%s62
 283      BE003F45 
 284 04e0 00000000 		or	%s62,0,%s61
 284      BD003E45 
 285 04e8 00000000 		muls.l	%s60,4,%s62
 285      BE043C6E 
 286 04f0 B8FEFFFF 		br.l	.L1.4
 286      00000F18 
 287              	.L1.0:
 288 04f8 1C000000 		ldl.sx	%s18,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 288      81001203 
 289 0500 00FFFFFF 		brlt.w	0,%s18,.L1.6
 289      92008218 
 290 0508 48FEFFFF 		br.l	.L1.2
 290      00000F18 
 291              		.cfi_endproc
 292              		.set	.L.2.2auto_size,	0xffffffffffffff00	# 256 Bytes
 294              	# ============ End  conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, int, int, int)#1}::operator() const
 295              	# ============ Begin  _ZZN4conv15refconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_cl
 296              		.balign 16
 297              	# line 550
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // writing to dst[ p,mb,g,oc,oh,ow ]
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 1 // revert back to old speed champ for short regr tests, and clean up
 228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // regr.sh-FWD 2.39x
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   int ohb[KH], ohe[KH];
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kh = 0; kh < p->kh; ++kh) {
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohb[kh] = div_floor(    + PH - kh*(p->dh+1) + SH - 1, SH);//(c-a+b-1)/b
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohe[kh] = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohb[kh] < 0 ) ohb[kh] = 0;
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohe[kh] > OH) ohe[kh] = OH;
 235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   int owb[KW], owe[KW];
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kw = 0; kw < KW; ++kw) {
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owb[kw] = div_floor(    + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owe[kw] = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owb[kw] < 0 ) owb[kw] = 0;
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owe[kw] > OW) owe[kw] = OW;
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   OMP(parallel for collapse(3))//;
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int g = 0; g < G; ++g) {
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t bia_off = bia_off_f(p, g, oc);
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int kh = 0; kh < p->kh; ++kh) { // <--- write-aliasing
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_end = ohe[kh];
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( ohb[kh] >= oh_end ) continue;
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int ow_end = owe[kw];
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if( owb[kw] >= ow_end ) continue;
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = ohb[kh]; oh < oh_end; ++oh) {
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int ih = oh * SH - PH + kh * (p->dh + 1);
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ic = 0; ic < IC/G; ++ic) { // <--- !!!
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int ow = owb[kw]; ow < ow_end; ++ow) {
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int iw = ow * SW - PW + kw * (p->dw + 1);
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   float &d = ((float*)dst_m)[dst_off];
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           bias_relu(p, dst_m, mb, g, oc, oh);
 274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #else
 279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #error "select one!"
 280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** }
 282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** /** 6.3 x w/ conditional hoisting and loop order
 284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * g,mb,ic,oc,kh,kw,oh,[ih],ow,[iw] */
 285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
 286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                      dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
 288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 1 && defined(__ve) // compiler bug! XXX TODO temporarily disabled
 289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //refconv_2_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
 290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // I managed to fix a similar error for sx_conv3 with nc++ compiler.
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   sxconv_3_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
 292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 0 // regr 1.91
 293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // + dilates: 1.81x
 294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int ow_lowest = (bww>0? bww: 0);
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //const int ohb[KH], ohe[KH], 
 301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   OMP(parallel for collapse(3))//;
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int mb = 0; mb < MB; ++mb) {
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         //const size_t src_off = src_off_f(p, mb, g, ic, ih, iw); // WRITTEN
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             ds = 0;
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           int oh_beg, oh_end;
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           // TODO: optimize, same as fwd
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define HOIST_OH 1
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if HOIST_OH==0
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           hoist_ApiB_in( /* set     */ oh_beg, oh_end,
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                          /*oh  in   */ oh_lowest, OH,
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                          /*ih=A+ohB */ -PH + kh*(p->dh+1), SH, // B>0, ApiB OK
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                          /*ih in    */ 0, IH);
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif HOIST_OH==1 // see ref_conv3 for this version, ref_conv5 for yet another
 324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     oh_beg = div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     oh_end = div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (oh_beg < 0    ) oh_beg = 0;
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (oh_end > OH) oh_end = OH;
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #else
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #error "huh"
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int ow_beg, ow_end;
 333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if HOIST_OH==0
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             hoist_ApiB_in( /* set     */ ow_beg, ow_end,
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                            /*ow  in   */ ow_lowest, OW,
 336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                            /*iw=A+owB */ -PW + kw*(p->dw+1), SW, // B>0, ApiB OK
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                            /*iw in    */ 0, IW);
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif HOIST_OH==1
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_beg = div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_end = div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_beg < 0    ) ow_beg = 0;
 342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_end > OW) ow_end = OW;
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #else
 344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #error "huh"
 345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 0
 347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = oh_beg; oh < oh_end; ++oh) {
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int ih  =  oh*SH - PH + kh * (p->dh+1);
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ow = ow_beg; ow < ow_end; ++ow) {
 350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float tmp=0.0f;
 351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int oc = 0; oc < OC/G; ++oc) {
 352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
 355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int iw  =  ow*SW - PW + kw * (p->dw+1);
 357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float &ds = ((float*)diff_src_m)[src_off];
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 ds += tmp;
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #else
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             // aliasing analysis does not seem easy. (between kh/ih and kh/iw)
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             // src_off_f:
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             //    ((mb * IC + g * IC/G + ic) * IH + ih) * IW
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             // Q: when is ih for one kh equal to ih for some other kh?
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             // Usual case has lots of aliasing happening!
 368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             // Soln would be to split into 3 cases (each)
 369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             // kh "left" kh "full-range" kh "right"
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             //and the reorder to loops oh-first...
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             //........
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             //but this ends up looking a lot like plain refconv3
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int ih = oh_beg * SH - PH + kh * (p->dh+1);
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int Aiw = kw * (p->dw+1) - PW;
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = oh_beg; oh < oh_end; ++oh) {
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               //const int ih  =  oh*SH - PH + kh * (p->dh+1);
 377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               //int iw= ow_beg * SW - PW + kw * (p->dw+1);
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               int iw = ow_beg * SW + Aiw;
 379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ow = ow_beg; ow < ow_end; ++ow) {
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float tmp=0.0f;
 381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int oc = 0; oc < OC/G; ++oc) {
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //const int iw  =  ow*SW - PW + kw * (p->dw+1);
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //RT_ASSERT( iw == iw2 );
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const size_t src_off = src_off_f(p, mb, g, ic, ih, iw); // WRITTEN
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float &ds = ((float*)diff_src_m)[src_off];
 390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //   We are looping over kh,kw here.
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //   It IS possible that ds[mb,g,ic,ih,iw] has the same value for different
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //   values of kh (or kw).  So ds += is not omp-thread-safe.
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** //#pragma omp atomic // omp loops are mg, g, ic ---> no need for atomic
 394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 ds += tmp;
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 iw += SW;
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               ih += SH;
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 1 // regr 1.91
 406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // + dilates: 1.81x
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   int ohb[KH], ohe[KH], owb[KW], owe[KW]; // precalc oh_beg/end, ow_beg/end
 408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int ahh= div_floor( PH - (p->kh-1)*(p->dh+1), SH );
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int bhh= ahh*SH - PH + (p->kh-1) * (p->dh+1);
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int oh_lowest = (bhh>0? bhh: 0); /// Wow, oh0 is INDEPENDENT of all loop vars
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int aww= div_floor( PW - (KW-1)*(p->dw+1), SW );
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int bww= aww*SW - PW + (KW-1) * (p->dw+1);
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int ow_lowest = (bww>0? bww: 0);
 414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  if defined HERE, nc++ generates incorrect code:
 415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //int ohb[KH], ohe[KH], owb[KW], owe[KW]; // precalc oh_beg/end, ow_beg/end
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kh = 0; kh < p->kh; ++kh) {
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     int oh_beg = div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     int oh_end = div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
 419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (oh_beg < 0 ) oh_beg = 0;
 420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (oh_end > OH) oh_end = OH;
 421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohb[kh] = oh_beg;
 422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohe[kh] = oh_end;
 423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kw = 0; kw < p->kw; ++kw) {
 425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     int ow_beg = div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
 426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     int ow_end = div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
 427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ow_beg < 0 ) ow_beg = 0;
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ow_end > OW) ow_end = OW;
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owb[kw] = ow_beg;
 430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owe[kw] = ow_end;
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //print(10, "bwd_d oh/ow_lowest = %d,%d\n", oh_lowest, ow_lowest );
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   OMP(parallel for collapse(3))//;
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int mb = 0; mb < MB; ++mb) {
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         //const size_t src_off = src_off_f(p, mb, g, ic, ih, iw); // WRITTEN
 438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             ds = 0;
 443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_beg = ohb[kh];
 447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_end = ohe[kh];
 448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int ow_beg = owb[kw];
 450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int ow_end = owe[kw];
 451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 1
 452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = oh_beg; oh < oh_end; ++oh) {
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int ih  =  oh*SH - PH + kh * (p->dh+1);
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               IVDEP() for (int ow = ow_beg; ow < ow_end; ++ow) {
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float tmp=0.0f;
 456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int oc = 0; oc < OC/G; ++oc) {
 457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int iw  =  ow*SW - PW + kw * (p->dw+1);
 462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float &ds = ((float*)diff_src_m)[src_off];
 464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 ds += tmp;
 465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #else
 468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int ih = oh_beg * SH - PH + kh * (p->dh+1);
 469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int Aiw = kw * (p->dw+1) - PW;
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = oh_beg; oh < oh_end; ++oh) {
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               //const int ih  =  oh*SH - PH + kh * (p->dh+1);
 472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               //int iw= ow_beg * SW - PW + kw * (p->dw+1);
 473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               int iw = ow_beg * SW + Aiw;
 474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ow = ow_beg; ow < ow_end; ++ow) {
 475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float tmp=0.0f;
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int oc = 0; oc < OC/G; ++oc) {
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp += ((float*)diff_dst_m)[dst_off] * ((float*)wei_m)[wei_off];
 480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //const int iw  =  ow*SW - PW + kw * (p->dw+1);
 482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //RT_ASSERT( iw == iw2 );
 483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const size_t src_off = src_off_f(p, mb, g, ic, ih, iw); // WRITTEN
 484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float &ds = ((float*)diff_src_m)[src_off];
 485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //   We are looping over kh,kw here.
 486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //   It IS possible that ds[mb,g,ic,ih,iw] has the same value for different
 487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 //   values of kh (or kw).  So ds += is not omp-thread-safe.
 488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** //#pragma omp atomic // omp loops are mg, g, ic ---> no need for atomic
 489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 ds += tmp;
 490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 iw += SW;
 491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               ih += SH;
 493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 1
 501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #error "oops"
 502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** }
 504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** /** hoist and reorder loops.
 506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****  * g,mb,ic,oc,kh,kw,oh,[ih],ow,[iw] */
 507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** void refconv_4_bwd_w(const prb_t *p, dnn_mem_t &src_m,
 508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                      dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m)
 509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** {
 510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 15 is default
 511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define BW4 19
 512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 14 : 9.35
 513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 15 : 9.39
 514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 16 : 9.18
 515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 17 : 12.58 FAIL
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 18 : 7.55
 517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 19 : 16.1
 518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 20 : 17.9
 519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 21 : 2.07
 520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 22 : 3.40
 521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 23 : 5.1
 522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  Speedups Table
 523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //     Test: regr.sh 6 BWD_W, snake10(avx2)
 524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //     |   descr.............
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //         - 'tidy' means removine comments & dead code
 526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  0 1.14
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  1 1.14 tidy
 528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  2 1.37 zero_wei & mb loop ouside
 529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  3 1.27 tidy
 530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  4 1.78 hoist oh,ow
 531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  5 loop order tests XAF=1.88 XAG=2.15 XBF=1.95 XBG=1.92
 532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //                     YAF=1.86 YAG=1.95 YBF=1.98 YBG=1.99
 533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //                     ZAF=1.85 ZAG=2.26 ZBF=1.90 ZBG=1.79
 534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //                     best loop order for short tests is
 535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //                ZAG: omp(g,A:ic,kh,kw) hoist G:oc,Z:mb,oh,ow
 536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //                     changed Y to "better" posn (after hoist)
 537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //                     YAF=2.0 YAG=1.83 YBF=1.87 YBG=1.77
 538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  50 1.97 tidy ZAG
 539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  -------- mb ouside is not omp-safe !!!! (discovered later)
 540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  6 1.82 alt mb:Z loop posn not better
 541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  7 1.56 omp(g,oc,ic,kh,kw) ic&zero, mb,oh,ow ?? zeroing back inside
 542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  8 1.54 ?? init bias inside loop
 543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   //  9 1.79
 544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 10 1.91,1.91 _nog offsets (FIXED) are now a non-optimization
 545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 11 1.61 REMOVED (_nog) then fixed and omp experiments
 546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 12 1.91
 547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 13 2.28
 548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 14 2.40
 549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // It is hard to measure any speed difference from modifying the bwd_w_bias_update
 550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   auto bwd_w_bias_update = [](const prb_t* p, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m){
 298              		.loc	1 550 0
 300              	conv::refconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const:
 301              		.cfi_startproc
 302 0510 00000000 		st	%fp,0x0(,%sp)
 302      8B000911 
 303              		.cfi_def_cfa_offset	0
 304              		.cfi_offset	9,0
 305 0518 08000000 		st	%lr,0x8(,%sp)
 305      8B000A11 
 306 0520 18000000 		st	%got,0x18(,%sp)
 306      8B000F11 
 307 0528 20000000 		st	%plt,0x20(,%sp)
 307      8B001011 
 308 0530 00000000 		or	%fp,0,%sp
 308      8B000945 
 309              		.cfi_def_cfa_register	9
 310 0538 30000000 		st	%s18,48(,%fp)
 310      89001211 
 311 0540 38000000 		st	%s19,56(,%fp)
 311      89001311 
 312 0548 40000000 		st	%s20,64(,%fp)
 312      89001411 
 313 0550 00FFFFFF 		lea	%s13,.L.3.2auto_size&0xffffffff
 313      00000D06 
 314 0558 00000000 		and	%s13,%s13,(32)0
 314      608D0D44 
 315 0560 FFFFFFFF 		lea.sl	%sp,.L.3.2auto_size>>32(%fp,%s13)
 315      8D898B06 
 316 0568 48000000 		brge.l.t	%sp,%sl,.L2.EoP
 316      888B3518 
 317 0570 18000000 		ld	%s61,0x18(,%tp)
 317      8E003D01 
 318 0578 00000000 		or	%s62,0,%s0
 318      80003E45 
 319 0580 3B010000 		lea	%s63,0x13b
 319      00003F06 
 320 0588 00000000 		shm.l	%s63,0x0(%s61)
 320      BD033F31 
 321 0590 08000000 		shm.l	%sl,0x8(%s61)
 321      BD030831 
 322 0598 10000000 		shm.l	%sp,0x10(%s61)
 322      BD030B31 
 323 05a0 00000000 		monc
 323      0000003F 
 324 05a8 00000000 		or	%s0,0,%s62
 324      BE000045 
 325              	.L2.EoP:
 326              	# End of prologue codes
 327              	# line 551
 551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
 328              		.loc	1 551 0
 329 05b0 48000000 		ldl.zx	%s63,72(,%s1)	# *(p).dir
 329      8100BF03 
 330 05b8 00000000 		adds.w.sx	%s63,0,%s63
 330      BF003F4A 
 331 05c0 04000000 		lea	%s62,4
 331      00003E06 
 332 05c8 00000000 		and	%s62,%s63,%s62
 332      BEBF3E44 
 333 05d0 40070000 		brne.w	0,%s62,.L2.0
 333      BE008318 
 334 05d8 28000000 		br.l	.L2.1
 334      00000F18 
 335              	.L2.2:
 336              	# line 632
 552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     //memset( (float*)diff_bia_m, 0, diff_bia_m.size() ); // single loop, always equiv
 553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     //zero_bia(p, diff_bia_m);
 554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 0
 555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(parallel for collapse(2) //)//;
 556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     //#pragma omp parallel for collapse(2) // PT 3.6x
 557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         //#pragma omp parallel // PT 2.70x, 2.88x
 560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         {
 561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
 563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           db = 0.f; // optional (now done earlier)
 564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           //# pragma omp for collapse(3)
 565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 db += ((float*)diff_dst_m)[dst_off];
 570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 0 // 4.2x can only collapse(1) for thread-safe write
 577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(parallel for collapse(1))//;
 578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int oc = 0; oc < OC     ; ++oc) {
 579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       float &db = ((float*)diff_bia_m)[bia_off];
 581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       db = 0.f; // optional (now done earlier)
 582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int mb = 0; mb < MB; ++mb) {
 583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             size_t dst_off = dst_off_f_nog(p, mb, /*g,*/ oc, oh, ow);
 586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             db += ((float*)diff_dst_m)[dst_off];
 587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 0 // 4.2x can only collapse(1) for thread-safe write
 592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(parallel for collapse(1))//;
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int oc = 0; oc < OC     ; ++oc) {
 594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       float &db = ((float*)diff_bia_m)[bia_off];
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       db = 0.f;
 597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int mb = 0; mb < MB; ++mb) {
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int ohw = oh * OW + ow;
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             db += ((float*)diff_dst_m)[dst_off];
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 0 // 
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int oc = 0; oc < OC     ; ++oc) {
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       {
 610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         float &db = ((float*)diff_bia_m)[bia_off];
 612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         db = 0.f;
 613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         OMP(parallel for collapse(3) reduction(+:db))//;
 614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int mb = 0; mb < MB; ++mb) {
 615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int oh = 0; oh < OH; ++oh) {
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int ow = 0; ow < OW; ++ow) {
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               int ohw = oh * OW + ow;
 618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               db += ((float*)diff_dst_m)[dst_off];
 620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 1
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int oc = 0; oc < OC     ; ++oc) {
 627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       float &db = ((float*)diff_bia_m)[bia_off];
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       db = 0.f;
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(parallel for collapse(2) reduction(+:db))//;
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int mb = 0; mb < MB; ++mb) {
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ohw = 0; ohw < OH*OW; ++ohw) {
 337              		.loc	1 632 0
 338 05e0 80000000 		mins.w.sx	%s61,%s59,%s61
 338      BDBB3D78 
 339 05e8 A0040000 		br.l	.L2.3
 339      00000F18 
 340              	.L2.4:
 341 05f0 80000000 		mins.w.sx	%s60,%s55,%s60
 341      BCB73C78 
 342 05f8 78010000 		br.l	.L2.5
 342      00000F18 
 343              	.L2.1:
 344              	# line 642
 633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           db += ((float*)diff_dst_m)[dst_off];
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #else //
 639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #error "choose one!"
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }; // bwd_w_bias_update
 345              		.loc	1 642 0
 346              	# Start of epilogue codes
 347 0600 30000000 		ld	%s18,48(,%fp)
 347      89001201 
 348 0608 38000000 		ld	%s19,56(,%fp)
 348      89001301 
 349 0610 40000000 		ld	%s20,64(,%fp)
 349      89001401 
 350 0618 00000000 		or	%sp,0,%fp
 350      89000B45 
 351              		.cfi_def_cfa	11,8
 352 0620 18000000 		ld	%got,0x18(,%sp)
 352      8B000F01 
 353 0628 20000000 		ld	%plt,0x20(,%sp)
 353      8B001001 
 354 0630 08000000 		ld	%lr,0x8(,%sp)
 354      8B000A01 
 355 0638 00000000 		ld	%fp,0x0(,%sp)
 355      8B000901 
 356 0640 00000000 		b.l	(,%lr)
 356      8A000F19 
 357              	.L2.6:
 358              	# line 626
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 359              		.loc	1 626 0
 360 0648 00000000 		adds.w.sx	%s57,1,%s57
 360      B901394A 
 361 0650 00000000 		adds.l	%s58,4,%s58
 361      BA043A59 
 362 0658 00000000 		adds.w.sx	%s63,1,%s63
 362      BF013F4A 
 363 0660 68050000 		brgt.w	0,%s57,.L2.7
 363      B9008118 
 364 0668 98FFFFFF 		br.l	.L2.1
 364      00000F18 
 365              	.L2.8:
 366 0670 00000000 		or	%s57,0,%s2
 366      82003945 
 367 0678 00000000 		or	%s58,0,%s54
 367      B6003A45 
 368 0680 00000000 		or	%s63,0,%s6
 368      86003F45 
 369 0688 00000000 		or	%s50,0,%s4
 369      84003245 
 370 0690 00000000 		or	%s40,0,%s60
 370      BC002845 
 371 0698 00000000 		or	%s41,0,%s56
 371      B8002945 
 372 06a0 00000000 		or	%s56,0,%s49
 372      B1003845 
 373 06a8 00000000 		or	%s52,0,%s1
 373      81003445 
 374 06b0 00000000 		or	%s62,0,%s3
 374      83003E45 
 375 06b8 00000000 		or	%s51,0,%s5
 375      85003345 
 376 06c0 88FFFFFF 		br.l	.L2.6
 376      00000F18 
 377              	.L2.9:
 378              	# line 631
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ohw = 0; ohw < OH*OW; ++ohw) {
 379              		.loc	1 631 0
 380 06c8 00000000 		adds.w.sx	%s61,4,%s61
 380      BD043D4A 
 381 06d0 00000000 		adds.l	%s63,%s63,%s60
 381      BCBF3F59 
 382 06d8 00000000 		adds.l	%s59,%s59,%s56
 382      B8BB3B59 
 383 06e0 00000000 		adds.l	%s58,%s58,%s56
 383      B8BA3A59 
 384 06e8 00000000 		adds.l	%s57,%s57,%s56
 384      B8B93959 
 385 06f0 D0010000 		brgt.w	0,%s61,.L2.10
 385      BD008118 
 386 06f8 78FFFFFF 		br.l	.L2.8
 386      00000F18 
 387              	.L2.11:
 388              	# line 635
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 389              		.loc	1 635 0
 390 0700 00000000 		or	%s62,1,(0)1
 390      00013E45 
 391 0708 00000000 		or	%s55,0,%s54
 391      B6003745 
 392 0710 00000000 		lvl	%s62
 392      00BE00BF 
 393 0718 00000034 		vstu.nc	%v52,0,%s55
 393      B7000092 
 394 0720 A8FFFFFF 		br.l	.L2.9
 394      00000F18 
 395              	.L2.12:
 396              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 397              		.loc	1 634 0
 398 0728 00000000 		lvl	%s53
 398      00B500BF 
 399 0730 00003D32 		vfsum.s	%v50,%v61
 399      000080EC 
 400 0738 00000000 		or	%s62,1,(0)1
 400      00013E45 
 401 0740 00000000 		lvl	%s62
 401      00BE00BF 
 402 0748 00323434 		vfadd.s	%v52,%v52,%v50
 402      000080CC 
 403 0750 00000000 		or	%s61,0,%s52
 403      B4003D45 
 404 0758 00000000 		or	%s60,0,%s51
 404      B3003C45 
 405 0760 00000000 		or	%s56,0,%s50
 405      B2003845 
 406 0768 98FFFFFF 		br.l	.L2.11
 406      00000F18 
 407              	.L2.5:
 408 0770 00000000 		adds.l	%s62,%s63,(0)1
 408      00BF3E59 
 409 0778 00000000 		adds.l	%s62,%s62,%s61
 409      BDBE3E59 
 410 0780 00000000 		lvl	%s60
 410      00BC00BF 
 411 0788 0000003C 		vldu.nc	%v60,4,%s62
 411      BE040082 
 412 0790 00000000 		adds.l	%s62,%s59,(0)1
 412      00BB3E59 
 413 0798 00000000 		adds.l	%s62,%s62,%s61
 413      BDBE3E59 
 414 07a0 0000003B 		vldu.nc	%v59,4,%s62
 414      BE040082 
 415 07a8 003B3C3A 		vfadd.s	%v58,%v60,%v59
 415      000080CC 
 416 07b0 00000000 		adds.l	%s62,%s58,(0)1
 416      00BA3E59 
 417 07b8 00000000 		adds.l	%s62,%s62,%s61
 417      BDBE3E59 
 418 07c0 00000039 		vldu.nc	%v57,4,%s62
 418      BE040082 
 419 07c8 00393A38 		vfadd.s	%v56,%v58,%v57
 419      000080CC 
 420 07d0 00000000 		adds.l	%s62,%s57,(0)1
 420      00B93E59 
 421 07d8 00000000 		adds.l	%s62,%s62,%s61
 421      BDBE3E59 
 422 07e0 00000037 		vldu.nc	%v55,4,%s62
 422      BE040082 
 423 07e8 00373836 		vfadd.s	%v54,%v56,%v55
 423      000080CC 
 424 07f0 00363D3D 		vfadd.s	%v61,%v61,%v54
 424      000080CC 
 425              	# line 632
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 426              		.loc	1 632 0
 427 07f8 00000000 		adds.l	%s61,%s61,%s56
 427      B8BD3D59 
 428 0800 00000000 		subs.w.sx	%s55,%s55,%s60
 428      BCB7375A 
 429 0808 20FFFFFF 		brge.w	0,%s55,.L2.12
 429      B7008518 
 430 0810 E0FDFFFF 		br.l	.L2.4
 430      00000F18 
 431              	.L2.13:
 432 0818 00000000 		subs.w.sx	%s62,0,%s49
 432      B1003E5A 
 433 0820 00000000 		smvl	%s53
 433      0000352E 
 434 0828 80000000 		mins.w.sx	%s48,%s62,%s53
 434      B5BE3078 
 435              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 436              		.loc	1 634 0
 437 0830 00000000 		or	%s47,0,(0)1
 437      00002F45 
 438 0838 00000000 		or	%s52,0,%s61
 438      BD003445 
 439 0840 00000000 		or	%s51,0,%s60
 439      BC003345 
 440 0848 00000000 		or	%s50,0,%s56
 440      B8003245 
 441 0850 00000000 		or	%s60,0,%s48
 441      B0003C45 
 442 0858 00000000 		lvl	%s53
 442      00B500BF 
 443 0860 0000003D 		vbrdu	%v61,%s47
 443      00AF808C 
 444 0868 00000000 		or	%s55,0,%s62
 444      BE003745 
 445              	# line 632
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 446              		.loc	1 632 0
 447 0870 00000000 		or	%s61,0,(0)1
 447      00003D45 
 448 0878 00000000 		or	%s48,0,%s48
 448      B0003045 
 449 0880 00000000 		muls.l	%s56,4,%s48
 449      B004386E 
 450 0888 E8FEFFFF 		br.l	.L2.5
 450      00000F18 
 451              	.L2.14:
 452 0890 00000000 		or	%s55,1,(0)1
 452      00013745 
 453 0898 00000000 		or	%s53,0,%s54
 453      B6003545 
 454 08a0 00000000 		lvl	%s55
 454      00B700BF 
 455 08a8 00000034 		vldu.nc	%v52,0,%s53
 455      B5000082 
 456 08b0 68FFFFFF 		brlt.w	0,%s18,.L2.13
 456      92008218 
 457 08b8 48FEFFFF 		br.l	.L2.11
 457      00000F18 
 458              	.L2.10:
 459 08c0 D0FFFFFF 		brlt.w	0,%s18,.L2.14
 459      92008218 
 460 08c8 00FEFFFF 		br.l	.L2.9
 460      00000F18 
 461              	.L2.15:
 462 08d0 00000000 		or	%s55,0,%s63
 462      BF003745 
 463 08d8 00000000 		or	%s53,0,%s20
 463      94003545 
 464              	# line 631
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ohw = 0; ohw < OH*OW; ++ohw) {
 465              		.loc	1 631 0
 466 08e0 00000000 		adds.w.sx	%s61,%s20,%s46
 466      AE943D4A 
 467 08e8 00000000 		muls.l	%s48,%s55,%s51
 467      B3B7306E 
 468 08f0 00000000 		or	%s49,0,%s56
 468      B8003145 
 469 08f8 00000000 		or	%s54,0,%s58
 469      BA003645 
 470 0900 00000000 		adds.l	%s48,%s48,%s50
 470      B2B03059 
 471 0908 00000000 		muls.l	%s47,%s53,%s62
 471      BEB52F6E 
 472 0910 00000000 		or	%s1,0,%s52
 472      B4000145 
 473 0918 00000000 		or	%s2,0,%s57
 473      B9000245 
 474 0920 00000000 		adds.l	%s47,%s48,%s47
 474      AFB02F59 
 475 0928 00000000 		muls.l	%s52,%s55,%s51
 475      B3B7346E 
 476 0930 00000000 		or	%s3,0,%s62
 476      BE000345 
 477 0938 00000000 		or	%s4,0,%s50
 477      B2000445 
 478 0940 00000000 		adds.l	%s52,%s52,%s45
 478      ADB43459 
 479 0948 00000000 		muls.l	%s62,%s53,%s44
 479      ACB53E6E 
 480 0950 00000000 		or	%s5,0,%s51
 480      B3000545 
 481 0958 00000000 		or	%s6,0,%s63
 481      BF000645 
 482 0960 00000000 		adds.l	%s59,%s52,%s62
 482      BEB43B59 
 483 0968 00000000 		muls.l	%s62,%s55,%s51
 483      B3B73E6E 
 484 0970 00000000 		or	%s63,0,%s47
 484      AF003F45 
 485 0978 00000000 		adds.l	%s62,%s62,%s43
 485      ABBE3E59 
 486 0980 00000000 		muls.l	%s52,%s53,%s44
 486      ACB5346E 
 487 0988 00000000 		adds.l	%s58,%s62,%s52
 487      B4BE3A59 
 488 0990 00000000 		muls.l	%s51,%s55,%s51
 488      B3B7336E 
 489 0998 00000000 		adds.l	%s51,%s51,%s42
 489      AAB33359 
 490 09a0 00000000 		muls.l	%s53,%s53,%s44
 490      ACB5356E 
 491 09a8 00000000 		adds.l	%s57,%s51,%s53
 491      B5B33959 
 492 09b0 00000000 		or	%s56,0,%s41
 492      A9003845 
 493 09b8 00000000 		or	%s60,0,%s40
 493      A8003C45 
 494 09c0 00FFFFFF 		br.l	.L2.10
 494      00000F18 
 495              	.L2.16:
 496 09c8 08FFFFFF 		brlt.w	%s20,%s19,.L2.15
 496      93948218 
 497 09d0 78FCFFFF 		br.l	.L2.6
 497      00000F18 
 498              	.L2.17:
 499 09d8 00000000 		or	%s63,0,%s4
 499      84003F45 
 500 09e0 00000000 		or	%s57,0,%s5
 500      85003945 
 501 09e8 E0FFFFFF 		br.l	.L2.16
 501      00000F18 
 502              	.L2.18:
 503 09f0 80010000 		br.l	.L2.19
 503      00000F18 
 504              	.L2.20:
 505 09f8 00000000 		adds.w.sx	%s63,1,%s63
 505      BF013F4A 
 506 0a00 00000000 		adds.l	%s61,%s62,%s61
 506      BDBE3D59 
 507 0a08 E8FFFFFF 		brgt.w	0,%s63,.L2.18
 507      BF008118 
 508 0a10 C8FFFFFF 		br.l	.L2.17
 508      00000F18 
 509              	.L2.21:
 510              	# line 635
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 511              		.loc	1 635 0
 512 0a18 00000000 		or	%s60,1,(0)1
 512      00013C45 
 513 0a20 00000000 		or	%s59,0,%s58
 513      BA003B45 
 514 0a28 00000000 		lvl	%s60
 514      00BC00BF 
 515 0a30 00000035 		vstu.nc	%v53,0,%s59
 515      BB000092 
 516 0a38 C0FFFFFF 		br.l	.L2.20
 516      00000F18 
 517              	.L2.22:
 518 0a40 00000000 		or	%s61,0,%s3
 518      83003D45 
 519 0a48 00000000 		or	%s62,0,%s2
 519      82003E45 
 520 0a50 00000000 		or	%s63,0,%s1
 520      81003F45 
 521              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 522              		.loc	1 634 0
 523 0a58 00000000 		lvl	%s55
 523      00B700BF 
 524 0a60 00003F33 		vfsum.s	%v51,%v63
 524      000080EC 
 525 0a68 00000000 		or	%s60,1,(0)1
 525      00013C45 
 526 0a70 00000000 		lvl	%s60
 526      00BC00BF 
 527 0a78 00333535 		vfadd.s	%v53,%v53,%v51
 527      000080CC 
 528 0a80 98FFFFFF 		br.l	.L2.21
 528      00000F18 
 529              	.L2.3:
 530 0a88 00000000 		or	%s62,0,%s63
 530      BF003E45 
 531 0a90 00000000 		lvl	%s61
 531      00BD00BF 
 532 0a98 0000003E 		vldu.nc	%v62,4,%s62
 532      BE040082 
 533 0aa0 003E3F3F 		vfadd.s	%v63,%v63,%v62
 533      000080CC 
 534              	# line 632
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 535              		.loc	1 632 0
 536 0aa8 00000000 		adds.l	%s63,%s63,%s60
 536      BCBF3F59 
 537 0ab0 00000000 		subs.w.sx	%s59,%s59,%s61
 537      BDBB3B5A 
 538 0ab8 88FFFFFF 		brge.w	0,%s59,.L2.22
 538      BB008518 
 539 0ac0 20FBFFFF 		br.l	.L2.2
 539      00000F18 
 540              	.L2.23:
 541 0ac8 00000000 		subs.w.sx	%s57,0,%s56
 541      B800395A 
 542 0ad0 00000000 		smvl	%s55
 542      0000372E 
 543 0ad8 80000000 		mins.w.sx	%s54,%s57,%s55
 543      B7B93678 
 544              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 545              		.loc	1 634 0
 546 0ae0 00000000 		or	%s53,0,(0)1
 546      00003545 
 547 0ae8 00000000 		or	%s1,0,%s63
 547      BF000145 
 548 0af0 00000000 		or	%s2,0,%s62
 548      BE000245 
 549 0af8 00000000 		or	%s3,0,%s61
 549      BD000345 
 550 0b00 00000000 		lvl	%s55
 550      00B700BF 
 551 0b08 0000003F 		vbrdu	%v63,%s53
 551      00B5808C 
 552 0b10 00000000 		or	%s59,0,%s57
 552      B9003B45 
 553 0b18 00000000 		or	%s63,0,%s61
 553      BD003F45 
 554 0b20 00000000 		or	%s62,0,%s54
 554      B6003E45 
 555              	# line 632
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 556              		.loc	1 632 0
 557 0b28 00000000 		muls.l	%s60,4,%s62
 557      BE043C6E 
 558 0b30 00000000 		or	%s61,0,%s54
 558      B6003D45 
 559 0b38 50FFFFFF 		br.l	.L2.3
 559      00000F18 
 560              	.L2.24:
 561 0b40 00000000 		or	%s59,1,(0)1
 561      00013B45 
 562 0b48 00000000 		or	%s57,0,%s58
 562      BA003945 
 563 0b50 00000000 		lvl	%s59
 563      00BB00BF 
 564 0b58 00000035 		vldu.nc	%v53,0,%s57
 564      B9000082 
 565 0b60 68FFFFFF 		brlt.w	0,%s18,.L2.23
 565      92008218 
 566 0b68 B0FEFFFF 		br.l	.L2.21
 566      00000F18 
 567              	.L2.19:
 568 0b70 D0FFFFFF 		brlt.w	0,%s18,.L2.24
 568      92008218 
 569 0b78 80FEFFFF 		br.l	.L2.20
 569      00000F18 
 570              	.L2.25:
 571 0b80 00000000 		or	%s4,0,%s63
 571      BF000445 
 572 0b88 00000000 		or	%s63,0,%s52
 572      B4003F45 
 573              	# line 631
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ohw = 0; ohw < OH*OW; ++ohw) {
 574              		.loc	1 631 0
 575 0b90 00000000 		muls.l	%s60,%s61,%s51
 575      B3BD3C6E 
 576 0b98 00000000 		or	%s5,0,%s57
 576      B9000545 
 577 0ba0 00000000 		adds.l	%s60,%s60,%s50
 577      B2BC3C59 
 578 0ba8 00000000 		or	%s61,0,%s60
 578      BC003D45 
 579 0bb0 C0FFFFFF 		br.l	.L2.19
 579      00000F18 
 580              	.L2.26:
 581 0bb8 C8FFFFFF 		brlt.w	0,%s20,.L2.25
 581      94008218 
 582 0bc0 08FEFFFF 		br.l	.L2.16
 582      00000F18 
 583              	.L2.7:
 584 0bc8 00000000 		or	%s61,0,%s63
 584      BF003D45 
 585              	# line 629
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(parallel for collapse(2) reduction(+:db))//;
 586              		.loc	1 629 0
 587 0bd0 00000000 		or	%s59,0,(0)1
 587      00003B45 
 588 0bd8 00000000 		stu	%s59,0(,%s58)	# *(db)
 588      BA003B12 
 589 0be0 D8FFFFFF 		brlt.w	0,%s19,.L2.26
 589      93008218 
 590 0be8 60FAFFFF 		br.l	.L2.6
 590      00000F18 
 591              	.L2.27:
 592 0bf0 A8010000 		dld	%s2,424(,%s2)	# *(diff_bia_m).data_
 592      82000209 
 593              	# line 631
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ohw = 0; ohw < OH*OW; ++ohw) {
 594              		.loc	1 631 0
 595 0bf8 04000000 		dldl.sx	%s19,4(,%s1)	# *(p).__b_N4conv6desc_tE.mb
 595      8100130B 
 596 0c00 00000000 		subs.w.sx	%s46,0,%s19
 596      93002E5A 
 597 0c08 00000000 		and	%s20,%s19,(62)0
 597      7E931444 
 598 0c10 00000000 		subs.w.sx	%s52,0,%s20
 598      9400345A 
 599 0c18 00000000 		or	%s58,0,%s2
 599      82003A45 
 600              	# line 632
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 601              		.loc	1 632 0
 602 0c20 18000000 		dldl.sx	%s61,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 602      81003D0B 
 603 0c28 00000000 		or	%s60,0,%s61
 603      BD003C45 
 604 0c30 00000000 		or	%s60,0,%s60
 604      BC003C45 
 605 0c38 1C000000 		dldl.sx	%s59,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 605      81003B0B 
 606 0c40 00000000 		muls.w.sx	%s61,%s61,%s59
 606      BBBD3D4B 
 607 0c48 00000000 		subs.w.sx	%s56,0,%s61
 607      BD00385A 
 608 0c50 00000000 		or	%s59,0,%s59
 608      BB003B45 
 609 0c58 00000000 		or	%s59,0,%s59
 609      BB003B45 
 610              	# line 631
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ohw = 0; ohw < OH*OW; ++ohw) {
 611              		.loc	1 631 0
 612 0c60 00000000 		muls.l	%s55,%s60,%s59
 612      BBBC376E 
 613 0c68 00000000 		muls.l	%s51,4,%s55
 613      B704336E 
 614              	# line 632
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 615              		.loc	1 632 0
 616 0c70 A8010000 		dld	%s50,424(,%s3)	# *(s$10).data_
 616      83003209 
 617              	# line 626
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 618              		.loc	1 626 0
 619 0c78 00000000 		subs.w.sx	%s54,0,%s18
 619      9200365A 
 620 0c80 00000000 		or	%s18,0,%s61
 620      BD001245 
 621 0c88 00000000 		or	%s57,0,%s54
 621      B6003945 
 622              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 623              		.loc	1 634 0
 624 0c90 14000000 		dldl.sx	%s1,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 624      8100010B 
 625 0c98 00000000 		or	%s1,0,%s1
 625      81000145 
 626 0ca0 00000000 		or	%s1,0,%s1
 626      81000145 
 627              	# line 631
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ohw = 0; ohw < OH*OW; ++ohw) {
 628              		.loc	1 631 0
 629 0ca8 00000000 		muls.l	%s60,%s1,%s60
 629      BC813C6E 
 630 0cb0 00000000 		muls.l	%s60,%s59,%s60
 630      BCBB3C6E 
 631 0cb8 00000000 		muls.l	%s62,4,%s60
 631      BC043E6E 
 632 0cc0 00000000 		muls.l	%s40,4,%s62
 632      BE04286E 
 633 0cc8 00000000 		muls.l	%s1,4,%s1
 633      8104016E 
 634 0cd0 00000000 		muls.l	%s44,%s1,%s55
 634      B7812C6E 
 635 0cd8 00000000 		muls.l	%s41,4,%s44
 635      AC04296E 
 636 0ce0 00000000 		adds.l	%s45,%s50,%s44
 636      ACB22D59 
 637 0ce8 00000000 		muls.l	%s61,8,%s60
 637      BC083D6E 
 638 0cf0 00000000 		adds.l	%s43,%s50,%s61
 638      BDB22B59 
 639 0cf8 00000000 		muls.l	%s60,12,%s60
 639      BC0C3C6E 
 640 0d00 00000000 		adds.l	%s42,%s50,%s60
 640      BCB22A59 
 641 0d08 C0FEFFFF 		br.l	.L2.7
 641      00000F18 
 642              	.L2.0:
 643              	# line 626
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 644              		.loc	1 626 0
 645 0d10 00000000 		or	%s63,0,(0)1
 645      00003F45 
 646 0d18 14000000 		ldl.sx	%s18,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 646      81001203 
 647 0d20 D0FEFFFF 		brlt.w	0,%s18,.L2.27
 647      92008218 
 648 0d28 D8F8FFFF 		br.l	.L2.1
 648      00000F18 
 649              		.cfi_endproc
 650              		.set	.L.3.2auto_size,	0xffffffffffffff00	# 256 Bytes
 652              	# ============ End  _ZZN4conv15refconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_clES
 653              	# ============ Begin  conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 654              		.data
 655              		.balign 16
 658              	.LP._ZN4conv13refconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 659 0000 00000000 		.long	__vla_dealloc_eh
 659      00000000 
 660 0008 0000     		.zero	2
 661 000a FFFF     		.short	65535
 662 000c 04       		.byte	4
 663 000d 000000   		.zero	3
 664 0010 00000000 		.long	__vla_dealloc_eh
 664      00000000 
 665 0018 0100     		.short	1
 666 001a 0000     		.zero	2
 667 001c 04       		.byte	4
 668 001d 000000   		.zero	3
 669 0020 00000000 		.long	__vla_dealloc_eh
 669      00000000 
 670 0028 0200     		.short	2
 671 002a 0100     		.short	1
 672 002c 04       		.byte	4
 673 002d 000000   		.zero	3
 674 0030 00000000 		.long	__vla_dealloc_eh
 674      00000000 
 675 0038 0300     		.short	3
 676 003a 0200     		.short	2
 677 003c 04       		.byte	4
 678 003d 000000   		.zero	3
 679              		.text
 680              		.balign 16
 681              	# line 156
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #define FWD_g_mb_oc_oh_ow \
 682              		.loc	1 156 0
 683              		.globl	conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 685              	conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 686              		.cfi_startproc
 687 0d30 00000000 		st	%fp,0x0(,%sp)
 687      8B000911 
 688              		.cfi_def_cfa_offset	0
 689              		.cfi_offset	9,0
 690 0d38 08000000 		st	%lr,0x8(,%sp)
 690      8B000A11 
 691 0d40 18000000 		st	%got,0x18(,%sp)
 691      8B000F11 
 692 0d48 20000000 		st	%plt,0x20(,%sp)
 692      8B001011 
 693 0d50 00000000 		or	%fp,0,%sp
 693      8B000945 
 694              		.cfi_def_cfa_register	9
 695 0d58 30000000 		st	%s18,48(,%fp)
 695      89001211 
 696 0d60 38000000 		st	%s19,56(,%fp)
 696      89001311 
 697 0d68 40000000 		st	%s20,64(,%fp)
 697      89001411 
 698 0d70 48000000 		st	%s21,72(,%fp)
 698      89001511 
 699 0d78 50000000 		st	%s22,80(,%fp)
 699      89001611 
 700 0d80 58000000 		st	%s23,88(,%fp)
 700      89001711 
 701 0d88 60000000 		st	%s24,96(,%fp)
 701      89001811 
 702 0d90 68000000 		st	%s25,104(,%fp)
 702      89001911 
 703 0d98 70000000 		st	%s26,112(,%fp)
 703      89001A11 
 704 0da0 78000000 		st	%s27,120(,%fp)
 704      89001B11 
 705 0da8 80000000 		st	%s28,128(,%fp)
 705      89001C11 
 706 0db0 88000000 		st	%s29,136(,%fp)
 706      89001D11 
 707 0db8 90000000 		st	%s30,144(,%fp)
 707      89001E11 
 708 0dc0 98000000 		st	%s31,152(,%fp)
 708      89001F11 
 709 0dc8 A0000000 		st	%s32,160(,%fp)
 709      89002011 
 710 0dd0 A8000000 		st	%s33,168(,%fp)
 710      89002111 
 711 0dd8 A0DAFFFF 		lea	%s13,.L.4.2auto_size&0xffffffff
 711      00000D06 
 712 0de0 00000000 		and	%s13,%s13,(32)0
 712      608D0D44 
 713 0de8 FFFFFFFF 		lea.sl	%sp,.L.4.2auto_size>>32(%fp,%s13)
 713      8D898B06 
 714 0df0 48000000 		brge.l.t	%sp,%sl,.L3.EoP
 714      888B3518 
 715 0df8 18000000 		ld	%s61,0x18(,%tp)
 715      8E003D01 
 716 0e00 00000000 		or	%s62,0,%s0
 716      80003E45 
 717 0e08 3B010000 		lea	%s63,0x13b
 717      00003F06 
 718 0e10 00000000 		shm.l	%s63,0x0(%s61)
 718      BD033F31 
 719 0e18 08000000 		shm.l	%sl,0x8(%s61)
 719      BD030831 
 720 0e20 10000000 		shm.l	%sp,0x10(%s61)
 720      BD030B31 
 721 0e28 00000000 		monc
 721      0000003F 
 722 0e30 00000000 		or	%s0,0,%s62
 722      BE000045 
 723              	.L3.EoP:
 724              	# End of prologue codes
 725 0e38 30FEFFFF 		st	%s0,-464(,%fp)	# spill 
 725      89000011 
 726 0e40 00000000 		lea	%s63,__curr_eh_stack_entry@LO
 726      00003F06 
 727 0e48 00000000 		and	%s63,%s63,(32)0
 727      60BF3F44 
 728 0e50 00000000 		lea.sl	%s63,__curr_eh_stack_entry@HI(,%s63)
 728      BF00BF06 
 729 0e58 00000000 		ld	%s62,0(,%s63)
 729      BF003E01 
 730 0e60 40FEFFFF 		st	%s62,-448(,%fp)
 730      89003E11 
 731 0e68 40FEFFFF 		lea	%s62,-448
 731      00003E06 
 732 0e70 00000000 		adds.l	%s62,%fp,%s62
 732      BE893E59 
 733 0e78 00000000 		st	%s62,0(,%s63)
 733      BF003E11 
 734 0e80 00000000 		or	%s63,1,(0)1
 734      00013F45 
 735 0e88 48FEFFFF 		st1b	%s63,-440(,%fp)
 735      89003F15 
 736 0e90 00000000 		lea	%s63,.LP._ZN4conv13refconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 736      00003F06 
 737 0e98 00000000 		and	%s63,%s63,(32)0
 737      60BF3F44 
 738 0ea0 00000000 		lea.sl	%s63,.LP._ZN4conv13refconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s63)
 738      BF00BF06 
 739 0ea8 50FEFFFF 		st	%s63,-432(,%fp)
 739      89003F11 
 740 0eb0 B8FFFFFF 		lea	%s63,-72
 740      00003F06 
 741 0eb8 00000000 		adds.l	%s63,%fp,%s63
 741      BF893F59 
 742 0ec0 58FEFFFF 		st	%s63,-424(,%fp)
 742      89003F11 
 743 0ec8 00000000 		lea	%s23,__eh_curr_region@LO
 743      00001706 
 744 0ed0 00000000 		and	%s23,%s23,(32)0
 744      60971744 
 745 0ed8 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 745      97009706 
 746 0ee0 00000000 		ld2b.zx	%s63,0(,%s23)
 746      9700BF04 
 747 0ee8 68FEFFFF 		st2b	%s63,-408(,%fp)
 747      89003F14 
 748 0ef0 FFFF0000 		lea	%s63,65535
 748      00003F06 
 749 0ef8 00000000 		st2b	%s63,0(,%s23)
 749      97003F14 
 750              	# line 229
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kh = 0; kh < p->kh; ++kh) {
 751              		.loc	1 229 0
 752 0f00 20000000 		ldl.sx	%s63,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 752      80003F03 
 753 0f08 00000000 		or	%s63,0,%s63
 753      BF003F45 
 754 0f10 E8FFFFFF 		lea	%s62,-24
 754      00003E06 
 755 0f18 00000000 		adds.l	%s24,%fp,%s62
 755      BE891859 
 756 0f20 00000000 		muls.l	%s0,4,%s63
 756      BF04006E 
 757 0f28 00000000 		lea	%s12,__grow_stack@LO
 757      00000C06 
 758 0f30 00000000 		and	%s12,%s12,(32)0
 758      608C0C44 
 759 0f38 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 759      8C008C06 
 760 0f40 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 760      8C000A08 
 761 0f48 F8000000 		lea	%s63,248
 761      00003F06 
 762 0f50 00000000 		adds.l	%s63,%sp,%s63
 762      BF8B3F59 
 763 0f58 00000000 		lea	%s62,0
 763      00003E06 
 764 0f60 00000000 		st	%s63,0(,%s24)
 764      98003F11 
 765 0f68 E8FFFFFF 		ld	%s63,-24(,%fp)	# ohb
 765      89003F01 
 766 0f70 30FEFFFF 		ld	%s61,-464(,%fp)	# restore 
 766      89003D01 
 767 0f78 B8FFFFFF 		st	%s63,-72(,%fp)
 767      89003F11 
 768 0f80 00000000 		st2b	%s62,0(,%s23)
 768      97003E14 
 769 0f88 20000000 		ldl.sx	%s61,32(,%s61)	# *(p).__b_N4conv6desc_tE.kh
 769      BD003D03 
 770 0f90 00000000 		or	%s61,0,%s61
 770      BD003D45 
 771 0f98 00000000 		adds.l	%s24,%fp,(59)1
 771      3B891859 
 772 0fa0 00000000 		muls.l	%s0,4,%s61
 772      BD04006E 
 773 0fa8 00000000 		lea	%s12,__grow_stack@LO
 773      00000C06 
 774 0fb0 00000000 		and	%s12,%s12,(32)0
 774      608C0C44 
 775 0fb8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 775      8C008C06 
 776 0fc0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 776      8C000A08 
 777 0fc8 F8000000 		lea	%s63,248
 777      00003F06 
 778 0fd0 00000000 		adds.l	%s63,%sp,%s63
 778      BF8B3F59 
 779 0fd8 30FEFFFF 		ld	%s62,-464(,%fp)	# restore 
 779      89003E01 
 780 0fe0 00000000 		st	%s63,0(,%s24)
 780      98003F11 
 781 0fe8 E0FFFFFF 		ld	%s63,-32(,%fp)	# ohe
 781      89003F01 
 782 0ff0 C0FFFFFF 		lea	%s61,-64
 782      00003D06 
 783 0ff8 00000000 		st	%s63,0(%s61,%fp)
 783      89BD3F11 
 784 1000 00000000 		or	%s61,1,(0)1
 784      00013D45 
 785 1008 00000000 		st2b	%s61,0(,%s23)
 785      97003D14 
 786              	# line 230
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohb[kh] = div_floor(    + PH - kh*(p->dh+1) + SH - 1, SH);//(c-a+b-1)/b
 787              		.loc	1 230 0
 788 1010 20000000 		ldl.sx	%s62,32(,%s62)	# *(p).__b_N4conv6desc_tE.kh
 788      BE003E03 
 789 1018 B8160000 		brlt.w	0,%s62,.L3.0
 789      BE008218 
 790 1020 00000000 		or	%s29,0,%s1
 790      81001D45 
 791 1028 30FEFFFF 		ld	%s1,-464(,%fp)	# restore 
 791      89000101 
 792 1030 00000000 		or	%s28,0,%s2
 792      82001C45 
 793 1038 00000000 		or	%s20,0,%s3
 793      83001445 
 794 1040 00000000 		or	%s21,0,%s4
 794      84001545 
 795 1048 58120000 		br.l	.L3.1
 795      00000F18 
 796              	.L3.2:
 797              	# line 232
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohb[kh] < 0 ) ohb[kh] = 0;
 798              		.loc	1 232 0
 799 1050 80000000 		mins.w.sx	%s61,%s53,%s61
 799      BDB53D78 
 800 1058 F8140000 		br.l	.L3.3
 800      00000F18 
 801              	.L3.4:
 802 1060 00000000 		or	%s61,0,(0)1
 802      00003D45 
 803 1068 28140000 		br.l	.L3.5
 803      00000F18 
 804              	.L3.6:
 805              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owb[kw] < 0 ) owb[kw] = 0;
 806              		.loc	1 239 0
 807 1070 80000000 		mins.w.sx	%s61,%s53,%s61
 807      BDB53D78 
 808 1078 900F0000 		br.l	.L3.7
 808      00000F18 
 809              	.L3.8:
 810 1080 00000000 		or	%s61,0,(0)1
 810      00003D45 
 811 1088 C00E0000 		br.l	.L3.9
 811      00000F18 
 812              	.L3.10:
 813 1090 38FEFFFF 		st	%s60,-456(,%fp)	# spill 
 813      89003C11 
 814 1098 28FEFFFF 		st	%s2,-472(,%fp)	# spill 
 814      89000211 
 815 10a0 00000000 		or	%s19,0,%s62
 815      BE001345 
 816 10a8 00000000 		or	%s63,0,%s33
 816      A1003F45 
 817 10b0 00000000 		or	%s2,0,%s4
 817      84000245 
 818 10b8 00000000 		or	%s3,0,%s5
 818      85000345 
 819 10c0 00000000 		or	%s5,0,%s7
 819      87000545 
 820 10c8 00000000 		or	%s4,0,%s6
 820      86000445 
 821 10d0 480B0000 		br.l	.L3.11
 821      00000F18 
 822              	.L3.12:
 823 10d8 00000000 		or	%s56,0,%s23
 823      97003845 
 824 10e0 00000000 		or	%s50,0,%s24
 824      98003245 
 825 10e8 00000000 		or	%s61,0,%s28
 825      9C003D45 
 826 10f0 00000000 		or	%s45,0,%s25
 826      99002D45 
 827 10f8 00000000 		or	%s43,0,%s26
 827      9A002B45 
 828 1100 00000000 		or	%s63,0,%s21
 828      95003F45 
 829 1108 00000000 		or	%s59,0,%s29
 829      9D003B45 
 830 1110 00000000 		or	%s40,0,%s22
 830      96002845 
 831 1118 00000000 		or	%s42,0,%s27
 831      9B002A45 
 832 1120 C8030000 		br.l	.L3.13
 832      00000F18 
 833              	.L3.14:
 834              	# line 257
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int ih = oh * SH - PH + kh * (p->dh + 1);
 835              		.loc	1 257 0
 836 1128 00000000 		adds.w.sx	%s63,1,%s63
 836      BF013F4A 
 837 1130 00000000 		adds.w.sx	%s59,%s60,%s59
 837      BBBC3B4A 
 838 1138 00000000 		adds.w.sx	%s57,1,%s57
 838      B901394A 
 839 1140 70020000 		brgt.w	0,%s63,.L3.15
 839      BF008118 
 840 1148 90FFFFFF 		br.l	.L3.12
 840      00000F18 
 841              	.L3.16:
 842 1150 00000000 		or	%s63,0,%s5
 842      85003F45 
 843 1158 00000000 		or	%s60,0,%s4
 843      84003C45 
 844 1160 00000000 		or	%s59,0,%s6
 844      86003B45 
 845 1168 00000000 		or	%s57,0,%s7
 845      87003945 
 846 1170 B8FFFFFF 		br.l	.L3.14
 846      00000F18 
 847              	.L3.17:
 848              	# line 259
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 849              		.loc	1 259 0
 850 1178 00000000 		adds.w.sx	%s63,1,%s63
 850      BF013F4A 
 851 1180 00000000 		adds.l	%s60,%s62,%s60
 851      BCBE3C59 
 852 1188 00000000 		adds.w.sx	%s61,1,%s61
 852      BD013D4A 
 853 1190 80010000 		brgt.w	0,%s63,.L3.18
 853      BF008118 
 854 1198 B8FFFFFF 		br.l	.L3.16
 854      00000F18 
 855              	.L3.19:
 856 11a0 00000000 		or	%s63,0,%s1
 856      81003F45 
 857 11a8 00000000 		or	%s62,0,%s2
 857      82003E45 
 858 11b0 00000000 		or	%s61,0,%s3
 858      83003D45 
 859 11b8 C0FFFFFF 		br.l	.L3.17
 859      00000F18 
 860              	.L3.20:
 861              	# line 266
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 862              		.loc	1 266 0
 863 11c0 00000000 		ldu	%s62,0(,%s63)	# *(d)
 863      BF003E02 
 864 11c8 00000000 		ldu	%s57,0(,%s61)	# float
 864      BD003902 
 865 11d0 00000000 		ldu	%s56,0(,%s60)	# float
 865      BC003802 
 866 11d8 00000000 		fmul.s	%s56,%s57,%s56
 866      B8B9B84D 
 867 11e0 00000000 		fadd.s	%s56,%s62,%s56
 867      B8BEB84C 
 868 11e8 00000000 		stu	%s56,0(,%s63)	# *(d)
 868      BF003812 
 869              	# line 261
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 870              		.loc	1 261 0
 871 11f0 00000000 		adds.w.sx	%s59,1,%s59
 871      BB013B4A 
 872 11f8 00000000 		adds.l	%s63,4,%s63
 872      BF043F59 
 873 1200 00000000 		adds.l	%s61,%s58,%s61
 873      BDBA3D59 
 874 1208 B8FFFFFF 		brgt.w	0,%s59,.L3.20
 874      BB008118 
 875 1210 90FFFFFF 		br.l	.L3.19
 875      00000F18 
 876              	.L3.21:
 877              	# line 262
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int iw = ow * SW - PW + kw * (p->dw + 1);
 878              		.loc	1 262 0
 879 1218 00000000 		divs.w.sx	%s57,%s55,%s54
 879      B6B7397B 
 880 1220 00000000 		or	%s1,0,%s63
 880      BF000145 
 881 1228 00000000 		or	%s2,0,%s62
 881      BE000245 
 882 1230 00000000 		or	%s3,0,%s61
 882      BD000345 
 883 1238 00000000 		or	%s57,0,%s57
 883      B9003945 
 884 1240 00000000 		addu.l	%s57,%s57,%s53
 884      B5B93948 
 885 1248 00000000 		addu.l	%s57,%s57,%s52
 885      B4B93948 
 886 1250 00000000 		mulu.l	%s57,%s57,%s51
 886      B3B93949 
 887 1258 00000000 		addu.l	%s57,%s57,%s50
 887      B2B93948 
 888 1260 00000000 		mulu.l	%s57,%s57,%s49
 888      B1B93949 
 889 1268 00000000 		or	%s57,0,%s57
 889      B9003945 
 890              	# line 265
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 891              		.loc	1 265 0
 892 1270 00000000 		divs.w.sx	%s62,%s48,%s54
 892      B6B03E7B 
 893 1278 00000000 		or	%s62,0,%s62
 893      BE003E45 
 894 1280 00000000 		addu.l	%s62,%s62,%s47
 894      AFBE3E48 
 895 1288 00000000 		or	%s56,0,%s61
 895      BD003845 
 896 1290 00000000 		addu.l	%s56,%s62,%s56
 896      B8BE3848 
 897 1298 00000000 		mulu.l	%s56,%s56,%s46
 897      AEB83849 
 898 12a0 00000000 		addu.l	%s56,%s56,%s45
 898      ADB83848 
 899 12a8 00000000 		mulu.l	%s56,%s56,%s44
 899      ACB83849 
 900 12b0 00000000 		or	%s56,0,%s56
 900      B8003845 
 901 12b8 00000000 		or	%s62,0,%s18
 901      92003E45 
 902              	# line 261
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 903              		.loc	1 261 0
 904 12c0 00000000 		adds.w.sx	%s59,%s18,%s43
 904      AB923B4A 
 905 12c8 00000000 		muls.l	%s56,4,%s56
 905      B804386E 
 906 12d0 00000000 		muls.l	%s57,4,%s57
 906      B904396E 
 907 12d8 00000000 		muls.l	%s40,4,%s62
 907      BE04286E 
 908 12e0 00000000 		adds.l	%s56,%s56,%s42
 908      AAB83859 
 909 12e8 00000000 		muls.l	%s62,%s62,%s58
 909      BABE3E6E 
 910 12f0 00000000 		adds.l	%s61,%s56,%s62
 910      BEB83D59 
 911 12f8 00000000 		adds.l	%s57,%s57,%s41
 911      A9B93959 
 912 1300 00000000 		adds.l	%s63,%s57,%s40
 912      A8B93F59 
 913 1308 B8FEFFFF 		br.l	.L3.20
 913      00000F18 
 914              	.L3.18:
 915 1310 08FFFFFF 		brlt.w	%s18,%s19,.L3.21
 915      93928218 
 916 1318 60FEFFFF 		br.l	.L3.17
 916      00000F18 
 917              	.L3.22:
 918              	# line 260
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int ow = owb[kw]; ow < ow_end; ++ow) {
 919              		.loc	1 260 0
 920 1320 00000000 		divu.l	%s56,%s39,%s38
 920      A6A7386F 
 921 1328 00000000 		or	%s4,0,%s60
 921      BC000445 
 922 1330 00000000 		or	%s5,0,%s63
 922      BF000545 
 923 1338 00000000 		or	%s6,0,%s59
 923      BB000645 
 924 1340 00000000 		or	%s7,0,%s57
 924      B9000745 
 925 1348 00000000 		addu.l	%s56,%s56,%s52
 925      B4B83848 
 926 1350 00000000 		mulu.l	%s56,%s56,%s37
 926      A5B83849 
 927 1358 00000000 		divu.l	%s56,%s56,%s38
 927      A6B8386F 
 928 1360 00000000 		or	%s56,0,%s56
 928      B8003845 
 929 1368 00000000 		or	%s50,0,%s57
 929      B9003245 
 930 1370 00000000 		or	%s45,0,%s59
 930      BB002D45 
 931              	# line 259
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 932              		.loc	1 259 0
 933 1378 00000000 		divs.w.sx	%s59,%s36,%s35
 933      A3A43B7B 
 934 1380 00000000 		subs.w.sx	%s59,0,%s59
 934      BB003B5A 
 935 1388 00000000 		or	%s63,0,%s59
 935      BB003F45 
 936 1390 00000000 		muls.l	%s56,%s56,%s62
 936      BEB8386E 
 937 1398 00000000 		adds.l	%s56,%s56,%s34
 937      A2B83859 
 938 13a0 00000000 		or	%s60,0,%s56
 938      B8003C45 
 939 13a8 68FFFFFF 		br.l	.L3.18
 939      00000F18 
 940              	.L3.15:
 941 13b0 00000000 		or	%s61,0,(0)1
 941      00003D45 
 942 13b8 68FFFFFF 		brlt.w	0,%s20,.L3.22
 942      94008218 
 943 13c0 68FDFFFF 		br.l	.L3.14
 943      00000F18 
 944              	.L3.23:
 945 13c8 00000000 		divs.w.sx	%s20,%s36,%s35
 945      A3A4147B 
 946              	# line 261
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 947              		.loc	1 261 0
 948 13d0 00000000 		dldl.sx	%s18,0(%s61,%s59)	# *(owb)
 948      BBBD120B 
 949              	# line 257
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int ih = oh * SH - PH + kh * (p->dh + 1);
 950              		.loc	1 257 0
 951 13d8 00000000 		adds.w.sx	%s7,%s42,%s33
 951      A1AA074A 
 952 13e0 00000000 		muls.w.sx	%s6,%s42,%s60
 952      BCAA064B 
 953 13e8 00000000 		or	%s21,0,%s63
 953      BF001545 
 954 13f0 00000000 		or	%s63,0,%s7
 954      87003F45 
 955 13f8 00000000 		adds.w.sx	%s6,%s6,%s32
 955      A086064A 
 956              	# line 261
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 957              		.loc	1 261 0
 958 1400 00000000 		subs.w.sx	%s7,0,%s19
 958      9300075A 
 959              	# line 259
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 960              		.loc	1 259 0
 961 1408 00000000 		adds.l	%s34,%s61,%s31
 961      9FBD2259 
 962              	# line 261
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 963              		.loc	1 261 0
 964 1410 00000000 		adds.l	%s5,%s43,%s30
 964      9EAB0559 
 965 1418 00000000 		or	%s22,0,%s40
 965      A8001645 
 966 1420 00000000 		or	%s23,0,%s56
 966      B8001745 
 967 1428 00000000 		or	%s24,0,%s50
 967      B2001845 
 968 1430 00000000 		or	%s25,0,%s45
 968      AD001945 
 969 1438 00000000 		or	%s26,0,%s43
 969      AB001A45 
 970 1440 00000000 		or	%s43,0,%s7
 970      87002B45 
 971 1448 00000000 		or	%s27,0,%s42
 971      AA001B45 
 972 1450 00000000 		or	%s42,0,%s5
 972      85002A45 
 973 1458 00000000 		or	%s28,0,%s61
 973      BD001C45 
 974 1460 00000000 		or	%s29,0,%s59
 974      BB001D45 
 975 1468 00000000 		or	%s59,0,%s6
 975      86003B45 
 976 1470 40FFFFFF 		br.l	.L3.15
 976      00000F18 
 977              	.L3.24:
 978 1478 00000000 		or	%s57,0,%s42
 978      AA003945 
 979 1480 48FFFFFF 		brlt.w	%s42,%s40,.L3.23
 979      A8AA8218 
 980 1488 60000000 		br.l	.L3.13
 980      00000F18 
 981              	.L3.25:
 982 1490 C8FDFFFF 		ld	%s40,-568(,%fp)	# restore 
 982      89002801 
 983 1498 C0FDFFFF 		ld	%s43,-576(,%fp)	# restore 
 983      89002B01 
 984 14a0 D8FDFFFF 		ld	%s34,-552(,%fp)	# restore 
 984      89002201 
 985 14a8 D0FDFFFF 		ld	%s61,-560(,%fp)	# restore 
 985      89003D01 
 986 14b0 E8FDFFFF 		ld	%s50,-536(,%fp)	# restore 
 986      89003201 
 987 14b8 B8FDFFFF 		ld	%s42,-584(,%fp)	# restore 
 987      89002A01 
 988 14c0 E0FDFFFF 		ld	%s33,-544(,%fp)	# restore 
 988      89002101 
 989 14c8 A0FDFFFF 		ld	%s5,-608(,%fp)	# restore 
 989      89000501 
 990 14d0 B0FDFFFF 		ld	%s7,-592(,%fp)	# restore 
 990      89000701 
 991 14d8 A8FDFFFF 		ld	%s6,-600(,%fp)	# restore 
 991      89000601 
 992 14e0 70040000 		br.l	.L3.26
 992      00000F18 
 993              	.L3.13:
 994 14e8 00000000 		or	%s57,3,(0)1
 994      00033945 
 995 14f0 00000000 		st2b	%s57,0(,%s56)
 995      B8003914 
 996              	# line 254
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int ow_end = owe[kw];
 997              		.loc	1 254 0
 998 14f8 00000000 		adds.w.sx	%s50,1,%s50
 998      B201324A 
 999 1500 00000000 		adds.l	%s61,4,%s61
 999      BD043D59 
 1000 1508 00000000 		adds.l	%s43,%s45,%s43
 1000      ABAD2B59 
 1001 1510 10000000 		brgt.w	0,%s50,.L3.27
 1001      B2008118 
 1002 1518 78FFFFFF 		br.l	.L3.25
 1002      00000F18 
 1003              	.L3.27:
 1004              	# line 255
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if( owb[kw] >= ow_end ) continue;
 1005              		.loc	1 255 0
 1006 1520 00000000 		ldl.sx	%s19,0(%s61,%s63)	# *(owe)
 1006      BFBD1303 
 1007              	# line 256
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = ohb[kh]; oh < oh_end; ++oh) {
 1008              		.loc	1 256 0
 1009 1528 00000000 		ldl.sx	%s18,0(%s61,%s59)	# *(owb)
 1009      BBBD1203 
 1010 1530 B8FFFFFF 		brge.w	%s18,%s19,.L3.13
 1010      93928518 
 1011 1538 40FFFFFF 		br.l	.L3.24
 1011      00000F18 
 1012              	.L3.28:
 1013 1540 E8FDFFFF 		st	%s50,-536(,%fp)	# spill 
 1013      89003211 
 1014 1548 E0FDFFFF 		st	%s33,-544(,%fp)	# spill 
 1014      89002111 
 1015 1550 D8FDFFFF 		st	%s34,-552(,%fp)	# spill 
 1015      89002211 
 1016 1558 D0FDFFFF 		st	%s61,-560(,%fp)	# spill 
 1016      89003D11 
 1017 1560 C8FDFFFF 		st	%s1,-568(,%fp)	# spill 
 1017      89000111 
 1018 1568 C0FDFFFF 		st	%s43,-576(,%fp)	# spill 
 1018      89002B11 
 1019 1570 B8FDFFFF 		st	%s42,-584(,%fp)	# spill 
 1019      89002A11 
 1020 1578 B0FDFFFF 		st	%s7,-592(,%fp)	# spill 
 1020      89000711 
 1021 1580 A8FDFFFF 		st	%s6,-600(,%fp)	# spill 
 1021      89000611 
 1022 1588 A0FDFFFF 		st	%s5,-608(,%fp)	# spill 
 1022      89000511 
 1023              	# line 257
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int ih = oh * SH - PH + kh * (p->dh + 1);
 1024              		.loc	1 257 0
 1025 1590 00000000 		dldl.sx	%s42,0(%s43,%s42)	# *(ohb)
 1025      AAAB2A0B 
 1026 1598 00000000 		or	%s50,0,%s7
 1026      87003245 
 1027              	# line 254
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int ow_end = owe[kw];
 1028              		.loc	1 254 0
 1029 15a0 00000000 		or	%s61,0,(0)1
 1029      00003D45 
 1030 15a8 00000000 		or	%s43,0,(0)1
 1030      00002B45 
 1031              	# line 257
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int ih = oh * SH - PH + kh * (p->dh + 1);
 1032              		.loc	1 257 0
 1033 15b0 00000000 		subs.w.sx	%s33,0,%s40
 1033      A800215A 
 1034              	# line 259
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1035              		.loc	1 259 0
 1036 15b8 00000000 		muls.l	%s6,%s57,%s6
 1036      86B9066E 
 1037 15c0 00000000 		adds.l	%s31,%s6,%s5
 1037      85861F59 
 1038 15c8 58FFFFFF 		br.l	.L3.27
 1038      00000F18 
 1039              	.L3.29:
 1040 15d0 70FFFFFF 		brlt.w	0,%s33,.L3.28
 1040      A1008218 
 1041 15d8 00000000 		or	%s40,0,%s1
 1041      81002845 
 1042 15e0 70030000 		br.l	.L3.26
 1042      00000F18 
 1043              	.L3.30:
 1044 15e8 00000000 		or	%s7,0,%s5
 1044      85000745 
 1045 15f0 00000000 		or	%s62,0,%s19
 1045      93003E45 
 1046 15f8 38FEFFFF 		ld	%s60,-456(,%fp)	# restore 
 1046      89003C01 
 1047 1600 00000000 		or	%s33,0,%s63
 1047      BF002145 
 1048 1608 00000000 		or	%s5,0,%s3
 1048      83000545 
 1049 1610 00000000 		or	%s6,0,%s4
 1049      84000645 
 1050 1618 00000000 		or	%s4,0,%s2
 1050      82000445 
 1051 1620 28FEFFFF 		ld	%s2,-472(,%fp)	# restore 
 1051      89000201 
 1052 1628 48010000 		br.l	.L3.31
 1052      00000F18 
 1053              	.L3.32:
 1054 1630 00000000 		lea	%s63,__eh_curr_region@LO
 1054      00003F06 
 1055 1638 00000000 		and	%s63,%s63,(32)0
 1055      60BF3F44 
 1056 1640 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 1056      BF00BF06 
 1057 1648 68FEFFFF 		ld2b.zx	%s62,-408(,%fp)
 1057      8900BE04 
 1058 1650 00000000 		st2b	%s62,0(,%s63)
 1058      BF003E14 
 1059 1658 40FEFFFF 		ld	%s63,-448(,%fp)
 1059      89003F01 
 1060 1660 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 1060      00003E06 
 1061 1668 00000000 		and	%s62,%s62,(32)0
 1061      60BE3E44 
 1062 1670 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 1062      BE00BE06 
 1063 1678 00000000 		st	%s63,0(,%s62)
 1063      BE003F11 
 1064              	# Start of epilogue codes
 1065 1680 30000000 		ld	%s18,48(,%fp)
 1065      89001201 
 1066 1688 38000000 		ld	%s19,56(,%fp)
 1066      89001301 
 1067 1690 40000000 		ld	%s20,64(,%fp)
 1067      89001401 
 1068 1698 48000000 		ld	%s21,72(,%fp)
 1068      89001501 
 1069 16a0 50000000 		ld	%s22,80(,%fp)
 1069      89001601 
 1070 16a8 58000000 		ld	%s23,88(,%fp)
 1070      89001701 
 1071 16b0 60000000 		ld	%s24,96(,%fp)
 1071      89001801 
 1072 16b8 68000000 		ld	%s25,104(,%fp)
 1072      89001901 
 1073 16c0 70000000 		ld	%s26,112(,%fp)
 1073      89001A01 
 1074 16c8 78000000 		ld	%s27,120(,%fp)
 1074      89001B01 
 1075 16d0 80000000 		ld	%s28,128(,%fp)
 1075      89001C01 
 1076 16d8 88000000 		ld	%s29,136(,%fp)
 1076      89001D01 
 1077 16e0 90000000 		ld	%s30,144(,%fp)
 1077      89001E01 
 1078 16e8 98000000 		ld	%s31,152(,%fp)
 1078      89001F01 
 1079 16f0 A0000000 		ld	%s32,160(,%fp)
 1079      89002001 
 1080 16f8 A8000000 		ld	%s33,168(,%fp)
 1080      89002101 
 1081 1700 00000000 		or	%sp,0,%fp
 1081      89000B45 
 1082              		.cfi_def_cfa	11,8
 1083 1708 18000000 		ld	%got,0x18(,%sp)
 1083      8B000F01 
 1084 1710 20000000 		ld	%plt,0x20(,%sp)
 1084      8B001001 
 1085 1718 08000000 		ld	%lr,0x8(,%sp)
 1085      8B000A01 
 1086 1720 00000000 		ld	%fp,0x0(,%sp)
 1086      8B000901 
 1087 1728 00000000 		b.l	(,%lr)
 1087      8A000F19 
 1088              	.L3.33:
 1089              	# line 244
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1090              		.loc	1 244 0
 1091 1730 00000000 		ldl.sx	%s18,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1091      81001203 
 1092 1738 00000000 		adds.w.sx	%s6,1,%s6
 1092      8601064A 
 1093 1740 E0060000 		brlt.w	%s6,%s18,.L3.34
 1093      92868218 
 1094 1748 E8FEFFFF 		br.l	.L3.32
 1094      00000F18 
 1095              	.L3.35:
 1096              	# line 245
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 1097              		.loc	1 245 0
 1098 1750 04000000 		ldl.sx	%s18,4(,%s1)	# *(p).__b_N4conv6desc_tE.mb
 1098      81001203 
 1099 1758 00000000 		adds.w.sx	%s5,1,%s5
 1099      8501054A 
 1100 1760 80060000 		brlt.w	%s5,%s18,.L3.36
 1100      92858218 
 1101 1768 C8FFFFFF 		br.l	.L3.33
 1101      00000F18 
 1102              	.L3.31:
 1103              	# line 246
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t bia_off = bia_off_f(p, g, oc);
 1104              		.loc	1 246 0
 1105 1770 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1105      81003F03 
 1106 1778 00000000 		ldl.sx	%s61,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1106      81003D03 
 1107 1780 00000000 		divs.w.sx	%s61,%s63,%s61
 1107      BDBF3D7B 
 1108 1788 00000000 		adds.w.sx	%s7,1,%s7
 1108      8701074A 
 1109 1790 E0050000 		brlt.w	%s7,%s61,.L3.37
 1109      BD878218 
 1110 1798 B8FFFFFF 		br.l	.L3.35
 1110      00000F18 
 1111              	.L3.38:
 1112 17a0 30FEFFFF 		ld	%s1,-464(,%fp)	# restore 
 1112      89000101 
 1113 17a8 00000000 		or	%s62,0,%s19
 1113      93003E45 
 1114 17b0 00FEFFFF 		ld	%s7,-512(,%fp)	# restore 
 1114      89000701 
 1115 17b8 38FEFFFF 		ld	%s60,-456(,%fp)	# restore 
 1115      89003C01 
 1116 17c0 F8FDFFFF 		ld	%s33,-520(,%fp)	# restore 
 1116      89002101 
 1117 17c8 28FEFFFF 		ld	%s2,-472(,%fp)	# restore 
 1117      89000201 
 1118 17d0 18FEFFFF 		ld	%s4,-488(,%fp)	# restore 
 1118      89000401 
 1119 17d8 10FEFFFF 		ld	%s5,-496(,%fp)	# restore 
 1119      89000501 
 1120 17e0 08FEFFFF 		ld	%s6,-504(,%fp)	# restore 
 1120      89000601 
 1121 17e8 88FFFFFF 		br.l	.L3.31
 1121      00000F18 
 1122              	.L3.39:
 1123 17f0 F8FDFFFF 		ld	%s0,-520(,%fp)	# restore 
 1123      89000001 
 1124 17f8 30FEFFFF 		ld	%s1,-464(,%fp)	# restore 
 1124      89000101 
 1125 1800 18FEFFFF 		ld	%s2,-488(,%fp)	# restore 
 1125      89000201 
 1126 1808 10FEFFFF 		ld	%s3,-496(,%fp)	# restore 
 1126      89000301 
 1127 1810 08FEFFFF 		ld	%s4,-504(,%fp)	# restore 
 1127      89000401 
 1128 1818 00FEFFFF 		ld	%s5,-512(,%fp)	# restore 
 1128      89000501 
 1129              	.L3.40:
 1130 1820 F8FDFFFF 		st	%s0,-520(,%fp)	# spill 
 1130      89000011 
 1131 1828 30FEFFFF 		st	%s1,-464(,%fp)	# spill 
 1131      89000111 
 1132 1830 18FEFFFF 		st	%s2,-488(,%fp)	# spill 
 1132      89000211 
 1133 1838 10FEFFFF 		st	%s3,-496(,%fp)	# spill 
 1133      89000311 
 1134 1840 08FEFFFF 		st	%s4,-504(,%fp)	# spill 
 1134      89000411 
 1135 1848 00FEFFFF 		st	%s5,-512(,%fp)	# spill 
 1135      89000511 
 1136 1850 F0FDFFFF 		st	%s6,-528(,%fp)	# spill 
 1136      89000611 
 1137              	# line 273
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 1138              		.loc	1 273 0
 1139 1858 00000000 		lea	%s12,conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, int, int, int)#1}::operator()(conv::prb_t const*, dnn_mem_t const&, int, int, int, int) const
 1139      00000C06 
 1140 1860 00000000 		and	%s12,%s12,(32)0
 1140      608C0C44 
 1141 1868 00000000 		lea.sl	%s12,conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, int, int, int)#1}::operator()(conv::prb_t const*, dnn_mem_t const&, int) const
 1141      8C008C06 
 1142 1870 00000000 		bsic	%lr,(,%s12)	# conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, int, int, int)#1}::operator() const
 1142      8C000A08 
 1143              	# line 272
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           bias_relu(p, dst_m, mb, g, oc, oh);
 1144              		.loc	1 272 0
 1145 1878 00000000 		adds.w.sx	%s23,1,%s23
 1145      9701174A 
 1146 1880 F0FDFFFF 		ld	%s6,-528(,%fp)	# restore 
 1146      89000601 
 1147 1888 00000000 		adds.w.sx	%s6,1,%s6
 1147      8601064A 
 1148 1890 60FFFFFF 		brgt.w	0,%s23,.L3.39
 1148      97008118 
 1149 1898 08FFFFFF 		br.l	.L3.38
 1149      00000F18 
 1150              	.L3.41:
 1151 18a0 00000000 		subs.w.sx	%s18,0,%s18
 1151      9200125A 
 1152 18a8 00000000 		or	%s23,0,%s18
 1152      92001745 
 1153 18b0 00000000 		or	%s0,0,%s63
 1153      BF000045 
 1154 18b8 68FFFFFF 		br.l	.L3.40
 1154      00000F18 
 1155              	.L3.42:
 1156 18c0 00000000 		or	%s6,0,(0)1
 1156      00000645 
 1157 18c8 18000000 		ldl.sx	%s18,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1157      81001203 
 1158 18d0 D0FFFFFF 		brlt.w	0,%s18,.L3.41
 1158      92008218 
 1159 18d8 10FDFFFF 		br.l	.L3.30
 1159      00000F18 
 1160              	.L3.43:
 1161 18e0 30FEFFFF 		ld	%s1,-464(,%fp)	# restore 
 1161      89000101 
 1162 18e8 00000000 		or	%s26,0,%s56
 1162      B8001A45 
 1163 18f0 98FDFFFF 		ld	%s19,-616(,%fp)	# restore 
 1163      89001301 
 1164 18f8 90FDFFFF 		ld	%s31,-624(,%fp)	# restore 
 1164      89001F01 
 1165 1900 F8FDFFFF 		ld	%s63,-520(,%fp)	# restore 
 1165      89003F01 
 1166 1908 88FDFFFF 		ld	%s29,-632(,%fp)	# restore 
 1166      89001D01 
 1167 1910 80FDFFFF 		ld	%s28,-640(,%fp)	# restore 
 1167      89001C01 
 1168 1918 18FEFFFF 		ld	%s2,-488(,%fp)	# restore 
 1168      89000201 
 1169 1920 00FEFFFF 		ld	%s5,-512(,%fp)	# restore 
 1169      89000501 
 1170 1928 10FEFFFF 		ld	%s3,-496(,%fp)	# restore 
 1170      89000301 
 1171 1930 08FEFFFF 		ld	%s4,-504(,%fp)	# restore 
 1171      89000401 
 1172 1938 88FFFFFF 		br.l	.L3.42
 1172      00000F18 
 1173              	.L3.44:
 1174 1940 00000000 		or	%s1,0,%s40
 1174      A8000145 
 1175 1948 58000000 		br.l	.L3.45
 1175      00000F18 
 1176              	.L3.26:
 1177 1950 00000000 		or	%s57,3,(0)1
 1177      00033945 
 1178 1958 00000000 		st2b	%s57,0(,%s56)
 1178      B8003914 
 1179              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_end = ohe[kh];
 1180              		.loc	1 251 0
 1181 1960 00000000 		adds.w.sx	%s40,1,%s40
 1181      A801284A 
 1182 1968 00000000 		adds.l	%s43,4,%s43
 1182      AB042B59 
 1183 1970 00000000 		adds.w.sx	%s32,%s34,%s32
 1183      A0A2204A 
 1184 1978 00000000 		adds.w.sx	%s61,1,%s61
 1184      BD013D4A 
 1185 1980 C0FFFFFF 		brgt.w	0,%s40,.L3.44
 1185      A8008118 
 1186 1988 58FFFFFF 		br.l	.L3.43
 1186      00000F18 
 1187              	.L3.46:
 1188 1990 00000000 		or	%s40,0,%s1
 1188      81002845 
 1189 1998 B8FFFFFF 		br.l	.L3.26
 1189      00000F18 
 1190              	.L3.45:
 1191 19a0 00000000 		or	%s57,0,%s61
 1191      BD003945 
 1192              	# line 252
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( ohb[kh] >= oh_end ) continue;
 1193              		.loc	1 252 0
 1194 19a8 00000000 		ldl.sx	%s40,0(%s43,%s50)	# *(ohe)
 1194      B2AB2803 
 1195              	# line 253
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 1196              		.loc	1 253 0
 1197 19b0 00000000 		ldl.sx	%s18,0(%s43,%s42)	# *(ohb)
 1197      AAAB1203 
 1198 19b8 D8FFFFFF 		brge.w	%s18,%s40,.L3.46
 1198      A8928518 
 1199 19c0 10FCFFFF 		br.l	.L3.29
 1199      00000F18 
 1200              	.L3.47:
 1201 19c8 F8FDFFFF 		st	%s63,-520(,%fp)	# spill 
 1201      89003F11 
 1202 19d0 10FEFFFF 		st	%s3,-496(,%fp)	# spill 
 1202      89000311 
 1203 19d8 18FEFFFF 		st	%s2,-488(,%fp)	# spill 
 1203      89000211 
 1204 19e0 08FEFFFF 		st	%s4,-504(,%fp)	# spill 
 1204      89000411 
 1205 19e8 00FEFFFF 		st	%s5,-512(,%fp)	# spill 
 1205      89000511 
 1206 19f0 98FDFFFF 		st	%s19,-616(,%fp)	# spill 
 1206      89001311 
 1207 19f8 30FEFFFF 		st	%s1,-464(,%fp)	# spill 
 1207      89000111 
 1208 1a00 90FDFFFF 		st	%s31,-624(,%fp)	# spill 
 1208      89001F11 
 1209 1a08 88FDFFFF 		st	%s29,-632(,%fp)	# spill 
 1209      89001D11 
 1210 1a10 80FDFFFF 		st	%s28,-640(,%fp)	# spill 
 1210      89001C11 
 1211              	# line 252
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( ohb[kh] >= oh_end ) continue;
 1212              		.loc	1 252 0
 1213 1a18 E0FFFFFF 		dld	%s50,-32(,%fp)	# ohe
 1213      89003209 
 1214              	# line 253
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 1215              		.loc	1 253 0
 1216 1a20 E8FFFFFF 		dld	%s42,-24(,%fp)	# ohb
 1216      89002A09 
 1217              	# line 254
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int ow_end = owe[kw];
 1218              		.loc	1 254 0
 1219 1a28 24000000 		dldl.sx	%s33,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 1219      8100210B 
 1220 1a30 00000000 		or	%s57,0,%s33
 1220      A1003945 
 1221 1a38 00000000 		or	%s57,0,%s57
 1221      B9003945 
 1222 1a40 00000000 		subs.w.sx	%s7,0,%s33
 1222      A100075A 
 1223              	# line 255
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if( owb[kw] >= ow_end ) continue;
 1224              		.loc	1 255 0
 1225 1a48 F0FFFFFF 		dld	%s63,-16(,%fp)	# owe
 1225      89003F09 
 1226              	# line 256
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = ohb[kh]; oh < oh_end; ++oh) {
 1227              		.loc	1 256 0
 1228 1a50 D8FFFFFF 		dld	%s59,-40(,%fp)	# owb
 1228      89003B09 
 1229              	# line 258
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ic = 0; ic < IC/G; ++ic) { // <--- !!!
 1230              		.loc	1 258 0
 1231 1a58 28000000 		dldl.sx	%s60,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 1231      81003C0B 
 1232 1a60 30000000 		dldl.sx	%s40,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 1232      8100280B 
 1233              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_end = ohe[kh];
 1234              		.loc	1 251 0
 1235 1a68 00000000 		subs.w.sx	%s40,0,%s40
 1235      A800285A 
 1236 1a70 00000000 		or	%s32,0,%s40
 1236      A8002045 
 1237              	# line 258
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ic = 0; ic < IC/G; ++ic) { // <--- !!!
 1238              		.loc	1 258 0
 1239 1a78 38000000 		dldl.sx	%s40,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 1239      8100280B 
 1240 1a80 00000000 		adds.w.sx	%s34,1,%s40
 1240      A801224A 
 1241              	# line 259
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1242              		.loc	1 259 0
 1243 1a88 08000000 		dldl.sx	%s36,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 1243      8100240B 
 1244 1a90 00000000 		or	%s37,0,%s36
 1244      A4002545 
 1245 1a98 00000000 		dldl.sx	%s35,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1245      8100230B 
 1246 1aa0 00000000 		or	%s38,0,%s35
 1246      A3002645 
 1247              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_end = ohe[kh];
 1248              		.loc	1 251 0
 1249 1aa8 00000000 		or	%s43,0,(0)1
 1249      00002B45 
 1250              	# line 260
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int ow = owb[kw]; ow < ow_end; ++ow) {
 1251              		.loc	1 260 0
 1252 1ab0 14000000 		dldl.sx	%s40,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1252      8100280B 
 1253 1ab8 00000000 		or	%s40,0,%s40
 1253      A8002845 
 1254 1ac0 00000000 		mulu.l	%s39,%s40,%s19
 1254      93A82749 
 1255 1ac8 00000000 		or	%s52,0,%s5
 1255      85003445 
 1256 1ad0 00000000 		or	%s40,0,%s18
 1256      92002845 
 1257 1ad8 00000000 		or	%s40,0,%s40
 1257      A8002845 
 1258              	# line 259
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1259              		.loc	1 259 0
 1260 1ae0 00000000 		muls.l	%s40,%s40,%s57
 1260      B9A8286E 
 1261              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_end = ohe[kh];
 1262              		.loc	1 251 0
 1263 1ae8 00000000 		subs.w.sx	%s18,0,%s18
 1263      9200125A 
 1264 1af0 00000000 		or	%s1,0,%s18
 1264      92000145 
 1265 1af8 30FEFFFF 		ld	%s3,-464(,%fp)	# restore 
 1265      89000301 
 1266              	# line 262
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int iw = ow * SW - PW + kw * (p->dw + 1);
 1267              		.loc	1 262 0
 1268 1b00 14000000 		dldl.sx	%s0,20(,%s3)	# *(p).__b_N4conv6desc_tE.oc
 1268      8300000B 
 1269 1b08 00000000 		or	%s27,0,%s0
 1269      80001B45 
 1270              	# line 259
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1271              		.loc	1 259 0
 1272 1b10 00000000 		muls.l	%s62,4,%s40
 1272      A8043E6E 
 1273 1b18 00000000 		muls.l	%s6,4,%s57
 1273      B904066E 
 1274              	# line 262
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int iw = ow * SW - PW + kw * (p->dw + 1);
 1275              		.loc	1 262 0
 1276 1b20 00000000 		mulu.l	%s53,%s27,%s31
 1276      9F9B3549 
 1277 1b28 00000000 		muls.w.sx	%s55,%s0,%s4
 1277      8480374B 
 1278 1b30 00000000 		dldl.sx	%s54,0(,%s3)	# *(p).__b_N4conv6desc_tE.g
 1278      8300360B 
 1279 1b38 18000000 		dldl.sx	%s57,24(,%s3)	# *(p).__b_N4conv6desc_tE.oh
 1279      8300390B 
 1280 1b40 00000000 		or	%s51,0,%s57
 1280      B9003345 
 1281 1b48 1C000000 		dldl.sx	%s57,28(,%s3)	# *(p).__b_N4conv6desc_tE.ow
 1281      8300390B 
 1282 1b50 00000000 		or	%s49,0,%s57
 1282      B9003145 
 1283              	# line 263
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   float &d = ((float*)dst_m)[dst_off];
 1284              		.loc	1 263 0
 1285 1b58 2C000000 		dldl.sx	%s57,44(,%s3)	# *(p).__b_N4conv6desc_tE.sw
 1285      8300390B 
 1286 1b60 00000000 		or	%s57,0,%s57
 1286      B9003945 
 1287              	# line 261
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 1288              		.loc	1 261 0
 1289 1b68 00000000 		muls.l	%s58,4,%s57
 1289      B9043A6E 
 1290              	# line 263
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   float &d = ((float*)dst_m)[dst_off];
 1291              		.loc	1 263 0
 1292 1b70 34000000 		dldl.sx	%s57,52(,%s3)	# *(p).__b_N4conv6desc_tE.pw
 1292      8300390B 
 1293 1b78 00000000 		or	%s57,0,%s57
 1293      B9003945 
 1294 1b80 3C000000 		dldl.sx	%s40,60(,%s3)	# *(p).__b_N4conv6desc_tE.dw
 1294      8300280B 
 1295 1b88 00000000 		adds.w.sx	%s40,1,%s40
 1295      A801284A 
 1296 1b90 00000000 		or	%s40,0,%s40
 1296      A8002845 
 1297              	# line 254
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             const int ow_end = owe[kw];
 1298              		.loc	1 254 0
 1299 1b98 00000000 		muls.l	%s45,4,%s40
 1299      A8042D6E 
 1300              	# line 264
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 1301              		.loc	1 264 0
 1302 1ba0 A8010000 		dld	%s41,424(,%s2)	# *(dst_m).data_
 1302      82002909 
 1303              	# line 265
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 1304              		.loc	1 265 0
 1305 1ba8 08000000 		dldl.sx	%s40,8(,%s3)	# *(p).__b_N4conv6desc_tE.ic
 1305      8300280B 
 1306 1bb0 00000000 		or	%s2,0,%s40
 1306      A8000245 
 1307 1bb8 00000000 		mulu.l	%s47,%s31,%s2
 1307      829F2F49 
 1308 1bc0 00000000 		muls.w.sx	%s48,%s4,%s40
 1308      A884304B 
 1309 1bc8 0C000000 		dldl.sx	%s40,12(,%s3)	# *(p).__b_N4conv6desc_tE.ih
 1309      8300280B 
 1310 1bd0 00000000 		or	%s46,0,%s40
 1310      A8002E45 
 1311 1bd8 10000000 		dldl.sx	%s3,16(,%s3)	# *(p).__b_N4conv6desc_tE.iw
 1311      8300030B 
 1312 1be0 00000000 		or	%s44,0,%s3
 1312      83002C45 
 1313              	# line 266
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 1314              		.loc	1 266 0
 1315 1be8 A8010000 		dld	%s29,424(,%s29)	# *(src_m).data_
 1315      9D001D09 
 1316 1bf0 A8010000 		dld	%s5,424(,%s28)	# *(wei_m).data_
 1316      9C000509 
 1317              	# line 261
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow); // WRITTEN
 1318              		.loc	1 261 0
 1319 1bf8 00000000 		muls.l	%s57,-4,%s57
 1319      B97C396E 
 1320 1c00 00000000 		adds.l	%s30,%s29,%s57
 1320      B99D1E59 
 1321 1c08 00000000 		or	%s56,0,%s26
 1321      9A003845 
 1322 1c10 90FDFFFF 		br.l	.L3.45
 1322      00000F18 
 1323              	.L3.11:
 1324              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const int oh_end = ohe[kh];
 1325              		.loc	1 251 0
 1326 1c18 00000000 		or	%s61,0,(0)1
 1326      00003D45 
 1327 1c20 20000000 		ldl.sx	%s18,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 1327      81001203 
 1328 1c28 A0FDFFFF 		brlt.w	0,%s18,.L3.47
 1328      92008218 
 1329 1c30 90FCFFFF 		br.l	.L3.42
 1329      00000F18 
 1330              	.L3.48:
 1331 1c38 30FEFFFF 		ld	%s1,-464(,%fp)	# restore 
 1331      89000101 
 1332 1c40 00000000 		or	%s19,0,%s18
 1332      92001345 
 1333 1c48 18FEFFFF 		ld	%s2,-488(,%fp)	# restore 
 1333      89000201 
 1334 1c50 00FEFFFF 		ld	%s5,-512(,%fp)	# restore 
 1334      89000501 
 1335 1c58 10FEFFFF 		ld	%s3,-496(,%fp)	# restore 
 1335      89000301 
 1336 1c60 08FEFFFF 		ld	%s4,-504(,%fp)	# restore 
 1336      89000401 
 1337 1c68 00000000 		or	%s63,0,%s33
 1337      A1003F45 
 1338 1c70 A8FFFFFF 		br.l	.L3.11
 1338      00000F18 
 1339              	.L3.49:
 1340 1c78 38FEFFFF 		ld	%s0,-456(,%fp)	# restore 
 1340      89000001 
 1341 1c80 30FEFFFF 		ld	%s1,-464(,%fp)	# restore 
 1341      89000101 
 1342 1c88 28FEFFFF 		ld	%s2,-472(,%fp)	# restore 
 1342      89000201 
 1343 1c90 20FEFFFF 		ld	%s3,-480(,%fp)	# restore 
 1343      89000301 
 1344 1c98 18FEFFFF 		ld	%s4,-488(,%fp)	# restore 
 1344      89000401 
 1345 1ca0 10FEFFFF 		ld	%s5,-496(,%fp)	# restore 
 1345      89000501 
 1346 1ca8 08FEFFFF 		ld	%s6,-504(,%fp)	# restore 
 1346      89000601 
 1347 1cb0 00FEFFFF 		ld	%s7,-512(,%fp)	# restore 
 1347      89000701 
 1348              	.L3.50:
 1349              	# line 249
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 1350              		.loc	1 249 0
 1351 1cb8 F0000000 		st	%s23,240(,%sp)
 1351      8B001711 
 1352 1cc0 38FEFFFF 		st	%s0,-456(,%fp)	# spill 
 1352      89000011 
 1353 1cc8 30FEFFFF 		st	%s1,-464(,%fp)	# spill 
 1353      89000111 
 1354 1cd0 28FEFFFF 		st	%s2,-472(,%fp)	# spill 
 1354      89000211 
 1355 1cd8 20FEFFFF 		st	%s3,-480(,%fp)	# spill 
 1355      89000311 
 1356 1ce0 18FEFFFF 		st	%s4,-488(,%fp)	# spill 
 1356      89000411 
 1357 1ce8 10FEFFFF 		st	%s5,-496(,%fp)	# spill 
 1357      89000511 
 1358 1cf0 08FEFFFF 		st	%s6,-504(,%fp)	# spill 
 1358      89000611 
 1359 1cf8 00FEFFFF 		st	%s7,-512(,%fp)	# spill 
 1359      89000711 
 1360 1d00 00000000 		lea	%s12,conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, dnn_mem_t const&, int, int, int, int)#1}::operator()(conv::prb_t const*, dnn_mem_t const&) const
 1360      00000C06 
 1361 1d08 00000000 		and	%s12,%s12,(32)0
 1361      608C0C44 
 1362 1d10 00000000 		lea.sl	%s12,conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t const&, int, dnn_mem_t const&, int, int, int, int)#1}::operator()(conv::prb_t const*) const
 1362      8C008C06 
 1363 1d18 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv13refconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_RKS3_iS6_iiiiE
 1363      8C000A08 
 1364              	# line 248
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
 1365              		.loc	1 248 0
 1366 1d20 00000000 		adds.w.sx	%s24,1,%s24
 1366      9801184A 
 1367 1d28 00000000 		adds.w.sx	%s23,1,%s23
 1367      9701174A 
 1368 1d30 48FFFFFF 		brgt.w	0,%s24,.L3.49
 1368      98008118 
 1369 1d38 00FFFFFF 		br.l	.L3.48
 1369      00000F18 
 1370              	.L3.51:
 1371              	# line 249
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 1372              		.loc	1 249 0
 1373 1d40 00000000 		adds.w.sx	%s3,0,%s63
 1373      BF00034A 
 1374              	# line 248
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
 1375              		.loc	1 248 0
 1376 1d48 00000000 		subs.w.sx	%s63,0,%s18
 1376      92003F5A 
 1377 1d50 00000000 		or	%s18,0,%s62
 1377      BE001245 
 1378 1d58 00000000 		or	%s24,0,%s63
 1378      BF001845 
 1379 1d60 00000000 		or	%s0,0,%s60
 1379      BC000045 
 1380 1d68 50FFFFFF 		br.l	.L3.50
 1380      00000F18 
 1381              	.L3.37:
 1382              	# line 247
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 1383              		.loc	1 247 0
 1384 1d70 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1384      81003F03 
 1385 1d78 00000000 		or	%s63,0,%s63
 1385      BF003F45 
 1386 1d80 00000000 		mulu.l	%s63,%s63,%s62
 1386      BEBF3F49 
 1387 1d88 00000000 		ldl.sx	%s61,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1387      81003D03 
 1388 1d90 00000000 		or	%s61,0,%s61
 1388      BD003D45 
 1389 1d98 00000000 		divu.l	%s61,%s63,%s61
 1389      BDBF3D6F 
 1390 1da0 00000000 		or	%s63,0,%s7
 1390      87003F45 
 1391 1da8 00000000 		addu.l	%s63,%s61,%s63
 1391      BFBD3F48 
 1392              	# line 248
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           dst_init(p, bia_m, bia_off, dst_m, mb, g, oc, oh);
 1393              		.loc	1 248 0
 1394 1db0 00000000 		or	%s23,0,(0)1
 1394      00001745 
 1395 1db8 18000000 		ldl.sx	%s18,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1395      81001203 
 1396 1dc0 80FFFFFF 		brlt.w	0,%s18,.L3.51
 1396      92008218 
 1397 1dc8 C8F2FFFF 		br.l	.L3.10
 1397      00000F18 
 1398              	.L3.52:
 1399 1dd0 00000000 		or	%s31,0,%s5
 1399      85001F45 
 1400 1dd8 98FFFFFF 		br.l	.L3.37
 1400      00000F18 
 1401              	.L3.36:
 1402              	# line 246
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         size_t bia_off = bia_off_f(p, g, oc);
 1403              		.loc	1 246 0
 1404 1de0 00000000 		or	%s7,0,(0)1
 1404      00000745 
 1405 1de8 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1405      81003F03 
 1406 1df0 00000000 		ldl.sx	%s61,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1406      81003D03 
 1407 1df8 00000000 		divs.w.sx	%s61,%s63,%s61
 1407      BDBF3D7B 
 1408 1e00 D0FFFFFF 		brlt.w	0,%s61,.L3.52
 1408      BD008218 
 1409 1e08 48F9FFFF 		br.l	.L3.35
 1409      00000F18 
 1410              	.L3.53:
 1411 1e10 00000000 		or	%s62,0,%s6
 1411      86003E45 
 1412 1e18 C8FFFFFF 		br.l	.L3.36
 1412      00000F18 
 1413              	.L3.34:
 1414              	# line 245
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 1415              		.loc	1 245 0
 1416 1e20 00000000 		or	%s5,0,(0)1
 1416      00000545 
 1417 1e28 04000000 		ldl.sx	%s18,4(,%s1)	# *(p).__b_N4conv6desc_tE.mb
 1417      81001203 
 1418 1e30 E0FFFFFF 		brlt.w	0,%s18,.L3.53
 1418      92008218 
 1419 1e38 F8F8FFFF 		br.l	.L3.33
 1419      00000F18 
 1420              	.L3.54:
 1421              	# line 249
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 1422              		.loc	1 249 0
 1423 1e40 F9FFFFFF 		lea	%s63,-7
 1423      00003F06 
 1424 1e48 00000000 		adds.l	%s60,%fp,%s63
 1424      BF893C59 
 1425 1e50 00000000 		lea	%s26,__eh_curr_region@LO
 1425      00001A06 
 1426 1e58 00000000 		and	%s26,%s26,(32)0
 1426      609A1A44 
 1427 1e60 00000000 		lea.sl	%s26,__eh_curr_region@HI(,%s26)
 1427      9A009A06 
 1428              	# line 273
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 1429              		.loc	1 273 0
 1430 1e68 00000000 		adds.l	%s33,%fp,(61)1
 1430      3D892159 
 1431 1e70 00000000 		or	%s2,0,%s20
 1431      94000245 
 1432 1e78 00000000 		or	%s4,0,%s21
 1432      95000445 
 1433 1e80 A0FFFFFF 		br.l	.L3.34
 1433      00000F18 
 1434              	.L3.55:
 1435              	# line 244
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1436              		.loc	1 244 0
 1437 1e88 00000000 		or	%s6,0,(0)1
 1437      00000645 
 1438 1e90 00000000 		ldl.sx	%s18,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1438      81001203 
 1439 1e98 A8FFFFFF 		brlt.w	0,%s18,.L3.54
 1439      92008218 
 1440 1ea0 90F7FFFF 		br.l	.L3.32
 1440      00000F18 
 1441              	.L3.56:
 1442              	# line 237
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owb[kw] = div_floor(    + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
 1443              		.loc	1 237 0
 1444 1ea8 00000000 		subs.l	%s0,0,%s2
 1444      8200005B 
 1445 1eb0 00000000 		lea	%s12,__grow_stack@LO
 1445      00000C06 
 1446 1eb8 00000000 		and	%s12,%s12,(32)0
 1446      608C0C44 
 1447 1ec0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1447      8C008C06 
 1448 1ec8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1448      8C000A08 
 1449 1ed0 B8FFFFFF 		br.l	.L3.55
 1449      00000F18 
 1450              	.L3.57:
 1451 1ed8 00000000 		adds.l	%s57,4,%s57
 1451      B9043959 
 1452 1ee0 00000000 		adds.l	%s62,4,%s62
 1452      BE043E59 
 1453 1ee8 00000000 		adds.w.sx	%s52,-1,%s52
 1453      B47F344A 
 1454 1ef0 90000000 		brlt.w	0,%s52,.L3.58
 1454      B4008218 
 1455 1ef8 B0FFFFFF 		br.l	.L3.56
 1455      00000F18 
 1456              	.L3.59:
 1457              	# line 241
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 1458              		.loc	1 241 0
 1459 1f00 00000000 		stl	%s19,0(%s57,%s53)	# *(owe)
 1459      B5B91313 
 1460 1f08 D0FFFFFF 		br.l	.L3.57
 1460      00000F18 
 1461              	.L3.60:
 1462 1f10 00000000 		ldl.sx	%s18,0(%s57,%s53)	# *(owe)
 1462      B5B91203 
 1463 1f18 1C000000 		ldl.sx	%s19,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 1463      81001303 
 1464 1f20 E0FFFFFF 		brgt.w	%s18,%s19,.L3.59
 1464      93928118 
 1465 1f28 B0FFFFFF 		br.l	.L3.57
 1465      00000F18 
 1466              	.L3.61:
 1467 1f30 00000000 		lea	%s61,0
 1467      00003D06 
 1468              	# line 240
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owe[kw] > OW) owe[kw] = OW;
 1469              		.loc	1 240 0
 1470 1f38 00000000 		stl	%s61,0(%s57,%s54)	# *(owb)
 1470      B6B93D13 
 1471 1f40 D0FFFFFF 		br.l	.L3.60
 1471      00000F18 
 1472              	.L3.9:
 1473              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owb[kw] < 0 ) owb[kw] = 0;
 1474              		.loc	1 239 0
 1475 1f48 00000000 		subs.w.sx	%s61,%s56,%s61
 1475      BDB83D5A 
 1476 1f50 00000000 		stl	%s61,0(%s57,%s55)	# *(owe)
 1476      B7B93D13 
 1477              	# line 240
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owe[kw] > OW) owe[kw] = OW;
 1478              		.loc	1 240 0
 1479 1f58 00000000 		ldl.sx	%s18,0(%s57,%s54)	# *(owb)
 1479      B6B91203 
 1480 1f60 D0FFFFFF 		brgt.w	0,%s18,.L3.61
 1480      92008118 
 1481 1f68 A8FFFFFF 		br.l	.L3.60
 1481      00000F18 
 1482              	.L3.62:
 1483              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owb[kw] < 0 ) owb[kw] = 0;
 1484              		.loc	1 239 0
 1485 1f70 00000000 		or	%s61,1,(0)1
 1485      00013D45 
 1486 1f78 D0FFFFFF 		br.l	.L3.9
 1486      00000F18 
 1487              	.L3.58:
 1488              	# line 238
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owe[kw] = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 1489              		.loc	1 238 0
 1490 1f80 00000000 		ldl.sx	%s61,0(%s62,%s63)
 1490      BFBE3D03 
 1491 1f88 00000000 		ldl.sx	%s56,0(%s62,%s60)
 1491      BCBE3803 
 1492 1f90 00000000 		ldl.sx	%s18,0(%s62,%s59)
 1492      BBBE1203 
 1493 1f98 00000000 		stl	%s61,0(%s57,%s58)	# *(owb)
 1493      BAB93D13 
 1494 1fa0 D0FFFFFF 		brgt.w	0,%s18,.L3.62
 1494      92008118 
 1495 1fa8 D8F0FFFF 		br.l	.L3.8
 1495      00000F18 
 1496              	.L3.63:
 1497 1fb0 00000000 		or	%s52,0,%s51
 1497      B3003445 
 1498 1fb8 00000000 		or	%s57,0,(0)1
 1498      00003945 
 1499 1fc0 00000000 		or	%s62,0,(0)1
 1499      00003E45 
 1500 1fc8 00000000 		or	%s53,0,%s50
 1500      B2003545 
 1501 1fd0 00000000 		or	%s54,0,%s49
 1501      B1003645 
 1502 1fd8 00000000 		or	%s55,0,%s48
 1502      B0003745 
 1503 1fe0 00000000 		or	%s58,0,%s47
 1503      AF003A45 
 1504 1fe8 00000000 		or	%s59,0,%s46
 1504      AE003B45 
 1505 1ff0 00000000 		or	%s60,0,%s45
 1505      AD003C45 
 1506 1ff8 00000000 		or	%s63,0,%s44
 1506      AC003F45 
 1507 2000 80FFFFFF 		br.l	.L3.58
 1507      00000F18 
 1508              	.L3.7:
 1509 2008 34000000 		ldl.sx	%s63,52(,%s1)	# *(p).__b_N4conv6desc_tE.pw
 1509      81003F03 
 1510 2010 3C000000 		ldl.sx	%s52,60(,%s1)	# *(p).__b_N4conv6desc_tE.dw
 1510      81003403 
 1511 2018 00000000 		adds.w.sx	%s52,1,%s52
 1511      B401344A 
 1512 2020 00000000 		lvl	%s61
 1512      00BD00BF 
 1513 2028 002B0029 		vadds.w.sx	%v41,%s62,%v43
 1513      00BE20CA 
 1514 2030 00290028 		vmuls.w.sx	%v40,%s52,%v41
 1514      00B420CB 
 1515 2038 00280027 		vsubs.w.sx	%v39,%s63,%v40
 1515      00BF20DA 
 1516 2040 2C000000 		ldl.sx	%s63,44(,%s1)	# *(p).__b_N4conv6desc_tE.sw
 1516      81003F03 
 1517 2048 00270026 		vadds.w.sx	%v38,%s63,%v39
 1517      00BF20CA 
 1518 2050 00000000 		subs.w.sx	%s52,0,(63)0
 1518      7F00345A 
 1519 2058 00260025 		vadds.w.sx	%v37,%s52,%v38
 1519      00B420CA 
 1520 2060 00002524 		vdivs.w.sx	%v36,%v37,%s63
 1520      00BF10EB 
 1521 2068 00240023 		vmuls.w.sx	%v35,%s63,%v36
 1521      00BF20CB 
 1522 2070 00232522 		vsubs.w.sx	%v34,%v37,%v35
 1522      000000DA 
 1523 2078 0022050F 		vfmk.w.ge	%vm15,%v34
 1523      000000B5 
 1524 2080 0000002A 		vbrd	%v42,0,%vm15
 1524      00000F8C 
 1525 2088 00000F0F 		negm	%vm15,%vm15
 1525      00000095 
 1526 2090 0000002A 		vbrd	%v42,1,%vm15
 1526      00010F8C 
 1527 2098 002A2421 		vsubs.w.sx	%v33,%v36,%v42
 1527      000000DA 
 1528 20a0 00000000 		adds.l	%s63,%s60,%s59
 1528      BBBC3F59 
 1529 20a8 00000021 		vstl.nc	%v33,4,%s63
 1529      BF040093 
 1530              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (owb[kw] < 0 ) owb[kw] = 0;
 1531              		.loc	1 239 0
 1532 20b0 10000000 		ldl.sx	%s63,16(,%s1)	# *(p).__b_N4conv6desc_tE.iw
 1532      81003F03 
 1533 20b8 34000000 		ldl.sx	%s52,52(,%s1)	# *(p).__b_N4conv6desc_tE.pw
 1533      81003403 
 1534 20c0 00000000 		adds.w.sx	%s52,%s63,%s52
 1534      B4BF344A 
 1535 20c8 3C000000 		ldl.sx	%s63,60(,%s1)	# *(p).__b_N4conv6desc_tE.dw
 1535      81003F03 
 1536 20d0 00000000 		adds.w.sx	%s63,1,%s63
 1536      BF013F4A 
 1537 20d8 002B0020 		vadds.w.sx	%v32,%s62,%v43
 1537      00BE20CA 
 1538 20e0 0020001F 		vmuls.w.sx	%v31,%s63,%v32
 1538      00BF20CB 
 1539 20e8 001F001E 		vsubs.w.sx	%v30,%s52,%v31
 1539      00B420DA 
 1540 20f0 2C000000 		ldl.sx	%s63,44(,%s1)	# *(p).__b_N4conv6desc_tE.sw
 1540      81003F03 
 1541 20f8 001E001D 		vadds.w.sx	%v29,%s63,%v30
 1541      00BF20CA 
 1542 2100 00000000 		subs.w.sx	%s52,0,(63)0
 1542      7F00345A 
 1543 2108 001D001C 		vadds.w.sx	%v28,%s52,%v29
 1543      00B420CA 
 1544 2110 00001C1B 		vdivs.w.sx	%v27,%v28,%s63
 1544      00BF10EB 
 1545 2118 00000000 		adds.l	%s52,%s58,%s59
 1545      BBBA3459 
 1546 2120 0000001B 		vstl.nc	%v27,4,%s52
 1546      B4040093 
 1547 2128 001B001A 		vor	%v26,(0)1,%v27
 1547      000020C5 
 1548 2130 001A0019 		vmuls.w.sx	%v25,%s63,%v26
 1548      00BF20CB 
 1549 2138 00191C18 		vsubs.w.sx	%v24,%v28,%v25
 1549      000000DA 
 1550 2140 00000000 		adds.l	%s63,%s57,%s59
 1550      BBB93F59 
 1551 2148 00000018 		vstl.nc	%v24,4,%s63
 1551      BF040093 
 1552 2150 00000000 		adds.w.sx	%s62,%s62,%s56
 1552      B8BE3E4A 
 1553 2158 00000000 		or	%s55,0,%s55
 1553      B7003745 
 1554 2160 00000000 		adds.l	%s59,%s59,%s55
 1554      B7BB3B59 
 1555 2168 00000000 		or	%s55,0,%s54
 1555      B6003745 
 1556 2170 00000000 		subs.w.sx	%s53,%s53,%s61
 1556      BDB5355A 
 1557 2178 38FEFFFF 		brge.w	0,%s53,.L3.63
 1557      B5008518 
 1558 2180 F0EEFFFF 		br.l	.L3.6
 1558      00000F18 
 1559              	.L3.64:
 1560              	# line 238
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owe[kw] = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 1561              		.loc	1 238 0
 1562 2188 D8FFFFFF 		dld	%s47,-40(,%fp)	# owb
 1562      89002F09 
 1563 2190 00000000 		or	%s49,0,%s47
 1563      AF003145 
 1564 2198 00000000 		or	%s48,0,%s63
 1564      BF003045 
 1565 21a0 00000000 		or	%s50,0,%s63
 1565      BF003245 
 1566              	# line 237
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owb[kw] = div_floor(    + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
 1567              		.loc	1 237 0
 1568 21a8 00000000 		subs.w.sx	%s18,0,%s18
 1568      9200125A 
 1569 21b0 00000000 		subs.w.sx	%s51,0,%s18
 1569      9200335A 
 1570 21b8 00000000 		smvl	%s23
 1570      0000172E 
 1571 21c0 00000000 		muls.l	%s0,12,%s51
 1571      B30C006E 
 1572 21c8 F0ECFFFF 		st	%s0,-4880(,%fp)	# spill 
 1572      89000011 
 1573 21d0 00000000 		lea	%s12,__grow_stack@LO
 1573      00000C06 
 1574 21d8 00000000 		and	%s12,%s12,(32)0
 1574      608C0C44 
 1575 21e0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1575      8C008C06 
 1576 21e8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1576      8C000A08 
 1577 21f0 F8000000 		lea	%s63,248
 1577      00003F06 
 1578 21f8 00000000 		adds.l	%s60,%sp,%s63
 1578      BF8B3C59 
 1579 2200 F0ECFFFF 		ld	%s2,-4880(,%fp)	# restore 
 1579      89000201 
 1580 2208 00000000 		or	%s44,0,%s60
 1580      BC002C45 
 1581 2210 00000000 		muls.w.sx	%s63,4,%s51
 1581      B3043F4B 
 1582 2218 00000000 		smvl	%s13
 1582      00000D2E 
 1583 2220 00000000 		lvl	%s13
 1583      008D00BF 
 1584 2228 00000000 		adds.l	%s58,%s60,%s63
 1584      BFBC3A59 
 1585 2230 00000000 		or	%s45,0,%s58
 1585      BA002D45 
 1586 2238 00000000 		adds.l	%s57,%s58,%s63
 1586      BFBA3959 
 1587 2240 00000000 		or	%s46,0,%s57
 1587      B9002E45 
 1588 2248 80000000 		mins.w.sx	%s61,%s51,%s23
 1588      97B33D78 
 1589 2250 00000000 		or	%s53,0,%s51
 1589      B3003545 
 1590 2258 00000000 		or	%s62,0,(0)1
 1590      00003E45 
 1591 2260 00000000 		or	%s56,0,%s61
 1591      BD003845 
 1592 2268 00000000 		lvl	%s61
 1592      00BD00BF 
 1593 2270 00000016 		vseq	%v22
 1593      00000099 
 1594 2278 0016002B 		vor	%v43,(0)1,%v22
 1594      000020C5 
 1595 2280 00000000 		muls.w.sx	%s55,4,%s61
 1595      BD04374B 
 1596 2288 00000000 		or	%s59,0,(0)1
 1596      00003B45 
 1597 2290 00000000 		muls.w.sx	%s54,4,%s23
 1597      9704364B 
 1598 2298 70FDFFFF 		br.l	.L3.7
 1598      00000F18 
 1599              	.L3.1:
 1600              	# line 236
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kw = 0; kw < KW; ++kw) {
 1601              		.loc	1 236 0
 1602 22a0 24000000 		ldl.sx	%s63,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 1602      81003F03 
 1603 22a8 00000000 		or	%s63,0,%s63
 1603      BF003F45 
 1604 22b0 D8FFFFFF 		lea	%s62,-40
 1604      00003E06 
 1605 22b8 00000000 		adds.l	%s23,%fp,%s62
 1605      BE891759 
 1606 22c0 00000000 		muls.l	%s0,4,%s63
 1606      BF04006E 
 1607 22c8 00000000 		lea	%s12,__grow_stack@LO
 1607      00000C06 
 1608 22d0 00000000 		and	%s12,%s12,(32)0
 1608      608C0C44 
 1609 22d8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1609      8C008C06 
 1610 22e0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1610      8C000A08 
 1611 22e8 F8000000 		lea	%s63,248
 1611      00003F06 
 1612 22f0 00000000 		adds.l	%s63,%sp,%s63
 1612      BF8B3F59 
 1613 22f8 00000000 		st	%s63,0(,%s23)
 1613      97003F11 
 1614 2300 D8FFFFFF 		ld	%s63,-40(,%fp)	# owb
 1614      89003F01 
 1615 2308 C8FFFFFF 		lea	%s62,-56
 1615      00003E06 
 1616 2310 00000000 		st	%s63,0(%s62,%fp)
 1616      89BE3F11 
 1617 2318 00000000 		lea	%s23,__eh_curr_region@LO
 1617      00001706 
 1618 2320 00000000 		and	%s23,%s23,(32)0
 1618      60971744 
 1619 2328 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 1619      97009706 
 1620 2330 00000000 		or	%s63,2,(0)1
 1620      00023F45 
 1621 2338 00000000 		st2b	%s63,0(,%s23)
 1621      97003F14 
 1622 2340 24000000 		ldl.sx	%s63,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 1622      81003F03 
 1623 2348 00000000 		or	%s63,0,%s63
 1623      BF003F45 
 1624 2350 00000000 		adds.l	%s24,%fp,(60)1
 1624      3C891859 
 1625 2358 00000000 		muls.l	%s0,4,%s63
 1625      BF04006E 
 1626 2360 00000000 		lea	%s12,__grow_stack@LO
 1626      00000C06 
 1627 2368 00000000 		and	%s12,%s12,(32)0
 1627      608C0C44 
 1628 2370 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1628      8C008C06 
 1629 2378 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1629      8C000A08 
 1630 2380 F8000000 		lea	%s63,248
 1630      00003F06 
 1631 2388 00000000 		adds.l	%s63,%sp,%s63
 1631      BF8B3F59 
 1632 2390 00000000 		st	%s63,0(,%s24)
 1632      98003F11 
 1633 2398 F0FFFFFF 		ld	%s63,-16(,%fp)	# owe
 1633      89003F01 
 1634 23a0 D0FFFFFF 		lea	%s62,-48
 1634      00003E06 
 1635 23a8 00000000 		st	%s63,0(%s62,%fp)
 1635      89BE3F11 
 1636 23b0 00000000 		or	%s62,3,(0)1
 1636      00033E45 
 1637 23b8 00000000 		st2b	%s62,0(,%s23)
 1637      97003E14 
 1638              	# line 237
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     owb[kw] = div_floor(    + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
 1639              		.loc	1 237 0
 1640 23c0 24000000 		ldl.sx	%s18,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 1640      81001203 
 1641 23c8 C0FDFFFF 		brlt.w	0,%s18,.L3.64
 1641      92008218 
 1642 23d0 B8FAFFFF 		br.l	.L3.55
 1642      00000F18 
 1643              	.L3.65:
 1644              	# line 230
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohb[kh] = div_floor(    + PH - kh*(p->dh+1) + SH - 1, SH);//(c-a+b-1)/b
 1645              		.loc	1 230 0
 1646 23d8 00000000 		subs.l	%s0,0,%s5
 1646      8500005B 
 1647 23e0 00000000 		lea	%s12,__grow_stack@LO
 1647      00000C06 
 1648 23e8 00000000 		and	%s12,%s12,(32)0
 1648      608C0C44 
 1649 23f0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1649      8C008C06 
 1650 23f8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1650      8C000A08 
 1651 2400 00000000 		or	%s28,0,%s2
 1651      82001C45 
 1652 2408 00000000 		or	%s20,0,%s3
 1652      83001445 
 1653 2410 00000000 		or	%s21,0,%s4
 1653      84001545 
 1654 2418 88FEFFFF 		br.l	.L3.1
 1654      00000F18 
 1655              	.L3.66:
 1656 2420 00000000 		adds.l	%s57,4,%s57
 1656      B9043959 
 1657 2428 00000000 		adds.l	%s62,4,%s62
 1657      BE043E59 
 1658 2430 00000000 		adds.w.sx	%s52,-1,%s52
 1658      B47F344A 
 1659 2438 90000000 		brlt.w	0,%s52,.L3.67
 1659      B4008218 
 1660 2440 98FFFFFF 		br.l	.L3.65
 1660      00000F18 
 1661              	.L3.68:
 1662              	# line 234
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 1663              		.loc	1 234 0
 1664 2448 00000000 		stl	%s19,0(%s57,%s53)	# *(ohe)
 1664      B5B91313 
 1665 2450 D0FFFFFF 		br.l	.L3.66
 1665      00000F18 
 1666              	.L3.69:
 1667 2458 00000000 		ldl.sx	%s18,0(%s57,%s53)	# *(ohe)
 1667      B5B91203 
 1668 2460 18000000 		ldl.sx	%s19,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1668      81001303 
 1669 2468 E0FFFFFF 		brgt.w	%s18,%s19,.L3.68
 1669      93928118 
 1670 2470 B0FFFFFF 		br.l	.L3.66
 1670      00000F18 
 1671              	.L3.70:
 1672 2478 00000000 		lea	%s61,0
 1672      00003D06 
 1673              	# line 233
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohe[kh] > OH) ohe[kh] = OH;
 1674              		.loc	1 233 0
 1675 2480 00000000 		stl	%s61,0(%s57,%s54)	# *(ohb)
 1675      B6B93D13 
 1676 2488 D0FFFFFF 		br.l	.L3.69
 1676      00000F18 
 1677              	.L3.5:
 1678              	# line 232
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohb[kh] < 0 ) ohb[kh] = 0;
 1679              		.loc	1 232 0
 1680 2490 00000000 		subs.w.sx	%s61,%s56,%s61
 1680      BDB83D5A 
 1681 2498 00000000 		stl	%s61,0(%s57,%s55)	# *(ohe)
 1681      B7B93D13 
 1682              	# line 233
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohe[kh] > OH) ohe[kh] = OH;
 1683              		.loc	1 233 0
 1684 24a0 00000000 		ldl.sx	%s18,0(%s57,%s54)	# *(ohb)
 1684      B6B91203 
 1685 24a8 D0FFFFFF 		brgt.w	0,%s18,.L3.70
 1685      92008118 
 1686 24b0 A8FFFFFF 		br.l	.L3.69
 1686      00000F18 
 1687              	.L3.71:
 1688              	# line 232
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohb[kh] < 0 ) ohb[kh] = 0;
 1689              		.loc	1 232 0
 1690 24b8 00000000 		or	%s61,1,(0)1
 1690      00013D45 
 1691 24c0 D0FFFFFF 		br.l	.L3.5
 1691      00000F18 
 1692              	.L3.67:
 1693              	# line 231
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohe[kh] = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 1694              		.loc	1 231 0
 1695 24c8 00000000 		ldl.sx	%s61,0(%s62,%s63)
 1695      BFBE3D03 
 1696 24d0 00000000 		ldl.sx	%s56,0(%s62,%s60)
 1696      BCBE3803 
 1697 24d8 00000000 		ldl.sx	%s18,0(%s62,%s59)
 1697      BBBE1203 
 1698 24e0 00000000 		stl	%s61,0(%s57,%s58)	# *(ohb)
 1698      BAB93D13 
 1699 24e8 D0FFFFFF 		brgt.w	0,%s18,.L3.71
 1699      92008118 
 1700 24f0 70EBFFFF 		br.l	.L3.4
 1700      00000F18 
 1701              	.L3.72:
 1702 24f8 00000000 		or	%s52,0,%s51
 1702      B3003445 
 1703 2500 00000000 		or	%s57,0,(0)1
 1703      00003945 
 1704 2508 00000000 		or	%s62,0,(0)1
 1704      00003E45 
 1705 2510 00000000 		or	%s53,0,%s50
 1705      B2003545 
 1706 2518 00000000 		or	%s54,0,%s49
 1706      B1003645 
 1707 2520 00000000 		or	%s55,0,%s48
 1707      B0003745 
 1708 2528 00000000 		or	%s58,0,%s47
 1708      AF003A45 
 1709 2530 00000000 		or	%s59,0,%s46
 1709      AE003B45 
 1710 2538 00000000 		or	%s60,0,%s45
 1710      AD003C45 
 1711 2540 00000000 		or	%s63,0,%s44
 1711      AC003F45 
 1712 2548 80FFFFFF 		br.l	.L3.67
 1712      00000F18 
 1713              	.L3.3:
 1714 2550 30000000 		ldl.sx	%s63,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 1714      81003F03 
 1715 2558 38000000 		ldl.sx	%s52,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 1715      81003403 
 1716 2560 00000000 		adds.w.sx	%s52,1,%s52
 1716      B401344A 
 1717 2568 00000000 		lvl	%s61
 1717      00BD00BF 
 1718 2570 003F003D 		vadds.w.sx	%v61,%s62,%v63
 1718      00BE20CA 
 1719 2578 003D003C 		vmuls.w.sx	%v60,%s52,%v61
 1719      00B420CB 
 1720 2580 003C003B 		vsubs.w.sx	%v59,%s63,%v60
 1720      00BF20DA 
 1721 2588 28000000 		ldl.sx	%s63,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 1721      81003F03 
 1722 2590 003B003A 		vadds.w.sx	%v58,%s63,%v59
 1722      00BF20CA 
 1723 2598 00000000 		subs.w.sx	%s52,0,(63)0
 1723      7F00345A 
 1724 25a0 003A0039 		vadds.w.sx	%v57,%s52,%v58
 1724      00B420CA 
 1725 25a8 00003938 		vdivs.w.sx	%v56,%v57,%s63
 1725      00BF10EB 
 1726 25b0 00380037 		vmuls.w.sx	%v55,%s63,%v56
 1726      00BF20CB 
 1727 25b8 00373936 		vsubs.w.sx	%v54,%v57,%v55
 1727      000000DA 
 1728 25c0 0036050F 		vfmk.w.ge	%vm15,%v54
 1728      000000B5 
 1729 25c8 0000003E 		vbrd	%v62,0,%vm15
 1729      00000F8C 
 1730 25d0 00000F0F 		negm	%vm15,%vm15
 1730      00000095 
 1731 25d8 0000003E 		vbrd	%v62,1,%vm15
 1731      00010F8C 
 1732 25e0 003E3835 		vsubs.w.sx	%v53,%v56,%v62
 1732      000000DA 
 1733 25e8 00000000 		adds.l	%s63,%s60,%s59
 1733      BBBC3F59 
 1734 25f0 00000035 		vstl.nc	%v53,4,%s63
 1734      BF040093 
 1735              	# line 232
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if (ohb[kh] < 0 ) ohb[kh] = 0;
 1736              		.loc	1 232 0
 1737 25f8 0C000000 		ldl.sx	%s63,12(,%s1)	# *(p).__b_N4conv6desc_tE.ih
 1737      81003F03 
 1738 2600 30000000 		ldl.sx	%s52,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 1738      81003403 
 1739 2608 00000000 		adds.w.sx	%s52,%s63,%s52
 1739      B4BF344A 
 1740 2610 38000000 		ldl.sx	%s63,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 1740      81003F03 
 1741 2618 00000000 		adds.w.sx	%s63,1,%s63
 1741      BF013F4A 
 1742 2620 003F0034 		vadds.w.sx	%v52,%s62,%v63
 1742      00BE20CA 
 1743 2628 00340033 		vmuls.w.sx	%v51,%s63,%v52
 1743      00BF20CB 
 1744 2630 00330032 		vsubs.w.sx	%v50,%s52,%v51
 1744      00B420DA 
 1745 2638 28000000 		ldl.sx	%s63,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 1745      81003F03 
 1746 2640 00320031 		vadds.w.sx	%v49,%s63,%v50
 1746      00BF20CA 
 1747 2648 00000000 		subs.w.sx	%s52,0,(63)0
 1747      7F00345A 
 1748 2650 00310030 		vadds.w.sx	%v48,%s52,%v49
 1748      00B420CA 
 1749 2658 0000302F 		vdivs.w.sx	%v47,%v48,%s63
 1749      00BF10EB 
 1750 2660 00000000 		adds.l	%s52,%s58,%s59
 1750      BBBA3459 
 1751 2668 0000002F 		vstl.nc	%v47,4,%s52
 1751      B4040093 
 1752 2670 002F002E 		vor	%v46,(0)1,%v47
 1752      000020C5 
 1753 2678 002E002D 		vmuls.w.sx	%v45,%s63,%v46
 1753      00BF20CB 
 1754 2680 002D302C 		vsubs.w.sx	%v44,%v48,%v45
 1754      000000DA 
 1755 2688 00000000 		adds.l	%s63,%s57,%s59
 1755      BBB93F59 
 1756 2690 0000002C 		vstl.nc	%v44,4,%s63
 1756      BF040093 
 1757 2698 00000000 		adds.w.sx	%s62,%s62,%s56
 1757      B8BE3E4A 
 1758 26a0 00000000 		or	%s55,0,%s55
 1758      B7003745 
 1759 26a8 00000000 		adds.l	%s59,%s59,%s55
 1759      B7BB3B59 
 1760 26b0 00000000 		or	%s55,0,%s54
 1760      B6003745 
 1761 26b8 00000000 		subs.w.sx	%s53,%s53,%s61
 1761      BDB5355A 
 1762 26c0 38FEFFFF 		brge.w	0,%s53,.L3.72
 1762      B5008518 
 1763 26c8 88E9FFFF 		br.l	.L3.2
 1763      00000F18 
 1764              	.L3.0:
 1765              	# line 231
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohe[kh] = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 1766              		.loc	1 231 0
 1767 26d0 E8FFFFFF 		dld	%s47,-24(,%fp)	# ohb
 1767      89002F09 
 1768 26d8 00000000 		or	%s49,0,%s47
 1768      AF003145 
 1769 26e0 00000000 		or	%s48,0,%s63
 1769      BF003045 
 1770 26e8 00000000 		or	%s50,0,%s63
 1770      BF003245 
 1771              	# line 230
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     ohb[kh] = div_floor(    + PH - kh*(p->dh+1) + SH - 1, SH);//(c-a+b-1)/b
 1772              		.loc	1 230 0
 1773 26f0 00000000 		subs.w.sx	%s63,0,%s62
 1773      BE003F5A 
 1774 26f8 00000000 		subs.w.sx	%s51,0,%s63
 1774      BF00335A 
 1775 2700 00000000 		smvl	%s23
 1775      0000172E 
 1776 2708 00000000 		muls.l	%s0,12,%s51
 1776      B30C006E 
 1777 2710 F8F4FFFF 		st	%s0,-2824(,%fp)	# spill 
 1777      89000011 
 1778 2718 00000000 		lea	%s12,__grow_stack@LO
 1778      00000C06 
 1779 2720 00000000 		and	%s12,%s12,(32)0
 1779      608C0C44 
 1780 2728 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1780      8C008C06 
 1781 2730 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1781      8C000A08 
 1782 2738 F8000000 		lea	%s63,248
 1782      00003F06 
 1783 2740 00000000 		adds.l	%s60,%sp,%s63
 1783      BF8B3C59 
 1784 2748 00000000 		or	%s29,0,%s1
 1784      81001D45 
 1785 2750 00000000 		or	%s44,0,%s60
 1785      BC002C45 
 1786 2758 00000000 		muls.w.sx	%s63,4,%s51
 1786      B3043F4B 
 1787 2760 30FEFFFF 		ld	%s1,-464(,%fp)	# restore 
 1787      89000101 
 1788 2768 00000000 		adds.l	%s58,%s60,%s63
 1788      BFBC3A59 
 1789 2770 F8F4FFFF 		ld	%s5,-2824(,%fp)	# restore 
 1789      89000501 
 1790 2778 00000000 		or	%s45,0,%s58
 1790      BA002D45 
 1791 2780 00000000 		adds.l	%s57,%s58,%s63
 1791      BFBA3959 
 1792 2788 00000000 		smvl	%s13
 1792      00000D2E 
 1793 2790 00000000 		lvl	%s13
 1793      008D00BF 
 1794 2798 00000000 		or	%s46,0,%s57
 1794      B9002E45 
 1795 27a0 80000000 		mins.w.sx	%s61,%s51,%s23
 1795      97B33D78 
 1796 27a8 00000000 		or	%s53,0,%s51
 1796      B3003545 
 1797 27b0 00000000 		or	%s62,0,(0)1
 1797      00003E45 
 1798 27b8 00000000 		or	%s56,0,%s61
 1798      BD003845 
 1799 27c0 00000000 		lvl	%s61
 1799      00BD00BF 
 1800 27c8 00000017 		vseq	%v23
 1800      00000099 
 1801 27d0 0017003F 		vor	%v63,(0)1,%v23
 1801      000020C5 
 1802 27d8 00000000 		muls.w.sx	%s55,4,%s61
 1802      BD04374B 
 1803 27e0 00000000 		or	%s59,0,(0)1
 1803      00003B45 
 1804 27e8 00000000 		muls.w.sx	%s54,4,%s23
 1804      9704364B 
 1805 27f0 60FDFFFF 		br.l	.L3.3
 1805      00000F18 
 1806              		.cfi_endproc
 1807              		.set	.L.4.2auto_size,	0xffffffffffffdaa0	# 9568 Bytes
 1809              	# ============ End  conv::refconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1810              	# ============ Begin  conv::refconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1811 27f8 00000000 		.balign 16
 1811      00000000 
 1812              	# line 287
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 1 && defined(__ve) // compiler bug! XXX TODO temporarily disabled
 1813              		.loc	1 287 0
 1814              		.globl	conv::refconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 1816              	conv::refconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 1817              		.cfi_startproc
 1818 2800 00000000 		st	%fp,0x0(,%sp)
 1818      8B000911 
 1819              		.cfi_def_cfa_offset	0
 1820              		.cfi_offset	9,0
 1821 2808 08000000 		st	%lr,0x8(,%sp)
 1821      8B000A11 
 1822 2810 18000000 		st	%got,0x18(,%sp)
 1822      8B000F11 
 1823 2818 20000000 		st	%plt,0x20(,%sp)
 1823      8B001011 
 1824 2820 00000000 		or	%fp,0,%sp
 1824      8B000945 
 1825              		.cfi_def_cfa_register	9
 1826 2828 30FEFFFF 		lea	%s13,.L.5.2auto_size&0xffffffff
 1826      00000D06 
 1827 2830 00000000 		and	%s13,%s13,(32)0
 1827      608D0D44 
 1828 2838 FFFFFFFF 		lea.sl	%sp,.L.5.2auto_size>>32(%fp,%s13)
 1828      8D898B06 
 1829 2840 48000000 		brge.l.t	%sp,%sl,.L4.EoP
 1829      888B3518 
 1830 2848 18000000 		ld	%s61,0x18(,%tp)
 1830      8E003D01 
 1831 2850 00000000 		or	%s62,0,%s0
 1831      80003E45 
 1832 2858 3B010000 		lea	%s63,0x13b
 1832      00003F06 
 1833 2860 00000000 		shm.l	%s63,0x0(%s61)
 1833      BD033F31 
 1834 2868 08000000 		shm.l	%sl,0x8(%s61)
 1834      BD030831 
 1835 2870 10000000 		shm.l	%sp,0x10(%s61)
 1835      BD030B31 
 1836 2878 00000000 		monc
 1836      0000003F 
 1837 2880 00000000 		or	%s0,0,%s62
 1837      BE000045 
 1838              	.L4.EoP:
 1839              	# End of prologue codes
 1840              	# line 291
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 0 // regr 1.91
 1841              		.loc	1 291 0
 1842 2888 00000000 		lea	%s12,conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 1842      00000C06 
 1843 2890 00000000 		and	%s12,%s12,(32)0
 1843      608C0C44 
 1844 2898 00000000 		lea.sl	%s12,conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s12)
 1844      8C008C06 
 1845 28a0 00000000 		bsic	%lr,(,%s12)	# conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 1845      8C000A08 
 1846              	# line 503
 503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 1847              		.loc	1 503 0
 1848              	# Start of epilogue codes
 1849 28a8 00000000 		or	%sp,0,%fp
 1849      89000B45 
 1850              		.cfi_def_cfa	11,8
 1851 28b0 18000000 		ld	%got,0x18(,%sp)
 1851      8B000F01 
 1852 28b8 20000000 		ld	%plt,0x20(,%sp)
 1852      8B001001 
 1853 28c0 08000000 		ld	%lr,0x8(,%sp)
 1853      8B000A01 
 1854 28c8 00000000 		ld	%fp,0x0(,%sp)
 1854      8B000901 
 1855 28d0 00000000 		b.l	(,%lr)
 1855      8A000F19 
 1856              		.cfi_endproc
 1857              		.set	.L.5.2auto_size,	0xfffffffffffffe30	# 464 Bytes
 1859              	# ============ End  conv::refconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1860              	# ============ Begin  conv::refconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1861              		.data
 1862              		.balign 16
 1865              	.LP._ZN4conv15refconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 1866 0040 00000000 		.long	__vla_dealloc_eh
 1866      00000000 
 1867 0048 0000     		.zero	2
 1868 004a FFFF     		.short	65535
 1869 004c 04       		.byte	4
 1870 004d 000000   		.zero	3
 1871 0050 00000000 		.long	__vla_dealloc_eh
 1871      00000000 
 1872 0058 0100     		.short	1
 1873 005a 0000     		.zero	2
 1874 005c 04       		.byte	4
 1875 005d 000000   		.zero	3
 1876 0060 00000000 		.long	__vla_dealloc_eh
 1876      00000000 
 1877 0068 0200     		.short	2
 1878 006a 0100     		.short	1
 1879 006c 04       		.byte	4
 1880 006d 000000   		.zero	3
 1881 0070 00000000 		.long	__vla_dealloc_eh
 1881      00000000 
 1882 0078 0300     		.short	3
 1883 007a 0200     		.short	2
 1884 007c 04       		.byte	4
 1885 007d 000000   		.zero	3
 1886 0080 00000000 		.long	__vla_dealloc_eh
 1886      00000000 
 1887 0088 0400     		.short	4
 1888 008a 0300     		.short	3
 1889 008c 04       		.byte	4
 1890 008d 000000   		.zero	3
 1891 0090 00000000 		.long	__vla_dealloc_eh
 1891      00000000 
 1892 0098 0500     		.short	5
 1893 009a 0400     		.short	4
 1894 009c 04       		.byte	4
 1895 009d 000000   		.zero	3
 1896              		.text
 1897 28d8 00000000 		.balign 16
 1897      00000000 
 1898              	# line 509
 509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   // 15 is default
 1899              		.loc	1 509 0
 1900              		.globl	conv::refconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 1902              	conv::refconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 1903              		.cfi_startproc
 1904 28e0 00000000 		st	%fp,0x0(,%sp)
 1904      8B000911 
 1905              		.cfi_def_cfa_offset	0
 1906              		.cfi_offset	9,0
 1907 28e8 08000000 		st	%lr,0x8(,%sp)
 1907      8B000A11 
 1908 28f0 18000000 		st	%got,0x18(,%sp)
 1908      8B000F11 
 1909 28f8 20000000 		st	%plt,0x20(,%sp)
 1909      8B001011 
 1910 2900 00000000 		or	%fp,0,%sp
 1910      8B000945 
 1911              		.cfi_def_cfa_register	9
 1912 2908 30000000 		st	%s18,48(,%fp)
 1912      89001211 
 1913 2910 38000000 		st	%s19,56(,%fp)
 1913      89001311 
 1914 2918 40000000 		st	%s20,64(,%fp)
 1914      89001411 
 1915 2920 48000000 		st	%s21,72(,%fp)
 1915      89001511 
 1916 2928 50000000 		st	%s22,80(,%fp)
 1916      89001611 
 1917 2930 58000000 		st	%s23,88(,%fp)
 1917      89001711 
 1918 2938 60000000 		st	%s24,96(,%fp)
 1918      89001811 
 1919 2940 68000000 		st	%s25,104(,%fp)
 1919      89001911 
 1920 2948 70000000 		st	%s26,112(,%fp)
 1920      89001A11 
 1921 2950 78000000 		st	%s27,120(,%fp)
 1921      89001B11 
 1922 2958 80000000 		st	%s28,128(,%fp)
 1922      89001C11 
 1923 2960 88000000 		st	%s29,136(,%fp)
 1923      89001D11 
 1924 2968 90000000 		st	%s30,144(,%fp)
 1924      89001E11 
 1925 2970 98000000 		st	%s31,152(,%fp)
 1925      89001F11 
 1926 2978 A0000000 		st	%s32,160(,%fp)
 1926      89002011 
 1927 2980 A8000000 		st	%s33,168(,%fp)
 1927      89002111 
 1928 2988 B0F9FFFF 		lea	%s13,.L.6.2auto_size&0xffffffff
 1928      00000D06 
 1929 2990 00000000 		and	%s13,%s13,(32)0
 1929      608D0D44 
 1930 2998 FFFFFFFF 		lea.sl	%sp,.L.6.2auto_size>>32(%fp,%s13)
 1930      8D898B06 
 1931 29a0 48000000 		brge.l.t	%sp,%sl,.L5.EoP
 1931      888B3518 
 1932 29a8 18000000 		ld	%s61,0x18(,%tp)
 1932      8E003D01 
 1933 29b0 00000000 		or	%s62,0,%s0
 1933      80003E45 
 1934 29b8 3B010000 		lea	%s63,0x13b
 1934      00003F06 
 1935 29c0 00000000 		shm.l	%s63,0x0(%s61)
 1935      BD033F31 
 1936 29c8 08000000 		shm.l	%sl,0x8(%s61)
 1936      BD030831 
 1937 29d0 10000000 		shm.l	%sp,0x10(%s61)
 1937      BD030B31 
 1938 29d8 00000000 		monc
 1938      0000003F 
 1939 29e0 00000000 		or	%s0,0,%s62
 1939      BE000045 
 1940              	.L5.EoP:
 1941              	# End of prologue codes
 1942 29e8 E0FCFFFF 		st	%s1,-800(,%fp)	# spill 
 1942      89000111 
 1943 29f0 D8FCFFFF 		st	%s2,-808(,%fp)	# spill 
 1943      89000211 
 1944 29f8 E8FCFFFF 		st	%s4,-792(,%fp)	# spill 
 1944      89000411 
 1945 2a00 08FDFFFF 		st	%s0,-760(,%fp)	# spill 
 1945      89000011 
 1946 2a08 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 1946      00003E06 
 1947 2a10 00000000 		and	%s62,%s62,(32)0
 1947      60BE3E44 
 1948 2a18 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 1948      BE00BE06 
 1949 2a20 00000000 		or	%s2,0,%s3
 1949      83000245 
 1950 2a28 00000000 		ld	%s61,0(,%s62)
 1950      BE003D01 
 1951 2a30 00000000 		or	%s3,0,%s4
 1951      84000345 
 1952 2a38 00000000 		or	%s1,0,%s0
 1952      80000145 
 1953 2a40 20FEFFFF 		st	%s61,-480(,%fp)
 1953      89003D11 
 1954 2a48 20FEFFFF 		lea	%s61,-480
 1954      00003D06 
 1955 2a50 00000000 		adds.l	%s61,%fp,%s61
 1955      BD893D59 
 1956 2a58 00000000 		st	%s61,0(,%s62)
 1956      BE003D11 
 1957 2a60 00000000 		or	%s62,1,(0)1
 1957      00013E45 
 1958 2a68 28FEFFFF 		st1b	%s62,-472(,%fp)
 1958      89003E15 
 1959 2a70 00000000 		lea	%s62,.LP._ZN4conv15refconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 1959      00003E06 
 1960 2a78 00000000 		and	%s62,%s62,(32)0
 1960      60BE3E44 
 1961 2a80 00000000 		lea.sl	%s62,.LP._ZN4conv15refconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s62)
 1961      BE00BE06 
 1962 2a88 30FEFFFF 		st	%s62,-464(,%fp)
 1962      89003E11 
 1963 2a90 98FFFFFF 		lea	%s62,-104
 1963      00003E06 
 1964 2a98 00000000 		adds.l	%s62,%fp,%s62
 1964      BE893E59 
 1965 2aa0 38FEFFFF 		st	%s62,-456(,%fp)
 1965      89003E11 
 1966 2aa8 00000000 		lea	%s23,__eh_curr_region@LO
 1966      00001706 
 1967 2ab0 00000000 		and	%s23,%s23,(32)0
 1967      60971744 
 1968 2ab8 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 1968      97009706 
 1969 2ac0 00000000 		ld2b.zx	%s62,0(,%s23)
 1969      9700BE04 
 1970 2ac8 48FEFFFF 		st2b	%s62,-440(,%fp)
 1970      89003E14 
 1971 2ad0 FFFF0000 		lea	%s62,65535
 1971      00003E06 
 1972 2ad8 00000000 		st2b	%s62,0(,%s23)
 1972      97003E14 
 1973              	# line 1011
 643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** // --------------------------------------------------impls
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** // -------------------------------------------------------
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if BW4==14 //
 646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   zero_wei(p, diff_wei_m);
 648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int mb = 0; mb < MB; ++mb)
 649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   {
 650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(parallel for collapse(4) schedule(static))//;
 651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int oh_beg, oh_end;
 656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             oh_beg=div_floor(       + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
 657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
 658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (oh_beg < 0    ) oh_beg = 0;
 659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (oh_end > OH) oh_end = OH;
 660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int ow_beg, ow_end;
 661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             ow_beg=div_floor(       + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
 662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
 663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (ow_beg < 0    ) ow_beg = 0;
 664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (ow_end > OW) ow_end = OW;
 665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // need to set dw=0
 666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int ic = 0; ic < IC/G; ++ic) {
 668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int oh = oh_beg; oh < oh_end; ++oh) {
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int ih = oh * SH - PH + kh * (p->dh + 1);
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int ow = ow_beg; ow < ow_end; ++ow) {
 673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int iw = ow * SW - PW + kw * (p->dw + 1);
 675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   dw += ((float*)diff_dst_m)[dst_off]
 677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     * ((float*)src_m)[src_off];
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif BW4==15 // tidy up, try some questionable omp mods
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   zero_wei(p, diff_wei_m);
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int mb = 0; mb < MB; ++mb) {
 690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 OMP(parallel)//;
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   {
 692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     // NOTE: we've arrived at something very similar to ref_conv3, but
 693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     //   mb-loop is outside omp-loop
 694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(for collapse(4))//;
 695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int oh_beg, oh_end;
 700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
 701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
 702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (oh_beg < 0    ) oh_beg = 0;
 703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (oh_end > OH) oh_end = OH;
 704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             int ow_beg, ow_end;
 705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
 706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
 707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (ow_beg < 0    ) ow_beg = 0;
 708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (ow_end > OW) ow_end = OW;
 709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
 710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int ic = 0; ic < IC/G; ++ic) { // B
 712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               //dw = 0.f; // 2.2x --> 2.0x
 715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int oh = oh_beg; oh < oh_end; ++oh) {
 716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int ih = oh * SH - PH + kh * (p->dh + 1);
 717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (int ow = ow_beg; ow < ow_end; ++ow) {
 718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     // Here's the problem: multiple 'mb' might update the same 'dw'
 722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     dw += ((float*)diff_dst_m)[dst_off]
 723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       * ((float*)src_m)[src_off];
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   }
 725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif BW4==16 // copy from ref_conv3
 734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int DH = p->dh + 1;
 735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const int DW = p->dw + 1;
 736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   OMP(parallel)//;
 738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   {
 739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(for collapse(5))//;
 740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               dw = 0;
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(for collapse(4))//;
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               int oh_beg, oh_end;
 761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               oh_beg = div_floor(    + PH - kh*DH + SH - 1, SH);//(c-a+b-1)/b
 762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               oh_end = div_floor( IH + PH - kh*DH + SH - 1, SH);//(d-a+b-1)/b
 763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               if (oh_end > OH) oh_end = OH;
 765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               int ow_beg, ow_end;
 766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
 767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
 768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               if (ow_end > OW) ow_end = OW;
 770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
 771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ic = 0; ic < IC/G; ++ic) { // involved in WRITE
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float &dw = ((float*)diff_wei_m)[wei_off];
 775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int mb = 0; mb < MB; ++mb) {
 776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       const int ih = oh * SH - PH + kh * DH;
 779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       const int iw = ow * SW - PW + kw * DW;
 780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       dw += ((float*)diff_dst_m)[dst_off]
 783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                         * ((float*)src_m)[src_off];
 784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     }
 785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   }
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(for collapse(2) nowait)//;
 796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int g = 0; g < G; ++g) {
 797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
 800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           db = 0;
 801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 db += ((float*)diff_dst_m)[dst_off];
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif BW4==17 // snarfed from sx_conv3.
 814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 0
 815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t G = p->g;
 816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t MB = p->mb;
 817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t IC = p->ic;
 818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t OC = p->oc;
 819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t KH = p->kh;
 821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t IH = p->ih;
 822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t OH = p->oh;
 823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t SH = p->sh;
 824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t PH = p->ph;
 825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t KW = p->kw;
 827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t IW = p->iw;
 828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t OW = p->ow;
 829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t SW = p->sw;
 830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t PW = p->pw;
 831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t DH = p->dh + 1;
 833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t DW = p->dw + 1;
 834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t ICOG = IC/G;
 835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t OCOG = OC / G;
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t OC_OH_OW = OC * OH_OW;
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t IH_IW = IH * IW;
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t KH_KW = KH * KW;
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   const ssize_t SH_IW = SH * IW;
 842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   float const * restrict const psrc = (float*)src_m;
 843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   float       * restrict const pdiff_wei = (float*)diff_wei_m;
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   float       * restrict const pdiff_bia = (float*)diff_bia_m;
 845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
 846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   OMP(parallel for collapse(4))//;
 847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
 848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
 849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       SHORTLOOP() for (ssize_t kh = 0; kh < p->kh; ++kh) {
 850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         SHORTLOOP() for (ssize_t kw = 0; kw < KW; ++kw) {
 851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #if 0 // SX 24.5x BWD_WB regr.sh  x86:7.6,13.2,1.73
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           ssize_t oh_beg, oh_end;
 854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
 857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if (oh_end > OH) oh_end = OH;
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           ssize_t ow_beg, ow_end;
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
 860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
 861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
 862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if (ow_end > OW) ow_end = OW;
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
 864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 1 // SX 24.3x  x86:6.9,16.2 // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< XXX x86 XXX
 865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           // equiv, but OK for unsigned hoist_t and "normal" division op
 866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
 867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           hoist_t oh_beg = 0, oh_end=0;
 868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
 870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( oh_end >= OH ) oh_end = OH;
 871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           hoist_t ow_beg = 1, ow_end=0;
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( ow_end >= OW ) ow_end = OW;
 875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif 0 // SX 24.1x  x86:6.8,12.3
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const ssize_t oh_beg = ( kh*DH < PH ? ((PH-kh*DH) + SH-1)/ SH : 0 );
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           ssize_t oh_end = ( kh*DH < IH+PH ? ((IH + PH - kh*DH) + SH-1) / SH : 0 );
 878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( oh_end >= OH ) oh_end = OH;
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const ssize_t ow_beg = ( kw*DW < PW ? ((PW-kw*DW) + SW-1)/ SW : 0 );
 880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           ssize_t ow_end = ( kw*DW < IW+PW ? ((IW + PW - kw*DW) + SW-1) / SW : 0 );
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if( ow_end >= OW ) ow_end = OW;
 882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #endif
 883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           float dw_ic[ICOG];
 884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
 885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
 886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             ow_end -= ow_beg;
 887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             oh_end -= oh_beg;
 888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             if (ICOG > OH*OW) { // x86: best for large ic, not best for small ic
 889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
 890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*S
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const ssize_t s0 = s00 + mb*IC*IH*IW;
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (ssize_t oh = 0; oh < oh_end; ++oh) {
 895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (size_t ow = 0; ow < ow_end; ++ow) {
 896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     for (ssize_t ic = 0; ic < ICOG; ++ic) {
 897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       // pdiff_dst is always readable, even if not used
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       dw_ic[ic] += psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW] * pdiff_dst[dst_off_beg+oh*
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     }
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   }
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }else{
 904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg
 907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 float tmp = 0.f;
 908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (ssize_t mb = 0; mb < MB; ++mb) {
 909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
 910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const ssize_t s0 = s00 + mb*IC*IH*IW;
 911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (ssize_t oh = 0; oh < oh_end; ++oh) {
 912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     for (size_t ow = 0; ow < ow_end; ++ow) {
 913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       tmp += psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW] * pdiff_dst[dst_off_beg+oh*OW+ow]
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     }
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   }
 916:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 dw_ic[ic] = tmp;
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
 919:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 920:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 921:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
 922:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
 923:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
 924:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 925:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** 
 926:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 927:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 928:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 929:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 930:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   if ((p->dir & FLAG_BIA)) {
 931:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(for collapse(2) nowait)//;
 932:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
 933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
 934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         const ssize_t bia_off = bia_off_f(p, g, oc);
 935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         pdiff_bia[bia_off] = 0.f;
 936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
 937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
 938:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
 939:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
 941:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
 942:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
 945:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
 947:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 948:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 949:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif BW4==18 // tidy up, try some questionable omp mods
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
 951:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   zero_wei(p, diff_wei_m);
 952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   int ohb[KH*KW], owb[KH*KW], ohe[KH*KW], owe[KH*KW];
 953:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   bool ook[KH*KW];
 954:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kh = 0; kh < p->kh; ++kh) {
 955:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 956:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 957:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);
 958:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 959:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 960:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 961:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (oh_beg < 0 ) oh_beg = 0;
 962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_beg < 0 ) ow_beg = 0;
 963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (oh_end > OH) oh_end = OH;
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_end > OW) ow_end = OW;
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       const int khkw = kh*KW+kw;
 966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ohb[khkw] = oh_beg;
 967:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owb[khkw] = ow_beg;
 968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ohe[khkw] = oh_end;
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owe[khkw] = ow_end;
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 972:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int mb = 0; mb < MB; ++mb) {
 974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   OMP(parallel)//;
 975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   {
 976:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(for collapse(5))//;
 977:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int g = 0; g < G; ++g) {
 978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int khkw = kh*KW+kw;
 983:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 985:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               //dw = 0.f; // 2.2x --> 2.0x
 986:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               if (ook[khkw])
 987:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               {
 988:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int oh_beg = ohb[khkw];
 989:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int oh_end = ohe[khkw];
 990:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int ow_beg = owb[khkw];
 991:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   const int ow_end = owe[khkw];
 992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 993:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int ih = oh * SH - PH + kh * (p->dh + 1);
 994:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 995:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 996:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       const int iw = ow * SW - PW + kw * (p->dw + 1);
 997:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 998:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       //if (ook[khkw])
 999:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                         dw += ((float*)diff_dst_m)[dst_off] * ((float*)src_m)[src_off];
1000:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     }
1001:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   }
1002:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
1003:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               }
1004:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             }
1005:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           }
1006:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         }
1007:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       }
1008:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
1009:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
1010:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp **** #elif BW4==19 // mb loop up-front A3,x86:12x
1011:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
 1974              		.loc	1 1011 0
 1975 2ae0 00000000 		adds.l	%s0,%fp,(61)1
 1975      3D890059 
 1976 2ae8 00000000 		lea	%s12,conv::refconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const@L
 1976      00000C06 
 1977 2af0 00000000 		and	%s12,%s12,(32)0
 1977      608C0C44 
 1978 2af8 00000000 		lea.sl	%s12,_ZZN4conv15refconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_clES2_S4_S4
 1978      8C008C06 
 1979 2b00 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv15refconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_clES
 1979      8C000A08 
 1980 2b08 D8FCFFFF 		ld	%s28,-808(,%fp)	# restore 
 1980      89001C01 
 1981              	# line 1012
1012:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   zero_wei(p, diff_wei_m);
 1982              		.loc	1 1012 0
 1983 2b10 A8010000 		ld	%s0,424(,%s28)	# *(diff_wei_m).data_
 1983      9C000001 
 1984 2b18 98010000 		ld	%s62,408(,%s28)	# *(diff_wei_m).mpd_
 1984      9C003E01 
 1985 2b20 D0FCFFFF 		st	%s0,-816(,%fp)	# spill 
 1985      89000011 
 1986 2b28 00000000 		or	%s0,0,%s62
 1986      BE000045 
 1987 2b30 00000000 		lea	%s12,mkldnn_memory_primitive_desc_get_size@LO
 1987      00000C06 
 1988 2b38 00000000 		and	%s12,%s12,(32)0
 1988      608C0C44 
 1989 2b40 00000000 		lea.sl	%s12,mkldnn_memory_primitive_desc_get_size@HI(,%s12)
 1989      8C008C06 
 1990 2b48 00000000 		bsic	%lr,(,%s12)	# mkldnn_memory_primitive_desc_get_size
 1990      8C000A08 
 1991 2b50 00000000 		or	%s1,0,(0)1
 1991      00000145 
 1992 2b58 00000000 		or	%s2,0,%s0
 1992      80000245 
 1993 2b60 D0FCFFFF 		ld	%s0,-816(,%fp)	# restore 
 1993      89000001 
 1994 2b68 00000000 		lea	%s12,__vec_memset@LO
 1994      00000C06 
 1995 2b70 00000000 		and	%s12,%s12,(32)0
 1995      608C0C44 
 1996 2b78 00000000 		lea.sl	%s12,__vec_memset@HI(,%s12)
 1996      8C008C06 
 1997 2b80 00000000 		bsic	%lr,(,%s12)	# __vec_memset
 1997      8C000A08 
 1998 2b88 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 1998      89003F01 
 1999              	# line 1013
1013:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   int ohb[KH*KW], owb[KH*KW], ohe[KH*KW], owe[KH*KW];
 2000              		.loc	1 1013 0
 2001 2b90 20000000 		ldl.sx	%s62,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2001      BF003E03 
 2002 2b98 24000000 		ldl.sx	%s61,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2002      BF003D03 
 2003 2ba0 00000000 		muls.w.sx	%s61,%s62,%s61
 2003      BDBE3D4B 
 2004 2ba8 00000000 		or	%s61,0,%s61
 2004      BD003D45 
 2005 2bb0 C8FFFFFF 		lea	%s62,-56
 2005      00003E06 
 2006 2bb8 00000000 		adds.l	%s24,%fp,%s62
 2006      BE891859 
 2007 2bc0 00000000 		muls.l	%s0,4,%s61
 2007      BD04006E 
 2008 2bc8 00000000 		lea	%s12,__grow_stack@LO
 2008      00000C06 
 2009 2bd0 00000000 		and	%s12,%s12,(32)0
 2009      608C0C44 
 2010 2bd8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2010      8C008C06 
 2011 2be0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2011      8C000A08 
 2012 2be8 D0000000 		lea	%s62,208
 2012      00003E06 
 2013 2bf0 00000000 		adds.l	%s62,%sp,%s62
 2013      BE8B3E59 
 2014 2bf8 00000000 		lea	%s61,0
 2014      00003D06 
 2015 2c00 00000000 		st	%s62,0(,%s24)
 2015      98003E11 
 2016 2c08 C8FFFFFF 		ld	%s62,-56(,%fp)	# ohb
 2016      89003E01 
 2017 2c10 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2017      89003F01 
 2018 2c18 98FFFFFF 		st	%s62,-104(,%fp)
 2018      89003E11 
 2019 2c20 00000000 		st2b	%s61,0(,%s23)
 2019      97003D14 
 2020 2c28 20000000 		ldl.sx	%s62,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2020      BF003E03 
 2021 2c30 24000000 		ldl.sx	%s61,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2021      BF003D03 
 2022 2c38 00000000 		muls.w.sx	%s61,%s62,%s61
 2022      BDBE3D4B 
 2023 2c40 00000000 		or	%s61,0,%s61
 2023      BD003D45 
 2024 2c48 D8FFFFFF 		lea	%s62,-40
 2024      00003E06 
 2025 2c50 00000000 		adds.l	%s24,%fp,%s62
 2025      BE891859 
 2026 2c58 00000000 		muls.l	%s0,4,%s61
 2026      BD04006E 
 2027 2c60 00000000 		lea	%s12,__grow_stack@LO
 2027      00000C06 
 2028 2c68 00000000 		and	%s12,%s12,(32)0
 2028      608C0C44 
 2029 2c70 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2029      8C008C06 
 2030 2c78 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2030      8C000A08 
 2031 2c80 D0000000 		lea	%s62,208
 2031      00003E06 
 2032 2c88 00000000 		adds.l	%s62,%sp,%s62
 2032      BE8B3E59 
 2033 2c90 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2033      89003F01 
 2034 2c98 00000000 		st	%s62,0(,%s24)
 2034      98003E11 
 2035 2ca0 D8FFFFFF 		ld	%s62,-40(,%fp)	# owb
 2035      89003E01 
 2036 2ca8 A0FFFFFF 		lea	%s61,-96
 2036      00003D06 
 2037 2cb0 00000000 		st	%s62,0(%s61,%fp)
 2037      89BD3E11 
 2038 2cb8 00000000 		or	%s62,1,(0)1
 2038      00013E45 
 2039 2cc0 00000000 		st2b	%s62,0(,%s23)
 2039      97003E14 
 2040 2cc8 20000000 		ldl.sx	%s62,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2040      BF003E03 
 2041 2cd0 24000000 		ldl.sx	%s61,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2041      BF003D03 
 2042 2cd8 00000000 		muls.w.sx	%s61,%s62,%s61
 2042      BDBE3D4B 
 2043 2ce0 00000000 		or	%s61,0,%s61
 2043      BD003D45 
 2044 2ce8 D0FFFFFF 		lea	%s62,-48
 2044      00003E06 
 2045 2cf0 00000000 		adds.l	%s24,%fp,%s62
 2045      BE891859 
 2046 2cf8 00000000 		muls.l	%s0,4,%s61
 2046      BD04006E 
 2047 2d00 00000000 		lea	%s12,__grow_stack@LO
 2047      00000C06 
 2048 2d08 00000000 		and	%s12,%s12,(32)0
 2048      608C0C44 
 2049 2d10 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2049      8C008C06 
 2050 2d18 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2050      8C000A08 
 2051 2d20 D0000000 		lea	%s62,208
 2051      00003E06 
 2052 2d28 00000000 		adds.l	%s62,%sp,%s62
 2052      BE8B3E59 
 2053 2d30 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2053      89003F01 
 2054 2d38 00000000 		st	%s62,0(,%s24)
 2054      98003E11 
 2055 2d40 D0FFFFFF 		ld	%s62,-48(,%fp)	# ohe
 2055      89003E01 
 2056 2d48 A8FFFFFF 		lea	%s61,-88
 2056      00003D06 
 2057 2d50 00000000 		st	%s62,0(%s61,%fp)
 2057      89BD3E11 
 2058 2d58 00000000 		or	%s62,2,(0)1
 2058      00023E45 
 2059 2d60 00000000 		st2b	%s62,0(,%s23)
 2059      97003E14 
 2060 2d68 20000000 		ldl.sx	%s62,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2060      BF003E03 
 2061 2d70 24000000 		ldl.sx	%s61,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2061      BF003D03 
 2062 2d78 00000000 		muls.w.sx	%s61,%s62,%s61
 2062      BDBE3D4B 
 2063 2d80 00000000 		or	%s61,0,%s61
 2063      BD003D45 
 2064 2d88 00000000 		adds.l	%s24,%fp,(59)1
 2064      3B891859 
 2065 2d90 00000000 		muls.l	%s0,4,%s61
 2065      BD04006E 
 2066 2d98 00000000 		lea	%s12,__grow_stack@LO
 2066      00000C06 
 2067 2da0 00000000 		and	%s12,%s12,(32)0
 2067      608C0C44 
 2068 2da8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2068      8C008C06 
 2069 2db0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2069      8C000A08 
 2070 2db8 D0000000 		lea	%s62,208
 2070      00003E06 
 2071 2dc0 00000000 		adds.l	%s62,%sp,%s62
 2071      BE8B3E59 
 2072 2dc8 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2072      89003F01 
 2073 2dd0 00000000 		st	%s62,0(,%s24)
 2073      98003E11 
 2074 2dd8 E0FFFFFF 		ld	%s62,-32(,%fp)	# owe
 2074      89003E01 
 2075 2de0 B0FFFFFF 		lea	%s61,-80
 2075      00003D06 
 2076 2de8 00000000 		st	%s62,0(%s61,%fp)
 2076      89BD3E11 
 2077 2df0 00000000 		or	%s62,3,(0)1
 2077      00033E45 
 2078 2df8 00000000 		st2b	%s62,0(,%s23)
 2078      97003E14 
 2079              	# line 1014
1014:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   bool ook[KH*KW];
 2080              		.loc	1 1014 0
 2081 2e00 20000000 		ldl.sx	%s62,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2081      BF003E03 
 2082 2e08 24000000 		ldl.sx	%s61,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2082      BF003D03 
 2083 2e10 00000000 		muls.w.sx	%s61,%s62,%s61
 2083      BDBE3D4B 
 2084 2e18 00000000 		or	%s0,0,%s61
 2084      BD000045 
 2085 2e20 E8FFFFFF 		lea	%s62,-24
 2085      00003E06 
 2086 2e28 00000000 		adds.l	%s24,%fp,%s62
 2086      BE891859 
 2087 2e30 00000000 		lea	%s12,__grow_stack@LO
 2087      00000C06 
 2088 2e38 00000000 		and	%s12,%s12,(32)0
 2088      608C0C44 
 2089 2e40 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2089      8C008C06 
 2090 2e48 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2090      8C000A08 
 2091 2e50 D0000000 		lea	%s62,208
 2091      00003E06 
 2092 2e58 00000000 		adds.l	%s62,%sp,%s62
 2092      BE8B3E59 
 2093 2e60 00000000 		st	%s62,0(,%s24)
 2093      98003E11 
 2094 2e68 E8FFFFFF 		ld	%s62,-24(,%fp)	# ook
 2094      89003E01 
 2095 2e70 B8FFFFFF 		lea	%s61,-72
 2095      00003D06 
 2096 2e78 00000000 		st	%s62,0(%s61,%fp)
 2096      89BD3E11 
 2097 2e80 10150000 		br.l	.L5.0
 2097      00000F18 
 2098              	.L5.1:
 2099              	# line 1018
1015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int kh = 0; kh < p->kh; ++kh) {
1016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
1017:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
1018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);
 2100              		.loc	1 1018 0
 2101 2e88 00000000 		or	%s62,0,(0)1
 2101      00003E45 
 2102 2e90 00000000 		or	%s60,0,%s1
 2102      81003C45 
 2103 2e98 00000000 		or	%s1,0,%s57
 2103      B9000145 
 2104 2ea0 90130000 		br.l	.L5.2
 2104      00000F18 
 2105              	.L5.3:
 2106              	# line 1019
1019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 2107              		.loc	1 1019 0
 2108 2ea8 00000000 		or	%s59,0,(0)1
 2108      00003B45 
 2109 2eb0 00000000 		or	%s2,0,%s56
 2109      B8000245 
 2110 2eb8 E0120000 		br.l	.L5.4
 2110      00000F18 
 2111              	.L5.5:
 2112              	# line 1020
1020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 2113              		.loc	1 1020 0
 2114 2ec0 00000000 		or	%s58,0,(0)1
 2114      00003A45 
 2115 2ec8 00000000 		or	%s3,0,%s55
 2115      B7000345 
 2116 2ed0 30120000 		br.l	.L5.6
 2116      00000F18 
 2117              	.L5.7:
 2118              	# line 1021
1021:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 2119              		.loc	1 1021 0
 2120 2ed8 00000000 		or	%s57,0,(0)1
 2120      00003945 
 2121 2ee0 00000000 		or	%s56,0,%s2
 2121      82003845 
 2122 2ee8 00000000 		or	%s52,0,%s3
 2122      83003445 
 2123 2ef0 00000000 		or	%s51,0,%s1
 2123      81003345 
 2124 2ef8 C8110000 		br.l	.L5.8
 2124      00000F18 
 2125              	.L5.9:
 2126              	# line 1031
1022:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (oh_beg < 0 ) oh_beg = 0;
1023:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_beg < 0 ) ow_beg = 0;
1024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (oh_end > OH) oh_end = OH;
1025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_end > OW) ow_end = OW;
1026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       const int khkw = kh*KW+kw;
1027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ohb[khkw] = oh_beg;
1028:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owb[khkw] = ow_beg;
1029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ohe[khkw] = oh_end;
1030:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owe[khkw] = ow_end;
1031:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
 2127              		.loc	1 1031 0
 2128 2f00 00000000 		or	%s59,0,(0)1
 2128      00003B45 
 2129 2f08 00000000 		or	%s58,0,%s62
 2129      BE003A45 
 2130 2f10 00000000 		or	%s62,0,%s59
 2130      BB003E45 
 2131 2f18 00000000 		or	%s57,0,%s51
 2131      B3003945 
 2132 2f20 20100000 		br.l	.L5.10
 2132      00000F18 
 2133              	.L5.11:
 2134 2f28 00000000 		or	%s62,0,%s49
 2134      B1003E45 
 2135 2f30 00000000 		or	%s3,0,%s63
 2135      BF000345 
 2136 2f38 00000000 		or	%s4,0,%s59
 2136      BB000445 
 2137 2f40 B8080000 		br.l	.L5.12
 2137      00000F18 
 2138              	.L5.13:
 2139              	# line 1050
1032:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
1033:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   }
1034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****   for (int mb = 0; mb < MB; ++mb) {
1035:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(parallel)//;
1036:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     {
1037:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       float tmp[IC/G];
1038:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(for collapse(4))//;
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       for (int g = 0; g < G; ++g) {
1040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
1041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
1042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
1043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int khkw = kh*KW+kw;
1044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               if (ook[khkw])
1045:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               {
1046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int oh_beg = ohb[khkw];
1047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int oh_end = ohe[khkw];
1048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int ow_beg = owb[khkw];
1049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int ow_end = owe[khkw];
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int ic = 0; ic < IC/G; ++ic)
 2140              		.loc	1 1050 0
 2141 2f48 80000000 		mins.w.sx	%s61,%s56,%s61
 2141      BDB83D78 
 2142 2f50 E0080000 		br.l	.L5.14
 2142      00000F18 
 2143              	.L5.15:
 2144 2f58 00000000 		or	%s59,0,%s4
 2144      84003B45 
 2145 2f60 00000000 		or	%s63,0,%s3
 2145      83003F45 
 2146 2f68 00000000 		or	%s49,0,%s62
 2146      BE003145 
 2147 2f70 48030000 		br.l	.L5.16
 2147      00000F18 
 2148              	.L5.17:
 2149 2f78 00000000 		lea	%s63,__eh_curr_region@LO
 2149      00003F06 
 2150 2f80 00000000 		and	%s63,%s63,(32)0
 2150      60BF3F44 
 2151 2f88 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 2151      BF00BF06 
 2152 2f90 48FEFFFF 		ld2b.zx	%s62,-440(,%fp)
 2152      8900BE04 
 2153 2f98 00000000 		st2b	%s62,0(,%s63)
 2153      BF003E14 
 2154 2fa0 20FEFFFF 		ld	%s63,-480(,%fp)
 2154      89003F01 
 2155 2fa8 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 2155      00003E06 
 2156 2fb0 00000000 		and	%s62,%s62,(32)0
 2156      60BE3E44 
 2157 2fb8 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 2157      BE00BE06 
 2158 2fc0 00000000 		st	%s63,0(,%s62)
 2158      BE003F11 
 2159              	# Start of epilogue codes
 2160 2fc8 30000000 		ld	%s18,48(,%fp)
 2160      89001201 
 2161 2fd0 38000000 		ld	%s19,56(,%fp)
 2161      89001301 
 2162 2fd8 40000000 		ld	%s20,64(,%fp)
 2162      89001401 
 2163 2fe0 48000000 		ld	%s21,72(,%fp)
 2163      89001501 
 2164 2fe8 50000000 		ld	%s22,80(,%fp)
 2164      89001601 
 2165 2ff0 58000000 		ld	%s23,88(,%fp)
 2165      89001701 
 2166 2ff8 60000000 		ld	%s24,96(,%fp)
 2166      89001801 
 2167 3000 68000000 		ld	%s25,104(,%fp)
 2167      89001901 
 2168 3008 70000000 		ld	%s26,112(,%fp)
 2168      89001A01 
 2169 3010 78000000 		ld	%s27,120(,%fp)
 2169      89001B01 
 2170 3018 80000000 		ld	%s28,128(,%fp)
 2170      89001C01 
 2171 3020 88000000 		ld	%s29,136(,%fp)
 2171      89001D01 
 2172 3028 90000000 		ld	%s30,144(,%fp)
 2172      89001E01 
 2173 3030 98000000 		ld	%s31,152(,%fp)
 2173      89001F01 
 2174 3038 A0000000 		ld	%s32,160(,%fp)
 2174      89002001 
 2175 3040 A8000000 		ld	%s33,168(,%fp)
 2175      89002101 
 2176 3048 00000000 		or	%sp,0,%fp
 2176      89000B45 
 2177              		.cfi_def_cfa	11,8
 2178 3050 18000000 		ld	%got,0x18(,%sp)
 2178      8B000F01 
 2179 3058 20000000 		ld	%plt,0x20(,%sp)
 2179      8B001001 
 2180 3060 08000000 		ld	%lr,0x8(,%sp)
 2180      8B000A01 
 2181 3068 00000000 		ld	%fp,0x0(,%sp)
 2181      8B000901 
 2182 3070 00000000 		b.l	(,%lr)
 2182      8A000F19 
 2183              	.L5.18:
 2184 3078 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2184      89003F01 
 2185 3080 600D0000 		br.l	.L5.19
 2185      00000F18 
 2186              	.L5.20:
 2187 3088 00000000 		or	%s62,4,(0)1
 2187      00043E45 
 2188 3090 00000000 		st2b	%s62,0(,%s24)
 2188      98003E14 
 2189 3098 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2189      89003F01 
 2190              	# line 1034
1034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(parallel)//;
 2191              		.loc	1 1034 0
 2192 30a0 04000000 		ldl.sx	%s18,4(,%s63)	# *(p).__b_N4conv6desc_tE.mb
 2192      BF001203 
 2193 30a8 00000000 		adds.w.sx	%s33,1,%s33
 2193      A101214A 
 2194 30b0 C8FFFFFF 		brlt.w	%s33,%s18,.L5.18
 2194      92A18218 
 2195 30b8 C0FEFFFF 		br.l	.L5.17
 2195      00000F18 
 2196              	.L5.21:
 2197 30c0 F8FCFFFF 		ld	%s24,-776(,%fp)	# restore 
 2197      89001801 
 2198 30c8 F0FCFFFF 		ld	%s33,-784(,%fp)	# restore 
 2198      89002101 
 2199 30d0 00FDFFFF 		ld	%s23,-768(,%fp)	# restore 
 2199      89001701 
 2200 30d8 E0FCFFFF 		ld	%s29,-800(,%fp)	# restore 
 2200      89001D01 
 2201 30e0 D8FCFFFF 		ld	%s28,-808(,%fp)	# restore 
 2201      89001C01 
 2202 30e8 E8FCFFFF 		ld	%s30,-792(,%fp)	# restore 
 2202      89001E01 
 2203 30f0 98FFFFFF 		br.l	.L5.20
 2203      00000F18 
 2204              	.L5.22:
 2205              	# line 1039
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 2206              		.loc	1 1039 0
 2207 30f8 00000000 		adds.w.sx	%s60,1,%s60
 2207      BC013C4A 
 2208 3100 00000000 		adds.w.sx	%s49,%s50,%s49
 2208      B1B2314A 
 2209 3108 00000000 		adds.w.sx	%s55,%s43,%s55
 2209      B7AB374A 
 2210 3110 00000000 		adds.l	%s42,%s46,%s42
 2210      AAAE2A59 
 2211 3118 280A0000 		brgt.w	0,%s60,.L5.23
 2211      BC008118 
 2212 3120 A0FFFFFF 		br.l	.L5.21
 2212      00000F18 
 2213              	.L5.24:
 2214 3128 28FDFFFF 		ld	%s60,-728(,%fp)	# restore 
 2214      89003C01 
 2215 3130 00000000 		or	%s63,0,%s55
 2215      B7003F45 
 2216 3138 10FDFFFF 		ld	%s50,-752(,%fp)	# restore 
 2216      89003201 
 2217 3140 18FEFFFF 		ld	%s49,-488(,%fp)	# restore 
 2217      89003101 
 2218 3148 10FEFFFF 		ld	%s55,-496(,%fp)	# restore 
 2218      89003701 
 2219 3150 20FDFFFF 		ld	%s46,-736(,%fp)	# restore 
 2219      89002E01 
 2220 3158 18FDFFFF 		ld	%s42,-744(,%fp)	# restore 
 2220      89002A01 
 2221 3160 30FDFFFF 		ld	%s20,-720(,%fp)	# restore 
 2221      89001401 
 2222 3168 90FFFFFF 		br.l	.L5.22
 2222      00000F18 
 2223              	.L5.25:
 2224              	# line 1040
1040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 2225              		.loc	1 1040 0
 2226 3170 00000000 		adds.w.sx	%s60,1,%s60
 2226      BC013C4A 
 2227 3178 00000000 		adds.w.sx	%s59,1,%s59
 2227      BB013B4A 
 2228 3180 40090000 		brgt.w	0,%s60,.L5.26
 2228      BC008118 
 2229 3188 A0FFFFFF 		br.l	.L5.24
 2229      00000F18 
 2230              	.L5.27:
 2231 3190 78FDFFFF 		ld	%s60,-648(,%fp)	# restore 
 2231      89003C01 
 2232 3198 70FDFFFF 		ld	%s59,-656(,%fp)	# restore 
 2232      89003B01 
 2233 31a0 80FDFFFF 		ld	%s19,-640(,%fp)	# restore 
 2233      89001301 
 2234 31a8 40FDFFFF 		ld	%s32,-704(,%fp)	# restore 
 2234      89002001 
 2235 31b0 60FDFFFF 		ld	%s3,-672(,%fp)	# restore 
 2235      89000301 
 2236 31b8 58FDFFFF 		ld	%s2,-680(,%fp)	# restore 
 2236      89000201 
 2237 31c0 50FDFFFF 		ld	%s1,-688(,%fp)	# restore 
 2237      89000101 
 2238 31c8 48FDFFFF 		ld	%s33,-696(,%fp)	# restore 
 2238      89002101 
 2239 31d0 38FDFFFF 		ld	%s31,-712(,%fp)	# restore 
 2239      89001F01 
 2240 31d8 68FDFFFF 		ld	%s53,-664(,%fp)	# restore 
 2240      89003501 
 2241 31e0 90FFFFFF 		br.l	.L5.25
 2241      00000F18 
 2242              	.L5.28:
 2243              	# line 1041
1041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 2244              		.loc	1 1041 0
 2245 31e8 00000000 		adds.w.sx	%s59,1,%s59
 2245      BB013B4A 
 2246 31f0 00000000 		adds.l	%s50,%s56,%s50
 2246      B2B83259 
 2247 31f8 00000000 		adds.l	%s42,%s56,%s42
 2247      AAB82A59 
 2248 3200 00000000 		adds.l	%s40,%s56,%s40
 2248      A8B82859 
 2249 3208 00000000 		adds.l	%s37,%s56,%s37
 2249      A5B82559 
 2250 3210 00000000 		adds.l	%s35,%s36,%s35
 2250      A3A42359 
 2251 3218 00000000 		adds.w.sx	%s7,%s34,%s7
 2251      87A2074A 
 2252 3220 00000000 		adds.w.sx	%s63,1,%s63
 2252      BF013F4A 
 2253 3228 E8070000 		brgt.w	0,%s59,.L5.29
 2253      BB008118 
 2254 3230 60FFFFFF 		br.l	.L5.27
 2254      00000F18 
 2255              	.L5.30:
 2256 3238 D8FDFFFF 		ld	%s59,-552(,%fp)	# restore 
 2256      89003B01 
 2257 3240 00000000 		or	%s4,0,%s34
 2257      A2000445 
 2258 3248 D0FDFFFF 		ld	%s56,-560(,%fp)	# restore 
 2258      89003801 
 2259 3250 A0FDFFFF 		ld	%s50,-608(,%fp)	# restore 
 2259      89003201 
 2260 3258 A8FDFFFF 		ld	%s42,-600(,%fp)	# restore 
 2260      89002A01 
 2261 3260 B0FDFFFF 		ld	%s40,-592(,%fp)	# restore 
 2261      89002801 
 2262 3268 B8FDFFFF 		ld	%s37,-584(,%fp)	# restore 
 2262      89002501 
 2263 3270 C8FDFFFF 		ld	%s36,-568(,%fp)	# restore 
 2263      89002401 
 2264 3278 C0FDFFFF 		ld	%s35,-576(,%fp)	# restore 
 2264      89002301 
 2265 3280 E8FDFFFF 		ld	%s34,-536(,%fp)	# restore 
 2265      89002201 
 2266 3288 E0FDFFFF 		ld	%s63,-544(,%fp)	# restore 
 2266      89003F01 
 2267 3290 F0FDFFFF 		ld	%s18,-528(,%fp)	# restore 
 2267      89001201 
 2268 3298 88FDFFFF 		ld	%s5,-632(,%fp)	# restore 
 2268      89000501 
 2269 32a0 98FDFFFF 		ld	%s62,-616(,%fp)	# restore 
 2269      89003E01 
 2270 32a8 90FDFFFF 		ld	%s61,-624(,%fp)	# restore 
 2270      89003D01 
 2271 32b0 38FFFFFF 		br.l	.L5.28
 2271      00000F18 
 2272              	.L5.16:
 2273              	# line 1042
1042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int khkw = kh*KW+kw;
 2274              		.loc	1 1042 0
 2275 32b8 00000000 		adds.w.sx	%s59,1,%s59
 2275      BB013B4A 
 2276 32c0 00000000 		adds.l	%s63,1,%s63
 2276      BF013F59 
 2277 32c8 00000000 		adds.l	%s56,4,%s56
 2277      B8043859 
 2278 32d0 00000000 		adds.l	%s50,%s52,%s50
 2278      B2B43259 
 2279 32d8 48060000 		brgt.w	0,%s59,.L5.31
 2279      BB008118 
 2280 32e0 58FFFFFF 		br.l	.L5.30
 2280      00000F18 
 2281              	.L5.32:
 2282 32e8 00000000 		or	%s59,0,%s4
 2282      84003B45 
 2283 32f0 00000000 		or	%s63,0,%s3
 2283      83003F45 
 2284 32f8 00000000 		or	%s56,0,%s1
 2284      81003845 
 2285 3300 00000000 		or	%s49,0,%s62
 2285      BE003145 
 2286 3308 B0FFFFFF 		br.l	.L5.16
 2286      00000F18 
 2287              	.L5.33:
 2288              	# line 1066
1051:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp[ic] = 0.f;
1052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int oh = oh_beg; oh < oh_end; ++oh) {
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (int ow = ow_beg; ow < ow_end; ++ow) {
1054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
1055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int ih = oh * SH - PH + kh * (p->dh + 1);
1056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     for (int ic = 0; ic < IC/G; ++ic) {
1058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
1059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       tmp[ic] += ((float*)diff_dst_m)[dst_off] * ((float*)src_m)[src_off];
1060:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     }
1061:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   }
1062:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 }
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 IVDEP() for (int ic = 0; ic < IC/G; ++ic) {
1064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
1065:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   float &dw = ((float*)diff_wei_m)[wei_off];
1066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   dw += tmp[ic];
 2289              		.loc	1 1066 0
 2290 3310 00000000 		ldu	%s61,0(,%s63)	# *(dw)
 2290      BF003D02 
 2291 3318 00000000 		ldu	%s56,0(,%s60)	# *(tmp)
 2291      BC003802 
 2292 3320 00000000 		fadd.s	%s56,%s61,%s56
 2292      B8BDB84C 
 2293 3328 00000000 		stu	%s56,0(,%s63)	# *(dw)
 2293      BF003812 
 2294              	# line 1063
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 2295              		.loc	1 1063 0
 2296 3330 00000000 		adds.w.sx	%s59,1,%s59
 2296      BB013B4A 
 2297 3338 00000000 		adds.l	%s63,%s57,%s63
 2297      BFB93F59 
 2298 3340 00000000 		adds.l	%s60,4,%s60
 2298      BC043C59 
 2299 3348 C8FFFFFF 		brgt.w	0,%s59,.L5.33
 2299      BB008118 
 2300 3350 98FFFFFF 		br.l	.L5.32
 2300      00000F18 
 2301              	.L5.34:
 2302              	# line 1064
1064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   float &dw = ((float*)diff_wei_m)[wei_off];
 2303              		.loc	1 1064 0
 2304 3358 00000000 		divu.l	%s61,%s62,%s58
 2304      BABE3D6F 
 2305 3360 00000000 		or	%s1,0,%s56
 2305      B8000145 
 2306 3368 00000000 		addu.l	%s61,%s61,%s46
 2306      AEBD3D48 
 2307 3370 00000000 		mulu.l	%s61,%s61,%s55
 2307      B7BD3D49 
 2308 3378 00000000 		divu.l	%s61,%s61,%s58
 2308      BABD3D6F 
 2309 3380 00000000 		or	%s61,0,%s61
 2309      BD003D45 
 2310              	# line 1063
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 2311              		.loc	1 1063 0
 2312 3388 00000000 		subs.w.sx	%s18,0,%s18
 2312      9200125A 
 2313 3390 00000000 		or	%s59,0,%s18
 2313      92003B45 
 2314 3398 00000000 		or	%s60,0,%s51
 2314      B3003C45 
 2315 33a0 00000000 		muls.l	%s61,%s61,%s57
 2315      B9BD3D6E 
 2316 33a8 00000000 		adds.l	%s56,%s61,%s56
 2316      B8BD3859 
 2317 33b0 00000000 		adds.l	%s56,%s56,%s53
 2317      B5B83859 
 2318 33b8 00000000 		or	%s63,0,%s56
 2318      B8003F45 
 2319 33c0 50FFFFFF 		br.l	.L5.33
 2319      00000F18 
 2320              	.L5.35:
 2321 33c8 00000000 		divs.w.sx	%s18,%s43,%s54
 2321      B6AB127B 
 2322 33d0 88FFFFFF 		brlt.w	0,%s18,.L5.34
 2322      92008218 
 2323 33d8 80FBFFFF 		br.l	.L5.15
 2323      00000F18 
 2324              	.L5.36:
 2325 33e0 F8FDFFFF 		st	%s53,-520(,%fp)	# spill 
 2325      89003511 
 2326 33e8 00FEFFFF 		st	%s58,-512(,%fp)	# spill 
 2326      89003A11 
 2327 33f0 08FEFFFF 		st	%s62,-504(,%fp)	# spill 
 2327      89003E11 
 2328 33f8 10FEFFFF 		st	%s55,-496(,%fp)	# spill 
 2328      89003711 
 2329 3400 18FEFFFF 		st	%s49,-488(,%fp)	# spill 
 2329      89003111 
 2330 3408 00000000 		or	%s62,0,%s21
 2330      95003E45 
 2331 3410 00000000 		or	%s55,0,%s22
 2331      96003745 
 2332 3418 00000000 		or	%s58,0,%s23
 2332      97003A45 
 2333 3420 00000000 		or	%s57,0,%s24
 2333      98003945 
 2334 3428 00000000 		or	%s6,0,%s35
 2334      A3000645 
 2335 3430 00000000 		or	%s50,0,%s33
 2335      A1003245 
 2336 3438 00000000 		or	%s56,0,%s25
 2336      99003845 
 2337 3440 00000000 		or	%s3,0,%s26
 2337      9A000345 
 2338 3448 00000000 		or	%s42,0,%s27
 2338      9B002A45 
 2339 3450 00000000 		or	%s40,0,%s28
 2339      9C002845 
 2340 3458 00000000 		or	%s37,0,%s29
 2340      9D002545 
 2341 3460 00000000 		or	%s4,0,%s30
 2341      9E000445 
 2342 3468 00000000 		or	%s52,0,%s31
 2342      9F003445 
 2343 3470 00000000 		or	%s7,0,%s34
 2343      A2000745 
 2344 3478 00000000 		or	%s34,0,%s61
 2344      BD002245 
 2345 3480 00000000 		or	%s53,0,%s32
 2345      A0003545 
 2346 3488 40FFFFFF 		br.l	.L5.35
 2346      00000F18 
 2347              	.L5.37:
 2348              	# line 1052
1052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (int ow = ow_beg; ow < ow_end; ++ow) {
 2349              		.loc	1 1052 0
 2350 3490 00000000 		adds.w.sx	%s63,1,%s63
 2350      BF013F4A 
 2351 3498 00000000 		adds.w.sx	%s60,%s61,%s60
 2351      BCBD3C4A 
 2352 34a0 00000000 		adds.w.sx	%s59,1,%s59
 2352      BB013B4A 
 2353 34a8 50020000 		brgt.w	0,%s63,.L5.38
 2353      BF008118 
 2354 34b0 30FFFFFF 		br.l	.L5.36
 2354      00000F18 
 2355              	.L5.39:
 2356 34b8 00000000 		or	%s63,0,%s5
 2356      85003F45 
 2357 34c0 00000000 		or	%s61,0,%s4
 2357      84003D45 
 2358 34c8 00000000 		or	%s60,0,%s7
 2358      87003C45 
 2359 34d0 00000000 		or	%s59,0,%s20
 2359      94003B45 
 2360 34d8 00000000 		or	%s18,0,%s6
 2360      86001245 
 2361 34e0 B0FFFFFF 		br.l	.L5.37
 2361      00000F18 
 2362              	.L5.40:
 2363 34e8 18010000 		br.l	.L5.41
 2363      00000F18 
 2364              	.L5.42:
 2365              	# line 1053
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2366              		.loc	1 1053 0
 2367 34f0 00000000 		adds.w.sx	%s63,1,%s63
 2367      BF013F4A 
 2368 34f8 00000000 		adds.l	%s60,4,%s60
 2368      BC043C59 
 2369 3500 00000000 		adds.l	%s61,%s62,%s61
 2369      BDBE3D59 
 2370 3508 E0FFFFFF 		brgt.w	0,%s63,.L5.40
 2370      BF008118 
 2371 3510 A8FFFFFF 		br.l	.L5.39
 2371      00000F18 
 2372              	.L5.43:
 2373 3518 00000000 		or	%s63,0,%s1
 2373      81003F45 
 2374 3520 00000000 		or	%s62,0,%s2
 2374      82003E45 
 2375 3528 00000000 		or	%s61,0,%s3
 2375      83003D45 
 2376 3530 C0FFFFFF 		br.l	.L5.42
 2376      00000F18 
 2377              	.L5.44:
 2378              	# line 1059
1059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     }
 2379              		.loc	1 1059 0
 2380 3538 00000000 		ldu	%s62,0(,%s63)	# *(tmp)
 2380      BF003E02 
 2381 3540 00000000 		ldu	%s57,0(,%s61)	# float
 2381      BD003902 
 2382 3548 00000000 		ldu	%s56,0(,%s60)	# float
 2382      BC003802 
 2383 3550 00000000 		fmul.s	%s57,%s56,%s57
 2383      B9B8B94D 
 2384 3558 00000000 		fadd.s	%s57,%s62,%s57
 2384      B9BEB94C 
 2385 3560 00000000 		stu	%s57,0(,%s63)	# *(tmp)
 2385      BF003912 
 2386              	# line 1057
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2387              		.loc	1 1057 0
 2388 3568 00000000 		adds.w.sx	%s59,1,%s59
 2388      BB013B4A 
 2389 3570 00000000 		adds.l	%s63,4,%s63
 2389      BF043F59 
 2390 3578 00000000 		adds.l	%s61,%s58,%s61
 2390      BDBA3D59 
 2391 3580 B8FFFFFF 		brgt.w	0,%s59,.L5.44
 2391      BB008118 
 2392 3588 90FFFFFF 		br.l	.L5.43
 2392      00000F18 
 2393              	.L5.45:
 2394              	# line 1058
1058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       tmp[ic] += ((float*)diff_dst_m)[dst_off] * ((float*)src_m)[src_off];
 2395              		.loc	1 1058 0
 2396 3590 00000000 		divs.w.sx	%s57,%s55,%s54
 2396      B6B7397B 
 2397 3598 00000000 		or	%s1,0,%s63
 2397      BF000145 
 2398 35a0 00000000 		or	%s2,0,%s62
 2398      BE000245 
 2399 35a8 00000000 		or	%s3,0,%s61
 2399      BD000345 
 2400 35b0 00000000 		or	%s57,0,%s57
 2400      B9003945 
 2401 35b8 00000000 		addu.l	%s57,%s57,%s53
 2401      B5B93948 
 2402 35c0 00000000 		or	%s57,0,%s57
 2402      B9003945 
 2403 35c8 00000000 		or	%s59,0,%s52
 2403      B4003B45 
 2404 35d0 00000000 		or	%s63,0,%s51
 2404      B3003F45 
 2405              	# line 1057
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2406              		.loc	1 1057 0
 2407 35d8 00000000 		muls.l	%s57,%s57,%s58
 2407      BAB9396E 
 2408 35e0 00000000 		adds.l	%s57,%s61,%s57
 2408      B9BD3959 
 2409 35e8 00000000 		adds.l	%s57,%s57,%s50
 2409      B2B93959 
 2410 35f0 00000000 		or	%s61,0,%s57
 2410      B9003D45 
 2411 35f8 40FFFFFF 		br.l	.L5.44
 2411      00000F18 
 2412              	.L5.41:
 2413 3600 90FFFFFF 		brlt.w	0,%s18,.L5.45
 2413      92008218 
 2414 3608 E8FEFFFF 		br.l	.L5.42
 2414      00000F18 
 2415              	.L5.46:
 2416              	# line 1054
1054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int ih = oh * SH - PH + kh * (p->dh + 1);
 2417              		.loc	1 1054 0
 2418 3610 00000000 		divs.w.sx	%s57,%s49,%s48
 2418      B0B1397B 
 2419 3618 00000000 		or	%s4,0,%s61
 2419      BD000445 
 2420 3620 00000000 		or	%s5,0,%s63
 2420      BF000545 
 2421 3628 00000000 		or	%s6,0,%s18
 2421      92000645 
 2422 3630 00000000 		or	%s7,0,%s60
 2422      BC000745 
 2423 3638 00000000 		or	%s20,0,%s59
 2423      BB001445 
 2424 3640 00000000 		or	%s57,0,%s57
 2424      B9003945 
 2425 3648 00000000 		addu.l	%s57,%s57,%s47
 2425      AFB93948 
 2426 3650 00000000 		addu.l	%s57,%s57,%s46
 2426      AEB93948 
 2427 3658 00000000 		mulu.l	%s57,%s57,%s45
 2427      ADB93949 
 2428 3660 00000000 		or	%s59,0,%s59
 2428      BB003B45 
 2429 3668 00000000 		addu.l	%s59,%s57,%s59
 2429      BBB93B48 
 2430 3670 00000000 		mulu.l	%s59,%s59,%s44
 2430      ACBB3B49 
 2431 3678 00000000 		or	%s59,0,%s59
 2431      BB003B45 
 2432 3680 00000000 		or	%s57,0,%s60
 2432      BC003945 
 2433              	# line 1057
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2434              		.loc	1 1057 0
 2435 3688 00000000 		divs.w.sx	%s56,%s43,%s54
 2435      B6AB387B 
 2436 3690 00000000 		subs.w.sx	%s52,0,%s56
 2436      B800345A 
 2437 3698 00000000 		or	%s37,0,%s18
 2437      92002545 
 2438              	# line 1053
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2439              		.loc	1 1053 0
 2440 36a0 00000000 		adds.w.sx	%s63,%s18,%s42
 2440      AA923F4A 
 2441 36a8 00000000 		muls.l	%s59,4,%s59
 2441      BB043B6E 
 2442 36b0 00000000 		or	%s18,0,%s56
 2442      B8001245 
 2443 36b8 00000000 		muls.l	%s56,4,%s37
 2443      A504386E 
 2444 36c0 00000000 		adds.l	%s59,%s59,%s41
 2444      A9BB3B59 
 2445 36c8 00000000 		adds.l	%s60,%s59,%s56
 2445      B8BB3C59 
 2446 36d0 00000000 		muls.l	%s37,%s37,%s62
 2446      BEA5256E 
 2447 36d8 00000000 		adds.l	%s61,%s37,%s40
 2447      A8A53D59 
 2448              	# line 1057
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2449              		.loc	1 1057 0
 2450 36e0 00000000 		muls.l	%s57,%s57,%s39
 2450      A7B9396E 
 2451 36e8 00000000 		adds.l	%s50,%s57,%s38
 2451      A6B93259 
 2452 36f0 10FFFFFF 		br.l	.L5.41
 2452      00000F18 
 2453              	.L5.38:
 2454 36f8 18FFFFFF 		brlt.w	%s18,%s19,.L5.46
 2454      93928218 
 2455 3700 90FDFFFF 		br.l	.L5.37
 2455      00000F18 
 2456              	.L5.47:
 2457              	# line 1052
1052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (int ow = ow_beg; ow < ow_end; ++ow) {
 2458              		.loc	1 1052 0
 2459 3708 00000000 		subs.w.sx	%s35,0,%s35
 2459      A300235A 
 2460 3710 00000000 		or	%s61,0,%s34
 2460      A2003D45 
 2461 3718 00000000 		adds.w.sx	%s63,%s60,%s35
 2461      A3BC3F4A 
 2462 3720 00000000 		muls.w.sx	%s5,%s60,%s34
 2462      A2BC054B 
 2463 3728 00000000 		or	%s21,0,%s62
 2463      BE001545 
 2464 3730 00000000 		or	%s22,0,%s55
 2464      B7001645 
 2465 3738 00000000 		adds.w.sx	%s60,%s5,%s7
 2465      87853C4A 
 2466              	# line 1053
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2467              		.loc	1 1053 0
 2468 3740 00000000 		subs.w.sx	%s5,0,%s19
 2468      9300055A 
 2469 3748 00000000 		adds.l	%s2,%s50,%s6
 2469      86B20259 
 2470 3750 00000000 		or	%s23,0,%s58
 2470      BA001745 
 2471 3758 00000000 		or	%s24,0,%s57
 2471      B9001845 
 2472 3760 00000000 		or	%s25,0,%s56
 2472      B8001945 
 2473 3768 00000000 		or	%s26,0,%s3
 2473      83001A45 
 2474 3770 00000000 		or	%s27,0,%s42
 2474      AA001B45 
 2475 3778 00000000 		or	%s42,0,%s5
 2475      85002A45 
 2476 3780 00000000 		or	%s28,0,%s40
 2476      A8001C45 
 2477 3788 00000000 		or	%s40,0,%s2
 2477      82002845 
 2478 3790 00000000 		or	%s29,0,%s37
 2478      A5001D45 
 2479 3798 00000000 		or	%s30,0,%s4
 2479      84001E45 
 2480 37a0 00000000 		or	%s31,0,%s52
 2480      B4001F45 
 2481 37a8 00000000 		or	%s32,0,%s53
 2481      B5002045 
 2482 37b0 00000000 		or	%s33,0,%s50
 2482      B2002145 
 2483 37b8 00000000 		or	%s34,0,%s7
 2483      87002245 
 2484 37c0 00000000 		or	%s35,0,%s6
 2484      86002345 
 2485 37c8 18FEFFFF 		ld	%s49,-488(,%fp)	# restore 
 2485      89003101 
 2486 37d0 10FEFFFF 		ld	%s55,-496(,%fp)	# restore 
 2486      89003701 
 2487 37d8 08FEFFFF 		ld	%s62,-504(,%fp)	# restore 
 2487      89003E01 
 2488 37e0 00FEFFFF 		ld	%s58,-512(,%fp)	# restore 
 2488      89003A01 
 2489 37e8 F8FDFFFF 		ld	%s53,-520(,%fp)	# restore 
 2489      89003501 
 2490 37f0 08FFFFFF 		br.l	.L5.38
 2490      00000F18 
 2491              	.L5.12:
 2492 37f8 00000000 		or	%s59,0,%s60
 2492      BC003B45 
 2493 3800 08FFFFFF 		brlt.w	%s60,%s35,.L5.47
 2493      A3BC8218 
 2494 3808 C0FBFFFF 		br.l	.L5.35
 2494      00000F18 
 2495              	.L5.48:
 2496 3810 00000000 		or	%s60,0,%s1
 2496      81003C45 
 2497 3818 00000000 		or	%s56,0,%s2
 2497      82003845 
 2498 3820 00000000 		or	%s62,0,%s49
 2498      B1003E45 
 2499 3828 D0FFFFFF 		br.l	.L5.12
 2499      00000F18 
 2500              	.L5.14:
 2501              	# line 1051
1051:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int oh = oh_beg; oh < oh_end; ++oh) {
 2502              		.loc	1 1051 0
 2503 3830 00000000 		or	%s63,0,(0)1
 2503      00003F45 
 2504 3838 00000000 		lvl	%s61
 2504      00BD00BF 
 2505 3840 0000003F 		vbrdu	%v63,%s63
 2505      00BF808C 
 2506 3848 00000000 		or	%s63,0,%s60
 2506      BC003F45 
 2507 3850 0000003F 		vstu.nc	%v63,4,%s63
 2507      BF040092 
 2508              	# line 1050
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp[ic] = 0.f;
 2509              		.loc	1 1050 0
 2510 3858 00000000 		adds.l	%s60,%s60,%s59
 2510      BBBC3C59 
 2511 3860 00000000 		subs.w.sx	%s56,%s56,%s61
 2511      BDB8385A 
 2512 3868 A8FFFFFF 		brge.w	0,%s56,.L5.48
 2512      B8008518 
 2513 3870 D8F6FFFF 		br.l	.L5.13
 2513      00000F18 
 2514              	.L5.49:
 2515 3878 00000000 		subs.w.sx	%s20,0,%s20
 2515      9400145A 
 2516 3880 00000000 		or	%s1,0,%s60
 2516      BC000145 
 2517 3888 00000000 		subs.w.sx	%s20,0,%s20
 2517      9400145A 
 2518 3890 00000000 		smvl	%s62
 2518      00003E2E 
 2519 3898 80000000 		mins.w.sx	%s61,%s20,%s62
 2519      BE943D78 
 2520 38a0 00000000 		or	%s2,0,%s56
 2520      B8000245 
 2521 38a8 00000000 		or	%s56,0,%s20
 2521      94003845 
 2522 38b0 00000000 		or	%s60,0,%s51
 2522      B3003C45 
 2523 38b8 00000000 		or	%s62,0,%s61
 2523      BD003E45 
 2524 38c0 00000000 		muls.l	%s62,4,%s62
 2524      BE043E6E 
 2525 38c8 00000000 		or	%s3,0,%s63
 2525      BF000345 
 2526 38d0 00000000 		or	%s4,0,%s59
 2526      BB000445 
 2527 38d8 00000000 		or	%s59,0,%s62
 2527      BE003B45 
 2528 38e0 50FFFFFF 		br.l	.L5.14
 2528      00000F18 
 2529              	.L5.50:
 2530              	# line 1046
1046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int oh_end = ohe[khkw];
 2531              		.loc	1 1046 0
 2532 38e8 00000000 		ldl.sx	%s60,0(%s56,%s42)	# *(ohb)
 2532      AAB83C03 
 2533              	# line 1047
1047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int ow_beg = owb[khkw];
 2534              		.loc	1 1047 0
 2535 38f0 00000000 		ldl.sx	%s35,0(%s56,%s40)	# *(ohe)
 2535      A8B82303 
 2536              	# line 1048
1048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int ow_end = owe[khkw];
 2537              		.loc	1 1048 0
 2538 38f8 00000000 		ldl.sx	%s18,0(%s56,%s37)	# *(owb)
 2538      A5B81203 
 2539              	# line 1049
1049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int ic = 0; ic < IC/G; ++ic)
 2540              		.loc	1 1049 0
 2541 3900 00000000 		ldl.sx	%s19,0(%s56,%s36)	# *(owe)
 2541      A4B81303 
 2542              	# line 1050
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp[ic] = 0.f;
 2543              		.loc	1 1050 0
 2544 3908 00000000 		divs.w.sx	%s20,%s43,%s54
 2544      B6AB147B 
 2545 3910 68FFFFFF 		brlt.w	0,%s20,.L5.49
 2545      94008218 
 2546 3918 10F6FFFF 		br.l	.L5.11
 2546      00000F18 
 2547              	.L5.31:
 2548              	# line 1044
1044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               {
 2549              		.loc	1 1044 0
 2550 3920 00000000 		ld1b.sx	%s60,0(,%s63)	# *(ook)
 2550      BF003C05 
 2551 3928 00000000 		or	%s60,0,%s60
 2551      BC003C45 
 2552 3930 B8FFFFFF 		brne.w	0,%s60,.L5.50
 2552      BC008318 
 2553 3938 80F9FFFF 		br.l	.L5.16
 2553      00000F18 
 2554              	.L5.51:
 2555 3940 F0FDFFFF 		st	%s18,-528(,%fp)	# spill 
 2555      89001211 
 2556 3948 E8FDFFFF 		st	%s34,-536(,%fp)	# spill 
 2556      89002211 
 2557 3950 E0FDFFFF 		st	%s63,-544(,%fp)	# spill 
 2557      89003F11 
 2558 3958 D8FDFFFF 		st	%s59,-552(,%fp)	# spill 
 2558      89003B11 
 2559 3960 D0FDFFFF 		st	%s56,-560(,%fp)	# spill 
 2559      89003811 
 2560 3968 C8FDFFFF 		st	%s36,-568(,%fp)	# spill 
 2560      89002411 
 2561 3970 C0FDFFFF 		st	%s35,-576(,%fp)	# spill 
 2561      89002311 
 2562 3978 B8FDFFFF 		st	%s37,-584(,%fp)	# spill 
 2562      89002511 
 2563 3980 B0FDFFFF 		st	%s40,-592(,%fp)	# spill 
 2563      89002811 
 2564 3988 A8FDFFFF 		st	%s42,-600(,%fp)	# spill 
 2564      89002A11 
 2565 3990 A0FDFFFF 		st	%s50,-608(,%fp)	# spill 
 2565      89003211 
 2566 3998 98FDFFFF 		st	%s62,-616(,%fp)	# spill 
 2566      89003E11 
 2567 39a0 90FDFFFF 		st	%s61,-624(,%fp)	# spill 
 2567      89003D11 
 2568 39a8 88FDFFFF 		st	%s5,-632(,%fp)	# spill 
 2568      89000511 
 2569 39b0 00000000 		or	%s42,0,%s50
 2569      B2002A45 
 2570 39b8 A8FDFFFF 		ld	%s40,-600(,%fp)	# restore 
 2570      89002801 
 2571 39c0 B0FDFFFF 		ld	%s37,-592(,%fp)	# restore 
 2571      89002501 
 2572 39c8 B8FDFFFF 		ld	%s36,-584(,%fp)	# restore 
 2572      89002401 
 2573 39d0 00000000 		or	%s59,0,%s62
 2573      BE003B45 
 2574 39d8 00000000 		or	%s63,0,%s35
 2574      A3003F45 
 2575              	# line 1042
1042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int khkw = kh*KW+kw;
 2576              		.loc	1 1042 0
 2577 39e0 00000000 		or	%s56,0,(0)1
 2577      00003845 
 2578 39e8 00000000 		or	%s50,0,(0)1
 2578      00003245 
 2579              	# line 1063
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 2580              		.loc	1 1063 0
 2581 39f0 00000000 		muls.l	%s61,%s60,%s61
 2581      BDBC3D6E 
 2582 39f8 00000000 		adds.l	%s53,%s61,%s5
 2582      85BD3559 
 2583 3a00 00000000 		or	%s34,0,%s4
 2583      84002245 
 2584 3a08 18FFFFFF 		br.l	.L5.31
 2584      00000F18 
 2585              	.L5.29:
 2586 3a10 00000000 		or	%s60,0,%s63
 2586      BF003C45 
 2587 3a18 28FFFFFF 		brlt.w	0,%s18,.L5.51
 2587      92008218 
 2588 3a20 C8F7FFFF 		br.l	.L5.28
 2588      00000F18 
 2589              	.L5.52:
 2590 3a28 80FDFFFF 		st	%s19,-640(,%fp)	# spill 
 2590      89001311 
 2591 3a30 78FDFFFF 		st	%s60,-648(,%fp)	# spill 
 2591      89003C11 
 2592 3a38 70FDFFFF 		st	%s59,-656(,%fp)	# spill 
 2592      89003B11 
 2593 3a40 68FDFFFF 		st	%s53,-664(,%fp)	# spill 
 2593      89003511 
 2594 3a48 60FDFFFF 		st	%s3,-672(,%fp)	# spill 
 2594      89000311 
 2595 3a50 58FDFFFF 		st	%s2,-680(,%fp)	# spill 
 2595      89000211 
 2596 3a58 50FDFFFF 		st	%s1,-688(,%fp)	# spill 
 2596      89000111 
 2597 3a60 48FDFFFF 		st	%s33,-696(,%fp)	# spill 
 2597      89002111 
 2598 3a68 40FDFFFF 		st	%s32,-704(,%fp)	# spill 
 2598      89002011 
 2599 3a70 38FDFFFF 		st	%s31,-712(,%fp)	# spill 
 2599      89001F11 
 2600 3a78 00000000 		or	%s46,0,%s59
 2600      BB002E45 
 2601 3a80 00000000 		or	%s59,0,%s53
 2601      B5003B45 
 2602 3a88 00000000 		or	%s50,0,%s3
 2602      83003245 
 2603 3a90 00000000 		or	%s42,0,%s2
 2603      82002A45 
 2604 3a98 00000000 		or	%s40,0,%s1
 2604      81002845 
 2605 3aa0 00000000 		or	%s37,0,%s33
 2605      A1002545 
 2606 3aa8 00000000 		or	%s35,0,%s32
 2606      A0002345 
 2607 3ab0 00000000 		or	%s7,0,%s31
 2607      9F000745 
 2608 3ab8 58FFFFFF 		br.l	.L5.29
 2608      00000F18 
 2609              	.L5.26:
 2610              	# line 1041
1041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 2611              		.loc	1 1041 0
 2612 3ac0 00000000 		or	%s63,0,(0)1
 2612      00003F45 
 2613 3ac8 60FFFFFF 		brlt.w	0,%s19,.L5.52
 2613      93008218 
 2614 3ad0 A0F6FFFF 		br.l	.L5.25
 2614      00000F18 
 2615              	.L5.53:
 2616 3ad8 30FDFFFF 		st	%s20,-720(,%fp)	# spill 
 2616      89001411 
 2617 3ae0 10FEFFFF 		st	%s55,-496(,%fp)	# spill 
 2617      89003711 
 2618 3ae8 18FEFFFF 		st	%s49,-488(,%fp)	# spill 
 2618      89003111 
 2619 3af0 28FDFFFF 		st	%s60,-728(,%fp)	# spill 
 2619      89003C11 
 2620 3af8 20FDFFFF 		st	%s46,-736(,%fp)	# spill 
 2620      89002E11 
 2621 3b00 18FDFFFF 		st	%s42,-744(,%fp)	# spill 
 2621      89002A11 
 2622 3b08 10FDFFFF 		st	%s50,-752(,%fp)	# spill 
 2622      89003211 
 2623              	# line 1040
1040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 2624              		.loc	1 1040 0
 2625 3b10 00000000 		divs.w.sx	%s50,%s50,%s48
 2625      B0B2327B 
 2626 3b18 00000000 		subs.w.sx	%s50,0,%s50
 2626      B200325A 
 2627 3b20 00000000 		or	%s60,0,%s50
 2627      B2003C45 
 2628 3b28 00000000 		or	%s49,0,%s42
 2628      AA003145 
 2629 3b30 00000000 		or	%s55,0,%s63
 2629      BF003745 
 2630 3b38 88FFFFFF 		br.l	.L5.26
 2630      00000F18 
 2631              	.L5.23:
 2632 3b40 00000000 		or	%s59,0,(0)1
 2632      00003B45 
 2633 3b48 90FFFFFF 		brlt.w	0,%s20,.L5.53
 2633      94008218 
 2634 3b50 A8F5FFFF 		br.l	.L5.22
 2634      00000F18 
 2635              	.L5.54:
 2636 3b58 00FDFFFF 		st	%s23,-768(,%fp)	# spill 
 2636      89001711 
 2637 3b60 F8FCFFFF 		st	%s24,-776(,%fp)	# spill 
 2637      89001811 
 2638 3b68 F0FCFFFF 		st	%s33,-784(,%fp)	# spill 
 2638      89002111 
 2639 3b70 E8FCFFFF 		st	%s30,-792(,%fp)	# spill 
 2639      89001E11 
 2640 3b78 E0FCFFFF 		st	%s29,-800(,%fp)	# spill 
 2640      89001D11 
 2641 3b80 D8FCFFFF 		st	%s28,-808(,%fp)	# spill 
 2641      89001C11 
 2642 3b88 08FDFFFF 		ld	%s59,-760(,%fp)	# restore 
 2642      89003B01 
 2643 3b90 14000000 		dldl.sx	%s50,20(,%s59)	# *(p).__b_N4conv6desc_tE.oc
 2643      BB00320B 
 2644 3b98 00000000 		or	%s40,0,%s50
 2644      B2002845 
 2645              	# line 1039
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 2646              		.loc	1 1039 0
 2647 3ba0 00000000 		or	%s42,0,(0)1
 2647      00002A45 
 2648              	# line 1040
1040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 2649              		.loc	1 1040 0
 2650 3ba8 00000000 		divs.w.sx	%s20,%s50,%s48
 2650      B0B2147B 
 2651              	# line 1039
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 2652              		.loc	1 1039 0
 2653 3bb0 00000000 		subs.w.sx	%s37,0,%s48
 2653      B000255A 
 2654 3bb8 00000000 		or	%s60,0,%s37
 2654      A5003C45 
 2655              	# line 1041
1041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 2656              		.loc	1 1041 0
 2657 3bc0 20000000 		dldl.sx	%s19,32(,%s59)	# *(p).__b_N4conv6desc_tE.kh
 2657      BB00130B 
 2658 3bc8 00000000 		subs.w.sx	%s53,0,%s19
 2658      9300355A 
 2659              	# line 1042
1042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int khkw = kh*KW+kw;
 2660              		.loc	1 1042 0
 2661 3bd0 24000000 		dldl.sx	%s18,36(,%s59)	# *(p).__b_N4conv6desc_tE.kw
 2661      BB00120B 
 2662 3bd8 00000000 		or	%s36,0,%s18
 2662      92002445 
 2663 3be0 00000000 		subs.w.sx	%s62,0,%s18
 2663      92003E5A 
 2664              	# line 1044
1044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               {
 2665              		.loc	1 1044 0
 2666 3be8 E8FFFFFF 		dld	%s32,-24(,%fp)	# ook
 2666      89002009 
 2667              	# line 1046
1046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int oh_end = ohe[khkw];
 2668              		.loc	1 1046 0
 2669 3bf0 C8FFFFFF 		dld	%s3,-56(,%fp)	# ohb
 2669      89000309 
 2670              	# line 1047
1047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int ow_beg = owb[khkw];
 2671              		.loc	1 1047 0
 2672 3bf8 D0FFFFFF 		dld	%s2,-48(,%fp)	# ohe
 2672      89000209 
 2673              	# line 1048
1048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 const int ow_end = owe[khkw];
 2674              		.loc	1 1048 0
 2675 3c00 D8FFFFFF 		dld	%s1,-40(,%fp)	# owb
 2675      89000109 
 2676              	# line 1049
1049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                 for (int ic = 0; ic < IC/G; ++ic)
 2677              		.loc	1 1049 0
 2678 3c08 E0FFFFFF 		dld	%s37,-32(,%fp)	# owe
 2678      89002509 
 2679              	# line 1050
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp[ic] = 0.f;
 2680              		.loc	1 1050 0
 2681 3c10 08000000 		dldl.sx	%s43,8(,%s59)	# *(p).__b_N4conv6desc_tE.ic
 2681      BB002B0B 
 2682 3c18 00000000 		or	%s63,0,%s43
 2682      AB003F45 
 2683              	# line 1041
1041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 2684              		.loc	1 1041 0
 2685 3c20 00000000 		muls.l	%s56,4,%s36
 2685      A404386E 
 2686              	# line 1050
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   tmp[ic] = 0.f;
 2687              		.loc	1 1050 0
 2688 3c28 00000000 		dldl.sx	%s54,0(,%s59)	# *(p).__b_N4conv6desc_tE.g
 2688      BB00360B 
 2689 3c30 00000000 		or	%s58,0,%s54
 2689      B6003A45 
 2690 3c38 00000000 		or	%s35,0,%s33
 2690      A1002345 
 2691              	# line 1054
1054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int ih = oh * SH - PH + kh * (p->dh + 1);
 2692              		.loc	1 1054 0
 2693 3c40 00000000 		mulu.l	%s47,%s35,%s40
 2693      A8A32F49 
 2694 3c48 00000000 		or	%s33,0,%s37
 2694      A5002145 
 2695              	# line 1058
1058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       tmp[ic] += ((float*)diff_dst_m)[dst_off] * ((float*)src_m)[src_off];
 2696              		.loc	1 1058 0
 2697 3c50 00000000 		mulu.l	%s35,%s35,%s63
 2697      BFA32349 
 2698              	# line 1054
1054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int ih = oh * SH - PH + kh * (p->dh + 1);
 2699              		.loc	1 1054 0
 2700 3c58 18000000 		dldl.sx	%s40,24(,%s59)	# *(p).__b_N4conv6desc_tE.oh
 2700      BB00280B 
 2701 3c60 F8FDFFFF 		st	%s35,-520(,%fp)	# spill 
 2701      89002311 
 2702 3c68 00000000 		or	%s45,0,%s40
 2702      A8002D45 
 2703 3c70 1C000000 		dldl.sx	%s40,28(,%s59)	# *(p).__b_N4conv6desc_tE.ow
 2703      BB00280B 
 2704 3c78 00000000 		or	%s44,0,%s40
 2704      A8002C45 
 2705              	# line 1055
1055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 2706              		.loc	1 1055 0
 2707 3c80 28000000 		dldl.sx	%s4,40(,%s59)	# *(p).__b_N4conv6desc_tE.sh
 2707      BB00040B 
 2708 3c88 30000000 		dldl.sx	%s40,48(,%s59)	# *(p).__b_N4conv6desc_tE.ph
 2708      BB00280B 
 2709              	# line 1052
1052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   for (int ow = ow_beg; ow < ow_end; ++ow) {
 2710              		.loc	1 1052 0
 2711 3c90 00000000 		subs.w.sx	%s31,0,%s40
 2711      A8001F5A 
 2712              	# line 1055
1055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 2713              		.loc	1 1055 0
 2714 3c98 38000000 		dldl.sx	%s40,56(,%s59)	# *(p).__b_N4conv6desc_tE.dh
 2714      BB00280B 
 2715 3ca0 00000000 		adds.w.sx	%s34,1,%s40
 2715      A801224A 
 2716              	# line 1056
1056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     for (int ic = 0; ic < IC/G; ++ic) {
 2717              		.loc	1 1056 0
 2718 3ca8 2C000000 		dldl.sx	%s40,44(,%s59)	# *(p).__b_N4conv6desc_tE.sw
 2718      BB00280B 
 2719 3cb0 00000000 		or	%s40,0,%s40
 2719      A8002845 
 2720              	# line 1053
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2721              		.loc	1 1053 0
 2722 3cb8 00000000 		muls.l	%s40,4,%s40
 2722      A804286E 
 2723              	# line 1056
1056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     for (int ic = 0; ic < IC/G; ++ic) {
 2724              		.loc	1 1056 0
 2725 3cc0 34000000 		dldl.sx	%s37,52(,%s59)	# *(p).__b_N4conv6desc_tE.pw
 2725      BB00250B 
 2726 3cc8 08FEFFFF 		st	%s40,-504(,%fp)	# spill 
 2726      89002811 
 2727 3cd0 00000000 		or	%s37,0,%s37
 2727      A5002545 
 2728 3cd8 3C000000 		dldl.sx	%s40,60(,%s59)	# *(p).__b_N4conv6desc_tE.dw
 2728      BB00280B 
 2729 3ce0 00000000 		adds.w.sx	%s40,1,%s40
 2729      A801284A 
 2730 3ce8 00000000 		or	%s40,0,%s40
 2730      A8002845 
 2731              	# line 1042
1042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****               const int khkw = kh*KW+kw;
 2732              		.loc	1 1042 0
 2733 3cf0 00000000 		muls.l	%s52,4,%s40
 2733      A804346E 
 2734              	# line 1058
1058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       tmp[ic] += ((float*)diff_dst_m)[dst_off] * ((float*)src_m)[src_off];
 2735              		.loc	1 1058 0
 2736 3cf8 0C000000 		dldl.sx	%s40,12(,%s59)	# *(p).__b_N4conv6desc_tE.ih
 2736      BB00280B 
 2737 3d00 00000000 		or	%s40,0,%s40
 2737      A8002845 
 2738 3d08 00000000 		or	%s40,0,%s40
 2738      A8002845 
 2739 3d10 10000000 		dldl.sx	%s35,16(,%s59)	# *(p).__b_N4conv6desc_tE.iw
 2739      BB00230B 
 2740 3d18 00000000 		or	%s35,0,%s35
 2740      A3002345 
 2741 3d20 00000000 		or	%s35,0,%s35
 2741      A3002345 
 2742              	# line 1057
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2743              		.loc	1 1057 0
 2744 3d28 00000000 		muls.l	%s40,%s40,%s35
 2744      A3A8286E 
 2745 3d30 00000000 		muls.l	%s40,4,%s40
 2745      A804286E 
 2746 3d38 00000000 		muls.l	%s39,4,%s35
 2746      A304276E 
 2747 3d40 00FEFFFF 		st	%s40,-512(,%fp)	# spill 
 2747      89002811 
 2748              	# line 1059
1059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     }
 2749              		.loc	1 1059 0
 2750 3d48 A8010000 		dld	%s41,424(,%s30)	# *(diff_dst_m).data_
 2750      9E002909 
 2751 3d50 A8010000 		dld	%s38,424(,%s29)	# *(src_m).data_
 2751      9D002609 
 2752              	# line 1064
1064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   float &dw = ((float*)diff_wei_m)[wei_off];
 2753              		.loc	1 1064 0
 2754 3d58 14000000 		dldl.sx	%s40,20(,%s59)	# *(p).__b_N4conv6desc_tE.oc
 2754      BB00280B 
 2755 3d60 00000000 		or	%s40,0,%s40
 2755      A8002845 
 2756 3d68 00000000 		or	%s46,0,%s40
 2756      A8002E45 
 2757 3d70 20000000 		dldl.sx	%s40,32(,%s59)	# *(p).__b_N4conv6desc_tE.kh
 2757      BB00280B 
 2758 3d78 00000000 		or	%s40,0,%s40
 2758      A8002845 
 2759 3d80 00000000 		or	%s40,0,%s40
 2759      A8002845 
 2760 3d88 24000000 		dldl.sx	%s59,36(,%s59)	# *(p).__b_N4conv6desc_tE.kw
 2760      BB003B0B 
 2761 3d90 00000000 		or	%s59,0,%s59
 2761      BB003B45 
 2762 3d98 00000000 		or	%s59,0,%s59
 2762      BB003B45 
 2763              	# line 1063
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 2764              		.loc	1 1063 0
 2765 3da0 00000000 		muls.l	%s40,%s40,%s59
 2765      BBA8286E 
 2766 3da8 00000000 		muls.l	%s57,4,%s40
 2766      A804396E 
 2767 3db0 00000000 		muls.l	%s61,4,%s59
 2767      BB043D6E 
 2768              	# line 1065
1065:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                   dw += tmp[ic];
 2769              		.loc	1 1065 0
 2770 3db8 A8010000 		dld	%s5,424(,%s28)	# *(diff_wei_m).data_
 2770      9C000509 
 2771              	# line 1039
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 2772              		.loc	1 1039 0
 2773 3dc0 00000000 		or	%s49,0,(0)1
 2773      00003145 
 2774 3dc8 00000000 		or	%s55,0,(0)1
 2774      00003745 
 2775              	# line 1053
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2776              		.loc	1 1053 0
 2777 3dd0 00000000 		muls.l	%s6,-4,%s37
 2777      A57C066E 
 2778 3dd8 68FDFFFF 		br.l	.L5.23
 2778      00000F18 
 2779              	.L5.19:
 2780 3de0 08FDFFFF 		st	%s63,-760(,%fp)	# spill 
 2780      89003F11 
 2781              	# line 1037
1037:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(for collapse(4))//;
 2782              		.loc	1 1037 0
 2783 3de8 08000000 		ldl.sx	%s62,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 2783      BF003E03 
 2784 3df0 00000000 		ldl.sx	%s61,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2784      BF003D03 
 2785 3df8 00000000 		divs.w.sx	%s61,%s62,%s61
 2785      BDBE3D7B 
 2786 3e00 00000000 		or	%s61,0,%s61
 2786      BD003D45 
 2787 3e08 00000000 		muls.l	%s0,4,%s61
 2787      BD04006E 
 2788 3e10 00000000 		lea	%s12,__grow_stack@LO
 2788      00000C06 
 2789 3e18 00000000 		and	%s12,%s12,(32)0
 2789      608C0C44 
 2790 3e20 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2790      8C008C06 
 2791 3e28 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2791      8C000A08 
 2792 3e30 D0000000 		lea	%s62,208
 2792      00003E06 
 2793 3e38 00000000 		adds.l	%s62,%sp,%s62
 2793      BE8B3E59 
 2794 3e40 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2794      89003F01 
 2795 3e48 00000000 		st	%s62,0(,%s23)
 2795      97003E11 
 2796 3e50 F0FFFFFF 		ld	%s51,-16(,%fp)	# tmp
 2796      89003301 
 2797 3e58 C0FFFFFF 		lea	%s62,-64
 2797      00003E06 
 2798 3e60 00000000 		st	%s51,0(%s62,%fp)
 2798      89BE3311 
 2799 3e68 00000000 		or	%s62,5,(0)1
 2799      00053E45 
 2800 3e70 00000000 		st2b	%s62,0(,%s24)
 2800      98003E14 
 2801              	# line 1039
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 2802              		.loc	1 1039 0
 2803 3e78 00000000 		ldl.sx	%s48,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2803      BF003003 
 2804 3e80 D8FCFFFF 		brlt.w	0,%s48,.L5.54
 2804      B0008218 
 2805 3e88 00F2FFFF 		br.l	.L5.20
 2805      00000F18 
 2806              	.L5.55:
 2807              	# line 1037
1037:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       OMP(for collapse(4))//;
 2808              		.loc	1 1037 0
 2809 3e90 00000000 		adds.l	%s23,%fp,(60)1
 2809      3C891759 
 2810 3e98 00000000 		lea	%s24,__eh_curr_region@LO
 2810      00001806 
 2811 3ea0 00000000 		and	%s24,%s24,(32)0
 2811      60981844 
 2812 3ea8 00000000 		lea.sl	%s24,__eh_curr_region@HI(,%s24)
 2812      98009806 
 2813 3eb0 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2813      89003F01 
 2814 3eb8 E0FCFFFF 		ld	%s29,-800(,%fp)	# restore 
 2814      89001D01 
 2815 3ec0 D8FCFFFF 		ld	%s28,-808(,%fp)	# restore 
 2815      89001C01 
 2816 3ec8 E8FCFFFF 		ld	%s30,-792(,%fp)	# restore 
 2816      89001E01 
 2817 3ed0 10FFFFFF 		br.l	.L5.19
 2817      00000F18 
 2818              	.L5.56:
 2819              	# line 1034
1034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     OMP(parallel)//;
 2820              		.loc	1 1034 0
 2821 3ed8 00000000 		or	%s33,0,(0)1
 2821      00002145 
 2822 3ee0 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 2822      89003F01 
 2823 3ee8 04000000 		ldl.sx	%s18,4(,%s63)	# *(p).__b_N4conv6desc_tE.mb
 2823      BF001203 
 2824 3ef0 A0FFFFFF 		brlt.w	0,%s18,.L5.55
 2824      92008218 
 2825 3ef8 80F0FFFF 		br.l	.L5.17
 2825      00000F18 
 2826              	.L5.57:
 2827 3f00 08FDFFFF 		st	%s63,-760(,%fp)	# spill 
 2827      89003F11 
 2828 3f08 D0FFFFFF 		br.l	.L5.56
 2828      00000F18 
 2829              	.L5.58:
 2830              	# line 1015
1015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 2831              		.loc	1 1015 0
 2832 3f10 20000000 		ldl.sx	%s18,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 2832      BF001203 
 2833 3f18 00000000 		adds.w.sx	%s61,1,%s61
 2833      BD013D4A 
 2834 3f20 18040000 		brlt.w	%s61,%s18,.L5.59
 2834      92BD8218 
 2835 3f28 D8FFFFFF 		br.l	.L5.57
 2835      00000F18 
 2836              	.L5.60:
 2837 3f30 00000000 		or	%s1,0,%s60
 2837      BC000145 
 2838 3f38 88030000 		br.l	.L5.61
 2838      00000F18 
 2839              	.L5.10:
 2840 3f40 38000000 		lea	%s59,56
 2840      00003B06 
 2841              	# line 1031
1031:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 2842              		.loc	1 1031 0
 2843 3f48 00000000 		sll	%s62,%s62,%s59
 2843      BEBB3E65 
 2844 3f50 38000000 		lea	%s59,56
 2844      00003B06 
 2845 3f58 00000000 		sra.l	%s62,%s62,%s59
 2845      BEBB3E77 
 2846 3f60 00000000 		or	%s58,0,%s58
 2846      BA003A45 
 2847 3f68 00000000 		st1b	%s62,0(%s58,%s57)	# *(ook)
 2847      B9BA3E15 
 2848              	# line 1016
1016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 2849              		.loc	1 1016 0
 2850 3f70 24000000 		ldl.sx	%s18,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2850      BF001203 
 2851 3f78 00000000 		adds.w.sx	%s60,1,%s60
 2851      BC013C4A 
 2852 3f80 B0FFFFFF 		brlt.w	%s60,%s18,.L5.60
 2852      92BC8218 
 2853 3f88 88FFFFFF 		br.l	.L5.58
 2853      00000F18 
 2854              	.L5.62:
 2855              	# line 1031
1031:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     }
 2856              		.loc	1 1031 0
 2857 3f90 00000000 		or	%s59,1,(0)1
 2857      00013B45 
 2858 3f98 00000000 		or	%s58,0,%s62
 2858      BE003A45 
 2859 3fa0 00000000 		or	%s57,0,%s51
 2859      B3003945 
 2860 3fa8 00000000 		or	%s62,0,%s59
 2860      BB003E45 
 2861 3fb0 90FFFFFF 		br.l	.L5.10
 2861      00000F18 
 2862              	.L5.63:
 2863 3fb8 D8FFFFFF 		brlt.w	%s59,%s57,.L5.62
 2863      B9BB8218 
 2864 3fc0 40EFFFFF 		br.l	.L5.9
 2864      00000F18 
 2865              	.L5.64:
 2866              	# line 1026
1026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ohb[khkw] = oh_beg;
 2867              		.loc	1 1026 0
 2868 3fc8 24000000 		ldl.sx	%s62,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 2868      BF003E03 
 2869 3fd0 00000000 		muls.w.sx	%s62,%s62,%s61
 2869      BDBE3E4B 
 2870 3fd8 00000000 		adds.w.sx	%s62,%s62,%s60
 2870      BCBE3E4A 
 2871 3fe0 00000000 		or	%s52,0,%s62
 2871      BE003445 
 2872              	# line 1027
1027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owb[khkw] = ow_beg;
 2873              		.loc	1 1027 0
 2874 3fe8 00000000 		muls.l	%s52,4,%s52
 2874      B404346E 
 2875 3ff0 00000000 		stl	%s19,0(%s52,%s56)	# *(ohb)
 2875      B8B41313 
 2876              	# line 1028
1028:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ohe[khkw] = oh_end;
 2877              		.loc	1 1028 0
 2878 3ff8 00000000 		stl	%s59,0(%s52,%s55)	# *(owb)
 2878      B7B43B13 
 2879              	# line 1029
1029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owe[khkw] = ow_end;
 2880              		.loc	1 1029 0
 2881 4000 00000000 		stl	%s58,0(%s52,%s54)	# *(ohe)
 2881      B6B43A13 
 2882              	# line 1030
1030:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
 2883              		.loc	1 1030 0
 2884 4008 00000000 		stl	%s57,0(%s52,%s53)	# *(owe)
 2884      B5B43913 
 2885 4010 A8FFFFFF 		brlt.w	%s19,%s58,.L5.63
 2885      BA938218 
 2886 4018 E8EEFFFF 		br.l	.L5.9
 2886      00000F18 
 2887              	.L5.65:
 2888 4020 00000000 		or	%s57,0,%s18
 2888      92003945 
 2889 4028 A0FFFFFF 		br.l	.L5.64
 2889      00000F18 
 2890              	.L5.66:
 2891              	# line 1025
1025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       const int khkw = kh*KW+kw;
 2892              		.loc	1 1025 0
 2893 4030 1C000000 		ldl.sx	%s18,28(,%s63)	# *(p).__b_N4conv6desc_tE.ow
 2893      BF001203 
 2894 4038 E8FFFFFF 		brgt.w	%s57,%s18,.L5.65
 2894      92B98118 
 2895 4040 88FFFFFF 		br.l	.L5.64
 2895      00000F18 
 2896              	.L5.67:
 2897 4048 00000000 		or	%s58,0,%s18
 2897      92003A45 
 2898 4050 E0FFFFFF 		br.l	.L5.66
 2898      00000F18 
 2899              	.L5.68:
 2900              	# line 1024
1024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_end > OW) ow_end = OW;
 2901              		.loc	1 1024 0
 2902 4058 18000000 		ldl.sx	%s18,24(,%s63)	# *(p).__b_N4conv6desc_tE.oh
 2902      BF001203 
 2903 4060 E8FFFFFF 		brgt.w	%s58,%s18,.L5.67
 2903      92BA8118 
 2904 4068 C8FFFFFF 		br.l	.L5.66
 2904      00000F18 
 2905              	.L5.69:
 2906              	# line 1023
1023:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (oh_end > OH) oh_end = OH;
 2907              		.loc	1 1023 0
 2908 4070 00000000 		or	%s59,0,(0)1
 2908      00003B45 
 2909 4078 00000000 		or	%s55,0,%s52
 2909      B4003745 
 2910 4080 00000000 		or	%s19,0,%s62
 2910      BE001345 
 2911 4088 D0FFFFFF 		br.l	.L5.68
 2911      00000F18 
 2912              	.L5.70:
 2913 4090 E0FFFFFF 		brgt.w	0,%s59,.L5.69
 2913      BB008118 
 2914 4098 00000000 		or	%s19,0,%s62
 2914      BE001345 
 2915 40a0 00000000 		or	%s55,0,%s52
 2915      B4003745 
 2916 40a8 B0FFFFFF 		br.l	.L5.68
 2916      00000F18 
 2917              	.L5.71:
 2918              	# line 1022
1022:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (ow_beg < 0 ) ow_beg = 0;
 2919              		.loc	1 1022 0
 2920 40b0 00000000 		or	%s62,0,(0)1
 2920      00003E45 
 2921 40b8 D8FFFFFF 		br.l	.L5.70
 2921      00000F18 
 2922              	.L5.8:
 2923              	# line 1021
1021:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (oh_beg < 0 ) oh_beg = 0;
 2924              		.loc	1 1021 0
 2925 40c0 00000000 		subs.w.sx	%s57,%s55,%s57
 2925      B9B7395A 
 2926 40c8 E8FFFFFF 		brgt.w	0,%s62,.L5.71
 2926      BE008118 
 2927 40d0 C0FFFFFF 		br.l	.L5.70
 2927      00000F18 
 2928              	.L5.72:
 2929 40d8 00000000 		or	%s57,1,(0)1
 2929      00013945 
 2930 40e0 00000000 		or	%s56,0,%s2
 2930      82003845 
 2931 40e8 00000000 		or	%s52,0,%s3
 2931      83003445 
 2932 40f0 00000000 		or	%s51,0,%s1
 2932      81003345 
 2933 40f8 C8FFFFFF 		br.l	.L5.8
 2933      00000F18 
 2934              	.L5.6:
 2935              	# line 1020
1020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 2936              		.loc	1 1020 0
 2937 4100 00000000 		subs.w.sx	%s58,%s56,%s58
 2937      BAB83A5A 
 2938              	# line 1021
1021:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       if (oh_beg < 0 ) oh_beg = 0;
 2939              		.loc	1 1021 0
 2940 4108 10000000 		ldl.sx	%s57,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 2940      BF003903 
 2941 4110 34000000 		ldl.sx	%s56,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 2941      BF003803 
 2942 4118 00000000 		adds.w.sx	%s56,%s57,%s56
 2942      B8B9384A 
 2943 4120 3C000000 		ldl.sx	%s57,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 2943      BF003903 
 2944 4128 00000000 		adds.w.sx	%s57,1,%s57
 2944      B901394A 
 2945 4130 00000000 		muls.w.sx	%s57,%s57,%s60
 2945      BCB9394B 
 2946 4138 00000000 		subs.w.sx	%s57,%s56,%s57
 2946      B9B8395A 
 2947 4140 2C000000 		ldl.sx	%s56,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 2947      BF003803 
 2948 4148 00000000 		adds.w.sx	%s57,%s57,%s56
 2948      B8B9394A 
 2949 4150 00000000 		adds.w.sx	%s57,-1,%s57
 2949      B97F394A 
 2950 4158 00000000 		divs.w.sx	%s55,%s57,%s56
 2950      B8B9377B 
 2951 4160 00000000 		muls.w.sx	%s56,%s56,%s55
 2951      B7B8384B 
 2952 4168 00000000 		subs.w.sx	%s56,%s57,%s56
 2952      B8B9385A 
 2953 4170 68FFFFFF 		brgt.w	0,%s56,.L5.72
 2953      B8008118 
 2954 4178 60EDFFFF 		br.l	.L5.7
 2954      00000F18 
 2955              	.L5.73:
 2956              	# line 1020
1020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 2957              		.loc	1 1020 0
 2958 4180 00000000 		or	%s58,1,(0)1
 2958      00013A45 
 2959 4188 00000000 		or	%s3,0,%s55
 2959      B7000345 
 2960 4190 70FFFFFF 		br.l	.L5.6
 2960      00000F18 
 2961              	.L5.4:
 2962              	# line 1019
1019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 2963              		.loc	1 1019 0
 2964 4198 00000000 		subs.w.sx	%s59,%s57,%s59
 2964      BBB93B5A 
 2965              	# line 1020
1020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 2966              		.loc	1 1020 0
 2967 41a0 0C000000 		ldl.sx	%s58,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 2967      BF003A03 
 2968 41a8 30000000 		ldl.sx	%s57,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 2968      BF003903 
 2969 41b0 00000000 		adds.w.sx	%s57,%s58,%s57
 2969      B9BA394A 
 2970 41b8 38000000 		ldl.sx	%s58,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 2970      BF003A03 
 2971 41c0 00000000 		adds.w.sx	%s58,1,%s58
 2971      BA013A4A 
 2972 41c8 00000000 		muls.w.sx	%s58,%s58,%s61
 2972      BDBA3A4B 
 2973 41d0 00000000 		subs.w.sx	%s58,%s57,%s58
 2973      BAB93A5A 
 2974 41d8 28000000 		ldl.sx	%s57,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 2974      BF003903 
 2975 41e0 00000000 		adds.w.sx	%s58,%s58,%s57
 2975      B9BA3A4A 
 2976 41e8 00000000 		adds.w.sx	%s58,-1,%s58
 2976      BA7F3A4A 
 2977 41f0 00000000 		divs.w.sx	%s56,%s58,%s57
 2977      B9BA387B 
 2978 41f8 00000000 		muls.w.sx	%s57,%s57,%s56
 2978      B8B9394B 
 2979 4200 00000000 		subs.w.sx	%s57,%s58,%s57
 2979      B9BA395A 
 2980 4208 78FFFFFF 		brgt.w	0,%s57,.L5.73
 2980      B9008118 
 2981 4210 B0ECFFFF 		br.l	.L5.5
 2981      00000F18 
 2982              	.L5.74:
 2983              	# line 1019
1019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 2984              		.loc	1 1019 0
 2985 4218 00000000 		or	%s59,1,(0)1
 2985      00013B45 
 2986 4220 00000000 		or	%s2,0,%s56
 2986      B8000245 
 2987 4228 70FFFFFF 		br.l	.L5.4
 2987      00000F18 
 2988              	.L5.2:
 2989              	# line 1018
1018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 2990              		.loc	1 1018 0
 2991 4230 00000000 		subs.w.sx	%s62,%s59,%s62
 2991      BEBB3E5A 
 2992              	# line 1019
1019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 2993              		.loc	1 1019 0
 2994 4238 34000000 		ldl.sx	%s59,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 2994      BF003B03 
 2995 4240 3C000000 		ldl.sx	%s58,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 2995      BF003A03 
 2996 4248 00000000 		adds.w.sx	%s58,1,%s58
 2996      BA013A4A 
 2997 4250 00000000 		muls.w.sx	%s58,%s58,%s60
 2997      BCBA3A4B 
 2998 4258 00000000 		subs.w.sx	%s58,%s59,%s58
 2998      BABB3A5A 
 2999 4260 2C000000 		ldl.sx	%s59,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 2999      BF003B03 
 3000 4268 00000000 		adds.w.sx	%s58,%s58,%s59
 3000      BBBA3A4A 
 3001 4270 00000000 		adds.w.sx	%s58,-1,%s58
 3001      BA7F3A4A 
 3002 4278 00000000 		divs.w.sx	%s57,%s58,%s59
 3002      BBBA397B 
 3003 4280 00000000 		muls.w.sx	%s59,%s59,%s57
 3003      B9BB3B4B 
 3004 4288 00000000 		subs.w.sx	%s59,%s58,%s59
 3004      BBBA3B5A 
 3005 4290 88FFFFFF 		brgt.w	0,%s59,.L5.74
 3005      BB008118 
 3006 4298 10ECFFFF 		br.l	.L5.3
 3006      00000F18 
 3007              	.L5.75:
 3008              	# line 1018
1018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 3009              		.loc	1 1018 0
 3010 42a0 00000000 		or	%s62,1,(0)1
 3010      00013E45 
 3011 42a8 00000000 		or	%s60,0,%s1
 3011      81003C45 
 3012 42b0 00000000 		or	%s1,0,%s57
 3012      B9000145 
 3013 42b8 78FFFFFF 		br.l	.L5.2
 3013      00000F18 
 3014              	.L5.61:
 3015 42c0 30000000 		ldl.sx	%s62,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 3015      BF003E03 
 3016 42c8 38000000 		ldl.sx	%s60,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 3016      BF003C03 
 3017 42d0 00000000 		adds.w.sx	%s60,1,%s60
 3017      BC013C4A 
 3018 42d8 00000000 		muls.w.sx	%s60,%s60,%s61
 3018      BDBC3C4B 
 3019 42e0 00000000 		subs.w.sx	%s60,%s62,%s60
 3019      BCBE3C5A 
 3020 42e8 28000000 		ldl.sx	%s62,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 3020      BF003E03 
 3021 42f0 00000000 		adds.w.sx	%s60,%s60,%s62
 3021      BEBC3C4A 
 3022 42f8 00000000 		adds.w.sx	%s60,-1,%s60
 3022      BC7F3C4A 
 3023 4300 00000000 		divs.w.sx	%s59,%s60,%s62
 3023      BEBC3B7B 
 3024 4308 00000000 		muls.w.sx	%s62,%s62,%s59
 3024      BBBE3E4B 
 3025 4310 00000000 		subs.w.sx	%s62,%s60,%s62
 3025      BEBC3E5A 
 3026 4318 88FFFFFF 		brgt.w	0,%s62,.L5.75
 3026      BE008118 
 3027 4320 68EBFFFF 		br.l	.L5.1
 3027      00000F18 
 3028              	.L5.76:
 3029 4328 00000000 		or	%s1,0,%s60
 3029      BC000145 
 3030 4330 90FFFFFF 		br.l	.L5.61
 3030      00000F18 
 3031              	.L5.59:
 3032              	# line 1016
1016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 3033              		.loc	1 1016 0
 3034 4338 00000000 		or	%s60,0,(0)1
 3034      00003C45 
 3035 4340 24000000 		ldl.sx	%s18,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 3035      BF001203 
 3036 4348 E0FFFFFF 		brlt.w	0,%s18,.L5.76
 3036      92008218 
 3037 4350 C0FBFFFF 		br.l	.L5.58
 3037      00000F18 
 3038              	.L5.77:
 3039              	# line 1027
1027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owb[khkw] = ow_beg;
 3040              		.loc	1 1027 0
 3041 4358 C8FFFFFF 		dld	%s56,-56(,%fp)	# ohb
 3041      89003809 
 3042              	# line 1028
1028:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ohe[khkw] = oh_end;
 3043              		.loc	1 1028 0
 3044 4360 D8FFFFFF 		dld	%s55,-40(,%fp)	# owb
 3044      89003709 
 3045              	# line 1029
1029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       owe[khkw] = ow_end;
 3046              		.loc	1 1029 0
 3047 4368 D0FFFFFF 		dld	%s54,-48(,%fp)	# ohe
 3047      89003609 
 3048              	# line 1030
1030:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****       ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
 3049              		.loc	1 1030 0
 3050 4370 E0FFFFFF 		dld	%s53,-32(,%fp)	# owe
 3050      89003509 
 3051 4378 00000000 		or	%s57,0,%s62
 3051      BE003945 
 3052 4380 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 3052      89003F01 
 3053 4388 B0FFFFFF 		br.l	.L5.59
 3053      00000F18 
 3054              	.L5.0:
 3055              	# line 1015
1015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv4.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 3056              		.loc	1 1015 0
 3057 4390 00000000 		or	%s61,0,(0)1
 3057      00003D45 
 3058 4398 00000000 		or	%s60,4,(0)1
 3058      00043C45 
 3059 43a0 00000000 		st2b	%s60,0(,%s23)
 3059      97003C14 
 3060 43a8 08FDFFFF 		ld	%s63,-760(,%fp)	# restore 
 3060      89003F01 
 3061 43b0 20000000 		ldl.sx	%s18,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 3061      BF001203 
 3062 43b8 A0FFFFFF 		brlt.w	0,%s18,.L5.77
 3062      92008218 
 3063 43c0 18FBFFFF 		br.l	.L5.56
 3063      00000F18 
 3064              		.cfi_endproc
 3065              		.set	.L.6.2auto_size,	0xfffffffffffff9b0	# 1616 Bytes
 3067              	# ============ End  conv::refconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
