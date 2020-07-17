#!/bin/bash
# vim: ts=2 sw=2 et
# Run all built-in benchdnn convolution 'make' targets via 'vetest.sh -T'
# Modify before running!
BDIR=build-vejd2
NODE=2
err=""
#
# Let's remove the "install" recompile so it is done just once, up front
#     { make -C $BDIR -j 16 install || make -C $BDIR -j 1 install; }
rm -f conv-benchdnn.log
echo "Rebuilding once:  'make install' --> conv-benchdnn.log"
{ make -C $BDIR -j 16 install || make -C $BDIR -j 1 install;
} >> conv-benchdnn.log 2>&1 \
  && true || err="Error during 'make install'"

if [ ! "${err}" ]; then
	rm -f conv_*.log
  for SUFF in 3d 3d_f32_nxc attributes bf16 bfloat16 depthwise dilated dilated_f32_nxc f32 f32_nxc function gemm_bf16 gemm_f32 gemm_int8 int8 int8_wino topologies topologies_f32_nxc wino; do
    testname="test_benchdnn_conv_${SUFF}"
    logfile="conv_${SUFF}.log"
    echo -n "Running ${testname}   --> ${logfile}   : "
    # Run by hand, one might 'make install' every time:
    #     { make -C $BDIR -j 16 install || make -C $BDIR -j 1 install; }
    { true \
      && ./vetest.sh -B $BDIR -N $NODE -L "${logfile}" -vv -T "${testname}"; \
    } >> conv-benchdnn.log 2>&1 \
      && echo YAY || echo OHOH
    if [ ! -f "${logfile}" ]; then
      err="${err}  missing log file ${logfile} ?\\n"
    fi
  done
  echo 'Summary of conv_*.log benchdnn files:'
  tail -n 400 conv_*.log | grep '\(^=\)\|\(failed:\)'
fi

echo "Execution log --> conv-benchdnn.log"
if [ "${err}" ]; then echo "${err}"; fi
