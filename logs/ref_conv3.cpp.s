   1              		.ident "nc++ 1.5.2 (Build 11:19:31 Oct  2 2018)"
   2              		.file "ref_conv3.cpp"
   3              		.file 1 "/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp"
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
  99              	# ============ Begin  _INTERNAL_13_ref_conv3_cpp_bbff7ae7::conv::chk(bool, char const*, char const*, int) ============
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
 131              	# line 30
   1:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /*******************************************************************************
   2:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * Copyright 2017 NEC Laboratories America
   3:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** *
   4:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * Licensed under the Apache License, Version 2.0 (the "License");
   5:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * you may not use this file except in compliance with the License.
   6:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * You may obtain a copy of the License at
   7:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** *
   8:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** *     http://www.apache.org/licenses/LICENSE-2.0
   9:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** *
  10:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * Unless required by applicable law or agreed to in writing, software
  11:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * distributed under the License is distributed on an "AS IS" BASIS,
  12:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  13:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * See the License for the specific language governing permissions and
  14:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** * limitations under the License.
  15:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** *******************************************************************************/
  16:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  17:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** \file
  18:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * precalc inner kernel loop limits to avoid conditionals */
  19:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #include "conv/conv.hpp"
  20:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #include "idiv.hpp"
  21:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  22:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** namespace conv {
  23:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  24:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** // BWD + dilate is not fast for these loops (and mkl-dnn doesn't allow it yet)
  25:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** extern void refconv_2_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  26:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  27:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** extern void refconv_4_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
  28:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m);
  29:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  30:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static void chk( bool cond, char const* msg, char const* file, int const lineno ){
 132              		.loc	1 30 0
 134              	_INTERNAL_13_ref_conv3_cpp_bbff7ae7::conv::chk(bool, char const*, char const*, int):
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
 162              	# line 32
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
  32:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 163              		.loc	1 32 0
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
 173              	# line 31
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if (!cond){ printf("@@@ error: %s : [%s:%d]\n", msg, file, lineno); exit(1); }
 174              		.loc	1 31 0
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
 195              	# ============ End  _INTERNAL_13_ref_conv3_cpp_bbff7ae7::conv::chk(bool, char const*, char const*, int) ============
 196              	# ============ Begin  _INTERNAL_13_ref_conv3_cpp_bbff7ae7::conv::gcd(int, int) ============
 197 0258 00000000 		.balign 16
 197      00000000 
 198              	# line 79
  33:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static bool trivial( int const verb, bool const cond, char const* msg,
  34:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                      char const* file, int const lineno ){
  35:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if (verb > verbose && cond){
  36:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         printf("@@@ trivial: %s : [%s:%d]\n", msg, file, lineno); fflush(stdout);
  37:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
  38:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  39:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     return cond;
  40:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
  41:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** //#define MUST( COND )
  42:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define MUST( COND )    chk(    (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  43:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define PRINTF(...)     do{ printf(__VA_ARGS__); fflush(stdout);}while(0)
  44:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define TRIVIAL( COND ) COND
  45:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** //#define TRIVIAL( COND ) trivial(1, (COND), #COND, __PRETTY_FUNCTION__, __LINE__)
  46:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  47:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if defined(NDEBUG)
  48:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define DPRINTF(...)
  49:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define DMUST(...)
  50:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
  51:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define DPRINTF(...)  do{printf(__VA_ARGS__); fflush(stdout);}while(0)
  52:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define DMUST(...)   MUST(__VA_ARGS__)
  53:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
  54:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  55:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define G  p->g
  56:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define MB p->mb
  57:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define IC p->ic
  58:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define OC p->oc
  59:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  60:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define KH p->kh
  61:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define IH p->ih
  62:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define OH p->oh
  63:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define SH p->sh
  64:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define PH p->ph
  65:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  66:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define KW p->kw
  67:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define IW p->iw
  68:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define OW p->ow
  69:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define SW p->sw
  70:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #define PW p->pw
  71:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  72:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** //const int DH = p->dh + 1;
  73:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** //const int DW = p->dw + 1;
  74:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  75:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** //----------------------------
  76:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  77:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** greatest common denominator, a,b > 0 */
  78:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static int gcd(int a, int b)
  79:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** {
 199              		.loc	1 79 0
 201              	_INTERNAL_13_ref_conv3_cpp_bbff7ae7::conv::gcd(int, int):
 202              		.cfi_startproc
 203 0260 00000000 		st	%fp,0x0(,%sp)
 203      8B000911 
 204              		.cfi_def_cfa_offset	0
 205              		.cfi_offset	9,0
 206 0268 08000000 		st	%lr,0x8(,%sp)
 206      8B000A11 
 207 0270 18000000 		st	%got,0x18(,%sp)
 207      8B000F11 
 208 0278 20000000 		st	%plt,0x20(,%sp)
 208      8B001011 
 209 0280 00000000 		or	%fp,0,%sp
 209      8B000945 
 210              		.cfi_def_cfa_register	9
 211 0288 30000000 		st	%s18,48(,%fp)
 211      89001211 
 212 0290 00FFFFFF 		lea	%s13,.L.3.2auto_size&0xffffffff
 212      00000D06 
 213 0298 00000000 		and	%s13,%s13,(32)0
 213      608D0D44 
 214 02a0 FFFFFFFF 		lea.sl	%sp,.L.3.2auto_size>>32(%fp,%s13)
 214      8D898B06 
 215 02a8 48000000 		brge.l.t	%sp,%sl,.L2.EoP
 215      888B3518 
 216 02b0 18000000 		ld	%s61,0x18(,%tp)
 216      8E003D01 
 217 02b8 00000000 		or	%s62,0,%s0
 217      80003E45 
 218 02c0 3B010000 		lea	%s63,0x13b
 218      00003F06 
 219 02c8 00000000 		shm.l	%s63,0x0(%s61)
 219      BD033F31 
 220 02d0 08000000 		shm.l	%sl,0x8(%s61)
 220      BD030831 
 221 02d8 10000000 		shm.l	%sp,0x10(%s61)
 221      BD030B31 
 222 02e0 00000000 		monc
 222      0000003F 
 223 02e8 00000000 		or	%s0,0,%s62
 223      BE000045 
 224              	.L2.EoP:
 225              	# End of prologue codes
 226 02f0 00000000 		or	%s18,0,%s0
 226      80001245 
 227 02f8 00000000 		or	%s63,0,%s1
 227      81003F45 
 228 0300 A8000000 		br.l	.L2.0
 228      00000F18 
 229              	.L2.1:
 230              	# line 85
  80:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (;;)
  81:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     {
  82:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         if (a == 0) return b;
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         b %= a;
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         if (b == 0) return a;
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         a %= b;
 231              		.loc	1 85 0
 232 0308 00000000 		divs.w.sx	%s62,%s18,%s63
 232      BF923E7B 
 233 0310 00000000 		muls.w.sx	%s62,%s63,%s62
 233      BEBF3E4B 
 234 0318 00000000 		subs.w.sx	%s18,%s18,%s62
 234      BE92125A 
 235 0320 88000000 		br.l	.L2.0
 235      00000F18 
 236              	.L2.2:
 237 0328 00000000 		or	%s0,0,%s18
 237      92000045 
 238 0330 30000000 		br.l	.L2.3
 238      00000F18 
 239              	.L2.4:
 240              	# line 83
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         if (b == 0) return a;
 241              		.loc	1 83 0
 242 0338 00000000 		divs.w.sx	%s62,%s63,%s18
 242      92BF3E7B 
 243 0340 00000000 		muls.w.sx	%s62,%s18,%s62
 243      BE923E4B 
 244 0348 00000000 		subs.w.sx	%s63,%s63,%s62
 244      BEBF3F5A 
 245 0350 D8FFFFFF 		breq.w	0,%s63,.L2.2
 245      BF008418 
 246 0358 B0FFFFFF 		br.l	.L2.1
 246      00000F18 
 247              	.L2.3:
 248              	# line 84
  84:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         a %= b;
 249              		.loc	1 84 0
 250              	# Start of epilogue codes
 251 0360 30000000 		ld	%s18,48(,%fp)
 251      89001201 
 252 0368 00000000 		or	%sp,0,%fp
 252      89000B45 
 253              		.cfi_def_cfa	11,8
 254 0370 18000000 		ld	%got,0x18(,%sp)
 254      8B000F01 
 255 0378 20000000 		ld	%plt,0x20(,%sp)
 255      8B001001 
 256 0380 08000000 		ld	%lr,0x8(,%sp)
 256      8B000A01 
 257 0388 00000000 		ld	%fp,0x0(,%sp)
 257      8B000901 
 258 0390 00000000 		b.l	(,%lr)
 258      8A000F19 
 259              	.L2.5:
 260 0398 00000000 		or	%s0,0,%s63
 260      BF000045 
 261 03a0 C0FFFFFF 		br.l	.L2.3
 261      00000F18 
 262              	.L2.0:
 263 03a8 F0FFFFFF 		breq.w	0,%s18,.L2.5
 263      92008418 
 264 03b0 88FFFFFF 		br.l	.L2.4
 264      00000F18 
 265              		.cfi_endproc
 266              		.set	.L.3.2auto_size,	0xffffffffffffff00	# 256 Bytes
 268              	# ============ End  _INTERNAL_13_ref_conv3_cpp_bbff7ae7::conv::gcd(int, int) ============
 269              	# ============ Begin  conv::refconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 270              		.data
 271              		.balign 16
 274              	.LP._ZN4conv13refconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 275 0000 00000000 		.long	__vla_dealloc_eh
 275      00000000 
 276 0008 0000     		.zero	2
 277 000a FFFF     		.short	65535
 278 000c 04       		.byte	4
 279 000d 000000   		.zero	3
 280 0010 00000000 		.long	__vla_dealloc_eh
 280      00000000 
 281 0018 0100     		.short	1
 282 001a 0000     		.zero	2
 283 001c 04       		.byte	4
 284 001d 000000   		.zero	3
 285 0020 00000000 		.long	__vla_dealloc_eh
 285      00000000 
 286 0028 0200     		.short	2
 287 002a 0100     		.short	1
 288 002c 04       		.byte	4
 289 002d 000000   		.zero	3
 290 0030 00000000 		.long	__vla_dealloc_eh
 290      00000000 
 291 0038 0300     		.short	3
 292 003a 0200     		.short	2
 293 003c 04       		.byte	4
 294 003d 000000   		.zero	3
 295              		.balign 1
 298              	.LP.__13_ref_conv3_cpp_bbff7ae7.0.__unnamed.0:
 299 0040 76       		.byte	118
 300 0041 6F       		.byte	111
 301 0042 69       		.byte	105
 302 0043 64       		.byte	100
 303 0044 20       		.byte	32
 304 0045 63       		.byte	99
 305 0046 6F       		.byte	111
 306 0047 6E       		.byte	110
 307 0048 76       		.byte	118
 308 0049 3A       		.byte	58
 309 004a 3A       		.byte	58
 310 004b 72       		.byte	114
 311 004c 65       		.byte	101
 312 004d 66       		.byte	102
 313 004e 63       		.byte	99
 314 004f 6F       		.byte	111
 315 0050 6E       		.byte	110
 316 0051 76       		.byte	118
 317 0052 5F       		.byte	95
 318 0053 33       		.byte	51
 319 0054 5F       		.byte	95
 320 0055 66       		.byte	102
 321 0056 77       		.byte	119
 322 0057 64       		.byte	100
 323 0058 28       		.byte	40
 324 0059 63       		.byte	99
 325 005a 6F       		.byte	111
 326 005b 6E       		.byte	110
 327 005c 73       		.byte	115
 328 005d 74       		.byte	116
 329 005e 20       		.byte	32
 330 005f 63       		.byte	99
 331 0060 6F       		.byte	111
 332 0061 6E       		.byte	110
 333 0062 76       		.byte	118
 334 0063 3A       		.byte	58
 335 0064 3A       		.byte	58
 336 0065 70       		.byte	112
 337 0066 72       		.byte	114
 338 0067 62       		.byte	98
 339 0068 5F       		.byte	95
 340 0069 74       		.byte	116
 341 006a 20       		.byte	32
 342 006b 2A       		.byte	42
 343 006c 2C       		.byte	44
 344 006d 20       		.byte	32
 345 006e 64       		.byte	100
 346 006f 6E       		.byte	110
 347 0070 6E       		.byte	110
 348 0071 5F       		.byte	95
 349 0072 6D       		.byte	109
 350 0073 65       		.byte	101
 351 0074 6D       		.byte	109
 352 0075 5F       		.byte	95
 353 0076 74       		.byte	116
 354 0077 20       		.byte	32
 355 0078 26       		.byte	38
 356 0079 2C       		.byte	44
 357 007a 20       		.byte	32
 358 007b 64       		.byte	100
 359 007c 6E       		.byte	110
 360 007d 6E       		.byte	110
 361 007e 5F       		.byte	95
 362 007f 6D       		.byte	109
 363 0080 65       		.byte	101
 364 0081 6D       		.byte	109
 365 0082 5F       		.byte	95
 366 0083 74       		.byte	116
 367 0084 20       		.byte	32
 368 0085 26       		.byte	38
 369 0086 2C       		.byte	44
 370 0087 20       		.byte	32
 371 0088 64       		.byte	100
 372 0089 6E       		.byte	110
 373 008a 6E       		.byte	110
 374 008b 5F       		.byte	95
 375 008c 6D       		.byte	109
 376 008d 65       		.byte	101
 377 008e 6D       		.byte	109
 378 008f 5F       		.byte	95
 379 0090 74       		.byte	116
 380 0091 20       		.byte	32
 381 0092 26       		.byte	38
 382 0093 2C       		.byte	44
 383 0094 20       		.byte	32
 384 0095 64       		.byte	100
 385 0096 6E       		.byte	110
 386 0097 6E       		.byte	110
 387 0098 5F       		.byte	95
 388 0099 6D       		.byte	109
 389 009a 65       		.byte	101
 390 009b 6D       		.byte	109
 391 009c 5F       		.byte	95
 392 009d 74       		.byte	116
 393 009e 20       		.byte	32
 394 009f 26       		.byte	38
 395 00a0 29       		.byte	41
 396 00a1 00       		.zero	1
 397              		.section .rodata
 398 0019 00000000 		.balign 16
 398      000000
 400              	.LP.__string.1:
 401 0020 70       		.byte	112
 402 0021 2D       		.byte	45
 403 0022 3E       		.byte	62
 404 0023 6B       		.byte	107
 405 0024 68       		.byte	104
 406 0025 20       		.byte	32
 407 0026 3E       		.byte	62
 408 0027 20       		.byte	32
 409 0028 30       		.byte	48
 410 0029 20       		.byte	32
 411 002a 26       		.byte	38
 412 002b 26       		.byte	38
 413 002c 20       		.byte	32
 414 002d 4B       		.byte	75
 415 002e 57       		.byte	87
 416 002f 20       		.byte	32
 417 0030 3E       		.byte	62
 418 0031 20       		.byte	32
 419 0032 30       		.byte	48
 420 0033 00       		.zero	1
 421 0034 00000000 		.balign 8
 423              	.LP.__string.2:
 424 0038 40       		.byte	64
 425 0039 40       		.byte	64
 426 003a 40       		.byte	64
 427 003b 20       		.byte	32
 428 003c 65       		.byte	101
 429 003d 72       		.byte	114
 430 003e 72       		.byte	114
 431 003f 6F       		.byte	111
 432 0040 72       		.byte	114
 433 0041 3A       		.byte	58
 434 0042 20       		.byte	32
 435 0043 25       		.byte	37
 436 0044 73       		.byte	115
 437 0045 20       		.byte	32
 438 0046 3A       		.byte	58
 439 0047 20       		.byte	32
 440 0048 5B       		.byte	91
 441 0049 25       		.byte	37
 442 004a 73       		.byte	115
 443 004b 3A       		.byte	58
 444 004c 25       		.byte	37
 445 004d 64       		.byte	100
 446 004e 5D       		.byte	93
 447 004f 0A       		.byte	10
 448 0050 00       		.zero	1
 449 0051 00000000 		.balign 8
 449      000000
 451              	.LP.__string.3:
 452 0058 70       		.byte	112
 453 0059 2D       		.byte	45
 454 005a 3E       		.byte	62
 455 005b 64       		.byte	100
 456 005c 68       		.byte	104
 457 005d 20       		.byte	32
 458 005e 3E       		.byte	62
 459 005f 3D       		.byte	61
 460 0060 20       		.byte	32
 461 0061 30       		.byte	48
 462 0062 20       		.byte	32
 463 0063 26       		.byte	38
 464 0064 26       		.byte	38
 465 0065 20       		.byte	32
 466 0066 70       		.byte	112
 467 0067 2D       		.byte	45
 468 0068 3E       		.byte	62
 469 0069 64       		.byte	100
 470 006a 77       		.byte	119
 471 006b 20       		.byte	32
 472 006c 3E       		.byte	62
 473 006d 3D       		.byte	61
 474 006e 20       		.byte	32
 475 006f 30       		.byte	48
 476 0070 00       		.zero	1
 477 0071 00000000 		.balign 8
 477      000000
 479              	.LP.__string.4:
 480 0078 40       		.byte	64
 481 0079 40       		.byte	64
 482 007a 40       		.byte	64
 483 007b 20       		.byte	32
 484 007c 65       		.byte	101
 485 007d 72       		.byte	114
 486 007e 72       		.byte	114
 487 007f 6F       		.byte	111
 488 0080 72       		.byte	114
 489 0081 3A       		.byte	58
 490 0082 20       		.byte	32
 491 0083 25       		.byte	37
 492 0084 73       		.byte	115
 493 0085 20       		.byte	32
 494 0086 3A       		.byte	58
 495 0087 20       		.byte	32
 496 0088 5B       		.byte	91
 497 0089 25       		.byte	37
 498 008a 73       		.byte	115
 499 008b 3A       		.byte	58
 500 008c 25       		.byte	37
 501 008d 64       		.byte	100
 502 008e 5D       		.byte	93
 503 008f 0A       		.byte	10
 504 0090 00       		.zero	1
 505 0091 00000000 		.balign 8
 505      000000
 507              	.LP.__string.5:
 508 0098 53       		.byte	83
 509 0099 48       		.byte	72
 510 009a 20       		.byte	32
 511 009b 3E       		.byte	62
 512 009c 3D       		.byte	61
 513 009d 20       		.byte	32
 514 009e 30       		.byte	48
 515 009f 20       		.byte	32
 516 00a0 26       		.byte	38
 517 00a1 26       		.byte	38
 518 00a2 20       		.byte	32
 519 00a3 53       		.byte	83
 520 00a4 57       		.byte	87
 521 00a5 20       		.byte	32
 522 00a6 3E       		.byte	62
 523 00a7 3D       		.byte	61
 524 00a8 20       		.byte	32
 525 00a9 30       		.byte	48
 526 00aa 00       		.zero	1
 527 00ab 00000000 		.balign 8
 527      00
 529              	.LP.__string.6:
 530 00b0 40       		.byte	64
 531 00b1 40       		.byte	64
 532 00b2 40       		.byte	64
 533 00b3 20       		.byte	32
 534 00b4 65       		.byte	101
 535 00b5 72       		.byte	114
 536 00b6 72       		.byte	114
 537 00b7 6F       		.byte	111
 538 00b8 72       		.byte	114
 539 00b9 3A       		.byte	58
 540 00ba 20       		.byte	32
 541 00bb 25       		.byte	37
 542 00bc 73       		.byte	115
 543 00bd 20       		.byte	32
 544 00be 3A       		.byte	58
 545 00bf 20       		.byte	32
 546 00c0 5B       		.byte	91
 547 00c1 25       		.byte	37
 548 00c2 73       		.byte	115
 549 00c3 3A       		.byte	58
 550 00c4 25       		.byte	37
 551 00c5 64       		.byte	100
 552 00c6 5D       		.byte	93
 553 00c7 0A       		.byte	10
 554 00c8 00       		.zero	1
 555              		.text
 556 03b8 00000000 		.balign 16
 556      00000000 
 557              	# line 237
  86:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
  87:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
  88:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  89:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** lowest common multiple, a,b > 0 */
  90:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static int lcm(int a, int b)
  91:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** {
  92:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     int temp = gcd(a, b);
  93:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  94:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     return temp ? (a / temp * b) : 0;
  95:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
  96:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
  97:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** Solve for integers j, k and g=gcd(a,b) such that ja + ky = g,
  98:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * where a,b are integer constants.
  99:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * This is a linear equation in integers, and is solved
 100:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * via the extended Euclid algorithm.
 101:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  */
 102:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static void inline extendedEuclid( int& k, int a, int& j, int b, int& g)
 103:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** {
 104:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int x = 1, y = 0;
 105:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int xLast = 0, yLast = 1;
 106:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int q, r, m, n;
 107:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   while (a != 0) 
 108:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   {
 109:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     q = b / a;
 110:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     r = b % a;
 111:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     m = xLast - q * x;
 112:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     n = yLast - q * y;
 113:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     xLast = x; 
 114:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     yLast = y;
 115:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     x = m; 
 116:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     y = n;
 117:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     b = a; 
 118:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     a = r;
 119:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 120:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   g = b;
 121:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   k = xLast;
 122:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   j = yLast;
 123:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 124:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 125:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** hoist `A+iB in range [C,D)` condition out of a loop for i in [imin,imax].
 126:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * When 
 127:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * Original:
 128:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \code
 129:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * for(i=imin; i<imax; ++i){       // original loop
 130:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *   int const ApiB = a + i*b;      // linear fn, ( b>=0 ? )
 131:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *   if( ApiB < c || ApiB > d ) continue;
 132:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *   // Loop Body
 133:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * }
 134:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \endcode
 135:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * Transformed:
 136:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \code
 137:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * int const ibeg, iend;
 138:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * hoist_ApiB_in( ibeg, iend, imin,imax, a,b, c,d );
 139:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * for(i=ibeg; i<iend; ++i){       // original loop
 140:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *   int const ApiB = a + i*b;
 141:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *   // GONE: if( ApiB < c || ApiB > d ) continue;
 142:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *   // Loop Body
 143:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * }
 144:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \endcode
 145:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \pre \c b > 0, (c, d?)
 146:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  */
 147:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static inline void hoist_ApiB_in( int& beg, int& end,
 148:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         const int imin, const int imax,
 149:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         const int a, const int b, const int c, const int d)
 150:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** {
 151:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( b > 0 );
 152:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // int i*B < A    iff    i < (A    )/B
 153:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // int i*B > A    iff    i > (A+B-1)/A
 154:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // A+iB >= c ... iB >= c-A  ... i >= (c-A + B-1 )/B
 155:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 1
 156:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     beg = div_floor( c-a+b-1, b );
 157:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 158:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     beg = c-a + b-1;
 159:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( beg >= 0 ){
 160:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         beg /= b;
 161:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     } else {
 162:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         int const fmul=(-beg + b)/b;
 163:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         RT_ASSERT( beg + fmul*b >= 0 );
 164:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         beg = (beg + fmul*b) / b - fmul;
 165:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 166:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 167:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), beg=%d? f+c-a+b-1=%d\n",
 168:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //        imin,imax, a,b, c,d, beg, f+c-a+b-1);
 169:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( a + (beg-1)*b < c );
 170:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( a + (beg  )*b >= c );
 171:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( beg < imin ) beg = imin;
 172:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 173:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // A+iB < d ... iB < d-A    ... i < (d-A) / B
 174:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 1
 175:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     end = div_floor( d-a+b-1, b );
 176:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 177:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     end = d-a +b-1;
 178:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( end >= 0 ){
 179:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         end /= b;
 180:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     } else {
 181:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         int const fmul=(-end + b)/b;
 182:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         RT_ASSERT( end + fmul*b >= 0 );
 183:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         end = (end + fmul*b) / b - fmul;
 184:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 185:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 186:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //print(0, "i in [%d,%d), lin(a,b)=%d+i*%d in [c,d]=[%d,%d), end=%d? f+d-a=%d\n",
 187:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //        imin,imax, a,b, c,d, end, f+d-a);
 188:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( a + (end-1)*b < d );
 189:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( a + (end  )*b >= d );
 190:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( end > imax ) end = imax;
 191:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 192:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 193:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** Integer \c i so A-iB is <em>just below</em> \c target.
 194:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \pre \c B>0 (unchecked). */
 195:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static inline int AmiB_lt_target( const int a, const int b, const int target)
 196:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** {
 197:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     int ibelow = a-target + b;
 198:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // XXX use idiv.hpp here too
 199:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( ibelow >= 0 ){
 200:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         ibelow /= b;
 201:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //ibelow = div_floor( ibelow, b );
 202:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     } else {
 203:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         int const fmul=(-ibelow + b)/b;
 204:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //RT_ASSERT( ibelow + fmul*b >= 0 );
 205:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //RT_ASSERT( fmul == div_floor( -ibelow, b )+1 );
 206:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         ibelow = (ibelow + fmul                    *b) / b - fmul; // orig
 207:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //ibelow = (ibelow + (div_floor(-ibelow,b)+1)*b) / b - (div_floor(-ibelow,b)+1);
 208:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 209:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //ibelow = div_floor( ibelow, b );
 210:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //ibelow = (ibelow + div_floor(-ibelow,b)* b) / b - div_floor(-ibelow,b);
 211:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 212:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( a - (ibelow-1)*b >= target );
 213:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( a - (ibelow  )*b <  target );
 214:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     return ibelow;
 215:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 216:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** Get range if \c i so A-iB is in [c,d), and then further
 217:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * restrict to range [imin,imax).  Note that \c -B means as \c i
 218:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * increases, we move from \c d-1 downwards to \c c. */
 219:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** static inline void hoist_AmiB_in( int& beg, int& end,
 220:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         const int imin, const int imax,
 221:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         const int a, const int b, const int c, const int d)
 222:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** {
 223:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( b > 0 );
 224:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     beg = AmiB_lt_target( a, b, d );
 225:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //RT_ASSERT( beg == div_floor( a-d+b, b) );
 226:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //beg = div_floor( a-d+b, b); // possibly slower ?? do I have a cmov here? no!
 227:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //beg = div_floor( a-d, b) + 1; // possibly slower ?? do I have a cmov here? no!
 228:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( beg < imin ) beg = imin;
 229:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 230:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     end = AmiB_lt_target( a, b, c );
 231:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //RT_ASSERT( end == div_floor( a-c+b, b) );
 232:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //end = div_floor( a-c+b, b);
 233:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //end = div_floor( a-c, b) + 1;
 234:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( end > imax ) end = imax;
 235:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 236:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** void refconv_3_fwd(const prb_t *p, dnn_mem_t &src_m,
 237:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &bia_m, dnn_mem_t &dst_m) {
 558              		.loc	1 237 0
 559              		.globl	conv::refconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 561              	conv::refconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 562              		.cfi_startproc
 563 03c0 00000000 		st	%fp,0x0(,%sp)
 563      8B000911 
 564              		.cfi_def_cfa_offset	0
 565              		.cfi_offset	9,0
 566 03c8 08000000 		st	%lr,0x8(,%sp)
 566      8B000A11 
 567 03d0 18000000 		st	%got,0x18(,%sp)
 567      8B000F11 
 568 03d8 20000000 		st	%plt,0x20(,%sp)
 568      8B001011 
 569 03e0 00000000 		or	%fp,0,%sp
 569      8B000945 
 570              		.cfi_def_cfa_register	9
 571 03e8 30000000 		st	%s18,48(,%fp)
 571      89001211 
 572 03f0 38000000 		st	%s19,56(,%fp)
 572      89001311 
 573 03f8 40000000 		st	%s20,64(,%fp)
 573      89001411 
 574 0400 48000000 		st	%s21,72(,%fp)
 574      89001511 
 575 0408 50000000 		st	%s22,80(,%fp)
 575      89001611 
 576 0410 58000000 		st	%s23,88(,%fp)
 576      89001711 
 577 0418 60000000 		st	%s24,96(,%fp)
 577      89001811 
 578 0420 68000000 		st	%s25,104(,%fp)
 578      89001911 
 579 0428 70000000 		st	%s26,112(,%fp)
 579      89001A11 
 580 0430 78000000 		st	%s27,120(,%fp)
 580      89001B11 
 581 0438 80000000 		st	%s28,128(,%fp)
 581      89001C11 
 582 0440 88000000 		st	%s29,136(,%fp)
 582      89001D11 
 583 0448 90000000 		st	%s30,144(,%fp)
 583      89001E11 
 584 0450 98000000 		st	%s31,152(,%fp)
 584      89001F11 
 585 0458 A0000000 		st	%s32,160(,%fp)
 585      89002011 
 586 0460 A8000000 		st	%s33,168(,%fp)
 586      89002111 
 587 0468 F0E6FFFF 		lea	%s13,.L.4.2auto_size&0xffffffff
 587      00000D06 
 588 0470 00000000 		and	%s13,%s13,(32)0
 588      608D0D44 
 589 0478 FFFFFFFF 		lea.sl	%sp,.L.4.2auto_size>>32(%fp,%s13)
 589      8D898B06 
 590 0480 48000000 		brge.l.t	%sp,%sl,.L3.EoP
 590      888B3518 
 591 0488 18000000 		ld	%s61,0x18(,%tp)
 591      8E003D01 
 592 0490 00000000 		or	%s62,0,%s0
 592      80003E45 
 593 0498 3B010000 		lea	%s63,0x13b
 593      00003F06 
 594 04a0 00000000 		shm.l	%s63,0x0(%s61)
 594      BD033F31 
 595 04a8 08000000 		shm.l	%sl,0x8(%s61)
 595      BD030831 
 596 04b0 10000000 		shm.l	%sp,0x10(%s61)
 596      BD030B31 
 597 04b8 00000000 		monc
 597      0000003F 
 598 04c0 00000000 		or	%s0,0,%s62
 598      BE000045 
 599              	.L3.EoP:
 600              	# End of prologue codes
 601 04c8 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 601      00003E06 
 602 04d0 00000000 		and	%s62,%s62,(32)0
 602      60BE3E44 
 603 04d8 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 603      BE00BE06 
 604 04e0 00000000 		ld	%s61,0(,%s62)
 604      BE003D01 
 605 04e8 38FEFFFF 		st	%s61,-456(,%fp)
 605      89003D11 
 606 04f0 38FEFFFF 		lea	%s61,-456
 606      00003D06 
 607 04f8 00000000 		adds.l	%s61,%fp,%s61
 607      BD893D59 
 608 0500 00000000 		st	%s61,0(,%s62)
 608      BE003D11 
 609 0508 00000000 		or	%s62,1,(0)1
 609      00013E45 
 610 0510 40FEFFFF 		st1b	%s62,-448(,%fp)
 610      89003E15 
 611 0518 00000000 		lea	%s62,.LP._ZN4conv13refconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 611      00003E06 
 612 0520 00000000 		and	%s62,%s62,(32)0
 612      60BE3E44 
 613 0528 00000000 		lea.sl	%s62,.LP._ZN4conv13refconv_3_fwdEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s62)
 613      BE00BE06 
 614 0530 48FEFFFF 		st	%s62,-440(,%fp)
 614      89003E11 
 615 0538 B8FFFFFF 		lea	%s62,-72
 615      00003E06 
 616 0540 00000000 		adds.l	%s62,%fp,%s62
 616      BE893E59 
 617 0548 50FEFFFF 		st	%s62,-432(,%fp)
 617      89003E11 
 618 0550 00000000 		lea	%s62,__eh_curr_region@LO
 618      00003E06 
 619 0558 00000000 		and	%s62,%s62,(32)0
 619      60BE3E44 
 620 0560 00000000 		lea.sl	%s62,__eh_curr_region@HI(,%s62)
 620      BE00BE06 
 621 0568 00000000 		ld2b.zx	%s61,0(,%s62)
 621      BE00BD04 
 622 0570 60FEFFFF 		st2b	%s61,-416(,%fp)
 622      89003D14 
 623 0578 FFFF0000 		lea	%s61,65535
 623      00003D06 
 624 0580 00000000 		st2b	%s61,0(,%s62)
 624      BE003D14 
 625              	# line 238
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   MUST( p->kh > 0 && KW > 0 );
 626              		.loc	1 238 0
 627 0588 20000000 		ldl.sx	%s18,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 627      80001203 
 628 0590 98250000 		brlt.w	0,%s18,.L3.0
 628      92008218 
 629              	.L3.1:
 630 0598 00000000 		or	%s62,0,(0)1
 630      00003E45 
 631 05a0 00000000 		or	%s63,0,%s0
 631      80003F45 
 632 05a8 00250000 		br.l	.L3.2
 632      00000F18 
 633              	.L3.3:
 634 05b0 18F3FFFF 		st	%s63,-3304(,%fp)	# spill 
 634      89003F11 
 635 05b8 10F3FFFF 		st	%s1,-3312(,%fp)	# spill 
 635      89000111 
 636 05c0 08F3FFFF 		st	%s2,-3320(,%fp)	# spill 
 636      89000211 
 637 05c8 00F3FFFF 		st	%s3,-3328(,%fp)	# spill 
 637      89000311 
 638 05d0 F8F2FFFF 		st	%s4,-3336(,%fp)	# spill 
 638      89000411 
 639              	# line 31
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 640              		.loc	1 31 0
 641 05d8 00000000 		lea	%s0,.LP.__string.2@LO
 641      00000006 
 642 05e0 00000000 		and	%s0,%s0,(32)0
 642      60800044 
 643 05e8 00000000 		lea.sl	%s0,.LP.__string.2@HI(,%s0)
 643      80008006 
 644 05f0 00000000 		or	%s2,0,%s60
 644      BC000245 
 645 05f8 B0000000 		st	%s0,176(,%sp)
 645      8B000011 
 646 0600 B8000000 		st	%s61,184(,%sp)
 646      8B003D11 
 647 0608 C0000000 		st	%s60,192(,%sp)
 647      8B003C11 
 648 0610 EE000000 		lea	%s3,238
 648      00000306 
 649 0618 00000000 		or	%s1,0,%s61
 649      BD000145 
 650 0620 C8000000 		st	%s3,200(,%sp)
 650      8B000311 
 651 0628 00000000 		lea	%s12,printf@LO
 651      00000C06 
 652 0630 00000000 		and	%s12,%s12,(32)0
 652      608C0C44 
 653 0638 00000000 		lea.sl	%s12,printf@HI(,%s12)
 653      8C008C06 
 654 0640 00000000 		bsic	%lr,(,%s12)	# printf
 654      8C000A08 
 655 0648 00000000 		or	%s0,1,(0)1
 655      00010045 
 656 0650 00000000 		lea	%s12,exit@LO
 656      00000C06 
 657 0658 00000000 		and	%s12,%s12,(32)0
 657      608C0C44 
 658 0660 00000000 		lea.sl	%s12,exit@HI(,%s12)
 658      8C008C06 
 659 0668 00000000 		bsic	%lr,(,%s12)	# exit
 659      8C000A08 
 660 0670 18F3FFFF 		ld	%s63,-3304(,%fp)	# restore 
 660      89003F01 
 661 0678 10F3FFFF 		ld	%s1,-3312(,%fp)	# restore 
 661      89000101 
 662 0680 08F3FFFF 		ld	%s2,-3320(,%fp)	# restore 
 662      89000201 
 663 0688 00F3FFFF 		ld	%s3,-3328(,%fp)	# restore 
 663      89000301 
 664 0690 F8F2FFFF 		ld	%s4,-3336(,%fp)	# restore 
 664      89000401 
 665 0698 F8230000 		br.l	.L3.4
 665      00000F18 
 666              	.L3.5:
 667              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 668              		.loc	1 239 0
 669 06a0 00000000 		or	%s62,0,(0)1
 669      00003E45 
 670 06a8 58230000 		br.l	.L3.6
 670      00000F18 
 671              	.L3.7:
 672 06b0 18F3FFFF 		st	%s63,-3304(,%fp)	# spill 
 672      89003F11 
 673 06b8 10F3FFFF 		st	%s1,-3312(,%fp)	# spill 
 673      89000111 
 674 06c0 08F3FFFF 		st	%s2,-3320(,%fp)	# spill 
 674      89000211 
 675 06c8 00F3FFFF 		st	%s3,-3328(,%fp)	# spill 
 675      89000311 
 676 06d0 F8F2FFFF 		st	%s4,-3336(,%fp)	# spill 
 676      89000411 
 677              	# line 31
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 678              		.loc	1 31 0
 679 06d8 00000000 		lea	%s0,.LP.__string.4@LO
 679      00000006 
 680 06e0 00000000 		and	%s0,%s0,(32)0
 680      60800044 
 681 06e8 00000000 		lea.sl	%s0,.LP.__string.4@HI(,%s0)
 681      80008006 
 682 06f0 00000000 		or	%s2,0,%s60
 682      BC000245 
 683 06f8 B0000000 		st	%s0,176(,%sp)
 683      8B000011 
 684 0700 B8000000 		st	%s61,184(,%sp)
 684      8B003D11 
 685 0708 C0000000 		st	%s60,192(,%sp)
 685      8B003C11 
 686 0710 EF000000 		lea	%s3,239
 686      00000306 
 687 0718 00000000 		or	%s1,0,%s61
 687      BD000145 
 688 0720 C8000000 		st	%s3,200(,%sp)
 688      8B000311 
 689 0728 00000000 		lea	%s12,printf@LO
 689      00000C06 
 690 0730 00000000 		and	%s12,%s12,(32)0
 690      608C0C44 
 691 0738 00000000 		lea.sl	%s12,printf@HI(,%s12)
 691      8C008C06 
 692 0740 00000000 		bsic	%lr,(,%s12)	# printf
 692      8C000A08 
 693 0748 00000000 		or	%s0,1,(0)1
 693      00010045 
 694 0750 00000000 		lea	%s12,exit@LO
 694      00000C06 
 695 0758 00000000 		and	%s12,%s12,(32)0
 695      608C0C44 
 696 0760 00000000 		lea.sl	%s12,exit@HI(,%s12)
 696      8C008C06 
 697 0768 00000000 		bsic	%lr,(,%s12)	# exit
 697      8C000A08 
 698 0770 18F3FFFF 		ld	%s63,-3304(,%fp)	# restore 
 698      89003F01 
 699 0778 10F3FFFF 		ld	%s1,-3312(,%fp)	# restore 
 699      89000101 
 700 0780 08F3FFFF 		ld	%s2,-3320(,%fp)	# restore 
 700      89000201 
 701 0788 00F3FFFF 		ld	%s3,-3328(,%fp)	# restore 
 701      89000301 
 702 0790 F8F2FFFF 		ld	%s4,-3336(,%fp)	# restore 
 702      89000401 
 703 0798 50220000 		br.l	.L3.8
 703      00000F18 
 704              	.L3.9:
 705              	# line 240
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   MUST( SH >= 0 && SW >= 0 );
 706              		.loc	1 240 0
 707 07a0 00000000 		or	%s62,0,(0)1
 707      00003E45 
 708 07a8 00000000 		or	%s19,0,%s1
 708      81001345 
 709 07b0 00000000 		or	%s20,0,%s2
 709      82001445 
 710 07b8 00000000 		or	%s21,0,%s3
 710      83001545 
 711 07c0 00000000 		or	%s26,0,%s4
 711      84001A45 
 712 07c8 70210000 		br.l	.L3.10
 712      00000F18 
 713              	.L3.11:
 714 07d0 18F3FFFF 		st	%s63,-3304(,%fp)	# spill 
 714      89003F11 
 715              	# line 31
  31:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 716              		.loc	1 31 0
 717 07d8 00000000 		lea	%s0,.LP.__string.6@LO
 717      00000006 
 718 07e0 00000000 		and	%s0,%s0,(32)0
 718      60800044 
 719 07e8 00000000 		lea.sl	%s0,.LP.__string.6@HI(,%s0)
 719      80008006 
 720 07f0 00000000 		or	%s2,0,%s60
 720      BC000245 
 721 07f8 B0000000 		st	%s0,176(,%sp)
 721      8B000011 
 722 0800 B8000000 		st	%s61,184(,%sp)
 722      8B003D11 
 723 0808 C0000000 		st	%s60,192(,%sp)
 723      8B003C11 
 724 0810 F0000000 		lea	%s3,240
 724      00000306 
 725 0818 00000000 		or	%s1,0,%s61
 725      BD000145 
 726 0820 C8000000 		st	%s3,200(,%sp)
 726      8B000311 
 727 0828 00000000 		lea	%s12,printf@LO
 727      00000C06 
 728 0830 00000000 		and	%s12,%s12,(32)0
 728      608C0C44 
 729 0838 00000000 		lea.sl	%s12,printf@HI(,%s12)
 729      8C008C06 
 730 0840 00000000 		bsic	%lr,(,%s12)	# printf
 730      8C000A08 
 731 0848 00000000 		or	%s0,1,(0)1
 731      00010045 
 732 0850 00000000 		lea	%s12,exit@LO
 732      00000C06 
 733 0858 00000000 		and	%s12,%s12,(32)0
 733      608C0C44 
 734 0860 00000000 		lea.sl	%s12,exit@HI(,%s12)
 734      8C008C06 
 735 0868 00000000 		bsic	%lr,(,%s12)	# exit
 735      8C000A08 
 736 0870 18F3FFFF 		ld	%s63,-3304(,%fp)	# restore 
 736      89003F01 
 737 0878 281E0000 		br.l	.L3.12
 737      00000F18 
 738              	.L3.13:
 739              	# line 311
 241:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 242:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 243:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   refconv_2_fwd(p, src_m, wei_m, bia_m, dst_m);
 244:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 245:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 0 // original hoist, regr 4.72x
 246:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   auto ker = [](
 247:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       const prb_t *p, dnn_mem_t &src_m, dnn_mem_t &wei_m,
 248:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       float &d, const int g, const int mb, const int oc, const int oh, const int ow
 249:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       , const int kh_beg, const int kh_end, const int kw_beg, const int kw_end
 250:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ) {
 251:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int ic = 0; ic < IC/G; ++ic) {
 252:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int kh = kh_beg; kh < kh_end; ++kh)
 253:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       {
 254:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         const int ih = oh * SH - PH + kh * (p->dh + 1);
 255:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int kw = kw_beg; kw < kw_end; ++kw) {
 256:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           const int iw = ow * SW - PW + kw * (p->dw + 1); // loop vars: ow, kw
 257:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 258:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 259:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 260:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 261:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 262:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 263:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   };
 264:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 265:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // writes go to  dst_off_f(p, mb, g, oc, oh, ow);
 266:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   OMP(parallel for collapse(5))//;
 267:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int g = 0; g < G; ++g) {
 268:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 269:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 270:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 271:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 272:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 273:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t bia_off = bia_off_f(p, g, oc);
 274:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float &d = ((float*)dst_m)[dst_off];
 275:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0;
 276:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kh_beg, kh_end, kw_beg, kw_end;
 277:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             hoist_ApiB_in( kh_beg, kh_end,
 278:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 /*i  in   */ 0, p->kh,
 279:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 /*ih=A+iB */ (oh * SH - PH), (p->dh + 1),
 280:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 /*ih in   */ 0, IH);
 281:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             hoist_ApiB_in( kw_beg, kw_end,
 282:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 /*i  in   */ 0, KW,
 283:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 /*iw=A+iB */ (ow * SW - PW), (p->dw + 1),
 284:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 /*iw in   */ 0, IW);
 285:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kw_beg < kw_end && kh_beg < kh_end ) {
 286:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               ker( p, src_m, wei_m,
 287:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   d, g, mb, oc, oh, ow
 288:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   , kh_beg, kh_end, kw_beg, kw_end
 289:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                  );
 290:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 291:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (p->merge == RELU && d < 0)
 292:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               d = 0;
 293:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 294:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 295:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 296:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 297:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 298:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 1 // inline kernel, longhand hoist, short-circuit --> regr 8.28x
 299:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // musek(avx):regr 14.0x
 300:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // writes go to  dst_off_f(p, mb, g, oc, oh, ow);
 301:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // on alexnet, this got me about 15x speedup
 302:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // regr.sh-FWD 2.42x,2.38x
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int khb[OH] alignas(64);
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int khe[OH] alignas(64);
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int kwb[OW] alignas(64);
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int kwe[OW] alignas(64);
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int ICOG = IC / G;
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int OCOG = OC / G;
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DH   = p->dh + 1;
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DW   = p->dw + 1;
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int oh = 0; oh < OH; ++oh) {
 740              		.loc	1 311 0
 741 0880 80000000 		mins.w.sx	%s59,%s53,%s59
 741      BBB53B78 
 742 0888 481B0000 		br.l	.L3.14
 742      00000F18 
 743              	.L3.15:
 744              	# line 319
 312:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // trick to easy calc of kh, kw loop limits is that division must
 313:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // round more consistently.  'C' round-to-zero is not so useful!
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     khb[oh] = div_floor( 0  - (oh * SH - PH) + p->dh, DH );
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, DH );
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( khb[oh] < 0  ) khb[oh] = 0;
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( khe[oh] > KH ) khe[oh] = KH;
 318:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int ow = 0; ow < OW; ++ow) {
 745              		.loc	1 319 0
 746 0890 80000000 		mins.w.sx	%s59,%s52,%s59
 746      BBB43B78 
 747 0898 38180000 		br.l	.L3.16
 747      00000F18 
 748              	.L3.17:
 749              	# line 334
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, DW );
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, DW );
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( kwb[ow] < 0  ) kwb[ow] = 0;
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( kwe[ow] > KW ) kwe[ow] = KW;
 324:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 325:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   OMP(parallel for collapse(5))//;
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int g = 0; g < G; ++g) {
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OCOG; ++oc) {
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 331:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 332:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t bia_off = bia_off_f(p, g, oc);
 333:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float &d = ((float*)dst_m)[dst_off];
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             d = (p->dir & FLAG_BIA)? ((float*)bia_m)[bia_off] : 0.f;
 750              		.loc	1 334 0
 751 08a0 00000000 		or	%s63,0,(0)1
 751      00003F45 
 752 08a8 00000000 		or	%s51,0,%s62
 752      BE003345 
 753 08b0 00000000 		stu	%s63,0(%s55,%s56)	# *(d)
 753      B8B73F12 
 754 08b8 70110000 		br.l	.L3.18
 754      00000F18 
 755              	.L3.19:
 756              	# line 343
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kwb[ow] < kwe[ow] && khb[oh] < khe[oh] ) {
 336:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ih0 = oh * SH - PH;
 337:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int iw0 = ow * SW - PW;
 338:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ic = 0; ic < ICOG; ++ic) {
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[oh]; kh < khe[oh]; ++kh) {
 341:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 342:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   const int ih = ih0 + kh * DH;
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[ow]; kw < kwe[ow]; ++kw) {
 757              		.loc	1 343 0
 758 08c0 80000000 		mins.w.sx	%s60,%s56,%s60
 758      BCB83C78 
 759 08c8 B80D0000 		br.l	.L3.20
 759      00000F18 
 760              	.L3.21:
 761 08d0 80000000 		mins.w.sx	%s58,%s47,%s58
 761      BAAF3A78 
 762 08d8 E0060000 		br.l	.L3.22
 762      00000F18 
 763              	.L3.23:
 764 08e0 00000000 		lea	%s63,__eh_curr_region@LO
 764      00003F06 
 765 08e8 00000000 		and	%s63,%s63,(32)0
 765      60BF3F44 
 766 08f0 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 766      BF00BF06 
 767 08f8 60FEFFFF 		ld2b.zx	%s62,-416(,%fp)
 767      8900BE04 
 768 0900 00000000 		st2b	%s62,0(,%s63)
 768      BF003E14 
 769 0908 38FEFFFF 		ld	%s63,-456(,%fp)
 769      89003F01 
 770 0910 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 770      00003E06 
 771 0918 00000000 		and	%s62,%s62,(32)0
 771      60BE3E44 
 772 0920 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 772      BE00BE06 
 773 0928 00000000 		st	%s63,0(,%s62)
 773      BE003F11 
 774              	# line 363
 344:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 345:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     const int iw = iw0 + kw * DW;
 346:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 347:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     d += ((float*)src_m)[src_off] * ((float*)wei_m)[wei_off];
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 350:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 351:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 352:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (p->merge == RELU && d < 0.f)
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 d = 0.f;
 355:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 356:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 357:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 358:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 359:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 360:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 361:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #error "please select one"
 362:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 363:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 775              		.loc	1 363 0
 776              	# Start of epilogue codes
 777 0930 30000000 		ld	%s18,48(,%fp)
 777      89001201 
 778 0938 38000000 		ld	%s19,56(,%fp)
 778      89001301 
 779 0940 40000000 		ld	%s20,64(,%fp)
 779      89001401 
 780 0948 48000000 		ld	%s21,72(,%fp)
 780      89001501 
 781 0950 50000000 		ld	%s22,80(,%fp)
 781      89001601 
 782 0958 58000000 		ld	%s23,88(,%fp)
 782      89001701 
 783 0960 60000000 		ld	%s24,96(,%fp)
 783      89001801 
 784 0968 68000000 		ld	%s25,104(,%fp)
 784      89001901 
 785 0970 70000000 		ld	%s26,112(,%fp)
 785      89001A01 
 786 0978 78000000 		ld	%s27,120(,%fp)
 786      89001B01 
 787 0980 80000000 		ld	%s28,128(,%fp)
 787      89001C01 
 788 0988 88000000 		ld	%s29,136(,%fp)
 788      89001D01 
 789 0990 90000000 		ld	%s30,144(,%fp)
 789      89001E01 
 790 0998 98000000 		ld	%s31,152(,%fp)
 790      89001F01 
 791 09a0 A0000000 		ld	%s32,160(,%fp)
 791      89002001 
 792 09a8 A8000000 		ld	%s33,168(,%fp)
 792      89002101 
 793 09b0 00000000 		or	%sp,0,%fp
 793      89000B45 
 794              		.cfi_def_cfa	11,8
 795 09b8 18000000 		ld	%got,0x18(,%sp)
 795      8B000F01 
 796 09c0 20000000 		ld	%plt,0x20(,%sp)
 796      8B001001 
 797 09c8 08000000 		ld	%lr,0x8(,%sp)
 797      8B000A01 
 798 09d0 00000000 		ld	%fp,0x0(,%sp)
 798      8B000901 
 799 09d8 00000000 		b.l	(,%lr)
 799      8A000F19 
 800              	.L3.24:
 801              	# line 326
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 802              		.loc	1 326 0
 803 09e0 00000000 		adds.w.sx	%s62,1,%s62
 803      BE013E4A 
 804 09e8 00000000 		adds.w.sx	%s63,%s55,%s63
 804      BFB73F4A 
 805 09f0 00000000 		adds.l	%s51,%s53,%s51
 805      B3B53359 
 806 09f8 00000000 		adds.w.sx	%s48,%s45,%s48
 806      B0AD304A 
 807 0a00 00000000 		adds.l	%s39,%s41,%s39
 807      A7A92759 
 808 0a08 00000000 		adds.w.sx	%s33,%s45,%s33
 808      A1AD214A 
 809 0a10 00000000 		adds.l	%s35,%s41,%s35
 809      A3A92359 
 810 0a18 F8130000 		brgt.w	0,%s62,.L3.25
 810      BE008118 
 811 0a20 C0FEFFFF 		br.l	.L3.23
 811      00000F18 
 812              	.L3.26:
 813 0a28 C8FBFFFF 		ld	%s62,-1080(,%fp)	# restore 
 813      89003E01 
 814 0a30 00000000 		or	%s25,0,%s33
 814      A1001945 
 815 0a38 D8FBFFFF 		ld	%s55,-1064(,%fp)	# restore 
 815      89003701 
 816 0a40 A8FBFFFF 		ld	%s51,-1112(,%fp)	# restore 
 816      89003301 
 817 0a48 D0FBFFFF 		ld	%s45,-1072(,%fp)	# restore 
 817      89002D01 
 818 0a50 C0FBFFFF 		ld	%s41,-1088(,%fp)	# restore 
 818      89002901 
 819 0a58 B0FBFFFF 		ld	%s39,-1104(,%fp)	# restore 
 819      89002701 
 820 0a60 80FDFFFF 		ld	%s33,-640(,%fp)	# restore 
 820      89002101 
 821 0a68 B8FBFFFF 		ld	%s35,-1096(,%fp)	# restore 
 821      89002301 
 822 0a70 E0FBFFFF 		ld	%s23,-1056(,%fp)	# restore 
 822      89001701 
 823 0a78 A0FBFFFF 		ld	%s26,-1120(,%fp)	# restore 
 823      89001A01 
 824 0a80 60FFFFFF 		br.l	.L3.24
 824      00000F18 
 825              	.L3.27:
 826              	# line 327
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OCOG; ++oc) {
 827              		.loc	1 327 0
 828 0a88 00000000 		adds.w.sx	%s62,1,%s62
 828      BE013E4A 
 829 0a90 00000000 		adds.l	%s51,%s53,%s51
 829      B3B53359 
 830 0a98 00000000 		adds.l	%s45,%s50,%s45
 830      ADB22D59 
 831 0aa0 00000000 		adds.l	%s39,%s50,%s39
 831      A7B22759 
 832 0aa8 B8120000 		brgt.w	0,%s62,.L3.28
 832      BE008118 
 833 0ab0 78FFFFFF 		br.l	.L3.26
 833      00000F18 
 834              	.L3.29:
 835 0ab8 18FCFFFF 		ld	%s62,-1000(,%fp)	# restore 
 835      89003E01 
 836 0ac0 08FCFFFF 		ld	%s53,-1016(,%fp)	# restore 
 836      89003501 
 837 0ac8 F0FBFFFF 		ld	%s51,-1040(,%fp)	# restore 
 837      89003301 
 838 0ad0 10FCFFFF 		ld	%s50,-1008(,%fp)	# restore 
 838      89003201 
 839 0ad8 F8FBFFFF 		ld	%s45,-1032(,%fp)	# restore 
 839      89002D01 
 840 0ae0 00FCFFFF 		ld	%s39,-1024(,%fp)	# restore 
 840      89002701 
 841 0ae8 20FCFFFF 		ld	%s22,-992(,%fp)	# restore 
 841      89001601 
 842 0af0 E8FBFFFF 		ld	%s28,-1048(,%fp)	# restore 
 842      89001C01 
 843 0af8 90FFFFFF 		br.l	.L3.27
 843      00000F18 
 844              	.L3.30:
 845              	# line 328
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 846              		.loc	1 328 0
 847 0b00 00000000 		adds.w.sx	%s62,1,%s62
 847      BE013E4A 
 848 0b08 00000000 		adds.w.sx	%s55,1,%s55
 848      B701374A 
 849 0b10 C8110000 		brgt.w	0,%s62,.L3.31
 849      BE008118 
 850 0b18 A0FFFFFF 		br.l	.L3.29
 850      00000F18 
 851              	.L3.32:
 852 0b20 48FCFFFF 		ld	%s62,-952(,%fp)	# restore 
 852      89003E01 
 853 0b28 40FCFFFF 		ld	%s55,-960(,%fp)	# restore 
 853      89003701 
 854 0b30 50FCFFFF 		ld	%s21,-944(,%fp)	# restore 
 854      89001501 
 855 0b38 38FCFFFF 		ld	%s4,-968(,%fp)	# restore 
 855      89000401 
 856 0b40 30FCFFFF 		ld	%s30,-976(,%fp)	# restore 
 856      89001E01 
 857 0b48 28FCFFFF 		ld	%s29,-984(,%fp)	# restore 
 857      89001D01 
 858 0b50 B0FFFFFF 		br.l	.L3.30
 858      00000F18 
 859              	.L3.33:
 860              	# line 329
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 861              		.loc	1 329 0
 862 0b58 00000000 		adds.w.sx	%s62,1,%s62
 862      BE013E4A 
 863 0b60 00000000 		adds.w.sx	%s55,%s56,%s55
 863      B7B8374A 
 864 0b68 00000000 		adds.w.sx	%s53,%s56,%s53
 864      B5B8354A 
 865 0b70 00000000 		adds.l	%s51,4,%s51
 865      B3043359 
 866 0b78 00000000 		adds.w.sx	%s50,1,%s50
 866      B201324A 
 867 0b80 E8100000 		brgt.w	0,%s62,.L3.34
 867      BE008118 
 868 0b88 98FFFFFF 		br.l	.L3.32
 868      00000F18 
 869              	.L3.35:
 870 0b90 D8FCFFFF 		ld	%s62,-808(,%fp)	# restore 
 870      89003E01 
 871 0b98 E0FCFFFF 		ld	%s56,-800(,%fp)	# restore 
 871      89003801 
 872 0ba0 D0FCFFFF 		ld	%s55,-816(,%fp)	# restore 
 872      89003701 
 873 0ba8 C8FCFFFF 		ld	%s53,-824(,%fp)	# restore 
 873      89003501 
 874 0bb0 C0FCFFFF 		ld	%s51,-832(,%fp)	# restore 
 874      89003301 
 875 0bb8 B8FCFFFF 		ld	%s50,-840(,%fp)	# restore 
 875      89003201 
 876 0bc0 A8FCFFFF 		ld	%s46,-856(,%fp)	# restore 
 876      89002E01 
 877 0bc8 E8FCFFFF 		ld	%s19,-792(,%fp)	# restore 
 877      89001301 
 878 0bd0 A0FCFFFF 		ld	%s35,-864(,%fp)	# restore 
 878      89002301 
 879 0bd8 98FCFFFF 		ld	%s34,-872(,%fp)	# restore 
 879      89002201 
 880 0be0 80FCFFFF 		ld	%s33,-896(,%fp)	# restore 
 880      89002101 
 881 0be8 90FCFFFF 		ld	%s5,-880(,%fp)	# restore 
 881      89000501 
 882 0bf0 88FCFFFF 		ld	%s2,-888(,%fp)	# restore 
 882      89000201 
 883 0bf8 68FCFFFF 		ld	%s49,-920(,%fp)	# restore 
 883      89003101 
 884 0c00 70FCFFFF 		ld	%s60,-912(,%fp)	# restore 
 884      89003C01 
 885 0c08 78FCFFFF 		ld	%s20,-904(,%fp)	# restore 
 885      89001401 
 886 0c10 60FCFFFF 		ld	%s32,-928(,%fp)	# restore 
 886      89002001 
 887 0c18 58FCFFFF 		ld	%s31,-936(,%fp)	# restore 
 887      89001F01 
 888 0c20 B0FCFFFF 		ld	%s63,-848(,%fp)	# restore 
 888      89003F01 
 889 0c28 30FFFFFF 		br.l	.L3.33
 889      00000F18 
 890              	.L3.36:
 891 0c30 480E0000 		br.l	.L3.37
 891      00000F18 
 892              	.L3.38:
 893              	# line 330
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 894              		.loc	1 330 0
 895 0c38 00000000 		adds.w.sx	%s62,1,%s62
 895      BE013E4A 
 896 0c40 00000000 		adds.l	%s53,%s54,%s53
 896      B5B63559 
 897 0c48 00000000 		adds.l	%s55,4,%s55
 897      B7043759 
 898 0c50 E0FFFFFF 		brgt.w	0,%s62,.L3.36
 898      BE008118 
 899 0c58 38FFFFFF 		br.l	.L3.35
 899      00000F18 
 900              	.L3.39:
 901              	# line 354
 354:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 902              		.loc	1 354 0
 903 0c60 00000000 		or	%s63,0,(0)1
 903      00003F45 
 904 0c68 00000000 		stu	%s63,0(%s55,%s56)	# *(d)
 904      B8B73F12 
 905 0c70 C8FFFFFF 		br.l	.L3.38
 905      00000F18 
 906              	.L3.40:
 907              	# line 353
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 d = 0.f;
 908              		.loc	1 353 0
 909 0c78 00000000 		ldu	%s19,0(%s55,%s56)	# *(d)
 909      B8B71302 
 910 0c80 00000000 		or	%s20,0,(0)1
 910      00001445 
 911 0c88 00000000 		or	%s62,0,%s51
 911      B3003E45 
 912 0c90 D0FFFFFF 		brgt.s	%s20,%s19,.L3.39
 912      9394C118 
 913 0c98 A0FFFFFF 		br.l	.L3.38
 913      00000F18 
 914              	.L3.41:
 915 0ca0 D8FFFFFF 		breq.w	1,%s52,.L3.40
 915      B4018418 
 916 0ca8 00000000 		or	%s62,0,%s51
 916      B3003E45 
 917 0cb0 88FFFFFF 		br.l	.L3.38
 917      00000F18 
 918              	.L3.42:
 919 0cb8 40FDFFFF 		ld	%s52,-704(,%fp)	# restore 
 919      89003401 
 920 0cc0 00000000 		or	%s3,0,%s60
 920      BC000345 
 921 0cc8 60FDFFFF 		ld	%s18,-672(,%fp)	# restore 
 921      89001201 
 922 0cd0 58FDFFFF 		ld	%s61,-680(,%fp)	# restore 
 922      89003D01 
 923 0cd8 10FDFFFF 		ld	%s59,-752(,%fp)	# restore 
 923      89003B01 
 924 0ce0 08FDFFFF 		ld	%s57,-760(,%fp)	# restore 
 924      89003901 
 925 0ce8 50FDFFFF 		ld	%s50,-688(,%fp)	# restore 
 925      89003201 
 926 0cf0 48FDFFFF 		ld	%s49,-696(,%fp)	# restore 
 926      89003101 
 927 0cf8 F0FCFFFF 		ld	%s6,-784(,%fp)	# restore 
 927      89000601 
 928 0d00 F8FCFFFF 		ld	%s7,-776(,%fp)	# restore 
 928      89000701 
 929 0d08 38FDFFFF 		ld	%s44,-712(,%fp)	# restore 
 929      89002C01 
 930 0d10 30FDFFFF 		ld	%s60,-720(,%fp)	# restore 
 930      89003C01 
 931 0d18 00FDFFFF 		ld	%s58,-768(,%fp)	# restore 
 931      89003A01 
 932 0d20 18FDFFFF 		ld	%s53,-744(,%fp)	# restore 
 932      89003501 
 933 0d28 28FDFFFF 		ld	%s51,-728(,%fp)	# restore 
 933      89003301 
 934 0d30 20FDFFFF 		ld	%s54,-736(,%fp)	# restore 
 934      89003601 
 935 0d38 68FFFFFF 		br.l	.L3.41
 935      00000F18 
 936              	.L3.43:
 937 0d40 780B0000 		br.l	.L3.44
 937      00000F18 
 938              	.L3.45:
 939              	# line 339
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[oh]; kh < khe[oh]; ++kh) {
 940              		.loc	1 339 0
 941 0d48 00000000 		adds.w.sx	%s62,1,%s62
 941      BE013E4A 
 942 0d50 00000000 		adds.w.sx	%s59,1,%s59
 942      BB013B4A 
 943 0d58 E8FFFFFF 		brgt.w	0,%s62,.L3.43
 943      BE008118 
 944 0d60 58FFFFFF 		br.l	.L3.42
 944      00000F18 
 945              	.L3.46:
 946 0d68 68FDFFFF 		st	%s31,-664(,%fp)	# spill 
 946      89001F11 
 947 0d70 70FDFFFF 		st	%s1,-656(,%fp)	# spill 
 947      89000111 
 948 0d78 78FDFFFF 		st	%s58,-648(,%fp)	# spill 
 948      89003A11 
 949 0d80 80FDFFFF 		st	%s33,-640(,%fp)	# spill 
 949      89002111 
 950 0d88 88FDFFFF 		st	%s6,-632(,%fp)	# spill 
 950      89000611 
 951 0d90 00FEFFFF 		ld	%s62,-512(,%fp)	# restore 
 951      89003E01 
 952 0d98 00000000 		or	%s39,0,%s25
 952      99002745 
 953 0da0 C8FDFFFF 		ld	%s59,-568(,%fp)	# restore 
 953      89003B01 
 954 0da8 00000000 		or	%s43,0,%s29
 954      9D002B45 
 955 0db0 28FEFFFF 		ld	%s45,-472(,%fp)	# restore 
 955      89002D01 
 956 0db8 00000000 		or	%s42,0,%s28
 956      9C002A45 
 957 0dc0 20FEFFFF 		ld	%s41,-480(,%fp)	# restore 
 957      89002901 
 958 0dc8 00000000 		or	%s38,0,%s24
 958      98002645 
 959 0dd0 00000000 		or	%s47,0,%s32
 959      A0002F45 
 960 0dd8 00000000 		or	%s40,0,%s26
 960      9A002845 
 961 0de0 00000000 		or	%s37,0,%s23
 961      97002545 
 962 0de8 00000000 		or	%s36,0,%s22
 962      96002445 
 963 0df0 B0FDFFFF 		ld	%s26,-592(,%fp)	# restore 
 963      89001A01 
 964 0df8 00000000 		or	%s33,0,%s4
 964      84002145 
 965 0e00 A8FDFFFF 		ld	%s25,-600(,%fp)	# restore 
 965      89001901 
 966 0e08 00000000 		or	%s55,0,%s48
 966      B0003745 
 967 0e10 D0FDFFFF 		ld	%s22,-560(,%fp)	# restore 
 967      89001601 
 968 0e18 00000000 		or	%s56,0,%s49
 968      B1003845 
 969 0e20 E8FDFFFF 		ld	%s30,-536(,%fp)	# restore 
 969      89001E01 
 970 0e28 00000000 		or	%s34,0,%s21
 970      95002245 
 971 0e30 18FEFFFF 		ld	%s21,-488(,%fp)	# restore 
 971      89001501 
 972 0e38 D8FDFFFF 		ld	%s60,-552(,%fp)	# restore 
 972      89003C01 
 973 0e40 C0FDFFFF 		ld	%s29,-576(,%fp)	# restore 
 973      89001D01 
 974 0e48 B8FDFFFF 		ld	%s28,-584(,%fp)	# restore 
 974      89001C01 
 975 0e50 A0FDFFFF 		ld	%s24,-608(,%fp)	# restore 
 975      89001801 
 976 0e58 98FDFFFF 		ld	%s23,-616(,%fp)	# restore 
 976      89001701 
 977 0e60 90FDFFFF 		ld	%s4,-624(,%fp)	# restore 
 977      89000401 
 978 0e68 10FEFFFF 		ld	%s1,-496(,%fp)	# restore 
 978      89000101 
 979 0e70 08FEFFFF 		ld	%s32,-504(,%fp)	# restore 
 979      89002001 
 980 0e78 E0FDFFFF 		ld	%s31,-544(,%fp)	# restore 
 980      89001F01 
 981 0e80 F8FDFFFF 		ld	%s48,-520(,%fp)	# restore 
 981      89003001 
 982 0e88 F0FDFFFF 		ld	%s35,-528(,%fp)	# restore 
 982      89002301 
 983 0e90 B8FEFFFF 		br.l	.L3.45
 983      00000F18 
 984              	.L3.47:
 985              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 986              		.loc	1 340 0
 987 0e98 00000000 		adds.w.sx	%s62,4,%s62
 987      BE043E4A 
 988 0ea0 00000000 		adds.w.sx	%s59,%s59,%s58
 988      BABB3B4A 
 989 0ea8 00000000 		adds.w.sx	%s57,%s57,%s58
 989      BAB9394A 
 990 0eb0 00000000 		adds.w.sx	%s56,4,%s56
 990      B804384A 
 991 0eb8 00000000 		adds.w.sx	%s55,4,%s55
 991      B704374A 
 992 0ec0 00000000 		adds.w.sx	%s54,4,%s54
 992      B604364A 
 993 0ec8 00000000 		adds.w.sx	%s53,4,%s53
 993      B504354A 
 994 0ed0 00000000 		adds.w.sx	%s52,%s52,%s58
 994      BAB4344A 
 995 0ed8 00000000 		adds.w.sx	%s51,%s51,%s58
 995      BAB3334A 
 996 0ee0 10050000 		brgt.w	0,%s62,.L3.48
 996      BE008118 
 997 0ee8 80FEFFFF 		br.l	.L3.46
 997      00000F18 
 998              	.L3.49:
 999              	# line 349
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 1000              		.loc	1 349 0
 1001 0ef0 00000000 		or	%s63,1,(0)1
 1001      00013F45 
 1002 0ef8 00000000 		adds.l	%s61,%s49,(0)1
 1002      00B13D59 
 1003 0f00 00000000 		adds.l	%s61,%s61,%s48
 1003      B0BD3D59 
 1004 0f08 00000000 		lvl	%s63
 1004      00BF00BF 
 1005 0f10 0000002E 		vstu.nc	%v46,0,%s61
 1005      BD000092 
 1006 0f18 80FFFFFF 		br.l	.L3.47
 1006      00000F18 
 1007              	.L3.50:
 1008 0f20 00000000 		or	%s1,0,%s63
 1008      BF000145 
 1009              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1010              		.loc	1 348 0
 1011 0f28 00000000 		lvl	%s61
 1011      00BD00BF 
 1012 0f30 00003C2C 		vfsum.s	%v44,%v60
 1012      000080EC 
 1013 0f38 00000000 		or	%s63,1,(0)1
 1013      00013F45 
 1014 0f40 00000000 		lvl	%s63
 1014      00BF00BF 
 1015 0f48 002C2E2E 		vfadd.s	%v46,%v46,%v44
 1015      000080CC 
 1016 0f50 00000000 		or	%s62,0,%s44
 1016      AC003E45 
 1017 0f58 00000000 		or	%s59,0,%s43
 1017      AB003B45 
 1018 0f60 00000000 		or	%s58,0,%s42
 1018      AA003A45 
 1019 0f68 00000000 		or	%s57,0,%s41
 1019      A9003945 
 1020 0f70 00000000 		or	%s56,0,%s40
 1020      A8003845 
 1021 0f78 00000000 		or	%s55,0,%s39
 1021      A7003745 
 1022 0f80 00000000 		or	%s54,0,%s38
 1022      A6003645 
 1023 0f88 00000000 		or	%s53,0,%s37
 1023      A5003545 
 1024 0f90 00000000 		or	%s52,0,%s36
 1024      A4003445 
 1025 0f98 00000000 		or	%s51,0,%s35
 1025      A3003345 
 1026 0fa0 00000000 		or	%s48,0,%s34
 1026      A2003045 
 1027 0fa8 00000000 		or	%s49,0,%s7
 1027      87003145 
 1028 0fb0 40FFFFFF 		br.l	.L3.49
 1028      00000F18 
 1029              	.L3.22:
 1030 0fb8 00000000 		or	%s62,0,%s63
 1030      BF003E45 
 1031 0fc0 00000000 		or	%s46,0,%s60
 1031      BC002E45 
 1032 0fc8 00000000 		adds.l	%s45,%s59,(0)1
 1032      00BB2D59 
 1033 0fd0 00000000 		adds.l	%s46,%s45,%s46
 1033      AEAD2E59 
 1034 0fd8 00000000 		lvl	%s58
 1034      00BA00BF 
 1035 0fe0 0000003B 		vldu.nc	%v59,%s62,%s46
 1035      AEBE0082 
 1036 0fe8 00000000 		or	%s62,0,%s63
 1036      BF003E45 
 1037 0ff0 00000000 		or	%s46,0,%s60
 1037      BC002E45 
 1038 0ff8 00000000 		adds.l	%s45,%s57,(0)1
 1038      00B92D59 
 1039 1000 00000000 		adds.l	%s46,%s45,%s46
 1039      AEAD2E59 
 1040 1008 0000003A 		vldu.nc	%v58,%s62,%s46
 1040      AEBE0082 
 1041 1010 00000000 		or	%s62,0,%s63
 1041      BF003E45 
 1042 1018 00000000 		or	%s46,0,%s60
 1042      BC002E45 
 1043 1020 00000000 		adds.l	%s45,%s56,(0)1
 1043      00B82D59 
 1044 1028 00000000 		adds.l	%s46,%s45,%s46
 1044      AEAD2E59 
 1045 1030 00000039 		vldu.nc	%v57,%s62,%s46
 1045      AEBE0082 
 1046 1038 00000000 		or	%s62,0,%s63
 1046      BF003E45 
 1047 1040 00000000 		or	%s46,0,%s60
 1047      BC002E45 
 1048 1048 00000000 		adds.l	%s45,%s55,(0)1
 1048      00B72D59 
 1049 1050 00000000 		adds.l	%s46,%s45,%s46
 1049      AEAD2E59 
 1050 1058 00000038 		vldu.nc	%v56,%s62,%s46
 1050      AEBE0082 
 1051 1060 00000000 		adds.l	%s62,%s54,(0)1
 1051      00B63E59 
 1052 1068 00000000 		adds.l	%s62,%s62,%s53
 1052      B5BE3E59 
 1053 1070 00000037 		vldu.nc	%v55,4,%s62
 1053      BE040082 
 1054 1078 00000000 		adds.l	%s62,%s52,(0)1
 1054      00B43E59 
 1055 1080 00000000 		adds.l	%s62,%s62,%s53
 1055      B5BE3E59 
 1056 1088 00000036 		vldu.nc	%v54,4,%s62
 1056      BE040082 
 1057 1090 00363A35 		vfmul.s	%v53,%v58,%v54
 1057      000080CD 
 1058 1098 3B373534 		vfmad.s	%v52,%v53,%v55,%v59
 1058      000080E2 
 1059 10a0 00000000 		adds.l	%s62,%s51,(0)1
 1059      00B33E59 
 1060 10a8 00000000 		adds.l	%s62,%s62,%s53
 1060      B5BE3E59 
 1061 10b0 00000033 		vldu.nc	%v51,4,%s62
 1061      BE040082 
 1062 10b8 39333432 		vfmad.s	%v50,%v52,%v51,%v57
 1062      000080E2 
 1063 10c0 00000000 		adds.l	%s62,%s50,(0)1
 1063      00B23E59 
 1064 10c8 00000000 		adds.l	%s62,%s62,%s53
 1064      B5BE3E59 
 1065 10d0 00000031 		vldu.nc	%v49,4,%s62
 1065      BE040082 
 1066 10d8 38313230 		vfmad.s	%v48,%v50,%v49,%v56
 1066      000080E2 
 1067 10e0 00303C3C 		vfadd.s	%v60,%v60,%v48
 1067      000080CC 
 1068              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1069              		.loc	1 343 0
 1070 10e8 00000000 		adds.w.sx	%s60,%s60,%s49
 1070      B1BC3C4A 
 1071 10f0 00000000 		adds.l	%s53,%s53,%s48
 1071      B0B53559 
 1072 10f8 00000000 		subs.w.sx	%s47,%s47,%s58
 1072      BAAF2F5A 
 1073 1100 20FEFFFF 		brge.w	0,%s47,.L3.50
 1073      AF008518 
 1074 1108 C8F7FFFF 		br.l	.L3.21
 1074      00000F18 
 1075              	.L3.51:
 1076              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1077              		.loc	1 348 0
 1078 1110 00000000 		divs.w.sx	%s46,%s33,%s32
 1078      A0A12E7B 
 1079 1118 00000000 		or	%s63,0,%s1
 1079      81003F45 
 1080 1120 00000000 		or	%s35,0,%s51
 1080      B3002345 
 1081 1128 00000000 		or	%s36,0,%s52
 1081      B4002445 
 1082 1130 00000000 		or	%s37,0,%s53
 1082      B5002545 
 1083 1138 00000000 		or	%s38,0,%s54
 1083      B6002645 
 1084 1140 00000000 		or	%s39,0,%s55
 1084      B7002745 
 1085 1148 00000000 		or	%s40,0,%s56
 1085      B8002845 
 1086 1150 00000000 		or	%s41,0,%s57
 1086      B9002945 
 1087 1158 00000000 		or	%s43,0,%s59
 1087      BB002B45 
 1088 1160 00000000 		or	%s46,0,%s46
 1088      AE002E45 
 1089 1168 00000000 		addu.l	%s46,%s46,%s31
 1089      9FAE2E48 
 1090 1170 00000000 		or	%s44,0,%s62
 1090      BE002C45 
 1091 1178 00000000 		addu.l	%s46,%s46,%s30
 1091      9EAE2E48 
 1092 1180 00000000 		or	%s42,0,%s58
 1092      BA002A45 
 1093 1188 00000000 		mulu.l	%s46,%s46,%s29
 1093      9DAE2E49 
 1094 1190 00000000 		or	%s62,0,%s53
 1094      B5003E45 
 1095 1198 00000000 		or	%s45,0,%s59
 1095      BB002D45 
 1096 11a0 00000000 		addu.l	%s45,%s46,%s45
 1096      ADAE2D48 
 1097 11a8 00000000 		or	%s34,0,%s48
 1097      B0002245 
 1098 11b0 00000000 		mulu.l	%s45,%s45,%s28
 1098      9CAD2D49 
 1099 11b8 00000000 		or	%s7,0,%s49
 1099      B1000745 
 1100 11c0 00000000 		or	%s45,0,%s45
 1100      AD002D45 
 1101 11c8 00000000 		or	%s3,0,%s57
 1101      B9000345 
 1102 11d0 00000000 		addu.l	%s3,%s46,%s3
 1102      83AE0348 
 1103 11d8 00000000 		mulu.l	%s3,%s28,%s3
 1103      839C0349 
 1104 11e0 00000000 		or	%s3,0,%s3
 1104      83000345 
 1105 11e8 00000000 		or	%s2,0,%s56
 1105      B8000245 
 1106 11f0 00000000 		or	%s0,0,%s55
 1106      B7000045 
 1107 11f8 00000000 		or	%s61,0,%s54
 1107      B6003D45 
 1108 1200 00000000 		or	%s60,0,%s52
 1108      B4003C45 
 1109 1208 00000000 		addu.l	%s59,%s46,%s60
 1109      BCAE3B48 
 1110 1210 00000000 		mulu.l	%s60,%s28,%s59
 1110      BB9C3C49 
 1111 1218 00000000 		or	%s59,0,%s60
 1111      BC003B45 
 1112 1220 00000000 		or	%s60,0,%s51
 1112      B3003C45 
 1113 1228 00000000 		addu.l	%s46,%s46,%s60
 1113      BCAE2E48 
 1114 1230 00000000 		mulu.l	%s46,%s28,%s46
 1114      AE9C2E49 
 1115 1238 00000000 		or	%s46,0,%s46
 1115      AE002E45 
 1116 1240 00000000 		divu.l	%s60,%s27,%s26
 1116      9A9B3C6F 
 1117 1248 00000000 		addu.l	%s58,%s60,%s25
 1117      99BC3A48 
 1118 1250 00000000 		mulu.l	%s60,%s58,%s24
 1118      98BA3C49 
 1119 1258 00000000 		divu.l	%s58,%s60,%s26
 1119      9ABC3A6F 
 1120 1260 00000000 		addu.l	%s60,%s30,%s58
 1120      BA9E3C48 
 1121 1268 00000000 		mulu.l	%s58,%s60,%s23
 1121      97BC3A49 
 1122 1270 00000000 		addu.l	%s2,%s2,%s58
 1122      BA820248 
 1123 1278 00000000 		addu.l	%s62,%s62,%s58
 1123      BABE3E48 
 1124 1280 00000000 		addu.l	%s0,%s0,%s58
 1124      BA800048 
 1125 1288 00000000 		addu.l	%s60,%s61,%s58
 1125      BABD3C48 
 1126 1290 00000000 		mulu.l	%s2,%s2,%s22
 1126      96820249 
 1127 1298 00000000 		or	%s2,0,%s2
 1127      82000245 
 1128 12a0 00000000 		mulu.l	%s62,%s22,%s62
 1128      BE963E49 
 1129 12a8 00000000 		or	%s62,0,%s62
 1129      BE003E45 
 1130 12b0 00000000 		mulu.l	%s0,%s22,%s0
 1130      80960049 
 1131 12b8 00000000 		or	%s0,0,%s0
 1131      80000045 
 1132 12c0 00000000 		mulu.l	%s61,%s22,%s60
 1132      BC963D49 
 1133 12c8 00000000 		or	%s60,0,%s61
 1133      BD003C45 
 1134              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1135              		.loc	1 343 0
 1136 12d0 00000000 		muls.l	%s62,4,%s62
 1136      BE043E6E 
 1137 12d8 00000000 		muls.l	%s2,4,%s2
 1137      8204026E 
 1138 12e0 00000000 		muls.l	%s0,4,%s0
 1138      8004006E 
 1139 12e8 00000000 		muls.l	%s61,4,%s60
 1139      BC043D6E 
 1140 12f0 00000000 		muls.l	%s45,4,%s45
 1140      AD042D6E 
 1141 12f8 00000000 		muls.l	%s3,4,%s3
 1141      8304036E 
 1142 1300 00000000 		muls.l	%s60,4,%s59
 1142      BB043C6E 
 1143 1308 00000000 		muls.l	%s46,4,%s46
 1143      AE042E6E 
 1144 1310 00000000 		adds.l	%s54,%s62,%s21
 1144      95BE3659 
 1145 1318 00000000 		adds.l	%s51,%s2,%s21
 1145      95823359 
 1146 1320 00000000 		adds.l	%s50,%s0,%s21
 1146      95803259 
 1147 1328 00000000 		adds.l	%s52,%s61,%s21
 1147      95BD3459 
 1148 1330 00000000 		adds.l	%s59,%s45,%s20
 1148      94AD3B59 
 1149 1338 00000000 		adds.l	%s57,%s3,%s19
 1149      93833959 
 1150 1340 00000000 		adds.l	%s56,%s60,%s6
 1150      86BC3859 
 1151 1348 00000000 		adds.l	%s55,%s46,%s5
 1151      85AE3759 
 1152 1350 00000000 		subs.w.sx	%s62,0,%s4
 1152      84003E5A 
 1153 1358 00000000 		smvl	%s61
 1153      00003D2E 
 1154 1360 80000000 		mins.w.sx	%s58,%s62,%s61
 1154      BDBE3A78 
 1155              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1156              		.loc	1 348 0
 1157 1368 00000000 		or	%s46,0,(0)1
 1157      00002E45 
 1158 1370 00000000 		lvl	%s61
 1158      00BD00BF 
 1159 1378 0000003C 		vbrdu	%v60,%s46
 1159      00AE808C 
 1160 1380 00000000 		or	%s47,0,%s62
 1160      BE002F45 
 1161 1388 00000000 		or	%s62,0,%s58
 1161      BA003E45 
 1162              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1163              		.loc	1 343 0
 1164 1390 00000000 		or	%s60,0,(0)1
 1164      00003C45 
 1165 1398 00000000 		muls.w.sx	%s49,%s1,%s58
 1165      BA81314B 
 1166 13a0 00000000 		or	%s53,0,(0)1
 1166      00003545 
 1167 13a8 00000000 		muls.l	%s48,4,%s62
 1167      BE04306E 
 1168 13b0 08FCFFFF 		br.l	.L3.22
 1168      00000F18 
 1169              	.L3.52:
 1170 13b8 00000000 		or	%s50,1,(0)1
 1170      00013245 
 1171 13c0 00000000 		adds.l	%s47,%s49,(0)1
 1171      00B12F59 
 1172 13c8 00000000 		adds.l	%s47,%s47,%s48
 1172      B0AF2F59 
 1173 13d0 00000000 		lvl	%s50
 1173      00B200BF 
 1174 13d8 0000002E 		vldu.nc	%v46,0,%s47
 1174      AF000082 
 1175 13e0 30FDFFFF 		brlt.w	0,%s18,.L3.51
 1175      92008218 
 1176 13e8 08FBFFFF 		br.l	.L3.49
 1176      00000F18 
 1177              	.L3.48:
 1178 13f0 C8FFFFFF 		brlt.w	0,%s18,.L3.52
 1178      92008218 
 1179 13f8 A0FAFFFF 		br.l	.L3.47
 1179      00000F18 
 1180              	.L3.53:
 1181 1400 28FEFFFF 		st	%s45,-472(,%fp)	# spill 
 1181      89002D11 
 1182 1408 20FEFFFF 		st	%s41,-480(,%fp)	# spill 
 1182      89002911 
 1183 1410 18FEFFFF 		st	%s21,-488(,%fp)	# spill 
 1183      89001511 
 1184 1418 10FEFFFF 		st	%s1,-496(,%fp)	# spill 
 1184      89000111 
 1185 1420 08FEFFFF 		st	%s32,-504(,%fp)	# spill 
 1185      89002011 
 1186 1428 00FEFFFF 		st	%s62,-512(,%fp)	# spill 
 1186      89003E11 
 1187 1430 F8FDFFFF 		st	%s48,-520(,%fp)	# spill 
 1187      89003011 
 1188 1438 F0FDFFFF 		st	%s35,-528(,%fp)	# spill 
 1188      89002311 
 1189 1440 E8FDFFFF 		st	%s30,-536(,%fp)	# spill 
 1189      89001E11 
 1190 1448 E0FDFFFF 		st	%s31,-544(,%fp)	# spill 
 1190      89001F11 
 1191 1450 D8FDFFFF 		st	%s60,-552(,%fp)	# spill 
 1191      89003C11 
 1192 1458 D0FDFFFF 		st	%s22,-560(,%fp)	# spill 
 1192      89001611 
 1193 1460 C8FDFFFF 		st	%s59,-568(,%fp)	# spill 
 1193      89003B11 
 1194 1468 C0FDFFFF 		st	%s29,-576(,%fp)	# spill 
 1194      89001D11 
 1195 1470 B8FDFFFF 		st	%s28,-584(,%fp)	# spill 
 1195      89001C11 
 1196 1478 B0FDFFFF 		st	%s26,-592(,%fp)	# spill 
 1196      89001A11 
 1197 1480 A8FDFFFF 		st	%s25,-600(,%fp)	# spill 
 1197      89001911 
 1198 1488 A0FDFFFF 		st	%s24,-608(,%fp)	# spill 
 1198      89001811 
 1199 1490 98FDFFFF 		st	%s23,-616(,%fp)	# spill 
 1199      89001711 
 1200 1498 90FDFFFF 		st	%s4,-624(,%fp)	# spill 
 1200      89000411 
 1201 14a0 00000000 		or	%s30,0,%s59
 1201      BB001E45 
 1202              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 1203              		.loc	1 340 0
 1204 14a8 00000000 		adds.w.sx	%s62,%s22,%s29
 1204      9D963E4A 
 1205 14b0 00000000 		muls.w.sx	%s60,%s22,%s60
 1205      BC963C4B 
 1206 14b8 E8FDFFFF 		ld	%s63,-536(,%fp)	# restore 
 1206      89003F01 
 1207 14c0 00000000 		or	%s29,0,%s43
 1207      AB001D45 
 1208 14c8 00000000 		adds.w.sx	%s59,%s60,%s31
 1208      9FBC3B4A 
 1209 14d0 00000000 		adds.w.sx	%s57,%s60,%s28
 1209      9CBC394A 
 1210 14d8 00000000 		adds.w.sx	%s61,%s22,%s26
 1210      9A963D4A 
 1211 14e0 00000000 		adds.w.sx	%s50,%s22,%s25
 1211      9996324A 
 1212 14e8 00000000 		adds.w.sx	%s54,%s22,%s24
 1212      9896364A 
 1213 14f0 00000000 		adds.w.sx	%s53,%s22,%s63
 1213      BF96354A 
 1214 14f8 00000000 		adds.w.sx	%s52,%s60,%s23
 1214      97BC344A 
 1215 1500 00000000 		adds.w.sx	%s51,%s60,%s4
 1215      84BC334A 
 1216 1508 00000000 		or	%s25,0,%s39
 1216      A7001945 
 1217 1510 00000000 		or	%s28,0,%s42
 1217      AA001C45 
 1218 1518 00000000 		or	%s24,0,%s38
 1218      A6001845 
 1219 1520 00000000 		or	%s32,0,%s47
 1219      AF002045 
 1220 1528 00000000 		or	%s26,0,%s40
 1220      A8001A45 
 1221 1530 00000000 		or	%s23,0,%s37
 1221      A5001745 
 1222 1538 00000000 		or	%s22,0,%s36
 1222      A4001645 
 1223 1540 00000000 		or	%s4,0,%s33
 1223      A1000445 
 1224 1548 00000000 		or	%s48,0,%s55
 1224      B7003045 
 1225 1550 00000000 		or	%s49,0,%s56
 1225      B8003145 
 1226 1558 00000000 		or	%s21,0,%s34
 1226      A2001545 
 1227 1560 00000000 		or	%s56,0,%s61
 1227      BD003845 
 1228 1568 00000000 		or	%s55,0,%s50
 1228      B2003745 
 1229 1570 88FDFFFF 		ld	%s6,-632(,%fp)	# restore 
 1229      89000601 
 1230 1578 80FDFFFF 		ld	%s33,-640(,%fp)	# restore 
 1230      89002101 
 1231 1580 78FDFFFF 		ld	%s58,-648(,%fp)	# restore 
 1231      89003A01 
 1232 1588 70FDFFFF 		ld	%s1,-656(,%fp)	# restore 
 1232      89000101 
 1233 1590 68FDFFFF 		ld	%s31,-664(,%fp)	# restore 
 1233      89001F01 
 1234 1598 58FEFFFF 		br.l	.L3.48
 1234      00000F18 
 1235              	.L3.54:
 1236 15a0 60FEFFFF 		brlt.w	%s22,%s21,.L3.53
 1236      95968218 
 1237 15a8 A0F7FFFF 		br.l	.L3.45
 1237      00000F18 
 1238              	.L3.55:
 1239 15b0 00000000 		or	%s59,0,%s3
 1239      83003B45 
 1240 15b8 00000000 		or	%s62,0,%s2
 1240      82003E45 
 1241 15c0 E0FFFFFF 		br.l	.L3.54
 1241      00000F18 
 1242              	.L3.56:
 1243 15c8 00000000 		adds.w.sx	%s62,1,%s62
 1243      BE013E4A 
 1244 15d0 00000000 		adds.w.sx	%s59,%s60,%s59
 1244      BBBC3B4A 
 1245 15d8 00000000 		adds.w.sx	%s58,1,%s58
 1245      BA013A4A 
 1246 15e0 80020000 		brgt.w	0,%s62,.L3.57
 1246      BE008118 
 1247 15e8 C8FFFFFF 		br.l	.L3.55
 1247      00000F18 
 1248              	.L3.58:
 1249              	# line 349
 349:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 1250              		.loc	1 349 0
 1251 15f0 00000000 		or	%s63,1,(0)1
 1251      00013F45 
 1252 15f8 00000000 		adds.l	%s61,%s56,(0)1
 1252      00B83D59 
 1253 1600 00000000 		adds.l	%s61,%s61,%s55
 1253      B7BD3D59 
 1254 1608 00000000 		lvl	%s63
 1254      00BF00BF 
 1255 1610 0000002F 		vstu.nc	%v47,0,%s61
 1255      BD000092 
 1256 1618 B0FFFFFF 		br.l	.L3.56
 1256      00000F18 
 1257              	.L3.59:
 1258 1620 00000000 		or	%s1,0,%s61
 1258      BD000145 
 1259              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1260              		.loc	1 348 0
 1261 1628 00000000 		lvl	%s54
 1261      00B600BF 
 1262 1630 00003F2D 		vfsum.s	%v45,%v63
 1262      000080EC 
 1263 1638 00000000 		or	%s63,1,(0)1
 1263      00013F45 
 1264 1640 00000000 		lvl	%s63
 1264      00BF00BF 
 1265 1648 002D2F2F 		vfadd.s	%v47,%v47,%v45
 1265      000080CC 
 1266 1650 00000000 		or	%s62,0,%s53
 1266      B5003E45 
 1267 1658 00000000 		or	%s60,0,%s52
 1267      B4003C45 
 1268 1660 00000000 		or	%s59,0,%s51
 1268      B3003B45 
 1269 1668 00000000 		or	%s58,0,%s50
 1269      B2003A45 
 1270 1670 00000000 		or	%s56,0,%s49
 1270      B1003845 
 1271 1678 78FFFFFF 		br.l	.L3.58
 1271      00000F18 
 1272              	.L3.20:
 1273 1680 00000000 		or	%s62,0,%s63
 1273      BF003E45 
 1274 1688 00000000 		lvl	%s60
 1274      00BC00BF 
 1275 1690 0000003E 		vldu.nc	%v62,%s61,%s62
 1275      BEBD0082 
 1276 1698 00000000 		or	%s62,0,%s59
 1276      BB003E45 
 1277 16a0 0000003D 		vldu.nc	%v61,4,%s62
 1277      BE040082 
 1278 16a8 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 1278      000080E2 
 1279              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1280              		.loc	1 343 0
 1281 16b0 00000000 		adds.l	%s63,%s63,%s58
 1281      BABF3F59 
 1282 16b8 00000000 		adds.l	%s59,%s59,%s57
 1282      B9BB3B59 
 1283 16c0 00000000 		subs.w.sx	%s56,%s56,%s60
 1283      BCB8385A 
 1284 16c8 58FFFFFF 		brge.w	0,%s56,.L3.59
 1284      B8008518 
 1285 16d0 F0F1FFFF 		br.l	.L3.19
 1285      00000F18 
 1286              	.L3.60:
 1287              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1288              		.loc	1 348 0
 1289 16d8 00000000 		divs.w.sx	%s46,%s48,%s47
 1289      AFB02E7B 
 1290 16e0 00000000 		or	%s61,0,%s1
 1290      81003D45 
 1291 16e8 00000000 		or	%s52,0,%s60
 1291      BC003445 
 1292 16f0 00000000 		or	%s50,0,%s58
 1292      BA003245 
 1293 16f8 00000000 		or	%s51,0,%s59
 1293      BB003345 
 1294 1700 00000000 		or	%s53,0,%s62
 1294      BE003545 
 1295 1708 00000000 		or	%s49,0,%s56
 1295      B8003145 
 1296 1710 00000000 		or	%s46,0,%s46
 1296      AE002E45 
 1297 1718 00000000 		addu.l	%s46,%s46,%s45
 1297      ADAE2E48 
 1298 1720 00000000 		addu.l	%s46,%s46,%s44
 1298      ACAE2E48 
 1299 1728 00000000 		mulu.l	%s46,%s46,%s43
 1299      ABAE2E49 
 1300 1730 00000000 		or	%s62,0,%s58
 1300      BA003E45 
 1301 1738 00000000 		or	%s7,0,%s59
 1301      BB000745 
 1302 1740 00000000 		addu.l	%s7,%s46,%s7
 1302      87AE0748 
 1303 1748 00000000 		mulu.l	%s7,%s7,%s42
 1303      AA870749 
 1304 1750 00000000 		or	%s7,0,%s7
 1304      87000745 
 1305 1758 00000000 		divu.l	%s46,%s41,%s40
 1305      A8A92E6F 
 1306 1760 00000000 		addu.l	%s46,%s46,%s39
 1306      A7AE2E48 
 1307 1768 00000000 		mulu.l	%s46,%s46,%s38
 1307      A6AE2E49 
 1308 1770 00000000 		divu.l	%s46,%s46,%s40
 1308      A8AE2E6F 
 1309 1778 00000000 		addu.l	%s46,%s44,%s46
 1309      AEAC2E48 
 1310 1780 00000000 		mulu.l	%s46,%s46,%s37
 1310      A5AE2E49 
 1311 1788 00000000 		addu.l	%s46,%s62,%s46
 1311      AEBE2E48 
 1312 1790 00000000 		mulu.l	%s46,%s46,%s36
 1312      A4AE2E49 
 1313 1798 00000000 		or	%s46,0,%s46
 1313      AE002E45 
 1314              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1315              		.loc	1 343 0
 1316 17a0 00000000 		muls.l	%s7,4,%s7
 1316      8704076E 
 1317 17a8 00000000 		muls.l	%s46,4,%s46
 1317      AE042E6E 
 1318 17b0 00000000 		adds.l	%s7,%s7,%s35
 1318      A3870759 
 1319 17b8 00000000 		adds.l	%s46,%s46,%s34
 1319      A2AE2E59 
 1320 17c0 00000000 		subs.w.sx	%s62,0,%s33
 1320      A1003E5A 
 1321 17c8 00000000 		smvl	%s54
 1321      0000362E 
 1322 17d0 80000000 		mins.w.sx	%s60,%s62,%s54
 1322      B6BE3C78 
 1323              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1324              		.loc	1 348 0
 1325 17d8 00000000 		or	%s6,0,(0)1
 1325      00000645 
 1326 17e0 00000000 		lvl	%s54
 1326      00B600BF 
 1327 17e8 0000003F 		vbrdu	%v63,%s6
 1327      0086808C 
 1328 17f0 00000000 		or	%s56,0,%s62
 1328      BE003845 
 1329 17f8 00000000 		or	%s62,0,%s60
 1329      BC003E45 
 1330 1800 00000000 		or	%s63,0,%s7
 1330      87003F45 
 1331              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1332              		.loc	1 343 0
 1333 1808 00000000 		muls.l	%s58,%s1,%s62
 1333      BE813A6E 
 1334 1810 00000000 		or	%s59,0,%s46
 1334      AE003B45 
 1335 1818 00000000 		muls.l	%s57,4,%s62
 1335      BE04396E 
 1336 1820 60FEFFFF 		br.l	.L3.20
 1336      00000F18 
 1337              	.L3.61:
 1338 1828 00000000 		or	%s57,1,(0)1
 1338      00013945 
 1339 1830 00000000 		adds.l	%s54,%s56,(0)1
 1339      00B83659 
 1340 1838 00000000 		adds.l	%s54,%s54,%s55
 1340      B7B63659 
 1341 1840 00000000 		lvl	%s57
 1341      00B900BF 
 1342 1848 0000002F 		vldu.nc	%v47,0,%s54
 1342      B6000082 
 1343 1850 88FEFFFF 		brlt.w	0,%s18,.L3.60
 1343      92008218 
 1344 1858 98FDFFFF 		br.l	.L3.58
 1344      00000F18 
 1345              	.L3.57:
 1346 1860 C8FFFFFF 		brlt.w	0,%s18,.L3.61
 1346      92008218 
 1347 1868 60FDFFFF 		br.l	.L3.56
 1347      00000F18 
 1348              	.L3.62:
 1349 1870 00000000 		or	%s44,0,%s59
 1349      BB002C45 
 1350 1878 00000000 		or	%s2,0,%s62
 1350      BE000245 
 1351 1880 00000000 		or	%s62,0,%s32
 1351      A0003E45 
 1352 1888 00000000 		or	%s3,0,%s59
 1352      BB000345 
 1353 1890 00000000 		or	%s59,0,%s31
 1353      9F003B45 
 1354 1898 00000000 		or	%s58,0,%s30
 1354      9E003A45 
 1355 18a0 C0FFFFFF 		br.l	.L3.57
 1355      00000F18 
 1356              	.L3.63:
 1357 18a8 C8FFFFFF 		brlt.w	0,%s22,.L3.62
 1357      96008218 
 1358 18b0 F0FCFFFF 		br.l	.L3.54
 1358      00000F18 
 1359              	.L3.44:
 1360 18b8 F0FFFFFF 		brlt.w	0,%s21,.L3.63
 1360      95008218 
 1361 18c0 88F4FFFF 		br.l	.L3.45
 1361      00000F18 
 1362              	.L3.64:
 1363 18c8 60FDFFFF 		st	%s18,-672(,%fp)	# spill 
 1363      89001211 
 1364 18d0 58FDFFFF 		st	%s61,-680(,%fp)	# spill 
 1364      89003D11 
 1365 18d8 50FDFFFF 		st	%s50,-688(,%fp)	# spill 
 1365      89003211 
 1366 18e0 48FDFFFF 		st	%s49,-696(,%fp)	# spill 
 1366      89003111 
 1367 18e8 40FDFFFF 		st	%s52,-704(,%fp)	# spill 
 1367      89003411 
 1368 18f0 38FDFFFF 		st	%s44,-712(,%fp)	# spill 
 1368      89002C11 
 1369 18f8 30FDFFFF 		st	%s60,-720(,%fp)	# spill 
 1369      89003C11 
 1370 1900 28FDFFFF 		st	%s51,-728(,%fp)	# spill 
 1370      89003311 
 1371 1908 20FDFFFF 		st	%s54,-736(,%fp)	# spill 
 1371      89003611 
 1372 1910 18FDFFFF 		st	%s53,-744(,%fp)	# spill 
 1372      89003511 
 1373 1918 10FDFFFF 		st	%s59,-752(,%fp)	# spill 
 1373      89003B11 
 1374 1920 08FDFFFF 		st	%s57,-760(,%fp)	# spill 
 1374      89003911 
 1375 1928 00FDFFFF 		st	%s58,-768(,%fp)	# spill 
 1375      89003A11 
 1376 1930 F8FCFFFF 		st	%s7,-776(,%fp)	# spill 
 1376      89000711 
 1377 1938 F0FCFFFF 		st	%s6,-784(,%fp)	# spill 
 1377      89000611 
 1378 1940 00000000 		dldl.sx	%s57,0(%s55,%s57)	# *(j$46)
 1378      B9B7390B 
 1379 1948 00000000 		dldl.sx	%s63,0(%s55,%s59)	# *(j$45)
 1379      BBB73F0B 
 1380 1950 00000000 		or	%s59,0,%s46
 1380      AE003B45 
 1381 1958 00000000 		subs.w.sx	%s18,%s57,%s63
 1381      BFB9125A 
 1382 1960 00000000 		subs.w.sx	%s33,0,%s18
 1382      9200215A 
 1383 1968 00000000 		or	%s63,0,%s63
 1383      BF003F45 
 1384 1970 00000000 		muls.l	%s61,4,%s63
 1384      BF043D6E 
 1385 1978 00000000 		or	%s62,0,%s58
 1385      BA003E45 
 1386 1980 00000000 		muls.l	%s58,%s63,%s1
 1386      81BF3A6E 
 1387 1988 00000000 		muls.l	%s57,%s63,%s1
 1387      81BF396E 
 1388 1990 00000000 		muls.l	%s54,%s63,%s1
 1388      81BF366E 
 1389 1998 00000000 		muls.l	%s52,%s63,%s1
 1389      81BF346E 
 1390 19a0 00000000 		muls.l	%s63,%s63,%s1
 1390      81BF3F6E 
 1391 19a8 00000000 		adds.l	%s58,%s58,%s53
 1391      B5BA3A59 
 1392 19b0 00000000 		adds.l	%s35,%s58,%s7
 1392      87BA2359 
 1393 19b8 00000000 		adds.l	%s7,%s53,%s7
 1393      87B50759 
 1394 19c0 00000000 		adds.l	%s20,%s57,%s7
 1394      87B91459 
 1395 19c8 00000000 		adds.l	%s19,%s54,%s7
 1395      87B61359 
 1396 19d0 00000000 		adds.l	%s52,%s52,%s7
 1396      87B43459 
 1397 19d8 00000000 		adds.l	%s5,%s63,%s7
 1397      87BF0559 
 1398 19e0 88FDFFFF 		st	%s52,-632(,%fp)	# spill 
 1398      89003411 
 1399 19e8 00000000 		adds.l	%s34,%s61,%s6
 1399      86BD2259 
 1400 19f0 00000000 		or	%s60,0,%s3
 1400      83003C45 
 1401 19f8 C0FEFFFF 		br.l	.L3.44
 1401      00000F18 
 1402              	.L3.65:
 1403              	# line 339
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[oh]; kh < khe[oh]; ++kh) {
 1404              		.loc	1 339 0
 1405 1a00 00000000 		or	%s46,0,(0)1
 1405      00002E45 
 1406 1a08 C0FEFFFF 		brlt.w	0,%s44,.L3.64
 1406      AC008218 
 1407 1a10 90F2FFFF 		br.l	.L3.41
 1407      00000F18 
 1408              	.L3.66:
 1409 1a18 E8FFFFFF 		brlt.w	%s50,%s49,.L3.65
 1409      B1B28218 
 1410 1a20 80F2FFFF 		br.l	.L3.41
 1410      00000F18 
 1411              	.L3.18:
 1412              	# line 334
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kwb[ow] < kwe[ow] && khb[oh] < khe[oh] ) {
 1413              		.loc	1 334 0
 1414 1a28 00000000 		ldu	%s62,0(%s55,%s56)	# *(d)
 1414      B8B73E02 
 1415 1a30 00000000 		stu	%s62,0(%s55,%s56)	# *(d)
 1415      B8B73E12 
 1416              	# line 335
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ih0 = oh * SH - PH;
 1417              		.loc	1 335 0
 1418 1a38 00000000 		ldl.sx	%s19,0(%s55,%s59)	# *(kwb)
 1418      BBB71303 
 1419 1a40 00000000 		ldl.sx	%s20,0(%s55,%s57)	# *(kwe)
 1419      B9B71403 
 1420 1a48 D0FFFFFF 		brlt.w	%s19,%s20,.L3.66
 1420      94938218 
 1421 1a50 50F2FFFF 		br.l	.L3.41
 1421      00000F18 
 1422              	.L3.67:
 1423              	# line 334
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kwb[ow] < kwe[ow] && khb[oh] < khe[oh] ) {
 1424              		.loc	1 334 0
 1425 1a58 00000000 		ldu	%s63,0(%s60,%s61)	# float
 1425      BDBC3F02 
 1426 1a60 00000000 		or	%s51,0,%s62
 1426      BE003345 
 1427 1a68 00000000 		stu	%s63,0(%s55,%s56)	# *(d)
 1427      B8B73F12 
 1428 1a70 B8FFFFFF 		br.l	.L3.18
 1428      00000F18 
 1429              	.L3.37:
 1430 1a78 E0FFFFFF 		brne.w	0,%s18,.L3.67
 1430      92008318 
 1431 1a80 20EEFFFF 		br.l	.L3.17
 1431      00000F18 
 1432              	.L3.68:
 1433 1a88 E8FCFFFF 		st	%s19,-792(,%fp)	# spill 
 1433      89001311 
 1434 1a90 E0FCFFFF 		st	%s56,-800(,%fp)	# spill 
 1434      89003811 
 1435 1a98 D8FCFFFF 		st	%s62,-808(,%fp)	# spill 
 1435      89003E11 
 1436 1aa0 D0FCFFFF 		st	%s55,-816(,%fp)	# spill 
 1436      89003711 
 1437 1aa8 C8FCFFFF 		st	%s53,-824(,%fp)	# spill 
 1437      89003511 
 1438 1ab0 C0FCFFFF 		st	%s51,-832(,%fp)	# spill 
 1438      89003311 
 1439 1ab8 B8FCFFFF 		st	%s50,-840(,%fp)	# spill 
 1439      89003211 
 1440 1ac0 B0FCFFFF 		st	%s63,-848(,%fp)	# spill 
 1440      89003F11 
 1441 1ac8 A8FCFFFF 		st	%s46,-856(,%fp)	# spill 
 1441      89002E11 
 1442 1ad0 A0FCFFFF 		st	%s35,-864(,%fp)	# spill 
 1442      89002311 
 1443 1ad8 98FCFFFF 		st	%s34,-872(,%fp)	# spill 
 1443      89002211 
 1444 1ae0 90FCFFFF 		st	%s5,-880(,%fp)	# spill 
 1444      89000511 
 1445 1ae8 88FCFFFF 		st	%s2,-888(,%fp)	# spill 
 1445      89000211 
 1446 1af0 80FCFFFF 		st	%s33,-896(,%fp)	# spill 
 1446      89002111 
 1447 1af8 78FCFFFF 		st	%s20,-904(,%fp)	# spill 
 1447      89001411 
 1448 1b00 70FCFFFF 		st	%s60,-912(,%fp)	# spill 
 1448      89003C11 
 1449 1b08 68FCFFFF 		st	%s49,-920(,%fp)	# spill 
 1449      89003111 
 1450 1b10 60FCFFFF 		st	%s32,-928(,%fp)	# spill 
 1450      89002011 
 1451 1b18 58FCFFFF 		st	%s31,-936(,%fp)	# spill 
 1451      89001F11 
 1452 1b20 00000000 		divs.w.sx	%s46,%s63,%s46
 1452      AEBF2E7B 
 1453 1b28 00000000 		or	%s46,0,%s46
 1453      AE002E45 
 1454 1b30 00000000 		addu.l	%s35,%s46,%s35
 1454      A3AE2348 
 1455 1b38 00000000 		addu.l	%s35,%s35,%s39
 1455      A7A32348 
 1456 1b40 00000000 		mulu.l	%s34,%s35,%s34
 1456      A2A32249 
 1457 1b48 00000000 		divu.l	%s2,%s5,%s2
 1457      8285026F 
 1458 1b50 00000000 		addu.l	%s2,%s39,%s2
 1458      82A70248 
 1459 1b58 00000000 		mulu.l	%s2,4,%s2
 1459      82040249 
 1460 1b60 00000000 		or	%s63,0,%s50
 1460      B2003F45 
 1461 1b68 00000000 		addu.l	%s63,%s34,%s63
 1461      BFA23F48 
 1462 1b70 00000000 		mulu.l	%s33,%s63,%s33
 1462      A1BF2149 
 1463 1b78 00000000 		or	%s33,0,%s33
 1463      A1002145 
 1464              	# line 330
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1465              		.loc	1 330 0
 1466 1b80 00000000 		muls.l	%s33,4,%s33
 1466      A104216E 
 1467              	# line 335
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ih0 = oh * SH - PH;
 1468              		.loc	1 335 0
 1469 1b88 00000000 		dldl.sx	%s63,0(%s51,%s20)	# *(khe)
 1469      94B33F0B 
 1470 1b90 00000000 		dldl.sx	%s50,0(%s51,%s60)	# *(khb)
 1470      BCB3320B 
 1471              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 1472              		.loc	1 340 0
 1473 1b98 00000000 		dldl.sx	%s20,0(%s51,%s20)	# *(khe)
 1473      94B3140B 
 1474 1ba0 00000000 		dldl.sx	%s30,0(%s51,%s60)	# *(khb)
 1474      BCB31E0B 
 1475 1ba8 00000000 		or	%s60,0,%s2
 1475      82003C45 
 1476 1bb0 00000000 		subs.w.sx	%s21,%s20,%s30
 1476      9E94155A 
 1477 1bb8 00000000 		subs.w.sx	%s29,0,%s21
 1477      95001D5A 
 1478 1bc0 00000000 		and	%s22,%s21,(62)0
 1478      7E951644 
 1479 1bc8 00000000 		subs.w.sx	%s51,0,%s22
 1479      9600335A 
 1480              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1481              		.loc	1 348 0
 1482 1bd0 00000000 		adds.w.sx	%s25,3,%s30
 1482      9E03194A 
 1483 1bd8 00000000 		adds.w.sx	%s26,2,%s30
 1483      9E021A4A 
 1484              	# line 330
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1485              		.loc	1 330 0
 1486 1be0 00000000 		adds.l	%s56,%s33,%s49
 1486      B1A13859 
 1487 1be8 00000000 		or	%s62,0,%s32
 1487      A0003E45 
 1488 1bf0 00000000 		or	%s46,0,(0)1
 1488      00002E45 
 1489 1bf8 00000000 		or	%s53,0,%s31
 1489      9F003545 
 1490              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 1491              		.loc	1 340 0
 1492 1c00 00000000 		muls.w.sx	%s35,%s30,%s3
 1492      839E234B 
 1493 1c08 C8FCFFFF 		ld	%s34,-824(,%fp)	# restore 
 1493      89002201 
 1494 1c10 00000000 		or	%s49,0,%s63
 1494      BF003145 
 1495 1c18 00000000 		or	%s32,0,%s51
 1495      B3002045 
 1496 1c20 00000000 		adds.w.sx	%s31,%s34,%s35
 1496      A3A21F4A 
 1497 1c28 00000000 		adds.w.sx	%s28,%s55,%s35
 1497      A3B71C4A 
 1498 1c30 00000000 		muls.w.sx	%s63,%s26,%s3
 1498      839A3F4B 
 1499 1c38 00000000 		or	%s55,0,%s46
 1499      AE003745 
 1500 1c40 00000000 		adds.w.sx	%s23,%s34,%s63
 1500      BFA2174A 
 1501 1c48 00000000 		muls.w.sx	%s63,%s25,%s3
 1501      83993F4B 
 1502 1c50 00000000 		adds.w.sx	%s4,%s34,%s63
 1502      BFA2044A 
 1503 1c58 00000000 		adds.w.sx	%s24,1,%s30
 1503      9E01184A 
 1504 1c60 18FEFFFF 		br.l	.L3.37
 1504      00000F18 
 1505              	.L3.34:
 1506 1c68 20FEFFFF 		brlt.w	0,%s19,.L3.68
 1506      93008218 
 1507 1c70 E8EEFFFF 		br.l	.L3.33
 1507      00000F18 
 1508              	.L3.69:
 1509 1c78 50FCFFFF 		st	%s21,-944(,%fp)	# spill 
 1509      89001511 
 1510 1c80 48FCFFFF 		st	%s62,-952(,%fp)	# spill 
 1510      89003E11 
 1511 1c88 40FCFFFF 		st	%s55,-960(,%fp)	# spill 
 1511      89003711 
 1512 1c90 38FCFFFF 		st	%s4,-968(,%fp)	# spill 
 1512      89000411 
 1513 1c98 30FCFFFF 		st	%s30,-976(,%fp)	# spill 
 1513      89001E11 
 1514 1ca0 28FCFFFF 		st	%s29,-984(,%fp)	# spill 
 1514      89001D11 
 1515 1ca8 00000000 		or	%s39,0,%s55
 1515      B7002745 
 1516 1cb0 00000000 		or	%s62,0,%s4
 1516      84003E45 
 1517 1cb8 00000000 		or	%s55,0,%s30
 1517      9E003745 
 1518 1cc0 00000000 		or	%s53,0,%s29
 1518      9D003545 
 1519              	# line 329
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1520              		.loc	1 329 0
 1521 1cc8 00000000 		or	%s51,0,(0)1
 1521      00003345 
 1522 1cd0 98FFFFFF 		br.l	.L3.34
 1522      00000F18 
 1523              	.L3.31:
 1524 1cd8 00000000 		or	%s50,0,(0)1
 1524      00003245 
 1525 1ce0 98FFFFFF 		brlt.w	0,%s21,.L3.69
 1525      95008218 
 1526 1ce8 18EEFFFF 		br.l	.L3.30
 1526      00000F18 
 1527              	.L3.70:
 1528 1cf0 20FCFFFF 		st	%s22,-992(,%fp)	# spill 
 1528      89001611 
 1529 1cf8 18FCFFFF 		st	%s62,-1000(,%fp)	# spill 
 1529      89003E11 
 1530 1d00 10FCFFFF 		st	%s50,-1008(,%fp)	# spill 
 1530      89003211 
 1531 1d08 08FCFFFF 		st	%s53,-1016(,%fp)	# spill 
 1531      89003511 
 1532 1d10 00FCFFFF 		st	%s39,-1024(,%fp)	# spill 
 1532      89002711 
 1533 1d18 F8FBFFFF 		st	%s45,-1032(,%fp)	# spill 
 1533      89002D11 
 1534 1d20 F0FBFFFF 		st	%s51,-1040(,%fp)	# spill 
 1534      89003311 
 1535 1d28 E8FBFFFF 		st	%s28,-1048(,%fp)	# spill 
 1535      89001C11 
 1536 1d30 00000000 		or	%s35,0,%s51
 1536      B3002345 
 1537 1d38 00000000 		or	%s45,0,%s45
 1537      AD002D45 
 1538 1d40 00000000 		or	%s39,0,%s39
 1538      A7002745 
 1539 1d48 68FDFFFF 		st	%s39,-664(,%fp)	# spill 
 1539      89002711 
 1540 1d50 00000000 		or	%s62,0,%s28
 1540      9C003E45 
 1541 1d58 80FFFFFF 		br.l	.L3.31
 1541      00000F18 
 1542              	.L3.28:
 1543              	# line 328
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 1544              		.loc	1 328 0
 1545 1d60 00000000 		or	%s55,0,(0)1
 1545      00003745 
 1546 1d68 88FFFFFF 		brlt.w	0,%s22,.L3.70
 1546      96008218 
 1547 1d70 18EDFFFF 		br.l	.L3.27
 1547      00000F18 
 1548              	.L3.71:
 1549 1d78 E0FBFFFF 		st	%s23,-1056(,%fp)	# spill 
 1549      89001711 
 1550 1d80 D8FBFFFF 		st	%s55,-1064(,%fp)	# spill 
 1550      89003711 
 1551 1d88 D0FBFFFF 		st	%s45,-1072(,%fp)	# spill 
 1551      89002D11 
 1552 1d90 80FDFFFF 		st	%s33,-640(,%fp)	# spill 
 1552      89002111 
 1553 1d98 C8FBFFFF 		st	%s62,-1080(,%fp)	# spill 
 1553      89003E11 
 1554 1da0 C0FBFFFF 		st	%s41,-1088(,%fp)	# spill 
 1554      89002911 
 1555 1da8 B8FBFFFF 		st	%s35,-1096(,%fp)	# spill 
 1555      89002311 
 1556 1db0 B0FBFFFF 		st	%s39,-1104(,%fp)	# spill 
 1556      89002711 
 1557 1db8 A8FBFFFF 		st	%s51,-1112(,%fp)	# spill 
 1557      89003311 
 1558 1dc0 A0FBFFFF 		st	%s26,-1120(,%fp)	# spill 
 1558      89001A11 
 1559 1dc8 00000000 		or	%s5,0,%s51
 1559      B3000545 
 1560 1dd0 00000000 		or	%s41,0,%s39
 1560      A7002945 
 1561 1dd8 00000000 		or	%s27,0,%s35
 1561      A3001B45 
 1562 1de0 00000000 		or	%s62,0,%s26
 1562      9A003E45 
 1563              	# line 327
 327:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OCOG; ++oc) {
 1564              		.loc	1 327 0
 1565 1de8 00000000 		or	%s51,0,(0)1
 1565      00003345 
 1566 1df0 00000000 		or	%s45,0,(0)1
 1566      00002D45 
 1567 1df8 00000000 		or	%s39,0,(0)1
 1567      00002745 
 1568 1e00 00000000 		or	%s33,0,%s25
 1568      99002145 
 1569 1e08 58FFFFFF 		br.l	.L3.28
 1569      00000F18 
 1570              	.L3.25:
 1571 1e10 68FFFFFF 		brlt.w	0,%s23,.L3.71
 1571      97008218 
 1572 1e18 C8EBFFFF 		br.l	.L3.24
 1572      00000F18 
 1573              	.L3.72:
 1574 1e20 04000000 		dldl.sx	%s5,4(,%s23)	# *(p).__b_N4conv6desc_tE.mb
 1574      9700050B 
 1575 1e28 00000000 		or	%s3,0,%s60
 1575      BC000345 
 1576 1e30 00000000 		subs.w.sx	%s0,0,%s5
 1576      8500005A 
 1577              	# line 326
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1578              		.loc	1 326 0
 1579 1e38 00000000 		or	%s51,0,(0)1
 1579      00003345 
 1580 1e40 00000000 		or	%s39,0,(0)1
 1580      00002745 
 1581 1e48 00000000 		or	%s35,0,(0)1
 1581      00002345 
 1582 1e50 00000000 		or	%s2,0,%s46
 1582      AE000245 
 1583 1e58 00000000 		subs.w.sx	%s27,0,%s46
 1583      AE001B5A 
 1584 1e60 00000000 		or	%s62,0,%s27
 1584      9B003E45 
 1585              	# line 329
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1586              		.loc	1 329 0
 1587 1e68 18000000 		dldl.sx	%s27,24(,%s23)	# *(p).__b_N4conv6desc_tE.oh
 1587      97001B0B 
 1588 1e70 00000000 		or	%s34,0,%s27
 1588      9B002245 
 1589 1e78 00000000 		subs.w.sx	%s4,0,%s27
 1589      9B00045A 
 1590              	# line 330
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1591              		.loc	1 330 0
 1592 1e80 1C000000 		dldl.sx	%s24,28(,%s23)	# *(p).__b_N4conv6desc_tE.ow
 1592      9700180B 
 1593 1e88 00000000 		or	%s25,0,%s24
 1593      98001945 
 1594 1e90 00000000 		subs.w.sx	%s32,0,%s24
 1594      9800205A 
 1595              	# line 334
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kwb[ow] < kwe[ow] && khb[oh] < khe[oh] ) {
 1596              		.loc	1 334 0
 1597 1e98 14000000 		dldl.sx	%s55,20(,%s23)	# *(p).__b_N4conv6desc_tE.oc
 1597      9700370B 
 1598 1ea0 00000000 		or	%s63,0,%s55
 1598      B7003F45 
 1599 1ea8 00000000 		or	%s53,0,%s63
 1599      BF003545 
 1600 1eb0 A8010000 		dld	%s49,424(,%s26)	# *(dst_m).data_
 1600      9A003109 
 1601 1eb8 00000000 		or	%s26,0,%s0
 1601      80001A45 
 1602 1ec0 48000000 		dldl.zx	%s0,72(,%s23)	# *(p).dir
 1602      9700800B 
 1603 1ec8 00000000 		adds.w.sx	%s0,0,%s0
 1603      8000004A 
 1604 1ed0 04000000 		lea	%s63,4
 1604      00003F06 
 1605 1ed8 00000000 		and	%s18,%s0,%s63
 1605      BF801244 
 1606              	# line 335
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ih0 = oh * SH - PH;
 1607              		.loc	1 335 0
 1608 1ee0 B0FFFFFF 		dld	%s59,-80(,%fp)	# kwb
 1608      89003B09 
 1609 1ee8 F0FFFFFF 		dld	%s57,-16(,%fp)	# kwe
 1609      89003909 
 1610              	# line 334
 334:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kwb[ow] < kwe[ow] && khb[oh] < khe[oh] ) {
 1611              		.loc	1 334 0
 1612 1ef0 A8010000 		dld	%s61,424(,%s21)	# *(bia_m).data_
 1612      95003D09 
 1613 1ef8 00000000 		or	%s21,0,%s27
 1613      9B001545 
 1614              	# line 335
 335:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ih0 = oh * SH - PH;
 1615              		.loc	1 335 0
 1616 1f00 30FEFFFF 		dld	%s0,-464(,%fp)	# khb
 1616      89000009 
 1617 1f08 E0FFFFFF 		dld	%s27,-32(,%fp)	# khe
 1617      89001B09 
 1618              	# line 353
 353:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 d = 0.f;
 1619              		.loc	1 353 0
 1620 1f10 5C000000 		dldl.zx	%s63,92(,%s23)	# *(p).merge
 1620      9700BF0B 
 1621 1f18 00000000 		adds.w.sx	%s52,0,%s63
 1621      BF00344A 
 1622              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 1623              		.loc	1 340 0
 1624 1f20 28000000 		dldl.sx	%s56,40(,%s23)	# *(p).__b_N4conv6desc_tE.sh
 1624      9700380B 
 1625 1f28 30000000 		dldl.sx	%s63,48(,%s23)	# *(p).__b_N4conv6desc_tE.ph
 1625      97003F0B 
 1626              	# line 329
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1627              		.loc	1 329 0
 1628 1f30 00000000 		subs.w.sx	%s29,0,%s63
 1628      BF001D5A 
 1629              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 1630              		.loc	1 340 0
 1631 1f38 2C000000 		dldl.sx	%s54,44(,%s23)	# *(p).__b_N4conv6desc_tE.sw
 1631      9700360B 
 1632 1f40 00000000 		or	%s50,0,%s54
 1632      B6003245 
 1633              	# line 330
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1634              		.loc	1 330 0
 1635 1f48 00000000 		muls.l	%s54,4,%s50
 1635      B204366E 
 1636              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 1637              		.loc	1 340 0
 1638 1f50 34000000 		dldl.sx	%s50,52(,%s23)	# *(p).__b_N4conv6desc_tE.pw
 1638      9700320B 
 1639 1f58 00000000 		or	%s48,0,%s50
 1639      B2003045 
 1640              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1641              		.loc	1 343 0
 1642 1f60 A8010000 		dld	%s7,424(,%s19)	# *(s$47).data_
 1642      93000709 
 1643              	# line 326
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1644              		.loc	1 326 0
 1645 1f68 00000000 		or	%s50,0,(0)1
 1645      00003245 
 1646 1f70 00000000 		or	%s47,0,(0)1
 1646      00002F45 
 1647 1f78 00000000 		or	%s33,0,(0)1
 1647      00002145 
 1648              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1649              		.loc	1 343 0
 1650 1f80 A8010000 		dld	%s6,424(,%s20)	# *(s$48).data_
 1650      94000609 
 1651 1f88 00000000 		or	%s19,0,%s24
 1651      98001345 
 1652              	# line 348
 348:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 1653              		.loc	1 348 0
 1654 1f90 08000000 		dldl.sx	%s45,8(,%s23)	# *(p).__b_N4conv6desc_tE.ic
 1654      97002D0B 
 1655 1f98 00000000 		or	%s20,0,%s27
 1655      9B001445 
 1656 1fa0 00000000 		or	%s38,0,%s45
 1656      AD002645 
 1657 1fa8 00000000 		or	%s27,0,%s50
 1657      B2001B45 
 1658 1fb0 00000000 		or	%s50,0,%s38
 1658      A6003245 
 1659 1fb8 00000000 		dldl.sx	%s24,0(,%s23)	# *(p).__b_N4conv6desc_tE.g
 1659      9700180B 
 1660 1fc0 00000000 		or	%s40,0,%s24
 1660      98002845 
 1661 1fc8 0C000000 		dldl.sx	%s43,12(,%s23)	# *(p).__b_N4conv6desc_tE.ih
 1661      97002B0B 
 1662 1fd0 00000000 		or	%s43,0,%s43
 1662      AB002B45 
 1663 1fd8 10000000 		dldl.sx	%s42,16(,%s23)	# *(p).__b_N4conv6desc_tE.iw
 1663      97002A0B 
 1664 1fe0 00000000 		or	%s42,0,%s42
 1664      AA002A45 
 1665 1fe8 14000000 		dldl.sx	%s41,20(,%s23)	# *(p).__b_N4conv6desc_tE.oc
 1665      9700290B 
 1666 1ff0 00000000 		or	%s37,0,%s41
 1666      A9002545 
 1667 1ff8 00000000 		or	%s41,0,%s37
 1667      A5002945 
 1668 2000 20000000 		dldl.sx	%s37,32(,%s23)	# *(p).__b_N4conv6desc_tE.kh
 1668      9700250B 
 1669 2008 00000000 		or	%s37,0,%s37
 1669      A5002545 
 1670 2010 24000000 		dldl.sx	%s36,36(,%s23)	# *(p).__b_N4conv6desc_tE.kw
 1670      9700240B 
 1671 2018 00000000 		or	%s23,0,%s5
 1671      85001745 
 1672 2020 00000000 		or	%s36,0,%s36
 1672      A4002445 
 1673              	# line 328
 328:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oh = 0; oh < OH; ++oh) {
 1674              		.loc	1 328 0
 1675 2028 00000000 		subs.w.sx	%s28,0,%s22
 1675      96001C5A 
 1676              	# line 329
 329:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int ow = 0; ow < OW; ++ow) {
 1677              		.loc	1 329 0
 1678 2030 00000000 		subs.w.sx	%s30,%s60,%s63
 1678      BFBC1E5A 
 1679              	# line 330
 330:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 1680              		.loc	1 330 0
 1681 2038 00000000 		muls.l	%s31,-4,%s48
 1681      B07C1F6E 
 1682              	# line 339
 339:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[oh]; kh < khe[oh]; ++kh) {
 1683              		.loc	1 339 0
 1684 2040 00000000 		subs.w.sx	%s5,0,%s44
 1684      AC00055A 
 1685 2048 00000000 		or	%s63,0,%s58
 1685      BA003F45 
 1686              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1687              		.loc	1 343 0
 1688 2050 00000000 		muls.l	%s1,4,%s63
 1688      BF04016E 
 1689              	# line 340
 340:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   //const int ih = oh * SH - PH + kh * DH;
 1690              		.loc	1 340 0
 1691 2058 00000000 		sla.w.sx	%s63,%s60,2
 1691      BC023F66 
 1692              	# line 343
 343:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     //const int iw = ow * SW - PW + kw * DW;
 1693              		.loc	1 343 0
 1694 2060 00000000 		sla.w.sx	%s60,%s58,2
 1694      BA023C66 
 1695 2068 78FDFFFF 		st	%s63,-648(,%fp)	# spill 
 1695      89003F11 
 1696 2070 70FDFFFF 		st	%s60,-656(,%fp)	# spill 
 1696      89003C11 
 1697 2078 00000000 		or	%s60,0,%s0
 1697      80003C45 
 1698 2080 00000000 		or	%s63,0,%s27
 1698      9B003F45 
 1699 2088 00000000 		or	%s48,0,%s47
 1699      AF003045 
 1700 2090 00000000 		or	%s47,0,%s24
 1700      98002F45 
 1701 2098 00000000 		or	%s58,0,%s5
 1701      85003A45 
 1702 20a0 70FDFFFF 		br.l	.L3.25
 1702      00000F18 
 1703              	.L3.73:
 1704              	# line 326
 326:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 1705              		.loc	1 326 0
 1706 20a8 00000000 		ldl.sx	%s46,0(,%s23)	# *(p).__b_N4conv6desc_tE.g
 1706      97002E03 
 1707 20b0 70FDFFFF 		brlt.w	0,%s46,.L3.72
 1707      AE008218 
 1708 20b8 28E8FFFF 		br.l	.L3.23
 1708      00000F18 
 1709              	.L3.74:
 1710 20c0 00000000 		or	%s23,0,%s63
 1710      BF001745 
 1711 20c8 E0FFFFFF 		br.l	.L3.73
 1711      00000F18 
 1712              	.L3.16:
 1713              	# line 320
 320:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwe[ow] = div_floor( IW - (ow * SW - PW) + p->dw, DW );
 1714              		.loc	1 320 0
 1715 20d0 34000000 		ldl.sx	%s62,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 1715      BF003E03 
 1716 20d8 3C000000 		ldl.sx	%s51,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 1716      BF003303 
 1717 20e0 00000000 		adds.w.sx	%s51,%s62,%s51
 1717      B3BE334A 
 1718 20e8 2C000000 		ldl.sx	%s62,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 1718      BF003E03 
 1719 20f0 00000000 		lvl	%s59
 1719      00BB00BF 
 1720 20f8 000E000B 		vadds.w.sx	%v11,%s61,%v14
 1720      00BD20CA 
 1721 2100 000B000A 		vmuls.w.sx	%v10,%s62,%v11
 1721      00BE20CB 
 1722 2108 000A0009 		vsubs.w.sx	%v9,%s51,%v10
 1722      00B320DA 
 1723 2110 00000908 		vdivs.w.sx	%v8,%v9,%s58
 1723      00BA10EB 
 1724 2118 00080007 		vmuls.w.sx	%v7,%s58,%v8
 1724      00BA20CB 
 1725 2120 00070906 		vsubs.w.sx	%v6,%v9,%v7
 1725      000000DA 
 1726 2128 0006050F 		vfmk.w.ge	%vm15,%v6
 1726      000000B5 
 1727 2130 0000000D 		vbrd	%v13,0,%vm15
 1727      00000F8C 
 1728 2138 00000F0F 		negm	%vm15,%vm15
 1728      00000095 
 1729 2140 0000000D 		vbrd	%v13,1,%vm15
 1729      00010F8C 
 1730 2148 34000000 		ldl.sx	%s62,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 1730      BF003E03 
 1731 2150 3C000000 		ldl.sx	%s51,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 1731      BF003303 
 1732 2158 00000000 		adds.w.sx	%s51,%s62,%s51
 1732      B3BE334A 
 1733 2160 2C000000 		ldl.sx	%s62,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 1733      BF003E03 
 1734 2168 000E0005 		vadds.w.sx	%v5,%s61,%v14
 1734      00BD20CA 
 1735 2170 00050004 		vmuls.w.sx	%v4,%s62,%v5
 1735      00BE20CB 
 1736 2178 00040003 		vsubs.w.sx	%v3,%s51,%v4
 1736      00B320DA 
 1737 2180 00000302 		vdivs.w.sx	%v2,%v3,%s58
 1737      00BA10EB 
 1738 2188 000D0201 		vsubs.w.sx	%v1,%v2,%v13
 1738      000000DA 
 1739 2190 00000000 		adds.l	%s62,%s57,(0)1
 1739      00B93E59 
 1740 2198 00000000 		adds.l	%s51,%s62,%s56
 1740      B8BE3359 
 1741 21a0 00000001 		vstl.nc	%v1,4,%s51
 1741      B3040093 
 1742              	# line 321
 321:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( kwb[ow] < 0  ) kwb[ow] = 0;
 1743              		.loc	1 321 0
 1744 21a8 34000000 		ldl.sx	%s51,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 1744      BF003303 
 1745 21b0 3C000000 		ldl.sx	%s50,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 1745      BF003203 
 1746 21b8 2C000000 		ldl.sx	%s49,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 1746      BF003103 
 1747 21c0 000E0000 		vadds.w.sx	%v0,%s61,%v14
 1747      00BD20CA 
 1748 21c8 0000003E 		vmuls.w.sx	%v62,%s49,%v0
 1748      00B120CB 
 1749 21d0 10000000 		ldl.sx	%s49,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 1749      BF003103 
 1750 21d8 00000000 		adds.w.sx	%s49,%s51,%s49
 1750      B1B3314A 
 1751 21e0 00000000 		adds.w.sx	%s49,%s50,%s49
 1751      B1B2314A 
 1752 21e8 003E003D 		vsubs.w.sx	%v61,%s49,%v62
 1752      00B120DA 
 1753 21f0 00003D3F 		vdivs.w.sx	%v63,%v61,%s58
 1753      00BA10EB 
 1754 21f8 003F003B 		vmuls.w.sx	%v59,%s58,%v63
 1754      00BA20CB 
 1755 2200 003B3D3A 		vsubs.w.sx	%v58,%v61,%v59
 1755      000000DA 
 1756 2208 003A050F 		vfmk.w.ge	%vm15,%v58
 1756      000000B5 
 1757 2210 0000000C 		vbrd	%v12,0,%vm15
 1757      00000F8C 
 1758 2218 00000F0F 		negm	%vm15,%vm15
 1758      00000095 
 1759 2220 0000000C 		vbrd	%v12,1,%vm15
 1759      00010F8C 
 1760 2228 10000000 		ldl.sx	%s51,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 1760      BF003303 
 1761 2230 34000000 		ldl.sx	%s50,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 1761      BF003203 
 1762 2238 00000000 		adds.w.sx	%s50,%s51,%s50
 1762      B2B3324A 
 1763 2240 3C000000 		ldl.sx	%s51,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 1763      BF003303 
 1764 2248 00000000 		adds.w.sx	%s51,%s50,%s51
 1764      B3B2334A 
 1765 2250 2C000000 		ldl.sx	%s50,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 1765      BF003203 
 1766 2258 000E0039 		vadds.w.sx	%v57,%s61,%v14
 1766      00BD20CA 
 1767 2260 00390038 		vmuls.w.sx	%v56,%s50,%v57
 1767      00B220CB 
 1768 2268 00380037 		vsubs.w.sx	%v55,%s51,%v56
 1768      00B320DA 
 1769 2270 00003736 		vdivs.w.sx	%v54,%v55,%s58
 1769      00BA10EB 
 1770 2278 000C3635 		vsubs.w.sx	%v53,%v54,%v12
 1770      000000DA 
 1771 2280 00000000 		adds.l	%s51,%s55,(0)1
 1771      00B73359 
 1772 2288 00000000 		adds.l	%s50,%s51,%s56
 1772      B8B33259 
 1773 2290 00000035 		vstl.nc	%v53,4,%s50
 1773      B2040093 
 1774              	# line 322
 322:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( kwe[ow] > KW ) kwe[ow] = KW;
 1775              		.loc	1 322 0
 1776 2298 00000000 		adds.l	%s50,%s62,%s56
 1776      B8BE3259 
 1777 22a0 00000034 		vldl.sx.nc	%v52,4,%s50
 1777      B2040083 
 1778 22a8 00340033 		vmaxs.w.sx	%v51,0,%v52
 1778      0000208A 
 1779 22b0 00000000 		adds.l	%s62,%s62,%s56
 1779      B8BE3E59 
 1780 22b8 00000033 		vstl.nc	%v51,4,%s62
 1780      BE040093 
 1781              	# line 323
 323:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 1782              		.loc	1 323 0
 1783 22c0 00000000 		adds.l	%s62,%s51,%s56
 1783      B8B33E59 
 1784 22c8 00000032 		vldl.sx.nc	%v50,4,%s62
 1784      BE040083 
 1785 22d0 24000000 		ldl.sx	%s62,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 1785      BF003E03 
 1786 22d8 00320031 		vmins.w.sx	%v49,%s62,%v50
 1786      00BE308A 
 1787 22e0 00000000 		adds.l	%s51,%s51,%s56
 1787      B8B33359 
 1788 22e8 00000031 		vstl.nc	%v49,4,%s51
 1788      B3040093 
 1789              	# line 319
 319:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwb[ow] = div_floor( 0  - (ow * SW - PW) + p->dw, DW );
 1790              		.loc	1 319 0
 1791 22f0 00000000 		adds.l	%s56,%s56,%s54
 1791      B6B83859 
 1792 22f8 00000000 		adds.w.sx	%s61,%s61,%s53
 1792      B5BD3D4A 
 1793 2300 00000000 		subs.w.sx	%s52,%s52,%s59
 1793      BBB4345A 
 1794 2308 B8FDFFFF 		brge.w	0,%s52,.L3.74
 1794      B4008518 
 1795 2310 80E5FFFF 		br.l	.L3.15
 1795      00000F18 
 1796              	.L3.75:
 1797 2318 00000000 		subs.w.sx	%s18,0,%s18
 1797      9200125A 
 1798 2320 00000000 		or	%s63,0,%s23
 1798      97003F45 
 1799 2328 00000000 		subs.w.sx	%s18,0,%s18
 1799      9200125A 
 1800 2330 00000000 		smvl	%s62
 1800      00003E2E 
 1801 2338 80000000 		mins.w.sx	%s59,%s18,%s62
 1801      BE923B78 
 1802 2340 00000000 		or	%s52,0,%s18
 1802      92003445 
 1803 2348 00000000 		or	%s56,0,(0)1
 1803      00003845 
 1804 2350 00000000 		or	%s62,0,%s59
 1804      BB003E45 
 1805 2358 00000000 		muls.l	%s54,4,%s62
 1805      BE04366E 
 1806 2360 00000000 		or	%s61,0,(0)1
 1806      00003D45 
 1807 2368 00000000 		or	%s53,0,%s59
 1807      BB003545 
 1808 2370 00000000 		lvl	%s59
 1808      00BB00BF 
 1809 2378 0000003C 		vseq	%v60
 1809      00000099 
 1810 2380 003C000E 		vor	%v14,(0)1,%v60
 1810      000020C5 
 1811 2388 48FDFFFF 		br.l	.L3.16
 1811      00000F18 
 1812              	.L3.76:
 1813 2390 1C000000 		ldl.sx	%s18,28(,%s23)	# *(p).__b_N4conv6desc_tE.ow
 1813      97001203 
 1814 2398 B0FFFFFF 		ld	%s57,-80(,%fp)	# kwb
 1814      89003901 
 1815 23a0 F0FFFFFF 		ld	%s55,-16(,%fp)	# kwe
 1815      89003701 
 1816 23a8 70FFFFFF 		brlt.w	0,%s18,.L3.75
 1816      92008218 
 1817 23b0 F8FCFFFF 		br.l	.L3.73
 1817      00000F18 
 1818              	.L3.77:
 1819 23b8 00000000 		or	%s23,0,%s63
 1819      BF001745 
 1820 23c0 00000000 		or	%s58,0,%s49
 1820      B1003A45 
 1821 23c8 C8FFFFFF 		br.l	.L3.76
 1821      00000F18 
 1822              	.L3.14:
 1823              	# line 314
 314:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     khe[oh] = div_floor( IH - (oh * SH - PH) + p->dh, DH );
 1824              		.loc	1 314 0
 1825 23d0 30000000 		ldl.sx	%s62,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 1825      BF003E03 
 1826 23d8 38000000 		ldl.sx	%s52,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 1826      BF003403 
 1827 23e0 00000000 		adds.w.sx	%s52,%s62,%s52
 1827      B4BE344A 
 1828 23e8 28000000 		ldl.sx	%s62,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 1828      BF003E03 
 1829 23f0 00000000 		lvl	%s59
 1829      00BB00BF 
 1830 23f8 002B0028 		vadds.w.sx	%v40,%s61,%v43
 1830      00BD20CA 
 1831 2400 00280027 		vmuls.w.sx	%v39,%s62,%v40
 1831      00BE20CB 
 1832 2408 00270026 		vsubs.w.sx	%v38,%s52,%v39
 1832      00B420DA 
 1833 2410 00002625 		vdivs.w.sx	%v37,%v38,%s60
 1833      00BC10EB 
 1834 2418 00250024 		vmuls.w.sx	%v36,%s60,%v37
 1834      00BC20CB 
 1835 2420 00242623 		vsubs.w.sx	%v35,%v38,%v36
 1835      000000DA 
 1836 2428 0023050F 		vfmk.w.ge	%vm15,%v35
 1836      000000B5 
 1837 2430 0000002A 		vbrd	%v42,0,%vm15
 1837      00000F8C 
 1838 2438 00000F0F 		negm	%vm15,%vm15
 1838      00000095 
 1839 2440 0000002A 		vbrd	%v42,1,%vm15
 1839      00010F8C 
 1840 2448 30000000 		ldl.sx	%s62,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 1840      BF003E03 
 1841 2450 38000000 		ldl.sx	%s52,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 1841      BF003403 
 1842 2458 00000000 		adds.w.sx	%s52,%s62,%s52
 1842      B4BE344A 
 1843 2460 28000000 		ldl.sx	%s62,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 1843      BF003E03 
 1844 2468 002B0022 		vadds.w.sx	%v34,%s61,%v43
 1844      00BD20CA 
 1845 2470 00220021 		vmuls.w.sx	%v33,%s62,%v34
 1845      00BE20CB 
 1846 2478 00210020 		vsubs.w.sx	%v32,%s52,%v33
 1846      00B420DA 
 1847 2480 0000201F 		vdivs.w.sx	%v31,%v32,%s60
 1847      00BC10EB 
 1848 2488 002A1F1E 		vsubs.w.sx	%v30,%v31,%v42
 1848      000000DA 
 1849 2490 00000000 		adds.l	%s62,%s58,(0)1
 1849      00BA3E59 
 1850 2498 00000000 		adds.l	%s52,%s62,%s57
 1850      B9BE3459 
 1851 24a0 0000001E 		vstl.nc	%v30,4,%s52
 1851      B4040093 
 1852              	# line 315
 315:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( khb[oh] < 0  ) khb[oh] = 0;
 1853              		.loc	1 315 0
 1854 24a8 30000000 		ldl.sx	%s52,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 1854      BF003403 
 1855 24b0 38000000 		ldl.sx	%s51,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 1855      BF003303 
 1856 24b8 28000000 		ldl.sx	%s50,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 1856      BF003203 
 1857 24c0 002B001D 		vadds.w.sx	%v29,%s61,%v43
 1857      00BD20CA 
 1858 24c8 001D001C 		vmuls.w.sx	%v28,%s50,%v29
 1858      00B220CB 
 1859 24d0 0C000000 		ldl.sx	%s50,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 1859      BF003203 
 1860 24d8 00000000 		adds.w.sx	%s50,%s52,%s50
 1860      B2B4324A 
 1861 24e0 00000000 		adds.w.sx	%s50,%s51,%s50
 1861      B2B3324A 
 1862 24e8 001C001B 		vsubs.w.sx	%v27,%s50,%v28
 1862      00B220DA 
 1863 24f0 00001B1A 		vdivs.w.sx	%v26,%v27,%s60
 1863      00BC10EB 
 1864 24f8 001A0019 		vmuls.w.sx	%v25,%s60,%v26
 1864      00BC20CB 
 1865 2500 00191B18 		vsubs.w.sx	%v24,%v27,%v25
 1865      000000DA 
 1866 2508 0018050F 		vfmk.w.ge	%vm15,%v24
 1866      000000B5 
 1867 2510 00000029 		vbrd	%v41,0,%vm15
 1867      00000F8C 
 1868 2518 00000F0F 		negm	%vm15,%vm15
 1868      00000095 
 1869 2520 00000029 		vbrd	%v41,1,%vm15
 1869      00010F8C 
 1870 2528 0C000000 		ldl.sx	%s52,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 1870      BF003403 
 1871 2530 30000000 		ldl.sx	%s51,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 1871      BF003303 
 1872 2538 00000000 		adds.w.sx	%s51,%s52,%s51
 1872      B3B4334A 
 1873 2540 38000000 		ldl.sx	%s52,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 1873      BF003403 
 1874 2548 00000000 		adds.w.sx	%s52,%s51,%s52
 1874      B4B3344A 
 1875 2550 28000000 		ldl.sx	%s51,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 1875      BF003303 
 1876 2558 002B0017 		vadds.w.sx	%v23,%s61,%v43
 1876      00BD20CA 
 1877 2560 00170016 		vmuls.w.sx	%v22,%s51,%v23
 1877      00B320CB 
 1878 2568 00160015 		vsubs.w.sx	%v21,%s52,%v22
 1878      00B420DA 
 1879 2570 00001514 		vdivs.w.sx	%v20,%v21,%s60
 1879      00BC10EB 
 1880 2578 00291413 		vsubs.w.sx	%v19,%v20,%v41
 1880      000000DA 
 1881 2580 00000000 		adds.l	%s52,%s56,(0)1
 1881      00B83459 
 1882 2588 00000000 		adds.l	%s51,%s52,%s57
 1882      B9B43359 
 1883 2590 00000013 		vstl.nc	%v19,4,%s51
 1883      B3040093 
 1884              	# line 316
 316:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( khe[oh] > KH ) khe[oh] = KH;
 1885              		.loc	1 316 0
 1886 2598 00000000 		adds.l	%s51,%s62,%s57
 1886      B9BE3359 
 1887 25a0 00000012 		vldl.sx.nc	%v18,4,%s51
 1887      B3040083 
 1888 25a8 00120011 		vmaxs.w.sx	%v17,0,%v18
 1888      0000208A 
 1889 25b0 00000000 		adds.l	%s62,%s62,%s57
 1889      B9BE3E59 
 1890 25b8 00000011 		vstl.nc	%v17,4,%s62
 1890      BE040093 
 1891              	# line 317
 317:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 1892              		.loc	1 317 0
 1893 25c0 00000000 		adds.l	%s62,%s52,%s57
 1893      B9B43E59 
 1894 25c8 00000010 		vldl.sx.nc	%v16,4,%s62
 1894      BE040083 
 1895 25d0 20000000 		ldl.sx	%s62,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 1895      BF003E03 
 1896 25d8 0010000F 		vmins.w.sx	%v15,%s62,%v16
 1896      00BE308A 
 1897 25e0 00000000 		adds.l	%s52,%s52,%s57
 1897      B9B43459 
 1898 25e8 0000000F 		vstl.nc	%v15,4,%s52
 1898      B4040093 
 1899              	# line 311
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // trick to easy calc of kh, kw loop limits is that division must
 1900              		.loc	1 311 0
 1901 25f0 00000000 		adds.l	%s57,%s57,%s55
 1901      B7B93959 
 1902 25f8 00000000 		adds.w.sx	%s61,%s61,%s54
 1902      B6BD3D4A 
 1903 2600 00000000 		subs.w.sx	%s53,%s53,%s59
 1903      BBB5355A 
 1904 2608 B0FDFFFF 		brge.w	0,%s53,.L3.77
 1904      B5008518 
 1905 2610 70E2FFFF 		br.l	.L3.13
 1905      00000F18 
 1906              	.L3.78:
 1907 2618 00000000 		subs.w.sx	%s18,0,%s18
 1907      9200125A 
 1908 2620 00000000 		or	%s63,0,%s23
 1908      97003F45 
 1909 2628 00000000 		subs.w.sx	%s18,0,%s18
 1909      9200125A 
 1910 2630 00000000 		smvl	%s52
 1910      0000342E 
 1911 2638 80000000 		mins.w.sx	%s59,%s18,%s52
 1911      B4923B78 
 1912 2640 00000000 		or	%s53,0,%s18
 1912      92003545 
 1913 2648 00000000 		or	%s57,0,(0)1
 1913      00003945 
 1914 2650 00000000 		or	%s52,0,%s59
 1914      BB003445 
 1915 2658 00000000 		muls.l	%s55,4,%s52
 1915      B404376E 
 1916 2660 00000000 		or	%s61,0,(0)1
 1916      00003D45 
 1917 2668 00000000 		or	%s54,0,%s59
 1917      BB003645 
 1918 2670 00000000 		lvl	%s59
 1918      00BB00BF 
 1919 2678 00000030 		vseq	%v48
 1919      00000099 
 1920 2680 00000000 		or	%s49,0,%s58
 1920      BA003145 
 1921 2688 00000000 		or	%s58,0,%s62
 1921      BE003A45 
 1922 2690 0030002B 		vor	%v43,(0)1,%v48
 1922      000020C5 
 1923 2698 38FDFFFF 		br.l	.L3.14
 1923      00000F18 
 1924              	.L3.12:
 1925              	# line 303
 303:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int khe[OH] alignas(64);
 1926              		.loc	1 303 0
 1927 26a0 18000000 		ldl.sx	%s62,24(,%s63)	# *(p).__b_N4conv6desc_tE.oh
 1927      BF003E03 
 1928 26a8 00000000 		or	%s23,0,%s63
 1928      BF001745 
 1929 26b0 00000000 		or	%s62,0,%s62
 1929      BE003E45 
 1930 26b8 30FEFFFF 		lea	%s61,-464
 1930      00003D06 
 1931 26c0 00000000 		adds.l	%s24,%fp,%s61
 1931      BD891859 
 1932 26c8 00000000 		muls.l	%s0,4,%s62
 1932      BE04006E 
 1933 26d0 00000000 		lea	%s12,__grow_stack@LO
 1933      00000C06 
 1934 26d8 00000000 		and	%s12,%s12,(32)0
 1934      608C0C44 
 1935 26e0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1935      8C008C06 
 1936 26e8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1936      8C000A08 
 1937 26f0 D0000000 		lea	%s62,208
 1937      00003E06 
 1938 26f8 00000000 		adds.l	%s62,%sp,%s62
 1938      BE8B3E59 
 1939 2700 00000000 		lea	%s61,0
 1939      00003D06 
 1940 2708 00000000 		st	%s62,0(,%s24)
 1940      98003E11 
 1941 2710 30FEFFFF 		ld	%s62,-464(,%fp)	# khb
 1941      89003E01 
 1942 2718 B8FFFFFF 		st	%s62,-72(,%fp)
 1942      89003E11 
 1943 2720 00000000 		lea	%s24,__eh_curr_region@LO
 1943      00001806 
 1944 2728 00000000 		and	%s24,%s24,(32)0
 1944      60981844 
 1945 2730 00000000 		lea.sl	%s24,__eh_curr_region@HI(,%s24)
 1945      98009806 
 1946 2738 00000000 		st2b	%s61,0(,%s24)
 1946      98003D14 
 1947              	# line 304
 304:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int kwb[OW] alignas(64);
 1948              		.loc	1 304 0
 1949 2740 18000000 		ldl.sx	%s62,24(,%s23)	# *(p).__b_N4conv6desc_tE.oh
 1949      97003E03 
 1950 2748 00000000 		or	%s62,0,%s62
 1950      BE003E45 
 1951 2750 00000000 		adds.l	%s25,%fp,(59)1
 1951      3B891959 
 1952 2758 00000000 		muls.l	%s0,4,%s62
 1952      BE04006E 
 1953 2760 00000000 		lea	%s12,__grow_stack@LO
 1953      00000C06 
 1954 2768 00000000 		and	%s12,%s12,(32)0
 1954      608C0C44 
 1955 2770 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1955      8C008C06 
 1956 2778 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1956      8C000A08 
 1957 2780 D0000000 		lea	%s62,208
 1957      00003E06 
 1958 2788 00000000 		adds.l	%s62,%sp,%s62
 1958      BE8B3E59 
 1959 2790 00000000 		st	%s62,0(,%s25)
 1959      99003E11 
 1960 2798 E0FFFFFF 		ld	%s62,-32(,%fp)	# khe
 1960      89003E01 
 1961 27a0 C0FFFFFF 		lea	%s61,-64
 1961      00003D06 
 1962 27a8 00000000 		st	%s62,0(%s61,%fp)
 1962      89BD3E11 
 1963 27b0 00000000 		or	%s62,1,(0)1
 1963      00013E45 
 1964 27b8 00000000 		st2b	%s62,0(,%s24)
 1964      98003E14 
 1965              	# line 305
 305:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int kwe[OW] alignas(64);
 1966              		.loc	1 305 0
 1967 27c0 1C000000 		ldl.sx	%s62,28(,%s23)	# *(p).__b_N4conv6desc_tE.ow
 1967      97003E03 
 1968 27c8 00000000 		or	%s62,0,%s62
 1968      BE003E45 
 1969 27d0 B0FFFFFF 		lea	%s61,-80
 1969      00003D06 
 1970 27d8 00000000 		adds.l	%s25,%fp,%s61
 1970      BD891959 
 1971 27e0 00000000 		muls.l	%s0,4,%s62
 1971      BE04006E 
 1972 27e8 00000000 		lea	%s12,__grow_stack@LO
 1972      00000C06 
 1973 27f0 00000000 		and	%s12,%s12,(32)0
 1973      608C0C44 
 1974 27f8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1974      8C008C06 
 1975 2800 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1975      8C000A08 
 1976 2808 D0000000 		lea	%s62,208
 1976      00003E06 
 1977 2810 00000000 		adds.l	%s62,%sp,%s62
 1977      BE8B3E59 
 1978 2818 00000000 		st	%s62,0(,%s25)
 1978      99003E11 
 1979 2820 B0FFFFFF 		ld	%s62,-80(,%fp)	# kwb
 1979      89003E01 
 1980 2828 C8FFFFFF 		lea	%s61,-56
 1980      00003D06 
 1981 2830 00000000 		st	%s62,0(%s61,%fp)
 1981      89BD3E11 
 1982 2838 00000000 		or	%s62,2,(0)1
 1982      00023E45 
 1983 2840 00000000 		st2b	%s62,0(,%s24)
 1983      98003E14 
 1984              	# line 306
 306:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int ICOG = IC / G;
 1985              		.loc	1 306 0
 1986 2848 1C000000 		ldl.sx	%s62,28(,%s23)	# *(p).__b_N4conv6desc_tE.ow
 1986      97003E03 
 1987 2850 00000000 		or	%s62,0,%s62
 1987      BE003E45 
 1988 2858 00000000 		adds.l	%s25,%fp,(60)1
 1988      3C891959 
 1989 2860 00000000 		muls.l	%s0,4,%s62
 1989      BE04006E 
 1990 2868 00000000 		lea	%s12,__grow_stack@LO
 1990      00000C06 
 1991 2870 00000000 		and	%s12,%s12,(32)0
 1991      608C0C44 
 1992 2878 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 1992      8C008C06 
 1993 2880 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 1993      8C000A08 
 1994 2888 D0000000 		lea	%s62,208
 1994      00003E06 
 1995 2890 00000000 		adds.l	%s62,%sp,%s62
 1995      BE8B3E59 
 1996 2898 00000000 		st	%s62,0(,%s25)
 1996      99003E11 
 1997 28a0 F0FFFFFF 		ld	%s62,-16(,%fp)	# kwe
 1997      89003E01 
 1998 28a8 D0FFFFFF 		lea	%s61,-48
 1998      00003D06 
 1999 28b0 00000000 		st	%s62,0(%s61,%fp)
 1999      89BD3E11 
 2000 28b8 00000000 		or	%s62,3,(0)1
 2000      00033E45 
 2001 28c0 00000000 		st2b	%s62,0(,%s24)
 2001      98003E14 
 2002              	# line 307
 307:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int OCOG = OC / G;
 2003              		.loc	1 307 0
 2004 28c8 00000000 		ldl.sx	%s62,0(,%s23)	# *(p).__b_N4conv6desc_tE.g
 2004      97003E03 
 2005 28d0 08000000 		ldl.sx	%s61,8(,%s23)	# *(p).__b_N4conv6desc_tE.ic
 2005      97003D03 
 2006 28d8 00000000 		divs.w.sx	%s44,%s61,%s62
 2006      BEBD2C7B 
 2007              	# line 308
 308:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DH   = p->dh + 1;
 2008              		.loc	1 308 0
 2009 28e0 14000000 		ldl.sx	%s59,20(,%s23)	# *(p).__b_N4conv6desc_tE.oc
 2009      97003B03 
 2010 28e8 00000000 		divs.w.sx	%s22,%s59,%s62
 2010      BEBB167B 
 2011              	# line 309
 309:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DW   = p->dw + 1;
 2012              		.loc	1 309 0
 2013 28f0 38000000 		ldl.sx	%s61,56(,%s23)	# *(p).__b_N4conv6desc_tE.dh
 2013      97003D03 
 2014 28f8 00000000 		adds.w.sx	%s60,1,%s61
 2014      BD013C4A 
 2015              	# line 310
 310:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int oh = 0; oh < OH; ++oh) {
 2016              		.loc	1 310 0
 2017 2900 3C000000 		ldl.sx	%s62,60(,%s23)	# *(p).__b_N4conv6desc_tE.dw
 2017      97003E03 
 2018 2908 00000000 		adds.w.sx	%s58,1,%s62
 2018      BE013A4A 
 2019              	# line 311
 311:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // trick to easy calc of kh, kw loop limits is that division must
 2020              		.loc	1 311 0
 2021 2910 18000000 		ldl.sx	%s18,24(,%s23)	# *(p).__b_N4conv6desc_tE.oh
 2021      97001203 
 2022 2918 30FEFFFF 		ld	%s62,-464(,%fp)	# khb
 2022      89003E01 
 2023 2920 E0FFFFFF 		ld	%s56,-32(,%fp)	# khe
 2023      89003801 
 2024 2928 F0FCFFFF 		brlt.w	0,%s18,.L3.78
 2024      92008218 
 2025 2930 60FAFFFF 		br.l	.L3.76
 2025      00000F18 
 2026              	.L3.10:
 2027 2938 38000000 		lea	%s61,56
 2027      00003D06 
 2028              	# line 240
 240:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 2029              		.loc	1 240 0
 2030 2940 00000000 		sll	%s62,%s62,%s61
 2030      BEBD3E65 
 2031 2948 38000000 		lea	%s61,56
 2031      00003D06 
 2032 2950 00000000 		sra.l	%s62,%s62,%s61
 2032      BEBD3E77 
 2033 2958 00000000 		or	%s62,0,%s62
 2033      BE003E45 
 2034 2960 00000000 		lea	%s61,.LP.__string.5@LO
 2034      00003D06 
 2035 2968 00000000 		and	%s61,%s61,(32)0
 2035      60BD3D44 
 2036 2970 00000000 		lea.sl	%s61,.LP.__string.5@HI(,%s61)
 2036      BD00BD06 
 2037 2978 00000000 		lea	%s60,.LP.__13_ref_conv3_cpp_bbff7ae7.0.__unnamed.0@LO
 2037      00003C06 
 2038 2980 00000000 		and	%s60,%s60,(32)0
 2038      60BC3C44 
 2039 2988 00000000 		lea.sl	%s60,.LP.__13_ref_conv3_cpp_bbff7ae7.0.__unnamed.0@HI(,%s60)
 2039      BC00BC06 
 2040 2990 10FDFFFF 		brne.w	0,%s62,.L3.12
 2040      BE008318 
 2041 2998 38DEFFFF 		br.l	.L3.11
 2041      00000F18 
 2042              	.L3.79:
 2043 29a0 00000000 		or	%s62,1,(0)1
 2043      00013E45 
 2044 29a8 00000000 		or	%s19,0,%s1
 2044      81001345 
 2045 29b0 00000000 		or	%s20,0,%s2
 2045      82001445 
 2046 29b8 00000000 		or	%s21,0,%s3
 2046      83001545 
 2047 29c0 00000000 		or	%s26,0,%s4
 2047      84001A45 
 2048 29c8 70FFFFFF 		br.l	.L3.10
 2048      00000F18 
 2049              	.L3.80:
 2050 29d0 2C000000 		ldl.sx	%s18,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 2050      BF001203 
 2051 29d8 C8FFFFFF 		brle.w	0,%s18,.L3.79
 2051      92008618 
 2052 29e0 C0DDFFFF 		br.l	.L3.9
 2052      00000F18 
 2053              	.L3.8:
 2054 29e8 28000000 		ldl.sx	%s18,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 2054      BF001203 
 2055 29f0 E0FFFFFF 		brle.w	0,%s18,.L3.80
 2055      92008618 
 2056 29f8 A8DDFFFF 		br.l	.L3.9
 2056      00000F18 
 2057              	.L3.6:
 2058 2a00 38000000 		lea	%s61,56
 2058      00003D06 
 2059              	# line 239
 239:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   MUST( SH >= 0 && SW >= 0 );
 2060              		.loc	1 239 0
 2061 2a08 00000000 		sll	%s62,%s62,%s61
 2061      BEBD3E65 
 2062 2a10 38000000 		lea	%s61,56
 2062      00003D06 
 2063 2a18 00000000 		sra.l	%s62,%s62,%s61
 2063      BEBD3E77 
 2064 2a20 00000000 		or	%s62,0,%s62
 2064      BE003E45 
 2065 2a28 00000000 		lea	%s61,.LP.__string.3@LO
 2065      00003D06 
 2066 2a30 00000000 		and	%s61,%s61,(32)0
 2066      60BD3D44 
 2067 2a38 00000000 		lea.sl	%s61,.LP.__string.3@HI(,%s61)
 2067      BD00BD06 
 2068 2a40 00000000 		lea	%s60,.LP.__13_ref_conv3_cpp_bbff7ae7.0.__unnamed.0@LO
 2068      00003C06 
 2069 2a48 00000000 		and	%s60,%s60,(32)0
 2069      60BC3C44 
 2070 2a50 00000000 		lea.sl	%s60,.LP.__13_ref_conv3_cpp_bbff7ae7.0.__unnamed.0@HI(,%s60)
 2070      BC00BC06 
 2071 2a58 90FFFFFF 		brne.w	0,%s62,.L3.8
 2071      BE008318 
 2072 2a60 50DCFFFF 		br.l	.L3.7
 2072      00000F18 
 2073              	.L3.81:
 2074 2a68 00000000 		or	%s62,1,(0)1
 2074      00013E45 
 2075 2a70 90FFFFFF 		br.l	.L3.6
 2075      00000F18 
 2076              	.L3.82:
 2077 2a78 3C000000 		ldl.sx	%s18,60(,%s63)	# *(p).__b_N4conv6desc_tE.dw
 2077      BF001203 
 2078 2a80 E8FFFFFF 		brle.w	0,%s18,.L3.81
 2078      92008618 
 2079 2a88 18DCFFFF 		br.l	.L3.5
 2079      00000F18 
 2080              	.L3.4:
 2081 2a90 38000000 		ldl.sx	%s18,56(,%s63)	# *(p).__b_N4conv6desc_tE.dh
 2081      BF001203 
 2082 2a98 E0FFFFFF 		brle.w	0,%s18,.L3.82
 2082      92008618 
 2083 2aa0 00DCFFFF 		br.l	.L3.5
 2083      00000F18 
 2084              	.L3.2:
 2085 2aa8 38000000 		lea	%s61,56
 2085      00003D06 
 2086              	# line 238
 238:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   MUST( p->dh >= 0 && p->dw >= 0 );
 2087              		.loc	1 238 0
 2088 2ab0 00000000 		sll	%s62,%s62,%s61
 2088      BEBD3E65 
 2089 2ab8 38000000 		lea	%s61,56
 2089      00003D06 
 2090 2ac0 00000000 		sra.l	%s62,%s62,%s61
 2090      BEBD3E77 
 2091 2ac8 00000000 		or	%s62,0,%s62
 2091      BE003E45 
 2092 2ad0 00000000 		lea	%s61,.LP.__string.1@LO
 2092      00003D06 
 2093 2ad8 00000000 		and	%s61,%s61,(32)0
 2093      60BD3D44 
 2094 2ae0 00000000 		lea.sl	%s61,.LP.__string.1@HI(,%s61)
 2094      BD00BD06 
 2095 2ae8 00000000 		lea	%s60,.LP.__13_ref_conv3_cpp_bbff7ae7.0.__unnamed.0@LO
 2095      00003C06 
 2096 2af0 00000000 		and	%s60,%s60,(32)0
 2096      60BC3C44 
 2097 2af8 00000000 		lea.sl	%s60,.LP.__13_ref_conv3_cpp_bbff7ae7.0.__unnamed.0@HI(,%s60)
 2097      BC00BC06 
 2098 2b00 90FFFFFF 		brne.w	0,%s62,.L3.4
 2098      BE008318 
 2099 2b08 A8DAFFFF 		br.l	.L3.3
 2099      00000F18 
 2100              	.L3.83:
 2101 2b10 00000000 		or	%s62,1,(0)1
 2101      00013E45 
 2102 2b18 00000000 		or	%s63,0,%s0
 2102      80003F45 
 2103 2b20 88FFFFFF 		br.l	.L3.2
 2103      00000F18 
 2104              	.L3.0:
 2105 2b28 24000000 		ldl.sx	%s18,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 2105      80001203 
 2106 2b30 E0FFFFFF 		brlt.w	0,%s18,.L3.83
 2106      92008218 
 2107 2b38 60DAFFFF 		br.l	.L3.1
 2107      00000F18 
 2108              		.cfi_endproc
 2109              		.set	.L.4.2auto_size,	0xffffffffffffe6f0	# 6416 Bytes
 2111              	# ============ End  conv::refconv_3_fwd(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2112              	# ============ Begin  conv::refconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 2113              		.balign 16
 2114              	# line 424
 364:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 365:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** inline the kernel.  original guesswork did not do dilation properly.
 366:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \verbatim
 367:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * **Problem**: Find the lowest khb >= kh_beg such that
 368:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *          osh = ih+PH - khb*DH
 369:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *      AND osh % SH == 0.            i.e. osh = j*SH
 370:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *          (Then oh_beg = osh / SH)
 371:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * Diophantine: solve for unknown integers k,j ...
 372:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *    k*DH + j*SH = X,     where X = ih+PH
 373:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * \endverbatim
 374:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * - One solution is obtained via extendedEuclid Algorithm (outside of loops)
 375:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * - First we quickly check for "no possible solutions"
 376:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * - Then k is adjusted up to "just past zero"
 377:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * - and if j*SH is too big, j is adjusted to "just below OH" (and k goes up)
 378:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  *
 379:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * Here is an unoptimized sketch of the calculation
 380:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** \verbatim
 381:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** // Calc based on Diophantine equation approach (not optimized)
 382:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** int k = kh_end;
 383:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 384:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 385:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // 1. Find one soln (any)
 386:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     int const mul = (ih+PH) / gcd_h;
 387:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     k = ha*mul;
 388:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     int j = hb*mul;
 389:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( k*DH + j*SH == X );
 390:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 391:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // 2. Adjust to lowest k>=0
 392:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     int const dk = SH/gcd_h;
 393:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     int const dj = DH/gcd_h;
 394:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     int m = (k<0? (-k+ dk -1) / dk
 395:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           : k >= dk? - (k / dk)
 396:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           : 0);
 397:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if(m){
 398:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         k += m * dk;
 399:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         j -= m * dj;
 400:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 401:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( k >= 0 && k < dk);
 402:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( k*DH + j*SH == X ); // still have a soln
 403:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 404:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // 3. Adjust j downwards st. j*SH < OH*SH (k can go up even more)
 405:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( j >= OH ){
 406:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         m = (j-OH) / dj + 1;
 407:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         k += m * dk;
 408:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         j -= m * dj;
 409:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         DMUST( j < OH );
 410:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         DMUST( j >= OH - (DH/gcd_h) );
 411:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         DMUST( k*DH + j*SH == X ); // still have a soln
 412:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 413:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     DMUST( j*SH < OH*SH );
 414:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 415:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 416:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** kh_beg = k;
 417:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** \endverbatim
 418:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * Discovering such formulas <em>by guesswork</em> did not work out
 419:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * well for me at all !
 420:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  */
 421:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** //static
 422:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** void refconv_3_bwd_d_generic(const prb_t *p, dnn_mem_t &diff_src_m,
 423:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m)
 424:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** {
 2115              		.loc	1 424 0
 2116              		.globl	conv::refconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 2118              	conv::refconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 2119              		.cfi_startproc
 2120 2b40 00000000 		st	%fp,0x0(,%sp)
 2120      8B000911 
 2121              		.cfi_def_cfa_offset	0
 2122              		.cfi_offset	9,0
 2123 2b48 08000000 		st	%lr,0x8(,%sp)
 2123      8B000A11 
 2124 2b50 18000000 		st	%got,0x18(,%sp)
 2124      8B000F11 
 2125 2b58 20000000 		st	%plt,0x20(,%sp)
 2125      8B001011 
 2126 2b60 00000000 		or	%fp,0,%sp
 2126      8B000945 
 2127              		.cfi_def_cfa_register	9
 2128 2b68 30000000 		st	%s18,48(,%fp)
 2128      89001211 
 2129 2b70 38000000 		st	%s19,56(,%fp)
 2129      89001311 
 2130 2b78 40000000 		st	%s20,64(,%fp)
 2130      89001411 
 2131 2b80 48000000 		st	%s21,72(,%fp)
 2131      89001511 
 2132 2b88 50000000 		st	%s22,80(,%fp)
 2132      89001611 
 2133 2b90 58000000 		st	%s23,88(,%fp)
 2133      89001711 
 2134 2b98 60000000 		st	%s24,96(,%fp)
 2134      89001811 
 2135 2ba0 68000000 		st	%s25,104(,%fp)
 2135      89001911 
 2136 2ba8 70000000 		st	%s26,112(,%fp)
 2136      89001A11 
 2137 2bb0 78000000 		st	%s27,120(,%fp)
 2137      89001B11 
 2138 2bb8 80000000 		st	%s28,128(,%fp)
 2138      89001C11 
 2139 2bc0 88000000 		st	%s29,136(,%fp)
 2139      89001D11 
 2140 2bc8 90000000 		st	%s30,144(,%fp)
 2140      89001E11 
 2141 2bd0 98000000 		st	%s31,152(,%fp)
 2141      89001F11 
 2142 2bd8 A0000000 		st	%s32,160(,%fp)
 2142      89002011 
 2143 2be0 A8000000 		st	%s33,168(,%fp)
 2143      89002111 
 2144 2be8 00FCFFFF 		lea	%s13,.L.5.2auto_size&0xffffffff
 2144      00000D06 
 2145 2bf0 00000000 		and	%s13,%s13,(32)0
 2145      608D0D44 
 2146 2bf8 FFFFFFFF 		lea.sl	%sp,.L.5.2auto_size>>32(%fp,%s13)
 2146      8D898B06 
 2147 2c00 48000000 		brge.l.t	%sp,%sl,.L4.EoP
 2147      888B3518 
 2148 2c08 18000000 		ld	%s61,0x18(,%tp)
 2148      8E003D01 
 2149 2c10 00000000 		or	%s62,0,%s0
 2149      80003E45 
 2150 2c18 3B010000 		lea	%s63,0x13b
 2150      00003F06 
 2151 2c20 00000000 		shm.l	%s63,0x0(%s61)
 2151      BD033F31 
 2152 2c28 08000000 		shm.l	%sl,0x8(%s61)
 2152      BD030831 
 2153 2c30 10000000 		shm.l	%sp,0x10(%s61)
 2153      BD030B31 
 2154 2c38 00000000 		monc
 2154      0000003F 
 2155 2c40 00000000 		or	%s0,0,%s62
 2155      BE000045 
 2156              	.L4.EoP:
 2157              	# End of prologue codes
 2158              	# line 568
 425:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0 // shorten, do same for kw,ow loop. tweaks to kh calc
 426:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const KH = p->kh;
 427:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const OH = OH;
 428:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const DH = p->dh + 1;
 429:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const SH = SH;
 430:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const PH = PH;
 431:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int gcd_h = gcd( SH, DH );
 432:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
 433:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int khh = lcm_h / DH;
 434:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 435:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int jhh = lcm_h / SH;
 436:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int ha, hb, hg;
 437:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
 438:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 439:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( hg == gcd_h );
 440:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 441:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const KW = p->kh;
 442:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const DW = p->dw + 1;
 443:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const SW = SW;
 444:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const OW = OW;
 445:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const PW = PW;
 446:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int gcd_w = gcd( SW, DW );
 447:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //const int lcm_w = lcm( SW, DW );
 448:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int lcm_w = SW * DW/gcd_w;
 449:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int kww = lcm_w / DW;
 450:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int jww = lcm_w / SW;
 451:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int wa, wb, wg;
 452:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
 453:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( wg == gcd_w );
 454:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   OMP(parallel for collapse(5))//;
 455:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int g = 0; g < G; ++g) {
 456:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 457:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 458:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 459:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           // calc kh_beg, kh_end here? 4.28x
 460:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 461:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 462:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 463:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             ds = 0;
 464:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 465:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kh_end = (ih + PH) / DH + 1;
 466:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kh_end > KH) kh_end = KH;
 467:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kh_beg = kh_end;
 468:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 469:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               // 1. Find one soln (any)
 470:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int const mul = (ih+PH) / gcd_h;
 471:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kh_beg = ha*mul;
 472:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int j = hb*mul;
 473:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               // 2. Adjust to lowest kh_beg>=0
 474:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0 // ok
 475:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = (kh_beg<0? (-kh_beg+ khh -1) / khh
 476:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   : kh_beg >= khh? - (kh_beg / khh)
 477:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   : 0);
 478:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               RT_ASSERT( kh_beg + m*khh == rem_floor( kh_beg, khh ) ); // adjust kh_beg in khh-step
 479:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               RT_ASSERT( m == (rem_floor(kh_beg,khh) - kh_beg) / khh ); // y
 480:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               RT_ASSERT( m == - div_floor(kh_beg,khh) ); // y
 481:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if(m){
 482:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   kh_beg += m * khh;
 483:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   j -= m * jhh;
 484:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 485:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 0 // ok
 486:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int k2 = rem_floor( kh_beg, khh );
 487:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = (k2-kh_beg) / khh;
 488:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kh_beg = k2;
 489:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               j -= m * jhh;
 490:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 1 // ok
 491:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = div_floor(kh_beg, khh);
 492:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kh_beg -= m * khh;
 493:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               j      += m * jhh;
 494:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 495:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               // 3. Adjust j downwards st. j*SH < OH*SH (kh_beg can go up even more)
 496:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if( j >= OH ){
 497:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 m = (j-OH) / jhh + 1;
 498:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 kh_beg += m * khh;
 499:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //j      -= m * jhh; // not needed
 500:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 501:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 502:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kh_beg >= kh_end ) continue;
 503:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 504:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kw_beg, /*ow_beg,*/ kw_end;
 505:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             kw_end = (iw + PW) / (p->dw+1) + 1;
 506:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kw_end > KW) kw_end = KW;
 507:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             kw_beg = div_floor( (iw + PW) - OW*SW, p->dw+1) + 1;
 508:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kw_beg < 0    ) kw_beg = 0;
 509:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             { // jump kw_beg up to 1st non-skipped index
 510:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int owxsw = iw+PW - kw_beg * (p->dw+1);
 511:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (owxsw % SW){
 512:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 do {
 513:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   ++kw_beg;
 514:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   owxsw = iw+PW - kw_beg * (p->dw+1);
 515:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 } while( owxsw % SW != 0 && kw_beg < kw_end );
 516:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 DMUST( kw_beg >= kw_end || (iw+PW - kw_beg * (p->dw+1)) % SW == 0 );
 517:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 518:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 519:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             DMUST( kw_beg >= 0 );
 520:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 521:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kw_end = (iw + PW) / DW + 1;
 522:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kw_end > KW) kw_end = KW;
 523:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kw_beg = kw_end;
 524:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
 525:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int const mul = (iw+PW) / gcd_w;
 526:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kw_beg = wa*mul;
 527:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               //int j = wb*mul;
 528:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = div_floor(kw_beg, kww);
 529:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kw_beg -= m * kww;
 530:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int j = wb * mul + m * jww;
 531:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if( j >= OW ){
 532:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 m = (j-OW) / jww + 1;
 533:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 kw_beg += m * kww;
 534:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //j -= m * jww; // not needed
 535:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 536:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 537:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 538:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kw_beg >= kw_end ) continue;
 539:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 540:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int oc = 0; oc < OC/G; ++oc) {
 541:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*(p->dh+1) ;
 542:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   kh < kh_end;
 543:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   oh0 -= lcm_h, kh += khh)
 544:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               {
 545:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
 546:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 547:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     ow0 -= lcm_w, kw += kww)
 548:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 {
 549:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 550:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 551:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   ds += ((float*)diff_dst_m)[dst_off]
 552:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     * ((float*)wei_m)[wei_off];
 553:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 554:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 555:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 556:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 557:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 558:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 559:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 560:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 561:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 562:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 1 // clean up
 563:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const KH = p->kh;
 564:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const OH = OH;
 565:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const DH = p->dh + 1;
 566:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const SH = SH;
 567:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const PH = PH;
 568:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const DH = p->dh + 1;
 2159              		.loc	1 568 0
 2160 2c48 38000000 		ldl.sx	%s62,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 2160      80003E03 
 2161 2c50 00000000 		or	%s4,0,%s0
 2161      80000445 
 2162 2c58 00000000 		adds.w.sx	%s61,1,%s62
 2162      BE013D4A 
 2163 2c60 00000000 		or	%s63,0,%s61
 2163      BD003F45 
 2164              	# line 569
 569:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int gcd_h = gcd( SH, DH );
 2165              		.loc	1 569 0
 2166 2c68 28000000 		ldl.sx	%s18,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 2166      80001203 
 2167 2c70 98120000 		br.l	.L4.0
 2167      00000F18 
 2168              	.L4.1:
 2169              	# line 85
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 2170              		.loc	1 85 0
 2171 2c78 00000000 		divs.w.sx	%s62,%s18,%s63
 2171      BF923E7B 
 2172 2c80 00000000 		muls.w.sx	%s62,%s63,%s62
 2172      BEBF3E4B 
 2173 2c88 00000000 		subs.w.sx	%s18,%s18,%s62
 2173      BE92125A 
 2174 2c90 78120000 		br.l	.L4.0
 2174      00000F18 
 2175              	.L4.2:
 2176 2c98 00000000 		or	%s5,0,%s18
 2176      92000545 
 2177 2ca0 00000000 		or	%s0,0,%s4
 2177      84000045 
 2178 2ca8 00000000 		or	%s4,0,%s1
 2178      81000445 
 2179 2cb0 00000000 		or	%s6,0,%s2
 2179      82000645 
 2180 2cb8 C0110000 		br.l	.L4.3
 2180      00000F18 
 2181              	.L4.4:
 2182              	# line 83
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         if (b == 0) return a;
 2183              		.loc	1 83 0
 2184 2cc0 00000000 		divs.w.sx	%s62,%s63,%s18
 2184      92BF3E7B 
 2185 2cc8 00000000 		muls.w.sx	%s62,%s18,%s62
 2185      BE923E4B 
 2186 2cd0 00000000 		subs.w.sx	%s63,%s63,%s62
 2186      BEBF3F5A 
 2187 2cd8 C0FFFFFF 		breq.w	0,%s63,.L4.2
 2187      BF008418 
 2188 2ce0 98FFFFFF 		br.l	.L4.1
 2188      00000F18 
 2189              	.L4.5:
 2190              	# line 85
  85:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 2191              		.loc	1 85 0
 2192 2ce8 00000000 		divs.w.sx	%s62,%s18,%s63
 2192      BF923E7B 
 2193 2cf0 00000000 		muls.w.sx	%s62,%s63,%s62
 2193      BEBF3E4B 
 2194 2cf8 00000000 		subs.w.sx	%s18,%s18,%s62
 2194      BE92125A 
 2195 2d00 90100000 		br.l	.L4.6
 2195      00000F18 
 2196              	.L4.7:
 2197 2d08 00000000 		or	%s39,0,%s18
 2197      92002745 
 2198 2d10 00000000 		or	%s0,0,%s1
 2198      81000045 
 2199 2d18 00100000 		br.l	.L4.8
 2199      00000F18 
 2200              	.L4.9:
 2201              	# line 83
  83:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         if (b == 0) return a;
 2202              		.loc	1 83 0
 2203 2d20 00000000 		divs.w.sx	%s59,%s63,%s18
 2203      92BF3B7B 
 2204 2d28 00000000 		muls.w.sx	%s59,%s18,%s59
 2204      BB923B4B 
 2205 2d30 00000000 		subs.w.sx	%s63,%s63,%s59
 2205      BBBF3F5A 
 2206 2d38 D0FFFFFF 		breq.w	0,%s63,.L4.7
 2206      BF008418 
 2207 2d40 A8FFFFFF 		br.l	.L4.5
 2207      00000F18 
 2208              	.L4.10:
 2209              	# line 609
 570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int lcm_h = SH * DH/gcd_h; //lcm( SH, DH ) = SH*DH / gcd(SH,DH)
 571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int khh = lcm_h / DH;
 572:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int jhh = lcm_h / SH;
 574:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int ha, hb, hg;
 575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   extendedEuclid( ha, DH, hb, SH, hg);
 576:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 577:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( hg == gcd_h );
 578:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 579:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const KW = p->kh;
 580:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const SW = SW;
 581:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const OW = OW;
 582:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //int const PW = PW;
 583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int const DW = p->dw + 1;
 584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int gcd_w = gcd( SW, DW );
 585:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //const int lcm_w = lcm( SW, DW );
 586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int lcm_w = SW * DW/gcd_w;
 587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int kww = lcm_w / DW;
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int jww = lcm_w / SW;
 589:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int wa, wb, wg;
 590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   extendedEuclid( wa, DW, wb, SW, wg);
 591:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( wg == gcd_w );
 592:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   OMP(parallel for collapse(5))//;
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int g = 0; g < G; ++g) {
 594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 597:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           // calc kh_beg, kh_end here? 4.28x
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 599:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 600:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float &ds = ((float*)diff_src_m)[src_off];
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             ds = 0;
 602:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kh_end = (ih + PH) / DH + 1;
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kh_end > KH) kh_end = KH;
 605:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kh_beg = kh_end;
 606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( (ih+PH) % gcd_h == 0 ){ // Do solutions exist?
 607:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int const mul = (ih+PH) / gcd_h;
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kh_beg = ha*mul;
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = div_floor(kh_beg, khh);
 2210              		.loc	1 609 0
 2211 2d48 00000000 		or	%s38,0,(0)1
 2211      00002645 
 2212 2d50 100A0000 		br.l	.L4.11
 2212      00000F18 
 2213              	.L4.12:
 2214              	# line 622
 610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kh_beg -= m * khh;
 611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
 612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
 613:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 614:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kh_beg >= kh_end ) continue;
 615:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kw_end = (iw + PW) / DW + 1;
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kw_end > KW) kw_end = KW;
 618:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kw_beg = kw_end;
 619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( (iw+PW) % gcd_w == 0 ){ // Do solutions exist?
 620:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int const mul = (iw+PW) / gcd_w;
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kw_beg = wa * mul;
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = div_floor(kw_beg, kww);
 2215              		.loc	1 622 0
 2216 2d58 00000000 		or	%s6,0,(0)1
 2216      00000645 
 2217 2d60 00000000 		or	%s5,0,%s37
 2217      A5000545 
 2218 2d68 00000000 		or	%s37,0,%s38
 2218      A6002545 
 2219 2d70 F0050000 		br.l	.L4.13
 2219      00000F18 
 2220              	.L4.14:
 2221              	# line 634
 623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kw_beg -= m * kww;
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int j = wb * mul + m * jww;
 625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (j >= OW) kw_beg += (j-OW)/jww * kww + kww;
 626:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 627:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( kw_beg >= kw_end ) continue;
 628:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int oc = 0; oc < OC/G; ++oc) {
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
 631:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   kh < kh_end;
 632:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   oh0 -= lcm_h, kh += khh)
 633:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               {
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kw = kw_beg, ow0=iw+PW - kw_beg*(p->dw+1) ;
 2222              		.loc	1 634 0
 2223 2d78 80000000 		mins.w.sx	%s62,%s54,%s62
 2223      BEB63E78 
 2224 2d80 B8010000 		br.l	.L4.15
 2224      00000F18 
 2225              	.L4.16:
 2226 2d88 B8FFFFFF 		ld	%s63,-72(,%fp)	# restore 
 2226      89003F01 
 2227 2d90 00000000 		or	%s20,0,%s27
 2227      9B001445 
 2228 2d98 C0FFFFFF 		ld	%s58,-64(,%fp)	# restore 
 2228      89003A01 
 2229 2da0 00000000 		or	%s23,0,%s32
 2229      A0001745 
 2230 2da8 A0FFFFFF 		ld	%s56,-96(,%fp)	# restore 
 2230      89003801 
 2231 2db0 00000000 		or	%s32,0,%s28
 2231      9C002045 
 2232 2db8 B0FFFFFF 		ld	%s27,-80(,%fp)	# restore 
 2232      89001B01 
 2233 2dc0 00000000 		or	%s2,0,%s33
 2233      A1000245 
 2234 2dc8 F8FFFFFF 		ld	%s31,-8(,%fp)	# restore 
 2234      89001F01 
 2235 2dd0 F0FFFFFF 		ld	%s49,-16(,%fp)	# restore 
 2235      89003101 
 2236 2dd8 A8FFFFFF 		ld	%s28,-88(,%fp)	# restore 
 2236      89001C01 
 2237 2de0 88FFFFFF 		ld	%s4,-120(,%fp)	# restore 
 2237      89000401 
 2238 2de8 80FFFFFF 		ld	%s3,-128(,%fp)	# restore 
 2238      89000301 
 2239 2df0 E8FFFFFF 		ld	%s39,-24(,%fp)	# restore 
 2239      89002701 
 2240 2df8 E0FFFFFF 		ld	%s55,-32(,%fp)	# restore 
 2240      89003701 
 2241 2e00 D8FFFFFF 		ld	%s33,-40(,%fp)	# restore 
 2241      89002101 
 2242 2e08 98FFFFFF 		ld	%s61,-104(,%fp)	# restore 
 2242      89003D01 
 2243 2e10 D0FFFFFF 		ld	%s7,-48(,%fp)	# restore 
 2243      89000701 
 2244 2e18 C8FFFFFF 		ld	%s34,-56(,%fp)	# restore 
 2244      89002201 
 2245 2e20 90FFFFFF 		ld	%s59,-112(,%fp)	# restore 
 2245      89003B01 
 2246 2e28 B8080000 		br.l	.L4.17
 2246      00000F18 
 2247              	.L4.18:
 2248              	# line 629
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
 2249              		.loc	1 629 0
 2250 2e30 00000000 		adds.w.sx	%s55,1,%s55
 2250      B701374A 
 2251 2e38 00000000 		adds.w.sx	%s53,1,%s53
 2251      B501354A 
 2252 2e40 68030000 		brgt.w	0,%s55,.L4.19
 2252      B7008118 
 2253 2e48 40FFFFFF 		br.l	.L4.16
 2253      00000F18 
 2254              	.L4.20:
 2255 2e50 00000000 		or	%s55,0,%s21
 2255      95003745 
 2256 2e58 00000000 		or	%s53,0,%s23
 2256      97003545 
 2257 2e60 00000000 		or	%s18,0,%s22
 2257      96001245 
 2258 2e68 00000000 		or	%s58,0,%s20
 2258      94003A45 
 2259 2e70 C0FFFFFF 		br.l	.L4.18
 2259      00000F18 
 2260              	.L4.21:
 2261              	# line 643
 635:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 636:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     ow0 -= lcm_w, kw += kww)
 637:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 {
 638:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   size_t dst_off = dst_off_f(p, mb, g, oc, oh0/SH, ow0/SW);
 639:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   ds += ((float*)diff_dst_m)[dst_off]
 641:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     * ((float*)wei_m)[wei_off];
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 643:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 2262              		.loc	1 643 0
 2263 2e78 00000000 		subs.w.sx	%s63,%s63,%s62
 2263      BEBF3F5A 
 2264              	# line 630
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   kh < kh_end;
 2265              		.loc	1 630 0
 2266 2e80 00000000 		adds.w.sx	%s58,%s60,%s58
 2266      BABC3A4A 
 2267 2e88 00000000 		adds.w.sx	%s56,%s56,%s60
 2267      BCB8384A 
 2268 2e90 B8020000 		brgt.w	0,%s58,.L4.22
 2268      BA008118 
 2269 2e98 B8FFFFFF 		br.l	.L4.20
 2269      00000F18 
 2270              	.L4.23:
 2271              	# line 642
 642:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 2272              		.loc	1 642 0
 2273 2ea0 00000000 		or	%s61,1,(0)1
 2273      00013D45 
 2274 2ea8 00000000 		or	%s59,0,%s54
 2274      B6003B45 
 2275 2eb0 00000000 		lvl	%s61
 2275      00BD00BF 
 2276 2eb8 00000036 		vstu.nc	%v54,0,%s59
 2276      BB000092 
 2277 2ec0 B8FFFFFF 		br.l	.L4.21
 2277      00000F18 
 2278              	.L4.24:
 2279 2ec8 00000000 		or	%s54,0,%s4
 2279      84003645 
 2280 2ed0 00000000 		or	%s33,0,%s59
 2280      BB002145 
 2281 2ed8 00000000 		or	%s32,0,%s61
 2281      BD002045 
 2282 2ee0 00000000 		or	%s56,0,%s5
 2282      85003845 
 2283 2ee8 00000000 		or	%s58,0,%s3
 2283      83003A45 
 2284 2ef0 00000000 		or	%s60,0,%s1
 2284      81003C45 
 2285 2ef8 00000000 		or	%s62,0,%s2
 2285      82003E45 
 2286 2f00 00000000 		or	%s63,0,%s6
 2286      86003F45 
 2287              	# line 640
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     * ((float*)wei_m)[wei_off];
 2288              		.loc	1 640 0
 2289 2f08 00000000 		lvl	%s34
 2289      00A200BF 
 2290 2f10 00003D34 		vfsum.s	%v52,%v61
 2290      000080EC 
 2291 2f18 00000000 		or	%s61,1,(0)1
 2291      00013D45 
 2292 2f20 00000000 		lvl	%s61
 2292      00BD00BF 
 2293 2f28 00343636 		vfadd.s	%v54,%v54,%v52
 2293      000080CC 
 2294 2f30 70FFFFFF 		br.l	.L4.23
 2294      00000F18 
 2295              	.L4.15:
 2296 2f38 00000000 		lvl	%s62
 2296      00BE00BF 
 2297 2f40 003F003E 		vadds.w.sx	%v62,%s63,%v63
 2297      00BF20CA 
 2298 2f48 00003E3C 		vdivs.w.sx	%v60,%v62,%s61
 2298      00BD10EB 
 2299 2f50 003C003B 		vor	%v59,(0)1,%v60
 2299      000020C5 
 2300 2f58 003B003A 		vaddu.l	%v58,%s60,%v59
 2300      00BC20C8 
 2301 2f60 003A0039 		vsfa	%v57,%v58,2,%s59
 2301      BB0200D7 
 2302 2f68 00003938 		vgtu	%v56,%v57,0,0
 2302      000040A2 
 2303 2f70 00000000 		or	%s53,0,%s58
 2303      BA003545 
 2304 2f78 00000037 		vldu.nc	%v55,%s57,%s53
 2304      B5B90082 
 2305 2f80 38373D3D 		vfmad.s	%v61,%v61,%v55,%v56
 2305      000080E2 
 2306              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2307              		.loc	1 634 0
 2308 2f88 00000000 		adds.w.sx	%s63,%s63,%s56
 2308      B8BF3F4A 
 2309 2f90 00000000 		adds.l	%s58,%s58,%s55
 2309      B7BA3A59 
 2310 2f98 00000000 		subs.w.sx	%s54,%s54,%s62
 2310      BEB6365A 
 2311 2fa0 28FFFFFF 		brge.w	0,%s54,.L4.24
 2311      B6008518 
 2312 2fa8 D0FDFFFF 		br.l	.L4.14
 2312      00000F18 
 2313              	.L4.25:
 2314              	# line 640
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     * ((float*)wei_m)[wei_off];
 2315              		.loc	1 640 0
 2316 2fb0 00000000 		divs.w.sx	%s53,%s52,%s51
 2316      B3B4357B 
 2317 2fb8 00000000 		or	%s1,0,%s60
 2317      BC000145 
 2318 2fc0 00000000 		or	%s2,0,%s62
 2318      BE000245 
 2319 2fc8 00000000 		or	%s3,0,%s58
 2319      BA000345 
 2320 2fd0 00000000 		or	%s4,0,%s54
 2320      B6000445 
 2321 2fd8 00000000 		or	%s5,0,%s56
 2321      B8000545 
 2322 2fe0 00000000 		or	%s6,0,%s63
 2322      BF000645 
 2323 2fe8 00000000 		or	%s53,0,%s53
 2323      B5003545 
 2324 2ff0 00000000 		addu.l	%s53,%s53,%s50
 2324      B2B53548 
 2325 2ff8 00000000 		addu.l	%s53,%s53,%s49
 2325      B1B53548 
 2326 3000 00000000 		mulu.l	%s53,%s53,%s48
 2326      B0B53549 
 2327 3008 00000000 		divu.l	%s35,%s47,%s46
 2327      AEAF236F 
 2328 3010 00000000 		addu.l	%s35,%s49,%s35
 2328      A3B12348 
 2329 3018 00000000 		mulu.l	%s35,%s35,%s45
 2329      ADA32349 
 2330 3020 00000000 		divu.l	%s35,%s35,%s46
 2330      AEA3236F 
 2331 3028 00000000 		addu.l	%s35,%s35,%s44
 2331      ACA32348 
 2332 3030 00000000 		mulu.l	%s35,%s35,%s43
 2332      ABA32349 
 2333 3038 00000000 		divs.w.sx	%s34,%s63,%s42
 2333      AABF227B 
 2334 3040 00000000 		or	%s34,0,%s34
 2334      A2002245 
 2335 3048 00000000 		addu.l	%s34,%s53,%s34
 2335      A2B52248 
 2336 3050 00000000 		mulu.l	%s60,%s34,%s41
 2336      A9A23C49 
 2337 3058 00000000 		or	%s53,0,%s56
 2337      B8003545 
 2338 3060 00000000 		addu.l	%s53,%s35,%s53
 2338      B5A33548 
 2339 3068 00000000 		mulu.l	%s53,%s53,%s40
 2339      A8B53549 
 2340 3070 00000000 		or	%s53,0,%s53
 2340      B5003545 
 2341              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2342              		.loc	1 634 0
 2343 3078 00000000 		muls.l	%s53,4,%s53
 2343      B504356E 
 2344 3080 00000000 		adds.l	%s53,%s53,%s39
 2344      A7B53559 
 2345 3088 00000000 		subs.w.sx	%s35,0,%s38
 2345      A600235A 
 2346 3090 00000000 		smvl	%s34
 2346      0000222E 
 2347 3098 80000000 		mins.w.sx	%s62,%s35,%s34
 2347      A2A33E78 
 2348              	# line 640
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     * ((float*)wei_m)[wei_off];
 2349              		.loc	1 640 0
 2350 30a0 00000000 		or	%s7,0,(0)1
 2350      00000745 
 2351 30a8 00000000 		lvl	%s34
 2351      00A200BF 
 2352 30b0 0000003D 		vbrdu	%v61,%s7
 2352      0087808C 
 2353 30b8 00000000 		or	%s54,0,%s35
 2353      A3003645 
 2354 30c0 00000000 		or	%s35,0,%s62
 2354      BE002345 
 2355 30c8 00000000 		or	%s63,0,%s37
 2355      A5003F45 
 2356              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2357              		.loc	1 634 0
 2358 30d0 00000000 		muls.w.sx	%s56,%s36,%s62
 2358      BEA4384B 
 2359 30d8 00000000 		lvl	%s62
 2359      00BE00BF 
 2360 30e0 00000035 		vseq	%v53
 2360      00000099 
 2361 30e8 0035003F 		vmuls.w.sx	%v63,%s36,%v53
 2361      00A420CB 
 2362 30f0 00000000 		or	%s58,0,%s53
 2362      B5003A45 
 2363 30f8 00000000 		muls.l	%s55,%s57,%s35
 2363      A3B9376E 
 2364 3100 00000000 		or	%s59,0,%s33
 2364      A1003B45 
 2365 3108 00000000 		or	%s61,0,%s32
 2365      A0003D45 
 2366 3110 28FEFFFF 		br.l	.L4.15
 2366      00000F18 
 2367              	.L4.26:
 2368 3118 00000000 		or	%s55,1,(0)1
 2368      00013745 
 2369 3120 00000000 		or	%s53,0,%s54
 2369      B6003545 
 2370 3128 00000000 		lvl	%s55
 2370      00B700BF 
 2371 3130 00000036 		vldu.nc	%v54,0,%s53
 2371      B5000082 
 2372 3138 78FEFFFF 		brlt.w	0,%s18,.L4.25
 2372      92008218 
 2373 3140 60FDFFFF 		br.l	.L4.23
 2373      00000F18 
 2374              	.L4.22:
 2375 3148 D0FFFFFF 		brlt.w	0,%s18,.L4.26
 2375      92008218 
 2376 3150 28FDFFFF 		br.l	.L4.21
 2376      00000F18 
 2377              	.L4.27:
 2378 3158 00000000 		divs.w.sx	%s61,%s31,%s30
 2378      9E9F3D7B 
 2379 3160 00000000 		or	%s20,0,%s58
 2379      BA001445 
 2380 3168 00000000 		or	%s21,0,%s55
 2380      B7001545 
 2381 3170 00000000 		or	%s22,0,%s18
 2381      92001645 
 2382 3178 00000000 		or	%s23,0,%s53
 2382      B5001745 
 2383 3180 00000000 		subs.w.sx	%s38,0,%s61
 2383      BD00265A 
 2384 3188 00000000 		or	%s49,0,%s53
 2384      B5003145 
 2385              	# line 630
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   kh < kh_end;
 2386              		.loc	1 630 0
 2387 3190 00000000 		adds.w.sx	%s58,%s18,%s29
 2387      9D923A4A 
 2388 3198 00000000 		or	%s18,0,%s61
 2388      BD001245 
 2389 31a0 A8FFFFFF 		br.l	.L4.22
 2389      00000F18 
 2390              	.L4.19:
 2391 31a8 00000000 		or	%s56,0,%s18
 2391      92003845 
 2392 31b0 00000000 		or	%s63,0,%s58
 2392      BA003F45 
 2393 31b8 A0FFFFFF 		brlt.w	%s18,%s19,.L4.27
 2393      93928218 
 2394 31c0 70FCFFFF 		br.l	.L4.18
 2394      00000F18 
 2395              	.L4.28:
 2396 31c8 F8FFFFFF 		st	%s31,-8(,%fp)	# spill 
 2396      89001F11 
 2397 31d0 F0FFFFFF 		st	%s49,-16(,%fp)	# spill 
 2397      89003111 
 2398 31d8 E8FFFFFF 		st	%s39,-24(,%fp)	# spill 
 2398      89002711 
 2399 31e0 E0FFFFFF 		st	%s55,-32(,%fp)	# spill 
 2399      89003711 
 2400 31e8 D8FFFFFF 		st	%s33,-40(,%fp)	# spill 
 2400      89002111 
 2401 31f0 D0FFFFFF 		st	%s7,-48(,%fp)	# spill 
 2401      89000711 
 2402 31f8 C8FFFFFF 		st	%s34,-56(,%fp)	# spill 
 2402      89002211 
 2403 3200 C0FFFFFF 		st	%s58,-64(,%fp)	# spill 
 2403      89003A11 
 2404 3208 B8FFFFFF 		st	%s63,-72(,%fp)	# spill 
 2404      89003F11 
 2405 3210 B0FFFFFF 		st	%s27,-80(,%fp)	# spill 
 2405      89001B11 
 2406 3218 A8FFFFFF 		st	%s28,-88(,%fp)	# spill 
 2406      89001C11 
 2407 3220 A0FFFFFF 		st	%s56,-96(,%fp)	# spill 
 2407      89003811 
 2408 3228 98FFFFFF 		st	%s61,-104(,%fp)	# spill 
 2408      89003D11 
 2409 3230 90FFFFFF 		st	%s59,-112(,%fp)	# spill 
 2409      89003B11 
 2410 3238 88FFFFFF 		st	%s4,-120(,%fp)	# spill 
 2410      89000411 
 2411 3240 80FFFFFF 		st	%s3,-128(,%fp)	# spill 
 2411      89000311 
 2412 3248 00000000 		muls.w.sx	%s61,%s18,%s61
 2412      BD923D4B 
 2413 3250 00000000 		subs.w.sx	%s58,%s59,%s61
 2413      BDBB3A5A 
 2414 3258 00000000 		or	%s63,0,%s38
 2414      A6003F45 
 2415              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2416              		.loc	1 634 0
 2417 3260 00000000 		muls.w.sx	%s4,%s38,%s4
 2417      84A6044B 
 2418 3268 00000000 		subs.w.sx	%s4,%s56,%s4
 2418      84B8045A 
 2419 3270 00000000 		adds.w.sx	%s61,-1,%s53
 2419      B57F3D4A 
 2420 3278 00000000 		or	%s53,0,%s37
 2420      A5003545 
 2421 3280 00000000 		subs.w.sx	%s38,%s61,%s38
 2421      A6BD265A 
 2422 3288 00000000 		or	%s37,0,%s4
 2422      84002545 
 2423 3290 00000000 		adds.w.sx	%s31,%s38,%s30
 2423      9EA61F4A 
 2424              	# line 629
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
 2425              		.loc	1 629 0
 2426 3298 00000000 		divs.w.sx	%s61,%s28,%s27
 2426      9B9C3D7B 
 2427 32a0 00000000 		or	%s27,0,%s20
 2427      94001B45 
 2428 32a8 00000000 		or	%s28,0,%s32
 2428      A0001C45 
 2429 32b0 00000000 		subs.w.sx	%s61,0,%s61
 2429      BD003D5A 
 2430 32b8 00000000 		or	%s55,0,%s61
 2430      BD003745 
 2431              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2432              		.loc	1 634 0
 2433 32c0 00000000 		muls.l	%s63,4,%s63
 2433      BF043F6E 
 2434 32c8 00000000 		adds.l	%s39,%s63,%s3
 2434      83BF2759 
 2435 32d0 00000000 		or	%s33,0,%s2
 2435      82002145 
 2436 32d8 00000000 		or	%s32,0,%s23
 2436      97002045 
 2437 32e0 C8FEFFFF 		br.l	.L4.19
 2437      00000F18 
 2438              	.L4.29:
 2439              	# line 629
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
 2440              		.loc	1 629 0
 2441 32e8 00000000 		or	%s37,0,(0)1
 2441      00002545 
 2442 32f0 00000000 		divs.w.sx	%s21,%s28,%s27
 2442      9B9C157B 
 2443 32f8 00000000 		or	%s63,0,%s1
 2443      81003F45 
 2444 3300 C8FEFFFF 		brlt.w	0,%s21,.L4.28
 2444      95008218 
 2445 3308 D8030000 		br.l	.L4.17
 2445      00000F18 
 2446              	.L4.30:
 2447 3310 00000000 		or	%s63,0,%s1
 2447      81003F45 
 2448 3318 C8030000 		br.l	.L4.17
 2448      00000F18 
 2449              	.L4.31:
 2450 3320 F0FFFFFF 		brge.w	%s38,%s53,.L4.30
 2450      B5A68518 
 2451 3328 C0FFFFFF 		br.l	.L4.29
 2451      00000F18 
 2452              	.L4.32:
 2453              	# line 625
 625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 2454              		.loc	1 625 0
 2455 3330 00000000 		subs.w.sx	%s6,%s6,%s24
 2455      9886065A 
 2456 3338 00000000 		divs.w.sx	%s6,%s6,%s25
 2456      9986067B 
 2457 3340 00000000 		muls.w.sx	%s6,%s30,%s6
 2457      869E064B 
 2458 3348 00000000 		adds.w.sx	%s6,%s30,%s6
 2458      869E064A 
 2459 3350 00000000 		adds.w.sx	%s38,%s38,%s6
 2459      86A6264A 
 2460 3358 C8FFFFFF 		br.l	.L4.31
 2460      00000F18 
 2461              	.L4.13:
 2462              	# line 622
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kw_beg -= m * kww;
 2463              		.loc	1 622 0
 2464 3360 00000000 		divs.w.sx	%s35,%s37,%s30
 2464      9EA5237B 
 2465 3368 00000000 		subs.w.sx	%s6,%s35,%s6
 2465      86A3065A 
 2466              	# line 623
 623:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int j = wb * mul + m * jww;
 2467              		.loc	1 623 0
 2468 3370 00000000 		muls.w.sx	%s35,%s30,%s6
 2468      869E234B 
 2469 3378 00000000 		subs.w.sx	%s38,%s37,%s35
 2469      A3A5265A 
 2470              	# line 624
 624:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (j >= OW) kw_beg += (j-OW)/jww * kww + kww;
 2471              		.loc	1 624 0
 2472 3380 00000000 		muls.w.sx	%s5,%s26,%s5
 2472      859A054B 
 2473 3388 00000000 		muls.w.sx	%s6,%s6,%s25
 2473      9986064B 
 2474 3390 00000000 		adds.w.sx	%s6,%s5,%s6
 2474      8685064A 
 2475 3398 98FFFFFF 		brge.w	%s6,%s24,.L4.32
 2475      98868518 
 2476 33a0 80FFFFFF 		br.l	.L4.31
 2476      00000F18 
 2477              	.L4.33:
 2478              	# line 622
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kw_beg -= m * kww;
 2479              		.loc	1 622 0
 2480 33a8 00000000 		or	%s6,1,(0)1
 2480      00010645 
 2481 33b0 00000000 		or	%s5,0,%s37
 2481      A5000545 
 2482 33b8 00000000 		or	%s37,0,%s38
 2482      A6002545 
 2483 33c0 A0FFFFFF 		br.l	.L4.13
 2483      00000F18 
 2484              	.L4.34:
 2485              	# line 621
 621:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = div_floor(kw_beg, kww);
 2486              		.loc	1 621 0
 2487 33c8 00000000 		muls.w.sx	%s38,%s37,%s7
 2487      87A5264B 
 2488              	# line 622
 622:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kw_beg -= m * kww;
 2489              		.loc	1 622 0
 2490 33d0 00000000 		divs.w.sx	%s35,%s38,%s30
 2490      9EA6237B 
 2491 33d8 00000000 		muls.w.sx	%s35,%s30,%s35
 2491      A39E234B 
 2492 33e0 00000000 		subs.w.sx	%s35,%s38,%s35
 2492      A3A6235A 
 2493 33e8 C0FFFFFF 		brgt.w	0,%s35,.L4.33
 2493      A3008118 
 2494 33f0 68F9FFFF 		br.l	.L4.12
 2494      00000F18 
 2495              	.L4.35:
 2496              	# line 616
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kw_end > KW) kw_end = KW;
 2497              		.loc	1 616 0
 2498 33f8 00000000 		divs.w.sx	%s53,%s58,%s55
 2498      B7BA357B 
 2499 3400 00000000 		adds.w.sx	%s53,1,%s53
 2499      B501354A 
 2500              	# line 617
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kw_beg = kw_end;
 2501              		.loc	1 617 0
 2502 3408 80000000 		mins.w.sx	%s53,%s53,%s49
 2502      B1B53578 
 2503 3410 00000000 		or	%s38,0,%s53
 2503      B5002645 
 2504              	# line 619
 619:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int const mul = (iw+PW) / gcd_w;
 2505              		.loc	1 619 0
 2506 3418 00000000 		divs.w.sx	%s37,%s58,%s39
 2506      A7BA257B 
 2507 3420 00000000 		muls.w.sx	%s35,%s39,%s37
 2507      A5A7234B 
 2508 3428 00000000 		subs.w.sx	%s35,%s58,%s35
 2508      A3BA235A 
 2509 3430 98FFFFFF 		breq.w	0,%s35,.L4.34
 2509      A3008418 
 2510 3438 E8FEFFFF 		br.l	.L4.31
 2510      00000F18 
 2511              	.L4.36:
 2512              	# line 654
 644:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 645:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 646:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 647:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 648:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 649:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 650:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 651:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 652:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #error "select one"
 653:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 654:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 2513              		.loc	1 654 0
 2514              	# Start of epilogue codes
 2515 3440 30000000 		ld	%s18,48(,%fp)
 2515      89001201 
 2516 3448 38000000 		ld	%s19,56(,%fp)
 2516      89001301 
 2517 3450 40000000 		ld	%s20,64(,%fp)
 2517      89001401 
 2518 3458 48000000 		ld	%s21,72(,%fp)
 2518      89001501 
 2519 3460 50000000 		ld	%s22,80(,%fp)
 2519      89001601 
 2520 3468 58000000 		ld	%s23,88(,%fp)
 2520      89001701 
 2521 3470 60000000 		ld	%s24,96(,%fp)
 2521      89001801 
 2522 3478 68000000 		ld	%s25,104(,%fp)
 2522      89001901 
 2523 3480 70000000 		ld	%s26,112(,%fp)
 2523      89001A01 
 2524 3488 78000000 		ld	%s27,120(,%fp)
 2524      89001B01 
 2525 3490 80000000 		ld	%s28,128(,%fp)
 2525      89001C01 
 2526 3498 88000000 		ld	%s29,136(,%fp)
 2526      89001D01 
 2527 34a0 90000000 		ld	%s30,144(,%fp)
 2527      89001E01 
 2528 34a8 98000000 		ld	%s31,152(,%fp)
 2528      89001F01 
 2529 34b0 A0000000 		ld	%s32,160(,%fp)
 2529      89002001 
 2530 34b8 A8000000 		ld	%s33,168(,%fp)
 2530      89002101 
 2531 34c0 00000000 		or	%sp,0,%fp
 2531      89000B45 
 2532              		.cfi_def_cfa	11,8
 2533 34c8 18000000 		ld	%got,0x18(,%sp)
 2533      8B000F01 
 2534 34d0 20000000 		ld	%plt,0x20(,%sp)
 2534      8B001001 
 2535 34d8 08000000 		ld	%lr,0x8(,%sp)
 2535      8B000A01 
 2536 34e0 00000000 		ld	%fp,0x0(,%sp)
 2536      8B000901 
 2537 34e8 00000000 		b.l	(,%lr)
 2537      8A000F19 
 2538              	.L4.37:
 2539 34f0 50FFFFFF 		br.l	.L4.36
 2539      00000F18 
 2540              	.L4.38:
 2541 34f8 A8050000 		br.l	.L4.39
 2541      00000F18 
 2542              	.L4.40:
 2543              	# line 593
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2544              		.loc	1 593 0
 2545 3500 00000000 		adds.w.sx	%s63,1,%s63
 2545      BF013F4A 
 2546 3508 00000000 		adds.w.sx	%s53,%s59,%s53
 2546      B5BB354A 
 2547 3510 00000000 		adds.w.sx	%s52,%s58,%s52
 2547      B4BA344A 
 2548 3518 00000000 		adds.l	%s50,%s44,%s50
 2548      B2AC3259 
 2549 3520 D8FFFFFF 		brgt.w	0,%s63,.L4.38
 2549      BF008118 
 2550 3528 C8FFFFFF 		br.l	.L4.37
 2550      00000F18 
 2551              	.L4.41:
 2552 3530 90FEFFFF 		ld	%s63,-368(,%fp)	# restore 
 2552      89003F01 
 2553 3538 98FEFFFF 		ld	%s58,-360(,%fp)	# restore 
 2553      89003A01 
 2554 3540 88FEFFFF 		ld	%s50,-376(,%fp)	# restore 
 2554      89003201 
 2555 3548 A0FEFFFF 		ld	%s20,-352(,%fp)	# restore 
 2555      89001401 
 2556 3550 80FEFFFF 		ld	%s47,-384(,%fp)	# restore 
 2556      89002F01 
 2557 3558 A8FFFFFF 		br.l	.L4.40
 2557      00000F18 
 2558              	.L4.42:
 2559              	# line 594
 594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 2560              		.loc	1 594 0
 2561 3560 00000000 		adds.w.sx	%s63,1,%s63
 2561      BF013F4A 
 2562 3568 00000000 		adds.l	%s50,%s56,%s50
 2562      B2B83259 
 2563 3570 00000000 		adds.l	%s38,%s44,%s38
 2563      A6AC2659 
 2564 3578 B8040000 		brgt.w	0,%s63,.L4.43
 2564      BF008118 
 2565 3580 B0FFFFFF 		br.l	.L4.41
 2565      00000F18 
 2566              	.L4.44:
 2567 3588 D0FEFFFF 		ld	%s63,-304(,%fp)	# restore 
 2567      89003F01 
 2568 3590 C8FEFFFF 		ld	%s56,-312(,%fp)	# restore 
 2568      89003801 
 2569 3598 B0FEFFFF 		ld	%s50,-336(,%fp)	# restore 
 2569      89003201 
 2570 35a0 C0FEFFFF 		ld	%s44,-320(,%fp)	# restore 
 2570      89002C01 
 2571 35a8 B8FEFFFF 		ld	%s38,-328(,%fp)	# restore 
 2571      89002601 
 2572 35b0 A8FEFFFF 		ld	%s59,-344(,%fp)	# restore 
 2572      89003B01 
 2573 35b8 D8FEFFFF 		ld	%s20,-296(,%fp)	# restore 
 2573      89001401 
 2574 35c0 A0FFFFFF 		br.l	.L4.42
 2574      00000F18 
 2575              	.L4.45:
 2576              	# line 595
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2577              		.loc	1 595 0
 2578 35c8 00000000 		adds.w.sx	%s63,1,%s63
 2578      BF013F4A 
 2579 35d0 00000000 		adds.w.sx	%s58,1,%s58
 2579      BA013A4A 
 2580 35d8 D8030000 		brgt.w	0,%s63,.L4.46
 2580      BF008118 
 2581 35e0 A8FFFFFF 		br.l	.L4.44
 2581      00000F18 
 2582              	.L4.47:
 2583 35e8 F8FEFFFF 		ld	%s63,-264(,%fp)	# restore 
 2583      89003F01 
 2584 35f0 F0FEFFFF 		ld	%s58,-272(,%fp)	# restore 
 2584      89003A01 
 2585 35f8 00FFFFFF 		ld	%s19,-256(,%fp)	# restore 
 2585      89001301 
 2586 3600 E0FEFFFF 		ld	%s29,-288(,%fp)	# restore 
 2586      89001D01 
 2587 3608 E8FEFFFF 		ld	%s1,-280(,%fp)	# restore 
 2587      89000101 
 2588 3610 B8FFFFFF 		br.l	.L4.45
 2588      00000F18 
 2589              	.L4.48:
 2590 3618 38030000 		br.l	.L4.49
 2590      00000F18 
 2591              	.L4.50:
 2592              	# line 596
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           // calc kh_beg, kh_end here? 4.28x
 2593              		.loc	1 596 0
 2594 3620 00000000 		adds.w.sx	%s63,1,%s63
 2594      BF013F4A 
 2595 3628 00000000 		adds.w.sx	%s58,1,%s58
 2595      BA013A4A 
 2596 3630 00000000 		adds.w.sx	%s59,1,%s59
 2596      BB013B4A 
 2597 3638 00000000 		adds.w.sx	%s56,1,%s56
 2597      B801384A 
 2598 3640 D8FFFFFF 		brgt.w	0,%s63,.L4.48
 2598      BF008118 
 2599 3648 A0FFFFFF 		br.l	.L4.47
 2599      00000F18 
 2600              	.L4.51:
 2601 3650 70FFFFFF 		ld	%s63,-144(,%fp)	# restore 
 2601      89003F01 
 2602 3658 68FFFFFF 		ld	%s58,-152(,%fp)	# restore 
 2602      89003A01 
 2603 3660 60FFFFFF 		ld	%s56,-160(,%fp)	# restore 
 2603      89003801 
 2604 3668 78FFFFFF 		ld	%s18,-136(,%fp)	# restore 
 2604      89001201 
 2605 3670 50FFFFFF 		ld	%s38,-176(,%fp)	# restore 
 2605      89002601 
 2606 3678 48FFFFFF 		ld	%s37,-184(,%fp)	# restore 
 2606      89002501 
 2607 3680 40FFFFFF 		ld	%s35,-192(,%fp)	# restore 
 2607      89002301 
 2608 3688 10FFFFFF 		ld	%s34,-240(,%fp)	# restore 
 2608      89002201 
 2609 3690 38FFFFFF 		ld	%s6,-200(,%fp)	# restore 
 2609      89000601 
 2610 3698 08FFFFFF 		ld	%s32,-248(,%fp)	# restore 
 2610      89002001 
 2611 36a0 28FFFFFF 		ld	%s22,-216(,%fp)	# restore 
 2611      89001601 
 2612 36a8 20FFFFFF 		ld	%s21,-224(,%fp)	# restore 
 2612      89001501 
 2613 36b0 30FFFFFF 		ld	%s5,-208(,%fp)	# restore 
 2613      89000501 
 2614 36b8 18FFFFFF 		ld	%s54,-232(,%fp)	# restore 
 2614      89003601 
 2615 36c0 58FFFFFF 		ld	%s53,-168(,%fp)	# restore 
 2615      89003501 
 2616 36c8 58FFFFFF 		br.l	.L4.50
 2616      00000F18 
 2617              	.L4.52:
 2618 36d0 00000000 		or	%s1,0,%s63
 2618      BF000145 
 2619 36d8 00010000 		br.l	.L4.53
 2619      00000F18 
 2620              	.L4.17:
 2621              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2622              		.loc	1 598 0
 2623 36e0 00000000 		adds.w.sx	%s63,1,%s63
 2623      BF013F4A 
 2624 36e8 00000000 		adds.l	%s54,4,%s54
 2624      B6043659 
 2625 36f0 00000000 		adds.w.sx	%s58,1,%s58
 2625      BA013A4A 
 2626 36f8 00000000 		adds.w.sx	%s56,1,%s56
 2626      B801384A 
 2627 3700 D0FFFFFF 		brgt.w	0,%s63,.L4.52
 2627      BF008118 
 2628 3708 48FFFFFF 		br.l	.L4.51
 2628      00000F18 
 2629              	.L4.54:
 2630 3710 00000000 		or	%s63,0,%s1
 2630      81003F45 
 2631 3718 C8FFFFFF 		br.l	.L4.17
 2631      00000F18 
 2632              	.L4.55:
 2633 3720 F0FFFFFF 		brge.w	%s18,%s19,.L4.54
 2633      93928518 
 2634 3728 D0FCFFFF 		br.l	.L4.35
 2634      00000F18 
 2635              	.L4.56:
 2636              	# line 612
 612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 2637              		.loc	1 612 0
 2638 3730 00000000 		subs.w.sx	%s38,%s38,%s31
 2638      9FA6265A 
 2639 3738 00000000 		divs.w.sx	%s38,%s38,%s33
 2639      A1A6267B 
 2640 3740 00000000 		muls.w.sx	%s38,%s60,%s38
 2640      A6BC264B 
 2641 3748 00000000 		adds.w.sx	%s38,%s60,%s38
 2641      A6BC264A 
 2642 3750 00000000 		adds.w.sx	%s18,%s18,%s38
 2642      A692124A 
 2643 3758 C8FFFFFF 		br.l	.L4.55
 2643      00000F18 
 2644              	.L4.11:
 2645              	# line 609
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kh_beg -= m * khh;
 2646              		.loc	1 609 0
 2647 3760 00000000 		divs.w.sx	%s53,%s34,%s60
 2647      BCA2357B 
 2648 3768 00000000 		subs.w.sx	%s38,%s53,%s38
 2648      A6B5265A 
 2649              	# line 610
 610:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int j = hb * mul + m * jhh; // var j --> 'm' again
 2650              		.loc	1 610 0
 2651 3770 00000000 		muls.w.sx	%s53,%s60,%s38
 2651      A6BC354B 
 2652 3778 00000000 		subs.w.sx	%s18,%s34,%s53
 2652      B5A2125A 
 2653              	# line 611
 611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
 2654              		.loc	1 611 0
 2655 3780 00000000 		muls.w.sx	%s38,%s38,%s33
 2655      A1A6264B 
 2656 3788 00000000 		adds.w.sx	%s38,%s38,%s32
 2656      A0A6264A 
 2657 3790 A0FFFFFF 		brge.w	%s38,%s31,.L4.56
 2657      9FA68518 
 2658 3798 88FFFFFF 		br.l	.L4.55
 2658      00000F18 
 2659              	.L4.57:
 2660              	# line 609
 609:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               kh_beg -= m * khh;
 2661              		.loc	1 609 0
 2662 37a0 00000000 		or	%s38,1,(0)1
 2662      00012645 
 2663 37a8 B8FFFFFF 		br.l	.L4.11
 2663      00000F18 
 2664              	.L4.58:
 2665 37b0 00000000 		divs.w.sx	%s53,%s34,%s60
 2665      BCA2357B 
 2666 37b8 00000000 		muls.w.sx	%s53,%s60,%s53
 2666      B5BC354B 
 2667 37c0 00000000 		subs.w.sx	%s53,%s34,%s53
 2667      B5A2355A 
 2668 37c8 D8FFFFFF 		brgt.w	0,%s53,.L4.57
 2668      B5008118 
 2669 37d0 78F5FFFF 		br.l	.L4.10
 2669      00000F18 
 2670              	.L4.53:
 2671              	# line 601
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 2672              		.loc	1 601 0
 2673 37d8 00000000 		or	%s63,0,(0)1
 2673      00003F45 
 2674 37e0 00000000 		stu	%s63,0(,%s54)	# *(ds)
 2674      B6003F12 
 2675 37e8 00000000 		or	%s18,0,%s19
 2675      93001245 
 2676 37f0 C0FFFFFF 		breq.w	0,%s20,.L4.58
 2676      94008418 
 2677 37f8 28FFFFFF 		br.l	.L4.55
 2677      00000F18 
 2678              	.L4.59:
 2679 3800 78FFFFFF 		st	%s18,-136(,%fp)	# spill 
 2679      89001211 
 2680 3808 70FFFFFF 		st	%s63,-144(,%fp)	# spill 
 2680      89003F11 
 2681 3810 68FFFFFF 		st	%s58,-152(,%fp)	# spill 
 2681      89003A11 
 2682 3818 60FFFFFF 		st	%s56,-160(,%fp)	# spill 
 2682      89003811 
 2683 3820 58FFFFFF 		st	%s53,-168(,%fp)	# spill 
 2683      89003511 
 2684 3828 50FFFFFF 		st	%s38,-176(,%fp)	# spill 
 2684      89002611 
 2685 3830 48FFFFFF 		st	%s37,-184(,%fp)	# spill 
 2685      89002511 
 2686 3838 40FFFFFF 		st	%s35,-192(,%fp)	# spill 
 2686      89002311 
 2687 3840 38FFFFFF 		st	%s6,-200(,%fp)	# spill 
 2687      89000611 
 2688 3848 30FFFFFF 		st	%s5,-208(,%fp)	# spill 
 2688      89000511 
 2689 3850 28FFFFFF 		st	%s22,-216(,%fp)	# spill 
 2689      89001611 
 2690 3858 20FFFFFF 		st	%s21,-224(,%fp)	# spill 
 2690      89001511 
 2691 3860 18FFFFFF 		st	%s54,-232(,%fp)	# spill 
 2691      89003611 
 2692 3868 10FFFFFF 		st	%s34,-240(,%fp)	# spill 
 2692      89002211 
 2693 3870 08FFFFFF 		st	%s32,-248(,%fp)	# spill 
 2693      89002011 
 2694 3878 00000000 		divs.w.sx	%s53,%s53,%s27
 2694      9BB5357B 
 2695 3880 00000000 		or	%s53,0,%s53
 2695      B5003545 
 2696 3888 00000000 		addu.l	%s38,%s53,%s38
 2696      A6B52648 
 2697 3890 00000000 		addu.l	%s38,%s38,%s44
 2697      ACA62648 
 2698 3898 00000000 		mulu.l	%s37,%s38,%s37
 2698      A5A62549 
 2699 38a0 00000000 		or	%s63,0,%s56
 2699      B8003F45 
 2700 38a8 00000000 		addu.l	%s63,%s37,%s63
 2700      BFA53F48 
 2701 38b0 00000000 		mulu.l	%s35,%s63,%s35
 2701      A3BF2349 
 2702 38b8 00000000 		or	%s35,0,%s35
 2702      A3002345 
 2703              	# line 603
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kh_end > KH) kh_end = KH;
 2704              		.loc	1 603 0
 2705 38c0 00000000 		divs.w.sx	%s63,%s58,%s61
 2705      BDBA3F7B 
 2706 38c8 00000000 		adds.w.sx	%s63,1,%s63
 2706      BF013F4A 
 2707              	# line 604
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kh_beg = kh_end;
 2708              		.loc	1 604 0
 2709 38d0 80000000 		mins.w.sx	%s19,%s63,%s6
 2709      86BF1378 
 2710              	# line 630
 630:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   kh < kh_end;
 2711              		.loc	1 630 0
 2712 38d8 00000000 		subs.w.sx	%s29,0,%s19
 2712      93001D5A 
 2713              	# line 606
 606:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int const mul = (ih+PH) / gcd_h;
 2714              		.loc	1 606 0
 2715 38e0 00000000 		divs.w.sx	%s63,%s58,%s5
 2715      85BA3F7B 
 2716 38e8 00000000 		muls.w.sx	%s5,%s5,%s63
 2716      BF85054B 
 2717 38f0 00000000 		subs.w.sx	%s20,%s58,%s5
 2717      85BA145A 
 2718              	# line 608
 608:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int m = div_floor(kh_beg, khh);
 2719              		.loc	1 608 0
 2720 38f8 00000000 		muls.w.sx	%s22,%s63,%s22
 2720      96BF164B 
 2721              	# line 611
 611:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (j >= OH) kh_beg += (j-OH)/jhh * khh + khh;
 2722              		.loc	1 611 0
 2723 3900 00000000 		muls.w.sx	%s21,%s63,%s21
 2723      95BF154B 
 2724 3908 00000000 		or	%s1,0,%s54
 2724      B6000145 
 2725              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2726              		.loc	1 598 0
 2727 3910 00000000 		muls.l	%s35,4,%s35
 2727      A304236E 
 2728 3918 00000000 		adds.l	%s35,%s35,%s34
 2728      A2A32359 
 2729 3920 00000000 		or	%s34,0,%s22
 2729      96002245 
 2730 3928 00000000 		or	%s54,0,%s35
 2730      A3003645 
 2731 3930 00000000 		or	%s58,0,%s32
 2731      A0003A45 
 2732 3938 00000000 		or	%s56,0,%s32
 2732      A0003845 
 2733 3940 00000000 		or	%s32,0,%s21
 2733      95002045 
 2734 3948 90FEFFFF 		br.l	.L4.53
 2734      00000F18 
 2735              	.L4.49:
 2736 3950 B0FEFFFF 		brlt.w	0,%s18,.L4.59
 2736      92008218 
 2737 3958 C8FCFFFF 		br.l	.L4.50
 2737      00000F18 
 2738              	.L4.60:
 2739 3960 00FFFFFF 		st	%s19,-256(,%fp)	# spill 
 2739      89001311 
 2740 3968 F8FEFFFF 		st	%s63,-264(,%fp)	# spill 
 2740      89003F11 
 2741 3970 F0FEFFFF 		st	%s58,-272(,%fp)	# spill 
 2741      89003A11 
 2742 3978 E8FEFFFF 		st	%s1,-280(,%fp)	# spill 
 2742      89000111 
 2743 3980 E0FEFFFF 		st	%s29,-288(,%fp)	# spill 
 2743      89001D11 
 2744 3988 00000000 		or	%s44,0,%s58
 2744      BA002C45 
 2745 3990 00000000 		or	%s63,0,%s1
 2745      81003F45 
 2746 3998 00000000 		or	%s58,0,%s29
 2746      9D003A45 
 2747 39a0 00000000 		or	%s59,0,%s29
 2747      9D003B45 
 2748 39a8 A8FFFFFF 		br.l	.L4.49
 2748      00000F18 
 2749              	.L4.46:
 2750              	# line 596
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           // calc kh_beg, kh_end here? 4.28x
 2751              		.loc	1 596 0
 2752 39b0 00000000 		or	%s56,0,(0)1
 2752      00003845 
 2753 39b8 A8FFFFFF 		brlt.w	0,%s19,.L4.60
 2753      93008218 
 2754 39c0 08FCFFFF 		br.l	.L4.45
 2754      00000F18 
 2755              	.L4.61:
 2756 39c8 D8FEFFFF 		st	%s20,-296(,%fp)	# spill 
 2756      89001411 
 2757 39d0 D0FEFFFF 		st	%s63,-304(,%fp)	# spill 
 2757      89003F11 
 2758 39d8 C8FEFFFF 		st	%s56,-312(,%fp)	# spill 
 2758      89003811 
 2759 39e0 C0FEFFFF 		st	%s44,-320(,%fp)	# spill 
 2759      89002C11 
 2760 39e8 B8FEFFFF 		st	%s38,-328(,%fp)	# spill 
 2760      89002611 
 2761 39f0 B0FEFFFF 		st	%s50,-336(,%fp)	# spill 
 2761      89003211 
 2762 39f8 A8FEFFFF 		st	%s59,-344(,%fp)	# spill 
 2762      89003B11 
 2763              	# line 595
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2764              		.loc	1 595 0
 2765 3a00 00000000 		divs.w.sx	%s59,%s59,%s27
 2765      9BBB3B7B 
 2766 3a08 00000000 		subs.w.sx	%s59,0,%s59
 2766      BB003B5A 
 2767 3a10 00000000 		or	%s63,0,%s59
 2767      BB003F45 
 2768 3a18 00000000 		or	%s38,0,%s50
 2768      B2002645 
 2769 3a20 B8FEFFFF 		ld	%s50,-328(,%fp)	# restore 
 2769      89003201 
 2770 3a28 88FFFFFF 		br.l	.L4.46
 2770      00000F18 
 2771              	.L4.43:
 2772 3a30 00000000 		or	%s58,0,(0)1
 2772      00003A45 
 2773 3a38 90FFFFFF 		brlt.w	0,%s20,.L4.61
 2773      94008218 
 2774 3a40 20FBFFFF 		br.l	.L4.42
 2774      00000F18 
 2775              	.L4.62:
 2776 3a48 A0FEFFFF 		st	%s20,-352(,%fp)	# spill 
 2776      89001411 
 2777 3a50 98FEFFFF 		st	%s58,-360(,%fp)	# spill 
 2777      89003A11 
 2778 3a58 90FEFFFF 		st	%s63,-368(,%fp)	# spill 
 2778      89003F11 
 2779 3a60 88FEFFFF 		st	%s50,-376(,%fp)	# spill 
 2779      89003211 
 2780 3a68 80FEFFFF 		st	%s47,-384(,%fp)	# spill 
 2780      89002F11 
 2781 3a70 00000000 		divs.w.sx	%s20,%s59,%s27
 2781      9BBB147B 
 2782 3a78 00000000 		or	%s47,0,%s50
 2782      B2002F45 
 2783 3a80 80FEFFFF 		ld	%s63,-384(,%fp)	# restore 
 2783      89003F01 
 2784              	# line 594
 594:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 2785              		.loc	1 594 0
 2786 3a88 00000000 		or	%s50,0,(0)1
 2786      00003245 
 2787 3a90 00000000 		or	%s38,0,(0)1
 2787      00002645 
 2788 3a98 98FFFFFF 		br.l	.L4.43
 2788      00000F18 
 2789              	.L4.39:
 2790 3aa0 A8FFFFFF 		brlt.w	0,%s20,.L4.62
 2790      94008218 
 2791 3aa8 58FAFFFF 		br.l	.L4.40
 2791      00000F18 
 2792              	.L4.63:
 2793 3ab0 04000000 		dldl.sx	%s20,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 2793      8000140B 
 2794 3ab8 00000000 		or	%s62,0,%s2
 2794      82003E45 
 2795 3ac0 00000000 		subs.w.sx	%s47,0,%s20
 2795      94002F5A 
 2796              	# line 595
 595:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 2797              		.loc	1 595 0
 2798 3ac8 08000000 		dldl.sx	%s59,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 2798      80003B0B 
 2799 3ad0 00000000 		or	%s38,0,%s59
 2799      BB002645 
 2800 3ad8 00000000 		or	%s56,0,%s38
 2800      A6003845 
 2801              	# line 593
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2802              		.loc	1 593 0
 2803 3ae0 00000000 		or	%s50,0,(0)1
 2803      00003245 
 2804 3ae8 00000000 		subs.w.sx	%s38,0,%s27
 2804      9B00265A 
 2805 3af0 00000000 		or	%s63,0,%s38
 2805      A6003F45 
 2806              	# line 596
 596:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           // calc kh_beg, kh_end here? 4.28x
 2807              		.loc	1 596 0
 2808 3af8 0C000000 		dldl.sx	%s19,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 2808      8000130B 
 2809 3b00 00000000 		or	%s37,0,%s19
 2809      93002545 
 2810 3b08 00000000 		subs.w.sx	%s1,0,%s19
 2810      9300015A 
 2811              	# line 598
 598:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 2812              		.loc	1 598 0
 2813 3b10 10000000 		dldl.sx	%s18,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 2813      8000120B 
 2814 3b18 00000000 		or	%s35,0,%s18
 2814      92002345 
 2815 3b20 00000000 		subs.w.sx	%s54,0,%s18
 2815      9200365A 
 2816              	# line 601
 601:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 2817              		.loc	1 601 0
 2818 3b28 A8010000 		dld	%s34,424(,%s4)	# *(diff_src_m).data_
 2818      84002209 
 2819              	# line 603
 603:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kh_end > KH) kh_end = KH;
 2820              		.loc	1 603 0
 2821 3b30 30000000 		dldl.sx	%s29,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 2821      80001D0B 
 2822              	# line 604
 604:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kh_beg = kh_end;
 2823              		.loc	1 604 0
 2824 3b38 20000000 		dldl.sx	%s38,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 2824      8000260B 
 2825              	# line 612
 612:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 2826              		.loc	1 612 0
 2827 3b40 18000000 		dldl.sx	%s31,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 2827      80001F0B 
 2828              	# line 616
 616:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if (kw_end > KW) kw_end = KW;
 2829              		.loc	1 616 0
 2830 3b48 34000000 		dldl.sx	%s32,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 2830      8000200B 
 2831              	# line 617
 617:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             int kw_beg = kw_end;
 2832              		.loc	1 617 0
 2833 3b50 24000000 		dldl.sx	%s49,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 2833      8000310B 
 2834              	# line 625
 625:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 2835              		.loc	1 625 0
 2836 3b58 1C000000 		dldl.sx	%s24,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 2836      8000180B 
 2837              	# line 629
 629:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int kh = kh_beg, oh0=ih+PH - kh_beg*DH ;
 2838              		.loc	1 629 0
 2839 3b60 14000000 		dldl.sx	%s28,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 2839      80001C0B 
 2840              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2841              		.loc	1 634 0
 2842 3b68 3C000000 		dldl.sx	%s57,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 2842      8000390B 
 2843 3b70 00000000 		adds.w.sx	%s4,1,%s57
 2843      B901044A 
 2844 3b78 A8010000 		dld	%s2,424(,%s3)	# *(s$99).data_
 2844      83000209 
 2845              	# line 593
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2846              		.loc	1 593 0
 2847 3b80 00000000 		or	%s53,0,(0)1
 2847      00003545 
 2848 3b88 00000000 		or	%s52,0,(0)1
 2848      00003445 
 2849              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2850              		.loc	1 634 0
 2851 3b90 A8010000 		dld	%s3,424(,%s6)	# *(s$101).data_
 2851      86000309 
 2852 3b98 00000000 		or	%s6,0,%s38
 2852      A6000645 
 2853              	# line 640
 640:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     * ((float*)wei_m)[wei_off];
 2854              		.loc	1 640 0
 2855 3ba0 14000000 		dldl.sx	%s38,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 2855      8000260B 
 2856 3ba8 00000000 		or	%s57,0,%s38
 2856      A6003945 
 2857 3bb0 00000000 		or	%s44,0,%s57
 2857      B9002C45 
 2858 3bb8 00000000 		dldl.sx	%s51,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 2858      8000330B 
 2859 3bc0 00000000 		or	%s46,0,%s51
 2859      B3002E45 
 2860 3bc8 18000000 		dldl.sx	%s57,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 2860      8000390B 
 2861 3bd0 00000000 		or	%s48,0,%s57
 2861      B9003045 
 2862 3bd8 28000000 		dldl.sx	%s42,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 2862      80002A0B 
 2863 3be0 1C000000 		dldl.sx	%s57,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 2863      8000390B 
 2864 3be8 00000000 		or	%s41,0,%s57
 2864      B9002945 
 2865 3bf0 2C000000 		dldl.sx	%s23,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 2865      8000170B 
 2866 3bf8 08000000 		dldl.sx	%s57,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 2866      8000390B 
 2867 3c00 00000000 		or	%s45,0,%s57
 2867      B9002D45 
 2868 3c08 20000000 		dldl.sx	%s57,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 2868      8000390B 
 2869 3c10 00000000 		or	%s43,0,%s57
 2869      B9002B45 
 2870 3c18 24000000 		dldl.sx	%s0,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 2870      8000000B 
 2871 3c20 00000000 		or	%s40,0,%s0
 2871      80002845 
 2872 3c28 00000000 		or	%s0,0,%s30
 2872      9E000045 
 2873              	# line 634
 634:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     kw < kw_end;
 2874              		.loc	1 634 0
 2875 3c30 00000000 		muls.l	%s57,4,%s0
 2875      8004396E 
 2876 3c38 00000000 		subs.w.sx	%s36,0,%s58
 2876      BA00245A 
 2877 3c40 00000000 		or	%s58,0,%s38
 2877      A6003A45 
 2878 3c48 58FEFFFF 		br.l	.L4.39
 2878      00000F18 
 2879              	.L4.64:
 2880              	# line 593
 593:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 2881              		.loc	1 593 0
 2882 3c50 00000000 		ldl.sx	%s27,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 2882      80001B03 
 2883 3c58 58FEFFFF 		brlt.w	0,%s27,.L4.63
 2883      9B008218 
 2884 3c60 E0F7FFFF 		br.l	.L4.36
 2884      00000F18 
 2885              	.L4.65:
 2886 3c68 00000000 		or	%s0,0,%s1
 2886      81000045 
 2887 3c70 00000000 		or	%s58,0,%s18
 2887      92003A45 
 2888 3c78 D8FFFFFF 		br.l	.L4.64
 2888      00000F18 
 2889              	.L4.66:
 2890 3c80 00000000 		or	%s59,0,%s54
 2890      B6003B45 
 2891              	.L4.67:
 2892              	# line 590
 590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( wg == gcd_w );
 2893              		.loc	1 590 0
 2894 3c88 00000000 		divs.w.sx	%s58,%s63,%s59
 2894      BBBF3A7B 
 2895 3c90 00000000 		muls.w.sx	%s54,%s59,%s58
 2895      BABB364B 
 2896 3c98 00000000 		or	%s59,0,%s59
 2896      BB003B45 
 2897 3ca0 00000000 		subs.w.sx	%s54,%s63,%s54
 2897      B6BF365A 
 2898 3ca8 00000000 		or	%s63,0,%s59
 2898      BB003F45 
 2899 3cb0 00000000 		muls.w.sx	%s59,%s58,%s57
 2899      B9BA3B4B 
 2900 3cb8 00000000 		subs.w.sx	%s59,%s7,%s59
 2900      BB873B5A 
 2901 3cc0 00000000 		or	%s7,0,%s57
 2901      B9000745 
 2902 3cc8 00000000 		or	%s57,0,%s59
 2902      BB003945 
 2903 3cd0 00000000 		muls.w.sx	%s58,%s58,%s56
 2903      B8BA3A4B 
 2904 3cd8 00000000 		subs.w.sx	%s58,%s26,%s58
 2904      BA9A3A5A 
 2905 3ce0 00000000 		or	%s26,0,%s56
 2905      B8001A45 
 2906 3ce8 00000000 		or	%s56,0,%s58
 2906      BA003845 
 2907 3cf0 90FFFFFF 		brne.w	0,%s54,.L4.66
 2907      B6008318 
 2908 3cf8 70FFFFFF 		br.l	.L4.65
 2908      00000F18 
 2909              	.L4.68:
 2910 3d00 00000000 		or	%s1,0,%s0
 2910      80000145 
 2911 3d08 00000000 		or	%s18,0,%s58
 2911      BA001245 
 2912 3d10 78FFFFFF 		br.l	.L4.67
 2912      00000F18 
 2913              	.L4.8:
 2914              	# line 586
 586:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int kww = lcm_w / DW;
 2915              		.loc	1 586 0
 2916 3d18 2C000000 		ldl.sx	%s63,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 2916      80003F03 
 2917 3d20 00000000 		muls.w.sx	%s58,%s63,%s55
 2917      B7BF3A4B 
 2918 3d28 00000000 		or	%s59,0,%s55
 2918      B7003B45 
 2919 3d30 00000000 		divs.w.sx	%s58,%s58,%s39
 2919      A7BA3A7B 
 2920              	# line 587
 587:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int jww = lcm_w / SW;
 2921              		.loc	1 587 0
 2922 3d38 00000000 		divs.w.sx	%s30,%s58,%s55
 2922      B7BA1E7B 
 2923              	# line 588
 588:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int wa, wb, wg;
 2924              		.loc	1 588 0
 2925 3d40 00000000 		divs.w.sx	%s25,%s58,%s63
 2925      BFBA197B 
 2926              	# line 590
 590:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( wg == gcd_w );
 2927              		.loc	1 590 0
 2928 3d48 00000000 		or	%s57,1,(0)1
 2928      00013945 
 2929 3d50 00000000 		or	%s26,1,(0)1
 2929      00011A45 
 2930 3d58 00000000 		or	%s56,0,(0)1
 2930      00003845 
 2931 3d60 00000000 		or	%s7,0,(0)1
 2931      00000745 
 2932 3d68 98FFFFFF 		brne.w	0,%s55,.L4.68
 2932      B7008318 
 2933 3d70 E0FEFFFF 		br.l	.L4.64
 2933      00000F18 
 2934              	.L4.69:
 2935 3d78 00000000 		or	%s39,0,%s63
 2935      BF002745 
 2936 3d80 00000000 		or	%s0,0,%s1
 2936      81000045 
 2937 3d88 90FFFFFF 		br.l	.L4.8
 2937      00000F18 
 2938              	.L4.6:
 2939 3d90 E8FFFFFF 		breq.w	0,%s18,.L4.69
 2939      92008418 
 2940 3d98 88EFFFFF 		br.l	.L4.9
 2940      00000F18 
 2941              	.L4.70:
 2942              	# line 583
 583:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int gcd_w = gcd( SW, DW );
 2943              		.loc	1 583 0
 2944 3da0 3C000000 		ldl.sx	%s62,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 2944      80003E03 
 2945 3da8 00000000 		or	%s1,0,%s0
 2945      80000145 
 2946 3db0 00000000 		adds.w.sx	%s55,1,%s62
 2946      BE01374A 
 2947 3db8 00000000 		or	%s63,0,%s55
 2947      B7003F45 
 2948              	# line 584
 584:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //const int lcm_w = lcm( SW, DW );
 2949              		.loc	1 584 0
 2950 3dc0 2C000000 		ldl.sx	%s18,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 2950      80001203 
 2951 3dc8 C8FFFFFF 		br.l	.L4.6
 2951      00000F18 
 2952              	.L4.71:
 2953 3dd0 00000000 		or	%s0,0,%s1
 2953      81000045 
 2954 3dd8 00000000 		or	%s2,0,%s62
 2954      BE000245 
 2955 3de0 C0FFFFFF 		br.l	.L4.70
 2955      00000F18 
 2956              	.L4.72:
 2957 3de8 00000000 		or	%s59,0,%s55
 2957      B7003B45 
 2958              	.L4.73:
 2959              	# line 575
 575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 2960              		.loc	1 575 0
 2961 3df0 00000000 		divs.w.sx	%s58,%s63,%s59
 2961      BBBF3A7B 
 2962 3df8 00000000 		muls.w.sx	%s55,%s59,%s58
 2962      BABB374B 
 2963 3e00 00000000 		or	%s59,0,%s59
 2963      BB003B45 
 2964 3e08 00000000 		subs.w.sx	%s55,%s63,%s55
 2964      B7BF375A 
 2965 3e10 00000000 		or	%s63,0,%s59
 2965      BB003F45 
 2966 3e18 00000000 		muls.w.sx	%s59,%s58,%s57
 2966      B9BA3B4B 
 2967 3e20 00000000 		subs.w.sx	%s59,%s22,%s59
 2967      BB963B5A 
 2968 3e28 00000000 		or	%s22,0,%s57
 2968      B9001645 
 2969 3e30 00000000 		or	%s57,0,%s59
 2969      BB003945 
 2970 3e38 00000000 		muls.w.sx	%s58,%s58,%s56
 2970      B8BA3A4B 
 2971 3e40 00000000 		subs.w.sx	%s58,%s21,%s58
 2971      BA953A5A 
 2972 3e48 00000000 		or	%s21,0,%s56
 2972      B8001545 
 2973 3e50 00000000 		or	%s56,0,%s58
 2973      BA003845 
 2974 3e58 90FFFFFF 		brne.w	0,%s55,.L4.72
 2974      B7008318 
 2975 3e60 70FFFFFF 		br.l	.L4.71
 2975      00000F18 
 2976              	.L4.74:
 2977 3e68 00000000 		or	%s1,0,%s0
 2977      80000145 
 2978 3e70 80FFFFFF 		br.l	.L4.73
 2978      00000F18 
 2979              	.L4.3:
 2980              	# line 570
 570:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int khh = lcm_h / DH;
 2981              		.loc	1 570 0
 2982 3e78 28000000 		ldl.sx	%s63,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 2982      80003F03 
 2983 3e80 00000000 		muls.w.sx	%s58,%s63,%s61
 2983      BDBF3A4B 
 2984 3e88 00000000 		or	%s59,0,%s61
 2984      BD003B45 
 2985 3e90 00000000 		divs.w.sx	%s62,%s58,%s5
 2985      85BA3E7B 
 2986              	# line 571
 571:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   DMUST( khh == SH / gcd(SH,DH) );
 2987              		.loc	1 571 0
 2988 3e98 00000000 		divs.w.sx	%s60,%s62,%s61
 2988      BDBE3C7B 
 2989              	# line 573
 573:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int ha, hb, hg;
 2990              		.loc	1 573 0
 2991 3ea0 00000000 		divs.w.sx	%s33,%s62,%s63
 2991      BFBE217B 
 2992              	# line 575
 575:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //print(0," extendedEuclid: %d * [DH=%d] + %d * [SH=%d] = %d[gcd(DH,SH)]\n", ha,DH, hb,SH, hg);
 2993              		.loc	1 575 0
 2994 3ea8 00000000 		or	%s57,1,(0)1
 2994      00013945 
 2995 3eb0 00000000 		or	%s21,1,(0)1
 2995      00011545 
 2996 3eb8 00000000 		or	%s56,0,(0)1
 2996      00003845 
 2997 3ec0 00000000 		or	%s22,0,(0)1
 2997      00001645 
 2998 3ec8 A0FFFFFF 		brne.w	0,%s61,.L4.74
 2998      BD008318 
 2999 3ed0 00000000 		or	%s2,0,%s62
 2999      BE000245 
 3000 3ed8 C8FEFFFF 		br.l	.L4.70
 3000      00000F18 
 3001              	.L4.75:
 3002 3ee0 00000000 		or	%s5,0,%s63
 3002      BF000545 
 3003 3ee8 00000000 		or	%s0,0,%s4
 3003      84000045 
 3004 3ef0 00000000 		or	%s4,0,%s1
 3004      81000445 
 3005 3ef8 00000000 		or	%s6,0,%s2
 3005      82000645 
 3006 3f00 78FFFFFF 		br.l	.L4.3
 3006      00000F18 
 3007              	.L4.0:
 3008 3f08 D8FFFFFF 		breq.w	0,%s18,.L4.75
 3008      92008418 
 3009 3f10 B0EDFFFF 		br.l	.L4.4
 3009      00000F18 
 3010              		.cfi_endproc
 3011              		.set	.L.5.2auto_size,	0xfffffffffffffc00	# 1024 Bytes
 3013              	# ============ End  conv::refconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3014              	# ============ Begin  conv::refconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3015              		.data
 3016 00a2 00000000 		.balign 16
 3016      00000000 
 3016      00000000 
 3016      0000
 3019              	.LP._ZN4conv15refconv_3_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0:
 3020 00b0 00000000 		.long	__vla_dealloc_eh
 3020      00000000 
 3021 00b8 0000     		.zero	2
 3022 00ba FFFF     		.short	65535
 3023 00bc 04       		.byte	4
 3024 00bd 000000   		.zero	3
 3025 00c0 00000000 		.long	__vla_dealloc_eh
 3025      00000000 
 3026 00c8 0100     		.short	1
 3027 00ca 0000     		.zero	2
 3028 00cc 04       		.byte	4
 3029 00cd 000000   		.zero	3
 3030 00d0 00000000 		.long	__vla_dealloc_eh
 3030      00000000 
 3031 00d8 0200     		.short	2
 3032 00da 0100     		.short	1
 3033 00dc 04       		.byte	4
 3034 00dd 000000   		.zero	3
 3035 00e0 00000000 		.long	__vla_dealloc_eh
 3035      00000000 
 3036 00e8 0300     		.short	3
 3037 00ea 0200     		.short	2
 3038 00ec 04       		.byte	4
 3039 00ed 000000   		.zero	3
 3040 00f0 00000000 		.long	__vla_dealloc_eh
 3040      00000000 
 3041 00f8 0400     		.short	4
 3042 00fa 0300     		.short	3
 3043 00fc 04       		.byte	4
 3044 00fd 000000   		.zero	3
 3045 0100 00000000 		.long	__vla_dealloc_eh
 3045      00000000 
 3046 0108 0500     		.short	5
 3047 010a 0400     		.short	4
 3048 010c 04       		.byte	4
 3049 010d 000000   		.zero	3
 3050              		.text
 3051 3f18 00000000 		.balign 16
 3051      00000000 
 3052              	# line 703
 655:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0// try to "guess" things   --- no way!
 656:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_beg = (ih+PH - kh_beg * (p->dh+1)) / SH;
 657:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int khb0 = div_floor( (ih + PH) - OH*SH, DH) + 1;
 658:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int khb = khb0;
 659:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if( khb > 0 ){
 660:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 // Want first khb >= khb0 such that
 661:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //   ohsh = (ih+PH - khb*DH) is a multiple of SH
 662:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //     [ and >= 0, and < oh_end ]
 663:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 664:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 // or smallest N>=0 s.t.
 665:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //   khb' = (ih+PH - (khb+N)*DH) has khb'/SH*SH == khb'
 666:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //
 667:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //int ohsh = (ih+PH - khb * (DH));
 668:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //       ~ (ih+PH - ((ih + PH) - OH*SH + DH))
 669:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //       ~ OH*SH - (DH)
 670:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //int ohsh = OH*SH - (DH);
 671:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //if( ohsh % SH != 0 ) ohsh -= lcm_h;
 672:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 int ohsh = (ih+PH - khb * (DH));
 673:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 if( ohsh % SH != 0 ) ohsh -= ohsh % SH;
 674:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 if( ohsh % SH == 0 && kh_beg < kh_end ) RT_ASSERT( ohsh == oh_beg * SH );
 675:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 RT_ASSERT( ohsh %SH == 0 );
 676:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //int khb2 = div_floor( (ih+PH) - ohsh + DH , DH );
 677:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //int khb2 = div_floor( (ih+PH) - div_floor(ohsh,SH)*SH + DH-1 , DH ); // almost!
 678:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 int khb2 = div_floor( (ih+PH) - div_floor(ih+PH-ohsh,SH)*SH + DH-1 , DH ); // almos
 679:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 print(0, "\n\t\t SH,DH,PH,OH=%d,%d,%d,%d; ih=%d; oh_beg=%d, ohsh=%d, ohsh/SH=%d lcm
 680:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     SH,DH,PH,OH, ih, oh_beg,ohsh,ohsh/SH, lcm_h,khh, khb,khb2, kh_beg,kh_end);
 681:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 if( kh_beg < kh_end ) RT_ASSERT( khb2 == kh_beg );
 682:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 ohsh = (ih+PH - khb2 * (DH));
 683:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 print(0, " ohsh'=%d ", ohsh);
 684:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //ohsh -= ohsh % SH;
 685:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //if( kh_beg < kh_end ) RT_ASSERT( rem_floor(ohsh, SH) != 0 );
 686:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 // n RT_ASSERT( oh_beg == ohsh/SH );
 687:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //if( !( oh_beg == ohsh/SH )){
 688:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //  print(0, "\n\t\t SH,DH,PH,OH=%d,%d,%d,%d; ih=%d; oh_beg=%d, ohsh=%d, ohsh/SH=%d
 689:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //      SH, DH, PH, OH, ih, oh_beg, ohsh, ohsh/SH, lcm_h, khh, khb, kh_beg,kh_end);
 690:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //}
 691:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //if( kh_beg < kh_end ) RT_ASSERT( oh_beg == ohsh/SH );
 692:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 //RT_ASSERT( kh_beg == khb );
 693:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 print(0,"%c",'\n');
 694:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 695:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 696:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 697:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 698:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 699:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 700:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 701:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 702:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** void refconv_3_bwd_d(const prb_t *p, dnn_mem_t &diff_src_m,
 703:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     dnn_mem_t &wei_m, dnn_mem_t &diff_dst_m) {
 3053              		.loc	1 703 0
 3054              		.globl	conv::refconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 3056              	conv::refconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 3057              		.cfi_startproc
 3058 3f20 00000000 		st	%fp,0x0(,%sp)
 3058      8B000911 
 3059              		.cfi_def_cfa_offset	0
 3060              		.cfi_offset	9,0
 3061 3f28 08000000 		st	%lr,0x8(,%sp)
 3061      8B000A11 
 3062 3f30 18000000 		st	%got,0x18(,%sp)
 3062      8B000F11 
 3063 3f38 20000000 		st	%plt,0x20(,%sp)
 3063      8B001011 
 3064 3f40 00000000 		or	%fp,0,%sp
 3064      8B000945 
 3065              		.cfi_def_cfa_register	9
 3066 3f48 30000000 		st	%s18,48(,%fp)
 3066      89001211 
 3067 3f50 38000000 		st	%s19,56(,%fp)
 3067      89001311 
 3068 3f58 40000000 		st	%s20,64(,%fp)
 3068      89001411 
 3069 3f60 48000000 		st	%s21,72(,%fp)
 3069      89001511 
 3070 3f68 50000000 		st	%s22,80(,%fp)
 3070      89001611 
 3071 3f70 58000000 		st	%s23,88(,%fp)
 3071      89001711 
 3072 3f78 60000000 		st	%s24,96(,%fp)
 3072      89001811 
 3073 3f80 68000000 		st	%s25,104(,%fp)
 3073      89001911 
 3074 3f88 70000000 		st	%s26,112(,%fp)
 3074      89001A11 
 3075 3f90 78000000 		st	%s27,120(,%fp)
 3075      89001B11 
 3076 3f98 80000000 		st	%s28,128(,%fp)
 3076      89001C11 
 3077 3fa0 88000000 		st	%s29,136(,%fp)
 3077      89001D11 
 3078 3fa8 90000000 		st	%s30,144(,%fp)
 3078      89001E11 
 3079 3fb0 98000000 		st	%s31,152(,%fp)
 3079      89001F11 
 3080 3fb8 A0000000 		st	%s32,160(,%fp)
 3080      89002011 
 3081 3fc0 A8000000 		st	%s33,168(,%fp)
 3081      89002111 
 3082 3fc8 90DAFFFF 		lea	%s13,.L.6.2auto_size&0xffffffff
 3082      00000D06 
 3083 3fd0 00000000 		and	%s13,%s13,(32)0
 3083      608D0D44 
 3084 3fd8 FFFFFFFF 		lea.sl	%sp,.L.6.2auto_size>>32(%fp,%s13)
 3084      8D898B06 
 3085 3fe0 48000000 		brge.l.t	%sp,%sl,.L5.EoP
 3085      888B3518 
 3086 3fe8 18000000 		ld	%s61,0x18(,%tp)
 3086      8E003D01 
 3087 3ff0 00000000 		or	%s62,0,%s0
 3087      80003E45 
 3088 3ff8 3B010000 		lea	%s63,0x13b
 3088      00003F06 
 3089 4000 00000000 		shm.l	%s63,0x0(%s61)
 3089      BD033F31 
 3090 4008 08000000 		shm.l	%sl,0x8(%s61)
 3090      BD030831 
 3091 4010 10000000 		shm.l	%sp,0x10(%s61)
 3091      BD030B31 
 3092 4018 00000000 		monc
 3092      0000003F 
 3093 4020 00000000 		or	%s0,0,%s62
 3093      BE000045 
 3094              	.L5.EoP:
 3095              	# End of prologue codes
 3096 4028 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 3096      00003E06 
 3097 4030 00000000 		and	%s62,%s62,(32)0
 3097      60BE3E44 
 3098 4038 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 3098      BE00BE06 
 3099 4040 00000000 		ld	%s61,0(,%s62)
 3099      BE003D01 
 3100 4048 20FEFFFF 		st	%s61,-480(,%fp)
 3100      89003D11 
 3101 4050 20FEFFFF 		lea	%s61,-480
 3101      00003D06 
 3102 4058 00000000 		adds.l	%s61,%fp,%s61
 3102      BD893D59 
 3103 4060 00000000 		st	%s61,0(,%s62)
 3103      BE003D11 
 3104 4068 00000000 		or	%s62,1,(0)1
 3104      00013E45 
 3105 4070 28FEFFFF 		st1b	%s62,-472(,%fp)
 3105      89003E15 
 3106 4078 00000000 		lea	%s62,.LP._ZN4conv15refconv_3_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@LO
 3106      00003E06 
 3107 4080 00000000 		and	%s62,%s62,(32)0
 3107      60BE3E44 
 3108 4088 00000000 		lea.sl	%s62,.LP._ZN4conv15refconv_3_bwd_dEPKNS_5prb_tER9dnn_mem_tS4_S4_.0.__unnamed.0@HI(,%s62)
 3108      BE00BE06 
 3109 4090 30FEFFFF 		st	%s62,-464(,%fp)
 3109      89003E11 
 3110 4098 98FFFFFF 		lea	%s62,-104
 3110      00003E06 
 3111 40a0 00000000 		adds.l	%s62,%fp,%s62
 3111      BE893E59 
 3112 40a8 38FEFFFF 		st	%s62,-456(,%fp)
 3112      89003E11 
 3113 40b0 00000000 		lea	%s62,__eh_curr_region@LO
 3113      00003E06 
 3114 40b8 00000000 		and	%s62,%s62,(32)0
 3114      60BE3E44 
 3115 40c0 00000000 		lea.sl	%s62,__eh_curr_region@HI(,%s62)
 3115      BE00BE06 
 3116 40c8 00000000 		ld2b.zx	%s61,0(,%s62)
 3116      BE00BD04 
 3117 40d0 48FEFFFF 		st2b	%s61,-440(,%fp)
 3117      89003D14 
 3118 40d8 FFFF0000 		lea	%s61,65535
 3118      00003D06 
 3119 40e0 00000000 		st2b	%s61,0(,%s62)
 3119      BE003D14 
 3120              	# line 714
 704:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 705:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     refconv_2_bwd_d(p, diff_src_m, wei_m, diff_dst_m);
 706:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 707:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 0 // kw_beg, oh_end loop ---> calculation (debug)
 708:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   //  MOVED to separate routine
 709:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
 710:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 711:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // many impls moved to ref_conv3.cpp.v2 "historical" code
 712:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 1 // a new simplification of loop limits (same speed as above)
 713:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // regr-dilate: 2.50x
 714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   if (p->dh != 0 || p->dw != 0) { // A fast version here does not support dilation
 3121              		.loc	1 714 0
 3122 40e8 38000000 		ldl.sx	%s18,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 3122      80001203 
 3123 40f0 50140000 		brne.w	0,%s18,.L5.0
 3123      92008318 
 3124 40f8 08130000 		br.l	.L5.1
 3124      00000F18 
 3125              	.L5.2:
 3126              	# line 721
 715:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // FIXME can we call this even less?
 716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     refconv_3_bwd_d_generic(p, diff_src_m, wei_m, diff_dst_m);
 717:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     return;
 718:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 719:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int khb[IH], khe[IH], ohb[IH];
 721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int ih = 0; ih < IH; ++ih) {
 3127              		.loc	1 721 0
 3128 4100 80000000 		mins.w.sx	%s60,%s53,%s60
 3128      BCB53C78 
 3129 4108 D80E0000 		br.l	.L5.3
 3129      00000F18 
 3130              	.L5.4:
 3131              	# line 733
 722:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //int ocend = (OC/G);
 723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     khe[ih] = ih + PH;
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     ohb[ih] = OH - 1;
 725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
 726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohb[ih] = khe[ih] / SH;
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       khb[ih] = khe[ih] % SH;
 729:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if (++khe[ih] > p->kh) khe[ih] = p->kh;
 731:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   int kwb[IW], kwe[IW], owb[IW];
 733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int iw = 0; iw < IW; ++iw) {
 3132              		.loc	1 733 0
 3133 4110 80000000 		mins.w.sx	%s60,%s53,%s60
 3133      BCB53C78 
 3134 4118 900A0000 		br.l	.L5.5
 3134      00000F18 
 3135              	.L5.6:
 3136              	# line 757
 734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwe[iw] = iw + PW;
 735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     owb[iw] = OW - 1;
 736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
 737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
 738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       owb[iw] = kwe[iw] / SW;
 739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       kwb[iw] = kwe[iw] % SW;
 740:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if (++kwe[iw] > KW) kwe[iw] = KW;
 742:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 743:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 744:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   OMP(parallel for collapse(5))//;
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int g = 0; g < G; ++g) {
 746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kh_e = khe[ih];
 751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kw_e = kwe[iw];
 752:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float tmp = 0.f;
 753:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             if( khb[ih] < kh_e && kwb[iw] < kw_e ) {
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int oc = 0; oc < OC/G; ++oc) {
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 3137              		.loc	1 757 0
 3138 4120 80000000 		mins.w.sx	%s61,%s56,%s61
 3138      BDB83D78 
 3139 4128 40030000 		br.l	.L5.7
 3139      00000F18 
 3140              	.L5.8:
 3141 4130 00000000 		lea	%s63,__eh_curr_region@LO
 3141      00003F06 
 3142 4138 00000000 		and	%s63,%s63,(32)0
 3142      60BF3F44 
 3143 4140 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 3143      BF00BF06 
 3144 4148 48FEFFFF 		ld2b.zx	%s62,-440(,%fp)
 3144      8900BE04 
 3145 4150 00000000 		st2b	%s62,0(,%s63)
 3145      BF003E14 
 3146 4158 20FEFFFF 		ld	%s63,-480(,%fp)
 3146      89003F01 
 3147 4160 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 3147      00003E06 
 3148 4168 00000000 		and	%s62,%s62,(32)0
 3148      60BE3E44 
 3149 4170 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 3149      BE00BE06 
 3150 4178 00000000 		st	%s63,0(,%s62)
 3150      BE003F11 
 3151 4180 98120000 		br.l	.L5.9
 3151      00000F18 
 3152              	.L5.10:
 3153 4188 68080000 		br.l	.L5.11
 3153      00000F18 
 3154              	.L5.12:
 3155              	# line 745
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 3156              		.loc	1 745 0
 3157 4190 00000000 		adds.w.sx	%s63,1,%s63
 3157      BF013F4A 
 3158 4198 00000000 		adds.w.sx	%s48,%s41,%s48
 3158      B0A9304A 
 3159 41a0 00000000 		adds.w.sx	%s50,%s61,%s50
 3159      B2BD324A 
 3160 41a8 00000000 		adds.l	%s55,%s47,%s55
 3160      B7AF3759 
 3161 41b0 D8FFFFFF 		brgt.w	0,%s63,.L5.10
 3161      BF008118 
 3162 41b8 78FFFFFF 		br.l	.L5.8
 3162      00000F18 
 3163              	.L5.13:
 3164 41c0 58FDFFFF 		ld	%s63,-680(,%fp)	# restore 
 3164      89003F01 
 3165 41c8 60FDFFFF 		ld	%s61,-672(,%fp)	# restore 
 3165      89003D01 
 3166 41d0 50FDFFFF 		ld	%s55,-688(,%fp)	# restore 
 3166      89003701 
 3167 41d8 68FDFFFF 		ld	%s20,-664(,%fp)	# restore 
 3167      89001401 
 3168 41e0 48FDFFFF 		ld	%s6,-696(,%fp)	# restore 
 3168      89000601 
 3169 41e8 A8FFFFFF 		br.l	.L5.12
 3169      00000F18 
 3170              	.L5.14:
 3171              	# line 746
 746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 3172              		.loc	1 746 0
 3173 41f0 00000000 		adds.w.sx	%s63,1,%s63
 3173      BF013F4A 
 3174 41f8 00000000 		adds.l	%s55,%s58,%s55
 3174      B7BA3759 
 3175 4200 00000000 		adds.l	%s46,%s47,%s46
 3175      AEAF2E59 
 3176 4208 78070000 		brgt.w	0,%s63,.L5.15
 3176      BF008118 
 3177 4210 B0FFFFFF 		br.l	.L5.13
 3177      00000F18 
 3178              	.L5.16:
 3179 4218 98FDFFFF 		ld	%s63,-616(,%fp)	# restore 
 3179      89003F01 
 3180 4220 90FDFFFF 		ld	%s58,-624(,%fp)	# restore 
 3180      89003A01 
 3181 4228 78FDFFFF 		ld	%s55,-648(,%fp)	# restore 
 3181      89003701 
 3182 4230 88FDFFFF 		ld	%s47,-632(,%fp)	# restore 
 3182      89002F01 
 3183 4238 80FDFFFF 		ld	%s46,-640(,%fp)	# restore 
 3183      89002E01 
 3184 4240 70FDFFFF 		ld	%s41,-656(,%fp)	# restore 
 3184      89002901 
 3185 4248 A0FDFFFF 		ld	%s20,-608(,%fp)	# restore 
 3185      89001401 
 3186 4250 A0FFFFFF 		br.l	.L5.14
 3186      00000F18 
 3187              	.L5.17:
 3188              	# line 747
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 3189              		.loc	1 747 0
 3190 4258 00000000 		adds.w.sx	%s63,1,%s63
 3190      BF013F4A 
 3191 4260 00000000 		adds.w.sx	%s61,1,%s61
 3191      BD013D4A 
 3192 4268 98060000 		brgt.w	0,%s63,.L5.18
 3192      BF008118 
 3193 4270 A8FFFFFF 		br.l	.L5.16
 3193      00000F18 
 3194              	.L5.19:
 3195 4278 B8FDFFFF 		ld	%s63,-584(,%fp)	# restore 
 3195      89003F01 
 3196 4280 B0FDFFFF 		ld	%s61,-592(,%fp)	# restore 
 3196      89003D01 
 3197 4288 C0FDFFFF 		ld	%s19,-576(,%fp)	# restore 
 3197      89001301 
 3198 4290 A8FDFFFF 		ld	%s56,-600(,%fp)	# restore 
 3198      89003801 
 3199 4298 C0FFFFFF 		br.l	.L5.17
 3199      00000F18 
 3200              	.L5.20:
 3201              	# line 748
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 3202              		.loc	1 748 0
 3203 42a0 00000000 		adds.w.sx	%s63,1,%s63
 3203      BF013F4A 
 3204 42a8 00000000 		adds.l	%s61,4,%s61
 3204      BD043D59 
 3205 42b0 00000000 		adds.w.sx	%s58,1,%s58
 3205      BA013A4A 
 3206 42b8 F8050000 		brgt.w	0,%s63,.L5.21
 3206      BF008118 
 3207 42c0 B8FFFFFF 		br.l	.L5.19
 3207      00000F18 
 3208              	.L5.22:
 3209 42c8 00000000 		or	%s63,0,%s27
 3209      9B003F45 
 3210 42d0 18FEFFFF 		ld	%s61,-488(,%fp)	# restore 
 3210      89003D01 
 3211 42d8 00000000 		or	%s18,0,%s26
 3211      9A001245 
 3212 42e0 10FEFFFF 		ld	%s58,-496(,%fp)	# restore 
 3212      89003A01 
 3213 42e8 08FEFFFF 		ld	%s57,-504(,%fp)	# restore 
 3213      89003901 
 3214 42f0 00FEFFFF 		ld	%s53,-512(,%fp)	# restore 
 3214      89003501 
 3215 42f8 D8FDFFFF 		ld	%s35,-552(,%fp)	# restore 
 3215      89002301 
 3216 4300 F0FDFFFF 		ld	%s46,-528(,%fp)	# restore 
 3216      89002E01 
 3217 4308 E8FDFFFF 		ld	%s37,-536(,%fp)	# restore 
 3217      89002501 
 3218 4310 E0FDFFFF 		ld	%s36,-544(,%fp)	# restore 
 3218      89002401 
 3219 4318 D0FDFFFF 		ld	%s34,-560(,%fp)	# restore 
 3219      89002201 
 3220 4320 C8FDFFFF 		ld	%s7,-568(,%fp)	# restore 
 3220      89000701 
 3221 4328 F8FDFFFF 		ld	%s48,-520(,%fp)	# restore 
 3221      89003001 
 3222 4330 70FFFFFF 		br.l	.L5.20
 3222      00000F18 
 3223              	.L5.23:
 3224              	# line 769
 758:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 759:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     tmp += ((float*)diff_dst_m)[dst_off]
 761:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       * ((float*)wei_m)[wei_off];
 762:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 764:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 765:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 766:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float &ds = ((float*)diff_src_m)[src_off]; // WRITTEN
 769:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             ds = tmp;
 3225              		.loc	1 769 0
 3226 4338 00000000 		stu	%s63,0(%s58,%s56)	# *(ds)
 3226      B8BA3F12 
 3227              	# line 749
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kh_e = khe[ih];
 3228              		.loc	1 749 0
 3229 4340 00000000 		adds.w.sx	%s55,1,%s55
 3229      B701374A 
 3230 4348 00000000 		adds.l	%s58,4,%s58
 3230      BA043A59 
 3231 4350 40040000 		brgt.w	0,%s55,.L5.24
 3231      B7008118 
 3232 4358 70FFFFFF 		br.l	.L5.22
 3232      00000F18 
 3233              	.L5.25:
 3234              	# line 760
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       * ((float*)wei_m)[wei_off];
 3235              		.loc	1 760 0
 3236 4360 0000003C 		lvs	%s63,%v60(0)
 3236      00003F9E 
 3237 4368 00000000 		or	%s56,0,%s6
 3237      86003845 
 3238 4370 00000000 		or	%s58,0,%s24
 3238      98003A45 
 3239 4378 00000000 		or	%s55,0,%s21
 3239      95003745 
 3240 4380 00000000 		or	%s51,0,%s22
 3240      96003345 
 3241 4388 00000000 		or	%s60,0,%s5
 3241      85003C45 
 3242 4390 00000000 		or	%s54,0,%s25
 3242      99003645 
 3243 4398 00000000 		or	%s52,0,%s23
 3243      97003445 
 3244 43a0 98FFFFFF 		br.l	.L5.23
 3244      00000F18 
 3245              	.L5.26:
 3246              	# line 755
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
 3247              		.loc	1 755 0
 3248 43a8 00000000 		adds.w.sx	%s58,1,%s58
 3248      BA013A4A 
 3249 43b0 00000000 		adds.w.sx	%s57,1,%s57
 3249      B901394A 
 3250 43b8 A8020000 		brgt.w	0,%s58,.L5.27
 3250      BA008118 
 3251 43c0 A0FFFFFF 		br.l	.L5.25
 3251      00000F18 
 3252              	.L5.28:
 3253 43c8 00000000 		or	%s58,0,%s2
 3253      82003A45 
 3254 43d0 00000000 		or	%s57,0,%s4
 3254      84003945 
 3255 43d8 00000000 		or	%s18,0,%s3
 3255      83001245 
 3256 43e0 00000000 		or	%s61,0,%s1
 3256      81003D45 
 3257 43e8 C0FFFFFF 		br.l	.L5.26
 3257      00000F18 
 3258              	.L5.29:
 3259              	# line 763
 763:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 3260              		.loc	1 763 0
 3261 43f0 00000000 		adds.w.sx	%s63,-1,%s63
 3261      BF7F3F4A 
 3262              	# line 756
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 3263              		.loc	1 756 0
 3264 43f8 00000000 		adds.w.sx	%s61,%s62,%s61
 3264      BDBE3D4A 
 3265 4400 00000000 		adds.w.sx	%s60,%s60,%s62
 3265      BEBC3C4A 
 3266 4408 F8010000 		brgt.w	0,%s61,.L5.30
 3266      BD008118 
 3267 4410 B8FFFFFF 		br.l	.L5.28
 3267      00000F18 
 3268              	.L5.31:
 3269              	# line 760
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       * ((float*)wei_m)[wei_off];
 3270              		.loc	1 760 0
 3271 4418 00000000 		lvl	%s55
 3271      00B700BF 
 3272 4420 00003F3B 		vfsum.s	%v59,%v63
 3272      000080EC 
 3273 4428 00000000 		or	%s58,1,(0)1
 3273      00013A45 
 3274 4430 00000000 		lvl	%s58
 3274      00BA00BF 
 3275 4438 003B3C3C 		vfadd.s	%v60,%v60,%v59
 3275      000080CC 
 3276 4440 00000000 		or	%s60,0,%s54
 3276      B6003C45 
 3277 4448 00000000 		or	%s61,0,%s53
 3277      B5003D45 
 3278 4450 00000000 		or	%s62,0,%s52
 3278      B4003E45 
 3279 4458 00000000 		or	%s63,0,%s51
 3279      B3003F45 
 3280 4460 90FFFFFF 		br.l	.L5.29
 3280      00000F18 
 3281              	.L5.7:
 3282 4468 00000000 		or	%s62,0,%s63
 3282      BF003E45 
 3283 4470 00000000 		lvl	%s61
 3283      00BD00BF 
 3284 4478 0000003E 		vldu.nc	%v62,-4,%s62
 3284      BE7C0082 
 3285 4480 00000000 		or	%s62,0,%s60
 3285      BC003E45 
 3286 4488 0000003D 		vldu.nc	%v61,%s59,%s62
 3286      BEBB0082 
 3287 4490 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 3287      000080E2 
 3288              	# line 757
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3289              		.loc	1 757 0
 3290 4498 00000000 		adds.l	%s63,%s63,%s58
 3290      BABF3F59 
 3291 44a0 00000000 		adds.l	%s60,%s60,%s57
 3291      B9BC3C59 
 3292 44a8 00000000 		subs.w.sx	%s56,%s56,%s61
 3292      BDB8385A 
 3293 44b0 68FFFFFF 		brge.w	0,%s56,.L5.31
 3293      B8008518 
 3294 44b8 68FCFFFF 		br.l	.L5.6
 3294      00000F18 
 3295              	.L5.32:
 3296              	# line 760
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       * ((float*)wei_m)[wei_off];
 3297              		.loc	1 760 0
 3298 44c0 00000000 		divs.w.sx	%s48,%s50,%s49
 3298      B1B2307B 
 3299 44c8 00000000 		or	%s52,0,%s62
 3299      BE003445 
 3300 44d0 00000000 		or	%s51,0,%s63
 3300      BF003345 
 3301 44d8 00000000 		or	%s54,0,%s60
 3301      BC003645 
 3302 44e0 00000000 		or	%s53,0,%s61
 3302      BD003545 
 3303 44e8 00000000 		or	%s48,0,%s48
 3303      B0003045 
 3304 44f0 00000000 		addu.l	%s48,%s48,%s47
 3304      AFB03048 
 3305 44f8 00000000 		addu.l	%s48,%s48,%s46
 3305      AEB03048 
 3306 4500 00000000 		mulu.l	%s48,%s48,%s45
 3306      ADB03049 
 3307 4508 00000000 		divu.l	%s62,%s44,%s43
 3307      ABAC3E6F 
 3308 4510 00000000 		addu.l	%s62,%s46,%s62
 3308      BEAE3E48 
 3309 4518 00000000 		mulu.l	%s62,%s62,%s42
 3309      AABE3E49 
 3310 4520 00000000 		divu.l	%s62,%s62,%s43
 3310      ABBE3E6F 
 3311 4528 00000000 		addu.l	%s62,%s62,%s41
 3311      A9BE3E48 
 3312 4530 00000000 		mulu.l	%s62,%s62,%s40
 3312      A8BE3E49 
 3313 4538 00000000 		or	%s34,0,%s63
 3313      BF002245 
 3314 4540 00000000 		addu.l	%s34,%s48,%s34
 3314      A2B02248 
 3315 4548 00000000 		mulu.l	%s34,%s34,%s39
 3315      A7A22249 
 3316 4550 00000000 		or	%s34,0,%s34
 3316      A2002245 
 3317 4558 00000000 		or	%s48,0,%s60
 3317      BC003045 
 3318 4560 00000000 		addu.l	%s48,%s62,%s48
 3318      B0BE3048 
 3319 4568 00000000 		mulu.l	%s48,%s48,%s38
 3319      A6B03049 
 3320 4570 00000000 		or	%s48,0,%s48
 3320      B0003045 
 3321              	# line 757
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3322              		.loc	1 757 0
 3323 4578 00000000 		muls.l	%s48,4,%s48
 3323      B004306E 
 3324 4580 00000000 		muls.l	%s34,4,%s34
 3324      A204226E 
 3325 4588 00000000 		adds.l	%s48,%s48,%s37
 3325      A5B03059 
 3326 4590 00000000 		adds.l	%s34,%s34,%s36
 3326      A4A22259 
 3327 4598 00000000 		subs.w.sx	%s62,0,%s35
 3327      A3003E5A 
 3328 45a0 00000000 		smvl	%s55
 3328      0000372E 
 3329 45a8 80000000 		mins.w.sx	%s61,%s62,%s55
 3329      B7BE3D78 
 3330              	# line 760
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       * ((float*)wei_m)[wei_off];
 3331              		.loc	1 760 0
 3332 45b0 00000000 		or	%s7,0,(0)1
 3332      00000745 
 3333 45b8 00000000 		lvl	%s55
 3333      00B700BF 
 3334 45c0 0000003F 		vbrdu	%v63,%s7
 3334      0087808C 
 3335 45c8 00000000 		or	%s56,0,%s62
 3335      BE003845 
 3336 45d0 00000000 		or	%s62,0,%s61
 3336      BD003E45 
 3337 45d8 00000000 		or	%s63,0,%s34
 3337      A2003F45 
 3338              	# line 757
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3339              		.loc	1 757 0
 3340 45e0 00000000 		muls.l	%s58,-4,%s62
 3340      BE7C3A6E 
 3341 45e8 00000000 		or	%s60,0,%s48
 3341      B0003C45 
 3342 45f0 00000000 		muls.l	%s57,%s59,%s62
 3342      BEBB396E 
 3343 45f8 70FEFFFF 		br.l	.L5.7
 3343      00000F18 
 3344              	.L5.30:
 3345 4600 C0FEFFFF 		brlt.w	0,%s18,.L5.32
 3345      92008218 
 3346 4608 E8FDFFFF 		br.l	.L5.29
 3346      00000F18 
 3347              	.L5.33:
 3348 4610 00000000 		divs.w.sx	%s56,%s33,%s32
 3348      A0A1387B 
 3349 4618 00000000 		or	%s1,0,%s61
 3349      BD000145 
 3350 4620 00000000 		or	%s2,0,%s58
 3350      BA000245 
 3351 4628 00000000 		or	%s3,0,%s18
 3351      92000345 
 3352 4630 00000000 		or	%s4,0,%s57
 3352      B9000445 
 3353 4638 00000000 		subs.w.sx	%s35,0,%s56
 3353      B800235A 
 3354 4640 00000000 		or	%s46,0,%s57
 3354      B9002E45 
 3355              	# line 756
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 3356              		.loc	1 756 0
 3357 4648 00000000 		adds.w.sx	%s61,%s18,%s31
 3357      9F923D4A 
 3358 4650 00000000 		or	%s18,0,%s56
 3358      B8001245 
 3359 4658 A8FFFFFF 		br.l	.L5.30
 3359      00000F18 
 3360              	.L5.27:
 3361 4660 00000000 		or	%s60,0,%s18
 3361      92003C45 
 3362 4668 00000000 		or	%s63,0,%s61
 3362      BD003F45 
 3363 4670 A0FFFFFF 		brlt.w	%s18,%s19,.L5.33
 3363      93928218 
 3364 4678 30FDFFFF 		br.l	.L5.26
 3364      00000F18 
 3365              	.L5.34:
 3366              	# line 757
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3367              		.loc	1 757 0
 3368 4680 00000000 		dldl.sx	%s63,0(%s58,%s54)	# *(kwb)
 3368      B6BA3F0B 
 3369 4688 00000000 		or	%s5,0,%s60
 3369      BC000545 
 3370 4690 00000000 		or	%s6,0,%s56
 3370      B8000645 
 3371 4698 00000000 		or	%s60,0,%s63
 3371      BF003C45 
 3372 46a0 00000000 		muls.l	%s60,4,%s60
 3372      BC043C6E 
 3373 46a8 00000000 		dldl.sx	%s56,0(%s58,%s30)	# *(owb)
 3373      9EBA380B 
 3374 46b0 00000000 		or	%s21,0,%s55
 3374      B7001545 
 3375 46b8 00000000 		or	%s22,0,%s51
 3375      B3001645 
 3376 46c0 00000000 		or	%s56,0,%s56
 3376      B8003845 
 3377 46c8 00000000 		muls.l	%s56,4,%s56
 3377      B804386E 
 3378 46d0 00000000 		adds.w.sx	%s55,-1,%s57
 3378      B97F374A 
 3379 46d8 00000000 		or	%s57,0,%s53
 3379      B5003945 
 3380 46e0 00000000 		subs.w.sx	%s63,%s55,%s63
 3380      BFB73F5A 
 3381 46e8 00000000 		or	%s23,0,%s52
 3381      B4001745 
 3382 46f0 00000000 		adds.w.sx	%s33,%s63,%s32
 3382      A0BF214A 
 3383              	# line 755
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
 3384              		.loc	1 755 0
 3385 46f8 00000000 		divs.w.sx	%s51,%s52,%s51
 3385      B3B4337B 
 3386 4700 00000000 		or	%s24,0,%s58
 3386      BA001845 
 3387 4708 00000000 		or	%s25,0,%s54
 3387      B6001945 
 3388 4710 00000000 		subs.w.sx	%s51,0,%s51
 3388      B300335A 
 3389 4718 00000000 		or	%s58,0,%s51
 3389      B3003A45 
 3390              	# line 757
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3391              		.loc	1 757 0
 3392 4720 00000000 		adds.l	%s37,%s60,%s29
 3392      9DBC2559 
 3393 4728 00000000 		adds.l	%s36,%s56,%s28
 3393      9CB82459 
 3394              	# line 760
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       * ((float*)wei_m)[wei_off];
 3395              		.loc	1 760 0
 3396 4730 00000000 		or	%s63,1,(0)1
 3396      00013F45 
 3397 4738 00000000 		or	%s60,0,(0)1
 3397      00003C45 
 3398 4740 00000000 		lvl	%s63
 3398      00BF00BF 
 3399 4748 0000003C 		vbrdu	%v60,%s60
 3399      00BC808C 
 3400 4750 10FFFFFF 		br.l	.L5.27
 3400      00000F18 
 3401              	.L5.35:
 3402              	# line 755
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
 3403              		.loc	1 755 0
 3404 4758 00000000 		or	%s53,0,(0)1
 3404      00003545 
 3405 4760 00000000 		divs.w.sx	%s21,%s52,%s51
 3405      B3B4157B 
 3406 4768 18FFFFFF 		brlt.w	0,%s21,.L5.34
 3406      95008218 
 3407 4770 C8FBFFFF 		br.l	.L5.23
 3407      00000F18 
 3408              	.L5.36:
 3409              	# line 754
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int oc = 0; oc < OC/G; ++oc) {
 3410              		.loc	1 754 0
 3411 4778 00000000 		ldl.sx	%s21,0(%s58,%s54)	# *(kwb)
 3411      B6BA1503 
 3412 4780 D8FFFFFF 		brlt.w	%s21,%s57,.L5.35
 3412      B9958218 
 3413 4788 B0FBFFFF 		br.l	.L5.23
 3413      00000F18 
 3414              	.L5.24:
 3415              	# line 750
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kw_e = kwe[iw];
 3416              		.loc	1 750 0
 3417 4790 00000000 		or	%s63,0,(0)1
 3417      00003F45 
 3418              	# line 751
 751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float tmp = 0.f;
 3419              		.loc	1 751 0
 3420 4798 00000000 		ldl.sx	%s57,0(%s58,%s60)	# *(kwe)
 3420      BCBA3903 
 3421 47a0 D8FFFFFF 		brlt.w	%s20,%s19,.L5.36
 3421      93948218 
 3422 47a8 90FBFFFF 		br.l	.L5.23
 3422      00000F18 
 3423              	.L5.37:
 3424 47b0 18FEFFFF 		st	%s61,-488(,%fp)	# spill 
 3424      89003D11 
 3425 47b8 10FEFFFF 		st	%s58,-496(,%fp)	# spill 
 3425      89003A11 
 3426 47c0 08FEFFFF 		st	%s57,-504(,%fp)	# spill 
 3426      89003911 
 3427 47c8 00FEFFFF 		st	%s53,-512(,%fp)	# spill 
 3427      89003511 
 3428 47d0 F8FDFFFF 		st	%s48,-520(,%fp)	# spill 
 3428      89003011 
 3429 47d8 F0FDFFFF 		st	%s46,-528(,%fp)	# spill 
 3429      89002E11 
 3430 47e0 E8FDFFFF 		st	%s37,-536(,%fp)	# spill 
 3430      89002511 
 3431 47e8 E0FDFFFF 		st	%s36,-544(,%fp)	# spill 
 3431      89002411 
 3432 47f0 D8FDFFFF 		st	%s35,-552(,%fp)	# spill 
 3432      89002311 
 3433 47f8 D0FDFFFF 		st	%s34,-560(,%fp)	# spill 
 3433      89002211 
 3434 4800 C8FDFFFF 		st	%s7,-568(,%fp)	# spill 
 3434      89000711 
 3435 4808 00000000 		or	%s6,0,%s58
 3435      BA000645 
 3436              	# line 750
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kw_e = kwe[iw];
 3437              		.loc	1 750 0
 3438 4810 00000000 		dldl.sx	%s19,0(%s61,%s57)	# *(khe)
 3438      B9BD130B 
 3439 4818 00000000 		or	%s26,0,%s18
 3439      92001A45 
 3440 4820 00000000 		or	%s27,0,%s63
 3440      BF001B45 
 3441              	# line 756
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 3442              		.loc	1 756 0
 3443 4828 00000000 		subs.w.sx	%s31,0,%s19
 3443      93001F5A 
 3444              	# line 754
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int oc = 0; oc < OC/G; ++oc) {
 3445              		.loc	1 754 0
 3446 4830 00000000 		dldl.sx	%s20,0(%s61,%s53)	# *(khb)
 3446      B5BD140B 
 3447              	# line 767
 767:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float &ds = ((float*)diff_src_m)[src_off]; // WRITTEN
 3448              		.loc	1 767 0
 3449 4838 00000000 		divs.w.sx	%s48,%s48,%s51
 3449      B3B0307B 
 3450 4840 00000000 		or	%s48,0,%s48
 3450      B0003045 
 3451 4848 00000000 		addu.l	%s46,%s48,%s46
 3451      AEB02E48 
 3452 4850 00000000 		addu.l	%s46,%s46,%s41
 3452      A9AE2E48 
 3453 4858 00000000 		mulu.l	%s37,%s46,%s37
 3453      A5AE2549 
 3454 4860 00000000 		addu.l	%s6,%s37,%s6
 3454      86A50648 
 3455 4868 00000000 		mulu.l	%s36,%s6,%s36
 3455      A4862449 
 3456 4870 00000000 		or	%s36,0,%s36
 3456      A4002445 
 3457              	# line 749
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kh_e = khe[ih];
 3458              		.loc	1 749 0
 3459 4878 00000000 		muls.l	%s36,4,%s36
 3459      A404246E 
 3460              	# line 756
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 3461              		.loc	1 756 0
 3462 4880 00000000 		dldl.sx	%s18,0(%s61,%s53)	# *(khb)
 3462      B5BD120B 
 3463 4888 00000000 		dldl.sx	%s61,0(%s61,%s35)	# *(ohb)
 3463      A3BD3D0B 
 3464              	# line 749
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kh_e = khe[ih];
 3465              		.loc	1 749 0
 3466 4890 00000000 		adds.l	%s56,%s36,%s34
 3466      A2A43859 
 3467 4898 00000000 		or	%s55,0,%s7
 3467      87003745 
 3468 48a0 00000000 		or	%s58,0,(0)1
 3468      00003A45 
 3469 48a8 E8FEFFFF 		br.l	.L5.24
 3469      00000F18 
 3470              	.L5.21:
 3471 48b0 00FFFFFF 		brlt.w	0,%s18,.L5.37
 3471      92008218 
 3472 48b8 E8F9FFFF 		br.l	.L5.20
 3472      00000F18 
 3473              	.L5.38:
 3474 48c0 C0FDFFFF 		st	%s19,-576(,%fp)	# spill 
 3474      89001311 
 3475 48c8 B8FDFFFF 		st	%s63,-584(,%fp)	# spill 
 3475      89003F11 
 3476 48d0 B0FDFFFF 		st	%s61,-592(,%fp)	# spill 
 3476      89003D11 
 3477 48d8 A8FDFFFF 		st	%s56,-600(,%fp)	# spill 
 3477      89003811 
 3478 48e0 00000000 		or	%s41,0,%s61
 3478      BD002945 
 3479 48e8 00000000 		or	%s63,0,%s56
 3479      B8003F45 
 3480              	# line 748
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 3481              		.loc	1 748 0
 3482 48f0 00000000 		or	%s61,0,(0)1
 3482      00003D45 
 3483 48f8 B8FFFFFF 		br.l	.L5.21
 3483      00000F18 
 3484              	.L5.18:
 3485 4900 00000000 		or	%s58,0,(0)1
 3485      00003A45 
 3486 4908 B8FFFFFF 		brlt.w	0,%s19,.L5.38
 3486      93008218 
 3487 4910 48F9FFFF 		br.l	.L5.17
 3487      00000F18 
 3488              	.L5.39:
 3489 4918 A0FDFFFF 		st	%s20,-608(,%fp)	# spill 
 3489      89001411 
 3490 4920 98FDFFFF 		st	%s63,-616(,%fp)	# spill 
 3490      89003F11 
 3491 4928 90FDFFFF 		st	%s58,-624(,%fp)	# spill 
 3491      89003A11 
 3492 4930 88FDFFFF 		st	%s47,-632(,%fp)	# spill 
 3492      89002F11 
 3493 4938 80FDFFFF 		st	%s46,-640(,%fp)	# spill 
 3493      89002E11 
 3494 4940 78FDFFFF 		st	%s55,-648(,%fp)	# spill 
 3494      89003711 
 3495 4948 70FDFFFF 		st	%s41,-656(,%fp)	# spill 
 3495      89002911 
 3496              	# line 747
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 3497              		.loc	1 747 0
 3498 4950 00000000 		divs.w.sx	%s41,%s41,%s51
 3498      B3A9297B 
 3499 4958 00000000 		subs.w.sx	%s41,0,%s41
 3499      A900295A 
 3500 4960 00000000 		or	%s63,0,%s41
 3500      A9003F45 
 3501 4968 00000000 		or	%s46,0,%s55
 3501      B7002E45 
 3502 4970 80FDFFFF 		ld	%s47,-640(,%fp)	# restore 
 3502      89002F01 
 3503 4978 88FFFFFF 		br.l	.L5.18
 3503      00000F18 
 3504              	.L5.15:
 3505 4980 00000000 		or	%s61,0,(0)1
 3505      00003D45 
 3506 4988 90FFFFFF 		brlt.w	0,%s20,.L5.39
 3506      94008218 
 3507 4990 60F8FFFF 		br.l	.L5.14
 3507      00000F18 
 3508              	.L5.40:
 3509 4998 68FDFFFF 		st	%s20,-664(,%fp)	# spill 
 3509      89001411 
 3510 49a0 60FDFFFF 		st	%s61,-672(,%fp)	# spill 
 3510      89003D11 
 3511 49a8 58FDFFFF 		st	%s63,-680(,%fp)	# spill 
 3511      89003F11 
 3512 49b0 50FDFFFF 		st	%s55,-688(,%fp)	# spill 
 3512      89003711 
 3513 49b8 48FDFFFF 		st	%s6,-696(,%fp)	# spill 
 3513      89000611 
 3514 49c0 00000000 		divs.w.sx	%s20,%s41,%s51
 3514      B3A9147B 
 3515 49c8 00000000 		or	%s44,0,%s55
 3515      B7002C45 
 3516 49d0 00000000 		or	%s63,0,%s6
 3516      86003F45 
 3517              	# line 746
 746:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int ic = 0; ic < IC/G; ++ic) {
 3518              		.loc	1 746 0
 3519 49d8 00000000 		or	%s55,0,(0)1
 3519      00003745 
 3520 49e0 00000000 		or	%s46,0,(0)1
 3520      00002E45 
 3521 49e8 98FFFFFF 		br.l	.L5.15
 3521      00000F18 
 3522              	.L5.11:
 3523 49f0 A8FFFFFF 		brlt.w	0,%s20,.L5.40
 3523      94008218 
 3524 49f8 98F7FFFF 		br.l	.L5.12
 3524      00000F18 
 3525              	.L5.41:
 3526 4a00 C0F4FFFF 		ld	%s46,-2880(,%fp)	# restore 
 3526      89002E01 
 3527 4a08 04000000 		dldl.sx	%s20,4(,%s46)	# *(p).__b_N4conv6desc_tE.mb
 3527      AE00140B 
 3528 4a10 00000000 		subs.w.sx	%s6,0,%s20
 3528      9400065A 
 3529              	# line 747
 747:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ih = 0; ih < IH; ++ih) {
 3530              		.loc	1 747 0
 3531 4a18 08000000 		dldl.sx	%s41,8(,%s46)	# *(p).__b_N4conv6desc_tE.ic
 3531      AE00290B 
 3532 4a20 00000000 		or	%s44,0,%s41
 3532      A9002C45 
 3533 4a28 00000000 		or	%s58,0,%s44
 3533      AC003A45 
 3534              	# line 745
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 3535              		.loc	1 745 0
 3536 4a30 00000000 		or	%s55,0,(0)1
 3536      00003745 
 3537 4a38 00000000 		subs.w.sx	%s44,0,%s51
 3537      B3002C5A 
 3538 4a40 00000000 		or	%s63,0,%s44
 3538      AC003F45 
 3539              	# line 748
 748:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int iw = 0; iw < IW; ++iw) {
 3540              		.loc	1 748 0
 3541 4a48 0C000000 		dldl.sx	%s19,12(,%s46)	# *(p).__b_N4conv6desc_tE.ih
 3541      AE00130B 
 3542 4a50 00000000 		or	%s37,0,%s19
 3542      93002545 
 3543 4a58 00000000 		subs.w.sx	%s56,0,%s19
 3543      9300385A 
 3544              	# line 749
 749:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kh_e = khe[ih];
 3545              		.loc	1 749 0
 3546 4a60 10000000 		dldl.sx	%s18,16(,%s46)	# *(p).__b_N4conv6desc_tE.iw
 3546      AE00120B 
 3547 4a68 00000000 		or	%s36,0,%s18
 3547      92002445 
 3548 4a70 00000000 		subs.w.sx	%s7,0,%s18
 3548      9200075A 
 3549              	# line 750
 750:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             const int kw_e = kwe[iw];
 3550              		.loc	1 750 0
 3551 4a78 D0FFFFFF 		dld	%s57,-48(,%fp)	# khe
 3551      89003909 
 3552              	# line 751
 751:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             float tmp = 0.f;
 3553              		.loc	1 751 0
 3554 4a80 F0FFFFFF 		dld	%s60,-16(,%fp)	# kwe
 3554      89003C09 
 3555              	# line 754
 754:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int oc = 0; oc < OC/G; ++oc) {
 3556              		.loc	1 754 0
 3557 4a88 C8FFFFFF 		dld	%s53,-56(,%fp)	# khb
 3557      89003509 
 3558 4a90 E0FFFFFF 		dld	%s54,-32(,%fp)	# kwb
 3558      89003609 
 3559              	# line 768
 768:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             ds = tmp;
 3560              		.loc	1 768 0
 3561 4a98 A8010000 		dld	%s34,424(,%s1)	# *(diff_src_m).data_
 3561      81002209 
 3562              	# line 755
 755:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int kh = khb[ih], oh=ohb[ih]; kh < kh_e; --oh, kh+=SH) {
 3563              		.loc	1 755 0
 3564 4aa0 14000000 		dldl.sx	%s52,20(,%s46)	# *(p).__b_N4conv6desc_tE.oc
 3564      AE00340B 
 3565              	# line 756
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 3566              		.loc	1 756 0
 3567 4aa8 D8FFFFFF 		dld	%s35,-40(,%fp)	# ohb
 3567      89002309 
 3568              	# line 757
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3569              		.loc	1 757 0
 3570 4ab0 E8FFFFFF 		dld	%s30,-24(,%fp)	# owb
 3570      89001E09 
 3571 4ab8 2C000000 		dldl.sx	%s32,44(,%s46)	# *(p).__b_N4conv6desc_tE.sw
 3571      AE00200B 
 3572 4ac0 00000000 		or	%s44,0,%s32
 3572      A0002C45 
 3573 4ac8 00000000 		muls.l	%s59,4,%s44
 3573      AC043B6E 
 3574              	# line 745
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 3575              		.loc	1 745 0
 3576 4ad0 00000000 		or	%s48,0,(0)1
 3576      00003045 
 3577 4ad8 00000000 		or	%s50,0,(0)1
 3577      00003245 
 3578              	# line 757
 757:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 3579              		.loc	1 757 0
 3580 4ae0 A8010000 		dld	%s28,424(,%s3)	# *(s$133).data_
 3580      83001C09 
 3581 4ae8 A8010000 		dld	%s29,424(,%s2)	# *(s$135).data_
 3581      82001D09 
 3582              	# line 760
 760:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       * ((float*)wei_m)[wei_off];
 3583              		.loc	1 760 0
 3584 4af0 14000000 		dldl.sx	%s61,20(,%s46)	# *(p).__b_N4conv6desc_tE.oc
 3584      AE003D0B 
 3585 4af8 00000000 		or	%s44,0,%s61
 3585      BD002C45 
 3586 4b00 00000000 		or	%s47,0,%s44
 3586      AC002F45 
 3587 4b08 00000000 		dldl.sx	%s49,0(,%s46)	# *(p).__b_N4conv6desc_tE.g
 3587      AE00310B 
 3588 4b10 00000000 		or	%s43,0,%s49
 3588      B1002B45 
 3589 4b18 18000000 		dldl.sx	%s44,24(,%s46)	# *(p).__b_N4conv6desc_tE.oh
 3589      AE002C0B 
 3590 4b20 00000000 		or	%s45,0,%s44
 3590      AC002D45 
 3591 4b28 1C000000 		dldl.sx	%s44,28(,%s46)	# *(p).__b_N4conv6desc_tE.ow
 3591      AE002C0B 
 3592 4b30 00000000 		or	%s39,0,%s44
 3592      AC002745 
 3593 4b38 08000000 		dldl.sx	%s44,8(,%s46)	# *(p).__b_N4conv6desc_tE.ic
 3593      AE002C0B 
 3594 4b40 00000000 		or	%s42,0,%s44
 3594      AC002A45 
 3595 4b48 20000000 		dldl.sx	%s44,32(,%s46)	# *(p).__b_N4conv6desc_tE.kh
 3595      AE002C0B 
 3596 4b50 00000000 		or	%s40,0,%s44
 3596      AC002845 
 3597 4b58 24000000 		dldl.sx	%s44,36(,%s46)	# *(p).__b_N4conv6desc_tE.kw
 3597      AE002C0B 
 3598 4b60 00000000 		or	%s38,0,%s44
 3598      AC002645 
 3599              	# line 756
 756:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int kw = kwb[iw], ow=owb[iw]; kw < kw_e; --ow, kw += SW) {
 3600              		.loc	1 756 0
 3601 4b68 28000000 		dldl.sx	%s62,40(,%s46)	# *(p).__b_N4conv6desc_tE.sh
 3601      AE003E0B 
 3602 4b70 80FEFFFF 		br.l	.L5.11
 3602      00000F18 
 3603              	.L5.42:
 3604 4b78 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3604      89003F01 
 3605              	# line 745
 745:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int mb = 0; mb < MB; ++mb) {
 3606              		.loc	1 745 0
 3607 4b80 00000000 		ldl.sx	%s51,0(,%s63)	# *(p).__b_N4conv6desc_tE.g
 3607      BF003303 
 3608 4b88 78FEFFFF 		brlt.w	0,%s51,.L5.41
 3608      B3008218 
 3609 4b90 A0F5FFFF 		br.l	.L5.8
 3609      00000F18 
 3610              	.L5.43:
 3611 4b98 C0F4FFFF 		st	%s63,-2880(,%fp)	# spill 
 3611      89003F11 
 3612 4ba0 D8FFFFFF 		br.l	.L5.42
 3612      00000F18 
 3613              	.L5.5:
 3614              	# line 734
 734:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     owb[iw] = OW - 1;
 3615              		.loc	1 734 0
 3616 4ba8 34000000 		ldl.sx	%s62,52(,%s63)	# *(p).__b_N4conv6desc_tE.pw
 3616      BF003E03 
 3617 4bb0 00000000 		lvl	%s60
 3617      00BC00BF 
 3618 4bb8 00280023 		vadds.w.sx	%v35,%s61,%v40
 3618      00BD20CA 
 3619 4bc0 00230022 		vadds.w.sx	%v34,%s62,%v35
 3619      00BE20CA 
 3620 4bc8 00000000 		adds.l	%s62,%s59,(0)1
 3620      00BB3E59 
 3621 4bd0 00000000 		adds.l	%s52,%s62,%s58
 3621      BABE3459 
 3622 4bd8 00000022 		vstl.nc	%v34,4,%s52
 3622      B4040093 
 3623              	# line 735
 735:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwb[iw] = kwe[iw] - OW*SW + SW;
 3624              		.loc	1 735 0
 3625 4be0 1C000000 		ldl.sx	%s52,28(,%s63)	# *(p).__b_N4conv6desc_tE.ow
 3625      BF003403 
 3626 4be8 00000000 		adds.w.sx	%s52,-1,%s52
 3626      B47F344A 
 3627 4bf0 00000021 		vbrd	%v33,%s52
 3627      00B4008C 
 3628 4bf8 00000000 		adds.l	%s52,%s57,(0)1
 3628      00B93459 
 3629 4c00 00000000 		adds.l	%s51,%s52,%s58
 3629      BAB43359 
 3630 4c08 00000021 		vstl.nc	%v33,4,%s51
 3630      B3040093 
 3631              	# line 736
 736:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( kwb[iw] < SW - 1 ){ // unlikely?
 3632              		.loc	1 736 0
 3633 4c10 00000000 		adds.l	%s51,%s62,%s58
 3633      BABE3359 
 3634 4c18 00000020 		vldl.sx.nc	%v32,4,%s51
 3634      B3040083 
 3635 4c20 1C000000 		ldl.sx	%s51,28(,%s63)	# *(p).__b_N4conv6desc_tE.ow
 3635      BF003303 
 3636 4c28 2C000000 		ldl.sx	%s50,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 3636      BF003203 
 3637 4c30 00000000 		muls.w.sx	%s51,%s51,%s50
 3637      B2B3334B 
 3638 4c38 00000000 		subs.w.sx	%s51,0,%s51
 3638      B300335A 
 3639 4c40 0020001F 		vadds.w.sx	%v31,%s51,%v32
 3639      00B320CA 
 3640 4c48 001F001E 		vadds.w.sx	%v30,%s50,%v31
 3640      00B220CA 
 3641 4c50 00000000 		adds.l	%s51,%s56,(0)1
 3641      00B83359 
 3642 4c58 00000000 		adds.l	%s50,%s51,%s58
 3642      BAB33259 
 3643 4c60 0000001E 		vstl.nc	%v30,4,%s50
 3643      B2040093 
 3644              	# line 737
 737:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       owb[iw] = kwe[iw] / SW;
 3645              		.loc	1 737 0
 3646 4c68 2C000000 		ldl.sx	%s50,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 3646      BF003203 
 3647 4c70 00000000 		adds.w.sx	%s49,-1,%s50
 3647      B27F314A 
 3648 4c78 001E001D 		vcmps.w.sx	%v29,%s49,%v30
 3648      00B120FA 
 3649 4c80 001D010F 		vfmk.w.gt	%vm15,%v29
 3649      000000B5 
 3650              	# line 738
 738:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       kwb[iw] = kwe[iw] % SW;
 3651              		.loc	1 738 0
 3652 4c88 00000000 		adds.l	%s49,%s62,%s58
 3652      BABE3159 
 3653 4c90 0000001C 		vldl.sx.nc	%v28,4,%s49
 3653      B1040083 
 3654 4c98 00001C27 		vdivs.w.sx	%v39,%v28,%s50,%vm15
 3654      00B21FEB 
 3655 4ca0 00000000 		adds.l	%s52,%s52,%s58
 3655      BAB43459 
 3656 4ca8 00000027 		vstl.nc	%v39,4,%s52,%vm15
 3656      B4040F93 
 3657              	# line 739
 739:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 3658              		.loc	1 739 0
 3659 4cb0 00000000 		adds.l	%s52,%s62,%s58
 3659      BABE3459 
 3660 4cb8 0000001B 		vldl.sx.nc	%v27,4,%s52
 3660      B4040083 
 3661 4cc0 2C000000 		ldl.sx	%s52,44(,%s63)	# *(p).__b_N4conv6desc_tE.sw
 3661      BF003403 
 3662 4cc8 00001B26 		vdivs.w.sx	%v38,%v27,%s52,%vm15
 3662      00B41FEB 
 3663 4cd0 00260025 		vmuls.w.sx	%v37,%s52,%v38,%vm15
 3663      00B42FCB 
 3664 4cd8 00251B24 		vsubs.w.sx	%v36,%v27,%v37,%vm15
 3664      00000FDA 
 3665 4ce0 00000000 		adds.l	%s51,%s51,%s58
 3665      BAB33359 
 3666 4ce8 00000024 		vstl.nc	%v36,4,%s51,%vm15
 3666      B3040F93 
 3667              	# line 741
 741:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 3668              		.loc	1 741 0
 3669 4cf0 00000000 		adds.l	%s52,%s62,%s58
 3669      BABE3459 
 3670 4cf8 0000001A 		vldl.sx.nc	%v26,4,%s52
 3670      B4040083 
 3671 4d00 001A0019 		vadds.w.sx	%v25,1,%v26
 3671      000120CA 
 3672 4d08 00000000 		adds.l	%s52,%s62,%s58
 3672      BABE3459 
 3673 4d10 00000019 		vstl.nc	%v25,4,%s52
 3673      B4040093 
 3674 4d18 24000000 		ldl.sx	%s52,36(,%s63)	# *(p).__b_N4conv6desc_tE.kw
 3674      BF003403 
 3675 4d20 00190018 		vcmps.w.sx	%v24,%s52,%v25
 3675      00B420FA 
 3676 4d28 0018020F 		vfmk.w.lt	%vm15,%v24
 3676      000000B5 
 3677 4d30 00000017 		vbrd	%v23,%s52
 3677      00B4008C 
 3678 4d38 00000000 		adds.l	%s62,%s62,%s58
 3678      BABE3E59 
 3679 4d40 00000017 		vstl.nc	%v23,4,%s62,%vm15
 3679      BE040F93 
 3680              	# line 733
 733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwe[iw] = iw + PW;
 3681              		.loc	1 733 0
 3682 4d48 00000000 		adds.w.sx	%s61,%s61,%s55
 3682      B7BD3D4A 
 3683 4d50 00000000 		adds.l	%s58,%s58,%s54
 3683      B6BA3A59 
 3684 4d58 00000000 		subs.w.sx	%s53,%s53,%s60
 3684      BCB5355A 
 3685 4d60 38FEFFFF 		brge.w	0,%s53,.L5.43
 3685      B5008518 
 3686 4d68 A8F3FFFF 		br.l	.L5.4
 3686      00000F18 
 3687              	.L5.44:
 3688 4d70 00000000 		subs.w.sx	%s18,0,%s18
 3688      9200125A 
 3689 4d78 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3689      89003F01 
 3690 4d80 00000000 		subs.w.sx	%s18,0,%s18
 3690      9200125A 
 3691 4d88 00000000 		smvl	%s62
 3691      00003E2E 
 3692 4d90 80000000 		mins.w.sx	%s60,%s18,%s62
 3692      BE923C78 
 3693 4d98 00000000 		or	%s53,0,%s18
 3693      92003545 
 3694 4da0 00000000 		or	%s61,0,(0)1
 3694      00003D45 
 3695 4da8 00000000 		or	%s55,0,%s60
 3695      BC003745 
 3696 4db0 00000000 		lvl	%s60
 3696      00BC00BF 
 3697 4db8 00000015 		vseq	%v21
 3697      00000099 
 3698 4dc0 00150028 		vor	%v40,(0)1,%v21
 3698      000020C5 
 3699 4dc8 00000000 		or	%s58,0,(0)1
 3699      00003A45 
 3700 4dd0 00000000 		or	%s62,0,%s60
 3700      BC003E45 
 3701 4dd8 00000000 		muls.l	%s54,4,%s62
 3701      BE04366E 
 3702 4de0 C8FDFFFF 		br.l	.L5.5
 3702      00000F18 
 3703              	.L5.45:
 3704 4de8 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3704      89003F01 
 3705              	# line 732
 732:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int iw = 0; iw < IW; ++iw) {
 3706              		.loc	1 732 0
 3707 4df0 10000000 		ldl.sx	%s62,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 3707      BF003E03 
 3708 4df8 00000000 		or	%s62,0,%s62
 3708      BE003E45 
 3709 4e00 00000000 		adds.l	%s23,%fp,(59)1
 3709      3B891759 
 3710 4e08 00000000 		muls.l	%s0,4,%s62
 3710      BE04006E 
 3711 4e10 00000000 		lea	%s12,__grow_stack@LO
 3711      00000C06 
 3712 4e18 00000000 		and	%s12,%s12,(32)0
 3712      608C0C44 
 3713 4e20 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3713      8C008C06 
 3714 4e28 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3714      8C000A08 
 3715 4e30 D0000000 		lea	%s62,208
 3715      00003E06 
 3716 4e38 00000000 		adds.l	%s62,%sp,%s62
 3716      BE8B3E59 
 3717 4e40 00000000 		st	%s62,0(,%s23)
 3717      97003E11 
 3718 4e48 E0FFFFFF 		ld	%s62,-32(,%fp)	# kwb
 3718      89003E01 
 3719 4e50 B0FFFFFF 		lea	%s61,-80
 3719      00003D06 
 3720 4e58 00000000 		st	%s62,0(%s61,%fp)
 3720      89BD3E11 
 3721 4e60 00000000 		lea	%s23,__eh_curr_region@LO
 3721      00001706 
 3722 4e68 00000000 		and	%s23,%s23,(32)0
 3722      60971744 
 3723 4e70 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 3723      97009706 
 3724 4e78 00000000 		or	%s62,3,(0)1
 3724      00033E45 
 3725 4e80 00000000 		st2b	%s62,0(,%s23)
 3725      97003E14 
 3726 4e88 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3726      89003F01 
 3727 4e90 10000000 		ldl.sx	%s62,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 3727      BF003E03 
 3728 4e98 00000000 		or	%s62,0,%s62
 3728      BE003E45 
 3729 4ea0 00000000 		adds.l	%s24,%fp,(60)1
 3729      3C891859 
 3730 4ea8 00000000 		muls.l	%s0,4,%s62
 3730      BE04006E 
 3731 4eb0 00000000 		lea	%s12,__grow_stack@LO
 3731      00000C06 
 3732 4eb8 00000000 		and	%s12,%s12,(32)0
 3732      608C0C44 
 3733 4ec0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3733      8C008C06 
 3734 4ec8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3734      8C000A08 
 3735 4ed0 D0000000 		lea	%s62,208
 3735      00003E06 
 3736 4ed8 00000000 		adds.l	%s62,%sp,%s62
 3736      BE8B3E59 
 3737 4ee0 00000000 		st	%s62,0(,%s24)
 3737      98003E11 
 3738 4ee8 F0FFFFFF 		ld	%s62,-16(,%fp)	# kwe
 3738      89003E01 
 3739 4ef0 B8FFFFFF 		lea	%s61,-72
 3739      00003D06 
 3740 4ef8 00000000 		st	%s62,0(%s61,%fp)
 3740      89BD3E11 
 3741 4f00 00000000 		or	%s62,4,(0)1
 3741      00043E45 
 3742 4f08 00000000 		st2b	%s62,0(,%s23)
 3742      97003E14 
 3743 4f10 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3743      89003F01 
 3744 4f18 10000000 		ldl.sx	%s62,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 3744      BF003E03 
 3745 4f20 00000000 		or	%s62,0,%s62
 3745      BE003E45 
 3746 4f28 E8FFFFFF 		lea	%s61,-24
 3746      00003D06 
 3747 4f30 00000000 		adds.l	%s24,%fp,%s61
 3747      BD891859 
 3748 4f38 00000000 		muls.l	%s0,4,%s62
 3748      BE04006E 
 3749 4f40 00000000 		lea	%s12,__grow_stack@LO
 3749      00000C06 
 3750 4f48 00000000 		and	%s12,%s12,(32)0
 3750      608C0C44 
 3751 4f50 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3751      8C008C06 
 3752 4f58 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3752      8C000A08 
 3753 4f60 D0000000 		lea	%s62,208
 3753      00003E06 
 3754 4f68 00000000 		adds.l	%s62,%sp,%s62
 3754      BE8B3E59 
 3755 4f70 00000000 		st	%s62,0(,%s24)
 3755      98003E11 
 3756 4f78 E8FFFFFF 		ld	%s57,-24(,%fp)	# owb
 3756      89003901 
 3757 4f80 C0FFFFFF 		lea	%s62,-64
 3757      00003E06 
 3758 4f88 00000000 		st	%s57,0(%s62,%fp)
 3758      89BE3911 
 3759 4f90 00000000 		or	%s62,5,(0)1
 3759      00053E45 
 3760 4f98 00000000 		st2b	%s62,0(,%s23)
 3760      97003E14 
 3761 4fa0 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3761      89003F01 
 3762              	# line 733
 733:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     kwe[iw] = iw + PW;
 3763              		.loc	1 733 0
 3764 4fa8 10000000 		ldl.sx	%s18,16(,%s63)	# *(p).__b_N4conv6desc_tE.iw
 3764      BF001203 
 3765 4fb0 F0FFFFFF 		ld	%s59,-16(,%fp)	# kwe
 3765      89003B01 
 3766 4fb8 E0FFFFFF 		ld	%s56,-32(,%fp)	# kwb
 3766      89003801 
 3767 4fc0 B0FDFFFF 		brlt.w	0,%s18,.L5.44
 3767      92008218 
 3768 4fc8 B0FBFFFF 		br.l	.L5.42
 3768      00000F18 
 3769              	.L5.46:
 3770 4fd0 C0F4FFFF 		st	%s63,-2880(,%fp)	# spill 
 3770      89003F11 
 3771 4fd8 10FEFFFF 		br.l	.L5.45
 3771      00000F18 
 3772              	.L5.3:
 3773              	# line 723
 723:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     ohb[ih] = OH - 1;
 3774              		.loc	1 723 0
 3775 4fe0 30000000 		ldl.sx	%s62,48(,%s63)	# *(p).__b_N4conv6desc_tE.ph
 3775      BF003E03 
 3776 4fe8 00000000 		lvl	%s60
 3776      00BC00BF 
 3777 4ff0 003A0035 		vadds.w.sx	%v53,%s61,%v58
 3777      00BD20CA 
 3778 4ff8 00350034 		vadds.w.sx	%v52,%s62,%v53
 3778      00BE20CA 
 3779 5000 00000000 		adds.l	%s62,%s59,(0)1
 3779      00BB3E59 
 3780 5008 00000000 		adds.l	%s52,%s62,%s58
 3780      BABE3459 
 3781 5010 00000034 		vstl.nc	%v52,4,%s52
 3781      B4040093 
 3782              	# line 724
 724:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     khb[ih] = khe[ih] - OH*SH + SH;
 3783              		.loc	1 724 0
 3784 5018 18000000 		ldl.sx	%s52,24(,%s63)	# *(p).__b_N4conv6desc_tE.oh
 3784      BF003403 
 3785 5020 00000000 		adds.w.sx	%s52,-1,%s52
 3785      B47F344A 
 3786 5028 00000033 		vbrd	%v51,%s52
 3786      00B4008C 
 3787 5030 00000000 		adds.l	%s52,%s57,(0)1
 3787      00B93459 
 3788 5038 00000000 		adds.l	%s51,%s52,%s58
 3788      BAB43359 
 3789 5040 00000033 		vstl.nc	%v51,4,%s51
 3789      B3040093 
 3790              	# line 725
 725:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if( khb[ih] < SH - 1 ){ // unlikely?
 3791              		.loc	1 725 0
 3792 5048 00000000 		adds.l	%s51,%s62,%s58
 3792      BABE3359 
 3793 5050 00000032 		vldl.sx.nc	%v50,4,%s51
 3793      B3040083 
 3794 5058 18000000 		ldl.sx	%s51,24(,%s63)	# *(p).__b_N4conv6desc_tE.oh
 3794      BF003303 
 3795 5060 28000000 		ldl.sx	%s50,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 3795      BF003203 
 3796 5068 00000000 		muls.w.sx	%s51,%s51,%s50
 3796      B2B3334B 
 3797 5070 00000000 		subs.w.sx	%s51,0,%s51
 3797      B300335A 
 3798 5078 00320031 		vadds.w.sx	%v49,%s51,%v50
 3798      00B320CA 
 3799 5080 00310030 		vadds.w.sx	%v48,%s50,%v49
 3799      00B220CA 
 3800 5088 00000000 		adds.l	%s51,%s56,(0)1
 3800      00B83359 
 3801 5090 00000000 		adds.l	%s50,%s51,%s58
 3801      BAB33259 
 3802 5098 00000030 		vstl.nc	%v48,4,%s50
 3802      B2040093 
 3803              	# line 726
 726:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohb[ih] = khe[ih] / SH;
 3804              		.loc	1 726 0
 3805 50a0 28000000 		ldl.sx	%s50,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 3805      BF003203 
 3806 50a8 00000000 		adds.w.sx	%s49,-1,%s50
 3806      B27F314A 
 3807 50b0 0030002F 		vcmps.w.sx	%v47,%s49,%v48
 3807      00B120FA 
 3808 50b8 002F010F 		vfmk.w.gt	%vm15,%v47
 3808      000000B5 
 3809              	# line 727
 727:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       khb[ih] = khe[ih] % SH;
 3810              		.loc	1 727 0
 3811 50c0 00000000 		adds.l	%s49,%s62,%s58
 3811      BABE3159 
 3812 50c8 0000002E 		vldl.sx.nc	%v46,4,%s49
 3812      B1040083 
 3813 50d0 00002E39 		vdivs.w.sx	%v57,%v46,%s50,%vm15
 3813      00B21FEB 
 3814 50d8 00000000 		adds.l	%s52,%s52,%s58
 3814      BAB43459 
 3815 50e0 00000039 		vstl.nc	%v57,4,%s52,%vm15
 3815      B4040F93 
 3816              	# line 728
 728:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 3817              		.loc	1 728 0
 3818 50e8 00000000 		adds.l	%s52,%s62,%s58
 3818      BABE3459 
 3819 50f0 0000002D 		vldl.sx.nc	%v45,4,%s52
 3819      B4040083 
 3820 50f8 28000000 		ldl.sx	%s52,40(,%s63)	# *(p).__b_N4conv6desc_tE.sh
 3820      BF003403 
 3821 5100 00002D38 		vdivs.w.sx	%v56,%v45,%s52,%vm15
 3821      00B41FEB 
 3822 5108 00380037 		vmuls.w.sx	%v55,%s52,%v56,%vm15
 3822      00B42FCB 
 3823 5110 00372D36 		vsubs.w.sx	%v54,%v45,%v55,%vm15
 3823      00000FDA 
 3824 5118 00000000 		adds.l	%s51,%s51,%s58
 3824      BAB33359 
 3825 5120 00000036 		vstl.nc	%v54,4,%s51,%vm15
 3825      B3040F93 
 3826              	# line 730
 730:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 3827              		.loc	1 730 0
 3828 5128 00000000 		adds.l	%s52,%s62,%s58
 3828      BABE3459 
 3829 5130 0000002C 		vldl.sx.nc	%v44,4,%s52
 3829      B4040083 
 3830 5138 002C002B 		vadds.w.sx	%v43,1,%v44
 3830      000120CA 
 3831 5140 00000000 		adds.l	%s52,%s62,%s58
 3831      BABE3459 
 3832 5148 0000002B 		vstl.nc	%v43,4,%s52
 3832      B4040093 
 3833 5150 20000000 		ldl.sx	%s52,32(,%s63)	# *(p).__b_N4conv6desc_tE.kh
 3833      BF003403 
 3834 5158 002B002A 		vcmps.w.sx	%v42,%s52,%v43
 3834      00B420FA 
 3835 5160 002A020F 		vfmk.w.lt	%vm15,%v42
 3835      000000B5 
 3836 5168 00000029 		vbrd	%v41,%s52
 3836      00B4008C 
 3837 5170 00000000 		adds.l	%s62,%s62,%s58
 3837      BABE3E59 
 3838 5178 00000029 		vstl.nc	%v41,4,%s62,%vm15
 3838      BE040F93 
 3839              	# line 721
 721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //int ocend = (OC/G);
 3840              		.loc	1 721 0
 3841 5180 00000000 		adds.w.sx	%s61,%s61,%s55
 3841      B7BD3D4A 
 3842 5188 00000000 		adds.l	%s58,%s58,%s54
 3842      B6BA3A59 
 3843 5190 00000000 		subs.w.sx	%s53,%s53,%s60
 3843      BCB5355A 
 3844 5198 38FEFFFF 		brge.w	0,%s53,.L5.46
 3844      B5008518 
 3845 51a0 60EFFFFF 		br.l	.L5.2
 3845      00000F18 
 3846              	.L5.47:
 3847 51a8 00000000 		subs.w.sx	%s18,0,%s18
 3847      9200125A 
 3848 51b0 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3848      89003F01 
 3849 51b8 00000000 		subs.w.sx	%s18,0,%s18
 3849      9200125A 
 3850 51c0 00000000 		smvl	%s62
 3850      00003E2E 
 3851 51c8 80000000 		mins.w.sx	%s60,%s18,%s62
 3851      BE923C78 
 3852 51d0 00000000 		or	%s53,0,%s18
 3852      92003545 
 3853 51d8 00000000 		or	%s61,0,(0)1
 3853      00003D45 
 3854 51e0 00000000 		or	%s55,0,%s60
 3854      BC003745 
 3855 51e8 00000000 		lvl	%s60
 3855      00BC00BF 
 3856 51f0 00000016 		vseq	%v22
 3856      00000099 
 3857 51f8 0016003A 		vor	%v58,(0)1,%v22
 3857      000020C5 
 3858 5200 00000000 		or	%s58,0,(0)1
 3858      00003A45 
 3859 5208 00000000 		or	%s62,0,%s60
 3859      BC003E45 
 3860 5210 00000000 		muls.l	%s54,4,%s62
 3860      BE04366E 
 3861 5218 C8FDFFFF 		br.l	.L5.3
 3861      00000F18 
 3862              	.L5.48:
 3863 5220 C0F4FFFF 		st	%s0,-2880(,%fp)	# spill 
 3863      89000011 
 3864              	# line 720
 720:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int ih = 0; ih < IH; ++ih) {
 3865              		.loc	1 720 0
 3866 5228 0C000000 		ldl.sx	%s61,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 3866      80003D03 
 3867 5230 00000000 		or	%s61,0,%s61
 3867      BD003D45 
 3868 5238 C8FFFFFF 		lea	%s60,-56
 3868      00003C06 
 3869 5240 00000000 		adds.l	%s23,%fp,%s60
 3869      BC891759 
 3870 5248 00000000 		muls.l	%s0,4,%s61
 3870      BD04006E 
 3871 5250 00000000 		lea	%s12,__grow_stack@LO
 3871      00000C06 
 3872 5258 00000000 		and	%s12,%s12,(32)0
 3872      608C0C44 
 3873 5260 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3873      8C008C06 
 3874 5268 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3874      8C000A08 
 3875 5270 D0000000 		lea	%s61,208
 3875      00003D06 
 3876 5278 00000000 		adds.l	%s61,%sp,%s61
 3876      BD8B3D59 
 3877 5280 00000000 		lea	%s60,0
 3877      00003C06 
 3878 5288 00000000 		st	%s61,0(,%s23)
 3878      97003D11 
 3879 5290 C8FFFFFF 		ld	%s61,-56(,%fp)	# khb
 3879      89003D01 
 3880 5298 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3880      89003F01 
 3881 52a0 98FFFFFF 		st	%s61,-104(,%fp)
 3881      89003D11 
 3882 52a8 00000000 		st2b	%s60,0(,%s62)
 3882      BE003C14 
 3883 52b0 0C000000 		ldl.sx	%s61,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 3883      BF003D03 
 3884 52b8 00000000 		or	%s61,0,%s61
 3884      BD003D45 
 3885 52c0 D0FFFFFF 		lea	%s60,-48
 3885      00003C06 
 3886 52c8 00000000 		adds.l	%s23,%fp,%s60
 3886      BC891759 
 3887 52d0 00000000 		muls.l	%s0,4,%s61
 3887      BD04006E 
 3888 52d8 00000000 		lea	%s12,__grow_stack@LO
 3888      00000C06 
 3889 52e0 00000000 		and	%s12,%s12,(32)0
 3889      608C0C44 
 3890 52e8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3890      8C008C06 
 3891 52f0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3891      8C000A08 
 3892 52f8 D0000000 		lea	%s61,208
 3892      00003D06 
 3893 5300 00000000 		adds.l	%s61,%sp,%s61
 3893      BD8B3D59 
 3894 5308 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3894      89003F01 
 3895 5310 00000000 		st	%s61,0(,%s23)
 3895      97003D11 
 3896 5318 D0FFFFFF 		ld	%s61,-48(,%fp)	# khe
 3896      89003D01 
 3897 5320 A0FFFFFF 		lea	%s60,-96
 3897      00003C06 
 3898 5328 00000000 		st	%s61,0(%s60,%fp)
 3898      89BC3D11 
 3899 5330 00000000 		or	%s61,1,(0)1
 3899      00013D45 
 3900 5338 00000000 		st2b	%s61,0(,%s62)
 3900      BE003D14 
 3901 5340 0C000000 		ldl.sx	%s61,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 3901      BF003D03 
 3902 5348 00000000 		or	%s61,0,%s61
 3902      BD003D45 
 3903 5350 D8FFFFFF 		lea	%s60,-40
 3903      00003C06 
 3904 5358 00000000 		adds.l	%s23,%fp,%s60
 3904      BC891759 
 3905 5360 00000000 		muls.l	%s0,4,%s61
 3905      BD04006E 
 3906 5368 00000000 		lea	%s12,__grow_stack@LO
 3906      00000C06 
 3907 5370 00000000 		and	%s12,%s12,(32)0
 3907      608C0C44 
 3908 5378 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 3908      8C008C06 
 3909 5380 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 3909      8C000A08 
 3910 5388 D0000000 		lea	%s61,208
 3910      00003D06 
 3911 5390 00000000 		adds.l	%s61,%sp,%s61
 3911      BD8B3D59 
 3912 5398 C0F4FFFF 		ld	%s63,-2880(,%fp)	# restore 
 3912      89003F01 
 3913 53a0 00000000 		st	%s61,0(,%s23)
 3913      97003D11 
 3914 53a8 D8FFFFFF 		ld	%s57,-40(,%fp)	# ohb
 3914      89003901 
 3915 53b0 A8FFFFFF 		lea	%s61,-88
 3915      00003D06 
 3916 53b8 00000000 		st	%s57,0(%s61,%fp)
 3916      89BD3911 
 3917 53c0 00000000 		or	%s61,2,(0)1
 3917      00023D45 
 3918 53c8 00000000 		st2b	%s61,0(,%s62)
 3918      BE003D14 
 3919              	# line 721
 721:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     //int ocend = (OC/G);
 3920              		.loc	1 721 0
 3921 53d0 0C000000 		ldl.sx	%s18,12(,%s63)	# *(p).__b_N4conv6desc_tE.ih
 3921      BF001203 
 3922 53d8 D0FFFFFF 		ld	%s59,-48(,%fp)	# khe
 3922      89003B01 
 3923 53e0 C8FFFFFF 		ld	%s56,-56(,%fp)	# khb
 3923      89003801 
 3924 53e8 C0FDFFFF 		brlt.w	0,%s18,.L5.47
 3924      92008218 
 3925 53f0 F8F9FFFF 		br.l	.L5.45
 3925      00000F18 
 3926              	.L5.49:
 3927 53f8 D0000000 		br.l	.L5.50
 3927      00000F18 
 3928              	.L5.1:
 3929              	# line 714
 714:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // FIXME can we call this even less?
 3930              		.loc	1 714 0
 3931 5400 3C000000 		ldl.sx	%s18,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 3931      80001203 
 3932 5408 F0FFFFFF 		brne.w	0,%s18,.L5.49
 3932      92008318 
 3933 5410 10FEFFFF 		br.l	.L5.48
 3933      00000F18 
 3934              	.L5.9:
 3935              	# line 778
 770:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 771:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 772:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 773:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 774:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 775:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 776:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #error "please enable one impl"
 777:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 778:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 3936              		.loc	1 778 0
 3937              	# Start of epilogue codes
 3938 5418 30000000 		ld	%s18,48(,%fp)
 3938      89001201 
 3939 5420 38000000 		ld	%s19,56(,%fp)
 3939      89001301 
 3940 5428 40000000 		ld	%s20,64(,%fp)
 3940      89001401 
 3941 5430 48000000 		ld	%s21,72(,%fp)
 3941      89001501 
 3942 5438 50000000 		ld	%s22,80(,%fp)
 3942      89001601 
 3943 5440 58000000 		ld	%s23,88(,%fp)
 3943      89001701 
 3944 5448 60000000 		ld	%s24,96(,%fp)
 3944      89001801 
 3945 5450 68000000 		ld	%s25,104(,%fp)
 3945      89001901 
 3946 5458 70000000 		ld	%s26,112(,%fp)
 3946      89001A01 
 3947 5460 78000000 		ld	%s27,120(,%fp)
 3947      89001B01 
 3948 5468 80000000 		ld	%s28,128(,%fp)
 3948      89001C01 
 3949 5470 88000000 		ld	%s29,136(,%fp)
 3949      89001D01 
 3950 5478 90000000 		ld	%s30,144(,%fp)
 3950      89001E01 
 3951 5480 98000000 		ld	%s31,152(,%fp)
 3951      89001F01 
 3952 5488 A0000000 		ld	%s32,160(,%fp)
 3952      89002001 
 3953 5490 A8000000 		ld	%s33,168(,%fp)
 3953      89002101 
 3954 5498 00000000 		or	%sp,0,%fp
 3954      89000B45 
 3955              		.cfi_def_cfa	11,8
 3956 54a0 18000000 		ld	%got,0x18(,%sp)
 3956      8B000F01 
 3957 54a8 20000000 		ld	%plt,0x20(,%sp)
 3957      8B001001 
 3958 54b0 08000000 		ld	%lr,0x8(,%sp)
 3958      8B000A01 
 3959 54b8 00000000 		ld	%fp,0x0(,%sp)
 3959      8B000901 
 3960 54c0 00000000 		b.l	(,%lr)
 3960      8A000F19 
 3961              	.L5.50:
 3962              	# line 716
 716:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     return;
 3963              		.loc	1 716 0
 3964 54c8 00000000 		lea	%s12,conv::refconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@LO
 3964      00000C06 
 3965 54d0 00000000 		and	%s12,%s12,(32)0
 3965      608C0C44 
 3966 54d8 00000000 		lea.sl	%s12,conv::refconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)@HI(,%s12)
 3966      8C008C06 
 3967 54e0 00000000 		bsic	%lr,(,%s12)	# conv::refconv_3_bwd_d_generic(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 3967      8C000A08 
 3968 54e8 48FEFFFF 		ld2b.zx	%s63,-440(,%fp)
 3968      8900BF04 
 3969 54f0 00000000 		lea	%s62,__eh_curr_region@LO
 3969      00003E06 
 3970 54f8 00000000 		and	%s62,%s62,(32)0
 3970      60BE3E44 
 3971 5500 00000000 		lea.sl	%s62,__eh_curr_region@HI(,%s62)
 3971      BE00BE06 
 3972 5508 00000000 		st2b	%s63,0(,%s62)
 3972      BE003F14 
 3973 5510 20FEFFFF 		ld	%s63,-480(,%fp)
 3973      89003F01 
 3974 5518 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 3974      00003E06 
 3975 5520 00000000 		and	%s62,%s62,(32)0
 3975      60BE3E44 
 3976 5528 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 3976      BE00BE06 
 3977 5530 00000000 		st	%s63,0(,%s62)
 3977      BE003F11 
 3978 5538 E0FEFFFF 		br.l	.L5.9
 3978      00000F18 
 3979              	.L5.0:
 3980 5540 88FFFFFF 		br.l	.L5.50
 3980      00000F18 
 3981              		.cfi_endproc
 3982              		.set	.L.6.2auto_size,	0xffffffffffffda90	# 9584 Bytes
 3984              	# ============ End  conv::refconv_3_bwd_d(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3985              	# ============ Begin  conv::refconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 3986              		.data
 3987              		.balign 16
 3990              	.LP._ZN4conv15refconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0:
 3991 0110 00000000 		.long	__vla_dealloc_eh
 3991      00000000 
 3992 0118 0000     		.zero	2
 3993 011a FFFF     		.short	65535
 3994 011c 04       		.byte	4
 3995 011d 000000   		.zero	3
 3996 0120 00000000 		.long	__vla_dealloc_eh
 3996      00000000 
 3997 0128 0100     		.short	1
 3998 012a 0000     		.zero	2
 3999 012c 04       		.byte	4
 4000 012d 000000   		.zero	3
 4001              		.section .rodata
 4002 00c9 00000000 		.balign 16
 4002      000000
 4004              	.LP._ZN4conv15refconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.ohw_muls.__initializer.0:
 4005 00d0 00000000 		.zero	8
 4005      00000000 
 4006 00d8 01000000 		.long	1
 4006      00000000 
 4007 00e0 00000000 		.zero	8
 4007      00000000 
 4008 00e8 00000001 		.long	16777216
 4008      00000000 
 4009              		.text
 4010 5548 00000000 		.balign 16
 4010      00000000 
 4011              	# line 783
 779:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 780:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** /** This one just reuses the hoisting function from FWD.
 781:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****  * g,oc,ic,kh,kw,mb,oh,ow,[iw],[ih] */
 782:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** void refconv_3_bwd_w(const prb_t *p, dnn_mem_t &src_m,
 783:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     dnn_mem_t &diff_wei_m, dnn_mem_t &diff_bia_m, dnn_mem_t &diff_dst_m) {
 4012              		.loc	1 783 0
 4013              		.globl	conv::refconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&)
 4015              	conv::refconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&):
 4016              		.cfi_startproc
 4017 5550 00000000 		st	%fp,0x0(,%sp)
 4017      8B000911 
 4018              		.cfi_def_cfa_offset	0
 4019              		.cfi_offset	9,0
 4020 5558 08000000 		st	%lr,0x8(,%sp)
 4020      8B000A11 
 4021 5560 18000000 		st	%got,0x18(,%sp)
 4021      8B000F11 
 4022 5568 20000000 		st	%plt,0x20(,%sp)
 4022      8B001011 
 4023 5570 00000000 		or	%fp,0,%sp
 4023      8B000945 
 4024              		.cfi_def_cfa_register	9
 4025 5578 30000000 		st	%s18,48(,%fp)
 4025      89001211 
 4026 5580 38000000 		st	%s19,56(,%fp)
 4026      89001311 
 4027 5588 40000000 		st	%s20,64(,%fp)
 4027      89001411 
 4028 5590 48000000 		st	%s21,72(,%fp)
 4028      89001511 
 4029 5598 50000000 		st	%s22,80(,%fp)
 4029      89001611 
 4030 55a0 58000000 		st	%s23,88(,%fp)
 4030      89001711 
 4031 55a8 60000000 		st	%s24,96(,%fp)
 4031      89001811 
 4032 55b0 68000000 		st	%s25,104(,%fp)
 4032      89001911 
 4033 55b8 70000000 		st	%s26,112(,%fp)
 4033      89001A11 
 4034 55c0 78000000 		st	%s27,120(,%fp)
 4034      89001B11 
 4035 55c8 80000000 		st	%s28,128(,%fp)
 4035      89001C11 
 4036 55d0 88000000 		st	%s29,136(,%fp)
 4036      89001D11 
 4037 55d8 90000000 		st	%s30,144(,%fp)
 4037      89001E11 
 4038 55e0 98000000 		st	%s31,152(,%fp)
 4038      89001F11 
 4039 55e8 A0000000 		st	%s32,160(,%fp)
 4039      89002011 
 4040 55f0 A8000000 		st	%s33,168(,%fp)
 4040      89002111 
 4041 55f8 E0F9FFFF 		lea	%s13,.L.7.2auto_size&0xffffffff
 4041      00000D06 
 4042 5600 00000000 		and	%s13,%s13,(32)0
 4042      608D0D44 
 4043 5608 FFFFFFFF 		lea.sl	%sp,.L.7.2auto_size>>32(%fp,%s13)
 4043      8D898B06 
 4044 5610 48000000 		brge.l.t	%sp,%sl,.L6.EoP
 4044      888B3518 
 4045 5618 18000000 		ld	%s61,0x18(,%tp)
 4045      8E003D01 
 4046 5620 00000000 		or	%s62,0,%s0
 4046      80003E45 
 4047 5628 3B010000 		lea	%s63,0x13b
 4047      00003F06 
 4048 5630 00000000 		shm.l	%s63,0x0(%s61)
 4048      BD033F31 
 4049 5638 08000000 		shm.l	%sl,0x8(%s61)
 4049      BD030831 
 4050 5640 10000000 		shm.l	%sp,0x10(%s61)
 4050      BD030B31 
 4051 5648 00000000 		monc
 4051      0000003F 
 4052 5650 00000000 		or	%s0,0,%s62
 4052      BE000045 
 4053              	.L6.EoP:
 4054              	# End of prologue codes
 4055 5658 10FDFFFF 		st	%s0,-752(,%fp)	# spill 
 4055      89000011 
 4056 5660 00000000 		lea	%s63,__curr_eh_stack_entry@LO
 4056      00003F06 
 4057 5668 00000000 		and	%s63,%s63,(32)0
 4057      60BF3F44 
 4058 5670 00000000 		lea.sl	%s63,__curr_eh_stack_entry@HI(,%s63)
 4058      BF00BF06 
 4059 5678 00000000 		ld	%s62,0(,%s63)
 4059      BF003E01 
 4060 5680 48FEFFFF 		st	%s62,-440(,%fp)
 4060      89003E11 
 4061 5688 48FEFFFF 		lea	%s62,-440
 4061      00003E06 
 4062 5690 00000000 		adds.l	%s62,%fp,%s62
 4062      BE893E59 
 4063 5698 00000000 		st	%s62,0(,%s63)
 4063      BF003E11 
 4064 56a0 00000000 		or	%s63,1,(0)1
 4064      00013F45 
 4065 56a8 50FEFFFF 		st1b	%s63,-432(,%fp)
 4065      89003F15 
 4066 56b0 00000000 		lea	%s63,.LP._ZN4conv15refconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@LO
 4066      00003F06 
 4067 56b8 00000000 		and	%s63,%s63,(32)0
 4067      60BF3F44 
 4068 56c0 00000000 		lea.sl	%s63,.LP._ZN4conv15refconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.0.__unnamed.0@HI(,%s63)
 4068      BF00BF06 
 4069 56c8 58FEFFFF 		st	%s63,-424(,%fp)
 4069      89003F11 
 4070 56d0 00000000 		adds.l	%s63,%fp,(58)1
 4070      3A893F59 
 4071 56d8 60FEFFFF 		st	%s63,-416(,%fp)
 4071      89003F11 
 4072 56e0 00000000 		lea	%s23,__eh_curr_region@LO
 4072      00001706 
 4073 56e8 00000000 		and	%s23,%s23,(32)0
 4073      60971744 
 4074 56f0 00000000 		lea.sl	%s23,__eh_curr_region@HI(,%s23)
 4074      97009706 
 4075 56f8 00000000 		ld2b.zx	%s63,0(,%s23)
 4075      9700BF04 
 4076 5700 70FEFFFF 		st2b	%s63,-400(,%fp)
 4076      89003F14 
 4077 5708 FFFF0000 		lea	%s63,65535
 4077      00003F06 
 4078 5710 00000000 		st2b	%s63,0(,%s23)
 4078      97003F14 
 4079              	# line 869
 784:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0 // same, but tidy code
 785:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // regr.sh-BWD_W 2.51x,2.51x
 786:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // TRY : nog offset?
 787:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DH = p->dh + 1;
 788:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DW = p->dw + 1;
 789:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 790:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   OMP(parallel)//;
 791:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   {
 792:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     OMP(for collapse(5))//;
 793:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int g = 0; g < G; ++g) {
 794:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 795:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 796:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 797:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 798:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 799:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 800:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               dw = 0;
 801:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 802:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 803:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 804:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 805:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 806:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
 807:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     OMP(for collapse(4))//;
 808:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int g = 0; g < G; ++g) {
 809:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 810:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 811:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 812:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 813:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_beg, oh_end;
 814:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               oh_beg = div_floor(    + PH - kh*DH + SH - 1, SH);//(c-a+b-1)/b
 815:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               oh_end = div_floor( IH + PH - kh*DH + SH - 1, SH);//(d-a+b-1)/b
 816:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 817:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (oh_end > OH) oh_end = OH;
 818:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ow_beg, ow_end;
 819:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
 820:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
 821:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
 822:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (ow_end > OW) ow_end = OW;
 823:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
 824:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 825:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ic = 0; ic < IC/G; ++ic) { // involved in WRITE
 826:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 827:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 float &dw = ((float*)diff_wei_m)[wei_off];
 828:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int mb = 0; mb < MB; ++mb) {
 829:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 830:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 831:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       const int ih = oh * SH - PH + kh * DH;
 832:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       const int iw = ow * SW - PW + kw * DW;
 833:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 834:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 835:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       dw += ((float*)diff_dst_m)[dst_off]
 836:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                         * ((float*)src_m)[src_off];
 837:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     }
 838:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 839:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 840:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 841:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 842:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 843:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 844:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 845:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 846:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 847:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if ((p->dir & FLAG_BIA)) {
 848:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       OMP(for collapse(2) nowait)//;
 849:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int g = 0; g < G; ++g) {
 850:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 851:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 852:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
 853:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           db = 0;
 854:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 855:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 856:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 857:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 858:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 db += ((float*)diff_dst_m)[dst_off];
 859:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 860:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 861:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 862:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 863:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 864:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 865:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 866:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #elif 1 // same, but tidy code
 867:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // regr.sh-BWD_W 2.51x,2.51x
 868:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // TRY : nog offset?
 869:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DH = p->dh + 1;
 4080              		.loc	1 869 0
 4081 5718 38000000 		ldl.sx	%s63,56(,%s0)	# *(p).__b_N4conv6desc_tE.dh
 4081      80003F03 
 4082 5720 00000000 		adds.w.sx	%s41,1,%s63
 4082      BF01294A 
 4083              	# line 870
 870:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const int DW = p->dw + 1;
 4084              		.loc	1 870 0
 4085 5728 3C000000 		ldl.sx	%s63,60(,%s0)	# *(p).__b_N4conv6desc_tE.dw
 4085      80003F03 
 4086 5730 00000000 		adds.w.sx	%s24,1,%s63
 4086      BF01184A 
 4087              	# line 873
 871:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 872:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   // precalc nice loop limits
 873:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   ssize_t ohw_begend[KH*KW][4];
 4088              		.loc	1 873 0
 4089 5738 20000000 		ldl.sx	%s63,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 4089      80003F03 
 4090 5740 24000000 		ldl.sx	%s62,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 4090      80003E03 
 4091 5748 00000000 		muls.w.sx	%s62,%s63,%s62
 4091      BEBF3E4B 
 4092 5750 00000000 		or	%s62,0,%s62
 4092      BE003E45 
 4093 5758 00000000 		muls.l	%s62,4,%s62
 4093      BE043E6E 
 4094 5760 40FEFFFF 		lea	%s63,-448
 4094      00003F06 
 4095 5768 00000000 		adds.l	%s25,%fp,%s63
 4095      BF891959 
 4096 5770 00000000 		muls.l	%s0,8,%s62
 4096      BE08006E 
 4097 5778 00000000 		lea	%s12,__grow_stack@LO
 4097      00000C06 
 4098 5780 00000000 		and	%s12,%s12,(32)0
 4098      608C0C44 
 4099 5788 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4099      8C008C06 
 4100 5790 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4100      8C000A08 
 4101 5798 B8000000 		lea	%s63,184
 4101      00003F06 
 4102 57a0 00000000 		adds.l	%s63,%sp,%s63
 4102      BF8B3F59 
 4103 57a8 00000000 		lea	%s62,0
 4103      00003E06 
 4104 57b0 00000000 		st	%s63,0(,%s25)
 4104      99003F11 
 4105 57b8 40FEFFFF 		ld	%s63,-448(,%fp)	# ohw_begend
 4105      89003F01 
 4106 57c0 10FDFFFF 		ld	%s61,-752(,%fp)	# restore 
 4106      89003D01 
 4107 57c8 C0FFFFFF 		st	%s63,-64(,%fp)
 4107      89003F11 
 4108 57d0 00000000 		st2b	%s62,0(,%s23)
 4108      97003E14 
 4109              	# line 874
 874:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   const ssize_t ohw_muls[4] = { OW, 1, (1<<24)*OW, (1<<24) };
 4110              		.loc	1 874 0
 4111 57d8 D0FFFFFF 		lea	%s63,-48
 4111      00003F06 
 4112 57e0 00000000 		adds.l	%s63,%fp,%s63
 4112      BF893F59 
 4113 57e8 00000000 		lea	%s62,.LP._ZN4conv15refconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.ohw_muls.__initializer.0@L
 4113      00003E06 
 4114 57f0 00000000 		and	%s62,%s62,(32)0
 4114      60BE3E44 
 4115 57f8 00000000 		lea.sl	%s62,.LP._ZN4conv15refconv_3_bwd_wEPKNS_5prb_tER9dnn_mem_tS4_S4_S4_.ohw_muls.__initializer.
 4115      BE00BE06 
 4116 5800 00000000 		ld	%s60,0(,%s62)	# conflict.I64
 4116      BE003C01 
 4117 5808 00000000 		st	%s60,0(,%s63)	# conflict.I64
 4117      BF003C11 
 4118 5810 00000000 		adds.l	%s60,8,%s62
 4118      BE083C59 
 4119 5818 00000000 		ld	%s60,0(,%s60)	# conflict.I64
 4119      BC003C01 
 4120 5820 00000000 		adds.l	%s59,8,%s63
 4120      BF083B59 
 4121 5828 00000000 		st	%s60,0(,%s59)	# conflict.I64
 4121      BB003C11 
 4122 5830 00000000 		adds.l	%s60,16,%s62
 4122      BE103C59 
 4123 5838 00000000 		ld	%s60,0(,%s60)	# conflict.I64
 4123      BC003C01 
 4124 5840 00000000 		adds.l	%s59,16,%s63
 4124      BF103B59 
 4125 5848 00000000 		st	%s60,0(,%s59)	# conflict.I64
 4125      BB003C11 
 4126 5850 00000000 		adds.l	%s62,24,%s62
 4126      BE183E59 
 4127 5858 00000000 		ld	%s62,0(,%s62)	# conflict.I64
 4127      BE003E01 
 4128 5860 00000000 		adds.l	%s60,24,%s63
 4128      BF183C59 
 4129 5868 00000000 		st	%s62,0(,%s60)	# conflict.I64
 4129      BC003E11 
 4130 5870 1C000000 		ldl.sx	%s62,28(,%s61)	# *(p).__b_N4conv6desc_tE.ow
 4130      BD003E03 
 4131 5878 00000000 		or	%s60,0,%s62
 4131      BE003C45 
 4132 5880 00000000 		st	%s60,0(,%s63)	# long
 4132      BF003C11 
 4133 5888 00000000 		sla.w.sx	%s62,%s62,24
 4133      BE183E66 
 4134 5890 00000000 		or	%s62,0,%s62
 4134      BE003E45 
 4135 5898 E0FFFFFF 		lea	%s63,-32
 4135      00003F06 
 4136 58a0 00000000 		st	%s62,0(%s63,%fp)	# ohw_muls
 4136      89BF3E11 
 4137              	# line 875
 875:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   bool ook[KH*KW];
 4138              		.loc	1 875 0
 4139 58a8 20000000 		ldl.sx	%s63,32(,%s61)	# *(p).__b_N4conv6desc_tE.kh
 4139      BD003F03 
 4140 58b0 24000000 		ldl.sx	%s61,36(,%s61)	# *(p).__b_N4conv6desc_tE.kw
 4140      BD003D03 
 4141 58b8 00000000 		muls.w.sx	%s61,%s63,%s61
 4141      BDBF3D4B 
 4142 58c0 00000000 		or	%s0,0,%s61
 4142      BD000045 
 4143 58c8 00000000 		adds.l	%s25,%fp,(60)1
 4143      3C891959 
 4144 58d0 00000000 		lea	%s12,__grow_stack@LO
 4144      00000C06 
 4145 58d8 00000000 		and	%s12,%s12,(32)0
 4145      608C0C44 
 4146 58e0 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 4146      8C008C06 
 4147 58e8 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 4147      8C000A08 
 4148 58f0 B8000000 		lea	%s63,184
 4148      00003F06 
 4149 58f8 00000000 		adds.l	%s63,%sp,%s63
 4149      BF8B3F59 
 4150 5900 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 4150      89000001 
 4151 5908 00000000 		st	%s63,0(,%s25)
 4151      99003F11 
 4152 5910 F0FFFFFF 		ld	%s63,-16(,%fp)	# ook
 4152      89003F01 
 4153 5918 C8FFFFFF 		lea	%s62,-56
 4153      00003E06 
 4154 5920 00000000 		st	%s63,0(%s62,%fp)
 4154      89BE3F11 
 4155 5928 00000000 		or	%s62,1,(0)1
 4155      00013E45 
 4156 5930 00000000 		st2b	%s62,0(,%s23)
 4156      97003E14 
 4157              	# line 876
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   for (int kh = 0; kh < p->kh; ++kh) {
 4158              		.loc	1 876 0
 4159 5938 20000000 		ldl.sx	%s0,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 4159      80000003 
 4160 5940 F8210000 		brlt.w	0,%s0,.L6.0
 4160      80008218 
 4161 5948 C81B0000 		br.l	.L6.1
 4161      00000F18 
 4162              	.L6.2:
 4163              	# line 879
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 878:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       oh_beg=div_floor(    + PH - kh * (p->dh + 1) + SH - 1, SH);
 4164              		.loc	1 879 0
 4165 5950 00000000 		or	%s63,0,(0)1
 4165      00003F45 
 4166 5958 00000000 		or	%s1,0,%s61
 4166      BD000145 
 4167 5960 00000000 		or	%s61,0,%s63
 4167      BF003D45 
 4168 5968 401F0000 		br.l	.L6.3
 4168      00000F18 
 4169              	.L6.4:
 4170              	# line 881
 880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 4171              		.loc	1 881 0
 4172 5970 00000000 		or	%s55,0,(0)1
 4172      00003745 
 4173 5978 00000000 		or	%s52,0,%s61
 4173      BD003445 
 4174 5980 00000000 		or	%s61,0,%s1
 4174      81003D45 
 4175 5988 00000000 		smvl	%s13
 4175      00000D2E 
 4176 5990 00000000 		lvl	%s13
 4176      008D00BF 
 4177 5998 0020001C 		vor	%v28,(0)1,%v32
 4177      000020C5 
 4178 59a0 001D0000 		br.l	.L6.5
 4178      00000F18 
 4179              	.L6.6:
 4180              	# line 877
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 4181              		.loc	1 877 0
 4182 59a8 80000000 		mins.w.sx	%s58,%s38,%s58
 4182      BAA63A78 
 4183 59b0 981F0000 		br.l	.L6.7
 4183      00000F18 
 4184              	.L6.8:
 4185              	# line 903
 882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (oh_beg < 0 ) oh_beg = 0;
 884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (ow_beg < 0 ) ow_beg = 0;
 885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (oh_end > OH) oh_end = OH;
 886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (ow_end > OW) ow_end = OW;
 887:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       const int khkw = kh*KW+kw;
 888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][0] = oh_beg;
 889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][1] = ow_beg;
 890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][2] = oh_end;
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][3] = ow_end;
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
 893:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 894:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 895:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 896:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   OMP(parallel)//;
 897:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   {
 898:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     OMP(for collapse(5))//;
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int g = 0; g < G; ++g) {
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4186              		.loc	1 903 0
 4187 59b8 80000000 		mins.w.sx	%s62,%s59,%s62
 4187      BEBB3E78 
 4188 59c0 70180000 		br.l	.L6.9
 4188      00000F18 
 4189              	.L6.10:
 4190 59c8 00000000 		smvl	%s13
 4190      00000D2E 
 4191 59d0 00000000 		lvl	%s13
 4191      008D00BF 
 4192 59d8 003C003B 		vor	%v59,(0)1,%v60
 4192      000020C5 
 4193 59e0 480E0000 		br.l	.L6.11
 4193      00000F18 
 4194              	.L6.12:
 4195              	# line 946
 904:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 905:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               float &dw = ((float*)diff_wei_m)[wei_off];
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               dw = 0;
 907:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 908:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 909:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 910:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 911:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 912:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     // writing to dw at wei_off_f(p, g, oc, ic, kh, kw);
 913:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     OMP(for collapse(4))//;
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int g = 0; g < G; ++g) {
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 916:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 919:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 920:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_beg, oh_end;
 921:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               oh_beg = div_floor(    + PH - kh*DH + SH - 1, SH);//(c-a+b-1)/b
 922:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               oh_end = div_floor( IH + PH - kh*DH + SH - 1, SH);//(d-a+b-1)/b
 923:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (oh_beg < 0    ) oh_beg = 0;
 924:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (oh_end > OH) oh_end = OH;
 925:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ow_beg, ow_end;
 926:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               ow_beg = div_floor(    + PW - kw*DW + SW - 1, SW);//(c-a+b-1)/b
 927:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               ow_end = div_floor( IW + PW - kw*DW + SW - 1, SW);//(d-a+b-1)/b
 928:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (ow_beg < 0    ) ow_beg = 0;
 929:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if (ow_end > OW) ow_end = OW;
 930:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if( ow_beg >= ow_end || oh_beg >= oh_end ) continue;
 931:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 932:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               const int khkw = kh*KW+kw;
 933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               if( ! ook[khkw] ) continue;
 934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_beg = ohw_begend[khkw][0];
 935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ow_beg = ohw_begend[khkw][1];
 936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_end = ohw_begend[khkw][2];
 937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ow_end = ohw_begend[khkw][3];
 938:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 939:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ic = 0; ic < IC/G; ++ic) { // involved in WRITE
 941:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 942:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 float &dw = ((float*)diff_wei_m)[wei_off];
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 for (int mb = 0; mb < MB; ++mb) {
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 945:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     const int ih = oh * SH - PH + kh * DH;
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     for (int ow = ow_beg; ow < ow_end; ++ow) {
 4196              		.loc	1 946 0
 4197 59e8 80000000 		mins.w.sx	%s61,%s56,%s61
 4197      BDB83D78 
 4198 59f0 C00E0000 		br.l	.L6.13
 4198      00000F18 
 4199              	.L6.14:
 4200              	# line 971
 947:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 948:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       const int iw = ow * SW - PW + kw * DW;
 949:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t src_off = src_off_f(p, mb, g, ic, ih, iw);
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       dw += ((float*)diff_dst_m)[dst_off]
 951:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                         * ((float*)src_m)[src_off];
 952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     }
 953:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 954:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 }
 955:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 956:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 957:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 958:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 959:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 960:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 961:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** 
 962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     if ((p->dir & FLAG_BIA)) {
 963:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       OMP(for collapse(2) nowait)//;
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int g = 0; g < G; ++g) {
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 966:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 967:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           float &db = ((float*)diff_bia_m)[bia_off];
 968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           db = 0;
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 4201              		.loc	1 971 0
 4202 59f8 80000000 		mins.w.sx	%s61,%s59,%s61
 4202      BDBB3D78 
 4203 5a00 18070000 		br.l	.L6.15
 4203      00000F18 
 4204              	.L6.16:
 4205 5a08 80000000 		mins.w.sx	%s60,%s55,%s60
 4205      BCB73C78 
 4206 5a10 18030000 		br.l	.L6.17
 4206      00000F18 
 4207              	.L6.18:
 4208 5a18 00000000 		lea	%s63,__eh_curr_region@LO
 4208      00003F06 
 4209 5a20 00000000 		and	%s63,%s63,(32)0
 4209      60BF3F44 
 4210 5a28 00000000 		lea.sl	%s63,__eh_curr_region@HI(,%s63)
 4210      BF00BF06 
 4211 5a30 70FEFFFF 		ld2b.zx	%s62,-400(,%fp)
 4211      8900BE04 
 4212 5a38 00000000 		st2b	%s62,0(,%s63)
 4212      BF003E14 
 4213 5a40 48FEFFFF 		ld	%s63,-440(,%fp)
 4213      89003F01 
 4214 5a48 00000000 		lea	%s62,__curr_eh_stack_entry@LO
 4214      00003E06 
 4215 5a50 00000000 		and	%s62,%s62,(32)0
 4215      60BE3E44 
 4216 5a58 00000000 		lea.sl	%s62,__curr_eh_stack_entry@HI(,%s62)
 4216      BE00BE06 
 4217 5a60 00000000 		st	%s63,0(,%s62)
 4217      BE003F11 
 4218              	# line 984
 972:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 db += ((float*)diff_dst_m)[dst_off];
 974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 975:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 976:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           }
 977:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         }
 978:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       }
 979:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 980:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****   }
 981:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #else
 982:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #error "select one"
 983:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 984:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** }
 4219              		.loc	1 984 0
 4220              	# Start of epilogue codes
 4221 5a68 30000000 		ld	%s18,48(,%fp)
 4221      89001201 
 4222 5a70 38000000 		ld	%s19,56(,%fp)
 4222      89001301 
 4223 5a78 40000000 		ld	%s20,64(,%fp)
 4223      89001401 
 4224 5a80 48000000 		ld	%s21,72(,%fp)
 4224      89001501 
 4225 5a88 50000000 		ld	%s22,80(,%fp)
 4225      89001601 
 4226 5a90 58000000 		ld	%s23,88(,%fp)
 4226      89001701 
 4227 5a98 60000000 		ld	%s24,96(,%fp)
 4227      89001801 
 4228 5aa0 68000000 		ld	%s25,104(,%fp)
 4228      89001901 
 4229 5aa8 70000000 		ld	%s26,112(,%fp)
 4229      89001A01 
 4230 5ab0 78000000 		ld	%s27,120(,%fp)
 4230      89001B01 
 4231 5ab8 80000000 		ld	%s28,128(,%fp)
 4231      89001C01 
 4232 5ac0 88000000 		ld	%s29,136(,%fp)
 4232      89001D01 
 4233 5ac8 90000000 		ld	%s30,144(,%fp)
 4233      89001E01 
 4234 5ad0 98000000 		ld	%s31,152(,%fp)
 4234      89001F01 
 4235 5ad8 A0000000 		ld	%s32,160(,%fp)
 4235      89002001 
 4236 5ae0 A8000000 		ld	%s33,168(,%fp)
 4236      89002101 
 4237 5ae8 00000000 		or	%sp,0,%fp
 4237      89000B45 
 4238              		.cfi_def_cfa	11,8
 4239 5af0 18000000 		ld	%got,0x18(,%sp)
 4239      8B000F01 
 4240 5af8 20000000 		ld	%plt,0x20(,%sp)
 4240      8B001001 
 4241 5b00 08000000 		ld	%lr,0x8(,%sp)
 4241      8B000A01 
 4242 5b08 00000000 		ld	%fp,0x0(,%sp)
 4242      8B000901 
 4243 5b10 00000000 		b.l	(,%lr)
 4243      8A000F19 
 4244              	.L6.19:
 4245              	# line 964
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 4246              		.loc	1 964 0
 4247 5b18 00000000 		adds.w.sx	%s63,1,%s63
 4247      BF013F4A 
 4248 5b20 00000000 		adds.l	%s60,%s61,%s60
 4248      BCBD3C59 
 4249 5b28 00000000 		adds.w.sx	%s54,%s58,%s54
 4249      B6BA364A 
 4250 5b30 00000000 		adds.w.sx	%s47,%s58,%s47
 4250      AFBA2F4A 
 4251 5b38 80080000 		brgt.w	0,%s63,.L6.20
 4251      BF008118 
 4252 5b40 D8FEFFFF 		br.l	.L6.18
 4252      00000F18 
 4253              	.L6.21:
 4254 5b48 00000000 		or	%s63,0,%s25
 4254      99003F45 
 4255 5b50 00000000 		or	%s61,0,%s26
 4255      9A003D45 
 4256 5b58 00000000 		or	%s60,0,%s27
 4256      9B003C45 
 4257 5b60 00000000 		or	%s58,0,%s24
 4257      98003A45 
 4258 5b68 00000000 		or	%s22,0,%s23
 4258      97001645 
 4259 5b70 00000000 		or	%s56,0,%s47
 4259      AF003845 
 4260 5b78 00000000 		or	%s47,0,%s38
 4260      A6002F45 
 4261 5b80 98FFFFFF 		br.l	.L6.19
 4261      00000F18 
 4262              	.L6.22:
 4263              	# line 965
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 4264              		.loc	1 965 0
 4265 5b88 00000000 		adds.w.sx	%s61,1,%s61
 4265      BD013D4A 
 4266 5b90 00000000 		adds.l	%s60,4,%s60
 4266      BC043C59 
 4267 5b98 00000000 		adds.w.sx	%s59,1,%s59
 4267      BB013B4A 
 4268 5ba0 70070000 		brgt.w	0,%s61,.L6.23
 4268      BD008118 
 4269 5ba8 A0FFFFFF 		br.l	.L6.21
 4269      00000F18 
 4270              	.L6.24:
 4271 5bb0 00000000 		or	%s61,0,%s7
 4271      87003D45 
 4272 5bb8 00000000 		or	%s59,0,%s22
 4272      96003B45 
 4273 5bc0 C8FFFFFF 		br.l	.L6.22
 4273      00000F18 
 4274              	.L6.25:
 4275              	# line 969
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 4276              		.loc	1 969 0
 4277 5bc8 00000000 		adds.w.sx	%s63,1,%s63
 4277      BF013F4A 
 4278 5bd0 00000000 		adds.l	%s61,%s62,%s61
 4278      BDBE3D59 
 4279 5bd8 00000000 		adds.l	%s59,%s62,%s59
 4279      BBBE3B59 
 4280 5be0 D8060000 		brgt.w	0,%s63,.L6.26
 4280      BF008118 
 4281 5be8 C8FFFFFF 		br.l	.L6.24
 4281      00000F18 
 4282              	.L6.27:
 4283 5bf0 00000000 		or	%s63,0,%s3
 4283      83003F45 
 4284 5bf8 00000000 		or	%s62,0,%s4
 4284      84003E45 
 4285 5c00 00000000 		or	%s61,0,%s2
 4285      82003D45 
 4286 5c08 00000000 		or	%s59,0,%s6
 4286      86003B45 
 4287 5c10 00000000 		or	%s53,0,%s46
 4287      AE003545 
 4288 5c18 00000000 		or	%s50,0,%s43
 4288      AB003245 
 4289 5c20 00000000 		or	%s49,0,%s42
 4289      AA003145 
 4290 5c28 00000000 		or	%s48,0,%s41
 4290      A9003045 
 4291 5c30 00000000 		or	%s46,0,%s39
 4291      A7002E45 
 4292 5c38 00000000 		or	%s44,0,%s1
 4292      81002C45 
 4293 5c40 00000000 		or	%s60,0,%s57
 4293      B9003C45 
 4294 5c48 00000000 		or	%s38,0,%s47
 4294      AF002645 
 4295 5c50 00000000 		or	%s47,0,%s40
 4295      A8002F45 
 4296 5c58 00000000 		or	%s54,0,%s5
 4296      85003645 
 4297 5c60 68FFFFFF 		br.l	.L6.25
 4297      00000F18 
 4298              	.L6.28:
 4299              	# line 970
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 4300              		.loc	1 970 0
 4301 5c68 00000000 		adds.w.sx	%s63,4,%s63
 4301      BF043F4A 
 4302 5c70 00000000 		adds.w.sx	%s62,4,%s62
 4302      BE043E4A 
 4303 5c78 00000000 		adds.w.sx	%s61,4,%s61
 4303      BD043D4A 
 4304 5c80 00000000 		adds.w.sx	%s60,4,%s60
 4304      BC043C4A 
 4305 5c88 00000000 		adds.w.sx	%s59,4,%s59
 4305      BB043B4A 
 4306 5c90 E0020000 		brgt.w	0,%s63,.L6.29
 4306      BF008118 
 4307 5c98 58FFFFFF 		br.l	.L6.27
 4307      00000F18 
 4308              	.L6.30:
 4309              	# line 974
 974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 4310              		.loc	1 974 0
 4311 5ca0 00000000 		or	%s58,1,(0)1
 4311      00013A45 
 4312 5ca8 00000000 		or	%s56,0,%s57
 4312      B9003845 
 4313 5cb0 00000000 		lvl	%s58
 4313      00BA00BF 
 4314 5cb8 0000002D 		vstu.nc	%v45,0,%s56
 4314      B8000092 
 4315 5cc0 A8FFFFFF 		br.l	.L6.28
 4315      00000F18 
 4316              	.L6.31:
 4317              	# line 973
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 4318              		.loc	1 973 0
 4319 5cc8 00000000 		lvl	%s54
 4319      00B600BF 
 4320 5cd0 0000362B 		vfsum.s	%v43,%v54
 4320      000080EC 
 4321 5cd8 00000000 		or	%s58,1,(0)1
 4321      00013A45 
 4322 5ce0 00000000 		lvl	%s58
 4322      00BA00BF 
 4323 5ce8 002B2D2D 		vfadd.s	%v45,%v45,%v43
 4323      000080CC 
 4324 5cf0 00000000 		or	%s63,0,%s53
 4324      B5003F45 
 4325 5cf8 00000000 		or	%s62,0,%s52
 4325      B4003E45 
 4326 5d00 00000000 		or	%s61,0,%s51
 4326      B3003D45 
 4327 5d08 00000000 		or	%s60,0,%s50
 4327      B2003C45 
 4328 5d10 00000000 		or	%s59,0,%s49
 4328      B1003B45 
 4329 5d18 00000000 		or	%s57,0,%s48
 4329      B0003945 
 4330 5d20 80FFFFFF 		br.l	.L6.30
 4330      00000F18 
 4331              	.L6.17:
 4332 5d28 00000000 		adds.l	%s62,%s63,(0)1
 4332      00BF3E59 
 4333 5d30 00000000 		adds.l	%s62,%s62,%s61
 4333      BDBE3E59 
 4334 5d38 00000000 		lvl	%s60
 4334      00BC00BF 
 4335 5d40 00000035 		vldu.nc	%v53,4,%s62
 4335      BE040082 
 4336 5d48 00000000 		adds.l	%s62,%s59,(0)1
 4336      00BB3E59 
 4337 5d50 00000000 		adds.l	%s62,%s62,%s61
 4337      BDBE3E59 
 4338 5d58 00000034 		vldu.nc	%v52,4,%s62
 4338      BE040082 
 4339 5d60 00343533 		vfadd.s	%v51,%v53,%v52
 4339      000080CC 
 4340 5d68 00000000 		adds.l	%s62,%s58,(0)1
 4340      00BA3E59 
 4341 5d70 00000000 		adds.l	%s62,%s62,%s61
 4341      BDBE3E59 
 4342 5d78 00000032 		vldu.nc	%v50,4,%s62
 4342      BE040082 
 4343 5d80 00323331 		vfadd.s	%v49,%v51,%v50
 4343      000080CC 
 4344 5d88 00000000 		adds.l	%s62,%s57,(0)1
 4344      00B93E59 
 4345 5d90 00000000 		adds.l	%s62,%s62,%s61
 4345      BDBE3E59 
 4346 5d98 00000030 		vldu.nc	%v48,4,%s62
 4346      BE040082 
 4347 5da0 0030312F 		vfadd.s	%v47,%v49,%v48
 4347      000080CC 
 4348 5da8 002F3636 		vfadd.s	%v54,%v54,%v47
 4348      000080CC 
 4349              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4350              		.loc	1 971 0
 4351 5db0 00000000 		adds.l	%s61,%s61,%s56
 4351      B8BD3D59 
 4352 5db8 00000000 		subs.w.sx	%s55,%s55,%s60
 4352      BCB7375A 
 4353 5dc0 08FFFFFF 		brge.w	0,%s55,.L6.31
 4353      B7008518 
 4354 5dc8 40FCFFFF 		br.l	.L6.16
 4354      00000F18 
 4355              	.L6.32:
 4356              	# line 973
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 4357              		.loc	1 973 0
 4358 5dd0 00000000 		divs.w.sx	%s45,%s47,%s46
 4358      AEAF2D7B 
 4359 5dd8 00000000 		or	%s49,0,%s59
 4359      BB003145 
 4360 5de0 00000000 		or	%s50,0,%s60
 4360      BC003245 
 4361 5de8 00000000 		or	%s51,0,%s61
 4361      BD003345 
 4362 5df0 00000000 		or	%s52,0,%s62
 4362      BE003445 
 4363 5df8 00000000 		or	%s53,0,%s63
 4363      BF003545 
 4364 5e00 00000000 		or	%s48,0,%s57
 4364      B9003045 
 4365 5e08 00000000 		or	%s45,0,%s45
 4365      AD002D45 
 4366 5e10 00000000 		addu.l	%s45,%s45,%s44
 4366      ACAD2D48 
 4367 5e18 00000000 		addu.l	%s45,%s45,%s43
 4367      ABAD2D48 
 4368 5e20 00000000 		mulu.l	%s45,%s45,%s42
 4368      AAAD2D49 
 4369 5e28 00000000 		or	%s38,0,%s59
 4369      BB002645 
 4370 5e30 00000000 		addu.l	%s38,%s45,%s38
 4370      A6AD2648 
 4371 5e38 00000000 		mulu.l	%s38,%s38,%s41
 4371      A9A62649 
 4372 5e40 00000000 		or	%s38,0,%s38
 4372      A6002645 
 4373 5e48 00000000 		or	%s62,0,%s62
 4373      BE003E45 
 4374 5e50 00000000 		addu.l	%s62,%s45,%s62
 4374      BEAD3E48 
 4375 5e58 00000000 		mulu.l	%s62,%s41,%s62
 4375      BEA93E49 
 4376 5e60 00000000 		or	%s62,0,%s62
 4376      BE003E45 
 4377 5e68 00000000 		or	%s37,0,%s61
 4377      BD002545 
 4378 5e70 00000000 		addu.l	%s37,%s45,%s37
 4378      A5AD2548 
 4379 5e78 00000000 		mulu.l	%s37,%s41,%s37
 4379      A5A92549 
 4380 5e80 00000000 		or	%s37,0,%s37
 4380      A5002545 
 4381 5e88 00000000 		or	%s36,0,%s60
 4381      BC002445 
 4382 5e90 00000000 		addu.l	%s36,%s45,%s36
 4382      A4AD2448 
 4383 5e98 00000000 		mulu.l	%s36,%s41,%s36
 4383      A4A92449 
 4384 5ea0 00000000 		or	%s36,0,%s36
 4384      A4002445 
 4385              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4386              		.loc	1 971 0
 4387 5ea8 00000000 		muls.l	%s38,4,%s38
 4387      A604266E 
 4388 5eb0 00000000 		muls.l	%s62,4,%s62
 4388      BE043E6E 
 4389 5eb8 00000000 		muls.l	%s37,4,%s37
 4389      A504256E 
 4390 5ec0 00000000 		muls.l	%s36,4,%s36
 4390      A404246E 
 4391 5ec8 00000000 		adds.l	%s63,%s38,%s40
 4391      A8A63F59 
 4392 5ed0 00000000 		adds.l	%s59,%s40,%s62
 4392      BEA83B59 
 4393 5ed8 00000000 		adds.l	%s58,%s40,%s37
 4393      A5A83A59 
 4394 5ee0 00000000 		adds.l	%s57,%s40,%s36
 4394      A4A83959 
 4395 5ee8 00000000 		subs.w.sx	%s62,0,%s39
 4395      A7003E5A 
 4396 5ef0 00000000 		smvl	%s54
 4396      0000362E 
 4397 5ef8 80000000 		mins.w.sx	%s60,%s62,%s54
 4397      B6BE3C78 
 4398              	# line 973
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 4399              		.loc	1 973 0
 4400 5f00 00000000 		or	%s45,0,(0)1
 4400      00002D45 
 4401 5f08 00000000 		lvl	%s54
 4401      00B600BF 
 4402 5f10 00000036 		vbrdu	%v54,%s45
 4402      00AD808C 
 4403 5f18 00000000 		or	%s55,0,%s62
 4403      BE003745 
 4404              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4405              		.loc	1 971 0
 4406 5f20 00000000 		or	%s61,0,(0)1
 4406      00003D45 
 4407 5f28 00000000 		or	%s62,0,%s60
 4407      BC003E45 
 4408 5f30 00000000 		muls.l	%s56,4,%s62
 4408      BE04386E 
 4409 5f38 F0FDFFFF 		br.l	.L6.17
 4409      00000F18 
 4410              	.L6.33:
 4411 5f40 00000000 		or	%s58,1,(0)1
 4411      00013A45 
 4412 5f48 00000000 		or	%s56,0,%s57
 4412      B9003845 
 4413 5f50 00000000 		lvl	%s58
 4413      00BA00BF 
 4414 5f58 0000002D 		vldu.nc	%v45,0,%s56
 4414      B8000082 
 4415 5f60 70FEFFFF 		brlt.w	0,%s18,.L6.32
 4415      92008218 
 4416 5f68 38FDFFFF 		br.l	.L6.30
 4416      00000F18 
 4417              	.L6.29:
 4418 5f70 D0FFFFFF 		brlt.w	0,%s18,.L6.33
 4418      92008218 
 4419 5f78 F0FCFFFF 		br.l	.L6.28
 4419      00000F18 
 4420              	.L6.34:
 4421 5f80 00000000 		or	%s43,0,%s50
 4421      B2002B45 
 4422 5f88 00000000 		or	%s42,0,%s49
 4422      B1002A45 
 4423 5f90 00000000 		or	%s41,0,%s48
 4423      B0002945 
 4424 5f98 00000000 		or	%s40,0,%s47
 4424      AF002845 
 4425 5fa0 00000000 		or	%s39,0,%s46
 4425      AE002745 
 4426 5fa8 00000000 		or	%s46,0,%s53
 4426      B5002E45 
 4427 5fb0 00000000 		or	%s57,0,%s60
 4427      BC003945 
 4428 5fb8 00000000 		or	%s1,0,%s44
 4428      AC000145 
 4429 5fc0 00000000 		or	%s44,0,%s59
 4429      BB002C45 
 4430              	# line 970
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 4431              		.loc	1 970 0
 4432 5fc8 00000000 		adds.w.sx	%s56,%s20,%s35
 4432      A394384A 
 4433 5fd0 00000000 		adds.w.sx	%s55,1,%s20
 4433      9401374A 
 4434 5fd8 00000000 		adds.w.sx	%s53,2,%s20
 4434      9402354A 
 4435 5fe0 00000000 		adds.w.sx	%s60,3,%s20
 4435      94033C4A 
 4436 5fe8 00000000 		or	%s2,0,%s61
 4436      BD000245 
 4437 5ff0 00000000 		or	%s61,0,%s53
 4437      B5003D45 
 4438 5ff8 00000000 		or	%s3,0,%s63
 4438      BF000345 
 4439 6000 00000000 		or	%s63,0,%s56
 4439      B8003F45 
 4440 6008 00000000 		or	%s4,0,%s62
 4440      BE000445 
 4441 6010 00000000 		or	%s62,0,%s55
 4441      B7003E45 
 4442 6018 00000000 		or	%s5,0,%s54
 4442      B6000545 
 4443 6020 00000000 		or	%s6,0,%s59
 4443      BB000645 
 4444 6028 00000000 		or	%s59,0,%s58
 4444      BA003B45 
 4445 6030 00000000 		or	%s47,0,%s38
 4445      A6002F45 
 4446 6038 38FFFFFF 		br.l	.L6.29
 4446      00000F18 
 4447              	.L6.35:
 4448 6040 00000000 		or	%s58,0,%s20
 4448      94003A45 
 4449 6048 38FFFFFF 		brlt.w	%s20,%s19,.L6.34
 4449      93948218 
 4450 6050 78FBFFFF 		br.l	.L6.25
 4450      00000F18 
 4451              	.L6.36:
 4452 6058 00000000 		or	%s59,0,%s1
 4452      81003B45 
 4453 6060 00000000 		or	%s61,0,%s4
 4453      84003D45 
 4454 6068 00000000 		or	%s63,0,%s2
 4454      82003F45 
 4455 6070 00000000 		or	%s62,0,%s3
 4455      83003E45 
 4456 6078 C8FFFFFF 		br.l	.L6.35
 4456      00000F18 
 4457              	.L6.37:
 4458 6080 D0010000 		br.l	.L6.38
 4458      00000F18 
 4459              	.L6.39:
 4460 6088 00000000 		adds.w.sx	%s63,1,%s63
 4460      BF013F4A 
 4461 6090 00000000 		adds.w.sx	%s62,1,%s62
 4461      BE013E4A 
 4462 6098 E8FFFFFF 		brgt.w	0,%s63,.L6.37
 4462      BF008118 
 4463 60a0 B8FFFFFF 		br.l	.L6.36
 4463      00000F18 
 4464              	.L6.40:
 4465              	# line 974
 974:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 4466              		.loc	1 974 0
 4467 60a8 00000000 		or	%s61,1,(0)1
 4467      00013D45 
 4468 60b0 00000000 		or	%s59,0,%s60
 4468      BC003B45 
 4469 60b8 00000000 		lvl	%s61
 4469      00BD00BF 
 4470 60c0 0000002E 		vstu.nc	%v46,0,%s59
 4470      BB000092 
 4471 60c8 C0FFFFFF 		br.l	.L6.39
 4471      00000F18 
 4472              	.L6.41:
 4473              	# line 973
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 4474              		.loc	1 973 0
 4475 60d0 00000000 		lvl	%s58
 4475      00BA00BF 
 4476 60d8 0000382C 		vfsum.s	%v44,%v56
 4476      000080EC 
 4477 60e0 00000000 		or	%s61,1,(0)1
 4477      00013D45 
 4478 60e8 00000000 		lvl	%s61
 4478      00BD00BF 
 4479 60f0 002C2E2E 		vfadd.s	%v46,%v46,%v44
 4479      000080CC 
 4480 60f8 00000000 		or	%s63,0,%s57
 4480      B9003F45 
 4481 6100 00000000 		or	%s62,0,%s56
 4481      B8003E45 
 4482 6108 00000000 		or	%s60,0,%s55
 4482      B7003C45 
 4483 6110 98FFFFFF 		br.l	.L6.40
 4483      00000F18 
 4484              	.L6.15:
 4485 6118 00000000 		or	%s62,0,%s63
 4485      BF003E45 
 4486 6120 00000000 		lvl	%s61
 4486      00BD00BF 
 4487 6128 00000037 		vldu.nc	%v55,4,%s62
 4487      BE040082 
 4488 6130 00373838 		vfadd.s	%v56,%v56,%v55
 4488      000080CC 
 4489              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4490              		.loc	1 971 0
 4491 6138 00000000 		adds.l	%s63,%s63,%s60
 4491      BCBF3F59 
 4492 6140 00000000 		subs.w.sx	%s59,%s59,%s61
 4492      BDBB3B5A 
 4493 6148 88FFFFFF 		brge.w	0,%s59,.L6.41
 4493      BB008518 
 4494 6150 A8F8FFFF 		br.l	.L6.14
 4494      00000F18 
 4495              	.L6.42:
 4496              	# line 973
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 4497              		.loc	1 973 0
 4498 6158 00000000 		divs.w.sx	%s52,%s54,%s53
 4498      B5B6347B 
 4499 6160 00000000 		or	%s56,0,%s62
 4499      BE003845 
 4500 6168 00000000 		or	%s57,0,%s63
 4500      BF003945 
 4501 6170 00000000 		or	%s55,0,%s60
 4501      BC003745 
 4502 6178 00000000 		or	%s52,0,%s52
 4502      B4003445 
 4503 6180 00000000 		addu.l	%s52,%s52,%s51
 4503      B3B43448 
 4504 6188 00000000 		addu.l	%s52,%s52,%s50
 4504      B2B43448 
 4505 6190 00000000 		mulu.l	%s52,%s52,%s49
 4505      B1B43449 
 4506 6198 00000000 		or	%s62,0,%s62
 4506      BE003E45 
 4507 61a0 00000000 		addu.l	%s62,%s52,%s62
 4507      BEB43E48 
 4508 61a8 00000000 		mulu.l	%s62,%s62,%s48
 4508      B0BE3E49 
 4509 61b0 00000000 		or	%s62,0,%s62
 4509      BE003E45 
 4510              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4511              		.loc	1 971 0
 4512 61b8 00000000 		muls.l	%s62,4,%s62
 4512      BE043E6E 
 4513 61c0 00000000 		adds.l	%s62,%s62,%s47
 4513      AFBE3E59 
 4514 61c8 00000000 		subs.w.sx	%s52,0,%s46
 4514      AE00345A 
 4515 61d0 00000000 		smvl	%s58
 4515      00003A2E 
 4516 61d8 80000000 		mins.w.sx	%s61,%s52,%s58
 4516      BAB43D78 
 4517              	# line 973
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 4518              		.loc	1 973 0
 4519 61e0 00000000 		or	%s45,0,(0)1
 4519      00002D45 
 4520 61e8 00000000 		lvl	%s58
 4520      00BA00BF 
 4521 61f0 00000038 		vbrdu	%v56,%s45
 4521      00AD808C 
 4522 61f8 00000000 		or	%s59,0,%s52
 4522      B4003B45 
 4523 6200 00000000 		or	%s63,0,%s62
 4523      BE003F45 
 4524 6208 00000000 		or	%s62,0,%s61
 4524      BD003E45 
 4525              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4526              		.loc	1 971 0
 4527 6210 00000000 		muls.l	%s60,4,%s62
 4527      BE043C6E 
 4528 6218 00FFFFFF 		br.l	.L6.15
 4528      00000F18 
 4529              	.L6.43:
 4530 6220 00000000 		or	%s61,1,(0)1
 4530      00013D45 
 4531 6228 00000000 		or	%s59,0,%s60
 4531      BC003B45 
 4532 6230 00000000 		lvl	%s61
 4532      00BD00BF 
 4533 6238 0000002E 		vldu.nc	%v46,0,%s59
 4533      BB000082 
 4534 6240 18FFFFFF 		brlt.w	0,%s18,.L6.42
 4534      92008218 
 4535 6248 60FEFFFF 		br.l	.L6.40
 4535      00000F18 
 4536              	.L6.38:
 4537 6250 D0FFFFFF 		brlt.w	0,%s18,.L6.43
 4537      92008218 
 4538 6258 30FEFFFF 		br.l	.L6.39
 4538      00000F18 
 4539              	.L6.44:
 4540 6260 00000000 		or	%s51,0,%s61
 4540      BD003345 
 4541 6268 00000000 		or	%s1,0,%s59
 4541      BB000145 
 4542 6270 00000000 		or	%s2,0,%s63
 4542      BF000245 
 4543 6278 00000000 		or	%s63,0,%s44
 4543      AC003F45 
 4544 6280 00000000 		or	%s3,0,%s62
 4544      BE000345 
 4545 6288 00000000 		or	%s62,0,%s58
 4545      BA003E45 
 4546 6290 00000000 		or	%s4,0,%s61
 4546      BD000445 
 4547 6298 B8FFFFFF 		br.l	.L6.38
 4547      00000F18 
 4548              	.L6.45:
 4549              	# line 970
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 4550              		.loc	1 970 0
 4551 62a0 00000000 		or	%s58,0,(0)1
 4551      00003A45 
 4552 62a8 B8FFFFFF 		brlt.w	0,%s20,.L6.44
 4552      94008218 
 4553 62b0 90FDFFFF 		br.l	.L6.35
 4553      00000F18 
 4554              	.L6.26:
 4555 62b8 E8FFFFFF 		brlt.w	0,%s19,.L6.45
 4555      93008218 
 4556 62c0 08F9FFFF 		br.l	.L6.25
 4556      00000F18 
 4557              	.L6.46:
 4558 62c8 00000000 		or	%s50,0,%s59
 4558      BB003245 
 4559 62d0 00000000 		or	%s63,0,%s34
 4559      A2003F45 
 4560              	# line 969
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 4561              		.loc	1 969 0
 4562 62d8 00000000 		or	%s58,0,(0)1
 4562      00003A45 
 4563 62e0 00000000 		or	%s57,0,(0)1
 4563      00003945 
 4564 62e8 00000000 		or	%s7,0,%s61
 4564      BD000745 
 4565 62f0 00000000 		or	%s61,0,%s58
 4565      BA003D45 
 4566 62f8 00000000 		or	%s22,0,%s59
 4566      BB001645 
 4567 6300 00000000 		or	%s59,0,%s57
 4567      B9003B45 
 4568 6308 B0FFFFFF 		br.l	.L6.26
 4568      00000F18 
 4569              	.L6.23:
 4570              	# line 968
 968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 4571              		.loc	1 968 0
 4572 6310 00000000 		or	%s63,0,(0)1
 4572      00003F45 
 4573 6318 00000000 		stu	%s63,0(,%s60)	# *(db)
 4573      BC003F12 
 4574 6320 A8FFFFFF 		brlt.w	0,%s21,.L6.46
 4574      95008218 
 4575 6328 60F8FFFF 		br.l	.L6.22
 4575      00000F18 
 4576              	.L6.47:
 4577 6330 00000000 		or	%s57,0,%s60
 4577      BC003945 
 4578 6338 00000000 		divu.l	%s57,%s57,%s33
 4578      A1B9396F 
 4579 6340 00000000 		or	%s38,0,%s47
 4579      AF002645 
 4580 6348 00000000 		or	%s23,0,%s22
 4580      96001745 
 4581 6350 00000000 		or	%s24,0,%s58
 4581      BA001845 
 4582 6358 00000000 		or	%s25,0,%s63
 4582      BF001945 
 4583 6360 00000000 		or	%s26,0,%s61
 4583      BD001A45 
 4584 6368 00000000 		or	%s27,0,%s60
 4584      BC001B45 
 4585 6370 00000000 		or	%s57,0,%s57
 4585      B9003945 
 4586              	# line 965
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 4587              		.loc	1 965 0
 4588 6378 00000000 		divs.w.sx	%s63,%s32,%s31
 4588      9FA03F7B 
 4589 6380 00000000 		subs.w.sx	%s63,0,%s63
 4589      BF003F5A 
 4590 6388 00000000 		or	%s61,0,%s63
 4590      BF003D45 
 4591 6390 00000000 		muls.l	%s57,4,%s57
 4591      B904396E 
 4592 6398 00000000 		adds.l	%s57,%s57,%s30
 4592      9EB93959 
 4593 63a0 00000000 		or	%s60,0,%s57
 4593      B9003C45 
 4594 63a8 00000000 		or	%s47,0,%s56
 4594      B8002F45 
 4595 63b0 60FFFFFF 		br.l	.L6.23
 4595      00000F18 
 4596              	.L6.20:
 4597 63b8 00000000 		or	%s59,0,(0)1
 4597      00003B45 
 4598 63c0 70FFFFFF 		brlt.w	0,%s22,.L6.47
 4598      96008218 
 4599 63c8 50F7FFFF 		br.l	.L6.19
 4599      00000F18 
 4600              	.L6.48:
 4601 63d0 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 4601      89000001 
 4602 63d8 14000000 		dldl.sx	%s32,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 4602      8000200B 
 4603 63e0 00000000 		or	%s59,0,%s32
 4603      A0003B45 
 4604 63e8 00000000 		or	%s61,0,%s59
 4604      BB003D45 
 4605              	# line 964
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 4606              		.loc	1 964 0
 4607 63f0 00000000 		or	%s60,0,(0)1
 4607      00003C45 
 4608              	# line 965
 965:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           size_t bia_off = bia_off_f(p, g, oc);
 4609              		.loc	1 965 0
 4610 63f8 00000000 		divs.w.sx	%s22,%s32,%s31
 4610      9FA0167B 
 4611 6400 00000000 		or	%s33,0,%s31
 4611      9F002145 
 4612              	# line 964
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 4613              		.loc	1 964 0
 4614 6408 00000000 		subs.w.sx	%s59,0,%s31
 4614      9F003B5A 
 4615 6410 00000000 		or	%s63,0,%s59
 4615      BB003F45 
 4616              	# line 968
 968:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int mb = 0; mb < MB; ++mb) {
 4617              		.loc	1 968 0
 4618 6418 A8010000 		dld	%s30,424(,%s3)	# *(diff_bia_m).data_
 4618      83001E09 
 4619              	# line 969
 969:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int oh = 0; oh < OH; ++oh) {
 4620              		.loc	1 969 0
 4621 6420 04000000 		dldl.sx	%s21,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 4621      8000150B 
 4622 6428 00000000 		subs.w.sx	%s34,0,%s21
 4622      9500225A 
 4623              	# line 970
 970:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               for (int ow = 0; ow < OW; ++ow) {
 4624              		.loc	1 970 0
 4625 6430 18000000 		dldl.sx	%s19,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 4625      8000130B 
 4626 6438 00000000 		subs.w.sx	%s35,0,%s19
 4626      9300235A 
 4627 6440 00000000 		and	%s20,%s19,(62)0
 4627      7E931444 
 4628 6448 00000000 		subs.w.sx	%s44,0,%s20
 4628      94002C5A 
 4629              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4630              		.loc	1 971 0
 4631 6450 1C000000 		dldl.sx	%s18,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 4631      8000120B 
 4632 6458 00000000 		or	%s48,0,%s18
 4632      92003045 
 4633 6460 00000000 		subs.w.sx	%s46,0,%s18
 4633      92002E5A 
 4634              	# line 964
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 4635              		.loc	1 964 0
 4636 6468 00000000 		or	%s54,0,(0)1
 4636      00003645 
 4637 6470 00000000 		or	%s47,0,(0)1
 4637      00002F45 
 4638              	# line 971
 971:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4639              		.loc	1 971 0
 4640 6478 A8010000 		dld	%s56,424(,%s4)	# *(s$224).data_
 4640      84003809 
 4641              	# line 973
 973:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               }
 4642              		.loc	1 973 0
 4643 6480 14000000 		dldl.sx	%s58,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 4643      80003A0B 
 4644 6488 00000000 		or	%s59,0,%s58
 4644      BA003B45 
 4645 6490 00000000 		or	%s62,0,%s59
 4645      BB003E45 
 4646 6498 00000000 		dldl.sx	%s53,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 4646      8000350B 
 4647 64a0 18000000 		dldl.sx	%s0,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 4647      8000000B 
 4648 64a8 00000000 		or	%s49,0,%s0
 4648      80003145 
 4649 64b0 08FFFFFF 		br.l	.L6.20
 4649      00000F18 
 4650              	.L6.49:
 4651 64b8 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 4651      89000001 
 4652              	# line 964
 964:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int oc = 0; oc < OC/G; ++oc) {
 4653              		.loc	1 964 0
 4654 64c0 00000000 		ldl.sx	%s31,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 4654      80001F03 
 4655 64c8 08FFFFFF 		brlt.w	0,%s31,.L6.48
 4655      9F008218 
 4656 64d0 48F5FFFF 		br.l	.L6.18
 4656      00000F18 
 4657              	.L6.50:
 4658 64d8 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 4658      89000001 
 4659              	# line 962
 962:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       OMP(for collapse(2) nowait)//;
 4660              		.loc	1 962 0
 4661 64e0 48000000 		ldl.zx	%s63,72(,%s0)	# *(p).dir
 4661      8000BF03 
 4662 64e8 00000000 		adds.w.sx	%s63,0,%s63
 4662      BF003F4A 
 4663 64f0 04000000 		lea	%s62,4
 4663      00003E06 
 4664 64f8 00000000 		and	%s62,%s63,%s62
 4664      BEBF3E44 
 4665 6500 B8FFFFFF 		brne.w	0,%s62,.L6.49
 4665      BE008318 
 4666 6508 10F5FFFF 		br.l	.L6.18
 4666      00000F18 
 4667              	.L6.51:
 4668 6510 80FCFFFF 		ld	%s3,-896(,%fp)	# restore 
 4668      89000301 
 4669 6518 78FCFFFF 		ld	%s4,-904(,%fp)	# restore 
 4669      89000401 
 4670 6520 B8FFFFFF 		br.l	.L6.50
 4670      00000F18 
 4671              	.L6.52:
 4672              	# line 914
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 4673              		.loc	1 914 0
 4674 6528 00000000 		adds.w.sx	%s63,1,%s63
 4674      BF013F4A 
 4675 6530 00000000 		adds.l	%s53,%s58,%s53
 4675      B5BA3559 
 4676 6538 00000000 		adds.w.sx	%s49,%s50,%s49
 4676      B1B2314A 
 4677 6540 00000000 		adds.w.sx	%s42,%s45,%s42
 4677      AAAD2A4A 
 4678 6548 78090000 		brgt.w	0,%s63,.L6.53
 4678      BF008118 
 4679 6550 C0FFFFFF 		br.l	.L6.51
 4679      00000F18 
 4680              	.L6.54:
 4681 6558 30FDFFFF 		ld	%s63,-720(,%fp)	# restore 
 4681      89003F01 
 4682 6560 28FDFFFF 		ld	%s58,-728(,%fp)	# restore 
 4682      89003A01 
 4683 6568 20FDFFFF 		ld	%s53,-736(,%fp)	# restore 
 4683      89003501 
 4684 6570 40FDFFFF 		ld	%s50,-704(,%fp)	# restore 
 4684      89003201 
 4685 6578 38FDFFFF 		ld	%s45,-712(,%fp)	# restore 
 4685      89002D01 
 4686 6580 48FDFFFF 		ld	%s20,-696(,%fp)	# restore 
 4686      89001401 
 4687 6588 18FDFFFF 		ld	%s32,-744(,%fp)	# restore 
 4687      89002001 
 4688 6590 98FFFFFF 		br.l	.L6.52
 4688      00000F18 
 4689              	.L6.55:
 4690              	# line 915
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 4691              		.loc	1 915 0
 4692 6598 00000000 		adds.w.sx	%s58,1,%s58
 4692      BA013A4A 
 4693 65a0 00000000 		adds.w.sx	%s55,1,%s55
 4693      B701374A 
 4694 65a8 A0080000 		brgt.w	0,%s58,.L6.56
 4694      BA008118 
 4695 65b0 A8FFFFFF 		br.l	.L6.54
 4695      00000F18 
 4696              	.L6.57:
 4697 65b8 88FDFFFF 		ld	%s58,-632(,%fp)	# restore 
 4697      89003A01 
 4698 65c0 80FDFFFF 		ld	%s55,-640(,%fp)	# restore 
 4698      89003701 
 4699 65c8 90FDFFFF 		ld	%s19,-624(,%fp)	# restore 
 4699      89001301 
 4700 65d0 68FDFFFF 		ld	%s2,-664(,%fp)	# restore 
 4700      89000201 
 4701 65d8 70FDFFFF 		ld	%s3,-656(,%fp)	# restore 
 4701      89000301 
 4702 65e0 78FDFFFF 		ld	%s7,-648(,%fp)	# restore 
 4702      89000701 
 4703 65e8 60FDFFFF 		ld	%s33,-672(,%fp)	# restore 
 4703      89002101 
 4704 65f0 A8FFFFFF 		br.l	.L6.55
 4704      00000F18 
 4705              	.L6.58:
 4706              	# line 917
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 4707              		.loc	1 917 0
 4708 65f8 00000000 		adds.w.sx	%s55,1,%s55
 4708      B701374A 
 4709 6600 00000000 		adds.l	%s53,%s54,%s53
 4709      B5B63559 
 4710 6608 00000000 		adds.l	%s50,%s51,%s50
 4710      B2B33259 
 4711 6610 00000000 		adds.w.sx	%s32,%s41,%s32
 4711      A0A9204A 
 4712 6618 00000000 		adds.w.sx	%s63,1,%s63
 4712      BF013F4A 
 4713 6620 A8070000 		brgt.w	0,%s55,.L6.59
 4713      B7008118 
 4714 6628 90FFFFFF 		br.l	.L6.57
 4714      00000F18 
 4715              	.L6.60:
 4716 6630 D8FDFFFF 		ld	%s55,-552(,%fp)	# restore 
 4716      89003701 
 4717 6638 D0FDFFFF 		ld	%s54,-560(,%fp)	# restore 
 4717      89003601 
 4718 6640 B8FDFFFF 		ld	%s53,-584(,%fp)	# restore 
 4718      89003501 
 4719 6648 C8FDFFFF 		ld	%s51,-568(,%fp)	# restore 
 4719      89003301 
 4720 6650 C0FDFFFF 		ld	%s50,-576(,%fp)	# restore 
 4720      89003201 
 4721 6658 E0FDFFFF 		ld	%s41,-544(,%fp)	# restore 
 4721      89002901 
 4722 6660 E8FDFFFF 		ld	%s63,-536(,%fp)	# restore 
 4722      89003F01 
 4723 6668 F0FDFFFF 		ld	%s18,-528(,%fp)	# restore 
 4723      89001201 
 4724 6670 98FDFFFF 		ld	%s4,-616(,%fp)	# restore 
 4724      89000401 
 4725 6678 B0FDFFFF 		ld	%s37,-592(,%fp)	# restore 
 4725      89002501 
 4726 6680 A8FDFFFF 		ld	%s36,-600(,%fp)	# restore 
 4726      89002401 
 4727 6688 A0FDFFFF 		ld	%s35,-608(,%fp)	# restore 
 4727      89002301 
 4728 6690 68FFFFFF 		br.l	.L6.58
 4728      00000F18 
 4729              	.L6.61:
 4730 6698 00000000 		or	%s58,1,(0)1
 4730      00013A45 
 4731 66a0 00000000 		st2b	%s58,0(,%s57)
 4731      B9003A14 
 4732              	# line 918
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 4733              		.loc	1 918 0
 4734 66a8 00000000 		adds.w.sx	%s55,1,%s55
 4734      B701374A 
 4735 66b0 00000000 		adds.l	%s54,32,%s54
 4735      B6203659 
 4736 66b8 00000000 		adds.l	%s63,1,%s63
 4736      BF013F59 
 4737 66c0 00000000 		adds.l	%s53,4,%s53
 4737      B5043559 
 4738 66c8 00000000 		adds.l	%s51,%s52,%s51
 4738      B3B43359 
 4739 66d0 38060000 		brgt.w	0,%s55,.L6.62
 4739      B7008118 
 4740 66d8 58FFFFFF 		br.l	.L6.60
 4740      00000F18 
 4741              	.L6.63:
 4742 66e0 00000000 		or	%s57,0,%s25
 4742      99003945 
 4743 66e8 00000000 		or	%s55,0,%s28
 4743      9C003745 
 4744 66f0 00000000 		or	%s54,0,%s27
 4744      9B003645 
 4745 66f8 00000000 		or	%s63,0,%s26
 4745      9A003F45 
 4746 6700 38FEFFFF 		ld	%s53,-456(,%fp)	# restore 
 4746      89003501 
 4747 6708 00000000 		or	%s52,0,%s29
 4747      9D003445 
 4748 6710 00000000 		or	%s51,0,%s30
 4748      9E003345 
 4749 6718 30FEFFFF 		ld	%s46,-464(,%fp)	# restore 
 4749      89002E01 
 4750 6720 28FEFFFF 		ld	%s47,-472(,%fp)	# restore 
 4750      89002F01 
 4751 6728 20FEFFFF 		ld	%s59,-480(,%fp)	# restore 
 4751      89003B01 
 4752 6730 10FEFFFF 		ld	%s34,-496(,%fp)	# restore 
 4752      89002201 
 4753 6738 18FEFFFF 		ld	%s40,-488(,%fp)	# restore 
 4753      89002801 
 4754 6740 00FEFFFF 		ld	%s6,-512(,%fp)	# restore 
 4754      89000601 
 4755 6748 F8FDFFFF 		ld	%s5,-520(,%fp)	# restore 
 4755      89000501 
 4756 6750 08FEFFFF 		ld	%s7,-504(,%fp)	# restore 
 4756      89000701 
 4757 6758 40FFFFFF 		br.l	.L6.61
 4757      00000F18 
 4758              	.L6.64:
 4759              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 4760              		.loc	1 940 0
 4761 6760 00000000 		adds.w.sx	%s63,1,%s63
 4761      BF013F4A 
 4762 6768 00000000 		adds.l	%s57,%s60,%s57
 4762      B9BC3959 
 4763 6770 00000000 		adds.w.sx	%s58,1,%s58
 4763      BA013A4A 
 4764 6778 F8030000 		brgt.w	0,%s63,.L6.65
 4764      BF008118 
 4765 6780 60FFFFFF 		br.l	.L6.63
 4765      00000F18 
 4766              	.L6.66:
 4767 6788 00000000 		or	%s63,0,%s22
 4767      96003F45 
 4768 6790 00000000 		or	%s60,0,%s23
 4768      97003C45 
 4769 6798 00000000 		or	%s58,0,%s24
 4769      98003A45 
 4770 67a0 C0FFFFFF 		br.l	.L6.64
 4770      00000F18 
 4771              	.L6.67:
 4772              	# line 943
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 4773              		.loc	1 943 0
 4774 67a8 00000000 		adds.w.sx	%s63,1,%s63
 4774      BF013F4A 
 4775 67b0 00000000 		adds.l	%s58,%s61,%s58
 4775      BABD3A59 
 4776 67b8 00000000 		adds.l	%s55,%s56,%s55
 4776      B7B83759 
 4777 67c0 50030000 		brgt.w	0,%s63,.L6.68
 4777      BF008118 
 4778 67c8 C0FFFFFF 		br.l	.L6.66
 4778      00000F18 
 4779              	.L6.69:
 4780 67d0 00000000 		or	%s63,0,%s2
 4780      82003F45 
 4781 67d8 00000000 		or	%s61,0,%s3
 4781      83003D45 
 4782 67e0 00000000 		or	%s58,0,%s6
 4782      86003A45 
 4783 67e8 00000000 		or	%s56,0,%s4
 4783      84003845 
 4784 67f0 00000000 		or	%s55,0,%s5
 4784      85003745 
 4785 67f8 B0FFFFFF 		br.l	.L6.67
 4785      00000F18 
 4786              	.L6.70:
 4787              	# line 944
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     const int ih = oh * SH - PH + kh * DH;
 4788              		.loc	1 944 0
 4789 6800 00000000 		adds.w.sx	%s63,1,%s63
 4789      BF013F4A 
 4790 6808 00000000 		adds.w.sx	%s61,%s62,%s61
 4790      BDBE3D4A 
 4791 6810 00000000 		adds.w.sx	%s60,1,%s60
 4791      BC013C4A 
 4792 6818 80020000 		brgt.w	0,%s63,.L6.71
 4792      BF008118 
 4793 6820 B0FFFFFF 		br.l	.L6.69
 4793      00000F18 
 4794              	.L6.11:
 4795              	# line 952
 952:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   }
 4796              		.loc	1 952 0
 4797 6828 00000000 		or	%s59,1,(0)1
 4797      00013B45 
 4798 6830 00000000 		or	%s58,0,%s57
 4798      B9003A45 
 4799 6838 00000000 		lvl	%s59
 4799      00BB00BF 
 4800 6840 0000003B 		vstu.nc	%v59,0,%s58
 4800      BA000092 
 4801 6848 B8FFFFFF 		br.l	.L6.70
 4801      00000F18 
 4802              	.L6.72:
 4803 6850 00000000 		or	%s1,0,%s59
 4803      BB000145 
 4804              	# line 950
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                         * ((float*)src_m)[src_off];
 4805              		.loc	1 950 0
 4806 6858 00000000 		lvl	%s55
 4806      00B700BF 
 4807 6860 00003F3A 		vfsum.s	%v58,%v63
 4807      000080EC 
 4808 6868 00000000 		or	%s59,1,(0)1
 4808      00013B45 
 4809 6870 00000000 		lvl	%s59
 4809      00BB00BF 
 4810 6878 003A3B3B 		vfadd.s	%v59,%v59,%v58
 4810      000080CC 
 4811 6880 00000000 		or	%s63,0,%s54
 4811      B6003F45 
 4812 6888 00000000 		or	%s62,0,%s53
 4812      B5003E45 
 4813 6890 00000000 		or	%s61,0,%s52
 4813      B4003D45 
 4814 6898 00000000 		or	%s60,0,%s51
 4814      B3003C45 
 4815 68a0 00000000 		or	%s57,0,%s50
 4815      B2003945 
 4816 68a8 80FFFFFF 		br.l	.L6.11
 4816      00000F18 
 4817              	.L6.13:
 4818 68b0 00000000 		or	%s62,0,%s63
 4818      BF003E45 
 4819 68b8 00000000 		lvl	%s61
 4819      00BD00BF 
 4820 68c0 0000003E 		vldu.nc	%v62,4,%s62
 4820      BE040082 
 4821 68c8 00000000 		or	%s62,0,%s60
 4821      BC003E45 
 4822 68d0 0000003D 		vldu.nc	%v61,%s59,%s62
 4822      BEBB0082 
 4823 68d8 3E3D3F3F 		vfmad.s	%v63,%v63,%v61,%v62
 4823      000080E2 
 4824              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4825              		.loc	1 946 0
 4826 68e0 00000000 		adds.l	%s63,%s63,%s58
 4826      BABF3F59 
 4827 68e8 00000000 		adds.l	%s60,%s60,%s57
 4827      B9BC3C59 
 4828 68f0 00000000 		subs.w.sx	%s56,%s56,%s61
 4828      BDB8385A 
 4829 68f8 58FFFFFF 		brge.w	0,%s56,.L6.72
 4829      B8008518 
 4830 6900 E8F0FFFF 		br.l	.L6.12
 4830      00000F18 
 4831              	.L6.73:
 4832              	# line 950
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                         * ((float*)src_m)[src_off];
 4833              		.loc	1 950 0
 4834 6908 00000000 		divs.w.sx	%s47,%s49,%s48
 4834      B0B12F7B 
 4835 6910 00000000 		or	%s59,0,%s1
 4835      81003B45 
 4836 6918 00000000 		or	%s53,0,%s62
 4836      BE003545 
 4837 6920 00000000 		or	%s51,0,%s60
 4837      BC003345 
 4838 6928 00000000 		or	%s52,0,%s61
 4838      BD003445 
 4839 6930 00000000 		or	%s54,0,%s63
 4839      BF003645 
 4840 6938 00000000 		or	%s50,0,%s57
 4840      B9003245 
 4841 6940 00000000 		smvl	%s13
 4841      00000D2E 
 4842 6948 00000000 		lvl	%s13
 4842      008D00BF 
 4843 6950 003C003B 		vor	%v59,(0)1,%v60
 4843      000020C5 
 4844 6958 00000000 		or	%s47,0,%s47
 4844      AF002F45 
 4845 6960 00000000 		addu.l	%s47,%s47,%s46
 4845      AEAF2F48 
 4846 6968 00000000 		addu.l	%s47,%s47,%s45
 4846      ADAF2F48 
 4847 6970 00000000 		mulu.l	%s47,%s47,%s44
 4847      ACAF2F49 
 4848 6978 00000000 		or	%s62,0,%s60
 4848      BC003E45 
 4849 6980 00000000 		addu.l	%s62,%s47,%s62
 4849      BEAF3E48 
 4850 6988 00000000 		mulu.l	%s62,%s62,%s43
 4850      ABBE3E49 
 4851 6990 00000000 		or	%s62,0,%s62
 4851      BE003E45 
 4852 6998 00000000 		divs.w.sx	%s47,%s42,%s48
 4852      B0AA2F7B 
 4853 69a0 00000000 		or	%s47,0,%s47
 4853      AF002F45 
 4854 69a8 00000000 		addu.l	%s47,%s47,%s41
 4854      A9AF2F48 
 4855 69b0 00000000 		addu.l	%s47,%s47,%s40
 4855      A8AF2F48 
 4856 69b8 00000000 		mulu.l	%s47,%s47,%s39
 4856      A7AF2F49 
 4857 69c0 00000000 		or	%s34,0,%s61
 4857      BD002245 
 4858 69c8 00000000 		addu.l	%s34,%s47,%s34
 4858      A2AF2248 
 4859 69d0 00000000 		mulu.l	%s34,%s34,%s38
 4859      A6A22249 
 4860 69d8 00000000 		or	%s34,0,%s34
 4860      A2002245 
 4861              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4862              		.loc	1 946 0
 4863 69e0 00000000 		muls.l	%s34,4,%s34
 4863      A204226E 
 4864 69e8 00000000 		muls.l	%s62,4,%s62
 4864      BE043E6E 
 4865 69f0 00000000 		adds.l	%s34,%s34,%s37
 4865      A5A22259 
 4866 69f8 00000000 		adds.l	%s62,%s62,%s36
 4866      A4BE3E59 
 4867 6a00 00000000 		subs.w.sx	%s47,0,%s35
 4867      A3002F5A 
 4868 6a08 00000000 		smvl	%s55
 4868      0000372E 
 4869 6a10 80000000 		mins.w.sx	%s61,%s47,%s55
 4869      B7AF3D78 
 4870              	# line 950
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                         * ((float*)src_m)[src_off];
 4871              		.loc	1 950 0
 4872 6a18 00000000 		or	%s7,0,(0)1
 4872      00000745 
 4873 6a20 00000000 		lvl	%s55
 4873      00B700BF 
 4874 6a28 0000003F 		vbrdu	%v63,%s7
 4874      0087808C 
 4875 6a30 00000000 		or	%s56,0,%s47
 4875      AF003845 
 4876 6a38 00000000 		or	%s47,0,%s61
 4876      BD002F45 
 4877 6a40 00000000 		or	%s63,0,%s62
 4877      BE003F45 
 4878              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4879              		.loc	1 946 0
 4880 6a48 00000000 		muls.l	%s58,4,%s47
 4880      AF043A6E 
 4881 6a50 00000000 		or	%s60,0,%s34
 4881      A2003C45 
 4882 6a58 00000000 		muls.l	%s57,%s1,%s47
 4882      AF81396E 
 4883 6a60 50FEFFFF 		br.l	.L6.13
 4883      00000F18 
 4884              	.L6.74:
 4885 6a68 00000000 		or	%s58,1,(0)1
 4885      00013A45 
 4886 6a70 00000000 		or	%s56,0,%s57
 4886      B9003845 
 4887 6a78 00000000 		lvl	%s58
 4887      00BA00BF 
 4888 6a80 0000003C 		vldu.nc	%v60,0,%s56
 4888      B8000082 
 4889 6a88 80FEFFFF 		brlt.w	0,%s18,.L6.73
 4889      92008218 
 4890 6a90 38EFFFFF 		br.l	.L6.10
 4890      00000F18 
 4891              	.L6.71:
 4892 6a98 D0FFFFFF 		brlt.w	0,%s18,.L6.74
 4892      92008218 
 4893 6aa0 60FDFFFF 		br.l	.L6.70
 4893      00000F18 
 4894              	.L6.75:
 4895 6aa8 00000000 		or	%s46,0,%s58
 4895      BA002E45 
 4896 6ab0 00000000 		or	%s41,0,%s55
 4896      B7002945 
 4897              	# line 944
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     const int ih = oh * SH - PH + kh * DH;
 4898              		.loc	1 944 0
 4899 6ab8 00000000 		adds.w.sx	%s59,%s19,%s33
 4899      A1933B4A 
 4900 6ac0 00000000 		muls.w.sx	%s54,%s19,%s62
 4900      BE93364B 
 4901 6ac8 00000000 		or	%s2,0,%s63
 4901      BF000245 
 4902 6ad0 00000000 		or	%s63,0,%s59
 4902      BB003F45 
 4903 6ad8 00000000 		adds.w.sx	%s54,%s54,%s32
 4903      A0B6364A 
 4904 6ae0 00000000 		or	%s3,0,%s61
 4904      BD000345 
 4905 6ae8 00000000 		or	%s61,0,%s54
 4905      B6003D45 
 4906 6af0 00000000 		or	%s4,0,%s56
 4906      B8000445 
 4907 6af8 00000000 		or	%s5,0,%s55
 4907      B7000545 
 4908 6b00 00000000 		or	%s6,0,%s58
 4908      BA000645 
 4909 6b08 90FFFFFF 		br.l	.L6.71
 4909      00000F18 
 4910              	.L6.68:
 4911 6b10 00000000 		or	%s60,0,%s19
 4911      93003C45 
 4912 6b18 90FFFFFF 		brlt.w	%s19,%s20,.L6.75
 4912      94938218 
 4913 6b20 88FCFFFF 		br.l	.L6.67
 4913      00000F18 
 4914              	.L6.76:
 4915 6b28 00000000 		or	%s40,0,%s58
 4915      BA002845 
 4916 6b30 00000000 		or	%s22,0,%s63
 4916      BF001645 
 4917 6b38 00000000 		or	%s63,0,%s31
 4917      9F003F45 
 4918              	# line 943
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 4919              		.loc	1 943 0
 4920 6b40 00000000 		or	%s59,0,(0)1
 4920      00003B45 
 4921 6b48 00000000 		or	%s55,0,(0)1
 4921      00003745 
 4922 6b50 00000000 		or	%s23,0,%s60
 4922      BC001745 
 4923 6b58 00000000 		or	%s24,0,%s58
 4923      BA001845 
 4924 6b60 00000000 		or	%s58,0,%s59
 4924      BB003A45 
 4925 6b68 A8FFFFFF 		br.l	.L6.68
 4925      00000F18 
 4926              	.L6.65:
 4927 6b70 B8FFFFFF 		brlt.w	0,%s21,.L6.76
 4927      95008218 
 4928 6b78 E8FBFFFF 		br.l	.L6.64
 4928      00000F18 
 4929              	.L6.77:
 4930 6b80 38FEFFFF 		st	%s53,-456(,%fp)	# spill 
 4930      89003511 
 4931 6b88 30FEFFFF 		st	%s46,-464(,%fp)	# spill 
 4931      89002E11 
 4932 6b90 28FEFFFF 		st	%s47,-472(,%fp)	# spill 
 4932      89002F11 
 4933 6b98 20FEFFFF 		st	%s59,-480(,%fp)	# spill 
 4933      89003B11 
 4934 6ba0 18FEFFFF 		st	%s40,-488(,%fp)	# spill 
 4934      89002811 
 4935 6ba8 10FEFFFF 		st	%s34,-496(,%fp)	# spill 
 4935      89002211 
 4936 6bb0 08FEFFFF 		st	%s7,-504(,%fp)	# spill 
 4936      89000711 
 4937 6bb8 00FEFFFF 		st	%s6,-512(,%fp)	# spill 
 4937      89000611 
 4938 6bc0 F8FDFFFF 		st	%s5,-520(,%fp)	# spill 
 4938      89000511 
 4939              	# line 944
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     const int ih = oh * SH - PH + kh * DH;
 4940              		.loc	1 944 0
 4941 6bc8 00000000 		divu.l	%s59,%s59,%s40
 4941      A8BB3B6F 
 4942 6bd0 00000000 		or	%s25,0,%s57
 4942      B9001945 
 4943 6bd8 00000000 		or	%s26,0,%s63
 4943      BF001A45 
 4944 6be0 00000000 		or	%s27,0,%s54
 4944      B6001B45 
 4945 6be8 00000000 		or	%s28,0,%s55
 4945      B7001C45 
 4946 6bf0 00000000 		or	%s29,0,%s52
 4946      B4001D45 
 4947 6bf8 00000000 		or	%s30,0,%s51
 4947      B3001E45 
 4948 6c00 00000000 		addu.l	%s59,%s59,%s45
 4948      ADBB3B48 
 4949 6c08 00000000 		mulu.l	%s34,%s59,%s34
 4949      A2BB2249 
 4950 6c10 00000000 		divu.l	%s40,%s34,%s40
 4950      A8A2286F 
 4951 6c18 00000000 		or	%s40,0,%s40
 4951      A8002845 
 4952              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 4953              		.loc	1 940 0
 4954 6c20 00000000 		divs.w.sx	%s46,%s47,%s46
 4954      AEAF2E7B 
 4955 6c28 00000000 		subs.w.sx	%s46,0,%s46
 4955      AE002E5A 
 4956 6c30 00000000 		or	%s63,0,%s46
 4956      AE003F45 
 4957 6c38 00000000 		or	%s59,0,%s50
 4957      B2003B45 
 4958              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4959              		.loc	1 946 0
 4960 6c40 00000000 		subs.w.sx	%s18,%s41,%s50
 4960      B2A9125A 
 4961 6c48 00000000 		subs.w.sx	%s35,0,%s18
 4961      9200235A 
 4962              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 4963              		.loc	1 940 0
 4964 6c50 00000000 		muls.l	%s40,%s40,%s60
 4964      BCA8286E 
 4965 6c58 00000000 		adds.l	%s40,%s53,%s40
 4965      A8B52859 
 4966 6c60 00000000 		adds.l	%s7,%s40,%s7
 4966      87A80759 
 4967 6c68 00000000 		or	%s57,0,%s7
 4967      87003945 
 4968              	# line 944
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     const int ih = oh * SH - PH + kh * DH;
 4969              		.loc	1 944 0
 4970 6c70 00000000 		subs.w.sx	%s33,0,%s20
 4970      9400215A 
 4971              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 4972              		.loc	1 946 0
 4973 6c78 00000000 		muls.l	%s55,%s59,%s1
 4973      81BB376E 
 4974 6c80 00000000 		muls.l	%s59,4,%s59
 4974      BB043B6E 
 4975 6c88 00000000 		adds.l	%s55,%s51,%s55
 4975      B7B33759 
 4976 6c90 00000000 		adds.l	%s37,%s55,%s6
 4976      86B72559 
 4977 6c98 00000000 		adds.l	%s36,%s59,%s5
 4977      85BB2459 
 4978 6ca0 D0FEFFFF 		br.l	.L6.65
 4978      00000F18 
 4979              	.L6.78:
 4980              	# line 934
 934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ow_beg = ohw_begend[khkw][1];
 4981              		.loc	1 934 0
 4982 6ca8 00000000 		ld	%s50,0(,%s54)	# *(ohw_begend)
 4982      B6003201 
 4983 6cb0 00000000 		adds.w.sx	%s19,0,%s50
 4983      B200134A 
 4984              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 4985              		.loc	1 940 0
 4986 6cb8 00000000 		or	%s58,0,(0)1
 4986      00003A45 
 4987              	# line 935
 935:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_end = ohw_begend[khkw][2];
 4988              		.loc	1 935 0
 4989 6cc0 08000000 		ld	%s50,8(,%s54)	# *(ohw_begend)
 4989      B6003201 
 4990 6cc8 00000000 		adds.w.sx	%s50,0,%s50
 4990      B200324A 
 4991              	# line 936
 936:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ow_end = ohw_begend[khkw][3];
 4992              		.loc	1 936 0
 4993 6cd0 10000000 		ld	%s41,16(,%s54)	# *(ohw_begend)
 4993      B6002901 
 4994 6cd8 00000000 		adds.w.sx	%s20,0,%s41
 4994      A900144A 
 4995              	# line 937
 937:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #endif
 4996              		.loc	1 937 0
 4997 6ce0 18000000 		ld	%s41,24(,%s54)	# *(ohw_begend)
 4997      B6002901 
 4998 6ce8 00000000 		adds.w.sx	%s41,0,%s41
 4998      A900294A 
 4999              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 5000              		.loc	1 940 0
 5001 6cf0 00000000 		divs.w.sx	%s18,%s47,%s46
 5001      AEAF127B 
 5002 6cf8 88FEFFFF 		brlt.w	0,%s18,.L6.77
 5002      92008218 
 5003 6d00 98F9FFFF 		br.l	.L6.61
 5003      00000F18 
 5004              	.L6.62:
 5005              	# line 933
 933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_beg = ohw_begend[khkw][0];
 5006              		.loc	1 933 0
 5007 6d08 00000000 		ld1b.sx	%s58,0(,%s63)	# *(ook)
 5007      BF003A05 
 5008 6d10 00000000 		or	%s58,0,%s58
 5008      BA003A45 
 5009 6d18 90FFFFFF 		brne.w	0,%s58,.L6.78
 5009      BA008318 
 5010 6d20 78F9FFFF 		br.l	.L6.61
 5010      00000F18 
 5011              	.L6.79:
 5012 6d28 F0FDFFFF 		st	%s18,-528(,%fp)	# spill 
 5012      89001211 
 5013 6d30 E8FDFFFF 		st	%s63,-536(,%fp)	# spill 
 5013      89003F11 
 5014 6d38 E0FDFFFF 		st	%s41,-544(,%fp)	# spill 
 5014      89002911 
 5015 6d40 D8FDFFFF 		st	%s55,-552(,%fp)	# spill 
 5015      89003711 
 5016 6d48 D0FDFFFF 		st	%s54,-560(,%fp)	# spill 
 5016      89003611 
 5017 6d50 C8FDFFFF 		st	%s51,-568(,%fp)	# spill 
 5017      89003311 
 5018 6d58 C0FDFFFF 		st	%s50,-576(,%fp)	# spill 
 5018      89003211 
 5019 6d60 B8FDFFFF 		st	%s53,-584(,%fp)	# spill 
 5019      89003511 
 5020 6d68 B0FDFFFF 		st	%s37,-592(,%fp)	# spill 
 5020      89002511 
 5021 6d70 A8FDFFFF 		st	%s36,-600(,%fp)	# spill 
 5021      89002411 
 5022 6d78 A0FDFFFF 		st	%s35,-608(,%fp)	# spill 
 5022      89002311 
 5023 6d80 98FDFFFF 		st	%s4,-616(,%fp)	# spill 
 5023      89000411 
 5024 6d88 00000000 		or	%s55,0,%s37
 5024      A5003745 
 5025 6d90 00000000 		or	%s54,0,%s53
 5025      B5003645 
 5026              	# line 918
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 5027              		.loc	1 918 0
 5028 6d98 00000000 		or	%s53,0,(0)1
 5028      00003545 
 5029 6da0 00000000 		or	%s63,0,%s50
 5029      B2003F45 
 5030 6da8 00000000 		or	%s51,0,%s36
 5030      A4003345 
 5031              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 5032              		.loc	1 940 0
 5033 6db0 00000000 		muls.l	%s35,%s58,%s35
 5033      A3BA236E 
 5034 6db8 00000000 		adds.l	%s7,%s35,%s4
 5034      84A30759 
 5035 6dc0 48FFFFFF 		br.l	.L6.62
 5035      00000F18 
 5036              	.L6.59:
 5037 6dc8 00000000 		or	%s58,0,%s63
 5037      BF003A45 
 5038 6dd0 58FFFFFF 		brlt.w	0,%s18,.L6.79
 5038      92008218 
 5039 6dd8 20F8FFFF 		br.l	.L6.58
 5039      00000F18 
 5040              	.L6.80:
 5041 6de0 90FDFFFF 		st	%s19,-624(,%fp)	# spill 
 5041      89001311 
 5042 6de8 88FDFFFF 		st	%s58,-632(,%fp)	# spill 
 5042      89003A11 
 5043 6df0 80FDFFFF 		st	%s55,-640(,%fp)	# spill 
 5043      89003711 
 5044 6df8 78FDFFFF 		st	%s7,-648(,%fp)	# spill 
 5044      89000711 
 5045 6e00 70FDFFFF 		st	%s3,-656(,%fp)	# spill 
 5045      89000311 
 5046 6e08 68FDFFFF 		st	%s2,-664(,%fp)	# spill 
 5046      89000211 
 5047 6e10 60FDFFFF 		st	%s33,-672(,%fp)	# spill 
 5047      89002111 
 5048 6e18 00000000 		or	%s45,0,%s55
 5048      B7002D45 
 5049 6e20 00000000 		or	%s55,0,%s7
 5049      87003745 
 5050 6e28 00000000 		or	%s53,0,%s3
 5050      83003545 
 5051 6e30 00000000 		or	%s50,0,%s2
 5051      82003245 
 5052 6e38 00000000 		or	%s32,0,%s33
 5052      A1002045 
 5053 6e40 88FFFFFF 		br.l	.L6.59
 5053      00000F18 
 5054              	.L6.56:
 5055              	# line 917
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 5056              		.loc	1 917 0
 5057 6e48 00000000 		or	%s63,0,(0)1
 5057      00003F45 
 5058 6e50 90FFFFFF 		brlt.w	0,%s19,.L6.80
 5058      93008218 
 5059 6e58 40F7FFFF 		br.l	.L6.55
 5059      00000F18 
 5060              	.L6.81:
 5061 6e60 48FDFFFF 		st	%s20,-696(,%fp)	# spill 
 5061      89001411 
 5062 6e68 40FDFFFF 		st	%s50,-704(,%fp)	# spill 
 5062      89003211 
 5063 6e70 38FDFFFF 		st	%s45,-712(,%fp)	# spill 
 5063      89002D11 
 5064 6e78 30FDFFFF 		st	%s63,-720(,%fp)	# spill 
 5064      89003F11 
 5065 6e80 28FDFFFF 		st	%s58,-728(,%fp)	# spill 
 5065      89003A11 
 5066 6e88 20FDFFFF 		st	%s53,-736(,%fp)	# spill 
 5066      89003511 
 5067 6e90 18FDFFFF 		st	%s32,-744(,%fp)	# spill 
 5067      89002011 
 5068              	# line 915
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 5069              		.loc	1 915 0
 5070 6e98 00000000 		divs.w.sx	%s32,%s32,%s46
 5070      AEA0207B 
 5071 6ea0 00000000 		subs.w.sx	%s32,0,%s32
 5071      A000205A 
 5072 6ea8 00000000 		or	%s58,0,%s32
 5072      A0003A45 
 5073 6eb0 00000000 		or	%s59,0,%s53
 5073      B5003B45 
 5074 6eb8 90FFFFFF 		br.l	.L6.56
 5074      00000F18 
 5075              	.L6.53:
 5076 6ec0 00000000 		or	%s55,0,(0)1
 5076      00003745 
 5077 6ec8 98FFFFFF 		brlt.w	0,%s20,.L6.81
 5077      94008218 
 5078 6ed0 58F6FFFF 		br.l	.L6.52
 5078      00000F18 
 5079              	.L6.82:
 5080 6ed8 80FCFFFF 		st	%s3,-896(,%fp)	# spill 
 5080      89000311 
 5081 6ee0 78FCFFFF 		st	%s4,-904(,%fp)	# spill 
 5081      89000411 
 5082 6ee8 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 5082      89000001 
 5083 6ef0 14000000 		dldl.sx	%s32,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 5083      8000200B 
 5084 6ef8 00000000 		or	%s59,0,%s32
 5084      A0003B45 
 5085 6f00 00000000 		or	%s58,0,%s59
 5085      BB003A45 
 5086              	# line 914
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5087              		.loc	1 914 0
 5088 6f08 00000000 		or	%s53,0,(0)1
 5088      00003545 
 5089              	# line 915
 915:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         //for (int ic = 0; ic < IC/G; ++ic)
 5090              		.loc	1 915 0
 5091 6f10 00000000 		divs.w.sx	%s20,%s32,%s46
 5091      AEA0147B 
 5092 6f18 00000000 		or	%s40,0,%s46
 5092      AE002845 
 5093              	# line 914
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5094              		.loc	1 914 0
 5095 6f20 00000000 		subs.w.sx	%s59,0,%s46
 5095      AE003B5A 
 5096 6f28 00000000 		or	%s63,0,%s59
 5096      BB003F45 
 5097              	# line 917
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 5098              		.loc	1 917 0
 5099 6f30 20000000 		dldl.sx	%s19,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 5099      8000130B 
 5100 6f38 00000000 		or	%s59,0,%s19
 5100      93003B45 
 5101 6f40 00000000 		or	%s59,0,%s59
 5101      BB003B45 
 5102 6f48 00000000 		subs.w.sx	%s7,0,%s19
 5102      9300075A 
 5103              	# line 918
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 5104              		.loc	1 918 0
 5105 6f50 24000000 		dldl.sx	%s18,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 5105      8000120B 
 5106 6f58 00000000 		or	%s55,0,%s18
 5106      92003745 
 5107 6f60 00000000 		or	%s55,0,%s55
 5107      B7003745 
 5108              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 5109              		.loc	1 940 0
 5110 6f68 00000000 		muls.l	%s59,%s59,%s55
 5110      B7BB3B6E 
 5111 6f70 00000000 		or	%s51,0,%s18
 5111      92003345 
 5112              	# line 917
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 5113              		.loc	1 917 0
 5114 6f78 00000000 		muls.l	%s54,32,%s51
 5114      B320366E 
 5115              	# line 918
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 5116              		.loc	1 918 0
 5117 6f80 00000000 		subs.w.sx	%s37,0,%s18
 5117      9200255A 
 5118              	# line 933
 933:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int oh_beg = ohw_begend[khkw][0];
 5119              		.loc	1 933 0
 5120 6f88 F0FFFFFF 		dld	%s30,-16(,%fp)	# ook
 5120      89001E09 
 5121              	# line 934
 934:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               int ow_beg = ohw_begend[khkw][1];
 5122              		.loc	1 934 0
 5123 6f90 40FEFFFF 		dld	%s3,-448(,%fp)	# ohw_begend
 5123      89000309 
 5124              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 5125              		.loc	1 940 0
 5126 6f98 08000000 		dldl.sx	%s47,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 5126      80002F0B 
 5127 6fa0 00000000 		or	%s34,0,%s47
 5127      AF002245 
 5128              	# line 944
 944:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                     const int ih = oh * SH - PH + kh * DH;
 5129              		.loc	1 944 0
 5130 6fa8 A8010000 		dld	%s29,424(,%s2)	# *(diff_wei_m).data_
 5130      82001D09 
 5131 6fb0 00000000 		or	%s2,0,%s30
 5131      9E000245 
 5132              	# line 943
 943:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                   for (int oh = oh_beg; oh < oh_end; ++oh) {
 5133              		.loc	1 943 0
 5134 6fb8 04000000 		dldl.sx	%s21,4(,%s0)	# *(p).__b_N4conv6desc_tE.mb
 5134      8000150B 
 5135 6fc0 00000000 		subs.w.sx	%s31,0,%s21
 5135      95001F5A 
 5136              	# line 940
 940:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                 size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw); //<- WRITTEN
 5137              		.loc	1 940 0
 5138 6fc8 00000000 		muls.l	%s60,4,%s59
 5138      BB043C6E 
 5139 6fd0 00000000 		muls.l	%s35,4,%s55
 5139      B704236E 
 5140              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 5141              		.loc	1 946 0
 5142 6fd8 28000000 		dldl.sx	%s62,40(,%s0)	# *(p).__b_N4conv6desc_tE.sh
 5142      80003E0B 
 5143 6fe0 30000000 		dldl.sx	%s59,48(,%s0)	# *(p).__b_N4conv6desc_tE.ph
 5143      80003B0B 
 5144              	# line 917
 917:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 5145              		.loc	1 917 0
 5146 6fe8 00000000 		subs.w.sx	%s33,0,%s59
 5146      BB00215A 
 5147              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 5148              		.loc	1 946 0
 5149 6ff0 A8010000 		dld	%s5,424(,%s4)	# *(s$203).data_
 5149      84000509 
 5150              	# line 914
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5151              		.loc	1 914 0
 5152 6ff8 00000000 		or	%s49,0,(0)1
 5152      00003145 
 5153 7000 00000000 		or	%s42,0,(0)1
 5153      00002A45 
 5154              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 5155              		.loc	1 946 0
 5156 7008 A8010000 		dld	%s6,424(,%s1)	# *(s$205).data_
 5156      81000609 
 5157 7010 00000000 		or	%s4,0,%s29
 5157      9D000445 
 5158              	# line 950
 950:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                         * ((float*)src_m)[src_off];
 5159              		.loc	1 950 0
 5160 7018 14000000 		dldl.sx	%s50,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 5160      8000320B 
 5161 7020 00000000 		or	%s59,0,%s50
 5161      B2003B45 
 5162 7028 00000000 		or	%s61,0,%s59
 5162      BB003D45 
 5163 7030 00000000 		dldl.sx	%s48,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 5163      8000300B 
 5164 7038 18000000 		dldl.sx	%s59,24(,%s0)	# *(p).__b_N4conv6desc_tE.oh
 5164      80003B0B 
 5165 7040 00000000 		or	%s44,0,%s59
 5165      BB002C45 
 5166 7048 1C000000 		dldl.sx	%s59,28(,%s0)	# *(p).__b_N4conv6desc_tE.ow
 5166      80003B0B 
 5167 7050 00000000 		or	%s43,0,%s59
 5167      BB002B45 
 5168 7058 08000000 		dldl.sx	%s45,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 5168      80002D0B 
 5169 7060 00000000 		or	%s59,0,%s45
 5169      AD003B45 
 5170 7068 00000000 		or	%s56,0,%s59
 5170      BB003845 
 5171 7070 0C000000 		dldl.sx	%s59,12(,%s0)	# *(p).__b_N4conv6desc_tE.ih
 5171      80003B0B 
 5172 7078 00000000 		or	%s39,0,%s59
 5172      BB002745 
 5173 7080 10000000 		dldl.sx	%s59,16(,%s0)	# *(p).__b_N4conv6desc_tE.iw
 5173      80003B0B 
 5174 7088 00000000 		or	%s38,0,%s59
 5174      BB002645 
 5175 7090 34000000 		dldl.sx	%s59,52(,%s0)	# *(p).__b_N4conv6desc_tE.pw
 5175      80003B0B 
 5176 7098 00000000 		or	%s59,0,%s59
 5176      BB003B45 
 5177 70a0 2C000000 		dldl.sx	%s0,44(,%s0)	# *(p).__b_N4conv6desc_tE.sw
 5177      8000000B 
 5178 70a8 00000000 		or	%s0,0,%s0
 5178      80000045 
 5179              	# line 946
 946:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****                       size_t dst_off = dst_off_f(p, mb, g, oc, oh, ow);
 5180              		.loc	1 946 0
 5181 70b0 00000000 		muls.l	%s1,4,%s0
 5181      8004016E 
 5182 70b8 00000000 		lea	%s57,__eh_curr_region@LO
 5182      00003906 
 5183 70c0 00000000 		and	%s57,%s57,(32)0
 5183      60B93944 
 5184 70c8 00000000 		lea.sl	%s57,__eh_curr_region@HI(,%s57)
 5184      B900B906 
 5185 70d0 00000000 		or	%s24,0,%s24
 5185      98001845 
 5186              	# line 918
 918:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp **** #if 0
 5187              		.loc	1 918 0
 5188 70d8 00000000 		muls.l	%s52,4,%s24
 5188      9804346E 
 5189 70e0 00000000 		muls.l	%s36,-4,%s59
 5189      BB7C246E 
 5190 70e8 D8FDFFFF 		br.l	.L6.53
 5190      00000F18 
 5191              	.L6.83:
 5192 70f0 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 5192      89000001 
 5193              	# line 914
 914:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5194              		.loc	1 914 0
 5195 70f8 00000000 		ldl.sx	%s46,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 5195      80002E03 
 5196 7100 D8FDFFFF 		brlt.w	0,%s46,.L6.82
 5196      AE008218 
 5197 7108 D0F3FFFF 		br.l	.L6.50
 5197      00000F18 
 5198              	.L6.84:
 5199 7110 00000000 		or	%s1,0,%s22
 5199      96000145 
 5200 7118 00000000 		or	%s2,0,%s26
 5200      9A000245 
 5201 7120 00000000 		or	%s3,0,%s23
 5201      97000345 
 5202 7128 00000000 		or	%s4,0,%s25
 5202      99000445 
 5203 7130 C0FFFFFF 		br.l	.L6.83
 5203      00000F18 
 5204              	.L6.85:
 5205              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5206              		.loc	1 899 0
 5207 7138 00000000 		adds.w.sx	%s63,1,%s63
 5207      BF013F4A 
 5208 7140 00000000 		adds.l	%s60,%s61,%s60
 5208      BCBD3C59 
 5209 7148 D8020000 		brgt.w	0,%s63,.L6.86
 5209      BF008118 
 5210 7150 C0FFFFFF 		br.l	.L6.84
 5210      00000F18 
 5211              	.L6.87:
 5212 7158 00000000 		or	%s63,0,%s6
 5212      86003F45 
 5213 7160 00000000 		or	%s61,0,%s7
 5213      87003D45 
 5214 7168 00000000 		or	%s60,0,%s21
 5214      95003C45 
 5215 7170 00000000 		or	%s20,0,%s5
 5215      85001445 
 5216 7178 C0FFFFFF 		br.l	.L6.85
 5216      00000F18 
 5217              	.L6.88:
 5218              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 5219              		.loc	1 900 0
 5220 7180 00000000 		adds.w.sx	%s63,1,%s63
 5220      BF013F4A 
 5221 7188 00000000 		adds.w.sx	%s62,1,%s62
 5221      BE013E4A 
 5222 7190 20020000 		brgt.w	0,%s63,.L6.89
 5222      BF008118 
 5223 7198 C0FFFFFF 		br.l	.L6.87
 5223      00000F18 
 5224              	.L6.90:
 5225 71a0 00000000 		or	%s63,0,%s3
 5225      83003F45 
 5226 71a8 00000000 		or	%s62,0,%s4
 5226      84003E45 
 5227 71b0 D0FFFFFF 		br.l	.L6.88
 5227      00000F18 
 5228              	.L6.91:
 5229              	# line 901
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 5230              		.loc	1 901 0
 5231 71b8 00000000 		adds.w.sx	%s63,1,%s63
 5231      BF013F4A 
 5232 71c0 00000000 		adds.w.sx	%s61,1,%s61
 5232      BD013D4A 
 5233 71c8 98010000 		brgt.w	0,%s63,.L6.92
 5233      BF008118 
 5234 71d0 D0FFFFFF 		br.l	.L6.90
 5234      00000F18 
 5235              	.L6.93:
 5236 71d8 00000000 		or	%s63,0,%s1
 5236      81003F45 
 5237 71e0 00000000 		or	%s61,0,%s2
 5237      82003D45 
 5238 71e8 D0FFFFFF 		br.l	.L6.91
 5238      00000F18 
 5239              	.L6.94:
 5240 71f0 38010000 		br.l	.L6.95
 5240      00000F18 
 5241              	.L6.96:
 5242              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 5243              		.loc	1 902 0
 5244 71f8 00000000 		adds.w.sx	%s63,1,%s63
 5244      BF013F4A 
 5245 7200 00000000 		adds.w.sx	%s62,1,%s62
 5245      BE013E4A 
 5246 7208 E8FFFFFF 		brgt.w	0,%s63,.L6.94
 5246      BF008118 
 5247 7210 C8FFFFFF 		br.l	.L6.93
 5247      00000F18 
 5248              	.L6.97:
 5249 7218 00000000 		or	%s62,0,%s58
 5249      BA003E45 
 5250 7220 00000000 		or	%s63,0,%s57
 5250      B9003F45 
 5251 7228 D0FFFFFF 		br.l	.L6.96
 5251      00000F18 
 5252              	.L6.9:
 5253              	# line 906
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 5254              		.loc	1 906 0
 5255 7230 00000000 		or	%s63,0,(0)1
 5255      00003F45 
 5256 7238 00000000 		lvl	%s62
 5256      00BE00BF 
 5257 7240 00000039 		vbrdu	%v57,%s63
 5257      00BF808C 
 5258 7248 00000000 		or	%s63,0,%s61
 5258      BD003F45 
 5259 7250 00000039 		vstu.nc	%v57,4,%s63
 5259      BF040092 
 5260              	# line 903
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 5261              		.loc	1 903 0
 5262 7258 00000000 		adds.l	%s61,%s61,%s60
 5262      BCBD3D59 
 5263 7260 00000000 		subs.w.sx	%s59,%s59,%s62
 5263      BEBB3B5A 
 5264 7268 B0FFFFFF 		brge.w	0,%s59,.L6.97
 5264      BB008518 
 5265 7270 48E7FFFF 		br.l	.L6.8
 5265      00000F18 
 5266              	.L6.98:
 5267              	# line 906
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 5268              		.loc	1 906 0
 5269 7278 00000000 		divu.l	%s54,%s56,%s55
 5269      B7B8366F 
 5270 7280 00000000 		or	%s58,0,%s62
 5270      BE003A45 
 5271 7288 00000000 		or	%s57,0,%s63
 5271      BF003945 
 5272 7290 00000000 		addu.l	%s54,%s54,%s53
 5272      B5B63648 
 5273 7298 00000000 		mulu.l	%s54,%s54,%s52
 5273      B4B63649 
 5274 72a0 00000000 		divu.l	%s54,%s54,%s55
 5274      B7B6366F 
 5275 72a8 00000000 		addu.l	%s54,%s54,%s51
 5275      B3B63648 
 5276 72b0 00000000 		mulu.l	%s54,%s54,%s50
 5276      B2B63649 
 5277 72b8 00000000 		or	%s63,0,%s62
 5277      BE003F45 
 5278 72c0 00000000 		addu.l	%s63,%s54,%s63
 5278      BFB63F48 
 5279 72c8 00000000 		mulu.l	%s63,%s63,%s49
 5279      B1BF3F49 
 5280 72d0 00000000 		or	%s63,0,%s63
 5280      BF003F45 
 5281              	# line 903
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 5282              		.loc	1 903 0
 5283 72d8 00000000 		muls.l	%s63,4,%s63
 5283      BF043F6E 
 5284 72e0 00000000 		adds.l	%s63,%s63,%s48
 5284      B0BF3F59 
 5285 72e8 00000000 		subs.w.sx	%s54,0,%s47
 5285      AF00365A 
 5286 72f0 00000000 		smvl	%s46
 5286      00002E2E 
 5287 72f8 80000000 		mins.w.sx	%s62,%s54,%s46
 5287      AEB63E78 
 5288 7300 00000000 		or	%s59,0,%s54
 5288      B6003B45 
 5289 7308 00000000 		or	%s61,0,%s63
 5289      BF003D45 
 5290 7310 00000000 		or	%s63,0,%s62
 5290      BE003F45 
 5291 7318 00000000 		muls.l	%s60,4,%s63
 5291      BF043C6E 
 5292 7320 10FFFFFF 		br.l	.L6.9
 5292      00000F18 
 5293              	.L6.95:
 5294 7328 50FFFFFF 		brlt.w	0,%s18,.L6.98
 5294      92008218 
 5295 7330 C8FEFFFF 		br.l	.L6.96
 5295      00000F18 
 5296              	.L6.99:
 5297 7338 00000000 		or	%s51,0,%s61
 5297      BD003345 
 5298 7340 00000000 		or	%s1,0,%s63
 5298      BF000145 
 5299 7348 00000000 		or	%s63,0,%s45
 5299      AD003F45 
 5300 7350 00000000 		or	%s2,0,%s61
 5300      BD000245 
 5301 7358 D0FFFFFF 		br.l	.L6.95
 5301      00000F18 
 5302              	.L6.92:
 5303              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 5304              		.loc	1 902 0
 5305 7360 00000000 		or	%s62,0,(0)1
 5305      00003E45 
 5306 7368 D0FFFFFF 		brlt.w	0,%s19,.L6.99
 5306      93008218 
 5307 7370 48FEFFFF 		br.l	.L6.91
 5307      00000F18 
 5308              	.L6.100:
 5309              	# line 901
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 5310              		.loc	1 901 0
 5311 7378 00000000 		divs.w.sx	%s60,%s44,%s43
 5311      ABAC3C7B 
 5312 7380 00000000 		or	%s3,0,%s63
 5312      BF000345 
 5313 7388 00000000 		or	%s4,0,%s62
 5313      BE000445 
 5314 7390 00000000 		subs.w.sx	%s60,0,%s60
 5314      BC003C5A 
 5315 7398 00000000 		or	%s63,0,%s60
 5315      BC003F45 
 5316 73a0 00000000 		or	%s53,0,%s62
 5316      BE003545 
 5317 73a8 B8FFFFFF 		br.l	.L6.92
 5317      00000F18 
 5318              	.L6.89:
 5319 73b0 00000000 		or	%s61,0,(0)1
 5319      00003D45 
 5320 73b8 C0FFFFFF 		brlt.w	0,%s20,.L6.100
 5320      94008218 
 5321 73c0 C0FDFFFF 		br.l	.L6.88
 5321      00000F18 
 5322              	.L6.101:
 5323 73c8 00000000 		divs.w.sx	%s59,%s44,%s43
 5323      ABAC3B7B 
 5324              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 5325              		.loc	1 900 0
 5326 73d0 00000000 		divs.w.sx	%s58,%s42,%s43
 5326      ABAA3A7B 
 5327 73d8 00000000 		or	%s5,0,%s20
 5327      94000545 
 5328 73e0 00000000 		or	%s6,0,%s63
 5328      BF000645 
 5329 73e8 00000000 		or	%s7,0,%s61
 5329      BD000745 
 5330 73f0 00000000 		or	%s21,0,%s60
 5330      BC001545 
 5331 73f8 00000000 		or	%s20,0,%s59
 5331      BB001445 
 5332 7400 00000000 		subs.w.sx	%s58,0,%s58
 5332      BA003A5A 
 5333 7408 00000000 		or	%s63,0,%s58
 5333      BA003F45 
 5334 7410 00000000 		or	%s56,0,%s60
 5334      BC003845 
 5335 7418 98FFFFFF 		br.l	.L6.89
 5335      00000F18 
 5336              	.L6.86:
 5337 7420 00000000 		or	%s62,0,(0)1
 5337      00003E45 
 5338 7428 A0FFFFFF 		brlt.w	0,%s20,.L6.101
 5338      94008218 
 5339 7430 08FDFFFF 		br.l	.L6.85
 5339      00000F18 
 5340              	.L6.102:
 5341 7438 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 5341      89000001 
 5342 7440 00000000 		or	%s22,0,%s1
 5342      81001645 
 5343 7448 00000000 		or	%s23,0,%s3
 5343      83001745 
 5344 7450 14000000 		dldl.sx	%s42,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 5344      80002A0B 
 5345              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5346              		.loc	1 899 0
 5347 7458 00000000 		or	%s60,0,(0)1
 5347      00003C45 
 5348 7460 00000000 		or	%s25,0,%s4
 5348      84001945 
 5349              	# line 900
 900:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****         for (int ic = 0; ic < IC/G; ++ic) {
 5350              		.loc	1 900 0
 5351 7468 00000000 		divs.w.sx	%s20,%s42,%s43
 5351      ABAA147B 
 5352              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5353              		.loc	1 899 0
 5354 7470 00000000 		subs.w.sx	%s62,0,%s43
 5354      AB003E5A 
 5355 7478 00000000 		or	%s26,0,%s2
 5355      82001A45 
 5356 7480 00000000 		or	%s63,0,%s62
 5356      BE003F45 
 5357              	# line 901
 901:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****           for (int kh = 0; kh < p->kh; ++kh) {
 5358              		.loc	1 901 0
 5359 7488 08000000 		dldl.sx	%s44,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 5359      80002C0B 
 5360              	# line 902
 902:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             for (int kw = 0; kw < KW; ++kw) {
 5361              		.loc	1 902 0
 5362 7490 20000000 		dldl.sx	%s19,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 5362      8000130B 
 5363 7498 00000000 		subs.w.sx	%s45,0,%s19
 5363      93002D5A 
 5364              	# line 903
 903:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****               size_t wei_off = wei_off_f(p, g, oc, ic, kh, kw);
 5365              		.loc	1 903 0
 5366 74a0 24000000 		dldl.sx	%s18,36(,%s0)	# *(p).__b_N4conv6desc_tE.kw
 5366      8000120B 
 5367 74a8 00000000 		or	%s49,0,%s18
 5367      92003145 
 5368 74b0 00000000 		subs.w.sx	%s47,0,%s18
 5368      92002F5A 
 5369              	# line 906
 906:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****             }
 5370              		.loc	1 906 0
 5371 74b8 A8010000 		dld	%s48,424(,%s2)	# *(s$194).data_
 5371      82003009 
 5372 74c0 14000000 		dldl.sx	%s62,20(,%s0)	# *(p).__b_N4conv6desc_tE.oc
 5372      80003E0B 
 5373 74c8 00000000 		or	%s62,0,%s62
 5373      BE003E45 
 5374 74d0 00000000 		or	%s61,0,%s62
 5374      BE003D45 
 5375 74d8 00000000 		dldl.sx	%s62,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 5375      80003E0B 
 5376 74e0 00000000 		or	%s55,0,%s62
 5376      BE003745 
 5377 74e8 08000000 		dldl.sx	%s62,8(,%s0)	# *(p).__b_N4conv6desc_tE.ic
 5377      80003E0B 
 5378 74f0 00000000 		or	%s52,0,%s62
 5378      BE003445 
 5379 74f8 20000000 		dldl.sx	%s0,32(,%s0)	# *(p).__b_N4conv6desc_tE.kh
 5379      8000000B 
 5380 7500 00000000 		or	%s50,0,%s0
 5380      80003245 
 5381 7508 18FFFFFF 		br.l	.L6.86
 5381      00000F18 
 5382              	.L6.1:
 5383 7510 10FDFFFF 		ld	%s0,-752(,%fp)	# restore 
 5383      89000001 
 5384              	# line 899
 899:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       for (int oc = 0; oc < OC/G; ++oc) {
 5385              		.loc	1 899 0
 5386 7518 00000000 		ldl.sx	%s43,0(,%s0)	# *(p).__b_N4conv6desc_tE.g
 5386      80002B03 
 5387 7520 18FFFFFF 		brlt.w	0,%s43,.L6.102
 5387      AB008218 
 5388 7528 C8FBFFFF 		br.l	.L6.83
 5388      00000F18 
 5389              	.L6.103:
 5390 7530 00000000 		or	%s1,0,%s33
 5390      A1000145 
 5391 7538 88FCFFFF 		ld	%s2,-888(,%fp)	# restore 
 5391      89000201 
 5392 7540 80FCFFFF 		ld	%s3,-896(,%fp)	# restore 
 5392      89000301 
 5393 7548 78FCFFFF 		ld	%s4,-904(,%fp)	# restore 
 5393      89000401 
 5394 7550 70FCFFFF 		ld	%s24,-912(,%fp)	# restore 
 5394      89001801 
 5395 7558 E0FDFFFF 		ld	%s41,-544(,%fp)	# restore 
 5395      89002901 
 5396 7560 B0FFFFFF 		br.l	.L6.1
 5396      00000F18 
 5397              	.L6.104:
 5398              	# line 876
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 5399              		.loc	1 876 0
 5400 7568 00000000 		adds.w.sx	%s63,1,%s63
 5400      BF013F4A 
 5401 7570 00000000 		adds.w.sx	%s61,%s62,%s61
 5401      BDBE3D4A 
 5402 7578 00000000 		adds.w.sx	%s60,%s62,%s60
 5402      BCBE3C4A 
 5403 7580 00000000 		adds.l	%s58,%s59,%s58
 5403      BABB3A59 
 5404 7588 00000000 		adds.l	%s55,%s56,%s55
 5404      B7B83759 
 5405 7590 98050000 		brgt.w	0,%s63,.L6.105
 5405      BF008118 
 5406 7598 98FFFFFF 		br.l	.L6.103
 5406      00000F18 
 5407              	.L6.106:
 5408              	# line 877
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 5409              		.loc	1 877 0
 5410 75a0 00000000 		subs.l	%s0,0,%s28
 5410      9C00005B 
 5411 75a8 00000000 		lea	%s12,__grow_stack@LO
 5411      00000C06 
 5412 75b0 00000000 		and	%s12,%s12,(32)0
 5412      608C0C44 
 5413 75b8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 5413      8C008C06 
 5414 75c0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 5414      8C000A08 
 5415 75c8 00000000 		or	%s63,0,%s3
 5415      83003F45 
 5416 75d0 00000000 		or	%s62,0,%s4
 5416      84003E45 
 5417 75d8 00000000 		or	%s61,0,%s21
 5417      95003D45 
 5418 75e0 00000000 		or	%s60,0,%s1
 5418      81003C45 
 5419 75e8 00000000 		or	%s59,0,%s5
 5419      85003B45 
 5420 75f0 00000000 		or	%s58,0,%s7
 5420      87003A45 
 5421 75f8 00000000 		or	%s56,0,%s6
 5421      86003845 
 5422 7600 00000000 		or	%s55,0,%s20
 5422      94003745 
 5423 7608 00000000 		or	%s18,0,%s2
 5423      82001245 
 5424 7610 58FFFFFF 		br.l	.L6.104
 5424      00000F18 
 5425              	.L6.107:
 5426              	# line 892
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 5427              		.loc	1 892 0
 5428 7618 00000000 		ldl.sx	%s61,0(%s62,%s63)
 5428      BFBE3D03 
 5429 7620 38000000 		lea	%s58,56
 5429      00003A06 
 5430 7628 00000000 		sll	%s61,%s61,%s58
 5430      BDBA3D65 
 5431 7630 38000000 		lea	%s58,56
 5431      00003A06 
 5432 7638 00000000 		sra.l	%s61,%s61,%s58
 5432      BDBA3D77 
 5433 7640 00000000 		st1b	%s61,0(,%s60)	# *(j$185)
 5433      BC003D15 
 5434              	# line 877
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 5435              		.loc	1 877 0
 5436 7648 00000000 		adds.l	%s60,1,%s60
 5436      BC013C59 
 5437 7650 00000000 		adds.l	%s62,4,%s62
 5437      BE043E59 
 5438 7658 00000000 		adds.w.sx	%s59,-1,%s59
 5438      BB7F3B4A 
 5439 7660 B8FFFFFF 		brlt.w	0,%s59,.L6.107
 5439      BB008218 
 5440 7668 38FFFFFF 		br.l	.L6.106
 5440      00000F18 
 5441              	.L6.108:
 5442 7670 00000000 		or	%s59,0,%s31
 5442      9F003B45 
 5443              	# line 892
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 5444              		.loc	1 892 0
 5445 7678 00000000 		or	%s62,0,(0)1
 5445      00003E45 
 5446 7680 00000000 		or	%s63,0,%s29
 5446      9D003F45 
 5447 7688 00000000 		or	%s1,0,%s60
 5447      BC000145 
 5448 7690 00000000 		or	%s60,0,%s22
 5448      96003C45 
 5449 7698 80FFFFFF 		br.l	.L6.107
 5449      00000F18 
 5450              	.L6.5:
 5451              	# line 881
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 5452              		.loc	1 881 0
 5453 76a0 00000000 		subs.w.sx	%s55,%s61,%s55
 5453      B7BD375A 
 5454              	# line 882
 882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (oh_beg < 0 ) oh_beg = 0;
 5455              		.loc	1 882 0
 5456 76a8 00000000 		lvl	%s58
 5456      00BA00BF 
 5457 76b0 001F0018 		vadds.w.sx	%v24,%s54,%v31
 5457      00B620CA 
 5458 76b8 00001817 		vdivs.w.sx	%v23,%v24,%s57
 5458      00B910EB 
 5459 76c0 00170016 		vmuls.w.sx	%v22,%s57,%v23
 5459      00B920CB 
 5460 76c8 001F0015 		vadds.w.sx	%v21,%s54,%v31
 5460      00B620CA 
 5461 76d0 00161514 		vsubs.w.sx	%v20,%v21,%v22
 5461      000000DA 
 5462 76d8 0014050F 		vfmk.w.ge	%vm15,%v20
 5462      000000B5 
 5463 76e0 0000001E 		vbrd	%v30,0,%vm15
 5463      00000F8C 
 5464 76e8 00000F0F 		negm	%vm15,%vm15
 5464      00000095 
 5465 76f0 0000001E 		vbrd	%v30,1,%vm15
 5465      00010F8C 
 5466 76f8 001D0013 		vadds.w.sx	%v19,%s53,%v29
 5466      00B520CA 
 5467 7700 00001312 		vdivs.w.sx	%v18,%v19,%s57
 5467      00B910EB 
 5468 7708 001E1211 		vsubs.w.sx	%v17,%v18,%v30
 5468      000000DA 
 5469              	# line 883
 883:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (ow_beg < 0 ) ow_beg = 0;
 5470              		.loc	1 883 0
 5471 7710 00000000 		maxs.w.sx	%s52,%s52,(0)1
 5471      00B43478 
 5472 7718 00000000 		or	%s37,0,%s52
 5472      B4002545 
 5473              	# line 884
 884:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (oh_end > OH) oh_end = OH;
 5474              		.loc	1 884 0
 5475 7720 001C0010 		vmaxs.w.sx	%v16,0,%v28
 5475      0000208A 
 5476              	# line 889
 889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][2] = oh_end;
 5477              		.loc	1 889 0
 5478 7728 0010000F 		vor	%v15,(0)1,%v16
 5478      000020C5 
 5479              	# line 885
 885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (ow_end > OW) ow_end = OW;
 5480              		.loc	1 885 0
 5481 7730 80000000 		mins.w.sx	%s55,%s55,%s51
 5481      B3B73778 
 5482 7738 00000000 		or	%s36,0,%s55
 5482      B7002445 
 5483              	# line 886
 886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       const int khkw = kh*KW+kw;
 5484              		.loc	1 886 0
 5485 7740 0011000E 		vmins.w.sx	%v14,%s50,%v17
 5485      00B2308A 
 5486              	# line 891
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
 5487              		.loc	1 891 0
 5488 7748 000E000D 		vor	%v13,(0)1,%v14
 5488      000020C5 
 5489              	# line 888
 888:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][1] = ow_beg;
 5490              		.loc	1 888 0
 5491 7750 0000000C 		vbrd	%v12,%s37
 5491      00A5008C 
 5492 7758 00000000 		or	%s37,0,%s49
 5492      B1002545 
 5493 7760 0000000C 		vst.nc	%v12,32,%s37
 5493      A5200091 
 5494              	# line 889
 889:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][2] = oh_end;
 5495              		.loc	1 889 0
 5496 7768 00000000 		adds.l	%s37,%s49,(0)1
 5496      00B12559 
 5497 7770 00000000 		adds.l	%s35,8,%s37
 5497      A5082359 
 5498 7778 0000000F 		vst.nc	%v15,32,%s35
 5498      A3200091 
 5499              	# line 890
 890:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ohw_begend[khkw][3] = ow_end;
 5500              		.loc	1 890 0
 5501 7780 0000000B 		vbrd	%v11,%s36
 5501      00A4008C 
 5502 7788 00000000 		adds.l	%s36,16,%s37
 5502      A5102459 
 5503 7790 0000000B 		vst.nc	%v11,32,%s36
 5503      A4200091 
 5504              	# line 891
 891:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ook[khkw] = (oh_beg < oh_end && ow_beg < ow_end);
 5505              		.loc	1 891 0
 5506 7798 00000000 		adds.l	%s37,24,%s37
 5506      A5182559 
 5507 77a0 0000000D 		vst.nc	%v13,32,%s37
 5507      A5200091 
 5508              	# line 892
 892:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     }
 5509              		.loc	1 892 0
 5510 77a8 00000000 		cmps.w.sx	%s55,%s52,%s55
 5510      B7B4377A 
 5511 77b0 0000000A 		vbrd	%v10,%s55
 5511      00B7008C 
 5512 77b8 000A020F 		vfmk.w.lt	%vm15,%v10
 5512      000000B5 
 5513 77c0 000E101B 		vcmps.w.sx	%v27,%v16,%v14,%vm15
 5513      00000FFA 
 5514 77c8 001B050E 		vfmk.w.ge	%vm14,%v27,%vm15
 5514      00000FB5 
 5515 77d0 00000F0D 		negm	%vm13,%vm15
 5515      00000095 
 5516 77d8 000D0E0D 		orm	%vm13,%vm14,%vm13
 5516      00000085 
 5517 77e0 0000001A 		vbrd	%v26,0,%vm13
 5517      00000D8C 
 5518 77e8 00000000 		adds.l	%s55,%s48,%s47
 5518      AFB03759 
 5519 77f0 0000001A 		vstl.nc	%v26,4,%s55,%vm13
 5519      B7040D93 
 5520 77f8 000F0E0F 		nndm	%vm15,%vm14,%vm15
 5520      00000094 
 5521 7800 00000019 		vbrd	%v25,1,%vm15
 5521      00010F8C 
 5522 7808 00000000 		or	%s55,0,%s55
 5522      B7003745 
 5523 7810 00000019 		vstl.nc	%v25,4,%s55,%vm15
 5523      B7040F93 
 5524              	# line 877
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 5525              		.loc	1 877 0
 5526 7818 00000000 		adds.w.sx	%s53,%s53,%s46
 5526      AEB5354A 
 5527 7820 00000000 		adds.w.sx	%s54,%s54,%s45
 5527      ADB6364A 
 5528 7828 00000000 		adds.w.sx	%s56,%s56,%s44
 5528      ACB8384A 
 5529 7830 00000000 		adds.w.sx	%s59,%s59,%s43
 5529      ABBB3B4A 
 5530 7838 00000000 		adds.l	%s49,%s49,%s42
 5530      AAB13159 
 5531 7840 00000000 		or	%s40,0,%s40
 5531      A8002845 
 5532 7848 00000000 		adds.l	%s47,%s47,%s40
 5532      A8AF2F59 
 5533 7850 00000000 		or	%s40,0,%s39
 5533      A7002845 
 5534 7858 00000000 		subs.w.sx	%s38,%s38,%s58
 5534      BAA6265A 
 5535 7860 10FEFFFF 		brge.w	0,%s38,.L6.108
 5535      A6008518 
 5536 7868 40E1FFFF 		br.l	.L6.6
 5536      00000F18 
 5537              	.L6.109:
 5538              	# line 881
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 5539              		.loc	1 881 0
 5540 7870 00000000 		or	%s55,1,(0)1
 5540      00013745 
 5541 7878 00000000 		or	%s52,0,%s61
 5541      BD003445 
 5542 7880 00000000 		or	%s61,0,%s1
 5542      81003D45 
 5543 7888 00000000 		smvl	%s13
 5543      00000D2E 
 5544 7890 00000000 		lvl	%s13
 5544      008D00BF 
 5545 7898 0020001C 		vor	%v28,(0)1,%v32
 5545      000020C5 
 5546 78a0 00FEFFFF 		br.l	.L6.5
 5546      00000F18 
 5547              	.L6.3:
 5548              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 5549              		.loc	1 879 0
 5550 78a8 00000000 		subs.w.sx	%s61,%s62,%s61
 5550      BDBE3D5A 
 5551              	# line 880
 880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 5552              		.loc	1 880 0
 5553 78b0 00000000 		lvl	%s58
 5553      00BA00BF 
 5554 78b8 002A0027 		vadds.w.sx	%v39,%s59,%v42
 5554      00BB20CA 
 5555 78c0 00002726 		vdivs.w.sx	%v38,%v39,%s57
 5555      00B910EB 
 5556 78c8 00260025 		vmuls.w.sx	%v37,%s57,%v38
 5556      00B920CB 
 5557 78d0 002A0024 		vadds.w.sx	%v36,%s59,%v42
 5557      00BB20CA 
 5558 78d8 00252423 		vsubs.w.sx	%v35,%v36,%v37
 5558      000000DA 
 5559 78e0 0023050F 		vfmk.w.ge	%vm15,%v35
 5559      000000B5 
 5560 78e8 00000029 		vbrd	%v41,0,%vm15
 5560      00000F8C 
 5561 78f0 00000F0F 		negm	%vm15,%vm15
 5561      00000095 
 5562 78f8 00000029 		vbrd	%v41,1,%vm15
 5562      00010F8C 
 5563 7900 00280022 		vadds.w.sx	%v34,%s56,%v40
 5563      00B820CA 
 5564 7908 00002221 		vdivs.w.sx	%v33,%v34,%s57
 5564      00B910EB 
 5565 7910 00292120 		vsubs.w.sx	%v32,%v33,%v41
 5565      000000DA 
 5566 7918 58FFFFFF 		brgt.w	0,%s19,.L6.109
 5566      93008118 
 5567 7920 50E0FFFF 		br.l	.L6.4
 5567      00000F18 
 5568              	.L6.110:
 5569              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 5570              		.loc	1 879 0
 5571 7928 00000000 		or	%s63,1,(0)1
 5571      00013F45 
 5572 7930 00000000 		or	%s1,0,%s61
 5572      BD000145 
 5573 7938 00000000 		or	%s61,0,%s63
 5573      BF003D45 
 5574 7940 68FFFFFF 		br.l	.L6.3
 5574      00000F18 
 5575              	.L6.7:
 5576 7948 E0FFFFFF 		brgt.w	0,%s18,.L6.110
 5576      92008118 
 5577 7950 00E0FFFF 		br.l	.L6.2
 5577      00000F18 
 5578              	.L6.111:
 5579 7958 58FDFFFF 		st	%s63,-680(,%fp)	# spill 
 5579      89003F11 
 5580 7960 00000000 		divs.w.sx	%s63,%s61,%s23
 5580      97BD3F7B 
 5581 7968 00000000 		muls.w.sx	%s63,%s23,%s63
 5581      BF973F4B 
 5582 7970 00000000 		subs.w.sx	%s28,%s61,%s63
 5582      BFBD1C5A 
 5583 7978 00000000 		divs.w.sx	%s29,%s61,%s23
 5583      97BD1D7B 
 5584              	# line 881
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 5585              		.loc	1 881 0
 5586 7980 00000000 		divs.w.sx	%s63,%s60,%s23
 5586      97BC3F7B 
 5587 7988 00000000 		muls.w.sx	%s63,%s23,%s63
 5587      BF973F4B 
 5588 7990 00000000 		subs.w.sx	%s19,%s60,%s63
 5588      BFBC135A 
 5589 7998 00000000 		divs.w.sx	%s30,%s60,%s23
 5589      97BC1E7B 
 5590 79a0 00000000 		or	%s22,0,%s55
 5590      B7001645 
 5591              	# line 877
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 5592              		.loc	1 877 0
 5593 79a8 00000000 		subs.w.sx	%s31,0,%s24
 5593      98001F5A 
 5594 79b0 00000000 		smvl	%s32
 5594      0000202E 
 5595 79b8 00000000 		muls.l	%s0,4,%s31
 5595      9F04006E 
 5596 79c0 50FDFFFF 		st	%s0,-688(,%fp)	# spill 
 5596      89000011 
 5597 79c8 00000000 		lea	%s12,__grow_stack@LO
 5597      00000C06 
 5598 79d0 00000000 		and	%s12,%s12,(32)0
 5598      608C0C44 
 5599 79d8 00000000 		lea.sl	%s12,__grow_stack@HI(,%s12)
 5599      8C008C06 
 5600 79e0 00000000 		bsic	%lr,(,%s12)	# __grow_stack
 5600      8C000A08 
 5601 79e8 B8000000 		lea	%s63,184
 5601      00003F06 
 5602 79f0 00000000 		adds.l	%s48,%sp,%s63
 5602      BF8B3059 
 5603 79f8 00000000 		or	%s2,0,%s18
 5603      92000245 
 5604 7a00 00000000 		or	%s18,0,%s28
 5604      9C001245 
 5605 7a08 00000000 		or	%s63,0,%s29
 5605      9D003F45 
 5606 7a10 00000000 		or	%s29,0,%s48
 5606      B0001D45 
 5607 7a18 80000000 		mins.w.sx	%s52,%s31,%s32
 5607      A09F3478 
 5608 7a20 00000000 		or	%s38,0,%s31
 5608      9F002645 
 5609 7a28 00000000 		lvl	%s52
 5609      00B400BF 
 5610 7a30 00000009 		vseq	%v9
 5610      00000099 
 5611 7a38 00000000 		or	%s53,0,%s25
 5611      99003545 
 5612 7a40 00000000 		muls.w.sx	%s46,%s26,%s52
 5612      B49A2E4B 
 5613 7a48 00000000 		or	%s21,0,%s61
 5613      BD001545 
 5614 7a50 00000000 		or	%s61,0,%s30
 5614      9E003D45 
 5615 7a58 58FDFFFF 		ld	%s3,-680(,%fp)	# restore 
 5615      89000301 
 5616 7a60 00000000 		or	%s4,0,%s62
 5616      BE000445 
 5617 7a68 00000000 		or	%s62,0,%s63
 5617      BF003E45 
 5618 7a70 00000000 		or	%s5,0,%s59
 5618      BB000545 
 5619 7a78 00000000 		or	%s6,0,%s56
 5619      B8000645 
 5620 7a80 00000000 		or	%s7,0,%s58
 5620      BA000745 
 5621 7a88 00000000 		or	%s20,0,%s55
 5621      B7001445 
 5622 7a90 50FDFFFF 		ld	%s28,-688(,%fp)	# restore 
 5622      89001C01 
 5623 7a98 0009001D 		vmuls.w.sx	%v29,%s26,%v9
 5623      009A20CB 
 5624 7aa0 00000000 		or	%s54,0,%s25
 5624      99003645 
 5625 7aa8 00000000 		muls.w.sx	%s45,%s26,%s52
 5625      B49A2D4B 
 5626 7ab0 0009001F 		vmuls.w.sx	%v31,%s26,%v9
 5626      009A20CB 
 5627 7ab8 00000000 		or	%s56,0,%s27
 5627      9B003845 
 5628 7ac0 00000000 		muls.w.sx	%s44,%s26,%s52
 5628      B49A2C4B 
 5629 7ac8 00090028 		vmuls.w.sx	%v40,%s26,%v9
 5629      009A20CB 
 5630 7ad0 00000000 		or	%s59,0,%s27
 5630      9B003B45 
 5631 7ad8 00000000 		muls.w.sx	%s43,%s26,%s52
 5631      B49A2B4B 
 5632 7ae0 0009002A 		vmuls.w.sx	%v42,%s26,%v9
 5632      009A20CB 
 5633 7ae8 00000000 		or	%s49,0,%s58
 5633      BA003145 
 5634 7af0 00000000 		or	%s63,0,%s52
 5634      B4003F45 
 5635 7af8 00000000 		muls.l	%s42,32,%s63
 5635      BF202A6E 
 5636 7b00 00000000 		or	%s58,0,%s52
 5636      B4003A45 
 5637 7b08 00000000 		muls.w.sx	%s40,4,%s52
 5637      B404284B 
 5638 7b10 00000000 		or	%s47,0,(0)1
 5638      00002F45 
 5639 7b18 00000000 		muls.w.sx	%s39,4,%s32
 5639      A004274B 
 5640 7b20 28FEFFFF 		br.l	.L6.7
 5640      00000F18 
 5641              	.L6.105:
 5642 7b28 30FEFFFF 		brlt.w	0,%s18,.L6.111
 5642      92008218 
 5643 7b30 38FAFFFF 		br.l	.L6.104
 5643      00000F18 
 5644              	.L6.0:
 5645 7b38 88FCFFFF 		st	%s2,-888(,%fp)	# spill 
 5645      89000211 
 5646 7b40 80FCFFFF 		st	%s3,-896(,%fp)	# spill 
 5646      89000311 
 5647 7b48 78FCFFFF 		st	%s4,-904(,%fp)	# spill 
 5647      89000411 
 5648 7b50 70FCFFFF 		st	%s24,-912(,%fp)	# spill 
 5648      89001811 
 5649 7b58 E0FDFFFF 		st	%s41,-544(,%fp)	# spill 
 5649      89002911 
 5650 7b60 10FDFFFF 		ld	%s54,-752(,%fp)	# restore 
 5650      89003601 
 5651 7b68 00000000 		or	%s33,0,%s1
 5651      81002145 
 5652 7b70 24000000 		dldl.sx	%s18,36(,%s54)	# *(p).__b_N4conv6desc_tE.kw
 5652      B600120B 
 5653 7b78 00000000 		or	%s56,0,%s18
 5653      92003845 
 5654 7b80 00000000 		subs.w.sx	%s24,0,%s18
 5654      9200185A 
 5655 7b88 40FEFFFF 		dld	%s53,-448(,%fp)	# ohw_begend
 5655      89003509 
 5656 7b90 00000000 		or	%s58,0,%s53
 5656      B5003A45 
 5657 7b98 00000000 		or	%s55,0,%s63
 5657      BF003745 
 5658              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 5659              		.loc	1 879 0
 5660 7ba0 30000000 		dldl.sx	%s53,48(,%s54)	# *(p).__b_N4conv6desc_tE.ph
 5660      B600350B 
 5661 7ba8 38000000 		dldl.sx	%s52,56(,%s54)	# *(p).__b_N4conv6desc_tE.dh
 5661      B600340B 
 5662 7bb0 00000000 		adds.w.sx	%s52,1,%s52
 5662      B401344A 
 5663              	# line 876
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 5664              		.loc	1 876 0
 5665 7bb8 00000000 		subs.w.sx	%s62,0,%s52
 5665      B4003E5A 
 5666              	# line 879
 879:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_beg=div_floor(    + PW - kw * (p->dw + 1) + SW - 1, SW);
 5667              		.loc	1 879 0
 5668 7bc0 28000000 		dldl.sx	%s23,40(,%s54)	# *(p).__b_N4conv6desc_tE.sh
 5668      B600170B 
 5669              	# line 876
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 5670              		.loc	1 876 0
 5671 7bc8 00000000 		adds.w.sx	%s52,%s53,%s23
 5671      97B5344A 
 5672 7bd0 00000000 		muls.l	%s59,32,%s56
 5672      B8203B6E 
 5673 7bd8 00000000 		subs.w.sx	%s0,0,%s0
 5673      8000005A 
 5674 7be0 00000000 		or	%s63,0,%s0
 5674      80003F45 
 5675              	# line 880
 880:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       oh_end=div_floor( IH + PH - kh * (p->dh + 1) + SH - 1, SH);
 5676              		.loc	1 880 0
 5677 7be8 34000000 		dldl.sx	%s49,52(,%s54)	# *(p).__b_N4conv6desc_tE.pw
 5677      B600310B 
 5678 7bf0 2C000000 		dldl.sx	%s57,44(,%s54)	# *(p).__b_N4conv6desc_tE.sw
 5678      B600390B 
 5679 7bf8 00000000 		adds.w.sx	%s48,%s49,%s57
 5679      B9B1304A 
 5680 7c00 00000000 		adds.w.sx	%s27,-1,%s48
 5680      B07F1B4A 
 5681 7c08 3C000000 		dldl.sx	%s48,60(,%s54)	# *(p).__b_N4conv6desc_tE.dw
 5681      B600300B 
 5682 7c10 00000000 		adds.w.sx	%s48,1,%s48
 5682      B001304A 
 5683              	# line 877
 877:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       int oh_beg, ow_beg, oh_end, ow_end;
 5684              		.loc	1 877 0
 5685 7c18 00000000 		subs.w.sx	%s26,0,%s48
 5685      B0001A5A 
 5686              	# line 881
 881:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       ow_end=div_floor( IW + PW - kw * (p->dw + 1) + SW - 1, SW);
 5687              		.loc	1 881 0
 5688 7c20 0C000000 		dldl.sx	%s48,12(,%s54)	# *(p).__b_N4conv6desc_tE.ih
 5688      B600300B 
 5689 7c28 00000000 		adds.w.sx	%s48,%s53,%s48
 5689      B0B5304A 
 5690              	# line 876
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 5691              		.loc	1 876 0
 5692 7c30 00000000 		adds.w.sx	%s48,%s23,%s48
 5692      B097304A 
 5693              	# line 882
 882:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (oh_beg < 0 ) oh_beg = 0;
 5694              		.loc	1 882 0
 5695 7c38 10000000 		dldl.sx	%s53,16(,%s54)	# *(p).__b_N4conv6desc_tE.iw
 5695      B600350B 
 5696 7c40 00000000 		adds.w.sx	%s53,%s49,%s53
 5696      B5B1354A 
 5697 7c48 00000000 		adds.w.sx	%s53,%s57,%s53
 5697      B5B9354A 
 5698 7c50 00000000 		adds.w.sx	%s25,-1,%s53
 5698      B57F194A 
 5699              	# line 885
 885:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       if (ow_end > OW) ow_end = OW;
 5700              		.loc	1 885 0
 5701 7c58 18000000 		dldl.sx	%s51,24(,%s54)	# *(p).__b_N4conv6desc_tE.oh
 5701      B600330B 
 5702              	# line 886
 886:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****       const int khkw = kh*KW+kw;
 5703              		.loc	1 886 0
 5704 7c60 1C000000 		dldl.sx	%s50,28(,%s54)	# *(p).__b_N4conv6desc_tE.ow
 5704      B600320B 
 5705              	# line 876
 876:/usr/uhome/aurora/4gi/nlabhpg/work/kruus/gen-dnn/tests/benchdnn/conv/ref_conv3.cpp ****     for (int kw = 0; kw < p->kw; ++kw) {
 5706              		.loc	1 876 0
 5707 7c68 00000000 		adds.w.sx	%s52,-1,%s52
 5707      B47F344A 
 5708 7c70 00000000 		or	%s61,0,%s52
 5708      B4003D45 
 5709 7c78 00000000 		adds.w.sx	%s48,-1,%s48
 5709      B07F304A 
 5710 7c80 00000000 		or	%s60,0,%s48
 5710      B0003C45 
 5711 7c88 A0FEFFFF 		br.l	.L6.105
 5711      00000F18 
 5712              		.cfi_endproc
 5713              		.set	.L.7.2auto_size,	0xfffffffffffff9e0	# 1568 Bytes
 5715              	# ============ End  conv::refconv_3_bwd_w(conv::prb_t const*, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&, dnn_mem_t&) ============
 5716              		.weak div_floor(int, int)
