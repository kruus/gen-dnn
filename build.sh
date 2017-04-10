#!/bin/bash
(
if [ -d build ]; then rm -rf build.bak && mv -v build build.bak; fi
if [ -d install ]; then rm -rf install.bak && mv -v install install.bak; fi
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=../install -DTARGET_VANILLA=ON -DCMAKE_BUILD_TYPE=Release ..
# for a debug compile  --- FIXME
#cmake -DCMAKE_INSTALL_PREFIX=../install -DTARGET_VANILLA=ON -DCMAKE_BUILD_TYPE=Debug ..
make VERBOSE=1 -j8
make install
) 2>&1 | tee build.log
(cd build && ARGS='-VV -N' make test \
	  && ARGS='-VV -R .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test0.log
(cd build && ARGS='-VV -E .*test_.*' /usr/bin/time -v make test) 2>&1 | tee test1.log
# for a debug compile  --- FIXME
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' /usr/bin/time -v make test) 2>&1 | tee test1-dbg.log
#(cd build && ARGS='-VV -R .*simple_training-net-cpp' valgrind make test) 2>&1 | tee test1-valgrind.log

