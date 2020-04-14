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

if (NOT DNNL_BUILD_EXAMPLES)
    return()
endif()

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
include_directories(${PROJECT_SOURCE_DIR}/examples)

set_if(UNIX LIBM m)

if(DNNLPRIM_ALL)
    file(GLOB_RECURSE sources *.cpp *.c)
else()
    # no primitives (create engine and stream, print hello)
    set(sources "${CMAKE_CURRENT_SOURCE_DIR}/primitives/stream.cpp")

    macro(add_primitive_example var MYLAYER) # followed by filename prefixes
        if(DNNLPRIM_ALL OR DNNLPRIM_${MYLAYER})
            foreach(layer_ ${ARGN})
                append_glob(${var}
                    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/${layer_}*.cpp
                    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/${layer_}*.c
                    )
            endforeach()
        endif()
    endmacro()
    add_primitive_example(sources BATCH_NORMALIZATION batch_normalization)
    add_primitive_example(sources BINARY binary)
    add_primitive_example(sources CONCAT concat)
    add_primitive_example(sources CONVOLUTION convolution)
    #add_primitive_example(sources DECONVOLUTION deconvolution)
    add_primitive_example(sources ELTWISE eltwise)
    add_primitive_example(sources INNER_PRODUCT inner_product)
    add_primitive_example(sources LAYER_NORMALIZATION layer_normalization)
    add_primitive_example(sources LOGSOFTMAX logsoftmax)
    add_primitive_example(sources LRN lrn)
    add_primitive_example(sources MATMUL matmul)
    add_primitive_example(sources POOLING pooling)
    add_primitive_example(sources REORDER reorder)
    add_primitive_example(sources RESAMPLING resampling)
    add_primitive_example(sources RNN lstm)
    add_primitive_example(sources SHUFFLE shuffle)
    add_primitive_example(sources SOFTMAX softmax)
    add_primitive_example(sources SUM sum)
    message(STATUS "\nsources examples:\n${sources}\n")
endif()

foreach(src ${sources})
    file(RELATIVE_PATH src_rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${src})
    string(REGEX REPLACE "[/_\\.]" "-" example_name ${src_rel_path})

    # Put hw-specific part of the name in front.
    # It is important for examples in subdirectories.
    foreach(pat "cpu-" "gpu-" "cross-engine-")
        string(REGEX REPLACE "^(.*)${pat}" "${pat}\\1"
            example_name ${example_name})
    endforeach()

    if(${example_name} MATCHES "(cpu-)")
        # Example name contains cpu-
        register_exe(${example_name} ${src} "test" ${LIBM})
    elseif(${example_name} MATCHES "^(cross-engine|gpu)")
        # Example name contains cross-engine or gpu-
        if (NOT DNNL_GPU_RUNTIME STREQUAL "NONE")
            register_exe(${example_name} ${src} "test" ${LIBM})
        endif()
    else()
        register_exe(${example_name} ${src} "" ${LIBM})

        # Adding test for CPU
        add_test("cpu-${example_name}" "${example_name}" cpu)
        maybe_configure_windows_test("cpu-${example_name}" TEST)

        # Adding test for GPU
        if (NOT DNNL_GPU_RUNTIME STREQUAL "NONE")
           add_test("gpu-${example_name}" "${example_name}" gpu)
           maybe_configure_windows_test("gpu-${example_name}" TEST)
        endif()
    endif()
endforeach()

if (DNNL_INSTALL_MODE STREQUAL "BUNDLE")
    file(GLOB example_sources
         "cpu_*.cpp" "c_*.c" "cnn_*.c" "cnn_*.cpp" "rnn_*.cpp" "*.h*")
    configure_file(CMakeLists.txt.in CMakeLists.txt @ONLY)
    install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/CMakeLists.txt
        ${example_sources}
        DESTINATION examples)
    install(DIRECTORY
        tutorials
        DESTINATION examples)
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        install(FILES
            ${PROJECT_SOURCE_DIR}/cmake/template.vcxproj.user
            DESTINATION examples)
    endif()
endif()
