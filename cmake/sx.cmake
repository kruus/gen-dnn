#==============================================
# vim: sw=4 ts=4 et tw=120
# Copyright 2017 NEC Corporation
#
#==============================================

set(NECSX FALSE)
if("$ENV{CC}" MATCHES "sxcc.*" OR "$ENV{CXX}" MATCHES "sxc[+][+].*")
    # Detect sxcc or sxc++ from environment
    #    (ex. export CC=sxcc for bash shell)
    # We assume PATH and environmet is set so sx cross-compiler
    # tools are all available
    set(NECSX TRUE)
    find_program(CMAKE_C_COMPILER   sxcc PATH)
    find_program(CMAKE_CXX_COMPILER sxc++ PATH)
    #set(SX_ROOT "$ENV{SX_ROOT}")
    string(REGEX REPLACE "/usr/bin.*" "" SX_ROOT "${CMAKE_CXX_COMPILER}")
    message(STATUS "    CMAKE_C_COMPILER                ${CMAKE_C_COMPILER}")
    message(STATUS "    CMAKE_CXX_COMPILER              ${CMAKE_CXX_COMPILER}")
    message(STATUS "    SX_ROOT                         ${SX_ROOT}")
    set(CMAKE_FIND_ROOT_PATH "${SX_ROOT}")
    set(CMAKE_SYSTEM_NAME "SX") # automatically signals cross-compilation
    set(CMAKE_SYSTEM_VERSION "SX-UX") # not used much
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake") # find SX Platform stuff
    message(STATUS "    CMAKE_SYSTEM_NAME               ${CMAKE_SYSTEM_NAME}")
    message(STATUS "    CMAKE_SYSTEM_VERSION            ${CMAKE_SYSTEM_VERSION}")

    # maybe we need toolchain for next to be set?
    message(STATUS "    CMAKE_CROSSCOMPILING           ${CMAKE_CROSSCOMPILING}")

    if(TRUE) # SKIPS testing the compiler, which migh be trying to RUN stuff
        include(CMakeForceCompiler)
        cmake_force_c_compiler(sxcc GNU)
        cmake_force_c_compiler(sxc++ GNU)
    endif()
    set(CMAKE_C_LINKER_PREFERENCE C)
    set(CMAKE_CXX_LINKER_PREFERENCE CXX)

    # search for programs in the build target (SX_ROOT) and then host directories
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
    # for libraries and headers in the target directories
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

    #set(CMAKE_C_COMPILER_ID "SX") # GNU compiler options do not work (uggh)
    #set(CMAKE_CXX_COMPILER_ID "SX")
    #set(CMAKE_COMPILER_IS_SXCC 1)
    #set(CMAKE_COMPILER_IS_SX 1)

endif()

if(NECSX)
    # No support for alternately named compiler versions:
    find_program(CMAKE_AR sxar PATH)
    find_program(CMAKE_STRIP sxstrip PATH)
    find_program(CMAKE_STRIP sxstrip PATH)
    # Note: sxc++ -prelink $*; sxar r $* $@
    set(CMAKE_FIND_LIBRARY_PREFIXES "/SX/lib")
    set(CMAKE_FIND_LIBRARY_SUFFIXES "")
    # Somehow this sets up some stuff OK ?
    include(${CMAKE_ROOT}/Modules/CMakeCInformation.cmake)
    include(${CMAKE_ROOT}/Modules/CMakeCXXInformation.cmake)
endif()

function(show_cmake_stuff MSG)
    message(STATUS "${MSG}")
    message(STATUS "    NECSX                           ${NECSX}")
    message(STATUS "    CMAKE_ROOT                      ${CMAKE_ROOT}")
    message(STATUS "    CMAKE_GENERATOR                 ${CMAKE_GENERATOR}")
    message(STATUS "    ENV{CC}                         $ENV{CC}")
    message(STATUS "    ENV{CXX}                        $ENV{CXX}")
    message(STATUS "CMAKE_C_LINKER_PREFERENCE C ${CMAKE_C_LINKER_PREFERENCE}")
    message(STATUS "CMAKE_CXX_LINKER_PREFERENCE C ${CMAKE_CXX_LINKER_PREFERENCE}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_VERSION                   ${CMAKE_VERSION}")
    message(STATUS "    CMAKE_SYSTEM_NAME               ${CMAKE_SYSTEM_NAME}")
    message(STATUS "    CMAKE_UNIX                      ${CMAKE_UNIX}")
    message(STATUS "    CMAKE_C_COMPILER_ID             ${CMAKE_C_COMPILER_ID}")
    message(STATUS "    CMAKE_CXX_COMPILER_ID           ${CMAKE_CXX_COMPILER_ID}")
    message(STATUS "    CMAKE_COMPILER_IS_GNUCC         ${CMAKE_COMPILER_IS_GNUCC}")
    message(STATUS "    CMAKE_COMPILER_IS_GNUCXX        ${CMAKE_COMPILER_IS_GNUCXX}")
    message(STATUS "    -------------------------------")
    message(STATUS "    BUILD_SHARED_LIBS               ${BUILD_SHARED_LIBS}")
    message(STATUS "    CMAKE_AR                        ${CMAKE_AR}")
    message(STATUS "    CMAKE_C_OUTPUT_EXTENSION        ${CMAKE_C_OUTPUT_EXTENSION}")
    message(STATUS "    CMAKE_EXE_LINKER_FLAGS          ${CMAKE_EXE_LINKER_FLAGS}")
    message(STATUS "    CMAKE_MODULE_LINKER_FLAGS       ${CMAKE_MODULE_LINKER_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LINKER_FLAGS       ${CMAKE_SHARED_LINKER_FLAGS}")
    message(STATUS "    CMAKE_EXE_LINKER_FLAGS          ${CMAKE_EXE_LINKER_FLAGS}")
    message(STATUS "    CMAKE_MODULE_LINKER_FLAGS       ${CMAKE_MODULE_LINKER_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LINKER_FLAGS       ${CMAKE_SHARED_LINKER_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_C_FLAGS    ${CMAKE_SHARED_LIBRARY_C_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS ${CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS}")
    message(STATUS "    CMAKE_SHARED_C_LINK_FLAGS       ${CMAKE_C_LINK_FLAGS}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_C_COMPILER                ${CMAKE_C_COMPILER}")
    message(STATUS "    CMAKE_C_FLAGS                   ${CMAKE_C_FLAGS}")
    message(STATUS "    CMAKE_C_FLAGS_RELEASE           ${CMAKE_C_FLAGS_RELEASE}")
    message(STATUS "    CMAKE_C_FLAGS_DEBUG             ${CMAKE_C_FLAGS_DEBUG}")
    message(STATUS "    CMAKE_C_COMPILE_OBJECT        ${CMAKE_C_COMPILE_OBJECT}")
    message(STATUS "    CMAKE_C_LINK_EXECUTABLE       ${CMAKE_C_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_C_CREATE_SHARED_LIBRARY ${CMAKE_C_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_C_CREATE_STATIC_LIBRARY ${CMAKE_C_CREATE_STATIC_LIBRARY}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_CXX_COMPILER              ${CMAKE_CXX_COMPILER}")
    message(STATUS "    CMAKE_CXX_FLAGS                 ${CMAKE_CXX_FLAGS}")
    message(STATUS "    CMAKE_CXX_LINK_FLAGS            ${CMAKE_CXX_LINK_FLAGS}")
    message(STATUS "    CMAKE_CXX_FLAGS_RELEASE         ${CMAKE_CXX_FLAGS_RELEASE}")
    message(STATUS "    CMAKE_CXX_FLAGS_DEBUG           ${CMAKE_CXX_FLAGS_DEBUG}")
    message(STATUS "    CMAKE_CXX_COMPILE_OBJECT        ${CMAKE_CXX_COMPILE_OBJECT}")
    message(STATUS "    CMAKE_CXX_LINK_EXECUTABLE       ${CMAKE_CXX_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_CXX_CREATE_SHARED_LIBRARY ${CMAKE_CXX_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_CXX_CREATE_STATIC_LIBRARY ${CMAKE_CXX_CREATE_STATIC_LIBRARY}")
    message(STATUS "    -------------------------------")
endfunction()

# ------ Suggestions -------------
set(SX_CFLAGS_INLINING "-pi auto")
set(SX_CFLAGS_NOINLINING "-pi noauto")
set(SX_CCXXFLAGS_QUIET = "-pi nomsg -pvctl nomsg -O nomsg")
set(SX_CCXXFLAGS_VERBOSE = "-ftrace -R,diaglist,fmtlist -pvctl,fullmsg,noneighbors")
set(SX_CCXXFLAGS_WARNALL = "-w all")

set(SX_CFLAGS_C99 = "${SX_CFLAGS} -f90lib -Kc99,gcc")
set(SX_CXXFLAGS_C11 = "${SX_CXXFLAGS} -f90lib -K exceptions rtti cpp11 gcc)")
set(SX_CXXFLAGS_C11 = "${SX_CXXFLAGS} -f90lib -K exceptions rtti cpp11 gcc)")
#set(SX_CXXFLAGS_C11 = "${SX_CXXFLAGS} -f90lib -K exceptions -K rtti -K cpp11 -K gcc")
set(SX_LINK_FLAGS "${SX_LINK_FLAGS} -L/SX/usr/lib")
set(SX_LINK_LIBRARIES "${SX_LINK_LIBRARARIES} -llapack -lcblas -lblas")
# ---------------------------------

function(set_cmake_ccxx SUFFIX OPT)
    set(CMAKE_C_${SUFFIX} "${OPT}" PARENT_SCOPE)
    set(CMAKE_CXX_${SUFFIX} "${OPT}" PARENT_SCOPE)
endfunction()

if(NECSX)
    set_cmake_ccxx("FLAGS_DEBUG" "-g -ftrace -Cnoopt")
    set_cmake_ccxx("FLAGS_RELEASE" "-Caopt")
    set_cmake_ccxx("FLAGS_MINSIZEREL" "-Cvopt -Os")
    set_cmake_ccxx("FLAGS_RELWITHDEBINFO" "-g -Cvopt")
    set(CMAKE_SHARED_LIBRARY_CREATE_CCXX_FLAGS "-Wl,-shared")
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "-g -ftrace")
    set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "-g")
endif()
