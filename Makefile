.PHONY: all clean realclean
all:
	echo "make Targets: clean realclean"
	echo "Build Help:   build.sh -h"

gen-dnn.src.tar.gz:
	tar czf $@ Makefile build.sh include src
clean:
	rm -rf build build-sx build-jit build*.bak b.log b2.log
realclean: clean
	rm -f build.log build-jit.log
	#rm -f build-sx.log
