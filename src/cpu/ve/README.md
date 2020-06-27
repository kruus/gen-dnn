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
bnorm still not "fast".

eltwise_generic might also need 'off_l_vec' optimization
	ve version begun, not optimized (needs work)

simple_sum should begin by following v0.16 version
	did some further optimizations.  still slow cf. x64, I think

simple_concat 
	some work on ve version, based on v0.16 impl (needs work)

rnn ??

pooling	already started with VE bugfixes, no optimization yet: off_v_vec optimizations possible

simple_reorder wants at least the v0.16 ShortLoop() pragmas reinstated
	and reorder(any,any,any) using off_l reorder should use 'off_l_vec'
	- actually this is an interesting case of how to introduce batching into
	  a parallel_nd construct
