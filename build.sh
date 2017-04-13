#!/bin/bash
# vim: et ts=4 sw=4
DOVANILLA="y"
DOJIT="n"
DOTEST="n"
DODEBUG="n"
usage() { echo "$0 usage:" && head -n 30 "$0" | grep " .)\ #"; exit 0; }
while getopts ":htvijd" arg; do
    case $arg in
        t) # [no] Run tests (tens of minutes)
            DOTEST="y"
            ;;
        v) # [yes] (src/vanilla C/C++ only: no src/cpu JIT assembler)
            DOVANILLA="y"; DOJIT="n"
            ;;
        i | j) # [no] Intel JIT (src/cpu JIT assembly version)
            DOVANILLA="n"; DOJIT="y"
            ;;
        d) # [no] debug release
            DODEBUG="y"
            ;;
        h | *) # help
            usage
            ;;
    esac
    shift
done
(
    echo "DOVANILLA $DOVANILLA"
    echo "DOJIT     $DOJIT"
    echo "DOTEST    $DOTEST"
    echo "DODEBUG   $DODEBUG"
    if [ -d build ]; then rm -rf build.bak && mv -v build build.bak; fi
    if [ -d install ]; then rm -rf install.bak && mv -v install install.bak; fi
    mkdir build
    cd build
    #
    CMAKEOPT=''
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
    CMAKEOPT="${CMAKEOPT} -DFAIL_WITHOUT_MKL=ON"
    # Without MKL, unit tests take **forever**
    #    TODO: cblas / mathkeisan alternatives?
    cmake ${CMAKEOPT} .. && \
	    make VERBOSE=1 -j8 && \
	    examples/simple-training-net-cpp && \
	    { echo "Doxygen (please be patient)"; make doc >& ../doxygen.log; }
) 2>&1 | tee build.log
(
    cd build
    { echo "Installing ..."; make install; }
) 2>&1 >> build.log
if [ "$DOTEST" == "y" ]; then
    (cd build && ARGS='-VV -N' make test \
	      && ARGS='-VV -R .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test0.log
    (cd build && ARGS='-VV -E .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test1.log
fi
# for a debug compile  --- FIXME
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' /usr/bin/time -v make test) 2>&1 | tee test1-dbg.log
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' valgrind make test) 2>&1 | tee test1-valgrind.log
