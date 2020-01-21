#!/bin/bash
#
#     vanilla debug   -- tests that at some point had issues
#
#rm -rf build-gend && time ./build.sh -gdqTtt >& gend.log
#
BLD=build-gend
GTESTS="${BLD}/tests/gtests"
MKLDNN_VERBOSE=2
{ time ./build.sh -gdqqT \
	&& {
	${GTESTS}/test_inner_product_forward;
	${GTESTS}/test_deconvolution;
	${GTESTS}/test_matmul;
	${GTESTS}/test_matmul;
	build-gend/examples/cpu-tutorials-matmul-matmul-quantization-cpp;
	build-gend/examples/tutorials-matmul-inference-int8-matmul-cpp "cpu"
	build-gend/examples/cnn-inference-int8-cpp "cpu";
	build-gend/examples/cnn-training-int8-cpp "cpu";
	build-gend/tests/mkldnn_compat/examples/mkldnn-compat-cnn-inference-int8 "cpu";
	build-gend/tests/mkldnn_compat/examples/mkldnn-compat-cnn-inference-int8-cpp "cpu";
} } >& vd.log
