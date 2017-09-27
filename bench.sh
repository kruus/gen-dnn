#!/bin/bash
#
#################
if [ `uname` == 'SUPER-UX' ]; then
	#BUILD=build-sx
	# let's take the MOST RECENT of build-sx or build-sxd directories ...
	BUILD=`ls -ldst build-sx* | grep ' drwx' | head -1 | sed 's/.*\(build.*\)/\1/'`
	LOGDIR=guest/sx
	mkdir -p guest/sx
	chmod ugo+w guest/sx
else
	#     select one:
	BUILD=build
	#BUILD=buildd
	#BUILD=build-jit
	#BUILD=build-jitd
	(cd ${BUILD}/tests/benchdnn && VERBOSE=1 make) || { echo "Compile issues?"; exit; }
	LOGDIR=./
fi
#################
#
BENCHDIR=${BUILD}/tests/benchdnn
echo "BUILD    directory : ${BUILD}"
echo "benchdnn directory : ${BENCHDIR}"
cat <<EOF
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
RUNME=./benchdnn
#
# Comment these out to use system default (all for Intel)
#
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
{
(cd ${BENCHDIR} && ${RUNME} --conv --mode=P -v3 --cfg=f32 --dir=FWD_B mb1_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
(cd ${BENCHDIR} && ${RUNME} --conv --mode=P -v3 --cfg=f32 --dir=FWD_B mb12_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
(cd ${BENCHDIR} && ${RUNME} --conv --mode=P -v3 --cfg=f32 --dir=FWD_B mb32_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
(cd ${BENCHDIR} && ${RUNME} --conv --mode=C -v3 --cfg=f32 --dir=FWD_B mb1_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
(cd ${BENCHDIR} && ${RUNME} --conv --mode=C -v3 --cfg=f32 --dir=FWD_B mb12_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
(cd ${BENCHDIR} && ${RUNME} --conv --mode=C -v3 --cfg=f32 --dir=FWD_B mb32_ic3ih227iw227_oc96oh55ow55_kh11kw11_sh4sw4ph0pw0_nalexnet:conv1 ) || { echo "Ohoh"; exit; }
} 2>&1 | tee ${LOGDIR}/bench-quick.log

echo "Bench Convolution Performance for default fwd conv layers (many!) ..."
(cd ${BENCHDIR} && ${RUNME} --conv --mode=P -v3 --cfg=f32 --dir=FWD_B ) 2>&1 | tee ${LOGDIR}/bench-conv-tmp.log \
&& mv ${LOGDIR}/bench-conv-tmp.log ${LOGDIR}/bench-conv.log \
|| { echo "Ohoh"; exit; }
echo "Bench Convolution Correctness for default fwd conv layers (many!) ..."
(cd ${BENCHDIR} && ${RUNME} --conv          -v3 --cfg=f32 --dir=FWD_B ) 2>&1 | tee ${LOGDIR}/bench-conv-tmp.log \
&& mv ${LOGDIR}/bench-conv-tmp.log ${LOGDIR}/bench-conv-correct.log \
|| { echo "Ohoh"; exit; }

