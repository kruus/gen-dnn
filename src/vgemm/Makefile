OBJECTS:=gemm.cpp.o ref_gemm.cpp.o gemm_utils.cpp.o
all: $(OBJECTS) libvgemm.a libvgemm.so
	echo 'make all DONE'
libvgemm.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ -o $@
libvgemm.a: $(OBJECTS)
	$(AR) qc $@ $^

INC:=
OPT:=
AS_OPT:=

ifeq ($(CC:ncc%=ncc),ncc)
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-freport-all
endif
OPT+=-fopenmp -finline -finline-functions -O3 -DNDEBUG

CHEADERS:=mkldnn_os.h mkldnn_subset.h
CXXHEADERS:=gemm.hpp gemm_utils.hpp \
	mkldnn_subset.hpp os_blas.hpp utils.hpp nstl.hpp \
	mkldnn_thread.hpp cpu_isa_traits.hpp
.PHONY: all Makefile $(CHEADERS) $(CXXHEADERS)

# assembly outputs for non-PIC are sometimes easier to understand
%.o: % $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(ASOPT) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) -o $@ -c $<
%.lo: % $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $<
clean:
	rm -f *.o *.lo *.L *.s *.log
realclean: clean
	rm -f libvgemm.so libvgemm.a
# last line
