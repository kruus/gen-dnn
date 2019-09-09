#===============================================================================
# Copyright 2017-2018 Intel Corporation
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

# Manage secure Development Lifecycle-related compiler flags
#===============================================================================

if(SDL_cmake_included)
    return()
endif()
set(SDL_cmake_included true)

set(CMAKE_CCXX_FLAGS)
message(STATUS "CXX_FLAGS begin SDL.cmake : ${CMAKE_CXX_FLAGS}")
if(NECSX)
    message(STATUS "more SX stuff can go here")
    message(STATUS "testing : CMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}")
    #set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fopenmp")
    #set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -f90lib")
    #
    # disable to force examples through ref_convolution.cpp code...
    ###set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -DUSE_CBLAS")
    #
    #set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -Wl,-M") # or maybe as linker flags?
    set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -wfatal=47")     # macro redefinition
    set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -woff=1")        # last line of input file doesn't end with newline
    #
    # sxc++ with -Cnoopt or -Cdebug CHANGES SEMANTICS OF snprintf
    # Soln:
    #  do not use -Cdebug or -Cnoopt
    #set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -DBAD_SNPRINTF") # return value of snprintf does not follow c99/c++11 conventions

    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_CCXX_FLAGS} ${SX_CFLAGS_C99}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CCXX_FLAGS} ${SX_CXXFLAGS_C11}")
    # MathKeisan libs: additional link libs set in src/CMakeLists.txt
    list(APPEND mkldnn_LINKER_LIBS ${SX_LINK_LIBRARIES})    # ex. -llapack -lcblas -lblas -lm
    # cmake propagates the library dependencies to any targets
    # that depend on the build mkldnn target

    message(STATUS "testing : CMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}")

elseif(UNIX OR APPLE)
    if(NECVE)
        #set(CMAKE_CCXX_FLAGS "-fPIC") # why do I need this
    else()
        set(CMAKE_CCXX_FLAGS "-fPIC -Wformat -Wformat-security")
    endif()
    if(NECVE)
    else()
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -D_FORTIFY_SOURCE=2")
        set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -D_FORTIFY_SOURCE=2")
    endif()
    if(NECVE) # no -fstack-protector option (masquerades as GNUL 6.0.0)
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.9)
            set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fstack-protector-all")
        else()
            set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fstack-protector-strong")
        endif()

        # GCC might be very paranoid for partial structure initialization, e.g.
        #   struct { int a, b; } s = { 0, };
        # However the behavior is triggered by `Wmissing-field-initializers`
        # only. To prevent warnings on users' side who use the library and turn
        # this warning on, let's use it too. Applicable for the library sources
        # and interfaces only (tests currently rely on that fact heavily)
	# [ejk] Good: SX and VE compilers sometimes will set missing POD init
	#             with garbage values.  These compilers are buggy.
        set(CMAKE_SRC_CCXX_FLAGS "${CMAKE_SRC_CCXX_FLAGS} -Wmissing-field-initializers")
        set(CMAKE_EXAMPLE_CCXX_FLAGS "${CMAKE_EXAMPLE_CCXX_FLAGS} -Wmissing-field-initializers")
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        set(CMAKE_CCXX_FLAGS "${CMAKE_CCXX_FLAGS} -fstack-protector-all")
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fstack-protector")
    endif()
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_CCXX_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CCXX_FLAGS}")
    if(APPLE)
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-bind_at_load")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-bind_at_load")
    else()
        if(NOT NECVE)
            set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pie")
        endif()
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now")
    endif()
endif()
message(STATUS "CXX_FLAGS end SDL.cmake : ${CMAKE_CXX_FLAGS}")
