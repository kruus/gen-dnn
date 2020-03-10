#===============================================================================
# Copyright 2018-2020 Intel Corporation
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

# Manage different library options
#===============================================================================

if(options_cmake_included)
    return()
endif()
set(options_cmake_included true)

# =======================================
# CPU and JIT boring predefined constants
# =======================================

# possible DNNL_CPU values:
set(DNNL_CPU_X86 1)
set(DNNL_CPU_VE  2)
# Standard ISA values for VANILLA, (lowest non-vanilla), and ALL features
set(DNNL_ISA_VANILLA 1) # ANY and ALL depend on CPU, VANILLA does not

set(DNNL_ISA_X86                10) # VANILLA + no restriction to be C/C++ ref impl
set(DNNL_ISA_X86_ALL            11)
# ve-specific cross-compilation example: add when VANILLA is not enough
set(DNNL_ISA_VE                 30) # ANY + anything VE-specific
set(DNNL_ISA_VE_ALL             30) # ALL==ANY (simplest case)
#
# Semantics:
#
# VANILLA adds the connotation of "cross-platform"
# ANY expands on VANILLA to mean "any variety of this DNNL_CPU".
#     ANY loses the cross-platform connotation.
# ALL implies "all bells and whistles" for this DNNL_CPU.
#     (was 'all', but too easily confused with ANY)

# Set target cpu and DNNL_ISA_{ANY|ALL} constants
if(${CMAKE_SYSTEM_PROCESSOR} MATCHES "^(x86_64|AMD64.*|aarch64.*|AARCH64.*|arm64.*|ARM64.*)")
    # Begin assuming xbyak and jit files are in libdnnl
    set(DNNL_CPU ${DNNL_CPU_X86})
    set(TARGET_X86 1) # shorthand
    set(DNNL_ISA_ANY ${DNNL_ISA_X86})
    set(DNNL_ISA_ALL ${DNNL_ISA_X86_ALL})
elseif(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aurora") # some cpus won't handle x86 jit
    set(TARGET_X86 0)
    set(DNNL_CPU ${DNNL_CPU_VE})
    set(DNNL_ISA_ANY ${DNNL_ISA_VE})
    set(DNNL_ISA_ALL ${DNNL_ISA_VE_ALL})
else()
    message(FATAL_ERROR "Unrecognized target CPU : ${CMAKE_SYSTEM_PROCESSOR}")
endif()

# ===========
# CPU and JIT
# ===========

# You may specify additional CPU target info with cmake -DDNNL_ISA=<string>
# This is used for dnnl_config.h.in
#
set(DNNL_ISA "ALL" CACHE STRING
    "All cpus must support DNNL_ISA=ALL [default] and VANILLA.

    VANILLA removes all x86 jit support and should mostly be pure C/C++.
    These impls should run on any CPU, so can be used with a
    cmake toolchain file to cross-compile libdnnl for non-x86 CPUs.
    ALL means supply all available features. x86 supports all jit targets.
    Non-x86 ALL builds on forked repos can add specialized layers to
    the basic VANILLA build to provide a cpu-specific cpu_engine.")
    if(NOT ${DNNL_ISA} MATCHES "^(VANILLA|ALL)$")
        message(FATAL_ERROR "Unsupported ${CMAKE_SYSTEM_PROCESSOR} variant: DNNL_ISA=${DNNL_ISA}")
    endif()
set(DNNL_ISA_VALUE ${DNNL_ISA_${DNNL_ISA}})
message(STATUS "Target CPU ${CMAKE_SYSTEM_PROCESSOR} has DNNL_CPU=${DNNL_CPU}, and maps DNNL_ISA=${DNNL_ISA} to DNNL_ISA_VALUE=${DNNL_ISA_VALUE}=DNNL_ISA_${DNNL_ISA}")

set(TARGET_X86_JIT 1)
if(NOT TARGET_X86 OR DNNL_ISA STREQUAL "VANILLA")
    set(TARGET_X86_JIT 0)
endif()

# ========
# Features
# ========

option(DNNL_VERBOSE
    "allows DNNL be verbose whenever DNNL_VERBOSE
    environment variable set to 1" ON) # enabled by default

option(DNNL_ENABLE_CONCURRENT_EXEC
    "disables sharing a common scratchpad between primitives.
    This option must be turned ON if there is a possibility of executing
    distinct primitives concurrently.
    CAUTION: enabling this option increases memory consumption."
    OFF) # disabled by default

option(DNNL_ENABLE_PRIMITIVE_CACHE "enables primitive cache.
    WARNING: the primitive cache is an experimental feature and might be
    changed without prior notification in future releases" OFF)
    # disabled by default

option(DNNL_ENABLE_MAX_CPU_ISA
    "enables control of CPU ISA detected by DNNL via DNNL_MAX_CPU_ISA
    environment variable and dnnl_set_max_cpu_isa() function" ON)

# =============================
# Building properties and scope
# =============================

set(DNNL_LIBRARY_TYPE "SHARED" CACHE STRING
    "specifies whether DNNL library should be SHARED or STATIC")
if(NOT ${DNNL_LIBRARY_TYPE} MATCHES "^(SHARED|STATIC)$")
    message(FATAL_ERROR "Unsupported ${DNNL_LIBRARY_TYPE} variant: DNNL_LIBRARY_TYPE=${DNNL_LIBRARY_TYPE}")
endif()
option(DNNL_BUILD_EXAMPLES "builds examples"  ON)
option(DNNL_BUILD_TESTS "builds tests" ON)
option(DNNL_BUILD_FOR_CI "specifies whether DNNL library should be built for CI" OFF)
option(DNNL_WERROR "treat warnings as errors" OFF)

set(DNNL_INSTALL_MODE "DEFAULT" CACHE STRING
    "specifies installation mode; supports DEFAULT or BUNDLE.

    When BUNDLE option is set DNNL will be installed as a bundle
    which contains examples and benchdnn.")
if(NOT ${DNNL_INSTALL_MODE} MATCHES "^(DEFAULT|BUNDLE)$")
    message(FATAL_ERROR "Unsupported ${DNNL_INSTALL_MODE} variant: DNNL_INSTALL_MODE=${DNNL_INSTALL_MODE}")
endif()

set(DNNL_CODE_COVERAGE "OFF" CACHE STRING
    "specifies which supported tool for code coverage will be used
    Currently only gcov supported")
if(NOT ${DNNL_CODE_COVERAGE} MATCHES "^(OFF|GCOV)$")
    message(FATAL_ERROR "Unsupported code coverage tool: ${DNNL_CODE_COVERAGE}")
endif()

# =============
# Optimizations
# =============

set(DNNL_ARCH_OPT_FLAGS "HostOpts" CACHE STRING
    "specifies compiler optimization flags (see below for more information).
    If empty default optimization level would be applied which depends on the
    compiler being used.

    - For Intel(R) C++ Compilers the default option is `-xSSE4.1` which instructs
      the compiler to generate the code for the processors that support SSE4.1
      instructions. This option would not allow to run the library on older
      architectures.

    - For GNU* Compiler Collection and Clang, the default option is `-msse4.1` which
      behaves similarly to the description above.

    - For all other cases there are no special optimizations flags.

    If the library is to be built for generic architecture (e.g. built by a
    Linux distributive maintainer) one may want to specify DNNL_ARCH_OPT_FLAGS=\"\"
    to not use any host specific instructions")

# ======================
# Profiling capabilities
# ======================

option(DNNL_ENABLE_JIT_PROFILING
    "Enable registration of DNNL kernels that are generated at
    runtime with Intel VTune Amplifier (on by default). Without the
    registrations, Intel VTune Amplifier would report data collected inside
    the kernels as `outside any known module`."
    ON)

# ===================
# Engine capabilities
# ===================

set(DNNL_CPU_RUNTIME "OMP" CACHE STRING
    "specifies the threading runtime for CPU engines;
    supports OMP (default) or TBB.

    To use Intel(R) Threading Building Blocks (Intel(R) TBB) one should also
    set TBBROOT (either environment variable or CMake option) to the library
    location.")
if(NOT "${DNNL_CPU_RUNTIME}" MATCHES "^(OMP|TBB|SEQ)$")
    message(FATAL_ERROR "Unsupported CPU runtime: ${DNNL_CPU_RUNTIME}")
endif()

set(TBBROOT "" CACHE STRING
    "path to Intel(R) Thread Building Blocks (Intel(R) TBB).
    Use this option to specify Intel(R) TBB installation locaton.")

set(DNNL_GPU_RUNTIME "NONE" CACHE STRING
    "specifies the runtime to use for GPU engines.
    Can be NONE (default; no GPU engines) or OCL (OpenCL GPU engines).

    Using OpenCL for GPU requires setting OPENCLROOT if the libraries are
    installed in a non-standard location.")
if(NOT "${DNNL_GPU_RUNTIME}" MATCHES "^(OCL|NONE)$")
    message(FATAL_ERROR "Unsupported GPU runtime: ${DNNL_GPU_RUNTIME}")
endif()

set(OPENCLROOT "" CACHE STRING
    "path to Intel(R) SDK for OpenCL(TM).
    Use this option to specify custom location for OpenCL.")

# =============
# Miscellaneous
# =============

option(BENCHDNN_USE_RDPMC
    "enables rdpms counter to report precise cpu frequency in benchdnn.
     CAUTION: may not work on all cpus (hence disabled by default)"
    OFF) # disabled by default

# =========================
# Developer and debug flags
# =========================

set(DNNL_USE_CLANG_SANITIZER "" CACHE STRING
    "instructs build system to use a Clang sanitizer. Possible values:
    Address: enables AddressSanitizer
    Memory: enables MemorySanitizer
    MemoryWithOrigin: enables MemorySanitizer with origin tracking
    Undefined: enables UndefinedBehaviourSanitizer
    This feature is experimental and is only available on Linux.")

option(_DNNL_USE_MKL "use BLAS functions from Intel MKL" OFF)
# vim: ts=4 sw=4 et
