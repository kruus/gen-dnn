#==============================================
# vim: sw=4 ts=4 et tw=120
# Copyright 2017 NEC Corporation
#
#==============================================
message(STATUS " *** Toolchain file: sx.cmake ***")

SET(CMAKE_SYSTEM_NAME SX)

# with cmake >= 3.8, most details can move into the
# Platform/SX-foo and Platform/SX-Initialize files.
SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CACHE PATH
    "cmake additional Module/Platform path")

# cross-compilers CMAKE_${lang}_COMPILER moved to Platform/SX-*
#set(CMAKE_Fortran_COMPILER "sxf03") # ?
# For SX, sxar is a script that first runs a pre-link phase
SET(CMAKE_AR "${CMAKE_MODULE_PATH}/Platform/SX-ar" CACHE FILEPATH
    "Archiver script")

SET(SX_TRACE TRUE)
if(SX_TRACE)
    message(STATUS "CMAKE_SYSTEM_NAME   ${CMAKE_SYSTEM_NAME}")
    message(STATUS "CMAKE_MODULE_PATH   ${CMAKE_MODULE_PATH}")
endif()
