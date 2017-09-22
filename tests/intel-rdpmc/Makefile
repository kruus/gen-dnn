
all: rdpmc1 rdpmc2

rdpmc1: doihave_rdpmc.c
	gcc $^ -o $@
rdpmc2: doihave_rdpmc2.c common.c cloexec.c common.h cloexec.h
	gcc $(filter %.c,$^) -o $@

clean:
	# nothing
realclean:
	rm -f rdpmc1 rdpmc2
