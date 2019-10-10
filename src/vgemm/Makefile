OBJECTS:=gemm.cpp.o ref_gemm.cpp.o gemm_utils.cpp.o

# Optionally, try to force -ve or -x86 library
ifeq ($(TARGET),-x86) # unfortunately some Aurora machines do not seem to have a cblas :-/
CC=gcc
CXX=g++
NM=nm
endif
ifeq ($(TARGET),-ve)
CC=ncc
CXX=nc++
NM=nnm
endif

# bash counterpart: COMPILE_TYPE=`${CC} --version 2>&1 | awk '{print $$1; exit}'`
COMPILE_TYPE:=$(word 1,$(shell $(CC) --version 2>&1))
$(if $(COMPILE_TYPE),,$(error could not determine C compiler type for CC=$(CC))) # VE(ncc) vs x86(gcc or ...)

INC:=-I.
OPT:=
AS_OPT:=
CFLAGS:=-fopenmp -std=c11 -Wall
CXXFLAGS:=-fopenmp -Wall
CFLAGS+=-g
CXXFLAGS+=-g
LIBS:=-L. -lvconv${TARGET} -Wl,-rpath,./ -L../vgemm -lvgemm${TARGET} -Wl,-rpath,../vgemm

OPT+=-finline -finline-functions -O3
OPT+=-fopenmp
OPT+=-DNDEBUG

# TARGET might have been empty/unrecognized. set it for sure based on CC
ifeq ($(COMPILE_TYPE),ncc)
$(info ncc compiler detected)
TARGET:=-ve
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-report-all
LIBS+=-L/opt/nec/ve/nlc/2.0.0/lib -lcblas -lblas_openmp -Wl,-rpath,/opt/nec/ve/nlc/2.0.0/lib
else
TARGET:=-x86
LIBS=-lcblas -lblas # system libs
CXXFLAGS+=-std=c++11
AS_OPT+=-Wa,-adhln# -g
endif

INSTALLDIR:=./install${TARGET}
OBJECTS:=${patsubst %.o,%${TARGET}.o,${OBJECTS}}

ifeq ($(COMPILE_TYPE),ncc)
LIBS+=-L/opt/nec/ve/nlc/2.0.0/lib -lcblas -lblas_openmp -Wl,-rpath,/opt/nec/ve/nlc/2.0.0/lib
else
LIBS+=-lcblas -lblas# system libs
endif

all: build install${TARGET}
debug:
	echo "OBJECTS $(OBJECTS)"
build: $(OBJECTS) libvgemm${TARGET}.a libvgemm${TARGET}.so
	echo 'make build DONE'
libvgemm${TARGET}.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ -o $@
SHELL:=bash	
libvgemm${TARGET}.a: $(OBJECTS)
	$(AR) crs $@ $^
	#$(NM) -C $@ >& $@.nm

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
	rm -f *.o *.lo *.L *.s *.i *.gch *.log
realclean: clean
	rm -f libvgemm${TARGET}*
	rm -rf install*
# last line
