message(STATUS " *** Platform/SX-sxcc.cmake *** ")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set(CMAKE_SHARED_LIBRARY_SUFFIX ".a")
set(CMAKE_SHARED_LIBRARY_PREFIX "lib")
set(CMAKE_EXECUTABLE_SUFFIX "")

set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
#set(CMAKE_DL_LIBS "-r") # extra option for ld to maintain relocation info ?

# Files named "libfoo.a" may actually be shared libraries.
set_property(GLOBAL PROPERTY TARGET_ARCHIVES_MAY_BE_SHARED_LIBS 1)
set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS 1)

set(CMAKE_LIBRARY_PATH_FLAG "-L")

#include(UnixPaths???)
