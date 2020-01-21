#!/bin/bash
#
# build many standard log files
# This may take a long time to run
#
if [ -nz "full-build" ]; then
	REDO='echo'; BUILD_SH='./build.sh -q'
	# build.sh will rm -rf the build dir by default
	#
	# standard x86 jit build, all options enabled
	(${REDO} build-jit-ALL && ${BUILD_SH} -jTtt ) >& jit-ALL.log
	#
	#
	# vanilla build (no bfloat16, no rnn)
	( ${REDO} build-gen && ${BUILD_SH} -gTtt ) >& gen.log
	#
	################## extra build styles
	# unsupported: x86 jit without bfloat16
	# unsupported: x86 vanilla with rnn
	#
	# vanilla build + bfloat16
	( ${REDO} build-gen-bf16 && ${BUILD_SH} -gBTtt ) >& gen-bf16.log
	#
	# standard x86 jit build for sse41 (compile-time target, uni drivers may bypass, for now)
	( ${REDO} build-jit-SSE41 && ${BUILD_SH} -jTtt -mSSE41 ) >& jit-SSE41.log
	#
	# jit build without even SSE41 (may not work yet)
	( ${REDO} build-jit-ANY && ${BUILD_SH} -jTtt -mANY ) >& jit-ANY.log
	#
	#
else # sometimes dependencies don't really cause recompilation as expected ??
	# the -qq option skips the doxygen build and skips the rm -rf step
	REDO='echo'; BUILD_SH='./build.sh -qq'
	#
	# standard x86 jit build, all options enabled
	( ${REDO} build-jit-ALL && ${BUILD_SH} -jTtt ) >& jit-ALL.log
	#
	#
	# vanilla build (no bfloat16, no rnn)
	( ${REDO} build-gen && ${BUILD_SH} -gTtt ) >& gen.log
	#
	################## extra build styles
	# unsupported: x86 jit without bfloat16
	# unsupported: x86 vanilla with rnn
	#
	# vanilla build + bfloat16
	( ${REDO} build-gen-bf16 && ${BUILD_SH} -gBTtt ) >& gen-bf16.log
	#
	# standard x86 jit build for sse41 (compile-time target, uni drivers may bypass, for now)
	( ${REDO} build-jit-SSE41 && ${BUILD_SH} -jTtt -mSSE41 ) >& jit-SSE41.log
	#
	# jit build without even SSE41 (may not work yet)
	( ${REDO} build-jit-ANY && ${BUILD_SH} -jTtt -mANY ) >& jit-ANY.log
	#
	#
fi
