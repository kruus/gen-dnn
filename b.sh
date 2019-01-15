#!/bin/bash
cd build-vej/tests/benchdnn || pwd
make >& ../../../b.log && echo BUILT
if false; then
	LOG=small
	TEST=conv_regression_small_spatial
	BATCH="--batch=inputs/$TEST"
	# libvednn impls:
	# --mode=C correctness fails during ref calc for BWD_D, libvednn call executes fine.
	#      (sometimes even segfault during BWD ref calc)
	OMP_NUM_THREADS=1 ve_exec ./benchdnn --mode=P --cfg=f32 --verbose=5 \
		-v5 --dir=BWD_D $BATCH \
		--reset -v5 --dir=BWD_W $BATCH \
		--reset -v5 --dir=FWD_D $BATCH \
	2>&1 | tee ../../../$LOG.log && echo YAY - see $LOG.log || echo OHOH - see $LOG.log
fi
if true; then
	LOG=vgg
	TEST=conv_vgg_19
	BATCH="--verbose=1 --mb=1 --batch=inputs/$TEST"
	THREADS=1
	# libvednn impls:
	# --mode=C correctness fails during ref calc for BWD_D, libvednn call executes fine.
	#      (sometimes even segfault during BWD ref calc)
	OMP_NUM_THREADS=$THREADS ve_exec ./benchdnn --mode=P --cfg=f32 \
		--reset --dir=FWD_D $BATCH \
		--reset --dir=FWD_I $BATCH \
		--reset --dir=BWD_D $BATCH \
		--reset --dir=BWD_W $BATCH \
		--reset --dir=BWD_WB $BATCH \
	2>&1 | tee ../../../$LOG.log && echo YAY - see $LOG.log || echo OHOH - see $LOG.log
fi
