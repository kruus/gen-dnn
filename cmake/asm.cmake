# [ejk] generate some nice assembler listings [at least for gcc] into build/asm/

if(asm_cmake_included)
	return()
endif()
set(asm_cmake_included)

# assume we have already found out about general compiler settings.
# CMAKE_C_CREATE_ASSEMBLY_SOURCE and
# CMAKE_CXX_CREATE_ASSEMBLY_SOURCE are set up.
# but default to just using -S, and leaving the the .cpp.s file deep in build dir.
#
# So here is an opportunity to change cmake macros to output more useful
# assembler outputs [if you know how to do it for your particular compiler]
#
# This may not work for *you*
#
# You still need to go into the build dir, where the Makefile is, and type
# 'make foo.cpp.s' by hand.    (Alternatively you can add some extra targets
# to the main CMakeLists.txt to produce a few assembler files that you're
# really interested in generating every time)
#

# sample source code to test
set(asm_C_TEST_SOURCE
"
int main() {
  return 0;
}
")

find_program(asm_CXXFILT c++filt)
find_program(asm_CAT cat)
message(STATUS "??? ${asm_CAT} <ASSEMBLY_SOURCE>.0 | ${asm_CXXFILT} > <ASSEMBLY_SOURCE>")
if(asm_CXXFILT AND asm_CAT)
    set(asm_FILTER_COMMAND "${asm_CAT} <ASSEMBLY_SOURCE>.0 | ${asm_CXXFILT} > <ASSEMBLY_SOURCE>")
else()
    set(asm_FILTER_COMMAND "${CMAKE_COMMAND -E move \"<ASSEMBLY_SOURCE>.0\" \"<ASSEMBLY_SOURCE>\"")
endif()

#file(TO_NATIVE_PATH "${CMAKE_CURRENT_BINARY_DIR}/asm" asm_OUTPUT_DIR))
set(asm_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/asm")
file(MAKE_DIRECTORY ${asm_OUTPUT_DIR})

if(CMAKE_C_COMPILER_LOADED)
    if(UNIX AND NOT APPLE)
        # cmake docs do not really recommend overriding the cmake macros, but
        # it seemed an easy way to nicer asm outputs for gcc
        message(STATUS "CMAKE_C_COMPILER_ID ${CMAKE_C_COMPILER_ID}")
        if(${CMAKE_C_COMPILER_ID} STREQUAL "GNU")
            if(0)
                # this way still does not produce very readable asm, imho.
                string(REPLACE " -S <SOURCE>" " -fverbose-asm -S <SOURCE>"
                    asm_C_CREATE_ASSEMBLY "${CMAKE_C_CREATE_ASSEMBLY_SOURCE}")
                string(REPLACE "<ASSEMBLY_SOURCE>" "<ASSEMBLY_SOURCE>.orig"
                    asm_C_CREATE_ASSEMBLY "${asm_C_CREATE_ASSEMBLY}")
            else()
                # gcc: interspersed source/assembler
                string(REPLACE " -S <SOURCE>" " -g -fverbose-asm -Wa,-adhln -c <SOURCE>"
                    asm_C_CREATE_ASSEMBLY "${CMAKE_C_CREATE_ASSEMBLY_SOURCE}")
                string(REPLACE "-o <ASSEMBLY_SOURCE>" "-o /dev/null > <ASSEMBLY_SOURCE>.0"
                    asm_C_CREATE_ASSEMBLY "${asm_C_CREATE_ASSEMBLY}")
                # demangle and copy FOO.c.s upwards into the binary dir (easier to find)
                set(CMAKE_C_CREATE_ASSEMBLY_SOURCE
                    "${asm_C_CREATE_ASSEMBLY}"
                    "${asm_FILTER_COMMAND}"
                    "${CMAKE_COMMAND} -E copy \"<ASSEMBLY_SOURCE>\" \"${asm_OUTPUT_DIR}/\"" 
                    )
            endif()
            message(STATUS "CMAKE_C_CREATE_ASSEMBLY_SOURCE has been set to :\n${CMAKE_C_CREATE_ASSEMBLY_SOURCE}")
        endif()
    else()
        set(CMAKE_C_CREATE_ASSEMBLY_SOURCE
            "${CMAKE_C_CREATE_ASSEMBLY_SOURCE}"
            "${CMAKE_COMMAND} -E copy \"<ASSEMBLY_SOURCE>\" \"${asm_OUTPUT_DIR}/\"" 
            )
    endif()
endif()
if(CMAKE_C_COMPILER_LOADED)
    if(UNIX AND NOT APPLE)
        # cmake docs do not really recommend overriding the cmake macros, but
        # it seemed an easy way to nicer asm outputs for gcc
        message(STATUS "CMAKE_C_COMPILER_ID ${CMAKE_C_COMPILER_ID}")
        if(${CMAKE_C_COMPILER_ID} STREQUAL "GNU")
            if(0)
                string(REPLACE " -S <SOURCE>" " -fverbose-asm -S <SOURCE>"
                    asm_CXX_CREATE_ASSEMBLY "${CMAKE_CXX_CREATE_ASSEMBLY_SOURCE}")
                string(REPLACE "<ASSEMBLY_SOURCE>" "<ASSEMBLY_SOURCE>.orig"
                    asm_CXX_CREATE_ASSEMBLY "${asm_CXX_CREATE_ASSEMBLY}")
            else()
                # gcc: interspersed source/assembler, and copy .s files to easy-to-find spot
                string(REPLACE " -S <SOURCE>" " -g -fverbose-asm -Wa,-adhln -c <SOURCE>"
                    asm_CXX_CREATE_ASSEMBLY "${CMAKE_CXX_CREATE_ASSEMBLY_SOURCE}")
                string(REPLACE "-o <ASSEMBLY_SOURCE>" "-o /dev/null > <ASSEMBLY_SOURCE>.0"
                    asm_CXX_CREATE_ASSEMBLY "${asm_CXX_CREATE_ASSEMBLY}")
                set(CMAKE_CXX_CREATE_ASSEMBLY_SOURCE
                    "${asm_CXX_CREATE_ASSEMBLY}"
                    "${asm_FILTER_COMMAND}"
                    "${CMAKE_COMMAND} -E copy \"<ASSEMBLY_SOURCE>\" \"${asm_OUTPUT_DIR}/\"" 
                    )
            endif()
            message(STATUS "CMAKE_CXX_CREATE_ASSEMBLY_SOURCE has been set to :\n${CMAKE_CXX_CREATE_ASSEMBLY_SOURCE}")
        endif()
    else()
        # use default assembler sequence -- just copy the buried output to build/asm
        set(CMAKE_C_CREATE_ASSEMBLY_SOURCE
            "${CMAKE_C_CREATE_ASSEMBLY_SOURCE}"
            "${CMAKE_COMMAND} -E copy \"<ASSEMBLY_SOURCE>\" \"${asm_OUTPUT_DIR}/\"" 
            )
    endif()
endif()
# vim: et ts=4 sw=4 ai
