.PHONY: all example tarball rel dbg clean realclean gcc
all: example tarball
	@echo "You can also make debugging targets: help dbg rel"
	@echo "to see if cmake -DCMAKE_BUILD_TYPE=xxx works"
help:
	@echo "example  [*] a normal cmake/sx.cmake toolchain run"
	@echo "tarball  [*] create sx-cmake-support.tar.gz"
	@echo "rel      CMAKE_BUILD_TYPE=Release (trace-->rel.log)"
	@echo "dbg      CMAKE_BUILD_TYPE=Debug   (trace-->dbg.log)"
	@echo "all      all [*] targets"

example:
	./cmake.sh
	if [ -f build/foo ]; then echo "build/foo should be runnable on SX now"; fi
	test -f build/foo || exit 1

tarball:
	tar czf sx-cmake-support.tar.gz Platform cmake cmake.sh

gcc:
	rm -rf build-$@ $@.err && mkdir build-$@
	echo "cmake with NO toolchain into build-$@/ ..."
	ls -l build-$@
	( cd build-$@ && cmake -DCMAKE_BUILD_TYPE=Release -Wno-dev .. ) 2>&1 | tee $@.err \
		|| { echo "Error - cmake: see $@.err and build-$@/"; false; }
	echo "make in build-$@/ ..."
	(cd build-$@ && make VERBOSE=1) 2>&1 | tee -a $@.err \
		|| { echo "Error - build: see $@.err and build-$@/"; false; }
	if [ -f $@.log ]; then mv $@.log $@.log.bak; fi
	mv $@.err $@.log
	echo "OK: $@.log"

rel:
	rm -rf build-$@ $@.err && mkdir build-$@
	echo "cmake with sx toolchain into build-$@/ ..."
	(cd build-$@ && cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/sx.cmake --trace -Wno-dev \
		-DCMAKE_BUILD_TYPE=Release .. ) >& $@.err \
		|| { echo "Error - cmake: see $@.err and build-$@/"; false; }
	echo "make in build-$@/ ..."
	(cd build-$@ && make VERBOSE=1) 2>&1 >> $@.err \
		|| { echo "Error - build: see $@.err and build-$@/"; false; }
	if [ -f $@.log ]; then mv $@.log $@.log.bak; fi
	mv $@.err $@.log
	echo "OK: $@.log"

dbg:
	rm -rf build-$@ $@.err && mkdir build-$@
	echo "cmake with sx toolchain into build-$@/ ..."
	(cd build-$@ && cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/sx.cmake --trace \
		-DCMAKE_BUILD_TYPE=Debug -wno-dev ..) >& $@.err \
		|| { echo "Error - cmake: see $@.err and build-$@/"; false; }
	echo "make in build-$@/ ..."
	(cd build-$@ && make VERBOSE=1) 2>&1 >> $@.err \
		|| { echo "Error - build: see $@.err and build-$@/"; false; }
	if [ -f $@.log ]; then mv $@.log $@.log.bak; fi
	mv $@.err $@.log
	echo "OK: $@.log"


clean:
	rm -rf build build-dbg build-rel build.log cmake.log *.bak
realclean: clean
	rm -f foo dbg.log rel.log
	#rm -f sx-cmake-support.tar.gz
