# this one is important
# ve.cmake toolchain is invoked by cmake PROJECT command, after cmake
# using uname (or whatever) to determine a host system such as 'Linux'
if(${CMAKE_HOST_SYSTEM_NAME})
    set(CMAKE_SYSTEM_NAME ${CMAKE_HOST_SYSTEM_NAME})
else()
    set(CMAKE_SYSTEM_NAME Linux)
endif()

# but we are not using the host processor
set(CMAKE_SYSTEM_PROCESSOR aurora)

set(NECVE  1 CACHE BOOL "Set thing up for NEC Aurora vector processor" FORCE)

# we are debugging a fair bit... default value for CMAKE_BUILD_TYPE
set(CMAKE_BUILD_TYPE_INIT "RelWithDebInfo")

# for now, want verbose linking...
set(CMAKE_EXE_LINKER_FLAGS_INIT "-v -Wl,--verbose -Wl,-z,-origin")
set(CMAKE_SHARED_LINKER_FLAGS_INIT "-v -Wl,--verbose -Wl,-z,-origin")

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
    set(_verbose 1)
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

macro(DETERMINE_CLANG_SYSTEM_INCLUDES_DIRS _compiler _isCpp _flags _incVar _preincVar _moreFlags)
    #
    # Input:
    #           _compiler  : clang or clang++
    #           _flags     : compiler flags
    #           _isCpp     : isCpp
    # Output:
    #           _incVar    : list of compiler include paths (-isystem)
    #           _preincVar : list of compiler pre-include paths
    # Modifies CMAKE_C_FLAGS or CMAKE_CXX_FLAGS
    #
    set(_verbose 1)
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
    set(_cmd ${_compiler} -v --target=ve-linux -c dummy)
    execute_process(COMMAND ${_cmd}
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/CMakeFiles"
        OUTPUT_QUIET
        OUTPUT_VARIABLE _compOut0 # could be useful if use -dM
        ERROR_VARIABLE _compOut)
    file(REMOVE "${CMAKE_BINARY_DIR}/CMakeFiles/dummy")
    separate_arguments(_compArgs UNIX_COMMAND "${_compOut}")
    if(_verbose GREATER 1)
        message(STATUS "_compiler   : ${_compiler}")
        message(STATUS "_flags      : ${_flags}")
        message(STATUS "_buildflags : ${_buildflags}")
        message(STATUS "_compOut0   : ${_compOut0}")
        message(STATUS "_compOut    : ${_compOut}")
        message(STATUS "_compArgs   : ${_compArgs}")
    endif()
    set(_nextType "boring")
    foreach(_compArg ${_compArgs})
        if(_verbose GREATER 2)
            message(STATUS "_nextType=${nextType}, _compArg=${_compArg}")
        endif()
        if(${_nextType} STREQUAL "InstalledDir:")
            set(_install_dir ${_compArg})
            set(_nextType "boring")
        elseif(${_compArg} STREQUAL "InstalledDir:")
            set(_nextType ${_compArg})
        endif()
    endforeach()
    list(APPEND ${_moreFlags} "-idirafter${_install_dir}/../include")
    if(${_isCpp} STREQUAL "clang++")
      list(APPEND ${_incVar} "${_install_dir}/../lib/clang/${_compiler_version}/include/c++/v1")
      list(APPEND ${_moreFlags} "-idirafter${_install_dir}/../include/c++/v1")
    endif()
    list(APPEND ${_incVar} "${_install_dir}/../lib/clang/${_compiler_version}/include")
    if(1)
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
    execute_process(COMMAND $ENV{CC} --version OUTPUT_VARIABLE _cLangVersion ERROR_VARIABLE _ccVersion)
    if(${_ccVersion} MATCHES "^ncc")
        set(_compiler $ENV{CC})
    elseif(${_cLangVersion} MATCHES "^clang")
        set(_compiler $ENV{CC})
        set(CMAKE_C_FLAGS "--target=ve-linux -fno-vectorize -fno-slp-vectorize -fno-crash-diagnostics -frtlib-add-rpath")
        set(CMAKE_C_FLAGS_INIT "--target=ve-linux -fno-vectorize -fno-slp-vectorize -fno-crash-diagnostics -frtlib-add-rpath")
        set(CMAKE_C_FLAGS_RELEASE "-DNDEBUG")

        set(CMAKE_EXE_LINKER_FLAGS_INIT "-v -Wl,--verbose -Wl,-z,-origin -frtlib-add-rpath")
        set(CMAKE_SHARED_LINKER_FLAGS_INIT "-v -Wl,--verbose -Wl,-z,-origin -frtlib-add-rpath")
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
    if(${_compiler} MATCHES "clang")
        DETERMINE_CLANG_SYSTEM_INCLUDES_DIRS(${_compiler} "clang" "-pthread" VE_C_SYSINC VE_C_PREINC _moreCFlags)
        foreach(_newFlag ${_moreCFlags})
          MESSAGE(STATUS "Adding flag ${_newFlag}")
          SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${_newFlag}")
          MESSAGE(STATUS "CMAKE_C_FLAGS ${CMAKE_C_FLAGS}")
        endforeach()
    else()
      MESSAGE(STATUS "Determining clang system include directories")
      DETERMINE_NCC_SYSTEM_INCLUDES_DIRS(ncc "-pthread" VE_C_SYSINC VE_C_PREINC)
    endif()
    message(STATUS "ve.cmake [test]:  C pre-inc dirs  : ${VE_C_PREINC}")
    message(STATUS "ve.cmake [test]:  C sys-inc dirs  : ${VE_C_SYSINC}")
    message(STATUS "ve.cmake [test]:  C CMAKE_C_FLAGS : ${CMAKE_C_FLAGS}")
    set(VE_C_PREINC ${VE_C_PREINC} CACHE INTERNAL "ncc pre-include directory[ies]")
    set(VE_C_SYSINC ${VE_C_SYSINC} CACHE INTERNAL "ncc sys-include directory[ies]")
    # oh, next 2 do not exist yet, so this must be done in Linux-GNU-<lang>-aurora.cmake files
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
    execute_process(COMMAND $ENV{CXX} --version OUTPUT_VARIABLE _cLangVersion ERROR_VARIABLE _ccVersion)
    if(${_ccVersion} MATCHES "^nc\\+\\+")
        set(_compiler $ENV{CXX})
    elseif(${_cLangVersion} MATCHES "^clang version ([0-9]+\.[0-9]+\.[0-9]+)")
        set(_compiler $ENV{CXX})
        set(_compiler_version "${CMAKE_MATCH_1}")
        message(STATUS "ve.cmake [test]:  Clang version: ${_compiler_version}")
        set(CMAKE_CXX_FLAGS "--target=ve-linux -fno-vectorize -fno-slp-vectorize -fno-crash-diagnostics -frtlib-add-rpath")
        set(CMAKE_CXX_FLAGS_INIT "--target=ve-linux -fno-vectorize -fno-slp-vectorize -fno-crash-diagnostics -frtlib-add-rpath")
        set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG")
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
    if(${_compiler} MATCHES "clang")
      MESSAGE(STATUS "Determining clang++ system include directories")
      DETERMINE_CLANG_SYSTEM_INCLUDES_DIRS(${_compiler} "clang++" "-pthread" VE_CXX_SYSINC VE_CXX_PREINC _moreCxxFlags)
      foreach(_newFlag ${_moreCxxFlags})
        MESSAGE(STATUS "Adding flag ${_newFlag}")
        SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${_newFlag}")
        MESSAGE(STATUS "CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}")
      endforeach()
    else()
      MESSAGE(STATUS "Determining nc++ system include directories")
      DETERMINE_NCC_SYSTEM_INCLUDES_DIRS(nc++ "-pthread" VE_CXX_SYSINC VE_CXX_PREINC)
    endif()
    message(STATUS "ve.cmake [test]:  C++ pre-inc dirs  : ${VE_CXX_PREINC}")
    message(STATUS "ve.cmake [test]:  C++ sys-inc dirs  : ${VE_CXX_SYSINC}")
    message(STATUS "ve.cmake [test]:  CMAKE_CXX_FLAGS : ${CMAKE_CXX_FLAGS}")
    set(VE_CXX_PREINC ${VE_CXX_PREINC} CACHE INTERNAL "nc++ pre-include directory[ies]")
    set(VE_CXX_SYSINC ${VE_CXX_SYSINC} CACHE INTERNAL "nc++ sys-include directory[ies]")
    message(STATUS "ve.cmake [test]:  C++ pre-inc dirs  : ${VE_CXX_PREINC}")
    message(STATUS "ve.cmake [test]:  C++ sys-inc dirs  : ${VE_CXX_SYSINC}")
    message(STATUS "ve.cmake [test]:  CMAKE_CXX_FLAGS : ${CMAKE_CXX_FLAGS}")
    set(CMAKE_CXX_COMPILER   ${_compiler})
else()
    set(CMAKE_CXX_COMPILER   nc++)
endif()
unset(_compiler)

#  There are some options here:
#   [1] [current] check VE_OPT (maybe from ENV) or fixed path /opt/nec/ve/bin/ncc
# but maybe better (since could use an older compiler version, for example)
#   [2] if 'ncc' can be executed in current environment, grab paths directly from
#       execute_process(... ncc ...)
# TODO [2] is above, but can that optional info help us in what follows?
# set(CMAKE_CXX_COMPILER nc++)
# [1] determine important VE cross-compiler dirs
#  TODO update dir determination if VE
if(NOT VE_OPT)
    set(VE_OPT $ENV{VE_OPT})
endif()
# TODO if already know full compiler path from [2], then VE_ROOT must be in some parent dir
# TODO ncc gives us MUSL_DIR (and we probably do not need it)
# find_program(VE_NCC NAMES ${CMAKE_C_COMPILER} NO_DEFAULT_PATH
find_program(VE_NCC NAMES ncc NO_DEFAULT_PATH
    PATHS ${VE_OPT} /opt/nec/ve
    PATH_SUFFIXES bin)
if(NOT VE_NCC)
    message(FATAL_ERROR "ve.cmake: VE cross-compiler ${CMAKE_C_COMPILER} not found under ${VE_OPT} or /opt/nec/ve")
endif()
get_filename_component(VE_OPT ${VE_NCC} DIRECTORY) # VE_OPT/bin 
get_filename_component(VE_OPT ${VE_OPT} DIRECTORY) # VE_OPT 
# # final check on VE_OPT
# find_program(VE_NCC NAMES ${CMAKE_C_COMPILER} PATHS ${VE_OPT} PATH_SUFFIXES bin)
# if(NOT VE_NCC)
#     message(FATAL_ERROR "ve.cmake: VE cross-compiler ${CMAKE_C_COMPILER} not found under ${VE_OPT}")
# endif()
# find_program(VE_NCXX NAMES ${CMAKE_CXX_COMPILER} PATHS ${VE_OPT} PATH_SUFFIXES bin)
# if(NOT VE_NCXX)
#     message(FATAL_ERROR "ve.cmake: VE cross-compiler ${CMAKE_CXX_COMPILER} not found under ${VE_OPT}")
# endif()
set(VE_OPT ${VE_OPT} CACHE PATH "Aurora cross compiler root")
# VE_OPT seems OK

unset(CMAKE_LIBRARY_ARCHITECTURE) # do not try <prefix>/lib/<arch> search paths
# CMAKE_SYSTEM_PREFIX is a low priority search path.
# You may need to modify a cache variable like CMAKE_PREFIX_PATH in
# your project to avoid finding things in /usr/... host-only directories.
message(STATUS "CMAKE_SYSTEM_PREFIX_PATH  : ${CMAKE_SYSTEM_PREFIX_PATH}")
set(CMAKE_SYSTEM_PREFIX_PATH ${CMAKE_SYSTEM_PREFIX_PATH} ${VE_OPT} ${CMAKE_INSTALL_PREFIX} ${CMAKE_STAGING_PREFIX})     # a list of search paths
list(REMOVE_DUPLICATES CMAKE_SYSTEM_PREFIX_PATH)
message(STATUS "CMAKE_SYSTEM_PREFIX_PATH -> ${CMAKE_SYSTEM_PREFIX_PATH}")

# set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CACHE PATH "cmake additional Module/Platform path")
set(_CMAKE_TOOLCHAIN_PREFIX n)		# nar, nld, nFOO binaries XXX handy, but undocumented
#set(CMAKE_CROSSCOMPILING ON)		# auto, if used as TOOCLCHAIN file
set(VE_EXEC ve_exec)
message(STATUS "VE_EXEC start off as ${VE_EXEC}")
set(CMAKE_FIND_LIBRARY_PREFIXES lib)
set(CMAKE_FIND_LIBRARY_SUFFIXES .so .a)
find_program(CMAKE_CROSSCOMPILING_EMULATOR NAMES ve_exec NO_DEFAULT_PATH PATHS ${VE_OPT} PATH_SUFFIXES bin)
message(STATUS "find_program --> CMAKE_CROSSCOMPILING_EMULATOR = ${CMAKE_CROSSCOMPILING_EMULATOR}")
if(CMAKE_CROSSCOMPILING_EMULATOR)
    set(VE_EXEC ${CMAKE_CROSSCOMPILING_EMULATOR})
else()
    set(VE_EXEC "echo ve_exec")
    set(CMAKE_CROSSCOMPILING_EMULATOR ve_exec)
    #set(CMAKE_CROSSCOMPILING_EMULATOR "")
endif()
message(STATUS "VE_EXEC ends up as ${VE_EXEC}")

# # VE libc and other libs
# # ? find_library c ... ?
# set(VE_MUSL_DIR "${VE_OPT}/musl" CACHE PATH "Aurora musl directory")
# set(VE_MUSL_FLAGS " -I${VE_MUSL_DIR}/include -L${VE_MUSL_DIR}/lib" CACHE STRING "Aurora C/CXX compile/link options. ncc/nc++ auto uses the include path!")
# if(NOT EXISTS ${VE_MUSL_DIR})
#     message(WARNING "ve.cmake: VE musl directory not found")
# endif()
# message(STATUS "VE_MUSL_DIR [libc]          : ${VE_MUSL_DIR}")
# message(STATUS "VE_MUSL_FLAGS               : ${VE_MUSL_FLAGS}")
# # VE_MUSL_DIR seems OK
# # Note: MUSL is **always** included for you by ncc/nc++
# 
# if(VE_MUSL_DIR)
#     list(APPEND CMAKE_FIND_ROOT_PATH ${VE_MUSL_DIR})
#     list(APPEND CMAKE_SYSTEM_PREFIX_PATH ${VE_MUSL_DIR})
#     message(STATUS "CMAKE_SYSTEM_PREFIX_PATH -> ${CMAKE_SYSTEM_PREFIX_PATH}")
#     # TODO actually check that the function 'dlopen' is there
#     # Note: linker is auto-supplied ld-musl-ve via ncc/nc++ [I think]
#     find_library(VE_DL_LIBRARY NAMES ld-musl-ve c dl# there is no libdl.a for dlopen,...
#         NO_DEFAULT_PATH HINTS ${VE_MUSL_DIR}/lib)
#     set(VE_DL_LIBRARY ${VE_DL_LIBRARY} CACHE PATH "Library that may contain a dlopen function")
# endif()

# For reference, from nlc 1.0.0 docs ............
# Various NLC options ...........................
#   Bool:     VE_I64   VE_MPI    VE_SEQ
#   NLC libs: VE_ASL   VE_FFT    VE_CBLAS   VE_HET   [sblas, lapack, clapack ...]
include(CMakeParseArguments) # not require for cmake>=3.4
function(VE_JOIN VALUES GLUE OUTPUT)
    # Can use this to transform a ;-separated list into a :-separated list
    # Ex. VE_JOIN("a;b;c\;c" ":" output) ---> output = "a:b:c\;c" (should preserve escaped semicolons)
    string (REGEX REPLACE "([^\\]|^);" "\\1${GLUE}" _TMP_STR "${VALUES}")
    string (REGEX REPLACE "[\\](.)" "\\1" _TMP_STR "${_TMP_STR}") #fixes escaping
    string(STRIP "${_TMP_STR}" _TMP_STR)
    set (${OUTPUT} "${_TMP_STR}" PARENT_SCOPE)
endfunction()
function(VE_PREPEND_EACH VALUES GLUE OUTPUT)
    # Ex. VE_PREPEND("a;b;c" " -I" output) ---> output = " -Ia -Ib -Ic"
    set(_tmp "")
    if(NOT "${VALUES}" STREQUAL "")
        VE_JOIN("${GLUE}${VALUES}" "${GLUE}" _tmp)
    endif()
    string(STRIP "${_tmp}" _tmp)
    set(${OUTPUT} "${_tmp}" PARENT_SCOPE)
endfunction()
######## find a VE_CBLAS_INCLUDE_DIR, that contains cblas.h
# blas location : IF you have sourced nlcvars.sh, we try to match those settings exactly
#   otherwise, look in ENV{NLC_BASE}/include or ${VE_OPT}/nlc/**/include for cblas.h

function(NLC_PRELIM_SETTINGS)
    cmake_parse_arguments(_prelim "INIT" "I64;MPI" "" ${ARGN})
    if(NOT _prelim_INIT)
        set(NLC_LIB_I64 ${_prelim_I64})
        set(NLC_LIB_MPI ${_prelim_MPI})
    else() # snarf default directories/options from environment or default search paths
        set(NLC_VERSION "")
        set(NLC_LIB_I64 "")
        set(NLC_LIB_MPI "")
        if(IS_DIRECTORY "$ENV{NLC_HOME}")
            message(STATUS "  using NLC_HOME from environment: ${NLC_HOME} (assuming nlcvar.{sh|csh} has been sourced)")
            set(NLC_VERSION "$ENV{NLC_VERSION}")
            set(NLC_HOME "$ENV{NLC_HOME}")
            set(ASL_HOME "$ENV{NLC_HOME}")
            set(NLC_LIB_I64 "")
            set(ASL_LIB_I64 "")
            set(NLC_LIB_MPI "")
            set(ASL_LIB_MPI "")
            if(EXISTS "${NLC_HOME}/include/cblas.h")
                set(VE_NLC_INCLUDE_CBLAS_H "include/cblas.h")
                set(VE_CBLAS_INCLUDE_DIR "${NLC_HOME}/include")
                set(VE_CBLAS_DIR "${NLC_HOME}")
            endif()
        else()
            message(FATAL_ERROR "environment variable NLC_HOME not set")
        endif()
    endif()
    set(VE_CBLAS_INCLUDE_DIR "${VE_CBLAS_INCLUDE_DIR}" CACHE STRING "VE_CBLAS_INCLUDE_DIR")
    message(STATUS "Global: set VE_CBLAS_INCLUDE_DIR to ${VE_CBLAS_INCLUDE_DIR}")
    if(_prelim_INIT)
        if(NOT IS_DIRECTORY "${VE_CBLAS_INCLUDE_DIR}")
            message(STATUS "Ohoh. No cblas.h?  VE_CBLAS_INCLUDE_DIR = ${VE_CBLAS_INCLUDE_DIR}")
            message(WARNING "VE NLC libraries (ASL, FFTW3, CBLAS, Hetero) not found")
            message(STATUS "ve.cmake will try to find cblas.h as follows:")
            message(STATUS "    1) NLC_HOME environment variable (set by sourcing nlcvars.sh or nlcvars.csh)")
            # This was an environment variable that Erich was using at some point
            message(STATUS "    2) environment variable NLC_BASE")
            message(STATUS "    3) recursion under $VE_OPT/nlc/**/include = ${VE_OPT}/nlc/**/include")
            message(FATAL_ERROR "ve.cmake could not find cblas.h")
        endif()
        message(STATUS "Good. Found cblas.h in ${VE_CBLAS_INCLUDE_DIR}")
        get_filename_component(VE_CBLAS_DIR "${VE_CBLAS_INCLUDE_DIR}" DIRECTORY)
        set(VE_CBLAS_DIR "${VE_CBLAS_DIR}" CACHE PATH "NLC/version prefix-directory (ex. $VE_OPT/nlc/1.0.0)" FORCE)
        message(STATUS "      Caching VE_CBLAS_DIR ${VE_CBLAS_DIR}")
        mark_as_advanced(VE_CBLAS_DIR) # this is a purely internal variable
        if("${NLC_VERSION}" STREQUAL "")
            get_filename_component(NLC_VERSION "${VE_CBLAS_DIR}" NAME) # a simple guess
            message(STATUS "      NLC_VERSION    --> ${NLC_VERSION}")
        endif()
        if(NOT IS_DIRECTORY "${NLC_HOME}")
            set(NLC_HOME "${VE_CBLAS_DIR}")
            message(STATUS "      NLC_HOME       --> ${NLC_HOME}")
        endif()
        # TODO check NLC_HOME
        if(NOT IS_DIRECTORY "${ASL_HOME}")
            set(ASL_HOME "${NLC_HOME}")
            message(STATUS "      ASL_HOME       --> ${ASL_HOME}")
        endif()
        # TODO check NLC_HOME
        set(NLC_HOME "${NLC_HOME}" CACHE PATH "NLC/version prefix-directory (ex. $VE_OPT/nlc/1.0.0)" FORCE)
        set(ASL_HOME "${ASL_HOME}" CACHE PATH "ASL prefix-directory (typ. equiv NLC_HOME)" FORCE)
        mark_as_advanced(ASL_HOME) # NLC_HOME?
    endif()
    # VE_CBLAS_INCLUDE_DIR is now a directory, set just once during 'INIT'

    # The following search-path things may vary with I64 or MPI settings:
    if("${NLC_LIB_I64}" STREQUAL "")
        set(NLC_LIB_I64 0)
        set(ASL_LIB_I64 0)
    endif()
    if("${NLC_LIB_MPI}" STREQUAL "")
        set(NLC_LIB_MPI 0)
        set(ASL_LIB_MPI 0)
    endif()
    set(NLC__suffix "")
    if(NLC_LIB_I64)
        set(NLC__suffix "_i64")
    endif()
    if(NLC_LIB_MPI)
        set(NLC__suffix "_mpi${NLC__suffix}")
    endif()

    # ve.cmake sets ;-separated NLC lists according to some default options for included components/features
    #   VE_NCC_INCLUDES
    #   VE_NFORT_INCLUDES
    #   VE_NLC_LIBRARY_PATH --> VE_NLC_LIBS

    set(VE_NCC_INCLUDES "")   # a ;-separated list, analogous to nlcvar additions to $NCC_INCLUDE_PATH
    foreach(NLC__dir_inc in ${NLC_HOME}/include ${NLC_HOME}/include/inc${NLC__suffix})
        if(IS_DIRECTORY ${NLC__dir_inc})
            list(APPEND VE_NCC_INCLUDES ${NLC__dir_inc})
        endif()
    endforeach()
    unset(NLC__dir_inc)
    message(STATUS "  VE_NCC_INCLUDES           : ${VE_NCC_INCLUDES}")

    set(VE_NFORT_INCLUDES "")   # a ;-separated list, analogous to nlcvar prepends to env $NFORT_INCLUDE_PATH
    foreach(NLC__dir_mod in ${NLC_HOME}/include ${NLC_HOME}/include/mod${NLC__suffix})
        if(IS_DIRECTORY ${NLC__dir_mod})
            list(APPEND VE_NFORT_INCLUDES ${NLC__dir_mod})
        endif()
    endforeach()
    unset(NLC__dir_mod)
    set(VE_NFORT_INCLUDE ${VE_NFORT_INCLUDES})  #VE NFORT ;-separated paths to prepend to NFORT_INCLUDE_PATH")
    message(STATUS "  VE_NFORT_INCLUDES         : ${VE_NFORT_INCLUDES}")

    set(VE_NLC_LIBRARY_PATH "")   # a ;-separated list, analogous to nlcvar prepends to env $VE_LIBRARY_PATH
    foreach(NLC__dir_lib in ${NLC_HOME}/lib)
        if(IS_DIRECTORY ${NLC__dir_lib})
            list(APPEND VE_NLC_LIBRARY_PATH ${NLC__dir_lib})
        endif()
    endforeach()
    unset(NLC__dir_lib)
    set(VE_NLC_LIBRARY_PATH "${VE_NLC_LIBRARY_PATH}")  #VE NLC ;-separated library paths to prepend to VE_NLC_LIBRARY_PATH")
    message(STATUS "  VE_NLC_LIBRARY_PATH       : ${VE_NFORT_INCLUDES}")

    # These values are not meant to be modified, so returned as CACHE values
    set(NLC_LIB_I64 "${NLC_LIB_I64}" CACHE BOOL "NLC 1/0 64-bit integer?" FORCE)
    set(ASL_LIB_I64 "${ASL_LIB_I64}" CACHE BOOL "ASL 1/0 64-bit integer?" FORCE)
    set(NLC_LIB_MPI "${NLC_LIB_MPI}" CACHE BOOL "NLC 1/0 MPI support?" FORCE)
    set(ASL_LIB_MPI "${ASL_LIB_MPI}" CACHE BOOL "ASL 1/0 MPI support?" FORCE)
    mark_as_advanced(NLC_HOME ASL_HOME NLC_LIB_I64 ASL_LIB_I64 NLC_LIB_MPI ASL_LIB_MPI)
    # These values might have to change (if user calls VE_NLC_SETUP)
    set(VE_NCC_INCLUDES "${VE_NCC_INCLUDES}" CACHE STRING "NLC ncc/nc++ compiler include path (:-separated) like $NCC_INCLUDE_PATH" FORCE)
    set(VE_NFORT_INCLUDES "${VE_NFORT_INCLUDES}" CACHE STRING "NLC nfort compiler include path (:-separated) like $NFORT_INCLUDE_PATH" FORCE)
    set(VE_NLC_LIBRARY_PATH "${VE_NLC_LIBRARY_PATH}" CACHE STRING "NLC library search path (:-separated) like $VE_LIBRARY_PATH" FORCE)

    # CMAKE_SYSTEM_foo_PATH are ;-separated lists, for low-priority CMAKE search paths for find_xxx ops
    set(CMAKE_SYSTEM_PREFIX_PATH ${NLC_HOME} ${CMAKE_SYSTEM_PREFIX_PATH})
    set(CMAKE_SYSTEM_LIBRARY_PATH ${VE_NLC_LIBRARY_PATH} ${CMAKE_SYSTEM_LIBRARY_PATH})
    set(CMAKE_SYSTEM_INCLUDE_PATH ${VE_NCC_INCLUDES} ${VE_NFORT_INCLUDES} ${CMAKE_SYSTEM_INCLUDE_PATH}) # NFORT?
    if(IS_DIRECTORY ${NLC_HOME}/bin)
        set(CMAKE_SYSTEM_PROGRAM_PATH ${NLC_HOME}/bin ${CMAKE_SYSTEM_PROGRAM_PATH})
    else()
        set(CMAKE_SYSTEM_PROGRAM_PATH "")
    endif()
    list(REMOVE_DUPLICATES CMAKE_SYSTEM_PREFIX_PATH)
    list(REMOVE_DUPLICATES CMAKE_SYSTEM_LIBRARY_PATH)
    list(REMOVE_DUPLICATES CMAKE_SYSTEM_INCLUDE_PATH)
    list(REMOVE_DUPLICATES CMAKE_SYSTEM_PROGRAM_PATH)
    # pass these new values to caller scope
    set(CMAKE_SYSTEM_PREFIX_PATH ${CMAKE_SYSTEM_PREFIX_PATH} PARENT_SCOPE)
    set(CMAKE_SYSTEM_LIBRARY_PATH ${CMAKE_SYSTEM_LIBRARY_PATH} PARENT_SCOPE)
    set(CMAKE_SYSTEM_INCLUDE_PATH ${CMAKE_SYSTEM_INCLUDE_PATH} PARENT_SCOPE)
    set(CMAKE_SYSTEM_PROGRAM_PATH ${CMAKE_SYSTEM_PROGRAM_PATH} PARENT_SCOPE)
endfunction(NLC_PRELIM_SETTINGS)
############### OK, now have prelim directories as per envcblas.sh, or from NLC_BASE or search for cblas.h

function(VE_NLC_SETUP)
    #set(options I64 MPI SEQ) # so default is NO I64, NO MPI, parallel NLC libs
    set(options "")
    set(oneValueArgs I64 MPI SEQ   ASL FFT CBLAS HET)
    #set(multiValueArgs "")
    cmake_parse_arguments(_nlc "" "${oneValueArgs}" "" ${ARGN})
    message(STATUS "VE_SETUP args: _nlc_I64 ${_nlc_I64} _nlc_MPI ${_nlc_MPI} _nlc_SEQ ${_nlc_SEQ} _nlc_FFT ${_nlc_FFT} _nlc_ASL ${_nlc_ASL} _nlc_CBLAS ${_nlc_CBLAS} _nlc_HET ${_nlc_HET}")
    if(_nlc_I64)
        set(_nlc_CBLAS 0) # not available
        set(_nlc_HET 0)   # not available
    endif()
    if(_nlc_HET)
        set(_nlc_SEQ 0)
    endif()
    message(STATUS "adjusted args: _nlc_I64 ${_nlc_I64} _nlc_MPI ${_nlc_MPI} _nlc_SEQ ${_nlc_SEQ} _nlc_FFT ${_nlc_FFT} _nlc_ASL ${_nlc_ASL} _nlc_CBLAS ${_nlc_CBLAS} _nlc_HET ${_nlc_HET}")

    set(_ve_sequential "_sequential")
    set(_ve_openmp "_openmp")
    if(_nlc_SEQ)
        set(_ve_fopenmp "")
        set(_ve_openmp_or_sequential "${_ve_sequential}")
    else()
        set(_ve_fopenmp "-fopenmp")
        set(_ve_openmp_or_sequential "${_ve_openmap}")
    endif()
    if(_nlc_MPI)
        set(_ve_mpi "_mpi")
    else()
        set(_ve_mpi "")
    endif()
    if(_nlc_I64)
        set(_ve_i64 "_i64")
    else()
        set(_ve_i64 "")
    endif()
    # adjust NCC_INCLUDE_PATH, NFORT_INCLUDE_PATH and VE_LIBRARY_PATH
    NLC_PRELIM_SETTINGS(I64 ${_nlc_I64} MPI ${_nlc_MPI})

    # TODO find_library each required lib (or check library exists)
    set(VE_NLC_ASL_LIBS -lasl${_ve_mpi}${_ve_openmp_or_sequential}${_ve_i64} ${_ve_fopenmp})
    set(VE_NLC_FFT_LIBS -laslfftw3${_ve_mpi}${_ve_i64} -lasl${_ve_mpi}${_ve_openmp_or_sequential}${_ve_i64} ${_ve_fopenmp})
    if(_nlc_I64)
        set(VE_NLC_CBLAS_LIBS "") # I64 ==> cblas N/A
        set(VE_NLC_CBLAS_LIB_PATHS "")
    else()
        set(VE_NLC_CBLAS_LIBS -lcblas -lblas${_ve_openmp_or_sequential} ${ve_fopenmp})
        set(VE_NLC_CBLAS_LIB_PATHS ${VE_NLC_LIBRARY_PATH}/libcblas.a ${VE_NLC_LIBRARY_PATH}/libblas${_ve_openmp_or_sequential}.a)
        if(ve_fopenmp)
            list(APPEND VE_NLC_CBLAS_LIB_PATHS ${VE_NLC_LIBRARY_PATH}/lib${ve_fopenmp}.a)
        endif()
    endif()
    if(_nlc_SEQ OR _nlc_I64)                   # SEQ or I64 ==> het N/A
        set(VE_NLC_HET_LIBS "")
    else()
        set(VE_NLC_HET_LIBS -lheterosolver${_ve_mpi}${_ve_openmp} ${_ve_fopenmp})
    endif()

    set(VE_NLC_LIBS "")
    if(VE_FFT)
        list(INSERT VE_NLC_LIBS 0 "${VE_NLC_FFT_LIBS}")
    endif()
    if(VE_ASL)
        list(INSERT VE_NLC_LIBS 0 "${VE_NLC_ASL_LIBS}")
    endif()
    if(VE_CBLAS)
        list(INSERT VE_NLC_LIBS 0 "${VE_NLC_CBLAS_LIBS}")
    endif()
    if(VE_HET)
        list(INSERT VE_NLC_LIBS 0 "${VE_NLC_HET_LIBS}")
    endif()
    list(REMOVE_DUPLICATES VE_NLC_LIBS)
    VE_JOIN("${VE_NLC_LIBS}" " " VE_NLC_LIBS)

    VE_PREPEND_EACH("${VE_NCC_INCLUDES}" " -I" _tmp)
    set(VE_NLC_C_INCFLAGS "${_ve_fopenmp} ${_tmp}")
    set(VE_NLC_CXX_INCFLAGS "${_ve_fopenmp} ${_tmp}")
    VE_PREPEND_EACH("${VE_NLC_LIBRARY_PATH}" " -L" _tmp)
    set(VE_NLC_C_LDFLAGS "${_ve_fopenmp} ${_tmp}")
    set(VE_NLC_CXX_LDFLAGS "${_ve_fopenmp} ${_tmp}")
    string(STRIP "${VE_NLC_CXX_LDFLAGS}" VE_NLC_CXX_LDFLAGS)

    set(VE_I64 ${_nlc_I64} PARENT_SCOPE)
    set(VE_MPI ${_nlc_MPI} PARENT_SCOPE)
    set(VE_SEQ ${_nlc_SEQ} PARENT_SCOPE)
    set(VE_ASL ${_nlc_ASL} PARENT_SCOPE)
    set(VE_FFT ${_nlc_FFT} PARENT_SCOPE)
    set(VE_CBLAS ${_nlc_CBLAS} PARENT_SCOPE)
    set(VE_HET ${_nlc_HET} PARENT_SCOPE)
    set(VE_NLC_FFT_LIBS "${VE_NLC_FFT_LIBS}" PARENT_SCOPE)
    set(VE_NLC_ASL_LIBS "${VE_NLC_ASL_LIBS}" PARENT_SCOPE)
    set(VE_NLC_CBLAS_LIBS "${VE_NLC_CBLAS_LIBS}" PARENT_SCOPE)
    set(VE_NLC_CBLAS_LIB_PATHS "${VE_NLC_CBLAS_LIB_PATHS}" PARENT_SCOPE)
    set(VE_NLC_HET_LIBS "${VE_NLC_HET_LIBS}" PARENT_SCOPE)
    set(VE_NLC_LIBS "${VE_NLC_LIBS}" CACHE STRING "NLC C/C++ link libraries" FORCE)
    set(VE_NLC_C_INCFLAGS "${VE_NLC_C_INCFLAGS}" CACHE STRING "NLC C include flags" FORCE) 
    set(VE_NLC_CXX_INCFLAGS "${VE_NLC_CXX_INCFLAGS}" CACHE STRING "NLC C++ include flags" FORCE)
    set(VE_NLC_C_LDFLAGS "${VE_NLC_C_LDFLAGS}" CACHE STRING "NLC C LDFLAGS" FORCE)
    set(VE_NLC_CXX_LDFLAGS "${VE_NLC_CXX_LDFLAGS}" CACHE STRING "NLC C++ LDFLAGS" FORCE)
    #mark_as_advanced(VE_NLC_C_INCFLAGS VE_NLC_CXX_INCFLAGS VE_NLC_C_LDFLAGS VE_NLC_CXX_LDFLAGS)
    #set(VE_NLC_LIBS "${VE_NLC_LIBS}" PARENT_SCOPE)
    message(STATUS "VE_NLC_C_INCFLAGS           : ${VE_NLC_C_INCFLAGS}")
    message(STATUS "VE_NLC_C_LDFLAGS            : ${VE_NLC_C_LDFLAGS}")
    #message(STATUS "ve.cmake TODO: C/CXX RPATH linker options to NLC library directories (in case shared libs are used)")
endfunction(VE_NLC_SETUP)

NLC_PRELIM_SETTINGS(INIT)
message(STATUS "NLC preliminary settings:")
message(STATUS "  NLC_HOME            = ${NLC_HOME}")
message(STATUS "  NLC_VERSION         = ${NLC_VERSION}")
message(STATUS " (VE_CBLAS_DIR)       = ${VE_CBLAS_DIR}")
message(STATUS "  ASL_HOME            = ${ASL_HOME}")
message(STATUS "  NLC_LIB_I64         = ${NLC_LIB_I64}")
message(STATUS "  ASL_LIB_I64         = ${ASL_LIB_I64}")
message(STATUS "  NLC_LIB_MPI         = ${NLC_LIB_MPI}")
message(STATUS "  ASL_LIB_MPI         = ${ASL_LIB_MPI}")
#set(VE_NCC_INCLUDES "${VE_NCC_INCLUDES}" CACHE STRING "NLC ncc/nc++ compiler include path (:-separated) like $NCC_INCLUDE_PATH" FORCE)
#set(VE_NFORT_INCLUDES "${VE_NFORT_INCLUDES}" CACHE STRING "NLC nfort compiler include path (:-separated) like $NFORT_INCLUDE_PATH" FORCE)
#set(VE_NLC_LIBRARY_PATH "${VE_NLC_LIBRARY_PATH}" CACHE STRING "NLC library search path (:-separated) like $VE_LIBRARY_PATH" FORCE)
message(STATUS "  VE_NCC_INCLUDES     = ${VE_NCC_INCLUDES} (~ env $NCC_INCLUDES)")
message(STATUS "  VE_NFORT_INCLUDES   = ${VE_NCC_INCLUDES} (~ env $NFORT_INCLUDES)")
message(STATUS "  VE_NLC_LIBRARY_PATH = ${VE_NLC_LIBRARY_PATH} (~ env $VE_LIBRARY_PATH)")
message(STATUS "Adding NLC dirs to cmake SYSTEM search paths...")
message(STATUS "  CMAKE_SYSTEM_PREFIX_PATH  -> ${CMAKE_SYSTEM_PREFIX_PATH}")
message(STATUS "  CMAKE_SYSTEM_LIBRARY_PATH -> ${CMAKE_SYSTEM_LIBRARY_PATH}")
message(STATUS "  CMAKE_SYSTEM_INCLUDE_PATH -> ${CMAKE_SYSTEM_INCLUDE_PATH}")
message(STATUS "  CMAKE_SYSTEM_PROGRAM_PATH -> ${CMAKE_SYSTEM_PROGRAM_PATH}")
# search for programs in the build host directories [find_file and find_path]
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)

set(VE_SEQ 1) # default to nlc using _sequential libs (**no** OpenMP parallelization)
set(VE_FFT 0)
set(VE_ASL 0)
set(VE_CBLAS 1)
set(VE_HET 0)
if(DEFINED $ENV{VE_SEQ})
    set(VE_SEQ $ENV{VE_SEQ})
endif()
if(DEFINED $ENV{VE_FFT})
    set(VE_FFT $ENV{VE_FFT})
endif()
if(DEFINED $ENV{VE_ASL})
    set(VE_ASL $ENV{VE_ASL})
endif()
if(DEFINED $ENV{VE_CBLAS})
    set(VE_CBLAS $ENV{VE_CBLAS})
endif()
if(DEFINED $ENV{VE_HET})
    set(VE_HET $ENV{VE_HET})
endif()
# default to just cblas.   VE_NLC_SETUP should be callable again, by user, but IS NOT [TODO]
VE_NLC_SETUP(I64 ${NLC_LIB_I64} MPI ${NLC_LIB_MPI} SEQ ${VE_SEQ}  FFT ${VE_FFT} ASL ${VE_ASL} CBLAS ${VE_CBLAS} HET ${VE_HET})
#set(VE_I64 ${_nlc_I64} PARENT_SCOPE)
#set(VE_MPI ${_nlc_MPI} PARENT_SCOPE)
#set(VE_SEQ ${_nlc_SEQ} PARENT_SCOPE)
#set(VE_ASL ${_nlc_ASL} PARENT_SCOPE)
#set(VE_FFT ${_nlc_FFT} PARENT_SCOPE)
#set(VE_CBLAS ${_nlc_CBLAS} PARENT_SCOPE)
#set(VE_HET ${_nlc_HET} PARENT_SCOPE)
#set(VE_NLC_FFT_LIBS "${VE_NLC_FFT_LIBS}" PARENT_SCOPE)
#set(VE_NLC_ASL_LIBS "${VE_NLC_ASL_LIBS}" PARENT_SCOPE)
#set(VE_NLC_CBLAS_LIBS "${VE_NLC_CBLAS_LIBS}" PARENT_SCOPE)
#set(VE_NLC_CBLAS_LIB_PATHS "${VE_NLC_CBLAS_LIB_PATHS}" PARENT_SCOPE)
#set(VE_NLC_HET_LIBS "${VE_NLC_HET_LIBS}" PARENT_SCOPE)
#set(VE_NLC_LIBS "${VE_NLC_LIBS}" CACHE STRING "NLC C/C++ link libraries" FORCE)
#set(VE_NLC_C_INCFLAGS "${VE_NLC_C_INCFLAGS}" CACHE STRING "NLC C include flags" FORCE) 
#set(VE_NLC_CXX_INCFLAGS "${VE_NLC_CXX_INCFLAGS}" CACHE STRING "NLC C++ include flags" FORCE)
#set(VE_NLC_C_LDFLAGS "${VE_NLC_C_LDFLAGS}" CACHE STRING "NLC C LDFLAGS" FORCE)
#set(VE_NLC_CXX_LDFLAGS "${VE_NLCXX_C_LDFLAGS}" CACHE STRING "NLC C++ LDFLAGS" FORCE)
message(STATUS "ve.cmake VE_NLC_SETUP:  VE_I64 ${VE_I64} VE_MPI ${VE_MPI} VE_SEQ ${VE_SEQ}")
message(STATUS "ve.cmake                VE_FFT ${VE_FFT} VE_ASL ${VE_ASL} VE_CBLAS ${VE_CBLAS} VE_HET ${VE_HET}")
message(STATUS "ve.cmake              - VE_NLC_FFT_LIBS   ${VE_NLC_FFT_LIBS}")
message(STATUS "ve.cmake              - VE_NLC_ASL_LIBS   ${VE_NLC_ASL_LIBS}")
message(STATUS "ve.cmake              - VE_NLC_CBLAS_LIBS ${VE_NLC_CBLAS_LIBS}")
message(STATUS "ve.cmake              - VE_NLC_CBLAS_LIB_PATHS ${VE_NLC_CBLAS_LIB_PATHS}")
message(STATUS "ve.cmake              - VE_NLC_HET_LIBS   ${VE_NLC_HET_LIBS}")
message(STATUS "ve.cmake   VE_NLC_LIBS         ${VE_NLC_LIBS}") # cache force
message(STATUS "ve.cmake   VE_NLC_C_INCFLAGS   ${VE_NLC_C_INCFLAGS}") # cache force
message(STATUS "ve.cmake   VE_NLC_CXX_INCFLAGS ${VE_NLC_CXX_INCFLAGS}") # cache force
message(STATUS "ve.cmake   VE_NLC_C_LDFLAGS    ${VE_NLC_C_LDCFLAGS}") # cache force
message(STATUS "ve.cmake   VE_NLC_CXX_LDFLAGS  ${VE_NLC_CXX_LDFLAGS}") # cache force
message(STATUS " ...... end test code ......")

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
set(VE_VEPERF_DIR "${VE_VEPERF_DIR}" CACHE PATH "Aurora ftrace/veperf root directory" FORCE)
set(VE_VEPERF_INCLUDE "${VE_VEPERF_INCLUDE}" CACHE PATH "Aurora ftrace/veperf include path" FORCE)
set(VE_VEPERF_INCFLAGS "-I${VE_VEPERF_INCLUDE}" CACHE STRING "Aurora ftrace/veperf include path" FORCE)
set(VE_VEPERF_LDFLAGS "-L${VE_VEPERF_DIR}/lib" CACHE STRING "Aurora ftrace/veperf C/CXX compile/link options" FORCE)
set(VE_VEPERF_LIBS "-lveperf") # NOTE: there are static and shared libs
mark_as_advanced(VE_VEPERF_DIR VE_VEPERF_INCLUDE VE_VEPERF_LDFLAGS VE_VEPERF_LIBS)
# Q: What is difference between   libveperf and libveperf_sp
# TODO: add library existence and compilation checks
message(STATUS "veperf.h                         : ${found_VEPERF_H}")
message(STATUS "VE_VEPERF_INCLUDE                : ${VE_VEPERF_INCLUDE}")
message(STATUS "VE_VEPERF_DIR [ftrace|veperf]    : ${VE_VEPERF_DIR}")
message(STATUS "VE_VEPERF_INCFLAGS               : ${VE_VEPERF_INCFLAGS}")
message(STATUS "VE_VEPERF_LDFLAGS                : ${VE_VEPERF_LDFLAGS}")
message(STATUS "VE_VEPERF_LIBS                   : ${VE_VEPERF_LIBS}")
# Expected libraries: libveperf.{a|so} headers: ftrace.h veperf.h
# add LDFLAGS="-lveperf" (nothing for ftrace)
# VE_VEPERF_DIR for ftrace/veperf
#
# Note: If wanting to use CMAKE_FIND_ROOT_PATH, how does one automatically add lib subdirs?
#  ... so I set up SYSTEM search paths instead ...
#
set(CMAKE_SYSTEM_PREFIX_PATH  ${CMAKE_SYSTEM_PREFIX_PATH} ${VE_VEPERF_DIR})
set(CMAKE_SYSTEM_LIBRARY_PATH ${CMAKE_SYSTEM_LIBRARY_PATH} ${VE_VEPERF_DIR}/lib)
set(CMAKE_SYSTEM_INCLUDE_PATH ${CMAKE_SYSTEM_INCLUDE_PATH} ${VE_VEPERF_DIR}/include)
set(CMAKE_SYSTEM_PROGRAM_PATH ${CMAKE_SYSTEM_PROGRAM_PATH} ${VE_VEPERF_DIR}/bin)
# (later we fix up and remove duplicates)

#set(CMAKE_SYSTEM_PREFIX_PATH  ${CMAKE_SYSTEM_PREFIX_PATH} CACHE STRING "Cmake default search roots" FORCE)
#set(CMAKE_SYSTEM_LIBRARY_PATH ${CMAKE_SYSTEM_LIBRARY_PATH} CACHE STRING "Cmake default library paths" FORCE)
#set(CMAKE_SYSTEM_INCLUDE_PATH ${CMAKE_SYSTEM_INCLUDE_PATH} CACHE STRING "Cmake default include paths" FORCE)
#set(CMAKE_SYSTEM_PROGRAM_PATH ${CMAKE_SYSTEM_PROGRAM_PATH} CACHE STRING "Cmake default binary paths" FORCE)

# The following makes quite verbose debugging output...
#set(CMAKE_C_FLAGS "-fdiag-vector=0" CACHE STRING "C flags")
#set(CMAKE_CXX_FLAGS "-fdiag-vector=0 -fdefer-inline-template-instantiation" CACHE STRING "C++ flags")

message(STATUS "After ve.cmake ..............")
message(STATUS "CMAKE_SYSTEM_NAME           : ${CMAKE_SYSTEM_NAME}")
message(STATUS "CMAKE_SYSTEM_PROCESSOR      : ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "CMAKE_BUILD_TYPE_INIT       : ${CMAKE_BUILD_TYPE_INIT}")
message(STATUS "VE_C_PREINC                 : ${VE_C_PREINC}")
message(STATUS "VE_C_SYSINC                 : ${VE_C_PREINC}")
message(STATUS "VE_CXX_PREINC               : ${VE_CXX_PREINC}")
message(STATUS "VE_CXX_SYSINC               : ${VE_CXX_PREINC}")
message(STATUS "VE_OPT                      : ${VE_OPT}")
message(STATUS "VE_EXEC                     : ${VE_EXEC}")
message(STATUS "VE_MUSL_DIR                 : ${VE_MUSL_DIR}")
message(STATUS "VE_MUSL_FLAGS               : ${VE_MUSL_FLAGS}")
message(STATUS "VE_DL_LIBRARY               : ${VE_DL_LIBRARY}")
message(STATUS "VE_NLC_DIR                  : ${VE_NLC_DIR}")
message(STATUS "VE_NLC_FLAGS                : ${VE_NLC_FLAGS}")
message(STATUS "VE_CBLAS_INCLUDE_DIR        : ${VE_CBLAS_INCLUDE_DIR}")
message(STATUS "NLC_BASE                    : ${NLC_BASE}")
message(STATUS "VE_VEPERF_DIR               : ${VE_VEPERF_DIR}")
message(STATUS "VE_VEPERF_INCLUDE           : ${VE_VEPERF_INCLUDE}")
message(STATUS "VE_VEPERF_INCFLAGS          : ${VE_VEPERF_INCFLAGS}")
message(STATUS "VE_VEPERF_LDFLAGS           : ${VE_VEPERF_LDFLAGS}")
message(STATUS "VE_VEPERF_LIBS              : ${VE_VEPERF_LIBS}")
message(STATUS "CMAKE_SYSTEM_PREFIX_PATH    : ${CMAKE_SYSTEM_PREFIX_PATH}")
message(STATUS "CMAKE_SYSTEM_LIBRARY_PATH   : ${CMAKE_SYSTEM_LIBRARY_PATH}")
message(STATUS "CMAKE_SYSTEM_INCLUDE_PATH   : ${CMAKE_SYSTEM_INCLUDE_PATH}")
message(STATUS "CMAKE_SYSTEM_PROGRAM_PATH   : ${CMAKE_SYSTEM_PROGRAM_PATH}")
message(STATUS "CMAKE_FIND_ROOT_PATH        : ${CMAKE_FIND_ROOT_PATH}")
message(STATUS "CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CMAKE_FIND_ROOT_PATH_MODE_PROGRAM}")
message(STATUS "CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY}")
message(STATUS "CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CMAKE_FIND_ROOT_PATH_MODE_INCLUDE}")
message(STATUS "CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ${CMAKE_FIND_ROOT_PATH_MODE_PACKAGE}")
message(STATUS ".............................")
############################## temporary

#### for use in later Platform/Linux-GNU-<language>-aurora.cmake files ####
function(VE_PARANOID_RPATH)
    set(CMAKE_EXE_LINKER_FLAGS "-v --verbose -z origin ${CMAKE_EXE_LINKER_FLAGS}")
    set(CMAKE_SHARED_LIBFLAGS "-v --verbose -z origin ${CMAKE_SHARED_LIB_FLAGS}") # ???
    message(STATUS "CMAKE_C_LINK_FLAGS   : ${CMAKE_C_LINK_FLAGS}")
    message(STATUS "CMAKE_CXX_LINK_FLAGS : ${CMAKE_C_LINK_FLAGS}")
    message(STATUS "CMAKE_EXE_LINKER_FLAGS : ${CMAKE_EXE_LINKER_FLAGS}")

    message(STATUS "CMAKE_INSTALL_RPATH               i ${CMAKE_INSTALL_RPATH}")
    message(STATUS "CMAKE_INSTALL_RPATH_USE_LINK_PATH i ${CMAKE_INSTALL_RPATH_USE_LINK_PATH}")
    message(STATUS "CMAKE_SKIP_BUILD_RPATH            i ${CMAKE_SKIP_BUILD_RPATH}")
    message(STATUS "CMAKE_BUILD_WITH_INSTALL_RPATH    i ${CMAKE_BUILD_WITH_INSTALL_RPATH}")
    #message(STATUS "CMAKE_INSTALL_NAME_DIR            i ${CMAKE_INSTALL_NAME_DIR}")
    #include(GNUInstallDirs)
    #message(STATUS "CMAKE_INSTALL_LIBDIR              i ${CMAKE_INSTALL_LIBDIR}")

    set(CMAKE_SKIP_BUILD_RPATH FALSE) #false --> allow test within build directory
    set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) # when building, don't use the install RPATH already (but later on when installing)
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE) # auto INSTALL_RPATH settings?
    set(_nlc_ldlibrarypath "$ORIGIN/" "$ORIGIN/../lib" "$ORIGIN/../../")
    message(STATUS " ve_paranoid_rpath : CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
    message(STATUS " ve_paranoid_rpath : VE_VE                = ${VE_VE}")
    message(STATUS " ve_paranoid_rpath : VE_HOME              = ${VE_HOME}")
    message(STATUS " ve_paranoid_rpath : VE_OPT               = ${VE_OPT}")
    message(STATUS " ve_paranoid_rpath : VE_NLC_LIBRARY_PATH  = ${VE_NLC_LIBRARY_PATH}")
    if(IS_DIRECTORY ${CMAKE_INSTALL_PREFIX}/lib)
        list(APPEND _nlc_ldlibrarypath ${CMAKE_INSTALL_PREFIX}/lib)
    else()
        message(STATUS "RPATH skipping CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX} -- no lib subdir")
    endif()
    if(NOT ${VE_VE} STREQUAL "")
        list(APPEND _nlc_ldlibrarypath ${VE_VE}/lib)
    endif()
    if(NOT ${VE_OPT} STREQUAL "" AND IS_DIRECTORY ${VE_OPT}/lib)
        list(APPEND _nlc_ldlibrarypath ${VE_OPT}/lib)
    endif()
    if(NOT ${VE_HOME} STREQUAL "" AND IS_DIRECTORY ${VE_NLC_HOME}/lib)
        list(APPEND _nlc_ldlibrarypath ${VE_HOME}/lib)
    endif()
    list(APPEND _nlc_ldlibrarypath ${VE_NLC_LIBRARY_PATH})
    list(REMOVE_DUPLICATES _nlc_ldlibrarypath)
    set(CMAKE_INSTALL_RPATH "${_nlc_ldlibrarypath}")   # must be a semicolon-separated list
    message(STATUS "CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_RPATH}")

    #set(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG     -Wl,-rpath, )
    #set(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP : )
    #set(CMAKE_SHARED_LIBRARY_RPATH_LINK_C_FLAG  -Wl,-rpath-link, )
    message(STATUS "CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG ${CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG}")
    message(STATUS "CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP ${CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP}")
    message(STATUS "CMAKE_SHARED_LIBRARY_RPATH_LINK_C_FLAG ${CMAKE_SHARED_LIBRARY_RPATH_LINK_C_FLAG}")

    # ; --> : and prepend -Wl,-rpath-link [or -Wl,-rpath]
    VE_JOIN("${_nlc_ldlibrarypath}" "${CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP}" _nlc_ldlibrarypath)
    set(_nlc_ldlibrarypath "${CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG}${_nlc_ldlibrarypath}")
    set(VE_LINK_RPATH "${_nlc_ldlibrarypath}" CACHE STRING "VE C/C++ -Wl,-rpath suggestion" FORCE)
    unset(_nlc_ldlibrarypath)

    message(STATUS "CMAKE_INSTALL_RPATH               f ${CMAKE_INSTALL_RPATH}")
    message(STATUS "CMAKE_INSTALL_RPATH_USE_LINK_PATH f ${CMAKE_INSTALL_RPATH_USE_LINK_PATH}")
    message(STATUS "CMAKE_SKIP_BUILD_RPATH            f ${CMAKE_SKIP_BUILD_RPATH}")
    message(STATUS "CMAKE_BUILD_WITH_INSTALL_RPATH    f ${CMAKE_BUILD_WITH_INSTALL_RPATH}")
    message(STATUS "VE_LINK_RPATH                     f ${VE_LINK_RPATH}")
    #message(STATUS "CMAKE_INSTALL_NAME_DIR            f ${CMAKE_INSTALL_NAME_DIR}")

endfunction()

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
    message(STATUS "    CMAKE_SYSTEM_PROCESSOR          ${CMAKE_SYSTEM_PROCESSOR}")
    message(STATUS "    CMAKE_UNIX                      ${CMAKE_UNIX}")
    message(STATUS "    CMAKE_C_COMPILER_ID             ${CMAKE_C_COMPILER_ID}")
    message(STATUS "    CMAKE_CXX_COMPILER_ID           ${CMAKE_CXX_COMPILER_ID}")
    message(STATUS "    CMAKE_COMPILER_IS_GNUCC         ${CMAKE_COMPILER_IS_GNUCC}")
    message(STATUS "    CMAKE_COMPILER_IS_GNUCXX        ${CMAKE_COMPILER_IS_GNUCXX}")
    message(STATUS "    CMAKE_C_COMPILER_VERSION        ${CMAKE_C_COMPILER_VERSION}")
    message(STATUS "    CMAKE_CXX_COMPILER_VERSION      ${CMAKE_CXX_COMPILER_VERSION}")
    message(STATUS "    CMAKE_BUILD_TYPE_INIT           ${CMAKE_BUILD_TYPE_INIT}")
    message(STATUS "    --------- paths,flags ---------")
    message(STATUS "    VE_C_PREINC                     ${VE_C_PREINC}")
    message(STATUS "    VE_C_SYSINC                     ${VE_C_SYSINC}")
    message(STATUS "    VE_CXX_PREINC                   ${VE_CXX_PREINC}")
    message(STATUS "    VE_CXX_SYSINC                   ${VE_CXX_PREINC}")
    message(STATUS "    VE_OPT                          ${VE_OPT}")
    message(STATUS "    VE_EXEC                         ${VE_EXEC}")
    message(STATUS "    VE_MUSL_DIR                     ${VE_MUSL_DIR}")
    message(STATUS "    VE_MUSL_FLAGS                   ${VE_MUSL_FLAGS}")
    message(STATUS "    VE_DL_LIBRARY                   ${VE_DL_LIBRARY}")
    message(STATUS "    VE_NLC_DIR                      ${VE_NLC_DIR}")
    message(STATUS "    VE_NLC_FLAGS                    ${VE_NLC_FLAGS}")
    message(STATUS "    VE_CBLAS_INCLUDE_DIR            ${VE_CBLAS_INCLUDE_DIR}")
    message(STATUS "    NLC_BASE                        ${NLC_BASE}")
    message(STATUS "    VE_VEPERF_DIR                   ${VE_VEPERF_DIR}")
    message(STATUS "    VE_VEPERF_INCLUDE               ${VE_VEPERF_INCLUDE}")
    message(STATUS "    VE_VEPERF_INCFLAGS              ${VE_VEPERF_INCFLAGS}")
    message(STATUS "    VE_VEPERF_LDFLAGS               ${VE_VEPERF_LDFLAGS}")
    message(STATUS "    VE_VEPERF_LIBS                  ${VE_VEPERF_LIBS}")
    message(STATUS "    CMAKE_SYSTEM_PREFIX_PATH        ${CMAKE_SYSTEM_PREFIX_PATH}")
    message(STATUS "    CMAKE_SYSTEM_LIBRARY_PATH       ${CMAKE_SYSTEM_LIBRARY_PATH}")
    message(STATUS "    CMAKE_SYSTEM_INCLUDE_PATH       ${CMAKE_SYSTEM_INCLUDE_PATH}")
    message(STATUS "    CMAKE_SYSTEM_PROGRAM_PATH       ${CMAKE_SYSTEM_PROGRAM_PATH}")
    message(STATUS "    CMAKE_FIND_ROOT_PATH              ${CMAKE_FIND_ROOT_PATH}")
    message(STATUS "    CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CMAKE_FIND_ROOT_PATH_MODE_PROGRAM}")
    message(STATUS "    CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY}")
    message(STATUS "    CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CMAKE_FIND_ROOT_PATH_MODE_INCLUDE}")
    message(STATUS "    CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ${CMAKE_FIND_ROOT_PATH_MODE_PACKAGE}")
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
    message(STATUS "    CMAKE_C_COMPILE_OPTIONS_PIC          ${CMAKE_C_COMPILE_OPTIONS_PIC}")
    message(STATUS "    CMAKE_C_LINK_EXECUTABLE              ${CMAKE_C_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_C_CREATE_SHARED_LIBRARY        ${CMAKE_C_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_C_CREATE_STATIC_LIBRARY        ${CMAKE_C_CREATE_STATIC_LIBRARY}")
    message(STATUS "    CMAKE_C_CREATE_PREPROCESSED_SOURCE   ${CMAKE_C_CREATE_PREPROCESSED_SOURCE}")
    message(STATUS "    CMAKE_C_CREATE_ASSEMBLY_SOURCE       ${CMAKE_C_CREATE_ASSEMBLY_SOURCE}")
    message(STATUS "    CMAKE_SHARED_C_LINK_FLAGS            ${CMAKE_C_LINK_FLAGS}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_CXX_COMPILER                   ${CMAKE_CXX_COMPILER}")
    message(STATUS "    CMAKE_C_OUTPUT_EXTENSION             ${CMAKE_CXX_OUTPUT_EXTENSION}")
    message(STATUS "    CMAKE_CXX_FLAGS                      ${CMAKE_CXX_FLAGS}")
    message(STATUS "    CMAKE_CXX_LINK_FLAGS                 ${CMAKE_CXX_LINK_FLAGS}")
    message(STATUS "    CMAKE_CXX_FLAGS_RELEASE              ${CMAKE_CXX_FLAGS_RELEASE}")
    message(STATUS "    CMAKE_CXX_FLAGS_DEBUG                ${CMAKE_CXX_FLAGS_DEBUG}")
    message(STATUS "    CMAKE_CXX_COMPILE_OBJECT             ${CMAKE_CXX_COMPILE_OBJECT}")
    message(STATUS "    CMAKE_CXX_COMPILE_OPTIONS_PIC        ${CMAKE_CXX_COMPILE_OPTIONS_PIC}")
    message(STATUS "    CMAKE_CXX_LINK_EXECUTABLE            ${CMAKE_CXX_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_SHARED_CXX_LINK_FLAGS          ${CMAKE_CXX_LINK_FLAGS}")
    message(STATUS "    CMAKE_CXX_CREATE_SHARED_LIBRARY      ${CMAKE_CXX_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_CXX_CREATE_STATIC_LIBRARY      ${CMAKE_CXX_CREATE_STATIC_LIBRARY}")
    message(STATUS "    CMAKE_CXX_CREATE_PREPROCESSED_SOURCE ${CMAKE_CXX_CREATE_PREPROCESSED_SOURCE}")
    message(STATUS "    CMAKE_CXX_CREATE_ASSEMBLY_SOURCE     ${CMAKE_CXX_CREATE_ASSEMBLY_SOURCE}")
    message(STATUS "    -------------------------------")
endfunction()

show_cmake_stuff("End of ve.cmake")

# vim: et ts=4 sw=4 ai
