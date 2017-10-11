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
    echo " Examples: ./bench-gdb.sh        All impls, FWD_D, merges NONE"
    echo "   ./bench-gdb.sh -dg            debug compile under gdb"
    echo "   ./bench-gdb.sh -M"NONE RELU"  both NONE and RELU convolutions"
    echo "   ./bench-gdb.sh -jbm"A AP" -sref    jit full rebuild, All PERF, skip ref impl"
    echo "   ./bench-gdb.sh -sref -AP"
    echo " We auto-supply a default single convolution spec:"
    echo "   ${CONV_SPEC[@]}"
    exit 0
}
REBUILD="n"
DODEBUG="n"
RUN_UNDER=""
VERBOSITY=0
skip=""
while getopts ":hv:jdqbPTGVs:m:M:D:" arg; do
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
if [ "$DODEBUG" == "y" ]; then INSTALLDIR="${INSTALLDIR}-dbg"; BUILDDIR="${BUILDDIR}d";
	REBUILD_CMD="${REBUILD_CMD}d"
fi
if [ "$REBUILD" == "n" ]; then
	REBUILD_CMD="(cd ${BUILDDIR} && make)"
fi

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
