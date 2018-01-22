#===============================================================================
# Copyright 2017 NEC
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
# Locate Aurora blas lib 
#===============================================================================

if(NLC_cmake_included)
    return()
endif()
set(NLC_cmake_included true)

if(NECVE)
    #
    # Detect via env var NLC_BASE, or add some more locations to search
    # to try to automatically locate CBLAS for Aurora cross-compilation.
    #
    #set(NLCINC $ENV{NLC_BASE}/include)
    find_path(NLCINC cblas.h NO_DEFAULT_PATH PATHS
        /opt/nec/ve/nlc/1.0.0/include # latest version
        /opt/nec/ve/nlc/0.9.0/include # older version from beta program
        /usr/uhome/aurora/bm/nlc/0.9.0/include # ok for cross-compile on zoro
        $ENV{NLC_BASE}
        )

    if(NOT NLCINC)
        message(STATUS "Aurora NLC cblas not found")
        return()
    endif()
    get_filename_component(NLCROOT "${NLCINC}" PATH)
    message(STATUS "NLCROOT = ${NLCROOT}")
    message(STATUS "Using Aurora NLC cblas found under ${NLCROOT}")

    find_library(NLCLIB NAMES cblas PATHS ${NLCROOT}/lib)
    if(NLCLIB)
        #set(NLCLIB $ENV{NLC_BASE}/lib/libcblas.a)
    endif()
    message(STATUS "NLCLIB = ${NLCLIB}")

    #set(NLCLIBBLAS $ENV{NLC_BASE}/lib/libblas_pthread.a)
    #set(NLCLIBBLAS /opt/nec/ve/nlc/0.9.0/lib/libblas_sequential.a)
    find_library(NLCLIBBLAS NAMES blas_pthread PATHS ${NLCROOT}/lib)
    if(NLCLIBBLAS)
        #set(NLCLIBBLAS $ENV{NLC_BASE}/lib/libcblas_pthread.a)
    endif()
    message(STATUS "NLCLIBBLAS = ${NLCLIBBLAS}")

    if(NLCLIB AND NLCLIBBLAS)
        add_definitions(-DUSE_CBLAS)
        include_directories(AFTER ${NLCINC})
        list(APPEND mkldnn_LINKER_LIBS ${NLCLIB} ${NLCLIBBLAS})
    endif()
endif()
# vim: et ts=4 sw=4 ai
