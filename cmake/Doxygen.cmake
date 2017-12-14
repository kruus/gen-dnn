#===============================================================================
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
# Locates Doxygen and configures documentation generation
#===============================================================================

if(Doxygen_cmake_included)
    return()
endif()
set(Doxygen_cmake_included true)

find_package(Doxygen)
if(DOXYGEN_FOUND)
    set(DOXYGEN_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/reference)
    set(DOXYGEN_STAMP_FILE ${CMAKE_CURRENT_BINARY_DIR}/doc.stamp)
    set(DOXYGEN_STAMP_FILE2 ${CMAKE_CURRENT_BINARY_DIR}/doc2.stamp)
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile.in
        ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
        @ONLY)
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile-cpu.in
        ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile-cpu
        @ONLY)
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/doc/header.html.in
        ${CMAKE_CURRENT_BINARY_DIR}/header.html
        @ONLY)
    file(GLOB_RECURSE HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/include/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/gtests/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/gtests/*.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/gtests/in/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/gtests/in/*.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/gtests/gtest/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/gtests/gtest/*.hpp
        )
    file(GLOB_RECURSE DOX
        ${CMAKE_SOURCE_DIR}/doc/*
        )
    add_custom_command(
        OUTPUT ${DOXYGEN_STAMP_FILE}
        DEPENDS ${HEADERS} ${DOX}
        COMMAND ${DOXYGEN_EXECUTABLE} Doxyfile
        COMMAND cmake -E touch ${DOXYGEN_STAMP_FILE}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating vanilla documentation with Doxygen" VERBATIM)
    add_custom_command(
        OUTPUT ${DOXYGEN_STAMP_FILE2}
        DEPENDS ${HEADERS} ${DOX}
        COMMAND ${DOXYGEN_EXECUTABLE} Doxyfile-cpu
        COMMAND cmake -E touch ${DOXYGEN_STAMP_FILE2}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating jit documentation with Doxygen" VERBATIM)
    add_custom_target(doc DEPENDS ${DOXYGEN_STAMP_FILE} ${DOXYGEN_STAMP_FILE2})
    #install( DIRECTORY DESTINATION share/doc/${LIB_NAME} COMPONENT doc)
    install(
        DIRECTORY ${DOXYGEN_OUTPUT_DIR}
        DESTINATION share/doc/${LIB_NAME} # OPTIONAL is an error in [too old] cmake 2.6.4
        COMPONENT doc
	OPTIONAL)
    # convenience target, so 'make install-doc' does just the doxygen and doc install
    add_custom_target(install-doc
        DEPENDS doc
        COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_COMPONENT=doc -P ${CMAKE_BINARY_DIR}/cmake_install.cmake
        )
endif(DOXYGEN_FOUND)


