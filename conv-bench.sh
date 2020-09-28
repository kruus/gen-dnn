#!/bin/bash
# vim: ts=2 sw=2 et
# Run all built-in benchdnn convolution 'make' targets via 'vetest.sh -T'
# Modify before running!
SUFF=ved
BDIR="build-${SUFF}"
IDIR="install-${SUFF}"
NODE=0
err=""
#
# Let's remove the "install" recompile so it is done just once, up front
#     { make -C $BDIR -j 16 install || make -C $BDIR -j 1 install; }
rm -f conv-benchdnn.log
rm -f "${IDIR}"
echo "Rebuilding once:  'make install' --> conv-benchdnn.log"
{ make -C "${BDIR}" -j 16 install || make -C $BDIR -j 1 install;
} >> conv-benchdnn.log 2>&1 \
  && true || err="Error during 'make install'"

#[aurora-ds08 conv]$ ./vetest.sh -B build-ved -l | fmt -w 1 | grep conv_ | grep -v cpu$
set_basic='attributes function 3d depthwise dilated f32 gemm_f32 topologies wino '
set_nxc='3d_f32_nxc attributes_f32_nxc dilated_f32_nxc f32_nxc topologies_f32_nxc'
set_bf16='bf16 bfloat16 gemm_bf16'
set_int8='gemm_int8 int8 int8_wino'
set_all="${set_basic} ${set_int8} ${set_bf16} ${set_nxc}"
if [ ! "${err}" ]; then
	rm -f conv_*.log

  for SUFF in ${set_all}; do

    testname="test_benchdnn_conv_${SUFF}"
    logfile="conv_${SUFF}.log"
    echo -n "Running ${testname}   --> ${logfile}   : "
    # Run by hand, one might 'make install' every time:
    #     { make -C $BDIR -j 16 install || make -C $BDIR -j 1 install; }
    { true \
      && ./vetest.sh -B $BDIR -N $NODE -L "${logfile}" -vvv -T "${testname}"; \
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
