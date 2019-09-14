OBJECTS:=gemm.cpp.o ref_gemm.cpp.o gemm_utils.cpp.o
all: build install
build: $(OBJECTS) libvgemm.a libvgemm.so
	echo 'make build DONE'
libvgemm.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ -o $@
libvgemm.a: $(OBJECTS)
	$(AR) qc $@ $^

INC:=
OPT:=
AS_OPT:=
INSTALLDIR:=./install

ifeq ($(patsubst ncc%,ncc,$(CC)),ncc)
$(info ncc compiler detected)
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-report-all
endif
OPT+=-fopenmp -finline -finline-functions -O3 -DNDEBUG

CHEADERS:=mkldnn_os.h mkldnn_subset.h
CXXHEADERS:=gemm.hpp gemm_utils.hpp \
	mkldnn_subset.hpp os_blas.hpp utils.hpp nstl.hpp \
	mkldnn_thread.hpp cpu_isa_traits.hpp
hdrs.log:
	{ for f in ${CHEADERS}; do echo $$f; gcc -std=c11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } >& hdrs.log
	{ for f in ${CXXHEADERS}; do echo $$f; g++ -std=c++11 -DTARGET=VANILLA ${INC} $$f 2>&1; done; } 2>&1 >> hdrs.log
install: all
	rm -rf $(INSTALLDIR)
	mkdir -p $(INSTALLDIR)/include/gen-dnn/vgemm
	cp ${CHEADERS} ${CXXHEADERS} $(INSTALLDIR)/include/gen-dnn/vgemm/
	mkdir -p $(INSTALLDIR)/lib
	cp libvgemm.so libvgemm.a $(INSTALLDIR)/lib/
	mkdir -p $(INSTALLDIR)/src/gen-dnn/vgemm
	cp $(OBJECTS:.o=) $(INSTALLDIR)/src/gen-dnn/vgemm/
	@echo 'vgemm package --> $(INSTALLDIR)/'

.PHONY: all Makefile $(CHEADERS) $(CXXHEADERS)
# assembly outputs for non-PIC are sometimes easier to understand
%.o: % | $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(AS_OPT) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) -o $@ -c $*.s
%.lo: % | $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $*.s
clean:
	rm -f *.o *.lo *.L *.s *.log *.gch *.log
realclean: clean
	rm -f libvgemm.so libvgemm.a
	rm -rf install
# last line
