#!/bin/bash
# vim: sw=2 ts=2 et
S=ved
B=build-$S
I=install-$S
NODE=0
if [ ! -d "$B" ]; then
  echo -n "no $B directory?"
else
  echo "directory = `pwd`"
  echo "remake --> x.log"
  rm -rf $I
  #  -T test_convolution_backward_data_f32
  #  -T test_convolution_backward_weights_f32
  { time make -C $B -j 16 install; } >& x.log \
    && { \
    ./vetest.sh -B $B -N $NODE -vv -L convG.log -vvv \
    -T test_convolution_format_any \
    -T test_convolution_forward_f32 \
    -T test_convolution_eltwise_forward_f32 \
    -T test_convolution_forward_u8s8fp \
    -T test_convolution_forward_u8s8s32 \
    -T test_convolution_eltwise_forward_x8s8f32s32 \
    ; } >& y.log
fi
