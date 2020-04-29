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

# Auxiliary build functions
#===============================================================================

if(utils_cmake_included)
    return()
endif()
set(utils_cmake_included true)
include("cmake/options.cmake")

# Common configuration for tests / test cases on Windows
function(maybe_configure_windows_test name kind)
    if(WIN32 AND (NOT DNNL_BUILD_FOR_CI))
        string(REPLACE  ";" "\;" PATH "${CTESTCONFIG_PATH};$ENV{PATH}")
        set_property(${kind} ${name} PROPERTY ENVIRONMENT "PATH=${PATH}")
        if(TARGET ${name} AND CMAKE_GENERATOR MATCHES "Visual Studio")
            configure_file(${PROJECT_SOURCE_DIR}/cmake/template.vcxproj.user
                ${name}.vcxproj.user @ONLY)
        endif()
    endif()
endfunction()

# Register new executable/test
#   name -- name of the executable
#   srcs -- list of source, if many must be enclosed with ""
#   test -- "test" to mark executable as a test, "" otherwise
#   arg4 -- (optional) list of extra library dependencies
function(register_exe name srcs test)
    add_executable(${name} ${srcs})
    target_link_libraries(${name} ${LIB_NAME} ${EXTRA_SHARED_LIBS} ${ARGV3})
    if("x${test}" STREQUAL "xtest")
        add_test(${name} ${name})
        maybe_configure_windows_test(${name} TEST)
    else()
        maybe_configure_windows_test(${name} TARGET)
    endif()
endfunction()

# Append to a variable
#   var = var + value
macro(append var value)
    set(${var} "${${var}} ${value}")
endmacro()

# Set variable depending on condition:
#   var = cond ? val_if_true : val_if_false
macro(set_ternary var condition val_if_true val_if_false)
    if (${condition})
        set(${var} "${val_if_true}")
    else()
        set(${var} "${val_if_false}")
    endif()
endmacro()

# Conditionally set a variable
#   if (cond) var = value
macro(set_if condition var value)
    if (${condition})
        set(${var} "${value}")
    endif()
endmacro()

# Conditionally append
#   if (cond) var = var + value
macro(append_if condition var value)
    if (${condition})
        append(${var} "${value}")
    endif()
endmacro()

# Append a path to path_list variable (Windows-only version)
macro(append_to_windows_path_list path_list path)
    file(TO_NATIVE_PATH "${path}" append_to_windows_path_list_tmp__)
    if(${path_list})
        set(${path_list}
            "${${path_list}};${append_to_windows_path_list_tmp__}")
    else()
        set(${path_list}
            "${append_to_windows_path_list_tmp__}")
    endif()
endmacro()

function(target_link_libraries_build target list)
    # Foreach is required for compatibility with 2.8.11 ways
    foreach(lib ${list})
        target_link_libraries(${target} LINK_PUBLIC
            "$<BUILD_INTERFACE:${lib}>")
    endforeach(lib)
endfunction()

function(target_link_libraries_install target list)
    # Foreach is required for compatibility with 2.8.11 ways
    foreach(lib ${list})
        get_filename_component(base "${lib}" NAME)
        target_link_libraries(${target} LINK_PUBLIC
            "$<INSTALL_INTERFACE:${base}>")
    endforeach(lib)
endfunction()

# ----- added functions [EXTRA] -------
# list_filter_exclude(<list> <regexp>)
# behave like list(FILTER <list> EXCLUDE REGEX <regexp>)
macro(list_filter_exclude _list _regexp)
    set(_kept)
    foreach(_item ${${_list}})
        string(REGEX MATCH "${_regexp}" _ok "${_item}")
        if(NOT _ok)
            list(APPEND _kept "${_item}")
        endif()
    endforeach()
    set(${_list} "${_kept}")
endmacro()

# helpers to expand list 'var' of source files...
macro(append_glob var)
    file(GLOB _x ${ARGN})
    list(APPEND ${var} ${_x})
endmacro()
macro(append_glob_jit var)
    if(TARGET_X86_JIT)
        file(GLOB _x ${ARGN})
        list(APPEND ${var} ${_x})
    endif()
endmacro()
macro(append_subdir_recurse var subdir)
    file(GLOB_RECURSE _x
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.c
        ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/*.cpp
        )
    list(APPEND ${var} ${_x})
endmacro()
macro(exclude_jit var)
    if(NOT TARGET_X86_JIT)
        list_filter_exclude(${var} "jit.*")
    endif()
endmacro()

