#!/bin/bash
S=ved
B=build-$S
I=install-$S
NODE=2
BATCH=in/elt-dense.in
rm -rf $I
{ echo -n "Build..."; make -C $B -j 16 install >& x.log &&
	echo -n "Correctness..." && 
{ time { ./vetest.sh -B $B -N ${NODE} -L elt.log -vv --benchdnn -v8 --mode=C --eltwise --batch=${BATCH} >&y.log; } }
2>&1 | head -n1 | sed "s/\\n/ /" &&
	echo -n "Performance..." && 
{ time { ./vetest.sh -B $B -N ${NODE} -L eltP.log -v --benchdnn -v8 --mode=P --eltwise --batch=${BATCH} >&y.log; } }
2>&1 | head -n1 | sed "s/\\n/ /"
} && echo YAY || echo OHOH
