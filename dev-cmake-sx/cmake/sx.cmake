#==============================================
# vim: sw=4 ts=4 et tw=120
# Copyright 2017 NEC Corporation
#
#==============================================
message(STATUS " *** Toolchain file: sx.cmake ***")

# The Platform files (esp. SX-Initialize "common" init) are known to work with 3.8.0
# 3.0 does not pull in this file, which just makes life so much easier
cmake_minimum_required(VERSION 3.8.0 FATAL_ERROR)

#SET(CMAKE_SYSTEM_NAME Generic) # incorrectly assumes GNU, so CMAKE_BUILD_TYPE options are WRONG
SET(CMAKE_SYSTEM_NAME SX)   # this would need our own Platforms/SX.cmake file
# this seems to be somewhat flaky
#SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" CACHE PATH "cmake additional Module path")
# but this seems to work (In fact, the module path ONLY looks in source_dir)
SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}"       CACHE PATH "cmake additional Module path")

# cross-compilers CMAKE_${lang}_COMPILER moved to Platform/SX-*
#set(CMAKE_Fortran_COMPILER "sxf03") # ?
# For SX, sxar is a script that first runs a pre-link phase
SET(CMAKE_AR     "${CMAKE_MODULE_PATH}/Platform/SX-ar" CACHE FILEPATH "Archiver script")

SET(SX_TRACE TRUE)
if(SX_TRACE)
    message(STATUS "CMAKE_SYSTEM_NAME   ${CMAKE_SYSTEM_NAME}")
    message(STATUS "CMAKE_MODULE_PATH   ${CMAKE_MODULE_PATH}")
endif()

# rest of things I think are not needed for cmake-3.8 and Platform/SX-foo files
#------------------------------------------------------------------------------
#SET(CMAKE_RANLIB "${CMAKE_CURRENT_SOURCE_DIR}/ranlib" CACHE FILEPATH "ranlib")
# default is "UNSET" which is probably OK

# If we are running cmake-3.0, then Platform/SX-Initialize will not automatically run...
# Doesn't work: include("Platform/SX-Initialize")

# These probably should bet set up from CMakeLists.txt
#   see build/CMakeCache.txt for some SX_foo settings ???
#SET(CMAKE_C_FLAGS "-Kgcc -size_t64 -Caopt -v" CACHE STRING "C flags")
#SET(CMAKE_CXX_FLAGS "-Kgcc,exceptions -size_t64 -Caopt -v" CACHE STRING "C++ flags")

#message(STATUS "CMAKE_VERSION ${CMAKE_VERSION}")
# Moved into Platform/SX-Initialize files ...
#SET(CMAKE_FIND_ROOT_PATH "/SX")
#SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
#SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

#function(sx_local_settings)
#    #set(CMAKE_CXX_LIBRARY_ARCHITECTURE lib64)
#endfunction()
#

