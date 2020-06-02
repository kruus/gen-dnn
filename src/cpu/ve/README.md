batch_normalization stuff is 10x to 200x faster (avg 38x speedup on benchdnn)

bnorm WIP (need to consider how to handle mdw::off_v_vec "officially"

softmax v1.4 version already done, better than v0.16 version

lrn 	yanking v0.16 optimizations into this version (pretty similar, v1.4 just adds ncdhw possibility
	not using off_v_vec yet, mostly just taking ifs out of loops to allow vectorization.
	also force vectorization across channels, and not the kernel width (typical only 5).

eltwise_generic also need 'off_l_vec' optimization

simple_sum should begin by following v0.16 version

simple_concat is v0.16 shortloop_reduction correct?

rnn ??

pooling	already started with VE bugfixes, no optimization yet: off_v_vec optimizations look pertinent

simple_reorder wants at least the v0.16 ShortLoop() pragmas reinstated
	and reorder(any,any,any) using off_l reorder should use 'off_l_vec'
	- actually this is an interesting case of how to introduce batching into
	  a parallel_nd construct
