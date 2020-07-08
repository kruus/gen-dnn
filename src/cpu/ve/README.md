=== General VE characteristics (nc++-3.0.27)

lambda function overhead fairly noticable. Lambdas not inlined, while
true func calls can be inlined.

conditions inside loops can create problems / slowdowns,
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

batch_normalization stuff is 10x to 200x faster (avg 38x speedup on benchdnn)
bnorm WIP (need to consider how to handle mdw::off_v_vec "officially")
	lrn did this, so possibly more speedups for bnorm
	TODO: int8 on VE (for workspace) is unvectorizable. Is bitmap vectorized?
	caveat - std::vector<bool> has weak threading guarantees.
bnorm still not "fast", but maybe the 3 hr benchdnn test is largely due to the "reorders"
	work around ccom compiler error by explicityly adding -mno-vector-intrinsic-check (just in case)

eltwise_generic might also need 'off_l_vec' optimization
	ve version begun, not optimized (needs work)
	for vectorization, move 'switch' cases out of loop.
		fwd speedups O(250)x for large tensors

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

rnn ??

pooling	already started with VE bugfixes, no optimization yet: off_v_vec optimizations possible

simple_reorder wants at least the v0.16 ShortLoop() pragmas reinstated
	and reorder(any,any,any) using off_l reorder should use 'off_l_vec'
	- actually this is an interesting case of how to introduce batching into
	  a parallel_nd construct

ref_deconvolution
	switching to vectorized offset calcs (WIP)

### cblas (build.sh -C)
FindBLAS is no longer working.  hardwired USE_CBLAS and directories using cmake/ve.cmake toolchain variables.
Changed to blas_openmp instead of \_sequential version.  Introduces msan_unpoison_matrix assertion failure:
enchdnn: /home/kruus/vanilla-dbg/src/cpu/gemm/gemm_msan_unpoison.hpp:26: void dnnl::impl::cpu::msan_unpoison_matrix(void *, long, long, long, unsigned long): Assertion `C != nullptr && M > 0 && N > 0 && LDC >= M && typesize' failed. 

### sample tests

default benchdnn tests :

[aurora-ds08 vanilla-dbg]$ { { make -C build-ve -j 16 install || make -C build-ve -j 1 install; } && ./vetest.sh -B build-ve -L ve-bench-elt.log -t 8 -v -T test_benchdnn_eltwise; } >& ve-elt.log && echo YAY || echo OHOH

test_benchdnn_eltwise in --mode=P :

[aurora-ds08 vanilla-dbg]$ { { make -C build-ve -j 16 install || make -C build-ve -j 1 install; } && (cd /home/kruus/vanilla-dbg/build-ve/tests/benchdnn && /usr/bin/env DNNL_VERBOSE=1 VE_PROGINF=DETAIL DNNL_VERBOSE=0 OMP_NUM_THREADS=8 VE_OMP_NUM_THREADS=8 VE_NODE_NUMBER=2 /home/kruus/vanilla-dbg/build-ve/tests/benchdnn/benchdnn -v1 --engine=cpu --mode=P --eltwise --batch=inputs/eltwise/test_eltwise_all); } >& ve-bench-eltP.log && echo YAY || echo OHOH

debug a single test case :

[aurora-ds08 vanilla-dbg]$ { { make -C build-ve -j 16 install || make -C build-ve -j 1 install; } && ./vetest.sh -B build-ve -v -L f.log --benchdnn --mode=C --eltwise --dir=FWD_D --alg=exp_dst alpha=0 beta=0 44x88x33x3; } >& ve-elt.log && echo YAY || echo OHOH

### Errors

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

##### new gtest bugs (from ve mods)

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

Tests 2,3,4,5,6 fail (wrong result)
```
[  FAILED  ] SimpleSmall_NCHW_CPU/deconvolution_test_float.TestDeconvolution/2
```
or benchdnn test_deconv_all, at beginnning of test.

test_conv_regression segfault w/ benchdnn: `--conv --cfg=f32_full mb1ic16ih1oc16oh1kh3ph0`

