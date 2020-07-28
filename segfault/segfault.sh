#!/bin/bash
# VE seems to have some issue with u8/s8 operations.  On VE, 1- and 2-byte quantities
# have no vector support, so code should be scalar.
cd "$(dirname -- "${BASH_SOURCE[0]}")"
B=../build-ved
N=2
../vetest.sh -B $B -N $N -L sum.log  --benchdnn -v8 --sum --batch=sum.in || echo OHOH
../vetest.sh -B $B -N $N -L shf.log  --benchdnn -v8 --shuffle --batch=shf.in || echo OHOH
../vetest.sh -B $B -N $N -L cat.log  --benchdnn -v8 --concat --batch=cat.in || echo OHOH
../vetest.sh -B $B -N $N -L bin.log  --benchdnn -v8 --binary --batch=bin.in || echo OHOH
../vetest.sh -B $B -N $N -L pool.log --benchdnn -v8 --pool --batch=pool.in || echo OHOH
../vetest.sh -B $B -N $N -L cnv.log  --benchdnn -v8 --conv --batch=cnv.in || echo OHOH
../vetest.sh -B $B -N $N -L rnn.log  --benchdnn -v8 --rnn --batch=rnn.in || echo OHOH
../vetest.sh -B $B -N $N -L mm.log   --benchdnn -v8 --batch=mm.in || echo OHOH
cat sum.log shf.log cat.log bin.log pool.log cnv.log rnn.log mm.log > segfault.log
rm -f sum.log shf.log cat.log bin.log pool.log cnv.log rnn.log mm.log
