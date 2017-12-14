#!/bin/bash
# vim: et ts=4 sw=4
#
# This is a version of bench.sh I use for debugging [ejk]
#
ORIGINAL_CMD="$0 $*"
if [ -d src/vanilla ]; then
    DOTARGET="v" # v for vanilla (C/C++ code)
    DOJIT=0
else
    DOTARGET="j" # j for JIT (Intel assembler)
    DOJIT=100
fi
modes=A # string with A C P T
merges=(NONE) # NONE RELU
dirs=(FWD_D) # FWD_D FWD_B BWD_D BWD_W BWD_WB
CONV_SPEC=(mb1_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1)
usage() {
    echo "$0 usage:"
    awk '/getopts/{flag=1;next} /done/{flag=0} flag&&/^[^#]+) #/; flag&&/^ *# /' $0
    echo " Examples: ./bench-run.sh          | All impls, FWD_D, merges NONE"
    echo "   ./bench-run.sh -dg              | debug compile under run"
    echo "   ./bench-run.sh -M"NONE RELU"    | both NONE and RELU convolutions"
    echo "   ./bench-run.sh -jbm"A AP" -sref | jit full rebuild, All PERF, skip ref impl"
    echo "   ./bench-run.sh -sref -AP"
    echo " We auto-supply a default single convolution spec:"
    echo "   ${CONV_SPEC[@]}"
    echo " but you can alternate specs or batchfiles with -i\"F_1 F_2 ...\","
    echo " where F_i that are files in tests/benchdnn/inputs/ are batchfiles,"
    echo " and other F_i are supplied verbatim to the 'benchdnn' command"
    echo "    (example: ./bench-run.sh -qmPT -itest_conv_regression"
    echo "              to quickly run Performance Tests with a batchfile)"
    echo "     or  ./bench-run.sh -mPT -D'FWD_B BWD_D BWD_WB' -i'conv_alexnet'"
    echo "         to run longer benchdnn impl comparisons"
    echo " Note:"
    echo "   We do not capture output into a logfile"
    echo "   SX/Aurora builds not supported"
    ls -l ./tests/benchdnn/inputs
    exit 0
}
REBUILD="n"
DODEBUG="n"
RUN_UNDER=""
VERBOSITY=0
skip=""
while getopts ":hv:jdqbPTGVs:m:M:D:i:" arg; do
    #echo "arg = ${arg}, OPTIND = ${OPTIND}, OPTARG=${OPTARG}"
    case $arg in
        v) # N [0] verbosity
            VERBOSITY="${OPTARG}"
            echo "VERBOSITY   ${VERBOSITY}"
            ;;
        j) # use Intel JIT (src/cpu/ JIT assembly code) if avail [default=vanilla]
            DOTARGET="j"
            ;;
        d) # [no] debug release
            DODEBUG="y"
            ;;
        q) # quick [default] skip full remake via build.sh
            REBUILD="n"
            ;;
        b) # build.sh (full remake)
            REBUILD="y"
            ;;
        m) # test mode string, C P [A] T -- for Corr Perf All Test
            modes=(${OPTARG})
            ;;
        M) # merges string : select from [NONE] RELU
            merges=(${OPTARG})
            ;;
        D) # dirs string : select from [FWD_D] FWD_B BWD_D BWD_W BWD_WB
            dirs=(${OPTARG})
            ;;
        i) # BATCHFILE (under benchdnn/inputs/ directory)
            CONV_SPEC=(${OPTARG})
            ;;
        P) # [default] plain run (no gdb or valgrind)
            RUN_UNDER=""
            ;;
        T) # run under /usr/bin/time -v
            RUN_UNDER=(/usr/bin/time -v)
            ;;
        G) # run under gdb
            RUN_UNDER=(gdb --args)
            ;;
        V) # run under valgrind
            RUN_UNDER=(valgrind --leak-check=full)
            skip="gemm" # my valgrind did not handle some mkl VEX instrns
            ;;
        s) # skip-impl string [""]
            skip="${OPTARG}"
            ;;
    h | *) # help
            usage
            ;;
    esac
done
BUILDDIR="build"
INSTALLDIR="install"
REBUILD_CMD="./build.sh -q"
if [ "$DOTARGET" == "j" ]; then DOJIT=100; INSTALLDIR='install-jit';
    BUILDDIR='build-jit';
	REBUILD_CMD="${REBUILD_CMD}j"
else
	REBUILD_CMD="${REBUILD_CMD}v"
fi
if [ "$DODEBUG" == "y" ]; then
    INSTALLDIR="${INSTALLDIR}-dbg"
    BUILDDIR="${BUILDDIR}d"
	REBUILD_CMD="${REBUILD_CMD}d"
fi
if [ "$REBUILD" == "n" ]; then
	REBUILD_CMD="(cd ${BUILDDIR} && make)"
fi
for idx in "${!CONV_SPEC[@]}"; do
    spec="${CONV_SPEC[$idx]}"
    if [ -f "./tests/benchdnn/inputs/${spec}" ]; then
        CONV_SPEC[$idx]="--batch=./tests/benchdnn/inputs/${spec}"
        cp -uarv "./tests/benchdnn/inputs/${spec}" "${BUILDDIR}/tests/benchdnn/inputs/"
    fi
done

eval ${REBUILD_CMD} || { echo "OHOH for ${REBUILD_CMD}"; exit -1; }
echo "Rebuilt ${BUILDDIR}"
echo "modes     : ${modes[@]}"
echo "merges    : ${merges[@]}"
echo "dirs      : ${dirs[@]}"
echo "CONV_SPEC : ${CONV_SPEC[@]}"
echo "VERBOSITY : ${VERBOSITY}"

for mode in ${modes[@]}; do
	for merge in ${merges[@]}; do
        for dir in ${dirs[@]}; do
            echo -e "\n>>>$mode $merge $dir";
            echo "${RUN_UNDER[@]}
                ./${BUILDDIR}/tests/benchdnn/benchdnn
                --conv --mode=$mode --cfg=f32 --dir=$dir --merge=$merge
                --skip-impl="$skip" -v${VERBOSITY}
                ${CONV_SPEC[@]}"
            OMP_NUM_THREADS=12 \
                ${RUN_UNDER[@]} \
                ./${BUILDDIR}/tests/benchdnn/benchdnn \
                --conv --mode=$mode --cfg=f32 --dir=$dir --merge=$merge \
                --skip-impl="$skip" -v${VERBOSITY} \
                ${CONV_SPEC[@]} \
            || { echo "Ohoh"; };
        done;
    done;
done
echo "Done benchdnn in ${BUILDDIR}"
