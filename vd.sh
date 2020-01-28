#!/bin/bash
#
#     vanilla debug   -- tests that at some point had issues
#
#rm -rf build-gend && time ./build.sh -gdqTtt >& gend.log
#
# following 2 settings should match:
BLD=build-gen
OPTIONS="-gqTtttt"
# optional: full rebuild?
rm -rf ${BLD}
#
GTESTS="${BLD}/tests/gtests"
MKLDNN_VERBOSE=2
{ time ./build.sh ${OPTIONS} \
	&& {
	${GTESTS}/test_eltwise;
	${GTESTS}/test_matmul;
	${GTESTS}/test_gemm_f16;
	${GTESTS}/test_gemm_bf16bf16bf16;
	${GTESTS}/test_gemm_bf16bf16bf32;
	${GTESTS}/test_inner_product_forward;
	${GTESTS}/test_deconvolution;
	${GTESTS}/test_matmul;
	build-gend/examples/cpu-tutorials-matmul-matmul-quantization-cpp;
	build-gend/examples/tutorials-matmul-inference-int8-matmul-cpp "cpu"
	build-gend/examples/cnn-inference-int8-cpp "cpu";
	build-gend/examples/cpu-cnn-training-bf16-cpp "cpu";
	build-gend/tests/mkldnn_compat/examples/mkldnn-compat-cnn-inference-int8 "cpu";
	build-gend/tests/mkldnn_compat/examples/mkldnn-compat-cnn-inference-int8-cpp "cpu";
} } >& vd.log
