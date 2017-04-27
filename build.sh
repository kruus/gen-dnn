#!/bin/bash
# vim: et ts=4 sw=4
ORIGINAL_CMD="$0 $*"
if [ "${CC##sx}" == "sx" -o "${CXX##sx}" == "sx" ]; then
    DOTARGET="s" # s for SX (C/C++ code, cross-compile)
elif [ -d src/vanilla ]; then
    DOTARGET="v" # v for vanilla (C/C++ code)
else
    DOTARGET="j" # j for JIT (Intel assembler)
fi
DOTEST=0
DODEBUG="n"
DODOC="y"
DONEEDMKL="y"
DOJUSTDOC="n"
SIZE_T=32 # or 64, for -s or -S SX compile
JOBS="-j8"
CMAKETRACE=""
usage() {
    echo "$0 usage:"
    #head -n 30 "$0" | grep "^[^#]*.)\ #"
    awk '/getopts/{flag=1;next} /done/{flag=0} flag&&/^[^#]+) #/; flag&&/^ *# /' $0
    echo "Example: time a full test run for a debug compilation --- time $0 -dtt"
    exit 0
}
while getopts ":htvjdDqpsST" arg; do
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
            if [ -d src/vanilla ]; then DOTARGET="v"; fi
            ;;
        j) # force Intel JIT (src/cpu/ JIT assembly code)
            DOTARGET="j"; DOJIT=100 # 100 means all JIT funcs enabled
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
        p) # permissive: disable the FAIL_WITHOUT_MKL switch
            DONEEDMKL="n"
            ;;
        s) # SX cross-compile (size_t=32)
            DOTARGET="s"; DOJIT=0; SIZE_T=32; JOBS="-j1"
            ;;
        S) # SX cross-compile (size_t=64)
            DOTARGET="s"; DOJIT=0; SIZE_T=64; JOBS="-j1"
            ;;
        T) # cmake --trace
            CMAKETRACE="--trace"
            ;;
    h | *) # help
            usage
            ;;
    esac
done
DOJIT=0
INSTALLDIR=install
BUILDDIR=build
if [ "$DOTARGET" == "j" ]; then DOJIT=100; INSTALLDIR='install-jit'; BUILDDIR='build-jit'; fi
if [ "$DOTARGET" == "s" ]; then DONEEDMKL="n"; DODOC="n"; DOTEST="n"; INSTALLDIR='install-sx'; BUILDDIR='build-sx'; fi
#if [ "$DOTARGET" == "v" ]; then ; fi
if [ "$DODEBUG" == "y" ]; then INSTALLDIR="${INSTALLDIR}-dbg"; fi
if [ "$DOJUSTDOC" == "y" ]; then
    (
        if [ ! -d build ]; then mkdir build; fi
        if [ ! -f build/Doxyfile ]; then
            # doxygen doesn't much care HOW to build, just WHERE
            (cd build && cmake -DCMAKE_INSTALL_PREFIX=../${INSTALL_DIR} -DFAIL_WITHOUT_MKL=OFF ..)
        fi
        echo "Doxygen (please be patient)"
        rm -rf build/doc*stamp build/reference "${INSTALL_DIR}/share/doc"
        #cd build \
        #&& make VERBOSE=1 doc \
        #&& cmake -DCOMPONENT=doc -P cmake_install.cmake
        cd build && make VERBOSE=1 install-doc # Doxygen.cmake custom target
    ) 2>&1 | tee ../doxygen.log
    exit 0
fi
timeoutPID() { # unused
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
    echo "DOTARGET   $DOTARGET"
    echo "DOJIT      $DOJIT"
    echo "DOTEST     $DOTEST"
    echo "DODEBUG    $DODEBUG"
    echo "DODOC      $DODOC"
    echo "BUILDDIR   ${BUILDDIR}"
    echo "INSTALLDIR ${INSTALLDIR}"
    if [ -d "${BUILDDIR}" ]; then rm -rf "${BUILDDIR}".bak && mv -v "${BUILDDIR}" "${BUILDDIR}".bak; fi
    if [ -d "$INSTALLDIR}" ]; then rm -rf "$INSTALLDIR}".bak && mv -v "$INSTALLDIR}" "$INSTALLDIR}".bak; fi
    mkdir "${BUILDDIR}"
    cd "${BUILDDIR}"
    #
    BUILDOK="y"
    CMAKEOPT=''
    CMAKEOPT="${CMAKEOPT} -DCMAKE_CCXX_FLAGS=-DJITFUNCS=${DOJIT}"
    if [ ! "$DOTARGET" == "j" ]; then
        CMAKEOPT="${CMAKEOPT} -DTARGET_VANILLA=ON"
    fi
    if [ "$DOTARGET" == "s" ]; then
        TOOLCHAIN=../cmake/sx.cmake
        if [ ! -f "${TOOLCHAIN}" ]; then echo "Ohoh. ${TOOLCHAIN} not found?"; BUILDOK="n"; fi
        CMAKEOPT="${CMAKEOPT} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}"
        CMAKEOPT="${CMAKEOPT} --debug-trycompile --trace -LAH" # long debug of cmake
        export CFLAGS="${CFLAGS} -size_t${SIZE_T} -Kc99,gcc"
        # An object file that is generated with -Kexceptions and an object file
        # that is generated with -Knoexceptions must not be linked together. In
        # such a case, the exception may not be thrown correctly Therefore, do
        # not specify -Kexceptions if the program does not use the try, catch
        # and throw keywords.
        export CXXFLAGS="${CXXFLAGS} -size_t${SIZE_T} -Kcpp11,gcc,rtti,exceptions"
        #export CXXFLAGS="${CXXFLAGS} -size_t${SIZE_T} -Kcpp11,gcc,rtti"
    fi
    if [ "$DODEBUG" == "y" ]; then
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Debug"
        CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../${INSTALLDIR}-dbg"
    else
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Release"
        #CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
        CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../${INSTALLDIR}"
    fi
    if [ "$DONEEDMKL" == "y" ]; then
        CMAKEOPT="${CMAKEOPT} -DFAIL_WITHOUT_MKL=ON"
    fi
    # Remove leading whitespace from CMAKEENV (bash magic)
    shopt -s extglob; CMAKEENV=\""${CMAKEENV##*([[:space:]])}"\"; shopt -u extglob
    # Without MKL, unit tests take **forever**
    #    TODO: cblas / mathkeisan alternatives?
    if [ "$BUILDOK" == "y" ]; then
        BUILDOK="n"
        rm -f ./stamp-BUILDOK
        echo "${CMAKEENV}; cmake ${CMAKEOPT} ${CMAKETRACE} .."
        ${CMAKEENV}; cmake ${CMAKEOPT} ${CMAKETRACE} .. \
        && make VERBOSE=1 ${JOBS} \
        && BUILDOK="y"
    fi
    if [ "$BUILDOK" == "y" -a ! "$DOTARGET" == "s" ]; then
        echo "DOTARGET  $DOTARGET"
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
) 2>&1 | tee "${BUILDDIR}".log
ls -l "${BUILDDIR}"
BUILDOK="n"; if [ -f "${BUILDDIR}"/stamp-BUILDOK ]; then BUILDOK="y"; fi # check last thing produced for OK build
if [ "$BUILDOK" == "y" ]; then
    (
    cd "${BUILDDIR}"
    { echo "Installing ..."; make install-bin install-dev; }
    { echo "Installing docs ..."; make install-doc; }
    ) 2>&1 >> "${BUILDDIR}".log
    if [ ! "$DOTEST" == "0" -a ! "$DOTARGET" == "s" ]; then
        rm -f test1.log test2.log
        echo "Testing ... test1"
        (cd "${BUILDDIR}" && ARGS='-VV -E .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test1.log || true
        if [ $DOTEST -gt 1 ]; then
            echo "Testing ... test1"
            (cd "${BUILDDIR}" && ARGS='-VV -N' make test \
            && ARGS='-VV -R .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test2.log || true
        fi
        echo "Tests done"
    fi
else
    echo "Build NOT OK..."
fi
echo "BUILDDIR   ${BUILDDIR}"
echo "INSTALLDIR ${INSTALLDIR}"
echo "DOTARGET=${DOTARGET}, DOJIT=${DOJIT}, DODEBUG=${DODEBUG}, DOTEST=${DOTEST}, DODOC=${DODOC}, DONEEDMKL=${DONEEDMKL}"
if [ "${BUILDOK}" == "y" ]; then
    LOGDIR="log-${DOTARGET}${DOJIT}${DODEBUG}${DOTEST}${DODOC}${DONEEDMKL}"
    if [ "$DOTEST" -gt "0" ]; then
        echo "LOGDIR:       ${LOGDIR}" 2>&1 >> "${BUILDDIR}".log
    fi
    if [ "$DOTEST" -gt "0" ]; then
        if [ -d "${LOGDIR}" ]; then rm -f "${LOGIDR}.bak"; mv -v "${LOGDIR}" "${LOGDIR}.bak"; fi
        mkdir ${LOGDIR}
        for f in "${BUILDDIR}.log" test1.log test2.log doxygen.log; do
            cp -av "${f}" "${LOGDIR}/" || true
        done
    fi
fi
echo "FINISHED:     $ORIGINAL_CMD" 2>&1 >> "${BUILDDIR}".log
# for a debug compile  --- FIXME
#(cd "${BUILDDIR}" && ARGS='-VV -R .*simple_training-net-cpp' /usr/bin/time -v make test) 2>&1 | tee test1-dbg.log
#(cd "${BUILDDIR}" && ARGS='-VV -R .*simple_training-net-cpp' valgrind make test) 2>&1 | tee test1-valgrind.log
