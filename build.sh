#!/bin/bash
(
if [ -d build ]; then rm -rf build.bak && mv -v build build.bak; fi
if [ -d install ]; then rm -rf install.bak && mv -v install install.bak; fi
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=../install -DBUILD_TYPE=Release ..
make VERBOSE=1
) 2>&1 | tee build.log
