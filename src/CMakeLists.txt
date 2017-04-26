#===============================================================================
# vim: set ts=4 sw=4 et ftype=cmake
# Copyright 2016-2017 Intel Corporation
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

set(TARGET_NAME ${LIB_NAME})

file(GLOB_RECURSE HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/*.hpp
    )
file(GLOB_RECURSE SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/common/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/common/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/common/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/io/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/io/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/io/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/io/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/${CPU_DIR}/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/${CPU_DIR}/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/${CPU_DIR}/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/${CPU_DIR}/*.hpp
    )
# prefix any directories in CPU_INCLUDE_SUBDIRS with ${CMAKE_CURRENT_SOURCE_DIR}
set(CPU_INCLUDE_DIRS)
string(REGEX REPLACE "([^;]+)" "${CMAKE_CURRENT_SOURCE_DIR}/\\1" CPU_INCLUDE_DIRS "${CPU_INCLUDE_SRC_SUBDIRS}")
message(STATUS " original CPU_INCLUDE_SRC_SUBDIRS : ${CPU_INCLUDE_SRC_SUBDIRS}")
message(STATUS " extra CPU include directories    : ${CPU_INCLUDE_DIRS}")

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/common
    ${CPU_INCLUDE_DIRS}
    #   upstream version ...
    #${CMAKE_CURRENT_SOURCE_DIR}
    #${CMAKE_CURRENT_SOURCE_DIR}/common
    #${CMAKE_CURRENT_SOURCE_DIR}/cpu/xbyak
    )

if(MECSX)
	add_library(${TARGET_NAME}        ${HEADERS} ${SOURCES})
else()
    add_library(${TARGET_NAME} SHARED ${HEADERS} ${SOURCES})
endif()
message(STATUS "${TARGET_NAME}_LINKER_LIBS = ${${TARGET_NAME}_LINKER_LIBS}")
target_link_libraries(${TARGET_NAME} ${${TARGET_NAME}_LINKER_LIBS})
set_property(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD 11)
set_property(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD_REQUIRED ON)
#if(NECSX)
#    set_target_properties(${LIB_NAME} PROPERTIES LINKER_LANGUAGE CXX)
#    message(STATUS "src/ CMAKE_CXX_COMPILER = ${CMAKE_CXX_COMPILER}")
#endif()

install(TARGETS ${TARGET_NAME} DESTINATION lib COMPONENT bin)
install(FILES ${HEADERS} DESTINATION include COMPONENT dev)
