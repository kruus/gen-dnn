#===============================================================================
# Copyright 2019-2020 Intel Corporation
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

file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*.[ch]pp)
file(GLOB_RECURSE SOURCES_EXTRA
    ${CMAKE_CURRENT_SOURCE_DIR}/gemm/*.[ch]pp
    ${CMAKE_CURRENT_SOURCE_DIR}/matmul/*.[ch]pp
    ${CMAKE_CURRENT_SOURCE_DIR}/rnn/*.[ch]pp
    )
foreach(SOURCE_FILE ${SOURCES_EXTRA})
    list(APPEND SOURCES "${SOURCE_FILE}")
endforeach()

# vanilla-x86 and non-x86 targets should ignore all x86 jit files
#if(NOT TARGET_X86_JIT)
#    message(STATUS "no x86 JIT: removing all '.*jit.*' source code")
#    message(STATUS "\nbegin:\n${SOURCES}\n")
#    #list(FILTER SOURCES EXCLUDE REGEX ".*(jit|xbyak).*") # not in older cmake
#    list_filter_exclude(SOURCES ".*(jit|xbyak).*") # equiv. as macro
#    message(STATUS "\nend:\n${SOURCES}\n")
#endif()
#list(REMOVE_DUPLICATES SOURCES)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
if(TARGET_X86_JIT)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/xbyak)
endif()

if(NECVE)
    file(GLOB SOURCES_VE
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.c
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.cpp
        )

    # OPTIONAL: split cpu_reorder impl list into smaller compilations?
    # (after split full rebuild in under half an hour, MUCH faster)
    #  however, this creates segfaults
    #  possibly the compiler turning of ipa in the monolithic compile
    #  is helping avoid bugs ?
    if(0) # original monolithic list [very long nc++ compile time]
        # "safe" (nc++ aborts ipa optimization at some point, good!)
        list_filter_exclude(SOURCES_VE ".*cpu_reorder.*")
    else() # split impl maps by map value. Fast compile,
        # but nc++ ipa may introduce seg faults.  Monotlithic compile
        # turns off ipa optimization (too many functions).
        list(REMOVE_ITEM SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/cpu_reorder.cpp)
    endif()

    # Same-Name cpp files in subdirectory REPLACE parent ones:
    #   some cpu-specific code / optimization is too ugly for src/cpu/
    string(REPLACE "/ve/" "/" x_ "${SOURCES_VE}")
    list(REMOVE_ITEM SOURCES ${x_})

    message(STATUS "SOURCES_VE      ${SOURCES_VE}")
    # add VE files to [maybe shortened] SOURCES
    file(GLOB HEADERS_VE
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.hpp
        )
    list(APPEND SOURCES ${SOURCES_VE} ${HEADERS_VE})
    # note: headers do not REPLACE because of likelihood of confusion
    #     : parent xxx.hpp header must include the ve/xxx.hpp one case by case

    set_source_files_properties(${SOURCES_VE} PROPERTIES COMPILE_FLAGS
        "-I${CMAKE_CURRENT_SOURCE_DIR}/ve -I${CMAKE_CURRENT_SOURCE_DIR}")
else()
    # perhaps allow testing some ve/ enhancements on x86
    # [OK to never make use of these]
    #list(APPEND SOURCES_VE
    #    ${CMAKE_CURRENT_SOURCE_DIR}/ve/memory_desc_wrapper_opt.hpp
    #    ${CMAKE_CURRENT_SOURCE_DIR}/ve/memory_desc_wrapper_opt.cpp
    #    ${CMAKE_CURRENT_SOURCE_DIR}/ve/ve_fastdiv.h
    #    ${CMAKE_CURRENT_SOURCE_DIR}/ve/ve_fastdiv.c
    #    )
    #set_source_files_properties(${SOURCES_VE} PROPERTIES COMPILE_FLAGS
    #    "-I${CMAKE_CURRENT_SOURCE_DIR}/ve -I${CMAKE_CURRENT_SOURCE_DIR}")
    #list(APPEND SOURCES ${SOURCES_VE})
endif()

# Don't build sources from linux_perf direcotry if JIT Profiling isn't enabled.
# NOTE: On AArch64 builds. DNNL_ENABLE_JIT_PROFILING=OFF by default.
if(NOT DNNL_ENABLE_JIT_PROFILING)
    list(FILTER SOURCES EXCLUDE REGEX "linux_perf")
endif()

if(NECVE)
    file(GLOB FILES_REDUCE_INLINING
        ${CMAKE_CURRENT_SOURCE_DIR}/simple_resampling.cpp
        )
    message(STATUS "FILES_REDUCE_INLINING = ${FILES_REDUCE_INLINING}")
    # error:
    # !(cd /home/kruus/vanilla-dbg/build-vejd/src/cpu && /opt/nec/ve/bin/nc++  -DDNNL_DLL -DDNNL_DLL_EXPORTS
    # -DDNNL_ENABLE_CONCURRENT_EXEC -DDNNL_ENABLE_MAX_CPU_ISA -DDNNL_VE=1 -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS
    # -I/home/kruus/vanilla-dbg/include -I/home/kruus/vanilla-dbg/build-vejd/include -I/home/kruus/vanilla-dbg/src
    # -I/home/kruus/vanilla-dbg/src/cpu  -include stdint.h -minit-stack=zero -Wunknown-pragma -report-all
    # -O4 -finline -finline-functions -finline-max-function-size=300 -finline-max-depth=5 -finline-max-times=20
    # -ftemplate-depth=50 -fdiag-inline=2 -fdiag-vector=2 -mno-parallel -DCBLAS_LAYOUT=CBLAS_ORDER
    # -DDNNL_VALUE_INITIALIZATION_BUG -pthread -std=gnu++14 -fopenmp   -D_SDL_beg -fPIC -D_FORTIFY_SOURCE=0 -D_SDL_end
    #    -O4 -g -DNDEBUG   -o CMakeFiles/dnnl_cpu.dir/simple_resampling.cpp.o
    # -c /home/kruus/vanilla-dbg/src/cpu/simple_resampling.cpp) && echo YAY || echo OHOH
    set_source_files_properties(${FILES_REDUCE_INLINING}
        PROPERTIES COMPILE_FLAGS "-finline-max-depth=4")

    file(GLOB FILES_BIG_INLINING
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ncsp_batch_normalization.cpp
        #${CMAKE_CURRENT_SOURCE_DIR}/ve/nspc_batch_normalization.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/nhwc_pooling.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ref_binary.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_convolution.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ref_convolution*.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ref_eltwise.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_inner_product.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_layer_normalization.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ref_lrn.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_pooling.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ref_pooling.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_resampling.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_softmax.cpp
        )
    set_source_files_properties(${FILES_BIG_INLINING}
        PROPERTIES COMPILE_FLAGS "-finline-max-function-size=12288")

    #file(GLOB FILES_O0
    #    ${CMAKE_CURRENT_SOURCE_DIR}/ve/ref_convolution_bwd_w.cpp
    #    )
    #set_source_files_properties(${FILES_O0}
    #    PROPERTIES COMPILE_FLAGS "-O0")

    file(GLOB_RECURSE FILES_NO_VECTOR_INTRINSIC_CHECK
        ${CMAKE_CURRENT_SOURCE_DIR}/ncsp_batch_normalization.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/nspc_batch_normalization.cpp)
    message(STATUS "FILES_NO_VECTOR_INTRINSIC_CHECK = ${FILES_NO_VECTOR_INTRINSIC_CHECK}")
    # nc++ "compiler error" if use -mvector-intrinsic-check option [append default option]
    set_source_files_properties(${FILES_NO_VECTOR_INTRINSIC_CHECK}
        PROPERTIES COMPILE_FLAGS "-mno-vector-intrinsic-check")
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
    # to make computations more stable and to align the jitted code
    # with the reference one use precise division and square root
    # by default
    file(GLOB FILES_REQUIRED_PREC_SQRT
        ${CMAKE_CURRENT_SOURCE_DIR}/*normalization*.cpp
        )
    file(GLOB FILES_REQUIRED_PREC_DIV
        ${CMAKE_CURRENT_SOURCE_DIR}/*resampling*.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/*normalization*.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_eltwise.cpp
        )
    if(WIN32)
        set_source_files_properties(${FILES_REQUIRED_PREC_SQRT}
            PROPERTIES COMPILE_FLAGS "/Qprec-sqrt")
        set_source_files_properties(${FILES_REQUIRED_PREC_DIV}
            PROPERTIES COMPILE_FLAGS "/Qprec-div")
    else()
        set_source_files_properties(${FILES_REQUIRED_PREC_SQRT}
            PROPERTIES COMPILE_FLAGS "-prec-sqrt")
        set_source_files_properties(${FILES_REQUIRED_PREC_DIV}
            PROPERTIES COMPILE_FLAGS "-prec-div")
    endif()
endif()

if(MSVC AND (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" OR CMAKE_CXX_COMPILER_ID STREQUAL "Intel"))
    file(GLOB FILES_REQUIRED_BIGOBJ
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_engine.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_reorder.cpp)
    set_source_files_properties(${FILES_REQUIRED_BIGOBJ}
        PROPERTIES COMPILE_FLAGS "/bigobj")
endif()

set(OBJ_LIB ${LIB_NAME}_cpu)
add_library(${OBJ_LIB} OBJECT ${SOURCES})
set_property(GLOBAL APPEND PROPERTY DNNL_LIB_DEPS
    $<TARGET_OBJECTS:${OBJ_LIB}>)

if (DNNL_TARGET_ARCH STREQUAL "X64")
    add_subdirectory(x64)
endif()
# vim: set sw=4 ts=4 et
