#===============================================================================
# Copyright 2016-2020 Intel Corporation
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

# propagate EXAMPLE specific flags
append(CMAKE_C_FLAGS "${CMAKE_EXAMPLE_CCXX_FLAGS}")
append(CMAKE_CXX_FLAGS "${CMAKE_EXAMPLE_CCXX_FLAGS}")

# propagate sanitizer flags
append(CMAKE_C_FLAGS "${CMAKE_CCXX_SANITIZER_FLAGS}")
append(CMAKE_CXX_FLAGS "${CMAKE_CCXX_SANITIZER_FLAGS}")

# propagate nowarn flags
append(CMAKE_C_FLAGS "${CMAKE_CCXX_NOWARN_FLAGS}")
append(CMAKE_CXX_FLAGS "${CMAKE_CCXX_NOWARN_FLAGS}")

include_directories(${PROJECT_SOURCE_DIR}/include)

set_if(UNIX LIBM m)

if(DNNLPRIM_ALL)
    file(GLOB sources *.cpp *.c)
else()
    if(DNNLPRIM_REORDER AND DNNLPRIM_CONVOLUTION AND DNNLPRIM_ELTWISE AND DNNLPRIM_LRN AND DNNLPRIM_POOL)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cnn_inference_f32.c)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cpu_cnn_training_f32.c)
    endif()
    if(DNNLPRIM_REORDER AND DNNLPRIM_ELTWISE)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cross_engine_reorder.c)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cross_engine_reorder.cpp)
    endif()
    if(DNNLPRIM_REORDER AND DNNLPRIM_CONVOLUTION AND DNNLPRIM_ELTWISE AND DNNLPRIM_LRN AND DNNLPRIM_POOL)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cnn_inference_f32.cpp)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cnn_inference_int8.cpp)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cnn_training_f32.cpp)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cpu_cnn_training_bf16.cpp)
    endif()
    if(DNNLPRIM_RNN)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cpu_rnn_inference_f32.cpp)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/cpu_rnn_inference_int8.cpp)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/rnn_training_f32.cpp)
    endif()
    if(DNNLPRIM_ELTWISE)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/getting_started.cpp)
    endif()
    #if(DNNLPRIM_CONVOLUTION AND DNNLPRIM_POOLING AND DNNLPRIM_REORDER)
    #    list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/memory_format_propagation.cpp)
    #endif()
    if(DNNLPRIM_CONVOLUTION AND DNNLPRIM_ELTWISE)
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/performance_profiling.cpp)
    endif()
    message(STATUS "\nsources examples:\n${sources}\n")
endif()

foreach(src ${sources})
    get_filename_component(src_name ${src} NAME)
    string(REGEX REPLACE "[_\\.]" "-" example_name ${src_name})
    if(${example_name} MATCHES "^(cpu)")
        # Example name contains cpu-
        register_exe(mkldnn-compat-${example_name} ${src} "test" ${LIBM})
    elseif(${example_name} MATCHES "^(cross-engine|gpu)")
        # Example name contains cross-engine or gpu-
        if (NOT DNNL_GPU_RUNTIME STREQUAL "NONE")
            register_exe(mkldnn-compat-${example_name} ${src} "test" ${LIBM})
        endif()
    else()
        register_exe(mkldnn-compat-${example_name} ${src} "" ${LIBM})

        # Adding test for CPU
        add_test("mkldnn-compat-cpu-${example_name}" "mkldnn-compat-${example_name}" cpu)
        maybe_configure_windows_test("mkldnn-compat-cpu-${example_name}" TEST)

        # Adding test for GPU
        if (NOT DNNL_GPU_RUNTIME STREQUAL "NONE")
           add_test("mkldnn-compat-gpu-${example_name}" "mkldnn-compat-${example_name}" gpu)
           maybe_configure_windows_test("mkldnn-compat-gpu-${example_name}" TEST)
        endif()
    endif()
endforeach()

