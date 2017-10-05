# C++ vs C

- simple_net is ~ twice as many lines in C. Why?
  - C++ constructors can do some routine tasks:
    - aligned malloc calls
    - object 'init' calls
    - memory freeing during destructor
    - query operations can be simple C++ getters
    - C++ enums shorter, in a namespace, so easier to read code

Consider the [simple_net.cpp example](https://software.intel.com/en-us/articles/intel-mkl-dnn-part-2-sample-code-build-and-walkthrough) example.

#### C++

    /* AlexNet: relu
     * {batch, 96, 55, 55} -> {batch, 96, 55, 55}
     */
    const double negative_slope = 1.0;
    auto relu_dst_memory = mkldnn::memory(conv_prim_desc.dst_primitive_desc());
   
    auto relu_desc = mkldnn::relu_forward::desc(mkldnn::prop_kind::forward,
    conv_prim_desc.dst_primitive_desc().desc(), negative_slope);
   
    auto relu_prim_desc = mkldnn::relu_forward::primitive_desc(relu_desc, cpu_engine);
   
    net.push_back(mkldnn::relu_forward(relu_prim_desc, conv_dst_memory,
    relu_dst_memory));

Even this is a bit much for a _user_ API -- hopefully memory allocation would
be done by Torch/Caffer/Tensorflow/...

However, the C++ API already streamlines a lot of boilerplate code. Compare with
the C API code:

#### C

    /* create a relu */
    mkldnn_eltwise_desc_t relu_desc;
    TRACE("mkldnn_eltwise_forward_desc_init (for relu)");
    CHECK(mkldnn_eltwise_forward_desc_init(&relu_desc, mkldnn_forward,
                mkldnn_eltwise_relu, relu_src_md, negative_slope, 0));

    mkldnn_primitive_desc_t relu_pd;
    TRACE("mkldnn_primitive_desc_create...");
    CHECK(mkldnn_primitive_desc_create(&relu_pd, &relu_desc, engine, NULL));

    mkldnn_primitive_t relu_dst_memory;
    TRACE("mkldnn_primitive_desc_query_pd...");
    const_mkldnn_primitive_desc_t relu_dst_pd = mkldnn_primitive_desc_query_pd(
            relu_pd, mkldnn_query_dst_pd, 0);
    CHECK(mkldnn_primitive_create(&relu_dst_memory, relu_dst_pd, NULL, NULL));
    CHECK(mkldnn_memory_set_data_handle(relu_dst_memory, relu_dst_buffer));

    TRACE("create relu primitive");
    /* finally create a relu primitive */
    mkldnn_primitive_t relu;
    mkldnn_primitive_at_t relu_srcs = { conv_internal_dst_memory, 0 };
    const_mkldnn_primitive_t relu_dsts[] = { relu_dst_memory };

    CHECK(mkldnn_primitive_create(&relu, relu_pd, &relu_srcs, relu_dsts));
    /* create a relu */
    mkldnn_eltwise_desc_t relu_desc;
    TRACE("mkldnn_eltwise_forward_desc_init (for relu)");
    CHECK(mkldnn_eltwise_forward_desc_init(&relu_desc, mkldnn_forward,
                mkldnn_eltwise_relu, relu_src_md, negative_slope, 0));

    mkldnn_primitive_desc_t relu_pd;
    TRACE("mkldnn_primitive_desc_create...");
    CHECK(mkldnn_primitive_desc_create(&relu_pd, &relu_desc, engine, NULL));

    mkldnn_primitive_t relu_dst_memory;
    TRACE("mkldnn_primitive_desc_query_pd...");
    const_mkldnn_primitive_desc_t relu_dst_pd = mkldnn_primitive_desc_query_pd(
            relu_pd, mkldnn_query_dst_pd, 0);
    CHECK(mkldnn_primitive_create(&relu_dst_memory, relu_dst_pd, NULL, NULL));
    CHECK(mkldnn_memory_set_data_handle(relu_dst_memory, relu_dst_buffer));

    TRACE("create relu primitive");
    /* finally create a relu primitive */
    mkldnn_primitive_t relu;
    mkldnn_primitive_at_t relu_srcs = { conv_internal_dst_memory, 0 };
    const_mkldnn_primitive_t relu_dsts[] = { relu_dst_memory };

    CHECK(mkldnn_primitive_create(&relu, relu_pd, &relu_srcs, relu_dsts));

OK, so this is a low-level library.  C++ offers some automation, but
for real use, mkl-dnn is an implementation library for some ML framework.

Example: [Intel-Caffe](https://github.com/intel/caffe)

### Public API largely governed by enum values

So let''s look at some exemplary enums from [mkldnn_types.h](https://github.com/kruus/gen-dnn/blob/master/include/mkldnn_types.h)
{
| type name | enum/type | value | comment
| :--- |:--- |:--- |:---
| mkldnn_status_t | mkldnn_success | 0 | operation successful
|        | mkldnn_out_of_memory | 1 | failure
|        | ... | | |
| mkldnn_data_type_t | mkldnn_f32 | 1 | 32-bit floating point
|        | ...s32,s16,s8,u8 | | integer types
| mkldnn_memory_format_t | mkldnn_format_undef | 0 | empty/uninitialized
|        | mkldnn_any  | | primitive selects memory format automatically
|        | mkldnn_nchw | | Caffe-style image (batch, channels, height, width)
|        | mkldnn_nhwc | | Tensorflow/Milde-ish
|        | mkldnn_chwn | | Neon layout
|        | ... | | perhaps 20 more memory formats (many blocked by 8/16 elements)
| mkldnn_padding_kind_t | mkldnn_padding_zero | | How to interpret data in padding regions
| mkdnn_prop_kind_t | mkldnn_forward_training | 64 | fprop (maintain info for bprop
|        | mkldnn_forward_inference | 96 | fprop, with no bprop
|        | mkldnn_backward | | wrt all parameters
|        | ...backward_data | |
|        | ...backward_weights | |
|        | ...backward_bias | |
|        | ... | |
| mkldnn_primitive_kind_t | mkldnn_memory | |
|        | mkldnn_view | |
|        | mkldnn_reorder | |
|        | mkldnn_concat | |
|        | mkldnn_concat_inplace | |
|        | mkldnn_sum | |
|        | mkldnn_convolution | |
|        | mkldnn_eltwise | | for univariate functions
|        | mkldnn_softmax | |
|        | mkldnn_pooling | |
|        | mkldnn_lrn | |
|        | mkldnn_batch_normalization | |
|        | mkldnn_inner_product | |
|        | mkldnn_convolution_relu | |
|        | | |
| mkldnn_algorithm_t | mkldnn_convolution_direct | 1 | im2col gemm
|        | mkldnn_convolution_winograd | 2 | winograd convolution
|        | mkldnn_eltwise_relu/tanh/elu | | various element-wise funcs
|        | mkldnn_lrn_across_channels | |
|        | mkldnn_lrn_within_channel | |
|        | ... | |
| mkldnn_batch_normalization_flag_t | | | global/omit stats? scaleshift?
|        | ... | |
| mkldnn_blocking_desc_t | struct | | blocking strides, padding offsets, ...
| mkldnn_op_desc_t | void * | | opaque op descriptor (resolve to some private data type)
| mkldnn_memory_desc_t | struct | | dims, data_type, mkldnn_memory_format_t, p opt. block layout]
| mkldnn_convolution_desc_t | struct | | many, many parameters
| mkldnn_eltwise_desc_t | struct | |
| mkldnn_softmax_desc_t | struct | |
| mkldnn_pooling_desc_t | struct | |
| mkldnn_lrn_desc_t | struct |
| mkldnn_batch_normalization_desc_t | struct | |
| mkldnn_inner_product_desc_t | struct | |
| mkldnn_convolution_relu_desc_t | struct | |
|        | ... | |
| mkldnn_engine_kind_t | mkldnn_cpu | 1 | Intel CPU
|        | ... |  |
| mkldnn_primitive_desc | struct | | opaque
| mkldnn_primitive | struct | | opaque
| mkldnn_primitive_at | struct | | point to one-of layer inputs? outputs?
|        | ... | |
| mkldnn_query_t | enum | | many property queries
| mkldnn_stream_kind_t | mkldnn_lazy | | stream processing heuristic
| mkldnn_stream | struct | | opaque network execution stream
|        | ... | | layers connected by in/out mem descriptors
}

OK, so have lots of enum values, mostly used to populate
structs describing: memory, primiives (layer ops)

Functions are in [mkldnn.h](https://github.com/kruus/gen-dnn/blob/master/include/mkldnn.h)

1. iterate over primitives that "match" the primitive descriptor
2. query functions (getters)
3. memory primitive create/destroy/equal
4. layer operation primitive create/init
5. a few 'engine' functions
6. stream create, submit, wait, destroy

##### Comments about API functions:

1. iteration: mostly done automatically by engine !
  - to find an implementation corresponds to primitive descriptor, check
    - available on your CPU
    - correct data type,
    - compatible/convertible memory layout,
    - compatible with descriptor 'algorithm' specs
  - typically happens in background, by ordering tables of layer ops in order
    of decreasing speed, so the first "match" is likely to be the fastest
    - so all-C++ kernels may be very slow
2. query functions
  - tedious to use; C++ API can use getters for private data (nicer)
3. memory primitives
  - fundamental operation! Slightly easier in C++
4. layer ops
5. Engine
   - Intel CPU engine supports many instruction sets.
   - used to also have Phi implementations
   - fast impls all generate JIT assembly code for kernels
     - JIT impls very sophisticated:
       - Ex. size of loop code, size of loop limits compared with cache sizes
         on the executing CPU to generate the fastest impls.d
6. Stream
   - seems to be lacking overall optimizations
     - e.g. no sophisticated mechanisms to re-use memory regions, or optimize
       choice of data reordering operations.  (If you ever hit a non-optimized
       reordering op, things get very very slow)
7. General comments:
  - Not good for readability, or robustness
    - ptr lifetimes may be tricky.
    - C `void*` object misuse might not be catchable at compile-time.
  - Possible issues with ordering of \_destroy ops
    - all restrictions/assumptions not documented
  - Does an excellent job at only a few opaque objects for 'details'
  - Excellent checking (during 'init' phase) whether a primitive can be
    correctly applied under current conditions.
  - The C++ API exposes just a little bit of the useful stuff in `src/common`.
    Think about whether some C++ helper classes might be useful to expose.

##### Current Intel work:

- Windows support (SX mods accomplished most of the warning reduction)
- JIT algorithms for integer data types
- Optimizing JIT algs for different CPUs (AVX2, AVX512, ...)
- Tweaking #pragma omp settings
- providing inlinable C++ impls for simple_reorder, as slow
  data reorderings get discovered.
  - (most generic reordering kernel has an unavoidable function call in the inner loop of the kernel for "offset of" calculation)


----------


