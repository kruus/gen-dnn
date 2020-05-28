all: crash
.PHONY: crash
#mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#ROOT := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
ROOT:=.

# select one

# ccom segfault always (100s of attempts)
OPT:=-std=c++11 -O0

# no crash at higher optimization
#OPT:=-std=c++11 -O1 -fno-inline

crash:
	ulimit 16384 # <----------- this line fixes the crash
	VE_TRACEBACK=VERBOSE \
	/opt/nec/ve/bin/nc++  \
	-DNOMINMAX -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS \
	-DCBLAS_LAYOUT=CBLAS_ORDER -DDNNL_VALUE_INITIALIZATION_BUG \
	-I${ROOT}/include -I${ROOT}/build-ved4/include -I${ROOT} -I${ROOT}/tests/gtests \
	-I${ROOT}/tests/gtests/gtest -I${ROOT}/tests/gtests/in \
	-I${ROOT}/tests/gtests/../../src/common -I${ROOT}/tests/gtests/../../src/cpu \
	-I${ROOT}/src/../include  \
	-include stdint.h -minit-stack=zero -fopenmp -pthread -g -Wall \
	${OPT} \
	-o test_memory_desc_ops.cpp.o \
	-c ${ROOT}/tests/gtests/api/test_memory_desc_ops.cpp
#
# crash:
# "./tests/gtests/gtest/internal/gtest-death-test-internal.h", line 96: warning:
#           attribute does not apply to any entity
#     } GTEST_ATTRIBUTE_UNUSED_;
#       ^
# 
# "./tests/gtests/gtest/gtest.h", line 2277: warning: attribute does not apply to
#           any entity
#   } GTEST_ATTRIBUTE_UNUSED_;  // A ScopedTrace object does its job in its
#     ^
# 
# nc++: /opt/nec/ve/ncc/3.0.27/libexec/ccom is abnormally terminated by SIGSEGV
# make: *** [crash] Error 4
# 
