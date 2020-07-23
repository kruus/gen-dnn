=== General VE characteristics (nc++-3.0.27)

lambda function overhead fairly noticable. Lambdas not inlined, while
true func calls can be inlined.

Sometimes VE_OMP_NUM_THREADS>1 VE_PROGINFO=DETAIL runs hang during exit
stats printout.

Depending sentsitively on compile options, zero, underlow and overflow results
like +/-NaN and +/-inf for vectorized math functions may not agree with scalar
(or IEEE) results.  Usually the scalar functions conform to standards.

Conditions inside loops can create problems / slowdowns,
even if compile-time const.

arrange inner loops to have high vector length.

use memory_desc_wrapper_opt to vectorize func calls to physical offset calcs.

vectorization often disallowed for runtime-dim stack array temporaries, but
can allocate "max size" array[constexpr] as workaround.

need to verify vectorization in .LL diagnostics output

=== todo / done

softmax v1.4 version already done, better than v0.16 version

lrn 	yanking v0.16 optimizations into this version (pretty similar, v1.4 just adds ncdhw possibility
	not using off_v_vec yet, mostly just taking ifs out of loops to allow vectorization.
	also force vectorization across channels, and not the kernel width (typical only 5).
	further optimizations done for across,within fwd,bkwd.  vectorizing across channels,
        nhwc layout can be ~ 3x better than even highly optimized nchw WITHIN kernel.
	Can we use same 'dense layout' approach as softmax to handle more "any" cases?
	BWD has some low-channel loop-order checks, but not FWD.
	TODO: benchdnn --lnorm --dir=BWD_DW --stat_tag=abx --flags=S --inplace=false 256x768
		accuracy threshold is slightly exceeded

batch_normalization stuff is 10x to 200x faster (avg 38x speedup on benchdnn)
bnorm WIP (need to consider how to handle mdw::off_v_vec "officially")
	lrn did this, so possibly more speedups for bnorm
	TODO: int8 on VE (for workspace) is unvectorizable. Is bitmap vectorized?
	caveat - std::vector<bool> has weak threading guarantees.
bnorm still not "fast", but maybe the 3 hr benchdnn test is largely due to the "reorders"
	work around ccom compiler error by explicityly adding -mno-vector-intrinsic-check (just in case)

eltwise_generic might also need 'off_l_vec' optimization
	for vectorization, move 'switch' cases out of loop.
		fwd speedups O(250)x for large tensors
	LIMIT CASE ISSUES:
	eltwise_pow with beta==-1 has issues with f(-0)  (are alpha cases ok?)
	eltwise_logistic alpha=0.1 beta=0.2 during gtest

	I notice that for "tiny" benchdnn tests, things take uniformly .057 ms,
	regardless of --alg, which represents omp + balance + "invoke lambda"
	overhead!  In comparison, on x86 this is ~ 0.019 ms (3x faster on x86).

	ref_eltwise bwd generic (only a few cases hit this) is optimized.

	TBD: VE vectorization for forward_nCspBc_padded
		(same method as forward_dense)

simple_sum should begin by following v0.16 version
	did some further optimizations.  still slow cf. x64, I think

simple_concat 
	some work on ve version, based on v0.16 impl (needs work)
	main mod is to introduce memcpy_wrap<T>, which avoids fn call for types T
	which nc++ is able to efficiently vectorize.  bf16 now also allowed for
	simple_concat because it is size 2 and memcpyable.  VE has no vectorization
        support for 1- or 2-byte types,so revert to memcpy in those cases.
	ve-banch-catP.log: Av VL 102, Vec% only 11$
	(is this the scalar reorders, or perhaps small benchdnn problem sizes?)

rnn ?? still rather slow.  Have not looked at it.

pooling	already started with VE bugfixes, no optimization yet: off_v_vec optimizations possible

simple_reorder wants at least the v0.16 ShortLoop() pragmas reinstated
	and reorder(any,any,any) using off_l reorder should use 'off_l_vec'
	- actually this is an interesting case of how to introduce batching into
	  a parallel_nd construct
	Split apart the 45-minute compile of cpu_reorder (nc++ stuck in ipa, which eventually stops)
	by putting reorder map values `std::vector<rpd_create_f>` into separate small files.
	BUT, split apart compiler ipa is not stopped, and segfaults happen.
	SAFEST is to do the forever-compile, which stops ipa, and avoids the split-induced segfaults.

ref_deconvolution
	switching to vectorized offset calcs (WIP)
	convolution segfaults dealt with. Compilation correctness for im2col/col2im worked around.
	Hardest was compile bug for backward weights, where hoisting conditionals always resulted
	in some [rare] segfaults.
	TODO: vectorize offset calcs
	TODO: im2col and col2im unrollings (a la v0.16)

### cblas (build.sh -C)
FindBLAS is no longer working.  hardwired USE_CBLAS and directories using cmake/ve.cmake toolchain variables.
Changed to blas_openmp instead of \_sequential version.  Introduces msan_unpoison_matrix assertion failure:
```
benchdnn: /home/kruus/vanilla-dbg/src/cpu/gemm/gemm_msan_unpoison.hpp:26: void dnnl::impl::cpu::msan_unpoison_matrix(void *, long, long, long, unsigned long): Assertion `C != nullptr && M > 0 && N > 0 && LDC >= M && typesize' failed. 
```
Also now see segfault in deconv (below) ... reverting to blas_sequential (VE_SEQ=1 default setting)

### sample tests

default benchdnn tests :

[aurora-ds08 vanilla-dbg]$ { { make -C build-ve -j 16 install || make -C build-ve -j 1 install; } && ./vetest.sh -B build-ve -L ve-bench-elt.log -t 8 -v -T test_benchdnn_eltwise; } >& ve-elt.log && echo YAY || echo OHOH

test_benchdnn_eltwise in --mode=P :

[aurora-ds08 vanilla-dbg]$ { { make -C build-ve -j 16 install || make -C build-ve -j 1 install; } && (cd /home/kruus/vanilla-dbg/build-ve/tests/benchdnn && /usr/bin/env DNNL_VERBOSE=1 VE_PROGINF=DETAIL DNNL_VERBOSE=0 OMP_NUM_THREADS=8 VE_OMP_NUM_THREADS=8 VE_NODE_NUMBER=2 /home/kruus/vanilla-dbg/build-ve/tests/benchdnn/benchdnn -v1 --engine=cpu --mode=P --eltwise --batch=inputs/eltwise/test_eltwise_all); } >& ve-bench-eltP.log && echo YAY || echo OHOH

debug a single test case :

[aurora-ds08 vanilla-dbg]$ { { make -C build-ve -j 16 install || make -C build-ve -j 1 install; } && ./vetest.sh -B build-ve -v -L f.log --benchdnn --mode=C --eltwise --dir=FWD_D --alg=exp_dst alpha=0 beta=0 44x88x33x3; } >& ve-elt.log && echo YAY || echo OHOH

S=vejd2 B=build-$S I=install-$S; { rm -f $I; { make -C $B -j 16 install || make -C $B -j 1 install; } >& x.log  && VE_NODE_NUMBER=2 DNNL_VERBOSE=2 gdb --args $B/tests/benchdnn/benchdnn --mode=C -v8 --conv --dir=FWD_D,BWD_D,BWD_WB --stag=axb --dtag=axb mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1 ; }
S=vejd2 B=build-$S I=install-$S; { rm -f $I; { make -C $B -j 16 install || make -C $B -j 1 install; } >& x.log  && ./vetest.sh -B $B -N 0 -L f.log --benchdnn -v8 --mode=C --conv --dir=BWD_WB --stag=abx --dtag=abx mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1 ; } >&y.log && echo YAY || echo OHOH
S=vejd2 B=build-$S I=install-$S; { rm -f $I; { make -C $B -j 16 install || make -C $B -j 1 install; } >& x.log  && ./vetest.sh -B $B -N 0 -L f.log -T test_sum; } >&y.log && echo YAY || echo OHOH

### Errors during fixing of git tag v1.4-dbg-0

##### linking with cblas, an assertion fails during test_rnn_small:

```
dnnl_verbose,exec,cpu,reorder,simple:any,undef,src_f32::blocked:abcd:f0 dst_f32::blocked:abcd:f0,,,1x1x3x2,0.0168457
rel_eps(0x1p-14) eps(0x1p-20) 84
rel_eps(6.10352e-05) eps(9.53674e-07) 84
dt: min(-0x1.0f3558p-2) max(0x1.054018p+1) mean(0x1.34282ef555555p-1), var(0x1.759cc08dd6486p-1)
dt: min(-0.264852) max(2.04102) mean(0.6benchdnn: /home/kruus/vanilla-dbg/src/cpu/gemm/gemm_msan_unpoison.hpp:26: void dnnl::impl::cpu::msan_unpoison_matrix(void *, long, long, long, unsigned long): Assertion `C != nullptr && M > 0 && N > 0 && LDC >= M && typesize' failed. 
/bin/sh: line 1: 35378 Killed                  /home/kruus/vanilla-dbg/build-vejdC/tests/benchdnn/benchdnn -v1 --engine=cpu --rnn --batch=inputs/rnn/test_rnn_small
```
next try... failed assertion: M > 0 && N > 0 && LDC >= M
FIX: rnn calls extended_sgemm with N==0, so check first: `if (*N > 0) msan_unpoison_matrix`

##### new bugs (from ve mods)

```
[ RUN      ] SimpleZeroDim_f32/eltwise_test_f32.TestsEltwise/0
dnnl_verbose,info,oneDNN v1.4.0 (commit 30203a2a9a60bb0c1f45b09d33025ca86977a8eb)
dnnl_verbose,info,cpu,runtime:OpenMP
dnnl_verbose,info,cpu,isa:Generic
dnnl_verbose,info,gpu,runtime:none
dnnl_verbose,create:cache_miss,cpu,eltwise,ref:any,forward_training,data_f32::blocked:abcde:f0 diff_undef::undef::f0,,alg:eltwise_gelu_tanh alpha:0.1 beta:0,0x2x4x4x4,0.0720215
dnnl_verbose,exec,cpu,eltwise,ref:any,forward_training,data_f32::blocked:abcde:f0 diff_undef::undef::f0,,alg:eltwise_gelu_tanh alpha:0.1 beta:0,0x2x4x4x4,0.00292969
test_eltwise: /home/kruus/vanilla-dbg/src/cpu/ref_eltwise.hpp:145: dnnl_status_t dnnl::impl::cpu::ref_eltwise_bwd_t<data_type>::pd_t::init(dnnl_engine *) [with data_type = (dnnl_data_type_t)3]: Assertion `(!(!use_dense_) || !!(one_of(alg_, eltwise_pow, eltwise_sqrt, eltwise_log, eltwise_sqrt_use_dst_for_bwd )))' failed.
```
FIXED: just support all alg_kind in generic (as done for dense bwd eltwise) 
--eltwise --tag=aBx8b --alg=pow --alpha=-0.25 --beta=-1 3x7x4x5
	[  13][0x0x2x3] src:       -0 fp0:     -inf fp:     -inf dt:      inf diff:     inf rdiff:    -nan
RESOLUTION: live with it for now.  It is already special-cased a bit.
Note: in Release mode compile, limit case behavior is OK, but in debug mode there are differences.
      vector ops are documented to skimp on limit case behaviour for speed.

Tests 2,3,4,5,6 fail (wrong result)
```
[  FAILED  ] SimpleSmall_NCHW_CPU/deconvolution_test_float.TestDeconvolution/2
```
or benchdnn test_deconv_all, at beginnning of test.

test_conv_regression segfault w/ benchdnn: `--conv --cfg=f32_full mb1ic16ih1oc16oh1kh3ph0`

retrying using libblas_sequential...

##### ./build.sh -vdd
some error in cpu_reorder file split?  anything with reorders has issues!
modify scr/cpu/CMakeLists to make it optional.

##### compare -O4 with -O3 compile
Segfault during: benchdnn -v1 --engine=cpu --sum --batch=inputs/sum/test_sum_all
Example benchdnn test:
 benchdnn --mode=C -v5 --sum --ddt=u8 --sdt=f32:f32 --dtag=abx  3x3x16x4
Segfault: --shuffle --dt=s8 --tag=axb --group=4 1x12x56x56
	--reorder --sdt=f32 --ddt=s8 --stag=aBx16b --dtag=aBx16b --attr="oscale=per_dim_1:8;" 2x64x3x3
	--conv --cfg=f32_full mb1ic16ih1oc16oh1kh3ph0
	--pool --dir=FWD_I --cfg=s8 --tag=axb --alg=AVG_P ic64iw32ow16kw3sw2pw0
	--matmul --stag=ba --wtag=ba --runtime_m=1 --runtime_n=1 --runtime_k=1 --bia_dt=f32 --attr="oscale=per_oc:2.25*;post_ops='relu';" m10n20k30
	--conv --dir=BWD_D g1ic16iw5oc16ow3kw3pw4dw4n"large_padding_and_dilation_w.r.t._kernel_size"
	--conv --alg=auto mb9ic3ih300oc64oh300kh3ph1n"ssd_300_voc0712:conv1_1"
	--conv ic512ih14oc512oh14kh3ph1n"vgg_19:conv5_1*4"
	--conv --dir=BWD_D --cfg=f32_full ic4ih8iw8oc6oh4ow8kh3kw3sh2sw1ph1pw1dh1dw0n"dilated_conv:11"
	--conv --dir=BWD_D g32ic32ih112oc32oh112kh3ph1n"mobilenet:conv2_1/dw"
	--concat --ddt=s8 --dtag=aBx16b --axis=3 3x4x5x13:3x4x5x17
	--binary --sdt=s8:s8 --ddt=s8 --stag=abc:bac --alg=MAX --inplace=false 4x6x7:4x6x1
	--sum --ddt=u8 --dtag=abx --scales=0.25 3x3x16x4
Compile with -O3: removes segfaults in shuffle,reorder,pool,matmul,concat,binary,sum
./build.sh -addTttttt
gtests: failed: ;test_deconvolution;test_eltwise
	Ex: Simple_blocked_padded_f32/eltwise_test_f32.TestsEltwise/38 Simple_blocked_3d_padded_f32/eltwise_test_f32.TestsEltwise/12
		 Simple_blocked_padded_f32/eltwise_test_f32.TestsEltwise/51
		(limit case behavior, ignorable)
		SimpleSmall_NCHW_CPU/deconvolution_test_float.TestDeconvolution/2
		(also likely to be limit case behavior of math funcs)
	segfaults:
	--conv --cfg=f32_full mb1ic16ih1oc16oh1kh3ph0
	--conv --dir=BWD_D g1ic16iw5oc16ow3kw3pw4dw4n"large_padding_and_dilation_w.r.t._kernel_size"
	--conv --dir=BWD_D --alg=auto ic3ih300oc64oh300kh3ph1n"ssd_300_voc0712:conv1_1"
	--conv ic512ih14oc512oh14kh3ph1n"vgg_19:conv5_1*4"
	--conv --dir=BWD_D --cfg=f32_full ic4ih8iw8oc6oh4ow8kh3kw3sh2sw1ph1pw1dh1dw0n"dilated_conv:11"
	--conv --dir=BWD_D g32ic32ih112oc32oh112kh3ph1n"mobilenet:conv2_1/dw"
		Hopefully an init() logic bug (try using consistency.hpp for the header *first*)

----------------------------------------- 
After some col2im & im2col fixes (conditional hoisting), some of above errors now pass.
Gtests now show some errors:

BackwardData_Simple_NCHW_CPU/convolution_test.TestConvolution/6 FAILED during
	build-vejd2/tests/gtests/test_convolution_backward_data_f32
A corresponding "wrong result" benchdnn test is:
	--mode=C --conv --dir=BWD_D --stag=acdb --wtag=decab --dtag=axb mb2_g2ic4oc6_ih4oh4kh3sh1dh0ph0_iw4ow4kw3sw1dw0pw0
This failure exercises ref:any backward_data:
gtest:
dnnl_verbose,exec,cpu,convolution,ref:any,backward_data,src_f32::blocked:acdb:f0 wei_f32::blocked:decab:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_g2ic4oc6_ih4oh4kh3sh1dh0ph0_iw4ow4kw3sw1dw0pw0,0.218018
benchdnn:
dnnl_verbose,exec,cpu,convolution,ref:any,backward_data,src_f32::blocked:acdb:f0 wei_f32::blocked:decab:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_g2ic4oc6_ih4oh4kh3sh1dh0ph0_iw4ow4kw3sw1dw0pw0,0.220947

Also test:
   wrong results:
	--conv --dir=BWD_D --stag=aBcd16b --wtag=abcde --dtag=aBcd16b mb1_g16ic16oc16_ih500oh698kh3sh1dh0ph100_iw500ow698kw3sw1dw0pw100
   segfault:
	--conv --dir=BWD_D --stag=aBcd16b --wtag=Abcde16a --dtag=aBcd16b mb1_g16ic16oc16_ih500oh698kh3sh1dh0ph100_iw500ow698kw3sw1dw0pw100
In some respects, segfault is nicer because maybe gdb backtrace can (if very lucky) point at potential issues.
	... Ex. ref_convolution.cpp:365 'if(...) continue'
	... FIXED (test in stages, OFFND=0,1,2 : split apart monolithic "d +=" into 3 statements

Next corruption : --conv g1ic3ih224oc64oh112kh7sh2ph3
	 /home/kruus/vanilla-dbg/src/cpu/ve/gemm_convolution_utils.cpp:787   im2col

------------------------------ now tackle deconv gtest issue
[ RUN      ] SimpleSmall_NCHW_CPU/deconvolution_test_float.TestDeconvolution/3
 ref_deconvolution_bwd_t [/home/kruus/vanilla-dbg/src/cpu/ve/ref_deconvolution.hpp:323] (desc()->prop_kind == prop_kind::backward_data)
dnnl_verbose,create:cache_miss,cpu,convolution,ref:any,backward_data,src_f32::blocked:acdb:f0 wei_f32::blocked:cdab:f0 bia_f32::blocked:a:f0 dst_f32::blocked:acdb:f0,scratchpad_mode:user;,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0551758
dnnl_verbose,create:cache_miss,cpu,deconvolution,ref:any,forward_training,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_f32::blocked:a:f0 dst_f32::blocked:acdb:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.529053
dnnl_verbose,exec,cpu,deconvolution,ref:any,forward_training,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_f32::blocked:a:f0 dst_f32::blocked:acdb:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.531982
dnnl_verbose,create:cache_miss,cpu,convolution,ref:any,backward_data,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0620117
dnnl_verbose,exec,cpu,convolution,ref:any,backward_data,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.447998
 ref_deconvolution_bwd_t [/home/kruus/vanilla-dbg/src/cpu/ve/ref_deconvolution.hpp:323] (desc()->prop_kind == prop_kind::backward_data)
dnnl_verbose,create:cache_miss,cpu,convolution,ref:any,forward_training,src_f32::blocked:acdb:f0 wei_f32::blocked:cdab:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,scratchpad_mode:user;,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0529785
dnnl_verbose,create:cache_miss,cpu,deconvolution,ref:any,backward_data,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.5271
dnnl_verbose,exec,cpu,deconvolution,ref:any,backward_data,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.49292
dnnl_verbose,create:cache_miss,cpu,convolution,ref:any,forward_training,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0629883
dnnl_verbose,exec,cpu,convolution,ref:any,forward_training,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.444092
 ref_deconvolution_bwd_t [/home/kruus/vanilla-dbg/src/cpu/ve/ref_deconvolution.hpp:323] (desc()->prop_kind == prop_kind::backward_data)
dnnl_verbose,create:cache_miss,cpu,convolution,ref:any,backward_weights,src_f32::blocked:acdb:f0 wei_f32::blocked:cdab:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,scratchpad_mode:user;,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0510254
dnnl_verbose,create:cache_miss,cpu,deconvolution,ref:any,backward_weights,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_f32::blocked:a:f0 dst_f32::blocked:acdb:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.506836
dnnl_verbose,exec,cpu,deconvolution,ref:any,backward_weights,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_f32::blocked:a:f0 dst_f32::blocked:acdb:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.141113
dnnl_verbose,create:cache_miss,cpu,convolution,ref:any,backward_weights,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0629883
dnnl_verbose,exec,cpu,convolution,ref:any,backward_weights,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0788574
benchdnn: --deconv --dir=FWD_D,BWD_W,BWD_D --stag=acdb --wtag=cdba --dtag=acdb mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1

--deconv --dir=FWD_D,BWD_D,BWD_W --stag=acdb --wtag=cdba --dtag=acdb mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1
fails for BWD_W (FWD_D,BWD_D ok)
run: --deconv --dir=BWD_W --stag=acdb --wtag=cdba --dtag=acdb ic6ih4oc4oh4kh3ph1
oneDNN implementation: ref:any
dnnl_verbose,create:cache_miss,cpu,convolution,ref:any,backward_weights,src_f32::blocked:acdb:f0 wei_f32::blocked:cdab:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,scratchpad_mode:user;,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.0529785

also fails during corresponding --conv operation, for BWD_W only:
	--conv --dir=FWD_D,BWD_D,BWD_W --stag=acdb --wtag=cdba --dtag=acdb mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1
Thread 3 "ve_exec" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ff817fff000 (LWP 112248)]
0x000060000ba27780 in dnnl_primitive_attr::_ZZNK4dnnl4impl3cpu21ref_convolution_fwd_tIL16dnnl_data_type_t3ELS3_3ELS3_3ELS3_3EE15execute_forwardERKNS0_10exec_ctx_tEEUlRffE_::_ZZNK4dnnl4impl3cpu21ref_convolution_fwd_tIL16dnnl_data_type_t3ELS3_3ELS3_3ELS3_3EE15execute_forwardERKNS0_10exec_ctx_tEEUliiiiiiE_::_ZZNK4dnnl4impl3cpu21ref_convolution_fwd_tIL16dnnl_data_type_t3ELS3_3ELS3_9
609             for_(dim_t mb = 0; mb < MB; ++mb)

dnnl_verbose,create:cache_miss,cpu,deconvolution,ref:any,backward_weights,src_f32::blocked:acdb:f0 wei_f32::blocked:cdba:f0 bia_undef::undef::f0 dst_f32::blocked:acdb:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.51001
dnnl_verbose,create:cache_miss,cpu,reorder,simple:any,undef,src_f32::blocked:abcd:f0 dst_f32::blocked:acdb:f0,,,2x4x4x4,0.0620117
dnnl_verbose,exec,cpu,reorder,simple:any,undef,src_f32::blocked:abcd:f0 dst_f32::blocked:acdb:f0,,,2x4x4x4,0.119873
dnnl_verbose,create:cache_miss,cpu,reorder,simple:any,undef,src_f32::blocked:abcd:f0 dst_f32::blocked:cdba:f0,,,4x6x3x3,0.0610352
dnnl_verbose,exec,cpu,reorder,simple:any,undef,src_f32::blocked:abcd:f0 dst_f32::blocked:cdba:f0,,,4x6x3x3,0.158936
dnnl_verbose,create:cache_miss,cpu,reorder,simple:any,undef,src_f32::blocked:abcd:f0 dst_f32::blocked:acdb:f0,,,2x6x4x4,0.0610352
dnnl_verbose,exec,cpu,reorder,simple:any,undef,src_f32::blocked:abcd:f0 dst_f32::blocked:acdb:f0,,,2x6x4x4,0.171875

Thread 2 "ve_exec" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ff80bfff000 (LWP 95163)]
0x000060000ba277a0 in dnnl_primitive_attr::_ZZNK4dnnl4impl3cpu21ref_convolution_fwd_tIL16dnnl_data_type_t3ELS3_3ELS3_3ELS3_3EE15execute_forwardERKNS0_10exec_ctx_tEEUlRffE_::_ZZNK4dnnl4impl3cpu21ref_convolution_fwd_tIL16dnnl_data_type_t3ELS3_3ELS3_3ELS3_3EE15execute_forwardERKNS0_10exec_ctx_tEEUliiiiiiE_::_ZZNK4dnnl4impl3cpu21ref_convolution_fwd_tIL16dnnl_data_type_t3ELS3_3ELS3_9
611             for_(dim_t oh = 0; oh < OH; ++oh) (first run)
609             for_(dim_t mb = 0; mb < MB; ++mb) (next run)
#3  0x000060000bbac9b8 in dnnl::impl::parallel<void dnnl::impl::parallel_nd<int, int, dnnl::impl::cpu::ref_convolution_bwd_weights_t<(dnnl_data_type_t)3, (dnnl_data_type_t)3, (dnnl_data_type_t)3, (dnnl_data_type_t)3>::execute_backward_weights(dnnl::impl::exec_ctx_t const&) const::{lambda(int, int)#1}>(int const&, int const&, dnnl::impl::cpu::ref_convolution_bwd_weights_t<(dnnl_9


split ve/ref_convolution.cpp into 3 files. still segfault w/ 
BDIR=build-vejd2; { rm -f install; { make -C $BDIR -j 16 install || make -C $BDIR -j 1 install; } >& x.log  && VE_NODE_NUMBER=2 DNNL_VERBOSE=2 gdb --args $BDIR/tests/benchdnn/benchdnn --mode=C -v8 --conv --dir=FWD_D,BWD_D,BWD_WB --stag=axb --dtag=axb mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1 ; }

Thread 3 "ve_exec" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ff817fff000 (LWP 106117)]
0x000060000c898860 in dnnl_primitive_attr::_ZZNK4dnnl4impl3cpu29ref_convolution_bwd_weights_tIL16dnnl_data_type_t3ELS3_3ELS3_3ELS3_3EE24execute_backward_weightsERKNS0_10exec_ctx_tEEUlRfiiiiiiE_::operator() (this=0x60ffffff9370, d=@0x7ff817ffe7a8: 0, g=0, oc=2, ic=0, kd=0, kh=2, kw=0) at /home/kruus/vanilla-dbg/src/cpu/ve/ref_convolution_bwd_w.cpp:100
100                 int ih = oh * KSH - padT     + kh * KDH; // in [0,IH)

compilation:

[ 27%] Building CXX object src/cpu/CMakeFiles/dnnl_cpu.dir/ve/ref_convolution_bwd_d.cpp.o
cd /home/kruus/vanilla-dbg/build-vejd2/src/cpu && /opt/nec/ve/bin/nc++-3.0.27  -DDNNL_DLL -DDNNL_DLL_EXPORTS -DDNNL_ENABLE_CONCURRENT_EXEC -DDNNL_ENABLE_MAX_CPU_ISA -DDNNL_VE=1 -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -I/home/kruus/vanilla-dbg/include -I/home/kruus/vanilla-dbg/build-vejd2/include -I/home/kruus/vanilla-dbg/src -I/home/kruus/vanilla-dbg/src/cpu  -include stdint.h -minit-stack=zero -Wunknown-pragma -fdiag-inline=2 -fdiag-vector=2 -report-all -O3 -finline -finline-functions -finline-max-function-size=300 -finline-max-depth=10 -finline-max-times=20 -ftemplate-depth=50 -DCBLAS_LAYOUT=CBLAS_ORDER -DDNNL_VALUE_INITIALIZATION_BUG -pthread -std=gnu++14 -fopenmp   -D_SDL_beg -fPIC -D_FORTIFY_SOURCE=0 -D_SDL_end    -O3 -g2 -DNDEBUG -mretain-list-vector   -finline-max-function-size=12288 -o CMakeFiles/dnnl_cpu.dir/ve/ref_convolution_bwd_d.cpp.o -c /home/kruus/vanilla-dbg/src/cpu/ve/ref_convolution_bwd_d.cpp

now compiling with -O0:

cd /home/kruus/vanilla-dbg/build-vejd2/src/cpu && /opt/nec/ve/bin/nc++-3.0.27  -DDNNL_DLL -DDNNL_DLL_EXPORTS -DDNNL_ENABLE_CONCURRENT_EXEC -DDNNL_ENABLE_MAX_CPU_ISA -DDNNL_VE=1 -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -I/home/kruus/vanilla-dbg/include -I/home/kruus/vanilla-dbg/build-vejd2/include -I/home/kruus/vanilla-dbg/src -I/home/kruus/vanilla-dbg/src/cpu  -include stdint.h -minit-stack=zero -Wunknown-pragma -fdiag-inline=2 -fdiag-vector=2 -report-all -O3 -finline -finline-functions -finline-max-function-size=300 -finline-max-depth=10 -finline-max-times=20 -ftemplate-depth=50 -DCBLAS_LAYOUT=CBLAS_ORDER -DDNNL_VALUE_INITIALIZATION_BUG -pthread -std=gnu++14 -fopenmp   -D_SDL_beg -fPIC -D_FORTIFY_SOURCE=0 -D_SDL_end    -O3 -g2 -DNDEBUG -mretain-list-vector   -finline-max-function-size=12288 -o CMakeFiles/dnnl_cpu.dir/ve/ref_convolution_bwd_d.cpp.o -c /home/kruus/vanilla-dbg/src/cpu/ve/ref_convolution_bwd_d.cpp


--------------------------------------------- go back to original bwd_w-orig.ipp implementation
OK for test_convolution_backward_weights_f32
failures for test_deconvolution, but they pass in benchdnn: ex:
--deconv --dir=FWD_D --stag=nhwc --wtag=oihw --dtag=nhwc mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1

Bias is incorrectly set to zero for benchdnn (deconv.in)
--deconv --dir=BWD_WB --stag=nhwc --wtag=oihw --dtag=nhwc ic6ih2oc4oh4kh3ph0
--deconv --dir=BWD_WB --stag=nhwc --wtag=hwio --dtag=nhwc ic6ih4oc4oh4kh3ph1
--deconv --dir=BWD_WB --stag=nhwc --wtag=hwio --dtag=nhwc ic6ih2oc4oh4kh3ph0

OH. was missing a chunk of code in src/cpu/ve/ref_deconvolution.cpp (WIP)

--------------------------------- fixed some test_convolution_backward_f32, retry kdd2.log
tests issues with sum [eltwise]
benchdnn issues:  ldd2.log
segfault: test_binary_all  --binary --sdt=u8:s8 --ddt=u8 3x5x6x9:3x5x6x9 
	test_concat-all 	--concat --ddt=u8 --dtag=any --axis=3 3x4x5x13:3x4x5x17 
	test_conv_functin	--conv --cfg=u8s8s8 --alg=auto ic3ih300oc64oh300kh3ph1n"ssd_300_voc0712:conv1_1"
				benchdnn -v1 --engine=cpu --conv --batch=inputs/conv/test_conv_function
				test_benchdnn_conv_function_cpu
	test_benchdnn_matmul_cpu	--matmul --cfg=u8s8u8 --stag=ab --wtag=ab --attr="oscale=common:2.25*;" m1n1k1
	test_benchdnn_pool_cpu		--pool --dir=FWD_I --cfg=u8 --tag=axb ic64iw32ow16kw3sw2pw0
	test_reorder_all	 --reorder --sdt=f32 --ddt=u8 --stag=abx --dtag=abx --attr="oscale=per_dim_1:0.125;" 2x64x3x3 
	test_shuffle_all	benchdnn -v1 --engine=cpu --shuffle --batch=inputs/shuffle/test_shuffle_all
				--shuffle --dt=u8 --group=4 1x12x56x56
S=vejd2 B=build-$S I=install-$S; { rm -f $I; { make -C $B -j 16 install || make -C $B -j 1 install; } >& x.log  && VE_NODE_NUMBER=2 DNNL_VERBOSE=2 gdb --args $B/tests/benchdnn/benchdnn --mode=C -v8 --conv --dir=FWD_D,BWD_D,BWD_WB --stag=axb --dtag=axb mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1 ; }
S=vejd2 B=build-$S I=install-$S; { rm -f $I; { make -C $B -j 16 install || make -C $B -j 1 install; } >& x.log  && ./vetest.sh -B $B -N 0 -L f.log --benchdnn -v8 --mode=C --conv --dir=BWD_WB --stag=abx --dtag=abx mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1 ; } >&y.log && echo YAY || echo OHOH
S=vejd2 B=build-$S I=install-$S; { rm -f $I; { make -C $B -j 16 install || make -C $B -j 1 install; } >& x.log  && ./vetest.sh -B $B -N 0 -L f.log -T test_sum; } >&y.log && echo YAY || echo OHOH
--------------------------------- turn off fast reorder compile option in src/cpu/CMakeLists.txt
fix up issues after removing partial-build support...
./build.sh -addTttttt >& ldd.log
./build.sh -N 2 -vdqqTttttt >&      # 1st time had a veos? error, claiming !BUILD_OK, but rerun seems OK.

Good news: at RelWithDebInfo compile, ./build.sh -ad, eltwise vector results are OK.
 (but limit cases +/-inf,nan,+/-0 descrepancies for ./build.sh -add)
