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
    echo " Example:   ./regr.sh FWD 6    # FWD 6 threads"
    echo "            # output to FWD-t6-<hostname>.log"
    echo ""
    #./bench.sh -h
    #exit 0
}
case $DIRN in
    FWD*) # mostly FWD_B and some with --merge=RELU
        BATCH="inputs/test_fwd_regression"
        DIRN='FWD'
        ;;
    BWD_D) # backward data
        BATCH="inputs/test_bwd_d_regression"
        ;;
    BWD_W*) # backward weights (runs BWD_WB tests)
        BATCH="inputs/test_bwd_w_regression"
        ;;
    ALL) # test_conv_regression mix
        BATCH="inputs/test_conv_regression"
        ;;
    ALEX*) # alexnet (mix)
        BATCH="--dir=FWD_B --batch=inputs/conv_alexnet --dir=BWD_D --batch=inputs/conv_alexnet --dir=BWD_WB --batch=inputs/conv_alexnet"
    h | *) # help
        usage
        exit
        ;;
esac
# Alexnet: better to run as
# (cd build && make && cd tests/benchdnn && OMP_NUM_THREADS=6 ./benchdnn --mode=PT --dir=FWD_B --batch=inputs/conv_alexnet) 2>&1 | tee alex-fwd.log
# etc. to control which direction
echo "BATCH   : $BATCH"
if [ "$BATCH" = "" ]; then
    usage
    exit
fi
# if batch is a file, prepend --batch=
if [ -f "./tests/benchdnn/${BATCH}" ]; then
    BATCH="--batch=${BATCH}"
fi
if [ "$THREADS" ]; then
    if [ ! "$THREADS" -ge 0 ]; then
        usage
        exit
    fi
fi
BUILDDIR=build
#(cd build && make && cd tests/benchdnn && /usr/bin/time -v ./benchdnn --mode=PT --batch=inputs/test_fwd_regression) 2>&1 | tee PT.log
HOSTNAME=`hostname --short`
LOGFILE="${DIRN}-${HOSTNAME}.log"
if [ ! "$THREADS" = "" ]; then LOGFILE="${DIRN}-t${THREADS}-${HOSTNAME}.log"; fi
echo "LOGFILE : $LOGFILE"
(
{
    cd "$BUILDDIR" && make && cp -uarv ../tests/benchdnn/inputs/* ./tests/benchdnn/inputs/ && \
        { 
            if [ "$THREADS" = "" ]; then unset OMP_NUM_THREADS;
            else THREADS="OMP_NUM_THREADS=$THREADS"; fi
            echo "THREADS  : $THREADS"
            echo "cmd      : $THREADS /usr/bin/time -v ./benchdnn --mode=PT $BATCH"
            cd tests/benchdnn;
            ls -l inputs;
            eval $THREADS /usr/bin/time -v ./benchdnn --mode=PT $BATCH
        }
    } || { echo "Problems?"; false; }
    ) >& "$LOGFILE" \
        && { echo 'regr.sh OK'; tail -n40 $LOGFILE | awk '/final stats/{f=1} /kbytes/{f=0} f==1{print $0;}'; } \
        || { echo "regr.sh FAIL"; tail -n80 $LOGFILE; echo "See LOGFILE = $LOGFILE"; }
# vim: set ts=4 sw=4 et :
