OBJECTS:=scratchpad.cpp.o 		memory_desc_wrapper.cpp.o \
	mkldnn_debug.cpp.o 		primitive_attr.cpp.o \
	gemm_convolution_utils.cpp.o \
	gemm_convolution.cpp.o \
	convolution.cpp.o \
	memory.cpp.o utils.cpp.o
# gemm_convolution.cpp.o  pulls too many headers, so memory and primitive API simplified
# convolution.cpp and memory.cpp proved FOO_desc_init functions (helper functions)
#      to initialize memory and convolution descriptors
#
CHEADERS:=mkldnn_types.h mkldnn_desc_init.h mkldnn_debug.h
CXXHEADERS:=c_types_map.hpp consistency.hpp conv_primitive_conf.hpp \
	gemm_convolution.hpp gemm_convolution_utils.hpp memory_desc_wrapper.hpp \
	mkldnn_traits.hpp primitive_attr.hpp scratchpad.hpp type_helpers.hpp \
	verbose.hpp

# Optionally, try to force -ve or -x86 library
ifeq ($(TARGET),-x86)
CC=gcc-7
CXX=g++-7
NM=nm
endif
ifeq ($(TARGET),-ve)
CC=ncc
CXX=nc++
NM=nnm
endif

SHELL:=bash
INC:=
OPT:=
AS_OPT:=
CFLAGS:=-fopenmp -std=c11 -Wall
CXXFLAGS:=-fopenmp -Wall
CFLAGS+=-g
CXXFLAGS+=-g
INC+=-I. -I../vgemm

OPT+=-O3 -finline -finline-functions
OPT+=-fopenmp
#OPT+=-DNDEBUG

TARGET:=-ve
ifeq ($(patsubst ncc%,ncc,$(CC)),ncc) # if $(CC) begins with 'ncc'
$(info ncc compiler detected)
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-report-all
CXXFLAGS+=-std=gnu++14
else
LIBS=-lcblas -lblas # system libs
CXXFLAGS+=-std=c++11
TARGET:=-x86
AS_OPT+=-Wa,-adhln# -g
endif
INSTALLDIR:=./install${TARGET}
OBJECTS:=${patsubst %.o,%${TARGET}.o,${OBJECTS}}

ifeq ($(TARGET),-x86) # override gcc compiler version (testing...)
CC=gcc
CXX=g++
endif

LIBS:=-L. -lvconv${TARGET} -Wl,-rpath,./ -L../vgemm -lvgemm${TARGET} -Wl,-rpath,../vgemm
ifeq ($(patsubst ncc%,ncc,$(CC)),ncc) # if $(CC) begins with 'ncc'
LIBS+=-L/opt/nec/ve/nlc/2.0.0/lib -lcblas -lblas_openmp -Wl,-rpath,/opt/nec/ve/nlc/2.0.0/lib
else
LIBS+=-lblas
endif

#
##################################### all #####################################
#
all: build install${TARGET}
vconv${TARGET}.tar.gz: all
	cd install${TARGET} && tar czf ../$@ *
	@echo 'distribution tarball:'
	-ls -ld $@
test: build test_md
	{ ./test_md; } 2>&1 | tee test.log
	@echo "make test DONE -- see test.log"
build: $(OBJECTS) libvconv${TARGET}.a libvconv${TARGET}.so
	@echo "make build DONE"
force: realclean
	$(MAKE)

# -report-all causes a failure sometimes (ncc-2.4.20 ccom SIGSEGV)
gemm_convolution_utils.cpp${TARGET}.o: gemm_convolution_utils.cpp | $(CHEADERS) $(CXXHEADERS)
	@echo -e '\n    %%%% %%%% $* --> $@'
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(CC_OPT) -o $*${TARGET}.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(CC_OPT) -o $@ -c $*${TARGET}.s
# assembly outputs for non-PIC are sometimes easier to understand
%${TARGET}.o: % | $(CHEADERS) $(CXXHEADERS)
	@echo -e '\n    %%%% %%%% $* --> $@'
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(CC_OPT) $(AS_OPT) -o $*${TARGET}.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(CC_OPT) -o $@ -c $*${TARGET}.s
%${TARGET}.lo: % | $(CHEADERS) $(CXXHEADERS)
	@echo -e '\n    %%%% %%%% $* --> $@'
	@#$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $*${TARGET}.s -S $<
	@#$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $*${TARGET}.s
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $*

# link with something like:
#     -lcconv -L/opt/nec/ve/nlc/2.0.0/include -lcblas -lblas_openmp
libvconv${TARGET}.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ \
		-o $@
# libvconv${TARGET}.a will contain libvgemm as required
libvconv${TARGET}.a: $(OBJECTS) libvgemm${TARGET}.a
	rm -rf tmp_obj; mkdir tmp_obj
	(cd tmp_obj && $(AR) -x ../libvgemm${TARGET}.a)
	$(AR) qc $@ $(filter %.o,$^) `ls -rt1 tmp_obj/*`
	rm -rf tmp_obj
	ls -l $@
	#$(NM) -C $@ >& $@.nm

test_md: test_md.c build
	$(CC) $(CFLAGS) $(OPT) $(INC) -o $@.s -S $(filter %.c,$^)
	$(CXX) $(CXXFLAGS) $(OPT) -o $@ $@.s $(LIBS)
%: %.c libvconv${TARGET}.so libvgemm${TARGET}.so
	$(CC) $(CFLAGS) $(INC) -o $@.o -c $(filter %.c,$^)
	$(CXX) $(CXXFLAGS) -o $@ $@.o $(LIBS)
hdrs.log:
	{ for f in ${CHEADERS}; do echo $$f; gcc -std=c11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } >& hdrs.log
	{ for f in ${CXXHEADERS}; do echo $$f; g++ -std=c++11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } 2>&1 >> hdrs.log
install${TARGET}: all
	rm -rf $(INSTALLDIR)
	mkdir -p $(INSTALLDIR)/include/gen-dnn/vconv
	cp ${CHEADERS} ${CXXHEADERS} $(INSTALLDIR)/include/gen-dnn/vconv/
	mkdir -p $(INSTALLDIR)/lib
	cp libvconv${TARGET}.so libvconv${TARGET}.a $(INSTALLDIR)/lib/
	mkdir -p $(INSTALLDIR)/src/gen-dnn/vconv
	cp $(OBJECTS:${TARGET}.o=) $(INSTALLDIR)/src/gen-dnn/vconv/
	@echo 'vconv package --> $(INSTALLDIR)/'

.PHONY:all Makefile force ${CHEADERS} ${CXXHEADERS} ${patsubst %.o,%,$(OBJECTS)}
../vgemm/libvgemm${TARGET}.a:
	$(MAKE) -C ../vgemm realclean
	TARGET=$(TARGET) $(MAKE) -C ../vgemm libvgemm${TARGET}.a libvgemm${TARGET}.so
libvgemm${TARGET}.a: ../vgemm/libvgemm${TARGET}.a
	$(MAKE) -C ../vgemm
	cp ../vgemm/$@ ./$@
libvgemm${TARGET}.so: | libvgemm${TARGET}.a
	#$(MAKE) -C ../vgemm
	cp ../vgemm/$@ ./$@
clean:
	rm -f *.o *.lo *.L *.s *.i *.gch *.log
realclean: clean
	$(MAKE) -C ../vgemm realclean
	rm -f libvgemm${TARGET}* libvconv${TARGET}* test_md
	rm -rf install*
# last line
