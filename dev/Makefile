all: log
# sr : soft_relu fwd/bwd accuracy test over range [-90,90]
#
# Summary:	
# 	forward and backward (i.e. derivative) functions behave nicely
# 	in limit cases for +/- inf and nan for SCALAR function calls.
# but nc++ VECTORIZATIONS are a complete mess.
#   The vectorization for sqrt(x) uses (1/sqrt(double{x})) * x with iterations
#   The vectorization for 0.5/sqrt(x) is even more braindead:
#     It does the above sqrt(x), takes the reciprocal, and adds even more iterative corrections.
# ... outputs are quite often -nan instead of behaving like the scalar versions.
CXX:=nc++
CXXFLAGS:= -finline-functions -finline-max-depth=10 -finline-max-function-size=500 
CXXFLAGS+= -I.. -I../include -I../src/ -I../src/common
CXXFLAGS+= -I../build-vejd/include # adjust this for dnnl_config.h
CXXFLAGS+= -fdiag-inline=2 -fdiag-vector=2 -fdiag-parallel=2 -report-all
CXXFLAGS+= -std=gnu++11 -O2
CXXFLAGS+= -ffast-math
sr: sr.cpp
	$(CXX) $(CXXFLAGS) -S $< -o $<.s
	$(CXX) $(CXXFLAGS) $< -o $@
	./$@
log: log.cpp
	$(CXX) $(CXXFLAGS) -S $< -o $<.s
	$(CXX) $(CXXFLAGS) $< -o $@
	./$@
vrsqrt: vrsqrt.cpp
	$(CXX) $(CXXFLAGS) -S $< -o $<.s
	$(CXX) $(CXXFLAGS) $< -o $@
	./$@
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
	rm -f log log.cpp.s log.L log.LL
	rm -f vrsqrt vrsqrt.cpp.s vrsqrt.L vrsqrt.LL
realclean: clean
	rm -f *.log
	#
#

