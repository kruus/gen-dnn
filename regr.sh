#!/bin/bash
# Usage:
#  regr.sh {FWD*|BWD_D|BWD_W*} ...other bench.sh args
#
ORIGINAL_CMD="$0 $*"
usage() {
    echo " command: $ORIGINAL_CMD"
    echo "$0 usage:"
    echo " regr.sh [threads] {[<benchdnn_arg>|<batch_file>|FWD*|BWD_D|BWD_W*|ALEX|MINI] ...}"
    #head -n 30 "$0" | grep "^[^#]*.)\ #"
    awk '/getopts/{flag=1;next} /done/{flag=0} flag&&/^[^#]+\) #/; flag&&/^ *# /' $0
    echo " Substitutions:"
    echo "   FWD|BWD_D|BWD_W* --> test_fwd_regrssion, ..."
    echo "   ALL              --> shortish regression tests (all dirns)"
    echo "   ALEX             --> a series of alexnet tests (all dirns)"
    echo "   <file> found?    --> copy to build dir and use --batch=<file>"
    echo " Examples: ./regr.sh 6 FWD  # FWD 6 threads     to FWD-t6-<host>.log"
    echo "   ./regr.sh FWD            # FWD, default threads to FWD-<host>.log"
    echo "   ./regr.sh 6 --dir=BWD_WB conv_alexnet   # 6 thread BWD_WB alexnet"
    echo "   ./regr.sh 6 --dir=BWD_W conv_regression_group  # fast bug-hunting"
    #./bench.sh -h
    #exit 0
}
THREADS="$1"
re_nonneg='^[0-9]+$'                      # reg expr for zero or positive int
if ! [[ "$THREADS" =~ $re_nonneg ]]; then # non-digits? no threads argument
    THREADS=""
else
    shift                                 # gobble the threads arg
fi
if [ "$#" -lt 1 ]; then usage; exit; fi
ARGS=($*)
BASE=''
batch_check() {
    BATCH="$1"
    # if batch is a file, copy to build dir and prepend --batch=
    for DIR in ./tests/benchdnn ./tests/benchdnn/inputs .; do
        #echo "file? ${DIR}/${BATCH}"
        if [ -f "${DIR}/${BATCH}" ]; then
            cp -uav "${DIR}/${BATCH}" "./build/tests/benchdnn/inputs/${BATCH}"
            BATCH="--batch=inputs/${1}"
            return
        fi
    done
    echo "Not-a-file: ${BATCH}"
}
nopt=0
for ((i=0; i<${#ARGS[*]}; ++i)); do
    #echo "$i : ${ARGS[i]}"
    xform="${ARGS[i]}"
    chkfile=0
    case $xform in
        FWD|FWD_B|FWD_D) # mostly FWD_B and some with --merge=RELU
            BASE="FWD"; xform="test_fwd_regression"; chkfile=1; ((++nopt))
            ;;
        BWD_D) # backward data
            BASE="BWD_D;" xform="test_bwd_d_regression"; chkfile=1; ((++nopt))
            ;;
        BWD_W*) # backward weights (runs BWD_WB tests)
            BASE="BWD_W"; xform="test_bwd_w_regression"; chkfile=1; ((++nopt))
            ;;
        ALL) # test_conv_regression mix
            BASE="${xform}"; xform="test_conv_regression"; chkfile=1; ((++nopt))
            ;;
        ALEX|ALEXNET) # alexnet (mix)
            BASE="ALEX";
            xform="--dir=FWD_B --batch=inputs/conv_alexnet --dir=BWD_D --batch=inputs/conv_alexnet --dir=BWD_WB --batch=inputs/conv_alexnet"
            ((++nopt))
            ;;
        MINI) # low-minibatch alexnet
            BASE="MINIALEX";
            xform="--dir=FWD_B --batch=inputs/minialex --dir=BWD_D --batch=inputs/minialex --dir=BWD_WB --batch=inputs/minialex"
            ((++nopt))
            ;;
        h) # help
            usage
            exit
            ;;
        *) # other? arbitrary benchdnn args or test files ...
            chkfile=1
            ((++nopt))
            ;;
    esac
    #echo "xform1 = ${xform}"

    if [ $chkfile -ne 0 ]; then # search for batch file args, copying into build dir
        batch_check "${xform}"
        xform="${BATCH}"
    fi
    #echo "xform2 = ${xform}"

    ARGS[$i]="${xform}"
done
if [ -z "${BASE}" -o $nopt -gt 1 ]; then BASE='x'; fi
echo "THREADS': ${THREADS}"
echo "BASE    : ${BASE}"
echo "ARGS    : ${ARGS[@]}"
echo "nopt    : $nopt"
#for ((i=0; i<${#ARGS[*]}; ++i)); do
#    echo "$i : ${ARGS[i]}"
#done
# Alexnet: better to run as
# (cd build && make && cd tests/benchdnn && OMP_NUM_THREADS=6 ./benchdnn --mode=PT --dir=FWD_B --batch=inputs/conv_alexnet) 2>&1 | tee alex-fwd.log
# etc. to control which direction

# zero in on a particular failure (by hand):
# (cd build && make && cd tests/benchdnn && OMP_NUM_THREADS=6 ./benchdnn --mode=PT --dir=BWD_W --batch=inputs/conv_regression_group) >& x.log && { echo 'OK'; tail -n40 x.log | awk '/final stats/{f=1} /kbytes/{f=0} f==1{print $0;}'; } || { echo 'FAIL'; tail -n80 x.log; echo 'See x.log'; }
#
BUILDDIR=build
#(cd build && make && cd tests/benchdnn && /usr/bin/time -v ./benchdnn --mode=PT --batch=inputs/test_fwd_regression) 2>&1 | tee PT.log
HOSTNAME=`hostname --short`
LOGFILE="${BASE}-${HOSTNAME}.log"
if [ ! "$THREADS" = "" ]; then LOGFILE="${BASE}-t${THREADS}-${HOSTNAME}.log"; fi
echo "LOGFILE : $LOGFILE"
(
{
    cd "$BUILDDIR" && make && cp -uarv ../tests/benchdnn/inputs/* ./tests/benchdnn/inputs/ && \
        { 
            if [ "$THREADS" = "" ]; then unset OMP_NUM_THREADS;
            else THREADS="OMP_NUM_THREADS=$THREADS"; fi
            echo "THREADS  : $THREADS"
            echo "cmd      : $THREADS /usr/bin/time -v ./benchdnn --mode=PT ${ARGS[@]}"
            cd tests/benchdnn;
            #ls -l inputs;
            echo " `pwd` inputs:"
            (cd inputs && ls -1) | awk '//{p=p " " $0;++n} n>=4{print p; p=""; n=0} END{print p}' | column -t
            eval $THREADS /usr/bin/time -v ./benchdnn --mode=PT ${ARGS[@]}
        }
    } || { echo "Problems?"; false; }
    ) >& "$LOGFILE" \
        && { echo 'regr.sh OK'; tail -n40 $LOGFILE | awk '/final stats/{f=1} /kbytes/{f=0} f==1{print $0;}'; } \
        || { echo "regr.sh FAIL"; tail -n40 $LOGFILE | awk 'BEGIN{f=1} /kbytes/{f=0} f==1{print $0}'; echo "See LOGFILE = $LOGFILE"; }
# vim: set ts=4 sw=4 et :
