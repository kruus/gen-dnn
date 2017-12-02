#===============================================================================
# Copyright 2017 Intel Corporation
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

# main benchdnn files
#file(GLOB_RECURSE HEADERS
#    ${CMAKE_CURRENT_SOURCE_DIR}/../include/*.h
#    ${CMAKE_CURRENT_SOURCE_DIR}/../include/*.hpp
#    )
#message(STATUS "benchdnn HEADERS are ${HEADERS}") # empty!!
file(GLOB SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/*.h
    )
include_directories( ${CMAKE_CURRENT_SOURCE_DIR} )
# benchdnn subtests
foreach(subdir (conv ip self self/conv))
    file(GLOB subfiles
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.c
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.h
        )
    list(APPEND SOURCES ${subfiles})
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/${subdir})
endforeach()

option(BENCHDNN_USE_RDPMC
    "enables rdpms counter to report precise cpu frequency.
     CAUTION: may not work on all cpus (hence disable by default)"
    OFF) # disabled by default
if(BENCHDNN_USE_RDPMC)
    add_definitions(-DBENCHDNN_USE_RDPMC)
endif()

add_executable(benchdnn ${SOURCES})
if(WIN32)
    configure_file(${CMAKE_SOURCE_DIR}/config_template.vcxproj.user
        benchdnn.vcxproj.user @ONLY)
    set_property(TARGET benchdnn PROPERTY ENVIRONMENT "PATH=${CTESTCONFIG_PATH}")
endif()

set_property(TARGET benchdnn PROPERTY CXX_STANDARD 11)
# [ejk] ease switching between #ifdef'ed code blocks with unused vars/fns
if(NECSX)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pvctl,fullmsg")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pvctl,fullmsg")
else()
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-error")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-error")
endif()

#set_property(TARGET benchdnn PROPERTY C_STANDARD 11)
target_link_libraries(benchdnn ${LIB_NAME} ${EXTRA_LIBS})
if(NECSX) # dirname and strnlen extensions in a special library:
    find_library(LIBGEN libgen) # NEW [ejk] probably need to tweak paths!!!
    message(STATUS, "libgen ?? ${LIBGEN} ...")
    if(LIBGEN)
        target_link_libraries(benchdnn ${LIBGEN})
    else()
        target_link_libraries(benchdnn -lgen)
    endif()
    # Let me try the approach Ishizaka-san uses for milde compilation:
    set_target_properties(benchdnn PROPERTIES
        LINK_FLAGS -Wl,-h,muldefs,-h,lib_cyclic)
elseif(UNIX AND NOT APPLE)
    error_if_SX()
    find_library(LIBRT rt)
    if(LIBRT)
        target_link_libraries(benchdnn ${LIBRT})
    endif()
endif()
# add_test(benchdnn benchdnn)

file(COPY inputs DESTINATION .)
add_custom_target(test_conv
    COMMAND benchdnn --conv --batch=inputs/test_conv_all
    DEPENDS benchdnn
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
if(WIN32)
    configure_file(${CMAKE_SOURCE_DIR}/config_template.vcxproj.user
        test_conv.vcxproj.user @ONLY)
    set_property(TARGET test_conv PROPERTY ENVIRONMENT "PATH=${CTESTCONFIG_PATH}")
endif()
add_custom_target(test_conv_regression
    COMMAND benchdnn --conv --batch=inputs/test_conv_regression
    DEPENDS benchdnn
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
if(WIN32)
    configure_file(${CMAKE_SOURCE_DIR}/config_template.vcxproj.user
        test_conv_regression.vcxproj.user @ONLY)
    set_property(TARGET test_conv_regression PROPERTY ENVIRONMENT "PATH=${CTESTCONFIG_PATH}")
endif()
# vim: et ts=4 sw=4 ai cino=^=l0,\:0,N-s
