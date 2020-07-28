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

file(GLOB SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
    )
if(NOT DNNL_ENABLE_PRIMITIVE_CACHE)
    # x86 jit uses primitive_hashing.  Can we skip primitive_cache entirely?
    # Kinda' -- public API **could** use a much smaller stub, since only
    #      dnnl_set_primitive_cache_capacity
    #      dnnl_get_primitive_cache_capacity
    # are officially needed. `primitive_cache.[hc]pp` can be emptier.
    # TODO More complete stub-ification of primitive_cache.[hc]pp ?
    #list(REMOVE_ITEM SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/primitive_cache.cpp)
endif()

# for simplicity let's include the ve/ stuff "as in full build"
if(NECVE)
    file(GLOB SOURCES_VE
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.c
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/*.cpp
        )
    # Same-Name files in subdirectory REPLACE parent ones:
    #   some cpu-specific code / optimization is too ugly!
    string(REPLACE "/ve/" "/" x_ "${SOURCES_VE}")
    list(REMOVE_ITEM SOURCES ${x_})

    message(STATUS "SOURCES_VE      ${SOURCES_VE}")
    # add VE files to [maybe shortened] SOURCES
    list(APPEND SOURCES ${SOURCES_VE})

    set_source_files_properties(${SOURCES_VE} PROPERTIES COMPILE_FLAGS
        "-I${CMAKE_CURRENT_SOURCE_DIR}/ve -I${CMAKE_CURRENT_SOURCE_DIR}")

    # the following might put -O0 too late in command line ? ?
    file(GLOB FILES_O0
        ${CMAKE_CURRENT_SOURCE_DIR}/reorder.cpp
        )
    set_source_files_properties(${FILES_O0}
        PROPERTIES COMPILE_FLAGS "-O0"
        )

else()
    # optional enhancement: vectorized offset calculations:
    # [OK to never make use of these]
    list(APPEND SOURCES_VE
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/memory_desc_wrapper_opt.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/memory_desc_wrapper_opt.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ve_fastdiv.h
        ${CMAKE_CURRENT_SOURCE_DIR}/ve/ve_fastdiv.c
        )
    set_source_files_properties(${SOURCES_VE} PROPERTIES COMPILE_FLAGS
        "-I${CMAKE_CURRENT_SOURCE_DIR}/ve -I${CMAKE_CURRENT_SOURCE_DIR}")
    list(APPEND SOURCES ${SOURCES_VE})
endif()

set(OBJ_LIB ${LIB_NAME}_common)
add_library(${OBJ_LIB} OBJECT ${SOURCES})
set_property(GLOBAL APPEND PROPERTY DNNL_LIB_DEPS
    $<TARGET_OBJECTS:${OBJ_LIB}>)
