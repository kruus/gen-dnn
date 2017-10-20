all: a.o a.s a.d a

HDRS := ../idiv.hpp

%.s: %.cpp $(HDRS)
	g++ -std=c++11 -march=native -O3 -S $<
	
%.o: %.cpp $(HDRS)
	g++ -std=c++11 -march=native -O3 -c $< -o $@

%: %.o
	g++ -std=c++11 -march=native -O3 $< -o $@

%.d: %.o
	objdump -C -S -dt $< > $@ 2>&1
	
.PHONY: run
run: a
	./a 2 8 -4

clean:
	rm -f a
	rm -f *.s *.o
realclean:
	rm -f *.d
