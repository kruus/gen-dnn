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
    if(VE_CBLAS_INCLUDE_DIR)
        set(NLCINC "${VE_CBLAS_INCLUDE_DIR}")
        #set(NLCINC "${VE_NCC_INCLUDES}")# <-- this one is a bit longer
    else()
        find_path(NLCINC cblas.h NO_DEFAULT_PATH PATHS
            ${NLC_HOME}
            /opt/nec/ve/nlc/1.0.0/include # latest version
            /opt/nec/ve/nlc/0.9.0/include # older version from beta program
            /usr/uhome/aurora/bm/nlc/0.9.0/include # ok for cross-compile on zoro
            $ENV{NLC_BASE}
            )
    endif()
    if(NOT NLCINC)
        message(STATUS "Aurora NLC cblas not found")
        return()
    endif()
    message(STATUS "NLC cblas includes: ${NLCINC}")

    if(NLC_HOME)
        set(NLCROOT "${NLC_HOME}")
    else()
        get_filename_component(NLCROOT "${NLCINC}" PATH)
    endif()
    message(STATUS "NLCROOT = ${NLCROOT}")
    message(STATUS "Using Aurora NLC cblas found under ${NLCROOT}")

    if(VE_NLC_CBLAS_LIB_PATHS)
        set(NLCLIB ${VE_NLC_CBLAS_LIB_PATHS})
    else()
        find_library(NLCLIBCBLAS NAMES cblas PATHS ${NLCROOT}/lib)
        find_library(NLCLIBBLAS NAMES blas_sequential PATHS ${NLCROOT}/lib)
        if(NLCLIBCBLAS AND NLCLIBBLAS)
            set(NLCLIB ${NLCLIBCBLAS} ${NLCLIBBLAS})
        endif()
    endif()
    message(STATUS "NLCLIB = ${NLCLIB}")

    # VE_SETUP args (adjusted) : _nlc_I64 0 _nlc_MPI 0 _nlc_SEQ 1 _nlc_FFT 0 _nlc_ASL 0 _nlc_CBLAS 1 _nlc_HET 0
    #-- set VE_CBLAS_INCLUDE_DIR to /opt/nec/ve/nlc/2.0.0/include
    #set(VE_NLC_CBLAS_LIBS -lcblas -lblas${_ve_openmp_or_sequential} ${ve_fopenmp} )
    #set(VE_NLC_CBLAS_LIB_PATHS ${VE_NLC_LIBRARY_PATH}/libcblas.a ${VE_NLC_LIBRARY_PATH}/libblas${_ve_openmp_or_sequential}.a )
    # ve.cmake also sets:
    #  For VE_NLC_SETUP:  VE_I64 0 VE_MPI 0 VE_SEQ 1
    #   VE_NLC_LIBS -lcblas -lblas_sequential
    #   VE_NLC_C_INCFLAGS -I/opt/nec/ve/nlc/2.0.0/include -I/opt/nec/ve/nlc/2.0.0/include/inc
    #   VE_NLC_CXX_INCFLAGS same
    #   VE_NLC_C_LDFLAGS -L/opt/nec/ve/nlc/2.0.0/lib
    #   VE_NLC_CXX_LDFLAGS same
    if(VE_NLC_CBLAS_LIB_PATHS)
        set(NLCLIBBLAS ${VE_NLC_CBLAS_LIB_PATHS})
    else()
    endif()
    message(STATUS "NLCLIBBLAS = ${NLCLIBBLAS}")

    if(NLCLIB AND NLCLIBBLAS)
        add_definitions(-DUSE_CBLAS)
        include_directories(AFTER ${NLCINC})
        #include_directories(AFTER ${VE_NLC_INCLUDES})
        list(APPEND mkldnn_LINKER_LIBS ${NLCLIB})
        #list(APPEND mkldnn_LINKER_LIBS ${VE_NLC_CBLAS_LIB_PATHS})
    endif()
    message(STATUS "mkldnn_LINKER_LIBS ${mkldnn_LINKER_LIBS}")
endif()
# vim: et ts=4 sw=4 ai
