# local gcc compiler tests
all:
	g++ --std=c++11 -fopenmp -g -E pragma-gcc.cxx -O3 -Wall -Wa,-ahdln -o pragma-gcc.i
	g++ --std=c++11 -fopenmp -g -S pragma-gcc.cxx -O3 -Wall -Wa,-ahdln -o pragma-gcc.s
	g++ --std=c++11 -fopenmp -g -c pragma-gcc.cxx -O3 -Wall -o pragma-gcc.o
