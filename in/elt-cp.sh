#!/bin/bash
S=ved
B=build-$S
I=install-$S
NODE=2
#BATCH=in/elt-dense.in
#BATCH=in/elt-generic.in
#BATCH=in/elt-nCsp8c.in
BATCH=in/elt.in # all 3
# NOTE nCsp8c impl removed for VE (generic is faster)
rm -rf $I
{ echo -n "Build..."; make -C $B -j 16 install >& x.log &&
	echo -n "Correctness..." && 
{ time { ./vetest.sh -B $B -N ${NODE} -L elt.log -vv --benchdnn -v8 --mode=C --eltwise --batch=${BATCH} >&y.log; } } &&
	echo -n "Performance..." && 
{ time { ./vetest.sh -B $B -N ${NODE} -L eltP.log -v --benchdnn -v8 --mode=P --eltwise --batch=${BATCH} >&y.log; } }
} && echo YAY || echo OHOH
