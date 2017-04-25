#
# cmake-3.0 an be made to work, but cmake-3.8 pulls in a
# Platform/SX-Initialize file that is just too convenient
#    (not sure about actual minimum cmake version)
cmake_minimum_required(VERSION 3.8.0 FATAL_ERROR)
# cmake-3.8.0 built from sources without much difficulty
# my copy is in /gfs/nlabhpg/cmake3.8/
# and is available for me after bash:$ source ~/bashrc-local
#                                   or source /mnt/diamond2/home/4gi/nlabhpg/bashrc-local
# (sources in /fgs/nlabhpg/cmake-3.8.0/

project(cmake-sample C CXX)
# cmake-3.8:  patches no longer required
#if(NECSX)
#    fix_bad_gnu_things()
#    sx_local_settings()
#    if(SX_TRACE)
#        message(STATUS "after fix_bad_gnu_things, CMAKE_C_FLAGS_RELWITHDEBINFO is ${CMAKE_C_FLAGS_RELWITHDEBINFO}")
#    endif()
#endif()

# add to (or override) your flags... example:
#   for any environment :
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Kgcc -size_t64 -v")
# NOTE: -size_t64 must **also** be given to linker:
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-size_t64")
#         ^^^ or SHARED or MODULE
# or for just foo, set_target_properties(foo PROPERTIES LINK_FLAGS -Wl,-size_t64)

#  for Release mode only :
#    (You can set other "standard" strings in Platform/SX-Initialize)
#    - make rel
#    - or cmake -DCMAKE_BUILT_TYPE=Release ...
#    will now include a whole pile of options
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${SX_CCXXFLAGS_WARNALL} ${SX_CCXXFLAGS_VERBOSE} ${SX_LINK_LIBRARIES}")

add_executable(foo foo.cc)

add_executable(speed64 speed.cpp)
target_link_libraries(speed64 "-lcblas -lblas -lf2003")

add_library(spd libspeed.cpp libspeed.hpp) # create libspd.a
set_target_properties(spd PROPERTIES COMPILE_FLAGS "-Tauto,all")

add_executable(speed2 speed2.cpp)
add_dependencies(speed2 spd)
target_link_libraries(speed2 "-Wl,-h,muldefs,-h,lib_cyclic -L. libspd.a -lcblas -lblas -lf2003")

