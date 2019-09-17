OBJECTS:=scratchpad.cpp.o 		memory_desc_wrapper.cpp.o \
	primitive_attr.cpp.o \
	gemm_convolution_utils.cpp.o \
	gemm_convolution.cpp.o \
	convolution.cpp.o memory.cpp utils.cpp
# gemm_convolution.cpp.o  pulls too many headers, so memory and primitive API simplified
# convolution.cpp and memory.cpp proved FOO_desc_init functions (helper functions)
#      to initialize memory and convolution descriptors
#
CHEADERS:=mkldnn_types.h mkldnn_desc_init.h
CXXHEADERS:=c_types_map.hpp consistency.hpp conv_primitive_conf.hpp \
	gemm_convolution.hpp gemm_convolution_utils.hpp memory_desc_wrapper.hpp \
	mkldnn_traits.hpp primitive_attr.hpp scratchpad.hpp type_helpers.hpp \
	verbose.hpp

# Optionally, try to force -ve or -x86 library
ifeq ($(TARGET),-x86)
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
INC+=-I. -I../vgemm

INC+=-I../vgemm
OPT+=-fopenmp -finline -finline-functions -O3 -DNDEBUG

TARGET:=-ve
ifeq ($(patsubst ncc%,ncc,$(CC)),ncc) # if $(CC) begins with 'ncc'
$(info ncc compiler detected)
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-report-all
LIBS+=-L/opt/nec/ve/nlc/2.0.0/lib -lcblas -lblas_openmp -Wl,-rpath,/opt/nec/ve/nlc/2.0.0/lib
CXXFLAGS+=-std=gnu++14
#CC_OPT+=-report-all
else
LIBS=-lcblas -lblas # system libs
CXXFLAGS+=-std=c++17
TARGET:=-x86
endif
INSTALLDIR:=./install${TARGET}
OBJECTS:=${patsubst %.o,%${TARGET}.o,${OBJECTS}}

LIBS:=-L. -L../vgemm -lvconv${TARGET} -lvgemm{TARGET} -Wl,-rpath,./ -Wl,-rpath,../vgemm

all: build install${TARGET}
build: $(OBJECTS) libvconv${TARGET}.a libvconv${TARGET}.so
	@echo "make build DONE"
force: realclean
	$(MAKE)

# assembly outputs for non-PIC are sometimes easier to understand
%${TARGET}.o: % | $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(AS_OPT) -o $*${TARGET}.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(CC_OPT) -o $@ -c $*${TARGET}.s
%${TARGET}.lo: % | $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $*${TARGET}.s -S $<
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $*${TARGET}.s

# link with something like:
#     -lcconv -L/opt/nec/ve/nlc/2.0.0/include -lcblas -lblas_openmp
libvconv${TARGET}.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ \
		-o $@
# libvconv${TARGET}.a will contain libvgemm as required
libvconv${TARGET}.a: $(OBJECTS) libvgemm${TARGET}.a
	#$(CXX) -static $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ libvgemm.a \
	#		-L/opt/nec/ve/nlc/2.0.0/lib -lcblas -lblas_openmp -o $@
	rm -rf tmp_obj; mkdir tmp_obj
	(cd tmp_obj && $(AR) -x ../libvgemm${TARGET}.a)
	$(AR) qc $@ $(filter %.o,$^) `ls -rt1 tmp_obj/*`
	rm -rf tmp_obj
	$(NM) -C $@ >& $@.nm

test_md: test_md.c | libvconv${TARGET}.so libvgemm${TARGET}.so
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
	rm -f *.o *.lo *.L *.s *.gch *.log
realclean: clean
	$(MAKE) -C ../vgemm realclean
	rm -f libvgemm.a libvconv.a libvconv.so
	rm -rf install*
# last line
