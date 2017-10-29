#!/bin/bash
# Usage:
#  regr.sh {FWD*|BWD_D|BWD_W*} ...other bench.sh args
#
ORIGINAL_CMD="$0 $*"
DIRN=$1; shift
THREADS=$1; shift
echo "DIRN    : $DIRN"
echo "THREADS : $THREADS"
BATCH=""
usage() {
    echo "$0 usage:"
    echo " regr.sh {FWD*|BWD_D|BWD_W*} [threads]"
    #head -n 30 "$0" | grep "^[^#]*.)\ #"
    awk '/getopts/{flag=1;next} /done/{flag=0} flag&&/^[^#]+\) #/; flag&&/^ *# /' $0
    echo ""
    #./bench.sh -h
    #exit 0
}
case $DIRN in
	FWD*) # mostly FWD_B and some with --merge=RELU
		BATCH="inputs/test_fwd_regression"
		;;
	BWD_D) # backward data
		BATCH="inputs/test_bwd_d_regression"
		;;
	BWD_W*) # backward weights (runs BWD_WB tests)
		BATCH="inputs/test_bwd_w_regression"
		;;
	h | *) # help
		usage
		;;
esac
echo "BATCH   : $BATCH"
if [ "$BATCH" = "" ]; then
	usage
	exit
fi
BUILDDIR=build
#(cd build && make && cd tests/benchdnn && /usr/bin/time -v ./benchdnn --mode=PT --batch=inputs/test_fwd_regression) 2>&1 | tee PT.log
LOGFILE="$DIRN.log"
echo "LOGFILE : $LOGFILE"
(
cd "$BUILDDIR" && make && cp -uarv tests/benchdnn/inputs/* "$BUILDDIR"/tests/benchdnn/inputs/ ;
if [ "$THREADS" = "" ]; then unset OMP_NUM_THREADS;
else THREADS="OMP_NUM_THREADS=$THREADS"; fi
echo "THREADS  : $THREADS"
echo "cmd      : $THREADS /usr/bin/time -v ./benchdnn --mode=PT --batch=$BATCH"
cd tests/benchdnn;
ls -l inputs;
eval $THREADS /usr/bin/time -v ./benchdnn --mode=PT --batch=$BATCH
) >& "$LOGFILE" && { \
	echo YAY; \
	tail -n40 "$LOGFILE"; \
} || { echo "ohoh"; tail -n40 $LOGFILE; }

