-------------------- QuickStart ---------------------------
# Purpose testbed for developing/tweaking cmake SX platform definitions
# set up ** cmake-3.8 ** in your PATH
make help
make
# Now the .tar.gz file can be untarred in the parent directory (gen-dnn)
# to incorporate changes developed here for SX cmake support.

-------------------- Changelog ----------------------------
## cmake-sample

Quickstart: In top-level dir

- cmake.sh
  - creates build/ and cmake.log and build.log
  - toolchain file: cmake/sx.cmake   (size_t64)
  - SX setup      : Platform/SX*

## Changes

- original from Ishizaka-san
  - compiles a simple test program
  - does not support CMAKE_BUILD_TYPE
  - can supply options to compiler that sxcc/sxc++
    does not understand

- modified to support CMAKE_BUILD_TYPE
  - corrects some things that cmake "GNU" compiler guess gets wrong
  - still kind of hacky
  - debug with cmake --trace to see what cmake is doing
  - I developed this with cmake-3.8
  - It also seems OK with cmake-3.0

## TODO

- should have other example dirs that test SX libraries
  - in multiple subdirs
  - linking with multiple libraries
  - linking with MathKeisan etc.
  - runnability after install

- cmake bugs:
  - CMAKE_MODULE_PATH did not point into a subdir correctly !?

