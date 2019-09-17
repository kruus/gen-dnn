OBJECTS:=gemm.cpp.o ref_gemm.cpp.o gemm_utils.cpp.o

# Optionally, try to force -ve or -x86 library
ifeq ($(TARGET),-x86) # unfortunately some Aurora machines do not seem to have a cblas :-/
CC=gcc
CXX=g++
endif
ifeq ($(TARGET),-ve)
CC=ncc
CXX=nc++
endif

INC:=-I.
OPT:=
AS_OPT:=
CFLAGS:=-fopenmp -std=c11 -Wall
CXXFLAGS:=-fopenmp -Wall
CFLAGS+=-g
CXXFLAGS+=-g
OPT+=-fopenmp -finline -finline-functions -O3 -DNDEBUG

TARGET:=-ve
ifeq ($(patsubst ncc%,ncc,$(CC)),ncc)
$(info ncc compiler detected)
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-report-all
LIBS+=-L/opt/nec/ve/nlc/2.0.0/lib -lcblas -lblas_openmp -Wl,-rpath,/opt/nec/ve/nlc/2.0.0/lib
else
LIBS=-lcblas -lblas # system libs
CXXFLAGS+=-std=c++11
TARGET:=-x86
endif
INSTALLDIR:=./install${TARGET}
OBJECTS:=${patsubst %.o,%${TARGET}.o,${OBJECTS}}

all: build install${TARGET}
debug:
	echo "OBJECTS $(OBJECTS)"
build: $(OBJECTS) libvgemm${TARGET}.a libvgemm${TARGET}.so
	echo 'make build DONE'
libvgemm${TARGET}.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ -o $@
libvgemm${TARGET}.a: $(OBJECTS)
	$(AR) crs $@ $^
	$(NM) -C $@ >& $@.nm

CHEADERS:=mkldnn_os.h mkldnn_subset.h
CXXHEADERS:=gemm.hpp gemm_utils.hpp \
	mkldnn_subset.hpp os_blas.hpp utils.hpp nstl.hpp \
	mkldnn_thread.hpp cpu_isa_traits.hpp
hdrs.log:
	{ for f in ${CHEADERS}; do echo $$f; gcc -std=c11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } >& hdrs.log
	{ for f in ${CXXHEADERS}; do echo $$f; g++ -std=c++11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } 2>&1 >> hdrs.log
install${TARGET}: all
	rm -rf $(INSTALLDIR)
	mkdir -p $(INSTALLDIR)/include/gen-dnn/vgemm
	cp ${CHEADERS} ${CXXHEADERS} $(INSTALLDIR)/include/gen-dnn/vgemm/
	mkdir -p $(INSTALLDIR)/lib
	cp libvgemm${TARGET}.so libvgemm${TARGET}.a $(INSTALLDIR)/lib/
	mkdir -p $(INSTALLDIR)/src/gen-dnn/vgemm
	cp $(OBJECTS:${TARGET}.o=) $(INSTALLDIR)/src/gen-dnn/vgemm/
	@echo 'vgemm package --> $(INSTALLDIR)/'

.PHONY: all Makefile $(CHEADERS) $(CXXHEADERS)
# assembly outputs for non-PIC are sometimes easier to understand
%${TARGET}.o: % | $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(AS_OPT) -o $*${TARGET}.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) -o $@ -c $*${TARGET}.s
%${TARGET}.lo: % | $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $*${TARGET}.s -S $<
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $*${TARGET}.s
clean:
	rm -f *.o *.lo *.L *.s *.log *.gch *.log
realclean: clean
	rm -f libvgemm${TARGET}.so libvgemm${TARGET}.a
	rm -rf install*
# last line
