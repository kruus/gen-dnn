=== General VE characteristics (nc++-3.0.27)

lambda function overhead fairly noticable. Lambdas not inlined, while
true func calls can be inlined.

Sometimes VE_OMP_NUM_THREADS>1 VE_PROGINFO=DETAIL runs hang during exit
stats printout.

Depending sensitively on compile options, zero, underlow and overflow results
like +/-NaN and +/-inf for vectorized math functions may not agree with scalar
(or IEEE) results.  Usually the scalar functions conform to standards.

Conditions inside loops can create problems / slowdowns,
even if compile-time const.

arrange inner loops to have high vector length.

use memory_desc_wrapper_opt to vectorize func calls to physical offset calcs.

vectorization often disallowed for runtime-dim stack array temporaries, but
can allocate "max size" array[constexpr] as workaround.

need to verify vectorization in .LL diagnostics output

<B>NOT</B> yet hooked up to libvednn (the big speed win in old v0.16) in v1.4-alpha

CE should avoid int8 layers, only supporting vectorization of 4-, 8- or 16-byte types.

merge with dev/reo branch WIP

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
	work around ccom compiler error by explicitly adding -mno-vector-intrinsic-check (just in case)

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
	did some further optimizations.  still slow cf. x64, I think.
	Later improvements to VE reorder (below) should help greatly.

simple_concat 
	some work on ve version, based on v0.16 impl (needs work)
	main mod is to introduce memcpy_wrap<T>, which avoids fn call for types T
	which nc++ is able to efficiently vectorize.  bf16 now also allowed for
	simple_concat because it is size 2 and memcpyable.  VE has no vectorization
        support for 1- or 2-byte types,so revert to memcpy in those cases.
	ve-banch-catP.log: Av VL 102, Vec% only 11$
	(is this the scalar reorders, or perhaps small benchdnn problem sizes?)

rnn ?? still rather slow.  Have not looked at it.

pooling	already started with VE bugfixes, no optimization yet: off\_v\_vec optimizations possible

simple\_reorder wants at least the v0.16 ShortLoop() pragmas reinstated
	and reorder(any,any,any) using off\_l reorder should use 'off\_l\_vec'
	- actually this is an interesting case of how to introduce batching into
	  a parallel\_nd construct
	Split apart the 45-minute compile of cpu\_reorder (nc++ stuck in ipa, which eventually stops)
	by putting reorder map values `std::vector<rpd_create_f>` into separate small files.
	BUT, split apart compiler ipa is not stopped, and segfaults happen.
	SAFEST is to do the forever-compile, which stops ipa, and avoids the split-induced segfaults.
	- reorder impls now print which template produced them.
        - tackle very slow f32-->s32,u8,s8 reorders  (VE has no vector support for u8,s8 types)
	- ref and direct reorders now may use nc++ extended asm
	  - reduce bad loop overheads by making asm sections larger
            - sometimes compiler ICE if have too many separate asm sections.
            - asm in functions prevents inlining, so also better to move required asm
              sections to higher-level code to prevent serious fn call impact.
          - begin vectorizing quantization, saturation and rounding routines (new header)
            - now also sommetimes w/ extended asm for large speedups.
	- benchdnn tests extensively excercise reorders, so this reduces full build-test
          cycle from original 5-6 hours quit a bit.
    - have not looked at optimizing rnn reorders (many 8-bit tests involved, so likely slow on VE)

ref_deconvolution
	switching to vectorized offset calcs (WIP)
	convolution segfaults dealt with. Compilation correctness for im2col/col2im worked around.
	Hardest was compile bug for backward weights, where hoisting conditionals always resulted
	in some [rare] segfaults.
	TODO: vectorize offset calcs
	TODO: im2col and col2im unrollings (a la v0.16)

### cblas (build.sh -C)
- FindBLAS.cmake has stopped working
  - hardwired USE_CBLAS and directories using cmake/ve.cmake toolchain variables.
Changed to blas_openmp instead of \_sequential version.  Introduces msan_unpoison_matrix assertion failure
```
benchdnn: /home/kruus/vanilla-dbg/src/cpu/gemm/gemm_msan_unpoison.hpp:26: void dnnl::impl::cpu::msan_unpoison_matrix(void *, long, long, long, unsigned long): Assertion `C != nullptr && M > 0 && N > 0 && LDC >= M && typesize' failed. 
```
Also now see segfault in deconv (below) ...
Reverted to blas_sequential (VE_SEQ=1 default setting)
(Generally, OneDNN assumes it is responsible for threading decisions).

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

- very lengthy logic expressions miscompiled
  - replace with consisitency.hpp : short-circuited consistency checking, with optional
    verbose "failure reason" printout.

- 'if's inside 'parallel' sometimes compiled badly, or even incorrectly.
  - nc++ prefers to move conditionals outside parallel sections.
  - sometimes even if technically the conditions are purely compile-time.

- some miscompilations related to template inlining decisions in compiler
  - some headers need different template instantiation settings
  - perhaps issues when compiler aborts and inlining decision "mid-stream"?

- split of reorder code (reduce 45 minute reorder compile, that eventually
  aborts ipa compiler phase, "too many functions")
  - initial version had library statics "initialization order fiasco" that
    led rarely to empty reorder lists and eventual segfaults.
  - switch to function level statics to contruct objects in desired order

- limiting +/-0, +/-inf, and NaN fixups in eltwise <B>won't</B> be supported much.
  - they worked perfectly once, but small changes in compile options can
    completely change behavior
    - testing for limit cases explicitly slows down code.
    - which limit cases fail depend very sensitively on compile options

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

