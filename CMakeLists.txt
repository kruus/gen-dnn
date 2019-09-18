# vim: et ts=4 sw=4
#===============================================================================
# Copyright 2016-2018 Intel Corporation
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
    cmake_minimum_required(VERSION 3.6)
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
set(PROJECT_VERSION "0.16")

set(LIB_NAME mkldnn)

project(${PROJECT_NAME} C CXX) # This runs any CMAKE_TOOLCHAIN_FILE (twice)
if(NECSX)
    cmake_minimum_required(VERSION 3.8) # allow nicer Platform/SX-* files
    # Want -lcblas *after* -lmkldnn ... How?
    #set(LINK_LIBRARIES "${LINK_LIBRARIES} ${SX_LINK_LIBRARIES}" CACHE STRING "will this go after -lmkldnn?")
endif()
# If enabled, generate a compile_commands.json file of the exact compiler
# commands (for Makefile and Ninja generators)
add_definitions(-DCMAKE_EXPORT_COMPILE_COMMANDS=1)

message(STATUS "CMAKE_TOOLCHAIN_PREFIX = ${CMAKE_TOOLCHAIN_PREFIX}")
if("${CMAKE_BUILD_TYPE}" STREQUAL "")
    message(STATUS "CMAKE_BUILD_TYPE is unset, defaulting to RelWithDebInfo")
    set(CMAKE_BUILD_TYPE "RelWithDebInfo")
endif()

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

set(CMAKE_SRC_CCXX_FLAGS)       # SRC specifics
set(CMAKE_EXAMPLE_CCXX_FLAGS)   # EXAMPLE specifics
set(CMAKE_TEST_CCXX_FLAGS)      # TESTS specifics

include("cmake/options.cmake")
include("cmake/platform.cmake")
include("cmake/asm.cmake")
if(TRUE AND NECVE)
    set(CMAKE_THREAD_PREFER_PTHREAD 1)
    set(THREADS_PREFER_PTHREAD_FLAG 1)
    set(Threads_FIND_QUIETLY FALSE)
    find_package(Threads REQUIRED)
endif()
include("cmake/MKL.cmake")
include("cmake/cblas.cmake")
include("cmake/OpenMP.cmake")
include("cmake/SDL.cmake")
include("cmake/NLC.cmake")
include("cmake/Doxygen.cmake")
include("cmake/profiling.cmake")

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

get_property(dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
foreach(dir ${dirs})
    message(STATUS "include_directories: '${dir}'")
endforeach()

message(STATUS "CMakeLists.txt DONE!")
# vim: et ts=4 sw=4 ai :
