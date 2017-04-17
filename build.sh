#!/bin/bash
# vim: et ts=4 sw=4
ORIGINAL_CMD="$0 $*"
if [ -d src/vanilla ]; then
    DOVANILLA="y"
    DOJIT=0
else
    DOVANILLA="n"
    DOJIT=100
fi
DOTEST=0
DODEBUG="n"
DODOC="y"
DONEEDMKL="y"
DOJUSTDOC="n"
usage() {
    echo "$0 usage:"
    #head -n 30 "$0" | grep "^[^#]*.)\ #"
    awk '/getopts/{flag=1;next} /done/{flag=0} flag&&/^[^#]+) #/; flag&&/^ *# /' $0
    echo "Example: time a full test run for a debug compilation --- time $0 -dtt"
    exit 0
}
while getopts ":htvijdDqs" arg; do
    #echo "arg = ${arg}, OPTIND = ${OPTIND}, OPTARG=${OPTARG}"
    case $arg in
        t) # [0] increment test level: (1) examples, (2) tests (longer), ...
            # Apr-14-2017 build timings:
            # 0: build    ~ ?? min  (jit), 1     min  (vanilla)
            # 1: examples ~  1 min  (jit), 13-16 mins (vanilla)
            # 2: test_*   ~ 10 mins (jit), 108   mins (vanilla)
            DOTEST=$(( DOTEST + 1 ))
            ;;
        v) # [yes] (vanilla C/C++ only: no src/cpu/ JIT assembler)
            if [ -d src/vanilla ]; then DOVANILLA="y"; fi
            DOJIT=0
            ;;
    i | j) # force Intel JIT (src/cpu/ JIT assembly code)
            DOVANILLA="n"; DOJIT=100 # 100 means all JIT funcs enabled
            ;;
        d) # [no] debug release
            DODEBUG="y"
            ;;
        D) # [no] Doxygen : force a full rebuild of only the doc component
            DOJUSTDOC="y"
            ;;
        q) # quick: skip doxygen docs [default: run doxygen if build OK]
            DODOC="n"
            ;;
        s) # slow: disable the FAIL_WITHOUT_MKL switch
            DONEEDMKL="n"
            ;;
    h | *) # help
            usage
            ;;
    esac
done
if [ "$DOJUSTDOC" == "y" ]; then
    (
        if [ ! -d build ]; then mkdir build; fi
        if [ ! -f build/Doxyfile ]; then
            # doxygen doesn't much care HOW to build, just WHERE
            (cd build && cmake -DCMAKE_INSTALL_PREFIX=../install -DFAIL_WITHOUT_MKL=OFF ..)
        fi
        echo "Doxygen (please be patient)"
        rm -rf build/doc*stamp build/reference install/share/doc
        #cd build \
        #&& make VERBOSE=1 doc \
        #&& cmake -DCOMPONENT=doc -P cmake_install.cmake
        cd build && make VERBOSE=1 install-doc # Doxygen.cmake custom target
    ) 2>&1 | tee ../doxygen.log
    exit 0
fi
timeoutPID() {
    PID="$1"
    timeout="$2"
    interval=1
    delay=1
    (
        ((t = timeout))

        while ((t > 0)); do
            sleep $interval
            kill -0 $$ || exit 0
            ((t -= interval))
        done

        # Be nice, post SIGTERM first.
        # The 'exit 0' below will be executed if any preceeding command fails.
        kill -s SIGTERM $$ && kill -0 $$ || exit 0
        sleep $delay
        kill -s SIGKILL $$
    ) 2> /dev/null &
}
(
    echo "DOVANILLA $DOVANILLA"
    echo "DOJIT     $DOJIT"
    echo "DOTEST    $DOTEST"
    echo "DODEBUG   $DODEBUG"
    echo "DODOC     $DODOC"
    if [ -d build ]; then rm -rf build.bak && mv -v build build.bak; fi
    if [ -d install ]; then rm -rf install.bak && mv -v install install.bak; fi
    mkdir build
    cd build
    #
    CMAKEOPT=''
    CMAKEOPT="${CMAKEOPT} -DCMAKE_CCXX_FLAGS=-DJITFUNCS=${DOJIT}"
    if [ "$DOVANILLA" == "y" ]; then
        CMAKEOPT="${CMAKEOPT} -DTARGET_VANILLA=ON"
    fi
    if [ "$DODEBUG" == "y" ]; then
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Debug"
        CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../install-dbg"
    else
        #CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Release"
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
        CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../install"
    fi
    if [ "$DONEEDMKL" == "y" ]; then
        CMAKEOPT="${CMAKEOPT} -DFAIL_WITHOUT_MKL=ON"
    fi
    # Without MKL, unit tests take **forever**
    #    TODO: cblas / mathkeisan alternatives?
    BUILDOK="n"
    rm -f ./stamp-BUILDOK
    echo "cmake ${CMAKEOPT} .."
    cmake ${CMAKEOPT} .. && \
	    make VERBOSE=1 -j8 && \
        BUILDOK="y"
    if [ "$BUILDOK" == "y" ]; then
        echo "DOVANILLA $DOVANILLA"
        echo "DOJIT     $DOJIT"
        echo "DOTEST    $DOTEST"
        echo "DODEBUG   $DODEBUG"
        echo "DODOC     $DODOC"
        # Whatever you are currently debugging (and is a quick sanity check) can go here
        if [ -x tests/api-io-c ]; then
            { echo "api-io-c                ..."; time tests/api-io-c || BUILDOK="n"; }
        else
            { echo "api-c                ..."; time tests/api-c || BUILDOK="n"; }
        fi
        if [ "$DOTEST" == 0 -a "$DOJIT" -gt 0 ]; then # this is fast ONLY with JIT (< 5 secs vs > 5 mins)
            { echo "simple-training-net-cpp ..."; time examples/simple-training-net-cpp || BUILDOK="n"; }
        fi
    fi
    if [ "$BUILDOK" == "y" ]; then
        touch ./stamp-BUILDOK
        if [ "$DODOC" == "y" ]; then
            echo "Build OK... Doxygen (please be patient)"
            make VERBOSE=1 doc >& ../doxygen.log
        fi
    fi
) 2>&1 | tee build.log
BUILDOK="n"; if [ -f build/stamp-BUILDOK ]; then BUILDOK="y"; fi # check last thing produced for OK build
if [ "$BUILDOK" == "y" ]; then
    (
        cd build
        { echo "Installing ..."; make install; }
    ) 2>&1 >> build.log
    if [ "$DOTEST" -gt 0 ]; then
        rm -f test1.log test2.log
        echo "Testing ... test1"
        (cd build && ARGS='-VV -E .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test1.log || true
        if [ "$DOTEST" -gt 1 ]; then
            echo "Testing ... test1"
            (cd build && ARGS='-VV -N' make test \
                && ARGS='-VV -R .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test2.log || true
        fi
        echo "Tests done"
    fi
else
    echo "Build NOT OK..."
fi
echo "DOVANILLA=${DOVANILLA}, DOJIT=${DOJIT}, DOTEST=${DOTEST}, DODEBUG=${DODEBUG}, DODOC=${DODOC}, DONEEDMKL=${DONEEDMKL}"
if [ "$DOTEST" -gt 0 -a "${BUILDOK}" == "y" ]; then
    LOGDIR="log-${DOVANILLA}${DOJIT}${DOTEST}${DODEBUG}${DODOC}${DONEEDMKL}"
    echo "LOGDIR:       ${LOGDIR}" 2>&1 >> build.log
fi
if [ "$DOTEST" -gt 0  -a "${BUILDOK}" == "y"]; then
    if [ -d "${LOGDIR}" ]; then rm -f "${LOGIDR}.bak"; mv -v "${LOGDIR}" "${LOGDIR}.bak"; fi
    mkdir ${LOGDIR}
    for f in build.log test1.log test2.log doxygen.log; do
        cp -av "${f}" "${LOGDIR}/" || true
    done
fi
echo "FINISHED:     $ORIGINAL_CMD" 2>&1 >> build.log
# for a debug compile  --- FIXME
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' /usr/bin/time -v make test) 2>&1 | tee test1-dbg.log
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' valgrind make test) 2>&1 | tee test1-valgrind.log
