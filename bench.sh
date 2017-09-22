#!/bin/bash
#
#################
#     select one:
BUILD=build
#BUILD=buildd
#BUILD=build-jit
#BUILD=build-jitd
#################
#
(cd ${BUILD}/tests/benchdnn && VERBOSE=1 make) || { echo "Compile issues?"; exit; }
echo <<EOF
Here are the output fields for performance benchmarks:
	string: perf
	convolution name
	full conv-desc
	number of giga ops calculated
	effective cpu frequency in GHz (amb clocks[min] / time[min])
	minimum time spent in ms
	best gigaops (since it corresponds to mimimum time)
	average time spent in ms
	average gigaops (since it corresponds to average time)
as reported by the default output template
	perf,%n,%d,%GO,%GF,%-t,%-Gp,%0t,%0Gp
EOF
echo "Bench Convolution Performance for just fwd alexnet:conv1 ..."
(cd ${BUILD}/tests/benchdnn && ./benchdnn --conv --mode=P -v3 --cfg=f32 --dir=FWD_B mb1_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
(cd ${BUILD}/tests/benchdnn && ./benchdnn --conv --mode=P -v3 --cfg=f32 --dir=FWD_B mb12_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
(cd ${BUILD}/tests/benchdnn && ./benchdnn --conv --mode=P -v3 --cfg=f32 --dir=FWD_B mb32_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }

echo "Bench Convolution Performance for default fwd conv layers (many!) ..."
(cd ${BUILD}/tests/benchdnn && ./benchdnn --conv --mode=P -v3 --cfg=f32 --dir=FWD_B ) 2>&1 | tee bench-conv-tmp.log || { echo "Ohoh"; exit; }
mv bench-conv-tmp.log bench-conv.log
echo "Bench Convolution Correctness for default fwd conv layers (many!) ..."
(cd ${BUILD}/tests/benchdnn && ./benchdnn --conv          -v3 --cfg=f32 --dir=FWD_B ) 2>&1 | tee bench-conv-tmp.log || { echo "Ohoh"; exit; }
mv bench-conv-tmp.log bench-conv-correct.log

