all: sr
# sr : soft_relu fwd/bwd accuracy test over range [-90,90]
CXX:=nc++
CXXFLAGS:= -finline-functions -finline-max-depth=10 -finline-max-function-size=500 
CXXFLAGS+= -I.. -I../include -I../src/ -I../src/common
CXXFLAGS+= -I../build-vejd/include # adjust this for dnnl_config.h
CXXFLAGS+= -fdiag-inline=2 -fdiag-vector=2 -fdiag-parallel=2 -report-all
CXXFLAGS+= -std=gnu++11 -O4 -ffast-math
sr:
	$(CXX) $(CXXFLAGS) -S sr.cpp -o sr.cpp.s
	$(CXX) $(CXXFLAGS) sr.cpp -o sr
	./sr >& sr.log
test_int8-b.o : test_int8-b.cpp
	$(CXX) -O3 -std=c++11 -Wall -g -c $< -o $@
	$(CXX) -O3 -std=c++11 -Wall -g -dD -E $< -o $<.i
	nnm -C $@
test_int8: test_int8-a.cpp test_int8-b.o
	$(CXX) -O3 -std=c++11 -Wall -g -DMAIN -dD -E $< -o $<.i
	$(CXX) -O3 -std=c++11 -Wall -g -DMAIN $^ -o $@
clean:
	rm -f test_int8 test_int8-b.o test_int8*.i
	rm -f sr sr.cpp.s sr.L sr.LL
realclean: clean
	rm -f *.log
	#
#

