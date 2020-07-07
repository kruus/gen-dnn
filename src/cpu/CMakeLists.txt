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

if(DNNLPRIM_ALL)
    file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*.[ch]pp)
    file(GLOB_RECURSE SOURCES_EXTRA
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm/*.[ch]pp
        ${CMAKE_CURRENT_SOURCE_DIR}/matmul/*.[ch]pp
        ${CMAKE_CURRENT_SOURCE_DIR}/rnn/*.[ch]pp
        )
    foreach(SOURCE_FILE ${SOURCES_EXTRA})
        list(APPEND SOURCES "${SOURCE_FILE}")
    endforeach()
else() ####### CLEARLY WRONG AFTER DIRECTORY REORGANIZATION
    # Debug : include primitives piecewise into libdnnl
    file(GLOB SOURCES_CORE
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_engine*
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_memory_storage*
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_stream*
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_isa_traits*
        # engine also requires impl list getters,
        # even if only to provide empty impl lists
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_sum.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_reorder.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_concat.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/platform.cpp
        )
    if(TARGET_X86_JIT)
        append_subdir_recurse(SOURCES_CORE xbyak)
        append_glob(SOURCES_CORE ${CMAKE_CURRENT_SOURCE_DIR}/jit_utils/jit_utils*)
        if(DNNL_ENABLE_JIT_PROFILING)
            append_subdir_recurse(SOURCES_CORE jit_utils/jitprofiling)
            append_subdir_recurse(SOURCES_CORE jit_utils/linux_perf)
        endif()
    endif()
    
    message(STATUS "\nsources cpu core:\n${SOURCES_CORE}\n")
    set(SOURCES_PRIM "")
    set(_eltwise_help OFF)
    if(DNNLPRIM_ALL OR DNNLPRIM_BATCH_NORMALIZATION)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_batch_normalization*
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_batch_normalization*
            ${CMAKE_CURRENT_SOURCE_DIR}/ncsp_batch_normalization*
            ${CMAKE_CURRENT_SOURCE_DIR}/nspc_batch_normalization*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_barrier*
            ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*batch_normalization*
            )

    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_BINARY) # implies eltwise
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/binary/cpu*
            ${CMAKE_CURRENT_SOURCE_DIR}/binary/ref*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/binary/jit*
            )
        set(_eltwise_help ON)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_CONVOLUTION) # implies REORDER
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_convolution*
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_convolution*
            ${CMAKE_CURRENT_SOURCE_DIR}/gemm*_convolution*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_barrier*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_reducer* # cpu_accumulator_1d_t
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*_conv*
            ${CMAKE_CURRENT_SOURCE_DIR}/jit_transpose_src_utils*
            )
        set(_gemm ON)
        set(_eltwise_help ON)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_DECONVOLUTION) # imples CONVOLUTION and REORDER
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_deconvolution*
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_deconvolution*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*deconvolution*
            )
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_ELTWISE)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_eltwise*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit_uni_eltwise.*
            )
        set(_eltwise_help ON)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_GEMM) # no a primitive, but in public api
        set(_gemm ON)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_INNER_PRODUCT) # implies REORDER amd ELTWISE
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_inner_product*
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_inner_product*
            ${CMAKE_CURRENT_SOURCE_DIR}/gemm*_inner_product*
            )
        set(_gemm ON)
        set(_eltwise_help ON)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_REORDER)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_reorder*
            ${CMAKE_CURRENT_SOURCE_DIR}/simple_reorder*
            ${CMAKE_CURRENT_SOURCE_DIR}/wino_reorder*
            ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
            )
        if(DNNLPRIM_ALL OR DNNLPRIM_RNN)
            # rnn/rnn_reorders.hpp pulls in sgemm_pack (or gemm_bf16bf16f32_pack)
            # and the pack routines call gemm_driver, so add full gemm lib
            set(_gemm ON)
        endif()
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*reorder*
            )
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_LAYER_NORMALIZATION)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_layer_normalization*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_layer_normalization*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*_layer_normalization*
            )
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_LRN)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_lrn*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_lrn*
            ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*_lrn*
            )
        set(_gemm ON) # dnnl::impl::cpu::sgemm_pack, gemm_s8u8s32_pack (for primitives test)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_MATMUL)
        append_subdir_recurse(SOURCES_CORE matmul)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_inner_product*
            ${CMAKE_CURRENT_SOURCE_DIR}/gemm*_inner_product*
            )
        set(_gemm ON)
        set(_eltwise_help ON)
        # weed out *jit* down below (could do this for other cases too)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_POOLING)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_pooling*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_pooling*
            ${CMAKE_CURRENT_SOURCE_DIR}/nchw_pooling*
            ${CMAKE_CURRENT_SOURCE_DIR}/nhwc_pooling*
            ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*_pool*
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*_reorder*
            )
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_RESAMPLING)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/resampling/*
            ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
            )
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_RNN)
        if(TARGET_X86_JIT)
            append_subdir_recurse(SOURCES_CORE rnn)
            append_glob(SOURCES_PRIM
                ${CMAKE_CURRENT_SOURCE_DIR}/jit_uni_eltwise_injector.*
                ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
                )
        else()
            append_glob(SOURCES_PRIM
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/cpu*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/ref*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/rnn*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/cell*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/f32/gemm_utils*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/f32/ref_gemm_f32*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/f32/common*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/s8x8s32/ref_gemm_s8x8s32*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/s8x8s32/simple_gemm_s8s8s32*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/s8x8s32/common*
                ${CMAKE_CURRENT_SOURCE_DIR}/rnn/jit_uni_rnn_common_postgemm_dispatcher.hpp
                ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
                # no eltwise for ref
                )
        endif()
        set(_gemm ON)
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_SHUFFLE)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_shuffle*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_shuffle*
            )
        # no jit version
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_SOFTMAX)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_softmax*
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_softmax*
            # no eltwise postops?
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*softmax*
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*eltwise_injector*
            )
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_CONCAT)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_concat*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_concat*
            ${CMAKE_CURRENT_SOURCE_DIR}/simple_concat*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*_concat*
            )
    endif()
    if(DNNLPRIM_ALL OR DNNLPRIM_SUM)
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_sum*
            ${CMAKE_CURRENT_SOURCE_DIR}/cpu_sum*
            ${CMAKE_CURRENT_SOURCE_DIR}/simple_sum*
            ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit*_sum*
            )
    endif()
    if(_eltwise_help) # Postops may use ref_eltwise [or jit_eltwise_injector]
        append_glob(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/ref_eltwise*
            ${CMAKE_CURRENT_SOURCE_DIR}/bfloat16*
            )
        append_glob_jit(SOURCES_PRIM
            ${CMAKE_CURRENT_SOURCE_DIR}/jit_uni_eltwise_injector.*
            )
    endif() 
    if(_gemm)
        if(TARGET_X86_JIT)
            append_subdir_recurse(SOURCES_CORE gemm)
        else()
            append_glob(SOURCES_PRIM
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/*.hpp
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/*.cpp
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/f32/gemm_utils*
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/f32/ref_gemm_f32*
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/f32/common*
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/s8x8s32/ref_gemm_s8x8s32*
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/s8x8s32/simple_gemm_s8s8s32*
                ${CMAKE_CURRENT_SOURCE_DIR}/gemm/s8x8s32/common*
                )
        endif()
    endif()
    message(STATUS "\nsources cpu prim:\n${SOURCES_PRIM}\n")
    set(SOURCES ${SOURCES_CORE} ${SOURCES_PRIM})
    message(STATUS "\nsources cpu     :\n${SOURCES}\n")
endif()

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
    # Same-Name cpp files in subdirectory REPLACE parent ones:
    #   some cpu-specific code / optimization is too ugly!
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
        #${CMAKE_CURRENT_SOURCE_DIR}/*resampling.cpp
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
