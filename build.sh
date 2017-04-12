#!/bin/bash
DOTEST="n"; if [ "$1" == "test" ]; then DOTEST="y"; shift; fi
(
    if [ -d build ]; then rm -rf build.bak && mv -v build build.bak; fi
    if [ -d install ]; then rm -rf install.bak && mv -v install install.bak; fi
    mkdir build
    cd build
    #
    CMAKEOPT=''
    CMAKEOPT="${CMAKEOPT} -DTARGET_VANILLA=ON"
    #
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Debug"
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../install-dbg"
    #
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Release"
    CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
    CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../install"
    #
    CMAKEOPT="${CMAKEOPT} -DFAIL_WITHOUT_MKL=ON"
    # Without MKL, unit tests take **forever**
    #    TODO: cblas / mathkeisan alternatives?
    cmake ${CMAKEOPT} ..
    make VERBOSE=1 -j8 && \
    echo "Doxygen (please be patient)" && \
    make doc >& ../doxygen.log
) 2>&1 | tee build.log
(
    cd build
    echo "Installing ..."
    make install
) 2>&1 >> build.log
if [ "$DOTEST" == "y" ]; then
    (cd build && ARGS='-VV -N' make test \
	      && ARGS='-VV -R .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test0.log
    (cd build && ARGS='-VV -E .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test1.log
fi
# for a debug compile  --- FIXME
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' /usr/bin/time -v make test) 2>&1 | tee test1-dbg.log
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' valgrind make test) 2>&1 | tee test1-valgrind.log

