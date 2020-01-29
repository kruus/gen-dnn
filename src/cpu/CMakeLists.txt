#===============================================================================
# Copyright 2019 Intel Corporation
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

file(GLOB_RECURSE SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
    )

if(NOT TARGET_X86)
    message(STATUS "no x86 JIT: removing all '.*jit.*' source code")
    message(STATUS "\nbegin:\n${SOURCES}\n")
    list(FILTER SOURCES EXCLUDE REGEX ".*(jit|xbyak).*")
    message(STATUS "\nend:\n${SOURCES}\n")
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
if(TARGET_X86)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/xbyak)
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
    # to make computations more stable and to align the jitted code
    # with the reference one use precise division and square root
    # by default
    file(GLOB FILES_REQUIRED_PREC_SQRT
        ${CMAKE_CURRENT_SOURCE_DIR}/*normalization*.cpp)
    file(GLOB FILES_REQUIRED_PREC_DIV
        ${CMAKE_CURRENT_SOURCE_DIR}/*resampling*.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/*normalization*.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ref_rnn.cpp)
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

if(MSVC)
    file(GLOB FILES_REQUIRED_BIGOBJ
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_engine.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_reorder.cpp)
    set_source_files_properties(${FILES_REQUIRED_BIGOBJ}
        PROPERTIES COMPILE_FLAGS "/bigobj")
endif()

file(GLOB HPP_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)

# Hmmm. not quite working? (missing include_directories)
#set(CMAKE_REQUIRED_FLAGS ${CMAKE_CXX_FLAGS})
#set(CMAKE_REQUIRED_INCLUDES ${CMAKE_CXX_FLAGS})
#include(CheckIncludeFileCXX)
#foreach(project_header ${HPP_HEADERS})
#    get_filename_component(header_name ${project_header} NAME_WE)
#    check_include_file_cxx("${project_header}" ${header_name}_IS_STANDALONE)
#endforeach()

set(OBJ_LIB ${LIB_NAME}_cpu)
add_library(${OBJ_LIB} OBJECT ${SOURCES})
set(${LIB_NAME}_SUB_OBJS ${${LIB_NAME}_SUB_OBJS}
    $<TARGET_OBJECTS:${OBJ_LIB}> PARENT_SCOPE)
