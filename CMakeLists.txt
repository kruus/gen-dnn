# vim: et ts=4 sw=4
#===============================================================================
# Copyright 2016-2017 Intel Corporation
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

if(CMAKE_TOOLCHAIN_FILE)
    # 3.8 makes it easier to construct Platform/SX-* files
    cmake_minimum_required(VERSION 3.8)
else()
    cmake_minimum_required(VERSION 2.8)
endif()

# Use old-style version handling
if(POLICY CMP0048)
    cmake_policy(SET CMP0048 OLD)
    cmake_policy(SET CMP0054 OLD)
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
# use full pathnames on libs (now auto-discovered from compiler frontends)
if(POLICY CMP0060)
    cmake_policy(SET CMP0060 NEW)
endif()

set(PROJECT_NAME "GEN-DNN generic MKL-DNN)")
set(PROJECT_FULL_NAME "Generic (Intel(R) MKL-DNN)")
set(PROJECT_VERSION "0.12")

set(LIB_NAME mkldnn)

project(${PROJECT_NAME} C CXX) # This runs any CMAKE_TOOLCHAIN_FILE (twice)
# If enabled, generate a compile_commands.json file of the exact compiler
# commands (for Makefile and Ninja generators)
add_definitions(-DCMAKE_EXPORT_COMPILE_COMMANDS=1)

# Want -lcblas *after* -lmkldnn ... How?
#set(LINK_LIBRARIES "${LINK_LIBRARIES} ${SX_LINK_LIBRARIES}" CACHE STRING "will this go after -lmkldnn?")

message(STATUS "CMAKE_TOOLCHAIN_PREFIX = ${CMAKE_TOOLCHAIN_PREFIX}")

if("${CMAKE_BUILD_TYPE}" STREQUAL "")
    message(STATUS "CMAKE_BUILD_TYPE is unset, defaulting to RelWithDebInfo")
    set(CMAKE_BUILD_TYPE "RelWithDebInfo")
endif()


####################################
# [ejk] support a TARGET_VANILLA **alternative** to src/cpu/ 
include(CMakeDependentOption)
CMAKE_DEPENDENT_OPTION(TARGET_VANILLA "Use only pure C/C++ source_code, no JIT assembler" OFF
    "NECVE;NECSX" ON)
set(TARGET_JIT OFF)
if(TARGET_VANILLA)
    set(TARGET_DEFS "-DTARGET_VANILLA")
    set(TARGET_JIT OFF)
endif()
MESSAGE(STATUS "src/ TARGET_VANILLA: " ${TARGET_VANILLA})
if(TARGET_VANILLA)
    set(CPU_DIR vanilla)
else()
    set(CPU_DIR cpu)
endif()
# NECVE: OpenMP support is rumored to be here, but experience suggests otherwise :0
CMAKE_DEPENDENT_OPTION(USE_OPENMP "Use OpenMP?" ON
                                        "NECVE" OFF)
CMAKE_DEPENDENT_OPTION(USE_SHAREDLIBS "Use shared libs?" ON
                                                 "NECVE" OFF)
# These options can be overridden from the cmake command line
message(STATUS, "cmake options: -DTARGET_VANILLA=${TARGET_VANILLA} -DUSE_OPENMP=${USE_OPENMP} -DUSE_SHAREDLIB=${USE_SHAREDLIB}")                                                 
#if(NECVE)
#    show_cmake_stuff("Initial setup completed ...")
#endif()
####################################

include("cmake/platform.cmake")
include("cmake/asm.cmake")
if(TRUE AND NECVE)
    set(CMAKE_THREAD_PREFER_PTHREAD 1)
    set(THREADS_PREFER_PTHREAD_FLAG 1)
    find_package(Threads REQUIRED)
endif()
if(USE_OPENMP)
    include("cmake/OpenMP.cmake")
endif()
include("cmake/SDL.cmake")
include("cmake/MKL.cmake")
include("cmake/NLC.cmake")
include("cmake/Doxygen.cmake")

# XXX hack
include("Platform/SX-util.cmake")

enable_testing()

include_directories(include)

add_subdirectory(src)
add_subdirectory(examples)
add_subdirectory(tests)

install(FILES LICENSE DESTINATION share/doc/${LIB_NAME} COMPONENT doc)
message(STATUS "CMAKE_CXX_COMPILER = ${CMAKE_CXX_COMPILER}")
if(1 OR NECVE)
    show_cmake_stuff("After cmake/*.cmake includes ...")
    configure_file(${CMAKE_SOURCE_DIR}/cmake/bash_help.inc.in
        ${PROJECT_BINARY_DIR}/bash_help.inc)
endif()
message(STATUS "CMakeLists.txt DONE!")
# vim: et ts=4 sw=4 ai :
