#!/bin/bash
# vim: sw=2 ts=2 et
S=ved
B=build-$S
I=install-$S
NODE=0
if [ ! -d "$B" ]; then
  echo -n "no $B directory?"
else
  echo "directory = `pwd`"
  echo "remake --> x.log"
  rm -rf $I
  { time make -C $B -j 16 install; } >& x.log \
    && echo "vetest correctness --> conv.log" \
    && { echo ./vetest.sh -B $B -N $NODE -L conv.log -vvv --benchdnn --mode=C -v20 --conv --batch=conv.in; } >&y.log \
    && { time ./vetest.sh -B $B -N $NODE -L conv.log -vvv --benchdnn --mode=C -v20 --conv --batch=conv.in; } >> y.log 2>&1 \
    && tests=`grep '^tests:' conv.log` \
    && echo "$tests" \
    && echo "vetest peformance --> convP.log" \
    && { echo ./vetest.sh -B $B -N $NODE -L convP.log -v --benchdnn --mode=P -v5 --conv --batch=conv.in; } >> y.log 2>&1 \
    && { time ./vetest.sh -B $B -N $NODE -L convP.log -v --benchdnn --mode=P -v5 --conv --batch=conv.in; } >> y.log 2>&1 \
    && summary=`grep '^perf' convP.log | cut -d, -f9 | tr '\n' ' '` \
    && echo "$summary" \
    && { echo "$tests"; echo "$summary"; } >> convP.log
fi
