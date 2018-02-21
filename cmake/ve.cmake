# this one is important
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aurora)
set(NECVE 1 CACHE BOOL "Set thing up for NEC Aurora vector processor")

macro(DETERMINE_NCC_SYSTEM_INCLUDES_DIRS _compiler _flags _incVar _preincVar)
    #
    # TODO return more useful things, since this can be run very very early,
    #      and might be more trustworthy than hardwired path guesses.
    # Input:
    #           _compiler  : ncc or nc++ [or nfort?]
    #           _flags     : compiler flags
    # Output:
    #           _incVar    : list of compiler include paths (-isystem)
    #           _preincVar : list of compiler pre-include paths
    #
    #    ncc -v -E -x c++ dummy 1>/dev/null
    #       /opt/nec/ve/ncc/0.0.28/libexec/ccom -cpp -v -E -dD
    #         -isystem /opt/nec/ve/ncc/0.0.28/include
    #         -isystem /opt/nec/ve/musl/include
    #         --preinclude-path /opt/nec/ve/ncc/0.0.28/include
    #         -x c++ dummy
    # or [TODO] nfort -v -E dummy 1>/dev/null
    #       /opt/nec/ve/nfort/0.0.28/libexec/fpp -I. -p
    #         -I/opt/nec/ve/nfort/0.0.28/include
    #         -I/opt/nec/ve/musl/include
    #         dummy
    set(_verbose 3)
    # Oh, CMAKE_C/CXX_foo might not be set yet.
    #if(_verbose GREATER 0)
    #    message(STATUS "  CMAKE_C_COMPILER_ID           : ${CMAKE_C_COMPILER_ID}")
    #    message(STATUS "  CMAKE_CXX_COMPILER_ID           : ${CMAKE_CXX_COMPILER_ID}")
    #endif()
    #if(NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
    #    message(WARNING "CXX compiler not GNU, so may not be able to determine CXX sys includes")
    #endif()
    file(WRITE "${CMAKE_BINARY_DIR}/CMakeFiles/dummy" "\n")
    separate_arguments(_buildFlags UNIX_COMMAND "${_flags}")
    #execute_process(COMMAND ${_compiler} ${_buildFlags} -v -E dummy
    set(_cmd ${_compiler} -v -E dummy)
    execute_process(COMMAND ${_cmd}
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/CMakeFiles"
        OUTPUT_QUIET
        #OUTPUT_VARIABLE _compOut0 # could be useful if use -dM
        ERROR_VARIABLE _compOut)
    file(REMOVE "${CMAKE_BINARY_DIR}/CMakeFiles/dummy")
    separate_arguments(_compArgs UNIX_COMMAND "${_compOut}")
    if(_verbose GREATER 1)
        message(STATUS "_compiler   : ${_compiler}")
        message(STATUS "_flags      : ${_flags}")
        message(STATUS "_buildflags : ${_buildflags}")
        #message(STATUS "_compOut0   : ${_compOut0}")
        message(STATUS "_compOut    : ${_compOut}")
        message(STATUS "_compArgs   : ${_compArgs}")
    endif()
    set(_nextType "boring")
    list(GET _compArgs 0 _ccom) # e.g. /opt/nec/ve/ncc/0.0.28/libexec/ccom
    message(STATUS "_ccom ${_ccom}")
    get_filename_component(_compRoot ${_ccom} DIRECTORY)
    get_filename_component(_compRoot ${_compRoot} DIRECTORY)
    message(STATUS "_compRoot ${_compRoot}")
    if(_verbose GREATER 0)
        if(EXISTS ${_compRoot}/etc/ncc.conf)
            file(READ ${_compRoot}/etc/ncc.conf _etc_ncc_conf)
            message(STATUS "${_compRoot}/etc/ncc.conf\n${_etc_ncc_conf}")
        endif()
    endif()
    foreach(_compArg ${_compArgs})
        if(_verbose GREATER 2)
            message(STATUS "_nextType=${nextType}, _compArg=${_compArg}")
        endif()
        if(${_nextType} STREQUAL "-isystem")
            list(APPEND ${_incVar} ${_compArg})
            set(_nextType "boring")
        elseif(${_compArg} STREQUAL "-isystem")
            set(_nextType ${_compArg})
        endif()
    endforeach()
    foreach(_compArg ${_compArgs})
        if(_verbose GREATER 2)
            message(STATUS "_nextType=${nextType}, _compArg=${_compArg}")
        endif()
        if(${_nextType} STREQUAL "--preinclude-path")
            list(REMOVE_ITEM ${_incVar} ${_compArg})
            list(APPEND ${_preincVar} ${_compArg})
            set(_nextType "boring")
        elseif(${_compArg} STREQUAL "--preinclude-path")
            set(_nextType ${_compArg})
        endif()
    endforeach()
    if(_verbose GREATER 0)
        message(STATUS "Compiler       : ${_compiler}")
        message(STATUS "  Flags        : ${_compiler}")
        message(STATUS "  pre-includes : ${${_preincVar}}")
        message(STATUS "  sys-includes : ${${_incVar}}")
    endif()
endmacro()

# specify the cross compiler
# Output:
#      CMAKE_C_COMPILER    CMAKE_CXX_COMPILER   [ex. ncc nc++]
#

# [2] can we get 'ncc' characteristics when executed in currect shell?
#     If so, this might be better than any hard-wired path we might wish to use.
# [a] if $CC is some ncc, use that; else use 'ncc'
set(_compiler FALSE)
if(EXISTS "$ENV{CC}")
    execute_process(COMMAND $ENV{CC} --version OUTPUT_QUIET ERROR_VARIABLE _ccVersion)
    if(${_ccVersion} MATCHES "^ncc")
        set(_compiler $ENV{CC})
    endif()
endif()
if(NOT _compiler) # OK, CC is not an ncc.  Is there an 'ncc' in current path?
    # do not use find_program (search paths not set yet)
    execute_process(COMMAND ncc --version OUTPUT_QUIET ERROR_VARIABLE _ccVersion)
    if(${_ccVersion} MATCHES "^ncc")
        set(_compiler "ncc")
    endif()
endif()
if(_compiler)
    DETERMINE_NCC_SYSTEM_INCLUDES_DIRS(ncc "-pthread" VE_C_SYSINC VE_C_PREINC)
    message(STATUS "ve.cmake [test]:  C pre-inc dirs  : ${VE_C_PREINC}")
    message(STATUS "ve.cmake [test]:  C sys-inc dirs  : ${VE_C_SYSINC}")
    set(VE_C_PREINC ${VE_C_PREINC} CACHE INTERNAL "ncc pre-include directory[ies]")
    set(VE_C_SYSINC ${VE_C_SYSINC} CACHE INTERNAL "ncc sys-include directory[ies]")
    # oh, next 2 do not exist yet
    #list(INSERT CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES 0 ${_VE_C_PREINC})
    #list(APPEND CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES ${_VE_C_SYSINC})
    #message(STATUS "ve.cmake [test]:  CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES ${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES}")
    set(CMAKE_C_COMPILER   ${_compiler})
else()
    # unverified standard compiler names
    set(CMAKE_C_COMPILER   ncc)
endif()
set(_compiler FALSE)
if(EXISTS "$ENV{CXX}")
    execute_process(COMMAND $ENV{CXX} --version OUTPUT_QUIET ERROR_VARIABLE _ccVersion)
    if(${_ccVersion} MATCHES "^nc\\+\\+")
        set(_compiler $ENV{CXX})
    endif()
endif()
if(NOT _compiler) # OK, CC is not an ncc.  Is there an 'ncc' in current path?
    # do not use find_program (search paths not set yet)
    execute_process(COMMAND nc++ --version OUTPUT_QUIET ERROR_VARIABLE _ccVersion)
    if(${_ccVersion} MATCHES "^nc\\+\\+")
        set(_compiler "nc++")
    endif()
endif()
if(_compiler)
    DETERMINE_NCC_SYSTEM_INCLUDES_DIRS(nc++ "-pthread" VE_CXX_SYSINC VE_CXX_PREINC)
    message(STATUS "ve.cmake [test]:  C pre-inc dirs  : ${VE_CXX_PREINC}")
    message(STATUS "ve.cmake [test]:  C sys-inc dirs  : ${VE_CXX_SYSINC}")
    set(VE_CXX_PREINC ${VE_CXX_PREINC} CACHE INTERNAL "nc++ pre-include directory[ies]")
    set(VE_CXX_SYSINC ${VE_CXX_SYSINC} CACHE INTERNAL "nc++ sys-include directory[ies]")
    message(STATUS "ve.cmake [test]:  C pre-inc dirs  : ${VE_CXX_PREINC}")
    message(STATUS "ve.cmake [test]:  C sys-inc dirs  : ${VE_CXX_SYSINC}")
    set(CMAKE_CXX_COMPILER   ${_compiler})
else()
    set(CMAKE_CXX_COMPILER   ncc)
endif()
unset(_compiler)

#  There are some options here:
#   [1] [current] check VE_OPT (maybe from ENV) or fixed path /opt/nec/ve/bin/ncc
# but maybe better (since could use an older compiler version, for example)
#   [2] if 'ncc' can be executed in current environment, grab paths directly from
#       execute_process(... ncc ...)
# TODO [2] is above, but can that optional info help us in what follows?
set(CMAKE_CXX_COMPILER nc++)
# [1] determine important VE cross-compiler dirs
#  TODO update dir determination if VE
if(NOT VE_OPT)
    set(VE_OPT $ENV{VE_OPT})
endif()
# TODO if already know full compiler path from [2], then VE_ROOT must be in some parent dir
# TODO ncc gives us MUSL_DIR (and we probably do not need it)
find_program(VE_NCC NAMES ${CMAKE_C_COMPILER} NO_DEFAULT_PATH
    PATHS ${VE_OPT} /opt/nec/ve
    PATH_SUFFIXES bin)
if(NOT VE_NCC)
    message(FATAL_ERROR "ve.cmake: VE cross-compiler ${CMAKE_C_COMPILER} not found under ${VE_OPT} or /opt/nec/ve")
endif()
get_filename_component(VE_OPT ${VE_NCC} DIRECTORY) # VE_OPT/bin 
get_filename_component(VE_OPT ${VE_OPT} DIRECTORY) # VE_OPT 
# final check on VE_OPT
find_program(VE_NCC NAMES ${CMAKE_C_COMPILER} PATHS ${VE_OPT} PATH_SUFFIXES bin)
if(NOT VE_NCC)
    message(FATAL_ERROR "ve.cmake: VE cross-compiler ${CMAKE_C_COMPILER} not found under ${VE_OPT}")
endif()
find_program(VE_NCXX NAMES ${CMAKE_CXX_COMPILER} PATHS ${VE_OPT} PATH_SUFFIXES bin)
if(NOT VE_NCXX)
    message(FATAL_ERROR "ve.cmake: VE cross-compiler ${CMAKE_CXX_COMPILER} not found under ${VE_OPT}")
endif()
set(VE_OPT ${VE_OPT} CACHE PATH "Aurora cross compiler root")
# VE_OPT seems OK

unset(CMAKE_LIBRARY_ARCHITECTURE) # do not try <prefix>/lib/<arch> search paths
# CMAKE_SYSTEM_PREFIX is a low priority search path.
# You may need to modify a cache variable like CMAKE_PREFIX_PATH in
# your project to avoid finding things in /usr/... host-only directories.
message(STATUS "CMAKE_SYSTEM_PREFIX_PATH  : ${CMAKE_SYSTEM_PREFIX_PATH}")
set(CMAKE_SYSTEM_PREFIX_PATH ${VE_OPT} ${CMAKE_INSTALL_PREFIX} ${CMAKE_STAGING_PREFIX})     # a list of search paths
message(STATUS "CMAKE_SYSTEM_PREFIX_PATH -> ${CMAKE_SYSTEM_PREFIX_PATH}")

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CACHE PATH "cmake additional Module/Platform path")
set(_CMAKE_TOOLCHAIN_PREFIX n)		# nar, nld, nFOO binaries XXX handy, but undocumented
#set(CMAKE_CROSSCOMPILING ON)		# auto, if used as TOOCLCHAIN file
set(VE_EXEC ve_exec)
message(STATUS "VE_EXEC start off as ${VE_EXEC}")
set(CMAKE_FIND_LIBRARY_PREFIXES lib)
set(CMAKE_FIND_LIBRARY_SUFFIXES .so .a)
find_program(CMAKE_CROSSCOMPILING_EMULATOR NAMES ve_exec NO_DEFAULT_PATH PATHS ${VE_OPT} PATH_SUFFEXES bin)
message(STATUS "find_program --> CMAKE_CROSSCOMPILING_EMULATOR = ${CMAKE_CROSSCOMPILING_EMULATOR}")
if(CMAKE_CROSSCOMPILING_EMULATOR)
    set(VE_EXEC ${CMAKE_CROSSCOMPILING_EMULATOR})
else()
    set(VE_EXEC "echo ve_exec")
    set(CMAKE_CROSSCOMPILING_EMULATOR ve_exec)
    #set(CMAKE_CROSSCOMPILING_EMULATOR "")
endif()
message(STATUS "VE_EXEC ends up as ${VE_EXEC}")

# VE libc and other libs
# ? find_library c ... ?
set(VE_MUSL_DIR "${VE_OPT}/musl" CACHE PATH "Aurora musl directory")
set(VE_MUSL_FLAGS " -I${VE_MUSL_DIR}/include -L${VE_MUSL_DIR}/lib" CACHE STRING "Aurora musl C/CXX compile/link options")
if(NOT EXISTS ${VE_MUSL_DIR})
    message(WARNING "ve.cmake: VE musl directory not found")
endif()
message(STATUS "VE_MUSL_DIR [libc]          : ${VE_MUSL_DIR}")
message(STATUS "VE_MUSL_FLAGS               : ${VE_MUSL_FLAGS}")
# VE_MUSL_DIR seems OK

if(VE_MUSL_DIR)
    list(APPEND CMAKE_FIND_ROOT_PATH ${VE_MUSL_DIR})
    list(APPEND CMAKE_SYSTEM_PREFIX_PATH ${VE_MUSL_DIR})
    message(STATUS "CMAKE_SYSTEM_PREFIX_PATH -> ${CMAKE_SYSTEM_PREFIX_PATH}")
    # TODO actually check that the function 'dlopen' is there
    find_library(VE_DL_LIBRARY NAMES ld-musl-ve c dl# there is no libdl.a for dlopen,...
        NO_DEFAULT_PATH HINTS ${VE_MUSL_DIR}/lib)
    set(VE_DL_LIBRARY ${VE_DL_LIBRARY} CACHE PATH "Library that may contain a dlopen function")
endif()

# blas location
find_file(found_CBLAS_H NAME cblas.h
    NO_DEFAULT_PATH
    PATHS $ENV{NLC_BASE} ${VE_OPT}/nlc/0.9.0 ${VE_OPT}/nlc
    PATH_SUFFIXES include
    )
message(STATUS "cblas.h --> ${found_CBLAS_H}")
if(NOT found_CBLAS_H)
    message(WARNING "ve.cmake: VE cblas not found? export NLC_BASE to search alternate locations")
endif()
get_filename_component(VE_CBLAS_INCLUDE "${found_CBLAS_H}" DIRECTORY)
get_filename_component(NLC_BASE "${VE_CBLAS_INCLUDE}" DIRECTORY)
set(VE_NLC_DIR "${NLC_BASE}" CACHE PATH "Aurora nlc directory")
set(VE_NLC_FLAGS " -I${VE_CBLAS_INCLUDE} -L${VE_NLC_DIR}/lib" CACHE PATH "Aurora nlc blas C/CXX compile/link options")
message(STATUS "VE_NLC_DIR [cblas]          : ${VE_NLC_DIR}")
message(STATUS "VE_NLC_FLAGS                : ${VE_NLC_FLAGS}")
if(VE_NLC_DIR)
    list(APPEND CMAKE_FIND_ROOT_PATH ${VE_NLC_DIR})
endif()
# expect libraries: libblas_{sequential|pthread}[_i64].{a|so}, libcblas headers: cblas.h
# Ex. LDFLAGS -lcblas -lblas_sequential  ?
# VE_NLC_DIR for blas

if(VE_NLC_DIR)
    list(APPEND CMAKE_FIND_ROOT_PATH ${VE_NLC_DIR})
    list(APPEND CMAKE_SYSTEM_PREFIX_PATH ${VE_NLC_DIR})
    message(STATUS "CMAKE_SYSTEM_PREFIX_PATH -> ${CMAKE_SYSTEM_PREFIX_PATH}")
endif()

# ftrace/veperf location
find_file(found_VEPERF_H NAME veperf.h
    NO_DEFAULT_PATH
    PATHS /usr/uhome/aurora/mpc/pub/veperf/latest
    PATH_SUFFIXES include
    )
message(STATUS "veperf.h --> ${found_VEPERF_H}")
if(NOT found_VEPERF_H)
    message(WARNING "ve.cmake: veperf.h not found (looking for veperf.h [ftrace.h might be there too])")
endif()
get_filename_component(VE_VEPERF_INCLUDE "${found_VEPERF_H}" DIRECTORY)
get_filename_component(VE_VEPERF_DIR "${VE_VEPERF_INCLUDE}" DIRECTORY)
set(VE_VEPERF_DIR "${VEPERF_DIR}" CACHE PATH "Aurora ftrace/veperf root directory")
set(VE_VEPERF_FLAGS "-I${VE_VEPERF_DIR}/include -L${VE_VEPERF_DIR}/lib" CACHE PATH "Aurora ftrace/veperf C/CXX compile/link options")
message(STATUS "VE_VEPERF_DIR [ftrace|veperf]    : ${VE_VEPERF_DIR}")
message(STATUS "VE_VEPERF_FLAGS                  : ${VE_VEPERF_FLAGS}")
# Expected libraries: libveperf.{a|so} headers: ftrace.h veperf.h
# add LDFLAGS="-lveperf" (nothing for ftrace)
# VE_VEPERF_DIR for ftrace/veperf

if(VE_VEPERF_DIR)
    list(APPEND CMAKE_FIND_ROOT_PATH ${VE_VEPERF_DIR})
    list(APPEND CMAKE_SYSTEM_PREFIX_PATH ${VE_VEPERF_DIR})
    message(STATUS "CMAKE_SYSTEM_PREFIX_PATH -> ${CMAKE_SYSTEM_PREFIX_PATH}")
endif()

#set(CMAKE_C_FLAGS "-fdiag-vector=0" CACHE STRING "C flags")
#set(CMAKE_CXX_FLAGS "-fdiag-vector=0 -fdefer-inline-template-instantiation" CACHE STRING "C++ flags")

# search for programs in the build host directories [find_file and find_path]
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

############################## temporary

function(show_cmake_stuff MSG)
    message(STATUS "${MSG}")
    message(STATUS "    NECSX                           ${NECSX}")
    message(STATUS "    NECVE                           ${NECVE}")
    message(STATUS "    CMAKE_ROOT                      ${CMAKE_ROOT}")
    message(STATUS "    CMAKE_GENERATOR                 ${CMAKE_GENERATOR}")
    message(STATUS "    CMAKE_MODULE_PATH               ${CMAKE_MODULE_PATH}")
    message(STATUS "    ENV{CC}                         $ENV{CC}")
    message(STATUS "    ENV{CXX}                        $ENV{CXX}")
    message(STATUS "    CMAKE_C_LINKER_PREFERENCE C     ${CMAKE_C_LINKER_PREFERENCE}")
    message(STATUS "    CMAKE_CXX_LINKER_PREFERENCE C   ${CMAKE_CXX_LINKER_PREFERENCE}")
    message(STATUS "    CMAKE_TOOLCHAIN_FILE            ${CMAKE_TOOLCHAIN_FILE}")
    message(STATUS "    _CMAKE_TOOLCHAIN_PREFIX         ${_CMAKE_TOOLCHAIN_PREFIX}")
    message(STATUS "    CMAKE_CROSSCOMPILING            ${CMAKE_CROSSCOMPILING}")
    message(STATUS "    CMAKE_CROSSCOMPILING_EMULATOR   ${CMAKE_CROSSCOMPILING_EMULATOR}")
    message(STATUS " Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}-C-${CMAKE_SYSTEM_PROCESSOR}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_VERSION                   ${CMAKE_VERSION}")
    message(STATUS "    CMAKE_SYSTEM_NAME               ${CMAKE_SYSTEM_NAME}")
    message(STATUS "    CMAKE_UNIX                      ${CMAKE_UNIX}")
    message(STATUS "    CMAKE_C_COMPILER_ID             ${CMAKE_C_COMPILER_ID}")
    message(STATUS "    CMAKE_CXX_COMPILER_ID           ${CMAKE_CXX_COMPILER_ID}")
    message(STATUS "    CMAKE_COMPILER_IS_GNUCC         ${CMAKE_COMPILER_IS_GNUCC}")
    message(STATUS "    CMAKE_COMPILER_IS_GNUCXX        ${CMAKE_COMPILER_IS_GNUCXX}")
    message(STATUS "    CMAKE_C_COMPILER_VERSION        ${CMAKE_C_COMPILER_VERSION}")
    message(STATUS "    CMAKE_CXX_COMPILER_VERSION      ${CMAKE_CXX_COMPILER_VERSION}")
    message(STATUS "    -------------------------------")
    message(STATUS "    BUILD_SHARED_LIBS               ${BUILD_SHARED_LIBS}")
    message(STATUS "    CMAKE_AR                        ${CMAKE_AR}")
    message(STATUS "    CMAKE_MODULE_LINKER_FLAGS       ${CMAKE_MODULE_LINKER_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LINKER_FLAGS       ${CMAKE_SHARED_LINKER_FLAGS}")
    message(STATUS "    CMAKE_EXE_LINKER_FLAGS          ${CMAKE_EXE_LINKER_FLAGS}")
    message(STATUS "    CMAKE_MODULE_LINKER_FLAGS       ${CMAKE_MODULE_LINKER_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LINKER_FLAGS       ${CMAKE_SHARED_LINKER_FLAGS}")
    message(STATUS "    CMAKE_STATIC_LINKER_FLAGS       ${CMAKE_STATIC_LINKER_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_C_FLAGS    ${CMAKE_SHARED_LIBRARY_C_FLAGS}")
    message(STATUS "    CMAKE_STATIC_LIBRARY_C_FLAGS    ${CMAKE_STATIC_LIBRARY_C_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS ${CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS}")
    message(STATUS "    CMAKE_STATIC_LIBRARY_CREATE_C_FLAGS ${CMAKE_STATIC_LIBRARY_CREATE_C_FLAGS}")
    message(STATUS "    BUILD_STATIC_LIBS               ${BUILD_STATIC_LIBS}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_C_COMPILER                     ${CMAKE_C_COMPILER}")
    message(STATUS "    CMAKE_C_OUTPUT_EXTENSION             ${CMAKE_C_OUTPUT_EXTENSION}")
    message(STATUS "    CMAKE_C_FLAGS                        ${CMAKE_C_FLAGS}")
    message(STATUS "    CMAKE_C_FLAGS_RELEASE                ${CMAKE_C_FLAGS_RELEASE}")
    message(STATUS "    CMAKE_C_FLAGS_DEBUG                  ${CMAKE_C_FLAGS_DEBUG}")
    message(STATUS "    CMAKE_C_COMPILE_OBJECT               ${CMAKE_C_COMPILE_OBJECT}")
    message(STATUS "    CMAKE_C_LINK_EXECUTABLE              ${CMAKE_C_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_C_CREATE_SHARED_LIBRARY        ${CMAKE_C_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_C_CREATE_STATIC_LIBRARY        ${CMAKE_C_CREATE_STATIC_LIBRARY}")
    message(STATUS "    CMAKE_C_CREATE_PREPROCESSED_SOURCE   ${CMAKE_C_CREATE_PREPROCESSED_SOURCE}")
    message(STATUS "    CMAKE_C_CREATE_ASSEMBLY_SOURCE       ${CMAKE_C_CREATE_ASSEMBLY_SOURCE}")
    message(STATUS "    CMAKE_SHARED_CXX_LINK_FLAGS          ${CMAKE_C_LINK_FLAGS}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_CXX_COMPILER                   ${CMAKE_CXX_COMPILER}")
    message(STATUS "    CMAKE_C_OUTPUT_EXTENSION             ${CMAKE_CXX_OUTPUT_EXTENSION}")
    message(STATUS "    CMAKE_CXX_FLAGS                      ${CMAKE_CXX_FLAGS}")
    message(STATUS "    CMAKE_CXX_LINK_FLAGS                 ${CMAKE_CXX_LINK_FLAGS}")
    message(STATUS "    CMAKE_CXX_FLAGS_RELEASE              ${CMAKE_CXX_FLAGS_RELEASE}")
    message(STATUS "    CMAKE_CXX_FLAGS_DEBUG                ${CMAKE_CXX_FLAGS_DEBUG}")
    message(STATUS "    CMAKE_CXX_COMPILE_OBJECT             ${CMAKE_CXX_COMPILE_OBJECT}")
    message(STATUS "    CMAKE_CXX_LINK_EXECUTABLE            ${CMAKE_CXX_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_CXX_CREATE_SHARED_LIBRARY      ${CMAKE_CXX_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_CXX_CREATE_STATIC_LIBRARY      ${CMAKE_CXX_CREATE_STATIC_LIBRARY}")
    message(STATUS "    CMAKE_CXX_CREATE_PREPROCESSED_SOURCE ${CMAKE_CXX_CREATE_PREPROCESSED_SOURCE}")
    message(STATUS "    CMAKE_CXX_CREATE_ASSEMBLY_SOURCE     ${CMAKE_CXX_CREATE_ASSEMBLY_SOURCE}")
    message(STATUS "    -------------------------------")
endfunction()

macro(DETERMINE_NCC_SYSTEM_INCLUDES_DIRS _compiler _flags _incVar _preincVar)
    # Input:
    #           _compiler  : ncc or nc++ [or nfort?]
    #           _flags     : compiler flags
    # Output:
    #           _incVar    : list of compiler include paths (-isystem)
    #           _preincVar : list of compiler pre-include paths
    #
    #    ncc -v -E -x c++ dummy 1>/dev/null
    #       /opt/nec/ve/ncc/0.0.28/libexec/ccom -cpp -v -E -dD
    #         -isystem /opt/nec/ve/ncc/0.0.28/include
    #         -isystem /opt/nec/ve/musl/include
    #         --preinclude-path /opt/nec/ve/ncc/0.0.28/include
    #         -x c++ dummy
    # or [TODO] nfort -v -E dummy 1>/dev/null
    #       /opt/nec/ve/nfort/0.0.28/libexec/fpp -I. -p
    #         -I/opt/nec/ve/nfort/0.0.28/include
    #         -I/opt/nec/ve/musl/include
    #         dummy
    set(_verbose 1)
    if(_verbose GREATER 0)
        message(STATUS "  CMAKE_C_COMPILER_ID           : ${CMAKE_C_COMPILER_ID}")
        message(STATUS "  CMAKE_CXX_COMPILER_ID           : ${CMAKE_CXX_COMPILER_ID}")
    endif()
    if(NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
        message(WARNING "CXX compiler not GNU, so may not be able to determine CXX sys includes")
    endif()
    file(WRITE "${CMAKE_BINARY_DIR}/CMakeFiles/dummy" "\n")
    separate_arguments(_buildFlags UNIX_COMMAND "${_flags}")
    #execute_process(COMMAND ${_compiler} ${_buildFlags} -v -E dummy
    set(_cmd ${CMAKE_C_COMPILER} -v -E dummy)
    execute_process(COMMAND ${_cmd}
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/CMakeFiles"
        OUTPUT_QUIET
        #OUTPUT_VARIABLE _compOut0 # could be useful if use -dM
        ERROR_VARIABLE _compOut)
    file(REMOVE "${CMAKE_BINARY_DIR}/CMakeFiles/dummy")
    separate_arguments(_compArgs UNIX_COMMAND "${_compOut}")
    if(_verbose GREATER 1)
        message(STATUS "_compiler   : ${_compiler}")
        message(STATUS "_flags      : ${_flags}")
        message(STATUS "_buildflags : ${_buildflags}")
        #message(STATUS "_compOut0   : ${_compOut0}")
        message(STATUS "_compOut    : ${_compOut}")
        message(STATUS "_compArgs   : ${_compArgs}")
    endif()
    set(_nextType "boring")
    list(GET _compArgs 0 _ccom) # e.g. /opt/nec/ve/ncc/0.0.28/libexec/ccom
    message(STATUS "_ccom ${_ccom}")
    get_filename_component(_compRoot ${_ccom} DIRECTORY)
    get_filename_component(_compRoot ${_compRoot} DIRECTORY)
    message(STATUS "_compRoot ${_compRoot}")
    if(_verbose GREATER 0)
        if(EXISTS ${_compRoot}/etc/ncc.conf)
            file(READ ${_compRoot}/etc/ncc.conf _etc_ncc_conf)
            message(STATUS "${_compRoot}/etc/ncc.conf\n${_etc_ncc_conf}")
        endif()
    endif()
    foreach(_compArg ${_compArgs})
        if(_verbose GREATER 2)
            message(STATUS "_nextType=${nextType}, _compArg=${_compArg}")
        endif()
        if(${_nextType} STREQUAL "-isystem")
            list(APPEND ${_incVar} ${_compArg})
            set(_nextType "boring")
        elseif(${_compArg} STREQUAL "-isystem")
            set(_nextType ${_compArg})
        endif()
    endforeach()
    foreach(_compArg ${_compArgs})
        if(_verbose GREATER 2)
            message(STATUS "_nextType=${nextType}, _compArg=${_compArg}")
        endif()
        if(${_nextType} STREQUAL "--preinclude-path")
            list(REMOVE_ITEM ${_incVar} ${_compArg})
            list(APPEND ${_preincVar} ${_compArg})
            set(_nextType "boring")
        elseif(${_compArg} STREQUAL "--preinclude-path")
            set(_nextType ${_compArg})
        endif()
    endforeach()
    if(_verbose GREATER 0)
        message(STATUS "Compiler       : ${_compiler}")
        message(STATUS "  Flags        : ${_compiler}")
        message(STATUS "  pre-includes : ${${_preincVar}}")
        message(STATUS "  sys-includes : ${${_incVar}}")
    endif()
endmacro()

show_cmake_stuff("End of ve.cmake")

# vim: et ts=4 sw=4 ai
