   1              		.ident "nc++ 1.5.2 (Build 11:19:31 Oct  2 2018)"
   2              		.file "ref_conv2.cpp"
   3              		.file 1 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp"
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
  41              	# ============ Begin  _ZZN4conv13refconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_Rfiiii
  42              		.text
  43              		.balign 16
  44              	# line 52
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** /*******************************************************************************
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * Copyright 2017 NEC Laboratories America
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** *
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * Licensed under the Apache License, Version 2.0 (the "License");
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * you may not use this file except in compliance with the License.
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * You may obtain a copy of the License at
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** *
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** *     http://www.apache.org/licenses/LICENSE-2.0
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** *
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * Unless required by applicable law or agreed to in writing, software
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * distributed under the License is distributed on an "AS IS" BASIS,
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * See the License for the specific language governing permissions and
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** * limitations under the License.
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** *******************************************************************************/
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** /** \file
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****  * no lambda parms by reference, test_conv_regression avg speedup = 1.557 x */
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #include "conv/conv.hpp"
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define G  p->g
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define MB p->mb
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define IC p->ic
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define OC p->oc
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define KH p->kh
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define IH p->ih
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define OH p->oh
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define SH p->sh
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define PH p->ph
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define KW p->kw
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define IW p->iw
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define OW p->ow
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define SW p->sw
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define PW p->pw
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** namespace conv {
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** // no effect for x86+gcc
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** //#define IVDEPx()
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #define IVDEPx() IVDEP()
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** extern void compute_ref_fwd(const prb_t *p, dnn_mem_t &src_m,
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m);
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** void refconv_2_fwd(const prb_t *p, dnn_mem_t &src_m,
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                    dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //char attr_buf[max_attr_len];
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //attr2str(&p->attr, attr_buf);
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //print(40,__FILE__ " fwd p->attr is %s\n", attr_buf);
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   auto ker = []( const prb_t *p, const float * restrict psrc, const float * restrict pwei,
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                  float &d, int g, int mb, int oc, int oh, int ow) {
  45              		.loc	1 52 0
  47              	conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float const*, float const*, float&, int, int, int, int, int)#1}::operator()(conv::prb_t const*, float const*, float const*, float&, int, int, int, int) const
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
  57 0028 30000000 		st	%s18,48(,%fp)
  57      89001211 
  58 0030 38000000 		st	%s19,56(,%fp)
  58      89001311 
  59 0038 78000000 		st	%s27,120(,%fp)
  59      89001B11 
  60 0040 80000000 		st	%s28,128(,%fp)
  60      89001C11 
  61 0048 88000000 		st	%s29,136(,%fp)
  61      89001D11 
  62 0050 90000000 		st	%s30,144(,%fp)
  62      89001E11 
  63 0058 98000000 		st	%s31,152(,%fp)
  63      89001F11 
  64 0060 A0000000 		st	%s32,160(,%fp)
  64      89002011 
  65 0068 A8000000 		st	%s33,168(,%fp)
  65      89002111 
  66 0070 00FFFFFF 		lea	%s13,.L.1.2auto_size&0xffffffff
  66      00000D06 
  67 0078 00000000 		and	%s13,%s13,(32)0
  67      608D0D44 
  68 0080 FFFFFFFF 		lea.sl	%sp,.L.1.2auto_size>>32(%fp,%s13)
  68      8D898B06 
  69 0088 48000000 		brge.l.t	%sp,%sl,.L0.EoP
  69      888B3518 
  70 0090 18000000 		ld	%s61,0x18(,%tp)
  70      8E003D01 
  71 0098 00000000 		or	%s62,0,%s0
  71      80003E45 
  72 00a0 3B010000 		lea	%s63,0x13b
  72      00003F06 
  73 00a8 00000000 		shm.l	%s63,0x0(%s61)
  73      BD033F31 
  74 00b0 08000000 		shm.l	%sl,0x8(%s61)
  74      BD030831 
  75 00b8 10000000 		shm.l	%sp,0x10(%s61)
  75      BD030B31 
  76 00c0 00000000 		monc
  76      0000003F 
  77 00c8 00000000 		or	%s0,0,%s62
  77      BE000045 
  78              	.L0.EoP:
  79              	# End of prologue codes
  80              	# line 53
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int ic = 0; ic < IC/G; ++ic) {
  81              		.loc	1 53 0
  82 00d0 00000000 		or	%s61,0,(0)1
  82      00003D45 
  83 00d8 08000000 		ldl.sx	%s63,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
  83      81003F03 
  84 00e0 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
  84      81003E03 
  85 00e8 00000000 		divs.w.sx	%s62,%s63,%s62
  85      BEBF3E7B 
  86 00f0 58040000 		brlt.w	0,%s62,.L0.0
  86      BE008218 
  87 00f8 F8020000 		br.l	.L0.1
  87      00000F18 
  88              	.L0.2:
  89              	# line 63
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int kh = 0; kh < KH; ++kh) {
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         const int ih = oh * SH - PH + kh * (p->dh + 1);
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         if (ih < 0 || ih >= IH) continue;
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int kw = 0; kw < KW; ++kw) {
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           if (iw < 0 || iw >= IW) continue;
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
  90              		.loc	1 63 0
  91 0100 00000000 		divs.w.sx	%s54,%s56,%s55
  91      B7B8367B 
  92 0108 00000000 		or	%s54,0,%s54
  92      B6003645 
  93 0110 00000000 		addu.l	%s54,%s54,%s53
  93      B5B63648 
  94 0118 00000000 		addu.l	%s54,%s54,%s52
  94      B4B63648 
  95 0120 00000000 		mulu.l	%s54,%s54,%s51
  95      B3B63649 
  96 0128 00000000 		addu.l	%s54,%s54,%s50
  96      B2B63648 
  97 0130 00000000 		mulu.l	%s54,%s54,%s49
  97      B1B63649 
  98 0138 00000000 		lvl	%s62
  98      00BE00BF 
  99 0140 003F0033 		vadds.w.sx	%v51,%s63,%v63
  99      00BF20CA 
 100 0148 0033003B 		vor	%v59,(0)1,%v51,%vm15
 100      00002FC5 
 101 0150 003B003A 		vaddu.l	%v58,%s54,%v59,%vm15
 101      00B62FC8 
 102              	# line 64
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 103              		.loc	1 64 0
 104 0158 00000000 		divu.l	%s54,%s48,%s47
 104      AFB0366F 
 105 0160 00000000 		addu.l	%s54,%s54,%s46
 105      AEB63648 
 106 0168 00000000 		mulu.l	%s54,%s54,%s45
 106      ADB63649 
 107 0170 00000000 		divu.l	%s54,%s54,%s47
 107      AFB6366F 
 108 0178 00000000 		addu.l	%s54,%s52,%s54
 108      B6B43648 
 109 0180 00000000 		mulu.l	%s54,%s54,%s44
 109      ACB63649 
 110 0188 00000000 		addu.l	%s54,%s54,%s43
 110      ABB63648 
 111 0190 00000000 		mulu.l	%s54,%s54,%s42
 111      AAB63649 
 112 0198 00390032 		vadds.w.sx	%v50,%s60,%v57
 112      00BC20CA 
 113 01a0 00320038 		vor	%v56,(0)1,%v50,%vm15
 113      00002FC5 
 114 01a8 00380037 		vaddu.l	%v55,%s54,%v56,%vm15
 114      00B62FC8 
 115              	# line 66
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           d += psrc[src_off] * pwei[wei_off];
 116              		.loc	1 66 0
 117 01b0 003A0036 		vsfa	%v54,%v58,2,%s41,%vm15
 117      A9020FD7 
 118 01b8 00000031 		vbrd	%v49,0
 118      0000008C 
 119 01c0 00003631 		vgtu	%v49,%v54,0,0,%vm15
 119      00004FA2 
 120 01c8 00370035 		vsfa	%v53,%v55,2,%s40,%vm15
 120      A8020FD7 
 121 01d0 00000030 		vbrd	%v48,0
 121      0000008C 
 122 01d8 00003530 		vgtu	%v48,%v53,0,0,%vm15
 122      00004FA2 
 123 01e0 31303434 		vfmad.s	%v52,%v52,%v48,%v49,%vm15
 123      00008FE2 
 124 01e8 B0000000 		br.l	.L0.3
 124      00000F18 
 125              	.L0.4:
 126              	# line 59
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
 127              		.loc	1 59 0
 128 01f0 80000000 		mins.w.sx	%s62,%s57,%s62
 128      BEB93E78 
 129 01f8 D0000000 		br.l	.L0.5
 129      00000F18 
 130              	.L0.6:
 131              	# line 66
 132              		.loc	1 66 0
 133 0200 00000000 		or	%s59,1,(0)1
 133      00013B45 
 134 0208 00000000 		or	%s58,0,%s39
 134      A7003A45 
 135 0210 00000000 		lvl	%s59
 135      00BB00BF 
 136 0218 0000002F 		vldu.nc	%v47,0,%s58
 136      BA000082 
 137 0220 00000000 		lvl	%s38
 137      00A600BF 
 138 0228 0000342E 		vfsum.s	%v46,%v52
 138      000080EC 
 139 0230 00000000 		or	%s59,1,(0)1
 139      00013B45 
 140 0238 00000000 		lvl	%s59
 140      00BB00BF 
 141 0240 002E2F2D 		vfadd.s	%v45,%v47,%v46
 141      000080CC 
 142 0248 00000000 		or	%s59,1,(0)1
 142      00013B45 
 143 0250 00000000 		or	%s58,0,%s39
 143      A7003A45 
 144 0258 00000000 		lvl	%s59
 144      00BB00BF 
 145 0260 0000002D 		vstu.nc	%v45,0,%s58
 145      BA000092 
 146 0268 00000000 		or	%s60,0,%s37
 146      A5003C45 
 147 0270 00000000 		or	%s18,0,%s36
 147      A4001245 
 148 0278 00000000 		or	%s61,0,%s35
 148      A3003D45 
 149 0280 00000000 		or	%s62,0,%s34
 149      A2003E45 
 150 0288 00000000 		or	%s63,0,%s7
 150      87003F45 
 151 0290 20020000 		br.l	.L0.7
 151      00000F18 
 152              	.L0.3:
 153              	# line 59
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
 154              		.loc	1 59 0
 155 0298 00000000 		adds.w.sx	%s60,%s60,%s59
 155      BBBC3C4A 
 156 02a0 00000000 		adds.w.sx	%s63,%s63,%s58
 156      BABF3F4A 
 157 02a8 00000000 		adds.w.sx	%s61,%s61,%s58
 157      BABD3D4A 
 158 02b0 00000000 		subs.w.sx	%s57,%s57,%s62
 158      BEB9395A 
 159 02b8 48FFFFFF 		brge.w	0,%s57,.L0.6
 159      B9008518 
 160 02c0 30FFFFFF 		br.l	.L0.4
 160      00000F18 
 161              	.L0.5:
 162              	# line 61
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 163              		.loc	1 61 0
 164 02c8 00000000 		lvl	%s62
 164      00BE00BF 
 165 02d0 003F003E 		vadds.w.sx	%v62,%s63,%v63
 165      00BF20CA 
 166 02d8 003E050F 		vfmk.w.ge	%vm15,%v62
 166      000000B5 
 167 02e0 003D003C 		vadds.w.sx	%v60,%s61,%v61
 167      00BD20CA 
 168 02e8 003C020F 		vfmk.w.lt	%vm15,%v60,%vm15
 168      00000FB5 
 169 02f0 00000F00 		pcvm	%s18,%vm15
 169      000012A4 
 170 02f8 A0FFFFFF 		brge.w	0,%s18,.L0.3
 170      92008518 
 171 0300 00FEFFFF 		br.l	.L0.2
 171      00000F18 
 172              	.L0.8:
 173 0308 00000000 		or	%s50,0,%s18
 173      92003245 
 174 0310 00000000 		or	%s43,0,%s60
 174      BC002B45 
 175 0318 00000000 		or	%s34,0,%s62
 175      BE002245 
 176 0320 00000000 		or	%s37,0,%s60
 176      BC002545 
 177 0328 00000000 		or	%s36,0,%s18
 177      92002445 
 178 0330 00000000 		or	%s35,0,%s61
 178      BD002345 
 179 0338 00000000 		or	%s61,0,%s33
 179      A1003D45 
 180              	# line 59
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
 181              		.loc	1 59 0
 182 0340 00000000 		subs.w.sx	%s54,0,%s32
 182      A000365A 
 183 0348 00000000 		smvl	%s38
 183      0000262E 
 184 0350 80000000 		mins.w.sx	%s62,%s54,%s38
 184      A6B63E78 
 185              	# line 66
 186              		.loc	1 66 0
 187 0358 00000000 		or	%s6,0,(0)1
 187      00000645 
 188 0360 00000000 		or	%s7,0,%s63
 188      BF000745 
 189 0368 00000000 		lvl	%s38
 189      00A600BF 
 190 0370 00000034 		vbrdu	%v52,%s6
 190      0086808C 
 191 0378 00000000 		or	%s57,0,%s54
 191      B6003945 
 192              	# line 59
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
 193              		.loc	1 59 0
 194 0380 00000000 		or	%s60,0,(0)1
 194      00003C45 
 195 0388 00000000 		or	%s59,0,%s62
 195      BE003B45 
 196 0390 00000000 		lvl	%s62
 196      00BE00BF 
 197 0398 0000002C 		vseq	%v44
 197      00000099 
 198 03a0 002C0039 		vor	%v57,(0)1,%v44
 198      000020C5 
 199 03a8 00000000 		or	%s63,0,%s31
 199      9F003F45 
 200 03b0 002C003F 		vmuls.w.sx	%v63,%s30,%v44
 200      009E20CB 
 201 03b8 00000000 		muls.w.sx	%s58,%s30,%s62
 201      BE9E3A4B 
 202 03c0 002C003D 		vmuls.w.sx	%v61,%s30,%v44
 202      009E20CB 
 203 03c8 00FFFFFF 		br.l	.L0.5
 203      00000F18 
 204              	.L0.9:
 205 03d0 38FFFFFF 		brlt.w	0,%s19,.L0.8
 205      93008218 
 206 03d8 D8000000 		br.l	.L0.7
 206      00000F18 
 207              	.L0.10:
 208 03e0 D0000000 		brle.w	0,%s61,.L0.7
 208      BD008618 
 209 03e8 E8FFFFFF 		br.l	.L0.9
 209      00000F18 
 210              	.L0.1:
 211              	# line 70
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   };
 212              		.loc	1 70 0
 213              	# Start of epilogue codes
 214 03f0 30000000 		ld	%s18,48(,%fp)
 214      89001201 
 215 03f8 38000000 		ld	%s19,56(,%fp)
 215      89001301 
 216 0400 78000000 		ld	%s27,120(,%fp)
 216      89001B01 
 217 0408 80000000 		ld	%s28,128(,%fp)
 217      89001C01 
 218 0410 88000000 		ld	%s29,136(,%fp)
 218      89001D01 
 219 0418 90000000 		ld	%s30,144(,%fp)
 219      89001E01 
 220 0420 98000000 		ld	%s31,152(,%fp)
 220      89001F01 
 221 0428 A0000000 		ld	%s32,160(,%fp)
 221      89002001 
 222 0430 A8000000 		ld	%s33,168(,%fp)
 222      89002101 
 223 0438 00000000 		or	%sp,0,%fp
 223      89000B45 
 224              		.cfi_def_cfa	11,8
 225 0440 18000000 		ld	%got,0x18(,%sp)
 225      8B000F01 
 226 0448 20000000 		ld	%plt,0x20(,%sp)
 226      8B001001 
 227 0450 08000000 		ld	%lr,0x8(,%sp)
 227      8B000A01 
 228 0458 00000000 		ld	%fp,0x0(,%sp)
 228      8B000901 
 229 0460 00000000 		b.l	(,%lr)
 229      8A000F19 
 230              	.L0.11:
 231 0468 88FFFFFF 		br.l	.L0.1
 231      00000F18 
 232              	.L0.12:
 233              	# line 53
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int kh = 0; kh < KH; ++kh) {
 234              		.loc	1 53 0
 235 0470 00000000 		adds.w.sx	%s63,1,%s63
 235      BF013F4A 
 236 0478 00000000 		adds.w.sx	%s61,1,%s61
 236      BD013D4A 
 237 0480 B0000000 		brgt.w	0,%s63,.L0.13
 237      BF008118 
 238 0488 E0FFFFFF 		br.l	.L0.11
 238      00000F18 
 239              	.L0.14:
 240 0490 00000000 		or	%s63,0,%s2
 240      82003F45 
 241 0498 00000000 		or	%s61,0,%s3
 241      83003D45 
 242 04a0 00000000 		or	%s18,0,%s1
 242      81001245 
 243 04a8 C8FFFFFF 		br.l	.L0.12
 243      00000F18 
 244              	.L0.7:
 245              	# line 54
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         const int ih = oh * SH - PH + kh * (p->dh + 1);
 246              		.loc	1 54 0
 247 04b0 00000000 		adds.w.sx	%s63,1,%s63
 247      BF013F4A 
 248 04b8 00000000 		adds.w.sx	%s61,%s62,%s61
 248      BDBE3D4A 
 249 04c0 00000000 		adds.w.sx	%s18,%s62,%s18
 249      92BE124A 
 250 04c8 00000000 		adds.w.sx	%s60,1,%s60
 250      BC013C4A 
 251 04d0 10000000 		brgt.w	0,%s63,.L0.15
 251      BF008118 
 252 04d8 B8FFFFFF 		br.l	.L0.14
 252      00000F18 
 253              	.L0.15:
 254 04e0 D0FFFFFF 		brgt.w	0,%s18,.L0.7
 254      92008118 
 255 04e8 F8FEFFFF 		br.l	.L0.10
 255      00000F18 
 256              	.L0.16:
 257 04f0 00000000 		or	%s52,0,%s61
 257      BD003445 
 258 04f8 00000000 		or	%s1,0,%s18
 258      92000145 
 259 0500 00000000 		or	%s2,0,%s63
 259      BF000245 
 260 0508 00000000 		or	%s63,0,%s29
 260      9D003F45 
 261 0510 00000000 		or	%s3,0,%s61
 261      BD000345 
 262 0518 00000000 		or	%s61,0,%s28
 262      9C003D45 
 263 0520 00000000 		or	%s18,0,%s27
 263      9B001245 
 264 0528 B8FFFFFF 		br.l	.L0.15
 264      00000F18 
 265              	.L0.13:
 266 0530 00000000 		or	%s60,0,(0)1
 266      00003C45 
 267 0538 B8FFFFFF 		brlt.w	0,%s18,.L0.16
 267      92008218 
 268 0540 30FFFFFF 		br.l	.L0.12
 268      00000F18 
 269              	.L0.0:
 270 0548 20000000 		dldl.sx	%s18,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 270      8100120B 
 271 0550 00000000 		or	%s41,0,%s2
 271      82002945 
 272 0558 00000000 		or	%s40,0,%s3
 272      83002845 
 273 0560 00000000 		subs.w.sx	%s29,0,%s18
 273      92001D5A 
 274              	# line 55
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         if (ih < 0 || ih >= IH) continue;
 275              		.loc	1 55 0
 276 0568 F0000000 		dldl.sx	%s60,240(,%fp)	# oh
 276      89003C0B 
 277 0570 00000000 		or	%s39,0,%s4
 277      84002745 
 278 0578 28000000 		dldl.sx	%s59,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 278      81003B0B 
 279 0580 00000000 		muls.w.sx	%s59,%s60,%s59
 279      BBBC3B4B 
 280 0588 30000000 		dldl.sx	%s60,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 280      81003C0B 
 281 0590 00000000 		subs.w.sx	%s27,%s59,%s60
 281      BCBB1B5A 
 282 0598 38000000 		dldl.sx	%s60,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 282      81003C0B 
 283 05a0 00000000 		adds.w.sx	%s60,1,%s60
 283      BC013C4A 
 284              	# line 53
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int kh = 0; kh < KH; ++kh) {
 285              		.loc	1 53 0
 286 05a8 00000000 		subs.w.sx	%s59,0,%s62
 286      BE003B5A 
 287 05b0 00000000 		or	%s62,0,%s60
 287      BC003E45 
 288 05b8 00000000 		or	%s63,0,%s59
 288      BB003F45 
 289              	# line 56
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 290              		.loc	1 56 0
 291 05c0 0C000000 		dldl.sx	%s60,12(,%s1)	# *(p).__b_N4conv6desc_tE.ih
 291      81003C0B 
 292              	# line 54
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         const int ih = oh * SH - PH + kh * (p->dh + 1);
 293              		.loc	1 54 0
 294 05c8 00000000 		subs.w.sx	%s28,%s27,%s60
 294      BC9B1C5A 
 295              	# line 59
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
 296              		.loc	1 59 0
 297 05d0 24000000 		dldl.sx	%s19,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 297      8100130B 
 298 05d8 00000000 		or	%s42,0,%s19
 298      93002A45 
 299 05e0 00000000 		subs.w.sx	%s32,0,%s19
 299      9300205A 
 300              	# line 60
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           if (iw < 0 || iw >= IW) continue;
 301              		.loc	1 60 0
 302 05e8 F8000000 		dldl.sx	%s60,248(,%fp)	# ow
 302      89003C0B 
 303 05f0 2C000000 		dldl.sx	%s59,44(,%s1)	# *(p).__b_N4conv6desc_tE.sw
 303      81003B0B 
 304 05f8 00000000 		muls.w.sx	%s59,%s60,%s59
 304      BBBC3B4B 
 305 0600 34000000 		dldl.sx	%s60,52(,%s1)	# *(p).__b_N4conv6desc_tE.pw
 305      81003C0B 
 306 0608 00000000 		subs.w.sx	%s31,%s59,%s60
 306      BCBB1F5A 
 307 0610 3C000000 		dldl.sx	%s60,60(,%s1)	# *(p).__b_N4conv6desc_tE.dw
 307      81003C0B 
 308 0618 00000000 		adds.w.sx	%s30,1,%s60
 308      BC011E4A 
 309              	# line 61
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 310              		.loc	1 61 0
 311 0620 10000000 		dldl.sx	%s60,16(,%s1)	# *(p).__b_N4conv6desc_tE.iw
 311      81003C0B 
 312 0628 00000000 		or	%s49,0,%s60
 312      BC003145 
 313              	# line 59
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
 314              		.loc	1 59 0
 315 0630 00000000 		subs.w.sx	%s33,%s31,%s60
 315      BC9F215A 
 316 0638 00000000 		or	%s6,0,%s6
 316      86000645 
 317              	# line 63
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 318              		.loc	1 63 0
 319 0640 08000000 		dldl.sx	%s60,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 319      81003C0B 
 320 0648 00000000 		or	%s45,0,%s60
 320      BC002D45 
 321 0650 00000000 		mulu.l	%s53,%s6,%s45
 321      AD863549 
 322 0658 00000000 		muls.w.sx	%s56,%s5,%s60
 322      BC85384B 
 323 0660 00000000 		or	%s5,0,%s5
 323      85000545 
 324 0668 00000000 		dldl.sx	%s55,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 324      8100370B 
 325 0670 00000000 		or	%s47,0,%s55
 325      B7002F45 
 326 0678 0C000000 		dldl.sx	%s60,12(,%s1)	# *(p).__b_N4conv6desc_tE.ih
 326      81003C0B 
 327 0680 00000000 		or	%s51,0,%s60
 327      BC003345 
 328              	# line 64
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 329              		.loc	1 64 0
 330 0688 14000000 		dldl.sx	%s60,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 330      81003C0B 
 331 0690 00000000 		or	%s60,0,%s60
 331      BC003C45 
 332 0698 00000000 		mulu.l	%s48,%s5,%s60
 332      BC853049 
 333 06a0 00000000 		or	%s46,0,%s7
 333      87002E45 
 334 06a8 20000000 		dldl.sx	%s1,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 334      8100010B 
 335 06b0 00000000 		or	%s44,0,%s1
 335      81002C45 
 336 06b8 78FEFFFF 		br.l	.L0.13
 336      00000F18 
 337              		.cfi_endproc
 338              		.set	.L.1.2auto_size,	0xffffffffffffff00	# 256 Bytes
 340              	# ============ End  _ZZN4conv13refconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_RfiiiiiE
 341              	# ============ Begin  _ZZN4conv13refconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_RfiE_clES2_S
 342              		.balign 16
 343              	# line 71
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   auto maybe_scale = [](const prb_t *p, float &d, int oc) {
 344              		.loc	1 71 0
 346              	conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, int)#1}::operator()(conv::prb_t const*, float&, int) const:
 347              		.cfi_startproc
 348 06c0 00000000 		st	%fp,0x0(,%sp)
 348      8B000911 
 349              		.cfi_def_cfa_offset	0
 350              		.cfi_offset	9,0
 351 06c8 08000000 		st	%lr,0x8(,%sp)
 351      8B000A11 
 352 06d0 18000000 		st	%got,0x18(,%sp)
 352      8B000F11 
 353 06d8 20000000 		st	%plt,0x20(,%sp)
 353      8B001011 
 354 06e0 00000000 		or	%fp,0,%sp
 354      8B000945 
 355              		.cfi_def_cfa_register	9
 356 06e8 00FFFFFF 		lea	%s13,.L.2.2auto_size&0xffffffff
 356      00000D06 
 357 06f0 00000000 		and	%s13,%s13,(32)0
 357      608D0D44 
 358 06f8 FFFFFFFF 		lea.sl	%sp,.L.2.2auto_size>>32(%fp,%s13)
 358      8D898B06 
 359 0700 48000000 		brge.l.t	%sp,%sl,.L1.EoP
 359      888B3518 
 360 0708 18000000 		ld	%s61,0x18(,%tp)
 360      8E003D01 
 361 0710 00000000 		or	%s62,0,%s0
 361      80003E45 
 362 0718 3B010000 		lea	%s63,0x13b
 362      00003F06 
 363 0720 00000000 		shm.l	%s63,0x0(%s61)
 363      BD033F31 
 364 0728 08000000 		shm.l	%sl,0x8(%s61)
 364      BD030831 
 365 0730 10000000 		shm.l	%sp,0x10(%s61)
 365      BD030B31 
 366 0738 00000000 		monc
 366      0000003F 
 367 0740 00000000 		or	%s0,0,%s62
 367      BE000045 
 368              	.L1.EoP:
 369              	# End of prologue codes
 370              	# line 72
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (!p->attr.oscale.is_def()) {
 371              		.loc	1 72 0
 372 0748 64000000 		ldl.zx	%s63,100(,%s1)	# *(p).attr.oscale.policy
 372      8100BF03 
 373 0750 38000000 		lea	%s62,56
 373      00003E06 
 374 0758 00000000 		adds.w.sx	%s63,0,%s63
 374      BF003F4A 
 375 0760 38000000 		lea	%s61,56
 375      00003D06 
 376 0768 00000000 		cmps.w.sx	%s63,%s63,(0)1
 376      00BF3F7A 
 377 0770 00000000 		or	%s60,0,(0)1
 377      00003C45 
 378 0778 84000000 		cmov.w.eq	%s60,(63)0,%s63
 378      7FBF3C3B 
 379 0780 00000000 		sll	%s60,%s60,%s62
 379      BCBE3C65 
 380 0788 00000000 		sra.l	%s60,%s60,%s61
 380      BCBD3C77 
 381 0790 00000000 		or	%s60,0,%s60
 381      BC003C45 
 382 0798 A8000000 		breq.w	0,%s60,.L1.0
 382      BC008418 
 383 07a0 48000000 		br.l	.L1.1
 383      00000F18 
 384              	.L1.2:
 385              	# line 78
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       using policy_t = attr_t::scale_t::policy_t;
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       const auto &s = p->attr.oscale;
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       if (s.policy == policy_t::COMMON) {
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         d *= s.scale;
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       } else {
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         d *= p->scales[oc];
 386              		.loc	1 78 0
 387 07a8 00000000 		ldu	%s63,0(,%s2)	# *(d)
 387      82003F02 
 388 07b0 00000000 		or	%s3,0,%s3
 388      83000345 
 389 07b8 B8000000 		ld	%s1,184(,%s1)	# *(p).scales
 389      81000101 
 390 07c0 00000000 		muls.l	%s3,4,%s3
 390      8304036E 
 391 07c8 00000000 		ldu	%s3,0(%s3,%s1)	# *(*(p).scales)
 391      81830302 
 392 07d0 00000000 		fmul.s	%s3,%s63,%s3
 392      83BF834D 
 393 07d8 00000000 		stu	%s3,0(,%s2)	# *(d)
 393      82000312 
 394 07e0 08000000 		br.l	.L1.1
 394      00000F18 
 395              	.L1.1:
 396              	# line 81
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   };
 397              		.loc	1 81 0
 398              	# Start of epilogue codes
 399 07e8 00000000 		or	%sp,0,%fp
 399      89000B45 
 400              		.cfi_def_cfa	11,8
 401 07f0 18000000 		ld	%got,0x18(,%sp)
 401      8B000F01 
 402 07f8 20000000 		ld	%plt,0x20(,%sp)
 402      8B001001 
 403 0800 08000000 		ld	%lr,0x8(,%sp)
 403      8B000A01 
 404 0808 00000000 		ld	%fp,0x0(,%sp)
 404      8B000901 
 405 0810 00000000 		b.l	(,%lr)
 405      8A000F19 
 406              	.L1.3:
 407              	# line 76
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       } else {
 408              		.loc	1 76 0
 409 0818 00000000 		ldu	%s62,0(,%s2)	# *(d)
 409      82003E02 
 410 0820 04000000 		ldu	%s63,4(,%s63)	# *(s).scale
 410      BF003F02 
 411 0828 00000000 		fmul.s	%s63,%s62,%s63
 411      BFBEBF4D 
 412 0830 00000000 		stu	%s63,0(,%s2)	# *(d)
 412      82003F12 
 413 0838 B0FFFFFF 		br.l	.L1.1
 413      00000F18 
 414              	.L1.0:
 415              	# line 74
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       if (s.policy == policy_t::COMMON) {
 416              		.loc	1 74 0
 417 0840 64000000 		lea	%s63,100
 417      00003F06 
 418 0848 00000000 		adds.l	%s63,%s1,%s63
 418      BF813F59 
 419              	# line 75
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         d *= s.scale;
 420              		.loc	1 75 0
 421 0850 00000000 		ldl.zx	%s62,0(,%s63)	# *(s).policy
 421      BF00BE03 
 422 0858 00000000 		adds.w.sx	%s62,0,%s62
 422      BE003E4A 
 423 0860 B8FFFFFF 		breq.w	1,%s62,.L1.3
 423      BE018418 
 424 0868 40FFFFFF 		br.l	.L1.2
 424      00000F18 
 425              		.cfi_endproc
 426              		.set	.L.2.2auto_size,	0xffffffffffffff00	# 256 Bytes
 428              	# ============ End  conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, int)#1}::operator()(conv::prb_t const*, float&) const
 429              	# ============ Begin  _ZZN4conv13refconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_RffE_clES2_S
 430              		.balign 16
 431              	# line 82
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   auto maybe_post_ops = [](const prb_t *p, float &d, float const dst) {
 432              		.loc	1 82 0
 434              	conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, float)#1}::operator()(conv::prb_t const*, float&, float) const:
 435              		.cfi_startproc
 436 0870 00000000 		st	%fp,0x0(,%sp)
 436      8B000911 
 437              		.cfi_def_cfa_offset	0
 438              		.cfi_offset	9,0
 439 0878 08000000 		st	%lr,0x8(,%sp)
 439      8B000A11 
 440 0880 18000000 		st	%got,0x18(,%sp)
 440      8B000F11 
 441 0888 20000000 		st	%plt,0x20(,%sp)
 441      8B001011 
 442 0890 00000000 		or	%fp,0,%sp
 442      8B000945 
 443              		.cfi_def_cfa_register	9
 444 0898 30000000 		st	%s18,48(,%fp)
 444      89001211 
 445 08a0 38000000 		st	%s19,56(,%fp)
 445      89001311 
 446 08a8 00FFFFFF 		lea	%s13,.L.3.2auto_size&0xffffffff
 446      00000D06 
 447 08b0 00000000 		and	%s13,%s13,(32)0
 447      608D0D44 
 448 08b8 FFFFFFFF 		lea.sl	%sp,.L.3.2auto_size>>32(%fp,%s13)
 448      8D898B06 
 449 08c0 48000000 		brge.l.t	%sp,%sl,.L2.EoP
 449      888B3518 
 450 08c8 18000000 		ld	%s61,0x18(,%tp)
 450      8E003D01 
 451 08d0 00000000 		or	%s62,0,%s0
 451      80003E45 
 452 08d8 3B010000 		lea	%s63,0x13b
 452      00003F06 
 453 08e0 00000000 		shm.l	%s63,0x0(%s61)
 453      BD033F31 
 454 08e8 08000000 		shm.l	%sl,0x8(%s61)
 454      BD030831 
 455 08f0 10000000 		shm.l	%sp,0x10(%s61)
 455      BD030B31 
 456 08f8 00000000 		monc
 456      0000003F 
 457 0900 00000000 		or	%s0,0,%s62
 457      BE000045 
 458              	.L2.EoP:
 459              	# End of prologue codes
 460              	# line 83
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     const auto &ops = p->attr.post_ops;
 461              		.loc	1 83 0
 462 0908 6C000000 		lea	%s63,108
 462      00003F06 
 463 0910 00000000 		adds.l	%s63,%s1,%s63
 463      BF813F59 
 464              	# line 84
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int idx = 0; idx < ops.len; ++idx) {
 465              		.loc	1 84 0
 466 0918 00000000 		ldl.sx	%s63,0(,%s63)	# *(ops).len
 466      BF003F03 
 467 0920 58010000 		brlt.w	0,%s63,.L2.0
 467      BF008218 
 468 0928 88000000 		br.l	.L2.1
 468      00000F18 
 469              	.L2.2:
 470 0930 00000000 		or	%s60,0,%s18
 470      92003C45 
 471 0938 00000000 		or	%s62,0,%s1
 471      81003E45 
 472              	.L2.3:
 473              	# line 92
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       using pk = attr_t::post_ops_t::kind_t;
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       const auto &e = ops.entry[idx];
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       switch (e.kind) {
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         case pk::SUM:
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           d += e.sum.scale * dst;
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           break;
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         case pk::RELU:
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           d = e.eltwise.scale * (d < 0 ? 0 : d);
 474              		.loc	1 92 0
 475 0940 00000000 		fmul.s	%s58,%s60,%s58
 475      BABCBA4D 
 476 0948 00000000 		stu	%s58,0(,%s61)	# *(d)
 476      BD003A12 
 477 0950 B0000000 		br.l	.L2.4
 477      00000F18 
 478              	.L2.5:
 479 0958 00000000 		or	%s60,0,(0)1
 479      00003C45 
 480 0960 00000000 		or	%s62,0,%s1
 480      81003E45 
 481 0968 D8FFFFFF 		br.l	.L2.3
 481      00000F18 
 482              	.L2.6:
 483 0970 04000000 		ldu	%s58,4(,%s63)	# *(e)..sum.scale
 483      BF003A02 
 484 0978 00000000 		ldu	%s18,0(,%s61)	# *(d)
 484      BD001202 
 485 0980 00000000 		or	%s19,0,(0)1
 485      00001345 
 486 0988 D0FFFFFF 		brgt.s	%s19,%s18,.L2.5
 486      9293C118 
 487 0990 A0FFFFFF 		br.l	.L2.2
 487      00000F18 
 488              	.L2.7:
 489 0998 D8FFFFFF 		breq.w	1,%s62,.L2.6
 489      BE018418 
 490 09a0 00000000 		or	%s62,0,%s1
 490      81003E45 
 491 09a8 58000000 		br.l	.L2.4
 491      00000F18 
 492              	.L2.1:
 493              	# line 82
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     const auto &ops = p->attr.post_ops;
 494              		.loc	1 82 0
 495              	# Start of epilogue codes
 496 09b0 30000000 		ld	%s18,48(,%fp)
 496      89001201 
 497 09b8 38000000 		ld	%s19,56(,%fp)
 497      89001301 
 498 09c0 00000000 		or	%sp,0,%fp
 498      89000B45 
 499              		.cfi_def_cfa	11,8
 500 09c8 18000000 		ld	%got,0x18(,%sp)
 500      8B000F01 
 501 09d0 20000000 		ld	%plt,0x20(,%sp)
 501      8B001001 
 502 09d8 08000000 		ld	%lr,0x8(,%sp)
 502      8B000A01 
 503 09e0 00000000 		ld	%fp,0x0(,%sp)
 503      8B000901 
 504 09e8 00000000 		b.l	(,%lr)
 504      8A000F19 
 505              	.L2.8:
 506 09f0 00000000 		or	%s1,0,%s62
 506      BE000145 
 507 09f8 60000000 		br.l	.L2.9
 507      00000F18 
 508              	.L2.4:
 509              	# line 84
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int idx = 0; idx < ops.len; ++idx) {
 510              		.loc	1 84 0
 511 0a00 00000000 		adds.w.sx	%s62,1,%s62
 511      BE013E4A 
 512 0a08 00000000 		adds.l	%s63,16,%s63
 512      BF103F59 
 513 0a10 E0FFFFFF 		brgt.w	0,%s62,.L2.8
 513      BE008118 
 514 0a18 98FFFFFF 		br.l	.L2.1
 514      00000F18 
 515              	.L2.10:
 516              	# line 89
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           break;
 517              		.loc	1 89 0
 518 0a20 00000000 		ldu	%s60,0(,%s61)	# *(d)
 518      BD003C02 
 519 0a28 00000000 		or	%s62,0,%s1
 519      81003E45 
 520 0a30 04000000 		ldu	%s58,4(,%s63)	# *(e)..sum.scale
 520      BF003A02 
 521 0a38 00000000 		fmul.s	%s58,%s58,%s59
 521      BBBABA4D 
 522 0a40 00000000 		fadd.s	%s58,%s60,%s58
 522      BABCBA4C 
 523 0a48 00000000 		stu	%s58,0(,%s61)	# *(d)
 523      BD003A12 
 524 0a50 B0FFFFFF 		br.l	.L2.4
 524      00000F18 
 525              	.L2.9:
 526              	# line 87
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         case pk::SUM:
 527              		.loc	1 87 0
 528 0a58 00000000 		ldl.zx	%s62,0(,%s63)	# *(e).kind
 528      BF00BE03 
 529 0a60 00000000 		adds.w.sx	%s62,0,%s62
 529      BE003E4A 
 530 0a68 B8FFFFFF 		breq.w	0,%s62,.L2.10
 530      BE008418 
 531 0a70 28FFFFFF 		br.l	.L2.7
 531      00000F18 
 532              	.L2.0:
 533              	# line 86
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       switch (e.kind) {
 534              		.loc	1 86 0
 535 0a78 70000000 		lea	%s62,112
 535      00003E06 
 536 0a80 00000000 		adds.l	%s62,%s1,%s62
 536      BE813E59 
 537              	# line 84
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       using pk = attr_t::post_ops_t::kind_t;
 538              		.loc	1 84 0
 539 0a88 00000000 		subs.w.sx	%s60,0,%s63
 539      BF003C5A 
 540 0a90 00000000 		or	%s61,0,%s2
 540      82003D45 
 541 0a98 00000000 		or	%s1,0,%s60
 541      BC000145 
 542 0aa0 00000000 		or	%s63,0,%s62
 542      BE003F45 
 543 0aa8 00000000 		or	%s59,0,%s3
 543      83003B45 
 544 0ab0 A8FFFFFF 		br.l	.L2.9
 544      00000F18 
 545              		.cfi_endproc
 546              		.set	.L.3.2auto_size,	0xffffffffffffff00	# 256 Bytes
 548              	# ============ End  conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, float)#1}::operator()(conv::prb_t const*, float&) const
 549              	# ============ Begin  _ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_
 550              		.data
 551              		.balign 16
 554              	.LP._ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_RfiiiiiE_clES2_S5_
 555 0000 00000000 		.long	__vla_dealloc_eh
 555      00000000 
 556 0008 0000     		.zero	2
 557 000a FFFF     		.short	65535
 558 000c 04       		.byte	4
 559 000d 000000   		.zero	3
 560 0010 00000000 		.long	__vla_dealloc_eh
 560      00000000 
 561 0018 0100     		.short	1
 562 001a 0000     		.zero	2
 563 001c 04       		.byte	4
 564 001d 000000   		.zero	3
 565 0020 00000000 		.long	__vla_dealloc_eh
 565      00000000 
 566 0028 0200     		.short	2
 567 002a 0100     		.short	1
 568 002c 04       		.byte	4
 569 002d 000000   		.zero	3
 570 0030 00000000 		.long	__vla_dealloc_eh
 570      00000000 
 571 0038 0300     		.short	3
 572 003a 0200     		.short	2
 573 003c 04       		.byte	4
 574 003d 000000   		.zero	3
 575              		.text
 576 0ab8 00000000 		.balign 16
 576      00000000 
 577              	# line 321
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           break;
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         default:
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           assert(!"unknown attr::post_ops::kind");
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   };
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const float* restrict const psrc = (float*)src_m;
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const float* restrict const pwei = (float*)wei_m;
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const float* restrict const pbia = (float*)bia_m;
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   /* */ float* restrict const pdst = (float*)dst_m;
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMP(parallel for collapse(5))//;
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int g = 0; g < G; ++g) {
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float conv_res = 0;
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             ker(p, psrc, pwei, conv_res, g, mb, oc, oh, ow);
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             if (p->dir & FLAG_BIA) {
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               const size_t bia_off = bia_off_f(p, g, oc);
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               conv_res += pbia[bia_off];
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             }
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             if (p->merge == RELU && conv_res < 0)
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               conv_res = 0;
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             maybe_scale(p, conv_res, g * OC / G + oc);
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float &dst = pdst[dst_off];
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             maybe_post_ops(p, conv_res, dst);
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             pdst[dst_off] = conv_res;
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** }
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** enum sz { precompute_size = 16 };
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** /* pre-computes arrays of oh(ow) and kh(kw) for traversing in kernel */
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** static inline void precompute_ok(int i, int O, int K, int S, int P, int D,
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int &num, int *_o, int *_k) {
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   assert(K <= precompute_size);
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   num = 0;
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #pragma _NEC loop_count(precompute_size)
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < K; ++k) { // nvc++ DOES vectorize this.  not gcc.
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0 // original
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       int o = i - k * (D + 1) + P;
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       if (o < 0 || o % S) continue;
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       o /= S;
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       if (o >= O) continue;
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       _k[num] = k;
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       _o[num] = o;
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       ++num;
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #else // avoid % because simd remainder might not exist
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int oi = i - k * (D + 1) + P;
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int o = oi / S;
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //if (o < 0 || o % S) continue; // this modification is very nice for nc++
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //if (o >= O) continue;
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (oi < 0 || o >= O || oi != o*S) continue;
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[num] = k;
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _o[num] = o;
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     ++num;         // nobody seems to generate a vgather here.
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** };
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 1 // see what gcc vectorizes (and what it does NOT!!!)
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** // this code is not even correct. but that's ok for now.
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** // This code gives nc++ MORE trouble thant the precompute_ok, above !
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** void precompute_ok2(int i, int O, int K, int S, int P, int D,
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int &num, int *_o, int *_k) {
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   assert(K <= precompute_size);
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //alignas(16) float oo    [precompute_size];
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   alignas(16) int oo    [precompute_size];
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   alignas(16) int ooS   [precompute_size];
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   alignas(16) int ooi   [precompute_size];
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //alignas(16) int gather[precompute_size] = {0}; // gcc does NOT like vectorizing with 'bool foo[
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   alignas(16) bool gather[precompute_size] = {0}; // gcc does NOT like vectorizing with 'bool foo[]
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //alignas(16) int gattmp[precompute_size] = {0};
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   alignas(16) int kk    [precompute_size];
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //alignas(16) signed char ix [precompute_size];
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   alignas(16) int ix [precompute_size];
 179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   VREG(oo) VREG(ooS) VREG(ooi) VREG(gather) VREG(kk) VREG(ix)
 180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < precompute_size; ++k) kk[k] = k;
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMPSIMD()//;
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   IVDEP()
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
 185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       oo[k] = (P + i) - k * (D+1);
 186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       ooi[k] = (int)oo[k];
 187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       //oo[k] = (oo[k]+S-1) * (float)(1.0/S);
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       oo[k] = oo[k] / S;
 189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       ooS[k] = ooi[k] * S; // tmp
 190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       gather[k] = (ooi[k] >= 0 && ooi[k] < O && ooS[k] == ooi[k]);
 191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   // xform mask into gather indices 'ooS'
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   int cnt = 0;
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   IVDEP()//;
 195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (ssize_t k = 0; k < 16; ++k) {
 196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       if (gather[k]) {
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ix[cnt++] = k;
 198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   num = cnt; // do not know how to force gather with gcc.
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   if (cnt) {
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       OMPSIMD(aligned(_o:16))//;
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       IVDEP()//;
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (size_t k = 0; k < 16; ++k) {
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           _o[k] = (gather[k]? ooi[ix[k]]: 0);
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //gather[k] = gather[k] << 31;
 207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //gather[k] = gather[k] >> 31;
 208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //ooS[k] = ~0;
 209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //ooS[k] = (gather[k]? ooS[k]: 0);
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //if (gather[k]) _o[k] = ooi[ix[k]]; // gcc:NO
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //_o[k] = (ooS[k]? ooi[ix[k]]: 0);
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       OMPSIMD(aligned(_k:16))//;
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int k = 0; k < 16; ++k) {
 215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           _k[k] = (gather[k]? kk[ix[k]]: 0);
 216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           //if (gather[k]) _k[k] = kk[ix[k]]; // gcc:NO
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #else
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   int cnt = 0;
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //IVDEP()//;
 222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMPSIMD()//;
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     kk[k] = k;
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     ooi[k] = (P + i) - k * (D+1);
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //ooi[k] = (int)oo[k];
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //oo[k] = (oo[k]+S-1) * (float)(1.0/S);
 228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     oo[k] = ooi[k] / S;
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     ooS[k] = ooi[k] * S; // tmp
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     gather[k] = (ooi[k] >= 0 && ooi[k] < O && ooS[k] == ooi[k]);
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMPSIMD()//;
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   IVDEP()//;
 235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k]) _o[cnt] = ooi[k];
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k]) _k[cnt] = kk[k];
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k]) ++cnt;
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #elif 1
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k])
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       ix[cnt++] = k;
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMPSIMD(aligned(_o:16))//;
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //IVDEP()//;
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   ShortLoop() for (size_t i = 0; i < cnt; ++i) { // nc++ still no gather ?
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     const int ii = ix[i];
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _o[i] = (gather[ii]? ooi[ii]: 0);
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   ShortLoop() for (size_t i = 0; i < cnt; ++i) {
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[i] = (gather[ix[i]]? kk[ix[i]]: 0);
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #elif 0
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < 16; ++k) { // gcc vectorizes this nicely
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k]) {
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       _o[cnt] = ooi[k];
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       _k[cnt] = kk[k];
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       ++cnt;
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   num = cnt; // do not know how to force gather with gcc.
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < K; ++k) {
 267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int o = i - k * (D + 1) + P;
 268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (o < 0 || o % S) continue;
 269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     o /= S;
 270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (o >= O) continue;
 271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[num] = k;
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _o[num] = o;
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     ++num;
 274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** };
 277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0
 279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** static inline void precompute_k(int i, int O, int K, int S, int P, int D,
 280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                                  int &num, int *_k) {
 281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0
 282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     num = 0;
 283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int kh_end = (ih + PH) / DH + 1;
 284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (kh_end > KH) kh_end = KH;
 285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int kh_beg = kh_end;
 286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int const mul = (ih+PH) / gcd_h;
 288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         kh_beg = ha*mul;
 289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int m = div_floor(kh_beg, khh);
 290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         kh_beg -= m * khh;
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int j = hb * mul + m * jhh; // var j --> 'm' again
 292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
 293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int k = kh_beg; k < kh_end; k += khh)
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         _k[num++] = k;
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #else
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   num = 0;
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int k = 0; k < K; ++k) {
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int o = i - k * (D + 1) + P;
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (o < 0 || o % S) continue;
 301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     o /= S;
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (o >= O) continue;
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[num] = k;
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //_o[num] = o;
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     ++num;
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** }
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                      dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const bool fast = MAX2(KH, KW) <= precompute_size;
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float const * restrict const pwei = (float*)wei_m;
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //float const * restrict const pbia = (float*)bia_m;
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   auto ker_fast = [](const prb_t* p, const enum sz precompute_size,
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                      const float* pdiff_dst, const float* pwei,
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                      float &ds, int g, int mb, int ic, int ih, int iw) {
 578              		.loc	1 321 0
 580              	_ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_RfiiiiiE_clES2_S5_S7_S
 581              		.cfi_startproc
 582 0ac0 00000000 		st	%fp,0x0(,%sp)
 582      8B000911 
 583              		.cfi_def_cfa_offset	0
 584              		.cfi_offset	9,0
 585 0ac8 08000000 		st	%lr,0x8(,%sp)
 585      8B000A11 
 586 0ad0 18000000 		st	%got,0x18(,%sp)
 586      8B000F11 
 587 0ad8 20000000 		st	%plt,0x20(,%sp)
 587      8B001011 
 588 0ae0 00000000 		or	%fp,0,%sp
 588      8B000945 
 589              		.cfi_def_cfa_register	9
 590 0ae8 30000000 		st	%s18,48(,%fp)
 590      89001211 
 591 0af0 38000000 		st	%s19,56(,%fp)
 591      89001311 
 592 0af8 58000000 		st	%s23,88(,%fp)
 592      89001711 
 593 0b00 60000000 		st	%s24,96(,%fp)
 593      89001811 
 594 0b08 68000000 		st	%s25,104(,%fp)
 594      89001911 
 595 0b10 D0FBFFFF 		lea	%s13,.L.4.2auto_size&0xffffffff
 595      00000D06 
 596 0b18 00000000 		and	%s13,%s13,(32)0
 596      608D0D44 
 597 0b20 FFFFFFFF 		lea.sl	%sp,.L.4.2auto_size>>32(%fp,%s13)
 597      8D898B06 
 598 0b28 48000000 		brge.l.t	%sp,%sl,.L3.EoP
 598      888B3518 
 599 0b30 18000000 		ld	%s61,0x18(,%tp)
 599      8E003D01 
 600 0b38 00000000 		or	%s62,0,%s0
 600      80003E45 
 601 0b40 3B010000 		lea	%s63,0x13b
 601      00003F06 
 602 0b48 00000000 		shm.l	%s63,0x0(%s61)
 602      BD033F31 
 603 0b50 08000000 		shm.l	%sl,0x8(%s61)
 603      BD030831 
 604 0b58 10000000 		shm.l	%sp,0x10(%s61)
 604      BD030B31 
 605 0b60 00000000 		monc
 605      0000003F 
 606 0b68 00000000 		or	%s0,0,%s62
 606      BE000045 
 607              	.L3.EoP:
 608              	# End of prologue codes
 609 0b70 28FEFFFF 		st	%s7,-472(,%fp)	# spill 
 609      89000711 
 610 0b78 20FEFFFF 		st	%s6,-480(,%fp)	# spill 
 610      89000611 
 611 0b80 18FEFFFF 		st	%s5,-488(,%fp)	# spill 
 611      89000511 
 612 0b88 10FEFFFF 		st	%s4,-496(,%fp)	# spill 
 612      89000411 
 613 0b90 08FEFFFF 		st	%s3,-504(,%fp)	# spill 
 613      89000311 
 614 0b98 00FEFFFF 		st	%s1,-512(,%fp)	# spill 
 614      89000111 
 615 0ba0 00000000 		or	%s2,0,%s2
 615      82000245 
 616 0ba8 00000000 		lea	%s63,__curr_eh_stack_entry@LO
 616      00003F06 
 617 0bb0 00000000 		and	%s63,%s63,(32)0
 617      60BF3F44 
 618 0bb8 00000000 		lea.sl	%s63,__curr_eh_stack_entry@HI(,%s63)
 618      BF00BF06 
 619 0bc0 00000000 		ld	%s62,0(,%s63)
 619      BF003E01 
 620 0bc8 38FEFFFF 		st	%s62,-456(,%fp)
 620      89003E11 
 621 0bd0 38FEFFFF 		lea	%s62,-456
 621      00003E06 
 622 0bd8 00000000 		adds.l	%s62,%fp,%s62
 622      BE893E59 
 623 0be0 00000000 		st	%s62,0(,%s63)
 623      BF003E11 
 624 0be8 00000000 		or	%s63,1,(0)1
 624      00013F45 
 625 0bf0 40FEFFFF 		st1b	%s63,-448(,%fp)
 625      89003F15 
 626 0bf8 00000000 		lea	%s63,.LP._ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_RfiiiiiE
 626      00003F06 
 627 0c00 00000000 		and	%s63,%s63,(32)0
 627      60BF3F44 
 628 0c08 00000000 		lea.sl	%s63,.LP._ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_Rfiii
 628      BF00BF06 
 629 0c10 48FEFFFF 		st	%s63,-440(,%fp)
 629      89003F11 
 630 0c18 B8FFFFFF 		lea	%s63,-72
 630      00003F06 
 631 0c20 00000000 		adds.l	%s63,%fp,%s63
 631      BF893F59 
 632 0c28 50FEFFFF 		st	%s63,-432(,%fp)
 632      89003F11 
 633 0c30 00000000 		lea	%s23,__eh_curr_region@LO
 633      00001706 
 634 0c38 00000000 		and	%s23,%s23,(32)0
 634      60971744 
 635 0c40 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 635      97009706 
 636 0c48 00000000 		ld2b.zx	%s63,0(,%s23)
 636      9700BF04 
 637 0c50 60FEFFFF 		st2b	%s63,-416(,%fp)
 637      89003F14 
 638 0c58 FFFF0000 		lea	%s63,65535
 638      00003F06 
 639 0c60 00000000 		st2b	%s63,0(,%s23)
 639      97003F14 
 640              	# line 325
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 1
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     // after reflection, this might be decently fast.
 324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     // next opt might be to use more mem and precompute kh_beg[ih] pre-OMP.
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     alignas(16) int kh[precompute_size];
 641              		.loc	1 325 0
 642 0c68 B0FFFFFF 		lea	%s63,-80
 642      00003F06 
 643 0c70 00000000 		adds.l	%s24,%fp,%s63
 643      BF891859 
 644 0c78 00000000 		muls.l	%s25,4,%s2
 644      8204196E 
 645 0c80 00000000 		or	%s0,0,%s25
 645      99000045 
 646 0c88 00000000 		lea	%s12,__grow_stack@LO
 646      00000C06 
 647 0c90 00000000 		and	%s12,%s12,(32)0
 647      608C0C44 
 648 0c98 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 648      8C008C06 
 649 0ca0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 649      8C000A08 
 650 0ca8 F8000000 		lea	%s63,248
 650      00003F06 
 651 0cb0 00000000 		adds.l	%s63,%sp,%s63
 651      BF8B3F59 
 652 0cb8 00000000 		lea	%s62,0
 652      00003E06 
 653 0cc0 00000000 		or	%s0,0,%s25
 653      99000045 
 654 0cc8 00000000 		st	%s63,0(,%s24)
 654      98003F11 
 655 0cd0 B0FFFFFF 		ld	%s63,-80(,%fp)	# kh
 655      89003F01 
 656 0cd8 B8FFFFFF 		st	%s63,-72(,%fp)
 656      89003F11 
 657 0ce0 00000000 		st2b	%s62,0(,%s23)
 657      97003E14 
 658              	# line 326
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     alignas(16) int oh[precompute_size];
 659              		.loc	1 326 0
 660 0ce8 30FEFFFF 		lea	%s63,-464
 660      00003F06 
 661 0cf0 00000000 		adds.l	%s24,%fp,%s63
 661      BF891859 
 662 0cf8 00000000 		lea	%s12,__grow_stack@LO
 662      00000C06 
 663 0d00 00000000 		and	%s12,%s12,(32)0
 663      608C0C44 
 664 0d08 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 664      8C008C06 
 665 0d10 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 665      8C000A08 
 666 0d18 F8000000 		lea	%s63,248
 666      00003F06 
 667 0d20 00000000 		adds.l	%s63,%sp,%s63
 667      BF8B3F59 
 668 0d28 00000000 		or	%s0,0,%s25
 668      99000045 
 669 0d30 00000000 		st	%s63,0(,%s24)
 669      98003F11 
 670 0d38 30FEFFFF 		ld	%s63,-464(,%fp)	# oh
 670      89003F01 
 671 0d40 C0FFFFFF 		lea	%s62,-64
 671      00003E06 
 672 0d48 00000000 		st	%s63,0(%s62,%fp)
 672      89BE3F11 
 673 0d50 00000000 		or	%s63,1,(0)1
 673      00013F45 
 674 0d58 00000000 		st2b	%s63,0(,%s23)
 674      97003F14 
 675              	# line 327
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     alignas(16) int kw[precompute_size];
 676              		.loc	1 327 0
 677 0d60 00000000 		adds.l	%s24,%fp,(59)1
 677      3B891859 
 678 0d68 00000000 		lea	%s12,__grow_stack@LO
 678      00000C06 
 679 0d70 00000000 		and	%s12,%s12,(32)0
 679      608C0C44 
 680 0d78 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 680      8C008C06 
 681 0d80 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 681      8C000A08 
 682 0d88 F8000000 		lea	%s63,248
 682      00003F06 
 683 0d90 00000000 		adds.l	%s63,%sp,%s63
 683      BF8B3F59 
 684 0d98 00000000 		or	%s0,0,%s25
 684      99000045 
 685 0da0 00000000 		st	%s63,0(,%s24)
 685      98003F11 
 686 0da8 E0FFFFFF 		ld	%s63,-32(,%fp)	# kw
 686      89003F01 
 687 0db0 C8FFFFFF 		lea	%s62,-56
 687      00003E06 
 688 0db8 00000000 		st	%s63,0(%s62,%fp)
 688      89BE3F11 
 689 0dc0 00000000 		or	%s63,2,(0)1
 689      00023F45 
 690 0dc8 00000000 		st2b	%s63,0(,%s23)
 690      97003F14 
 691              	# line 328
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     alignas(16) int ow[precompute_size];
 692              		.loc	1 328 0
 693 0dd0 00000000 		adds.l	%s24,%fp,(60)1
 693      3C891859 
 694 0dd8 00000000 		lea	%s12,__grow_stack@LO
 694      00000C06 
 695 0de0 00000000 		and	%s12,%s12,(32)0
 695      608C0C44 
 696 0de8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 696      8C008C06 
 697 0df0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 697      8C000A08 
 698 0df8 F8000000 		lea	%s63,248
 698      00003F06 
 699 0e00 00000000 		adds.l	%s63,%sp,%s63
 699      BF8B3F59 
 700 0e08 00000000 		st	%s63,0(,%s24)
 700      98003F11 
 701 0e10 F0FFFFFF 		ld	%s63,-16(,%fp)	# ow
 701      89003F01 
 702 0e18 D0FFFFFF 		lea	%s62,-48
 702      00003E06 
 703 0e20 00000000 		st	%s63,0(%s62,%fp)
 703      89BE3F11 
 704 0e28 00000000 		or	%s63,3,(0)1
 704      00033F45 
 705 0e30 00000000 		st2b	%s63,0(,%s23)
 705      97003F14 
 706              	# line 330
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int num_h, num_w;
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     precompute_ok(ih, OH, KH, SH, PH, p->dh, num_h, oh, kh);
 707              		.loc	1 330 0
 708 0e38 F8000000 		ldl.sx	%s0,248(,%fp)	# ih
 708      89000003 
 709 0e40 18000000 		ldl.sx	%s63,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 709      81003F03 
 710 0e48 20000000 		ldl.sx	%s2,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 710      81000203 
 711 0e50 28000000 		ldl.sx	%s3,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 711      81000303 
 712 0e58 30000000 		ldl.sx	%s4,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 712      81000403 
 713 0e60 38000000 		ldl.sx	%s5,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 713      81000503 
 714 0e68 00000000 		or	%s1,0,%s63
 714      BF000145 
 715 0e70 D8FFFFFF 		lea	%s63,-40
 715      00003F06 
 716 0e78 00000000 		adds.l	%s6,%fp,%s63
 716      BF890659 
 717 0e80 30FEFFFF 		ld	%s7,-464(,%fp)	# oh
 717      89000701 
 718 0e88 B0FFFFFF 		ld	%s63,-80(,%fp)	# kh
 718      89003F01 
 719 0e90 F0000000 		st	%s63,240(,%sp)
 719      8B003F11 
 720 0e98 00000000 		lea	%s12,_INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*)@LO
 720      00000C06 
 721 0ea0 00000000 		and	%s12,%s12,(32)0
 721      608C0C44 
 722 0ea8 00000000 		lea.sl	%s12,_INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*)@HI(,%s12)
 722      8C008C06 
 723 0eb0 00000000 		bsic	%lr,(,%s12)	# _INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*)
 723      8C000A08 
 724              	# line 332
 331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //precompute_ok2(ih, OH, KH, SH, PH, p->dh, num_h, oh, kh);
 332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     precompute_ok(iw, OW, KW, SW, PW, p->dw, num_w, ow, kw);
 725              		.loc	1 332 0
 726 0eb8 00010000 		ldl.sx	%s0,256(,%fp)	# iw
 726      89000003 
 727 0ec0 00FEFFFF 		ld	%s63,-512(,%fp)	# restore 
 727      89003F01 
 728 0ec8 1C000000 		ldl.sx	%s1,28(,%s63)	# *(p).__b_N4conv6desc_tE.ow
 728      BF000103 
 729 0ed0 24000000 		ldl.sx	%s2,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 729      BF000203 
 730 0ed8 2C000000 		ldl.sx	%s3,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 730      BF000303 
 731 0ee0 34000000 		ldl.sx	%s4,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 731      BF000403 
 732 0ee8 3C000000 		ldl.sx	%s5,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 732      BF000503 
 733 0ef0 DCFFFFFF 		lea	%s63,-36
 733      00003F06 
 734 0ef8 00000000 		adds.l	%s6,%fp,%s63
 734      BF890659 
 735 0f00 F0FFFFFF 		ld	%s7,-16(,%fp)	# ow
 735      89000701 
 736 0f08 E0FFFFFF 		ld	%s63,-32(,%fp)	# kw
 736      89003F01 
 737 0f10 F0000000 		st	%s63,240(,%sp)
 737      8B003F11 
 738 0f18 00000000 		lea	%s12,_INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*)@LO
 738      00000C06 
 739 0f20 00000000 		and	%s12,%s12,(32)0
 739      608C0C44 
 740 0f28 00000000 		lea.sl	%s12,_INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*)@HI(,%s12)
 740      8C008C06 
 741 0f30 00000000 		bsic	%lr,(,%s12)	# _INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*)
 741      8C000A08 
 742              	# line 359
 333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #elif 2
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     // after reflection, this might be decently fast.
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     // next opt might be to use more mem and precompute kh_beg[ih] pre-OMP.
 336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int kh[precompute_size], oh[precompute_size], num_h;
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int kw[precompute_size], ow[precompute_size], num_w;
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     precompute_ok2(ih, OH, KH, SH, PH, p->dh, num_h, oh, kh);
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     precompute_ok2(iw, OW, KW, SW, PW, p->dw, num_w, ow, kw);
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #else
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     // ouch.
 342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int kh[precompute_size];
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int oh[precompute_size];
 344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int kw[precompute_size];
 345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int ow[precompute_size];
 346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int num_w, num_h;
 347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     precompute_k(ih, OH, KH, SH, PH, p->dh, num_h, kh); // use formula
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     precompute_k(ih, OH, KH, SH, PH, p->dh, num_h, kh); // use formula
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int oh0 = (ih + PH - kh[0] * DH ) / SH;
 350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int h=0; h<num_h; ++h) {
 351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         // linear, decrements by lcm_h/SH == DH/gcd_h == jhh
 352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         //oh[h] = (ih + PH - kh[h] * DH) / SH;
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         oh[h] = oh0 - h * jhh;
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int w=0; w<num_w; ++w)
 356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         ow[w] = iw + PW - kw[w] * DW; // linear, decrements by lcm_w
 357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     IVDEPx() for (int oc = 0; oc < OC/G; ++oc) {
 743              		.loc	1 359 0
 744 0f38 00000000 		or	%s61,0,(0)1
 744      00003D45 
 745 0f40 00FEFFFF 		ld	%s1,-512(,%fp)	# restore 
 745      89000101 
 746 0f48 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 746      81003F03 
 747 0f50 00000000 		ldl.sx	%s1,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 747      81000103 
 748 0f58 00000000 		divs.w.sx	%s1,%s63,%s1
 748      81BF017B 
 749 0f60 A8030000 		brlt.w	0,%s1,.L3.0
 749      81008218 
 750 0f68 18000000 		br.l	.L3.1
 750      00000F18 
 751              	.L3.2:
 752              	# line 362
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int h = 0; h < num_h; ++h) {
 361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int w = 0; w < num_w; ++w) {
 753              		.loc	1 362 0
 754 0f70 80000000 		mins.w.sx	%s60,%s53,%s60
 754      BCB53C78 
 755 0f78 98010000 		br.l	.L3.3
 755      00000F18 
 756              	.L3.1:
 757 0f80 00000000 		lea	%s63,__eh_curr_region@LO
 757      00003F06 
 758 0f88 00000000 		and	%s63,%s63,(32)0
 758      60BF3F44 
 759 0f90 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 759      BF00BF06 
 760 0f98 60FEFFFF 		ld2b.zx	%s62,-416(,%fp)
 760      8900BE04 
 761 0fa0 00000000 		st2b	%s62,0(,%s63)
 761      BF003E14 
 762 0fa8 38FEFFFF 		ld	%s63,-456(,%fp)
 762      89003F01 
 763 0fb0 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 763      00003E06 
 764 0fb8 00000000 		and	%s62,%s62,(32)0
 764      60BE3E44 
 765 0fc0 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 765      BE00BE06 
 766 0fc8 00000000 		st	%s63,0(,%s62)
 766      BE003F11 
 767              	# Start of epilogue codes
 768 0fd0 30000000 		ld	%s18,48(,%fp)
 768      89001201 
 769 0fd8 38000000 		ld	%s19,56(,%fp)
 769      89001301 
 770 0fe0 58000000 		ld	%s23,88(,%fp)
 770      89001701 
 771 0fe8 60000000 		ld	%s24,96(,%fp)
 771      89001801 
 772 0ff0 68000000 		ld	%s25,104(,%fp)
 772      89001901 
 773 0ff8 00000000 		or	%sp,0,%fp
 773      89000B45 
 774              		.cfi_def_cfa	11,8
 775 1000 18000000 		ld	%got,0x18(,%sp)
 775      8B000F01 
 776 1008 20000000 		ld	%plt,0x20(,%sp)
 776      8B001001 
 777 1010 08000000 		ld	%lr,0x8(,%sp)
 777      8B000A01 
 778 1018 00000000 		ld	%fp,0x0(,%sp)
 778      8B000901 
 779 1020 00000000 		b.l	(,%lr)
 779      8A000F19 
 780              	.L3.4:
 781 1028 D0020000 		br.l	.L3.5
 781      00000F18 
 782              	.L3.6:
 783              	# line 359
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int h = 0; h < num_h; ++h) {
 784              		.loc	1 359 0
 785 1030 00000000 		adds.w.sx	%s62,1,%s62
 785      BE013E4A 
 786 1038 00000000 		adds.w.sx	%s61,1,%s61
 786      BD013D4A 
 787 1040 E8FFFFFF 		brgt.w	0,%s62,.L3.4
 787      BE008118 
 788 1048 38FFFFFF 		br.l	.L3.1
 788      00000F18 
 789              	.L3.7:
 790 1050 00000000 		or	%s62,0,%s3
 790      83003E45 
 791 1058 00000000 		or	%s61,0,%s4
 791      84003D45 
 792 1060 D0FFFFFF 		br.l	.L3.6
 792      00000F18 
 793              	.L3.8:
 794 1068 48020000 		br.l	.L3.9
 794      00000F18 
 795              	.L3.10:
 796              	# line 360
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int h = 0; h < num_h; ++h) {
 797              		.loc	1 360 0
 798 1070 00000000 		adds.w.sx	%s62,1,%s62
 798      BE013E4A 
 799 1078 00000000 		adds.l	%s61,4,%s61
 799      BD043D59 
 800 1080 E8FFFFFF 		brgt.w	0,%s62,.L3.8
 800      BE008118 
 801 1088 C8FFFFFF 		br.l	.L3.7
 801      00000F18 
 802              	.L3.11:
 803              	# line 365
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh[h], kw[w]);
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 804              		.loc	1 365 0
 805 1090 00000000 		or	%s60,1,(0)1
 805      00013C45 
 806 1098 00000000 		or	%s59,0,%s35
 806      A3003B45 
 807 10a0 00000000 		or	%s62,0,%s1
 807      81003E45 
 808 10a8 00000000 		or	%s61,0,%s2
 808      82003D45 
 809 10b0 00000000 		lvl	%s60
 809      00BC00BF 
 810 10b8 00000034 		vldu.nc	%v52,0,%s59
 810      BB000082 
 811 10c0 00000000 		lvl	%s50
 811      00B200BF 
 812 10c8 00003F33 		vfsum.s	%v51,%v63
 812      000080EC 
 813 10d0 00000000 		or	%s60,1,(0)1
 813      00013C45 
 814 10d8 00000000 		lvl	%s60
 814      00BC00BF 
 815 10e0 00333432 		vfadd.s	%v50,%v52,%v51
 815      000080CC 
 816 10e8 00000000 		or	%s60,1,(0)1
 816      00013C45 
 817 10f0 00000000 		or	%s59,0,%s35
 817      A3003B45 
 818 10f8 00000000 		lvl	%s60
 818      00BC00BF 
 819 1100 00000032 		vstu.nc	%v50,0,%s59
 819      BB000092 
 820 1108 68FFFFFF 		br.l	.L3.10
 820      00000F18 
 821              	.L3.3:
 822              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 823              		.loc	1 363 0
 824 1110 00000000 		adds.l	%s62,%s63,(0)1
 824      00BF3E59 
 825 1118 00000000 		adds.l	%s62,%s62,%s61
 825      BDBE3E59 
 826 1120 00000000 		lvl	%s60
 826      00BC00BF 
 827 1128 0000003E 		vldl.sx.nc	%v62,4,%s62
 827      BE040083 
 828 1130 003E003D 		vor	%v61,(0)1,%v62
 828      000020C5 
 829 1138 003D003C 		vaddu.l	%v60,%s59,%v61
 829      00BB20C8 
 830              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 831              		.loc	1 364 0
 832 1140 00000000 		adds.l	%s62,%s58,(0)1
 832      00BA3E59 
 833 1148 00000000 		adds.l	%s62,%s62,%s61
 833      BDBE3E59 
 834 1150 0000003B 		vldl.sx.nc	%v59,4,%s62
 834      BE040083 
 835 1158 003B003A 		vor	%v58,(0)1,%v59
 835      000020C5 
 836 1160 003A0039 		vaddu.l	%v57,%s57,%v58
 836      00B920C8 
 837              	# line 365
 838              		.loc	1 365 0
 839 1168 003C0038 		vsfa	%v56,%v60,2,%s56
 839      B80200D7 
 840 1170 00003837 		vgtu	%v55,%v56,0,0
 840      000040A2 
 841 1178 00390036 		vsfa	%v54,%v57,2,%s55
 841      B70200D7 
 842 1180 00003635 		vgtu	%v53,%v54,0,0
 842      000040A2 
 843 1188 37353F3F 		vfmad.s	%v63,%v63,%v53,%v55
 843      000080E2 
 844              	# line 362
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 845              		.loc	1 362 0
 846 1190 00000000 		adds.l	%s61,%s61,%s54
 846      B6BD3D59 
 847 1198 00000000 		subs.w.sx	%s53,%s53,%s60
 847      BCB5355A 
 848 11a0 F0FEFFFF 		brge.w	0,%s53,.L3.11
 848      B5008518 
 849 11a8 C8FDFFFF 		br.l	.L3.2
 849      00000F18 
 850              	.L3.12:
 851              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 852              		.loc	1 363 0
 853 11b0 00000000 		divs.w.sx	%s50,%s52,%s51
 853      B3B4327B 
 854 11b8 00000000 		or	%s1,0,%s62
 854      BE000145 
 855 11c0 00000000 		or	%s2,0,%s61
 855      BD000245 
 856 11c8 00000000 		or	%s50,0,%s50
 856      B2003245 
 857 11d0 00000000 		addu.l	%s50,%s50,%s49
 857      B1B23248 
 858 11d8 00000000 		addu.l	%s50,%s50,%s48
 858      B0B23248 
 859 11e0 00000000 		mulu.l	%s50,%s50,%s47
 859      AFB23249 
 860              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 861              		.loc	1 364 0
 862 11e8 00000000 		divu.l	%s62,%s46,%s45
 862      ADAE3E6F 
 863 11f0 00000000 		addu.l	%s62,%s48,%s62
 863      BEB03E48 
 864 11f8 00000000 		mulu.l	%s62,%s62,%s44
 864      ACBE3E49 
 865 1200 00000000 		divu.l	%s62,%s62,%s45
 865      ADBE3E6F 
 866 1208 00000000 		addu.l	%s62,%s62,%s43
 866      ABBE3E48 
 867 1210 00000000 		mulu.l	%s62,%s62,%s42
 867      AABE3E49 
 868              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 869              		.loc	1 363 0
 870 1218 00000000 		dldl.sx	%s36,0(%s61,%s41)	# *(oh)
 870      A9BD240B 
 871 1220 00000000 		or	%s36,0,%s36
 871      A4002445 
 872 1228 00000000 		addu.l	%s36,%s50,%s36
 872      A4B22448 
 873 1230 00000000 		mulu.l	%s59,%s36,%s40
 873      A8A43B49 
 874              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 875              		.loc	1 364 0
 876 1238 00000000 		dldl.sx	%s50,0(%s61,%s39)	# *(kh)
 876      A7BD320B 
 877 1240 00000000 		or	%s50,0,%s50
 877      B2003245 
 878 1248 00000000 		addu.l	%s50,%s62,%s50
 878      B2BE3248 
 879 1250 00000000 		mulu.l	%s57,%s50,%s38
 879      A6B23949 
 880              	# line 362
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 881              		.loc	1 362 0
 882 1258 00000000 		subs.w.sx	%s62,0,%s37
 882      A5003E5A 
 883 1260 00000000 		smvl	%s50
 883      0000322E 
 884 1268 80000000 		mins.w.sx	%s60,%s62,%s50
 884      B2BE3C78 
 885              	# line 365
 886              		.loc	1 365 0
 887 1270 00000000 		or	%s36,0,(0)1
 887      00002445 
 888 1278 00000000 		lvl	%s50
 888      00B200BF 
 889 1280 0000003F 		vbrdu	%v63,%s36
 889      00A4808C 
 890 1288 00000000 		or	%s53,0,%s62
 890      BE003545 
 891              	# line 362
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 892              		.loc	1 362 0
 893 1290 00000000 		or	%s61,0,(0)1
 893      00003D45 
 894 1298 00000000 		or	%s62,0,%s60
 894      BC003E45 
 895 12a0 00000000 		muls.l	%s54,4,%s62
 895      BE04366E 
 896 12a8 68FEFFFF 		br.l	.L3.3
 896      00000F18 
 897              	.L3.9:
 898 12b0 00FFFFFF 		brlt.w	0,%s18,.L3.12
 898      92008218 
 899 12b8 B8FDFFFF 		br.l	.L3.10
 899      00000F18 
 900              	.L3.13:
 901 12c0 00000000 		or	%s48,0,%s61
 901      BD003045 
 902 12c8 00000000 		or	%s3,0,%s62
 902      BE000345 
 903 12d0 00000000 		or	%s62,0,%s34
 903      A2003E45 
 904              	# line 360
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 905              		.loc	1 360 0
 906 12d8 00000000 		or	%s60,0,(0)1
 906      00003C45 
 907 12e0 00000000 		or	%s4,0,%s61
 907      BD000445 
 908 12e8 00000000 		or	%s61,0,%s60
 908      BC003D45 
 909 12f0 C0FFFFFF 		br.l	.L3.9
 909      00000F18 
 910              	.L3.5:
 911 12f8 C8FFFFFF 		brlt.w	0,%s19,.L3.13
 911      93008218 
 912 1300 30FDFFFF 		br.l	.L3.6
 912      00000F18 
 913              	.L3.0:
 914 1308 DCFFFFFF 		ldl.sx	%s18,-36(,%fp)	# num_w
 914      89001203 
 915 1310 08FEFFFF 		ld	%s56,-504(,%fp)	# restore 
 915      89003801 
 916              	# line 362
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh[h], ow[w]);
 917              		.loc	1 362 0
 918 1318 00000000 		subs.w.sx	%s37,0,%s18
 918      9200255A 
 919 1320 D8FFFFFF 		ldl.sx	%s19,-40(,%fp)	# num_h
 919      89001303 
 920 1328 10FEFFFF 		ld	%s55,-496(,%fp)	# restore 
 920      89003701 
 921              	# line 360
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 922              		.loc	1 360 0
 923 1330 00000000 		subs.w.sx	%s34,0,%s19
 923      9300225A 
 924              	# line 359
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int h = 0; h < num_h; ++h) {
 925              		.loc	1 359 0
 926 1338 00000000 		subs.w.sx	%s1,0,%s1
 926      8100015A 
 927 1340 18FEFFFF 		ld	%s35,-488(,%fp)	# restore 
 927      89002301 
 928 1348 00000000 		or	%s62,0,%s1
 928      81003E45 
 929 1350 28FEFFFF 		ld	%s60,-472(,%fp)	# restore 
 929      89003C01 
 930 1358 00FEFFFF 		ld	%s1,-512(,%fp)	# restore 
 930      89000101 
 931              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh[h], kw[w]);
 932              		.loc	1 363 0
 933 1360 14000000 		dldl.sx	%s59,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 933      81003B0B 
 934 1368 00000000 		or	%s57,0,%s59
 934      BB003945 
 935 1370 00000000 		mulu.l	%s49,%s60,%s57
 935      B9BC3149 
 936 1378 20FEFFFF 		ld	%s6,-480(,%fp)	# restore 
 936      89000601 
 937 1380 00000000 		muls.w.sx	%s52,%s6,%s59
 937      BB86344B 
 938 1388 20FEFFFF 		ld	%s60,-480(,%fp)	# restore 
 938      89003C01 
 939              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 940              		.loc	1 364 0
 941 1390 00000000 		mulu.l	%s46,%s57,%s60
 941      BCB92E49 
 942              	# line 363
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh[h], kw[w]);
 943              		.loc	1 363 0
 944 1398 00000000 		dldl.sx	%s51,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 944      8100330B 
 945 13a0 00000000 		or	%s45,0,%s51
 945      B3002D45 
 946 13a8 18000000 		dldl.sx	%s60,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 946      81003C0B 
 947 13b0 00000000 		or	%s47,0,%s60
 947      BC002F45 
 948 13b8 30FEFFFF 		dld	%s41,-464(,%fp)	# oh
 948      89002909 
 949 13c0 1C000000 		dldl.sx	%s60,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 949      81003C0B 
 950 13c8 00000000 		or	%s40,0,%s60
 950      BC002845 
 951 13d0 F0FFFFFF 		dld	%s63,-16(,%fp)	# ow
 951      89003F09 
 952              	# line 364
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 953              		.loc	1 364 0
 954 13d8 08000000 		dldl.sx	%s60,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 954      81003C0B 
 955 13e0 00000000 		or	%s44,0,%s60
 955      BC002C45 
 956 13e8 F0000000 		dldl.sx	%s60,240(,%fp)	# ic
 956      89003C0B 
 957 13f0 00000000 		or	%s43,0,%s60
 957      BC002B45 
 958 13f8 20000000 		dldl.sx	%s60,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 958      81003C0B 
 959 1400 00000000 		or	%s42,0,%s60
 959      BC002A45 
 960 1408 B0FFFFFF 		dld	%s39,-80(,%fp)	# kh
 960      89002709 
 961 1410 24000000 		dldl.sx	%s1,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 961      8100010B 
 962 1418 00000000 		or	%s38,0,%s1
 962      81002645 
 963 1420 E0FFFFFF 		dld	%s58,-32(,%fp)	# kw
 963      89003A09 
 964 1428 D0FEFFFF 		br.l	.L3.5
 964      00000F18 
 965              		.cfi_endproc
 966              		.set	.L.4.2auto_size,	0xfffffffffffffbd0	# 1072 Bytes
 968              	# ============ End  _ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_Rf
 969              	# ============ Begin  _ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_PKfS6_Rfiiiii
 970              		.balign 16
 971              	# line 372
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   };
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   auto ker = [](const prb_t* p, float const* pdiff_dst, float const* pwei,
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                 float &ds, int g, int mb, int ic, int ih, int iw) {
 972              		.loc	1 372 0
 974              	conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float const*, float const*, float&, int, int, int, int, int)#1}::operator()(conv::prb_t const*, float const*, float const*, float&, int, int, int, int, int) const
 975              		.cfi_startproc
 976 1430 00000000 		st	%fp,0x0(,%sp)
 976      8B000911 
 977              		.cfi_def_cfa_offset	0
 978              		.cfi_offset	9,0
 979 1438 08000000 		st	%lr,0x8(,%sp)
 979      8B000A11 
 980 1440 18000000 		st	%got,0x18(,%sp)
 980      8B000F11 
 981 1448 20000000 		st	%plt,0x20(,%sp)
 981      8B001011 
 982 1450 00000000 		or	%fp,0,%sp
 982      8B000945 
 983              		.cfi_def_cfa_register	9
 984 1458 30000000 		st	%s18,48(,%fp)
 984      89001211 
 985 1460 38000000 		st	%s19,56(,%fp)
 985      89001311 
 986 1468 40000000 		st	%s20,64(,%fp)
 986      89001411 
 987 1470 48000000 		st	%s21,72(,%fp)
 987      89001511 
 988 1478 50000000 		st	%s22,80(,%fp)
 988      89001611 
 989 1480 88000000 		st	%s29,136(,%fp)
 989      89001D11 
 990 1488 90000000 		st	%s30,144(,%fp)
 990      89001E11 
 991 1490 98000000 		st	%s31,152(,%fp)
 991      89001F11 
 992 1498 A0000000 		st	%s32,160(,%fp)
 992      89002011 
 993 14a0 A8000000 		st	%s33,168(,%fp)
 993      89002111 
 994 14a8 00EFFFFF 		lea	%s13,.L.5.2auto_size&0xffffffff
 994      00000D06 
 995 14b0 00000000 		and	%s13,%s13,(32)0
 995      608D0D44 
 996 14b8 FFFFFFFF 		lea.sl	%sp,.L.5.2auto_size>>32(%fp,%s13)
 996      8D898B06 
 997 14c0 48000000 		brge.l.t	%sp,%sl,.L4.EoP
 997      888B3518 
 998 14c8 18000000 		ld	%s61,0x18(,%tp)
 998      8E003D01 
 999 14d0 00000000 		or	%s62,0,%s0
 999      80003E45 
 1000 14d8 3B010000 		lea	%s63,0x13b
 1000      00003F06 
 1001 14e0 00000000 		shm.l	%s63,0x0(%s61)
 1001      BD033F31 
 1002 14e8 08000000 		shm.l	%sl,0x8(%s61)
 1002      BD030831 
 1003 14f0 10000000 		shm.l	%sp,0x10(%s61)
 1003      BD030B31 
 1004 14f8 00000000 		monc
 1004      0000003F 
 1005 1500 00000000 		or	%s0,0,%s62
 1005      BE000045 
 1006              	.L4.EoP:
 1007              	# End of prologue codes
 1008              	# line 373
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 1009              		.loc	1 373 0
 1010 1508 00000000 		or	%s57,0,(0)1
 1010      00003945 
 1011 1510 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1011      81003F03 
 1012 1518 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1012      81003E03 
 1013 1520 00000000 		divs.w.sx	%s62,%s63,%s62
 1013      BEBF3E7B 
 1014 1528 48050000 		brlt.w	0,%s62,.L4.0
 1014      BE008218 
 1015 1530 E8030000 		br.l	.L4.1
 1015      00000F18 
 1016              	.L4.2:
 1017              	# line 386
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int kh = 0; kh < KH; ++kh) {
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int oh = ih - kh * (p->dh + 1) + PH;
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         if (oh < 0 || oh % SH) continue;
 377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         oh /= SH;
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         if (oh >= OH) continue;
 379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx() for (int kw = 0; kw < KW; ++kw) {
 381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           int ow = iw - kw * (p->dw + 1) + PW;
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           if (ow < 0 || ow % SW) continue;
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ow /= SW;
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           if (ow >= OW) continue;
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1018              		.loc	1 386 0
 1019 1538 00000000 		divs.w.sx	%s53,%s55,%s54
 1019      B6B7357B 
 1020 1540 00000000 		or	%s53,0,%s53
 1020      B5003545 
 1021 1548 00000000 		addu.l	%s53,%s53,%s52
 1021      B4B53548 
 1022              	# line 387
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1023              		.loc	1 387 0
 1024 1550 00000000 		divu.l	%s38,%s51,%s50
 1024      B2B3266F 
 1025              	# line 386
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1026              		.loc	1 386 0
 1027 1558 00000000 		addu.l	%s53,%s53,%s49
 1027      B1B53548 
 1028              	# line 387
 1029              		.loc	1 387 0
 1030 1560 00000000 		addu.l	%s38,%s38,%s49
 1030      B1A62648 
 1031              	# line 386
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1032              		.loc	1 386 0
 1033 1568 00000000 		mulu.l	%s53,%s53,%s48
 1033      B0B53549 
 1034 1570 00000000 		addu.l	%s53,%s53,%s47
 1034      AFB53548 
 1035 1578 00000000 		mulu.l	%s53,%s53,%s46
 1035      AEB53549 
 1036 1580 00000000 		lvl	%s62
 1036      00BE00BF 
 1037 1588 00390033 		vor	%v51,(0)1,%v57,%vm15
 1037      00002FC5 
 1038 1590 00330032 		vaddu.l	%v50,%s53,%v51,%vm15
 1038      00B52FC8 
 1039              	# line 387
 1040              		.loc	1 387 0
 1041 1598 00000000 		mulu.l	%s38,%s38,%s45
 1041      ADA62649 
 1042 15a0 00000000 		divu.l	%s38,%s38,%s50
 1042      B2A6266F 
 1043 15a8 00000000 		addu.l	%s38,%s38,%s44
 1043      ACA62648 
 1044 15b0 00000000 		mulu.l	%s38,%s38,%s43
 1044      ABA62649 
 1045 15b8 00000000 		addu.l	%s38,%s38,%s42
 1045      AAA62648 
 1046 15c0 00000000 		mulu.l	%s38,%s38,%s41
 1046      A9A62649 
 1047 15c8 0031002B 		vadds.w.sx	%v43,%s59,%v49
 1047      00BB20CA 
 1048 15d0 002B0030 		vor	%v48,(0)1,%v43,%vm15
 1048      00002FC5 
 1049 15d8 0030002F 		vaddu.l	%v47,%s38,%v48,%vm15
 1049      00A62FC8 
 1050              	# line 388
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 1051              		.loc	1 388 0
 1052 15e0 0032002E 		vsfa	%v46,%v50,2,%s40,%vm15
 1052      A8020FD7 
 1053 15e8 0000002A 		vbrd	%v42,0
 1053      0000008C 
 1054 15f0 00002E2A 		vgtu	%v42,%v46,0,0,%vm15
 1054      00004FA2 
 1055 15f8 002F002D 		vsfa	%v45,%v47,2,%s39,%vm15
 1055      A7020FD7 
 1056 1600 00000029 		vbrd	%v41,0
 1056      0000008C 
 1057 1608 00002D29 		vgtu	%v41,%v45,0,0,%vm15
 1057      00004FA2 
 1058 1610 2A292C2C 		vfmad.s	%v44,%v44,%v41,%v42,%vm15
 1058      00008FE2 
 1059 1618 C8000000 		br.l	.L4.3
 1059      00000F18 
 1060              	.L4.4:
 1061              	# line 380
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           int ow = iw - kw * (p->dw + 1) + PW;
 1062              		.loc	1 380 0
 1063 1620 80000000 		mins.w.sx	%s62,%s56,%s62
 1063      BEB83E78 
 1064 1628 00000000 		smvl	%s13
 1064      00000D2E 
 1065 1630 00000000 		lvl	%s13
 1065      008D00BF 
 1066 1638 D0000000 		br.l	.L4.5
 1066      00000F18 
 1067              	.L4.6:
 1068              	# line 389
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1069              		.loc	1 389 0
 1070 1640 00000000 		or	%s61,1,(0)1
 1070      00013D45 
 1071 1648 00000000 		or	%s57,0,%s60
 1071      BC003945 
 1072 1650 00000000 		lvl	%s61
 1072      00BD00BF 
 1073 1658 00000028 		vstu.nc	%v40,0,%s57
 1073      B9000092 
 1074 1660 88030000 		br.l	.L4.7
 1074      00000F18 
 1075              	.L4.8:
 1076 1668 00000000 		or	%s53,0,%s3
 1076      83003545 
 1077 1670 00000000 		or	%s32,0,%s60
 1077      BC002045 
 1078 1678 00000000 		or	%s60,0,%s2
 1078      82003C45 
 1079 1680 00000000 		or	%s31,0,%s61
 1079      BD001F45 
 1080 1688 00000000 		or	%s58,0,%s1
 1080      81003A45 
 1081              	# line 388
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 1082              		.loc	1 388 0
 1083 1690 00000000 		lvl	%s34
 1083      00A200BF 
 1084 1698 00002C26 		vfsum.s	%v38,%v44
 1084      000080EC 
 1085 16a0 00000000 		or	%s61,1,(0)1
 1085      00013D45 
 1086 16a8 00000000 		or	%s59,0,%s7
 1086      87003B45 
 1087 16b0 00000000 		or	%s18,0,%s4
 1087      84001245 
 1088 16b8 00000000 		or	%s62,0,%s6
 1088      86003E45 
 1089 16c0 00000000 		or	%s63,0,%s5
 1089      85003F45 
 1090 16c8 00000000 		lvl	%s61
 1090      00BD00BF 
 1091 16d0 00262828 		vfadd.s	%v40,%v40,%v38
 1091      000080CC 
 1092 16d8 68FFFFFF 		br.l	.L4.6
 1092      00000F18 
 1093              	.L4.3:
 1094              	# line 380
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           int ow = iw - kw * (p->dw + 1) + PW;
 1095              		.loc	1 380 0
 1096 16e0 00000000 		adds.w.sx	%s59,%s59,%s58
 1096      BABB3B4A 
 1097 16e8 00000000 		adds.w.sx	%s63,%s63,%s57
 1097      B9BF3F4A 
 1098 16f0 00000000 		subs.w.sx	%s56,%s56,%s62
 1098      BEB8385A 
 1099 16f8 70FFFFFF 		brge.w	0,%s56,.L4.8
 1099      B8008518 
 1100 1700 20FFFFFF 		br.l	.L4.4
 1100      00000F18 
 1101              	.L4.5:
 1102 1708 00000000 		lvl	%s62
 1102      00BE00BF 
 1103 1710 003F003E 		vadds.w.sx	%v62,%s63,%v63
 1103      00BF20CA 
 1104 1718 003E0037 		vor	%v55,(0)1,%v62
 1104      000020C5 
 1105              	# line 382
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ow /= SW;
 1106              		.loc	1 382 0
 1107 1720 003F0036 		vadds.w.sx	%v54,%s63,%v63
 1107      00BF20CA 
 1108 1728 0036050F 		vfmk.w.ge	%vm15,%v54
 1108      000000B5 
 1109 1730 003F0035 		vadds.w.sx	%v53,%s63,%v63
 1109      00BF20CA 
 1110 1738 0000353D 		vdivs.w.sx	%v61,%v53,%s61,%vm15
 1110      00BD1FEB 
 1111 1740 003D003C 		vmuls.w.sx	%v60,%s61,%v61,%vm15
 1111      00BD2FCB 
 1112 1748 003F0034 		vadds.w.sx	%v52,%s63,%v63
 1112      00BF20CA 
 1113 1750 003C343B 		vsubs.w.sx	%v59,%v52,%v60,%vm15
 1113      00000FDA 
 1114 1758 003B040E 		vfmk.w.eq	%vm14,%v59,%vm15
 1114      00000FB5 
 1115 1760 0000003A 		vbrd	%v58,0,%vm14
 1115      00000E8C 
 1116 1768 000F0E0E 		nndm	%vm14,%vm14,%vm15
 1116      00000094 
 1117 1770 00000F0F 		negm	%vm15,%vm15
 1117      00000095 
 1118 1778 000F0E0F 		orm	%vm15,%vm14,%vm15
 1118      00000085 
 1119 1780 0000003A 		vbrd	%v58,1,%vm15
 1119      00010F8C 
 1120 1788 003A040F 		vfmk.w.eq	%vm15,%v58
 1120      000000B5 
 1121              	# line 383
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           if (ow >= OW) continue;
 1122              		.loc	1 383 0
 1123 1790 00003739 		vdivs.w.sx	%v57,%v55,%s61,%vm15
 1123      00BD1FEB 
 1124              	# line 384
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1125              		.loc	1 384 0
 1126 1798 00390038 		vcmps.w.sx	%v56,%s60,%v57,%vm15
 1126      00BC2FFA 
 1127 17a0 0038010F 		vfmk.w.gt	%vm15,%v56,%vm15
 1127      00000FB5 
 1128 17a8 00000F00 		pcvm	%s18,%vm15
 1128      000012A4 
 1129 17b0 30FFFFFF 		brge.w	0,%s18,.L4.3
 1129      92008518 
 1130 17b8 80FDFFFF 		br.l	.L4.2
 1130      00000F18 
 1131              	.L4.9:
 1132 17c0 00000000 		or	%s47,0,%s57
 1132      B9002F45 
 1133 17c8 00000000 		or	%s42,0,%s59
 1133      BB002A45 
 1134              	# line 380
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           int ow = iw - kw * (p->dw + 1) + PW;
 1135              		.loc	1 380 0
 1136 17d0 00000000 		subs.w.sx	%s38,0,%s37
 1136      A500265A 
 1137 17d8 00000000 		smvl	%s34
 1137      0000222E 
 1138              	# line 388
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1139              		.loc	1 388 0
 1140 17e0 80000000 		mins.w.sx	%s0,%s38,%s34
 1140      A2A60078 
 1141 17e8 00000000 		or	%s33,0,(0)1
 1141      00002145 
 1142 17f0 00000000 		or	%s1,0,%s58
 1142      BA000145 
 1143 17f8 00000000 		or	%s2,0,%s60
 1143      BC000245 
 1144 1800 00000000 		or	%s3,0,%s53
 1144      B5000345 
 1145 1808 00000000 		or	%s4,0,%s18
 1145      92000445 
 1146 1810 00000000 		or	%s5,0,%s63
 1146      BF000545 
 1147 1818 00000000 		or	%s6,0,%s62
 1147      BE000645 
 1148 1820 00000000 		or	%s62,0,%s0
 1148      80003E45 
 1149 1828 00000000 		or	%s7,0,%s59
 1149      BB000745 
 1150 1830 00000000 		lvl	%s34
 1150      00A200BF 
 1151 1838 0000002C 		vbrdu	%v44,%s33
 1151      00A1808C 
 1152 1840 00000000 		or	%s56,0,%s38
 1152      A6003845 
 1153 1848 00000000 		or	%s59,0,(0)1
 1153      00003B45 
 1154 1850 00000000 		or	%s58,0,%s0
 1154      80003A45 
 1155 1858 00000000 		lvl	%s0
 1155      008000BF 
 1156 1860 00000027 		vseq	%v39
 1156      00000099 
 1157 1868 00270031 		vor	%v49,(0)1,%v39
 1157      000020C5 
 1158 1870 00000000 		or	%s63,0,%s36
 1158      A4003F45 
 1159 1878 00000000 		muls.w.sx	%s57,%s35,%s0
 1159      80A3394B 
 1160 1880 0027003F 		vmuls.w.sx	%v63,%s35,%v39
 1160      00A320CB 
 1161 1888 00000000 		or	%s60,0,%s32
 1161      A0003C45 
 1162 1890 00000000 		or	%s61,0,%s31
 1162      9F003D45 
 1163 1898 70FEFFFF 		br.l	.L4.5
 1163      00000F18 
 1164              	.L4.10:
 1165              	# line 380
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           int ow = iw - kw * (p->dw + 1) + PW;
 1166              		.loc	1 380 0
 1167 18a0 00000000 		or	%s56,1,(0)1
 1167      00013845 
 1168 18a8 00000000 		or	%s47,0,%s60
 1168      BC002F45 
 1169 18b0 00000000 		lvl	%s56
 1169      00B800BF 
 1170 18b8 00000028 		vldu.nc	%v40,0,%s47
 1170      AF000082 
 1171 18c0 00FFFFFF 		brlt.w	0,%s53,.L4.9
 1171      B5008218 
 1172 18c8 78FDFFFF 		br.l	.L4.6
 1172      00000F18 
 1173              	.L4.11:
 1174 18d0 D0FFFFFF 		brlt.w	0,%s53,.L4.10
 1174      B5008218 
 1175 18d8 10010000 		br.l	.L4.7
 1175      00000F18 
 1176              	.L4.12:
 1177 18e0 08010000 		brge.w	%s57,%s19,.L4.7
 1177      93B98518 
 1178 18e8 E8FFFFFF 		br.l	.L4.11
 1178      00000F18 
 1179              	.L4.13:
 1180              	# line 376
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         oh /= SH;
 1181              		.loc	1 376 0
 1182 18f0 00000000 		divs.w.sx	%s57,%s18,%s58
 1182      BA92397B 
 1183 18f8 00000000 		muls.w.sx	%s56,%s58,%s57
 1183      B9BA384B 
 1184 1900 00000000 		subs.w.sx	%s56,%s18,%s56
 1184      B892385A 
 1185 1908 E0000000 		brne.w	0,%s56,.L4.7
 1185      B8008318 
 1186 1910 D0FFFFFF 		br.l	.L4.12
 1186      00000F18 
 1187              	.L4.1:
 1188              	# line 392
 390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   };
 1189              		.loc	1 392 0
 1190              	# Start of epilogue codes
 1191 1918 30000000 		ld	%s18,48(,%fp)
 1191      89001201 
 1192 1920 38000000 		ld	%s19,56(,%fp)
 1192      89001301 
 1193 1928 40000000 		ld	%s20,64(,%fp)
 1193      89001401 
 1194 1930 48000000 		ld	%s21,72(,%fp)
 1194      89001501 
 1195 1938 50000000 		ld	%s22,80(,%fp)
 1195      89001601 
 1196 1940 88000000 		ld	%s29,136(,%fp)
 1196      89001D01 
 1197 1948 90000000 		ld	%s30,144(,%fp)
 1197      89001E01 
 1198 1950 98000000 		ld	%s31,152(,%fp)
 1198      89001F01 
 1199 1958 A0000000 		ld	%s32,160(,%fp)
 1199      89002001 
 1200 1960 A8000000 		ld	%s33,168(,%fp)
 1200      89002101 
 1201 1968 00000000 		or	%sp,0,%fp
 1201      89000B45 
 1202              		.cfi_def_cfa	11,8
 1203 1970 18000000 		ld	%got,0x18(,%sp)
 1203      8B000F01 
 1204 1978 20000000 		ld	%plt,0x20(,%sp)
 1204      8B001001 
 1205 1980 08000000 		ld	%lr,0x8(,%sp)
 1205      8B000A01 
 1206 1988 00000000 		ld	%fp,0x0(,%sp)
 1206      8B000901 
 1207 1990 00000000 		b.l	(,%lr)
 1207      8A000F19 
 1208              	.L4.14:
 1209 1998 80FFFFFF 		br.l	.L4.1
 1209      00000F18 
 1210              	.L4.15:
 1211              	# line 373
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int kh = 0; kh < KH; ++kh) {
 1212              		.loc	1 373 0
 1213 19a0 00000000 		adds.w.sx	%s63,1,%s63
 1213      BF013F4A 
 1214 19a8 00000000 		adds.w.sx	%s57,1,%s57
 1214      B901394A 
 1215 19b0 A8000000 		brgt.w	0,%s63,.L4.16
 1215      BF008118 
 1216 19b8 E0FFFFFF 		br.l	.L4.14
 1216      00000F18 
 1217              	.L4.17:
 1218 19c0 00000000 		or	%s63,0,%s21
 1218      95003F45 
 1219 19c8 00000000 		or	%s57,0,%s22
 1219      96003945 
 1220 19d0 00000000 		or	%s18,0,%s20
 1220      94001245 
 1221 19d8 C8FFFFFF 		br.l	.L4.15
 1221      00000F18 
 1222              	.L4.18:
 1223 19e0 30000000 		br.l	.L4.19
 1223      00000F18 
 1224              	.L4.7:
 1225              	# line 374
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int oh = ih - kh * (p->dh + 1) + PH;
 1226              		.loc	1 374 0
 1227 19e8 00000000 		adds.w.sx	%s63,1,%s63
 1227      BF013F4A 
 1228 19f0 00000000 		adds.w.sx	%s18,%s62,%s18
 1228      92BE124A 
 1229 19f8 00000000 		adds.w.sx	%s59,1,%s59
 1229      BB013B4A 
 1230 1a00 E0FFFFFF 		brgt.w	0,%s63,.L4.18
 1230      BF008118 
 1231 1a08 B8FFFFFF 		br.l	.L4.17
 1231      00000F18 
 1232              	.L4.19:
 1233 1a10 D8FFFFFF 		brgt.w	0,%s18,.L4.7
 1233      92008118 
 1234 1a18 D8FEFFFF 		br.l	.L4.13
 1234      00000F18 
 1235              	.L4.20:
 1236 1a20 00000000 		or	%s49,0,%s57
 1236      B9003145 
 1237 1a28 00000000 		or	%s20,0,%s18
 1237      92001445 
 1238 1a30 00000000 		or	%s21,0,%s63
 1238      BF001545 
 1239 1a38 00000000 		or	%s63,0,%s30
 1239      9E003F45 
 1240 1a40 00000000 		or	%s18,0,%s29
 1240      9D001245 
 1241 1a48 00000000 		or	%s22,0,%s57
 1241      B9001645 
 1242 1a50 C0FFFFFF 		br.l	.L4.19
 1242      00000F18 
 1243              	.L4.16:
 1244 1a58 00000000 		or	%s59,0,(0)1
 1244      00003B45 
 1245 1a60 C0FFFFFF 		brlt.w	0,%s18,.L4.20
 1245      92008218 
 1246 1a68 38FFFFFF 		br.l	.L4.15
 1246      00000F18 
 1247              	.L4.0:
 1248 1a70 20000000 		dldl.sx	%s18,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 1248      8100120B 
 1249 1a78 00000000 		or	%s40,0,%s2
 1249      82002845 
 1250 1a80 00000000 		or	%s39,0,%s3
 1250      83002745 
 1251 1a88 00000000 		subs.w.sx	%s30,0,%s18
 1251      92001E5A 
 1252              	# line 376
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         oh /= SH;
 1253              		.loc	1 376 0
 1254 1a90 F0000000 		dldl.sx	%s61,240(,%fp)	# ih
 1254      89003D0B 
 1255 1a98 00000000 		or	%s60,0,%s4
 1255      84003C45 
 1256 1aa0 38000000 		dldl.sx	%s59,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 1256      81003B0B 
 1257 1aa8 00000000 		adds.w.sx	%s59,1,%s59
 1257      BB013B4A 
 1258              	# line 374
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int oh = ih - kh * (p->dh + 1) + PH;
 1259              		.loc	1 374 0
 1260 1ab0 00000000 		subs.w.sx	%s59,0,%s59
 1260      BB003B5A 
 1261              	# line 376
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         oh /= SH;
 1262              		.loc	1 376 0
 1263 1ab8 30000000 		dldl.sx	%s56,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 1263      8100380B 
 1264              	# line 374
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int oh = ih - kh * (p->dh + 1) + PH;
 1265              		.loc	1 374 0
 1266 1ac0 00000000 		adds.w.sx	%s29,%s61,%s56
 1266      B8BD1D4A 
 1267              	# line 373
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int kh = 0; kh < KH; ++kh) {
 1268              		.loc	1 373 0
 1269 1ac8 00000000 		subs.w.sx	%s61,0,%s62
 1269      BE003D5A 
 1270 1ad0 00000000 		or	%s62,0,%s59
 1270      BB003E45 
 1271 1ad8 00000000 		or	%s63,0,%s61
 1271      BD003F45 
 1272              	# line 376
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         oh /= SH;
 1273              		.loc	1 376 0
 1274 1ae0 28000000 		dldl.sx	%s58,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 1274      81003A0B 
 1275              	# line 378
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1276              		.loc	1 378 0
 1277 1ae8 18000000 		dldl.sx	%s19,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1277      8100130B 
 1278              	# line 380
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           int ow = iw - kw * (p->dw + 1) + PW;
 1279              		.loc	1 380 0
 1280 1af0 24000000 		dldl.sx	%s53,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 1280      8100350B 
 1281 1af8 00000000 		or	%s41,0,%s53
 1281      B5002945 
 1282 1b00 00000000 		subs.w.sx	%s37,0,%s53
 1282      B500255A 
 1283              	# line 382
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ow /= SW;
 1284              		.loc	1 382 0
 1285 1b08 F8000000 		dldl.sx	%s61,248(,%fp)	# iw
 1285      89003D0B 
 1286 1b10 34000000 		dldl.sx	%s59,52(,%s1)	# *(p).__b_N4conv6desc_tE.pw
 1286      81003B0B 
 1287 1b18 00000000 		adds.w.sx	%s36,%s61,%s59
 1287      BBBD244A 
 1288 1b20 3C000000 		dldl.sx	%s61,60(,%s1)	# *(p).__b_N4conv6desc_tE.dw
 1288      81003D0B 
 1289 1b28 00000000 		adds.w.sx	%s61,1,%s61
 1289      BD013D4A 
 1290              	# line 380
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           int ow = iw - kw * (p->dw + 1) + PW;
 1291              		.loc	1 380 0
 1292 1b30 00000000 		subs.w.sx	%s35,0,%s61
 1292      BD00235A 
 1293              	# line 382
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ow /= SW;
 1294              		.loc	1 382 0
 1295 1b38 2C000000 		dldl.sx	%s31,44(,%s1)	# *(p).__b_N4conv6desc_tE.sw
 1295      81001F0B 
 1296              	# line 384
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1297              		.loc	1 384 0
 1298 1b40 1C000000 		dldl.sx	%s32,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 1298      8100200B 
 1299 1b48 00000000 		or	%s46,0,%s32
 1299      A0002E45 
 1300 1b50 00000000 		or	%s6,0,%s6
 1300      86000645 
 1301              	# line 386
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1302              		.loc	1 386 0
 1303 1b58 14000000 		dldl.sx	%s61,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1303      81003D0B 
 1304 1b60 00000000 		or	%s59,0,%s61
 1304      BD003B45 
 1305 1b68 00000000 		mulu.l	%s52,%s6,%s59
 1305      BB863449 
 1306 1b70 00000000 		muls.w.sx	%s55,%s5,%s61
 1306      BD85374B 
 1307 1b78 00000000 		or	%s5,0,%s5
 1307      85000545 
 1308              	# line 387
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 1309              		.loc	1 387 0
 1310 1b80 00000000 		mulu.l	%s51,%s59,%s5
 1310      85BB3349 
 1311              	# line 386
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 1312              		.loc	1 386 0
 1313 1b88 00000000 		dldl.sx	%s54,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1313      8100360B 
 1314 1b90 00000000 		or	%s50,0,%s54
 1314      B6003245 
 1315 1b98 18000000 		dldl.sx	%s61,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1315      81003D0B 
 1316 1ba0 00000000 		or	%s48,0,%s61
 1316      BD003045 
 1317              	# line 387
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           ds += pdiff_dst[dst_off] * pwei[wei_off];
 1318              		.loc	1 387 0
 1319 1ba8 08000000 		dldl.sx	%s61,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 1319      81003D0B 
 1320 1bb0 00000000 		or	%s45,0,%s61
 1320      BD002D45 
 1321 1bb8 00000000 		or	%s44,0,%s7
 1321      87002C45 
 1322 1bc0 20000000 		dldl.sx	%s1,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 1322      8100010B 
 1323 1bc8 00000000 		or	%s43,0,%s1
 1323      81002B45 
 1324 1bd0 88FEFFFF 		br.l	.L4.16
 1324      00000F18 
 1325              		.cfi_endproc
 1326              		.set	.L.5.2auto_size,	0xffffffffffffef00	# 4352 Bytes
 1328              	# ============ End  _ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_PKfS6_RfiiiiiE_
 1329              	# ============ Begin  _ZZN4conv15refconv_2_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_Rfii
 1330 1bd8 00000000 		.balign 16
 1330      00000000 
 1331              	# line 431
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMP(parallel for collapse(5))//;
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int g = 0; g < G; ++g) {
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float &ds = pdiff_src[src_off];
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             ds = 0;
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             if (fast)
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               ker_fast(p, precompute_size, pdiff_dst, pwei,
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                        ds, g, mb, ic, ih, iw);
 406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             else
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               ker(p, pdiff_dst, pwei, ds, g, mb, ic, ih, iw);
 408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** }
 414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** static inline void compute_bounds(int I, int O, int k, int S, int P, int D,
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         int &o_s, int &o_e) {
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const float tmp = P - k * (D + 1);
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   o_s = MAX2(0, ceilf(tmp / S));
 419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   o_e = MIN2(O, ceilf((I + tmp) / S));
 420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** };
 421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** void refconv_2_bwd_w(const prb_t *p, dnn_mem_t &src_m,
 423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                      dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
 424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float const * restrict const psrc      = (float*)src_m;
 426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
 427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_wei = (float*)diff_wei_m;
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_bia = (float*)diff_bia_m;
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   auto ker = []( const prb_t *p,
 430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                  const float * restrict pdiff_dst, const float* restrict psrc,
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                  float &dw, int g, int oc, int ic, int kh, int kw) {
 1332              		.loc	1 431 0
 1334              	conv::refconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float const*, float const*, float&, int, int, int, int, int)#1}::operator()(conv::prb_t const*, float const*, float const*, float&, int, int) const
 1335              		.cfi_startproc
 1336 1be0 00000000 		st	%fp,0x0(,%sp)
 1336      8B000911 
 1337              		.cfi_def_cfa_offset	0
 1338              		.cfi_offset	9,0
 1339 1be8 08000000 		st	%lr,0x8(,%sp)
 1339      8B000A11 
 1340 1bf0 18000000 		st	%got,0x18(,%sp)
 1340      8B000F11 
 1341 1bf8 20000000 		st	%plt,0x20(,%sp)
 1341      8B001011 
 1342 1c00 00000000 		or	%fp,0,%sp
 1342      8B000945 
 1343              		.cfi_def_cfa_register	9
 1344 1c08 30000000 		st	%s18,48(,%fp)
 1344      89001211 
 1345 1c10 38000000 		st	%s19,56(,%fp)
 1345      89001311 
 1346 1c18 40000000 		st	%s20,64(,%fp)
 1346      89001411 
 1347 1c20 58000000 		st	%s23,88(,%fp)
 1347      89001711 
 1348 1c28 60000000 		st	%s24,96(,%fp)
 1348      89001811 
 1349 1c30 68000000 		st	%s25,104(,%fp)
 1349      89001911 
 1350 1c38 70000000 		st	%s26,112(,%fp)
 1350      89001A11 
 1351 1c40 78000000 		st	%s27,120(,%fp)
 1351      89001B11 
 1352 1c48 A0000000 		st	%s32,160(,%fp)
 1352      89002011 
 1353 1c50 A8000000 		st	%s33,168(,%fp)
 1353      89002111 
 1354 1c58 90FDFFFF 		lea	%s13,.L.6.2auto_size&0xffffffff
 1354      00000D06 
 1355 1c60 00000000 		and	%s13,%s13,(32)0
 1355      608D0D44 
 1356 1c68 FFFFFFFF 		lea.sl	%sp,.L.6.2auto_size>>32(%fp,%s13)
 1356      8D898B06 
 1357 1c70 48000000 		brge.l.t	%sp,%sl,.L5.EoP
 1357      888B3518 
 1358 1c78 18000000 		ld	%s61,0x18(,%tp)
 1358      8E003D01 
 1359 1c80 00000000 		or	%s62,0,%s0
 1359      80003E45 
 1360 1c88 3B010000 		lea	%s63,0x13b
 1360      00003F06 
 1361 1c90 00000000 		shm.l	%s63,0x0(%s61)
 1361      BD033F31 
 1362 1c98 08000000 		shm.l	%sl,0x8(%s61)
 1362      BD030831 
 1363 1ca0 10000000 		shm.l	%sp,0x10(%s61)
 1363      BD030B31 
 1364 1ca8 00000000 		monc
 1364      0000003F 
 1365 1cb0 00000000 		or	%s0,0,%s62
 1365      BE000045 
 1366              	.L5.EoP:
 1367              	# End of prologue codes
 1368 1cb8 F8FFFFFF 		st	%s7,-8(,%fp)	# spill 
 1368      89000711 
 1369 1cc0 F0FFFFFF 		st	%s6,-16(,%fp)	# spill 
 1369      89000611 
 1370 1cc8 E8FFFFFF 		st	%s5,-24(,%fp)	# spill 
 1370      89000511 
 1371 1cd0 E0FFFFFF 		st	%s4,-32(,%fp)	# spill 
 1371      89000411 
 1372 1cd8 D8FFFFFF 		st	%s3,-40(,%fp)	# spill 
 1372      89000311 
 1373 1ce0 D0FFFFFF 		st	%s2,-48(,%fp)	# spill 
 1373      89000211 
 1374 1ce8 C8FFFFFF 		st	%s1,-56(,%fp)	# spill 
 1374      89000111 
 1375              	# line 433
 432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     int oh_s, oh_e, ow_s, ow_e;
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     compute_bounds(IH, OH, kh, SH, PH, p->dh, oh_s, oh_e);
 1376              		.loc	1 433 0
 1377 1cf0 0C000000 		ldl.sx	%s23,12(,%s1)	# *(p).__b_N4conv6desc_tE.ih
 1377      81001703 
 1378 1cf8 18000000 		ldl.sx	%s24,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1378      81001803 
 1379 1d00 28000000 		ldl.sx	%s25,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 1379      81001903 
 1380 1d08 00000000 		cvt.s.w	%s63,%s25
 1380      0099BF5E 
 1381 1d10 30000000 		ldl.sx	%s62,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 1381      81003E03 
 1382 1d18 38000000 		ldl.sx	%s1,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 1382      81000103 
 1383 1d20 F0000000 		ldl.sx	%s61,240(,%fp)	# kh
 1383      89003D03 
 1384 1d28 00000000 		adds.w.sx	%s1,1,%s1
 1384      8101014A 
 1385 1d30 00000000 		muls.w.sx	%s1,%s61,%s1
 1385      81BD014B 
 1386 1d38 00000000 		subs.w.sx	%s1,%s62,%s1
 1386      81BE015A 
 1387 1d40 00000000 		cvt.s.w	%s26,%s1
 1387      00819A5E 
 1388 1d48 00000000 		fdiv.s	%s0,%s26,%s63
 1388      BF9A805D 
 1389 1d50 C0FFFFFF 		st	%s0,-64(,%fp)	# spill 
 1389      89000011 
 1390 1d58 00000000 		lea	%s12,ceilf@LO
 1390      00000C06 
 1391 1d60 00000000 		and	%s12,%s12,(32)0
 1391      608C0C44 
 1392 1d68 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1392      8C008C06 
 1393 1d70 00000000 		bsic	%lr,(,%s12)	# ceilf
 1393      8C000A08 
 1394 1d78 00000000 		or	%s18,0,(0)1
 1394      00001245 
 1395 1d80 F0080000 		brgt.s	%s18,%s0,.L5.0
 1395      8092C118 
 1396 1d88 C0FFFFFF 		ld	%s0,-64(,%fp)	# restore 
 1396      89000001 
 1397 1d90 00000000 		lea	%s12,ceilf@LO
 1397      00000C06 
 1398 1d98 00000000 		and	%s12,%s12,(32)0
 1398      608C0C44 
 1399 1da0 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1399      8C008C06 
 1400 1da8 00000000 		bsic	%lr,(,%s12)	# ceilf
 1400      8C000A08 
 1401 1db0 00000000 		or	%s63,0,%s0
 1401      80003F45 
 1402 1db8 50080000 		br.l	.L5.1
 1402      00000F18 
 1403              	.L5.2:
 1404 1dc0 38FFFFFF 		ld	%s0,-200(,%fp)	# restore 
 1404      89000001 
 1405 1dc8 00000000 		lea	%s12,ceilf@LO
 1405      00000C06 
 1406 1dd0 00000000 		and	%s12,%s12,(32)0
 1406      608C0C44 
 1407 1dd8 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1407      8C008C06 
 1408 1de0 00000000 		bsic	%lr,(,%s12)	# ceilf
 1408      8C000A08 
 1409 1de8 00000000 		or	%s63,0,%s0
 1409      80003F45 
 1410 1df0 C8FFFFFF 		ld	%s1,-56(,%fp)	# restore 
 1410      89000101 
 1411 1df8 48070000 		br.l	.L5.3
 1411      00000F18 
 1412              	.L5.4:
 1413 1e00 30FFFFFF 		ld	%s0,-208(,%fp)	# restore 
 1413      89000001 
 1414              	# line 434
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     compute_bounds(IW, OW, kw, SW, PW, p->dw, ow_s, ow_e);
 1415              		.loc	1 434 0
 1416 1e08 00000000 		lea	%s12,ceilf@LO
 1416      00000C06 
 1417 1e10 00000000 		and	%s12,%s12,(32)0
 1417      608C0C44 
 1418 1e18 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1418      8C008C06 
 1419 1e20 00000000 		bsic	%lr,(,%s12)	# ceilf
 1419      8C000A08 
 1420 1e28 00000000 		or	%s63,0,%s0
 1420      80003F45 
 1421 1e30 00000000 		or	%s62,0,%s23
 1421      97003E45 
 1422 1e38 88060000 		br.l	.L5.5
 1422      00000F18 
 1423              	.L5.6:
 1424 1e40 28FFFFFF 		ld	%s0,-216(,%fp)	# restore 
 1424      89000001 
 1425 1e48 00000000 		lea	%s12,ceilf@LO
 1425      00000C06 
 1426 1e50 00000000 		and	%s12,%s12,(32)0
 1426      608C0C44 
 1427 1e58 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1427      8C008C06 
 1428 1e60 00000000 		bsic	%lr,(,%s12)	# ceilf
 1428      8C000A08 
 1429 1e68 00000000 		or	%s63,0,%s0
 1429      80003F45 
 1430 1e70 C8FFFFFF 		ld	%s1,-56(,%fp)	# restore 
 1430      89000101 
 1431 1e78 10060000 		br.l	.L5.7
 1431      00000F18 
 1432              	.L5.8:
 1433 1e80 00000000 		smvl	%s13
 1433      00000D2E 
 1434 1e88 00000000 		lvl	%s13
 1434      008D00BF 
 1435 1e90 003C003B 		vor	%v59,(0)1,%v60
 1435      000020C5 
 1436 1e98 18010000 		br.l	.L5.9
 1436      00000F18 
 1437              	.L5.10:
 1438              	# line 439
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int oh = oh_s; oh < oh_e; ++oh) {
 438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int ow = ow_s; ow < ow_e; ++ow) {
 1439              		.loc	1 439 0
 1440 1ea0 80000000 		mins.w.sx	%s61,%s56,%s61
 1440      BDB83D78 
 1441 1ea8 90010000 		br.l	.L5.11
 1441      00000F18 
 1442              	.L5.12:
 1443              	# line 449
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1);
 442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           dw += pdiff_dst[dst_off] * psrc[src_off];
 446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   };
 1444              		.loc	1 449 0
 1445              	# Start of epilogue codes
 1446 1eb0 30000000 		ld	%s18,48(,%fp)
 1446      89001201 
 1447 1eb8 38000000 		ld	%s19,56(,%fp)
 1447      89001301 
 1448 1ec0 40000000 		ld	%s20,64(,%fp)
 1448      89001401 
 1449 1ec8 58000000 		ld	%s23,88(,%fp)
 1449      89001701 
 1450 1ed0 60000000 		ld	%s24,96(,%fp)
 1450      89001801 
 1451 1ed8 68000000 		ld	%s25,104(,%fp)
 1451      89001901 
 1452 1ee0 70000000 		ld	%s26,112(,%fp)
 1452      89001A01 
 1453 1ee8 78000000 		ld	%s27,120(,%fp)
 1453      89001B01 
 1454 1ef0 A0000000 		ld	%s32,160(,%fp)
 1454      89002001 
 1455 1ef8 A8000000 		ld	%s33,168(,%fp)
 1455      89002101 
 1456 1f00 00000000 		or	%sp,0,%fp
 1456      89000B45 
 1457              		.cfi_def_cfa	11,8
 1458 1f08 18000000 		ld	%got,0x18(,%sp)
 1458      8B000F01 
 1459 1f10 20000000 		ld	%plt,0x20(,%sp)
 1459      8B001001 
 1460 1f18 08000000 		ld	%lr,0x8(,%sp)
 1460      8B000A01 
 1461 1f20 00000000 		ld	%fp,0x0(,%sp)
 1461      8B000901 
 1462 1f28 00000000 		b.l	(,%lr)
 1462      8A000F19 
 1463              	.L5.13:
 1464              	# line 436
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int oh = oh_s; oh < oh_e; ++oh) {
 1465              		.loc	1 436 0
 1466 1f30 00000000 		adds.w.sx	%s63,1,%s63
 1466      BF013F4A 
 1467 1f38 00000000 		adds.l	%s58,%s61,%s58
 1467      BABD3A59 
 1468 1f40 00000000 		adds.l	%s55,%s56,%s55
 1468      B7B83759 
 1469 1f48 50030000 		brgt.w	0,%s63,.L5.14
 1469      BF008118 
 1470 1f50 60FFFFFF 		br.l	.L5.12
 1470      00000F18 
 1471              	.L5.15:
 1472 1f58 00000000 		or	%s63,0,%s2
 1472      82003F45 
 1473 1f60 00000000 		or	%s61,0,%s3
 1473      83003D45 
 1474 1f68 00000000 		or	%s58,0,%s6
 1474      86003A45 
 1475 1f70 00000000 		or	%s56,0,%s4
 1475      84003845 
 1476 1f78 00000000 		or	%s55,0,%s5
 1476      85003745 
 1477 1f80 B0FFFFFF 		br.l	.L5.13
 1477      00000F18 
 1478              	.L5.16:
 1479              	# line 437
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 1480              		.loc	1 437 0
 1481 1f88 00000000 		adds.w.sx	%s63,1,%s63
 1481      BF013F4A 
 1482 1f90 00000000 		adds.w.sx	%s61,%s62,%s61
 1482      BDBE3D4A 
 1483 1f98 00000000 		adds.w.sx	%s60,1,%s60
 1483      BC013C4A 
 1484 1fa0 80020000 		brgt.w	0,%s63,.L5.17
 1484      BF008118 
 1485 1fa8 B0FFFFFF 		br.l	.L5.15
 1485      00000F18 
 1486              	.L5.9:
 1487              	# line 446
 446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 1488              		.loc	1 446 0
 1489 1fb0 00000000 		or	%s59,1,(0)1
 1489      00013B45 
 1490 1fb8 00000000 		or	%s58,0,%s57
 1490      B9003A45 
 1491 1fc0 00000000 		lvl	%s59
 1491      00BB00BF 
 1492 1fc8 0000003B 		vstu.nc	%v59,0,%s58
 1492      BA000092 
 1493 1fd0 B8FFFFFF 		br.l	.L5.16
 1493      00000F18 
 1494              	.L5.18:
 1495 1fd8 00000000 		or	%s1,0,%s59
 1495      BB000145 
 1496              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1497              		.loc	1 445 0
 1498 1fe0 00000000 		lvl	%s55
 1498      00B700BF 
 1499 1fe8 00003F3A 		vfsum.s	%v58,%v63
 1499      000080EC 
 1500 1ff0 00000000 		or	%s59,1,(0)1
 1500      00013B45 
 1501 1ff8 00000000 		lvl	%s59
 1501      00BB00BF 
 1502 2000 003A3B3B 		vfadd.s	%v59,%v59,%v58
 1502      000080CC 
 1503 2008 00000000 		or	%s63,0,%s54
 1503      B6003F45 
 1504 2010 00000000 		or	%s62,0,%s53
 1504      B5003E45 
 1505 2018 00000000 		or	%s61,0,%s52
 1505      B4003D45 
 1506 2020 00000000 		or	%s60,0,%s51
 1506      B3003C45 
 1507 2028 00000000 		or	%s57,0,%s50
 1507      B2003945 
 1508 2030 80FFFFFF 		br.l	.L5.9
 1508      00000F18 
 1509              	.L5.11:
 1510 2038 00000000 		or	%s62,0,%s63
 1510      BF003E45 
 1511 2040 00000000 		lvl	%s61
 1511      00BD00BF 
 1512 2048 0000003E 		vldu.nc	%v62,4,%s62
 1512      BE040082 
 1513 2050 00000000 		or	%s62,0,%s60
 1513      BC003E45 
 1514 2058 0000003D 		vldu.nc	%v61,%s59,%s62
 1514      BEBB0082 
 1515 2060 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 1515      000080E2 
 1516              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1517              		.loc	1 439 0
 1518 2068 00000000 		adds.l	%s63,%s63,%s58
 1518      BABF3F59 
 1519 2070 00000000 		adds.l	%s60,%s60,%s57
 1519      B9BC3C59 
 1520 2078 00000000 		subs.w.sx	%s56,%s56,%s61
 1520      BDB8385A 
 1521 2080 58FFFFFF 		brge.w	0,%s56,.L5.18
 1521      B8008518 
 1522 2088 18FEFFFF 		br.l	.L5.10
 1522      00000F18 
 1523              	.L5.19:
 1524              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1525              		.loc	1 445 0
 1526 2090 00000000 		divs.w.sx	%s47,%s49,%s48
 1526      B0B12F7B 
 1527 2098 00000000 		or	%s59,0,%s1
 1527      81003B45 
 1528 20a0 00000000 		or	%s53,0,%s62
 1528      BE003545 
 1529 20a8 00000000 		or	%s50,0,%s57
 1529      B9003245 
 1530 20b0 00000000 		or	%s51,0,%s60
 1530      BC003345 
 1531 20b8 00000000 		or	%s52,0,%s61
 1531      BD003445 
 1532 20c0 00000000 		or	%s54,0,%s63
 1532      BF003645 
 1533 20c8 00000000 		smvl	%s13
 1533      00000D2E 
 1534 20d0 00000000 		lvl	%s13
 1534      008D00BF 
 1535 20d8 003C003B 		vor	%v59,(0)1,%v60
 1535      000020C5 
 1536 20e0 00000000 		or	%s47,0,%s47
 1536      AF002F45 
 1537 20e8 00000000 		addu.l	%s47,%s47,%s46
 1537      AEAF2F48 
 1538 20f0 00000000 		addu.l	%s47,%s47,%s45
 1538      ADAF2F48 
 1539 20f8 00000000 		mulu.l	%s47,%s47,%s44
 1539      ACAF2F49 
 1540 2100 00000000 		or	%s62,0,%s61
 1540      BD003E45 
 1541 2108 00000000 		addu.l	%s62,%s47,%s62
 1541      BEAF3E48 
 1542 2110 00000000 		mulu.l	%s62,%s62,%s43
 1542      ABBE3E49 
 1543 2118 00000000 		or	%s62,0,%s62
 1543      BE003E45 
 1544 2120 00000000 		divs.w.sx	%s47,%s42,%s48
 1544      B0AA2F7B 
 1545 2128 00000000 		or	%s47,0,%s47
 1545      AF002F45 
 1546 2130 00000000 		addu.l	%s47,%s47,%s41
 1546      A9AF2F48 
 1547 2138 00000000 		addu.l	%s47,%s47,%s40
 1547      A8AF2F48 
 1548 2140 00000000 		mulu.l	%s47,%s47,%s39
 1548      A7AF2F49 
 1549 2148 00000000 		or	%s34,0,%s60
 1549      BC002245 
 1550 2150 00000000 		addu.l	%s34,%s47,%s34
 1550      A2AF2248 
 1551 2158 00000000 		mulu.l	%s34,%s34,%s38
 1551      A6A22249 
 1552 2160 00000000 		or	%s34,0,%s34
 1552      A2002245 
 1553              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1554              		.loc	1 439 0
 1555 2168 00000000 		muls.l	%s34,4,%s34
 1555      A204226E 
 1556 2170 00000000 		muls.l	%s62,4,%s62
 1556      BE043E6E 
 1557 2178 00000000 		adds.l	%s34,%s34,%s37
 1557      A5A22259 
 1558 2180 00000000 		adds.l	%s62,%s62,%s36
 1558      A4BE3E59 
 1559 2188 00000000 		subs.w.sx	%s47,0,%s35
 1559      A3002F5A 
 1560 2190 00000000 		smvl	%s55
 1560      0000372E 
 1561 2198 80000000 		mins.w.sx	%s61,%s47,%s55
 1561      B7AF3D78 
 1562              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1563              		.loc	1 445 0
 1564 21a0 00000000 		or	%s7,0,(0)1
 1564      00000745 
 1565 21a8 00000000 		lvl	%s55
 1565      00B700BF 
 1566 21b0 0000003F 		vbrdu	%v63,%s7
 1566      0087808C 
 1567 21b8 00000000 		or	%s56,0,%s47
 1567      AF003845 
 1568 21c0 00000000 		or	%s47,0,%s61
 1568      BD002F45 
 1569 21c8 00000000 		or	%s63,0,%s34
 1569      A2003F45 
 1570              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1571              		.loc	1 439 0
 1572 21d0 00000000 		muls.l	%s58,4,%s47
 1572      AF043A6E 
 1573 21d8 00000000 		or	%s60,0,%s62
 1573      BE003C45 
 1574 21e0 00000000 		muls.l	%s57,%s1,%s47
 1574      AF81396E 
 1575 21e8 50FEFFFF 		br.l	.L5.11
 1575      00000F18 
 1576              	.L5.20:
 1577              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1578              		.loc	1 445 0
 1579 21f0 00000000 		or	%s58,1,(0)1
 1579      00013A45 
 1580 21f8 00000000 		or	%s56,0,%s57
 1580      B9003845 
 1581 2200 00000000 		lvl	%s58
 1581      00BA00BF 
 1582 2208 0000003C 		vldu.nc	%v60,0,%s56
 1582      B8000082 
 1583 2210 80FEFFFF 		brlt.w	0,%s18,.L5.19
 1583      92008218 
 1584 2218 68FCFFFF 		br.l	.L5.8
 1584      00000F18 
 1585              	.L5.17:
 1586 2220 D0FFFFFF 		brlt.w	0,%s18,.L5.20
 1586      92008218 
 1587 2228 60FDFFFF 		br.l	.L5.16
 1587      00000F18 
 1588              	.L5.21:
 1589 2230 00000000 		or	%s46,0,%s58
 1589      BA002E45 
 1590 2238 00000000 		or	%s41,0,%s55
 1590      B7002945 
 1591              	# line 437
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 1592              		.loc	1 437 0
 1593 2240 00000000 		adds.w.sx	%s59,%s19,%s33
 1593      A1933B4A 
 1594 2248 00000000 		muls.w.sx	%s54,%s19,%s62
 1594      BE93364B 
 1595 2250 00000000 		or	%s2,0,%s63
 1595      BF000245 
 1596 2258 00000000 		or	%s63,0,%s59
 1596      BB003F45 
 1597 2260 00000000 		adds.w.sx	%s54,%s54,%s32
 1597      A0B6364A 
 1598 2268 00000000 		or	%s3,0,%s61
 1598      BD000345 
 1599 2270 00000000 		or	%s61,0,%s54
 1599      B6003D45 
 1600 2278 00000000 		or	%s4,0,%s56
 1600      B8000445 
 1601 2280 00000000 		or	%s5,0,%s55
 1601      B7000545 
 1602 2288 00000000 		or	%s6,0,%s58
 1602      BA000645 
 1603 2290 90FFFFFF 		br.l	.L5.17
 1603      00000F18 
 1604              	.L5.14:
 1605 2298 00000000 		or	%s60,0,%s19
 1605      93003C45 
 1606 22a0 90FFFFFF 		brlt.w	%s19,%s20,.L5.21
 1606      94938218 
 1607 22a8 88FCFFFF 		br.l	.L5.13
 1607      00000F18 
 1608              	.L5.22:
 1609 22b0 00000000 		or	%s60,0,%s23
 1609      97003C45 
 1610              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1611              		.loc	1 439 0
 1612 22b8 00000000 		subs.w.sx	%s23,%s63,%s23
 1612      97BF175A 
 1613 22c0 E0FFFFFF 		ld	%s57,-32(,%fp)	# restore 
 1613      89003901 
 1614 22c8 00000000 		subs.w.sx	%s35,0,%s23
 1614      9700235A 
 1615 22d0 00000000 		muls.l	%s60,4,%s60
 1615      BC043C6E 
 1616              	# line 436
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int oh = oh_s; oh < oh_e; ++oh) {
 1617              		.loc	1 436 0
 1618 22d8 00000000 		subs.w.sx	%s59,0,%s18
 1618      92003B5A 
 1619 22e0 00000000 		or	%s18,0,%s23
 1619      97001245 
 1620 22e8 00000000 		or	%s63,0,%s59
 1620      BB003F45 
 1621 22f0 00000000 		or	%s58,0,(0)1
 1621      00003A45 
 1622 22f8 00000000 		or	%s55,0,(0)1
 1622      00003745 
 1623              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1624              		.loc	1 445 0
 1625 2300 28000000 		dldl.sx	%s62,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 1625      81003E0B 
 1626 2308 30000000 		dldl.sx	%s59,48(,%s1)	# *(p).__b_N4conv6desc_tE.ph
 1626      81003B0B 
 1627 2310 F0000000 		dldl.sx	%s54,240(,%fp)	# kh
 1627      8900360B 
 1628 2318 38000000 		dldl.sx	%s53,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 1628      8100350B 
 1629 2320 00000000 		adds.w.sx	%s53,1,%s53
 1629      B501354A 
 1630 2328 00000000 		muls.w.sx	%s53,%s54,%s53
 1630      B5B6354B 
 1631              	# line 437
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 1632              		.loc	1 437 0
 1633 2330 00000000 		subs.w.sx	%s32,%s53,%s59
 1633      BBB5205A 
 1634              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1635              		.loc	1 445 0
 1636 2338 08000000 		dldl.sx	%s59,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 1636      81003B0B 
 1637 2340 00000000 		or	%s54,0,%s59
 1637      BB003645 
 1638 2348 00000000 		or	%s61,0,%s54
 1638      B6003D45 
 1639 2350 E8FFFFFF 		ld	%s5,-24(,%fp)	# restore 
 1639      89000501 
 1640 2358 00000000 		muls.w.sx	%s49,%s59,%s5
 1640      85BB314B 
 1641 2360 00000000 		dldl.sx	%s48,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1641      8100300B 
 1642 2368 F8FFFFFF 		ld	%s45,-8(,%fp)	# restore 
 1642      89002D01 
 1643 2370 0C000000 		dldl.sx	%s59,12(,%s1)	# *(p).__b_N4conv6desc_tE.ih
 1643      81003B0B 
 1644 2378 00000000 		or	%s44,0,%s59
 1644      BB002C45 
 1645 2380 10000000 		dldl.sx	%s59,16(,%s1)	# *(p).__b_N4conv6desc_tE.iw
 1645      81003B0B 
 1646 2388 00000000 		or	%s43,0,%s59
 1646      BB002B45 
 1647 2390 F8000000 		dldl.sx	%s59,248(,%fp)	# kw
 1647      89003B0B 
 1648 2398 00000000 		or	%s54,0,%s59
 1648      BB003645 
 1649              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1650              		.loc	1 439 0
 1651 23a0 00000000 		muls.l	%s54,4,%s54
 1651      B604366E 
 1652              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1653              		.loc	1 445 0
 1654 23a8 3C000000 		dldl.sx	%s53,60(,%s1)	# *(p).__b_N4conv6desc_tE.dw
 1654      8100350B 
 1655 23b0 00000000 		muls.w.sx	%s53,%s59,%s53
 1655      B5BB354B 
 1656 23b8 34000000 		dldl.sx	%s59,52(,%s1)	# *(p).__b_N4conv6desc_tE.pw
 1656      81003B0B 
 1657 23c0 00000000 		subs.w.sx	%s59,%s53,%s59
 1657      BBB53B5A 
 1658 23c8 00000000 		or	%s59,0,%s59
 1658      BB003B45 
 1659              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1660              		.loc	1 439 0
 1661 23d0 00000000 		muls.l	%s59,4,%s59
 1661      BB043B6E 
 1662              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1663              		.loc	1 445 0
 1664 23d8 2C000000 		dldl.sx	%s53,44(,%s1)	# *(p).__b_N4conv6desc_tE.sw
 1664      8100350B 
 1665 23e0 00000000 		or	%s53,0,%s53
 1665      B5003545 
 1666              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1667              		.loc	1 439 0
 1668 23e8 00000000 		muls.l	%s52,4,%s53
 1668      B504346E 
 1669 23f0 00000000 		muls.l	%s53,%s60,%s53
 1669      B5BC356E 
 1670 23f8 00000000 		adds.l	%s59,%s53,%s59
 1670      BBB53B59 
 1671 2400 00000000 		adds.l	%s54,%s59,%s54
 1671      B6BB3659 
 1672              	# line 445
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 1673              		.loc	1 445 0
 1674 2408 14000000 		dldl.sx	%s59,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1674      81003B0B 
 1675 2410 00000000 		or	%s53,0,%s59
 1675      BB003545 
 1676 2418 00000000 		or	%s56,0,%s53
 1676      B5003845 
 1677 2420 00000000 		muls.w.sx	%s42,%s5,%s59
 1677      BB852A4B 
 1678 2428 F0FFFFFF 		ld	%s40,-16(,%fp)	# restore 
 1678      89002801 
 1679 2430 18000000 		dldl.sx	%s59,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1679      81003B0B 
 1680 2438 00000000 		or	%s39,0,%s59
 1680      BB002745 
 1681 2440 1C000000 		dldl.sx	%s59,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 1681      81003B0B 
 1682 2448 00000000 		or	%s1,0,%s52
 1682      B4000145 
 1683 2450 00000000 		or	%s38,0,%s59
 1683      BB002645 
 1684              	# line 437
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         IVDEPx()//;
 1685              		.loc	1 437 0
 1686 2458 00000000 		subs.w.sx	%s33,0,%s20
 1686      9400215A 
 1687 2460 D0FFFFFF 		ld	%s2,-48(,%fp)	# restore 
 1687      89000201 
 1688              	# line 439
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           const int ih = oh * SH - PH + kh * (p->dh + 1);
 1689              		.loc	1 439 0
 1690 2468 00000000 		adds.l	%s37,%s60,%s2
 1690      82BC2559 
 1691 2470 D8FFFFFF 		ld	%s3,-40(,%fp)	# restore 
 1691      89000301 
 1692 2478 00000000 		adds.l	%s36,%s3,%s54
 1692      B6832459 
 1693 2480 18FEFFFF 		br.l	.L5.14
 1693      00000F18 
 1694              	.L5.7:
 1695              	# line 434
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1696              		.loc	1 434 0
 1697 2488 00000000 		cvt.w.s.sx.rz	%s63,%s63
 1697      08BFBF4E 
 1698              	# line 436
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int oh = oh_s; oh < oh_e; ++oh) {
 1699              		.loc	1 436 0
 1700 2490 04000000 		ldl.sx	%s18,4(,%s1)	# *(p).__b_N4conv6desc_tE.mb
 1700      81001203 
 1701 2498 18FEFFFF 		brlt.w	0,%s18,.L5.22
 1701      92008218 
 1702 24a0 10FAFFFF 		br.l	.L5.12
 1702      00000F18 
 1703              	.L5.23:
 1704              	# line 434
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1705              		.loc	1 434 0
 1706 24a8 00000000 		cvt.s.w	%s63,%s24
 1706      0098BF5E 
 1707 24b0 C8FFFFFF 		ld	%s1,-56(,%fp)	# restore 
 1707      89000101 
 1708 24b8 D0FFFFFF 		br.l	.L5.7
 1708      00000F18 
 1709              	.L5.5:
 1710 24c0 00000000 		cvt.w.s.sx.rz	%s23,%s63
 1710      08BF974E 
 1711 24c8 00000000 		cvt.s.w	%s27,%s24
 1711      00989B5E 
 1712 24d0 00000000 		cvt.s.w	%s62,%s62
 1712      00BEBE5E 
 1713 24d8 00000000 		fadd.s	%s26,%s62,%s26
 1713      9ABE9A4C 
 1714 24e0 00000000 		cvt.s.w	%s25,%s25
 1714      0099995E 
 1715 24e8 00000000 		fdiv.s	%s0,%s26,%s25
 1715      999A805D 
 1716 24f0 28FFFFFF 		st	%s0,-216(,%fp)	# spill 
 1716      89000011 
 1717 24f8 00000000 		lea	%s12,ceilf@LO
 1717      00000C06 
 1718 2500 00000000 		and	%s12,%s12,(32)0
 1718      608C0C44 
 1719 2508 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1719      8C008C06 
 1720 2510 00000000 		bsic	%lr,(,%s12)	# ceilf
 1720      8C000A08 
 1721 2518 90FFFFFF 		brlt.s	%s27,%s0,.L5.23
 1721      809BC218 
 1722 2520 20F9FFFF 		br.l	.L5.6
 1722      00000F18 
 1723              	.L5.24:
 1724 2528 00000000 		or	%s63,0,(0)1
 1724      00003F45 
 1725 2530 00000000 		or	%s62,0,%s23
 1725      97003E45 
 1726 2538 88FFFFFF 		br.l	.L5.5
 1726      00000F18 
 1727              	.L5.3:
 1728              	# line 433
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     compute_bounds(IW, OW, kw, SW, PW, p->dw, ow_s, ow_e);
 1729              		.loc	1 433 0
 1730 2540 00000000 		cvt.w.s.sx.rz	%s20,%s63
 1730      08BF944E 
 1731 2548 C8FFFFFF 		st	%s1,-56(,%fp)	# spill 
 1731      89000111 
 1732              	# line 434
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1733              		.loc	1 434 0
 1734 2550 10000000 		ldl.sx	%s23,16(,%s1)	# *(p).__b_N4conv6desc_tE.iw
 1734      81001703 
 1735 2558 1C000000 		ldl.sx	%s24,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 1735      81001803 
 1736 2560 2C000000 		ldl.sx	%s25,44(,%s1)	# *(p).__b_N4conv6desc_tE.sw
 1736      81001903 
 1737 2568 00000000 		cvt.s.w	%s63,%s25
 1737      0099BF5E 
 1738 2570 34000000 		ldl.sx	%s62,52(,%s1)	# *(p).__b_N4conv6desc_tE.pw
 1738      81003E03 
 1739 2578 3C000000 		ldl.sx	%s61,60(,%s1)	# *(p).__b_N4conv6desc_tE.dw
 1739      81003D03 
 1740 2580 F8000000 		ldl.sx	%s60,248(,%fp)	# kw
 1740      89003C03 
 1741 2588 00000000 		adds.w.sx	%s61,1,%s61
 1741      BD013D4A 
 1742 2590 00000000 		muls.w.sx	%s61,%s60,%s61
 1742      BDBC3D4B 
 1743 2598 00000000 		subs.w.sx	%s61,%s62,%s61
 1743      BDBE3D5A 
 1744 25a0 00000000 		cvt.s.w	%s26,%s61
 1744      00BD9A5E 
 1745 25a8 00000000 		fdiv.s	%s0,%s26,%s63
 1745      BF9A805D 
 1746 25b0 30FFFFFF 		st	%s0,-208(,%fp)	# spill 
 1746      89000011 
 1747 25b8 00000000 		lea	%s12,ceilf@LO
 1747      00000C06 
 1748 25c0 00000000 		and	%s12,%s12,(32)0
 1748      608C0C44 
 1749 25c8 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1749      8C008C06 
 1750 25d0 00000000 		bsic	%lr,(,%s12)	# ceilf
 1750      8C000A08 
 1751 25d8 00000000 		or	%s18,0,(0)1
 1751      00001245 
 1752 25e0 48FFFFFF 		brgt.s	%s18,%s0,.L5.24
 1752      8092C118 
 1753 25e8 18F8FFFF 		br.l	.L5.4
 1753      00000F18 
 1754              	.L5.25:
 1755              	# line 433
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     compute_bounds(IW, OW, kw, SW, PW, p->dw, ow_s, ow_e);
 1756              		.loc	1 433 0
 1757 25f0 00000000 		cvt.s.w	%s63,%s24
 1757      0098BF5E 
 1758 25f8 C8FFFFFF 		ld	%s1,-56(,%fp)	# restore 
 1758      89000101 
 1759 2600 40FFFFFF 		br.l	.L5.3
 1759      00000F18 
 1760              	.L5.1:
 1761 2608 00000000 		cvt.w.s.sx.rz	%s19,%s63
 1761      08BF934E 
 1762 2610 00000000 		cvt.s.w	%s27,%s24
 1762      00989B5E 
 1763 2618 00000000 		cvt.s.w	%s23,%s23
 1763      0097975E 
 1764 2620 00000000 		fadd.s	%s26,%s23,%s26
 1764      9A979A4C 
 1765 2628 00000000 		cvt.s.w	%s25,%s25
 1765      0099995E 
 1766 2630 00000000 		fdiv.s	%s0,%s26,%s25
 1766      999A805D 
 1767 2638 38FFFFFF 		st	%s0,-200(,%fp)	# spill 
 1767      89000011 
 1768 2640 00000000 		lea	%s12,ceilf@LO
 1768      00000C06 
 1769 2648 00000000 		and	%s12,%s12,(32)0
 1769      608C0C44 
 1770 2650 00000000 		lea.sl	%s12,ceilf@HI(,%s12)
 1770      8C008C06 
 1771 2658 00000000 		bsic	%lr,(,%s12)	# ceilf
 1771      8C000A08 
 1772 2660 90FFFFFF 		brlt.s	%s27,%s0,.L5.25
 1772      809BC218 
 1773 2668 58F7FFFF 		br.l	.L5.2
 1773      00000F18 
 1774              	.L5.0:
 1775 2670 00000000 		or	%s63,0,(0)1
 1775      00003F45 
 1776 2678 90FFFFFF 		br.l	.L5.1
 1776      00000F18 
 1777              		.cfi_endproc
 1778              		.set	.L.6.2auto_size,	0xfffffffffffffd90	# 624 Bytes
 1780              	# ============ End  _ZZN4conv15refconv_2_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_Rfiiii
 1781              	# ============ Begin  conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1782              		.balign 16
 1783              	# line 47
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //char attr_buf[max_attr_len];
 1784              		.loc	1 47 0
 1785              		.globl	conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 1787              	conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 1788              		.cfi_startproc
 1789 2680 00000000 		st	%fp,0x0(,%sp)
 1789      8B000911 
 1790              		.cfi_def_cfa_offset	0
 1791              		.cfi_offset	9,0
 1792 2688 08000000 		st	%lr,0x8(,%sp)
 1792      8B000A11 
 1793 2690 18000000 		st	%got,0x18(,%sp)
 1793      8B000F11 
 1794 2698 20000000 		st	%plt,0x20(,%sp)
 1794      8B001011 
 1795 26a0 00000000 		or	%fp,0,%sp
 1795      8B000945 
 1796              		.cfi_def_cfa_register	9
 1797 26a8 30000000 		st	%s18,48(,%fp)
 1797      89001211 
 1798 26b0 38000000 		st	%s19,56(,%fp)
 1798      89001311 
 1799 26b8 50000000 		st	%s22,80(,%fp)
 1799      89001611 
 1800 26c0 58000000 		st	%s23,88(,%fp)
 1800      89001711 
 1801 26c8 60000000 		st	%s24,96(,%fp)
 1801      89001811 
 1802 26d0 68000000 		st	%s25,104(,%fp)
 1802      89001911 
 1803 26d8 70000000 		st	%s26,112(,%fp)
 1803      89001A11 
 1804 26e0 78000000 		st	%s27,120(,%fp)
 1804      89001B11 
 1805 26e8 80000000 		st	%s28,128(,%fp)
 1805      89001C11 
 1806 26f0 88000000 		st	%s29,136(,%fp)
 1806      89001D11 
 1807 26f8 90000000 		st	%s30,144(,%fp)
 1807      89001E11 
 1808 2700 98000000 		st	%s31,152(,%fp)
 1808      89001F11 
 1809 2708 A0000000 		st	%s32,160(,%fp)
 1809      89002011 
 1810 2710 A8000000 		st	%s33,168(,%fp)
 1810      89002111 
 1811 2718 70FDFFFF 		lea	%s13,.L.7.2auto_size&0xffffffff
 1811      00000D06 
 1812 2720 00000000 		and	%s13,%s13,(32)0
 1812      608D0D44 
 1813 2728 FFFFFFFF 		lea.sl	%sp,.L.7.2auto_size>>32(%fp,%s13)
 1813      8D898B06 
 1814 2730 48000000 		brge.l.t	%sp,%sl,.L6.EoP
 1814      888B3518 
 1815 2738 18000000 		ld	%s61,0x18(,%tp)
 1815      8E003D01 
 1816 2740 00000000 		or	%s62,0,%s0
 1816      80003E45 
 1817 2748 3B010000 		lea	%s63,0x13b
 1817      00003F06 
 1818 2750 00000000 		shm.l	%s63,0x0(%s61)
 1818      BD033F31 
 1819 2758 08000000 		shm.l	%sl,0x8(%s61)
 1819      BD030831 
 1820 2760 10000000 		shm.l	%sp,0x10(%s61)
 1820      BD030B31 
 1821 2768 00000000 		monc
 1821      0000003F 
 1822 2770 00000000 		or	%s0,0,%s62
 1822      BE000045 
 1823              	.L6.EoP:
 1824              	# End of prologue codes
 1825              	# line 99
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const float* restrict const pwei = (float*)wei_m;
 1826              		.loc	1 99 0
 1827 2778 A8010000 		ld	%s63,424(,%s1)	# *(src_m).data_
 1827      81003F01 
 1828              	# line 100
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const float* restrict const pbia = (float*)bia_m;
 1829              		.loc	1 100 0
 1830 2780 A8010000 		ld	%s62,424(,%s2)	# *(wei_m).data_
 1830      82003E01 
 1831              	# line 101
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   /* */ float* restrict const pdst = (float*)dst_m;
 1832              		.loc	1 101 0
 1833 2788 A8010000 		ld	%s22,424(,%s3)	# *(bia_m).data_
 1833      83001601 
 1834              	# line 102
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMP(parallel for collapse(5))//;
 1835              		.loc	1 102 0
 1836 2790 A8010000 		ld	%s30,424(,%s4)	# *(dst_m).data_
 1836      84001E01 
 1837              	# line 104
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1838              		.loc	1 104 0
 1839 2798 00000000 		or	%s5,0,(0)1
 1839      00000545 
 1840 27a0 00000000 		ldl.sx	%s18,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 1840      80001203 
 1841 27a8 D8050000 		brlt.w	0,%s18,.L6.0
 1841      92008218 
 1842 27b0 08000000 		br.l	.L6.1
 1842      00000F18 
 1843              	.L6.1:
 1844              	# line 132
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1845              		.loc	1 132 0
 1846              	# Start of epilogue codes
 1847 27b8 30000000 		ld	%s18,48(,%fp)
 1847      89001201 
 1848 27c0 38000000 		ld	%s19,56(,%fp)
 1848      89001301 
 1849 27c8 50000000 		ld	%s22,80(,%fp)
 1849      89001601 
 1850 27d0 58000000 		ld	%s23,88(,%fp)
 1850      89001701 
 1851 27d8 60000000 		ld	%s24,96(,%fp)
 1851      89001801 
 1852 27e0 68000000 		ld	%s25,104(,%fp)
 1852      89001901 
 1853 27e8 70000000 		ld	%s26,112(,%fp)
 1853      89001A01 
 1854 27f0 78000000 		ld	%s27,120(,%fp)
 1854      89001B01 
 1855 27f8 80000000 		ld	%s28,128(,%fp)
 1855      89001C01 
 1856 2800 88000000 		ld	%s29,136(,%fp)
 1856      89001D01 
 1857 2808 90000000 		ld	%s30,144(,%fp)
 1857      89001E01 
 1858 2810 98000000 		ld	%s31,152(,%fp)
 1858      89001F01 
 1859 2818 A0000000 		ld	%s32,160(,%fp)
 1859      89002001 
 1860 2820 A8000000 		ld	%s33,168(,%fp)
 1860      89002101 
 1861 2828 00000000 		or	%sp,0,%fp
 1861      89000B45 
 1862              		.cfi_def_cfa	11,8
 1863 2830 18000000 		ld	%got,0x18(,%sp)
 1863      8B000F01 
 1864 2838 20000000 		ld	%plt,0x20(,%sp)
 1864      8B001001 
 1865 2840 08000000 		ld	%lr,0x8(,%sp)
 1865      8B000A01 
 1866 2848 00000000 		ld	%fp,0x0(,%sp)
 1866      8B000901 
 1867 2850 00000000 		b.l	(,%lr)
 1867      8A000F19 
 1868              	.L6.2:
 1869              	# line 104
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1870              		.loc	1 104 0
 1871 2858 00000000 		ldl.sx	%s18,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1871      81001203 
 1872 2860 00000000 		adds.w.sx	%s5,1,%s5
 1872      8501054A 
 1873 2868 F8040000 		brlt.w	%s5,%s18,.L6.3
 1873      92858218 
 1874 2870 48FFFFFF 		br.l	.L6.1
 1874      00000F18 
 1875              	.L6.4:
 1876              	# line 105
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 1877              		.loc	1 105 0
 1878 2878 04000000 		ldl.sx	%s18,4(,%s1)	# *(p).__b_N4conv6desc_tE.mb
 1878      81001203 
 1879 2880 00000000 		adds.w.sx	%s6,1,%s6
 1879      8601064A 
 1880 2888 98040000 		brlt.w	%s6,%s18,.L6.5
 1880      92868218 
 1881 2890 C8FFFFFF 		br.l	.L6.2
 1881      00000F18 
 1882              	.L6.6:
 1883              	# line 106
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 1884              		.loc	1 106 0
 1885 2898 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1885      81003F03 
 1886 28a0 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1886      81003E03 
 1887 28a8 00000000 		divs.w.sx	%s62,%s63,%s62
 1887      BEBF3E7B 
 1888 28b0 00000000 		adds.w.sx	%s7,1,%s7
 1888      8701074A 
 1889 28b8 38040000 		brlt.w	%s7,%s62,.L6.7
 1889      BE878218 
 1890 28c0 B8FFFFFF 		br.l	.L6.4
 1890      00000F18 
 1891              	.L6.8:
 1892 28c8 00000000 		or	%s61,0,%s63
 1892      BF003D45 
 1893 28d0 C8FFFFFF 		br.l	.L6.6
 1893      00000F18 
 1894              	.L6.9:
 1895              	# line 107
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1896              		.loc	1 107 0
 1897 28d8 18000000 		ldl.sx	%s18,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 1897      81001203 
 1898 28e0 00000000 		adds.w.sx	%s27,1,%s27
 1898      9B011B4A 
 1899 28e8 D0030000 		brlt.w	%s27,%s18,.L6.10
 1899      929B8218 
 1900 28f0 D8FFFFFF 		br.l	.L6.8
 1900      00000F18 
 1901              	.L6.11:
 1902 28f8 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 1902      89000101 
 1903 2900 D8FFFFFF 		ld	%s63,-40(,%fp)	# restore 
 1903      89003F01 
 1904 2908 C0FFFFFF 		ld	%s4,-64(,%fp)	# restore 
 1904      89000401 
 1905 2910 B0FFFFFF 		ld	%s7,-80(,%fp)	# restore 
 1905      89000701 
 1906 2918 B8FFFFFF 		ld	%s6,-72(,%fp)	# restore 
 1906      89000601 
 1907 2920 E0FFFFFF 		ld	%s5,-32(,%fp)	# restore 
 1907      89000501 
 1908 2928 C8FFFFFF 		ld	%s3,-56(,%fp)	# restore 
 1908      89000301 
 1909 2930 D0FFFFFF 		ld	%s2,-48(,%fp)	# restore 
 1909      89000201 
 1910 2938 A0FFFFFF 		br.l	.L6.9
 1910      00000F18 
 1911              	.L6.12:
 1912 2940 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 1912      89000101 
 1913 2948 E0FFFFFF 		ld	%s5,-32(,%fp)	# restore 
 1913      89000501 
 1914 2950 D8FFFFFF 		ld	%s0,-40(,%fp)	# restore 
 1914      89000001 
 1915 2958 D0FFFFFF 		ld	%s2,-48(,%fp)	# restore 
 1915      89000201 
 1916 2960 C8FFFFFF 		ld	%s3,-56(,%fp)	# restore 
 1916      89000301 
 1917 2968 C0FFFFFF 		ld	%s4,-64(,%fp)	# restore 
 1917      89000401 
 1918 2970 B8FFFFFF 		ld	%s6,-72(,%fp)	# restore 
 1918      89000601 
 1919 2978 B0FFFFFF 		ld	%s7,-80(,%fp)	# restore 
 1919      89000701 
 1920 2980 C8010000 		br.l	.L6.13
 1920      00000F18 
 1921              	.L6.14:
 1922 2988 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 1922      89000101 
 1923 2990 00000000 		or	%s0,0,%s29
 1923      9D000045 
 1924 2998 C0FFFFFF 		ld	%s2,-64(,%fp)	# restore 
 1924      89000201 
 1925              	# line 122
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float &dst = pdst[dst_off];
 1926              		.loc	1 122 0
 1927 29a0 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1927      81003F03 
 1928 29a8 E0FFFFFF 		ld	%s5,-32(,%fp)	# restore 
 1928      89000501 
 1929 29b0 00000000 		muls.w.sx	%s63,%s63,%s5
 1929      85BF3F4B 
 1930 29b8 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1930      81003E03 
 1931 29c0 00000000 		divs.w.sx	%s62,%s63,%s62
 1931      BEBF3E7B 
 1932 29c8 B0FFFFFF 		ld	%s7,-80(,%fp)	# restore 
 1932      89000701 
 1933 29d0 00000000 		adds.w.sx	%s3,%s62,%s7
 1933      87BE034A 
 1934 29d8 00000000 		lea	%s12,conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, int)#1}::operator()(conv::prb_t const*, float&, int) const@LO
 1934      00000C06 
 1935 29e0 00000000 		and	%s12,%s12,(32)0
 1935      608C0C44 
 1936 29e8 00000000 		lea.sl	%s12,conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, int)#1}::operator()(conv::prb_t const*, float&, int) const@HI(,%
 1936      8C008C06 
 1937 29f0 00000000 		bsic	%lr,(,%s12)	# conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, int)#1}::operator()(conv::prb_t const*, float&) const
 1937      8C000A08 
 1938              	# line 123
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             maybe_post_ops(p, conv_res, dst);
 1939              		.loc	1 123 0
 1940 29f8 00000000 		mulu.l	%s28,4,%s28
 1940      9C041C49 
 1941 2a00 C0FFFFFF 		ld	%s2,-64(,%fp)	# restore 
 1941      89000201 
 1942 2a08 00000000 		or	%s0,0,%s31
 1942      9F000045 
 1943 2a10 00000000 		adds.l	%s63,%s28,%s30
 1943      9E9C3F59 
 1944 2a18 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 1944      89000101 
 1945              	# line 124
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1946              		.loc	1 124 0
 1947 2a20 00000000 		ldu	%s3,0(,%s63)	# *(dst)
 1947      BF000302 
 1948 2a28 00000000 		lea	%s12,conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, float)#1}::operator()(conv::prb_t const*, float&, float) const@LO
 1948      00000C06 
 1949 2a30 00000000 		and	%s12,%s12,(32)0
 1949      608C0C44 
 1950 2a38 00000000 		lea.sl	%s12,conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, float)#1}::operator()(conv::prb_t const*, float&, float) const@HI(,%
 1950      8C008C06 
 1951 2a40 00000000 		bsic	%lr,(,%s12)	# conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float&, float)#1}::operator()(conv::prb_t const*, float&) const
 1951      8C000A08 
 1952              	# line 126
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 1953              		.loc	1 126 0
 1954 2a48 F0FFFFFF 		ldu	%s63,-16(,%fp)	# conv_res
 1954      89003F02 
 1955 2a50 00000000 		stu	%s63,0(%s28,%s30)	# *(pdst)
 1955      9E9C3F12 
 1956              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1957              		.loc	1 108 0
 1958 2a58 00000000 		adds.w.sx	%s32,1,%s32
 1958      A001204A 
 1959 2a60 00000000 		adds.w.sx	%s23,1,%s23
 1959      9701174A 
 1960 2a68 D8FEFFFF 		brgt.w	0,%s32,.L6.12
 1960      A0008118 
 1961 2a70 88FEFFFF 		br.l	.L6.11
 1961      00000F18 
 1962              	.L6.15:
 1963              	# line 120
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 1964              		.loc	1 120 0
 1965 2a78 00000000 		or	%s63,0,(0)1
 1965      00003F45 
 1966 2a80 F0FFFFFF 		stu	%s63,-16(,%fp)	# conv_res
 1966      89003F12 
 1967 2a88 00FFFFFF 		br.l	.L6.14
 1967      00000F18 
 1968              	.L6.16:
 1969              	# line 119
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               conv_res = 0;
 1970              		.loc	1 119 0
 1971 2a90 F0FFFFFF 		ldu	%s18,-16(,%fp)	# conv_res
 1971      89001202 
 1972 2a98 00000000 		or	%s19,0,(0)1
 1972      00001345 
 1973 2aa0 D8FFFFFF 		brgt.s	%s19,%s18,.L6.15
 1973      9293C118 
 1974 2aa8 E0FEFFFF 		br.l	.L6.14
 1974      00000F18 
 1975              	.L6.17:
 1976 2ab0 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 1976      89000101 
 1977 2ab8 5C000000 		ldl.zx	%s63,92(,%s1)	# *(p).merge
 1977      8100BF03 
 1978 2ac0 00000000 		adds.w.sx	%s63,0,%s63
 1978      BF003F4A 
 1979 2ac8 C8FFFFFF 		breq.w	1,%s63,.L6.16
 1979      BF018418 
 1980 2ad0 B8FEFFFF 		br.l	.L6.14
 1980      00000F18 
 1981              	.L6.18:
 1982 2ad8 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 1982      89000101 
 1983              	# line 115
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               conv_res += pbia[bia_off];
 1984              		.loc	1 115 0
 1985 2ae0 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 1985      81003F03 
 1986 2ae8 00000000 		or	%s63,0,%s63
 1986      BF003F45 
 1987 2af0 00000000 		mulu.l	%s63,%s63,%s33
 1987      A1BF3F49 
 1988 2af8 00000000 		ldl.sx	%s1,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 1988      81000103 
 1989 2b00 00000000 		or	%s1,0,%s1
 1989      81000145 
 1990 2b08 00000000 		divu.l	%s1,%s63,%s1
 1990      81BF016F 
 1991 2b10 00000000 		addu.l	%s1,%s25,%s1
 1991      81990148 
 1992              	# line 116
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             }
 1993              		.loc	1 116 0
 1994 2b18 F0FFFFFF 		ldu	%s63,-16(,%fp)	# conv_res
 1994      89003F02 
 1995 2b20 00000000 		mulu.l	%s1,4,%s1
 1995      81040149 
 1996 2b28 00000000 		ldu	%s1,0(%s1,%s22)	# *(pbia)
 1996      96810102 
 1997 2b30 00000000 		fadd.s	%s1,%s63,%s1
 1997      81BF814C 
 1998 2b38 F0FFFFFF 		stu	%s1,-16(,%fp)	# conv_res
 1998      89000112 
 1999 2b40 70FFFFFF 		br.l	.L6.17
 1999      00000F18 
 2000              	.L6.13:
 2001 2b48 00000000 		or	%s63,0,%s23
 2001      97003F45 
 2002 2b50 E8FFFFFF 		st	%s1,-24(,%fp)	# spill 
 2002      89000111 
 2003 2b58 E0FFFFFF 		st	%s5,-32(,%fp)	# spill 
 2003      89000511 
 2004 2b60 D8FFFFFF 		st	%s0,-40(,%fp)	# spill 
 2004      89000011 
 2005 2b68 D0FFFFFF 		st	%s2,-48(,%fp)	# spill 
 2005      89000211 
 2006 2b70 C8FFFFFF 		st	%s3,-56(,%fp)	# spill 
 2006      89000311 
 2007 2b78 C0FFFFFF 		st	%s4,-64(,%fp)	# spill 
 2007      89000411 
 2008 2b80 B8FFFFFF 		st	%s6,-72(,%fp)	# spill 
 2008      89000611 
 2009 2b88 B0FFFFFF 		st	%s7,-80(,%fp)	# spill 
 2009      89000711 
 2010              	# line 109
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 2011              		.loc	1 109 0
 2012 2b90 14000000 		ldl.sx	%s62,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 2012      81003E03 
 2013 2b98 00000000 		or	%s61,0,%s62
 2013      BE003D45 
 2014 2ba0 00000000 		mulu.l	%s61,%s61,%s24
 2014      98BD3D49 
 2015 2ba8 00000000 		muls.w.sx	%s62,%s62,%s5
 2015      85BE3E4B 
 2016 2bb0 00000000 		ldl.sx	%s60,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 2016      81003C03 
 2017 2bb8 00000000 		divs.w.sx	%s60,%s62,%s60
 2017      BCBE3C7B 
 2018 2bc0 00000000 		or	%s60,0,%s60
 2018      BC003C45 
 2019 2bc8 00000000 		addu.l	%s60,%s61,%s60
 2019      BCBD3C48 
 2020 2bd0 00000000 		addu.l	%s60,%s60,%s25
 2020      99BC3C48 
 2021 2bd8 18000000 		ldl.sx	%s62,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 2021      81003E03 
 2022 2be0 00000000 		or	%s62,0,%s62
 2022      BE003E45 
 2023 2be8 00000000 		mulu.l	%s62,%s60,%s62
 2023      BEBC3E49 
 2024 2bf0 00000000 		addu.l	%s62,%s62,%s26
 2024      9ABE3E48 
 2025 2bf8 1C000000 		ldl.sx	%s61,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 2025      81003D03 
 2026 2c00 00000000 		or	%s61,0,%s61
 2026      BD003D45 
 2027 2c08 00000000 		mulu.l	%s61,%s62,%s61
 2027      BDBE3D49 
 2028 2c10 00000000 		addu.l	%s28,%s61,%s63
 2028      BFBD1C48 
 2029              	# line 111
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             ker(p, psrc, pwei, conv_res, g, mb, oc, oh, ow);
 2030              		.loc	1 111 0
 2031 2c18 00000000 		or	%s63,0,(0)1
 2031      00003F45 
 2032 2c20 F0FFFFFF 		stu	%s63,-16(,%fp)	# conv_res
 2032      89003F12 
 2033              	# line 112
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 2034              		.loc	1 112 0
 2035 2c28 F0000000 		st	%s27,240(,%sp)
 2035      8B001B11 
 2036 2c30 F8000000 		st	%s23,248(,%sp)
 2036      8B001711 
 2037 2c38 00000000 		lea	%s12,conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float const*, float const*, float&, int, int, int, int, int)#1}::operator()(conv::prb_t const*, float const*) const
 2037      00000C06 
 2038 2c40 00000000 		and	%s12,%s12,(32)0
 2038      608C0C44 
 2039 2c48 00000000 		lea.sl	%s12,conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, float const*, float const*, float&, int, int, int, int, int)#1}::operator()(conv::prb_t const*) const
 2039      8C008C06 
 2040 2c50 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv13refconv_2_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_RfiiiiiE
 2040      8C000A08 
 2041 2c58 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 2041      89000101 
 2042              	# line 114
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****               const size_t bia_off = bia_off_f(p, g, oc);
 2043              		.loc	1 114 0
 2044 2c60 48000000 		ldl.zx	%s1,72(,%s1)	# *(p).dir
 2044      81008103 
 2045 2c68 00000000 		adds.w.sx	%s1,0,%s1
 2045      8100014A 
 2046 2c70 04000000 		lea	%s63,4
 2046      00003F06 
 2047 2c78 00000000 		and	%s63,%s1,%s63
 2047      BF813F44 
 2048 2c80 58FEFFFF 		brne.w	0,%s63,.L6.18
 2048      BF008318 
 2049 2c88 28FEFFFF 		br.l	.L6.17
 2049      00000F18 
 2050              	.L6.19:
 2051 2c90 00000000 		or	%s26,0,%s27
 2051      9B001A45 
 2052              	# line 108
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2053              		.loc	1 108 0
 2054 2c98 00000000 		subs.w.sx	%s18,0,%s18
 2054      9200125A 
 2055 2ca0 00000000 		or	%s32,0,%s18
 2055      92002045 
 2056 2ca8 00000000 		or	%s0,0,%s63
 2056      BF000045 
 2057 2cb0 98FEFFFF 		br.l	.L6.13
 2057      00000F18 
 2058              	.L6.10:
 2059 2cb8 00000000 		or	%s23,0,(0)1
 2059      00001745 
 2060 2cc0 1C000000 		ldl.sx	%s18,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 2060      81001203 
 2061 2cc8 C8FFFFFF 		brlt.w	0,%s18,.L6.19
 2061      92008218 
 2062 2cd0 08FCFFFF 		br.l	.L6.9
 2062      00000F18 
 2063              	.L6.20:
 2064 2cd8 00000000 		or	%s25,0,%s7
 2064      87001945 
 2065 2ce0 00000000 		or	%s63,0,%s61
 2065      BD003F45 
 2066 2ce8 D0FFFFFF 		br.l	.L6.10
 2066      00000F18 
 2067              	.L6.7:
 2068              	# line 107
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 2069              		.loc	1 107 0
 2070 2cf0 00000000 		or	%s27,0,(0)1
 2070      00001B45 
 2071 2cf8 18000000 		ldl.sx	%s18,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 2071      81001203 
 2072 2d00 D8FFFFFF 		brlt.w	0,%s18,.L6.20
 2072      92008218 
 2073 2d08 90FBFFFF 		br.l	.L6.6
 2073      00000F18 
 2074              	.L6.21:
 2075 2d10 00000000 		or	%s24,0,%s6
 2075      86001845 
 2076 2d18 D8FFFFFF 		br.l	.L6.7
 2076      00000F18 
 2077              	.L6.5:
 2078              	# line 106
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 2079              		.loc	1 106 0
 2080 2d20 00000000 		or	%s7,0,(0)1
 2080      00000745 
 2081 2d28 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 2081      81003F03 
 2082 2d30 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 2082      81003E03 
 2083 2d38 00000000 		divs.w.sx	%s62,%s63,%s62
 2083      BEBF3E7B 
 2084 2d40 D0FFFFFF 		brlt.w	0,%s62,.L6.21
 2084      BE008218 
 2085 2d48 30FBFFFF 		br.l	.L6.4
 2085      00000F18 
 2086              	.L6.22:
 2087 2d50 00000000 		or	%s33,0,%s5
 2087      85002145 
 2088 2d58 C8FFFFFF 		br.l	.L6.5
 2088      00000F18 
 2089              	.L6.3:
 2090              	# line 105
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 2091              		.loc	1 105 0
 2092 2d60 00000000 		or	%s6,0,(0)1
 2092      00000645 
 2093 2d68 04000000 		ldl.sx	%s18,4(,%s1)	# *(p).__b_N4conv6desc_tE.mb
 2093      81001203 
 2094 2d70 E0FFFFFF 		brlt.w	0,%s18,.L6.22
 2094      92008218 
 2095 2d78 E0FAFFFF 		br.l	.L6.2
 2095      00000F18 
 2096              	.L6.0:
 2097              	# line 112
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 2098              		.loc	1 112 0
 2099 2d80 00000000 		adds.l	%s4,%fp,(60)1
 2099      3C890459 
 2100 2d88 F4FFFFFF 		lea	%s60,-12
 2100      00003C06 
 2101 2d90 00000000 		adds.l	%s61,%fp,%s60
 2101      BC893D59 
 2102              	# line 124
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 2103              		.loc	1 124 0
 2104 2d98 F6FFFFFF 		lea	%s60,-10
 2104      00003C06 
 2105 2da0 00000000 		adds.l	%s31,%fp,%s60
 2105      BC891F59 
 2106              	# line 122
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float &dst = pdst[dst_off];
 2107              		.loc	1 122 0
 2108 2da8 F5FFFFFF 		lea	%s60,-11
 2108      00003C06 
 2109 2db0 00000000 		adds.l	%s29,%fp,%s60
 2109      BC891D59 
 2110 2db8 00000000 		or	%s1,0,%s0
 2110      80000145 
 2111 2dc0 00000000 		or	%s3,0,%s62
 2111      BE000345 
 2112 2dc8 00000000 		or	%s2,0,%s63
 2112      BF000245 
 2113 2dd0 90FFFFFF 		br.l	.L6.3
 2113      00000F18 
 2114              		.cfi_endproc
 2115              		.set	.L.7.2auto_size,	0xfffffffffffffd70	# 656 Bytes
 2117              	# ============ End  conv::refconv_2_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2118              	# ============ Begin  _INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*) ==
 2119 2dd8 00000000 		.balign 16
 2119      00000000 
 2120              	# line 138
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   assert(K <= precompute_size);
 2121              		.loc	1 138 0
 2123              	_INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*):
 2124              		.cfi_startproc
 2125 2de0 00000000 		st	%fp,0x0(,%sp)
 2125      8B000911 
 2126              		.cfi_def_cfa_offset	0
 2127              		.cfi_offset	9,0
 2128 2de8 08000000 		st	%lr,0x8(,%sp)
 2128      8B000A11 
 2129 2df0 18000000 		st	%got,0x18(,%sp)
 2129      8B000F11 
 2130 2df8 20000000 		st	%plt,0x20(,%sp)
 2130      8B001011 
 2131 2e00 00000000 		or	%fp,0,%sp
 2131      8B000945 
 2132              		.cfi_def_cfa_register	9
 2133 2e08 30000000 		st	%s18,48(,%fp)
 2133      89001211 
 2134 2e10 30CAF3FF 		lea	%s13,.L.8.2auto_size&0xffffffff
 2134      00000D06 
 2135 2e18 00000000 		and	%s13,%s13,(32)0
 2135      608D0D44 
 2136 2e20 FFFFFFFF 		lea.sl	%sp,.L.8.2auto_size>>32(%fp,%s13)
 2136      8D898B06 
 2137 2e28 48000000 		brge.l.t	%sp,%sl,.L7.EoP
 2137      888B3518 
 2138 2e30 18000000 		ld	%s61,0x18(,%tp)
 2138      8E003D01 
 2139 2e38 00000000 		or	%s62,0,%s0
 2139      80003E45 
 2140 2e40 3B010000 		lea	%s63,0x13b
 2140      00003F06 
 2141 2e48 00000000 		shm.l	%s63,0x0(%s61)
 2141      BD033F31 
 2142 2e50 08000000 		shm.l	%sl,0x8(%s61)
 2142      BD030831 
 2143 2e58 10000000 		shm.l	%sp,0x10(%s61)
 2143      BD030B31 
 2144 2e60 00000000 		monc
 2144      0000003F 
 2145 2e68 00000000 		or	%s0,0,%s62
 2145      BE000045 
 2146              	.L7.EoP:
 2147              	# End of prologue codes
 2148 2e70 00000000 		lea	%s63,0
 2148      00003F06 
 2149              	# line 140
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #pragma _NEC loop_count(precompute_size)
 2150              		.loc	1 140 0
 2151 2e78 00000000 		stl	%s63,0(,%s6)	# *(num)
 2151      86003F13 
 2152              	# line 142
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0 // original
 2153              		.loc	1 142 0
 2154 2e80 00000000 		or	%s53,0,(0)1
 2154      00003545 
 2155 2e88 28030000 		brlt.w	0,%s2,.L7.0
 2155      82008218 
 2156 2e90 08000000 		br.l	.L7.1
 2156      00000F18 
 2157              	.L7.1:
 2158              	# line 162
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 1 // see what gcc vectorizes (and what it does NOT!!!)
 2159              		.loc	1 162 0
 2160              	# Start of epilogue codes
 2161 2e98 30000000 		ld	%s18,48(,%fp)
 2161      89001201 
 2162 2ea0 00000000 		or	%sp,0,%fp
 2162      89000B45 
 2163              		.cfi_def_cfa	11,8
 2164 2ea8 18000000 		ld	%got,0x18(,%sp)
 2164      8B000F01 
 2165 2eb0 20000000 		ld	%plt,0x20(,%sp)
 2165      8B001001 
 2166 2eb8 08000000 		ld	%lr,0x8(,%sp)
 2166      8B000A01 
 2167 2ec0 00000000 		ld	%fp,0x0(,%sp)
 2167      8B000901 
 2168 2ec8 00000000 		b.l	(,%lr)
 2168      8A000F19 
 2169              	.L7.2:
 2170 2ed0 C8FFFFFF 		br.l	.L7.1
 2170      00000F18 
 2171              	.L7.3:
 2172 2ed8 00000000 		or	%s52,0,%s59
 2172      BB003445 
 2173 2ee0 A8020000 		br.l	.L7.4
 2173      00000F18 
 2174              	.L7.5:
 2175              	# line 142
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0 // original
 2176              		.loc	1 142 0
 2177 2ee8 99860100 		lea	%s62,99993
 2177      00003E06 
 2178 2ef0 00000000 		adds.w.sx	%s59,%s59,%s62
 2178      BEBB3B4A 
 2179 2ef8 6779FEFF 		lea	%s62,-99993
 2179      00003E06 
 2180 2f00 00000000 		adds.w.sx	%s63,%s63,%s62
 2180      BEBF3F4A 
 2181 2f08 6779FEFF 		lea	%s62,-99993
 2181      00003E06 
 2182 2f10 00000000 		adds.w.sx	%s61,%s61,%s62
 2182      BEBD3D4A 
 2183 2f18 6779FEFF 		lea	%s62,-99993
 2183      00003E06 
 2184 2f20 00000000 		adds.w.sx	%s56,%s56,%s62
 2184      BEB8384A 
 2185 2f28 00000000 		adds.w.sx	%s55,%s55,%s54
 2185      B6B7374A 
 2186 2f30 99860100 		lea	%s62,99993
 2186      00003E06 
 2187 2f38 00000000 		adds.w.sx	%s53,%s53,%s62
 2187      BEB5354A 
 2188 2f40 98FFFFFF 		brgt.w	0,%s59,.L7.3
 2188      BB008118 
 2189 2f48 88FFFFFF 		br.l	.L7.2
 2189      00000F18 
 2190              	.L7.6:
 2191 2f50 00000000 		or	%s59,0,%s52
 2191      B4003B45 
 2192 2f58 00000000 		or	%s63,0,%s3
 2192      83003F45 
 2193 2f60 00000000 		or	%s61,0,%s2
 2193      82003D45 
 2194 2f68 00000000 		or	%s56,0,%s1
 2194      81003845 
 2195 2f70 78FFFFFF 		br.l	.L7.5
 2195      00000F18 
 2196              	.L7.7:
 2197 2f78 00000000 		adds.w.sx	%s62,1,%s62
 2197      BE013E4A 
 2198 2f80 00000000 		adds.l	%s63,4,%s63
 2198      BF043F59 
 2199 2f88 00000000 		adds.w.sx	%s61,1,%s61
 2199      BD013D4A 
 2200 2f90 78000000 		brgt.w	0,%s62,.L7.8
 2200      BE008118 
 2201 2f98 B8FFFFFF 		br.l	.L7.6
 2201      00000F18 
 2202              	.L7.9:
 2203              	# line 157
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _o[num] = o;
 2204              		.loc	1 157 0
 2205 2fa0 00000000 		ldl.sx	%s59,0(,%s60)	# *(num)
 2205      BC003B03 
 2206 2fa8 00000000 		or	%s59,0,%s59
 2206      BB003B45 
 2207 2fb0 00000000 		muls.l	%s59,4,%s59
 2207      BB043B6E 
 2208 2fb8 00000000 		stl	%s61,0(%s59,%s58)	# *(_k)
 2208      BABB3D13 
 2209              	# line 158
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     ++num;         // nobody seems to generate a vgather here.
 2210              		.loc	1 158 0
 2211 2fc0 00000000 		ldl.sx	%s59,0(,%s60)	# *(num)
 2211      BC003B03 
 2212 2fc8 00000000 		or	%s59,0,%s59
 2212      BB003B45 
 2213 2fd0 00000000 		muls.l	%s59,4,%s59
 2213      BB043B6E 
 2214 2fd8 98E5F9FF 		ldl.sx	%s56,-399976(,%s63)	# j$7
 2214      BF003803 
 2215 2fe0 00000000 		stl	%s56,0(%s59,%s57)	# *(_o)
 2215      B9BB3813 
 2216              	# line 159
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 2217              		.loc	1 159 0
 2218 2fe8 00000000 		ldl.sx	%s59,0(,%s60)	# *(num)
 2218      BC003B03 
 2219 2ff0 00000000 		adds.w.sx	%s59,1,%s59
 2219      BB013B4A 
 2220 2ff8 00000000 		stl	%s59,0(,%s60)	# *(num)
 2220      BC003B13 
 2221 3000 78FFFFFF 		br.l	.L7.7
 2221      00000F18 
 2222              	.L7.8:
 2223              	# line 156
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[num] = k;
 2224              		.loc	1 156 0
 2225 3008 30CBF3FF 		ldl.sx	%s18,-799952(,%s63)	# j$8
 2225      BF001203 
 2226 3010 90FFFFFF 		brne.w	0,%s18,.L7.9
 2226      92008318 
 2227 3018 60FFFFFF 		br.l	.L7.7
 2227      00000F18 
 2228              	.L7.10:
 2229              	# line 142
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0 // original
 2230              		.loc	1 142 0
 2231 3020 00000000 		subs.w.sx	%s59,0,%s59
 2231      BB003B5A 
 2232 3028 00000000 		or	%s1,0,%s56
 2232      B8000145 
 2233 3030 00000000 		or	%s62,0,%s59
 2233      BB003E45 
 2234 3038 00000000 		or	%s2,0,%s61
 2234      BD000245 
 2235 3040 00000000 		or	%s3,0,%s63
 2235      BF000345 
 2236 3048 00000000 		or	%s63,0,%fp
 2236      89003F45 
 2237 3050 00000000 		or	%s61,0,%s53
 2237      B5003D45 
 2238 3058 B0FFFFFF 		br.l	.L7.8
 2238      00000F18 
 2239              	.L7.11:
 2240 3060 C0FFFFFF 		brlt.w	0,%s59,.L7.10
 2240      BB008218 
 2241 3068 00000000 		or	%s59,0,%s52
 2241      B4003B45 
 2242 3070 78FEFFFF 		br.l	.L7.5
 2242      00000F18 
 2243              	.L7.12:
 2244 3078 00000000 		subs.w.sx	%s62,0,%s59
 2244      BB003E5A 
 2245 3080 00000000 		subs.w.sx	%s62,0,%s62
 2245      BE003E5A 
 2246 3088 00000000 		or	%s62,0,%s62
 2246      BE003E45 
 2247 3090 00000000 		lvl	%s62
 2247      00BE00BF 
 2248 3098 0000003B 		vseq	%v59
 2248      00000099 
 2249 30a0 003B003A 		vmuls.w.sx	%v58,%s51,%v59
 2249      00B320CB 
 2250 30a8 003B0039 		vmuls.w.sx	%v57,-1,%v59
 2250      007F20CB 
 2251              	# line 156
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[num] = k;
 2252              		.loc	1 156 0
 2253 30b0 00390038 		vadds.w.sx	%v56,%s56,%v57
 2253      00B820CA 
 2254 30b8 003A0037 		vadds.w.sx	%v55,%s55,%v58
 2254      00B720CA 
 2255 30c0 00373836 		vsubs.w.sx	%v54,%v56,%v55
 2255      000000DA 
 2256 30c8 00003635 		vdivs.w.sx	%v53,%v54,%s50
 2256      00B210EB 
 2257 30d0 98E5F9FF 		lea	%s48,-399976
 2257      00003006 
 2258 30d8 00000000 		adds.l	%s48,%fp,%s48
 2258      B0893059 
 2259 30e0 00000035 		vstl.nc	%v53,4,%s48
 2259      B0040093 
 2260 30e8 0036050F 		vfmk.w.ge	%vm15,%v54
 2260      000000B5 
 2261 30f0 0035003F 		vcmps.w.sx	%v63,%s49,%v53,%vm15
 2261      00B12FFA 
 2262 30f8 003F010E 		vfmk.w.gt	%vm14,%v63,%vm15
 2262      00000FB5 
 2263 3100 0035003E 		vmuls.w.sx	%v62,%s50,%v53,%vm14
 2263      00B22ECB 
 2264 3108 003E363D 		vcmps.w.sx	%v61,%v54,%v62,%vm14
 2264      00000EFA 
 2265 3110 003D040D 		vfmk.w.eq	%vm13,%v61,%vm14
 2265      00000EB5 
 2266 3118 0000003C 		vbrd	%v60,0,%vm13
 2266      00000D8C 
 2267 3120 000E0D0D 		nndm	%vm13,%vm13,%vm14
 2267      00000094 
 2268 3128 000F0E0E 		nndm	%vm14,%vm14,%vm15
 2268      00000094 
 2269 3130 00000F0F 		negm	%vm15,%vm15
 2269      00000095 
 2270 3138 000E0D0E 		orm	%vm14,%vm13,%vm14
 2270      00000085 
 2271 3140 000F0E0F 		orm	%vm15,%vm14,%vm15
 2271      00000085 
 2272 3148 0000003C 		vbrd	%v60,1,%vm15
 2272      00010F8C 
 2273 3150 003C040F 		vfmk.w.eq	%vm15,%v60
 2273      000000B5 
 2274 3158 00000034 		vbrd	%v52,1
 2274      0001008C 
 2275 3160 00340033 		vmrg	%v51,0,%v52,%vm15
 2275      00002FD6 
 2276 3168 30CBF3FF 		lea	%s48,-799952
 2276      00003006 
 2277 3170 00000000 		adds.l	%s48,%fp,%s48
 2277      B0893059 
 2278 3178 00000033 		vstl.nc	%v51,4,%s48
 2278      B0040093 
 2279 3180 E0FEFFFF 		br.l	.L7.11
 2279      00000F18 
 2280              	.L7.4:
 2281              	# line 142
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0 // original
 2282              		.loc	1 142 0
 2283 3188 00000000 		cmps.w.sx	%s62,%s63,(0)1
 2283      00BF3E7A 
 2284 3190 99860100 		lea	%s59,99993
 2284      00003B06 
 2285 3198 82000000 		cmov.w.lt	%s59,%s61,%s62
 2285      BDBE3B3B 
 2286 31a0 D8FEFFFF 		brlt.w	0,%s59,.L7.12
 2286      BB008218 
 2287 31a8 B8FEFFFF 		br.l	.L7.11
 2287      00000F18 
 2288              	.L7.0:
 2289              	# line 156
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[num] = k;
 2290              		.loc	1 156 0
 2291 31b0 00000000 		adds.w.sx	%s4,%s0,%s4
 2291      8480044A 
 2292 31b8 00000000 		or	%s60,0,%s6
 2292      86003C45 
 2293 31c0 00000000 		or	%s56,0,%s4
 2293      84003845 
 2294              	# line 157
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _o[num] = o;
 2295              		.loc	1 157 0
 2296 31c8 F0000000 		dld	%s58,240(,%fp)	# _k
 2296      89003A09 
 2297              	# line 142
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #if 0 // original
 2298              		.loc	1 142 0
 2299 31d0 00000000 		subs.w.sx	%s62,0,%s2
 2299      82003E5A 
 2300 31d8 00000000 		or	%s57,0,%s7
 2300      87003945 
 2301 31e0 00000000 		or	%s52,0,%s62
 2301      BE003445 
 2302 31e8 00000000 		or	%s61,0,%s2
 2302      82003D45 
 2303 31f0 6779FEFF 		lea	%s62,-99993
 2303      00003E06 
 2304 31f8 00000000 		adds.w.sx	%s62,%s2,%s62
 2304      BE823E4A 
 2305 3200 00000000 		or	%s49,0,%s1
 2305      81003145 
 2306 3208 00000000 		or	%s63,0,%s62
 2306      BE003F45 
 2307 3210 00000000 		or	%s55,0,(0)1
 2307      00003745 
 2308 3218 99860100 		lea	%s62,99993
 2308      00003E06 
 2309 3220 00000000 		muls.w.sx	%s54,%s5,%s62
 2309      BE85364B 
 2310 3228 00000000 		or	%s50,0,%s3
 2310      83003245 
 2311 3230 00000000 		or	%s51,0,%s5
 2311      85003345 
 2312 3238 50FFFFFF 		br.l	.L7.4
 2312      00000F18 
 2313              		.cfi_endproc
 2314              		.set	.L.8.2auto_size,	0xfffffffffff3ca30	# 800208 Bytes
 2316              	# ============ End  _INTERNAL_13_ref_conv2_cpp_36778705::conv::precompute_ok(int, int, int, int, int, int, int&, int*, int*) ====
 2317              	# ============ Begin  conv::precompute_ok2(int, int, int, int, int, int, int&, int*, int*) ============
 2318              		.section .rodata
 2319              		.balign 16
 2321              	.LP._ZN4conv14precompute_ok2EiiiiiiRiPiS1_.gather.__initializer.0:
 2322 0000 00000000 		.zero	16
 2322      00000000 
 2322      00000000 
 2322      00000000 
 2323              		.text
 2324              		.balign 16
 2325              	# line 167
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   assert(K <= precompute_size);
 2326              		.loc	1 167 0
 2327              		.globl	conv::precompute_ok2(int, int, int, int, int, int, int&, int*, int*)
 2329              	conv::precompute_ok2(int, int, int, int, int, int, int&, int*, int*):
 2330              		.cfi_startproc
 2331 3240 00000000 		st	%fp,0x0(,%sp)
 2331      8B000911 
 2332              		.cfi_def_cfa_offset	0
 2333              		.cfi_offset	9,0
 2334 3248 08000000 		st	%lr,0x8(,%sp)
 2334      8B000A11 
 2335 3250 18000000 		st	%got,0x18(,%sp)
 2335      8B000F11 
 2336 3258 20000000 		st	%plt,0x20(,%sp)
 2336      8B001011 
 2337 3260 00000000 		or	%fp,0,%sp
 2337      8B000945 
 2338              		.cfi_def_cfa_register	9
 2339 3268 30000000 		st	%s18,48(,%fp)
 2339      89001211 
 2340 3270 58000000 		st	%s23,88(,%fp)
 2340      89001711 
 2341 3278 60000000 		st	%s24,96(,%fp)
 2341      89001811 
 2342 3280 305DFFFF 		lea	%s13,.L.9.2auto_size&0xffffffff
 2342      00000D06 
 2343 3288 00000000 		and	%s13,%s13,(32)0
 2343      608D0D44 
 2344 3290 FFFFFFFF 		lea.sl	%sp,.L.9.2auto_size>>32(%fp,%s13)
 2344      8D898B06 
 2345 3298 48000000 		brge.l.t	%sp,%sl,.L8.EoP
 2345      888B3518 
 2346 32a0 18000000 		ld	%s61,0x18(,%tp)
 2346      8E003D01 
 2347 32a8 00000000 		or	%s62,0,%s0
 2347      80003E45 
 2348 32b0 3B010000 		lea	%s63,0x13b
 2348      00003F06 
 2349 32b8 00000000 		shm.l	%s63,0x0(%s61)
 2349      BD033F31 
 2350 32c0 08000000 		shm.l	%sl,0x8(%s61)
 2350      BD030831 
 2351 32c8 10000000 		shm.l	%sp,0x10(%s61)
 2351      BD030B31 
 2352 32d0 00000000 		monc
 2352      0000003F 
 2353 32d8 00000000 		or	%s0,0,%s62
 2353      BE000045 
 2354              	.L8.EoP:
 2355              	# End of prologue codes
 2356              	# line 225
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //ooi[k] = (int)oo[k];
 2357              		.loc	1 225 0
 2358 32e0 00000000 		adds.w.sx	%s23,%s0,%s4
 2358      8480174A 
 2359              	# line 174
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //alignas(16) int gattmp[precompute_size] = {0};
 2360              		.loc	1 174 0
 2361 32e8 30FFFFFF 		lea	%s61,-208
 2361      00003D06 
 2362 32f0 00000000 		adds.l	%s61,%fp,%s61
 2362      BD893D59 
 2363 32f8 00000000 		lea	%s57,.LP._ZN4conv14precompute_ok2EiiiiiiRiPiS1_.gather.__initializer.0@LO
 2363      00003906 
 2364 3300 00000000 		and	%s57,%s57,(32)0
 2364      60B93944 
 2365 3308 00000000 		lea.sl	%s57,.LP._ZN4conv14precompute_ok2EiiiiiiRiPiS1_.gather.__initializer.0@HI(,%s57)
 2365      B900B906 
 2366 3310 00000000 		ld	%s56,0(,%s57)	# conflict.I64
 2366      B9003801 
 2367 3318 00000000 		st	%s56,0(,%s61)	# conflict.I64
 2367      BD003811 
 2368 3320 00000000 		adds.l	%s57,8,%s57
 2368      B9083959 
 2369 3328 00000000 		ld	%s57,0(,%s57)	# conflict.I64
 2369      B9003901 
 2370 3330 00000000 		adds.l	%s61,8,%s61
 2370      BD083D59 
 2371 3338 00000000 		st	%s57,0(,%s61)	# conflict.I64
 2371      BD003911 
 2372              	# line 223
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     kk[k] = k;
 2373              		.loc	1 223 0
 2374 3340 00000000 		or	%s24,0,(0)1
 2374      00001845 
 2375 3348 00000000 		adds.l	%s60,16,%fp
 2375      89103C59 
 2376 3350 40000000 		lea	%s0,64
 2376      00000006 
 2377 3358 00000000 		lea	%s12,__grow_stack@LO
 2377      00000C06 
 2378 3360 00000000 		and	%s12,%s12,(32)0
 2378      608C0C44 
 2379 3368 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2379      8C008C06 
 2380 3370 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2380      8C000A08 
 2381 3378 B8000000 		lea	%s61,184
 2381      00003D06 
 2382 3380 00000000 		adds.l	%s61,%sp,%s61
 2382      BD8B3D59 
 2383 3388 00000000 		smvl	%s13
 2383      00000D2E 
 2384 3390 00000000 		lvl	%s13
 2384      008D00BF 
 2385 3398 00000000 		or	%s63,0,%s61
 2385      BD003F45 
 2386 33a0 00000000 		or	%s57,16,(0)1
 2386      00103945 
 2387 33a8 10000000 		lea	%s56,16
 2387      00003806 
 2388 33b0 00000000 		adds.w.sx	%s56,0,%s56
 2388      B800384A 
 2389 33b8 00000000 		lvl	%s56
 2389      00B800BF 
 2390 33c0 00000039 		vseq	%v57
 2390      00000099 
 2391 33c8 00390038 		vor	%v56,(0)1,%v57
 2391      000020C5 
 2392 33d0 00390037 		vmuls.w.sx	%v55,%s5,%v57
 2392      008520CB 
 2393 33d8 00390036 		vmuls.w.sx	%v54,-1,%v57
 2393      007F20CB 
 2394              	# line 225
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //ooi[k] = (int)oo[k];
 2395              		.loc	1 225 0
 2396 33e0 00000000 		lvl	%s57
 2396      00B900BF 
 2397 33e8 00360035 		vadds.w.sx	%v53,%s23,%v54
 2397      009720CA 
 2398 33f0 00370034 		vadds.w.sx	%v52,0,%v55
 2398      000020CA 
 2399 33f8 00343533 		vsubs.w.sx	%v51,%v53,%v52
 2399      000000DA 
 2400              	# line 224
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     ooi[k] = (P + i) - k * (D+1);
 2401              		.loc	1 224 0
 2402 3400 00380032 		vadds.w.sx	%v50,0,%v56
 2402      000020CA 
 2403 3408 00000000 		adds.l	%s56,%fp,(58)1
 2403      3A893859 
 2404 3410 00000032 		vstl.nc	%v50,4,%s56
 2404      B8040093 
 2405              	# line 225
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     //ooi[k] = (int)oo[k];
 2406              		.loc	1 225 0
 2407 3418 00000000 		adds.l	%s56,%fp,(57)1
 2407      39893859 
 2408 3420 00000033 		vstl.nc	%v51,4,%s56
 2408      B8040093 
 2409              	# line 229
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     gather[k] = (ooi[k] >= 0 && ooi[k] < O && ooS[k] == ooi[k]);
 2410              		.loc	1 229 0
 2411 3428 00330031 		vmuls.w.sx	%v49,%s3,%v51
 2411      008320CB 
 2412              	# line 230
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2413              		.loc	1 230 0
 2414 3430 0033050F 		vfmk.w.ge	%vm15,%v51
 2414      000000B5 
 2415 3438 0033003D 		vcmps.w.sx	%v61,%s1,%v51,%vm15
 2415      00812FFA 
 2416 3440 00000000 		or	%s1,0,%s24
 2416      98000145 
 2417 3448 003D010E 		vfmk.w.gt	%vm14,%v61,%vm15
 2417      00000FB5 
 2418 3450 0033313C 		vcmps.w.sx	%v60,%v49,%v51,%vm14
 2418      00000EFA 
 2419 3458 003C030D 		vfmk.w.ne	%vm13,%v60,%vm14
 2419      00000EB5 
 2420 3460 000F0E0C 		nndm	%vm12,%vm14,%vm15
 2420      00000094 
 2421 3468 00000F0F 		negm	%vm15,%vm15
 2421      00000095 
 2422 3470 000C0D0C 		orm	%vm12,%vm13,%vm12
 2422      00000085 
 2423 3478 000F0C0F 		orm	%vm15,%vm12,%vm15
 2423      00000085 
 2424 3480 0000003B 		vbrd	%v59,0,%vm15
 2424      00000F8C 
 2425 3488 00000000 		or	%s56,0,%s61
 2425      BD003845 
 2426 3490 0000003B 		vstl.nc	%v59,4,%s56,%vm15
 2426      B8040F93 
 2427 3498 000E0D0E 		nndm	%vm14,%vm13,%vm14
 2427      00000094 
 2428 34a0 0000003A 		vbrd	%v58,1,%vm14
 2428      00010E8C 
 2429 34a8 00000000 		or	%s61,0,%s61
 2429      BD003D45 
 2430 34b0 0000003A 		vstl.nc	%v58,4,%s61,%vm14
 2430      BD040E93 
 2431 34b8 00000000 		or	%s58,16,(0)1
 2431      00103A45 
 2432 34c0 00000000 		or	%s59,-16,(0)1
 2432      00703B45 
 2433 34c8 00000000 		or	%s62,0,(0)1
 2433      00003E45 
 2434 34d0 88050000 		br.l	.L8.0
 2434      00000F18 
 2435              	.L8.1:
 2436              	# line 263
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 2437              		.loc	1 263 0
 2438 34d8 00000000 		stl	%s58,0(,%s6)	# *(num)
 2438      86003A13 
 2439              	# line 276
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** #endif
 2440              		.loc	1 276 0
 2441              	# Start of epilogue codes
 2442 34e0 30000000 		ld	%s18,48(,%fp)
 2442      89001201 
 2443 34e8 58000000 		ld	%s23,88(,%fp)
 2443      89001701 
 2444 34f0 60000000 		ld	%s24,96(,%fp)
 2444      89001801 
 2445 34f8 00000000 		or	%sp,0,%fp
 2445      89000B45 
 2446              		.cfi_def_cfa	11,8
 2447 3500 18000000 		ld	%got,0x18(,%sp)
 2447      8B000F01 
 2448 3508 20000000 		ld	%plt,0x20(,%sp)
 2448      8B001001 
 2449 3510 08000000 		ld	%lr,0x8(,%sp)
 2449      8B000A01 
 2450 3518 00000000 		ld	%fp,0x0(,%sp)
 2450      8B000901 
 2451 3520 00000000 		b.l	(,%lr)
 2451      8A000F19 
 2452              	.L8.2:
 2453 3528 00000000 		or	%s1,0,%s1
 2453      81000145 
 2454 3530 00000000 		or	%s56,0,%s56
 2454      B8003845 
 2455              	# line 252
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2456              		.loc	1 252 0
 2457 3538 00000000 		lvl	%s1
 2457      008100BF 
 2458 3540 00000028 		vldl.sx.nc	%v40,4,%s56
 2458      B8040083 
 2459 3548 0028040F 		vfmk.w.eq	%vm15,%v40
 2459      000000B5 
 2460 3550 00000000 		smvl	%s13
 2460      00000D2E 
 2461 3558 00000000 		lvl	%s13
 2461      008D00BF 
 2462 3560 00000000 		lvl	%s1
 2462      008100BF 
 2463 3568 00000027 		vbrd	%v39,0,%vm15
 2463      00000F8C 
 2464 3570 00000F0F 		negm	%vm15,%vm15
 2464      00000095 
 2465 3578 40FFFFFF 		lea	%s63,-192
 2465      00003F06 
 2466 3580 00000000 		adds.l	%s63,%fp,%s63
 2466      BF893F59 
 2467 3588 00000000 		or	%s63,0,%s63
 2467      BF003F45 
 2468 3590 00000024 		vldl.sx.nc	%v36,4,%s63
 2468      BF040083 
 2469 3598 00240026 		vor	%v38,(0)1,%v36,%vm15
 2469      00002FC5 
 2470 35a0 00000000 		adds.l	%s63,-64,%fp
 2470      89403F59 
 2471 35a8 00260025 		vsfa	%v37,%v38,2,%s63,%vm15
 2471      BF020FD7 
 2472 35b0 00000023 		vbrd	%v35,0
 2472      0000008C 
 2473 35b8 00002523 		vgtl.sx	%v35,%v37,0,0,%vm15
 2473      00004FA3 
 2474 35c0 00232727 		vmrg	%v39,%v39,%v35,%vm15
 2474      00000FD6 
 2475 35c8 00000000 		adds.l	%s2,%s2,(0)1
 2475      00820259 
 2476 35d0 00000000 		or	%s2,0,%s2
 2476      82000245 
 2477 35d8 00000027 		vstl.nc	%v39,4,%s2
 2477      82040093 
 2478              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[i] = (gather[ix[i]]? kk[ix[i]]: 0);
 2479              		.loc	1 251 0
 2480 35e0 00000000 		subs.l	%s0,0,%s3
 2480      8300005B 
 2481 35e8 00000000 		lea	%s12,__grow_stack@LO
 2481      00000C06 
 2482 35f0 00000000 		and	%s12,%s12,(32)0
 2482      608C0C44 
 2483 35f8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2483      8C008C06 
 2484 3600 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2484      8C000A08 
 2485 3608 D0FEFFFF 		br.l	.L8.1
 2485      00000F18 
 2486              	.L8.3:
 2487              	# line 252
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2488              		.loc	1 252 0
 2489 3610 00000000 		ld	%s61,0(%s62,%s63)
 2489      BFBE3D01 
 2490 3618 30FFFFFF 		ld1b.sx	%s61,-208(%s61,%fp)	# gather
 2490      89BD3D05 
 2491 3620 00000000 		or	%s61,0,%s61
 2491      BD003D45 
 2492 3628 00000000 		stl	%s61,0(%s59,%s60)
 2492      BCBB3D13 
 2493 3630 00000000 		adds.l	%s59,4,%s59
 2493      BB043B59 
 2494 3638 00000000 		adds.l	%s62,8,%s62
 2494      BE083E59 
 2495 3640 00000000 		addu.l	%s57,%s57,(0)0
 2495      40B93948 
 2496 3648 00000000 		cmpu.l	%s18,%s57,(0)1
 2496      00B91255 
 2497 3650 C0FFFFFF 		brgt.l	%s18,0,.L8.3
 2497      00920118 
 2498 3658 D0FEFFFF 		br.l	.L8.2
 2498      00000F18 
 2499              	.L8.4:
 2500 3660 98AEFFFF 		st	%s63,-20840(,%fp)	# spill 
 2500      89003F11 
 2501 3668 F0000000 		dld	%s2,240(,%fp)	# _k
 2501      89000209 
 2502              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[i] = (gather[ix[i]]? kk[ix[i]]: 0);
 2503              		.loc	1 251 0
 2504 3670 00000000 		muls.l	%s0,12,%s63
 2504      BF0C006E 
 2505 3678 90AEFFFF 		st	%s0,-20848(,%fp)	# spill 
 2505      89000011 
 2506 3680 00000000 		lea	%s12,__grow_stack@LO
 2506      00000C06 
 2507 3688 00000000 		and	%s12,%s12,(32)0
 2507      608C0C44 
 2508 3690 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2508      8C008C06 
 2509 3698 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2509      8C000A08 
 2510 36a0 B8000000 		lea	%s61,184
 2510      00003D06 
 2511 36a8 00000000 		adds.l	%s61,%sp,%s61
 2511      BD8B3D59 
 2512 36b0 98AEFFFF 		ld	%s1,-20840(,%fp)	# restore 
 2512      89000101 
 2513 36b8 00000000 		or	%s63,0,%s61
 2513      BD003F45 
 2514 36c0 90AEFFFF 		ld	%s3,-20848(,%fp)	# restore 
 2514      89000301 
 2515 36c8 00000000 		mulu.l	%s56,8,%s1
 2515      81083849 
 2516 36d0 00000000 		adds.l	%s56,%s61,%s56
 2516      B8BD3859 
 2517 36d8 00000000 		or	%s60,0,%s56
 2517      B8003C45 
 2518 36e0 98AEFFFF 		ld	%s55,-20840(,%fp)	# restore 
 2518      89003701 
 2519              	# line 252
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2520              		.loc	1 252 0
 2521 36e8 40FFFFFF 		lea	%s54,-192
 2521      00003606 
 2522 36f0 00000000 		adds.l	%s54,%fp,%s54
 2522      B6893659 
 2523 36f8 00000000 		or	%s54,0,%s54
 2523      B6003645 
 2524 3700 00000000 		lvl	%s55
 2524      00B700BF 
 2525 3708 00000030 		vldl.sx.nc	%v48,4,%s54
 2525      B6040083 
 2526 3710 0030002F 		vor	%v47,(0)1,%v48
 2526      000020C5 
 2527 3718 00000000 		or	%s61,0,%s61
 2527      BD003D45 
 2528 3720 0000002F 		vst.nc	%v47,8,%s61
 2528      BD080091 
 2529 3728 98AEFFFF 		ld	%s57,-20840(,%fp)	# restore 
 2529      89003901 
 2530 3730 00000000 		or	%s59,0,(0)1
 2530      00003B45 
 2531 3738 00000000 		or	%s62,0,(0)1
 2531      00003E45 
 2532 3740 D0FEFFFF 		br.l	.L8.3
 2532      00000F18 
 2533              	.L8.5:
 2534              	# line 251
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     _k[i] = (gather[ix[i]]? kk[ix[i]]: 0);
 2535              		.loc	1 251 0
 2536 3748 00000000 		cmpu.l	%s18,0,%s63
 2536      BF001255 
 2537 3750 10FFFFFF 		brlt.l	%s18,0,.L8.4
 2537      00920218 
 2538 3758 80FDFFFF 		br.l	.L8.1
 2538      00000F18 
 2539              	.L8.6:
 2540 3760 00000000 		or	%s63,0,%s58
 2540      BA003F45 
 2541 3768 00000000 		cmpu.l	%s18,%s63,(0)1
 2541      00BF1255 
 2542 3770 D8FFFFFF 		brgt.l	%s18,0,.L8.5
 2542      00920118 
 2543 3778 60FDFFFF 		br.l	.L8.1
 2543      00000F18 
 2544              	.L8.7:
 2545 3780 00000000 		or	%s1,0,%s1
 2545      81000145 
 2546 3788 00000000 		or	%s55,0,%s55
 2546      B7003745 
 2547              	# line 249
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2548              		.loc	1 249 0
 2549 3790 00000000 		lvl	%s1
 2549      008100BF 
 2550 3798 0000002E 		vldl.sx.nc	%v46,4,%s55
 2550      B7040083 
 2551 37a0 002E040F 		vfmk.w.eq	%vm15,%v46
 2551      000000B5 
 2552 37a8 00000000 		smvl	%s13
 2552      00000D2E 
 2553 37b0 00000000 		lvl	%s13
 2553      008D00BF 
 2554 37b8 00000000 		lvl	%s1
 2554      008100BF 
 2555 37c0 0000002D 		vbrd	%v45,0,%vm15
 2555      00000F8C 
 2556 37c8 00000F0F 		negm	%vm15,%vm15
 2556      00000095 
 2557 37d0 00000000 		or	%s54,0,%s54
 2557      B6003645 
 2558 37d8 0000002A 		vldl.sx.nc	%v42,4,%s54
 2558      B6040083 
 2559 37e0 002A002C 		vor	%v44,(0)1,%v42,%vm15
 2559      00002FC5 
 2560 37e8 80FFFFFF 		lea	%s63,-128
 2560      00003F06 
 2561 37f0 00000000 		adds.l	%s63,%s63,%fp
 2561      89BF3F59 
 2562 37f8 002C002B 		vsfa	%v43,%v44,2,%s63,%vm15
 2562      BF020FD7 
 2563 3800 00000029 		vbrd	%v41,0
 2563      0000008C 
 2564 3808 00002B29 		vgtl.sx	%v41,%v43,0,0,%vm15
 2564      00004FA3 
 2565 3810 00292D2D 		vmrg	%v45,%v45,%v41,%vm15
 2565      00000FD6 
 2566 3818 00000000 		adds.l	%s7,%s7,(0)1
 2566      00870759 
 2567 3820 00000000 		or	%s7,0,%s7
 2567      87000745 
 2568 3828 0000002D 		vstl.nc	%v45,4,%s7
 2568      87040093 
 2569              	# line 247
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     const int ii = ix[i];
 2570              		.loc	1 247 0
 2571 3830 00000000 		subs.l	%s0,0,%s2
 2571      8200005B 
 2572 3838 00000000 		lea	%s12,__grow_stack@LO
 2572      00000C06 
 2573 3840 00000000 		and	%s12,%s12,(32)0
 2573      608C0C44 
 2574 3848 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2574      8C008C06 
 2575 3850 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2575      8C000A08 
 2576 3858 08FFFFFF 		br.l	.L8.6
 2576      00000F18 
 2577              	.L8.8:
 2578              	# line 249
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2579              		.loc	1 249 0
 2580 3860 40FFFFFF 		ldl.sx	%s62,-192(%s63,%fp)	# ix
 2580      89BF3E03 
 2581 3868 00000000 		or	%s56,0,%s62
 2581      BE003845 
 2582 3870 30FFFFFF 		ld1b.sx	%s56,-208(%s56,%fp)	# gather
 2582      89B83805 
 2583 3878 00000000 		or	%s56,0,%s56
 2583      B8003845 
 2584 3880 00000000 		stl	%s62,0(%s60,%s61)
 2584      BDBC3E13 
 2585 3888 00000000 		stl	%s56,0(%s60,%s59)
 2585      BBBC3813 
 2586 3890 00000000 		adds.l	%s63,4,%s63
 2586      BF043F59 
 2587 3898 00000000 		adds.l	%s60,4,%s60
 2587      BC043C59 
 2588 38a0 00000000 		addu.l	%s57,%s57,(0)0
 2588      40B93948 
 2589 38a8 00000000 		cmpu.l	%s18,%s57,(0)1
 2589      00B91255 
 2590 38b0 B0FFFFFF 		brgt.l	%s18,0,.L8.8
 2590      00920118 
 2591 38b8 C8FEFFFF 		br.l	.L8.7
 2591      00000F18 
 2592              	.L8.9:
 2593 38c0 A8C6FFFF 		st	%s63,-14680(,%fp)	# spill 
 2593      89003F11 
 2594              	# line 247
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     const int ii = ix[i];
 2595              		.loc	1 247 0
 2596 38c8 00000000 		muls.l	%s0,8,%s63
 2596      BF08006E 
 2597 38d0 A0C6FFFF 		st	%s0,-14688(,%fp)	# spill 
 2597      89000011 
 2598 38d8 00000000 		lea	%s12,__grow_stack@LO
 2598      00000C06 
 2599 38e0 00000000 		and	%s12,%s12,(32)0
 2599      608C0C44 
 2600 38e8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2600      8C008C06 
 2601 38f0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2601      8C000A08 
 2602 38f8 B8000000 		lea	%s62,184
 2602      00003E06 
 2603 3900 00000000 		adds.l	%s55,%sp,%s62
 2603      BE8B3759 
 2604 3908 A8C6FFFF 		ld	%s1,-14680(,%fp)	# restore 
 2604      89000101 
 2605 3910 00000000 		or	%s59,0,%s55
 2605      B7003B45 
 2606 3918 A0C6FFFF 		ld	%s2,-14688(,%fp)	# restore 
 2606      89000201 
 2607 3920 00000000 		mulu.l	%s62,4,%s1
 2607      81043E49 
 2608 3928 00000000 		adds.l	%s54,%s55,%s62
 2608      BEB73659 
 2609 3930 00000000 		or	%s61,0,%s54
 2609      B6003D45 
 2610 3938 A8C6FFFF 		ld	%s57,-14680(,%fp)	# restore 
 2610      89003901 
 2611 3940 00000000 		or	%s63,0,(0)1
 2611      00003F45 
 2612 3948 00000000 		or	%s60,0,(0)1
 2612      00003C45 
 2613 3950 10FFFFFF 		br.l	.L8.8
 2613      00000F18 
 2614              	.L8.10:
 2615 3958 00000000 		cmpu.l	%s18,0,%s63
 2615      BF001255 
 2616 3960 60FFFFFF 		brlt.l	%s18,0,.L8.9
 2616      00920218 
 2617 3968 F8FDFFFF 		br.l	.L8.6
 2617      00000F18 
 2618              	.L8.11:
 2619 3970 00000000 		or	%s63,0,%s58
 2619      BA003F45 
 2620 3978 00000000 		cmpu.l	%s18,%s63,(0)1
 2620      00BF1255 
 2621 3980 D8FFFFFF 		brgt.l	%s18,0,.L8.10
 2621      00920118 
 2622 3988 D8FDFFFF 		br.l	.L8.6
 2622      00000F18 
 2623              	.L8.12:
 2624              	# line 241
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k])
 2625              		.loc	1 241 0
 2626 3990 00000000 		adds.l	%s62,1,%s62
 2626      BE013E59 
 2627 3998 00000000 		adds.w.sx	%s60,1,%s60
 2627      BC013C4A 
 2628 39a0 30000000 		brgt.l	0,%s62,.L8.13
 2628      BE000118 
 2629 39a8 C8FFFFFF 		br.l	.L8.11
 2629      00000F18 
 2630              	.L8.14:
 2631              	# line 243
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2632              		.loc	1 243 0
 2633 39b0 40FFFFFF 		stl	%s60,-192(,%s59)	# ix
 2633      BB003C13 
 2634 39b8 00000000 		adds.w.sx	%s58,1,%s58
 2634      BA013A4A 
 2635 39c0 00000000 		adds.l	%s59,4,%s59
 2635      BB043B59 
 2636 39c8 C8FFFFFF 		br.l	.L8.12
 2636      00000F18 
 2637              	.L8.13:
 2638              	# line 242
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       ix[cnt++] = k;
 2639              		.loc	1 242 0
 2640 39d0 30FFFFFF 		ld1b.sx	%s61,-208(%s62,%s63)	# gather
 2640      BFBE3D05 
 2641 39d8 00000000 		or	%s61,0,%s61
 2641      BD003D45 
 2642 39e0 D0FFFFFF 		brne.w	0,%s61,.L8.14
 2642      BD008318 
 2643 39e8 A8FFFFFF 		br.l	.L8.12
 2643      00000F18 
 2644              	.L8.15:
 2645              	# line 223
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     kk[k] = k;
 2646              		.loc	1 223 0
 2647 39f0 00000000 		or	%s0,-64,(0)1
 2647      00400045 
 2648 39f8 00000000 		lea	%s12,__grow_stack@LO
 2648      00000C06 
 2649 3a00 00000000 		and	%s12,%s12,(32)0
 2649      608C0C44 
 2650 3a08 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2650      8C008C06 
 2651 3a10 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2651      8C000A08 
 2652              	# line 241
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k])
 2653              		.loc	1 241 0
 2654 3a18 00000000 		or	%s60,0,(0)1
 2654      00003C45 
 2655 3a20 00000000 		adds.l	%s63,16,%fp
 2655      89103F59 
 2656              	# line 243
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2657              		.loc	1 243 0
 2658 3a28 00000000 		or	%s61,0,(0)1
 2658      00003D45 
 2659 3a30 00000000 		or	%s58,0,%s1
 2659      81003A45 
 2660 3a38 00000000 		muls.l	%s61,4,%s61
 2660      BD043D6E 
 2661 3a40 00000000 		adds.l	%s59,%fp,%s61
 2661      BD893B59 
 2662              	# line 241
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     if (gather[k])
 2663              		.loc	1 241 0
 2664 3a48 00000000 		or	%s62,-16,(0)1
 2664      00703E45 
 2665 3a50 80FFFFFF 		br.l	.L8.13
 2665      00000F18 
 2666              	.L8.0:
 2667              	# line 230
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 2668              		.loc	1 230 0
 2669 3a58 00000000 		ldl.sx	%s61,0(%s62,%s63)
 2669      BFBE3D03 
 2670 3a60 38000000 		lea	%s57,56
 2670      00003906 
 2671 3a68 00000000 		sll	%s61,%s61,%s57
 2671      BDB93D65 
 2672 3a70 38000000 		lea	%s57,56
 2672      00003906 
 2673 3a78 00000000 		sra.l	%s61,%s61,%s57
 2673      BDB93D77 
 2674 3a80 30FFFFFF 		st1b	%s61,-208(%s59,%s60)	# gather
 2674      BCBB3D15 
 2675              	# line 223
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     kk[k] = k;
 2676              		.loc	1 223 0
 2677 3a88 00000000 		adds.l	%s59,1,%s59
 2677      BB013B59 
 2678 3a90 00000000 		adds.l	%s62,4,%s62
 2678      BE043E59 
 2679 3a98 00000000 		adds.l	%s58,-1,%s58
 2679      BA7F3A59 
 2680 3aa0 B8FFFFFF 		brlt.l	0,%s58,.L8.0
 2680      BA000218 
 2681 3aa8 48FFFFFF 		br.l	.L8.15
 2681      00000F18 
 2682              		.cfi_endproc
 2683              		.set	.L.9.2auto_size,	0xffffffffffff5d30	# 41680 Bytes
 2685              	# ============ End  conv::precompute_ok2(int, int, int, int, int, int, int&, int*, int*) ============
 2686              	# ============ Begin  conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2687              		.balign 16
 2688              	# line 312
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   const bool fast = MAX2(KH, KW) <= precompute_size;
 2689              		.loc	1 312 0
 2690              		.globl	conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2692              	conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 2693              		.cfi_startproc
 2694 3ab0 00000000 		st	%fp,0x0(,%sp)
 2694      8B000911 
 2695              		.cfi_def_cfa_offset	0
 2696              		.cfi_offset	9,0
 2697 3ab8 08000000 		st	%lr,0x8(,%sp)
 2697      8B000A11 
 2698 3ac0 18000000 		st	%got,0x18(,%sp)
 2698      8B000F11 
 2699 3ac8 20000000 		st	%plt,0x20(,%sp)
 2699      8B001011 
 2700 3ad0 00000000 		or	%fp,0,%sp
 2700      8B000945 
 2701              		.cfi_def_cfa_register	9
 2702 3ad8 30000000 		st	%s18,48(,%fp)
 2702      89001211 
 2703 3ae0 38000000 		st	%s19,56(,%fp)
 2703      89001311 
 2704 3ae8 58000000 		st	%s23,88(,%fp)
 2704      89001711 
 2705 3af0 60000000 		st	%s24,96(,%fp)
 2705      89001811 
 2706 3af8 68000000 		st	%s25,104(,%fp)
 2706      89001911 
 2707 3b00 30FDFFFF 		lea	%s13,.L.10.2auto_size&0xffffffff
 2707      00000D06 
 2708 3b08 00000000 		and	%s13,%s13,(32)0
 2708      608D0D44 
 2709 3b10 FFFFFFFF 		lea.sl	%sp,.L.10.2auto_size>>32(%fp,%s13)
 2709      8D898B06 
 2710 3b18 48000000 		brge.l.t	%sp,%sl,.L9.EoP
 2710      888B3518 
 2711 3b20 18000000 		ld	%s61,0x18(,%tp)
 2711      8E003D01 
 2712 3b28 00000000 		or	%s62,0,%s0
 2712      80003E45 
 2713 3b30 3B010000 		lea	%s63,0x13b
 2713      00003F06 
 2714 3b38 00000000 		shm.l	%s63,0x0(%s61)
 2714      BD033F31 
 2715 3b40 08000000 		shm.l	%sl,0x8(%s61)
 2715      BD030831 
 2716 3b48 10000000 		shm.l	%sp,0x10(%s61)
 2716      BD030B31 
 2717 3b50 00000000 		monc
 2717      0000003F 
 2718 3b58 00000000 		or	%s0,0,%s62
 2718      BE000045 
 2719              	.L9.EoP:
 2720              	# End of prologue codes
 2721              	# line 313
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
 2722              		.loc	1 313 0
 2723 3b60 20000000 		ldl.sx	%s18,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 2723      80001203 
 2724 3b68 24000000 		ldl.sx	%s19,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 2724      80001303 
 2725 3b70 90050000 		brgt.w	%s18,%s19,.L9.0
 2725      93928118 
 2726 3b78 00000000 		or	%s61,0,%s19
 2726      93003D45 
 2727 3b80 00000000 		or	%s63,0,%s0
 2727      80003F45 
 2728 3b88 00050000 		br.l	.L9.1
 2728      00000F18 
 2729              	.L9.2:
 2730 3b90 E8FFFFFF 		st	%s61,-24(,%fp)	# spill 
 2730      89003D11 
 2731 3b98 E0FFFFFF 		st	%s59,-32(,%fp)	# spill 
 2731      89003B11 
 2732 3ba0 D8FFFFFF 		st	%s58,-40(,%fp)	# spill 
 2732      89003A11 
 2733 3ba8 D0FFFFFF 		st	%s56,-48(,%fp)	# spill 
 2733      89003811 
 2734 3bb0 C8FFFFFF 		st	%s60,-56(,%fp)	# spill 
 2734      89003C11 
 2735 3bb8 C0FFFFFF 		st	%s63,-64(,%fp)	# spill 
 2735      89003F11 
 2736 3bc0 B8FFFFFF 		st	%s57,-72(,%fp)	# spill 
 2736      89003911 
 2737 3bc8 B0FFFFFF 		st	%s2,-80(,%fp)	# spill 
 2737      89000211 
 2738 3bd0 A8FFFFFF 		st	%s3,-88(,%fp)	# spill 
 2738      89000311 
 2739 3bd8 A0FFFFFF 		st	%s6,-96(,%fp)	# spill 
 2739      89000611 
 2740 3be0 98FFFFFF 		st	%s7,-104(,%fp)	# spill 
 2740      89000711 
 2741              	# line 407
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 2742              		.loc	1 407 0
 2743 3be8 F0000000 		st	%s23,240(,%sp)
 2743      8B001711 
 2744 3bf0 F8000000 		st	%s57,248(,%sp)
 2744      8B003911 
 2745 3bf8 00000000 		or	%s5,0,%s60
 2745      BC000545 
 2746 3c00 00000000 		or	%s4,0,%s62
 2746      BE000445 
 2747 3c08 00000000 		or	%s1,0,%s63
 2747      BF000145 
 2748 3c10 00000000 		or	%s0,0,%s24
 2748      98000045 
 2749 3c18 00000000 		lea	%s12,_ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_PKfS6_RfiiiiiE_clES2_S6_S
 2749      00000C06 
 2750 3c20 00000000 		and	%s12,%s12,(32)0
 2750      608C0C44 
 2751 3c28 00000000 		lea.sl	%s12,_ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_PKfS6_RfiiiiiE_clES2_S
 2751      8C008C06 
 2752 3c30 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_PKfS6_RfiiiiiE_
 2752      8C000A08 
 2753 3c38 C0FFFFFF 		ld	%s63,-64(,%fp)	# restore 
 2753      89003F01 
 2754 3c40 B8FFFFFF 		ld	%s57,-72(,%fp)	# restore 
 2754      89003901 
 2755 3c48 E8FFFFFF 		ld	%s61,-24(,%fp)	# restore 
 2755      89003D01 
 2756 3c50 E0FFFFFF 		ld	%s59,-32(,%fp)	# restore 
 2756      89003B01 
 2757 3c58 D8FFFFFF 		ld	%s58,-40(,%fp)	# restore 
 2757      89003A01 
 2758 3c60 C8FFFFFF 		ld	%s60,-56(,%fp)	# restore 
 2758      89003C01 
 2759 3c68 D0FFFFFF 		ld	%s56,-48(,%fp)	# restore 
 2759      89003801 
 2760 3c70 B0FFFFFF 		ld	%s2,-80(,%fp)	# restore 
 2760      89000201 
 2761 3c78 A8FFFFFF 		ld	%s3,-88(,%fp)	# restore 
 2761      89000301 
 2762 3c80 A0FFFFFF 		ld	%s6,-96(,%fp)	# restore 
 2762      89000601 
 2763 3c88 98FFFFFF 		ld	%s7,-104(,%fp)	# restore 
 2763      89000701 
 2764 3c90 F0000000 		br.l	.L9.3
 2764      00000F18 
 2765              	.L9.4:
 2766              	# line 413
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 2767              		.loc	1 413 0
 2768              	# Start of epilogue codes
 2769 3c98 30000000 		ld	%s18,48(,%fp)
 2769      89001201 
 2770 3ca0 38000000 		ld	%s19,56(,%fp)
 2770      89001301 
 2771 3ca8 58000000 		ld	%s23,88(,%fp)
 2771      89001701 
 2772 3cb0 60000000 		ld	%s24,96(,%fp)
 2772      89001801 
 2773 3cb8 68000000 		ld	%s25,104(,%fp)
 2773      89001901 
 2774 3cc0 00000000 		or	%sp,0,%fp
 2774      89000B45 
 2775              		.cfi_def_cfa	11,8
 2776 3cc8 18000000 		ld	%got,0x18(,%sp)
 2776      8B000F01 
 2777 3cd0 20000000 		ld	%plt,0x20(,%sp)
 2777      8B001001 
 2778 3cd8 08000000 		ld	%lr,0x8(,%sp)
 2778      8B000A01 
 2779 3ce0 00000000 		ld	%fp,0x0(,%sp)
 2779      8B000901 
 2780 3ce8 00000000 		b.l	(,%lr)
 2780      8A000F19 
 2781              	.L9.5:
 2782              	# line 395
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2783              		.loc	1 395 0
 2784 3cf0 00000000 		ldl.sx	%s19,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2784      BF001303 
 2785 3cf8 00000000 		adds.w.sx	%s60,1,%s60
 2785      BC013C4A 
 2786 3d00 38030000 		brlt.w	%s60,%s19,.L9.6
 2786      93BC8218 
 2787 3d08 90FFFFFF 		br.l	.L9.4
 2787      00000F18 
 2788              	.L9.7:
 2789              	# line 396
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 2790              		.loc	1 396 0
 2791 3d10 04000000 		ldl.sx	%s19,4(,%s63)	# *(p).__b_N4conv6desc_tE.mb
 2791      BF001303 
 2792 3d18 00000000 		adds.w.sx	%s6,1,%s6
 2792      8601064A 
 2793 3d20 E8020000 		brlt.w	%s6,%s19,.L9.8
 2793      93868218 
 2794 3d28 C8FFFFFF 		br.l	.L9.5
 2794      00000F18 
 2795              	.L9.9:
 2796              	# line 397
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2797              		.loc	1 397 0
 2798 3d30 08000000 		ldl.sx	%s62,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 2798      BF003E03 
 2799 3d38 00000000 		ldl.sx	%s59,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2799      BF003B03 
 2800 3d40 00000000 		divs.w.sx	%s59,%s62,%s59
 2800      BBBE3B7B 
 2801 3d48 00000000 		adds.w.sx	%s7,1,%s7
 2801      8701074A 
 2802 3d50 88020000 		brlt.w	%s7,%s59,.L9.10
 2802      BB878218 
 2803 3d58 B8FFFFFF 		br.l	.L9.7
 2803      00000F18 
 2804              	.L9.11:
 2805              	# line 398
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 2806              		.loc	1 398 0
 2807 3d60 0C000000 		ldl.sx	%s19,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 2807      BF001303 
 2808 3d68 00000000 		adds.w.sx	%s23,1,%s23
 2808      9701174A 
 2809 3d70 38020000 		brlt.w	%s23,%s19,.L9.12
 2809      93978218 
 2810 3d78 B8FFFFFF 		br.l	.L9.9
 2810      00000F18 
 2811              	.L9.3:
 2812              	# line 399
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2813              		.loc	1 399 0
 2814 3d80 10000000 		ldl.sx	%s19,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 2814      BF001303 
 2815 3d88 00000000 		adds.w.sx	%s57,1,%s57
 2815      B901394A 
 2816 3d90 48010000 		brlt.w	%s57,%s19,.L9.13
 2816      93B98218 
 2817 3d98 C8FFFFFF 		br.l	.L9.11
 2817      00000F18 
 2818              	.L9.14:
 2819 3da0 E8FFFFFF 		st	%s61,-24(,%fp)	# spill 
 2819      89003D11 
 2820 3da8 E0FFFFFF 		st	%s59,-32(,%fp)	# spill 
 2820      89003B11 
 2821 3db0 D8FFFFFF 		st	%s58,-40(,%fp)	# spill 
 2821      89003A11 
 2822 3db8 D0FFFFFF 		st	%s56,-48(,%fp)	# spill 
 2822      89003811 
 2823 3dc0 A0FFFFFF 		st	%s6,-96(,%fp)	# spill 
 2823      89000611 
 2824 3dc8 C8FFFFFF 		st	%s60,-56(,%fp)	# spill 
 2824      89003C11 
 2825 3dd0 A8FFFFFF 		st	%s3,-88(,%fp)	# spill 
 2825      89000311 
 2826 3dd8 B0FFFFFF 		st	%s2,-80(,%fp)	# spill 
 2826      89000211 
 2827 3de0 C0FFFFFF 		st	%s63,-64(,%fp)	# spill 
 2827      89003F11 
 2828 3de8 B8FFFFFF 		st	%s57,-72(,%fp)	# spill 
 2828      89003911 
 2829 3df0 98FFFFFF 		st	%s7,-104(,%fp)	# spill 
 2829      89000711 
 2830              	# line 404
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                        ds, g, mb, ic, ih, iw);
 2831              		.loc	1 404 0
 2832 3df8 00000000 		or	%s55,16,(0)1
 2832      00103745 
 2833 3e00 F0000000 		st	%s7,240(,%sp)
 2833      8B000711 
 2834 3e08 F8000000 		st	%s23,248(,%sp)
 2834      8B001711 
 2835 3e10 00010000 		st	%s57,256(,%sp)
 2835      8B003911 
 2836 3e18 00000000 		or	%s7,0,%s6
 2836      86000745 
 2837 3e20 00000000 		or	%s6,0,%s60
 2837      BC000645 
 2838 3e28 00000000 		or	%s5,0,%s62
 2838      BE000545 
 2839 3e30 00000000 		or	%s4,0,%s3
 2839      83000445 
 2840 3e38 00000000 		or	%s3,0,%s2
 2840      82000345 
 2841 3e40 00000000 		or	%s1,0,%s63
 2841      BF000145 
 2842 3e48 00000000 		or	%s0,0,%s25
 2842      99000045 
 2843 3e50 00000000 		or	%s2,0,%s55
 2843      B7000245 
 2844 3e58 00000000 		lea	%s12,conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, conv::sz, float const*, float const*, float&, int, int, int, int, int)#1}::operator() const
 2844      00000C06 
 2845 3e60 00000000 		and	%s12,%s12,(32)0
 2845      608C0C44 
 2846 3e68 00000000 		lea.sl	%s12,_ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_RfiiiiiE_
 2846      8C008C06 
 2847 3e70 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv15refconv_2_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_ENKUlS2_NS_2szEPKfS7_Rf
 2847      8C000A08 
 2848 3e78 C0FFFFFF 		ld	%s63,-64(,%fp)	# restore 
 2848      89003F01 
 2849 3e80 B8FFFFFF 		ld	%s57,-72(,%fp)	# restore 
 2849      89003901 
 2850 3e88 E8FFFFFF 		ld	%s61,-24(,%fp)	# restore 
 2850      89003D01 
 2851 3e90 E0FFFFFF 		ld	%s59,-32(,%fp)	# restore 
 2851      89003B01 
 2852 3e98 D8FFFFFF 		ld	%s58,-40(,%fp)	# restore 
 2852      89003A01 
 2853 3ea0 98FFFFFF 		ld	%s7,-104(,%fp)	# restore 
 2853      89000701 
 2854 3ea8 A0FFFFFF 		ld	%s6,-96(,%fp)	# restore 
 2854      89000601 
 2855 3eb0 C8FFFFFF 		ld	%s60,-56(,%fp)	# restore 
 2855      89003C01 
 2856 3eb8 B0FFFFFF 		ld	%s2,-80(,%fp)	# restore 
 2856      89000201 
 2857 3ec0 A8FFFFFF 		ld	%s3,-88(,%fp)	# restore 
 2857      89000301 
 2858 3ec8 D0FFFFFF 		ld	%s56,-48(,%fp)	# restore 
 2858      89003801 
 2859 3ed0 B0FEFFFF 		br.l	.L9.3
 2859      00000F18 
 2860              	.L9.13:
 2861              	# line 400
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float &ds = pdiff_src[src_off];
 2862              		.loc	1 400 0
 2863 3ed8 08000000 		ldl.sx	%s62,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 2863      BF003E03 
 2864 3ee0 00000000 		or	%s55,0,%s62
 2864      BE003745 
 2865 3ee8 00000000 		mulu.l	%s55,%s55,%s61
 2865      BDB73749 
 2866 3ef0 00000000 		muls.w.sx	%s62,%s62,%s60
 2866      BCBE3E4B 
 2867 3ef8 00000000 		ldl.sx	%s54,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2867      BF003603 
 2868 3f00 00000000 		divs.w.sx	%s54,%s62,%s54
 2868      B6BE367B 
 2869 3f08 00000000 		or	%s54,0,%s54
 2869      B6003645 
 2870 3f10 00000000 		addu.l	%s54,%s55,%s54
 2870      B6B73648 
 2871 3f18 00000000 		addu.l	%s54,%s54,%s59
 2871      BBB63648 
 2872 3f20 0C000000 		ldl.sx	%s62,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 2872      BF003E03 
 2873 3f28 00000000 		or	%s62,0,%s62
 2873      BE003E45 
 2874 3f30 00000000 		mulu.l	%s62,%s54,%s62
 2874      BEB63E49 
 2875 3f38 00000000 		addu.l	%s62,%s62,%s58
 2875      BABE3E48 
 2876 3f40 10000000 		ldl.sx	%s55,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 2876      BF003703 
 2877 3f48 00000000 		or	%s55,0,%s55
 2877      B7003745 
 2878 3f50 00000000 		mulu.l	%s55,%s62,%s55
 2878      B7BE3749 
 2879 3f58 00000000 		or	%s62,0,%s57
 2879      B9003E45 
 2880 3f60 00000000 		addu.l	%s62,%s55,%s62
 2880      BEB73E48 
 2881              	# line 401
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             ds = 0;
 2882              		.loc	1 401 0
 2883 3f68 00000000 		mulu.l	%s62,4,%s62
 2883      BE043E49 
 2884 3f70 00000000 		adds.l	%s62,%s62,%s56
 2884      B8BE3E59 
 2885              	# line 402
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             if (fast)
 2886              		.loc	1 402 0
 2887 3f78 00000000 		or	%s55,0,(0)1
 2887      00003745 
 2888 3f80 00000000 		stu	%s55,0(,%s62)	# *(ds)
 2888      BE003712 
 2889 3f88 18FEFFFF 		brne.w	0,%s18,.L9.14
 2889      92008318 
 2890 3f90 00FCFFFF 		br.l	.L9.2
 2890      00000F18 
 2891              	.L9.15:
 2892 3f98 00000000 		or	%s58,0,%s23
 2892      97003A45 
 2893 3fa0 38FFFFFF 		br.l	.L9.13
 2893      00000F18 
 2894              	.L9.12:
 2895              	# line 399
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2896              		.loc	1 399 0
 2897 3fa8 00000000 		or	%s57,0,(0)1
 2897      00003945 
 2898 3fb0 10000000 		ldl.sx	%s19,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 2898      BF001303 
 2899 3fb8 E0FFFFFF 		brlt.w	0,%s19,.L9.15
 2899      93008218 
 2900 3fc0 A0FDFFFF 		br.l	.L9.11
 2900      00000F18 
 2901              	.L9.16:
 2902 3fc8 00000000 		or	%s59,0,%s7
 2902      87003B45 
 2903 3fd0 D8FFFFFF 		br.l	.L9.12
 2903      00000F18 
 2904              	.L9.10:
 2905              	# line 398
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 2906              		.loc	1 398 0
 2907 3fd8 00000000 		or	%s23,0,(0)1
 2907      00001745 
 2908 3fe0 0C000000 		ldl.sx	%s19,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 2908      BF001303 
 2909 3fe8 E0FFFFFF 		brlt.w	0,%s19,.L9.16
 2909      93008218 
 2910 3ff0 40FDFFFF 		br.l	.L9.9
 2910      00000F18 
 2911              	.L9.17:
 2912 3ff8 00000000 		or	%s61,0,%s6
 2912      86003D45 
 2913 4000 D8FFFFFF 		br.l	.L9.10
 2913      00000F18 
 2914              	.L9.8:
 2915              	# line 397
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2916              		.loc	1 397 0
 2917 4008 00000000 		or	%s7,0,(0)1
 2917      00000745 
 2918 4010 08000000 		ldl.sx	%s62,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 2918      BF003E03 
 2919 4018 00000000 		ldl.sx	%s61,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2919      BF003D03 
 2920 4020 00000000 		divs.w.sx	%s61,%s62,%s61
 2920      BDBE3D7B 
 2921 4028 D0FFFFFF 		brlt.w	0,%s61,.L9.17
 2921      BD008218 
 2922 4030 E0FCFFFF 		br.l	.L9.7
 2922      00000F18 
 2923              	.L9.6:
 2924              	# line 396
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 2925              		.loc	1 396 0
 2926 4038 00000000 		or	%s6,0,(0)1
 2926      00000645 
 2927 4040 04000000 		ldl.sx	%s19,4(,%s63)	# *(p).__b_N4conv6desc_tE.mb
 2927      BF001303 
 2928 4048 C0FFFFFF 		brlt.w	0,%s19,.L9.8
 2928      93008218 
 2929 4050 A0FCFFFF 		br.l	.L9.5
 2929      00000F18 
 2930              	.L9.18:
 2931 4058 00000000 		or	%s18,0,%s61
 2931      BD001245 
 2932              	# line 404
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****                        ds, g, mb, ic, ih, iw);
 2933              		.loc	1 404 0
 2934 4060 F1FFFFFF 		lea	%s61,-15
 2934      00003D06 
 2935 4068 00000000 		adds.l	%s25,%fp,%s61
 2935      BD891959 
 2936              	# line 407
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 2937              		.loc	1 407 0
 2938 4070 00000000 		adds.l	%s24,%fp,(60)1
 2938      3C891859 
 2939 4078 00000000 		or	%s3,0,%s62
 2939      BE000345 
 2940 4080 B8FFFFFF 		br.l	.L9.6
 2940      00000F18 
 2941              	.L9.1:
 2942              	# line 313
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
 2943              		.loc	1 313 0
 2944 4088 10000000 		lea	%s62,16
 2944      00003E06 
 2945 4090 00000000 		cmps.w.sx	%s62,%s61,%s62
 2945      BEBD3E7A 
 2946 4098 00000000 		or	%s61,0,(0)1
 2946      00003D45 
 2947 40a0 38000000 		lea	%s59,56
 2947      00003B06 
 2948 40a8 86000000 		cmov.w.le	%s61,(63)0,%s62
 2948      7FBE3D3B 
 2949 40b0 38000000 		lea	%s62,56
 2949      00003E06 
 2950 40b8 00000000 		sll	%s61,%s61,%s59
 2950      BDBB3D65 
 2951 40c0 00000000 		sra.l	%s61,%s61,%s62
 2951      BDBE3D77 
 2952              	# line 395
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2953              		.loc	1 395 0
 2954 40c8 00000000 		or	%s60,0,(0)1
 2954      00003C45 
 2955              	# line 314
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float const * restrict const pwei = (float*)wei_m;
 2956              		.loc	1 314 0
 2957 40d0 A8010000 		ld	%s56,424(,%s1)	# *(diff_src_m).data_
 2957      81003801 
 2958              	# line 315
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   //float const * restrict const pbia = (float*)bia_m;
 2959              		.loc	1 315 0
 2960 40d8 A8010000 		ld	%s62,424(,%s2)	# *(wei_m).data_
 2960      82003E01 
 2961              	# line 317
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 2962              		.loc	1 317 0
 2963 40e0 A8010000 		ld	%s2,424(,%s3)	# *(diff_dst_m).data_
 2963      83000201 
 2964              	# line 395
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2965              		.loc	1 395 0
 2966 40e8 00000000 		ldl.sx	%s18,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 2966      BF001203 
 2967 40f0 68FFFFFF 		brlt.w	0,%s18,.L9.18
 2967      92008218 
 2968 40f8 A0FBFFFF 		br.l	.L9.4
 2968      00000F18 
 2969              	.L9.0:
 2970              	# line 313
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
 2971              		.loc	1 313 0
 2972 4100 20000000 		ldl.sx	%s61,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 2972      80003D03 
 2973 4108 00000000 		or	%s63,0,%s0
 2973      80003F45 
 2974 4110 78FFFFFF 		br.l	.L9.1
 2974      00000F18 
 2975              		.cfi_endproc
 2976              		.set	.L.10.2auto_size,	0xfffffffffffffd30	# 720 Bytes
 2978              	# ============ End  conv::refconv_2_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2979              	# ============ Begin  conv::refconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2980 4118 00000000 		.balign 16
 2980      00000000 
 2981              	# line 423
 423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 2982              		.loc	1 423 0
 2983              		.globl	conv::refconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2985              	conv::refconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 2986              		.cfi_startproc
 2987 4120 00000000 		st	%fp,0x0(,%sp)
 2987      8B000911 
 2988              		.cfi_def_cfa_offset	0
 2989              		.cfi_offset	9,0
 2990 4128 08000000 		st	%lr,0x8(,%sp)
 2990      8B000A11 
 2991 4130 18000000 		st	%got,0x18(,%sp)
 2991      8B000F11 
 2992 4138 20000000 		st	%plt,0x20(,%sp)
 2992      8B001011 
 2993 4140 00000000 		or	%fp,0,%sp
 2993      8B000945 
 2994              		.cfi_def_cfa_register	9
 2995 4148 30000000 		st	%s18,48(,%fp)
 2995      89001211 
 2996 4150 38000000 		st	%s19,56(,%fp)
 2996      89001311 
 2997 4158 40000000 		st	%s20,64(,%fp)
 2997      89001411 
 2998 4160 48000000 		st	%s21,72(,%fp)
 2998      89001511 
 2999 4168 50000000 		st	%s22,80(,%fp)
 2999      89001611 
 3000 4170 58000000 		st	%s23,88(,%fp)
 3000      89001711 
 3001 4178 60000000 		st	%s24,96(,%fp)
 3001      89001811 
 3002 4180 68000000 		st	%s25,104(,%fp)
 3002      89001911 
 3003 4188 70000000 		st	%s26,112(,%fp)
 3003      89001A11 
 3004 4190 78000000 		st	%s27,120(,%fp)
 3004      89001B11 
 3005 4198 80000000 		st	%s28,128(,%fp)
 3005      89001C11 
 3006 41a0 88000000 		st	%s29,136(,%fp)
 3006      89001D11 
 3007 41a8 90000000 		st	%s30,144(,%fp)
 3007      89001E11 
 3008 41b0 80FDFFFF 		lea	%s13,.L.11.2auto_size&0xffffffff
 3008      00000D06 
 3009 41b8 00000000 		and	%s13,%s13,(32)0
 3009      608D0D44 
 3010 41c0 FFFFFFFF 		lea.sl	%sp,.L.11.2auto_size>>32(%fp,%s13)
 3010      8D898B06 
 3011 41c8 48000000 		brge.l.t	%sp,%sl,.L10.EoP
 3011      888B3518 
 3012 41d0 18000000 		ld	%s61,0x18(,%tp)
 3012      8E003D01 
 3013 41d8 00000000 		or	%s62,0,%s0
 3013      80003E45 
 3014 41e0 3B010000 		lea	%s63,0x13b
 3014      00003F06 
 3015 41e8 00000000 		shm.l	%s63,0x0(%s61)
 3015      BD033F31 
 3016 41f0 08000000 		shm.l	%sl,0x8(%s61)
 3016      BD030831 
 3017 41f8 10000000 		shm.l	%sp,0x10(%s61)
 3017      BD030B31 
 3018 4200 00000000 		monc
 3018      0000003F 
 3019 4208 00000000 		or	%s0,0,%s62
 3019      BE000045 
 3020              	.L10.EoP:
 3021              	# End of prologue codes
 3022              	# line 425
 425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
 3023              		.loc	1 425 0
 3024 4210 A8010000 		ld	%s63,424(,%s1)	# *(src_m).data_
 3024      81003F01 
 3025              	# line 426
 426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_wei = (float*)diff_wei_m;
 3026              		.loc	1 426 0
 3027 4218 A8010000 		ld	%s4,424(,%s4)	# *(diff_dst_m).data_
 3027      84000401 
 3028              	# line 427
 427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   float       * restrict const pdiff_bia = (float*)diff_bia_m;
 3029              		.loc	1 427 0
 3030 4220 A8010000 		ld	%s28,424(,%s2)	# *(diff_wei_m).data_
 3030      82001C01 
 3031              	# line 428
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   auto ker = []( const prb_t *p,
 3032              		.loc	1 428 0
 3033 4228 A8010000 		ld	%s40,424(,%s3)	# *(diff_bia_m).data_
 3033      83002801 
 3034              	# line 452
 450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMP(parallel for collapse(5))//;
 452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int g = 0; g < G; ++g) {
 3035              		.loc	1 452 0
 3036 4230 00000000 		or	%s5,0,(0)1
 3036      00000545 
 3037 4238 00000000 		ldl.sx	%s18,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3037      80001203 
 3038 4240 00090000 		brlt.w	0,%s18,.L10.0
 3038      92008218 
 3039 4248 30050000 		br.l	.L10.1
 3039      00000F18 
 3040              	.L10.2:
 3041              	# line 478
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int kh = 0; kh < KH; ++kh) {
 456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float &dw = pdiff_wei[wei_off];
 459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             dw = 0;
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             ker( p, pdiff_dst, psrc, dw, g, oc, ic, kh, kw);
 461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   if (!(p->dir & FLAG_BIA)) return;
 468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   OMP(parallel for collapse(2))//;
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   for (int g = 0; g < G; ++g) {
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       size_t bia_off = bia_off_f(p, g, oc);
 473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       float &db = pdiff_bia[bia_off];
 474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       db = 0;
 475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int mb = 0; mb < MB; ++mb) {
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 3042              		.loc	1 478 0
 3043 4250 80000000 		mins.w.sx	%s61,%s59,%s61
 3043      BDBB3D78 
 3044 4258 78010000 		br.l	.L10.3
 3044      00000F18 
 3045              	.L10.4:
 3046              	# line 470
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 3047              		.loc	1 470 0
 3048 4260 00000000 		adds.w.sx	%s63,1,%s63
 3048      BF013F4A 
 3049 4268 00000000 		adds.l	%s59,%s62,%s59
 3049      BBBE3B59 
 3050 4270 00000000 		adds.w.sx	%s54,%s58,%s54
 3050      B6BA364A 
 3051 4278 78030000 		brgt.w	0,%s63,.L10.5
 3051      BF008118 
 3052 4280 60040000 		br.l	.L10.6
 3052      00000F18 
 3053              	.L10.7:
 3054 4288 00000000 		or	%s63,0,%s22
 3054      96003F45 
 3055 4290 00000000 		or	%s62,0,%s23
 3055      97003E45 
 3056 4298 00000000 		or	%s59,0,%s24
 3056      98003B45 
 3057 42a0 00000000 		or	%s58,0,%s7
 3057      87003A45 
 3058 42a8 B8FFFFFF 		br.l	.L10.4
 3058      00000F18 
 3059              	.L10.8:
 3060              	# line 471
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       size_t bia_off = bia_off_f(p, g, oc);
 3061              		.loc	1 471 0
 3062 42b0 00000000 		adds.w.sx	%s62,1,%s62
 3062      BE013E4A 
 3063 42b8 00000000 		adds.l	%s58,4,%s58
 3063      BA043A59 
 3064 42c0 00000000 		adds.w.sx	%s60,1,%s60
 3064      BC013C4A 
 3065 42c8 98020000 		brgt.w	0,%s62,.L10.9
 3065      BE008118 
 3066 42d0 B8FFFFFF 		br.l	.L10.7
 3066      00000F18 
 3067              	.L10.10:
 3068 42d8 00000000 		or	%s62,0,%s5
 3068      85003E45 
 3069 42e0 00000000 		or	%s60,0,%s6
 3069      86003C45 
 3070 42e8 C8FFFFFF 		br.l	.L10.8
 3070      00000F18 
 3071              	.L10.11:
 3072              	# line 476
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 3073              		.loc	1 476 0
 3074 42f0 00000000 		adds.w.sx	%s63,1,%s63
 3074      BF013F4A 
 3075 42f8 00000000 		adds.l	%s60,%s61,%s60
 3075      BCBD3C59 
 3076 4300 10020000 		brgt.w	0,%s63,.L10.12
 3076      BF008118 
 3077 4308 D0FFFFFF 		br.l	.L10.10
 3077      00000F18 
 3078              	.L10.13:
 3079 4310 00000000 		or	%s63,0,%s1
 3079      81003F45 
 3080 4318 00000000 		or	%s61,0,%s3
 3080      83003D45 
 3081 4320 00000000 		or	%s60,0,%s4
 3081      84003C45 
 3082 4328 C8FFFFFF 		br.l	.L10.11
 3082      00000F18 
 3083              	.L10.14:
 3084              	# line 477
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 3085              		.loc	1 477 0
 3086 4330 00000000 		adds.w.sx	%s63,1,%s63
 3086      BF013F4A 
 3087 4338 00000000 		adds.w.sx	%s62,1,%s62
 3087      BE013E4A 
 3088 4340 90010000 		brgt.w	0,%s63,.L10.15
 3088      BF008118 
 3089 4348 C8FFFFFF 		br.l	.L10.13
 3089      00000F18 
 3090              	.L10.16:
 3091              	# line 480
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             db += pdiff_dst[dst_off];
 3092              		.loc	1 480 0
 3093 4350 00000000 		or	%s61,1,(0)1
 3093      00013D45 
 3094 4358 00000000 		or	%s60,0,%s58
 3094      BA003C45 
 3095 4360 00000000 		lvl	%s61
 3095      00BD00BF 
 3096 4368 0000003D 		vldu.nc	%v61,0,%s60
 3096      BC000082 
 3097 4370 00000000 		lvl	%s57
 3097      00B900BF 
 3098 4378 00003F3C 		vfsum.s	%v60,%v63
 3098      000080EC 
 3099 4380 00000000 		or	%s61,1,(0)1
 3099      00013D45 
 3100 4388 00000000 		lvl	%s61
 3100      00BD00BF 
 3101 4390 003C3D3B 		vfadd.s	%v59,%v61,%v60
 3101      000080CC 
 3102 4398 00000000 		or	%s61,1,(0)1
 3102      00013D45 
 3103 43a0 00000000 		or	%s60,0,%s58
 3103      BA003C45 
 3104 43a8 00000000 		lvl	%s61
 3104      00BD00BF 
 3105 43b0 0000003B 		vstu.nc	%v59,0,%s60
 3105      BC000092 
 3106 43b8 00000000 		or	%s62,0,%s56
 3106      B8003E45 
 3107 43c0 00000000 		or	%s63,0,%s55
 3107      B7003F45 
 3108 43c8 68FFFFFF 		br.l	.L10.14
 3108      00000F18 
 3109              	.L10.3:
 3110 43d0 00000000 		or	%s62,0,%s63
 3110      BF003E45 
 3111 43d8 00000000 		lvl	%s61
 3111      00BD00BF 
 3112 43e0 0000003E 		vldu.nc	%v62,4,%s62
 3112      BE040082 
 3113 43e8 003E3F3F 		vfadd.s	%v63,%v63,%v62
 3113      000080CC 
 3114              	# line 478
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3115              		.loc	1 478 0
 3116 43f0 00000000 		adds.l	%s63,%s63,%s60
 3116      BCBF3F59 
 3117 43f8 00000000 		subs.w.sx	%s59,%s59,%s61
 3117      BDBB3B5A 
 3118 4400 50FFFFFF 		brge.w	0,%s59,.L10.16
 3118      BB008518 
 3119 4408 48FEFFFF 		br.l	.L10.2
 3119      00000F18 
 3120              	.L10.17:
 3121              	# line 479
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3122              		.loc	1 479 0
 3123 4410 00000000 		divs.w.sx	%s52,%s54,%s53
 3123      B5B6347B 
 3124 4418 00000000 		or	%s56,0,%s62
 3124      BE003845 
 3125 4420 00000000 		or	%s55,0,%s63
 3125      BF003745 
 3126 4428 00000000 		or	%s52,0,%s52
 3126      B4003445 
 3127 4430 00000000 		addu.l	%s52,%s52,%s51
 3127      B3B43448 
 3128 4438 00000000 		addu.l	%s52,%s52,%s50
 3128      B2B43448 
 3129 4440 00000000 		mulu.l	%s52,%s52,%s49
 3129      B1B43449 
 3130 4448 00000000 		or	%s62,0,%s62
 3130      BE003E45 
 3131 4450 00000000 		addu.l	%s62,%s52,%s62
 3131      BEB43E48 
 3132 4458 00000000 		mulu.l	%s62,%s62,%s48
 3132      B0BE3E49 
 3133 4460 00000000 		or	%s62,0,%s62
 3133      BE003E45 
 3134              	# line 478
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3135              		.loc	1 478 0
 3136 4468 00000000 		muls.l	%s62,4,%s62
 3136      BE043E6E 
 3137 4470 00000000 		adds.l	%s62,%s62,%s2
 3137      82BE3E59 
 3138 4478 00000000 		subs.w.sx	%s52,0,%s47
 3138      AF00345A 
 3139 4480 00000000 		smvl	%s57
 3139      0000392E 
 3140 4488 80000000 		mins.w.sx	%s61,%s52,%s57
 3140      B9B43D78 
 3141              	# line 480
 3142              		.loc	1 480 0
 3143 4490 00000000 		or	%s46,0,(0)1
 3143      00002E45 
 3144 4498 00000000 		lvl	%s57
 3144      00B900BF 
 3145 44a0 0000003F 		vbrdu	%v63,%s46
 3145      00AE808C 
 3146 44a8 00000000 		or	%s59,0,%s52
 3146      B4003B45 
 3147 44b0 00000000 		or	%s63,0,%s62
 3147      BE003F45 
 3148 44b8 00000000 		or	%s62,0,%s61
 3148      BD003E45 
 3149              	# line 478
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3150              		.loc	1 478 0
 3151 44c0 00000000 		muls.l	%s60,4,%s62
 3151      BE043C6E 
 3152 44c8 08FFFFFF 		br.l	.L10.3
 3152      00000F18 
 3153              	.L10.15:
 3154 44d0 40FFFFFF 		brlt.w	0,%s18,.L10.17
 3154      92008218 
 3155 44d8 58FEFFFF 		br.l	.L10.14
 3155      00000F18 
 3156              	.L10.18:
 3157 44e0 00000000 		or	%s51,0,%s60
 3157      BC003345 
 3158 44e8 00000000 		or	%s1,0,%s63
 3158      BF000145 
 3159 44f0 00000000 		or	%s63,0,%s45
 3159      AD003F45 
 3160 44f8 00000000 		or	%s3,0,%s61
 3160      BD000345 
 3161 4500 00000000 		or	%s4,0,%s60
 3161      BC000445 
 3162 4508 C8FFFFFF 		br.l	.L10.15
 3162      00000F18 
 3163              	.L10.12:
 3164              	# line 477
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 3165              		.loc	1 477 0
 3166 4510 00000000 		or	%s62,0,(0)1
 3166      00003E45 
 3167 4518 C8FFFFFF 		brlt.w	0,%s19,.L10.18
 3167      93008218 
 3168 4520 D0FDFFFF 		br.l	.L10.11
 3168      00000F18 
 3169              	.L10.19:
 3170 4528 00000000 		or	%s50,0,%s60
 3170      BC003245 
 3171 4530 00000000 		or	%s63,0,%s44
 3171      AC003F45 
 3172              	# line 476
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 3173              		.loc	1 476 0
 3174 4538 00000000 		or	%s59,0,(0)1
 3174      00003B45 
 3175 4540 00000000 		or	%s5,0,%s62
 3175      BE000545 
 3176 4548 00000000 		or	%s6,0,%s60
 3176      BC000645 
 3177 4550 00000000 		or	%s60,0,%s59
 3177      BB003C45 
 3178 4558 B8FFFFFF 		br.l	.L10.12
 3178      00000F18 
 3179              	.L10.9:
 3180              	# line 474
 474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 3181              		.loc	1 474 0
 3182 4560 00000000 		or	%s63,0,(0)1
 3182      00003F45 
 3183 4568 00000000 		stu	%s63,0(,%s58)	# *(db)
 3183      BA003F12 
 3184 4570 B8FFFFFF 		brlt.w	0,%s20,.L10.19
 3184      94008218 
 3185 4578 38FDFFFF 		br.l	.L10.8
 3185      00000F18 
 3186              	.L10.20:
 3187 4580 00000000 		or	%s57,0,%s59
 3187      BB003945 
 3188              	# line 472
 472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       float &db = pdiff_bia[bia_off];
 3189              		.loc	1 472 0
 3190 4588 00000000 		divu.l	%s57,%s57,%s43
 3190      ABB9396F 
 3191 4590 00000000 		or	%s7,0,%s58
 3191      BA000745 
 3192 4598 00000000 		or	%s22,0,%s63
 3192      BF001645 
 3193 45a0 00000000 		or	%s23,0,%s62
 3193      BE001745 
 3194 45a8 00000000 		or	%s24,0,%s59
 3194      BB001845 
 3195 45b0 00000000 		or	%s57,0,%s57
 3195      B9003945 
 3196              	# line 471
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       size_t bia_off = bia_off_f(p, g, oc);
 3197              		.loc	1 471 0
 3198 45b8 00000000 		divs.w.sx	%s63,%s42,%s41
 3198      A9AA3F7B 
 3199 45c0 00000000 		subs.w.sx	%s63,0,%s63
 3199      BF003F5A 
 3200 45c8 00000000 		or	%s62,0,%s63
 3200      BF003E45 
 3201 45d0 00000000 		muls.l	%s57,4,%s57
 3201      B904396E 
 3202 45d8 00000000 		adds.l	%s57,%s57,%s40
 3202      A8B93959 
 3203 45e0 00000000 		or	%s58,0,%s57
 3203      B9003A45 
 3204 45e8 78FFFFFF 		br.l	.L10.9
 3204      00000F18 
 3205              	.L10.5:
 3206 45f0 00000000 		or	%s60,0,(0)1
 3206      00003C45 
 3207 45f8 88FFFFFF 		brlt.w	0,%s21,.L10.20
 3207      95008218 
 3208 4600 60FCFFFF 		br.l	.L10.4
 3208      00000F18 
 3209              	.L10.21:
 3210 4608 14000000 		dldl.sx	%s42,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 3210      80002A0B 
 3211 4610 00000000 		or	%s2,0,%s4
 3211      84000245 
 3212 4618 00000000 		or	%s60,0,%s42
 3212      AA003C45 
 3213 4620 00000000 		or	%s62,0,%s60
 3213      BC003E45 
 3214              	# line 470
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 3215              		.loc	1 470 0
 3216 4628 00000000 		or	%s59,0,(0)1
 3216      00003B45 
 3217              	# line 471
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       size_t bia_off = bia_off_f(p, g, oc);
 3218              		.loc	1 471 0
 3219 4630 00000000 		divs.w.sx	%s21,%s42,%s41
 3219      A9AA157B 
 3220 4638 00000000 		or	%s43,0,%s41
 3220      A9002B45 
 3221              	# line 470
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 3222              		.loc	1 470 0
 3223 4640 00000000 		subs.w.sx	%s60,0,%s41
 3223      A9003C5A 
 3224 4648 00000000 		or	%s63,0,%s60
 3224      BC003F45 
 3225              	# line 476
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 3226              		.loc	1 476 0
 3227 4650 04000000 		dldl.sx	%s20,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 3227      8000140B 
 3228 4658 00000000 		subs.w.sx	%s44,0,%s20
 3228      94002C5A 
 3229              	# line 477
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 3230              		.loc	1 477 0
 3231 4660 18000000 		dldl.sx	%s19,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 3231      8000130B 
 3232 4668 00000000 		subs.w.sx	%s45,0,%s19
 3232      93002D5A 
 3233              	# line 478
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             const size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3234              		.loc	1 478 0
 3235 4670 1C000000 		dldl.sx	%s18,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 3235      8000120B 
 3236 4678 00000000 		or	%s48,0,%s18
 3236      92003045 
 3237 4680 00000000 		subs.w.sx	%s47,0,%s18
 3237      92002F5A 
 3238              	# line 479
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             db += pdiff_dst[dst_off];
 3239              		.loc	1 479 0
 3240 4688 14000000 		dldl.sx	%s58,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 3240      80003A0B 
 3241 4690 00000000 		or	%s60,0,%s58
 3241      BA003C45 
 3242 4698 00000000 		or	%s61,0,%s60
 3242      BC003D45 
 3243 46a0 00000000 		dldl.sx	%s53,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3243      8000350B 
 3244 46a8 18000000 		dldl.sx	%s0,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 3244      8000000B 
 3245 46b0 00000000 		or	%s49,0,%s0
 3245      80003145 
 3246              	# line 470
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 3247              		.loc	1 470 0
 3248 46b8 00000000 		or	%s54,0,(0)1
 3248      00003645 
 3249 46c0 30FFFFFF 		br.l	.L10.5
 3249      00000F18 
 3250              	.L10.22:
 3251 46c8 00000000 		ldl.sx	%s41,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3251      80002903 
 3252 46d0 38FFFFFF 		brlt.w	0,%s41,.L10.21
 3252      A9008218 
 3253 46d8 08000000 		br.l	.L10.6
 3253      00000F18 
 3254              	.L10.6:
 3255              	# line 487
 481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             //db += pdiff_dst[dst_off_f(p, mb, g, oc, oh, ow)];
 482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         }
 484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       }
 485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     }
 486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****   }
 487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** }
 3256              		.loc	1 487 0
 3257              	# Start of epilogue codes
 3258 46e0 30000000 		ld	%s18,48(,%fp)
 3258      89001201 
 3259 46e8 38000000 		ld	%s19,56(,%fp)
 3259      89001301 
 3260 46f0 40000000 		ld	%s20,64(,%fp)
 3260      89001401 
 3261 46f8 48000000 		ld	%s21,72(,%fp)
 3261      89001501 
 3262 4700 50000000 		ld	%s22,80(,%fp)
 3262      89001601 
 3263 4708 58000000 		ld	%s23,88(,%fp)
 3263      89001701 
 3264 4710 60000000 		ld	%s24,96(,%fp)
 3264      89001801 
 3265 4718 68000000 		ld	%s25,104(,%fp)
 3265      89001901 
 3266 4720 70000000 		ld	%s26,112(,%fp)
 3266      89001A01 
 3267 4728 78000000 		ld	%s27,120(,%fp)
 3267      89001B01 
 3268 4730 80000000 		ld	%s28,128(,%fp)
 3268      89001C01 
 3269 4738 88000000 		ld	%s29,136(,%fp)
 3269      89001D01 
 3270 4740 90000000 		ld	%s30,144(,%fp)
 3270      89001E01 
 3271 4748 00000000 		or	%sp,0,%fp
 3271      89000B45 
 3272              		.cfi_def_cfa	11,8
 3273 4750 18000000 		ld	%got,0x18(,%sp)
 3273      8B000F01 
 3274 4758 20000000 		ld	%plt,0x20(,%sp)
 3274      8B001001 
 3275 4760 08000000 		ld	%lr,0x8(,%sp)
 3275      8B000A01 
 3276 4768 00000000 		ld	%fp,0x0(,%sp)
 3276      8B000901 
 3277 4770 00000000 		b.l	(,%lr)
 3277      8A000F19 
 3278              	.L10.1:
 3279              	# line 467
 467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp **** 
 3280              		.loc	1 467 0
 3281 4778 48000000 		ldl.zx	%s63,72(,%s0)	# *(p).dir
 3281      8000BF03 
 3282 4780 00000000 		adds.w.sx	%s63,0,%s63
 3282      BF003F4A 
 3283 4788 04000000 		lea	%s62,4
 3283      00003E06 
 3284 4790 00000000 		and	%s62,%s63,%s62
 3284      BEBF3E44 
 3285 4798 48FFFFFF 		breq.w	0,%s62,.L10.6
 3285      BE008418 
 3286 47a0 28FFFFFF 		br.l	.L10.22
 3286      00000F18 
 3287              	.L10.23:
 3288 47a8 00000000 		or	%s0,0,%s1
 3288      81000045 
 3289 47b0 00000000 		or	%s40,0,%s19
 3289      93002845 
 3290 47b8 00000000 		or	%s4,0,%s2
 3290      82000445 
 3291 47c0 B8FFFFFF 		br.l	.L10.1
 3291      00000F18 
 3292              	.L10.24:
 3293              	# line 452
 452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****     for (int oc = 0; oc < OC/G; ++oc) {
 3294              		.loc	1 452 0
 3295 47c8 00000000 		ldl.sx	%s18,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 3295      81001203 
 3296 47d0 00000000 		adds.w.sx	%s5,1,%s5
 3296      8501054A 
 3297 47d8 38030000 		brlt.w	%s5,%s18,.L10.25
 3297      92858218 
 3298 47e0 C8FFFFFF 		br.l	.L10.23
 3298      00000F18 
 3299              	.L10.26:
 3300              	# line 453
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 3301              		.loc	1 453 0
 3302 47e8 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 3302      81003F03 
 3303 47f0 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 3303      81003E03 
 3304 47f8 00000000 		divs.w.sx	%s62,%s63,%s62
 3304      BEBF3E7B 
 3305 4800 00000000 		adds.w.sx	%s6,1,%s6
 3305      8601064A 
 3306 4808 C8020000 		brlt.w	%s6,%s62,.L10.27
 3306      BE868218 
 3307 4810 B8FFFFFF 		br.l	.L10.24
 3307      00000F18 
 3308              	.L10.28:
 3309              	# line 454
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int kh = 0; kh < KH; ++kh) {
 3310              		.loc	1 454 0
 3311 4818 08000000 		ldl.sx	%s63,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 3311      81003F03 
 3312 4820 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 3312      81003E03 
 3313 4828 00000000 		divs.w.sx	%s62,%s63,%s62
 3313      BEBF3E7B 
 3314 4830 00000000 		adds.w.sx	%s7,1,%s7
 3314      8701074A 
 3315 4838 68020000 		brlt.w	%s7,%s62,.L10.29
 3315      BE878218 
 3316 4840 A8FFFFFF 		br.l	.L10.26
 3316      00000F18 
 3317              	.L10.30:
 3318 4848 00000000 		or	%s61,0,%s63
 3318      BF003D45 
 3319 4850 C8FFFFFF 		br.l	.L10.28
 3319      00000F18 
 3320              	.L10.31:
 3321              	# line 455
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 3322              		.loc	1 455 0
 3323 4858 20000000 		ldl.sx	%s18,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 3323      81001203 
 3324 4860 00000000 		adds.w.sx	%s29,1,%s29
 3324      9D011D4A 
 3325 4868 00020000 		brlt.w	%s29,%s18,.L10.32
 3325      929D8218 
 3326 4870 D8FFFFFF 		br.l	.L10.30
 3326      00000F18 
 3327              	.L10.33:
 3328 4878 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 3328      89000101 
 3329 4880 E0FFFFFF 		ld	%s63,-32(,%fp)	# restore 
 3329      89003F01 
 3330 4888 B8FFFFFF 		ld	%s7,-72(,%fp)	# restore 
 3330      89000701 
 3331 4890 C0FFFFFF 		ld	%s6,-64(,%fp)	# restore 
 3331      89000601 
 3332 4898 C8FFFFFF 		ld	%s5,-56(,%fp)	# restore 
 3332      89000501 
 3333 48a0 D8FFFFFF 		ld	%s2,-40(,%fp)	# restore 
 3333      89000201 
 3334 48a8 D0FFFFFF 		ld	%s3,-48(,%fp)	# restore 
 3334      89000301 
 3335 48b0 A8FFFFFF 		br.l	.L10.31
 3335      00000F18 
 3336              	.L10.34:
 3337 48b8 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 3337      89000101 
 3338 48c0 E0FFFFFF 		ld	%s0,-32(,%fp)	# restore 
 3338      89000001 
 3339 48c8 D8FFFFFF 		ld	%s2,-40(,%fp)	# restore 
 3339      89000201 
 3340 48d0 D0FFFFFF 		ld	%s3,-48(,%fp)	# restore 
 3340      89000301 
 3341 48d8 C8FFFFFF 		ld	%s5,-56(,%fp)	# restore 
 3341      89000501 
 3342 48e0 C0FFFFFF 		ld	%s6,-64(,%fp)	# restore 
 3342      89000601 
 3343 48e8 B8FFFFFF 		ld	%s7,-72(,%fp)	# restore 
 3343      89000701 
 3344              	.L10.35:
 3345 48f0 00000000 		or	%s63,0,%s23
 3345      97003F45 
 3346 48f8 E8FFFFFF 		st	%s1,-24(,%fp)	# spill 
 3346      89000111 
 3347 4900 E0FFFFFF 		st	%s0,-32(,%fp)	# spill 
 3347      89000011 
 3348 4908 D8FFFFFF 		st	%s2,-40(,%fp)	# spill 
 3348      89000211 
 3349 4910 D0FFFFFF 		st	%s3,-48(,%fp)	# spill 
 3349      89000311 
 3350 4918 C8FFFFFF 		st	%s5,-56(,%fp)	# spill 
 3350      89000511 
 3351 4920 C0FFFFFF 		st	%s6,-64(,%fp)	# spill 
 3351      89000611 
 3352 4928 B8FFFFFF 		st	%s7,-72(,%fp)	# spill 
 3352      89000711 
 3353              	# line 457
 457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             float &dw = pdiff_wei[wei_off];
 3354              		.loc	1 457 0
 3355 4930 14000000 		ldl.sx	%s62,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 3355      81003E03 
 3356 4938 00000000 		or	%s62,0,%s62
 3356      BE003E45 
 3357 4940 00000000 		mulu.l	%s62,%s62,%s24
 3357      98BE3E49 
 3358 4948 00000000 		ldl.sx	%s61,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 3358      81003D03 
 3359 4950 00000000 		or	%s61,0,%s61
 3359      BD003D45 
 3360 4958 00000000 		divu.l	%s62,%s62,%s61
 3360      BDBE3E6F 
 3361 4960 00000000 		addu.l	%s62,%s62,%s25
 3361      99BE3E48 
 3362 4968 08000000 		ldl.sx	%s60,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 3362      81003C03 
 3363 4970 00000000 		or	%s60,0,%s60
 3363      BC003C45 
 3364 4978 00000000 		mulu.l	%s60,%s62,%s60
 3364      BCBE3C49 
 3365 4980 00000000 		divu.l	%s61,%s60,%s61
 3365      BDBC3D6F 
 3366 4988 00000000 		addu.l	%s61,%s61,%s26
 3366      9ABD3D48 
 3367 4990 20000000 		ldl.sx	%s62,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 3367      81003E03 
 3368 4998 00000000 		or	%s62,0,%s62
 3368      BE003E45 
 3369 49a0 00000000 		mulu.l	%s62,%s61,%s62
 3369      BEBD3E49 
 3370 49a8 00000000 		addu.l	%s62,%s62,%s27
 3370      9BBE3E48 
 3371 49b0 24000000 		ldl.sx	%s61,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 3371      81003D03 
 3372 49b8 00000000 		or	%s61,0,%s61
 3372      BD003D45 
 3373 49c0 00000000 		mulu.l	%s61,%s62,%s61
 3373      BDBE3D49 
 3374 49c8 00000000 		addu.l	%s63,%s61,%s63
 3374      BFBD3F48 
 3375              	# line 458
 458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             dw = 0;
 3376              		.loc	1 458 0
 3377 49d0 00000000 		mulu.l	%s63,4,%s63
 3377      BF043F49 
 3378 49d8 00000000 		adds.l	%s4,%s63,%s28
 3378      9CBF0459 
 3379              	# line 459
 459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             ker( p, pdiff_dst, psrc, dw, g, oc, ic, kh, kw);
 3380              		.loc	1 459 0
 3381 49e0 00000000 		or	%s63,0,(0)1
 3381      00003F45 
 3382 49e8 00000000 		stu	%s63,0(,%s4)	# *(dw)
 3382      84003F12 
 3383              	# line 460
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 3384              		.loc	1 460 0
 3385 49f0 F0000000 		st	%s29,240(,%sp)
 3385      8B001D11 
 3386 49f8 F8000000 		st	%s23,248(,%sp)
 3386      8B001711 
 3387 4a00 00000000 		lea	%s12,_ZZN4conv15refconv_2_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_RfiiiiiE_clES2_S
 3387      00000C06 
 3388 4a08 00000000 		and	%s12,%s12,(32)0
 3388      608C0C44 
 3389 4a10 00000000 		lea.sl	%s12,_ZZN4conv15refconv_2_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_RfiiiiiE_clES
 3389      8C008C06 
 3390 4a18 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv15refconv_2_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_PKfS6_Rfiiii
 3390      8C000A08 
 3391              	# line 456
 456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****             size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 3392              		.loc	1 456 0
 3393 4a20 00000000 		adds.w.sx	%s30,1,%s30
 3393      9E011E4A 
 3394 4a28 00000000 		adds.w.sx	%s23,1,%s23
 3394      9701174A 
 3395 4a30 88FEFFFF 		brgt.w	0,%s30,.L10.34
 3395      9E008118 
 3396 4a38 40FEFFFF 		br.l	.L10.33
 3396      00000F18 
 3397              	.L10.36:
 3398 4a40 00000000 		or	%s27,0,%s29
 3398      9D001B45 
 3399 4a48 00000000 		subs.w.sx	%s18,0,%s18
 3399      9200125A 
 3400 4a50 00000000 		or	%s30,0,%s18
 3400      92001E45 
 3401 4a58 00000000 		or	%s0,0,%s63
 3401      BF000045 
 3402 4a60 90FEFFFF 		br.l	.L10.35
 3402      00000F18 
 3403              	.L10.32:
 3404 4a68 00000000 		or	%s23,0,(0)1
 3404      00001745 
 3405 4a70 24000000 		ldl.sx	%s18,36(,%s1)	# *(p).__b_N4conv6desc_tE.kw
 3405      81001203 
 3406 4a78 C8FFFFFF 		brlt.w	0,%s18,.L10.36
 3406      92008218 
 3407 4a80 D8FDFFFF 		br.l	.L10.31
 3407      00000F18 
 3408              	.L10.37:
 3409 4a88 00000000 		or	%s26,0,%s7
 3409      87001A45 
 3410 4a90 00000000 		or	%s63,0,%s61
 3410      BD003F45 
 3411 4a98 D0FFFFFF 		br.l	.L10.32
 3411      00000F18 
 3412              	.L10.29:
 3413              	# line 455
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 3414              		.loc	1 455 0
 3415 4aa0 00000000 		or	%s29,0,(0)1
 3415      00001D45 
 3416 4aa8 20000000 		ldl.sx	%s18,32(,%s1)	# *(p).__b_N4conv6desc_tE.kh
 3416      81001203 
 3417 4ab0 D8FFFFFF 		brlt.w	0,%s18,.L10.37
 3417      92008218 
 3418 4ab8 60FDFFFF 		br.l	.L10.28
 3418      00000F18 
 3419              	.L10.38:
 3420 4ac0 00000000 		or	%s25,0,%s6
 3420      86001945 
 3421 4ac8 D8FFFFFF 		br.l	.L10.29
 3421      00000F18 
 3422              	.L10.27:
 3423              	# line 454
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****         for (int kh = 0; kh < KH; ++kh) {
 3424              		.loc	1 454 0
 3425 4ad0 00000000 		or	%s7,0,(0)1
 3425      00000745 
 3426 4ad8 08000000 		ldl.sx	%s63,8(,%s1)	# *(p).__b_N4conv6desc_tE.ic
 3426      81003F03 
 3427 4ae0 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 3427      81003E03 
 3428 4ae8 00000000 		divs.w.sx	%s62,%s63,%s62
 3428      BEBF3E7B 
 3429 4af0 D0FFFFFF 		brlt.w	0,%s62,.L10.38
 3429      BE008218 
 3430 4af8 F0FCFFFF 		br.l	.L10.26
 3430      00000F18 
 3431              	.L10.39:
 3432 4b00 00000000 		or	%s24,0,%s5
 3432      85001845 
 3433 4b08 C8FFFFFF 		br.l	.L10.27
 3433      00000F18 
 3434              	.L10.25:
 3435              	# line 453
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 3436              		.loc	1 453 0
 3437 4b10 00000000 		or	%s6,0,(0)1
 3437      00000645 
 3438 4b18 14000000 		ldl.sx	%s63,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 3438      81003F03 
 3439 4b20 00000000 		ldl.sx	%s62,0(,%s1)	# *(p).__b_N4conv6desc_tE.g
 3439      81003E03 
 3440 4b28 00000000 		divs.w.sx	%s62,%s63,%s62
 3440      BEBF3E7B 
 3441 4b30 D0FFFFFF 		brlt.w	0,%s62,.L10.39
 3441      BE008218 
 3442 4b38 90FCFFFF 		br.l	.L10.24
 3442      00000F18 
 3443              	.L10.0:
 3444              	# line 460
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv2.cpp ****           }
 3445              		.loc	1 460 0
 3446 4b40 00000000 		adds.l	%s61,%fp,(60)1
 3446      3C893D59 
 3447 4b48 00000000 		or	%s1,0,%s0
 3447      80000145 
 3448 4b50 00000000 		or	%s2,0,%s4
 3448      84000245 
 3449 4b58 00000000 		or	%s3,0,%s63
 3449      BF000345 
 3450 4b60 00000000 		or	%s19,0,%s40
 3450      A8001345 
 3451 4b68 A8FFFFFF 		br.l	.L10.25
 3451      00000F18 
 3452              		.cfi_endproc
 3453              		.set	.L.11.2auto_size,	0xfffffffffffffd80	# 640 Bytes
 3455              	# ============ End  conv::refconv_2_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
