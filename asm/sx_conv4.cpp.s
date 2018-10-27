   1              		.ident "nc++ 1.5.2 (Build 11:19:31 Oct  2 2018)"
   2              		.file "sx_conv4.cpp"
   3              		.file 1 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp"
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
  41              		.file 39 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp"
  42              	# ============ Begin  conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator() const
  43              		.text
  44              		.balign 16
  45              	# line 1422
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /*******************************************************************************
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * Copyright 2017 NEC Laboratories America
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** *
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * Licensed under the Apache License, Version 2.0 (the "License");
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * you may not use this file except in compliance with the License.
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * You may obtain a copy of the License at
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** *
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** *     http://www.apache.org/licenses/LICENSE-2.0
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** *
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * Unless required by applicable law or agreed to in writing, software
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * distributed under the License is distributed on an "AS IS" BASIS,
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * See the License for the specific language governing permissions and
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** * limitations under the License.
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** *******************************************************************************/
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** \file
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * sx vectorization ref_conv3.cpp */
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if ! defined(_SX)
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** // TODO ok for gcc, but others ???
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define restrict __restrict__
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #include "conv/conv.hpp"
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #include "idiv.hpp"
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** namespace conv {
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** // BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** extern void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** extern void sxconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static void chk( bool cond, char const* msg, char const* file, int const lineno ){
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static bool trivial( int const verb, bool const cond, char const* msg,
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                      char const* file, int const lineno ){
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if (verb > verbose && cond){
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         printf("@@@ trivial: %s : [%s:%d]\n", msg, file, lineno); fflush(stdout);
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     return cond;
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** //#define MUST( COND )
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define MUST( COND )    chk(    (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define PRINTF(...)     do{ printf(__VA_ARGS__); fflush(stdout);}while(0)
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define TRIVIAL( COND ) COND
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** //#define TRIVIAL( COND ) trivial(1, (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if defined(NDEBUG)
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define DPRINTF(...)
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define DMUST(...)
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define DPRINTF(...)  do{printf(__VA_ARGS__); fflush(stdout);}while(0)
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define DMUST(...)   MUST(__VA_ARGS__)
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** greatest common denominator, a,b > 0 */
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static int gcd(int a, int b)
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** {
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (;;)
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     {
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         if (a == 0) return b;
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         b %= a;
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         if (b == 0) return a;
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         a %= b;
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** lowest common multiple, a,b > 0 */
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static int lcm(int a, int b)
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** {
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int temp = gcd(a, b);
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     return temp ? (a / temp * b) : 0;
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** Solve for integers j, k and g=gcd(a,b) such that ja + ky = g,
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * where a,b are integer constants.
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * This is a linear equation in integers, and is solved
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * via the extended Euclid algorithm.
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  */
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static void inline extendedEuclid( int& k, int a, int& j, int b, int& g)
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** {
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int x = 1, y = 0;
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int xLast = 0, yLast = 1;
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int q, r, m, n;
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   while (a != 0) 
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     q = b / a;
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     r = b % a;
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     m = xLast - q * x;
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     n = yLast - q * y;
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     xLast = x; 
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     yLast = y;
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     x = m; 
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     y = n;
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     b = a; 
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     a = r;
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   g = b;
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   k = xLast;
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   j = yLast;
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** hoist `A+iB in range [C,D)` condition out of a loop for i in [imin,imax].
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * When 
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * Original:
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * for(i=imin; i<imax; ++i){       // original loop
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   if( ApiB < c || ApiB > d ) continue;
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   // Loop Body
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * }
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * Transformed:
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * int const ibeg, iend;
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * for(i=ibeg; i<iend; ++i){       // original loop
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   int const ApiB = a + i*b;
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   // GONE: if( ApiB < c || ApiB > d ) continue;
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   // Loop Body
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * }
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \pre \c b > 0, (c, d?)
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  */
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static inline void hoist_ApiB_in( int& beg, int& end,
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const int imin, const int imax,
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const int a, const int b, const int c, const int d)
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** {
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( b > 0 );
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // int i*B < A    iff    i < (A    )/B
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // int i*B > A    iff    i > (A+B-1)/A
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // A+iB >= c ... iB >= c-A  ... i >= (c-A + B-1 )/B
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     beg = div_floor( c-a+b-1, b );
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     beg = c-a + b-1;
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( beg >= 0 ){
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         beg /= b;
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     } else {
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         int const fmul=(-beg + b)/b;
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         RT_ASSERT( beg + fmul*b >= 0 );
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         beg = (beg + fmul*b) / b - fmul;
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), beg=%d? f+c-a+b-1=%d\n",
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //        imin,imax, a,b, c,d, beg, f+c-a+b-1);
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( a + (beg-1)*b < c );
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( a + (beg  )*b >= c );
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( beg < imin ) beg = imin;
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // A+iB < d ... iB < d-A    ... i < (d-A) / B
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     end = div_floor( d-a+b-1, b );
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     end = d-a +b-1;
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( end >= 0 ){
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         end /= b;
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     } else {
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         int const fmul=(-end + b)/b;
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         RT_ASSERT( end + fmul*b >= 0 );
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         end = (end + fmul*b) / b - fmul;
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), end=%d? f+d-a=%d\n",
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //        imin,imax, a,b, c,d, end, f+d-a);
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( a + (end-1)*b < d );
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( a + (end  )*b >= d );
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( end > imax ) end = imax;
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** Integer \c i so A-iB is <em>just below</em> \c target.
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \pre \c B>0 (unchecked). */
 179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static inline int AmiB_lt_target( const int a, const int b, const int target)
 180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** {
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int ibelow = a-target + b;
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // XXX use idiv.hpp here too
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( ibelow >= 0 ){
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ibelow /= b;
 185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //ibelow = div_floor( ibelow, b );
 186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     } else {
 187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         int const fmul=(-ibelow + b)/b;
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //RT_ASSERT( ibelow + fmul*b >= 0 );
 189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //RT_ASSERT( fmul == div_floor( -ibelow, b )+1 );
 190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ibelow = (ibelow + fmul                    *b) / b - fmul; // orig
 191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //ibelow = (ibelow + (div_floor(-ibelow,b)+1)*b) / b - (div_floor(-ibelow,b)+1);
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //ibelow = div_floor( ibelow, b );
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( a - (ibelow-1)*b >= target );
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( a - (ibelow  )*b <  target );
 198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     return ibelow;
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** Get range if \c i so A-iB is in [c,d), and then further
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * restrict to range [imin,imax).  Note that \c -B means as \c i
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * increases, we move from \c d-1 downwards to \c c. */
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static inline void hoist_AmiB_in( int& beg, int& end,
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const int imin, const int imax,
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const int a, const int b, const int c, const int d)
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** {
 207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     DMUST( b > 0 );
 208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     beg = AmiB_lt_target( a, b, d );
 209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //RT_ASSERT( beg == div_floor( a-d+b, b) );
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //beg = div_floor( a-d+b, b); // possibly slower ?? do I have a cmov here? no!
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //beg = div_floor( a-d, b) + 1; // possibly slower ?? do I have a cmov here? no!
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( beg < imin ) beg = imin;
 213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     end = AmiB_lt_target( a, b, c );
 215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //RT_ASSERT( end == div_floor( a-c+b, b) );
 216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //end = div_floor( a-c+b, b);
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //end = div_floor( a-c, b) + 1;
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( end > imax ) end = imax;
 219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** shows a new hoisting method.
 222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * Hoisting conditionals refers to replacing conditionals with
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * formulas for loop limits.  A simple example can be found in
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \ref hoist_ApiB_in, which uses the following examples:
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * Original:
 228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * for(i=imin; i<imax; ++i){       // original loop
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   if( ApiB < c || ApiB > d ) continue;
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   // Loop Body
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * }
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * Transformed:
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * int const ibeg, iend;
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * for(i=ibeg; i<iend; ++i){       // original loop
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   int const ApiB = a + i*b;
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   // GONE: if( ApiB < c || ApiB > d ) continue;
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   // Loop Body
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * }
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * For \c kh, for examples we replaced and simplified the \em hoist routine
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * in steps:
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \ref ref_conv2.cpp
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *  for (int kh = 0; kh < p->kh; ++kh) {
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *      const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *      if (ih < 0 || ih >= p->ih) continue;
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *      // etc
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * With hoisting, \ref refconv3_fwd
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code   
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * int kh_beg, kh_end;
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * hoist_ApiB_in( kh_beg, kh_end,
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *                0, p->kh                          // i  in  [0, p->kh)
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *               (oh * p->sh - p->ph), (p->dh + 1), // ih=A+iB
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *               0, p->ih);                         // ih in [0, p->ih)
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * //if (kh_beg >= kh_end) continue;
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * for (int kh = kh_beg; kh < kh_end; ++kh) {
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     // etc
 268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * which simplifies to
 270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * kh_beg = div_floor( 0     - (oh * SH - PH) + p->dh, (p->dh+1) );
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * kh_end = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * if( kh_beg < 0     ) kh_beg = 0;
 274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * if( kh_end > p->kh ) kh_end = p->kh;
 275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * //if (kh_beg >= kh_end) continue;
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * for (int kh = kh_beg; kh < kh_end; ++kh) {
 277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     const int ih = oh * p->sh - p->ph + kh * (p->dh + 1);
 278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     // etc
 279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * A key feature for the mathematics of such formulas is that integer
 282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * rounding should go toward negative infinity.  Unfortunately, C99
 283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * and C++11 round toward zero.  So div_floor, which has been optimized
 284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * for x86, may have conditionals that don't behave so well for other
 285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * chips.
 286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * So here we derive a way to do all calculations with positive integers,
 288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * avoiding negatives.  Such a calculation is now correct when evaluated
 289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * with unsigned integers, and also allows normal division to be used.
 290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - First, solve for \c kh, assuming div_floor rounding.
 292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - ih = oh * p->sh - p->ph + kh * (p->dh + 1)
 293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ih = oh*SH - PH + kh*DH\f$
 294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$kh*DH = ih + PH - oh*SH\f$
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$kh = div\_floor( ih+PH-oh*SH+DH-1, DH )\f$, which we'll loosely call
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$kh(ih,oh) = (ih+DH-1+PH-oh*SH) / DH\f$ (true for positive numerator & denominator)
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - \f$kh_{beg}\f$, the lowest \c kh value, is associated with the lowest possible \c oh.
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - We avoid testing for values of zero, since division values of zero can
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     result by rounding negative integers upward
 301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - Consider \f$kh(ih,oh) >= 1\f$
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ (0 + DH-1+PH-oh*SH) / DH >= 1\f$  (for +ve numerator & denominator)
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ DH-1+PH-oh*SH >= DH\f$
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ PH-1 - oh*SH >= 0\f$
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ oh*SH <= PH-1 \f$
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ oh*SH < PH \f$
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - Therefore if \f$oh*SH < PH\f$, we use the formula \f$kh_{beg}=(DH-1+[PH-oh*SH]) / DH\f$
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - Notice that both numerator and denominator are both strictly positive.
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - So this formula is correct for signed/unsigned integers.
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - Otherwise, \f$kh_{beg} = 0\f$, the lowest possible value.
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - We'll avoid \f$kh_{beg} > KH\f$, by testing \f$kh_{beg} < kh_{end}\f$
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - Now Consider \f$kh_{end} >= KH\f$, where KH is the highest valid value for \f$kh_{end}\f$
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - The largest \f$kh\f$ occurs when \c ih has it's largest possible value, \c IH.
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - Let's first check for \f$kh(ih,oh) >= KH\f$
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ (IH + DH-1 + PH - oh*SH) / DH >= KH \f$
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ IH + DH - 1 + PH - oh*SH  >= KH*DH \f$
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ KH*DH + oh*SH + 1 <= IH+PH+DH \f$, now RHS and LHS are positive
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - \f$ KH*DH + oh*SH < IH+PH+DH \f$
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - When the above condition holds, we can set \f$kh_{end} = KH\f$ (maximal value)
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - Otherwise we can also check for \f$kh(ih,oh) >= 1\f$, so that we can safely use
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   division with positive integers.
 324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - Replacing 'KH' with '1' in above...  \f$ 1*DH + oh*SH < IH+PH+DH \f$
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - So when \f$oh*SH < IH+PH\f$, \f$kh_{end} =  (DH-1 + [IH+PH - oh*SH]) / DH \f$
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     will be \f$ > 0\f$
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     - Otherwise we can set \f$kh_{end} = 0\f$
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * So the \em long-hand postive-integer solutions for \c kh_beg and \c kh_end are:
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * if( oh*SH < PH )
 333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   kh_beg = (p->dh + (PH - oh * SH)) / DH;
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * else
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   kh_beg = 0;
 336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * and
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \code
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * if (oh*SH + KH*DH < IH + PH + DH)
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   kh_end = KH;
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * else if (oh*SH >= IH+PH)
 342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   kh_end = 0;
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * else
 344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   kh_end = ([IH+PH - oh*SH] + DH-1) / DH;
 345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \endcode
 346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * \ref sxconv_4_fwd shows how this can be done, and results in big speedups for sxc++,
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * whose compiler can vectorize the few remaining simple conditionals quite well (apparently).
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
 350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * Other SX optimizations include using unit-stride temporaries, since complex expressions
 351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * with multiple strided vectors are sometimes not vectorized very well.
 352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  */
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** void sxconv_4_fwd(const prb_t *p, dnn_mem_t &src_m,
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
 355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // V 8 is default
 356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define V 9
 357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if V==8 // A1, A3 : 74, 108x
 358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t G = p->g;
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t MB = p->mb;
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IC = p->ic;
 361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH = p->ih;
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IW = p->iw;
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OC = p->oc;
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH = p->oh;
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OW = p->ow;
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH = p->kh;
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KW = p->kw;
 368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PH = p->ph;
 369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PW = p->pw;
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH = p->sh;
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SW = p->sw;
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DH = p->dh + 1;
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DW = p->dw + 1;
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG = IC/G;
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC/G;
 377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH_KW = KH * KW;
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH_IW = IH * IW;
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH_IW = SH * IW;
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DH_IW = DH * IW;
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( p->kh > 0 && KW > 0 );
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( SH >= 0 && SW >= 0 );
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const psrc = (float*)src_m;
 390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pwei = (float*)wei_m;
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pbia = (float*)bia_m;
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdst = (float*)dst_m;
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
 394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khkw_begend[4] alignas(4*sizeof(ssize_t));
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t kh_beg=0, kh_end=0;
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t kw_beg=0, kw_end=0;
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(khkw_begend)
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(khkw_begend)
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khkw_muls[4] alignas(4*sizeof(ssize_t)) = {1, KH, (1<<16), (1<<16)*KW};
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(khkw_muls)
 406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(khkw_muls)
 408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khash, w0, s0, s00;
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khash_prv = ~0;
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //ssize_t khash_prv2 = (KH+KW)*4; // impossibly high hash
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     bool kok[KH][KW] alignas(128);
 414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(kok)
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(kok)
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float src[ICOG*KH*KW] alignas(128);
 420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(src)
 422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(src)
 424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float tmp[OCOG] alignas(128);
 426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** //RETAIN(tmp)
 427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(tmp)
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(OCOG)
 430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(tmp,OCOG) // roughly double the speed
 432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(4))//;
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oh = 0; oh < OH; ++oh) {
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ---- 1 omp thread ----
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if ((p->dir & FLAG_BIA) == 0){
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc)
 441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = 0.f;
 442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }else{
 443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
 444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc)
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = pbia[bia_off0 + oc];
 446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // this alt to div_floor avoids negatives.
 448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ... so it is correct for unsigned types AND normal div.
 449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kh_beg=0, kh_end=0;
 450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
 451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kh_end = 0;
 452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kh_end >= KH) kh_end = KH;
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kw_beg=0, kw_end=0;
 456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
 457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kw_end >= KW) kw_end = KW;
 459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           bool const khw_ok = ( kw_beg < kw_end && kh_beg < kh_end );
 461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (khw_ok)
 462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           {
 463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //unsigned khash = ((kw_beg+kh_beg) | ((kw_end+kh_end) - (KH+KW)) | khash_prv);
 464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // --> FAIL. ?better hash needed?
 465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[0] = kh_beg;
 466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[1] = kh_end;
 467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[2] = kw_beg;
 468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[3] = kw_end;
 469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khash = 0;
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t i=0; i<4; ++i)
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               khash += khkw_begend[i] * khkw_muls[i];
 472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (khash != khash_prv){
 473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               khash_prv = khash;
 474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   kok[kh][kw] = (kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end);
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
 481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-PW+
 482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // slower for (ssize_t ic = 0, ickhkw=0; ic < ICOG; ++ickhkw, ++ic)
 483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic)
 484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
 485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW]
 488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // this may fail if wei access also needs to be protected.
 493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc) {
 494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (p->merge == RELU) {
 501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
 502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
 505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (size_t oc = 0; oc < OCOG; ++oc)
 506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
 508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
 509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif V==9 // A1, A3 : 74, 108x
 512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t G = p->g;
 513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t MB = p->mb;
 514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IC = p->ic;
 515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH = p->ih;
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IW = p->iw;
 517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OC = p->oc;
 518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH = p->oh;
 519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OW = p->ow;
 520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH = p->kh;
 521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KW = p->kw;
 522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PH = p->ph;
 523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PW = p->pw;
 524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH = p->sh;
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SW = p->sw;
 526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DH = p->dh + 1;
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DW = p->dw + 1;
 528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG = IC/G;
 530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC/G;
 531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH_KW = KH * KW;
 532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
 534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
 536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH_IW = IH * IW;
 537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH_IW = SH * IW;
 538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DH_IW = DH * IW;
 539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( p->kh > 0 && KW > 0 );
 541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( SH >= 0 && SW >= 0 );
 543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const psrc = (float*)src_m;
 544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pwei = (float*)wei_m;
 545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pbia = (float*)bia_m;
 546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdst = (float*)dst_m;
 547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int khkw_end = (int)KH_KW;
 548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float khkw_zeros[khkw_end];
 549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (int khkw=0; khkw < khkw_end; ++khkw){
 550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       khkw_zeros[khkw] = 0.f;
 551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pkhkw_zeros = &khkw_zeros[0];
 553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
 554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
 555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khkw_begend[4];
 556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t kh_beg=0, kh_end=0;
 557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t kw_beg=0, kw_end=0;
 558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(khkw_begend)
 560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(khkw_begend)
 562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khkw_muls[4] = {1, KH, (1<<16), (1<<16)*KW};
 564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(khkw_muls)
 566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(khkw_muls)
 568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
 570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khash, w0, s0, s00;
 571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t khash_prv = ~0;
 572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //ssize_t khash_prv2 = (KH+KW)*4; // impossibly high hash
 573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //bool kok[KH][KW];
 574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int kok[KH_KW] alignas(128);
 575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(kok)
 577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(kok)
 579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float src[ICOG*KH*KW] alignas(128);
 581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(src)
 583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(src)
 585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float tmp[OCOG] alignas(128);
 587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float seq[KH_KW] alignas(128);
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for(int i=0; i<KH_KW; ++i) seq[KH_KW] = (float)i;
 589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** //RETAIN(tmp)
 590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(tmp)
 592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(OCOG)
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(tmp,OCOG) // roughly double the speed
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(4))//;
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oh = 0; oh < OH; ++oh) {
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ---- 1 omp thread ----
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if ((p->dir & FLAG_BIA) == 0){
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc)
 605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = 0.f;
 606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }else{
 607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc)
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = pbia[bia_off0 + oc];
 610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // this alt to div_floor avoids negatives.
 612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ... so it is correct for unsigned types AND normal div.
 613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kh_beg=0, kh_end=0;
 614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
 615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kh_end = 0;
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kh_end >= KH) kh_end = KH;
 618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kw_beg=0, kw_end=0;
 620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kw_end >= KW) kw_end = KW;
 623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           bool const khw_ok = ( kw_beg < kw_end && kh_beg < kh_end );
 625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (khw_ok)
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           {
 627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //unsigned khash = ((kw_beg+kh_beg) | ((kw_end+kh_end) - (KH+KW)) | khash_prv);
 628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // --> FAIL. ?better hash needed?
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[0] = kh_beg;
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[1] = kh_end;
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[2] = kw_beg;
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[3] = kw_end;
 633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khash = 0;
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t i=0; i<4; ++i)
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               khash += khkw_begend[i] * khkw_muls[i];
 636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (khash != khash_prv){
 637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               khash_prv = khash;
 638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int khkw_end = (int)KH_KW;
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //OMP(simd)//;
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               IVDEP() for (int khkw = 0; khkw < khkw_end; ++khkw) { // this does not simd-ize very 
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const int kh = khkw / p->kw;
 643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const int kw = khkw % p->kw;
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 kok[khkw] = ((kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end)? 0xffFFffFF: 0)
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //kok[khkw] = ((kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end)? 0xffFFffFF: 
 646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //kok[khkw] = (kh>=kh_beg ? ~0: 0)
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //    &       (kw>=kw_beg ? ~0: 0)
 648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //    &       (kh<kh_end  ? ~0: 0)
 649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //    &       (kw<kw_end  ? ~0: 0)
 650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //    ;
 651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int khkw_end = (int)KH_KW;
 654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const int khh = (int)KH;
 655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const int kww = (int)KW;
 656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (int khkw = 0; khkw < khkw_end; ++khkw) kok[khkw] = 0;
 657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               bool alignas(128) khok[khh]; for(int i=0; i<khh; ++i) khok[i] = (i>=kh_beg? ~0: 0) & 
 658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               bool alignas(128) kwok[kww]; for(int i=0; i<kww; ++i) kwok[i] = (i>=kw_beg? ~0: 0) & 
 659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t kh = 0; kh < khh; ++kh) {
 660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = 0; kw < kww; ++kw) {
 661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   kok[kh*kww+kw] = khok[kh];
 662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = 0; kw < kww; ++kw) {
 664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   kok[kh*kww+kw] &= kwok[kw];
 665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
 670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-PW+
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // slower for (ssize_t ic = 0, ickhkw=0; ic < ICOG; ++ickhkw, ++ic)
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic)
 673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
 674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 0
 675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (int khkw = 0; khkw < khkw_end; ++khkw) {
 676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //const int kh = khkw / p->kw;
 677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //const int kw = khkw % p->kw;
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //src[ic*KH*KW + khkw] = (kok[khkw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW]: 0.f);
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //src[ic*KH*KW + khkw] = (kok[khkw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW]: 0.f);
 680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 src[ic*KH*KW + khkw] = ((kok[khkw] & (1<<31))? psrc[s0 + ic*IH_IW + (khkw/p->kw)*DH
 681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               float idx[khkw_end] alignas(128);
 684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (int khkw = 0; khkw < khkw_end; ++khkw) {
 685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const int khh = KH;
 686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const int kww = KW;
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (int kh=0; kh<khh; ++kh){
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw=0; kw<kww; ++kw){
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   // using integer calc no longer results in vgather !
 690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //idx[kh*kww+kw] = s0 + ic*IH_IW + kh*DH_IW + kw*DW;
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   idx[kh*kww+kw] = (float)s0 + (float)ic*IH*IW + (float)kh*DH*IW + (float)kw*DW;
 692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = 0.f;
 693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //if (kok[kh*kww+kw]) src[ic*khh*kww + kh*kww+kw] += psrc[(int)(idx[kh*kww+kw])];
 694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   src[ic*khh*kww + kh*kww+kw] = ((kok[kh*kww+kw])? psrc[(int)(idx[kh*kww+kw])]: 0.f
 695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = ((kok[kh*kww+kw])? psrc[(int)(idx[kh*kww+kw])]: k
 696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               float idx[khkw_end] alignas(128);
 700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const int khh = KH;
 701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const int kww = KW;
 702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (int kh=0; kh<khh; ++kh){
 703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw=0; kw<kww; ++kw){
 704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   idx[kh*kww+kw] = (float)s0 + (float)ic*IH*IW + (float)kh*DH*IW + (float)kw*DW;
 705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (int khkw=0; khkw < khkw_end; ++khkw){
 708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 // AHAAAAAA  this is the magic to generate vmaskmovps and vgatherdps ... but it is 
 709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 src[ic*khkw_end + khkw] = ((kok[khkw] & (1<<31))? psrc[(int)(idx[khkw])]: 0.f);
 710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //
 711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //src[ic*khh*kww + khkw] = 0.f;
 712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //if (kok[khkw]) src[ic*khh*kww + khkw] += psrc[(int)(idx[khkw])];
 713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //  not nice
 714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //if (kok[khkw]) src[ic*khh*kww + khkw] = psrc[(int)(idx[khkw])];
 715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //else           src[ic*khh*kww + khkw] = 0.f;
 716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //src[ic*khh*kww + khkw] = (kok[khkw]? psrc[(int)(idx[khkw])]: pkhkw_zeros[khkw]);
 717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // this may fail if wei access also needs to be protected.
 722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //float const * restrict pwei_oc = pwei + w0;
 723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //for (ssize_t oc = 0; oc < OCOG; pwei_oc+=ICOG_KH_KW, ++oc)
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc) {
 725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               OMP(simd)//;
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //tmp[oc] += src[ickhkw] * pwei_oc[ickhkw];
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               float x = 0.f;
 733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW-16+1; ickhkw+=16) {
 734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 OMP(simd)//;
 735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t i = ickhkw; i < ickhkw+16; ++i) {
 736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   x += src[i] * pwei_oc[i];
 737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t i = ickhkw; i < ICOG_KH_KW; ++i) {
 739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   x += src[i] * pwei_oc[i];
 740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] = x;
 742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (p->merge == RELU) {
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (size_t oc = 0; oc < OCOG; ++oc)
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #error "please select one"
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** hoisting for generic dilations is complicated by modulo conditions. */
 765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static void sxconv_4_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
 766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
 767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** {
 768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if defined(__ve) // compiler bug! XXX TODO temporarily disabled
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   refconv_2_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
 770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // shorten, do same for kw,ow loop. tweaks to kh calc
 771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const KH = p->kh;
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const OH = OH;
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const DH = p->dh + 1;
 774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const SH = SH;
 775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const PH = PH;
 776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int gcd_h = gcd( SH, DH );
 777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int khh = lcm_h / DH;
 779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int jhh = lcm_h / SH;
 781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int ha, hb, hg;
 782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
 783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( hg == gcd_h );
 785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const KW = p->kh;
 787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const DW = p->dw + 1;
 788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const SW = SW;
 789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const OW = OW;
 790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int const PW = PW;
 791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int gcd_w = gcd( SW, DW );
 792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //const int lcm_w = lcm( SW, DW );
 793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int lcm_w = SW * DW/gcd_w;
 794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int kww = lcm_w / DW;
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int jww = lcm_w / SW;
 796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int wa, wb, wg;
 797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
 798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( wg == gcd_w );
 799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(5))//;
 800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (int g = 0; g < G; ++g) {
 801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // calc kh_beg, kh_end here? 4.28x
 805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ds = 0;
 809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             int kh_end = (ih + PH) / DH + 1;
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kh_end > KH) kh_end = KH;
 812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             int kh_beg = kh_end;
 813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               // 1. Find one soln (any)
 815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int const mul = (ih+PH) / gcd_h;
 816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_beg = ha*mul;
 817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int j = hb*mul;
 818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               // 2. Adjust to lowest kh_beg>=0
 819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 0 // ok
 820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = (kh_beg<0? (-kh_beg+ khh -1) / khh
 821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   : kh_beg >= khh? - (kh_beg / khh)
 822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   : 0);
 823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( kh_beg + m*khh == rem_floor( kh_beg, khh ) ); // adjust kh_beg in khh-step
 824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( m == (rem_floor(kh_beg,khh) - kh_beg) / khh ); // y
 825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( m == - div_floor(kh_beg,khh) ); // y
 826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if(m){
 827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   kh_beg += m * khh;
 828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   j -= m * jhh;
 829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // ok
 831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int k2 = rem_floor( kh_beg, khh );
 832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = (k2-kh_beg) / khh;
 833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_beg = k2;
 834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               j -= m * jhh;
 835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1 // ok
 836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = div_floor(kh_beg, khh);
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_beg -= m * khh;
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               j      += m * jhh;
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               // 3. Adjust j downwards st. j*SH < OH*SH (kh_beg can go up even more)
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if( j >= OH ){
 842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 m = (j-OH) / jhh + 1;
 843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 kh_beg += m * khh;
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //j      -= m * jhh; // not needed
 845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh_beg >= kh_end ) continue;
 848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 0
 849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             int kw_beg, /*ow_beg,*/ kw_end;
 850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             kw_end = (iw + PW) / (p->dw+1) + 1;
 851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kw_end > KW) kw_end = KW;
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             kw_beg = div_floor( (iw + PW) - OW*SW, p->dw+1) + 1;
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kw_beg < 0    ) kw_beg = 0;
 854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             { // jump kw_beg up to 1st non-skipped index
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int owxsw = iw+PW - kw_beg * (p->dw+1);
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (owxsw % SW){
 857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 do {
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ++kw_beg;
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   owxsw = iw+PW - kw_beg * (p->dw+1);
 860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 } while( owxsw % SW != 0 && kw_beg < kw_end );
 861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 DMUST( kw_beg >= kw_end || (iw+PW - kw_beg * (p->dw+1)) % SW == 0 );
 862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             DMUST( kw_beg >= 0 );
 865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             int kw_end = (iw + PW) / DW + 1;
 867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kw_end > KW) kw_end = KW;
 868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             int kw_beg = kw_end;
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
 870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int const mul = (iw+PW) / gcd_w;
 871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_beg = wa*mul;
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //int j = wb*mul;
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = div_floor(kw_beg, kww);
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_beg -= m * kww;
 875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int j = wb * mul + m * jww;
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if( j >= OW ){
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 m = (j-OW) / jww + 1;
 878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 kw_beg += m * kww;
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //j -= m * jww; // not needed
 880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw_beg >= kw_end ) continue;
 884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (int oc = 0; oc < OC/G; ++oc) {
 886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   kh < kh_end;
 888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   oh0 -= lcm_h, kh += khh)
 889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               {
 890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     kw < kw_end;
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     ow0 -= lcm_w, kw += kww)
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 {
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ds += ((float*)diff_dst_m)[dst_off]
 897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     * ((float*)wei_m)[wei_off];
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
 904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
 905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1 // clean up
 908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
 909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pwei = (float*)wei_m;
 910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //float const * restrict const pbia = (float*)bia_m;
 911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
 912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define G  p->g
 913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define MB p->mb
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IC p->ic
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OC p->oc
 916:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define KH p->kh
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IH p->ih
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OH p->oh
 919:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define SH p->sh
 920:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define PH p->ph
 921:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define KW p->kw
 922:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IW p->iw
 923:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OW p->ow
 924:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define SW p->sw
 925:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define PW p->pw
 926:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const KH = p->kh;
 927:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const OH = OH;
 928:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const DH = p->dh + 1;
 929:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const SH = SH;
 930:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const PH = PH;
 931:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   size_t const DH = p->dh + 1;
 932:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int gcd_h = gcd( SH, DH );
 933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
 934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int khh = lcm_h / DH;
 935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int jhh = lcm_h / SH;
 937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int ha, hb, hg;
 938:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
 939:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( hg == gcd_h );
 941:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 942:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const KW = p->kh;
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const SW = SW;
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const OW = OW;
 945:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const PW = PW;
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   size_t const DW = p->dw + 1;
 947:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int gcd_w = gcd( SW, DW );
 948:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //const int lcm_w = lcm( SW, DW );
 949:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int lcm_w = SW * DW/gcd_w;
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int kww = lcm_w / DW;
 951:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int jww = lcm_w / SW;
 952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int wa, wb, wg;
 953:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
 954:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( wg == gcd_w );
 955:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t OCOG = OC / G;
 956:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t ICOG = IC / G;
 957:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t ICOG_KH_KW = ICOG * KH * KW;
 958:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t OH_OW = OH * OW;
 959:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(5))//;
 960:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (int g = 0; g < G; ++g) {
 961:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             float &ds = pdiff_src[src_off];
 967:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ds = 0;
 968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kh_end = (ih + PH) / DH + 1;
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kh_end > KH) kh_end = KH;
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kh_beg = kh_end;
 972:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int kh_ibeg = kh_end;
 974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int const mul = (ih+PH) / gcd_h;
 975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_ibeg = ha*mul;
 976:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = div_floor(kh_ibeg, khh);
 977:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_ibeg -= m * khh;
 978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
 979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
 980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_beg = kh_ibeg;
 981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh_beg >= kh_end ) continue;
 983:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kw_end = (iw + PW) / DW + 1;
 985:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kw_end > KW) kw_end = KW;
 986:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kw_beg = kw_end;
 987:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
 988:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int kw_ibeg;
 989:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int const mul = (iw+PW) / gcd_w;
 990:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_ibeg = wa * mul;
 991:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = div_floor(kw_ibeg, kww);
 992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_ibeg -= m * kww;
 993:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int j = wb * mul + m * jww;
 994:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
 995:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_beg = kw_ibeg;
 996:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 997:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw_beg >= kw_end ) continue;
 998:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 0
 999:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
1000:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 kh < kh_end;
1001:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 oh0 -= lcm_h, kh += khh)
1002:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
1003:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (size_t kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
1004:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   kw < kw_end;
1005:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ow0 -= lcm_w, kw += kww)
1006:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               {
1007:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh0/SH) * OW + ow0
1008:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw
1009:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 float d[OCOG], w[OCOG];
1010:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (size_t oc = 0; oc < OCOG; ++oc) {
1011:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1012:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1013:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
1014:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   d[oc] = pdiff_dst[dst_off0 + oc*OH_OW];
1015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   w[oc] = pwei     [wei_off0 + oc*ICOG_KH_KW];
1016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ds += d[oc] * w[oc];
1017:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1021:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             float d[OCOG], w[OCOG];
1022:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t oh0  = ih+PH - kh_beg*DH;
1023:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t ow00 = iw+PW - kw_beg*DW;
1024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t kh = kh_beg; kh < kh_end; kh += khh)
1025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
1026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               size_t ow0 = ow00;
1027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (size_t kw = kw_beg; kw < kw_end; kw += kww)
1028:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               {
1029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh0/SH) * OW + ow0
1030:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw
1031:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (size_t oc = 0; oc < OCOG; ++oc) {
1032:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1033:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
1035:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   d[oc] = pdiff_dst[dst_off0 + oc*OH_OW];
1036:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   w[oc] = pwei     [wei_off0 + oc*ICOG_KH_KW];
1037:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ds += d[oc] * w[oc];
1038:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ow0 -= lcm_w;
1040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               oh0 -= lcm_h;
1042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1045:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef G
1051:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef MB
1052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IC
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OC
1054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef KH
1055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IH
1056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OH
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef SH
1058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef PH
1059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef KW
1060:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IW
1061:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OW
1062:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef SW
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef PW
1064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1 // no macros, use ssize_t
1065:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
1066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pwei = (float*)wei_m;
1067:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
1068:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define G  p->g
1069:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define MB p->mb
1070:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IC p->ic
1071:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OC p->oc
1072:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define KH p->kh
1073:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IH p->ih
1074:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OH p->oh
1075:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define SH p->sh
1076:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define PH p->ph
1077:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define KW p->kw
1078:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IW p->iw
1079:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OW p->ow
1080:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define SW p->sw
1081:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define PW p->pw
1082:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const KH = p->kh;
1083:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const OH = OH;
1084:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const DH = p->dh + 1;
1085:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const SH = SH;
1086:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const PH = PH;
1087:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   size_t const DH = p->dh + 1;
1088:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int gcd_h = gcd( SH, DH );
1089:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
1090:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int khh = lcm_h / DH;
1091:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
1092:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int jhh = lcm_h / SH;
1093:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int ha, hb, hg;
1094:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
1095:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
1096:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( hg == gcd_h );
1097:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1098:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const KW = p->kh;
1099:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const SW = SW;
1100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const OW = OW;
1101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //int const PW = PW;
1102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   size_t const DW = p->dw + 1;
1103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int gcd_w = gcd( SW, DW );
1104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //const int lcm_w = lcm( SW, DW );
1105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int lcm_w = SW * DW/gcd_w;
1106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int kww = lcm_w / DW;
1107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int jww = lcm_w / SW;
1108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   int wa, wb, wg;
1109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
1110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   DMUST( wg == gcd_w );
1111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t OCOG = OC / G;
1112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t ICOG = IC / G;
1113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t ICOG_KH_KW = ICOG * KH * KW;
1114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const size_t OH_OW = OH * OW;
1115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(5))//;
1116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (int g = 0; g < G; ++g) {
1117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (int mb = 0; mb < MB; ++mb) {
1118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
1119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (int ih = 0; ih < IH; ++ih) {
1120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int iw = 0; iw < IW; ++iw) {
1121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
1122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             float &ds = pdiff_src[src_off];
1123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ds = 0;
1124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kh_end = (ih + PH) / DH + 1;
1126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kh_end > KH) kh_end = KH;
1127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kh_beg = kh_end;
1128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int kh_ibeg = kh_end;
1130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int const mul = (ih+PH) / gcd_h;
1131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_ibeg = ha*mul;
1132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = div_floor(kh_ibeg, khh);
1133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_ibeg -= m * khh;
1134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
1135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
1136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kh_beg = kh_ibeg;
1137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh_beg >= kh_end ) continue;
1139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kw_end = (iw + PW) / DW + 1;
1141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (kw_end > KW) kw_end = KW;
1142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             size_t kw_beg = kw_end;
1143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
1144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int kw_ibeg;
1145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int const mul = (iw+PW) / gcd_w;
1146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_ibeg = wa * mul;
1147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int m = div_floor(kw_ibeg, kww);
1148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_ibeg -= m * kww;
1149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               int j = wb * mul + m * jww;
1150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
1151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               kw_beg = kw_ibeg;
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw_beg >= kw_end ) continue;
1154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
1156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 kh < kh_end;
1157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 oh0 -= lcm_h, kh += khh)
1158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
1159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (size_t kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
1160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   kw < kw_end;
1161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ow0 -= lcm_w, kw += kww)
1162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               {
1163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh0/SH) * OW + ow0
1164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw
1165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 float d[OCOG], w[OCOG];
1166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (size_t oc = 0; oc < OCOG; ++oc) {
1167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
1170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   d[oc] = pdiff_dst[dst_off0 + oc*OH_OW];
1171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   w[oc] = pwei     [wei_off0 + oc*ICOG_KH_KW];
1172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ds += d[oc] * w[oc];
1173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef G
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef MB
1184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IC
1185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OC
1186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef KH
1187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IH
1188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OH
1189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef SH
1190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef PH
1191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef KW
1192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IW
1193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OW
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef SW
1195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef PW
1196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #error "select one"
1198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
1200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** Special-case the non-dilation BWD_D code.
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * In this case, the postive integer conditional hoistings were
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * previously derived (ex. \ref ref_conv3.cpp).  They should agree
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * with \c sx_conv_3_fwd hoistings, specialized for DH=1 [DW=1],
1205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * but have been simplified a bit further.
1206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  */
1207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** void sxconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
1208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
1209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
1210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pwei = (float*)wei_m;
1211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //float const * restrict const pbia = (float*)bia_m;
1212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
1213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 // a new simplification of loop limits (same speed as above)
1214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // regr-dilate: 2.50x
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
1216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // FIXME can we call this even less?
1217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     sxconv_4_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
1218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     return;
1219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define MAC 0
1221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // SX: MAC=0 ./regr.sh BWD_D 17.0x ---> MAC=1 10.55x; MAC=1+int 
1222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if MAC
1223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define G  p->g
1224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define MB p->mb
1225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IC p->ic
1226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OC p->oc
1227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define KH p->kh
1228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IH p->ih
1229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OH p->oh
1230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define SH p->sh
1231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define PH p->ph
1232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define KW p->kw
1233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define IW p->iw
1234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define OW p->ow
1235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define SW p->sw
1236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #define PW p->pw
1237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG = IC/G;
1238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
1239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC / G;
1240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
1241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int G = p->g;
1243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int MB = p->mb;
1244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int IC = p->ic;
1245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int IH = p->ih;
1246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int IW = p->iw;
1247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int OC = p->oc;
1248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int OH = p->oh;
1249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int OW = p->ow;
1250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int KH = p->kh;
1251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int KW = p->kw;
1252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int PH = p->ph;
1253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int PW = p->pw;
1254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int SH = p->sh;
1255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int SW = p->sw;
1256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int DH = p->dh + 1;
1257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int DW = p->dw + 1;
1258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG = IC/G;
1259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
1260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC / G;
1261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
1262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   ssize_t khb[IH], khe[IH], ohb[IH];
1264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t ih = 0; ih < IH; ++ih) {
1265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khe[ih] = ih + PH;
1266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ohb[ih] = OH - 1;
1267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
1268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
1269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       ohb[ih] = khe[ih] / SH;
1270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       khb[ih] = khe[ih] % SH;
1271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if (++khe[ih] > KH) khe[ih] = KH;
1273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   ssize_t kwb[IW], kwe[IW], owb[IW];
1275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t iw = 0; iw < IW; ++iw) {
1276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwe[iw] = iw + PW;
1277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     owb[iw] = OW - 1;
1278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
1279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
1280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       owb[iw] = kwe[iw] / SW;
1281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       kwb[iw] = kwe[iw] % SW;
1282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if (++kwe[iw] > KW) kwe[iw] = KW;
1284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(4))//;
1286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
1287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
1288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
1289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
1290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t kh_b = khb[ih];
1291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t kh_e = khe[ih];
1292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t oh_b = ohb[ih];
1293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           float tmp_iw[IW] alignas(128);
1295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t iw = 0; iw < IW; ++iw) {
1296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t kw_b = kwb[iw];
1297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t kw_e = kwe[iw];
1298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ow_b = owb[iw];
1299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             float tmp = 0.f;
1301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh_b < kh_e && kw_b < kw_e ){
1302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               float tmp_oc[OCOG] alignas(128);
1303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //const ssize_t tmp_oc_sz = (kh_e-kh_b)*(kw_e-kw_b)*OCOG;
1304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //float tmp_oc[tmp_oc_sz] alignas(128); // introducing this was perhaps a bit slower
1305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //ssize_t ixoc = 0;
1306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + 0) * KW + 0;
1307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t d0 = ((mb * OC + g * OCOG + 0) * OH + 0) * OW + 0;
1308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t kh = kh_b, oh=oh_b; kh < kh_e; --oh, kh+=SH) {
1309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw += SW) {
1310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
1311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //const ssize_t dst_off0 = ((mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
1312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   const ssize_t wei_off0 = w0 + kh*KW+kw;
1313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   const ssize_t dst_off0 = d0 + oh*OW+ow;
1314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t oc = 0; oc < OCOG; ++oc) {
1315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
1316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     // slower index calc...
1317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //tmp += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
1318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //tmp_oc[oc] = pdiff_dst[(int)((float)dst_off0 + (float)oc*OH_OW)]
1319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //           * pwei[(int)((float)wei_off0 + (float)oc*ICOG_KH_KW)];
1320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp_oc[oc]  = pdiff_dst[(dst_off0 + oc*OH_OW)];
1321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp_oc[oc] *= pwei[(wei_off0 + oc*ICOG_KH_KW)];
1322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp += tmp_oc[oc];
1323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //itmp_oc[ixoc] = pdiff_dst[(int)((float)dst_off0 + (float)oc*OH_OW)]
1324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //           * pwei[(int)((float)wei_off0 + (float)oc*ICOG_KH_KW)];
1325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //++ixoc;
1326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (ssize_t oc = 0; oc < tmp_oc_sz; ++oc) { tmp += tmp_oc[oc]; }
1330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //pdiff_src[src_off0+iw] = tmp; // MUST always be executed (even to store 0.f)
1333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp_iw[iw] = tmp; // MUST always be executed (even to store 0.f)
1334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0);
1336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t iw = 0; iw < IW; ++iw) {
1337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_src[src_off0+iw] = tmp_iw[iw]; // MUST always be executed (even to store 0.f)
1338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if MAC
1345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef G
1346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef MB
1347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IC
1348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OC
1349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef KH
1350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IH
1351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OH
1352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef SH
1353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef PH
1354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef KW
1355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef IW
1356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef OW
1357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef SW
1358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #undef PW
1359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #error "please enable one impl"
1362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
1364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** /** This one simplifies the hoisting function much
1366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * like \c sxconv_4_fwd.
1367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *
1368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * - simplify:
1369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * 1. When is oh_beg >= 1?
1370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - (PH - kh*DH +SH-1) / SH >= 1
1371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - PH - kh*DH + SH-1 >= SH
1372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - PH - kh*DH - 1 >= 0
1373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - kh*DH <= PH -1
1374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - kh*DH < PH
1375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - In this case, we can set oh_beg=(PH - kh*DH +SH-1) / SH,
1376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     - and it is OK if this value is > OH.
1377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * 2. When is oh_end >= OH?
1378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - (IH + PH - kh*DH + SH - 1) / SH >= OH
1379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - IH + PH - kh*DH + SH - 1 >= OH*SH
1380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - kh*DH + 1 <= IH+PH+SH - OH*SH
1381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - kh*DH + OH*SH < IH+PH+SH
1382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - In this case, we may set oh_end = OH,
1383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  * 3. When is oh_end >= 1?
1384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - this is a bit simpler: OH-->1 in above...
1385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - kh*DH < IH+PH
1386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *   - If this is *not* the case, we can set oh_end=0
1387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *     - otherwise (IH + PH - kh*DH + SH - 1) / SH
1388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  *       - (subject to oh_end <= OH)
1389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****  */
1390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** void sxconv_4_bwd_w(const prb_t *p, dnn_mem_t &src_m,
1391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
1392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t G = p->g;
1393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t MB = p->mb;
1394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IC = p->ic;
1395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH = p->ih;
1396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IW = p->iw;
1397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OC = p->oc;
1398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH = p->oh;
1399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OW = p->ow;
1400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH = p->kh;
1401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KW = p->kw;
1402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PH = p->ph;
1403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PW = p->pw;
1404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH = p->sh;
1405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SW = p->sw;
1406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DH = p->dh + 1;
1407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DW = p->dw + 1;
1408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG = IC/G;
1409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
1410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC / G;
1411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
1412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OC_OH_OW = OC * OH_OW;
1413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH_IW = IH * IW;
1414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH_KW = KH * KW;
1415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH_IW = SH * IW;
1416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const psrc = (float*)src_m;
1417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_wei = (float*)diff_wei_m;
1418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_bia = (float*)diff_bia_m;
1419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
1420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
1421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // It is hard to measure any speed difference from modifying the bwd_w_bias_update
1422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   auto bwd_w_bias_update = [&](const prb_t* p, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m){
  46              		.loc	1 1422 0
  48              	conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const:
  49              		.cfi_startproc
  50 0000 00000000 		st	%fp,0x0(,%sp)
  50      8B000911 
  51              		.cfi_def_cfa_offset	0
  52              		.cfi_offset	9,0
  53 0008 08000000 		st	%lr,0x8(,%sp)
  53      8B000A11 
  54 0010 18000000 		st	%got,0x18(,%sp)
  54      8B000F11 
  55 0018 20000000 		st	%plt,0x20(,%sp)
  55      8B001011 
  56 0020 00000000 		or	%fp,0,%sp
  56      8B000945 
  57              		.cfi_def_cfa_register	9
  58 0028 30000000 		st	%s18,48(,%fp)
  58      89001211 
  59 0030 38000000 		st	%s19,56(,%fp)
  59      89001311 
  60 0038 40000000 		st	%s20,64(,%fp)
  60      89001411 
  61 0040 48000000 		st	%s21,72(,%fp)
  61      89001511 
  62 0048 00FFFFFF 		lea	%s13,.L.1.2auto_size&0xffffffff
  62      00000D06 
  63 0050 00000000 		and	%s13,%s13,(32)0
  63      608D0D44 
  64 0058 FFFFFFFF 		lea.sl	%sp,.L.1.2auto_size>>32(%fp,%s13)
  64      8D898B06 
  65 0060 48000000 		brge.l.t	%sp,%sl,.L0.EoP
  65      888B3518 
  66 0068 18000000 		ld	%s61,0x18(,%tp)
  66      8E003D01 
  67 0070 00000000 		or	%s62,0,%s0
  67      80003E45 
  68 0078 3B010000 		lea	%s63,0x13b
  68      00003F06 
  69 0080 00000000 		shm.l	%s63,0x0(%s61)
  69      BD033F31 
  70 0088 08000000 		shm.l	%sl,0x8(%s61)
  70      BD030831 
  71 0090 10000000 		shm.l	%sp,0x10(%s61)
  71      BD030B31 
  72 0098 00000000 		monc
  72      0000003F 
  73 00a0 00000000 		or	%s0,0,%s62
  73      BE000045 
  74              	.L0.EoP:
  75              	# End of prologue codes
  76              	# line 1423
1423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
  77              		.loc	1 1423 0
  78 00a8 48000000 		ldl.zx	%s63,72(,%s1)	# *(p).dir
  78      8100BF03 
  79 00b0 00000000 		adds.w.sx	%s63,0,%s63
  79      BF003F4A 
  80 00b8 04000000 		lea	%s62,4
  80      00003E06 
  81 00c0 00000000 		and	%s62,%s63,%s62
  81      BEBF3E44 
  82 00c8 30070000 		brne.w	0,%s62,.L0.0
  82      BE008318 
  83 00d0 28000000 		br.l	.L0.1
  83      00000F18 
  84              	.L0.2:
  85              	# line 1431
1424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       float       * restrict const pdiff_bia = (float*)diff_bia_m;
1425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       float const * restrict const pdiff_dst = (float*)diff_dst_m;
1426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
1427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (int oc = 0; oc < OC     ; ++oc) {
1428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         float tmp = 0.f;
1429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         OMP(parallel for collapse(2) reduction(+:tmp))//;
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (int mb = 0; mb < MB; ++mb) {
1431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
  86              		.loc	1 1431 0
  87 00d8 80000000 		mins.l	%s61,%s59,%s61
  87      BDBB3D68 
  88 00e0 80040000 		br.l	.L0.3
  88      00000F18 
  89              	.L0.4:
  90 00e8 80000000 		mins.l	%s60,%s55,%s60
  90      BCB73C68 
  91 00f0 70010000 		br.l	.L0.5
  91      00000F18 
  92              	.L0.1:
  93              	# line 1458
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp += pdiff_dst[dst_off_f_nog_ohw(p,mb,/*g,*/oc,ohw)];
1433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
1436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         pdiff_bia[ bia_off_f_nog(p,/*g,*/oc) ] = tmp;
1437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(2) nowait)//;
1441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const ssize_t bia_off = bia_off_f(p, g, oc);
1444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         pdiff_bia[bia_off] = 0.f;
1445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
1447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
1449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
1450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
1451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
1452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   };
  94              		.loc	1 1458 0
  95              	# Start of epilogue codes
  96 00f8 30000000 		ld	%s18,48(,%fp)
  96      89001201 
  97 0100 38000000 		ld	%s19,56(,%fp)
  97      89001301 
  98 0108 40000000 		ld	%s20,64(,%fp)
  98      89001401 
  99 0110 48000000 		ld	%s21,72(,%fp)
  99      89001501 
 100 0118 00000000 		or	%sp,0,%fp
 100      89000B45 
 101              		.cfi_def_cfa	11,8
 102 0120 18000000 		ld	%got,0x18(,%sp)
 102      8B000F01 
 103 0128 20000000 		ld	%plt,0x20(,%sp)
 103      8B001001 
 104 0130 08000000 		ld	%lr,0x8(,%sp)
 104      8B000A01 
 105 0138 00000000 		ld	%fp,0x0(,%sp)
 105      8B000901 
 106 0140 00000000 		b.l	(,%lr)
 106      8A000F19 
 107              	.L0.6:
 108              	# line 1436
1436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
 109              		.loc	1 1436 0
 110 0148 00000000 		stu	%s59,0(,%s58)	# *(pdiff_bia)
 110      BA003B12 
 111              	# line 1427
1427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         float tmp = 0.f;
 112              		.loc	1 1427 0
 113 0150 00000000 		adds.l	%s57,1,%s57
 113      B9013959 
 114 0158 00000000 		adds.l	%s58,4,%s58
 114      BA043A59 
 115 0160 00000000 		adds.w.sx	%s63,1,%s63
 115      BF013F4A 
 116 0168 30050000 		brgt.l	0,%s57,.L0.7
 116      B9000118 
 117 0170 88FFFFFF 		br.l	.L0.1
 117      00000F18 
 118              	.L0.8:
 119              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp += pdiff_dst[dst_off_f_nog_ohw(p,mb,/*g,*/oc,ohw)];
 120              		.loc	1 1432 0
 121 0178 00000033 		lvs	%s59,%v51(0)
 121      00003B9E 
 122 0180 00000000 		or	%s58,0,%s3
 122      83003A45 
 123 0188 00000000 		or	%s57,0,%s4
 123      84003945 
 124 0190 00000000 		or	%s63,0,%s21
 124      95003F45 
 125 0198 00000000 		or	%s55,0,%s1
 125      81003745 
 126 01a0 00000000 		or	%s48,0,%s6
 126      86003045 
 127 01a8 00000000 		or	%s41,0,%s60
 127      BC002945 
 128 01b0 00000000 		or	%s42,0,%s56
 128      B8002A45 
 129 01b8 00000000 		or	%s54,0,%s50
 129      B2003645 
 130 01c0 00000000 		or	%s50,0,%s2
 130      82003245 
 131 01c8 00000000 		or	%s62,0,%s5
 131      85003E45 
 132 01d0 00000000 		or	%s49,0,%s7
 132      87003145 
 133 01d8 70FFFFFF 		br.l	.L0.6
 133      00000F18 
 134              	.L0.9:
 135              	# line 1430
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 136              		.loc	1 1430 0
 137 01e0 00000000 		adds.l	%s61,4,%s61
 137      BD043D59 
 138 01e8 00000000 		adds.l	%s63,%s63,%s60
 138      BCBF3F59 
 139 01f0 00000000 		adds.l	%s59,%s59,%s56
 139      B8BB3B59 
 140 01f8 00000000 		adds.l	%s58,%s58,%s56
 140      B8BA3A59 
 141 0200 00000000 		adds.l	%s57,%s57,%s56
 141      B8B93959 
 142 0208 78010000 		brgt.l	0,%s61,.L0.10
 142      BD000118 
 143 0210 68FFFFFF 		br.l	.L0.8
 143      00000F18 
 144              	.L0.11:
 145              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 146              		.loc	1 1432 0
 147 0218 00000000 		lvl	%s54
 147      00B600BF 
 148 0220 00003D32 		vfsum.s	%v50,%v61
 148      000080EC 
 149 0228 00000000 		or	%s62,1,(0)1
 149      00013E45 
 150 0230 00000000 		lvl	%s62
 150      00BE00BF 
 151 0238 00323333 		vfadd.s	%v51,%v51,%v50
 151      000080CC 
 152 0240 00000000 		or	%s56,0,%s53
 152      B5003845 
 153 0248 00000000 		or	%s60,0,%s52
 153      B4003C45 
 154 0250 00000000 		or	%s61,0,%s51
 154      B3003D45 
 155 0258 88FFFFFF 		br.l	.L0.9
 155      00000F18 
 156              	.L0.5:
 157 0260 00000000 		adds.l	%s62,%s63,(0)1
 157      00BF3E59 
 158 0268 00000000 		adds.l	%s62,%s62,%s61
 158      BDBE3E59 
 159 0270 00000000 		lvl	%s60
 159      00BC00BF 
 160 0278 0000003C 		vldu.nc	%v60,4,%s62
 160      BE040082 
 161 0280 00000000 		adds.l	%s62,%s59,(0)1
 161      00BB3E59 
 162 0288 00000000 		adds.l	%s62,%s62,%s61
 162      BDBE3E59 
 163 0290 0000003B 		vldu.nc	%v59,4,%s62
 163      BE040082 
 164 0298 003B3C3A 		vfadd.s	%v58,%v60,%v59
 164      000080CC 
 165 02a0 00000000 		adds.l	%s62,%s58,(0)1
 165      00BA3E59 
 166 02a8 00000000 		adds.l	%s62,%s62,%s61
 166      BDBE3E59 
 167 02b0 00000039 		vldu.nc	%v57,4,%s62
 167      BE040082 
 168 02b8 00393A38 		vfadd.s	%v56,%v58,%v57
 168      000080CC 
 169 02c0 00000000 		adds.l	%s62,%s57,(0)1
 169      00B93E59 
 170 02c8 00000000 		adds.l	%s62,%s62,%s61
 170      BDBE3E59 
 171 02d0 00000037 		vldu.nc	%v55,4,%s62
 171      BE040082 
 172 02d8 00373836 		vfadd.s	%v54,%v56,%v55
 172      000080CC 
 173 02e0 00363D3D 		vfadd.s	%v61,%v61,%v54
 173      000080CC 
 174              	# line 1431
1431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp += pdiff_dst[dst_off_f_nog_ohw(p,mb,/*g,*/oc,ohw)];
 175              		.loc	1 1431 0
 176 02e8 00000000 		adds.l	%s61,%s61,%s56
 176      B8BD3D59 
 177 02f0 00000000 		subs.l	%s55,%s55,%s60
 177      BCB7375B 
 178 02f8 20FFFFFF 		brge.l	0,%s55,.L0.11
 178      B7000518 
 179 0300 E8FDFFFF 		br.l	.L0.4
 179      00000F18 
 180              	.L0.12:
 181 0308 00000000 		subs.l	%s62,0,%s50
 181      B2003E5B 
 182 0310 00000000 		smvl	%s54
 182      0000362E 
 183 0318 80000000 		mins.l	%s49,%s62,%s54
 183      B6BE3168 
 184              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 185              		.loc	1 1432 0
 186 0320 00000000 		or	%s48,0,(0)1
 186      00003045 
 187 0328 00000000 		or	%s51,0,%s61
 187      BD003345 
 188 0330 00000000 		lvl	%s54
 188      00B600BF 
 189 0338 0000003D 		vbrdu	%v61,%s48
 189      00B0808C 
 190 0340 00000000 		or	%s55,0,%s62
 190      BE003745 
 191              	# line 1431
1431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp += pdiff_dst[dst_off_f_nog_ohw(p,mb,/*g,*/oc,ohw)];
 192              		.loc	1 1431 0
 193 0348 00000000 		or	%s61,0,(0)1
 193      00003D45 
 194 0350 00000000 		muls.l	%s62,4,%s49
 194      B1043E6E 
 195 0358 00000000 		or	%s52,0,%s60
 195      BC003445 
 196 0360 00000000 		or	%s53,0,%s56
 196      B8003545 
 197 0368 00000000 		or	%s60,0,%s49
 197      B1003C45 
 198 0370 00000000 		or	%s56,0,%s62
 198      BE003845 
 199 0378 E8FEFFFF 		br.l	.L0.5
 199      00000F18 
 200              	.L0.10:
 201 0380 88FFFFFF 		brlt.l	0,%s18,.L0.12
 201      92000218 
 202 0388 58FEFFFF 		br.l	.L0.9
 202      00000F18 
 203              	.L0.13:
 204 0390 00000000 		or	%s53,0,%s63
 204      BF003545 
 205 0398 00000000 		or	%s52,0,%s20
 205      94003445 
 206              	# line 1430
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 207              		.loc	1 1430 0
 208 03a0 00000000 		adds.l	%s61,%s52,%s47
 208      AFB43D59 
 209 03a8 00000000 		muls.l	%s51,%s53,%s49
 209      B1B5336E 
 210 03b0 00000000 		or	%s1,0,%s55
 210      B7000145 
 211 03b8 00000000 		or	%s2,0,%s50
 211      B2000245 
 212 03c0 00000000 		adds.l	%s51,%s51,%s48
 212      B0B33359 
 213 03c8 00000000 		muls.l	%s55,%s52,%s62
 213      BEB4376E 
 214 03d0 00000000 		or	%s50,0,%s54
 214      B6003245 
 215 03d8 00000000 		or	%s3,0,%s58
 215      BA000345 
 216 03e0 00000000 		adds.l	%s55,%s51,%s55
 216      B7B33759 
 217 03e8 00000000 		muls.l	%s54,%s53,%s49
 217      B1B5366E 
 218 03f0 00000000 		or	%s4,0,%s57
 218      B9000445 
 219 03f8 00000000 		or	%s5,0,%s62
 219      BE000545 
 220 0400 00000000 		adds.l	%s54,%s54,%s46
 220      AEB63659 
 221 0408 00000000 		muls.l	%s62,%s52,%s45
 221      ADB43E6E 
 222 0410 00000000 		or	%s6,0,%s48
 222      B0000645 
 223 0418 00000000 		or	%s7,0,%s49
 223      B1000745 
 224 0420 00000000 		adds.l	%s62,%s54,%s62
 224      BEB63E59 
 225 0428 00000000 		muls.l	%s54,%s53,%s49
 225      B1B5366E 
 226 0430 00000000 		or	%s21,0,%s63
 226      BF001545 
 227 0438 00000000 		or	%s63,0,%s55
 227      B7003F45 
 228 0440 00000000 		adds.l	%s54,%s54,%s44
 228      ACB63659 
 229 0448 00000000 		muls.l	%s55,%s52,%s45
 229      ADB4376E 
 230 0450 00000000 		adds.l	%s58,%s54,%s55
 230      B7B63A59 
 231 0458 00000000 		muls.l	%s49,%s53,%s49
 231      B1B5316E 
 232 0460 00000000 		adds.l	%s49,%s49,%s43
 232      ABB13159 
 233 0468 00000000 		muls.l	%s52,%s52,%s45
 233      ADB4346E 
 234 0470 00000000 		adds.l	%s57,%s49,%s52
 234      B4B13959 
 235              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 236              		.loc	1 1432 0
 237 0478 00000000 		or	%s55,1,(0)1
 237      00013745 
 238 0480 00000000 		lvl	%s55
 238      00B700BF 
 239 0488 00000033 		vbrdu	%v51,%s59
 239      00BB808C 
 240 0490 00000000 		or	%s59,0,%s62
 240      BE003B45 
 241 0498 00000000 		or	%s56,0,%s42
 241      AA003845 
 242 04a0 00000000 		or	%s60,0,%s41
 242      A9003C45 
 243 04a8 D8FEFFFF 		br.l	.L0.10
 243      00000F18 
 244              	.L0.14:
 245 04b0 E0FEFFFF 		brlt.l	%s55,%s19,.L0.13
 245      93B70218 
 246 04b8 90FCFFFF 		br.l	.L0.6
 246      00000F18 
 247              	.L0.15:
 248 04c0 00000035 		lvs	%s59,%v53(0)
 248      00003B9E 
 249 04c8 00000000 		or	%s55,0,%s1
 249      81003745 
 250 04d0 00000000 		or	%s63,0,%s2
 250      82003F45 
 251 04d8 00000000 		or	%s58,0,%s3
 251      83003A45 
 252 04e0 00000000 		or	%s57,0,%s4
 252      84003945 
 253 04e8 C8FFFFFF 		br.l	.L0.14
 253      00000F18 
 254              	.L0.16:
 255 04f0 20010000 		br.l	.L0.17
 255      00000F18 
 256              	.L0.18:
 257              	# line 1430
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 258              		.loc	1 1430 0
 259 04f8 00000000 		adds.w.sx	%s63,1,%s63
 259      BF013F4A 
 260 0500 00000000 		adds.l	%s61,%s62,%s61
 260      BDBE3D59 
 261 0508 E8FFFFFF 		brgt.w	0,%s63,.L0.16
 261      BF008118 
 262 0510 B0FFFFFF 		br.l	.L0.15
 262      00000F18 
 263              	.L0.19:
 264              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 265              		.loc	1 1432 0
 266 0518 00000000 		lvl	%s58
 266      00BA00BF 
 267 0520 00003F34 		vfsum.s	%v52,%v63
 267      000080EC 
 268 0528 00000000 		or	%s60,1,(0)1
 268      00013C45 
 269 0530 00000000 		lvl	%s60
 269      00BC00BF 
 270 0538 00343535 		vfadd.s	%v53,%v53,%v52
 270      000080CC 
 271 0540 00000000 		or	%s61,0,%s57
 271      B9003D45 
 272 0548 00000000 		or	%s62,0,%s56
 272      B8003E45 
 273 0550 00000000 		or	%s63,0,%s55
 273      B7003F45 
 274 0558 A0FFFFFF 		br.l	.L0.18
 274      00000F18 
 275              	.L0.3:
 276 0560 00000000 		or	%s62,0,%s63
 276      BF003E45 
 277 0568 00000000 		lvl	%s61
 277      00BD00BF 
 278 0570 0000003E 		vldu.nc	%v62,4,%s62
 278      BE040082 
 279 0578 003E3F3F 		vfadd.s	%v63,%v63,%v62
 279      000080CC 
 280              	# line 1431
1431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp += pdiff_dst[dst_off_f_nog_ohw(p,mb,/*g,*/oc,ohw)];
 281              		.loc	1 1431 0
 282 0580 00000000 		adds.l	%s63,%s63,%s60
 282      BCBF3F59 
 283 0588 00000000 		subs.l	%s59,%s59,%s61
 283      BDBB3B5B 
 284 0590 88FFFFFF 		brge.l	0,%s59,.L0.19
 284      BB000518 
 285 0598 40FBFFFF 		br.l	.L0.2
 285      00000F18 
 286              	.L0.20:
 287 05a0 00000000 		subs.l	%s53,0,%s54
 287      B600355B 
 288 05a8 00000000 		smvl	%s58
 288      00003A2E 
 289 05b0 80000000 		mins.l	%s52,%s53,%s58
 289      BAB53468 
 290              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 291              		.loc	1 1432 0
 292 05b8 00000000 		or	%s51,0,(0)1
 292      00003345 
 293 05c0 00000000 		or	%s57,0,%s61
 293      BD003945 
 294 05c8 00000000 		lvl	%s58
 294      00BA00BF 
 295 05d0 0000003F 		vbrdu	%v63,%s51
 295      00B3808C 
 296 05d8 00000000 		or	%s59,0,%s53
 296      B5003B45 
 297 05e0 00000000 		or	%s55,0,%s63
 297      BF003745 
 298 05e8 00000000 		or	%s63,0,%s61
 298      BD003F45 
 299              	# line 1431
1431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp += pdiff_dst[dst_off_f_nog_ohw(p,mb,/*g,*/oc,ohw)];
 300              		.loc	1 1431 0
 301 05f0 00000000 		muls.l	%s60,4,%s52
 301      B4043C6E 
 302 05f8 00000000 		or	%s56,0,%s62
 302      BE003845 
 303 0600 00000000 		or	%s61,0,%s52
 303      B4003D45 
 304 0608 58FFFFFF 		br.l	.L0.3
 304      00000F18 
 305              	.L0.17:
 306 0610 90FFFFFF 		brlt.l	0,%s18,.L0.20
 306      92000218 
 307 0618 E0FEFFFF 		br.l	.L0.18
 307      00000F18 
 308              	.L0.21:
 309 0620 00000000 		or	%s1,0,%s55
 309      B7000145 
 310 0628 00000000 		or	%s2,0,%s63
 310      BF000245 
 311 0630 00000000 		or	%s63,0,%s50
 311      B2003F45 
 312              	# line 1430
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 313              		.loc	1 1430 0
 314 0638 00000000 		muls.l	%s60,%s61,%s49
 314      B1BD3C6E 
 315 0640 00000000 		or	%s3,0,%s58
 315      BA000345 
 316 0648 00000000 		or	%s4,0,%s57
 316      B9000445 
 317 0650 00000000 		adds.l	%s60,%s60,%s48
 317      B0BC3C59 
 318 0658 00000000 		or	%s61,0,%s60
 318      BC003D45 
 319              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 320              		.loc	1 1432 0
 321 0660 00000000 		or	%s60,1,(0)1
 321      00013C45 
 322 0668 00000000 		or	%s59,0,(0)1
 322      00003B45 
 323 0670 00000000 		lvl	%s60
 323      00BC00BF 
 324 0678 00000035 		vbrdu	%v53,%s59
 324      00BB808C 
 325 0680 90FFFFFF 		br.l	.L0.17
 325      00000F18 
 326              	.L0.22:
 327 0688 98FFFFFF 		brlt.w	0,%s20,.L0.21
 327      94008218 
 328 0690 20FEFFFF 		br.l	.L0.14
 328      00000F18 
 329              	.L0.7:
 330 0698 00000000 		or	%s61,0,%s63
 330      BF003D45 
 331              	# line 1430
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 332              		.loc	1 1430 0
 333 06a0 00000000 		or	%s59,0,(0)1
 333      00003B45 
 334 06a8 E0FFFFFF 		brlt.l	0,%s19,.L0.22
 334      93000218 
 335 06b0 98FAFFFF 		br.l	.L0.6
 335      00000F18 
 336              	.L0.23:
 337 06b8 08000000 		dld	%s61,8(,%s0)	# *(this).MB
 337      80003D09 
 338 06c0 00000000 		dld	%s19,0(,%s61)	# *(*(this).MB)
 338      BD001309 
 339 06c8 00000000 		subs.l	%s47,0,%s19
 339      93002F5B 
 340 06d0 00000000 		and	%s61,%s19,(62)0
 340      7E933D44 
 341 06d8 00000000 		adds.w.sx	%s20,0,%s61
 341      BD00144A 
 342 06e0 00000000 		or	%s55,0,%s20
 342      94003745 
 343 06e8 00000000 		subs.w.sx	%s50,0,%s20
 343      9400325A 
 344              	# line 1431
1431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             tmp += pdiff_dst[dst_off_f_nog_ohw(p,mb,/*g,*/oc,ohw)];
 345              		.loc	1 1431 0
 346 06f0 10000000 		dld	%s61,16(,%s0)	# *(this).OH
 346      80003D09 
 347 06f8 00000000 		dld	%s61,0(,%s61)	# *(*(this).OH)
 347      BD003D09 
 348 0700 18000000 		dld	%s0,24(,%s0)	# *(this).OW
 348      80000009 
 349 0708 00000000 		dld	%s0,0(,%s0)	# *(*(this).OW)
 349      80000009 
 350 0710 00000000 		muls.l	%s18,%s61,%s0
 350      80BD126E 
 351 0718 00000000 		subs.l	%s54,0,%s18
 351      9200365B 
 352              	# line 1427
1427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         float tmp = 0.f;
 353              		.loc	1 1427 0
 354 0720 00000000 		subs.l	%s61,0,%s62
 354      BE003D5B 
 355 0728 00000000 		or	%s57,0,%s61
 355      BD003945 
 356              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 357              		.loc	1 1432 0
 358 0730 14000000 		dldl.sx	%s61,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 358      81003D0B 
 359 0738 00000000 		or	%s61,0,%s61
 359      BD003D45 
 360 0740 00000000 		or	%s61,0,%s61
 360      BD003D45 
 361 0748 18000000 		dldl.sx	%s60,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 361      81003C0B 
 362 0750 00000000 		or	%s60,0,%s60
 362      BC003C45 
 363 0758 00000000 		or	%s60,0,%s60
 363      BC003C45 
 364              	# line 1430
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 365              		.loc	1 1430 0
 366 0760 00000000 		muls.l	%s59,%s61,%s60
 366      BCBD3B6E 
 367              	# line 1432
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 368              		.loc	1 1432 0
 369 0768 1C000000 		dldl.sx	%s1,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 369      8100010B 
 370 0770 00000000 		or	%s1,0,%s1
 370      81000145 
 371 0778 00000000 		or	%s1,0,%s1
 371      81000145 
 372              	# line 1430
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 373              		.loc	1 1430 0
 374 0780 00000000 		muls.l	%s59,%s1,%s59
 374      BB813B6E 
 375 0788 00000000 		muls.l	%s56,8,%s59
 375      BB08386E 
 376 0790 00000000 		muls.l	%s1,%s60,%s1
 376      81BC016E 
 377 0798 00000000 		or	%s58,0,%s2
 377      82003A45 
 378 07a0 00000000 		muls.l	%s62,4,%s59
 378      BB043E6E 
 379 07a8 00000000 		muls.l	%s41,4,%s62
 379      BE04296E 
 380 07b0 00000000 		muls.l	%s61,4,%s61
 380      BD043D6E 
 381 07b8 00000000 		muls.l	%s45,%s61,%s1
 381      81BD2D6E 
 382 07c0 00000000 		muls.l	%s42,4,%s45
 382      AD042A6E 
 383 07c8 00000000 		muls.l	%s49,4,%s1
 383      8104316E 
 384 07d0 00000000 		muls.l	%s59,12,%s59
 384      BB0C3B6E 
 385 07d8 00000000 		adds.l	%s46,%s48,%s45
 385      ADB02E59 
 386 07e0 00000000 		adds.l	%s44,%s48,%s56
 386      B8B02C59 
 387 07e8 00000000 		adds.l	%s43,%s48,%s59
 387      BBB02B59 
 388 07f0 A8FEFFFF 		br.l	.L0.7
 388      00000F18 
 389              	.L0.0:
 390              	# line 1424
1424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       float const * restrict const pdiff_dst = (float*)diff_dst_m;
 391              		.loc	1 1424 0
 392 07f8 A8010000 		ld	%s2,424(,%s2)	# *(diff_bia_m).data_
 392      82000201 
 393              	# line 1425
1425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 394              		.loc	1 1425 0
 395 0800 A8010000 		ld	%s48,424(,%s3)	# *(diff_dst_m).data_
 395      83003001 
 396              	# line 1427
1427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         float tmp = 0.f;
 397              		.loc	1 1427 0
 398 0808 00000000 		or	%s63,0,(0)1
 398      00003F45 
 399 0810 00000000 		ld	%s62,0(,%s0)	# *(this).OC
 399      80003E01 
 400 0818 00000000 		ld	%s62,0(,%s62)	# *(*(this).OC)
 400      BE003E01 
 401 0820 98FEFFFF 		brlt.l	0,%s62,.L0.23
 401      BE000218 
 402 0828 D0F8FFFF 		br.l	.L0.1
 402      00000F18 
 403              		.cfi_endproc
 404              		.set	.L.1.2auto_size,	0xffffffffffffff00	# 256 Bytes
 406              	# ============ End  _ZZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_clES2
 407              	# ============ Begin  _INTERNAL_12_sx_conv4_cpp_bd510499::conv::chk(bool, char const*, char const*, int) ============
 408              		.section .rodata
 409              		.balign 16
 411              	.LP.__string.0:
 412 0000 40       		.byte	64
 413 0001 40       		.byte	64
 414 0002 40       		.byte	64
 415 0003 20       		.byte	32
 416 0004 65       		.byte	101
 417 0005 72       		.byte	114
 418 0006 72       		.byte	114
 419 0007 6F       		.byte	111
 420 0008 72       		.byte	114
 421 0009 3A       		.byte	58
 422 000a 20       		.byte	32
 423 000b 25       		.byte	37
 424 000c 73       		.byte	115
 425 000d 20       		.byte	32
 426 000e 3A       		.byte	58
 427 000f 20       		.byte	32
 428 0010 5B       		.byte	91
 429 0011 25       		.byte	37
 430 0012 73       		.byte	115
 431 0013 3A       		.byte	58
 432 0014 25       		.byte	37
 433 0015 64       		.byte	100
 434 0016 5D       		.byte	93
 435 0017 0A       		.byte	10
 436 0018 00       		.zero	1
 437              		.text
 438              		.balign 16
 439              	# line 36
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
 440              		.loc	1 36 0
 442              	_INTERNAL_12_sx_conv4_cpp_bd510499::conv::chk(bool, char const*, char const*, int):
 443              		.cfi_startproc
 444 0830 00000000 		st	%fp,0x0(,%sp)
 444      8B000911 
 445              		.cfi_def_cfa_offset	0
 446              		.cfi_offset	9,0
 447 0838 08000000 		st	%lr,0x8(,%sp)
 447      8B000A11 
 448 0840 18000000 		st	%got,0x18(,%sp)
 448      8B000F11 
 449 0848 20000000 		st	%plt,0x20(,%sp)
 449      8B001011 
 450 0850 00000000 		or	%fp,0,%sp
 450      8B000945 
 451              		.cfi_def_cfa_register	9
 452 0858 30FEFFFF 		lea	%s13,.L.2.2auto_size&0xffffffff
 452      00000D06 
 453 0860 00000000 		and	%s13,%s13,(32)0
 453      608D0D44 
 454 0868 FFFFFFFF 		lea.sl	%sp,.L.2.2auto_size>>32(%fp,%s13)
 454      8D898B06 
 455 0870 48000000 		brge.l.t	%sp,%sl,.L1.EoP
 455      888B3518 
 456 0878 18000000 		ld	%s61,0x18(,%tp)
 456      8E003D01 
 457 0880 00000000 		or	%s62,0,%s0
 457      80003E45 
 458 0888 3B010000 		lea	%s63,0x13b
 458      00003F06 
 459 0890 00000000 		shm.l	%s63,0x0(%s61)
 459      BD033F31 
 460 0898 08000000 		shm.l	%sl,0x8(%s61)
 460      BD030831 
 461 08a0 10000000 		shm.l	%sp,0x10(%s61)
 461      BD030B31 
 462 08a8 00000000 		monc
 462      0000003F 
 463 08b0 00000000 		or	%s0,0,%s62
 463      BE000045 
 464              	.L1.EoP:
 465              	# End of prologue codes
 466 08b8 00000000 		or	%s0,0,%s0
 466      80000045 
 467 08c0 40000000 		breq.w	0,%s0,.L1.0
 467      80008418 
 468 08c8 08000000 		br.l	.L1.1
 468      00000F18 
 469              	.L1.1:
 470              	# line 38
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** static bool trivial( int const verb, bool const cond, char const* msg,
 471              		.loc	1 38 0
 472              	# Start of epilogue codes
 473 08d0 00000000 		or	%sp,0,%fp
 473      89000B45 
 474              		.cfi_def_cfa	11,8
 475 08d8 18000000 		ld	%got,0x18(,%sp)
 475      8B000F01 
 476 08e0 20000000 		ld	%plt,0x20(,%sp)
 476      8B001001 
 477 08e8 08000000 		ld	%lr,0x8(,%sp)
 477      8B000A01 
 478 08f0 00000000 		ld	%fp,0x0(,%sp)
 478      8B000901 
 479 08f8 00000000 		b.l	(,%lr)
 479      8A000F19 
 480              	.L1.0:
 481              	# line 37
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 482              		.loc	1 37 0
 483 0900 00000000 		lea	%s0,.LP.__string.0@LO
 483      00000006 
 484 0908 00000000 		and	%s0,%s0,(32)0
 484      60800044 
 485 0910 00000000 		lea.sl	%s0,.LP.__string.0@HI(,%s0)
 485      80008006 
 486 0918 B0000000 		st	%s0,176(,%sp)
 486      8B000011 
 487 0920 B8000000 		st	%s1,184(,%sp)
 487      8B000111 
 488 0928 C0000000 		st	%s2,192(,%sp)
 488      8B000211 
 489 0930 C8000000 		st	%s3,200(,%sp)
 489      8B000311 
 490 0938 00000000 		lea	%s12,printf@LO
 490      00000C06 
 491 0940 00000000 		and	%s12,%s12,(32)0
 491      608C0C44 
 492 0948 00000000 		lea.sl	%s12,printf@HI(,%s12)
 492      8C008C06 
 493 0950 00000000 		bsic	%lr,(,%s12)	# printf
 493      8C000A08 
 494 0958 00000000 		or	%s0,1,(0)1
 494      00010045 
 495 0960 00000000 		lea	%s12,exit@LO
 495      00000C06 
 496 0968 00000000 		and	%s12,%s12,(32)0
 496      608C0C44 
 497 0970 00000000 		lea.sl	%s12,exit@HI(,%s12)
 497      8C008C06 
 498 0978 00000000 		bsic	%lr,(,%s12)	# exit
 498      8C000A08 
 499 0980 50FFFFFF 		br.l	.L1.1
 499      00000F18 
 500              		.cfi_endproc
 501              		.set	.L.2.2auto_size,	0xfffffffffffffe30	# 464 Bytes
 503              	# ============ End  _INTERNAL_12_sx_conv4_cpp_bd510499::conv::chk(bool, char const*, char const*, int) ============
 504              	# ============ Begin  conv::sxconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 505              		.data
 506              		.balign 16
 509              	.LP._ZN4conv12sxconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 510 0000 00000000 		.long	__vla_dealloc_eh
 510      00000000 
 511 0008 0000     		.zero	2
 512 000a FFFF     		.short	65535
 513 000c 04       		.byte	4
 514 000d 000000   		.zero	3
 515 0010 00000000 		.long	__vla_dealloc_eh
 515      00000000 
 516 0018 0100     		.short	1
 517 001a 0000     		.zero	2
 518 001c 04       		.byte	4
 519 001d 000000   		.zero	3
 520 0020 00000000 		.long	__vla_dealloc_eh
 520      00000000 
 521 0028 0200     		.short	2
 522 002a 0100     		.short	1
 523 002c 04       		.byte	4
 524 002d 000000   		.zero	3
 525 0030 00000000 		.long	__vla_dealloc_eh
 525      00000000 
 526 0038 0300     		.short	3
 527 003a 0200     		.short	2
 528 003c 04       		.byte	4
 529 003d 000000   		.zero	3
 530 0040 00000000 		.long	__vla_dealloc_eh
 530      00000000 
 531 0048 0400     		.short	4
 532 004a 0300     		.short	3
 533 004c 04       		.byte	4
 534 004d 000000   		.zero	3
 535 0050 00000000 		.long	__vla_dealloc_eh
 535      00000000 
 536 0058 0500     		.short	5
 537 005a 0400     		.short	4
 538 005c 04       		.byte	4
 539 005d 000000   		.zero	3
 540              		.balign 1
 543              	.LP.__12_sx_conv4_cpp_bd510499.0.__unnamed.0:
 544 0060 76       		.byte	118
 545 0061 6F       		.byte	111
 546 0062 69       		.byte	105
 547 0063 64       		.byte	100
 548 0064 20       		.byte	32
 549 0065 63       		.byte	99
 550 0066 6F       		.byte	111
 551 0067 6E       		.byte	110
 552 0068 76       		.byte	118
 553 0069 3A       		.byte	58
 554 006a 3A       		.byte	58
 555 006b 73       		.byte	115
 556 006c 78       		.byte	120
 557 006d 63       		.byte	99
 558 006e 6F       		.byte	111
 559 006f 6E       		.byte	110
 560 0070 76       		.byte	118
 561 0071 5F       		.byte	95
 562 0072 34       		.byte	52
 563 0073 5F       		.byte	95
 564 0074 66       		.byte	102
 565 0075 77       		.byte	119
 566 0076 64       		.byte	100
 567 0077 28       		.byte	40
 568 0078 63       		.byte	99
 569 0079 6F       		.byte	111
 570 007a 6E       		.byte	110
 571 007b 73       		.byte	115
 572 007c 74       		.byte	116
 573 007d 20       		.byte	32
 574 007e 63       		.byte	99
 575 007f 6F       		.byte	111
 576 0080 6E       		.byte	110
 577 0081 76       		.byte	118
 578 0082 3A       		.byte	58
 579 0083 3A       		.byte	58
 580 0084 70       		.byte	112
 581 0085 72       		.byte	114
 582 0086 62       		.byte	98
 583 0087 5F       		.byte	95
 584 0088 74       		.byte	116
 585 0089 20       		.byte	32
 586 008a 2A       		.byte	42
 587 008b 2C       		.byte	44
 588 008c 20       		.byte	32
 589 008d 64       		.byte	100
 590 008e 6E       		.byte	110
 591 008f 6E       		.byte	110
 592 0090 5F       		.byte	95
 593 0091 6D       		.byte	109
 594 0092 65       		.byte	101
 595 0093 6D       		.byte	109
 596 0094 5F       		.byte	95
 597 0095 74       		.byte	116
 598 0096 20       		.byte	32
 599 0097 26       		.byte	38
 600 0098 2C       		.byte	44
 601 0099 20       		.byte	32
 602 009a 64       		.byte	100
 603 009b 6E       		.byte	110
 604 009c 6E       		.byte	110
 605 009d 5F       		.byte	95
 606 009e 6D       		.byte	109
 607 009f 65       		.byte	101
 608 00a0 6D       		.byte	109
 609 00a1 5F       		.byte	95
 610 00a2 74       		.byte	116
 611 00a3 20       		.byte	32
 612 00a4 26       		.byte	38
 613 00a5 2C       		.byte	44
 614 00a6 20       		.byte	32
 615 00a7 64       		.byte	100
 616 00a8 6E       		.byte	110
 617 00a9 6E       		.byte	110
 618 00aa 5F       		.byte	95
 619 00ab 6D       		.byte	109
 620 00ac 65       		.byte	101
 621 00ad 6D       		.byte	109
 622 00ae 5F       		.byte	95
 623 00af 74       		.byte	116
 624 00b0 20       		.byte	32
 625 00b1 26       		.byte	38
 626 00b2 2C       		.byte	44
 627 00b3 20       		.byte	32
 628 00b4 64       		.byte	100
 629 00b5 6E       		.byte	110
 630 00b6 6E       		.byte	110
 631 00b7 5F       		.byte	95
 632 00b8 6D       		.byte	109
 633 00b9 65       		.byte	101
 634 00ba 6D       		.byte	109
 635 00bb 5F       		.byte	95
 636 00bc 74       		.byte	116
 637 00bd 20       		.byte	32
 638 00be 26       		.byte	38
 639 00bf 29       		.byte	41
 640 00c0 00       		.zero	1
 641              		.section .rodata
 642 0019 00000000 		.balign 16
 642      000000
 644              	.LP.__string.1:
 645 0020 70       		.byte	112
 646 0021 2D       		.byte	45
 647 0022 3E       		.byte	62
 648 0023 6B       		.byte	107
 649 0024 68       		.byte	104
 650 0025 20       		.byte	32
 651 0026 3E       		.byte	62
 652 0027 20       		.byte	32
 653 0028 30       		.byte	48
 654 0029 20       		.byte	32
 655 002a 26       		.byte	38
 656 002b 26       		.byte	38
 657 002c 20       		.byte	32
 658 002d 4B       		.byte	75
 659 002e 57       		.byte	87
 660 002f 20       		.byte	32
 661 0030 3E       		.byte	62
 662 0031 20       		.byte	32
 663 0032 30       		.byte	48
 664 0033 00       		.zero	1
 665 0034 00000000 		.balign 8
 667              	.LP.__string.2:
 668 0038 40       		.byte	64
 669 0039 40       		.byte	64
 670 003a 40       		.byte	64
 671 003b 20       		.byte	32
 672 003c 65       		.byte	101
 673 003d 72       		.byte	114
 674 003e 72       		.byte	114
 675 003f 6F       		.byte	111
 676 0040 72       		.byte	114
 677 0041 3A       		.byte	58
 678 0042 20       		.byte	32
 679 0043 25       		.byte	37
 680 0044 73       		.byte	115
 681 0045 20       		.byte	32
 682 0046 3A       		.byte	58
 683 0047 20       		.byte	32
 684 0048 5B       		.byte	91
 685 0049 25       		.byte	37
 686 004a 73       		.byte	115
 687 004b 3A       		.byte	58
 688 004c 25       		.byte	37
 689 004d 64       		.byte	100
 690 004e 5D       		.byte	93
 691 004f 0A       		.byte	10
 692 0050 00       		.zero	1
 693 0051 00000000 		.balign 8
 693      000000
 695              	.LP.__string.3:
 696 0058 70       		.byte	112
 697 0059 2D       		.byte	45
 698 005a 3E       		.byte	62
 699 005b 64       		.byte	100
 700 005c 68       		.byte	104
 701 005d 20       		.byte	32
 702 005e 3E       		.byte	62
 703 005f 3D       		.byte	61
 704 0060 20       		.byte	32
 705 0061 30       		.byte	48
 706 0062 20       		.byte	32
 707 0063 26       		.byte	38
 708 0064 26       		.byte	38
 709 0065 20       		.byte	32
 710 0066 70       		.byte	112
 711 0067 2D       		.byte	45
 712 0068 3E       		.byte	62
 713 0069 64       		.byte	100
 714 006a 77       		.byte	119
 715 006b 20       		.byte	32
 716 006c 3E       		.byte	62
 717 006d 3D       		.byte	61
 718 006e 20       		.byte	32
 719 006f 30       		.byte	48
 720 0070 00       		.zero	1
 721 0071 00000000 		.balign 8
 721      000000
 723              	.LP.__string.4:
 724 0078 40       		.byte	64
 725 0079 40       		.byte	64
 726 007a 40       		.byte	64
 727 007b 20       		.byte	32
 728 007c 65       		.byte	101
 729 007d 72       		.byte	114
 730 007e 72       		.byte	114
 731 007f 6F       		.byte	111
 732 0080 72       		.byte	114
 733 0081 3A       		.byte	58
 734 0082 20       		.byte	32
 735 0083 25       		.byte	37
 736 0084 73       		.byte	115
 737 0085 20       		.byte	32
 738 0086 3A       		.byte	58
 739 0087 20       		.byte	32
 740 0088 5B       		.byte	91
 741 0089 25       		.byte	37
 742 008a 73       		.byte	115
 743 008b 3A       		.byte	58
 744 008c 25       		.byte	37
 745 008d 64       		.byte	100
 746 008e 5D       		.byte	93
 747 008f 0A       		.byte	10
 748 0090 00       		.zero	1
 749 0091 00000000 		.balign 8
 749      000000
 751              	.LP.__string.5:
 752 0098 53       		.byte	83
 753 0099 48       		.byte	72
 754 009a 20       		.byte	32
 755 009b 3E       		.byte	62
 756 009c 3D       		.byte	61
 757 009d 20       		.byte	32
 758 009e 30       		.byte	48
 759 009f 20       		.byte	32
 760 00a0 26       		.byte	38
 761 00a1 26       		.byte	38
 762 00a2 20       		.byte	32
 763 00a3 53       		.byte	83
 764 00a4 57       		.byte	87
 765 00a5 20       		.byte	32
 766 00a6 3E       		.byte	62
 767 00a7 3D       		.byte	61
 768 00a8 20       		.byte	32
 769 00a9 30       		.byte	48
 770 00aa 00       		.zero	1
 771 00ab 00000000 		.balign 8
 771      00
 773              	.LP.__string.6:
 774 00b0 40       		.byte	64
 775 00b1 40       		.byte	64
 776 00b2 40       		.byte	64
 777 00b3 20       		.byte	32
 778 00b4 65       		.byte	101
 779 00b5 72       		.byte	114
 780 00b6 72       		.byte	114
 781 00b7 6F       		.byte	111
 782 00b8 72       		.byte	114
 783 00b9 3A       		.byte	58
 784 00ba 20       		.byte	32
 785 00bb 25       		.byte	37
 786 00bc 73       		.byte	115
 787 00bd 20       		.byte	32
 788 00be 3A       		.byte	58
 789 00bf 20       		.byte	32
 790 00c0 5B       		.byte	91
 791 00c1 25       		.byte	37
 792 00c2 73       		.byte	115
 793 00c3 3A       		.byte	58
 794 00c4 25       		.byte	37
 795 00c5 64       		.byte	100
 796 00c6 5D       		.byte	93
 797 00c7 0A       		.byte	10
 798 00c8 00       		.zero	1
 799 00c9 00000000 		.balign 8
 799      000000
 801              	.LP._ZN4conv12sxconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.khkw_muls.__initializer.1:
 802 00d0 01000000 		.long	1
 802      00000000 
 803 00d8 00000000 		.zero	8
 803      00000000 
 804 00e0 00000100 		.long	65536
 804      00000000 
 805 00e8 00000000 		.zero	8
 805      00000000 
 806              		.text
 807 0988 00000000 		.balign 16
 807      00000000 
 808              	# line 354
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // V 8 is default
 809              		.loc	1 354 0
 810              		.globl	conv::sxconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 812              	conv::sxconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 813              		.cfi_startproc
 814 0990 00000000 		st	%fp,0x0(,%sp)
 814      8B000911 
 815              		.cfi_def_cfa_offset	0
 816              		.cfi_offset	9,0
 817 0998 08000000 		st	%lr,0x8(,%sp)
 817      8B000A11 
 818 09a0 18000000 		st	%got,0x18(,%sp)
 818      8B000F11 
 819 09a8 20000000 		st	%plt,0x20(,%sp)
 819      8B001011 
 820 09b0 00000000 		or	%fp,0,%sp
 820      8B000945 
 821              		.cfi_def_cfa_register	9
 822 09b8 30000000 		st	%s18,48(,%fp)
 822      89001211 
 823 09c0 38000000 		st	%s19,56(,%fp)
 823      89001311 
 824 09c8 40000000 		st	%s20,64(,%fp)
 824      89001411 
 825 09d0 48000000 		st	%s21,72(,%fp)
 825      89001511 
 826 09d8 50000000 		st	%s22,80(,%fp)
 826      89001611 
 827 09e0 58000000 		st	%s23,88(,%fp)
 827      89001711 
 828 09e8 60000000 		st	%s24,96(,%fp)
 828      89001811 
 829 09f0 68000000 		st	%s25,104(,%fp)
 829      89001911 
 830 09f8 70000000 		st	%s26,112(,%fp)
 830      89001A11 
 831 0a00 78000000 		st	%s27,120(,%fp)
 831      89001B11 
 832 0a08 80000000 		st	%s28,128(,%fp)
 832      89001C11 
 833 0a10 88000000 		st	%s29,136(,%fp)
 833      89001D11 
 834 0a18 90000000 		st	%s30,144(,%fp)
 834      89001E11 
 835 0a20 98000000 		st	%s31,152(,%fp)
 835      89001F11 
 836 0a28 A0000000 		st	%s32,160(,%fp)
 836      89002011 
 837 0a30 A8000000 		st	%s33,168(,%fp)
 837      89002111 
 838 0a38 F0D5FFFF 		lea	%s13,.L.3.2auto_size&0xffffffff
 838      00000D06 
 839 0a40 00000000 		and	%s13,%s13,(32)0
 839      608D0D44 
 840 0a48 FFFFFFFF 		lea.sl	%sp,.L.3.2auto_size>>32(%fp,%s13)
 840      8D898B06 
 841 0a50 48000000 		brge.l.t	%sp,%sl,.L2.EoP
 841      888B3518 
 842 0a58 18000000 		ld	%s61,0x18(,%tp)
 842      8E003D01 
 843 0a60 00000000 		or	%s62,0,%s0
 843      80003E45 
 844 0a68 3B010000 		lea	%s63,0x13b
 844      00003F06 
 845 0a70 00000000 		shm.l	%s63,0x0(%s61)
 845      BD033F31 
 846 0a78 08000000 		shm.l	%sl,0x8(%s61)
 846      BD030831 
 847 0a80 10000000 		shm.l	%sp,0x10(%s61)
 847      BD030B31 
 848 0a88 00000000 		monc
 848      0000003F 
 849 0a90 00000000 		or	%s0,0,%s62
 849      BE000045 
 850              	.L2.EoP:
 851              	# End of prologue codes
 852 0a98 00000000 		lea	%s63,__curr_eh_stack_entry@LO
 852      00003F06 
 853 0aa0 00000000 		and	%s63,%s63,(32)0
 853      60BF3F44 
 854 0aa8 00000000 		lea.sl	%s63,__curr_eh_stack_entry@HI(,%s63)
 854      BF00BF06 
 855 0ab0 00000000 		ld	%s62,0(,%s63)
 855      BF003E01 
 856 0ab8 D8FDFFFF 		st	%s62,-552(,%fp)
 856      89003E11 
 857 0ac0 D8FDFFFF 		lea	%s62,-552
 857      00003E06 
 858 0ac8 00000000 		adds.l	%s62,%fp,%s62
 858      BE893E59 
 859 0ad0 00000000 		st	%s62,0(,%s63)
 859      BF003E11 
 860 0ad8 00000000 		or	%s63,1,(0)1
 860      00013F45 
 861 0ae0 E0FDFFFF 		st1b	%s63,-544(,%fp)
 861      89003F15 
 862              	# line 512
 512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t MB = p->mb;
 863              		.loc	1 512 0
 864 0ae8 00000000 		ldl.sx	%s63,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 864      80003F03 
 865 0af0 00000000 		or	%s63,0,%s63
 865      BF003F45 
 866 0af8 00000000 		lea	%s62,.LP._ZN4conv12sxconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 866      00003E06 
 867 0b00 00000000 		and	%s62,%s62,(32)0
 867      60BE3E44 
 868 0b08 00000000 		lea.sl	%s62,.LP._ZN4conv12sxconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s62)
 868      BE00BE06 
 869 0b10 E8FDFFFF 		st	%s62,-536(,%fp)
 869      89003E11 
 870 0b18 58FFFFFF 		lea	%s62,-168
 870      00003E06 
 871 0b20 00000000 		adds.l	%s62,%fp,%s62
 871      BE893E59 
 872 0b28 F0FDFFFF 		st	%s62,-528(,%fp)
 872      89003E11 
 873 0b30 00000000 		lea	%s62,__eh_curr_region@LO
 873      00003E06 
 874 0b38 00000000 		and	%s62,%s62,(32)0
 874      60BE3E44 
 875 0b40 00000000 		lea.sl	%s62,__eh_curr_region@HI(,%s62)
 875      BE00BE06 
 876 0b48 00000000 		ld2b.zx	%s60,0(,%s62)
 876      BE00BC04 
 877 0b50 00FEFFFF 		st2b	%s60,-512(,%fp)
 877      89003C14 
 878 0b58 FFFF0000 		lea	%s60,65535
 878      00003C06 
 879 0b60 00000000 		st2b	%s60,0(,%s62)
 879      BE003C14 
 880              	# line 513
 513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IC = p->ic;
 881              		.loc	1 513 0
 882 0b68 04000000 		ldl.sx	%s62,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 882      80003E03 
 883 0b70 00000000 		or	%s21,0,%s62
 883      BE001545 
 884              	# line 514
 514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH = p->ih;
 885              		.loc	1 514 0
 886 0b78 08000000 		ldl.sx	%s62,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 886      80003E03 
 887 0b80 00000000 		or	%s62,0,%s62
 887      BE003E45 
 888              	# line 529
 529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC/G;
 889              		.loc	1 529 0
 890 0b88 00000000 		divs.l	%s31,%s62,%s63
 890      BFBE1F7F 
 891              	# line 515
 515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IW = p->iw;
 892              		.loc	1 515 0
 893 0b90 0C000000 		ldl.sx	%s60,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 893      80003C03 
 894 0b98 00000000 		or	%s60,0,%s60
 894      BC003C45 
 895              	# line 516
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OC = p->oc;
 896              		.loc	1 516 0
 897 0ba0 10000000 		ldl.sx	%s59,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 897      80003B03 
 898 0ba8 00000000 		or	%s59,0,%s59
 898      BB003B45 
 899              	# line 517
 517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH = p->oh;
 900              		.loc	1 517 0
 901 0bb0 14000000 		ldl.sx	%s55,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 901      80003703 
 902 0bb8 00000000 		or	%s55,0,%s55
 902      B7003745 
 903              	# line 530
 530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH_KW = KH * KW;
 904              		.loc	1 530 0
 905 0bc0 00000000 		divs.l	%s40,%s55,%s63
 905      BFB7287F 
 906              	# line 518
 518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OW = p->ow;
 907              		.loc	1 518 0
 908 0bc8 18000000 		ldl.sx	%s54,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 908      80003603 
 909 0bd0 00000000 		or	%s20,0,%s54
 909      B6001445 
 910              	# line 519
 519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH = p->kh;
 911              		.loc	1 519 0
 912 0bd8 1C000000 		ldl.sx	%s54,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 912      80003603 
 913 0be0 00000000 		or	%s22,0,%s54
 913      B6001645 
 914              	# line 533
 533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 915              		.loc	1 533 0
 916 0be8 00000000 		muls.l	%s54,%s20,%s22
 916      9694366E 
 917              	# line 520
 520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KW = p->kw;
 918              		.loc	1 520 0
 919 0bf0 20000000 		ldl.sx	%s18,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 919      80001203 
 920 0bf8 00000000 		or	%s58,0,%s18
 920      92003A45 
 921              	# line 521
 521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PH = p->ph;
 922              		.loc	1 521 0
 923 0c00 24000000 		ldl.sx	%s53,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 923      80003503 
 924 0c08 00000000 		or	%s57,0,%s53
 924      B5003945 
 925              	# line 531
 531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 926              		.loc	1 531 0
 927 0c10 00000000 		muls.l	%s53,%s58,%s57
 927      B9BA356E 
 928              	# line 532
 532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
 929              		.loc	1 532 0
 930 0c18 00000000 		muls.l	%s19,%s31,%s53
 930      B59F136E 
 931              	# line 522
 522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PW = p->pw;
 932              		.loc	1 522 0
 933 0c20 30000000 		ldl.sx	%s52,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 933      80003403 
 934 0c28 00000000 		or	%s52,0,%s52
 934      B4003445 
 935              	# line 523
 523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH = p->sh;
 936              		.loc	1 523 0
 937 0c30 34000000 		ldl.sx	%s50,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 937      80003203 
 938 0c38 00000000 		or	%s50,0,%s50
 938      B2003245 
 939              	# line 524
 524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SW = p->sw;
 940              		.loc	1 524 0
 941 0c40 28000000 		ldl.sx	%s48,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 941      80003003 
 942 0c48 00000000 		or	%s51,0,%s48
 942      B0003345 
 943              	# line 525
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DH = p->dh + 1;
 944              		.loc	1 525 0
 945 0c50 2C000000 		ldl.sx	%s48,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 945      80003003 
 946 0c58 00000000 		or	%s49,0,%s48
 946      B0003145 
 947              	# line 526
 526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DW = p->dw + 1;
 948              		.loc	1 526 0
 949 0c60 38000000 		ldl.sx	%s48,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 949      80003003 
 950 0c68 00000000 		adds.w.sx	%s48,1,%s48
 950      B001304A 
 951 0c70 00000000 		or	%s56,0,%s48
 951      B0003845 
 952              	# line 527
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 953              		.loc	1 527 0
 954 0c78 3C000000 		ldl.sx	%s48,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 954      80003003 
 955 0c80 00000000 		adds.w.sx	%s48,1,%s48
 955      B001304A 
 956 0c88 00000000 		or	%s46,0,%s48
 956      B0002E45 
 957 0c90 F82E0000 		brlt.w	0,%s18,.L2.0
 957      92008218 
 958              	.L2.1:
 959              	# line 540
 540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 960              		.loc	1 540 0
 961 0c98 00000000 		or	%s48,0,(0)1
 961      00003045 
 962 0ca0 00000000 		or	%s61,0,%s0
 962      80003D45 
 963 0ca8 602E0000 		br.l	.L2.2
 963      00000F18 
 964              	.L2.3:
 965 0cb0 B8F5FFFF 		st	%s61,-2632(,%fp)	# spill 
 965      89003D11 
 966 0cb8 70EAFFFF 		st	%s1,-5520(,%fp)	# spill 
 966      89000111 
 967 0cc0 68EAFFFF 		st	%s2,-5528(,%fp)	# spill 
 967      89000211 
 968 0cc8 60EAFFFF 		st	%s3,-5536(,%fp)	# spill 
 968      89000311 
 969 0cd0 58EAFFFF 		st	%s4,-5544(,%fp)	# spill 
 969      89000411 
 970 0cd8 A8EAFFFF 		st	%s54,-5464(,%fp)	# spill 
 970      89003611 
 971 0ce0 50EAFFFF 		st	%s53,-5552(,%fp)	# spill 
 971      89003511 
 972 0ce8 A0F5FFFF 		st	%s40,-2656(,%fp)	# spill 
 972      89002811 
 973 0cf0 90F5FFFF 		st	%s46,-2672(,%fp)	# spill 
 973      89002E11 
 974 0cf8 88F5FFFF 		st	%s56,-2680(,%fp)	# spill 
 974      89003811 
 975 0d00 80F5FFFF 		st	%s49,-2688(,%fp)	# spill 
 975      89003111 
 976 0d08 78F4FFFF 		st	%s51,-2952(,%fp)	# spill 
 976      89003311 
 977 0d10 A0EAFFFF 		st	%s50,-5472(,%fp)	# spill 
 977      89003211 
 978 0d18 98EAFFFF 		st	%s52,-5480(,%fp)	# spill 
 978      89003411 
 979 0d20 78F5FFFF 		st	%s57,-2696(,%fp)	# spill 
 979      89003911 
 980 0d28 70F5FFFF 		st	%s58,-2704(,%fp)	# spill 
 980      89003A11 
 981 0d30 90EAFFFF 		st	%s55,-5488(,%fp)	# spill 
 981      89003711 
 982 0d38 88EAFFFF 		st	%s59,-5496(,%fp)	# spill 
 982      89003B11 
 983 0d40 80EAFFFF 		st	%s60,-5504(,%fp)	# spill 
 983      89003C11 
 984 0d48 78EAFFFF 		st	%s62,-5512(,%fp)	# spill 
 984      89003E11 
 985 0d50 48EAFFFF 		st	%s63,-5560(,%fp)	# spill 
 985      89003F11 
 986              	# line 37
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 987              		.loc	1 37 0
 988 0d58 00000000 		lea	%s0,.LP.__string.2@LO
 988      00000006 
 989 0d60 00000000 		and	%s0,%s0,(32)0
 989      60800044 
 990 0d68 00000000 		lea.sl	%s0,.LP.__string.2@HI(,%s0)
 990      80008006 
 991 0d70 00000000 		or	%s2,0,%s45
 991      AD000245 
 992 0d78 B0000000 		st	%s0,176(,%sp)
 992      8B000011 
 993 0d80 B8000000 		st	%s47,184(,%sp)
 993      8B002F11 
 994 0d88 C0000000 		st	%s45,192(,%sp)
 994      8B002D11 
 995 0d90 1C020000 		lea	%s3,540
 995      00000306 
 996 0d98 00000000 		or	%s1,0,%s47
 996      AF000145 
 997 0da0 C8000000 		st	%s3,200(,%sp)
 997      8B000311 
 998 0da8 00000000 		lea	%s12,printf@LO
 998      00000C06 
 999 0db0 00000000 		and	%s12,%s12,(32)0
 999      608C0C44 
 1000 0db8 00000000 		lea.sl	%s12,printf@HI(,%s12)
 1000      8C008C06 
 1001 0dc0 00000000 		bsic	%lr,(,%s12)	# printf
 1001      8C000A08 
 1002 0dc8 00000000 		or	%s0,1,(0)1
 1002      00010045 
 1003 0dd0 00000000 		lea	%s12,exit@LO
 1003      00000C06 
 1004 0dd8 00000000 		and	%s12,%s12,(32)0
 1004      608C0C44 
 1005 0de0 00000000 		lea.sl	%s12,exit@HI(,%s12)
 1005      8C008C06 
 1006 0de8 00000000 		bsic	%lr,(,%s12)	# exit
 1006      8C000A08 
 1007 0df0 B8F5FFFF 		ld	%s61,-2632(,%fp)	# restore 
 1007      89003D01 
 1008 0df8 70EAFFFF 		ld	%s1,-5520(,%fp)	# restore 
 1008      89000101 
 1009 0e00 68EAFFFF 		ld	%s2,-5528(,%fp)	# restore 
 1009      89000201 
 1010 0e08 60EAFFFF 		ld	%s3,-5536(,%fp)	# restore 
 1010      89000301 
 1011 0e10 58EAFFFF 		ld	%s4,-5544(,%fp)	# restore 
 1011      89000401 
 1012 0e18 A8EAFFFF 		ld	%s54,-5464(,%fp)	# restore 
 1012      89003601 
 1013 0e20 50EAFFFF 		ld	%s53,-5552(,%fp)	# restore 
 1013      89003501 
 1014 0e28 A0F5FFFF 		ld	%s40,-2656(,%fp)	# restore 
 1014      89002801 
 1015 0e30 90F5FFFF 		ld	%s46,-2672(,%fp)	# restore 
 1015      89002E01 
 1016 0e38 88F5FFFF 		ld	%s56,-2680(,%fp)	# restore 
 1016      89003801 
 1017 0e40 80F5FFFF 		ld	%s49,-2688(,%fp)	# restore 
 1017      89003101 
 1018 0e48 78F4FFFF 		ld	%s51,-2952(,%fp)	# restore 
 1018      89003301 
 1019 0e50 A0EAFFFF 		ld	%s50,-5472(,%fp)	# restore 
 1019      89003201 
 1020 0e58 98EAFFFF 		ld	%s52,-5480(,%fp)	# restore 
 1020      89003401 
 1021 0e60 78F5FFFF 		ld	%s57,-2696(,%fp)	# restore 
 1021      89003901 
 1022 0e68 70F5FFFF 		ld	%s58,-2704(,%fp)	# restore 
 1022      89003A01 
 1023 0e70 90EAFFFF 		ld	%s55,-5488(,%fp)	# restore 
 1023      89003701 
 1024 0e78 88EAFFFF 		ld	%s59,-5496(,%fp)	# restore 
 1024      89003B01 
 1025 0e80 80EAFFFF 		ld	%s60,-5504(,%fp)	# restore 
 1025      89003C01 
 1026 0e88 78EAFFFF 		ld	%s62,-5512(,%fp)	# restore 
 1026      89003E01 
 1027 0e90 48EAFFFF 		ld	%s63,-5560(,%fp)	# restore 
 1027      89003F01 
 1028 0e98 582C0000 		br.l	.L2.4
 1028      00000F18 
 1029              	.L2.5:
 1030              	# line 541
 541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( SH >= 0 && SW >= 0 );
 1031              		.loc	1 541 0
 1032 0ea0 00000000 		or	%s48,0,(0)1
 1032      00003045 
 1033 0ea8 B82B0000 		br.l	.L2.6
 1033      00000F18 
 1034              	.L2.7:
 1035 0eb0 78F4FFFF 		st	%s51,-2952(,%fp)	# spill 
 1035      89003311 
 1036 0eb8 B8F5FFFF 		st	%s61,-2632(,%fp)	# spill 
 1036      89003D11 
 1037 0ec0 70EAFFFF 		st	%s1,-5520(,%fp)	# spill 
 1037      89000111 
 1038 0ec8 68EAFFFF 		st	%s2,-5528(,%fp)	# spill 
 1038      89000211 
 1039 0ed0 60EAFFFF 		st	%s3,-5536(,%fp)	# spill 
 1039      89000311 
 1040 0ed8 58EAFFFF 		st	%s4,-5544(,%fp)	# spill 
 1040      89000411 
 1041 0ee0 A8EAFFFF 		st	%s54,-5464(,%fp)	# spill 
 1041      89003611 
 1042 0ee8 50EAFFFF 		st	%s53,-5552(,%fp)	# spill 
 1042      89003511 
 1043 0ef0 A0F5FFFF 		st	%s40,-2656(,%fp)	# spill 
 1043      89002811 
 1044 0ef8 90F5FFFF 		st	%s46,-2672(,%fp)	# spill 
 1044      89002E11 
 1045 0f00 88F5FFFF 		st	%s56,-2680(,%fp)	# spill 
 1045      89003811 
 1046 0f08 80F5FFFF 		st	%s49,-2688(,%fp)	# spill 
 1046      89003111 
 1047 0f10 A0EAFFFF 		st	%s50,-5472(,%fp)	# spill 
 1047      89003211 
 1048 0f18 98EAFFFF 		st	%s52,-5480(,%fp)	# spill 
 1048      89003411 
 1049 0f20 78F5FFFF 		st	%s57,-2696(,%fp)	# spill 
 1049      89003911 
 1050 0f28 70F5FFFF 		st	%s58,-2704(,%fp)	# spill 
 1050      89003A11 
 1051 0f30 90EAFFFF 		st	%s55,-5488(,%fp)	# spill 
 1051      89003711 
 1052 0f38 88EAFFFF 		st	%s59,-5496(,%fp)	# spill 
 1052      89003B11 
 1053 0f40 80EAFFFF 		st	%s60,-5504(,%fp)	# spill 
 1053      89003C11 
 1054 0f48 78EAFFFF 		st	%s62,-5512(,%fp)	# spill 
 1054      89003E11 
 1055 0f50 48EAFFFF 		st	%s63,-5560(,%fp)	# spill 
 1055      89003F11 
 1056              	# line 37
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 1057              		.loc	1 37 0
 1058 0f58 00000000 		lea	%s0,.LP.__string.4@LO
 1058      00000006 
 1059 0f60 00000000 		and	%s0,%s0,(32)0
 1059      60800044 
 1060 0f68 00000000 		lea.sl	%s0,.LP.__string.4@HI(,%s0)
 1060      80008006 
 1061 0f70 00000000 		or	%s2,0,%s45
 1061      AD000245 
 1062 0f78 B0000000 		st	%s0,176(,%sp)
 1062      8B000011 
 1063 0f80 B8000000 		st	%s47,184(,%sp)
 1063      8B002F11 
 1064 0f88 C0000000 		st	%s45,192(,%sp)
 1064      8B002D11 
 1065 0f90 1D020000 		lea	%s3,541
 1065      00000306 
 1066 0f98 00000000 		or	%s1,0,%s47
 1066      AF000145 
 1067 0fa0 C8000000 		st	%s3,200(,%sp)
 1067      8B000311 
 1068 0fa8 00000000 		lea	%s12,printf@LO
 1068      00000C06 
 1069 0fb0 00000000 		and	%s12,%s12,(32)0
 1069      608C0C44 
 1070 0fb8 00000000 		lea.sl	%s12,printf@HI(,%s12)
 1070      8C008C06 
 1071 0fc0 00000000 		bsic	%lr,(,%s12)	# printf
 1071      8C000A08 
 1072 0fc8 00000000 		or	%s0,1,(0)1
 1072      00010045 
 1073 0fd0 00000000 		lea	%s12,exit@LO
 1073      00000C06 
 1074 0fd8 00000000 		and	%s12,%s12,(32)0
 1074      608C0C44 
 1075 0fe0 00000000 		lea.sl	%s12,exit@HI(,%s12)
 1075      8C008C06 
 1076 0fe8 00000000 		bsic	%lr,(,%s12)	# exit
 1076      8C000A08 
 1077 0ff0 78F4FFFF 		ld	%s51,-2952(,%fp)	# restore 
 1077      89003301 
 1078 0ff8 B8F5FFFF 		ld	%s61,-2632(,%fp)	# restore 
 1078      89003D01 
 1079 1000 70EAFFFF 		ld	%s1,-5520(,%fp)	# restore 
 1079      89000101 
 1080 1008 68EAFFFF 		ld	%s2,-5528(,%fp)	# restore 
 1080      89000201 
 1081 1010 60EAFFFF 		ld	%s3,-5536(,%fp)	# restore 
 1081      89000301 
 1082 1018 58EAFFFF 		ld	%s4,-5544(,%fp)	# restore 
 1082      89000401 
 1083 1020 A8EAFFFF 		ld	%s54,-5464(,%fp)	# restore 
 1083      89003601 
 1084 1028 50EAFFFF 		ld	%s53,-5552(,%fp)	# restore 
 1084      89003501 
 1085 1030 A0F5FFFF 		ld	%s40,-2656(,%fp)	# restore 
 1085      89002801 
 1086 1038 90F5FFFF 		ld	%s46,-2672(,%fp)	# restore 
 1086      89002E01 
 1087 1040 88F5FFFF 		ld	%s56,-2680(,%fp)	# restore 
 1087      89003801 
 1088 1048 80F5FFFF 		ld	%s49,-2688(,%fp)	# restore 
 1088      89003101 
 1089 1050 A0EAFFFF 		ld	%s50,-5472(,%fp)	# restore 
 1089      89003201 
 1090 1058 98EAFFFF 		ld	%s52,-5480(,%fp)	# restore 
 1090      89003401 
 1091 1060 78F5FFFF 		ld	%s57,-2696(,%fp)	# restore 
 1091      89003901 
 1092 1068 70F5FFFF 		ld	%s58,-2704(,%fp)	# restore 
 1092      89003A01 
 1093 1070 90EAFFFF 		ld	%s55,-5488(,%fp)	# restore 
 1093      89003701 
 1094 1078 88EAFFFF 		ld	%s59,-5496(,%fp)	# restore 
 1094      89003B01 
 1095 1080 80EAFFFF 		ld	%s60,-5504(,%fp)	# restore 
 1095      89003C01 
 1096 1088 78EAFFFF 		ld	%s62,-5512(,%fp)	# restore 
 1096      89003E01 
 1097 1090 48EAFFFF 		ld	%s63,-5560(,%fp)	# restore 
 1097      89003F01 
 1098 1098 88290000 		br.l	.L2.8
 1098      00000F18 
 1099              	.L2.9:
 1100 10a0 B8F5FFFF 		st	%s61,-2632(,%fp)	# spill 
 1100      89003D11 
 1101 10a8 A8EAFFFF 		st	%s54,-5464(,%fp)	# spill 
 1101      89003611 
 1102 10b0 90F5FFFF 		st	%s46,-2672(,%fp)	# spill 
 1102      89002E11 
 1103 10b8 88F5FFFF 		st	%s56,-2680(,%fp)	# spill 
 1103      89003811 
 1104 10c0 80F5FFFF 		st	%s49,-2688(,%fp)	# spill 
 1104      89003111 
 1105 10c8 78F4FFFF 		st	%s51,-2952(,%fp)	# spill 
 1105      89003311 
 1106 10d0 A0EAFFFF 		st	%s50,-5472(,%fp)	# spill 
 1106      89003211 
 1107 10d8 98EAFFFF 		st	%s52,-5480(,%fp)	# spill 
 1107      89003411 
 1108 10e0 70F4FFFF 		st	%s22,-2960(,%fp)	# spill 
 1108      89001611 
 1109 10e8 90EAFFFF 		st	%s55,-5488(,%fp)	# spill 
 1109      89003711 
 1110 10f0 88EAFFFF 		st	%s59,-5496(,%fp)	# spill 
 1110      89003B11 
 1111 10f8 80EAFFFF 		st	%s60,-5504(,%fp)	# spill 
 1111      89003C11 
 1112 1100 78EAFFFF 		st	%s62,-5512(,%fp)	# spill 
 1112      89003E11 
 1113 1108 00000000 		or	%s18,0,(0)1
 1113      00001245 
 1114 1110 00000000 		or	%s32,0,%s40
 1114      A8002045 
 1115 1118 00000000 		or	%s30,0,%s57
 1115      B9001E45 
 1116 1120 00000000 		or	%s29,0,%s58
 1116      BA001D45 
 1117 1128 00000000 		or	%s22,0,%s63
 1117      BF001645 
 1118 1130 38280000 		br.l	.L2.10
 1118      00000F18 
 1119              	.L2.11:
 1120              	# line 549
 549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       khkw_zeros[khkw] = 0.f;
 1121              		.loc	1 549 0
 1122 1138 80000000 		mins.w.sx	%s62,%s55,%s62
 1122      BEB73E78 
 1123 1140 E0250000 		br.l	.L2.12
 1123      00000F18 
 1124              	.L2.13:
 1125              	# line 588
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** //RETAIN(tmp)
 1126              		.loc	1 588 0
 1127 1148 80000000 		mins.l	%s62,%s59,%s62
 1127      BEBB3E68 
 1128 1150 40220000 		br.l	.L2.14
 1128      00000F18 
 1129              	.L2.15:
 1130              	# line 608
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = pbia[bia_off0 + oc];
 1131              		.loc	1 608 0
 1132 1158 80000000 		mins.l	%s58,%s54,%s58
 1132      BAB63A68 
 1133 1160 40000000 		br.l	.L2.16
 1133      00000F18 
 1134              	.L2.17:
 1135 1168 00000000 		or	%s4,0,%s63
 1135      BF000445 
 1136 1170 00000000 		or	%s55,0,%s53
 1136      B5003745 
 1137 1178 00000000 		or	%s63,0,%s51
 1137      B3003F45 
 1138 1180 00000000 		or	%s58,0,%s52
 1138      B4003A45 
 1139 1188 00000000 		or	%s57,0,%s50
 1139      B2003945 
 1140 1190 00000000 		or	%s61,0,%s44
 1140      AC003D45 
 1141 1198 C0190000 		br.l	.L2.18
 1141      00000F18 
 1142              	.L2.16:
 1143              	# line 609
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 1144              		.loc	1 609 0
 1145 11a0 00000000 		adds.l	%s61,%s63,(0)1
 1145      00BF3D59 
 1146 11a8 00000000 		adds.l	%s61,%s61,%s59
 1146      BBBD3D59 
 1147 11b0 00000000 		lvl	%s58
 1147      00BA00BF 
 1148 11b8 00000026 		vldu.nc	%v38,4,%s61
 1148      BD040082 
 1149 11c0 00000000 		adds.l	%s61,%s57,(0)1
 1149      00B93D59 
 1150 11c8 00000000 		adds.l	%s61,%s61,%s59
 1150      BBBD3D59 
 1151 11d0 00000026 		vstu.nc	%v38,4,%s61
 1151      BD040092 
 1152              	# line 608
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = pbia[bia_off0 + oc];
 1153              		.loc	1 608 0
 1154 11d8 00000000 		adds.l	%s59,%s59,%s55
 1154      B7BB3B59 
 1155 11e0 00000000 		subs.l	%s54,%s54,%s58
 1155      BAB6365B 
 1156 11e8 80FFFFFF 		brge.l	0,%s54,.L2.17
 1156      B6000518 
 1157 11f0 68FFFFFF 		br.l	.L2.15
 1157      00000F18 
 1158              	.L2.19:
 1159 11f8 00000000 		subs.l	%s38,0,%s39
 1159      A700265B 
 1160 1200 00000000 		smvl	%s37
 1160      0000252E 
 1161 1208 80000000 		mins.l	%s58,%s38,%s37
 1161      A5A63A68 
 1162 1210 00000000 		or	%s54,0,%s38
 1162      A6003645 
 1163 1218 00000000 		or	%s38,0,(0)1
 1163      00002645 
 1164 1220 00000000 		muls.l	%s37,4,%s58
 1164      BA04256E 
 1165 1228 00000000 		or	%s63,0,%s4
 1165      84003F45 
 1166 1230 00000000 		or	%s44,0,%s61
 1166      BD002C45 
 1167 1238 00000000 		or	%s50,0,%s57
 1167      B9003245 
 1168 1240 00000000 		or	%s57,0,%s59
 1168      BB003945 
 1169 1248 00000000 		or	%s52,0,%s2
 1169      82003445 
 1170 1250 00000000 		or	%s53,0,%s55
 1170      B7003545 
 1171 1258 00000000 		or	%s59,0,%s38
 1171      A6003B45 
 1172 1260 00000000 		or	%s55,0,%s37
 1172      A5003745 
 1173 1268 38FFFFFF 		br.l	.L2.16
 1173      00000F18 
 1174              	.L2.20:
 1175 1270 90FFFFFF 		ld	%s59,-112(,%fp)	# tmp
 1175      89003B01 
 1176 1278 00000000 		or	%s62,0,%s53
 1176      B5003E45 
 1177 1280 78FFFFFF 		brlt.l	0,%s40,.L2.19
 1177      A8000218 
 1178 1288 00000000 		or	%s58,0,%s2
 1178      82003A45 
 1179 1290 00000000 		or	%s63,0,%s51
 1179      B3003F45 
 1180 1298 C0180000 		br.l	.L2.18
 1180      00000F18 
 1181              	.L2.21:
 1182              	# line 604
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = 0.f;
 1183              		.loc	1 604 0
 1184 12a0 80000000 		mins.l	%s59,%s54,%s59
 1184      BBB63B68 
 1185 12a8 E8180000 		br.l	.L2.22
 1185      00000F18 
 1186              	.L2.23:
 1187              	# line 624
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (khw_ok)
 1188              		.loc	1 624 0
 1189 12b0 00000000 		or	%s59,0,(0)1
 1189      00003B45 
 1190 12b8 00000000 		or	%s1,0,%s53
 1190      B5000145 
 1191 12c0 00000000 		or	%s2,0,%s58
 1191      BA000245 
 1192 12c8 00000000 		or	%s3,0,%s51
 1192      B3000345 
 1193 12d0 00000000 		or	%s51,0,%s63
 1193      BF003345 
 1194 12d8 00000000 		or	%s53,0,%s62
 1194      BE003545 
 1195 12e0 50170000 		br.l	.L2.24
 1195      00000F18 
 1196              	.L2.25:
 1197              	# line 641
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const int kh = khkw / p->kw;
 1198              		.loc	1 641 0
 1199 12e8 80000000 		mins.w.sx	%s57,%s47,%s57
 1199      B9AF3978 
 1200 12f0 C8140000 		br.l	.L2.26
 1200      00000F18 
 1201              	.L2.27:
 1202              	# line 688
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   // using integer calc no longer results in vgather !
 1203              		.loc	1 688 0
 1204 12f8 80000000 		mins.w.sx	%s62,%s52,%s62
 1204      BEB43E78 
 1205 1300 00000000 		smvl	%s13
 1205      00000D2E 
 1206 1308 00000000 		lvl	%s13
 1206      008D00BF 
 1207 1310 70100000 		br.l	.L2.28
 1207      00000F18 
 1208              	.L2.29:
 1209              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 1210              		.loc	1 727 0
 1211 1318 80000000 		mins.l	%s58,%s54,%s58
 1211      BAB63A68 
 1212 1320 B00C0000 		br.l	.L2.30
 1212      00000F18 
 1213              	.L2.31:
 1214 1328 80000000 		mins.l	%s58,%s51,%s58
 1214      BAB33A68 
 1215 1330 58080000 		br.l	.L2.32
 1215      00000F18 
 1216              	.L2.33:
 1217              	# line 748
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 1218              		.loc	1 748 0
 1219 1338 00000000 		cmpu.l	%s63,%s54,%s58
 1219      BAB63F55 
 1220 1340 06000000 		cmov.l.le	%s58,%s54,%s63
 1220      B6BF3A3B 
 1221 1348 10050000 		br.l	.L2.34
 1221      00000F18 
 1222              	.L2.35:
 1223              	# line 752
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1224              		.loc	1 752 0
 1225 1350 00000000 		cmpu.l	%s63,%s52,%s58
 1225      BAB43F55 
 1226 1358 06000000 		cmov.l.le	%s58,%s52,%s63
 1226      B4BF3A3B 
 1227 1360 B0030000 		br.l	.L2.36
 1227      00000F18 
 1228              	.L2.37:
 1229 1368 00000000 		lea	%s63,__eh_curr_region@LO
 1229      00003F06 
 1230 1370 00000000 		and	%s63,%s63,(32)0
 1230      60BF3F44 
 1231 1378 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 1231      BF00BF06 
 1232 1380 00FEFFFF 		ld2b.zx	%s62,-512(,%fp)
 1232      8900BE04 
 1233 1388 00000000 		st2b	%s62,0(,%s63)
 1233      BF003E14 
 1234 1390 D8FDFFFF 		ld	%s63,-552(,%fp)
 1234      89003F01 
 1235 1398 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 1235      00003E06 
 1236 13a0 00000000 		and	%s62,%s62,(32)0
 1236      60BE3E44 
 1237 13a8 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 1237      BE00BE06 
 1238 13b0 00000000 		st	%s63,0(,%s62)
 1238      BE003F11 
 1239              	# line 762
 762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 1240              		.loc	1 762 0
 1241              	# Start of epilogue codes
 1242 13b8 30000000 		ld	%s18,48(,%fp)
 1242      89001201 
 1243 13c0 38000000 		ld	%s19,56(,%fp)
 1243      89001301 
 1244 13c8 40000000 		ld	%s20,64(,%fp)
 1244      89001401 
 1245 13d0 48000000 		ld	%s21,72(,%fp)
 1245      89001501 
 1246 13d8 50000000 		ld	%s22,80(,%fp)
 1246      89001601 
 1247 13e0 58000000 		ld	%s23,88(,%fp)
 1247      89001701 
 1248 13e8 60000000 		ld	%s24,96(,%fp)
 1248      89001801 
 1249 13f0 68000000 		ld	%s25,104(,%fp)
 1249      89001901 
 1250 13f8 70000000 		ld	%s26,112(,%fp)
 1250      89001A01 
 1251 1400 78000000 		ld	%s27,120(,%fp)
 1251      89001B01 
 1252 1408 80000000 		ld	%s28,128(,%fp)
 1252      89001C01 
 1253 1410 88000000 		ld	%s29,136(,%fp)
 1253      89001D01 
 1254 1418 90000000 		ld	%s30,144(,%fp)
 1254      89001E01 
 1255 1420 98000000 		ld	%s31,152(,%fp)
 1255      89001F01 
 1256 1428 A0000000 		ld	%s32,160(,%fp)
 1256      89002001 
 1257 1430 A8000000 		ld	%s33,168(,%fp)
 1257      89002101 
 1258 1438 00000000 		or	%sp,0,%fp
 1258      89000B45 
 1259              		.cfi_def_cfa	11,8
 1260 1440 18000000 		ld	%got,0x18(,%sp)
 1260      8B000F01 
 1261 1448 20000000 		ld	%plt,0x20(,%sp)
 1261      8B001001 
 1262 1450 08000000 		ld	%lr,0x8(,%sp)
 1262      8B000A01 
 1263 1458 00000000 		ld	%fp,0x0(,%sp)
 1263      8B000901 
 1264 1460 00000000 		b.l	(,%lr)
 1264      8A000F19 
 1265              	.L2.38:
 1266 1468 B81A0000 		br.l	.L2.39
 1266      00000F18 
 1267              	.L2.40:
 1268              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 1269              		.loc	1 598 0
 1270 1470 00000000 		adds.l	%s59,1,%s59
 1270      BB013B59 
 1271 1478 00000000 		adds.l	%s63,%s42,%s63
 1271      BFAA3F59 
 1272 1480 00000000 		adds.l	%s60,%s38,%s60
 1272      BCA63C59 
 1273 1488 00000000 		adds.l	%s34,%s38,%s34
 1273      A2A62259 
 1274 1490 00000000 		adds.l	%s7,%s31,%s7
 1274      879F0759 
 1275 1498 00000000 		adds.l	%s5,%s6,%s5
 1275      85860559 
 1276 14a0 C8FFFFFF 		brgt.l	0,%s59,.L2.38
 1276      BB000118 
 1277 14a8 C0FEFFFF 		br.l	.L2.37
 1277      00000F18 
 1278              	.L2.41:
 1279 14b0 30F3FFFF 		st	%s6,-3280(,%fp)	# spill 
 1279      89000611 
 1280 14b8 68F5FFFF 		st	%s5,-2712(,%fp)	# spill 
 1280      89000511 
 1281 14c0 38F3FFFF 		st	%s7,-3272(,%fp)	# spill 
 1281      89000711 
 1282 14c8 40F3FFFF 		st	%s34,-3264(,%fp)	# spill 
 1282      89002211 
 1283 14d0 38F4FFFF 		st	%s63,-3016(,%fp)	# spill 
 1283      89003F11 
 1284 14d8 A0F3FFFF 		ld	%s59,-3168(,%fp)	# restore 
 1284      89003B01 
 1285 14e0 00000000 		or	%s63,0,%s4
 1285      84003F45 
 1286 14e8 98F3FFFF 		ld	%s42,-3176(,%fp)	# restore 
 1286      89002A01 
 1287 14f0 90F3FFFF 		ld	%s38,-3184(,%fp)	# restore 
 1287      89002601 
 1288 14f8 B8F4FFFF 		ld	%s60,-2888(,%fp)	# restore 
 1288      89003C01 
 1289 1500 80F3FFFF 		ld	%s34,-3200(,%fp)	# restore 
 1289      89002201 
 1290 1508 70F3FFFF 		ld	%s7,-3216(,%fp)	# restore 
 1290      89000701 
 1291 1510 88F3FFFF 		ld	%s6,-3192(,%fp)	# restore 
 1291      89000601 
 1292 1518 78F3FFFF 		ld	%s5,-3208(,%fp)	# restore 
 1292      89000501 
 1293 1520 A8F3FFFF 		ld	%s21,-3160(,%fp)	# restore 
 1293      89001501 
 1294 1528 68F3FFFF 		ld	%s55,-3224(,%fp)	# restore 
 1294      89003701 
 1295 1530 60F3FFFF 		ld	%s19,-3232(,%fp)	# restore 
 1295      89001301 
 1296 1538 58F3FFFF 		ld	%s4,-3240(,%fp)	# restore 
 1296      89000401 
 1297 1540 30FFFFFF 		br.l	.L2.40
 1297      00000F18 
 1298              	.L2.42:
 1299              	# line 599
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oh = 0; oh < OH; ++oh) {
 1300              		.loc	1 599 0
 1301 1548 00000000 		adds.l	%s59,1,%s59
 1301      BB013B59 
 1302 1550 00000000 		adds.l	%s42,%s45,%s42
 1302      AAAD2A59 
 1303 1558 00000000 		adds.l	%s38,%s41,%s38
 1303      A6A92659 
 1304 1560 B8180000 		brgt.l	0,%s59,.L2.43
 1304      BB000118 
 1305 1568 48FFFFFF 		br.l	.L2.41
 1305      00000F18 
 1306              	.L2.44:
 1307 1570 08F4FFFF 		ld	%s59,-3064(,%fp)	# restore 
 1307      89003B01 
 1308 1578 00F4FFFF 		ld	%s45,-3072(,%fp)	# restore 
 1308      89002D01 
 1309 1580 E8F3FFFF 		ld	%s42,-3096(,%fp)	# restore 
 1309      89002A01 
 1310 1588 F8F3FFFF 		ld	%s41,-3080(,%fp)	# restore 
 1310      89002901 
 1311 1590 F0F3FFFF 		ld	%s38,-3088(,%fp)	# restore 
 1311      89002601 
 1312 1598 B0F3FFFF 		ld	%s26,-3152(,%fp)	# restore 
 1312      89001A01 
 1313 15a0 10F4FFFF 		ld	%s20,-3056(,%fp)	# restore 
 1313      89001401 
 1314 15a8 E0F3FFFF 		ld	%s44,-3104(,%fp)	# restore 
 1314      89002C01 
 1315 15b0 D8F3FFFF 		ld	%s37,-3112(,%fp)	# restore 
 1315      89002501 
 1316 15b8 D0F3FFFF 		ld	%s3,-3120(,%fp)	# restore 
 1316      89000301 
 1317 15c0 C8F3FFFF 		ld	%s1,-3128(,%fp)	# restore 
 1317      89000101 
 1318 15c8 B8F3FFFF 		ld	%s30,-3144(,%fp)	# restore 
 1318      89001E01 
 1319 15d0 C0F3FFFF 		ld	%s33,-3136(,%fp)	# restore 
 1319      89002101 
 1320 15d8 70FFFFFF 		br.l	.L2.42
 1320      00000F18 
 1321              	.L2.45:
 1322              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 1323              		.loc	1 600 0
 1324 15e0 00000000 		adds.l	%s59,1,%s59
 1324      BB013B59 
 1325 15e8 00000000 		adds.l	%s21,%s51,%s21
 1325      95B31559 
 1326 15f0 00000000 		adds.l	%s60,%s50,%s60
 1326      BCB23C59 
 1327 15f8 00000000 		adds.l	%s55,%s50,%s55
 1327      B7B23759 
 1328 1600 00000000 		adds.l	%s45,%s48,%s45
 1328      ADB02D59 
 1329 1608 00000000 		adds.l	%s20,%s51,%s20
 1329      94B31459 
 1330 1610 00000000 		adds.l	%s42,%s43,%s42
 1330      AAAB2A59 
 1331 1618 30170000 		brgt.l	0,%s59,.L2.46
 1331      BB000118 
 1332 1620 50FFFFFF 		br.l	.L2.44
 1332      00000F18 
 1333              	.L2.47:
 1334 1628 68F4FFFF 		ld	%s59,-2968(,%fp)	# restore 
 1334      89003B01 
 1335 1630 78F4FFFF 		ld	%s51,-2952(,%fp)	# restore 
 1335      89003301 
 1336 1638 60F4FFFF 		ld	%s50,-2976(,%fp)	# restore 
 1336      89003201 
 1337 1640 58F4FFFF 		ld	%s48,-2984(,%fp)	# restore 
 1337      89003001 
 1338 1648 40F4FFFF 		ld	%s45,-3008(,%fp)	# restore 
 1338      89002D01 
 1339 1650 50F4FFFF 		ld	%s43,-2992(,%fp)	# restore 
 1339      89002B01 
 1340 1658 48F4FFFF 		ld	%s42,-3000(,%fp)	# restore 
 1340      89002A01 
 1341 1660 70F4FFFF 		ld	%s22,-2960(,%fp)	# restore 
 1341      89001601 
 1342 1668 38F4FFFF 		ld	%s63,-3016(,%fp)	# restore 
 1342      89003F01 
 1343 1670 30F4FFFF 		ld	%s62,-3024(,%fp)	# restore 
 1343      89003E01 
 1344 1678 28F4FFFF 		ld	%s58,-3032(,%fp)	# restore 
 1344      89003A01 
 1345 1680 20F4FFFF 		ld	%s54,-3040(,%fp)	# restore 
 1345      89003601 
 1346 1688 18F4FFFF 		ld	%s52,-3048(,%fp)	# restore 
 1346      89003401 
 1347 1690 50FFFFFF 		br.l	.L2.45
 1347      00000F18 
 1348              	.L2.48:
 1349              	# line 601
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ---- 1 omp thread ----
 1350              		.loc	1 601 0
 1351 1698 00000000 		adds.l	%s51,1,%s51
 1351      B3013359 
 1352 16a0 00000000 		adds.l	%s48,%s49,%s48
 1352      B0B13059 
 1353 16a8 00000000 		adds.l	%s45,%s47,%s45
 1353      ADAF2D59 
 1354 16b0 00000000 		adds.l	%s43,%s47,%s43
 1354      ABAF2B59 
 1355 16b8 00000000 		adds.l	%s42,%s49,%s42
 1355      AAB12A59 
 1356 16c0 00000000 		adds.l	%s22,%s49,%s22
 1356      96B11659 
 1357 16c8 00000000 		adds.l	%s41,4,%s41
 1357      A9042959 
 1358 16d0 A0150000 		brgt.l	0,%s51,.L2.49
 1358      B3000118 
 1359 16d8 50FFFFFF 		br.l	.L2.47
 1359      00000F18 
 1360              	.L2.50:
 1361 16e0 00000000 		or	%s5,0,%s55
 1361      B7000545 
 1362 16e8 00000000 		or	%s55,0,%s62
 1362      BE003745 
 1363 16f0 00000000 		or	%s57,0,%s50
 1363      B2003945 
 1364 16f8 00000000 		or	%s61,0,%s44
 1364      AC003D45 
 1365 1700 00000000 		or	%s53,0,%s38
 1365      A6003545 
 1366 1708 90FFFFFF 		br.l	.L2.48
 1366      00000F18 
 1367              	.L2.36:
 1368 1710 00000000 		or	%s59,0,%s61
 1368      BD003B45 
 1369              	# line 753
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
 1370              		.loc	1 753 0
 1371 1718 00000000 		lvl	%s58
 1371      00BA00BF 
 1372 1720 00000025 		vldu.nc	%v37,4,%s59
 1372      BB040082 
 1373 1728 00000000 		adds.l	%s59,%s57,%s55
 1373      B7B93B59 
 1374 1730 00000000 		or	%s59,0,%s59
 1374      BB003B45 
 1375 1738 00000025 		vstu.nc	%v37,%s55,%s59
 1375      BBB70092 
 1376              	# line 752
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1377              		.loc	1 752 0
 1378 1740 00000000 		adds.l	%s57,%s57,%s54
 1378      B6B93959 
 1379 1748 00000000 		adds.l	%s61,%s61,%s53
 1379      B5BD3D59 
 1380 1750 00000000 		subu.l	%s52,%s52,%s58
 1380      BAB43458 
 1381 1758 00000000 		cmpu.l	%s19,%s52,(0)1
 1381      00B41355 
 1382 1760 80FFFFFF 		brle.l	%s19,0,.L2.50
 1382      00930618 
 1383 1768 E8FBFFFF 		br.l	.L2.35
 1383      00000F18 
 1384              	.L2.51:
 1385 1770 00000000 		subs.w.sx	%s63,0,(63)0
 1385      7F003F5A 
 1386 1778 00000000 		or	%s38,0,%s53
 1386      B5002645 
 1387 1780 00000000 		or	%s63,0,%s63
 1387      BF003F45 
 1388              	# line 753
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
 1389              		.loc	1 753 0
 1390 1788 00000000 		muls.l	%s63,%s63,%s5
 1390      85BF3F6E 
 1391 1790 00000000 		or	%s44,0,%s61
 1391      BD002C45 
 1392 1798 00000000 		or	%s50,0,%s57
 1392      B9003245 
 1393 17a0 00000000 		adds.l	%s57,%s41,%s63
 1393      BFA93959 
 1394              	# line 752
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1395              		.loc	1 752 0
 1396 17a8 00000000 		smvl	%s63
 1396      00003F2E 
 1397              	# line 753
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
 1398              		.loc	1 753 0
 1399 17b0 00000000 		cmpu.l	%s37,%s53,%s63
 1399      BFB52555 
 1400 17b8 00000000 		or	%s58,0,%s63
 1400      BF003A45 
 1401 17c0 06000000 		cmov.l.le	%s58,%s53,%s37
 1401      B5A53A3B 
 1402 17c8 00000000 		or	%s52,0,%s53
 1402      B5003445 
 1403 17d0 00000000 		or	%s63,0,%s58
 1403      BA003F45 
 1404 17d8 00000000 		muls.l	%s54,%s5,%s63
 1404      BF85366E 
 1405 17e0 00000000 		or	%s61,0,%s59
 1405      BB003D45 
 1406 17e8 00000000 		muls.l	%s53,4,%s63
 1406      BF04356E 
 1407 17f0 00000000 		or	%s62,0,%s55
 1407      B7003E45 
 1408 17f8 00000000 		or	%s55,0,%s5
 1408      85003745 
 1409 1800 10FFFFFF 		br.l	.L2.36
 1409      00000F18 
 1410              	.L2.52:
 1411              	# line 752
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1412              		.loc	1 752 0
 1413 1808 90FFFFFF 		ld	%s59,-112(,%fp)	# tmp
 1413      89003B01 
 1414 1810 00000000 		cmpu.l	%s26,0,%s53
 1414      B5001A55 
 1415 1818 58FFFFFF 		brlt.l	%s26,0,.L2.51
 1415      009A0218 
 1416 1820 78FEFFFF 		br.l	.L2.48
 1416      00000F18 
 1417              	.L2.53:
 1418 1828 00000000 		cmpu.l	%s26,%s53,(0)1
 1418      00B51A55 
 1419 1830 D8FFFFFF 		brgt.l	%s26,0,.L2.52
 1419      009A0118 
 1420 1838 60FEFFFF 		br.l	.L2.48
 1420      00000F18 
 1421              	.L2.54:
 1422 1840 00000000 		or	%s57,0,%s62
 1422      BE003945 
 1423 1848 00000000 		or	%s61,0,%s52
 1423      B4003D45 
 1424 1850 D8FFFFFF 		br.l	.L2.53
 1424      00000F18 
 1425              	.L2.34:
 1426 1858 00000000 		or	%s59,0,%s61
 1426      BD003B45 
 1427              	# line 749
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 1428              		.loc	1 749 0
 1429 1860 00000000 		lvl	%s58
 1429      00BA00BF 
 1430 1868 00000023 		vldu.nc	%v35,4,%s59
 1430      BB040082 
 1431 1870 00000000 		or	%s59,0,(0)1
 1431      00003B45 
 1432 1878 00230022 		vfmax.s	%v34,%s59,%v35
 1432      00BBA0BD 
 1433 1880 00000000 		or	%s59,0,%s61
 1433      BD003B45 
 1434 1888 00000022 		vstu.nc	%v34,4,%s59
 1434      BB040092 
 1435              	# line 748
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 1436              		.loc	1 748 0
 1437 1890 00000000 		adds.l	%s61,%s61,%s57
 1437      B9BD3D59 
 1438 1898 00000000 		subu.l	%s54,%s54,%s58
 1438      BAB63658 
 1439 18a0 00000000 		cmpu.l	%s19,%s54,(0)1
 1439      00B61355 
 1440 18a8 98FFFFFF 		brle.l	%s19,0,.L2.54
 1440      00930618 
 1441 18b0 88FAFFFF 		br.l	.L2.33
 1441      00000F18 
 1442              	.L2.55:
 1443 18b8 00000000 		smvl	%s63
 1443      00003F2E 
 1444 18c0 00000000 		cmpu.l	%s50,%s53,%s63
 1444      BFB53255 
 1445 18c8 00000000 		or	%s58,0,%s63
 1445      BF003A45 
 1446 18d0 06000000 		cmov.l.le	%s58,%s53,%s50
 1446      B5B23A3B 
 1447 18d8 00000000 		or	%s54,0,%s53
 1447      B5003645 
 1448 18e0 00000000 		or	%s52,0,%s61
 1448      BD003445 
 1449 18e8 00000000 		or	%s61,0,%s59
 1449      BB003D45 
 1450 18f0 00000000 		or	%s63,0,%s58
 1450      BA003F45 
 1451 18f8 00000000 		muls.l	%s63,4,%s63
 1451      BF043F6E 
 1452 1900 00000000 		or	%s62,0,%s57
 1452      B9003E45 
 1453 1908 00000000 		or	%s57,0,%s63
 1453      BF003945 
 1454 1910 48FFFFFF 		br.l	.L2.34
 1454      00000F18 
 1455              	.L2.56:
 1456 1918 90FFFFFF 		ld	%s59,-112(,%fp)	# tmp
 1456      89003B01 
 1457 1920 00000000 		cmpu.l	%s26,0,%s53
 1457      B5001A55 
 1458 1928 90FFFFFF 		brlt.l	%s26,0,.L2.55
 1458      009A0218 
 1459 1930 F8FEFFFF 		br.l	.L2.53
 1459      00000F18 
 1460              	.L2.57:
 1461 1938 00000000 		cmpu.l	%s26,%s53,(0)1
 1461      00B51A55 
 1462 1940 D8FFFFFF 		brgt.l	%s26,0,.L2.56
 1462      009A0118 
 1463 1948 E0FEFFFF 		br.l	.L2.53
 1463      00000F18 
 1464              	.L2.58:
 1465              	# line 747
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
 1466              		.loc	1 747 0
 1467 1950 5C000000 		ldl.zx	%s59,92(,%s61)	# *(p).merge
 1467      BD00BB03 
 1468 1958 00000000 		adds.w.sx	%s59,0,%s59
 1468      BB003B4A 
 1469 1960 D8FFFFFF 		breq.w	1,%s59,.L2.57
 1469      BB018418 
 1470 1968 C0FEFFFF 		br.l	.L2.53
 1470      00000F18 
 1471              	.L2.59:
 1472 1970 A0F4FFFF 		st	%s19,-2912(,%fp)	# spill 
 1472      89001311 
 1473 1978 80F4FFFF 		st	%s52,-2944(,%fp)	# spill 
 1473      89003411 
 1474 1980 A8F4FFFF 		st	%s48,-2904(,%fp)	# spill 
 1474      89003011 
 1475 1988 00000000 		or	%s61,0,%s26
 1475      9A003D45 
 1476 1990 00000000 		or	%s53,0,%s3
 1476      83003545 
 1477 1998 00000000 		or	%s56,0,%s30
 1477      9E003845 
 1478 19a0 00000000 		or	%s49,0,%s33
 1478      A1003145 
 1479 19a8 00000000 		or	%s57,0,%s37
 1479      A5003945 
 1480 19b0 00000000 		or	%s48,0,%s38
 1480      A6003045 
 1481 19b8 00000000 		or	%s51,0,%s39
 1481      A7003345 
 1482 19c0 60F5FFFF 		ld	%s39,-2720(,%fp)	# restore 
 1482      89002701 
 1483 19c8 00000000 		or	%s47,0,%s44
 1483      AC002F45 
 1484 19d0 18F5FFFF 		ld	%s55,-2792(,%fp)	# restore 
 1484      89003701 
 1485 19d8 10F5FFFF 		ld	%s60,-2800(,%fp)	# restore 
 1485      89003C01 
 1486 19e0 70FFFFFF 		br.l	.L2.58
 1486      00000F18 
 1487              	.L2.60:
 1488 19e8 A0030000 		br.l	.L2.61
 1488      00000F18 
 1489              	.L2.62:
 1490              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 1491              		.loc	1 724 0
 1492 19f0 00000000 		adds.l	%s59,4,%s59
 1492      BB043B59 
 1493 19f8 00000000 		adds.l	%s58,16,%s58
 1493      BA103A59 
 1494 1a00 00000000 		adds.l	%s55,%s55,%s52
 1494      B4B73759 
 1495 1a08 00000000 		adds.l	%s57,%s57,%s52
 1495      B4B93959 
 1496 1a10 00000000 		adds.l	%s54,%s54,%s52
 1496      B4B63659 
 1497 1a18 00000000 		adds.l	%s53,%s53,%s52
 1497      B4B53559 
 1498 1a20 C8FFFFFF 		brgt.l	0,%s59,.L2.60
 1498      BB000118 
 1499 1a28 48FFFFFF 		br.l	.L2.59
 1499      00000F18 
 1500              	.L2.63:
 1501              	# line 730
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 1502              		.loc	1 730 0
 1503 1a30 00000000 		or	%s63,1,(0)1
 1503      00013F45 
 1504 1a38 00000000 		adds.l	%s62,%s58,(0)1
 1504      00BA3E59 
 1505 1a40 00000000 		adds.l	%s61,12,%s62
 1505      BE0C3D59 
 1506 1a48 00000000 		lvl	%s63
 1506      00BF00BF 
 1507 1a50 0000000F 		vstu.nc	%v15,0,%s61
 1507      BD000092 
 1508 1a58 00000000 		or	%s60,1,(0)1
 1508      00013C45 
 1509 1a60 00000000 		adds.l	%s63,8,%s62
 1509      BE083F59 
 1510 1a68 00000000 		lvl	%s60
 1510      00BC00BF 
 1511 1a70 00000010 		vstu.nc	%v16,0,%s63
 1511      BF000092 
 1512 1a78 00000000 		or	%s61,1,(0)1
 1512      00013D45 
 1513 1a80 00000000 		adds.l	%s62,4,%s62
 1513      BE043E59 
 1514 1a88 00000000 		lvl	%s61
 1514      00BD00BF 
 1515 1a90 00000011 		vstu.nc	%v17,0,%s62
 1515      BE000092 
 1516 1a98 00000000 		or	%s63,1,(0)1
 1516      00013F45 
 1517 1aa0 00000000 		or	%s62,0,%s58
 1517      BA003E45 
 1518 1aa8 00000000 		lvl	%s63
 1518      00BF00BF 
 1519 1ab0 00000012 		vstu.nc	%v18,0,%s62
 1519      BE000092 
 1520 1ab8 38FFFFFF 		br.l	.L2.62
 1520      00000F18 
 1521              	.L2.64:
 1522 1ac0 00000000 		or	%s1,0,%s63
 1522      BF000145 
 1523              	# line 728
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //tmp[oc] += src[ickhkw] * pwei_oc[ickhkw];
 1524              		.loc	1 728 0
 1525 1ac8 00000000 		lvl	%s62
 1525      00BE00BF 
 1526 1ad0 00002F0D 		vfsum.s	%v13,%v47
 1526      000080EC 
 1527 1ad8 00000000 		or	%s63,1,(0)1
 1527      00013F45 
 1528 1ae0 00000000 		lvl	%s63
 1528      00BF00BF 
 1529 1ae8 000D1212 		vfadd.s	%v18,%v18,%v13
 1529      000080CC 
 1530 1af0 00000000 		lvl	%s62
 1530      00BE00BF 
 1531 1af8 00002E0C 		vfsum.s	%v12,%v46
 1531      000080EC 
 1532 1b00 00000000 		or	%s63,1,(0)1
 1532      00013F45 
 1533 1b08 00000000 		lvl	%s63
 1533      00BF00BF 
 1534 1b10 000C1111 		vfadd.s	%v17,%v17,%v12
 1534      000080CC 
 1535 1b18 00000000 		lvl	%s62
 1535      00BE00BF 
 1536 1b20 00002D0B 		vfsum.s	%v11,%v45
 1536      000080EC 
 1537 1b28 00000000 		or	%s63,1,(0)1
 1537      00013F45 
 1538 1b30 00000000 		lvl	%s63
 1538      00BF00BF 
 1539 1b38 000B1010 		vfadd.s	%v16,%v16,%v11
 1539      000080CC 
 1540 1b40 00000000 		lvl	%s62
 1540      00BE00BF 
 1541 1b48 00002C0A 		vfsum.s	%v10,%v44
 1541      000080EC 
 1542 1b50 00000000 		or	%s63,1,(0)1
 1542      00013F45 
 1543 1b58 00000000 		lvl	%s63
 1543      00BF00BF 
 1544 1b60 000A0F0F 		vfadd.s	%v15,%v15,%v10
 1544      000080CC 
 1545 1b68 00000000 		or	%s59,0,%s60
 1545      BC003B45 
 1546 1b70 00000000 		or	%s52,0,%s56
 1546      B8003445 
 1547 1b78 00000000 		or	%s58,0,%s50
 1547      B2003A45 
 1548 1b80 B0FEFFFF 		br.l	.L2.63
 1548      00000F18 
 1549              	.L2.32:
 1550              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 1551              		.loc	1 727 0
 1552 1b88 00000000 		adds.l	%s61,%s63,(0)1
 1552      00BF3D59 
 1553 1b90 00000000 		adds.l	%s61,%s61,%s59
 1553      BBBD3D59 
 1554 1b98 00000000 		lvl	%s58
 1554      00BA00BF 
 1555 1ba0 0000002B 		vldu.nc	%v43,4,%s61
 1555      BD040082 
 1556              	# line 728
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //tmp[oc] += src[ickhkw] * pwei_oc[ickhkw];
 1557              		.loc	1 728 0
 1558 1ba8 00000000 		adds.l	%s61,%s57,(0)1
 1558      00B93D59 
 1559 1bb0 00000000 		adds.l	%s61,%s61,%s59
 1559      BBBD3D59 
 1560 1bb8 0000002A 		vldu.nc	%v42,4,%s61
 1560      BD040082 
 1561 1bc0 00000000 		adds.l	%s61,%s55,(0)1
 1561      00B73D59 
 1562 1bc8 00000000 		adds.l	%s61,%s61,%s59
 1562      BBBD3D59 
 1563 1bd0 00000029 		vldu.nc	%v41,4,%s61
 1563      BD040082 
 1564 1bd8 2B2A2F2F 		vfmad.s	%v47,%v47,%v42,%v43
 1564      000080E2 
 1565 1be0 2B292E2E 		vfmad.s	%v46,%v46,%v41,%v43
 1565      000080E2 
 1566 1be8 00000000 		adds.l	%s61,%s54,(0)1
 1566      00B63D59 
 1567 1bf0 00000000 		adds.l	%s61,%s61,%s59
 1567      BBBD3D59 
 1568 1bf8 00000028 		vldu.nc	%v40,4,%s61
 1568      BD040082 
 1569 1c00 2B282D2D 		vfmad.s	%v45,%v45,%v40,%v43
 1569      000080E2 
 1570 1c08 00000000 		adds.l	%s61,%s53,(0)1
 1570      00B53D59 
 1571 1c10 00000000 		adds.l	%s61,%s61,%s59
 1571      BBBD3D59 
 1572 1c18 00000027 		vldu.nc	%v39,4,%s61
 1572      BD040082 
 1573 1c20 2B272C2C 		vfmad.s	%v44,%v44,%v39,%v43
 1573      000080E2 
 1574              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 1575              		.loc	1 727 0
 1576 1c28 00000000 		adds.l	%s59,%s59,%s52
 1576      B4BB3B59 
 1577 1c30 00000000 		subs.l	%s51,%s51,%s58
 1577      BAB3335B 
 1578 1c38 88FEFFFF 		brge.l	0,%s51,.L2.64
 1578      B3000518 
 1579 1c40 E8F6FFFF 		br.l	.L2.31
 1579      00000F18 
 1580              	.L2.65:
 1581 1c48 00000000 		subs.l	%s61,0,%s48
 1581      B0003D5B 
 1582 1c50 00000000 		smvl	%s62
 1582      00003E2E 
 1583 1c58 80000000 		mins.l	%s49,%s61,%s62
 1583      BEBD3168 
 1584              	# line 728
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //tmp[oc] += src[ickhkw] * pwei_oc[ickhkw];
 1585              		.loc	1 728 0
 1586 1c60 00000000 		or	%s47,0,(0)1
 1586      00002F45 
 1587 1c68 00000000 		or	%s63,0,%s1
 1587      81003F45 
 1588 1c70 00000000 		or	%s50,0,%s58
 1588      BA003245 
 1589 1c78 00000000 		or	%s60,0,%s59
 1589      BB003C45 
 1590 1c80 00000000 		or	%s56,0,%s52
 1590      B4003845 
 1591 1c88 00000000 		or	%s58,0,%s49
 1591      B1003A45 
 1592 1c90 00000000 		lvl	%s62
 1592      00BE00BF 
 1593 1c98 0000002F 		vbrdu	%v47,%s47
 1593      00AF808C 
 1594 1ca0 00000000 		or	%s47,0,(0)1
 1594      00002F45 
 1595 1ca8 0000002E 		vbrdu	%v46,%s47
 1595      00AF808C 
 1596 1cb0 00000000 		or	%s47,0,(0)1
 1596      00002F45 
 1597 1cb8 0000002D 		vbrdu	%v45,%s47
 1597      00AF808C 
 1598 1cc0 00000000 		or	%s47,0,(0)1
 1598      00002F45 
 1599 1cc8 0000002C 		vbrdu	%v44,%s47
 1599      00AF808C 
 1600 1cd0 00000000 		or	%s51,0,%s61
 1600      BD003345 
 1601              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 1602              		.loc	1 727 0
 1603 1cd8 00000000 		or	%s59,0,(0)1
 1603      00003B45 
 1604 1ce0 00000000 		muls.l	%s52,4,%s49
 1604      B104346E 
 1605 1ce8 A0FEFFFF 		br.l	.L2.32
 1605      00000F18 
 1606              	.L2.66:
 1607 1cf0 00000000 		or	%s51,1,(0)1
 1607      00013345 
 1608 1cf8 00000000 		or	%s50,0,%s58
 1608      BA003245 
 1609 1d00 00000000 		lvl	%s51
 1609      00B300BF 
 1610 1d08 00000012 		vldu.nc	%v18,0,%s50
 1610      B2000082 
 1611 1d10 00000000 		or	%s51,1,(0)1
 1611      00013345 
 1612 1d18 00000000 		adds.l	%s50,%s58,(0)1
 1612      00BA3259 
 1613 1d20 00000000 		adds.l	%s49,4,%s50
 1613      B2043159 
 1614 1d28 00000000 		lvl	%s51
 1614      00B300BF 
 1615 1d30 00000011 		vldu.nc	%v17,0,%s49
 1615      B1000082 
 1616 1d38 00000000 		or	%s51,1,(0)1
 1616      00013345 
 1617 1d40 00000000 		adds.l	%s49,8,%s50
 1617      B2083159 
 1618 1d48 00000000 		lvl	%s51
 1618      00B300BF 
 1619 1d50 00000010 		vldu.nc	%v16,0,%s49
 1619      B1000082 
 1620 1d58 00000000 		or	%s51,1,(0)1
 1620      00013345 
 1621 1d60 00000000 		adds.l	%s50,12,%s50
 1621      B20C3259 
 1622 1d68 00000000 		lvl	%s51
 1622      00B300BF 
 1623 1d70 0000000F 		vldu.nc	%v15,0,%s50
 1623      B2000082 
 1624 1d78 D0FEFFFF 		brlt.l	0,%s19,.L2.65
 1624      93000218 
 1625 1d80 B0FCFFFF 		br.l	.L2.63
 1625      00000F18 
 1626              	.L2.61:
 1627 1d88 68FFFFFF 		brlt.l	0,%s19,.L2.66
 1627      93000218 
 1628 1d90 60FCFFFF 		br.l	.L2.62
 1628      00000F18 
 1629              	.L2.67:
 1630 1d98 18F5FFFF 		st	%s55,-2792(,%fp)	# spill 
 1630      89003711 
 1631 1da0 10F5FFFF 		st	%s60,-2800(,%fp)	# spill 
 1631      89003C11 
 1632 1da8 60F5FFFF 		st	%s39,-2720(,%fp)	# spill 
 1632      89002711 
 1633 1db0 D8F4FFFF 		ld	%s62,-2856(,%fp)	# restore 
 1633      89003E01 
 1634 1db8 00000000 		or	%s1,0,%s63
 1634      BF000145 
 1635 1dc0 A0F4FFFF 		ld	%s19,-2912(,%fp)	# restore 
 1635      89001301 
 1636              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 1637              		.loc	1 724 0
 1638 1dc8 00000000 		adds.l	%s63,%s62,%s39
 1638      A7BE3F59 
 1639 1dd0 00000000 		muls.l	%s60,4,%s62
 1639      BE043C6E 
 1640 1dd8 00000000 		or	%s3,0,%s53
 1640      B5000345 
 1641 1de0 00000000 		or	%s26,0,%s61
 1641      BD001A45 
 1642 1de8 00000000 		adds.l	%s58,%s60,%s59
 1642      BBBC3A59 
 1643 1df0 B0F4FFFF 		ld	%s61,-2896(,%fp)	# restore 
 1643      89003D01 
 1644 1df8 00000000 		or	%s59,0,%s63
 1644      BF003B45 
 1645 1e00 00000000 		or	%s30,0,%s56
 1645      B8001E45 
 1646 1e08 00000000 		muls.l	%s63,%s62,%s61
 1646      BDBE3F6E 
 1647 1e10 98F4FFFF 		ld	%s60,-2920(,%fp)	# restore 
 1647      89003C01 
 1648 1e18 00000000 		or	%s33,0,%s49
 1648      B1002145 
 1649 1e20 00000000 		or	%s37,0,%s57
 1649      B9002545 
 1650 1e28 00000000 		adds.l	%s55,%s63,%s60
 1650      BCBF3759 
 1651 1e30 00000000 		muls.l	%s63,%s62,%s61
 1651      BDBE3F6E 
 1652 1e38 B8F4FFFF 		ld	%s60,-2888(,%fp)	# restore 
 1652      89003C01 
 1653 1e40 00000000 		or	%s38,0,%s48
 1653      B0002645 
 1654 1e48 A8F4FFFF 		ld	%s48,-2904(,%fp)	# restore 
 1654      89003001 
 1655 1e50 00000000 		adds.l	%s57,%s63,%s60
 1655      BCBF3959 
 1656 1e58 00000000 		muls.l	%s63,%s62,%s61
 1656      BDBE3F6E 
 1657 1e60 90F4FFFF 		ld	%s60,-2928(,%fp)	# restore 
 1657      89003C01 
 1658 1e68 00000000 		or	%s39,0,%s51
 1658      B3002745 
 1659 1e70 00000000 		or	%s44,0,%s47
 1659      AF002C45 
 1660 1e78 00000000 		adds.l	%s54,%s63,%s60
 1660      BCBF3659 
 1661 1e80 00000000 		muls.l	%s61,%s62,%s61
 1661      BDBE3D6E 
 1662 1e88 88F4FFFF 		ld	%s63,-2936(,%fp)	# restore 
 1662      89003F01 
 1663 1e90 00000000 		adds.l	%s53,%s61,%s63
 1663      BFBD3559 
 1664 1e98 80F4FFFF 		ld	%s52,-2944(,%fp)	# restore 
 1664      89003401 
 1665 1ea0 E8FEFFFF 		br.l	.L2.61
 1665      00000F18 
 1666              	.L2.68:
 1667 1ea8 D8F4FFFF 		ld	%s26,-2856(,%fp)	# restore 
 1667      89001A01 
 1668 1eb0 E8FEFFFF 		brlt.l	%s26,%s40,.L2.67
 1668      A89A0218 
 1669 1eb8 98FAFFFF 		br.l	.L2.58
 1669      00000F18 
 1670              	.L2.69:
 1671 1ec0 A0F4FFFF 		st	%s19,-2912(,%fp)	# spill 
 1671      89001311 
 1672 1ec8 A8F4FFFF 		st	%s60,-2904(,%fp)	# spill 
 1672      89003C11 
 1673 1ed0 B0F4FFFF 		st	%s54,-2896(,%fp)	# spill 
 1673      89003611 
 1674 1ed8 00000000 		or	%s53,0,%s26
 1674      9A003545 
 1675 1ee0 00000000 		or	%s61,0,%s30
 1675      9E003D45 
 1676 1ee8 00000000 		or	%s63,0,%s52
 1676      B4003F45 
 1677 1ef0 C8F4FFFF 		ld	%s59,-2872(,%fp)	# restore 
 1677      89003B01 
 1678 1ef8 00000000 		or	%s56,0,%s33
 1678      A1003845 
 1679 1f00 00000000 		or	%s57,0,%s37
 1679      A5003945 
 1680 1f08 00000000 		or	%s2,0,%s38
 1680      A6000245 
 1681 1f10 00000000 		or	%s51,0,%s44
 1681      AC003345 
 1682 1f18 00000000 		or	%s55,0,%s50
 1682      B2003745 
 1683 1f20 10F5FFFF 		ld	%s60,-2800(,%fp)	# restore 
 1683      89003C01 
 1684 1f28 80FFFFFF 		br.l	.L2.68
 1684      00000F18 
 1685              	.L2.70:
 1686 1f30 00000000 		adds.l	%s59,1,%s59
 1686      BB013B59 
 1687 1f38 00000000 		adds.l	%s58,4,%s58
 1687      BA043A59 
 1688 1f40 00000000 		adds.l	%s57,%s54,%s57
 1688      B9B63959 
 1689 1f48 90010000 		brgt.l	0,%s59,.L2.71
 1689      BB000118 
 1690 1f50 70FFFFFF 		br.l	.L2.69
 1690      00000F18 
 1691              	.L2.72:
 1692              	# line 730
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
 1693              		.loc	1 730 0
 1694 1f58 00000000 		or	%s63,1,(0)1
 1694      00013F45 
 1695 1f60 00000000 		or	%s62,0,%s58
 1695      BA003E45 
 1696 1f68 00000000 		lvl	%s63
 1696      00BF00BF 
 1697 1f70 00000013 		vstu.nc	%v19,0,%s62
 1697      BE000092 
 1698 1f78 B8FFFFFF 		br.l	.L2.70
 1698      00000F18 
 1699              	.L2.73:
 1700 1f80 00000000 		or	%s58,0,%s1
 1700      81003A45 
 1701 1f88 00000000 		or	%s52,0,%s63
 1701      BF003445 
 1702 1f90 00000000 		or	%s54,0,%s3
 1702      83003645 
 1703 1f98 00000000 		or	%s59,0,%s2
 1703      82003B45 
 1704              	# line 728
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //tmp[oc] += src[ickhkw] * pwei_oc[ickhkw];
 1705              		.loc	1 728 0
 1706 1fa0 00000000 		lvl	%s56
 1706      00B800BF 
 1707 1fa8 0000320E 		vfsum.s	%v14,%v50
 1707      000080EC 
 1708 1fb0 00000000 		or	%s63,1,(0)1
 1708      00013F45 
 1709 1fb8 00000000 		lvl	%s63
 1709      00BF00BF 
 1710 1fc0 000E1313 		vfadd.s	%v19,%v19,%v14
 1710      000080CC 
 1711 1fc8 90FFFFFF 		br.l	.L2.72
 1711      00000F18 
 1712              	.L2.30:
 1713 1fd0 00000000 		adds.l	%s61,%s63,(0)1
 1713      00BF3D59 
 1714 1fd8 00000000 		adds.l	%s61,%s61,%s59
 1714      BBBD3D59 
 1715 1fe0 00000000 		lvl	%s58
 1715      00BA00BF 
 1716 1fe8 00000031 		vldu.nc	%v49,4,%s61
 1716      BD040082 
 1717 1ff0 00000000 		adds.l	%s61,%s57,(0)1
 1717      00B93D59 
 1718 1ff8 00000000 		adds.l	%s61,%s61,%s59
 1718      BBBD3D59 
 1719 2000 00000030 		vldu.nc	%v48,4,%s61
 1719      BD040082 
 1720 2008 31303232 		vfmad.s	%v50,%v50,%v48,%v49
 1720      000080E2 
 1721              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 1722              		.loc	1 727 0
 1723 2010 00000000 		adds.l	%s59,%s59,%s55
 1723      B7BB3B59 
 1724 2018 00000000 		subs.l	%s54,%s54,%s58
 1724      BAB6365B 
 1725 2020 60FFFFFF 		brge.l	0,%s54,.L2.73
 1725      B6000518 
 1726 2028 F0F2FFFF 		br.l	.L2.29
 1726      00000F18 
 1727              	.L2.74:
 1728 2030 00000000 		subs.l	%s62,0,%s60
 1728      BC003E5B 
 1729 2038 00000000 		smvl	%s56
 1729      0000382E 
 1730 2040 80000000 		mins.l	%s61,%s62,%s56
 1730      B8BE3D68 
 1731              	# line 728
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //tmp[oc] += src[ickhkw] * pwei_oc[ickhkw];
 1732              		.loc	1 728 0
 1733 2048 00000000 		or	%s53,0,(0)1
 1733      00003545 
 1734 2050 00000000 		or	%s1,0,%s58
 1734      BA000145 
 1735 2058 00000000 		or	%s58,0,%s61
 1735      BD003A45 
 1736 2060 00000000 		or	%s2,0,%s59
 1736      BB000245 
 1737 2068 00000000 		or	%s3,0,%s54
 1737      B6000345 
 1738 2070 00000000 		lvl	%s56
 1738      00B800BF 
 1739 2078 00000032 		vbrdu	%v50,%s53
 1739      00B5808C 
 1740 2080 00000000 		or	%s54,0,%s62
 1740      BE003645 
 1741              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 1742              		.loc	1 727 0
 1743 2088 00000000 		or	%s59,0,(0)1
 1743      00003B45 
 1744 2090 00000000 		muls.l	%s55,4,%s61
 1744      BD04376E 
 1745 2098 00000000 		or	%s63,0,%s52
 1745      B4003F45 
 1746 20a0 30FFFFFF 		br.l	.L2.30
 1746      00000F18 
 1747              	.L2.75:
 1748 20a8 00000000 		or	%s53,1,(0)1
 1748      00013545 
 1749 20b0 00000000 		or	%s51,0,%s58
 1749      BA003345 
 1750 20b8 00000000 		lvl	%s53
 1750      00B500BF 
 1751 20c0 00000013 		vldu.nc	%v19,0,%s51
 1751      B3000082 
 1752 20c8 68FFFFFF 		brlt.l	0,%s19,.L2.74
 1752      93000218 
 1753 20d0 88FEFFFF 		br.l	.L2.72
 1753      00000F18 
 1754              	.L2.71:
 1755 20d8 D0FFFFFF 		brlt.l	0,%s19,.L2.75
 1755      93000218 
 1756 20e0 50FEFFFF 		br.l	.L2.70
 1756      00000F18 
 1757              	.L2.76:
 1758 20e8 10F5FFFF 		st	%s60,-2800(,%fp)	# spill 
 1758      89003C11 
 1759 20f0 C8F4FFFF 		st	%s59,-2872(,%fp)	# spill 
 1759      89003B11 
 1760 20f8 C0F4FFFF 		ld	%s59,-2880(,%fp)	# restore 
 1760      89003B01 
 1761 2100 00000000 		or	%s52,0,%s63
 1761      BF003445 
 1762 2108 C8F4FFFF 		ld	%s58,-2872(,%fp)	# restore 
 1762      89003A01 
 1763 2110 00000000 		or	%s26,0,%s53
 1763      B5001A45 
 1764 2118 00000000 		or	%s30,0,%s61
 1764      BD001E45 
 1765 2120 00000000 		or	%s33,0,%s56
 1765      B8002145 
 1766 2128 00000000 		or	%s37,0,%s57
 1766      B9002545 
 1767 2130 B8F4FFFF 		ld	%s57,-2888(,%fp)	# restore 
 1767      89003901 
 1768 2138 00000000 		or	%s38,0,%s2
 1768      82002645 
 1769 2140 00000000 		or	%s44,0,%s51
 1769      B3002C45 
 1770 2148 00000000 		or	%s50,0,%s55
 1770      B7003245 
 1771 2150 B0F4FFFF 		ld	%s54,-2896(,%fp)	# restore 
 1771      89003601 
 1772 2158 A8F4FFFF 		ld	%s60,-2904(,%fp)	# restore 
 1772      89003C01 
 1773 2160 A0F4FFFF 		ld	%s19,-2912(,%fp)	# restore 
 1773      89001301 
 1774 2168 70FFFFFF 		br.l	.L2.71
 1774      00000F18 
 1775              	.L2.77:
 1776 2170 D8F4FFFF 		ld	%s26,-2856(,%fp)	# restore 
 1776      89001A01 
 1777 2178 70FFFFFF 		brlt.l	0,%s26,.L2.76
 1777      9A000218 
 1778 2180 28FDFFFF 		br.l	.L2.68
 1778      00000F18 
 1779              	.L2.78:
 1780              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 1781              		.loc	1 724 0
 1782 2188 90FFFFFF 		ld	%s59,-112(,%fp)	# tmp
 1782      89003B01 
 1783 2190 D0FDFFFF 		ld	%s63,-560(,%fp)	# src
 1783      89003F01 
 1784 2198 D8FFFFFF 		brlt.l	0,%s40,.L2.77
 1784      A8000218 
 1785 21a0 B0F7FFFF 		br.l	.L2.58
 1785      00000F18 
 1786              	.L2.79:
 1787 21a8 E0F4FFFF 		st	%s19,-2848(,%fp)	# spill 
 1787      89001311 
 1788 21b0 E8F4FFFF 		st	%s20,-2840(,%fp)	# spill 
 1788      89001411 
 1789 21b8 A0F5FFFF 		ld	%s40,-2656(,%fp)	# restore 
 1789      89002801 
 1790 21c0 00000000 		or	%s6,0,%s21
 1790      95000645 
 1791 21c8 C0F5FFFF 		ld	%s53,-2624(,%fp)	# restore 
 1791      89003501 
 1792 21d0 00000000 		or	%s7,0,%s22
 1792      96000745 
 1793 21d8 B8F5FFFF 		ld	%s61,-2632(,%fp)	# restore 
 1793      89003D01 
 1794 21e0 00000000 		or	%s34,0,%s26
 1794      9A002245 
 1795 21e8 B0F5FFFF 		ld	%s36,-2640(,%fp)	# restore 
 1795      89002401 
 1796 21f0 A8F5FFFF 		ld	%s28,-2648(,%fp)	# restore 
 1796      89001C01 
 1797 21f8 98F5FFFF 		ld	%s31,-2664(,%fp)	# restore 
 1797      89001F01 
 1798 2200 90F5FFFF 		ld	%s46,-2672(,%fp)	# restore 
 1798      89002E01 
 1799 2208 88F5FFFF 		ld	%s56,-2680(,%fp)	# restore 
 1799      89003801 
 1800 2210 80F5FFFF 		ld	%s49,-2688(,%fp)	# restore 
 1800      89003101 
 1801 2218 78F5FFFF 		ld	%s57,-2696(,%fp)	# restore 
 1801      89003901 
 1802 2220 70F5FFFF 		ld	%s2,-2704(,%fp)	# restore 
 1802      89000201 
 1803 2228 68F5FFFF 		ld	%s5,-2712(,%fp)	# restore 
 1803      89000501 
 1804 2230 F0F4FFFF 		ld	%s35,-2832(,%fp)	# restore 
 1804      89002301 
 1805 2238 60F5FFFF 		ld	%s39,-2720(,%fp)	# restore 
 1805      89002701 
 1806 2240 58F5FFFF 		ld	%s41,-2728(,%fp)	# restore 
 1806      89002901 
 1807 2248 50F5FFFF 		ld	%s22,-2736(,%fp)	# restore 
 1807      89001601 
 1808 2250 F8F4FFFF 		ld	%s42,-2824(,%fp)	# restore 
 1808      89002A01 
 1809 2258 48F5FFFF 		ld	%s43,-2744(,%fp)	# restore 
 1809      89002B01 
 1810 2260 40F5FFFF 		ld	%s45,-2752(,%fp)	# restore 
 1810      89002D01 
 1811 2268 38F5FFFF 		ld	%s48,-2760(,%fp)	# restore 
 1811      89003001 
 1812 2270 30F5FFFF 		ld	%s51,-2768(,%fp)	# restore 
 1812      89003301 
 1813 2278 28F5FFFF 		ld	%s47,-2776(,%fp)	# restore 
 1813      89002F01 
 1814 2280 20F5FFFF 		ld	%s20,-2784(,%fp)	# restore 
 1814      89001401 
 1815 2288 18F5FFFF 		ld	%s55,-2792(,%fp)	# restore 
 1815      89003701 
 1816 2290 10F5FFFF 		ld	%s60,-2800(,%fp)	# restore 
 1816      89003C01 
 1817 2298 08F5FFFF 		ld	%s21,-2808(,%fp)	# restore 
 1817      89001501 
 1818 22a0 00F5FFFF 		ld	%s4,-2816(,%fp)	# restore 
 1818      89000401 
 1819 22a8 E0FEFFFF 		br.l	.L2.78
 1819      00000F18 
 1820              	.L2.80:
 1821 22b0 C8F5FFFF 		ld	%s0,-2616(,%fp)	# restore 
 1821      89000001 
 1822 22b8 00030000 		br.l	.L2.81
 1822      00000F18 
 1823              	.L2.82:
 1824 22c0 00000000 		or	%s61,4,(0)1
 1824      00043D45 
 1825 22c8 00000000 		st2b	%s61,0(,%s24)
 1825      98003D14 
 1826              	# line 672
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
 1827              		.loc	1 672 0
 1828 22d0 00000000 		adds.l	%s33,1,%s33
 1828      A1012159 
 1829 22d8 00000000 		adds.l	%s31,%s32,%s31
 1829      9FA01F59 
 1830 22e0 00000000 		adds.l	%s30,1,%s30
 1830      9E011E59 
 1831 22e8 C8FFFFFF 		brgt.l	0,%s33,.L2.80
 1831      A1000118 
 1832 22f0 B8FEFFFF 		br.l	.L2.79
 1832      00000F18 
 1833              	.L2.83:
 1834 22f8 00000000 		or	%s19,0,%s46
 1834      AE001345 
 1835 2300 00000000 		or	%s20,0,%s60
 1835      BC001445 
 1836 2308 00000000 		or	%s21,0,%s56
 1836      B8001545 
 1837 2310 00000000 		or	%s22,0,%s44
 1837      AC001645 
 1838 2318 00000000 		or	%s26,0,%s62
 1838      BE001A45 
 1839 2320 A0FFFFFF 		br.l	.L2.82
 1839      00000F18 
 1840              	.L2.84:
 1841              	# line 687
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw=0; kw<kww; ++kw){
 1842              		.loc	1 687 0
 1843 2328 00000000 		adds.w.sx	%s63,1,%s63
 1843      BF013F4A 
 1844 2330 00000000 		adds.l	%s57,%s62,%s57
 1844      B9BE3959 
 1845 2338 00000000 		adds.l	%s55,%s62,%s55
 1845      B7BE3759 
 1846 2340 00000000 		adds.l	%s59,%s62,%s59
 1846      BBBE3B59 
 1847 2348 00000000 		adds.w.sx	%s61,1,%s61
 1847      BD013D4A 
 1848 2350 C8010000 		brgt.w	0,%s63,.L2.85
 1848      BF008118 
 1849 2358 A0FFFFFF 		br.l	.L2.83
 1849      00000F18 
 1850              	.L2.86:
 1851 2360 00000000 		or	%s61,0,%s49
 1851      B1003D45 
 1852 2368 00000000 		or	%s62,0,%s48
 1852      B0003E45 
 1853 2370 00000000 		or	%s63,0,%s47
 1853      AF003F45 
 1854 2378 B0FFFFFF 		br.l	.L2.84
 1854      00000F18 
 1855              	.L2.28:
 1856              	# line 691
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = 0.f;
 1857              		.loc	1 691 0
 1858 2380 00000000 		lvl	%s62
 1858      00BE00BF 
 1859 2388 003F003E 		vadds.w.sx	%v62,%s63,%v63
 1859      00BF20CA 
 1860 2390 00003E39 		vcvt.s.w	%v57,%v62
 1860      000080F8 
 1861 2398 00000038 		vbrdu	%v56,%s61
 1861      00BD808C 
 1862 23a0 39003837 		vfmad.s	%v55,%v56,%s60,%v57
 1862      00BC90E2 
 1863 23a8 00000000 		adds.l	%s51,%s59,(0)1
 1863      00BB3359 
 1864 23b0 00000000 		adds.l	%s50,%s51,%s58
 1864      BAB33259 
 1865 23b8 00000037 		vstu.nc	%v55,4,%s50
 1865      B2040092 
 1866              	# line 694
 694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = ((kok[kh*kww+kw])? psrc[(int)(idx[kh*kww+kw])]: k
 1867              		.loc	1 694 0
 1868 23c0 00000000 		adds.l	%s50,%s57,(0)1
 1868      00B93259 
 1869 23c8 00000000 		adds.l	%s50,%s50,%s58
 1869      BAB23259 
 1870 23d0 00000036 		vldl.sx.nc	%v54,4,%s50
 1870      B2040083 
 1871 23d8 0036030F 		vfmk.w.ne	%vm15,%v54
 1871      000000B5 
 1872 23e0 00000F0F 		negm	%vm15,%vm15
 1872      00000095 
 1873 23e8 00000000 		or	%s50,0,(0)1
 1873      00003245 
 1874 23f0 0000003D 		vbrdu	%v61,%s50,%vm15
 1874      00B28F8C 
 1875 23f8 00000F0F 		negm	%vm15,%vm15
 1875      00000095 
 1876 2400 00000000 		adds.l	%s51,%s51,%s58
 1876      BAB33359 
 1877 2408 00000035 		vldu.nc	%v53,4,%s51
 1877      B3040082 
 1878 2410 0008353C 		vcvt.w.s.sx.rz	%v60,%v53,%vm15
 1878      00008FE8 
 1879 2418 003C003B 		vor	%v59,(0)1,%v60,%vm15
 1879      00002FC5 
 1880 2420 003B003A 		vsfa	%v58,%v59,2,%s56,%vm15
 1880      B8020FD7 
 1881 2428 00000034 		vbrd	%v52,0
 1881      0000008C 
 1882 2430 00003A34 		vgtu	%v52,%v58,0,0,%vm15
 1882      00004FA2 
 1883 2438 00343D3D 		vmrg	%v61,%v61,%v52,%vm15
 1883      00000FD6 
 1884 2440 00000000 		adds.l	%s51,%s55,(0)1
 1884      00B73359 
 1885 2448 00000000 		adds.l	%s51,%s51,%s58
 1885      BAB33359 
 1886 2450 0000003D 		vstu.nc	%v61,4,%s51
 1886      B3040092 
 1887              	# line 688
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   // using integer calc no longer results in vgather !
 1888              		.loc	1 688 0
 1889 2458 00000000 		adds.l	%s58,%s58,%s54
 1889      B6BA3A59 
 1890 2460 00000000 		adds.w.sx	%s63,%s63,%s53
 1890      B5BF3F4A 
 1891 2468 00000000 		subs.w.sx	%s52,%s52,%s62
 1891      BEB4345A 
 1892 2470 F0FEFFFF 		brge.w	0,%s52,.L2.86
 1892      B4008518 
 1893 2478 80EEFFFF 		br.l	.L2.27
 1893      00000F18 
 1894              	.L2.87:
 1895              	# line 691
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = 0.f;
 1896              		.loc	1 691 0
 1897 2480 00000000 		cvt.s.w	%s51,%s61
 1897      00BDB35E 
 1898 2488 00000000 		or	%s49,0,%s61
 1898      BD003145 
 1899 2490 00000000 		or	%s47,0,%s63
 1899      BF002F45 
 1900 2498 00000000 		fmul.s	%s51,%s51,%s46
 1900      AEB3B34D 
 1901 24a0 00000000 		or	%s48,0,%s62
 1901      BE003045 
 1902 24a8 00000000 		fadd.s	%s61,%s51,%s45
 1902      ADB3BD4C 
 1903              	# line 688
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   // using integer calc no longer results in vgather !
 1904              		.loc	1 688 0
 1905 24b0 00000000 		subs.w.sx	%s51,0,%s44
 1905      AC00335A 
 1906 24b8 00000000 		smvl	%s50
 1906      0000322E 
 1907 24c0 80000000 		mins.w.sx	%s62,%s51,%s50
 1907      B2B33E78 
 1908 24c8 00000000 		or	%s52,0,%s51
 1908      B3003445 
 1909 24d0 00000000 		or	%s58,0,(0)1
 1909      00003A45 
 1910 24d8 00000000 		or	%s51,0,%s62
 1910      BE003345 
 1911 24e0 00000000 		muls.l	%s54,4,%s51
 1911      B304366E 
 1912 24e8 00000000 		or	%s63,0,(0)1
 1912      00003F45 
 1913 24f0 00000000 		lvl	%s62
 1913      00BE00BF 
 1914 24f8 00000033 		vseq	%v51
 1914      00000099 
 1915 2500 0033003F 		vor	%v63,(0)1,%v51
 1915      000020C5 
 1916 2508 00000000 		or	%s53,0,%s62
 1916      BE003545 
 1917 2510 70FEFFFF 		br.l	.L2.28
 1917      00000F18 
 1918              	.L2.85:
 1919 2518 68FFFFFF 		brlt.w	0,%s18,.L2.87
 1919      92008218 
 1920 2520 08FEFFFF 		br.l	.L2.84
 1920      00000F18 
 1921              	.L2.88:
 1922 2528 50FFFFFF 		dld	%s58,-176(,%fp)	# kok
 1922      89003A09 
 1923 2530 00000000 		or	%s62,0,%s26
 1923      9A003E45 
 1924 2538 D0FDFFFF 		dld	%s54,-560(,%fp)	# src
 1924      89003609 
 1925              	# line 691
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = 0.f;
 1926              		.loc	1 691 0
 1927 2540 00000000 		cvt.d.l	%s53,%s30
 1927      009E355F 
 1928 2548 00000000 		cvt.s.d	%s53,%s53
 1928      00B5351F 
 1929 2550 00000000 		fmul.s	%s53,%s53,%s29
 1929      9DB5B54D 
 1930 2558 00000000 		fadd.s	%s45,%s53,%s28
 1930      9CB5AD4C 
 1931 2560 00000000 		or	%s63,0,%s27
 1931      9B003F45 
 1932 2568 00000000 		or	%s57,0,%s58
 1932      BA003945 
 1933 2570 00000000 		or	%s59,0,%s59
 1933      BB003B45 
 1934              	# line 687
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw=0; kw<kww; ++kw){
 1935              		.loc	1 687 0
 1936 2578 00000000 		muls.l	%s26,%s31,%s26
 1936      9A9F1A6E 
 1937 2580 00000000 		adds.l	%s26,%s54,%s26
 1937      9AB61A59 
 1938 2588 00000000 		or	%s55,0,%s26
 1938      9A003745 
 1939 2590 00000000 		or	%s44,0,%s22
 1939      96002C45 
 1940 2598 00000000 		or	%s56,0,%s21
 1940      95003845 
 1941 25a0 00000000 		or	%s60,0,%s20
 1941      94003C45 
 1942 25a8 00000000 		or	%s46,0,%s19
 1942      93002E45 
 1943 25b0 68FFFFFF 		br.l	.L2.85
 1943      00000F18 
 1944              	.L2.81:
 1945 25b8 C8F5FFFF 		st	%s0,-2616(,%fp)	# spill 
 1945      89000011 
 1946              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (int khkw = 0; khkw < khkw_end; ++khkw) {
 1947              		.loc	1 683 0
 1948 25c0 00000000 		lea	%s12,__grow_stack@LO
 1948      00000C06 
 1949 25c8 00000000 		and	%s12,%s12,(32)0
 1949      608C0C44 
 1950 25d0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1950      8C008C06 
 1951 25d8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1951      8C000A08 
 1952 25e0 D0000000 		lea	%s59,208
 1952      00003B06 
 1953 25e8 00000000 		adds.l	%s59,%sp,%s59
 1953      BB8B3B59 
 1954 25f0 00000000 		st	%s59,0(,%s23)
 1954      97003B11 
 1955 25f8 F0FFFFFF 		ld	%s59,-16(,%fp)	# idx
 1955      89003B01 
 1956 2600 80FFFFFF 		lea	%s58,-128
 1956      00003A06 
 1957 2608 00000000 		st	%s59,0(%s58,%fp)
 1957      89BA3B11 
 1958              	# line 687
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw=0; kw<kww; ++kw){
 1959              		.loc	1 687 0
 1960 2610 00000000 		or	%s61,0,(0)1
 1960      00003D45 
 1961 2618 00000000 		or	%s58,5,(0)1
 1961      00053A45 
 1962 2620 00000000 		st2b	%s58,0(,%s24)
 1962      98003A14 
 1963 2628 00FFFFFF 		brlt.w	0,%s25,.L2.88
 1963      99008218 
 1964 2630 90FCFFFF 		br.l	.L2.82
 1964      00000F18 
 1965              	.L2.89:
 1966 2638 C0F5FFFF 		st	%s53,-2624(,%fp)	# spill 
 1966      89003511 
 1967 2640 B8F5FFFF 		st	%s61,-2632(,%fp)	# spill 
 1967      89003D11 
 1968 2648 B0F5FFFF 		st	%s36,-2640(,%fp)	# spill 
 1968      89002411 
 1969 2650 A8F5FFFF 		st	%s28,-2648(,%fp)	# spill 
 1969      89001C11 
 1970 2658 A0F5FFFF 		st	%s40,-2656(,%fp)	# spill 
 1970      89002811 
 1971 2660 98F5FFFF 		st	%s31,-2664(,%fp)	# spill 
 1971      89001F11 
 1972 2668 90F5FFFF 		st	%s46,-2672(,%fp)	# spill 
 1972      89002E11 
 1973 2670 88F5FFFF 		st	%s56,-2680(,%fp)	# spill 
 1973      89003811 
 1974 2678 80F5FFFF 		st	%s49,-2688(,%fp)	# spill 
 1974      89003111 
 1975 2680 78F5FFFF 		st	%s57,-2696(,%fp)	# spill 
 1975      89003911 
 1976 2688 70F5FFFF 		st	%s2,-2704(,%fp)	# spill 
 1976      89000211 
 1977 2690 68F5FFFF 		st	%s5,-2712(,%fp)	# spill 
 1977      89000511 
 1978 2698 60F5FFFF 		st	%s39,-2720(,%fp)	# spill 
 1978      89002711 
 1979 26a0 58F5FFFF 		st	%s41,-2728(,%fp)	# spill 
 1979      89002911 
 1980 26a8 50F5FFFF 		st	%s22,-2736(,%fp)	# spill 
 1980      89001611 
 1981 26b0 48F5FFFF 		st	%s43,-2744(,%fp)	# spill 
 1981      89002B11 
 1982 26b8 40F5FFFF 		st	%s45,-2752(,%fp)	# spill 
 1982      89002D11 
 1983 26c0 38F5FFFF 		st	%s48,-2760(,%fp)	# spill 
 1983      89003011 
 1984 26c8 30F5FFFF 		st	%s51,-2768(,%fp)	# spill 
 1984      89003311 
 1985 26d0 28F5FFFF 		st	%s47,-2776(,%fp)	# spill 
 1985      89002F11 
 1986 26d8 20F5FFFF 		st	%s20,-2784(,%fp)	# spill 
 1986      89001411 
 1987 26e0 18F5FFFF 		st	%s55,-2792(,%fp)	# spill 
 1987      89003711 
 1988 26e8 10F5FFFF 		st	%s60,-2800(,%fp)	# spill 
 1988      89003C11 
 1989 26f0 08F5FFFF 		st	%s21,-2808(,%fp)	# spill 
 1989      89001511 
 1990 26f8 00F5FFFF 		st	%s4,-2816(,%fp)	# spill 
 1990      89000411 
 1991 2700 F8F4FFFF 		st	%s42,-2824(,%fp)	# spill 
 1991      89002A11 
 1992 2708 F0F4FFFF 		st	%s35,-2832(,%fp)	# spill 
 1992      89002311 
 1993              	# line 691
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = 0.f;
 1994              		.loc	1 691 0
 1995 2710 00000000 		cvt.d.l	%s42,%s42
 1995      00AA2A5F 
 1996 2718 00000000 		cvt.s.d	%s28,%s42
 1996      00AA1C1F 
 1997 2720 00000000 		or	%s33,0,%s35
 1997      A3002145 
 1998              	# line 672
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
 1999              		.loc	1 672 0
 2000 2728 00000000 		or	%s31,0,(0)1
 2000      00001F45 
 2001 2730 00000000 		or	%s26,0,%s34
 2001      A2001A45 
 2002 2738 00000000 		or	%s22,0,%s7
 2002      87001645 
 2003 2740 00000000 		or	%s21,0,%s6
 2003      86001545 
 2004 2748 E8F4FFFF 		ld	%s20,-2840(,%fp)	# restore 
 2004      89001401 
 2005 2750 E0F4FFFF 		ld	%s19,-2848(,%fp)	# restore 
 2005      89001301 
 2006 2758 C8F5FFFF 		ld	%s0,-2616(,%fp)	# restore 
 2006      89000001 
 2007 2760 58FEFFFF 		br.l	.L2.81
 2007      00000F18 
 2008              	.L2.90:
 2009 2768 00000000 		or	%s30,0,(0)1
 2009      00001E45 
 2010 2770 C8FEFFFF 		brlt.l	0,%s31,.L2.89
 2010      9F000218 
 2011 2778 10FAFFFF 		br.l	.L2.78
 2011      00000F18 
 2012              	.L2.91:
 2013 2780 00000000 		or	%s47,0,%s63
 2013      BF002F45 
 2014 2788 00000000 		or	%s51,0,%s62
 2014      BE003345 
 2015 2790 00000000 		or	%s48,0,%s44
 2015      AC003045 
 2016 2798 00000000 		or	%s57,0,%s38
 2016      A6003945 
 2017 27a0 00000000 		or	%s49,0,%s37
 2017      A5003145 
 2018 27a8 00000000 		or	%s53,0,%s3
 2018      83003545 
 2019 27b0 B8FFFFFF 		br.l	.L2.90
 2019      00000F18 
 2020              	.L2.26:
 2021              	# line 644
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //kok[khkw] = ((kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end)? 0xffFFffFF: 
 2022              		.loc	1 644 0
 2023 27b8 24000000 		ldl.sx	%s59,36(,%s61)	# *(p).__b_N4conv6desc_tE.kw
 2023      BD003B03 
 2024 27c0 00000000 		lvl	%s57
 2024      00B900BF 
 2025 27c8 0021001B 		vadds.w.sx	%v27,%s58,%v33
 2025      00BA20CA 
 2026 27d0 00001B1A 		vdivs.w.sx	%v26,%v27,%s59
 2026      00BB10EB 
 2027 27d8 001A0019 		vmuls.w.sx	%v25,%s59,%v26
 2027      00BB20CB 
 2028 27e0 00210018 		vadds.w.sx	%v24,%s58,%v33
 2028      00BA20CA 
 2029 27e8 00191817 		vsubs.w.sx	%v23,%v24,%v25
 2029      000000DA 
 2030 27f0 001A0016 		vor	%v22,(0)1,%v26
 2030      000020C5 
 2031 27f8 00160015 		vcmps.l	%v21,%s54,%v22
 2031      00B620BA 
 2032 2800 0015060F 		vfmk.l.le	%vm15,%v21
 2032      000000B4 
 2033 2808 00170020 		vor	%v32,(0)1,%v23,%vm15
 2033      00002FC5 
 2034 2810 0020001F 		vcmps.l	%v31,%s53,%v32,%vm15
 2034      00B52FBA 
 2035 2818 001F060E 		vfmk.l.le	%vm14,%v31,%vm15
 2035      00000FB4 
 2036 2820 0016001E 		vcmps.l	%v30,%s52,%v22,%vm14
 2036      00B42EBA 
 2037 2828 001E010D 		vfmk.l.gt	%vm13,%v30,%vm14
 2037      00000EB4 
 2038 2830 0020001D 		vcmps.l	%v29,%s51,%v32,%vm13
 2038      00B32DBA 
 2039 2838 001D060C 		vfmk.l.le	%vm12,%v29,%vm13
 2039      00000DB4 
 2040 2840 000E0D0B 		nndm	%vm11,%vm13,%vm14
 2040      00000094 
 2041 2848 000F0E0E 		nndm	%vm14,%vm14,%vm15
 2041      00000094 
 2042 2850 00000F0F 		negm	%vm15,%vm15
 2042      00000095 
 2043 2858 000B0C0B 		orm	%vm11,%vm12,%vm11
 2043      00000085 
 2044 2860 000E0B0E 		orm	%vm14,%vm11,%vm14
 2044      00000085 
 2045 2868 000F0E0F 		orm	%vm15,%vm14,%vm15
 2045      00000085 
 2046 2870 0000001C 		vbrd	%v28,0,%vm15
 2046      00000F8C 
 2047 2878 000D0C0D 		nndm	%vm13,%vm12,%vm13
 2047      00000094 
 2048 2880 FFFFFFFF 		lea	%s59,-1
 2048      00003B06 
 2049 2888 00000000 		and	%s59,%s59,(32)0
 2049      60BB3B44 
 2050 2890 0000001C 		vbrd	%v28,%s59,%vm13
 2050      00BB0D8C 
 2051 2898 001C0014 		vor	%v20,(0)1,%v28
 2051      000020C5 
 2052 28a0 00000000 		or	%s59,0,%s50
 2052      B2003B45 
 2053 28a8 00000014 		vstl.nc	%v20,4,%s59
 2053      BB040093 
 2054              	# line 641
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const int kh = khkw / p->kw;
 2055              		.loc	1 641 0
 2056 28b0 00000000 		adds.l	%s50,%s50,%s49
 2056      B1B23259 
 2057 28b8 00000000 		adds.w.sx	%s58,%s58,%s48
 2057      B0BA3A4A 
 2058 28c0 00000000 		subs.w.sx	%s47,%s47,%s57
 2058      B9AF2F5A 
 2059 28c8 B8FEFFFF 		brge.w	0,%s47,.L2.91
 2059      AF008518 
 2060 28d0 18EAFFFF 		br.l	.L2.25
 2060      00000F18 
 2061              	.L2.92:
 2062 28d8 D0F4FFFF 		ld	%s0,-2864(,%fp)	# restore 
 2062      89000001 
 2063 28e0 00000000 		or	%s37,0,%s49
 2063      B1002545 
 2064 28e8 00000000 		or	%s38,0,%s57
 2064      B9002645 
 2065 28f0 00000000 		subs.w.sx	%s0,0,%s0
 2065      8000005A 
 2066 28f8 00000000 		smvl	%s33
 2066      0000212E 
 2067 2900 80000000 		mins.w.sx	%s57,%s0,%s33
 2067      A1803978 
 2068 2908 00000000 		or	%s62,0,%s51
 2068      B3003E45 
 2069 2910 00000000 		or	%s51,0,%s3
 2069      83003345 
 2070 2918 00000000 		or	%s3,0,%s53
 2070      B5000345 
 2071 2920 00000000 		or	%s53,0,%s1
 2071      81003545 
 2072 2928 00000000 		or	%s44,0,%s48
 2072      B0002C45 
 2073 2930 00000000 		or	%s63,0,%s47
 2073      AF003F45 
 2074 2938 00000000 		or	%s47,0,%s0
 2074      80002F45 
 2075 2940 00000000 		or	%s50,0,%s59
 2075      BB003245 
 2076 2948 00000000 		or	%s59,0,%s57
 2076      B9003B45 
 2077 2950 00000000 		muls.l	%s49,4,%s59
 2077      BB04316E 
 2078 2958 00000000 		or	%s58,0,(0)1
 2078      00003A45 
 2079 2960 00000000 		or	%s48,0,%s57
 2079      B9003045 
 2080 2968 00000000 		lvl	%s57
 2080      00B900BF 
 2081 2970 00000009 		vseq	%v9
 2081      00000099 
 2082 2978 00090021 		vor	%v33,(0)1,%v9
 2082      000020C5 
 2083 2980 38FEFFFF 		br.l	.L2.26
 2083      00000F18 
 2084              	.L2.93:
 2085 2988 00000000 		or	%s28,0,%s50
 2085      B2001C45 
 2086 2990 50FFFFFF 		ld	%s59,-176(,%fp)	# kok
 2086      89003B01 
 2087 2998 40FFFFFF 		brlt.w	0,%s36,.L2.92
 2087      A4008218 
 2088 29a0 C8FDFFFF 		br.l	.L2.90
 2088      00000F18 
 2089              	.L2.94:
 2090              	# line 629
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[1] = kh_end;
 2091              		.loc	1 629 0
 2092 29a8 B8FFFFFF 		st	%s54,-72(,%fp)	# khkw_begend
 2092      89003611 
 2093              	# line 630
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[2] = kw_beg;
 2094              		.loc	1 630 0
 2095 29b0 C0FFFFFF 		st	%s52,-64(,%fp)	# khkw_begend
 2095      89003411 
 2096              	# line 631
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khkw_begend[3] = kw_end;
 2097              		.loc	1 631 0
 2098 29b8 C8FFFFFF 		st	%s1,-56(,%fp)	# khkw_begend
 2098      89000111 
 2099              	# line 632
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             khash = 0;
 2100              		.loc	1 632 0
 2101 29c0 D0FFFFFF 		st	%s3,-48(,%fp)	# khkw_begend
 2101      89000311 
 2102              	# line 635
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (khash != khash_prv){
 2103              		.loc	1 635 0
 2104 29c8 98FFFFFF 		ld	%s59,-104(,%fp)	# khkw_muls
 2104      89003B01 
 2105 29d0 00000000 		muls.l	%s59,%s54,%s59
 2105      BBB63B6E 
 2106 29d8 A0FFFFFF 		ld	%s50,-96(,%fp)	# khkw_muls
 2106      89003201 
 2107 29e0 00000000 		muls.l	%s50,%s52,%s50
 2107      B2B4326E 
 2108 29e8 00000000 		adds.l	%s50,%s59,%s50
 2108      B2BB3259 
 2109 29f0 A8FFFFFF 		ld	%s59,-88(,%fp)	# khkw_muls
 2109      89003B01 
 2110 29f8 00000000 		muls.l	%s59,%s1,%s59
 2110      BB813B6E 
 2111 2a00 00000000 		adds.l	%s59,%s50,%s59
 2111      BBB23B59 
 2112 2a08 B0FFFFFF 		ld	%s50,-80(,%fp)	# khkw_muls
 2112      89003201 
 2113 2a10 00000000 		muls.l	%s50,%s3,%s50
 2113      B283326E 
 2114 2a18 00000000 		adds.l	%s50,%s59,%s50
 2114      B2BB3259 
 2115 2a20 68FFFFFF 		brne.l	%s50,%s28,.L2.93
 2115      9CB20318 
 2116 2a28 40FDFFFF 		br.l	.L2.90
 2116      00000F18 
 2117              	.L2.24:
 2118 2a30 38000000 		lea	%s50,56
 2118      00003206 
 2119              	# line 624
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (khw_ok)
 2120              		.loc	1 624 0
 2121 2a38 00000000 		sll	%s59,%s59,%s50
 2121      BBB23B65 
 2122 2a40 38000000 		lea	%s50,56
 2122      00003206 
 2123 2a48 00000000 		sra.l	%s59,%s59,%s50
 2123      BBB23B77 
 2124 2a50 00000000 		or	%s59,0,%s59
 2124      BB003B45 
 2125 2a58 50FFFFFF 		brne.w	0,%s59,.L2.94
 2125      BB008318 
 2126 2a60 F0EEFFFF 		br.l	.L2.58
 2126      00000F18 
 2127              	.L2.95:
 2128 2a68 00000000 		or	%s59,1,(0)1
 2128      00013B45 
 2129 2a70 00000000 		or	%s1,0,%s53
 2129      B5000145 
 2130 2a78 00000000 		or	%s53,0,%s62
 2130      BE003545 
 2131 2a80 00000000 		or	%s2,0,%s58
 2131      BA000245 
 2132 2a88 00000000 		or	%s3,0,%s51
 2132      B3000345 
 2133 2a90 00000000 		or	%s51,0,%s63
 2133      BF003345 
 2134 2a98 98FFFFFF 		br.l	.L2.24
 2134      00000F18 
 2135              	.L2.96:
 2136 2aa0 C8FFFFFF 		brlt.l	%s54,%s52,.L2.95
 2136      B4B60218 
 2137 2aa8 08E8FFFF 		br.l	.L2.23
 2137      00000F18 
 2138              	.L2.97:
 2139              	# line 622
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 2140              		.loc	1 622 0
 2141 2ab0 80000000 		mins.l	%s51,%s59,%s57
 2141      B9BB3368 
 2142 2ab8 E8FFFFFF 		brlt.l	%s53,%s51,.L2.96
 2142      B3B50218 
 2143 2ac0 F0E7FFFF 		br.l	.L2.23
 2143      00000F18 
 2144              	.L2.98:
 2145              	# line 621
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kw_end >= KW) kw_end = KW;
 2146              		.loc	1 621 0
 2147 2ac8 00000000 		divs.l	%s59,%s43,%s46
 2147      AEAB3B7F 
 2148 2ad0 E0FFFFFF 		br.l	.L2.97
 2148      00000F18 
 2149              	.L2.99:
 2150 2ad8 F0FFFFFF 		brgt.l	0,%s48,.L2.98
 2150      B0000118 
 2151 2ae0 D0FFFFFF 		br.l	.L2.97
 2151      00000F18 
 2152              	.L2.100:
 2153              	# line 620
 620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 2154              		.loc	1 620 0
 2155 2ae8 00000000 		divs.l	%s53,%s45,%s46
 2155      AEAD357F 
 2156 2af0 E8FFFFFF 		br.l	.L2.99
 2156      00000F18 
 2157              	.L2.101:
 2158              	# line 617
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 2159              		.loc	1 617 0
 2160 2af8 80000000 		mins.l	%s52,%s59,%s58
 2160      BABB3468 
 2161              	# line 619
 619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
 2162              		.loc	1 619 0
 2163 2b00 00000000 		or	%s53,0,(0)1
 2163      00003545 
 2164 2b08 00000000 		or	%s59,0,(0)1
 2164      00003B45 
 2165 2b10 D8FFFFFF 		brgt.l	0,%s22,.L2.100
 2165      96000118 
 2166 2b18 C0FFFFFF 		br.l	.L2.99
 2166      00000F18 
 2167              	.L2.102:
 2168              	# line 616
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kh_end >= KH) kh_end = KH;
 2169              		.loc	1 616 0
 2170 2b20 00000000 		divs.l	%s59,%s55,%s56
 2170      B8B73B7F 
 2171 2b28 D0FFFFFF 		br.l	.L2.101
 2171      00000F18 
 2172              	.L2.103:
 2173              	# line 615
 615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
 2174              		.loc	1 615 0
 2175 2b30 00000000 		or	%s59,0,(0)1
 2175      00003B45 
 2176 2b38 E8FFFFFF 		brgt.l	0,%s21,.L2.102
 2176      95000118 
 2177 2b40 B8FFFFFF 		br.l	.L2.101
 2177      00000F18 
 2178              	.L2.104:
 2179              	# line 614
 614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kh_end = 0;
 2180              		.loc	1 614 0
 2181 2b48 00000000 		divs.l	%s54,%s60,%s56
 2181      B8BC367F 
 2182 2b50 E0FFFFFF 		br.l	.L2.103
 2182      00000F18 
 2183              	.L2.18:
 2184              	# line 613
 613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
 2185              		.loc	1 613 0
 2186 2b58 00000000 		or	%s54,0,(0)1
 2186      00003645 
 2187 2b60 E8FFFFFF 		brgt.l	0,%s20,.L2.104
 2187      94000118 
 2188 2b68 C8FFFFFF 		br.l	.L2.103
 2188      00000F18 
 2189              	.L2.105:
 2190 2b70 00000000 		or	%s58,0,%s53
 2190      B5003A45 
 2191 2b78 00000000 		or	%s57,0,%s52
 2191      B4003945 
 2192 2b80 00000000 		or	%s61,0,%s51
 2192      B3003D45 
 2193 2b88 D0FFFFFF 		br.l	.L2.18
 2193      00000F18 
 2194              	.L2.22:
 2195              	# line 605
 605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }else{
 2196              		.loc	1 605 0
 2197 2b90 00000000 		or	%s61,0,(0)1
 2197      00003D45 
 2198 2b98 00000000 		lvl	%s59
 2198      00BB00BF 
 2199 2ba0 00000024 		vbrdu	%v36,%s61
 2199      00BD808C 
 2200 2ba8 00000000 		or	%s61,0,%s58
 2200      BA003D45 
 2201 2bb0 00000024 		vstu.nc	%v36,4,%s61
 2201      BD040092 
 2202              	# line 604
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = 0.f;
 2203              		.loc	1 604 0
 2204 2bb8 00000000 		adds.l	%s58,%s58,%s57
 2204      B9BA3A59 
 2205 2bc0 00000000 		subs.l	%s54,%s54,%s59
 2205      BBB6365B 
 2206 2bc8 A8FFFFFF 		brge.l	0,%s54,.L2.105
 2206      B6000518 
 2207 2bd0 D0E6FFFF 		br.l	.L2.21
 2207      00000F18 
 2208              	.L2.106:
 2209 2bd8 00000000 		subs.l	%s50,0,%s39
 2209      A700325B 
 2210 2be0 00000000 		smvl	%s44
 2210      00002C2E 
 2211 2be8 80000000 		mins.l	%s44,%s50,%s44
 2211      ACB22C68 
 2212 2bf0 00000000 		or	%s54,0,%s50
 2212      B2003645 
 2213 2bf8 00000000 		or	%s58,0,%s59
 2213      BB003A45 
 2214 2c00 00000000 		muls.l	%s50,4,%s44
 2214      AC04326E 
 2215 2c08 00000000 		or	%s52,0,%s57
 2215      B9003445 
 2216 2c10 00000000 		or	%s53,0,%s2
 2216      82003545 
 2217 2c18 00000000 		or	%s63,0,%s51
 2217      B3003F45 
 2218 2c20 00000000 		or	%s51,0,%s61
 2218      BD003345 
 2219 2c28 00000000 		or	%s59,0,%s44
 2219      AC003B45 
 2220 2c30 00000000 		or	%s57,0,%s50
 2220      B2003945 
 2221 2c38 58FFFFFF 		br.l	.L2.22
 2221      00000F18 
 2222              	.L2.107:
 2223 2c40 90FFFFFF 		ld	%s59,-112(,%fp)	# tmp
 2223      89003B01 
 2224 2c48 00000000 		or	%s62,0,%s53
 2224      B5003E45 
 2225 2c50 88FFFFFF 		brlt.l	0,%s40,.L2.106
 2225      A8000218 
 2226 2c58 00000000 		or	%s58,0,%s2
 2226      82003A45 
 2227 2c60 00000000 		or	%s63,0,%s51
 2227      B3003F45 
 2228 2c68 F0FEFFFF 		br.l	.L2.18
 2228      00000F18 
 2229              	.L2.49:
 2230              	# line 603
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc)
 2231              		.loc	1 603 0
 2232 2c70 48000000 		ldl.zx	%s59,72(,%s61)	# *(p).dir
 2232      BD00BB03 
 2233 2c78 00000000 		adds.w.sx	%s59,0,%s59
 2233      BB003B4A 
 2234 2c80 04000000 		lea	%s58,4
 2234      00003A06 
 2235 2c88 00000000 		and	%s58,%s59,%s58
 2235      BABB3A44 
 2236 2c90 B0FFFFFF 		breq.w	0,%s58,.L2.107
 2236      BA008418 
 2237 2c98 D8E5FFFF 		br.l	.L2.20
 2237      00000F18 
 2238              	.L2.108:
 2239 2ca0 78F4FFFF 		st	%s51,-2952(,%fp)	# spill 
 2239      89003311 
 2240 2ca8 70F4FFFF 		st	%s22,-2960(,%fp)	# spill 
 2240      89001611 
 2241 2cb0 68F4FFFF 		st	%s59,-2968(,%fp)	# spill 
 2241      89003B11 
 2242 2cb8 60F4FFFF 		st	%s50,-2976(,%fp)	# spill 
 2242      89003211 
 2243 2cc0 58F4FFFF 		st	%s48,-2984(,%fp)	# spill 
 2243      89003011 
 2244 2cc8 50F4FFFF 		st	%s43,-2992(,%fp)	# spill 
 2244      89002B11 
 2245 2cd0 48F4FFFF 		st	%s42,-3000(,%fp)	# spill 
 2245      89002A11 
 2246 2cd8 40F4FFFF 		st	%s45,-3008(,%fp)	# spill 
 2246      89002D11 
 2247 2ce0 38F4FFFF 		st	%s63,-3016(,%fp)	# spill 
 2247      89003F11 
 2248 2ce8 30F4FFFF 		st	%s62,-3024(,%fp)	# spill 
 2248      89003E11 
 2249 2cf0 28F4FFFF 		st	%s58,-3032(,%fp)	# spill 
 2249      89003A11 
 2250 2cf8 20F4FFFF 		st	%s54,-3040(,%fp)	# spill 
 2250      89003611 
 2251 2d00 18F4FFFF 		st	%s52,-3048(,%fp)	# spill 
 2251      89003411 
 2252 2d08 00000000 		or	%s51,0,%s63
 2252      BF003345 
 2253 2d10 00000000 		or	%s48,0,%s62
 2253      BE003045 
 2254 2d18 00000000 		or	%s45,0,%s58
 2254      BA002D45 
 2255 2d20 00000000 		or	%s43,0,%s54
 2255      B6002B45 
 2256 2d28 40F4FFFF 		ld	%s42,-3008(,%fp)	# restore 
 2256      89002A01 
 2257 2d30 00000000 		or	%s22,0,%s52
 2257      B4001645 
 2258 2d38 48F4FFFF 		ld	%s41,-3000(,%fp)	# restore 
 2258      89002901 
 2259 2d40 30FFFFFF 		br.l	.L2.49
 2259      00000F18 
 2260              	.L2.46:
 2261 2d48 58FFFFFF 		brlt.l	0,%s22,.L2.108
 2261      96000218 
 2262 2d50 90E8FFFF 		br.l	.L2.45
 2262      00000F18 
 2263              	.L2.109:
 2264 2d58 10F4FFFF 		st	%s20,-3056(,%fp)	# spill 
 2264      89001411 
 2265 2d60 08F4FFFF 		st	%s59,-3064(,%fp)	# spill 
 2265      89003B11 
 2266 2d68 00F4FFFF 		st	%s45,-3072(,%fp)	# spill 
 2266      89002D11 
 2267 2d70 F8F3FFFF 		st	%s41,-3080(,%fp)	# spill 
 2267      89002911 
 2268 2d78 F0F3FFFF 		st	%s38,-3088(,%fp)	# spill 
 2268      89002611 
 2269 2d80 E8F3FFFF 		st	%s42,-3096(,%fp)	# spill 
 2269      89002A11 
 2270 2d88 E0F3FFFF 		st	%s44,-3104(,%fp)	# spill 
 2270      89002C11 
 2271 2d90 D8F3FFFF 		st	%s37,-3112(,%fp)	# spill 
 2271      89002511 
 2272 2d98 D0F3FFFF 		st	%s3,-3120(,%fp)	# spill 
 2272      89000311 
 2273 2da0 C8F3FFFF 		st	%s1,-3128(,%fp)	# spill 
 2273      89000111 
 2274 2da8 C0F3FFFF 		st	%s33,-3136(,%fp)	# spill 
 2274      89002111 
 2275 2db0 B8F3FFFF 		st	%s30,-3144(,%fp)	# spill 
 2275      89001E11 
 2276 2db8 B0F3FFFF 		st	%s26,-3152(,%fp)	# spill 
 2276      89001A11 
 2277 2dc0 00000000 		or	%s59,0,%s44
 2277      AC003B45 
 2278 2dc8 00000000 		or	%s21,0,%s37
 2278      A5001545 
 2279 2dd0 00000000 		or	%s60,0,%s3
 2279      83003C45 
 2280 2dd8 00000000 		or	%s55,0,%s1
 2280      81003745 
 2281              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2282              		.loc	1 600 0
 2283 2de0 00000000 		adds.l	%s33,%s42,%s33
 2283      A1AA2159 
 2284 2de8 00000000 		or	%s45,0,%s33
 2284      A1002D45 
 2285 2df0 00000000 		or	%s20,0,%s30
 2285      9E001445 
 2286 2df8 00000000 		muls.l	%s38,%s38,%s43
 2286      ABA6266E 
 2287 2e00 00000000 		adds.l	%s26,%s38,%s26
 2287      9AA61A59 
 2288 2e08 00000000 		or	%s42,0,%s26
 2288      9A002A45 
 2289 2e10 38FFFFFF 		br.l	.L2.46
 2289      00000F18 
 2290              	.L2.43:
 2291 2e18 40FFFFFF 		brlt.l	0,%s20,.L2.109
 2291      94000218 
 2292 2e20 28E7FFFF 		br.l	.L2.42
 2292      00000F18 
 2293              	.L2.110:
 2294 2e28 A8F3FFFF 		st	%s21,-3160(,%fp)	# spill 
 2294      89001511 
 2295 2e30 B8F4FFFF 		st	%s60,-2888(,%fp)	# spill 
 2295      89003C11 
 2296 2e38 A0F3FFFF 		st	%s59,-3168(,%fp)	# spill 
 2296      89003B11 
 2297 2e40 98F3FFFF 		st	%s42,-3176(,%fp)	# spill 
 2297      89002A11 
 2298 2e48 90F3FFFF 		st	%s38,-3184(,%fp)	# spill 
 2298      89002611 
 2299 2e50 88F3FFFF 		st	%s6,-3192(,%fp)	# spill 
 2299      89000611 
 2300 2e58 80F3FFFF 		st	%s34,-3200(,%fp)	# spill 
 2300      89002211 
 2301 2e60 78F3FFFF 		st	%s5,-3208(,%fp)	# spill 
 2301      89000511 
 2302 2e68 70F3FFFF 		st	%s7,-3216(,%fp)	# spill 
 2302      89000711 
 2303 2e70 68F3FFFF 		st	%s55,-3224(,%fp)	# spill 
 2303      89003711 
 2304 2e78 60F3FFFF 		st	%s19,-3232(,%fp)	# spill 
 2304      89001311 
 2305 2e80 58F3FFFF 		st	%s4,-3240(,%fp)	# spill 
 2305      89000411 
 2306 2e88 00000000 		or	%s59,0,%s55
 2306      B7003B45 
 2307              	# line 599
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oh = 0; oh < OH; ++oh) {
 2308              		.loc	1 599 0
 2309 2e90 00000000 		muls.l	%s19,%s7,%s19
 2309      9387136E 
 2310 2e98 00000000 		or	%s42,0,%s19
 2310      93002A45 
 2311 2ea0 00000000 		or	%s38,0,%s5
 2311      85002645 
 2312              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 2313              		.loc	1 724 0
 2314 2ea8 00000000 		adds.l	%s60,%s34,%s4
 2314      84A23C59 
 2315 2eb0 50F3FFFF 		ld	%s55,-3248(,%fp)	# restore 
 2315      89003701 
 2316 2eb8 00000000 		or	%s4,0,%s63
 2316      BF000445 
 2317 2ec0 98F4FFFF 		st	%s60,-2920(,%fp)	# spill 
 2317      89003C11 
 2318 2ec8 00000000 		adds.l	%s60,%s34,%s55
 2318      B7A23C59 
 2319 2ed0 48F3FFFF 		ld	%s55,-3256(,%fp)	# restore 
 2319      89003701 
 2320 2ed8 90F4FFFF 		st	%s60,-2928(,%fp)	# spill 
 2320      89003C11 
 2321 2ee0 00000000 		adds.l	%s55,%s34,%s55
 2321      B7A23759 
 2322 2ee8 88F4FFFF 		st	%s55,-2936(,%fp)	# spill 
 2322      89003711 
 2323 2ef0 38F4FFFF 		ld	%s63,-3016(,%fp)	# restore 
 2323      89003F01 
 2324 2ef8 40F3FFFF 		ld	%s34,-3264(,%fp)	# restore 
 2324      89002201 
 2325 2f00 38F3FFFF 		ld	%s7,-3272(,%fp)	# restore 
 2325      89000701 
 2326 2f08 68F5FFFF 		ld	%s5,-2712(,%fp)	# restore 
 2326      89000501 
 2327 2f10 30F3FFFF 		ld	%s6,-3280(,%fp)	# restore 
 2327      89000601 
 2328 2f18 00FFFFFF 		br.l	.L2.43
 2328      00000F18 
 2329              	.L2.39:
 2330 2f20 08FFFFFF 		brlt.l	0,%s21,.L2.110
 2330      95000218 
 2331 2f28 48E5FFFF 		br.l	.L2.40
 2331      00000F18 
 2332              	.L2.111:
 2333 2f30 30F3FFFF 		st	%s56,-3280(,%fp)	# spill 
 2333      89003811 
 2334 2f38 A0F4FFFF 		st	%s19,-2912(,%fp)	# spill 
 2334      89001311 
 2335 2f40 98EAFFFF 		ld	%s0,-5480(,%fp)	# restore 
 2335      89000001 
 2336 2f48 00000000 		or	%s40,0,%s32
 2336      A0002845 
 2337 2f50 80EAFFFF 		ld	%s63,-5504(,%fp)	# restore 
 2337      89003F01 
 2338 2f58 00000000 		or	%s57,0,%s30
 2338      9E003945 
 2339 2f60 B8F5FFFF 		ld	%s61,-2632(,%fp)	# restore 
 2339      89003D01 
 2340              	# line 616
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kh_end >= KH) kh_end = KH;
 2341              		.loc	1 616 0
 2342 2f68 00000000 		adds.l	%s62,%s63,%s0
 2342      80BF3E59 
 2343 2f70 00000000 		or	%s2,0,%s29
 2343      9D000245 
 2344              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2345              		.loc	1 600 0
 2346 2f78 00000000 		subs.l	%s37,0,%s62
 2346      BE00255B 
 2347              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 2348              		.loc	1 598 0
 2349 2f80 00000000 		subs.l	%s60,0,%s0
 2349      80003C5B 
 2350 2f88 88F5FFFF 		ld	%s56,-2680(,%fp)	# restore 
 2350      89003801 
 2351              	# line 614
 614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           kh_end = 0;
 2352              		.loc	1 614 0
 2353 2f90 00000000 		adds.l	%s59,-1,%s56
 2353      B87F3B59 
 2354              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2355              		.loc	1 600 0
 2356 2f98 00000000 		adds.l	%s3,%s0,%s59
 2356      BB800359 
 2357 2fa0 00000000 		adds.l	%s1,%s62,%s59
 2357      BBBE0159 
 2358 2fa8 88EAFFFF 		ld	%s62,-5496(,%fp)	# restore 
 2358      89003E01 
 2359              	# line 691
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = 0.f;
 2360              		.loc	1 691 0
 2361 2fb0 00000000 		muls.l	%s59,%s63,%s62
 2361      BEBF3B6E 
 2362 2fb8 00000000 		cvt.d.l	%s63,%s59
 2362      00BB3F5F 
 2363 2fc0 00000000 		cvt.s.d	%s58,%s63
 2363      00BF3A1F 
 2364 2fc8 00000000 		muls.l	%s63,%s56,%s62
 2364      BEB83F6E 
 2365 2fd0 00000000 		cvt.d.l	%s55,%s63
 2365      00BF375F 
 2366 2fd8 00000000 		cvt.s.d	%s63,%s55
 2366      00B73F1F 
 2367              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2368              		.loc	1 600 0
 2369 2fe0 00000000 		muls.l	%s0,%s0,%s62
 2369      BE80006E 
 2370 2fe8 A0EAFFFF 		ld	%s55,-5472(,%fp)	# restore 
 2370      89003701 
 2371 2ff0 E0F4FFFF 		st	%s63,-2848(,%fp)	# spill 
 2371      89003F11 
 2372              	# line 621
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (kw_end >= KW) kw_end = KW;
 2373              		.loc	1 621 0
 2374 2ff8 00000000 		adds.l	%s63,%s62,%s55
 2374      B7BE3F59 
 2375              	# line 601
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ---- 1 omp thread ----
 2376              		.loc	1 601 0
 2377 3000 00000000 		subs.l	%s54,0,%s63
 2377      BF00365B 
 2378 3008 00000000 		subs.l	%s52,0,%s55
 2378      B700345B 
 2379              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2380              		.loc	1 600 0
 2381 3010 00000000 		adds.l	%s0,%s55,%s0
 2381      80B70059 
 2382 3018 00000000 		subs.l	%s33,0,%s0
 2382      8000215B 
 2383 3020 90F5FFFF 		ld	%s46,-2672(,%fp)	# restore 
 2383      89002E01 
 2384              	# line 620
 620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 2385              		.loc	1 620 0
 2386 3028 00000000 		adds.l	%s0,-1,%s46
 2386      AE7F0059 
 2387              	# line 601
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ---- 1 omp thread ----
 2388              		.loc	1 601 0
 2389 3030 00000000 		adds.l	%s51,%s55,%s0
 2389      80B73359 
 2390 3038 00000000 		adds.l	%s0,%s63,%s0
 2390      80BF0059 
 2391              	# line 691
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //src[ic*khh*kww + kh*kww+kw] = 0.f;
 2392              		.loc	1 691 0
 2393 3040 00000000 		cvt.d.l	%s63,%s46
 2393      00AE3F5F 
 2394 3048 00000000 		cvt.s.d	%s55,%s63
 2394      00BF371F 
 2395              	# line 639
 639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //OMP(simd)//;
 2396              		.loc	1 639 0
 2397 3050 00000000 		adds.w.sx	%s36,0,%s53
 2397      B500244A 
 2398              	# line 641
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const int kh = khkw / p->kw;
 2399              		.loc	1 641 0
 2400 3058 00000000 		subs.w.sx	%s63,0,%s36
 2400      A4003F5A 
 2401 3060 E8F4FFFF 		st	%s55,-2840(,%fp)	# spill 
 2401      89003711 
 2402 3068 D0F4FFFF 		st	%s63,-2864(,%fp)	# spill 
 2402      89003F11 
 2403 3070 00000000 		or	%s63,0,%s24
 2403      98003F45 
 2404 3078 00000000 		lea	%s24,__eh_curr_region@LO
 2404      00001806 
 2405 3080 00000000 		and	%s24,%s24,(32)0
 2405      60981844 
 2406 3088 00000000 		lea.sl	%s24,__eh_curr_region@HI(,%s24)
 2406      98009806 
 2407              	# line 685
 685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const int kww = KW;
 2408              		.loc	1 685 0
 2409 3090 00000000 		adds.w.sx	%s55,0,%s29
 2409      9D00374A 
 2410 3098 00000000 		or	%s53,0,%s32
 2410      A0003545 
 2411 30a0 00000000 		or	%s32,0,%s55
 2411      B7002045 
 2412              	# line 687
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw=0; kw<kww; ++kw){
 2413              		.loc	1 687 0
 2414 30a8 00000000 		subs.w.sx	%s27,0,%s55
 2414      B7001B5A 
 2415              	# line 686
 686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (int kh=0; kh<khh; ++kh){
 2416              		.loc	1 686 0
 2417 30b0 00000000 		adds.w.sx	%s18,0,%s30
 2417      9E00124A 
 2418 30b8 00000000 		or	%s50,0,%s18
 2418      92003245 
 2419              	# line 688
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   // using integer calc no longer results in vgather !
 2420              		.loc	1 688 0
 2421 30c0 00000000 		subs.w.sx	%s49,0,%s18
 2421      9200315A 
 2422 30c8 00000000 		or	%s48,0,%s25
 2422      99003045 
 2423 30d0 38F3FFFF 		st	%s49,-3272(,%fp)	# spill 
 2423      89003111 
 2424              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (int khkw = 0; khkw < khkw_end; ++khkw) {
 2425              		.loc	1 683 0
 2426 30d8 00000000 		muls.l	%s49,4,%s48
 2426      B004316E 
 2427 30e0 00000000 		or	%s25,0,%s55
 2427      B7001945 
 2428              	# line 687
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (int kw=0; kw<kww; ++kw){
 2429              		.loc	1 687 0
 2430 30e8 00000000 		muls.l	%s55,4,%s50
 2430      B204376E 
 2431 30f0 C8F5FFFF 		st	%s49,-2616(,%fp)	# spill 
 2431      89003111 
 2432 30f8 40F3FFFF 		st	%s55,-3264(,%fp)	# spill 
 2432      89003711 
 2433              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (int khkw = 0; khkw < khkw_end; ++khkw) {
 2434              		.loc	1 683 0
 2435 3100 00000000 		adds.l	%s55,%fp,(60)1
 2435      3C893759 
 2436 3108 00000000 		or	%s50,0,%s53
 2436      B5003245 
 2437              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 2438              		.loc	1 598 0
 2439 3110 00000000 		muls.l	%s42,4,%s53
 2439      B5042A6E 
 2440              	# line 608
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               tmp[oc] = pbia[bia_off0 + oc];
 2441              		.loc	1 608 0
 2442 3118 00000000 		subs.l	%s39,0,%s53
 2442      B500275B 
 2443              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 2444              		.loc	1 724 0
 2445 3120 00000000 		and	%s49,%s53,(62)0
 2445      7EB53144 
 2446 3128 00000000 		adds.w.sx	%s48,0,%s49
 2446      B100304A 
 2447 3130 00000000 		or	%s49,0,%s48
 2447      B0003145 
 2448 3138 D8F4FFFF 		st	%s49,-2856(,%fp)	# spill 
 2448      89003111 
 2449 3140 00000000 		subs.l	%s48,0,%s49
 2449      B100305B 
 2450 3148 A8EAFFFF 		ld	%s49,-5464(,%fp)	# restore 
 2450      89003101 
 2451 3150 C0F4FFFF 		st	%s48,-2880(,%fp)	# spill 
 2451      89003011 
 2452 3158 00000000 		or	%s48,0,%s49
 2452      B1003045 
 2453              	# line 753
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
 2454              		.loc	1 753 0
 2455 3160 00000000 		muls.l	%s49,4,%s48
 2455      B004316E 
 2456              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 2457              		.loc	1 598 0
 2458 3168 00000000 		subs.l	%s48,0,%s22
 2458      9600305B 
 2459 3170 68F5FFFF 		st	%s49,-2712(,%fp)	# spill 
 2459      89003111 
 2460 3178 00000000 		or	%s49,0,%s59
 2460      BB003145 
 2461 3180 00000000 		or	%s59,0,%s48
 2461      B0003B45 
 2462 3188 00000000 		or	%s34,0,(0)1
 2462      00002245 
 2463 3190 00000000 		or	%s7,0,(0)1
 2463      00000745 
 2464 3198 00000000 		or	%s5,0,(0)1
 2464      00000545 
 2465 31a0 00000000 		or	%s63,0,%s63
 2465      BF003F45 
 2466 31a8 00000000 		muls.l	%s48,%s53,%s31
 2466      9FB5306E 
 2467 31b0 00000000 		muls.l	%s47,%s29,%s48
 2467      B09D2F6E 
 2468 31b8 00000000 		or	%s29,0,%s58
 2468      BA001D45 
 2469 31c0 00000000 		or	%s58,0,%s51
 2469      B3003A45 
 2470 31c8 00000000 		muls.l	%s51,%s30,%s47
 2470      AF9E336E 
 2471 31d0 00000000 		or	%s30,0,%s60
 2471      BC001E45 
 2472 31d8 00000000 		muls.l	%s38,4,%s51
 2472      B304266E 
 2473              	# line 672
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             {
 2474              		.loc	1 672 0
 2475 31e0 00000000 		subs.l	%s35,0,%s31
 2475      9F00235B 
 2476              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 2477              		.loc	1 724 0
 2478 31e8 00000000 		muls.l	%s60,4,%s19
 2478      93043C6E 
 2479 31f0 B0F4FFFF 		st	%s60,-2896(,%fp)	# spill 
 2479      89003C11 
 2480 31f8 00000000 		muls.l	%s51,4,%s60
 2480      BC04336E 
 2481              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG_KH_KW];
 2482              		.loc	1 727 0
 2483 3200 00000000 		subs.l	%s48,0,%s19
 2483      9300305B 
 2484 3208 00000000 		or	%s60,0,%s23
 2484      97003C45 
 2485 3210 80F4FFFF 		st	%s51,-2944(,%fp)	# spill 
 2485      89003311 
 2486 3218 A8F4FFFF 		st	%s48,-2904(,%fp)	# spill 
 2486      89003011 
 2487 3220 B0F4FFFF 		ld	%s51,-2896(,%fp)	# restore 
 2487      89003301 
 2488              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 2489              		.loc	1 724 0
 2490 3228 00000000 		adds.l	%s4,%s23,%s51
 2490      B3970459 
 2491              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 2492              		.loc	1 598 0
 2493 3230 00000000 		muls.l	%s6,%s53,%s20
 2493      94B5066E 
 2494              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2495              		.loc	1 600 0
 2496 3238 00000000 		subs.l	%s44,0,%s20
 2496      94002C5B 
 2497              	# line 599
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oh = 0; oh < OH; ++oh) {
 2498              		.loc	1 599 0
 2499 3240 00000000 		subs.l	%s53,0,%s21
 2499      9500355B 
 2500 3248 78EAFFFF 		ld	%s51,-5512(,%fp)	# restore 
 2500      89003301 
 2501 3250 00000000 		muls.l	%s45,%s49,%s51
 2501      B3B12D6E 
 2502 3258 90EAFFFF 		ld	%s51,-5488(,%fp)	# restore 
 2502      89003301 
 2503 3260 00000000 		muls.l	%s41,%s20,%s51
 2503      B394296E 
 2504 3268 70F4FFFF 		ld	%s22,-2960(,%fp)	# restore 
 2504      89001601 
 2505              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2506              		.loc	1 600 0
 2507 3270 00000000 		muls.l	%s43,4,%s22
 2507      96042B6E 
 2508              	# line 601
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ---- 1 omp thread ----
 2509              		.loc	1 601 0
 2510 3278 00000000 		subs.l	%s51,0,%s22
 2510      9600335B 
 2511 3280 78F4FFFF 		ld	%s48,-2952(,%fp)	# restore 
 2511      89003001 
 2512 3288 38F4FFFF 		st	%s51,-3016(,%fp)	# spill 
 2512      89003311 
 2513              	# line 600
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ow = 0; ow < OW; ++ow) {
 2514              		.loc	1 600 0
 2515 3290 00000000 		subs.l	%s51,0,%s48
 2515      B000335B 
 2516 3298 00000000 		muls.l	%s47,%s62,%s48
 2516      B0BE2F6E 
 2517 32a0 80F5FFFF 		ld	%s62,-2688(,%fp)	# restore 
 2517      89003E01 
 2518 32a8 20F4FFFF 		st	%s0,-3040(,%fp)	# spill 
 2518      89000011 
 2519              	# line 601
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // ---- 1 omp thread ----
 2520              		.loc	1 601 0
 2521 32b0 00000000 		subs.l	%s0,0,%s62
 2521      BE00005B 
 2522 32b8 C8F3FFFF 		st	%s1,-3128(,%fp)	# spill 
 2522      89000111 
 2523              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 2524              		.loc	1 724 0
 2525 32c0 00000000 		muls.l	%s1,8,%s19
 2525      9308016E 
 2526 32c8 28F5FFFF 		st	%s0,-2776(,%fp)	# spill 
 2526      89000011 
 2527 32d0 00000000 		adds.l	%s0,%s23,%s1
 2527      81970059 
 2528 32d8 00000000 		muls.l	%s1,12,%s19
 2528      930C016E 
 2529 32e0 50F3FFFF 		st	%s0,-3248(,%fp)	# spill 
 2529      89000011 
 2530 32e8 00000000 		adds.l	%s0,%s23,%s1
 2530      81970059 
 2531 32f0 00000000 		or	%s19,0,%s49
 2531      B1001345 
 2532 32f8 48F3FFFF 		st	%s0,-3256(,%fp)	# spill 
 2532      89000011 
 2533 3300 00000000 		or	%s49,0,%s62
 2533      BE003145 
 2534 3308 00000000 		or	%s23,0,%s55
 2534      B7001745 
 2535 3310 00000000 		or	%s55,0,%s53
 2535      B5003745 
 2536 3318 00000000 		or	%s53,0,%s50
 2536      B2003545 
 2537 3320 00000000 		or	%s50,0,%s51
 2537      B3003245 
 2538 3328 00000000 		or	%s51,0,%s48
 2538      B0003345 
 2539 3330 C8F3FFFF 		ld	%s1,-3128(,%fp)	# restore 
 2539      89000101 
 2540 3338 00000000 		or	%s62,0,%s54
 2540      B6003E45 
 2541 3340 20F4FFFF 		ld	%s54,-3040(,%fp)	# restore 
 2541      89003601 
 2542 3348 00000000 		or	%s48,0,%s47
 2542      AF003045 
 2543 3350 28F5FFFF 		ld	%s47,-2776(,%fp)	# restore 
 2543      89002F01 
 2544 3358 C8FBFFFF 		br.l	.L2.39
 2544      00000F18 
 2545              	.L2.112:
 2546 3360 D0FBFFFF 		brlt.l	0,%s22,.L2.111
 2546      96000218 
 2547 3368 00E0FFFF 		br.l	.L2.37
 2547      00000F18 
 2548              	.L2.113:
 2549              	# line 588
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** //RETAIN(tmp)
 2550              		.loc	1 588 0
 2551 3370 00000000 		adds.l	%s62,-1,%s62
 2551      BE7F3E59 
 2552 3378 00000004 		lvs	%s62,%v4(%s62)
 2552      00BE3E9E 
 2553 3380 00000000 		stu	%s62,0(%s33,%s61)	# *(seq)
 2553      BDA13E12 
 2554 3388 D8FFFFFF 		br.l	.L2.112
 2554      00000F18 
 2555              	.L2.14:
 2556 3390 00000000 		lvl	%s62
 2556      00BE00BF 
 2557 3398 00070006 		vadds.w.sx	%v6,%s63,%v7
 2557      00BF20CA 
 2558 33a0 00000605 		vcvt.s.w	%v5,%v6
 2558      000080F8 
 2559 33a8 00050004 		vor	%v4,(0)1,%v5
 2559      000020C5 
 2560 33b0 00000000 		adds.w.sx	%s63,%s63,%s60
 2560      BCBF3F4A 
 2561 33b8 00000000 		subs.l	%s59,%s59,%s62
 2561      BEBB3B5B 
 2562 33c0 B0FFFFFF 		brge.l	0,%s59,.L2.113
 2562      BB000518 
 2563 33c8 80DDFFFF 		br.l	.L2.13
 2563      00000F18 
 2564              	.L2.114:
 2565 33d0 00000000 		or	%s61,0,%s48
 2565      B0003D45 
 2566 33d8 00000000 		subs.l	%s58,0,%s53
 2566      B5003A5B 
 2567 33e0 00000000 		subs.l	%s58,0,%s58
 2567      BA003A5B 
 2568 33e8 00000000 		smvl	%s57
 2568      0000392E 
 2569 33f0 80000000 		mins.l	%s62,%s58,%s57
 2569      B9BA3E68 
 2570 33f8 00000000 		or	%s59,0,%s58
 2570      BA003B45 
 2571 3400 00000000 		or	%s63,0,(0)1
 2571      00003F45 
 2572 3408 00000000 		adds.w.sx	%s60,0,%s62
 2572      BE003C4A 
 2573 3410 00000000 		lvl	%s60
 2573      00BC00BF 
 2574 3418 00000003 		vseq	%v3
 2574      00000099 
 2575 3420 00030007 		vor	%v7,(0)1,%v3
 2575      000020C5 
 2576 3428 68FFFFFF 		br.l	.L2.14
 2576      00000F18 
 2577              	.L2.115:
 2578              	# line 563
 563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 2579              		.loc	1 563 0
 2580 3430 98FFFFFF 		lea	%s48,-104
 2580      00003006 
 2581 3438 00000000 		adds.l	%s48,%fp,%s48
 2581      B0893059 
 2582 3440 00000000 		lea	%s47,.LP._ZN4conv12sxconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.khkw_muls.__initializer.1@LO
 2582      00002F06 
 2583 3448 00000000 		and	%s47,%s47,(32)0
 2583      60AF2F44 
 2584 3450 00000000 		lea.sl	%s47,.LP._ZN4conv12sxconv_4_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.khkw_muls.__initializer.1@
 2584      AF00AF06 
 2585 3458 00000000 		ld	%s45,0(,%s47)	# conflict.I64
 2585      AF002D01 
 2586 3460 00000000 		st	%s45,0(,%s48)	# conflict.I64
 2586      B0002D11 
 2587 3468 00000000 		adds.l	%s45,8,%s47
 2587      AF082D59 
 2588 3470 00000000 		ld	%s45,0(,%s45)	# conflict.I64
 2588      AD002D01 
 2589 3478 00000000 		adds.l	%s44,8,%s48
 2589      B0082C59 
 2590 3480 00000000 		st	%s45,0(,%s44)	# conflict.I64
 2590      AC002D11 
 2591 3488 00000000 		adds.l	%s45,16,%s47
 2591      AF102D59 
 2592 3490 00000000 		ld	%s45,0(,%s45)	# conflict.I64
 2592      AD002D01 
 2593 3498 00000000 		adds.l	%s44,16,%s48
 2593      B0102C59 
 2594 34a0 00000000 		st	%s45,0(,%s44)	# conflict.I64
 2594      AC002D11 
 2595 34a8 00000000 		adds.l	%s47,24,%s47
 2595      AF182F59 
 2596 34b0 00000000 		ld	%s47,0(,%s47)	# conflict.I64
 2596      AF002F01 
 2597 34b8 00000000 		adds.l	%s48,24,%s48
 2597      B0183059 
 2598 34c0 00000000 		st	%s47,0(,%s48)	# conflict.I64
 2598      B0002F11 
 2599 34c8 A0FFFFFF 		lea	%s48,-96
 2599      00003006 
 2600 34d0 00000000 		st	%s29,0(%s48,%fp)	# khkw_muls
 2600      89B01D11 
 2601 34d8 00000100 		lea	%s48,65536
 2601      00003006 
 2602 34e0 00000000 		muls.l	%s48,%s30,%s48
 2602      B09E306E 
 2603 34e8 B0FFFFFF 		lea	%s47,-80
 2603      00002F06 
 2604 34f0 00000000 		st	%s48,0(%s47,%fp)	# khkw_muls
 2604      89AF3011 
 2605              	# line 571
 571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //ssize_t khash_prv2 = (KH+KW)*4; // impossibly high hash
 2606              		.loc	1 571 0
 2607 34f8 00000000 		or	%s28,-1,(0)1
 2607      007F1C45 
 2608              	# line 574
 574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 2609              		.loc	1 574 0
 2610 3500 50FFFFFF 		lea	%s48,-176
 2610      00003006 
 2611 3508 00000000 		adds.l	%s27,%fp,%s48
 2611      B0891B59 
 2612 3510 00000000 		muls.l	%s33,4,%s53
 2612      B504216E 
 2613 3518 00000000 		or	%s0,0,%s33
 2613      A1000045 
 2614 3520 00000000 		lea	%s12,__grow_stack@LO
 2614      00000C06 
 2615 3528 00000000 		and	%s12,%s12,(32)0
 2615      608C0C44 
 2616 3530 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2616      8C008C06 
 2617 3538 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2617      8C000A08 
 2618 3540 D0000000 		lea	%s48,208
 2618      00003006 
 2619 3548 00000000 		adds.l	%s48,%sp,%s48
 2619      B08B3059 
 2620 3550 00000000 		st	%s48,0(,%s27)
 2620      9B003011 
 2621 3558 50FFFFFF 		ld	%s48,-176(,%fp)	# kok
 2621      89003001 
 2622 3560 60FFFFFF 		lea	%s47,-160
 2622      00002F06 
 2623 3568 00000000 		st	%s48,0(%s47,%fp)
 2623      89AF3011 
 2624 3570 00000000 		lea	%s27,__eh_curr_region@LO
 2624      00001B06 
 2625 3578 00000000 		and	%s27,%s27,(32)0
 2625      609B1B44 
 2626 3580 00000000 		lea.sl	%s27,__eh_curr_region@HI(,%s27)
 2626      9B009B06 
 2627 3588 00000000 		or	%s48,1,(0)1
 2627      00013045 
 2628 3590 00000000 		st2b	%s48,0(,%s27)
 2628      9B003014 
 2629              	# line 580
 580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 2630              		.loc	1 580 0
 2631 3598 00000000 		muls.l	%s48,%s29,%s31
 2631      9F9D306E 
 2632 35a0 00000000 		muls.l	%s48,%s30,%s48
 2632      B09E306E 
 2633 35a8 D0FDFFFF 		lea	%s47,-560
 2633      00002F06 
 2634 35b0 00000000 		adds.l	%s34,%fp,%s47
 2634      AF892259 
 2635 35b8 00000000 		muls.l	%s0,4,%s48
 2635      B004006E 
 2636 35c0 00000000 		lea	%s12,__grow_stack@LO
 2636      00000C06 
 2637 35c8 00000000 		and	%s12,%s12,(32)0
 2637      608C0C44 
 2638 35d0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2638      8C008C06 
 2639 35d8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2639      8C000A08 
 2640 35e0 D0000000 		lea	%s48,208
 2640      00003006 
 2641 35e8 00000000 		adds.l	%s48,%sp,%s48
 2641      B08B3059 
 2642 35f0 00000000 		st	%s48,0(,%s34)
 2642      A2003011 
 2643 35f8 D0FDFFFF 		ld	%s48,-560(,%fp)	# src
 2643      89003001 
 2644 3600 68FFFFFF 		lea	%s47,-152
 2644      00002F06 
 2645 3608 00000000 		st	%s48,0(%s47,%fp)
 2645      89AF3011 
 2646 3610 00000000 		or	%s48,2,(0)1
 2646      00023045 
 2647 3618 00000000 		st2b	%s48,0(,%s27)
 2647      9B003014 
 2648              	# line 586
 586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float seq[KH_KW] alignas(128);
 2649              		.loc	1 586 0
 2650 3620 90FFFFFF 		lea	%s48,-112
 2650      00003006 
 2651 3628 00000000 		adds.l	%s34,%fp,%s48
 2651      B0892259 
 2652 3630 00000000 		muls.l	%s0,4,%s32
 2652      A004006E 
 2653 3638 00000000 		lea	%s12,__grow_stack@LO
 2653      00000C06 
 2654 3640 00000000 		and	%s12,%s12,(32)0
 2654      608C0C44 
 2655 3648 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2655      8C008C06 
 2656 3650 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2656      8C000A08 
 2657 3658 D0000000 		lea	%s48,208
 2657      00003006 
 2658 3660 00000000 		adds.l	%s48,%sp,%s48
 2658      B08B3059 
 2659 3668 00000000 		or	%s0,0,%s33
 2659      A1000045 
 2660 3670 00000000 		st	%s48,0(,%s34)
 2660      A2003011 
 2661 3678 90FFFFFF 		ld	%s48,-112(,%fp)	# tmp
 2661      89003001 
 2662 3680 70FFFFFF 		lea	%s47,-144
 2662      00002F06 
 2663 3688 00000000 		st	%s48,0(%s47,%fp)
 2663      89AF3011 
 2664 3690 00000000 		or	%s48,3,(0)1
 2664      00033045 
 2665 3698 00000000 		st2b	%s48,0(,%s27)
 2665      9B003014 
 2666              	# line 587
 587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for(int i=0; i<KH_KW; ++i) seq[KH_KW] = (float)i;
 2667              		.loc	1 587 0
 2668 36a0 00000000 		adds.l	%s34,%fp,(59)1
 2668      3B892259 
 2669 36a8 00000000 		lea	%s12,__grow_stack@LO
 2669      00000C06 
 2670 36b0 00000000 		and	%s12,%s12,(32)0
 2670      608C0C44 
 2671 36b8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2671      8C008C06 
 2672 36c0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2672      8C000A08 
 2673 36c8 D0000000 		lea	%s48,208
 2673      00003006 
 2674 36d0 00000000 		adds.l	%s48,%sp,%s48
 2674      B08B3059 
 2675 36d8 00000000 		st	%s48,0(,%s34)
 2675      A2003011 
 2676 36e0 E0FFFFFF 		ld	%s48,-32(,%fp)	# seq
 2676      89003001 
 2677 36e8 78FFFFFF 		lea	%s47,-136
 2677      00002F06 
 2678 36f0 00000000 		st	%s48,0(%s47,%fp)
 2678      89AF3011 
 2679 36f8 00000000 		or	%s47,4,(0)1
 2679      00042F45 
 2680 3700 00000000 		st2b	%s47,0(,%s27)
 2680      9B002F14 
 2681 3708 C8FCFFFF 		brlt.l	0,%s53,.L2.114
 2681      B5000218 
 2682 3710 50FCFFFF 		br.l	.L2.112
 2682      00000F18 
 2683              	.L2.116:
 2684 3718 18FDFFFF 		br.l	.L2.115
 2684      00000F18 
 2685              	.L2.12:
 2686              	# line 550
 550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 2687              		.loc	1 550 0
 2688 3720 00000000 		or	%s63,0,(0)1
 2688      00003F45 
 2689 3728 00000000 		lvl	%s62
 2689      00BE00BF 
 2690 3730 00000008 		vbrdu	%v8,%s63
 2690      00BF808C 
 2691 3738 00000000 		or	%s63,0,%s60
 2691      BC003F45 
 2692 3740 00000008 		vstu.nc	%v8,4,%s63
 2692      BF040092 
 2693              	# line 549
 549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       khkw_zeros[khkw] = 0.f;
 2694              		.loc	1 549 0
 2695 3748 00000000 		adds.l	%s60,%s60,%s59
 2695      BBBC3C59 
 2696 3750 00000000 		subs.w.sx	%s55,%s55,%s62
 2696      BEB7375A 
 2697 3758 C0FFFFFF 		brge.w	0,%s55,.L2.116
 2697      B7008518 
 2698 3760 D8D9FFFF 		br.l	.L2.11
 2698      00000F18 
 2699              	.L2.117:
 2700 3768 00000000 		subs.w.sx	%s63,0,%s25
 2700      99003F5A 
 2701 3770 00000000 		subs.w.sx	%s63,0,%s63
 2701      BF003F5A 
 2702 3778 00000000 		smvl	%s61
 2702      00003D2E 
 2703 3780 80000000 		mins.w.sx	%s62,%s63,%s61
 2703      BDBF3E78 
 2704 3788 00000000 		or	%s55,0,%s63
 2704      BF003745 
 2705 3790 00000000 		or	%s60,0,%s48
 2705      B0003C45 
 2706 3798 00000000 		or	%s63,0,%s62
 2706      BE003F45 
 2707 37a0 00000000 		muls.l	%s59,4,%s63
 2707      BF043B6E 
 2708 37a8 78FFFFFF 		br.l	.L2.12
 2708      00000F18 
 2709              	.L2.118:
 2710              	# line 543
 543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pwei = (float*)wei_m;
 2711              		.loc	1 543 0
 2712 37b0 A8010000 		ld	%s56,424(,%s1)	# *(src_m).data_
 2712      81003801 
 2713              	# line 544
 544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pbia = (float*)bia_m;
 2714              		.loc	1 544 0
 2715 37b8 A8010000 		ld	%s23,424(,%s2)	# *(wei_m).data_
 2715      82001701 
 2716              	# line 545
 545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdst = (float*)dst_m;
 2717              		.loc	1 545 0
 2718 37c0 A8010000 		ld	%s24,424(,%s3)	# *(bia_m).data_
 2718      83001801 
 2719              	# line 546
 546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int khkw_end = (int)KH_KW;
 2720              		.loc	1 546 0
 2721 37c8 A8010000 		ld	%s26,424(,%s4)	# *(dst_m).data_
 2721      84001A01 
 2722              	# line 547
 547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float khkw_zeros[khkw_end];
 2723              		.loc	1 547 0
 2724 37d0 00000000 		adds.w.sx	%s25,0,%s53
 2724      B500194A 
 2725 37d8 00000000 		or	%s48,0,%s25
 2725      99003045 
 2726              	# line 548
 548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (int khkw=0; khkw < khkw_end; ++khkw){
 2727              		.loc	1 548 0
 2728 37e0 88FFFFFF 		lea	%s47,-120
 2728      00002F06 
 2729 37e8 00000000 		adds.l	%s27,%fp,%s47
 2729      AF891B59 
 2730 37f0 00000000 		muls.l	%s0,4,%s48
 2730      B004006E 
 2731 37f8 00000000 		lea	%s12,__grow_stack@LO
 2731      00000C06 
 2732 3800 00000000 		and	%s12,%s12,(32)0
 2732      608C0C44 
 2733 3808 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2733      8C008C06 
 2734 3810 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2734      8C000A08 
 2735 3818 D0000000 		lea	%s48,208
 2735      00003006 
 2736 3820 00000000 		adds.l	%s48,%sp,%s48
 2736      B08B3059 
 2737 3828 00000000 		lea	%s47,0
 2737      00002F06 
 2738 3830 00000000 		st	%s48,0(,%s27)
 2738      9B003011 
 2739 3838 88FFFFFF 		ld	%s48,-120(,%fp)	# khkw_zeros
 2739      89003001 
 2740 3840 58FFFFFF 		st	%s48,-168(,%fp)
 2740      89003011 
 2741 3848 00000000 		lea	%s45,__eh_curr_region@LO
 2741      00002D06 
 2742 3850 00000000 		and	%s45,%s45,(32)0
 2742      60AD2D44 
 2743 3858 00000000 		lea.sl	%s45,__eh_curr_region@HI(,%s45)
 2743      AD00AD06 
 2744 3860 00000000 		st2b	%s47,0(,%s45)
 2744      AD002F14 
 2745 3868 00FFFFFF 		brlt.w	0,%s25,.L2.117
 2745      99008218 
 2746 3870 C0FBFFFF 		br.l	.L2.115
 2746      00000F18 
 2747              	.L2.119:
 2748 3878 70EAFFFF 		st	%s1,-5520(,%fp)	# spill 
 2748      89000111 
 2749 3880 68EAFFFF 		st	%s2,-5528(,%fp)	# spill 
 2749      89000211 
 2750 3888 60EAFFFF 		st	%s3,-5536(,%fp)	# spill 
 2750      89000311 
 2751 3890 58EAFFFF 		st	%s4,-5544(,%fp)	# spill 
 2751      89000411 
 2752 3898 50EAFFFF 		st	%s53,-5552(,%fp)	# spill 
 2752      89003511 
 2753              	# line 37
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** }
 2754              		.loc	1 37 0
 2755 38a0 00000000 		lea	%s0,.LP.__string.6@LO
 2755      00000006 
 2756 38a8 00000000 		and	%s0,%s0,(32)0
 2756      60800044 
 2757 38b0 00000000 		lea.sl	%s0,.LP.__string.6@HI(,%s0)
 2757      80008006 
 2758 38b8 00000000 		or	%s2,0,%s47
 2758      AF000245 
 2759 38c0 B0000000 		st	%s0,176(,%sp)
 2759      8B000011 
 2760 38c8 B8000000 		st	%s48,184(,%sp)
 2760      8B003011 
 2761 38d0 C0000000 		st	%s47,192(,%sp)
 2761      8B002F11 
 2762 38d8 1E020000 		lea	%s3,542
 2762      00000306 
 2763 38e0 00000000 		or	%s1,0,%s48
 2763      B0000145 
 2764 38e8 C8000000 		st	%s3,200(,%sp)
 2764      8B000311 
 2765 38f0 00000000 		lea	%s12,printf@LO
 2765      00000C06 
 2766 38f8 00000000 		and	%s12,%s12,(32)0
 2766      608C0C44 
 2767 3900 00000000 		lea.sl	%s12,printf@HI(,%s12)
 2767      8C008C06 
 2768 3908 00000000 		bsic	%lr,(,%s12)	# printf
 2768      8C000A08 
 2769 3910 00000000 		or	%s0,1,(0)1
 2769      00010045 
 2770 3918 00000000 		lea	%s12,exit@LO
 2770      00000C06 
 2771 3920 00000000 		and	%s12,%s12,(32)0
 2771      608C0C44 
 2772 3928 00000000 		lea.sl	%s12,exit@HI(,%s12)
 2772      8C008C06 
 2773 3930 00000000 		bsic	%lr,(,%s12)	# exit
 2773      8C000A08 
 2774 3938 70EAFFFF 		ld	%s1,-5520(,%fp)	# restore 
 2774      89000101 
 2775 3940 68EAFFFF 		ld	%s2,-5528(,%fp)	# restore 
 2775      89000201 
 2776 3948 60EAFFFF 		ld	%s3,-5536(,%fp)	# restore 
 2776      89000301 
 2777 3950 58EAFFFF 		ld	%s4,-5544(,%fp)	# restore 
 2777      89000401 
 2778 3958 50EAFFFF 		ld	%s53,-5552(,%fp)	# restore 
 2778      89003501 
 2779 3960 50FEFFFF 		br.l	.L2.118
 2779      00000F18 
 2780              	.L2.10:
 2781 3968 10FFFFFF 		breq.w	0,%s18,.L2.119
 2781      92008418 
 2782 3970 40FEFFFF 		br.l	.L2.118
 2782      00000F18 
 2783              	.L2.120:
 2784 3978 B8F5FFFF 		st	%s61,-2632(,%fp)	# spill 
 2784      89003D11 
 2785 3980 A8EAFFFF 		st	%s54,-5464(,%fp)	# spill 
 2785      89003611 
 2786 3988 90F5FFFF 		st	%s46,-2672(,%fp)	# spill 
 2786      89002E11 
 2787 3990 88F5FFFF 		st	%s56,-2680(,%fp)	# spill 
 2787      89003811 
 2788 3998 80F5FFFF 		st	%s49,-2688(,%fp)	# spill 
 2788      89003111 
 2789 39a0 78F4FFFF 		st	%s51,-2952(,%fp)	# spill 
 2789      89003311 
 2790 39a8 A0EAFFFF 		st	%s50,-5472(,%fp)	# spill 
 2790      89003211 
 2791 39b0 98EAFFFF 		st	%s52,-5480(,%fp)	# spill 
 2791      89003411 
 2792 39b8 70F4FFFF 		st	%s22,-2960(,%fp)	# spill 
 2792      89001611 
 2793 39c0 90EAFFFF 		st	%s55,-5488(,%fp)	# spill 
 2793      89003711 
 2794 39c8 88EAFFFF 		st	%s59,-5496(,%fp)	# spill 
 2794      89003B11 
 2795 39d0 80EAFFFF 		st	%s60,-5504(,%fp)	# spill 
 2795      89003C11 
 2796 39d8 78EAFFFF 		st	%s62,-5512(,%fp)	# spill 
 2796      89003E11 
 2797 39e0 00000000 		or	%s18,1,(0)1
 2797      00011245 
 2798 39e8 00000000 		or	%s32,0,%s40
 2798      A8002045 
 2799 39f0 00000000 		or	%s30,0,%s57
 2799      B9001E45 
 2800 39f8 00000000 		or	%s29,0,%s58
 2800      BA001D45 
 2801 3a00 00000000 		or	%s22,0,%s63
 2801      BF001645 
 2802 3a08 60FFFFFF 		br.l	.L2.10
 2802      00000F18 
 2803              	.L2.121:
 2804 3a10 68FFFFFF 		brle.l	0,%s49,.L2.120
 2804      B1000618 
 2805 3a18 88D6FFFF 		br.l	.L2.9
 2805      00000F18 
 2806              	.L2.8:
 2807              	# line 542
 542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const psrc = (float*)src_m;
 2808              		.loc	1 542 0
 2809 3a20 00000000 		lea	%s48,.LP.__string.5@LO
 2809      00003006 
 2810 3a28 00000000 		and	%s48,%s48,(32)0
 2810      60B03044 
 2811 3a30 00000000 		lea.sl	%s48,.LP.__string.5@HI(,%s48)
 2811      B000B006 
 2812 3a38 00000000 		lea	%s47,.LP.__12_sx_conv4_cpp_bd510499.0.__unnamed.0@LO
 2812      00002F06 
 2813 3a40 00000000 		and	%s47,%s47,(32)0
 2813      60AF2F44 
 2814 3a48 00000000 		lea.sl	%s47,.LP.__12_sx_conv4_cpp_bd510499.0.__unnamed.0@HI(,%s47)
 2814      AF00AF06 
 2815 3a50 C0FFFFFF 		brle.l	0,%s51,.L2.121
 2815      B3000618 
 2816 3a58 48D6FFFF 		br.l	.L2.9
 2816      00000F18 
 2817              	.L2.6:
 2818 3a60 38000000 		lea	%s47,56
 2818      00002F06 
 2819              	# line 541
 541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( SH >= 0 && SW >= 0 );
 2820              		.loc	1 541 0
 2821 3a68 00000000 		sll	%s48,%s48,%s47
 2821      B0AF3065 
 2822 3a70 38000000 		lea	%s47,56
 2822      00002F06 
 2823 3a78 00000000 		sra.l	%s48,%s48,%s47
 2823      B0AF3077 
 2824 3a80 00000000 		or	%s48,0,%s48
 2824      B0003045 
 2825 3a88 00000000 		lea	%s47,.LP.__string.3@LO
 2825      00002F06 
 2826 3a90 00000000 		and	%s47,%s47,(32)0
 2826      60AF2F44 
 2827 3a98 00000000 		lea.sl	%s47,.LP.__string.3@HI(,%s47)
 2827      AF00AF06 
 2828 3aa0 00000000 		lea	%s45,.LP.__12_sx_conv4_cpp_bd510499.0.__unnamed.0@LO
 2828      00002D06 
 2829 3aa8 00000000 		and	%s45,%s45,(32)0
 2829      60AD2D44 
 2830 3ab0 00000000 		lea.sl	%s45,.LP.__12_sx_conv4_cpp_bd510499.0.__unnamed.0@HI(,%s45)
 2830      AD00AD06 
 2831 3ab8 68FFFFFF 		brne.w	0,%s48,.L2.8
 2831      B0008318 
 2832 3ac0 F0D3FFFF 		br.l	.L2.7
 2832      00000F18 
 2833              	.L2.122:
 2834 3ac8 00000000 		or	%s48,1,(0)1
 2834      00013045 
 2835 3ad0 90FFFFFF 		br.l	.L2.6
 2835      00000F18 
 2836              	.L2.123:
 2837 3ad8 3C000000 		ldl.sx	%s18,60(,%s61)	# *(p).__b_N4conv6desc_tE.dw
 2837      BD001203 
 2838 3ae0 E8FFFFFF 		brle.w	0,%s18,.L2.122
 2838      92008618 
 2839 3ae8 B8D3FFFF 		br.l	.L2.5
 2839      00000F18 
 2840              	.L2.4:
 2841 3af0 38000000 		ldl.sx	%s18,56(,%s61)	# *(p).__b_N4conv6desc_tE.dh
 2841      BD001203 
 2842 3af8 E0FFFFFF 		brle.w	0,%s18,.L2.123
 2842      92008618 
 2843 3b00 A0D3FFFF 		br.l	.L2.5
 2843      00000F18 
 2844              	.L2.2:
 2845 3b08 38000000 		lea	%s47,56
 2845      00002F06 
 2846              	# line 540
 540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 2847              		.loc	1 540 0
 2848 3b10 00000000 		sll	%s48,%s48,%s47
 2848      B0AF3065 
 2849 3b18 38000000 		lea	%s47,56
 2849      00002F06 
 2850 3b20 00000000 		sra.l	%s48,%s48,%s47
 2850      B0AF3077 
 2851 3b28 00000000 		or	%s48,0,%s48
 2851      B0003045 
 2852 3b30 00000000 		lea	%s47,.LP.__string.1@LO
 2852      00002F06 
 2853 3b38 00000000 		and	%s47,%s47,(32)0
 2853      60AF2F44 
 2854 3b40 00000000 		lea.sl	%s47,.LP.__string.1@HI(,%s47)
 2854      AF00AF06 
 2855 3b48 00000000 		lea	%s45,.LP.__12_sx_conv4_cpp_bd510499.0.__unnamed.0@LO
 2855      00002D06 
 2856 3b50 00000000 		and	%s45,%s45,(32)0
 2856      60AD2D44 
 2857 3b58 00000000 		lea.sl	%s45,.LP.__12_sx_conv4_cpp_bd510499.0.__unnamed.0@HI(,%s45)
 2857      AD00AD06 
 2858 3b60 90FFFFFF 		brne.w	0,%s48,.L2.4
 2858      B0008318 
 2859 3b68 48D1FFFF 		br.l	.L2.3
 2859      00000F18 
 2860              	.L2.124:
 2861 3b70 00000000 		or	%s48,1,(0)1
 2861      00013045 
 2862 3b78 00000000 		or	%s61,0,%s0
 2862      80003D45 
 2863 3b80 88FFFFFF 		br.l	.L2.2
 2863      00000F18 
 2864              	.L2.0:
 2865 3b88 E8FFFFFF 		brlt.l	0,%s57,.L2.124
 2865      B9000218 
 2866 3b90 08D1FFFF 		br.l	.L2.1
 2866      00000F18 
 2867              		.cfi_endproc
 2868              		.set	.L.3.2auto_size,	0xffffffffffffd5f0	# 10768 Bytes
 2870              	# ============ End  conv::sxconv_4_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2871              	# ============ Begin  _ZN34_INTERNAL_12_sx_conv4_cpp_bd5104994conv22sxconv_4_bwd_d_genericEPKNS0_5p
 2872 3b98 00000000 		.balign 16
 2872      00000000 
 2873              	# line 767
 767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if defined(__ve) // compiler bug! XXX TODO temporarily disabled
 2874              		.loc	1 767 0
 2876              	_INTERNAL_12_sx_conv4_cpp_bd510499::conv::sxconv_4_bwd_d_generic(_INTERNAL_12_sx_conv4_cpp_bd510499::conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2877              		.cfi_startproc
 2878 3ba0 00000000 		st	%fp,0x0(,%sp)
 2878      8B000911 
 2879              		.cfi_def_cfa_offset	0
 2880              		.cfi_offset	9,0
 2881 3ba8 08000000 		st	%lr,0x8(,%sp)
 2881      8B000A11 
 2882 3bb0 18000000 		st	%got,0x18(,%sp)
 2882      8B000F11 
 2883 3bb8 20000000 		st	%plt,0x20(,%sp)
 2883      8B001011 
 2884 3bc0 00000000 		or	%fp,0,%sp
 2884      8B000945 
 2885              		.cfi_def_cfa_register	9
 2886 3bc8 30FEFFFF 		lea	%s13,.L.4.2auto_size&0xffffffff
 2886      00000D06 
 2887 3bd0 00000000 		and	%s13,%s13,(32)0
 2887      608D0D44 
 2888 3bd8 FFFFFFFF 		lea.sl	%sp,.L.4.2auto_size>>32(%fp,%s13)
 2888      8D898B06 
 2889 3be0 48000000 		brge.l.t	%sp,%sl,.L3.EoP
 2889      888B3518 
 2890 3be8 18000000 		ld	%s61,0x18(,%tp)
 2890      8E003D01 
 2891 3bf0 00000000 		or	%s62,0,%s0
 2891      80003E45 
 2892 3bf8 3B010000 		lea	%s63,0x13b
 2892      00003F06 
 2893 3c00 00000000 		shm.l	%s63,0x0(%s61)
 2893      BD033F31 
 2894 3c08 08000000 		shm.l	%sl,0x8(%s61)
 2894      BD030831 
 2895 3c10 10000000 		shm.l	%sp,0x10(%s61)
 2895      BD030B31 
 2896 3c18 00000000 		monc
 2896      0000003F 
 2897 3c20 00000000 		or	%s0,0,%s62
 2897      BE000045 
 2898              	.L3.EoP:
 2899              	# End of prologue codes
 2900              	# line 769
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // shorten, do same for kw,ow loop. tweaks to kh calc
 2901              		.loc	1 769 0
 2902 3c28 00000000 		lea	%s12,conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 2902      00000C06 
 2903 3c30 00000000 		and	%s12,%s12,(32)0
 2903      608C0C44 
 2904 3c38 00000000 		lea.sl	%s12,conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s12)
 2904      8C008C06 
 2905 3c40 00000000 		bsic	%lr,(,%s12)	# conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2905      8C000A08 
 2906              	# line 1199
1199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 2907              		.loc	1 1199 0
 2908              	# Start of epilogue codes
 2909 3c48 00000000 		or	%sp,0,%fp
 2909      89000B45 
 2910              		.cfi_def_cfa	11,8
 2911 3c50 18000000 		ld	%got,0x18(,%sp)
 2911      8B000F01 
 2912 3c58 20000000 		ld	%plt,0x20(,%sp)
 2912      8B001001 
 2913 3c60 08000000 		ld	%lr,0x8(,%sp)
 2913      8B000A01 
 2914 3c68 00000000 		ld	%fp,0x0(,%sp)
 2914      8B000901 
 2915 3c70 00000000 		b.l	(,%lr)
 2915      8A000F19 
 2916              		.cfi_endproc
 2917              		.set	.L.4.2auto_size,	0xfffffffffffffe30	# 464 Bytes
 2919              	# ============ End  _ZN34_INTERNAL_12_sx_conv4_cpp_bd5104994conv22sxconv_4_bwd_d_genericEPKNS0_5prb
 2920              	# ============ Begin  conv::sxconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2921              		.data
 2922 00c1 00000000 		.balign 16
 2922      00000000 
 2922      00000000 
 2922      000000
 2925              	.LP._ZN4conv14sxconv_4_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0:
 2926 00d0 00000000 		.long	__vla_dealloc_eh
 2926      00000000 
 2927 00d8 0000     		.zero	2
 2928 00da FFFF     		.short	65535
 2929 00dc 04       		.byte	4
 2930 00dd 000000   		.zero	3
 2931 00e0 00000000 		.long	__vla_dealloc_eh
 2931      00000000 
 2932 00e8 0100     		.short	1
 2933 00ea 0000     		.zero	2
 2934 00ec 04       		.byte	4
 2935 00ed 000000   		.zero	3
 2936 00f0 00000000 		.long	__vla_dealloc_eh
 2936      00000000 
 2937 00f8 0200     		.short	2
 2938 00fa 0100     		.short	1
 2939 00fc 04       		.byte	4
 2940 00fd 000000   		.zero	3
 2941 0100 00000000 		.long	__vla_dealloc_eh
 2941      00000000 
 2942 0108 0300     		.short	3
 2943 010a 0200     		.short	2
 2944 010c 04       		.byte	4
 2945 010d 000000   		.zero	3
 2946 0110 00000000 		.long	__vla_dealloc_eh
 2946      00000000 
 2947 0118 0400     		.short	4
 2948 011a 0300     		.short	3
 2949 011c 04       		.byte	4
 2950 011d 000000   		.zero	3
 2951 0120 00000000 		.long	__vla_dealloc_eh
 2951      00000000 
 2952 0128 0500     		.short	5
 2953 012a 0400     		.short	4
 2954 012c 04       		.byte	4
 2955 012d 000000   		.zero	3
 2956 0130 00000000 		.long	__vla_dealloc_eh
 2956      00000000 
 2957 0138 0600     		.short	6
 2958 013a 0500     		.short	5
 2959 013c 04       		.byte	4
 2960 013d 000000   		.zero	3
 2961 0140 00000000 		.long	__vla_dealloc_eh
 2961      00000000 
 2962 0148 0700     		.short	7
 2963 014a 0600     		.short	6
 2964 014c 04       		.byte	4
 2965 014d 000000   		.zero	3
 2966              		.text
 2967 3c78 00000000 		.balign 16
 2967      00000000 
 2968              	# line 1208
1208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
 2969              		.loc	1 1208 0
 2970              		.globl	conv::sxconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2972              	conv::sxconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 2973              		.cfi_startproc
 2974 3c80 00000000 		st	%fp,0x0(,%sp)
 2974      8B000911 
 2975              		.cfi_def_cfa_offset	0
 2976              		.cfi_offset	9,0
 2977 3c88 08000000 		st	%lr,0x8(,%sp)
 2977      8B000A11 
 2978 3c90 18000000 		st	%got,0x18(,%sp)
 2978      8B000F11 
 2979 3c98 20000000 		st	%plt,0x20(,%sp)
 2979      8B001011 
 2980 3ca0 00000000 		or	%fp,0,%sp
 2980      8B000945 
 2981              		.cfi_def_cfa_register	9
 2982 3ca8 30000000 		st	%s18,48(,%fp)
 2982      89001211 
 2983 3cb0 38000000 		st	%s19,56(,%fp)
 2983      89001311 
 2984 3cb8 40000000 		st	%s20,64(,%fp)
 2984      89001411 
 2985 3cc0 48000000 		st	%s21,72(,%fp)
 2985      89001511 
 2986 3cc8 50000000 		st	%s22,80(,%fp)
 2986      89001611 
 2987 3cd0 58000000 		st	%s23,88(,%fp)
 2987      89001711 
 2988 3cd8 60000000 		st	%s24,96(,%fp)
 2988      89001811 
 2989 3ce0 68000000 		st	%s25,104(,%fp)
 2989      89001911 
 2990 3ce8 70000000 		st	%s26,112(,%fp)
 2990      89001A11 
 2991 3cf0 78000000 		st	%s27,120(,%fp)
 2991      89001B11 
 2992 3cf8 80000000 		st	%s28,128(,%fp)
 2992      89001C11 
 2993 3d00 88000000 		st	%s29,136(,%fp)
 2993      89001D11 
 2994 3d08 90000000 		st	%s30,144(,%fp)
 2994      89001E11 
 2995 3d10 98000000 		st	%s31,152(,%fp)
 2995      89001F11 
 2996 3d18 A0000000 		st	%s32,160(,%fp)
 2996      89002011 
 2997 3d20 A8000000 		st	%s33,168(,%fp)
 2997      89002111 
 2998 3d28 30C9FFFF 		lea	%s13,.L.5.2auto_size&0xffffffff
 2998      00000D06 
 2999 3d30 00000000 		and	%s13,%s13,(32)0
 2999      608D0D44 
 3000 3d38 FFFFFFFF 		lea.sl	%sp,.L.5.2auto_size>>32(%fp,%s13)
 3000      8D898B06 
 3001 3d40 48000000 		brge.l.t	%sp,%sl,.L4.EoP
 3001      888B3518 
 3002 3d48 18000000 		ld	%s61,0x18(,%tp)
 3002      8E003D01 
 3003 3d50 00000000 		or	%s62,0,%s0
 3003      80003E45 
 3004 3d58 3B010000 		lea	%s63,0x13b
 3004      00003F06 
 3005 3d60 00000000 		shm.l	%s63,0x0(%s61)
 3005      BD033F31 
 3006 3d68 08000000 		shm.l	%sl,0x8(%s61)
 3006      BD030831 
 3007 3d70 10000000 		shm.l	%sp,0x10(%s61)
 3007      BD030B31 
 3008 3d78 00000000 		monc
 3008      0000003F 
 3009 3d80 00000000 		or	%s0,0,%s62
 3009      BE000045 
 3010              	.L4.EoP:
 3011              	# End of prologue codes
 3012 3d88 00000000 		lea	%s63,__curr_eh_stack_entry@LO
 3012      00003F06 
 3013 3d90 00000000 		and	%s63,%s63,(32)0
 3013      60BF3F44 
 3014 3d98 00000000 		lea.sl	%s63,__curr_eh_stack_entry@HI(,%s63)
 3014      BF00BF06 
 3015 3da0 00000000 		ld	%s62,0(,%s63)
 3015      BF003E01 
 3016 3da8 08FEFFFF 		st	%s62,-504(,%fp)
 3016      89003E11 
 3017 3db0 08FEFFFF 		lea	%s62,-504
 3017      00003E06 
 3018 3db8 00000000 		adds.l	%s62,%fp,%s62
 3018      BE893E59 
 3019 3dc0 00000000 		st	%s62,0(,%s63)
 3019      BF003E11 
 3020 3dc8 00000000 		or	%s63,1,(0)1
 3020      00013F45 
 3021 3dd0 10FEFFFF 		st1b	%s63,-496(,%fp)
 3021      89003F15 
 3022 3dd8 00000000 		lea	%s63,.LP._ZN4conv14sxconv_4_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@LO
 3022      00003F06 
 3023 3de0 00000000 		and	%s63,%s63,(32)0
 3023      60BF3F44 
 3024 3de8 00000000 		lea.sl	%s63,.LP._ZN4conv14sxconv_4_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@HI(,%s63)
 3024      BF00BF06 
 3025 3df0 18FEFFFF 		st	%s63,-488(,%fp)
 3025      89003F11 
 3026 3df8 98FFFFFF 		lea	%s63,-104
 3026      00003F06 
 3027 3e00 00000000 		adds.l	%s63,%fp,%s63
 3027      BF893F59 
 3028 3e08 20FEFFFF 		st	%s63,-480(,%fp)
 3028      89003F11 
 3029 3e10 00000000 		lea	%s63,__eh_curr_region@LO
 3029      00003F06 
 3030 3e18 00000000 		and	%s63,%s63,(32)0
 3030      60BF3F44 
 3031 3e20 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 3031      BF00BF06 
 3032 3e28 00000000 		ld2b.zx	%s62,0(,%s63)
 3032      BF00BE04 
 3033 3e30 30FEFFFF 		st2b	%s62,-464(,%fp)
 3033      89003E14 
 3034 3e38 FFFF0000 		lea	%s62,65535
 3034      00003E06 
 3035 3e40 00000000 		st2b	%s62,0(,%s63)
 3035      BF003E14 
 3036              	# line 1209
1209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const pwei = (float*)wei_m;
 3037              		.loc	1 1209 0
 3038 3e48 A8010000 		ld	%s29,424(,%s1)	# *(diff_src_m).data_
 3038      81001D01 
 3039              	# line 1210
1210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //float const * restrict const pbia = (float*)bia_m;
 3040              		.loc	1 1210 0
 3041 3e50 A8010000 		ld	%s47,424(,%s2)	# *(wei_m).data_
 3041      82002F01 
 3042              	# line 1212
1212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 // a new simplification of loop limits (same speed as above)
 3043              		.loc	1 1212 0
 3044 3e58 A8010000 		ld	%s49,424(,%s3)	# *(diff_dst_m).data_
 3044      83003101 
 3045              	# line 1215
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // FIXME can we call this even less?
 3046              		.loc	1 1215 0
 3047 3e60 38000000 		ldl.sx	%s18,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 3047      80001203 
 3048 3e68 58180000 		brne.w	0,%s18,.L4.0
 3048      92008318 
 3049 3e70 10170000 		br.l	.L4.1
 3049      00000F18 
 3050              	.L4.2:
 3051 3e78 08E4FFFF 		st	%s40,-7160(,%fp)	# spill 
 3051      89002811 
 3052 3e80 10E4FFFF 		st	%s35,-7152(,%fp)	# spill 
 3052      89002311 
 3053 3e88 00E4FFFF 		st	%s31,-7168(,%fp)	# spill 
 3053      89001F11 
 3054 3e90 B0F4FFFF 		st	%s49,-2896(,%fp)	# spill 
 3054      89003111 
 3055 3e98 A0F4FFFF 		st	%s47,-2912(,%fp)	# spill 
 3055      89002F11 
 3056 3ea0 00000000 		or	%s19,0,%s34
 3056      A2001345 
 3057 3ea8 00000000 		or	%s20,0,%s37
 3057      A5001445 
 3058 3eb0 00000000 		or	%s21,0,%s41
 3058      A9001545 
 3059 3eb8 00000000 		or	%s31,0,%s39
 3059      A7001F45 
 3060 3ec0 00000000 		or	%s32,0,%s36
 3060      A4002045 
 3061 3ec8 28100000 		br.l	.L4.3
 3061      00000F18 
 3062              	.L4.4:
 3063              	# line 1264
1264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khe[ih] = ih + PH;
 3064              		.loc	1 1264 0
 3065 3ed0 80000000 		mins.l	%s62,%s50,%s62
 3065      BEB23E68 
 3066 3ed8 C0110000 		br.l	.L4.5
 3066      00000F18 
 3067              	.L4.6:
 3068 3ee0 00000000 		or	%s37,0,%s20
 3068      94002545 
 3069 3ee8 B80D0000 		br.l	.L4.7
 3069      00000F18 
 3070              	.L4.8:
 3071              	# line 1275
1275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwe[iw] = iw + PW;
 3072              		.loc	1 1275 0
 3073 3ef0 80000000 		mins.l	%s62,%s50,%s62
 3073      BEB23E68 
 3074 3ef8 D00D0000 		br.l	.L4.9
 3074      00000F18 
 3075              	.L4.10:
 3076              	# line 1314
1314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 3077              		.loc	1 1314 0
 3078 3f00 80000000 		mins.l	%s60,%s53,%s60
 3078      BCB53C68 
 3079 3f08 B8050000 		br.l	.L4.11
 3079      00000F18 
 3080              	.L4.12:
 3081 3f10 00000000 		or	%s56,0,%s18
 3081      92003845 
 3082 3f18 B8F5FFFF 		ld	%s62,-2632(,%fp)	# restore 
 3082      89003E01 
 3083 3f20 E0010000 		br.l	.L4.13
 3083      00000F18 
 3084              	.L4.14:
 3085              	# line 1336
1336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_src[src_off0+iw] = tmp_iw[iw]; // MUST always be executed (even to store 0.f)
 3086              		.loc	1 1336 0
 3087 3f28 80000000 		mins.l	%s53,%s50,%s53
 3087      B5B23568 
 3088 3f30 18020000 		br.l	.L4.15
 3088      00000F18 
 3089              	.L4.16:
 3090 3f38 00000000 		lea	%s63,__eh_curr_region@LO
 3090      00003F06 
 3091 3f40 00000000 		and	%s63,%s63,(32)0
 3091      60BF3F44 
 3092 3f48 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 3092      BF00BF06 
 3093 3f50 30FEFFFF 		ld2b.zx	%s62,-464(,%fp)
 3093      8900BE04 
 3094 3f58 00000000 		st2b	%s62,0(,%s63)
 3094      BF003E14 
 3095 3f60 08FEFFFF 		ld	%s63,-504(,%fp)
 3095      89003F01 
 3096 3f68 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 3096      00003E06 
 3097 3f70 00000000 		and	%s62,%s62,(32)0
 3097      60BE3E44 
 3098 3f78 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 3098      BE00BE06 
 3099 3f80 00000000 		st	%s63,0(,%s62)
 3099      BE003F11 
 3100 3f88 10160000 		br.l	.L4.17
 3100      00000F18 
 3101              	.L4.18:
 3102              	# line 1286
1286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 3103              		.loc	1 1286 0
 3104 3f90 00000000 		adds.l	%s63,1,%s63
 3104      BF013F59 
 3105 3f98 00000000 		adds.l	%s52,%s53,%s52
 3105      B4B53459 
 3106 3fa0 00000000 		adds.l	%s51,%s18,%s51
 3106      B3923359 
 3107 3fa8 00000000 		adds.l	%s20,1,%s20
 3107      94011459 
 3108 3fb0 200B0000 		brgt.l	0,%s63,.L4.19
 3108      BF000118 
 3109 3fb8 80FFFFFF 		br.l	.L4.16
 3109      00000F18 
 3110              	.L4.20:
 3111 3fc0 E0F4FFFF 		ld	%s63,-2848(,%fp)	# restore 
 3111      89003F01 
 3112 3fc8 D8F4FFFF 		ld	%s53,-2856(,%fp)	# restore 
 3112      89003501 
 3113 3fd0 D0F4FFFF 		ld	%s52,-2864(,%fp)	# restore 
 3113      89003401 
 3114 3fd8 38F5FFFF 		ld	%s18,-2760(,%fp)	# restore 
 3114      89001201 
 3115 3fe0 C8F4FFFF 		ld	%s51,-2872(,%fp)	# restore 
 3115      89003301 
 3116 3fe8 E8F4FFFF 		ld	%s19,-2840(,%fp)	# restore 
 3116      89001301 
 3117 3ff0 B0F4FFFF 		ld	%s49,-2896(,%fp)	# restore 
 3117      89003101 
 3118 3ff8 A0F4FFFF 		ld	%s47,-2912(,%fp)	# restore 
 3118      89002F01 
 3119 4000 C0F4FFFF 		ld	%s54,-2880(,%fp)	# restore 
 3119      89003601 
 3120 4008 B8F4FFFF 		ld	%s50,-2888(,%fp)	# restore 
 3120      89003201 
 3121 4010 A8F4FFFF 		ld	%s48,-2904(,%fp)	# restore 
 3121      89003001 
 3122 4018 78FFFFFF 		br.l	.L4.18
 3122      00000F18 
 3123              	.L4.21:
 3124              	# line 1287
1287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 3125              		.loc	1 1287 0
 3126 4020 00000000 		adds.l	%s63,1,%s63
 3126      BF013F59 
 3127 4028 00000000 		adds.l	%s31,%s55,%s31
 3127      9FB71F59 
 3128 4030 00000000 		adds.l	%s30,1,%s30
 3128      9E011E59 
 3129 4038 F0090000 		brgt.l	0,%s63,.L4.22
 3129      BF000118 
 3130 4040 80FFFFFF 		br.l	.L4.20
 3130      00000F18 
 3131              	.L4.23:
 3132 4048 08F5FFFF 		ld	%s63,-2808(,%fp)	# restore 
 3132      89003F01 
 3133 4050 00F5FFFF 		ld	%s55,-2816(,%fp)	# restore 
 3133      89003701 
 3134 4058 58F5FFFF 		ld	%s31,-2728(,%fp)	# restore 
 3134      89001F01 
 3135 4060 10F5FFFF 		ld	%s22,-2800(,%fp)	# restore 
 3135      89001601 
 3136 4068 F8F4FFFF 		ld	%s58,-2824(,%fp)	# restore 
 3136      89003A01 
 3137 4070 F0F4FFFF 		ld	%s57,-2832(,%fp)	# restore 
 3137      89003901 
 3138 4078 A8FFFFFF 		br.l	.L4.21
 3138      00000F18 
 3139              	.L4.24:
 3140              	# line 1288
1288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 3141              		.loc	1 1288 0
 3142 4080 00000000 		adds.l	%s63,1,%s63
 3142      BF013F59 
 3143 4088 00000000 		adds.l	%s28,%s56,%s28
 3143      9CB81C59 
 3144 4090 00000000 		adds.l	%s19,1,%s19
 3144      93011359 
 3145 4098 30090000 		brgt.l	0,%s63,.L4.25
 3145      BF000118 
 3146 40a0 A8FFFFFF 		br.l	.L4.23
 3146      00000F18 
 3147              	.L4.26:
 3148 40a8 28F5FFFF 		ld	%s63,-2776(,%fp)	# restore 
 3148      89003F01 
 3149 40b0 00000000 		or	%s59,0,%s62
 3149      BE003B45 
 3150 40b8 20F5FFFF 		ld	%s56,-2784(,%fp)	# restore 
 3150      89003801 
 3151 40c0 00000000 		or	%s60,0,%s28
 3151      9C003C45 
 3152 40c8 50F5FFFF 		ld	%s28,-2736(,%fp)	# restore 
 3152      89001C01 
 3153 40d0 30F5FFFF 		ld	%s21,-2768(,%fp)	# restore 
 3153      89001501 
 3154 40d8 18F5FFFF 		ld	%s62,-2792(,%fp)	# restore 
 3154      89003E01 
 3155 40e0 A0FFFFFF 		br.l	.L4.24
 3155      00000F18 
 3156              	.L4.27:
 3157 40e8 00000000 		or	%s18,0,%s56
 3157      B8001245 
 3158 40f0 00000000 		or	%s0,0,%s62
 3158      BE000045 
 3159 40f8 D8070000 		br.l	.L4.28
 3159      00000F18 
 3160              	.L4.13:
 3161 4100 00000000 		or	%s63,5,(0)1
 3161      00053F45 
 3162 4108 00000000 		st2b	%s63,0(,%s61)
 3162      BD003F14 
 3163              	# line 1289
1289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t kh_b = khb[ih];
 3164              		.loc	1 1289 0
 3165 4110 00000000 		adds.l	%s56,1,%s56
 3165      B8013859 
 3166 4118 00000000 		adds.l	%s25,8,%s25
 3166      99081959 
 3167 4120 00000000 		adds.l	%s31,1,%s31
 3167      9F011F59 
 3168 4128 C0FFFFFF 		brgt.l	0,%s56,.L4.27
 3168      B8000118 
 3169 4130 78FFFFFF 		br.l	.L4.26
 3169      00000F18 
 3170              	.L4.29:
 3171 4138 00000000 		or	%s56,0,%s60
 3171      BC003845 
 3172 4140 C0FFFFFF 		br.l	.L4.13
 3172      00000F18 
 3173              	.L4.15:
 3174              	# line 1337
1337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 3175              		.loc	1 1337 0
 3176 4148 00000000 		adds.l	%s56,%s63,(0)1
 3176      00BF3859 
 3177 4150 00000000 		adds.l	%s56,%s56,%s55
 3177      B7B83859 
 3178 4158 00000000 		lvl	%s53
 3178      00B500BF 
 3179 4160 00000039 		vldu.nc	%v57,4,%s56
 3179      B8040082 
 3180 4168 00000000 		adds.l	%s56,%s52,(0)1
 3180      00B43859 
 3181 4170 00000000 		adds.l	%s56,%s56,%s55
 3181      B7B83859 
 3182 4178 00000039 		vstu.nc	%v57,4,%s56
 3182      B8040092 
 3183              	# line 1336
1336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_src[src_off0+iw] = tmp_iw[iw]; // MUST always be executed (even to store 0.f)
 3184              		.loc	1 1336 0
 3185 4180 00000000 		adds.l	%s55,%s55,%s51
 3185      B3B73759 
 3186 4188 00000000 		subs.l	%s50,%s50,%s53
 3186      B5B2325B 
 3187 4190 A8FFFFFF 		brge.l	0,%s50,.L4.29
 3187      B2000518 
 3188 4198 90FDFFFF 		br.l	.L4.14
 3188      00000F18 
 3189              	.L4.30:
 3190 41a0 00000000 		muls.l	%s59,4,%s55
 3190      B7043B6E 
 3191 41a8 B8F5FFFF 		ld	%s62,-2632(,%fp)	# restore 
 3191      89003E01 
 3192 41b0 00000000 		or	%s60,0,%s18
 3192      92003C45 
 3193 41b8 00000000 		adds.l	%s52,%s59,%s29
 3193      9DBB3459 
 3194 41c0 00000000 		subs.l	%s59,0,%s28
 3194      9C003B5B 
 3195 41c8 00000000 		smvl	%s58
 3195      00003A2E 
 3196 41d0 80000000 		mins.l	%s53,%s59,%s58
 3196      BABB3568 
 3197 41d8 00000000 		or	%s50,0,%s59
 3197      BB003245 
 3198 41e0 00000000 		or	%s55,0,(0)1
 3198      00003745 
 3199 41e8 00000000 		muls.l	%s51,4,%s53
 3199      B504336E 
 3200 41f0 58FFFFFF 		br.l	.L4.15
 3200      00000F18 
 3201              	.L4.31:
 3202              	# line 1335
1335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t iw = 0; iw < IW; ++iw) {
 3203              		.loc	1 1335 0
 3204 41f8 08000000 		ldl.sx	%s56,8(,%s32)	# *(p).__b_N4conv6desc_tE.ic
 3204      A0003803 
 3205 4200 00000000 		or	%s56,0,%s56
 3205      B8003845 
 3206 4208 00000000 		muls.l	%s55,%s56,%s30
 3206      9EB8376E 
 3207 4210 00000000 		muls.l	%s53,%s56,%s20
 3207      94B8356E 
 3208 4218 00000000 		ldl.sx	%s52,0(,%s32)	# *(p).__b_N4conv6desc_tE.g
 3208      A0003403 
 3209 4220 00000000 		or	%s52,0,%s52
 3209      B4003445 
 3210 4228 00000000 		divs.l	%s52,%s53,%s52
 3210      B4B5347F 
 3211 4230 00000000 		adds.l	%s52,%s55,%s52
 3211      B4B73459 
 3212 4238 00000000 		adds.l	%s52,%s52,%s19
 3212      93B43459 
 3213 4240 0C000000 		ldl.sx	%s56,12(,%s32)	# *(p).__b_N4conv6desc_tE.ih
 3213      A0003803 
 3214 4248 00000000 		or	%s56,0,%s56
 3214      B8003845 
 3215 4250 00000000 		muls.l	%s56,%s52,%s56
 3215      B8B4386E 
 3216 4258 00000000 		adds.l	%s56,%s56,%s31
 3216      9FB83859 
 3217 4260 10000000 		ldl.sx	%s55,16(,%s32)	# *(p).__b_N4conv6desc_tE.iw
 3217      A0003703 
 3218 4268 00000000 		or	%s55,0,%s55
 3218      B7003745 
 3219 4270 00000000 		muls.l	%s55,%s56,%s55
 3219      B7B8376E 
 3220              	# line 1336
1336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_src[src_off0+iw] = tmp_iw[iw]; // MUST always be executed (even to store 0.f)
 3221              		.loc	1 1336 0
 3222 4278 00FEFFFF 		ld	%s63,-512(,%fp)	# tmp_iw
 3222      89003F01 
 3223 4280 20FFFFFF 		brlt.l	0,%s27,.L4.30
 3223      9B000218 
 3224 4288 88FCFFFF 		br.l	.L4.12
 3224      00000F18 
 3225              	.L4.32:
 3226 4290 38F5FFFF 		st	%s18,-2760(,%fp)	# spill 
 3226      89001211 
 3227 4298 40F5FFFF 		st	%s32,-2752(,%fp)	# spill 
 3227      89002011 
 3228 42a0 48F5FFFF 		st	%s29,-2744(,%fp)	# spill 
 3228      89001D11 
 3229 42a8 50F5FFFF 		st	%s28,-2736(,%fp)	# spill 
 3229      89001C11 
 3230 42b0 58F5FFFF 		st	%s31,-2728(,%fp)	# spill 
 3230      89001F11 
 3231 42b8 A0F5FFFF 		ld	%s32,-2656(,%fp)	# restore 
 3231      89002001 
 3232 42c0 88F5FFFF 		ld	%s30,-2680(,%fp)	# restore 
 3232      89001E01 
 3233 42c8 80F5FFFF 		ld	%s20,-2688(,%fp)	# restore 
 3233      89001401 
 3234 42d0 90F5FFFF 		ld	%s19,-2672(,%fp)	# restore 
 3234      89001301 
 3235 42d8 98F5FFFF 		ld	%s31,-2664(,%fp)	# restore 
 3235      89001F01 
 3236 42e0 B0F5FFFF 		ld	%s27,-2640(,%fp)	# restore 
 3236      89001B01 
 3237 42e8 A8F5FFFF 		ld	%s26,-2648(,%fp)	# restore 
 3237      89001A01 
 3238 42f0 78F5FFFF 		ld	%s29,-2696(,%fp)	# restore 
 3238      89001D01 
 3239 42f8 60F5FFFF 		ld	%s28,-2720(,%fp)	# restore 
 3239      89001C01 
 3240 4300 70F5FFFF 		ld	%s25,-2704(,%fp)	# restore 
 3240      89001901 
 3241 4308 68F5FFFF 		ld	%s18,-2712(,%fp)	# restore 
 3241      89001201 
 3242 4310 E8FEFFFF 		br.l	.L4.31
 3242      00000F18 
 3243              	.L4.33:
 3244              	# line 1333
1333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
 3245              		.loc	1 1333 0
 3246 4318 00FEFFFF 		ld	%s55,-512(,%fp)	# tmp_iw
 3246      89003701 
 3247 4320 00000000 		stu	%s63,0(%s53,%s55)	# *(tmp_iw)
 3247      B7B53F12 
 3248              	# line 1295
1295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t kw_b = kwb[iw];
 3249              		.loc	1 1295 0
 3250 4328 00000000 		adds.l	%s52,1,%s52
 3250      B4013459 
 3251 4330 00000000 		adds.l	%s56,8,%s56
 3251      B8083859 
 3252 4338 00000000 		adds.l	%s53,4,%s53
 3252      B5043559 
 3253 4340 A0040000 		brgt.l	0,%s52,.L4.34
 3253      B4000118 
 3254 4348 48FFFFFF 		br.l	.L4.32
 3254      00000F18 
 3255              	.L4.35:
 3256 4350 00000000 		or	%s62,6,(0)1
 3256      00063E45 
 3257 4358 00000000 		st2b	%s62,0(,%s61)
 3257      BD003E14 
 3258 4360 B8FFFFFF 		br.l	.L4.33
 3258      00000F18 
 3259              	.L4.36:
 3260 4368 F0F5FFFF 		st	%s54,-2576(,%fp)	# spill 
 3260      89003611 
 3261 4370 E8F5FFFF 		st	%s58,-2584(,%fp)	# spill 
 3261      89003A11 
 3262 4378 E0F5FFFF 		st	%s61,-2592(,%fp)	# spill 
 3262      89003D11 
 3263 4380 D8F5FFFF 		st	%s57,-2600(,%fp)	# spill 
 3263      89003911 
 3264 4388 D0F5FFFF 		st	%s46,-2608(,%fp)	# spill 
 3264      89002E11 
 3265 4390 C8F5FFFF 		st	%s59,-2616(,%fp)	# spill 
 3265      89003B11 
 3266 4398 C0F5FFFF 		st	%s62,-2624(,%fp)	# spill 
 3266      89003E11 
 3267              	# line 1322
1322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //itmp_oc[ixoc] = pdiff_dst[(int)((float)dst_off0 + (float)oc*OH_OW)]
 3268              		.loc	1 1322 0
 3269 43a0 0000003B 		lvs	%s63,%v59(0)
 3269      00003F9E 
 3270 43a8 00000000 		or	%s61,0,%s7
 3270      87003D45 
 3271 43b0 00000000 		or	%s32,0,%s60
 3271      BC002045 
 3272 43b8 00000000 		or	%s56,0,%s25
 3272      99003845 
 3273 43c0 00000000 		or	%s52,0,%s26
 3273      9A003445 
 3274 43c8 00000000 		or	%s53,0,%s21
 3274      95003545 
 3275 43d0 00000000 		or	%s21,0,%s27
 3275      9B001545 
 3276 43d8 78FFFFFF 		br.l	.L4.35
 3276      00000F18 
 3277              	.L4.37:
 3278              	# line 1328
1328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (ssize_t oc = 0; oc < tmp_oc_sz; ++oc) { tmp += tmp_oc[oc]; }
 3279              		.loc	1 1328 0
 3280 43e0 00000000 		subs.l	%s63,%s63,%s60
 3280      BCBF3F5B 
 3281              	# line 1308
1308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw += SW) {
 3282              		.loc	1 1308 0
 3283 43e8 00000000 		adds.l	%s56,%s59,%s56
 3283      B8BB3859 
 3284 43f0 00000000 		adds.l	%s55,%s55,%s54
 3284      B6B73759 
 3285 43f8 78020000 		brgt.l	0,%s56,.L4.38
 3285      B8000118 
 3286 4400 68FFFFFF 		br.l	.L4.36
 3286      00000F18 
 3287              	.L4.39:
 3288 4408 00000000 		or	%s63,0,%s6
 3288      86003F45 
 3289 4410 00000000 		or	%s60,0,%s3
 3289      83003C45 
 3290 4418 00000000 		or	%s59,0,%s1
 3290      81003B45 
 3291 4420 00000000 		or	%s56,0,%s2
 3291      82003845 
 3292 4428 00000000 		or	%s55,0,%s5
 3292      85003745 
 3293 4430 00000000 		or	%s54,0,%s4
 3293      84003645 
 3294 4438 A8FFFFFF 		br.l	.L4.37
 3294      00000F18 
 3295              	.L4.40:
 3296              	# line 1327
1327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 3297              		.loc	1 1327 0
 3298 4440 00000000 		adds.l	%s63,-4,%s63
 3298      BF7C3F59 
 3299              	# line 1309
1309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 3300              		.loc	1 1309 0
 3301 4448 00000000 		adds.l	%s60,%s62,%s60
 3301      BCBE3C59 
 3302 4450 00000000 		adds.l	%s59,%s59,%s58
 3302      BABB3B59 
 3303 4458 98010000 		brgt.l	0,%s60,.L4.41
 3303      BC000118 
 3304 4460 A8FFFFFF 		br.l	.L4.39
 3304      00000F18 
 3305              	.L4.42:
 3306              	# line 1322
1322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //itmp_oc[ixoc] = pdiff_dst[(int)((float)dst_off0 + (float)oc*OH_OW)]
 3307              		.loc	1 1322 0
 3308 4468 00000000 		lvl	%s52
 3308      00B400BF 
 3309 4470 00003F3A 		vfsum.s	%v58,%v63
 3309      000080EC 
 3310 4478 00000000 		or	%s56,1,(0)1
 3310      00013845 
 3311 4480 00000000 		lvl	%s56
 3311      00B800BF 
 3312 4488 003A3B3B 		vfadd.s	%v59,%v59,%v58
 3312      000080CC 
 3313 4490 00000000 		or	%s58,0,%s51
 3313      B3003A45 
 3314 4498 00000000 		or	%s59,0,%s50
 3314      B2003B45 
 3315 44a0 00000000 		or	%s60,0,%s49
 3315      B1003C45 
 3316 44a8 00000000 		or	%s62,0,%s48
 3316      B0003E45 
 3317 44b0 00000000 		or	%s63,0,%s47
 3317      AF003F45 
 3318 44b8 88FFFFFF 		br.l	.L4.40
 3318      00000F18 
 3319              	.L4.11:
 3320 44c0 00000000 		or	%s62,0,%s63
 3320      BF003E45 
 3321              	# line 1320
1320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp_oc[oc] *= pwei[(wei_off0 + oc*ICOG_KH_KW)];
 3322              		.loc	1 1320 0
 3323 44c8 00000000 		lvl	%s60
 3323      00BC00BF 
 3324 44d0 0000003E 		vldu.nc	%v62,%s61,%s62
 3324      BEBD0082 
 3325 44d8 00000000 		or	%s62,0,%s59
 3325      BB003E45 
 3326 44e0 0000003E 		vstu.nc	%v62,4,%s62
 3326      BE040092 
 3327 44e8 00000000 		or	%s62,0,%s58
 3327      BA003E45 
 3328              	# line 1321
1321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp += tmp_oc[oc];
 3329              		.loc	1 1321 0
 3330 44f0 0000003D 		vldu.nc	%v61,%s57,%s62
 3330      BEB90082 
 3331 44f8 003D3E3C 		vfmul.s	%v60,%v62,%v61
 3331      000080CD 
 3332 4500 00000000 		or	%s62,0,%s59
 3332      BB003E45 
 3333 4508 0000003C 		vstu.nc	%v60,4,%s62
 3333      BE040092 
 3334              	# line 1322
1322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //itmp_oc[ixoc] = pdiff_dst[(int)((float)dst_off0 + (float)oc*OH_OW)]
 3335              		.loc	1 1322 0
 3336 4510 003C3F3F 		vfadd.s	%v63,%v63,%v60
 3336      000080CC 
 3337              	# line 1314
1314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 3338              		.loc	1 1314 0
 3339 4518 00000000 		adds.l	%s63,%s63,%s56
 3339      B8BF3F59 
 3340 4520 00000000 		adds.l	%s58,%s58,%s55
 3340      B7BA3A59 
 3341 4528 00000000 		adds.l	%s59,%s59,%s54
 3341      B6BB3B59 
 3342 4530 00000000 		subs.l	%s53,%s53,%s60
 3342      BCB5355B 
 3343 4538 30FFFFFF 		brge.l	0,%s53,.L4.42
 3343      B5000518 
 3344 4540 C0F9FFFF 		br.l	.L4.10
 3344      00000F18 
 3345              	.L4.43:
 3346 4548 00000000 		subs.l	%s45,0,%s46
 3346      AE002D5B 
 3347 4550 00000000 		smvl	%s52
 3347      0000342E 
 3348 4558 80000000 		mins.l	%s43,%s45,%s52
 3348      B4AD2B68 
 3349              	# line 1322
1322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //itmp_oc[ixoc] = pdiff_dst[(int)((float)dst_off0 + (float)oc*OH_OW)]
 3350              		.loc	1 1322 0
 3351 4560 00000000 		or	%s42,0,(0)1
 3351      00002A45 
 3352 4568 00000000 		or	%s48,0,%s62
 3352      BE003045 
 3353 4570 00000000 		lvl	%s52
 3353      00B400BF 
 3354 4578 0000003F 		vbrdu	%v63,%s42
 3354      00AA808C 
 3355 4580 00000000 		or	%s53,0,%s45
 3355      AD003545 
 3356 4588 00000000 		or	%s62,0,%s63
 3356      BF003E45 
 3357              	# line 1314
1314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 3358              		.loc	1 1314 0
 3359 4590 00000000 		muls.l	%s56,%s61,%s43
 3359      ABBD386E 
 3360 4598 00000000 		or	%s50,0,%s59
 3360      BB003245 
 3361 45a0 00000000 		or	%s47,0,%s63
 3361      BF002F45 
 3362 45a8 00000000 		or	%s49,0,%s60
 3362      BC003145 
 3363 45b0 00000000 		or	%s51,0,%s58
 3363      BA003345 
 3364 45b8 00000000 		or	%s58,0,%s59
 3364      BB003A45 
 3365 45c0 00000000 		muls.l	%s55,%s57,%s43
 3365      ABB9376E 
 3366 45c8 00000000 		or	%s59,0,%s44
 3366      AC003B45 
 3367 45d0 00000000 		muls.l	%s54,4,%s43
 3367      AB04366E 
 3368 45d8 00000000 		or	%s60,0,%s43
 3368      AB003C45 
 3369 45e0 00000000 		or	%s63,0,%s62
 3369      BE003F45 
 3370 45e8 D8FEFFFF 		br.l	.L4.11
 3370      00000F18 
 3371              	.L4.41:
 3372 45f0 58FFFFFF 		brlt.l	0,%s18,.L4.43
 3372      92000218 
 3373 45f8 48FEFFFF 		br.l	.L4.40
 3373      00000F18 
 3374              	.L4.44:
 3375              	# line 1327
1327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
 3376              		.loc	1 1327 0
 3377 4600 00000000 		muls.l	%s53,4,%s41
 3377      A904356E 
 3378 4608 00000000 		or	%s1,0,%s59
 3378      BB000145 
 3379 4610 00000000 		or	%s2,0,%s56
 3379      B8000245 
 3380 4618 00000000 		adds.l	%s53,%s63,%s53
 3380      B5BF3559 
 3381              	# line 1309
1309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 3382              		.loc	1 1309 0
 3383 4620 00000000 		muls.l	%s56,4,%s19
 3383      9304386E 
 3384 4628 00000000 		adds.l	%s52,%s19,%s40
 3384      A8933459 
 3385 4630 00000000 		or	%s3,0,%s60
 3385      BC000345 
 3386 4638 00000000 		adds.l	%s59,%s55,%s56
 3386      B8B73B59 
 3387 4640 00000000 		or	%s60,0,%s52
 3387      B4003C45 
 3388 4648 00000000 		or	%s4,0,%s54
 3388      B6000445 
 3389 4650 00000000 		or	%s5,0,%s55
 3389      B7000545 
 3390 4658 00000000 		or	%s6,0,%s63
 3390      BF000645 
 3391 4660 00000000 		or	%s63,0,%s53
 3391      B5003F45 
 3392 4668 88FFFFFF 		br.l	.L4.41
 3392      00000F18 
 3393              	.L4.38:
 3394 4670 90FFFFFF 		brlt.l	%s19,%s20,.L4.44
 3394      94930218 
 3395 4678 68FDFFFF 		br.l	.L4.37
 3395      00000F18 
 3396              	.L4.45:
 3397              	# line 1328
1328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (ssize_t oc = 0; oc < tmp_oc_sz; ++oc) { tmp += tmp_oc[oc]; }
 3398              		.loc	1 1328 0
 3399 4680 00000000 		muls.l	%s51,%s33,%s32
 3399      A0A1336E 
 3400 4688 00000000 		or	%s60,0,%s32
 3400      A0003C45 
 3401 4690 00000000 		or	%s7,0,%s61
 3401      BD000745 
 3402 4698 00000000 		adds.l	%s63,%s51,%s31
 3402      9FB33F59 
 3403              	# line 1308
1308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw += SW) {
 3404              		.loc	1 1308 0
 3405 46a0 00000000 		adds.l	%s51,%s21,%s30
 3405      9E953359 
 3406 46a8 00000000 		muls.l	%s50,%s21,%s29
 3406      9D95326E 
 3407 46b0 00000000 		or	%s25,0,%s56
 3407      B8001945 
 3408 46b8 00000000 		or	%s56,0,%s51
 3408      B3003845 
 3409 46c0 00000000 		adds.l	%s55,%s50,%s28
 3409      9CB23759 
 3410              	# line 1309
1309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 3411              		.loc	1 1309 0
 3412 46c8 00000000 		subs.l	%s40,0,%s20
 3412      9400285B 
 3413              	# line 1322
1322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //itmp_oc[ixoc] = pdiff_dst[(int)((float)dst_off0 + (float)oc*OH_OW)]
 3414              		.loc	1 1322 0
 3415 46d0 00000000 		or	%s51,1,(0)1
 3415      00013345 
 3416 46d8 00000000 		or	%s50,0,(0)1
 3416      00003245 
 3417 46e0 00000000 		or	%s26,0,%s52
 3417      B4001A45 
 3418 46e8 00000000 		lvl	%s51
 3418      00B300BF 
 3419 46f0 0000003B 		vbrdu	%v59,%s50
 3419      00B2808C 
 3420 46f8 00000000 		or	%s27,0,%s21
 3420      95001B45 
 3421 4700 00000000 		or	%s21,0,%s53
 3421      B5001545 
 3422 4708 F0F5FFFF 		ld	%s54,-2576(,%fp)	# restore 
 3422      89003601 
 3423 4710 E8F5FFFF 		ld	%s58,-2584(,%fp)	# restore 
 3423      89003A01 
 3424 4718 E0F5FFFF 		ld	%s61,-2592(,%fp)	# restore 
 3424      89003D01 
 3425 4720 D8F5FFFF 		ld	%s57,-2600(,%fp)	# restore 
 3425      89003901 
 3426 4728 D0F5FFFF 		ld	%s46,-2608(,%fp)	# restore 
 3426      89002E01 
 3427 4730 C8F5FFFF 		ld	%s59,-2616(,%fp)	# restore 
 3427      89003B01 
 3428 4738 C0F5FFFF 		ld	%s62,-2624(,%fp)	# restore 
 3428      89003E01 
 3429 4740 30FFFFFF 		br.l	.L4.38
 3429      00000F18 
 3430              	.L4.46:
 3431 4748 F8F5FFFF 		st	%s63,-2568(,%fp)	# spill 
 3431      89003F11 
 3432 4750 00000000 		or	%s0,0,%s23
 3432      97000045 
 3433              	# line 1302
1302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //const ssize_t tmp_oc_sz = (kh_e-kh_b)*(kw_e-kw_b)*OCOG;
 3434              		.loc	1 1302 0
 3435 4758 00000000 		lea	%s12,__grow_stack@LO
 3435      00000C06 
 3436 4760 00000000 		and	%s12,%s12,(32)0
 3436      608C0C44 
 3437 4768 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3437      8C008C06 
 3438 4770 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3438      8C000A08 
 3439 4778 D0000000 		lea	%s55,208
 3439      00003706 
 3440 4780 00000000 		adds.l	%s55,%sp,%s55
 3440      B78B3759 
 3441 4788 F8F5FFFF 		ld	%s63,-2568(,%fp)	# restore 
 3441      89003F01 
 3442 4790 00000000 		st	%s55,0(,%s24)
 3442      98003711 
 3443 4798 80FFFFFF 		ld	%s44,-128(,%fp)	# tmp_oc
 3443      89002C01 
 3444 47a0 D0FFFFFF 		lea	%s55,-48
 3444      00003706 
 3445 47a8 00000000 		st	%s44,0(%s55,%fp)
 3445      89B72C11 
 3446 47b0 00000000 		or	%s55,7,(0)1
 3446      00073745 
 3447 47b8 00000000 		st2b	%s55,0(,%s61)
 3447      BD003714 
 3448 47c0 C0FEFFFF 		brlt.l	%s21,%s22,.L4.45
 3448      96950218 
 3449 47c8 88FBFFFF 		br.l	.L4.35
 3449      00000F18 
 3450              	.L4.47:
 3451 47d0 78FFFFFF 		brlt.l	%s19,%s20,.L4.46
 3451      94930218 
 3452 47d8 40FBFFFF 		br.l	.L4.33
 3452      00000F18 
 3453              	.L4.34:
 3454              	# line 1296
1296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t kw_e = kwe[iw];
 3455              		.loc	1 1296 0
 3456 47e0 00000000 		or	%s63,0,(0)1
 3456      00003F45 
 3457 47e8 E0FFFFFF 		ld	%s55,-32(,%fp)	# kwb
 3457      89003701 
 3458 47f0 00000000 		ld	%s19,0(%s56,%s55)	# *(kwb)
 3458      B7B81301 
 3459              	# line 1297
1297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ow_b = owb[iw];
 3460              		.loc	1 1297 0
 3461 47f8 E8FFFFFF 		ld	%s55,-24(,%fp)	# kwe
 3461      89003701 
 3462 4800 00000000 		ld	%s20,0(%s56,%s55)	# *(kwe)
 3462      B7B81401 
 3463              	# line 1298
1298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 3464              		.loc	1 1298 0
 3465 4808 F0FFFFFF 		ld	%s55,-16(,%fp)	# owb
 3465      89003701 
 3466 4810 00000000 		ld	%s41,0(%s56,%s55)	# *(owb)
 3466      B7B82901 
 3467 4818 B8FFFFFF 		brlt.l	%s21,%s22,.L4.47
 3467      96950218 
 3468 4820 F8FAFFFF 		br.l	.L4.33
 3468      00000F18 
 3469              	.L4.48:
 3470 4828 B0F5FFFF 		st	%s27,-2640(,%fp)	# spill 
 3470      89001B11 
 3471 4830 A8F5FFFF 		st	%s26,-2648(,%fp)	# spill 
 3471      89001A11 
 3472 4838 A0F5FFFF 		st	%s32,-2656(,%fp)	# spill 
 3472      89002011 
 3473 4840 98F5FFFF 		st	%s31,-2664(,%fp)	# spill 
 3473      89001F11 
 3474 4848 90F5FFFF 		st	%s19,-2672(,%fp)	# spill 
 3474      89001311 
 3475 4850 88F5FFFF 		st	%s30,-2680(,%fp)	# spill 
 3475      89001E11 
 3476 4858 80F5FFFF 		st	%s20,-2688(,%fp)	# spill 
 3476      89001411 
 3477 4860 78F5FFFF 		st	%s29,-2696(,%fp)	# spill 
 3477      89001D11 
 3478 4868 70F5FFFF 		st	%s25,-2704(,%fp)	# spill 
 3478      89001911 
 3479 4870 68F5FFFF 		st	%s18,-2712(,%fp)	# spill 
 3479      89001211 
 3480 4878 60F5FFFF 		st	%s28,-2720(,%fp)	# spill 
 3480      89001C11 
 3481 4880 00000000 		or	%s52,0,%s28
 3481      9C003445 
 3482              	# line 1295
1295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t kw_b = kwb[iw];
 3483              		.loc	1 1295 0
 3484 4888 00000000 		or	%s56,0,(0)1
 3484      00003845 
 3485 4890 00000000 		or	%s53,0,(0)1
 3485      00003545 
 3486              	# line 1308
1308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw += SW) {
 3487              		.loc	1 1308 0
 3488 4898 00000000 		subs.l	%s30,0,%s22
 3488      96001E5B 
 3489 48a0 58F5FFFF 		ld	%s31,-2728(,%fp)	# restore 
 3489      89001F01 
 3490 48a8 50F5FFFF 		ld	%s28,-2736(,%fp)	# restore 
 3490      89001C01 
 3491 48b0 48F5FFFF 		ld	%s29,-2744(,%fp)	# restore 
 3491      89001D01 
 3492 48b8 40F5FFFF 		ld	%s32,-2752(,%fp)	# restore 
 3492      89002001 
 3493 48c0 38F5FFFF 		ld	%s18,-2760(,%fp)	# restore 
 3493      89001201 
 3494 48c8 18FFFFFF 		br.l	.L4.34
 3494      00000F18 
 3495              	.L4.28:
 3496              	# line 1290
1290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t kh_e = khe[ih];
 3497              		.loc	1 1290 0
 3498 48d0 88FFFFFF 		ld	%s63,-120(,%fp)	# khb
 3498      89003F01 
 3499 48d8 B8F5FFFF 		st	%s0,-2632(,%fp)	# spill 
 3499      89000011 
 3500 48e0 00000000 		ld	%s21,0(%s25,%s63)	# *(khb)
 3500      BF991501 
 3501              	# line 1291
1291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t oh_b = ohb[ih];
 3502              		.loc	1 1291 0
 3503 48e8 90FFFFFF 		ld	%s63,-112(,%fp)	# khe
 3503      89003F01 
 3504 48f0 00000000 		ld	%s22,0(%s25,%s63)	# *(khe)
 3504      BF991601 
 3505              	# line 1292
1292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 3506              		.loc	1 1292 0
 3507 48f8 D8FFFFFF 		ld	%s63,-40(,%fp)	# ohb
 3507      89003F01 
 3508 4900 00000000 		ld	%s33,0(%s25,%s63)	# *(ohb)
 3508      BF992101 
 3509              	# line 1294
1294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t iw = 0; iw < IW; ++iw) {
 3510              		.loc	1 1294 0
 3511 4908 00000000 		lea	%s12,__grow_stack@LO
 3511      00000C06 
 3512 4910 00000000 		and	%s12,%s12,(32)0
 3512      608C0C44 
 3513 4918 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3513      8C008C06 
 3514 4920 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3514      8C000A08 
 3515 4928 D0000000 		lea	%s63,208
 3515      00003F06 
 3516 4930 00000000 		adds.l	%s63,%sp,%s63
 3516      BF8B3F59 
 3517 4938 00000000 		st	%s63,0(,%s26)
 3517      9A003F11 
 3518 4940 00FEFFFF 		ld	%s63,-512(,%fp)	# tmp_iw
 3518      89003F01 
 3519 4948 C8FFFFFF 		lea	%s56,-56
 3519      00003806 
 3520 4950 00000000 		st	%s63,0(%s56,%fp)
 3520      89B83F11 
 3521 4958 00000000 		or	%s63,6,(0)1
 3521      00063F45 
 3522 4960 00000000 		st2b	%s63,0(,%s61)
 3522      BD003F14 
 3523 4968 C0FEFFFF 		brlt.l	0,%s27,.L4.48
 3523      9B000218 
 3524 4970 88F8FFFF 		br.l	.L4.31
 3524      00000F18 
 3525              	.L4.49:
 3526 4978 30F5FFFF 		st	%s21,-2768(,%fp)	# spill 
 3526      89001511 
 3527 4980 50F5FFFF 		st	%s28,-2736(,%fp)	# spill 
 3527      89001C11 
 3528 4988 28F5FFFF 		st	%s63,-2776(,%fp)	# spill 
 3528      89003F11 
 3529 4990 20F5FFFF 		st	%s56,-2784(,%fp)	# spill 
 3529      89003811 
 3530 4998 18F5FFFF 		st	%s62,-2792(,%fp)	# spill 
 3530      89003E11 
 3531 49a0 00000000 		or	%s18,0,%s62
 3531      BE001245 
 3532              	# line 1289
1289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t kh_b = khb[ih];
 3533              		.loc	1 1289 0
 3534 49a8 00000000 		or	%s25,0,(0)1
 3534      00001945 
 3535 49b0 00000000 		or	%s28,0,%s60
 3535      BC001C45 
 3536 49b8 00000000 		or	%s0,0,%s59
 3536      BB000045 
 3537 49c0 10FFFFFF 		br.l	.L4.28
 3537      00000F18 
 3538              	.L4.25:
 3539 49c8 00000000 		or	%s31,0,(0)1
 3539      00001F45 
 3540 49d0 A8FFFFFF 		brlt.l	0,%s21,.L4.49
 3540      95000218 
 3541 49d8 A8F6FFFF 		br.l	.L4.24
 3541      00000F18 
 3542              	.L4.50:
 3543 49e0 10F5FFFF 		st	%s22,-2800(,%fp)	# spill 
 3543      89001611 
 3544 49e8 58F5FFFF 		st	%s31,-2728(,%fp)	# spill 
 3544      89001F11 
 3545 49f0 08F5FFFF 		st	%s63,-2808(,%fp)	# spill 
 3545      89003F11 
 3546 49f8 00F5FFFF 		st	%s55,-2816(,%fp)	# spill 
 3546      89003711 
 3547 4a00 F8F4FFFF 		st	%s58,-2824(,%fp)	# spill 
 3547      89003A11 
 3548 4a08 F0F4FFFF 		st	%s57,-2832(,%fp)	# spill 
 3548      89003911 
 3549 4a10 00000000 		or	%s63,0,%s58
 3549      BA003F45 
 3550 4a18 00000000 		or	%s28,0,%s57
 3550      B9001C45 
 3551 4a20 A8FFFFFF 		br.l	.L4.25
 3551      00000F18 
 3552              	.L4.22:
 3553              	# line 1288
1288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 3554              		.loc	1 1288 0
 3555 4a28 00000000 		or	%s19,0,(0)1
 3555      00001345 
 3556 4a30 B0FFFFFF 		brlt.l	0,%s22,.L4.50
 3556      96000218 
 3557 4a38 E8F5FFFF 		br.l	.L4.21
 3557      00000F18 
 3558              	.L4.51:
 3559 4a40 E8F4FFFF 		st	%s19,-2840(,%fp)	# spill 
 3559      89001311 
 3560 4a48 38F5FFFF 		st	%s18,-2760(,%fp)	# spill 
 3560      89001211 
 3561 4a50 E0F4FFFF 		st	%s63,-2848(,%fp)	# spill 
 3561      89003F11 
 3562 4a58 D8F4FFFF 		st	%s53,-2856(,%fp)	# spill 
 3562      89003511 
 3563 4a60 D0F4FFFF 		st	%s52,-2864(,%fp)	# spill 
 3563      89003411 
 3564 4a68 C8F4FFFF 		st	%s51,-2872(,%fp)	# spill 
 3564      89003311 
 3565 4a70 C0F4FFFF 		st	%s54,-2880(,%fp)	# spill 
 3565      89003611 
 3566 4a78 B8F4FFFF 		st	%s50,-2888(,%fp)	# spill 
 3566      89003211 
 3567 4a80 B0F4FFFF 		st	%s49,-2896(,%fp)	# spill 
 3567      89003111 
 3568 4a88 A8F4FFFF 		st	%s48,-2904(,%fp)	# spill 
 3568      89003011 
 3569 4a90 A0F4FFFF 		st	%s47,-2912(,%fp)	# spill 
 3569      89002F11 
 3570 4a98 00000000 		or	%s63,0,%s54
 3570      B6003F45 
 3571              	# line 1287
1287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 3572              		.loc	1 1287 0
 3573 4aa0 00000000 		muls.l	%s50,%s51,%s50
 3573      B2B3326E 
 3574 4aa8 00000000 		adds.l	%s49,%s50,%s49
 3574      B1B23159 
 3575 4ab0 00000000 		or	%s31,0,%s49
 3575      B1001F45 
 3576              	# line 1288
1288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 3577              		.loc	1 1288 0
 3578 4ab8 00000000 		muls.l	%s48,%s52,%s48
 3578      B0B4306E 
 3579 4ac0 00000000 		adds.l	%s57,%s48,%s47
 3579      AFB03959 
 3580 4ac8 60FFFFFF 		br.l	.L4.22
 3580      00000F18 
 3581              	.L4.19:
 3582              	# line 1287
1287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 3583              		.loc	1 1287 0
 3584 4ad0 00000000 		or	%s30,0,(0)1
 3584      00001E45 
 3585 4ad8 68FFFFFF 		brlt.l	0,%s19,.L4.51
 3585      93000218 
 3586 4ae0 B0F4FFFF 		br.l	.L4.18
 3586      00000F18 
 3587              	.L4.52:
 3588 4ae8 00000000 		or	%s57,0,%s24
 3588      98003945 
 3589 4af0 00000000 		subs.l	%s54,0,%s57
 3589      B900365B 
 3590              	# line 1286
1286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 3591              		.loc	1 1286 0
 3592 4af8 00000000 		subs.l	%s46,0,%s23
 3592      97002E5B 
 3593 4b00 B0F4FFFF 		ld	%s49,-2896(,%fp)	# restore 
 3593      89003101 
 3594 4b08 00000000 		or	%s63,0,%s46
 3594      AE003F45 
 3595 4b10 00000000 		or	%s25,0,%s25
 3595      99001945 
 3596              	# line 1289
1289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t kh_b = khb[ih];
 3597              		.loc	1 1289 0
 3598 4b18 00000000 		subs.l	%s62,0,%s25
 3598      99003E5B 
 3599 4b20 00000000 		or	%s27,0,%s28
 3599      9C001B45 
 3600              	# line 1295
1295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t kw_b = kwb[iw];
 3601              		.loc	1 1295 0
 3602 4b28 00000000 		subs.l	%s60,0,%s27
 3602      9B003C5B 
 3603              	# line 1294
1294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t iw = 0; iw < IW; ++iw) {
 3604              		.loc	1 1294 0
 3605 4b30 00000000 		muls.l	%s59,4,%s27
 3605      9B043B6E 
 3606 4b38 00000000 		adds.l	%s26,%fp,(55)1
 3606      37891A59 
 3607              	# line 1302
1302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //const ssize_t tmp_oc_sz = (kh_e-kh_b)*(kw_e-kw_b)*OCOG;
 3608              		.loc	1 1302 0
 3609 4b40 00000000 		adds.l	%s24,%fp,(57)1
 3609      39891859 
 3610 4b48 00000000 		muls.l	%s23,4,%s18
 3610      9204176E 
 3611              	# line 1314
1314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 3612              		.loc	1 1314 0
 3613 4b50 00000000 		subs.l	%s46,0,%s18
 3613      92002E5B 
 3614 4b58 A0F4FFFF 		ld	%s47,-2912(,%fp)	# restore 
 3614      89002F01 
 3615 4b60 D0F5FFFF 		st	%s46,-2608(,%fp)	# spill 
 3615      89002E11 
 3616 4b68 00000000 		lea	%s61,__eh_curr_region@LO
 3616      00003D06 
 3617 4b70 00000000 		and	%s61,%s61,(32)0
 3617      60BD3D44 
 3618 4b78 00000000 		lea.sl	%s61,__eh_curr_region@HI(,%s61)
 3618      BD00BD06 
 3619 4b80 00000000 		or	%s46,0,%s32
 3619      A0002E45 
 3620              	# line 1308
1308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw += SW) {
 3621              		.loc	1 1308 0
 3622 4b88 00000000 		muls.l	%s45,4,%s46
 3622      AE042D6E 
 3623 4b90 00000000 		or	%s33,0,%s33
 3623      A1002145 
 3624              	# line 1328
1328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //for (ssize_t oc = 0; oc < tmp_oc_sz; ++oc) { tmp += tmp_oc[oc]; }
 3625              		.loc	1 1328 0
 3626 4b98 00000000 		muls.l	%s44,4,%s33
 3626      A1042C6E 
 3627 4ba0 48F5FFFF 		st	%s45,-2744(,%fp)	# spill 
 3627      89002D11 
 3628 4ba8 40F5FFFF 		st	%s44,-2752(,%fp)	# spill 
 3628      89002C11 
 3629 4bb0 08E4FFFF 		ld	%s43,-7160(,%fp)	# restore 
 3629      89002B01 
 3630 4bb8 A0F5FFFF 		ld	%s32,-2656(,%fp)	# restore 
 3630      89002001 
 3631              	# line 1308
1308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw += SW) {
 3632              		.loc	1 1308 0
 3633 4bc0 00000000 		muls.l	%s42,%s43,%s45
 3633      ADAB2A6E 
 3634 4bc8 C8F5FFFF 		st	%s43,-2616(,%fp)	# spill 
 3634      89002B11 
 3635 4bd0 F0F5FFFF 		st	%s42,-2576(,%fp)	# spill 
 3635      89002A11 
 3636 4bd8 00000000 		or	%s43,0,%s21
 3636      95002B45 
 3637 4be0 C0F5FFFF 		st	%s43,-2624(,%fp)	# spill 
 3637      89002B11 
 3638              	# line 1309
1309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 3639              		.loc	1 1309 0
 3640 4be8 00000000 		muls.l	%s43,4,%s43
 3640      AB042B6E 
 3641 4bf0 10E4FFFF 		ld	%s42,-7152(,%fp)	# restore 
 3641      89002A01 
 3642 4bf8 00000000 		or	%s21,0,%s25
 3642      99001545 
 3643 4c00 E8F5FFFF 		st	%s43,-2584(,%fp)	# spill 
 3643      89002B11 
 3644              	# line 1288
1288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 3645              		.loc	1 1288 0
 3646 4c08 00000000 		muls.l	%s46,%s46,%s42
 3646      AAAE2E6E 
 3647 4c10 00000000 		muls.l	%s56,4,%s46
 3647      AE04386E 
 3648 4c18 00000000 		muls.l	%s48,%s42,%s45
 3648      ADAA306E 
 3649 4c20 00000000 		or	%s30,0,%s30
 3649      9E001E45 
 3650 4c28 00E4FFFF 		ld	%s46,-7168(,%fp)	# restore 
 3650      89002E01 
 3651              	# line 1287
1287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 3652              		.loc	1 1287 0
 3653 4c30 00000000 		muls.l	%s30,%s30,%s46
 3653      AE9E1E6E 
 3654 4c38 00000000 		muls.l	%s30,%s33,%s30
 3654      9EA11E6E 
 3655 4c40 00000000 		muls.l	%s55,4,%s30
 3655      9E04376E 
 3656 4c48 00000000 		muls.l	%s50,%s46,%s44
 3656      ACAE326E 
 3657              	# line 1286
1286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 3658              		.loc	1 1286 0
 3659 4c50 00000000 		muls.l	%s53,%s18,%s22
 3659      9692356E 
 3660              	# line 1288
1288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 3661              		.loc	1 1288 0
 3662 4c58 00000000 		subs.l	%s58,0,%s22
 3662      96003A5B 
 3663              	# line 1286
1286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 3664              		.loc	1 1286 0
 3665 4c60 00000000 		or	%s52,0,(0)1
 3665      00003445 
 3666 4c68 00000000 		or	%s51,0,(0)1
 3666      00003345 
 3667              	# line 1314
1314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 3668              		.loc	1 1314 0
 3669 4c70 00000000 		muls.l	%s37,4,%s37
 3669      A504256E 
 3670 4c78 00000000 		muls.l	%s46,4,%s19
 3670      93042E6E 
 3671 4c80 D8F5FFFF 		st	%s37,-2600(,%fp)	# spill 
 3671      89002511 
 3672 4c88 E0F5FFFF 		st	%s46,-2592(,%fp)	# spill 
 3672      89002E11 
 3673 4c90 00000000 		or	%s19,0,%s57
 3673      B9001345 
 3674 4c98 38FEFFFF 		br.l	.L4.19
 3674      00000F18 
 3675              	.L4.7:
 3676              	# line 1286
1286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 3677              		.loc	1 1286 0
 3678 4ca0 00000000 		or	%s20,0,(0)1
 3678      00001445 
 3679 4ca8 00000000 		or	%s23,0,%s23
 3679      97001745 
 3680 4cb0 38FEFFFF 		brlt.l	0,%s23,.L4.52
 3680      97000218 
 3681 4cb8 80F2FFFF 		br.l	.L4.16
 3681      00000F18 
 3682              	.L4.53:
 3683 4cc0 E0FFFFFF 		br.l	.L4.7
 3683      00000F18 
 3684              	.L4.9:
 3685              	# line 1276
1276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     owb[iw] = OW - 1;
 3686              		.loc	1 1276 0
 3687 4cc8 00000000 		lvl	%s62
 3687      00BE00BF 
 3688 4cd0 00270026 		vadds.l	%v38,%s63,%v39
 3688      00BF208B 
 3689 4cd8 00000000 		adds.l	%s49,%s61,(0)1
 3689      00BD3159 
 3690 4ce0 00000000 		adds.l	%s48,%s49,%s60
 3690      BCB13059 
 3691 4ce8 00000026 		vst.nc	%v38,8,%s48
 3691      B0080091 
 3692              	# line 1277
1277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
 3693              		.loc	1 1277 0
 3694 4cf0 00000021 		vbrd	%v33,%s59
 3694      00BB008C 
 3695 4cf8 00000000 		adds.l	%s48,%s58,(0)1
 3695      00BA3059 
 3696 4d00 00000000 		adds.l	%s47,%s48,%s60
 3696      BCB02F59 
 3697 4d08 00000021 		vst.nc	%v33,8,%s47
 3697      AF080091 
 3698              	# line 1278
1278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
 3699              		.loc	1 1278 0
 3700 4d10 00000000 		adds.l	%s47,%s49,%s60
 3700      BCB12F59 
 3701 4d18 00000020 		vld.nc	%v32,8,%s47
 3701      AF080081 
 3702 4d20 00000000 		subs.l	%s47,0,%s57
 3702      B9002F5B 
 3703 4d28 0020001F 		vadds.l	%v31,%s47,%v32
 3703      00AF208B 
 3704 4d30 001F001E 		vadds.l	%v30,%s56,%v31
 3704      00B8208B 
 3705 4d38 00000000 		adds.l	%s47,%s55,(0)1
 3705      00B72F59 
 3706 4d40 00000000 		adds.l	%s46,%s47,%s60
 3706      BCAF2E59 
 3707 4d48 0000001E 		vst.nc	%v30,8,%s46
 3707      AE080091 
 3708              	# line 1279
1279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       owb[iw] = kwe[iw] / SW;
 3709              		.loc	1 1279 0
 3710 4d50 001E001D 		vcmps.l	%v29,%s54,%v30
 3710      00B620BA 
 3711 4d58 001D010F 		vfmk.l.gt	%vm15,%v29
 3711      000000B4 
 3712              	# line 1280
1280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       kwb[iw] = kwe[iw] % SW;
 3713              		.loc	1 1280 0
 3714 4d60 00000000 		adds.l	%s46,%s49,%s60
 3714      BCB12E59 
 3715 4d68 0000001C 		vld.nc	%v28,8,%s46
 3715      AE080081 
 3716 4d70 00001C25 		vdivs.l	%v37,%v28,%s56,%vm15
 3716      00B81FFB 
 3717 4d78 00000000 		adds.l	%s48,%s48,%s60
 3717      BCB03059 
 3718 4d80 00000025 		vst.nc	%v37,8,%s48,%vm15
 3718      B0080F91 
 3719              	# line 1281
1281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 3720              		.loc	1 1281 0
 3721 4d88 00000000 		adds.l	%s48,%s49,%s60
 3721      BCB13059 
 3722 4d90 0000001B 		vld.nc	%v27,8,%s48
 3722      B0080081 
 3723 4d98 00001B24 		vdivs.l	%v36,%v27,%s56,%vm15
 3723      00B81FFB 
 3724 4da0 00240023 		vmuls.l	%v35,%s56,%v36,%vm15
 3724      00B82FDB 
 3725 4da8 00231B22 		vsubs.l	%v34,%v27,%v35,%vm15
 3725      00000F9B 
 3726 4db0 00000000 		adds.l	%s47,%s47,%s60
 3726      BCAF2F59 
 3727 4db8 00000022 		vst.nc	%v34,8,%s47,%vm15
 3727      AF080F91 
 3728              	# line 1283
1283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 3729              		.loc	1 1283 0
 3730 4dc0 00000000 		adds.l	%s48,%s49,%s60
 3730      BCB13059 
 3731 4dc8 0000001A 		vld.nc	%v26,8,%s48
 3731      B0080081 
 3732 4dd0 001A0019 		vadds.l	%v25,1,%v26
 3732      0001208B 
 3733 4dd8 00000000 		adds.l	%s48,%s49,%s60
 3733      BCB13059 
 3734 4de0 00000019 		vst.nc	%v25,8,%s48
 3734      B0080091 
 3735 4de8 00190018 		vcmps.l	%v24,%s53,%v25
 3735      00B520BA 
 3736 4df0 0018020F 		vfmk.l.lt	%vm15,%v24
 3736      000000B4 
 3737 4df8 00000017 		vbrd	%v23,%s53
 3737      00B5008C 
 3738 4e00 00000000 		adds.l	%s49,%s49,%s60
 3738      BCB13159 
 3739 4e08 00000017 		vst.nc	%v23,8,%s49,%vm15
 3739      B1080F91 
 3740              	# line 1275
1275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwe[iw] = iw + PW;
 3741              		.loc	1 1275 0
 3742 4e10 00000000 		adds.l	%s60,%s60,%s52
 3742      B4BC3C59 
 3743 4e18 00000000 		adds.l	%s63,%s63,%s51
 3743      B3BF3F59 
 3744 4e20 00000000 		subs.l	%s50,%s50,%s62
 3744      BEB2325B 
 3745 4e28 98FEFFFF 		brge.l	0,%s50,.L4.53
 3745      B2000518 
 3746 4e30 C0F0FFFF 		br.l	.L4.8
 3746      00000F18 
 3747              	.L4.54:
 3748 4e38 00000000 		or	%s31,0,%s31
 3748      9F001F45 
 3749              	# line 1277
1277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
 3750              		.loc	1 1277 0
 3751 4e40 00000000 		adds.w.sx	%s49,-1,%s33
 3751      A17F314A 
 3752 4e48 00000000 		or	%s37,0,%s20
 3752      94002545 
 3753 4e50 00000000 		or	%s59,0,%s49
 3753      B1003B45 
 3754              	# line 1278
1278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
 3755              		.loc	1 1278 0
 3756 4e58 00000000 		muls.w.sx	%s49,%s33,%s21
 3756      95A1314B 
 3757 4e60 00000000 		or	%s57,0,%s49
 3757      B1003945 
 3758 4e68 00000000 		or	%s56,0,%s21
 3758      95003845 
 3759              	# line 1279
1279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       owb[iw] = kwe[iw] / SW;
 3760              		.loc	1 1279 0
 3761 4e70 00000000 		adds.w.sx	%s49,-1,%s21
 3761      957F314A 
 3762 4e78 00000000 		or	%s54,0,%s49
 3762      B1003645 
 3763 4e80 00000000 		or	%s53,0,%s32
 3763      A0003545 
 3764              	# line 1275
1275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwe[iw] = iw + PW;
 3765              		.loc	1 1275 0
 3766 4e88 00000000 		subs.l	%s26,0,%s26
 3766      9A001A5B 
 3767 4e90 00000000 		subs.l	%s26,0,%s26
 3767      9A001A5B 
 3768 4e98 00000000 		smvl	%s49
 3768      0000312E 
 3769 4ea0 80000000 		mins.l	%s62,%s26,%s49
 3769      B19A3E68 
 3770 4ea8 00000000 		or	%s50,0,%s26
 3770      9A003245 
 3771 4eb0 00000000 		or	%s60,0,(0)1
 3771      00003C45 
 3772 4eb8 00000000 		muls.l	%s52,8,%s62
 3772      BE08346E 
 3773 4ec0 00000000 		or	%s63,0,%s31
 3773      9F003F45 
 3774 4ec8 00000000 		or	%s51,0,%s62
 3774      BE003345 
 3775 4ed0 00000000 		lvl	%s62
 3775      00BE00BF 
 3776 4ed8 00000015 		vseq	%v21
 3776      00000099 
 3777 4ee0 00150027 		vor	%v39,(0)1,%v21
 3777      000020C5 
 3778 4ee8 E0FDFFFF 		br.l	.L4.9
 3778      00000F18 
 3779              	.L4.3:
 3780 4ef0 00000000 		or	%s26,0,%s28
 3780      9C001A45 
 3781              	# line 1274
1274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t iw = 0; iw < IW; ++iw) {
 3782              		.loc	1 1274 0
 3783 4ef8 00000000 		adds.l	%s27,%fp,(59)1
 3783      3B891B59 
 3784 4f00 00000000 		muls.l	%s38,8,%s26
 3784      9A08266E 
 3785 4f08 00000000 		or	%s0,0,%s38
 3785      A6000045 
 3786 4f10 00000000 		lea	%s12,__grow_stack@LO
 3786      00000C06 
 3787 4f18 00000000 		and	%s12,%s12,(32)0
 3787      608C0C44 
 3788 4f20 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3788      8C008C06 
 3789 4f28 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3789      8C000A08 
 3790 4f30 D0000000 		lea	%s63,208
 3790      00003F06 
 3791 4f38 00000000 		adds.l	%s63,%sp,%s63
 3791      BF8B3F59 
 3792 4f40 00000000 		or	%s0,0,%s38
 3792      A6000045 
 3793 4f48 00000000 		st	%s63,0(,%s27)
 3793      9B003F11 
 3794 4f50 E0FFFFFF 		ld	%s63,-32(,%fp)	# kwb
 3794      89003F01 
 3795 4f58 B0FFFFFF 		lea	%s62,-80
 3795      00003E06 
 3796 4f60 00000000 		st	%s63,0(%s62,%fp)
 3796      89BE3F11 
 3797 4f68 00000000 		lea	%s27,__eh_curr_region@LO
 3797      00001B06 
 3798 4f70 00000000 		and	%s27,%s27,(32)0
 3798      609B1B44 
 3799 4f78 00000000 		lea.sl	%s27,__eh_curr_region@HI(,%s27)
 3799      9B009B06 
 3800 4f80 00000000 		or	%s63,3,(0)1
 3800      00033F45 
 3801 4f88 00000000 		st2b	%s63,0(,%s27)
 3801      9B003F14 
 3802 4f90 E8FFFFFF 		lea	%s63,-24
 3802      00003F06 
 3803 4f98 00000000 		adds.l	%s42,%fp,%s63
 3803      BF892A59 
 3804 4fa0 00000000 		lea	%s12,__grow_stack@LO
 3804      00000C06 
 3805 4fa8 00000000 		and	%s12,%s12,(32)0
 3805      608C0C44 
 3806 4fb0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3806      8C008C06 
 3807 4fb8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3807      8C000A08 
 3808 4fc0 D0000000 		lea	%s63,208
 3808      00003F06 
 3809 4fc8 00000000 		adds.l	%s63,%sp,%s63
 3809      BF8B3F59 
 3810 4fd0 00000000 		or	%s0,0,%s38
 3810      A6000045 
 3811 4fd8 00000000 		st	%s63,0(,%s42)
 3811      AA003F11 
 3812 4fe0 E8FFFFFF 		ld	%s63,-24(,%fp)	# kwe
 3812      89003F01 
 3813 4fe8 B8FFFFFF 		lea	%s62,-72
 3813      00003E06 
 3814 4ff0 00000000 		st	%s63,0(%s62,%fp)
 3814      89BE3F11 
 3815 4ff8 00000000 		or	%s63,4,(0)1
 3815      00043F45 
 3816 5000 00000000 		st2b	%s63,0(,%s27)
 3816      9B003F14 
 3817 5008 00000000 		adds.l	%s38,%fp,(60)1
 3817      3C892659 
 3818 5010 00000000 		lea	%s12,__grow_stack@LO
 3818      00000C06 
 3819 5018 00000000 		and	%s12,%s12,(32)0
 3819      608C0C44 
 3820 5020 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3820      8C008C06 
 3821 5028 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3821      8C000A08 
 3822 5030 D0000000 		lea	%s63,208
 3822      00003F06 
 3823 5038 00000000 		adds.l	%s63,%sp,%s63
 3823      BF8B3F59 
 3824 5040 00000000 		st	%s63,0(,%s38)
 3824      A6003F11 
 3825 5048 F0FFFFFF 		ld	%s58,-16(,%fp)	# owb
 3825      89003A01 
 3826 5050 C0FFFFFF 		lea	%s63,-64
 3826      00003F06 
 3827 5058 00000000 		st	%s58,0(%s63,%fp)
 3827      89BF3A11 
 3828 5060 00000000 		or	%s63,5,(0)1
 3828      00053F45 
 3829 5068 00000000 		st2b	%s63,0(,%s27)
 3829      9B003F14 
 3830              	# line 1275
1275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     kwe[iw] = iw + PW;
 3831              		.loc	1 1275 0
 3832 5070 E8FFFFFF 		ld	%s61,-24(,%fp)	# kwe
 3832      89003D01 
 3833 5078 E0FFFFFF 		ld	%s55,-32(,%fp)	# kwb
 3833      89003701 
 3834 5080 B8FDFFFF 		brlt.l	0,%s26,.L4.54
 3834      9A000218 
 3835 5088 58EEFFFF 		br.l	.L4.6
 3835      00000F18 
 3836              	.L4.55:
 3837 5090 60FEFFFF 		br.l	.L4.3
 3837      00000F18 
 3838              	.L4.5:
 3839              	# line 1265
1265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ohb[ih] = OH - 1;
 3840              		.loc	1 1265 0
 3841 5098 00000000 		lvl	%s62
 3841      00BE00BF 
 3842 50a0 00380037 		vadds.l	%v55,%s63,%v56
 3842      00BF208B 
 3843 50a8 00000000 		adds.l	%s49,%s61,(0)1
 3843      00BD3159 
 3844 50b0 00000000 		adds.l	%s48,%s49,%s60
 3844      BCB13059 
 3845 50b8 00000037 		vst.nc	%v55,8,%s48
 3845      B0080091 
 3846              	# line 1266
1266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
 3847              		.loc	1 1266 0
 3848 50c0 00000032 		vbrd	%v50,%s59
 3848      00BB008C 
 3849 50c8 00000000 		adds.l	%s48,%s58,(0)1
 3849      00BA3059 
 3850 50d0 00000000 		adds.l	%s47,%s48,%s60
 3850      BCB02F59 
 3851 50d8 00000032 		vst.nc	%v50,8,%s47
 3851      AF080091 
 3852              	# line 1267
1267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
 3853              		.loc	1 1267 0
 3854 50e0 00000000 		adds.l	%s47,%s49,%s60
 3854      BCB12F59 
 3855 50e8 00000031 		vld.nc	%v49,8,%s47
 3855      AF080081 
 3856 50f0 00000000 		subs.l	%s47,0,%s57
 3856      B9002F5B 
 3857 50f8 00310030 		vadds.l	%v48,%s47,%v49
 3857      00AF208B 
 3858 5100 0030002F 		vadds.l	%v47,%s56,%v48
 3858      00B8208B 
 3859 5108 00000000 		adds.l	%s47,%s55,(0)1
 3859      00B72F59 
 3860 5110 00000000 		adds.l	%s46,%s47,%s60
 3860      BCAF2E59 
 3861 5118 0000002F 		vst.nc	%v47,8,%s46
 3861      AE080091 
 3862              	# line 1268
1268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       ohb[ih] = khe[ih] / SH;
 3863              		.loc	1 1268 0
 3864 5120 002F002E 		vcmps.l	%v46,%s54,%v47
 3864      00B620BA 
 3865 5128 002E010F 		vfmk.l.gt	%vm15,%v46
 3865      000000B4 
 3866              	# line 1269
1269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       khb[ih] = khe[ih] % SH;
 3867              		.loc	1 1269 0
 3868 5130 00000000 		adds.l	%s46,%s49,%s60
 3868      BCB12E59 
 3869 5138 0000002D 		vld.nc	%v45,8,%s46
 3869      AE080081 
 3870 5140 00002D36 		vdivs.l	%v54,%v45,%s56,%vm15
 3870      00B81FFB 
 3871 5148 00000000 		adds.l	%s48,%s48,%s60
 3871      BCB03059 
 3872 5150 00000036 		vst.nc	%v54,8,%s48,%vm15
 3872      B0080F91 
 3873              	# line 1270
1270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
 3874              		.loc	1 1270 0
 3875 5158 00000000 		adds.l	%s48,%s49,%s60
 3875      BCB13059 
 3876 5160 0000002C 		vld.nc	%v44,8,%s48
 3876      B0080081 
 3877 5168 00002C35 		vdivs.l	%v53,%v44,%s56,%vm15
 3877      00B81FFB 
 3878 5170 00350034 		vmuls.l	%v52,%s56,%v53,%vm15
 3878      00B82FDB 
 3879 5178 00342C33 		vsubs.l	%v51,%v44,%v52,%vm15
 3879      00000F9B 
 3880 5180 00000000 		adds.l	%s47,%s47,%s60
 3880      BCAF2F59 
 3881 5188 00000033 		vst.nc	%v51,8,%s47,%vm15
 3881      AF080F91 
 3882              	# line 1272
1272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
 3883              		.loc	1 1272 0
 3884 5190 00000000 		adds.l	%s48,%s49,%s60
 3884      BCB13059 
 3885 5198 0000002B 		vld.nc	%v43,8,%s48
 3885      B0080081 
 3886 51a0 002B002A 		vadds.l	%v42,1,%v43
 3886      0001208B 
 3887 51a8 00000000 		adds.l	%s48,%s49,%s60
 3887      BCB13059 
 3888 51b0 0000002A 		vst.nc	%v42,8,%s48
 3888      B0080091 
 3889 51b8 002A0029 		vcmps.l	%v41,%s53,%v42
 3889      00B520BA 
 3890 51c0 0029020F 		vfmk.l.lt	%vm15,%v41
 3890      000000B4 
 3891 51c8 00000028 		vbrd	%v40,%s53
 3891      00B5008C 
 3892 51d0 00000000 		adds.l	%s49,%s49,%s60
 3892      BCB13159 
 3893 51d8 00000028 		vst.nc	%v40,8,%s49,%vm15
 3893      B1080F91 
 3894              	# line 1264
1264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khe[ih] = ih + PH;
 3895              		.loc	1 1264 0
 3896 51e0 00000000 		adds.l	%s60,%s60,%s52
 3896      B4BC3C59 
 3897 51e8 00000000 		adds.l	%s63,%s63,%s51
 3897      B3BF3F59 
 3898 51f0 00000000 		subs.l	%s50,%s50,%s62
 3898      BEB2325B 
 3899 51f8 98FEFFFF 		brge.l	0,%s50,.L4.55
 3899      B2000518 
 3900 5200 D0ECFFFF 		br.l	.L4.4
 3900      00000F18 
 3901              	.L4.56:
 3902 5208 10E4FFFF 		st	%s35,-7152(,%fp)	# spill 
 3902      89002311 
 3903 5210 B0F4FFFF 		st	%s49,-2896(,%fp)	# spill 
 3903      89003111 
 3904 5218 A0F4FFFF 		st	%s47,-2912(,%fp)	# spill 
 3904      89002F11 
 3905 5220 08E4FFFF 		st	%s40,-7160(,%fp)	# spill 
 3905      89002811 
 3906 5228 00E4FFFF 		st	%s31,-7168(,%fp)	# spill 
 3906      89001F11 
 3907 5230 00000000 		or	%s38,0,%s38
 3907      A6002645 
 3908              	# line 1266
1266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
 3909              		.loc	1 1266 0
 3910 5238 00000000 		adds.w.sx	%s49,-1,%s31
 3910      9F7F314A 
 3911 5240 00000000 		or	%s19,0,%s34
 3911      A2001345 
 3912 5248 00000000 		or	%s59,0,%s49
 3912      B1003B45 
 3913              	# line 1267
1267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
 3914              		.loc	1 1267 0
 3915 5250 00000000 		muls.w.sx	%s49,%s31,%s40
 3915      A89F314B 
 3916 5258 00000000 		or	%s20,0,%s37
 3916      A5001445 
 3917 5260 00000000 		or	%s21,0,%s41
 3917      A9001545 
 3918 5268 00000000 		or	%s57,0,%s49
 3918      B1003945 
 3919 5270 00000000 		or	%s56,0,%s40
 3919      A8003845 
 3920              	# line 1268
1268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       ohb[ih] = khe[ih] / SH;
 3921              		.loc	1 1268 0
 3922 5278 00000000 		adds.w.sx	%s40,-1,%s40
 3922      A87F284A 
 3923 5280 00000000 		or	%s31,0,%s39
 3923      A7001F45 
 3924 5288 00000000 		or	%s54,0,%s40
 3924      A8003645 
 3925              	# line 1264
1264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khe[ih] = ih + PH;
 3926              		.loc	1 1264 0
 3927 5290 00000000 		subs.l	%s26,0,%s26
 3927      9A001A5B 
 3928 5298 00000000 		or	%s32,0,%s36
 3928      A4002045 
 3929 52a0 00000000 		subs.l	%s26,0,%s26
 3929      9A001A5B 
 3930 52a8 00000000 		smvl	%s49
 3930      0000312E 
 3931 52b0 80000000 		mins.l	%s62,%s26,%s49
 3931      B19A3E68 
 3932 52b8 00000000 		or	%s50,0,%s26
 3932      9A003245 
 3933 52c0 00000000 		or	%s60,0,(0)1
 3933      00003C45 
 3934 52c8 00000000 		muls.l	%s52,8,%s62
 3934      BE08346E 
 3935 52d0 00000000 		or	%s63,0,%s38
 3935      A6003F45 
 3936 52d8 00000000 		or	%s51,0,%s62
 3936      BE003345 
 3937 52e0 00000000 		lvl	%s62
 3937      00BE00BF 
 3938 52e8 00000016 		vseq	%v22
 3938      00000099 
 3939 52f0 00160038 		vor	%v56,(0)1,%v22
 3939      000020C5 
 3940 52f8 A0FDFFFF 		br.l	.L4.5
 3940      00000F18 
 3941              	.L4.57:
 3942 5300 18ECFFFF 		st	%s63,-5096(,%fp)	# spill 
 3942      89003F11 
 3943 5308 A0F5FFFF 		st	%s0,-2656(,%fp)	# spill 
 3943      89000011 
 3944              	# line 1242
1242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int MB = p->mb;
 3945              		.loc	1 1242 0
 3946 5310 00000000 		ldl.sx	%s23,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3946      80001703 
 3947              	# line 1243
1243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int IC = p->ic;
 3948              		.loc	1 1243 0
 3949 5318 04000000 		ldl.sx	%s24,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 3949      80001803 
 3950              	# line 1244
1244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int IH = p->ih;
 3951              		.loc	1 1244 0
 3952 5320 08000000 		ldl.sx	%s63,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 3952      80003F03 
 3953              	# line 1258
1258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 3954              		.loc	1 1258 0
 3955 5328 00000000 		divs.w.sx	%s63,%s63,%s23
 3955      97BF3F7B 
 3956 5330 00000000 		or	%s22,0,%s63
 3956      BF001645 
 3957              	# line 1245
1245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int IW = p->iw;
 3958              		.loc	1 1245 0
 3959 5338 0C000000 		ldl.sx	%s25,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 3959      80001903 
 3960 5340 00000000 		or	%s26,0,%s25
 3960      99001A45 
 3961              	# line 1263
1263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t ih = 0; ih < IH; ++ih) {
 3962              		.loc	1 1263 0
 3963 5348 00000000 		muls.l	%s27,8,%s26
 3963      9A081B6E 
 3964              	# line 1246
1246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int OC = p->oc;
 3965              		.loc	1 1246 0
 3966 5350 10000000 		ldl.sx	%s28,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 3966      80001C03 
 3967              	# line 1247
1247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int OH = p->oh;
 3968              		.loc	1 1247 0
 3969 5358 14000000 		ldl.sx	%s30,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 3969      80001E03 
 3970              	# line 1260
1260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
 3971              		.loc	1 1260 0
 3972 5360 00000000 		divs.w.sx	%s63,%s30,%s23
 3972      979E3F7B 
 3973 5368 00000000 		or	%s18,0,%s63
 3973      BF001245 
 3974              	# line 1248
1248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int OW = p->ow;
 3975              		.loc	1 1248 0
 3976 5370 18000000 		ldl.sx	%s31,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 3976      80001F03 
 3977              	# line 1249
1249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int KH = p->kh;
 3978              		.loc	1 1249 0
 3979 5378 1C000000 		ldl.sx	%s33,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 3979      80002103 
 3980              	# line 1261
1261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
 3981              		.loc	1 1261 0
 3982 5380 00000000 		muls.w.sx	%s63,%s31,%s33
 3982      A19F3F4B 
 3983 5388 00000000 		or	%s34,0,%s63
 3983      BF002245 
 3984              	# line 1250
1250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int KW = p->kw;
 3985              		.loc	1 1250 0
 3986 5390 20000000 		ldl.sx	%s35,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 3986      80002303 
 3987 5398 00000000 		or	%s53,0,%s35
 3987      A3003545 
 3988              	# line 1259
1259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC / G;
 3989              		.loc	1 1259 0
 3990 53a0 00000000 		muls.l	%s63,%s22,%s53
 3990      B5963F6E 
 3991              	# line 1251
1251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int PH = p->ph;
 3992              		.loc	1 1251 0
 3993 53a8 24000000 		ldl.sx	%s36,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 3993      80002403 
 3994 53b0 00000000 		or	%s62,0,%s36
 3994      A4003E45 
 3995              	# line 1259
1259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OCOG = OC / G;
 3996              		.loc	1 1259 0
 3997 53b8 00000000 		muls.l	%s37,%s63,%s62
 3997      BEBF256E 
 3998              	# line 1252
1252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int PW = p->pw;
 3999              		.loc	1 1252 0
 4000 53c0 30000000 		ldl.sx	%s38,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 4000      80002603 
 4001              	# line 1253
1253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int SH = p->sh;
 4002              		.loc	1 1253 0
 4003 53c8 34000000 		ldl.sx	%s39,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 4003      80002703 
 4004              	# line 1254
1254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int SW = p->sw;
 4005              		.loc	1 1254 0
 4006 53d0 28000000 		ldl.sx	%s40,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 4006      80002803 
 4007              	# line 1255
1255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const int DH = p->dh + 1;
 4008              		.loc	1 1255 0
 4009 53d8 2C000000 		ldl.sx	%s41,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 4009      80002903 
 4010 53e0 00000000 		or	%s0,0,%s27
 4010      9B000045 
 4011              	# line 1263
1263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t ih = 0; ih < IH; ++ih) {
 4012              		.loc	1 1263 0
 4013 53e8 88FFFFFF 		lea	%s63,-120
 4013      00003F06 
 4014 53f0 00000000 		adds.l	%s42,%fp,%s63
 4014      BF892A59 
 4015 53f8 00000000 		lea	%s12,__grow_stack@LO
 4015      00000C06 
 4016 5400 00000000 		and	%s12,%s12,(32)0
 4016      608C0C44 
 4017 5408 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4017      8C008C06 
 4018 5410 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4018      8C000A08 
 4019 5418 D0000000 		lea	%s63,208
 4019      00003F06 
 4020 5420 00000000 		adds.l	%s63,%sp,%s63
 4020      BF8B3F59 
 4021 5428 00000000 		lea	%s62,0
 4021      00003E06 
 4022 5430 00000000 		or	%s0,0,%s27
 4022      9B000045 
 4023 5438 00000000 		st	%s63,0(,%s42)
 4023      AA003F11 
 4024 5440 88FFFFFF 		ld	%s63,-120(,%fp)	# khb
 4024      89003F01 
 4025 5448 18ECFFFF 		ld	%s60,-5096(,%fp)	# restore 
 4025      89003C01 
 4026 5450 98FFFFFF 		st	%s63,-104(,%fp)
 4026      89003F11 
 4027 5458 00000000 		st2b	%s62,0(,%s60)
 4027      BC003E14 
 4028 5460 90FFFFFF 		lea	%s63,-112
 4028      00003F06 
 4029 5468 00000000 		adds.l	%s42,%fp,%s63
 4029      BF892A59 
 4030 5470 00000000 		lea	%s12,__grow_stack@LO
 4030      00000C06 
 4031 5478 00000000 		and	%s12,%s12,(32)0
 4031      608C0C44 
 4032 5480 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4032      8C008C06 
 4033 5488 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4033      8C000A08 
 4034 5490 D0000000 		lea	%s63,208
 4034      00003F06 
 4035 5498 00000000 		adds.l	%s63,%sp,%s63
 4035      BF8B3F59 
 4036 54a0 18ECFFFF 		ld	%s62,-5096(,%fp)	# restore 
 4036      89003E01 
 4037 54a8 00000000 		or	%s0,0,%s27
 4037      9B000045 
 4038 54b0 00000000 		st	%s63,0(,%s42)
 4038      AA003F11 
 4039 54b8 90FFFFFF 		ld	%s63,-112(,%fp)	# khe
 4039      89003F01 
 4040 54c0 A0FFFFFF 		lea	%s60,-96
 4040      00003C06 
 4041 54c8 00000000 		st	%s63,0(%s60,%fp)
 4041      89BC3F11 
 4042 54d0 00000000 		or	%s63,1,(0)1
 4042      00013F45 
 4043 54d8 00000000 		st2b	%s63,0(,%s62)
 4043      BE003F14 
 4044 54e0 D8FFFFFF 		lea	%s63,-40
 4044      00003F06 
 4045 54e8 00000000 		adds.l	%s27,%fp,%s63
 4045      BF891B59 
 4046 54f0 00000000 		lea	%s12,__grow_stack@LO
 4046      00000C06 
 4047 54f8 00000000 		and	%s12,%s12,(32)0
 4047      608C0C44 
 4048 5500 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4048      8C008C06 
 4049 5508 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4049      8C000A08 
 4050 5510 D0000000 		lea	%s63,208
 4050      00003F06 
 4051 5518 00000000 		adds.l	%s63,%sp,%s63
 4051      BF8B3F59 
 4052 5520 18ECFFFF 		ld	%s62,-5096(,%fp)	# restore 
 4052      89003E01 
 4053 5528 00000000 		st	%s63,0(,%s27)
 4053      9B003F11 
 4054 5530 D8FFFFFF 		ld	%s58,-40(,%fp)	# ohb
 4054      89003A01 
 4055 5538 A8FFFFFF 		lea	%s63,-88
 4055      00003F06 
 4056 5540 00000000 		st	%s58,0(%s63,%fp)
 4056      89BF3A11 
 4057 5548 00000000 		or	%s63,2,(0)1
 4057      00023F45 
 4058 5550 00000000 		st2b	%s63,0(,%s62)
 4058      BE003F14 
 4059              	# line 1264
1264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     khe[ih] = ih + PH;
 4060              		.loc	1 1264 0
 4061 5558 90FFFFFF 		ld	%s61,-112(,%fp)	# khe
 4061      89003D01 
 4062 5560 88FFFFFF 		ld	%s55,-120(,%fp)	# khb
 4062      89003701 
 4063 5568 A0FCFFFF 		brlt.l	0,%s26,.L4.56
 4063      9A000218 
 4064 5570 08E9FFFF 		br.l	.L4.2
 4064      00000F18 
 4065              	.L4.58:
 4066 5578 D0000000 		br.l	.L4.59
 4066      00000F18 
 4067              	.L4.1:
 4068              	# line 1215
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // FIXME can we call this even less?
 4069              		.loc	1 1215 0
 4070 5580 3C000000 		ldl.sx	%s18,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 4070      80001203 
 4071 5588 F0FFFFFF 		brne.w	0,%s18,.L4.58
 4071      92008318 
 4072 5590 70FDFFFF 		br.l	.L4.57
 4072      00000F18 
 4073              	.L4.17:
 4074              	# line 1363
1363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 4075              		.loc	1 1363 0
 4076              	# Start of epilogue codes
 4077 5598 30000000 		ld	%s18,48(,%fp)
 4077      89001201 
 4078 55a0 38000000 		ld	%s19,56(,%fp)
 4078      89001301 
 4079 55a8 40000000 		ld	%s20,64(,%fp)
 4079      89001401 
 4080 55b0 48000000 		ld	%s21,72(,%fp)
 4080      89001501 
 4081 55b8 50000000 		ld	%s22,80(,%fp)
 4081      89001601 
 4082 55c0 58000000 		ld	%s23,88(,%fp)
 4082      89001701 
 4083 55c8 60000000 		ld	%s24,96(,%fp)
 4083      89001801 
 4084 55d0 68000000 		ld	%s25,104(,%fp)
 4084      89001901 
 4085 55d8 70000000 		ld	%s26,112(,%fp)
 4085      89001A01 
 4086 55e0 78000000 		ld	%s27,120(,%fp)
 4086      89001B01 
 4087 55e8 80000000 		ld	%s28,128(,%fp)
 4087      89001C01 
 4088 55f0 88000000 		ld	%s29,136(,%fp)
 4088      89001D01 
 4089 55f8 90000000 		ld	%s30,144(,%fp)
 4089      89001E01 
 4090 5600 98000000 		ld	%s31,152(,%fp)
 4090      89001F01 
 4091 5608 A0000000 		ld	%s32,160(,%fp)
 4091      89002001 
 4092 5610 A8000000 		ld	%s33,168(,%fp)
 4092      89002101 
 4093 5618 00000000 		or	%sp,0,%fp
 4093      89000B45 
 4094              		.cfi_def_cfa	11,8
 4095 5620 18000000 		ld	%got,0x18(,%sp)
 4095      8B000F01 
 4096 5628 20000000 		ld	%plt,0x20(,%sp)
 4096      8B001001 
 4097 5630 08000000 		ld	%lr,0x8(,%sp)
 4097      8B000A01 
 4098 5638 00000000 		ld	%fp,0x0(,%sp)
 4098      8B000901 
 4099 5640 00000000 		b.l	(,%lr)
 4099      8A000F19 
 4100              	.L4.59:
 4101              	# line 769
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // shorten, do same for kw,ow loop. tweaks to kh calc
 4102              		.loc	1 769 0
 4103 5648 00000000 		lea	%s12,conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 4103      00000C06 
 4104 5650 00000000 		and	%s12,%s12,(32)0
 4104      608C0C44 
 4105 5658 00000000 		lea.sl	%s12,conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s12)
 4105      8C008C06 
 4106 5660 00000000 		bsic	%lr,(,%s12)	# conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 4106      8C000A08 
 4107 5668 30FEFFFF 		ld2b.zx	%s63,-464(,%fp)
 4107      8900BF04 
 4108 5670 00000000 		lea	%s62,__eh_curr_region@LO
 4108      00003E06 
 4109 5678 00000000 		and	%s62,%s62,(32)0
 4109      60BE3E44 
 4110 5680 00000000 		lea.sl	%s62,__eh_curr_region@HI(,%s62)
 4110      BE00BE06 
 4111 5688 00000000 		st2b	%s63,0(,%s62)
 4111      BE003F14 
 4112 5690 08FEFFFF 		ld	%s63,-504(,%fp)
 4112      89003F01 
 4113 5698 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 4113      00003E06 
 4114 56a0 00000000 		and	%s62,%s62,(32)0
 4114      60BE3E44 
 4115 56a8 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 4115      BE00BE06 
 4116 56b0 00000000 		st	%s63,0(,%s62)
 4116      BE003F11 
 4117 56b8 E0FEFFFF 		br.l	.L4.17
 4117      00000F18 
 4118              	.L4.0:
 4119 56c0 88FFFFFF 		br.l	.L4.59
 4119      00000F18 
 4120              		.cfi_endproc
 4121              		.set	.L.5.2auto_size,	0xffffffffffffc930	# 14032 Bytes
 4123              	# ============ End  conv::sxconv_4_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 4124              	# ============ Begin  conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 4125              		.data
 4126              		.balign 16
 4129              	.LP._ZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 4130 0150 00000000 		.long	__vla_dealloc_eh
 4130      00000000 
 4131 0158 0000     		.zero	2
 4132 015a FFFF     		.short	65535
 4133 015c 04       		.byte	4
 4134 015d 000000   		.zero	3
 4135 0160 00000000 		.long	__vla_dealloc_eh
 4135      00000000 
 4136 0168 0100     		.short	1
 4137 016a 0000     		.zero	2
 4138 016c 04       		.byte	4
 4139 016d 000000   		.zero	3
 4140 0170 00000000 		.long	__vla_dealloc_eh
 4140      00000000 
 4141 0178 0200     		.short	2
 4142 017a 0100     		.short	1
 4143 017c 04       		.byte	4
 4144 017d 000000   		.zero	3
 4145              		.section .rodata
 4146              		.balign 16
 4148              	.LP._ZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.ohw_muls.__initializer.2:
 4149 00f0 0000803F 		.int	1065353216
 4150 00f4 00000000 		.zero	4
 4151 00f8 00008047 		.int	1199570944
 4152 00fc 00000000 		.zero	4
 4153              		.text
 4154 56c8 00000000 		.balign 16
 4154      00000000 
 4155              	# line 1391
1391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t G = p->g;
 4156              		.loc	1 1391 0
 4157              		.globl	conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 4159              	conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 4160              		.cfi_startproc
 4161 56d0 00000000 		st	%fp,0x0(,%sp)
 4161      8B000911 
 4162              		.cfi_def_cfa_offset	0
 4163              		.cfi_offset	9,0
 4164 56d8 08000000 		st	%lr,0x8(,%sp)
 4164      8B000A11 
 4165 56e0 18000000 		st	%got,0x18(,%sp)
 4165      8B000F11 
 4166 56e8 20000000 		st	%plt,0x20(,%sp)
 4166      8B001011 
 4167 56f0 00000000 		or	%fp,0,%sp
 4167      8B000945 
 4168              		.cfi_def_cfa_register	9
 4169 56f8 30000000 		st	%s18,48(,%fp)
 4169      89001211 
 4170 5700 38000000 		st	%s19,56(,%fp)
 4170      89001311 
 4171 5708 40000000 		st	%s20,64(,%fp)
 4171      89001411 
 4172 5710 48000000 		st	%s21,72(,%fp)
 4172      89001511 
 4173 5718 50000000 		st	%s22,80(,%fp)
 4173      89001611 
 4174 5720 58000000 		st	%s23,88(,%fp)
 4174      89001711 
 4175 5728 60000000 		st	%s24,96(,%fp)
 4175      89001811 
 4176 5730 68000000 		st	%s25,104(,%fp)
 4176      89001911 
 4177 5738 70000000 		st	%s26,112(,%fp)
 4177      89001A11 
 4178 5740 78000000 		st	%s27,120(,%fp)
 4178      89001B11 
 4179 5748 80000000 		st	%s28,128(,%fp)
 4179      89001C11 
 4180 5750 88000000 		st	%s29,136(,%fp)
 4180      89001D11 
 4181 5758 90000000 		st	%s30,144(,%fp)
 4181      89001E11 
 4182 5760 98000000 		st	%s31,152(,%fp)
 4182      89001F11 
 4183 5768 A0000000 		st	%s32,160(,%fp)
 4183      89002011 
 4184 5770 A8000000 		st	%s33,168(,%fp)
 4184      89002111 
 4185 5778 60E9FFFF 		lea	%s13,.L.6.2auto_size&0xffffffff
 4185      00000D06 
 4186 5780 00000000 		and	%s13,%s13,(32)0
 4186      608D0D44 
 4187 5788 FFFFFFFF 		lea.sl	%sp,.L.6.2auto_size>>32(%fp,%s13)
 4187      8D898B06 
 4188 5790 48000000 		brge.l.t	%sp,%sl,.L5.EoP
 4188      888B3518 
 4189 5798 18000000 		ld	%s61,0x18(,%tp)
 4189      8E003D01 
 4190 57a0 00000000 		or	%s62,0,%s0
 4190      80003E45 
 4191 57a8 3B010000 		lea	%s63,0x13b
 4191      00003F06 
 4192 57b0 00000000 		shm.l	%s63,0x0(%s61)
 4192      BD033F31 
 4193 57b8 08000000 		shm.l	%sl,0x8(%s61)
 4193      BD030831 
 4194 57c0 10000000 		shm.l	%sp,0x10(%s61)
 4194      BD030B31 
 4195 57c8 00000000 		monc
 4195      0000003F 
 4196 57d0 00000000 		or	%s0,0,%s62
 4196      BE000045 
 4197              	.L5.EoP:
 4198              	# End of prologue codes
 4199 57d8 A0F4FFFF 		st	%s0,-2912(,%fp)	# spill 
 4199      89000011 
 4200 57e0 00000000 		lea	%s63,__curr_eh_stack_entry@LO
 4200      00003F06 
 4201 57e8 00000000 		and	%s63,%s63,(32)0
 4201      60BF3F44 
 4202 57f0 00000000 		lea.sl	%s63,__curr_eh_stack_entry@HI(,%s63)
 4202      BF00BF06 
 4203 57f8 00000000 		ld	%s60,0(,%s63)
 4203      BF003C01 
 4204 5800 38FEFFFF 		st	%s60,-456(,%fp)
 4204      89003C11 
 4205 5808 38FEFFFF 		lea	%s60,-456
 4205      00003C06 
 4206 5810 00000000 		adds.l	%s60,%fp,%s60
 4206      BC893C59 
 4207 5818 00000000 		st	%s60,0(,%s63)
 4207      BF003C11 
 4208 5820 00000000 		or	%s63,1,(0)1
 4208      00013F45 
 4209 5828 40FEFFFF 		st1b	%s63,-448(,%fp)
 4209      89003F15 
 4210              	# line 1392
1392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t MB = p->mb;
 4211              		.loc	1 1392 0
 4212 5830 00000000 		ldl.sx	%s63,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 4212      80003F03 
 4213 5838 00000000 		or	%s23,0,%s63
 4213      BF001745 
 4214 5840 00000000 		lea	%s63,.LP._ZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 4214      00003F06 
 4215 5848 00000000 		and	%s63,%s63,(32)0
 4215      60BF3F44 
 4216 5850 00000000 		lea.sl	%s63,.LP._ZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s63)
 4216      BF00BF06 
 4217 5858 48FEFFFF 		st	%s63,-440(,%fp)
 4217      89003F11 
 4218 5860 B0FFFFFF 		lea	%s63,-80
 4218      00003F06 
 4219 5868 00000000 		adds.l	%s63,%fp,%s63
 4219      BF893F59 
 4220 5870 50FEFFFF 		st	%s63,-432(,%fp)
 4220      89003F11 
 4221 5878 00000000 		lea	%s24,__eh_curr_region@LO
 4221      00001806 
 4222 5880 00000000 		and	%s24,%s24,(32)0
 4222      60981844 
 4223 5888 00000000 		lea.sl	%s24,__eh_curr_region@HI(,%s24)
 4223      98009806 
 4224 5890 00000000 		ld2b.zx	%s63,0(,%s24)
 4224      9800BF04 
 4225 5898 60FEFFFF 		st2b	%s63,-416(,%fp)
 4225      89003F14 
 4226 58a0 FFFF0000 		lea	%s63,65535
 4226      00003F06 
 4227 58a8 00000000 		st2b	%s63,0(,%s24)
 4227      98003F14 
 4228              	# line 1393
1393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IC = p->ic;
 4229              		.loc	1 1393 0
 4230 58b0 04000000 		ldl.sx	%s63,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 4230      80003F03 
 4231 58b8 00000000 		or	%s63,0,%s63
 4231      BF003F45 
 4232 58c0 30FEFFFF 		st	%s63,-464(,%fp)	# MB
 4232      89003F11 
 4233              	# line 1422
1422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
 4234              		.loc	1 1422 0
 4235 58c8 30FEFFFF 		lea	%s63,-464
 4235      00003F06 
 4236 58d0 00000000 		adds.l	%s63,%fp,%s63
 4236      BF893F59 
 4237              	# line 1394
1394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH = p->ih;
 4238              		.loc	1 1394 0
 4239 58d8 08000000 		ldl.sx	%s60,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 4239      80003C03 
 4240 58e0 00000000 		or	%s25,0,%s60
 4240      BC001945 
 4241              	# line 1408
1408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 4242              		.loc	1 1408 0
 4243 58e8 00000000 		divs.l	%s19,%s25,%s23
 4243      9799137F 
 4244              	# line 1395
1395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IW = p->iw;
 4245              		.loc	1 1395 0
 4246 58f0 0C000000 		ldl.sx	%s60,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 4246      80003C03 
 4247 58f8 00000000 		or	%s26,0,%s60
 4247      BC001A45 
 4248              	# line 1396
1396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OC = p->oc;
 4249              		.loc	1 1396 0
 4250 5900 10000000 		ldl.sx	%s60,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 4250      80003C03 
 4251 5908 00000000 		or	%s27,0,%s60
 4251      BC001B45 
 4252              	# line 1413
1413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH_KW = KH * KW;
 4253              		.loc	1 1413 0
 4254 5910 00000000 		muls.l	%s61,%s26,%s27
 4254      9B9A3D6E 
 4255              	# line 1397
1397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH = p->oh;
 4256              		.loc	1 1397 0
 4257 5918 14000000 		ldl.sx	%s60,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 4257      80003C03 
 4258 5920 00000000 		or	%s60,0,%s60
 4258      BC003C45 
 4259              	# line 1410
1410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH_OW = OH * OW;
 4260              		.loc	1 1410 0
 4261 5928 00000000 		divs.l	%s20,%s60,%s23
 4261      97BC147F 
 4262              	# line 1397
1397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OH = p->oh;
 4263              		.loc	1 1397 0
 4264 5930 28FEFFFF 		st	%s60,-472(,%fp)	# OC
 4264      89003C11 
 4265              	# line 1422
1422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
 4266              		.loc	1 1422 0
 4267 5938 28FEFFFF 		lea	%s59,-472
 4267      00003B06 
 4268 5940 00000000 		adds.l	%s59,%fp,%s59
 4268      BB893B59 
 4269              	# line 1398
1398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OW = p->ow;
 4270              		.loc	1 1398 0
 4271 5948 18000000 		ldl.sx	%s58,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 4271      80003A03 
 4272 5950 00000000 		or	%s58,0,%s58
 4272      BA003A45 
 4273 5958 20FEFFFF 		st	%s58,-480(,%fp)	# OH
 4273      89003A11 
 4274              	# line 1422
1422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
 4275              		.loc	1 1422 0
 4276 5960 20FEFFFF 		lea	%s56,-480
 4276      00003806 
 4277 5968 00000000 		adds.l	%s56,%fp,%s56
 4277      B8893859 
 4278              	# line 1399
1399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH = p->kh;
 4279              		.loc	1 1399 0
 4280 5970 1C000000 		ldl.sx	%s55,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 4280      80003703 
 4281 5978 00000000 		or	%s55,0,%s55
 4281      B7003745 
 4282              	# line 1411
1411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t OC_OH_OW = OC * OH_OW;
 4283              		.loc	1 1411 0
 4284 5980 00000000 		muls.l	%s18,%s58,%s55
 4284      B7BA126E 
 4285              	# line 1412
1412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t IH_IW = IH * IW;
 4286              		.loc	1 1412 0
 4287 5988 00000000 		muls.l	%s28,%s60,%s18
 4287      92BC1C6E 
 4288              	# line 2396
1459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //memset( (float*)diff_bia_m, 0, diff_bia_m.size() ); // single loop, always equiv
1461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   //zero_bia(p, diff_bia_m);
1462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 0 // A1,A3 x86 cf. sx3 : 9.6, 8.0   (sxconv3: 7.1, 19.3)   x86:8.5,7.7,1.1
1463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
1464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
1465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(3))//;
1466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
1469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t wei_off00 = ((((size_t)g * OCOG + oc) * ICOG + ic) * KH + 0) * KW + 0;
1470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t kh = 0; kh < KH; ++kh) {
1471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t kw = 0; kw < KW; ++kw) {
1472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off00 + kh*KW + kw] = 0.f;
1473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
1479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(4))//;
1480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         //for (ssize_t ic = 0; ic < IC/G; ++ic)
1483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t kh = 0; kh < p->kh; ++kh) {
1484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t kw = 0; kw < KW; ++kw) {
1485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
1486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               // SX TODO simplify these to positive-integer solutions !!!
1487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ssize_t oh_beg, oh_end;
1488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
1489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
1490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
1491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (oh_end > OH) oh_end = OH;
1492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 0 // establish non-negative equivalencies
1493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( (oh_beg >= 1) == (kh*DH < PH) );
1494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( (oh_end >= 1) == (kh*DH < IH+PH) );
1495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( (oh_end >= OH) == (kh*DH + OH*SH < IH+PH+SH) ); // ???
1496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               size_t ohb2 = 0;
1497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if( kh*DH < PH ) ohb2 = ((PH-kh*DH) + SH-1)/ SH;
1498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( ohb2 == oh_beg );
1499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               size_t ohe2 = 0;
1500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if( kh*DH < IH+PH ) {
1501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohe2 = ((IH + PH - kh*DH) + SH-1) / SH;
1502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 RT_ASSERT( ohe2 >= 1 );
1503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if( ohe2 >= OH ) {
1505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohe2 = OH;
1506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 RT_ASSERT( (kh*DH + OH*SH < IH+PH+SH) );
1507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               // note: oh_end from div_floor and signed integer was allowed to be -ve
1509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               RT_ASSERT( (oh_end<0 && ohe2==0) || (oh_end>=0 && ohe2==oh_end ) );
1510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ssize_t ow_beg, ow_end;
1512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
1513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
1514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
1515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ow_end > OW) ow_end = OW;
1516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
1517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
1518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const size_t ow_emb = ow_end - ow_beg;
1519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               float dw_ic[ICOG];
1521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //float dw_ic[ICOG][MB];
1522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
1523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 float tmp = 0.f;
1524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t mb = 0; mb < MB; ++mb) {
1525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t oh = oh_beg; oh < oh_end; ++oh) {
1526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     const size_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh) * OW + ow_beg;
1527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     const ssize_t ih = ih0 + oh * SH;
1528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     const size_t iw_beg = ow_beg * SW - PW + kw * DW;
1529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + iw_beg
1530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + ow_b
1531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     for (size_t ow = 0; ow < ow_emb; ++ow) {
1532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                      tmp += pdiff_dst[dst_off_beg+ow] * psrc[src_off_beg + ow*SW];
1533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
1534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 dw_ic[ic] = tmp;
1537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
1539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic){
1540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
1541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
1549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       OMP(for collapse(2) nowait)//;
1550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t g = 0; g < G; ++g) {
1551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t oc = 0; oc < OCOG; ++oc) {
1552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t bia_off = bia_off_f(p, g, oc);
1553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
1554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           db = 0;
1555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t mb = 0; mb < MB; ++mb) {
1556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t oh = 0; oh < OH; ++oh) {
1558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t ow = 0; ow < OW; ++ow) {
1559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 db += pdiff_dst[dst_off00 + oh*OW + ow];
1560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // x86 9.9, 9.0   x86:8.4,7.4,1.8
1568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
1569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(4))//;
1570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
1571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
1572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t kh = 0; kh < p->kh; ++kh) {
1573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t kw = 0; kw < KW; ++kw) {
1574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
1575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t oh_beg, oh_end;
1576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
1577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
1578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
1579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_end > OH) oh_end = OH;
1580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t ow_beg, ow_end;
1581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
1582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
1583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
1584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_end > OW) ow_end = OW;
1585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
1586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
1587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const size_t ow_emb = ow_end - ow_beg;
1588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           float dw_ic[ICOG];
1590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
1591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
1592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) {
1593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               float tmp = 0.f;
1594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
1595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = oh_beg; oh < oh_end; ++oh) {
1596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   const size_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh) * OW + ow_beg;
1597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   const ssize_t ih = ih0 + oh * SH;
1598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   const size_t iw_beg = ow_beg * SW - PW + kw * DW;
1599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + iw_beg;
1600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   //const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + ow_beg
1601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < ow_emb; ++ow) {
1602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp += pdiff_dst[dst_off_beg+ow] * psrc[src_off_beg + ow*SW];
1603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               dw_ic[ic] = tmp;
1607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
1610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
1611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
1612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   if ((p->dir & FLAG_BIA)) {
1620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(2) nowait)//;
1621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ssize_t bia_off = bia_off_f(p, g, oc);
1624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         float &db = ((float*)diff_bia_m)[bia_off];
1625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         db = 0;
1626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
1627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
1629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
1630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               db += pdiff_dst[dst_off00 + oh*OW + ow];
1631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // x86 6.0, 8.2 x86:8.8,7.2,1.8
1638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
1639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(4))//;
1640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
1641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
1642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
1643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
1645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t oh_beg, oh_end;
1646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
1647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
1648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
1649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_end > OH) oh_end = OH;
1650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t ow_beg, ow_end;
1651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
1652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
1653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
1654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_end > OW) ow_end = OW;
1655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
1656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
1657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           float dw_ic[ICOG];
1659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
1660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
1661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ow_end -= ow_beg;
1662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             oh_end -= oh_beg;
1663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
1664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW 
1665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) {
1666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               float tmp = 0.f;
1667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
1668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //const ssize_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_b
1669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
1670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //const ssize_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + (ih0+oh_beg*SH)) *
1671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t src_off_beg = s00 + mb*IC*IH*IW + ic*IH*IW;
1672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
1673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < oh_end; ++oh) {
1674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < ow_end; ++ow) {
1675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW];
1676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0
1679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 if(oh_end < 256 && ow_end < 256){ // ShortLoop is faster, but speed destroyed by 'i
1680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   ShortLoop() for (ssize_t oh = 0; oh < oh_end; ++oh) {
1681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     ShortLoop() for (size_t ow = 0; ow < ow_end; ++ow) {
1682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW]
1683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
1684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }else{
1686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t oh = 0; oh < oh_end; ++oh) {
1687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     for (size_t ow = 0; ow < ow_end; ++ow) {
1688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW]
1689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
1690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // slower
1693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 float s[oh_end*ow_end];
1694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 float d[oh_end*ow_end];
1695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < oh_end; ++oh) {
1696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < ow_end; ++ow) {
1697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     d[oh*ow_end+ow] = pdiff_dst[dst_off_beg + oh*OW + ow];
1698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     s[oh*ow_end+ow] = psrc[src_off_beg + oh*SH_IW + ow*SW];
1699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t o = 0; o < ow_end*oh_end; ++o) {
1702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   tmp += d[o] * s[o];
1703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // very slow
1705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 float s[OH][OW], d[OH][OW];
1706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh) {
1707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
1708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     d[oh][ow] = (oh<oh_end && ow<ow_end ? pdiff_dst[dst_off_beg + oh*OW + ow]: 0.f)
1709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     s[oh][ow] = (oh<oh_end && ow<ow_end ? psrc[src_off_beg + oh*SH_IW + ow*SW]: 0.f
1710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh)
1713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow)
1714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmp += d[oh][ow] * s[oh][ow];
1715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               dw_ic[ic] = tmp;
1718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
1721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
1722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
1723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   if ((p->dir & FLAG_BIA)) {
1731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(2) nowait)//;
1732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ssize_t bia_off = bia_off_f(p, g, oc);
1735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         float &db = ((float*)diff_bia_m)[bia_off];
1736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         db = 0;
1737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
1738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
1740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
1741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               db += pdiff_dst[dst_off00 + oh*OW + ow];
1742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // loop order change, much better 24x for regr.sh BWD_WB (x86:6.9,19.3)  // XXX FAIL GOOD f
1749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
1750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(4))//;
1751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
1752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
1753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
1754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
1756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t oh_beg, oh_end;
1757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
1758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
1759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
1760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_end > OH) oh_end = OH;
1761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t ow_beg, ow_end;
1762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
1763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
1764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
1765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_end > OW) ow_end = OW;
1766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           float dw_ic[ICOG];
1767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
1768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
1769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ow_end -= ow_beg;
1770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             oh_end -= oh_beg;
1771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
1772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW 
1773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t mb = 0; mb < MB; ++mb) {
1774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
1775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s0 = s00 + mb*IC*IH*IW;
1776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t oh = 0; oh < oh_end; ++oh) {
1777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (size_t ow = 0; ow < ow_end; ++ow) {
1778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ic = 0; ic < ICOG; ++ic) {
1779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     dw_ic[ic] += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[s0+ic*IH*IW + oh*SH_IW + ow
1780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     // slower ...
1781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //dw_ic[ic] += pdiff_dst[d0+mb*OC*OH*OW + oh*OW+ow] * psrc[s00+mb*IC*IH*IW + ic
1782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
1788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
1789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
1790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   if ((p->dir & FLAG_BIA)) {
1797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(2) nowait)//;
1798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const ssize_t bia_off = bia_off_f(p, g, oc);
1801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         pdiff_bia[bia_off] = 0.f;
1802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
1804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
1806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
1807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
1808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
1809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // BWD_W SX 24.2x FAIL
1816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // loop order change, much better 24x for regr.sh BWD_WB (x86:7.9,19.1)
1817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
1818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(4))//;
1819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
1820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
1821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
1822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
1824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 // SX 24.5x BWD_WB regr.sh  x86:7.6,13.2,1.73
1825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t oh_beg, oh_end;
1826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
1827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
1828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
1829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (oh_end > OH) oh_end = OH;
1830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t ow_beg, ow_end;
1831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
1832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
1833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
1834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_end > OW) ow_end = OW;
1835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
1836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1 // SX 24.3x  x86:6.9,16.2 // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< XXX x86 XXX
1837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // equiv, but OK for unsigned hoist_t and "normal" division op
1838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
1839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           hoist_t oh_beg = 0, oh_end=0;
1840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
1841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
1842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( oh_end >= OH ) oh_end = OH;
1843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           hoist_t ow_beg = 1, ow_end=0;
1844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
1845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
1846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( ow_end >= OW ) ow_end = OW;
1847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // SX 24.1x  x86:6.8,12.3
1848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t oh_beg = ( kh*DH < PH ? ((PH-kh*DH) + SH-1)/ SH : 0 );
1849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t oh_end = ( kh*DH < IH+PH ? ((IH + PH - kh*DH) + SH-1) / SH : 0 );
1850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( oh_end >= OH ) oh_end = OH;
1851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t ow_beg = ( kw*DW < PW ? ((PW-kw*DW) + SW-1)/ SW : 0 );
1852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ssize_t ow_end = ( kw*DW < IW+PW ? ((IW + PW - kw*DW) + SW-1) / SW : 0 );
1853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( ow_end >= OW ) ow_end = OW;
1854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           float dw_ic[ICOG];
1856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
1857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
1858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ow_end -= ow_beg;
1859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             oh_end -= oh_beg;
1860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
1861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW 
1862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t mb = 0; mb < MB; ++mb) {
1863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
1864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s0 = s00 + mb*IC*IH*IW;
1865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t oh = 0; oh < oh_end; ++oh) {
1866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (size_t ow = 0; ow < ow_end; ++ow) {
1867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ic = 0; ic < ICOG; ++ic) {
1868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     // pdiff_dst is always readable, even if not used
1869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     dw_ic[ic] += psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW] * pdiff_dst[dst_off_beg+oh*OW
1870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
1876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
1877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
1878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   if ((p->dir & FLAG_BIA)) {
1885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(for collapse(2) nowait)//;
1886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const ssize_t bia_off = bia_off_f(p, g, oc);
1889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         pdiff_bia[bia_off] = 0.f;
1890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
1892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
1893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
1894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
1895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
1896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
1897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // A1,A3 SX 1.5,1.1     x86:6.9,13.1
1904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
1905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel for collapse(4))//;
1906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   for (ssize_t g = 0; g < G; ++g) {
1907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
1908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
1909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
1911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // conditionals --> loop limit calculations   "hoisting"
1913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           // equiv, but OK for unsigned hoist_t and "normal" division op
1914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
1915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           hoist_t oh_beg = 0, oh_end=0;
1916:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
1917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
1918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( oh_end >= OH ) oh_end = OH;
1919:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           hoist_t ow_beg = 0, ow_end=0;
1920:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
1921:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
1922:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if( ow_end >= OW ) ow_end = OW;
1923:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1924:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           float dw_ic[ICOG];
1925:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
1926:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
1927:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             ow_end -= ow_beg;
1928:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             oh_end -= oh_beg;
1929:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
1930:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW 
1931:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t mb = 0; mb < MB; ++mb) {
1932:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
1933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s0 = s00 + mb*IC*IH*IW;
1934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t oh = 0; oh < oh_end; ++oh) {
1935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (size_t ow = 0; ow < ow_end; ++ow) {
1936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ic = 0; ic < ICOG; ++ic) {
1937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     // pdiff_dst is always readable, even if not used
1938:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     dw_ic[ic] += psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW] * pdiff_dst[dst_off_beg+oh*OW
1939:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
1940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
1941:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
1942:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
1943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
1945:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
1946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
1947:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
1948:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1949:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
1950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
1951:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
1952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
1953:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   bwd_w_bias_update( p, diff_bia_m, diff_dst_m);
1954:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // A1,A3 SX 1.5,1.1       x86:HORRIBLE
1955:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
1956:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
1957:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
1958:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     bool ook[OH*OW];
1959:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** RETAIN(ook)
1960:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int ohw_off[OH*OW];
1961:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** RETAIN(ohw_off)
1962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float tmpsrc[OH*OW];
1963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
1964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(tmpsrc)
1965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(tmpsrc)
1967:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float dw_ic[ICOG];
1969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
1970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(dw_ic)
1971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1972:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(dw_ic)
1973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash;
1975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash_prv = -1;
1976:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_begend[4];
1977:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
1978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_begend)
1979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_begend)
1981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_muls[4] = {1, OH, (1<<16), (1<<16)*OW};
1983:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
1984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_muls)
1985:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
1986:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_muls)
1987:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
1988:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1989:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(parallel for collapse(4))//;
1990:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1991:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
1992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
1993:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1994:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
1995:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
1996:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // conditionals --> loop limit calculations   "hoisting"
1997:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // equiv, but OK for unsigned hoist_t and "normal" division op
1998:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
1999:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t oh_beg = 0, oh_end=0;
2000:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
2001:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
2002:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( oh_end >= OH ) oh_end = OH;
2003:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t ow_beg = 0, ow_end=0;
2004:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
2005:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
2006:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( ow_end >= OW ) ow_end = OW;
2007:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2008:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //float dw_ic[ICOG];
2009:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2010:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (ow_beg < ow_end && oh_beg < oh_end) {
2011:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //ow_end -= ow_beg;
2012:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //oh_end -= oh_beg;
2013:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
2014:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               //const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg
2015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+0*SH)) * IW + 0*SW - PW + k
2017:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[0] = oh_beg;
2019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[1] = oh_end;
2020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[2] = ow_beg;
2021:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[3] = ow_end;
2022:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohash = 0;
2023:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (size_t i=0; i<4; ++i)
2024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohash += ohw_begend[i] * ohw_muls[i];
2025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
2026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohash_prv = ohash;
2027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //bool ook[OH*OW];
2028:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 //ssize_t ohw_off[OH*OW]
2029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh) {
2030:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
2031:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     //ook[oh*OW+ow] = (oh>=oh_beg && ow>=ow_beg) && (oh<oh_end && ow<ow_end);
2032:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if ( (oh>=oh_beg && ow>=ow_beg) && (oh<oh_end && ow<ow_end) )
2033:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = (int)(oh*SH_IW + ow*SW);
2034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     else
2035:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = -1;
2036:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2037:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2038:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
2042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t s0 = s00 + mb*IC*IH*IW;
2043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
2044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t oh = 0; oh < OH; ++oh) {
2045:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     for (size_t ow = 0; ow < OW; ++ow) {
2046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       // is pdiff_dst readable, even if not used ? YES (as suspected)
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       // yes RT_ASSERT( dst_off_beg + oh*OW + ow >= 0 );
2048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       // yes RT_ASSERT( dst_off_beg + oh*OW + ow < MB*G*OCOG*OH*OW );
2049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       // yes RT_ASSERT( s0+ic*IH*IW + oh*SH_IW + ow*SW >= 0 );
2050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       // FALSE ... RT_ASSERT( s0+ic*IH*IW + oh*SH_IW + ow*SW < MB*G*ICOG*IH*IW );
2051:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       //if( oh>=oh_beg && ow>=ow_beg && oh<oh_end && ow<ow_end ){
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       //  dw_ic[ic] += psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW] * pdiff_dst[dst_off_beg
2053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       //}
2054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
2055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       if( ohw_off[oh*OW+ow] >= 0 ){
2056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                         // fastest ?
2057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                         dw_ic[ic] += psrc[s0+ic*IH*IW + oh*SH_IW + ow*SW] * pdiff_dst[dst_off_beg+o
2058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                         //dw_ic[ic] += psrc[s00+mb*IC*IH*IW +ic*IW*IH+ ohw_off[oh*OW+ow]] * pdiff_d
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                         //dw_ic[ic] += psrc[s0+ic*IH*IW + ohw_off[oh*OW+ow]] * pdiff_dst[dst_off_be
2060:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       }
2061:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else // slower
2062:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       if( ohw_off[oh*OW+ow] >= 0 ){
2063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                         tmpsrc[oh*OW+ow] = psrc[s00+mb*IC*IH*IW +ic*IW*IH+ ohw_off[oh*OW+ow]];
2064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       }else{
2065:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                         tmpsrc[oh*OW+ow] = 0.f;
2066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       }
2067:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += tmpsrc[oh*OW+ow] * pdiff_dst[dst_off_beg+oh*OW+ow];
2068:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2069:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2070:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
2071:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2072:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2073:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2074:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2075:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2076:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic){
2077:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2078:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2079:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
2080:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
2081:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
2082:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
2083:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
2084:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   bwd_w_bias_update( p, diff_bia_m, diff_dst_m);
2085:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // A1,A3,BWD_WB SX 13.8,13.8,14    x86:HORRIBLE
2086:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2087:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
2088:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
2089:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     bool ook[OH*OW];
2090:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** RETAIN(ook)
2091:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int ohw_off[OH*OW];
2092:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** RETAIN(ohw_off)
2093:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float tmpsrc[OH*OW];
2094:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2095:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(tmpsrc)
2096:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2097:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(tmpsrc)
2098:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2099:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float dw_ic[ICOG];
2100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(dw_ic)
2102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(dw_ic)
2104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash;
2106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash_prv = -1;
2107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_begend[4];
2108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_begend)
2110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_begend)
2112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_muls[4] = {1, OH, (1<<16), (1<<16)*OW};
2114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_muls)
2116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_muls)
2118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(parallel for collapse(4))//;
2121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
2124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
2125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // conditionals --> loop limit calculations   "hoisting"
2128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // equiv, but OK for unsigned hoist_t and "normal" division op
2129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
2130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t oh_beg = 0, oh_end=0;
2131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
2132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
2133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( oh_end >= OH ) oh_end = OH;
2134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t ow_beg = 0, ow_end=0;
2135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
2136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
2137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( ow_end >= OW ) ow_end = OW;
2138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (ow_beg < ow_end && oh_beg < oh_end) {
2141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+0*SH)) * IW + 0*SW - PW + k
2143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[0] = oh_beg; ohw_begend[1] = oh_end; ohw_begend[2] = ow_beg; ohw_begend[3]
2145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohash = 0; for (size_t i=0; i<4; ++i) ohash += ohw_begend[i] * ohw_muls[i];
2146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
2147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohash_prv = ohash;
2148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh) {
2149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
2150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if ( (oh>=oh_beg && ow>=ow_beg) && (oh<oh_end && ow<ow_end) )
2151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = (int)(oh*SH_IW + ow*SW);
2152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     else
2153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = -1;
2154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
2160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t s0 = s00 + mb*IC*IH*IW;
2161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
2162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ohw = 0; ohw< OH_OW; ++ohw) {
2163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if( ohw_off[ohw] >= 0 ){
2164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       // fastest ?
2165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += psrc[s0+ic*IH*IW + ohw_off[ohw]] * pdiff_dst[dst_off_beg+ohw];
2166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
2167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic){
2173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
2176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
2177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
2178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
2179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
2180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   bwd_w_bias_update( p, diff_bia_m, diff_dst_m);
2181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 //
2182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
2184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
2185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int ohw_off[OH*OW];
2186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** RETAIN(ohw_off)
2187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float tmpsrc[OH*OW];
2188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(tmpsrc)
2190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(tmpsrc)
2192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float dw_ic[ICOG];
2194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(dw_ic)
2196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(dw_ic)
2198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash;
2200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash_prv = -1;
2201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_begend[4];
2202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_begend)
2204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_begend)
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_muls[4] = {1, OH, (1<<16), (1<<16)*OW};
2208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_muls)
2210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_muls)
2212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(parallel for collapse(4))//;
2215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
2218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
2219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // conditionals --> loop limit calculations   "hoisting"
2222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // equiv, but OK for unsigned hoist_t and "normal" division op
2223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
2224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t oh_beg = 0, oh_end=0;
2225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
2226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
2227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( oh_end >= OH ) oh_end = OH;
2228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t ow_beg = 0, ow_end=0;
2229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
2230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
2231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( ow_end >= OW ) ow_end = OW;
2232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (ow_beg < ow_end && oh_beg < oh_end) {
2235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+0*SH)) * IW + 0*SW - PW + k
2237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[0] = oh_beg; ohw_begend[1] = oh_end; ohw_begend[2] = ow_beg; ohw_begend[3]
2239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohash = 0; for (size_t i=0; i<4; ++i) ohash += ohw_begend[i] * ohw_muls[i];
2240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
2241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohash_prv = ohash;
2242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh) {
2243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
2244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if ( (oh>=oh_beg && ow>=ow_beg) && (oh<oh_end && ow<ow_end) )
2245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = (int)(oh*SH_IW + ow*SW);
2246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     else
2247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = -1;
2248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
2254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 const ssize_t s0 = s00 + mb*IC*IH*IW;
2255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
2256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ohw = 0; ohw< OH_OW; ++ohw) {
2257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 // x86:HORRIBLE
2258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if( ohw_off[ohw] >= 0 ){
2259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += psrc[s0+ic*IH*IW + ohw_off[ohw]] * pdiff_dst[dst_off_beg+ohw];
2260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
2261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // SX:half-speed
2262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmpsrc[ohw] = (ohw_off[ohw] >= 0? psrc[s0+ic*IH*IW + ohw_off[ohw]]: 0.f);
2263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     dw_ic[ic] += tmpsrc[ohw] * pdiff_dst[dst_off_beg+ohw];
2264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1 // very slightly slower, but allows checking loop re-orderings
2265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if( ohw_off[ohw] >= 0 ){
2266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += psrc[s00+(mb*IC+ic)*IH_IW + ohw_off[ohw]] * pdiff_dst[d0+mb*OC_O
2267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
2268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic){
2275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
2278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
2279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
2280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
2281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
2282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   bwd_w_bias_update( p, diff_bia_m, diff_dst_m);
2283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 0 // experimental
2284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
2286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
2287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int ohw_off[OH*OW];
2288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** RETAIN(ohw_off)
2289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float tmpsrc[OH*OW];
2290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(tmpsrc)
2292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(tmpsrc)
2294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float dw_ic[ICOG];
2296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(dw_ic)
2298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(dw_ic)
2300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash;
2302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash_prv = -1;
2303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_begend[4];
2304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_begend)
2306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_begend)
2308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_muls[4] = {1, OH, (1<<16), (1<<16)*OW};
2310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_muls)
2312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_muls)
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(parallel for collapse(4))//;
2317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
2320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
2321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // conditionals --> loop limit calculations   "hoisting"
2324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // equiv, but OK for unsigned hoist_t and "normal" division op
2325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
2326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t oh_beg = 0, oh_end=0;
2327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
2328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
2329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( oh_end >= OH ) oh_end = OH;
2330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t ow_beg = 0, ow_end=0;
2331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
2332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
2333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( ow_end >= OW ) ow_end = OW;
2334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (ow_beg < ow_end && oh_beg < oh_end) {
2337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+0*SH)) * IW + 0*SW - PW + k
2339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[0] = oh_beg; ohw_begend[1] = oh_end; ohw_begend[2] = ow_beg; ohw_begend[3]
2341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohash = 0; for (size_t i=0; i<4; ++i) ohash += ohw_begend[i] * ohw_muls[i];
2342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
2343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohash_prv = ohash;
2344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh) {
2345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
2346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if ( (oh>=oh_beg && ow>=ow_beg) && (oh<oh_end && ow<ow_end) )
2347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = (int)(oh*SH_IW + ow*SW);
2348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     else
2349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = -1;
2350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
2354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ssize_t src_mbic[MB*ICOG];
2355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
2357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   src_mbic[mb*IC+ic] = s00 + (mb*IC+ic)*IH_IW;
2358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               // mb, ohw, ic SLOW
2363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
2365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ohw = 0; ohw< OH_OW; ++ohw) {
2366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 0
2367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if( ohw_off[ohw] >= 0 ){
2368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += psrc[s00+(mb*IC+ic)*IH_IW + ohw_off[ohw]] * pdiff_dst[d0+mb*OC_O
2369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
2370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1
2371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if( ohw_off[ohw] >= 0 ){
2372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += psrc[src_mbic[mb*IC+ic] + ohw_off[ohw]] * pdiff_dst[d0+mb*OC_OH_
2373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
2374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     tmpsrc[ohw] = (ohw_off[ohw] >= 0? psrc[s00+(mb*IC+ic)*IH_IW + ohw_off[ohw]]: 0.
2376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += tmpsrc[ohw] * pdiff_dst[d0+mb*OC_OH_OW+ohw];
2377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic){
2384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
2387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
2388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
2389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
2390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
2391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   bwd_w_bias_update( p, diff_bia_m, diff_dst_m);
2392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1 // cleaned up, SX ~ 11x speedup.    SUCKS on x86 with gcc (0.34x speedup)!
2393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   OMP(parallel)//;
2395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   {
2396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     int ohw_off[OH*OW];
 4289              		.loc	1 2396 0
 4290 5990 00000000 		muls.l	%s60,4,%s18
 4290      92043C6E 
 4291              	# line 1399
1399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KH = p->kh;
 4292              		.loc	1 1399 0
 4293 5998 18FEFFFF 		st	%s55,-488(,%fp)	# OW
 4293      89003711 
 4294              	# line 1422
1422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
 4295              		.loc	1 1422 0
 4296 59a0 18FEFFFF 		lea	%s58,-488
 4296      00003A06 
 4297 59a8 00000000 		adds.l	%s58,%fp,%s58
 4297      BA893A59 
 4298              	# line 1400
1400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t KW = p->kw;
 4299              		.loc	1 1400 0
 4300 59b0 20000000 		ldl.sx	%s55,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 4300      80003703 
 4301 59b8 00000000 		or	%s55,0,%s55
 4301      B7003745 
 4302              	# line 1401
1401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PH = p->ph;
 4303              		.loc	1 1401 0
 4304 59c0 24000000 		ldl.sx	%s53,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 4304      80003503 
 4305 59c8 00000000 		or	%s21,0,%s53
 4305      B5001545 
 4306              	# line 1414
1414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH_IW = SH * IW;
 4307              		.loc	1 1414 0
 4308 59d0 00000000 		muls.l	%s29,%s55,%s21
 4308      95B71D6E 
 4309              	# line 1402
1402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t PW = p->pw;
 4310              		.loc	1 1402 0
 4311 59d8 30000000 		ldl.sx	%s55,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 4311      80003703 
 4312 59e0 00000000 		or	%s30,0,%s55
 4312      B7001E45 
 4313              	# line 1403
1403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SH = p->sh;
 4314              		.loc	1 1403 0
 4315 59e8 34000000 		ldl.sx	%s55,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 4315      80003703 
 4316 59f0 00000000 		or	%s31,0,%s55
 4316      B7001F45 
 4317              	# line 1404
1404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t SW = p->sw;
 4318              		.loc	1 1404 0
 4319 59f8 28000000 		ldl.sx	%s55,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 4319      80003703 
 4320 5a00 00000000 		or	%s33,0,%s55
 4320      B7002145 
 4321              	# line 1415
1415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float const * restrict const psrc = (float*)src_m;
 4322              		.loc	1 1415 0
 4323 5a08 00000000 		muls.l	%s50,%s27,%s33
 4323      A19B326E 
 4324              	# line 1405
1405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DH = p->dh + 1;
 4325              		.loc	1 1405 0
 4326 5a10 2C000000 		ldl.sx	%s55,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 4326      80003703 
 4327 5a18 00000000 		or	%s32,0,%s55
 4327      B7002045 
 4328              	# line 1406
1406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t DW = p->dw + 1;
 4329              		.loc	1 1406 0
 4330 5a20 38000000 		ldl.sx	%s55,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 4330      80003703 
 4331 5a28 00000000 		adds.w.sx	%s55,1,%s55
 4331      B701374A 
 4332 5a30 00000000 		or	%s47,0,%s55
 4332      B7002F45 
 4333              	# line 1407
1407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   const ssize_t ICOG = IC/G;
 4334              		.loc	1 1407 0
 4335 5a38 3C000000 		ldl.sx	%s55,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 4335      80003703 
 4336 5a40 00000000 		or	%s0,0,%s60
 4336      BC000045 
 4337 5a48 00000000 		adds.w.sx	%s55,1,%s55
 4337      B701374A 
 4338 5a50 00000000 		or	%s41,0,%s55
 4338      B7002945 
 4339              	# line 1416
1416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_wei = (float*)diff_wei_m;
 4340              		.loc	1 1416 0
 4341 5a58 A8010000 		ld	%s57,424(,%s1)	# *(src_m).data_
 4341      81003901 
 4342              	# line 1417
1417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   float       * restrict const pdiff_bia = (float*)diff_bia_m;
 4343              		.loc	1 1417 0
 4344 5a60 A8010000 		ld	%s54,424(,%s2)	# *(diff_wei_m).data_
 4344      82003601 
 4345              	# line 1419
1419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1
 4346              		.loc	1 1419 0
 4347 5a68 A8010000 		ld	%s34,424(,%s4)	# *(diff_dst_m).data_
 4347      84002201 
 4348              	# line 1422
1422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     if ((p->dir & FLAG_BIA)) {
 4349              		.loc	1 1422 0
 4350 5a70 F8FDFFFF 		st	%s59,-520(,%fp)	# bwd_w_bias_update.OC
 4350      89003B11 
 4351 5a78 00FEFFFF 		st	%s63,-512(,%fp)	# bwd_w_bias_update.MB
 4351      89003F11 
 4352 5a80 08FEFFFF 		st	%s56,-504(,%fp)	# bwd_w_bias_update.OH
 4352      89003811 
 4353 5a88 10FEFFFF 		st	%s58,-496(,%fp)	# bwd_w_bias_update.OW
 4353      89003A11 
 4354              	# line 2396
 4355              		.loc	1 2396 0
 4356 5a90 F0FDFFFF 		lea	%s63,-528
 4356      00003F06 
 4357 5a98 00000000 		adds.l	%s35,%fp,%s63
 4357      BF892359 
 4358 5aa0 00000000 		lea	%s12,__grow_stack@LO
 4358      00000C06 
 4359 5aa8 00000000 		and	%s12,%s12,(32)0
 4359      608C0C44 
 4360 5ab0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4360      8C008C06 
 4361 5ab8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4361      8C000A08 
 4362 5ac0 D0000000 		lea	%s63,208
 4362      00003F06 
 4363 5ac8 00000000 		adds.l	%s63,%sp,%s63
 4363      BF8B3F59 
 4364 5ad0 00000000 		lea	%s60,0
 4364      00003C06 
 4365 5ad8 00000000 		st	%s63,0(,%s35)
 4365      A3003F11 
 4366 5ae0 F0FDFFFF 		ld	%s63,-528(,%fp)	# ohw_off
 4366      89003F01 
 4367 5ae8 B0FFFFFF 		st	%s63,-80(,%fp)
 4367      89003F11 
 4368 5af0 00000000 		st2b	%s60,0(,%s24)
 4368      98003C14 
 4369              	# line 2399
2397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     RETAIN(ohw_off)
2398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //int icohw_off[ICOG*OH*OW]
2399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float tmpsrc[OH*OW];
 4370              		.loc	1 2399 0
 4371 5af8 20FEFFFF 		ld	%s63,-480(,%fp)	# OH
 4371      89003F01 
 4372 5b00 18FEFFFF 		ld	%s60,-488(,%fp)	# OW
 4372      89003C01 
 4373 5b08 00000000 		muls.l	%s60,%s63,%s60
 4373      BCBF3C6E 
 4374 5b10 D0FFFFFF 		lea	%s63,-48
 4374      00003F06 
 4375 5b18 00000000 		adds.l	%s35,%fp,%s63
 4375      BF892359 
 4376 5b20 00000000 		muls.l	%s0,4,%s60
 4376      BC04006E 
 4377 5b28 00000000 		lea	%s12,__grow_stack@LO
 4377      00000C06 
 4378 5b30 00000000 		and	%s12,%s12,(32)0
 4378      608C0C44 
 4379 5b38 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4379      8C008C06 
 4380 5b40 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4380      8C000A08 
 4381 5b48 D0000000 		lea	%s63,208
 4381      00003F06 
 4382 5b50 00000000 		adds.l	%s63,%sp,%s63
 4382      BF8B3F59 
 4383 5b58 00000000 		st	%s63,0(,%s35)
 4383      A3003F11 
 4384 5b60 D0FFFFFF 		ld	%s63,-48(,%fp)	# tmpsrc
 4384      89003F01 
 4385 5b68 00130000 		br.l	.L5.0
 4385      00000F18 
 4386              	.L5.1:
 4387              	# line 2444
2400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     //ALLOC_ON_VREG(tmpsrc)
2401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float dw_ic[ICOG];
2402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(dw_ic)
2404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ALLOC_ON_VREG(dw_ic)
2406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash;
2408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     ssize_t ohash_prv = -1;
2409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_begend[4];
2410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_begend)
2412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_begend)
2414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_muls[4] = {1, OH, (1<<16), (1<<16)*OW};
2416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
2417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     VREG(ohw_muls)
2418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #else
2419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         VREG(ohw_muls)
2420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     OMP(parallel for collapse(4))//;
2423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
2427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // conditionals --> loop limit calculations   "hoisting"
2430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             // equiv, but OK for unsigned hoist_t and "normal" division op
2431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //   kh,kw + constants ---> oh/ow_beg/end
2432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
2433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t oh_beg = 0, oh_end=0;
2434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
2435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
2436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < PH ) oh_beg =    (   - ih0 + SH - 1)/ SH;
2437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < IH+PH ) oh_end = (IH - ih0 + SH - 1) / SH;
2438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( oh_end >= OH ) oh_end = OH;
2439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             hoist_t ow_beg = 0, ow_end=0;
2440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < PW ) ow_beg =    ((     PW - kw*DW) + SW-1)/ SW;
2441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
2442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( ow_end >= OW ) ow_end = OW;
2443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
 4388              		.loc	1 2444 0
 4389 5b70 80000000 		mins.l	%s60,%s56,%s60
 4389      BCB83C68 
 4390 5b78 B80D0000 		br.l	.L5.2
 4390      00000F18 
 4391              	.L5.3:
 4392              	# line 2454
2445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (ow_beg < ow_end && oh_beg < oh_end) {
2446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+0*SH)) * IW + 0*SW - PW + k
2448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohw_begend[0] = oh_beg; ohw_begend[1] = oh_end; ohw_begend[2] = ow_beg; ohw_begend[3]
2450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohash = 0; for (size_t i=0; i<4; ++i) ohash += ohw_begend[i] * ohw_muls[i];
2451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
2452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 ohash_prv = ohash;
2453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh) {
2454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
 4393              		.loc	1 2454 0
 4394 5b80 00000000 		cmpu.l	%s63,%s47,%s59
 4394      BBAF3F55 
 4395 5b88 06000000 		cmov.l.le	%s59,%s47,%s63
 4395      AFBF3B3B 
 4396 5b90 00000000 		smvl	%s13
 4396      00000D2E 
 4397 5b98 00000000 		lvl	%s13
 4397      008D00BF 
 4398 5ba0 28090000 		br.l	.L5.4
 4398      00000F18 
 4399              	.L5.5:
 4400              	# line 2480
2455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if ( (oh>=oh_beg && ow>=ow_beg) && (oh<oh_end && ow<ow_end) )
2456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = (int)(oh*SH_IW + ow*SW);
2457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     else
2458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = -1;
2459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
2463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               // mb, ohw, ic SLOW
2464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
2466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ohw = 0; ohw< OH_OW; ++ohw) {
2467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 || defined(_SX)
2468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if( ohw_off[ohw] >= 0 ){
2469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += psrc[s00+(mb*IC+ic)*IH_IW + ohw_off[ohw]] * pdiff_dst[d0+mb*OC_O
2470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
2471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #elif 1 // slightly slower
2472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += (ohw_off[ohw] >= 0? psrc[s00+(mb*IC+ic)*IH_IW + ohw_off[ohw]]: 0
2473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                         * pdiff_dst[d0+mb*OC_OH_OW+ohw];
2474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #endif
2475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
2476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 }
2477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               }
2478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic){
 4401              		.loc	1 2480 0
 4402 5ba8 80000000 		mins.l	%s59,%s52,%s59
 4402      BBB43B68 
 4403 5bb0 C8030000 		br.l	.L5.6
 4403      00000F18 
 4404              	.L5.7:
 4405 5bb8 00000000 		lea	%s23,__eh_curr_region@LO
 4405      00001706 
 4406 5bc0 00000000 		and	%s23,%s23,(32)0
 4406      60971744 
 4407 5bc8 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 4407      97009706 
 4408 5bd0 00000000 		or	%s2,0,%s3
 4408      83000245 
 4409 5bd8 FFFF0000 		lea	%s63,65535
 4409      00003F06 
 4410 5be0 00000000 		or	%s3,0,%s4
 4410      84000345 
 4411 5be8 00000000 		st2b	%s63,0(,%s23)
 4411      97003F14 
 4412              	# line 2488
2481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
2483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           }
2484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         }
2485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       }
2486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     }
2487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   }
2488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****   bwd_w_bias_update( p, diff_bia_m, diff_dst_m);
 4413              		.loc	1 2488 0
 4414 5bf0 F8FDFFFF 		lea	%s63,-520
 4414      00003F06 
 4415 5bf8 00000000 		adds.l	%s0,%fp,%s63
 4415      BF890059 
 4416 5c00 A0F4FFFF 		ld	%s1,-2912(,%fp)	# restore 
 4416      89000101 
 4417 5c08 00000000 		lea	%s12,conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const@LO
 4417      00000C06 
 4418 5c10 00000000 		and	%s12,%s12,(32)0
 4418      608C0C44 
 4419 5c18 00000000 		lea.sl	%s12,conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const
 4419      8C008C06 
 4420 5c20 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_clES2
 4420      8C000A08 
 4421 5c28 60FEFFFF 		ld2b.zx	%s63,-416(,%fp)
 4421      8900BF04 
 4422 5c30 00000000 		st2b	%s63,0(,%s23)
 4422      97003F14 
 4423 5c38 38FEFFFF 		ld	%s63,-456(,%fp)
 4423      89003F01 
 4424 5c40 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 4424      00003E06 
 4425 5c48 00000000 		and	%s62,%s62,(32)0
 4425      60BE3E44 
 4426 5c50 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 4426      BE00BE06 
 4427 5c58 00000000 		st	%s63,0(,%s62)
 4427      BE003F11 
 4428              	# Start of epilogue codes
 4429 5c60 30000000 		ld	%s18,48(,%fp)
 4429      89001201 
 4430 5c68 38000000 		ld	%s19,56(,%fp)
 4430      89001301 
 4431 5c70 40000000 		ld	%s20,64(,%fp)
 4431      89001401 
 4432 5c78 48000000 		ld	%s21,72(,%fp)
 4432      89001501 
 4433 5c80 50000000 		ld	%s22,80(,%fp)
 4433      89001601 
 4434 5c88 58000000 		ld	%s23,88(,%fp)
 4434      89001701 
 4435 5c90 60000000 		ld	%s24,96(,%fp)
 4435      89001801 
 4436 5c98 68000000 		ld	%s25,104(,%fp)
 4436      89001901 
 4437 5ca0 70000000 		ld	%s26,112(,%fp)
 4437      89001A01 
 4438 5ca8 78000000 		ld	%s27,120(,%fp)
 4438      89001B01 
 4439 5cb0 80000000 		ld	%s28,128(,%fp)
 4439      89001C01 
 4440 5cb8 88000000 		ld	%s29,136(,%fp)
 4440      89001D01 
 4441 5cc0 90000000 		ld	%s30,144(,%fp)
 4441      89001E01 
 4442 5cc8 98000000 		ld	%s31,152(,%fp)
 4442      89001F01 
 4443 5cd0 A0000000 		ld	%s32,160(,%fp)
 4443      89002001 
 4444 5cd8 A8000000 		ld	%s33,168(,%fp)
 4444      89002101 
 4445 5ce0 00000000 		or	%sp,0,%fp
 4445      89000B45 
 4446              		.cfi_def_cfa	11,8
 4447 5ce8 18000000 		ld	%got,0x18(,%sp)
 4447      8B000F01 
 4448 5cf0 20000000 		ld	%plt,0x20(,%sp)
 4448      8B001001 
 4449 5cf8 08000000 		ld	%lr,0x8(,%sp)
 4449      8B000A01 
 4450 5d00 00000000 		ld	%fp,0x0(,%sp)
 4450      8B000901 
 4451 5d08 00000000 		b.l	(,%lr)
 4451      8A000F19 
 4452              	.L5.8:
 4453 5d10 A0F4FFFF 		st	%s62,-2912(,%fp)	# spill 
 4453      89003E11 
 4454 5d18 18F4FFFF 		ld	%s3,-3048(,%fp)	# restore 
 4454      89000301 
 4455 5d20 10F4FFFF 		ld	%s4,-3056(,%fp)	# restore 
 4455      89000401 
 4456 5d28 90FEFFFF 		br.l	.L5.7
 4456      00000F18 
 4457              	.L5.9:
 4458              	# line 2423
2423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
 4459              		.loc	1 2423 0
 4460 5d30 00000000 		adds.l	%s55,1,%s55
 4460      B7013759 
 4461 5d38 00000000 		adds.l	%s49,%s20,%s49
 4461      B1943159 
 4462 5d40 00000000 		adds.l	%s37,%s38,%s37
 4462      A5A62559 
 4463 5d48 00000000 		adds.l	%s36,1,%s36
 4463      A4012459 
 4464 5d50 400F0000 		brgt.l	0,%s55,.L5.10
 4464      B7000118 
 4465 5d58 B8FFFFFF 		br.l	.L5.8
 4465      00000F18 
 4466              	.L5.11:
 4467 5d60 E0F4FFFF 		ld	%s55,-2848(,%fp)	# restore 
 4467      89003701 
 4468 5d68 E8F4FFFF 		ld	%s20,-2840(,%fp)	# restore 
 4468      89001401 
 4469 5d70 C8F4FFFF 		ld	%s49,-2872(,%fp)	# restore 
 4469      89003101 
 4470 5d78 D8F4FFFF 		ld	%s38,-2856(,%fp)	# restore 
 4470      89002601 
 4471 5d80 D0F4FFFF 		ld	%s37,-2864(,%fp)	# restore 
 4471      89002501 
 4472 5d88 C0F4FFFF 		ld	%s36,-2880(,%fp)	# restore 
 4472      89002401 
 4473 5d90 B0F4FFFF 		ld	%s34,-2896(,%fp)	# restore 
 4473      89002201 
 4474 5d98 B8F4FFFF 		ld	%s42,-2888(,%fp)	# restore 
 4474      89002A01 
 4475 5da0 A8F4FFFF 		ld	%s3,-2904(,%fp)	# restore 
 4475      89000301 
 4476 5da8 88FFFFFF 		br.l	.L5.9
 4476      00000F18 
 4477              	.L5.12:
 4478              	# line 2424
2424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
 4479              		.loc	1 2424 0
 4480 5db0 00000000 		adds.l	%s49,1,%s49
 4480      B1013159 
 4481 5db8 00000000 		adds.l	%s28,%s46,%s28
 4481      9CAE1C59 
 4482 5dc0 00000000 		adds.l	%s40,1,%s40
 4482      A8012859 
 4483 5dc8 180E0000 		brgt.l	0,%s49,.L5.13
 4483      B1000118 
 4484 5dd0 90FFFFFF 		br.l	.L5.11
 4484      00000F18 
 4485              	.L5.14:
 4486 5dd8 28F5FFFF 		ld	%s49,-2776(,%fp)	# restore 
 4486      89003101 
 4487 5de0 20F5FFFF 		ld	%s46,-2784(,%fp)	# restore 
 4487      89002E01 
 4488 5de8 18F5FFFF 		ld	%s40,-2792(,%fp)	# restore 
 4488      89002801 
 4489 5df0 08F5FFFF 		ld	%s56,-2808(,%fp)	# restore 
 4489      89003801 
 4490 5df8 10F5FFFF 		ld	%s57,-2800(,%fp)	# restore 
 4490      89003901 
 4491 5e00 00F5FFFF 		ld	%s51,-2816(,%fp)	# restore 
 4491      89003301 
 4492 5e08 F8F4FFFF 		ld	%s50,-2824(,%fp)	# restore 
 4492      89003201 
 4493 5e10 F0F4FFFF 		ld	%s48,-2832(,%fp)	# restore 
 4493      89003001 
 4494 5e18 98FFFFFF 		br.l	.L5.12
 4494      00000F18 
 4495              	.L5.15:
 4496              	# line 2425
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 4497              		.loc	1 2425 0
 4498 5e20 20000000 		ldl.sx	%s55,32(,%s62)	# *(p).__b_N4conv6desc_tE.kh
 4498      BE003703 
 4499 5e28 00000000 		or	%s55,0,%s55
 4499      B7003745 
 4500 5e30 00000000 		adds.l	%s22,%s47,%s22
 4500      96AF1659 
 4501 5e38 00000000 		adds.l	%s20,%s47,%s20
 4501      94AF1459 
 4502 5e40 00000000 		adds.l	%s42,%s44,%s42
 4502      AAAC2A59 
 4503 5e48 00000000 		adds.l	%s31,%s44,%s31
 4503      9FAC1F59 
 4504 5e50 00000000 		adds.l	%s40,%s43,%s40
 4504      A8AB2859 
 4505 5e58 00000000 		adds.l	%s38,1,%s38
 4505      A6012659 
 4506 5e60 F00C0000 		brlt.l	%s38,%s55,.L5.16
 4506      B7A60218 
 4507 5e68 70FFFFFF 		br.l	.L5.14
 4507      00000F18 
 4508              	.L5.17:
 4509 5e70 80F5FFFF 		ld	%s47,-2688(,%fp)	# restore 
 4509      89002F01 
 4510 5e78 00000000 		or	%s45,0,%s1
 4510      81002D45 
 4511 5e80 70F5FFFF 		ld	%s44,-2704(,%fp)	# restore 
 4511      89002C01 
 4512 5e88 00000000 		or	%s35,0,%s51
 4512      B3002345 
 4513 5e90 68F5FFFF 		ld	%s43,-2712(,%fp)	# restore 
 4513      89002B01 
 4514 5e98 58F5FFFF 		ld	%s40,-2728(,%fp)	# restore 
 4514      89002801 
 4515 5ea0 60F5FFFF 		ld	%s38,-2720(,%fp)	# restore 
 4515      89002601 
 4516 5ea8 78F5FFFF 		ld	%s21,-2696(,%fp)	# restore 
 4516      89001501 
 4517 5eb0 50F5FFFF 		ld	%s63,-2736(,%fp)	# restore 
 4517      89003F01 
 4518 5eb8 48F5FFFF 		ld	%s61,-2744(,%fp)	# restore 
 4518      89003D01 
 4519 5ec0 40F5FFFF 		ld	%s60,-2752(,%fp)	# restore 
 4519      89003C01 
 4520 5ec8 38F5FFFF 		ld	%s59,-2760(,%fp)	# restore 
 4520      89003B01 
 4521 5ed0 30F5FFFF 		ld	%s58,-2768(,%fp)	# restore 
 4521      89003A01 
 4522 5ed8 48FFFFFF 		br.l	.L5.15
 4522      00000F18 
 4523              	.L5.18:
 4524 5ee0 00000000 		or	%s45,0,%s1
 4524      81002D45 
 4525 5ee8 00000000 		or	%s35,0,%s51
 4525      B3002345 
 4526 5ef0 00000000 		or	%s44,0,%s49
 4526      B1002C45 
 4527 5ef8 00000000 		or	%s34,0,%s62
 4527      BE002245 
 4528 5f00 880B0000 		br.l	.L5.19
 4528      00000F18 
 4529              	.L5.20:
 4530              	# line 2426
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
 4531              		.loc	1 2426 0
 4532 5f08 00000000 		adds.l	%s43,1,%s43
 4532      AB012B59 
 4533 5f10 00000000 		adds.l	%s40,%s41,%s40
 4533      A8A92859 
 4534 5f18 00000000 		adds.l	%s21,%s41,%s21
 4534      95A91559 
 4535 5f20 00000000 		adds.l	%s38,%s39,%s38
 4535      A6A72659 
 4536 5f28 00000000 		adds.l	%s37,%s39,%s37
 4536      A5A72559 
 4537 5f30 00000000 		adds.l	%s36,%s41,%s36
 4537      A4A92459 
 4538 5f38 00000000 		adds.l	%s46,1,%s46
 4538      AE012E59 
 4539 5f40 A0FFFFFF 		brgt.l	0,%s43,.L5.18
 4539      AB000118 
 4540 5f48 28FFFFFF 		br.l	.L5.17
 4540      00000F18 
 4541              	.L5.21:
 4542 5f50 00000000 		or	%s2,0,%s56
 4542      B8000245 
 4543 5f58 00000000 		or	%s53,0,%s63
 4543      BF003545 
 4544 5f60 00000000 		or	%s52,0,%s61
 4544      BD003445 
 4545 5f68 00000000 		or	%s62,0,%s57
 4545      B9003E45 
 4546 5f70 98FFFFFF 		br.l	.L5.20
 4546      00000F18 
 4547              	.L5.6:
 4548 5f78 00000000 		or	%s60,0,%s62
 4548      BE003C45 
 4549              	# line 2481
2481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             }
 4550              		.loc	1 2481 0
 4551 5f80 00000000 		lvl	%s59
 4551      00BB00BF 
 4552 5f88 00000031 		vldu.nc	%v49,4,%s60
 4552      BC040082 
 4553 5f90 00000000 		or	%s60,0,%s58
 4553      BA003C45 
 4554 5f98 00000031 		vstu.nc	%v49,%s56,%s60
 4554      BCB80092 
 4555              	# line 2480
2480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
 4556              		.loc	1 2480 0
 4557 5fa0 00000000 		adds.l	%s62,%s62,%s55
 4557      B7BE3E59 
 4558 5fa8 00000000 		adds.l	%s58,%s58,%s53
 4558      B5BA3A59 
 4559 5fb0 00000000 		subs.l	%s52,%s52,%s59
 4559      BBB4345B 
 4560 5fb8 98FFFFFF 		brge.l	0,%s52,.L5.21
 4560      B4000518 
 4561 5fc0 E8FBFFFF 		br.l	.L5.5
 4561      00000F18 
 4562              	.L5.22:
 4563 5fc8 00000000 		muls.l	%s60,4,%s55
 4563      B7043C6E 
 4564 5fd0 00000000 		or	%s56,0,%s2
 4564      82003845 
 4565 5fd8 00000000 		or	%s57,0,%s62
 4565      BE003945 
 4566 5fe0 00000000 		adds.l	%s60,%s60,%s54
 4566      B6BC3C59 
 4567 5fe8 00000000 		subs.l	%s50,0,%s53
 4567      B500325B 
 4568 5ff0 00000000 		smvl	%s48
 4568      0000302E 
 4569 5ff8 80000000 		mins.l	%s59,%s50,%s48
 4569      B0B23B68 
 4570 6000 00000000 		or	%s61,0,%s52
 4570      B4003D45 
 4571 6008 00000000 		or	%s52,0,%s50
 4571      B2003445 
 4572 6010 00000000 		or	%s62,0,%s61
 4572      BD003E45 
 4573 6018 00000000 		muls.l	%s55,4,%s59
 4573      BB04376E 
 4574 6020 00000000 		or	%s58,0,%s60
 4574      BC003A45 
 4575 6028 00000000 		muls.l	%s2,%s2,%s59
 4575      BB82026E 
 4576 6030 00000000 		or	%s63,0,%s53
 4576      B5003F45 
 4577 6038 00000000 		or	%s53,0,%s2
 4577      82003545 
 4578 6040 38FFFFFF 		br.l	.L5.6
 4578      00000F18 
 4579              	.L5.23:
 4580              	# line 2479
2479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic){
 4581              		.loc	1 2479 0
 4582 6048 14000000 		ldl.sx	%s55,20(,%s62)	# *(p).__b_N4conv6desc_tE.oc
 4582      BE003703 
 4583 6050 00000000 		or	%s55,0,%s55
 4583      B7003745 
 4584 6058 00000000 		mulu.l	%s55,%s55,%s51
 4584      B3B73749 
 4585 6060 00000000 		ldl.sx	%s45,0(,%s62)	# *(p).__b_N4conv6desc_tE.g
 4585      BE002D03 
 4586 6068 00000000 		or	%s45,0,%s45
 4586      AD002D45 
 4587 6070 00000000 		divu.l	%s55,%s55,%s45
 4587      ADB7376F 
 4588 6078 00000000 		addu.l	%s55,%s55,%s49
 4588      B1B73748 
 4589 6080 08000000 		ldl.sx	%s44,8(,%s62)	# *(p).__b_N4conv6desc_tE.ic
 4589      BE002C03 
 4590 6088 00000000 		or	%s44,0,%s44
 4590      AC002C45 
 4591 6090 00000000 		mulu.l	%s44,%s55,%s44
 4591      ACB72C49 
 4592 6098 00000000 		divu.l	%s45,%s44,%s45
 4592      ADAC2D6F 
 4593 60a0 20000000 		ldl.sx	%s55,32(,%s62)	# *(p).__b_N4conv6desc_tE.kh
 4593      BE003703 
 4594 60a8 00000000 		or	%s55,0,%s55
 4594      B7003745 
 4595 60b0 00000000 		mulu.l	%s55,%s45,%s55
 4595      B7AD3749 
 4596 60b8 00000000 		addu.l	%s55,%s55,%s47
 4596      AFB73748 
 4597 60c0 24000000 		ldl.sx	%s45,36(,%s62)	# *(p).__b_N4conv6desc_tE.kw
 4597      BE002D03 
 4598 60c8 00000000 		or	%s45,0,%s45
 4598      AD002D45 
 4599 60d0 00000000 		mulu.l	%s45,%s55,%s45
 4599      ADB72D49 
 4600 60d8 00000000 		or	%s55,0,%s46
 4600      AE003745 
 4601 60e0 00000000 		addu.l	%s55,%s45,%s55
 4601      B7AD3748 
 4602 60e8 00000000 		or	%s55,0,%s55
 4602      B7003745 
 4603 60f0 D8FEFFFF 		brlt.l	0,%s19,.L5.22
 4603      93000218 
 4604 60f8 10FEFFFF 		br.l	.L5.20
 4604      00000F18 
 4605              	.L5.24:
 4606 6100 E0F5FFFF 		st	%s57,-2592(,%fp)	# spill 
 4606      89003911 
 4607 6108 E8F5FFFF 		st	%s61,-2584(,%fp)	# spill 
 4607      89003D11 
 4608 6110 00000000 		or	%s62,0,%s34
 4608      A2003E45 
 4609 6118 00000000 		or	%s51,0,%s35
 4609      A3003345 
 4610 6120 00000000 		or	%s49,0,%s44
 4610      AC003145 
 4611 6128 00000000 		or	%s1,0,%s45
 4611      AD000145 
 4612 6130 00000000 		or	%s4,0,%s63
 4612      BF000445 
 4613 6138 00000000 		or	%s2,0,%s26
 4613      9A000245 
 4614 6140 00000000 		or	%s5,0,%s54
 4614      B6000545 
 4615 6148 00000000 		or	%s54,0,%s25
 4615      99003645 
 4616 6150 00000000 		or	%s6,0,%s60
 4616      BC000645 
 4617 6158 00000000 		or	%s7,0,%s58
 4617      BA000745 
 4618 6160 00000000 		or	%s20,0,%s27
 4618      9B001445 
 4619 6168 E0FEFFFF 		br.l	.L5.23
 4619      00000F18 
 4620              	.L5.25:
 4621              	# line 2464
2464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
 4622              		.loc	1 2464 0
 4623 6170 00000000 		adds.l	%s62,1,%s62
 4623      BE013E59 
 4624 6178 00000000 		adds.l	%s59,%s60,%s59
 4624      BBBC3B59 
 4625 6180 00000000 		adds.l	%s55,%s58,%s55
 4625      B7BA3759 
 4626 6188 A8010000 		brgt.l	0,%s62,.L5.26
 4626      BE000118 
 4627 6190 70FFFFFF 		br.l	.L5.24
 4627      00000F18 
 4628              	.L5.27:
 4629 6198 00000000 		or	%s62,0,%s4
 4629      84003E45 
 4630 61a0 00000000 		or	%s60,0,%s5
 4630      85003C45 
 4631 61a8 00000000 		or	%s59,0,%s20
 4631      94003B45 
 4632 61b0 00000000 		or	%s58,0,%s6
 4632      86003A45 
 4633 61b8 00000000 		or	%s55,0,%s7
 4633      87003745 
 4634 61c0 B0FFFFFF 		br.l	.L5.25
 4634      00000F18 
 4635              	.L5.28:
 4636              	# line 2465
2465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (ssize_t ohw = 0; ohw< OH_OW; ++ohw) {
 4637              		.loc	1 2465 0
 4638 61c8 00000000 		adds.l	%s62,1,%s62
 4638      BE013E59 
 4639 61d0 00000000 		adds.l	%s60,4,%s60
 4639      BC043C59 
 4640 61d8 00000000 		adds.l	%s58,%s61,%s58
 4640      BABD3A59 
 4641 61e0 F0000000 		brgt.l	0,%s62,.L5.29
 4641      BE000118 
 4642 61e8 B0FFFFFF 		br.l	.L5.27
 4642      00000F18 
 4643              	.L5.30:
 4644 61f0 00000000 		or	%s62,0,%s3
 4644      83003E45 
 4645 61f8 00000000 		or	%s61,0,%s1
 4645      81003D45 
 4646 6200 00000000 		or	%s18,0,%s2
 4646      82001245 
 4647 6208 C0FFFFFF 		br.l	.L5.28
 4647      00000F18 
 4648              	.L5.31:
 4649              	# line 2466
2466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 || defined(_SX)
 4650              		.loc	1 2466 0
 4651 6210 00000000 		adds.l	%s61,1,%s61
 4651      BD013D59 
 4652 6218 00000000 		adds.l	%s62,4,%s62
 4652      BE043E59 
 4653 6220 60000000 		brgt.l	0,%s61,.L5.32
 4653      BD000118 
 4654 6228 C8FFFFFF 		br.l	.L5.30
 4654      00000F18 
 4655              	.L5.33:
 4656              	# line 2469
2469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     }
 4657              		.loc	1 2469 0
 4658 6230 00000000 		ldu	%s59,0(,%s60)	# *(dw_ic)
 4658      BC003B02 
 4659 6238 00000000 		or	%s18,0,%s18
 4659      92001245 
 4660 6240 00000000 		adds.l	%s18,%s18,%s58
 4660      BA921259 
 4661 6248 00000000 		muls.l	%s18,4,%s18
 4661      9204126E 
 4662 6250 00000000 		ldu	%s18,0(%s18,%s57)	# *(psrc)
 4662      B9921202 
 4663 6258 00000000 		ldu	%s55,0(%s62,%s56)	# *(pdiff_dst)
 4663      B8BE3702 
 4664 6260 00000000 		fmul.s	%s55,%s18,%s55
 4664      B792B74D 
 4665 6268 00000000 		fadd.s	%s55,%s59,%s55
 4665      B7BBB74C 
 4666 6270 00000000 		stu	%s55,0(,%s60)	# *(dw_ic)
 4666      BC003712 
 4667 6278 98FFFFFF 		br.l	.L5.31
 4667      00000F18 
 4668              	.L5.32:
 4669              	# line 2468
2468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       dw_ic[ic] += psrc[s00+(mb*IC+ic)*IH_IW + ohw_off[ohw]] * pdiff_dst[d0+mb*OC_O
 4670              		.loc	1 2468 0
 4671 6280 00000000 		ldl.sx	%s18,0(%s62,%s63)	# *(ohw_off)
 4671      BFBE1203 
 4672 6288 A8FFFFFF 		brle.w	0,%s18,.L5.33
 4672      92008618 
 4673 6290 80FFFFFF 		br.l	.L5.31
 4673      00000F18 
 4674              	.L5.34:
 4675 6298 00000000 		or	%s1,0,%s61
 4675      BD000145 
 4676 62a0 00000000 		or	%s61,0,%s54
 4676      B6003D45 
 4677              	# line 2466
2466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 || defined(_SX)
 4678              		.loc	1 2466 0
 4679 62a8 00000000 		or	%s59,0,(0)1
 4679      00003B45 
 4680 62b0 00000000 		or	%s2,0,%s18
 4680      92000245 
 4681 62b8 00000000 		or	%s3,0,%s62
 4681      BE000345 
 4682 62c0 00000000 		or	%s62,0,%s59
 4682      BB003E45 
 4683 62c8 B8FFFFFF 		br.l	.L5.32
 4683      00000F18 
 4684              	.L5.29:
 4685 62d0 C8FFFFFF 		brlt.l	0,%s18,.L5.34
 4685      92000218 
 4686 62d8 F0FEFFFF 		br.l	.L5.28
 4686      00000F18 
 4687              	.L5.35:
 4688 62e0 00000000 		or	%s4,0,%s62
 4688      BE000445 
 4689 62e8 00000000 		or	%s62,0,%s53
 4689      B5003E45 
 4690 62f0 00000000 		or	%s5,0,%s60
 4690      BC000545 
 4691 62f8 00000000 		or	%s60,0,%s52
 4691      B4003C45 
 4692 6300 00000000 		or	%s6,0,%s58
 4692      BA000645 
 4693 6308 00000000 		or	%s58,0,%s59
 4693      BB003A45 
 4694 6310 00000000 		or	%s56,0,%s55
 4694      B7003845 
 4695 6318 00000000 		or	%s7,0,%s55
 4695      B7000745 
 4696 6320 00000000 		or	%s20,0,%s59
 4696      BB001445 
 4697 6328 A8FFFFFF 		br.l	.L5.29
 4697      00000F18 
 4698              	.L5.26:
 4699 6330 B0FFFFFF 		brlt.l	0,%s19,.L5.35
 4699      93000218 
 4700 6338 38FEFFFF 		br.l	.L5.25
 4700      00000F18 
 4701              	.L5.36:
 4702 6340 00000000 		or	%s62,0,%s29
 4702      9D003E45 
 4703 6348 00000000 		or	%s59,0,%s36
 4703      A4003B45 
 4704 6350 00000000 		or	%s55,0,%s28
 4704      9C003745 
 4705 6358 00000000 		or	%s25,0,%s54
 4705      B6001945 
 4706 6360 00000000 		or	%s26,0,%s2
 4706      82001A45 
 4707 6368 00000000 		or	%s27,0,%s20
 4707      94001B45 
 4708 6370 00000000 		or	%s58,0,%s7
 4708      87003A45 
 4709 6378 00000000 		or	%s60,0,%s6
 4709      86003C45 
 4710 6380 00000000 		or	%s54,0,%s5
 4710      85003645 
 4711 6388 00000000 		or	%s63,0,%s4
 4711      84003F45 
 4712 6390 E8F5FFFF 		ld	%s61,-2584(,%fp)	# restore 
 4712      89003D01 
 4713 6398 E0F5FFFF 		ld	%s57,-2592(,%fp)	# restore 
 4713      89003901 
 4714 63a0 90FFFFFF 		br.l	.L5.26
 4714      00000F18 
 4715              	.L5.37:
 4716 63a8 98FFFFFF 		brlt.l	0,%s30,.L5.36
 4716      9E000218 
 4717 63b0 00000000 		or	%s62,0,%s34
 4717      A2003E45 
 4718 63b8 00000000 		or	%s51,0,%s35
 4718      A3003345 
 4719 63c0 00000000 		or	%s49,0,%s44
 4719      AC003145 
 4720 63c8 00000000 		or	%s1,0,%s45
 4720      AD000145 
 4721 63d0 78FCFFFF 		br.l	.L5.23
 4721      00000F18 
 4722              	.L5.38:
 4723 63d8 88F5FFFF 		st	%s59,-2680(,%fp)	# spill 
 4723      89003B11 
 4724 63e0 90F5FFFF 		st	%s50,-2672(,%fp)	# spill 
 4724      89003211 
 4725 63e8 98F5FFFF 		st	%s42,-2664(,%fp)	# spill 
 4725      89002A11 
 4726 63f0 A0F5FFFF 		st	%s48,-2656(,%fp)	# spill 
 4726      89003011 
 4727 63f8 00000000 		or	%s45,0,%s1
 4727      81002D45 
 4728 6400 00000000 		or	%s44,0,%s3
 4728      83002C45 
 4729 6408 00000000 		or	%s47,0,%s4
 4729      84002F45 
 4730 6410 00000000 		or	%s46,0,%s25
 4730      99002E45 
 4731 6418 00000000 		or	%s54,0,%s26
 4731      9A003645 
 4732 6420 00000000 		or	%s19,0,%s27
 4732      9B001345 
 4733 6428 B0F5FFFF 		ld	%s4,-2640(,%fp)	# restore 
 4733      89000401 
 4734 6430 D8F5FFFF 		ld	%s52,-2600(,%fp)	# restore 
 4734      89003401 
 4735 6438 D0F5FFFF 		ld	%s53,-2608(,%fp)	# restore 
 4735      89003501 
 4736 6440 C8F5FFFF 		ld	%s43,-2616(,%fp)	# restore 
 4736      89002B01 
 4737 6448 C0F5FFFF 		ld	%s42,-2624(,%fp)	# restore 
 4737      89002A01 
 4738 6450 B8F5FFFF 		ld	%s20,-2632(,%fp)	# restore 
 4738      89001401 
 4739 6458 50FFFFFF 		br.l	.L5.37
 4739      00000F18 
 4740              	.L5.39:
 4741              	# line 2453
2453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
 4742              		.loc	1 2453 0
 4743 6460 00000000 		adds.l	%s51,1,%s51
 4743      B3013359 
 4744 6468 00000000 		adds.l	%s55,1,%s55
 4744      B7013759 
 4745 6470 00000000 		adds.l	%s62,1,%s62
 4745      BE013E59 
 4746 6478 00000000 		adds.l	%s49,%s50,%s49
 4746      B1B23159 
 4747 6480 00000000 		adds.l	%s53,%s48,%s53
 4747      B5B03559 
 4748 6488 28020000 		brgt.l	0,%s51,.L5.40
 4748      B3000118 
 4749 6490 48FFFFFF 		br.l	.L5.38
 4749      00000F18 
 4750              	.L5.41:
 4751 6498 00000000 		or	%s59,0,%s61
 4751      BD003B45 
 4752 64a0 00000000 		or	%s48,0,%s57
 4752      B9003045 
 4753 64a8 00000000 		or	%s49,0,%s45
 4753      AD003145 
 4754 64b0 00000000 		or	%s50,0,%s44
 4754      AC003245 
 4755 64b8 00000000 		or	%s51,0,%s43
 4755      AB003345 
 4756 64c0 A0FFFFFF 		br.l	.L5.39
 4756      00000F18 
 4757              	.L5.4:
 4758              	# line 2455
2455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = (int)(oh*SH_IW + ow*SW);
 4759              		.loc	1 2455 0
 4760 64c8 00000000 		cmps.l	%s60,%s62,(0)1
 4760      00BE3C6A 
 4761 64d0 00000000 		lvl	%s59
 4761      00BB00BF 
 4762 64d8 00000037 		vbrd	%v55,%s60
 4762      00BC008C 
 4763 64e0 0037050F 		vfmk.l.ge	%vm15,%v55
 4763      000000B4 
 4764 64e8 003E0036 		vaddu.l	%v54,%s58,%v62
 4764      00BA20C8 
 4765 64f0 0036003D 		vcmpu.l	%v61,%s56,%v54,%vm15
 4765      00B82FB9 
 4766 64f8 003D060E 		vfmk.l.le	%vm14,%v61,%vm15
 4766      00000FB4 
 4767 6500 00000000 		cmps.l	%s60,%s55,(0)1
 4767      00B73C6A 
 4768 6508 0000003C 		vbrd	%v60,%s60,%vm14
 4768      00BC0E8C 
 4769 6510 003C020D 		vfmk.l.lt	%vm13,%v60,%vm14
 4769      00000EB4 
 4770 6518 003E0035 		vaddu.l	%v53,%s58,%v62
 4770      00BA20C8 
 4771 6520 0035003B 		vcmpu.l	%v59,%s54,%v53,%vm13
 4771      00B62DB9 
 4772 6528 003B060C 		vfmk.l.le	%vm12,%v59,%vm13
 4772      00000DB4 
 4773 6530 000E0D0B 		nndm	%vm11,%vm13,%vm14
 4773      00000094 
 4774 6538 000F0E0E 		nndm	%vm14,%vm14,%vm15
 4774      00000094 
 4775 6540 00000F0F 		negm	%vm15,%vm15
 4775      00000095 
 4776              	# line 2458
2458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   }
 4777              		.loc	1 2458 0
 4778 6548 000B0C0B 		orm	%vm11,%vm12,%vm11
 4778      00000085 
 4779 6550 000E0B0E 		orm	%vm14,%vm11,%vm14
 4779      00000085 
 4780 6558 000F0E0F 		orm	%vm15,%vm14,%vm15
 4780      00000085 
 4781 6560 00000034 		vbrd	%v52,-1
 4781      007F008C 
 4782 6568 00000000 		adds.l	%s60,%s53,(0)1
 4782      00B53C59 
 4783 6570 00000000 		adds.l	%s46,%s60,%s52
 4783      B4BC2E59 
 4784 6578 00000034 		vstl.nc	%v52,4,%s46,%vm15
 4784      AE040F93 
 4785              	# line 2455
2455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                       ohw_off[oh*OW+ow] = (int)(oh*SH_IW + ow*SW);
 4786              		.loc	1 2455 0
 4787 6580 000D0C0D 		nndm	%vm13,%vm12,%vm13
 4787      00000094 
 4788              	# line 2456
2456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     else
 4789              		.loc	1 2456 0
 4790 6588 003A0033 		vadds.l	%v51,%s51,%v58
 4790      00B3208B 
 4791 6590 00330039 		vor	%v57,(0)1,%v51,%vm13
 4791      00002DC5 
 4792 6598 00390038 		vadds.w.sx	%v56,0,%v57,%vm13
 4792      00002DCA 
 4793 65a0 00000000 		adds.l	%s60,%s60,%s52
 4793      B4BC3C59 
 4794 65a8 00000038 		vstl.nc	%v56,4,%s60,%vm13
 4794      BC040D93 
 4795              	# line 2454
2454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                     if ( (oh>=oh_beg && ow>=ow_beg) && (oh<oh_end && ow<ow_end) )
 4796              		.loc	1 2454 0
 4797 65b0 00000000 		addu.l	%s58,%s58,%s50
 4797      B2BA3A48 
 4798 65b8 00000000 		adds.l	%s51,%s51,%s49
 4798      B1B33359 
 4799 65c0 00000000 		adds.l	%s52,%s52,%s48
 4799      B0B43459 
 4800 65c8 00000000 		subu.l	%s47,%s47,%s59
 4800      BBAF2F58 
 4801 65d0 00000000 		cmpu.l	%s19,%s47,(0)1
 4801      00AF1355 
 4802 65d8 C0FEFFFF 		brle.l	%s19,0,.L5.41
 4802      00930618 
 4803 65e0 A0F5FFFF 		br.l	.L5.3
 4803      00000F18 
 4804              	.L5.42:
 4805 65e8 00000000 		or	%s61,0,%s59
 4805      BB003D45 
 4806 65f0 00000000 		or	%s44,0,%s50
 4806      B2002C45 
 4807 65f8 00000000 		or	%s45,0,%s49
 4807      B1002D45 
 4808 6600 00000000 		or	%s43,0,%s51
 4808      B3002B45 
 4809 6608 00000000 		or	%s51,0,%s49
 4809      B1003345 
 4810 6610 00000000 		smvl	%s63
 4810      00003F2E 
 4811 6618 00000000 		cmpu.l	%s60,%s59,%s63
 4811      BFBB3C55 
 4812 6620 00000000 		or	%s63,0,%s63
 4812      BF003F45 
 4813 6628 06000000 		cmov.l.le	%s63,%s59,%s60
 4813      BBBC3F3B 
 4814 6630 00000000 		or	%s47,0,%s59
 4814      BB002F45 
 4815 6638 00000000 		or	%s58,0,(0)1
 4815      00003A45 
 4816 6640 00000000 		or	%s50,0,%s63
 4816      BF003245 
 4817 6648 00000000 		lvl	%s63
 4817      00BF00BF 
 4818 6650 00000030 		vseq	%v48
 4818      00000099 
 4819 6658 00000000 		or	%s57,0,%s48
 4819      B0003945 
 4820 6660 00000000 		or	%s59,0,%s63
 4820      BF003B45 
 4821 6668 0030003E 		vor	%v62,(0)1,%v48
 4821      000020C5 
 4822 6670 00000000 		or	%s63,0,%s63
 4822      BF003F45 
 4823 6678 00000000 		lvl	%s63
 4823      00BF00BF 
 4824 6680 0000002F 		vseq	%v47
 4824      00000099 
 4825 6688 00000000 		muls.l	%s49,%s42,%s63
 4825      BFAA316E 
 4826 6690 002F003A 		vmuls.l	%v58,%s42,%v47
 4826      00AA20DB 
 4827 6698 00000000 		or	%s52,0,(0)1
 4827      00003445 
 4828 66a0 00000000 		muls.l	%s48,4,%s63
 4828      BF04306E 
 4829 66a8 20FEFFFF 		br.l	.L5.4
 4829      00000F18 
 4830              	.L5.40:
 4831 66b0 00000000 		cmpu.l	%s20,0,%s59
 4831      BB001455 
 4832 66b8 30FFFFFF 		brlt.l	%s20,0,.L5.42
 4832      00940218 
 4833 66c0 A0FDFFFF 		br.l	.L5.39
 4833      00000F18 
 4834              	.L5.43:
 4835 66c8 D8F5FFFF 		st	%s52,-2600(,%fp)	# spill 
 4835      89003411 
 4836 66d0 D0F5FFFF 		st	%s53,-2608(,%fp)	# spill 
 4836      89003511 
 4837 66d8 C8F5FFFF 		st	%s43,-2616(,%fp)	# spill 
 4837      89002B11 
 4838 66e0 C0F5FFFF 		st	%s42,-2624(,%fp)	# spill 
 4838      89002A11 
 4839 66e8 B8F5FFFF 		st	%s20,-2632(,%fp)	# spill 
 4839      89001411 
 4840 66f0 B0F5FFFF 		st	%s4,-2640(,%fp)	# spill 
 4840      89000411 
 4841 66f8 00000000 		or	%s56,0,%s51
 4841      B3003845 
 4842 6700 00000000 		or	%s25,0,%s46
 4842      AE001945 
 4843 6708 00000000 		or	%s26,0,%s54
 4843      B6001A45 
 4844 6710 00000000 		or	%s54,0,%s49
 4844      B1003645 
 4845 6718 A8F5FFFF 		ld	%s51,-2648(,%fp)	# restore 
 4845      89003301 
 4846              	# line 2453
2453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
 4847              		.loc	1 2453 0
 4848 6720 00000000 		subs.l	%s63,0,%s1
 4848      81003F5B 
 4849 6728 00000000 		or	%s1,0,%s45
 4849      AD000145 
 4850 6730 00000000 		or	%s55,0,%s63
 4850      BF003745 
 4851 6738 00000000 		subs.l	%s63,0,%s3
 4851      83003F5B 
 4852 6740 00000000 		or	%s3,0,%s44
 4852      AC000345 
 4853 6748 00000000 		or	%s62,0,%s63
 4853      BF003E45 
 4854 6750 00000000 		or	%s49,0,(0)1
 4854      00003145 
 4855 6758 00000000 		or	%s53,0,%s4
 4855      84003545 
 4856 6760 00000000 		or	%s4,0,%s47
 4856      AF000445 
 4857 6768 00000000 		or	%s27,0,%s19
 4857      93001B45 
 4858 6770 A0F5FFFF 		ld	%s48,-2656(,%fp)	# restore 
 4858      89003001 
 4859 6778 98F5FFFF 		ld	%s42,-2664(,%fp)	# restore 
 4859      89002A01 
 4860 6780 90F5FFFF 		ld	%s50,-2672(,%fp)	# restore 
 4860      89003201 
 4861 6788 88F5FFFF 		ld	%s59,-2680(,%fp)	# restore 
 4861      89003B01 
 4862 6790 20FFFFFF 		br.l	.L5.40
 4862      00000F18 
 4863              	.L5.44:
 4864 6798 00000000 		or	%s24,0,%s62
 4864      BE001845 
 4865 67a0 28FFFFFF 		brlt.l	0,%s45,.L5.43
 4865      AD000218 
 4866 67a8 00FCFFFF 		br.l	.L5.37
 4866      00000F18 
 4867              	.L5.45:
 4868 67b0 E8FFFFFF 		brne.l	%s62,%s24,.L5.44
 4868      98BE0318 
 4869 67b8 F0FBFFFF 		br.l	.L5.37
 4869      00000F18 
 4870              	.L5.46:
 4871              	# line 2450
2450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
 4872              		.loc	1 2450 0
 4873 67c0 00000000 		cvt.d.l	%s62,%s62
 4873      00BE3E5F 
 4874 67c8 00000000 		cvt.s.d	%s62,%s62
 4874      00BE3E1F 
 4875 67d0 E8FFFFFF 		ldu	%s58,-24(,%s60)	# ohw_begend
 4875      BC003A02 
 4876 67d8 D8FFFFFF 		ldu	%s55,-40(,%s60)	# ohw_muls
 4876      BC003702 
 4877 67e0 00000000 		fmul.s	%s55,%s58,%s55
 4877      B7BAB74D 
 4878 67e8 00000000 		fadd.s	%s55,%s62,%s55
 4878      B7BEB74C 
 4879 67f0 00000000 		cvt.d.s	%s55,%s55
 4879      00B7370F 
 4880 67f8 00000000 		cvt.l.d.rz	%s62,%s55
 4880      08B73E4F 
 4881 6800 00000000 		addu.l	%s59,1,%s59
 4881      BB013B48 
 4882 6808 00000000 		adds.l	%s60,4,%s60
 4882      BC043C59 
 4883 6810 04000000 		lea	%s58,4
 4883      00003A06 
 4884 6818 00000000 		cmpu.l	%s58,%s59,%s58
 4884      BABB3A55 
 4885 6820 A0FFFFFF 		brlt.l	%s58,0,.L5.46
 4885      00BA0218 
 4886 6828 88FFFFFF 		br.l	.L5.45
 4886      00000F18 
 4887              	.L5.47:
 4888              	# line 2449
2449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohash = 0; for (size_t i=0; i<4; ++i) ohash += ohw_begend[i] * ohw_muls[i];
 4889              		.loc	1 2449 0
 4890 6830 00000000 		cvt.d.l	%s63,%s62
 4890      00BE3F5F 
 4891 6838 00000000 		or	%s1,0,%s55
 4891      B7000145 
 4892 6840 00000000 		or	%s3,0,%s62
 4892      BE000345 
 4893 6848 00000000 		cvt.s.d	%s63,%s63
 4893      00BF3F1F 
 4894              	# line 2450
2450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
 4895              		.loc	1 2450 0
 4896 6850 00000000 		or	%s62,0,(0)1
 4896      00003E45 
 4897 6858 00000000 		or	%s60,0,%fp
 4897      89003C45 
 4898              	# line 2449
2449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               ohash = 0; for (size_t i=0; i<4; ++i) ohash += ohw_begend[i] * ohw_muls[i];
 4899              		.loc	1 2449 0
 4900 6860 E8FFFFFF 		stu	%s63,-24(,%fp)	# ohw_begend
 4900      89003F12 
 4901 6868 00000000 		cvt.d.l	%s55,%s55
 4901      00B7375F 
 4902 6870 00000000 		cvt.s.d	%s55,%s55
 4902      00B7371F 
 4903 6878 ECFFFFFF 		stu	%s55,-20(,%fp)	# ohw_begend
 4903      89003712 
 4904 6880 00000000 		cvt.d.l	%s63,%s51
 4904      00B33F5F 
 4905 6888 00000000 		cvt.s.d	%s63,%s63
 4905      00BF3F1F 
 4906 6890 F0FFFFFF 		stu	%s63,-16(,%fp)	# ohw_begend
 4906      89003F12 
 4907 6898 00000000 		cvt.d.l	%s63,%s49
 4907      00B13F5F 
 4908 68a0 00000000 		cvt.s.d	%s63,%s63
 4908      00BF3F1F 
 4909 68a8 F4FFFFFF 		stu	%s63,-12(,%fp)	# ohw_begend
 4909      89003F12 
 4910              	# line 2450
2450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               if (ohash != ohash_prv){
 4911              		.loc	1 2450 0
 4912 68b0 00000000 		or	%s59,0,(0)1
 4912      00003B45 
 4913 68b8 08FFFFFF 		br.l	.L5.46
 4913      00000F18 
 4914              	.L5.48:
 4915 68c0 70FFFFFF 		brlt.l	%s62,%s55,.L5.47
 4915      B7BE0218 
 4916 68c8 00000000 		or	%s62,0,%s34
 4916      A2003E45 
 4917 68d0 00000000 		or	%s51,0,%s35
 4917      A3003345 
 4918 68d8 00000000 		or	%s49,0,%s44
 4918      AC003145 
 4919 68e0 00000000 		or	%s1,0,%s45
 4919      AD000145 
 4920 68e8 60F7FFFF 		br.l	.L5.23
 4920      00000F18 
 4921              	.L5.49:
 4922 68f0 D0FFFFFF 		brlt.l	%s51,%s49,.L5.48
 4922      B1B30218 
 4923 68f8 00000000 		or	%s1,0,%s45
 4923      AD000145 
 4924 6900 00000000 		or	%s49,0,%s44
 4924      AC003145 
 4925 6908 00000000 		or	%s51,0,%s35
 4925      A3003345 
 4926 6910 00000000 		or	%s62,0,%s34
 4926      A2003E45 
 4927 6918 30F7FFFF 		br.l	.L5.23
 4927      00000F18 
 4928              	.L5.50:
 4929 6920 00000000 		or	%s62,0,%s63
 4929      BF003E45 
 4930 6928 C8FFFFFF 		br.l	.L5.49
 4930      00000F18 
 4931              	.L5.2:
 4932              	# line 2444
2444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (ow_beg < ow_end && oh_beg < oh_end) {
 4933              		.loc	1 2444 0
 4934 6930 00000000 		or	%s62,0,(0)1
 4934      00003E45 
 4935 6938 00000000 		lvl	%s60
 4935      00BC00BF 
 4936 6940 00000032 		vbrdu	%v50,%s62
 4936      00BE808C 
 4937 6948 00000000 		or	%s62,0,%s59
 4937      BB003E45 
 4938 6950 00000032 		vstu.nc	%v50,4,%s62
 4938      BE040092 
 4939 6958 00000000 		adds.l	%s59,%s59,%s58
 4939      BABB3B59 
 4940 6960 00000000 		subs.l	%s56,%s56,%s60
 4940      BCB8385B 
 4941 6968 B8FFFFFF 		brge.l	0,%s56,.L5.50
 4941      B8000518 
 4942 6970 00F2FFFF 		br.l	.L5.1
 4942      00000F18 
 4943              	.L5.51:
 4944 6978 00000000 		subs.l	%s61,0,%s53
 4944      B5003D5B 
 4945 6980 00000000 		smvl	%s57
 4945      0000392E 
 4946 6988 80000000 		mins.l	%s60,%s61,%s57
 4946      B9BD3C68 
 4947 6990 00000000 		or	%s56,0,%s61
 4947      BD003845 
 4948 6998 00000000 		or	%s59,0,%s52
 4948      B4003B45 
 4949 69a0 00000000 		muls.l	%s58,4,%s60
 4949      BC043A6E 
 4950 69a8 00000000 		or	%s63,0,%s62
 4950      BE003F45 
 4951 69b0 80FFFFFF 		br.l	.L5.2
 4951      00000F18 
 4952              	.L5.52:
 4953 69b8 C0FFFFFF 		brlt.l	0,%s19,.L5.51
 4953      93000218 
 4954 69c0 30FFFFFF 		br.l	.L5.49
 4954      00000F18 
 4955              	.L5.53:
 4956 69c8 00000000 		or	%s49,0,%s23
 4956      97003145 
 4957 69d0 E8FFFFFF 		br.l	.L5.52
 4957      00000F18 
 4958              	.L5.54:
 4959 69d8 F0FFFFFF 		brge.l	%s49,%s23,.L5.53
 4959      97B10518 
 4960 69e0 D8FFFFFF 		br.l	.L5.52
 4960      00000F18 
 4961              	.L5.55:
 4962              	# line 2441
2441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( ow_end >= OW ) ow_end = OW;
 4963              		.loc	1 2441 0
 4964 69e8 00000000 		divs.l	%s49,%s37,%s32
 4964      A0A5317F 
 4965 69f0 E8FFFFFF 		br.l	.L5.54
 4965      00000F18 
 4966              	.L5.56:
 4967 69f8 F0FFFFFF 		brgt.l	0,%s40,.L5.55
 4967      A8000118 
 4968 6a00 D8FFFFFF 		br.l	.L5.54
 4968      00000F18 
 4969              	.L5.57:
 4970              	# line 2440
2440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
 4971              		.loc	1 2440 0
 4972 6a08 00000000 		divs.l	%s51,%s38,%s32
 4972      A0A6337F 
 4973 6a10 E8FFFFFF 		br.l	.L5.56
 4973      00000F18 
 4974              	.L5.58:
 4975              	# line 2439
2439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kw*DW < PW ) ow_beg =    ((     PW - kw*DW) + SW-1)/ SW;
 4976              		.loc	1 2439 0
 4977 6a18 00000000 		or	%s51,0,(0)1
 4977      00003345 
 4978 6a20 00000000 		or	%s49,0,(0)1
 4978      00003145 
 4979 6a28 E0FFFFFF 		brgt.l	0,%s21,.L5.57
 4979      95000118 
 4980 6a30 C8FFFFFF 		br.l	.L5.56
 4980      00000F18 
 4981              	.L5.59:
 4982 6a38 00000000 		or	%s55,0,%s45
 4982      AD003745 
 4983 6a40 D8FFFFFF 		br.l	.L5.58
 4983      00000F18 
 4984              	.L5.60:
 4985 6a48 F0FFFFFF 		brge.l	%s55,%s45,.L5.59
 4985      ADB70518 
 4986 6a50 C8FFFFFF 		br.l	.L5.58
 4986      00000F18 
 4987              	.L5.61:
 4988              	# line 2437
2437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( oh_end >= OH ) oh_end = OH;
 4989              		.loc	1 2437 0
 4990 6a58 00000000 		divs.l	%s55,%s31,%s33
 4990      A19F377F 
 4991 6a60 E8FFFFFF 		br.l	.L5.60
 4991      00000F18 
 4992              	.L5.62:
 4993 6a68 F0FFFFFF 		brgt.l	0,%s22,.L5.61
 4993      96000118 
 4994 6a70 D8FFFFFF 		br.l	.L5.60
 4994      00000F18 
 4995              	.L5.63:
 4996              	# line 2436
2436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( kh*DH < IH+PH ) oh_end = (IH - ih0 + SH - 1) / SH;
 4997              		.loc	1 2436 0
 4998 6a78 00000000 		divs.l	%s62,%s42,%s33
 4998      A1AA3E7F 
 4999 6a80 E8FFFFFF 		br.l	.L5.62
 4999      00000F18 
 5000              	.L5.19:
 5001              	# line 2433
2433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             //if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
 5002              		.loc	1 2433 0
 5003 6a88 00000000 		or	%s62,0,(0)1
 5003      00003E45 
 5004 6a90 00000000 		or	%s55,0,(0)1
 5004      00003745 
 5005 6a98 E0FFFFFF 		brgt.l	0,%s20,.L5.63
 5005      94000118 
 5006 6aa0 C8FFFFFF 		br.l	.L5.62
 5006      00000F18 
 5007              	.L5.64:
 5008 6aa8 80F5FFFF 		st	%s47,-2688(,%fp)	# spill 
 5008      89002F11 
 5009 6ab0 78F5FFFF 		st	%s21,-2696(,%fp)	# spill 
 5009      89001511 
 5010 6ab8 70F5FFFF 		st	%s44,-2704(,%fp)	# spill 
 5010      89002C11 
 5011 6ac0 68F5FFFF 		st	%s43,-2712(,%fp)	# spill 
 5011      89002B11 
 5012 6ac8 60F5FFFF 		st	%s38,-2720(,%fp)	# spill 
 5012      89002611 
 5013 6ad0 58F5FFFF 		st	%s40,-2728(,%fp)	# spill 
 5013      89002811 
 5014 6ad8 50F5FFFF 		st	%s63,-2736(,%fp)	# spill 
 5014      89003F11 
 5015 6ae0 48F5FFFF 		st	%s61,-2744(,%fp)	# spill 
 5015      89003D11 
 5016 6ae8 40F5FFFF 		st	%s60,-2752(,%fp)	# spill 
 5016      89003C11 
 5017 6af0 38F5FFFF 		st	%s59,-2760(,%fp)	# spill 
 5017      89003B11 
 5018 6af8 30F5FFFF 		st	%s58,-2768(,%fp)	# spill 
 5018      89003A11 
 5019 6b00 00000000 		or	%s36,0,%s40
 5019      A8002445 
 5020 6b08 00000000 		or	%s47,0,%s38
 5020      A6002F45 
 5021 6b10 00000000 		or	%s43,0,%s63
 5021      BF002B45 
 5022 6b18 00000000 		or	%s40,0,%s61
 5022      BD002845 
 5023 6b20 00000000 		or	%s21,0,%s60
 5023      BC001545 
 5024 6b28 00000000 		or	%s38,0,%s59
 5024      BB002645 
 5025 6b30 00000000 		or	%s37,0,%s58
 5025      BA002545 
 5026 6b38 00000000 		or	%s34,0,%s62
 5026      BE002245 
 5027 6b40 00000000 		or	%s44,0,%s49
 5027      B1002C45 
 5028 6b48 40FFFFFF 		br.l	.L5.19
 5028      00000F18 
 5029              	.L5.16:
 5030              	# line 2426
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
 5031              		.loc	1 2426 0
 5032 6b50 00000000 		or	%s46,0,(0)1
 5032      00002E45 
 5033 6b58 50FFFFFF 		brlt.l	0,%s21,.L5.64
 5033      95000218 
 5034 6b60 C0F2FFFF 		br.l	.L5.15
 5034      00000F18 
 5035              	.L5.65:
 5036 6b68 28F5FFFF 		st	%s49,-2776(,%fp)	# spill 
 5036      89003111 
 5037 6b70 20F5FFFF 		st	%s46,-2784(,%fp)	# spill 
 5037      89002E11 
 5038 6b78 18F5FFFF 		st	%s40,-2792(,%fp)	# spill 
 5038      89002811 
 5039 6b80 10F5FFFF 		st	%s57,-2800(,%fp)	# spill 
 5039      89003911 
 5040 6b88 08F5FFFF 		st	%s56,-2808(,%fp)	# spill 
 5040      89003811 
 5041 6b90 00F5FFFF 		st	%s51,-2816(,%fp)	# spill 
 5041      89003311 
 5042 6b98 F8F4FFFF 		st	%s50,-2824(,%fp)	# spill 
 5042      89003211 
 5043 6ba0 F0F4FFFF 		st	%s48,-2832(,%fp)	# spill 
 5043      89003011 
 5044 6ba8 00000000 		or	%s49,0,%s40
 5044      A8003145 
 5045 6bb0 00000000 		or	%s22,0,%s57
 5045      B9001645 
 5046 6bb8 00000000 		or	%s20,0,%s56
 5046      B8001445 
 5047 6bc0 00000000 		or	%s42,0,%s51
 5047      B3002A45 
 5048 6bc8 00000000 		or	%s31,0,%s50
 5048      B2001F45 
 5049 6bd0 00000000 		or	%s40,0,%s48
 5049      B0002845 
 5050 6bd8 78FFFFFF 		br.l	.L5.16
 5050      00000F18 
 5051              	.L5.13:
 5052              	# line 2425
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 5053              		.loc	1 2425 0
 5054 6be0 00000000 		or	%s38,0,(0)1
 5054      00002645 
 5055 6be8 20000000 		ldl.sx	%s55,32(,%s62)	# *(p).__b_N4conv6desc_tE.kh
 5055      BE003703 
 5056 6bf0 00000000 		or	%s55,0,%s55
 5056      B7003745 
 5057 6bf8 70FFFFFF 		brlt.l	0,%s55,.L5.65
 5057      B7000218 
 5058 6c00 B0F1FFFF 		br.l	.L5.12
 5058      00000F18 
 5059              	.L5.66:
 5060 6c08 E8F4FFFF 		st	%s20,-2840(,%fp)	# spill 
 5060      89001411 
 5061 6c10 E0F4FFFF 		st	%s55,-2848(,%fp)	# spill 
 5061      89003711 
 5062 6c18 D8F4FFFF 		st	%s38,-2856(,%fp)	# spill 
 5062      89002611 
 5063 6c20 D0F4FFFF 		st	%s37,-2864(,%fp)	# spill 
 5063      89002511 
 5064 6c28 C8F4FFFF 		st	%s49,-2872(,%fp)	# spill 
 5064      89003111 
 5065 6c30 C0F4FFFF 		st	%s36,-2880(,%fp)	# spill 
 5065      89002411 
 5066 6c38 B8F4FFFF 		st	%s42,-2888(,%fp)	# spill 
 5066      89002A11 
 5067 6c40 B0F4FFFF 		st	%s34,-2896(,%fp)	# spill 
 5067      89002211 
 5068 6c48 A8F4FFFF 		st	%s3,-2904(,%fp)	# spill 
 5068      89000311 
 5069 6c50 00000000 		or	%s35,0,%s36
 5069      A4002345 
 5070 6c58 00000000 		or	%s49,0,%s42
 5070      AA003145 
 5071 6c60 C8F4FFFF 		ld	%s55,-2872(,%fp)	# restore 
 5071      89003701 
 5072              	# line 2424
2424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
 5073              		.loc	1 2424 0
 5074 6c68 00000000 		muls.l	%s55,%s55,%s46
 5074      AEB7376E 
 5075 6c70 00000000 		adds.l	%s34,%s55,%s34
 5075      A2B72259 
 5076 6c78 00000000 		or	%s28,0,%s34
 5076      A2001C45 
 5077              	# line 2425
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 5078              		.loc	1 2425 0
 5079 6c80 00000000 		adds.l	%s48,%s37,%s3
 5079      83A53059 
 5080 6c88 58FFFFFF 		br.l	.L5.13
 5080      00000F18 
 5081              	.L5.10:
 5082              	# line 2424
2424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
 5083              		.loc	1 2424 0
 5084 6c90 00000000 		or	%s40,0,(0)1
 5084      00002845 
 5085 6c98 70FFFFFF 		brlt.l	0,%s20,.L5.66
 5085      94000218 
 5086 6ca0 90F0FFFF 		br.l	.L5.9
 5086      00000F18 
 5087              	.L5.67:
 5088 6ca8 18F4FFFF 		st	%s3,-3048(,%fp)	# spill 
 5088      89000311 
 5089 6cb0 10F4FFFF 		st	%s4,-3056(,%fp)	# spill 
 5089      89000411 
 5090 6cb8 E0F5FFFF 		st	%s57,-2592(,%fp)	# spill 
 5090      89003911 
 5091 6cc0 90F5FFFF 		st	%s50,-2672(,%fp)	# spill 
 5091      89003211 
 5092 6cc8 E8F5FFFF 		st	%s61,-2584(,%fp)	# spill 
 5092      89003D11 
 5093 6cd0 30FEFFFF 		ld	%s48,-464(,%fp)	# MB
 5093      89003001 
 5094 6cd8 A0F4FFFF 		ld	%s62,-2912(,%fp)	# restore 
 5094      89003E01 
 5095              	# line 2464
2464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
 5096              		.loc	1 2464 0
 5097 6ce0 00000000 		subs.l	%s40,0,%s48
 5097      B000285B 
 5098              	# line 2427
2427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** 
 5099              		.loc	1 2427 0
 5100 6ce8 00000000 		subs.l	%s56,0,%s30
 5100      9E00385B 
 5101              	# line 2437
2437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( oh_end >= OH ) oh_end = OH;
 5102              		.loc	1 2437 0
 5103 6cf0 00000000 		adds.l	%s35,%s26,%s30
 5103      9E9A2359 
 5104 6cf8 00000000 		or	%s30,0,%s48
 5104      B0001E45 
 5105              	# line 2425
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 5106              		.loc	1 2425 0
 5107 6d00 00000000 		subs.l	%s57,0,%s35
 5107      A300395B 
 5108 6d08 00000000 		muls.l	%s48,%s27,%s56
 5108      B89B306E 
 5109              	# line 2441
2441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if( ow_end >= OW ) ow_end = OW;
 5110              		.loc	1 2441 0
 5111 6d10 00000000 		adds.l	%s35,%s27,%s31
 5111      9F9B2359 
 5112              	# line 2426
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
 5113              		.loc	1 2426 0
 5114 6d18 00000000 		subs.l	%s1,0,%s35
 5114      A300015B 
 5115 6d20 00000000 		subs.l	%s60,0,%s31
 5115      9F003C5B 
 5116              	# line 2425
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 5117              		.loc	1 2425 0
 5118 6d28 00000000 		subs.l	%s3,%s48,%s31
 5118      9FB0035B 
 5119 6d30 00000000 		or	%s48,0,%s63
 5119      BF003045 
 5120 6d38 88F5FFFF 		st	%s48,-2680(,%fp)	# spill 
 5120      89003011 
 5121 6d40 00000000 		or	%s48,0,%s32
 5121      A0003045 
 5122 6d48 00000000 		or	%s48,0,%s48
 5122      B0003045 
 5123 6d50 98F5FFFF 		st	%s48,-2664(,%fp)	# spill 
 5123      89003011 
 5124              	# line 2426
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
 5125              		.loc	1 2426 0
 5126 6d58 00000000 		adds.l	%s31,%s31,%s32
 5126      A09F1F59 
 5127 6d60 00000000 		adds.l	%s35,%s32,%s35
 5127      A3A02359 
 5128 6d68 F0FDFFFF 		dld	%s4,-528(,%fp)	# ohw_off
 5128      89000409 
 5129 6d70 C8FFFFFF 		dld	%s52,-56(,%fp)	# dw_ic
 5129      89003409 
 5130              	# line 2423
2423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
 5131              		.loc	1 2423 0
 5132 6d78 00000000 		subs.l	%s48,0,%s23
 5132      9700305B 
 5133 6d80 00000000 		or	%s23,0,%s63
 5133      BF001745 
 5134 6d88 00000000 		or	%s55,0,%s48
 5134      B0003745 
 5135              	# line 2424
2424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
 5136              		.loc	1 2424 0
 5137 6d90 00000000 		subs.l	%s42,0,%s20
 5137      94002A5B 
 5138 6d98 00000000 		muls.l	%s48,%s45,%s63
 5138      BFAD306E 
 5139              	# line 2453
2453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
 5140              		.loc	1 2453 0
 5141 6da0 00000000 		subs.l	%s0,0,%s45
 5141      AD00005B 
 5142              	# line 2423
2423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
 5143              		.loc	1 2423 0
 5144 6da8 00000000 		or	%s49,0,(0)1
 5144      00003145 
 5145 6db0 A8F5FFFF 		st	%s0,-2648(,%fp)	# spill 
 5145      89000011 
 5146 6db8 00000000 		or	%s37,0,(0)1
 5146      00002545 
 5147              	# line 2444
2444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             if (ow_beg < ow_end && oh_beg < oh_end) {
 5148              		.loc	1 2444 0
 5149 6dc0 00000000 		subs.l	%s53,0,%s19
 5149      9300355B 
 5150              	# line 2423
2423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
 5151              		.loc	1 2423 0
 5152 6dc8 00000000 		muls.l	%s38,%s19,%s61
 5152      BD93266E 
 5153              	# line 2424
2424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****         ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
 5154              		.loc	1 2424 0
 5155 6dd0 00000000 		muls.l	%s46,4,%s48
 5155      B0042E6E 
 5156              	# line 2453
2453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
 5157              		.loc	1 2453 0
 5158 6dd8 00000000 		muls.l	%s48,4,%s63
 5158      BF04306E 
 5159              	# line 2425
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 5160              		.loc	1 2425 0
 5161 6de0 00000000 		subs.l	%s44,0,%s47
 5161      AF002C5B 
 5162 6de8 00000000 		muls.l	%s43,%s27,%s47
 5162      AF9B2B6E 
 5163 6df0 A0F5FFFF 		st	%s48,-2656(,%fp)	# spill 
 5163      89003011 
 5164              	# line 2426
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
 5165              		.loc	1 2426 0
 5166 6df8 00000000 		adds.l	%s59,-1,%s31
 5166      9F7F3B59 
 5167 6e00 00000000 		adds.l	%s58,-1,%s35
 5167      A37F3A59 
 5168              	# line 2425
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****           ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 5169              		.loc	1 2425 0
 5170 6e08 00000000 		subs.l	%s48,%s33,%s56
 5170      B8A1305B 
 5171 6e10 00000000 		adds.l	%s51,-1,%s48
 5171      B07F3359 
 5172 6e18 00000000 		adds.l	%s50,%s26,%s51
 5172      B39A3259 
 5173              	# line 2426
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****             const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
 5174              		.loc	1 2426 0
 5175 6e20 00000000 		subs.l	%s63,0,%s21
 5175      95003F5B 
 5176 6e28 00000000 		subs.l	%s39,0,%s41
 5176      A900275B 
 5177              	# line 2464
2464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
 5178              		.loc	1 2464 0
 5179 6e30 00000000 		muls.l	%s6,%s25,%s61
 5179      BD99066E 
 5180 6e38 00000000 		or	%s61,0,%s1
 5180      81003D45 
 5181 6e40 00000000 		muls.l	%s7,4,%s28
 5181      9C04076E 
 5182              	# line 2480
2480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****               pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
 5183              		.loc	1 2480 0
 5184 6e48 00000000 		muls.l	%s2,4,%s29
 5184      9D04026E 
 5185              	# line 2466
2466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #if 1 || defined(_SX)
 5186              		.loc	1 2466 0
 5187 6e50 00000000 		subs.l	%s5,0,%s18
 5187      9200055B 
 5188 6e58 00000000 		or	%s29,0,%s40
 5188      A8001D45 
 5189 6e60 30FEFFFF 		br.l	.L5.10
 5189      00000F18 
 5190              	.L5.0:
 5191 6e68 B8FFFFFF 		lea	%s60,-72
 5191      00003C06 
 5192 6e70 00000000 		st	%s63,0(%s60,%fp)
 5192      89BC3F11 
 5193 6e78 00000000 		or	%s63,1,(0)1
 5193      00013F45 
 5194 6e80 00000000 		st2b	%s63,0(,%s24)
 5194      98003F14 
 5195              	# line 2401
2401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 5196              		.loc	1 2401 0
 5197 6e88 C8FFFFFF 		lea	%s63,-56
 5197      00003F06 
 5198 6e90 00000000 		adds.l	%s35,%fp,%s63
 5198      BF892359 
 5199 6e98 00000000 		muls.l	%s0,4,%s19
 5199      9304006E 
 5200 6ea0 00000000 		lea	%s12,__grow_stack@LO
 5200      00000C06 
 5201 6ea8 00000000 		and	%s12,%s12,(32)0
 5201      608C0C44 
 5202 6eb0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 5202      8C008C06 
 5203 6eb8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 5203      8C000A08 
 5204 6ec0 D0000000 		lea	%s63,208
 5204      00003F06 
 5205 6ec8 00000000 		adds.l	%s63,%sp,%s63
 5205      BF8B3F59 
 5206              	# line 2423
2423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
 5207              		.loc	1 2423 0
 5208 6ed0 00000000 		or	%s36,0,(0)1
 5208      00002445 
 5209              	# line 2401
2401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 5210              		.loc	1 2401 0
 5211 6ed8 00000000 		st	%s63,0(,%s35)
 5211      A3003F11 
 5212 6ee0 C8FFFFFF 		ld	%s63,-56(,%fp)	# dw_ic
 5212      89003F01 
 5213 6ee8 C0FFFFFF 		lea	%s60,-64
 5213      00003C06 
 5214 6ef0 00000000 		st	%s63,0(%s60,%fp)
 5214      89BC3F11 
 5215 6ef8 00000000 		or	%s63,2,(0)1
 5215      00023F45 
 5216 6f00 00000000 		st2b	%s63,0(,%s24)
 5216      98003F14 
 5217              	# line 2408
2408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp ****     float ohw_begend[4];
 5218              		.loc	1 2408 0
 5219 6f08 00000000 		or	%s24,-1,(0)1
 5219      007F1845 
 5220              	# line 2415
2415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv4.cpp **** #ifdef __ve
 5221              		.loc	1 2415 0
 5222 6f10 D8FFFFFF 		lea	%s63,-40
 5222      00003F06 
 5223 6f18 00000000 		adds.l	%s63,%fp,%s63
 5223      BF893F59 
 5224 6f20 00000000 		lea	%s60,.LP._ZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.ohw_muls.__initializer.2@LO
 5224      00003C06 
 5225 6f28 00000000 		and	%s60,%s60,(32)0
 5225      60BC3C44 
 5226 6f30 00000000 		lea.sl	%s60,.LP._ZN4conv14sxconv_4_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.ohw_muls.__initializer.2
 5226      BC00BC06 
 5227 6f38 00000000 		ld	%s59,0(,%s60)	# conflict.I64
 5227      BC003B01 
 5228 6f40 00000000 		st	%s59,0(,%s63)	# conflict.I64
 5228      BF003B11 
 5229 6f48 00000000 		adds.l	%s60,8,%s60
 5229      BC083C59 
 5230 6f50 00000000 		ld	%s60,0(,%s60)	# conflict.I64
 5230      BC003C01 
 5231 6f58 00000000 		adds.l	%s63,8,%s63
 5231      BF083F59 
 5232 6f60 00000000 		st	%s60,0(,%s63)	# conflict.I64
 5232      BF003C11 
 5233 6f68 20FEFFFF 		ld	%s45,-480(,%fp)	# OH
 5233      89002D01 
 5234 6f70 00000000 		cvt.d.l	%s63,%s45
 5234      00AD3F5F 
 5235 6f78 00000000 		cvt.s.d	%s63,%s63
 5235      00BF3F1F 
 5236 6f80 DCFFFFFF 		lea	%s60,-36
 5236      00003C06 
 5237 6f88 00000000 		stu	%s63,0(%s60,%fp)	# ohw_muls
 5237      89BC3F12 
 5238 6f90 18FEFFFF 		ld	%s63,-488(,%fp)	# OW
 5238      89003F01 
 5239 6f98 00000100 		lea	%s60,65536
 5239      00003C06 
 5240 6fa0 00000000 		muls.l	%s60,%s63,%s60
 5240      BCBF3C6E 
 5241 6fa8 00000000 		cvt.d.l	%s60,%s60
 5241      00BC3C5F 
 5242 6fb0 00000000 		cvt.s.d	%s60,%s60
 5242      00BC3C1F 
 5243 6fb8 E4FFFFFF 		lea	%s59,-28
 5243      00003B06 
 5244 6fc0 00000000 		stu	%s60,0(%s59,%fp)	# ohw_muls
 5244      89BB3C12 
 5245 6fc8 E0FCFFFF 		brlt.l	0,%s23,.L5.67
 5245      97000218 
 5246 6fd0 E8EBFFFF 		br.l	.L5.7
 5246      00000F18 
 5247              		.cfi_endproc
 5248              		.set	.L.6.2auto_size,	0xffffffffffffe960	# 5792 Bytes
 5250              	# ============ End  conv::sxconv_4_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
