/*******************************************************************************
* Copyright 2016-2017 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

#include <iostream>
#include <numeric>
#include "mkldnn.hpp"

using namespace mkldnn;

#define TRACE(...) do { std::cout<<__VA_ARGS__<<std::endl; }while(0)

void simple_net(){
    TRACE("simple_net() creates a cpu_engine");
    auto cpu_engine = engine(engine::cpu, 0);

    const uint32_t batch = 8;

#if defined(NDEBUG)
#define SRC_PIX 227
#define CNV_WID 11
#define SRC_STRIDE 4
#define CNV_OSZ 55
#define POOL_OSZ 27
#else
/** reduce from original 227 for faster debug runs... */
#define SRC_PIX 67/*227*/
#define CNV_WID 11/*11*/
#define SRC_STRIDE 4
#define CNV_OSZ ((SRC_PIX - (CNV_WID/2 + 2))/SRC_STRIDE)/*55*/
#define POOL_OSZ ((CNV_OSZ)/2)/*27*/
#endif
    TRACE("setting various layer dimension");
    std::vector<float> net_src(batch * 3 * SRC_PIX * SRC_PIX);
    std::vector<float> net_dst(batch * 96 * POOL_OSZ * POOL_OSZ);

    /* AlexNet: conv
     * {batch, 3, 227, 227} (x) {96, 3, 11, 11} -> {batch, 96, 55, 55}
     * strides: {4, 4}
     */
    memory::dims conv_src_tz = {batch, 3, SRC_PIX, SRC_PIX};
    memory::dims conv_weights_tz = {96, 3, CNV_WID, CNV_WID};
    memory::dims conv_bias_tz = {96};
    memory::dims conv_dst_tz = {batch, 96, CNV_OSZ, CNV_OSZ};
    memory::dims conv_strides = {SRC_STRIDE, SRC_STRIDE};
    auto conv_padding = {0, 0};

    std::vector<float> conv_weights(std::accumulate(conv_weights_tz.begin(),
        conv_weights_tz.end(), 1, std::multiplies<uint32_t>()));
    std::vector<float> conv_bias(std::accumulate(conv_bias_tz.begin(),
        conv_bias_tz.end(), 1, std::multiplies<uint32_t>()));

    /* create memory for user data */
    TRACE("create memory for user data");
    auto conv_user_src_memory = memory({{{conv_src_tz}, memory::data_type::f32,
        memory::format::nchw}, cpu_engine}, net_src.data());
    auto conv_user_weights_memory = memory({{{conv_weights_tz},
        memory::data_type::f32, memory::format::oihw}, cpu_engine},
        conv_weights.data());
    auto conv_user_bias_memory = memory({{{conv_bias_tz},
        memory::data_type::f32, memory::format::x}, cpu_engine},
        conv_bias.data());

    /* create memory descriptors for convolution data w/ no specified format */
    TRACE("create memory descriptors for convolution data w/ no specified format");
    auto conv_src_md = memory::desc({conv_src_tz}, memory::data_type::f32,
        memory::format::any);
    auto conv_bias_md = memory::desc({conv_bias_tz}, memory::data_type::f32,
        memory::format::any);
    auto conv_weights_md = memory::desc({conv_weights_tz},
        memory::data_type::f32, memory::format::any);
    auto conv_dst_md = memory::desc({conv_dst_tz}, memory::data_type::f32,
        memory::format::any);

    /* create a convolution */
    TRACE("create a convolution");
    auto conv_desc = convolution_forward::desc(prop_kind::forward,
        convolution_direct, conv_src_md, conv_weights_md, conv_bias_md,
        conv_dst_md, conv_strides, conv_padding, conv_padding,
        padding_kind::zero);
    auto conv_prim_desc =
        convolution_forward::primitive_desc(conv_desc, cpu_engine);

    std::vector<primitive> net;

    /* create reorders between user and data if it is needed and
     *  add it to net before convolution */
    TRACE("create reorders between src data and conv input [if req'd]");
    auto conv_src_memory = conv_user_src_memory;
    if (memory::primitive_desc(conv_prim_desc.src_primitive_desc()) !=
        conv_user_src_memory.get_primitive_desc()) {
        conv_src_memory = memory(conv_prim_desc.src_primitive_desc());
        net.push_back(reorder(conv_user_src_memory, conv_src_memory));
    }

    auto conv_weights_memory = conv_user_weights_memory;
    if (memory::primitive_desc(conv_prim_desc.weights_primitive_desc()) !=
        conv_user_weights_memory.get_primitive_desc()) {
        conv_weights_memory = memory(conv_prim_desc.weights_primitive_desc());
        net.push_back(reorder(conv_user_weights_memory, conv_weights_memory));
    }

    auto conv_dst_memory = memory(conv_prim_desc.dst_primitive_desc());

    /* create convolution primitive and add it to net */
    TRACE("create conv primitive and add it to net");
    net.push_back(convolution_forward(conv_prim_desc, conv_src_memory,
        conv_weights_memory, conv_user_bias_memory, conv_dst_memory));

    /* AlexNet: relu
     * {batch, 96, 55, 55} -> {batch, 96, 55, 55}
     */
    const double negative_slope = 1.0;

    auto relu_dst_memory = memory(conv_prim_desc.dst_primitive_desc());

    /* create relu primitive and add it to net */
    TRACE("create relu primitive and add it to net");
    auto relu_desc = relu_forward::desc(prop_kind::forward,
            conv_prim_desc.dst_primitive_desc().desc(), negative_slope);
    auto relu_prim_desc = relu_forward::primitive_desc(relu_desc, cpu_engine);

    net.push_back(relu_forward(relu_prim_desc, conv_dst_memory,
            relu_dst_memory));

    /* AlexNet: lrn
     * {batch, 96, 55, 55} -> {batch, 96, 55, 55}
     * local size: 5
     * alpha: 0.0001
     * beta: 0.75
     */
    const uint32_t local_size = 5;
    const double alpha = 0.0001;
    const double beta = 0.75;
    const double k = 1.0;

    auto lrn_dst_memory = memory(relu_dst_memory.get_primitive_desc());

    /* create lrn primitive and add it to net */
    TRACE("create lrn primitive and add it to net");
    auto lrn_desc = lrn_forward::desc(prop_kind::forward, lrn_across_channels,
                conv_prim_desc.dst_primitive_desc().desc(), local_size,
                alpha, beta, k);
    TRACE("retrieve lrn memory descriptor");
    auto lrn_prim_desc = lrn_forward::primitive_desc(lrn_desc, cpu_engine);

    /* create lrn scratch memory from lrn primitive descriptor */
    TRACE("create lrn scratch memory from lrn primitive descriptor");
    auto lrn_scratch_memory = memory(lrn_prim_desc.workspace_primitive_desc());

    TRACE("push lrn onto net");
    net.push_back(lrn_forward(lrn_prim_desc, relu_dst_memory,
        lrn_scratch_memory, lrn_dst_memory));

    /* AlexNet: pool
     * {batch, 96, 55, 55} -> {batch, 96, 27, 27}
     * kernel: {3, 3}
     * strides: {2, 2}
     */
    memory::dims pool_dst_tz = {batch, 96, POOL_OSZ, POOL_OSZ};
    memory::dims pool_kernel = {3, 3};
    memory::dims pool_strides = {2, 2};
    auto pool_padding = {0, 0};

    auto pool_user_dst_memory = memory({{{pool_dst_tz}, memory::data_type::f32,
        memory::format::nchw}, cpu_engine}, net_dst.data());

    auto pool_dst_md = memory::desc({pool_dst_tz}, memory::data_type::f32,
        memory::format::any);

    /* create a pooling */
    auto pool_desc = pooling_forward::desc(prop_kind::forward, pooling_max,
        lrn_dst_memory.get_primitive_desc().desc(), pool_dst_md, pool_strides,
        pool_kernel, pool_padding, pool_padding, padding_kind::zero);
    auto pool_pd = pooling_forward::primitive_desc(pool_desc, cpu_engine);

    auto pool_dst_memory = pool_user_dst_memory;
    if (memory::primitive_desc(pool_pd.dst_primitive_desc()) !=
        pool_user_dst_memory.get_primitive_desc()) {
        pool_dst_memory = memory(pool_pd.dst_primitive_desc());
    }

    /* create pooling indices memory from pooling primitive descriptor */
    auto pool_indices_memory = memory(pool_pd.workspace_primitive_desc());

    /* create pooling primitive an add it to net */
    TRACE("create pooling primitive an add it to net");
    net.push_back(pooling_forward(pool_pd, lrn_dst_memory, pool_dst_memory,
        pool_indices_memory));

    /* create reorder between internal and user data if it is needed and
     *  add it to net after pooling */
    if (pool_dst_memory != pool_user_dst_memory) {
        net.push_back(reorder(pool_dst_memory, pool_user_dst_memory));
    }

    stream(stream::kind::eager).submit(net).wait();
    std::cout<<" simple_net.cpp stream(eager).submit(net).wait() DONE (yay)"<<std::endl;
}

#if defined(_SX)
#include <string>       // operator<<(ostream,string) is defined here!
#endif
int main(int argc, char **argv) {
    try {
        simple_net();
    }
    catch(error& e) {
        std::cerr << "status: " << e.status << std::endl;
        std::cerr << "message: " << e.message << std::endl;
    }
    std::cout<<" \nGoodbye"<<std::endl;
    return 0;
}
