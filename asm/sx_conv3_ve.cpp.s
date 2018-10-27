   1              		.ident "nc++ 1.5.2 (Build 11:19:31 Oct  2 2018)"
   2              		.file "sx_conv3_ve.cpp"
   3              		.file 1 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp"
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
  42              	# ============ Begin  div_floor(int, int) ============
  43              		.text
  44              		.balign 16
  45              	# line 176
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** \file
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * Fast integer division, rounding toward -ve infinity.
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * If it compiles, the functions are correct (static assertions).
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * Remainder-based tests were branchless AND no cmov (and short).
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * Older sign-based fixups are in dev/idiv_dev.hpp
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  */
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #ifndef IDIV_HPP
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #define IDIV_HPP
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** //#include <limits> // some bit-twiddle hacks want # bits in int
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** // fwd decl
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** Truncate integer \c n / \c d \f$\forall d>0, \mathrm{any }n\f$ toward \f$-\infty\f$,
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * unchecked.  These are fast, inlinable constexpr 1-line functions.
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * Use prior knowledge of signed-ness to choose the correct [fastest!]
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * function call.
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * Intel+gcc (old versions!)
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * | Routine   | \~instrns | \~bytes (hex) | trunc \f$\rightarrow -infty\f$ |
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * |:------------- |:-------- |:------------ |:------------------------- |
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * | n/d in C++11 or C99 | 1   | ??            | n>0, d>0 |
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * | **div_floor** | 5         | 0a            | any n, d>0 |
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * | div_floorn    | 7         | 1f            | any n, d<0 |
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * | div_floorx    | 15        | 40            | any n, any d!=0 |
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  */
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** constexpr int div_floor( int const n, int const d );
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** Euclidean remainder for \c d> 0 returns \b\c r in [0,k)
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * st \c n \c =d*k+r for some int \c k. [\c k is div_floor(n,d)]. */
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** constexpr int rem_floor( int const n, int const d );
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** Truncate integer \c n / \c d \f$\forall d<0, \mathrm{any }n\f$ toward \f$-\infty\f$,
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * unchecked. */
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** constexpr int div_floorn( int const n, int const d );
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** For \c d<0, returns \c r in (d,0] st \c n \c =d*k+r. This is so
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \f$n=d*\mathrm{div_{floor*}}(n,d) + \mathrm{rem_{floor*}}\f$ holds. */
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** inline constexpr int rem_floorn( int const n, int const d );
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** Truncate integer \c n / \c d (any signs) \f$\forall n, d!=0\f$
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * toward \f$-\infty\f$. About 15 branchless instrns on Intel w/ cmov. */
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** constexpr int div_floorx( int const n, int const d );
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** return d>0? rem_floor(n,d): rem_floorn(n,d). Returned remainder
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * is always in open range including zero until \c d, for +ve or -ve \c d. */
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** inline constexpr int rem_floorx( int const n, int const d );
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** // normal C99 and C++11 integer division works like this:
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  5/3 == 1, "oops"); // mod:2
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  4/3 == 1, "oops"); // mod:1
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  3/3 == 1, "oops"); // mod:0
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  2/3 == 0, "oops"); // mod:2
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  1/3 == 0, "oops"); // mod:1
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  0/3 == 0, "oops"); // mod:0
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -1/3 == 0, "oops"); // want "-1", mod:-1 
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -2/3 == 0, "oops"); // want "-1", mod:-2
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -3/3 ==-1, "oops"); // want "-1", mod:0  OK
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -4/3 ==-1, "oops"); // want "-2", mod:-1
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  5/-3 ==-1, "oops"); // mod:2  want: -2
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  4/-3 ==-1, "oops"); // mod:1  want: -2
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  3/-3 ==-1, "oops"); // mod:0  want: -1 (OK)
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  2/-3 == 0, "oops"); // mod:2  want: -1
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  1/-3 == 0, "oops"); // mod:1  want: -1
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  0/-3 == 0, "oops"); // mod:0  want: 0
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -1/-3 == 0, "oops"); // mod:-1 want: 0 (OK)
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -2/-3 == 0, "oops"); // mod:-2 want: 0 (OK)
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -3/-3 == 1, "oops"); // mod:0  want: 1 (OK)
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -4/-3 == 1, "oops"); // mod:-1 want: 1 (OK)
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** // and modulus... (for C++11 / C99 at least)
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  5%3 == 2, "oops");
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  4%3 == 1, "oops");
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  3%3 == 0, "oops");
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  2%3 == 2, "oops");
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  1%3 == 1, "oops");
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  0%3 == 0, "oops");
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -1%3 ==-1, "oops"); // -1/3*3 + X = -1 --> X = -1 - (0)
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -2%3 ==-2, "oops");
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -3%3 == 0, "oops");
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  5%-3 == 2, "oops");
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  4%-3 == 1, "oops");
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  3%-3 == 0, "oops");
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  2%-3 == 2, "oops");
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  1%-3 == 1, "oops");
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert(  0%-3 == 0, "oops");
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -1%-3 ==-1, "oops");
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -2%-3 ==-2, "oops");
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -3%-3 == 0, "oops");
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** static_assert( -4%-3 ==-1, "oops");
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** For \c b!=0, return nonzero if \c a!=0 and \c sign(a)!=sign(b).
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \pre b!=0 (unchecked)
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * /note this is not a general-purpose "non-zero and different-signs"
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * test.
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * If b==0, return result is <em>don't care</em>.  This is why
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * it has a strange name.  Machine code is pretty simple for Intel:
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \code 
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * 0000000000000000 <test_nzdiffsign_bnz(int, int)>:
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 0:	31 fe                	xor    %edi,%esi
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 2:	c1 fe 1f             	sar    $0x1f,%esi
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 5:	89 f0                	mov    %esi,%eax
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 7:	21 f8                	and    %edi,%eax
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 9:	c3                   	retq   
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \endcode
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  */
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** inline constexpr int nzdiffsign_bnz( int const a, int const b )
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** {
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #if 1
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     return a & ((a^b)<0? ~0: 0); // return a or 0
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     /* 0000000000000000 <test_nzdiffsign_bnz(int, int)>:
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 0:	31 fe                	xor    %edi,%esi
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 2:	c1 fe 1f             	sar    $0x1f,%esi
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 5:	89 f0                	mov    %esi,%eax
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 7:	21 f8                	and    %edi,%eax
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 9:	c3                   	retq   
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****      */
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #elif 0 && !defined(DOXYGEN_SHOULD_SKIP_THIS)
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     //return ((a^b)<0? a: 0);                   // return a or 0 
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     /*
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****        0000000000000000 <test_nzdiffsign_bnz(int, int)>:
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 0:	31 fe                	xor    %edi,%esi
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 2:	b8 00 00 00 00       	mov    $0x0,%eax
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 7:	0f 48 c7             	cmovs  %edi,%eax
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** a:	c3                   	retq   
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****      */
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     //return ((a^b)<0? (a!=0): 0);              // return 1 or 0
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     //return (a!=0) & ((a^b)<0);                // return 1 or 0
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     /*
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****        0000000000000000 <test_nzdiffsign_bnz(int, int)>:
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 0:	31 fe                	xor    %edi,%esi
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 2:	c1 ee 1f             	shr    $0x1f,%esi
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 5:	85 ff                	test   %edi,%edi
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 7:	0f 95 c0             	setne  %al
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** a:	21 f0                	and    %esi,%eax
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** c:	c3                   	retq   
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****      */
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #elif (-1 >> 1 == -1)
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     return ( ((a^b)>>31) & a ); // good, equiv  a & ((a^b)<0? ~0: 0)
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     //return a!=0 && b!=0 && (a^b)<0; // ok, but long
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     //return ( ((a^b)>>31) & (a!=0) );          // return 1 or 0
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     //return (a & ((a^b)<0? ~0: 0)) != 0;       // return 1 or 0
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     /* 
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 0:	31 fe                	xor    %edi,%esi
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 2:	31 c0                	xor    %eax,%eax
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 4:	c1 fe 1f             	sar    $0x1f,%esi
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 7:	85 ff                	test   %edi,%edi
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** 9:	0f 95 c0             	setne  %al
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** c:	21 f0                	and    %esi,%eax
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** e:	c3                   	retq   
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****      */
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #else
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #error "bit-twiddling hacks insufficient"
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #endif
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** }
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** /** 
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * In C99 and C++11 integer division always truncates -ves toward 0.
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * so:
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \verbatim
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *         5/3=1,     4/3=1,   3/3=1
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *         2/3=0,     1/3=0,   0/3=0
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * , but **-1/3=0**, -2/3=0,  -3/3=-1
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \endverbatim
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * When dealing with integer inequalities, we often need to
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * always truncate the division downward, towards \f$-\infty\f$.
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \pre d > 0 (unchecked)
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \return n/d rounded downward toward \f$-\infty\f$
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  * \note This fast case often applies to strided "forward"
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *       index calculations.  Any-valued strides should use
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  *       \c div_floorx. Negative strides can use \c div_floorn.
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****  */
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** inline constexpr int div_floor( int const n, int const d )
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** {
  46              		.loc	39 176 0
  47              		.globl	div_floor(int, int)
  48              		.weak div_floor(int, int)
  50 0000 B8010000 		.long	.L_FE.1-8-.
  50      00000000 
  51              	div_floor(int, int):
  52              		.cfi_startproc
  53 0008 00000000 		st	%fp,0x0(,%sp)
  53      8B000911 
  54              		.cfi_def_cfa_offset	0
  55              		.cfi_offset	9,0
  56 0010 08000000 		st	%lr,0x8(,%sp)
  56      8B000A11 
  57 0018 18000000 		st	%got,0x18(,%sp)
  57      8B000F11 
  58 0020 20000000 		st	%plt,0x20(,%sp)
  58      8B001011 
  59 0028 00000000 		or	%fp,0,%sp
  59      8B000945 
  60              		.cfi_def_cfa_register	9
  61 0030 58000000 		st	%s23,88(,%fp)
  61      89001711 
  62 0038 20FEFFFF 		lea	%s13,.L.1.2auto_size&0xffffffff
  62      00000D06 
  63 0040 00000000 		and	%s13,%s13,(32)0
  63      608D0D44 
  64 0048 FFFFFFFF 		lea.sl	%sp,.L.1.2auto_size>>32(%fp,%s13)
  64      8D898B06 
  65 0050 48000000 		brge.l.t	%sp,%sl,.L0.EoP
  65      888B3518 
  66 0058 18000000 		ld	%s61,0x18(,%tp)
  66      8E003D01 
  67 0060 00000000 		or	%s62,0,%s0
  67      80003E45 
  68 0068 3B010000 		lea	%s63,0x13b
  68      00003F06 
  69 0070 00000000 		shm.l	%s63,0x0(%s61)
  69      BD033F31 
  70 0078 08000000 		shm.l	%sl,0x8(%s61)
  70      BD030831 
  71 0080 10000000 		shm.l	%sp,0x10(%s61)
  71      BD030B31 
  72 0088 00000000 		monc
  72      0000003F 
  73 0090 00000000 		or	%s0,0,%s62
  73      BE000045 
  74              	.L0.EoP:
  75              	# End of prologue codes
  76 0098 F8FFFFFF 		st	%s1,-8(,%fp)	# spill 
  76      89000111 
  77 00a0 F0FFFFFF 		st	%s0,-16(,%fp)	# spill 
  77      89000011 
  78 00a8 00000000 		lea	%s0,div_floor(int, int)@LO
  78      00000006 
  79 00b0 00000000 		and	%s0,%s0,(32)0
  79      60800044 
  80 00b8 00000000 		lea.sl	%s0,div_floor(int, int)@HI(,%s0)
  80      80008006 
  81 00c0 08000000 		ld	%s1,8(,%fp)	# ptr
  81      89000101 
  82 00c8 00000000 		lea	%s12,__ftrace_func_enter@LO
  82      00000C06 
  83 00d0 00000000 		and	%s12,%s12,(32)0
  83      608C0C44 
  84 00d8 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
  84      8C008C06 
  85 00e0 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
  85      8C000A08 
  86 00e8 F8FFFFFF 		ld	%s1,-8(,%fp)	# restore 
  86      89000101 
  87 00f0 F0FFFFFF 		ld	%s0,-16(,%fp)	# restore 
  87      89000001 
  88              	# line 178
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #if 1
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     return (n/d) - (n%d<0? 1: 0);
  89              		.loc	39 178 0
  90 00f8 00000000 		divs.w.sx	%s63,%s0,%s1
  90      81803F7B 
  91 0100 00000000 		muls.w.sx	%s1,%s1,%s63
  91      BF81014B 
  92 0108 00000000 		subs.w.sx	%s1,%s0,%s1
  92      8180015A 
  93 0110 A0000000 		brgt.w	0,%s1,.L0.0
  93      81008118 
  94 0118 00000000 		or	%s62,0,(0)1
  94      00003E45 
  95 0120 08000000 		br.l	.L0.1
  95      00000F18 
  96              	.L0.1:
  97 0128 00000000 		subs.w.sx	%s23,%s63,%s62
  97      BEBF175A 
  98 0130 00000000 		lea	%s0,div_floor(int, int)@LO
  98      00000006 
  99 0138 00000000 		and	%s0,%s0,(32)0
  99      60800044 
 100 0140 00000000 		lea.sl	%s0,div_floor(int, int)@HI(,%s0)
 100      80008006 
 101 0148 08000000 		ld	%s1,8(,%fp)	# ptr
 101      89000101 
 102 0150 00000000 		lea	%s12,__ftrace_func_exit@LO
 102      00000C06 
 103 0158 00000000 		and	%s12,%s12,(32)0
 103      608C0C44 
 104 0160 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 104      8C008C06 
 105 0168 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 105      8C000A08 
 106 0170 00000000 		or	%s0,0,%s23
 106      97000045 
 107              	# Start of epilogue codes
 108 0178 58000000 		ld	%s23,88(,%fp)
 108      89001701 
 109 0180 00000000 		or	%sp,0,%fp
 109      89000B45 
 110              		.cfi_def_cfa	11,8
 111 0188 18000000 		ld	%got,0x18(,%sp)
 111      8B000F01 
 112 0190 20000000 		ld	%plt,0x20(,%sp)
 112      8B001001 
 113 0198 08000000 		ld	%lr,0x8(,%sp)
 113      8B000A01 
 114 01a0 00000000 		ld	%fp,0x0(,%sp)
 114      8B000901 
 115 01a8 00000000 		b.l	(,%lr)
 115      8A000F19 
 116              	.L0.0:
 117 01b0 00000000 		or	%s62,1,(0)1
 117      00013E45 
 118 01b8 70FFFFFF 		br.l	.L0.1
 118      00000F18 
 119              		.cfi_endproc
 120              		.set	.L.1.2auto_size,	0xfffffffffffffe20	# 480 Bytes
 122              	.L_FE.1:
 123 01c0 6469765F 		.string	"div_floor\000\000\000\000\000\000"
 123      666C6F6F 
 123      72000000 
 123      00000000 
 124              	# ============ End  div_floor(int, int) ============
 125              	# ============ Begin  conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator() const
 126              		.balign 16
 127              	# line 2304
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /*******************************************************************************
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * Copyright 2017 NEC Laboratories America
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** *
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * Licensed under the Apache License, Version 2.0 (the "License");
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * you may not use this file except in compliance with the License.
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * You may obtain a copy of the License at
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** *
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** *     http://www.apache.org/licenses/LICENSE-2.0
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** *
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * Unless required by applicable law or agreed to in writing, software
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * distributed under the License is distributed on an "AS IS" BASIS,
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * See the License for the specific language governing permissions and
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** * limitations under the License.
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** *******************************************************************************/
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** \file
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * sx vectorization ref_conv3.cpp */
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if defined(__ve)
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #include "conv/conv.hpp"
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #include "idiv.hpp"
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //#include <iostream>
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //using namespace std;
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** namespace conv {
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** // BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** extern void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** extern void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** extern void sxconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** extern void sxconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** void refconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static void chk( bool cond, char const* msg, char const* file, int const lineno ){
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static bool trivial( int const verb, bool const cond, char const* msg,
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                      char const* file, int const lineno ){
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (verb > verbose && cond){
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         printf("@@@ trivial: %s : [%s:%d]\n", msg, file, lineno); fflush(stdout);
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     return cond;
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //#define MUST( COND )
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define MUST( COND )    chk(    (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PRINTF(...)     do{ printf(__VA_ARGS__); fflush(stdout);}while(0)
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define TRIVIAL( COND ) COND
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //#define TRIVIAL( COND ) trivial(1, (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if defined(NDEBUG)
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define DPRINTF(...)
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define DMUST(...)
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define DPRINTF(...)  do{printf(__VA_ARGS__); fflush(stdout);}while(0)
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define DMUST(...)   MUST(__VA_ARGS__)
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** greatest common denominator, a,b > 0 */
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static int gcd(int a, int b)
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (;;)
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     {
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         if (a == 0) return b;
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         b %= a;
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         if (b == 0) return a;
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         a %= b;
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** lowest common multiple, a,b > 0 */
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static int lcm(int a, int b)
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int temp = gcd(a, b);
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     return temp ? (a / temp * b) : 0;
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** Solve for integers j, k and g=gcd(a,b) such that ja + ky = g,
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * where a,b are integer constants.
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * This is a linear equation in integers, and is solved
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * via the extended Euclid algorithm.
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  */
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static void inline extendedEuclid( int& k, int a, int& j, int b, int& g)
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int x = 1, y = 0;
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int xLast = 0, yLast = 1;
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int q, r, m, n;
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   while (a != 0) 
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   {
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     q = b / a;
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     r = b % a;
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     m = xLast - q * x;
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     n = yLast - q * y;
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     xLast = x; 
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     yLast = y;
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     x = m; 
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     y = n;
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     b = a; 
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     a = r;
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   g = b;
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   k = xLast;
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   j = yLast;
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** hoist `A+iB in range [C,D)` condition out of a loop for i in [imin,imax].
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * When 
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * Original:
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * \code
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * for(i=imin; i<imax; ++i){       // original loop
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   if( ApiB < c || ApiB > d ) continue;
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   // Loop Body
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * }
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * \endcode
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * Transformed:
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * \code
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * int const ibeg, iend;
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * for(i=ibeg; i<iend; ++i){       // original loop
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   int const ApiB = a + i*b;
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   // GONE: if( ApiB < c || ApiB > d ) continue;
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   // Loop Body
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * }
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * \endcode
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * \pre \c b > 0, (c, d?)
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  */
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static inline void hoist_ApiB_in( int& beg, int& end,
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const int imin, const int imax,
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const int a, const int b, const int c, const int d)
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( b > 0 );
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     beg = div_floor( c-a+b-1, b );
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( a + (beg-1)*b < c );
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( a + (beg  )*b >= c );
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( beg < imin ) beg = imin;
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     end = div_floor( d-a+b-1, b );
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( a + (end-1)*b < d );
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( a + (end  )*b >= d );
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( end > imax ) end = imax;
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** Integer \c i so A-iB is <em>just below</em> \c target.
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * \pre \c B>0 (unchecked). */
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static inline int AmiB_lt_target( const int a, const int b, const int target)
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int ibelow = a-target + b;
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // XXX use idiv.hpp here too
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( ibelow >= 0 ){
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ibelow /= b;
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //ibelow = div_floor( ibelow, b );
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     } else {
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         int const fmul=(-ibelow + b)/b;
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //RT_ASSERT( ibelow + fmul*b >= 0 );
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //RT_ASSERT( fmul == div_floor( -ibelow, b )+1 );
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ibelow = (ibelow + fmul                    *b) / b - fmul; // orig
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //ibelow = (ibelow + (div_floor(-ibelow,b)+1)*b) / b - (div_floor(-ibelow,b)+1);
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //ibelow = div_floor( ibelow, b );
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( a - (ibelow-1)*b >= target );
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( a - (ibelow  )*b <  target );
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     return ibelow;
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** Get range if \c i so A-iB is in [c,d), and then further
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * restrict to range [imin,imax).  Note that \c -B means as \c i
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * increases, we move from \c d-1 downwards to \c c. */
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static inline void hoist_AmiB_in( int& beg, int& end,
 179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const int imin, const int imax,
 180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const int a, const int b, const int c, const int d)
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     DMUST( b > 0 );
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     beg = AmiB_lt_target( a, b, d );
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //RT_ASSERT( beg == div_floor( a-d+b, b) );
 185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //beg = div_floor( a-d+b, b); // possibly slower ?? do I have a cmov here? no!
 186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //beg = div_floor( a-d, b) + 1; // possibly slower ?? do I have a cmov here? no!
 187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( beg < imin ) beg = imin;
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     end = AmiB_lt_target( a, b, c );
 190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //RT_ASSERT( end == div_floor( a-c+b, b) );
 191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //end = div_floor( a-c+b, b);
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //end = div_floor( a-c, b) + 1;
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( end > imax ) end = imax;
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** void sxconv_3_fwd(const prb_t *p, dnn_mem_t &src_m,
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
 198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define V 10
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // regr.sh FWD A3 (Intel)
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // 6 : ok, 10.8
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // 7 : ok, 99.4
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // 8 : ok, 98.4
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // 9 : ok, 97.0  
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // 10 : ok, 
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if V==6
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t G = p->g;
 207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
 208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
 209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
 213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
 215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
 216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
 219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DW = p->dw + 1;
 222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC/G;
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH_KW = KH * KW;
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
 228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH_IW = IH * IW;
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH_IW = SH * IW;
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH_IW = DH * IW;
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->kh > 0 && KW > 0 );
 235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( SH >= 0 && SW >= 0 );
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const psrc = (float*)src_m;
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pbia = (float*)bia_m;
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdst = (float*)dst_m;
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel) {
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash, w0, s0, s00;
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash_prv = ~0;
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t six[ICOG*KH*KW]; ALLOC_ON_VREG(six)//;
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t wix[ICOG*KH*KW]; ALLOC_ON_VREG(wix)
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float tmp[OCOG];         ALLOC_ON_VREG(tmp,OCOG) // roughly double the speed//;
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(4))//;
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if ((p->dir & FLAG_BIA) == 0){
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }else{
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // this alt to div_floor avoids negatives.
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ... so it is correct for unsigned types AND normal div.
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ssize_t kh_beg=0, kh_end=0;
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
 267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_end = 0;
 268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
 269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end >= KH) kh_end = KH;
 270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ssize_t kw_beg=0, kw_end=0;
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end >= KW) kw_end = KW;
 275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg < kw_end && kh_beg < kh_end )
 277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
 278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // SX regr.sh A1,A3 FWD: 27.0x 18.5x-->54x"alloc_on_vreg"
 279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_end -= kh_beg;
 280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_end -= kw_beg;
 281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + kh_beg) * KW + kw_beg; // oc,
 282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+kh_beg*DH)) * IW + (ow
 283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < kh_end; ++kh) {
 285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < kw_end; ++kw) {
 286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     float s = psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW];
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (ssize_t oc = 0; oc < OCOG; ++oc) {
 288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp[oc] += s * pwei[w0 + oc * ICOG*KH*KW + ic * KH*KW + kh*KW + kw];
 289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // A1,FWD 20.1x 15.3x
 294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop() for (ssize_t kh = kh_beg; kh < kh_end; ++kh) {
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const ssize_t ih = oh * SH - PH + kh * DH;
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kw = kw_beg; kw < kw_end; ++kw) {
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const ssize_t iw = ow * SW - PW + kw * DW;
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ssize_t const src_off0 =  ((mb * IC + g * ICOG + 0 ) * IH + ih) * IW + iw;
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t ic = 0; ic < ICOG; ++ic) {
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     ssize_t const wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     float wei[OCOG];
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     float vsrc = psrc[src_off0 + ic * IH_IW];
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (ssize_t oc = 0; oc < OCOG; ++oc) {
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       wei[oc] = pwei[wei_off0 + oc * ICOG_KH_KW];
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp[oc] += vsrc * wei[oc];
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // 19.8x 15.8x
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t const w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop() for (ssize_t kh = kh_beg; kh < kh_end; ++kh) {
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const ssize_t ih = oh * SH - PH + kh * DH;
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kw = kw_beg; kw < kw_end; ++kw) {
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ssize_t const src_off0 =  ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+kh*DH)) * I
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t ic = 0; ic < ICOG; ++ic) {
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     float wei[OCOG];
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (ssize_t oc = 0; oc < OCOG; ++oc) {
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //wei[oc] = pwei[wei_off0 + oc * ICOG*KH*KW];
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       wei[oc] = pwei[w0 + oc * ICOG*KH*KW + ic * KH*KW + kh*KW + kw];
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp[oc] += psrc[src_off0 + ic*IH*IW] * wei[oc];
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // 19.9x 15.7x
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-P
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop() for (ssize_t kh = kh_beg; kh < kh_end; ++kh) {
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kw = kw_beg; kw < kw_end; ++kw) {
 331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t ic = 0; ic < ICOG; ++ic) {
 332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     float wei[OCOG];
 333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (ssize_t oc = 0; oc < OCOG; ++oc) {
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       wei[oc] = pwei[w0 + oc * ICOG*KH*KW + ic * KH*KW + kh*KW + kw];
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp[oc] += psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW] * wei[oc];
 336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // 17.8x FWD regr.sh .. A1, FWD: 27.0x 18.5x
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_end -= kh_beg;
 342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_end -= kw_beg;
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + kh_beg) * KW + kw_beg; // oc,
 344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+kh_beg*DH)) * IW + (ow
 345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // 0: 26.8x 18.6x  27.2x 17.7x
 346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < kh_end; ++kh) {
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < kw_end; ++kw) {
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     six[ ic * kh_end*kw_end + kh * kw_end + kw ] = psrc[s0 + ic*IH*IW + kh*DH*IW + 
 350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = w0 + ic * KH*KW + kh*KW + kw;
 351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < kh_end; ++kh) {
 357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < kw_end; ++kw) {
 358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (ssize_t oc = 0; oc < OCOG; ++oc) {
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp[oc] += psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW] * pwei[w0 + oc * ICOG*KH*KW
 361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //tmp[oc] += six[ic*kh_end*kw_end + kh*kw_end + kw] * pwei[wix[ic*kh_end*kw_e
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // 27.0 17.9x (both)
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_end -= kh_beg;
 368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_end -= kw_beg;
 369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + kh_beg) * KW + kw_beg; // oc,
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+kh_beg*DH)) * IW + (ow
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < kh_end; ++kh) {
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < kw_end; ++kw) {
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     six[ ic * kh_end*kw_end + kh * kw_end + kw ] = psrc[s0 + ic*IH*IW + kh*DH*IW + 
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = w0 + ic * KH*KW + kh*KW + kw;
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic * KH*KW + kh*KW + kw;
 377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ickhkw = 0; ickhkw < ICOG*kh_end*kw_end; ++ickhkw){
 381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oc = 0; oc < OCOG; ++oc) {
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //tmp[oc] += six[ickhkw] * pwei[wix[ickhkw] + oc * ICOG*KH*KW];
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += six[ickhkw] * pwei[w0 + wix[ickhkw] + oc * ICOG*KH*KW];
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 //
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_end -= kh_beg;
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_end -= kw_beg;
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + kh_beg) * KW + kw_beg; // oc,
 390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+kh_beg*DH)) * IW + (ow
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < kh_end; ++kh) {
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < kw_end; ++kw) {
 394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = w0 + ic * KH*KW + kh*KW + kw;
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic * KH*KW + kh*KW + kw;
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     six[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic*IH*IW + kh*DH*IW + kw*DW;
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ickhkw = 0; ickhkw < ICOG*kh_end*kw_end; ++ickhkw){
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oc = 0; oc < OCOG; ++oc) {
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += psrc[s0 + six[ickhkw]] * pwei[w0 + wix[ickhkw] + oc * ICOG*KH*KW];
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // 27.3 18.2 .. 26.7 17.7 .. 28,52 with alloc_on_vreg
 406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_end -= kh_beg;
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_end -= kw_beg;
 408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s000 = ((mb*IC+g*ICOG)*IH -PH)*IW -PW;
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = s000 + ((kh_beg*KW + kw_beg)<<32) + ((kh_end*KW + kw_end)<<40);
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv) {
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //s00 = ((mb * IC + g * ICOG + 0 ) * IH + (0*SH-PH+kh_beg*DH)) * IW + (0*SW-PW+kw_b
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //w0 = (((g * OCOG ) * ICOG ) * KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 w0 = (g * OCOG_ICOG_KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //s00 = ((mb * IC + g * ICOG ) * IH + (-PH+kh_beg*DH)) * IW + (-PW+kw_beg*DW); //ic
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 s00 = s000 + kh_beg*DH_IW + kw_beg*DW;
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kh = 0; kh < kh_end; ++kh) {
 419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     ShortLoop() for (ssize_t kw = 0; kw < kw_end; ++kw) {
 420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = w0 + ic * KH*KW + kh*KW + kw
 421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic*KH*KW + kh*KW + kw;
 422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       six[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic*IH*IW + kh*DH*IW + kw*DW;
 423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash_prv = khash;
 427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               s0 = s00 + oh*SH_IW + ow*SW;
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ickhkw = 0; ickhkw < ICOG*kh_end*kw_end; ++ickhkw){
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oc = 0; oc < OCOG; ++oc) {
 432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += psrc[s0 + six[ickhkw]] * pwei[w0 + wix[ickhkw] + oc * ICOG_KH_KW];
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // loop order.. 64,94x speedup
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_end -= kh_beg;
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_end -= kw_beg;
 438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t s000 = ((mb*IC+g*ICOG)*IH -PH)*IW -PW;
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             khash = s000 + ((kh_beg*KW + kw_beg)<<32) + ((kh_end*KW + kw_end)<<40);
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khash != khash_prv) {
 441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //s00 = ((mb * IC + g * ICOG + 0 ) * IH + (0*SH-PH+kh_beg*DH)) * IW + (0*SW-PW+kw_beg
 443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //w0 = (((g * OCOG ) * ICOG ) * KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               w0 = (g * OCOG_ICOG_KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //s00 = ((mb * IC + g * ICOG ) * IH + (-PH+kh_beg*DH)) * IW + (-PW+kw_beg*DW); //ic,k
 446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               s00 = s000 + kh_beg*DH_IW + kw_beg*DW;
 447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #pragma cdir noconflict
 448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop()for (ssize_t kh = 0; kh < kh_end; ++kh) {
 450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop()for (ssize_t kw = 0; kw < kw_end; ++kw) {
 451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = w0 + ic * KH*KW + kh*KW + kw;
 452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic*KH*KW + kh*KW + kw;
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     six[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic*IH*IW + kh*DH*IW + kw*DW;
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash_prv = khash;
 458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             s0 = s00 + oh*SH_IW + ow*SW;
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t oc = 0; oc < OCOG; ++oc) {
 462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RETAIN(tmp) RETAIN(six) RETAIN(wix) IVDEP()//;
 463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ickhkw = 0; ickhkw < ICOG*kh_end*kw_end; ++ickhkw){
 464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] += psrc[s0 + six[ickhkw]] * pwei[w0 + wix[ickhkw] + oc * ICOG_KH_KW];
 465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (p->merge == RELU) {
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
 472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
 475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (size_t oc = 0; oc < OCOG; ++oc)
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif V==7
 482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t G = p->g;
 483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
 484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
 485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
 486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
 487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
 488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
 489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
 490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
 491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
 492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
 493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
 494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
 495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
 496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
 497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DW = p->dw + 1;
 498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
 500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC/G;
 501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH_KW = KH * KW;
 502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
 504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
 506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH_IW = IH * IW;
 507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH_IW = SH * IW;
 508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH_IW = DH * IW;
 509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->kh > 0 && KW > 0 );
 511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( SH >= 0 && SW >= 0 );
 513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const psrc = (float*)src_m;
 514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
 515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pbia = (float*)bia_m;
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdst = (float*)dst_m;
 517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel)
 518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   {
 519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kh_beg=0, kh_end=0;
 520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kw_beg=0, kw_end=0;
 521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
 522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash, w0, s0, s00;
 523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash_prv = ~0;
 524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t khash_prv2 = (KH+KW)*4; // impossibly high hash
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_begend[4];
 526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_muls[4] = {1, KH, (1<<16), (1<<16)*KW};
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     bool kok[KH][KW];
 528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     VREG(khkw_begend) VREG(khkw_muls) VREG(kok)//;
 529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float src[ICOG*KH*KW];
 530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t six[ICOG*KH*KW];
 531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t wix[ICOG*KH*KW];
 532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ALLOC_ON_VREG(src) ALLOC_ON_VREG(six) ALLOC_ON_VREG(wix)//;
 533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float tmp[OCOG];
 534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ALLOC_ON_VREG(tmp,OCOG)//; // roughly double the speed//;
 535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(4))//;
 537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
 538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if ((p->dir & FLAG_BIA) == 0){
 543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
 545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }else{
 546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
 547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
 549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // this alt to div_floor avoids negatives.
 551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ... so it is correct for unsigned types AND normal div.
 552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_beg=0, kh_end=0;
 553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
 554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_end = 0;
 555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
 556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end >= KH) kh_end = KH;
 557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_beg=0, kw_end=0;
 559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
 560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end >= KW) kw_end = KW;
 562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             bool const khw_ok = ( kw_beg < kw_end && kh_beg < kh_end );
 565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
 567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               bool kok[KH][KW];
 568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               VREG(kok)
 569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=kh_beg && kh<kh_end && kw>=kw_beg && kw<kw_end);
 572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
 575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-P
 576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               bool ickhkw_ok[ICOG*KH*KW];
 577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ALLOC_ON_VREG(ickhkw_ok,1024)
 578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
 579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       const ssize_t ickhkw = ic*KH*KW + kh*KW + kw;
 582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       ickhkw_ok[ickhkw] = kok[kh][kw];
 583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       src[ickhkw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW]: 0.f);
 584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
 589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     const ssize_t ickhkw = ic*KH*KW + kh*KW + kw;
 592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //bool const kok= (kh>=kh_beg && kh<kh_end && kw>=kw_beg && kw<kw_end);
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //if (kok)
 594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //float wei[OCOG];
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //float s = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW]: 0.f);
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //float s = (ickhkw_ok[ickhkw]?  psrc[s0 + six[ickhkw]]: 0.f);
 597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (ssize_t oc = 0; oc < OCOG; ++oc) {
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //wei[oc] = pwei[w0 + oc * ICOG*KH*KW + ickhkw];
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //tmp[oc] += s * pwei[w0 + oc * ICOG*KH*KW + ickhkw];
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //tmp[oc] += (ickhkw_ok[ickhkw]?  psrc[s0 + six[ickhkw]]: 0.f) * pwei[w0 + oc
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //tmp[oc] += (ickhkw_ok[ickhkw]?  psrc[s0 + six[ickhkw]]: 0.f) * pwei[w0 + oc
 602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //tmp[oc] += (ickhkw_ok[ickhkw]?  src[ickhkw]: 0.f) * pwei[w0 + oc * ICOG*KH*
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp[oc] += src[ickhkw] * pwei[w0 + oc * ICOG*KH*KW + ickhkw];
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //wei[oc] = pwei[w0 + oc * ICOG*KH*KW + ic * KH*KW + kh*KW + kw];
 605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //tmp[oc] += psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW] * wei[oc];
 606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //tmp[oc] += psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW]
 607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //    * pwei[w0 + oc * ICOG*KH*KW + ic * KH*KW + kh*KW + kw];
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // speed winner: 70x,105x
 614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             bool const khw_ok = ( kw_beg < kw_end && kh_beg < kh_end );
 615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // 70, 106
 618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if(1){
 619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash_prv = 0;
 620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 bool lh[KH];
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 VREG(lh)
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) lh[KH] = (kh >= kh_beg && kh < kh
 623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 bool lw[KW];
 625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 VREG(lw)
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t kw = 0; kw < KW; ++kw) lw[KW] = (kw >= kw_beg && kw < kw_end);
 627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = lh[KH] && lw[KW];
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // 73, 107
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if( 1 ){
 636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //khash_prv = 0;
 637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end);
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // 73, 107
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //unsigned khash = ((kw_beg+kh_beg) | ((kw_end+kh_end) - (KH+KW)) | khash_prv);
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // --> FAIL. ?better hash needed?
 646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1 // 73, 109
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[0] = kh_beg;
 648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[1] = kh_end;
 649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[2] = kw_beg;
 650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[3] = kw_end;
 651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = 0;
 652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t i=0; i<4; ++i)
 653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash += khkw_begend[i] * khkw_muls[i];
 654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else // 73, 107
 655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = ((kh_beg*KW + kw_beg)) + ((kh_end*KW + kw_end)<<32);
 656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
 658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash_prv = khash;
 659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end);
 662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
 667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-P
 668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // slower for (ssize_t ic = 0, ickhkw=0; ic < ICOG; ++ickhkw, ++ic)
 669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic)
 670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     const ssize_t ickhkw = ic*KH*KW + kh*KW + kw;
 675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ickhkw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*DW]: 0.f);
 676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
 677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // this may fail if wei access also needs to be protected.
 684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc) {
 685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else // 66, 94
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             bool const khw_ok = ( kw_beg < kw_end && kh_beg < kh_end );
 692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
 694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //kh_end -= kh_beg;
 695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //kw_end -= kw_beg;
 696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s000 = ((mb*IC+g*ICOG)*IH -PH)*IW -PW;
 697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = s000 + ((kh_beg*KW + kw_beg)<<32) + ((kh_end*KW + kw_end)<<40);
 698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv) {
 699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //s00 = ((mb * IC + g * ICOG + 0 ) * IH + (0*SH-PH+kh_beg*DH)) * IW + (0*SW-PW+kw_b
 701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //w0 = (((g * OCOG ) * ICOG ) * KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 w0 = (g * OCOG_ICOG_KH + kh_beg) * KW + kw_beg; // oc,ic,kh,kw=0
 703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //s00 = ((mb * IC + g * ICOG ) * IH + (-PH+kh_beg*DH)) * IW + (-PW+kw_beg*DW); //ic
 704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 s00 = s000 + kh_beg*DH_IW + kw_beg*DW;
 705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ic = 0; ic < ICOG; ++ic) {
 706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kh = 0; kh < kh_end; ++kh) {
 707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     ShortLoop() for (ssize_t kw = 0; kw < kw_end; ++kw) {
 708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       //wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = w0 + ic * KH*KW + kh*KW + kw
 709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       wix[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic*KH*KW + kh*KW + kw;
 710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       six[ ic * kh_end*kw_end + kh * kw_end + kw ] = ic*IH*IW + kh*DH*IW + kw*DW;
 711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
 712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash_prv = khash;
 715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               s0 = s00 + oh*SH_IW + ow*SW;
 717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc) {
 719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG*kh_end*kw_end; ++ickhkw){
 720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += psrc[s0 + six[ickhkw]] * pwei[w0 + wix[ickhkw] + oc * ICOG_KH_KW];
 721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (p->merge == RELU) {
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t oc = 0; oc < OCOG; ++oc)
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
 731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
 732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
 735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
 736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif V==8 // A1, A3 : 74, 108x
 739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t G = p->g;
 740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
 741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
 742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
 743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
 744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
 746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
 751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DW = p->dw + 1;
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC/G;
 758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH_KW = KH * KW;
 759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
 761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
 763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH_IW = IH * IW;
 764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH_IW = SH * IW;
 765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH_IW = DH * IW;
 766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->kh > 0 && KW > 0 );
 768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( SH >= 0 && SW >= 0 );
 770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const psrc = (float*)src_m;
 771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pbia = (float*)bia_m;
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdst = (float*)dst_m;
 774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel)
 775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   {
 776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_begend[4]; VREG(khkw_begend)//;
 777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kh_beg=0, kh_end=0;
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kw_beg=0, kw_end=0;
 779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_muls[4] = {1, KH, (1<<16), (1<<16)*KW}; VREG(khkw_muls)//;
 780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
 781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash, w0, s0, s00;
 782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash_prv = ~0;
 783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t khash_prv2 = (KH+KW)*4; // impossibly high hash
 784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     bool kok[KH][KW]; VREG(kok)//;
 785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float src[ICOG*KH*KW]; ALLOC_ON_VREG(src)//;
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float tmp[OCOG];       ALLOC_ON_VREG(tmp,OCOG) // roughly double the speed;
 787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(4))//;
 789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
 790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if ((p->dir & FLAG_BIA) == 0){
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
 797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }else{
 798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
 799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
 801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // this alt to div_floor avoids negatives.
 803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ... so it is correct for unsigned types AND normal div.
 804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_beg=0, kh_end=0;
 805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_end = 0;
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end >= KH) kh_end = KH;
 809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_beg=0, kw_end=0;
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
 812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end >= KW) kw_end = KW;
 814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             bool const khw_ok = ( kw_beg < kw_end && kh_beg < kh_end );
 816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
 818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //unsigned khash = ((kw_beg+kh_beg) | ((kw_end+kh_end) - (KH+KW)) | khash_prv);
 819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // --> FAIL. ?better hash needed?
 820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[0] = kh_beg;
 821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[1] = kh_end;
 822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[2] = kw_beg;
 823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[3] = kw_end;
 824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = 0;
 825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t i=0; i<4; ++i)
 826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash += khkw_begend[i] * khkw_muls[i];
 827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
 828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash_prv = khash;
 829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end);
 832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
 836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-P
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // slower for (ssize_t ic = 0, ickhkw=0; ic < ICOG; ++ickhkw, ++ic)
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic)
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
 843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // this may fail if wei access also needs to be protected.
 848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc) {
 849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (p->merge == RELU) {
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t oc = 0; oc < OCOG; ++oc)
 857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
 860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
 861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
 864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
 865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif V==9 // A1, A3 : 74, 108x
 868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t G = p->g;
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
 870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
 871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
 875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
 878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
 880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
 882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
 883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DW = p->dw + 1;
 884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
 886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC/G;
 887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH_KW = KH * KW;
 888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
 890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH_IW = IH * IW;
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH_IW = SH * IW;
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH_IW = DH * IW;
 895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->kh > 0 && KW > 0 );
 897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( SH >= 0 && SW >= 0 );
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const psrc = (float*)src_m;
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pbia = (float*)bia_m;
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdst = (float*)dst_m;
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   ssize_t khb[OH], khe[OH]; ALLOC_ON_VREG(khb,OH) ALLOC_ON_VREG(khe,OH)
 904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   ssize_t kwb[OW], kwe[OW]; ALLOC_ON_VREG(kwb,OW) ALLOC_ON_VREG(kwe,OW)
 905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single) for (ssize_t oh = 0; oh < OH; ++oh) {
 907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // this alt to div_floor avoids negatives.
 908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // ... so it is correct for unsigned types AND normal div.
 909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[oh] = 0;
 910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[oh] = 0;
 911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh*SH < PH)    khb[oh] = (   PH - oh*SH + (DH - 1)) / DH;
 912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh*SH < IH+PH) khe[oh] = (IH+PH - oh*SH + (DH - 1)) / DH;
 913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (khe[oh] >= KH) khe[oh] = KH;
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single)//;
 916:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (ssize_t ow = 0; ow < OW; ++ow) {
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[ow]=0;
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[ow]=0;
 919:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow*SW < PW)    kwb[ow] = (   PW - ow*SW + (DW - 1)) / DW;
 920:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow*SW < IW+PW) kwe[ow] = (IW+PW - ow*SW + (DW - 1)) / DW;
 921:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (kwe[ow] >= KW) kwe[ow] = KW;
 922:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 923:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
 924:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single nowait) for (int oh = 0; oh < OH; ++oh) {
 925:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // trick to easy calc of kh, kw loop limits is that division must
 926:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // round more consistently.  'C' round-to-zero is not so useful!
 927:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[oh] = div_floor( 0  - (oh * SH - PH) + p->dh, (p->dh+1) );
 928:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 929:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( khb[oh] < 0     ) khb[oh] = 0;
 930:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( khe[oh] > p->kh ) khe[oh] = p->kh;
 931:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 932:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single nowait) for (int ow = 0; ow < OW; ++ow) {
 933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, (p->dw+1) );
 934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
 935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( kwb[ow] < 0  ) kwb[ow] = 0;
 936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( kwe[ow] > KW ) kwe[ow] = KW;
 937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 938:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 939:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel)
 941:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   {
 942:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kh_beg=0, kh_end=0;
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kw_beg=0, kw_end=0;
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash, w0, s0, s00;
 945:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash_prv = ~0;
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_begend[4];
 947:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_muls[4] = {1, KH, (1<<16), (1<<16)*KW};
 948:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     bool kok[KH][KW];
 949:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     VREG(khkw_begend) VREG(khkw_muls) VREG(kok)//;
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
 951:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t khash_prv2 = (KH+KW)*4; // impossibly high hash
 952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float src[ICOG*KH*KW]; ALLOC_ON_VREG(src)//;
 953:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float tmp[OCOG];       ALLOC_ON_VREG(tmp,OCOG)//; // roughly 2x speed;
 954:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 955:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(4))//;
 956:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
 957:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 958:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 959:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 960:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 961:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if ((p->dir & FLAG_BIA) == 0){
 962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }else{
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
 966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 967:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
 968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // this alt to div_floor avoids negatives.
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ... so it is correct for unsigned types AND normal div.
 972:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_beg=0, kh_end=0;
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < PH) kh_beg = (PH - oh*SH + (DH - 1)) / DH;
 974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_end = 0;
 975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh*SH < IH+PH) kh_end = (IH+PH - oh*SH + (DH - 1)) / DH;
 976:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end >= KH) kh_end = KH;
 977:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_beg=0, kw_end=0;
 979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < PW) kw_beg = (PW - ow*SW + (DW - 1)) / DW;
 980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow*SW < IW+PW) kw_end = (IW+PW - ow*SW + (DW - 1)) / DW;
 981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end >= KW) kw_end = KW;
 982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( kh_beg == khb[oh] );
 983:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( kh_end == khe[oh] );
 984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( kw_beg == kwb[ow] );
 985:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( kw_end == kwe[ow] );
 986:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
 987:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_beg = khb[oh];
 988:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kh_end = khe[oh];
 989:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_beg = kwb[ow];
 990:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_end = kwe[ow];
 991:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 993:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             bool const khw_ok = ( khb[oh] < kh_end && kwb[ow] < kw_end );
 994:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 995:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
 996:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //unsigned khash = ((kw_beg+kh_beg) | ((kw_end+kh_end) - (KH+KW)) | khash_prv);
 997:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // --> FAIL. ?better hash needed?
 998:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[0] = kh_beg;
 999:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[1] = kh_end;
1000:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[2] = kw_beg;
1001:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[3] = kw_end;
1002:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = 0;
1003:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t i=0; i<4; ++i)
1004:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash += khkw_begend[i] * khkw_muls[i];
1005:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
1006:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash_prv = khash;
1007:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
1008:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1009:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=kh_beg && kw>=kw_beg) && (kh<kh_end && kw<kw_end);
1010:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
1011:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1012:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1013:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
1014:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-P
1015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // slower for (ssize_t ic = 0, ickhkw=0; ic < ICOG; ++ickhkw, ++ic)
1016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic)
1017:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
1018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
1019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
1021:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
1022:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1023:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // this may fail if wei access also needs to be protected.
1026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc) {
1027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
1028:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
1029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1030:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1031:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1032:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
1033:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (p->merge == RELU) {
1034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t oc = 0; oc < OCOG; ++oc)
1035:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
1036:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1037:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
1038:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
1039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
1040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
1041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
1042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
1043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1045:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif V==10
1046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t G = p->g;
1047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
1048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
1049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
1051:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
1052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
1054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
1055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
1056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
1058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
1059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
1060:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
1061:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DW = p->dw + 1;
1062:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
1064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC/G;
1065:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH_KW = KH * KW;
1066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
1067:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
1068:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
1069:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH = OCOG * ICOG * KH;
1070:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH_IW = IH * IW;
1071:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH_IW = SH * IW;
1072:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH_IW = DH * IW;
1073:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1074:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->kh > 0 && KW > 0 );
1075:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
1076:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( SH >= 0 && SW >= 0 );
1077:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const psrc = (float*)src_m;
1078:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
1079:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pbia = (float*)bia_m;
1080:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdst = (float*)dst_m;
1081:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   ssize_t khb[OH], khe[OH]; ALLOC_ON_VREG(khb,OH) ALLOC_ON_VREG(khe,OH)
1082:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   ssize_t kwb[OW], kwe[OW]; ALLOC_ON_VREG(kwb,OW) ALLOC_ON_VREG(kwe,OW)
1083:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
1084:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single) for (ssize_t oh = 0; oh < OH; ++oh) {
1085:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // this alt to div_floor avoids negatives.
1086:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // ... so it is correct for unsigned types AND normal div.
1087:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[oh] = 0;
1088:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[oh] = 0;
1089:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh*SH < PH)    khb[oh] = (   PH - oh*SH + (DH - 1)) / DH;
1090:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh*SH < IH+PH) khe[oh] = (IH+PH - oh*SH + (DH - 1)) / DH;
1091:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (khe[oh] >= KH) khe[oh] = KH;
1092:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1093:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single) for (ssize_t ow = 0; ow < OW; ++ow) {
1094:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[ow]=0;
1095:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[ow]=0;
1096:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow*SW < PW)    kwb[ow] = (   PW - ow*SW + (DW - 1)) / DW;
1097:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow*SW < IW+PW) kwe[ow] = (IW+PW - ow*SW + (DW - 1)) / DW;
1098:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (kwe[ow] >= KW) kwe[ow] = KW;
1099:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0
1101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single nowait) for (int oh = 0; oh < OH; ++oh) {
1102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // trick to easy calc of kh, kw loop limits is that division must
1103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // round more consistently.  'C' round-to-zero is not so useful!
1104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[oh] = div_floor( 0  - (oh * SH - PH) + p->dh, (p->dh+1) );
1105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
1106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( khb[oh] < 0     ) khb[oh] = 0;
1107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( khe[oh] > p->kh ) khe[oh] = p->kh;
1108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(single nowait) for (int ow = 0; ow < OW; ++ow) {
1110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, (p->dw+1) );
1111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
1112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( kwb[ow] < 0  ) kwb[ow] = 0;
1113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( kwe[ow] > KW ) kwe[ow] = KW;
1114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel) {
1118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kh_beg=0, kh_end=0;
1119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t kw_beg=0, kw_end=0;
1120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash, w0, s0, s00;
1121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khash_prv = ~0;
1122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
1123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t khash_prv2 = (KH+KW)*4; // impossibly high hash
1124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     bool kok[KH][KW];
1125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_begend[4];
1126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_muls[4] = {1, KH, (1<<16), (1<<16)*KW};
1127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     VREG(khkw_begend) VREG(khkw_muls) VREG(kok)//;
1128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //float src[ICOG*KH*KW]; ALLOC_ON_VREG(src)//;
1130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float src[ICOG*KH*KW] alignas(64); ALLOC_ON_VREG(src)//;
1131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float tmp[OCOG] alignas(64);       ALLOC_ON_VREG(tmp,OCOG)//; // roughly double the speed;
1132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(single nowait) for (int oh = 0; oh < OH; ++oh) {
1134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       // trick to easy calc of kh, kw loop limits is that division must
1135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       // round more consistently.  'C' round-to-zero is not so useful!
1136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khb[oh] = div_floor( 0  - (oh * SH - PH) + p->dh, (p->dh+1) );
1137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
1138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( khb[oh] < 0     ) khb[oh] = 0;
1139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( khe[oh] > p->kh ) khe[oh] = p->kh;
1140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(single nowait) for (int ow = 0; ow < OW; ++ow) {
1142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, (p->dw+1) );
1143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
1144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( kwb[ow] < 0  ) kwb[ow] = 0;
1145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( kwe[ow] > KW ) kwe[ow] = KW;
1146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(barrier)//;
1148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(4))//;
1150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
1151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
1153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
1154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
1155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if ((p->dir & FLAG_BIA) == 0){
1156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
1157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
1158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }else{
1159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t bia_off0 = (ssize_t)g * OCOG + 0;
1160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
1161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
1162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //kh_beg = khb[oh];
1164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //kh_end = khe[oh];
1165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //kw_beg = kwb[ow];
1166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //kw_end = kwe[ow];
1167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             bool const khw_ok = ( khb[oh] < khe[oh] && kwb[ow] < kwe[ow] );
1169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
1170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
1171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //unsigned khash = ((kw_beg+kh_beg) | ((kw_end+kh_end) - (KH+KW)) | khash_prv);
1172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // --> FAIL. ?better hash needed?
1173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[0] = khb[oh];
1174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[1] = khe[oh];
1175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[2] = kwb[ow];
1176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[3] = kwe[ow];
1177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = 0;
1178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               OMPSIMD()
1179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t i=0; i<4; ++i)
1180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash += khkw_begend[i] * khkw_muls[i];
1181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
1182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 khash_prv = khash;
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
1184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=khb[oh] && kw>=kwb[ow]) && (kh<khe[oh] && kw<kwe[ow]);
1186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
1187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + 0) * KH + 0) * KW + 0; // oc,ic,kh,kw=0
1190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = ((mb * IC + g * ICOG + 0 ) * IH + (oh*SH-PH+0*DH)) * IW + (ow*SW-P
1191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // slower for (ssize_t ic = 0, ickhkw=0; ic < ICOG; ++ickhkw, ++ic)
1192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic)
1193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ShortLoop() for (ssize_t kh = 0; kh < KH; ++kh) {
1195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
1196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
1197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
1198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // this may fail if wei access also needs to be protected.
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc) {
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
1205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //for (size_t oc = 0; oc < OCOG; ++oc) pdst[dst_off0 + oc * OH_OW] = tmp[oc];
1209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (p->merge == RELU) {
1210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t oc = 0; oc < OCOG; ++oc)
1211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
1212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 if (tmp[oc] < 0.f) tmp[oc] = 0.f;
1213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t dst_off0 = (((ssize_t)mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (size_t oc = 0; oc < OCOG; ++oc)
1216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
1217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
1218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
1219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
1220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
1223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #error "please select one"
1224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
1226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
1228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** hoisting for generic dilations is complicated by modulo conditions. */
1229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static void sxconv_3_bwd_d_generic_0(const prb_t *p, dnn_mem_t &diff_src_m,
1230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
1231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
1232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // shorten, do same for kw,ow loop. tweaks to kh calc
1233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const KH = p->kh;
1234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const OH = OH;
1235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DH = p->dh + 1;
1236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const SH = SH;
1237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const PH = PH;
1238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_h = gcd( SH, DH );
1239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
1240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int khh = lcm_h / DH;
1241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
1242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jhh = lcm_h / SH;
1243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ha, hb, hg;
1244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
1245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
1246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
1247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const KW = p->kh;
1249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DW = p->dw + 1;
1250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const SW = SW;
1251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const OW = OW;
1252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const PW = PW;
1253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_w = gcd( SW, DW );
1254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //const int lcm_w = lcm( SW, DW );
1255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_w = SW * DW/gcd_w;
1256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int kww = lcm_w / DW;
1257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jww = lcm_w / SW;
1258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int wa, wb, wg;
1259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
1260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
1261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(5))//;
1262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int g = 0; g < G; ++g) {
1263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
1264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
1265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
1266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // calc kh_beg, kh_end here? 4.28x
1267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int iw = 0; iw < IW; ++iw) {
1268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
1269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float &ds = pdiff_src[src_off];
1270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ds = 0;
1271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = (ih + PH) / DH + 1;
1273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end > KH) kh_end = KH;
1274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_beg = kh_end;
1275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // 1. Find one soln (any)
1277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (ih+PH) / gcd_h;
1278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_beg = ha*mul;
1279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = hb*mul;
1280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // 2. Adjust to lowest kh_beg>=0
1281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // ok
1282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = (kh_beg<0? (-kh_beg+ khh -1) / khh
1283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   : kh_beg >= khh? - (kh_beg / khh)
1284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   : 0);
1285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( kh_beg + m*khh == rem_floor( kh_beg, khh ) ); // adjust kh_beg in khh-step
1286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( m == (rem_floor(kh_beg,khh) - kh_beg) / khh ); // y
1287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( m == - div_floor(kh_beg,khh) ); // y
1288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if(m){
1289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   kh_beg += m * khh;
1290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   j -= m * jhh;
1291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // ok
1293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int k2 = rem_floor( kh_beg, khh );
1294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = (k2-kh_beg) / khh;
1295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_beg = k2;
1296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               j -= m * jhh;
1297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // ok
1298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kh_beg, khh);
1299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_beg -= m * khh;
1300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               j      += m * jhh;
1301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // 3. Adjust j downwards st. j*SH < OH*SH (kh_beg can go up even more)
1303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if( j >= OH ){
1304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 m = (j-OH) / jhh + 1;
1305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 kh_beg += m * khh;
1306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //j      -= m * jhh; // not needed
1307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
1310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
1311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_beg, /*ow_beg,*/ kw_end;
1312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_end = (iw + PW) / (p->dw+1) + 1;
1313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end > KW) kw_end = KW;
1314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             kw_beg = div_floor( (iw + PW) - OW*SW, p->dw+1) + 1;
1315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_beg < 0    ) kw_beg = 0;
1316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             { // jump kw_beg up to 1st non-skipped index
1317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int owxsw = iw+PW - kw_beg * (p->dw+1);
1318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (owxsw % SW){
1319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 do {
1320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ++kw_beg;
1321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   owxsw = iw+PW - kw_beg * (p->dw+1);
1322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 } while( owxsw % SW != 0 && kw_beg < kw_end );
1323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 DMUST( kw_beg >= kw_end || (iw+PW - kw_beg * (p->dw+1)) % SW == 0 );
1324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             DMUST( kw_beg >= 0 );
1327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
1328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = (iw + PW) / DW + 1;
1329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end > KW) kw_end = KW;
1330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_beg = kw_end;
1331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
1332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (iw+PW) / gcd_w;
1333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_beg = wa*mul;
1334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //int j = wb*mul;
1335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kw_beg, kww);
1336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_beg -= m * kww;
1337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = wb * mul + m * jww;
1338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if( j >= OW ){
1339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 m = (j-OW) / jww + 1;
1340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 kw_beg += m * kww;
1341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //j -= m * jww; // not needed
1342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
1346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int oc = 0; oc < OC/G; ++oc) {
1348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
1349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   kh < kh_end;
1350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   oh0 -= lcm_h, kh += khh)
1351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
1352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
1353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kw < kw_end;
1354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     ow0 -= lcm_w, kw += kww)
1355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 {
1356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ds += pdiff_dst[dst_off] * pwei_m[wei_off];
1359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
1364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
1365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
1366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // clean up
1369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
1370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
1371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //float const * restrict const pbia = (float*)bia_m;
1372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
1373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define G  p->g
1374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define MB p->mb
1375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IC p->ic
1376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OC p->oc
1377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KH p->kh
1378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IH p->ih
1379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OH p->oh
1380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SH p->sh
1381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PH p->ph
1382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KW p->kw
1383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IW p->iw
1384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OW p->ow
1385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SW p->sw
1386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PW p->pw
1387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const KH = p->kh;
1388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const OH = OH;
1389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const DH = p->dh + 1;
1390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const SH = SH;
1391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const PH = PH;
1392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DH = p->dh + 1;
1393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_h = gcd( SH, DH );
1394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
1395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int khh = lcm_h / DH;
1396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
1397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jhh = lcm_h / SH;
1398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ha, hb, hg;
1399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
1400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
1401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
1402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const KW = p->kh;
1404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const SW = SW;
1405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const OW = OW;
1406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const PW = PW;
1407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DW = p->dw + 1;
1408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_w = gcd( SW, DW );
1409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //const int lcm_w = lcm( SW, DW );
1410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_w = SW * DW/gcd_w;
1411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int kww = lcm_w / DW;
1412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jww = lcm_w / SW;
1413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int wa, wb, wg;
1414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
1415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
1416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OCOG = OC / G;
1417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG = IC / G;
1418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG_KH_KW = ICOG * KH * KW;
1419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OH_OW = OH * OW;
1420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(5))//;
1421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int g = 0; g < G; ++g) {
1422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
1423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
1424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
1425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int iw = 0; iw < IW; ++iw) {
1426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
1427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float &ds = pdiff_src[src_off];
1428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ds = 0;
1429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = (ih + PH) / DH + 1;
1431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end > KH) kh_end = KH;
1432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_beg = kh_end;
1433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int kh_ibeg = kh_end;
1435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (ih+PH) / gcd_h;
1436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_ibeg = ha*mul;
1437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kh_ibeg, khh);
1438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_ibeg -= m * khh;
1439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
1440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
1441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_beg = kh_ibeg;
1442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
1444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = (iw + PW) / DW + 1;
1446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end > KW) kw_end = KW;
1447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_beg = kw_end;
1448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
1449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int kw_ibeg;
1450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (iw+PW) / gcd_w;
1451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_ibeg = wa * mul;
1452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kw_ibeg, kww);
1453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_ibeg -= m * kww;
1454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = wb * mul + m * jww;
1455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
1456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_beg = kw_ibeg;
1457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
1459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ShortLoop()//;
1461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
1462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 kh < kh_end;
1463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 oh0 -= lcm_h, kh += khh)
1464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
1465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop()//;
1466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
1467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   kw < kw_end;
1468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ow0 -= lcm_w, kw += kww)
1469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
1470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh0/SH) * OW + ow0
1471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw
1472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 float d[OCOG], w[OCOG];
1473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 IVDEP() for (size_t oc = 0; oc < OCOG; ++oc) {
1474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
1477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   d[oc] = pdiff_dst[dst_off0 + oc*OH_OW];
1478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   w[oc] = pwei     [wei_off0 + oc*ICOG_KH_KW];
1479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ds += d[oc] * w[oc];
1480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
1485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
1486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
1487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef G
1490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef MB
1491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IC
1492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OC
1493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KH
1494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IH
1495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OH
1496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SH
1497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PH
1498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KW
1499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IW
1500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OW
1501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SW
1502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PW
1503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // no macros, use ssize_t
1504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
1505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
1506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
1507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define G  p->g
1508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define MB p->mb
1509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IC p->ic
1510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OC p->oc
1511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KH p->kh
1512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IH p->ih
1513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OH p->oh
1514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SH p->sh
1515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PH p->ph
1516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KW p->kw
1517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IW p->iw
1518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OW p->ow
1519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SW p->sw
1520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PW p->pw
1521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const KH = p->kh;
1522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const OH = OH;
1523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const DH = p->dh + 1;
1524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const SH = SH;
1525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const PH = PH;
1526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   size_t const DH = p->dh + 1;
1527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_h = gcd( SH, DH );
1528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
1529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int khh = lcm_h / DH;
1530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
1531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jhh = lcm_h / SH;
1532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ha, hb, hg;
1533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
1534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
1535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
1536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const KW = p->kh;
1538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const SW = SW;
1539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const OW = OW;
1540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //int const PW = PW;
1541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   size_t const DW = p->dw + 1;
1542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_w = gcd( SW, DW );
1543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //const int lcm_w = lcm( SW, DW );
1544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_w = SW * DW/gcd_w;
1545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int kww = lcm_w / DW;
1546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jww = lcm_w / SW;
1547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int wa, wb, wg;
1548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
1549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
1550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const size_t OCOG = OC / G;
1551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const size_t ICOG = IC / G;
1552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const size_t ICOG_KH_KW = ICOG * KH * KW;
1553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const size_t OH_OW = OH * OW;
1554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(5))//;
1555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int g = 0; g < G; ++g) {
1556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
1557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
1558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
1559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int iw = 0; iw < IW; ++iw) {
1560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
1561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float &ds = pdiff_src[src_off];
1562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ds = 0;
1563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t kh_end = (ih + PH) / DH + 1;
1565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end > KH) kh_end = KH;
1566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t kh_beg = kh_end;
1567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int kh_ibeg = kh_end;
1569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (ih+PH) / gcd_h;
1570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_ibeg = ha*mul;
1571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kh_ibeg, khh);
1572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_ibeg -= m * khh;
1573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
1574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
1575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_beg = kh_ibeg;
1576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
1578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t kw_end = (iw + PW) / DW + 1;
1580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end > KW) kw_end = KW;
1581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t kw_beg = kw_end;
1582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
1583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int kw_ibeg;
1584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (iw+PW) / gcd_w;
1585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_ibeg = wa * mul;
1586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kw_ibeg, kww);
1587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_ibeg -= m * kww;
1588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = wb * mul + m * jww;
1589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
1590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_beg = kw_ibeg;
1591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
1593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ShortLoop()for (size_t kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
1595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 kh < kh_end;
1596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 oh0 -= lcm_h, kh += khh)
1597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             {
1598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop()for (size_t kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
1599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   kw < kw_end;
1600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ow0 -= lcm_w, kw += kww)
1601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
1602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t dst_off0 = (((size_t)mb * OC + g * OCOG + 0) * OH + oh0/SH) * OW + ow0
1603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t wei_off0 = ((((size_t)g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw
1604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 float d[OCOG], w[OCOG];
1605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 RETAIN(ds)IVDEP()for (size_t oc = 0; oc < OCOG; ++oc) {
1606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
1609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   d[oc] = pdiff_dst[dst_off0 + oc*OH_OW];
1610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   w[oc] = pwei     [wei_off0 + oc*ICOG_KH_KW];
1611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ds += d[oc] * w[oc];
1612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
1617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
1618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
1619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef G
1622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef MB
1623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IC
1624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OC
1625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KH
1626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IH
1627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OH
1628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SH
1629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PH
1630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KW
1631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IW
1632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OW
1633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SW
1634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PW
1635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
1636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #error "select one"
1637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
1639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** void sxconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
1642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
1643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** {
1644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
1645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
1646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //float const * restrict const pbia = (float*)bia_m;
1647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
1648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define G  p->g
1649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define MB p->mb
1650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IC p->ic
1651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OC p->oc
1652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KH p->kh
1653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IH p->ih
1654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OH p->oh
1655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SH p->sh
1656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PH p->ph
1657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KW p->kw
1658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IW p->iw
1659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OW p->ow
1660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SW p->sw
1661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PW p->pw
1662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // clean up
1663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // for nvcc, defining the follow below leads to wrong code
1664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khb[IH];
1665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khe[IH];
1666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwb[IW];
1667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwe[IW];
1668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DH = p->dh + 1;
1670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_h = gcd( SH, DH );
1671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
1672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int khh = lcm_h / DH;
1673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
1674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jhh = lcm_h / SH;
1675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ha, hb, hg;
1676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
1677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
1678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DW = p->dw + 1;
1680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_w = gcd( SW, DW );
1681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_w = SW * DW/gcd_w;
1682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int kww = lcm_w / DW;
1683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jww = lcm_w / SW;
1684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int wa, wb, wg;
1685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
1686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
1687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OCOG = OC / G;
1689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG = IC / G;
1690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OH_OW = OH * OW;
1691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG_KH_KW = ICOG * KH * KW;
1692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // slower:
1694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   struct BE{ int beg; int end; };
1695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // gcda ha : gcdb hb : jhh jjj : khh kkk
1696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   auto kBE = [](int const i, int const P, int const D, int const K, int const O,
1697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const gcd, int const gcda, int const gcdb, int const jjj, int const kkk ){
1698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     struct BE kbe;
1699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kbe.end = (i + P) / D + 1;
1700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (kbe.end > K) kbe.end = K;
1701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kbe.beg = kbe.end;
1702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (i+P) % gcd == 0 ){ // Do solutions exist?
1703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kh_ibeg = kbe.end;
1704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const mul = (i+P) / gcd;
1705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg = gcda*mul;
1706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kh_ibeg, kkk);
1707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg -= m * kkk;
1708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = gcdb * mul + m * jjj; // var j --> 'm' again
1709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= O) kh_ibeg += (j-O)/jjj * kkk + kkk;
1710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kbe.beg = kh_ibeg;
1711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     return kbe;
1713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   };
1714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const struct BE beh = kBE(ih, PH, DH, KH, OH, gcd_h, ha, hb, jhh, khh);
1715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_beg = beh.beg;
1716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = beh.end;
1717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // just enabling the following generates an error with nvcc
1720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1
1721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int ih = 0; ih < IH; ++ih) {
1722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[ih] = (ih + PH) / DH + 1;
1723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (khe[ih] > KH) khe[ih] = KH;
1724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[ih] = khe[ih];
1725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kh_ibeg = khe[ih];
1727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const mul = (ih+PH) / gcd_h;
1728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg = ha*mul;
1729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kh_ibeg, khh);
1730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg -= m * khh;
1731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = hb * mul + m * jhh; // var j --> 'm' again
1732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
1733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khb[ih] = kh_ibeg;
1734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int iw = 0; iw < IW; ++iw) {
1737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = (iw + PW) / DW + 1;
1738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (kwe[iw] > KW) kwe[iw] = KW;
1739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[iw] = kwe[iw];
1740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
1741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kw_ibeg = kwe[iw];
1742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const mul = (iw+PW) / gcd_w;
1743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kw_ibeg = wa * mul;
1744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kw_ibeg, kww);
1745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kw_ibeg -= m * kww;
1746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = wb * mul + m * jww;
1747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
1748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[iw] = kw_ibeg;
1749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int nerr_kh=0;
1752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(5))//;
1755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int g = 0; g < G; ++g) {
1756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
1757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
1758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
1759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // calc kh_beg, kh_end here? 4.28x
1760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int iw = 0; iw < IW; ++iw) {
1761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
1762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float &ds = pdiff_src[src_off];
1763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ds = 0;
1764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
1766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = (ih + PH) / DH + 1;
1767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kh_end > KH) kh_end = KH;
1768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_beg = kh_end;
1769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int kh_ibeg = kh_end;
1771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (ih+PH) / gcd_h;
1772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_ibeg = ha*mul;
1773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kh_ibeg, khh);
1774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_ibeg -= m * khh;
1775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
1776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
1777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kh_beg = kh_ibeg;
1778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // Nothing here --> OK with nvcc
1780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // RT_ASSERT --> error with nvcc
1781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ++nerr_kh --> error with nvcc
1782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //RT_ASSERT( kh_beg == khb[ih] );
1783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //RT_ASSERT( kh_end == khe[ih] );
1784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //if (kh_beg != khb[ih]) ++nerr_kh;
1785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //if (kh_end != khe[ih]) ++nerr_kh;
1786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
1787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_beg = khb[ih];
1788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = khe[ih];
1789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
1791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
1793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = (iw + PW) / DW + 1;
1794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (kw_end > KW) kw_end = KW;
1795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_beg = kw_end;
1796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
1797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int kw_ibeg = kw_end;
1798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int const mul = (iw+PW) / gcd_w;
1799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_ibeg = wa * mul;
1800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int m = div_floor(kw_ibeg, kww);
1801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_ibeg -= m * kww;
1802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int j = wb * mul + m * jww;
1803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
1804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               kw_beg = kw_ibeg;
1805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //RT_ASSERT( kw_beg == kwb[iw] );
1807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //RT_ASSERT( kw_end == kwe[iw] );
1808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
1809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_beg = kwb[iw];
1810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = kwe[iw];
1811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
1812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
1813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int oh0=ih+PH - kh_beg*DH;
1815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const size_t d_oc00 = dst_off_f(p, mb, g, 0, 0, 0);
1816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //size_t d_oc00 = dst_off_f(p, mb, g, 0, oh0/SH, 0);
1817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const size_t w_oc00 = wei_off_f(p, g, 0, ic, 0, 0);
1818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ShortLoop() for (int kh = kh_beg; kh < kh_end; kh += khh) {
1819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
1820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop() for (int kw = kw_beg; kw < kw_end; kw += kww) {
1821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
1822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t w_oc0 = wei_off_f(p, g, 0, ic, kh, kw);
1823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t w_oc0 = w_oc00 + kh*KW + kw;
1824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t d_oc0 = d_oc00 + (oh0/SH)*OW + ow0/SW;
1825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = d_oc00 + (oh0/SH) + ow0/SW;
1826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int oc = 0; oc < OC/G; ++oc) {
1827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
1830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ds += pdiff_dst[d_oc0 + oc*OH_OW] * pwei[w_oc0 + oc*ICOG_KH_KW];
1831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ow0 -= lcm_w;
1833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               oh0 -= lcm_h;
1835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //d_oc00 -= jhh; // jhh = lcm_h/SH;
1836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
1839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
1840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
1841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //if(nerr_kh) cout<<" nerr_kh="<<nerr_kh;
1844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // clean up
1845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khb[IH];
1846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khe[IH];
1847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwb[IW];
1848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwe[IW];
1849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DH = p->dh + 1;
1851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_h = gcd( SH, DH );
1852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
1853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int khh = lcm_h / DH;
1854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
1855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jhh = lcm_h / SH;
1856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ha, hb, hg;
1857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
1858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
1859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DW = p->dw + 1;
1861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_w = gcd( SW, DW );
1862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_w = SW * DW/gcd_w;
1863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int kww = lcm_w / DW;
1864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jww = lcm_w / SW;
1865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int wa, wb, wg;
1866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
1867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
1868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OCOG = OC / G;
1870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG = IC / G;
1871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OH_OW = OH * OW;
1872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG_KH_KW = ICOG * KH * KW;
1873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int ih = 0; ih < IH; ++ih) {
1875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[ih] = (ih + PH) / DH + 1;
1876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (khe[ih] > KH) khe[ih] = KH;
1877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[ih] = khe[ih];
1878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kh_ibeg = khe[ih];
1880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const mul = (ih+PH) / gcd_h;
1881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg = ha*mul;
1882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kh_ibeg, khh);
1883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg -= m * khh;
1884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = hb * mul + m * jhh; // var j --> 'm' again
1885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
1886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khb[ih] = kh_ibeg;
1887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int iw = 0; iw < IW; ++iw) {
1890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = (iw + PW) / DW + 1;
1891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (kwe[iw] > KW) kwe[iw] = KW;
1892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[iw] = kwe[iw];
1893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
1894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kw_ibeg = kwe[iw];
1895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const mul = (iw+PW) / gcd_w;
1896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kw_ibeg = wa * mul;
1897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kw_ibeg, kww);
1898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kw_ibeg -= m * kww;
1899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = wb * mul + m * jww;
1900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
1901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[iw] = kw_ibeg;
1902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(5))//;
1906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int g = 0; g < G; ++g) {
1907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
1908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
1909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
1910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // calc kh_beg, kh_end here? 4.28x
1911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int iw = 0; iw < IW; ++iw) {
1912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
1913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float &ds = pdiff_src[src_off];
1914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ds = 0;
1915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1916:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_beg = khb[ih];
1917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = khe[ih];
1918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
1919:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1920:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_beg = kwb[iw];
1921:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = kwe[iw];
1922:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
1923:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1924:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int oh0=ih+PH - kh_beg*DH;
1925:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const size_t w_oc00 = wei_off_f(p, g, 0, ic, 0, 0);
1926:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //const size_t d_oc00 = dst_off_f(p, mb, g, 0, 0, 0);
1927:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //const size_t d_oc00b = dst_off_f(p, mb, g, 0, oh0/SH, 0);
1928:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t d_oc1h = dst_off_f(p, mb, g, 0, oh0/SH, 0);
1929:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ShortLoop() for (int kh = kh_beg; kh < kh_end; kh += khh) {
1930:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
1931:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //if(g==0&&mb==0&&ic==0) cout<<" kh="<<kh<<" oh0="<<oh0<<" (oh0/SH)*OW="<<(oh0/SH)*OW
1932:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //int d_oc00h = d_oc00 + (oh0/SH)*OW;
1934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //RT_ASSERT( d_oc00h == d_oc00b - ((kh-kh_beg)/khh * jhh * OW / SH) );
1935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //RT_ASSERT( d_oc00h == d_oc1h );
1936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop() for (int kw = kw_beg; kw < kw_end; kw += kww) {
1937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
1938:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t w_oc0 = wei_off_f(p, g, 0, ic, kh, kw);
1939:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t w_oc0 = w_oc00 + kh*KW + kw;
1940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = d_oc00 + (oh0/SH)*OW + ow0/SW;
1941:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0b = d_oc00h + ow0/SW;
1942:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t d_oc0b = d_oc1h + ow0/SW;
1943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int oc = 0; oc < OC/G; ++oc) {
1944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
1945:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
1946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
1947:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[d_oc0 + oc*OH_OW] * pwei[w_oc0 + oc*ICOG_KH_KW];
1948:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0 + oc*ICOG_KH_KW];
1949:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
1950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ow0 -= lcm_w;
1951:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
1952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               oh0 -= lcm_h;
1953:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               d_oc1h -= jhh*OW; // jhh ~ lcm_h/SH
1954:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
1955:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1956:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
1957:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
1958:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
1959:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
1960:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
1961:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //if(nerr_kh) cout<<" nerr_kh="<<nerr_kh;
1962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // clean up
1963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khb[IH];
1964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khe[IH];
1965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwb[IW];
1966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwe[IW];
1967:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DH = p->dh + 1;
1969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_h = gcd( SH, DH );
1970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
1971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int khh = lcm_h / DH;
1972:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
1973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jhh = lcm_h / SH;
1974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ha, hb, hg;
1975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
1976:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
1977:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int const DW = p->dw + 1;
1979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_w = gcd( SW, DW );
1980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_w = SW * DW/gcd_w;
1981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int kww = lcm_w / DW;
1982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jww = lcm_w / SW;
1983:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int wa, wb, wg;
1984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
1985:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
1986:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1987:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OCOG = OC / G;
1988:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG = IC / G;
1989:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OH_OW = OH * OW;
1990:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG_KH_KW = ICOG * KH * KW;
1991:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
1992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int ih = 0; ih < IH; ++ih) {
1993:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[ih] = (ih + PH) / DH + 1;
1994:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (khe[ih] > KH) khe[ih] = KH;
1995:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[ih] = khe[ih];
1996:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
1997:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kh_ibeg = khe[ih];
1998:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const mul = (ih+PH) / gcd_h;
1999:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg = ha*mul;
2000:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kh_ibeg, khh);
2001:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg -= m * khh;
2002:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = hb * mul + m * jhh; // var j --> 'm' again
2003:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
2004:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khb[ih] = kh_ibeg;
2005:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2006:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2007:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int iw = 0; iw < IW; ++iw) {
2008:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = (iw + PW) / DW + 1;
2009:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (kwe[iw] > KW) kwe[iw] = KW;
2010:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[iw] = kwe[iw];
2011:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
2012:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kw_ibeg = kwe[iw];
2013:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int const mul = (iw+PW) / gcd_w;
2014:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kw_ibeg = wa * mul;
2015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kw_ibeg, kww);
2016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kw_ibeg -= m * kww;
2017:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = wb * mul + m * jww;
2018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
2019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[iw] = kw_ibeg;
2020:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2021:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2022:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2023:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(5))//;
2024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int g = 0; g < G; ++g) {
2025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
2026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
2027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
2028:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // calc kh_beg, kh_end here? 4.28x
2029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int iw = 0; iw < IW; ++iw) {
2030:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
2031:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float &ds = pdiff_src[src_off];
2032:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ds = 0;
2033:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_beg = khb[ih];
2035:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = khe[ih];
2036:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
2037:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2038:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_beg = kwb[iw];
2039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = kwe[iw];
2040:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
2041:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int oh0=ih+PH - kh_beg*DH;
2043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t d_oc1h = dst_off_f(p, mb, g, 0, oh0/SH, 0);
2044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const size_t w_oc00 = wei_off_f(p, g, 0, ic, 0, 0);
2045:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // using next line is maybe a wee bit slower
2046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //size_t w_oc1h = wei_off_f(p, g, 0, ic, kh_beg, 0);
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ShortLoop() for (int kh = kh_beg; kh < kh_end; kh += khh) {
2048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
2049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //size_t w_oc1h = w_oc1h0;
2050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //if(g==0&&mb==0&&ic==0) cout<<" kh="<<kh<<" oh0="<<oh0<<" (oh0/SH)*OW="<<(oh0/SH)*OW
2051:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ShortLoop() for (int kw = kw_beg; kw < kw_end; kw += kww) {
2053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
2054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t w_oc0 = wei_off_f(p, g, 0, ic, kh, kw);
2055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t w_oc0 = w_oc00 + kh*KW + kw;
2056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t w_oc0b = w_oc1h + kw;
2057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //RT_ASSERT( w_oc0b == w_oc0 );
2058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const size_t d_oc0b = d_oc1h + ow0/SW;
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int oc = 0; oc < OC/G; ++oc) {
2060:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
2061:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
2062:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[dst_off] * pwei[wei_off];
2063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[d_oc0 + oc*OH_OW] * pwei[w_oc0 + oc*ICOG_KH_KW];
2064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0 + oc*ICOG_KH_KW];
2065:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0b + oc*ICOG_KH_KW];
2066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2067:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ow0 -= lcm_w;
2068:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2069:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               oh0 -= lcm_h;
2070:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               d_oc1h -= jhh*OW; // jhh ~ lcm_h/SH
2071:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //w_oc1h += khh*KW;
2072:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2073:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2074:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2075:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2076:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2077:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2078:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2079:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //if(nerr_kh) cout<<" nerr_kh="<<nerr_kh;
2080:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2081:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #error "select one"
2082:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2083:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef G
2084:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef MB
2085:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IC
2086:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OC
2087:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KH
2088:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IH
2089:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OH
2090:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SH
2091:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PH
2092:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KW
2093:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IW
2094:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OW
2095:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SW
2096:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PW
2097:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
2098:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2099:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** Special-case the non-dilation BWD_D code.
2100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * In this case, the postive integer conditional hoistings were
2101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * previously derived (ex. \ref ref_conv3.cpp).  They should agree
2102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * with \c sx_conv_3_fwd hoistings, specialized for DH=1 [DW=1],
2103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * but have been simplified a bit further.
2104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  */
2105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** void sxconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
2106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
2107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 && defined(__ve) // compiler bug! XXX TODO temporarily disabled
2108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   refconv_3_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
2109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
2111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
2112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //float const * restrict const pbia = (float*)bia_m;
2113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
2114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1 // a new simplification of loop limits (same speed as above)
2115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // regr-dilate: 2.50x
2116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
2117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // FIXME can we call this even less?
2118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
2119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //sxconv_3_bwd_d_generic_0(p, diff_src_m, wei_m, diff_dst_m);
2120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     sxconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
2121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     return;
2122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define MAC 0
2124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // SX: MAC=0 ./regr.sh BWD_D 17.0x ---> MAC=1 10.55x; MAC=1+int 
2125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if MAC
2126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define G  p->g
2127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define MB p->mb
2128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IC p->ic
2129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OC p->oc
2130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KH p->kh
2131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IH p->ih
2132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OH p->oh
2133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SH p->sh
2134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PH p->ph
2135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define KW p->kw
2136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define IW p->iw
2137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define OW p->ow
2138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define SW p->sw
2139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PW p->pw
2140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
2141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
2142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC / G;
2143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
2144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int G = p->g;
2146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int MB = p->mb;
2147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int IC = p->ic;
2148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int IH = p->ih;
2149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int IW = p->iw;
2150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OC = p->oc;
2151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OH = p->oh;
2152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OW = p->ow;
2153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int KH = p->kh;
2154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int KW = p->kw;
2155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int PH = p->ph;
2156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int PW = p->pw;
2157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int SH = p->sh;
2158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int SW = p->sw;
2159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int DH = p->dh + 1;
2160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int DW = p->dw + 1;
2161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
2162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
2163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC / G;
2164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
2165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khb[IH], khe[IH], ohb[IH];
2167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int ih = 0; ih < IH; ++ih) {
2168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //int ocend = (OC/G);
2169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[ih] = ih + PH;
2170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohb[ih] = OH - 1;
2171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
2172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
2173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ohb[ih] = khe[ih] / SH;
2174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khb[ih] = khe[ih] % SH;
2175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (++khe[ih] > p->kh) khe[ih] = p->kh;
2177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwb[IW], kwe[IW], owb[IW];
2179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int iw = 0; iw < IW; ++iw) {
2180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = iw + PW;
2181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owb[iw] = OW - 1;
2182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
2183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
2184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       owb[iw] = kwe[iw] / SW;
2185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[iw] = kwe[iw] % SW;
2186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (++kwe[iw] > KW) kwe[iw] = KW;
2188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(4))//;
2190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (ssize_t g = 0; g < G; ++g) {
2191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
2192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
2193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
2194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t src_off0 = src_off_f2(p, mb, g, ic, ih, 0);
2196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t iw = 0; iw < IW; ++iw) {
2197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int kh_e = khe[ih];
2199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int kw_e = kwe[iw];
2200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float tmp = 0.f;
2201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( khb[ih] < kh_e && kwb[iw] < kw_e ) {
2203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + 0) * KW + 0;
2204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t d0 = ((mb * OC + g * OCOG + 0) * OH + 0) * OW + 0;
2205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
2207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
2208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t dst_off0 = ((mb * OC + g * OCOG + 0) * OH + oh) * OW + ow;
2209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const ssize_t wei_off0 = w0 + (ssize_t)((float)kh*KW+(float)kw);
2210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const ssize_t dst_off0 = d0 + (ssize_t)((float)oh*OW+(float)ow);
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t oc = 0; oc < OCOG; ++oc) {
2212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     tmp += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
2214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             pdiff_src[src_off0+iw] = tmp; // MUST always be executed (even to store 0.f)
2220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if MAC
2227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef G
2228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef MB
2229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IC
2230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OC
2231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KH
2232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IH
2233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OH
2234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SH
2235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PH
2236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef KW
2237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef IW
2238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef OW
2239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef SW
2240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #undef PW
2241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #error "please enable one impl"
2244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
2247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** /** This one simplifies the hoisting function much
2249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * like \c sxconv_3_fwd.
2250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *
2251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * - simplify:
2252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * 1. When is oh_beg >= 1?
2253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - (PH - kh*DH +SH-1) / SH >= 1
2254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - PH - kh*DH + SH-1 >= SH
2255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - PH - kh*DH - 1 >= 0
2256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - kh*DH <= PH -1
2257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - kh*DH < PH
2258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - In this case, we can set oh_beg=(PH - kh*DH +SH-1) / SH,
2259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *     - and it is OK if this value is > OH.
2260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * 2. When is oh_end >= OH?
2261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - (IH + PH - kh*DH + SH - 1) / SH >= OH
2262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - IH + PH - kh*DH + SH - 1 >= OH*SH
2263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - kh*DH + 1 <= IH+PH+SH - OH*SH
2264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - kh*DH + OH*SH < IH+PH+SH
2265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - In this case, we may set oh_end = OH,
2266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  * 3. When is oh_end >= 1?
2267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - this is a bit simpler: OH-->1 in above...
2268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - kh*DH < IH+PH
2269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *   - If this is *not* the case, we can set oh_end=0
2270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *     - otherwise (IH + PH - kh*DH + SH - 1) / SH
2271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  *       - (subject to oh_end <= OH)
2272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****  */
2273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** void sxconv_3_bwd_w(const prb_t *p, dnn_mem_t &src_m,
2274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
2275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t G = p->g;
2276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
2277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
2278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
2279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
2280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
2281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
2282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
2283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
2284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
2285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
2286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
2287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
2288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
2289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
2290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DW = p->dw + 1;
2291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG = IC/G;
2292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
2293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC / G;
2294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
2295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH_IW = IH * IW;
2296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH_KW = KH * KW;
2297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH_IW = SH * IW;
2298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const psrc = (float*)src_m;
2299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_wei = (float*)diff_wei_m;
2300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_bia = (float*)diff_bia_m;
2301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
2302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1
2303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // It is hard to measure any speed difference from modifying the bwd_w_bias_update
2304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   auto bwd_w_bias_update = [&](const prb_t* p, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m){
 128              		.loc	1 2304 0
 130 01d0 30090000 		.long	.L_FE.2-8-.
 130      00000000 
 131              	conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const:
 132              		.cfi_startproc
 133 01d8 00000000 		st	%fp,0x0(,%sp)
 133      8B000911 
 134              		.cfi_def_cfa_offset	0
 135              		.cfi_offset	9,0
 136 01e0 08000000 		st	%lr,0x8(,%sp)
 136      8B000A11 
 137 01e8 18000000 		st	%got,0x18(,%sp)
 137      8B000F11 
 138 01f0 20000000 		st	%plt,0x20(,%sp)
 138      8B001011 
 139 01f8 00000000 		or	%fp,0,%sp
 139      8B000945 
 140              		.cfi_def_cfa_register	9
 141 0200 30000000 		st	%s18,48(,%fp)
 141      89001211 
 142 0208 38000000 		st	%s19,56(,%fp)
 142      89001311 
 143 0210 40000000 		st	%s20,64(,%fp)
 143      89001411 
 144 0218 10FEFFFF 		lea	%s13,.L.2.2auto_size&0xffffffff
 144      00000D06 
 145 0220 00000000 		and	%s13,%s13,(32)0
 145      608D0D44 
 146 0228 FFFFFFFF 		lea.sl	%sp,.L.2.2auto_size>>32(%fp,%s13)
 146      8D898B06 
 147 0230 48000000 		brge.l.t	%sp,%sl,.L1.EoP
 147      888B3518 
 148 0238 18000000 		ld	%s61,0x18(,%tp)
 148      8E003D01 
 149 0240 00000000 		or	%s62,0,%s0
 149      80003E45 
 150 0248 3B010000 		lea	%s63,0x13b
 150      00003F06 
 151 0250 00000000 		shm.l	%s63,0x0(%s61)
 151      BD033F31 
 152 0258 08000000 		shm.l	%sl,0x8(%s61)
 152      BD030831 
 153 0260 10000000 		shm.l	%sp,0x10(%s61)
 153      BD030B31 
 154 0268 00000000 		monc
 154      0000003F 
 155 0270 00000000 		or	%s0,0,%s62
 155      BE000045 
 156              	.L1.EoP:
 157              	# End of prologue codes
 158 0278 F8FFFFFF 		st	%s3,-8(,%fp)	# spill 
 158      89000311 
 159 0280 F0FFFFFF 		st	%s0,-16(,%fp)	# spill 
 159      89000011 
 160 0288 E8FFFFFF 		st	%s1,-24(,%fp)	# spill 
 160      89000111 
 161 0290 00000000 		lea	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const@LO
 161      00000006 
 162 0298 00000000 		and	%s0,%s0,(32)0
 162      60800044 
 163 02a0 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const@
 163      80008006 
 164 02a8 08000000 		ld	%s1,8(,%fp)	# ptr
 164      89000101 
 165 02b0 00000000 		lea	%s12,__ftrace_func_enter@LO
 165      00000C06 
 166 02b8 00000000 		and	%s12,%s12,(32)0
 166      608C0C44 
 167 02c0 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
 167      8C008C06 
 168 02c8 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
 168      8C000A08 
 169 02d0 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 169      89000101 
 170              	# line 2305
2305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if ((p->dir & FLAG_BIA)) {
 171              		.loc	1 2305 0
 172 02d8 48000000 		ldl.zx	%s1,72(,%s1)	# *(p).dir
 172      81008103 
 173 02e0 00000000 		adds.w.sx	%s1,0,%s1
 173      8100014A 
 174 02e8 04000000 		lea	%s63,4
 174      00003F06 
 175 02f0 00000000 		and	%s63,%s1,%s63
 175      BF813F44 
 176 02f8 E0070000 		brne.w	0,%s63,.L1.0
 176      BF008318 
 177 0300 28000000 		br.l	.L1.1
 177      00000F18 
 178              	.L1.2:
 179              	# line 2312
2306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int oc = 0; oc < OC     ; ++oc) {
2307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
2308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         float &db = pdiff_bia[bia_off];
2309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         db = 0.f;
2310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         OMP(parallel for collapse(2) reduction(+:db))//;
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int mb = 0; mb < MB; ++mb) {
2312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 180              		.loc	1 2312 0
 181 0308 80000000 		mins.l	%s61,%s59,%s61
 181      BDBB3D68 
 182 0310 F0040000 		br.l	.L1.3
 182      00000F18 
 183              	.L1.4:
 184 0318 80000000 		mins.l	%s60,%s55,%s60
 184      BCB73C68 
 185 0320 C0010000 		br.l	.L1.5
 185      00000F18 
 186              	.L1.1:
 187              	# line 2319
2313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             db += ((float*)diff_dst_m)[dst_off];
2315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   };
 188              		.loc	1 2319 0
 189 0328 00000000 		lea	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const@LO
 189      00000006 
 190 0330 00000000 		and	%s0,%s0,(32)0
 190      60800044 
 191 0338 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const@
 191      80008006 
 192 0340 08000000 		ld	%s1,8(,%fp)	# ptr
 192      89000101 
 193 0348 00000000 		lea	%s12,__ftrace_func_exit@LO
 193      00000C06 
 194 0350 00000000 		and	%s12,%s12,(32)0
 194      608C0C44 
 195 0358 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 195      8C008C06 
 196 0360 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 196      8C000A08 
 197              	# Start of epilogue codes
 198 0368 30000000 		ld	%s18,48(,%fp)
 198      89001201 
 199 0370 38000000 		ld	%s19,56(,%fp)
 199      89001301 
 200 0378 40000000 		ld	%s20,64(,%fp)
 200      89001401 
 201 0380 00000000 		or	%sp,0,%fp
 201      89000B45 
 202              		.cfi_def_cfa	11,8
 203 0388 18000000 		ld	%got,0x18(,%sp)
 203      8B000F01 
 204 0390 20000000 		ld	%plt,0x20(,%sp)
 204      8B001001 
 205 0398 08000000 		ld	%lr,0x8(,%sp)
 205      8B000A01 
 206 03a0 00000000 		ld	%fp,0x0(,%sp)
 206      8B000901 
 207 03a8 00000000 		b.l	(,%lr)
 207      8A000F19 
 208              	.L1.6:
 209              	# line 2306
2306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int oc = 0; oc < OC     ; ++oc) {
 210              		.loc	1 2306 0
 211 03b0 00000000 		adds.l	%s57,1,%s57
 211      B9013959 
 212 03b8 00000000 		adds.l	%s58,4,%s58
 212      BA043A59 
 213 03c0 00000000 		adds.w.sx	%s63,1,%s63
 213      BF013F4A 
 214 03c8 78050000 		brgt.l	0,%s57,.L1.7
 214      B9000118 
 215 03d0 58FFFFFF 		br.l	.L1.1
 215      00000F18 
 216              	.L1.8:
 217 03d8 00000000 		or	%s57,0,%s3
 217      83003945 
 218 03e0 00000000 		or	%s58,0,%s54
 218      B6003A45 
 219 03e8 00000000 		or	%s63,0,%s7
 219      87003F45 
 220 03f0 00000000 		or	%s55,0,%s1
 220      81003745 
 221 03f8 00000000 		or	%s50,0,%s5
 221      85003245 
 222 0400 00000000 		or	%s39,0,%s60
 222      BC002745 
 223 0408 00000000 		or	%s40,0,%s56
 223      B8002845 
 224 0410 00000000 		or	%s56,0,%s49
 224      B1003845 
 225 0418 00000000 		or	%s52,0,%s2
 225      82003445 
 226 0420 00000000 		or	%s62,0,%s4
 226      84003E45 
 227 0428 00000000 		or	%s51,0,%s6
 227      86003345 
 228 0430 80FFFFFF 		br.l	.L1.6
 228      00000F18 
 229              	.L1.9:
 230              	# line 2311
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 231              		.loc	1 2311 0
 232 0438 00000000 		adds.l	%s61,4,%s61
 232      BD043D59 
 233 0440 00000000 		adds.l	%s63,%s63,%s60
 233      BCBF3F59 
 234 0448 00000000 		adds.l	%s59,%s59,%s56
 234      B8BB3B59 
 235 0450 00000000 		adds.l	%s58,%s58,%s56
 235      B8BA3A59 
 236 0458 00000000 		adds.l	%s57,%s57,%s56
 236      B8B93959 
 237 0460 C8010000 		brgt.l	0,%s61,.L1.10
 237      BD000118 
 238 0468 70FFFFFF 		br.l	.L1.8
 238      00000F18 
 239              	.L1.11:
 240              	# line 2315
2315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
 241              		.loc	1 2315 0
 242 0470 00000000 		or	%s62,1,(0)1
 242      00013E45 
 243 0478 00000000 		or	%s55,0,%s54
 243      B6003745 
 244 0480 00000000 		lvl	%s62
 244      00BE00BF 
 245 0488 00000034 		vstu.nc	%v52,0,%s55
 245      B7000092 
 246 0490 A8FFFFFF 		br.l	.L1.9
 246      00000F18 
 247              	.L1.12:
 248              	# line 2314
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 249              		.loc	1 2314 0
 250 0498 00000000 		lvl	%s53
 250      00B500BF 
 251 04a0 00003D32 		vfsum.s	%v50,%v61
 251      000080EC 
 252 04a8 00000000 		or	%s62,1,(0)1
 252      00013E45 
 253 04b0 00000000 		lvl	%s62
 253      00BE00BF 
 254 04b8 00323434 		vfadd.s	%v52,%v52,%v50
 254      000080CC 
 255 04c0 00000000 		or	%s61,0,%s52
 255      B4003D45 
 256 04c8 00000000 		or	%s60,0,%s51
 256      B3003C45 
 257 04d0 00000000 		or	%s56,0,%s50
 257      B2003845 
 258 04d8 98FFFFFF 		br.l	.L1.11
 258      00000F18 
 259              	.L1.5:
 260 04e0 00000000 		adds.l	%s62,%s63,(0)1
 260      00BF3E59 
 261 04e8 00000000 		adds.l	%s62,%s62,%s61
 261      BDBE3E59 
 262 04f0 00000000 		lvl	%s60
 262      00BC00BF 
 263 04f8 0000003C 		vldu.nc	%v60,4,%s62
 263      BE040082 
 264 0500 00000000 		adds.l	%s62,%s59,(0)1
 264      00BB3E59 
 265 0508 00000000 		adds.l	%s62,%s62,%s61
 265      BDBE3E59 
 266 0510 0000003B 		vldu.nc	%v59,4,%s62
 266      BE040082 
 267 0518 003B3C3A 		vfadd.s	%v58,%v60,%v59
 267      000080CC 
 268 0520 00000000 		adds.l	%s62,%s58,(0)1
 268      00BA3E59 
 269 0528 00000000 		adds.l	%s62,%s62,%s61
 269      BDBE3E59 
 270 0530 00000039 		vldu.nc	%v57,4,%s62
 270      BE040082 
 271 0538 00393A38 		vfadd.s	%v56,%v58,%v57
 271      000080CC 
 272 0540 00000000 		adds.l	%s62,%s57,(0)1
 272      00B93E59 
 273 0548 00000000 		adds.l	%s62,%s62,%s61
 273      BDBE3E59 
 274 0550 00000037 		vldu.nc	%v55,4,%s62
 274      BE040082 
 275 0558 00373836 		vfadd.s	%v54,%v56,%v55
 275      000080CC 
 276 0560 00363D3D 		vfadd.s	%v61,%v61,%v54
 276      000080CC 
 277              	# line 2312
2312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 278              		.loc	1 2312 0
 279 0568 00000000 		adds.l	%s61,%s61,%s56
 279      B8BD3D59 
 280 0570 00000000 		subs.l	%s55,%s55,%s60
 280      BCB7375B 
 281 0578 20FFFFFF 		brge.l	0,%s55,.L1.12
 281      B7000518 
 282 0580 98FDFFFF 		br.l	.L1.4
 282      00000F18 
 283              	.L1.13:
 284 0588 00000000 		subs.l	%s62,0,%s49
 284      B1003E5B 
 285 0590 00000000 		smvl	%s53
 285      0000352E 
 286 0598 80000000 		mins.l	%s48,%s62,%s53
 286      B5BE3068 
 287              	# line 2314
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 288              		.loc	1 2314 0
 289 05a0 00000000 		or	%s47,0,(0)1
 289      00002F45 
 290 05a8 00000000 		or	%s52,0,%s61
 290      BD003445 
 291 05b0 00000000 		or	%s51,0,%s60
 291      BC003345 
 292 05b8 00000000 		or	%s50,0,%s56
 292      B8003245 
 293 05c0 00000000 		or	%s60,0,%s48
 293      B0003C45 
 294 05c8 00000000 		lvl	%s53
 294      00B500BF 
 295 05d0 0000003D 		vbrdu	%v61,%s47
 295      00AF808C 
 296 05d8 00000000 		or	%s55,0,%s62
 296      BE003745 
 297              	# line 2312
2312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 298              		.loc	1 2312 0
 299 05e0 00000000 		or	%s61,0,(0)1
 299      00003D45 
 300 05e8 00000000 		muls.l	%s56,4,%s48
 300      B004386E 
 301 05f0 F0FEFFFF 		br.l	.L1.5
 301      00000F18 
 302              	.L1.14:
 303 05f8 00000000 		or	%s55,1,(0)1
 303      00013745 
 304 0600 00000000 		or	%s53,0,%s54
 304      B6003545 
 305 0608 00000000 		lvl	%s55
 305      00B700BF 
 306 0610 00000034 		vldu.nc	%v52,0,%s53
 306      B5000082 
 307 0618 70FFFFFF 		brlt.l	0,%s18,.L1.13
 307      92000218 
 308 0620 50FEFFFF 		br.l	.L1.11
 308      00000F18 
 309              	.L1.10:
 310 0628 D0FFFFFF 		brlt.l	0,%s18,.L1.14
 310      92000218 
 311 0630 08FEFFFF 		br.l	.L1.9
 311      00000F18 
 312              	.L1.15:
 313 0638 00000000 		or	%s53,0,%s63
 313      BF003545 
 314 0640 00000000 		or	%s48,0,%s20
 314      94003045 
 315              	# line 2311
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 316              		.loc	1 2311 0
 317 0648 00000000 		adds.l	%s61,%s48,%s46
 317      AEB03D59 
 318 0650 00000000 		muls.l	%s47,%s53,%s51
 318      B3B52F6E 
 319 0658 00000000 		or	%s49,0,%s56
 319      B8003145 
 320 0660 00000000 		or	%s54,0,%s58
 320      BA003645 
 321 0668 00000000 		adds.l	%s47,%s47,%s50
 321      B2AF2F59 
 322 0670 00000000 		muls.l	%s41,%s48,%s62
 322      BEB0296E 
 323 0678 00000000 		or	%s1,0,%s55
 323      B7000145 
 324 0680 00000000 		or	%s2,0,%s52
 324      B4000245 
 325 0688 00000000 		adds.l	%s41,%s47,%s41
 325      A9AF2959 
 326 0690 00000000 		muls.l	%s55,%s53,%s51
 326      B3B5376E 
 327 0698 00000000 		or	%s3,0,%s57
 327      B9000345 
 328 06a0 00000000 		or	%s4,0,%s62
 328      BE000445 
 329 06a8 00000000 		adds.l	%s55,%s55,%s45
 329      ADB73759 
 330 06b0 00000000 		muls.l	%s62,%s48,%s44
 330      ACB03E6E 
 331 06b8 00000000 		or	%s5,0,%s50
 331      B2000545 
 332 06c0 00000000 		or	%s6,0,%s51
 332      B3000645 
 333 06c8 00000000 		adds.l	%s59,%s55,%s62
 333      BEB73B59 
 334 06d0 00000000 		muls.l	%s62,%s53,%s51
 334      B3B53E6E 
 335 06d8 00000000 		or	%s7,0,%s63
 335      BF000745 
 336 06e0 00000000 		or	%s63,0,%s41
 336      A9003F45 
 337 06e8 00000000 		adds.l	%s62,%s62,%s43
 337      ABBE3E59 
 338 06f0 00000000 		muls.l	%s55,%s48,%s44
 338      ACB0376E 
 339 06f8 00000000 		adds.l	%s58,%s62,%s55
 339      B7BE3A59 
 340 0700 00000000 		muls.l	%s51,%s53,%s51
 340      B3B5336E 
 341 0708 00000000 		adds.l	%s51,%s51,%s42
 341      AAB33359 
 342 0710 00000000 		muls.l	%s48,%s48,%s44
 342      ACB0306E 
 343 0718 00000000 		adds.l	%s57,%s51,%s48
 343      B0B33959 
 344 0720 00000000 		or	%s56,0,%s40
 344      A8003845 
 345 0728 00000000 		or	%s60,0,%s39
 345      A7003C45 
 346 0730 F8FEFFFF 		br.l	.L1.10
 346      00000F18 
 347              	.L1.16:
 348 0738 00FFFFFF 		brlt.l	%s55,%s19,.L1.15
 348      93B70218 
 349 0740 70FCFFFF 		br.l	.L1.6
 349      00000F18 
 350              	.L1.17:
 351 0748 00000000 		or	%s55,0,%s4
 351      84003745 
 352 0750 00000000 		or	%s63,0,%s5
 352      85003F45 
 353 0758 00000000 		or	%s57,0,%s6
 353      86003945 
 354 0760 D8FFFFFF 		br.l	.L1.16
 354      00000F18 
 355              	.L1.18:
 356 0768 78010000 		br.l	.L1.19
 356      00000F18 
 357              	.L1.20:
 358 0770 00000000 		adds.w.sx	%s63,1,%s63
 358      BF013F4A 
 359 0778 00000000 		adds.l	%s61,%s62,%s61
 359      BDBE3D59 
 360 0780 E8FFFFFF 		brgt.w	0,%s63,.L1.18
 360      BF008118 
 361 0788 C0FFFFFF 		br.l	.L1.17
 361      00000F18 
 362              	.L1.21:
 363              	# line 2315
2315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
 364              		.loc	1 2315 0
 365 0790 00000000 		or	%s60,1,(0)1
 365      00013C45 
 366 0798 00000000 		or	%s59,0,%s58
 366      BA003B45 
 367 07a0 00000000 		lvl	%s60
 367      00BC00BF 
 368 07a8 00000035 		vstu.nc	%v53,0,%s59
 368      BB000092 
 369 07b0 C0FFFFFF 		br.l	.L1.20
 369      00000F18 
 370              	.L1.22:
 371 07b8 00000000 		or	%s61,0,%s3
 371      83003D45 
 372 07c0 00000000 		or	%s62,0,%s2
 372      82003E45 
 373 07c8 00000000 		or	%s63,0,%s1
 373      81003F45 
 374              	# line 2314
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 375              		.loc	1 2314 0
 376 07d0 00000000 		lvl	%s55
 376      00B700BF 
 377 07d8 00003F33 		vfsum.s	%v51,%v63
 377      000080EC 
 378 07e0 00000000 		or	%s60,1,(0)1
 378      00013C45 
 379 07e8 00000000 		lvl	%s60
 379      00BC00BF 
 380 07f0 00333535 		vfadd.s	%v53,%v53,%v51
 380      000080CC 
 381 07f8 98FFFFFF 		br.l	.L1.21
 381      00000F18 
 382              	.L1.3:
 383 0800 00000000 		or	%s62,0,%s63
 383      BF003E45 
 384 0808 00000000 		lvl	%s61
 384      00BD00BF 
 385 0810 0000003E 		vldu.nc	%v62,4,%s62
 385      BE040082 
 386 0818 003E3F3F 		vfadd.s	%v63,%v63,%v62
 386      000080CC 
 387              	# line 2312
2312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 388              		.loc	1 2312 0
 389 0820 00000000 		adds.l	%s63,%s63,%s60
 389      BCBF3F59 
 390 0828 00000000 		subs.l	%s59,%s59,%s61
 390      BDBB3B5B 
 391 0830 88FFFFFF 		brge.l	0,%s59,.L1.22
 391      BB000518 
 392 0838 D0FAFFFF 		br.l	.L1.2
 392      00000F18 
 393              	.L1.23:
 394 0840 00000000 		subs.l	%s57,0,%s56
 394      B800395B 
 395 0848 00000000 		smvl	%s55
 395      0000372E 
 396 0850 80000000 		mins.l	%s54,%s57,%s55
 396      B7B93668 
 397              	# line 2314
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 398              		.loc	1 2314 0
 399 0858 00000000 		or	%s53,0,(0)1
 399      00003545 
 400 0860 00000000 		or	%s1,0,%s63
 400      BF000145 
 401 0868 00000000 		or	%s2,0,%s62
 401      BE000245 
 402 0870 00000000 		or	%s3,0,%s61
 402      BD000345 
 403 0878 00000000 		lvl	%s55
 403      00B700BF 
 404 0880 0000003F 		vbrdu	%v63,%s53
 404      00B5808C 
 405 0888 00000000 		or	%s59,0,%s57
 405      B9003B45 
 406 0890 00000000 		or	%s63,0,%s61
 406      BD003F45 
 407              	# line 2312
2312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 408              		.loc	1 2312 0
 409 0898 00000000 		muls.l	%s60,4,%s54
 409      B6043C6E 
 410 08a0 00000000 		or	%s61,0,%s54
 410      B6003D45 
 411 08a8 58FFFFFF 		br.l	.L1.3
 411      00000F18 
 412              	.L1.24:
 413 08b0 00000000 		or	%s59,1,(0)1
 413      00013B45 
 414 08b8 00000000 		or	%s57,0,%s58
 414      BA003945 
 415 08c0 00000000 		lvl	%s59
 415      00BB00BF 
 416 08c8 00000035 		vldu.nc	%v53,0,%s57
 416      B9000082 
 417 08d0 70FFFFFF 		brlt.l	0,%s18,.L1.23
 417      92000218 
 418 08d8 B8FEFFFF 		br.l	.L1.21
 418      00000F18 
 419              	.L1.19:
 420 08e0 D0FFFFFF 		brlt.l	0,%s18,.L1.24
 420      92000218 
 421 08e8 88FEFFFF 		br.l	.L1.20
 421      00000F18 
 422              	.L1.25:
 423 08f0 00000000 		or	%s4,0,%s55
 423      B7000445 
 424 08f8 00000000 		or	%s5,0,%s63
 424      BF000545 
 425 0900 00000000 		or	%s63,0,%s52
 425      B4003F45 
 426              	# line 2311
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 427              		.loc	1 2311 0
 428 0908 00000000 		muls.l	%s60,%s61,%s51
 428      B3BD3C6E 
 429 0910 00000000 		or	%s6,0,%s57
 429      B9000645 
 430 0918 00000000 		adds.l	%s60,%s60,%s50
 430      B2BC3C59 
 431 0920 00000000 		or	%s61,0,%s60
 431      BC003D45 
 432 0928 B8FFFFFF 		br.l	.L1.19
 432      00000F18 
 433              	.L1.26:
 434 0930 C0FFFFFF 		brlt.w	0,%s20,.L1.25
 434      94008218 
 435 0938 00FEFFFF 		br.l	.L1.16
 435      00000F18 
 436              	.L1.7:
 437 0940 00000000 		or	%s61,0,%s63
 437      BF003D45 
 438              	# line 2309
2309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         OMP(parallel for collapse(2) reduction(+:db))//;
 439              		.loc	1 2309 0
 440 0948 00000000 		or	%s59,0,(0)1
 440      00003B45 
 441 0950 00000000 		stu	%s59,0(,%s58)	# *(db)
 441      BA003B12 
 442 0958 D8FFFFFF 		brlt.l	0,%s19,.L1.26
 442      93000218 
 443 0960 50FAFFFF 		br.l	.L1.6
 443      00000F18 
 444              	.L1.27:
 445 0968 F0FFFFFF 		ld	%s0,-16(,%fp)	# restore 
 445      89000001 
 446 0970 08000000 		dld	%s61,8(,%s0)	# *(this).pdiff_bia
 446      80003D09 
 447 0978 00000000 		dld	%s61,0(,%s61)	# *(*(this).pdiff_bia)
 447      BD003D09 
 448 0980 00000000 		or	%s58,0,%s61
 448      BD003A45 
 449              	# line 2311
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 450              		.loc	1 2311 0
 451 0988 10000000 		dld	%s61,16(,%s0)	# *(this).MB
 451      80003D09 
 452 0990 00000000 		dld	%s19,0(,%s61)	# *(*(this).MB)
 452      BD001309 
 453 0998 00000000 		subs.l	%s46,0,%s19
 453      93002E5B 
 454 09a0 00000000 		and	%s61,%s19,(62)0
 454      7E933D44 
 455 09a8 00000000 		adds.w.sx	%s20,0,%s61
 455      BD00144A 
 456 09b0 00000000 		or	%s55,0,%s20
 456      94003745 
 457 09b8 00000000 		subs.w.sx	%s52,0,%s20
 457      9400345A 
 458              	# line 2312
2312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t dst_off = dst_off_f_nog_ohw(p, mb, /*g,*/ oc, ohw);
 459              		.loc	1 2312 0
 460 09c0 18000000 		dld	%s61,24(,%s0)	# *(this).OH
 460      80003D09 
 461 09c8 00000000 		dld	%s61,0(,%s61)	# *(*(this).OH)
 461      BD003D09 
 462 09d0 20000000 		dld	%s0,32(,%s0)	# *(this).OW
 462      80000009 
 463 09d8 00000000 		dld	%s0,0(,%s0)	# *(*(this).OW)
 463      80000009 
 464 09e0 00000000 		muls.l	%s18,%s61,%s0
 464      80BD126E 
 465 09e8 00000000 		subs.l	%s56,0,%s18
 465      9200385B 
 466 09f0 F8FFFFFF 		ld	%s3,-8(,%fp)	# restore 
 466      89000301 
 467 09f8 A8010000 		dld	%s50,424(,%s3)	# *(s$177).data_
 467      83003209 
 468              	# line 2306
2306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 469              		.loc	1 2306 0
 470 0a00 00000000 		subs.l	%s61,0,%s62
 470      BE003D5B 
 471 0a08 00000000 		or	%s57,0,%s61
 471      BD003945 
 472 0a10 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 472      89000101 
 473              	# line 2314
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 474              		.loc	1 2314 0
 475 0a18 14000000 		dldl.sx	%s61,20(,%s1)	# *(p).__b_N4conv6desc_tE.oc
 475      81003D0B 
 476 0a20 00000000 		or	%s61,0,%s61
 476      BD003D45 
 477 0a28 00000000 		or	%s61,0,%s61
 477      BD003D45 
 478 0a30 18000000 		dldl.sx	%s60,24(,%s1)	# *(p).__b_N4conv6desc_tE.oh
 478      81003C0B 
 479 0a38 00000000 		or	%s60,0,%s60
 479      BC003C45 
 480 0a40 00000000 		or	%s60,0,%s60
 480      BC003C45 
 481              	# line 2311
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 482              		.loc	1 2311 0
 483 0a48 00000000 		muls.l	%s59,%s61,%s60
 483      BCBD3B6E 
 484              	# line 2314
2314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 485              		.loc	1 2314 0
 486 0a50 1C000000 		dldl.sx	%s1,28(,%s1)	# *(p).__b_N4conv6desc_tE.ow
 486      8100010B 
 487 0a58 00000000 		or	%s1,0,%s1
 487      81000145 
 488 0a60 00000000 		or	%s1,0,%s1
 488      81000145 
 489              	# line 2311
2311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int ohw = 0; ohw < OH*OW; ++ohw) {
 490              		.loc	1 2311 0
 491 0a68 00000000 		muls.l	%s59,%s1,%s59
 491      BB813B6E 
 492 0a70 00000000 		muls.l	%s54,8,%s59
 492      BB08366E 
 493 0a78 00000000 		adds.l	%s43,%s50,%s54
 493      B6B22B59 
 494 0a80 00000000 		muls.l	%s1,%s60,%s1
 494      81BC016E 
 495 0a88 00000000 		muls.l	%s62,4,%s59
 495      BB043E6E 
 496 0a90 00000000 		muls.l	%s39,4,%s62
 496      BE04276E 
 497 0a98 00000000 		muls.l	%s61,4,%s61
 497      BD043D6E 
 498 0aa0 00000000 		muls.l	%s44,%s61,%s1
 498      81BD2C6E 
 499 0aa8 00000000 		muls.l	%s40,4,%s44
 499      AC04286E 
 500 0ab0 00000000 		adds.l	%s45,%s50,%s44
 500      ACB22D59 
 501 0ab8 00000000 		muls.l	%s51,4,%s1
 501      8104336E 
 502 0ac0 00000000 		muls.l	%s59,12,%s59
 502      BB0C3B6E 
 503 0ac8 00000000 		adds.l	%s42,%s50,%s59
 503      BBB22A59 
 504 0ad0 70FEFFFF 		br.l	.L1.7
 504      00000F18 
 505              	.L1.0:
 506              	# line 2306
2306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         size_t bia_off = bia_off_f_nog(p, /*g,*/ oc);
 507              		.loc	1 2306 0
 508 0ad8 00000000 		or	%s63,0,(0)1
 508      00003F45 
 509 0ae0 F0FFFFFF 		ld	%s0,-16(,%fp)	# restore 
 509      89000001 
 510 0ae8 00000000 		ld	%s62,0(,%s0)	# *(this).OC
 510      80003E01 
 511 0af0 00000000 		ld	%s62,0(,%s62)	# *(*(this).OC)
 511      BE003E01 
 512 0af8 70FEFFFF 		brlt.l	0,%s62,.L1.27
 512      BE000218 
 513 0b00 28F8FFFF 		br.l	.L1.1
 513      00000F18 
 514              		.cfi_endproc
 515              		.set	.L.2.2auto_size,	0xfffffffffffffe10	# 496 Bytes
 517              	.L_FE.2:
 518 0b08 636F6E76 		.string	"conv::sxconv_3_bwd_w(const conv::prb_t *, dnn_mem_t &, dnn_mem_t &, dnn_mem_t &, dnn_mem_
 518      3A3A7378 
 518      636F6E76 
 518      5F335F62 
 518      77645F77 
 519              	# ============ End  _ZZN4conv14sxconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_clES2
 520              	# ============ Begin  _INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::chk(bool, char const*, char const*, int) ============
 521              		.section .rodata
 522              		.balign 16
 524              	.LP.__string.0:
 525 0000 40       		.byte	64
 526 0001 40       		.byte	64
 527 0002 40       		.byte	64
 528 0003 20       		.byte	32
 529 0004 65       		.byte	101
 530 0005 72       		.byte	114
 531 0006 72       		.byte	114
 532 0007 6F       		.byte	111
 533 0008 72       		.byte	114
 534 0009 3A       		.byte	58
 535 000a 20       		.byte	32
 536 000b 25       		.byte	37
 537 000c 73       		.byte	115
 538 000d 20       		.byte	32
 539 000e 3A       		.byte	58
 540 000f 20       		.byte	32
 541 0010 5B       		.byte	91
 542 0011 25       		.byte	37
 543 0012 73       		.byte	115
 544 0013 3A       		.byte	58
 545 0014 25       		.byte	37
 546 0015 64       		.byte	100
 547 0016 5D       		.byte	93
 548 0017 0A       		.byte	10
 549 0018 00       		.zero	1
 550              		.text
 551              		.balign 16
 552              	# line 42
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
 553              		.loc	1 42 0
 555 0bc0 20020000 		.long	.L_FE.3-8-.
 555      00000000 
 556              	_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::chk(bool, char const*, char const*, int):
 557              		.cfi_startproc
 558 0bc8 00000000 		st	%fp,0x0(,%sp)
 558      8B000911 
 559              		.cfi_def_cfa_offset	0
 560              		.cfi_offset	9,0
 561 0bd0 08000000 		st	%lr,0x8(,%sp)
 561      8B000A11 
 562 0bd8 18000000 		st	%got,0x18(,%sp)
 562      8B000F11 
 563 0be0 20000000 		st	%plt,0x20(,%sp)
 563      8B001011 
 564 0be8 00000000 		or	%fp,0,%sp
 564      8B000945 
 565              		.cfi_def_cfa_register	9
 566 0bf0 30000000 		st	%s18,48(,%fp)
 566      89001211 
 567 0bf8 F0FDFFFF 		lea	%s13,.L.3.2auto_size&0xffffffff
 567      00000D06 
 568 0c00 00000000 		and	%s13,%s13,(32)0
 568      608D0D44 
 569 0c08 FFFFFFFF 		lea.sl	%sp,.L.3.2auto_size>>32(%fp,%s13)
 569      8D898B06 
 570 0c10 48000000 		brge.l.t	%sp,%sl,.L2.EoP
 570      888B3518 
 571 0c18 18000000 		ld	%s61,0x18(,%tp)
 571      8E003D01 
 572 0c20 00000000 		or	%s62,0,%s0
 572      80003E45 
 573 0c28 3B010000 		lea	%s63,0x13b
 573      00003F06 
 574 0c30 00000000 		shm.l	%s63,0x0(%s61)
 574      BD033F31 
 575 0c38 08000000 		shm.l	%sl,0x8(%s61)
 575      BD030831 
 576 0c40 10000000 		shm.l	%sp,0x10(%s61)
 576      BD030B31 
 577 0c48 00000000 		monc
 577      0000003F 
 578 0c50 00000000 		or	%s0,0,%s62
 578      BE000045 
 579              	.L2.EoP:
 580              	# End of prologue codes
 581 0c58 F8FFFFFF 		st	%s3,-8(,%fp)	# spill 
 581      89000311 
 582 0c60 F0FFFFFF 		st	%s2,-16(,%fp)	# spill 
 582      89000211 
 583 0c68 E8FFFFFF 		st	%s1,-24(,%fp)	# spill 
 583      89000111 
 584 0c70 E0FFFFFF 		st	%s0,-32(,%fp)	# spill 
 584      89000011 
 585 0c78 00000000 		lea	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::chk(bool, char const*, char const*, int)@LO
 585      00000006 
 586 0c80 00000000 		and	%s0,%s0,(32)0
 586      60800044 
 587 0c88 00000000 		lea.sl	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::chk(bool, char const*, char const*, int)@HI(,%s0)
 587      80008006 
 588 0c90 08000000 		ld	%s1,8(,%fp)	# ptr
 588      89000101 
 589 0c98 00000000 		lea	%s12,__ftrace_func_enter@LO
 589      00000C06 
 590 0ca0 00000000 		and	%s12,%s12,(32)0
 590      608C0C44 
 591 0ca8 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
 591      8C008C06 
 592 0cb0 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
 592      8C000A08 
 593 0cb8 E0FFFFFF 		ld	%s18,-32(,%fp)	# restore 
 593      89001201 
 594 0cc0 88000000 		breq.w	0,%s18,.L2.0
 594      92008418 
 595 0cc8 08000000 		br.l	.L2.1
 595      00000F18 
 596              	.L2.1:
 597              	# line 44
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** static bool trivial( int const verb, bool const cond, char const* msg,
 598              		.loc	1 44 0
 599 0cd0 00000000 		lea	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::chk(bool, char const*, char const*, int)@LO
 599      00000006 
 600 0cd8 00000000 		and	%s0,%s0,(32)0
 600      60800044 
 601 0ce0 00000000 		lea.sl	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::chk(bool, char const*, char const*, int)@HI(,%s0)
 601      80008006 
 602 0ce8 08000000 		ld	%s1,8(,%fp)	# ptr
 602      89000101 
 603 0cf0 00000000 		lea	%s12,__ftrace_func_exit@LO
 603      00000C06 
 604 0cf8 00000000 		and	%s12,%s12,(32)0
 604      608C0C44 
 605 0d00 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 605      8C008C06 
 606 0d08 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 606      8C000A08 
 607              	# Start of epilogue codes
 608 0d10 30000000 		ld	%s18,48(,%fp)
 608      89001201 
 609 0d18 00000000 		or	%sp,0,%fp
 609      89000B45 
 610              		.cfi_def_cfa	11,8
 611 0d20 18000000 		ld	%got,0x18(,%sp)
 611      8B000F01 
 612 0d28 20000000 		ld	%plt,0x20(,%sp)
 612      8B001001 
 613 0d30 08000000 		ld	%lr,0x8(,%sp)
 613      8B000A01 
 614 0d38 00000000 		ld	%fp,0x0(,%sp)
 614      8B000901 
 615 0d40 00000000 		b.l	(,%lr)
 615      8A000F19 
 616              	.L2.0:
 617              	# line 43
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 618              		.loc	1 43 0
 619 0d48 00000000 		lea	%s0,.LP.__string.0@LO
 619      00000006 
 620 0d50 00000000 		and	%s0,%s0,(32)0
 620      60800044 
 621 0d58 00000000 		lea.sl	%s0,.LP.__string.0@HI(,%s0)
 621      80008006 
 622 0d60 B0000000 		st	%s0,176(,%sp)
 622      8B000011 
 623 0d68 E8FFFFFF 		ld	%s1,-24(,%fp)	# restore 
 623      89000101 
 624 0d70 B8000000 		st	%s1,184(,%sp)
 624      8B000111 
 625 0d78 F0FFFFFF 		ld	%s2,-16(,%fp)	# restore 
 625      89000201 
 626 0d80 C0000000 		st	%s2,192(,%sp)
 626      8B000211 
 627 0d88 F8FFFFFF 		ld	%s3,-8(,%fp)	# restore 
 627      89000301 
 628 0d90 C8000000 		st	%s3,200(,%sp)
 628      8B000311 
 629 0d98 00000000 		lea	%s12,printf@LO
 629      00000C06 
 630 0da0 00000000 		and	%s12,%s12,(32)0
 630      608C0C44 
 631 0da8 00000000 		lea.sl	%s12,printf@HI(,%s12)
 631      8C008C06 
 632 0db0 00000000 		bsic	%lr,(,%s12)	# printf
 632      8C000A08 
 633 0db8 00000000 		or	%s0,1,(0)1
 633      00010045 
 634 0dc0 00000000 		lea	%s12,exit@LO
 634      00000C06 
 635 0dc8 00000000 		and	%s12,%s12,(32)0
 635      608C0C44 
 636 0dd0 00000000 		lea.sl	%s12,exit@HI(,%s12)
 636      8C008C06 
 637 0dd8 00000000 		bsic	%lr,(,%s12)	# exit
 637      8C000A08 
 638 0de0 F0FEFFFF 		br.l	.L2.1
 638      00000F18 
 639              		.cfi_endproc
 640              		.set	.L.3.2auto_size,	0xfffffffffffffdf0	# 528 Bytes
 642              	.L_FE.3:
 643 0de8 5B6C6F63 		.string	"[local to sx_conv3_ve_cpp]::conv::chk\000 "
 643      616C2074 
 643      6F207378 
 643      5F636F6E 
 643      76335F76 
 644              	# ============ End  _INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::chk(bool, char const*, char const*, int) ============
 645              	# ============ Begin  _INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::gcd(int, int) ============
 646              		.balign 16
 647              	# line 69
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (;;)
 648              		.loc	1 69 0
 650 0e10 00020000 		.long	.L_FE.4-8-.
 650      00000000 
 651              	_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::gcd(int, int):
 652              		.cfi_startproc
 653 0e18 00000000 		st	%fp,0x0(,%sp)
 653      8B000911 
 654              		.cfi_def_cfa_offset	0
 655              		.cfi_offset	9,0
 656 0e20 08000000 		st	%lr,0x8(,%sp)
 656      8B000A11 
 657 0e28 18000000 		st	%got,0x18(,%sp)
 657      8B000F11 
 658 0e30 20000000 		st	%plt,0x20(,%sp)
 658      8B001011 
 659 0e38 00000000 		or	%fp,0,%sp
 659      8B000945 
 660              		.cfi_def_cfa_register	9
 661 0e40 30000000 		st	%s18,48(,%fp)
 661      89001211 
 662 0e48 58000000 		st	%s23,88(,%fp)
 662      89001711 
 663 0e50 20FEFFFF 		lea	%s13,.L.4.2auto_size&0xffffffff
 663      00000D06 
 664 0e58 00000000 		and	%s13,%s13,(32)0
 664      608D0D44 
 665 0e60 FFFFFFFF 		lea.sl	%sp,.L.4.2auto_size>>32(%fp,%s13)
 665      8D898B06 
 666 0e68 48000000 		brge.l.t	%sp,%sl,.L3.EoP
 666      888B3518 
 667 0e70 18000000 		ld	%s61,0x18(,%tp)
 667      8E003D01 
 668 0e78 00000000 		or	%s62,0,%s0
 668      80003E45 
 669 0e80 3B010000 		lea	%s63,0x13b
 669      00003F06 
 670 0e88 00000000 		shm.l	%s63,0x0(%s61)
 670      BD033F31 
 671 0e90 08000000 		shm.l	%sl,0x8(%s61)
 671      BD030831 
 672 0e98 10000000 		shm.l	%sp,0x10(%s61)
 672      BD030B31 
 673 0ea0 00000000 		monc
 673      0000003F 
 674 0ea8 00000000 		or	%s0,0,%s62
 674      BE000045 
 675              	.L3.EoP:
 676              	# End of prologue codes
 677 0eb0 F8FFFFFF 		st	%s0,-8(,%fp)	# spill 
 677      89000011 
 678 0eb8 F0FFFFFF 		st	%s1,-16(,%fp)	# spill 
 678      89000111 
 679 0ec0 00000000 		lea	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::gcd(int, int)@LO
 679      00000006 
 680 0ec8 00000000 		and	%s0,%s0,(32)0
 680      60800044 
 681 0ed0 00000000 		lea.sl	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::gcd(int, int)@HI(,%s0)
 681      80008006 
 682 0ed8 08000000 		ld	%s1,8(,%fp)	# ptr
 682      89000101 
 683 0ee0 00000000 		lea	%s12,__ftrace_func_enter@LO
 683      00000C06 
 684 0ee8 00000000 		and	%s12,%s12,(32)0
 684      608C0C44 
 685 0ef0 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
 685      8C008C06 
 686 0ef8 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
 686      8C000A08 
 687 0f00 F8FFFFFF 		ld	%s18,-8(,%fp)	# restore 
 687      89001201 
 688 0f08 F0FFFFFF 		ld	%s63,-16(,%fp)	# restore 
 688      89003F01 
 689 0f10 F8000000 		br.l	.L3.0
 689      00000F18 
 690              	.L3.1:
 691              	# line 75
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 692              		.loc	1 75 0
 693 0f18 00000000 		divs.w.sx	%s62,%s18,%s63
 693      BF923E7B 
 694 0f20 00000000 		muls.w.sx	%s62,%s63,%s62
 694      BEBF3E4B 
 695 0f28 00000000 		subs.w.sx	%s18,%s18,%s62
 695      BE92125A 
 696 0f30 D8000000 		br.l	.L3.0
 696      00000F18 
 697              	.L3.2:
 698 0f38 00000000 		or	%s23,0,%s18
 698      92001745 
 699 0f40 30000000 		br.l	.L3.3
 699      00000F18 
 700              	.L3.4:
 701              	# line 73
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         if (b == 0) return a;
 702              		.loc	1 73 0
 703 0f48 00000000 		divs.w.sx	%s62,%s63,%s18
 703      92BF3E7B 
 704 0f50 00000000 		muls.w.sx	%s62,%s18,%s62
 704      BE923E4B 
 705 0f58 00000000 		subs.w.sx	%s63,%s63,%s62
 705      BEBF3F5A 
 706 0f60 D8FFFFFF 		breq.w	0,%s63,.L3.2
 706      BF008418 
 707 0f68 B0FFFFFF 		br.l	.L3.1
 707      00000F18 
 708              	.L3.3:
 709              	# line 74
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         a %= b;
 710              		.loc	1 74 0
 711 0f70 00000000 		lea	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::gcd(int, int)@LO
 711      00000006 
 712 0f78 00000000 		and	%s0,%s0,(32)0
 712      60800044 
 713 0f80 00000000 		lea.sl	%s0,_INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::gcd(int, int)@HI(,%s0)
 713      80008006 
 714 0f88 08000000 		ld	%s1,8(,%fp)	# ptr
 714      89000101 
 715 0f90 00000000 		lea	%s12,__ftrace_func_exit@LO
 715      00000C06 
 716 0f98 00000000 		and	%s12,%s12,(32)0
 716      608C0C44 
 717 0fa0 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 717      8C008C06 
 718 0fa8 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 718      8C000A08 
 719 0fb0 00000000 		or	%s0,0,%s23
 719      97000045 
 720              	# Start of epilogue codes
 721 0fb8 30000000 		ld	%s18,48(,%fp)
 721      89001201 
 722 0fc0 58000000 		ld	%s23,88(,%fp)
 722      89001701 
 723 0fc8 00000000 		or	%sp,0,%fp
 723      89000B45 
 724              		.cfi_def_cfa	11,8
 725 0fd0 18000000 		ld	%got,0x18(,%sp)
 725      8B000F01 
 726 0fd8 20000000 		ld	%plt,0x20(,%sp)
 726      8B001001 
 727 0fe0 08000000 		ld	%lr,0x8(,%sp)
 727      8B000A01 
 728 0fe8 00000000 		ld	%fp,0x0(,%sp)
 728      8B000901 
 729 0ff0 00000000 		b.l	(,%lr)
 729      8A000F19 
 730              	.L3.5:
 731 0ff8 00000000 		or	%s23,0,%s63
 731      BF001745 
 732 1000 70FFFFFF 		br.l	.L3.3
 732      00000F18 
 733              	.L3.0:
 734 1008 F0FFFFFF 		breq.w	0,%s18,.L3.5
 734      92008418 
 735 1010 38FFFFFF 		br.l	.L3.4
 735      00000F18 
 736              		.cfi_endproc
 737              		.set	.L.4.2auto_size,	0xfffffffffffffe20	# 480 Bytes
 739              	.L_FE.4:
 740 1018 5B6C6F63 		.string	"[local to sx_conv3_ve_cpp]::conv::gcd\000 "
 740      616C2074 
 740      6F207378 
 740      5F636F6E 
 740      76335F76 
 741              	# ============ End  _INTERNAL_15_sx_conv3_ve_cpp_ab09f9b5::conv::gcd(int, int) ============
 742              	# ============ Begin  conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 743              		.data
 744              		.balign 16
 747              	.LP._ZN4conv12sxconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 748 0000 00000000 		.long	__vla_dealloc_eh
 748      00000000 
 749 0008 0000     		.zero	2
 750 000a FFFF     		.short	65535
 751 000c 04       		.byte	4
 752 000d 000000   		.zero	3
 753 0010 00000000 		.long	__vla_dealloc_eh
 753      00000000 
 754 0018 0100     		.short	1
 755 001a 0000     		.zero	2
 756 001c 04       		.byte	4
 757 001d 000000   		.zero	3
 758 0020 00000000 		.long	__vla_dealloc_eh
 758      00000000 
 759 0028 0200     		.short	2
 760 002a 0100     		.short	1
 761 002c 04       		.byte	4
 762 002d 000000   		.zero	3
 763 0030 00000000 		.long	__vla_dealloc_eh
 763      00000000 
 764 0038 0300     		.short	3
 765 003a 0200     		.short	2
 766 003c 04       		.byte	4
 767 003d 000000   		.zero	3
 768 0040 00000000 		.long	__vla_dealloc_eh
 768      00000000 
 769 0048 0400     		.short	4
 770 004a 0300     		.short	3
 771 004c 04       		.byte	4
 772 004d 000000   		.zero	3
 773 0050 00000000 		.long	__vla_dealloc_eh
 773      00000000 
 774 0058 0500     		.short	5
 775 005a 0400     		.short	4
 776 005c 04       		.byte	4
 777 005d 000000   		.zero	3
 778 0060 00000000 		.long	__vla_dealloc_eh
 778      00000000 
 779 0068 0600     		.short	6
 780 006a 0500     		.short	5
 781 006c 04       		.byte	4
 782 006d 000000   		.zero	3
 783              		.balign 1
 786              	.LP.__15_sx_conv3_ve_cpp_ab09f9b5.0.__unnamed.0:
 787 0070 76       		.byte	118
 788 0071 6F       		.byte	111
 789 0072 69       		.byte	105
 790 0073 64       		.byte	100
 791 0074 20       		.byte	32
 792 0075 63       		.byte	99
 793 0076 6F       		.byte	111
 794 0077 6E       		.byte	110
 795 0078 76       		.byte	118
 796 0079 3A       		.byte	58
 797 007a 3A       		.byte	58
 798 007b 73       		.byte	115
 799 007c 78       		.byte	120
 800 007d 63       		.byte	99
 801 007e 6F       		.byte	111
 802 007f 6E       		.byte	110
 803 0080 76       		.byte	118
 804 0081 5F       		.byte	95
 805 0082 33       		.byte	51
 806 0083 5F       		.byte	95
 807 0084 66       		.byte	102
 808 0085 77       		.byte	119
 809 0086 64       		.byte	100
 810 0087 28       		.byte	40
 811 0088 63       		.byte	99
 812 0089 6F       		.byte	111
 813 008a 6E       		.byte	110
 814 008b 73       		.byte	115
 815 008c 74       		.byte	116
 816 008d 20       		.byte	32
 817 008e 63       		.byte	99
 818 008f 6F       		.byte	111
 819 0090 6E       		.byte	110
 820 0091 76       		.byte	118
 821 0092 3A       		.byte	58
 822 0093 3A       		.byte	58
 823 0094 70       		.byte	112
 824 0095 72       		.byte	114
 825 0096 62       		.byte	98
 826 0097 5F       		.byte	95
 827 0098 74       		.byte	116
 828 0099 20       		.byte	32
 829 009a 2A       		.byte	42
 830 009b 2C       		.byte	44
 831 009c 20       		.byte	32
 832 009d 64       		.byte	100
 833 009e 6E       		.byte	110
 834 009f 6E       		.byte	110
 835 00a0 5F       		.byte	95
 836 00a1 6D       		.byte	109
 837 00a2 65       		.byte	101
 838 00a3 6D       		.byte	109
 839 00a4 5F       		.byte	95
 840 00a5 74       		.byte	116
 841 00a6 20       		.byte	32
 842 00a7 26       		.byte	38
 843 00a8 2C       		.byte	44
 844 00a9 20       		.byte	32
 845 00aa 64       		.byte	100
 846 00ab 6E       		.byte	110
 847 00ac 6E       		.byte	110
 848 00ad 5F       		.byte	95
 849 00ae 6D       		.byte	109
 850 00af 65       		.byte	101
 851 00b0 6D       		.byte	109
 852 00b1 5F       		.byte	95
 853 00b2 74       		.byte	116
 854 00b3 20       		.byte	32
 855 00b4 26       		.byte	38
 856 00b5 2C       		.byte	44
 857 00b6 20       		.byte	32
 858 00b7 64       		.byte	100
 859 00b8 6E       		.byte	110
 860 00b9 6E       		.byte	110
 861 00ba 5F       		.byte	95
 862 00bb 6D       		.byte	109
 863 00bc 65       		.byte	101
 864 00bd 6D       		.byte	109
 865 00be 5F       		.byte	95
 866 00bf 74       		.byte	116
 867 00c0 20       		.byte	32
 868 00c1 26       		.byte	38
 869 00c2 2C       		.byte	44
 870 00c3 20       		.byte	32
 871 00c4 64       		.byte	100
 872 00c5 6E       		.byte	110
 873 00c6 6E       		.byte	110
 874 00c7 5F       		.byte	95
 875 00c8 6D       		.byte	109
 876 00c9 65       		.byte	101
 877 00ca 6D       		.byte	109
 878 00cb 5F       		.byte	95
 879 00cc 74       		.byte	116
 880 00cd 20       		.byte	32
 881 00ce 26       		.byte	38
 882 00cf 29       		.byte	41
 883 00d0 00       		.zero	1
 884              		.section .rodata
 885 0019 00000000 		.balign 16
 885      000000
 887              	.LP.__string.1:
 888 0020 70       		.byte	112
 889 0021 2D       		.byte	45
 890 0022 3E       		.byte	62
 891 0023 6B       		.byte	107
 892 0024 68       		.byte	104
 893 0025 20       		.byte	32
 894 0026 3E       		.byte	62
 895 0027 20       		.byte	32
 896 0028 30       		.byte	48
 897 0029 20       		.byte	32
 898 002a 26       		.byte	38
 899 002b 26       		.byte	38
 900 002c 20       		.byte	32
 901 002d 4B       		.byte	75
 902 002e 57       		.byte	87
 903 002f 20       		.byte	32
 904 0030 3E       		.byte	62
 905 0031 20       		.byte	32
 906 0032 30       		.byte	48
 907 0033 00       		.zero	1
 908 0034 00000000 		.balign 8
 910              	.LP.__string.2:
 911 0038 40       		.byte	64
 912 0039 40       		.byte	64
 913 003a 40       		.byte	64
 914 003b 20       		.byte	32
 915 003c 65       		.byte	101
 916 003d 72       		.byte	114
 917 003e 72       		.byte	114
 918 003f 6F       		.byte	111
 919 0040 72       		.byte	114
 920 0041 3A       		.byte	58
 921 0042 20       		.byte	32
 922 0043 25       		.byte	37
 923 0044 73       		.byte	115
 924 0045 20       		.byte	32
 925 0046 3A       		.byte	58
 926 0047 20       		.byte	32
 927 0048 5B       		.byte	91
 928 0049 25       		.byte	37
 929 004a 73       		.byte	115
 930 004b 3A       		.byte	58
 931 004c 25       		.byte	37
 932 004d 64       		.byte	100
 933 004e 5D       		.byte	93
 934 004f 0A       		.byte	10
 935 0050 00       		.zero	1
 936 0051 00000000 		.balign 8
 936      000000
 938              	.LP.__string.3:
 939 0058 70       		.byte	112
 940 0059 2D       		.byte	45
 941 005a 3E       		.byte	62
 942 005b 64       		.byte	100
 943 005c 68       		.byte	104
 944 005d 20       		.byte	32
 945 005e 3E       		.byte	62
 946 005f 3D       		.byte	61
 947 0060 20       		.byte	32
 948 0061 30       		.byte	48
 949 0062 20       		.byte	32
 950 0063 26       		.byte	38
 951 0064 26       		.byte	38
 952 0065 20       		.byte	32
 953 0066 70       		.byte	112
 954 0067 2D       		.byte	45
 955 0068 3E       		.byte	62
 956 0069 64       		.byte	100
 957 006a 77       		.byte	119
 958 006b 20       		.byte	32
 959 006c 3E       		.byte	62
 960 006d 3D       		.byte	61
 961 006e 20       		.byte	32
 962 006f 30       		.byte	48
 963 0070 00       		.zero	1
 964 0071 00000000 		.balign 8
 964      000000
 966              	.LP.__string.4:
 967 0078 40       		.byte	64
 968 0079 40       		.byte	64
 969 007a 40       		.byte	64
 970 007b 20       		.byte	32
 971 007c 65       		.byte	101
 972 007d 72       		.byte	114
 973 007e 72       		.byte	114
 974 007f 6F       		.byte	111
 975 0080 72       		.byte	114
 976 0081 3A       		.byte	58
 977 0082 20       		.byte	32
 978 0083 25       		.byte	37
 979 0084 73       		.byte	115
 980 0085 20       		.byte	32
 981 0086 3A       		.byte	58
 982 0087 20       		.byte	32
 983 0088 5B       		.byte	91
 984 0089 25       		.byte	37
 985 008a 73       		.byte	115
 986 008b 3A       		.byte	58
 987 008c 25       		.byte	37
 988 008d 64       		.byte	100
 989 008e 5D       		.byte	93
 990 008f 0A       		.byte	10
 991 0090 00       		.zero	1
 992 0091 00000000 		.balign 8
 992      000000
 994              	.LP.__string.5:
 995 0098 53       		.byte	83
 996 0099 48       		.byte	72
 997 009a 20       		.byte	32
 998 009b 3E       		.byte	62
 999 009c 3D       		.byte	61
 1000 009d 20       		.byte	32
 1001 009e 30       		.byte	48
 1002 009f 20       		.byte	32
 1003 00a0 26       		.byte	38
 1004 00a1 26       		.byte	38
 1005 00a2 20       		.byte	32
 1006 00a3 53       		.byte	83
 1007 00a4 57       		.byte	87
 1008 00a5 20       		.byte	32
 1009 00a6 3E       		.byte	62
 1010 00a7 3D       		.byte	61
 1011 00a8 20       		.byte	32
 1012 00a9 30       		.byte	48
 1013 00aa 00       		.zero	1
 1014 00ab 00000000 		.balign 8
 1014      00
 1016              	.LP.__string.6:
 1017 00b0 40       		.byte	64
 1018 00b1 40       		.byte	64
 1019 00b2 40       		.byte	64
 1020 00b3 20       		.byte	32
 1021 00b4 65       		.byte	101
 1022 00b5 72       		.byte	114
 1023 00b6 72       		.byte	114
 1024 00b7 6F       		.byte	111
 1025 00b8 72       		.byte	114
 1026 00b9 3A       		.byte	58
 1027 00ba 20       		.byte	32
 1028 00bb 25       		.byte	37
 1029 00bc 73       		.byte	115
 1030 00bd 20       		.byte	32
 1031 00be 3A       		.byte	58
 1032 00bf 20       		.byte	32
 1033 00c0 5B       		.byte	91
 1034 00c1 25       		.byte	37
 1035 00c2 73       		.byte	115
 1036 00c3 3A       		.byte	58
 1037 00c4 25       		.byte	37
 1038 00c5 64       		.byte	100
 1039 00c6 5D       		.byte	93
 1040 00c7 0A       		.byte	10
 1041 00c8 00       		.zero	1
 1042 00c9 00000000 		.balign 8
 1042      000000
 1044              	.LP._ZN4conv12sxconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.khkw_muls.__initializer.0:
 1045 00d0 01000000 		.long	1
 1045      00000000 
 1046 00d8 00000000 		.zero	8
 1046      00000000 
 1047 00e0 00000100 		.long	65536
 1047      00000000 
 1048 00e8 00000000 		.zero	8
 1048      00000000 
 1049              		.text
 1050              		.balign 16
 1051              	# line 197
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define V 10
 1052              		.loc	1 197 0
 1053              		.globl	conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 1055 1040 10450000 		.long	.L_FE.5-8-.
 1055      00000000 
 1056              	conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 1057              		.cfi_startproc
 1058 1048 00000000 		st	%fp,0x0(,%sp)
 1058      8B000911 
 1059              		.cfi_def_cfa_offset	0
 1060              		.cfi_offset	9,0
 1061 1050 08000000 		st	%lr,0x8(,%sp)
 1061      8B000A11 
 1062 1058 18000000 		st	%got,0x18(,%sp)
 1062      8B000F11 
 1063 1060 20000000 		st	%plt,0x20(,%sp)
 1063      8B001011 
 1064 1068 00000000 		or	%fp,0,%sp
 1064      8B000945 
 1065              		.cfi_def_cfa_register	9
 1066 1070 30000000 		st	%s18,48(,%fp)
 1066      89001211 
 1067 1078 38000000 		st	%s19,56(,%fp)
 1067      89001311 
 1068 1080 40000000 		st	%s20,64(,%fp)
 1068      89001411 
 1069 1088 48000000 		st	%s21,72(,%fp)
 1069      89001511 
 1070 1090 50000000 		st	%s22,80(,%fp)
 1070      89001611 
 1071 1098 58000000 		st	%s23,88(,%fp)
 1071      89001711 
 1072 10a0 60000000 		st	%s24,96(,%fp)
 1072      89001811 
 1073 10a8 68000000 		st	%s25,104(,%fp)
 1073      89001911 
 1074 10b0 70000000 		st	%s26,112(,%fp)
 1074      89001A11 
 1075 10b8 78000000 		st	%s27,120(,%fp)
 1075      89001B11 
 1076 10c0 80000000 		st	%s28,128(,%fp)
 1076      89001C11 
 1077 10c8 88000000 		st	%s29,136(,%fp)
 1077      89001D11 
 1078 10d0 90000000 		st	%s30,144(,%fp)
 1078      89001E11 
 1079 10d8 98000000 		st	%s31,152(,%fp)
 1079      89001F11 
 1080 10e0 A0000000 		st	%s32,160(,%fp)
 1080      89002011 
 1081 10e8 A8000000 		st	%s33,168(,%fp)
 1081      89002111 
 1082 10f0 9084FFFF 		lea	%s13,.L.5.2auto_size&0xffffffff
 1082      00000D06 
 1083 10f8 00000000 		and	%s13,%s13,(32)0
 1083      608D0D44 
 1084 1100 FFFFFFFF 		lea.sl	%sp,.L.5.2auto_size>>32(%fp,%s13)
 1084      8D898B06 
 1085 1108 48000000 		brge.l.t	%sp,%sl,.L4.EoP
 1085      888B3518 
 1086 1110 18000000 		ld	%s61,0x18(,%tp)
 1086      8E003D01 
 1087 1118 00000000 		or	%s62,0,%s0
 1087      80003E45 
 1088 1120 3B010000 		lea	%s63,0x13b
 1088      00003F06 
 1089 1128 00000000 		shm.l	%s63,0x0(%s61)
 1089      BD033F31 
 1090 1130 08000000 		shm.l	%sl,0x8(%s61)
 1090      BD030831 
 1091 1138 10000000 		shm.l	%sp,0x10(%s61)
 1091      BD030B31 
 1092 1140 00000000 		monc
 1092      0000003F 
 1093 1148 00000000 		or	%s0,0,%s62
 1093      BE000045 
 1094              	.L4.EoP:
 1095              	# End of prologue codes
 1096 1150 90EAFFFF 		st	%s4,-5488(,%fp)	# spill 
 1096      89000411 
 1097 1158 88EAFFFF 		st	%s3,-5496(,%fp)	# spill 
 1097      89000311 
 1098 1160 80EAFFFF 		st	%s2,-5504(,%fp)	# spill 
 1098      89000211 
 1099 1168 78EAFFFF 		st	%s1,-5512(,%fp)	# spill 
 1099      89000111 
 1100 1170 70EAFFFF 		st	%s0,-5520(,%fp)	# spill 
 1100      89000011 
 1101 1178 00000000 		lea	%s0,conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 1101      00000006 
 1102 1180 00000000 		and	%s0,%s0,(32)0
 1102      60800044 
 1103 1188 00000000 		lea.sl	%s0,conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 1103      80008006 
 1104 1190 08000000 		ld	%s1,8(,%fp)	# ptr
 1104      89000101 
 1105 1198 00000000 		lea	%s12,__ftrace_func_enter@LO
 1105      00000C06 
 1106 11a0 00000000 		and	%s12,%s12,(32)0
 1106      608C0C44 
 1107 11a8 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
 1107      8C008C06 
 1108 11b0 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
 1108      8C000A08 
 1109 11b8 00000000 		lea	%s61,__curr_eh_stack_entry@LO
 1109      00003D06 
 1110 11c0 00000000 		and	%s61,%s61,(32)0
 1110      60BD3D44 
 1111 11c8 00000000 		lea.sl	%s61,__curr_eh_stack_entry@HI(,%s61)
 1111      BD00BD06 
 1112 11d0 00000000 		ld	%s60,0(,%s61)
 1112      BD003C01 
 1113 11d8 70EAFFFF 		ld	%s0,-5520(,%fp)	# restore 
 1113      89000001 
 1114 11e0 D8FDFFFF 		st	%s60,-552(,%fp)
 1114      89003C11 
 1115 11e8 D8FDFFFF 		lea	%s60,-552
 1115      00003C06 
 1116 11f0 00000000 		adds.l	%s60,%fp,%s60
 1116      BC893C59 
 1117 11f8 00000000 		st	%s60,0(,%s61)
 1117      BD003C11 
 1118 1200 00000000 		or	%s61,1,(0)1
 1118      00013D45 
 1119 1208 E0FDFFFF 		st1b	%s61,-544(,%fp)
 1119      89003D15 
 1120              	# line 1046
1046:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
 1121              		.loc	1 1046 0
 1122 1210 00000000 		ldl.sx	%s61,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 1122      80003D03 
 1123 1218 00000000 		or	%s61,0,%s61
 1123      BD003D45 
 1124 1220 00000000 		lea	%s60,.LP._ZN4conv12sxconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 1124      00003C06 
 1125 1228 00000000 		and	%s60,%s60,(32)0
 1125      60BC3C44 
 1126 1230 00000000 		lea.sl	%s60,.LP._ZN4conv12sxconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s60)
 1126      BC00BC06 
 1127 1238 E8FDFFFF 		st	%s60,-536(,%fp)
 1127      89003C11 
 1128 1240 58FFFFFF 		lea	%s60,-168
 1128      00003C06 
 1129 1248 00000000 		adds.l	%s60,%fp,%s60
 1129      BC893C59 
 1130 1250 F0FDFFFF 		st	%s60,-528(,%fp)
 1130      89003C11 
 1131 1258 00000000 		lea	%s60,__eh_curr_region@LO
 1131      00003C06 
 1132 1260 00000000 		and	%s60,%s60,(32)0
 1132      60BC3C44 
 1133 1268 00000000 		lea.sl	%s60,__eh_curr_region@HI(,%s60)
 1133      BC00BC06 
 1134 1270 00000000 		ld2b.zx	%s59,0(,%s60)
 1134      BC00BB04 
 1135 1278 00FEFFFF 		st2b	%s59,-512(,%fp)
 1135      89003B14 
 1136 1280 FFFF0000 		lea	%s59,65535
 1136      00003B06 
 1137 1288 00000000 		st2b	%s59,0(,%s60)
 1137      BC003B14 
 1138              	# line 1047
1047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
 1139              		.loc	1 1047 0
 1140 1290 04000000 		ldl.sx	%s60,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 1140      80003C03 
 1141 1298 00000000 		or	%s62,0,%s60
 1141      BC003E45 
 1142              	# line 1048
1048:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
 1143              		.loc	1 1048 0
 1144 12a0 08000000 		ldl.sx	%s60,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 1144      80003C03 
 1145 12a8 00000000 		or	%s60,0,%s60
 1145      BC003C45 
 1146              	# line 1063
1063:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC/G;
 1147              		.loc	1 1063 0
 1148 12b0 00000000 		divs.l	%s63,%s60,%s61
 1148      BDBC3F7F 
 1149              	# line 1049
1049:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
 1150              		.loc	1 1049 0
 1151 12b8 0C000000 		ldl.sx	%s59,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 1151      80003B03 
 1152 12c0 00000000 		or	%s44,0,%s59
 1152      BB002C45 
 1153              	# line 1050
1050:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
 1154              		.loc	1 1050 0
 1155 12c8 10000000 		ldl.sx	%s59,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 1155      80003B03 
 1156 12d0 00000000 		or	%s59,0,%s59
 1156      BB003B45 
 1157              	# line 1051
1051:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
 1158              		.loc	1 1051 0
 1159 12d8 14000000 		ldl.sx	%s58,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 1159      80003A03 
 1160 12e0 00000000 		or	%s58,0,%s58
 1160      BA003A45 
 1161              	# line 1064
1064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH_KW = KH * KW;
 1162              		.loc	1 1064 0
 1163 12e8 00000000 		divs.l	%s30,%s58,%s61
 1163      BDBA1E7F 
 1164              	# line 1052
1052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
 1165              		.loc	1 1052 0
 1166 12f0 18000000 		ldl.sx	%s57,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 1166      80003903 
 1167 12f8 00000000 		or	%s50,0,%s57
 1167      B9003245 
 1168              	# line 1053
1053:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
 1169              		.loc	1 1053 0
 1170 1300 1C000000 		ldl.sx	%s57,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 1170      80003903 
 1171 1308 00000000 		or	%s25,0,%s57
 1171      B9001945 
 1172              	# line 1067
1067:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG_ICOG_KH_KW = OCOG * ICOG_KH_KW;
 1173              		.loc	1 1067 0
 1174 1310 00000000 		muls.l	%s57,%s50,%s25
 1174      99B2396E 
 1175              	# line 1054
1054:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
 1176              		.loc	1 1054 0
 1177 1318 20000000 		ldl.sx	%s20,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 1177      80001403 
 1178 1320 00000000 		or	%s19,0,%s20
 1178      94001345 
 1179              	# line 1055
1055:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
 1180              		.loc	1 1055 0
 1181 1328 24000000 		ldl.sx	%s56,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 1181      80003803 
 1182 1330 00000000 		or	%s18,0,%s56
 1182      B8001245 
 1183              	# line 1065
1065:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH_KW;
 1184              		.loc	1 1065 0
 1185 1338 00000000 		muls.l	%s56,%s19,%s18
 1185      9293386E 
 1186              	# line 1066
1066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
 1187              		.loc	1 1066 0
 1188 1340 00000000 		muls.l	%s21,%s63,%s56
 1188      B8BF156E 
 1189              	# line 1056
1056:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
 1190              		.loc	1 1056 0
 1191 1348 30000000 		ldl.sx	%s56,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 1191      80003803 
 1192 1350 00000000 		or	%s56,0,%s56
 1192      B8003845 
 1193              	# line 1057
1057:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
 1194              		.loc	1 1057 0
 1195 1358 34000000 		ldl.sx	%s55,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 1195      80003703 
 1196 1360 00000000 		or	%s55,0,%s55
 1196      B7003745 
 1197              	# line 1058
1058:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
 1198              		.loc	1 1058 0
 1199 1368 28000000 		ldl.sx	%s54,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 1199      80003603 
 1200 1370 00000000 		or	%s54,0,%s54
 1200      B6003645 
 1201              	# line 1059
1059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
 1202              		.loc	1 1059 0
 1203 1378 2C000000 		ldl.sx	%s53,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 1203      80003503 
 1204 1380 00000000 		or	%s53,0,%s53
 1204      B5003545 
 1205              	# line 1060
1060:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DW = p->dw + 1;
 1206              		.loc	1 1060 0
 1207 1388 38000000 		ldl.sx	%s52,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 1207      80003403 
 1208 1390 00000000 		adds.w.sx	%s52,1,%s52
 1208      B401344A 
 1209 1398 00000000 		or	%s52,0,%s52
 1209      B4003445 
 1210              	# line 1061
1061:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 1211              		.loc	1 1061 0
 1212 13a0 3C000000 		ldl.sx	%s0,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 1212      80000003 
 1213 13a8 00000000 		adds.w.sx	%s0,1,%s0
 1213      8001004A 
 1214 13b0 00000000 		or	%s0,0,%s0
 1214      80000045 
 1215 13b8 90410000 		brlt.w	0,%s20,.L4.0
 1215      94008218 
 1216              	.L4.1:
 1217              	# line 1074
1074:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 1218              		.loc	1 1074 0
 1219 13c0 00000000 		or	%s51,0,(0)1
 1219      00003345 
 1220 13c8 70EAFFFF 		ld	%s47,-5520(,%fp)	# restore 
 1220      89002F01 
 1221 13d0 00000000 		or	%s1,0,%s0
 1221      80000145 
 1222 13d8 E8400000 		br.l	.L4.2
 1222      00000F18 
 1223              	.L4.3:
 1224 13e0 70EAFFFF 		st	%s47,-5520(,%fp)	# spill 
 1224      89002F11 
 1225 13e8 A8C1FFFF 		st	%s57,-15960(,%fp)	# spill 
 1225      89003911 
 1226 13f0 98ECFFFF 		st	%s63,-4968(,%fp)	# spill 
 1226      89003F11 
 1227 13f8 A0C1FFFF 		st	%s1,-15968(,%fp)	# spill 
 1227      89000111 
 1228 1400 E8C1FFFF 		st	%s52,-15896(,%fp)	# spill 
 1228      89003411 
 1229 1408 E0C1FFFF 		st	%s53,-15904(,%fp)	# spill 
 1229      89003511 
 1230 1410 D8C1FFFF 		st	%s54,-15912(,%fp)	# spill 
 1230      89003611 
 1231 1418 D0C1FFFF 		st	%s55,-15920(,%fp)	# spill 
 1231      89003711 
 1232 1420 C8C1FFFF 		st	%s56,-15928(,%fp)	# spill 
 1232      89003811 
 1233 1428 40EBFFFF 		st	%s50,-5312(,%fp)	# spill 
 1233      89003211 
 1234 1430 C0C1FFFF 		st	%s58,-15936(,%fp)	# spill 
 1234      89003A11 
 1235 1438 B8C1FFFF 		st	%s59,-15944(,%fp)	# spill 
 1235      89003B11 
 1236 1440 10ECFFFF 		st	%s44,-5104(,%fp)	# spill 
 1236      89002C11 
 1237 1448 B0C1FFFF 		st	%s60,-15952(,%fp)	# spill 
 1237      89003C11 
 1238 1450 F8EAFFFF 		st	%s62,-5384(,%fp)	# spill 
 1238      89003E11 
 1239 1458 98C1FFFF 		st	%s61,-15976(,%fp)	# spill 
 1239      89003D11 
 1240              	# line 43
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 1241              		.loc	1 43 0
 1242 1460 00000000 		lea	%s0,.LP.__string.2@LO
 1242      00000006 
 1243 1468 00000000 		and	%s0,%s0,(32)0
 1243      60800044 
 1244 1470 00000000 		lea.sl	%s0,.LP.__string.2@HI(,%s0)
 1244      80008006 
 1245 1478 00000000 		or	%s2,0,%s48
 1245      B0000245 
 1246 1480 B0000000 		st	%s0,176(,%sp)
 1246      8B000011 
 1247 1488 B8000000 		st	%s49,184(,%sp)
 1247      8B003111 
 1248 1490 C0000000 		st	%s48,192(,%sp)
 1248      8B003011 
 1249 1498 32040000 		lea	%s3,1074
 1249      00000306 
 1250 14a0 00000000 		or	%s1,0,%s49
 1250      B1000145 
 1251 14a8 C8000000 		st	%s3,200(,%sp)
 1251      8B000311 
 1252 14b0 00000000 		lea	%s12,printf@LO
 1252      00000C06 
 1253 14b8 00000000 		and	%s12,%s12,(32)0
 1253      608C0C44 
 1254 14c0 00000000 		lea.sl	%s12,printf@HI(,%s12)
 1254      8C008C06 
 1255 14c8 00000000 		bsic	%lr,(,%s12)	# printf
 1255      8C000A08 
 1256 14d0 00000000 		or	%s0,1,(0)1
 1256      00010045 
 1257 14d8 00000000 		lea	%s12,exit@LO
 1257      00000C06 
 1258 14e0 00000000 		and	%s12,%s12,(32)0
 1258      608C0C44 
 1259 14e8 00000000 		lea.sl	%s12,exit@HI(,%s12)
 1259      8C008C06 
 1260 14f0 00000000 		bsic	%lr,(,%s12)	# exit
 1260      8C000A08 
 1261 14f8 70EAFFFF 		ld	%s47,-5520(,%fp)	# restore 
 1261      89002F01 
 1262 1500 A8C1FFFF 		ld	%s57,-15960(,%fp)	# restore 
 1262      89003901 
 1263 1508 98ECFFFF 		ld	%s63,-4968(,%fp)	# restore 
 1263      89003F01 
 1264 1510 A0C1FFFF 		ld	%s1,-15968(,%fp)	# restore 
 1264      89000101 
 1265 1518 E8C1FFFF 		ld	%s52,-15896(,%fp)	# restore 
 1265      89003401 
 1266 1520 E0C1FFFF 		ld	%s53,-15904(,%fp)	# restore 
 1266      89003501 
 1267 1528 D8C1FFFF 		ld	%s54,-15912(,%fp)	# restore 
 1267      89003601 
 1268 1530 D0C1FFFF 		ld	%s55,-15920(,%fp)	# restore 
 1268      89003701 
 1269 1538 C8C1FFFF 		ld	%s56,-15928(,%fp)	# restore 
 1269      89003801 
 1270 1540 40EBFFFF 		ld	%s50,-5312(,%fp)	# restore 
 1270      89003201 
 1271 1548 C0C1FFFF 		ld	%s58,-15936(,%fp)	# restore 
 1271      89003A01 
 1272 1550 B8C1FFFF 		ld	%s59,-15944(,%fp)	# restore 
 1272      89003B01 
 1273 1558 10ECFFFF 		ld	%s44,-5104(,%fp)	# restore 
 1273      89002C01 
 1274 1560 B0C1FFFF 		ld	%s60,-15952(,%fp)	# restore 
 1274      89003C01 
 1275 1568 F8EAFFFF 		ld	%s62,-5384(,%fp)	# restore 
 1275      89003E01 
 1276 1570 98C1FFFF 		ld	%s61,-15976(,%fp)	# restore 
 1276      89003D01 
 1277 1578 303F0000 		br.l	.L4.4
 1277      00000F18 
 1278              	.L4.5:
 1279              	# line 1075
1075:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( SH >= 0 && SW >= 0 );
 1280              		.loc	1 1075 0
 1281 1580 00000000 		or	%s51,0,(0)1
 1281      00003345 
 1282 1588 903E0000 		br.l	.L4.6
 1282      00000F18 
 1283              	.L4.7:
 1284 1590 D8C1FFFF 		st	%s54,-15912(,%fp)	# spill 
 1284      89003611 
 1285 1598 70EAFFFF 		st	%s47,-5520(,%fp)	# spill 
 1285      89002F11 
 1286 15a0 A8C1FFFF 		st	%s57,-15960(,%fp)	# spill 
 1286      89003911 
 1287 15a8 98ECFFFF 		st	%s63,-4968(,%fp)	# spill 
 1287      89003F11 
 1288 15b0 A0C1FFFF 		st	%s1,-15968(,%fp)	# spill 
 1288      89000111 
 1289 15b8 E8C1FFFF 		st	%s52,-15896(,%fp)	# spill 
 1289      89003411 
 1290 15c0 E0C1FFFF 		st	%s53,-15904(,%fp)	# spill 
 1290      89003511 
 1291 15c8 D0C1FFFF 		st	%s55,-15920(,%fp)	# spill 
 1291      89003711 
 1292 15d0 C8C1FFFF 		st	%s56,-15928(,%fp)	# spill 
 1292      89003811 
 1293 15d8 40EBFFFF 		st	%s50,-5312(,%fp)	# spill 
 1293      89003211 
 1294 15e0 C0C1FFFF 		st	%s58,-15936(,%fp)	# spill 
 1294      89003A11 
 1295 15e8 B8C1FFFF 		st	%s59,-15944(,%fp)	# spill 
 1295      89003B11 
 1296 15f0 10ECFFFF 		st	%s44,-5104(,%fp)	# spill 
 1296      89002C11 
 1297 15f8 B0C1FFFF 		st	%s60,-15952(,%fp)	# spill 
 1297      89003C11 
 1298 1600 F8EAFFFF 		st	%s62,-5384(,%fp)	# spill 
 1298      89003E11 
 1299 1608 98C1FFFF 		st	%s61,-15976(,%fp)	# spill 
 1299      89003D11 
 1300              	# line 43
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 1301              		.loc	1 43 0
 1302 1610 00000000 		lea	%s0,.LP.__string.4@LO
 1302      00000006 
 1303 1618 00000000 		and	%s0,%s0,(32)0
 1303      60800044 
 1304 1620 00000000 		lea.sl	%s0,.LP.__string.4@HI(,%s0)
 1304      80008006 
 1305 1628 00000000 		or	%s2,0,%s48
 1305      B0000245 
 1306 1630 B0000000 		st	%s0,176(,%sp)
 1306      8B000011 
 1307 1638 B8000000 		st	%s49,184(,%sp)
 1307      8B003111 
 1308 1640 C0000000 		st	%s48,192(,%sp)
 1308      8B003011 
 1309 1648 33040000 		lea	%s3,1075
 1309      00000306 
 1310 1650 00000000 		or	%s1,0,%s49
 1310      B1000145 
 1311 1658 C8000000 		st	%s3,200(,%sp)
 1311      8B000311 
 1312 1660 00000000 		lea	%s12,printf@LO
 1312      00000C06 
 1313 1668 00000000 		and	%s12,%s12,(32)0
 1313      608C0C44 
 1314 1670 00000000 		lea.sl	%s12,printf@HI(,%s12)
 1314      8C008C06 
 1315 1678 00000000 		bsic	%lr,(,%s12)	# printf
 1315      8C000A08 
 1316 1680 00000000 		or	%s0,1,(0)1
 1316      00010045 
 1317 1688 00000000 		lea	%s12,exit@LO
 1317      00000C06 
 1318 1690 00000000 		and	%s12,%s12,(32)0
 1318      608C0C44 
 1319 1698 00000000 		lea.sl	%s12,exit@HI(,%s12)
 1319      8C008C06 
 1320 16a0 00000000 		bsic	%lr,(,%s12)	# exit
 1320      8C000A08 
 1321 16a8 D8C1FFFF 		ld	%s54,-15912(,%fp)	# restore 
 1321      89003601 
 1322 16b0 70EAFFFF 		ld	%s47,-5520(,%fp)	# restore 
 1322      89002F01 
 1323 16b8 A8C1FFFF 		ld	%s57,-15960(,%fp)	# restore 
 1323      89003901 
 1324 16c0 98ECFFFF 		ld	%s63,-4968(,%fp)	# restore 
 1324      89003F01 
 1325 16c8 A0C1FFFF 		ld	%s1,-15968(,%fp)	# restore 
 1325      89000101 
 1326 16d0 E8C1FFFF 		ld	%s52,-15896(,%fp)	# restore 
 1326      89003401 
 1327 16d8 E0C1FFFF 		ld	%s53,-15904(,%fp)	# restore 
 1327      89003501 
 1328 16e0 D0C1FFFF 		ld	%s55,-15920(,%fp)	# restore 
 1328      89003701 
 1329 16e8 C8C1FFFF 		ld	%s56,-15928(,%fp)	# restore 
 1329      89003801 
 1330 16f0 40EBFFFF 		ld	%s50,-5312(,%fp)	# restore 
 1330      89003201 
 1331 16f8 C0C1FFFF 		ld	%s58,-15936(,%fp)	# restore 
 1331      89003A01 
 1332 1700 B8C1FFFF 		ld	%s59,-15944(,%fp)	# restore 
 1332      89003B01 
 1333 1708 10ECFFFF 		ld	%s44,-5104(,%fp)	# restore 
 1333      89002C01 
 1334 1710 B0C1FFFF 		ld	%s60,-15952(,%fp)	# restore 
 1334      89003C01 
 1335 1718 F8EAFFFF 		ld	%s62,-5384(,%fp)	# restore 
 1335      89003E01 
 1336 1720 98C1FFFF 		ld	%s61,-15976(,%fp)	# restore 
 1336      89003D01 
 1337 1728 B03C0000 		br.l	.L4.8
 1337      00000F18 
 1338              	.L4.9:
 1339 1730 E8C1FFFF 		st	%s52,-15896(,%fp)	# spill 
 1339      89003411 
 1340 1738 E0C1FFFF 		st	%s53,-15904(,%fp)	# spill 
 1340      89003511 
 1341 1740 D8C1FFFF 		st	%s54,-15912(,%fp)	# spill 
 1341      89003611 
 1342 1748 D0C1FFFF 		st	%s55,-15920(,%fp)	# spill 
 1342      89003711 
 1343 1750 C8C1FFFF 		st	%s56,-15928(,%fp)	# spill 
 1343      89003811 
 1344 1758 C0C1FFFF 		st	%s58,-15936(,%fp)	# spill 
 1344      89003A11 
 1345 1760 B8C1FFFF 		st	%s59,-15944(,%fp)	# spill 
 1345      89003B11 
 1346 1768 10ECFFFF 		st	%s44,-5104(,%fp)	# spill 
 1346      89002C11 
 1347 1770 B0C1FFFF 		st	%s60,-15952(,%fp)	# spill 
 1347      89003C11 
 1348 1778 F8EAFFFF 		st	%s62,-5384(,%fp)	# spill 
 1348      89003E11 
 1349 1780 00000000 		or	%s20,0,(0)1
 1349      00001445 
 1350 1788 00000000 		or	%s31,0,%s47
 1350      AF001F45 
 1351 1790 80EAFFFF 		ld	%s2,-5504(,%fp)	# restore 
 1351      89000201 
 1352 1798 00000000 		or	%s22,0,%s61
 1352      BD001645 
 1353 17a0 88EAFFFF 		ld	%s3,-5496(,%fp)	# restore 
 1353      89000301 
 1354 17a8 00000000 		or	%s32,0,%s57
 1354      B9002045 
 1355 17b0 90EAFFFF 		ld	%s4,-5488(,%fp)	# restore 
 1355      89000401 
 1356 17b8 00000000 		or	%s33,0,%s1
 1356      81002145 
 1357 17c0 78EAFFFF 		ld	%s1,-5512(,%fp)	# restore 
 1357      89000101 
 1358 17c8 503B0000 		br.l	.L4.10
 1358      00000F18 
 1359              	.L4.11:
 1360              	# line 1133
1133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       // trick to easy calc of kh, kw loop limits is that division must
 1361              		.loc	1 1133 0
 1362 17d0 80000000 		mins.l	%s61,%s43,%s61
 1362      BDAB3D68 
 1363 17d8 D8320000 		br.l	.L4.12
 1363      00000F18 
 1364              	.L4.13:
 1365              	# line 1141
1141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, (p->dw+1) );
 1366              		.loc	1 1141 0
 1367 17e0 80000000 		mins.l	%s61,%s45,%s61
 1367      BDAD3D68 
 1368 17e8 00300000 		br.l	.L4.14
 1368      00000F18 
 1369              	.L4.15:
 1370              	# line 1160
1160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
 1371              		.loc	1 1160 0
 1372 17f0 80000000 		mins.l	%s53,%s45,%s53
 1372      B5AD3568 
 1373 17f8 20000000 		br.l	.L4.16
 1373      00000F18 
 1374              	.L4.17:
 1375 1800 00000000 		or	%s54,0,%s61
 1375      BD003645 
 1376 1808 00000000 		or	%s56,0,%s60
 1376      BC003845 
 1377 1810 A0270000 		br.l	.L4.18
 1377      00000F18 
 1378              	.L4.16:
 1379              	# line 1161
1161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 1380              		.loc	1 1161 0
 1381 1818 00000000 		adds.l	%s56,%s57,(0)1
 1381      00B93859 
 1382 1820 00000000 		adds.l	%s56,%s56,%s54
 1382      B6B83859 
 1383 1828 00000000 		lvl	%s53
 1383      00B500BF 
 1384 1830 00000024 		vldu.nc	%v36,4,%s56
 1384      B8040082 
 1385 1838 00000000 		adds.l	%s56,%s47,(0)1
 1385      00AF3859 
 1386 1840 00000000 		adds.l	%s56,%s56,%s54
 1386      B6B83859 
 1387 1848 00000024 		vstu.nc	%v36,4,%s56
 1387      B8040092 
 1388              	# line 1160
1160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
 1389              		.loc	1 1160 0
 1390 1850 00000000 		adds.l	%s54,%s54,%s46
 1390      AEB63659 
 1391 1858 00000000 		subs.l	%s45,%s45,%s53
 1391      B5AD2D5B 
 1392 1860 A0FFFFFF 		brge.l	0,%s45,.L4.17
 1392      AD000518 
 1393 1868 88FFFFFF 		br.l	.L4.15
 1393      00000F18 
 1394              	.L4.19:
 1395 1870 00000000 		subs.l	%s58,0,%s59
 1395      BB003A5B 
 1396 1878 00000000 		smvl	%s55
 1396      0000372E 
 1397 1880 80000000 		mins.l	%s55,%s58,%s55
 1397      B7BA3768 
 1398 1888 00000000 		or	%s45,0,%s58
 1398      BA002D45 
 1399 1890 00000000 		or	%s58,0,(0)1
 1399      00003A45 
 1400 1898 00000000 		muls.l	%s46,4,%s55
 1400      B7042E6E 
 1401 18a0 00000000 		or	%s60,0,%s56
 1401      B8003C45 
 1402 18a8 00000000 		or	%s61,0,%s54
 1402      B6003D45 
 1403 18b0 00000000 		or	%s34,0,%s53
 1403      B5002245 
 1404 18b8 00000000 		or	%s35,0,%s40
 1404      A8002345 
 1405 18c0 00000000 		or	%s53,0,%s55
 1405      B7003545 
 1406 18c8 00000000 		or	%s54,0,%s58
 1406      BA003645 
 1407 18d0 48FFFFFF 		br.l	.L4.16
 1407      00000F18 
 1408              	.L4.20:
 1409 18d8 98FFFFFF 		brlt.l	0,%s30,.L4.19
 1409      9E000218 
 1410 18e0 00000000 		or	%s34,0,%s53
 1410      B5002245 
 1411 18e8 00000000 		or	%s35,0,%s40
 1411      A8002345 
 1412 18f0 C0260000 		br.l	.L4.18
 1412      00000F18 
 1413              	.L4.21:
 1414              	# line 1156
1156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
 1415              		.loc	1 1156 0
 1416 18f8 80000000 		mins.l	%s54,%s44,%s54
 1416      B6AC3668 
 1417 1900 E8260000 		br.l	.L4.22
 1417      00000F18 
 1418              	.L4.23:
 1419              	# line 1168
1168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 1420              		.loc	1 1168 0
 1421 1908 00000000 		or	%s53,0,(0)1
 1421      00003545 
 1422 1910 38260000 		br.l	.L4.24
 1422      00000F18 
 1423              	.L4.25:
 1424              	# line 1185
1185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 1425              		.loc	1 1185 0
 1426 1918 00000000 		or	%s60,0,(0)1
 1426      00003C45 
 1427 1920 D8230000 		br.l	.L4.26
 1427      00000F18 
 1428              	.L4.27:
 1429 1928 00000000 		or	%s60,0,(0)1
 1429      00003C45 
 1430 1930 00000000 		or	%s19,0,%s61
 1430      BD001345 
 1431 1938 70200000 		br.l	.L4.28
 1431      00000F18 
 1432              	.L4.29:
 1433 1940 00000000 		or	%s60,0,(0)1
 1433      00003C45 
 1434 1948 00000000 		or	%s21,0,%s59
 1434      BB001545 
 1435 1950 B81F0000 		br.l	.L4.30
 1435      00000F18 
 1436              	.L4.31:
 1437 1958 00000000 		or	%s60,0,(0)1
 1437      00003C45 
 1438 1960 00000000 		or	%s22,0,%s58
 1438      BA001645 
 1439 1968 001F0000 		br.l	.L4.32
 1439      00000F18 
 1440              	.L4.33:
 1441 1970 00000000 		or	%s60,0,(0)1
 1441      00003C45 
 1442 1978 00000000 		or	%s58,0,%s22
 1442      96003A45 
 1443 1980 00000000 		or	%s59,0,%s21
 1443      95003B45 
 1444 1988 00000000 		or	%s61,0,%s19
 1444      93003D45 
 1445 1990 201E0000 		br.l	.L4.34
 1445      00000F18 
 1446              	.L4.35:
 1447              	# line 1203
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 1448              		.loc	1 1203 0
 1449 1998 80000000 		mins.l	%s54,%s50,%s54
 1449      B6B23668 
 1450 19a0 000D0000 		br.l	.L4.36
 1450      00000F18 
 1451              	.L4.37:
 1452 19a8 80000000 		mins.l	%s54,%s47,%s54
 1452      B6AF3668 
 1453 19b0 A0080000 		br.l	.L4.38
 1453      00000F18 
 1454              	.L4.39:
 1455 19b8 00000000 		or	%s40,0,%s35
 1455      A3002845 
 1456 19c0 D8040000 		br.l	.L4.40
 1456      00000F18 
 1457              	.L4.41:
 1458              	# line 1210
1210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 1459              		.loc	1 1210 0
 1460 19c8 00000000 		cmpu.l	%s63,%s43,%s53
 1460      B5AB3F55 
 1461 19d0 06000000 		cmov.l.le	%s53,%s43,%s63
 1461      ABBF353B 
 1462 19d8 08050000 		br.l	.L4.42
 1462      00000F18 
 1463              	.L4.43:
 1464              	# line 1215
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1465              		.loc	1 1215 0
 1466 19e0 00000000 		cmpu.l	%s63,%s42,%s53
 1466      B5AA3F55 
 1467 19e8 06000000 		cmov.l.le	%s53,%s42,%s63
 1467      AABF353B 
 1468 19f0 90030000 		br.l	.L4.44
 1468      00000F18 
 1469              	.L4.45:
 1470 19f8 00000000 		lea	%s63,__eh_curr_region@LO
 1470      00003F06 
 1471 1a00 00000000 		and	%s63,%s63,(32)0
 1471      60BF3F44 
 1472 1a08 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 1472      BF00BF06 
 1473 1a10 00FEFFFF 		ld2b.zx	%s62,-512(,%fp)
 1473      8900BE04 
 1474 1a18 00000000 		st2b	%s62,0(,%s63)
 1474      BF003E14 
 1475 1a20 D8FDFFFF 		ld	%s63,-552(,%fp)
 1475      89003F01 
 1476 1a28 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 1476      00003E06 
 1477 1a30 00000000 		and	%s62,%s62,(32)0
 1477      60BE3E44 
 1478 1a38 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 1478      BE00BE06 
 1479 1a40 00000000 		st	%s63,0(,%s62)
 1479      BE003F11 
 1480              	# line 1225
1225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 1481              		.loc	1 1225 0
 1482 1a48 00000000 		lea	%s0,conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 1482      00000006 
 1483 1a50 00000000 		and	%s0,%s0,(32)0
 1483      60800044 
 1484 1a58 00000000 		lea.sl	%s0,conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 1484      80008006 
 1485 1a60 08000000 		ld	%s1,8(,%fp)	# ptr
 1485      89000101 
 1486 1a68 00000000 		lea	%s12,__ftrace_func_exit@LO
 1486      00000C06 
 1487 1a70 00000000 		and	%s12,%s12,(32)0
 1487      608C0C44 
 1488 1a78 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 1488      8C008C06 
 1489 1a80 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 1489      8C000A08 
 1490              	# Start of epilogue codes
 1491 1a88 30000000 		ld	%s18,48(,%fp)
 1491      89001201 
 1492 1a90 38000000 		ld	%s19,56(,%fp)
 1492      89001301 
 1493 1a98 40000000 		ld	%s20,64(,%fp)
 1493      89001401 
 1494 1aa0 48000000 		ld	%s21,72(,%fp)
 1494      89001501 
 1495 1aa8 50000000 		ld	%s22,80(,%fp)
 1495      89001601 
 1496 1ab0 58000000 		ld	%s23,88(,%fp)
 1496      89001701 
 1497 1ab8 60000000 		ld	%s24,96(,%fp)
 1497      89001801 
 1498 1ac0 68000000 		ld	%s25,104(,%fp)
 1498      89001901 
 1499 1ac8 70000000 		ld	%s26,112(,%fp)
 1499      89001A01 
 1500 1ad0 78000000 		ld	%s27,120(,%fp)
 1500      89001B01 
 1501 1ad8 80000000 		ld	%s28,128(,%fp)
 1501      89001C01 
 1502 1ae0 88000000 		ld	%s29,136(,%fp)
 1502      89001D01 
 1503 1ae8 90000000 		ld	%s30,144(,%fp)
 1503      89001E01 
 1504 1af0 98000000 		ld	%s31,152(,%fp)
 1504      89001F01 
 1505 1af8 A0000000 		ld	%s32,160(,%fp)
 1505      89002001 
 1506 1b00 A8000000 		ld	%s33,168(,%fp)
 1506      89002101 
 1507 1b08 00000000 		or	%sp,0,%fp
 1507      89000B45 
 1508              		.cfi_def_cfa	11,8
 1509 1b10 18000000 		ld	%got,0x18(,%sp)
 1509      8B000F01 
 1510 1b18 20000000 		ld	%plt,0x20(,%sp)
 1510      8B001001 
 1511 1b20 08000000 		ld	%lr,0x8(,%sp)
 1511      8B000A01 
 1512 1b28 00000000 		ld	%fp,0x0(,%sp)
 1512      8B000901 
 1513 1b30 00000000 		b.l	(,%lr)
 1513      8A000F19 
 1514              	.L4.46:
 1515 1b38 90270000 		br.l	.L4.47
 1515      00000F18 
 1516              	.L4.48:
 1517              	# line 1150
1150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 1518              		.loc	1 1150 0
 1519 1b40 00000000 		adds.l	%s38,1,%s38
 1519      A6012659 
 1520 1b48 00000000 		adds.l	%s57,%s34,%s57
 1520      B9A23959 
 1521 1b50 00000000 		adds.l	%s60,%s2,%s60
 1521      BC823C59 
 1522 1b58 00000000 		adds.l	%s1,%s2,%s1
 1522      81820159 
 1523 1b60 00000000 		adds.l	%s61,%s63,%s61
 1523      BDBF3D59 
 1524 1b68 00000000 		adds.l	%s58,%s59,%s58
 1524      BABB3A59 
 1525 1b70 C8FFFFFF 		brgt.l	0,%s38,.L4.46
 1525      A6000118 
 1526 1b78 80FEFFFF 		br.l	.L4.45
 1526      00000F18 
 1527              	.L4.49:
 1528 1b80 98ECFFFF 		st	%s63,-4968(,%fp)	# spill 
 1528      89003F11 
 1529 1b88 88ECFFFF 		st	%s59,-4984(,%fp)	# spill 
 1529      89003B11 
 1530 1b90 F0EAFFFF 		ld	%s38,-5392(,%fp)	# restore 
 1530      89002601 
 1531 1b98 00000000 		or	%s19,0,%s61
 1531      BD001345 
 1532 1ba0 E8EAFFFF 		ld	%s34,-5400(,%fp)	# restore 
 1532      89002201 
 1533 1ba8 00000000 		or	%s24,0,%s60
 1533      BC001845 
 1534 1bb0 E0EAFFFF 		ld	%s2,-5408(,%fp)	# restore 
 1534      89000201 
 1535 1bb8 00000000 		or	%s42,0,%s58
 1535      BA002A45 
 1536 1bc0 F0EBFFFF 		ld	%s60,-5136(,%fp)	# restore 
 1536      89003C01 
 1537 1bc8 C8EAFFFF 		ld	%s1,-5432(,%fp)	# restore 
 1537      89000101 
 1538 1bd0 D8EAFFFF 		ld	%s63,-5416(,%fp)	# restore 
 1538      89003F01 
 1539 1bd8 B8EAFFFF 		ld	%s61,-5448(,%fp)	# restore 
 1539      89003D01 
 1540 1be0 D0EAFFFF 		ld	%s59,-5424(,%fp)	# restore 
 1540      89003B01 
 1541 1be8 C0EAFFFF 		ld	%s58,-5440(,%fp)	# restore 
 1541      89003A01 
 1542 1bf0 F8EAFFFF 		ld	%s62,-5384(,%fp)	# restore 
 1542      89003E01 
 1543 1bf8 B0EAFFFF 		ld	%s46,-5456(,%fp)	# restore 
 1543      89002E01 
 1544 1c00 A8EAFFFF 		ld	%s45,-5464(,%fp)	# restore 
 1544      89002D01 
 1545 1c08 A0EAFFFF 		ld	%s44,-5472(,%fp)	# restore 
 1545      89002C01 
 1546 1c10 98EAFFFF 		ld	%s43,-5480(,%fp)	# restore 
 1546      89002B01 
 1547 1c18 28FFFFFF 		br.l	.L4.48
 1547      00000F18 
 1548              	.L4.50:
 1549              	# line 1151
1151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 1550              		.loc	1 1151 0
 1551 1c20 00000000 		adds.l	%s38,1,%s38
 1551      A6012659 
 1552 1c28 00000000 		adds.l	%s34,%s35,%s34
 1552      A2A32259 
 1553 1c30 00000000 		adds.l	%s2,%s7,%s2
 1553      82870259 
 1554 1c38 98250000 		brgt.l	0,%s38,.L4.51
 1554      A6000118 
 1555 1c40 40FFFFFF 		br.l	.L4.49
 1555      00000F18 
 1556              	.L4.52:
 1557 1c48 38EBFFFF 		ld	%s38,-5320(,%fp)	# restore 
 1557      89002601 
 1558 1c50 30EBFFFF 		ld	%s35,-5328(,%fp)	# restore 
 1558      89002301 
 1559 1c58 18EBFFFF 		ld	%s34,-5352(,%fp)	# restore 
 1559      89002201 
 1560 1c60 28EBFFFF 		ld	%s7,-5336(,%fp)	# restore 
 1560      89000701 
 1561 1c68 20EBFFFF 		ld	%s2,-5344(,%fp)	# restore 
 1561      89000201 
 1562 1c70 00EBFFFF 		ld	%s52,-5376(,%fp)	# restore 
 1562      89003401 
 1563 1c78 40EBFFFF 		ld	%s50,-5312(,%fp)	# restore 
 1563      89003201 
 1564 1c80 10EBFFFF 		ld	%s58,-5360(,%fp)	# restore 
 1564      89003A01 
 1565 1c88 08EBFFFF 		ld	%s55,-5368(,%fp)	# restore 
 1565      89003701 
 1566 1c90 90FFFFFF 		br.l	.L4.50
 1566      00000F18 
 1567              	.L4.53:
 1568 1c98 98240000 		br.l	.L4.54
 1568      00000F18 
 1569              	.L4.55:
 1570              	# line 1152
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 1571              		.loc	1 1152 0
 1572 1ca0 00000000 		adds.l	%s50,1,%s50
 1572      B2013259 
 1573 1ca8 00000000 		adds.l	%s38,%s40,%s38
 1573      A6A82659 
 1574 1cb0 00000000 		adds.l	%s62,8,%s62
 1574      BE083E59 
 1575 1cb8 00000000 		adds.l	%s35,%s37,%s35
 1575      A3A52359 
 1576 1cc0 D8FFFFFF 		brgt.l	0,%s50,.L4.53
 1576      B2000118 
 1577 1cc8 80FFFFFF 		br.l	.L4.52
 1577      00000F18 
 1578              	.L4.56:
 1579 1cd0 78EBFFFF 		ld	%s50,-5256(,%fp)	# restore 
 1579      89003201 
 1580 1cd8 70EBFFFF 		ld	%s40,-5264(,%fp)	# restore 
 1580      89002801 
 1581 1ce0 58EBFFFF 		ld	%s38,-5288(,%fp)	# restore 
 1581      89002601 
 1582 1ce8 68EBFFFF 		ld	%s37,-5272(,%fp)	# restore 
 1582      89002501 
 1583 1cf0 60EBFFFF 		ld	%s35,-5280(,%fp)	# restore 
 1583      89002301 
 1584 1cf8 80EBFFFF 		ld	%s25,-5248(,%fp)	# restore 
 1584      89001901 
 1585 1d00 50EBFFFF 		ld	%s61,-5296(,%fp)	# restore 
 1585      89003D01 
 1586 1d08 48EBFFFF 		ld	%s60,-5304(,%fp)	# restore 
 1586      89003C01 
 1587 1d10 90FFFFFF 		br.l	.L4.55
 1587      00000F18 
 1588              	.L4.57:
 1589 1d18 98230000 		br.l	.L4.58
 1589      00000F18 
 1590              	.L4.59:
 1591              	# line 1153
1153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 1592              		.loc	1 1153 0
 1593 1d20 00000000 		adds.l	%s40,1,%s40
 1593      A8012859 
 1594 1d28 00000000 		adds.l	%s38,%s39,%s38
 1594      A6A72659 
 1595 1d30 00000000 		adds.l	%s50,8,%s50
 1595      B2083259 
 1596 1d38 00000000 		adds.l	%s37,4,%s37
 1596      A5042559 
 1597 1d40 D8FFFFFF 		brgt.l	0,%s40,.L4.57
 1597      A8000118 
 1598 1d48 88FFFFFF 		br.l	.L4.56
 1598      00000F18 
 1599              	.L4.60:
 1600 1d50 00000000 		or	%s18,0,%s45
 1600      AD001245 
 1601 1d58 00000000 		or	%s63,0,%s61
 1601      BD003F45 
 1602 1d60 00000000 		or	%s53,0,%s60
 1602      BC003545 
 1603 1d68 00000000 		or	%s54,0,%s58
 1603      BA003645 
 1604 1d70 00000000 		or	%s56,0,%s55
 1604      B7003845 
 1605 1d78 A8FFFFFF 		br.l	.L4.59
 1605      00000F18 
 1606              	.L4.44:
 1607 1d80 00000000 		or	%s54,0,%s56
 1607      B8003645 
 1608              	# line 1216
1216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 1609              		.loc	1 1216 0
 1610 1d88 00000000 		lvl	%s53
 1610      00B500BF 
 1611 1d90 00000023 		vldu.nc	%v35,4,%s54
 1611      B6040082 
 1612 1d98 00000000 		adds.l	%s54,%s46,%s45
 1612      ADAE3659 
 1613 1da0 00000000 		or	%s54,0,%s54
 1613      B6003645 
 1614 1da8 00000023 		vstu.nc	%v35,%s45,%s54
 1614      B6AD0092 
 1615              	# line 1215
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1616              		.loc	1 1215 0
 1617 1db0 00000000 		adds.l	%s46,%s46,%s44
 1617      ACAE2E59 
 1618 1db8 00000000 		adds.l	%s56,%s56,%s43
 1618      ABB83859 
 1619 1dc0 00000000 		subu.l	%s42,%s42,%s53
 1619      B5AA2A58 
 1620 1dc8 00000000 		cmpu.l	%s19,%s42,(0)1
 1620      00AA1355 
 1621 1dd0 80FFFFFF 		brle.l	%s19,0,.L4.60
 1621      00930618 
 1622 1dd8 08FCFFFF 		br.l	.L4.43
 1622      00000F18 
 1623              	.L4.61:
 1624 1de0 00000000 		subs.w.sx	%s52,0,(63)0
 1624      7F00345A 
 1625 1de8 00000000 		or	%s45,0,%s18
 1625      92002D45 
 1626 1df0 00000000 		or	%s52,0,%s52
 1626      B4003445 
 1627              	# line 1216
1216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 1628              		.loc	1 1216 0
 1629 1df8 00000000 		muls.l	%s52,%s52,%s18
 1629      92B4346E 
 1630 1e00 00000000 		or	%s55,0,%s56
 1630      B8003745 
 1631 1e08 00000000 		or	%s58,0,%s54
 1631      B6003A45 
 1632 1e10 00000000 		adds.l	%s46,%s37,%s52
 1632      B4A52E59 
 1633              	# line 1215
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1634              		.loc	1 1215 0
 1635 1e18 00000000 		smvl	%s54
 1635      0000362E 
 1636              	# line 1216
1216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 1637              		.loc	1 1216 0
 1638 1e20 00000000 		cmpu.l	%s52,%s53,%s54
 1638      B6B53455 
 1639 1e28 00000000 		or	%s54,0,%s54
 1639      B6003645 
 1640 1e30 06000000 		cmov.l.le	%s54,%s53,%s52
 1640      B5B4363B 
 1641 1e38 00000000 		or	%s42,0,%s53
 1641      B5002A45 
 1642 1e40 00000000 		or	%s52,0,%s54
 1642      B6003445 
 1643 1e48 00000000 		muls.l	%s44,%s18,%s52
 1643      B4922C6E 
 1644 1e50 00000000 		or	%s56,0,%s47
 1644      AF003845 
 1645 1e58 00000000 		muls.l	%s43,4,%s52
 1645      B4042B6E 
 1646 1e60 00000000 		or	%s60,0,%s53
 1646      B5003C45 
 1647 1e68 00000000 		or	%s61,0,%s63
 1647      BF003D45 
 1648 1e70 00000000 		or	%s53,0,%s54
 1648      B6003545 
 1649 1e78 08FFFFFF 		br.l	.L4.44
 1649      00000F18 
 1650              	.L4.62:
 1651              	# line 1215
1215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdst[dst_off0 + oc * OH_OW] = tmp[oc];
 1652              		.loc	1 1215 0
 1653 1e80 00000000 		cmpu.l	%s24,0,%s53
 1653      B5001855 
 1654 1e88 58FFFFFF 		brlt.l	%s24,0,.L4.61
 1654      00980218 
 1655 1e90 90FEFFFF 		br.l	.L4.59
 1655      00000F18 
 1656              	.L4.40:
 1657 1e98 00000000 		cmpu.l	%s24,%s53,(0)1
 1657      00B51855 
 1658 1ea0 E0FFFFFF 		brgt.l	%s24,0,.L4.62
 1658      00980118 
 1659 1ea8 78FEFFFF 		br.l	.L4.59
 1659      00000F18 
 1660              	.L4.63:
 1661 1eb0 00000000 		or	%s63,0,%s61
 1661      BD003F45 
 1662 1eb8 00000000 		or	%s20,0,%s60
 1662      BC001445 
 1663 1ec0 00000000 		or	%s54,0,%s58
 1663      BA003645 
 1664 1ec8 00000000 		or	%s56,0,%s55
 1664      B7003845 
 1665 1ed0 00000000 		or	%s53,0,%s52
 1665      B4003545 
 1666 1ed8 C0FFFFFF 		br.l	.L4.40
 1666      00000F18 
 1667              	.L4.42:
 1668 1ee0 00000000 		or	%s54,0,%s56
 1668      B8003645 
 1669              	# line 1212
1212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 1670              		.loc	1 1212 0
 1671 1ee8 00000000 		lvl	%s53
 1671      00B500BF 
 1672 1ef0 00000021 		vldu.nc	%v33,4,%s54
 1672      B6040082 
 1673 1ef8 00000000 		or	%s54,0,(0)1
 1673      00003645 
 1674 1f00 00210020 		vfmax.s	%v32,%s54,%v33
 1674      00B6A0BD 
 1675 1f08 00000000 		or	%s54,0,%s56
 1675      B8003645 
 1676 1f10 00000020 		vstu.nc	%v32,4,%s54
 1676      B6040092 
 1677              	# line 1210
1210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //tmp[oc] = (tmp[oc] < 0.f? 0.f: tmp[oc]);
 1678              		.loc	1 1210 0
 1679 1f18 00000000 		adds.l	%s56,%s56,%s46
 1679      AEB83859 
 1680 1f20 00000000 		subu.l	%s43,%s43,%s53
 1680      B5AB2B58 
 1681 1f28 00000000 		cmpu.l	%s20,%s43,(0)1
 1681      00AB1455 
 1682 1f30 80FFFFFF 		brle.l	%s20,0,.L4.63
 1682      00940618 
 1683 1f38 90FAFFFF 		br.l	.L4.41
 1683      00000F18 
 1684              	.L4.64:
 1685 1f40 00000000 		smvl	%s45
 1685      00002D2E 
 1686 1f48 00000000 		cmpu.l	%s44,%s53,%s45
 1686      ADB52C55 
 1687 1f50 00000000 		or	%s45,0,%s45
 1687      AD002D45 
 1688 1f58 06000000 		cmov.l.le	%s45,%s53,%s44
 1688      B5AC2D3B 
 1689 1f60 00000000 		or	%s43,0,%s53
 1689      B5002B45 
 1690 1f68 00000000 		or	%s55,0,%s56
 1690      B8003745 
 1691 1f70 00000000 		or	%s56,0,%s47
 1691      AF003845 
 1692 1f78 00000000 		or	%s44,0,%s45
 1692      AD002C45 
 1693 1f80 00000000 		muls.l	%s46,4,%s44
 1693      AC042E6E 
 1694 1f88 00000000 		or	%s58,0,%s54
 1694      B6003A45 
 1695 1f90 00000000 		or	%s60,0,%s20
 1695      94003C45 
 1696 1f98 00000000 		or	%s52,0,%s53
 1696      B5003445 
 1697 1fa0 00000000 		or	%s61,0,%s63
 1697      BF003D45 
 1698 1fa8 00000000 		or	%s40,0,%s35
 1698      A3002845 
 1699 1fb0 00000000 		or	%s53,0,%s45
 1699      AD003545 
 1700 1fb8 28FFFFFF 		br.l	.L4.42
 1700      00000F18 
 1701              	.L4.65:
 1702 1fc0 00000000 		cmpu.l	%s24,0,%s53
 1702      B5001855 
 1703 1fc8 78FFFFFF 		brlt.l	%s24,0,.L4.64
 1703      00980218 
 1704 1fd0 E8F9FFFF 		br.l	.L4.39
 1704      00000F18 
 1705              	.L4.66:
 1706 1fd8 00000000 		cmpu.l	%s24,%s34,(0)1
 1706      00A21855 
 1707 1fe0 00000000 		or	%s53,0,%s34
 1707      A2003545 
 1708 1fe8 D8FFFFFF 		brgt.l	%s24,0,.L4.65
 1708      00980118 
 1709 1ff0 00000000 		or	%s40,0,%s35
 1709      A3002845 
 1710 1ff8 A0FEFFFF 		br.l	.L4.40
 1710      00000F18 
 1711              	.L4.67:
 1712 2000 D8FFFFFF 		breq.w	1,%s36,.L4.66
 1712      A4018418 
 1713 2008 00000000 		or	%s40,0,%s35
 1713      A3002845 
 1714 2010 00000000 		or	%s53,0,%s34
 1714      A2003545 
 1715 2018 80FEFFFF 		br.l	.L4.40
 1715      00000F18 
 1716              	.L4.68:
 1717 2020 88EDFFFF 		st	%s1,-4728(,%fp)	# spill 
 1717      89000111 
 1718 2028 D8EBFFFF 		st	%s21,-5160(,%fp)	# spill 
 1718      89001511 
 1719 2030 A8EBFFFF 		st	%s43,-5208(,%fp)	# spill 
 1719      89002B11 
 1720 2038 B0EBFFFF 		st	%s42,-5200(,%fp)	# spill 
 1720      89002A11 
 1721 2040 E0EBFFFF 		st	%s58,-5152(,%fp)	# spill 
 1721      89003A11 
 1722 2048 00000000 		or	%s56,0,%s2
 1722      82003845 
 1723 2050 00000000 		or	%s54,0,%s7
 1723      87003645 
 1724 2058 A8ECFFFF 		ld	%s47,-4952(,%fp)	# restore 
 1724      89002F01 
 1725 2060 00000000 		or	%s48,0,%s19
 1725      93003045 
 1726 2068 00000000 		or	%s63,0,%s24
 1726      98003F45 
 1727 2070 00000000 		or	%s49,0,%s25
 1727      99003145 
 1728 2078 88ECFFFF 		ld	%s59,-4984(,%fp)	# restore 
 1728      89003B01 
 1729 2080 00000000 		or	%s50,0,%s44
 1729      AC003245 
 1730 2088 00000000 		or	%s38,0,%s45
 1730      AD002645 
 1731 2090 00000000 		or	%s39,0,%s46
 1731      AE002745 
 1732 2098 60ECFFFF 		ld	%s62,-5024(,%fp)	# restore 
 1732      89003E01 
 1733 20a0 58ECFFFF 		ld	%s57,-5032(,%fp)	# restore 
 1733      89003901 
 1734 20a8 30ECFFFF 		ld	%s21,-5072(,%fp)	# restore 
 1734      89001501 
 1735 20b0 50FFFFFF 		br.l	.L4.67
 1735      00000F18 
 1736              	.L4.69:
 1737 20b8 90030000 		br.l	.L4.70
 1737      00000F18 
 1738              	.L4.71:
 1739              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 1740              		.loc	1 1202 0
 1741 20c0 00000000 		adds.l	%s56,4,%s56
 1741      B8043859 
 1742 20c8 00000000 		adds.l	%s54,16,%s54
 1742      B6103659 
 1743 20d0 00000000 		adds.l	%s53,%s53,%s43
 1743      ABB53559 
 1744 20d8 00000000 		adds.l	%s52,%s52,%s42
 1744      AAB43459 
 1745 20e0 00000000 		adds.l	%s50,%s50,%s42
 1745      AAB23259 
 1746 20e8 00000000 		adds.l	%s49,%s49,%s42
 1746      AAB13159 
 1747 20f0 C8FFFFFF 		brgt.l	0,%s56,.L4.69
 1747      B8000118 
 1748 20f8 28FFFFFF 		br.l	.L4.68
 1748      00000F18 
 1749              	.L4.72:
 1750              	# line 1205
1205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 1751              		.loc	1 1205 0
 1752 2100 00000000 		or	%s63,1,(0)1
 1752      00013F45 
 1753 2108 00000000 		adds.l	%s62,%s54,(0)1
 1753      00B63E59 
 1754 2110 00000000 		adds.l	%s61,12,%s62
 1754      BE0C3D59 
 1755 2118 00000000 		lvl	%s63
 1755      00BF00BF 
 1756 2120 0000001B 		vstu.nc	%v27,0,%s61
 1756      BD000092 
 1757 2128 00000000 		or	%s60,1,(0)1
 1757      00013C45 
 1758 2130 00000000 		adds.l	%s63,8,%s62
 1758      BE083F59 
 1759 2138 00000000 		lvl	%s60
 1759      00BC00BF 
 1760 2140 0000001C 		vstu.nc	%v28,0,%s63
 1760      BF000092 
 1761 2148 00000000 		or	%s61,1,(0)1
 1761      00013D45 
 1762 2150 00000000 		adds.l	%s62,4,%s62
 1762      BE043E59 
 1763 2158 00000000 		lvl	%s61
 1763      00BD00BF 
 1764 2160 0000001D 		vstu.nc	%v29,0,%s62
 1764      BE000092 
 1765 2168 00000000 		or	%s63,1,(0)1
 1765      00013F45 
 1766 2170 00000000 		or	%s62,0,%s54
 1766      B6003E45 
 1767 2178 00000000 		lvl	%s63
 1767      00BF00BF 
 1768 2180 0000001E 		vstu.nc	%v30,0,%s62
 1768      BE000092 
 1769 2188 38FFFFFF 		br.l	.L4.71
 1769      00000F18 
 1770              	.L4.73:
 1771 2190 00000000 		or	%s1,0,%s60
 1771      BC000145 
 1772              	# line 1204
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 1773              		.loc	1 1204 0
 1774 2198 00000000 		lvl	%s62
 1774      00BE00BF 
 1775 21a0 00003019 		vfsum.s	%v25,%v48
 1775      000080EC 
 1776 21a8 00000000 		or	%s63,1,(0)1
 1776      00013F45 
 1777 21b0 00000000 		lvl	%s63
 1777      00BF00BF 
 1778 21b8 00191E1E 		vfadd.s	%v30,%v30,%v25
 1778      000080CC 
 1779 21c0 00000000 		lvl	%s62
 1779      00BE00BF 
 1780 21c8 00002F18 		vfsum.s	%v24,%v47
 1780      000080EC 
 1781 21d0 00000000 		or	%s63,1,(0)1
 1781      00013F45 
 1782 21d8 00000000 		lvl	%s63
 1782      00BF00BF 
 1783 21e0 00181D1D 		vfadd.s	%v29,%v29,%v24
 1783      000080CC 
 1784 21e8 00000000 		lvl	%s62
 1784      00BE00BF 
 1785 21f0 00002E17 		vfsum.s	%v23,%v46
 1785      000080EC 
 1786 21f8 00000000 		or	%s63,1,(0)1
 1786      00013F45 
 1787 2200 00000000 		lvl	%s63
 1787      00BF00BF 
 1788 2208 00171C1C 		vfadd.s	%v28,%v28,%v23
 1788      000080CC 
 1789 2210 00000000 		lvl	%s62
 1789      00BE00BF 
 1790 2218 00002D16 		vfsum.s	%v22,%v45
 1790      000080EC 
 1791 2220 00000000 		or	%s63,1,(0)1
 1791      00013F45 
 1792 2228 00000000 		lvl	%s63
 1792      00BF00BF 
 1793 2230 00161B1B 		vfadd.s	%v27,%v27,%v22
 1793      000080CC 
 1794 2238 00000000 		or	%s56,0,%s61
 1794      BD003845 
 1795 2240 00000000 		or	%s54,0,%s59
 1795      BB003645 
 1796 2248 B8FEFFFF 		br.l	.L4.72
 1796      00000F18 
 1797              	.L4.38:
 1798              	# line 1203
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 1799              		.loc	1 1203 0
 1800 2250 00000000 		adds.l	%s57,%s60,(0)1
 1800      00BC3959 
 1801 2258 00000000 		adds.l	%s57,%s57,%s56
 1801      B8B93959 
 1802 2260 00000000 		lvl	%s54
 1802      00B600BF 
 1803 2268 0000002C 		vldu.nc	%v44,4,%s57
 1803      B9040082 
 1804              	# line 1204
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 1805              		.loc	1 1204 0
 1806 2270 00000000 		adds.l	%s57,%s53,(0)1
 1806      00B53959 
 1807 2278 00000000 		adds.l	%s57,%s57,%s56
 1807      B8B93959 
 1808 2280 0000002B 		vldu.nc	%v43,4,%s57
 1808      B9040082 
 1809 2288 00000000 		adds.l	%s57,%s52,(0)1
 1809      00B43959 
 1810 2290 00000000 		adds.l	%s57,%s57,%s56
 1810      B8B93959 
 1811 2298 0000002A 		vldu.nc	%v42,4,%s57
 1811      B9040082 
 1812 22a0 2C2B3030 		vfmad.s	%v48,%v48,%v43,%v44
 1812      000080E2 
 1813 22a8 2C2A2F2F 		vfmad.s	%v47,%v47,%v42,%v44
 1813      000080E2 
 1814 22b0 00000000 		adds.l	%s57,%s50,(0)1
 1814      00B23959 
 1815 22b8 00000000 		adds.l	%s57,%s57,%s56
 1815      B8B93959 
 1816 22c0 00000029 		vldu.nc	%v41,4,%s57
 1816      B9040082 
 1817 22c8 2C292E2E 		vfmad.s	%v46,%v46,%v41,%v44
 1817      000080E2 
 1818 22d0 00000000 		adds.l	%s57,%s49,(0)1
 1818      00B13959 
 1819 22d8 00000000 		adds.l	%s57,%s57,%s56
 1819      B8B93959 
 1820 22e0 00000028 		vldu.nc	%v40,4,%s57
 1820      B9040082 
 1821 22e8 2C282D2D 		vfmad.s	%v45,%v45,%v40,%v44
 1821      000080E2 
 1822              	# line 1203
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 1823              		.loc	1 1203 0
 1824 22f0 00000000 		adds.l	%s56,%s56,%s48
 1824      B0B83859 
 1825 22f8 00000000 		subs.l	%s47,%s47,%s54
 1825      B6AF2F5B 
 1826 2300 90FEFFFF 		brge.l	0,%s47,.L4.73
 1826      AF000518 
 1827 2308 A0F6FFFF 		br.l	.L4.37
 1827      00000F18 
 1828              	.L4.74:
 1829 2310 00000000 		subs.l	%s63,0,%s58
 1829      BA003F5B 
 1830 2318 00000000 		smvl	%s62
 1830      00003E2E 
 1831 2320 80000000 		mins.l	%s57,%s63,%s62
 1831      BEBF3968 
 1832              	# line 1204
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 1833              		.loc	1 1204 0
 1834 2328 00000000 		or	%s55,0,(0)1
 1834      00003745 
 1835 2330 00000000 		or	%s60,0,%s1
 1835      81003C45 
 1836 2338 00000000 		or	%s59,0,%s54
 1836      B6003B45 
 1837 2340 00000000 		or	%s61,0,%s56
 1837      B8003D45 
 1838 2348 00000000 		or	%s54,0,%s57
 1838      B9003645 
 1839 2350 00000000 		lvl	%s62
 1839      00BE00BF 
 1840 2358 00000030 		vbrdu	%v48,%s55
 1840      00B7808C 
 1841 2360 00000000 		or	%s55,0,(0)1
 1841      00003745 
 1842 2368 0000002F 		vbrdu	%v47,%s55
 1842      00B7808C 
 1843 2370 00000000 		or	%s55,0,(0)1
 1843      00003745 
 1844 2378 0000002E 		vbrdu	%v46,%s55
 1844      00B7808C 
 1845 2380 00000000 		or	%s55,0,(0)1
 1845      00003745 
 1846 2388 0000002D 		vbrdu	%v45,%s55
 1846      00B7808C 
 1847 2390 00000000 		or	%s47,0,%s63
 1847      BF002F45 
 1848              	# line 1203
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 1849              		.loc	1 1203 0
 1850 2398 00000000 		or	%s56,0,(0)1
 1850      00003845 
 1851 23a0 00000000 		muls.l	%s48,4,%s57
 1851      B904306E 
 1852 23a8 A8FEFFFF 		br.l	.L4.38
 1852      00000F18 
 1853              	.L4.75:
 1854 23b0 00000000 		or	%s40,1,(0)1
 1854      00012845 
 1855 23b8 00000000 		or	%s39,0,%s54
 1855      B6002745 
 1856 23c0 00000000 		lvl	%s40
 1856      00A800BF 
 1857 23c8 0000001E 		vldu.nc	%v30,0,%s39
 1857      A7000082 
 1858 23d0 00000000 		or	%s40,1,(0)1
 1858      00012845 
 1859 23d8 00000000 		adds.l	%s39,%s54,(0)1
 1859      00B62759 
 1860 23e0 00000000 		adds.l	%s38,4,%s39
 1860      A7042659 
 1861 23e8 00000000 		lvl	%s40
 1861      00A800BF 
 1862 23f0 0000001D 		vldu.nc	%v29,0,%s38
 1862      A6000082 
 1863 23f8 00000000 		or	%s40,1,(0)1
 1863      00012845 
 1864 2400 00000000 		adds.l	%s38,8,%s39
 1864      A7082659 
 1865 2408 00000000 		lvl	%s40
 1865      00A800BF 
 1866 2410 0000001C 		vldu.nc	%v28,0,%s38
 1866      A6000082 
 1867 2418 00000000 		or	%s40,1,(0)1
 1867      00012845 
 1868 2420 00000000 		adds.l	%s39,12,%s39
 1868      A70C2759 
 1869 2428 00000000 		lvl	%s40
 1869      00A800BF 
 1870 2430 0000001B 		vldu.nc	%v27,0,%s39
 1870      A7000082 
 1871 2438 D8FEFFFF 		brlt.l	0,%s21,.L4.74
 1871      95000218 
 1872 2440 C0FCFFFF 		br.l	.L4.72
 1872      00000F18 
 1873              	.L4.70:
 1874 2448 68FFFFFF 		brlt.l	0,%s21,.L4.75
 1874      95000218 
 1875 2450 70FCFFFF 		br.l	.L4.71
 1875      00000F18 
 1876              	.L4.76:
 1877 2458 60ECFFFF 		st	%s62,-5024(,%fp)	# spill 
 1877      89003E11 
 1878 2460 58ECFFFF 		st	%s57,-5032(,%fp)	# spill 
 1878      89003911 
 1879 2468 30ECFFFF 		st	%s21,-5072(,%fp)	# spill 
 1879      89001511 
 1880 2470 A8ECFFFF 		st	%s47,-4952(,%fp)	# spill 
 1880      89002F11 
 1881 2478 88ECFFFF 		st	%s59,-4984(,%fp)	# spill 
 1881      89003B11 
 1882 2480 00ECFFFF 		ld	%s62,-5120(,%fp)	# restore 
 1882      89003E01 
 1883 2488 00000000 		or	%s2,0,%s56
 1883      B8000245 
 1884 2490 D8EBFFFF 		ld	%s21,-5160(,%fp)	# restore 
 1884      89001501 
 1885              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 1886              		.loc	1 1202 0
 1887 2498 00000000 		adds.l	%s56,%s62,%s59
 1887      BBBE3859 
 1888 24a0 00000000 		muls.l	%s61,4,%s62
 1888      BE043D6E 
 1889 24a8 88EDFFFF 		ld	%s1,-4728(,%fp)	# restore 
 1889      89000101 
 1890 24b0 00000000 		or	%s7,0,%s54
 1890      B6000745 
 1891 24b8 00000000 		adds.l	%s54,%s61,%s47
 1891      AFBD3659 
 1892 24c0 E8EBFFFF 		ld	%s61,-5144(,%fp)	# restore 
 1892      89003D01 
 1893 24c8 00000000 		or	%s19,0,%s48
 1893      B0001345 
 1894 24d0 E0EBFFFF 		ld	%s58,-5152(,%fp)	# restore 
 1894      89003A01 
 1895 24d8 00000000 		muls.l	%s61,%s62,%s61
 1895      BDBE3D6E 
 1896 24e0 F0EBFFFF 		ld	%s60,-5136(,%fp)	# restore 
 1896      89003C01 
 1897 24e8 00000000 		or	%s24,0,%s63
 1897      BF001845 
 1898 24f0 00000000 		or	%s25,0,%s49
 1898      B1001945 
 1899 24f8 00000000 		adds.l	%s53,%s61,%s60
 1899      BCBD3559 
 1900 2500 D0EBFFFF 		ld	%s63,-5168(,%fp)	# restore 
 1900      89003F01 
 1901 2508 00000000 		or	%s44,0,%s50
 1901      B2002C45 
 1902 2510 00000000 		or	%s45,0,%s38
 1902      A6002D45 
 1903 2518 00000000 		muls.l	%s61,%s62,%s63
 1903      BFBE3D6E 
 1904 2520 C8EBFFFF 		ld	%s60,-5176(,%fp)	# restore 
 1904      89003C01 
 1905 2528 00000000 		or	%s46,0,%s39
 1905      A7002E45 
 1906 2530 00000000 		adds.l	%s52,%s61,%s60
 1906      BCBD3459 
 1907 2538 00000000 		muls.l	%s61,%s62,%s63
 1907      BFBE3D6E 
 1908 2540 C0EBFFFF 		ld	%s60,-5184(,%fp)	# restore 
 1908      89003C01 
 1909 2548 00000000 		adds.l	%s50,%s61,%s60
 1909      BCBD3259 
 1910 2550 00000000 		muls.l	%s63,%s62,%s63
 1910      BFBE3F6E 
 1911 2558 B8EBFFFF 		ld	%s62,-5192(,%fp)	# restore 
 1911      89003E01 
 1912 2560 00000000 		adds.l	%s49,%s63,%s62
 1912      BEBF3159 
 1913 2568 B0EBFFFF 		ld	%s42,-5200(,%fp)	# restore 
 1913      89002A01 
 1914 2570 A8EBFFFF 		ld	%s43,-5208(,%fp)	# restore 
 1914      89002B01 
 1915 2578 D0FEFFFF 		br.l	.L4.70
 1915      00000F18 
 1916              	.L4.77:
 1917 2580 00ECFFFF 		ld	%s24,-5120(,%fp)	# restore 
 1917      89001801 
 1918 2588 D0FEFFFF 		brlt.l	%s24,%s30,.L4.76
 1918      9E980218 
 1919 2590 70FAFFFF 		br.l	.L4.67
 1919      00000F18 
 1920              	.L4.78:
 1921 2598 88EDFFFF 		st	%s60,-4728(,%fp)	# spill 
 1921      89003C11 
 1922 25a0 D8EBFFFF 		st	%s21,-5160(,%fp)	# spill 
 1922      89001511 
 1923 25a8 E0EBFFFF 		st	%s61,-5152(,%fp)	# spill 
 1923      89003D11 
 1924 25b0 E8EBFFFF 		st	%s46,-5144(,%fp)	# spill 
 1924      89002E11 
 1925 25b8 00000000 		or	%s56,0,%s7
 1925      87003845 
 1926 25c0 00000000 		or	%s54,0,%s19
 1926      93003645 
 1927 25c8 00000000 		or	%s63,0,%s24
 1927      98003F45 
 1928 25d0 00000000 		or	%s59,0,%s25
 1928      99003B45 
 1929 25d8 00000000 		or	%s50,0,%s42
 1929      AA003245 
 1930 25e0 00000000 		or	%s39,0,%s43
 1930      AB002745 
 1931 25e8 00000000 		or	%s62,0,%s44
 1931      AC003E45 
 1932 25f0 00000000 		or	%s57,0,%s45
 1932      AD003945 
 1933 25f8 00000000 		or	%s21,0,%s47
 1933      AF001545 
 1934 2600 00000000 		or	%s47,0,%s55
 1934      B7002F45 
 1935 2608 78FFFFFF 		br.l	.L4.77
 1935      00000F18 
 1936              	.L4.79:
 1937 2610 00000000 		adds.l	%s56,1,%s56
 1937      B8013859 
 1938 2618 00000000 		adds.l	%s54,4,%s54
 1938      B6043659 
 1939 2620 00000000 		adds.l	%s53,%s46,%s53
 1939      B5AE3559 
 1940 2628 70010000 		brgt.l	0,%s56,.L4.80
 1940      B8000118 
 1941 2630 68FFFFFF 		br.l	.L4.78
 1941      00000F18 
 1942              	.L4.81:
 1943              	# line 1205
1205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
 1944              		.loc	1 1205 0
 1945 2638 00000000 		or	%s63,1,(0)1
 1945      00013F45 
 1946 2640 00000000 		or	%s62,0,%s54
 1946      B6003E45 
 1947 2648 00000000 		lvl	%s63
 1947      00BF00BF 
 1948 2650 0000001F 		vstu.nc	%v31,0,%s62
 1948      BE000092 
 1949 2658 B8FFFFFF 		br.l	.L4.79
 1949      00000F18 
 1950              	.L4.82:
 1951 2660 00000000 		or	%s54,0,%s1
 1951      81003645 
 1952 2668 00000000 		or	%s56,0,%s2
 1952      82003845 
 1953              	# line 1204
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 1954              		.loc	1 1204 0
 1955 2670 00000000 		lvl	%s62
 1955      00BE00BF 
 1956 2678 0000331A 		vfsum.s	%v26,%v51
 1956      000080EC 
 1957 2680 00000000 		or	%s63,1,(0)1
 1957      00013F45 
 1958 2688 00000000 		lvl	%s63
 1958      00BF00BF 
 1959 2690 001A1F1F 		vfadd.s	%v31,%v31,%v26
 1959      000080CC 
 1960 2698 A0FFFFFF 		br.l	.L4.81
 1960      00000F18 
 1961              	.L4.36:
 1962 26a0 00000000 		adds.l	%s57,%s60,(0)1
 1962      00BC3959 
 1963 26a8 00000000 		adds.l	%s57,%s57,%s56
 1963      B8B93959 
 1964 26b0 00000000 		lvl	%s54
 1964      00B600BF 
 1965 26b8 00000032 		vldu.nc	%v50,4,%s57
 1965      B9040082 
 1966 26c0 00000000 		adds.l	%s57,%s53,(0)1
 1966      00B53959 
 1967 26c8 00000000 		adds.l	%s57,%s57,%s56
 1967      B8B93959 
 1968 26d0 00000031 		vldu.nc	%v49,4,%s57
 1968      B9040082 
 1969 26d8 32313333 		vfmad.s	%v51,%v51,%v49,%v50
 1969      000080E2 
 1970              	# line 1203
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 1971              		.loc	1 1203 0
 1972 26e0 00000000 		adds.l	%s56,%s56,%s52
 1972      B4B83859 
 1973 26e8 00000000 		subs.l	%s50,%s50,%s54
 1973      B6B2325B 
 1974 26f0 70FFFFFF 		brge.l	0,%s50,.L4.82
 1974      B2000518 
 1975 26f8 A0F2FFFF 		br.l	.L4.35
 1975      00000F18 
 1976              	.L4.83:
 1977 2700 00000000 		subs.l	%s63,0,%s61
 1977      BD003F5B 
 1978 2708 00000000 		smvl	%s62
 1978      00003E2E 
 1979 2710 80000000 		mins.l	%s59,%s63,%s62
 1979      BEBF3B68 
 1980              	# line 1204
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 1981              		.loc	1 1204 0
 1982 2718 00000000 		or	%s58,0,(0)1
 1982      00003A45 
 1983 2720 00000000 		or	%s1,0,%s54
 1983      B6000145 
 1984 2728 00000000 		or	%s54,0,%s59
 1984      BB003645 
 1985 2730 00000000 		or	%s2,0,%s56
 1985      B8000245 
 1986 2738 00000000 		lvl	%s62
 1986      00BE00BF 
 1987 2740 00000033 		vbrdu	%v51,%s58
 1987      00BA808C 
 1988 2748 00000000 		or	%s50,0,%s63
 1988      BF003245 
 1989              	# line 1203
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 1990              		.loc	1 1203 0
 1991 2750 00000000 		or	%s56,0,(0)1
 1991      00003845 
 1992 2758 00000000 		muls.l	%s52,4,%s59
 1992      BB04346E 
 1993 2760 40FFFFFF 		br.l	.L4.36
 1993      00000F18 
 1994              	.L4.84:
 1995 2768 00000000 		or	%s40,1,(0)1
 1995      00012845 
 1996 2770 00000000 		or	%s39,0,%s54
 1996      B6002745 
 1997 2778 00000000 		lvl	%s40
 1997      00A800BF 
 1998 2780 0000001F 		vldu.nc	%v31,0,%s39
 1998      A7000082 
 1999 2788 78FFFFFF 		brlt.l	0,%s21,.L4.83
 1999      95000218 
 2000 2790 A8FEFFFF 		br.l	.L4.81
 2000      00000F18 
 2001              	.L4.80:
 2002 2798 D0FFFFFF 		brlt.l	0,%s21,.L4.84
 2002      95000218 
 2003 27a0 70FEFFFF 		br.l	.L4.79
 2003      00000F18 
 2004              	.L4.85:
 2005 27a8 88EDFFFF 		ld	%s60,-4728(,%fp)	# restore 
 2005      89003C01 
 2006 27b0 00000000 		or	%s7,0,%s56
 2006      B8000745 
 2007 27b8 F8EBFFFF 		ld	%s56,-5128(,%fp)	# restore 
 2007      89003801 
 2008 27c0 00000000 		or	%s19,0,%s54
 2008      B6001345 
 2009 27c8 00000000 		or	%s54,0,%s47
 2009      AF003645 
 2010 27d0 F0EBFFFF 		ld	%s53,-5136(,%fp)	# restore 
 2010      89003501 
 2011 27d8 00000000 		or	%s24,0,%s63
 2011      BF001845 
 2012 27e0 00000000 		or	%s25,0,%s59
 2012      BB001945 
 2013 27e8 00000000 		or	%s42,0,%s50
 2013      B2002A45 
 2014 27f0 00000000 		or	%s43,0,%s39
 2014      A7002B45 
 2015 27f8 00000000 		or	%s44,0,%s62
 2015      BE002C45 
 2016 2800 00000000 		or	%s45,0,%s57
 2016      B9002D45 
 2017 2808 00000000 		or	%s55,0,%s47
 2017      AF003745 
 2018 2810 00000000 		or	%s47,0,%s21
 2018      95002F45 
 2019 2818 E8EBFFFF 		ld	%s46,-5144(,%fp)	# restore 
 2019      89002E01 
 2020 2820 E0EBFFFF 		ld	%s61,-5152(,%fp)	# restore 
 2020      89003D01 
 2021 2828 D8EBFFFF 		ld	%s21,-5160(,%fp)	# restore 
 2021      89001501 
 2022 2830 68FFFFFF 		br.l	.L4.80
 2022      00000F18 
 2023              	.L4.86:
 2024 2838 00ECFFFF 		ld	%s24,-5120(,%fp)	# restore 
 2024      89001801 
 2025 2840 68FFFFFF 		brlt.l	0,%s24,.L4.85
 2025      98000218 
 2026 2848 38FDFFFF 		br.l	.L4.77
 2026      00000F18 
 2027              	.L4.87:
 2028 2850 E8FFFFFF 		brlt.l	0,%s30,.L4.86
 2028      9E000218 
 2029 2858 A8F7FFFF 		br.l	.L4.67
 2029      00000F18 
 2030              	.L4.88:
 2031 2860 88EDFFFF 		st	%s30,-4728(,%fp)	# spill 
 2031      89001E11 
 2032 2868 08ECFFFF 		st	%s18,-5112(,%fp)	# spill 
 2032      89001211 
 2033 2870 10ECFFFF 		st	%s44,-5104(,%fp)	# spill 
 2033      89002C11 
 2034 2878 18ECFFFF 		st	%s59,-5096(,%fp)	# spill 
 2034      89003B11 
 2035 2880 20ECFFFF 		st	%s61,-5088(,%fp)	# spill 
 2035      89003D11 
 2036 2888 A0ECFFFF 		ld	%s30,-4960(,%fp)	# restore 
 2036      89001E01 
 2037 2890 00000000 		or	%s51,0,%s19
 2037      93003345 
 2038 2898 08EDFFFF 		ld	%s22,-4856(,%fp)	# restore 
 2038      89001601 
 2039 28a0 00EDFFFF 		ld	%s56,-4864(,%fp)	# restore 
 2039      89003801 
 2040 28a8 F8ECFFFF 		ld	%s54,-4872(,%fp)	# restore 
 2040      89003601 
 2041 28b0 F0ECFFFF 		ld	%s28,-4880(,%fp)	# restore 
 2041      89001C01 
 2042 28b8 E8ECFFFF 		ld	%s27,-4888(,%fp)	# restore 
 2042      89001B01 
 2043 28c0 E0ECFFFF 		ld	%s6,-4896(,%fp)	# restore 
 2043      89000601 
 2044 28c8 D8ECFFFF 		ld	%s5,-4904(,%fp)	# restore 
 2044      89000501 
 2045 28d0 D0ECFFFF 		ld	%s4,-4912(,%fp)	# restore 
 2045      89000401 
 2046 28d8 C8ECFFFF 		ld	%s3,-4920(,%fp)	# restore 
 2046      89000301 
 2047 28e0 C0ECFFFF 		ld	%s36,-4928(,%fp)	# restore 
 2047      89002401 
 2048 28e8 B8ECFFFF 		ld	%s34,-4936(,%fp)	# restore 
 2048      89002201 
 2049 28f0 B0ECFFFF 		ld	%s26,-4944(,%fp)	# restore 
 2049      89001A01 
 2050 28f8 A8ECFFFF 		ld	%s47,-4952(,%fp)	# restore 
 2050      89002F01 
 2051 2900 40ECFFFF 		ld	%s48,-5056(,%fp)	# restore 
 2051      89003001 
 2052 2908 98ECFFFF 		ld	%s63,-4968(,%fp)	# restore 
 2052      89003F01 
 2053 2910 90ECFFFF 		ld	%s18,-4976(,%fp)	# restore 
 2053      89001201 
 2054 2918 48ECFFFF 		ld	%s49,-5048(,%fp)	# restore 
 2054      89003101 
 2055 2920 88ECFFFF 		ld	%s59,-4984(,%fp)	# restore 
 2055      89003B01 
 2056 2928 80ECFFFF 		ld	%s37,-4992(,%fp)	# restore 
 2056      89002501 
 2057 2930 78ECFFFF 		ld	%s50,-5000(,%fp)	# restore 
 2057      89003201 
 2058 2938 50ECFFFF 		ld	%s38,-5040(,%fp)	# restore 
 2058      89002601 
 2059 2940 70ECFFFF 		ld	%s35,-5008(,%fp)	# restore 
 2059      89002301 
 2060 2948 68ECFFFF 		ld	%s39,-5016(,%fp)	# restore 
 2060      89002701 
 2061 2950 60ECFFFF 		ld	%s62,-5024(,%fp)	# restore 
 2061      89003E01 
 2062 2958 58ECFFFF 		ld	%s57,-5032(,%fp)	# restore 
 2062      89003901 
 2063 2960 38ECFFFF 		ld	%s41,-5064(,%fp)	# restore 
 2063      89002901 
 2064 2968 30ECFFFF 		ld	%s21,-5072(,%fp)	# restore 
 2064      89001501 
 2065 2970 E0FEFFFF 		br.l	.L4.87
 2065      00000F18 
 2066              	.L4.89:
 2067              	# line 1192
1192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 2068              		.loc	1 1192 0
 2069 2978 00000000 		adds.l	%s56,1,%s56
 2069      B8013859 
 2070 2980 00000000 		adds.l	%s54,%s19,%s54
 2070      B6933659 
 2071 2988 00000000 		adds.l	%s53,%s19,%s53
 2071      B5933559 
 2072 2990 00000000 		adds.l	%s46,%s19,%s46
 2072      AE932E59 
 2073 2998 00000000 		adds.l	%s43,%s44,%s43
 2073      ABAC2B59 
 2074 29a0 100B0000 		brgt.l	0,%s56,.L4.90
 2074      B8000118 
 2075 29a8 B8FEFFFF 		br.l	.L4.88
 2075      00000F18 
 2076              	.L4.91:
 2077 29b0 10EDFFFF 		st	%s58,-4848(,%fp)	# spill 
 2077      89003A11 
 2078 29b8 18EDFFFF 		st	%s55,-4840(,%fp)	# spill 
 2078      89003711 
 2079 29c0 20EDFFFF 		st	%s51,-4832(,%fp)	# spill 
 2079      89003311 
 2080 29c8 00000000 		or	%s56,0,%s28
 2080      9C003845 
 2081 29d0 00000000 		or	%s19,0,%s26
 2081      9A001345 
 2082 29d8 00000000 		or	%s54,0,%s30
 2082      9E003645 
 2083 29e0 00000000 		or	%s53,0,%s29
 2083      9D003545 
 2084 29e8 80EDFFFF 		ld	%s46,-4736(,%fp)	# restore 
 2084      89002E01 
 2085 29f0 00000000 		or	%s44,0,%s27
 2085      9B002C45 
 2086 29f8 90EDFFFF 		ld	%s43,-4720(,%fp)	# restore 
 2086      89002B01 
 2087 2a00 00000000 		or	%s59,0,%s31
 2087      9F003B45 
 2088 2a08 70EDFFFF 		ld	%s20,-4752(,%fp)	# restore 
 2088      89001401 
 2089 2a10 88EDFFFF 		ld	%s30,-4728(,%fp)	# restore 
 2089      89001E01 
 2090 2a18 78EDFFFF 		ld	%s31,-4744(,%fp)	# restore 
 2090      89001F01 
 2091 2a20 98EDFFFF 		ld	%s29,-4712(,%fp)	# restore 
 2091      89001D01 
 2092 2a28 A0EDFFFF 		ld	%s57,-4704(,%fp)	# restore 
 2092      89003901 
 2093 2a30 48FFFFFF 		br.l	.L4.89
 2093      00000F18 
 2094              	.L4.92:
 2095              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 2096              		.loc	1 1194 0
 2097 2a38 00000000 		adds.l	%s63,4,%s63
 2097      BF043F59 
 2098 2a40 00000000 		adds.l	%s62,%s62,%s61
 2098      BDBE3E59 
 2099 2a48 00000000 		adds.l	%s60,%s60,%s58
 2099      BABC3C59 
 2100 2a50 00000000 		adds.l	%s57,%s57,%s61
 2100      BDB93959 
 2101 2a58 00000000 		adds.l	%s56,%s56,%s55
 2101      B7B83859 
 2102 2a60 00000000 		adds.l	%s54,%s54,%s58
 2102      BAB63659 
 2103 2a68 00000000 		adds.l	%s53,%s53,%s61
 2103      BDB53559 
 2104 2a70 00000000 		adds.l	%s52,%s52,%s51
 2104      B3B43459 
 2105 2a78 00000000 		adds.l	%s50,%s50,%s58
 2105      BAB23259 
 2106 2a80 00000000 		adds.l	%s49,%s49,%s61
 2106      BDB13159 
 2107 2a88 00000000 		adds.l	%s48,%s48,%s51
 2107      B3B03059 
 2108 2a90 00000000 		adds.l	%s47,%s47,%s58
 2108      BAAF2F59 
 2109 2a98 00000000 		adds.l	%s46,%s46,%s51
 2109      B3AE2E59 
 2110 2aa0 00050000 		brgt.l	0,%s63,.L4.93
 2110      BF000118 
 2111 2aa8 08FFFFFF 		br.l	.L4.91
 2111      00000F18 
 2112              	.L4.94:
 2113 2ab0 00000000 		or	%s24,0,%s24
 2113      98001845 
 2114 2ab8 00000000 		or	%s44,0,%s44
 2114      AC002C45 
 2115              	# line 1196
1196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2116              		.loc	1 1196 0
 2117 2ac0 00000000 		lvl	%s24
 2117      009800BF 
 2118 2ac8 00000026 		vldl.sx.nc	%v38,4,%s44
 2118      AC040083 
 2119 2ad0 0026040F 		vfmk.w.eq	%vm15,%v38
 2119      000000B5 
 2120 2ad8 00000000 		or	%s59,0,(0)1
 2120      00003B45 
 2121 2ae0 00000027 		vbrdu	%v39,%s59,%vm15
 2121      00BB8F8C 
 2122 2ae8 00000F0F 		negm	%vm15,%vm15
 2122      00000095 
 2123 2af0 00000000 		adds.l	%s59,%s46,(0)1
 2123      00AE3B59 
 2124 2af8 00000000 		or	%s59,0,%s59
 2124      BB003B45 
 2125 2b00 00000025 		vldu.nc	%v37,%s33,%s59
 2125      BBA10082 
 2126 2b08 00252727 		vmrg	%v39,%v39,%v37,%vm15
 2126      00000FD6 
 2127 2b10 00000000 		adds.l	%s59,%s47,(0)1
 2127      00AF3B59 
 2128 2b18 00000000 		or	%s59,0,%s59
 2128      BB003B45 
 2129 2b20 00000027 		vstu.nc	%v39,4,%s59
 2129      BB040092 
 2130              	# line 1195
1195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
 2131              		.loc	1 1195 0
 2132 2b28 00000000 		subs.l	%s0,0,%s20
 2132      9400005B 
 2133 2b30 00000000 		lea	%s12,__grow_stack@LO
 2133      00000C06 
 2134 2b38 00000000 		and	%s12,%s12,(32)0
 2134      608C0C44 
 2135 2b40 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2135      8C008C06 
 2136 2b48 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2136      8C000A08 
 2137 2b50 00000000 		or	%s63,0,%s2
 2137      82003F45 
 2138 2b58 00000000 		or	%s62,0,%s5
 2138      85003E45 
 2139 2b60 00000000 		or	%s61,0,%s4
 2139      84003D45 
 2140 2b68 00000000 		or	%s60,0,%s1
 2140      81003C45 
 2141 2b70 00000000 		or	%s58,0,%s3
 2141      83003A45 
 2142 2b78 C0FEFFFF 		br.l	.L4.92
 2142      00000F18 
 2143              	.L4.95:
 2144              	# line 1196
1196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2145              		.loc	1 1196 0
 2146 2b80 00000000 		ld1b.sx	%s61,0(%s62,%s63)	# bool
 2146      BFBE3D05 
 2147 2b88 00000000 		or	%s61,0,%s61
 2147      BD003D45 
 2148 2b90 00000000 		stl	%s61,0(%s59,%s60)
 2148      BCBB3D13 
 2149 2b98 00000000 		adds.l	%s62,1,%s62
 2149      BE013E59 
 2150 2ba0 00000000 		adds.l	%s59,4,%s59
 2150      BB043B59 
 2151 2ba8 00000000 		adds.l	%s58,-1,%s58
 2151      BA7F3A59 
 2152 2bb0 D0FFFFFF 		brlt.l	0,%s58,.L4.95
 2152      BA000218 
 2153 2bb8 F8FEFFFF 		br.l	.L4.94
 2153      00000F18 
 2154              	.L4.96:
 2155 2bc0 00000000 		or	%s61,0,%s24
 2155      98003D45 
 2156 2bc8 00000000 		or	%s42,0,%s42
 2156      AA002A45 
 2157 2bd0 00000000 		lvl	%s61
 2157      00BD00BF 
 2158 2bd8 00000038 		vldl.sx.nc	%v56,4,%s42
 2158      AA040083 
 2159 2be0 00000000 		or	%s63,0,%s19
 2159      93003F45 
 2160 2be8 0038040F 		vfmk.w.eq	%vm15,%v56
 2160      000000B5 
 2161 2bf0 00000000 		or	%s45,0,(0)1
 2161      00002D45 
 2162 2bf8 00000000 		or	%s60,0,%s25
 2162      99003C45 
 2163 2c00 00000039 		vbrdu	%v57,%s45,%vm15
 2163      00AD8F8C 
 2164 2c08 00000F0F 		negm	%vm15,%vm15
 2164      00000095 
 2165 2c10 00000000 		adds.l	%s45,%s48,(0)1
 2165      00B02D59 
 2166 2c18 00000000 		or	%s45,0,%s45
 2166      AD002D45 
 2167 2c20 00000037 		vldu.nc	%v55,%s33,%s45
 2167      ADA10082 
 2168 2c28 00373939 		vmrg	%v57,%v57,%v55,%vm15
 2168      00000FD6 
 2169 2c30 00000000 		adds.l	%s45,%s50,(0)1
 2169      00B22D59 
 2170 2c38 00000000 		or	%s45,0,%s45
 2170      AD002D45 
 2171 2c40 00000039 		vstu.nc	%v57,4,%s45
 2171      AD040092 
 2172 2c48 00000000 		or	%s58,0,%s24
 2172      98003A45 
 2173 2c50 00000000 		or	%s62,0,(0)1
 2173      00003E45 
 2174 2c58 00000000 		or	%s59,0,(0)1
 2174      00003B45 
 2175 2c60 20FFFFFF 		br.l	.L4.95
 2175      00000F18 
 2176              	.L4.97:
 2177 2c68 00000000 		ld1b.sx	%s61,0(%s62,%s63)	# bool
 2177      BFBE3D05 
 2178 2c70 00000000 		or	%s61,0,%s61
 2178      BD003D45 
 2179 2c78 00000000 		stl	%s61,0(%s59,%s60)
 2179      BCBB3D13 
 2180 2c80 00000000 		adds.l	%s62,1,%s62
 2180      BE013E59 
 2181 2c88 00000000 		adds.l	%s59,4,%s59
 2181      BB043B59 
 2182 2c90 00000000 		adds.l	%s58,-1,%s58
 2182      BA7F3A59 
 2183 2c98 D0FFFFFF 		brlt.l	0,%s58,.L4.97
 2183      BA000218 
 2184 2ca0 20FFFFFF 		br.l	.L4.96
 2184      00000F18 
 2185              	.L4.98:
 2186 2ca8 00000000 		or	%s61,0,%s24
 2186      98003D45 
 2187 2cb0 00000000 		or	%s43,0,%s43
 2187      AB002B45 
 2188 2cb8 00000000 		lvl	%s61
 2188      00BD00BF 
 2189 2cc0 0000003B 		vldl.sx.nc	%v59,4,%s43
 2189      AB040083 
 2190 2cc8 00000000 		or	%s63,0,%s7
 2190      87003F45 
 2191 2cd0 003B040F 		vfmk.w.eq	%vm15,%v59
 2191      000000B5 
 2192 2cd8 00000000 		or	%s45,0,(0)1
 2192      00002D45 
 2193 2ce0 00000000 		or	%s60,0,%s22
 2193      96003C45 
 2194 2ce8 0000003C 		vbrdu	%v60,%s45,%vm15
 2194      00AD8F8C 
 2195 2cf0 00000F0F 		negm	%vm15,%vm15
 2195      00000095 
 2196 2cf8 00000000 		adds.l	%s45,%s52,(0)1
 2196      00B42D59 
 2197 2d00 00000000 		or	%s45,0,%s45
 2197      AD002D45 
 2198 2d08 0000003A 		vldu.nc	%v58,%s33,%s45
 2198      ADA10082 
 2199 2d10 003A3C3C 		vmrg	%v60,%v60,%v58,%vm15
 2199      00000FD6 
 2200 2d18 00000000 		adds.l	%s45,%s54,(0)1
 2200      00B62D59 
 2201 2d20 00000000 		or	%s45,0,%s45
 2201      AD002D45 
 2202 2d28 0000003C 		vstu.nc	%v60,4,%s45
 2202      AD040092 
 2203 2d30 00000000 		or	%s58,0,%s24
 2203      98003A45 
 2204 2d38 00000000 		or	%s62,0,(0)1
 2204      00003E45 
 2205 2d40 00000000 		or	%s59,0,(0)1
 2205      00003B45 
 2206 2d48 20FFFFFF 		br.l	.L4.97
 2206      00000F18 
 2207              	.L4.99:
 2208 2d50 00000000 		ld1b.sx	%s61,0(%s62,%s63)	# bool
 2208      BFBE3D05 
 2209 2d58 00000000 		or	%s61,0,%s61
 2209      BD003D45 
 2210 2d60 00000000 		stl	%s61,0(%s59,%s60)
 2210      BCBB3D13 
 2211 2d68 00000000 		adds.l	%s62,1,%s62
 2211      BE013E59 
 2212 2d70 00000000 		adds.l	%s59,4,%s59
 2212      BB043B59 
 2213 2d78 00000000 		adds.l	%s58,-1,%s58
 2213      BA7F3A59 
 2214 2d80 D0FFFFFF 		brlt.l	0,%s58,.L4.99
 2214      BA000218 
 2215 2d88 20FFFFFF 		br.l	.L4.98
 2215      00000F18 
 2216              	.L4.100:
 2217 2d90 00000000 		or	%s61,0,%s24
 2217      98003D45 
 2218 2d98 00000000 		or	%s45,0,%s45
 2218      AD002D45 
 2219 2da0 00000000 		lvl	%s61
 2219      00BD00BF 
 2220 2da8 0000003F 		vldl.sx.nc	%v63,4,%s45
 2220      AD040083 
 2221 2db0 00000000 		or	%s63,0,%s6
 2221      86003F45 
 2222 2db8 003F040F 		vfmk.w.eq	%vm15,%v63
 2222      000000B5 
 2223 2dc0 00000000 		or	%s45,0,(0)1
 2223      00002D45 
 2224 2dc8 00000000 		or	%s60,0,%s21
 2224      95003C45 
 2225 2dd0 00000000 		smvl	%s13
 2225      00000D2E 
 2226 2dd8 00000000 		lvl	%s13
 2226      008D00BF 
 2227 2de0 00000000 		lvl	%s61
 2227      00BD00BF 
 2228 2de8 0000003E 		vbrdu	%v62,%s45,%vm15
 2228      00AD8F8C 
 2229 2df0 00000F0F 		negm	%vm15,%vm15
 2229      00000095 
 2230 2df8 00000000 		adds.l	%s45,%s56,(0)1
 2230      00B82D59 
 2231 2e00 00000000 		or	%s45,0,%s45
 2231      AD002D45 
 2232 2e08 0000003D 		vldu.nc	%v61,%s33,%s45
 2232      ADA10082 
 2233 2e10 003D3E3E 		vmrg	%v62,%v62,%v61,%vm15
 2233      00000FD6 
 2234 2e18 00000000 		adds.l	%s45,%s1,(0)1
 2234      00812D59 
 2235 2e20 00000000 		or	%s45,0,%s45
 2235      AD002D45 
 2236 2e28 0000003E 		vstu.nc	%v62,4,%s45
 2236      AD040092 
 2237 2e30 00000000 		or	%s58,0,%s24
 2237      98003A45 
 2238 2e38 00000000 		or	%s62,0,(0)1
 2238      00003E45 
 2239 2e40 00000000 		or	%s59,0,(0)1
 2239      00003B45 
 2240 2e48 08FFFFFF 		br.l	.L4.99
 2240      00000F18 
 2241              	.L4.101:
 2242 2e50 00000000 		ld1b.sx	%s61,0(%s62,%s63)	# bool
 2242      BFBE3D05 
 2243 2e58 00000000 		or	%s61,0,%s61
 2243      BD003D45 
 2244 2e60 00000000 		stl	%s61,0(%s59,%s60)
 2244      BCBB3D13 
 2245 2e68 00000000 		adds.l	%s62,1,%s62
 2245      BE013E59 
 2246 2e70 00000000 		adds.l	%s59,4,%s59
 2246      BB043B59 
 2247 2e78 00000000 		adds.l	%s58,-1,%s58
 2247      BA7F3A59 
 2248 2e80 D0FFFFFF 		brlt.l	0,%s58,.L4.101
 2248      BA000218 
 2249 2e88 08FFFFFF 		br.l	.L4.100
 2249      00000F18 
 2250              	.L4.102:
 2251 2e90 B8EDFFFF 		st	%s63,-4680(,%fp)	# spill 
 2251      89003F11 
 2252 2e98 00000000 		or	%s63,0,%s62
 2252      BE003F45 
 2253 2ea0 B0EDFFFF 		st	%s63,-4688(,%fp)	# spill 
 2253      89003F11 
 2254 2ea8 00000000 		or	%s6,0,%s57
 2254      B9000645 
 2255 2eb0 00000000 		or	%s7,0,%s53
 2255      B5000745 
 2256 2eb8 00000000 		or	%s19,0,%s49
 2256      B1001345 
 2257              	# line 1195
1195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
 2258              		.loc	1 1195 0
 2259 2ec0 00000000 		subs.l	%s24,0,%s23
 2259      9700185B 
 2260 2ec8 00000000 		muls.l	%s0,16,%s24
 2260      9810006E 
 2261 2ed0 A8EDFFFF 		st	%s0,-4696(,%fp)	# spill 
 2261      89000011 
 2262 2ed8 00000000 		lea	%s12,__grow_stack@LO
 2262      00000C06 
 2263 2ee0 00000000 		and	%s12,%s12,(32)0
 2263      608C0C44 
 2264 2ee8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2264      8C008C06 
 2265 2ef0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2265      8C000A08 
 2266 2ef8 D0000000 		lea	%s45,208
 2266      00002D06 
 2267 2f00 00000000 		adds.l	%s45,%sp,%s45
 2267      AD8B2D59 
 2268 2f08 B0EDFFFF 		ld	%s63,-4688(,%fp)	# restore 
 2268      89003F01 
 2269 2f10 00000000 		or	%s1,0,%s60
 2269      BC000145 
 2270 2f18 00000000 		or	%s60,0,%s45
 2270      AD003C45 
 2271 2f20 00000000 		muls.l	%s44,4,%s24
 2271      98042C6E 
 2272 2f28 B8EDFFFF 		ld	%s2,-4680(,%fp)	# restore 
 2272      89000201 
 2273 2f30 00000000 		or	%s3,0,%s58
 2273      BA000345 
 2274 2f38 00000000 		adds.l	%s43,%s45,%s44
 2274      ACAD2B59 
 2275 2f40 00000000 		or	%s4,0,%s61
 2275      BD000445 
 2276 2f48 00000000 		or	%s21,0,%s43
 2276      AB001545 
 2277 2f50 00000000 		adds.l	%s42,%s43,%s44
 2277      ACAB2A59 
 2278 2f58 00000000 		or	%s5,0,%s62
 2278      BE000545 
 2279 2f60 00000000 		or	%s22,0,%s42
 2279      AA001645 
 2280 2f68 00000000 		adds.l	%s44,%s42,%s44
 2280      ACAA2C59 
 2281 2f70 A8EDFFFF 		ld	%s20,-4696(,%fp)	# restore 
 2281      89001401 
 2282 2f78 00000000 		or	%s25,0,%s44
 2282      AC001945 
 2283 2f80 00000000 		or	%s58,0,%s24
 2283      98003A45 
 2284 2f88 00000000 		or	%s62,0,(0)1
 2284      00003E45 
 2285 2f90 00000000 		or	%s59,0,(0)1
 2285      00003B45 
 2286 2f98 B8FEFFFF 		br.l	.L4.101
 2286      00000F18 
 2287              	.L4.93:
 2288 2fa0 F0FEFFFF 		brlt.l	0,%s18,.L4.102
 2288      92000218 
 2289 2fa8 90FAFFFF 		br.l	.L4.92
 2289      00000F18 
 2290              	.L4.103:
 2291 2fb0 A0EDFFFF 		st	%s57,-4704(,%fp)	# spill 
 2291      89003911 
 2292 2fb8 98EDFFFF 		st	%s29,-4712(,%fp)	# spill 
 2292      89001D11 
 2293 2fc0 90EDFFFF 		st	%s43,-4720(,%fp)	# spill 
 2293      89002B11 
 2294 2fc8 88EDFFFF 		st	%s30,-4728(,%fp)	# spill 
 2294      89001E11 
 2295 2fd0 80EDFFFF 		st	%s46,-4736(,%fp)	# spill 
 2295      89002E11 
 2296 2fd8 78EDFFFF 		st	%s31,-4744(,%fp)	# spill 
 2296      89001F11 
 2297 2fe0 70EDFFFF 		st	%s20,-4752(,%fp)	# spill 
 2297      89001411 
 2298 2fe8 68EDFFFF 		ld	%s45,-4760(,%fp)	# restore 
 2298      89002D01 
 2299 2ff0 00000000 		or	%s26,0,%s19
 2299      93001A45 
 2300 2ff8 00000000 		or	%s27,0,%s44
 2300      AC001B45 
 2301              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 2302              		.loc	1 1194 0
 2303 3000 00000000 		adds.l	%s63,%s20,%s45
 2303      AD943F59 
 2304 3008 00000000 		muls.l	%s45,%s20,%s18
 2304      92942D6E 
 2305 3010 00000000 		or	%s28,0,%s56
 2305      B8001C45 
 2306 3018 00000000 		adds.l	%s62,%s45,%s31
 2306      9FAD3E59 
 2307 3020 00000000 		muls.l	%s44,%s46,%s61
 2307      BDAE2C6E 
 2308 3028 00000000 		or	%s31,0,%s59
 2308      BB001F45 
 2309 3030 00000000 		adds.l	%s44,%s44,%s30
 2309      9EAC2C59 
 2310 3038 00000000 		muls.l	%s42,%s20,%s61
 2310      BD942A6E 
 2311 3040 00000000 		adds.l	%s60,%s44,%s42
 2311      AAAC3C59 
 2312 3048 60EDFFFF 		ld	%s44,-4768(,%fp)	# restore 
 2312      89002C01 
 2313 3050 00000000 		adds.l	%s44,%s45,%s44
 2313      ACAD2C59 
 2314 3058 00000000 		muls.l	%s42,%s43,%s29
 2314      9DAB2A6E 
 2315 3060 00000000 		adds.l	%s42,%s42,%s57
 2315      B9AA2A59 
 2316 3068 00000000 		muls.l	%s59,%s20,%s59
 2316      BB943B6E 
 2317 3070 00000000 		or	%s57,0,%s44
 2317      AC003945 
 2318 3078 00000000 		adds.l	%s56,%s42,%s59
 2318      BBAA3859 
 2319 3080 00000000 		muls.l	%s59,%s46,%s61
 2319      BDAE3B6E 
 2320 3088 58EDFFFF 		ld	%s44,-4776(,%fp)	# restore 
 2320      89002C01 
 2321 3090 00000000 		adds.l	%s44,%s59,%s44
 2321      ACBB2C59 
 2322 3098 00000000 		muls.l	%s59,%s20,%s61
 2322      BD943B6E 
 2323 30a0 00000000 		adds.l	%s59,%s44,%s59
 2323      BBAC3B59 
 2324 30a8 50EDFFFF 		ld	%s44,-4784(,%fp)	# restore 
 2324      89002C01 
 2325 30b0 00000000 		adds.l	%s44,%s45,%s44
 2325      ACAD2C59 
 2326 30b8 00000000 		muls.l	%s42,%s43,%s29
 2326      9DAB2A6E 
 2327 30c0 48EDFFFF 		ld	%s41,-4792(,%fp)	# restore 
 2327      89002901 
 2328 30c8 00000000 		adds.l	%s41,%s42,%s41
 2328      A9AA2959 
 2329 30d0 40EDFFFF 		ld	%s42,-4800(,%fp)	# restore 
 2329      89002A01 
 2330 30d8 00000000 		muls.l	%s40,%s20,%s42
 2330      AA94286E 
 2331 30e0 00000000 		adds.l	%s52,%s41,%s40
 2331      A8A93459 
 2332 30e8 00000000 		muls.l	%s41,%s54,%s61
 2332      BDB6296E 
 2333 30f0 00000000 		adds.l	%s41,%s30,%s41
 2333      A99E2959 
 2334 30f8 00000000 		muls.l	%s40,%s20,%s61
 2334      BD94286E 
 2335 3100 00000000 		adds.l	%s50,%s41,%s40
 2335      A8A93259 
 2336 3108 38EDFFFF 		ld	%s41,-4808(,%fp)	# restore 
 2336      89002901 
 2337 3110 00000000 		adds.l	%s49,%s45,%s41
 2337      A9AD3159 
 2338 3118 00000000 		muls.l	%s45,%s43,%s29
 2338      9DAB2D6E 
 2339 3120 30EDFFFF 		ld	%s41,-4816(,%fp)	# restore 
 2339      89002901 
 2340 3128 00000000 		adds.l	%s41,%s45,%s41
 2340      A9AD2959 
 2341 3130 00000000 		muls.l	%s45,%s20,%s42
 2341      AA942D6E 
 2342 3138 00000000 		adds.l	%s48,%s41,%s45
 2342      ADA93059 
 2343 3140 00000000 		muls.l	%s45,%s53,%s61
 2343      BDB52D6E 
 2344 3148 00000000 		adds.l	%s45,%s30,%s45
 2344      AD9E2D59 
 2345 3150 00000000 		muls.l	%s41,%s20,%s61
 2345      BD94296E 
 2346 3158 00000000 		or	%s30,0,%s54
 2346      B6001E45 
 2347 3160 00000000 		or	%s54,0,%s59
 2347      BB003645 
 2348 3168 00000000 		adds.l	%s47,%s45,%s41
 2348      A9AD2F59 
 2349 3170 00000000 		muls.l	%s43,%s43,%s29
 2349      9DAB2B6E 
 2350 3178 28EDFFFF 		ld	%s59,-4824(,%fp)	# restore 
 2350      89003B01 
 2351 3180 00000000 		or	%s29,0,%s53
 2351      B5001D45 
 2352 3188 00000000 		or	%s53,0,%s44
 2352      AC003545 
 2353 3190 00000000 		adds.l	%s59,%s43,%s59
 2353      BBAB3B59 
 2354 3198 00000000 		muls.l	%s42,%s20,%s42
 2354      AA942A6E 
 2355 31a0 00000000 		adds.l	%s46,%s59,%s42
 2355      AABB2E59 
 2356 31a8 20EDFFFF 		ld	%s51,-4832(,%fp)	# restore 
 2356      89003301 
 2357 31b0 18EDFFFF 		ld	%s55,-4840(,%fp)	# restore 
 2357      89003701 
 2358 31b8 10EDFFFF 		ld	%s58,-4848(,%fp)	# restore 
 2358      89003A01 
 2359 31c0 E0FDFFFF 		br.l	.L4.93
 2359      00000F18 
 2360              	.L4.104:
 2361 31c8 E8FDFFFF 		brlt.l	%s20,%s19,.L4.103
 2361      93940218 
 2362 31d0 A8F7FFFF 		br.l	.L4.89
 2362      00000F18 
 2363              	.L4.105:
 2364 31d8 00000000 		or	%s44,0,%s21
 2364      95002C45 
 2365 31e0 00000000 		or	%s43,0,%s27
 2365      9B002B45 
 2366 31e8 00000000 		or	%s46,0,%s28
 2366      9C002E45 
 2367 31f0 00000000 		or	%s53,0,%s22
 2367      96003545 
 2368 31f8 00000000 		or	%s54,0,%s25
 2368      99003645 
 2369 3200 00000000 		or	%s56,0,%s26
 2369      9A003845 
 2370 3208 A0EDFFFF 		ld	%s57,-4704(,%fp)	# restore 
 2370      89003901 
 2371 3210 B8FFFFFF 		br.l	.L4.104
 2371      00000F18 
 2372              	.L4.106:
 2373 3218 F8010000 		br.l	.L4.107
 2373      00000F18 
 2374              	.L4.108:
 2375 3220 00000000 		adds.l	%s63,1,%s63
 2375      BF013F59 
 2376 3228 00000000 		adds.l	%s62,%s18,%s62
 2376      BE923E59 
 2377 3230 00000000 		adds.l	%s60,%s61,%s60
 2377      BCBD3C59 
 2378 3238 00000000 		adds.l	%s58,%s59,%s58
 2378      BABB3A59 
 2379 3240 D8FFFFFF 		brgt.l	0,%s63,.L4.106
 2379      BF000118 
 2380 3248 90FFFFFF 		br.l	.L4.105
 2380      00000F18 
 2381              	.L4.109:
 2382 3250 00000000 		or	%s24,0,%s24
 2382      98001845 
 2383 3258 00000000 		or	%s57,0,%s57
 2383      B9003945 
 2384              	# line 1196
1196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2385              		.loc	1 1196 0
 2386 3260 00000000 		lvl	%s24
 2386      009800BF 
 2387 3268 00000036 		vldl.sx.nc	%v54,4,%s57
 2387      B9040083 
 2388 3270 0036040F 		vfmk.w.eq	%vm15,%v54
 2388      000000B5 
 2389 3278 00000000 		or	%s57,0,(0)1
 2389      00003945 
 2390 3280 00000000 		smvl	%s13
 2390      00000D2E 
 2391 3288 00000000 		lvl	%s13
 2391      008D00BF 
 2392 3290 00000000 		lvl	%s24
 2392      009800BF 
 2393 3298 00000035 		vbrdu	%v53,%s57,%vm15
 2393      00B98F8C 
 2394 32a0 00000F0F 		negm	%vm15,%vm15
 2394      00000095 
 2395 32a8 00000000 		or	%s57,0,%s58
 2395      BA003945 
 2396 32b0 00000034 		vldu.nc	%v52,%s33,%s57
 2396      B9A10082 
 2397 32b8 00343535 		vmrg	%v53,%v53,%v52,%vm15
 2397      00000FD6 
 2398 32c0 00000000 		or	%s57,0,%s1
 2398      81003945 
 2399 32c8 00000035 		vstu.nc	%v53,4,%s57
 2399      B9040092 
 2400              	# line 1195
1195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
 2401              		.loc	1 1195 0
 2402 32d0 00000000 		subs.l	%s0,0,%s6
 2402      8600005B 
 2403 32d8 00000000 		lea	%s12,__grow_stack@LO
 2403      00000C06 
 2404 32e0 00000000 		and	%s12,%s12,(32)0
 2404      608C0C44 
 2405 32e8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2405      8C008C06 
 2406 32f0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2406      8C000A08 
 2407 32f8 00000000 		or	%s63,0,%s2
 2407      82003F45 
 2408 3300 00000000 		or	%s62,0,%s5
 2408      85003E45 
 2409 3308 00000000 		or	%s61,0,%s4
 2409      84003D45 
 2410 3310 00000000 		or	%s60,0,%s1
 2410      81003C45 
 2411 3318 00000000 		or	%s59,0,%s3
 2411      83003B45 
 2412 3320 00FFFFFF 		br.l	.L4.108
 2412      00000F18 
 2413              	.L4.110:
 2414              	# line 1196
1196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2415              		.loc	1 1196 0
 2416 3328 00000000 		ld1b.sx	%s62,0(,%s63)	# bool
 2416      BF003E05 
 2417 3330 00000000 		or	%s62,0,%s62
 2417      BE003E45 
 2418 3338 00000000 		stl	%s62,0(%s60,%s61)
 2418      BDBC3E13 
 2419 3340 00000000 		adds.l	%s63,1,%s63
 2419      BF013F59 
 2420 3348 00000000 		adds.l	%s60,4,%s60
 2420      BC043C59 
 2421 3350 00000000 		adds.l	%s59,-1,%s59
 2421      BB7F3B59 
 2422 3358 D0FFFFFF 		brlt.l	0,%s59,.L4.110
 2422      BB000218 
 2423 3360 F0FEFFFF 		br.l	.L4.109
 2423      00000F18 
 2424              	.L4.111:
 2425 3368 C8F5FFFF 		st	%s63,-2616(,%fp)	# spill 
 2425      89003F11 
 2426              	# line 1195
1195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
 2427              		.loc	1 1195 0
 2428 3370 00000000 		subs.l	%s24,0,%s23
 2428      9700185B 
 2429 3378 00000000 		muls.l	%s0,4,%s24
 2429      9804006E 
 2430 3380 C0F5FFFF 		st	%s0,-2624(,%fp)	# spill 
 2430      89000011 
 2431 3388 00000000 		lea	%s12,__grow_stack@LO
 2431      00000C06 
 2432 3390 00000000 		and	%s12,%s12,(32)0
 2432      608C0C44 
 2433 3398 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2433      8C008C06 
 2434 33a0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2434      8C000A08 
 2435 33a8 D0000000 		lea	%s57,208
 2435      00003906 
 2436 33b0 00000000 		adds.l	%s57,%sp,%s57
 2436      B98B3959 
 2437 33b8 00000000 		or	%s1,0,%s60
 2437      BC000145 
 2438 33c0 C8F5FFFF 		ld	%s2,-2616(,%fp)	# restore 
 2438      89000201 
 2439 33c8 00000000 		or	%s3,0,%s59
 2439      BB000345 
 2440 33d0 00000000 		or	%s4,0,%s61
 2440      BD000445 
 2441 33d8 00000000 		or	%s61,0,%s57
 2441      B9003D45 
 2442 33e0 00000000 		or	%s59,0,%s24
 2442      98003B45 
 2443 33e8 00000000 		or	%s63,0,%s62
 2443      BE003F45 
 2444 33f0 00000000 		or	%s60,0,(0)1
 2444      00003C45 
 2445 33f8 00000000 		or	%s5,0,%s62
 2445      BE000545 
 2446 3400 C0F5FFFF 		ld	%s6,-2624(,%fp)	# restore 
 2446      89000601 
 2447 3408 20FFFFFF 		br.l	.L4.110
 2447      00000F18 
 2448              	.L4.107:
 2449 3410 58FFFFFF 		brlt.l	0,%s18,.L4.111
 2449      92000218 
 2450 3418 08FEFFFF 		br.l	.L4.108
 2450      00000F18 
 2451              	.L4.112:
 2452 3420 00000000 		or	%s63,0,%s32
 2452      A0003F45 
 2453 3428 A0EDFFFF 		st	%s57,-4704(,%fp)	# spill 
 2453      89003911 
 2454 3430 00000000 		or	%s62,0,%s31
 2454      9F003E45 
 2455              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 2456              		.loc	1 1194 0
 2457 3438 00000000 		muls.l	%s55,%s46,%s61
 2457      BDAE376E 
 2458 3440 00000000 		or	%s21,0,%s44
 2458      AC001545 
 2459 3448 00000000 		or	%s22,0,%s53
 2459      B5001645 
 2460 3450 00000000 		adds.l	%s55,%s55,%s30
 2460      9EB73759 
 2461 3458 00000000 		or	%s25,0,%s54
 2461      B6001945 
 2462 3460 00000000 		or	%s60,0,%s55
 2462      B7003C45 
 2463 3468 00000000 		muls.l	%s55,%s43,%s29
 2463      9DAB376E 
 2464 3470 00000000 		or	%s26,0,%s56
 2464      B8001A45 
 2465 3478 00000000 		or	%s27,0,%s43
 2465      AB001B45 
 2466 3480 00000000 		adds.l	%s57,%s55,%s57
 2466      B9B73959 
 2467 3488 00000000 		or	%s28,0,%s46
 2467      AE001C45 
 2468 3490 00000000 		or	%s58,0,%s57
 2468      B9003A45 
 2469 3498 78FFFFFF 		br.l	.L4.107
 2469      00000F18 
 2470              	.L4.113:
 2471 34a0 80FFFFFF 		brlt.l	0,%s20,.L4.112
 2471      94000218 
 2472 34a8 20FDFFFF 		br.l	.L4.104
 2472      00000F18 
 2473              	.L4.90:
 2474 34b0 F0FFFFFF 		brlt.l	0,%s19,.L4.113
 2474      93000218 
 2475 34b8 C0F4FFFF 		br.l	.L4.89
 2475      00000F18 
 2476              	.L4.114:
 2477 34c0 08EDFFFF 		st	%s22,-4856(,%fp)	# spill 
 2477      89001611 
 2478 34c8 00EDFFFF 		st	%s56,-4864(,%fp)	# spill 
 2478      89003811 
 2479 34d0 F8ECFFFF 		st	%s54,-4872(,%fp)	# spill 
 2479      89003611 
 2480 34d8 F0ECFFFF 		st	%s28,-4880(,%fp)	# spill 
 2480      89001C11 
 2481 34e0 E8ECFFFF 		st	%s27,-4888(,%fp)	# spill 
 2481      89001B11 
 2482 34e8 E0ECFFFF 		st	%s6,-4896(,%fp)	# spill 
 2482      89000611 
 2483 34f0 D8ECFFFF 		st	%s5,-4904(,%fp)	# spill 
 2483      89000511 
 2484 34f8 D0ECFFFF 		st	%s4,-4912(,%fp)	# spill 
 2484      89000411 
 2485 3500 C8ECFFFF 		st	%s3,-4920(,%fp)	# spill 
 2485      89000311 
 2486 3508 C0ECFFFF 		st	%s36,-4928(,%fp)	# spill 
 2486      89002411 
 2487 3510 B8ECFFFF 		st	%s34,-4936(,%fp)	# spill 
 2487      89002211 
 2488 3518 B0ECFFFF 		st	%s26,-4944(,%fp)	# spill 
 2488      89001A11 
 2489 3520 A8ECFFFF 		st	%s47,-4952(,%fp)	# spill 
 2489      89002F11 
 2490 3528 A0ECFFFF 		st	%s30,-4960(,%fp)	# spill 
 2490      89001E11 
 2491 3530 98ECFFFF 		st	%s63,-4968(,%fp)	# spill 
 2491      89003F11 
 2492 3538 90ECFFFF 		st	%s18,-4976(,%fp)	# spill 
 2492      89001211 
 2493 3540 88ECFFFF 		st	%s59,-4984(,%fp)	# spill 
 2493      89003B11 
 2494 3548 80ECFFFF 		st	%s37,-4992(,%fp)	# spill 
 2494      89002511 
 2495 3550 78ECFFFF 		st	%s50,-5000(,%fp)	# spill 
 2495      89003211 
 2496 3558 70ECFFFF 		st	%s35,-5008(,%fp)	# spill 
 2496      89002311 
 2497 3560 68ECFFFF 		st	%s39,-5016(,%fp)	# spill 
 2497      89002711 
 2498 3568 60ECFFFF 		st	%s62,-5024(,%fp)	# spill 
 2498      89003E11 
 2499 3570 58ECFFFF 		st	%s57,-5032(,%fp)	# spill 
 2499      89003911 
 2500 3578 50ECFFFF 		st	%s38,-5040(,%fp)	# spill 
 2500      89002611 
 2501 3580 48ECFFFF 		st	%s49,-5048(,%fp)	# spill 
 2501      89003111 
 2502 3588 40ECFFFF 		st	%s48,-5056(,%fp)	# spill 
 2502      89003011 
 2503 3590 38ECFFFF 		st	%s41,-5064(,%fp)	# spill 
 2503      89002911 
 2504 3598 30ECFFFF 		st	%s21,-5072(,%fp)	# spill 
 2504      89001511 
 2505 35a0 00000000 		or	%s56,0,%s49
 2505      B1003845 
 2506              	# line 1192
1192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 2507              		.loc	1 1192 0
 2508 35a8 00000000 		or	%s46,0,(0)1
 2508      00002E45 
 2509 35b0 00000000 		or	%s43,0,(0)1
 2509      00002B45 
 2510 35b8 00000000 		or	%s54,2,(0)1
 2510      00023645 
 2511 35c0 00000000 		or	%s53,3,(0)1
 2511      00033545 
 2512              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 2513              		.loc	1 1194 0
 2514 35c8 00000000 		adds.l	%s57,%s38,%s48
 2514      B0A63959 
 2515 35d0 00000000 		adds.l	%s41,%s38,%s41
 2515      A9A62959 
 2516 35d8 00000000 		adds.l	%s21,%s38,%s21
 2516      95A61559 
 2517 35e0 48EDFFFF 		st	%s41,-4792(,%fp)	# spill 
 2517      89002911 
 2518 35e8 30EDFFFF 		st	%s21,-4816(,%fp)	# spill 
 2518      89001511 
 2519 35f0 28ECFFFF 		ld	%s63,-5080(,%fp)	# restore 
 2519      89003F01 
 2520 35f8 00000000 		or	%s19,0,%s51
 2520      B3001345 
 2521 3600 00000000 		adds.l	%s63,%s38,%s63
 2521      BFA63F59 
 2522 3608 28EDFFFF 		st	%s63,-4824(,%fp)	# spill 
 2522      89003F11 
 2523 3610 20ECFFFF 		ld	%s61,-5088(,%fp)	# restore 
 2523      89003D01 
 2524 3618 18ECFFFF 		ld	%s59,-5096(,%fp)	# restore 
 2524      89003B01 
 2525 3620 10ECFFFF 		ld	%s44,-5104(,%fp)	# restore 
 2525      89002C01 
 2526 3628 08ECFFFF 		ld	%s18,-5112(,%fp)	# restore 
 2526      89001201 
 2527 3630 88EDFFFF 		ld	%s30,-4728(,%fp)	# restore 
 2527      89001E01 
 2528 3638 78FEFFFF 		br.l	.L4.90
 2528      00000F18 
 2529              	.L4.115:
 2530 3640 80FEFFFF 		brlt.l	0,%s63,.L4.114
 2530      BF000218 
 2531 3648 08F2FFFF 		br.l	.L4.87
 2531      00000F18 
 2532              	.L4.116:
 2533 3650 88EBFFFF 		st	%s45,-5240(,%fp)	# spill 
 2533      89002D11 
 2534 3658 90EBFFFF 		st	%s46,-5232(,%fp)	# spill 
 2534      89002E11 
 2535 3660 98EBFFFF 		st	%s48,-5224(,%fp)	# spill 
 2535      89003011 
 2536 3668 A0EBFFFF 		st	%s63,-5216(,%fp)	# spill 
 2536      89003F11 
 2537 3670 08ECFFFF 		st	%s18,-5112(,%fp)	# spill 
 2537      89001211 
 2538 3678 20ECFFFF 		st	%s61,-5088(,%fp)	# spill 
 2538      89003D11 
 2539 3680 98ECFFFF 		ld	%s63,-4968(,%fp)	# restore 
 2539      89003F01 
 2540 3688 00000000 		or	%s22,0,%s7
 2540      87001645 
 2541 3690 00000000 		or	%s56,0,%s25
 2541      99003845 
 2542 3698 00000000 		or	%s54,0,%s31
 2542      9F003645 
 2543 36a0 00000000 		or	%s4,0,%s42
 2543      AA000445 
 2544 36a8 00000000 		or	%s3,0,%s43
 2544      AB000345 
 2545 36b0 70EDFFFF 		ld	%s20,-4752(,%fp)	# restore 
 2545      89001401 
 2546 36b8 00000000 		or	%s48,0,%s55
 2546      B7003045 
 2547 36c0 78EDFFFF 		ld	%s31,-4744(,%fp)	# restore 
 2547      89001F01 
 2548 36c8 00000000 		or	%s50,0,%s47
 2548      AF003245 
 2549 36d0 00000000 		or	%s47,0,%s44
 2549      AC002F45 
 2550 36d8 90ECFFFF 		ld	%s18,-4976(,%fp)	# restore 
 2550      89001201 
 2551 36e0 48ECFFFF 		ld	%s49,-5048(,%fp)	# restore 
 2551      89003101 
 2552 36e8 88ECFFFF 		ld	%s59,-4984(,%fp)	# restore 
 2552      89003B01 
 2553 36f0 50ECFFFF 		ld	%s38,-5040(,%fp)	# restore 
 2553      89002601 
 2554 36f8 68ECFFFF 		ld	%s39,-5016(,%fp)	# restore 
 2554      89002701 
 2555 3700 58ECFFFF 		ld	%s57,-5032(,%fp)	# restore 
 2555      89003901 
 2556 3708 30ECFFFF 		ld	%s21,-5072(,%fp)	# restore 
 2556      89001501 
 2557 3710 30FFFFFF 		br.l	.L4.115
 2557      00000F18 
 2558              	.L4.117:
 2559              	# line 1183
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 2560              		.loc	1 1183 0
 2561 3718 00000000 		adds.l	%s56,4,%s56
 2561      B8043859 
 2562 3720 00000000 		adds.l	%s53,%s53,%s61
 2562      BDB53559 
 2563 3728 00000000 		adds.l	%s40,%s40,%s61
 2563      BDA82859 
 2564 3730 00000000 		adds.l	%s39,%s39,%s61
 2564      BDA72759 
 2565 3738 00000000 		adds.l	%s38,%s38,%s61
 2565      BDA62659 
 2566 3740 00000000 		adds.l	%s19,4,%s19
 2566      93041359 
 2567 3748 00000000 		adds.l	%s21,4,%s21
 2567      95041559 
 2568 3750 00000000 		adds.l	%s22,4,%s22
 2568      96041659 
 2569 3758 00000000 		adds.l	%s20,4,%s20
 2569      94041459 
 2570 3760 68030000 		brgt.l	0,%s56,.L4.118
 2570      B8000118 
 2571 3768 E8FEFFFF 		br.l	.L4.116
 2571      00000F18 
 2572              	.L4.119:
 2573 3770 00000000 		or	%s56,0,%s1
 2573      81003845 
 2574 3778 00000000 		or	%s53,0,%s3
 2574      83003545 
 2575 3780 00000000 		or	%s19,0,%s61
 2575      BD001345 
 2576 3788 00000000 		or	%s61,0,%s2
 2576      82003D45 
 2577 3790 00000000 		or	%s21,0,%s59
 2577      BB001545 
 2578 3798 00000000 		or	%s22,0,%s58
 2578      BA001645 
 2579 37a0 00000000 		or	%s23,0,%s4
 2579      84001745 
 2580 37a8 70FFFFFF 		br.l	.L4.117
 2580      00000F18 
 2581              	.L4.34:
 2582 37b0 38000000 		lea	%s57,56
 2582      00003906 
 2583              	# line 1185
1185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2584              		.loc	1 1185 0
 2585 37b8 00000000 		sll	%s60,%s60,%s57
 2585      BCB93C65 
 2586 37c0 38000000 		lea	%s57,56
 2586      00003906 
 2587 37c8 00000000 		sra.l	%s60,%s60,%s57
 2587      BCB93C77 
 2588 37d0 00000000 		st1b	%s60,0(%s54,%s50)	# bool
 2588      B2B63C15 
 2589              	# line 1184
1184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=khb[oh] && kw>=kwb[ow]) && (kh<khe[oh] && kw<kwe[ow]);
 2590              		.loc	1 1184 0
 2591 37d8 00000000 		adds.l	%s49,1,%s49
 2591      B1013159 
 2592 37e0 00000000 		adds.l	%s54,1,%s54
 2592      B6013659 
 2593 37e8 60020000 		brgt.l	0,%s49,.L4.120
 2593      B1000118 
 2594 37f0 80FFFFFF 		br.l	.L4.119
 2594      00000F18 
 2595              	.L4.121:
 2596              	# line 1185
1185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2597              		.loc	1 1185 0
 2598 37f8 00000000 		or	%s60,1,(0)1
 2598      00013C45 
 2599 3800 00000000 		or	%s58,0,%s22
 2599      96003A45 
 2600 3808 00000000 		or	%s59,0,%s21
 2600      95003B45 
 2601 3810 00000000 		or	%s61,0,%s19
 2601      93003D45 
 2602 3818 98FFFFFF 		br.l	.L4.34
 2602      00000F18 
 2603              	.L4.122:
 2604 3820 00000000 		ld	%s24,0(%s47,%s45)	# *(j$49)
 2604      ADAF1801 
 2605 3828 D0FFFFFF 		brlt.l	%s54,%s24,.L4.121
 2605      98B60218 
 2606 3830 40E1FFFF 		br.l	.L4.33
 2606      00000F18 
 2607              	.L4.123:
 2608 3838 00000000 		ld	%s24,0(%s62,%s46)	# *(j$48)
 2608      AEBE1801 
 2609 3840 E0FFFFFF 		brlt.l	%s22,%s24,.L4.122
 2609      98960218 
 2610 3848 28E1FFFF 		br.l	.L4.33
 2610      00000F18 
 2611              	.L4.124:
 2612 3850 00000000 		ld	%s24,0(%s47,%s48)	# *(j$47)
 2612      B0AF1801 
 2613 3858 E0FFFFFF 		brge.l	%s54,%s24,.L4.123
 2613      98B60518 
 2614 3860 10E1FFFF 		br.l	.L4.33
 2614      00000F18 
 2615              	.L4.32:
 2616 3868 38000000 		lea	%s57,56
 2616      00003906 
 2617 3870 00000000 		sll	%s60,%s60,%s57
 2617      BCB93C65 
 2618 3878 38000000 		lea	%s57,56
 2618      00003906 
 2619 3880 00000000 		sra.l	%s60,%s60,%s57
 2619      BCB93C77 
 2620 3888 00000000 		st1b	%s60,0(%s54,%s52)	# bool
 2620      B4B63C15 
 2621 3890 00000000 		ld	%s23,0(%s62,%s63)	# *(j$46)
 2621      BFBE1701 
 2622 3898 B8FFFFFF 		brge.l	%s22,%s23,.L4.124
 2622      97960518 
 2623 38a0 D0E0FFFF 		br.l	.L4.33
 2623      00000F18 
 2624              	.L4.125:
 2625 38a8 00000000 		or	%s60,1,(0)1
 2625      00013C45 
 2626 38b0 00000000 		or	%s22,0,%s58
 2626      BA001645 
 2627 38b8 B0FFFFFF 		br.l	.L4.32
 2627      00000F18 
 2628              	.L4.126:
 2629 38c0 00000000 		ld	%s24,0(%s47,%s45)	# *(j$49)
 2629      ADAF1801 
 2630 38c8 E0FFFFFF 		brlt.l	%s54,%s24,.L4.125
 2630      98B60218 
 2631 38d0 88E0FFFF 		br.l	.L4.31
 2631      00000F18 
 2632              	.L4.127:
 2633 38d8 00000000 		ld	%s24,0(%s62,%s46)	# *(j$48)
 2633      AEBE1801 
 2634 38e0 E0FFFFFF 		brlt.l	%s21,%s24,.L4.126
 2634      98950218 
 2635 38e8 70E0FFFF 		br.l	.L4.31
 2635      00000F18 
 2636              	.L4.128:
 2637 38f0 00000000 		ld	%s24,0(%s47,%s48)	# *(j$47)
 2637      B0AF1801 
 2638 38f8 E0FFFFFF 		brge.l	%s54,%s24,.L4.127
 2638      98B60518 
 2639 3900 58E0FFFF 		br.l	.L4.31
 2639      00000F18 
 2640              	.L4.30:
 2641 3908 38000000 		lea	%s57,56
 2641      00003906 
 2642 3910 00000000 		sll	%s60,%s60,%s57
 2642      BCB93C65 
 2643 3918 38000000 		lea	%s57,56
 2643      00003906 
 2644 3920 00000000 		sra.l	%s60,%s60,%s57
 2644      BCB93C77 
 2645 3928 00000000 		st1b	%s60,0(%s54,%s53)	# bool
 2645      B5B63C15 
 2646 3930 00000000 		ld	%s22,0(%s62,%s63)	# *(j$46)
 2646      BFBE1601 
 2647 3938 B8FFFFFF 		brge.l	%s21,%s22,.L4.128
 2647      96950518 
 2648 3940 18E0FFFF 		br.l	.L4.31
 2648      00000F18 
 2649              	.L4.129:
 2650 3948 00000000 		or	%s60,1,(0)1
 2650      00013C45 
 2651 3950 00000000 		or	%s21,0,%s59
 2651      BB001545 
 2652 3958 B0FFFFFF 		br.l	.L4.30
 2652      00000F18 
 2653              	.L4.130:
 2654 3960 00000000 		ld	%s24,0(%s47,%s45)	# *(j$49)
 2654      ADAF1801 
 2655 3968 E0FFFFFF 		brlt.l	%s54,%s24,.L4.129
 2655      98B60218 
 2656 3970 D0DFFFFF 		br.l	.L4.29
 2656      00000F18 
 2657              	.L4.131:
 2658 3978 00000000 		ld	%s24,0(%s62,%s46)	# *(j$48)
 2658      AEBE1801 
 2659 3980 E0FFFFFF 		brlt.l	%s19,%s24,.L4.130
 2659      98930218 
 2660 3988 B8DFFFFF 		br.l	.L4.29
 2660      00000F18 
 2661              	.L4.132:
 2662 3990 00000000 		ld	%s24,0(%s47,%s48)	# *(j$47)
 2662      B0AF1801 
 2663 3998 E0FFFFFF 		brge.l	%s54,%s24,.L4.131
 2663      98B60518 
 2664 39a0 A0DFFFFF 		br.l	.L4.29
 2664      00000F18 
 2665              	.L4.28:
 2666 39a8 38000000 		lea	%s57,56
 2666      00003906 
 2667 39b0 00000000 		sll	%s60,%s60,%s57
 2667      BCB93C65 
 2668 39b8 38000000 		lea	%s57,56
 2668      00003906 
 2669 39c0 00000000 		sra.l	%s60,%s60,%s57
 2669      BCB93C77 
 2670 39c8 00000000 		st1b	%s60,0(%s54,%s56)	# bool
 2670      B8B63C15 
 2671 39d0 00000000 		ld	%s21,0(%s62,%s63)	# *(j$46)
 2671      BFBE1501 
 2672 39d8 B8FFFFFF 		brge.l	%s19,%s21,.L4.132
 2672      95930518 
 2673 39e0 60DFFFFF 		br.l	.L4.29
 2673      00000F18 
 2674              	.L4.133:
 2675 39e8 00000000 		or	%s60,1,(0)1
 2675      00013C45 
 2676 39f0 00000000 		or	%s19,0,%s61
 2676      BD001345 
 2677 39f8 B0FFFFFF 		br.l	.L4.28
 2677      00000F18 
 2678              	.L4.134:
 2679 3a00 00000000 		ld	%s24,0(%s47,%s45)	# *(j$49)
 2679      ADAF1801 
 2680 3a08 E0FFFFFF 		brlt.l	%s54,%s24,.L4.133
 2680      98B60218 
 2681 3a10 18DFFFFF 		br.l	.L4.27
 2681      00000F18 
 2682              	.L4.135:
 2683 3a18 00000000 		ld	%s24,0(%s62,%s46)	# *(j$48)
 2683      AEBE1801 
 2684 3a20 E0FFFFFF 		brlt.l	%s20,%s24,.L4.134
 2684      98940218 
 2685 3a28 00DFFFFF 		br.l	.L4.27
 2685      00000F18 
 2686              	.L4.136:
 2687 3a30 00000000 		ld	%s24,0(%s47,%s48)	# *(j$47)
 2687      B0AF1801 
 2688 3a38 E0FFFFFF 		brge.l	%s54,%s24,.L4.135
 2688      98B60518 
 2689 3a40 E8DEFFFF 		br.l	.L4.27
 2689      00000F18 
 2690              	.L4.120:
 2691 3a48 00000000 		ld	%s19,0(%s62,%s63)	# *(j$46)
 2691      BFBE1301 
 2692 3a50 E0FFFFFF 		brge.l	%s20,%s19,.L4.136
 2692      93940518 
 2693 3a58 D0DEFFFF 		br.l	.L4.27
 2693      00000F18 
 2694              	.L4.137:
 2695 3a60 00000000 		or	%s58,0,%s22
 2695      96003A45 
 2696 3a68 00000000 		or	%s59,0,%s21
 2696      95003B45 
 2697 3a70 00000000 		or	%s1,0,%s56
 2697      B8000145 
 2698 3a78 00000000 		or	%s56,0,%s53
 2698      B5003845 
 2699 3a80 00000000 		or	%s2,0,%s61
 2699      BD000245 
 2700 3a88 00000000 		or	%s61,0,%s19
 2700      93003D45 
 2701 3a90 00000000 		or	%s3,0,%s53
 2701      B5000345 
 2702 3a98 00000000 		or	%s53,0,%s40
 2702      A8003545 
 2703 3aa0 00000000 		or	%s52,0,%s39
 2703      A7003445 
 2704 3aa8 00000000 		or	%s50,0,%s38
 2704      A6003245 
 2705 3ab0 00000000 		or	%s49,0,%s23
 2705      97003145 
 2706 3ab8 00000000 		or	%s4,0,%s23
 2706      97000445 
 2707 3ac0 88FFFFFF 		br.l	.L4.120
 2707      00000F18 
 2708              	.L4.118:
 2709              	# line 1184
1184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=khb[oh] && kw>=kwb[ow]) && (kh<khe[oh] && kw<kwe[ow]);
 2710              		.loc	1 1184 0
 2711 3ac8 00000000 		or	%s54,0,(0)1
 2711      00003645 
 2712 3ad0 90FFFFFF 		brlt.l	0,%s18,.L4.137
 2712      92000218 
 2713 3ad8 40FCFFFF 		br.l	.L4.117
 2713      00000F18 
 2714              	.L4.138:
 2715 3ae0 98ECFFFF 		st	%s63,-4968(,%fp)	# spill 
 2715      89003F11 
 2716 3ae8 90ECFFFF 		st	%s18,-4976(,%fp)	# spill 
 2716      89001211 
 2717 3af0 48ECFFFF 		st	%s49,-5048(,%fp)	# spill 
 2717      89003111 
 2718 3af8 88ECFFFF 		st	%s59,-4984(,%fp)	# spill 
 2718      89003B11 
 2719 3b00 50ECFFFF 		st	%s38,-5040(,%fp)	# spill 
 2719      89002611 
 2720 3b08 68ECFFFF 		st	%s39,-5016(,%fp)	# spill 
 2720      89002711 
 2721 3b10 58ECFFFF 		st	%s57,-5032(,%fp)	# spill 
 2721      89003911 
 2722 3b18 30ECFFFF 		st	%s21,-5072(,%fp)	# spill 
 2722      89001511 
 2723 3b20 78EDFFFF 		st	%s31,-4744(,%fp)	# spill 
 2723      89001F11 
 2724 3b28 70EDFFFF 		st	%s20,-4752(,%fp)	# spill 
 2724      89001411 
 2725 3b30 68EDFFFF 		ld	%s60,-4760(,%fp)	# restore 
 2725      89003C01 
 2726 3b38 00000000 		or	%s25,0,%s56
 2726      B8001945 
 2727 3b40 88EBFFFF 		ld	%s45,-5240(,%fp)	# restore 
 2727      89002D01 
 2728              	# line 1183
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 2729              		.loc	1 1183 0
 2730 3b48 00000000 		adds.l	%s56,%s20,%s60
 2730      BC943859 
 2731 3b50 08ECFFFF 		ld	%s18,-5112(,%fp)	# restore 
 2731      89001201 
 2732 3b58 00000000 		or	%s42,0,%s4
 2732      84002A45 
 2733 3b60 90EBFFFF 		ld	%s46,-5232(,%fp)	# restore 
 2733      89002E01 
 2734 3b68 00000000 		muls.l	%s60,%s20,%s18
 2734      92943C6E 
 2735 3b70 A0EBFFFF 		ld	%s63,-5216(,%fp)	# restore 
 2735      89003F01 
 2736 3b78 00000000 		or	%s43,0,%s3
 2736      83002B45 
 2737 3b80 00000000 		adds.l	%s53,%s60,%s31
 2737      9FBC3559 
 2738 3b88 60EDFFFF 		ld	%s59,-4768(,%fp)	# restore 
 2738      89003B01 
 2739 3b90 00000000 		or	%s31,0,%s54
 2739      B6001F45 
 2740 3b98 20ECFFFF 		ld	%s61,-5088(,%fp)	# restore 
 2740      89003D01 
 2741 3ba0 00000000 		adds.l	%s40,%s60,%s59
 2741      BBBC2859 
 2742 3ba8 50EDFFFF 		ld	%s59,-4784(,%fp)	# restore 
 2742      89003B01 
 2743 3bb0 00000000 		or	%s44,0,%s47
 2743      AF002C45 
 2744 3bb8 00000000 		or	%s47,0,%s50
 2744      B2002F45 
 2745 3bc0 00000000 		adds.l	%s39,%s60,%s59
 2745      BBBC2759 
 2746 3bc8 38EDFFFF 		ld	%s59,-4808(,%fp)	# restore 
 2746      89003B01 
 2747 3bd0 00000000 		or	%s55,0,%s48
 2747      B0003745 
 2748 3bd8 98EBFFFF 		ld	%s48,-5224(,%fp)	# restore 
 2748      89003001 
 2749 3be0 00000000 		adds.l	%s38,%s60,%s59
 2749      BBBC2659 
 2750 3be8 00000000 		adds.l	%s19,1,%s20
 2750      94011359 
 2751 3bf0 00000000 		adds.l	%s21,2,%s20
 2751      94021559 
 2752 3bf8 00000000 		adds.l	%s60,3,%s20
 2752      94033C59 
 2753 3c00 00000000 		or	%s20,0,%s7
 2753      87001445 
 2754 3c08 00000000 		or	%s7,0,%s22
 2754      96000745 
 2755 3c10 00000000 		or	%s22,0,%s60
 2755      BC001645 
 2756 3c18 B0FEFFFF 		br.l	.L4.118
 2756      00000F18 
 2757              	.L4.139:
 2758 3c20 00000000 		or	%s7,0,%s20
 2758      94000745 
 2759 3c28 B8FEFFFF 		brlt.l	%s20,%s51,.L4.138
 2759      B3940218 
 2760 3c30 10FAFFFF 		br.l	.L4.115
 2760      00000F18 
 2761              	.L4.140:
 2762 3c38 88EBFFFF 		st	%s48,-5240(,%fp)	# spill 
 2762      89003011 
 2763 3c40 90EBFFFF 		st	%s49,-5232(,%fp)	# spill 
 2763      89003111 
 2764 3c48 98EBFFFF 		st	%s52,-5224(,%fp)	# spill 
 2764      89003411 
 2765 3c50 A0EBFFFF 		st	%s63,-5216(,%fp)	# spill 
 2765      89003F11 
 2766 3c58 08ECFFFF 		st	%s18,-5112(,%fp)	# spill 
 2766      89001211 
 2767 3c60 00000000 		or	%s20,0,%s25
 2767      99001445 
 2768 3c68 00000000 		or	%s56,0,%s7
 2768      87003845 
 2769 3c70 00000000 		or	%s54,0,%s24
 2769      98003645 
 2770 3c78 00000000 		or	%s48,0,%s31
 2770      9F003045 
 2771 3c80 00000000 		or	%s63,0,%s32
 2771      A0003F45 
 2772 3c88 00000000 		or	%s31,0,%s43
 2772      AB001F45 
 2773 3c90 00000000 		or	%s18,0,%s45
 2773      AD001245 
 2774 3c98 00000000 		or	%s49,0,%s40
 2774      A8003145 
 2775 3ca0 00000000 		or	%s32,0,%s44
 2775      AC002045 
 2776 3ca8 00000000 		or	%s57,0,%s42
 2776      AA003945 
 2777 3cb0 70FFFFFF 		br.l	.L4.139
 2777      00000F18 
 2778              	.L4.141:
 2779 3cb8 00000000 		adds.l	%s56,1,%s56
 2779      B8013859 
 2780 3cc0 00000000 		adds.l	%s53,%s18,%s53
 2780      B5923559 
 2781 3cc8 00000000 		adds.l	%s20,1,%s20
 2781      94011459 
 2782 3cd0 08010000 		brgt.l	0,%s56,.L4.142
 2782      B8000118 
 2783 3cd8 60FFFFFF 		br.l	.L4.140
 2783      00000F18 
 2784              	.L4.143:
 2785 3ce0 00000000 		or	%s56,0,%s1
 2785      81003845 
 2786 3ce8 00000000 		or	%s53,0,%s2
 2786      82003545 
 2787 3cf0 C8FFFFFF 		br.l	.L4.141
 2787      00000F18 
 2788              	.L4.26:
 2789 3cf8 38000000 		lea	%s57,56
 2789      00003906 
 2790              	# line 1185
1185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2791              		.loc	1 1185 0
 2792 3d00 00000000 		sll	%s60,%s60,%s57
 2792      BCB93C65 
 2793 3d08 38000000 		lea	%s57,56
 2793      00003906 
 2794 3d10 00000000 		sra.l	%s60,%s60,%s57
 2794      BCB93C77 
 2795 3d18 00000000 		st1b	%s60,0(%s54,%s56)	# bool
 2795      B8B63C15 
 2796              	# line 1184
1184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=khb[oh] && kw>=kwb[ow]) && (kh<khe[oh] && kw<kwe[ow]);
 2797              		.loc	1 1184 0
 2798 3d20 00000000 		adds.l	%s53,1,%s53
 2798      B5013559 
 2799 3d28 00000000 		adds.l	%s54,1,%s54
 2799      B6013659 
 2800 3d30 68000000 		brgt.l	0,%s53,.L4.144
 2800      B5000118 
 2801 3d38 A8FFFFFF 		br.l	.L4.143
 2801      00000F18 
 2802              	.L4.145:
 2803              	# line 1185
1185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 2804              		.loc	1 1185 0
 2805 3d40 00000000 		or	%s60,1,(0)1
 2805      00013C45 
 2806 3d48 B0FFFFFF 		br.l	.L4.26
 2806      00000F18 
 2807              	.L4.146:
 2808 3d50 00000000 		ld	%s19,0(%s50,%s48)	# *(j$49)
 2808      B0B21301 
 2809 3d58 E8FFFFFF 		brlt.l	%s54,%s19,.L4.145
 2809      93B60218 
 2810 3d60 B8DBFFFF 		br.l	.L4.25
 2810      00000F18 
 2811              	.L4.147:
 2812 3d68 00000000 		ld	%s19,0(%s62,%s49)	# *(j$48)
 2812      B1BE1301 
 2813 3d70 E0FFFFFF 		brlt.l	%s20,%s19,.L4.146
 2813      93940218 
 2814 3d78 A0DBFFFF 		br.l	.L4.25
 2814      00000F18 
 2815              	.L4.148:
 2816 3d80 00000000 		ld	%s19,0(%s50,%s52)	# *(j$47)
 2816      B4B21301 
 2817 3d88 E0FFFFFF 		brge.l	%s54,%s19,.L4.147
 2817      93B60518 
 2818 3d90 88DBFFFF 		br.l	.L4.25
 2818      00000F18 
 2819              	.L4.144:
 2820 3d98 00000000 		ld	%s19,0(%s62,%s63)	# *(j$46)
 2820      BFBE1301 
 2821 3da0 E0FFFFFF 		brge.l	%s20,%s19,.L4.148
 2821      93940518 
 2822 3da8 70DBFFFF 		br.l	.L4.25
 2822      00000F18 
 2823              	.L4.149:
 2824 3db0 00000000 		or	%s1,0,%s56
 2824      B8000145 
 2825 3db8 00000000 		or	%s56,0,%s53
 2825      B5003845 
 2826 3dc0 00000000 		or	%s2,0,%s53
 2826      B5000245 
 2827 3dc8 00000000 		or	%s53,0,%s23
 2827      97003545 
 2828 3dd0 C8FFFFFF 		br.l	.L4.144
 2828      00000F18 
 2829              	.L4.142:
 2830              	# line 1184
1184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=khb[oh] && kw>=kwb[ow]) && (kh<khe[oh] && kw<kwe[ow]);
 2831              		.loc	1 1184 0
 2832 3dd8 00000000 		or	%s54,0,(0)1
 2832      00003645 
 2833 3de0 D0FFFFFF 		brlt.l	0,%s18,.L4.149
 2833      92000218 
 2834 3de8 D0FEFFFF 		br.l	.L4.141
 2834      00000F18 
 2835              	.L4.150:
 2836 3df0 00000000 		or	%s61,0,%s56
 2836      B8003D45 
 2837 3df8 00000000 		or	%s56,0,%s32
 2837      A0003845 
 2838 3e00 00000000 		or	%s53,0,%s31
 2838      9F003545 
 2839 3e08 00000000 		or	%s24,0,%s54
 2839      B6001845 
 2840 3e10 00000000 		or	%s25,0,%s20
 2840      94001945 
 2841 3e18 00000000 		or	%s20,0,%s7
 2841      87001445 
 2842 3e20 00000000 		or	%s7,0,%s61
 2842      BD000745 
 2843 3e28 00000000 		or	%s45,0,%s18
 2843      92002D45 
 2844 3e30 08ECFFFF 		ld	%s18,-5112(,%fp)	# restore 
 2844      89001201 
 2845 3e38 00000000 		or	%s40,0,%s49
 2845      B1002845 
 2846 3e40 00000000 		or	%s42,0,%s57
 2846      B9002A45 
 2847 3e48 00000000 		or	%s43,0,%s31
 2847      9F002B45 
 2848 3e50 00000000 		or	%s31,0,%s48
 2848      B0001F45 
 2849 3e58 00000000 		or	%s44,0,%s32
 2849      A0002C45 
 2850 3e60 00000000 		or	%s32,0,%s63
 2850      BF002045 
 2851 3e68 A0EBFFFF 		ld	%s63,-5216(,%fp)	# restore 
 2851      89003F01 
 2852 3e70 98EBFFFF 		ld	%s52,-5224(,%fp)	# restore 
 2852      89003401 
 2853 3e78 90EBFFFF 		ld	%s49,-5232(,%fp)	# restore 
 2853      89003101 
 2854 3e80 88EBFFFF 		ld	%s48,-5240(,%fp)	# restore 
 2854      89003001 
 2855 3e88 50FFFFFF 		br.l	.L4.142
 2855      00000F18 
 2856              	.L4.151:
 2857              	# line 1183
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 2858              		.loc	1 1183 0
 2859 3e90 00000000 		or	%s7,0,(0)1
 2859      00000745 
 2860 3e98 58FFFFFF 		brlt.l	0,%s20,.L4.150
 2860      94000218 
 2861 3ea0 80FDFFFF 		br.l	.L4.139
 2861      00000F18 
 2862              	.L4.152:
 2863 3ea8 00000000 		or	%s26,0,%s0
 2863      80001A45 
 2864 3eb0 E0FFFFFF 		brlt.l	0,%s51,.L4.151
 2864      B3000218 
 2865 3eb8 88F7FFFF 		br.l	.L4.115
 2865      00000F18 
 2866              	.L4.153:
 2867              	# line 1173
1173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[1] = khe[oh];
 2868              		.loc	1 1173 0
 2869 3ec0 00000000 		ld	%s7,0(%s62,%s56)	# *(khb)
 2869      B8BE0701 
 2870 3ec8 D8FFFFFF 		st	%s7,-40(,%fp)	# khkw_begend
 2870      89000711 
 2871              	# line 1174
1174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[2] = kwb[ow];
 2872              		.loc	1 1174 0
 2873 3ed0 00000000 		ld	%s2,0(%s62,%s54)	# *(khe)
 2873      B6BE0201 
 2874 3ed8 E0FFFFFF 		st	%s2,-32(,%fp)	# khkw_begend
 2874      89000211 
 2875              	# line 1175
1175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khkw_begend[3] = kwe[ow];
 2876              		.loc	1 1175 0
 2877 3ee0 00000000 		ld	%s1,0(%s50,%s28)	# *(kwb)
 2877      9CB20101 
 2878 3ee8 E8FFFFFF 		st	%s1,-24(,%fp)	# khkw_begend
 2878      89000111 
 2879              	# line 1176
1176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               khash = 0;
 2880              		.loc	1 1176 0
 2881 3ef0 00000000 		ld	%s0,0(%s50,%s27)	# *(kwe)
 2881      9BB20001 
 2882 3ef8 F0FFFFFF 		st	%s0,-16(,%fp)	# khkw_begend
 2882      89000011 
 2883              	# line 1180
1180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
 2884              		.loc	1 1180 0
 2885 3f00 00000000 		muls.l	%s7,%s7,%s6
 2885      8687076E 
 2886 3f08 00000000 		muls.l	%s2,%s2,%s5
 2886      8582026E 
 2887 3f10 00000000 		adds.l	%s2,%s7,%s2
 2887      82870259 
 2888 3f18 00000000 		muls.l	%s1,%s1,%s4
 2888      8481016E 
 2889 3f20 00000000 		adds.l	%s1,%s2,%s1
 2889      81820159 
 2890 3f28 00000000 		muls.l	%s0,%s0,%s3
 2890      8380006E 
 2891 3f30 00000000 		adds.l	%s0,%s1,%s0
 2891      80810059 
 2892 3f38 70FFFFFF 		brne.l	%s0,%s26,.L4.152
 2892      9A800318 
 2893 3f40 00F7FFFF 		br.l	.L4.115
 2893      00000F18 
 2894              	.L4.24:
 2895 3f48 38000000 		lea	%s40,56
 2895      00002806 
 2896              	# line 1168
1168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 2897              		.loc	1 1168 0
 2898 3f50 00000000 		sll	%s53,%s53,%s40
 2898      B5A83565 
 2899 3f58 38000000 		lea	%s40,56
 2899      00002806 
 2900 3f60 00000000 		sra.l	%s53,%s53,%s40
 2900      B5A83577 
 2901 3f68 00000000 		or	%s53,0,%s53
 2901      B5003545 
 2902 3f70 50FFFFFF 		brne.w	0,%s53,.L4.153
 2902      B5008318 
 2903 3f78 88E0FFFF 		br.l	.L4.67
 2903      00000F18 
 2904              	.L4.154:
 2905 3f80 00000000 		or	%s53,1,(0)1
 2905      00013545 
 2906 3f88 C0FFFFFF 		br.l	.L4.24
 2906      00000F18 
 2907              	.L4.155:
 2908 3f90 00000000 		ld	%s24,0(%s50,%s28)	# *(kwb)
 2908      9CB21801 
 2909 3f98 00000000 		ld	%s25,0(%s50,%s27)	# *(kwe)
 2909      9BB21901 
 2910 3fa0 E0FFFFFF 		brlt.l	%s24,%s25,.L4.154
 2910      99980218 
 2911 3fa8 60D9FFFF 		br.l	.L4.23
 2911      00000F18 
 2912              	.L4.18:
 2913 3fb0 00000000 		ld	%s24,0(%s62,%s56)	# *(khb)
 2913      B8BE1801 
 2914 3fb8 00000000 		ld	%s25,0(%s62,%s54)	# *(khe)
 2914      B6BE1901 
 2915 3fc0 D0FFFFFF 		brlt.l	%s24,%s25,.L4.155
 2915      99980218 
 2916 3fc8 40D9FFFF 		br.l	.L4.23
 2916      00000F18 
 2917              	.L4.156:
 2918 3fd0 00000000 		or	%s54,0,%s61
 2918      BD003645 
 2919 3fd8 00000000 		or	%s56,0,%s60
 2919      BC003845 
 2920 3fe0 D0FFFFFF 		br.l	.L4.18
 2920      00000F18 
 2921              	.L4.22:
 2922              	# line 1157
1157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }else{
 2923              		.loc	1 1157 0
 2924 3fe8 00000000 		or	%s56,0,(0)1
 2924      00003845 
 2925 3ff0 00000000 		lvl	%s54
 2925      00B600BF 
 2926 3ff8 00000022 		vbrdu	%v34,%s56
 2926      00B8808C 
 2927 4000 00000000 		or	%s56,0,%s53
 2927      B5003845 
 2928 4008 00000022 		vstu.nc	%v34,4,%s56
 2928      B8040092 
 2929              	# line 1156
1156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
 2930              		.loc	1 1156 0
 2931 4010 00000000 		adds.l	%s53,%s53,%s46
 2931      AEB53559 
 2932 4018 00000000 		subs.l	%s44,%s44,%s54
 2932      B6AC2C5B 
 2933 4020 B0FFFFFF 		brge.l	0,%s44,.L4.156
 2933      AC000518 
 2934 4028 D0D8FFFF 		br.l	.L4.21
 2934      00000F18 
 2935              	.L4.157:
 2936 4030 00000000 		subs.l	%s58,0,%s59
 2936      BB003A5B 
 2937 4038 00000000 		smvl	%s55
 2937      0000372E 
 2938 4040 80000000 		mins.l	%s55,%s58,%s55
 2938      B7BA3768 
 2939 4048 00000000 		or	%s44,0,%s58
 2939      BA002C45 
 2940 4050 00000000 		or	%s60,0,%s56
 2940      B8003C45 
 2941 4058 00000000 		or	%s61,0,%s54
 2941      B6003D45 
 2942 4060 00000000 		or	%s34,0,%s53
 2942      B5002245 
 2943 4068 00000000 		or	%s53,0,%s47
 2943      AF003545 
 2944 4070 00000000 		muls.l	%s46,4,%s55
 2944      B7042E6E 
 2945 4078 00000000 		or	%s35,0,%s40
 2945      A8002345 
 2946 4080 00000000 		or	%s54,0,%s55
 2946      B7003645 
 2947 4088 60FFFFFF 		br.l	.L4.22
 2947      00000F18 
 2948              	.L4.158:
 2949 4090 A0FFFFFF 		brlt.l	0,%s30,.L4.157
 2949      9E000218 
 2950 4098 00000000 		or	%s34,0,%s53
 2950      B5002245 
 2951 40a0 00000000 		or	%s35,0,%s40
 2951      A8002345 
 2952 40a8 08FFFFFF 		br.l	.L4.18
 2952      00000F18 
 2953              	.L4.58:
 2954 40b0 E0FFFFFF 		breq.w	0,%s22,.L4.158
 2954      96008418 
 2955 40b8 20D8FFFF 		br.l	.L4.20
 2955      00000F18 
 2956              	.L4.159:
 2957 40c0 80EBFFFF 		st	%s25,-5248(,%fp)	# spill 
 2957      89001911 
 2958 40c8 78EBFFFF 		st	%s50,-5256(,%fp)	# spill 
 2958      89003211 
 2959 40d0 70EBFFFF 		st	%s40,-5264(,%fp)	# spill 
 2959      89002811 
 2960 40d8 68EBFFFF 		st	%s37,-5272(,%fp)	# spill 
 2960      89002511 
 2961 40e0 60EBFFFF 		st	%s35,-5280(,%fp)	# spill 
 2961      89002311 
 2962 40e8 58EBFFFF 		st	%s38,-5288(,%fp)	# spill 
 2962      89002611 
 2963 40f0 50EBFFFF 		st	%s61,-5296(,%fp)	# spill 
 2963      89003D11 
 2964 40f8 48EBFFFF 		st	%s60,-5304(,%fp)	# spill 
 2964      89003C11 
 2965 4100 00000000 		or	%s40,0,%s61
 2965      BD002845 
 2966              	# line 1153
1153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 2967              		.loc	1 1153 0
 2968 4108 00000000 		adds.l	%s60,%s38,%s60
 2968      BCA63C59 
 2969 4110 00000000 		or	%s38,0,%s60
 2969      BC002645 
 2970 4118 00000000 		or	%s50,0,(0)1
 2970      00003245 
 2971 4120 00000000 		or	%s37,0,%s35
 2971      A3002545 
 2972 4128 88FFFFFF 		br.l	.L4.58
 2972      00000F18 
 2973              	.L4.54:
 2974 4130 90FFFFFF 		brlt.l	0,%s25,.L4.159
 2974      99000218 
 2975 4138 68DBFFFF 		br.l	.L4.55
 2975      00000F18 
 2976              	.L4.160:
 2977 4140 40EBFFFF 		st	%s50,-5312(,%fp)	# spill 
 2977      89003211 
 2978 4148 38EBFFFF 		st	%s38,-5320(,%fp)	# spill 
 2978      89002611 
 2979 4150 30EBFFFF 		st	%s35,-5328(,%fp)	# spill 
 2979      89002311 
 2980 4158 28EBFFFF 		st	%s7,-5336(,%fp)	# spill 
 2980      89000711 
 2981 4160 20EBFFFF 		st	%s2,-5344(,%fp)	# spill 
 2981      89000211 
 2982 4168 18EBFFFF 		st	%s34,-5352(,%fp)	# spill 
 2982      89002211 
 2983 4170 10EBFFFF 		st	%s58,-5360(,%fp)	# spill 
 2983      89003A11 
 2984 4178 08EBFFFF 		st	%s55,-5368(,%fp)	# spill 
 2984      89003711 
 2985 4180 00EBFFFF 		st	%s52,-5376(,%fp)	# spill 
 2985      89003411 
 2986 4188 00000000 		or	%s50,0,%s58
 2986      BA003245 
 2987              	# line 1152
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 2988              		.loc	1 1152 0
 2989 4190 00000000 		muls.l	%s34,%s34,%s29
 2989      9DA2226E 
 2990 4198 00000000 		adds.l	%s55,%s34,%s55
 2990      B7A23759 
 2991 41a0 00000000 		or	%s38,0,%s55
 2991      B7002645 
 2992 41a8 00000000 		or	%s62,0,(0)1
 2992      00003E45 
 2993 41b0 00000000 		muls.l	%s2,%s2,%s37
 2993      A582026E 
 2994 41b8 00000000 		adds.l	%s52,%s2,%s52
 2994      B4823459 
 2995 41c0 00000000 		or	%s35,0,%s52
 2995      B4002345 
 2996 41c8 68FFFFFF 		br.l	.L4.54
 2996      00000F18 
 2997              	.L4.51:
 2998 41d0 70FFFFFF 		brlt.l	0,%s50,.L4.160
 2998      B2000218 
 2999 41d8 48DAFFFF 		br.l	.L4.50
 2999      00000F18 
 3000              	.L4.161:
 3001 41e0 F8EAFFFF 		st	%s62,-5384(,%fp)	# spill 
 3001      89003E11 
 3002 41e8 F0EBFFFF 		st	%s60,-5136(,%fp)	# spill 
 3002      89003C11 
 3003 41f0 F0EAFFFF 		st	%s38,-5392(,%fp)	# spill 
 3003      89002611 
 3004 41f8 E8EAFFFF 		st	%s34,-5400(,%fp)	# spill 
 3004      89002211 
 3005 4200 E0EAFFFF 		st	%s2,-5408(,%fp)	# spill 
 3005      89000211 
 3006 4208 D8EAFFFF 		st	%s63,-5416(,%fp)	# spill 
 3006      89003F11 
 3007 4210 D0EAFFFF 		st	%s59,-5424(,%fp)	# spill 
 3007      89003B11 
 3008 4218 C8EAFFFF 		st	%s1,-5432(,%fp)	# spill 
 3008      89000111 
 3009 4220 C0EAFFFF 		st	%s58,-5440(,%fp)	# spill 
 3009      89003A11 
 3010 4228 B8EAFFFF 		st	%s61,-5448(,%fp)	# spill 
 3010      89003D11 
 3011 4230 B0EAFFFF 		st	%s46,-5456(,%fp)	# spill 
 3011      89002E11 
 3012 4238 A8EAFFFF 		st	%s45,-5464(,%fp)	# spill 
 3012      89002D11 
 3013 4240 A0EAFFFF 		st	%s44,-5472(,%fp)	# spill 
 3013      89002C11 
 3014 4248 98EAFFFF 		st	%s43,-5480(,%fp)	# spill 
 3014      89002B11 
 3015 4250 00000000 		or	%s38,0,%s46
 3015      AE002645 
 3016 4258 00000000 		or	%s34,0,%s61
 3016      BD002245 
 3017 4260 00000000 		or	%s2,0,%s58
 3017      BA000245 
 3018              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 3019              		.loc	1 1202 0
 3020 4268 00000000 		adds.l	%s45,%s1,%s45
 3020      AD812D59 
 3021 4270 00000000 		adds.l	%s44,%s1,%s44
 3021      AC812C59 
 3022 4278 C8EBFFFF 		st	%s45,-5176(,%fp)	# spill 
 3022      89002D11 
 3023 4280 C0EBFFFF 		st	%s44,-5184(,%fp)	# spill 
 3023      89002C11 
 3024 4288 00000000 		adds.l	%s62,%s1,%s43
 3024      AB813E59 
 3025 4290 B8EBFFFF 		st	%s62,-5192(,%fp)	# spill 
 3025      89003E11 
 3026 4298 00000000 		or	%s58,0,%s42
 3026      AA003A45 
 3027 42a0 00000000 		or	%s60,0,%s24
 3027      98003C45 
 3028 42a8 00000000 		or	%s61,0,%s19
 3028      93003D45 
 3029 42b0 88ECFFFF 		ld	%s59,-4984(,%fp)	# restore 
 3029      89003B01 
 3030 42b8 98ECFFFF 		ld	%s63,-4968(,%fp)	# restore 
 3030      89003F01 
 3031 42c0 10FFFFFF 		br.l	.L4.51
 3031      00000F18 
 3032              	.L4.47:
 3033 42c8 18FFFFFF 		brlt.l	0,%s62,.L4.161
 3033      BE000218 
 3034 42d0 70D8FFFF 		br.l	.L4.48
 3034      00000F18 
 3035              	.L4.162:
 3036 42d8 D8EBFFFF 		st	%s21,-5160(,%fp)	# spill 
 3036      89001511 
 3037 42e0 08ECFFFF 		st	%s18,-5112(,%fp)	# spill 
 3037      89001211 
 3038              	# line 1155
1155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oc = 0; oc < OCOG; ++oc)
 3039              		.loc	1 1155 0
 3040 42e8 48000000 		dldl.zx	%s0,72(,%s31)	# *(p).dir
 3040      9F00800B 
 3041 42f0 00000000 		or	%s48,0,%s20
 3041      94003045 
 3042 42f8 00000000 		or	%s51,0,%s19
 3042      93003345 
 3043 4300 00000000 		adds.w.sx	%s0,0,%s0
 3043      8000004A 
 3044 4308 04000000 		lea	%s63,4
 3044      00003F06 
 3045 4310 00000000 		and	%s0,%s0,%s63
 3045      BF800044 
 3046              	# line 1168
1168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 3047              		.loc	1 1168 0
 3048 4318 90FFFFFF 		dld	%s56,-112(,%fp)	# khb
 3048      89003809 
 3049 4320 00000000 		or	%s63,0,%s56
 3049      B8003F45 
 3050 4328 A0EBFFFF 		st	%s63,-5216(,%fp)	# spill 
 3050      89003F11 
 3051 4330 A0FFFFFF 		dld	%s54,-96(,%fp)	# khe
 3051      89003609 
 3052 4338 00000000 		or	%s63,0,%s54
 3052      B6003F45 
 3053 4340 90EBFFFF 		st	%s63,-5232(,%fp)	# spill 
 3053      89003F11 
 3054              	# line 1156
1156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = 0.f;
 3055              		.loc	1 1156 0
 3056 4348 D0FDFFFF 		dld	%s47,-560(,%fp)	# tmp
 3056      89002F09 
 3057              	# line 1168
1168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (khw_ok)
 3058              		.loc	1 1168 0
 3059 4350 98FFFFFF 		dld	%s28,-104(,%fp)	# kwb
 3059      89001C09 
 3060 4358 00000000 		or	%s63,0,%s28
 3060      9C003F45 
 3061 4360 98EBFFFF 		st	%s63,-5224(,%fp)	# spill 
 3061      89003F11 
 3062 4368 A8FFFFFF 		dld	%s27,-88(,%fp)	# kwe
 3062      89001B09 
 3063 4370 00000000 		or	%s63,0,%s27
 3063      9B003F45 
 3064 4378 88EBFFFF 		st	%s63,-5240(,%fp)	# spill 
 3064      89003F11 
 3065              	# line 1209
1209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (size_t oc = 0; oc < OCOG; ++oc)
 3066              		.loc	1 1209 0
 3067 4380 5C000000 		dldl.zx	%s63,92(,%s31)	# *(p).merge
 3067      9F00BF0B 
 3068 4388 00000000 		adds.w.sx	%s36,0,%s63
 3068      BF00244A 
 3069              	# line 1150
1150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 3070              		.loc	1 1150 0
 3071 4390 00000000 		or	%s1,0,(0)1
 3071      00000145 
 3072 4398 00000000 		or	%s61,0,(0)1
 3072      00003D45 
 3073 43a0 00000000 		or	%s58,0,(0)1
 3073      00003A45 
 3074              	# line 1180
1180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
 3075              		.loc	1 1180 0
 3076 43a8 C0FFFFFF 		dld	%s5,-64(,%fp)	# khkw_muls
 3076      89000509 
 3077 43b0 C8FFFFFF 		dld	%s4,-56(,%fp)	# khkw_muls
 3077      89000409 
 3078              	# line 1183
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3079              		.loc	1 1183 0
 3080 43b8 00000000 		and	%s63,%s19,(62)0
 3080      7E933F44 
 3081 43c0 00000000 		adds.w.sx	%s62,0,%s63
 3081      BF003E4A 
 3082 43c8 00000000 		or	%s63,0,%s62
 3082      BE003F45 
 3083 43d0 00000000 		subs.l	%s62,0,%s63
 3083      BF003E5B 
 3084 43d8 00000000 		subs.l	%s60,0,%s19
 3084      93003C5B 
 3085 43e0 B0FFFFFF 		dld	%s31,-80(,%fp)	# kok
 3085      89001F09 
 3086 43e8 68EDFFFF 		st	%s60,-4760(,%fp)	# spill 
 3086      89003C11 
 3087              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3088              		.loc	1 1194 0
 3089 43f0 50FFFFFF 		dld	%s60,-176(,%fp)	# src
 3089      89003C09 
 3090              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 3091              		.loc	1 1202 0
 3092 43f8 00000000 		and	%s59,%s30,(62)0
 3092      7E9E3B44 
 3093 4400 88EDFFFF 		st	%s60,-4728(,%fp)	# spill 
 3093      89003C11 
 3094 4408 00000000 		adds.w.sx	%s57,0,%s59
 3094      BB00394A 
 3095 4410 00000000 		or	%s59,0,%s57
 3095      B9003B45 
 3096 4418 00ECFFFF 		st	%s59,-5120(,%fp)	# spill 
 3096      89003B11 
 3097 4420 00000000 		subs.l	%s57,0,%s59
 3097      BB00395B 
 3098 4428 00000000 		or	%s53,0,%s30
 3098      9E003545 
 3099 4430 F8EBFFFF 		st	%s57,-5128(,%fp)	# spill 
 3099      89003911 
 3100              	# line 1160
1160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 tmp[oc] = pbia[bia_off0 + oc];
 3101              		.loc	1 1160 0
 3102 4438 00000000 		subs.l	%s59,0,%s30
 3102      9E003B5B 
 3103 4440 98ECFFFF 		ld	%s57,-4968(,%fp)	# restore 
 3103      89003901 
 3104 4448 88ECFFFF 		st	%s59,-4984(,%fp)	# spill 
 3104      89003B11 
 3105              	# line 1204
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 3106              		.loc	1 1204 0
 3107 4450 00000000 		muls.l	%s59,%s19,%s57
 3107      B9933B6E 
 3108              	# line 1192
1192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 3109              		.loc	1 1192 0
 3110 4458 00000000 		subs.l	%s49,0,%s57
 3110      B900315B 
 3111              	# line 1204
1204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
 3112              		.loc	1 1204 0
 3113 4460 00000000 		muls.l	%s55,%s59,%s18
 3113      92BB376E 
 3114              	# line 1183
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3115              		.loc	1 1183 0
 3116 4468 00000000 		adds.l	%s59,%s31,%s18
 3116      929F3B59 
 3117 4470 00000000 		muls.l	%s46,2,%s18
 3117      92022E6E 
 3118 4478 60EDFFFF 		st	%s59,-4768(,%fp)	# spill 
 3118      89003B11 
 3119 4480 00000000 		adds.l	%s59,%s31,%s46
 3119      AE9F3B59 
 3120 4488 00000000 		muls.l	%s46,3,%s18
 3120      92032E6E 
 3121 4490 50EDFFFF 		st	%s59,-4784(,%fp)	# spill 
 3121      89003B11 
 3122 4498 00000000 		adds.l	%s59,%s31,%s46
 3122      AE9F3B59 
 3123              	# line 1184
1184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     kok[kh][kw] = (kh>=khb[oh] && kw>=kwb[ow]) && (kh<khe[oh] && kw<kwe[ow]);
 3124              		.loc	1 1184 0
 3125 44a0 00000000 		subs.l	%s46,0,%s18
 3125      92002E5B 
 3126 44a8 38EDFFFF 		st	%s59,-4808(,%fp)	# spill 
 3126      89003B11 
 3127              	# line 1192
1192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 3128              		.loc	1 1192 0
 3129 44b0 00000000 		muls.l	%s59,%s19,%s18
 3129      92933B6E 
 3130              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 3131              		.loc	1 1202 0
 3132 44b8 00000000 		muls.l	%s45,%s57,%s59
 3132      BBB92D6E 
 3133 44c0 00000000 		muls.l	%s59,8,%s45
 3133      AD083B6E 
 3134 44c8 00000000 		or	%s44,0,%s32
 3134      A0002C45 
 3135 44d0 00000000 		or	%s43,0,%s44
 3135      AC002B45 
 3136              	# line 1150
1150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 3137              		.loc	1 1150 0
 3138 44d8 00000000 		subs.l	%s44,0,%s22
 3138      96002C5B 
 3139 44e0 00000000 		or	%s22,0,%s0
 3139      80001645 
 3140 44e8 00000000 		or	%s38,0,%s44
 3140      AC002645 
 3141 44f0 00000000 		muls.l	%s34,4,%s30
 3141      9E04226E 
 3142 44f8 00000000 		or	%s32,0,%s62
 3142      BE002045 
 3143 4500 00000000 		muls.l	%s2,%s55,%s34
 3143      A2B7026E 
 3144              	# line 1183
1183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3145              		.loc	1 1183 0
 3146 4508 00000000 		muls.l	%s0,4,%s18
 3146      9204006E 
 3147 4510 20ECFFFF 		st	%s0,-5088(,%fp)	# spill 
 3147      89000011 
 3148              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3149              		.loc	1 1194 0
 3150 4518 00000000 		muls.l	%s62,4,%s0
 3150      80043E6E 
 3151 4520 00000000 		adds.l	%s0,%s60,%s0
 3151      80BC0059 
 3152              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 3153              		.loc	1 1202 0
 3154 4528 00000000 		muls.l	%s60,4,%s55
 3154      B7043C6E 
 3155 4530 10EDFFFF 		st	%s62,-4848(,%fp)	# spill 
 3155      89003E11 
 3156 4538 58EDFFFF 		st	%s0,-4776(,%fp)	# spill 
 3156      89000011 
 3157 4540 E8EBFFFF 		st	%s60,-5144(,%fp)	# spill 
 3157      89003C11 
 3158 4548 00000000 		muls.l	%s0,4,%s60
 3158      BC04006E 
 3159 4550 00000000 		muls.l	%s62,4,%s45
 3159      AD043E6E 
 3160 4558 A8EBFFFF 		st	%s0,-5208(,%fp)	# spill 
 3160      89000011 
 3161 4560 D0EBFFFF 		st	%s62,-5168(,%fp)	# spill 
 3161      89003E11 
 3162 4568 00000000 		muls.l	%s0,4,%s62
 3162      BE04006E 
 3163              	# line 1216
1216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 3164              		.loc	1 1216 0
 3165 4570 00000000 		muls.l	%s18,4,%s43
 3165      AB04126E 
 3166 4578 B0EBFFFF 		st	%s0,-5200(,%fp)	# spill 
 3166      89000011 
 3167 4580 00000000 		or	%s57,0,%s24
 3167      98003945 
 3168 4588 00000000 		or	%s60,0,%s23
 3168      97003C45 
 3169              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 3170              		.loc	1 1202 0
 3171 4590 00000000 		adds.l	%s0,%s23,%s62
 3171      BE970059 
 3172 4598 00000000 		adds.l	%s44,%s23,%s59
 3172      BB972C59 
 3173 45a0 10ECFFFF 		ld	%s62,-5104(,%fp)	# restore 
 3173      89003E01 
 3174 45a8 98ECFFFF 		ld	%s59,-4968(,%fp)	# restore 
 3174      89003B01 
 3175              	# line 1150
1150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t mb = 0; mb < MB; ++mb) {
 3176              		.loc	1 1150 0
 3177 45b0 00000000 		muls.l	%s55,%s59,%s62
 3177      BEBB376E 
 3178 45b8 00000000 		muls.l	%s59,%s30,%s50
 3178      B29E3B6E 
 3179              	# line 1152
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 3180              		.loc	1 1152 0
 3181 45c0 00000000 		subs.l	%s42,0,%s50
 3181      B2002A5B 
 3182 45c8 E8C1FFFF 		ld	%s43,-15896(,%fp)	# restore 
 3182      89002B01 
 3183              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3184              		.loc	1 1194 0
 3185 45d0 00000000 		muls.l	%s41,4,%s43
 3185      AB04296E 
 3186 45d8 B8C1FFFF 		ld	%s40,-15944(,%fp)	# restore 
 3186      89002801 
 3187 45e0 00000000 		muls.l	%s39,%s43,%s40
 3187      A8AB276E 
 3188 45e8 00000000 		muls.l	%s43,4,%s39
 3188      A7042B6E 
 3189 45f0 18ECFFFF 		st	%s43,-5096(,%fp)	# spill 
 3189      89002B11 
 3190 45f8 00000000 		muls.l	%s37,4,%s43
 3190      AB04256E 
 3191 4600 00000000 		muls.l	%s43,8,%s39
 3191      A7082B6E 
 3192 4608 18EDFFFF 		st	%s37,-4840(,%fp)	# spill 
 3192      89002511 
 3193 4610 00000000 		muls.l	%s37,%s40,%s41
 3193      A9A8256E 
 3194 4618 40EDFFFF 		st	%s37,-4800(,%fp)	# spill 
 3194      89002511 
 3195 4620 00000000 		muls.l	%s41,4,%s37
 3195      A504296E 
 3196 4628 C8C1FFFF 		ld	%s35,-15928(,%fp)	# restore 
 3196      89002301 
 3197 4630 20EDFFFF 		st	%s41,-4832(,%fp)	# spill 
 3197      89002911 
 3198              	# line 1152
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 3199              		.loc	1 1152 0
 3200 4638 00000000 		muls.l	%s41,%s35,%s40
 3200      A8A3296E 
 3201              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3202              		.loc	1 1194 0
 3203 4640 00000000 		muls.l	%s29,4,%s40
 3203      A8041D6E 
 3204 4648 00000000 		muls.l	%s35,12,%s39
 3204      A70C236E 
 3205              	# line 1202
1202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t ickhkw = 0; ickhkw < ICOG_KH_KW; ++ickhkw) {
 3206              		.loc	1 1202 0
 3207 4650 00000000 		muls.l	%s39,12,%s45
 3207      AD0C276E 
 3208 4658 00000000 		or	%s45,0,%s0
 3208      80002D45 
 3209 4660 00000000 		adds.l	%s0,%s23,%s39
 3209      A7970059 
 3210 4668 F8EAFFFF 		ld	%s39,-5384(,%fp)	# restore 
 3210      89002701 
 3211 4670 00000000 		or	%s23,0,%s46
 3211      AE001745 
 3212              	# line 1151
1151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oh = 0; oh < OH; ++oh) {
 3213              		.loc	1 1151 0
 3214 4678 00000000 		subs.l	%s46,0,%s39
 3214      A7002E5B 
 3215 4680 B0C1FFFF 		ld	%s24,-15952(,%fp)	# restore 
 3215      89001801 
 3216 4688 00000000 		muls.l	%s19,%s62,%s24
 3216      98BE136E 
 3217 4690 C0C1FFFF 		ld	%s62,-15936(,%fp)	# restore 
 3217      89003E01 
 3218 4698 00000000 		muls.l	%s7,%s50,%s62
 3218      BEB2076E 
 3219 46a0 00000000 		or	%s62,0,%s39
 3219      A7003E45 
 3220              	# line 1152
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 3221              		.loc	1 1152 0
 3222 46a8 00000000 		muls.l	%s39,4,%s25
 3222      9904276E 
 3223              	# line 1153
1153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 3224              		.loc	1 1153 0
 3225 46b0 00000000 		subs.l	%s24,0,%s25
 3225      9900185B 
 3226 46b8 D8C1FFFF 		ld	%s3,-15912(,%fp)	# restore 
 3226      89000301 
 3227 46c0 D0ECFFFF 		st	%s4,-4912(,%fp)	# spill 
 3227      89000411 
 3228              	# line 1152
1152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ow = 0; ow < OW; ++ow) {
 3229              		.loc	1 1152 0
 3230 46c8 00000000 		muls.l	%s4,%s40,%s3
 3230      83A8046E 
 3231 46d0 00000000 		muls.l	%s40,4,%s4
 3231      8404286E 
 3232 46d8 00000000 		muls.l	%s4,-4,%s41
 3232      A97C046E 
 3233 46e0 E0C1FFFF 		ld	%s41,-15904(,%fp)	# restore 
 3233      89002901 
 3234              	# line 1153
1153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // ---- 1 omp thread ----
 3235              		.loc	1 1153 0
 3236 46e8 00000000 		muls.l	%s3,4,%s41
 3236      A904036E 
 3237 46f0 D0C1FFFF 		ld	%s41,-15920(,%fp)	# restore 
 3237      89002901 
 3238 46f8 D8ECFFFF 		st	%s5,-4904(,%fp)	# spill 
 3238      89000511 
 3239 4700 00000000 		muls.l	%s5,-4,%s41
 3239      A97C056E 
 3240              	# line 1180
1180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
 3241              		.loc	1 1180 0
 3242 4708 D0FFFFFF 		dld	%s41,-48(,%fp)	# khkw_muls
 3242      89002909 
 3243              	# line 1195
1195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     src[ic*KH*KW + kh*KW + kw] = (kok[kh][kw]? psrc[s0 + ic*IH*IW + kh*DH*IW + kw*D
 3244              		.loc	1 1195 0
 3245 4710 00000000 		muls.l	%s33,4,%s33
 3245      A104216E 
 3246              	# line 1203
1203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp[oc] += src[ickhkw] * pwei[w0 + ickhkw + oc * ICOG*KH*KW];
 3247              		.loc	1 1203 0
 3248 4718 00000000 		subs.l	%s6,0,%s21
 3248      9500065B 
 3249              	# line 1194
1194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
 3250              		.loc	1 1194 0
 3251 4720 00000000 		adds.l	%s21,%s37,%s20
 3251      94A51559 
 3252 4728 E0EBFFFF 		st	%s6,-5152(,%fp)	# spill 
 3252      89000611 
 3253 4730 00000000 		adds.l	%s37,%s43,%s20
 3253      94AB2559 
 3254 4738 00000000 		adds.l	%s43,%s35,%s20
 3254      94A32B59 
 3255              	# line 1180
1180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (khash != khash_prv){
 3256              		.loc	1 1180 0
 3257 4740 B8FFFFFF 		dld	%s6,-72(,%fp)	# khkw_muls
 3257      89000609 
 3258 4748 00000000 		or	%s20,0,%s63
 3258      BF001445 
 3259 4750 28ECFFFF 		st	%s43,-5080(,%fp)	# spill 
 3259      89002B11 
 3260 4758 00000000 		or	%s63,0,%s55
 3260      B7003F45 
 3261 4760 00000000 		or	%s55,0,%s4
 3261      84003745 
 3262 4768 D0ECFFFF 		ld	%s4,-4912(,%fp)	# restore 
 3262      89000401 
 3263 4770 00000000 		or	%s43,0,%s0
 3263      80002B45 
 3264 4778 00000000 		or	%s35,0,%s19
 3264      93002345 
 3265 4780 00000000 		or	%s19,0,%s24
 3265      98001345 
 3266 4788 00000000 		or	%s24,0,%s5
 3266      85001845 
 3267 4790 D8ECFFFF 		ld	%s5,-4904(,%fp)	# restore 
 3267      89000501 
 3268 4798 30ECFFFF 		st	%s37,-5072(,%fp)	# spill 
 3268      89002511 
 3269 47a0 00000000 		or	%s37,0,%s39
 3269      A7002545 
 3270 47a8 00000000 		or	%s39,0,%s3
 3270      83002745 
 3271 47b0 00000000 		or	%s3,0,%s41
 3271      A9000345 
 3272 47b8 00000000 		or	%s41,0,%s21
 3272      95002945 
 3273 47c0 30ECFFFF 		ld	%s21,-5072(,%fp)	# restore 
 3273      89001501 
 3274 47c8 00FBFFFF 		br.l	.L4.47
 3274      00000F18 
 3275              	.L4.163:
 3276 47d0 08FBFFFF 		brlt.l	0,%s22,.L4.162
 3276      96000218 
 3277 47d8 20D2FFFF 		br.l	.L4.45
 3277      00000F18 
 3278              	.L4.164:
 3279 47e0 F0FFFFFF 		br.l	.L4.163
 3279      00000F18 
 3280              	.L4.14:
 3281              	# line 1142
1142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
 3282              		.loc	1 1142 0
 3283 47e8 00000000 		lvl	%s61
 3283      00BD00BF 
 3284 47f0 00370039 		vadds.l	%v57,%s62,%v55
 3284      00BE208B 
 3285 47f8 00003933 		vdivs.l	%v51,%v57,%s60
 3285      00BC10FB 
 3286 4800 0033002C 		vmuls.l	%v44,%s60,%v51
 3286      00BC20DB 
 3287 4808 0037002B 		vadds.l	%v43,%s62,%v55
 3287      00BE208B 
 3288 4810 002C2B2A 		vsubs.l	%v42,%v43,%v44
 3288      0000009B 
 3289 4818 002A050F 		vfmk.l.ge	%vm15,%v42
 3289      000000B4 
 3290 4820 00000036 		vbrd	%v54,0,%vm15
 3290      00000F8C 
 3291 4828 00000F0F 		negm	%vm15,%vm15
 3291      00000095 
 3292 4830 00000036 		vbrd	%v54,1,%vm15
 3292      00010F8C 
 3293 4838 00340030 		vadds.l	%v48,%s59,%v52
 3293      00BB208B 
 3294 4840 0000302F 		vdivs.l	%v47,%v48,%s60
 3294      00BC10FB 
 3295 4848 00360029 		vor	%v41,(0)1,%v54
 3295      000020C5 
 3296 4850 00292F2E 		vsubs.l	%v46,%v47,%v41
 3296      0000009B 
 3297 4858 00000000 		adds.l	%s43,%s58,(0)1
 3297      00BA2B59 
 3298 4860 00000000 		adds.l	%s42,%s43,%s57
 3298      B9AB2A59 
 3299 4868 0000002E 		vst.nc	%v46,8,%s42
 3299      AA080091 
 3300              	# line 1143
1143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( kwb[ow] < 0  ) kwb[ow] = 0;
 3301              		.loc	1 1143 0
 3302 4870 00350028 		vadds.l	%v40,%s56,%v53
 3302      00B8208B 
 3303 4878 0000282D 		vdivs.l	%v45,%v40,%s60
 3303      00BC10FB 
 3304 4880 002D0026 		vmuls.l	%v38,%s60,%v45
 3304      00BC20DB 
 3305 4888 00350025 		vadds.l	%v37,%s56,%v53
 3305      00B8208B 
 3306 4890 00262527 		vsubs.l	%v39,%v37,%v38
 3306      0000009B 
 3307 4898 0027050F 		vfmk.l.ge	%vm15,%v39
 3307      000000B4 
 3308 48a0 00000032 		vbrd	%v50,0,%vm15
 3308      00000F8C 
 3309 48a8 00000F0F 		negm	%vm15,%vm15
 3309      00000095 
 3310 48b0 00000032 		vbrd	%v50,1,%vm15
 3310      00010F8C 
 3311 48b8 00310024 		vadds.l	%v36,%s55,%v49
 3311      00B7208B 
 3312 48c0 00002423 		vdivs.l	%v35,%v36,%s60
 3312      00BC10FB 
 3313 48c8 00320022 		vor	%v34,(0)1,%v50
 3313      000020C5 
 3314 48d0 00222321 		vsubs.l	%v33,%v35,%v34
 3314      0000009B 
 3315 48d8 00000000 		adds.l	%s42,%s54,(0)1
 3315      00B62A59 
 3316 48e0 00000000 		adds.l	%s41,%s42,%s57
 3316      B9AA2959 
 3317 48e8 00000021 		vst.nc	%v33,8,%s41
 3317      A9080091 
 3318              	# line 1144
1144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( kwe[ow] > KW ) kwe[ow] = KW;
 3319              		.loc	1 1144 0
 3320 48f0 00000000 		adds.l	%s41,%s43,%s57
 3320      B9AB2959 
 3321 48f8 00000020 		vld.nc	%v32,8,%s41
 3321      A9080081 
 3322 4900 0020001F 		vmaxs.l	%v31,0,%v32
 3322      0000209A 
 3323 4908 00000000 		adds.l	%s43,%s43,%s57
 3323      B9AB2B59 
 3324 4910 0000001F 		vst.nc	%v31,8,%s43
 3324      AB080091 
 3325              	# line 1145
1145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 3326              		.loc	1 1145 0
 3327 4918 00000000 		adds.l	%s43,%s42,%s57
 3327      B9AA2B59 
 3328 4920 0000001E 		vld.nc	%v30,8,%s43
 3328      AB080081 
 3329 4928 001E001D 		vmins.l	%v29,%s18,%v30
 3329      0092309A 
 3330 4930 00000000 		adds.l	%s42,%s42,%s57
 3330      B9AA2A59 
 3331 4938 0000001D 		vst.nc	%v29,8,%s42
 3331      AA080091 
 3332              	# line 1141
1141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, (p->dw+1) );
 3333              		.loc	1 1141 0
 3334 4940 00000000 		adds.l	%s57,%s57,%s53
 3334      B5B93959 
 3335 4948 00000000 		adds.l	%s55,%s55,%s51
 3335      B3B73759 
 3336 4950 00000000 		adds.l	%s56,%s56,%s49
 3336      B1B83859 
 3337 4958 00000000 		adds.l	%s59,%s59,%s47
 3337      AFBB3B59 
 3338 4960 00000000 		adds.l	%s62,%s62,%s46
 3338      AEBE3E59 
 3339 4968 00000000 		subs.l	%s45,%s45,%s61
 3339      BDAD2D5B 
 3340 4970 70FEFFFF 		brge.l	0,%s45,.L4.164
 3340      AD000518 
 3341 4978 68CEFFFF 		br.l	.L4.13
 3341      00000F18 
 3342              	.L4.165:
 3343 4980 00000000 		or	%s63,0,%s51
 3343      B3003F45 
 3344 4988 D0C1FFFF 		ld	%s48,-15920(,%fp)	# restore 
 3344      89003001 
 3345              	# line 1142
1142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
 3346              		.loc	1 1142 0
 3347 4990 00000000 		adds.l	%s44,%s63,%s48
 3347      B0BF2C59 
 3348 4998 00000000 		or	%s60,0,%s49
 3348      B1003C45 
 3349 49a0 B8C1FFFF 		ld	%s43,-15944(,%fp)	# restore 
 3349      89002B01 
 3350              	# line 1143
1143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( kwb[ow] < 0  ) kwb[ow] = 0;
 3351              		.loc	1 1143 0
 3352 49a8 00000000 		adds.l	%s43,%s48,%s43
 3352      ABB02B59 
 3353 49b0 00000000 		adds.l	%s43,%s63,%s43
 3353      ABBF2B59 
 3354              	# line 1141
1141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, (p->dw+1) );
 3355              		.loc	1 1141 0
 3356 49b8 00000000 		subs.l	%s63,0,%s25
 3356      99003F5B 
 3357 49c0 E0C1FFFF 		ld	%s48,-15904(,%fp)	# restore 
 3357      89003001 
 3358 49c8 00000000 		subs.l	%s48,0,%s48
 3358      B000305B 
 3359 49d0 00000000 		subs.l	%s63,0,%s63
 3359      BF003F5B 
 3360 49d8 00000000 		smvl	%s42
 3360      00002A2E 
 3361 49e0 80000000 		mins.l	%s61,%s63,%s42
 3361      AABF3D68 
 3362 49e8 00000000 		or	%s45,0,%s63
 3362      BF002D45 
 3363 49f0 00000000 		or	%s57,0,(0)1
 3363      00003945 
 3364 49f8 00000000 		muls.l	%s53,8,%s61
 3364      BD08356E 
 3365 4a00 00000000 		or	%s55,0,%s43
 3365      AB003745 
 3366 4a08 00000000 		muls.l	%s51,%s48,%s61
 3366      BDB0336E 
 3367 4a10 00000000 		lvl	%s61
 3367      00BD00BF 
 3368 4a18 0000001B 		vseq	%v27
 3368      00000099 
 3369 4a20 001B0031 		vmuls.l	%v49,%s48,%v27
 3369      00B020DB 
 3370 4a28 00000000 		or	%s56,0,%s43
 3370      AB003845 
 3371 4a30 00000000 		muls.l	%s49,%s48,%s61
 3371      BDB0316E 
 3372 4a38 001B0035 		vmuls.l	%v53,%s48,%v27
 3372      00B020DB 
 3373 4a40 00000000 		or	%s59,0,%s44
 3373      AC003B45 
 3374 4a48 00000000 		muls.l	%s47,%s48,%s61
 3374      BDB02F6E 
 3375 4a50 001B0034 		vmuls.l	%v52,%s48,%v27
 3375      00B020DB 
 3376 4a58 00000000 		or	%s62,0,%s44
 3376      AC003E45 
 3377 4a60 00000000 		muls.l	%s46,%s48,%s61
 3377      BDB02E6E 
 3378 4a68 001B0037 		vmuls.l	%v55,%s48,%v27
 3378      00B020DB 
 3379 4a70 78FDFFFF 		br.l	.L4.14
 3379      00000F18 
 3380              	.L4.166:
 3381 4a78 98FFFFFF 		ld	%s58,-104(,%fp)	# kwb
 3381      89003A01 
 3382 4a80 A8FFFFFF 		ld	%s54,-88(,%fp)	# kwe
 3382      89003601 
 3383              	# line 1142
1142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
 3384              		.loc	1 1142 0
 3385 4a88 3C000000 		ldl.sx	%s51,60(,%s31)	# *(p).__b_N4conv6desc_tE.dw
 3385      9F003303 
 3386 4a90 00000000 		adds.w.sx	%s49,1,%s51
 3386      B301314A 
 3387 4a98 E8FEFFFF 		brlt.l	0,%s25,.L4.165
 3387      99000218 
 3388 4aa0 30FDFFFF 		br.l	.L4.163
 3388      00000F18 
 3389              	.L4.167:
 3390 4aa8 D0FFFFFF 		br.l	.L4.166
 3390      00000F18 
 3391              	.L4.12:
 3392              	# line 1136
1136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 3393              		.loc	1 1136 0
 3394 4ab0 00000000 		lvl	%s61
 3394      00BD00BF 
 3395 4ab8 00150014 		vadds.l	%v20,%s62,%v21
 3395      00BE208B 
 3396 4ac0 0000140E 		vdivs.l	%v14,%v20,%s60
 3396      00BC10FB 
 3397 4ac8 000E000D 		vmuls.l	%v13,%s60,%v14
 3397      00BC20DB 
 3398 4ad0 0015000C 		vadds.l	%v12,%s62,%v21
 3398      00BE208B 
 3399 4ad8 000D0C0B 		vsubs.l	%v11,%v12,%v13
 3399      0000009B 
 3400 4ae0 000B050F 		vfmk.l.ge	%vm15,%v11
 3400      000000B4 
 3401 4ae8 00000013 		vbrd	%v19,0,%vm15
 3401      00000F8C 
 3402 4af0 00000F0F 		negm	%vm15,%vm15
 3402      00000095 
 3403 4af8 00000013 		vbrd	%v19,1,%vm15
 3403      00010F8C 
 3404 4b00 0012000A 		vadds.l	%v10,%s59,%v18
 3404      00BB208B 
 3405 4b08 00000A09 		vdivs.l	%v9,%v10,%s60
 3405      00BC10FB 
 3406 4b10 00130008 		vor	%v8,(0)1,%v19
 3406      000020C5 
 3407 4b18 00080907 		vsubs.l	%v7,%v9,%v8
 3407      0000009B 
 3408 4b20 00000000 		adds.l	%s42,%s58,(0)1
 3408      00BA2A59 
 3409 4b28 00000000 		adds.l	%s41,%s42,%s57
 3409      B9AA2959 
 3410 4b30 00000007 		vst.nc	%v7,8,%s41
 3410      A9080091 
 3411              	# line 1137
1137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( khb[oh] < 0     ) khb[oh] = 0;
 3412              		.loc	1 1137 0
 3413 4b38 00110006 		vadds.l	%v6,%s56,%v17
 3413      00B8208B 
 3414 4b40 00000605 		vdivs.l	%v5,%v6,%s60
 3414      00BC10FB 
 3415 4b48 00050004 		vmuls.l	%v4,%s60,%v5
 3415      00BC20DB 
 3416 4b50 00110003 		vadds.l	%v3,%s56,%v17
 3416      00B8208B 
 3417 4b58 00040302 		vsubs.l	%v2,%v3,%v4
 3417      0000009B 
 3418 4b60 0002050F 		vfmk.l.ge	%vm15,%v2
 3418      000000B4 
 3419 4b68 00000010 		vbrd	%v16,0,%vm15
 3419      00000F8C 
 3420 4b70 00000F0F 		negm	%vm15,%vm15
 3420      00000095 
 3421 4b78 00000010 		vbrd	%v16,1,%vm15
 3421      00010F8C 
 3422 4b80 000F0001 		vadds.l	%v1,%s55,%v15
 3422      00B7208B 
 3423 4b88 00000100 		vdivs.l	%v0,%v1,%s60
 3423      00BC10FB 
 3424 4b90 0010003F 		vor	%v63,(0)1,%v16
 3424      000020C5 
 3425 4b98 003F003D 		vsubs.l	%v61,%v0,%v63
 3425      0000009B 
 3426 4ba0 00000000 		adds.l	%s41,%s54,(0)1
 3426      00B62959 
 3427 4ba8 00000000 		adds.l	%s40,%s41,%s57
 3427      B9A92859 
 3428 4bb0 0000003D 		vst.nc	%v61,8,%s40
 3428      A8080091 
 3429              	# line 1138
1138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( khe[oh] > p->kh ) khe[oh] = p->kh;
 3430              		.loc	1 1138 0
 3431 4bb8 00000000 		adds.l	%s40,%s42,%s57
 3431      B9AA2859 
 3432 4bc0 0000003E 		vld.nc	%v62,8,%s40
 3432      A8080081 
 3433 4bc8 003E003B 		vmaxs.l	%v59,0,%v62
 3433      0000209A 
 3434 4bd0 00000000 		adds.l	%s42,%s42,%s57
 3434      B9AA2A59 
 3435 4bd8 0000003B 		vst.nc	%v59,8,%s42
 3435      AA080091 
 3436              	# line 1139
1139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 3437              		.loc	1 1139 0
 3438 4be0 00000000 		adds.l	%s42,%s41,%s57
 3438      B9A92A59 
 3439 4be8 0000003A 		vld.nc	%v58,8,%s42
 3439      AA080081 
 3440 4bf0 003A003C 		vcmps.l	%v60,%s53,%v58
 3440      00B520BA 
 3441 4bf8 003C020F 		vfmk.l.lt	%vm15,%v60
 3441      000000B4 
 3442 4c00 00000038 		vbrd	%v56,%s53
 3442      00B5008C 
 3443 4c08 00000000 		adds.l	%s41,%s41,%s57
 3443      B9A92959 
 3444 4c10 00000038 		vst.nc	%v56,8,%s41,%vm15
 3444      A9080F91 
 3445              	# line 1133
1133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       // trick to easy calc of kh, kw loop limits is that division must
 3446              		.loc	1 1133 0
 3447 4c18 00000000 		adds.l	%s57,%s57,%s51
 3447      B3B93959 
 3448 4c20 00000000 		adds.l	%s55,%s55,%s49
 3448      B1B73759 
 3449 4c28 00000000 		adds.l	%s56,%s56,%s47
 3449      AFB83859 
 3450 4c30 00000000 		adds.l	%s59,%s59,%s46
 3450      AEBB3B59 
 3451 4c38 00000000 		adds.l	%s62,%s62,%s45
 3451      ADBE3E59 
 3452 4c40 00000000 		subs.l	%s43,%s43,%s61
 3452      BDAB2B5B 
 3453 4c48 60FEFFFF 		brge.l	0,%s43,.L4.167
 3453      AB000518 
 3454 4c50 80CBFFFF 		br.l	.L4.11
 3454      00000F18 
 3455              	.L4.168:
 3456 4c58 00000000 		or	%s63,0,%s51
 3456      B3003F45 
 3457 4c60 C8C1FFFF 		ld	%s48,-15928(,%fp)	# restore 
 3457      89003001 
 3458              	# line 1136
1136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 3459              		.loc	1 1136 0
 3460 4c68 00000000 		adds.l	%s44,%s63,%s48
 3460      B0BF2C59 
 3461 4c70 00000000 		or	%s60,0,%s49
 3461      B1003C45 
 3462 4c78 10ECFFFF 		ld	%s42,-5104(,%fp)	# restore 
 3462      89002A01 
 3463              	# line 1137
1137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if( khb[oh] < 0     ) khb[oh] = 0;
 3464              		.loc	1 1137 0
 3465 4c80 00000000 		adds.l	%s42,%s48,%s42
 3465      AAB02A59 
 3466 4c88 00000000 		adds.l	%s42,%s63,%s42
 3466      AABF2A59 
 3467              	# line 1139
1139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 3468              		.loc	1 1139 0
 3469 4c90 20000000 		dldl.sx	%s63,32(,%s31)	# *(p).__b_N4conv6desc_tE.kh
 3469      9F003F0B 
 3470 4c98 00000000 		or	%s53,0,%s63
 3470      BF003545 
 3471              	# line 1133
1133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       // trick to easy calc of kh, kw loop limits is that division must
 3472              		.loc	1 1133 0
 3473 4ca0 00000000 		subs.l	%s63,0,%s50
 3473      B2003F5B 
 3474 4ca8 D8C1FFFF 		ld	%s48,-15912(,%fp)	# restore 
 3474      89003001 
 3475 4cb0 00000000 		subs.l	%s48,0,%s48
 3475      B000305B 
 3476 4cb8 00000000 		subs.l	%s63,0,%s63
 3476      BF003F5B 
 3477 4cc0 00000000 		smvl	%s41
 3477      0000292E 
 3478 4cc8 80000000 		mins.l	%s61,%s63,%s41
 3478      A9BF3D68 
 3479 4cd0 00000000 		or	%s43,0,%s63
 3479      BF002B45 
 3480 4cd8 00000000 		or	%s57,0,(0)1
 3480      00003945 
 3481 4ce0 00000000 		muls.l	%s51,8,%s61
 3481      BD08336E 
 3482 4ce8 00000000 		or	%s55,0,%s42
 3482      AA003745 
 3483 4cf0 00000000 		muls.l	%s49,%s48,%s61
 3483      BDB0316E 
 3484 4cf8 00000000 		lvl	%s61
 3484      00BD00BF 
 3485 4d00 0000001C 		vseq	%v28
 3485      00000099 
 3486 4d08 001C000F 		vmuls.l	%v15,%s48,%v28
 3486      00B020DB 
 3487 4d10 00000000 		or	%s56,0,%s42
 3487      AA003845 
 3488 4d18 00000000 		muls.l	%s47,%s48,%s61
 3488      BDB02F6E 
 3489 4d20 001C0011 		vmuls.l	%v17,%s48,%v28
 3489      00B020DB 
 3490 4d28 00000000 		or	%s59,0,%s44
 3490      AC003B45 
 3491 4d30 00000000 		muls.l	%s46,%s48,%s61
 3491      BDB02E6E 
 3492 4d38 001C0012 		vmuls.l	%v18,%s48,%v28
 3492      00B020DB 
 3493 4d40 00000000 		or	%s62,0,%s44
 3493      AC003E45 
 3494 4d48 00000000 		muls.l	%s45,%s48,%s61
 3494      BDB02D6E 
 3495 4d50 001C0015 		vmuls.l	%v21,%s48,%v28
 3495      00B020DB 
 3496 4d58 58FDFFFF 		br.l	.L4.12
 3496      00000F18 
 3497              	.L4.169:
 3498              	# line 1131
1131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 3499              		.loc	1 1131 0
 3500 4d60 00000000 		muls.l	%s0,4,%s30
 3500      9E04006E 
 3501 4d68 00000000 		lea	%s12,__grow_stack@LO
 3501      00000C06 
 3502 4d70 00000000 		and	%s12,%s12,(32)0
 3502      608C0C44 
 3503 4d78 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3503      8C008C06 
 3504 4d80 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3504      8C000A08 
 3505 4d88 D0000000 		lea	%s49,208
 3505      00003106 
 3506 4d90 00000000 		adds.l	%s49,%sp,%s49
 3506      B18B3159 
 3507 4d98 00000000 		st	%s49,0(,%s51)
 3507      B3003111 
 3508 4da0 D0FDFFFF 		ld	%s51,-560(,%fp)	# tmp
 3508      89003301 
 3509 4da8 88FFFFFF 		lea	%s49,-120
 3509      00003106 
 3510 4db0 00000000 		st	%s51,0(%s49,%fp)
 3510      89B13311 
 3511 4db8 00000000 		or	%s51,6,(0)1
 3511      00063345 
 3512 4dc0 00000000 		st2b	%s51,0(,%s27)
 3512      9B003314 
 3513              	# line 1133
1133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       // trick to easy calc of kh, kw loop limits is that division must
 3514              		.loc	1 1133 0
 3515 4dc8 90FFFFFF 		ld	%s58,-112(,%fp)	# khb
 3515      89003A01 
 3516 4dd0 A0FFFFFF 		ld	%s54,-96(,%fp)	# khe
 3516      89003601 
 3517              	# line 1136
1136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 3518              		.loc	1 1136 0
 3519 4dd8 38000000 		ldl.sx	%s51,56(,%s31)	# *(p).__b_N4conv6desc_tE.dh
 3519      9F003303 
 3520 4de0 00000000 		adds.w.sx	%s49,1,%s51
 3520      B301314A 
 3521 4de8 70FEFFFF 		brlt.l	0,%s50,.L4.168
 3521      B2000218 
 3522 4df0 88FCFFFF 		br.l	.L4.166
 3522      00000F18 
 3523              	.L4.170:
 3524              	# line 1078
1078:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pbia = (float*)bia_m;
 3525              		.loc	1 1078 0
 3526 4df8 A8010000 		ld	%s23,424(,%s2)	# *(wei_m).data_
 3526      82001701 
 3527 4e00 98ECFFFF 		st	%s63,-4968(,%fp)	# spill 
 3527      89003F11 
 3528              	# line 1079
1079:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdst = (float*)dst_m;
 3529              		.loc	1 1079 0
 3530 4e08 A8010000 		ld	%s24,424(,%s3)	# *(bia_m).data_
 3530      83001801 
 3531              	# line 1080
1080:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   ssize_t khb[OH], khe[OH]; ALLOC_ON_VREG(khb,OH) ALLOC_ON_VREG(khe,OH)
 3532              		.loc	1 1080 0
 3533 4e10 A8010000 		ld	%s52,424(,%s4)	# *(dst_m).data_
 3533      84003401 
 3534              	# line 1081
1081:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   ssize_t kwb[OW], kwe[OW]; ALLOC_ON_VREG(kwb,OW) ALLOC_ON_VREG(kwe,OW)
 3535              		.loc	1 1081 0
 3536 4e18 90FFFFFF 		lea	%s51,-112
 3536      00003306 
 3537 4e20 00000000 		adds.l	%s27,%fp,%s51
 3537      B3891B59 
 3538 4e28 00000000 		muls.l	%s28,8,%s50
 3538      B2081C6E 
 3539 4e30 00000000 		or	%s0,0,%s28
 3539      9C000045 
 3540 4e38 00000000 		lea	%s12,__grow_stack@LO
 3540      00000C06 
 3541 4e40 00000000 		and	%s12,%s12,(32)0
 3541      608C0C44 
 3542 4e48 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3542      8C008C06 
 3543 4e50 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3543      8C000A08 
 3544 4e58 D0000000 		lea	%s51,208
 3544      00003306 
 3545 4e60 00000000 		adds.l	%s51,%sp,%s51
 3545      B38B3359 
 3546 4e68 00000000 		lea	%s49,0
 3546      00003106 
 3547 4e70 00000000 		or	%s0,0,%s28
 3547      9C000045 
 3548 4e78 00000000 		st	%s51,0(,%s27)
 3548      9B003311 
 3549 4e80 90FFFFFF 		ld	%s51,-112(,%fp)	# khb
 3549      89003301 
 3550 4e88 58FFFFFF 		st	%s51,-168(,%fp)
 3550      89003311 
 3551 4e90 00000000 		lea	%s27,__eh_curr_region@LO
 3551      00001B06 
 3552 4e98 00000000 		and	%s27,%s27,(32)0
 3552      609B1B44 
 3553 4ea0 00000000 		lea.sl	%s27,__eh_curr_region@HI(,%s27)
 3553      9B009B06 
 3554 4ea8 00000000 		st2b	%s49,0(,%s27)
 3554      9B003114 
 3555 4eb0 A0FFFFFF 		lea	%s51,-96
 3555      00003306 
 3556 4eb8 00000000 		adds.l	%s28,%fp,%s51
 3556      B3891C59 
 3557 4ec0 00000000 		lea	%s12,__grow_stack@LO
 3557      00000C06 
 3558 4ec8 00000000 		and	%s12,%s12,(32)0
 3558      608C0C44 
 3559 4ed0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3559      8C008C06 
 3560 4ed8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3560      8C000A08 
 3561 4ee0 D0000000 		lea	%s51,208
 3561      00003306 
 3562 4ee8 00000000 		adds.l	%s51,%sp,%s51
 3562      B38B3359 
 3563 4ef0 00000000 		st	%s51,0(,%s28)
 3563      9C003311 
 3564 4ef8 A0FFFFFF 		ld	%s51,-96(,%fp)	# khe
 3564      89003301 
 3565 4f00 60FFFFFF 		lea	%s49,-160
 3565      00003106 
 3566 4f08 00000000 		st	%s51,0(%s49,%fp)
 3566      89B13311 
 3567 4f10 00000000 		or	%s51,1,(0)1
 3567      00013345 
 3568 4f18 00000000 		st2b	%s51,0(,%s27)
 3568      9B003314 
 3569              	# line 1082
1082:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 3570              		.loc	1 1082 0
 3571 4f20 98FFFFFF 		lea	%s51,-104
 3571      00003306 
 3572 4f28 00000000 		adds.l	%s28,%fp,%s51
 3572      B3891C59 
 3573 4f30 00000000 		muls.l	%s29,8,%s25
 3573      99081D6E 
 3574 4f38 00000000 		or	%s0,0,%s29
 3574      9D000045 
 3575 4f40 00000000 		lea	%s12,__grow_stack@LO
 3575      00000C06 
 3576 4f48 00000000 		and	%s12,%s12,(32)0
 3576      608C0C44 
 3577 4f50 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3577      8C008C06 
 3578 4f58 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3578      8C000A08 
 3579 4f60 D0000000 		lea	%s51,208
 3579      00003306 
 3580 4f68 00000000 		adds.l	%s51,%sp,%s51
 3580      B38B3359 
 3581 4f70 00000000 		or	%s0,0,%s29
 3581      9D000045 
 3582 4f78 00000000 		st	%s51,0(,%s28)
 3582      9C003311 
 3583 4f80 98FFFFFF 		ld	%s51,-104(,%fp)	# kwb
 3583      89003301 
 3584 4f88 68FFFFFF 		lea	%s49,-152
 3584      00003106 
 3585 4f90 00000000 		st	%s51,0(%s49,%fp)
 3585      89B13311 
 3586 4f98 00000000 		or	%s51,2,(0)1
 3586      00023345 
 3587 4fa0 00000000 		st2b	%s51,0(,%s27)
 3587      9B003314 
 3588 4fa8 A8FFFFFF 		lea	%s51,-88
 3588      00003306 
 3589 4fb0 00000000 		adds.l	%s28,%fp,%s51
 3589      B3891C59 
 3590 4fb8 00000000 		lea	%s12,__grow_stack@LO
 3590      00000C06 
 3591 4fc0 00000000 		and	%s12,%s12,(32)0
 3591      608C0C44 
 3592 4fc8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3592      8C008C06 
 3593 4fd0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3593      8C000A08 
 3594 4fd8 D0000000 		lea	%s51,208
 3594      00003306 
 3595 4fe0 00000000 		adds.l	%s51,%sp,%s51
 3595      B38B3359 
 3596 4fe8 00000000 		st	%s51,0(,%s28)
 3596      9C003311 
 3597 4ff0 A8FFFFFF 		ld	%s51,-88(,%fp)	# kwe
 3597      89003301 
 3598 4ff8 70FFFFFF 		lea	%s49,-144
 3598      00003106 
 3599 5000 00000000 		st	%s51,0(%s49,%fp)
 3599      89B13311 
 3600 5008 00000000 		or	%s51,3,(0)1
 3600      00033345 
 3601 5010 00000000 		st2b	%s51,0(,%s27)
 3601      9B003314 
 3602              	# line 1121
1121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //ssize_t kh_beg_prv=0, kh_end_prv=0, kw_beg_prv=0, kw_end_prv=0, w0_prv=0;
 3603              		.loc	1 1121 0
 3604 5018 00000000 		or	%s26,-1,(0)1
 3604      007F1A45 
 3605              	# line 1124
1124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ssize_t khkw_begend[4];
 3606              		.loc	1 1124 0
 3607 5020 00000000 		muls.l	%s0,%s19,%s18
 3607      9293006E 
 3608 5028 B0FFFFFF 		lea	%s51,-80
 3608      00003306 
 3609 5030 00000000 		adds.l	%s28,%fp,%s51
 3609      B3891C59 
 3610 5038 00000000 		lea	%s12,__grow_stack@LO
 3610      00000C06 
 3611 5040 00000000 		and	%s12,%s12,(32)0
 3611      608C0C44 
 3612 5048 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3612      8C008C06 
 3613 5050 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3613      8C000A08 
 3614 5058 D0000000 		lea	%s51,208
 3614      00003306 
 3615 5060 00000000 		adds.l	%s51,%sp,%s51
 3615      B38B3359 
 3616 5068 98ECFFFF 		ld	%s63,-4968(,%fp)	# restore 
 3616      89003F01 
 3617 5070 00000000 		st	%s51,0(,%s28)
 3617      9C003311 
 3618 5078 B0FFFFFF 		ld	%s51,-80(,%fp)	# kok
 3618      89003301 
 3619 5080 78FFFFFF 		lea	%s49,-136
 3619      00003106 
 3620 5088 00000000 		st	%s51,0(%s49,%fp)
 3620      89B13311 
 3621 5090 00000000 		or	%s51,4,(0)1
 3621      00043345 
 3622 5098 00000000 		st2b	%s51,0(,%s27)
 3622      9B003314 
 3623              	# line 1126
1126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     VREG(khkw_begend) VREG(khkw_muls) VREG(kok)//;
 3624              		.loc	1 1126 0
 3625 50a0 B8FFFFFF 		lea	%s51,-72
 3625      00003306 
 3626 50a8 00000000 		adds.l	%s51,%fp,%s51
 3626      B3893359 
 3627 50b0 00000000 		lea	%s49,.LP._ZN4conv12sxconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.khkw_muls.__initializer.0@LO
 3627      00003106 
 3628 50b8 00000000 		and	%s49,%s49,(32)0
 3628      60B13144 
 3629 50c0 00000000 		lea.sl	%s49,.LP._ZN4conv12sxconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.khkw_muls.__initializer.0@
 3629      B100B106 
 3630 50c8 00000000 		ld	%s47,0(,%s49)	# conflict.I64
 3630      B1002F01 
 3631 50d0 00000000 		st	%s47,0(,%s51)	# conflict.I64
 3631      B3002F11 
 3632 50d8 00000000 		adds.l	%s47,8,%s49
 3632      B1082F59 
 3633 50e0 00000000 		ld	%s47,0(,%s47)	# conflict.I64
 3633      AF002F01 
 3634 50e8 00000000 		adds.l	%s46,8,%s51
 3634      B3082E59 
 3635 50f0 00000000 		st	%s47,0(,%s46)	# conflict.I64
 3635      AE002F11 
 3636 50f8 00000000 		adds.l	%s47,16,%s49
 3636      B1102F59 
 3637 5100 00000000 		ld	%s47,0(,%s47)	# conflict.I64
 3637      AF002F01 
 3638 5108 00000000 		adds.l	%s46,16,%s51
 3638      B3102E59 
 3639 5110 00000000 		st	%s47,0(,%s46)	# conflict.I64
 3639      AE002F11 
 3640 5118 00000000 		adds.l	%s49,24,%s49
 3640      B1183159 
 3641 5120 00000000 		ld	%s49,0(,%s49)	# conflict.I64
 3641      B1003101 
 3642 5128 00000000 		adds.l	%s51,24,%s51
 3642      B3183359 
 3643 5130 00000000 		st	%s49,0(,%s51)	# conflict.I64
 3643      B3003111 
 3644 5138 C0FFFFFF 		lea	%s51,-64
 3644      00003306 
 3645 5140 00000000 		st	%s19,0(%s51,%fp)	# khkw_muls
 3645      89B31311 
 3646 5148 00000100 		lea	%s51,65536
 3646      00003306 
 3647 5150 00000000 		muls.l	%s51,%s18,%s51
 3647      B392336E 
 3648 5158 D0FFFFFF 		lea	%s49,-48
 3648      00003106 
 3649 5160 00000000 		st	%s51,0(%s49,%fp)	# khkw_muls
 3649      89B13311 
 3650              	# line 1130
1130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     float tmp[OCOG] alignas(64);       ALLOC_ON_VREG(tmp,OCOG)//; // roughly double the speed;
 3651              		.loc	1 1130 0
 3652 5168 00000000 		muls.l	%s51,%s19,%s63
 3652      BF93336E 
 3653 5170 00000000 		muls.l	%s51,%s18,%s51
 3653      B392336E 
 3654 5178 50FFFFFF 		lea	%s49,-176
 3654      00003106 
 3655 5180 00000000 		adds.l	%s28,%fp,%s49
 3655      B1891C59 
 3656 5188 00000000 		muls.l	%s0,4,%s51
 3656      B304006E 
 3657 5190 00000000 		lea	%s12,__grow_stack@LO
 3657      00000C06 
 3658 5198 00000000 		and	%s12,%s12,(32)0
 3658      608C0C44 
 3659 51a0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3659      8C008C06 
 3660 51a8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3660      8C000A08 
 3661 51b0 D0000000 		lea	%s51,208
 3661      00003306 
 3662 51b8 00000000 		adds.l	%s51,%sp,%s51
 3662      B38B3359 
 3663 51c0 00000000 		st	%s51,0(,%s28)
 3663      9C003311 
 3664 51c8 50FFFFFF 		ld	%s51,-176(,%fp)	# src
 3664      89003301 
 3665 51d0 80FFFFFF 		lea	%s49,-128
 3665      00003106 
 3666 51d8 00000000 		st	%s51,0(%s49,%fp)
 3666      89B13311 
 3667 51e0 00000000 		or	%s51,5,(0)1
 3667      00053345 
 3668 51e8 00000000 		st2b	%s51,0(,%s27)
 3668      9B003314 
 3669              	# line 1131
1131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 3670              		.loc	1 1131 0
 3671 51f0 D0FDFFFF 		lea	%s51,-560
 3671      00003306 
 3672 51f8 00000000 		adds.l	%s51,%fp,%s51
 3672      B3893359 
 3673 5200 60FBFFFF 		br.l	.L4.169
 3673      00000F18 
 3674              	.L4.171:
 3675              	# line 1077
1077:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
 3676              		.loc	1 1077 0
 3677 5208 A8010000 		ld	%s20,424(,%s1)	# *(src_m).data_
 3677      81001401 
 3678 5210 E8FBFFFF 		br.l	.L4.170
 3678      00000F18 
 3679              	.L4.172:
 3680 5218 78EAFFFF 		st	%s1,-5512(,%fp)	# spill 
 3680      89000111 
 3681 5220 98ECFFFF 		st	%s63,-4968(,%fp)	# spill 
 3681      89003F11 
 3682 5228 40EBFFFF 		st	%s50,-5312(,%fp)	# spill 
 3682      89003211 
 3683 5230 90EAFFFF 		st	%s4,-5488(,%fp)	# spill 
 3683      89000411 
 3684 5238 88EAFFFF 		st	%s3,-5496(,%fp)	# spill 
 3684      89000311 
 3685 5240 80EAFFFF 		st	%s2,-5504(,%fp)	# spill 
 3685      89000211 
 3686              	# line 43
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** }
 3687              		.loc	1 43 0
 3688 5248 00000000 		lea	%s0,.LP.__string.6@LO
 3688      00000006 
 3689 5250 00000000 		and	%s0,%s0,(32)0
 3689      60800044 
 3690 5258 00000000 		lea.sl	%s0,.LP.__string.6@HI(,%s0)
 3690      80008006 
 3691 5260 00000000 		or	%s2,0,%s49
 3691      B1000245 
 3692 5268 B0000000 		st	%s0,176(,%sp)
 3692      8B000011 
 3693 5270 B8000000 		st	%s51,184(,%sp)
 3693      8B003311 
 3694 5278 C0000000 		st	%s49,192(,%sp)
 3694      8B003111 
 3695 5280 34040000 		lea	%s3,1076
 3695      00000306 
 3696 5288 00000000 		or	%s1,0,%s51
 3696      B3000145 
 3697 5290 C8000000 		st	%s3,200(,%sp)
 3697      8B000311 
 3698 5298 00000000 		lea	%s12,printf@LO
 3698      00000C06 
 3699 52a0 00000000 		and	%s12,%s12,(32)0
 3699      608C0C44 
 3700 52a8 00000000 		lea.sl	%s12,printf@HI(,%s12)
 3700      8C008C06 
 3701 52b0 00000000 		bsic	%lr,(,%s12)	# printf
 3701      8C000A08 
 3702 52b8 00000000 		or	%s0,1,(0)1
 3702      00010045 
 3703 52c0 00000000 		lea	%s12,exit@LO
 3703      00000C06 
 3704 52c8 00000000 		and	%s12,%s12,(32)0
 3704      608C0C44 
 3705 52d0 00000000 		lea.sl	%s12,exit@HI(,%s12)
 3705      8C008C06 
 3706 52d8 00000000 		bsic	%lr,(,%s12)	# exit
 3706      8C000A08 
 3707 52e0 78EAFFFF 		ld	%s1,-5512(,%fp)	# restore 
 3707      89000101 
 3708 52e8 98ECFFFF 		ld	%s63,-4968(,%fp)	# restore 
 3708      89003F01 
 3709 52f0 40EBFFFF 		ld	%s50,-5312(,%fp)	# restore 
 3709      89003201 
 3710 52f8 90EAFFFF 		ld	%s4,-5488(,%fp)	# restore 
 3710      89000401 
 3711 5300 88EAFFFF 		ld	%s3,-5496(,%fp)	# restore 
 3711      89000301 
 3712 5308 80EAFFFF 		ld	%s2,-5504(,%fp)	# restore 
 3712      89000201 
 3713 5310 F8FEFFFF 		br.l	.L4.171
 3713      00000F18 
 3714              	.L4.10:
 3715 5318 00FFFFFF 		breq.w	0,%s20,.L4.172
 3715      94008418 
 3716 5320 E8FEFFFF 		br.l	.L4.171
 3716      00000F18 
 3717              	.L4.173:
 3718 5328 E8C1FFFF 		st	%s52,-15896(,%fp)	# spill 
 3718      89003411 
 3719 5330 E0C1FFFF 		st	%s53,-15904(,%fp)	# spill 
 3719      89003511 
 3720 5338 D8C1FFFF 		st	%s54,-15912(,%fp)	# spill 
 3720      89003611 
 3721 5340 D0C1FFFF 		st	%s55,-15920(,%fp)	# spill 
 3721      89003711 
 3722 5348 C8C1FFFF 		st	%s56,-15928(,%fp)	# spill 
 3722      89003811 
 3723 5350 C0C1FFFF 		st	%s58,-15936(,%fp)	# spill 
 3723      89003A11 
 3724 5358 B8C1FFFF 		st	%s59,-15944(,%fp)	# spill 
 3724      89003B11 
 3725 5360 10ECFFFF 		st	%s44,-5104(,%fp)	# spill 
 3725      89002C11 
 3726 5368 B0C1FFFF 		st	%s60,-15952(,%fp)	# spill 
 3726      89003C11 
 3727 5370 F8EAFFFF 		st	%s62,-5384(,%fp)	# spill 
 3727      89003E11 
 3728 5378 00000000 		or	%s20,1,(0)1
 3728      00011445 
 3729 5380 00000000 		or	%s31,0,%s47
 3729      AF001F45 
 3730 5388 80EAFFFF 		ld	%s2,-5504(,%fp)	# restore 
 3730      89000201 
 3731 5390 00000000 		or	%s32,0,%s57
 3731      B9002045 
 3732 5398 88EAFFFF 		ld	%s3,-5496(,%fp)	# restore 
 3732      89000301 
 3733 53a0 00000000 		or	%s33,0,%s1
 3733      81002145 
 3734 53a8 78EAFFFF 		ld	%s1,-5512(,%fp)	# restore 
 3734      89000101 
 3735 53b0 00000000 		or	%s22,0,%s61
 3735      BD001645 
 3736 53b8 90EAFFFF 		ld	%s4,-5488(,%fp)	# restore 
 3736      89000401 
 3737 53c0 58FFFFFF 		br.l	.L4.10
 3737      00000F18 
 3738              	.L4.174:
 3739 53c8 60FFFFFF 		brle.l	0,%s53,.L4.173
 3739      B5000618 
 3740 53d0 60C3FFFF 		br.l	.L4.9
 3740      00000F18 
 3741              	.L4.8:
 3742              	# line 1076
1076:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const psrc = (float*)src_m;
 3743              		.loc	1 1076 0
 3744 53d8 00000000 		lea	%s51,.LP.__string.5@LO
 3744      00003306 
 3745 53e0 00000000 		and	%s51,%s51,(32)0
 3745      60B33344 
 3746 53e8 00000000 		lea.sl	%s51,.LP.__string.5@HI(,%s51)
 3746      B300B306 
 3747 53f0 00000000 		lea	%s49,.LP.__15_sx_conv3_ve_cpp_ab09f9b5.0.__unnamed.0@LO
 3747      00003106 
 3748 53f8 00000000 		and	%s49,%s49,(32)0
 3748      60B13144 
 3749 5400 00000000 		lea.sl	%s49,.LP.__15_sx_conv3_ve_cpp_ab09f9b5.0.__unnamed.0@HI(,%s49)
 3749      B100B106 
 3750 5408 C0FFFFFF 		brle.l	0,%s54,.L4.174
 3750      B6000618 
 3751 5410 20C3FFFF 		br.l	.L4.9
 3751      00000F18 
 3752              	.L4.6:
 3753 5418 38000000 		lea	%s49,56
 3753      00003106 
 3754              	# line 1075
1075:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( SH >= 0 && SW >= 0 );
 3755              		.loc	1 1075 0
 3756 5420 00000000 		sll	%s51,%s51,%s49
 3756      B3B13365 
 3757 5428 38000000 		lea	%s49,56
 3757      00003106 
 3758 5430 00000000 		sra.l	%s51,%s51,%s49
 3758      B3B13377 
 3759 5438 00000000 		or	%s51,0,%s51
 3759      B3003345 
 3760 5440 00000000 		lea	%s49,.LP.__string.3@LO
 3760      00003106 
 3761 5448 00000000 		and	%s49,%s49,(32)0
 3761      60B13144 
 3762 5450 00000000 		lea.sl	%s49,.LP.__string.3@HI(,%s49)
 3762      B100B106 
 3763 5458 00000000 		lea	%s48,.LP.__15_sx_conv3_ve_cpp_ab09f9b5.0.__unnamed.0@LO
 3763      00003006 
 3764 5460 00000000 		and	%s48,%s48,(32)0
 3764      60B03044 
 3765 5468 00000000 		lea.sl	%s48,.LP.__15_sx_conv3_ve_cpp_ab09f9b5.0.__unnamed.0@HI(,%s48)
 3765      B000B006 
 3766 5470 68FFFFFF 		brne.w	0,%s51,.L4.8
 3766      B3008318 
 3767 5478 18C1FFFF 		br.l	.L4.7
 3767      00000F18 
 3768              	.L4.175:
 3769 5480 00000000 		or	%s51,1,(0)1
 3769      00013345 
 3770 5488 90FFFFFF 		br.l	.L4.6
 3770      00000F18 
 3771              	.L4.176:
 3772 5490 3C000000 		ldl.sx	%s20,60(,%s47)	# *(p).__b_N4conv6desc_tE.dw
 3772      AF001403 
 3773 5498 E8FFFFFF 		brle.w	0,%s20,.L4.175
 3773      94008618 
 3774 54a0 E0C0FFFF 		br.l	.L4.5
 3774      00000F18 
 3775              	.L4.4:
 3776 54a8 38000000 		ldl.sx	%s20,56(,%s47)	# *(p).__b_N4conv6desc_tE.dh
 3776      AF001403 
 3777 54b0 E0FFFFFF 		brle.w	0,%s20,.L4.176
 3777      94008618 
 3778 54b8 C8C0FFFF 		br.l	.L4.5
 3778      00000F18 
 3779              	.L4.2:
 3780 54c0 38000000 		lea	%s49,56
 3780      00003106 
 3781              	# line 1074
1074:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 3782              		.loc	1 1074 0
 3783 54c8 00000000 		sll	%s51,%s51,%s49
 3783      B3B13365 
 3784 54d0 38000000 		lea	%s49,56
 3784      00003106 
 3785 54d8 00000000 		sra.l	%s51,%s51,%s49
 3785      B3B13377 
 3786 54e0 00000000 		or	%s51,0,%s51
 3786      B3003345 
 3787 54e8 00000000 		lea	%s49,.LP.__string.1@LO
 3787      00003106 
 3788 54f0 00000000 		and	%s49,%s49,(32)0
 3788      60B13144 
 3789 54f8 00000000 		lea.sl	%s49,.LP.__string.1@HI(,%s49)
 3789      B100B106 
 3790 5500 00000000 		lea	%s48,.LP.__15_sx_conv3_ve_cpp_ab09f9b5.0.__unnamed.0@LO
 3790      00003006 
 3791 5508 00000000 		and	%s48,%s48,(32)0
 3791      60B03044 
 3792 5510 00000000 		lea.sl	%s48,.LP.__15_sx_conv3_ve_cpp_ab09f9b5.0.__unnamed.0@HI(,%s48)
 3792      B000B006 
 3793 5518 90FFFFFF 		brne.w	0,%s51,.L4.4
 3793      B3008318 
 3794 5520 C0BEFFFF 		br.l	.L4.3
 3794      00000F18 
 3795              	.L4.177:
 3796 5528 00000000 		or	%s51,1,(0)1
 3796      00013345 
 3797 5530 70EAFFFF 		ld	%s47,-5520(,%fp)	# restore 
 3797      89002F01 
 3798 5538 00000000 		or	%s1,0,%s0
 3798      80000145 
 3799 5540 80FFFFFF 		br.l	.L4.2
 3799      00000F18 
 3800              	.L4.0:
 3801 5548 E0FFFFFF 		brlt.l	0,%s18,.L4.177
 3801      92000218 
 3802 5550 70BEFFFF 		br.l	.L4.1
 3802      00000F18 
 3803              		.cfi_endproc
 3804              		.set	.L.5.2auto_size,	0xffffffffffff8490	# 31600 Bytes
 3806              	.L_FE.5:
 3807 5558 636F6E76 		.string	"conv::sxconv_3_fwd\000ve_c"
 3807      3A3A7378 
 3807      636F6E76 
 3807      5F335F66 
 3807      77640076 
 3808              	# ============ End  conv::sxconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3809              	# ============ Begin  conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3810              		.data
 3811 00d1 00000000 		.balign 16
 3811      00000000 
 3811      00000000 
 3811      000000
 3814              	.LP._ZN4conv22sxconv_3_bwd_d_genericEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0:
 3815 00e0 00000000 		.long	__vla_dealloc_eh
 3815      00000000 
 3816 00e8 0000     		.zero	2
 3817 00ea FFFF     		.short	65535
 3818 00ec 04       		.byte	4
 3819 00ed 000000   		.zero	3
 3820 00f0 00000000 		.long	__vla_dealloc_eh
 3820      00000000 
 3821 00f8 0100     		.short	1
 3822 00fa 0000     		.zero	2
 3823 00fc 04       		.byte	4
 3824 00fd 000000   		.zero	3
 3825 0100 00000000 		.long	__vla_dealloc_eh
 3825      00000000 
 3826 0108 0200     		.short	2
 3827 010a 0100     		.short	1
 3828 010c 04       		.byte	4
 3829 010d 000000   		.zero	3
 3830 0110 00000000 		.long	__vla_dealloc_eh
 3830      00000000 
 3831 0118 0300     		.short	3
 3832 011a 0200     		.short	2
 3833 011c 04       		.byte	4
 3834 011d 000000   		.zero	3
 3835              		.text
 3836              		.balign 16
 3837              	# line 1643
1643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_src = (float*)diff_src_m;
 3838              		.loc	1 1643 0
 3839              		.globl	conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 3841 5570 B8240000 		.long	.L_FE.6-8-.
 3841      00000000 
 3842              	conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 3843              		.cfi_startproc
 3844 5578 00000000 		st	%fp,0x0(,%sp)
 3844      8B000911 
 3845              		.cfi_def_cfa_offset	0
 3846              		.cfi_offset	9,0
 3847 5580 08000000 		st	%lr,0x8(,%sp)
 3847      8B000A11 
 3848 5588 18000000 		st	%got,0x18(,%sp)
 3848      8B000F11 
 3849 5590 20000000 		st	%plt,0x20(,%sp)
 3849      8B001011 
 3850 5598 00000000 		or	%fp,0,%sp
 3850      8B000945 
 3851              		.cfi_def_cfa_register	9
 3852 55a0 30000000 		st	%s18,48(,%fp)
 3852      89001211 
 3853 55a8 38000000 		st	%s19,56(,%fp)
 3853      89001311 
 3854 55b0 40000000 		st	%s20,64(,%fp)
 3854      89001411 
 3855 55b8 48000000 		st	%s21,72(,%fp)
 3855      89001511 
 3856 55c0 50000000 		st	%s22,80(,%fp)
 3856      89001611 
 3857 55c8 58000000 		st	%s23,88(,%fp)
 3857      89001711 
 3858 55d0 60000000 		st	%s24,96(,%fp)
 3858      89001811 
 3859 55d8 68000000 		st	%s25,104(,%fp)
 3859      89001911 
 3860 55e0 70000000 		st	%s26,112(,%fp)
 3860      89001A11 
 3861 55e8 78000000 		st	%s27,120(,%fp)
 3861      89001B11 
 3862 55f0 80000000 		st	%s28,128(,%fp)
 3862      89001C11 
 3863 55f8 88000000 		st	%s29,136(,%fp)
 3863      89001D11 
 3864 5600 90000000 		st	%s30,144(,%fp)
 3864      89001E11 
 3865 5608 98000000 		st	%s31,152(,%fp)
 3865      89001F11 
 3866 5610 A0000000 		st	%s32,160(,%fp)
 3866      89002011 
 3867 5618 A8000000 		st	%s33,168(,%fp)
 3867      89002111 
 3868 5620 70D7FFFF 		lea	%s13,.L.6.2auto_size&0xffffffff
 3868      00000D06 
 3869 5628 00000000 		and	%s13,%s13,(32)0
 3869      608D0D44 
 3870 5630 FFFFFFFF 		lea.sl	%sp,.L.6.2auto_size>>32(%fp,%s13)
 3870      8D898B06 
 3871 5638 48000000 		brge.l.t	%sp,%sl,.L5.EoP
 3871      888B3518 
 3872 5640 18000000 		ld	%s61,0x18(,%tp)
 3872      8E003D01 
 3873 5648 00000000 		or	%s62,0,%s0
 3873      80003E45 
 3874 5650 3B010000 		lea	%s63,0x13b
 3874      00003F06 
 3875 5658 00000000 		shm.l	%s63,0x0(%s61)
 3875      BD033F31 
 3876 5660 08000000 		shm.l	%sl,0x8(%s61)
 3876      BD030831 
 3877 5668 10000000 		shm.l	%sp,0x10(%s61)
 3877      BD030B31 
 3878 5670 00000000 		monc
 3878      0000003F 
 3879 5678 00000000 		or	%s0,0,%s62
 3879      BE000045 
 3880              	.L5.EoP:
 3881              	# End of prologue codes
 3882 5680 D8EBFFFF 		st	%s0,-5160(,%fp)	# spill 
 3882      89000011 
 3883 5688 D0EBFFFF 		st	%s3,-5168(,%fp)	# spill 
 3883      89000311 
 3884 5690 C8EBFFFF 		st	%s2,-5176(,%fp)	# spill 
 3884      89000211 
 3885 5698 C0EBFFFF 		st	%s1,-5184(,%fp)	# spill 
 3885      89000111 
 3886 56a0 00000000 		lea	%s0,conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 3886      00000006 
 3887 56a8 00000000 		and	%s0,%s0,(32)0
 3887      60800044 
 3888 56b0 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 3888      80008006 
 3889 56b8 08000000 		ld	%s1,8(,%fp)	# ptr
 3889      89000101 
 3890 56c0 00000000 		lea	%s12,__ftrace_func_enter@LO
 3890      00000C06 
 3891 56c8 00000000 		and	%s12,%s12,(32)0
 3891      608C0C44 
 3892 56d0 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
 3892      8C008C06 
 3893 56d8 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
 3893      8C000A08 
 3894 56e0 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 3894      00003E06 
 3895 56e8 00000000 		and	%s62,%s62,(32)0
 3895      60BE3E44 
 3896 56f0 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 3896      BE00BE06 
 3897 56f8 00000000 		ld	%s61,0(,%s62)
 3897      BE003D01 
 3898 5700 C0EBFFFF 		ld	%s60,-5184(,%fp)	# restore 
 3898      89003C01 
 3899 5708 48FEFFFF 		st	%s61,-440(,%fp)
 3899      89003D11 
 3900 5710 48FEFFFF 		lea	%s61,-440
 3900      00003D06 
 3901 5718 00000000 		adds.l	%s61,%fp,%s61
 3901      BD893D59 
 3902 5720 C8EBFFFF 		ld	%s2,-5176(,%fp)	# restore 
 3902      89000201 
 3903 5728 00000000 		st	%s61,0(,%s62)
 3903      BE003D11 
 3904 5730 00000000 		or	%s62,1,(0)1
 3904      00013E45 
 3905 5738 D0EBFFFF 		ld	%s3,-5168(,%fp)	# restore 
 3905      89000301 
 3906 5740 50FEFFFF 		st1b	%s62,-432(,%fp)
 3906      89003E15 
 3907 5748 00000000 		lea	%s62,.LP._ZN4conv22sxconv_3_bwd_d_genericEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@LO
 3907      00003E06 
 3908 5750 00000000 		and	%s62,%s62,(32)0
 3908      60BE3E44 
 3909 5758 00000000 		lea.sl	%s62,.LP._ZN4conv22sxconv_3_bwd_d_genericEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@HI(,%
 3909      BE00BE06 
 3910 5760 58FEFFFF 		st	%s62,-424(,%fp)
 3910      89003E11 
 3911 5768 00000000 		adds.l	%s62,%fp,(58)1
 3911      3A893E59 
 3912 5770 D8EBFFFF 		ld	%s1,-5160(,%fp)	# restore 
 3912      89000101 
 3913 5778 60FEFFFF 		st	%s62,-416(,%fp)
 3913      89003E11 
 3914 5780 00000000 		lea	%s23,__eh_curr_region@LO
 3914      00001706 
 3915 5788 00000000 		and	%s23,%s23,(32)0
 3915      60971744 
 3916 5790 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 3916      97009706 
 3917 5798 00000000 		ld2b.zx	%s62,0(,%s23)
 3917      9700BE04 
 3918 57a0 70FEFFFF 		st2b	%s62,-400(,%fp)
 3918      89003E14 
 3919 57a8 FFFF0000 		lea	%s62,65535
 3919      00003E06 
 3920 57b0 00000000 		st2b	%s62,0(,%s23)
 3920      97003E14 
 3921              	# line 1644
1644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
 3922              		.loc	1 1644 0
 3923 57b8 A8010000 		ld	%s20,424(,%s60)	# *(diff_src_m).data_
 3923      BC001401 
 3924              	# line 1645
1645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //float const * restrict const pbia = (float*)bia_m;
 3925              		.loc	1 1645 0
 3926 57c0 A8010000 		ld	%s28,424(,%s2)	# *(wei_m).data_
 3926      82001C01 
 3927              	# line 1647
1647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define G  p->g
 3928              		.loc	1 1647 0
 3929 57c8 A8010000 		ld	%s43,424(,%s3)	# *(diff_dst_m).data_
 3929      83002B01 
 3930              	# line 1963
1963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int khe[IH];
 3931              		.loc	1 1963 0
 3932 57d0 0C000000 		ldl.sx	%s62,12(,%s1)	# *(p).__b_N4conv6desc_tE.ih
 3932      81003E03 
 3933 57d8 00000000 		or	%s62,0,%s62
 3933      BE003E45 
 3934 57e0 40FEFFFF 		lea	%s61,-448
 3934      00003D06 
 3935 57e8 00000000 		adds.l	%s24,%fp,%s61
 3935      BD891859 
 3936 57f0 00000000 		muls.l	%s0,4,%s62
 3936      BE04006E 
 3937 57f8 00000000 		lea	%s12,__grow_stack@LO
 3937      00000C06 
 3938 5800 00000000 		and	%s12,%s12,(32)0
 3938      608C0C44 
 3939 5808 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3939      8C008C06 
 3940 5810 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3940      8C000A08 
 3941 5818 C0000000 		lea	%s62,192
 3941      00003E06 
 3942 5820 00000000 		adds.l	%s62,%sp,%s62
 3942      BE8B3E59 
 3943 5828 00000000 		lea	%s61,0
 3943      00003D06 
 3944 5830 00000000 		st	%s62,0(,%s24)
 3944      98003E11 
 3945 5838 40FEFFFF 		ld	%s62,-448(,%fp)	# khb
 3945      89003E01 
 3946 5840 D8EBFFFF 		ld	%s1,-5160(,%fp)	# restore 
 3946      89000101 
 3947 5848 C0FFFFFF 		st	%s62,-64(,%fp)
 3947      89003E11 
 3948 5850 00000000 		st2b	%s61,0(,%s23)
 3948      97003D14 
 3949              	# line 1964
1964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwb[IW];
 3950              		.loc	1 1964 0
 3951 5858 0C000000 		ldl.sx	%s62,12(,%s1)	# *(p).__b_N4conv6desc_tE.ih
 3951      81003E03 
 3952 5860 00000000 		or	%s62,0,%s62
 3952      BE003E45 
 3953 5868 00000000 		adds.l	%s24,%fp,(59)1
 3953      3B891859 
 3954 5870 00000000 		muls.l	%s0,4,%s62
 3954      BE04006E 
 3955 5878 00000000 		lea	%s12,__grow_stack@LO
 3955      00000C06 
 3956 5880 00000000 		and	%s12,%s12,(32)0
 3956      608C0C44 
 3957 5888 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3957      8C008C06 
 3958 5890 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3958      8C000A08 
 3959 5898 C0000000 		lea	%s62,192
 3959      00003E06 
 3960 58a0 00000000 		adds.l	%s62,%sp,%s62
 3960      BE8B3E59 
 3961 58a8 D8EBFFFF 		ld	%s1,-5160(,%fp)	# restore 
 3961      89000101 
 3962 58b0 00000000 		st	%s62,0(,%s24)
 3962      98003E11 
 3963 58b8 E0FFFFFF 		ld	%s62,-32(,%fp)	# khe
 3963      89003E01 
 3964 58c0 C8FFFFFF 		lea	%s61,-56
 3964      00003D06 
 3965 58c8 00000000 		st	%s62,0(%s61,%fp)
 3965      89BD3E11 
 3966 58d0 00000000 		or	%s62,1,(0)1
 3966      00013E45 
 3967 58d8 00000000 		st2b	%s62,0(,%s23)
 3967      97003E14 
 3968              	# line 1965
1965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int kwe[IW];
 3969              		.loc	1 1965 0
 3970 58e0 10000000 		ldl.sx	%s62,16(,%s1)	# *(p).__b_N4conv6desc_tE.iw
 3970      81003E03 
 3971 58e8 00000000 		or	%s62,0,%s62
 3971      BE003E45 
 3972 58f0 E8FFFFFF 		lea	%s61,-24
 3972      00003D06 
 3973 58f8 00000000 		adds.l	%s24,%fp,%s61
 3973      BD891859 
 3974 5900 00000000 		muls.l	%s0,4,%s62
 3974      BE04006E 
 3975 5908 00000000 		lea	%s12,__grow_stack@LO
 3975      00000C06 
 3976 5910 00000000 		and	%s12,%s12,(32)0
 3976      608C0C44 
 3977 5918 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3977      8C008C06 
 3978 5920 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3978      8C000A08 
 3979 5928 C0000000 		lea	%s62,192
 3979      00003E06 
 3980 5930 00000000 		adds.l	%s62,%sp,%s62
 3980      BE8B3E59 
 3981 5938 D8EBFFFF 		ld	%s1,-5160(,%fp)	# restore 
 3981      89000101 
 3982 5940 00000000 		st	%s62,0(,%s24)
 3982      98003E11 
 3983 5948 E8FFFFFF 		ld	%s62,-24(,%fp)	# kwb
 3983      89003E01 
 3984 5950 D0FFFFFF 		lea	%s61,-48
 3984      00003D06 
 3985 5958 00000000 		st	%s62,0(%s61,%fp)
 3985      89BD3E11 
 3986 5960 00000000 		or	%s62,2,(0)1
 3986      00023E45 
 3987 5968 00000000 		st2b	%s62,0(,%s23)
 3987      97003E14 
 3988              	# line 1966
1966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 3989              		.loc	1 1966 0
 3990 5970 10000000 		ldl.sx	%s62,16(,%s1)	# *(p).__b_N4conv6desc_tE.iw
 3990      81003E03 
 3991 5978 00000000 		or	%s62,0,%s62
 3991      BE003E45 
 3992 5980 00000000 		adds.l	%s24,%fp,(60)1
 3992      3C891859 
 3993 5988 00000000 		muls.l	%s0,4,%s62
 3993      BE04006E 
 3994 5990 00000000 		lea	%s12,__grow_stack@LO
 3994      00000C06 
 3995 5998 00000000 		and	%s12,%s12,(32)0
 3995      608C0C44 
 3996 59a0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3996      8C008C06 
 3997 59a8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3997      8C000A08 
 3998 59b0 C0000000 		lea	%s62,192
 3998      00003E06 
 3999 59b8 00000000 		adds.l	%s62,%sp,%s62
 3999      BE8B3E59 
 4000 59c0 D8EBFFFF 		ld	%s1,-5160(,%fp)	# restore 
 4000      89000101 
 4001 59c8 00000000 		st	%s62,0(,%s24)
 4001      98003E11 
 4002 59d0 F0FFFFFF 		ld	%s62,-16(,%fp)	# kwe
 4002      89003E01 
 4003 59d8 D8FFFFFF 		lea	%s61,-40
 4003      00003D06 
 4004 59e0 00000000 		st	%s62,0(%s61,%fp)
 4004      89BD3E11 
 4005 59e8 00000000 		or	%s62,3,(0)1
 4005      00033E45 
 4006 59f0 00000000 		st2b	%s62,0(,%s23)
 4006      97003E14 
 4007              	# line 1968
1968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_h = gcd( SH, DH );
 4008              		.loc	1 1968 0
 4009 59f8 38000000 		ldl.sx	%s62,56(,%s1)	# *(p).__b_N4conv6desc_tE.dh
 4009      81003E03 
 4010 5a00 00000000 		adds.w.sx	%s22,1,%s62
 4010      BE01164A 
 4011 5a08 00000000 		or	%s63,0,%s22
 4011      96003F45 
 4012              	# line 1969
1969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
 4013              		.loc	1 1969 0
 4014 5a10 28000000 		ldl.sx	%s18,40(,%s1)	# *(p).__b_N4conv6desc_tE.sh
 4014      81001203 
 4015 5a18 08200000 		br.l	.L5.0
 4015      00000F18 
 4016              	.L5.1:
 4017              	# line 75
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 4018              		.loc	1 75 0
 4019 5a20 00000000 		divs.w.sx	%s62,%s18,%s63
 4019      BF923E7B 
 4020 5a28 00000000 		muls.w.sx	%s62,%s63,%s62
 4020      BEBF3E4B 
 4021 5a30 00000000 		subs.w.sx	%s18,%s18,%s62
 4021      BE92125A 
 4022 5a38 E81F0000 		br.l	.L5.0
 4022      00000F18 
 4023              	.L5.2:
 4024 5a40 00000000 		or	%s49,0,%s18
 4024      92003145 
 4025 5a48 00000000 		or	%s60,0,%s1
 4025      81003C45 
 4026 5a50 581F0000 		br.l	.L5.3
 4026      00000F18 
 4027              	.L5.4:
 4028              	# line 73
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         if (b == 0) return a;
 4029              		.loc	1 73 0
 4030 5a58 00000000 		divs.w.sx	%s62,%s63,%s18
 4030      92BF3E7B 
 4031 5a60 00000000 		muls.w.sx	%s62,%s18,%s62
 4031      BE923E4B 
 4032 5a68 00000000 		subs.w.sx	%s63,%s63,%s62
 4032      BEBF3F5A 
 4033 5a70 D0FFFFFF 		breq.w	0,%s63,.L5.2
 4033      BF008418 
 4034 5a78 A8FFFFFF 		br.l	.L5.1
 4034      00000F18 
 4035              	.L5.5:
 4036              	# line 75
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 4037              		.loc	1 75 0
 4038 5a80 00000000 		divs.w.sx	%s63,%s18,%s62
 4038      BE923F7B 
 4039 5a88 00000000 		muls.w.sx	%s63,%s62,%s63
 4039      BFBE3F4B 
 4040 5a90 00000000 		subs.w.sx	%s18,%s18,%s63
 4040      BF92125A 
 4041 5a98 281E0000 		br.l	.L5.6
 4041      00000F18 
 4042              	.L5.7:
 4043 5aa0 00000000 		or	%s50,0,%s18
 4043      92003245 
 4044 5aa8 00000000 		or	%s62,0,%s60
 4044      BC003E45 
 4045 5ab0 00000000 		or	%s63,0,%s1
 4045      81003F45 
 4046 5ab8 00000000 		or	%s1,0,%s56
 4046      B8000145 
 4047 5ac0 00000000 		or	%s2,0,%s49
 4047      B1000245 
 4048 5ac8 681D0000 		br.l	.L5.8
 4048      00000F18 
 4049              	.L5.9:
 4050              	# line 73
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         if (b == 0) return a;
 4051              		.loc	1 73 0
 4052 5ad0 00000000 		divs.w.sx	%s61,%s62,%s18
 4052      92BE3D7B 
 4053 5ad8 00000000 		muls.w.sx	%s61,%s18,%s61
 4053      BD923D4B 
 4054 5ae0 00000000 		subs.w.sx	%s62,%s62,%s61
 4054      BDBE3E5A 
 4055 5ae8 B8FFFFFF 		breq.w	0,%s62,.L5.7
 4055      BE008418 
 4056 5af0 90FFFFFF 		br.l	.L5.5
 4056      00000F18 
 4057              	.L5.10:
 4058              	# line 1992
1992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[ih] = (ih + PH) / DH + 1;
 4059              		.loc	1 1992 0
 4060 5af8 80000000 		mins.w.sx	%s55,%s45,%s55
 4060      B7AD3778 
 4061 5b00 00000000 		smvl	%s13
 4061      00000D2E 
 4062 5b08 00000000 		lvl	%s13
 4062      008D00BF 
 4063 5b10 90190000 		br.l	.L5.11
 4063      00000F18 
 4064              	.L5.12:
 4065              	# line 2007
2007:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = (iw + PW) / DW + 1;
 4066              		.loc	1 2007 0
 4067 5b18 80000000 		mins.w.sx	%s57,%s45,%s57
 4067      B9AD3978 
 4068 5b20 00000000 		smvl	%s13
 4068      00000D2E 
 4069 5b28 00000000 		lvl	%s13
 4069      008D00BF 
 4070 5b30 D8160000 		br.l	.L5.13
 4070      00000F18 
 4071              	.L5.14:
 4072              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4073              		.loc	1 2059 0
 4074 5b38 80000000 		mins.w.sx	%s60,%s55,%s60
 4074      BCB73C78 
 4075 5b40 50090000 		br.l	.L5.15
 4075      00000F18 
 4076              	.L5.16:
 4077 5b48 80000000 		mins.w.sx	%s57,%s45,%s57
 4077      B9AD3978 
 4078 5b50 40030000 		br.l	.L5.17
 4078      00000F18 
 4079              	.L5.18:
 4080 5b58 70FDFFFF 		ld	%s55,-656(,%fp)	# restore 
 4080      89003701 
 4081 5b60 68FDFFFF 		ld	%s53,-664(,%fp)	# restore 
 4081      89003501 
 4082 5b68 50FDFFFF 		ld	%s48,-688(,%fp)	# restore 
 4082      89003001 
 4083 5b70 E8FDFFFF 		ld	%s42,-536(,%fp)	# restore 
 4083      89002A01 
 4084 5b78 E0FDFFFF 		ld	%s33,-544(,%fp)	# restore 
 4084      89002101 
 4085 5b80 D8FDFFFF 		ld	%s32,-552(,%fp)	# restore 
 4085      89002001 
 4086 5b88 D0FDFFFF 		ld	%s47,-560(,%fp)	# restore 
 4086      89002F01 
 4087 5b90 C8FDFFFF 		ld	%s46,-568(,%fp)	# restore 
 4087      89002E01 
 4088 5b98 C0FDFFFF 		ld	%s40,-576(,%fp)	# restore 
 4088      89002801 
 4089 5ba0 B8FDFFFF 		ld	%s37,-584(,%fp)	# restore 
 4089      89002501 
 4090 5ba8 B0FDFFFF 		ld	%s36,-592(,%fp)	# restore 
 4090      89002401 
 4091 5bb0 A8FDFFFF 		ld	%s35,-600(,%fp)	# restore 
 4091      89002301 
 4092 5bb8 A0FDFFFF 		ld	%s34,-608(,%fp)	# restore 
 4092      89002201 
 4093 5bc0 98FDFFFF 		ld	%s39,-616(,%fp)	# restore 
 4093      89002701 
 4094 5bc8 90FDFFFF 		ld	%s38,-624(,%fp)	# restore 
 4094      89002601 
 4095 5bd0 88FDFFFF 		ld	%s31,-632(,%fp)	# restore 
 4095      89001F01 
 4096 5bd8 80FDFFFF 		ld	%s30,-640(,%fp)	# restore 
 4096      89001E01 
 4097 5be0 30FDFFFF 		ld	%s44,-720(,%fp)	# restore 
 4097      89002C01 
 4098 5be8 28FDFFFF 		ld	%s5,-728(,%fp)	# restore 
 4098      89000501 
 4099 5bf0 78FDFFFF 		ld	%s19,-648(,%fp)	# restore 
 4099      89001301 
 4100 5bf8 58FDFFFF 		ld	%s18,-680(,%fp)	# restore 
 4100      89001201 
 4101 5c00 38FDFFFF 		ld	%s56,-712(,%fp)	# restore 
 4101      89003801 
 4102 5c08 40FDFFFF 		ld	%s61,-704(,%fp)	# restore 
 4102      89003D01 
 4103 5c10 48FDFFFF 		ld	%s63,-696(,%fp)	# restore 
 4103      89003F01 
 4104 5c18 00FDFFFF 		ld	%s28,-768(,%fp)	# restore 
 4104      89001C01 
 4105 5c20 10FDFFFF 		ld	%s2,-752(,%fp)	# restore 
 4105      89000201 
 4106 5c28 08FDFFFF 		ld	%s29,-760(,%fp)	# restore 
 4106      89001D01 
 4107 5c30 20FDFFFF 		ld	%s4,-736(,%fp)	# restore 
 4107      89000401 
 4108 5c38 18FDFFFF 		ld	%s3,-744(,%fp)	# restore 
 4108      89000301 
 4109 5c40 60FDFFFF 		ld	%s45,-672(,%fp)	# restore 
 4109      89002D01 
 4110 5c48 F8FCFFFF 		ld	%s27,-776(,%fp)	# restore 
 4110      89001B01 
 4111 5c50 F0FCFFFF 		ld	%s26,-784(,%fp)	# restore 
 4111      89001A01 
 4112 5c58 E8FCFFFF 		ld	%s25,-792(,%fp)	# restore 
 4112      89001901 
 4113 5c60 D00F0000 		br.l	.L5.19
 4113      00000F18 
 4114              	.L5.20:
 4115 5c68 F0090000 		br.l	.L5.21
 4115      00000F18 
 4116              	.L5.22:
 4117              	# line 2070
2070:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //w_oc1h += khh*KW;
 4118              		.loc	1 2070 0
 4119 5c70 00000000 		subu.l	%s57,%s57,%s62
 4119      BEB93958 
 4120              	# line 2047
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
 4121              		.loc	1 2047 0
 4122 5c78 00000000 		adds.w.sx	%s55,%s59,%s55
 4122      B7BB374A 
 4123 5c80 00000000 		adds.l	%s53,%s53,%s51
 4123      B3B53559 
 4124 5c88 00000000 		adds.l	%s48,%s48,%s51
 4124      B3B03059 
 4125 5c90 D8FFFFFF 		brgt.w	0,%s55,.L5.20
 4125      B7008118 
 4126 5c98 C0FEFFFF 		br.l	.L5.18
 4126      00000F18 
 4127              	.L5.23:
 4128 5ca0 F0FDFFFF 		st	%s56,-528(,%fp)	# spill 
 4128      89003811 
 4129 5ca8 F8FDFFFF 		st	%s1,-520(,%fp)	# spill 
 4129      89000111 
 4130 5cb0 00FEFFFF 		st	%s44,-512(,%fp)	# spill 
 4130      89002C11 
 4131 5cb8 08FEFFFF 		st	%s43,-504(,%fp)	# spill 
 4131      89002B11 
 4132 5cc0 00000000 		or	%s62,0,%s2
 4132      82003E45 
 4133 5cc8 00000000 		or	%s59,0,%s3
 4133      83003B45 
 4134 5cd0 00000000 		or	%s55,0,%s23
 4134      97003745 
 4135 5cd8 00000000 		or	%s53,0,%s22
 4135      96003545 
 4136 5ce0 00000000 		or	%s51,0,%s24
 4136      98003345 
 4137 5ce8 00000000 		or	%s48,0,%s29
 4137      9D003045 
 4138 5cf0 00000000 		or	%s37,0,%s25
 4138      99002545 
 4139 5cf8 00000000 		or	%s43,0,%s33
 4139      A1002B45 
 4140 5d00 28FEFFFF 		ld	%s34,-472(,%fp)	# restore 
 4140      89002201 
 4141 5d08 00000000 		or	%s42,0,%s32
 4141      A0002A45 
 4142 5d10 18FEFFFF 		ld	%s32,-488(,%fp)	# restore 
 4142      89002001 
 4143 5d18 00000000 		or	%s58,0,%s4
 4143      84003A45 
 4144 5d20 00000000 		or	%s1,0,%s20
 4144      94000145 
 4145 5d28 00000000 		or	%s20,0,%s30
 4145      9E001445 
 4146 5d30 10FEFFFF 		ld	%s30,-496(,%fp)	# restore 
 4146      89001E01 
 4147 5d38 00000000 		or	%s39,0,%s21
 4147      95002745 
 4148 5d40 00000000 		or	%s54,0,%s28
 4148      9C003645 
 4149 5d48 00000000 		or	%s52,0,%s26
 4149      9A003445 
 4150 5d50 00000000 		or	%s49,0,%s40
 4150      A8003145 
 4151 5d58 00000000 		or	%s50,0,%s41
 4151      A9003245 
 4152 5d60 00000000 		or	%s38,0,%s27
 4152      9B002645 
 4153 5d68 38FEFFFF 		ld	%s36,-456(,%fp)	# restore 
 4153      89002401 
 4154 5d70 30FEFFFF 		ld	%s35,-464(,%fp)	# restore 
 4154      89002301 
 4155 5d78 20FEFFFF 		ld	%s33,-480(,%fp)	# restore 
 4155      89002101 
 4156 5d80 F0FEFFFF 		br.l	.L5.22
 4156      00000F18 
 4157              	.L5.24:
 4158              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4159              		.loc	1 2052 0
 4160 5d88 00000000 		adds.w.sx	%s45,4,%s45
 4160      AD042D4A 
 4161 5d90 00000000 		adds.l	%s52,%s52,%s44
 4161      ACB43459 
 4162 5d98 00000000 		adds.l	%s54,%s54,%s44
 4162      ACB63659 
 4163 5da0 00000000 		adds.l	%s50,%s50,%s44
 4163      ACB23259 
 4164 5da8 00000000 		adds.w.sx	%s53,%s53,%s43
 4164      ABB5354A 
 4165 5db0 00000000 		adds.l	%s48,%s48,%s44
 4165      ACB03059 
 4166 5db8 00000000 		adds.w.sx	%s51,%s51,%s43
 4166      ABB3334A 
 4167 5dc0 00000000 		adds.w.sx	%s62,%s62,%s43
 4167      ABBE3E4A 
 4168 5dc8 00000000 		adds.w.sx	%s55,%s55,%s43
 4168      ABB7374A 
 4169 5dd0 A8030000 		brgt.w	0,%s45,.L5.25
 4169      AD008118 
 4170 5dd8 C8FEFFFF 		br.l	.L5.23
 4170      00000F18 
 4171              	.L5.26:
 4172              	# line 2066
2066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ow0 -= lcm_w;
 4173              		.loc	1 2066 0
 4174 5de0 00000000 		or	%s63,1,(0)1
 4174      00013F45 
 4175 5de8 00000000 		adds.l	%s61,%s41,(0)1
 4175      00A93D59 
 4176 5df0 00000000 		adds.l	%s61,%s61,%s40
 4176      A8BD3D59 
 4177 5df8 00000000 		lvl	%s63
 4177      00BF00BF 
 4178 5e00 0000002E 		vstu.nc	%v46,0,%s61
 4178      BD000092 
 4179 5e08 80FFFFFF 		br.l	.L5.24
 4179      00000F18 
 4180              	.L5.27:
 4181 5e10 00000000 		or	%s1,0,%s63
 4181      BF000145 
 4182              	# line 2064
2064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0b + oc*ICOG_KH_KW];
 4183              		.loc	1 2064 0
 4184 5e18 00000000 		lvl	%s61
 4184      00BD00BF 
 4185 5e20 00003C2C 		vfsum.s	%v44,%v60
 4185      000080EC 
 4186 5e28 00000000 		or	%s63,1,(0)1
 4186      00013F45 
 4187 5e30 00000000 		lvl	%s63
 4187      00BF00BF 
 4188 5e38 002C2E2E 		vfadd.s	%v46,%v46,%v44
 4188      000080CC 
 4189 5e40 00000000 		or	%s45,0,%s58
 4189      BA002D45 
 4190 5e48 00000000 		or	%s44,0,%s42
 4190      AA002C45 
 4191 5e50 00000000 		or	%s53,0,%s39
 4191      A7003545 
 4192 5e58 00000000 		or	%s43,0,%s38
 4192      A6002B45 
 4193 5e60 00000000 		or	%s51,0,%s37
 4193      A5003345 
 4194 5e68 00000000 		or	%s62,0,%s36
 4194      A4003E45 
 4195 5e70 00000000 		or	%s55,0,%s35
 4195      A3003745 
 4196 5e78 00000000 		or	%s60,0,%s34
 4196      A2003C45 
 4197 5e80 00000000 		or	%s57,0,%s7
 4197      87003945 
 4198 5e88 58FFFFFF 		br.l	.L5.26
 4198      00000F18 
 4199              	.L5.17:
 4200 5e90 00000000 		or	%s62,0,%s63
 4200      BF003E45 
 4201 5e98 00000000 		or	%s44,0,%s60
 4201      BC002C45 
 4202 5ea0 00000000 		adds.l	%s43,%s59,(0)1
 4202      00BB2B59 
 4203 5ea8 00000000 		adds.l	%s44,%s43,%s44
 4203      ACAB2C59 
 4204 5eb0 00000000 		lvl	%s57
 4204      00B900BF 
 4205 5eb8 0000003B 		vldu.nc	%v59,%s62,%s44
 4205      ACBE0082 
 4206 5ec0 00000000 		or	%s62,0,%s56
 4206      B8003E45 
 4207 5ec8 00000000 		or	%s44,0,%s55
 4207      B7002C45 
 4208 5ed0 00000000 		adds.l	%s43,%s54,(0)1
 4208      00B62B59 
 4209 5ed8 00000000 		adds.l	%s44,%s43,%s44
 4209      ACAB2C59 
 4210 5ee0 0000003A 		vldu.nc	%v58,%s62,%s44
 4210      ACBE0082 
 4211 5ee8 00000000 		or	%s62,0,%s63
 4211      BF003E45 
 4212 5ef0 00000000 		or	%s44,0,%s60
 4212      BC002C45 
 4213 5ef8 00000000 		adds.l	%s43,%s53,(0)1
 4213      00B52B59 
 4214 5f00 00000000 		adds.l	%s44,%s43,%s44
 4214      ACAB2C59 
 4215 5f08 00000039 		vldu.nc	%v57,%s62,%s44
 4215      ACBE0082 
 4216 5f10 00000000 		or	%s62,0,%s56
 4216      B8003E45 
 4217 5f18 00000000 		or	%s44,0,%s55
 4217      B7002C45 
 4218 5f20 00000000 		adds.l	%s43,%s52,(0)1
 4218      00B42B59 
 4219 5f28 00000000 		adds.l	%s44,%s43,%s44
 4219      ACAB2C59 
 4220 5f30 00000038 		vldu.nc	%v56,%s62,%s44
 4220      ACBE0082 
 4221 5f38 00383937 		vfmul.s	%v55,%v57,%v56
 4221      000080CD 
 4222 5f40 3B3A3736 		vfmad.s	%v54,%v55,%v58,%v59
 4222      000080E2 
 4223 5f48 00000000 		or	%s62,0,%s63
 4223      BF003E45 
 4224 5f50 00000000 		or	%s44,0,%s60
 4224      BC002C45 
 4225 5f58 00000000 		adds.l	%s43,%s51,(0)1
 4225      00B32B59 
 4226 5f60 00000000 		adds.l	%s44,%s43,%s44
 4226      ACAB2C59 
 4227 5f68 00000035 		vldu.nc	%v53,%s62,%s44
 4227      ACBE0082 
 4228 5f70 00000000 		or	%s62,0,%s56
 4228      B8003E45 
 4229 5f78 00000000 		or	%s44,0,%s55
 4229      B7002C45 
 4230 5f80 00000000 		adds.l	%s43,%s50,(0)1
 4230      00B22B59 
 4231 5f88 00000000 		adds.l	%s44,%s43,%s44
 4231      ACAB2C59 
 4232 5f90 00000034 		vldu.nc	%v52,%s62,%s44
 4232      ACBE0082 
 4233 5f98 35343633 		vfmad.s	%v51,%v54,%v52,%v53
 4233      000080E2 
 4234 5fa0 00000000 		or	%s62,0,%s63
 4234      BF003E45 
 4235 5fa8 00000000 		or	%s44,0,%s60
 4235      BC002C45 
 4236 5fb0 00000000 		adds.l	%s43,%s49,(0)1
 4236      00B12B59 
 4237 5fb8 00000000 		adds.l	%s44,%s43,%s44
 4237      ACAB2C59 
 4238 5fc0 00000032 		vldu.nc	%v50,%s62,%s44
 4238      ACBE0082 
 4239 5fc8 00000000 		or	%s62,0,%s56
 4239      B8003E45 
 4240 5fd0 00000000 		or	%s44,0,%s55
 4240      B7002C45 
 4241 5fd8 00000000 		adds.l	%s43,%s48,(0)1
 4241      00B02B59 
 4242 5fe0 00000000 		adds.l	%s44,%s43,%s44
 4242      ACAB2C59 
 4243 5fe8 00000031 		vldu.nc	%v49,%s62,%s44
 4243      ACBE0082 
 4244 5ff0 32313330 		vfmad.s	%v48,%v51,%v49,%v50
 4244      000080E2 
 4245 5ff8 00303C3C 		vfadd.s	%v60,%v60,%v48
 4245      000080CC 
 4246              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4247              		.loc	1 2059 0
 4248 6000 00000000 		adds.w.sx	%s60,%s60,%s47
 4248      AFBC3C4A 
 4249 6008 00000000 		adds.w.sx	%s55,%s55,%s46
 4249      AEB7374A 
 4250 6010 00000000 		subs.w.sx	%s45,%s45,%s57
 4250      B9AD2D5A 
 4251 6018 F8FDFFFF 		brge.w	0,%s45,.L5.27
 4251      AD008518 
 4252 6020 28FBFFFF 		br.l	.L5.16
 4252      00000F18 
 4253              	.L5.28:
 4254 6028 00000000 		or	%s6,0,%s59
 4254      BB000645 
 4255 6030 00000000 		muls.l	%s6,4,%s6
 4255      8604066E 
 4256 6038 00000000 		or	%s63,0,%s1
 4256      81003F45 
 4257 6040 00000000 		or	%s34,0,%s60
 4257      BC002245 
 4258 6048 00000000 		adds.l	%s59,%s6,%s33
 4258      A1863B59 
 4259 6050 00000000 		or	%s6,0,%s49
 4259      B1000645 
 4260 6058 00000000 		muls.l	%s6,4,%s6
 4260      8604066E 
 4261 6060 00000000 		or	%s7,0,%s57
 4261      B9000745 
 4262 6068 00000000 		or	%s35,0,%s55
 4262      B7002345 
 4263 6070 00000000 		adds.l	%s6,%s33,%s6
 4263      86A10659 
 4264 6078 00000000 		or	%s5,0,%s47
 4264      AF000545 
 4265 6080 00000000 		muls.l	%s5,4,%s5
 4265      8504056E 
 4266 6088 00000000 		or	%s36,0,%s62
 4266      BE002445 
 4267 6090 00000000 		or	%s37,0,%s51
 4267      B3002545 
 4268 6098 00000000 		adds.l	%s51,%s33,%s5
 4268      85A13359 
 4269 60a0 00000000 		or	%s62,0,%s46
 4269      AE003E45 
 4270 60a8 00000000 		muls.l	%s62,4,%s62
 4270      BE043E6E 
 4271 60b0 00000000 		or	%s39,0,%s53
 4271      B5002745 
 4272 60b8 00000000 		or	%s58,0,%s45
 4272      AD003A45 
 4273 60c0 00000000 		adds.l	%s49,%s33,%s62
 4273      BEA13159 
 4274 60c8 00000000 		subs.w.sx	%s62,0,%s32
 4274      A0003E5A 
 4275 60d0 00000000 		smvl	%s61
 4275      00003D2E 
 4276 60d8 80000000 		mins.w.sx	%s57,%s62,%s61
 4276      BDBE3978 
 4277              	# line 2064
2064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0b + oc*ICOG_KH_KW];
 4278              		.loc	1 2064 0
 4279 60e0 00000000 		or	%s5,0,(0)1
 4279      00000545 
 4280 60e8 00000000 		or	%s42,0,%s44
 4280      AC002A45 
 4281 60f0 00000000 		or	%s38,0,%s43
 4281      AB002645 
 4282 60f8 00000000 		or	%s53,0,%s6
 4282      86003545 
 4283 6100 00000000 		lvl	%s61
 4283      00BD00BF 
 4284 6108 0000003C 		vbrdu	%v60,%s5
 4284      0085808C 
 4285 6110 00000000 		or	%s45,0,%s62
 4285      BE002D45 
 4286              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4287              		.loc	1 2059 0
 4288 6118 00000000 		or	%s60,0,(0)1
 4288      00003C45 
 4289 6120 00000000 		muls.w.sx	%s47,%s1,%s57
 4289      B9812F4B 
 4290 6128 00000000 		or	%s55,0,(0)1
 4290      00003745 
 4291 6130 00000000 		muls.w.sx	%s46,%s56,%s57
 4291      B9B82E4B 
 4292 6138 58FDFFFF 		br.l	.L5.17
 4292      00000F18 
 4293              	.L5.29:
 4294 6140 00000000 		or	%s42,1,(0)1
 4294      00012A45 
 4295 6148 00000000 		adds.l	%s39,%s41,(0)1
 4295      00A92759 
 4296 6150 00000000 		adds.l	%s39,%s39,%s40
 4296      A8A72759 
 4297 6158 00000000 		lvl	%s42
 4297      00AA00BF 
 4298 6160 0000002E 		vldu.nc	%v46,0,%s39
 4298      A7000082 
 4299 6168 C0FEFFFF 		brlt.w	0,%s18,.L5.28
 4299      92008218 
 4300 6170 70FCFFFF 		br.l	.L5.26
 4300      00000F18 
 4301              	.L5.25:
 4302 6178 00000000 		divs.w.sx	%s59,%s62,%s60
 4302      BCBE3B7B 
 4303 6180 00000000 		or	%s59,0,%s59
 4303      BB003B45 
 4304 6188 00000000 		divs.w.sx	%s49,%s55,%s60
 4304      BCB7317B 
 4305 6190 00000000 		or	%s49,0,%s49
 4305      B1003145 
 4306 6198 00000000 		divs.w.sx	%s47,%s53,%s60
 4306      BCB52F7B 
 4307 61a0 00000000 		or	%s47,0,%s47
 4307      AF002F45 
 4308 61a8 00000000 		divs.w.sx	%s46,%s51,%s60
 4308      BCB32E7B 
 4309 61b0 00000000 		or	%s46,0,%s46
 4309      AE002E45 
 4310 61b8 00000000 		addu.l	%s59,%s59,%s57
 4310      B9BB3B48 
 4311 61c0 00000000 		addu.l	%s49,%s49,%s57
 4311      B9B13148 
 4312 61c8 00000000 		addu.l	%s47,%s47,%s57
 4312      B9AF2F48 
 4313 61d0 00000000 		addu.l	%s46,%s46,%s57
 4313      B9AE2E48 
 4314 61d8 68FFFFFF 		brlt.w	0,%s18,.L5.29
 4314      92008218 
 4315 61e0 A8FBFFFF 		br.l	.L5.24
 4315      00000F18 
 4316              	.L5.30:
 4317 61e8 00000000 		or	%s63,0,%s20
 4317      94003F45 
 4318 61f0 38FEFFFF 		st	%s36,-456(,%fp)	# spill 
 4318      89002411 
 4319 61f8 30FEFFFF 		st	%s35,-464(,%fp)	# spill 
 4319      89002311 
 4320 6200 28FEFFFF 		st	%s34,-472(,%fp)	# spill 
 4320      89002211 
 4321 6208 20FEFFFF 		st	%s33,-480(,%fp)	# spill 
 4321      89002111 
 4322 6210 18FEFFFF 		st	%s32,-488(,%fp)	# spill 
 4322      89002011 
 4323 6218 10FEFFFF 		st	%s30,-496(,%fp)	# spill 
 4323      89001E11 
 4324              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4325              		.loc	1 2052 0
 4326 6220 00000000 		adds.w.sx	%s45,%s20,%s31
 4326      9F942D4A 
 4327 6228 00000000 		adds.l	%s36,%s48,%s36
 4327      A4B02459 
 4328 6230 00000000 		muls.l	%s61,%s63,%s54
 4328      B6BF3D6E 
 4329 6238 00000000 		or	%s40,0,%s49
 4329      B1002845 
 4330 6240 00000000 		or	%s41,0,%s50
 4330      B2002945 
 4331 6248 00000000 		adds.l	%s61,%s36,%s61
 4331      BDA43D59 
 4332 6250 00000000 		adds.l	%s49,%s48,%s38
 4332      A6B03159 
 4333 6258 00000000 		muls.l	%s47,%s63,%s54
 4333      B6BF2F6E 
 4334 6260 00000000 		or	%s2,0,%s62
 4334      BE000245 
 4335 6268 00000000 		or	%s3,0,%s59
 4335      BB000345 
 4336 6270 00000000 		adds.l	%s47,%s49,%s47
 4336      AFB12F59 
 4337 6278 00000000 		adds.l	%s35,%s48,%s35
 4337      A3B02359 
 4338 6280 00000000 		muls.l	%s59,%s63,%s54
 4338      B6BF3B6E 
 4339 6288 00000000 		or	%s4,0,%s58
 4339      BA000445 
 4340 6290 00000000 		or	%s21,0,%s39
 4340      A7001545 
 4341 6298 00000000 		adds.l	%s50,%s35,%s59
 4341      BBA33259 
 4342 62a0 00000000 		muls.w.sx	%s59,%s20,%s52
 4342      B4943B4B 
 4343 62a8 00000000 		or	%s22,0,%s53
 4343      B5001645 
 4344 62b0 00000000 		or	%s23,0,%s55
 4344      B7001745 
 4345 62b8 00000000 		adds.w.sx	%s53,%s59,%s34
 4345      A2BB354A 
 4346 62c0 00000000 		adds.l	%s59,%s48,%s33
 4346      A1B03B59 
 4347 62c8 00000000 		muls.l	%s63,%s63,%s54
 4347      B6BF3F6E 
 4348 62d0 00000000 		or	%s33,0,%s43
 4348      AB002145 
 4349 62d8 00000000 		or	%s24,0,%s51
 4349      B3001845 
 4350 62e0 00000000 		adds.l	%s63,%s59,%s63
 4350      BFBB3F59 
 4351 62e8 00000000 		muls.w.sx	%s59,%s20,%s52
 4351      B4943B4B 
 4352 62f0 00000000 		or	%s25,0,%s37
 4352      A5001945 
 4353 62f8 00000000 		or	%s26,0,%s52
 4353      B4001A45 
 4354 6300 00000000 		adds.w.sx	%s51,%s59,%s32
 4354      A0BB334A 
 4355 6308 00000000 		muls.w.sx	%s59,%s20,%s52
 4355      B4943B4B 
 4356 6310 00000000 		or	%s32,0,%s42
 4356      AA002045 
 4357 6318 00000000 		or	%s27,0,%s38
 4357      A6001B45 
 4358 6320 00000000 		adds.w.sx	%s62,%s59,%s37
 4358      A5BB3E4A 
 4359 6328 00000000 		muls.w.sx	%s59,%s20,%s52
 4359      B4943B4B 
 4360 6330 00000000 		or	%s52,0,%s61
 4360      BD003445 
 4361 6338 00000000 		or	%s28,0,%s54
 4361      B6001C45 
 4362 6340 00000000 		adds.w.sx	%s55,%s59,%s30
 4362      9EBB374A 
 4363 6348 00000000 		or	%s54,0,%s47
 4363      AF003645 
 4364 6350 00000000 		or	%s29,0,%s48
 4364      B0001D45 
 4365 6358 00000000 		or	%s48,0,%s63
 4365      BF003045 
 4366 6360 00000000 		or	%s30,0,%s20
 4366      94001E45 
 4367 6368 00000000 		or	%s20,0,%s1
 4367      81001445 
 4368 6370 08FEFFFF 		ld	%s43,-504(,%fp)	# restore 
 4368      89002B01 
 4369 6378 00FEFFFF 		ld	%s44,-512(,%fp)	# restore 
 4369      89002C01 
 4370 6380 F8FDFFFF 		ld	%s1,-520(,%fp)	# restore 
 4370      89000101 
 4371 6388 F0FDFFFF 		ld	%s56,-528(,%fp)	# restore 
 4371      89003801 
 4372 6390 E8FDFFFF 		br.l	.L5.25
 4372      00000F18 
 4373              	.L5.31:
 4374 6398 50FEFFFF 		brlt.w	%s20,%s19,.L5.30
 4374      93948218 
 4375 63a0 D0F8FFFF 		br.l	.L5.22
 4375      00000F18 
 4376              	.L5.32:
 4377 63a8 00000000 		or	%s62,0,%s2
 4377      82003E45 
 4378 63b0 00000000 		or	%s59,0,%s3
 4378      83003B45 
 4379 63b8 00000000 		or	%s48,0,%s4
 4379      84003045 
 4380 63c0 00000000 		or	%s53,0,%s7
 4380      87003545 
 4381 63c8 00000000 		or	%s55,0,%s5
 4381      85003745 
 4382 63d0 00000000 		or	%s51,0,%s6
 4382      86003345 
 4383 63d8 C0FFFFFF 		br.l	.L5.31
 4383      00000F18 
 4384              	.L5.33:
 4385 63e0 00000000 		adds.w.sx	%s55,1,%s55
 4385      B701374A 
 4386 63e8 00000000 		adds.l	%s53,%s54,%s53
 4386      B5B63559 
 4387 63f0 00000000 		adds.w.sx	%s62,%s52,%s62
 4387      BEB43E4A 
 4388 63f8 D0010000 		brgt.w	0,%s55,.L5.34
 4388      B7008118 
 4389 6400 A8FFFFFF 		br.l	.L5.32
 4389      00000F18 
 4390              	.L5.35:
 4391              	# line 2066
2066:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ow0 -= lcm_w;
 4392              		.loc	1 2066 0
 4393 6408 00000000 		or	%s63,1,(0)1
 4393      00013F45 
 4394 6410 00000000 		adds.l	%s61,%s50,(0)1
 4394      00B23D59 
 4395 6418 00000000 		adds.l	%s61,%s61,%s49
 4395      B1BD3D59 
 4396 6420 00000000 		lvl	%s63
 4396      00BF00BF 
 4397 6428 0000002F 		vstu.nc	%v47,0,%s61
 4397      BD000092 
 4398 6430 B0FFFFFF 		br.l	.L5.33
 4398      00000F18 
 4399              	.L5.36:
 4400 6438 00000000 		or	%s1,0,%s61
 4400      BD000145 
 4401              	# line 2064
2064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0b + oc*ICOG_KH_KW];
 4402              		.loc	1 2064 0
 4403 6440 00000000 		lvl	%s51
 4403      00B300BF 
 4404 6448 00003F2D 		vfsum.s	%v45,%v63
 4404      000080EC 
 4405 6450 00000000 		or	%s63,1,(0)1
 4405      00013F45 
 4406 6458 00000000 		lvl	%s63
 4406      00BF00BF 
 4407 6460 002D2F2F 		vfadd.s	%v47,%v47,%v45
 4407      000080CC 
 4408 6468 00000000 		or	%s55,0,%s48
 4408      B0003745 
 4409 6470 00000000 		or	%s62,0,%s47
 4409      AF003E45 
 4410 6478 00000000 		or	%s60,0,%s46
 4410      AE003C45 
 4411 6480 00000000 		or	%s57,0,%s45
 4411      AD003945 
 4412 6488 80FFFFFF 		br.l	.L5.35
 4412      00000F18 
 4413              	.L5.15:
 4414 6490 00000000 		or	%s62,0,%s63
 4414      BF003E45 
 4415 6498 00000000 		lvl	%s60
 4415      00BC00BF 
 4416 64a0 0000003E 		vldu.nc	%v62,%s61,%s62
 4416      BEBD0082 
 4417 64a8 00000000 		or	%s62,0,%s59
 4417      BB003E45 
 4418 64b0 0000003D 		vldu.nc	%v61,%s58,%s62
 4418      BEBA0082 
 4419 64b8 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 4419      000080E2 
 4420              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4421              		.loc	1 2059 0
 4422 64c0 00000000 		adds.l	%s63,%s63,%s57
 4422      B9BF3F59 
 4423 64c8 00000000 		adds.l	%s59,%s59,%s56
 4423      B8BB3B59 
 4424 64d0 00000000 		subs.w.sx	%s55,%s55,%s60
 4424      BCB7375A 
 4425 64d8 60FFFFFF 		brge.w	0,%s55,.L5.36
 4425      B7008518 
 4426 64e0 58F6FFFF 		br.l	.L5.14
 4426      00000F18 
 4427              	.L5.37:
 4428 64e8 00000000 		or	%s44,0,%s59
 4428      BB002C45 
 4429 64f0 00000000 		muls.l	%s44,4,%s44
 4429      AC042C6E 
 4430 64f8 00000000 		or	%s61,0,%s1
 4430      81003D45 
 4431 6500 00000000 		or	%s46,0,%s60
 4431      BC002E45 
 4432 6508 00000000 		adds.l	%s44,%s44,%s43
 4432      ABAC2C59 
 4433 6510 00000000 		subs.w.sx	%s41,0,%s42
 4433      AA00295A 
 4434 6518 00000000 		smvl	%s51
 4434      0000332E 
 4435 6520 80000000 		mins.w.sx	%s60,%s41,%s51
 4435      B3A93C78 
 4436              	# line 2064
2064:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //ds += pdiff_dst[d_oc0b + oc*OH_OW] * pwei[w_oc0b + oc*ICOG_KH_KW];
 4437              		.loc	1 2064 0
 4438 6528 00000000 		or	%s40,0,(0)1
 4438      00002845 
 4439 6530 00000000 		or	%s45,0,%s57
 4439      B9002D45 
 4440 6538 00000000 		or	%s47,0,%s62
 4440      BE002F45 
 4441 6540 00000000 		or	%s48,0,%s55
 4441      B7003045 
 4442 6548 00000000 		lvl	%s51
 4442      00B300BF 
 4443 6550 0000003F 		vbrdu	%v63,%s40
 4443      00A8808C 
 4444 6558 00000000 		or	%s55,0,%s41
 4444      A9003745 
 4445 6560 00000000 		or	%s62,0,%s60
 4445      BC003E45 
 4446 6568 00000000 		or	%s63,0,%s44
 4446      AC003F45 
 4447              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4448              		.loc	1 2059 0
 4449 6570 00000000 		muls.l	%s57,%s1,%s62
 4449      BE81396E 
 4450 6578 00000000 		or	%s59,0,%s53
 4450      B5003B45 
 4451 6580 00000000 		muls.l	%s56,%s58,%s62
 4451      BEBA386E 
 4452 6588 08FFFFFF 		br.l	.L5.15
 4452      00000F18 
 4453              	.L5.38:
 4454 6590 00000000 		or	%s51,1,(0)1
 4454      00013345 
 4455 6598 00000000 		adds.l	%s48,%s50,(0)1
 4455      00B23059 
 4456 65a0 00000000 		adds.l	%s48,%s48,%s49
 4456      B1B03059 
 4457 65a8 00000000 		lvl	%s51
 4457      00B300BF 
 4458 65b0 0000002F 		vldu.nc	%v47,0,%s48
 4458      B0000082 
 4459 65b8 30FFFFFF 		brlt.w	0,%s18,.L5.37
 4459      92008218 
 4460 65c0 48FEFFFF 		br.l	.L5.35
 4460      00000F18 
 4461              	.L5.34:
 4462 65c8 00000000 		divs.w.sx	%s59,%s62,%s60
 4462      BCBE3B7B 
 4463 65d0 00000000 		or	%s59,0,%s59
 4463      BB003B45 
 4464 65d8 00000000 		addu.l	%s59,%s59,%s57
 4464      B9BB3B48 
 4465 65e0 B0FFFFFF 		brlt.w	0,%s18,.L5.38
 4465      92008218 
 4466 65e8 F8FDFFFF 		br.l	.L5.33
 4466      00000F18 
 4467              	.L5.39:
 4468 65f0 00000000 		or	%s2,0,%s62
 4468      BE000245 
 4469 65f8 00000000 		or	%s3,0,%s59
 4469      BB000345 
 4470 6600 00000000 		or	%s4,0,%s48
 4470      B0000445 
 4471 6608 00000000 		or	%s5,0,%s55
 4471      B7000545 
 4472 6610 00000000 		or	%s55,0,%s39
 4472      A7003745 
 4473              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4474              		.loc	1 2052 0
 4475 6618 00000000 		adds.l	%s63,%s53,%s38
 4475      A6B53F59 
 4476 6620 00000000 		or	%s6,0,%s51
 4476      B3000645 
 4477 6628 00000000 		or	%s7,0,%s53
 4477      B5000745 
 4478 6630 00000000 		or	%s53,0,%s63
 4478      BF003545 
 4479 6638 00000000 		or	%s62,0,%s37
 4479      A5003E45 
 4480 6640 88FFFFFF 		br.l	.L5.34
 4480      00000F18 
 4481              	.L5.40:
 4482 6648 A8FFFFFF 		brlt.w	0,%s20,.L5.39
 4482      94008218 
 4483 6650 48FDFFFF 		br.l	.L5.31
 4483      00000F18 
 4484              	.L5.21:
 4485 6658 F0FFFFFF 		brlt.w	0,%s19,.L5.40
 4485      93008218 
 4486 6660 10F6FFFF 		br.l	.L5.22
 4486      00000F18 
 4487              	.L5.41:
 4488 6668 E8FDFFFF 		st	%s42,-536(,%fp)	# spill 
 4488      89002A11 
 4489 6670 E0FDFFFF 		st	%s33,-544(,%fp)	# spill 
 4489      89002111 
 4490 6678 D8FDFFFF 		st	%s32,-552(,%fp)	# spill 
 4490      89002011 
 4491 6680 D0FDFFFF 		st	%s47,-560(,%fp)	# spill 
 4491      89002F11 
 4492 6688 C8FDFFFF 		st	%s46,-568(,%fp)	# spill 
 4492      89002E11 
 4493 6690 C0FDFFFF 		st	%s40,-576(,%fp)	# spill 
 4493      89002811 
 4494 6698 B8FDFFFF 		st	%s37,-584(,%fp)	# spill 
 4494      89002511 
 4495 66a0 B0FDFFFF 		st	%s36,-592(,%fp)	# spill 
 4495      89002411 
 4496 66a8 A8FDFFFF 		st	%s35,-600(,%fp)	# spill 
 4496      89002311 
 4497 66b0 A0FDFFFF 		st	%s34,-608(,%fp)	# spill 
 4497      89002211 
 4498 66b8 98FDFFFF 		st	%s39,-616(,%fp)	# spill 
 4498      89002711 
 4499 66c0 90FDFFFF 		st	%s38,-624(,%fp)	# spill 
 4499      89002611 
 4500 66c8 88FDFFFF 		st	%s31,-632(,%fp)	# spill 
 4500      89001F11 
 4501 66d0 80FDFFFF 		st	%s30,-640(,%fp)	# spill 
 4501      89001E11 
 4502 66d8 78FDFFFF 		st	%s19,-648(,%fp)	# spill 
 4502      89001311 
 4503 66e0 70FDFFFF 		st	%s55,-656(,%fp)	# spill 
 4503      89003711 
 4504 66e8 68FDFFFF 		st	%s53,-664(,%fp)	# spill 
 4504      89003511 
 4505 66f0 60FDFFFF 		st	%s45,-672(,%fp)	# spill 
 4505      89002D11 
 4506 66f8 58FDFFFF 		st	%s18,-680(,%fp)	# spill 
 4506      89001211 
 4507 6700 50FDFFFF 		st	%s48,-688(,%fp)	# spill 
 4507      89003011 
 4508 6708 48FDFFFF 		st	%s63,-696(,%fp)	# spill 
 4508      89003F11 
 4509 6710 40FDFFFF 		st	%s61,-704(,%fp)	# spill 
 4509      89003D11 
 4510 6718 38FDFFFF 		st	%s56,-712(,%fp)	# spill 
 4510      89003811 
 4511 6720 30FDFFFF 		st	%s44,-720(,%fp)	# spill 
 4511      89002C11 
 4512 6728 28FDFFFF 		st	%s5,-728(,%fp)	# spill 
 4512      89000511 
 4513 6730 20FDFFFF 		st	%s4,-736(,%fp)	# spill 
 4513      89000411 
 4514 6738 18FDFFFF 		st	%s3,-744(,%fp)	# spill 
 4514      89000311 
 4515 6740 10FDFFFF 		st	%s2,-752(,%fp)	# spill 
 4515      89000211 
 4516 6748 08FDFFFF 		st	%s29,-760(,%fp)	# spill 
 4516      89001D11 
 4517 6750 00FDFFFF 		st	%s28,-768(,%fp)	# spill 
 4517      89001C11 
 4518 6758 F8FCFFFF 		st	%s27,-776(,%fp)	# spill 
 4518      89001B11 
 4519 6760 F0FCFFFF 		st	%s26,-784(,%fp)	# spill 
 4519      89001A11 
 4520 6768 E8FCFFFF 		st	%s25,-792(,%fp)	# spill 
 4520      89001911 
 4521 6770 00000000 		or	%s47,0,%s20
 4521      94002F45 
 4522 6778 00000000 		muls.w.sx	%s63,%s20,%s63
 4522      BF943F4B 
 4523 6780 00000000 		subs.w.sx	%s37,%s48,%s63
 4523      BFB0255A 
 4524              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4525              		.loc	1 2059 0
 4526 6788 00000000 		subs.w.sx	%s30,%s37,%s61
 4526      BDA51E5A 
 4527              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4528              		.loc	1 2052 0
 4529 6790 00000000 		adds.w.sx	%s21,-1,%s21
 4529      957F154A 
 4530 6798 00000000 		subs.w.sx	%s21,%s21,%s20
 4530      9495155A 
 4531 67a0 00000000 		adds.w.sx	%s21,%s21,%s56
 4531      B895154A 
 4532 67a8 00000000 		divs.w.sx	%s19,%s21,%s56
 4532      B895137B 
 4533 67b0 00000000 		subs.w.sx	%s31,0,%s19
 4533      93001F5A 
 4534 67b8 00000000 		and	%s20,%s19,(62)0
 4534      7E931444 
 4535 67c0 00000000 		subs.w.sx	%s39,0,%s20
 4535      9400275A 
 4536              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4537              		.loc	1 2059 0
 4538 67c8 00000000 		divs.w.sx	%s5,%s44,%s5
 4538      85AC057B 
 4539 67d0 00000000 		subs.w.sx	%s42,0,%s5
 4539      85002A5A 
 4540 67d8 00000000 		or	%s63,0,%s18
 4540      92003F45 
 4541              	# line 2047
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
 4542              		.loc	1 2047 0
 4543 67e0 00000000 		adds.w.sx	%s55,%s18,%s4
 4543      8492374A 
 4544 67e8 00000000 		or	%s7,0,%s7
 4544      87000745 
 4545 67f0 00000000 		muls.l	%s7,4,%s7
 4545      8704076E 
 4546 67f8 00000000 		or	%s18,0,%s5
 4546      85001245 
 4547              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4548              		.loc	1 2052 0
 4549 6800 00000000 		muls.l	%s47,4,%s47
 4549      AF042F6E 
 4550              	# line 2047
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
 4551              		.loc	1 2047 0
 4552 6808 00000000 		muls.l	%s61,%s63,%s3
 4552      83BF3D6E 
 4553 6810 00000000 		adds.l	%s53,%s7,%s61
 4553      BD873559 
 4554 6818 00000000 		muls.l	%s3,%s63,%s3
 4554      83BF036E 
 4555 6820 00000000 		adds.l	%s48,%s7,%s3
 4555      83873059 
 4556              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4557              		.loc	1 2052 0
 4558 6828 00000000 		adds.w.sx	%s34,%s37,%s2
 4558      82A5224A 
 4559 6830 00000000 		adds.w.sx	%s32,%s37,%s29
 4559      9DA5204A 
 4560 6838 00000000 		adds.l	%s38,%s47,%s28
 4560      9CAF2659 
 4561 6840 00000000 		adds.l	%s36,%s47,%s27
 4561      9BAF2459 
 4562 6848 00000000 		adds.l	%s35,%s47,%s26
 4562      9AAF2359 
 4563 6850 00000000 		adds.l	%s33,%s47,%s25
 4563      99AF2159 
 4564 6858 00FEFFFF 		br.l	.L5.21
 4564      00000F18 
 4565              	.L5.42:
 4566              	# line 2043
2043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const size_t w_oc00 = wei_off_f(p, g, 0, ic, 0, 0);
 4567              		.loc	1 2043 0
 4568 6860 00000000 		divs.w.sx	%s41,%s45,%s42
 4568      AAAD297B 
 4569 6868 00000000 		or	%s41,0,%s41
 4569      A9002945 
 4570 6870 00000000 		addu.l	%s41,%s41,%s40
 4570      A8A92948 
 4571              	# line 2044
2044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // using next line is maybe a wee bit slower
 4572              		.loc	1 2044 0
 4573 6878 00000000 		divu.l	%s7,%s39,%s38
 4573      A6A7076F 
 4574              	# line 2043
2043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const size_t w_oc00 = wei_off_f(p, g, 0, ic, 0, 0);
 4575              		.loc	1 2043 0
 4576 6880 00000000 		mulu.l	%s41,%s41,%s37
 4576      A5A92949 
 4577 6888 00000000 		divs.w.sx	%s6,%s36,%s35
 4577      A3A4067B 
 4578 6890 00000000 		or	%s6,0,%s6
 4578      86000645 
 4579 6898 00000000 		addu.l	%s6,%s41,%s6
 4579      86A90648 
 4580 68a0 00000000 		mulu.l	%s57,%s6,%s34
 4580      A2863949 
 4581              	# line 2044
2044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // using next line is maybe a wee bit slower
 4582              		.loc	1 2044 0
 4583 68a8 00000000 		mulu.l	%s7,%s7,%s33
 4583      A1870749 
 4584 68b0 00000000 		divu.l	%s7,%s7,%s38
 4584      A687076F 
 4585 68b8 00000000 		addu.l	%s7,%s7,%s32
 4585      A0870748 
 4586 68c0 00000000 		mulu.l	%s7,%s7,%s31
 4586      9F870749 
 4587 68c8 00000000 		mulu.l	%s7,%s7,%s30
 4587      9E870749 
 4588 68d0 98FDFFFF 		brlt.w	%s18,%s19,.L5.41
 4588      93928218 
 4589 68d8 58030000 		br.l	.L5.19
 4589      00000F18 
 4590              	.L5.43:
 4591              	# line 2038
2038:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = kwe[iw];
 4592              		.loc	1 2038 0
 4593 68e0 00000000 		ldl.sx	%s20,0(%s49,%s47)	# *(kwb)
 4593      AFB11403 
 4594              	# line 2039
2039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
 4595              		.loc	1 2039 0
 4596 68e8 00000000 		ldl.sx	%s21,0(%s49,%s46)	# *(kwe)
 4596      AEB11503 
 4597 68f0 40030000 		brge.w	%s20,%s21,.L5.19
 4597      95948518 
 4598 68f8 68FFFFFF 		br.l	.L5.42
 4598      00000F18 
 4599              	.L5.44:
 4600 6900 00000000 		lea	%s63,__eh_curr_region@LO
 4600      00003F06 
 4601 6908 00000000 		and	%s63,%s63,(32)0
 4601      60BF3F44 
 4602 6910 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 4602      BF00BF06 
 4603 6918 70FEFFFF 		ld2b.zx	%s62,-400(,%fp)
 4603      8900BE04 
 4604 6920 00000000 		st2b	%s62,0(,%s63)
 4604      BF003E14 
 4605 6928 48FEFFFF 		ld	%s63,-440(,%fp)
 4605      89003F01 
 4606 6930 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 4606      00003E06 
 4607 6938 00000000 		and	%s62,%s62,(32)0
 4607      60BE3E44 
 4608 6940 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 4608      BE00BE06 
 4609 6948 00000000 		st	%s63,0(,%s62)
 4609      BE003F11 
 4610              	# line 2097
2097:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 4611              		.loc	1 2097 0
 4612 6950 00000000 		lea	%s0,conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 4612      00000006 
 4613 6958 00000000 		and	%s0,%s0,(32)0
 4613      60800044 
 4614 6960 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 4614      80008006 
 4615 6968 08000000 		ld	%s1,8(,%fp)	# ptr
 4615      89000101 
 4616 6970 00000000 		lea	%s12,__ftrace_func_exit@LO
 4616      00000C06 
 4617 6978 00000000 		and	%s12,%s12,(32)0
 4617      608C0C44 
 4618 6980 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 4618      8C008C06 
 4619 6988 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 4619      8C000A08 
 4620              	# Start of epilogue codes
 4621 6990 30000000 		ld	%s18,48(,%fp)
 4621      89001201 
 4622 6998 38000000 		ld	%s19,56(,%fp)
 4622      89001301 
 4623 69a0 40000000 		ld	%s20,64(,%fp)
 4623      89001401 
 4624 69a8 48000000 		ld	%s21,72(,%fp)
 4624      89001501 
 4625 69b0 50000000 		ld	%s22,80(,%fp)
 4625      89001601 
 4626 69b8 58000000 		ld	%s23,88(,%fp)
 4626      89001701 
 4627 69c0 60000000 		ld	%s24,96(,%fp)
 4627      89001801 
 4628 69c8 68000000 		ld	%s25,104(,%fp)
 4628      89001901 
 4629 69d0 70000000 		ld	%s26,112(,%fp)
 4629      89001A01 
 4630 69d8 78000000 		ld	%s27,120(,%fp)
 4630      89001B01 
 4631 69e0 80000000 		ld	%s28,128(,%fp)
 4631      89001C01 
 4632 69e8 88000000 		ld	%s29,136(,%fp)
 4632      89001D01 
 4633 69f0 90000000 		ld	%s30,144(,%fp)
 4633      89001E01 
 4634 69f8 98000000 		ld	%s31,152(,%fp)
 4634      89001F01 
 4635 6a00 A0000000 		ld	%s32,160(,%fp)
 4635      89002001 
 4636 6a08 A8000000 		ld	%s33,168(,%fp)
 4636      89002101 
 4637 6a10 00000000 		or	%sp,0,%fp
 4637      89000B45 
 4638              		.cfi_def_cfa	11,8
 4639 6a18 18000000 		ld	%got,0x18(,%sp)
 4639      8B000F01 
 4640 6a20 20000000 		ld	%plt,0x20(,%sp)
 4640      8B001001 
 4641 6a28 08000000 		ld	%lr,0x8(,%sp)
 4641      8B000A01 
 4642 6a30 00000000 		ld	%fp,0x0(,%sp)
 4642      8B000901 
 4643 6a38 00000000 		b.l	(,%lr)
 4643      8A000F19 
 4644              	.L5.45:
 4645 6a40 D8040000 		br.l	.L5.46
 4645      00000F18 
 4646              	.L5.47:
 4647              	# line 2024
2024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 4648              		.loc	1 2024 0
 4649 6a48 00000000 		adds.w.sx	%s57,1,%s57
 4649      B901394A 
 4650 6a50 00000000 		adds.w.sx	%s41,%s42,%s41
 4650      A9AA294A 
 4651 6a58 00000000 		adds.w.sx	%s45,%s53,%s45
 4651      ADB52D4A 
 4652 6a60 00000000 		adds.l	%s40,%s7,%s40
 4652      A8872859 
 4653 6a68 D8FFFFFF 		brgt.w	0,%s57,.L5.45
 4653      B9008118 
 4654 6a70 90FEFFFF 		br.l	.L5.44
 4654      00000F18 
 4655              	.L5.48:
 4656 6a78 F0EBFFFF 		ld	%s57,-5136(,%fp)	# restore 
 4656      89003901 
 4657 6a80 F8EBFFFF 		ld	%s53,-5128(,%fp)	# restore 
 4657      89003501 
 4658 6a88 E8EBFFFF 		ld	%s40,-5144(,%fp)	# restore 
 4658      89002801 
 4659 6a90 E8FDFFFF 		ld	%s39,-536(,%fp)	# restore 
 4659      89002701 
 4660 6a98 00ECFFFF 		ld	%s32,-5120(,%fp)	# restore 
 4660      89002001 
 4661 6aa0 E0EBFFFF 		ld	%s1,-5152(,%fp)	# restore 
 4661      89000101 
 4662 6aa8 A0FFFFFF 		br.l	.L5.47
 4662      00000F18 
 4663              	.L5.49:
 4664              	# line 2025
2025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 4665              		.loc	1 2025 0
 4666 6ab0 00000000 		adds.w.sx	%s57,1,%s57
 4666      B901394A 
 4667 6ab8 00000000 		adds.l	%s40,%s49,%s40
 4667      A8B12859 
 4668 6ac0 00000000 		adds.l	%s1,%s7,%s1
 4668      81870159 
 4669 6ac8 D8030000 		brgt.w	0,%s57,.L5.50
 4669      B9008118 
 4670 6ad0 A8FFFFFF 		br.l	.L5.48
 4670      00000F18 
 4671              	.L5.51:
 4672 6ad8 E8FDFFFF 		st	%s42,-536(,%fp)	# spill 
 4672      89002A11 
 4673 6ae0 08FCFFFF 		st	%s1,-1016(,%fp)	# spill 
 4673      89000111 
 4674 6ae8 38FCFFFF 		ld	%s57,-968(,%fp)	# restore 
 4674      89003901 
 4675 6af0 30FCFFFF 		ld	%s49,-976(,%fp)	# restore 
 4675      89003101 
 4676 6af8 18FCFFFF 		ld	%s40,-1000(,%fp)	# restore 
 4676      89002801 
 4677 6b00 28FCFFFF 		ld	%s7,-984(,%fp)	# restore 
 4677      89000701 
 4678 6b08 20FCFFFF 		ld	%s1,-992(,%fp)	# restore 
 4678      89000101 
 4679 6b10 10FCFFFF 		ld	%s42,-1008(,%fp)	# restore 
 4679      89002A01 
 4680 6b18 40FCFFFF 		ld	%s32,-960(,%fp)	# restore 
 4680      89002001 
 4681 6b20 90FFFFFF 		br.l	.L5.49
 4681      00000F18 
 4682              	.L5.52:
 4683              	# line 2026
2026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 4684              		.loc	1 2026 0
 4685 6b28 00000000 		adds.w.sx	%s57,1,%s57
 4685      B901394A 
 4686 6b30 00000000 		adds.w.sx	%s53,1,%s53
 4686      B501354A 
 4687 6b38 D0020000 		brgt.w	0,%s57,.L5.53
 4687      B9008118 
 4688 6b40 98FFFFFF 		br.l	.L5.51
 4688      00000F18 
 4689              	.L5.54:
 4690 6b48 60FCFFFF 		ld	%s57,-928(,%fp)	# restore 
 4690      89003901 
 4691 6b50 58FCFFFF 		ld	%s53,-936(,%fp)	# restore 
 4691      89003501 
 4692 6b58 68FCFFFF 		ld	%s19,-920(,%fp)	# restore 
 4692      89001301 
 4693 6b60 48FCFFFF 		ld	%s50,-952(,%fp)	# restore 
 4693      89003201 
 4694 6b68 50FCFFFF 		ld	%s4,-944(,%fp)	# restore 
 4694      89000401 
 4695 6b70 B8FFFFFF 		br.l	.L5.52
 4695      00000F18 
 4696              	.L5.55:
 4697 6b78 30020000 		br.l	.L5.56
 4697      00000F18 
 4698              	.L5.57:
 4699              	# line 2027
2027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // calc kh_beg, kh_end here? 4.28x
 4700              		.loc	1 2027 0
 4701 6b80 00000000 		adds.w.sx	%s57,1,%s57
 4701      B901394A 
 4702 6b88 00000000 		adds.l	%s53,4,%s53
 4702      B5043559 
 4703 6b90 00000000 		adds.w.sx	%s50,1,%s50
 4703      B201324A 
 4704 6b98 00000000 		adds.w.sx	%s49,1,%s49
 4704      B101314A 
 4705 6ba0 D8FFFFFF 		brgt.w	0,%s57,.L5.55
 4705      B9008118 
 4706 6ba8 A0FFFFFF 		br.l	.L5.54
 4706      00000F18 
 4707              	.L5.58:
 4708 6bb0 D8FCFFFF 		ld	%s57,-808(,%fp)	# restore 
 4708      89003901 
 4709 6bb8 C8FCFFFF 		ld	%s53,-824(,%fp)	# restore 
 4709      89003501 
 4710 6bc0 D0FCFFFF 		ld	%s50,-816(,%fp)	# restore 
 4710      89003201 
 4711 6bc8 C0FCFFFF 		ld	%s49,-832(,%fp)	# restore 
 4711      89003101 
 4712 6bd0 E0FCFFFF 		ld	%s18,-800(,%fp)	# restore 
 4712      89001201 
 4713 6bd8 B0FCFFFF 		ld	%s7,-848(,%fp)	# restore 
 4713      89000701 
 4714 6be0 A8FCFFFF 		ld	%s6,-856(,%fp)	# restore 
 4714      89000601 
 4715 6be8 A0FCFFFF 		ld	%s24,-864(,%fp)	# restore 
 4715      89001801 
 4716 6bf0 98FCFFFF 		ld	%s23,-872(,%fp)	# restore 
 4716      89001701 
 4717 6bf8 88FCFFFF 		ld	%s21,-888(,%fp)	# restore 
 4717      89001501 
 4718 6c00 70FCFFFF 		ld	%s36,-912(,%fp)	# restore 
 4718      89002401 
 4719 6c08 90FCFFFF 		ld	%s22,-880(,%fp)	# restore 
 4719      89001601 
 4720 6c10 80FCFFFF 		ld	%s20,-896(,%fp)	# restore 
 4720      89001401 
 4721 6c18 78FCFFFF 		ld	%s48,-904(,%fp)	# restore 
 4721      89003001 
 4722 6c20 B8FCFFFF 		ld	%s41,-840(,%fp)	# restore 
 4722      89002901 
 4723 6c28 58FFFFFF 		br.l	.L5.57
 4723      00000F18 
 4724              	.L5.19:
 4725 6c30 00000000 		or	%s57,3,(0)1
 4725      00033945 
 4726 6c38 00000000 		st2b	%s57,0(,%s55)
 4726      B7003914 
 4727              	# line 2029
2029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 4728              		.loc	1 2029 0
 4729 6c40 00000000 		adds.w.sx	%s53,1,%s53
 4729      B501354A 
 4730 6c48 00000000 		adds.l	%s49,4,%s49
 4730      B1043159 
 4731 6c50 00000000 		adds.w.sx	%s48,1,%s48
 4731      B001304A 
 4732 6c58 10000000 		brgt.w	0,%s53,.L5.59
 4732      B5008118 
 4733 6c60 50FFFFFF 		br.l	.L5.58
 4733      00000F18 
 4734              	.L5.59:
 4735              	# line 2032
2032:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 4736              		.loc	1 2032 0
 4737 6c68 00000000 		or	%s57,0,(0)1
 4737      00003945 
 4738 6c70 00000000 		stu	%s57,0(%s49,%s50)	# *(ds)
 4738      B2B13912 
 4739 6c78 B8FFFFFF 		brge.w	%s18,%s19,.L5.19
 4739      93928518 
 4740 6c80 60FCFFFF 		br.l	.L5.43
 4740      00000F18 
 4741              	.L5.60:
 4742 6c88 E0FCFFFF 		st	%s18,-800(,%fp)	# spill 
 4742      89001211 
 4743 6c90 D8FCFFFF 		st	%s57,-808(,%fp)	# spill 
 4743      89003911 
 4744 6c98 D0FCFFFF 		st	%s50,-816(,%fp)	# spill 
 4744      89003211 
 4745 6ca0 C8FCFFFF 		st	%s53,-824(,%fp)	# spill 
 4745      89003511 
 4746 6ca8 C0FCFFFF 		st	%s49,-832(,%fp)	# spill 
 4746      89003111 
 4747 6cb0 B8FCFFFF 		st	%s41,-840(,%fp)	# spill 
 4747      89002911 
 4748 6cb8 B0FCFFFF 		st	%s7,-848(,%fp)	# spill 
 4748      89000711 
 4749 6cc0 A8FCFFFF 		st	%s6,-856(,%fp)	# spill 
 4749      89000611 
 4750 6cc8 A0FCFFFF 		st	%s24,-864(,%fp)	# spill 
 4750      89001811 
 4751 6cd0 98FCFFFF 		st	%s23,-872(,%fp)	# spill 
 4751      89001711 
 4752 6cd8 90FCFFFF 		st	%s22,-880(,%fp)	# spill 
 4752      89001611 
 4753 6ce0 88FCFFFF 		st	%s21,-888(,%fp)	# spill 
 4753      89001511 
 4754 6ce8 80FCFFFF 		st	%s20,-896(,%fp)	# spill 
 4754      89001411 
 4755 6cf0 78FCFFFF 		st	%s48,-904(,%fp)	# spill 
 4755      89003011 
 4756 6cf8 70FCFFFF 		st	%s36,-912(,%fp)	# spill 
 4756      89002411 
 4757 6d00 00000000 		divs.w.sx	%s41,%s41,%s42
 4757      AAA9297B 
 4758 6d08 00000000 		or	%s41,0,%s41
 4758      A9002945 
 4759 6d10 00000000 		addu.l	%s7,%s41,%s7
 4759      87A90748 
 4760 6d18 00000000 		addu.l	%s7,%s7,%s32
 4760      A0870748 
 4761 6d20 00000000 		mulu.l	%s6,%s7,%s6
 4761      86870649 
 4762 6d28 00000000 		or	%s57,0,%s49
 4762      B1003945 
 4763 6d30 00000000 		addu.l	%s57,%s6,%s57
 4763      B9863948 
 4764 6d38 00000000 		mulu.l	%s24,%s57,%s24
 4764      98B91849 
 4765 6d40 00000000 		or	%s24,0,%s24
 4765      98001845 
 4766              	# line 2029
2029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 4767              		.loc	1 2029 0
 4768 6d48 00000000 		muls.l	%s24,4,%s24
 4768      9804186E 
 4769              	# line 2034
2034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = khe[ih];
 4770              		.loc	1 2034 0
 4771 6d50 00000000 		dldl.sx	%s18,0(%s53,%s23)	# *(khb)
 4771      97B5120B 
 4772              	# line 2042
2042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t d_oc1h = dst_off_f(p, mb, g, 0, oh0/SH, 0);
 4773              		.loc	1 2042 0
 4774 6d58 00000000 		muls.w.sx	%s22,%s18,%s22
 4774      9692164B 
 4775              	# line 2035
2035:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
 4776              		.loc	1 2035 0
 4777 6d60 00000000 		dldl.sx	%s19,0(%s53,%s21)	# *(khe)
 4777      95B5130B 
 4778              	# line 2047
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
 4779              		.loc	1 2047 0
 4780 6d68 00000000 		subs.w.sx	%s4,0,%s19
 4780      9300045A 
 4781              	# line 2042
2042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t d_oc1h = dst_off_f(p, mb, g, 0, oh0/SH, 0);
 4782              		.loc	1 2042 0
 4783 6d70 00000000 		subs.w.sx	%s22,%s50,%s22
 4783      96B2165A 
 4784              	# line 2029
2029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 4785              		.loc	1 2029 0
 4786 6d78 00000000 		adds.l	%s50,%s24,%s20
 4786      94983259 
 4787 6d80 00000000 		or	%s53,0,%s48
 4787      B0003545 
 4788 6d88 00000000 		or	%s49,0,(0)1
 4788      00003145 
 4789 6d90 00000000 		or	%s48,0,%s36
 4789      A4003045 
 4790 6d98 00000000 		or	%s36,0,%s22
 4790      96002445 
 4791 6da0 C8FEFFFF 		br.l	.L5.59
 4791      00000F18 
 4792              	.L5.56:
 4793 6da8 E0FEFFFF 		brlt.w	0,%s18,.L5.60
 4793      92008218 
 4794 6db0 D0FDFFFF 		br.l	.L5.57
 4794      00000F18 
 4795              	.L5.61:
 4796 6db8 68FCFFFF 		st	%s19,-920(,%fp)	# spill 
 4796      89001311 
 4797 6dc0 60FCFFFF 		st	%s57,-928(,%fp)	# spill 
 4797      89003911 
 4798 6dc8 58FCFFFF 		st	%s53,-936(,%fp)	# spill 
 4798      89003511 
 4799 6dd0 50FCFFFF 		st	%s4,-944(,%fp)	# spill 
 4799      89000411 
 4800 6dd8 48FCFFFF 		st	%s50,-952(,%fp)	# spill 
 4800      89003211 
 4801 6de0 00000000 		or	%s32,0,%s53
 4801      B5002045 
 4802 6de8 00000000 		or	%s57,0,%s4
 4802      84003945 
 4803              	# line 2027
2027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // calc kh_beg, kh_end here? 4.28x
 4804              		.loc	1 2027 0
 4805 6df0 00000000 		or	%s53,0,(0)1
 4805      00003545 
 4806 6df8 00000000 		or	%s50,0,%s50
 4806      B2003245 
 4807 6e00 A8FFFFFF 		br.l	.L5.56
 4807      00000F18 
 4808              	.L5.53:
 4809 6e08 00000000 		or	%s49,0,(0)1
 4809      00003145 
 4810 6e10 A8FFFFFF 		brlt.w	0,%s19,.L5.61
 4810      93008218 
 4811 6e18 10FDFFFF 		br.l	.L5.52
 4811      00000F18 
 4812              	.L5.62:
 4813 6e20 40FCFFFF 		st	%s32,-960(,%fp)	# spill 
 4813      89002011 
 4814 6e28 38FCFFFF 		st	%s57,-968(,%fp)	# spill 
 4814      89003911 
 4815 6e30 30FCFFFF 		st	%s49,-976(,%fp)	# spill 
 4815      89003111 
 4816 6e38 28FCFFFF 		st	%s7,-984(,%fp)	# spill 
 4816      89000711 
 4817 6e40 20FCFFFF 		st	%s1,-992(,%fp)	# spill 
 4817      89000111 
 4818 6e48 18FCFFFF 		st	%s40,-1000(,%fp)	# spill 
 4818      89002811 
 4819 6e50 10FCFFFF 		st	%s42,-1008(,%fp)	# spill 
 4819      89002A11 
 4820 6e58 E8FDFFFF 		ld	%s49,-536(,%fp)	# restore 
 4820      89003101 
 4821              	# line 2026
2026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 4822              		.loc	1 2026 0
 4823 6e60 00000000 		divs.w.sx	%s0,%s42,%s49
 4823      B1AA007B 
 4824 6e68 00000000 		or	%s42,0,%s49
 4824      B1002A45 
 4825 6e70 00000000 		subs.w.sx	%s0,0,%s0
 4825      8000005A 
 4826 6e78 00000000 		or	%s57,0,%s0
 4826      80003945 
 4827 6e80 00000000 		or	%s7,0,%s40
 4827      A8000745 
 4828 6e88 00000000 		or	%s40,0,%s1
 4828      81002845 
 4829 6e90 08FCFFFF 		ld	%s1,-1016(,%fp)	# restore 
 4829      89000101 
 4830 6e98 70FFFFFF 		br.l	.L5.53
 4830      00000F18 
 4831              	.L5.50:
 4832 6ea0 00000000 		or	%s53,0,(0)1
 4832      00003545 
 4833 6ea8 78FFFFFF 		brlt.w	0,%s32,.L5.62
 4833      A0008218 
 4834 6eb0 00FCFFFF 		br.l	.L5.49
 4834      00000F18 
 4835              	.L5.63:
 4836 6eb8 00ECFFFF 		st	%s32,-5120(,%fp)	# spill 
 4836      89002011 
 4837 6ec0 F8EBFFFF 		st	%s53,-5128(,%fp)	# spill 
 4837      89003511 
 4838 6ec8 F0EBFFFF 		st	%s57,-5136(,%fp)	# spill 
 4838      89003911 
 4839 6ed0 E8EBFFFF 		st	%s40,-5144(,%fp)	# spill 
 4839      89002811 
 4840 6ed8 E8FDFFFF 		st	%s39,-536(,%fp)	# spill 
 4840      89002711 
 4841 6ee0 E0EBFFFF 		st	%s1,-5152(,%fp)	# spill 
 4841      89000111 
 4842 6ee8 00000000 		divs.w.sx	%s32,%s42,%s39
 4842      A7AA207B 
 4843 6ef0 00000000 		or	%s39,0,%s40
 4843      A8002745 
 4844 6ef8 00000000 		or	%s57,0,%s1
 4844      81003945 
 4845              	# line 2025
2025:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 4846              		.loc	1 2025 0
 4847 6f00 00000000 		or	%s40,0,(0)1
 4847      00002845 
 4848 6f08 00000000 		or	%s1,0,(0)1
 4848      00000145 
 4849 6f10 90FFFFFF 		br.l	.L5.50
 4849      00000F18 
 4850              	.L5.46:
 4851 6f18 A0FFFFFF 		brlt.w	0,%s32,.L5.63
 4851      A0008218 
 4852 6f20 28FBFFFF 		br.l	.L5.47
 4852      00000F18 
 4853              	.L5.64:
 4854 6f28 04000000 		dldl.sx	%s32,4(,%s62)	# *(p).__b_N4conv6desc_tE.mb
 4854      BE00200B 
 4855 6f30 00000000 		or	%s39,0,%s42
 4855      AA002745 
 4856 6f38 00000000 		subs.w.sx	%s1,0,%s32
 4856      A000015A 
 4857              	# line 2026
2026:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 4858              		.loc	1 2026 0
 4859 6f40 08000000 		dldl.sx	%s0,8(,%s62)	# *(p).__b_N4conv6desc_tE.ic
 4859      BE00000B 
 4860 6f48 00000000 		or	%s33,0,%s0
 4860      80002145 
 4861 6f50 00000000 		or	%s49,0,%s33
 4861      A1003145 
 4862              	# line 2024
2024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 4863              		.loc	1 2024 0
 4864 6f58 00000000 		or	%s40,0,(0)1
 4864      00002845 
 4865 6f60 00000000 		or	%s38,0,%s42
 4865      AA002645 
 4866 6f68 00000000 		subs.w.sx	%s58,0,%s42
 4866      AA003A5A 
 4867 6f70 00000000 		or	%s42,0,%s0
 4867      80002A45 
 4868 6f78 00000000 		or	%s57,0,%s58
 4868      BA003945 
 4869              	# line 2027
2027:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // calc kh_beg, kh_end here? 4.28x
 4870              		.loc	1 2027 0
 4871 6f80 0C000000 		dldl.sx	%s19,12(,%s62)	# *(p).__b_N4conv6desc_tE.ih
 4871      BE00130B 
 4872 6f88 00000000 		or	%s6,0,%s19
 4872      93000645 
 4873 6f90 00000000 		subs.w.sx	%s4,0,%s19
 4873      9300045A 
 4874              	# line 2029
2029:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 4875              		.loc	1 2029 0
 4876 6f98 10000000 		dldl.sx	%s18,16(,%s62)	# *(p).__b_N4conv6desc_tE.iw
 4876      BE00120B 
 4877 6fa0 00000000 		or	%s24,0,%s18
 4877      92001845 
 4878 6fa8 00000000 		subs.w.sx	%s0,0,%s18
 4878      9200005A 
 4879              	# line 2034
2034:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kh_end = khe[ih];
 4880              		.loc	1 2034 0
 4881 6fb0 40FEFFFF 		dld	%s23,-448(,%fp)	# khb
 4881      89001709 
 4882              	# line 2038
2038:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int kw_end = kwe[iw];
 4883              		.loc	1 2038 0
 4884 6fb8 E8FFFFFF 		dld	%s47,-24(,%fp)	# kwb
 4884      89002F09 
 4885              	# line 2039
2039:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kw_beg >= kw_end ) continue;
 4886              		.loc	1 2039 0
 4887 6fc0 F0FFFFFF 		dld	%s46,-16(,%fp)	# kwe
 4887      89002E09 
 4888              	# line 2042
2042:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             size_t d_oc1h = dst_off_f(p, mb, g, 0, oh0/SH, 0);
 4889              		.loc	1 2042 0
 4890 6fc8 30000000 		dldl.sx	%s50,48(,%s62)	# *(p).__b_N4conv6desc_tE.ph
 4890      BE00320B 
 4891              	# line 2043
2043:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const size_t w_oc00 = wei_off_f(p, g, 0, ic, 0, 0);
 4892              		.loc	1 2043 0
 4893 6fd0 14000000 		dldl.sx	%s53,20(,%s62)	# *(p).__b_N4conv6desc_tE.oc
 4893      BE00350B 
 4894 6fd8 00000000 		or	%s58,0,%s53
 4894      B5003A45 
 4895 6fe0 00000000 		or	%s7,0,%s58
 4895      BA000745 
 4896 6fe8 18000000 		dldl.sx	%s58,24(,%s62)	# *(p).__b_N4conv6desc_tE.oh
 4896      BE003A0B 
 4897 6ff0 00000000 		or	%s37,0,%s58
 4897      BA002545 
 4898 6ff8 28000000 		dldl.sx	%s35,40(,%s62)	# *(p).__b_N4conv6desc_tE.sh
 4898      BE00230B 
 4899 7000 1C000000 		dldl.sx	%s58,28(,%s62)	# *(p).__b_N4conv6desc_tE.ow
 4899      BE003A0B 
 4900 7008 00000000 		or	%s34,0,%s58
 4900      BA002245 
 4901              	# line 2044
2044:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             // using next line is maybe a wee bit slower
 4902              		.loc	1 2044 0
 4903 7010 20000000 		dldl.sx	%s54,32(,%s62)	# *(p).__b_N4conv6desc_tE.kh
 4903      BE00360B 
 4904 7018 00000000 		or	%s31,0,%s54
 4904      B6001F45 
 4905 7020 24000000 		dldl.sx	%s54,36(,%s62)	# *(p).__b_N4conv6desc_tE.kw
 4905      BE00360B 
 4906 7028 00000000 		or	%s30,0,%s54
 4906      B6001E45 
 4907              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4908              		.loc	1 2052 0
 4909 7030 34000000 		dldl.sx	%s36,52(,%s62)	# *(p).__b_N4conv6desc_tE.pw
 4909      BE00240B 
 4910              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4911              		.loc	1 2059 0
 4912 7038 14000000 		dldl.sx	%s44,20(,%s62)	# *(p).__b_N4conv6desc_tE.oc
 4912      BE002C0B 
 4913              	# line 2024
2024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 4914              		.loc	1 2024 0
 4915 7040 00000000 		or	%s41,0,(0)1
 4915      00002945 
 4916 7048 00000000 		or	%s45,0,(0)1
 4916      00002D45 
 4917              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4918              		.loc	1 2059 0
 4919 7050 00000000 		dldl.sx	%s5,0(,%s62)	# *(p).__b_N4conv6desc_tE.g
 4919      BE00050B 
 4920              	# line 2070
2070:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //w_oc1h += khh*KW;
 4921              		.loc	1 2070 0
 4922 7058 00000000 		muls.w.sx	%s54,%s58,%s48
 4922      B0BA364B 
 4923 7060 00000000 		or	%s48,0,%s0
 4923      80003045 
 4924 7068 00000000 		or	%s0,0,%s62
 4924      BE000045 
 4925 7070 00000000 		or	%s62,0,%s54
 4925      B6003E45 
 4926              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4927              		.loc	1 2059 0
 4928 7078 24000000 		dldl.sx	%s58,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 4928      80003A0B 
 4929 7080 00000000 		or	%s54,0,%s58
 4929      BA003645 
 4930              	# line 2047
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
 4931              		.loc	1 2047 0
 4932 7088 00000000 		muls.l	%s3,4,%s54
 4932      B604036E 
 4933              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4934              		.loc	1 2059 0
 4935 7090 2C000000 		dldl.sx	%s0,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 4935      8000000B 
 4936 7098 00000000 		or	%s58,0,%s55
 4936      B7003A45 
 4937 70a0 00000000 		lea	%s55,__eh_curr_region@LO
 4937      00003706 
 4938 70a8 00000000 		and	%s55,%s55,(32)0
 4938      60B73744 
 4939 70b0 00000000 		lea.sl	%s55,__eh_curr_region@HI(,%s55)
 4939      B700B706 
 4940 70b8 00000000 		or	%s54,0,%s59
 4940      BB003645 
 4941              	# line 2047
2047:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               int ow0=iw+PW - kw_beg*DW;
 4942              		.loc	1 2047 0
 4943 70c0 00000000 		muls.l	%s51,%s3,%s54
 4943      B683336E 
 4944 70c8 00000000 		or	%s54,0,%s56
 4944      B8003645 
 4945              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4946              		.loc	1 2052 0
 4947 70d0 00000000 		muls.l	%s52,4,%s54
 4947      B604346E 
 4948 70d8 00000000 		muls.l	%s29,4,%s52
 4948      B4041D6E 
 4949 70e0 00000000 		muls.l	%s27,8,%s54
 4949      B6081B6E 
 4950 70e8 00FEFFFF 		st	%s29,-512(,%fp)	# spill 
 4950      89001D11 
 4951 70f0 00000000 		muls.l	%s29,12,%s54
 4951      B60C1D6E 
 4952 70f8 00000000 		subs.w.sx	%s54,0,%s61
 4952      BD00365A 
 4953 7100 00000000 		or	%s26,0,%s58
 4953      BA001A45 
 4954              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4955              		.loc	1 2059 0
 4956 7108 00000000 		muls.l	%s25,4,%s26
 4956      9A04196E 
 4957 7110 00000000 		or	%s26,0,%s60
 4957      BC001A45 
 4958 7118 00000000 		muls.l	%s2,4,%s26
 4958      9A04026E 
 4959              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4960              		.loc	1 2052 0
 4961 7120 00000000 		sla.w.sx	%s26,%s54,2
 4961      B6021A66 
 4962              	# line 2059
2059:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 4963              		.loc	1 2059 0
 4964 7128 00000000 		sla.w.sx	%s21,%s58,2
 4964      BA021566 
 4965 7130 08FCFFFF 		st	%s2,-1016(,%fp)	# spill 
 4965      89000211 
 4966 7138 08FEFFFF 		st	%s26,-504(,%fp)	# spill 
 4966      89001A11 
 4967 7140 F0FDFFFF 		st	%s21,-528(,%fp)	# spill 
 4967      89001511 
 4968 7148 00000000 		sla.w.sx	%s58,%s60,2
 4968      BC023A66 
 4969              	# line 2052
2052:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const size_t d_oc0 = dst_off_f(p, mb, g, 0, oh0/SH, ow0/SW);
 4970              		.loc	1 2052 0
 4971 7150 00000000 		muls.w.sx	%s2,-2,%s61
 4971      BD7E024B 
 4972 7158 F8FDFFFF 		st	%s58,-520(,%fp)	# spill 
 4972      89003A11 
 4973 7160 00000000 		muls.w.sx	%s60,-3,%s61
 4973      BD7D3C4B 
 4974 7168 00000000 		adds.l	%s58,%s52,%s28
 4974      9CB43A59 
 4975 7170 00000000 		adds.l	%s26,%s27,%s28
 4975      9C9B1A59 
 4976 7178 00000000 		adds.l	%s27,%s29,%s28
 4976      9C9D1B59 
 4977              	# line 2035
2035:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( kh_beg >= kh_end ) continue;
 4978              		.loc	1 2035 0
 4979 7180 E0FFFFFF 		dld	%s21,-32(,%fp)	# khe
 4979      89001509 
 4980 7188 00000000 		or	%s29,0,%s60
 4980      BC001D45 
 4981 7190 38EBFFFF 		st	%s54,-5320(,%fp)	# spill 
 4981      89003611 
 4982 7198 00000000 		or	%s60,0,%s0
 4982      80003C45 
 4983 71a0 00000000 		or	%s54,0,%s52
 4983      B4003645 
 4984 71a8 38EBFFFF 		ld	%s52,-5320(,%fp)	# restore 
 4984      89003401 
 4985 71b0 E8FCFFFF 		st	%s27,-792(,%fp)	# spill 
 4985      89001B11 
 4986 71b8 00000000 		or	%s27,0,%s58
 4986      BA001B45 
 4987 71c0 00000000 		or	%s58,0,%s25
 4987      99003A45 
 4988 71c8 E8FCFFFF 		ld	%s25,-792(,%fp)	# restore 
 4988      89001901 
 4989 71d0 48FDFFFF 		br.l	.L5.46
 4989      00000F18 
 4990              	.L5.65:
 4991              	# line 2024
2024:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 4992              		.loc	1 2024 0
 4993 71d8 00000000 		ldl.sx	%s42,0(,%s62)	# *(p).__b_N4conv6desc_tE.g
 4993      BE002A03 
 4994 71e0 48FDFFFF 		brlt.w	0,%s42,.L5.64
 4994      AA008218 
 4995 71e8 18F7FFFF 		br.l	.L5.44
 4995      00000F18 
 4996              	.L5.66:
 4997 71f0 00000000 		or	%s60,0,%s42
 4997      AA003C45 
 4998 71f8 00000000 		or	%s55,0,%s41
 4998      A9003745 
 4999 7200 D8FFFFFF 		br.l	.L5.65
 4999      00000F18 
 5000              	.L5.13:
 5001              	# line 2008
2008:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (kwe[iw] > KW) kwe[iw] = KW;
 5002              		.loc	1 2008 0
 5003 7208 34000000 		ldl.sx	%s60,52(,%s62)	# *(p).__b_N4conv6desc_tE.pw
 5003      BE003C03 
 5004 7210 00000000 		lvl	%s57
 5004      00B900BF 
 5005 7218 000F003F 		vadds.w.sx	%v63,%s58,%v15
 5005      00BA20CA 
 5006 7220 003F003B 		vadds.w.sx	%v59,%s60,%v63
 5006      00BC20CA 
 5007 7228 00003B3A 		vdivs.w.sx	%v58,%v59,%s63
 5007      00BF10EB 
 5008 7230 003A0039 		vadds.w.sx	%v57,1,%v58
 5008      000120CA 
 5009 7238 00000000 		adds.l	%s60,%s55,(0)1
 5009      00B73C59 
 5010 7240 00000000 		adds.l	%s44,%s60,%s53
 5010      B5BC2C59 
 5011 7248 00000039 		vstl.nc	%v57,4,%s44
 5011      AC040093 
 5012              	# line 2009
2009:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[iw] = kwe[iw];
 5013              		.loc	1 2009 0
 5014 7250 24000000 		ldl.sx	%s44,36(,%s62)	# *(p).__b_N4conv6desc_tE.kw
 5014      BE002C03 
 5015 7258 00390038 		vmins.w.sx	%v56,%s44,%v57
 5015      00AC308A 
 5016 7260 00000000 		adds.l	%s60,%s60,%s53
 5016      B5BC3C59 
 5017 7268 00000038 		vstl.nc	%v56,4,%s60
 5017      BC040093 
 5018              	# line 2010
2010:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
 5019              		.loc	1 2010 0
 5020 7270 00000000 		adds.l	%s60,%s51,(0)1
 5020      00B33C59 
 5021 7278 00000000 		adds.l	%s44,%s60,%s53
 5021      B5BC2C59 
 5022 7280 00000038 		vstl.nc	%v56,4,%s44
 5022      AC040093 
 5023              	# line 2011
2011:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kw_ibeg = kwe[iw];
 5024              		.loc	1 2011 0
 5025 7288 34000000 		ldl.sx	%s44,52(,%s62)	# *(p).__b_N4conv6desc_tE.pw
 5025      BE002C03 
 5026 7290 000F0037 		vadds.w.sx	%v55,%s58,%v15
 5026      00BA20CA 
 5027 7298 00370036 		vadds.w.sx	%v54,%s44,%v55
 5027      00AC20CA 
 5028 72a0 00003635 		vdivs.w.sx	%v53,%v54,%s50
 5028      00B210EB 
 5029 72a8 00350034 		vmuls.w.sx	%v52,%s50,%v53
 5029      00B220CB 
 5030 72b0 00343633 		vsubs.w.sx	%v51,%v54,%v52
 5030      000000DA 
 5031 72b8 0033040F 		vfmk.w.eq	%vm15,%v51
 5031      000000B5 
 5032              	# line 2014
2014:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kw_ibeg, kww);
 5033              		.loc	1 2014 0
 5034 72c0 0035000E 		vmuls.w.sx	%v14,%s54,%v53,%vm15
 5034      00B62FCB 
 5035              	# line 2015
2015:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kw_ibeg -= m * kww;
 5036              		.loc	1 2015 0
 5037 72c8 00000E0D 		vdivs.w.sx	%v13,%v14,%s56,%vm15
 5037      00B81FEB 
 5038 72d0 000D000C 		vmuls.w.sx	%v12,%s56,%v13,%vm15
 5038      00B82FCB 
 5039 72d8 000C0E0B 		vsubs.w.sx	%v11,%v14,%v12,%vm15
 5039      00000FDA 
 5040 72e0 000B050E 		vfmk.w.ge	%vm14,%v11,%vm15
 5040      00000FB5 
 5041 72e8 0000000A 		vbrd	%v10,0,%vm14
 5041      00000E8C 
 5042 72f0 000F0E0E 		nndm	%vm14,%vm14,%vm15
 5042      00000094 
 5043 72f8 0000000A 		vbrd	%v10,1,%vm14
 5043      00010E8C 
 5044 7300 00000E09 		vdivs.w.sx	%v9,%v14,%s56,%vm15
 5044      00B81FEB 
 5045 7308 000A0908 		vsubs.w.sx	%v8,%v9,%v10,%vm15
 5045      00000FDA 
 5046              	# line 2016
2016:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = wb * mul + m * jww;
 5047              		.loc	1 2016 0
 5048 7310 00080007 		vmuls.w.sx	%v7,%s56,%v8,%vm15
 5048      00B82FCB 
 5049 7318 00070E06 		vsubs.w.sx	%v6,%v14,%v7,%vm15
 5049      00000FDA 
 5050              	# line 2017
2017:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OW) kw_ibeg += (j-OW)/jww * kww + kww;
 5051              		.loc	1 2017 0
 5052 7320 00350005 		vmuls.w.sx	%v5,%s52,%v53,%vm15
 5052      00B42FCB 
 5053 7328 00080004 		vmuls.w.sx	%v4,%s49,%v8,%vm15
 5053      00B12FCB 
 5054 7330 00040503 		vadds.w.sx	%v3,%v5,%v4,%vm15
 5054      00000FCA 
 5055              	# line 2018
2018:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[iw] = kw_ibeg;
 5056              		.loc	1 2018 0
 5057 7338 1C000000 		ldl.sx	%s44,28(,%s62)	# *(p).__b_N4conv6desc_tE.ow
 5057      BE002C03 
 5058 7340 00030002 		vcmps.w.sx	%v2,%s44,%v3,%vm15
 5058      00AC2FFA 
 5059 7348 0002060E 		vfmk.w.le	%vm14,%v2,%vm15
 5059      00000FB5 
 5060 7350 00000000 		subs.w.sx	%s44,0,%s44
 5060      AC002C5A 
 5061 7358 00030001 		vadds.w.sx	%v1,%s44,%v3,%vm14
 5061      00AC2ECA 
 5062 7360 00000100 		vdivs.w.sx	%v0,%v1,%s49,%vm14
 5062      00B11EEB 
 5063 7368 0000003E 		vmuls.w.sx	%v62,%s56,%v0,%vm14
 5063      00B82ECB 
 5064 7370 003E063D 		vadds.w.sx	%v61,%v6,%v62,%vm14
 5064      00000ECA 
 5065 7378 003D0006 		vadds.w.sx	%v6,%s56,%v61,%vm14
 5065      00B82ECA 
 5066              	# line 2019
2019:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 5067              		.loc	1 2019 0
 5068 7380 00000000 		adds.l	%s60,%s60,%s53
 5068      B5BC3C59 
 5069 7388 00000006 		vstl.nc	%v6,4,%s60,%vm15
 5069      BC040F93 
 5070              	# line 2007
2007:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = (iw + PW) / DW + 1;
 5071              		.loc	1 2007 0
 5072 7390 00000000 		adds.w.sx	%s58,%s58,%s47
 5072      AFBA3A4A 
 5073 7398 00000000 		adds.l	%s53,%s53,%s46
 5073      AEB53559 
 5074 73a0 00000000 		subs.w.sx	%s45,%s45,%s57
 5074      B9AD2D5A 
 5075 73a8 48FEFFFF 		brge.w	0,%s45,.L5.66
 5075      AD008518 
 5076 73b0 68E7FFFF 		br.l	.L5.12
 5076      00000F18 
 5077              	.L5.67:
 5078 73b8 00000000 		subs.w.sx	%s18,0,%s18
 5078      9200125A 
 5079 73c0 00000000 		or	%s41,0,%s55
 5079      B7002945 
 5080 73c8 00000000 		subs.w.sx	%s18,0,%s18
 5080      9200125A 
 5081 73d0 00000000 		smvl	%s44
 5081      00002C2E 
 5082 73d8 80000000 		mins.w.sx	%s57,%s18,%s44
 5082      AC923978 
 5083 73e0 00000000 		or	%s45,0,%s18
 5083      92002D45 
 5084 73e8 00000000 		or	%s44,0,(0)1
 5084      00002C45 
 5085 73f0 00000000 		or	%s47,0,%s57
 5085      B9002F45 
 5086 73f8 00000000 		lvl	%s57
 5086      00B900BF 
 5087 7400 00000031 		vseq	%v49
 5087      00000099 
 5088 7408 00000000 		or	%s55,0,%s58
 5088      BA003745 
 5089 7410 00000000 		or	%s42,0,%s60
 5089      BC002A45 
 5090 7418 00000000 		or	%s58,0,%s44
 5090      AC003A45 
 5091 7420 0031000F 		vor	%v15,(0)1,%v49
 5091      000020C5 
 5092 7428 00000000 		or	%s53,0,(0)1
 5092      00003545 
 5093 7430 00000000 		or	%s60,0,%s57
 5093      B9003C45 
 5094 7438 00000000 		muls.l	%s46,4,%s60
 5094      BC042E6E 
 5095 7440 C8FDFFFF 		br.l	.L5.13
 5095      00000F18 
 5096              	.L5.68:
 5097 7448 10000000 		ldl.sx	%s18,16(,%s62)	# *(p).__b_N4conv6desc_tE.iw
 5097      BE001203 
 5098 7450 F0FFFFFF 		ld	%s58,-16(,%fp)	# kwe
 5098      89003A01 
 5099 7458 E8FFFFFF 		ld	%s51,-24(,%fp)	# kwb
 5099      89003301 
 5100 7460 58FFFFFF 		brlt.w	0,%s18,.L5.67
 5100      92008218 
 5101 7468 70FDFFFF 		br.l	.L5.65
 5101      00000F18 
 5102              	.L5.69:
 5103 7470 00000000 		or	%s56,0,%s42
 5103      AA003845 
 5104 7478 00000000 		or	%s49,0,%s41
 5104      A9003145 
 5105 7480 00000000 		or	%s60,0,%s40
 5105      A8003C45 
 5106 7488 00000000 		or	%s55,0,%s39
 5106      A7003745 
 5107 7490 00000000 		or	%s50,0,%s38
 5107      A6003245 
 5108 7498 B0FFFFFF 		br.l	.L5.68
 5108      00000F18 
 5109              	.L5.11:
 5110              	# line 1993
1993:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (khe[ih] > KH) khe[ih] = KH;
 5111              		.loc	1 1993 0
 5112 74a0 30000000 		ldl.sx	%s60,48(,%s62)	# *(p).__b_N4conv6desc_tE.ph
 5112      BE003C03 
 5113 74a8 00000000 		lvl	%s55
 5113      00B700BF 
 5114 74b0 002B0019 		vadds.w.sx	%v25,%s57,%v43
 5114      00B920CA 
 5115 74b8 00190018 		vadds.w.sx	%v24,%s60,%v25
 5115      00BC20CA 
 5116 74c0 00001817 		vdivs.w.sx	%v23,%v24,%s22
 5116      009610EB 
 5117 74c8 00170016 		vadds.w.sx	%v22,1,%v23
 5117      000120CA 
 5118 74d0 00000000 		adds.l	%s60,%s53,(0)1
 5118      00B53C59 
 5119 74d8 00000000 		adds.l	%s44,%s60,%s51
 5119      B3BC2C59 
 5120 74e0 00000016 		vstl.nc	%v22,4,%s44
 5120      AC040093 
 5121              	# line 1994
1994:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[ih] = khe[ih];
 5122              		.loc	1 1994 0
 5123 74e8 20000000 		ldl.sx	%s44,32(,%s62)	# *(p).__b_N4conv6desc_tE.kh
 5123      BE002C03 
 5124 74f0 00160015 		vmins.w.sx	%v21,%s44,%v22
 5124      00AC308A 
 5125 74f8 00000000 		adds.l	%s60,%s60,%s51
 5125      B3BC3C59 
 5126 7500 00000015 		vstl.nc	%v21,4,%s60
 5126      BC040093 
 5127              	# line 1995
1995:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 5128              		.loc	1 1995 0
 5129 7508 00000000 		adds.l	%s60,%s50,(0)1
 5129      00B23C59 
 5130 7510 00000000 		adds.l	%s44,%s60,%s51
 5130      B3BC2C59 
 5131 7518 00000015 		vstl.nc	%v21,4,%s44
 5131      AC040093 
 5132              	# line 1996
1996:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int kh_ibeg = khe[ih];
 5133              		.loc	1 1996 0
 5134 7520 30000000 		ldl.sx	%s44,48(,%s62)	# *(p).__b_N4conv6desc_tE.ph
 5134      BE002C03 
 5135 7528 002B0014 		vadds.w.sx	%v20,%s57,%v43
 5135      00B920CA 
 5136 7530 00140013 		vadds.w.sx	%v19,%s44,%v20
 5136      00AC20CA 
 5137 7538 00001312 		vdivs.w.sx	%v18,%v19,%s49
 5137      00B110EB 
 5138 7540 00120011 		vmuls.w.sx	%v17,%s49,%v18
 5138      00B120CB 
 5139 7548 00111310 		vsubs.w.sx	%v16,%v19,%v17
 5139      000000DA 
 5140 7550 0010040F 		vfmk.w.eq	%vm15,%v16
 5140      000000B5 
 5141              	# line 1999
1999:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int m = div_floor(kh_ibeg, khh);
 5142              		.loc	1 1999 0
 5143 7558 0012002A 		vmuls.w.sx	%v42,%s58,%v18,%vm15
 5143      00BA2FCB 
 5144              	# line 2000
2000:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kh_ibeg -= m * khh;
 5145              		.loc	1 2000 0
 5146 7560 00002A29 		vdivs.w.sx	%v41,%v42,%s59,%vm15
 5146      00BB1FEB 
 5147 7568 00290028 		vmuls.w.sx	%v40,%s59,%v41,%vm15
 5147      00BB2FCB 
 5148 7570 00282A27 		vsubs.w.sx	%v39,%v42,%v40,%vm15
 5148      00000FDA 
 5149 7578 0027050E 		vfmk.w.ge	%vm14,%v39,%vm15
 5149      00000FB5 
 5150 7580 00000026 		vbrd	%v38,0,%vm14
 5150      00000E8C 
 5151 7588 000F0E0E 		nndm	%vm14,%vm14,%vm15
 5151      00000094 
 5152 7590 00000026 		vbrd	%v38,1,%vm14
 5152      00010E8C 
 5153 7598 00002A25 		vdivs.w.sx	%v37,%v42,%s59,%vm15
 5153      00BB1FEB 
 5154 75a0 00262524 		vsubs.w.sx	%v36,%v37,%v38,%vm15
 5154      00000FDA 
 5155              	# line 2001
2001:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       int j = hb * mul + m * jhh; // var j --> 'm' again
 5156              		.loc	1 2001 0
 5157 75a8 00240023 		vmuls.w.sx	%v35,%s59,%v36,%vm15
 5157      00BB2FCB 
 5158 75b0 00232A22 		vsubs.w.sx	%v34,%v42,%v35,%vm15
 5158      00000FDA 
 5159              	# line 2002
2002:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       if (j >= OH) kh_ibeg += (j-OH)/jhh * khh + khh;
 5160              		.loc	1 2002 0
 5161 75b8 00120021 		vmuls.w.sx	%v33,%s56,%v18,%vm15
 5161      00B82FCB 
 5162 75c0 00240020 		vmuls.w.sx	%v32,%s48,%v36,%vm15
 5162      00B02FCB 
 5163 75c8 0020211F 		vadds.w.sx	%v31,%v33,%v32,%vm15
 5163      00000FCA 
 5164              	# line 2003
2003:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khb[ih] = kh_ibeg;
 5165              		.loc	1 2003 0
 5166 75d0 18000000 		ldl.sx	%s44,24(,%s62)	# *(p).__b_N4conv6desc_tE.oh
 5166      BE002C03 
 5167 75d8 001F001E 		vcmps.w.sx	%v30,%s44,%v31,%vm15
 5167      00AC2FFA 
 5168 75e0 001E060E 		vfmk.w.le	%vm14,%v30,%vm15
 5168      00000FB5 
 5169 75e8 00000000 		subs.w.sx	%s44,0,%s44
 5169      AC002C5A 
 5170 75f0 001F001D 		vadds.w.sx	%v29,%s44,%v31,%vm14
 5170      00AC2ECA 
 5171 75f8 00001D1C 		vdivs.w.sx	%v28,%v29,%s48,%vm14
 5171      00B01EEB 
 5172 7600 001C001B 		vmuls.w.sx	%v27,%s59,%v28,%vm14
 5172      00BB2ECB 
 5173 7608 001B221A 		vadds.w.sx	%v26,%v34,%v27,%vm14
 5173      00000ECA 
 5174 7610 001A0022 		vadds.w.sx	%v34,%s59,%v26,%vm14
 5174      00BB2ECA 
 5175              	# line 2004
2004:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 5176              		.loc	1 2004 0
 5177 7618 00000000 		adds.l	%s60,%s60,%s51
 5177      B3BC3C59 
 5178 7620 00000022 		vstl.nc	%v34,4,%s60,%vm15
 5178      BC040F93 
 5179              	# line 1992
1992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[ih] = (ih + PH) / DH + 1;
 5180              		.loc	1 1992 0
 5181 7628 00000000 		adds.w.sx	%s57,%s57,%s47
 5181      AFB9394A 
 5182 7630 00000000 		adds.l	%s51,%s51,%s46
 5182      AEB33359 
 5183 7638 00000000 		subs.w.sx	%s45,%s45,%s55
 5183      B7AD2D5A 
 5184 7640 30FEFFFF 		brge.w	0,%s45,.L5.69
 5184      AD008518 
 5185 7648 B0E4FFFF 		br.l	.L5.10
 5185      00000F18 
 5186              	.L5.70:
 5187 7650 00000000 		subs.w.sx	%s18,0,%s18
 5187      9200125A 
 5188 7658 00000000 		or	%s38,0,%s50
 5188      B2002645 
 5189 7660 00000000 		subs.w.sx	%s18,0,%s18
 5189      9200125A 
 5190 7668 00000000 		smvl	%s44
 5190      00002C2E 
 5191 7670 80000000 		mins.w.sx	%s44,%s18,%s44
 5191      AC922C78 
 5192 7678 00000000 		or	%s45,0,%s18
 5192      92002D45 
 5193 7680 00000000 		or	%s37,0,(0)1
 5193      00002545 
 5194 7688 00000000 		or	%s47,0,%s44
 5194      AC002F45 
 5195 7690 00000000 		lvl	%s44
 5195      00AC00BF 
 5196 7698 00000032 		vseq	%v50
 5196      00000099 
 5197 76a0 00000000 		or	%s50,0,%s57
 5197      B9003245 
 5198 76a8 00000000 		or	%s41,0,%s49
 5198      B1002945 
 5199 76b0 00000000 		or	%s49,0,%s2
 5199      82003145 
 5200 76b8 00000000 		or	%s42,0,%s56
 5200      B8002A45 
 5201 76c0 00000000 		or	%s56,0,%s1
 5201      81003845 
 5202 76c8 00000000 		or	%s39,0,%s55
 5202      B7002745 
 5203 76d0 00000000 		or	%s40,0,%s60
 5203      BC002845 
 5204 76d8 00000000 		or	%s55,0,%s44
 5204      AC003745 
 5205 76e0 00000000 		or	%s57,0,%s37
 5205      A5003945 
 5206 76e8 0032002B 		vor	%v43,(0)1,%v50
 5206      000020C5 
 5207 76f0 00000000 		or	%s51,0,(0)1
 5207      00003345 
 5208 76f8 00000000 		or	%s44,0,%s44
 5208      AC002C45 
 5209 7700 00000000 		muls.l	%s46,4,%s44
 5209      AC042E6E 
 5210 7708 98FDFFFF 		br.l	.L5.11
 5210      00000F18 
 5211              	.L5.71:
 5212              	# line 1988
1988:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OH_OW = OH * OW;
 5213              		.loc	1 1988 0
 5214 7710 08000000 		ldl.sx	%s60,8(,%s62)	# *(p).__b_N4conv6desc_tE.ic
 5214      BE003C03 
 5215 7718 00000000 		ldl.sx	%s57,0(,%s62)	# *(p).__b_N4conv6desc_tE.g
 5215      BE003903 
 5216 7720 00000000 		divs.w.sx	%s57,%s60,%s57
 5216      B9BC397B 
 5217              	# line 1989
1989:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int ICOG_KH_KW = ICOG * KH * KW;
 5218              		.loc	1 1989 0
 5219 7728 18000000 		ldl.sx	%s55,24(,%s62)	# *(p).__b_N4conv6desc_tE.oh
 5219      BE003703 
 5220 7730 1C000000 		ldl.sx	%s60,28(,%s62)	# *(p).__b_N4conv6desc_tE.ow
 5220      BE003C03 
 5221 7738 00000000 		muls.w.sx	%s60,%s55,%s60
 5221      BCB73C4B 
 5222              	# line 1990
1990:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 5223              		.loc	1 1990 0
 5224 7740 20000000 		ldl.sx	%s51,32(,%s62)	# *(p).__b_N4conv6desc_tE.kh
 5224      BE003303 
 5225 7748 00000000 		muls.w.sx	%s51,%s57,%s51
 5225      B3B9334B 
 5226 7750 24000000 		ldl.sx	%s55,36(,%s62)	# *(p).__b_N4conv6desc_tE.kw
 5226      BE003703 
 5227 7758 00000000 		muls.w.sx	%s55,%s51,%s55
 5227      B7B3374B 
 5228              	# line 1992
1992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khe[ih] = (ih + PH) / DH + 1;
 5229              		.loc	1 1992 0
 5230 7760 0C000000 		ldl.sx	%s18,12(,%s62)	# *(p).__b_N4conv6desc_tE.ih
 5230      BE001203 
 5231 7768 E0FFFFFF 		ld	%s53,-32(,%fp)	# khe
 5231      89003501 
 5232 7770 40FEFFFF 		ld	%s57,-448(,%fp)	# khb
 5232      89003901 
 5233 7778 D8FEFFFF 		brlt.w	0,%s18,.L5.70
 5233      92008218 
 5234 7780 C8FCFFFF 		br.l	.L5.68
 5234      00000F18 
 5235              	.L5.72:
 5236 7788 00000000 		or	%s62,0,%s3
 5236      83003E45 
 5237 7790 80FFFFFF 		br.l	.L5.71
 5237      00000F18 
 5238              	.L5.73:
 5239 7798 00000000 		or	%s60,0,%s51
 5239      B3003C45 
 5240              	.L5.74:
 5241              	# line 1984
1984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
 5242              		.loc	1 1984 0
 5243 77a0 00000000 		divs.w.sx	%s57,%s62,%s60
 5243      BCBE397B 
 5244 77a8 00000000 		muls.w.sx	%s51,%s60,%s57
 5244      B9BC334B 
 5245 77b0 00000000 		or	%s60,0,%s60
 5245      BC003C45 
 5246 77b8 00000000 		subs.w.sx	%s51,%s62,%s51
 5246      B3BE335A 
 5247 77c0 00000000 		or	%s62,0,%s60
 5247      BC003E45 
 5248 77c8 00000000 		muls.w.sx	%s60,%s57,%s55
 5248      B7B93C4B 
 5249 77d0 00000000 		subs.w.sx	%s60,%s54,%s60
 5249      BCB63C5A 
 5250 77d8 00000000 		or	%s54,0,%s55
 5250      B7003645 
 5251 77e0 00000000 		or	%s55,0,%s60
 5251      BC003745 
 5252 77e8 00000000 		muls.w.sx	%s57,%s57,%s53
 5252      B5B9394B 
 5253 77f0 00000000 		subs.w.sx	%s57,%s52,%s57
 5253      B9B4395A 
 5254 77f8 00000000 		or	%s52,0,%s53
 5254      B5003445 
 5255 7800 00000000 		or	%s53,0,%s57
 5255      B9003545 
 5256 7808 90FFFFFF 		brne.w	0,%s51,.L5.73
 5256      B3008318 
 5257 7810 78FFFFFF 		br.l	.L5.72
 5257      00000F18 
 5258              	.L5.75:
 5259 7818 00000000 		or	%s3,0,%s62
 5259      BE000345 
 5260 7820 00000000 		or	%s62,0,%s57
 5260      B9003E45 
 5261 7828 78FFFFFF 		br.l	.L5.74
 5261      00000F18 
 5262              	.L5.8:
 5263              	# line 1980
1980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int kww = lcm_w / DW;
 5264              		.loc	1 1980 0
 5265 7830 2C000000 		ldl.sx	%s57,44(,%s62)	# *(p).__b_N4conv6desc_tE.sw
 5265      BE003903 
 5266 7838 00000000 		muls.w.sx	%s51,%s57,%s63
 5266      BFB9334B 
 5267 7840 00000000 		or	%s60,0,%s63
 5267      BF003C45 
 5268 7848 00000000 		divs.w.sx	%s61,%s51,%s50
 5268      B2B33D7B 
 5269              	# line 1981
1981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int jww = lcm_w / SW;
 5270              		.loc	1 1981 0
 5271 7850 00000000 		divs.w.sx	%s56,%s61,%s63
 5271      BFBD387B 
 5272              	# line 1982
1982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int wa, wb, wg;
 5273              		.loc	1 1982 0
 5274 7858 00000000 		divs.w.sx	%s49,%s61,%s57
 5274      B9BD317B 
 5275              	# line 1984
1984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( wg == gcd_w );
 5276              		.loc	1 1984 0
 5277 7860 00000000 		or	%s55,1,(0)1
 5277      00013745 
 5278 7868 00000000 		or	%s52,1,(0)1
 5278      00013445 
 5279 7870 00000000 		or	%s53,0,(0)1
 5279      00003545 
 5280 7878 00000000 		or	%s54,0,(0)1
 5280      00003645 
 5281 7880 98FFFFFF 		brne.w	0,%s63,.L5.75
 5281      BF008318 
 5282 7888 88FEFFFF 		br.l	.L5.71
 5282      00000F18 
 5283              	.L5.76:
 5284 7890 00000000 		or	%s50,0,%s62
 5284      BE003245 
 5285 7898 00000000 		or	%s62,0,%s60
 5285      BC003E45 
 5286 78a0 00000000 		or	%s63,0,%s1
 5286      81003F45 
 5287 78a8 00000000 		or	%s1,0,%s56
 5287      B8000145 
 5288 78b0 00000000 		or	%s2,0,%s49
 5288      B1000245 
 5289 78b8 78FFFFFF 		br.l	.L5.8
 5289      00000F18 
 5290              	.L5.6:
 5291 78c0 D0FFFFFF 		breq.w	0,%s18,.L5.76
 5291      92008418 
 5292 78c8 08E2FFFF 		br.l	.L5.9
 5292      00000F18 
 5293              	.L5.77:
 5294              	# line 1978
1978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int gcd_w = gcd( SW, DW );
 5295              		.loc	1 1978 0
 5296 78d0 3C000000 		ldl.sx	%s63,60(,%s60)	# *(p).__b_N4conv6desc_tE.dw
 5296      BC003F03 
 5297 78d8 00000000 		adds.w.sx	%s63,1,%s63
 5297      BF013F4A 
 5298 78e0 00000000 		or	%s62,0,%s63
 5298      BF003E45 
 5299              	# line 1979
1979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int lcm_w = SW * DW/gcd_w;
 5300              		.loc	1 1979 0
 5301 78e8 2C000000 		ldl.sx	%s18,44(,%s60)	# *(p).__b_N4conv6desc_tE.sw
 5301      BC001203 
 5302 78f0 00000000 		or	%s1,0,%s63
 5302      BF000145 
 5303 78f8 C8FFFFFF 		br.l	.L5.6
 5303      00000F18 
 5304              	.L5.78:
 5305 7900 00000000 		or	%s60,0,%s1
 5305      81003C45 
 5306 7908 C8FFFFFF 		br.l	.L5.77
 5306      00000F18 
 5307              	.L5.79:
 5308 7910 00000000 		or	%s62,0,%s55
 5308      B7003E45 
 5309              	.L5.80:
 5310              	# line 1975
1975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
 5311              		.loc	1 1975 0
 5312 7918 00000000 		divs.w.sx	%s61,%s63,%s62
 5312      BEBF3D7B 
 5313 7920 00000000 		muls.w.sx	%s55,%s62,%s61
 5313      BDBE374B 
 5314 7928 00000000 		or	%s62,0,%s62
 5314      BE003E45 
 5315 7930 00000000 		subs.w.sx	%s55,%s63,%s55
 5315      B7BF375A 
 5316 7938 00000000 		or	%s63,0,%s62
 5316      BE003F45 
 5317 7940 00000000 		muls.w.sx	%s62,%s61,%s60
 5317      BCBD3E4B 
 5318 7948 00000000 		subs.w.sx	%s62,%s58,%s62
 5318      BEBA3E5A 
 5319 7950 00000000 		or	%s58,0,%s60
 5319      BC003A45 
 5320 7958 00000000 		or	%s60,0,%s62
 5320      BE003C45 
 5321 7960 00000000 		muls.w.sx	%s61,%s61,%s57
 5321      B9BD3D4B 
 5322 7968 00000000 		subs.w.sx	%s61,%s56,%s61
 5322      BDB83D5A 
 5323 7970 00000000 		or	%s56,0,%s57
 5323      B9003845 
 5324 7978 00000000 		or	%s57,0,%s61
 5324      BD003945 
 5325 7980 90FFFFFF 		brne.w	0,%s55,.L5.79
 5325      B7008318 
 5326 7988 78FFFFFF 		br.l	.L5.78
 5326      00000F18 
 5327              	.L5.81:
 5328 7990 00000000 		or	%s1,0,%s60
 5328      BC000145 
 5329 7998 00000000 		or	%s60,0,%s61
 5329      BD003C45 
 5330 79a0 78FFFFFF 		br.l	.L5.80
 5330      00000F18 
 5331              	.L5.3:
 5332              	# line 1970
1970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int khh = lcm_h / DH;
 5333              		.loc	1 1970 0
 5334 79a8 28000000 		ldl.sx	%s63,40(,%s60)	# *(p).__b_N4conv6desc_tE.sh
 5334      BC003F03 
 5335 79b0 00000000 		muls.w.sx	%s61,%s63,%s22
 5335      96BF3D4B 
 5336 79b8 00000000 		or	%s62,0,%s22
 5336      96003E45 
 5337 79c0 00000000 		divs.w.sx	%s61,%s61,%s49
 5337      B1BD3D7B 
 5338              	# line 1971
1971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 5339              		.loc	1 1971 0
 5340 79c8 00000000 		divs.w.sx	%s59,%s61,%s22
 5340      96BD3B7B 
 5341              	# line 1973
1973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ha, hb, hg;
 5342              		.loc	1 1973 0
 5343 79d0 00000000 		divs.w.sx	%s48,%s61,%s63
 5343      BFBD307B 
 5344              	# line 1975
1975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   DMUST( hg == gcd_h );
 5345              		.loc	1 1975 0
 5346 79d8 00000000 		or	%s61,1,(0)1
 5346      00013D45 
 5347 79e0 00000000 		or	%s56,1,(0)1
 5347      00013845 
 5348 79e8 00000000 		or	%s57,0,(0)1
 5348      00003945 
 5349 79f0 00000000 		or	%s58,0,(0)1
 5349      00003A45 
 5350 79f8 98FFFFFF 		brne.w	0,%s22,.L5.81
 5350      96008318 
 5351 7a00 D0FEFFFF 		br.l	.L5.77
 5351      00000F18 
 5352              	.L5.82:
 5353 7a08 00000000 		or	%s49,0,%s63
 5353      BF003145 
 5354 7a10 00000000 		or	%s60,0,%s1
 5354      81003C45 
 5355 7a18 90FFFFFF 		br.l	.L5.3
 5355      00000F18 
 5356              	.L5.0:
 5357 7a20 E8FFFFFF 		breq.w	0,%s18,.L5.82
 5357      92008418 
 5358 7a28 30E0FFFF 		br.l	.L5.4
 5358      00000F18 
 5359              		.cfi_endproc
 5360              		.set	.L.6.2auto_size,	0xffffffffffffd770	# 10384 Bytes
 5362              	.L_FE.6:
 5363 7a30 636F6E76 		.string	"conv::sxconv_3_bwd_d_generic\000on"
 5363      3A3A7378 
 5363      636F6E76 
 5363      5F335F62 
 5363      77645F64 
 5364              	# ============ End  conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 5365              	# ============ Begin  conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 5366              		.data
 5367              		.balign 16
 5370              	.LP._ZN4conv14sxconv_3_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0:
 5371 0120 00000000 		.long	__vla_dealloc_eh
 5371      00000000 
 5372 0128 0000     		.zero	2
 5373 012a FFFF     		.short	65535
 5374 012c 04       		.byte	4
 5375 012d 000000   		.zero	3
 5376 0130 00000000 		.long	__vla_dealloc_eh
 5376      00000000 
 5377 0138 0100     		.short	1
 5378 013a 0000     		.zero	2
 5379 013c 04       		.byte	4
 5380 013d 000000   		.zero	3
 5381 0140 00000000 		.long	__vla_dealloc_eh
 5381      00000000 
 5382 0148 0200     		.short	2
 5383 014a 0100     		.short	1
 5384 014c 04       		.byte	4
 5385 014d 000000   		.zero	3
 5386 0150 00000000 		.long	__vla_dealloc_eh
 5386      00000000 
 5387 0158 0300     		.short	3
 5388 015a 0200     		.short	2
 5389 015c 04       		.byte	4
 5390 015d 000000   		.zero	3
 5391 0160 00000000 		.long	__vla_dealloc_eh
 5391      00000000 
 5392 0168 0400     		.short	4
 5393 016a 0300     		.short	3
 5394 016c 04       		.byte	4
 5395 016d 000000   		.zero	3
 5396 0170 00000000 		.long	__vla_dealloc_eh
 5396      00000000 
 5397 0178 0500     		.short	5
 5398 017a 0400     		.short	4
 5399 017c 04       		.byte	4
 5400 017d 000000   		.zero	3
 5401              		.text
 5402              		.balign 16
 5403              	# line 2106
2106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 && defined(__ve) // compiler bug! XXX TODO temporarily disabled
 5404              		.loc	1 2106 0
 5405              		.globl	conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 5407 7a50 50240000 		.long	.L_FE.7-8-.
 5407      00000000 
 5408              	conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 5409              		.cfi_startproc
 5410 7a58 00000000 		st	%fp,0x0(,%sp)
 5410      8B000911 
 5411              		.cfi_def_cfa_offset	0
 5412              		.cfi_offset	9,0
 5413 7a60 08000000 		st	%lr,0x8(,%sp)
 5413      8B000A11 
 5414 7a68 18000000 		st	%got,0x18(,%sp)
 5414      8B000F11 
 5415 7a70 20000000 		st	%plt,0x20(,%sp)
 5415      8B001011 
 5416 7a78 00000000 		or	%fp,0,%sp
 5416      8B000945 
 5417              		.cfi_def_cfa_register	9
 5418 7a80 30000000 		st	%s18,48(,%fp)
 5418      89001211 
 5419 7a88 38000000 		st	%s19,56(,%fp)
 5419      89001311 
 5420 7a90 40000000 		st	%s20,64(,%fp)
 5420      89001411 
 5421 7a98 48000000 		st	%s21,72(,%fp)
 5421      89001511 
 5422 7aa0 50000000 		st	%s22,80(,%fp)
 5422      89001611 
 5423 7aa8 58000000 		st	%s23,88(,%fp)
 5423      89001711 
 5424 7ab0 60000000 		st	%s24,96(,%fp)
 5424      89001811 
 5425 7ab8 68000000 		st	%s25,104(,%fp)
 5425      89001911 
 5426 7ac0 70000000 		st	%s26,112(,%fp)
 5426      89001A11 
 5427 7ac8 78000000 		st	%s27,120(,%fp)
 5427      89001B11 
 5428 7ad0 80000000 		st	%s28,128(,%fp)
 5428      89001C11 
 5429 7ad8 88000000 		st	%s29,136(,%fp)
 5429      89001D11 
 5430 7ae0 90000000 		st	%s30,144(,%fp)
 5430      89001E11 
 5431 7ae8 98000000 		st	%s31,152(,%fp)
 5431      89001F11 
 5432 7af0 A0000000 		st	%s32,160(,%fp)
 5432      89002011 
 5433 7af8 A8000000 		st	%s33,168(,%fp)
 5433      89002111 
 5434 7b00 F0B7FFFF 		lea	%s13,.L.7.2auto_size&0xffffffff
 5434      00000D06 
 5435 7b08 00000000 		and	%s13,%s13,(32)0
 5435      608D0D44 
 5436 7b10 FFFFFFFF 		lea.sl	%sp,.L.7.2auto_size>>32(%fp,%s13)
 5436      8D898B06 
 5437 7b18 48000000 		brge.l.t	%sp,%sl,.L6.EoP
 5437      888B3518 
 5438 7b20 18000000 		ld	%s61,0x18(,%tp)
 5438      8E003D01 
 5439 7b28 00000000 		or	%s62,0,%s0
 5439      80003E45 
 5440 7b30 3B010000 		lea	%s63,0x13b
 5440      00003F06 
 5441 7b38 00000000 		shm.l	%s63,0x0(%s61)
 5441      BD033F31 
 5442 7b40 08000000 		shm.l	%sl,0x8(%s61)
 5442      BD030831 
 5443 7b48 10000000 		shm.l	%sp,0x10(%s61)
 5443      BD030B31 
 5444 7b50 00000000 		monc
 5444      0000003F 
 5445 7b58 00000000 		or	%s0,0,%s62
 5445      BE000045 
 5446              	.L6.EoP:
 5447              	# End of prologue codes
 5448 7b60 10ECFFFF 		st	%s0,-5104(,%fp)	# spill 
 5448      89000011 
 5449 7b68 08ECFFFF 		st	%s3,-5112(,%fp)	# spill 
 5449      89000311 
 5450 7b70 00ECFFFF 		st	%s2,-5120(,%fp)	# spill 
 5450      89000211 
 5451 7b78 F8EBFFFF 		st	%s1,-5128(,%fp)	# spill 
 5451      89000111 
 5452 7b80 00000000 		lea	%s0,conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 5452      00000006 
 5453 7b88 00000000 		and	%s0,%s0,(32)0
 5453      60800044 
 5454 7b90 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 5454      80008006 
 5455 7b98 08000000 		ld	%s1,8(,%fp)	# ptr
 5455      89000101 
 5456 7ba0 00000000 		lea	%s12,__ftrace_func_enter@LO
 5456      00000C06 
 5457 7ba8 00000000 		and	%s12,%s12,(32)0
 5457      608C0C44 
 5458 7bb0 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
 5458      8C008C06 
 5459 7bb8 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
 5459      8C000A08 
 5460 7bc0 00000000 		lea	%s63,__curr_eh_stack_entry@LO
 5460      00003F06 
 5461 7bc8 00000000 		and	%s63,%s63,(32)0
 5461      60BF3F44 
 5462 7bd0 00000000 		lea.sl	%s63,__curr_eh_stack_entry@HI(,%s63)
 5462      BF00BF06 
 5463 7bd8 00000000 		ld	%s62,0(,%s63)
 5463      BF003E01 
 5464 7be0 F8EBFFFF 		ld	%s1,-5128(,%fp)	# restore 
 5464      89000101 
 5465 7be8 20FEFFFF 		st	%s62,-480(,%fp)
 5465      89003E11 
 5466 7bf0 20FEFFFF 		lea	%s62,-480
 5466      00003E06 
 5467 7bf8 00000000 		adds.l	%s62,%fp,%s62
 5467      BE893E59 
 5468 7c00 00ECFFFF 		ld	%s2,-5120(,%fp)	# restore 
 5468      89000201 
 5469 7c08 00000000 		st	%s62,0(,%s63)
 5469      BF003E11 
 5470 7c10 00000000 		or	%s63,1,(0)1
 5470      00013F45 
 5471 7c18 08ECFFFF 		ld	%s3,-5112(,%fp)	# restore 
 5471      89000301 
 5472 7c20 28FEFFFF 		st1b	%s63,-472(,%fp)
 5472      89003F15 
 5473 7c28 00000000 		lea	%s63,.LP._ZN4conv14sxconv_3_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@LO
 5473      00003F06 
 5474 7c30 00000000 		and	%s63,%s63,(32)0
 5474      60BF3F44 
 5475 7c38 00000000 		lea.sl	%s63,.LP._ZN4conv14sxconv_3_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@HI(,%s63)
 5475      BF00BF06 
 5476 7c40 30FEFFFF 		st	%s63,-464(,%fp)
 5476      89003F11 
 5477 7c48 B0FFFFFF 		lea	%s63,-80
 5477      00003F06 
 5478 7c50 00000000 		adds.l	%s63,%fp,%s63
 5478      BF893F59 
 5479 7c58 10ECFFFF 		ld	%s51,-5104(,%fp)	# restore 
 5479      89003301 
 5480 7c60 38FEFFFF 		st	%s63,-456(,%fp)
 5480      89003F11 
 5481 7c68 00000000 		lea	%s63,__eh_curr_region@LO
 5481      00003F06 
 5482 7c70 00000000 		and	%s63,%s63,(32)0
 5482      60BF3F44 
 5483 7c78 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 5483      BF00BF06 
 5484 7c80 00000000 		ld2b.zx	%s62,0(,%s63)
 5484      BF00BE04 
 5485 7c88 48FEFFFF 		st2b	%s62,-440(,%fp)
 5485      89003E14 
 5486 7c90 FFFF0000 		lea	%s62,65535
 5486      00003E06 
 5487 7c98 00000000 		st2b	%s62,0(,%s63)
 5487      BF003E14 
 5488              	# line 2110
2110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pwei = (float*)wei_m;
 5489              		.loc	1 2110 0
 5490 7ca0 A8010000 		ld	%s42,424(,%s1)	# *(diff_src_m).data_
 5490      81002A01 
 5491              	# line 2111
2111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //float const * restrict const pbia = (float*)bia_m;
 5492              		.loc	1 2111 0
 5493 7ca8 A8010000 		ld	%s53,424(,%s2)	# *(wei_m).data_
 5493      82003501 
 5494              	# line 2113
2113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1 // a new simplification of loop limits (same speed as above)
 5495              		.loc	1 2113 0
 5496 7cb0 A8010000 		ld	%s52,424(,%s3)	# *(diff_dst_m).data_
 5496      83003401 
 5497              	# line 2116
2116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // FIXME can we call this even less?
 5498              		.loc	1 2116 0
 5499 7cb8 38000000 		ldl.sx	%s18,56(,%s51)	# *(p).__b_N4conv6desc_tE.dh
 5499      B3001203 
 5500 7cc0 C0210000 		brne.w	0,%s18,.L6.0
 5500      92008318 
 5501 7cc8 30200000 		br.l	.L6.1
 5501      00000F18 
 5502              	.L6.2:
 5503              	# line 2167
2167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //int ocend = (OC/G);
 5504              		.loc	1 2167 0
 5505 7cd0 80000000 		mins.w.sx	%s61,%s48,%s61
 5505      BDB03D78 
 5506 7cd8 701B0000 		br.l	.L6.3
 5506      00000F18 
 5507              	.L6.4:
 5508              	# line 2179
2179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = iw + PW;
 5509              		.loc	1 2179 0
 5510 7ce0 80000000 		mins.w.sx	%s61,%s47,%s61
 5510      BDAF3D78 
 5511 7ce8 A8170000 		br.l	.L6.5
 5511      00000F18 
 5512              	.L6.6:
 5513              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 5514              		.loc	1 2211 0
 5515 7cf0 80000000 		mins.w.sx	%s62,%s47,%s62
 5515      BEAF3E78 
 5516 7cf8 08100000 		br.l	.L6.7
 5516      00000F18 
 5517              	.L6.8:
 5518 7d00 80000000 		mins.l	%s60,%s55,%s60
 5518      BCB73C68 
 5519 7d08 300E0000 		br.l	.L6.9
 5519      00000F18 
 5520              	.L6.10:
 5521 7d10 80000000 		mins.w.sx	%s62,%s6,%s62
 5521      BE863E78 
 5522 7d18 D8070000 		br.l	.L6.11
 5522      00000F18 
 5523              	.L6.12:
 5524 7d20 80000000 		mins.l	%s59,%s47,%s59
 5524      BBAF3B68 
 5525 7d28 48040000 		br.l	.L6.13
 5525      00000F18 
 5526              	.L6.14:
 5527 7d30 00000000 		lea	%s63,__eh_curr_region@LO
 5527      00003F06 
 5528 7d38 00000000 		and	%s63,%s63,(32)0
 5528      60BF3F44 
 5529 7d40 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 5529      BF00BF06 
 5530 7d48 48FEFFFF 		ld2b.zx	%s62,-440(,%fp)
 5530      8900BE04 
 5531 7d50 00000000 		st2b	%s62,0(,%s63)
 5531      BF003E14 
 5532 7d58 20FEFFFF 		ld	%s63,-480(,%fp)
 5532      89003F01 
 5533 7d60 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 5533      00003E06 
 5534 7d68 00000000 		and	%s62,%s62,(32)0
 5534      60BE3E44 
 5535 7d70 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 5535      BE00BE06 
 5536 7d78 00000000 		st	%s63,0(,%s62)
 5536      BE003F11 
 5537 7d80 981F0000 		br.l	.L6.15
 5537      00000F18 
 5538              	.L6.16:
 5539 7d88 28150000 		br.l	.L6.17
 5539      00000F18 
 5540              	.L6.18:
 5541              	# line 2190
2190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 5542              		.loc	1 2190 0
 5543 7d90 00000000 		adds.l	%s60,1,%s60
 5543      BC013C59 
 5544 7d98 00000000 		adds.l	%s58,%s57,%s58
 5544      BAB93A59 
 5545 7da0 00000000 		adds.l	%s48,%s55,%s48
 5545      B0B73059 
 5546 7da8 00000000 		adds.l	%s39,%s18,%s39
 5546      A7922759 
 5547 7db0 D8FFFFFF 		brgt.l	0,%s60,.L6.16
 5547      BC000118 
 5548 7db8 78FFFFFF 		br.l	.L6.14
 5548      00000F18 
 5549              	.L6.19:
 5550 7dc0 40ECFFFF 		ld	%s60,-5056(,%fp)	# restore 
 5550      89003C01 
 5551 7dc8 38ECFFFF 		ld	%s55,-5064(,%fp)	# restore 
 5551      89003701 
 5552 7dd0 30ECFFFF 		ld	%s48,-5072(,%fp)	# restore 
 5552      89003001 
 5553 7dd8 88EDFFFF 		ld	%s18,-4728(,%fp)	# restore 
 5553      89001201 
 5554 7de0 28ECFFFF 		ld	%s39,-5080(,%fp)	# restore 
 5554      89002701 
 5555 7de8 48ECFFFF 		ld	%s22,-5048(,%fp)	# restore 
 5555      89001601 
 5556 7df0 20ECFFFF 		ld	%s38,-5088(,%fp)	# restore 
 5556      89002601 
 5557 7df8 18ECFFFF 		ld	%s37,-5096(,%fp)	# restore 
 5557      89002501 
 5558 7e00 90FFFFFF 		br.l	.L6.18
 5558      00000F18 
 5559              	.L6.20:
 5560              	# line 2191
2191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 5561              		.loc	1 2191 0
 5562 7e08 00000000 		adds.l	%s60,1,%s60
 5562      BC013C59 
 5563 7e10 00000000 		adds.l	%s48,%s57,%s48
 5563      B0B93059 
 5564 7e18 00000000 		adds.l	%s53,%s41,%s53
 5564      B5A93559 
 5565 7e20 00140000 		brgt.l	0,%s60,.L6.21
 5565      BC000118 
 5566 7e28 98FFFFFF 		br.l	.L6.19
 5566      00000F18 
 5567              	.L6.22:
 5568 7e30 68ECFFFF 		ld	%s60,-5016(,%fp)	# restore 
 5568      89003C01 
 5569 7e38 78ECFFFF 		ld	%s57,-5000(,%fp)	# restore 
 5569      89003901 
 5570 7e40 60ECFFFF 		ld	%s41,-5024(,%fp)	# restore 
 5570      89002901 
 5571 7e48 70ECFFFF 		ld	%s21,-5008(,%fp)	# restore 
 5571      89001501 
 5572 7e50 58ECFFFF 		ld	%s40,-5032(,%fp)	# restore 
 5572      89002801 
 5573 7e58 50ECFFFF 		ld	%s39,-5040(,%fp)	# restore 
 5573      89002701 
 5574 7e60 A8FFFFFF 		br.l	.L6.20
 5574      00000F18 
 5575              	.L6.23:
 5576              	# line 2192
2192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 5577              		.loc	1 2192 0
 5578 7e68 00000000 		adds.l	%s60,1,%s60
 5578      BC013C59 
 5579 7e70 00000000 		adds.l	%s57,%s56,%s57
 5579      B9B83959 
 5580 7e78 00000000 		adds.l	%s55,1,%s55
 5580      B7013759 
 5581 7e80 48130000 		brgt.l	0,%s60,.L6.24
 5581      BC000118 
 5582 7e88 A8FFFFFF 		br.l	.L6.22
 5582      00000F18 
 5583              	.L6.25:
 5584 7e90 C0ECFFFF 		ld	%s60,-4928(,%fp)	# restore 
 5584      89003C01 
 5585 7e98 B8ECFFFF 		ld	%s56,-4936(,%fp)	# restore 
 5585      89003801 
 5586 7ea0 B0ECFFFF 		ld	%s55,-4944(,%fp)	# restore 
 5586      89003701 
 5587 7ea8 C8ECFFFF 		ld	%s20,-4920(,%fp)	# restore 
 5587      89001401 
 5588 7eb0 A0ECFFFF 		ld	%s54,-4960(,%fp)	# restore 
 5588      89003601 
 5589 7eb8 90ECFFFF 		ld	%s44,-4976(,%fp)	# restore 
 5589      89002C01 
 5590 7ec0 80ECFFFF 		ld	%s42,-4992(,%fp)	# restore 
 5590      89002A01 
 5591 7ec8 88ECFFFF 		ld	%s43,-4984(,%fp)	# restore 
 5591      89002B01 
 5592 7ed0 98ECFFFF 		ld	%s48,-4968(,%fp)	# restore 
 5592      89003001 
 5593 7ed8 A8ECFFFF 		ld	%s58,-4952(,%fp)	# restore 
 5593      89003A01 
 5594 7ee0 88FFFFFF 		br.l	.L6.23
 5594      00000F18 
 5595              	.L6.26:
 5596              	# line 2193
2193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 5597              		.loc	1 2193 0
 5598 7ee8 00000000 		adds.l	%s60,1,%s60
 5598      BC013C59 
 5599 7ef0 00000000 		adds.l	%s56,%s59,%s56
 5599      B8BB3859 
 5600 7ef8 00000000 		adds.l	%s55,4,%s55
 5600      B7043759 
 5601 7f00 18120000 		brgt.l	0,%s60,.L6.27
 5601      BC000118 
 5602 7f08 88FFFFFF 		br.l	.L6.25
 5602      00000F18 
 5603              	.L6.28:
 5604 7f10 08EDFFFF 		ld	%s60,-4856(,%fp)	# restore 
 5604      89003C01 
 5605 7f18 00EDFFFF 		ld	%s59,-4864(,%fp)	# restore 
 5605      89003B01 
 5606 7f20 F8ECFFFF 		ld	%s56,-4872(,%fp)	# restore 
 5606      89003801 
 5607 7f28 F0ECFFFF 		ld	%s55,-4880(,%fp)	# restore 
 5607      89003701 
 5608 7f30 10EDFFFF 		ld	%s19,-4848(,%fp)	# restore 
 5608      89001301 
 5609 7f38 E8ECFFFF 		ld	%s49,-4888(,%fp)	# restore 
 5609      89003101 
 5610 7f40 E0ECFFFF 		ld	%s47,-4896(,%fp)	# restore 
 5610      89002F01 
 5611 7f48 D8ECFFFF 		ld	%s46,-4904(,%fp)	# restore 
 5611      89002E01 
 5612 7f50 D0ECFFFF 		ld	%s45,-4912(,%fp)	# restore 
 5612      89002D01 
 5613 7f58 90FFFFFF 		br.l	.L6.26
 5613      00000F18 
 5614              	.L6.29:
 5615              	# line 2219
2219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
 5616              		.loc	1 2219 0
 5617 7f60 00000000 		stu	%s56,0(%s60,%s55)	# *(pdiff_src)
 5617      B7BC3812 
 5618              	# line 2196
2196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 5619              		.loc	1 2196 0
 5620 7f68 00000000 		adds.l	%s54,1,%s54
 5620      B6013659 
 5621 7f70 00000000 		adds.l	%s60,4,%s60
 5621      BC043C59 
 5622 7f78 F8100000 		brgt.l	0,%s54,.L6.30
 5622      B6000118 
 5623 7f80 90FFFFFF 		br.l	.L6.28
 5623      00000F18 
 5624              	.L6.31:
 5625 7f88 B8EDFFFF 		ld	%s56,-4680(,%fp)	# restore 
 5625      89003801 
 5626 7f90 58EDFFFF 		ld	%s55,-4776(,%fp)	# restore 
 5626      89003701 
 5627 7f98 40EDFFFF 		ld	%s60,-4800(,%fp)	# restore 
 5627      89003C01 
 5628 7fa0 50EDFFFF 		ld	%s54,-4784(,%fp)	# restore 
 5628      89003601 
 5629 7fa8 70EDFFFF 		ld	%s63,-4752(,%fp)	# restore 
 5629      89003F01 
 5630 7fb0 48EDFFFF 		ld	%s19,-4792(,%fp)	# restore 
 5630      89001301 
 5631 7fb8 38EDFFFF 		ld	%s50,-4808(,%fp)	# restore 
 5631      89003201 
 5632 7fc0 30EDFFFF 		ld	%s61,-4816(,%fp)	# restore 
 5632      89003D01 
 5633 7fc8 68EDFFFF 		ld	%s20,-4760(,%fp)	# restore 
 5633      89001401 
 5634 7fd0 60EDFFFF 		ld	%s48,-4768(,%fp)	# restore 
 5634      89003001 
 5635 7fd8 20EDFFFF 		ld	%s52,-4832(,%fp)	# restore 
 5635      89003401 
 5636 7fe0 18EDFFFF 		ld	%s51,-4840(,%fp)	# restore 
 5636      89003301 
 5637 7fe8 28EDFFFF 		ld	%s58,-4824(,%fp)	# restore 
 5637      89003A01 
 5638 7ff0 70FFFFFF 		br.l	.L6.29
 5638      00000F18 
 5639              	.L6.32:
 5640              	# line 2216
2216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
 5641              		.loc	1 2216 0
 5642 7ff8 00000000 		adds.w.sx	%s63,-1,%s63
 5642      BF7F3F4A 
 5643              	# line 2205
2205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 5644              		.loc	1 2205 0
 5645 8000 00000000 		adds.w.sx	%s60,%s62,%s60
 5645      BCBE3C4A 
 5646 8008 00000000 		adds.w.sx	%s59,%s59,%s62
 5646      BEBB3B4A 
 5647 8010 000F0000 		brgt.w	0,%s60,.L6.33
 5647      BC008118 
 5648 8018 70FFFFFF 		br.l	.L6.31
 5648      00000F18 
 5649              	.L6.34:
 5650 8020 88EDFFFF 		st	%s18,-4728(,%fp)	# spill 
 5650      89001211 
 5651 8028 90EDFFFF 		st	%s41,-4720(,%fp)	# spill 
 5651      89002911 
 5652 8030 98EDFFFF 		st	%s40,-4712(,%fp)	# spill 
 5652      89002811 
 5653 8038 A0EDFFFF 		st	%s39,-4704(,%fp)	# spill 
 5653      89002711 
 5654 8040 A8EDFFFF 		st	%s58,-4696(,%fp)	# spill 
 5654      89003A11 
 5655 8048 B0EDFFFF 		st	%s61,-4688(,%fp)	# spill 
 5655      89003D11 
 5656              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 5657              		.loc	1 2213 0
 5658 8050 00000027 		lvs	%s56,%v39(0)
 5658      0000389E 
 5659              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 5660              		.loc	1 2206 0
 5661 8058 00000000 		subs.l	%s0,0,%s29
 5661      9D00005B 
 5662 8060 B8EDFFFF 		st	%s56,-4680(,%fp)	# spill 
 5662      89003811 
 5663 8068 00000000 		lea	%s12,__grow_stack@LO
 5663      00000C06 
 5664 8070 00000000 		and	%s12,%s12,(32)0
 5664      608C0C44 
 5665 8078 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 5665      8C008C06 
 5666 8080 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 5666      8C000A08 
 5667 8088 00000000 		or	%s63,0,%s35
 5667      A3003F45 
 5668 8090 00000000 		or	%s62,0,%s37
 5668      A5003E45 
 5669 8098 00000000 		or	%s60,0,%s38
 5669      A6003C45 
 5670 80a0 00000000 		or	%s59,0,%s36
 5670      A4003B45 
 5671 80a8 00000000 		or	%s18,0,%s30
 5671      9E001245 
 5672 80b0 00000000 		or	%s20,0,%s31
 5672      9F001445 
 5673 80b8 00000000 		or	%s19,0,%s34
 5673      A2001345 
 5674 80c0 80EDFFFF 		ld	%s57,-4736(,%fp)	# restore 
 5674      89003901 
 5675 80c8 78EDFFFF 		ld	%s53,-4744(,%fp)	# restore 
 5675      89003501 
 5676 80d0 28FFFFFF 		br.l	.L6.32
 5676      00000F18 
 5677              	.L6.35:
 5678              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 5679              		.loc	1 2211 0
 5680 80d8 00000000 		adds.l	%s62,8,%s62
 5680      BE083E59 
 5681 80e0 00000000 		adds.w.sx	%s42,-1,%s42
 5681      AA7F2A4A 
 5682 80e8 C8020000 		brlt.w	0,%s42,.L6.36
 5682      AA008218 
 5683 80f0 30FFFFFF 		br.l	.L6.34
 5683      00000F18 
 5684              	.L6.37:
 5685 80f8 00000000 		or	%s62,0,%s20
 5685      94003E45 
 5686 8100 00000000 		or	%s63,0,%s1
 5686      81003F45 
 5687 8108 00000000 		or	%s59,0,%s2
 5687      82003B45 
 5688 8110 00000000 		or	%s56,0,%s3
 5688      83003845 
 5689 8118 00000000 		or	%s55,0,%s4
 5689      84003745 
 5690 8120 00000000 		or	%s54,0,%s5
 5690      85003645 
 5691 8128 00000000 		or	%s52,0,%s6
 5691      86003445 
 5692 8130 00000000 		or	%s51,0,%s7
 5692      87003345 
 5693 8138 00000000 		or	%s50,0,%s19
 5693      93003245 
 5694              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 5695              		.loc	1 2213 0
 5696 8140 00000000 		lvl	%s46
 5696      00AE00BF 
 5697 8148 00003C26 		vfsum.s	%v38,%v60
 5697      000080EC 
 5698 8150 00000000 		or	%s60,1,(0)1
 5698      00013C45 
 5699 8158 00000000 		lvl	%s60
 5699      00BC00BF 
 5700 8160 00262727 		vfadd.s	%v39,%v39,%v38
 5700      000080CC 
 5701 8168 70FFFFFF 		br.l	.L6.35
 5701      00000F18 
 5702              	.L6.13:
 5703 8170 00000000 		adds.l	%s62,%s63,(0)1
 5703      00BF3E59 
 5704 8178 00000000 		adds.l	%s62,%s62,%s60
 5704      BCBE3E59 
 5705 8180 00000000 		lvl	%s59
 5705      00BB00BF 
 5706 8188 0000003B 		vldu.nc	%v59,%s61,%s62
 5706      BEBD0082 
 5707 8190 00000000 		adds.l	%s62,%s57,(0)1
 5707      00B93E59 
 5708 8198 00000000 		adds.l	%s62,%s62,%s56
 5708      B8BE3E59 
 5709 81a0 0000003A 		vldu.nc	%v58,%s58,%s62
 5709      BEBA0082 
 5710 81a8 00000000 		adds.l	%s62,%s55,(0)1
 5710      00B73E59 
 5711 81b0 00000000 		adds.l	%s62,%s62,%s60
 5711      BCBE3E59 
 5712 81b8 00000039 		vldu.nc	%v57,%s61,%s62
 5712      BEBD0082 
 5713 81c0 00000000 		adds.l	%s62,%s54,(0)1
 5713      00B63E59 
 5714 81c8 00000000 		adds.l	%s62,%s62,%s56
 5714      B8BE3E59 
 5715 81d0 00000038 		vldu.nc	%v56,%s58,%s62
 5715      BEBA0082 
 5716 81d8 00383937 		vfmul.s	%v55,%v57,%v56
 5716      000080CD 
 5717 81e0 3B3A3736 		vfmad.s	%v54,%v55,%v58,%v59
 5717      000080E2 
 5718 81e8 00000000 		adds.l	%s62,%s53,(0)1
 5718      00B53E59 
 5719 81f0 00000000 		adds.l	%s62,%s62,%s60
 5719      BCBE3E59 
 5720 81f8 00000035 		vldu.nc	%v53,%s61,%s62
 5720      BEBD0082 
 5721 8200 00000000 		adds.l	%s62,%s52,(0)1
 5721      00B43E59 
 5722 8208 00000000 		adds.l	%s62,%s62,%s56
 5722      B8BE3E59 
 5723 8210 00000034 		vldu.nc	%v52,%s58,%s62
 5723      BEBA0082 
 5724 8218 35343633 		vfmad.s	%v51,%v54,%v52,%v53
 5724      000080E2 
 5725 8220 00000000 		adds.l	%s62,%s51,(0)1
 5725      00B33E59 
 5726 8228 00000000 		adds.l	%s62,%s62,%s60
 5726      BCBE3E59 
 5727 8230 00000032 		vldu.nc	%v50,%s61,%s62
 5727      BEBD0082 
 5728 8238 00000000 		adds.l	%s62,%s50,(0)1
 5728      00B23E59 
 5729 8240 00000000 		adds.l	%s62,%s62,%s56
 5729      B8BE3E59 
 5730 8248 00000031 		vldu.nc	%v49,%s58,%s62
 5730      BEBA0082 
 5731 8250 32313330 		vfmad.s	%v48,%v51,%v49,%v50
 5731      000080E2 
 5732 8258 00303C3C 		vfadd.s	%v60,%v60,%v48
 5732      000080CC 
 5733              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 5734              		.loc	1 2211 0
 5735 8260 00000000 		adds.l	%s60,%s60,%s49
 5735      B1BC3C59 
 5736 8268 00000000 		adds.l	%s56,%s56,%s48
 5736      B0B83859 
 5737 8270 00000000 		subs.l	%s47,%s47,%s59
 5737      BBAF2F5B 
 5738 8278 80FEFFFF 		brge.l	0,%s47,.L6.37
 5738      AF000518 
 5739 8280 A0FAFFFF 		br.l	.L6.12
 5739      00000F18 
 5740              	.L6.38:
 5741 8288 00000000 		muls.l	%s46,4,%s46
 5741      AE042E6E 
 5742 8290 00000000 		or	%s1,0,%s63
 5742      BF000145 
 5743 8298 00000000 		or	%s2,0,%s59
 5743      BB000245 
 5744 82a0 00000000 		adds.l	%s63,%s46,%s41
 5744      A9AE3F59 
 5745 82a8 00000000 		muls.l	%s45,4,%s45
 5745      AD042D6E 
 5746 82b0 00000000 		or	%s3,0,%s56
 5746      B8000345 
 5747 82b8 00000000 		or	%s4,0,%s55
 5747      B7000445 
 5748 82c0 00000000 		adds.l	%s55,%s41,%s45
 5748      ADA93759 
 5749 82c8 00000000 		muls.l	%s44,4,%s44
 5749      AC042C6E 
 5750 82d0 00000000 		or	%s5,0,%s54
 5750      B6000545 
 5751 82d8 00000000 		or	%s6,0,%s52
 5751      B4000645 
 5752 82e0 00000000 		adds.l	%s53,%s41,%s44
 5752      ACA93559 
 5753 82e8 00000000 		muls.l	%s43,4,%s43
 5753      AB042B6E 
 5754 82f0 00000000 		or	%s7,0,%s51
 5754      B3000745 
 5755 82f8 00000000 		or	%s19,0,%s50
 5755      B2001345 
 5756 8300 00000000 		adds.l	%s51,%s41,%s43
 5756      ABA93359 
 5757 8308 00000000 		muls.l	%s46,4,%s60
 5757      BC042E6E 
 5758 8310 00000000 		or	%s20,0,%s62
 5758      BE001445 
 5759 8318 00000000 		adds.l	%s57,%s46,%s40
 5759      A8AE3959 
 5760 8320 00000000 		muls.l	%s62,4,%s49
 5760      B1043E6E 
 5761 8328 00000000 		adds.l	%s54,%s40,%s62
 5761      BEA83659 
 5762 8330 00000000 		muls.l	%s62,4,%s48
 5762      B0043E6E 
 5763 8338 00000000 		adds.l	%s52,%s40,%s62
 5763      BEA83459 
 5764 8340 00000000 		muls.l	%s62,4,%s47
 5764      AF043E6E 
 5765 8348 00000000 		adds.l	%s50,%s40,%s62
 5765      BEA83259 
 5766 8350 00000000 		subs.l	%s62,0,%s39
 5766      A7003E5B 
 5767 8358 00000000 		smvl	%s46
 5767      00002E2E 
 5768 8360 80000000 		mins.l	%s59,%s62,%s46
 5768      AEBE3B68 
 5769              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 5770              		.loc	1 2213 0
 5771 8368 00000000 		or	%s45,0,(0)1
 5771      00002D45 
 5772 8370 00000000 		lvl	%s46
 5772      00AE00BF 
 5773 8378 0000003C 		vbrdu	%v60,%s45
 5773      00AD808C 
 5774 8380 00000000 		or	%s47,0,%s62
 5774      BE002F45 
 5775              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 5776              		.loc	1 2211 0
 5777 8388 00000000 		or	%s60,0,(0)1
 5777      00003C45 
 5778 8390 00000000 		muls.l	%s49,%s61,%s59
 5778      BBBD316E 
 5779 8398 00000000 		or	%s56,0,(0)1
 5779      00003845 
 5780 83a0 00000000 		muls.l	%s48,%s58,%s59
 5780      BBBA306E 
 5781 83a8 C8FDFFFF 		br.l	.L6.13
 5781      00000F18 
 5782              	.L6.36:
 5783 83b0 00000000 		ld	%s60,0(%s62,%s63)
 5783      BFBE3C01 
 5784 83b8 00000000 		ld	%s49,0(%s62,%s59)
 5784      BBBE3101 
 5785 83c0 00000000 		ld	%s48,0(%s62,%s56)
 5785      B8BE3001 
 5786 83c8 00000000 		ld	%s47,0(%s62,%s55)
 5786      B7BE2F01 
 5787 83d0 00000000 		ld	%s46,0(%s62,%s54)
 5787      B6BE2E01 
 5788 83d8 00000000 		ld	%s45,0(%s62,%s52)
 5788      B4BE2D01 
 5789 83e0 00000000 		ld	%s44,0(%s62,%s51)
 5789      B3BE2C01 
 5790 83e8 00000000 		ld	%s43,0(%s62,%s50)
 5790      B2BE2B01 
 5791 83f0 98FEFFFF 		brlt.l	0,%s18,.L6.38
 5791      92000218 
 5792 83f8 E0FCFFFF 		br.l	.L6.35
 5792      00000F18 
 5793              	.L6.39:
 5794 8400 80EDFFFF 		st	%s57,-4736(,%fp)	# spill 
 5794      89003911 
 5795 8408 78EDFFFF 		st	%s53,-4744(,%fp)	# spill 
 5795      89003511 
 5796 8410 00000000 		or	%s42,0,%s31
 5796      9F002A45 
 5797 8418 00000000 		or	%s62,0,(0)1
 5797      00003E45 
 5798              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 5799              		.loc	1 2213 0
 5800 8420 00000000 		or	%s60,1,(0)1
 5800      00013C45 
 5801 8428 B8EDFFFF 		ld	%s57,-4680(,%fp)	# restore 
 5801      89003901 
 5802 8430 00000000 		or	%s63,0,%s30
 5802      9E003F45 
 5803 8438 00000000 		or	%s59,0,%s58
 5803      BA003B45 
 5804 8440 00000000 		or	%s56,0,%s61
 5804      BD003845 
 5805 8448 00000000 		lvl	%s60
 5805      00BC00BF 
 5806 8450 00000027 		vbrdu	%v39,%s57
 5806      00B9808C 
 5807 8458 E0EDFFFF 		ld	%s55,-4640(,%fp)	# restore 
 5807      89003701 
 5808 8460 00000000 		or	%s30,0,%s18
 5808      92001E45 
 5809 8468 D8EDFFFF 		ld	%s54,-4648(,%fp)	# restore 
 5809      89003601 
 5810 8470 00000000 		or	%s31,0,%s20
 5810      94001F45 
 5811 8478 D0EDFFFF 		ld	%s52,-4656(,%fp)	# restore 
 5811      89003401 
 5812 8480 00000000 		or	%s34,0,%s19
 5812      93002245 
 5813 8488 C8EDFFFF 		ld	%s51,-4664(,%fp)	# restore 
 5813      89003301 
 5814 8490 00000000 		or	%s35,0,%s3
 5814      83002345 
 5815 8498 C0EDFFFF 		ld	%s50,-4672(,%fp)	# restore 
 5815      89003201 
 5816 84a0 00000000 		or	%s36,0,%s4
 5816      84002445 
 5817 84a8 88EDFFFF 		ld	%s18,-4728(,%fp)	# restore 
 5817      89001201 
 5818 84b0 00000000 		or	%s37,0,%s1
 5818      81002545 
 5819 84b8 90EDFFFF 		ld	%s41,-4720(,%fp)	# restore 
 5819      89002901 
 5820 84c0 00000000 		or	%s38,0,%s2
 5820      82002645 
 5821 84c8 98EDFFFF 		ld	%s40,-4712(,%fp)	# restore 
 5821      89002801 
 5822 84d0 A0EDFFFF 		ld	%s39,-4704(,%fp)	# restore 
 5822      89002701 
 5823 84d8 A8EDFFFF 		ld	%s58,-4696(,%fp)	# restore 
 5823      89003A01 
 5824 84e0 B0EDFFFF 		ld	%s61,-4688(,%fp)	# restore 
 5824      89003D01 
 5825 84e8 C8FEFFFF 		br.l	.L6.36
 5825      00000F18 
 5826              	.L6.11:
 5827              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 5828              		.loc	1 2211 0
 5829 84f0 00000000 		lvl	%s62
 5829      00BE00BF 
 5830 84f8 00210020 		vadds.w.sx	%v32,%s63,%v33
 5830      00BF20CA 
 5831 8500 00002018 		vcvt.s.w	%v24,%v32
 5831      000080F8 
 5832 8508 001F0017 		vadds.w.sx	%v23,%s60,%v31
 5832      00BC20CA 
 5833 8510 00001716 		vcvt.s.w	%v22,%v23
 5833      000080F8 
 5834 8518 001E0015 		vadds.w.sx	%v21,%s59,%v30
 5834      00BB20CA 
 5835 8520 00001514 		vcvt.s.w	%v20,%v21
 5835      000080F8 
 5836 8528 001D0013 		vadds.w.sx	%v19,%s56,%v29
 5836      00B820CA 
 5837 8530 00001312 		vcvt.s.w	%v18,%v19
 5837      000080F8 
 5838 8538 001C0011 		vadds.w.sx	%v17,%s55,%v28
 5838      00B720CA 
 5839 8540 00001110 		vcvt.s.w	%v16,%v17
 5839      000080F8 
 5840 8548 001B000F 		vadds.w.sx	%v15,%s54,%v27
 5840      00B620CA 
 5841 8550 00000F0E 		vcvt.s.w	%v14,%v15
 5841      000080F8 
 5842 8558 001A000D 		vadds.w.sx	%v13,%s52,%v26
 5842      00B420CA 
 5843 8560 00000D0C 		vcvt.s.w	%v12,%v13
 5843      000080F8 
 5844 8568 0019000B 		vadds.w.sx	%v11,%s51,%v25
 5844      00B320CA 
 5845 8570 00000B0A 		vcvt.s.w	%v10,%v11
 5845      000080F8 
 5846 8578 000C0009 		vfadd.s	%v9,%s50,%v12
 5846      00B2A0CC 
 5847 8580 00000908 		vcvt.d.s	%v8,%v9
 5847      0000008F 
 5848 8588 00080807 		vcvt.l.d.rz	%v7,%v8
 5848      000000A8 
 5849 8590 000A0006 		vfadd.s	%v6,%s50,%v10
 5849      00B2A0CC 
 5850 8598 00000605 		vcvt.d.s	%v5,%v6
 5850      0000008F 
 5851 85a0 00080504 		vcvt.l.d.rz	%v4,%v5
 5851      000000A8 
 5852 85a8 000E0003 		vfadd.s	%v3,%s50,%v14
 5852      00B2A0CC 
 5853 85b0 00000302 		vcvt.d.s	%v2,%v3
 5853      0000008F 
 5854 85b8 00080201 		vcvt.l.d.rz	%v1,%v2
 5854      000000A8 
 5855 85c0 00100000 		vfadd.s	%v0,%s50,%v16
 5855      00B2A0CC 
 5856 85c8 0000003E 		vcvt.d.s	%v62,%v0
 5856      0000008F 
 5857 85d0 00083E3D 		vcvt.l.d.rz	%v61,%v62
 5857      000000A8 
 5858 85d8 0007003F 		vadds.l	%v63,%s57,%v7
 5858      00B9208B 
 5859 85e0 00000000 		adds.l	%s5,%s49,%s48
 5859      B0B10559 
 5860 85e8 0000003F 		vst.nc	%v63,8,%s5
 5860      85080091 
 5861 85f0 0004003B 		vadds.l	%v59,%s57,%v4
 5861      00B9208B 
 5862 85f8 00000000 		adds.l	%s5,%s47,%s48
 5862      B0AF0559 
 5863 8600 0000003B 		vst.nc	%v59,8,%s5
 5863      85080091 
 5864 8608 0001003A 		vadds.l	%v58,%s57,%v1
 5864      00B9208B 
 5865 8610 00000000 		adds.l	%s5,%s46,%s48
 5865      B0AE0559 
 5866 8618 0000003A 		vst.nc	%v58,8,%s5
 5866      85080091 
 5867 8620 003D0039 		vadds.l	%v57,%s57,%v61
 5867      00B9208B 
 5868 8628 00000000 		adds.l	%s5,%s45,%s48
 5868      B0AD0559 
 5869 8630 00000039 		vst.nc	%v57,8,%s5
 5869      85080091 
 5870 8638 00120038 		vfadd.s	%v56,%s44,%v18
 5870      00ACA0CC 
 5871 8640 00003837 		vcvt.d.s	%v55,%v56
 5871      0000008F 
 5872 8648 00083736 		vcvt.l.d.rz	%v54,%v55
 5872      000000A8 
 5873 8650 00140035 		vfadd.s	%v53,%s44,%v20
 5873      00ACA0CC 
 5874 8658 00003534 		vcvt.d.s	%v52,%v53
 5874      0000008F 
 5875 8660 00083433 		vcvt.l.d.rz	%v51,%v52
 5875      000000A8 
 5876 8668 00160032 		vfadd.s	%v50,%s44,%v22
 5876      00ACA0CC 
 5877 8670 00003231 		vcvt.d.s	%v49,%v50
 5877      0000008F 
 5878 8678 00083130 		vcvt.l.d.rz	%v48,%v49
 5878      000000A8 
 5879 8680 0018003C 		vfadd.s	%v60,%s44,%v24
 5879      00ACA0CC 
 5880 8688 00003C2F 		vcvt.d.s	%v47,%v60
 5880      0000008F 
 5881 8690 00082F2E 		vcvt.l.d.rz	%v46,%v47
 5881      000000A8 
 5882 8698 0036002D 		vadds.l	%v45,%s53,%v54
 5882      00B5208B 
 5883 86a0 00000000 		adds.l	%s5,%s43,%s48
 5883      B0AB0559 
 5884 86a8 0000002D 		vst.nc	%v45,8,%s5
 5884      85080091 
 5885 86b0 0033002C 		vadds.l	%v44,%s53,%v51
 5885      00B5208B 
 5886 86b8 00000000 		adds.l	%s5,%s42,%s48
 5886      B0AA0559 
 5887 86c0 0000002C 		vst.nc	%v44,8,%s5
 5887      85080091 
 5888 86c8 0030002B 		vadds.l	%v43,%s53,%v48
 5888      00B5208B 
 5889 86d0 00000000 		adds.l	%s5,%s41,%s48
 5889      B0A90559 
 5890 86d8 0000002B 		vst.nc	%v43,8,%s5
 5890      85080091 
 5891 86e0 002E002A 		vadds.l	%v42,%s53,%v46
 5891      00B5208B 
 5892 86e8 00000000 		adds.l	%s5,%s40,%s48
 5892      B0A80559 
 5893 86f0 0000002A 		vst.nc	%v42,8,%s5
 5893      85080091 
 5894 86f8 00000000 		adds.w.sx	%s63,%s63,%s39
 5894      A7BF3F4A 
 5895 8700 00000000 		adds.w.sx	%s60,%s60,%s39
 5895      A7BC3C4A 
 5896 8708 00000000 		adds.w.sx	%s59,%s59,%s39
 5896      A7BB3B4A 
 5897 8710 00000000 		adds.w.sx	%s56,%s56,%s39
 5897      A7B8384A 
 5898 8718 00000000 		adds.w.sx	%s55,%s55,%s38
 5898      A6B7374A 
 5899 8720 00000000 		adds.w.sx	%s54,%s54,%s37
 5899      A5B6364A 
 5900 8728 00000000 		adds.w.sx	%s52,%s52,%s36
 5900      A4B4344A 
 5901 8730 00000000 		adds.w.sx	%s51,%s51,%s35
 5901      A3B3334A 
 5902 8738 00000000 		or	%s34,0,%s34
 5902      A2002245 
 5903 8740 00000000 		adds.l	%s48,%s48,%s34
 5903      A2B03059 
 5904 8748 00000000 		or	%s34,0,%s7
 5904      87002245 
 5905 8750 00000000 		subs.w.sx	%s6,%s6,%s62
 5905      BE86065A 
 5906 8758 A8FCFFFF 		brge.w	0,%s6,.L6.39
 5906      86008518 
 5907 8760 B0F5FFFF 		br.l	.L6.10
 5907      00000F18 
 5908              	.L6.40:
 5909 8768 18F6FFFF 		st	%s63,-2536(,%fp)	# spill 
 5909      89003F11 
 5910 8770 00000000 		cvt.s.w	%s61,%s59
 5910      00BBBD5E 
 5911 8778 00000000 		fmul.s	%s50,%s61,%s23
 5911      97BDB24D 
 5912 8780 00000000 		cvt.s.w	%s61,%s63
 5912      00BFBD5E 
 5913 8788 00000000 		fmul.s	%s44,%s61,%s24
 5913      98BDAC4D 
 5914              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 5915              		.loc	1 2206 0
 5916 8790 00000000 		adds.w.sx	%s61,%s20,%s32
 5916      A0943D4A 
 5917 8798 00000000 		muls.w.sx	%s58,%s20,%s28
 5917      9C943A4B 
 5918 87a0 00000000 		adds.w.sx	%s51,%s58,%s33
 5918      A1BA334A 
 5919 87a8 00000000 		adds.w.sx	%s52,%s58,%s27
 5919      9BBA344A 
 5920 87b0 00000000 		adds.w.sx	%s54,%s58,%s22
 5920      96BA364A 
 5921 87b8 00000000 		adds.w.sx	%s55,%s58,%s21
 5921      95BA374A 
 5922 87c0 00000000 		subs.w.sx	%s56,%s26,%s20
 5922      949A385A 
 5923 87c8 00000000 		subs.w.sx	%s29,%s18,%s20
 5923      94921D5A 
 5924 87d0 08EEFFFF 		ld	%s58,-4600(,%fp)	# restore 
 5924      89003A01 
 5925 87d8 00000000 		subs.w.sx	%s30,%s58,%s20
 5925      94BA1E5A 
 5926 87e0 00EEFFFF 		ld	%s58,-4608(,%fp)	# restore 
 5926      89003A01 
 5927 87e8 00000000 		subs.w.sx	%s63,%s58,%s20
 5927      94BA3F5A 
 5928 87f0 00000000 		subs.w.sx	%s61,0,%s61
 5928      BD003D5A 
 5929 87f8 F0EDFFFF 		st	%s63,-4624(,%fp)	# spill 
 5929      89003F11 
 5930 8800 00000000 		adds.w.sx	%s61,3,%s61
 5930      BD033D4A 
 5931 8808 04000000 		lea	%s58,4
 5931      00003A06 
 5932 8810 00000000 		divs.w.sx	%s31,%s61,%s58
 5932      BABD1F7B 
 5933 8818 00000000 		smvl	%s61
 5933      00003D2E 
 5934 8820 40000000 		lea	%s58,64
 5934      00003A06 
 5935 8828 00000000 		muls.l	%s0,%s31,%s58
 5935      BA9F006E 
 5936 8830 E8EDFFFF 		st	%s0,-4632(,%fp)	# spill 
 5936      89000011 
 5937 8838 00000000 		lea	%s12,__grow_stack@LO
 5937      00000C06 
 5938 8840 00000000 		and	%s12,%s12,(32)0
 5938      608C0C44 
 5939 8848 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 5939      8C008C06 
 5940 8850 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 5940      8C000A08 
 5941 8858 D0000000 		lea	%s58,208
 5941      00003A06 
 5942 8860 00000000 		adds.l	%s49,%sp,%s58
 5942      BA8B3159 
 5943 8868 F0EDFFFF 		ld	%s63,-4624(,%fp)	# restore 
 5943      89003F01 
 5944 8870 00000000 		or	%s58,0,%s30
 5944      9E003A45 
 5945 8878 00000000 		or	%s30,0,%s49
 5945      B1001E45 
 5946 8880 00000000 		muls.w.sx	%s5,8,%s31
 5946      9F08054B 
 5947 8888 00000000 		or	%s1,0,%s62
 5947      BE000145 
 5948 8890 00000000 		or	%s2,0,%s60
 5948      BC000245 
 5949 8898 00000000 		adds.l	%s47,%s49,%s5
 5949      85B12F59 
 5950 88a0 00000000 		or	%s60,0,%s58
 5950      BA003C45 
 5951 88a8 00000000 		or	%s58,0,%s47
 5951      AF003A45 
 5952 88b0 00000000 		adds.l	%s46,%s47,%s5
 5952      85AF2E59 
 5953 88b8 18F6FFFF 		ld	%s3,-2536(,%fp)	# restore 
 5953      89000301 
 5954 88c0 00000000 		or	%s0,0,%s61
 5954      BD000045 
 5955 88c8 00000000 		or	%s61,0,%s46
 5955      AE003D45 
 5956 88d0 00000000 		adds.l	%s45,%s46,%s5
 5956      85AE2D59 
 5957 88d8 00000000 		or	%s4,0,%s59
 5957      BB000445 
 5958 88e0 00000000 		or	%s62,0,%s45
 5958      AD003E45 
 5959 88e8 E0EDFFFF 		st	%s62,-4640(,%fp)	# spill 
 5959      89003E11 
 5960 88f0 00000000 		adds.l	%s43,%s45,%s5
 5960      85AD2B59 
 5961 88f8 00000000 		or	%s59,0,%s29
 5961      9D003B45 
 5962 8900 00000000 		or	%s62,0,%s43
 5962      AB003E45 
 5963 8908 D8EDFFFF 		st	%s62,-4648(,%fp)	# spill 
 5963      89003E11 
 5964 8910 00000000 		adds.l	%s40,%s43,%s5
 5964      85AB2859 
 5965 8918 E8EDFFFF 		ld	%s29,-4632(,%fp)	# restore 
 5965      89001D01 
 5966 8920 00000000 		or	%s62,0,%s40
 5966      A8003E45 
 5967 8928 D0EDFFFF 		st	%s62,-4656(,%fp)	# spill 
 5967      89003E11 
 5968 8930 00000000 		adds.l	%s42,%s40,%s5
 5968      85A82A59 
 5969 8938 00000000 		or	%s62,0,%s42
 5969      AA003E45 
 5970 8940 C8EDFFFF 		st	%s62,-4664(,%fp)	# spill 
 5970      89003E11 
 5971 8948 00000000 		adds.l	%s41,%s42,%s5
 5971      85AA2959 
 5972 8950 00000000 		or	%s5,0,%s41
 5972      A9000545 
 5973 8958 C0EDFFFF 		st	%s5,-4672(,%fp)	# spill 
 5973      89000511 
 5974 8960 80000000 		mins.w.sx	%s62,%s31,%s0
 5974      809F3E78 
 5975 8968 00000000 		or	%s6,0,%s31
 5975      9F000645 
 5976 8970 00000000 		lvl	%s62
 5976      00BE00BF 
 5977 8978 00000024 		vseq	%v36
 5977      00000099 
 5978 8980 00240021 		vmuls.w.sx	%v33,-4,%v36
 5978      007C20CB 
 5979 8988 0024001F 		vmuls.w.sx	%v31,-4,%v36
 5979      007C20CB 
 5980 8990 0024001E 		vmuls.w.sx	%v30,-4,%v36
 5980      007C20CB 
 5981 8998 00000000 		muls.w.sx	%s39,-4,%s62
 5981      BE7C274B 
 5982 89a0 0024001D 		vmuls.w.sx	%v29,-4,%v36
 5982      007C20CB 
 5983 89a8 F8EDFFFF 		ld	%s5,-4616(,%fp)	# restore 
 5983      89000501 
 5984 89b0 00000000 		muls.w.sx	%s38,%s5,%s62
 5984      BE85264B 
 5985 89b8 0024001C 		vmuls.w.sx	%v28,%s5,%v36
 5985      008520CB 
 5986 89c0 00000000 		muls.w.sx	%s37,%s5,%s62
 5986      BE85254B 
 5987 89c8 0024001B 		vmuls.w.sx	%v27,%s5,%v36
 5987      008520CB 
 5988 89d0 00000000 		muls.w.sx	%s36,%s5,%s62
 5988      BE85244B 
 5989 89d8 0024001A 		vmuls.w.sx	%v26,%s5,%v36
 5989      008520CB 
 5990 89e0 00000000 		muls.w.sx	%s35,%s5,%s62
 5990      BE85234B 
 5991 89e8 00240019 		vmuls.w.sx	%v25,%s5,%v36
 5991      008520CB 
 5992 89f0 00000000 		muls.w.sx	%s34,8,%s62
 5992      BE08224B 
 5993 89f8 00000000 		or	%s48,0,(0)1
 5993      00003045 
 5994 8a00 00000000 		muls.w.sx	%s7,8,%s0
 5994      8008074B 
 5995 8a08 E8FAFFFF 		br.l	.L6.11
 5995      00000F18 
 5996              	.L6.41:
 5997 8a10 58FDFFFF 		brlt.w	%s20,%s19,.L6.40
 5997      93948218 
 5998 8a18 E0F5FFFF 		br.l	.L6.32
 5998      00000F18 
 5999              	.L6.42:
 6000 8a20 88EDFFFF 		st	%s18,-4728(,%fp)	# spill 
 6000      89001211 
 6001 8a28 90EDFFFF 		st	%s52,-4720(,%fp)	# spill 
 6001      89003411 
 6002 8a30 98EDFFFF 		st	%s53,-4712(,%fp)	# spill 
 6002      89003511 
 6003 8a38 A0EDFFFF 		st	%s51,-4704(,%fp)	# spill 
 6003      89003311 
 6004 8a40 A8EDFFFF 		st	%s58,-4696(,%fp)	# spill 
 6004      89003A11 
 6005 8a48 B0EDFFFF 		st	%s61,-4688(,%fp)	# spill 
 6005      89003D11 
 6006              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 6007              		.loc	1 2213 0
 6008 8a50 00000029 		lvs	%s56,%v41(0)
 6008      0000389E 
 6009              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 6010              		.loc	1 2206 0
 6011 8a58 00000000 		subs.l	%s0,0,%s5
 6011      8500005B 
 6012 8a60 B8EDFFFF 		st	%s56,-4680(,%fp)	# spill 
 6012      89003811 
 6013 8a68 00000000 		lea	%s12,__grow_stack@LO
 6013      00000C06 
 6014 8a70 00000000 		and	%s12,%s12,(32)0
 6014      608C0C44 
 6015 8a78 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6015      8C008C06 
 6016 8a80 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6016      8C000A08 
 6017 8a88 00000000 		or	%s18,0,%s6
 6017      86001245 
 6018 8a90 00000000 		or	%s63,0,%s7
 6018      87003F45 
 6019 8a98 00000000 		or	%s59,0,%s29
 6019      9D003B45 
 6020 8aa0 00000000 		or	%s62,0,%s30
 6020      9E003E45 
 6021 8aa8 00000000 		or	%s60,0,%s31
 6021      9F003C45 
 6022 8ab0 00000000 		or	%s57,0,%s34
 6022      A2003945 
 6023 8ab8 00000000 		or	%s53,0,%s35
 6023      A3003545 
 6024 8ac0 50FFFFFF 		br.l	.L6.41
 6024      00000F18 
 6025              	.L6.43:
 6026              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6027              		.loc	1 2211 0
 6028 8ac8 00000000 		adds.l	%s62,8,%s62
 6028      BE083E59 
 6029 8ad0 00000000 		adds.w.sx	%s55,-1,%s55
 6029      B77F374A 
 6030 8ad8 58010000 		brlt.w	0,%s55,.L6.44
 6030      B7008218 
 6031 8ae0 40FFFFFF 		br.l	.L6.42
 6031      00000F18 
 6032              	.L6.45:
 6033 8ae8 00000000 		or	%s62,0,%s3
 6033      83003E45 
 6034 8af0 00000000 		or	%s55,0,%s4
 6034      84003745 
 6035 8af8 00000000 		or	%s63,0,%s1
 6035      81003F45 
 6036 8b00 00000000 		or	%s59,0,%s2
 6036      82003B45 
 6037              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 6038              		.loc	1 2213 0
 6039 8b08 00000000 		lvl	%s49
 6039      00B100BF 
 6040 8b10 00003F28 		vfsum.s	%v40,%v63
 6040      000080EC 
 6041 8b18 00000000 		or	%s60,1,(0)1
 6041      00013C45 
 6042 8b20 00000000 		lvl	%s60
 6042      00BC00BF 
 6043 8b28 00282929 		vfadd.s	%v41,%v41,%v40
 6043      000080CC 
 6044 8b30 98FFFFFF 		br.l	.L6.43
 6044      00000F18 
 6045              	.L6.9:
 6046 8b38 00000000 		or	%s62,0,%s63
 6046      BF003E45 
 6047 8b40 00000000 		lvl	%s60
 6047      00BC00BF 
 6048 8b48 0000003E 		vldu.nc	%v62,%s61,%s62
 6048      BEBD0082 
 6049 8b50 00000000 		or	%s62,0,%s59
 6049      BB003E45 
 6050 8b58 0000003D 		vldu.nc	%v61,%s58,%s62
 6050      BEBA0082 
 6051 8b60 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 6051      000080E2 
 6052              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6053              		.loc	1 2211 0
 6054 8b68 00000000 		adds.l	%s63,%s63,%s57
 6054      B9BF3F59 
 6055 8b70 00000000 		adds.l	%s59,%s59,%s56
 6055      B8BB3B59 
 6056 8b78 00000000 		subs.l	%s55,%s55,%s60
 6056      BCB7375B 
 6057 8b80 68FFFFFF 		brge.l	0,%s55,.L6.45
 6057      B7000518 
 6058 8b88 78F1FFFF 		br.l	.L6.8
 6058      00000F18 
 6059              	.L6.46:
 6060 8b90 00000000 		muls.l	%s54,4,%s60
 6060      BC04366E 
 6061 8b98 00000000 		or	%s1,0,%s63
 6061      BF000145 
 6062 8ba0 00000000 		or	%s2,0,%s59
 6062      BB000245 
 6063 8ba8 00000000 		adds.l	%s54,%s54,%s53
 6063      B5B63659 
 6064 8bb0 00000000 		muls.l	%s50,4,%s56
 6064      B804326E 
 6065 8bb8 00000000 		or	%s3,0,%s62
 6065      BE000345 
 6066 8bc0 00000000 		or	%s4,0,%s55
 6066      B7000445 
 6067 8bc8 00000000 		adds.l	%s50,%s50,%s52
 6067      B4B23259 
 6068 8bd0 00000000 		subs.l	%s62,0,%s51
 6068      B3003E5B 
 6069 8bd8 00000000 		smvl	%s49
 6069      0000312E 
 6070 8be0 80000000 		mins.l	%s60,%s62,%s49
 6070      B1BE3C68 
 6071              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 6072              		.loc	1 2213 0
 6073 8be8 00000000 		or	%s48,0,(0)1
 6073      00003045 
 6074 8bf0 00000000 		lvl	%s49
 6074      00B100BF 
 6075 8bf8 0000003F 		vbrdu	%v63,%s48
 6075      00B0808C 
 6076 8c00 00000000 		or	%s55,0,%s62
 6076      BE003745 
 6077 8c08 00000000 		or	%s63,0,%s50
 6077      B2003F45 
 6078              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6079              		.loc	1 2211 0
 6080 8c10 00000000 		muls.l	%s57,%s61,%s60
 6080      BCBD396E 
 6081 8c18 00000000 		or	%s59,0,%s54
 6081      B6003B45 
 6082 8c20 00000000 		muls.l	%s56,%s58,%s60
 6082      BCBA386E 
 6083 8c28 10FFFFFF 		br.l	.L6.9
 6083      00000F18 
 6084              	.L6.44:
 6085 8c30 00000000 		ld	%s60,0(%s62,%s63)
 6085      BFBE3C01 
 6086 8c38 00000000 		ld	%s56,0(%s62,%s59)
 6086      BBBE3801 
 6087 8c40 50FFFFFF 		brlt.l	0,%s18,.L6.46
 6087      92000218 
 6088 8c48 80FEFFFF 		br.l	.L6.43
 6088      00000F18 
 6089              	.L6.47:
 6090 8c50 00000000 		or	%s55,0,%s30
 6090      9E003745 
 6091 8c58 00000000 		or	%s62,0,(0)1
 6091      00003E45 
 6092              	# line 2213
2213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
 6093              		.loc	1 2213 0
 6094 8c60 00000000 		or	%s60,1,(0)1
 6094      00013C45 
 6095 8c68 B8EDFFFF 		ld	%s56,-4680(,%fp)	# restore 
 6095      89003801 
 6096 8c70 00000000 		or	%s63,0,%s6
 6096      86003F45 
 6097 8c78 00000000 		or	%s59,0,%s7
 6097      87003B45 
 6098 8c80 00000000 		or	%s6,0,%s18
 6098      92000645 
 6099 8c88 00000000 		or	%s7,0,%s3
 6099      83000745 
 6100 8c90 00000000 		or	%s29,0,%s4
 6100      84001D45 
 6101 8c98 00000000 		or	%s30,0,%s1
 6101      81001E45 
 6102 8ca0 00000000 		or	%s31,0,%s2
 6102      82001F45 
 6103 8ca8 00000000 		or	%s34,0,%s57
 6103      B9002245 
 6104 8cb0 00000000 		or	%s35,0,%s53
 6104      B5002345 
 6105 8cb8 00000000 		lvl	%s60
 6105      00BC00BF 
 6106 8cc0 00000029 		vbrdu	%v41,%s56
 6106      00B8808C 
 6107 8cc8 B0EDFFFF 		ld	%s61,-4688(,%fp)	# restore 
 6107      89003D01 
 6108 8cd0 A8EDFFFF 		ld	%s58,-4696(,%fp)	# restore 
 6108      89003A01 
 6109 8cd8 A0EDFFFF 		ld	%s51,-4704(,%fp)	# restore 
 6109      89003301 
 6110 8ce0 98EDFFFF 		ld	%s53,-4712(,%fp)	# restore 
 6110      89003501 
 6111 8ce8 90EDFFFF 		ld	%s52,-4720(,%fp)	# restore 
 6111      89003401 
 6112 8cf0 88EDFFFF 		ld	%s18,-4728(,%fp)	# restore 
 6112      89001201 
 6113 8cf8 38FFFFFF 		br.l	.L6.44
 6113      00000F18 
 6114              	.L6.7:
 6115              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6116              		.loc	1 2211 0
 6117 8d00 00000000 		lvl	%s62
 6117      00BE00BF 
 6118 8d08 002F002E 		vadds.w.sx	%v46,%s63,%v47
 6118      00BF20CA 
 6119 8d10 00002E2C 		vcvt.s.w	%v44,%v46
 6119      000080F8 
 6120 8d18 002D002B 		vadds.w.sx	%v43,%s60,%v45
 6120      00BC20CA 
 6121 8d20 00002B2A 		vcvt.s.w	%v42,%v43
 6121      000080F8 
 6122 8d28 002A0029 		vfadd.s	%v41,%s59,%v42
 6122      00BBA0CC 
 6123 8d30 00002928 		vcvt.d.s	%v40,%v41
 6123      0000008F 
 6124 8d38 00082827 		vcvt.l.d.rz	%v39,%v40
 6124      000000A8 
 6125 8d40 00270026 		vadds.l	%v38,%s57,%v39
 6125      00B9208B 
 6126 8d48 00000000 		adds.l	%s46,%s56,%s55
 6126      B7B82E59 
 6127 8d50 00000026 		vst.nc	%v38,8,%s46
 6127      AE080091 
 6128 8d58 002C0025 		vfadd.s	%v37,%s54,%v44
 6128      00B6A0CC 
 6129 8d60 00002524 		vcvt.d.s	%v36,%v37
 6129      0000008F 
 6130 8d68 00082423 		vcvt.l.d.rz	%v35,%v36
 6130      000000A8 
 6131 8d70 00230022 		vadds.l	%v34,%s53,%v35
 6131      00B5208B 
 6132 8d78 00000000 		adds.l	%s46,%s52,%s55
 6132      B7B42E59 
 6133 8d80 00000022 		vst.nc	%v34,8,%s46
 6133      AE080091 
 6134 8d88 00000000 		adds.w.sx	%s63,%s63,%s51
 6134      B3BF3F4A 
 6135 8d90 00000000 		adds.w.sx	%s60,%s60,%s50
 6135      B2BC3C4A 
 6136 8d98 00000000 		or	%s49,0,%s49
 6136      B1003145 
 6137 8da0 00000000 		adds.l	%s55,%s55,%s49
 6137      B1B73759 
 6138 8da8 00000000 		or	%s49,0,%s48
 6138      B0003145 
 6139 8db0 00000000 		subs.w.sx	%s47,%s47,%s62
 6139      BEAF2F5A 
 6140 8db8 98FEFFFF 		brge.w	0,%s47,.L6.47
 6140      AF008518 
 6141 8dc0 30EFFFFF 		br.l	.L6.6
 6141      00000F18 
 6142              	.L6.48:
 6143 8dc8 18F6FFFF 		st	%s63,-2536(,%fp)	# spill 
 6143      89003F11 
 6144 8dd0 00000000 		cvt.s.w	%s61,%s59
 6144      00BBBD5E 
 6145 8dd8 00000000 		fmul.s	%s29,%s61,%s23
 6145      97BD9D4D 
 6146 8de0 00000000 		cvt.s.w	%s61,%s63
 6146      00BFBD5E 
 6147 8de8 00000000 		fmul.s	%s54,%s61,%s24
 6147      98BDB64D 
 6148              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 6149              		.loc	1 2206 0
 6150 8df0 00000000 		subs.w.sx	%s30,0,%s25
 6150      99001E5A 
 6151 8df8 00000000 		smvl	%s31
 6151      00001F2E 
 6152 8e00 00000000 		muls.l	%s0,16,%s30
 6152      9E10006E 
 6153 8e08 10F6FFFF 		st	%s0,-2544(,%fp)	# spill 
 6153      89000011 
 6154 8e10 00000000 		lea	%s12,__grow_stack@LO
 6154      00000C06 
 6155 8e18 00000000 		and	%s12,%s12,(32)0
 6155      608C0C44 
 6156 8e20 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6156      8C008C06 
 6157 8e28 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6157      8C000A08 
 6158 8e30 D0000000 		lea	%s61,208
 6158      00003D06 
 6159 8e38 00000000 		adds.l	%s56,%sp,%s61
 6159      BD8B3859 
 6160 8e40 00000000 		or	%s1,0,%s62
 6160      BE000145 
 6161 8e48 00000000 		or	%s6,0,%s56
 6161      B8000645 
 6162 8e50 00000000 		muls.w.sx	%s61,8,%s30
 6162      9E083D4B 
 6163 8e58 00000000 		or	%s2,0,%s60
 6163      BC000245 
 6164 8e60 18F6FFFF 		ld	%s3,-2536(,%fp)	# restore 
 6164      89000301 
 6165 8e68 00000000 		adds.l	%s52,%s56,%s61
 6165      BDB83459 
 6166 8e70 00000000 		or	%s4,0,%s59
 6166      BB000445 
 6167 8e78 00000000 		or	%s7,0,%s52
 6167      B4000745 
 6168 8e80 80000000 		mins.w.sx	%s62,%s30,%s31
 6168      9F9E3E78 
 6169 8e88 00000000 		or	%s47,0,%s30
 6169      9E002F45 
 6170 8e90 00000000 		or	%s63,0,%s26
 6170      9A003F45 
 6171 8e98 00000000 		muls.w.sx	%s51,-1,%s62
 6171      BE7F334B 
 6172 8ea0 00000000 		lvl	%s62
 6172      00BE00BF 
 6173 8ea8 00000025 		vseq	%v37
 6173      00000099 
 6174 8eb0 00000000 		or	%s59,0,%s29
 6174      9D003B45 
 6175 8eb8 10F6FFFF 		ld	%s5,-2544(,%fp)	# restore 
 6175      89000501 
 6176 8ec0 0025002F 		vmuls.w.sx	%v47,-1,%v37
 6176      007F20CB 
 6177 8ec8 00000000 		or	%s60,0,%s27
 6177      9B003C45 
 6178 8ed0 00000000 		muls.w.sx	%s50,%s28,%s62
 6178      BE9C324B 
 6179 8ed8 0025002D 		vmuls.w.sx	%v45,%s28,%v37
 6179      009C20CB 
 6180 8ee0 00000000 		muls.w.sx	%s49,8,%s62
 6180      BE08314B 
 6181 8ee8 00000000 		or	%s55,0,(0)1
 6181      00003745 
 6182 8ef0 00000000 		muls.w.sx	%s48,8,%s31
 6182      9F08304B 
 6183 8ef8 08FEFFFF 		br.l	.L6.7
 6183      00000F18 
 6184              	.L6.49:
 6185 8f00 C8FEFFFF 		brlt.w	0,%s20,.L6.48
 6185      94008218 
 6186 8f08 08FBFFFF 		br.l	.L6.41
 6186      00000F18 
 6187              	.L6.33:
 6188 8f10 F0FFFFFF 		brlt.w	0,%s19,.L6.49
 6188      93008218 
 6189 8f18 E0F0FFFF 		br.l	.L6.32
 6189      00000F18 
 6190              	.L6.50:
 6191 8f20 70EDFFFF 		st	%s63,-4752(,%fp)	# spill 
 6191      89003F11 
 6192 8f28 B8EDFFFF 		st	%s56,-4680(,%fp)	# spill 
 6192      89003811 
 6193 8f30 68EDFFFF 		st	%s20,-4760(,%fp)	# spill 
 6193      89001411 
 6194 8f38 60EDFFFF 		st	%s48,-4768(,%fp)	# spill 
 6194      89003011 
 6195 8f40 58EDFFFF 		st	%s55,-4776(,%fp)	# spill 
 6195      89003711 
 6196 8f48 50EDFFFF 		st	%s54,-4784(,%fp)	# spill 
 6196      89003611 
 6197 8f50 48EDFFFF 		st	%s19,-4792(,%fp)	# spill 
 6197      89001311 
 6198 8f58 40EDFFFF 		st	%s60,-4800(,%fp)	# spill 
 6198      89003C11 
 6199 8f60 38EDFFFF 		st	%s50,-4808(,%fp)	# spill 
 6199      89003211 
 6200 8f68 30EDFFFF 		st	%s61,-4816(,%fp)	# spill 
 6200      89003D11 
 6201 8f70 28EDFFFF 		st	%s58,-4824(,%fp)	# spill 
 6201      89003A11 
 6202 8f78 20EDFFFF 		st	%s52,-4832(,%fp)	# spill 
 6202      89003411 
 6203 8f80 18EDFFFF 		st	%s51,-4840(,%fp)	# spill 
 6203      89003311 
 6204 8f88 00000000 		dldl.sx	%s27,0(%s60,%s50)	# *(kwb)
 6204      B2BC1B0B 
 6205 8f90 00000000 		or	%s63,0,%s47
 6205      AF003F45 
 6206 8f98 00000000 		dldl.sx	%s26,0(%s60,%s61)	# *(owb)
 6206      BDBC1A0B 
 6207              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6208              		.loc	1 2211 0
 6209 8fa0 00000000 		adds.w.sx	%s18,-2,%s26
 6209      9A7E124A 
 6210 8fa8 00000000 		adds.w.sx	%s61,-3,%s26
 6210      9A7D3D4A 
 6211 8fb0 00000000 		adds.w.sx	%s56,-1,%s26
 6211      9A7F384A 
 6212 8fb8 08EEFFFF 		st	%s61,-4600(,%fp)	# spill 
 6212      89003D11 
 6213 8fc0 00EEFFFF 		st	%s56,-4608(,%fp)	# spill 
 6213      89003811 
 6214              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 6215              		.loc	1 2206 0
 6216 8fc8 00000000 		adds.w.sx	%s61,-1,%s59
 6216      BB7F3D4A 
 6217 8fd0 00000000 		or	%s59,0,%s49
 6217      B1003B45 
 6218 8fd8 00000000 		subs.w.sx	%s61,%s61,%s27
 6218      9BBD3D5A 
 6219 8fe0 00000000 		adds.w.sx	%s61,%s61,%s28
 6219      9CBD3D4A 
 6220 8fe8 00000000 		divs.w.sx	%s61,%s61,%s28
 6220      9CBD3D7B 
 6221 8ff0 00000000 		and	%s20,%s61,(62)0
 6221      7EBD1444 
 6222 8ff8 00000000 		subs.w.sx	%s25,0,%s20
 6222      9400195A 
 6223 9000 00000000 		subs.w.sx	%s32,0,%s61
 6223      BD00205A 
 6224 9008 00000000 		adds.w.sx	%s33,%s27,%s28
 6224      9C9B214A 
 6225              	# line 2205
2205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 6226              		.loc	1 2205 0
 6227 9010 00000000 		adds.w.sx	%s60,%s19,%s58
 6227      BA933C4A 
 6228              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 6229              		.loc	1 2206 0
 6230 9018 00000000 		adds.w.sx	%s22,%s27,%s52
 6230      B49B164A 
 6231 9020 00000000 		adds.w.sx	%s21,%s27,%s51
 6231      B39B154A 
 6232 9028 00000000 		or	%s19,0,%s61
 6232      BD001345 
 6233 9030 E0FEFFFF 		br.l	.L6.33
 6233      00000F18 
 6234              	.L6.51:
 6235 9038 00000000 		or	%s49,0,%s19
 6235      93003145 
 6236 9040 00000000 		or	%s47,0,%s48
 6236      B0002F45 
 6237 9048 D8FEFFFF 		brlt.w	%s19,%s20,.L6.50
 6237      94938218 
 6238 9050 10EFFFFF 		br.l	.L6.29
 6238      00000F18 
 6239              	.L6.52:
 6240              	# line 2202
2202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + 0) * KW + 0;
 6241              		.loc	1 2202 0
 6242 9058 00000000 		ldl.sx	%s21,0(%s60,%s50)	# *(kwb)
 6242      B2BC1503 
 6243 9060 D8FFFFFF 		brlt.w	%s21,%s59,.L6.51
 6243      BB958218 
 6244 9068 F8EEFFFF 		br.l	.L6.29
 6244      00000F18 
 6245              	.L6.30:
 6246              	# line 2198
2198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int kw_e = kwe[iw];
 6247              		.loc	1 2198 0
 6248 9070 00000000 		or	%s56,0,(0)1
 6248      00003845 
 6249              	# line 2199
2199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float tmp = 0.f;
 6250              		.loc	1 2199 0
 6251 9078 00000000 		ldl.sx	%s59,0(%s60,%s63)	# *(kwe)
 6251      BFBC3B03 
 6252 9080 D8FFFFFF 		brlt.w	%s19,%s20,.L6.52
 6252      94938218 
 6253 9088 D8EEFFFF 		br.l	.L6.29
 6253      00000F18 
 6254              	.L6.53:
 6255 9090 10EDFFFF 		st	%s19,-4848(,%fp)	# spill 
 6255      89001311 
 6256 9098 08EDFFFF 		st	%s60,-4856(,%fp)	# spill 
 6256      89003C11 
 6257 90a0 00EDFFFF 		st	%s59,-4864(,%fp)	# spill 
 6257      89003B11 
 6258 90a8 F8ECFFFF 		st	%s56,-4872(,%fp)	# spill 
 6258      89003811 
 6259 90b0 F0ECFFFF 		st	%s55,-4880(,%fp)	# spill 
 6259      89003711 
 6260 90b8 E8ECFFFF 		st	%s49,-4888(,%fp)	# spill 
 6260      89003111 
 6261 90c0 E0ECFFFF 		st	%s47,-4896(,%fp)	# spill 
 6261      89002F11 
 6262 90c8 D8ECFFFF 		st	%s46,-4904(,%fp)	# spill 
 6262      89002E11 
 6263 90d0 D0ECFFFF 		st	%s45,-4912(,%fp)	# spill 
 6263      89002D11 
 6264              	# line 2198
2198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int kw_e = kwe[iw];
 6265              		.loc	1 2198 0
 6266 90d8 00000000 		dldl.sx	%s20,0(%s55,%s49)	# *(khe)
 6266      B1B7140B 
 6267              	# line 2205
2205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 6268              		.loc	1 2205 0
 6269 90e0 00000000 		subs.w.sx	%s58,0,%s20
 6269      94003A5A 
 6270              	# line 2202
2202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + 0) * KW + 0;
 6271              		.loc	1 2202 0
 6272 90e8 00000000 		dldl.sx	%s19,0(%s55,%s47)	# *(khb)
 6272      AFB7130B 
 6273              	# line 2205
2205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 6274              		.loc	1 2205 0
 6275 90f0 00000000 		dldl.sx	%s48,0(%s55,%s46)	# *(ohb)
 6275      AEB7300B 
 6276 90f8 00000000 		or	%s55,0,%s56
 6276      B8003745 
 6277 9100 00000000 		or	%s54,0,%s45
 6277      AD003645 
 6278              	# line 2196
2196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 6279              		.loc	1 2196 0
 6280 9108 00000000 		or	%s60,0,(0)1
 6280      00003C45 
 6281 9110 60FFFFFF 		br.l	.L6.30
 6281      00000F18 
 6282              	.L6.27:
 6283 9118 78FFFFFF 		brlt.l	0,%s19,.L6.53
 6283      93000218 
 6284 9120 C8EDFFFF 		br.l	.L6.26
 6284      00000F18 
 6285              	.L6.54:
 6286 9128 C8ECFFFF 		st	%s20,-4920(,%fp)	# spill 
 6286      89001411 
 6287 9130 C0ECFFFF 		st	%s60,-4928(,%fp)	# spill 
 6287      89003C11 
 6288 9138 B8ECFFFF 		st	%s56,-4936(,%fp)	# spill 
 6288      89003811 
 6289 9140 B0ECFFFF 		st	%s55,-4944(,%fp)	# spill 
 6289      89003711 
 6290 9148 A8ECFFFF 		st	%s58,-4952(,%fp)	# spill 
 6290      89003A11 
 6291 9150 A0ECFFFF 		st	%s54,-4960(,%fp)	# spill 
 6291      89003611 
 6292 9158 98ECFFFF 		st	%s48,-4968(,%fp)	# spill 
 6292      89003011 
 6293 9160 90ECFFFF 		st	%s44,-4976(,%fp)	# spill 
 6293      89002C11 
 6294 9168 88ECFFFF 		st	%s43,-4984(,%fp)	# spill 
 6294      89002B11 
 6295 9170 80ECFFFF 		st	%s42,-4992(,%fp)	# spill 
 6295      89002A11 
 6296 9178 00000000 		divs.l	%s54,%s58,%s54
 6296      B6BA367F 
 6297 9180 00000000 		adds.l	%s48,%s54,%s48
 6297      B0B63059 
 6298 9188 00000000 		adds.l	%s48,%s55,%s48
 6298      B0B73059 
 6299 9190 00000000 		muls.l	%s44,%s48,%s44
 6299      ACB02C6E 
 6300 9198 00000000 		or	%s60,0,%s43
 6300      AB003C45 
 6301              	# line 2193
2193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 6302              		.loc	1 2193 0
 6303 91a0 00000000 		muls.l	%s44,%s44,%s59
 6303      BBAC2C6E 
 6304 91a8 00000000 		adds.l	%s42,%s44,%s42
 6304      AAAC2A59 
 6305 91b0 00000000 		or	%s56,0,%s42
 6305      AA003845 
 6306 91b8 00000000 		or	%s55,0,(0)1
 6306      00003745 
 6307 91c0 58FFFFFF 		br.l	.L6.27
 6307      00000F18 
 6308              	.L6.24:
 6309 91c8 60FFFFFF 		brlt.l	0,%s20,.L6.54
 6309      94000218 
 6310 91d0 98ECFFFF 		br.l	.L6.23
 6310      00000F18 
 6311              	.L6.55:
 6312 91d8 78ECFFFF 		st	%s57,-5000(,%fp)	# spill 
 6312      89003911 
 6313 91e0 70ECFFFF 		st	%s21,-5008(,%fp)	# spill 
 6313      89001511 
 6314 91e8 68ECFFFF 		st	%s60,-5016(,%fp)	# spill 
 6314      89003C11 
 6315 91f0 60ECFFFF 		st	%s41,-5024(,%fp)	# spill 
 6315      89002911 
 6316 91f8 58ECFFFF 		st	%s40,-5032(,%fp)	# spill 
 6316      89002811 
 6317 9200 50ECFFFF 		st	%s39,-5040(,%fp)	# spill 
 6317      89002711 
 6318 9208 00000000 		or	%s60,0,%s40
 6318      A8003C45 
 6319 9210 00000000 		or	%s57,0,%s39
 6319      A7003945 
 6320 9218 B0FFFFFF 		br.l	.L6.24
 6320      00000F18 
 6321              	.L6.21:
 6322              	# line 2192
2192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 6323              		.loc	1 2192 0
 6324 9220 00000000 		or	%s55,0,(0)1
 6324      00003745 
 6325 9228 B0FFFFFF 		brlt.l	0,%s21,.L6.55
 6325      95000218 
 6326 9230 D8EBFFFF 		br.l	.L6.20
 6326      00000F18 
 6327              	.L6.56:
 6328 9238 48ECFFFF 		st	%s22,-5048(,%fp)	# spill 
 6328      89001611 
 6329 9240 88EDFFFF 		st	%s18,-4728(,%fp)	# spill 
 6329      89001211 
 6330 9248 40ECFFFF 		st	%s60,-5056(,%fp)	# spill 
 6330      89003C11 
 6331 9250 38ECFFFF 		st	%s55,-5064(,%fp)	# spill 
 6331      89003711 
 6332 9258 30ECFFFF 		st	%s48,-5072(,%fp)	# spill 
 6332      89003011 
 6333 9260 28ECFFFF 		st	%s39,-5080(,%fp)	# spill 
 6333      89002711 
 6334 9268 20ECFFFF 		st	%s38,-5088(,%fp)	# spill 
 6334      89002611 
 6335 9270 18ECFFFF 		st	%s37,-5096(,%fp)	# spill 
 6335      89002511 
 6336 9278 00000000 		or	%s60,0,%s38
 6336      A6003C45 
 6337              	# line 2191
2191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 6338              		.loc	1 2191 0
 6339 9280 00000000 		or	%s55,0,(0)1
 6339      00003745 
 6340 9288 00000000 		muls.l	%s37,%s39,%s37
 6340      A5A7256E 
 6341 9290 00000000 		or	%s53,0,%s37
 6341      A5003545 
 6342              	# line 2192
2192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 6343              		.loc	1 2192 0
 6344 9298 00000000 		muls.l	%s39,%s48,%s56
 6344      B8B0276E 
 6345 92a0 00000000 		or	%s48,0,%s55
 6345      B7003045 
 6346 92a8 78FFFFFF 		br.l	.L6.21
 6346      00000F18 
 6347              	.L6.17:
 6348 92b0 88FFFFFF 		brlt.l	0,%s22,.L6.56
 6348      96000218 
 6349 92b8 D8EAFFFF 		br.l	.L6.18
 6349      00000F18 
 6350              	.L6.57:
 6351 92c0 90EDFFFF 		st	%s52,-4720(,%fp)	# spill 
 6351      89003411 
 6352 92c8 98EDFFFF 		st	%s53,-4712(,%fp)	# spill 
 6352      89003511 
 6353 92d0 00000000 		or	%s22,0,%s24
 6353      98001645 
 6354              	# line 2191
2191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 6355              		.loc	1 2191 0
 6356 92d8 00000000 		subs.l	%s38,0,%s22
 6356      9600265B 
 6357              	# line 2190
2190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 6358              		.loc	1 2190 0
 6359 92e0 00000000 		subs.l	%s53,0,%s23
 6359      9700355B 
 6360 92e8 00000000 		or	%s60,0,%s53
 6360      B5003C45 
 6361 92f0 00000000 		or	%s20,0,%s25
 6361      99001445 
 6362              	# line 2193
2193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 6363              		.loc	1 2193 0
 6364 92f8 00000000 		subs.l	%s43,0,%s20
 6364      94002B5B 
 6365 9300 10ECFFFF 		ld	%s53,-5104(,%fp)	# restore 
 6365      89003501 
 6366              	# line 2196
2196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 6367              		.loc	1 2196 0
 6368 9308 08000000 		dldl.sx	%s36,8(,%s53)	# *(p).__b_N4conv6desc_tE.ic
 6368      B500240B 
 6369 9310 00000000 		or	%s57,0,%s36
 6369      A4003945 
 6370 9318 00000000 		dldl.sx	%s36,0(,%s53)	# *(p).__b_N4conv6desc_tE.g
 6370      B500240B 
 6371 9320 00000000 		or	%s54,0,%s36
 6371      A4003645 
 6372              	# line 2190
2190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 6373              		.loc	1 2190 0
 6374 9328 00000000 		or	%s58,0,(0)1
 6374      00003A45 
 6375 9330 00000000 		or	%s48,0,(0)1
 6375      00003045 
 6376 9338 00000000 		or	%s39,0,(0)1
 6376      00002745 
 6377              	# line 2196
2196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 6378              		.loc	1 2196 0
 6379 9340 0C000000 		dldl.sx	%s36,12(,%s53)	# *(p).__b_N4conv6desc_tE.ih
 6379      B500240B 
 6380 9348 00000000 		or	%s44,0,%s36
 6380      A4002C45 
 6381 9350 10000000 		dldl.sx	%s53,16(,%s53)	# *(p).__b_N4conv6desc_tE.iw
 6381      B500350B 
 6382 9358 00000000 		or	%s53,0,%s53
 6382      B5003545 
 6383 9360 00000000 		or	%s19,0,%s27
 6383      9B001345 
 6384 9368 00000000 		subs.l	%s45,0,%s19
 6384      93002D5B 
 6385              	# line 2198
2198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int kw_e = kwe[iw];
 6386              		.loc	1 2198 0
 6387 9370 A8FFFFFF 		dld	%s49,-88(,%fp)	# khe
 6387      89003109 
 6388              	# line 2199
2199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float tmp = 0.f;
 6389              		.loc	1 2199 0
 6390 9378 F0FFFFFF 		dld	%s63,-16(,%fp)	# kwe
 6390      89003F09 
 6391              	# line 2202
2202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t w0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + 0) * KW + 0;
 6392              		.loc	1 2202 0
 6393 9380 A0FFFFFF 		dld	%s47,-96(,%fp)	# khb
 6393      89002F09 
 6394 9388 E8FFFFFF 		dld	%s36,-24(,%fp)	# kwb
 6394      89002409 
 6395 9390 00000000 		or	%s33,0,%s33
 6395      A1002145 
 6396 9398 00000000 		or	%s35,0,%s50
 6396      B2002345 
 6397              	# line 2192
2192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 6398              		.loc	1 2192 0
 6399 93a0 00000000 		muls.l	%s56,%s33,%s35
 6399      A3A1386E 
 6400              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6401              		.loc	1 2211 0
 6402 93a8 00000000 		cvt.s.w	%s23,%s50
 6402      00B2975E 
 6403 93b0 00000000 		or	%s29,0,%s29
 6403      9D001D45 
 6404 93b8 00000000 		or	%s30,0,%s30
 6404      9E001E45 
 6405              	# line 2191
2191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
 6406              		.loc	1 2191 0
 6407 93c0 00000000 		muls.l	%s29,%s29,%s30
 6407      9E9D1D6E 
 6408 93c8 00000000 		or	%s35,0,%s31
 6408      9F002345 
 6409 93d0 00000000 		or	%s50,0,%s36
 6409      A4003245 
 6410 93d8 00000000 		muls.l	%s41,%s35,%s29
 6410      9DA3296E 
 6411 93e0 00000000 		muls.l	%s37,%s30,%s35
 6411      A39E256E 
 6412              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6413              		.loc	1 2211 0
 6414 93e8 00000000 		cvt.s.w	%s24,%s31
 6414      009F985E 
 6415              	# line 2205
2205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 6416              		.loc	1 2205 0
 6417 93f0 E0FFFFFF 		dld	%s46,-32(,%fp)	# ohb
 6417      89002E09 
 6418              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 6419              		.loc	1 2206 0
 6420 93f8 98FFFFFF 		dld	%s61,-104(,%fp)	# owb
 6420      89003D09 
 6421              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6422              		.loc	1 2211 0
 6423 9400 00000000 		subs.l	%s36,0,%s18
 6423      9200245B 
 6424              	# line 2190
2190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t mb = 0; mb < MB; ++mb) {
 6425              		.loc	1 2190 0
 6426 9408 00000000 		muls.l	%s55,%s18,%s21
 6426      9592376E 
 6427 9410 A0EDFFFF 		st	%s36,-4704(,%fp)	# spill 
 6427      89002411 
 6428              	# line 2192
2192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t ih = 0; ih < IH; ++ih) {
 6429              		.loc	1 2192 0
 6430 9418 00000000 		subs.l	%s40,0,%s21
 6430      9500285B 
 6431              	# line 2193
2193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 6432              		.loc	1 2193 0
 6433 9420 00000000 		muls.l	%s59,4,%s53
 6433      B5043B6E 
 6434              	# line 2211
2211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //ds += pdiff_dst[dst_off0 + oc*OH_OW] * pwei[wei_off0 + oc*ICOG_KH_KW];
 6435              		.loc	1 2211 0
 6436 9428 00000000 		muls.l	%s34,4,%s34
 6436      A204226E 
 6437 9430 00000000 		muls.l	%s32,4,%s32
 6437      A004206E 
 6438 9438 A8EDFFFF 		st	%s34,-4696(,%fp)	# spill 
 6438      89002211 
 6439 9440 B0EDFFFF 		st	%s32,-4688(,%fp)	# spill 
 6439      89002011 
 6440              	# line 2206
2206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const ssize_t wei_off0 = (((g * OCOG + 0 ) * ICOG + ic) * KH + kh) * KW + kw;
 6441              		.loc	1 2206 0
 6442 9448 00000000 		sla.w.sx	%s5,%s28,2
 6442      9C020566 
 6443 9450 00000000 		sla.w.sx	%s52,%s28,1
 6443      9C013466 
 6444 9458 F8EDFFFF 		st	%s5,-4616(,%fp)	# spill 
 6444      89000511 
 6445 9460 00000000 		muls.w.sx	%s51,3,%s28
 6445      9C03334B 
 6446 9468 48FEFFFF 		br.l	.L6.17
 6446      00000F18 
 6447              	.L6.58:
 6448 9470 00000000 		or	%s23,0,%s23
 6448      97001745 
 6449 9478 48FEFFFF 		brlt.l	0,%s23,.L6.57
 6449      97000218 
 6450 9480 B0E8FFFF 		br.l	.L6.14
 6450      00000F18 
 6451              	.L6.59:
 6452 9488 E8FFFFFF 		br.l	.L6.58
 6452      00000F18 
 6453              	.L6.5:
 6454              	# line 2180
2180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owb[iw] = OW - 1;
 6455              		.loc	1 2180 0
 6456 9490 00000000 		lvl	%s61
 6456      00BD00BF 
 6457 9498 00120011 		vadds.w.sx	%v17,%s63,%v18
 6457      00BF20CA 
 6458 94a0 00000000 		adds.l	%s46,%s60,(0)1
 6458      00BC2E59 
 6459 94a8 00000000 		adds.l	%s45,%s46,%s59
 6459      BBAE2D59 
 6460 94b0 00000011 		vstl.nc	%v17,4,%s45
 6460      AD040093 
 6461              	# line 2181
2181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
 6462              		.loc	1 2181 0
 6463 94b8 0000000C 		vbrd	%v12,%s58
 6463      00BA008C 
 6464 94c0 00000000 		adds.l	%s45,%s57,(0)1
 6464      00B92D59 
 6465 94c8 00000000 		adds.l	%s44,%s45,%s59
 6465      BBAD2C59 
 6466 94d0 0000000C 		vstl.nc	%v12,4,%s44
 6466      AC040093 
 6467              	# line 2182
2182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
 6468              		.loc	1 2182 0
 6469 94d8 00000000 		adds.l	%s44,%s46,%s59
 6469      BBAE2C59 
 6470 94e0 0000000B 		vldl.sx.nc	%v11,4,%s44
 6470      AC040083 
 6471 94e8 00000000 		subs.w.sx	%s44,0,%s56
 6471      B8002C5A 
 6472 94f0 000B000A 		vadds.w.sx	%v10,%s44,%v11
 6472      00AC20CA 
 6473 94f8 000A0009 		vadds.w.sx	%v9,%s28,%v10
 6473      009C20CA 
 6474 9500 00000000 		adds.l	%s44,%s55,(0)1
 6474      00B72C59 
 6475 9508 00000000 		adds.l	%s43,%s44,%s59
 6475      BBAC2B59 
 6476 9510 00000009 		vstl.nc	%v9,4,%s43
 6476      AB040093 
 6477              	# line 2183
2183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       owb[iw] = kwe[iw] / SW;
 6478              		.loc	1 2183 0
 6479 9518 00090008 		vcmps.w.sx	%v8,%s54,%v9
 6479      00B620FA 
 6480 9520 0008010F 		vfmk.w.gt	%vm15,%v8
 6480      000000B5 
 6481              	# line 2184
2184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       kwb[iw] = kwe[iw] % SW;
 6482              		.loc	1 2184 0
 6483 9528 00000000 		adds.l	%s43,%s46,%s59
 6483      BBAE2B59 
 6484 9530 00000007 		vldl.sx.nc	%v7,4,%s43
 6484      AB040083 
 6485 9538 00000710 		vdivs.w.sx	%v16,%v7,%s28,%vm15
 6485      009C1FEB 
 6486 9540 00000000 		adds.l	%s45,%s45,%s59
 6486      BBAD2D59 
 6487 9548 00000010 		vstl.nc	%v16,4,%s45,%vm15
 6487      AD040F93 
 6488              	# line 2185
2185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 6489              		.loc	1 2185 0
 6490 9550 00000000 		adds.l	%s45,%s46,%s59
 6490      BBAE2D59 
 6491 9558 00000006 		vldl.sx.nc	%v6,4,%s45
 6491      AD040083 
 6492 9560 0000060F 		vdivs.w.sx	%v15,%v6,%s28,%vm15
 6492      009C1FEB 
 6493 9568 000F000E 		vmuls.w.sx	%v14,%s28,%v15,%vm15
 6493      009C2FCB 
 6494 9570 000E060D 		vsubs.w.sx	%v13,%v6,%v14,%vm15
 6494      00000FDA 
 6495 9578 00000000 		adds.l	%s44,%s44,%s59
 6495      BBAC2C59 
 6496 9580 0000000D 		vstl.nc	%v13,4,%s44,%vm15
 6496      AC040F93 
 6497              	# line 2187
2187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 6498              		.loc	1 2187 0
 6499 9588 00000000 		adds.l	%s45,%s46,%s59
 6499      BBAE2D59 
 6500 9590 00000005 		vldl.sx.nc	%v5,4,%s45
 6500      AD040083 
 6501 9598 00050004 		vadds.w.sx	%v4,1,%v5
 6501      000120CA 
 6502 95a0 00000000 		adds.l	%s45,%s46,%s59
 6502      BBAE2D59 
 6503 95a8 00000004 		vstl.nc	%v4,4,%s45
 6503      AD040093 
 6504 95b0 00040003 		vcmps.w.sx	%v3,%s50,%v4
 6504      00B220FA 
 6505 95b8 0003020F 		vfmk.w.lt	%vm15,%v3
 6505      000000B5 
 6506 95c0 00000002 		vbrd	%v2,%s50
 6506      00B2008C 
 6507 95c8 00000000 		adds.l	%s46,%s46,%s59
 6507      BBAE2E59 
 6508 95d0 00000002 		vstl.nc	%v2,4,%s46,%vm15
 6508      AE040F93 
 6509              	# line 2179
2179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = iw + PW;
 6510              		.loc	1 2179 0
 6511 95d8 00000000 		adds.l	%s59,%s59,%s49
 6511      B1BB3B59 
 6512 95e0 00000000 		adds.w.sx	%s63,%s63,%s48
 6512      B0BF3F4A 
 6513 95e8 00000000 		subs.w.sx	%s47,%s47,%s61
 6513      BDAF2F5A 
 6514 95f0 98FEFFFF 		brge.w	0,%s47,.L6.59
 6514      AF008518 
 6515 95f8 E8E6FFFF 		br.l	.L6.4
 6515      00000F18 
 6516              	.L6.60:
 6517              	# line 2181
2181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
 6518              		.loc	1 2181 0
 6519 9600 00000000 		adds.w.sx	%s58,-1,%s31
 6519      9F7F3A4A 
 6520              	# line 2182
2182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
 6521              		.loc	1 2182 0
 6522 9608 00000000 		muls.w.sx	%s56,%s31,%s28
 6522      9C9F384B 
 6523              	# line 2183
2183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       owb[iw] = kwe[iw] / SW;
 6524              		.loc	1 2183 0
 6525 9610 00000000 		adds.w.sx	%s54,-1,%s28
 6525      9C7F364A 
 6526              	# line 2179
2179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = iw + PW;
 6527              		.loc	1 2179 0
 6528 9618 00000000 		subs.w.sx	%s51,0,%s27
 6528      9B00335A 
 6529 9620 00000000 		subs.w.sx	%s51,0,%s51
 6529      B300335A 
 6530 9628 00000000 		smvl	%s46
 6530      00002E2E 
 6531 9630 80000000 		mins.w.sx	%s61,%s51,%s46
 6531      AEB33D78 
 6532 9638 00000000 		or	%s47,0,%s51
 6532      B3002F45 
 6533 9640 00000000 		lvl	%s61
 6533      00BD00BF 
 6534 9648 00000000 		vseq	%v0
 6534      00000099 
 6535 9650 00000000 		or	%s59,0,(0)1
 6535      00003B45 
 6536 9658 00000000 		or	%s51,0,%s61
 6536      BD003345 
 6537 9660 00000000 		muls.l	%s49,4,%s51
 6537      B304316E 
 6538 9668 00000000 		or	%s63,0,%s36
 6538      A4003F45 
 6539 9670 00000000 		or	%s48,0,%s61
 6539      BD003045 
 6540 9678 00000012 		vor	%v18,(0)1,%v0
 6540      000020C5 
 6541 9680 10FEFFFF 		br.l	.L6.5
 6541      00000F18 
 6542              	.L6.61:
 6543 9688 00000000 		or	%s63,0,%s27
 6543      9B003F45 
 6544              	# line 2178
2178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int iw = 0; iw < IW; ++iw) {
 6545              		.loc	1 2178 0
 6546 9690 E8FFFFFF 		lea	%s61,-24
 6546      00003D06 
 6547 9698 00000000 		adds.l	%s26,%fp,%s61
 6547      BD891A59 
 6548 96a0 00000000 		muls.l	%s35,4,%s63
 6548      BF04236E 
 6549 96a8 00000000 		or	%s0,0,%s35
 6549      A3000045 
 6550 96b0 00000000 		lea	%s12,__grow_stack@LO
 6550      00000C06 
 6551 96b8 00000000 		and	%s12,%s12,(32)0
 6551      608C0C44 
 6552 96c0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6552      8C008C06 
 6553 96c8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6553      8C000A08 
 6554 96d0 D0000000 		lea	%s63,208
 6554      00003F06 
 6555 96d8 00000000 		adds.l	%s63,%sp,%s63
 6555      BF8B3F59 
 6556 96e0 00000000 		or	%s0,0,%s35
 6556      A3000045 
 6557 96e8 00000000 		st	%s63,0(,%s26)
 6557      9A003F11 
 6558 96f0 E8FFFFFF 		ld	%s63,-24(,%fp)	# kwb
 6558      89003F01 
 6559 96f8 C8FFFFFF 		lea	%s61,-56
 6559      00003D06 
 6560 9700 00000000 		st	%s63,0(%s61,%fp)
 6560      89BD3F11 
 6561 9708 00000000 		lea	%s26,__eh_curr_region@LO
 6561      00001A06 
 6562 9710 00000000 		and	%s26,%s26,(32)0
 6562      609A1A44 
 6563 9718 00000000 		lea.sl	%s26,__eh_curr_region@HI(,%s26)
 6563      9A009A06 
 6564 9720 00000000 		or	%s63,3,(0)1
 6564      00033F45 
 6565 9728 00000000 		st2b	%s63,0(,%s26)
 6565      9A003F14 
 6566 9730 00000000 		adds.l	%s37,%fp,(60)1
 6566      3C892559 
 6567 9738 00000000 		lea	%s12,__grow_stack@LO
 6567      00000C06 
 6568 9740 00000000 		and	%s12,%s12,(32)0
 6568      608C0C44 
 6569 9748 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6569      8C008C06 
 6570 9750 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6570      8C000A08 
 6571 9758 D0000000 		lea	%s63,208
 6571      00003F06 
 6572 9760 00000000 		adds.l	%s63,%sp,%s63
 6572      BF8B3F59 
 6573 9768 00000000 		or	%s0,0,%s35
 6573      A3000045 
 6574 9770 00000000 		st	%s63,0(,%s37)
 6574      A5003F11 
 6575 9778 F0FFFFFF 		ld	%s63,-16(,%fp)	# kwe
 6575      89003F01 
 6576 9780 D0FFFFFF 		lea	%s61,-48
 6576      00003D06 
 6577 9788 00000000 		st	%s63,0(%s61,%fp)
 6577      89BD3F11 
 6578 9790 00000000 		or	%s63,4,(0)1
 6578      00043F45 
 6579 9798 00000000 		st2b	%s63,0(,%s26)
 6579      9A003F14 
 6580 97a0 98FFFFFF 		lea	%s63,-104
 6580      00003F06 
 6581 97a8 00000000 		adds.l	%s35,%fp,%s63
 6581      BF892359 
 6582 97b0 00000000 		lea	%s12,__grow_stack@LO
 6582      00000C06 
 6583 97b8 00000000 		and	%s12,%s12,(32)0
 6583      608C0C44 
 6584 97c0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6584      8C008C06 
 6585 97c8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6585      8C000A08 
 6586 97d0 D0000000 		lea	%s63,208
 6586      00003F06 
 6587 97d8 00000000 		adds.l	%s63,%sp,%s63
 6587      BF8B3F59 
 6588 97e0 00000000 		st	%s63,0(,%s35)
 6588      A3003F11 
 6589 97e8 98FFFFFF 		ld	%s57,-104(,%fp)	# owb
 6589      89003901 
 6590 97f0 D8FFFFFF 		lea	%s63,-40
 6590      00003F06 
 6591 97f8 00000000 		st	%s57,0(%s63,%fp)
 6591      89BF3911 
 6592 9800 00000000 		or	%s63,5,(0)1
 6592      00053F45 
 6593 9808 00000000 		st2b	%s63,0(,%s26)
 6593      9A003F14 
 6594              	# line 2179
2179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     kwe[iw] = iw + PW;
 6595              		.loc	1 2179 0
 6596 9810 F0FFFFFF 		ld	%s60,-16(,%fp)	# kwe
 6596      89003C01 
 6597 9818 E8FFFFFF 		ld	%s55,-24(,%fp)	# kwb
 6597      89003701 
 6598 9820 E0FDFFFF 		brlt.w	0,%s27,.L6.60
 6598      9B008218 
 6599 9828 48FCFFFF 		br.l	.L6.58
 6599      00000F18 
 6600              	.L6.62:
 6601 9830 10ECFFFF 		st	%s51,-5104(,%fp)	# spill 
 6601      89003311 
 6602 9838 00000000 		or	%s50,0,%s43
 6602      AB003245 
 6603 9840 48FEFFFF 		br.l	.L6.61
 6603      00000F18 
 6604              	.L6.3:
 6605              	# line 2169
2169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohb[ih] = OH - 1;
 6606              		.loc	1 2169 0
 6607 9848 00000000 		lvl	%s61
 6607      00BD00BF 
 6608 9850 00230022 		vadds.w.sx	%v34,%s63,%v35
 6608      00BF20CA 
 6609 9858 00000000 		adds.l	%s47,%s60,(0)1
 6609      00BC2F59 
 6610 9860 00000000 		adds.l	%s46,%s47,%s59
 6610      BBAF2E59 
 6611 9868 00000022 		vstl.nc	%v34,4,%s46
 6611      AE040093 
 6612              	# line 2170
2170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
 6613              		.loc	1 2170 0
 6614 9870 0000001D 		vbrd	%v29,%s58
 6614      00BA008C 
 6615 9878 00000000 		adds.l	%s46,%s57,(0)1
 6615      00B92E59 
 6616 9880 00000000 		adds.l	%s45,%s46,%s59
 6616      BBAE2D59 
 6617 9888 0000001D 		vstl.nc	%v29,4,%s45
 6617      AD040093 
 6618              	# line 2171
2171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
 6619              		.loc	1 2171 0
 6620 9890 00000000 		adds.l	%s45,%s47,%s59
 6620      BBAF2D59 
 6621 9898 0000001C 		vldl.sx.nc	%v28,4,%s45
 6621      AD040083 
 6622 98a0 00000000 		subs.w.sx	%s45,0,%s56
 6622      B8002D5A 
 6623 98a8 001C001B 		vadds.w.sx	%v27,%s45,%v28
 6623      00AD20CA 
 6624 98b0 001B001A 		vadds.w.sx	%v26,%s62,%v27
 6624      00BE20CA 
 6625 98b8 00000000 		adds.l	%s45,%s55,(0)1
 6625      00B72D59 
 6626 98c0 00000000 		adds.l	%s44,%s45,%s59
 6626      BBAD2C59 
 6627 98c8 0000001A 		vstl.nc	%v26,4,%s44
 6627      AC040093 
 6628              	# line 2172
2172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ohb[ih] = khe[ih] / SH;
 6629              		.loc	1 2172 0
 6630 98d0 001A0019 		vcmps.w.sx	%v25,%s54,%v26
 6630      00B620FA 
 6631 98d8 0019010F 		vfmk.w.gt	%vm15,%v25
 6631      000000B5 
 6632              	# line 2173
2173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       khb[ih] = khe[ih] % SH;
 6633              		.loc	1 2173 0
 6634 98e0 00000000 		adds.l	%s44,%s47,%s59
 6634      BBAF2C59 
 6635 98e8 00000018 		vldl.sx.nc	%v24,4,%s44
 6635      AC040083 
 6636 98f0 00001821 		vdivs.w.sx	%v33,%v24,%s62,%vm15
 6636      00BE1FEB 
 6637 98f8 00000000 		adds.l	%s46,%s46,%s59
 6637      BBAE2E59 
 6638 9900 00000021 		vstl.nc	%v33,4,%s46,%vm15
 6638      AE040F93 
 6639              	# line 2174
2174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 6640              		.loc	1 2174 0
 6641 9908 00000000 		adds.l	%s46,%s47,%s59
 6641      BBAF2E59 
 6642 9910 00000017 		vldl.sx.nc	%v23,4,%s46
 6642      AE040083 
 6643 9918 00001720 		vdivs.w.sx	%v32,%v23,%s62,%vm15
 6643      00BE1FEB 
 6644 9920 0020001F 		vmuls.w.sx	%v31,%s62,%v32,%vm15
 6644      00BE2FCB 
 6645 9928 001F171E 		vsubs.w.sx	%v30,%v23,%v31,%vm15
 6645      00000FDA 
 6646 9930 00000000 		adds.l	%s45,%s45,%s59
 6646      BBAD2D59 
 6647 9938 0000001E 		vstl.nc	%v30,4,%s45,%vm15
 6647      AD040F93 
 6648              	# line 2176
2176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 6649              		.loc	1 2176 0
 6650 9940 00000000 		adds.l	%s46,%s47,%s59
 6650      BBAF2E59 
 6651 9948 00000016 		vldl.sx.nc	%v22,4,%s46
 6651      AE040083 
 6652 9950 00160015 		vadds.w.sx	%v21,1,%v22
 6652      000120CA 
 6653 9958 00000000 		adds.l	%s46,%s47,%s59
 6653      BBAF2E59 
 6654 9960 00000015 		vstl.nc	%v21,4,%s46
 6654      AE040093 
 6655 9968 20000000 		ldl.sx	%s46,32(,%s51)	# *(p).__b_N4conv6desc_tE.kh
 6655      B3002E03 
 6656 9970 00150014 		vcmps.w.sx	%v20,%s46,%v21
 6656      00AE20FA 
 6657 9978 0014020F 		vfmk.w.lt	%vm15,%v20
 6657      000000B5 
 6658 9980 00000013 		vbrd	%v19,%s46
 6658      00AE008C 
 6659 9988 00000000 		adds.l	%s47,%s47,%s59
 6659      BBAF2F59 
 6660 9990 00000013 		vstl.nc	%v19,4,%s47,%vm15
 6660      AF040F93 
 6661              	# line 2167
2167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //int ocend = (OC/G);
 6662              		.loc	1 2167 0
 6663 9998 00000000 		adds.l	%s59,%s59,%s50
 6663      B2BB3B59 
 6664 99a0 00000000 		adds.w.sx	%s63,%s63,%s49
 6664      B1BF3F4A 
 6665 99a8 00000000 		subs.w.sx	%s48,%s48,%s61
 6665      BDB0305A 
 6666 99b0 80FEFFFF 		brge.w	0,%s48,.L6.62
 6666      B0008518 
 6667 99b8 18E3FFFF 		br.l	.L6.2
 6667      00000F18 
 6668              	.L6.63:
 6669              	# line 2170
2170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
 6670              		.loc	1 2170 0
 6671 99c0 00000000 		adds.w.sx	%s58,-1,%s30
 6671      9E7F3A4A 
 6672              	# line 2171
2171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
 6673              		.loc	1 2171 0
 6674 99c8 00000000 		muls.w.sx	%s56,%s30,%s62
 6674      BE9E384B 
 6675              	# line 2172
2172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ohb[ih] = khe[ih] / SH;
 6676              		.loc	1 2172 0
 6677 99d0 00000000 		adds.w.sx	%s54,-1,%s62
 6677      BE7F364A 
 6678              	# line 2167
2167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //int ocend = (OC/G);
 6679              		.loc	1 2167 0
 6680 99d8 00000000 		subs.w.sx	%s47,0,%s25
 6680      99002F5A 
 6681 99e0 10ECFFFF 		ld	%s51,-5104(,%fp)	# restore 
 6681      89003301 
 6682 99e8 00000000 		subs.w.sx	%s47,0,%s47
 6682      AF002F5A 
 6683 99f0 00000000 		smvl	%s46
 6683      00002E2E 
 6684 99f8 80000000 		mins.w.sx	%s61,%s47,%s46
 6684      AEAF3D78 
 6685 9a00 00000000 		or	%s48,0,%s47
 6685      AF003045 
 6686 9a08 00000000 		lvl	%s61
 6686      00BD00BF 
 6687 9a10 00000001 		vseq	%v1
 6687      00000099 
 6688 9a18 00000000 		or	%s59,0,(0)1
 6688      00003B45 
 6689 9a20 00000000 		or	%s47,0,%s61
 6689      BD002F45 
 6690 9a28 00000000 		muls.l	%s47,4,%s47
 6690      AF042F6E 
 6691 9a30 00000000 		or	%s63,0,%s35
 6691      A3003F45 
 6692 9a38 00000000 		or	%s49,0,%s61
 6692      BD003145 
 6693 9a40 00000000 		or	%s43,0,%s50
 6693      B2002B45 
 6694 9a48 00000000 		or	%s50,0,%s47
 6694      AF003245 
 6695 9a50 00010023 		vor	%v35,(0)1,%v1
 6695      000020C5 
 6696 9a58 F0FDFFFF 		br.l	.L6.3
 6696      00000F18 
 6697              	.L6.64:
 6698 9a60 70E3FFFF 		st	%s63,-7312(,%fp)	# spill 
 6698      89003F11 
 6699 9a68 10ECFFFF 		ld	%s51,-5104(,%fp)	# restore 
 6699      89003301 
 6700              	# line 2145
2145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int MB = p->mb;
 6701              		.loc	1 2145 0
 6702 9a70 00000000 		ldl.sx	%s23,0(,%s51)	# *(p).__b_N4conv6desc_tE.g
 6702      B3001703 
 6703              	# line 2146
2146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int IC = p->ic;
 6704              		.loc	1 2146 0
 6705 9a78 04000000 		ldl.sx	%s24,4(,%s51)	# *(p).__b_N4conv6desc_tE.mb
 6705      B3001803 
 6706              	# line 2147
2147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int IH = p->ih;
 6707              		.loc	1 2147 0
 6708 9a80 08000000 		ldl.sx	%s63,8(,%s51)	# *(p).__b_N4conv6desc_tE.ic
 6708      B3003F03 
 6709              	# line 2161
2161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t ICOG_KH_KW = ICOG * KH * KW;
 6710              		.loc	1 2161 0
 6711 9a88 00000000 		divs.w.sx	%s63,%s63,%s23
 6711      97BF3F7B 
 6712 9a90 00000000 		or	%s21,0,%s63
 6712      BF001545 
 6713              	# line 2148
2148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int IW = p->iw;
 6714              		.loc	1 2148 0
 6715 9a98 0C000000 		ldl.sx	%s25,12(,%s51)	# *(p).__b_N4conv6desc_tE.ih
 6715      B3001903 
 6716 9aa0 00000000 		or	%s63,0,%s25
 6716      99003F45 
 6717              	# line 2166
2166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int ih = 0; ih < IH; ++ih) {
 6718              		.loc	1 2166 0
 6719 9aa8 00000000 		muls.l	%s26,4,%s63
 6719      BF041A6E 
 6720              	# line 2149
2149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OC = p->oc;
 6721              		.loc	1 2149 0
 6722 9ab0 10000000 		ldl.sx	%s27,16(,%s51)	# *(p).__b_N4conv6desc_tE.iw
 6722      B3001B03 
 6723              	# line 2150
2150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OH = p->oh;
 6724              		.loc	1 2150 0
 6725 9ab8 14000000 		ldl.sx	%s29,20(,%s51)	# *(p).__b_N4conv6desc_tE.oc
 6725      B3001D03 
 6726 9ac0 00000000 		or	%s0,0,%s26
 6726      9A000045 
 6727              	# line 2163
2163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH_OW = OH * OW;
 6728              		.loc	1 2163 0
 6729 9ac8 00000000 		divs.w.sx	%s63,%s29,%s23
 6729      979D3F7B 
 6730 9ad0 00000000 		or	%s18,0,%s63
 6730      BF001245 
 6731              	# line 2151
2151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int OW = p->ow;
 6732              		.loc	1 2151 0
 6733 9ad8 18000000 		ldl.sx	%s30,24(,%s51)	# *(p).__b_N4conv6desc_tE.oh
 6733      B3001E03 
 6734              	# line 2152
2152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int KH = p->kh;
 6735              		.loc	1 2152 0
 6736 9ae0 1C000000 		ldl.sx	%s31,28(,%s51)	# *(p).__b_N4conv6desc_tE.ow
 6736      B3001F03 
 6737              	# line 2164
2164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 6738              		.loc	1 2164 0
 6739 9ae8 00000000 		muls.w.sx	%s63,%s30,%s31
 6739      9F9E3F4B 
 6740 9af0 00000000 		or	%s32,0,%s63
 6740      BF002045 
 6741              	# line 2153
2153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int KW = p->kw;
 6742              		.loc	1 2153 0
 6743 9af8 20000000 		ldl.sx	%s33,32(,%s51)	# *(p).__b_N4conv6desc_tE.kh
 6743      B3002103 
 6744 9b00 00000000 		or	%s63,0,%s33
 6744      A1003F45 
 6745              	# line 2162
2162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC / G;
 6746              		.loc	1 2162 0
 6747 9b08 00000000 		muls.l	%s63,%s21,%s63
 6747      BF953F6E 
 6748              	# line 2154
2154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int PH = p->ph;
 6749              		.loc	1 2154 0
 6750 9b10 24000000 		ldl.sx	%s50,36(,%s51)	# *(p).__b_N4conv6desc_tE.kw
 6750      B3003203 
 6751 9b18 00000000 		or	%s61,0,%s50
 6751      B2003D45 
 6752              	# line 2162
2162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OCOG = OC / G;
 6753              		.loc	1 2162 0
 6754 9b20 00000000 		muls.l	%s34,%s63,%s61
 6754      BDBF226E 
 6755              	# line 2155
2155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int PW = p->pw;
 6756              		.loc	1 2155 0
 6757 9b28 30000000 		ldl.sx	%s35,48(,%s51)	# *(p).__b_N4conv6desc_tE.ph
 6757      B3002303 
 6758              	# line 2156
2156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int SH = p->sh;
 6759              		.loc	1 2156 0
 6760 9b30 34000000 		ldl.sx	%s36,52(,%s51)	# *(p).__b_N4conv6desc_tE.pw
 6760      B3002403 
 6761              	# line 2157
2157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int SW = p->sw;
 6762              		.loc	1 2157 0
 6763 9b38 28000000 		ldl.sx	%s62,40(,%s51)	# *(p).__b_N4conv6desc_tE.sh
 6763      B3003E03 
 6764              	# line 2158
2158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const int DH = p->dh + 1;
 6765              		.loc	1 2158 0
 6766 9b40 2C000000 		ldl.sx	%s28,44(,%s51)	# *(p).__b_N4conv6desc_tE.sw
 6766      B3001C03 
 6767              	# line 2166
2166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int ih = 0; ih < IH; ++ih) {
 6768              		.loc	1 2166 0
 6769 9b48 A0FFFFFF 		lea	%s63,-96
 6769      00003F06 
 6770 9b50 00000000 		adds.l	%s37,%fp,%s63
 6770      BF892559 
 6771 9b58 00000000 		lea	%s12,__grow_stack@LO
 6771      00000C06 
 6772 9b60 00000000 		and	%s12,%s12,(32)0
 6772      608C0C44 
 6773 9b68 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6773      8C008C06 
 6774 9b70 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6774      8C000A08 
 6775 9b78 D0000000 		lea	%s63,208
 6775      00003F06 
 6776 9b80 00000000 		adds.l	%s63,%sp,%s63
 6776      BF8B3F59 
 6777 9b88 00000000 		lea	%s61,0
 6777      00003D06 
 6778 9b90 00000000 		or	%s0,0,%s26
 6778      9A000045 
 6779 9b98 00000000 		st	%s63,0(,%s37)
 6779      A5003F11 
 6780 9ba0 A0FFFFFF 		ld	%s63,-96(,%fp)	# khb
 6780      89003F01 
 6781 9ba8 70E3FFFF 		ld	%s59,-7312(,%fp)	# restore 
 6781      89003B01 
 6782 9bb0 B0FFFFFF 		st	%s63,-80(,%fp)
 6782      89003F11 
 6783 9bb8 00000000 		st2b	%s61,0(,%s59)
 6783      BB003D14 
 6784 9bc0 A8FFFFFF 		lea	%s63,-88
 6784      00003F06 
 6785 9bc8 00000000 		adds.l	%s37,%fp,%s63
 6785      BF892559 
 6786 9bd0 00000000 		lea	%s12,__grow_stack@LO
 6786      00000C06 
 6787 9bd8 00000000 		and	%s12,%s12,(32)0
 6787      608C0C44 
 6788 9be0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6788      8C008C06 
 6789 9be8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6789      8C000A08 
 6790 9bf0 D0000000 		lea	%s63,208
 6790      00003F06 
 6791 9bf8 00000000 		adds.l	%s63,%sp,%s63
 6791      BF8B3F59 
 6792 9c00 70E3FFFF 		ld	%s61,-7312(,%fp)	# restore 
 6792      89003D01 
 6793 9c08 00000000 		or	%s0,0,%s26
 6793      9A000045 
 6794 9c10 00000000 		st	%s63,0(,%s37)
 6794      A5003F11 
 6795 9c18 A8FFFFFF 		ld	%s63,-88(,%fp)	# khe
 6795      89003F01 
 6796 9c20 B8FFFFFF 		lea	%s59,-72
 6796      00003B06 
 6797 9c28 00000000 		st	%s63,0(%s59,%fp)
 6797      89BB3F11 
 6798 9c30 00000000 		or	%s63,1,(0)1
 6798      00013F45 
 6799 9c38 00000000 		st2b	%s63,0(,%s61)
 6799      BD003F14 
 6800 9c40 00000000 		adds.l	%s26,%fp,(59)1
 6800      3B891A59 
 6801 9c48 00000000 		lea	%s12,__grow_stack@LO
 6801      00000C06 
 6802 9c50 00000000 		and	%s12,%s12,(32)0
 6802      608C0C44 
 6803 9c58 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 6803      8C008C06 
 6804 9c60 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 6804      8C000A08 
 6805 9c68 D0000000 		lea	%s63,208
 6805      00003F06 
 6806 9c70 00000000 		adds.l	%s63,%sp,%s63
 6806      BF8B3F59 
 6807 9c78 70E3FFFF 		ld	%s61,-7312(,%fp)	# restore 
 6807      89003D01 
 6808 9c80 00000000 		st	%s63,0(,%s26)
 6808      9A003F11 
 6809 9c88 E0FFFFFF 		ld	%s57,-32(,%fp)	# ohb
 6809      89003901 
 6810 9c90 C0FFFFFF 		lea	%s63,-64
 6810      00003F06 
 6811 9c98 00000000 		st	%s57,0(%s63,%fp)
 6811      89BF3911 
 6812 9ca0 00000000 		or	%s63,2,(0)1
 6812      00023F45 
 6813 9ca8 00000000 		st2b	%s63,0(,%s61)
 6813      BD003F14 
 6814              	# line 2167
2167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     //int ocend = (OC/G);
 6815              		.loc	1 2167 0
 6816 9cb0 A8FFFFFF 		ld	%s60,-88(,%fp)	# khe
 6816      89003C01 
 6817 9cb8 A0FFFFFF 		ld	%s55,-96(,%fp)	# khb
 6817      89003701 
 6818 9cc0 00FDFFFF 		brlt.w	0,%s25,.L6.63
 6818      99008218 
 6819 9cc8 C0F9FFFF 		br.l	.L6.61
 6819      00000F18 
 6820              	.L6.65:
 6821 9cd0 10ECFFFF 		ld	%s0,-5104(,%fp)	# restore 
 6821      89000001 
 6822 9cd8 F8EBFFFF 		ld	%s1,-5128(,%fp)	# restore 
 6822      89000101 
 6823 9ce0 00ECFFFF 		ld	%s2,-5120(,%fp)	# restore 
 6823      89000201 
 6824 9ce8 08ECFFFF 		ld	%s3,-5112(,%fp)	# restore 
 6824      89000301 
 6825 9cf0 18010000 		br.l	.L6.66
 6825      00000F18 
 6826              	.L6.1:
 6827 9cf8 10ECFFFF 		ld	%s51,-5104(,%fp)	# restore 
 6827      89003301 
 6828              	# line 2116
2116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // FIXME can we call this even less?
 6829              		.loc	1 2116 0
 6830 9d00 3C000000 		ldl.sx	%s18,60(,%s51)	# *(p).__b_N4conv6desc_tE.dw
 6830      B3001203 
 6831 9d08 C8FFFFFF 		brne.w	0,%s18,.L6.65
 6831      92008318 
 6832 9d10 50FDFFFF 		br.l	.L6.64
 6832      00000F18 
 6833              	.L6.15:
 6834              	# line 2246
2246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
 6835              		.loc	1 2246 0
 6836 9d18 00000000 		lea	%s0,conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 6836      00000006 
 6837 9d20 00000000 		and	%s0,%s0,(32)0
 6837      60800044 
 6838 9d28 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 6838      80008006 
 6839 9d30 08000000 		ld	%s1,8(,%fp)	# ptr
 6839      89000101 
 6840 9d38 00000000 		lea	%s12,__ftrace_func_exit@LO
 6840      00000C06 
 6841 9d40 00000000 		and	%s12,%s12,(32)0
 6841      608C0C44 
 6842 9d48 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 6842      8C008C06 
 6843 9d50 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 6843      8C000A08 
 6844              	# Start of epilogue codes
 6845 9d58 30000000 		ld	%s18,48(,%fp)
 6845      89001201 
 6846 9d60 38000000 		ld	%s19,56(,%fp)
 6846      89001301 
 6847 9d68 40000000 		ld	%s20,64(,%fp)
 6847      89001401 
 6848 9d70 48000000 		ld	%s21,72(,%fp)
 6848      89001501 
 6849 9d78 50000000 		ld	%s22,80(,%fp)
 6849      89001601 
 6850 9d80 58000000 		ld	%s23,88(,%fp)
 6850      89001701 
 6851 9d88 60000000 		ld	%s24,96(,%fp)
 6851      89001801 
 6852 9d90 68000000 		ld	%s25,104(,%fp)
 6852      89001901 
 6853 9d98 70000000 		ld	%s26,112(,%fp)
 6853      89001A01 
 6854 9da0 78000000 		ld	%s27,120(,%fp)
 6854      89001B01 
 6855 9da8 80000000 		ld	%s28,128(,%fp)
 6855      89001C01 
 6856 9db0 88000000 		ld	%s29,136(,%fp)
 6856      89001D01 
 6857 9db8 90000000 		ld	%s30,144(,%fp)
 6857      89001E01 
 6858 9dc0 98000000 		ld	%s31,152(,%fp)
 6858      89001F01 
 6859 9dc8 A0000000 		ld	%s32,160(,%fp)
 6859      89002001 
 6860 9dd0 A8000000 		ld	%s33,168(,%fp)
 6860      89002101 
 6861 9dd8 00000000 		or	%sp,0,%fp
 6861      89000B45 
 6862              		.cfi_def_cfa	11,8
 6863 9de0 18000000 		ld	%got,0x18(,%sp)
 6863      8B000F01 
 6864 9de8 20000000 		ld	%plt,0x20(,%sp)
 6864      8B001001 
 6865 9df0 08000000 		ld	%lr,0x8(,%sp)
 6865      8B000A01 
 6866 9df8 00000000 		ld	%fp,0x0(,%sp)
 6866      8B000901 
 6867 9e00 00000000 		b.l	(,%lr)
 6867      8A000F19 
 6868              	.L6.66:
 6869              	# line 2120
2120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     return;
 6870              		.loc	1 2120 0
 6871 9e08 00000000 		lea	%s12,conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 6871      00000C06 
 6872 9e10 00000000 		and	%s12,%s12,(32)0
 6872      608C0C44 
 6873 9e18 00000000 		lea.sl	%s12,conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s12)
 6873      8C008C06 
 6874 9e20 00000000 		bsic	%lr,(,%s12)	# conv::sxconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 6874      8C000A08 
 6875 9e28 48FEFFFF 		ld2b.zx	%s63,-440(,%fp)
 6875      8900BF04 
 6876 9e30 00000000 		lea	%s62,__eh_curr_region@LO
 6876      00003E06 
 6877 9e38 00000000 		and	%s62,%s62,(32)0
 6877      60BE3E44 
 6878 9e40 00000000 		lea.sl	%s62,__eh_curr_region@HI(,%s62)
 6878      BE00BE06 
 6879 9e48 00000000 		st2b	%s63,0(,%s62)
 6879      BE003F14 
 6880 9e50 20FEFFFF 		ld	%s63,-480(,%fp)
 6880      89003F01 
 6881 9e58 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 6881      00003E06 
 6882 9e60 00000000 		and	%s62,%s62,(32)0
 6882      60BE3E44 
 6883 9e68 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 6883      BE00BE06 
 6884 9e70 00000000 		st	%s63,0(,%s62)
 6884      BE003F11 
 6885 9e78 A0FEFFFF 		br.l	.L6.15
 6885      00000F18 
 6886              	.L6.0:
 6887 9e80 10ECFFFF 		ld	%s0,-5104(,%fp)	# restore 
 6887      89000001 
 6888 9e88 F8EBFFFF 		ld	%s1,-5128(,%fp)	# restore 
 6888      89000101 
 6889 9e90 00ECFFFF 		ld	%s2,-5120(,%fp)	# restore 
 6889      89000201 
 6890 9e98 08ECFFFF 		ld	%s3,-5112(,%fp)	# restore 
 6890      89000301 
 6891 9ea0 68FFFFFF 		br.l	.L6.66
 6891      00000F18 
 6892              		.cfi_endproc
 6893              		.set	.L.7.2auto_size,	0xffffffffffffb7f0	# 18448 Bytes
 6895              	.L_FE.7:
 6896 9ea8 636F6E76 		.string	"conv::sxconv_3_bwd_d\000_c"
 6896      3A3A7378 
 6896      636F6E76 
 6896      5F335F62 
 6896      77645F64 
 6897              	# ============ End  conv::sxconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 6898              	# ============ Begin  conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 6899              		.data
 6900              		.balign 16
 6903              	.LP._ZN4conv14sxconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 6904 0180 00000000 		.long	__vla_dealloc_eh
 6904      00000000 
 6905 0188 0000     		.zero	2
 6906 018a FFFF     		.short	65535
 6907 018c 04       		.byte	4
 6908 018d 000000   		.zero	3
 6909 0190 00000000 		.long	__vla_dealloc_eh
 6909      00000000 
 6910 0198 0100     		.short	1
 6911 019a 0000     		.zero	2
 6912 019c 04       		.byte	4
 6913 019d 000000   		.zero	3
 6914 01a0 00000000 		.long	__vla_dealloc_eh
 6914      00000000 
 6915 01a8 0200     		.short	2
 6916 01aa 0100     		.short	1
 6917 01ac 04       		.byte	4
 6918 01ad 000000   		.zero	3
 6919 01b0 00000000 		.long	__vla_dealloc_eh
 6919      00000000 
 6920 01b8 0300     		.short	3
 6921 01ba 0200     		.short	2
 6922 01bc 04       		.byte	4
 6923 01bd 000000   		.zero	3
 6924 01c0 00000000 		.long	__vla_dealloc_eh
 6924      00000000 
 6925 01c8 0400     		.short	4
 6926 01ca 0300     		.short	3
 6927 01cc 04       		.byte	4
 6928 01cd 000000   		.zero	3
 6929              		.text
 6930              		.balign 16
 6931              	# line 2274
2274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t G = p->g;
 6932              		.loc	1 2274 0
 6933              		.globl	conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 6935 9ec0 B8220000 		.long	.L_FE.8-8-.
 6935      00000000 
 6936              	conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 6937              		.cfi_startproc
 6938 9ec8 00000000 		st	%fp,0x0(,%sp)
 6938      8B000911 
 6939              		.cfi_def_cfa_offset	0
 6940              		.cfi_offset	9,0
 6941 9ed0 08000000 		st	%lr,0x8(,%sp)
 6941      8B000A11 
 6942 9ed8 18000000 		st	%got,0x18(,%sp)
 6942      8B000F11 
 6943 9ee0 20000000 		st	%plt,0x20(,%sp)
 6943      8B001011 
 6944 9ee8 00000000 		or	%fp,0,%sp
 6944      8B000945 
 6945              		.cfi_def_cfa_register	9
 6946 9ef0 30000000 		st	%s18,48(,%fp)
 6946      89001211 
 6947 9ef8 38000000 		st	%s19,56(,%fp)
 6947      89001311 
 6948 9f00 40000000 		st	%s20,64(,%fp)
 6948      89001411 
 6949 9f08 48000000 		st	%s21,72(,%fp)
 6949      89001511 
 6950 9f10 50000000 		st	%s22,80(,%fp)
 6950      89001611 
 6951 9f18 58000000 		st	%s23,88(,%fp)
 6951      89001711 
 6952 9f20 60000000 		st	%s24,96(,%fp)
 6952      89001811 
 6953 9f28 68000000 		st	%s25,104(,%fp)
 6953      89001911 
 6954 9f30 70000000 		st	%s26,112(,%fp)
 6954      89001A11 
 6955 9f38 78000000 		st	%s27,120(,%fp)
 6955      89001B11 
 6956 9f40 80000000 		st	%s28,128(,%fp)
 6956      89001C11 
 6957 9f48 88000000 		st	%s29,136(,%fp)
 6957      89001D11 
 6958 9f50 90000000 		st	%s30,144(,%fp)
 6958      89001E11 
 6959 9f58 98000000 		st	%s31,152(,%fp)
 6959      89001F11 
 6960 9f60 A0000000 		st	%s32,160(,%fp)
 6960      89002011 
 6961 9f68 A8000000 		st	%s33,168(,%fp)
 6961      89002111 
 6962 9f70 B077FFFF 		lea	%s13,.L.8.2auto_size&0xffffffff
 6962      00000D06 
 6963 9f78 00000000 		and	%s13,%s13,(32)0
 6963      608D0D44 
 6964 9f80 FFFFFFFF 		lea.sl	%sp,.L.8.2auto_size>>32(%fp,%s13)
 6964      8D898B06 
 6965 9f88 48000000 		brge.l.t	%sp,%sl,.L7.EoP
 6965      888B3518 
 6966 9f90 18000000 		ld	%s61,0x18(,%tp)
 6966      8E003D01 
 6967 9f98 00000000 		or	%s62,0,%s0
 6967      80003E45 
 6968 9fa0 3B010000 		lea	%s63,0x13b
 6968      00003F06 
 6969 9fa8 00000000 		shm.l	%s63,0x0(%s61)
 6969      BD033F31 
 6970 9fb0 08000000 		shm.l	%sl,0x8(%s61)
 6970      BD030831 
 6971 9fb8 10000000 		shm.l	%sp,0x10(%s61)
 6971      BD030B31 
 6972 9fc0 00000000 		monc
 6972      0000003F 
 6973 9fc8 00000000 		or	%s0,0,%s62
 6973      BE000045 
 6974              	.L7.EoP:
 6975              	# End of prologue codes
 6976 9fd0 10ECFFFF 		st	%s4,-5104(,%fp)	# spill 
 6976      89000411 
 6977 9fd8 08ECFFFF 		st	%s3,-5112(,%fp)	# spill 
 6977      89000311 
 6978 9fe0 00ECFFFF 		st	%s2,-5120(,%fp)	# spill 
 6978      89000211 
 6979 9fe8 F8EBFFFF 		st	%s1,-5128(,%fp)	# spill 
 6979      89000111 
 6980 9ff0 F0EBFFFF 		st	%s0,-5136(,%fp)	# spill 
 6980      89000011 
 6981 9ff8 00000000 		lea	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 6981      00000006 
 6982 a000 00000000 		and	%s0,%s0,(32)0
 6982      60800044 
 6983 a008 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 6983      80008006 
 6984 a010 08000000 		ld	%s1,8(,%fp)	# ptr
 6984      89000101 
 6985 a018 00000000 		lea	%s12,__ftrace_func_enter@LO
 6985      00000C06 
 6986 a020 00000000 		and	%s12,%s12,(32)0
 6986      608C0C44 
 6987 a028 00000000 		lea.sl	%s12,__ftrace_func_enter@HI(,%s12)
 6987      8C008C06 
 6988 a030 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_enter
 6988      8C000A08 
 6989 a038 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 6989      00003E06 
 6990 a040 00000000 		and	%s62,%s62,(32)0
 6990      60BE3E44 
 6991 a048 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 6991      BE00BE06 
 6992 a050 00000000 		ld	%s61,0(,%s62)
 6992      BE003D01 
 6993 a058 F0EBFFFF 		ld	%s63,-5136(,%fp)	# restore 
 6993      89003F01 
 6994 a060 38FEFFFF 		st	%s61,-456(,%fp)
 6994      89003D11 
 6995 a068 38FEFFFF 		lea	%s61,-456
 6995      00003D06 
 6996 a070 00000000 		adds.l	%s61,%fp,%s61
 6996      BD893D59 
 6997 a078 F8EBFFFF 		ld	%s1,-5128(,%fp)	# restore 
 6997      89000101 
 6998 a080 00000000 		st	%s61,0(,%s62)
 6998      BE003D11 
 6999 a088 00000000 		or	%s62,1,(0)1
 6999      00013E45 
 7000 a090 00ECFFFF 		ld	%s2,-5120(,%fp)	# restore 
 7000      89000201 
 7001 a098 40FEFFFF 		st1b	%s62,-448(,%fp)
 7001      89003E15 
 7002              	# line 2275
2275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t MB = p->mb;
 7003              		.loc	1 2275 0
 7004 a0a0 00000000 		ldl.sx	%s62,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 7004      BF003E03 
 7005 a0a8 08ECFFFF 		ld	%s3,-5112(,%fp)	# restore 
 7005      89000301 
 7006 a0b0 00000000 		or	%s31,0,%s62
 7006      BE001F45 
 7007 a0b8 00000000 		lea	%s62,.LP._ZN4conv14sxconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 7007      00003E06 
 7008 a0c0 00000000 		and	%s62,%s62,(32)0
 7008      60BE3E44 
 7009 a0c8 00000000 		lea.sl	%s62,.LP._ZN4conv14sxconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s62)
 7009      BE00BE06 
 7010 a0d0 48FEFFFF 		st	%s62,-440(,%fp)
 7010      89003E11 
 7011 a0d8 B8FFFFFF 		lea	%s62,-72
 7011      00003E06 
 7012 a0e0 00000000 		adds.l	%s62,%fp,%s62
 7012      BE893E59 
 7013 a0e8 10ECFFFF 		ld	%s4,-5104(,%fp)	# restore 
 7013      89000401 
 7014 a0f0 50FEFFFF 		st	%s62,-432(,%fp)
 7014      89003E11 
 7015 a0f8 00000000 		lea	%s23,__eh_curr_region@LO
 7015      00001706 
 7016 a100 00000000 		and	%s23,%s23,(32)0
 7016      60971744 
 7017 a108 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 7017      97009706 
 7018 a110 00000000 		ld2b.zx	%s62,0(,%s23)
 7018      9700BE04 
 7019 a118 60FEFFFF 		st2b	%s62,-416(,%fp)
 7019      89003E14 
 7020 a120 FFFF0000 		lea	%s62,65535
 7020      00003E06 
 7021 a128 00000000 		st2b	%s62,0(,%s23)
 7021      97003E14 
 7022              	# line 2276
2276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IC = p->ic;
 7023              		.loc	1 2276 0
 7024 a130 04000000 		ldl.sx	%s62,4(,%s63)	# *(p).__b_N4conv6desc_tE.mb
 7024      BF003E03 
 7025 a138 00000000 		or	%s62,0,%s62
 7025      BE003E45 
 7026 a140 30FEFFFF 		st	%s62,-464(,%fp)	# MB
 7026      89003E11 
 7027              	# line 2304
2304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if ((p->dir & FLAG_BIA)) {
 7028              		.loc	1 2304 0
 7029 a148 30FEFFFF 		lea	%s62,-464
 7029      00003E06 
 7030 a150 00000000 		adds.l	%s62,%fp,%s62
 7030      BE893E59 
 7031              	# line 2277
2277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IH = p->ih;
 7032              		.loc	1 2277 0
 7033 a158 08000000 		ldl.sx	%s61,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 7033      BF003D03 
 7034 a160 00000000 		or	%s32,0,%s61
 7034      BD002045 
 7035              	# line 2278
2278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t IW = p->iw;
 7036              		.loc	1 2278 0
 7037 a168 0C000000 		ldl.sx	%s61,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 7037      BF003D03 
 7038 a170 00000000 		or	%s24,0,%s61
 7038      BD001845 
 7039              	# line 2279
2279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OC = p->oc;
 7040              		.loc	1 2279 0
 7041 a178 10000000 		ldl.sx	%s61,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 7041      BF003D03 
 7042 a180 00000000 		or	%s26,0,%s61
 7042      BD001A45 
 7043              	# line 2280
2280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OH = p->oh;
 7044              		.loc	1 2280 0
 7045 a188 14000000 		ldl.sx	%s61,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 7045      BF003D03 
 7046 a190 00000000 		or	%s61,0,%s61
 7046      BD003D45 
 7047 a198 28FEFFFF 		st	%s61,-472(,%fp)	# OC
 7047      89003D11 
 7048              	# line 2304
2304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if ((p->dir & FLAG_BIA)) {
 7049              		.loc	1 2304 0
 7050 a1a0 28FEFFFF 		lea	%s61,-472
 7050      00003D06 
 7051 a1a8 00000000 		adds.l	%s61,%fp,%s61
 7051      BD893D59 
 7052              	# line 2281
2281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t OW = p->ow;
 7053              		.loc	1 2281 0
 7054 a1b0 18000000 		ldl.sx	%s60,24(,%s63)	# *(p).__b_N4conv6desc_tE.oh
 7054      BF003C03 
 7055 a1b8 00000000 		or	%s60,0,%s60
 7055      BC003C45 
 7056 a1c0 20FEFFFF 		st	%s60,-480(,%fp)	# OH
 7056      89003C11 
 7057              	# line 2304
2304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if ((p->dir & FLAG_BIA)) {
 7058              		.loc	1 2304 0
 7059 a1c8 20FEFFFF 		lea	%s60,-480
 7059      00003C06 
 7060 a1d0 00000000 		adds.l	%s60,%fp,%s60
 7060      BC893C59 
 7061              	# line 2282
2282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KH = p->kh;
 7062              		.loc	1 2282 0
 7063 a1d8 1C000000 		ldl.sx	%s55,28(,%s63)	# *(p).__b_N4conv6desc_tE.ow
 7063      BF003703 
 7064 a1e0 00000000 		or	%s55,0,%s55
 7064      B7003745 
 7065 a1e8 18FEFFFF 		st	%s55,-488(,%fp)	# OW
 7065      89003711 
 7066              	# line 2304
2304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if ((p->dir & FLAG_BIA)) {
 7067              		.loc	1 2304 0
 7068 a1f0 18FEFFFF 		lea	%s55,-488
 7068      00003706 
 7069 a1f8 00000000 		adds.l	%s55,%fp,%s55
 7069      B7893759 
 7070              	# line 2283
2283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t KW = p->kw;
 7071              		.loc	1 2283 0
 7072 a200 20000000 		ldl.sx	%s54,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 7072      BF003603 
 7073 a208 00000000 		or	%s25,0,%s54
 7073      B6001945 
 7074              	# line 2770
2320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // 6 is a safe one
2322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define BW 6
2323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // SX BWD_WB tests
2324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // 6 3.34x
2325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if BW==0
2326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel)
2327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   {
2328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(3))//;
2329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t ic = 0; ic < ICOG; ++ic) {
2332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t wei_off00 = ((((size_t)g * OCOG + oc) * ICOG + ic) * KH + 0) * KW + 0;
2333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t kh = 0; kh < KH; ++kh) {
2334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t kw = 0; kw < KW; ++kw) {
2335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdiff_wei[wei_off00 + kh*KW + kw] = 0.f;
2336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(4))//;
2343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //for (ssize_t ic = 0; ic < IC/G; ++ic)
2346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t kh = 0; kh < p->kh; ++kh) {
2347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t kw = 0; kw < KW; ++kw) {
2348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // SX TODO simplify these to positive-integer solutions !!!
2350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t oh_beg, oh_end;
2351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
2352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
2353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
2354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (oh_end > OH) oh_end = OH;
2355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0 // establish non-negative equivalencies
2356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( (oh_beg >= 1) == (kh*DH < PH) );
2357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( (oh_end >= 1) == (kh*DH < IH+PH) );
2358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( (oh_end >= OH) == (kh*DH + OH*SH < IH+PH+SH) ); // ???
2359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t ohb2 = 0;
2360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if( kh*DH < PH ) ohb2 = ((PH-kh*DH) + SH-1)/ SH;
2361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( ohb2 == oh_beg );
2362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t ohe2 = 0;
2363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if( kh*DH < IH+PH ) {
2364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ohe2 = ((IH + PH - kh*DH) + SH-1) / SH;
2365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 RT_ASSERT( ohe2 >= 1 );
2366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if( ohe2 >= OH ) {
2368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 ohe2 = OH;
2369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 RT_ASSERT( (kh*DH + OH*SH < IH+PH+SH) );
2370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               // note: oh_end from div_floor and signed integer was allowed to be -ve
2372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               RT_ASSERT( (oh_end<0 && ohe2==0) || (oh_end>=0 && ohe2==oh_end ) );
2373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ssize_t ow_beg, ow_end;
2375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
2376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
2377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
2378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if (ow_end > OW) ow_end = OW;
2379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
2380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
2381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const size_t ow_emb = ow_end - ow_beg;
2382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               float dw_ic[ICOG];
2384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //float dw_ic[ICOG][MB];
2385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic) {
2386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 float tmp = 0.f;
2387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t mb = 0; mb < MB; ++mb) {
2388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t oh = oh_beg; oh < oh_end; ++oh) {
2389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     const size_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh) * OW + ow_beg;
2390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     const ssize_t ih = ih0 + oh * SH;
2391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     const size_t iw_beg = ow_beg * SW - PW + kw * DW;
2392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + iw_beg
2393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + ow_b
2394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (size_t ow = 0; ow < ow_emb; ++ow) {
2395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                      tmp += pdiff_dst[dst_off_beg+ow] * psrc[src_off_beg + ow*SW];
2396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
2397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 dw_ic[ic] = tmp;
2400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ic = 0; ic < ICOG; ++ic){
2403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if ((p->dir & FLAG_BIA)) {
2412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       OMP(for collapse(2) nowait)//;
2413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t g = 0; g < G; ++g) {
2414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t oc = 0; oc < OCOG; ++oc) {
2415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t bia_off = bia_off_f(p, g, oc);
2416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
2417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           db = 0;
2418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t mb = 0; mb < MB; ++mb) {
2419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t oh = 0; oh < OH; ++oh) {
2421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t ow = 0; ow < OW; ++ow) {
2422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 db += pdiff_dst[dst_off00 + oh*OW + ow];
2423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if BW==1
2432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(4))//;
2434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (ssize_t g = 0; g < G; ++g) {
2435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
2436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t kh = 0; kh < p->kh; ++kh) {
2437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t kw = 0; kw < KW; ++kw) {
2438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t oh_beg, oh_end;
2440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
2441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
2442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
2443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_end > OH) oh_end = OH;
2444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t ow_beg, ow_end;
2445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
2446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
2447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
2448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_end > OW) ow_end = OW;
2449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
2450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
2451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const size_t ow_emb = ow_end - ow_beg;
2452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           float dw_ic[ICOG];
2454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
2456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) {
2457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               float tmp = 0.f;
2458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oh = oh_beg; oh < oh_end; ++oh) {
2460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const size_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh) * OW + ow_beg;
2461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const ssize_t ih = ih0 + oh * SH;
2462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const size_t iw_beg = ow_beg * SW - PW + kw * DW;
2463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + iw_beg;
2464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const size_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + ih) * IW + ow_beg
2465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (size_t ow = 0; ow < ow_emb; ++ow) {
2466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     tmp += pdiff_dst[dst_off_beg+ow] * psrc[src_off_beg + ow*SW];
2467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               dw_ic[ic] = tmp;
2471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
2475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   if ((p->dir & FLAG_BIA)) {
2484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(2) nowait)//;
2485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ssize_t bia_off = bia_off_f(p, g, oc);
2488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         float &db = ((float*)diff_bia_m)[bia_off];
2489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         db = 0;
2490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
2491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
2493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
2494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               db += pdiff_dst[dst_off00 + oh*OW + ow];
2495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if BW==2
2503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(4))//;
2505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (ssize_t g = 0; g < G; ++g) {
2506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
2507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ShortLoop()for (ssize_t kh = 0; kh < p->kh; ++kh) {
2508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ShortLoop()for (ssize_t kw = 0; kw < KW; ++kw) {
2509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t oh_beg, oh_end;
2511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
2512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
2513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
2514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_end > OH) oh_end = OH;
2515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t ow_beg, ow_end;
2516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
2517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
2518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
2519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_end > OW) ow_end = OW;
2520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
2521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
2522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           float dw_ic[ICOG];
2524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
2526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ow_end -= ow_beg;
2527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             oh_end -= oh_beg;
2528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
2529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW 
2530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t ic = 0; ic < ICOG; ++ic) {
2531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               float tmp = 0.f;
2532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t mb = 0; mb < MB; ++mb) {
2533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const ssize_t dst_off_beg = ((mb * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_b
2534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
2535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 //const ssize_t src_off_beg = ((mb * IC + g * ICOG + ic ) * IH + (ih0+oh_beg*SH)) *
2536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 const ssize_t src_off_beg = s00 + mb*IC*IH*IW + ic*IH*IW;
2537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1
2538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oh = 0; oh < oh_end; ++oh) {
2539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (size_t ow = 0; ow < ow_end; ++ow) {
2540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW];
2541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0
2544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 if(oh_end < 256 && ow_end < 256){ // ShortLoop is faster, but speed destroyed by 'i
2545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   ShortLoop()for (ssize_t oh = 0; oh < oh_end; ++oh) {
2546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     ShortLoop()for (size_t ow = 0; ow < ow_end; ++ow) {
2547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW]
2548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
2549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }else{
2551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t oh = 0; oh < oh_end; ++oh) {
2552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     for (size_t ow = 0; ow < ow_end; ++ow) {
2553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                       tmp += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[src_off_beg + oh*SH_IW + ow*SW]
2554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     }
2555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // slower
2558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 float s[oh_end*ow_end];
2559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 float d[oh_end*ow_end];
2560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oh = 0; oh < oh_end; ++oh) {
2561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (size_t ow = 0; ow < ow_end; ++ow) {
2562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     d[oh*ow_end+ow] = pdiff_dst[dst_off_beg + oh*OW + ow];
2563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     s[oh*ow_end+ow] = psrc[src_off_beg + oh*SH_IW + ow*SW];
2564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t o = 0; o < ow_end*oh_end; ++o) {
2567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   tmp += d[o] * s[o];
2568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // very slow
2570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 float s[OH][OW], d[OH][OW];
2571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh) {
2572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (size_t ow = 0; ow < OW; ++ow) {
2573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     d[oh][ow] = (oh<oh_end && ow<ow_end ? pdiff_dst[dst_off_beg + oh*OW + ow]: 0.f)
2574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     s[oh][ow] = (oh<oh_end && ow<ow_end ? psrc[src_off_beg + oh*SH_IW + ow*SW]: 0.f
2575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (ssize_t oh = 0; oh < OH; ++oh)
2578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (size_t ow = 0; ow < OW; ++ow)
2579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     tmp += d[oh][ow] * s[oh][ow];
2580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               dw_ic[ic] = tmp;
2583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
2587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   if ((p->dir & FLAG_BIA)) {
2596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(2) nowait)//;
2597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ssize_t bia_off = bia_off_f(p, g, oc);
2600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         float &db = ((float*)diff_bia_m)[bia_off];
2601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         db = 0;
2602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
2603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
2605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
2606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               db += pdiff_dst[dst_off00 + oh*OW + ow];
2607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if BW==3
2615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // loop order change, much better 24x for regr.sh BWD_WB
2616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(4))//;
2618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (ssize_t g = 0; g < G; ++g) {
2619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
2620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
2621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
2622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t oh_beg, oh_end;
2624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
2625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
2626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
2627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_end > OH) oh_end = OH;
2628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t ow_beg, ow_end;
2629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
2630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
2631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
2632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_end > OW) ow_end = OW;
2633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           float dw_ic[ICOG];
2634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
2636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ow_end -= ow_beg;
2637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             oh_end -= oh_beg;
2638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
2639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW 
2640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t mb = 0; mb < MB; ++mb) {
2641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
2642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = s00 + mb*IC*IH*IW;
2643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oh = 0; oh < oh_end; ++oh) {
2644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (size_t ow = 0; ow < ow_end; ++ow) {
2645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (ssize_t ic = 0; ic < ICOG; ++ic) {
2646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     dw_ic[ic] += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[s0+ic*IH*IW + oh*SH_IW + ow
2647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
2654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   if ((p->dir & FLAG_BIA)) {
2662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(2) nowait)//;
2663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const ssize_t bia_off = bia_off_f(p, g, oc);
2666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         pdiff_bia[bia_off] = 0.f;
2667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
2669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
2671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
2672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
2673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
2674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if BW==5// loop order change, much better 24x for regr.sh BWD_WB
2682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
2683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel for collapse(4))//;
2684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (ssize_t g = 0; g < G; ++g) {
2685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
2686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ShortLoop() for (ssize_t kh = 0; kh < p->kh; ++kh) {
2687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ShortLoop() for (ssize_t kw = 0; kw < KW; ++kw) {
2688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t ih0 = /*0 * SH*/ - PH + kh * DH;
2689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           typedef int hoist_t; /*but it could even be unsigned int, now*/
2690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1 // SX 24.5x BWD_WB regr.sh
2691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t oh_beg, oh_end;
2692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_beg = div_floor(      SH - ih0 - 1, SH);//(c-a+b-1)/b
2693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           oh_end = div_floor( IH + SH - ih0 - 1, SH);//(d-a+b-1)/b
2694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_beg < 0    ) oh_beg = 0;
2695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (oh_end > OH) oh_end = OH;
2696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t ow_beg, ow_end;
2697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
2698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
2699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < 0    ) ow_beg = 0;
2700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_end > OW) ow_end = OW;
2701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //const size_t iw_beg = ow_beg * SW - PW + kw * DW;
2702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 0 // SX 24.3x
2703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           // equiv, but OK for unsigned hoist_t and "normal" division op
2704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           typedef ssize_t hoist_t; /*but it could even be unsigned int, now*/
2705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           hoist_t oh_beg = 0, oh_end=0;
2706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( kh*DH < PH ) oh_beg = ((PH-kh*DH) + SH-1)/ SH;
2707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( kh*DH < IH+PH ) oh_end = ((IH + PH - kh*DH) + SH-1) / SH;
2708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( oh_end >= OH ) oh_end = OH;
2709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           hoist_t ow_beg = 0, ow_end=0;
2710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( kw*DW < PW ) ow_beg = ((PW-kw*DW) + SW-1)/ SW;
2711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( kw*DW < IW+PW ) ow_end = ((IW + PW - kw*DW) + SW-1) / SW;
2712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( ow_end >= OW ) ow_end = OW;
2713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #elif 1 // SX 24.1x
2714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t oh_beg = ( kh*DH < PH ? ((PH-kh*DH) + SH-1)/ SH : 0 );
2715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t oh_end = ( kh*DH < IH+PH ? ((IH + PH - kh*DH) + SH-1) / SH : 0 );
2716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( oh_end >= OH ) oh_end = OH;
2717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t ow_beg = ( kw*DW < PW ? ((PW-kw*DW) + SW-1)/ SW : 0 );
2718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           ssize_t ow_end = ( kw*DW < IW+PW ? ((IW + PW - kw*DW) + SW-1) / SW : 0 );
2719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if( ow_end >= OW ) ow_end = OW;
2720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           float dw_ic[ICOG];
2722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           RETAIN(dw_ic)ShortLoopTest()for (ssize_t ic = 0; ic < ICOG; ++ic) dw_ic[ic] = 0.f;
2723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           if (ow_beg < ow_end && oh_beg < oh_end) {
2724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ow_end -= ow_beg;
2725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             oh_end -= oh_beg;
2726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t d0 = ((0 * OC + g * OCOG + oc) * OH + oh_beg) * OW + ow_beg;
2727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const ssize_t s00 = ((0 * IC + g * ICOG + 0 ) * IH + (ih0+oh_beg*SH)) * IW + ow_beg*SW 
2728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t mb = 0; mb < MB; ++mb) {
2729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t dst_off_beg = d0 + mb * OC*OH*OW;
2730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               const ssize_t s0 = s00 + mb*IC*IH*IW;
2731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (ssize_t oh = 0; oh < oh_end; ++oh) {
2732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (size_t ow = 0; ow < ow_end; ++ow) {
2733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   RETAIN(dw_ic)for (ssize_t ic = 0; ic < ICOG; ++ic) {
2734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     dw_ic[ic] += pdiff_dst[dst_off_beg+oh*OW+ow] * psrc[s0+ic*IH*IW + oh*SH_IW + ow
2735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   }
2736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 }
2737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               }
2738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t wei_off0 = wei_off_f2(p, g, oc, 0, kh, kw); // ic=0
2741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t ic = 0; ic < ICOG; ++ic){
2742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             pdiff_wei[wei_off0 + ic*KH_KW] = dw_ic[ic];
2743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   if ((p->dir & FLAG_BIA)) {
2750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(2) nowait)//;
2751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const ssize_t bia_off = bia_off_f(p, g, oc);
2754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         pdiff_bia[bia_off] = 0.f;
2755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const ssize_t dst_off000 = ((0 * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
2757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           //const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
2759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
2760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
2761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdiff_bia[bia_off] += pdiff_dst[dst_off000 + mb*OC*OH*OW + oh*OW + ow];
2762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if BW==6 // from ref_conv4
2770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   int ohb[KH], ohe[KH], owb[KW], owe[KW], ook[KH_KW];
 7075              		.loc	1 2770 0
 7076 a210 00000000 		muls.l	%s28,4,%s25
 7076      99041C6E 
 7077              	# line 2284
2284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PH = p->ph;
 7078              		.loc	1 2284 0
 7079 a218 24000000 		ldl.sx	%s54,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 7079      BF003603 
 7080 a220 00000000 		or	%s0,0,%s28
 7080      9C000045 
 7081 a228 00000000 		or	%s18,0,%s54
 7081      B6001245 
 7082              	# line 2296
2296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH_IW = SH * IW;
 7083              		.loc	1 2296 0
 7084 a230 00000000 		muls.l	%s29,%s25,%s18
 7084      92991D6E 
 7085              	# line 2285
2285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t PW = p->pw;
 7086              		.loc	1 2285 0
 7087 a238 30000000 		ldl.sx	%s54,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 7087      BF003603 
 7088 a240 00000000 		or	%s59,0,%s54
 7088      B6003B45 
 7089              	# line 2286
2286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SH = p->sh;
 7090              		.loc	1 2286 0
 7091 a248 34000000 		ldl.sx	%s54,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 7091      BF003603 
 7092 a250 00000000 		or	%s57,0,%s54
 7092      B6003945 
 7093              	# line 2287
2287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t SW = p->sw;
 7094              		.loc	1 2287 0
 7095 a258 28000000 		ldl.sx	%s54,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 7095      BF003603 
 7096 a260 00000000 		or	%s58,0,%s54
 7096      B6003A45 
 7097              	# line 2288
2288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   const ssize_t DH = p->dh + 1;
 7098              		.loc	1 2288 0
 7099 a268 2C000000 		ldl.sx	%s54,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 7099      BF003603 
 7100 a270 00000000 		or	%s56,0,%s54
 7100      B6003845 
 7101              	# line 2298
2298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_wei = (float*)diff_wei_m;
 7102              		.loc	1 2298 0
 7103 a278 A8010000 		ld	%s46,424(,%s1)	# *(src_m).data_
 7103      81002E01 
 7104              	# line 2299
2299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float       * restrict const pdiff_bia = (float*)diff_bia_m;
 7105              		.loc	1 2299 0
 7106 a280 A8010000 		ld	%s27,424(,%s2)	# *(diff_wei_m).data_
 7106      82001B01 
 7107              	# line 2300
2300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
 7108              		.loc	1 2300 0
 7109 a288 A8010000 		ld	%s3,424(,%s3)	# *(diff_bia_m).data_
 7109      83000301 
 7110              	# line 2301
2301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1
 7111              		.loc	1 2301 0
 7112 a290 A8010000 		ld	%s45,424(,%s4)	# *(diff_dst_m).data_
 7112      84002D01 
 7113              	# line 2300
2300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   float const * restrict const pdiff_dst = (float*)diff_dst_m;
 7114              		.loc	1 2300 0
 7115 a298 10FEFFFF 		st	%s3,-496(,%fp)	# pdiff_bia
 7115      89000311 
 7116              	# line 2304
2304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if ((p->dir & FLAG_BIA)) {
 7117              		.loc	1 2304 0
 7118 a2a0 10FEFFFF 		lea	%s54,-496
 7118      00003606 
 7119 a2a8 00000000 		adds.l	%s54,%fp,%s54
 7119      B6893659 
 7120 a2b0 E0FDFFFF 		st	%s61,-544(,%fp)	# bwd_w_bias_update.OC
 7120      89003D11 
 7121 a2b8 E8FDFFFF 		st	%s54,-536(,%fp)	# bwd_w_bias_update.pdiff_bia
 7121      89003611 
 7122 a2c0 F0FDFFFF 		st	%s62,-528(,%fp)	# bwd_w_bias_update.MB
 7122      89003E11 
 7123 a2c8 F8FDFFFF 		st	%s60,-520(,%fp)	# bwd_w_bias_update.OH
 7123      89003C11 
 7124 a2d0 00FEFFFF 		st	%s55,-512(,%fp)	# bwd_w_bias_update.OW
 7124      89003711 
 7125              	# line 2770
 7126              		.loc	1 2770 0
 7127 a2d8 08FEFFFF 		lea	%s62,-504
 7127      00003E06 
 7128 a2e0 00000000 		adds.l	%s30,%fp,%s62
 7128      BE891E59 
 7129 a2e8 00000000 		lea	%s12,__grow_stack@LO
 7129      00000C06 
 7130 a2f0 00000000 		and	%s12,%s12,(32)0
 7130      608C0C44 
 7131 a2f8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 7131      8C008C06 
 7132 a300 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 7132      8C000A08 
 7133 a308 D0000000 		lea	%s62,208
 7133      00003E06 
 7134 a310 00000000 		adds.l	%s62,%sp,%s62
 7134      BE8B3E59 
 7135 a318 00000000 		lea	%s61,0
 7135      00003D06 
 7136 a320 00000000 		or	%s0,0,%s28
 7136      9C000045 
 7137 a328 00000000 		st	%s62,0(,%s30)
 7137      9E003E11 
 7138 a330 08FEFFFF 		ld	%s62,-504(,%fp)	# ohb
 7138      89003E01 
 7139 a338 B8FFFFFF 		st	%s62,-72(,%fp)
 7139      89003E11 
 7140 a340 00000000 		st2b	%s61,0(,%s23)
 7140      97003D14 
 7141 a348 B0FFFFFF 		lea	%s62,-80
 7141      00003E06 
 7142 a350 00000000 		adds.l	%s28,%fp,%s62
 7142      BE891C59 
 7143 a358 00000000 		lea	%s12,__grow_stack@LO
 7143      00000C06 
 7144 a360 00000000 		and	%s12,%s12,(32)0
 7144      608C0C44 
 7145 a368 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 7145      8C008C06 
 7146 a370 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 7146      8C000A08 
 7147 a378 D0000000 		lea	%s62,208
 7147      00003E06 
 7148 a380 00000000 		adds.l	%s62,%sp,%s62
 7148      BE8B3E59 
 7149 a388 00000000 		st	%s62,0(,%s28)
 7149      9C003E11 
 7150 a390 B0FFFFFF 		ld	%s62,-80(,%fp)	# ohe
 7150      89003E01 
 7151 a398 C0FFFFFF 		lea	%s61,-64
 7151      00003D06 
 7152 a3a0 00000000 		st	%s62,0(%s61,%fp)
 7152      89BD3E11 
 7153 a3a8 00000000 		or	%s62,1,(0)1
 7153      00013E45 
 7154 a3b0 00000000 		st2b	%s62,0(,%s23)
 7154      97003E14 
 7155 a3b8 00000000 		adds.l	%s28,%fp,(59)1
 7155      3B891C59 
 7156 a3c0 00000000 		muls.l	%s0,4,%s18
 7156      9204006E 
 7157 a3c8 E8EBFFFF 		st	%s0,-5144(,%fp)	# spill 
 7157      89000011 
 7158 a3d0 00000000 		lea	%s12,__grow_stack@LO
 7158      00000C06 
 7159 a3d8 00000000 		and	%s12,%s12,(32)0
 7159      608C0C44 
 7160 a3e0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 7160      8C008C06 
 7161 a3e8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 7161      8C000A08 
 7162 a3f0 D0000000 		lea	%s62,208
 7162      00003E06 
 7163 a3f8 581C0000 		br.l	.L7.0
 7163      00000F18 
 7164              	.L7.1:
 7165              	# line 2771
2771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for(int kh=0; kh<KW; ++kh){
 7166              		.loc	1 2771 0
 7167 a400 80000000 		mins.l	%s60,%s47,%s60
 7167      BCAF3C68 
 7168 a408 00000000 		smvl	%s13
 7168      00000D2E 
 7169 a410 00000000 		lvl	%s13
 7169      008D00BF 
 7170 a418 50F4FFFF 		lea	%s13,-2992(,%fp)	# restore
 7170      89000D06 
 7171 a420 00000034 		vld	%v52,8,%s13 	# restore
 7171      8D084081 
 7172 a428 D8180000 		br.l	.L7.2
 7172      00000F18 
 7173              	.L7.3:
 7174              	# line 2780
2772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int oh_beg, oh_end;
2773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
2774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
2775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh_beg < 0    ) oh_beg = 0;
2776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh_end > OH) oh_end = OH;
2777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohb[kh] = oh_beg;
2778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohe[kh] = oh_end;
2779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for(int kw=0; kw<KW; ++kw){
 7175              		.loc	1 2780 0
 7176 a430 80000000 		mins.l	%s60,%s43,%s60
 7176      BCAB3C68 
 7177 a438 00000000 		smvl	%s13
 7177      00000D2E 
 7178 a440 00000000 		lvl	%s13
 7178      008D00BF 
 7179 a448 50ECFFFF 		lea	%s13,-5040(,%fp)	# restore
 7179      89000D06 
 7180 a450 00000015 		vld	%v21,8,%s13 	# restore
 7180      8D084081 
 7181 a458 70140000 		br.l	.L7.4
 7181      00000F18 
 7182              	.L7.5:
 7183              	# line 2791
2781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int ow_beg, ow_end;
2782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
2783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
2784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow_beg < 0    ) ow_beg = 0;
2785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow_end > OW) ow_end = OW;
2786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owb[kw] = ow_beg;
2787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owe[kw] = ow_end;
2788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (int kh = 0; kh < KH; ++kh) {
2790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int kw = 0; kw < KW; ++kw) {
2791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ook[kh*KW+kw] = (ohb[kh] < ohe[kh] && owb[kw] < owe[kw]);
 7184              		.loc	1 2791 0
 7185 a460 00000000 		or	%s60,0,(0)1
 7185      00003C45 
 7186 a468 40120000 		br.l	.L7.6
 7186      00000F18 
 7187              	.L7.7:
 7188              	# line 2868
2792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
2795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define PREZERO 1
2796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if PREZERO
2797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
2798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(for collapse(3))//;
2799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for (ssize_t g = 0; g < G; ++g) {
2800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t oc = 0; oc < OCOG; ++oc) {
2801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t ic = 0; ic < ICOG; ++ic) {
2802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         const ssize_t wei_off00 = (((g * OCOG + oc) * ICOG + ic) * KH + 0) * KW + 0;
2803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t kh = 0; kh < KH; ++kh) {
2804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t kw = 0; kw < KW; ++kw) {
2805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             pdiff_wei[wei_off00 + kh*KW + kw] = 0.f;
2806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   zero_wei(p, diff_wei_m);
2813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 1
2816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
2817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   if ((p->dir & FLAG_BIA)) {
2819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(2) nowait)//;
2820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (ssize_t g = 0; g < G; ++g) {
2821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (ssize_t oc = 0; oc < OCOG; ++oc) {
2822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         ssize_t bia_off = bia_off_f2(p, g, oc);
2823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         //float &db = pdiff_bia[bia_off];
2824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         pdiff_bia[bia_off] = 0.f;
2825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (ssize_t mb = 0; mb < MB; ++mb) {
2826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           const ssize_t dst_off00 = ((mb * OC + g * OCOG + oc) * OH + 0) * OW + 0;
2827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (ssize_t oh = 0; oh < OH; ++oh) {
2828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (ssize_t ow = 0; ow < OW; ++ow) {
2829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               pdiff_bia[bia_off] += pdiff_dst[dst_off00 + oh*OW + ow];
2830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             }
2831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           }
2832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         }
2833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       }
2834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
2835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
2836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #define TMP_IC 0
2839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if TMP_IC==0
2840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   zero_wei(p, diff_wei_m);
2841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   bwd_w_bias_update(p, diff_bia_m, diff_dst_m);
2843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //for (int mb = 0; mb < MB; ++mb) // <------ XXX WRONG position. not omp-safe
2844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   OMP(parallel)
2845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   {
2846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     OMP(for collapse(4))//;
2847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int g = 0; g < G; ++g) {
2848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
2849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
2850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int kw = 0; kw < KW; ++kw) {
2851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
2852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int oh_beg, oh_end;
2853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);//(c-a+b-1)/b
2854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
2855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh_beg < 0    ) oh_beg = 0;
2856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (oh_end > OH) oh_end = OH;
2857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( oh_beg == ohb[kh] );
2858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( oh_end == ohe[kh] );
2859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             int ow_beg, ow_end;
2860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);//(c-a+b-1)/b
2861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
2862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow_beg < 0    ) ow_beg = 0;
2863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if (ow_end > OW) ow_end = OW;
2864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( ow_beg == owb[kw] );
2865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RT_ASSERT( ow_end == owe[kw] );
2866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
2867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             if( !ook[kh*KW+kw] ) continue;
 7189              		.loc	1 2868 0
 7190 a470 80000000 		mins.l	%s53,%s47,%s53
 7190      B5AF3568 
 7191 a478 380B0000 		br.l	.L7.8
 7191      00000F18 
 7192              	.L7.9:
 7193              	# line 2896
2869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int oh_beg = ohb[kh];
2870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int oh_end = ohe[kh];
2871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ow_beg = owb[kw];
2872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ow_end = owe[kw];
2873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             //if( oh_beg >= oh_end || ow_beg >= ow_end ) continue; // oh, still need to set dw=0
2875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** 
2876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int iw0 = - PW + kw * (p->dw+1);
2877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ih0 = - PH + kh * (p->dh + 1);
2878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if TMP_IC
2879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             float tmp[ICOG];
2880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int ic = 0; ic < IC/G; ++ic) tmp[ic] = 0.f; // MUST always execute!
2881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             RETAIN(tmp)//;
2882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
2883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               for (int mb = 0; mb < MB; ++mb) // OK inside
2884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
2885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 size_t d_00 = dst_off_f(p, mb, g, oc, 0, 0);
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int ic = 0; ic < IC/G; ++ic) { // B
2887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
2888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               float &dw = pdiff_wei[wei_off];
2889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               //dw = 0.f; // 2.2x --> 2.0x
2890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 size_t s_00 = src_off_f(p, mb, g, ic, 0, 0) + iw0;
2891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int oh = oh_beg; oh < oh_end; ++oh) {
2892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const int ih = ih0 + oh * SH; // - PH + kh * (p->dh + 1);
2893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const int s0h = s_00 + ih*IW;
2894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const int s0h = s_00 + (ih0 + oh * SH) * IW;
2895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const int d0h = d_00 + oh*OW;
2896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (int ow = ow_beg; ow < ow_end; ++ow) {
 7194              		.loc	1 2896 0
 7195 a480 80000000 		mins.w.sx	%s61,%s56,%s61
 7195      BDB83D78 
 7196 a488 E8010000 		br.l	.L7.10
 7196      00000F18 
 7197              	.L7.11:
 7198 a490 00000000 		or	%s51,0,%s27
 7198      9B003345 
 7199 a498 B8FDFFFF 		ld	%s54,-584(,%fp)	# restore 
 7199      89003601 
 7200 a4a0 00000000 		or	%s50,0,%s28
 7200      9C003245 
 7201 a4a8 D8FDFFFF 		ld	%s49,-552(,%fp)	# restore 
 7201      89003101 
 7202 a4b0 00000000 		or	%s47,0,%s24
 7202      98002F45 
 7203 a4b8 C8FDFFFF 		ld	%s53,-568(,%fp)	# restore 
 7203      89003501 
 7204 a4c0 00000000 		or	%s44,0,%s25
 7204      99002C45 
 7205 a4c8 C0FDFFFF 		ld	%s48,-576(,%fp)	# restore 
 7205      89003001 
 7206 a4d0 00000000 		or	%s43,0,%s26
 7206      9A002B45 
 7207 a4d8 A8FDFFFF 		ld	%s7,-600(,%fp)	# restore 
 7207      89000701 
 7208 a4e0 98FDFFFF 		ld	%s5,-616(,%fp)	# restore 
 7208      89000501 
 7209 a4e8 B0FDFFFF 		ld	%s42,-592(,%fp)	# restore 
 7209      89002A01 
 7210 a4f0 A0FDFFFF 		ld	%s6,-608(,%fp)	# restore 
 7210      89000601 
 7211 a4f8 90FDFFFF 		ld	%s4,-624(,%fp)	# restore 
 7211      89000401 
 7212 a500 D0FDFFFF 		ld	%s55,-560(,%fp)	# restore 
 7212      89003701 
 7213 a508 E0080000 		br.l	.L7.12
 7213      00000F18 
 7214              	.L7.13:
 7215              	# line 2883
2883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 7216              		.loc	1 2883 0
 7217 a510 00000000 		adds.l	%s63,1,%s63
 7217      BF013F59 
 7218 a518 00000000 		adds.l	%s39,%s60,%s39
 7218      A7BC2759 
 7219 a520 00000000 		adds.l	%s55,%s58,%s55
 7219      B7BA3759 
 7220 a528 E8030000 		brgt.l	0,%s63,.L7.14
 7220      BF000118 
 7221 a530 60FFFFFF 		br.l	.L7.11
 7221      00000F18 
 7222              	.L7.15:
 7223 a538 00000000 		or	%s63,0,%s5
 7223      85003F45 
 7224 a540 00000000 		or	%s60,0,%s6
 7224      86003C45 
 7225 a548 00000000 		or	%s58,0,%s7
 7225      87003A45 
 7226 a550 00000000 		or	%s55,0,%s23
 7226      97003745 
 7227 a558 B8FFFFFF 		br.l	.L7.13
 7227      00000F18 
 7228              	.L7.16:
 7229              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7230              		.loc	1 2886 0
 7231 a560 00000000 		adds.l	%s63,1,%s63
 7231      BF013F59 
 7232 a568 00000000 		adds.l	%s55,%s62,%s55
 7232      B7BE3759 
 7233 a570 00000000 		adds.l	%s60,%s61,%s60
 7233      BCBD3C59 
 7234 a578 C8020000 		brgt.l	0,%s63,.L7.17
 7234      BF000118 
 7235 a580 B8FFFFFF 		br.l	.L7.15
 7235      00000F18 
 7236              	.L7.18:
 7237 a588 00000000 		or	%s63,0,%s1
 7237      81003F45 
 7238 a590 00000000 		or	%s62,0,%s2
 7238      82003E45 
 7239 a598 00000000 		or	%s61,0,%s3
 7239      83003D45 
 7240 a5a0 00000000 		or	%s60,0,%s4
 7240      84003C45 
 7241 a5a8 B8FFFFFF 		br.l	.L7.16
 7241      00000F18 
 7242              	.L7.19:
 7243              	# line 2891
2891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const int ih = ih0 + oh * SH; // - PH + kh * (p->dh + 1);
 7244              		.loc	1 2891 0
 7245 a5b0 00000000 		adds.w.sx	%s58,1,%s58
 7245      BA013A4A 
 7246 a5b8 00000000 		adds.l	%s61,%s57,%s61
 7246      BDB93D59 
 7247 a5c0 00000000 		adds.l	%s63,%s56,%s63
 7247      BFB83F59 
 7248 a5c8 E0010000 		brgt.w	0,%s58,.L7.20
 7248      BA008118 
 7249 a5d0 B8FFFFFF 		br.l	.L7.18
 7249      00000F18 
 7250              	.L7.21:
 7251              	# line 2913
2897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
2898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //const size_t dst_off = d_00 + oh*OW + ow;
2899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //const size_t dst_off = d0h + ow;
2900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //const int iw = iw0 + ow * SW; // - PW + kw * (p->dw + 1);
2901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //const int iw = ow * SW; // - PW + kw * (p->dw + 1);
2902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
2903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t src_off = s_00 + ih*IW+iw;
2904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t src_off = s0h + ow*SW;
2905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //#if TMP_IC
2906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //                    tmp[ic] += pdiff_dst[dst_off] * psrc[src_off];
2907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //#else
2908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //                    dw += pdiff_dst[dst_off] * psrc[src_off];
2909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** //#endif
2910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if TMP_IC
2911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     tmp[ic] += pdiff_dst[d0h + ow] * psrc[s0h + ow*SW];
2912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #else
2913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     dw += pdiff_dst[d0h + ow] * psrc[s0h + ow*SW];
 7252              		.loc	1 2913 0
 7253 a5d8 00000000 		or	%s62,1,(0)1
 7253      00013E45 
 7254 a5e0 00000000 		or	%s60,0,%s55
 7254      B7003C45 
 7255 a5e8 00000000 		lvl	%s62
 7255      00BE00BF 
 7256 a5f0 0000003C 		vldu.nc	%v60,0,%s60
 7256      BC000082 
 7257 a5f8 00000000 		lvl	%s54
 7257      00B600BF 
 7258 a600 00003F3B 		vfsum.s	%v59,%v63
 7258      000080EC 
 7259 a608 00000000 		or	%s62,1,(0)1
 7259      00013E45 
 7260 a610 00000000 		lvl	%s62
 7260      00BE00BF 
 7261 a618 003B3C3A 		vfadd.s	%v58,%v60,%v59
 7261      000080CC 
 7262 a620 00000000 		or	%s62,1,(0)1
 7262      00013E45 
 7263 a628 00000000 		or	%s60,0,%s55
 7263      B7003C45 
 7264 a630 00000000 		lvl	%s62
 7264      00BE00BF 
 7265 a638 0000003A 		vstu.nc	%v58,0,%s60
 7265      BC000092 
 7266 a640 00000000 		or	%s63,0,%s53
 7266      B5003F45 
 7267 a648 00000000 		or	%s56,0,%s52
 7267      B4003845 
 7268 a650 00000000 		or	%s61,0,%s51
 7268      B3003D45 
 7269 a658 00000000 		or	%s57,0,%s50
 7269      B2003945 
 7270 a660 00000000 		or	%s58,0,%s49
 7270      B1003A45 
 7271 a668 48FFFFFF 		br.l	.L7.19
 7271      00000F18 
 7272              	.L7.10:
 7273 a670 00000000 		or	%s62,0,%s63
 7273      BF003E45 
 7274 a678 00000000 		lvl	%s61
 7274      00BD00BF 
 7275 a680 0000003E 		vldu.nc	%v62,4,%s62
 7275      BE040082 
 7276 a688 00000000 		or	%s62,0,%s60
 7276      BC003E45 
 7277 a690 0000003D 		vldu.nc	%v61,%s59,%s62
 7277      BEBB0082 
 7278 a698 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 7278      000080E2 
 7279              	# line 2896
2896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 7280              		.loc	1 2896 0
 7281 a6a0 00000000 		adds.l	%s63,%s63,%s58
 7281      BABF3F59 
 7282 a6a8 00000000 		adds.l	%s60,%s60,%s57
 7282      B9BC3C59 
 7283 a6b0 00000000 		subs.w.sx	%s56,%s56,%s61
 7283      BDB8385A 
 7284 a6b8 20FFFFFF 		brge.w	0,%s56,.L7.21
 7284      B8008518 
 7285 a6c0 C0FDFFFF 		br.l	.L7.9
 7285      00000F18 
 7286              	.L7.22:
 7287 a6c8 00000000 		or	%s48,0,%s60
 7287      BC003045 
 7288 a6d0 00000000 		or	%s44,0,%s18
 7288      92002C45 
 7289 a6d8 00000000 		adds.w.sx	%s43,%s18,%s47
 7289      AF922B4A 
 7290 a6e0 00000000 		muls.l	%s48,4,%s48
 7290      B004306E 
 7291 a6e8 00000000 		or	%s52,0,%s56
 7291      B8003445 
 7292 a6f0 00000000 		muls.l	%s42,4,%s44
 7292      AC042A6E 
 7293 a6f8 00000000 		adds.l	%s48,%s48,%s46
 7293      AEB03059 
 7294 a700 00000000 		muls.l	%s44,%s44,%s59
 7294      BBAC2C6E 
 7295 a708 00000000 		or	%s53,0,%s63
 7295      BF003545 
 7296 a710 00000000 		or	%s51,0,%s61
 7296      BD003345 
 7297 a718 00000000 		adds.l	%s60,%s48,%s44
 7297      ACB03C59 
 7298 a720 00000000 		or	%s62,0,%s62
 7298      BE003E45 
 7299 a728 00000000 		muls.l	%s62,4,%s62
 7299      BE043E6E 
 7300 a730 00000000 		or	%s49,0,%s58
 7300      BA003145 
 7301 a738 00000000 		or	%s50,0,%s57
 7301      B9003245 
 7302 a740 00000000 		adds.l	%s62,%s62,%s45
 7302      ADBE3E59 
 7303 a748 00000000 		adds.l	%s63,%s62,%s42
 7303      AABE3F59 
 7304 a750 00000000 		subs.w.sx	%s43,0,%s43
 7304      AB002B5A 
 7305 a758 00000000 		smvl	%s54
 7305      0000362E 
 7306 a760 80000000 		mins.w.sx	%s61,%s43,%s54
 7306      B6AB3D78 
 7307              	# line 2913
 7308              		.loc	1 2913 0
 7309 a768 00000000 		or	%s62,0,(0)1
 7309      00003E45 
 7310 a770 00000000 		lvl	%s54
 7310      00B600BF 
 7311 a778 0000003F 		vbrdu	%v63,%s62
 7311      00BE808C 
 7312 a780 00000000 		or	%s56,0,%s43
 7312      AB003845 
 7313 a788 00000000 		or	%s62,0,%s61
 7313      BD003E45 
 7314              	# line 2896
2896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 7315              		.loc	1 2896 0
 7316 a790 00000000 		muls.l	%s58,4,%s62
 7316      BE043A6E 
 7317 a798 00000000 		muls.l	%s57,%s59,%s62
 7317      BEBB396E 
 7318 a7a0 D0FEFFFF 		br.l	.L7.10
 7318      00000F18 
 7319              	.L7.20:
 7320 a7a8 00000000 		or	%s62,0,%s63
 7320      BF003E45 
 7321              	# line 2895
2895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   for (int ow = ow_beg; ow < ow_end; ++ow) {
 7322              		.loc	1 2895 0
 7323 a7b0 00000000 		adds.w.sx	%s62,0,%s62
 7323      BE003E4A 
 7324 a7b8 00000000 		or	%s60,0,%s61
 7324      BD003C45 
 7325              	# line 2894
2894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   const int d0h = d_00 + oh*OW;
 7326              		.loc	1 2894 0
 7327 a7c0 00000000 		adds.w.sx	%s60,0,%s60
 7327      BC003C4A 
 7328 a7c8 00FFFFFF 		brlt.w	%s18,%s19,.L7.22
 7328      93928218 
 7329 a7d0 E0FDFFFF 		br.l	.L7.19
 7329      00000F18 
 7330              	.L7.23:
 7331 a7d8 00000000 		or	%s54,0,%s20
 7331      94003645 
 7332              	# line 2891
2891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const int ih = ih0 + oh * SH; // - PH + kh * (p->dh + 1);
 7333              		.loc	1 2891 0
 7334 a7e0 00000000 		adds.w.sx	%s58,%s20,%s41
 7334      A9943A4A 
 7335 a7e8 00000000 		adds.l	%s53,%s60,%s40
 7335      A8BC3559 
 7336 a7f0 00000000 		muls.l	%s52,%s54,%s57
 7336      B9B6346E 
 7337 a7f8 00000000 		or	%s1,0,%s63
 7337      BF000145 
 7338 a800 00000000 		or	%s2,0,%s62
 7338      BE000245 
 7339 a808 00000000 		adds.l	%s52,%s53,%s52
 7339      B4B53459 
 7340 a810 00000000 		muls.l	%s54,%s54,%s56
 7340      B8B6366E 
 7341 a818 00000000 		or	%s3,0,%s61
 7341      BD000345 
 7342 a820 00000000 		or	%s61,0,%s52
 7342      B4003D45 
 7343 a828 00000000 		adds.l	%s63,%s54,%s39
 7343      A7B63F59 
 7344 a830 00000000 		or	%s4,0,%s60
 7344      BC000445 
 7345 a838 70FFFFFF 		br.l	.L7.20
 7345      00000F18 
 7346              	.L7.17:
 7347 a840 98FFFFFF 		brlt.w	%s20,%s21,.L7.23
 7347      95948218 
 7348 a848 18FDFFFF 		br.l	.L7.16
 7348      00000F18 
 7349              	.L7.24:
 7350              	# line 2887
2887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               float &dw = pdiff_wei[wei_off];
 7351              		.loc	1 2887 0
 7352 a850 00000000 		divu.l	%s54,%s38,%s37
 7352      A5A6366F 
 7353 a858 00000000 		or	%s5,0,%s63
 7353      BF000545 
 7354 a860 00000000 		or	%s6,0,%s60
 7354      BC000645 
 7355 a868 00000000 		or	%s7,0,%s58
 7355      BA000745 
 7356 a870 00000000 		or	%s23,0,%s55
 7356      B7001745 
 7357 a878 00000000 		addu.l	%s54,%s54,%s36
 7357      A4B63648 
 7358 a880 00000000 		mulu.l	%s54,%s54,%s35
 7358      A3B63649 
 7359 a888 00000000 		divu.l	%s54,%s54,%s37
 7359      A5B6366F 
 7360 a890 00000000 		or	%s54,0,%s54
 7360      B6003645 
 7361              	# line 2890
2890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int oh = oh_beg; oh < oh_end; ++oh) {
 7362              		.loc	1 2890 0
 7363 a898 00000000 		divs.w.sx	%s58,%s34,%s33
 7363      A1A23A7B 
 7364 a8a0 00000000 		or	%s58,0,%s58
 7364      BA003A45 
 7365 a8a8 00000000 		or	%s53,0,%s55
 7365      B7003545 
 7366 a8b0 00000000 		addu.l	%s53,%s58,%s53
 7366      B5BA3548 
 7367 a8b8 00000000 		or	%s53,0,%s53
 7367      B5003545 
 7368              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7369              		.loc	1 2886 0
 7370 a8c0 00000000 		divs.l	%s58,%s32,%s31
 7370      9FA03A7F 
 7371 a8c8 00000000 		subs.l	%s58,0,%s58
 7371      BA003A5B 
 7372 a8d0 00000000 		or	%s63,0,%s58
 7372      BA003F45 
 7373 a8d8 00000000 		muls.l	%s54,%s54,%s62
 7373      BEB6366E 
 7374 a8e0 00000000 		adds.l	%s54,%s54,%s30
 7374      9EB63659 
 7375 a8e8 00000000 		or	%s55,0,%s54
 7375      B6003745 
 7376 a8f0 00000000 		muls.l	%s53,%s53,%s61
 7376      BDB5356E 
 7377 a8f8 00000000 		adds.l	%s53,%s53,%s29
 7377      9DB53559 
 7378 a900 00000000 		or	%s60,0,%s53
 7378      B5003C45 
 7379 a908 38FFFFFF 		br.l	.L7.17
 7379      00000F18 
 7380              	.L7.14:
 7381 a910 40FFFFFF 		brlt.l	0,%s22,.L7.24
 7381      96000218 
 7382 a918 F8FBFFFF 		br.l	.L7.13
 7382      00000F18 
 7383              	.L7.25:
 7384 a920 D8FDFFFF 		st	%s49,-552(,%fp)	# spill 
 7384      89003111 
 7385 a928 D0FDFFFF 		st	%s55,-560(,%fp)	# spill 
 7385      89003711 
 7386 a930 C8FDFFFF 		st	%s53,-568(,%fp)	# spill 
 7386      89003511 
 7387 a938 C0FDFFFF 		st	%s48,-576(,%fp)	# spill 
 7387      89003011 
 7388 a940 B8FDFFFF 		st	%s54,-584(,%fp)	# spill 
 7388      89003611 
 7389 a948 B0FDFFFF 		st	%s42,-592(,%fp)	# spill 
 7389      89002A11 
 7390 a950 A8FDFFFF 		st	%s7,-600(,%fp)	# spill 
 7390      89000711 
 7391 a958 A0FDFFFF 		st	%s6,-608(,%fp)	# spill 
 7391      89000611 
 7392 a960 98FDFFFF 		st	%s5,-616(,%fp)	# spill 
 7392      89000511 
 7393 a968 90FDFFFF 		st	%s4,-624(,%fp)	# spill 
 7393      89000411 
 7394              	# line 2885
2885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int ic = 0; ic < IC/G; ++ic) { // B
 7395              		.loc	1 2885 0
 7396 a970 00000000 		divs.w.sx	%s42,%s42,%s33
 7396      A1AA2A7B 
 7397 a978 00000000 		or	%s24,0,%s47
 7397      AF001845 
 7398 a980 00000000 		or	%s25,0,%s44
 7398      AC001945 
 7399 a988 00000000 		or	%s26,0,%s43
 7399      AB001A45 
 7400 a990 00000000 		or	%s27,0,%s51
 7400      B3001B45 
 7401 a998 00000000 		or	%s28,0,%s50
 7401      B2001C45 
 7402 a9a0 00000000 		or	%s42,0,%s42
 7402      AA002A45 
 7403 a9a8 00000000 		or	%s42,0,%s42
 7403      AA002A45 
 7404              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7405              		.loc	1 2886 0
 7406 a9b0 00000000 		divs.l	%s22,%s32,%s31
 7406      9FA0167F 
 7407 a9b8 00000000 		or	%s52,0,%s52
 7407      B4003445 
 7408 a9c0 00000000 		or	%s29,0,%s52
 7408      B4001D45 
 7409              	# line 2883
2883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 7410              		.loc	1 2883 0
 7411 a9c8 00000000 		or	%s55,0,(0)1
 7411      00003745 
 7412 a9d0 00000000 		or	%s63,0,%s7
 7412      87003F45 
 7413 a9d8 00000000 		muls.l	%s6,%s42,%s6
 7413      86AA066E 
 7414 a9e0 00000000 		adds.l	%s5,%s6,%s5
 7414      85860559 
 7415 a9e8 00000000 		or	%s39,0,%s5
 7415      85002745 
 7416              	# line 2896
2896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 7417              		.loc	1 2896 0
 7418 a9f0 00000000 		subs.w.sx	%s47,0,%s19
 7418      93002F5A 
 7419              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7420              		.loc	1 2886 0
 7421 a9f8 00000000 		adds.l	%s30,%s54,%s4
 7421      84B61E59 
 7422 aa00 10FFFFFF 		br.l	.L7.14
 7422      00000F18 
 7423              	.L7.26:
 7424              	# line 2871
2871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ow_end = owe[kw];
 7425              		.loc	1 2871 0
 7426 aa08 00000000 		ldl.sx	%s18,0(%s54,%s47)	# *(owb)
 7426      AFB61203 
 7427              	# line 2872
2872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 7428              		.loc	1 2872 0
 7429 aa10 00000000 		ldl.sx	%s19,0(%s54,%s44)	# *(owe)
 7429      ACB61303 
 7430              	# line 2876
2876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ih0 = - PH + kh * (p->dh + 1);
 7431              		.loc	1 2876 0
 7432 aa18 00000000 		adds.w.sx	%s52,0,%s50
 7432      B200344A 
 7433 aa20 00FFFFFF 		brlt.l	0,%s43,.L7.25
 7433      AB000218 
 7434 aa28 C0030000 		br.l	.L7.12
 7434      00000F18 
 7435              	.L7.27:
 7436 aa30 00000000 		lea	%s63,__eh_curr_region@LO
 7436      00003F06 
 7437 aa38 00000000 		and	%s63,%s63,(32)0
 7437      60BF3F44 
 7438 aa40 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 7438      BF00BF06 
 7439 aa48 60FEFFFF 		ld2b.zx	%s62,-416(,%fp)
 7439      8900BE04 
 7440 aa50 00000000 		st2b	%s62,0(,%s63)
 7440      BF003E14 
 7441 aa58 38FEFFFF 		ld	%s63,-456(,%fp)
 7441      89003F01 
 7442 aa60 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 7442      00003E06 
 7443 aa68 00000000 		and	%s62,%s62,(32)0
 7443      60BE3E44 
 7444 aa70 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 7444      BE00BE06 
 7445 aa78 00000000 		st	%s63,0(,%s62)
 7445      BE003F11 
 7446 aa80 00000000 		lea	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 7446      00000006 
 7447 aa88 00000000 		and	%s0,%s0,(32)0
 7447      60800044 
 7448 aa90 00000000 		lea.sl	%s0,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s0)
 7448      80008006 
 7449 aa98 08000000 		ld	%s1,8(,%fp)	# ptr
 7449      89000101 
 7450 aaa0 00000000 		lea	%s12,__ftrace_func_exit@LO
 7450      00000C06 
 7451 aaa8 00000000 		and	%s12,%s12,(32)0
 7451      608C0C44 
 7452 aab0 00000000 		lea.sl	%s12,__ftrace_func_exit@HI(,%s12)
 7452      8C008C06 
 7453 aab8 00000000 		bsic	%lr,(,%s12)	# __ftrace_func_exit
 7453      8C000A08 
 7454              	# Start of epilogue codes
 7455 aac0 30000000 		ld	%s18,48(,%fp)
 7455      89001201 
 7456 aac8 38000000 		ld	%s19,56(,%fp)
 7456      89001301 
 7457 aad0 40000000 		ld	%s20,64(,%fp)
 7457      89001401 
 7458 aad8 48000000 		ld	%s21,72(,%fp)
 7458      89001501 
 7459 aae0 50000000 		ld	%s22,80(,%fp)
 7459      89001601 
 7460 aae8 58000000 		ld	%s23,88(,%fp)
 7460      89001701 
 7461 aaf0 60000000 		ld	%s24,96(,%fp)
 7461      89001801 
 7462 aaf8 68000000 		ld	%s25,104(,%fp)
 7462      89001901 
 7463 ab00 70000000 		ld	%s26,112(,%fp)
 7463      89001A01 
 7464 ab08 78000000 		ld	%s27,120(,%fp)
 7464      89001B01 
 7465 ab10 80000000 		ld	%s28,128(,%fp)
 7465      89001C01 
 7466 ab18 88000000 		ld	%s29,136(,%fp)
 7466      89001D01 
 7467 ab20 90000000 		ld	%s30,144(,%fp)
 7467      89001E01 
 7468 ab28 98000000 		ld	%s31,152(,%fp)
 7468      89001F01 
 7469 ab30 A0000000 		ld	%s32,160(,%fp)
 7469      89002001 
 7470 ab38 A8000000 		ld	%s33,168(,%fp)
 7470      89002101 
 7471 ab40 00000000 		or	%sp,0,%fp
 7471      89000B45 
 7472              		.cfi_def_cfa	11,8
 7473 ab48 18000000 		ld	%got,0x18(,%sp)
 7473      8B000F01 
 7474 ab50 20000000 		ld	%plt,0x20(,%sp)
 7474      8B001001 
 7475 ab58 08000000 		ld	%lr,0x8(,%sp)
 7475      8B000A01 
 7476 ab60 00000000 		ld	%fp,0x0(,%sp)
 7476      8B000901 
 7477 ab68 00000000 		b.l	(,%lr)
 7477      8A000F19 
 7478              	.L7.28:
 7479              	# line 2847
2847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 7480              		.loc	1 2847 0
 7481 ab70 00000000 		adds.l	%s55,1,%s55
 7481      B7013759 
 7482 ab78 00000000 		adds.w.sx	%s42,%s54,%s42
 7482      AAB62A4A 
 7483 ab80 00000000 		adds.l	%s50,%s53,%s50
 7483      B2B53259 
 7484 ab88 00000000 		adds.w.sx	%s34,%s41,%s34
 7484      A2A9224A 
 7485 ab90 E8060000 		brgt.l	0,%s55,.L7.29
 7485      B7000118 
 7486 ab98 98FEFFFF 		br.l	.L7.27
 7486      00000F18 
 7487              	.L7.30:
 7488 aba0 30ECFFFF 		ld	%s55,-5072(,%fp)	# restore 
 7488      89003701 
 7489 aba8 40ECFFFF 		ld	%s54,-5056(,%fp)	# restore 
 7489      89003601 
 7490 abb0 B0FDFFFF 		ld	%s42,-592(,%fp)	# restore 
 7490      89002A01 
 7491 abb8 28ECFFFF 		ld	%s53,-5080(,%fp)	# restore 
 7491      89003501 
 7492 abc0 20ECFFFF 		ld	%s50,-5088(,%fp)	# restore 
 7492      89003201 
 7493 abc8 38ECFFFF 		ld	%s41,-5064(,%fp)	# restore 
 7493      89002901 
 7494 abd0 08FDFFFF 		ld	%s34,-760(,%fp)	# restore 
 7494      89002201 
 7495 abd8 48ECFFFF 		ld	%s20,-5048(,%fp)	# restore 
 7495      89001401 
 7496 abe0 18ECFFFF 		ld	%s59,-5096(,%fp)	# restore 
 7496      89003B01 
 7497 abe8 88FFFFFF 		br.l	.L7.28
 7497      00000F18 
 7498              	.L7.31:
 7499              	# line 2848
2848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 7500              		.loc	1 2848 0
 7501 abf0 00000000 		adds.l	%s53,1,%s53
 7501      B5013559 
 7502 abf8 00000000 		adds.w.sx	%s63,1,%s63
 7502      BF013F4A 
 7503 ac00 E0050000 		brgt.l	0,%s53,.L7.32
 7503      B5000118 
 7504 ac08 98FFFFFF 		br.l	.L7.30
 7504      00000F18 
 7505              	.L7.33:
 7506 ac10 70FCFFFF 		ld	%s53,-912(,%fp)	# restore 
 7506      89003501 
 7507 ac18 68FCFFFF 		ld	%s63,-920(,%fp)	# restore 
 7507      89003F01 
 7508 ac20 78FCFFFF 		ld	%s19,-904(,%fp)	# restore 
 7508      89001301 
 7509 ac28 58FCFFFF 		ld	%s61,-936(,%fp)	# restore 
 7509      89003D01 
 7510 ac30 50FCFFFF 		ld	%s60,-944(,%fp)	# restore 
 7510      89003C01 
 7511 ac38 60FCFFFF 		ld	%s62,-928(,%fp)	# restore 
 7511      89003E01 
 7512 ac40 A0FDFFFF 		ld	%s6,-608(,%fp)	# restore 
 7512      89000601 
 7513 ac48 A8FFFFFF 		br.l	.L7.31
 7513      00000F18 
 7514              	.L7.34:
 7515              	# line 2849
2849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 7516              		.loc	1 2849 0
 7517 ac50 00000000 		adds.w.sx	%s53,1,%s53
 7517      B501354A 
 7518 ac58 00000000 		adds.l	%s63,%s52,%s63
 7518      BFB43F59 
 7519 ac60 00000000 		adds.l	%s50,4,%s50
 7519      B2043259 
 7520 ac68 00000000 		adds.l	%s41,%s48,%s41
 7520      A9B02959 
 7521 ac70 00000000 		adds.w.sx	%s55,1,%s55
 7521      B701374A 
 7522 ac78 D0040000 		brgt.w	0,%s53,.L7.35
 7522      B5008118 
 7523 ac80 90FFFFFF 		br.l	.L7.33
 7523      00000F18 
 7524              	.L7.36:
 7525 ac88 80FCFFFF 		st	%s47,-896(,%fp)	# spill 
 7525      89002F11 
 7526 ac90 88FCFFFF 		st	%s44,-888(,%fp)	# spill 
 7526      89002C11 
 7527 ac98 90FCFFFF 		st	%s38,-880(,%fp)	# spill 
 7527      89002611 
 7528 aca0 98FCFFFF 		st	%s36,-872(,%fp)	# spill 
 7528      89002411 
 7529 aca8 A0FCFFFF 		st	%s37,-864(,%fp)	# spill 
 7529      89002511 
 7530 acb0 A8FCFFFF 		st	%s35,-856(,%fp)	# spill 
 7530      89002311 
 7531 acb8 B0FCFFFF 		st	%s45,-848(,%fp)	# spill 
 7531      89002D11 
 7532 acc0 B8FCFFFF 		st	%s46,-840(,%fp)	# spill 
 7532      89002E11 
 7533 acc8 C0FCFFFF 		st	%s56,-832(,%fp)	# spill 
 7533      89003811 
 7534 acd0 C8FCFFFF 		st	%s43,-824(,%fp)	# spill 
 7534      89002B11 
 7535 acd8 D0FCFFFF 		st	%s51,-816(,%fp)	# spill 
 7535      89003311 
 7536 ace0 D8FCFFFF 		st	%s59,-808(,%fp)	# spill 
 7536      89003B11 
 7537 ace8 E0FCFFFF 		st	%s57,-800(,%fp)	# spill 
 7537      89003911 
 7538 acf0 E8FCFFFF 		st	%s62,-792(,%fp)	# spill 
 7538      89003E11 
 7539 acf8 F0FCFFFF 		st	%s61,-784(,%fp)	# spill 
 7539      89003D11 
 7540 ad00 A8FDFFFF 		st	%s7,-600(,%fp)	# spill 
 7540      89000711 
 7541 ad08 F8FCFFFF 		st	%s60,-776(,%fp)	# spill 
 7541      89003C11 
 7542 ad10 98FDFFFF 		st	%s5,-616(,%fp)	# spill 
 7542      89000511 
 7543 ad18 00FDFFFF 		st	%s58,-768(,%fp)	# spill 
 7543      89003A11 
 7544 ad20 D8FDFFFF 		st	%s49,-552(,%fp)	# spill 
 7544      89003111 
 7545 ad28 08FDFFFF 		st	%s34,-760(,%fp)	# spill 
 7545      89002211 
 7546 ad30 B0FDFFFF 		st	%s42,-592(,%fp)	# spill 
 7546      89002A11 
 7547 ad38 A0FDFFFF 		st	%s6,-608(,%fp)	# spill 
 7547      89000611 
 7548 ad40 80FDFFFF 		ld	%s62,-640(,%fp)	# restore 
 7548      89003E01 
 7549              	# line 2850
2850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 7550              		.loc	1 2850 0
 7551 ad48 00000000 		subs.l	%s0,0,%s62
 7551      BE00005B 
 7552 ad50 00000000 		lea	%s12,__grow_stack@LO
 7552      00000C06 
 7553 ad58 00000000 		and	%s12,%s12,(32)0
 7553      608C0C44 
 7554 ad60 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 7554      8C008C06 
 7555 ad68 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 7555      8C000A08 
 7556 ad70 30FDFFFF 		ld	%s53,-720(,%fp)	# restore 
 7556      89003501 
 7557 ad78 28FDFFFF 		ld	%s52,-728(,%fp)	# restore 
 7557      89003401 
 7558 ad80 88FDFFFF 		ld	%s63,-632(,%fp)	# restore 
 7558      89003F01 
 7559 ad88 38FDFFFF 		ld	%s50,-712(,%fp)	# restore 
 7559      89003201 
 7560 ad90 20FDFFFF 		ld	%s48,-736(,%fp)	# restore 
 7560      89003001 
 7561 ad98 40FDFFFF 		ld	%s41,-704(,%fp)	# restore 
 7561      89002901 
 7562 ada0 68FDFFFF 		ld	%s55,-664(,%fp)	# restore 
 7562      89003701 
 7563 ada8 78FDFFFF 		ld	%s23,-648(,%fp)	# restore 
 7563      89001701 
 7564 adb0 70FDFFFF 		ld	%s24,-656(,%fp)	# restore 
 7564      89001801 
 7565 adb8 60FDFFFF 		ld	%s27,-672(,%fp)	# restore 
 7565      89001B01 
 7566 adc0 58FDFFFF 		ld	%s18,-680(,%fp)	# restore 
 7566      89001201 
 7567 adc8 50FDFFFF 		ld	%s26,-688(,%fp)	# restore 
 7567      89001A01 
 7568 add0 48FDFFFF 		ld	%s28,-696(,%fp)	# restore 
 7568      89001C01 
 7569 add8 18FDFFFF 		ld	%s25,-744(,%fp)	# restore 
 7569      89001901 
 7570 ade0 70FEFFFF 		br.l	.L7.34
 7570      00000F18 
 7571              	.L7.12:
 7572 ade8 00000000 		or	%s52,4,(0)1
 7572      00043445 
 7573 adf0 00000000 		st2b	%s52,0(,%s51)
 7573      B3003414 
 7574              	# line 2896
2896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 7575              		.loc	1 2896 0
 7576 adf8 00000000 		adds.l	%s54,4,%s54
 7576      B6043659 
 7577 ae00 00000000 		adds.l	%s50,%s50,%s49
 7577      B1B23259 
 7578 ae08 00000000 		adds.l	%s53,4,%s53
 7578      B5043559 
 7579 ae10 00000000 		adds.l	%s48,-1,%s48
 7579      B07F3059 
 7580 ae18 10000000 		brlt.l	0,%s48,.L7.37
 7580      B0000218 
 7581 ae20 68FEFFFF 		br.l	.L7.36
 7581      00000F18 
 7582              	.L7.37:
 7583              	# line 2868
2868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int oh_beg = ohb[kh];
 7584              		.loc	1 2868 0
 7585 ae28 00000000 		ldl.sx	%s18,0(%s53,%s55)
 7585      B7B51203 
 7586 ae30 B8FFFFFF 		breq.w	0,%s18,.L7.12
 7586      92008418 
 7587 ae38 D0FBFFFF 		br.l	.L7.26
 7587      00000F18 
 7588              	.L7.38:
 7589 ae40 78FDFFFF 		st	%s23,-648(,%fp)	# spill 
 7589      89001711 
 7590 ae48 70FDFFFF 		st	%s24,-656(,%fp)	# spill 
 7590      89001811 
 7591 ae50 68FDFFFF 		st	%s1,-664(,%fp)	# spill 
 7591      89000111 
 7592 ae58 60FDFFFF 		st	%s27,-672(,%fp)	# spill 
 7592      89001B11 
 7593 ae60 58FDFFFF 		st	%s18,-680(,%fp)	# spill 
 7593      89001211 
 7594 ae68 50FDFFFF 		st	%s26,-688(,%fp)	# spill 
 7594      89001A11 
 7595 ae70 48FDFFFF 		st	%s28,-696(,%fp)	# spill 
 7595      89001C11 
 7596 ae78 40FDFFFF 		st	%s41,-704(,%fp)	# spill 
 7596      89002911 
 7597 ae80 38FDFFFF 		st	%s5,-712(,%fp)	# spill 
 7597      89000511 
 7598 ae88 88FDFFFF 		st	%s63,-632(,%fp)	# spill 
 7598      89003F11 
 7599 ae90 30FDFFFF 		st	%s2,-720(,%fp)	# spill 
 7599      89000211 
 7600 ae98 28FDFFFF 		st	%s3,-728(,%fp)	# spill 
 7600      89000311 
 7601 aea0 20FDFFFF 		st	%s4,-736(,%fp)	# spill 
 7601      89000411 
 7602 aea8 18FDFFFF 		st	%s25,-744(,%fp)	# spill 
 7602      89001911 
 7603 aeb0 80FDFFFF 		st	%s19,-640(,%fp)	# spill 
 7603      89001311 
 7604 aeb8 00000000 		or	%s48,0,%s29
 7604      9D003045 
 7605              	# line 2896
2896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 7606              		.loc	1 2896 0
 7607 aec0 00000000 		or	%s54,0,(0)1
 7607      00003645 
 7608 aec8 10FDFFFF 		ld	%s50,-752(,%fp)	# restore 
 7608      89003201 
 7609 aed0 00000000 		or	%s53,0,(0)1
 7609      00003545 
 7610 aed8 00000000 		or	%s55,0,%s22
 7610      96003745 
 7611 aee0 00000000 		or	%s41,0,%s6
 7611      86002945 
 7612 aee8 00000000 		or	%s4,0,%s7
 7612      87000445 
 7613 aef0 A0FDFFFF 		ld	%s6,-608(,%fp)	# restore 
 7613      89000601 
 7614 aef8 B0FDFFFF 		ld	%s42,-592(,%fp)	# restore 
 7614      89002A01 
 7615 af00 08FDFFFF 		ld	%s34,-760(,%fp)	# restore 
 7615      89002201 
 7616 af08 D8FDFFFF 		ld	%s49,-552(,%fp)	# restore 
 7616      89003101 
 7617 af10 00FDFFFF 		ld	%s58,-768(,%fp)	# restore 
 7617      89003A01 
 7618 af18 98FDFFFF 		ld	%s5,-616(,%fp)	# restore 
 7618      89000501 
 7619 af20 F8FCFFFF 		ld	%s60,-776(,%fp)	# restore 
 7619      89003C01 
 7620 af28 A8FDFFFF 		ld	%s7,-600(,%fp)	# restore 
 7620      89000701 
 7621 af30 F0FCFFFF 		ld	%s61,-784(,%fp)	# restore 
 7621      89003D01 
 7622 af38 E8FCFFFF 		ld	%s62,-792(,%fp)	# restore 
 7622      89003E01 
 7623 af40 E0FCFFFF 		ld	%s57,-800(,%fp)	# restore 
 7623      89003901 
 7624 af48 D8FCFFFF 		ld	%s59,-808(,%fp)	# restore 
 7624      89003B01 
 7625 af50 D0FCFFFF 		ld	%s51,-816(,%fp)	# restore 
 7625      89003301 
 7626 af58 C8FCFFFF 		ld	%s43,-824(,%fp)	# restore 
 7626      89002B01 
 7627 af60 C0FCFFFF 		ld	%s56,-832(,%fp)	# restore 
 7627      89003801 
 7628 af68 B8FCFFFF 		ld	%s46,-840(,%fp)	# restore 
 7628      89002E01 
 7629 af70 B0FCFFFF 		ld	%s45,-848(,%fp)	# restore 
 7629      89002D01 
 7630 af78 A8FCFFFF 		ld	%s35,-856(,%fp)	# restore 
 7630      89002301 
 7631 af80 A0FCFFFF 		ld	%s37,-864(,%fp)	# restore 
 7631      89002501 
 7632 af88 98FCFFFF 		ld	%s36,-872(,%fp)	# restore 
 7632      89002401 
 7633 af90 90FCFFFF 		ld	%s38,-880(,%fp)	# restore 
 7633      89002601 
 7634 af98 88FCFFFF 		ld	%s44,-888(,%fp)	# restore 
 7634      89002C01 
 7635 afa0 80FCFFFF 		ld	%s47,-896(,%fp)	# restore 
 7635      89002F01 
 7636 afa8 80FEFFFF 		br.l	.L7.37
 7636      00000F18 
 7637              	.L7.8:
 7638              	# line 2868
2868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int oh_beg = ohb[kh];
 7639              		.loc	1 2868 0
 7640 afb0 00000000 		adds.l	%s55,%s63,(0)1
 7640      00BF3759 
 7641 afb8 00000000 		adds.l	%s55,%s55,%s54
 7641      B6B73759 
 7642 afc0 00000000 		lvl	%s53
 7642      00B500BF 
 7643 afc8 00000039 		vldl.sx.nc	%v57,4,%s55
 7643      B7040083 
 7644 afd0 00000000 		adds.l	%s55,%s52,%s51
 7644      B3B43759 
 7645 afd8 00000039 		vstl.nc	%v57,4,%s55
 7645      B7040093 
 7646 afe0 00000000 		adds.l	%s54,%s54,%s50
 7646      B2B63659 
 7647 afe8 00000000 		adds.l	%s51,%s51,%s49
 7647      B1B33359 
 7648 aff0 00000000 		or	%s49,0,%s48
 7648      B0003145 
 7649 aff8 00000000 		subs.l	%s47,%s47,%s53
 7649      B5AF2F5B 
 7650 b000 40FEFFFF 		brge.l	0,%s47,.L7.38
 7650      AF000518 
 7651 b008 68F4FFFF 		br.l	.L7.7
 7651      00000F18 
 7652              	.L7.39:
 7653 b010 88FDFFFF 		st	%s63,-632(,%fp)	# spill 
 7653      89003F11 
 7654              	# line 2869
2869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int oh_end = ohe[kh];
 7655              		.loc	1 2869 0
 7656 b018 00000000 		dldl.sx	%s20,0(%s50,%s23)	# *(ohb)
 7656      97B2140B 
 7657              	# line 2870
2870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ow_beg = owb[kw];
 7658              		.loc	1 2870 0
 7659 b020 00000000 		dldl.sx	%s21,0(%s50,%s24)	# *(ohe)
 7659      98B2150B 
 7660              	# line 2891
2891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const int ih = ih0 + oh * SH; // - PH + kh * (p->dh + 1);
 7661              		.loc	1 2891 0
 7662 b028 00000000 		subs.w.sx	%s6,0,%s21
 7662      9500065A 
 7663              	# line 2877
2877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if TMP_IC
 7664              		.loc	1 2877 0
 7665 b030 00000000 		adds.w.sx	%s62,0,%s41
 7665      A9003E4A 
 7666 b038 00000000 		or	%s62,0,%s62
 7666      BE003E45 
 7667              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7668              		.loc	1 2886 0
 7669 b040 00000000 		muls.l	%s61,%s54,%s25
 7669      99B63D6E 
 7670              	# line 2891
2891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const int ih = ih0 + oh * SH; // - PH + kh * (p->dh + 1);
 7671              		.loc	1 2891 0
 7672 b048 00000000 		muls.l	%s40,%s62,%s26
 7672      9ABE286E 
 7673              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7674              		.loc	1 2886 0
 7675 b050 00000000 		adds.l	%s7,%s61,%s27
 7675      9BBD0759 
 7676              	# line 2850
2850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 7677              		.loc	1 2850 0
 7678 b058 00000000 		subs.l	%s29,0,%s28
 7678      9C001D5B 
 7679 b060 00000000 		smvl	%s30
 7679      00001E2E 
 7680 b068 00000000 		muls.l	%s0,4,%s29
 7680      9D04006E 
 7681 b070 80FDFFFF 		st	%s0,-640(,%fp)	# spill 
 7681      89000011 
 7682 b078 00000000 		lea	%s12,__grow_stack@LO
 7682      00000C06 
 7683 b080 00000000 		and	%s12,%s12,(32)0
 7683      608C0C44 
 7684 b088 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 7684      8C008C06 
 7685 b090 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 7685      8C000A08 
 7686 b098 D0000000 		lea	%s62,208
 7686      00003E06 
 7687 b0a0 00000000 		adds.l	%s62,%sp,%s62
 7687      BE8B3E59 
 7688 b0a8 88FDFFFF 		ld	%s63,-632(,%fp)	# restore 
 7688      89003F01 
 7689 b0b0 00000000 		or	%s22,0,%s62
 7689      BE001645 
 7690 b0b8 80000000 		mins.l	%s61,%s29,%s30
 7690      9E9D3D68 
 7691 b0c0 00000000 		or	%s47,0,%s29
 7691      9D002F45 
 7692 b0c8 00000000 		or	%s54,0,(0)1
 7692      00003645 
 7693 b0d0 00000000 		muls.l	%s60,4,%s61
 7693      BD043C6E 
 7694 b0d8 00000000 		or	%s1,0,%s55
 7694      B7000145 
 7695 b0e0 00000000 		muls.l	%s49,4,%s61
 7695      BD04316E 
 7696 b0e8 00000000 		or	%s51,0,(0)1
 7696      00003345 
 7697 b0f0 00000000 		muls.l	%s30,4,%s30
 7697      9E041E6E 
 7698 b0f8 00000000 		or	%s2,0,%s53
 7698      B5000245 
 7699 b100 00000000 		or	%s53,0,%s61
 7699      BD003545 
 7700 b108 00000000 		or	%s3,0,%s52
 7700      B4000345 
 7701 b110 00000000 		or	%s52,0,%s62
 7701      BE003445 
 7702 b118 00000000 		or	%s4,0,%s48
 7702      B0000445 
 7703 b120 00000000 		or	%s48,0,%s30
 7703      9E003045 
 7704 b128 00000000 		or	%s5,0,%s50
 7704      B2000545 
 7705 b130 00000000 		or	%s50,0,%s60
 7705      BC003245 
 7706 b138 80FDFFFF 		ld	%s19,-640(,%fp)	# restore 
 7706      89001301 
 7707 b140 70FEFFFF 		br.l	.L7.8
 7707      00000F18 
 7708              	.L7.35:
 7709 b148 00000000 		or	%s54,0,%s55
 7709      B7003645 
 7710 b150 C0FEFFFF 		brlt.l	0,%s18,.L7.39
 7710      92000218 
 7711 b158 F8FAFFFF 		br.l	.L7.34
 7711      00000F18 
 7712              	.L7.40:
 7713 b160 78FCFFFF 		st	%s19,-904(,%fp)	# spill 
 7713      89001311 
 7714 b168 70FCFFFF 		st	%s53,-912(,%fp)	# spill 
 7714      89003511 
 7715 b170 68FCFFFF 		st	%s63,-920(,%fp)	# spill 
 7715      89003F11 
 7716 b178 60FCFFFF 		st	%s62,-928(,%fp)	# spill 
 7716      89003E11 
 7717 b180 58FCFFFF 		st	%s61,-936(,%fp)	# spill 
 7717      89003D11 
 7718 b188 50FCFFFF 		st	%s60,-944(,%fp)	# spill 
 7718      89003C11 
 7719 b190 A0FDFFFF 		st	%s6,-608(,%fp)	# spill 
 7719      89000611 
 7720 b198 00000000 		or	%s36,0,%s63
 7720      BF002445 
 7721 b1a0 98FCFFFF 		st	%s36,-872(,%fp)	# spill 
 7721      89002411 
 7722 b1a8 00000000 		or	%s53,0,%s62
 7722      BE003545 
 7723              	# line 2849
2849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 7724              		.loc	1 2849 0
 7725 b1b0 00000000 		or	%s50,0,(0)1
 7725      00003245 
 7726 b1b8 00000000 		or	%s63,0,%s61
 7726      BD003F45 
 7727 b1c0 00000000 		or	%s41,0,%s60
 7727      BC002945 
 7728              	# line 2883
2883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 7729              		.loc	1 2883 0
 7730 b1c8 00000000 		muls.l	%s5,%s54,%s6
 7730      86B6056E 
 7731 b1d0 98FDFFFF 		st	%s5,-616(,%fp)	# spill 
 7731      89000511 
 7732 b1d8 70FFFFFF 		br.l	.L7.35
 7732      00000F18 
 7733              	.L7.32:
 7734 b1e0 00000000 		or	%s54,0,%s63
 7734      BF003645 
 7735              	# line 2849
2849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 7736              		.loc	1 2849 0
 7737 b1e8 00000000 		or	%s55,0,(0)1
 7737      00003745 
 7738 b1f0 70FFFFFF 		brlt.w	0,%s19,.L7.40
 7738      93008218 
 7739 b1f8 F8F9FFFF 		br.l	.L7.31
 7739      00000F18 
 7740              	.L7.41:
 7741 b200 48ECFFFF 		st	%s20,-5048(,%fp)	# spill 
 7741      89001411 
 7742 b208 40ECFFFF 		st	%s54,-5056(,%fp)	# spill 
 7742      89003611 
 7743 b210 38ECFFFF 		st	%s41,-5064(,%fp)	# spill 
 7743      89002911 
 7744 b218 08FDFFFF 		st	%s34,-760(,%fp)	# spill 
 7744      89002211 
 7745 b220 B0FDFFFF 		st	%s42,-592(,%fp)	# spill 
 7745      89002A11 
 7746 b228 30ECFFFF 		st	%s55,-5072(,%fp)	# spill 
 7746      89003711 
 7747 b230 28ECFFFF 		st	%s53,-5080(,%fp)	# spill 
 7747      89003511 
 7748 b238 20ECFFFF 		st	%s50,-5088(,%fp)	# spill 
 7748      89003211 
 7749 b240 18ECFFFF 		st	%s59,-5096(,%fp)	# spill 
 7749      89003B11 
 7750              	# line 2848
2848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 7751              		.loc	1 2848 0
 7752 b248 00000000 		divs.l	%s59,%s59,%s31
 7752      9FBB3B7F 
 7753 b250 00000000 		subs.l	%s59,0,%s59
 7753      BB003B5B 
 7754 b258 00000000 		or	%s53,0,%s59
 7754      BB003545 
 7755 b260 00000000 		or	%s38,0,%s50
 7755      B2002645 
 7756 b268 90FCFFFF 		st	%s38,-880(,%fp)	# spill 
 7756      89002611 
 7757 b270 70FFFFFF 		br.l	.L7.32
 7757      00000F18 
 7758              	.L7.29:
 7759 b278 00000000 		or	%s63,0,(0)1
 7759      00003F45 
 7760 b280 80FFFFFF 		brlt.l	0,%s20,.L7.41
 7760      94000218 
 7761 b288 E8F8FFFF 		br.l	.L7.28
 7761      00000F18 
 7762              	.L7.42:
 7763 b290 18FEFFFF 		ld	%s56,-488(,%fp)	# OW
 7763      89003801 
 7764 b298 28FEFFFF 		ld	%s59,-472(,%fp)	# OC
 7764      89003B01 
 7765 b2a0 C0FCFFFF 		st	%s56,-832(,%fp)	# spill 
 7765      89003811 
 7766 b2a8 30FEFFFF 		ld	%s43,-464(,%fp)	# MB
 7766      89002B01 
 7767 b2b0 C8FCFFFF 		st	%s43,-824(,%fp)	# spill 
 7767      89002B11 
 7768              	# line 2883
2883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 7769              		.loc	1 2883 0
 7770 b2b8 00000000 		subs.l	%s7,0,%s43
 7770      AB00075B 
 7771              	# line 2848
2848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****         for (int kh = 0; kh < p->kh; ++kh) {
 7772              		.loc	1 2848 0
 7773 b2c0 00000000 		divs.l	%s20,%s59,%s31
 7773      9FBB147F 
 7774 b2c8 A8FDFFFF 		st	%s7,-600(,%fp)	# spill 
 7774      89000711 
 7775              	# line 2847
2847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 7776              		.loc	1 2847 0
 7777 b2d0 00000000 		subs.l	%s63,0,%s31
 7777      9F003F5B 
 7778 b2d8 00000000 		or	%s55,0,%s63
 7778      BF003745 
 7779 b2e0 F0EBFFFF 		ld	%s63,-5136(,%fp)	# restore 
 7779      89003F01 
 7780              	# line 2849
2849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 7781              		.loc	1 2849 0
 7782 b2e8 20000000 		dldl.sx	%s19,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 7782      BF00130B 
 7783 b2f0 00000000 		or	%s58,0,%s19
 7783      93003A45 
 7784 b2f8 00000000 		or	%s58,0,%s58
 7784      BA003A45 
 7785 b300 00000000 		subs.w.sx	%s62,0,%s19
 7785      93003E5A 
 7786              	# line 2868
2868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int oh_beg = ohb[kh];
 7787              		.loc	1 2868 0
 7788 b308 F0FFFFFF 		dld	%s61,-16(,%fp)	# ook
 7788      89003D09 
 7789              	# line 2869
2869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int oh_end = ohe[kh];
 7790              		.loc	1 2869 0
 7791 b310 08FEFFFF 		dld	%s23,-504(,%fp)	# ohb
 7791      89001709 
 7792              	# line 2870
2870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ow_beg = owb[kw];
 7793              		.loc	1 2870 0
 7794 b318 B0FFFFFF 		dld	%s24,-80(,%fp)	# ohe
 7794      89001809 
 7795              	# line 2871
2871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ow_end = owe[kw];
 7796              		.loc	1 2871 0
 7797 b320 E0FFFFFF 		dld	%s47,-32(,%fp)	# owb
 7797      89002F09 
 7798              	# line 2872
2872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 7799              		.loc	1 2872 0
 7800 b328 E8FFFFFF 		dld	%s44,-24(,%fp)	# owe
 7800      89002C09 
 7801 b330 80FCFFFF 		st	%s47,-896(,%fp)	# spill 
 7801      89002F11 
 7802 b338 88FCFFFF 		st	%s44,-888(,%fp)	# spill 
 7802      89002C11 
 7803 b340 58EBFFFF 		ld	%s57,-5288(,%fp)	# restore 
 7803      89003901 
 7804              	# line 2876
2876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             const int ih0 = - PH + kh * (p->dh + 1);
 7805              		.loc	1 2876 0
 7806 b348 00000000 		subs.l	%s57,0,%s57
 7806      B900395B 
 7807 b350 3C000000 		dldl.sx	%s56,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 7807      BF00380B 
 7808 b358 10FDFFFF 		st	%s57,-752(,%fp)	# spill 
 7808      89003911 
 7809 b360 00000000 		adds.w.sx	%s56,1,%s56
 7809      B801384A 
 7810 b368 00000000 		or	%s49,0,%s56
 7810      B8003145 
 7811 b370 D8FDFFFF 		st	%s49,-552(,%fp)	# spill 
 7811      89003111 
 7812 b378 60EBFFFF 		ld	%s57,-5280(,%fp)	# restore 
 7812      89003901 
 7813              	# line 2877
2877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if TMP_IC
 7814              		.loc	1 2877 0
 7815 b380 00000000 		subs.l	%s60,0,%s57
 7815      B9003C5B 
 7816 b388 38000000 		dldl.sx	%s57,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 7816      BF00390B 
 7817 b390 00000000 		adds.w.sx	%s57,1,%s57
 7817      B901394A 
 7818 b398 00000000 		or	%s48,0,%s57
 7818      B9003045 
 7819              	# line 2885
2885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int ic = 0; ic < IC/G; ++ic) { // B
 7820              		.loc	1 2885 0
 7821 b3a0 14000000 		dldl.sx	%s54,20(,%s63)	# *(p).__b_N4conv6desc_tE.oc
 7821      BF00360B 
 7822 b3a8 00000000 		or	%s57,0,%s54
 7822      B6003945 
 7823 b3b0 00000000 		or	%s53,0,%s57
 7823      B9003545 
 7824 b3b8 00000000 		dldl.sx	%s33,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 7824      BF00210B 
 7825 b3c0 00000000 		or	%s37,0,%s33
 7825      A1002545 
 7826 b3c8 A0FCFFFF 		st	%s37,-864(,%fp)	# spill 
 7826      89002511 
 7827              	# line 2847
2847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 7828              		.loc	1 2847 0
 7829 b3d0 00000000 		or	%s50,0,(0)1
 7829      00003245 
 7830              	# line 2885
2885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int ic = 0; ic < IC/G; ++ic) { // B
 7831              		.loc	1 2885 0
 7832 b3d8 18000000 		dldl.sx	%s57,24(,%s63)	# *(p).__b_N4conv6desc_tE.oh
 7832      BF00390B 
 7833 b3e0 00000000 		or	%s57,0,%s57
 7833      B9003945 
 7834 b3e8 00000000 		or	%s57,0,%s57
 7834      B9003945 
 7835              	# line 2883
2883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 7836              		.loc	1 2883 0
 7837 b3f0 00000000 		muls.l	%s56,%s53,%s57
 7837      B9B5386E 
 7838              	# line 2885
2885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****             for (int ic = 0; ic < IC/G; ++ic) { // B
 7839              		.loc	1 2885 0
 7840 b3f8 1C000000 		dldl.sx	%s51,28(,%s63)	# *(p).__b_N4conv6desc_tE.ow
 7840      BF00330B 
 7841 b400 00000000 		or	%s51,0,%s51
 7841      B3003345 
 7842 b408 00000000 		or	%s51,0,%s51
 7842      B3003345 
 7843              	# line 2883
2883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               {
 7844              		.loc	1 2883 0
 7845 b410 00000000 		muls.l	%s56,%s51,%s56
 7845      B8B3386E 
 7846 b418 00000000 		muls.l	%s6,%s57,%s51
 7846      B3B9066E 
 7847 b420 F8FCFFFF 		st	%s56,-776(,%fp)	# spill 
 7847      89003811 
 7848              	# line 2887
2887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               float &dw = pdiff_wei[wei_off];
 7849              		.loc	1 2887 0
 7850 b428 08000000 		dldl.sx	%s41,8(,%s63)	# *(p).__b_N4conv6desc_tE.ic
 7850      BF00290B 
 7851 b430 00000000 		or	%s35,0,%s41
 7851      A9002345 
 7852 b438 A8FCFFFF 		st	%s35,-856(,%fp)	# spill 
 7852      89002311 
 7853 b440 00000000 		or	%s35,0,%s35
 7853      A3002345 
 7854 b448 00FDFFFF 		st	%s35,-768(,%fp)	# spill 
 7854      89002311 
 7855 b450 24000000 		dldl.sx	%s57,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 7855      BF00390B 
 7856 b458 00000000 		or	%s57,0,%s57
 7856      B9003945 
 7857 b460 00000000 		or	%s57,0,%s57
 7857      B9003945 
 7858              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7859              		.loc	1 2886 0
 7860 b468 00000000 		muls.l	%s58,%s58,%s57
 7860      B9BA3A6E 
 7861              	# line 2890
2890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                 for (int oh = oh_beg; oh < oh_end; ++oh) {
 7862              		.loc	1 2890 0
 7863 b470 0C000000 		dldl.sx	%s56,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 7863      BF00380B 
 7864 b478 00000000 		or	%s56,0,%s56
 7864      B8003845 
 7865 b480 00000000 		or	%s56,0,%s56
 7865      B8003845 
 7866 b488 10000000 		dldl.sx	%s63,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 7866      BF003F0B 
 7867 b490 00000000 		or	%s63,0,%s63
 7867      BF003F45 
 7868 b498 00000000 		or	%s63,0,%s63
 7868      BF003F45 
 7869              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7870              		.loc	1 2886 0
 7871 b4a0 00000000 		muls.l	%s63,%s56,%s63
 7871      BFB83F6E 
 7872 b4a8 00000000 		lea	%s51,__eh_curr_region@LO
 7872      00003306 
 7873 b4b0 00000000 		and	%s51,%s51,(32)0
 7873      60B33344 
 7874 b4b8 00000000 		lea.sl	%s51,__eh_curr_region@HI(,%s51)
 7874      B300B306 
 7875              	# line 2847
2847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 7876              		.loc	1 2847 0
 7877 b4c0 00000000 		or	%s42,0,(0)1
 7877      00002A45 
 7878 b4c8 F0FCFFFF 		st	%s63,-784(,%fp)	# spill 
 7878      89003F11 
 7879 b4d0 D0FCFFFF 		st	%s51,-816(,%fp)	# spill 
 7879      89003311 
 7880 b4d8 00000000 		or	%s34,0,(0)1
 7880      00002245 
 7881              	# line 2886
2886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); // WRITTEN
 7882              		.loc	1 2886 0
 7883 b4e0 00000000 		muls.l	%s58,4,%s58
 7883      BA043A6E 
 7884 b4e8 00000000 		muls.l	%s25,4,%s57
 7884      B904196E 
 7885 b4f0 E8FCFFFF 		st	%s58,-792(,%fp)	# spill 
 7885      89003A11 
 7886              	# line 2849
2849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****           for (int kw = 0; kw < KW; ++kw) {
 7887              		.loc	1 2849 0
 7888 b4f8 00000000 		muls.l	%s52,4,%s18
 7888      9204346E 
 7889              	# line 2850
2850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #if 0
 7890              		.loc	1 2850 0
 7891 b500 00000000 		subs.l	%s28,0,%s18
 7891      92001C5B 
 7892 b508 50EBFFFF 		ld	%s58,-5296(,%fp)	# restore 
 7892      89003A01 
 7893              	# line 2891
2891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                   //const int ih = ih0 + oh * SH; // - PH + kh * (p->dh + 1);
 7894              		.loc	1 2891 0
 7895 b510 00000000 		muls.l	%s57,%s58,%s26
 7895      9ABA396E 
 7896 b518 48EBFFFF 		ld	%s56,-5304(,%fp)	# restore 
 7896      89003801 
 7897 b520 E0FCFFFF 		st	%s57,-800(,%fp)	# spill 
 7897      89003911 
 7898              	# line 2896
2896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****                     //size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 7899              		.loc	1 2896 0
 7900 b528 00000000 		muls.l	%s56,4,%s56
 7900      B804386E 
 7901 b530 D8FCFFFF 		st	%s56,-808(,%fp)	# spill 
 7901      89003811 
 7902 b538 40FDFFFF 		br.l	.L7.29
 7902      00000F18 
 7903              	.L7.43:
 7904 b540 60EBFFFF 		st	%s59,-5280(,%fp)	# spill 
 7904      89003B11 
 7905 b548 58EBFFFF 		st	%s57,-5288(,%fp)	# spill 
 7905      89003911 
 7906 b550 50EBFFFF 		st	%s58,-5296(,%fp)	# spill 
 7906      89003A11 
 7907 b558 48EBFFFF 		st	%s56,-5304(,%fp)	# spill 
 7907      89003811 
 7908 b560 B8FCFFFF 		st	%s46,-840(,%fp)	# spill 
 7908      89002E11 
 7909 b568 B0FCFFFF 		st	%s45,-848(,%fp)	# spill 
 7909      89002D11 
 7910 b570 00ECFFFF 		ld	%s2,-5120(,%fp)	# restore 
 7910      89000201 
 7911              	# line 2840
2840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp **** #endif
 7912              		.loc	1 2840 0
 7913 b578 A8010000 		ld	%s0,424(,%s2)	# *(diff_wei_m).data_
 7913      82000001 
 7914 b580 98010000 		ld	%s62,408(,%s2)	# *(diff_wei_m).mpd_
 7914      82003E01 
 7915 b588 40EBFFFF 		st	%s0,-5312(,%fp)	# spill 
 7915      89000011 
 7916 b590 00000000 		or	%s0,0,%s62
 7916      BE000045 
 7917 b598 00000000 		lea	%s12,mkldnn_memory_primitive_desc_get_size@LO
 7917      00000C06 
 7918 b5a0 00000000 		and	%s12,%s12,(32)0
 7918      608C0C44 
 7919 b5a8 00000000 		lea.sl	%s12,mkldnn_memory_primitive_desc_get_size@HI(,%s12)
 7919      8C008C06 
 7920 b5b0 00000000 		bsic	%lr,(,%s12)	# mkldnn_memory_primitive_desc_get_size
 7920      8C000A08 
 7921 b5b8 00000000 		or	%s1,0,(0)1
 7921      00000145 
 7922 b5c0 00000000 		or	%s2,0,%s0
 7922      80000245 
 7923 b5c8 40EBFFFF 		ld	%s0,-5312(,%fp)	# restore 
 7923      89000001 
 7924 b5d0 00000000 		lea	%s12,__vec_memset@LO
 7924      00000C06 
 7925 b5d8 00000000 		and	%s12,%s12,(32)0
 7925      608C0C44 
 7926 b5e0 00000000 		lea.sl	%s12,__vec_memset@HI(,%s12)
 7926      8C008C06 
 7927 b5e8 00000000 		bsic	%lr,(,%s12)	# __vec_memset
 7927      8C000A08 
 7928              	# line 2842
2842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   //for (int mb = 0; mb < MB; ++mb) // <------ XXX WRONG position. not omp-safe
 7929              		.loc	1 2842 0
 7930 b5f0 E0FDFFFF 		lea	%s62,-544
 7930      00003E06 
 7931 b5f8 00000000 		adds.l	%s0,%fp,%s62
 7931      BE890059 
 7932 b600 10ECFFFF 		ld	%s3,-5104(,%fp)	# restore 
 7932      89000301 
 7933 b608 08ECFFFF 		ld	%s2,-5112(,%fp)	# restore 
 7933      89000201 
 7934 b610 F0EBFFFF 		ld	%s1,-5136(,%fp)	# restore 
 7934      89000101 
 7935 b618 00000000 		lea	%s12,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const@LO
 7935      00000C06 
 7936 b620 00000000 		and	%s12,%s12,(32)0
 7936      608C0C44 
 7937 b628 00000000 		lea.sl	%s12,conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)::{lambda(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&)#1}::operator()(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&) const
 7937      8C008C06 
 7938 b630 00000000 		bsic	%lr,(,%s12)	# _ZZN4conv14sxconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_ENKUlS2_S4_S4_E_clES2
 7938      8C000A08 
 7939 b638 58FCFFFF 		brlt.l	0,%s31,.L7.42
 7939      9F000218 
 7940 b640 F0F3FFFF 		br.l	.L7.27
 7940      00000F18 
 7941              	.L7.44:
 7942 b648 00000000 		or	%s56,0,%s2
 7942      82003845 
 7943 b650 00000000 		or	%s58,0,%s3
 7943      83003A45 
 7944 b658 00000000 		or	%s57,0,%s4
 7944      84003945 
 7945 b660 00000000 		or	%s59,0,%s5
 7945      85003B45 
 7946 b668 D8FEFFFF 		br.l	.L7.43
 7946      00000F18 
 7947              	.L7.45:
 7948              	# line 2789
2789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int kw = 0; kw < KW; ++kw) {
 7949              		.loc	1 2789 0
 7950 b670 00000000 		adds.l	%s60,1,%s60
 7950      BC013C59 
 7951 b678 00000000 		adds.l	%s62,4,%s62
 7951      BE043E59 
 7952 b680 00000000 		adds.l	%s53,%s54,%s53
 7952      B5B63559 
 7953 b688 C0000000 		brgt.l	0,%s60,.L7.46
 7953      BC000118 
 7954 b690 B8FFFFFF 		br.l	.L7.44
 7954      00000F18 
 7955              	.L7.47:
 7956 b698 00000000 		or	%s60,0,%s1
 7956      81003C45 
 7957 b6a0 D0FFFFFF 		br.l	.L7.45
 7957      00000F18 
 7958              	.L7.6:
 7959              	# line 2791
2791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 7960              		.loc	1 2791 0
 7961 b6a8 00000000 		stl	%s60,0(%s58,%s59)	# *(ook)
 7961      BBBA3C13 
 7962              	# line 2790
2790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ook[kh*KW+kw] = (ohb[kh] < ohe[kh] && owb[kw] < owe[kw]);
 7963              		.loc	1 2790 0
 7964 b6b0 00000000 		adds.l	%s57,1,%s57
 7964      B9013959 
 7965 b6b8 00000000 		adds.l	%s58,4,%s58
 7965      BA043A59 
 7966 b6c0 40000000 		brgt.l	0,%s57,.L7.48
 7966      B9000118 
 7967 b6c8 D0FFFFFF 		br.l	.L7.47
 7967      00000F18 
 7968              	.L7.49:
 7969              	# line 2791
2791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 7970              		.loc	1 2791 0
 7971 b6d0 00000000 		or	%s60,1,(0)1
 7971      00013C45 
 7972 b6d8 D0FFFFFF 		br.l	.L7.6
 7972      00000F18 
 7973              	.L7.50:
 7974 b6e0 00000000 		ldl.sx	%s19,0(%s58,%s56)	# *(owb)
 7974      B8BA1303 
 7975 b6e8 00000000 		ldl.sx	%s20,0(%s58,%s55)	# *(owe)
 7975      B7BA1403 
 7976 b6f0 E0FFFFFF 		brlt.w	%s19,%s20,.L7.49
 7976      94938218 
 7977 b6f8 68EDFFFF 		br.l	.L7.5
 7977      00000F18 
 7978              	.L7.48:
 7979 b700 00000000 		ldl.sx	%s19,0(%s62,%s63)	# *(ohb)
 7979      BFBE1303 
 7980 b708 00000000 		ldl.sx	%s20,0(%s62,%s61)	# *(ohe)
 7980      BDBE1403 
 7981 b710 D0FFFFFF 		brlt.w	%s19,%s20,.L7.50
 7981      94938218 
 7982 b718 48EDFFFF 		br.l	.L7.5
 7982      00000F18 
 7983              	.L7.51:
 7984 b720 00000000 		or	%s59,0,%s53
 7984      B5003B45 
 7985              	# line 2790
2790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ook[kh*KW+kw] = (ohb[kh] < ohe[kh] && owb[kw] < owe[kw]);
 7986              		.loc	1 2790 0
 7987 b728 00000000 		or	%s58,0,(0)1
 7987      00003A45 
 7988 b730 00000000 		or	%s57,0,%s52
 7988      B4003945 
 7989 b738 00000000 		or	%s1,0,%s60
 7989      BC000145 
 7990 b740 C0FFFFFF 		br.l	.L7.48
 7990      00000F18 
 7991              	.L7.46:
 7992 b748 D8FFFFFF 		brlt.l	0,%s18,.L7.51
 7992      92000218 
 7993 b750 20FFFFFF 		br.l	.L7.45
 7993      00000F18 
 7994              	.L7.52:
 7995              	# line 2791
2791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     }
 7996              		.loc	1 2791 0
 7997 b758 08FEFFFF 		dld	%s63,-504(,%fp)	# ohb
 7997      89003F09 
 7998 b760 00000000 		or	%s2,0,%s56
 7998      B8000245 
 7999 b768 B0FFFFFF 		dld	%s61,-80(,%fp)	# ohe
 7999      89003D09 
 8000 b770 00000000 		or	%s3,0,%s58
 8000      BA000345 
 8001 b778 E0FFFFFF 		dld	%s56,-32(,%fp)	# owb
 8001      89003809 
 8002 b780 00000000 		or	%s4,0,%s57
 8002      B9000445 
 8003 b788 E8FFFFFF 		dld	%s55,-24(,%fp)	# owe
 8003      89003709 
 8004 b790 00000000 		or	%s5,0,%s59
 8004      BB000545 
 8005 b798 F0FFFFFF 		dld	%s59,-16(,%fp)	# ook
 8005      89003B09 
 8006              	# line 2789
2789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     for (int kw = 0; kw < KW; ++kw) {
 8007              		.loc	1 2789 0
 8008 b7a0 00000000 		subs.l	%s25,0,%s25
 8008      9900195B 
 8009 b7a8 00000000 		or	%s60,0,%s25
 8009      99003C45 
 8010 b7b0 00000000 		or	%s53,0,%s59
 8010      BB003545 
 8011 b7b8 00000000 		or	%s62,0,(0)1
 8011      00003E45 
 8012 b7c0 00000000 		muls.l	%s54,4,%s18
 8012      9204366E 
 8013              	# line 2790
2790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****       ook[kh*KW+kw] = (ohb[kh] < ohe[kh] && owb[kw] < owe[kw]);
 8014              		.loc	1 2790 0
 8015 b7c8 00000000 		subs.l	%s52,0,%s18
 8015      9200345B 
 8016 b7d0 78FFFFFF 		br.l	.L7.46
 8016      00000F18 
 8017              	.L7.53:
 8018 b7d8 80FFFFFF 		brlt.l	0,%s25,.L7.52
 8018      99000218 
 8019 b7e0 60FDFFFF 		br.l	.L7.43
 8019      00000F18 
 8020              	.L7.54:
 8021 b7e8 F0EBFFFF 		st	%s63,-5136(,%fp)	# spill 
 8021      89003F11 
 8022              	# line 2780
2780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int ow_beg, ow_end;
 8023              		.loc	1 2780 0
 8024 b7f0 00000000 		subs.l	%s0,0,%s5
 8024      8500005B 
 8025 b7f8 00000000 		lea	%s12,__grow_stack@LO
 8025      00000C06 
 8026 b800 00000000 		and	%s12,%s12,(32)0
 8026      608C0C44 
 8027 b808 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 8027      8C008C06 
 8028 b810 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 8028      8C000A08 
 8029 b818 00000000 		or	%s45,0,%s1
 8029      81002D45 
 8030 b820 00000000 		or	%s46,0,%s2
 8030      82002E45 
 8031 b828 00000000 		or	%s58,0,%s3
 8031      83003A45 
 8032 b830 00000000 		or	%s59,0,%s4
 8032      84003B45 
 8033 b838 A0FFFFFF 		br.l	.L7.53
 8033      00000F18 
 8034              	.L7.55:
 8035              	# line 2786
2786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owe[kw] = ow_end;
 8036              		.loc	1 2786 0
 8037 b840 00000000 		ldl.sx	%s60,0(%s61,%s62)
 8037      BEBD3C03 
 8038 b848 00000000 		ldl.sx	%s50,0(%s61,%s55)
 8038      B7BD3203 
 8039 b850 00000000 		stl	%s50,0(%s53,%s54)	# *(owb)
 8039      B6B53213 
 8040              	# line 2787
2787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 8041              		.loc	1 2787 0
 8042 b858 00000000 		stl	%s60,0(%s53,%s52)	# *(owe)
 8042      B4B53C13 
 8043              	# line 2780
2780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int ow_beg, ow_end;
 8044              		.loc	1 2780 0
 8045 b860 00000000 		adds.l	%s53,4,%s53
 8045      B5043559 
 8046 b868 00000000 		adds.l	%s61,4,%s61
 8046      BD043D59 
 8047 b870 00000000 		adds.l	%s51,-1,%s51
 8047      B37F3359 
 8048 b878 C8FFFFFF 		brlt.l	0,%s51,.L7.55
 8048      B3000218 
 8049 b880 68FFFFFF 		br.l	.L7.54
 8049      00000F18 
 8050              	.L7.56:
 8051 b888 00000000 		or	%s51,0,%s59
 8051      BB003345 
 8052              	# line 2786
2786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owe[kw] = ow_end;
 8053              		.loc	1 2786 0
 8054 b890 00000000 		or	%s53,0,(0)1
 8054      00003545 
 8055 b898 00000000 		or	%s61,0,(0)1
 8055      00003D45 
 8056 b8a0 00000000 		or	%s52,0,%s58
 8056      BA003445 
 8057 b8a8 00000000 		or	%s54,0,%s46
 8057      AE003645 
 8058 b8b0 00000000 		or	%s55,0,%s45
 8058      AD003745 
 8059 b8b8 00000000 		or	%s62,0,%s41
 8059      A9003E45 
 8060 b8c0 80FFFFFF 		br.l	.L7.55
 8060      00000F18 
 8061              	.L7.4:
 8062              	# line 2782
2782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
 8063              		.loc	1 2782 0
 8064 b8c8 3C000000 		ldl.sx	%s62,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 8064      BF003E03 
 8065 b8d0 00000000 		adds.w.sx	%s62,1,%s62
 8065      BE013E4A 
 8066 b8d8 00000000 		lvl	%s60
 8066      00BC00BF 
 8067 b8e0 00190014 		vadds.w.sx	%v20,%s61,%v25
 8067      00BD20CA 
 8068 b8e8 00140013 		vmuls.w.sx	%v19,%s62,%v20
 8068      00BE20CB 
 8069 b8f0 00130012 		vor	%v18,(0)1,%v19
 8069      000020C5 
 8070 b8f8 00120011 		vsubs.l	%v17,%s57,%v18
 8070      00B9209B 
 8071 b900 00110010 		vadds.l	%v16,%s56,%v17
 8071      00B8208B 
 8072 b908 00000000 		subs.l	%s62,0,(63)0
 8072      7F003E5B 
 8073 b910 0010000F 		vadds.l	%v15,%s62,%v16
 8073      00BE208B 
 8074 b918 000F000E 		vadds.w.sx	%v14,0,%v15
 8074      000020CA 
 8075 b920 00000E0D 		vdivs.w.sx	%v13,%v14,%s55
 8075      00B710EB 
 8076 b928 000D000C 		vmuls.w.sx	%v12,%s55,%v13
 8076      00B720CB 
 8077 b930 000C0E0B 		vsubs.w.sx	%v11,%v14,%v12
 8077      000000DA 
 8078 b938 000B050F 		vfmk.w.ge	%vm15,%v11
 8078      000000B5 
 8079 b940 00000018 		vbrd	%v24,0,%vm15
 8079      00000F8C 
 8080 b948 00000F0F 		negm	%vm15,%vm15
 8080      00000095 
 8081 b950 00000018 		vbrd	%v24,1,%vm15
 8081      00010F8C 
 8082 b958 00180D0A 		vsubs.w.sx	%v10,%v13,%v24
 8082      000000DA 
 8083 b960 00000000 		adds.l	%s62,%s54,%s53
 8083      B5B63E59 
 8084 b968 0000000A 		vstl.nc	%v10,4,%s62
 8084      BE040093 
 8085              	# line 2783
2783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow_beg < 0    ) ow_beg = 0;
 8086              		.loc	1 2783 0
 8087 b970 3C000000 		ldl.sx	%s42,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 8087      BF002A03 
 8088 b978 00000000 		adds.w.sx	%s42,1,%s42
 8088      AA012A4A 
 8089 b980 00190009 		vadds.w.sx	%v9,%s61,%v25
 8089      00BD20CA 
 8090 b988 00090008 		vmuls.w.sx	%v8,%s42,%v9
 8090      00AA20CB 
 8091 b990 00080007 		vor	%v7,(0)1,%v8
 8091      000020C5 
 8092 b998 00070006 		vsubs.l	%v6,%s52,%v7
 8092      00B4209B 
 8093 b9a0 00060005 		vadds.l	%v5,%s56,%v6
 8093      00B8208B 
 8094 b9a8 00000000 		subs.l	%s42,0,(63)0
 8094      7F002A5B 
 8095 b9b0 00050004 		vadds.l	%v4,%s42,%v5
 8095      00AA208B 
 8096 b9b8 00040003 		vadds.w.sx	%v3,0,%v4
 8096      000020CA 
 8097 b9c0 00000302 		vdivs.w.sx	%v2,%v3,%s55
 8097      00B710EB 
 8098 b9c8 00020001 		vmuls.w.sx	%v1,%s55,%v2
 8098      00B720CB 
 8099 b9d0 00010300 		vsubs.w.sx	%v0,%v3,%v1
 8099      000000DA 
 8100 b9d8 0000050F 		vfmk.w.ge	%vm15,%v0
 8100      000000B5 
 8101 b9e0 00000017 		vbrd	%v23,0,%vm15
 8101      00000F8C 
 8102 b9e8 00000F0F 		negm	%vm15,%vm15
 8102      00000095 
 8103 b9f0 00000017 		vbrd	%v23,1,%vm15
 8103      00010F8C 
 8104 b9f8 0017023E 		vsubs.w.sx	%v62,%v2,%v23
 8104      000000DA 
 8105 ba00 00000000 		adds.l	%s42,%s51,%s53
 8105      B5B32A59 
 8106 ba08 0000003E 		vstl.nc	%v62,4,%s42
 8106      AA040093 
 8107              	# line 2784
2784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow_end > OW) ow_end = OW;
 8108              		.loc	1 2784 0
 8109 ba10 000A003D 		vor	%v61,(0)1,%v10
 8109      000020C5 
 8110 ba18 003D020F 		vfmk.w.lt	%vm15,%v61
 8110      000000B5 
 8111 ba20 00000016 		vbrd	%v22,0,%vm15
 8111      00000F8C 
 8112 ba28 00000000 		or	%s62,0,%s62
 8112      BE003E45 
 8113 ba30 00000016 		vstl.nc	%v22,4,%s62,%vm15
 8113      BE040F93 
 8114              	# line 2785
2785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owb[kw] = ow_beg;
 8115              		.loc	1 2785 0
 8116 ba38 003E003F 		vor	%v63,(0)1,%v62
 8116      000020C5 
 8117 ba40 003F003C 		vor	%v60,(0)1,%v63
 8117      000020C5 
 8118 ba48 003C003B 		vcmps.l	%v59,%s50,%v60
 8118      00B220BA 
 8119 ba50 003B020F 		vfmk.l.lt	%vm15,%v59
 8119      000000B4 
 8120 ba58 00000015 		vbrd	%v21,%s49,%vm15
 8120      00B10F8C 
 8121 ba60 00000000 		or	%s42,0,%s42
 8121      AA002A45 
 8122 ba68 00000015 		vstl.nc	%v21,4,%s42,%vm15
 8122      AA040F93 
 8123              	# line 2780
2780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int ow_beg, ow_end;
 8124              		.loc	1 2780 0
 8125 ba70 00000000 		adds.w.sx	%s61,%s61,%s48
 8125      B0BD3D4A 
 8126 ba78 00000000 		adds.l	%s53,%s53,%s47
 8126      AFB53559 
 8127 ba80 00000000 		or	%s47,0,%s44
 8127      AC002F45 
 8128 ba88 00000000 		subs.l	%s43,%s43,%s60
 8128      BCAB2B5B 
 8129 ba90 F8FDFFFF 		brge.l	0,%s43,.L7.56
 8129      AB000518 
 8130 ba98 98E9FFFF 		br.l	.L7.3
 8130      00000F18 
 8131              	.L7.57:
 8132 baa0 18FEFFFF 		ld	%s50,-488(,%fp)	# OW
 8132      89003201 
 8133              	# line 2785
2785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owb[kw] = ow_beg;
 8134              		.loc	1 2785 0
 8135 baa8 00000000 		adds.w.sx	%s49,0,%s50
 8135      B200314A 
 8136              	# line 2782
2782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);//(d-a+b-1)/b
 8137              		.loc	1 2782 0
 8138 bab0 00000000 		adds.w.sx	%s55,0,%s56
 8138      B800374A 
 8139              	# line 2783
2783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (ow_beg < 0    ) ow_beg = 0;
 8140              		.loc	1 2783 0
 8141 bab8 00000000 		adds.l	%s52,%s26,%s57
 8141      B99A3459 
 8142              	# line 2786
2786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     owe[kw] = ow_end;
 8143              		.loc	1 2786 0
 8144 bac0 E0FFFFFF 		dld	%s23,-32(,%fp)	# owb
 8144      89001709 
 8145              	# line 2787
2787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 8146              		.loc	1 2787 0
 8147 bac8 E8FFFFFF 		dld	%s24,-24(,%fp)	# owe
 8147      89001809 
 8148              	# line 2780
2780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int ow_beg, ow_end;
 8149              		.loc	1 2780 0
 8150 bad0 00000000 		subs.l	%s62,0,%s18
 8150      92003E5B 
 8151 bad8 00000000 		subs.l	%s28,0,%s62
 8151      BE001C5B 
 8152 bae0 00000000 		smvl	%s29
 8152      00001D2E 
 8153 bae8 00000000 		muls.l	%s0,8,%s28
 8153      9C08006E 
 8154 baf0 30BBFFFF 		st	%s0,-17616(,%fp)	# spill 
 8154      89000011 
 8155 baf8 00000000 		lea	%s12,__grow_stack@LO
 8155      00000C06 
 8156 bb00 00000000 		and	%s12,%s12,(32)0
 8156      608C0C44 
 8157 bb08 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 8157      8C008C06 
 8158 bb10 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 8158      8C000A08 
 8159 bb18 D0000000 		lea	%s62,208
 8159      00003E06 
 8160 bb20 00000000 		adds.l	%s51,%sp,%s62
 8160      BE8B3359 
 8161 bb28 F0EBFFFF 		ld	%s63,-5136(,%fp)	# restore 
 8161      89003F01 
 8162 bb30 00000000 		or	%s41,0,%s51
 8162      B3002945 
 8163 bb38 00000000 		muls.l	%s62,4,%s28
 8163      9C043E6E 
 8164 bb40 00000000 		or	%s1,0,%s45
 8164      AD000145 
 8165 bb48 00000000 		or	%s2,0,%s46
 8165      AE000245 
 8166 bb50 00000000 		adds.l	%s54,%s51,%s62
 8166      BEB33659 
 8167 bb58 00000000 		or	%s46,0,%s23
 8167      97002E45 
 8168 bb60 00000000 		or	%s45,0,%s54
 8168      B6002D45 
 8169 bb68 80000000 		mins.l	%s60,%s28,%s29
 8169      9D9C3C68 
 8170 bb70 00000000 		or	%s43,0,%s28
 8170      9C002B45 
 8171 bb78 00000000 		or	%s61,0,(0)1
 8171      00003D45 
 8172 bb80 00000000 		adds.w.sx	%s48,0,%s60
 8172      BC00304A 
 8173 bb88 00000000 		or	%s3,0,%s58
 8173      BA000345 
 8174 bb90 00000000 		lvl	%s48
 8174      00B000BF 
 8175 bb98 00000039 		vseq	%v57
 8175      00000099 
 8176 bba0 00000000 		or	%s58,0,%s24
 8176      98003A45 
 8177 bba8 00000000 		or	%s4,0,%s59
 8177      BB000445 
 8178 bbb0 00000000 		or	%s59,0,%s28
 8178      9C003B45 
 8179 bbb8 30BBFFFF 		ld	%s5,-17616(,%fp)	# restore 
 8179      89000501 
 8180 bbc0 00000000 		smvl	%s13
 8180      00000D2E 
 8181 bbc8 00000000 		lvl	%s13
 8181      008D00BF 
 8182 bbd0 50ECFFFF 		lea	%s13,-5040(,%fp)	# restore
 8182      89000D06 
 8183 bbd8 00000015 		vld	%v21,8,%s13 	# restore
 8183      8D084081 
 8184 bbe0 00000000 		lvl	%s48
 8184      00B000BF 
 8185 bbe8 00390019 		vor	%v25,(0)1,%v57
 8185      000020C5 
 8186 bbf0 00000000 		muls.l	%s47,4,%s60
 8186      BC042F6E 
 8187 bbf8 00000000 		or	%s53,0,(0)1
 8187      00003545 
 8188 bc00 00000000 		muls.l	%s44,4,%s29
 8188      9D042C6E 
 8189 bc08 C0FCFFFF 		br.l	.L7.4
 8189      00000F18 
 8190              	.L7.58:
 8191 bc10 90FEFFFF 		brlt.l	0,%s18,.L7.57
 8191      92000218 
 8192 bc18 C0FBFFFF 		br.l	.L7.53
 8192      00000F18 
 8193              	.L7.59:
 8194 bc20 F0EBFFFF 		st	%s63,-5136(,%fp)	# spill 
 8194      89003F11 
 8195              	# line 2771
2771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int oh_beg, oh_end;
 8196              		.loc	1 2771 0
 8197 bc28 00000000 		subs.l	%s0,0,%s5
 8197      8500005B 
 8198 bc30 00000000 		lea	%s12,__grow_stack@LO
 8198      00000C06 
 8199 bc38 00000000 		and	%s12,%s12,(32)0
 8199      608C0C44 
 8200 bc40 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 8200      8C008C06 
 8201 bc48 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 8201      8C000A08 
 8202 bc50 00000000 		or	%s45,0,%s1
 8202      81002D45 
 8203 bc58 00000000 		or	%s46,0,%s2
 8203      82002E45 
 8204 bc60 00000000 		or	%s56,0,%s3
 8204      83003845 
 8205 bc68 00000000 		or	%s57,0,%s4
 8205      84003945 
 8206 bc70 A0FFFFFF 		br.l	.L7.58
 8206      00000F18 
 8207              	.L7.60:
 8208              	# line 2777
2777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohe[kh] = oh_end;
 8209              		.loc	1 2777 0
 8210 bc78 00000000 		ldl.sx	%s60,0(%s61,%s62)
 8210      BEBD3C03 
 8211 bc80 00000000 		ldl.sx	%s52,0(%s61,%s57)
 8211      B9BD3403 
 8212 bc88 00000000 		stl	%s52,0(%s55,%s56)	# *(ohb)
 8212      B8B73413 
 8213              	# line 2778
2778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 8214              		.loc	1 2778 0
 8215 bc90 00000000 		stl	%s60,0(%s55,%s54)	# *(ohe)
 8215      B6B73C13 
 8216              	# line 2771
2771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int oh_beg, oh_end;
 8217              		.loc	1 2771 0
 8218 bc98 00000000 		adds.l	%s55,4,%s55
 8218      B7043759 
 8219 bca0 00000000 		adds.l	%s61,4,%s61
 8219      BD043D59 
 8220 bca8 00000000 		adds.l	%s53,-1,%s53
 8220      B57F3559 
 8221 bcb0 C8FFFFFF 		brlt.l	0,%s53,.L7.60
 8221      B5000218 
 8222 bcb8 68FFFFFF 		br.l	.L7.59
 8222      00000F18 
 8223              	.L7.61:
 8224 bcc0 00000000 		or	%s53,0,%s46
 8224      AE003545 
 8225              	# line 2777
2777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohe[kh] = oh_end;
 8226              		.loc	1 2777 0
 8227 bcc8 00000000 		or	%s55,0,(0)1
 8227      00003745 
 8228 bcd0 00000000 		or	%s61,0,(0)1
 8228      00003D45 
 8229 bcd8 00000000 		or	%s54,0,%s45
 8229      AD003645 
 8230 bce0 00000000 		or	%s56,0,%s43
 8230      AB003845 
 8231 bce8 00000000 		or	%s57,0,%s42
 8231      AA003945 
 8232 bcf0 00000000 		or	%s62,0,%s41
 8232      A9003E45 
 8233 bcf8 80FFFFFF 		br.l	.L7.60
 8233      00000F18 
 8234              	.L7.2:
 8235              	# line 2773
2773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
 8236              		.loc	1 2773 0
 8237 bd00 38000000 		ldl.sx	%s62,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 8237      BF003E03 
 8238 bd08 00000000 		adds.w.sx	%s62,1,%s62
 8238      BE013E4A 
 8239 bd10 00000000 		lvl	%s60
 8239      00BC00BF 
 8240 bd18 00380033 		vadds.w.sx	%v51,%s61,%v56
 8240      00BD20CA 
 8241 bd20 00330032 		vmuls.w.sx	%v50,%s62,%v51
 8241      00BE20CB 
 8242 bd28 00320031 		vor	%v49,(0)1,%v50
 8242      000020C5 
 8243 bd30 00310030 		vsubs.l	%v48,%s59,%v49
 8243      00BB209B 
 8244 bd38 0030002F 		vadds.l	%v47,%s58,%v48
 8244      00BA208B 
 8245 bd40 00000000 		subs.l	%s62,0,(63)0
 8245      7F003E5B 
 8246 bd48 002F002E 		vadds.l	%v46,%s62,%v47
 8246      00BE208B 
 8247 bd50 002E002D 		vadds.w.sx	%v45,0,%v46
 8247      000020CA 
 8248 bd58 00002D2C 		vdivs.w.sx	%v44,%v45,%s57
 8248      00B910EB 
 8249 bd60 002C002B 		vmuls.w.sx	%v43,%s57,%v44
 8249      00B920CB 
 8250 bd68 002B2D2A 		vsubs.w.sx	%v42,%v45,%v43
 8250      000000DA 
 8251 bd70 002A050F 		vfmk.w.ge	%vm15,%v42
 8251      000000B5 
 8252 bd78 00000037 		vbrd	%v55,0,%vm15
 8252      00000F8C 
 8253 bd80 00000F0F 		negm	%vm15,%vm15
 8253      00000095 
 8254 bd88 00000037 		vbrd	%v55,1,%vm15
 8254      00010F8C 
 8255 bd90 00372C29 		vsubs.w.sx	%v41,%v44,%v55
 8255      000000DA 
 8256 bd98 00000000 		adds.l	%s62,%s56,%s55
 8256      B7B83E59 
 8257 bda0 00000029 		vstl.nc	%v41,4,%s62
 8257      BE040093 
 8258              	# line 2774
2774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh_beg < 0    ) oh_beg = 0;
 8259              		.loc	1 2774 0
 8260 bda8 38000000 		ldl.sx	%s44,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 8260      BF002C03 
 8261 bdb0 00000000 		adds.w.sx	%s44,1,%s44
 8261      AC012C4A 
 8262 bdb8 00380028 		vadds.w.sx	%v40,%s61,%v56
 8262      00BD20CA 
 8263 bdc0 00280027 		vmuls.w.sx	%v39,%s44,%v40
 8263      00AC20CB 
 8264 bdc8 00270026 		vor	%v38,(0)1,%v39
 8264      000020C5 
 8265 bdd0 00260025 		vsubs.l	%v37,%s54,%v38
 8265      00B6209B 
 8266 bdd8 00250024 		vadds.l	%v36,%s58,%v37
 8266      00BA208B 
 8267 bde0 00000000 		subs.l	%s44,0,(63)0
 8267      7F002C5B 
 8268 bde8 00240023 		vadds.l	%v35,%s44,%v36
 8268      00AC208B 
 8269 bdf0 00230022 		vadds.w.sx	%v34,0,%v35
 8269      000020CA 
 8270 bdf8 00002221 		vdivs.w.sx	%v33,%v34,%s57
 8270      00B910EB 
 8271 be00 00210020 		vmuls.w.sx	%v32,%s57,%v33
 8271      00B920CB 
 8272 be08 0020221F 		vsubs.w.sx	%v31,%v34,%v32
 8272      000000DA 
 8273 be10 001F050F 		vfmk.w.ge	%vm15,%v31
 8273      000000B5 
 8274 be18 00000036 		vbrd	%v54,0,%vm15
 8274      00000F8C 
 8275 be20 00000F0F 		negm	%vm15,%vm15
 8275      00000095 
 8276 be28 00000036 		vbrd	%v54,1,%vm15
 8276      00010F8C 
 8277 be30 0036211E 		vsubs.w.sx	%v30,%v33,%v54
 8277      000000DA 
 8278 be38 00000000 		adds.l	%s44,%s53,%s55
 8278      B7B52C59 
 8279 be40 0000001E 		vstl.nc	%v30,4,%s44
 8279      AC040093 
 8280              	# line 2775
2775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh_end > OH) oh_end = OH;
 8281              		.loc	1 2775 0
 8282 be48 0029001D 		vor	%v29,(0)1,%v41
 8282      000020C5 
 8283 be50 001D020F 		vfmk.w.lt	%vm15,%v29
 8283      000000B5 
 8284 be58 00000035 		vbrd	%v53,0,%vm15
 8284      00000F8C 
 8285 be60 00000000 		or	%s62,0,%s62
 8285      BE003E45 
 8286 be68 00000035 		vstl.nc	%v53,4,%s62,%vm15
 8286      BE040F93 
 8287              	# line 2776
2776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohb[kh] = oh_beg;
 8288              		.loc	1 2776 0
 8289 be70 001E001C 		vor	%v28,(0)1,%v30
 8289      000020C5 
 8290 be78 001C001B 		vor	%v27,(0)1,%v28
 8290      000020C5 
 8291 be80 001B001A 		vcmps.l	%v26,%s52,%v27
 8291      00B420BA 
 8292 be88 001A020F 		vfmk.l.lt	%vm15,%v26
 8292      000000B4 
 8293 be90 00000034 		vbrd	%v52,%s51,%vm15
 8293      00B30F8C 
 8294 be98 00000000 		or	%s44,0,%s44
 8294      AC002C45 
 8295 bea0 00000034 		vstl.nc	%v52,4,%s44,%vm15
 8295      AC040F93 
 8296              	# line 2771
2771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int oh_beg, oh_end;
 8297              		.loc	1 2771 0
 8298 bea8 00000000 		adds.w.sx	%s61,%s61,%s50
 8298      B2BD3D4A 
 8299 beb0 00000000 		adds.l	%s55,%s55,%s49
 8299      B1B73759 
 8300 beb8 00000000 		or	%s49,0,%s48
 8300      B0003145 
 8301 bec0 00000000 		subs.l	%s47,%s47,%s60
 8301      BCAF2F5B 
 8302 bec8 F8FDFFFF 		brge.l	0,%s47,.L7.61
 8302      AF000518 
 8303 bed0 30E5FFFF 		br.l	.L7.1
 8303      00000F18 
 8304              	.L7.62:
 8305 bed8 20FEFFFF 		ld	%s52,-480(,%fp)	# OH
 8305      89003401 
 8306              	# line 2776
2776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohb[kh] = oh_beg;
 8307              		.loc	1 2776 0
 8308 bee0 00000000 		adds.w.sx	%s51,0,%s52
 8308      B400334A 
 8309              	# line 2773
2773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);//(d-a+b-1)/b
 8310              		.loc	1 2773 0
 8311 bee8 00000000 		adds.w.sx	%s23,0,%s58
 8311      BA00174A 
 8312              	# line 2774
2774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     if (oh_beg < 0    ) oh_beg = 0;
 8313              		.loc	1 2774 0
 8314 bef0 00000000 		adds.l	%s54,%s24,%s59
 8314      BB983659 
 8315              	# line 2777
2777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     ohe[kh] = oh_end;
 8316              		.loc	1 2777 0
 8317 bef8 08FEFFFF 		dld	%s43,-504(,%fp)	# ohb
 8317      89002B09 
 8318              	# line 2778
2778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   }
 8319              		.loc	1 2778 0
 8320 bf00 B0FFFFFF 		dld	%s24,-80(,%fp)	# ohe
 8320      89001809 
 8321              	# line 2771
2771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****     int oh_beg, oh_end;
 8322              		.loc	1 2771 0
 8323 bf08 00000000 		subs.l	%s62,0,%s18
 8323      92003E5B 
 8324 bf10 00000000 		subs.l	%s28,0,%s62
 8324      BE001C5B 
 8325 bf18 00000000 		smvl	%s29
 8325      00001D2E 
 8326 bf20 00000000 		muls.l	%s0,8,%s28
 8326      9C08006E 
 8327 bf28 38D3FFFF 		st	%s0,-11464(,%fp)	# spill 
 8327      89000011 
 8328 bf30 00000000 		lea	%s12,__grow_stack@LO
 8328      00000C06 
 8329 bf38 00000000 		and	%s12,%s12,(32)0
 8329      608C0C44 
 8330 bf40 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 8330      8C008C06 
 8331 bf48 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 8331      8C000A08 
 8332 bf50 D0000000 		lea	%s62,208
 8332      00003E06 
 8333 bf58 00000000 		adds.l	%s53,%sp,%s62
 8333      BE8B3559 
 8334 bf60 F0EBFFFF 		ld	%s63,-5136(,%fp)	# restore 
 8334      89003F01 
 8335 bf68 00000000 		or	%s41,0,%s53
 8335      B5002945 
 8336 bf70 00000000 		muls.l	%s62,4,%s28
 8336      9C043E6E 
 8337 bf78 00000000 		or	%s1,0,%s45
 8337      AD000145 
 8338 bf80 00000000 		or	%s45,0,%s24
 8338      98002D45 
 8339 bf88 00000000 		adds.l	%s62,%s53,%s62
 8339      BEB53E59 
 8340 bf90 00000000 		or	%s2,0,%s46
 8340      AE000245 
 8341 bf98 00000000 		or	%s42,0,%s62
 8341      BE002A45 
 8342 bfa0 80000000 		mins.l	%s60,%s28,%s29
 8342      9D9C3C68 
 8343 bfa8 00000000 		or	%s47,0,%s28
 8343      9C002F45 
 8344 bfb0 00000000 		or	%s61,0,(0)1
 8344      00003D45 
 8345 bfb8 00000000 		adds.w.sx	%s50,0,%s60
 8345      BC00324A 
 8346 bfc0 00000000 		or	%s46,0,%s28
 8346      9C002E45 
 8347 bfc8 00000000 		lvl	%s50
 8347      00B200BF 
 8348 bfd0 0000003A 		vseq	%v58
 8348      00000099 
 8349 bfd8 00000000 		or	%s4,0,%s57
 8349      B9000445 
 8350 bfe0 00000000 		or	%s57,0,%s23
 8350      97003945 
 8351 bfe8 00000000 		or	%s3,0,%s56
 8351      B8000345 
 8352 bff0 00000000 		or	%s56,0,%s62
 8352      BE003845 
 8353 bff8 38D3FFFF 		ld	%s5,-11464(,%fp)	# restore 
 8353      89000501 
 8354 c000 00000000 		smvl	%s13
 8354      00000D2E 
 8355 c008 00000000 		lvl	%s13
 8355      008D00BF 
 8356 c010 50F4FFFF 		lea	%s13,-2992(,%fp)	# restore
 8356      89000D06 
 8357 c018 00000034 		vld	%v52,8,%s13 	# restore
 8357      8D084081 
 8358 c020 00000000 		lvl	%s50
 8358      00B200BF 
 8359 c028 003A0038 		vor	%v56,(0)1,%v58
 8359      000020C5 
 8360 c030 00000000 		muls.l	%s49,4,%s60
 8360      BC04316E 
 8361 c038 00000000 		or	%s55,0,(0)1
 8361      00003745 
 8362 c040 00000000 		muls.l	%s48,4,%s29
 8362      9D04306E 
 8363 c048 B8FCFFFF 		br.l	.L7.2
 8363      00000F18 
 8364              	.L7.0:
 8365              	# line 2770
2770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/sx_conv3_ve.cpp ****   for(int kh=0; kh<KW; ++kh){
 8366              		.loc	1 2770 0
 8367 c050 00000000 		adds.l	%s62,%sp,%s62
 8367      BE8B3E59 
 8368 c058 E8EBFFFF 		ld	%s0,-5144(,%fp)	# restore 
 8368      89000001 
 8369 c060 00000000 		st	%s62,0(,%s28)
 8369      9C003E11 
 8370 c068 E0FFFFFF 		ld	%s62,-32(,%fp)	# owb
 8370      89003E01 
 8371 c070 C8FFFFFF 		lea	%s61,-56
 8371      00003D06 
 8372 c078 00000000 		st	%s62,0(%s61,%fp)
 8372      89BD3E11 
 8373 c080 00000000 		or	%s62,2,(0)1
 8373      00023E45 
 8374 c088 00000000 		st2b	%s62,0(,%s23)
 8374      97003E14 
 8375 c090 E8FFFFFF 		lea	%s62,-24
 8375      00003E06 
 8376 c098 00000000 		adds.l	%s28,%fp,%s62
 8376      BE891C59 
 8377 c0a0 00000000 		lea	%s12,__grow_stack@LO
 8377      00000C06 
 8378 c0a8 00000000 		and	%s12,%s12,(32)0
 8378      608C0C44 
 8379 c0b0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 8379      8C008C06 
 8380 c0b8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 8380      8C000A08 
 8381 c0c0 D0000000 		lea	%s62,208
 8381      00003E06 
 8382 c0c8 00000000 		adds.l	%s62,%sp,%s62
 8382      BE8B3E59 
 8383 c0d0 00000000 		st	%s62,0(,%s28)
 8383      9C003E11 
 8384 c0d8 E8FFFFFF 		ld	%s62,-24(,%fp)	# owe
 8384      89003E01 
 8385 c0e0 D0FFFFFF 		lea	%s61,-48
 8385      00003D06 
 8386 c0e8 00000000 		st	%s62,0(%s61,%fp)
 8386      89BD3E11 
 8387 c0f0 00000000 		or	%s62,3,(0)1
 8387      00033E45 
 8388 c0f8 00000000 		st2b	%s62,0(,%s23)
 8388      97003E14 
 8389 c100 00000000 		adds.l	%s28,%fp,(60)1
 8389      3C891C59 
 8390 c108 00000000 		muls.l	%s0,4,%s29
 8390      9D04006E 
 8391 c110 00000000 		lea	%s12,__grow_stack@LO
 8391      00000C06 
 8392 c118 00000000 		and	%s12,%s12,(32)0
 8392      608C0C44 
 8393 c120 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 8393      8C008C06 
 8394 c128 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 8394      8C000A08 
 8395 c130 D0000000 		lea	%s62,208
 8395      00003E06 
 8396 c138 00000000 		adds.l	%s62,%sp,%s62
 8396      BE8B3E59 
 8397 c140 00000000 		st	%s62,0(,%s28)
 8397      9C003E11 
 8398 c148 F0FFFFFF 		ld	%s62,-16(,%fp)	# ook
 8398      89003E01 
 8399 c150 D8FFFFFF 		lea	%s61,-40
 8399      00003D06 
 8400 c158 00000000 		st	%s62,0(%s61,%fp)
 8400      89BD3E11 
 8401 c160 00000000 		or	%s62,4,(0)1
 8401      00043E45 
 8402 c168 00000000 		st2b	%s62,0(,%s23)
 8402      97003E14 
 8403 c170 68FDFFFF 		brlt.l	0,%s18,.L7.62
 8403      92000218 
 8404 c178 98FAFFFF 		br.l	.L7.58
 8404      00000F18 
 8405              		.cfi_endproc
 8406              		.set	.L.8.2auto_size,	0xffffffffffff77b0	# 34896 Bytes
 8408              	.L_FE.8:
 8409 c180 636F6E76 		.string	"conv::sxconv_3_bwd_w\000_c"
 8409      3A3A7378 
 8409      636F6E76 
 8409      5F335F62 
 8409      77645F77 
 8410              	# ============ End  conv::sxconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 8411              		.weak div_floor(int, int)
