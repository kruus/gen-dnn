#==============================================
# vim: sw=4 ts=4 et tw=120
# Copyright 2017 NEC Corporation
#
#==============================================
message(STATUS " *** Toolchain file: sx.cmake (size_t64) ***")
#SET(CMAKE_SYSTEM_NAME Generic) # incorrectly assumes GNU, so CMAKE_BUILD_TYPE options are WRONG
SET(CMAKE_SYSTEM_NAME SX)   # this would need our own Platforms/SX.cmake file
# this seems to be somewhat flaky
#SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" CACHE PATH "cmake additional Module path")
# but this seems to work (In fact, the module path ONLY looks in source_dir)
SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}"       CACHE PATH "cmake additional Module path")

# specify the cross compiler
SET(CMAKE_C_COMPILER   sxcc)
SET(CMAKE_CXX_COMPILER sxc++)
SET(CMAKE_AR     "${CMAKE_MODULE_PATH}/Platform/SX-ar" CACHE FILEPATH "Archiver")

SET(SX_TRACE FALSE)
if(SX_TRACE)
    message(STATUS "CMAKE_SYSTEM_NAME   ${CMAKE_SYSTEM_NAME}")
    message(STATUS "CMAKE_MODULE_PATH   ${CMAKE_MODULE_PATH}")
endif()
#SET(CMAKE_RANLIB "${CMAKE_CURRENT_SOURCE_DIR}/ranlib" CACHE FILEPATH "ranlib")


# option: size_t64 needs special library FIND path
SET(CMAKE_C_FLAGS "-Kgcc -size_t64 -Caopt -v" CACHE STRING "C flags")
SET(CMAKE_CXX_FLAGS "-Kgcc,exceptions -size_t64 -Caopt -v" CACHE STRING "C++ flags")

# Moved into Platform/SX* files ...
#SET(CMAKE_FIND_ROOT_PATH "/SX")
#SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
#SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

function(sx_local_settings)
    set(CMAKE_CXX_LIBRARY_ARCHITECTURE lib64)
endfunction()
#

