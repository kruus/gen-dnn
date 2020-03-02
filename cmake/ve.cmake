#
# This is NOT the Aurora VE toolchain file.
#
# It is here only to serve as an example of where toolkits may need
# to encroach on a hypothetical `cmake -DCMAKE_TOOLCHAIN_FILE=cmake/ve.cmake`
# build.
#

# We are cross-compiling for ...
set(CMAKE_SYSTEM_PROCESSOR aurora)

set(NECVE  1 CACHE BOOL "Set thing up for NEC Aurora vector processor" FORCE)

# ve.cmake toolchain is invoked by cmake PROJECT command, after cmake
# using uname (or whatever) to determine a host system such as 'Linux'.
# just in case... (be sure to force correct Platform/ cmake magic file names)
if(${CMAKE_HOST_SYSTEM_NAME})
    set(CMAKE_SYSTEM_NAME ${CMAKE_HOST_SYSTEM_NAME})
else()
    set(CMAKE_SYSTEM_NAME Linux)
endif()

# we are debugging a fair bit... default value for CMAKE_BUILD_TYPE
set(CMAKE_BUILD_TYPE_INIT "RelWithDebInfo")

# It might take a well to perfect a new toolchain file :(
macro(show_cmake_stuff MSG)
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
    message(STATUS "    --------- VE paths,flags ---------")
    # snip, snip, ...
    message(STATUS "    --------- cmake paths,flags ---------")
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
    message(STATUS "    BUILD_STATIC_LIBS               ${BUILD_STATIC_LIBS}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_C_COMPILER                      ${CMAKE_C_COMPILER}")
    message(STATUS "    CMAKE_C_OUTPUT_EXTENSION              ${CMAKE_C_OUTPUT_EXTENSION}")
    message(STATUS "    CMAKE_C_FLAGS                         ${CMAKE_C_FLAGS}")
    message(STATUS "    CMAKE_C_FLAGS_RELEASE                 ${CMAKE_C_FLAGS_RELEASE}")
    message(STATUS "    CMAKE_C_FLAGS_DEBUG                   ${CMAKE_C_FLAGS_DEBUG}")
    message(STATUS "    CMAKE_C_COMPILE_OBJECT                ${CMAKE_C_COMPILE_OBJECT}")
    message(STATUS "    CMAKE_C_COMPILE_OPTIONS_PIC           ${CMAKE_C_COMPILE_OPTIONS_PIC}")
    message(STATUS "    CMAKE_C_LINK_EXECUTABLE               ${CMAKE_C_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_C_LINK_FLAGS                    ${CMAKE_C_LINK_FLAGS}")
    message(STATUS "    CMAKE_C_CREATE_SHARED_LIBRARY         ${CMAKE_C_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_C_CREATE_STATIC_LIBRARY         ${CMAKE_C_CREATE_STATIC_LIBRARY}")
    message(STATUS "    CMAKE_C_CREATE_PREPROCESSED_SOURCE    ${CMAKE_C_CREATE_PREPROCESSED_SOURCE}")
    message(STATUS "    CMAKE_C_CREATE_ASSEMBLY_SOURCE        ${CMAKE_C_CREATE_ASSEMBLY_SOURCE}")
    message(STATUS "    CMAKE_SHARED_C_LINK_FLAGS             ${CMAKE_SHARED_C_LINK_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_C_FLAGS          ${CMAKE_SHARED_LIBRARY_C_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS   ${CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS}")
    message(STATUS "    CMAKE_STATIC_LIBRARY_C_FLAGS          ${CMAKE_STATIC_LIBRARY_C_FLAGS}")
    message(STATUS "    CMAKE_STATIC_LIBRARY_CREATE_C_FLAGS   ${CMAKE_STATIC_LIBRARY_CREATE_C_FLAGS}")
    message(STATUS "    -------------------------------")
    message(STATUS "    CMAKE_CXX_COMPILER                    ${CMAKE_CXX_COMPILER}")
    message(STATUS "    CMAKE_CXX_OUTPUT_EXTENSION            ${CMAKE_CXX_OUTPUT_EXTENSION}")
    message(STATUS "    CMAKE_CXX_FLAGS                       ${CMAKE_CXX_FLAGS}")
    message(STATUS "    CMAKE_CXX_FLAGS_RELEASE               ${CMAKE_CXX_FLAGS_RELEASE}")
    message(STATUS "    CMAKE_CXX_FLAGS_DEBUG                 ${CMAKE_CXX_FLAGS_DEBUG}")
    message(STATUS "    CMAKE_CXX_COMPILE_OBJECT              ${CMAKE_CXX_COMPILE_OBJECT}")
    message(STATUS "    CMAKE_CXX_COMPILE_OPTIONS_PIC         ${CMAKE_CXX_COMPILE_OPTIONS_PIC}")
    message(STATUS "    CMAKE_CXX_LINK_EXECUTABLE             ${CMAKE_CXX_LINK_EXECUTABLE}")
    message(STATUS "    CMAKE_CXX_LINK_FLAGS                  ${CMAKE_CXX_LINK_FLAGS}")
    message(STATUS "    CMAKE_CXX_CREATE_SHARED_LIBRARY       ${CMAKE_CXX_CREATE_SHARED_LIBRARY}")
    message(STATUS "    CMAKE_CXX_CREATE_STATIC_LIBRARY       ${CMAKE_CXX_CREATE_STATIC_LIBRARY}")
    message(STATUS "    CMAKE_CXX_CREATE_PREPROCESSED_SOURCE  ${CMAKE_CXX_CREATE_PREPROCESSED_SOURCE}")
    message(STATUS "    CMAKE_CXX_CREATE_ASSEMBLY_SOURCE      ${CMAKE_CXX_CREATE_ASSEMBLY_SOURCE}")
    message(STATUS "    CMAKE_SHARED_CXX_LINK_FLAGS           ${CMAKE_CXX_LINK_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_CXX_FLAGS        ${CMAKE_SHARED_LIBRARY_CXX_FLAGS}")
    message(STATUS "    CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS ${CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS}")
    message(STATUS "    CMAKE_STATIC_LIBRARY_CXX_FLAGS        ${CMAKE_STATIC_LIBRARY_CXX_FLAGS}")
    message(STATUS "    CMAKE_STATIC_LIBRARY_CREATE_CXX_FLAGS ${CMAKE_STATIC_LIBRARY_CREATE_CXX_FLAGS}")
    message(STATUS "    -------------------------------")
endmacro()

#show_cmake_stuff("End of ve.cmake")
# vim: et ts=4 sw=4 ai
