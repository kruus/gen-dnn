#all: hello a.o a.s a.d a
#
# bug demo for nc++ >= 2.0 or so (missing __cxa_thread_atexit during link)
#
#  in /opt/nec/ve/lib, the only defined 'atexit' symbols were:
#
#[aurora-ds02 nnm]$ grep -R atexit *.nm | grep ' T '
#libc.a.nm:0000000000000000 T atexit
#libc.a.nm:0000000000000620 T __cxa_atexit
#libc.a.nm:0000000000000470 T __internal_atexit
#libc.a.nm:0000000000000000 T __cxa_thread_atexit_impl
#libc_nonshared.a.nm:0000000000000000 T atexit 
#
all: tls_ok tls_bad

NCXX=nc++
GCXX=g++

.PHONY: tls_ok tls_bad ve
ve: simple_tls-ve threadlocal-ve
tls_ok: simple_tls simple_tls-ve
tls_bad: threadlocal threadlocal-ve

simple_tls: simple_tls.cpp
	$(GCXX) -o $@ -std=gnu++11 -pthread $< && ./$@
simple_tls-ve: simple_tls.cpp
	$(NCXX) -o $@ -std=gnu++11 -pthread $< && ./$@

threadlocal: threadlocal.cpp
	$(GCXX) -Wall -o $@ -std=gnu++11 -pthread $< && ./$@
threadlocal-ve: threadlocal.cpp
	$(NCXX) -Wall -o $@ -std=gnu++11 -pthread -g2 $< && ./$@
threadlocal-ve2: threadlocal.cpp
	$(NCXX) -std=gnu++11 -O3 -pthread -c $< -o $@.o
	nnm $@.o | grep tls
	$(NCXX) -v -std=gnu++11 -O3 -pthread -Wl,-v -o $@ $@.o -lpthread


.PHONY: hello
hello:
	g++ --version
HDRS := idiv.hpp
#HDRS := ./idiv-dev.hpp

%.s: %.cpp $(HDRS)
	g++ -std=c++11 -march=native -O3 -S $<
	
%.o: %.cpp $(HDRS)
	g++ -std=c++11 -march=native -O3 -c $< -o $@

%: %.o
	g++ -std=c++11 -march=native -O3 $< -o $@

%.d: %.o
	objdump -C -S -dt $< > $@ 2>&1
	
.PHONY: run
run: all
	./a 2 8 -4

clean:
	rm -f a simple_tls simple_tls-ve threadlocal threadlocal-ve
	rm -f *.s *.o
realclean:
	rm -f *.d
