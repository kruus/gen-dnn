all: hello clang-7139 cxx-pod cxx-locals cxx_incomplete_value_init smallbug
#
# Example usage:
#     # select gcc compiler and run
#     make -f Makefile.cxx-pod VERBOSE=1 clean all >& x86-gcc.log
#
# cxx-locals has assertions,
# cxx-pod is for exploration of possible issues.
# clang-7139 is a quick clang testsuite item from 2010
#    (similar test added to gcc 4.4 in 2010)
# cxx_imcomplete_value_init is a more extensive test from boost,
#    also described in the clang bug report
#
# nc++ passes these simple tests.
# But similar language constructs in more complicated dnnl code
# SOMETIMES fail.  In SOME instances, nc++ "forgets" about C++ rules
# forcing zero-initialization and used plain C rules.
#
# The only known "for-sure" nc++ fix is to memset to zero many cases of the
#    "auto x = T();"
# construct and the
#    "Foo::Foo(...) : T() {...}"
# construct, where T is a C POD type.
#
# Choose compiler + options
ifeq (0,1)
CC:=ncc
CXX:=nc++
CFLAGS:=-O4 -minit-stack=0xbad4face
CXXFLAGS:=$(CFLAGS)
endif
ifeq (0,1)
CC:=ncc
CXX:=nc++
CFLAGS:=-O4 -minit-stack=zero
CXXFLAGS:=$(CFLAGS)
endif
ifeq (0,1)
#VER:=-4.8
#VER:=-4.9
#VER:=-5
VER:=-7
CC:=gcc$(VER)
CXX:=g++$(VER)
CFLAGS:=-O2 -Wall -Werror -Wuninitialized
CXXFLAGS:=$(CFLAGS)
endif
ifeq (1,1)
#VER:=
VER:=-10
CC:=clang
CXX:=clang++
CFLAGS:=-O3 -Wall -Werror
CXXFLAGS:=$(CFLAGS)
endif
###################################################3
.PHONY: hello
hello:
	$(CXX) --version
%.cpp.o: %.cpp
	$(CXX) -std=gnu++11 -Wall $(CFLAGS) -o $^.i -dD -E $<
	$(CXX) -std=gnu++11 -Wall $(CFLAGS) -o $@ -c $<
%.c.o: %.c
	$(CC) -std=gnu11 -Wall $(CFLAGS) -o $^.i -dD -E $<
	$(CC) -std=gnu11 -Wall $(CFLAGS) -o $@ -c $<
cxx-pod: cxx-pod.cpp.o cxx-pod-fill.cpp.o cxx-pod-test.cpp.o cxx-pod2.cpp.o
	$(CXX) -std=gnu++11 -Wall -o $(LDFLAGS) $@ $^
	./$@
cxx-locals: cxx-locals.cpp.o cxx-locals.c.o
	$(CXX) -std=gnu++11 -Wall -o $(LDFLAGS) $@ $^
	./$@
cxx_incomplete_value_init: boost_no_com_value_init.cpp.o
	$(CXX) -std=c++11 -Wall -o $(LDFLAGS) $@ $^
	./$@ && echo PASSED TEST $@
clang-7139: clang-7139.cpp.o
	$(CXX) -std=c++11 -Wall -o $(LDFLAGS) $@ $^
	./$@
smallbug: smallbug.cpp.o
	$(CXX) -std=c++11 -Wall -o $(LDFLAGS) $@ $^
	./$@ && echo PASSED TEST $@
ifeq ($(CC),ncc)
%.cpp.z.o: %.cpp
	$(CXX) -std=gnu++11 -Wall -O4 -minit-stack=zero -o $@ -c $<
%.c.z.o: %.c
	$(CC) -std=gnu11 -Wall -O4 -minit-stack=zero -o $@ -c $<
cxx-locals-z: cxx-locals.cpp.z.o cxx-locals.c.z.o
	$(CXX) -std=gnu++11 -Wall -o $(LDFLAGS) $@ $^
	./$@
endif
clean:
	rm -f *.o *.i
realclean: clean
	rm -f cxx-pod clang-7139 cxx-locals cxx_incomplete_value_init smallbug
