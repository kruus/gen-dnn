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
COPY="cp -uav"
if [ "`uname -m`" = "SX-ACE" ]; then COPY="cp -a"; fi
echo "COPY    : $COPY"
BUILDDIR=build
if [ "`uname -m`" = "SX-ACE" ]; then BUILDDIR=build-sx; fi
echo "BUILDDIR: $BUILDDIR"
batch_check() {
    BATCH="$1"
    # if batch is a file, copy to build dir and prepend --batch=
    for DIR in ./tests/benchdnn ./tests/benchdnn/inputs .; do
        #echo "file? ${DIR}/${BATCH}"
        if [ -f "${DIR}/${BATCH}" ]; then
            ${COPY} "${DIR}/${BATCH}" "./${BUILDDIR}/tests/benchdnn/inputs/${BATCH}"
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
            BASE="BWD_D"; xform="test_bwd_d_regression"; chkfile=1; ((++nopt))
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
        A1) # alexnet conv1, mb=8
            BASE="A1";
            xform='g1mb8ic3ih227oc96oh55kh11sh4ph0n"mini:conv1"';
            if [ "`uname -m`" = "SX-ACE" ]; then
                xform='g1mb8ic3ih60oc32oh25kh11sh4ph0n"minisx:conv1"';
            fi;
            ((++nopt))
            ;;
        A3) # alexnet conv3, mb=8
            BASE="A3";
            xform='g1mb8ic256ih13oc384oh13kh3ph1n"mini:conv3"'
            if [ "`uname -m`" = "SX-ACE" ]; then
                xform='g1mb8ic32ih13oc48oh13kh3ph1n"minisx:conv3"'
            fi;
            ((++nopt))
            ;;
        MINI) # low-minibatch alexnet
            BASE="MINIALEX";
            xform="--dir=FWD_B --batch=inputs/minialex --dir=BWD_D --batch=inputs/minialex --dir=BWD_WB --batch=inputs/minialex"
            ((++nopt))
            ;;
        h|-h|--help) # help
            usage
            exit
            ;;
        n*|-n*) # base name for logfile; ex. -nFOO (no space)
            s="${xform#-}"; s="${s#n}"
            if [ "$s" != "" ]; then BASE="$s"; xform=''; fi
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
if [ "${BASE}" == "" ]; then BASE='x'; fi
echo "THREADS': ${THREADS}"
echo "BASE    : ${BASE}"
echo "ARGS    : ${ARGS[@]}"
echo "nopt    : $nopt"
#for ((i=0; i<${#ARGS[*]}; ++i)); do
#    echo "$i : ${ARGS[i]}"
#done
# Alexnet: better to run as
# (cd "${BUILDDIR}" && make && cd tests/benchdnn && OMP_NUM_THREADS=6 ./benchdnn --mode=PT --dir=FWD_B --batch=inputs/conv_alexnet) 2>&1 | tee alex-fwd.log
# etc. to control which direction

# zero in on a particular failure (by hand):
# (cd "${BUILDDIR}" && make && cd tests/benchdnn && OMP_NUM_THREADS=6 ./benchdnn --mode=PT --dir=BWD_W --batch=inputs/conv_regression_group) >& x.log && { echo 'OK'; tail -n40 x.log | awk '/final stats/{f=1} /kbytes/{f=0} f==1{print $0;}'; } || { echo 'FAIL'; tail -n80 x.log; echo 'See x.log'; }
#
#(cd "${BUILDDIR}" && make && cd tests/benchdnn && /usr/bin/time -v ./benchdnn --mode=PT --batch=inputs/test_fwd_regression) 2>&1 | tee PT.log
HOSTNAME=`hostname -s` # SX-ACCE does not support --short
if [ "`uname -m`" = "SX-ACE" ]; then HOSTNAME='sx'; fi # I could not put spaces here, for SX-ACE (so no awk/sed)
LOGFILE="${BASE}-${HOSTNAME}.log"
if [ ! "$THREADS" = "" ]; then LOGFILE="${BASE}-t${THREADS}-${HOSTNAME}.log"; fi
echo "LOGFILE : $LOGFILE"
COLUMN="column -t"
if [ "`uname -m`" = "SX-ACE" ]; then COLUMN='cat'; fi # I could not put spaces here, for SX-ACE (so no awk/sed)
echo "COLUMN  : $COLUMN"
TIME="/usr/bin/time -v"
if [ "`uname -m`" = "SX-ACE" ]; then TIME="time"; fi # just use the bash builtin
set +x
(
{
    cd "$BUILDDIR" && { if [ ! "`uname -m`" = "SX-ACE" ]; then make; fi; } \
    && $COPY -r ../tests/benchdnn/inputs/* ./tests/benchdnn/inputs/ && \
        { 
            if [ "$THREADS" = "" ]; then unset OMP_NUM_THREADS;
            else THREADS="OMP_NUM_THREADS=$THREADS"; fi
            echo "THREADS  : $THREADS"
            echo "cmd      : $THREADS /usr/bin/time -v ./benchdnn --mode=PT ${ARGS[@]}"
            cd tests/benchdnn;
pwd
ls -l .
            #ls -l inputs;
            echo " `pwd` inputs:"
set +x
echo "COLUMN ... $COLUMN"
            (cd inputs && ls -1) | awk '//{p=p " " $0;++n} n>=4{print p; p=""; n=0} END{print p}' | ${COLUMN}
            eval $THREADS ${TIME} C_PROGINF=DETAIL ./benchdnn --mode=PT ${ARGS[@]}
        }
    } || { echo "Problems?"; false; }
    ) >& "$LOGFILE" \
        && { echo 'regr.sh OK'; tail -60 $LOGFILE | awk '/final stats/{f=1} /kbytes/ || /Sys  Time/{f=0} f==1{print $0; next} /MFLOPS/ || /Concurr/ || /Ratio/'; } \
        || { echo "regr.sh FAIL"; tail -60 $LOGFILE | awk 'BEGIN{f=1} /kbytes/{f=0} f==1{print $0}'; echo "See LOGFILE = $LOGFILE"; }
# Note: SX-ACE does not support tail -n40
# vim: set ts=4 sw=4 et :
