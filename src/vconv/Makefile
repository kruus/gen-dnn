OBJECTS:=scratchpad.cpp.o 		memory_desc_wrapper.cpp.o \
	primitive_attr.cpp.o \
	gemm_convolution_utils.cpp.o \
	gemm_convolution.cpp.o
# gemm_convolution.cpp.o  will NOT compile (pulls too many headers)
#
all: build install
build: $(OBJECTS) libvconv.a libvconv.so
	@echo "make build DONE"
force: realclean
	$(MAKE)
# link with something like:
#     -lcconv -L/opt/nec/ve/nlc/2.0.0/include -lcblas -lblas_openmp
libvconv.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ \
		-o $@

# libvconv.a will contain libvgemm as required
libvconv.a: $(OBJECTS) libvgemm.a
	#$(CXX) -static $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ libvgemm.a \
	#		-L/opt/nec/ve/nlc/2.0.0/lib -lcblas -lblas_openmp -o $@
	rm -rf tmp_obj; mkdir tmp_obj
	(cd tmp_obj && $(AR) -x ../libvgemm.a)
	$(AR) qc $@ $(filter %.o,$^) tmp_obj/*
	rm -rf tmp_obj

INC:=
OPT:=
AS_OPT:=
INSTALLDIR:=./install

# order matters here
INC+=-I. -I../vgemm
OPT+=-fopenmp -finline -finline-functions -O3 -DNDEBUG

ifeq ($(patsubst ncc%,ncc,$(CC)),ncc)
$(info ncc compiler detected)
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-report-all
#CC_OPT+=-report-all
endif

CHEADERS:=mkldnn_types.h
CXXHEADERS:=c_types_map.hpp consistency.hpp conv_primitive_conf.hpp \
	gemm_convolution.hpp gemm_convolution_utils.hpp memory_desc_wrapper.hpp \
	mkldnn_traits.hpp primitive_attr.hpp scratchpad.hpp type_helpers.hpp \
	verbose.hpp
hdrs.log:
	{ for f in ${CHEADERS}; do echo $$f; gcc -std=c11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } >& hdrs.log
	{ for f in ${CXXHEADERS}; do echo $$f; g++ -std=c++11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } 2>&1 >> hdrs.log
install: all
	rm -rf $(INSTALLDIR)
	mkdir -p $(INSTALLDIR)/include/gen-dnn/vconv
	cp ${CHEADERS} ${CXXHEADERS} $(INSTALLDIR)/include/gen-dnn/vconv/
	mkdir -p $(INSTALLDIR)/lib
	cp libvconv.so libvconv.a $(INSTALLDIR)/lib/
	mkdir -p $(INSTALLDIR)/src/gen-dnn/vconv
	cp $(OBJECTS:.o=) $(INSTALLDIR)/src/gen-dnn/vconv/
	@echo 'vconv package --> $(INSTALLDIR)/'

.PHONY:all Makefile ../vgemm force ${CHEADERS} ${CXXHEADERS}
# assembly outputs for non-PIC are sometimes easier to understand
%.o: % | $(CHEADERS) $(CXXHEADERS) libvgemm.a
	@#echo  "($(patsubst ncc%,ncc,$(CC)),ncc)" $(AS_OPT)
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(AS_OPT) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(CC_OPT) -o $@ -c $*.s
	ls -l *.L
%.lo: % | $(CHEADERS) $(CXXHEADERS) ../libvgemm.so
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $*.s 

libvgemm.a: ../vgemm/libvgemm.a
	$(MAKE) -C ../vgemm
	cp ../vgemm/$@ ./$@
../libvgemm.so:
	$(MAKE) -C ../vgemm
clean:
	rm -f *.o *.lo *.L *.s *.gch *.log
realclean: clean
	$(MAKE) -C ../vgemm realclean
	rm -f libvgemm.a libvconv.a libvconv.so
	rm -rf install
# last line
