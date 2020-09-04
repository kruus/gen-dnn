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
    -T test_convolution_forward_f32 \
    -T test_convolution_backward_data_f32 \
    -T test_convolution_backward_weights_f32 \
    -T test_convolution_eltwise_forward_f32 \
    -T test_convolution_format_any \
    -T test_convolution_forward_u8s8fp \
    -T test_convolution_forward_u8s8s32 \
    -T test_convolution_eltwise_forward_x8s8f32s32 \
    ; } >& y.log
fi
#primitives-convolution-cpp                      cnn-inference-int8-cpp
#test_convolution_backward_data_f32              test_iface_pd_iter
#test_convolution_backward_weights_f32           test_iface_runtime_attr
#test_convolution_eltwise_forward_f32            test_iface_runtime_dims
#test_convolution_eltwise_forward_x8s8f32s32     test_iface_stream_attr
#test_convolution_format_any                     test_inner_product_backward_data
#test_convolution_forward_f32                    test_inner_product_backward_weights
#test_convolution_forward_u8s8fp                 test_inner_product_forward
#test_convolution_forward_u8s8s32                test_layer_normalization
#test_deconvolution                              test_lrn_backward
#primitives-convolution-cpp                      test_benchdnn_rnn_cpu
#rnn-training-f32-cpp                            test_convolution_backward_data_f32
#test                                            test_convolution_backward_weights_f32
#test_alloc_scratchpad                           test_convolution_eltwise_forward_f32
#test_api                                        test_convolution_eltwise_forward_x8s8f32s32
#test_batch_normalization_f32                    test_convolution_format_any
#test_batch_normalization_s8                     test_convolution_forward_f32
#test_benchdnn_binary                            test_convolution_forward_u8s8fp
#test_benchdnn_binary_bf16                       test_convolution_forward_u8s8s32
#test_benchdnn_binary_cpu                        test_deconvolution

