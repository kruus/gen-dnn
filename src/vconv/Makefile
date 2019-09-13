OBJECTS:=scratchpad.cpp.o 		memory_desc_wrapper.cpp.o \
	primitive_attr.cpp.o \
	gemm_convolution_utils.cpp.o \
	gemm_convolution.cpp.o
# gemm_convolution.cpp.o  will NOT compile (pulls too many headers)
#
all: $(OBJECTS) libvconv.a libvconv.so
	@echo "make all DONE"
force: realclean
	$(MAKE)

libvconv.so: $(patsubst %.o,%.lo,$(OBJECTS))
	$(CXX) -shared $(CXXFLAGS) $(OPT) $(INC) $(LDFLAGS) $^ \
		-L/opt/nec/ve/nlc/2.0.0/include -lcblas -lblas_openmp \
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

# order matters here
INC+=-I. -I../vgemm

OPT+=-fopenmp -finline -finline-functions -O3 -DNDEBUG
ifeq ($(CC:ncc%=ncc),ncc)
INC+=-I/opt/nec/ve/nlc/2.0.0/include
AS_OPT+=-freport-all
endif

# assembly outputs for non-PIC are sometimes easier to understand
%.o: % $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) $(ASOPT) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) $(OPT) $(INC) -o $@ -c $<
%.lo: % $(CHEADERS) $(CXXHEADERS)
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $*.s -S $<
	$(CXX) $(CXXFLAGS) -fPIC $(OPT) $(INC) -o $@ -c $<

.PHONY:all Makefile ../vgemm force
libvgemm.a: ../vgemm
	$(MAKE) -C ../vgemm
	cp ../vgemm/$@ ./$@
#libvgemm.so: ../vgemm
#	$(MAKE) -C ../vgemm
#	cp ../vgemm/$@ ./$@
#	@echo "*** WHY DO I NEED THIS? ***"
clean:
	rm -f *.o *.lo *.L *.s *.log
realclean: clean
	$(MAKE) -C ../vgemm realclean
	rm -f libvgemm.a libvconv.a libvconv.so
