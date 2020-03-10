#===============================================================================
# Copyright 2016-2019 Intel Corporation, 2020 NEC Labs America
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

# This file has two purposes:
# 1. Construct a Build Target string describing non-default target options
# 2. Further option processing for creating dnnl_config.h
#    (make some build variables boolean 0/1 for readability and logic)
#===============================================================================

if(options_config_included)
    return()
endif()
set(options_config_included true)
include("cmake/options.cmake")

# a few local macros for string handling, esp the DNNL_BUILD_STRING
# recording non-default options, and any other 'unsupported'.

MACRO(set_01 var)
    # Usage: set_01{foo condition}
    # Result: ${foo} is set to 1 or 0 based on evaluating condition
    # Why: easier to read '#if FOO' than '#if defined(FOO)'
    # note: related macro 'set_ternary' in utils.cmake
    if(${ARGN})
        set(${var} 1)
    else()
        set(${var} 0)
    endif()
endmacro()
macro(append_choice var bool_value true_val false_val)
    if(${bool_value})
        STRING(APPEND ${var} ${true_val})
    else()
        STRING(APPEND ${var} ${false_val})
    endif()
endmacro()
macro(MAP_VERB var key dotlist)
    # Purpose: map key to other string value via a "key.value;..." dotlist
    #          setting var's value if the key is encountered.
    # Example: MAP_VERB(foo "cow" "man.2 legs;cow.4 legs;ant.6 legs")
    #  will set ${foo} to the value "4 legs" associated to "cow"
    foreach(_mv_item IN ITEMS ${dotlist})
        if(${_mv_item} MATCHES  "^${key}[.]")
            string(REGEX REPLACE "^${key}[.]" "" _mv_val ${_mv_item})
            set(${var} "${_mv_val}")
            break()
        endif()
    endforeach()
endmacro()
macro(append_map var key dotmapping)
    # Purpose: map key to other string value via a "key.value;..." dotlist
    #          and (if key is found) append it's value to var
    # Example: set(animal "ant")
    #          set(fact "A ${animal} has ")
    #          append_map(foo "${animal}" "man.2 legs;cow.4 legs;ant.6 legs"
    # --> "${fact}" should be "A ant has 6 legs"
    #  with no effect on ${fact} if 'ant' is not a key in the dotmapping list
    set(_am_mapval "")
    MAP_VERB(_am_mapval ${key} "${dotmapping}")
    string(APPEND ${var} ${_am_mapval})
endmacro()

######################## target processor + "ISA" option
set(DNNL_BUILD_STRING "CPU ${CMAKE_SYSTEM_PROCESSOR}")

if(NOT CPU_ISA EQUAL "ALL") # ALL is the default (whatever your DNNL_CPU)
    string(TOLOWER ${DNNL_ISA} DNNL_ISA_LOWERCASE)
    set(DNNL_BUILD_STRING "${DNNL_BUILD_STRING} ISA ${DNNL_ISA_LOWERCASE}")
endif()

########################## supported options, constants
if(NOT "${CMAKE_BUILD_TYPE}" MATCHES "[Rr]elease")
    set(${DNNL_BUILD_STRING} "${DNNL_BUILD_STRING} build type=${CMAKE_BUILD_TYPE},")
endif()
# normalize DNNL_VERBOSE values to a config file integer
set_01(DNNL_VERBOSE_01 DNNL_VERBOSE)
message(STATUS "DNNL_VERBOSE   =${DNNL_VERBOSE}")
message(STATUS "DNNL_VERBOSE_01=${DNNL_VERBOSE_01}")
append_choice(DNNL_BUILD_STRING DNNL_VERBOSE_01 " quiet" "")

append_choice(DNNL_BUILD_STRING DNNL_ENABLE_CONCURRENT_CACHE " concurrent_exec" "")
append_choice(DNNL_BUILD_STRING DNNL_ENABLE_PRIMITIVE_CACHE " primitive_cache" "")
append_choice(DNNL_BUILD_STRING DNNL_ENABLE_MAX_CPU_ISA "" " no-maxisa")
# Building properties and scope
append_map(DNNL_BUILD_STRING "${DNNL_LIBRARY_TYPE}" "SHARED.; STATIC")
append_map(DNNL_BUILD_STRING "${DNNL_INSTALL_MODE}" "DEFAULT.;BUNDLE. BUNDLE")
append_map(DNNL_BUILD_STRING "${DNNL_CODE_COVERAGE}" "OFF.;GCOV. gcov")
# optimizations
if(NOT DNNL_ARCH_OPT_FLAGS STREQUAL "HostOpts")
    string(APPEND DNNL_BUILD_STRING " ARCH_OPT_FLAGS='${DNNL_ARCH_OPT_FLAGS}'")
endif()
# profiling
append_choice(DNNL_BUILD_STRING DNNL_ENABLE_JIT_PROFILING "" " no-jit-profiling")
# engine capabilities
append_map(DNNL_BUILD_STRING DNNL_CPU_RUNTIME "OMP.;TBB. runtime-TBB;SEQ. runtime-SEQ")
if("${DNNL_CPU_RUNTIME}" STREQUAL "TBB")
    string(APPEND DNNL_BUILD_STRING " TBBROOT='${TBBROOT}'")
endif()
append_map(DNNL_BUILD_STRING DNNL_GPU_RUNTIME "NONE.;OCL. OCL")
if(NOT "${DNNL_GPU_RUNTIME}" STREQUAL "NONE")
    string(APPEND DNNL_BUILD_STRING " OPENCLROOT='${OPENCLROOT}'")
endif()

########################## extra / debug options
if(NOT "${DNNL_USE_CLANG_SANITIZER}" STREQUAL "")
    string(APPEND DNNL_BUILD_STRING " sanitizer=${DNNL_USE_CLANG_SANITIZER}")
endif()
append_choice(DNNL_BUILD_STRING HAVE_MKL " MKL" "")
append_choice(DNNL_BUILD_STRING BENCHDNN_USE_RDPMC " benchdnn-rdpmc" "")
set(DNNL_USE_MKL HAVE_MKL)
# vim: et ts=4 sw=4 ai
