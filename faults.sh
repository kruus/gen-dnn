#!/bin/bash
# vim: et sw=2 ts=2 ft=sh
TEST_ENV=(DNNL_VERBOSE=2)
TEST_ENV+=(VE_INIT_HEAP=ZERO)
TEST_ENV+=(VE_ERRCTL_DEALLOCATE=MSG)
TEST_ENV+=(OMP_STACKSIZE=1G)
TEST_ENV+=(VE_TRACEBACK=VERBOSE)
TEST_ENV+=(VE_INIT_HEAP=ZERO)
TEST_ENV+=(VE_PROGINF=DETAIL)
#TEST_ENV+=(VE_ADVANCEOFF=YES)
#
ULIMIT=65536
ulimit -s $ULIMIT
echo 'ulimit : '`ulimit -s`
echo "/bin/env ${TEST_ENV[@]} <command>"
BLD="build-ved4"
LOG="f.log"
GTESTS='test_dnnl_threading test_inner_product_forward test_rnn_forward test_matmul test_convolution_backward_data_f32 test_convolution_backward_weights_f32 test_deconvolution'
#----------------------- setup
rm -f "${LOG}"
rm -f typescript # we append /dev/tty raw output here.
function decolorize # decolorize FILE [to stdout]
{
  sed -r 's/\x1B\[(([0-9]{1,3})?(;)?([0-9]{1,2})?)?[m,K,H,f,J]//g' "${1}" | tr -d '\r'
}
function test # test COMMAND [ARGS...] -- run in TEST_ENV & send console output to stdout
{
  # run COMMAND in TEST_ENV, returning exit status of COMMAND
  # stdout get the decolorized output of what's seen on terminal,
  #  so abort message that write to /dev/tty also end up on stdout )
  echo 'ulimit : '`ulimit -s`
  echo "/bin/env ${TEST_ENV[@]} $*"
  /bin/env ${TEST_ENV[@]} script -e -a -c $*
  err="$?"
  #decolorize typescript
  #rm -f typescript
  return $err
}
function comment
{
  echo "$*" | tee -a ${LOG}
}

#------------------ rebuild? ---------------------------------
if [ "" ]; then
  echo -n "Rebuilding : ./build.sh -avddddqq ..."
  { ./build.sh -avddddqq; echo "build.sh exit code $?"; } \
    >& q.log \
    && echo "YAY (see q.log)" || { echo "OHOH (see q.log)"; exit 1; }
fi
#------------------ run some tests ---------------------------
tests=0;
fail=0;
ok=0;
# gtests accept --gtest_list_tests and --gtest_filter to run just specific tests
if [ "y" ]; then # "" evaluates to false
  {
    for t in $GTESTS; do
      tests=$(($tests+1))
      { >&2 echo; >&2 echo "test ${t}";
        {
          test "${BLD}/tests/gtests/${t}"
        } \
        && { >&2 echo "OK gtest ${t}"; ok=$(($ok+1)); } \
        || { >&2 echo "ERROR gtest ${t} exit code $?"; fail=$(($fail+1)); }
      }
    done
    decolorize typescript
    rm -f typescript
  } \
    2>&1 1>>"${LOG}" 2> >(tee >(cat 1>&2)) # stdin+stderr-->LOG; stderr-->console
    #2>&1 1>>"${LOG}"
  # console shows just stderr summary, while
  # LOG also captures all decolorized console output of the test (incl abort msg)
fi
comment "Summary: ${tests} tests; ${ok} OK and ${fail} FAILED" 
decolorize f.log > ff.log

#
# failed
#         24 - test_dnnl_threading (Failed)
#         37 - test_inner_product_forward (OTHER_FAULT)
#37: [ RUN      ] TestInnerProductForward/inner_product_test_float.TestsInnerProduct/1
#37: dnnl_verbose,create,cpu,inner_product,gemm:ref,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:bcda:f0 bia_f32::blocked:a:f0 dst_f32::blocked:ab:f0,,,mb2ic512ih2iw2oc48,0.14209
#37: dnnl_verbose,exec,cpu,inner_product,gemm:ref,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:bcda:f0 bia_f32::blocked:a:f0 dst_f32::blocked:ab:f0,,,mb2ic512ih2iw2oc48,1.15991
#37: test_inner_product_forward: malloc.c:2923: __libc_malloc: Assertion `!victim || ((((mchunkptr)((char*)(victim) - 2*(sizeof(size_t)))))->size & 0x2) || ar_ptr == (((((mchunkptr)((char*)(victim) - 2*(sizeof(size_t)))))->size & 0x4) ? ((heap_info *) ((unsigned long) (((mchunkptr)((char*)(victim) - 2*(sizeof(size_t))))) & ~((2 * (1LL << 30)) - 1)))->ar_ptr : &main_arena)' failed.                                        
#21/52 Test #37: test_inner_product_forward ....................***Exception: Other  2.02 sec
#
#         47 - test_convolution_backward_data_f32 (SEGFAULT)
#47: [ RUN      ] BackwardData_Simple_NCHW_CPU/convolution_test.TestConvolution/0
#47: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#31/52 Test #47: test_convolution_backward_data_f32 ............***Exception: SegFault  3.65 sec
#
#         48 - test_convolution_backward_weights_f32 (SEGFAULT)
#48: [ RUN      ] BackwardWeights_Simple_NCHW_CPU/convolution_test.TestConvolution/0
#48: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#32/52 Test #48: test_convolution_backward_weights_f32 .........***Exception: SegFault  4.29 sec
#
#         49 - test_deconvolution (SEGFAULT)
#49: [ RUN      ] SimpleSmall_NCHW_CPU/deconvolution_test_float.TestDeconvolution/0
#49: dnnl_verbose,info,verbose:2
#49: dnnl_verbose,info,DNNL v1.3.0 (commit 86e142dd5617a18f526b56acf0fc09e37b3012ce)
#49: dnnl_verbose,info,cpu,runtime:OpenMP
#49: dnnl_verbose,info,cpu,isa:Vanilla
#49: dnnl_verbose,info,gpu,runtime:none
#49: dnnl_verbose,create,cpu,convolution,ref:any,backward_data,src_f32::blocked:abcd:f0 wei_f32::blocked:bacd:f0 bia_f32::blocked:a:f0 dst_f32::blocked:abcd:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.139893
#49: dnnl_verbose,create,cpu,deconvolution,ref:any,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:abcd:f0 bia_f32::blocked:a:f0 dst_f32::blocked:abcd:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,1.01392
#49: dnnl_verbose,exec,cpu,deconvolution,ref:any,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:abcd:f0 bia_f32::blocked:a:f0 dst_f32::blocked:abcd:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.937012
#49: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#33/52 Test #49: test_deconvolution ............................***Exception: SegFault  0.49 sec
#
#         59 - test_rnn_forward (SEGFAULT)
#59: [ RUN      ] TestRnn_CPU/rnn_forward_test_f32.TestsRnn/0
#59:  init strm @ 0x60fffff9a408
#...
#59:  init_tensor(src_iter...)DONE...
#59: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#43/52 Test #59: test_rnn_forward ..............................***Exception: SegFault  0.48 sec
#
#         63 - test_matmul (OTHER_FAULT)
#63: [ RUN      ] Generic_s8s8s32/iface.TestsMatMul/5
#63: dnnl_verbose,create,cpu,matmul,matmul-gemm:ref,undef,src_s8::blocked:ba:f0 wei_s8::blocked:ab:f0 bia_f32::blocked:ab:f0 dst_s32::blocked:ab:f0,oscale:0:2;zero_points:'src:0:-2_wei:0:2';,,m10n20k2,0.172852
#63: dnnl_verbose,exec,cpu,matmul,matmul-gemm:ref,undef,src_s8::blocked:ba:f0 wei_s8::blocked:ab:f0 bia_f32::blocked:ab:f0 dst_s32::blocked:ab:f0,oscale:0:2;zero_points:'src:0:-2_wei:0:2';,,m10n20k2,0.477051
#47/52 Test #63: test_matmul ...................................***Exception: Other  0.63 sec
#
