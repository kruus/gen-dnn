#===============================================================================
# Copyright 2016-2019 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#===============================================================================

if (CMAKE_TOOLCHAIN_FILE)
    cmake_minimum_required(VERSION 3.6)
elseif (NECSX)
    cmake_minimum_required(VERSION 3.8) # allow nicer Platform/SX-* files
else()
    cmake_minimum_required(VERSION 2.8.11)
endif()

if(POLICY CMP0022)
    cmake_policy(SET CMP0022 NEW)
endif()

if(POLICY CMP0054)
    cmake_policy(SET CMP0054 NEW)
endif()

# Enable RPATH on MacOS/OSX
if(POLICY CMP0042)
    cmake_policy(SET CMP0042 NEW)
endif()

# Do not export symbols from executables
if(POLICY CMP0065)
    cmake_policy(SET CMP0065 NEW)
endif()

# Pass all flags to try_compile
if(POLICY CMP0056)
    cmake_policy(SET CMP0056 NEW)
endif()
if(POLICY CMP0066)
    cmake_policy(SET CMP0066 NEW)
endif()

# Use <PackageName>_ROOT env. variable as a prefix
if(POLICY CMP0074)
    cmake_policy(SET CMP0074 NEW)
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "")
    message(STATUS "CMAKE_BUILD_TYPE is unset, defaulting to Release")
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel ...")
endif()

set(PROJECT_NAME "DNNL generic")
set(PROJECT_FULL_NAME "Deep Neural Network Library (DNNL) generic")
set(PROJECT_VERSION "1.1.0")

set(LIB_NAME dnnl)

if (CMAKE_VERSION VERSION_LESS 3.0)
    project(${PROJECT_NAME} C CXX)
else()
    cmake_policy(SET CMP0048 NEW)
    project(${PROJECT_NAME} VERSION "${PROJECT_VERSION}" LANGUAGES C CXX)
endif()

if (NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(FATAL_ERROR "DNNL supports 64 bit platforms only")
endif()

# If enabled, generate a compile_commands.json file of the exact compiler
# commands (for Makefile and Ninja generators)
add_definitions(-DCMAKE_EXPORT_COMPILE_COMMANDS=1)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

set(CMAKE_SRC_CCXX_FLAGS)       # SRC specifics
set(CMAKE_EXAMPLE_CCXX_FLAGS)   # EXAMPLE specifics
set(CMAKE_TEST_CCXX_FLAGS)      # TESTS specifics

if(UNIX OR MINGW)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
    if(NECVE)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
        # uninitialized variable debug:
        # "It may avoid by initializing the area to zero to compile with “-minit-stack=zero” and
        # execute with the environment variable VE_INIT_HEAP=ZERO. Correction of a
        # program is recommended to resolve a potential problem."
        string(APPEND CMAKE_C_FLAGS   " -minit-stack=0xDeadBeef")
        string(APPEND CMAKE_CXX_FLAGS " -minit-stack=0xDefaced1")
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    endif()
endif()

include("cmake/mkldnn_compat.cmake")

include("cmake/utils.cmake")
include("cmake/options.cmake")
include("cmake/asm.cmake")
include("cmake/OpenMP.cmake")
include("cmake/TBB.cmake")
include("cmake/OpenCL.cmake")
include("cmake/platform.cmake")
include("cmake/SDL.cmake")
include("cmake/MKL.cmake")
include("cmake/cblas.cmake")
#include("cmake/NLC.cmake")
include("cmake/Doxygen.cmake")
include("cmake/version.cmake")
# XXX hack (debug function to print various cmake things)
include("Platform/SX-util.cmake")
include("cmake/coverage.cmake")

# Handle cases when OpenMP runtime is requested but not found: override CPU
# runtime to be sequential
if(DNNL_CPU_RUNTIME STREQUAL "OMP" AND
   DNNL_CPU_THREADING_RUNTIME STREQUAL "SEQ")
    set(DNNL_CPU_RUNTIME "SEQ" CACHE STRING "" FORCE)
endif()

enable_testing()

include_directories(include)

# Prepare build variables for export to config.h, and format a final
# DNNL_BUILD_TARGET string recording non-default build options.
include("cmake/options-config.cmake")
message(STATUS "DNNL_BUILD_STRING ${DNNL_BUILD_STRING}")
configure_file(
    "${PROJECT_SOURCE_DIR}/include/dnnl_config.h.in"
    "${PROJECT_BINARY_DIR}/include/dnnl_config.h"
)
include_directories(${PROJECT_BINARY_DIR}/include)

configure_file(
    "${PROJECT_SOURCE_DIR}/README.binary.in"
    "${PROJECT_BINARY_DIR}/README"
)

if(DNNL_INSTALL_MODE STREQUAL "BUNDLE" AND NOT DEFINED CMAKE_INSTALL_LIBDIR)
    # define CMAKE_INSTALL_LIBDIR as "lib" in the case of bundle
    set(CMAKE_INSTALL_LIBDIR "lib")
endif()

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_subdirectory(src)
add_subdirectory(examples)
add_subdirectory(tests)

if(DNNL_INSTALL_MODE STREQUAL "BUNDLE")
    install(FILES LICENSE DESTINATION ${CMAKE_INSTALL_PREFIX})
    install(FILES ${PROJECT_BINARY_DIR}/README DESTINATION ${CMAKE_INSTALL_PREFIX})
else()
    # Cannot use CMAKE_INSTALL_DOCDIR since it uses PROJECT_NAME and not LIB_NAME
    install(FILES LICENSE DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/doc/${LIB_NAME})
    install(FILES ${PROJECT_BINARY_DIR}/README DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/doc/${LIB_NAME})
endif()

# record some cmake variables in the build tree, for shell scripts
configure_file(${CMAKE_SOURCE_DIR}/cmake/bash_help.inc.in
    ${PROJECT_BINARY_DIR}/bash_help.inc)
if(NECVE) # toolchain debug
    show_cmake_stuff("At end of CMakeLists.txt")
endif()
