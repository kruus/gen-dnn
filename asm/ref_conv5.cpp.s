   1              		.ident "nc++ 1.5.2 (Build 11:19:31 Oct  2 2018)"
   2              		.file "ref_conv5.cpp"
   3              		.file 1 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp"
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
  50              	div_floor(int, int):
  51              		.cfi_startproc
  52 0000 00000000 		st	%fp,0x0(,%sp)
  52      8B000911 
  53              		.cfi_def_cfa_offset	0
  54              		.cfi_offset	9,0
  55 0008 08000000 		st	%lr,0x8(,%sp)
  55      8B000A11 
  56 0010 18000000 		st	%got,0x18(,%sp)
  56      8B000F11 
  57 0018 20000000 		st	%plt,0x20(,%sp)
  57      8B001011 
  58 0020 00000000 		or	%fp,0,%sp
  58      8B000945 
  59              		.cfi_def_cfa_register	9
  60 0028 00FFFFFF 		lea	%s13,.L.1.2auto_size&0xffffffff
  60      00000D06 
  61 0030 00000000 		and	%s13,%s13,(32)0
  61      608D0D44 
  62 0038 FFFFFFFF 		lea.sl	%sp,.L.1.2auto_size>>32(%fp,%s13)
  62      8D898B06 
  63 0040 48000000 		brge.l.t	%sp,%sl,.L0.EoP
  63      888B3518 
  64 0048 18000000 		ld	%s61,0x18(,%tp)
  64      8E003D01 
  65 0050 00000000 		or	%s62,0,%s0
  65      80003E45 
  66 0058 3B010000 		lea	%s63,0x13b
  66      00003F06 
  67 0060 00000000 		shm.l	%s63,0x0(%s61)
  67      BD033F31 
  68 0068 08000000 		shm.l	%sl,0x8(%s61)
  68      BD030831 
  69 0070 10000000 		shm.l	%sp,0x10(%s61)
  69      BD030B31 
  70 0078 00000000 		monc
  70      0000003F 
  71 0080 00000000 		or	%s0,0,%s62
  71      BE000045 
  72              	.L0.EoP:
  73              	# End of prologue codes
  74              	# line 178
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp **** #if 1
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/idiv.hpp ****     return (n/d) - (n%d<0? 1: 0);
  75              		.loc	39 178 0
  76 0088 00000000 		divs.w.sx	%s63,%s0,%s1
  76      81803F7B 
  77 0090 00000000 		muls.w.sx	%s1,%s1,%s63
  77      BF81014B 
  78 0098 00000000 		subs.w.sx	%s1,%s0,%s1
  78      8180015A 
  79 00a0 50000000 		brgt.w	0,%s1,.L0.0
  79      81008118 
  80 00a8 00000000 		or	%s62,0,(0)1
  80      00003E45 
  81 00b0 08000000 		br.l	.L0.1
  81      00000F18 
  82              	.L0.1:
  83 00b8 00000000 		subs.w.sx	%s0,%s63,%s62
  83      BEBF005A 
  84              	# Start of epilogue codes
  85 00c0 00000000 		or	%sp,0,%fp
  85      89000B45 
  86              		.cfi_def_cfa	11,8
  87 00c8 18000000 		ld	%got,0x18(,%sp)
  87      8B000F01 
  88 00d0 20000000 		ld	%plt,0x20(,%sp)
  88      8B001001 
  89 00d8 08000000 		ld	%lr,0x8(,%sp)
  89      8B000A01 
  90 00e0 00000000 		ld	%fp,0x0(,%sp)
  90      8B000901 
  91 00e8 00000000 		b.l	(,%lr)
  91      8A000F19 
  92              	.L0.0:
  93 00f0 00000000 		or	%s62,1,(0)1
  93      00013E45 
  94 00f8 C0FFFFFF 		br.l	.L0.1
  94      00000F18 
  95              		.cfi_endproc
  96              		.set	.L.1.2auto_size,	0xffffffffffffff00	# 256 Bytes
  98              	# ============ End  div_floor(int, int) ============
  99              	# ============ Begin  _INTERNAL_13_ref_conv5_cpp_202f7a29::conv::chk(bool, char const*, char const*, int) ============
 100              		.section .rodata
 101              		.balign 16
 103              	.LP.__string.0:
 104 0000 40       		.byte	64
 105 0001 40       		.byte	64
 106 0002 40       		.byte	64
 107 0003 20       		.byte	32
 108 0004 65       		.byte	101
 109 0005 72       		.byte	114
 110 0006 72       		.byte	114
 111 0007 6F       		.byte	111
 112 0008 72       		.byte	114
 113 0009 3A       		.byte	58
 114 000a 20       		.byte	32
 115 000b 25       		.byte	37
 116 000c 73       		.byte	115
 117 000d 20       		.byte	32
 118 000e 3A       		.byte	58
 119 000f 20       		.byte	32
 120 0010 5B       		.byte	91
 121 0011 25       		.byte	37
 122 0012 73       		.byte	115
 123 0013 3A       		.byte	58
 124 0014 25       		.byte	37
 125 0015 64       		.byte	100
 126 0016 5D       		.byte	93
 127 0017 0A       		.byte	10
 128 0018 00       		.zero	1
 129              		.text
 130              		.balign 16
 131              	# line 50
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /*******************************************************************************
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * Copyright 2017 NEC Laboratories America
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** *
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * Licensed under the Apache License, Version 2.0 (the "License");
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * you may not use this file except in compliance with the License.
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * You may obtain a copy of the License at
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** *
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** *     http://www.apache.org/licenses/LICENSE-2.0
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** *
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * Unless required by applicable law or agreed to in writing, software
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * distributed under the License is distributed on an "AS IS" BASIS,
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * See the License for the specific language governing permissions and
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** * limitations under the License.
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** *******************************************************************************/
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** \file
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * precalc inner kernel loop limits to avoid conditionals */
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #include "conv/conv.hpp"
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #include "idiv.hpp"
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define G  p->g
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define MB p->mb
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define IC p->ic
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define OC p->oc
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define KH p->kh
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define IH p->ih
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define OH p->oh
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define SH p->sh
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define PH p->ph
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define KW p->kw
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define IW p->iw
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define OW p->ow
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define SW p->sw
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define PW p->pw
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** //const int DH = p->dh + 1;
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** //const int DW = p->dw + 1;
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** namespace conv {
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** // BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** extern void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static void chk( bool cond, char const* msg, char const* file, int const lineno ){
 132              		.loc	1 50 0
 134              	_INTERNAL_13_ref_conv5_cpp_202f7a29::conv::chk(bool, char const*, char const*, int):
 135              		.cfi_startproc
 136 0100 00000000 		st	%fp,0x0(,%sp)
 136      8B000911 
 137              		.cfi_def_cfa_offset	0
 138              		.cfi_offset	9,0
 139 0108 08000000 		st	%lr,0x8(,%sp)
 139      8B000A11 
 140 0110 18000000 		st	%got,0x18(,%sp)
 140      8B000F11 
 141 0118 20000000 		st	%plt,0x20(,%sp)
 141      8B001011 
 142 0120 00000000 		or	%fp,0,%sp
 142      8B000945 
 143              		.cfi_def_cfa_register	9
 144 0128 30FEFFFF 		lea	%s13,.L.2.2auto_size&0xffffffff
 144      00000D06 
 145 0130 00000000 		and	%s13,%s13,(32)0
 145      608D0D44 
 146 0138 FFFFFFFF 		lea.sl	%sp,.L.2.2auto_size>>32(%fp,%s13)
 146      8D898B06 
 147 0140 48000000 		brge.l.t	%sp,%sl,.L1.EoP
 147      888B3518 
 148 0148 18000000 		ld	%s61,0x18(,%tp)
 148      8E003D01 
 149 0150 00000000 		or	%s62,0,%s0
 149      80003E45 
 150 0158 3B010000 		lea	%s63,0x13b
 150      00003F06 
 151 0160 00000000 		shm.l	%s63,0x0(%s61)
 151      BD033F31 
 152 0168 08000000 		shm.l	%sl,0x8(%s61)
 152      BD030831 
 153 0170 10000000 		shm.l	%sp,0x10(%s61)
 153      BD030B31 
 154 0178 00000000 		monc
 154      0000003F 
 155 0180 00000000 		or	%s0,0,%s62
 155      BE000045 
 156              	.L1.EoP:
 157              	# End of prologue codes
 158 0188 00000000 		or	%s0,0,%s0
 158      80000045 
 159 0190 40000000 		breq.w	0,%s0,.L1.0
 159      80008418 
 160 0198 08000000 		br.l	.L1.1
 160      00000F18 
 161              	.L1.1:
 162              	# line 52
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 163              		.loc	1 52 0
 164              	# Start of epilogue codes
 165 01a0 00000000 		or	%sp,0,%fp
 165      89000B45 
 166              		.cfi_def_cfa	11,8
 167 01a8 18000000 		ld	%got,0x18(,%sp)
 167      8B000F01 
 168 01b0 20000000 		ld	%plt,0x20(,%sp)
 168      8B001001 
 169 01b8 08000000 		ld	%lr,0x8(,%sp)
 169      8B000A01 
 170 01c0 00000000 		ld	%fp,0x0(,%sp)
 170      8B000901 
 171 01c8 00000000 		b.l	(,%lr)
 171      8A000F19 
 172              	.L1.0:
 173              	# line 51
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
 174              		.loc	1 51 0
 175 01d0 00000000 		lea	%s0,.LP.__string.0@LO
 175      00000006 
 176 01d8 00000000 		and	%s0,%s0,(32)0
 176      60800044 
 177 01e0 00000000 		lea.sl	%s0,.LP.__string.0@HI(,%s0)
 177      80008006 
 178 01e8 B0000000 		st	%s0,176(,%sp)
 178      8B000011 
 179 01f0 B8000000 		st	%s1,184(,%sp)
 179      8B000111 
 180 01f8 C0000000 		st	%s2,192(,%sp)
 180      8B000211 
 181 0200 C8000000 		st	%s3,200(,%sp)
 181      8B000311 
 182 0208 00000000 		lea	%s12,printf@LO
 182      00000C06 
 183 0210 00000000 		and	%s12,%s12,(32)0
 183      608C0C44 
 184 0218 00000000 		lea.sl	%s12,printf@HI(,%s12)
 184      8C008C06 
 185 0220 00000000 		bsic	%lr,(,%s12)	# printf
 185      8C000A08 
 186 0228 00000000 		or	%s0,1,(0)1
 186      00010045 
 187 0230 00000000 		lea	%s12,exit@LO
 187      00000C06 
 188 0238 00000000 		and	%s12,%s12,(32)0
 188      608C0C44 
 189 0240 00000000 		lea.sl	%s12,exit@HI(,%s12)
 189      8C008C06 
 190 0248 00000000 		bsic	%lr,(,%s12)	# exit
 190      8C000A08 
 191 0250 50FFFFFF 		br.l	.L1.1
 191      00000F18 
 192              		.cfi_endproc
 193              		.set	.L.2.2auto_size,	0xfffffffffffffe30	# 464 Bytes
 195              	# ============ End  _INTERNAL_13_ref_conv5_cpp_202f7a29::conv::chk(bool, char const*, char const*, int) ============
 196              	# ============ Begin  conv::refconv_5_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 197              		.data
 198              		.balign 16
 201              	.LP.__13_ref_conv5_cpp_202f7a29.0.__unnamed.0:
 202 0000 76       		.byte	118
 203 0001 6F       		.byte	111
 204 0002 69       		.byte	105
 205 0003 64       		.byte	100
 206 0004 20       		.byte	32
 207 0005 63       		.byte	99
 208 0006 6F       		.byte	111
 209 0007 6E       		.byte	110
 210 0008 76       		.byte	118
 211 0009 3A       		.byte	58
 212 000a 3A       		.byte	58
 213 000b 72       		.byte	114
 214 000c 65       		.byte	101
 215 000d 66       		.byte	102
 216 000e 63       		.byte	99
 217 000f 6F       		.byte	111
 218 0010 6E       		.byte	110
 219 0011 76       		.byte	118
 220 0012 5F       		.byte	95
 221 0013 35       		.byte	53
 222 0014 5F       		.byte	95
 223 0015 66       		.byte	102
 224 0016 77       		.byte	119
 225 0017 64       		.byte	100
 226 0018 28       		.byte	40
 227 0019 63       		.byte	99
 228 001a 6F       		.byte	111
 229 001b 6E       		.byte	110
 230 001c 73       		.byte	115
 231 001d 74       		.byte	116
 232 001e 20       		.byte	32
 233 001f 63       		.byte	99
 234 0020 6F       		.byte	111
 235 0021 6E       		.byte	110
 236 0022 76       		.byte	118
 237 0023 3A       		.byte	58
 238 0024 3A       		.byte	58
 239 0025 70       		.byte	112
 240 0026 72       		.byte	114
 241 0027 62       		.byte	98
 242 0028 5F       		.byte	95
 243 0029 74       		.byte	116
 244 002a 20       		.byte	32
 245 002b 2A       		.byte	42
 246 002c 2C       		.byte	44
 247 002d 20       		.byte	32
 248 002e 64       		.byte	100
 249 002f 6E       		.byte	110
 250 0030 6E       		.byte	110
 251 0031 5F       		.byte	95
 252 0032 6D       		.byte	109
 253 0033 65       		.byte	101
 254 0034 6D       		.byte	109
 255 0035 5F       		.byte	95
 256 0036 74       		.byte	116
 257 0037 20       		.byte	32
 258 0038 26       		.byte	38
 259 0039 2C       		.byte	44
 260 003a 20       		.byte	32
 261 003b 64       		.byte	100
 262 003c 6E       		.byte	110
 263 003d 6E       		.byte	110
 264 003e 5F       		.byte	95
 265 003f 6D       		.byte	109
 266 0040 65       		.byte	101
 267 0041 6D       		.byte	109
 268 0042 5F       		.byte	95
 269 0043 74       		.byte	116
 270 0044 20       		.byte	32
 271 0045 26       		.byte	38
 272 0046 2C       		.byte	44
 273 0047 20       		.byte	32
 274 0048 64       		.byte	100
 275 0049 6E       		.byte	110
 276 004a 6E       		.byte	110
 277 004b 5F       		.byte	95
 278 004c 6D       		.byte	109
 279 004d 65       		.byte	101
 280 004e 6D       		.byte	109
 281 004f 5F       		.byte	95
 282 0050 74       		.byte	116
 283 0051 20       		.byte	32
 284 0052 26       		.byte	38
 285 0053 2C       		.byte	44
 286 0054 20       		.byte	32
 287 0055 64       		.byte	100
 288 0056 6E       		.byte	110
 289 0057 6E       		.byte	110
 290 0058 5F       		.byte	95
 291 0059 6D       		.byte	109
 292 005a 65       		.byte	101
 293 005b 6D       		.byte	109
 294 005c 5F       		.byte	95
 295 005d 74       		.byte	116
 296 005e 20       		.byte	32
 297 005f 26       		.byte	38
 298 0060 29       		.byte	41
 299 0061 00       		.zero	1
 300              		.section .rodata
 301 0019 00000000 		.balign 16
 301      000000
 303              	.LP.__string.1:
 304 0020 70       		.byte	112
 305 0021 2D       		.byte	45
 306 0022 3E       		.byte	62
 307 0023 6B       		.byte	107
 308 0024 68       		.byte	104
 309 0025 20       		.byte	32
 310 0026 3E       		.byte	62
 311 0027 20       		.byte	32
 312 0028 30       		.byte	48
 313 0029 20       		.byte	32
 314 002a 26       		.byte	38
 315 002b 26       		.byte	38
 316 002c 20       		.byte	32
 317 002d 4B       		.byte	75
 318 002e 57       		.byte	87
 319 002f 20       		.byte	32
 320 0030 3E       		.byte	62
 321 0031 20       		.byte	32
 322 0032 30       		.byte	48
 323 0033 00       		.zero	1
 324 0034 00000000 		.balign 8
 326              	.LP.__string.2:
 327 0038 40       		.byte	64
 328 0039 40       		.byte	64
 329 003a 40       		.byte	64
 330 003b 20       		.byte	32
 331 003c 65       		.byte	101
 332 003d 72       		.byte	114
 333 003e 72       		.byte	114
 334 003f 6F       		.byte	111
 335 0040 72       		.byte	114
 336 0041 3A       		.byte	58
 337 0042 20       		.byte	32
 338 0043 25       		.byte	37
 339 0044 73       		.byte	115
 340 0045 20       		.byte	32
 341 0046 3A       		.byte	58
 342 0047 20       		.byte	32
 343 0048 5B       		.byte	91
 344 0049 25       		.byte	37
 345 004a 73       		.byte	115
 346 004b 3A       		.byte	58
 347 004c 25       		.byte	37
 348 004d 64       		.byte	100
 349 004e 5D       		.byte	93
 350 004f 0A       		.byte	10
 351 0050 00       		.zero	1
 352 0051 00000000 		.balign 8
 352      000000
 354              	.LP.__string.3:
 355 0058 70       		.byte	112
 356 0059 2D       		.byte	45
 357 005a 3E       		.byte	62
 358 005b 64       		.byte	100
 359 005c 68       		.byte	104
 360 005d 20       		.byte	32
 361 005e 3E       		.byte	62
 362 005f 3D       		.byte	61
 363 0060 20       		.byte	32
 364 0061 30       		.byte	48
 365 0062 20       		.byte	32
 366 0063 26       		.byte	38
 367 0064 26       		.byte	38
 368 0065 20       		.byte	32
 369 0066 70       		.byte	112
 370 0067 2D       		.byte	45
 371 0068 3E       		.byte	62
 372 0069 64       		.byte	100
 373 006a 77       		.byte	119
 374 006b 20       		.byte	32
 375 006c 3E       		.byte	62
 376 006d 3D       		.byte	61
 377 006e 20       		.byte	32
 378 006f 30       		.byte	48
 379 0070 00       		.zero	1
 380 0071 00000000 		.balign 8
 380      000000
 382              	.LP.__string.4:
 383 0078 40       		.byte	64
 384 0079 40       		.byte	64
 385 007a 40       		.byte	64
 386 007b 20       		.byte	32
 387 007c 65       		.byte	101
 388 007d 72       		.byte	114
 389 007e 72       		.byte	114
 390 007f 6F       		.byte	111
 391 0080 72       		.byte	114
 392 0081 3A       		.byte	58
 393 0082 20       		.byte	32
 394 0083 25       		.byte	37
 395 0084 73       		.byte	115
 396 0085 20       		.byte	32
 397 0086 3A       		.byte	58
 398 0087 20       		.byte	32
 399 0088 5B       		.byte	91
 400 0089 25       		.byte	37
 401 008a 73       		.byte	115
 402 008b 3A       		.byte	58
 403 008c 25       		.byte	37
 404 008d 64       		.byte	100
 405 008e 5D       		.byte	93
 406 008f 0A       		.byte	10
 407 0090 00       		.zero	1
 408 0091 00000000 		.balign 8
 408      000000
 410              	.LP.__string.5:
 411 0098 53       		.byte	83
 412 0099 48       		.byte	72
 413 009a 20       		.byte	32
 414 009b 3E       		.byte	62
 415 009c 3D       		.byte	61
 416 009d 20       		.byte	32
 417 009e 30       		.byte	48
 418 009f 20       		.byte	32
 419 00a0 26       		.byte	38
 420 00a1 26       		.byte	38
 421 00a2 20       		.byte	32
 422 00a3 53       		.byte	83
 423 00a4 57       		.byte	87
 424 00a5 20       		.byte	32
 425 00a6 3E       		.byte	62
 426 00a7 3D       		.byte	61
 427 00a8 20       		.byte	32
 428 00a9 30       		.byte	48
 429 00aa 00       		.zero	1
 430 00ab 00000000 		.balign 8
 430      00
 432              	.LP.__string.6:
 433 00b0 40       		.byte	64
 434 00b1 40       		.byte	64
 435 00b2 40       		.byte	64
 436 00b3 20       		.byte	32
 437 00b4 65       		.byte	101
 438 00b5 72       		.byte	114
 439 00b6 72       		.byte	114
 440 00b7 6F       		.byte	111
 441 00b8 72       		.byte	114
 442 00b9 3A       		.byte	58
 443 00ba 20       		.byte	32
 444 00bb 25       		.byte	37
 445 00bc 73       		.byte	115
 446 00bd 20       		.byte	32
 447 00be 3A       		.byte	58
 448 00bf 20       		.byte	32
 449 00c0 5B       		.byte	91
 450 00c1 25       		.byte	37
 451 00c2 73       		.byte	115
 452 00c3 3A       		.byte	58
 453 00c4 25       		.byte	37
 454 00c5 64       		.byte	100
 455 00c6 5D       		.byte	93
 456 00c7 0A       		.byte	10
 457 00c8 00       		.zero	1
 458              		.text
 459 0258 00000000 		.balign 16
 459      00000000 
 460              	# line 237
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static bool trivial( int const verb, bool const cond, char const* msg,
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                      char const* file, int const lineno ){
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if (verb > verbose && cond){
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         printf("@@@ trivial: %s : [%s:%d]\n", msg, file, lineno); fflush(stdout);
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     return cond;
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** //#define MUST( COND )
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define MUST( COND )    chk(    (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define PRINTF(...)     do{ printf(__VA_ARGS__); fflush(stdout);}while(0)
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define TRIVIAL( COND ) COND
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** //#define TRIVIAL( COND ) trivial(1, (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if defined(NDEBUG)
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define DPRINTF(...)
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define DMUST(...)
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define DPRINTF(...)  do{printf(__VA_ARGS__); fflush(stdout);}while(0)
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #define DMUST(...)   MUST(__VA_ARGS__)
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** //----------------------------
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** greatest common denominator, a,b > 0 */
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static int gcd(int a, int b)
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** {
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (;;)
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     {
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         if (a == 0) return b;
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         b %= a;
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         if (b == 0) return a;
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         a %= b;
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** lowest common multiple, a,b > 0 */
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static int lcm(int a, int b)
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** {
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     int temp = gcd(a, b);
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     return temp ? (a / temp * b) : 0;
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** Solve for integers j, k and g=gcd(a,b) such that ja + ky = g,
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * where a,b are integer constants.
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * This is a linear equation in integers, and is solved
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * via the extended Euclid algorithm.
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  */
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static void inline extendedEuclid( int& k, int a, int& j, int b, int& g)
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** {
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int x = 1, y = 0;
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int xLast = 0, yLast = 1;
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int q, r, m, n;
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   while (a != 0) 
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   {
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     q = b / a;
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     r = b % a;
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     m = xLast - q * x;
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     n = yLast - q * y;
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     xLast = x; 
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     yLast = y;
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     x = m; 
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     y = n;
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     b = a; 
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     a = r;
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   g = b;
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   k = xLast;
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   j = yLast;
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** hoist `A+iB in range [C,D)` condition out of a loop for i in [imin,imax].
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * When 
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * Original:
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \code
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * for(i=imin; i<imax; ++i){       // original loop
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *   if( ApiB < c || ApiB > d ) continue;
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *   // Loop Body
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * }
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \endcode
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * Transformed:
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \code
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * int const ibeg, iend;
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * for(i=ibeg; i<iend; ++i){       // original loop
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *   int const ApiB = a + i*b;
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *   // GONE: if( ApiB < c || ApiB > d ) continue;
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *   // Loop Body
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * }
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \endcode
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \pre \c b > 0, (c, d?)
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  */
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static inline void hoist_ApiB_in( int& beg, int& end,
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         const int imin, const int imax,
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         const int a, const int b, const int c, const int d)
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** {
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( b > 0 );
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // int i*B < A    iff    i < (A    )/B
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // int i*B > A    iff    i > (A+B-1)/A
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // A+iB >= c ... iB >= c-A  ... i >= (c-A + B-1 )/B
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 1
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     beg = div_floor( c-a+b-1, b );
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     beg = c-a + b-1;
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( beg >= 0 ){
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         beg /= b;
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     } else {
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         int const fmul=(-beg + b)/b;
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         RT_ASSERT( beg + fmul*b >= 0 );
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         beg = (beg + fmul*b) / b - fmul;
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), beg=%d? f+c-a+b-1=%d\n",
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //        imin,imax, a,b, c,d, beg, f+c-a+b-1);
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( a + (beg-1)*b < c );
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( a + (beg  )*b >= c );
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( beg < imin ) beg = imin;
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // A+iB < d ... iB < d-A    ... i < (d-A) / B
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 1
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     end = div_floor( d-a+b-1, b );
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     end = d-a +b-1;
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( end >= 0 ){
 179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         end /= b;
 180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     } else {
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         int const fmul=(-end + b)/b;
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         RT_ASSERT( end + fmul*b >= 0 );
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         end = (end + fmul*b) / b - fmul;
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), end=%d? f+d-a=%d\n",
 187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //        imin,imax, a,b, c,d, end, f+d-a);
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( a + (end-1)*b < d );
 189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( a + (end  )*b >= d );
 190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( end > imax ) end = imax;
 191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** Integer \c i so A-iB is <em>just below</em> \c target.
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \pre \c B>0 (unchecked). */
 195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static inline int AmiB_lt_target( const int a, const int b, const int target)
 196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** {
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     int ibelow = a-target + b;
 198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // XXX use idiv.hpp here too
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( ibelow >= 0 ){
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         ibelow /= b;
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //ibelow = div_floor( ibelow, b );
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     } else {
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         int const fmul=(-ibelow + b)/b;
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //RT_ASSERT( ibelow + fmul*b >= 0 );
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //RT_ASSERT( fmul == div_floor( -ibelow, b )+1 );
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         ibelow = (ibelow + fmul                    *b) / b - fmul; // orig
 207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //ibelow = (ibelow + (div_floor(-ibelow,b)+1)*b) / b - (div_floor(-ibelow,b)+1);
 208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //ibelow = div_floor( ibelow, b );
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( a - (ibelow-1)*b >= target );
 213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( a - (ibelow  )*b <  target );
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     return ibelow;
 215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** Get range if \c i so A-iB is in [c,d), and then further
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * restrict to range [imin,imax).  Note that \c -B means as \c i
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * increases, we move from \c d-1 downwards to \c c. */
 219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static inline void hoist_AmiB_in( int& beg, int& end,
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         const int imin, const int imax,
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         const int a, const int b, const int c, const int d)
 222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** {
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( b > 0 );
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     beg = AmiB_lt_target( a, b, d );
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //RT_ASSERT( beg == div_floor( a-d+b, b) );
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //beg = div_floor( a-d+b, b); // possibly slower ?? do I have a cmov here? no!
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //beg = div_floor( a-d, b) + 1; // possibly slower ?? do I have a cmov here? no!
 228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( beg < imin ) beg = imin;
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     end = AmiB_lt_target( a, b, c );
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //RT_ASSERT( end == div_floor( a-c+b, b) );
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //end = div_floor( a-c+b, b);
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     //end = div_floor( a-c, b) + 1;
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( end > imax ) end = imax;
 235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** void refconv_5_fwd(const prb_t *p, dnn_mem_t &src_m,
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
 461              		.loc	1 237 0
 462              		.globl	conv::refconv_5_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 464              	conv::refconv_5_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 465              		.cfi_startproc
 466 0260 00000000 		st	%fp,0x0(,%sp)
 466      8B000911 
 467              		.cfi_def_cfa_offset	0
 468              		.cfi_offset	9,0
 469 0268 08000000 		st	%lr,0x8(,%sp)
 469      8B000A11 
 470 0270 18000000 		st	%got,0x18(,%sp)
 470      8B000F11 
 471 0278 20000000 		st	%plt,0x20(,%sp)
 471      8B001011 
 472 0280 00000000 		or	%fp,0,%sp
 472      8B000945 
 473              		.cfi_def_cfa_register	9
 474 0288 30000000 		st	%s18,48(,%fp)
 474      89001211 
 475 0290 38000000 		st	%s19,56(,%fp)
 475      89001311 
 476 0298 40000000 		st	%s20,64(,%fp)
 476      89001411 
 477 02a0 48000000 		st	%s21,72(,%fp)
 477      89001511 
 478 02a8 50000000 		st	%s22,80(,%fp)
 478      89001611 
 479 02b0 58000000 		st	%s23,88(,%fp)
 479      89001711 
 480 02b8 60000000 		st	%s24,96(,%fp)
 480      89001811 
 481 02c0 68000000 		st	%s25,104(,%fp)
 481      89001911 
 482 02c8 70000000 		st	%s26,112(,%fp)
 482      89001A11 
 483 02d0 78000000 		st	%s27,120(,%fp)
 483      89001B11 
 484 02d8 80000000 		st	%s28,128(,%fp)
 484      89001C11 
 485 02e0 88000000 		st	%s29,136(,%fp)
 485      89001D11 
 486 02e8 90000000 		st	%s30,144(,%fp)
 486      89001E11 
 487 02f0 98000000 		st	%s31,152(,%fp)
 487      89001F11 
 488 02f8 A0000000 		st	%s32,160(,%fp)
 488      89002011 
 489 0300 A8000000 		st	%s33,168(,%fp)
 489      89002111 
 490 0308 30FAFFFF 		lea	%s13,.L.3.2auto_size&0xffffffff
 490      00000D06 
 491 0310 00000000 		and	%s13,%s13,(32)0
 491      608D0D44 
 492 0318 FFFFFFFF 		lea.sl	%sp,.L.3.2auto_size>>32(%fp,%s13)
 492      8D898B06 
 493 0320 48000000 		brge.l.t	%sp,%sl,.L2.EoP
 493      888B3518 
 494 0328 18000000 		ld	%s61,0x18(,%tp)
 494      8E003D01 
 495 0330 00000000 		or	%s62,0,%s0
 495      80003E45 
 496 0338 3B010000 		lea	%s63,0x13b
 496      00003F06 
 497 0340 00000000 		shm.l	%s63,0x0(%s61)
 497      BD033F31 
 498 0348 08000000 		shm.l	%sl,0x8(%s61)
 498      BD030831 
 499 0350 10000000 		shm.l	%sp,0x10(%s61)
 499      BD030B31 
 500 0358 00000000 		monc
 500      0000003F 
 501 0360 00000000 		or	%s0,0,%s62
 501      BE000045 
 502              	.L2.EoP:
 503              	# End of prologue codes
 504              	# line 238
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   MUST( p->kh > 0 && KW > 0 );
 505              		.loc	1 238 0
 506 0368 20000000 		ldl.sx	%s18,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 506      80001203 
 507 0370 68160000 		brlt.w	0,%s18,.L2.0
 507      92008218 
 508              	.L2.1:
 509 0378 00000000 		or	%s63,0,(0)1
 509      00003F45 
 510 0380 00000000 		or	%s60,0,%s0
 510      80003C45 
 511 0388 D0150000 		br.l	.L2.2
 511      00000F18 
 512              	.L2.3:
 513 0390 A0FDFFFF 		st	%s60,-608(,%fp)	# spill 
 513      89003C11 
 514 0398 98FDFFFF 		st	%s1,-616(,%fp)	# spill 
 514      89000111 
 515 03a0 90FDFFFF 		st	%s2,-624(,%fp)	# spill 
 515      89000211 
 516 03a8 88FDFFFF 		st	%s3,-632(,%fp)	# spill 
 516      89000311 
 517 03b0 80FDFFFF 		st	%s4,-640(,%fp)	# spill 
 517      89000411 
 518              	# line 51
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
 519              		.loc	1 51 0
 520 03b8 00000000 		lea	%s0,.LP.__string.2@LO
 520      00000006 
 521 03c0 00000000 		and	%s0,%s0,(32)0
 521      60800044 
 522 03c8 00000000 		lea.sl	%s0,.LP.__string.2@HI(,%s0)
 522      80008006 
 523 03d0 00000000 		or	%s2,0,%s61
 523      BD000245 
 524 03d8 B0000000 		st	%s0,176(,%sp)
 524      8B000011 
 525 03e0 B8000000 		st	%s62,184(,%sp)
 525      8B003E11 
 526 03e8 C0000000 		st	%s61,192(,%sp)
 526      8B003D11 
 527 03f0 EE000000 		lea	%s3,238
 527      00000306 
 528 03f8 00000000 		or	%s1,0,%s62
 528      BE000145 
 529 0400 C8000000 		st	%s3,200(,%sp)
 529      8B000311 
 530 0408 00000000 		lea	%s12,printf@LO
 530      00000C06 
 531 0410 00000000 		and	%s12,%s12,(32)0
 531      608C0C44 
 532 0418 00000000 		lea.sl	%s12,printf@HI(,%s12)
 532      8C008C06 
 533 0420 00000000 		bsic	%lr,(,%s12)	# printf
 533      8C000A08 
 534 0428 00000000 		or	%s0,1,(0)1
 534      00010045 
 535 0430 00000000 		lea	%s12,exit@LO
 535      00000C06 
 536 0438 00000000 		and	%s12,%s12,(32)0
 536      608C0C44 
 537 0440 00000000 		lea.sl	%s12,exit@HI(,%s12)
 537      8C008C06 
 538 0448 00000000 		bsic	%lr,(,%s12)	# exit
 538      8C000A08 
 539 0450 A0FDFFFF 		ld	%s60,-608(,%fp)	# restore 
 539      89003C01 
 540 0458 98FDFFFF 		ld	%s1,-616(,%fp)	# restore 
 540      89000101 
 541 0460 90FDFFFF 		ld	%s2,-624(,%fp)	# restore 
 541      89000201 
 542 0468 88FDFFFF 		ld	%s3,-632(,%fp)	# restore 
 542      89000301 
 543 0470 80FDFFFF 		ld	%s4,-640(,%fp)	# restore 
 543      89000401 
 544 0478 C8140000 		br.l	.L2.4
 544      00000F18 
 545              	.L2.5:
 546              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 547              		.loc	1 239 0
 548 0480 00000000 		or	%s63,0,(0)1
 548      00003F45 
 549 0488 28140000 		br.l	.L2.6
 549      00000F18 
 550              	.L2.7:
 551 0490 A0FDFFFF 		st	%s60,-608(,%fp)	# spill 
 551      89003C11 
 552 0498 98FDFFFF 		st	%s1,-616(,%fp)	# spill 
 552      89000111 
 553 04a0 90FDFFFF 		st	%s2,-624(,%fp)	# spill 
 553      89000211 
 554 04a8 88FDFFFF 		st	%s3,-632(,%fp)	# spill 
 554      89000311 
 555 04b0 80FDFFFF 		st	%s4,-640(,%fp)	# spill 
 555      89000411 
 556              	# line 51
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 557              		.loc	1 51 0
 558 04b8 00000000 		lea	%s0,.LP.__string.4@LO
 558      00000006 
 559 04c0 00000000 		and	%s0,%s0,(32)0
 559      60800044 
 560 04c8 00000000 		lea.sl	%s0,.LP.__string.4@HI(,%s0)
 560      80008006 
 561 04d0 00000000 		or	%s2,0,%s61
 561      BD000245 
 562 04d8 B0000000 		st	%s0,176(,%sp)
 562      8B000011 
 563 04e0 B8000000 		st	%s62,184(,%sp)
 563      8B003E11 
 564 04e8 C0000000 		st	%s61,192(,%sp)
 564      8B003D11 
 565 04f0 EF000000 		lea	%s3,239
 565      00000306 
 566 04f8 00000000 		or	%s1,0,%s62
 566      BE000145 
 567 0500 C8000000 		st	%s3,200(,%sp)
 567      8B000311 
 568 0508 00000000 		lea	%s12,printf@LO
 568      00000C06 
 569 0510 00000000 		and	%s12,%s12,(32)0
 569      608C0C44 
 570 0518 00000000 		lea.sl	%s12,printf@HI(,%s12)
 570      8C008C06 
 571 0520 00000000 		bsic	%lr,(,%s12)	# printf
 571      8C000A08 
 572 0528 00000000 		or	%s0,1,(0)1
 572      00010045 
 573 0530 00000000 		lea	%s12,exit@LO
 573      00000C06 
 574 0538 00000000 		and	%s12,%s12,(32)0
 574      608C0C44 
 575 0540 00000000 		lea.sl	%s12,exit@HI(,%s12)
 575      8C008C06 
 576 0548 00000000 		bsic	%lr,(,%s12)	# exit
 576      8C000A08 
 577 0550 A0FDFFFF 		ld	%s60,-608(,%fp)	# restore 
 577      89003C01 
 578 0558 98FDFFFF 		ld	%s1,-616(,%fp)	# restore 
 578      89000101 
 579 0560 90FDFFFF 		ld	%s2,-624(,%fp)	# restore 
 579      89000201 
 580 0568 88FDFFFF 		ld	%s3,-632(,%fp)	# restore 
 580      89000301 
 581 0570 80FDFFFF 		ld	%s4,-640(,%fp)	# restore 
 581      89000401 
 582 0578 20130000 		br.l	.L2.8
 582      00000F18 
 583              	.L2.9:
 584              	# line 240
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   MUST( SH >= 0 && SW >= 0 );
 585              		.loc	1 240 0
 586 0580 00000000 		or	%s63,0,(0)1
 586      00003F45 
 587 0588 80120000 		br.l	.L2.10
 587      00000F18 
 588              	.L2.11:
 589 0590 A0FDFFFF 		st	%s60,-608(,%fp)	# spill 
 589      89003C11 
 590 0598 98FDFFFF 		st	%s1,-616(,%fp)	# spill 
 590      89000111 
 591 05a0 90FDFFFF 		st	%s2,-624(,%fp)	# spill 
 591      89000211 
 592 05a8 88FDFFFF 		st	%s3,-632(,%fp)	# spill 
 592      89000311 
 593 05b0 80FDFFFF 		st	%s4,-640(,%fp)	# spill 
 593      89000411 
 594              	# line 51
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 595              		.loc	1 51 0
 596 05b8 00000000 		lea	%s0,.LP.__string.6@LO
 596      00000006 
 597 05c0 00000000 		and	%s0,%s0,(32)0
 597      60800044 
 598 05c8 00000000 		lea.sl	%s0,.LP.__string.6@HI(,%s0)
 598      80008006 
 599 05d0 00000000 		or	%s2,0,%s61
 599      BD000245 
 600 05d8 B0000000 		st	%s0,176(,%sp)
 600      8B000011 
 601 05e0 B8000000 		st	%s62,184(,%sp)
 601      8B003E11 
 602 05e8 C0000000 		st	%s61,192(,%sp)
 602      8B003D11 
 603 05f0 F0000000 		lea	%s3,240
 603      00000306 
 604 05f8 00000000 		or	%s1,0,%s62
 604      BE000145 
 605 0600 C8000000 		st	%s3,200(,%sp)
 605      8B000311 
 606 0608 00000000 		lea	%s12,printf@LO
 606      00000C06 
 607 0610 00000000 		and	%s12,%s12,(32)0
 607      608C0C44 
 608 0618 00000000 		lea.sl	%s12,printf@HI(,%s12)
 608      8C008C06 
 609 0620 00000000 		bsic	%lr,(,%s12)	# printf
 609      8C000A08 
 610 0628 00000000 		or	%s0,1,(0)1
 610      00010045 
 611 0630 00000000 		lea	%s12,exit@LO
 611      00000C06 
 612 0638 00000000 		and	%s12,%s12,(32)0
 612      608C0C44 
 613 0640 00000000 		lea.sl	%s12,exit@HI(,%s12)
 613      8C008C06 
 614 0648 00000000 		bsic	%lr,(,%s12)	# exit
 614      8C000A08 
 615 0650 A0FDFFFF 		ld	%s60,-608(,%fp)	# restore 
 615      89003C01 
 616 0658 98FDFFFF 		ld	%s1,-616(,%fp)	# restore 
 616      89000101 
 617 0660 90FDFFFF 		ld	%s2,-624(,%fp)	# restore 
 617      89000201 
 618 0668 88FDFFFF 		ld	%s3,-632(,%fp)	# restore 
 618      89000301 
 619 0670 80FDFFFF 		ld	%s4,-640(,%fp)	# restore 
 619      89000401 
 620 0678 E8100000 		br.l	.L2.12
 620      00000F18 
 621              	.L2.13:
 622              	# line 310
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0 // ref_conv3 starting point
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #ifndef __ve
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   OMP(parallel for collapse(5))//;
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   for (int g = 0; g < G; ++g) {
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t bia_off = bia_off_f(p, g, oc);
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             float &d = ((float*)dst_m)[dst_off];
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0.f;
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_beg, kh_end, kw_beg, kw_end;
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // trick to easy calc of kh, kw loop limits is that division must
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // round more consistently.  'C' round-to-zero is not so useful!
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_beg = div_floor( 0     - (oh * SH - PH) + p->dh, (p->dh+1) );
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_end = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_beg < 0     ) kh_beg = 0;
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_end > p->kh ) kh_end = p->kh;
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_beg = div_floor( 0     - (ow * SW - PW) + p->dw, (p->dw+1) );
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_end = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_beg < 0     ) kw_beg = 0;
 267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_end > KW ) kw_end = KW;
 268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_beg < kw_end && kh_beg < kh_end ) {
 270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ic = 0; ic < IC/G; ++ic) {
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kh = kh_beg; kh < kh_end; ++kh) {
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   const int ih = oh * SH - PH + kh * (p->dh + 1);
 274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   for (int kw = kw_beg; kw < kw_end; ++kw) {
 275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (p->merge == RELU && d < 0.f)
 284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 d = 0.f;
 285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 1
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //hoist_ApiB_in( kh_beg, kh_end,
 292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //        /*i  in   */ 0, p->kh,
 293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //        /*ih=A+iB */ (oh * SH - PH), (p->dh + 1),
 294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //        /*ih in   */ 0, IH);
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //hoist_ApiB_in( kw_beg, kw_end,
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //        /*i  in   */ 0, KW,
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //        /*iw=A+iB */ (ow * SW - PW), (p->dw + 1),
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //        /*iw in   */ 0, IW);
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int const OHs_EgeK = IH+PH+p->dh - p->kh*(p->dh+1); // fully const!
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int const OWs_EgeK = IW+PW+p->dw - KW*(p->dw+1); // fully const!
 301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   OMP(parallel for collapse(5))//;
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   for (int g = 0; g < G; ++g) {
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t bia_off = bia_off_f(p, g, oc);
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             float &d = ((float*)dst_m)[dst_off];
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0.f;
 623              		.loc	1 310 0
 624 0680 00000000 		or	%s62,0,(0)1
 624      00003E45 
 625 0688 00000000 		or	%s1,0,%s63
 625      BF000145 
 626 0690 00000000 		stu	%s62,0(,%s57)	# *(d)
 626      B9003E12 
 627 0698 B80A0000 		br.l	.L2.14
 627      00000F18 
 628              	.L2.15:
 629              	# line 418
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0 // CODE TRANSFORM
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_beg, kh_end, kw_beg, kw_end;
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // trick to easy calc of kh, kw loop limits is that division must
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // round more consistently.  'C' round-to-zero is not so useful!
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_beg = div_floor( 0     - (oh * SH - PH) + p->dh, (p->dh+1) );
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_end = div_floor( IH - (oh * SH - PH) + p->dh, (p->dh+1) );
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // E >= (I+P-o*S +D) / (D+1) , if +ve
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // E >= K?   (I+P+D-o*S) / (D+1) >= K     E~kh_end o~oh K~p->kh
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //       I+P+D - K*(D+1) >= o*S
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //       o <= (I+P+D - K*(D+1)) / S   --> OH_EgeK
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int OH_EgeK = (IH+PH+p->dh - p->kh*(p->dh+1)) / SH;
 324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_end >= p->kh ) RT_ASSERT( oh <= OH_EgeK ); // YES
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_end <  p->kh ) RT_ASSERT( oh >  OH_EgeK ); // YES
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int koh = PH + p->dh - oh*SH;
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( oh <= OH_EgeK ) RT_ASSERT( koh+IH >= 0 ); // YES
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( oh <= OH_EgeK ) RT_ASSERT( kh_end >= p->kh );
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // E>=K --> I+P+D-o*S - K*(D+1) >= 0
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //          I + koh   - K*(D+1) >= 0
 331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( IH + koh >= p->kh * (p->dh+1) ) RT_ASSERT( kh_end >= p->kh );
 332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int hKDmi = p->kh*(p->dh+1) - IH;
 333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( koh >= hKDmi ) RT_ASSERT( kh_end >= p->kh );
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // better...
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // E>=K --> o*S <= I+P+D - K(D+1)  == OHs_EgeK
 336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //int const OHs_EgeK = IH+PH+p->dh - p->kh*(p->dh+1); // fully const!
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             RT_ASSERT( (kh_end >= p->kh) == (oh*SH <= OHs_EgeK) );
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // NO if( koh+IH >= 0 ) RT_ASSERT( kh_end >= p->kh );
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // B >= (P+D - o*S) / (D+1), if +ve       B~kh_beg o~oh
 342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //                           (NOT for B==0 : -ve rounding up!
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // B >= 1?   (P+D-o*S) / (D+1) >= 1
 344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //       P+D - o*S >= D+1
 345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //       o <= (P-1)/S, but for rounding... o<=(P+S-1)/S - 1 !!!
 346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //print(0,"B oh=%-3d kh_beg0 = %d o*S=%d   PSD=%d,%d,%d, (P+D)/S=%d (P-1)/S=%d\n",
 347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //        oh, kh_beg, oh*SH, PH,SH,p->dh,
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //        (PH+p->dh)/SH, (PH-1)/SH);
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int oh_Bge1 = (PH +SH - 1) / SH - 1;
 350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_beg >= 1 ) RT_ASSERT( oh <= oh_Bge1 );
 351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_beg <  1 ) RT_ASSERT( oh >  oh_Bge1 );
 352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // avoid the division, so inequalities are exact again...
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // oh > oh_Bge1   --> oh*SH > (PH-1)
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             RT_ASSERT( (kh_beg < 1) == (oh*SH > PH-1) );
 355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // now what about total elision?
 356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // -- does not seem to be any shorter way than kh_beg>=kh_end
 357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_beg < 0     ) kh_beg = 0;
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_end > p->kh ) kh_end = p->kh;
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // simpler limit case tests:
 361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( koh < 0 ) RT_ASSERT( kh_beg == 0 );
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if( koh +IH >= 0 ) RT_ASSERT( kh_end == p->kh );
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // recalc
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int kh_beg2 = (oh*SH > (PH-1) ? 0
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     : (PH +p->dh - oh*SH) / (p->dh+1));
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int kh_end2 = (oh*SH <= OHs_EgeK ? p->kh
 368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     : (PH +p->dh - oh*SH +IH) / (p->dh+1));
 369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             RT_ASSERT( kh_beg2 == kh_beg );
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             RT_ASSERT( kh_end2 == kh_end || kh_end <= 0 ); // -ve kh_end --> don't care
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 0 // FWD 2.44
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int ohsh = oh*SH;
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int toph = PH + p->dh - ohsh;
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             const int Dh = p->dh+1;
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_beg = (ohsh >= PH    ? 0        : toph);
 377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             toph += IH;
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_end = (ohsh <= OHs_EgeK ? p->kh*Dh : toph );
 379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_beg /= Dh;
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_end /= Dh;
 381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 0 // FWD 2.46x
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             {
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 const int Dh = p->dh+1;
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 register int toph = PH + p->dh - ohsh;
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 int kbh  = toph / Dh;
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 int keh  = (toph + IH) / Dh;
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //kh_beg = (ohsh > (PH-1) ? 0     : toph / Dh);
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 kh_beg = (ohsh >= PH    ? 0     : kbh);
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 toph += IH;
 390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 kh_end = (ohsh <= OHs_EgeK ? p->kh : keh);
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //kh_beg = 0; kh_end = p->kh;
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 1
 394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int os = oh*SH;
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int top = PH + p->dh - os;
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_beg = (os >= PH    ? 0     : top/(p->dh+1));
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_end = (os <= OHs_EgeK ? p->kh : (top+IH)/(p->dh+1) );
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_beg = div_floor( 0     - (ow * SW - PW) + p->dw, (p->dw+1) );
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_end = div_floor( IW - (ow * SW - PW) + p->dw, (p->dw+1) );
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_beg < 0     ) kw_beg = 0;
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_end > KW ) kw_end = KW;
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // given last impl for kh_beg/end ...
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             os = ow*SW;
 408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             top = PW + p->dw - os;
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_beg = (os >= PW    ? 0     : top/(p->dw+1));
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_end = (os <= OWs_EgeK ? KW : (top+IW)/(p->dw+1) );
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // CONCLUSION: div_floor is pretty optimized, at least for Intel,
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //   so the simpler looking code for limit conditions is no faster.
 414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else // RECAP of "simpler" [but not faster] formulas
 415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             // These MIGHT be faster if idiv becomes a slow operation.
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int os = oh*SH;
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int top = PH + p->dh - os;
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kh_beg = (os >= PH    ? 0     : top/(p->dh+1));
 630              		.loc	1 418 0
 631 06a0 00000000 		divs.w.sx	%s2,%s61,%s55
 631      B7BD027B 
 632 06a8 880A0000 		br.l	.L2.16
 632      00000F18 
 633              	.L2.17:
 634              	# line 419
 419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kh_end = (os <= OHs_EgeK ? p->kh : (top+IH)/(p->dh+1) );
 635              		.loc	1 419 0
 636 06b0 00000000 		divs.w.sx	%s3,%s54,%s55
 636      B7B6037B 
 637 06b8 580A0000 		br.l	.L2.18
 637      00000F18 
 638              	.L2.19:
 639              	# line 422
 420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             os = ow*SW;
 421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             top = PW + p->dw - os;
 422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kw_beg = (os >= PW    ? 0     : top/(p->dw+1));
 640              		.loc	1 422 0
 641 06c0 00000000 		divs.w.sx	%s21,%s51,%s52
 641      B4B3157B 
 642 06c8 280A0000 		br.l	.L2.20
 642      00000F18 
 643              	.L2.21:
 644              	# line 423
 423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kw_end = (os <= OWs_EgeK ? KW : (top+IW)/(p->dw+1) );
 645              		.loc	1 423 0
 646 06d0 00000000 		divs.w.sx	%s22,%s53,%s52
 646      B4B5167B 
 647 06d8 00000000 		or	%s63,0,%s1
 647      81003F45 
 648 06e0 E8090000 		br.l	.L2.22
 648      00000F18 
 649              	.L2.23:
 650 06e8 00000000 		smvl	%s13
 650      00000D2E 
 651 06f0 00000000 		lvl	%s13
 651      008D00BF 
 652 06f8 003C003B 		vor	%v59,(0)1,%v60
 652      000020C5 
 653 0700 10050000 		br.l	.L2.24
 653      00000F18 
 654              	.L2.25:
 655              	# line 431
 424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_beg < kw_end && kh_beg < kh_end ) {
 427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ic = 0; ic < IC/G; ++ic) {
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kh = kh_beg; kh < kh_end; ++kh) {
 430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   const int ih = oh * SH - PH + kh * (p->dh + 1);
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   for (int kw = kw_beg; kw < kw_end; ++kw) {
 656              		.loc	1 431 0
 657 0708 80000000 		mins.w.sx	%s60,%s56,%s60
 657      BCB83C78 
 658 0710 88050000 		br.l	.L2.26
 658      00000F18 
 659              	.L2.27:
 660              	# line 450
 432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (p->merge == RELU && d < 0.f)
 441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 d = 0.f;
 442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #error "please select one"
 449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 661              		.loc	1 450 0
 662              	# Start of epilogue codes
 663 0718 30000000 		ld	%s18,48(,%fp)
 663      89001201 
 664 0720 38000000 		ld	%s19,56(,%fp)
 664      89001301 
 665 0728 40000000 		ld	%s20,64(,%fp)
 665      89001401 
 666 0730 48000000 		ld	%s21,72(,%fp)
 666      89001501 
 667 0738 50000000 		ld	%s22,80(,%fp)
 667      89001601 
 668 0740 58000000 		ld	%s23,88(,%fp)
 668      89001701 
 669 0748 60000000 		ld	%s24,96(,%fp)
 669      89001801 
 670 0750 68000000 		ld	%s25,104(,%fp)
 670      89001901 
 671 0758 70000000 		ld	%s26,112(,%fp)
 671      89001A01 
 672 0760 78000000 		ld	%s27,120(,%fp)
 672      89001B01 
 673 0768 80000000 		ld	%s28,128(,%fp)
 673      89001C01 
 674 0770 88000000 		ld	%s29,136(,%fp)
 674      89001D01 
 675 0778 90000000 		ld	%s30,144(,%fp)
 675      89001E01 
 676 0780 98000000 		ld	%s31,152(,%fp)
 676      89001F01 
 677 0788 A0000000 		ld	%s32,160(,%fp)
 677      89002001 
 678 0790 A8000000 		ld	%s33,168(,%fp)
 678      89002101 
 679 0798 00000000 		or	%sp,0,%fp
 679      89000B45 
 680              		.cfi_def_cfa	11,8
 681 07a0 18000000 		ld	%got,0x18(,%sp)
 681      8B000F01 
 682 07a8 20000000 		ld	%plt,0x20(,%sp)
 682      8B001001 
 683 07b0 08000000 		ld	%lr,0x8(,%sp)
 683      8B000A01 
 684 07b8 00000000 		ld	%fp,0x0(,%sp)
 684      8B000901 
 685 07c0 00000000 		b.l	(,%lr)
 685      8A000F19 
 686              	.L2.28:
 687              	# line 302
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 688              		.loc	1 302 0
 689 07c8 00000000 		adds.w.sx	%s63,1,%s63
 689      BF013F4A 
 690 07d0 00000000 		adds.w.sx	%s62,%s61,%s62
 690      BEBD3E4A 
 691 07d8 00000000 		adds.l	%s53,%s57,%s53
 691      B5B93559 
 692 07e0 00000000 		adds.w.sx	%s55,%s46,%s55
 692      B7AE374A 
 693 07e8 00000000 		adds.l	%s5,%s34,%s5
 693      85A20559 
 694 07f0 A80C0000 		brgt.w	0,%s63,.L2.29
 694      BF008118 
 695 07f8 20FFFFFF 		br.l	.L2.27
 695      00000F18 
 696              	.L2.30:
 697 0800 48FEFFFF 		ld	%s63,-440(,%fp)	# restore 
 697      89003F01 
 698 0808 00000000 		or	%s25,0,%s55
 698      B7001945 
 699 0810 30FEFFFF 		ld	%s53,-464(,%fp)	# restore 
 699      89003501 
 700 0818 00000000 		or	%s55,0,%s4
 700      84003745 
 701 0820 50FEFFFF 		ld	%s46,-432(,%fp)	# restore 
 701      89002E01 
 702 0828 40FEFFFF 		ld	%s34,-448(,%fp)	# restore 
 702      89002201 
 703 0830 38FEFFFF 		ld	%s5,-456(,%fp)	# restore 
 703      89000501 
 704 0838 58FEFFFF 		ld	%s20,-424(,%fp)	# restore 
 704      89001401 
 705 0840 28FEFFFF 		ld	%s54,-472(,%fp)	# restore 
 705      89003601 
 706 0848 80FFFFFF 		br.l	.L2.28
 706      00000F18 
 707              	.L2.31:
 708              	# line 303
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 709              		.loc	1 303 0
 710 0850 00000000 		adds.w.sx	%s63,1,%s63
 710      BF013F4A 
 711 0858 00000000 		adds.l	%s46,%s57,%s46
 711      AEB92E59 
 712 0860 00000000 		adds.l	%s34,%s39,%s34
 712      A2A72259 
 713 0868 900B0000 		brgt.w	0,%s63,.L2.32
 713      BF008118 
 714 0870 90FFFFFF 		br.l	.L2.30
 714      00000F18 
 715              	.L2.33:
 716 0878 88FEFFFF 		ld	%s63,-376(,%fp)	# restore 
 716      89003F01 
 717 0880 78FEFFFF 		ld	%s57,-392(,%fp)	# restore 
 717      89003901 
 718 0888 68FEFFFF 		ld	%s46,-408(,%fp)	# restore 
 718      89002E01 
 719 0890 80FEFFFF 		ld	%s39,-384(,%fp)	# restore 
 719      89002701 
 720 0898 70FEFFFF 		ld	%s34,-400(,%fp)	# restore 
 720      89002201 
 721 08a0 60FEFFFF 		ld	%s61,-416(,%fp)	# restore 
 721      89003D01 
 722 08a8 90FEFFFF 		ld	%s20,-368(,%fp)	# restore 
 722      89001401 
 723 08b0 A0FFFFFF 		br.l	.L2.31
 723      00000F18 
 724              	.L2.34:
 725              	# line 304
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 726              		.loc	1 304 0
 727 08b8 00000000 		adds.w.sx	%s63,1,%s63
 727      BF013F4A 
 728 08c0 00000000 		adds.w.sx	%s53,1,%s53
 728      B501354A 
 729 08c8 A80A0000 		brgt.w	0,%s63,.L2.35
 729      BF008118 
 730 08d0 A8FFFFFF 		br.l	.L2.33
 730      00000F18 
 731              	.L2.36:
 732 08d8 C8FEFFFF 		ld	%s63,-312(,%fp)	# restore 
 732      89003F01 
 733 08e0 C0FEFFFF 		ld	%s53,-320(,%fp)	# restore 
 733      89003501 
 734 08e8 D0FEFFFF 		ld	%s19,-304(,%fp)	# restore 
 734      89001301 
 735 08f0 98FEFFFF 		ld	%s26,-360(,%fp)	# restore 
 735      89001A01 
 736 08f8 B8FEFFFF 		ld	%s51,-328(,%fp)	# restore 
 736      89003301 
 737 0900 B0FEFFFF 		ld	%s49,-336(,%fp)	# restore 
 737      89003101 
 738 0908 A8FEFFFF 		ld	%s41,-344(,%fp)	# restore 
 738      89002901 
 739 0910 A0FEFFFF 		ld	%s27,-352(,%fp)	# restore 
 739      89001B01 
 740 0918 A0FFFFFF 		br.l	.L2.34
 740      00000F18 
 741              	.L2.37:
 742              	# line 305
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 743              		.loc	1 305 0
 744 0920 00000000 		adds.w.sx	%s63,1,%s63
 744      BF013F4A 
 745 0928 00000000 		adds.w.sx	%s20,%s59,%s20
 745      94BB144A 
 746 0930 00000000 		adds.w.sx	%s19,%s59,%s19
 746      93BB134A 
 747 0938 00000000 		adds.w.sx	%s54,%s58,%s54
 747      B6BA364A 
 748 0940 00000000 		adds.w.sx	%s61,%s58,%s61
 748      BDBA3D4A 
 749 0948 00000000 		adds.w.sx	%s34,%s59,%s34
 749      A2BB224A 
 750 0950 00000000 		adds.w.sx	%s57,1,%s57
 750      B901394A 
 751 0958 88090000 		brgt.w	0,%s63,.L2.38
 751      BF008118 
 752 0960 78FFFFFF 		br.l	.L2.36
 752      00000F18 
 753              	.L2.39:
 754 0968 50FFFFFF 		ld	%s63,-176(,%fp)	# restore 
 754      89003F01 
 755 0970 58FFFFFF 		ld	%s59,-168(,%fp)	# restore 
 755      89003B01 
 756 0978 48FFFFFF 		ld	%s58,-184(,%fp)	# restore 
 756      89003A01 
 757 0980 40FFFFFF 		ld	%s57,-192(,%fp)	# restore 
 757      89003901 
 758 0988 60FFFFFF 		ld	%s21,-160(,%fp)	# restore 
 758      89001501 
 759 0990 30FFFFFF 		ld	%s39,-208(,%fp)	# restore 
 759      89002701 
 760 0998 28FFFFFF 		ld	%s35,-216(,%fp)	# restore 
 760      89002301 
 761 09a0 10FFFFFF 		ld	%s2,-240(,%fp)	# restore 
 761      89000201 
 762 09a8 20FFFFFF 		ld	%s5,-224(,%fp)	# restore 
 762      89000501 
 763 09b0 18FFFFFF 		ld	%s3,-232(,%fp)	# restore 
 763      89000301 
 764 09b8 F0FEFFFF 		ld	%s31,-272(,%fp)	# restore 
 764      89001F01 
 765 09c0 E0FEFFFF 		ld	%s29,-288(,%fp)	# restore 
 765      89001D01 
 766 09c8 08FFFFFF 		ld	%s1,-248(,%fp)	# restore 
 766      89000101 
 767 09d0 00FFFFFF 		ld	%s33,-256(,%fp)	# restore 
 767      89002101 
 768 09d8 F8FEFFFF 		ld	%s32,-264(,%fp)	# restore 
 768      89002001 
 769 09e0 E8FEFFFF 		ld	%s30,-280(,%fp)	# restore 
 769      89001E01 
 770 09e8 D8FEFFFF 		ld	%s28,-296(,%fp)	# restore 
 770      89001C01 
 771 09f0 38FFFFFF 		ld	%s62,-200(,%fp)	# restore 
 771      89003E01 
 772 09f8 28FFFFFF 		br.l	.L2.37
 772      00000F18 
 773              	.L2.40:
 774 0a00 90070000 		br.l	.L2.41
 774      00000F18 
 775              	.L2.42:
 776              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 777              		.loc	1 306 0
 778 0a08 00000000 		adds.w.sx	%s63,1,%s63
 778      BF013F4A 
 779 0a10 00000000 		adds.w.sx	%s59,%s60,%s59
 779      BBBC3B4A 
 780 0a18 00000000 		adds.w.sx	%s58,%s60,%s58
 780      BABC3A4A 
 781 0a20 00000000 		adds.l	%s57,4,%s57
 781      B9043959 
 782 0a28 00000000 		adds.w.sx	%s53,%s56,%s53
 782      B5B8354A 
 783 0a30 00000000 		adds.w.sx	%s51,%s56,%s51
 783      B3B8334A 
 784 0a38 00000000 		adds.w.sx	%s41,%s42,%s41
 784      A9AA294A 
 785 0a40 C0FFFFFF 		brgt.w	0,%s63,.L2.40
 785      BF008118 
 786 0a48 20FFFFFF 		br.l	.L2.39
 786      00000F18 
 787              	.L2.43:
 788              	# line 441
 441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 789              		.loc	1 441 0
 790 0a50 00000000 		or	%s62,0,(0)1
 790      00003E45 
 791 0a58 00000000 		stu	%s62,0(,%s57)	# *(d)
 791      B9003E12 
 792 0a60 A8FFFFFF 		br.l	.L2.42
 792      00000F18 
 793              	.L2.44:
 794              	# line 440
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 d = 0.f;
 795              		.loc	1 440 0
 796 0a68 00000000 		ldu	%s21,0(,%s57)	# *(d)
 796      B9001502 
 797 0a70 00000000 		or	%s22,0,(0)1
 797      00001645 
 798 0a78 D8FFFFFF 		brgt.s	%s22,%s21,.L2.43
 798      9596C118 
 799 0a80 88FFFFFF 		br.l	.L2.42
 799      00000F18 
 800              	.L2.45:
 801 0a88 E0FFFFFF 		breq.w	1,%s40,.L2.44
 801      A8018418 
 802 0a90 78FFFFFF 		br.l	.L2.42
 802      00000F18 
 803              	.L2.46:
 804 0a98 68FFFFFF 		st	%s52,-152(,%fp)	# spill 
 804      89003411 
 805 0aa0 70FFFFFF 		st	%s50,-144(,%fp)	# spill 
 805      89003211 
 806 0aa8 78FFFFFF 		st	%s49,-136(,%fp)	# spill 
 806      89003111 
 807 0ab0 80FFFFFF 		st	%s48,-128(,%fp)	# spill 
 807      89003011 
 808 0ab8 88FFFFFF 		st	%s54,-120(,%fp)	# spill 
 808      89003611 
 809 0ac0 90FFFFFF 		st	%s47,-112(,%fp)	# spill 
 809      89002F11 
 810 0ac8 98FFFFFF 		st	%s39,-104(,%fp)	# spill 
 810      89002711 
 811 0ad0 00000000 		or	%s40,0,%s28
 811      9C002845 
 812 0ad8 00000000 		or	%s48,0,%s21
 812      95003045 
 813 0ae0 00000000 		or	%s47,0,%s22
 813      96002F45 
 814 0ae8 00000000 		or	%s52,0,%s23
 814      97003445 
 815 0af0 C0FFFFFF 		ld	%s37,-64(,%fp)	# restore 
 815      89002501 
 816 0af8 00000000 		or	%s18,0,%s24
 816      98001245 
 817 0b00 00000000 		or	%s50,0,%s25
 817      99003245 
 818 0b08 00000000 		or	%s60,0,%s26
 818      9A003C45 
 819 0b10 B8FFFFFF 		ld	%s38,-72(,%fp)	# restore 
 819      89002601 
 820 0b18 00000000 		or	%s42,0,%s27
 820      9B002A45 
 821 0b20 B0FFFFFF 		ld	%s36,-80(,%fp)	# restore 
 821      89002401 
 822 0b28 00000000 		or	%s49,0,%s29
 822      9D003145 
 823 0b30 A8FFFFFF 		ld	%s7,-88(,%fp)	# restore 
 823      89000701 
 824 0b38 00000000 		or	%s51,0,%s30
 824      9E003345 
 825 0b40 A0FFFFFF 		ld	%s6,-96(,%fp)	# restore 
 825      89000601 
 826 0b48 00000000 		or	%s53,0,%s31
 826      9F003545 
 827 0b50 C8FFFFFF 		ld	%s41,-56(,%fp)	# restore 
 827      89002901 
 828 0b58 00000000 		or	%s58,0,%s32
 828      A0003A45 
 829 0b60 00000000 		or	%s59,0,%s33
 829      A1003B45 
 830 0b68 F8FFFFFF 		ld	%s63,-8(,%fp)	# restore 
 830      89003F01 
 831 0b70 00000000 		or	%s4,0,%s55
 831      B7000445 
 832 0b78 00000000 		or	%s55,0,%s62
 832      BE003745 
 833 0b80 F0FFFFFF 		ld	%s56,-16(,%fp)	# restore 
 833      89003801 
 834 0b88 E8FFFFFF 		ld	%s61,-24(,%fp)	# restore 
 834      89003D01 
 835 0b90 E0FFFFFF 		ld	%s54,-32(,%fp)	# restore 
 835      89003601 
 836 0b98 D8FFFFFF 		ld	%s19,-40(,%fp)	# restore 
 836      89001301 
 837 0ba0 D0FFFFFF 		ld	%s20,-48(,%fp)	# restore 
 837      89001401 
 838 0ba8 E0FEFFFF 		br.l	.L2.45
 838      00000F18 
 839              	.L2.47:
 840              	# line 428
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kh = kh_beg; kh < kh_end; ++kh) {
 841              		.loc	1 428 0
 842 0bb0 00000000 		adds.w.sx	%s63,1,%s63
 842      BF013F4A 
 843 0bb8 00000000 		adds.w.sx	%s60,1,%s60
 843      BC013C4A 
 844 0bc0 08030000 		brgt.w	0,%s63,.L2.48
 844      BF008118 
 845 0bc8 D0FEFFFF 		br.l	.L2.46
 845      00000F18 
 846              	.L2.49:
 847 0bd0 00000000 		or	%s63,0,%s6
 847      86003F45 
 848 0bd8 00000000 		or	%s60,0,%s7
 848      87003C45 
 849 0be0 D0FFFFFF 		br.l	.L2.47
 849      00000F18 
 850              	.L2.50:
 851              	# line 429
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   const int ih = oh * SH - PH + kh * (p->dh + 1);
 852              		.loc	1 429 0
 853 0be8 00000000 		adds.w.sx	%s63,1,%s63
 853      BF013F4A 
 854 0bf0 00000000 		adds.w.sx	%s60,%s62,%s60
 854      BCBE3C4A 
 855 0bf8 00000000 		adds.w.sx	%s59,1,%s59
 855      BB013B4A 
 856 0c00 70020000 		brgt.w	0,%s63,.L2.51
 856      BF008118 
 857 0c08 C8FFFFFF 		br.l	.L2.49
 857      00000F18 
 858              	.L2.24:
 859              	# line 436
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 860              		.loc	1 436 0
 861 0c10 00000000 		or	%s61,1,(0)1
 861      00013D45 
 862 0c18 00000000 		or	%s58,0,%s57
 862      B9003A45 
 863 0c20 00000000 		lvl	%s61
 863      00BD00BF 
 864 0c28 0000003B 		vstu.nc	%v59,0,%s58
 864      BA000092 
 865 0c30 B8FFFFFF 		br.l	.L2.50
 865      00000F18 
 866              	.L2.52:
 867 0c38 00000000 		or	%s57,0,%s3
 867      83003945 
 868 0c40 00000000 		or	%s39,0,%s61
 868      BD002745 
 869 0c48 00000000 		or	%s59,0,%s4
 869      84003B45 
 870 0c50 00000000 		or	%s60,0,%s5
 870      85003C45 
 871 0c58 00000000 		or	%s62,0,%s1
 871      81003E45 
 872 0c60 00000000 		or	%s63,0,%s2
 872      82003F45 
 873              	# line 435
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 874              		.loc	1 435 0
 875 0c68 00000000 		lvl	%s37
 875      00A500BF 
 876 0c70 00003F3A 		vfsum.s	%v58,%v63
 876      000080EC 
 877 0c78 00000000 		or	%s61,1,(0)1
 877      00013D45 
 878 0c80 00000000 		lvl	%s61
 878      00BD00BF 
 879 0c88 003A3C3B 		vfadd.s	%v59,%v60,%v58
 879      000080CC 
 880 0c90 80FFFFFF 		br.l	.L2.24
 880      00000F18 
 881              	.L2.26:
 882 0c98 00000000 		or	%s62,0,%s63
 882      BF003E45 
 883 0ca0 00000000 		lvl	%s60
 883      00BC00BF 
 884 0ca8 0000003E 		vldu.nc	%v62,%s61,%s62
 884      BEBD0082 
 885 0cb0 00000000 		or	%s62,0,%s59
 885      BB003E45 
 886 0cb8 0000003D 		vldu.nc	%v61,4,%s62
 886      BE040082 
 887 0cc0 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 887      000080E2 
 888              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 889              		.loc	1 431 0
 890 0cc8 00000000 		adds.l	%s63,%s63,%s58
 890      BABF3F59 
 891 0cd0 00000000 		adds.l	%s59,%s59,%s57
 891      B9BB3B59 
 892 0cd8 00000000 		subs.w.sx	%s56,%s56,%s60
 892      BCB8385A 
 893 0ce0 58FFFFFF 		brge.w	0,%s56,.L2.52
 893      B8008518 
 894 0ce8 20FAFFFF 		br.l	.L2.25
 894      00000F18 
 895              	.L2.53:
 896              	# line 435
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 897              		.loc	1 435 0
 898 0cf0 00000000 		divs.w.sx	%s53,%s55,%s54
 898      B6B7357B 
 899 0cf8 00000000 		or	%s61,0,%s39
 899      A7003D45 
 900 0d00 00000000 		or	%s1,0,%s62
 900      BE000145 
 901 0d08 00000000 		or	%s2,0,%s63
 901      BF000245 
 902 0d10 00000000 		or	%s3,0,%s57
 902      B9000345 
 903 0d18 00000000 		or	%s4,0,%s59
 903      BB000445 
 904 0d20 00000000 		or	%s5,0,%s60
 904      BC000545 
 905 0d28 00000000 		or	%s53,0,%s53
 905      B5003545 
 906 0d30 00000000 		addu.l	%s53,%s53,%s52
 906      B4B53548 
 907 0d38 00000000 		addu.l	%s53,%s53,%s51
 907      B3B53548 
 908 0d40 00000000 		mulu.l	%s53,%s53,%s50
 908      B2B53549 
 909 0d48 00000000 		or	%s62,0,%s60
 909      BC003E45 
 910 0d50 00000000 		addu.l	%s62,%s53,%s62
 910      BEB53E48 
 911 0d58 00000000 		mulu.l	%s62,%s62,%s49
 911      B1BE3E49 
 912 0d60 00000000 		or	%s62,0,%s62
 912      BE003E45 
 913 0d68 00000000 		divu.l	%s53,%s48,%s47
 913      AFB0356F 
 914 0d70 00000000 		addu.l	%s53,%s53,%s46
 914      AEB53548 
 915 0d78 00000000 		mulu.l	%s53,%s53,%s45
 915      ADB53549 
 916 0d80 00000000 		divu.l	%s53,%s53,%s47
 916      AFB5356F 
 917 0d88 00000000 		addu.l	%s53,%s51,%s53
 917      B5B33548 
 918 0d90 00000000 		mulu.l	%s53,%s53,%s44
 918      ACB53549 
 919 0d98 00000000 		or	%s38,0,%s59
 919      BB002645 
 920 0da0 00000000 		addu.l	%s38,%s53,%s38
 920      A6B52648 
 921 0da8 00000000 		mulu.l	%s38,%s38,%s43
 921      ABA62649 
 922 0db0 00000000 		or	%s38,0,%s38
 922      A6002645 
 923              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 924              		.loc	1 431 0
 925 0db8 00000000 		muls.l	%s38,4,%s38
 925      A604266E 
 926 0dc0 00000000 		muls.l	%s62,4,%s62
 926      BE043E6E 
 927 0dc8 00000000 		adds.l	%s38,%s38,%s42
 927      AAA62659 
 928 0dd0 00000000 		adds.l	%s62,%s62,%s41
 928      A9BE3E59 
 929 0dd8 00000000 		subs.w.sx	%s53,0,%s40
 929      A800355A 
 930 0de0 00000000 		smvl	%s37
 930      0000252E 
 931 0de8 80000000 		mins.w.sx	%s60,%s53,%s37
 931      A5B53C78 
 932              	# line 435
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 933              		.loc	1 435 0
 934 0df0 00000000 		or	%s36,0,(0)1
 934      00002445 
 935 0df8 00000000 		lvl	%s37
 935      00A500BF 
 936 0e00 0000003F 		vbrdu	%v63,%s36
 936      00A4808C 
 937 0e08 00000000 		or	%s56,0,%s53
 937      B5003845 
 938 0e10 00000000 		or	%s53,0,%s60
 938      BC003545 
 939 0e18 00000000 		or	%s63,0,%s62
 939      BE003F45 
 940              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 941              		.loc	1 431 0
 942 0e20 00000000 		muls.l	%s58,%s39,%s53
 942      B5A73A6E 
 943 0e28 00000000 		or	%s59,0,%s38
 943      A6003B45 
 944 0e30 00000000 		muls.l	%s57,4,%s53
 944      B504396E 
 945 0e38 60FEFFFF 		br.l	.L2.26
 945      00000F18 
 946              	.L2.54:
 947 0e40 00000000 		or	%s58,1,(0)1
 947      00013A45 
 948 0e48 00000000 		or	%s56,0,%s57
 948      B9003845 
 949 0e50 00000000 		lvl	%s58
 949      00BA00BF 
 950 0e58 0000003C 		vldu.nc	%v60,0,%s56
 950      B8000082 
 951 0e60 90FEFFFF 		brlt.w	0,%s18,.L2.53
 951      92008218 
 952 0e68 80F8FFFF 		br.l	.L2.23
 952      00000F18 
 953              	.L2.51:
 954 0e70 D0FFFFFF 		brlt.w	0,%s18,.L2.54
 954      92008218 
 955 0e78 70FDFFFF 		br.l	.L2.50
 955      00000F18 
 956              	.L2.55:
 957 0e80 00000000 		or	%s51,0,%s60
 957      BC003345 
 958              	# line 429
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   const int ih = oh * SH - PH + kh * (p->dh + 1);
 959              		.loc	1 429 0
 960 0e88 00000000 		adds.w.sx	%s61,%s19,%s35
 960      A3933D4A 
 961 0e90 00000000 		muls.w.sx	%s58,%s19,%s62
 961      BE933A4B 
 962 0e98 00000000 		or	%s6,0,%s63
 962      BF000645 
 963 0ea0 00000000 		or	%s63,0,%s61
 963      BD003F45 
 964 0ea8 00000000 		adds.w.sx	%s58,%s58,%s34
 964      A2BA3A4A 
 965 0eb0 00000000 		or	%s7,0,%s60
 965      BC000745 
 966 0eb8 00000000 		or	%s60,0,%s58
 966      BA003C45 
 967 0ec0 B0FFFFFF 		br.l	.L2.51
 967      00000F18 
 968              	.L2.48:
 969 0ec8 00000000 		or	%s59,0,%s19
 969      93003B45 
 970 0ed0 B0FFFFFF 		brlt.w	%s19,%s20,.L2.55
 970      94938218 
 971 0ed8 D8FCFFFF 		br.l	.L2.47
 971      00000F18 
 972              	.L2.56:
 973 0ee0 F8FFFFFF 		st	%s63,-8(,%fp)	# spill 
 973      89003F11 
 974 0ee8 F0FFFFFF 		st	%s56,-16(,%fp)	# spill 
 974      89003811 
 975 0ef0 E8FFFFFF 		st	%s61,-24(,%fp)	# spill 
 975      89003D11 
 976 0ef8 E0FFFFFF 		st	%s54,-32(,%fp)	# spill 
 976      89003611 
 977 0f00 D8FFFFFF 		st	%s19,-40(,%fp)	# spill 
 977      89001311 
 978 0f08 D0FFFFFF 		st	%s20,-48(,%fp)	# spill 
 978      89001411 
 979 0f10 C8FFFFFF 		st	%s41,-56(,%fp)	# spill 
 979      89002911 
 980 0f18 C0FFFFFF 		st	%s37,-64(,%fp)	# spill 
 980      89002511 
 981 0f20 B8FFFFFF 		st	%s38,-72(,%fp)	# spill 
 981      89002611 
 982 0f28 B0FFFFFF 		st	%s36,-80(,%fp)	# spill 
 982      89002411 
 983 0f30 A8FFFFFF 		st	%s7,-88(,%fp)	# spill 
 983      89000711 
 984 0f38 A0FFFFFF 		st	%s6,-96(,%fp)	# spill 
 984      89000611 
 985 0f40 00000000 		or	%s61,0,%s21
 985      95003D45 
 986              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 987              		.loc	1 431 0
 988 0f48 00000000 		subs.w.sx	%s56,%s22,%s21
 988      9596385A 
 989 0f50 00000000 		or	%s19,0,%s2
 989      82001345 
 990 0f58 00000000 		subs.w.sx	%s5,0,%s56
 990      B800055A 
 991              	# line 428
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kh = kh_beg; kh < kh_end; ++kh) {
 992              		.loc	1 428 0
 993 0f60 00000000 		divs.w.sx	%s37,%s38,%s37
 993      A5A6257B 
 994 0f68 00000000 		or	%s20,0,%s3
 994      83001445 
 995 0f70 00000000 		or	%s62,0,%s55
 995      B7003E45 
 996 0f78 00000000 		or	%s22,0,%s47
 996      AF001645 
 997 0f80 00000000 		or	%s23,0,%s52
 997      B4001745 
 998 0f88 00000000 		or	%s24,0,%s18
 998      92001845 
 999 0f90 00000000 		or	%s18,0,%s56
 999      B8001245 
 1000 0f98 00000000 		or	%s25,0,%s50
 1000      B2001945 
 1001 0fa0 00000000 		or	%s26,0,%s60
 1001      BC001A45 
 1002 0fa8 00000000 		or	%s60,0,%s39
 1002      A7003C45 
 1003 0fb0 00000000 		subs.w.sx	%s37,0,%s37
 1003      A500255A 
 1004 0fb8 00000000 		or	%s27,0,%s42
 1004      AA001B45 
 1005 0fc0 00000000 		or	%s63,0,%s37
 1005      A5003F45 
 1006              	# line 435
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 1007              		.loc	1 435 0
 1008 0fc8 00000000 		muls.w.sx	%s36,%s21,%s36
 1008      A495244B 
 1009 0fd0 00000000 		or	%s28,0,%s40
 1009      A8001C45 
 1010 0fd8 00000000 		or	%s40,0,%s5
 1010      85002845 
 1011 0fe0 00000000 		adds.w.sx	%s36,%s21,%s36
 1011      A495244A 
 1012 0fe8 00000000 		or	%s21,0,%s48
 1012      B0001545 
 1013 0ff0 00000000 		adds.w.sx	%s36,%s41,%s36
 1013      A4A9244A 
 1014 0ff8 00000000 		or	%s29,0,%s49
 1014      B1001D45 
 1015 1000 00000000 		or	%s36,0,%s36
 1015      A4002445 
 1016              	# line 429
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   const int ih = oh * SH - PH + kh * (p->dh + 1);
 1017              		.loc	1 429 0
 1018 1008 00000000 		subs.w.sx	%s35,0,%s3
 1018      8300235A 
 1019              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 1020              		.loc	1 431 0
 1021 1010 00000000 		muls.l	%s61,4,%s61
 1021      BD043D6E 
 1022 1018 00000000 		or	%s30,0,%s51
 1022      B3001E45 
 1023 1020 00000000 		muls.l	%s36,4,%s36
 1023      A404246E 
 1024 1028 00000000 		adds.l	%s42,%s61,%s7
 1024      87BD2A59 
 1025 1030 00000000 		or	%s31,0,%s53
 1025      B5001F45 
 1026 1038 00000000 		adds.l	%s41,%s36,%s6
 1026      86A42959 
 1027 1040 00000000 		or	%s32,0,%s58
 1027      BA002045 
 1028 1048 00000000 		or	%s33,0,%s59
 1028      BB002145 
 1029 1050 00000000 		or	%s55,0,%s4
 1029      84003745 
 1030 1058 98FFFFFF 		ld	%s39,-104(,%fp)	# restore 
 1030      89002701 
 1031 1060 90FFFFFF 		ld	%s47,-112(,%fp)	# restore 
 1031      89002F01 
 1032 1068 88FFFFFF 		ld	%s54,-120(,%fp)	# restore 
 1032      89003601 
 1033 1070 80FFFFFF 		ld	%s48,-128(,%fp)	# restore 
 1033      89003001 
 1034 1078 78FFFFFF 		ld	%s49,-136(,%fp)	# restore 
 1034      89003101 
 1035 1080 70FFFFFF 		ld	%s50,-144(,%fp)	# restore 
 1035      89003201 
 1036 1088 68FFFFFF 		ld	%s52,-152(,%fp)	# restore 
 1036      89003401 
 1037 1090 38FEFFFF 		br.l	.L2.48
 1037      00000F18 
 1038              	.L2.57:
 1039              	# line 428
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kh = kh_beg; kh < kh_end; ++kh) {
 1040              		.loc	1 428 0
 1041 1098 00000000 		or	%s39,0,(0)1
 1041      00002745 
 1042 10a0 00000000 		divs.w.sx	%s23,%s38,%s37
 1042      A5A6177B 
 1043 10a8 38FEFFFF 		brlt.w	0,%s23,.L2.56
 1043      97008218 
 1044 10b0 D8F9FFFF 		br.l	.L2.45
 1044      00000F18 
 1045              	.L2.58:
 1046 10b8 E0FFFFFF 		brlt.w	%s2,%s3,.L2.57
 1046      83828218 
 1047 10c0 C8F9FFFF 		br.l	.L2.45
 1047      00000F18 
 1048              	.L2.22:
 1049 10c8 F0FFFFFF 		brlt.w	%s21,%s22,.L2.58
 1049      96958218 
 1050 10d0 B8F9FFFF 		br.l	.L2.45
 1050      00000F18 
 1051              	.L2.59:
 1052 10d8 00000000 		or	%s22,0,%s47
 1052      AF001645 
 1053 10e0 00000000 		or	%s63,0,%s1
 1053      81003F45 
 1054 10e8 E0FFFFFF 		br.l	.L2.22
 1054      00000F18 
 1055              	.L2.20:
 1056 10f0 E8FFFFFF 		brge.w	0,%s59,.L2.59
 1056      BB008518 
 1057 10f8 D8F5FFFF 		br.l	.L2.21
 1057      00000F18 
 1058              	.L2.60:
 1059              	# line 422
 422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kw_end = (os <= OWs_EgeK ? KW : (top+IW)/(p->dw+1) );
 1060              		.loc	1 422 0
 1061 1100 00000000 		or	%s21,0,(0)1
 1061      00001545 
 1062 1108 E8FFFFFF 		br.l	.L2.20
 1062      00000F18 
 1063              	.L2.18:
 1064 1110 F0FFFFFF 		brle.w	0,%s58,.L2.60
 1064      BA008618 
 1065 1118 A8F5FFFF 		br.l	.L2.19
 1065      00000F18 
 1066              	.L2.61:
 1067 1120 00000000 		or	%s3,0,%s48
 1067      B0000345 
 1068 1128 E8FFFFFF 		br.l	.L2.18
 1068      00000F18 
 1069              	.L2.16:
 1070 1130 F0FFFFFF 		brge.w	0,%s20,.L2.61
 1070      94008518 
 1071 1138 78F5FFFF 		br.l	.L2.17
 1071      00000F18 
 1072              	.L2.62:
 1073              	# line 418
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kh_end = (os <= OHs_EgeK ? p->kh : (top+IH)/(p->dh+1) );
 1074              		.loc	1 418 0
 1075 1140 00000000 		or	%s2,0,(0)1
 1075      00000245 
 1076 1148 E8FFFFFF 		br.l	.L2.16
 1076      00000F18 
 1077              	.L2.14:
 1078              	# line 310
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 1079              		.loc	1 310 0
 1080 1150 00000000 		ldu	%s63,0(,%s57)	# *(d)
 1080      B9003F02 
 1081 1158 00000000 		stu	%s63,0(,%s57)	# *(d)
 1081      B9003F12 
 1082 1160 E0FFFFFF 		brle.w	0,%s19,.L2.62
 1082      93008618 
 1083 1168 38F5FFFF 		br.l	.L2.15
 1083      00000F18 
 1084              	.L2.63:
 1085 1170 00000000 		ldu	%s62,0(%s49,%s50)	# float
 1085      B2B13E02 
 1086 1178 00000000 		or	%s1,0,%s63
 1086      BF000145 
 1087 1180 00000000 		stu	%s62,0(,%s57)	# *(d)
 1087      B9003E12 
 1088 1188 C8FFFFFF 		br.l	.L2.14
 1088      00000F18 
 1089              	.L2.41:
 1090 1190 E0FFFFFF 		brne.w	0,%s18,.L2.63
 1090      92008318 
 1091 1198 E8F4FFFF 		br.l	.L2.13
 1091      00000F18 
 1092              	.L2.64:
 1093 11a0 60FFFFFF 		st	%s21,-160(,%fp)	# spill 
 1093      89001511 
 1094 11a8 58FFFFFF 		st	%s59,-168(,%fp)	# spill 
 1094      89003B11 
 1095 11b0 50FFFFFF 		st	%s63,-176(,%fp)	# spill 
 1095      89003F11 
 1096 11b8 48FFFFFF 		st	%s58,-184(,%fp)	# spill 
 1096      89003A11 
 1097 11c0 40FFFFFF 		st	%s57,-192(,%fp)	# spill 
 1097      89003911 
 1098 11c8 38FFFFFF 		st	%s62,-200(,%fp)	# spill 
 1098      89003E11 
 1099 11d0 30FFFFFF 		st	%s39,-208(,%fp)	# spill 
 1099      89002711 
 1100 11d8 28FFFFFF 		st	%s35,-216(,%fp)	# spill 
 1100      89002311 
 1101 11e0 20FFFFFF 		st	%s5,-224(,%fp)	# spill 
 1101      89000511 
 1102 11e8 18FFFFFF 		st	%s3,-232(,%fp)	# spill 
 1102      89000311 
 1103 11f0 10FFFFFF 		st	%s2,-240(,%fp)	# spill 
 1103      89000211 
 1104 11f8 08FFFFFF 		st	%s1,-248(,%fp)	# spill 
 1104      89000111 
 1105 1200 00FFFFFF 		st	%s33,-256(,%fp)	# spill 
 1105      89002111 
 1106 1208 F8FEFFFF 		st	%s32,-264(,%fp)	# spill 
 1106      89002011 
 1107 1210 F0FEFFFF 		st	%s31,-272(,%fp)	# spill 
 1107      89001F11 
 1108 1218 E8FEFFFF 		st	%s30,-280(,%fp)	# spill 
 1108      89001E11 
 1109 1220 E0FEFFFF 		st	%s29,-288(,%fp)	# spill 
 1109      89001D11 
 1110 1228 D8FEFFFF 		st	%s28,-296(,%fp)	# spill 
 1110      89001C11 
 1111 1230 00000000 		divs.w.sx	%s62,%s62,%s37
 1111      A5BE3E7B 
 1112 1238 00000000 		or	%s62,0,%s62
 1112      BE003E45 
 1113 1240 00000000 		addu.l	%s39,%s62,%s39
 1113      A7BE2748 
 1114 1248 00000000 		addu.l	%s39,%s39,%s46
 1114      AEA72748 
 1115 1250 00000000 		mulu.l	%s35,%s39,%s35
 1115      A3A72349 
 1116 1258 00000000 		divu.l	%s3,%s5,%s3
 1116      8385036F 
 1117 1260 00000000 		addu.l	%s3,%s46,%s3
 1117      83AE0348 
 1118 1268 00000000 		mulu.l	%s49,4,%s3
 1118      83043149 
 1119 1270 00000000 		or	%s62,0,%s57
 1119      B9003E45 
 1120 1278 00000000 		addu.l	%s62,%s35,%s62
 1120      BEA33E48 
 1121 1280 00000000 		mulu.l	%s2,%s62,%s2
 1121      82BE0249 
 1122 1288 00000000 		or	%s2,0,%s2
 1122      82000245 
 1123 1290 00000000 		or	%s63,0,%s1
 1123      81003F45 
 1124 1298 00000000 		or	%s59,0,%s33
 1124      A1003B45 
 1125 12a0 00000000 		or	%s58,0,%s32
 1125      A0003A45 
 1126              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1127              		.loc	1 306 0
 1128 12a8 00000000 		muls.l	%s2,4,%s2
 1128      8204026E 
 1129 12b0 00000000 		adds.l	%s31,%s2,%s31
 1129      9F821F59 
 1130 12b8 00000000 		or	%s57,0,%s31
 1130      9F003945 
 1131 12c0 00000000 		or	%s53,0,%s30
 1131      9E003545 
 1132 12c8 00000000 		or	%s51,0,%s29
 1132      9D003345 
 1133 12d0 00000000 		or	%s41,0,%s28
 1133      9C002945 
 1134 12d8 B8FEFFFF 		br.l	.L2.41
 1134      00000F18 
 1135              	.L2.38:
 1136 12e0 C0FEFFFF 		brlt.w	0,%s21,.L2.64
 1136      95008218 
 1137 12e8 38F6FFFF 		br.l	.L2.37
 1137      00000F18 
 1138              	.L2.65:
 1139 12f0 D0FEFFFF 		st	%s19,-304(,%fp)	# spill 
 1139      89001311 
 1140 12f8 C8FEFFFF 		st	%s63,-312(,%fp)	# spill 
 1140      89003F11 
 1141 1300 C0FEFFFF 		st	%s53,-320(,%fp)	# spill 
 1141      89003511 
 1142 1308 B8FEFFFF 		st	%s51,-328(,%fp)	# spill 
 1142      89003311 
 1143 1310 B0FEFFFF 		st	%s49,-336(,%fp)	# spill 
 1143      89003111 
 1144 1318 A8FEFFFF 		st	%s41,-344(,%fp)	# spill 
 1144      89002911 
 1145 1320 A0FEFFFF 		st	%s27,-352(,%fp)	# spill 
 1145      89001B11 
 1146 1328 98FEFFFF 		st	%s26,-360(,%fp)	# spill 
 1146      89001A11 
 1147 1330 00000000 		or	%s46,0,%s53
 1147      B5002E45 
 1148 1338 00000000 		or	%s63,0,%s51
 1148      B3003F45 
 1149 1340 00000000 		or	%s20,0,%s49
 1149      B1001445 
 1150 1348 00000000 		or	%s19,0,%s41
 1150      A9001345 
 1151 1350 00000000 		or	%s54,0,%s27
 1151      9B003645 
 1152 1358 00000000 		or	%s61,0,%s26
 1152      9A003D45 
 1153 1360 00000000 		or	%s34,0,%s41
 1153      A9002245 
 1154 1368 78FFFFFF 		br.l	.L2.38
 1154      00000F18 
 1155              	.L2.35:
 1156              	# line 305
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1157              		.loc	1 305 0
 1158 1370 00000000 		or	%s57,0,(0)1
 1158      00003945 
 1159 1378 78FFFFFF 		brlt.w	0,%s19,.L2.65
 1159      93008218 
 1160 1380 38F5FFFF 		br.l	.L2.34
 1160      00000F18 
 1161              	.L2.66:
 1162 1388 90FEFFFF 		st	%s20,-368(,%fp)	# spill 
 1162      89001411 
 1163 1390 88FEFFFF 		st	%s63,-376(,%fp)	# spill 
 1163      89003F11 
 1164 1398 80FEFFFF 		st	%s39,-384(,%fp)	# spill 
 1164      89002711 
 1165 13a0 78FEFFFF 		st	%s57,-392(,%fp)	# spill 
 1165      89003911 
 1166 13a8 70FEFFFF 		st	%s34,-400(,%fp)	# spill 
 1166      89002211 
 1167 13b0 68FEFFFF 		st	%s46,-408(,%fp)	# spill 
 1167      89002E11 
 1168 13b8 60FEFFFF 		st	%s61,-416(,%fp)	# spill 
 1168      89003D11 
 1169              	# line 304
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 1170              		.loc	1 304 0
 1171 13c0 00000000 		divs.w.sx	%s61,%s61,%s37
 1171      A5BD3D7B 
 1172 13c8 00000000 		subs.w.sx	%s61,0,%s61
 1172      BD003D5A 
 1173 13d0 00000000 		or	%s63,0,%s61
 1173      BD003F45 
 1174 13d8 00000000 		or	%s39,0,%s46
 1174      AE002745 
 1175 13e0 00000000 		or	%s34,0,%s34
 1175      A2002245 
 1176 13e8 68FFFFFF 		st	%s34,-152(,%fp)	# spill 
 1176      89002211 
 1177 13f0 80FFFFFF 		br.l	.L2.35
 1177      00000F18 
 1178              	.L2.32:
 1179 13f8 00000000 		or	%s53,0,(0)1
 1179      00003545 
 1180 1400 88FFFFFF 		brlt.w	0,%s20,.L2.66
 1180      94008218 
 1181 1408 48F4FFFF 		br.l	.L2.31
 1181      00000F18 
 1182              	.L2.67:
 1183 1410 58FEFFFF 		st	%s20,-424(,%fp)	# spill 
 1183      89001411 
 1184 1418 50FEFFFF 		st	%s46,-432(,%fp)	# spill 
 1184      89002E11 
 1185 1420 48FEFFFF 		st	%s63,-440(,%fp)	# spill 
 1185      89003F11 
 1186 1428 40FEFFFF 		st	%s34,-448(,%fp)	# spill 
 1186      89002211 
 1187 1430 38FEFFFF 		st	%s5,-456(,%fp)	# spill 
 1187      89000511 
 1188 1438 30FEFFFF 		st	%s53,-464(,%fp)	# spill 
 1188      89003511 
 1189 1440 28FEFFFF 		st	%s54,-472(,%fp)	# spill 
 1189      89003611 
 1190 1448 00000000 		divs.w.sx	%s20,%s61,%s37
 1190      A5BD147B 
 1191 1450 00000000 		or	%s5,0,%s53
 1191      B5000545 
 1192 1458 38FEFFFF 		ld	%s53,-456(,%fp)	# restore 
 1192      89003501 
 1193 1460 00000000 		or	%s63,0,%s54
 1193      B6003F45 
 1194              	# line 303
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 1195              		.loc	1 303 0
 1196 1468 00000000 		or	%s46,0,(0)1
 1196      00002E45 
 1197 1470 80FFFFFF 		st	%s53,-128(,%fp)	# spill 
 1197      89003511 
 1198 1478 00000000 		or	%s34,0,(0)1
 1198      00002245 
 1199 1480 00000000 		or	%s4,0,%s55
 1199      B7000445 
 1200 1488 00000000 		or	%s55,0,%s25
 1200      99003745 
 1201 1490 68FFFFFF 		br.l	.L2.32
 1201      00000F18 
 1202              	.L2.29:
 1203 1498 78FFFFFF 		brlt.w	0,%s20,.L2.67
 1203      94008218 
 1204 14a0 28F3FFFF 		br.l	.L2.28
 1204      00000F18 
 1205              	.L2.68:
 1206 14a8 04000000 		dldl.sx	%s20,4(,%s60)	# *(p).__b_N4conv6desc_tE.mb
 1206      BC00140B 
 1207 14b0 00000000 		or	%s25,0,%s62
 1207      BE001945 
 1208 14b8 00000000 		subs.w.sx	%s0,0,%s20
 1208      9400005A 
 1209              	# line 304
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 1210              		.loc	1 304 0
 1211 14c0 14000000 		dldl.sx	%s24,20(,%s60)	# *(p).__b_N4conv6desc_tE.oc
 1211      BC00180B 
 1212 14c8 00000000 		or	%s23,0,%s24
 1212      98001745 
 1213 14d0 00000000 		or	%s22,0,%s57
 1213      B9001645 
 1214 14d8 00000000 		or	%s57,0,%s23
 1214      97003945 
 1215              	# line 302
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1216              		.loc	1 302 0
 1217 14e0 00000000 		or	%s23,0,(0)1
 1217      00001745 
 1218 14e8 00000000 		or	%s5,0,(0)1
 1218      00000545 
 1219 14f0 00000000 		or	%s62,0,%s3
 1219      83003E45 
 1220 14f8 00000000 		or	%s3,0,%s37
 1220      A5000345 
 1221 1500 00000000 		subs.w.sx	%s55,0,%s37
 1221      A500375A 
 1222 1508 00000000 		or	%s51,0,%s63
 1222      BF003345 
 1223 1510 00000000 		or	%s63,0,%s55
 1223      B7003F45 
 1224              	# line 305
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1225              		.loc	1 305 0
 1226 1518 18000000 		dldl.sx	%s19,24(,%s60)	# *(p).__b_N4conv6desc_tE.oh
 1226      BC00130B 
 1227 1520 00000000 		or	%s35,0,%s19
 1227      93002345 
 1228 1528 00000000 		subs.w.sx	%s55,0,%s19
 1228      9300375A 
 1229              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1230              		.loc	1 306 0
 1231 1530 1C000000 		dldl.sx	%s21,28(,%s60)	# *(p).__b_N4conv6desc_tE.ow
 1231      BC00150B 
 1232 1538 00000000 		or	%s50,0,%s2
 1232      82003245 
 1233 1540 00000000 		or	%s2,0,%s21
 1233      95000245 
 1234 1548 00000000 		subs.w.sx	%s49,0,%s21
 1234      9500315A 
 1235              	# line 310
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 1236              		.loc	1 310 0
 1237 1550 A8010000 		dld	%s31,424(,%s4)	# *(dst_m).data_
 1237      84001F09 
 1238 1558 48000000 		dldl.zx	%s4,72(,%s60)	# *(p).dir
 1238      BC00840B 
 1239 1560 00000000 		adds.w.sx	%s4,0,%s4
 1239      8400044A 
 1240 1568 04000000 		lea	%s46,4
 1240      00002E06 
 1241 1570 00000000 		and	%s18,%s4,%s46
 1241      AE841244 
 1242              	# line 416
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int top = PH + p->dh - os;
 1243              		.loc	1 416 0
 1244 1578 28000000 		dldl.sx	%s4,40(,%s60)	# *(p).__b_N4conv6desc_tE.sh
 1244      BC00040B 
 1245              	# line 305
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1246              		.loc	1 305 0
 1247 1580 00000000 		subs.w.sx	%s46,0,%s4
 1247      84002E5A 
 1248 1588 00000000 		subs.w.sx	%s41,0,%s61
 1248      BD00295A 
 1249              	# line 417
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kh_beg = (os >= PH    ? 0     : top/(p->dh+1));
 1250              		.loc	1 417 0
 1251 1590 00000000 		adds.w.sx	%s26,%s61,%s58
 1251      BABD1A4A 
 1252              	# line 310
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 1253              		.loc	1 310 0
 1254 1598 A8010000 		dld	%s61,424(,%s62)	# *(bia_m).data_
 1254      BE003D09 
 1255 15a0 00000000 		or	%s58,0,%s46
 1255      AE003A45 
 1256              	# line 420
 420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             top = PW + p->dw - os;
 1257              		.loc	1 420 0
 1258 15a8 2C000000 		dldl.sx	%s62,44(,%s60)	# *(p).__b_N4conv6desc_tE.sw
 1258      BC003E0B 
 1259              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1260              		.loc	1 306 0
 1261 15b0 00000000 		subs.w.sx	%s46,0,%s62
 1261      BE002E5A 
 1262 15b8 00000000 		subs.w.sx	%s32,0,%s59
 1262      BB00205A 
 1263              	# line 421
 421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int const kw_beg = (os >= PW    ? 0     : top/(p->dw+1));
 1264              		.loc	1 421 0
 1265 15c0 00000000 		adds.w.sx	%s29,%s59,%s54
 1265      B6BB1D4A 
 1266              	# line 305
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1267              		.loc	1 305 0
 1268 15c8 00000000 		adds.w.sx	%s27,%s51,%s26
 1268      9AB31B4A 
 1269              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1270              		.loc	1 306 0
 1271 15d0 00000000 		adds.w.sx	%s30,%s56,%s29
 1271      9DB81E4A 
 1272              	# line 440
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 d = 0.f;
 1273              		.loc	1 440 0
 1274 15d8 5C000000 		dldl.zx	%s59,92(,%s60)	# *(p).merge
 1274      BC00BB0B 
 1275 15e0 00000000 		or	%s54,0,%s0
 1275      80003645 
 1276 15e8 00000000 		or	%s51,0,%s55
 1276      B7003345 
 1277 15f0 00000000 		adds.w.sx	%s40,0,%s59
 1277      BB00284A 
 1278              	# line 428
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kh = kh_beg; kh < kh_end; ++kh) {
 1279              		.loc	1 428 0
 1280 15f8 08000000 		dldl.sx	%s38,8(,%s60)	# *(p).__b_N4conv6desc_tE.ic
 1280      BC00260B 
 1281 1600 00000000 		or	%s59,0,%s4
 1281      84003B45 
 1282              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 1283              		.loc	1 431 0
 1284 1608 A8010000 		dld	%s6,424(,%s1)	# *(s$15).data_
 1284      81000609 
 1285              	# line 302
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1286              		.loc	1 302 0
 1287 1610 00000000 		or	%s4,0,(0)1
 1287      00000445 
 1288 1618 00000000 		or	%s55,0,(0)1
 1288      00003745 
 1289              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 1290              		.loc	1 431 0
 1291 1620 A8010000 		dld	%s7,424(,%s50)	# *(s$17).data_
 1291      B2000709 
 1292 1628 00000000 		or	%s50,0,%s61
 1292      BD003245 
 1293              	# line 435
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 1294              		.loc	1 435 0
 1295 1630 08000000 		dldl.sx	%s0,8(,%s60)	# *(p).__b_N4conv6desc_tE.ic
 1295      BC00000B 
 1296 1638 00000000 		or	%s61,0,%s24
 1296      98003D45 
 1297 1640 00000000 		or	%s1,0,%s49
 1297      B1000145 
 1298 1648 00000000 		or	%s45,0,%s0
 1298      80002D45 
 1299 1650 00000000 		or	%s39,0,%s45
 1299      AD002745 
 1300 1658 00000000 		dldl.sx	%s24,0(,%s60)	# *(p).__b_N4conv6desc_tE.g
 1300      BC00180B 
 1301 1660 00000000 		or	%s56,0,%s46
 1301      AE003845 
 1302 1668 00000000 		or	%s46,0,%s0
 1302      80002E45 
 1303 1670 88FFFFFF 		st	%s24,-120(,%fp)	# spill 
 1303      89001811 
 1304 1678 00000000 		or	%s24,0,%s24
 1304      98001845 
 1305 1680 90FFFFFF 		st	%s24,-112(,%fp)	# spill 
 1305      89001811 
 1306 1688 0C000000 		dldl.sx	%s0,12(,%s60)	# *(p).__b_N4conv6desc_tE.ih
 1306      BC00000B 
 1307 1690 00000000 		or	%s0,0,%s0
 1307      80000045 
 1308 1698 70FFFFFF 		st	%s0,-144(,%fp)	# spill 
 1308      89000011 
 1309 16a0 10000000 		dldl.sx	%s0,16(,%s60)	# *(p).__b_N4conv6desc_tE.iw
 1309      BC00000B 
 1310 16a8 00000000 		or	%s0,0,%s0
 1310      80000045 
 1311 16b0 78FFFFFF 		st	%s0,-136(,%fp)	# spill 
 1311      89000011 
 1312 16b8 2C000000 		dldl.sx	%s42,44(,%s60)	# *(p).__b_N4conv6desc_tE.sw
 1312      BC002A0B 
 1313 16c0 34000000 		dldl.sx	%s0,52(,%s60)	# *(p).__b_N4conv6desc_tE.pw
 1313      BC00000B 
 1314              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1315              		.loc	1 306 0
 1316 16c8 00000000 		subs.w.sx	%s28,0,%s0
 1316      80001C5A 
 1317              	# line 435
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 1318              		.loc	1 435 0
 1319 16d0 3C000000 		dldl.sx	%s36,60(,%s60)	# *(p).__b_N4conv6desc_tE.dw
 1319      BC00240B 
 1320 16d8 00000000 		adds.w.sx	%s0,1,%s36
 1320      A401004A 
 1321 16e0 00000000 		or	%s0,0,%s0
 1321      80000045 
 1322              	# line 431
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     const int iw = ow * SW - PW + kw * (p->dw + 1);
 1323              		.loc	1 431 0
 1324 16e8 00000000 		muls.l	%s0,4,%s0
 1324      8004006E 
 1325              	# line 435
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 1326              		.loc	1 435 0
 1327 16f0 14000000 		dldl.sx	%s24,20(,%s60)	# *(p).__b_N4conv6desc_tE.oc
 1327      BC00180B 
 1328 16f8 98FFFFFF 		st	%s0,-104(,%fp)	# spill 
 1328      89000011 
 1329 1700 00000000 		or	%s24,0,%s24
 1329      98001845 
 1330 1708 00000000 		or	%s34,0,%s24
 1330      98002245 
 1331 1710 20000000 		dldl.sx	%s0,32(,%s60)	# *(p).__b_N4conv6desc_tE.kh
 1331      BC00000B 
 1332 1718 00000000 		or	%s44,0,%s0
 1332      80002C45 
 1333 1720 24000000 		dldl.sx	%s0,36(,%s60)	# *(p).__b_N4conv6desc_tE.kw
 1333      BC00000B 
 1334 1728 00000000 		or	%s60,0,%s62
 1334      BE003C45 
 1335 1730 00000000 		or	%s62,0,%s4
 1335      84003E45 
 1336 1738 00000000 		or	%s43,0,%s0
 1336      80002B45 
 1337              	# line 305
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1338              		.loc	1 305 0
 1339 1740 00000000 		subs.w.sx	%s49,0,%s22
 1339      9600315A 
 1340              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1341              		.loc	1 306 0
 1342 1748 00000000 		subs.w.sx	%s33,0,%s53
 1342      B500215A 
 1343 1750 00000000 		or	%s53,0,%s23
 1343      97003545 
 1344 1758 40FDFFFF 		br.l	.L2.29
 1344      00000F18 
 1345              	.L2.12:
 1346              	# line 299
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int const OWs_EgeK = IW+PW+p->dw - KW*(p->dw+1); // fully const!
 1347              		.loc	1 299 0
 1348 1760 0C000000 		ldl.sx	%s63,12(,%s60)	# *(p).__b_N4conv6desc_tE.ih
 1348      BC003F03 
 1349 1768 30000000 		ldl.sx	%s61,48(,%s60)	# *(p).__b_N4conv6desc_tE.ph
 1349      BC003D03 
 1350 1770 00000000 		adds.w.sx	%s59,%s63,%s61
 1350      BDBF3B4A 
 1351 1778 38000000 		ldl.sx	%s58,56(,%s60)	# *(p).__b_N4conv6desc_tE.dh
 1351      BC003A03 
 1352 1780 00000000 		adds.w.sx	%s59,%s59,%s58
 1352      BABB3B4A 
 1353 1788 20000000 		ldl.sx	%s48,32(,%s60)	# *(p).__b_N4conv6desc_tE.kh
 1353      BC003003 
 1354 1790 00000000 		adds.w.sx	%s62,1,%s58
 1354      BA013E4A 
 1355 1798 00000000 		muls.w.sx	%s57,%s48,%s62
 1355      BEB0394B 
 1356 17a0 00000000 		subs.w.sx	%s57,%s59,%s57
 1356      B9BB395A 
 1357              	# line 300
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   OMP(parallel for collapse(5))//;
 1358              		.loc	1 300 0
 1359 17a8 10000000 		ldl.sx	%s56,16(,%s60)	# *(p).__b_N4conv6desc_tE.iw
 1359      BC003803 
 1360 17b0 34000000 		ldl.sx	%s59,52(,%s60)	# *(p).__b_N4conv6desc_tE.pw
 1360      BC003B03 
 1361 17b8 00000000 		adds.w.sx	%s55,%s56,%s59
 1361      BBB8374A 
 1362 17c0 3C000000 		ldl.sx	%s54,60(,%s60)	# *(p).__b_N4conv6desc_tE.dw
 1362      BC003603 
 1363 17c8 00000000 		adds.w.sx	%s55,%s55,%s54
 1363      B6B7374A 
 1364 17d0 00000000 		adds.w.sx	%s52,1,%s54
 1364      B601344A 
 1365 17d8 24000000 		ldl.sx	%s47,36(,%s60)	# *(p).__b_N4conv6desc_tE.kw
 1365      BC002F03 
 1366 17e0 00000000 		muls.w.sx	%s53,%s52,%s47
 1366      AFB4354B 
 1367 17e8 00000000 		subs.w.sx	%s53,%s55,%s53
 1367      B5B7355A 
 1368              	# line 302
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1369              		.loc	1 302 0
 1370 17f0 00000000 		ldl.sx	%s37,0(,%s60)	# *(p).__b_N4conv6desc_tE.g
 1370      BC002503 
 1371 17f8 B0FCFFFF 		brlt.w	0,%s37,.L2.68
 1371      A5008218 
 1372 1800 18EFFFFF 		br.l	.L2.27
 1372      00000F18 
 1373              	.L2.10:
 1374 1808 38000000 		lea	%s62,56
 1374      00003E06 
 1375              	# line 240
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 1376              		.loc	1 240 0
 1377 1810 00000000 		sll	%s63,%s63,%s62
 1377      BFBE3F65 
 1378 1818 38000000 		lea	%s62,56
 1378      00003E06 
 1379 1820 00000000 		sra.l	%s63,%s63,%s62
 1379      BFBE3F77 
 1380 1828 00000000 		or	%s63,0,%s63
 1380      BF003F45 
 1381 1830 00000000 		lea	%s62,.LP.__string.5@LO
 1381      00003E06 
 1382 1838 00000000 		and	%s62,%s62,(32)0
 1382      60BE3E44 
 1383 1840 00000000 		lea.sl	%s62,.LP.__string.5@HI(,%s62)
 1383      BE00BE06 
 1384 1848 00000000 		lea	%s61,.LP.__13_ref_conv5_cpp_202f7a29.0.__unnamed.0@LO
 1384      00003D06 
 1385 1850 00000000 		and	%s61,%s61,(32)0
 1385      60BD3D44 
 1386 1858 00000000 		lea.sl	%s61,.LP.__13_ref_conv5_cpp_202f7a29.0.__unnamed.0@HI(,%s61)
 1386      BD00BD06 
 1387 1860 00FFFFFF 		brne.w	0,%s63,.L2.12
 1387      BF008318 
 1388 1868 28EDFFFF 		br.l	.L2.11
 1388      00000F18 
 1389              	.L2.69:
 1390 1870 00000000 		or	%s63,1,(0)1
 1390      00013F45 
 1391 1878 90FFFFFF 		br.l	.L2.10
 1391      00000F18 
 1392              	.L2.70:
 1393 1880 2C000000 		ldl.sx	%s18,44(,%s60)	# *(p).__b_N4conv6desc_tE.sw
 1393      BC001203 
 1394 1888 E8FFFFFF 		brle.w	0,%s18,.L2.69
 1394      92008618 
 1395 1890 F0ECFFFF 		br.l	.L2.9
 1395      00000F18 
 1396              	.L2.8:
 1397 1898 28000000 		ldl.sx	%s18,40(,%s60)	# *(p).__b_N4conv6desc_tE.sh
 1397      BC001203 
 1398 18a0 E0FFFFFF 		brle.w	0,%s18,.L2.70
 1398      92008618 
 1399 18a8 D8ECFFFF 		br.l	.L2.9
 1399      00000F18 
 1400              	.L2.6:
 1401 18b0 38000000 		lea	%s62,56
 1401      00003E06 
 1402              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   MUST( SH >= 0 && SW >= 0 );
 1403              		.loc	1 239 0
 1404 18b8 00000000 		sll	%s63,%s63,%s62
 1404      BFBE3F65 
 1405 18c0 38000000 		lea	%s62,56
 1405      00003E06 
 1406 18c8 00000000 		sra.l	%s63,%s63,%s62
 1406      BFBE3F77 
 1407 18d0 00000000 		or	%s63,0,%s63
 1407      BF003F45 
 1408 18d8 00000000 		lea	%s62,.LP.__string.3@LO
 1408      00003E06 
 1409 18e0 00000000 		and	%s62,%s62,(32)0
 1409      60BE3E44 
 1410 18e8 00000000 		lea.sl	%s62,.LP.__string.3@HI(,%s62)
 1410      BE00BE06 
 1411 18f0 00000000 		lea	%s61,.LP.__13_ref_conv5_cpp_202f7a29.0.__unnamed.0@LO
 1411      00003D06 
 1412 18f8 00000000 		and	%s61,%s61,(32)0
 1412      60BD3D44 
 1413 1900 00000000 		lea.sl	%s61,.LP.__13_ref_conv5_cpp_202f7a29.0.__unnamed.0@HI(,%s61)
 1413      BD00BD06 
 1414 1908 90FFFFFF 		brne.w	0,%s63,.L2.8
 1414      BF008318 
 1415 1910 80EBFFFF 		br.l	.L2.7
 1415      00000F18 
 1416              	.L2.71:
 1417 1918 00000000 		or	%s63,1,(0)1
 1417      00013F45 
 1418 1920 90FFFFFF 		br.l	.L2.6
 1418      00000F18 
 1419              	.L2.72:
 1420 1928 3C000000 		ldl.sx	%s18,60(,%s60)	# *(p).__b_N4conv6desc_tE.dw
 1420      BC001203 
 1421 1930 E8FFFFFF 		brle.w	0,%s18,.L2.71
 1421      92008618 
 1422 1938 48EBFFFF 		br.l	.L2.5
 1422      00000F18 
 1423              	.L2.4:
 1424 1940 38000000 		ldl.sx	%s18,56(,%s60)	# *(p).__b_N4conv6desc_tE.dh
 1424      BC001203 
 1425 1948 E0FFFFFF 		brle.w	0,%s18,.L2.72
 1425      92008618 
 1426 1950 30EBFFFF 		br.l	.L2.5
 1426      00000F18 
 1427              	.L2.2:
 1428 1958 38000000 		lea	%s62,56
 1428      00003E06 
 1429              	# line 238
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 1430              		.loc	1 238 0
 1431 1960 00000000 		sll	%s63,%s63,%s62
 1431      BFBE3F65 
 1432 1968 38000000 		lea	%s62,56
 1432      00003E06 
 1433 1970 00000000 		sra.l	%s63,%s63,%s62
 1433      BFBE3F77 
 1434 1978 00000000 		or	%s63,0,%s63
 1434      BF003F45 
 1435 1980 00000000 		lea	%s62,.LP.__string.1@LO
 1435      00003E06 
 1436 1988 00000000 		and	%s62,%s62,(32)0
 1436      60BE3E44 
 1437 1990 00000000 		lea.sl	%s62,.LP.__string.1@HI(,%s62)
 1437      BE00BE06 
 1438 1998 00000000 		lea	%s61,.LP.__13_ref_conv5_cpp_202f7a29.0.__unnamed.0@LO
 1438      00003D06 
 1439 19a0 00000000 		and	%s61,%s61,(32)0
 1439      60BD3D44 
 1440 19a8 00000000 		lea.sl	%s61,.LP.__13_ref_conv5_cpp_202f7a29.0.__unnamed.0@HI(,%s61)
 1440      BD00BD06 
 1441 19b0 90FFFFFF 		brne.w	0,%s63,.L2.4
 1441      BF008318 
 1442 19b8 D8E9FFFF 		br.l	.L2.3
 1442      00000F18 
 1443              	.L2.73:
 1444 19c0 00000000 		or	%s63,1,(0)1
 1444      00013F45 
 1445 19c8 00000000 		or	%s60,0,%s0
 1445      80003C45 
 1446 19d0 88FFFFFF 		br.l	.L2.2
 1446      00000F18 
 1447              	.L2.0:
 1448 19d8 24000000 		ldl.sx	%s18,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 1448      80001203 
 1449 19e0 E0FFFFFF 		brlt.w	0,%s18,.L2.73
 1449      92008218 
 1450 19e8 90E9FFFF 		br.l	.L2.1
 1450      00000F18 
 1451              		.cfi_endproc
 1452              		.set	.L.3.2auto_size,	0xfffffffffffffa30	# 1488 Bytes
 1454              	# ============ End  conv::refconv_5_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 1455              	# ============ Begin  _ZN35_INTERNAL_13_ref_conv5_cpp_202f7a294conv23refconv_5_bwd_d_genericEPKNS0_
 1456              		.balign 16
 1457              	# line 510
 451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** inline the kernel.  original guesswork did not do dilation properly.
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \verbatim
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * **Problem**: Find the lowest khb >= kh_beg such that
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *          osh = ih+PH - khb*DH
 456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *      AND osh % SH == 0.            i.e. osh = j*SH
 457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *          (Then oh_beg = osh / SH)
 458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * Diophantine: solve for unknown integers k,j ...
 459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *    k*DH + j*SH = X,     where X = ih+PH
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * \endverbatim
 461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * - One solution is obtained via extendedEuclid Algorithm (outside of loops)
 462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * - First we quickly check for "no possible solutions"
 463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * - Then k is adjusted up to "just past zero"
 464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * - and if j*SH is too big, j is adjusted to "just below OH" (and k goes up)
 465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  *
 466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * Here is an unoptimized sketch of the calculation
 467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** \verbatim
 468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** // Calc based on Diophantine equation approach (not optimized)
 469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** int k = kh_end;
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // 1. Find one soln (any)
 473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     int const mul = (ih+PH) / gcd_h;
 474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     k = ha*mul;
 475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     int j = hb*mul;
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( k*DH + j*SH == X );
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // 2. Adjust to lowest k>=0
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     int const dk = SH/gcd_h;
 480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     int const dj = DH/gcd_h;
 481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     int m = (k<0? (-k+ dk -1) / dk
 482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           : k >= dk? - (k / dk)
 483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           : 0);
 484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if(m){
 485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         k += m * dk;
 486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         j -= m * dj;
 487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( k >= 0 && k < dk);
 489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( k*DH + j*SH == X ); // still have a soln
 490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // 3. Adjust j downwards st. j*SH < OH*SH (k can go up even more)
 492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if( j >= OH ){
 493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         m = (j-OH) / dj + 1;
 494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         k += m * dk;
 495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         j -= m * dj;
 496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         DMUST( j < OH );
 497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         DMUST( j >= OH - (DH/gcd_h) );
 498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         DMUST( k*DH + j*SH == X ); // still have a soln
 499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     DMUST( j*SH < OH*SH );
 501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** kh_beg = k;
 504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** \endverbatim
 505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * Discovering such formulas <em>by guesswork</em> did not work out
 506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * well for me at all !
 507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  */
 508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** static void refconv_5_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
 509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
 510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** {
 1458              		.loc	1 510 0
 1460              	_ZN35_INTERNAL_13_ref_conv5_cpp_202f7a294conv23refconv_5_bwd_d_genericEPKNS0_5prb_tER9dnn_mem_tS5_S
 1461              		.cfi_startproc
 1462 19f0 00000000 		st	%fp,0x0(,%sp)
 1462      8B000911 
 1463              		.cfi_def_cfa_offset	0
 1464              		.cfi_offset	9,0
 1465 19f8 08000000 		st	%lr,0x8(,%sp)
 1465      8B000A11 
 1466 1a00 18000000 		st	%got,0x18(,%sp)
 1466      8B000F11 
 1467 1a08 20000000 		st	%plt,0x20(,%sp)
 1467      8B001011 
 1468 1a10 00000000 		or	%fp,0,%sp
 1468      8B000945 
 1469              		.cfi_def_cfa_register	9
 1470 1a18 30000000 		st	%s18,48(,%fp)
 1470      89001211 
 1471 1a20 38000000 		st	%s19,56(,%fp)
 1471      89001311 
 1472 1a28 40000000 		st	%s20,64(,%fp)
 1472      89001411 
 1473 1a30 48000000 		st	%s21,72(,%fp)
 1473      89001511 
 1474 1a38 50000000 		st	%s22,80(,%fp)
 1474      89001611 
 1475 1a40 58000000 		st	%s23,88(,%fp)
 1475      89001711 
 1476 1a48 60000000 		st	%s24,96(,%fp)
 1476      89001811 
 1477 1a50 68000000 		st	%s25,104(,%fp)
 1477      89001911 
 1478 1a58 70000000 		st	%s26,112(,%fp)
 1478      89001A11 
 1479 1a60 78000000 		st	%s27,120(,%fp)
 1479      89001B11 
 1480 1a68 80000000 		st	%s28,128(,%fp)
 1480      89001C11 
 1481 1a70 88000000 		st	%s29,136(,%fp)
 1481      89001D11 
 1482 1a78 90000000 		st	%s30,144(,%fp)
 1482      89001E11 
 1483 1a80 98000000 		st	%s31,152(,%fp)
 1483      89001F11 
 1484 1a88 A0000000 		st	%s32,160(,%fp)
 1484      89002011 
 1485 1a90 A8000000 		st	%s33,168(,%fp)
 1485      89002111 
 1486 1a98 E0FBFFFF 		lea	%s13,.L.4.2auto_size&0xffffffff
 1486      00000D06 
 1487 1aa0 00000000 		and	%s13,%s13,(32)0
 1487      608D0D44 
 1488 1aa8 FFFFFFFF 		lea.sl	%sp,.L.4.2auto_size>>32(%fp,%s13)
 1488      8D898B06 
 1489 1ab0 48000000 		brge.l.t	%sp,%sl,.L3.EoP
 1489      888B3518 
 1490 1ab8 18000000 		ld	%s61,0x18(,%tp)
 1490      8E003D01 
 1491 1ac0 00000000 		or	%s62,0,%s0
 1491      80003E45 
 1492 1ac8 3B010000 		lea	%s63,0x13b
 1492      00003F06 
 1493 1ad0 00000000 		shm.l	%s63,0x0(%s61)
 1493      BD033F31 
 1494 1ad8 08000000 		shm.l	%sl,0x8(%s61)
 1494      BD030831 
 1495 1ae0 10000000 		shm.l	%sp,0x10(%s61)
 1495      BD030B31 
 1496 1ae8 00000000 		monc
 1496      0000003F 
 1497 1af0 00000000 		or	%s0,0,%s62
 1497      BE000045 
 1498              	.L3.EoP:
 1499              	# End of prologue codes
 1500              	# line 511
 511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int const DH = p->dh + 1;
 1501              		.loc	1 511 0
 1502 1af8 38000000 		ldl.sx	%s62,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 1502      80003E03 
 1503 1b00 00000000 		adds.w.sx	%s6,1,%s62
 1503      BE01064A 
 1504 1b08 00000000 		or	%s63,0,%s6
 1504      86003F45 
 1505              	# line 514
 512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int ha, hb, hg;
 514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
 1506              		.loc	1 514 0
 1507 1b10 00000000 		or	%s61,1,(0)1
 1507      00013D45 
 1508 1b18 00000000 		or	%s21,1,(0)1
 1508      00011545 
 1509 1b20 28000000 		ldl.sx	%s23,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 1509      80001703 
 1510 1b28 00000000 		or	%s60,0,(0)1
 1510      00003C45 
 1511 1b30 00000000 		or	%s22,0,(0)1
 1511      00001645 
 1512 1b38 20110000 		brne.w	0,%s6,.L3.0
 1512      86008318 
 1513 1b40 10100000 		br.l	.L3.1
 1513      00000F18 
 1514              	.L3.2:
 1515              	# line 658
 515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int gcd_h = hg;                 // = gcd( SH, DH );
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int lcm_h = SH * DH/gcd_h;      // lcm( SH, DH ) = SH*DH / gcd(SH,DH)
 517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int khh = SH / gcd_h;           // = lcm_h / DH;
 518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int jhh = lcm_h / SH;
 520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   DMUST( hg == gcd_h );
 522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int DW = p->dw + 1;
 523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   int wa, wb, wg;
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   extendedEuclid( wa, DW, wb, SW, wg); // DMUST( wg == gcd_w );
 526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int gcd_w = wg;                // = gcd( SW, DW );
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int lcm_w = SW * DW/gcd_w; // = lcm( SW, DW ) = SW*DW/gcd_w;
 528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int kww = SW / gcd_w;      // = lcm_w / DW;
 529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int jww = DW / gcd_w;      // = lcm_w / SW
 530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0 // shorten, do same for kw,ow loop. tweaks to kh calc
 532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   OMP(omp parallel for collapse(5))//;
 533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   for (int g = 0; g < G; ++g) {
 534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           // calc kh_beg, kh_end here? 4.28x
 538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             ds = 0;
 542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_end = (ih + PH) / DH + 1;
 544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kh_end > KH) kh_end = KH;
 545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_beg = kh_end;
 546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               // 1. Find one soln (any)
 548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int const mul = (ih+PH) / gcd_h;
 549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kh_beg = ha*mul;
 550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int j = hb*mul;
 551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               // 2. Adjust to lowest kh_beg>=0
 552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0 // ok
 553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = (kh_beg<0? (-kh_beg+ khh -1) / khh
 554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   : kh_beg >= khh? - (kh_beg / khh)
 555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   : 0);
 556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               RT_ASSERT( kh_beg + m*khh == rem_floor( kh_beg, khh ) ); // adjust kh_beg in khh-step
 557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               RT_ASSERT( m == (rem_floor(kh_beg,khh) - kh_beg) / khh ); // y
 558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               RT_ASSERT( m == - div_floor(kh_beg,khh) ); // y
 559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if(m){
 560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   kh_beg += m * khh;
 561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   j -= m * jhh;
 562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 0 // ok
 564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int k2 = rem_floor( kh_beg, khh );
 565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = (k2-kh_beg) / khh;
 566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kh_beg = k2;
 567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               j -= m * jhh;
 568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 1 // ok
 569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = div_floor(kh_beg, khh);
 570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kh_beg -= m * khh;
 571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               j      += m * jhh;
 572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               // 3. Adjust j downwards st. j*SH < OH*SH (kh_beg can go up even more)
 574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if( j >= OH ){
 575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 m = (j-OH) / jhh + 1;
 576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 kh_beg += m * khh;
 577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //j      -= m * jhh; // not needed
 578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_beg >= kh_end ) continue;
 581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0
 582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_beg, /*ow_beg,*/ kw_end;
 583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_end = (iw + PW) / (p->dw+1) + 1;
 584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kw_end > KW) kw_end = KW;
 585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kw_beg = div_floor( (iw + PW) - OW*SW, p->dw+1) + 1;
 586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kw_beg < 0    ) kw_beg = 0;
 587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             { // jump kw_beg up to 1st non-skipped index
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int owxsw = iw+PW - kw_beg * (p->dw+1);
 589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (owxsw % SW){
 590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 do {
 591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   ++kw_beg;
 592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   owxsw = iw+PW - kw_beg * (p->dw+1);
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 } while( owxsw % SW != 0 && kw_beg < kw_end );
 594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 DMUST( kw_beg >= kw_end || (iw+PW - kw_beg * (p->dw+1)) % SW == 0 );
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             DMUST( kw_beg >= 0 );
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_end = (iw + PW) / DW + 1;
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kw_end > KW) kw_end = KW;
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_beg = kw_end;
 602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int const mul = (iw+PW) / gcd_w;
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_beg = wa*mul;
 605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               //int j = wb*mul;
 606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = div_floor(kw_beg, kww);
 607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_beg -= m * kww;
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int j = wb * mul + m * jww;
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if( j >= OW ){
 610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 m = (j-OW) / jww + 1;
 611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 kw_beg += m * kww;
 612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //j -= m * jww; // not needed
 613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_beg >= kw_end ) continue;
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oc = 0; oc < OC/G; ++oc) {
 619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   kh < kh_end;
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   oh0 -= lcm_h, kh += khh)
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               {
 623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     ow0 -= lcm_w, kw += kww)
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 {
 627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   ds += ((float*)diff_dst_m)[dst_off]
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 1 // clean up
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   OMP(omp parallel for collapse(5))//;
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   for (int g = 0; g < G; ++g) {
 643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           // calc kh_beg, kh_end here? 4.28x
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             ds = 0;
 651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_end = (ih + PH) / DH + 1;
 653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kh_end > KH) kh_end = KH;
 654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_beg = kh_end;
 655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int const mul = (ih+PH) / gcd_h;
 657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kh_beg = ha*mul;
 658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = div_floor(kh_beg, khh);
 1516              		.loc	1 658 0
 1517 1b48 00000000 		or	%s50,0,(0)1
 1517      00003245 
 1518 1b50 180A0000 		br.l	.L3.3
 1518      00000F18 
 1519              	.L3.4:
 1520              	# line 671
 659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kh_beg -= m * khh;
 660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
 661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
 662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kh_beg >= kh_end ) continue;
 664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_end = (iw + PW) / DW + 1;
 666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kw_end > KW) kw_end = KW;
 667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_beg = kw_end;
 668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
 669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int const mul = (iw+PW) / gcd_w;
 670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_beg = wa * mul;
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = div_floor(kw_beg, kww);
 1521              		.loc	1 671 0
 1522 1b58 00000000 		or	%s6,0,(0)1
 1522      00000645 
 1523 1b60 00000000 		or	%s5,0,%s49
 1523      B1000545 
 1524 1b68 00000000 		or	%s49,0,%s50
 1524      B2003145 
 1525 1b70 F0050000 		br.l	.L3.5
 1525      00000F18 
 1526              	.L3.6:
 1527              	# line 683
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_beg -= m * kww;
 673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int j = wb * mul + m * jww;
 674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (j >= OW) kw_beg += (j-OW)/jww * kww + kww;
 675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_beg >= kw_end ) continue;
 677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oc = 0; oc < OC/G; ++oc) {
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   kh < kh_end;
 681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   oh0 -= lcm_h, kh += khh)
 682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               {
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
 1528              		.loc	1 683 0
 1529 1b78 80000000 		mins.w.sx	%s62,%s54,%s62
 1529      BEB63E78 
 1530 1b80 B8010000 		br.l	.L3.7
 1530      00000F18 
 1531              	.L3.8:
 1532 1b88 78FFFFFF 		st	%s1,-136(,%fp)	# spill 
 1532      89000111 
 1533 1b90 B8FFFFFF 		ld	%s63,-72(,%fp)	# restore 
 1533      89003F01 
 1534 1b98 00000000 		or	%s20,0,%s21
 1534      95001445 
 1535 1ba0 C0FFFFFF 		ld	%s58,-64(,%fp)	# restore 
 1535      89003A01 
 1536 1ba8 00000000 		or	%s42,0,%s22
 1536      96002A45 
 1537 1bb0 A0FFFFFF 		ld	%s56,-96(,%fp)	# restore 
 1537      89003801 
 1538 1bb8 00000000 		or	%s32,0,%s23
 1538      97002045 
 1539 1bc0 B0FFFFFF 		ld	%s30,-80(,%fp)	# restore 
 1539      89001E01 
 1540 1bc8 F8FFFFFF 		ld	%s52,-8(,%fp)	# restore 
 1540      89003401 
 1541 1bd0 A8FFFFFF 		ld	%s31,-88(,%fp)	# restore 
 1541      89001F01 
 1542 1bd8 98FFFFFF 		ld	%s61,-104(,%fp)	# restore 
 1542      89003D01 
 1543 1be0 88FFFFFF 		ld	%s4,-120(,%fp)	# restore 
 1543      89000401 
 1544 1be8 F0FFFFFF 		ld	%s51,-16(,%fp)	# restore 
 1544      89003301 
 1545 1bf0 80FFFFFF 		ld	%s3,-128(,%fp)	# restore 
 1545      89000301 
 1546 1bf8 E8FFFFFF 		ld	%s55,-24(,%fp)	# restore 
 1546      89003701 
 1547 1c00 E0FFFFFF 		ld	%s46,-32(,%fp)	# restore 
 1547      89002E01 
 1548 1c08 D8FFFFFF 		ld	%s28,-40(,%fp)	# restore 
 1548      89001C01 
 1549 1c10 D0FFFFFF 		ld	%s7,-48(,%fp)	# restore 
 1549      89000701 
 1550 1c18 C8FFFFFF 		ld	%s47,-56(,%fp)	# restore 
 1550      89002F01 
 1551 1c20 90FFFFFF 		ld	%s59,-112(,%fp)	# restore 
 1551      89003B01 
 1552 1c28 C0080000 		br.l	.L3.9
 1552      00000F18 
 1553              	.L3.10:
 1554              	# line 678
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 1555              		.loc	1 678 0
 1556 1c30 00000000 		adds.w.sx	%s55,1,%s55
 1556      B701374A 
 1557 1c38 00000000 		adds.w.sx	%s53,1,%s53
 1557      B501354A 
 1558 1c40 68030000 		brgt.w	0,%s55,.L3.11
 1558      B7008118 
 1559 1c48 40FFFFFF 		br.l	.L3.8
 1559      00000F18 
 1560              	.L3.12:
 1561 1c50 00000000 		or	%s55,0,%s4
 1561      84003745 
 1562 1c58 00000000 		or	%s53,0,%s20
 1562      94003545 
 1563 1c60 00000000 		or	%s18,0,%s5
 1563      85001245 
 1564 1c68 00000000 		or	%s58,0,%s3
 1564      83003A45 
 1565 1c70 C0FFFFFF 		br.l	.L3.10
 1565      00000F18 
 1566              	.L3.13:
 1567              	# line 692
 684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     ow0 -= lcm_w, kw += kww)
 686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 {
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   ds += ((float*)diff_dst_m)[dst_off]
 690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 1568              		.loc	1 692 0
 1569 1c78 00000000 		subs.w.sx	%s63,%s63,%s62
 1569      BEBF3F5A 
 1570              	# line 679
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   kh < kh_end;
 1571              		.loc	1 679 0
 1572 1c80 00000000 		adds.w.sx	%s58,%s60,%s58
 1572      BABC3A4A 
 1573 1c88 00000000 		adds.w.sx	%s56,%s56,%s60
 1573      BCB8384A 
 1574 1c90 B8020000 		brgt.w	0,%s58,.L3.14
 1574      BA008118 
 1575 1c98 B8FFFFFF 		br.l	.L3.12
 1575      00000F18 
 1576              	.L3.15:
 1577              	# line 691
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 1578              		.loc	1 691 0
 1579 1ca0 00000000 		or	%s61,1,(0)1
 1579      00013D45 
 1580 1ca8 00000000 		or	%s59,0,%s54
 1580      B6003B45 
 1581 1cb0 00000000 		lvl	%s61
 1581      00BD00BF 
 1582 1cb8 00000036 		vstu.nc	%v54,0,%s59
 1582      BB000092 
 1583 1cc0 B8FFFFFF 		br.l	.L3.13
 1583      00000F18 
 1584              	.L3.16:
 1585 1cc8 00000000 		or	%s1,0,%s59
 1585      BB000145 
 1586 1cd0 00000000 		or	%s2,0,%s61
 1586      BD000245 
 1587              	# line 689
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 1588              		.loc	1 689 0
 1589 1cd8 00000000 		lvl	%s52
 1589      00B400BF 
 1590 1ce0 00003D35 		vfsum.s	%v53,%v61
 1590      000080EC 
 1591 1ce8 00000000 		or	%s61,1,(0)1
 1591      00013D45 
 1592 1cf0 00000000 		lvl	%s61
 1592      00BD00BF 
 1593 1cf8 00353636 		vfadd.s	%v54,%v54,%v53
 1593      000080CC 
 1594 1d00 00000000 		or	%s63,0,%s51
 1594      B3003F45 
 1595 1d08 00000000 		or	%s62,0,%s50
 1595      B2003E45 
 1596 1d10 00000000 		or	%s60,0,%s49
 1596      B1003C45 
 1597 1d18 00000000 		or	%s58,0,%s48
 1597      B0003A45 
 1598 1d20 00000000 		or	%s56,0,%s47
 1598      AF003845 
 1599 1d28 00000000 		or	%s54,0,%s46
 1599      AE003645 
 1600 1d30 70FFFFFF 		br.l	.L3.15
 1600      00000F18 
 1601              	.L3.7:
 1602 1d38 00000000 		lvl	%s62
 1602      00BE00BF 
 1603 1d40 003F003E 		vadds.w.sx	%v62,%s63,%v63
 1603      00BF20CA 
 1604 1d48 00003E3C 		vdivs.w.sx	%v60,%v62,%s61
 1604      00BD10EB 
 1605 1d50 003C003B 		vor	%v59,(0)1,%v60
 1605      000020C5 
 1606 1d58 003B003A 		vaddu.l	%v58,%s60,%v59
 1606      00BC20C8 
 1607 1d60 003A0039 		vsfa	%v57,%v58,2,%s59
 1607      BB0200D7 
 1608 1d68 00003938 		vgtu	%v56,%v57,0,0
 1608      000040A2 
 1609 1d70 00000000 		or	%s53,0,%s58
 1609      BA003545 
 1610 1d78 00000037 		vldu.nc	%v55,%s57,%s53
 1610      B5B90082 
 1611 1d80 38373D3D 		vfmad.s	%v61,%v61,%v55,%v56
 1611      000080E2 
 1612              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 1613              		.loc	1 683 0
 1614 1d88 00000000 		adds.w.sx	%s63,%s63,%s56
 1614      B8BF3F4A 
 1615 1d90 00000000 		adds.l	%s58,%s58,%s55
 1615      B7BA3A59 
 1616 1d98 00000000 		subs.w.sx	%s54,%s54,%s62
 1616      BEB6365A 
 1617 1da0 28FFFFFF 		brge.w	0,%s54,.L3.16
 1617      B6008518 
 1618 1da8 D0FDFFFF 		br.l	.L3.6
 1618      00000F18 
 1619              	.L3.17:
 1620              	# line 689
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 1621              		.loc	1 689 0
 1622 1db0 00000000 		divs.w.sx	%s53,%s45,%s44
 1622      ACAD357B 
 1623 1db8 00000000 		or	%s61,0,%s2
 1623      82003D45 
 1624 1dc0 00000000 		or	%s59,0,%s1
 1624      81003B45 
 1625 1dc8 00000000 		or	%s51,0,%s63
 1625      BF003345 
 1626 1dd0 00000000 		or	%s47,0,%s56
 1626      B8002F45 
 1627 1dd8 00000000 		or	%s49,0,%s60
 1627      BC003145 
 1628 1de0 00000000 		or	%s50,0,%s62
 1628      BE003245 
 1629 1de8 00000000 		or	%s48,0,%s58
 1629      BA003045 
 1630 1df0 00000000 		or	%s46,0,%s54
 1630      B6002E45 
 1631 1df8 00000000 		or	%s53,0,%s53
 1631      B5003545 
 1632 1e00 00000000 		addu.l	%s53,%s53,%s43
 1632      ABB53548 
 1633 1e08 00000000 		addu.l	%s53,%s53,%s42
 1633      AAB53548 
 1634 1e10 00000000 		mulu.l	%s53,%s53,%s41
 1634      A9B53549 
 1635 1e18 00000000 		divu.l	%s7,%s40,%s39
 1635      A7A8076F 
 1636 1e20 00000000 		addu.l	%s7,%s42,%s7
 1636      87AA0748 
 1637 1e28 00000000 		mulu.l	%s7,%s7,%s38
 1637      A6870749 
 1638 1e30 00000000 		divu.l	%s7,%s7,%s39
 1638      A787076F 
 1639 1e38 00000000 		addu.l	%s7,%s7,%s37
 1639      A5870748 
 1640 1e40 00000000 		mulu.l	%s7,%s7,%s36
 1640      A4870749 
 1641 1e48 00000000 		divs.w.sx	%s6,%s63,%s35
 1641      A3BF067B 
 1642 1e50 00000000 		or	%s6,0,%s6
 1642      86000645 
 1643 1e58 00000000 		addu.l	%s6,%s53,%s6
 1643      86B50648 
 1644 1e60 00000000 		mulu.l	%s60,%s6,%s34
 1644      A2863C49 
 1645 1e68 00000000 		or	%s53,0,%s56
 1645      B8003545 
 1646 1e70 00000000 		addu.l	%s53,%s7,%s53
 1646      B5873548 
 1647 1e78 00000000 		mulu.l	%s53,%s53,%s33
 1647      A1B53549 
 1648 1e80 00000000 		or	%s53,0,%s53
 1648      B5003545 
 1649              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 1650              		.loc	1 683 0
 1651 1e88 00000000 		muls.l	%s53,4,%s53
 1651      B504356E 
 1652 1e90 00000000 		adds.l	%s53,%s53,%s32
 1652      A0B53559 
 1653 1e98 00000000 		subs.w.sx	%s7,0,%s31
 1653      9F00075A 
 1654 1ea0 00000000 		smvl	%s52
 1654      0000342E 
 1655 1ea8 80000000 		mins.w.sx	%s62,%s7,%s52
 1655      B4873E78 
 1656              	# line 689
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 1657              		.loc	1 689 0
 1658 1eb0 00000000 		or	%s6,0,(0)1
 1658      00000645 
 1659 1eb8 00000000 		lvl	%s52
 1659      00B400BF 
 1660 1ec0 0000003D 		vbrdu	%v61,%s6
 1660      0086808C 
 1661 1ec8 00000000 		or	%s54,0,%s7
 1661      87003645 
 1662 1ed0 00000000 		or	%s7,0,%s62
 1662      BE000745 
 1663 1ed8 00000000 		or	%s63,0,%s30
 1663      9E003F45 
 1664              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 1665              		.loc	1 683 0
 1666 1ee0 00000000 		muls.w.sx	%s56,%s29,%s62
 1666      BE9D384B 
 1667 1ee8 00000000 		lvl	%s62
 1667      00BE00BF 
 1668 1ef0 00000034 		vseq	%v52
 1668      00000099 
 1669 1ef8 0034003F 		vmuls.w.sx	%v63,%s29,%v52
 1669      009D20CB 
 1670 1f00 00000000 		or	%s58,0,%s53
 1670      B5003A45 
 1671 1f08 00000000 		muls.l	%s55,%s57,%s7
 1671      87B9376E 
 1672 1f10 28FEFFFF 		br.l	.L3.7
 1672      00000F18 
 1673              	.L3.18:
 1674 1f18 00000000 		or	%s55,1,(0)1
 1674      00013745 
 1675 1f20 00000000 		or	%s53,0,%s54
 1675      B6003545 
 1676 1f28 00000000 		lvl	%s55
 1676      00B700BF 
 1677 1f30 00000036 		vldu.nc	%v54,0,%s53
 1677      B5000082 
 1678 1f38 78FEFFFF 		brlt.w	0,%s18,.L3.17
 1678      92008218 
 1679 1f40 60FDFFFF 		br.l	.L3.15
 1679      00000F18 
 1680              	.L3.14:
 1681 1f48 D0FFFFFF 		brlt.w	0,%s18,.L3.18
 1681      92008218 
 1682 1f50 28FDFFFF 		br.l	.L3.13
 1682      00000F18 
 1683              	.L3.19:
 1684 1f58 00000000 		divs.w.sx	%s61,%s28,%s27
 1684      9B9C3D7B 
 1685 1f60 00000000 		or	%s3,0,%s58
 1685      BA000345 
 1686 1f68 00000000 		or	%s4,0,%s55
 1686      B7000445 
 1687 1f70 00000000 		or	%s5,0,%s18
 1687      92000545 
 1688 1f78 00000000 		or	%s20,0,%s53
 1688      B5001445 
 1689 1f80 00000000 		subs.w.sx	%s31,0,%s61
 1689      BD001F5A 
 1690 1f88 00000000 		or	%s42,0,%s53
 1690      B5002A45 
 1691              	# line 679
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   kh < kh_end;
 1692              		.loc	1 679 0
 1693 1f90 00000000 		adds.w.sx	%s58,%s18,%s26
 1693      9A923A4A 
 1694 1f98 00000000 		or	%s18,0,%s61
 1694      BD001245 
 1695 1fa0 A8FFFFFF 		br.l	.L3.14
 1695      00000F18 
 1696              	.L3.11:
 1697 1fa8 00000000 		or	%s56,0,%s18
 1697      92003845 
 1698 1fb0 00000000 		or	%s63,0,%s58
 1698      BA003F45 
 1699 1fb8 A0FFFFFF 		brlt.w	%s18,%s19,.L3.19
 1699      93928218 
 1700 1fc0 70FCFFFF 		br.l	.L3.10
 1700      00000F18 
 1701              	.L3.20:
 1702 1fc8 F8FFFFFF 		st	%s52,-8(,%fp)	# spill 
 1702      89003411 
 1703 1fd0 F0FFFFFF 		st	%s51,-16(,%fp)	# spill 
 1703      89003311 
 1704 1fd8 E8FFFFFF 		st	%s55,-24(,%fp)	# spill 
 1704      89003711 
 1705 1fe0 E0FFFFFF 		st	%s46,-32(,%fp)	# spill 
 1705      89002E11 
 1706 1fe8 D8FFFFFF 		st	%s28,-40(,%fp)	# spill 
 1706      89001C11 
 1707 1ff0 D0FFFFFF 		st	%s7,-48(,%fp)	# spill 
 1707      89000711 
 1708 1ff8 C8FFFFFF 		st	%s47,-56(,%fp)	# spill 
 1708      89002F11 
 1709 2000 C0FFFFFF 		st	%s58,-64(,%fp)	# spill 
 1709      89003A11 
 1710 2008 B8FFFFFF 		st	%s63,-72(,%fp)	# spill 
 1710      89003F11 
 1711 2010 B0FFFFFF 		st	%s30,-80(,%fp)	# spill 
 1711      89001E11 
 1712 2018 A8FFFFFF 		st	%s31,-88(,%fp)	# spill 
 1712      89001F11 
 1713 2020 A0FFFFFF 		st	%s56,-96(,%fp)	# spill 
 1713      89003811 
 1714 2028 98FFFFFF 		st	%s61,-104(,%fp)	# spill 
 1714      89003D11 
 1715 2030 90FFFFFF 		st	%s59,-112(,%fp)	# spill 
 1715      89003B11 
 1716 2038 88FFFFFF 		st	%s4,-120(,%fp)	# spill 
 1716      89000411 
 1717 2040 80FFFFFF 		st	%s3,-128(,%fp)	# spill 
 1717      89000311 
 1718 2048 00000000 		muls.w.sx	%s61,%s18,%s61
 1718      BD923D4B 
 1719 2050 00000000 		or	%s21,0,%s20
 1719      94001545 
 1720 2058 00000000 		or	%s22,0,%s42
 1720      AA001645 
 1721 2060 00000000 		subs.w.sx	%s58,%s59,%s61
 1721      BDBB3A5A 
 1722 2068 00000000 		or	%s63,0,%s50
 1722      B2003F45 
 1723              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 1724              		.loc	1 683 0
 1725 2070 00000000 		muls.w.sx	%s4,%s50,%s4
 1725      84B2044B 
 1726 2078 00000000 		or	%s23,0,%s32
 1726      A0001745 
 1727 2080 00000000 		subs.w.sx	%s4,%s56,%s4
 1727      84B8045A 
 1728 2088 00000000 		adds.w.sx	%s61,-1,%s53
 1728      B57F3D4A 
 1729 2090 00000000 		or	%s53,0,%s49
 1729      B1003545 
 1730 2098 00000000 		subs.w.sx	%s50,%s61,%s50
 1730      B2BD325A 
 1731 20a0 00000000 		adds.w.sx	%s28,%s50,%s27
 1731      9BB21C4A 
 1732              	# line 678
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 1733              		.loc	1 678 0
 1734 20a8 00000000 		divs.w.sx	%s31,%s31,%s30
 1734      9E9F1F7B 
 1735 20b0 00000000 		or	%s30,0,%s4
 1735      84001E45 
 1736 20b8 00000000 		subs.w.sx	%s31,0,%s31
 1736      9F001F5A 
 1737 20c0 00000000 		or	%s55,0,%s31
 1737      9F003745 
 1738              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 1739              		.loc	1 683 0
 1740 20c8 00000000 		muls.l	%s63,4,%s63
 1740      BF043F6E 
 1741 20d0 00000000 		adds.l	%s32,%s63,%s3
 1741      83BF2059 
 1742 20d8 78FFFFFF 		ld	%s1,-136(,%fp)	# restore 
 1742      89000101 
 1743 20e0 C8FEFFFF 		br.l	.L3.11
 1743      00000F18 
 1744              	.L3.21:
 1745              	# line 678
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 1746              		.loc	1 678 0
 1747 20e8 00000000 		or	%s49,0,(0)1
 1747      00003145 
 1748 20f0 00000000 		divs.w.sx	%s21,%s31,%s30
 1748      9E9F157B 
 1749 20f8 00000000 		or	%s63,0,%s1
 1749      81003F45 
 1750 2100 C8FEFFFF 		brlt.w	0,%s21,.L3.20
 1750      95008218 
 1751 2108 E0030000 		br.l	.L3.9
 1751      00000F18 
 1752              	.L3.22:
 1753 2110 00000000 		or	%s63,0,%s1
 1753      81003F45 
 1754 2118 D0030000 		br.l	.L3.9
 1754      00000F18 
 1755              	.L3.23:
 1756 2120 F0FFFFFF 		brge.w	%s50,%s53,.L3.22
 1756      B5B28518 
 1757 2128 C0FFFFFF 		br.l	.L3.21
 1757      00000F18 
 1758              	.L3.24:
 1759              	# line 674
 674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 1760              		.loc	1 674 0
 1761 2130 00000000 		subs.w.sx	%s6,%s6,%s24
 1761      9886065A 
 1762 2138 00000000 		divs.w.sx	%s6,%s6,%s25
 1762      9986067B 
 1763 2140 00000000 		muls.w.sx	%s6,%s27,%s6
 1763      869B064B 
 1764 2148 00000000 		adds.w.sx	%s6,%s27,%s6
 1764      869B064A 
 1765 2150 00000000 		adds.w.sx	%s50,%s50,%s6
 1765      86B2324A 
 1766 2158 C8FFFFFF 		br.l	.L3.23
 1766      00000F18 
 1767              	.L3.5:
 1768              	# line 671
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_beg -= m * kww;
 1769              		.loc	1 671 0
 1770 2160 00000000 		divs.w.sx	%s48,%s49,%s27
 1770      9BB1307B 
 1771 2168 00000000 		subs.w.sx	%s6,%s48,%s6
 1771      86B0065A 
 1772              	# line 672
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int j = wb * mul + m * jww;
 1773              		.loc	1 672 0
 1774 2170 00000000 		muls.w.sx	%s48,%s27,%s6
 1774      869B304B 
 1775 2178 00000000 		subs.w.sx	%s50,%s49,%s48
 1775      B0B1325A 
 1776              	# line 673
 673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (j >= OW) kw_beg += (j-OW)/jww * kww + kww;
 1777              		.loc	1 673 0
 1778 2180 00000000 		muls.w.sx	%s5,%s28,%s5
 1778      859C054B 
 1779 2188 00000000 		muls.w.sx	%s6,%s6,%s25
 1779      9986064B 
 1780 2190 00000000 		adds.w.sx	%s6,%s5,%s6
 1780      8685064A 
 1781 2198 98FFFFFF 		brge.w	%s6,%s24,.L3.24
 1781      98868518 
 1782 21a0 80FFFFFF 		br.l	.L3.23
 1782      00000F18 
 1783              	.L3.25:
 1784              	# line 671
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_beg -= m * kww;
 1785              		.loc	1 671 0
 1786 21a8 00000000 		or	%s6,1,(0)1
 1786      00010645 
 1787 21b0 00000000 		or	%s5,0,%s49
 1787      B1000545 
 1788 21b8 00000000 		or	%s49,0,%s50
 1788      B2003145 
 1789 21c0 A0FFFFFF 		br.l	.L3.5
 1789      00000F18 
 1790              	.L3.26:
 1791              	# line 670
 670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = div_floor(kw_beg, kww);
 1792              		.loc	1 670 0
 1793 21c8 00000000 		muls.w.sx	%s50,%s49,%s7
 1793      87B1324B 
 1794              	# line 671
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_beg -= m * kww;
 1795              		.loc	1 671 0
 1796 21d0 00000000 		divs.w.sx	%s48,%s50,%s27
 1796      9BB2307B 
 1797 21d8 00000000 		muls.w.sx	%s48,%s27,%s48
 1797      B09B304B 
 1798 21e0 00000000 		subs.w.sx	%s48,%s50,%s48
 1798      B0B2305A 
 1799 21e8 C0FFFFFF 		brgt.w	0,%s48,.L3.25
 1799      B0008118 
 1800 21f0 68F9FFFF 		br.l	.L3.4
 1800      00000F18 
 1801              	.L3.27:
 1802              	# line 665
 665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kw_end > KW) kw_end = KW;
 1803              		.loc	1 665 0
 1804 21f8 00000000 		divs.w.sx	%s53,%s58,%s55
 1804      B7BA357B 
 1805 2200 00000000 		adds.w.sx	%s53,1,%s53
 1805      B501354A 
 1806              	# line 666
 666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_beg = kw_end;
 1807              		.loc	1 666 0
 1808 2208 80000000 		mins.w.sx	%s53,%s53,%s52
 1808      B4B53578 
 1809 2210 00000000 		or	%s50,0,%s53
 1809      B5003245 
 1810              	# line 668
 668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int const mul = (iw+PW) / gcd_w;
 1811              		.loc	1 668 0
 1812 2218 00000000 		divs.w.sx	%s49,%s58,%s51
 1812      B3BA317B 
 1813 2220 00000000 		muls.w.sx	%s48,%s51,%s49
 1813      B1B3304B 
 1814 2228 00000000 		subs.w.sx	%s48,%s58,%s48
 1814      B0BA305A 
 1815 2230 98FFFFFF 		breq.w	0,%s48,.L3.26
 1815      B0008418 
 1816 2238 E8FEFFFF 		br.l	.L3.23
 1816      00000F18 
 1817              	.L3.28:
 1818              	# line 703
 693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #error "select one"
 702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 1819              		.loc	1 703 0
 1820              	# Start of epilogue codes
 1821 2240 30000000 		ld	%s18,48(,%fp)
 1821      89001201 
 1822 2248 38000000 		ld	%s19,56(,%fp)
 1822      89001301 
 1823 2250 40000000 		ld	%s20,64(,%fp)
 1823      89001401 
 1824 2258 48000000 		ld	%s21,72(,%fp)
 1824      89001501 
 1825 2260 50000000 		ld	%s22,80(,%fp)
 1825      89001601 
 1826 2268 58000000 		ld	%s23,88(,%fp)
 1826      89001701 
 1827 2270 60000000 		ld	%s24,96(,%fp)
 1827      89001801 
 1828 2278 68000000 		ld	%s25,104(,%fp)
 1828      89001901 
 1829 2280 70000000 		ld	%s26,112(,%fp)
 1829      89001A01 
 1830 2288 78000000 		ld	%s27,120(,%fp)
 1830      89001B01 
 1831 2290 80000000 		ld	%s28,128(,%fp)
 1831      89001C01 
 1832 2298 88000000 		ld	%s29,136(,%fp)
 1832      89001D01 
 1833 22a0 90000000 		ld	%s30,144(,%fp)
 1833      89001E01 
 1834 22a8 98000000 		ld	%s31,152(,%fp)
 1834      89001F01 
 1835 22b0 A0000000 		ld	%s32,160(,%fp)
 1835      89002001 
 1836 22b8 A8000000 		ld	%s33,168(,%fp)
 1836      89002101 
 1837 22c0 00000000 		or	%sp,0,%fp
 1837      89000B45 
 1838              		.cfi_def_cfa	11,8
 1839 22c8 18000000 		ld	%got,0x18(,%sp)
 1839      8B000F01 
 1840 22d0 20000000 		ld	%plt,0x20(,%sp)
 1840      8B001001 
 1841 22d8 08000000 		ld	%lr,0x8(,%sp)
 1841      8B000A01 
 1842 22e0 00000000 		ld	%fp,0x0(,%sp)
 1842      8B000901 
 1843 22e8 00000000 		b.l	(,%lr)
 1843      8A000F19 
 1844              	.L3.29:
 1845 22f0 50FFFFFF 		br.l	.L3.28
 1845      00000F18 
 1846              	.L3.30:
 1847 22f8 B8050000 		br.l	.L3.31
 1847      00000F18 
 1848              	.L3.32:
 1849              	# line 642
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1850              		.loc	1 642 0
 1851 2300 00000000 		adds.w.sx	%s63,1,%s63
 1851      BF013F4A 
 1852 2308 00000000 		adds.w.sx	%s53,%s59,%s53
 1852      B5BB354A 
 1853 2310 00000000 		adds.w.sx	%s45,%s58,%s45
 1853      ADBA2D4A 
 1854 2318 00000000 		adds.l	%s50,%s43,%s50
 1854      B2AB3259 
 1855 2320 D8FFFFFF 		brgt.w	0,%s63,.L3.30
 1855      BF008118 
 1856 2328 C8FFFFFF 		br.l	.L3.29
 1856      00000F18 
 1857              	.L3.33:
 1858 2330 80FEFFFF 		ld	%s63,-384(,%fp)	# restore 
 1858      89003F01 
 1859 2338 88FEFFFF 		ld	%s58,-376(,%fp)	# restore 
 1859      89003A01 
 1860 2340 78FEFFFF 		ld	%s50,-392(,%fp)	# restore 
 1860      89003201 
 1861 2348 90FEFFFF 		ld	%s20,-368(,%fp)	# restore 
 1861      89001401 
 1862 2350 70FEFFFF 		ld	%s40,-400(,%fp)	# restore 
 1862      89002801 
 1863 2358 A8FFFFFF 		br.l	.L3.32
 1863      00000F18 
 1864              	.L3.34:
 1865              	# line 643
 643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 1866              		.loc	1 643 0
 1867 2360 00000000 		adds.w.sx	%s63,1,%s63
 1867      BF013F4A 
 1868 2368 00000000 		adds.l	%s50,%s56,%s50
 1868      B2B83259 
 1869 2370 00000000 		adds.l	%s37,%s43,%s37
 1869      A5AB2559 
 1870 2378 C8040000 		brgt.w	0,%s63,.L3.35
 1870      BF008118 
 1871 2380 B0FFFFFF 		br.l	.L3.33
 1871      00000F18 
 1872              	.L3.36:
 1873 2388 C0FEFFFF 		ld	%s63,-320(,%fp)	# restore 
 1873      89003F01 
 1874 2390 B8FEFFFF 		ld	%s56,-328(,%fp)	# restore 
 1874      89003801 
 1875 2398 A0FEFFFF 		ld	%s50,-352(,%fp)	# restore 
 1875      89003201 
 1876 23a0 B0FEFFFF 		ld	%s43,-336(,%fp)	# restore 
 1876      89002B01 
 1877 23a8 A8FEFFFF 		ld	%s37,-344(,%fp)	# restore 
 1877      89002501 
 1878 23b0 98FEFFFF 		ld	%s59,-360(,%fp)	# restore 
 1878      89003B01 
 1879 23b8 C8FEFFFF 		ld	%s20,-312(,%fp)	# restore 
 1879      89001401 
 1880 23c0 A0FFFFFF 		br.l	.L3.34
 1880      00000F18 
 1881              	.L3.37:
 1882              	# line 644
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 1883              		.loc	1 644 0
 1884 23c8 00000000 		adds.w.sx	%s63,1,%s63
 1884      BF013F4A 
 1885 23d0 00000000 		adds.w.sx	%s58,1,%s58
 1885      BA013A4A 
 1886 23d8 E8030000 		brgt.w	0,%s63,.L3.38
 1886      BF008118 
 1887 23e0 A8FFFFFF 		br.l	.L3.36
 1887      00000F18 
 1888              	.L3.39:
 1889 23e8 E8FEFFFF 		ld	%s63,-280(,%fp)	# restore 
 1889      89003F01 
 1890 23f0 E0FEFFFF 		ld	%s58,-288(,%fp)	# restore 
 1890      89003A01 
 1891 23f8 F0FEFFFF 		ld	%s19,-272(,%fp)	# restore 
 1891      89001301 
 1892 2400 D0FEFFFF 		ld	%s26,-304(,%fp)	# restore 
 1892      89001A01 
 1893 2408 D8FEFFFF 		ld	%s1,-296(,%fp)	# restore 
 1893      89000101 
 1894 2410 B8FFFFFF 		br.l	.L3.37
 1894      00000F18 
 1895              	.L3.40:
 1896 2418 48030000 		br.l	.L3.41
 1896      00000F18 
 1897              	.L3.42:
 1898              	# line 645
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           // calc kh_beg, kh_end here? 4.28x
 1899              		.loc	1 645 0
 1900 2420 00000000 		adds.w.sx	%s63,1,%s63
 1900      BF013F4A 
 1901 2428 00000000 		adds.w.sx	%s58,1,%s58
 1901      BA013A4A 
 1902 2430 00000000 		adds.w.sx	%s59,1,%s59
 1902      BB013B4A 
 1903 2438 00000000 		adds.w.sx	%s56,1,%s56
 1903      B801384A 
 1904 2440 D8FFFFFF 		brgt.w	0,%s63,.L3.40
 1904      BF008118 
 1905 2448 A0FFFFFF 		br.l	.L3.39
 1905      00000F18 
 1906              	.L3.43:
 1907 2450 68FFFFFF 		ld	%s63,-152(,%fp)	# restore 
 1907      89003F01 
 1908 2458 60FFFFFF 		ld	%s58,-160(,%fp)	# restore 
 1908      89003A01 
 1909 2460 58FFFFFF 		ld	%s56,-168(,%fp)	# restore 
 1909      89003801 
 1910 2468 70FFFFFF 		ld	%s18,-144(,%fp)	# restore 
 1910      89001201 
 1911 2470 48FFFFFF 		ld	%s50,-184(,%fp)	# restore 
 1911      89003201 
 1912 2478 40FFFFFF 		ld	%s49,-192(,%fp)	# restore 
 1912      89003101 
 1913 2480 38FFFFFF 		ld	%s48,-200(,%fp)	# restore 
 1913      89003001 
 1914 2488 00FFFFFF 		ld	%s47,-256(,%fp)	# restore 
 1914      89002F01 
 1915 2490 28FFFFFF 		ld	%s5,-216(,%fp)	# restore 
 1915      89000501 
 1916 2498 F8FEFFFF 		ld	%s42,-264(,%fp)	# restore 
 1916      89002A01 
 1917 24a0 20FFFFFF 		ld	%s23,-224(,%fp)	# restore 
 1917      89001701 
 1918 24a8 18FFFFFF 		ld	%s22,-232(,%fp)	# restore 
 1918      89001601 
 1919 24b0 10FFFFFF 		ld	%s21,-240(,%fp)	# restore 
 1919      89001501 
 1920 24b8 30FFFFFF 		ld	%s6,-208(,%fp)	# restore 
 1920      89000601 
 1921 24c0 08FFFFFF 		ld	%s54,-248(,%fp)	# restore 
 1921      89003601 
 1922 24c8 50FFFFFF 		ld	%s53,-176(,%fp)	# restore 
 1922      89003501 
 1923 24d0 50FFFFFF 		br.l	.L3.42
 1923      00000F18 
 1924              	.L3.44:
 1925 24d8 00000000 		or	%s1,0,%s63
 1925      BF000145 
 1926 24e0 00010000 		br.l	.L3.45
 1926      00000F18 
 1927              	.L3.9:
 1928              	# line 647
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 1929              		.loc	1 647 0
 1930 24e8 00000000 		adds.w.sx	%s63,1,%s63
 1930      BF013F4A 
 1931 24f0 00000000 		adds.l	%s54,4,%s54
 1931      B6043659 
 1932 24f8 00000000 		adds.w.sx	%s58,1,%s58
 1932      BA013A4A 
 1933 2500 00000000 		adds.w.sx	%s56,1,%s56
 1933      B801384A 
 1934 2508 D0FFFFFF 		brgt.w	0,%s63,.L3.44
 1934      BF008118 
 1935 2510 40FFFFFF 		br.l	.L3.43
 1935      00000F18 
 1936              	.L3.46:
 1937 2518 00000000 		or	%s63,0,%s1
 1937      81003F45 
 1938 2520 C8FFFFFF 		br.l	.L3.9
 1938      00000F18 
 1939              	.L3.47:
 1940 2528 F0FFFFFF 		brge.w	%s18,%s19,.L3.46
 1940      93928518 
 1941 2530 C8FCFFFF 		br.l	.L3.27
 1941      00000F18 
 1942              	.L3.48:
 1943              	# line 661
 661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 1944              		.loc	1 661 0
 1945 2538 00000000 		subs.w.sx	%s50,%s50,%s32
 1945      A0B2325A 
 1946 2540 00000000 		divs.w.sx	%s50,%s50,%s46
 1946      AEB2327B 
 1947 2548 00000000 		muls.w.sx	%s50,%s60,%s50
 1947      B2BC324B 
 1948 2550 00000000 		adds.w.sx	%s50,%s60,%s50
 1948      B2BC324A 
 1949 2558 00000000 		adds.w.sx	%s18,%s18,%s50
 1949      B292124A 
 1950 2560 C8FFFFFF 		br.l	.L3.47
 1950      00000F18 
 1951              	.L3.3:
 1952              	# line 658
 658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kh_beg -= m * khh;
 1953              		.loc	1 658 0
 1954 2568 00000000 		divs.w.sx	%s53,%s47,%s60
 1954      BCAF357B 
 1955 2570 00000000 		subs.w.sx	%s50,%s53,%s50
 1955      B2B5325A 
 1956              	# line 659
 659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
 1957              		.loc	1 659 0
 1958 2578 00000000 		muls.w.sx	%s53,%s60,%s50
 1958      B2BC354B 
 1959 2580 00000000 		subs.w.sx	%s18,%s47,%s53
 1959      B5AF125A 
 1960              	# line 660
 660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
 1961              		.loc	1 660 0
 1962 2588 00000000 		muls.w.sx	%s50,%s50,%s46
 1962      AEB2324B 
 1963 2590 00000000 		adds.w.sx	%s50,%s50,%s42
 1963      AAB2324A 
 1964 2598 A0FFFFFF 		brge.w	%s50,%s32,.L3.48
 1964      A0B28518 
 1965 25a0 88FFFFFF 		br.l	.L3.47
 1965      00000F18 
 1966              	.L3.49:
 1967              	# line 658
 658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kh_beg -= m * khh;
 1968              		.loc	1 658 0
 1969 25a8 00000000 		or	%s50,1,(0)1
 1969      00013245 
 1970 25b0 B8FFFFFF 		br.l	.L3.3
 1970      00000F18 
 1971              	.L3.50:
 1972 25b8 00000000 		divs.w.sx	%s53,%s47,%s60
 1972      BCAF357B 
 1973 25c0 00000000 		muls.w.sx	%s53,%s60,%s53
 1973      B5BC354B 
 1974 25c8 00000000 		subs.w.sx	%s53,%s47,%s53
 1974      B5AF355A 
 1975 25d0 D8FFFFFF 		brgt.w	0,%s53,.L3.49
 1975      B5008118 
 1976 25d8 70F5FFFF 		br.l	.L3.2
 1976      00000F18 
 1977              	.L3.45:
 1978              	# line 650
 650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 1979              		.loc	1 650 0
 1980 25e0 00000000 		or	%s63,0,(0)1
 1980      00003F45 
 1981 25e8 00000000 		stu	%s63,0(,%s54)	# *(ds)
 1981      B6003F12 
 1982 25f0 00000000 		or	%s18,0,%s19
 1982      93001245 
 1983 25f8 C0FFFFFF 		breq.w	0,%s20,.L3.50
 1983      94008418 
 1984 2600 28FFFFFF 		br.l	.L3.47
 1984      00000F18 
 1985              	.L3.51:
 1986 2608 70FFFFFF 		st	%s18,-144(,%fp)	# spill 
 1986      89001211 
 1987 2610 68FFFFFF 		st	%s63,-152(,%fp)	# spill 
 1987      89003F11 
 1988 2618 60FFFFFF 		st	%s58,-160(,%fp)	# spill 
 1988      89003A11 
 1989 2620 58FFFFFF 		st	%s56,-168(,%fp)	# spill 
 1989      89003811 
 1990 2628 50FFFFFF 		st	%s53,-176(,%fp)	# spill 
 1990      89003511 
 1991 2630 48FFFFFF 		st	%s50,-184(,%fp)	# spill 
 1991      89003211 
 1992 2638 40FFFFFF 		st	%s49,-192(,%fp)	# spill 
 1992      89003111 
 1993 2640 38FFFFFF 		st	%s48,-200(,%fp)	# spill 
 1993      89003011 
 1994 2648 30FFFFFF 		st	%s6,-208(,%fp)	# spill 
 1994      89000611 
 1995 2650 28FFFFFF 		st	%s5,-216(,%fp)	# spill 
 1995      89000511 
 1996 2658 20FFFFFF 		st	%s23,-224(,%fp)	# spill 
 1996      89001711 
 1997 2660 18FFFFFF 		st	%s22,-232(,%fp)	# spill 
 1997      89001611 
 1998 2668 10FFFFFF 		st	%s21,-240(,%fp)	# spill 
 1998      89001511 
 1999 2670 08FFFFFF 		st	%s54,-248(,%fp)	# spill 
 1999      89003611 
 2000 2678 00FFFFFF 		st	%s47,-256(,%fp)	# spill 
 2000      89002F11 
 2001 2680 F8FEFFFF 		st	%s42,-264(,%fp)	# spill 
 2001      89002A11 
 2002 2688 00000000 		divs.w.sx	%s53,%s53,%s30
 2002      9EB5357B 
 2003 2690 00000000 		or	%s53,0,%s53
 2003      B5003545 
 2004 2698 00000000 		addu.l	%s50,%s53,%s50
 2004      B2B53248 
 2005 26a0 00000000 		addu.l	%s50,%s50,%s37
 2005      A5B23248 
 2006 26a8 00000000 		mulu.l	%s49,%s50,%s49
 2006      B1B23149 
 2007 26b0 00000000 		or	%s63,0,%s56
 2007      B8003F45 
 2008 26b8 00000000 		addu.l	%s63,%s49,%s63
 2008      BFB13F48 
 2009 26c0 00000000 		mulu.l	%s48,%s63,%s48
 2009      B0BF3049 
 2010 26c8 00000000 		or	%s48,0,%s48
 2010      B0003045 
 2011              	# line 652
 652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kh_end > KH) kh_end = KH;
 2012              		.loc	1 652 0
 2013 26d0 00000000 		divs.w.sx	%s6,%s58,%s6
 2013      86BA067B 
 2014 26d8 00000000 		adds.w.sx	%s6,1,%s6
 2014      8601064A 
 2015              	# line 653
 653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_beg = kh_end;
 2016              		.loc	1 653 0
 2017 26e0 80000000 		mins.w.sx	%s19,%s6,%s5
 2017      85861378 
 2018              	# line 679
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   kh < kh_end;
 2019              		.loc	1 679 0
 2020 26e8 00000000 		subs.w.sx	%s26,0,%s19
 2020      93001A5A 
 2021              	# line 655
 655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int const mul = (ih+PH) / gcd_h;
 2022              		.loc	1 655 0
 2023 26f0 00000000 		divs.w.sx	%s63,%s58,%s23
 2023      97BA3F7B 
 2024 26f8 00000000 		muls.w.sx	%s23,%s23,%s63
 2024      BF97174B 
 2025 2700 00000000 		subs.w.sx	%s20,%s58,%s23
 2025      97BA145A 
 2026              	# line 657
 657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int m = div_floor(kh_beg, khh);
 2027              		.loc	1 657 0
 2028 2708 00000000 		muls.w.sx	%s22,%s63,%s22
 2028      96BF164B 
 2029              	# line 660
 660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
 2030              		.loc	1 660 0
 2031 2710 00000000 		muls.w.sx	%s21,%s63,%s21
 2031      95BF154B 
 2032 2718 00000000 		or	%s1,0,%s54
 2032      B6000145 
 2033              	# line 647
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2034              		.loc	1 647 0
 2035 2720 00000000 		muls.l	%s48,4,%s48
 2035      B004306E 
 2036 2728 00000000 		adds.l	%s48,%s48,%s47
 2036      AFB03059 
 2037 2730 00000000 		or	%s47,0,%s22
 2037      96002F45 
 2038 2738 00000000 		or	%s54,0,%s48
 2038      B0003645 
 2039 2740 00000000 		or	%s58,0,%s42
 2039      AA003A45 
 2040 2748 00000000 		or	%s56,0,%s42
 2040      AA003845 
 2041 2750 00000000 		or	%s42,0,%s21
 2041      95002A45 
 2042 2758 88FEFFFF 		br.l	.L3.45
 2042      00000F18 
 2043              	.L3.41:
 2044 2760 A8FEFFFF 		brlt.w	0,%s18,.L3.51
 2044      92008218 
 2045 2768 B8FCFFFF 		br.l	.L3.42
 2045      00000F18 
 2046              	.L3.52:
 2047 2770 F0FEFFFF 		st	%s19,-272(,%fp)	# spill 
 2047      89001311 
 2048 2778 E8FEFFFF 		st	%s63,-280(,%fp)	# spill 
 2048      89003F11 
 2049 2780 E0FEFFFF 		st	%s58,-288(,%fp)	# spill 
 2049      89003A11 
 2050 2788 D8FEFFFF 		st	%s1,-296(,%fp)	# spill 
 2050      89000111 
 2051 2790 D0FEFFFF 		st	%s26,-304(,%fp)	# spill 
 2051      89001A11 
 2052 2798 00000000 		or	%s37,0,%s58
 2052      BA002545 
 2053 27a0 00000000 		or	%s63,0,%s1
 2053      81003F45 
 2054 27a8 00000000 		or	%s58,0,%s26
 2054      9A003A45 
 2055 27b0 00000000 		or	%s59,0,%s26
 2055      9A003B45 
 2056 27b8 A8FFFFFF 		br.l	.L3.41
 2056      00000F18 
 2057              	.L3.38:
 2058              	# line 645
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           // calc kh_beg, kh_end here? 4.28x
 2059              		.loc	1 645 0
 2060 27c0 00000000 		or	%s56,0,(0)1
 2060      00003845 
 2061 27c8 A8FFFFFF 		brlt.w	0,%s19,.L3.52
 2061      93008218 
 2062 27d0 F8FBFFFF 		br.l	.L3.37
 2062      00000F18 
 2063              	.L3.53:
 2064 27d8 C8FEFFFF 		st	%s20,-312(,%fp)	# spill 
 2064      89001411 
 2065 27e0 C0FEFFFF 		st	%s63,-320(,%fp)	# spill 
 2065      89003F11 
 2066 27e8 B8FEFFFF 		st	%s56,-328(,%fp)	# spill 
 2066      89003811 
 2067 27f0 B0FEFFFF 		st	%s43,-336(,%fp)	# spill 
 2067      89002B11 
 2068 27f8 A8FEFFFF 		st	%s37,-344(,%fp)	# spill 
 2068      89002511 
 2069 2800 A0FEFFFF 		st	%s50,-352(,%fp)	# spill 
 2069      89003211 
 2070 2808 98FEFFFF 		st	%s59,-360(,%fp)	# spill 
 2070      89003B11 
 2071              	# line 644
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2072              		.loc	1 644 0
 2073 2810 00000000 		divs.w.sx	%s59,%s59,%s30
 2073      9EBB3B7B 
 2074 2818 00000000 		subs.w.sx	%s59,0,%s59
 2074      BB003B5A 
 2075 2820 00000000 		or	%s63,0,%s59
 2075      BB003F45 
 2076 2828 00000000 		or	%s50,0,%s50
 2076      B2003245 
 2077 2830 00000000 		or	%s43,0,%s37
 2077      A5002B45 
 2078 2838 88FFFFFF 		br.l	.L3.38
 2078      00000F18 
 2079              	.L3.35:
 2080 2840 00000000 		or	%s58,0,(0)1
 2080      00003A45 
 2081 2848 90FFFFFF 		brlt.w	0,%s20,.L3.53
 2081      94008218 
 2082 2850 10FBFFFF 		br.l	.L3.34
 2082      00000F18 
 2083              	.L3.54:
 2084 2858 90FEFFFF 		st	%s20,-368(,%fp)	# spill 
 2084      89001411 
 2085 2860 88FEFFFF 		st	%s58,-376(,%fp)	# spill 
 2085      89003A11 
 2086 2868 80FEFFFF 		st	%s63,-384(,%fp)	# spill 
 2086      89003F11 
 2087 2870 78FEFFFF 		st	%s50,-392(,%fp)	# spill 
 2087      89003211 
 2088 2878 70FEFFFF 		st	%s40,-400(,%fp)	# spill 
 2088      89002811 
 2089 2880 00000000 		divs.w.sx	%s20,%s59,%s30
 2089      9EBB147B 
 2090 2888 00000000 		or	%s40,0,%s50
 2090      B2002845 
 2091 2890 70FEFFFF 		ld	%s63,-400(,%fp)	# restore 
 2091      89003F01 
 2092              	# line 643
 643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 2093              		.loc	1 643 0
 2094 2898 00000000 		or	%s50,0,(0)1
 2094      00003245 
 2095 28a0 00000000 		or	%s37,0,(0)1
 2095      00002545 
 2096 28a8 98FFFFFF 		br.l	.L3.35
 2096      00000F18 
 2097              	.L3.31:
 2098 28b0 A8FFFFFF 		brlt.w	0,%s20,.L3.54
 2098      94008218 
 2099 28b8 48FAFFFF 		br.l	.L3.32
 2099      00000F18 
 2100              	.L3.55:
 2101 28c0 04000000 		dldl.sx	%s20,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 2101      8000140B 
 2102 28c8 00000000 		subs.w.sx	%s40,0,%s20
 2102      9400285A 
 2103              	# line 644
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2104              		.loc	1 644 0
 2105 28d0 08000000 		dldl.sx	%s59,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 2105      80003B0B 
 2106 28d8 00000000 		or	%s37,0,%s59
 2106      BB002545 
 2107 28e0 00000000 		or	%s56,0,%s37
 2107      A5003845 
 2108              	# line 642
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2109              		.loc	1 642 0
 2110 28e8 00000000 		or	%s50,0,(0)1
 2110      00003245 
 2111 28f0 00000000 		subs.w.sx	%s37,0,%s30
 2111      9E00255A 
 2112 28f8 00000000 		or	%s63,0,%s37
 2112      A5003F45 
 2113              	# line 645
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           // calc kh_beg, kh_end here? 4.28x
 2114              		.loc	1 645 0
 2115 2900 0C000000 		dldl.sx	%s19,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 2115      8000130B 
 2116 2908 00000000 		or	%s49,0,%s19
 2116      93003145 
 2117 2910 00000000 		subs.w.sx	%s37,0,%s19
 2117      9300255A 
 2118              	# line 647
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2119              		.loc	1 647 0
 2120 2918 10000000 		dldl.sx	%s18,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 2120      8000120B 
 2121 2920 00000000 		or	%s48,0,%s18
 2121      92003045 
 2122 2928 00000000 		subs.w.sx	%s54,0,%s18
 2122      9200365A 
 2123              	# line 650
 650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 2124              		.loc	1 650 0
 2125 2930 A8010000 		dld	%s47,424(,%s1)	# *(diff_src_m).data_
 2125      81002F09 
 2126 2938 00000000 		or	%s1,0,%s37
 2126      A5000145 
 2127              	# line 652
 652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kh_end > KH) kh_end = KH;
 2128              		.loc	1 652 0
 2129 2940 30000000 		dldl.sx	%s26,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 2129      80001A0B 
 2130              	# line 653
 653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kh_beg = kh_end;
 2131              		.loc	1 653 0
 2132 2948 20000000 		dldl.sx	%s5,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 2132      8000050B 
 2133              	# line 661
 661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 2134              		.loc	1 661 0
 2135 2950 18000000 		dldl.sx	%s32,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 2135      8000200B 
 2136              	# line 665
 665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (kw_end > KW) kw_end = KW;
 2137              		.loc	1 665 0
 2138 2958 34000000 		dldl.sx	%s42,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 2138      80002A0B 
 2139              	# line 666
 666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_beg = kw_end;
 2140              		.loc	1 666 0
 2141 2960 24000000 		dldl.sx	%s52,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 2141      8000340B 
 2142              	# line 674
 674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 2143              		.loc	1 674 0
 2144 2968 1C000000 		dldl.sx	%s24,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 2144      8000180B 
 2145              	# line 678
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 2146              		.loc	1 678 0
 2147 2970 14000000 		dldl.sx	%s31,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 2147      80001F0B 
 2148              	# line 679
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   kh < kh_end;
 2149              		.loc	1 679 0
 2150 2978 38000000 		dldl.sx	%s37,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 2150      8000250B 
 2151 2980 00000000 		adds.w.sx	%s37,1,%s37
 2151      A501254A 
 2152              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 2153              		.loc	1 683 0
 2154 2988 3C000000 		dldl.sx	%s58,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 2154      80003A0B 
 2155 2990 00000000 		adds.w.sx	%s4,1,%s58
 2155      BA01044A 
 2156 2998 A8010000 		dld	%s58,424(,%s3)	# *(s$44).data_
 2156      83003A09 
 2157              	# line 642
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2158              		.loc	1 642 0
 2159 29a0 00000000 		or	%s53,0,(0)1
 2159      00003545 
 2160 29a8 00000000 		or	%s45,0,(0)1
 2160      00002D45 
 2161 29b0 78FFFFFF 		st	%s58,-136(,%fp)	# spill 
 2161      89003A11 
 2162              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 2163              		.loc	1 683 0
 2164 29b8 A8010000 		dld	%s3,424(,%s2)	# *(s$46).data_
 2164      82000309 
 2165              	# line 689
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 2166              		.loc	1 689 0
 2167 29c0 14000000 		dldl.sx	%s58,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 2167      80003A0B 
 2168 29c8 00000000 		or	%s57,0,%s58
 2168      BA003945 
 2169 29d0 00000000 		or	%s43,0,%s57
 2169      B9002B45 
 2170 29d8 00000000 		dldl.sx	%s44,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 2170      80002C0B 
 2171 29e0 00000000 		or	%s39,0,%s44
 2171      AC002745 
 2172 29e8 18000000 		dldl.sx	%s57,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 2172      8000390B 
 2173 29f0 00000000 		or	%s41,0,%s57
 2173      B9002945 
 2174 29f8 28000000 		dldl.sx	%s35,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 2174      8000230B 
 2175 2a00 1C000000 		dldl.sx	%s57,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 2175      8000390B 
 2176 2a08 00000000 		or	%s34,0,%s57
 2176      B9002245 
 2177 2a10 2C000000 		dldl.sx	%s2,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 2177      8000020B 
 2178 2a18 08000000 		dldl.sx	%s57,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 2178      8000390B 
 2179 2a20 00000000 		or	%s38,0,%s57
 2179      B9002645 
 2180 2a28 20000000 		dldl.sx	%s57,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 2180      8000390B 
 2181 2a30 00000000 		or	%s36,0,%s57
 2181      B9002445 
 2182 2a38 24000000 		dldl.sx	%s0,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 2182      8000000B 
 2183 2a40 00000000 		or	%s33,0,%s0
 2183      80002145 
 2184 2a48 00000000 		or	%s0,0,%s27
 2184      9B000045 
 2185              	# line 683
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     kw < kw_end;
 2186              		.loc	1 683 0
 2187 2a50 00000000 		muls.l	%s57,4,%s0
 2187      8004396E 
 2188 2a58 00000000 		subs.w.sx	%s29,0,%s61
 2188      BD001D5A 
 2189 2a60 00000000 		or	%s61,0,%s37
 2189      A5003D45 
 2190 2a68 48FEFFFF 		br.l	.L3.31
 2190      00000F18 
 2191              	.L3.56:
 2192              	# line 527
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int kww = SW / gcd_w;      // = lcm_w / DW;
 2193              		.loc	1 527 0
 2194 2a70 2C000000 		ldl.sx	%s63,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 2194      80003F03 
 2195              	# line 528
 528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int jww = DW / gcd_w;      // = lcm_w / SW
 2196              		.loc	1 528 0
 2197 2a78 00000000 		divs.w.sx	%s27,%s63,%s51
 2197      B3BF1B7B 
 2198              	# line 527
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int kww = SW / gcd_w;      // = lcm_w / DW;
 2199              		.loc	1 527 0
 2200 2a80 00000000 		muls.w.sx	%s61,%s63,%s55
 2200      B7BF3D4B 
 2201 2a88 00000000 		divs.w.sx	%s61,%s61,%s51
 2201      B3BD3D7B 
 2202              	# line 529
 529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 2203              		.loc	1 529 0
 2204 2a90 00000000 		divs.w.sx	%s25,%s55,%s51
 2204      B3B7197B 
 2205              	# line 642
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2206              		.loc	1 642 0
 2207 2a98 00000000 		ldl.sx	%s30,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 2207      80001E03 
 2208 2aa0 20FEFFFF 		brlt.w	0,%s30,.L3.55
 2208      9E008218 
 2209 2aa8 98F7FFFF 		br.l	.L3.28
 2209      00000F18 
 2210              	.L3.57:
 2211 2ab0 00000000 		or	%s0,0,%s4
 2211      84000045 
 2212 2ab8 B8FFFFFF 		br.l	.L3.56
 2212      00000F18 
 2213              	.L3.58:
 2214 2ac0 00000000 		or	%s63,0,%s57
 2214      B9003F45 
 2215              	.L3.59:
 2216              	# line 525
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int gcd_w = wg;                // = gcd( SW, DW );
 2217              		.loc	1 525 0
 2218 2ac8 00000000 		divs.w.sx	%s61,%s51,%s63
 2218      BFB33D7B 
 2219 2ad0 00000000 		muls.w.sx	%s57,%s63,%s61
 2219      BDBF394B 
 2220 2ad8 00000000 		or	%s63,0,%s63
 2220      BF003F45 
 2221 2ae0 00000000 		subs.w.sx	%s57,%s51,%s57
 2221      B9B3395A 
 2222 2ae8 00000000 		or	%s51,0,%s63
 2222      BF003345 
 2223 2af0 00000000 		muls.w.sx	%s63,%s61,%s59
 2223      BBBD3F4B 
 2224 2af8 00000000 		subs.w.sx	%s63,%s7,%s63
 2224      BF873F5A 
 2225 2b00 00000000 		or	%s7,0,%s59
 2225      BB000745 
 2226 2b08 00000000 		or	%s59,0,%s63
 2226      BF003B45 
 2227 2b10 00000000 		muls.w.sx	%s61,%s61,%s58
 2227      BABD3D4B 
 2228 2b18 00000000 		subs.w.sx	%s61,%s28,%s61
 2228      BD9C3D5A 
 2229 2b20 00000000 		or	%s28,0,%s58
 2229      BA001C45 
 2230 2b28 00000000 		or	%s58,0,%s61
 2230      BD003A45 
 2231 2b30 90FFFFFF 		brne.w	0,%s57,.L3.58
 2231      B9008318 
 2232 2b38 78FFFFFF 		br.l	.L3.57
 2232      00000F18 
 2233              	.L3.60:
 2234 2b40 00000000 		or	%s4,0,%s0
 2234      80000445 
 2235 2b48 80FFFFFF 		br.l	.L3.59
 2235      00000F18 
 2236              	.L3.1:
 2237              	# line 516
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int khh = SH / gcd_h;           // = lcm_h / DH;
 2238              		.loc	1 516 0
 2239 2b50 28000000 		ldl.sx	%s61,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 2239      80003D03 
 2240              	# line 517
 517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 2241              		.loc	1 517 0
 2242 2b58 00000000 		divs.w.sx	%s60,%s61,%s23
 2242      97BD3C7B 
 2243              	# line 516
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int khh = SH / gcd_h;           // = lcm_h / DH;
 2244              		.loc	1 516 0
 2245 2b60 00000000 		muls.w.sx	%s57,%s61,%s6
 2245      86BD394B 
 2246 2b68 00000000 		divs.w.sx	%s62,%s57,%s23
 2246      97B93E7B 
 2247              	# line 519
 519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 2248              		.loc	1 519 0
 2249 2b70 00000000 		divs.w.sx	%s46,%s62,%s61
 2249      BDBE2E7B 
 2250              	# line 522
 522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 2251              		.loc	1 522 0
 2252 2b78 3C000000 		ldl.sx	%s57,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 2252      80003903 
 2253 2b80 00000000 		adds.w.sx	%s55,1,%s57
 2253      B901374A 
 2254 2b88 00000000 		or	%s63,0,%s55
 2254      B7003F45 
 2255              	# line 525
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int gcd_w = wg;                // = gcd( SW, DW );
 2256              		.loc	1 525 0
 2257 2b90 00000000 		or	%s59,1,(0)1
 2257      00013B45 
 2258 2b98 00000000 		or	%s28,1,(0)1
 2258      00011C45 
 2259 2ba0 2C000000 		ldl.sx	%s51,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 2259      80003303 
 2260 2ba8 00000000 		or	%s58,0,(0)1
 2260      00003A45 
 2261 2bb0 00000000 		or	%s7,0,(0)1
 2261      00000745 
 2262 2bb8 88FFFFFF 		brne.w	0,%s55,.L3.60
 2262      B7008318 
 2263 2bc0 B0FEFFFF 		br.l	.L3.56
 2263      00000F18 
 2264              	.L3.61:
 2265 2bc8 00000000 		or	%s0,0,%s4
 2265      84000045 
 2266 2bd0 80FFFFFF 		br.l	.L3.1
 2266      00000F18 
 2267              	.L3.62:
 2268 2bd8 00000000 		or	%s63,0,%s59
 2268      BB003F45 
 2269              	.L3.63:
 2270              	# line 514
 514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   const int gcd_h = hg;                 // = gcd( SH, DH );
 2271              		.loc	1 514 0
 2272 2be0 00000000 		divs.w.sx	%s62,%s23,%s63
 2272      BF973E7B 
 2273 2be8 00000000 		muls.w.sx	%s59,%s63,%s62
 2273      BEBF3B4B 
 2274 2bf0 00000000 		or	%s63,0,%s63
 2274      BF003F45 
 2275 2bf8 00000000 		subs.w.sx	%s59,%s23,%s59
 2275      BB973B5A 
 2276 2c00 00000000 		or	%s23,0,%s63
 2276      BF001745 
 2277 2c08 00000000 		muls.w.sx	%s63,%s62,%s61
 2277      BDBE3F4B 
 2278 2c10 00000000 		subs.w.sx	%s63,%s22,%s63
 2278      BF963F5A 
 2279 2c18 00000000 		or	%s22,0,%s61
 2279      BD001645 
 2280 2c20 00000000 		or	%s61,0,%s63
 2280      BF003D45 
 2281 2c28 00000000 		muls.w.sx	%s62,%s62,%s60
 2281      BCBE3E4B 
 2282 2c30 00000000 		subs.w.sx	%s62,%s21,%s62
 2282      BE953E5A 
 2283 2c38 00000000 		or	%s21,0,%s60
 2283      BC001545 
 2284 2c40 00000000 		or	%s60,0,%s62
 2284      BE003C45 
 2285 2c48 90FFFFFF 		brne.w	0,%s59,.L3.62
 2285      BB008318 
 2286 2c50 78FFFFFF 		br.l	.L3.61
 2286      00000F18 
 2287              	.L3.0:
 2288 2c58 00000000 		or	%s4,0,%s0
 2288      80000445 
 2289 2c60 80FFFFFF 		br.l	.L3.63
 2289      00000F18 
 2290              		.cfi_endproc
 2291              		.set	.L.4.2auto_size,	0xfffffffffffffbe0	# 1056 Bytes
 2293              	# ============ End  _ZN35_INTERNAL_13_ref_conv5_cpp_202f7a294conv23refconv_5_bwd_d_genericEPKNS0_5p
 2294              	# ============ Begin  conv::refconv_5_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2295 2c68 00000000 		.balign 16
 2295      00000000 
 2296              	# line 752
 704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0// try to "guess" things   --- no way!
 705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg = (ih+PH - kh_beg * (p->dh+1)) / SH;
 706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int khb0 = div_floor( (ih + PH) - OH*SH, DH) + 1;
 707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int khb = khb0;
 708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if( khb > 0 ){
 709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 // Want first khb >= khb0 such that
 710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //   ohsh = (ih+PH - khb*DH) is a multiple of SH
 711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //     [ and >= 0, and < oh_end ]
 712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 // or smallest N>=0 s.t.
 714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //   khb' = (ih+PH - (khb+N)*DH) has khb'/SH*SH == khb'
 715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //
 716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //int ohsh = (ih+PH - khb * (DH));
 717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //       ~ (ih+PH - ((ih + PH) - OH*SH + DH))
 718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //       ~ OH*SH - (DH)
 719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //int ohsh = OH*SH - (DH);
 720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //if( ohsh % SH != 0 ) ohsh -= lcm_h;
 721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 int ohsh = (ih+PH - khb * (DH));
 722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 if( ohsh % SH != 0 ) ohsh -= ohsh % SH;
 723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 if( ohsh % SH == 0 && kh_beg < kh_end ) RT_ASSERT( ohsh == oh_beg * SH );
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 RT_ASSERT( ohsh %SH == 0 );
 725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //int khb2 = div_floor( (ih+PH) - ohsh + DH , DH );
 726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //int khb2 = div_floor( (ih+PH) - div_floor(ohsh,SH)*SH + DH-1 , DH ); // almost!
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 int khb2 = div_floor( (ih+PH) - div_floor(ih+PH-ohsh,SH)*SH + DH-1 , DH ); // almos
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 print(0, "\n\t\t SH,DH,PH,OH=%d,%d,%d,%d; ih=%d; oh_beg=%d, ohsh=%d, ohsh/SH=%d lcm
 729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     SH,DH,PH,OH, ih, oh_beg,ohsh,ohsh/SH, lcm_h,khh, khb,khb2, kh_beg,kh_end);
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 if( kh_beg < kh_end ) RT_ASSERT( khb2 == kh_beg );
 731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 ohsh = (ih+PH - khb2 * (DH));
 732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 print(0, " ohsh'=%d ", ohsh);
 733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //ohsh -= ohsh % SH;
 734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //if( kh_beg < kh_end ) RT_ASSERT( rem_floor(ohsh, SH) != 0 );
 735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 // n RT_ASSERT( oh_beg == ohsh/SH );
 736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //if( !( oh_beg == ohsh/SH )){
 737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //  print(0, "\n\t\t SH,DH,PH,OH=%d,%d,%d,%d; ih=%d; oh_beg=%d, ohsh=%d, ohsh/SH=%d
 738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //      SH, DH, PH, OH, ih, oh_beg, ohsh, ohsh/SH, lcm_h, khh, khb, kh_beg,kh_end);
 739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //}
 740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //if( kh_beg < kh_end ) RT_ASSERT( oh_beg == ohsh/SH );
 741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //RT_ASSERT( kh_beg == khb );
 742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 print(0,"%c",'\n');
 743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** void refconv_5_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
 2297              		.loc	1 752 0
 2298              		.globl	conv::refconv_5_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2300              	conv::refconv_5_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 2301              		.cfi_startproc
 2302 2c70 00000000 		st	%fp,0x0(,%sp)
 2302      8B000911 
 2303              		.cfi_def_cfa_offset	0
 2304              		.cfi_offset	9,0
 2305 2c78 08000000 		st	%lr,0x8(,%sp)
 2305      8B000A11 
 2306 2c80 18000000 		st	%got,0x18(,%sp)
 2306      8B000F11 
 2307 2c88 20000000 		st	%plt,0x20(,%sp)
 2307      8B001011 
 2308 2c90 00000000 		or	%fp,0,%sp
 2308      8B000945 
 2309              		.cfi_def_cfa_register	9
 2310 2c98 30000000 		st	%s18,48(,%fp)
 2310      89001211 
 2311 2ca0 38000000 		st	%s19,56(,%fp)
 2311      89001311 
 2312 2ca8 40000000 		st	%s20,64(,%fp)
 2312      89001411 
 2313 2cb0 48000000 		st	%s21,72(,%fp)
 2313      89001511 
 2314 2cb8 50000000 		st	%s22,80(,%fp)
 2314      89001611 
 2315 2cc0 58000000 		st	%s23,88(,%fp)
 2315      89001711 
 2316 2cc8 60000000 		st	%s24,96(,%fp)
 2316      89001811 
 2317 2cd0 68000000 		st	%s25,104(,%fp)
 2317      89001911 
 2318 2cd8 70000000 		st	%s26,112(,%fp)
 2318      89001A11 
 2319 2ce0 78000000 		st	%s27,120(,%fp)
 2319      89001B11 
 2320 2ce8 80000000 		st	%s28,128(,%fp)
 2320      89001C11 
 2321 2cf0 88000000 		st	%s29,136(,%fp)
 2321      89001D11 
 2322 2cf8 90000000 		st	%s30,144(,%fp)
 2322      89001E11 
 2323 2d00 98000000 		st	%s31,152(,%fp)
 2323      89001F11 
 2324 2d08 A0000000 		st	%s32,160(,%fp)
 2324      89002011 
 2325 2d10 A8000000 		st	%s33,168(,%fp)
 2325      89002111 
 2326 2d18 B09AFFFF 		lea	%s13,.L.5.2auto_size&0xffffffff
 2326      00000D06 
 2327 2d20 00000000 		and	%s13,%s13,(32)0
 2327      608D0D44 
 2328 2d28 FFFFFFFF 		lea.sl	%sp,.L.5.2auto_size>>32(%fp,%s13)
 2328      8D898B06 
 2329 2d30 48000000 		brge.l.t	%sp,%sl,.L4.EoP
 2329      888B3518 
 2330 2d38 18000000 		ld	%s61,0x18(,%tp)
 2330      8E003D01 
 2331 2d40 00000000 		or	%s62,0,%s0
 2331      80003E45 
 2332 2d48 3B010000 		lea	%s63,0x13b
 2332      00003F06 
 2333 2d50 00000000 		shm.l	%s63,0x0(%s61)
 2333      BD033F31 
 2334 2d58 08000000 		shm.l	%sl,0x8(%s61)
 2334      BD030831 
 2335 2d60 10000000 		shm.l	%sp,0x10(%s61)
 2335      BD030B31 
 2336 2d68 00000000 		monc
 2336      0000003F 
 2337 2d70 00000000 		or	%s0,0,%s62
 2337      BE000045 
 2338              	.L4.EoP:
 2339              	# End of prologue codes
 2340              	# line 763
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     refconv_2_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 0 // kw_beg, oh_end loop ---> calculation (debug)
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   //  MOVED to separate routine
 758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   refconv_5_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
 759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   // many impls moved to ref_conv3.cpp.v2 "historical" code
 761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 1 // a new simplification of loop limits (same speed as above)
 762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   // regr-dilate: 2.50x
 763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
 2341              		.loc	1 763 0
 2342 2d78 38000000 		ldl.sx	%s18,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 2342      80001203 
 2343 2d80 C8140000 		brne.w	0,%s18,.L4.0
 2343      92008318 
 2344 2d88 D0130000 		br.l	.L4.1
 2344      00000F18 
 2345              	.L4.2:
 2346              	# line 782
 764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // FIXME can we call this even less?
 765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     refconv_5_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
 766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     return;
 767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int mb = 0; mb < MB; ++mb) { // 1: move here, cf ref_conv3
 770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(parallel for collapse(3))//;
 771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   for (int g = 0; g < G; ++g) {
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           register int kh_e = ih + PH;
 776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           int oh_b = OH - 1;
 777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           int kh_b = kh_e - OH*SH + SH;
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           if( kh_b < SH - 1 ){ // unlikely?
 779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             oh_b = kh_e / SH;
 780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_b = kh_e % SH;
 781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           if (++kh_e > KH) kh_e = KH;
 2347              		.loc	1 782 0
 2348 2d90 80000000 		mins.w.sx	%s61,%s5,%s61
 2348      BD853D78 
 2349 2d98 00000000 		smvl	%s13
 2349      00000D2E 
 2350 2da0 00000000 		lvl	%s13
 2350      008D00BF 
 2351 2da8 00F0FFFF 		lea	%s13,-4096(,%fp)	# restore
 2351      89000D06 
 2352 2db0 00000026 		vld	%v38,8,%s13 	# restore
 2352      8D084081 
 2353 2db8 C80D0000 		br.l	.L4.3
 2353      00000F18 
 2354              	.L4.4:
 2355              	# line 799
 783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           if( kh_b >= kh_e ) continue;
 784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           //ocend = (kh_b < kh_e? ocend: 0);
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             ds = 0; // always!
 790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if( ocend == 0 ) continue;
 791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             register int kw_e = iw + PW;
 793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int ow_b = OW - 1;
 794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_b = kw_e - OW*SW + SW;
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_b < SW - 1 ){ // unlikely?
 796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_b = kw_e / SW;
 797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_b = kw_e % SW;
 798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if (++kw_e > KW) kw_e = KW;
 2356              		.loc	1 799 0
 2357 2dc0 80000000 		mins.w.sx	%s55,%s6,%s55
 2357      B7863778 
 2358 2dc8 00000000 		smvl	%s13
 2358      00000D2E 
 2359 2dd0 00000000 		lvl	%s13
 2359      008D00BF 
 2360 2dd8 78070000 		br.l	.L4.5
 2360      00000F18 
 2361              	.L4.6:
 2362              	# line 808
 800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if (kw_b >= kw_e ) continue;
 801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //ocend = (kw_b < kw_e? ocend: 0);
 802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_b >= kw_e ) continue;
 804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if( kh_b >= kh_e || kw_b >= kw_e ) continue;
 805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oc = 0; oc < OC/G; ++oc) {
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_b, oh=oh_b; kh < kh_e; --oh, kh+=SH) {
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw+=SW) {
 2363              		.loc	1 808 0
 2364 2de0 80000000 		mins.w.sx	%s61,%s56,%s61
 2364      BDB83D78 
 2365 2de8 48010000 		br.l	.L4.7
 2365      00000F18 
 2366              	.L4.8:
 2367 2df0 00000000 		or	%s63,0,%s23
 2367      97003F45 
 2368 2df8 00000000 		or	%s57,0,%s24
 2368      98003945 
 2369 2e00 00000000 		or	%s45,0,%s25
 2369      99002D45 
 2370 2e08 00000000 		or	%s47,0,%s26
 2370      9A002F45 
 2371 2e10 00000000 		or	%s54,0,%s1
 2371      81003645 
 2372 2e18 00000000 		or	%s50,0,%s20
 2372      94003245 
 2373 2e20 00000000 		or	%s51,0,%s21
 2373      95003345 
 2374 2e28 00000000 		or	%s56,0,%s22
 2374      96003845 
 2375 2e30 78050000 		br.l	.L4.9
 2375      00000F18 
 2376              	.L4.10:
 2377              	# line 806
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_b, oh=oh_b; kh < kh_e; --oh, kh+=SH) {
 2378              		.loc	1 806 0
 2379 2e38 00000000 		adds.w.sx	%s57,1,%s57
 2379      B901394A 
 2380 2e40 00000000 		adds.w.sx	%s56,1,%s56
 2380      B801384A 
 2381 2e48 20030000 		brgt.w	0,%s57,.L4.11
 2381      B9008118 
 2382 2e50 A0FFFFFF 		br.l	.L4.8
 2382      00000F18 
 2383              	.L4.12:
 2384 2e58 00000000 		or	%s57,0,%s3
 2384      83003945 
 2385 2e60 00000000 		or	%s56,0,%s5
 2385      85003845 
 2386 2e68 00000000 		or	%s18,0,%s4
 2386      84001245 
 2387 2e70 00000000 		or	%s61,0,%s2
 2387      82003D45 
 2388 2e78 C0FFFFFF 		br.l	.L4.10
 2388      00000F18 
 2389              	.L4.13:
 2390              	# line 814
 809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   ds += ((float*)diff_dst_m)[dst_off]
 812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 2391              		.loc	1 814 0
 2392 2e80 00000000 		adds.w.sx	%s63,-1,%s63
 2392      BF7F3F4A 
 2393              	# line 807
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw+=SW) {
 2394              		.loc	1 807 0
 2395 2e88 00000000 		adds.w.sx	%s61,%s62,%s61
 2395      BDBE3D4A 
 2396 2e90 00000000 		adds.w.sx	%s60,%s60,%s62
 2396      BEBC3C4A 
 2397 2e98 70020000 		brgt.w	0,%s61,.L4.14
 2397      BD008118 
 2398 2ea0 B8FFFFFF 		br.l	.L4.12
 2398      00000F18 
 2399              	.L4.15:
 2400              	# line 813
 813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 2401              		.loc	1 813 0
 2402 2ea8 00000000 		or	%s59,1,(0)1
 2402      00013B45 
 2403 2eb0 00000000 		or	%s57,0,%s58
 2403      BA003945 
 2404 2eb8 00000000 		lvl	%s59
 2404      00BB00BF 
 2405 2ec0 0000003C 		vstu.nc	%v60,0,%s57
 2405      B9000092 
 2406 2ec8 B8FFFFFF 		br.l	.L4.13
 2406      00000F18 
 2407              	.L4.16:
 2408 2ed0 00000000 		or	%s1,0,%s59
 2408      BB000145 
 2409              	# line 811
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 2410              		.loc	1 811 0
 2411 2ed8 00000000 		lvl	%s55
 2411      00B700BF 
 2412 2ee0 00003F3B 		vfsum.s	%v59,%v63
 2412      000080EC 
 2413 2ee8 00000000 		or	%s59,1,(0)1
 2413      00013B45 
 2414 2ef0 00000000 		lvl	%s59
 2414      00BB00BF 
 2415 2ef8 003B3C3C 		vfadd.s	%v60,%v60,%v59
 2415      000080CC 
 2416 2f00 00000000 		or	%s63,0,%s54
 2416      B6003F45 
 2417 2f08 00000000 		or	%s62,0,%s53
 2417      B5003E45 
 2418 2f10 00000000 		or	%s61,0,%s52
 2418      B4003D45 
 2419 2f18 00000000 		or	%s60,0,%s51
 2419      B3003C45 
 2420 2f20 00000000 		or	%s58,0,%s50
 2420      B2003A45 
 2421 2f28 80FFFFFF 		br.l	.L4.15
 2421      00000F18 
 2422              	.L4.7:
 2423 2f30 00000000 		or	%s62,0,%s63
 2423      BF003E45 
 2424 2f38 00000000 		lvl	%s61
 2424      00BD00BF 
 2425 2f40 0000003E 		vldu.nc	%v62,-4,%s62
 2425      BE7C0082 
 2426 2f48 00000000 		or	%s62,0,%s60
 2426      BC003E45 
 2427 2f50 0000003D 		vldu.nc	%v61,%s59,%s62
 2427      BEBB0082 
 2428 2f58 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 2428      000080E2 
 2429              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2430              		.loc	1 808 0
 2431 2f60 00000000 		adds.l	%s63,%s63,%s58
 2431      BABF3F59 
 2432 2f68 00000000 		adds.l	%s60,%s60,%s57
 2432      B9BC3C59 
 2433 2f70 00000000 		subs.w.sx	%s56,%s56,%s61
 2433      BDB8385A 
 2434 2f78 58FFFFFF 		brge.w	0,%s56,.L4.16
 2434      B8008518 
 2435 2f80 60FEFFFF 		br.l	.L4.6
 2435      00000F18 
 2436              	.L4.17:
 2437              	# line 811
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 2438              		.loc	1 811 0
 2439 2f88 00000000 		divs.w.sx	%s47,%s49,%s48
 2439      B0B12F7B 
 2440 2f90 00000000 		or	%s59,0,%s1
 2440      81003B45 
 2441 2f98 00000000 		or	%s53,0,%s62
 2441      BE003545 
 2442 2fa0 00000000 		or	%s54,0,%s63
 2442      BF003645 
 2443 2fa8 00000000 		or	%s51,0,%s60
 2443      BC003345 
 2444 2fb0 00000000 		or	%s52,0,%s61
 2444      BD003445 
 2445 2fb8 00000000 		or	%s50,0,%s58
 2445      BA003245 
 2446 2fc0 00000000 		or	%s47,0,%s47
 2446      AF002F45 
 2447 2fc8 00000000 		addu.l	%s47,%s47,%s46
 2447      AEAF2F48 
 2448 2fd0 00000000 		addu.l	%s47,%s47,%s45
 2448      ADAF2F48 
 2449 2fd8 00000000 		mulu.l	%s47,%s47,%s44
 2449      ACAF2F49 
 2450 2fe0 00000000 		divu.l	%s62,%s43,%s42
 2450      AAAB3E6F 
 2451 2fe8 00000000 		addu.l	%s62,%s45,%s62
 2451      BEAD3E48 
 2452 2ff0 00000000 		mulu.l	%s62,%s62,%s41
 2452      A9BE3E49 
 2453 2ff8 00000000 		divu.l	%s62,%s62,%s42
 2453      AABE3E6F 
 2454 3000 00000000 		addu.l	%s62,%s62,%s40
 2454      A8BE3E48 
 2455 3008 00000000 		mulu.l	%s62,%s62,%s39
 2455      A7BE3E49 
 2456 3010 00000000 		or	%s7,0,%s63
 2456      BF000745 
 2457 3018 00000000 		addu.l	%s7,%s47,%s7
 2457      87AF0748 
 2458 3020 00000000 		mulu.l	%s7,%s7,%s38
 2458      A6870749 
 2459 3028 00000000 		or	%s7,0,%s7
 2459      87000745 
 2460 3030 00000000 		or	%s47,0,%s60
 2460      BC002F45 
 2461 3038 00000000 		addu.l	%s47,%s62,%s47
 2461      AFBE2F48 
 2462 3040 00000000 		mulu.l	%s47,%s47,%s37
 2462      A5AF2F49 
 2463 3048 00000000 		or	%s47,0,%s47
 2463      AF002F45 
 2464              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2465              		.loc	1 808 0
 2466 3050 00000000 		muls.l	%s47,4,%s47
 2466      AF042F6E 
 2467 3058 00000000 		muls.l	%s7,4,%s7
 2467      8704076E 
 2468 3060 00000000 		adds.l	%s47,%s47,%s36
 2468      A4AF2F59 
 2469 3068 00000000 		adds.l	%s7,%s7,%s35
 2469      A3870759 
 2470 3070 00000000 		subs.w.sx	%s62,0,%s34
 2470      A2003E5A 
 2471 3078 00000000 		smvl	%s55
 2471      0000372E 
 2472 3080 80000000 		mins.w.sx	%s61,%s62,%s55
 2472      B7BE3D78 
 2473              	# line 811
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 2474              		.loc	1 811 0
 2475 3088 00000000 		or	%s6,0,(0)1
 2475      00000645 
 2476 3090 00000000 		lvl	%s55
 2476      00B700BF 
 2477 3098 0000003F 		vbrdu	%v63,%s6
 2477      0086808C 
 2478 30a0 00000000 		or	%s56,0,%s62
 2478      BE003845 
 2479 30a8 00000000 		or	%s62,0,%s61
 2479      BD003E45 
 2480 30b0 00000000 		or	%s63,0,%s7
 2480      87003F45 
 2481              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2482              		.loc	1 808 0
 2483 30b8 00000000 		muls.l	%s58,-4,%s62
 2483      BE7C3A6E 
 2484 30c0 00000000 		or	%s60,0,%s47
 2484      AF003C45 
 2485 30c8 00000000 		muls.l	%s57,%s1,%s62
 2485      BE81396E 
 2486 30d0 60FEFFFF 		br.l	.L4.7
 2486      00000F18 
 2487              	.L4.18:
 2488 30d8 00000000 		or	%s57,1,(0)1
 2488      00013945 
 2489 30e0 00000000 		or	%s56,0,%s58
 2489      BA003845 
 2490 30e8 00000000 		lvl	%s57
 2490      00B900BF 
 2491 30f0 0000003C 		vldu.nc	%v60,0,%s56
 2491      B8000082 
 2492 30f8 90FEFFFF 		brlt.w	0,%s18,.L4.17
 2492      92008218 
 2493 3100 A8FDFFFF 		br.l	.L4.15
 2493      00000F18 
 2494              	.L4.14:
 2495 3108 D0FFFFFF 		brlt.w	0,%s18,.L4.18
 2495      92008218 
 2496 3110 70FDFFFF 		br.l	.L4.13
 2496      00000F18 
 2497              	.L4.19:
 2498 3118 00000000 		divs.w.sx	%s59,%s33,%s32
 2498      A0A13B7B 
 2499 3120 00000000 		or	%s2,0,%s61
 2499      BD000245 
 2500 3128 00000000 		or	%s3,0,%s57
 2500      B9000345 
 2501 3130 00000000 		or	%s4,0,%s18
 2501      92000445 
 2502 3138 00000000 		or	%s5,0,%s56
 2502      B8000545 
 2503 3140 00000000 		subs.w.sx	%s34,0,%s59
 2503      BB00225A 
 2504 3148 00000000 		or	%s45,0,%s56
 2504      B8002D45 
 2505              	# line 807
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw+=SW) {
 2506              		.loc	1 807 0
 2507 3150 00000000 		adds.w.sx	%s61,%s18,%s31
 2507      9F923D4A 
 2508 3158 00000000 		or	%s18,0,%s59
 2508      BB001245 
 2509 3160 A8FFFFFF 		br.l	.L4.14
 2509      00000F18 
 2510              	.L4.11:
 2511 3168 00000000 		or	%s60,0,%s18
 2511      92003C45 
 2512 3170 00000000 		or	%s63,0,%s61
 2512      BD003F45 
 2513 3178 A0FFFFFF 		brlt.w	%s18,%s19,.L4.19
 2513      93928218 
 2514 3180 B8FCFFFF 		br.l	.L4.10
 2514      00000F18 
 2515              	.L4.20:
 2516              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2517              		.loc	1 808 0
 2518 3188 00000000 		adds.w.sx	%s60,-1,%s20
 2518      947F3C4A 
 2519 3190 00000000 		or	%s20,0,%s50
 2519      B2001445 
 2520 3198 00000000 		subs.w.sx	%s60,%s60,%s35
 2520      A3BC3C5A 
 2521 31a0 00000000 		or	%s59,0,%s35
 2521      A3003B45 
 2522 31a8 00000000 		adds.w.sx	%s33,%s60,%s32
 2522      A0BC214A 
 2523              	# line 806
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_b, oh=oh_b; kh < kh_e; --oh, kh+=SH) {
 2524              		.loc	1 806 0
 2525 31b0 00000000 		divs.w.sx	%s60,%s47,%s45
 2525      ADAF3C7B 
 2526 31b8 00000000 		or	%s21,0,%s51
 2526      B3001545 
 2527 31c0 00000000 		or	%s22,0,%s56
 2527      B8001645 
 2528 31c8 00000000 		or	%s56,0,%s53
 2528      B5003845 
 2529 31d0 00000000 		or	%s23,0,%s63
 2529      BF001745 
 2530 31d8 00000000 		or	%s24,0,%s57
 2530      B9001845 
 2531 31e0 00000000 		or	%s25,0,%s45
 2531      AD001945 
 2532 31e8 00000000 		or	%s26,0,%s47
 2532      AF001A45 
 2533 31f0 00000000 		subs.w.sx	%s60,0,%s60
 2533      BC003C5A 
 2534 31f8 00000000 		or	%s57,0,%s60
 2534      BC003945 
 2535              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2536              		.loc	1 808 0
 2537 3200 00000000 		muls.l	%s59,4,%s59
 2537      BB043B6E 
 2538 3208 00000000 		or	%s55,0,%s55
 2538      B7003745 
 2539 3210 00000000 		muls.l	%s55,4,%s55
 2539      B704376E 
 2540 3218 00000000 		adds.l	%s36,%s59,%s30
 2540      9EBB2459 
 2541 3220 00000000 		adds.l	%s35,%s55,%s29
 2541      9DB72359 
 2542 3228 00000000 		or	%s1,0,%s54
 2542      B6000145 
 2543 3230 38FFFFFF 		br.l	.L4.11
 2543      00000F18 
 2544              	.L4.21:
 2545              	# line 806
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_b, oh=oh_b; kh < kh_e; --oh, kh+=SH) {
 2546              		.loc	1 806 0
 2547 3238 00000000 		or	%s53,0,(0)1
 2547      00003545 
 2548 3240 00000000 		divs.w.sx	%s21,%s47,%s45
 2548      ADAF157B 
 2549 3248 00000000 		or	%s35,0,%s57
 2549      B9002345 
 2550 3250 00000000 		or	%s57,0,%s1
 2550      81003945 
 2551 3258 30FFFFFF 		brlt.w	0,%s21,.L4.20
 2551      95008218 
 2552 3260 48010000 		br.l	.L4.9
 2552      00000F18 
 2553              	.L4.22:
 2554 3268 E8E6FFFF 		st	%s62,-6424(,%fp)	# spill 
 2554      89003E11 
 2555 3270 F0E6FFFF 		st	%s47,-6416(,%fp)	# spill 
 2555      89002F11 
 2556 3278 F8E6FFFF 		st	%s46,-6408(,%fp)	# spill 
 2556      89002E11 
 2557 3280 00E7FFFF 		st	%s44,-6400(,%fp)	# spill 
 2557      89002C11 
 2558 3288 08E7FFFF 		st	%s38,-6392(,%fp)	# spill 
 2558      89002611 
 2559 3290 10E7FFFF 		st	%s43,-6384(,%fp)	# spill 
 2559      89002B11 
 2560 3298 18E7FFFF 		st	%s41,-6376(,%fp)	# spill 
 2560      89002911 
 2561 32a0 20E7FFFF 		st	%s48,-6368(,%fp)	# spill 
 2561      89003011 
 2562 32a8 28E7FFFF 		st	%s42,-6360(,%fp)	# spill 
 2562      89002A11 
 2563 32b0 30E7FFFF 		st	%s39,-6352(,%fp)	# spill 
 2563      89002711 
 2564 32b8 38E7FFFF 		st	%s37,-6344(,%fp)	# spill 
 2564      89002511 
 2565 32c0 40E7FFFF 		st	%s30,-6336(,%fp)	# spill 
 2565      89001E11 
 2566 32c8 48E7FFFF 		st	%s29,-6328(,%fp)	# spill 
 2566      89001D11 
 2567 32d0 50E7FFFF 		st	%s32,-6320(,%fp)	# spill 
 2567      89002011 
 2568 32d8 58E7FFFF 		st	%s54,-6312(,%fp)	# spill 
 2568      89003611 
 2569 32e0 60E7FFFF 		st	%s49,-6304(,%fp)	# spill 
 2569      89003111 
 2570 32e8 E8E7FFFF 		ld	%s62,-6168(,%fp)	# restore 
 2570      89003E01 
 2571              	# line 786
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2572              		.loc	1 786 0
 2573 32f0 00000000 		subs.l	%s0,0,%s62
 2573      BE00005B 
 2574 32f8 00000000 		lea	%s12,__grow_stack@LO
 2574      00000C06 
 2575 3300 00000000 		and	%s12,%s12,(32)0
 2575      608C0C44 
 2576 3308 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2576      8C008C06 
 2577 3310 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2577      8C000A08 
 2578 3318 A0E7FFFF 		ld	%s61,-6240(,%fp)	# restore 
 2578      89003D01 
 2579 3320 70E7FFFF 		ld	%s57,-6288(,%fp)	# restore 
 2579      89003901 
 2580 3328 68E7FFFF 		ld	%s53,-6296(,%fp)	# restore 
 2580      89003501 
 2581 3330 D0E7FFFF 		ld	%s50,-6192(,%fp)	# restore 
 2581      89003201 
 2582 3338 C8E7FFFF 		ld	%s24,-6200(,%fp)	# restore 
 2582      89001801 
 2583 3340 C0E7FFFF 		ld	%s25,-6208(,%fp)	# restore 
 2583      89001901 
 2584 3348 B8E7FFFF 		ld	%s26,-6216(,%fp)	# restore 
 2584      89001A01 
 2585 3350 B0E7FFFF 		ld	%s29,-6224(,%fp)	# restore 
 2585      89001D01 
 2586 3358 A8E7FFFF 		ld	%s60,-6232(,%fp)	# restore 
 2586      89003C01 
 2587 3360 98E7FFFF 		ld	%s52,-6248(,%fp)	# restore 
 2587      89003401 
 2588 3368 90E7FFFF 		ld	%s30,-6256(,%fp)	# restore 
 2588      89001E01 
 2589 3370 88E7FFFF 		ld	%s23,-6264(,%fp)	# restore 
 2589      89001701 
 2590 3378 F8E7FFFF 		ld	%s63,-6152(,%fp)	# restore 
 2590      89003F01 
 2591 3380 80E7FFFF 		ld	%s56,-6272(,%fp)	# restore 
 2591      89003801 
 2592 3388 78E7FFFF 		ld	%s55,-6280(,%fp)	# restore 
 2592      89003701 
 2593 3390 30070000 		br.l	.L4.23
 2593      00000F18 
 2594              	.L4.24:
 2595 3398 00000000 		or	%s1,0,%s57
 2595      B9000145 
 2596 33a0 40000000 		br.l	.L4.25
 2596      00000F18 
 2597              	.L4.9:
 2598              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2599              		.loc	1 808 0
 2600 33a8 00000000 		adds.l	%s58,4,%s58
 2600      BA043A59 
 2601 33b0 00000000 		adds.l	%s63,4,%s63
 2601      BF043F59 
 2602 33b8 00000000 		adds.w.sx	%s57,-1,%s57
 2602      B97F394A 
 2603 33c0 D8FFFFFF 		brlt.w	0,%s57,.L4.24
 2603      B9008218 
 2604 33c8 A0FEFFFF 		br.l	.L4.22
 2604      00000F18 
 2605              	.L4.26:
 2606 33d0 00000000 		or	%s57,0,%s1
 2606      81003945 
 2607 33d8 D0FFFFFF 		br.l	.L4.9
 2607      00000F18 
 2608              	.L4.25:
 2609              	# line 803
 803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if( kh_b >= kh_e || kw_b >= kw_e ) continue;
 2610              		.loc	1 803 0
 2611 33e0 00000000 		ldl.sx	%s57,0(%s63,%s50)
 2611      B2BF3903 
 2612 33e8 00000000 		ldl.sx	%s55,0(%s63,%s51)
 2612      B3BF3703 
 2613 33f0 00000000 		ldl.sx	%s20,0(%s63,%s56)
 2613      B8BF1403 
 2614 33f8 D8FFFFFF 		brge.w	%s57,%s20,.L4.26
 2614      94B98518 
 2615 3400 38FEFFFF 		br.l	.L4.21
 2615      00000F18 
 2616              	.L4.27:
 2617 3408 D0E7FFFF 		st	%s1,-6192(,%fp)	# spill 
 2617      89000111 
 2618 3410 C8E7FFFF 		st	%s24,-6200(,%fp)	# spill 
 2618      89001811 
 2619 3418 C0E7FFFF 		st	%s25,-6208(,%fp)	# spill 
 2619      89001911 
 2620 3420 B8E7FFFF 		st	%s26,-6216(,%fp)	# spill 
 2620      89001A11 
 2621 3428 B0E7FFFF 		st	%s38,-6224(,%fp)	# spill 
 2621      89002611 
 2622 3430 A8E7FFFF 		st	%s60,-6232(,%fp)	# spill 
 2622      89003C11 
 2623 3438 D8E7FFFF 		st	%s54,-6184(,%fp)	# spill 
 2623      89003611 
 2624 3440 E0E7FFFF 		st	%s36,-6176(,%fp)	# spill 
 2624      89002411 
 2625 3448 A0E7FFFF 		st	%s29,-6240(,%fp)	# spill 
 2625      89001D11 
 2626 3450 98E7FFFF 		st	%s52,-6248(,%fp)	# spill 
 2626      89003411 
 2627 3458 90E7FFFF 		st	%s30,-6256(,%fp)	# spill 
 2627      89001E11 
 2628 3460 88E7FFFF 		st	%s23,-6264(,%fp)	# spill 
 2628      89001711 
 2629 3468 F8E7FFFF 		st	%s2,-6152(,%fp)	# spill 
 2629      89000211 
 2630 3470 80E7FFFF 		st	%s3,-6272(,%fp)	# spill 
 2630      89000311 
 2631 3478 78E7FFFF 		st	%s32,-6280(,%fp)	# spill 
 2631      89002011 
 2632 3480 70E7FFFF 		st	%s4,-6288(,%fp)	# spill 
 2632      89000411 
 2633 3488 E8E7FFFF 		st	%s22,-6168(,%fp)	# spill 
 2633      89001611 
 2634 3490 68E7FFFF 		st	%s37,-6296(,%fp)	# spill 
 2634      89002511 
 2635 3498 00000000 		or	%s1,0,%s39
 2635      A7000145 
 2636 34a0 00000000 		or	%s58,0,%s31
 2636      9F003A45 
 2637              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2638              		.loc	1 808 0
 2639 34a8 00000000 		or	%s63,0,(0)1
 2639      00003F45 
 2640 34b0 00000000 		or	%s56,0,%s33
 2640      A1003845 
 2641 34b8 00000000 		or	%s45,0,%s21
 2641      95002D45 
 2642 34c0 00000000 		or	%s31,0,%s20
 2642      94001F45 
 2643 34c8 60E7FFFF 		ld	%s49,-6304(,%fp)	# restore 
 2643      89003101 
 2644 34d0 58E7FFFF 		ld	%s54,-6312(,%fp)	# restore 
 2644      89003601 
 2645 34d8 50E7FFFF 		ld	%s32,-6320(,%fp)	# restore 
 2645      89002001 
 2646 34e0 48E7FFFF 		ld	%s29,-6328(,%fp)	# restore 
 2646      89001D01 
 2647 34e8 40E7FFFF 		ld	%s30,-6336(,%fp)	# restore 
 2647      89001E01 
 2648 34f0 38E7FFFF 		ld	%s37,-6344(,%fp)	# restore 
 2648      89002501 
 2649 34f8 30E7FFFF 		ld	%s39,-6352(,%fp)	# restore 
 2649      89002701 
 2650 3500 28E7FFFF 		ld	%s42,-6360(,%fp)	# restore 
 2650      89002A01 
 2651 3508 20E7FFFF 		ld	%s48,-6368(,%fp)	# restore 
 2651      89003001 
 2652 3510 18E7FFFF 		ld	%s41,-6376(,%fp)	# restore 
 2652      89002901 
 2653 3518 10E7FFFF 		ld	%s43,-6384(,%fp)	# restore 
 2653      89002B01 
 2654 3520 08E7FFFF 		ld	%s38,-6392(,%fp)	# restore 
 2654      89002601 
 2655 3528 00E7FFFF 		ld	%s44,-6400(,%fp)	# restore 
 2655      89002C01 
 2656 3530 F8E6FFFF 		ld	%s46,-6408(,%fp)	# restore 
 2656      89002E01 
 2657 3538 F0E6FFFF 		ld	%s47,-6416(,%fp)	# restore 
 2657      89002F01 
 2658 3540 E8E6FFFF 		ld	%s62,-6424(,%fp)	# restore 
 2658      89003E01 
 2659 3548 98FEFFFF 		br.l	.L4.25
 2659      00000F18 
 2660              	.L4.5:
 2661              	# line 795
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_b = kw_e / SW;
 2662              		.loc	1 795 0
 2663 3550 00000000 		adds.l	%s57,%s63,%s58
 2663      BABF3959 
 2664 3558 00000000 		lvl	%s55
 2664      00B700BF 
 2665 3560 00000035 		vldl.sx.nc	%v53,4,%s57
 2665      B9040083 
 2666 3568 00350034 		vcmps.w.sx	%v52,%s54,%v53
 2666      00B620FA 
 2667 3570 0034010F 		vfmk.w.gt	%vm15,%v52
 2667      000000B5 
 2668              	# line 796
 796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               kw_b = kw_e % SW;
 2669              		.loc	1 796 0
 2670 3578 003A0033 		vadds.w.sx	%v51,%s56,%v58
 2670      00B820CA 
 2671 3580 00003339 		vdivs.w.sx	%v57,%v51,%s60,%vm15
 2671      00BC1FEB 
 2672 3588 00000000 		adds.l	%s5,%s53,%s58
 2672      BAB50559 
 2673 3590 00000039 		vstl.nc	%v57,4,%s5,%vm15
 2673      85040F93 
 2674 3598 00000000 		or	%s5,0,%s5
 2674      85000545 
 2675              	# line 797
 797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 2676              		.loc	1 797 0
 2677 35a0 00000032 		vldl.sx.nc	%v50,4,%s5
 2677      85040083 
 2678 35a8 00320038 		vmuls.w.sx	%v56,%s60,%v50,%vm15
 2678      00BC2FCB 
 2679 35b0 003A0031 		vadds.w.sx	%v49,%s56,%v58
 2679      00B820CA 
 2680 35b8 00383137 		vsubs.w.sx	%v55,%v49,%v56,%vm15
 2680      00000FDA 
 2681 35c0 00000000 		or	%s57,0,%s57
 2681      B9003945 
 2682 35c8 00000037 		vstl.nc	%v55,4,%s57,%vm15
 2682      B9040F93 
 2683              	# line 799
 799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if (kw_b >= kw_e ) continue;
 2684              		.loc	1 799 0
 2685 35d0 00000000 		adds.l	%s57,%s47,%s58
 2685      BAAF3959 
 2686 35d8 00000030 		vldl.sx.nc	%v48,4,%s57
 2686      B9040083 
 2687 35e0 0030002F 		vadds.w.sx	%v47,1,%v48
 2687      000120CA 
 2688 35e8 00000000 		adds.l	%s57,%s45,%s58
 2688      BAAD3959 
 2689 35f0 0000002F 		vstl.nc	%v47,4,%s57
 2689      B9040093 
 2690 35f8 002F002E 		vor	%v46,(0)1,%v47
 2690      000020C5 
 2691 3600 002E002D 		vcmps.w.sx	%v45,%s36,%v46
 2691      00A420FA 
 2692 3608 002D020F 		vfmk.w.lt	%vm15,%v45
 2692      000000B5 
 2693 3610 00000036 		vbrd	%v54,%s36,%vm15
 2693      00A40F8C 
 2694 3618 00000000 		or	%s57,0,%s57
 2694      B9003945 
 2695 3620 00000036 		vstl.nc	%v54,4,%s57,%vm15
 2695      B9040F93 
 2696 3628 00000000 		adds.w.sx	%s56,%s56,%s35
 2696      A3B8384A 
 2697 3630 00000000 		or	%s34,0,%s34
 2697      A2002245 
 2698 3638 00000000 		adds.l	%s58,%s58,%s34
 2698      A2BA3A59 
 2699 3640 00000000 		or	%s34,0,%s7
 2699      87002245 
 2700 3648 00000000 		subs.w.sx	%s6,%s6,%s55
 2700      B786065A 
 2701 3650 B8FDFFFF 		brge.w	0,%s6,.L4.27
 2701      86008518 
 2702 3658 68F7FFFF 		br.l	.L4.4
 2702      00000F18 
 2703              	.L4.28:
 2704              	# line 795
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_b = kw_e / SW;
 2705              		.loc	1 795 0
 2706 3660 80000000 		mins.w.sx	%s59,%s32,%s21
 2706      95A03B78 
 2707 3668 00000000 		or	%s63,0,%s62
 2707      BE003F45 
 2708 3670 00000000 		or	%s53,0,%s48
 2708      B0003545 
 2709 3678 00000000 		or	%s47,0,%s46
 2709      AE002F45 
 2710 3680 00000000 		or	%s45,0,%s49
 2710      B1002D45 
 2711 3688 00000000 		or	%s62,0,%s6
 2711      86003E45 
 2712 3690 00000000 		or	%s6,0,%s32
 2712      A0000645 
 2713 3698 00000000 		or	%s56,0,%s29
 2713      9D003845 
 2714 36a0 00000000 		or	%s35,0,%s59
 2714      BB002345 
 2715 36a8 00000000 		lvl	%s59
 2715      00BB00BF 
 2716 36b0 00000019 		vseq	%v25
 2716      00000099 
 2717 36b8 00000000 		or	%s37,0,%s5
 2717      85002545 
 2718 36c0 00000000 		or	%s38,0,%s29
 2718      9D002645 
 2719 36c8 00000000 		or	%s29,0,%s62
 2719      BE001D45 
 2720 36d0 00000000 		or	%s39,0,%s32
 2720      A0002745 
 2721 36d8 00000000 		or	%s32,0,%s55
 2721      B7002045 
 2722 36e0 00000000 		or	%s55,0,%s59
 2722      BB003745 
 2723 36e8 0019003A 		vor	%v58,(0)1,%v25
 2723      000020C5 
 2724 36f0 00000000 		muls.w.sx	%s34,4,%s59
 2724      BB04224B 
 2725 36f8 00000000 		or	%s58,0,(0)1
 2725      00003A45 
 2726 3700 00000000 		muls.w.sx	%s62,4,%s21
 2726      95043E4B 
 2727 3708 00000000 		or	%s21,0,%s7
 2727      87001545 
 2728 3710 00000000 		or	%s7,0,%s62
 2728      BE000745 
 2729 3718 E0E7FFFF 		ld	%s36,-6176(,%fp)	# restore 
 2729      89002401 
 2730 3720 D8E7FFFF 		ld	%s54,-6184(,%fp)	# restore 
 2730      89003601 
 2731 3728 28FEFFFF 		br.l	.L4.5
 2731      00000F18 
 2732              	.L4.29:
 2733              	# line 794
 794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_b < SW - 1 ){ // unlikely?
 2734              		.loc	1 794 0
 2735 3730 00000000 		adds.w.sx	%s57,%s63,%s60
 2735      BCBF394A 
 2736              	# line 789
 789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if( ocend == 0 ) continue;
 2737              		.loc	1 789 0
 2738 3738 00000000 		or	%s45,0,(0)1
 2738      00002D45 
 2739 3740 00000000 		stu	%s45,0(,%s58)	# *(ds)
 2739      BA002D12 
 2740 3748 00000000 		stl	%s56,0(%s53,%s54)
 2740      B6B53813 
 2741 3750 00000000 		stl	%s52,0(%s53,%s51)
 2741      B3B53413 
 2742 3758 00000000 		stl	%s57,0(%s53,%s50)
 2742      B2B53913 
 2743 3760 00000000 		adds.w.sx	%s56,1,%s56
 2743      B801384A 
 2744 3768 00000000 		adds.w.sx	%s63,1,%s63
 2744      BF013F4A 
 2745 3770 00000000 		adds.l	%s58,4,%s58
 2745      BA043A59 
 2746 3778 00000000 		adds.l	%s53,4,%s53
 2746      B5043559 
 2747 3780 00000000 		adds.w.sx	%s47,-1,%s47
 2747      AF7F2F4A 
 2748 3788 A8FFFFFF 		brlt.w	0,%s47,.L4.29
 2748      AF008218 
 2749 3790 D0FEFFFF 		br.l	.L4.28
 2749      00000F18 
 2750              	.L4.30:
 2751 3798 F8E7FFFF 		st	%s63,-6152(,%fp)	# spill 
 2751      89003F11 
 2752 37a0 00000000 		divs.w.sx	%s62,%s23,%s45
 2752      AD973E7B 
 2753 37a8 00000000 		or	%s62,0,%s62
 2753      BE003E45 
 2754 37b0 00000000 		addu.l	%s62,%s62,%s24
 2754      98BE3E48 
 2755 37b8 00000000 		addu.l	%s62,%s62,%s40
 2755      A8BE3E48 
 2756 37c0 00000000 		mulu.l	%s62,%s62,%s25
 2756      99BE3E49 
 2757 37c8 00000000 		or	%s59,0,%s1
 2757      81003B45 
 2758 37d0 00000000 		addu.l	%s59,%s62,%s59
 2758      BBBE3B48 
 2759 37d8 00000000 		mulu.l	%s59,%s59,%s26
 2759      9ABB3B49 
 2760 37e0 00000000 		or	%s59,0,%s59
 2760      BB003B45 
 2761              	# line 786
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2762              		.loc	1 786 0
 2763 37e8 00000000 		muls.l	%s59,4,%s59
 2763      BB043B6E 
 2764 37f0 00000000 		adds.l	%s31,%s59,%s27
 2764      9BBB1F59 
 2765 37f8 00000000 		or	%s63,0,%s28
 2765      9C003F45 
 2766 3800 F0E7FFFF 		st	%s63,-6160(,%fp)	# spill 
 2766      89003F11 
 2767 3808 00000000 		or	%s3,0,%s56
 2767      B8000345 
 2768 3810 00000000 		or	%s56,0,%s29
 2768      9D003845 
 2769              	# line 807
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int kw = kw_b, ow=ow_b; kw < kw_e; --ow, kw+=SW) {
 2770              		.loc	1 807 0
 2771 3818 00000000 		subs.w.sx	%s20,0,%s19
 2771      9300145A 
 2772              	# line 786
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2773              		.loc	1 786 0
 2774 3820 00000000 		subs.w.sx	%s32,0,%s30
 2774      9E00205A 
 2775 3828 00000000 		smvl	%s21
 2775      0000152E 
 2776 3830 00000000 		muls.l	%s0,16,%s32
 2776      A010006E 
 2777 3838 E8E7FFFF 		st	%s0,-6168(,%fp)	# spill 
 2777      89000011 
 2778 3840 00000000 		lea	%s12,__grow_stack@LO
 2778      00000C06 
 2779 3848 00000000 		and	%s12,%s12,(32)0
 2779      608C0C44 
 2780 3850 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2780      8C008C06 
 2781 3858 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2781      8C000A08 
 2782 3860 D0000000 		lea	%s62,208
 2782      00003E06 
 2783 3868 00000000 		adds.l	%s62,%sp,%s62
 2783      BE8B3E59 
 2784 3870 F0E7FFFF 		ld	%s63,-6160(,%fp)	# restore 
 2784      89003F01 
 2785 3878 00000000 		or	%s59,0,%s50
 2785      B2003B45 
 2786 3880 00000000 		or	%s50,0,%s62
 2786      BE003245 
 2787 3888 00000000 		muls.w.sx	%s49,4,%s32
 2787      A004314B 
 2788 3890 F8E7FFFF 		ld	%s2,-6152(,%fp)	# restore 
 2788      89000201 
 2789 3898 00000000 		or	%s4,0,%s57
 2789      B9000445 
 2790 38a0 00000000 		adds.l	%s48,%s62,%s49
 2790      B1BE3059 
 2791 38a8 00000000 		or	%s5,0,%s53
 2791      B5000545 
 2792 38b0 00000000 		or	%s51,0,%s48
 2792      B0003345 
 2793 38b8 00000000 		adds.l	%s46,%s48,%s49
 2793      B1B02E59 
 2794 38c0 00000000 		or	%s6,0,%s1
 2794      81000645 
 2795 38c8 00000000 		or	%s54,0,%s46
 2795      AE003645 
 2796 38d0 00000000 		adds.l	%s49,%s46,%s49
 2796      B1AE3159 
 2797 38d8 00000000 		or	%s1,0,%s59
 2797      BB000145 
 2798 38e0 00000000 		or	%s33,0,%s49
 2798      B1002145 
 2799 38e8 00000000 		or	%s47,0,%s32
 2799      A0002F45 
 2800 38f0 00000000 		or	%s58,0,%s31
 2800      9F003A45 
 2801 38f8 00000000 		or	%s53,0,(0)1
 2801      00003545 
 2802 3900 00000000 		or	%s7,0,%s45
 2802      AD000745 
 2803 3908 E8E7FFFF 		ld	%s22,-6168(,%fp)	# restore 
 2803      89001601 
 2804 3910 20FEFFFF 		br.l	.L4.29
 2804      00000F18 
 2805              	.L4.31:
 2806 3918 80FEFFFF 		brlt.w	0,%s50,.L4.30
 2806      B2008218 
 2807 3920 00000000 		or	%s61,0,%s1
 2807      81003D45 
 2808 3928 98010000 		br.l	.L4.23
 2808      00000F18 
 2809              	.L4.32:
 2810              	# line 769
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(parallel for collapse(3))//;
 2811              		.loc	1 769 0
 2812 3930 00000000 		adds.w.sx	%s63,1,%s63
 2812      BF013F4A 
 2813 3938 00000000 		adds.l	%s53,%s61,%s53
 2813      B5BD3559 
 2814 3940 00000000 		adds.l	%s49,%s55,%s49
 2814      B1B73159 
 2815 3948 C0050000 		brgt.w	0,%s63,.L4.33
 2815      BF008118 
 2816 3950 20080000 		br.l	.L4.34
 2816      00000F18 
 2817              	.L4.35:
 2818 3958 60CEFFFF 		ld	%s63,-12704(,%fp)	# restore 
 2818      89003F01 
 2819 3960 58CEFFFF 		ld	%s61,-12712(,%fp)	# restore 
 2819      89003D01 
 2820 3968 48CEFFFF 		ld	%s53,-12728(,%fp)	# restore 
 2820      89003501 
 2821 3970 50CEFFFF 		ld	%s49,-12720(,%fp)	# restore 
 2821      89003101 
 2822 3978 40CEFFFF 		ld	%s59,-12736(,%fp)	# restore 
 2822      89003B01 
 2823 3980 B0FFFFFF 		br.l	.L4.32
 2823      00000F18 
 2824              	.L4.36:
 2825              	# line 771
 771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 2826              		.loc	1 771 0
 2827 3988 00000000 		adds.w.sx	%s63,1,%s63
 2827      BF013F4A 
 2828 3990 00000000 		adds.w.sx	%s23,%s57,%s23
 2828      97B9174A 
 2829 3998 00000000 		adds.w.sx	%s49,%s56,%s49
 2829      B1B8314A 
 2830 39a0 00000000 		adds.l	%s53,%s55,%s53
 2830      B5B73559 
 2831 39a8 D8040000 		brgt.w	0,%s63,.L4.37
 2831      BF008118 
 2832 39b0 A8FFFFFF 		br.l	.L4.35
 2832      00000F18 
 2833              	.L4.38:
 2834 39b8 80CEFFFF 		ld	%s63,-12672(,%fp)	# restore 
 2834      89003F01 
 2835 39c0 68CEFFFF 		ld	%s57,-12696(,%fp)	# restore 
 2835      89003901 
 2836 39c8 88CEFFFF 		ld	%s56,-12664(,%fp)	# restore 
 2836      89003801 
 2837 39d0 60E7FFFF 		ld	%s49,-6304(,%fp)	# restore 
 2837      89003101 
 2838 39d8 78CEFFFF 		ld	%s55,-12680(,%fp)	# restore 
 2838      89003701 
 2839 39e0 70CEFFFF 		ld	%s53,-12688(,%fp)	# restore 
 2839      89003501 
 2840 39e8 90CEFFFF 		ld	%s19,-12656(,%fp)	# restore 
 2840      89001301 
 2841 39f0 98FFFFFF 		br.l	.L4.36
 2841      00000F18 
 2842              	.L4.39:
 2843 39f8 10040000 		br.l	.L4.40
 2843      00000F18 
 2844              	.L4.41:
 2845              	# line 772
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2846              		.loc	1 772 0
 2847 3a00 00000000 		adds.w.sx	%s63,1,%s63
 2847      BF013F4A 
 2848 3a08 00000000 		adds.w.sx	%s61,1,%s61
 2848      BD013D4A 
 2849 3a10 E8FFFFFF 		brgt.w	0,%s63,.L4.39
 2849      BF008118 
 2850 3a18 A0FFFFFF 		br.l	.L4.38
 2850      00000F18 
 2851              	.L4.42:
 2852 3a20 98CEFFFF 		ld	%s59,-12648(,%fp)	# restore 
 2852      89003B01 
 2853              	# line 773
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 2854              		.loc	1 773 0
 2855 3a28 00000000 		subs.l	%s0,0,%s59
 2855      BB00005B 
 2856 3a30 00000000 		lea	%s12,__grow_stack@LO
 2856      00000C06 
 2857 3a38 00000000 		and	%s12,%s12,(32)0
 2857      608C0C44 
 2858 3a40 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2858      8C008C06 
 2859 3a48 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2859      8C000A08 
 2860 3a50 C0CEFFFF 		ld	%s63,-12608(,%fp)	# restore 
 2860      89003F01 
 2861 3a58 00000000 		or	%s54,0,%s50
 2861      B2003645 
 2862 3a60 B8CEFFFF 		ld	%s61,-12616(,%fp)	# restore 
 2862      89003D01 
 2863 3a68 C8CEFFFF 		ld	%s18,-12600(,%fp)	# restore 
 2863      89001201 
 2864 3a70 A0CEFFFF 		ld	%s33,-12640(,%fp)	# restore 
 2864      89002101 
 2865 3a78 E8E6FFFF 		ld	%s62,-6424(,%fp)	# restore 
 2865      89003E01 
 2866 3a80 E0E6FFFF 		ld	%s51,-6432(,%fp)	# restore 
 2866      89003301 
 2867 3a88 D8E6FFFF 		ld	%s35,-6440(,%fp)	# restore 
 2867      89002301 
 2868 3a90 D0E6FFFF 		ld	%s58,-6448(,%fp)	# restore 
 2868      89003A01 
 2869 3a98 A8CEFFFF 		ld	%s32,-12632(,%fp)	# restore 
 2869      89002001 
 2870 3aa0 B0CEFFFF 		ld	%s31,-12624(,%fp)	# restore 
 2870      89001F01 
 2871 3aa8 58FFFFFF 		br.l	.L4.41
 2871      00000F18 
 2872              	.L4.43:
 2873 3ab0 00000000 		or	%s1,0,%s61
 2873      BD000145 
 2874 3ab8 40000000 		br.l	.L4.44
 2874      00000F18 
 2875              	.L4.23:
 2876              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2877              		.loc	1 808 0
 2878 3ac0 00000000 		adds.w.sx	%s61,1,%s61
 2878      BD013D4A 
 2879 3ac8 00000000 		adds.l	%s57,4,%s57
 2879      B9043959 
 2880 3ad0 00000000 		adds.w.sx	%s53,-1,%s53
 2880      B57F354A 
 2881 3ad8 D8FFFFFF 		brlt.w	0,%s53,.L4.43
 2881      B5008218 
 2882 3ae0 40FFFFFF 		br.l	.L4.42
 2882      00000F18 
 2883              	.L4.45:
 2884 3ae8 00000000 		or	%s61,0,%s1
 2884      81003D45 
 2885 3af0 D0FFFFFF 		br.l	.L4.23
 2885      00000F18 
 2886              	.L4.44:
 2887              	# line 783
 783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 2888              		.loc	1 783 0
 2889 3af8 00000000 		ldl.sx	%s18,0(%s57,%s63)
 2889      BFB91203 
 2890 3b00 00000000 		ldl.sx	%s61,0(%s57,%s56)
 2890      B8B93D03 
 2891 3b08 00000000 		ldl.sx	%s19,0(%s57,%s55)
 2891      B7B91303 
 2892 3b10 D8FFFFFF 		brge.w	%s18,%s19,.L4.45
 2892      93928518 
 2893 3b18 00FEFFFF 		br.l	.L4.31
 2893      00000F18 
 2894              	.L4.46:
 2895 3b20 E8E6FFFF 		st	%s62,-6424(,%fp)	# spill 
 2895      89003E11 
 2896 3b28 E0E6FFFF 		st	%s51,-6432(,%fp)	# spill 
 2896      89003311 
 2897 3b30 D8E6FFFF 		st	%s35,-6440(,%fp)	# spill 
 2897      89002311 
 2898 3b38 D0E6FFFF 		st	%s58,-6448(,%fp)	# spill 
 2898      89003A11 
 2899 3b40 00000000 		or	%s53,0,%s59
 2899      BB003545 
 2900              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 2901              		.loc	1 808 0
 2902 3b48 00000000 		or	%s1,0,(0)1
 2902      00000145 
 2903 3b50 00000000 		or	%s57,0,(0)1
 2903      00003945 
 2904 3b58 00000000 		or	%s50,0,%s54
 2904      B6003245 
 2905 3b60 00000000 		or	%s55,0,%s49
 2905      B1003745 
 2906 3b68 00000000 		or	%s56,0,%s48
 2906      B0003845 
 2907 3b70 00000000 		or	%s63,0,%s47
 2907      AF003F45 
 2908 3b78 80FFFFFF 		br.l	.L4.44
 2908      00000F18 
 2909              	.L4.3:
 2910 3b80 00000000 		lvl	%s61
 2910      00BD00BF 
 2911 3b88 002C002B 		vadds.w.sx	%v43,%s63,%v44
 2911      00BF20CA 
 2912 3b90 002B0025 		vor	%v37,(0)1,%v43
 2912      000020C5 
 2913              	# line 778
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             oh_b = kh_e / SH;
 2914              		.loc	1 778 0
 2915 3b98 00000024 		vbrd	%v36,%s58
 2915      00BA008C 
 2916 3ba0 00000000 		adds.l	%s4,%s57,%s56
 2916      B8B90459 
 2917 3ba8 00000024 		vstl.nc	%v36,4,%s4
 2917      84040093 
 2918 3bb0 002A0023 		vadds.w.sx	%v35,%s55,%v42
 2918      00B720CA 
 2919 3bb8 00230022 		vadds.w.sx	%v34,%s62,%v35
 2919      00BE20CA 
 2920 3bc0 00000000 		adds.l	%s3,%s53,%s56
 2920      B8B50359 
 2921 3bc8 00000022 		vstl.nc	%v34,4,%s3
 2921      83040093 
 2922 3bd0 00220021 		vor	%v33,(0)1,%v34
 2922      000020C5 
 2923 3bd8 00210020 		vcmps.w.sx	%v32,%s51,%v33
 2923      00B320FA 
 2924 3be0 0020010F 		vfmk.w.gt	%vm15,%v32
 2924      000000B5 
 2925              	# line 779
 779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             kh_b = kh_e % SH;
 2926              		.loc	1 779 0
 2927 3be8 002C001F 		vadds.w.sx	%v31,%s63,%v44
 2927      00BF20CA 
 2928 3bf0 00001F29 		vdivs.w.sx	%v41,%v31,%s62,%vm15
 2928      00BE1FEB 
 2929 3bf8 00000000 		or	%s2,0,%s4
 2929      84000245 
 2930 3c00 00000029 		vstl.nc	%v41,4,%s2,%vm15
 2930      82040F93 
 2931 3c08 00000000 		or	%s4,0,%s4
 2931      84000445 
 2932              	# line 780
 780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 2933              		.loc	1 780 0
 2934 3c10 0000001E 		vldl.sx.nc	%v30,4,%s4
 2934      84040083 
 2935 3c18 001E0028 		vmuls.w.sx	%v40,%s62,%v30,%vm15
 2935      00BE2FCB 
 2936 3c20 002C001D 		vadds.w.sx	%v29,%s63,%v44
 2936      00BF20CA 
 2937 3c28 00281D27 		vsubs.w.sx	%v39,%v29,%v40,%vm15
 2937      00000FDA 
 2938 3c30 00000000 		or	%s3,0,%s3
 2938      83000345 
 2939 3c38 00000027 		vstl.nc	%v39,4,%s3,%vm15
 2939      83040F93 
 2940              	# line 782
 782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           if( kh_b >= kh_e ) continue;
 2941              		.loc	1 782 0
 2942 3c40 0025001C 		vadds.w.sx	%v28,1,%v37
 2942      000120CA 
 2943 3c48 00000000 		adds.l	%s4,%s50,%s56
 2943      B8B20459 
 2944 3c50 0000001C 		vstl.nc	%v28,4,%s4
 2944      84040093 
 2945 3c58 001C001B 		vor	%v27,(0)1,%v28
 2945      000020C5 
 2946 3c60 001B001A 		vcmps.w.sx	%v26,%s35,%v27
 2946      00A320FA 
 2947 3c68 001A020F 		vfmk.w.lt	%vm15,%v26
 2947      000000B5 
 2948 3c70 00000026 		vbrd	%v38,%s35,%vm15
 2948      00A30F8C 
 2949 3c78 00000000 		or	%s4,0,%s4
 2949      84000445 
 2950 3c80 00000026 		vstl.nc	%v38,4,%s4,%vm15
 2950      84040F93 
 2951 3c88 00000000 		adds.w.sx	%s63,%s63,%s34
 2951      A2BF3F4A 
 2952 3c90 00000000 		adds.w.sx	%s55,%s55,%s34
 2952      A2B7374A 
 2953 3c98 00000000 		or	%s7,0,%s7
 2953      87000745 
 2954 3ca0 00000000 		adds.l	%s56,%s56,%s7
 2954      87B83859 
 2955 3ca8 00000000 		or	%s7,0,%s6
 2955      86000745 
 2956 3cb0 00000000 		subs.w.sx	%s5,%s5,%s61
 2956      BD85055A 
 2957 3cb8 68FEFFFF 		brge.w	0,%s5,.L4.46
 2957      85008518 
 2958 3cc0 D0F0FFFF 		br.l	.L4.2
 2958      00000F18 
 2959              	.L4.47:
 2960 3cc8 C8CEFFFF 		st	%s18,-12600(,%fp)	# spill 
 2960      89001211 
 2961 3cd0 C0CEFFFF 		st	%s63,-12608(,%fp)	# spill 
 2961      89003F11 
 2962 3cd8 B8CEFFFF 		st	%s61,-12616(,%fp)	# spill 
 2962      89003D11 
 2963 3ce0 B0CEFFFF 		st	%s31,-12624(,%fp)	# spill 
 2963      89001F11 
 2964 3ce8 A8CEFFFF 		st	%s32,-12632(,%fp)	# spill 
 2964      89002011 
 2965 3cf0 A0CEFFFF 		st	%s33,-12640(,%fp)	# spill 
 2965      89002111 
 2966 3cf8 00000000 		or	%s40,0,%s61
 2966      BD002845 
 2967 3d00 00000000 		or	%s55,0,%s31
 2967      9F003745 
 2968              	# line 773
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 2969              		.loc	1 773 0
 2970 3d08 00000000 		subs.w.sx	%s59,0,%s32
 2970      A0003B5A 
 2971 3d10 00000000 		smvl	%s31
 2971      00001F2E 
 2972 3d18 00000000 		muls.l	%s0,12,%s59
 2972      BB0C006E 
 2973 3d20 98CEFFFF 		st	%s0,-12648(,%fp)	# spill 
 2973      89000011 
 2974 3d28 00000000 		lea	%s12,__grow_stack@LO
 2974      00000C06 
 2975 3d30 00000000 		and	%s12,%s12,(32)0
 2975      608C0C44 
 2976 3d38 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 2976      8C008C06 
 2977 3d40 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 2977      8C000A08 
 2978 3d48 D0000000 		lea	%s46,208
 2978      00002E06 
 2979 3d50 00000000 		adds.l	%s53,%sp,%s46
 2979      AE8B3559 
 2980 3d58 00000000 		smvl	%s13
 2980      00000D2E 
 2981 3d60 00000000 		lvl	%s13
 2981      008D00BF 
 2982 3d68 00000000 		or	%s47,0,%s53
 2982      B5002F45 
 2983 3d70 00000000 		muls.w.sx	%s46,4,%s59
 2983      BB042E4B 
 2984 3d78 00000000 		adds.l	%s57,%s53,%s46
 2984      AEB53959 
 2985 3d80 00000000 		or	%s48,0,%s57
 2985      B9003045 
 2986 3d88 00000000 		adds.l	%s50,%s57,%s46
 2986      AEB93259 
 2987 3d90 00000000 		or	%s49,0,%s50
 2987      B2003145 
 2988 3d98 80000000 		mins.w.sx	%s61,%s59,%s31
 2988      9FBB3D78 
 2989 3da0 00000000 		or	%s5,0,%s59
 2989      BB000545 
 2990 3da8 00000000 		or	%s63,0,%s33
 2990      A1003F45 
 2991 3db0 00F0FFFF 		lea	%s13,-4096(,%fp)	# restore
 2991      89000D06 
 2992 3db8 00000026 		vld	%v38,8,%s13 	# restore
 2992      8D084081 
 2993 3dc0 00000000 		lvl	%s61
 2993      00BD00BF 
 2994 3dc8 00000018 		vseq	%v24
 2994      00000099 
 2995 3dd0 0018002C 		vor	%v44,(0)1,%v24
 2995      000020C5 
 2996 3dd8 00000000 		or	%s34,0,%s61
 2996      BD002245 
 2997 3de0 0018002A 		vor	%v42,(0)1,%v24
 2997      000020C5 
 2998 3de8 00000000 		muls.w.sx	%s7,4,%s61
 2998      BD04074B 
 2999 3df0 00000000 		or	%s56,0,(0)1
 2999      00003845 
 3000 3df8 00000000 		muls.w.sx	%s6,4,%s31
 3000      9F04064B 
 3001 3e00 80FDFFFF 		br.l	.L4.3
 3001      00000F18 
 3002              	.L4.40:
 3003 3e08 C0FEFFFF 		brlt.w	0,%s18,.L4.47
 3003      92008218 
 3004 3e10 F0FBFFFF 		br.l	.L4.41
 3004      00000F18 
 3005              	.L4.48:
 3006 3e18 90CEFFFF 		st	%s19,-12656(,%fp)	# spill 
 3006      89001311 
 3007 3e20 88CEFFFF 		st	%s56,-12664(,%fp)	# spill 
 3007      89003811 
 3008 3e28 60E7FFFF 		st	%s49,-6304(,%fp)	# spill 
 3008      89003111 
 3009 3e30 80CEFFFF 		st	%s63,-12672(,%fp)	# spill 
 3009      89003F11 
 3010 3e38 78CEFFFF 		st	%s55,-12680(,%fp)	# spill 
 3010      89003711 
 3011 3e40 70CEFFFF 		st	%s53,-12688(,%fp)	# spill 
 3011      89003511 
 3012 3e48 68CEFFFF 		st	%s57,-12696(,%fp)	# spill 
 3012      89003911 
 3013              	# line 772
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 3014              		.loc	1 772 0
 3015 3e50 00000000 		divs.w.sx	%s57,%s57,%s45
 3015      ADB9397B 
 3016 3e58 00000000 		subs.w.sx	%s57,0,%s57
 3016      B900395A 
 3017 3e60 00000000 		or	%s63,0,%s57
 3017      B9003F45 
 3018 3e68 00000000 		or	%s43,0,%s53
 3018      B5002B45 
 3019 3e70 10E7FFFF 		st	%s43,-6384(,%fp)	# spill 
 3019      89002B11 
 3020 3e78 90FFFFFF 		br.l	.L4.40
 3020      00000F18 
 3021              	.L4.37:
 3022 3e80 00000000 		or	%s61,0,(0)1
 3022      00003D45 
 3023 3e88 90FFFFFF 		brlt.w	0,%s19,.L4.48
 3023      93008218 
 3024 3e90 F8FAFFFF 		br.l	.L4.36
 3024      00000F18 
 3025              	.L4.49:
 3026 3e98 60CEFFFF 		st	%s63,-12704(,%fp)	# spill 
 3026      89003F11 
 3027 3ea0 58CEFFFF 		st	%s61,-12712(,%fp)	# spill 
 3027      89003D11 
 3028 3ea8 50CEFFFF 		st	%s49,-12720(,%fp)	# spill 
 3028      89003111 
 3029 3eb0 48CEFFFF 		st	%s53,-12728(,%fp)	# spill 
 3029      89003511 
 3030 3eb8 40CEFFFF 		st	%s59,-12736(,%fp)	# spill 
 3030      89003B11 
 3031 3ec0 00000000 		divs.w.sx	%s19,%s57,%s45
 3031      ADB9137B 
 3032 3ec8 00000000 		or	%s24,0,%s53
 3032      B5001845 
 3033 3ed0 00000000 		or	%s46,0,%s49
 3033      B1002E45 
 3034 3ed8 F8E6FFFF 		st	%s46,-6408(,%fp)	# spill 
 3034      89002E11 
 3035 3ee0 00000000 		or	%s63,0,%s59
 3035      BB003F45 
 3036              	# line 771
 771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 3037              		.loc	1 771 0
 3038 3ee8 00000000 		or	%s23,0,(0)1
 3038      00001745 
 3039 3ef0 00000000 		or	%s49,0,(0)1
 3039      00003145 
 3040 3ef8 00000000 		or	%s53,0,(0)1
 3040      00003545 
 3041 3f00 80FFFFFF 		br.l	.L4.37
 3041      00000F18 
 3042              	.L4.33:
 3043 3f08 90FFFFFF 		brlt.w	0,%s45,.L4.49
 3043      AD008218 
 3044 3f10 20FAFFFF 		br.l	.L4.32
 3044      00000F18 
 3045              	.L4.50:
 3046 3f18 00000000 		dldl.sx	%s45,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3046      80002D0B 
 3047 3f20 00000000 		subs.w.sx	%s59,0,%s45
 3047      AD003B5A 
 3048              	# line 769
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(parallel for collapse(3))//;
 3049              		.loc	1 769 0
 3050 3f28 00000000 		or	%s53,0,(0)1
 3050      00003545 
 3051 3f30 00000000 		or	%s49,0,(0)1
 3051      00003145 
 3052              	# line 772
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 3053              		.loc	1 772 0
 3054 3f38 08000000 		dldl.sx	%s57,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 3054      8000390B 
 3055 3f40 00000000 		or	%s50,0,%s57
 3055      B9003245 
 3056 3f48 00000000 		or	%s61,0,%s50
 3056      B2003D45 
 3057              	# line 769
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(parallel for collapse(3))//;
 3058              		.loc	1 769 0
 3059 3f50 00000000 		subs.w.sx	%s50,0,%s18
 3059      9200325A 
 3060 3f58 00000000 		or	%s63,0,%s50
 3060      B2003F45 
 3061              	# line 773
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 3062              		.loc	1 773 0
 3063 3f60 0C000000 		dldl.sx	%s18,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 3063      8000120B 
 3064 3f68 00000000 		or	%s25,0,%s18
 3064      92001945 
 3065 3f70 00000000 		subs.w.sx	%s32,0,%s18
 3065      9200205A 
 3066              	# line 778
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             oh_b = kh_e / SH;
 3067              		.loc	1 778 0
 3068 3f78 30000000 		dldl.sx	%s33,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 3068      8000210B 
 3069 3f80 18000000 		dldl.sx	%s50,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 3069      8000320B 
 3070 3f88 00000000 		adds.w.sx	%s58,-1,%s50
 3070      B27F3A4A 
 3071 3f90 28000000 		dldl.sx	%s62,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 3071      80003E0B 
 3072 3f98 00000000 		muls.w.sx	%s50,%s50,%s62
 3072      BEB2324B 
 3073              	# line 773
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 3074              		.loc	1 773 0
 3075 3fa0 00000000 		subs.w.sx	%s31,%s33,%s50
 3075      B2A11F5A 
 3076              	# line 778
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             oh_b = kh_e / SH;
 3077              		.loc	1 778 0
 3078 3fa8 00000000 		adds.w.sx	%s51,-1,%s62
 3078      BE7F334A 
 3079              	# line 782
 782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           if( kh_b >= kh_e ) continue;
 3080              		.loc	1 782 0
 3081 3fb0 20000000 		dldl.sx	%s35,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 3081      8000230B 
 3082              	# line 786
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 3083              		.loc	1 786 0
 3084 3fb8 10000000 		dldl.sx	%s54,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 3084      8000360B 
 3085 3fc0 00000000 		or	%s26,0,%s54
 3085      B6001A45 
 3086 3fc8 00000000 		subs.w.sx	%s30,0,%s54
 3086      B6001E5A 
 3087              	# line 789
 789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if( ocend == 0 ) continue;
 3088              		.loc	1 789 0
 3089 3fd0 A8010000 		dld	%s27,424(,%s1)	# *(diff_src_m).data_
 3089      81001B09 
 3090              	# line 792
 792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int ow_b = OW - 1;
 3091              		.loc	1 792 0
 3092 3fd8 34000000 		dldl.sx	%s29,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 3092      80001D0B 
 3093              	# line 793
 793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             int kw_b = kw_e - OW*SW + SW;
 3094              		.loc	1 793 0
 3095 3fe0 1C000000 		dldl.sx	%s50,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 3095      8000320B 
 3096 3fe8 00000000 		adds.w.sx	%s52,-1,%s50
 3096      B27F344A 
 3097              	# line 794
 794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             if( kw_b < SW - 1 ){ // unlikely?
 3098              		.loc	1 794 0
 3099 3ff0 2C000000 		dldl.sx	%s60,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 3099      80003C0B 
 3100 3ff8 00000000 		muls.w.sx	%s50,%s50,%s60
 3100      BCB2324B 
 3101              	# line 786
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 3102              		.loc	1 786 0
 3103 4000 00000000 		subs.w.sx	%s28,%s29,%s50
 3103      B29D1C5A 
 3104              	# line 795
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_b = kw_e / SW;
 3105              		.loc	1 795 0
 3106 4008 00000000 		adds.w.sx	%s50,-1,%s60
 3106      BC7F324A 
 3107              	# line 799
 799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //if (kw_b >= kw_e ) continue;
 3108              		.loc	1 799 0
 3109 4010 24000000 		dldl.sx	%s36,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 3109      8000240B 
 3110 4018 D8E7FFFF 		st	%s50,-6184(,%fp)	# spill 
 3110      89003211 
 3111 4020 E0E7FFFF 		st	%s36,-6176(,%fp)	# spill 
 3111      89002411 
 3112              	# line 806
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int kh = kh_b, oh=oh_b; kh < kh_e; --oh, kh+=SH) {
 3113              		.loc	1 806 0
 3114 4028 14000000 		dldl.sx	%s47,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 3114      80002F0B 
 3115              	# line 808
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3116              		.loc	1 808 0
 3117 4030 2C000000 		dldl.sx	%s50,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 3117      8000320B 
 3118 4038 F0E6FFFF 		st	%s47,-6416(,%fp)	# spill 
 3118      89002F11 
 3119 4040 50E7FFFF 		st	%s50,-6320(,%fp)	# spill 
 3119      89003211 
 3120 4048 00000000 		or	%s50,0,%s50
 3120      B2003245 
 3121 4050 00000000 		muls.l	%s50,4,%s50
 3121      B204326E 
 3122 4058 A8010000 		dld	%s3,424(,%s3)	# *(s$72).data_
 3122      83000309 
 3123 4060 58E7FFFF 		st	%s50,-6312(,%fp)	# spill 
 3123      89003211 
 3124 4068 48E7FFFF 		st	%s3,-6328(,%fp)	# spill 
 3124      89000311 
 3125 4070 A8010000 		dld	%s2,424(,%s2)	# *(s$74).data_
 3125      82000209 
 3126              	# line 811
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     * ((float*)wei_m)[wei_off];
 3127              		.loc	1 811 0
 3128 4078 14000000 		dldl.sx	%s56,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 3128      8000380B 
 3129 4080 40E7FFFF 		st	%s2,-6336(,%fp)	# spill 
 3129      89000211 
 3130 4088 00000000 		or	%s50,0,%s56
 3130      B8003245 
 3131 4090 00000000 		or	%s55,0,%s50
 3131      B2003745 
 3132 4098 00000000 		dldl.sx	%s48,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3132      8000300B 
 3133 40a0 20E7FFFF 		st	%s48,-6368(,%fp)	# spill 
 3133      89003011 
 3134 40a8 00000000 		or	%s42,0,%s48
 3134      B0002A45 
 3135 40b0 28E7FFFF 		st	%s42,-6360(,%fp)	# spill 
 3135      89002A11 
 3136 40b8 18000000 		dldl.sx	%s50,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 3136      8000320B 
 3137 40c0 00000000 		or	%s44,0,%s50
 3137      B2002C45 
 3138 40c8 00E7FFFF 		st	%s44,-6400(,%fp)	# spill 
 3138      89002C11 
 3139 40d0 1C000000 		dldl.sx	%s50,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 3139      8000320B 
 3140 40d8 00000000 		or	%s38,0,%s50
 3140      B2002645 
 3141 40e0 08E7FFFF 		st	%s38,-6392(,%fp)	# spill 
 3141      89002611 
 3142 40e8 08000000 		dldl.sx	%s50,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 3142      8000320B 
 3143 40f0 00000000 		or	%s41,0,%s50
 3143      B2002945 
 3144 40f8 18E7FFFF 		st	%s41,-6376(,%fp)	# spill 
 3144      89002911 
 3145 4100 20000000 		dldl.sx	%s50,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 3145      8000320B 
 3146 4108 00000000 		or	%s39,0,%s50
 3146      B2002745 
 3147 4110 30E7FFFF 		st	%s39,-6352(,%fp)	# spill 
 3147      89002711 
 3148 4118 24000000 		dldl.sx	%s0,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 3148      8000000B 
 3149 4120 00000000 		or	%s37,0,%s0
 3149      80002545 
 3150 4128 38E7FFFF 		st	%s37,-6344(,%fp)	# spill 
 3150      89002511 
 3151 4130 D8FDFFFF 		br.l	.L4.33
 3151      00000F18 
 3152              	.L4.51:
 3153              	# line 769
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(parallel for collapse(3))//;
 3154              		.loc	1 769 0
 3155 4138 04000000 		ldl.sx	%s18,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 3155      80001203 
 3156 4140 D8FDFFFF 		brlt.w	0,%s18,.L4.50
 3156      92008218 
 3157 4148 28000000 		br.l	.L4.34
 3157      00000F18 
 3158              	.L4.52:
 3159 4150 D0000000 		br.l	.L4.53
 3159      00000F18 
 3160              	.L4.1:
 3161              	# line 763
 763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // FIXME can we call this even less?
 3162              		.loc	1 763 0
 3163 4158 3C000000 		ldl.sx	%s18,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 3163      80001203 
 3164 4160 F0FFFFFF 		brne.w	0,%s18,.L4.52
 3164      92008318 
 3165 4168 D0FFFFFF 		br.l	.L4.51
 3165      00000F18 
 3166              	.L4.34:
 3167              	# line 824
 815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #error "please enable one impl"
 823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
 824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 3168              		.loc	1 824 0
 3169              	# Start of epilogue codes
 3170 4170 30000000 		ld	%s18,48(,%fp)
 3170      89001201 
 3171 4178 38000000 		ld	%s19,56(,%fp)
 3171      89001301 
 3172 4180 40000000 		ld	%s20,64(,%fp)
 3172      89001401 
 3173 4188 48000000 		ld	%s21,72(,%fp)
 3173      89001501 
 3174 4190 50000000 		ld	%s22,80(,%fp)
 3174      89001601 
 3175 4198 58000000 		ld	%s23,88(,%fp)
 3175      89001701 
 3176 41a0 60000000 		ld	%s24,96(,%fp)
 3176      89001801 
 3177 41a8 68000000 		ld	%s25,104(,%fp)
 3177      89001901 
 3178 41b0 70000000 		ld	%s26,112(,%fp)
 3178      89001A01 
 3179 41b8 78000000 		ld	%s27,120(,%fp)
 3179      89001B01 
 3180 41c0 80000000 		ld	%s28,128(,%fp)
 3180      89001C01 
 3181 41c8 88000000 		ld	%s29,136(,%fp)
 3181      89001D01 
 3182 41d0 90000000 		ld	%s30,144(,%fp)
 3182      89001E01 
 3183 41d8 98000000 		ld	%s31,152(,%fp)
 3183      89001F01 
 3184 41e0 A0000000 		ld	%s32,160(,%fp)
 3184      89002001 
 3185 41e8 A8000000 		ld	%s33,168(,%fp)
 3185      89002101 
 3186 41f0 00000000 		or	%sp,0,%fp
 3186      89000B45 
 3187              		.cfi_def_cfa	11,8
 3188 41f8 18000000 		ld	%got,0x18(,%sp)
 3188      8B000F01 
 3189 4200 20000000 		ld	%plt,0x20(,%sp)
 3189      8B001001 
 3190 4208 08000000 		ld	%lr,0x8(,%sp)
 3190      8B000A01 
 3191 4210 00000000 		ld	%fp,0x0(,%sp)
 3191      8B000901 
 3192 4218 00000000 		b.l	(,%lr)
 3192      8A000F19 
 3193              	.L4.53:
 3194              	# line 765
 765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     return;
 3195              		.loc	1 765 0
 3196 4220 00000000 		lea	%s12,_ZN35_INTERNAL_13_ref_conv5_cpp_202f7a294conv23refconv_5_bwd_d_genericEPKNS0_5prb_tER9dnn
 3196      00000C06 
 3197 4228 00000000 		and	%s12,%s12,(32)0
 3197      608C0C44 
 3198 4230 00000000 		lea.sl	%s12,_ZN35_INTERNAL_13_ref_conv5_cpp_202f7a294conv23refconv_5_bwd_d_genericEPKNS0_5prb_tER9
 3198      8C008C06 
 3199 4238 00000000 		bsic	%lr,(,%s12)	# _ZN35_INTERNAL_13_ref_conv5_cpp_202f7a294conv23refconv_5_bwd_d_genericEPKNS0_5p
 3199      8C000A08 
 3200 4240 30FFFFFF 		br.l	.L4.34
 3200      00000F18 
 3201              	.L4.0:
 3202 4248 D8FFFFFF 		br.l	.L4.53
 3202      00000F18 
 3203              		.cfi_endproc
 3204              		.set	.L.5.2auto_size,	0xffffffffffff9ab0	# 25936 Bytes
 3206              	# ============ End  conv::refconv_5_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3207              	# ============ Begin  conv::refconv_5_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3208              		.balign 16
 3209              	# line 829
 825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** /** This one just reuses the hoisting function from FWD.
 827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****  * g,oc,ic,kh,kw,mb,oh,ow,[iw],[ih] */
 828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** void refconv_5_bwd_w(const prb_t *p, dnn_mem_t &src_m,
 829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
 3210              		.loc	1 829 0
 3211              		.globl	conv::refconv_5_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 3213              	conv::refconv_5_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 3214              		.cfi_startproc
 3215 4250 00000000 		st	%fp,0x0(,%sp)
 3215      8B000911 
 3216              		.cfi_def_cfa_offset	0
 3217              		.cfi_offset	9,0
 3218 4258 08000000 		st	%lr,0x8(,%sp)
 3218      8B000A11 
 3219 4260 18000000 		st	%got,0x18(,%sp)
 3219      8B000F11 
 3220 4268 20000000 		st	%plt,0x20(,%sp)
 3220      8B001011 
 3221 4270 00000000 		or	%fp,0,%sp
 3221      8B000945 
 3222              		.cfi_def_cfa_register	9
 3223 4278 30000000 		st	%s18,48(,%fp)
 3223      89001211 
 3224 4280 38000000 		st	%s19,56(,%fp)
 3224      89001311 
 3225 4288 40000000 		st	%s20,64(,%fp)
 3225      89001411 
 3226 4290 48000000 		st	%s21,72(,%fp)
 3226      89001511 
 3227 4298 50000000 		st	%s22,80(,%fp)
 3227      89001611 
 3228 42a0 58000000 		st	%s23,88(,%fp)
 3228      89001711 
 3229 42a8 60000000 		st	%s24,96(,%fp)
 3229      89001811 
 3230 42b0 68000000 		st	%s25,104(,%fp)
 3230      89001911 
 3231 42b8 70000000 		st	%s26,112(,%fp)
 3231      89001A11 
 3232 42c0 78000000 		st	%s27,120(,%fp)
 3232      89001B11 
 3233 42c8 80000000 		st	%s28,128(,%fp)
 3233      89001C11 
 3234 42d0 88000000 		st	%s29,136(,%fp)
 3234      89001D11 
 3235 42d8 90000000 		st	%s30,144(,%fp)
 3235      89001E11 
 3236 42e0 98000000 		st	%s31,152(,%fp)
 3236      89001F11 
 3237 42e8 A0000000 		st	%s32,160(,%fp)
 3237      89002011 
 3238 42f0 A8000000 		st	%s33,168(,%fp)
 3238      89002111 
 3239 42f8 40FAFFFF 		lea	%s13,.L.6.2auto_size&0xffffffff
 3239      00000D06 
 3240 4300 00000000 		and	%s13,%s13,(32)0
 3240      608D0D44 
 3241 4308 FFFFFFFF 		lea.sl	%sp,.L.6.2auto_size>>32(%fp,%s13)
 3241      8D898B06 
 3242 4310 48000000 		brge.l.t	%sp,%sl,.L5.EoP
 3242      888B3518 
 3243 4318 18000000 		ld	%s61,0x18(,%tp)
 3243      8E003D01 
 3244 4320 00000000 		or	%s62,0,%s0
 3244      80003E45 
 3245 4328 3B010000 		lea	%s63,0x13b
 3245      00003F06 
 3246 4330 00000000 		shm.l	%s63,0x0(%s61)
 3246      BD033F31 
 3247 4338 08000000 		shm.l	%sl,0x8(%s61)
 3247      BD030831 
 3248 4340 10000000 		shm.l	%sp,0x10(%s61)
 3248      BD030B31 
 3249 4348 00000000 		monc
 3249      0000003F 
 3250 4350 00000000 		or	%s0,0,%s62
 3250      BE000045 
 3251              	.L5.EoP:
 3252              	# End of prologue codes
 3253              	# line 837
 830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #if 0
 831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 1 // same, but tidy code
 832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   // regr.sh-BWD_W 2.51x,2.51x
 833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   // TRY : nog offset?
 834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   OMP(parallel)//;
 835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   {
 836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     OMP(for collapse(5))//;
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int g = 0; g < G; ++g) {
 3254              		.loc	1 837 0
 3255 4358 00000000 		ldl.sx	%s43,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3255      80002B03 
 3256 4360 C8210000 		brlt.w	0,%s43,.L5.0
 3256      AB008218 
 3257 4368 781E0000 		br.l	.L5.1
 3257      00000F18 
 3258              	.L5.2:
 3259              	# line 841
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 3260              		.loc	1 841 0
 3261 4370 80000000 		mins.w.sx	%s62,%s59,%s62
 3261      BEBB3E78 
 3262 4378 A81F0000 		br.l	.L5.3
 3262      00000F18 
 3263              	.L5.4:
 3264              	# line 858
 842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               dw = 0;
 845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
 851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     OMP(for collapse(4))//;
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int g = 0; g < G; ++g) {
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               oh_beg = div_floor(       + PH - kh*(p->dh+1) + SH - 1, SH);//(c-a+b-1)/b
 3265              		.loc	1 858 0
 3266 4380 00000000 		or	%s63,0,(0)1
 3266      00003F45 
 3267 4388 00000000 		or	%s20,0,%s53
 3267      B5001445 
 3268 4390 00000000 		or	%s53,0,%s63
 3268      BF003545 
 3269 4398 00000000 		or	%s19,0,%s62
 3269      BE001345 
 3270 43a0 C8170000 		br.l	.L5.5
 3270      00000F18 
 3271              	.L5.6:
 3272              	# line 859
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               oh_end = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 3273              		.loc	1 859 0
 3274 43a8 00000000 		or	%s52,0,(0)1
 3274      00003445 
 3275 43b0 00000000 		or	%s51,0,%s53
 3275      B5003345 
 3276 43b8 00000000 		or	%s53,0,%s20
 3276      94003545 
 3277 43c0 00000000 		or	%s62,0,%s19
 3277      93003E45 
 3278 43c8 E8150000 		br.l	.L5.7
 3278      00000F18 
 3279              	.L5.8:
 3280              	# line 866
 860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_end > OH) oh_end = OH;
 862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int ow_beg, ow_end;
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_beg = div_floor(       + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
 864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_end = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
 866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (ow_end > OW) ow_end = OW;
 3281              		.loc	1 866 0
 3282 43d0 80000000 		mins.w.sx	%s50,%s1,%s50
 3282      B2813278 
 3283 43d8 D0170000 		br.l	.L5.9
 3283      00000F18 
 3284              	.L5.10:
 3285 43e0 00000000 		smvl	%s13
 3285      00000D2E 
 3286 43e8 00000000 		lvl	%s13
 3286      008D00BF 
 3287 43f0 003C003B 		vor	%v59,(0)1,%v60
 3287      000020C5 
 3288 43f8 70010000 		br.l	.L5.11
 3288      00000F18 
 3289              	.L5.12:
 3290              	# line 874
 867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
 868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ic = 0; ic < IC/G; ++ic) {
 870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 float &dw = ((float*)diff_wei_m)[wei_off];
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int mb = 0; mb < MB; ++mb) {
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 3291              		.loc	1 874 0
 3292 4400 80000000 		mins.w.sx	%s61,%s56,%s61
 3292      BDB83D78 
 3293 4408 E8010000 		br.l	.L5.13
 3293      00000F18 
 3294              	.L5.14:
 3295 4410 E8FFFFFF 		ld	%s53,-24(,%fp)	# restore 
 3295      89003501 
 3296 4418 00000000 		or	%s51,0,%s25
 3296      99003345 
 3297 4420 F0FFFFFF 		ld	%s52,-16(,%fp)	# restore 
 3297      89003401 
 3298 4428 00000000 		or	%s58,0,%s30
 3298      9E003A45 
 3299 4430 F8FFFFFF 		ld	%s50,-8(,%fp)	# restore 
 3299      89003201 
 3300 4438 00000000 		or	%s63,0,%s26
 3300      9A003F45 
 3301 4440 E0FFFFFF 		ld	%s41,-32(,%fp)	# restore 
 3301      89002901 
 3302 4448 00000000 		or	%s57,0,%s27
 3302      9B003945 
 3303 4450 D8FFFFFF 		ld	%s46,-40(,%fp)	# restore 
 3303      89002E01 
 3304 4458 00000000 		or	%s55,0,%s28
 3304      9C003745 
 3305 4460 D0FFFFFF 		ld	%s59,-48(,%fp)	# restore 
 3305      89003B01 
 3306 4468 00000000 		or	%s54,0,%s29
 3306      9D003645 
 3307 4470 C0FFFFFF 		ld	%s34,-64(,%fp)	# restore 
 3307      89002201 
 3308 4478 C8FFFFFF 		ld	%s45,-56(,%fp)	# restore 
 3308      89002D01 
 3309 4480 A8FFFFFF 		ld	%s5,-88(,%fp)	# restore 
 3309      89000501 
 3310 4488 B0FFFFFF 		ld	%s6,-80(,%fp)	# restore 
 3310      89000601 
 3311 4490 B8FFFFFF 		ld	%s7,-72(,%fp)	# restore 
 3311      89000701 
 3312 4498 18130000 		br.l	.L5.15
 3312      00000F18 
 3313              	.L5.16:
 3314              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 3315              		.loc	1 869 0
 3316 44a0 00000000 		adds.w.sx	%s63,1,%s63
 3316      BF013F4A 
 3317 44a8 00000000 		adds.l	%s57,%s60,%s57
 3317      B9BC3959 
 3318 44b0 00000000 		adds.w.sx	%s58,1,%s58
 3318      BA013A4A 
 3319 44b8 F8030000 		brgt.w	0,%s63,.L5.17
 3319      BF008118 
 3320 44c0 50FFFFFF 		br.l	.L5.14
 3320      00000F18 
 3321              	.L5.18:
 3322 44c8 00000000 		or	%s63,0,%s22
 3322      96003F45 
 3323 44d0 00000000 		or	%s60,0,%s23
 3323      97003C45 
 3324 44d8 00000000 		or	%s58,0,%s24
 3324      98003A45 
 3325 44e0 C0FFFFFF 		br.l	.L5.16
 3325      00000F18 
 3326              	.L5.19:
 3327              	# line 872
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 3328              		.loc	1 872 0
 3329 44e8 00000000 		adds.w.sx	%s63,1,%s63
 3329      BF013F4A 
 3330 44f0 00000000 		adds.l	%s58,%s61,%s58
 3330      BABD3A59 
 3331 44f8 00000000 		adds.l	%s55,%s56,%s55
 3331      B7B83759 
 3332 4500 50030000 		brgt.w	0,%s63,.L5.20
 3332      BF008118 
 3333 4508 C0FFFFFF 		br.l	.L5.18
 3333      00000F18 
 3334              	.L5.21:
 3335 4510 00000000 		or	%s63,0,%s2
 3335      82003F45 
 3336 4518 00000000 		or	%s61,0,%s3
 3336      83003D45 
 3337 4520 00000000 		or	%s58,0,%s6
 3337      86003A45 
 3338 4528 00000000 		or	%s56,0,%s4
 3338      84003845 
 3339 4530 00000000 		or	%s55,0,%s5
 3339      85003745 
 3340 4538 B0FFFFFF 		br.l	.L5.19
 3340      00000F18 
 3341              	.L5.22:
 3342              	# line 873
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 3343              		.loc	1 873 0
 3344 4540 00000000 		adds.w.sx	%s63,1,%s63
 3344      BF013F4A 
 3345 4548 00000000 		adds.w.sx	%s61,%s62,%s61
 3345      BDBE3D4A 
 3346 4550 00000000 		adds.w.sx	%s60,1,%s60
 3346      BC013C4A 
 3347 4558 80020000 		brgt.w	0,%s63,.L5.23
 3347      BF008118 
 3348 4560 B0FFFFFF 		br.l	.L5.21
 3348      00000F18 
 3349              	.L5.11:
 3350              	# line 881
 875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int iw = ow * SW - PW + kw * (p->dw + 1);
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       dw += ((float*)diff_dst_m)[dst_off]
 880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     }
 3351              		.loc	1 881 0
 3352 4568 00000000 		or	%s59,1,(0)1
 3352      00013B45 
 3353 4570 00000000 		or	%s58,0,%s57
 3353      B9003A45 
 3354 4578 00000000 		lvl	%s59
 3354      00BB00BF 
 3355 4580 0000003B 		vstu.nc	%v59,0,%s58
 3355      BA000092 
 3356 4588 B8FFFFFF 		br.l	.L5.22
 3356      00000F18 
 3357              	.L5.24:
 3358 4590 00000000 		or	%s1,0,%s59
 3358      BB000145 
 3359              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 3360              		.loc	1 879 0
 3361 4598 00000000 		lvl	%s55
 3361      00B700BF 
 3362 45a0 00003F3A 		vfsum.s	%v58,%v63
 3362      000080EC 
 3363 45a8 00000000 		or	%s59,1,(0)1
 3363      00013B45 
 3364 45b0 00000000 		lvl	%s59
 3364      00BB00BF 
 3365 45b8 003A3B3B 		vfadd.s	%v59,%v59,%v58
 3365      000080CC 
 3366 45c0 00000000 		or	%s63,0,%s54
 3366      B6003F45 
 3367 45c8 00000000 		or	%s62,0,%s53
 3367      B5003E45 
 3368 45d0 00000000 		or	%s61,0,%s52
 3368      B4003D45 
 3369 45d8 00000000 		or	%s60,0,%s51
 3369      B3003C45 
 3370 45e0 00000000 		or	%s57,0,%s50
 3370      B2003945 
 3371 45e8 80FFFFFF 		br.l	.L5.11
 3371      00000F18 
 3372              	.L5.13:
 3373 45f0 00000000 		or	%s62,0,%s63
 3373      BF003E45 
 3374 45f8 00000000 		lvl	%s61
 3374      00BD00BF 
 3375 4600 0000003E 		vldu.nc	%v62,4,%s62
 3375      BE040082 
 3376 4608 00000000 		or	%s62,0,%s60
 3376      BC003E45 
 3377 4610 0000003D 		vldu.nc	%v61,%s59,%s62
 3377      BEBB0082 
 3378 4618 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 3378      000080E2 
 3379              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 3380              		.loc	1 874 0
 3381 4620 00000000 		adds.l	%s63,%s63,%s58
 3381      BABF3F59 
 3382 4628 00000000 		adds.l	%s60,%s60,%s57
 3382      B9BC3C59 
 3383 4630 00000000 		subs.w.sx	%s56,%s56,%s61
 3383      BDB8385A 
 3384 4638 58FFFFFF 		brge.w	0,%s56,.L5.24
 3384      B8008518 
 3385 4640 C0FDFFFF 		br.l	.L5.12
 3385      00000F18 
 3386              	.L5.25:
 3387              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 3388              		.loc	1 879 0
 3389 4648 00000000 		divs.w.sx	%s47,%s49,%s48
 3389      B0B12F7B 
 3390 4650 00000000 		or	%s59,0,%s1
 3390      81003B45 
 3391 4658 00000000 		or	%s53,0,%s62
 3391      BE003545 
 3392 4660 00000000 		or	%s51,0,%s60
 3392      BC003345 
 3393 4668 00000000 		or	%s52,0,%s61
 3393      BD003445 
 3394 4670 00000000 		or	%s54,0,%s63
 3394      BF003645 
 3395 4678 00000000 		or	%s50,0,%s57
 3395      B9003245 
 3396 4680 00000000 		smvl	%s13
 3396      00000D2E 
 3397 4688 00000000 		lvl	%s13
 3397      008D00BF 
 3398 4690 003C003B 		vor	%v59,(0)1,%v60
 3398      000020C5 
 3399 4698 00000000 		or	%s47,0,%s47
 3399      AF002F45 
 3400 46a0 00000000 		addu.l	%s47,%s47,%s46
 3400      AEAF2F48 
 3401 46a8 00000000 		addu.l	%s47,%s47,%s45
 3401      ADAF2F48 
 3402 46b0 00000000 		mulu.l	%s47,%s47,%s44
 3402      ACAF2F49 
 3403 46b8 00000000 		or	%s62,0,%s61
 3403      BD003E45 
 3404 46c0 00000000 		addu.l	%s62,%s47,%s62
 3404      BEAF3E48 
 3405 46c8 00000000 		mulu.l	%s62,%s62,%s43
 3405      ABBE3E49 
 3406 46d0 00000000 		or	%s62,0,%s62
 3406      BE003E45 
 3407 46d8 00000000 		divs.w.sx	%s47,%s42,%s48
 3407      B0AA2F7B 
 3408 46e0 00000000 		or	%s47,0,%s47
 3408      AF002F45 
 3409 46e8 00000000 		addu.l	%s47,%s47,%s41
 3409      A9AF2F48 
 3410 46f0 00000000 		addu.l	%s47,%s47,%s40
 3410      A8AF2F48 
 3411 46f8 00000000 		mulu.l	%s47,%s47,%s39
 3411      A7AF2F49 
 3412 4700 00000000 		or	%s34,0,%s60
 3412      BC002245 
 3413 4708 00000000 		addu.l	%s34,%s47,%s34
 3413      A2AF2248 
 3414 4710 00000000 		mulu.l	%s34,%s34,%s38
 3414      A6A22249 
 3415 4718 00000000 		or	%s34,0,%s34
 3415      A2002245 
 3416              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 3417              		.loc	1 874 0
 3418 4720 00000000 		muls.l	%s34,4,%s34
 3418      A204226E 
 3419 4728 00000000 		muls.l	%s62,4,%s62
 3419      BE043E6E 
 3420 4730 00000000 		adds.l	%s34,%s34,%s37
 3420      A5A22259 
 3421 4738 00000000 		adds.l	%s62,%s62,%s36
 3421      A4BE3E59 
 3422 4740 00000000 		subs.w.sx	%s47,0,%s35
 3422      A3002F5A 
 3423 4748 00000000 		smvl	%s55
 3423      0000372E 
 3424 4750 80000000 		mins.w.sx	%s61,%s47,%s55
 3424      B7AF3D78 
 3425              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 3426              		.loc	1 879 0
 3427 4758 00000000 		or	%s7,0,(0)1
 3427      00000745 
 3428 4760 00000000 		lvl	%s55
 3428      00B700BF 
 3429 4768 0000003F 		vbrdu	%v63,%s7
 3429      0087808C 
 3430 4770 00000000 		or	%s56,0,%s47
 3430      AF003845 
 3431 4778 00000000 		or	%s47,0,%s61
 3431      BD002F45 
 3432 4780 00000000 		or	%s63,0,%s34
 3432      A2003F45 
 3433              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 3434              		.loc	1 874 0
 3435 4788 00000000 		muls.l	%s58,4,%s47
 3435      AF043A6E 
 3436 4790 00000000 		or	%s60,0,%s62
 3436      BE003C45 
 3437 4798 00000000 		muls.l	%s57,%s1,%s47
 3437      AF81396E 
 3438 47a0 50FEFFFF 		br.l	.L5.13
 3438      00000F18 
 3439              	.L5.26:
 3440              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 3441              		.loc	1 879 0
 3442 47a8 00000000 		or	%s58,1,(0)1
 3442      00013A45 
 3443 47b0 00000000 		or	%s56,0,%s57
 3443      B9003845 
 3444 47b8 00000000 		lvl	%s58
 3444      00BA00BF 
 3445 47c0 0000003C 		vldu.nc	%v60,0,%s56
 3445      B8000082 
 3446 47c8 80FEFFFF 		brlt.w	0,%s18,.L5.25
 3446      92008218 
 3447 47d0 10FCFFFF 		br.l	.L5.10
 3447      00000F18 
 3448              	.L5.23:
 3449 47d8 D0FFFFFF 		brlt.w	0,%s18,.L5.26
 3449      92008218 
 3450 47e0 60FDFFFF 		br.l	.L5.22
 3450      00000F18 
 3451              	.L5.27:
 3452 47e8 00000000 		or	%s46,0,%s58
 3452      BA002E45 
 3453 47f0 00000000 		or	%s41,0,%s55
 3453      B7002945 
 3454              	# line 873
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 3455              		.loc	1 873 0
 3456 47f8 00000000 		adds.w.sx	%s59,%s19,%s33
 3456      A1933B4A 
 3457 4800 00000000 		muls.w.sx	%s54,%s19,%s62
 3457      BE93364B 
 3458 4808 00000000 		or	%s2,0,%s63
 3458      BF000245 
 3459 4810 00000000 		or	%s63,0,%s59
 3459      BB003F45 
 3460 4818 00000000 		adds.w.sx	%s54,%s54,%s32
 3460      A0B6364A 
 3461 4820 00000000 		or	%s3,0,%s61
 3461      BD000345 
 3462 4828 00000000 		or	%s61,0,%s54
 3462      B6003D45 
 3463 4830 00000000 		or	%s4,0,%s56
 3463      B8000445 
 3464 4838 00000000 		or	%s5,0,%s55
 3464      B7000545 
 3465 4840 00000000 		or	%s6,0,%s58
 3465      BA000645 
 3466 4848 90FFFFFF 		br.l	.L5.23
 3466      00000F18 
 3467              	.L5.20:
 3468 4850 00000000 		or	%s60,0,%s19
 3468      93003C45 
 3469 4858 90FFFFFF 		brlt.w	%s19,%s20,.L5.27
 3469      94938218 
 3470 4860 88FCFFFF 		br.l	.L5.19
 3470      00000F18 
 3471              	.L5.28:
 3472 4868 00000000 		or	%s45,0,%s58
 3472      BA002D45 
 3473 4870 00000000 		or	%s22,0,%s63
 3473      BF001645 
 3474 4878 00000000 		or	%s63,0,%s31
 3474      9F003F45 
 3475              	# line 872
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 3476              		.loc	1 872 0
 3477 4880 00000000 		or	%s59,0,(0)1
 3477      00003B45 
 3478 4888 00000000 		or	%s55,0,(0)1
 3478      00003745 
 3479 4890 00000000 		or	%s23,0,%s60
 3479      BC001745 
 3480 4898 00000000 		or	%s24,0,%s58
 3480      BA001845 
 3481 48a0 00000000 		or	%s58,0,%s59
 3481      BB003A45 
 3482 48a8 A8FFFFFF 		br.l	.L5.20
 3482      00000F18 
 3483              	.L5.17:
 3484 48b0 B8FFFFFF 		brlt.w	0,%s21,.L5.28
 3484      95008218 
 3485 48b8 E8FBFFFF 		br.l	.L5.16
 3485      00000F18 
 3486              	.L5.29:
 3487 48c0 F8FFFFFF 		st	%s50,-8(,%fp)	# spill 
 3487      89003211 
 3488 48c8 F0FFFFFF 		st	%s52,-16(,%fp)	# spill 
 3488      89003411 
 3489 48d0 E8FFFFFF 		st	%s53,-24(,%fp)	# spill 
 3489      89003511 
 3490 48d8 E0FFFFFF 		st	%s41,-32(,%fp)	# spill 
 3490      89002911 
 3491 48e0 D8FFFFFF 		st	%s46,-40(,%fp)	# spill 
 3491      89002E11 
 3492 48e8 D0FFFFFF 		st	%s59,-48(,%fp)	# spill 
 3492      89003B11 
 3493 48f0 C8FFFFFF 		st	%s45,-56(,%fp)	# spill 
 3493      89002D11 
 3494 48f8 C0FFFFFF 		st	%s34,-64(,%fp)	# spill 
 3494      89002211 
 3495 4900 B8FFFFFF 		st	%s7,-72(,%fp)	# spill 
 3495      89000711 
 3496 4908 B0FFFFFF 		st	%s6,-80(,%fp)	# spill 
 3496      89000611 
 3497 4910 A8FFFFFF 		st	%s5,-88(,%fp)	# spill 
 3497      89000511 
 3498              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 3499              		.loc	1 874 0
 3500 4918 00000000 		divu.l	%s59,%s59,%s45
 3500      ADBB3B6F 
 3501 4920 00000000 		or	%s25,0,%s51
 3501      B3001945 
 3502 4928 00000000 		or	%s26,0,%s63
 3502      BF001A45 
 3503 4930 00000000 		or	%s27,0,%s57
 3503      B9001B45 
 3504 4938 00000000 		or	%s28,0,%s55
 3504      B7001C45 
 3505 4940 00000000 		or	%s29,0,%s54
 3505      B6001D45 
 3506 4948 00000000 		or	%s30,0,%s58
 3506      BA001E45 
 3507 4950 00000000 		or	%s58,0,%s47
 3507      AF003A45 
 3508 4958 00000000 		addu.l	%s59,%s59,%s40
 3508      A8BB3B48 
 3509 4960 00000000 		mulu.l	%s34,%s59,%s34
 3509      A2BB2249 
 3510 4968 00000000 		divu.l	%s45,%s34,%s45
 3510      ADA22D6F 
 3511 4970 00000000 		or	%s45,0,%s45
 3511      AD002D45 
 3512              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 3513              		.loc	1 869 0
 3514 4978 00000000 		divs.w.sx	%s41,%s46,%s41
 3514      A9AE297B 
 3515 4980 00000000 		subs.w.sx	%s41,0,%s41
 3515      A900295A 
 3516 4988 00000000 		or	%s63,0,%s41
 3516      A9003F45 
 3517 4990 00000000 		or	%s59,0,%s22
 3517      96003B45 
 3518              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 3519              		.loc	1 874 0
 3520 4998 00000000 		subs.w.sx	%s18,%s18,%s22
 3520      9692125A 
 3521 49a0 00000000 		subs.w.sx	%s35,0,%s18
 3521      9200235A 
 3522              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 3523              		.loc	1 869 0
 3524 49a8 00000000 		muls.l	%s45,%s45,%s60
 3524      BCAD2D6E 
 3525 49b0 00000000 		adds.l	%s45,%s45,%s53
 3525      B5AD2D59 
 3526 49b8 00000000 		adds.l	%s7,%s45,%s7
 3526      87AD0759 
 3527 49c0 00000000 		or	%s57,0,%s7
 3527      87003945 
 3528              	# line 873
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 3529              		.loc	1 873 0
 3530 49c8 00000000 		subs.w.sx	%s33,0,%s20
 3530      9400215A 
 3531              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 3532              		.loc	1 874 0
 3533 49d0 00000000 		muls.l	%s55,4,%s59
 3533      BB04376E 
 3534 49d8 00000000 		muls.l	%s59,%s59,%s1
 3534      81BB3B6E 
 3535 49e0 00000000 		adds.l	%s52,%s53,%s52
 3535      B4B53459 
 3536 49e8 00000000 		adds.l	%s37,%s55,%s6
 3536      86B72559 
 3537 49f0 00000000 		adds.l	%s5,%s59,%s5
 3537      85BB0559 
 3538 49f8 00000000 		adds.l	%s36,%s5,%s52
 3538      B4852459 
 3539 4a00 B0FEFFFF 		br.l	.L5.17
 3539      00000F18 
 3540              	.L5.30:
 3541              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 3542              		.loc	1 869 0
 3543 4a08 00000000 		or	%s47,0,(0)1
 3543      00002F45 
 3544 4a10 00000000 		divs.w.sx	%s23,%s46,%s41
 3544      A9AE177B 
 3545 4a18 A8FEFFFF 		brlt.w	0,%s23,.L5.29
 3545      97008218 
 3546 4a20 900D0000 		br.l	.L5.15
 3546      00000F18 
 3547              	.L5.31:
 3548 4a28 880D0000 		brge.w	%s19,%s20,.L5.15
 3548      94938518 
 3549 4a30 D8FFFFFF 		br.l	.L5.30
 3549      00000F18 
 3550              	.L5.32:
 3551              	# line 900
 882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if ((p->dir & FLAG_BIA)) {
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(for collapse(2) nowait)//;
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int g = 0; g < G; ++g) {
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
 897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           db = 0;
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 3552              		.loc	1 900 0
 3553 4a38 80000000 		mins.w.sx	%s61,%s59,%s61
 3553      BDBB3D78 
 3554 4a40 D0060000 		br.l	.L5.33
 3554      00000F18 
 3555              	.L5.34:
 3556 4a48 80000000 		mins.w.sx	%s60,%s55,%s60
 3556      BCB73C78 
 3557 4a50 D0020000 		br.l	.L5.35
 3557      00000F18 
 3558              	.L5.36:
 3559              	# line 1000
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 db += ((float*)diff_dst_m)[dst_off];
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #elif 0 // experiment
 911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   // regr.sh-BWD_W 2.48x
 912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   OMP(parallel)//;
 913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   {
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     OMP(for collapse(5))//;
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int g = 0; g < G; ++g) {
 916:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 919:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 920:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 921:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 922:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               dw = 0;
 923:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 924:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 925:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 926:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 927:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 928:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
 929:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     OMP(for collapse(3))//;
 930:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     for (int g = 0; g < G; ++g) {
 931:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 932:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             //for (int kw = 0; kw < KW; ++kw) {
 935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               oh_beg = div_floor(       + PH - kh*(p->dh+1) + SH - 1, SH);//(c-a+b-1)/b
 937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               oh_end = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 938:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 939:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_end > OH) oh_end = OH;
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               //int ow_beg, ow_end;
 941:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               //ow_beg = div_floor(       + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
 942:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               //ow_end = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               //if (ow_beg < 0    ) ow_beg = 0;
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               //if (ow_end > OW) ow_end = OW;
 945:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               //if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if( oh_beg >= oh_end ) continue;
 947:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 948:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ic = 0; ic < IC/G; ++ic) {
 949:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 //float &dw = ((float*)diff_wei_m)[wei_off];
 951:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 for (int mb = 0; mb < MB; ++mb) {
 952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 953:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 954:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 955:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int ow_beg, ow_end;
 956:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_beg = div_floor(       + PW - kw*(p->dw+1) + SW - 1, SW);//(c-a+b-1)/b
 957:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_end = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 958:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
 959:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (ow_end > OW) ow_end = OW;
 960:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 float &dw = ((float*)diff_wei_m)[wei_off];
 961:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int iw = ow * SW - PW + kw * (p->dw + 1);
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       dw += ((float*)diff_dst_m)[dst_off]
 967:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                     }
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   }
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 }
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 972:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 976:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 977:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     if ((p->dir & FLAG_BIA)) {
 979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(for collapse(2) nowait)//;
 980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int g = 0; g < G; ++g) {
 981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 983:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
 984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           db = 0;
 985:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 986:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 987:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 988:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 989:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 db += ((float*)diff_dst_m)[dst_off];
 990:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 991:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 992:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           }
 993:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         }
 994:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       }
 995:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****     }
 996:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****   }
 997:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #else
 998:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #error "select one"
 999:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** #endif
1000:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** }
 3560              		.loc	1 1000 0
 3561              	# Start of epilogue codes
 3562 4a58 30000000 		ld	%s18,48(,%fp)
 3562      89001201 
 3563 4a60 38000000 		ld	%s19,56(,%fp)
 3563      89001301 
 3564 4a68 40000000 		ld	%s20,64(,%fp)
 3564      89001401 
 3565 4a70 48000000 		ld	%s21,72(,%fp)
 3565      89001501 
 3566 4a78 50000000 		ld	%s22,80(,%fp)
 3566      89001601 
 3567 4a80 58000000 		ld	%s23,88(,%fp)
 3567      89001701 
 3568 4a88 60000000 		ld	%s24,96(,%fp)
 3568      89001801 
 3569 4a90 68000000 		ld	%s25,104(,%fp)
 3569      89001901 
 3570 4a98 70000000 		ld	%s26,112(,%fp)
 3570      89001A01 
 3571 4aa0 78000000 		ld	%s27,120(,%fp)
 3571      89001B01 
 3572 4aa8 80000000 		ld	%s28,128(,%fp)
 3572      89001C01 
 3573 4ab0 88000000 		ld	%s29,136(,%fp)
 3573      89001D01 
 3574 4ab8 90000000 		ld	%s30,144(,%fp)
 3574      89001E01 
 3575 4ac0 98000000 		ld	%s31,152(,%fp)
 3575      89001F01 
 3576 4ac8 A0000000 		ld	%s32,160(,%fp)
 3576      89002001 
 3577 4ad0 A8000000 		ld	%s33,168(,%fp)
 3577      89002101 
 3578 4ad8 00000000 		or	%sp,0,%fp
 3578      89000B45 
 3579              		.cfi_def_cfa	11,8
 3580 4ae0 18000000 		ld	%got,0x18(,%sp)
 3580      8B000F01 
 3581 4ae8 20000000 		ld	%plt,0x20(,%sp)
 3581      8B001001 
 3582 4af0 08000000 		ld	%lr,0x8(,%sp)
 3582      8B000A01 
 3583 4af8 00000000 		ld	%fp,0x0(,%sp)
 3583      8B000901 
 3584 4b00 00000000 		b.l	(,%lr)
 3584      8A000F19 
 3585              	.L5.37:
 3586 4b08 50FFFFFF 		br.l	.L5.36
 3586      00000F18 
 3587              	.L5.38:
 3588              	# line 893
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 3589              		.loc	1 893 0
 3590 4b10 00000000 		adds.w.sx	%s63,1,%s63
 3590      BF013F4A 
 3591 4b18 00000000 		adds.l	%s60,%s61,%s60
 3591      BCBD3C59 
 3592 4b20 00000000 		adds.w.sx	%s54,%s58,%s54
 3592      B6BA364A 
 3593 4b28 00000000 		adds.w.sx	%s47,%s58,%s47
 3593      AFBA2F4A 
 3594 4b30 80080000 		brgt.w	0,%s63,.L5.39
 3594      BF008118 
 3595 4b38 D0FFFFFF 		br.l	.L5.37
 3595      00000F18 
 3596              	.L5.40:
 3597 4b40 00000000 		or	%s63,0,%s25
 3597      99003F45 
 3598 4b48 00000000 		or	%s61,0,%s26
 3598      9A003D45 
 3599 4b50 00000000 		or	%s60,0,%s27
 3599      9B003C45 
 3600 4b58 00000000 		or	%s58,0,%s24
 3600      98003A45 
 3601 4b60 00000000 		or	%s22,0,%s23
 3601      97001645 
 3602 4b68 00000000 		or	%s56,0,%s47
 3602      AF003845 
 3603 4b70 00000000 		or	%s47,0,%s38
 3603      A6002F45 
 3604 4b78 98FFFFFF 		br.l	.L5.38
 3604      00000F18 
 3605              	.L5.41:
 3606              	# line 894
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 3607              		.loc	1 894 0
 3608 4b80 00000000 		adds.w.sx	%s61,1,%s61
 3608      BD013D4A 
 3609 4b88 00000000 		adds.l	%s60,4,%s60
 3609      BC043C59 
 3610 4b90 00000000 		adds.w.sx	%s59,1,%s59
 3610      BB013B4A 
 3611 4b98 70070000 		brgt.w	0,%s61,.L5.42
 3611      BD008118 
 3612 4ba0 A0FFFFFF 		br.l	.L5.40
 3612      00000F18 
 3613              	.L5.43:
 3614 4ba8 00000000 		or	%s61,0,%s7
 3614      87003D45 
 3615 4bb0 00000000 		or	%s59,0,%s22
 3615      96003B45 
 3616 4bb8 C8FFFFFF 		br.l	.L5.41
 3616      00000F18 
 3617              	.L5.44:
 3618              	# line 898
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 3619              		.loc	1 898 0
 3620 4bc0 00000000 		adds.w.sx	%s63,1,%s63
 3620      BF013F4A 
 3621 4bc8 00000000 		adds.l	%s61,%s62,%s61
 3621      BDBE3D59 
 3622 4bd0 00000000 		adds.l	%s59,%s62,%s59
 3622      BBBE3B59 
 3623 4bd8 D8060000 		brgt.w	0,%s63,.L5.45
 3623      BF008118 
 3624 4be0 C8FFFFFF 		br.l	.L5.43
 3624      00000F18 
 3625              	.L5.46:
 3626 4be8 00000000 		or	%s63,0,%s3
 3626      83003F45 
 3627 4bf0 00000000 		or	%s62,0,%s4
 3627      84003E45 
 3628 4bf8 00000000 		or	%s61,0,%s2
 3628      82003D45 
 3629 4c00 00000000 		or	%s59,0,%s6
 3629      86003B45 
 3630 4c08 00000000 		or	%s53,0,%s46
 3630      AE003545 
 3631 4c10 00000000 		or	%s50,0,%s43
 3631      AB003245 
 3632 4c18 00000000 		or	%s49,0,%s42
 3632      AA003145 
 3633 4c20 00000000 		or	%s48,0,%s41
 3633      A9003045 
 3634 4c28 00000000 		or	%s46,0,%s39
 3634      A7002E45 
 3635 4c30 00000000 		or	%s44,0,%s1
 3635      81002C45 
 3636 4c38 00000000 		or	%s60,0,%s57
 3636      B9003C45 
 3637 4c40 00000000 		or	%s38,0,%s47
 3637      AF002645 
 3638 4c48 00000000 		or	%s47,0,%s40
 3638      A8002F45 
 3639 4c50 00000000 		or	%s54,0,%s5
 3639      85003645 
 3640 4c58 68FFFFFF 		br.l	.L5.44
 3640      00000F18 
 3641              	.L5.47:
 3642              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 3643              		.loc	1 899 0
 3644 4c60 00000000 		adds.w.sx	%s63,4,%s63
 3644      BF043F4A 
 3645 4c68 00000000 		adds.w.sx	%s62,4,%s62
 3645      BE043E4A 
 3646 4c70 00000000 		adds.w.sx	%s61,4,%s61
 3646      BD043D4A 
 3647 4c78 00000000 		adds.w.sx	%s60,4,%s60
 3647      BC043C4A 
 3648 4c80 00000000 		adds.w.sx	%s59,4,%s59
 3648      BB043B4A 
 3649 4c88 E0020000 		brgt.w	0,%s63,.L5.48
 3649      BF008118 
 3650 4c90 58FFFFFF 		br.l	.L5.46
 3650      00000F18 
 3651              	.L5.49:
 3652              	# line 903
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 3653              		.loc	1 903 0
 3654 4c98 00000000 		or	%s58,1,(0)1
 3654      00013A45 
 3655 4ca0 00000000 		or	%s56,0,%s57
 3655      B9003845 
 3656 4ca8 00000000 		lvl	%s58
 3656      00BA00BF 
 3657 4cb0 00000013 		vstu.nc	%v19,0,%s56
 3657      B8000092 
 3658 4cb8 A8FFFFFF 		br.l	.L5.47
 3658      00000F18 
 3659              	.L5.50:
 3660              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 3661              		.loc	1 902 0
 3662 4cc0 00000000 		lvl	%s54
 3662      00B600BF 
 3663 4cc8 00003611 		vfsum.s	%v17,%v54
 3663      000080EC 
 3664 4cd0 00000000 		or	%s58,1,(0)1
 3664      00013A45 
 3665 4cd8 00000000 		lvl	%s58
 3665      00BA00BF 
 3666 4ce0 00111313 		vfadd.s	%v19,%v19,%v17
 3666      000080CC 
 3667 4ce8 00000000 		or	%s63,0,%s53
 3667      B5003F45 
 3668 4cf0 00000000 		or	%s62,0,%s52
 3668      B4003E45 
 3669 4cf8 00000000 		or	%s61,0,%s51
 3669      B3003D45 
 3670 4d00 00000000 		or	%s60,0,%s50
 3670      B2003C45 
 3671 4d08 00000000 		or	%s59,0,%s49
 3671      B1003B45 
 3672 4d10 00000000 		or	%s57,0,%s48
 3672      B0003945 
 3673 4d18 80FFFFFF 		br.l	.L5.49
 3673      00000F18 
 3674              	.L5.35:
 3675 4d20 00000000 		adds.l	%s62,%s63,(0)1
 3675      00BF3E59 
 3676 4d28 00000000 		adds.l	%s62,%s62,%s61
 3676      BDBE3E59 
 3677 4d30 00000000 		lvl	%s60
 3677      00BC00BF 
 3678 4d38 00000035 		vldu.nc	%v53,4,%s62
 3678      BE040082 
 3679 4d40 00000000 		adds.l	%s62,%s59,(0)1
 3679      00BB3E59 
 3680 4d48 00000000 		adds.l	%s62,%s62,%s61
 3680      BDBE3E59 
 3681 4d50 00000034 		vldu.nc	%v52,4,%s62
 3681      BE040082 
 3682 4d58 00343533 		vfadd.s	%v51,%v53,%v52
 3682      000080CC 
 3683 4d60 00000000 		adds.l	%s62,%s58,(0)1
 3683      00BA3E59 
 3684 4d68 00000000 		adds.l	%s62,%s62,%s61
 3684      BDBE3E59 
 3685 4d70 00000032 		vldu.nc	%v50,4,%s62
 3685      BE040082 
 3686 4d78 00323331 		vfadd.s	%v49,%v51,%v50
 3686      000080CC 
 3687 4d80 00000000 		adds.l	%s62,%s57,(0)1
 3687      00B93E59 
 3688 4d88 00000000 		adds.l	%s62,%s62,%s61
 3688      BDBE3E59 
 3689 4d90 00000030 		vldu.nc	%v48,4,%s62
 3689      BE040082 
 3690 4d98 0030312F 		vfadd.s	%v47,%v49,%v48
 3690      000080CC 
 3691 4da0 002F3636 		vfadd.s	%v54,%v54,%v47
 3691      000080CC 
 3692              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3693              		.loc	1 900 0
 3694 4da8 00000000 		adds.l	%s61,%s61,%s56
 3694      B8BD3D59 
 3695 4db0 00000000 		subs.w.sx	%s55,%s55,%s60
 3695      BCB7375A 
 3696 4db8 08FFFFFF 		brge.w	0,%s55,.L5.50
 3696      B7008518 
 3697 4dc0 88FCFFFF 		br.l	.L5.34
 3697      00000F18 
 3698              	.L5.51:
 3699              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 3700              		.loc	1 902 0
 3701 4dc8 00000000 		divs.w.sx	%s45,%s47,%s46
 3701      AEAF2D7B 
 3702 4dd0 00000000 		or	%s49,0,%s59
 3702      BB003145 
 3703 4dd8 00000000 		or	%s50,0,%s60
 3703      BC003245 
 3704 4de0 00000000 		or	%s51,0,%s61
 3704      BD003345 
 3705 4de8 00000000 		or	%s52,0,%s62
 3705      BE003445 
 3706 4df0 00000000 		or	%s53,0,%s63
 3706      BF003545 
 3707 4df8 00000000 		or	%s48,0,%s57
 3707      B9003045 
 3708 4e00 00000000 		or	%s45,0,%s45
 3708      AD002D45 
 3709 4e08 00000000 		addu.l	%s45,%s45,%s44
 3709      ACAD2D48 
 3710 4e10 00000000 		addu.l	%s45,%s45,%s43
 3710      ABAD2D48 
 3711 4e18 00000000 		mulu.l	%s45,%s45,%s42
 3711      AAAD2D49 
 3712 4e20 00000000 		or	%s38,0,%s59
 3712      BB002645 
 3713 4e28 00000000 		addu.l	%s38,%s45,%s38
 3713      A6AD2648 
 3714 4e30 00000000 		mulu.l	%s38,%s38,%s41
 3714      A9A62649 
 3715 4e38 00000000 		or	%s38,0,%s38
 3715      A6002645 
 3716 4e40 00000000 		or	%s62,0,%s62
 3716      BE003E45 
 3717 4e48 00000000 		addu.l	%s62,%s45,%s62
 3717      BEAD3E48 
 3718 4e50 00000000 		mulu.l	%s62,%s41,%s62
 3718      BEA93E49 
 3719 4e58 00000000 		or	%s62,0,%s62
 3719      BE003E45 
 3720 4e60 00000000 		or	%s37,0,%s61
 3720      BD002545 
 3721 4e68 00000000 		addu.l	%s37,%s45,%s37
 3721      A5AD2548 
 3722 4e70 00000000 		mulu.l	%s37,%s41,%s37
 3722      A5A92549 
 3723 4e78 00000000 		or	%s37,0,%s37
 3723      A5002545 
 3724 4e80 00000000 		or	%s36,0,%s60
 3724      BC002445 
 3725 4e88 00000000 		addu.l	%s36,%s45,%s36
 3725      A4AD2448 
 3726 4e90 00000000 		mulu.l	%s36,%s41,%s36
 3726      A4A92449 
 3727 4e98 00000000 		or	%s36,0,%s36
 3727      A4002445 
 3728              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3729              		.loc	1 900 0
 3730 4ea0 00000000 		muls.l	%s38,4,%s38
 3730      A604266E 
 3731 4ea8 00000000 		muls.l	%s62,4,%s62
 3731      BE043E6E 
 3732 4eb0 00000000 		muls.l	%s37,4,%s37
 3732      A504256E 
 3733 4eb8 00000000 		muls.l	%s36,4,%s36
 3733      A404246E 
 3734 4ec0 00000000 		adds.l	%s63,%s38,%s40
 3734      A8A63F59 
 3735 4ec8 00000000 		adds.l	%s59,%s40,%s62
 3735      BEA83B59 
 3736 4ed0 00000000 		adds.l	%s58,%s40,%s37
 3736      A5A83A59 
 3737 4ed8 00000000 		adds.l	%s57,%s40,%s36
 3737      A4A83959 
 3738 4ee0 00000000 		subs.w.sx	%s62,0,%s39
 3738      A7003E5A 
 3739 4ee8 00000000 		smvl	%s54
 3739      0000362E 
 3740 4ef0 80000000 		mins.w.sx	%s60,%s62,%s54
 3740      B6BE3C78 
 3741              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 3742              		.loc	1 902 0
 3743 4ef8 00000000 		or	%s45,0,(0)1
 3743      00002D45 
 3744 4f00 00000000 		lvl	%s54
 3744      00B600BF 
 3745 4f08 00000036 		vbrdu	%v54,%s45
 3745      00AD808C 
 3746 4f10 00000000 		or	%s55,0,%s62
 3746      BE003745 
 3747              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3748              		.loc	1 900 0
 3749 4f18 00000000 		or	%s61,0,(0)1
 3749      00003D45 
 3750 4f20 00000000 		or	%s62,0,%s60
 3750      BC003E45 
 3751 4f28 00000000 		muls.l	%s56,4,%s62
 3751      BE04386E 
 3752 4f30 F0FDFFFF 		br.l	.L5.35
 3752      00000F18 
 3753              	.L5.52:
 3754 4f38 00000000 		or	%s58,1,(0)1
 3754      00013A45 
 3755 4f40 00000000 		or	%s56,0,%s57
 3755      B9003845 
 3756 4f48 00000000 		lvl	%s58
 3756      00BA00BF 
 3757 4f50 00000013 		vldu.nc	%v19,0,%s56
 3757      B8000082 
 3758 4f58 70FEFFFF 		brlt.w	0,%s18,.L5.51
 3758      92008218 
 3759 4f60 38FDFFFF 		br.l	.L5.49
 3759      00000F18 
 3760              	.L5.48:
 3761 4f68 D0FFFFFF 		brlt.w	0,%s18,.L5.52
 3761      92008218 
 3762 4f70 F0FCFFFF 		br.l	.L5.47
 3762      00000F18 
 3763              	.L5.53:
 3764 4f78 00000000 		or	%s43,0,%s50
 3764      B2002B45 
 3765 4f80 00000000 		or	%s42,0,%s49
 3765      B1002A45 
 3766 4f88 00000000 		or	%s41,0,%s48
 3766      B0002945 
 3767 4f90 00000000 		or	%s40,0,%s47
 3767      AF002845 
 3768 4f98 00000000 		or	%s39,0,%s46
 3768      AE002745 
 3769 4fa0 00000000 		or	%s46,0,%s53
 3769      B5002E45 
 3770 4fa8 00000000 		or	%s57,0,%s60
 3770      BC003945 
 3771 4fb0 00000000 		or	%s1,0,%s44
 3771      AC000145 
 3772 4fb8 00000000 		or	%s44,0,%s59
 3772      BB002C45 
 3773              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 3774              		.loc	1 899 0
 3775 4fc0 00000000 		adds.w.sx	%s56,%s20,%s35
 3775      A394384A 
 3776 4fc8 00000000 		adds.w.sx	%s55,1,%s20
 3776      9401374A 
 3777 4fd0 00000000 		adds.w.sx	%s53,2,%s20
 3777      9402354A 
 3778 4fd8 00000000 		adds.w.sx	%s60,3,%s20
 3778      94033C4A 
 3779 4fe0 00000000 		or	%s2,0,%s61
 3779      BD000245 
 3780 4fe8 00000000 		or	%s61,0,%s53
 3780      B5003D45 
 3781 4ff0 00000000 		or	%s3,0,%s63
 3781      BF000345 
 3782 4ff8 00000000 		or	%s63,0,%s56
 3782      B8003F45 
 3783 5000 00000000 		or	%s4,0,%s62
 3783      BE000445 
 3784 5008 00000000 		or	%s62,0,%s55
 3784      B7003E45 
 3785 5010 00000000 		or	%s5,0,%s54
 3785      B6000545 
 3786 5018 00000000 		or	%s6,0,%s59
 3786      BB000645 
 3787 5020 00000000 		or	%s59,0,%s58
 3787      BA003B45 
 3788 5028 00000000 		or	%s47,0,%s38
 3788      A6002F45 
 3789 5030 38FFFFFF 		br.l	.L5.48
 3789      00000F18 
 3790              	.L5.54:
 3791 5038 00000000 		or	%s58,0,%s20
 3791      94003A45 
 3792 5040 38FFFFFF 		brlt.w	%s20,%s19,.L5.53
 3792      93948218 
 3793 5048 78FBFFFF 		br.l	.L5.44
 3793      00000F18 
 3794              	.L5.55:
 3795 5050 00000000 		or	%s59,0,%s1
 3795      81003B45 
 3796 5058 00000000 		or	%s61,0,%s4
 3796      84003D45 
 3797 5060 00000000 		or	%s63,0,%s2
 3797      82003F45 
 3798 5068 00000000 		or	%s62,0,%s3
 3798      83003E45 
 3799 5070 C8FFFFFF 		br.l	.L5.54
 3799      00000F18 
 3800              	.L5.56:
 3801 5078 D0010000 		br.l	.L5.57
 3801      00000F18 
 3802              	.L5.58:
 3803 5080 00000000 		adds.w.sx	%s63,1,%s63
 3803      BF013F4A 
 3804 5088 00000000 		adds.w.sx	%s62,1,%s62
 3804      BE013E4A 
 3805 5090 E8FFFFFF 		brgt.w	0,%s63,.L5.56
 3805      BF008118 
 3806 5098 B8FFFFFF 		br.l	.L5.55
 3806      00000F18 
 3807              	.L5.59:
 3808              	# line 903
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 3809              		.loc	1 903 0
 3810 50a0 00000000 		or	%s61,1,(0)1
 3810      00013D45 
 3811 50a8 00000000 		or	%s59,0,%s60
 3811      BC003B45 
 3812 50b0 00000000 		lvl	%s61
 3812      00BD00BF 
 3813 50b8 00000014 		vstu.nc	%v20,0,%s59
 3813      BB000092 
 3814 50c0 C0FFFFFF 		br.l	.L5.58
 3814      00000F18 
 3815              	.L5.60:
 3816              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 3817              		.loc	1 902 0
 3818 50c8 00000000 		lvl	%s58
 3818      00BA00BF 
 3819 50d0 00003812 		vfsum.s	%v18,%v56
 3819      000080EC 
 3820 50d8 00000000 		or	%s61,1,(0)1
 3820      00013D45 
 3821 50e0 00000000 		lvl	%s61
 3821      00BD00BF 
 3822 50e8 00121414 		vfadd.s	%v20,%v20,%v18
 3822      000080CC 
 3823 50f0 00000000 		or	%s63,0,%s57
 3823      B9003F45 
 3824 50f8 00000000 		or	%s62,0,%s56
 3824      B8003E45 
 3825 5100 00000000 		or	%s60,0,%s55
 3825      B7003C45 
 3826 5108 98FFFFFF 		br.l	.L5.59
 3826      00000F18 
 3827              	.L5.33:
 3828 5110 00000000 		or	%s62,0,%s63
 3828      BF003E45 
 3829 5118 00000000 		lvl	%s61
 3829      00BD00BF 
 3830 5120 00000037 		vldu.nc	%v55,4,%s62
 3830      BE040082 
 3831 5128 00373838 		vfadd.s	%v56,%v56,%v55
 3831      000080CC 
 3832              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3833              		.loc	1 900 0
 3834 5130 00000000 		adds.l	%s63,%s63,%s60
 3834      BCBF3F59 
 3835 5138 00000000 		subs.w.sx	%s59,%s59,%s61
 3835      BDBB3B5A 
 3836 5140 88FFFFFF 		brge.w	0,%s59,.L5.60
 3836      BB008518 
 3837 5148 F0F8FFFF 		br.l	.L5.32
 3837      00000F18 
 3838              	.L5.61:
 3839              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 3840              		.loc	1 902 0
 3841 5150 00000000 		divs.w.sx	%s52,%s54,%s53
 3841      B5B6347B 
 3842 5158 00000000 		or	%s56,0,%s62
 3842      BE003845 
 3843 5160 00000000 		or	%s57,0,%s63
 3843      BF003945 
 3844 5168 00000000 		or	%s55,0,%s60
 3844      BC003745 
 3845 5170 00000000 		or	%s52,0,%s52
 3845      B4003445 
 3846 5178 00000000 		addu.l	%s52,%s52,%s51
 3846      B3B43448 
 3847 5180 00000000 		addu.l	%s52,%s52,%s50
 3847      B2B43448 
 3848 5188 00000000 		mulu.l	%s52,%s52,%s49
 3848      B1B43449 
 3849 5190 00000000 		or	%s62,0,%s62
 3849      BE003E45 
 3850 5198 00000000 		addu.l	%s62,%s52,%s62
 3850      BEB43E48 
 3851 51a0 00000000 		mulu.l	%s62,%s62,%s48
 3851      B0BE3E49 
 3852 51a8 00000000 		or	%s62,0,%s62
 3852      BE003E45 
 3853              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3854              		.loc	1 900 0
 3855 51b0 00000000 		muls.l	%s62,4,%s62
 3855      BE043E6E 
 3856 51b8 00000000 		adds.l	%s62,%s62,%s47
 3856      AFBE3E59 
 3857 51c0 00000000 		subs.w.sx	%s52,0,%s46
 3857      AE00345A 
 3858 51c8 00000000 		smvl	%s58
 3858      00003A2E 
 3859 51d0 80000000 		mins.w.sx	%s61,%s52,%s58
 3859      BAB43D78 
 3860              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 3861              		.loc	1 902 0
 3862 51d8 00000000 		or	%s45,0,(0)1
 3862      00002D45 
 3863 51e0 00000000 		lvl	%s58
 3863      00BA00BF 
 3864 51e8 00000038 		vbrdu	%v56,%s45
 3864      00AD808C 
 3865 51f0 00000000 		or	%s59,0,%s52
 3865      B4003B45 
 3866 51f8 00000000 		or	%s63,0,%s62
 3866      BE003F45 
 3867 5200 00000000 		or	%s62,0,%s61
 3867      BD003E45 
 3868              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3869              		.loc	1 900 0
 3870 5208 00000000 		muls.l	%s60,4,%s62
 3870      BE043C6E 
 3871 5210 00FFFFFF 		br.l	.L5.33
 3871      00000F18 
 3872              	.L5.62:
 3873 5218 00000000 		or	%s61,1,(0)1
 3873      00013D45 
 3874 5220 00000000 		or	%s59,0,%s60
 3874      BC003B45 
 3875 5228 00000000 		lvl	%s61
 3875      00BD00BF 
 3876 5230 00000014 		vldu.nc	%v20,0,%s59
 3876      BB000082 
 3877 5238 18FFFFFF 		brlt.w	0,%s18,.L5.61
 3877      92008218 
 3878 5240 60FEFFFF 		br.l	.L5.59
 3878      00000F18 
 3879              	.L5.57:
 3880 5248 D0FFFFFF 		brlt.w	0,%s18,.L5.62
 3880      92008218 
 3881 5250 30FEFFFF 		br.l	.L5.58
 3881      00000F18 
 3882              	.L5.63:
 3883 5258 00000000 		or	%s51,0,%s61
 3883      BD003345 
 3884 5260 00000000 		or	%s1,0,%s59
 3884      BB000145 
 3885 5268 00000000 		or	%s2,0,%s63
 3885      BF000245 
 3886 5270 00000000 		or	%s63,0,%s44
 3886      AC003F45 
 3887 5278 00000000 		or	%s3,0,%s62
 3887      BE000345 
 3888 5280 00000000 		or	%s62,0,%s58
 3888      BA003E45 
 3889 5288 00000000 		or	%s4,0,%s61
 3889      BD000445 
 3890 5290 B8FFFFFF 		br.l	.L5.57
 3890      00000F18 
 3891              	.L5.64:
 3892              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 3893              		.loc	1 899 0
 3894 5298 00000000 		or	%s58,0,(0)1
 3894      00003A45 
 3895 52a0 B8FFFFFF 		brlt.w	0,%s20,.L5.63
 3895      94008218 
 3896 52a8 90FDFFFF 		br.l	.L5.54
 3896      00000F18 
 3897              	.L5.45:
 3898 52b0 E8FFFFFF 		brlt.w	0,%s19,.L5.64
 3898      93008218 
 3899 52b8 08F9FFFF 		br.l	.L5.44
 3899      00000F18 
 3900              	.L5.65:
 3901 52c0 00000000 		or	%s50,0,%s59
 3901      BB003245 
 3902 52c8 00000000 		or	%s63,0,%s34
 3902      A2003F45 
 3903              	# line 898
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 3904              		.loc	1 898 0
 3905 52d0 00000000 		or	%s58,0,(0)1
 3905      00003A45 
 3906 52d8 00000000 		or	%s57,0,(0)1
 3906      00003945 
 3907 52e0 00000000 		or	%s7,0,%s61
 3907      BD000745 
 3908 52e8 00000000 		or	%s61,0,%s58
 3908      BA003D45 
 3909 52f0 00000000 		or	%s22,0,%s59
 3909      BB001645 
 3910 52f8 00000000 		or	%s59,0,%s57
 3910      B9003B45 
 3911 5300 B0FFFFFF 		br.l	.L5.45
 3911      00000F18 
 3912              	.L5.42:
 3913              	# line 897
 897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 3914              		.loc	1 897 0
 3915 5308 00000000 		or	%s63,0,(0)1
 3915      00003F45 
 3916 5310 00000000 		stu	%s63,0(,%s60)	# *(db)
 3916      BC003F12 
 3917 5318 A8FFFFFF 		brlt.w	0,%s21,.L5.65
 3917      95008218 
 3918 5320 60F8FFFF 		br.l	.L5.41
 3918      00000F18 
 3919              	.L5.66:
 3920 5328 00000000 		or	%s57,0,%s60
 3920      BC003945 
 3921 5330 00000000 		divu.l	%s57,%s57,%s33
 3921      A1B9396F 
 3922 5338 00000000 		or	%s38,0,%s47
 3922      AF002645 
 3923 5340 00000000 		or	%s23,0,%s22
 3923      96001745 
 3924 5348 00000000 		or	%s24,0,%s58
 3924      BA001845 
 3925 5350 00000000 		or	%s25,0,%s63
 3925      BF001945 
 3926 5358 00000000 		or	%s26,0,%s61
 3926      BD001A45 
 3927 5360 00000000 		or	%s27,0,%s60
 3927      BC001B45 
 3928 5368 00000000 		or	%s57,0,%s57
 3928      B9003945 
 3929              	# line 894
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 3930              		.loc	1 894 0
 3931 5370 00000000 		divs.w.sx	%s63,%s32,%s31
 3931      9FA03F7B 
 3932 5378 00000000 		subs.w.sx	%s63,0,%s63
 3932      BF003F5A 
 3933 5380 00000000 		or	%s61,0,%s63
 3933      BF003D45 
 3934 5388 00000000 		muls.l	%s57,4,%s57
 3934      B904396E 
 3935 5390 00000000 		adds.l	%s57,%s57,%s30
 3935      9EB93959 
 3936 5398 00000000 		or	%s60,0,%s57
 3936      B9003C45 
 3937 53a0 00000000 		or	%s47,0,%s56
 3937      B8002F45 
 3938 53a8 60FFFFFF 		br.l	.L5.42
 3938      00000F18 
 3939              	.L5.39:
 3940 53b0 00000000 		or	%s59,0,(0)1
 3940      00003B45 
 3941 53b8 70FFFFFF 		brlt.w	0,%s22,.L5.66
 3941      96008218 
 3942 53c0 50F7FFFF 		br.l	.L5.38
 3942      00000F18 
 3943              	.L5.67:
 3944 53c8 14000000 		dldl.sx	%s32,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 3944      8000200B 
 3945 53d0 00000000 		or	%s59,0,%s32
 3945      A0003B45 
 3946 53d8 00000000 		or	%s61,0,%s59
 3946      BB003D45 
 3947              	# line 893
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 3948              		.loc	1 893 0
 3949 53e0 00000000 		or	%s60,0,(0)1
 3949      00003C45 
 3950              	# line 894
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 3951              		.loc	1 894 0
 3952 53e8 00000000 		divs.w.sx	%s22,%s32,%s31
 3952      9FA0167B 
 3953 53f0 00000000 		or	%s33,0,%s31
 3953      9F002145 
 3954              	# line 893
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 3955              		.loc	1 893 0
 3956 53f8 00000000 		subs.w.sx	%s59,0,%s31
 3956      9F003B5A 
 3957 5400 00000000 		or	%s63,0,%s59
 3957      BB003F45 
 3958              	# line 897
 897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 3959              		.loc	1 897 0
 3960 5408 A8010000 		dld	%s30,424(,%s3)	# *(diff_bia_m).data_
 3960      83001E09 
 3961              	# line 898
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 3962              		.loc	1 898 0
 3963 5410 04000000 		dldl.sx	%s21,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 3963      8000150B 
 3964 5418 00000000 		subs.w.sx	%s34,0,%s21
 3964      9500225A 
 3965              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 3966              		.loc	1 899 0
 3967 5420 18000000 		dldl.sx	%s19,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 3967      8000130B 
 3968 5428 00000000 		subs.w.sx	%s35,0,%s19
 3968      9300235A 
 3969 5430 00000000 		and	%s20,%s19,(62)0
 3969      7E931444 
 3970 5438 00000000 		subs.w.sx	%s44,0,%s20
 3970      94002C5A 
 3971              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3972              		.loc	1 900 0
 3973 5440 1C000000 		dldl.sx	%s18,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 3973      8000120B 
 3974 5448 00000000 		or	%s48,0,%s18
 3974      92003045 
 3975 5450 00000000 		subs.w.sx	%s46,0,%s18
 3975      92002E5A 
 3976              	# line 893
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 3977              		.loc	1 893 0
 3978 5458 00000000 		or	%s54,0,(0)1
 3978      00003645 
 3979 5460 00000000 		or	%s47,0,(0)1
 3979      00002F45 
 3980              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3981              		.loc	1 900 0
 3982 5468 A8010000 		dld	%s56,424(,%s4)	# *(s$142).data_
 3982      84003809 
 3983              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               }
 3984              		.loc	1 902 0
 3985 5470 14000000 		dldl.sx	%s58,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 3985      80003A0B 
 3986 5478 00000000 		or	%s59,0,%s58
 3986      BA003B45 
 3987 5480 00000000 		or	%s62,0,%s59
 3987      BB003E45 
 3988 5488 00000000 		dldl.sx	%s53,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3988      8000350B 
 3989 5490 18000000 		dldl.sx	%s0,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 3989      8000000B 
 3990 5498 00000000 		or	%s49,0,%s0
 3990      80003145 
 3991 54a0 10FFFFFF 		br.l	.L5.39
 3991      00000F18 
 3992              	.L5.68:
 3993              	# line 893
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 3994              		.loc	1 893 0
 3995 54a8 00000000 		ldl.sx	%s31,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 3995      80001F03 
 3996 54b0 18FFFFFF 		brlt.w	0,%s31,.L5.67
 3996      9F008218 
 3997 54b8 A0F5FFFF 		br.l	.L5.36
 3997      00000F18 
 3998              	.L5.69:
 3999              	# line 891
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       OMP(for collapse(2) nowait)//;
 4000              		.loc	1 891 0
 4001 54c0 48000000 		ldl.zx	%s63,72(,%s0)	# *(p).dir
 4001      8000BF03 
 4002 54c8 00000000 		adds.w.sx	%s63,0,%s63
 4002      BF003F4A 
 4003 54d0 04000000 		lea	%s62,4
 4003      00003E06 
 4004 54d8 00000000 		and	%s62,%s63,%s62
 4004      BEBF3E44 
 4005 54e0 C8FFFFFF 		brne.w	0,%s62,.L5.68
 4005      BE008318 
 4006 54e8 70F5FFFF 		br.l	.L5.36
 4006      00000F18 
 4007              	.L5.70:
 4008 54f0 80FDFFFF 		ld	%s0,-640(,%fp)	# restore 
 4008      89000001 
 4009 54f8 90FDFFFF 		ld	%s3,-624(,%fp)	# restore 
 4009      89000301 
 4010 5500 88FDFFFF 		ld	%s4,-632(,%fp)	# restore 
 4010      89000401 
 4011 5508 B8FFFFFF 		br.l	.L5.69
 4011      00000F18 
 4012              	.L5.71:
 4013              	# line 852
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4014              		.loc	1 852 0
 4015 5510 00000000 		adds.w.sx	%s63,1,%s63
 4015      BF013F4A 
 4016 5518 00000000 		adds.l	%s53,%s55,%s53
 4016      B5B73559 
 4017 5520 00000000 		adds.w.sx	%s49,%s52,%s49
 4017      B1B4314A 
 4018 5528 00000000 		adds.w.sx	%s42,%s50,%s42
 4018      AAB22A4A 
 4019 5530 60090000 		brgt.w	0,%s63,.L5.72
 4019      BF008118 
 4020 5538 B8FFFFFF 		br.l	.L5.70
 4020      00000F18 
 4021              	.L5.73:
 4022 5540 30FEFFFF 		ld	%s63,-464(,%fp)	# restore 
 4022      89003F01 
 4023 5548 28FEFFFF 		ld	%s55,-472(,%fp)	# restore 
 4023      89003701 
 4024 5550 20FEFFFF 		ld	%s53,-480(,%fp)	# restore 
 4024      89003501 
 4025 5558 40FEFFFF 		ld	%s52,-448(,%fp)	# restore 
 4025      89003401 
 4026 5560 00FFFFFF 		ld	%s49,-256(,%fp)	# restore 
 4026      89003101 
 4027 5568 38FEFFFF 		ld	%s50,-456(,%fp)	# restore 
 4027      89003201 
 4028 5570 F8FEFFFF 		ld	%s42,-264(,%fp)	# restore 
 4028      89002A01 
 4029 5578 E0FFFFFF 		ld	%s41,-32(,%fp)	# restore 
 4029      89002901 
 4030 5580 48FEFFFF 		ld	%s20,-440(,%fp)	# restore 
 4030      89001401 
 4031 5588 18FEFFFF 		ld	%s56,-488(,%fp)	# restore 
 4031      89003801 
 4032 5590 80FFFFFF 		br.l	.L5.71
 4032      00000F18 
 4033              	.L5.74:
 4034              	# line 853
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 4035              		.loc	1 853 0
 4036 5598 00000000 		adds.w.sx	%s63,1,%s63
 4036      BF013F4A 
 4037 55a0 00000000 		adds.w.sx	%s57,1,%s57
 4037      B901394A 
 4038 55a8 50080000 		brgt.w	0,%s63,.L5.75
 4038      BF008118 
 4039 55b0 90FFFFFF 		br.l	.L5.73
 4039      00000F18 
 4040              	.L5.76:
 4041 55b8 78FEFFFF 		ld	%s63,-392(,%fp)	# restore 
 4041      89003F01 
 4042 55c0 70FEFFFF 		ld	%s57,-400(,%fp)	# restore 
 4042      89003901 
 4043 55c8 80FEFFFF 		ld	%s19,-384(,%fp)	# restore 
 4043      89001301 
 4044 55d0 68FEFFFF 		ld	%s62,-408(,%fp)	# restore 
 4044      89003E01 
 4045 55d8 60FEFFFF 		ld	%s61,-416(,%fp)	# restore 
 4045      89003D01 
 4046 55e0 58FEFFFF 		ld	%s60,-424(,%fp)	# restore 
 4046      89003C01 
 4047 55e8 50FEFFFF 		ld	%s59,-432(,%fp)	# restore 
 4047      89003B01 
 4048 55f0 A8FFFFFF 		br.l	.L5.74
 4048      00000F18 
 4049              	.L5.77:
 4050              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4051              		.loc	1 855 0
 4052 55f8 00000000 		adds.w.sx	%s63,1,%s63
 4052      BF013F4A 
 4053 5600 00000000 		adds.w.sx	%s57,%s58,%s57
 4053      B9BA394A 
 4054 5608 00000000 		adds.w.sx	%s55,%s58,%s55
 4054      B7BA374A 
 4055 5610 00000000 		adds.w.sx	%s32,%s54,%s32
 4055      A0B6204A 
 4056 5618 00000000 		adds.w.sx	%s53,1,%s53
 4056      B501354A 
 4057 5620 58070000 		brgt.w	0,%s63,.L5.78
 4057      BF008118 
 4058 5628 90FFFFFF 		br.l	.L5.76
 4058      00000F18 
 4059              	.L5.79:
 4060 5630 E0FFFFFF 		st	%s41,-32(,%fp)	# spill 
 4060      89002911 
 4061 5638 D8FFFFFF 		st	%s46,-40(,%fp)	# spill 
 4061      89002E11 
 4062 5640 D0FFFFFF 		st	%s59,-48(,%fp)	# spill 
 4062      89003B11 
 4063 5648 88FEFFFF 		st	%s40,-376(,%fp)	# spill 
 4063      89002811 
 4064 5650 C0FFFFFF 		st	%s34,-64(,%fp)	# spill 
 4064      89002211 
 4065 5658 C8FFFFFF 		st	%s45,-56(,%fp)	# spill 
 4065      89002D11 
 4066 5660 90FEFFFF 		st	%s21,-368(,%fp)	# spill 
 4066      89001511 
 4067 5668 98FEFFFF 		st	%s62,-360(,%fp)	# spill 
 4067      89003E11 
 4068 5670 A0FEFFFF 		st	%s44,-352(,%fp)	# spill 
 4068      89002C11 
 4069 5678 A8FEFFFF 		st	%s43,-344(,%fp)	# spill 
 4069      89002B11 
 4070 5680 B0FEFFFF 		st	%s48,-336(,%fp)	# spill 
 4070      89003011 
 4071 5688 B8FEFFFF 		st	%s39,-328(,%fp)	# spill 
 4071      89002711 
 4072 5690 C0FEFFFF 		st	%s38,-320(,%fp)	# spill 
 4072      89002611 
 4073 5698 A8FFFFFF 		st	%s5,-88(,%fp)	# spill 
 4073      89000511 
 4074 56a0 B0FFFFFF 		st	%s6,-80(,%fp)	# spill 
 4074      89000611 
 4075 56a8 C8FEFFFF 		st	%s1,-312(,%fp)	# spill 
 4075      89000111 
 4076 56b0 D0FEFFFF 		st	%s31,-304(,%fp)	# spill 
 4076      89001F11 
 4077 56b8 D8FEFFFF 		st	%s61,-296(,%fp)	# spill 
 4077      89003D11 
 4078 56c0 E0FEFFFF 		st	%s56,-288(,%fp)	# spill 
 4078      89003811 
 4079 56c8 E8FEFFFF 		st	%s60,-280(,%fp)	# spill 
 4079      89003C11 
 4080 56d0 F0FEFFFF 		st	%s51,-272(,%fp)	# spill 
 4080      89003311 
 4081 56d8 F8FEFFFF 		st	%s42,-264(,%fp)	# spill 
 4081      89002A11 
 4082 56e0 00FFFFFF 		st	%s49,-256(,%fp)	# spill 
 4082      89003111 
 4083 56e8 90FFFFFF 		ld	%s62,-112(,%fp)	# restore 
 4083      89003E01 
 4084              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4085              		.loc	1 856 0
 4086 56f0 00000000 		subs.l	%s0,0,%s62
 4086      BE00005B 
 4087 56f8 00000000 		lea	%s12,__grow_stack@LO
 4087      00000C06 
 4088 5700 00000000 		and	%s12,%s12,(32)0
 4088      608C0C44 
 4089 5708 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4089      8C008C06 
 4090 5710 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4090      8C000A08 
 4091 5718 A0FFFFFF 		ld	%s63,-96(,%fp)	# restore 
 4091      89003F01 
 4092 5720 10FFFFFF 		ld	%s58,-240(,%fp)	# restore 
 4092      89003A01 
 4093 5728 18FFFFFF 		ld	%s57,-232(,%fp)	# restore 
 4093      89003901 
 4094 5730 20FFFFFF 		ld	%s55,-224(,%fp)	# restore 
 4094      89003701 
 4095 5738 68FFFFFF 		ld	%s54,-152(,%fp)	# restore 
 4095      89003601 
 4096 5740 50FFFFFF 		ld	%s53,-176(,%fp)	# restore 
 4096      89003501 
 4097 5748 88FFFFFF 		ld	%s18,-120(,%fp)	# restore 
 4097      89001201 
 4098 5750 80FFFFFF 		ld	%s45,-128(,%fp)	# restore 
 4098      89002D01 
 4099 5758 78FFFFFF 		ld	%s7,-136(,%fp)	# restore 
 4099      89000701 
 4100 5760 70FFFFFF 		ld	%s30,-144(,%fp)	# restore 
 4100      89001E01 
 4101 5768 60FFFFFF 		ld	%s36,-160(,%fp)	# restore 
 4101      89002401 
 4102 5770 58FFFFFF 		ld	%s25,-168(,%fp)	# restore 
 4102      89001901 
 4103 5778 48FFFFFF 		ld	%s31,-184(,%fp)	# restore 
 4103      89001F01 
 4104 5780 40FFFFFF 		ld	%s33,-192(,%fp)	# restore 
 4104      89002101 
 4105 5788 38FFFFFF 		ld	%s26,-200(,%fp)	# restore 
 4105      89001A01 
 4106 5790 30FFFFFF 		ld	%s27,-208(,%fp)	# restore 
 4106      89001B01 
 4107 5798 28FFFFFF 		ld	%s28,-216(,%fp)	# restore 
 4107      89001C01 
 4108 57a0 08FFFFFF 		ld	%s29,-248(,%fp)	# restore 
 4108      89001D01 
 4109 57a8 50FEFFFF 		br.l	.L5.77
 4109      00000F18 
 4110              	.L5.15:
 4111              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 4112              		.loc	1 874 0
 4113 57b0 00000000 		adds.l	%s53,4,%s53
 4113      B5043559 
 4114 57b8 00000000 		adds.l	%s52,%s52,%s51
 4114      B3B43459 
 4115 57c0 00000000 		adds.l	%s58,4,%s58
 4115      BA043A59 
 4116 57c8 00000000 		adds.w.sx	%s50,-1,%s50
 4116      B27F324A 
 4117 57d0 10000000 		brlt.w	0,%s50,.L5.80
 4117      B2008218 
 4118 57d8 58FEFFFF 		br.l	.L5.79
 4118      00000F18 
 4119              	.L5.80:
 4120              	# line 867
 867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp **** 
 4121              		.loc	1 867 0
 4122 57e0 00000000 		ldl.sx	%s18,0(%s58,%s63)
 4122      BFBA1203 
 4123 57e8 00000000 		ldl.sx	%s20,0(%s58,%s57)
 4123      B9BA1403 
 4124 57f0 00000000 		ldl.sx	%s19,0(%s58,%s55)
 4124      B7BA1303 
 4125 57f8 00000000 		ldl.sx	%s22,0(%s58,%s54)
 4125      B6BA1603 
 4126 5800 B0FFFFFF 		brge.w	%s22,%s18,.L5.15
 4126      92968518 
 4127 5808 20F2FFFF 		br.l	.L5.31
 4127      00000F18 
 4128              	.L5.81:
 4129 5810 88FFFFFF 		st	%s21,-120(,%fp)	# spill 
 4129      89001511 
 4130 5818 80FFFFFF 		st	%s45,-128(,%fp)	# spill 
 4130      89002D11 
 4131 5820 78FFFFFF 		st	%s7,-136(,%fp)	# spill 
 4131      89000711 
 4132 5828 70FFFFFF 		st	%s30,-144(,%fp)	# spill 
 4132      89001E11 
 4133 5830 68FFFFFF 		st	%s54,-152(,%fp)	# spill 
 4133      89003611 
 4134 5838 60FFFFFF 		st	%s36,-160(,%fp)	# spill 
 4134      89002411 
 4135 5840 58FFFFFF 		st	%s25,-168(,%fp)	# spill 
 4135      89001911 
 4136 5848 50FFFFFF 		st	%s24,-176(,%fp)	# spill 
 4136      89001811 
 4137 5850 48FFFFFF 		st	%s31,-184(,%fp)	# spill 
 4137      89001F11 
 4138 5858 40FFFFFF 		st	%s33,-192(,%fp)	# spill 
 4138      89002111 
 4139 5860 38FFFFFF 		st	%s26,-200(,%fp)	# spill 
 4139      89001A11 
 4140 5868 30FFFFFF 		st	%s27,-208(,%fp)	# spill 
 4140      89001B11 
 4141 5870 28FFFFFF 		st	%s28,-216(,%fp)	# spill 
 4141      89001C11 
 4142 5878 20FFFFFF 		st	%s55,-224(,%fp)	# spill 
 4142      89003711 
 4143 5880 18FFFFFF 		st	%s57,-232(,%fp)	# spill 
 4143      89003911 
 4144 5888 A0FFFFFF 		st	%s22,-96(,%fp)	# spill 
 4144      89001611 
 4145 5890 10FFFFFF 		st	%s23,-240(,%fp)	# spill 
 4145      89001711 
 4146 5898 08FFFFFF 		st	%s29,-248(,%fp)	# spill 
 4146      89001D11 
 4147 58a0 90FFFFFF 		st	%s40,-112(,%fp)	# spill 
 4147      89002811 
 4148 58a8 00000000 		or	%s50,0,%s44
 4148      AC003245 
 4149              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 4150              		.loc	1 874 0
 4151 58b0 00000000 		or	%s53,0,(0)1
 4151      00003545 
 4152 58b8 00000000 		or	%s58,0,(0)1
 4152      00003A45 
 4153 58c0 00000000 		or	%s63,0,%s42
 4153      AA003F45 
 4154 58c8 00000000 		or	%s57,0,%s43
 4154      AB003945 
 4155 58d0 00000000 		or	%s55,0,%s48
 4155      B0003745 
 4156 58d8 00000000 		or	%s54,0,%s49
 4156      B1003645 
 4157 58e0 00000000 		or	%s52,0,%s38
 4157      A6003445 
 4158 58e8 00000000 		or	%s7,0,%s39
 4158      A7000745 
 4159 58f0 00FFFFFF 		ld	%s49,-256(,%fp)	# restore 
 4159      89003101 
 4160 58f8 F8FEFFFF 		ld	%s42,-264(,%fp)	# restore 
 4160      89002A01 
 4161 5900 F0FEFFFF 		ld	%s51,-272(,%fp)	# restore 
 4161      89003301 
 4162 5908 E8FEFFFF 		ld	%s60,-280(,%fp)	# restore 
 4162      89003C01 
 4163 5910 E0FEFFFF 		ld	%s56,-288(,%fp)	# restore 
 4163      89003801 
 4164 5918 D8FEFFFF 		ld	%s61,-296(,%fp)	# restore 
 4164      89003D01 
 4165 5920 D0FEFFFF 		ld	%s31,-304(,%fp)	# restore 
 4165      89001F01 
 4166 5928 C8FEFFFF 		ld	%s1,-312(,%fp)	# restore 
 4166      89000101 
 4167 5930 B0FFFFFF 		ld	%s6,-80(,%fp)	# restore 
 4167      89000601 
 4168 5938 A8FFFFFF 		ld	%s5,-88(,%fp)	# restore 
 4168      89000501 
 4169 5940 C0FEFFFF 		ld	%s38,-320(,%fp)	# restore 
 4169      89002601 
 4170 5948 B8FEFFFF 		ld	%s39,-328(,%fp)	# restore 
 4170      89002701 
 4171 5950 B0FEFFFF 		ld	%s48,-336(,%fp)	# restore 
 4171      89003001 
 4172 5958 A8FEFFFF 		ld	%s43,-344(,%fp)	# restore 
 4172      89002B01 
 4173 5960 A0FEFFFF 		ld	%s44,-352(,%fp)	# restore 
 4173      89002C01 
 4174 5968 98FEFFFF 		ld	%s62,-360(,%fp)	# restore 
 4174      89003E01 
 4175 5970 90FEFFFF 		ld	%s21,-368(,%fp)	# restore 
 4175      89001501 
 4176 5978 C8FFFFFF 		ld	%s45,-56(,%fp)	# restore 
 4176      89002D01 
 4177 5980 C0FFFFFF 		ld	%s34,-64(,%fp)	# restore 
 4177      89002201 
 4178 5988 88FEFFFF 		ld	%s40,-376(,%fp)	# restore 
 4178      89002801 
 4179 5990 D0FFFFFF 		ld	%s59,-48(,%fp)	# restore 
 4179      89003B01 
 4180 5998 D8FFFFFF 		ld	%s46,-40(,%fp)	# restore 
 4180      89002E01 
 4181 59a0 E0FFFFFF 		ld	%s41,-32(,%fp)	# restore 
 4181      89002901 
 4182 59a8 38FEFFFF 		br.l	.L5.80
 4182      00000F18 
 4183              	.L5.7:
 4184              	# line 859
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 4185              		.loc	1 859 0
 4186 59b0 00000000 		subs.w.sx	%s52,%s53,%s52
 4186      B4B5345A 
 4187              	# line 860
 860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_end > OH) oh_end = OH;
 4188              		.loc	1 860 0
 4189 59b8 00000000 		maxs.w.sx	%s19,%s51,(0)1
 4189      00B31378 
 4190 59c0 00000000 		lvl	%s50
 4190      00B200BF 
 4191 59c8 0000002A 		vbrd	%v42,%s19
 4191      0093008C 
 4192 59d0 00000000 		adds.l	%s51,%s47,%s46
 4192      AEAF3359 
 4193 59d8 0000002A 		vstl.nc	%v42,4,%s51
 4193      B3040093 
 4194              	# line 861
 861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int ow_beg, ow_end;
 4195              		.loc	1 861 0
 4196 59e0 80000000 		mins.w.sx	%s20,%s52,%s45
 4196      ADB41478 
 4197 59e8 00000029 		vbrd	%v41,%s20
 4197      0094008C 
 4198 59f0 00000000 		adds.l	%s52,%s41,%s46
 4198      AEA93459 
 4199 59f8 00000029 		vstl.nc	%v41,4,%s52
 4199      B4040093 
 4200              	# line 863
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_end = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 4201              		.loc	1 863 0
 4202 5a00 002E0028 		vadds.w.sx	%v40,%s37,%v46
 4202      00A520CA 
 4203 5a08 00280027 		vor	%v39,(0)1,%v40
 4203      000020C5 
 4204 5a10 002E0026 		vadds.w.sx	%v38,%s37,%v46
 4204      00A520CA 
 4205 5a18 00002625 		vdivs.w.sx	%v37,%v38,%s36
 4205      00A410EB 
 4206 5a20 00250024 		vmuls.w.sx	%v36,%s36,%v37
 4206      00A420CB 
 4207 5a28 002E0023 		vadds.w.sx	%v35,%s37,%v46
 4207      00A520CA 
 4208 5a30 00242322 		vsubs.w.sx	%v34,%v35,%v36
 4208      000000DA 
 4209 5a38 0022050F 		vfmk.w.ge	%vm15,%v34
 4209      000000B5 
 4210 5a40 0000002D 		vbrd	%v45,0,%vm15
 4210      00000F8C 
 4211 5a48 00000F0F 		negm	%vm15,%vm15
 4211      00000095 
 4212 5a50 0000002D 		vbrd	%v45,1,%vm15
 4212      00010F8C 
 4213 5a58 00002721 		vdivs.w.sx	%v33,%v39,%s36
 4213      00A410EB 
 4214 5a60 002D2120 		vsubs.w.sx	%v32,%v33,%v45
 4214      000000DA 
 4215              	# line 864
 864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
 4216              		.loc	1 864 0
 4217 5a68 002C001F 		vadds.w.sx	%v31,%s35,%v44
 4217      00A320CA 
 4218 5a70 001F001E 		vor	%v30,(0)1,%v31
 4218      000020C5 
 4219 5a78 002C001D 		vadds.w.sx	%v29,%s35,%v44
 4219      00A320CA 
 4220 5a80 00001D1C 		vdivs.w.sx	%v28,%v29,%s36
 4220      00A410EB 
 4221 5a88 001C001B 		vmuls.w.sx	%v27,%s36,%v28
 4221      00A420CB 
 4222 5a90 002C001A 		vadds.w.sx	%v26,%s35,%v44
 4222      00A320CA 
 4223 5a98 001B1A19 		vsubs.w.sx	%v25,%v26,%v27
 4223      000000DA 
 4224 5aa0 0019050F 		vfmk.w.ge	%vm15,%v25
 4224      000000B5 
 4225 5aa8 0000002B 		vbrd	%v43,0,%vm15
 4225      00000F8C 
 4226 5ab0 00000F0F 		negm	%vm15,%vm15
 4226      00000095 
 4227 5ab8 0000002B 		vbrd	%v43,1,%vm15
 4227      00010F8C 
 4228 5ac0 00001E18 		vdivs.w.sx	%v24,%v30,%s36
 4228      00A410EB 
 4229 5ac8 002B1817 		vsubs.w.sx	%v23,%v24,%v43
 4229      000000DA 
 4230              	# line 865
 865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (ow_end > OW) ow_end = OW;
 4231              		.loc	1 865 0
 4232 5ad0 00200016 		vmaxs.w.sx	%v22,0,%v32
 4232      0000208A 
 4233 5ad8 00000000 		adds.l	%s52,%s34,%s46
 4233      AEA23459 
 4234 5ae0 00000016 		vstl.nc	%v22,4,%s52
 4234      B4040093 
 4235              	# line 866
 866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
 4236              		.loc	1 866 0
 4237 5ae8 00170015 		vmins.w.sx	%v21,%s7,%v23
 4237      0087308A 
 4238 5af0 00000000 		adds.l	%s52,%s6,%s46
 4238      AE863459 
 4239 5af8 00000015 		vstl.nc	%v21,4,%s52
 4239      B4040093 
 4240 5b00 00000000 		adds.w.sx	%s35,%s35,%s5
 4240      85A3234A 
 4241 5b08 00000000 		adds.w.sx	%s37,%s37,%s4
 4241      84A5254A 
 4242 5b10 00000000 		or	%s3,0,%s3
 4242      83000345 
 4243 5b18 00000000 		adds.l	%s46,%s46,%s3
 4243      83AE2E59 
 4244 5b20 00000000 		or	%s3,0,%s2
 4244      82000345 
 4245 5b28 00000000 		subs.w.sx	%s1,%s1,%s50
 4245      B281015A 
 4246 5b30 E0FCFFFF 		brge.w	0,%s1,.L5.81
 4246      81008518 
 4247 5b38 98E8FFFF 		br.l	.L5.8
 4247      00000F18 
 4248              	.L5.82:
 4249              	# line 859
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 4250              		.loc	1 859 0
 4251 5b40 00000000 		or	%s52,1,(0)1
 4251      00013445 
 4252 5b48 00000000 		or	%s51,0,%s53
 4252      B5003345 
 4253 5b50 00000000 		or	%s53,0,%s20
 4253      94003545 
 4254 5b58 00000000 		or	%s62,0,%s19
 4254      93003E45 
 4255 5b60 50FEFFFF 		br.l	.L5.7
 4255      00000F18 
 4256              	.L5.5:
 4257              	# line 858
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               oh_end = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 4258              		.loc	1 858 0
 4259 5b68 00000000 		subs.w.sx	%s53,%s58,%s53
 4259      B5BA355A 
 4260 5b70 D0FFFFFF 		brgt.w	0,%s19,.L5.82
 4260      93008118 
 4261 5b78 30E8FFFF 		br.l	.L5.6
 4261      00000F18 
 4262              	.L5.83:
 4263 5b80 00000000 		or	%s63,1,(0)1
 4263      00013F45 
 4264 5b88 00000000 		or	%s19,0,%s62
 4264      BE001345 
 4265 5b90 00000000 		or	%s20,0,%s53
 4265      B5001445 
 4266 5b98 00000000 		or	%s53,0,%s63
 4266      BF003545 
 4267 5ba0 C8FFFFFF 		br.l	.L5.5
 4267      00000F18 
 4268              	.L5.9:
 4269 5ba8 D8FFFFFF 		brgt.w	0,%s18,.L5.83
 4269      92008118 
 4270 5bb0 D0E7FFFF 		br.l	.L5.4
 4270      00000F18 
 4271              	.L5.84:
 4272 5bb8 A0FFFFFF 		st	%s63,-96(,%fp)	# spill 
 4272      89003F11 
 4273 5bc0 00000000 		divs.w.sx	%s38,%s57,%s25
 4273      99B9267B 
 4274 5bc8 00000000 		muls.w.sx	%s63,%s25,%s38
 4274      A6993F4B 
 4275 5bd0 00000000 		subs.w.sx	%s39,%s57,%s63
 4275      BFB9275A 
 4276              	# line 859
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 4277              		.loc	1 859 0
 4278 5bd8 00000000 		divs.w.sx	%s40,%s55,%s25
 4278      99B7287B 
 4279 5be0 00000000 		muls.w.sx	%s63,%s25,%s40
 4279      A8993F4B 
 4280 5be8 00000000 		subs.w.sx	%s62,%s55,%s63
 4280      BFB73E5A 
 4281 5bf0 00000000 		or	%s63,0,%s53
 4281      B5003F45 
 4282 5bf8 00000000 		or	%s37,0,%s26
 4282      9A002545 
 4283 5c00 00000000 		or	%s35,0,%s27
 4283      9B002345 
 4284 5c08 00000000 		or	%s42,0,%s38
 4284      A6002A45 
 4285 5c10 00000000 		or	%s38,0,%s28
 4285      9C002645 
 4286              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 4287              		.loc	1 869 0
 4288 5c18 00000000 		muls.l	%s63,%s63,%s29
 4288      9DBF3F6E 
 4289 5c20 00000000 		adds.l	%s43,%s63,%s30
 4289      9EBF2B59 
 4290              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4291              		.loc	1 856 0
 4292 5c28 00000000 		subs.w.sx	%s44,0,%s31
 4292      9F002C5A 
 4293 5c30 00000000 		smvl	%s63
 4293      00003F2E 
 4294 5c38 98FFFFFF 		st	%s63,-104(,%fp)	# spill 
 4294      89003F11 
 4295 5c40 00000000 		muls.l	%s0,16,%s44
 4295      AC10006E 
 4296 5c48 90FFFFFF 		st	%s0,-112(,%fp)	# spill 
 4296      89000011 
 4297 5c50 00000000 		lea	%s12,__grow_stack@LO
 4297      00000C06 
 4298 5c58 00000000 		and	%s12,%s12,(32)0
 4298      608C0C44 
 4299 5c60 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4299      8C008C06 
 4300 5c68 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4300      8C000A08 
 4301 5c70 B8000000 		lea	%s63,184
 4301      00003F06 
 4302 5c78 00000000 		adds.l	%s6,%sp,%s63
 4302      BF8B0659 
 4303 5c80 98FFFFFF 		ld	%s63,-104(,%fp)	# restore 
 4303      89003F01 
 4304 5c88 00000000 		or	%s61,0,%s42
 4304      AA003D45 
 4305 5c90 00000000 		or	%s42,0,%s6
 4305      86002A45 
 4306 5c98 00000000 		muls.w.sx	%s60,4,%s44
 4306      AC043C4B 
 4307 5ca0 00000000 		or	%s21,0,%s18
 4307      92001545 
 4308 5ca8 00000000 		or	%s18,0,%s39
 4308      A7001245 
 4309 5cb0 00000000 		adds.l	%s41,%s6,%s60
 4309      BC862959 
 4310 5cb8 A0FFFFFF 		ld	%s22,-96(,%fp)	# restore 
 4310      89001601 
 4311 5cc0 00000000 		or	%s23,0,%s58
 4311      BA001745 
 4312 5cc8 00000000 		or	%s58,0,%s61
 4312      BD003A45 
 4313 5cd0 00000000 		or	%s24,0,%s53
 4313      B5001845 
 4314 5cd8 00000000 		or	%s53,0,%s40
 4314      A8003545 
 4315 5ce0 00000000 		or	%s39,0,%s43
 4315      AB002745 
 4316 5ce8 00000000 		or	%s43,0,%s41
 4316      A9002B45 
 4317 5cf0 00000000 		adds.l	%s47,%s41,%s60
 4317      BCA92F59 
 4318 5cf8 90FFFFFF 		ld	%s40,-112(,%fp)	# restore 
 4318      89002801 
 4319 5d00 00000000 		or	%s48,0,%s47
 4319      AF003045 
 4320 5d08 00000000 		adds.l	%s34,%s47,%s60
 4320      BCAF2259 
 4321 5d10 00000000 		or	%s49,0,%s34
 4321      A2003145 
 4322 5d18 80000000 		mins.w.sx	%s50,%s44,%s63
 4322      BFAC3278 
 4323 5d20 00000000 		or	%s1,0,%s44
 4323      AC000145 
 4324 5d28 00000000 		muls.w.sx	%s5,%s33,%s50
 4324      B2A1054B 
 4325 5d30 00000000 		lvl	%s50
 4325      00B200BF 
 4326 5d38 00000010 		vseq	%v16
 4326      00000099 
 4327 5d40 0010002C 		vmuls.w.sx	%v44,%s33,%v16
 4327      00A120CB 
 4328 5d48 00000000 		muls.w.sx	%s4,%s33,%s50
 4328      B2A1044B 
 4329 5d50 0010002E 		vmuls.w.sx	%v46,%s33,%v16
 4329      00A120CB 
 4330 5d58 00000000 		muls.w.sx	%s3,4,%s50
 4330      B204034B 
 4331 5d60 00000000 		or	%s46,0,(0)1
 4331      00002E45 
 4332 5d68 00000000 		muls.w.sx	%s2,4,%s63
 4332      BF04024B 
 4333 5d70 38FEFFFF 		br.l	.L5.9
 4333      00000F18 
 4334              	.L5.78:
 4335 5d78 40FEFFFF 		brlt.w	0,%s18,.L5.84
 4335      92008218 
 4336 5d80 78F8FFFF 		br.l	.L5.77
 4336      00000F18 
 4337              	.L5.85:
 4338 5d88 80FEFFFF 		st	%s19,-384(,%fp)	# spill 
 4338      89001311 
 4339 5d90 78FEFFFF 		st	%s63,-392(,%fp)	# spill 
 4339      89003F11 
 4340 5d98 70FEFFFF 		st	%s57,-400(,%fp)	# spill 
 4340      89003911 
 4341 5da0 68FEFFFF 		st	%s62,-408(,%fp)	# spill 
 4341      89003E11 
 4342 5da8 60FEFFFF 		st	%s61,-416(,%fp)	# spill 
 4342      89003D11 
 4343 5db0 58FEFFFF 		st	%s60,-424(,%fp)	# spill 
 4343      89003C11 
 4344 5db8 50FEFFFF 		st	%s59,-432(,%fp)	# spill 
 4344      89003B11 
 4345 5dc0 00000000 		or	%s40,0,%s57
 4345      B9002845 
 4346 5dc8 88FEFFFF 		st	%s40,-376(,%fp)	# spill 
 4346      89002811 
 4347 5dd0 00000000 		or	%s63,0,%s62
 4347      BE003F45 
 4348 5dd8 00000000 		or	%s57,0,%s61
 4348      BD003945 
 4349 5de0 00000000 		or	%s55,0,%s60
 4349      BC003745 
 4350 5de8 00000000 		or	%s32,0,%s59
 4350      BB002045 
 4351 5df0 88FFFFFF 		br.l	.L5.78
 4351      00000F18 
 4352              	.L5.75:
 4353              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4354              		.loc	1 855 0
 4355 5df8 00000000 		or	%s53,0,(0)1
 4355      00003545 
 4356 5e00 88FFFFFF 		brlt.w	0,%s19,.L5.85
 4356      93008218 
 4357 5e08 90F7FFFF 		br.l	.L5.74
 4357      00000F18 
 4358              	.L5.86:
 4359 5e10 48FEFFFF 		st	%s20,-440(,%fp)	# spill 
 4359      89001411 
 4360 5e18 40FEFFFF 		st	%s52,-448(,%fp)	# spill 
 4360      89003411 
 4361 5e20 38FEFFFF 		st	%s50,-456(,%fp)	# spill 
 4361      89003211 
 4362 5e28 F8FEFFFF 		st	%s42,-264(,%fp)	# spill 
 4362      89002A11 
 4363 5e30 00FFFFFF 		st	%s49,-256(,%fp)	# spill 
 4363      89003111 
 4364 5e38 30FEFFFF 		st	%s63,-464(,%fp)	# spill 
 4364      89003F11 
 4365 5e40 28FEFFFF 		st	%s55,-472(,%fp)	# spill 
 4365      89003711 
 4366 5e48 20FEFFFF 		st	%s53,-480(,%fp)	# spill 
 4366      89003511 
 4367 5e50 18FEFFFF 		st	%s56,-488(,%fp)	# spill 
 4367      89003811 
 4368 5e58 E0FFFFFF 		st	%s41,-32(,%fp)	# spill 
 4368      89002911 
 4369              	# line 853
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 4370              		.loc	1 853 0
 4371 5e60 00000000 		divs.w.sx	%s41,%s56,%s41
 4371      A9B8297B 
 4372 5e68 00000000 		subs.w.sx	%s41,0,%s41
 4372      A900295A 
 4373 5e70 00000000 		or	%s63,0,%s41
 4373      A9003F45 
 4374 5e78 00000000 		or	%s53,0,%s53
 4374      B5003545 
 4375 5e80 D0FFFFFF 		st	%s53,-48(,%fp)	# spill 
 4375      89003511 
 4376 5e88 70FFFFFF 		br.l	.L5.75
 4376      00000F18 
 4377              	.L5.72:
 4378 5e90 00000000 		or	%s57,0,(0)1
 4378      00003945 
 4379 5e98 78FFFFFF 		brlt.w	0,%s20,.L5.86
 4379      94008218 
 4380 5ea0 70F6FFFF 		br.l	.L5.71
 4380      00000F18 
 4381              	.L5.87:
 4382 5ea8 90FDFFFF 		st	%s3,-624(,%fp)	# spill 
 4382      89000311 
 4383 5eb0 88FDFFFF 		st	%s4,-632(,%fp)	# spill 
 4383      89000411 
 4384 5eb8 80FDFFFF 		st	%s0,-640(,%fp)	# spill 
 4384      89000011 
 4385 5ec0 14000000 		dldl.sx	%s56,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 4385      8000380B 
 4386 5ec8 00000000 		or	%s57,0,%s56
 4386      B8003945 
 4387 5ed0 00000000 		or	%s55,0,%s57
 4387      B9003745 
 4388              	# line 852
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4389              		.loc	1 852 0
 4390 5ed8 00000000 		or	%s53,0,(0)1
 4390      00003545 
 4391              	# line 853
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 4392              		.loc	1 853 0
 4393 5ee0 00000000 		divs.w.sx	%s20,%s56,%s41
 4393      A9B8147B 
 4394 5ee8 00000000 		or	%s57,0,%s41
 4394      A9003945 
 4395 5ef0 C8FFFFFF 		st	%s57,-56(,%fp)	# spill 
 4395      89003911 
 4396              	# line 852
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4397              		.loc	1 852 0
 4398 5ef8 00000000 		subs.w.sx	%s57,0,%s41
 4398      A900395A 
 4399 5f00 00000000 		or	%s63,0,%s57
 4399      B9003F45 
 4400              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4401              		.loc	1 855 0
 4402 5f08 20000000 		dldl.sx	%s19,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 4402      8000130B 
 4403 5f10 00000000 		or	%s57,0,%s19
 4403      93003945 
 4404 5f18 00000000 		or	%s57,0,%s57
 4404      B9003945 
 4405 5f20 00000000 		subs.w.sx	%s62,0,%s19
 4405      93003E5A 
 4406              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4407              		.loc	1 856 0
 4408 5f28 24000000 		dldl.sx	%s18,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 4408      8000120B 
 4409 5f30 00000000 		or	%s51,0,%s18
 4409      92003345 
 4410 5f38 00000000 		or	%s51,0,%s51
 4410      B3003345 
 4411              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 4412              		.loc	1 869 0
 4413 5f40 00000000 		muls.l	%s57,%s57,%s51
 4413      B3B9396E 
 4414              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4415              		.loc	1 856 0
 4416 5f48 00000000 		subs.w.sx	%s31,0,%s18
 4416      92001F5A 
 4417              	# line 858
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               oh_end = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 4418              		.loc	1 858 0
 4419 5f50 30000000 		dldl.sx	%s48,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 4419      8000300B 
 4420 5f58 38000000 		dldl.sx	%s47,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 4420      80002F0B 
 4421 5f60 00000000 		adds.w.sx	%s47,1,%s47
 4421      AF012F4A 
 4422              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4423              		.loc	1 855 0
 4424 5f68 00000000 		subs.w.sx	%s58,0,%s47
 4424      AF003A5A 
 4425              	# line 858
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               oh_end = div_floor( IH + PH - kh*(p->dh+1) + SH - 1, SH);//(d-a+b-1)/b
 4426              		.loc	1 858 0
 4427 5f70 28000000 		dldl.sx	%s25,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 4427      8000190B 
 4428              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4429              		.loc	1 855 0
 4430 5f78 00000000 		adds.w.sx	%s47,%s48,%s25
 4430      99B02F4A 
 4431              	# line 859
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 4432              		.loc	1 859 0
 4433 5f80 0C000000 		dldl.sx	%s46,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 4433      80002E0B 
 4434 5f88 00000000 		adds.w.sx	%s46,%s48,%s46
 4434      AEB02E4A 
 4435              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4436              		.loc	1 855 0
 4437 5f90 00000000 		adds.w.sx	%s46,%s25,%s46
 4437      AE992E4A 
 4438              	# line 861
 861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int ow_beg, ow_end;
 4439              		.loc	1 861 0
 4440 5f98 18000000 		dldl.sx	%s45,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 4440      80002D0B 
 4441              	# line 863
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_end = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 4442              		.loc	1 863 0
 4443 5fa0 34000000 		dldl.sx	%s48,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 4443      8000300B 
 4444 5fa8 3C000000 		dldl.sx	%s44,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 4444      80002C0B 
 4445 5fb0 00000000 		adds.w.sx	%s44,1,%s44
 4445      AC012C4A 
 4446              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4447              		.loc	1 856 0
 4448 5fb8 00000000 		subs.w.sx	%s33,0,%s44
 4448      AC00215A 
 4449              	# line 863
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               ow_end = div_floor( IW + PW - kw*(p->dw+1) + SW - 1, SW);//(d-a+b-1)/b
 4450              		.loc	1 863 0
 4451 5fc0 2C000000 		dldl.sx	%s36,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 4451      8000240B 
 4452              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4453              		.loc	1 856 0
 4454 5fc8 00000000 		adds.w.sx	%s44,%s48,%s36
 4454      A4B02C4A 
 4455              	# line 864
 864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
 4456              		.loc	1 864 0
 4457 5fd0 10000000 		dldl.sx	%s43,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 4457      80002B0B 
 4458 5fd8 00000000 		adds.w.sx	%s43,%s48,%s43
 4458      ABB02B4A 
 4459              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4460              		.loc	1 856 0
 4461 5fe0 00000000 		adds.w.sx	%s43,%s36,%s43
 4461      ABA42B4A 
 4462              	# line 866
 866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
 4463              		.loc	1 866 0
 4464 5fe8 1C000000 		dldl.sx	%s7,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 4464      8000070B 
 4465              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 4466              		.loc	1 869 0
 4467 5ff0 08000000 		dldl.sx	%s48,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 4467      8000300B 
 4468 5ff8 D8FFFFFF 		st	%s48,-40(,%fp)	# spill 
 4468      89003011 
 4469 6000 00000000 		or	%s34,0,%s48
 4469      B0002245 
 4470 6008 C0FFFFFF 		st	%s34,-64(,%fp)	# spill 
 4470      89002211 
 4471              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 4472              		.loc	1 874 0
 4473 6010 A8010000 		dld	%s30,424(,%s2)	# *(diff_wei_m).data_
 4473      82001E09 
 4474              	# line 872
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 4475              		.loc	1 872 0
 4476 6018 04000000 		dldl.sx	%s21,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 4476      8000150B 
 4477 6020 90FEFFFF 		st	%s21,-368(,%fp)	# spill 
 4477      89001511 
 4478 6028 00000000 		subs.w.sx	%s21,0,%s21
 4478      9500155A 
 4479              	# line 869
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 4480              		.loc	1 869 0
 4481 6030 00000000 		muls.l	%s57,4,%s57
 4481      B904396E 
 4482 6038 D0FEFFFF 		st	%s21,-304(,%fp)	# spill 
 4482      89001511 
 4483 6040 E8FEFFFF 		st	%s57,-280(,%fp)	# spill 
 4483      89003911 
 4484 6048 00000000 		muls.l	%s29,4,%s51
 4484      B3041D6E 
 4485              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 4486              		.loc	1 874 0
 4487 6050 A8010000 		dld	%s6,424(,%s4)	# *(s$123).data_
 4487      84000609 
 4488              	# line 852
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4489              		.loc	1 852 0
 4490 6058 00000000 		or	%s49,0,(0)1
 4490      00003145 
 4491 6060 00000000 		or	%s42,0,(0)1
 4491      00002A45 
 4492 6068 B0FFFFFF 		st	%s6,-80(,%fp)	# spill 
 4492      89000611 
 4493              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 4494              		.loc	1 874 0
 4495 6070 A8010000 		dld	%s5,424(,%s1)	# *(s$125).data_
 4495      81000509 
 4496              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 4497              		.loc	1 879 0
 4498 6078 28000000 		dldl.sx	%s57,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 4498      8000390B 
 4499 6080 A8FFFFFF 		st	%s5,-88(,%fp)	# spill 
 4499      89000511 
 4500 6088 98FEFFFF 		st	%s57,-360(,%fp)	# spill 
 4500      89003911 
 4501 6090 30000000 		dldl.sx	%s57,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 4501      8000390B 
 4502              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4503              		.loc	1 855 0
 4504 6098 00000000 		subs.w.sx	%s59,0,%s57
 4504      B9003B5A 
 4505              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 4506              		.loc	1 879 0
 4507 60a0 38000000 		dldl.sx	%s57,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 4507      8000390B 
 4508 60a8 00000000 		adds.w.sx	%s54,1,%s57
 4508      B901364A 
 4509 60b0 08000000 		dldl.sx	%s52,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 4509      8000340B 
 4510 60b8 00000000 		or	%s57,0,%s52
 4510      B4003945 
 4511 60c0 00000000 		or	%s57,0,%s57
 4511      B9003945 
 4512 60c8 D8FEFFFF 		st	%s57,-296(,%fp)	# spill 
 4512      89003911 
 4513 60d0 00000000 		dldl.sx	%s48,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 4513      8000300B 
 4514 60d8 0C000000 		dldl.sx	%s57,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 4514      8000390B 
 4515 60e0 B0FEFFFF 		st	%s48,-336(,%fp)	# spill 
 4515      89003011 
 4516 60e8 00000000 		or	%s57,0,%s57
 4516      B9003945 
 4517 60f0 A0FEFFFF 		st	%s57,-352(,%fp)	# spill 
 4517      89003911 
 4518 60f8 10000000 		dldl.sx	%s57,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 4518      8000390B 
 4519 6100 00000000 		or	%s57,0,%s57
 4519      B9003945 
 4520 6108 A8FEFFFF 		st	%s57,-344(,%fp)	# spill 
 4520      89003911 
 4521 6110 3C000000 		dldl.sx	%s57,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 4521      8000390B 
 4522 6118 00000000 		or	%s57,0,%s57
 4522      B9003945 
 4523              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4524              		.loc	1 856 0
 4525 6120 00000000 		muls.l	%s51,4,%s57
 4525      B904336E 
 4526              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 4527              		.loc	1 879 0
 4528 6128 34000000 		dldl.sx	%s57,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 4528      8000390B 
 4529 6130 F0FEFFFF 		st	%s51,-272(,%fp)	# spill 
 4529      89003311 
 4530 6138 00000000 		or	%s57,0,%s57
 4530      B9003945 
 4531 6140 2C000000 		dldl.sx	%s51,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 4531      8000330B 
 4532 6148 00000000 		or	%s51,0,%s51
 4532      B3003345 
 4533              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                       const int ih = oh * SH - PH + kh * (p->dh + 1);
 4534              		.loc	1 874 0
 4535 6150 00000000 		muls.l	%s51,4,%s51
 4535      B304336E 
 4536              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****                         * ((float*)src_m)[src_off];
 4537              		.loc	1 879 0
 4538 6158 14000000 		dldl.sx	%s50,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 4538      8000320B 
 4539 6160 C8FEFFFF 		st	%s51,-312(,%fp)	# spill 
 4539      89003311 
 4540 6168 00000000 		or	%s51,0,%s50
 4540      B2003345 
 4541 6170 00000000 		or	%s51,0,%s51
 4541      B3003345 
 4542 6178 E0FEFFFF 		st	%s51,-288(,%fp)	# spill 
 4542      89003311 
 4543 6180 18000000 		dldl.sx	%s51,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 4543      8000330B 
 4544 6188 00000000 		or	%s39,0,%s51
 4544      B3002745 
 4545 6190 B8FEFFFF 		st	%s39,-328(,%fp)	# spill 
 4545      89002711 
 4546 6198 1C000000 		dldl.sx	%s0,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 4546      8000000B 
 4547 61a0 00000000 		or	%s38,0,%s0
 4547      80002645 
 4548 61a8 C0FEFFFF 		st	%s38,-320(,%fp)	# spill 
 4548      89002611 
 4549              	# line 855
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4550              		.loc	1 855 0
 4551 61b0 00000000 		adds.w.sx	%s61,-1,%s47
 4551      AF7F3D4A 
 4552 61b8 00000000 		adds.w.sx	%s60,-1,%s46
 4552      AE7F3C4A 
 4553              	# line 856
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               int oh_beg, oh_end;
 4554              		.loc	1 856 0
 4555 61c0 00000000 		adds.w.sx	%s26,-1,%s44
 4555      AC7F1A4A 
 4556 61c8 00000000 		adds.w.sx	%s27,-1,%s43
 4556      AB7F1B4A 
 4557 61d0 00000000 		muls.l	%s28,-4,%s57
 4557      B97C1C6E 
 4558 61d8 B8FCFFFF 		br.l	.L5.72
 4558      00000F18 
 4559              	.L5.1:
 4560              	# line 852
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4561              		.loc	1 852 0
 4562 61e0 00000000 		ldl.sx	%s41,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 4562      80002903 
 4563 61e8 C0FCFFFF 		brlt.w	0,%s41,.L5.87
 4563      A9008218 
 4564 61f0 D0F2FFFF 		br.l	.L5.69
 4564      00000F18 
 4565              	.L5.88:
 4566 61f8 00000000 		or	%s0,0,%s26
 4566      9A000045 
 4567 6200 00000000 		or	%s1,0,%s22
 4567      96000145 
 4568 6208 00000000 		or	%s2,0,%s25
 4568      99000245 
 4569 6210 00000000 		or	%s3,0,%s23
 4569      97000345 
 4570 6218 00000000 		or	%s4,0,%s24
 4570      98000445 
 4571 6220 C0FFFFFF 		br.l	.L5.1
 4571      00000F18 
 4572              	.L5.89:
 4573              	# line 837
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4574              		.loc	1 837 0
 4575 6228 00000000 		adds.w.sx	%s63,1,%s63
 4575      BF013F4A 
 4576 6230 00000000 		adds.l	%s60,%s61,%s60
 4576      BCBD3C59 
 4577 6238 D8020000 		brgt.w	0,%s63,.L5.90
 4577      BF008118 
 4578 6240 B8FFFFFF 		br.l	.L5.88
 4578      00000F18 
 4579              	.L5.91:
 4580 6248 00000000 		or	%s63,0,%s6
 4580      86003F45 
 4581 6250 00000000 		or	%s61,0,%s7
 4581      87003D45 
 4582 6258 00000000 		or	%s60,0,%s21
 4582      95003C45 
 4583 6260 00000000 		or	%s20,0,%s5
 4583      85001445 
 4584 6268 C0FFFFFF 		br.l	.L5.89
 4584      00000F18 
 4585              	.L5.92:
 4586              	# line 838
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 4587              		.loc	1 838 0
 4588 6270 00000000 		adds.w.sx	%s63,1,%s63
 4588      BF013F4A 
 4589 6278 00000000 		adds.w.sx	%s62,1,%s62
 4589      BE013E4A 
 4590 6280 20020000 		brgt.w	0,%s63,.L5.93
 4590      BF008118 
 4591 6288 C0FFFFFF 		br.l	.L5.91
 4591      00000F18 
 4592              	.L5.94:
 4593 6290 00000000 		or	%s63,0,%s3
 4593      83003F45 
 4594 6298 00000000 		or	%s62,0,%s4
 4594      84003E45 
 4595 62a0 D0FFFFFF 		br.l	.L5.92
 4595      00000F18 
 4596              	.L5.95:
 4597              	# line 839
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 4598              		.loc	1 839 0
 4599 62a8 00000000 		adds.w.sx	%s63,1,%s63
 4599      BF013F4A 
 4600 62b0 00000000 		adds.w.sx	%s61,1,%s61
 4600      BD013D4A 
 4601 62b8 98010000 		brgt.w	0,%s63,.L5.96
 4601      BF008118 
 4602 62c0 D0FFFFFF 		br.l	.L5.94
 4602      00000F18 
 4603              	.L5.97:
 4604 62c8 00000000 		or	%s63,0,%s1
 4604      81003F45 
 4605 62d0 00000000 		or	%s61,0,%s2
 4605      82003D45 
 4606 62d8 D0FFFFFF 		br.l	.L5.95
 4606      00000F18 
 4607              	.L5.98:
 4608 62e0 38010000 		br.l	.L5.99
 4608      00000F18 
 4609              	.L5.100:
 4610              	# line 840
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4611              		.loc	1 840 0
 4612 62e8 00000000 		adds.w.sx	%s63,1,%s63
 4612      BF013F4A 
 4613 62f0 00000000 		adds.w.sx	%s62,1,%s62
 4613      BE013E4A 
 4614 62f8 E8FFFFFF 		brgt.w	0,%s63,.L5.98
 4614      BF008118 
 4615 6300 C8FFFFFF 		br.l	.L5.97
 4615      00000F18 
 4616              	.L5.101:
 4617 6308 00000000 		or	%s62,0,%s58
 4617      BA003E45 
 4618 6310 00000000 		or	%s63,0,%s57
 4618      B9003F45 
 4619 6318 D0FFFFFF 		br.l	.L5.100
 4619      00000F18 
 4620              	.L5.3:
 4621              	# line 844
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 4622              		.loc	1 844 0
 4623 6320 00000000 		or	%s63,0,(0)1
 4623      00003F45 
 4624 6328 00000000 		lvl	%s62
 4624      00BE00BF 
 4625 6330 00000039 		vbrdu	%v57,%s63
 4625      00BF808C 
 4626 6338 00000000 		or	%s63,0,%s61
 4626      BD003F45 
 4627 6340 00000039 		vstu.nc	%v57,4,%s63
 4627      BF040092 
 4628              	# line 841
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 4629              		.loc	1 841 0
 4630 6348 00000000 		adds.l	%s61,%s61,%s60
 4630      BCBD3D59 
 4631 6350 00000000 		subs.w.sx	%s59,%s59,%s62
 4631      BEBB3B5A 
 4632 6358 B0FFFFFF 		brge.w	0,%s59,.L5.101
 4632      BB008518 
 4633 6360 10E0FFFF 		br.l	.L5.2
 4633      00000F18 
 4634              	.L5.102:
 4635              	# line 844
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 4636              		.loc	1 844 0
 4637 6368 00000000 		divu.l	%s54,%s56,%s55
 4637      B7B8366F 
 4638 6370 00000000 		or	%s58,0,%s62
 4638      BE003A45 
 4639 6378 00000000 		or	%s57,0,%s63
 4639      BF003945 
 4640 6380 00000000 		addu.l	%s54,%s54,%s53
 4640      B5B63648 
 4641 6388 00000000 		mulu.l	%s54,%s54,%s52
 4641      B4B63649 
 4642 6390 00000000 		divu.l	%s54,%s54,%s55
 4642      B7B6366F 
 4643 6398 00000000 		addu.l	%s54,%s54,%s51
 4643      B3B63648 
 4644 63a0 00000000 		mulu.l	%s54,%s54,%s50
 4644      B2B63649 
 4645 63a8 00000000 		or	%s63,0,%s62
 4645      BE003F45 
 4646 63b0 00000000 		addu.l	%s63,%s54,%s63
 4646      BFB63F48 
 4647 63b8 00000000 		mulu.l	%s63,%s63,%s49
 4647      B1BF3F49 
 4648 63c0 00000000 		or	%s63,0,%s63
 4648      BF003F45 
 4649              	# line 841
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 4650              		.loc	1 841 0
 4651 63c8 00000000 		muls.l	%s63,4,%s63
 4651      BF043F6E 
 4652 63d0 00000000 		adds.l	%s63,%s63,%s48
 4652      B0BF3F59 
 4653 63d8 00000000 		subs.w.sx	%s54,0,%s47
 4653      AF00365A 
 4654 63e0 00000000 		smvl	%s46
 4654      00002E2E 
 4655 63e8 80000000 		mins.w.sx	%s62,%s54,%s46
 4655      AEB63E78 
 4656 63f0 00000000 		or	%s59,0,%s54
 4656      B6003B45 
 4657 63f8 00000000 		or	%s61,0,%s63
 4657      BF003D45 
 4658 6400 00000000 		or	%s63,0,%s62
 4658      BE003F45 
 4659 6408 00000000 		muls.l	%s60,4,%s63
 4659      BF043C6E 
 4660 6410 10FFFFFF 		br.l	.L5.3
 4660      00000F18 
 4661              	.L5.99:
 4662 6418 50FFFFFF 		brlt.w	0,%s18,.L5.102
 4662      92008218 
 4663 6420 C8FEFFFF 		br.l	.L5.100
 4663      00000F18 
 4664              	.L5.103:
 4665 6428 00000000 		or	%s51,0,%s61
 4665      BD003345 
 4666 6430 00000000 		or	%s1,0,%s63
 4666      BF000145 
 4667 6438 00000000 		or	%s63,0,%s45
 4667      AD003F45 
 4668 6440 00000000 		or	%s2,0,%s61
 4668      BD000245 
 4669 6448 D0FFFFFF 		br.l	.L5.99
 4669      00000F18 
 4670              	.L5.96:
 4671              	# line 840
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4672              		.loc	1 840 0
 4673 6450 00000000 		or	%s62,0,(0)1
 4673      00003E45 
 4674 6458 D0FFFFFF 		brlt.w	0,%s19,.L5.103
 4674      93008218 
 4675 6460 48FEFFFF 		br.l	.L5.95
 4675      00000F18 
 4676              	.L5.104:
 4677              	# line 839
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 4678              		.loc	1 839 0
 4679 6468 00000000 		divs.w.sx	%s60,%s44,%s43
 4679      ABAC3C7B 
 4680 6470 00000000 		or	%s3,0,%s63
 4680      BF000345 
 4681 6478 00000000 		or	%s4,0,%s62
 4681      BE000445 
 4682 6480 00000000 		subs.w.sx	%s60,0,%s60
 4682      BC003C5A 
 4683 6488 00000000 		or	%s63,0,%s60
 4683      BC003F45 
 4684 6490 00000000 		or	%s53,0,%s62
 4684      BE003545 
 4685 6498 B8FFFFFF 		br.l	.L5.96
 4685      00000F18 
 4686              	.L5.93:
 4687 64a0 00000000 		or	%s61,0,(0)1
 4687      00003D45 
 4688 64a8 C0FFFFFF 		brlt.w	0,%s20,.L5.104
 4688      94008218 
 4689 64b0 C0FDFFFF 		br.l	.L5.92
 4689      00000F18 
 4690              	.L5.105:
 4691 64b8 00000000 		divs.w.sx	%s59,%s44,%s43
 4691      ABAC3B7B 
 4692              	# line 838
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 4693              		.loc	1 838 0
 4694 64c0 00000000 		divs.w.sx	%s58,%s42,%s43
 4694      ABAA3A7B 
 4695 64c8 00000000 		or	%s5,0,%s20
 4695      94000545 
 4696 64d0 00000000 		or	%s6,0,%s63
 4696      BF000645 
 4697 64d8 00000000 		or	%s7,0,%s61
 4697      BD000745 
 4698 64e0 00000000 		or	%s21,0,%s60
 4698      BC001545 
 4699 64e8 00000000 		or	%s20,0,%s59
 4699      BB001445 
 4700 64f0 00000000 		subs.w.sx	%s58,0,%s58
 4700      BA003A5A 
 4701 64f8 00000000 		or	%s63,0,%s58
 4701      BA003F45 
 4702 6500 00000000 		or	%s56,0,%s60
 4702      BC003845 
 4703 6508 98FFFFFF 		br.l	.L5.93
 4703      00000F18 
 4704              	.L5.90:
 4705 6510 00000000 		or	%s62,0,(0)1
 4705      00003E45 
 4706 6518 A0FFFFFF 		brlt.w	0,%s20,.L5.105
 4706      94008218 
 4707 6520 08FDFFFF 		br.l	.L5.89
 4707      00000F18 
 4708              	.L5.0:
 4709 6528 14000000 		dldl.sx	%s42,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 4709      80002A0B 
 4710              	# line 837
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4711              		.loc	1 837 0
 4712 6530 00000000 		or	%s60,0,(0)1
 4712      00003C45 
 4713 6538 00000000 		or	%s22,0,%s1
 4713      81001645 
 4714              	# line 838
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 4715              		.loc	1 838 0
 4716 6540 00000000 		divs.w.sx	%s20,%s42,%s43
 4716      ABAA147B 
 4717              	# line 837
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4718              		.loc	1 837 0
 4719 6548 00000000 		subs.w.sx	%s62,0,%s43
 4719      AB003E5A 
 4720 6550 00000000 		or	%s23,0,%s3
 4720      83001745 
 4721 6558 00000000 		or	%s63,0,%s62
 4721      BE003F45 
 4722              	# line 839
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 4723              		.loc	1 839 0
 4724 6560 08000000 		dldl.sx	%s44,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 4724      80002C0B 
 4725 6568 00000000 		or	%s24,0,%s4
 4725      84001845 
 4726              	# line 840
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4727              		.loc	1 840 0
 4728 6570 20000000 		dldl.sx	%s19,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 4728      8000130B 
 4729 6578 00000000 		or	%s25,0,%s2
 4729      82001945 
 4730 6580 00000000 		or	%s26,0,%s0
 4730      80001A45 
 4731 6588 00000000 		subs.w.sx	%s45,0,%s19
 4731      93002D5A 
 4732              	# line 841
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 4733              		.loc	1 841 0
 4734 6590 24000000 		dldl.sx	%s18,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 4734      8000120B 
 4735 6598 00000000 		or	%s49,0,%s18
 4735      92003145 
 4736 65a0 00000000 		subs.w.sx	%s47,0,%s18
 4736      92002F5A 
 4737              	# line 844
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv5.cpp ****             }
 4738              		.loc	1 844 0
 4739 65a8 A8010000 		dld	%s48,424(,%s2)	# *(s$114).data_
 4739      82003009 
 4740 65b0 14000000 		dldl.sx	%s62,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 4740      80003E0B 
 4741 65b8 00000000 		or	%s62,0,%s62
 4741      BE003E45 
 4742 65c0 00000000 		or	%s61,0,%s62
 4742      BE003D45 
 4743 65c8 00000000 		dldl.sx	%s62,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 4743      80003E0B 
 4744 65d0 00000000 		or	%s55,0,%s62
 4744      BE003745 
 4745 65d8 08000000 		dldl.sx	%s62,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 4745      80003E0B 
 4746 65e0 00000000 		or	%s52,0,%s62
 4746      BE003445 
 4747 65e8 20000000 		dldl.sx	%s0,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 4747      8000000B 
 4748 65f0 00000000 		or	%s50,0,%s0
 4748      80003245 
 4749 65f8 18FFFFFF 		br.l	.L5.90
 4749      00000F18 
 4750              		.cfi_endproc
 4751              		.set	.L.6.2auto_size,	0xfffffffffffffa40	# 1472 Bytes
 4753              	# ============ End  conv::refconv_5_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 4754              		.weak div_floor(int, int)
