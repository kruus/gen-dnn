show_cmake_stuff("After default C compiler detection as Linux-GNU ...")
message(STATUS "Linux-GNU-C-aurora patches HERE :   ${CMAKE_CURRENT_LIST_FILE}")

#nc++:   does not support -fvisibility= or -fvisibility-inlines-hidden
unset(CMAKE_C_COMPILE_OPTIONS_VISIBILITY)
unset(CMAKE_C_COMPILE_OPTIONS_VISIBILITY_INLINES_HIDDEN)

set(CMAKE_C_FLAGS_RELEASE_INIT "${CMAKE_C_FLAGS_RELEASE_INIT} -mretain-list-vector")
set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "${CMAKE_C_FLAGS_RELWITHDEBINFO_INIT} -mretain-list-vector")
# -Os is not supported
set(CMAKE_C_FLAGS_MINSIZEREL_INIT CMAKE_C_FLAGS_RELEASE_INIT)

# vim: et ts=4 sw=4 ai
