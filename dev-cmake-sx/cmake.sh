#! /bin/sh

#CMAKE=${HOME}/scatefs/20170420/cmake/bin/cmake
#
#$CMAKE \
#-DCMAKE_TOOLCHAIN_FILE=../sx.cmake \
#..

#rm -rf build && mkdir build && (cd build && cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/sx.cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -Wno-dev .. && make VERBOSE=1) 2>&1 | tee b.log

rm -rf build
mkdir build
(cd build && cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/sx.cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -wno-dev ..) 2>&1 | tee cmake.log \
&& (cd build && make VERBOSE=1) 2>&1 | tee build.log

