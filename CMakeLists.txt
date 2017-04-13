# vim: et ts=4 sw=4
#===============================================================================
# Copyright 2016 Intel Corporation
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

cmake_minimum_required(VERSION 2.8)

set(PROJECT_NAME "SX-DNN (Intel(R) MKL-DNN)")
set(PROJECT_FULL_NAME "SX version of Intel(R) Math Kernel Library for Deep Neural Networks (Intel(R) MKL-DNN)")
set(PROJECT_VERSION, "0.7")

set(LIB_NAME mkldnn)

project(${PROJECT_NAME} C CXX)

if("${CMAKE_BUILD_TYPE}" STREQUAL "")
    message(STATUS "CMAKE_BUILD_TYPE is unset, defaulting to Release")
    set(CMAKE_BUILD_TYPE "Release")
endif()

option(TARGET_VANILLA "Use only pure C/C++ source_code, no JIT assembler" OFF)
set(TARGET_JIT OFF)
if(TARGET_VANILLA)
    set(TARGET_DEFS "-DTARGET_VANILLA")
    set(TARGET_JIT OFF)
else()
    set(TARGET_DEFS "-DTARGET_XXJIT") # I removed this because too many tests involve the JIT formats
endif()
MESSAGE(STATUS "src/ TARGET_VANILLA: " ${TARGET_VANILLA})
if(TARGET_VANILLA)
    set(CPU_DIR vanilla)
    #set(CPU_INCLUDE_SRC_SUBDIRS)
else()
    set(CPU_DIR cpu)
    set(CPU_INCLUDE_SRC_SUBDIRS cpu/xbyak) # this can be a list of subdirectories of src/
endif()


include("cmake/MKL.cmake")
include("cmake/Doxygen.cmake")

# sdl options
if(UNIX OR APPLE)
    set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fPIC -Wformat -Wformat-security")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -D_FORTIFY_SOURCE=2")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -D_FORTIFY_SOURCE=2")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pie")
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -z noexecstack -z relro -z now")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -z noexecstack -z relro -z now")
        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.9)
            set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fstack-protector-all")
        else()
            set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fstack-protector-strong")
        endif()
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fstack-protector-all")
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now")
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fstack-protector")
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -z noexecstack -z relro -z now")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -z noexecstack -z relro -z now")
    endif()
endif()

# [ejk] (might be needed for -DUSE_CBLAS compiles, CHECKME) ok for gcc, others ???
#if(HAVE_MKL)
#    get_filename_component(MKLLIBPATH "${MKLLIB}" PATH) # this one was just not exported by MKL.cmake
#    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-rpath=${MKLLIBPATH}")
#    message(STATUS "   MKL: shared linker flags: ${CMAKE_SHARED_LINKER_FLAGS}")
#endif()

set(OPENMP_FLAGS "-fopenmp")
set(CCXX_WARN_FLAGS "-Wall -Werror -Wno-unknown-pragmas")
#set(CCXX_EXTRADEBUG_FLAGS "-g") # TODO separate Release-mode library debuginfo, someday.
# SIMPLER alternative:           cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo
set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} ${OPENMP_FLAGS} ${CCXX_EXTRADEBUG_FLAGS} ${CCXX_WARN_FLAGS} ${TARGET_DEFS} -DMKLDNN_DLL -DMKLDNN_DLL_EXPORTS -fvisibility=internal")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_CCXX_FLAGS} -std=c99")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CCXX_FLAGS} -std=c++11 -fvisibility-inlines-hidden")

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -xHOST")
endif()

enable_testing()

include_directories(include)

add_subdirectory(src)
add_subdirectory(examples)
add_subdirectory(tests)

install(FILES LICENSE DESTINATION share/doc/${LIB_NAME})
