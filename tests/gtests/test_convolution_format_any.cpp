/*******************************************************************************
* Copyright 2016-2018 Intel Corporation
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

#include "mkldnn_test_common.hpp"
#include "gtest/gtest.h"
#include "cpu_isa_traits.hpp"

#include "mkldnn.hpp"

#define FMT_DEBUG 0
#if FMT_DEBUG
#include "mkldnn_debug.h"
#include "mkldnn_io.hpp"
#include <iostream>
using std::cout;
using std::endl;
#define SHOW(msg,what) std::cout<<msg<<what<<std::endl;
inline std::ostream& operator<<(std::ostream& os, fmt const& f){
    return os << mkldnn_fmt2str((mkldnn_memory_format_t)f);
}
// SHOX should agree with EXP_VALS_NUM ...
#define SHOX(msg,what) std::cout<<msg<<what[0]<<" / "<<what[1]<<" / "<<what[2]<<std::endl;

#else
#define SHOW(msg,what)
#define SHOX(msg,what)
#endif

namespace mkldnn {

using fmt = memory::format;

#define EXP_VALS_NUM 3
struct fmt_compare {
    fmt in;
    fmt exp[EXP_VALS_NUM];
};
struct conv_any_fmt_test_params {
    prop_kind aprop_kind;
    const engine::kind engine_kind;
    algorithm aalgorithm;
    fmt_compare src_fmt;
    fmt_compare weights_fmt;
    fmt_compare bias_fmt;
    fmt_compare dst_fmt;
    test_convolution_sizes_t test_cd;
};

template <typename data_t>
class convolution_any_fmt_test
        : public ::testing::TestWithParam<conv_any_fmt_test_params> {
protected:
    virtual bool FmtIsExp(const mkldnn_memory_format_t in, fmt *exp ) {
        for (int i = 0; i < EXP_VALS_NUM; i++)
            if (in == exp[i])
                return true;
        return false;
    }
    virtual void SetUp()
    {
        // Skip this test if the library cannot select blocked format a priori.
        // Currently blocking is supported only for sse42 and later CPUs.
        bool implementation_supports_blocking
            = impl::cpu::mayiuse(impl::cpu::sse42);
        if (!implementation_supports_blocking) return;

        conv_any_fmt_test_params p = ::testing::
                TestWithParam<conv_any_fmt_test_params>::GetParam();

        ASSERT_TRUE(p.engine_kind == engine::kind::cpu);
        ASSERT_EQ(p.aprop_kind, prop_kind::forward);
        ASSERT_EQ(p.aalgorithm, algorithm::convolution_direct);
        auto eng = engine(p.engine_kind, 0);
        memory::data_type data_type = data_traits<data_t>::data_type;
        ASSERT_EQ(data_type, mkldnn::memory::data_type::f32);

        // Some format chekers
        ASSERT_NE(p.src_fmt.exp[0], fmt::any);
        ASSERT_NE(p.weights_fmt.exp[0], fmt::any);
        ASSERT_NE(p.bias_fmt.exp[0], fmt::any);
        ASSERT_NE(p.dst_fmt.exp[0], fmt::any);
        ASSERT_TRUE(
                p.src_fmt.in == fmt::any || p.src_fmt.in == p.src_fmt.exp[0]);
        ASSERT_TRUE(p.weights_fmt.in == fmt::any
                || p.weights_fmt.in == p.weights_fmt.exp[0]);
        ASSERT_TRUE(p.bias_fmt.in == fmt::any
                || p.bias_fmt.in == p.bias_fmt.exp[0]);
        ASSERT_TRUE(
                p.dst_fmt.in == fmt::any || p.dst_fmt.in == p.dst_fmt.exp[0]);

        test_convolution_sizes_t cd = p.test_cd;

        auto c_src_desc = create_md(
                { cd.mb, cd.ic, cd.ih, cd.iw }, data_type, p.src_fmt.in);
        auto c_weights_desc = cd.ng > 1 ?
                create_md({ cd.ng, cd.oc / cd.ng, cd.ic / cd.ng, cd.kh, cd.kw },
                        data_type, p.weights_fmt.in) :
                create_md({ cd.oc, cd.ic, cd.kh, cd.kw }, data_type,
                        p.weights_fmt.in);
        auto c_dst_desc = create_md(
                { cd.mb, cd.oc, cd.oh, cd.ow }, data_type, p.dst_fmt.in);

        bool with_bias = p.bias_fmt.in != fmt::format_undef;
        auto c_bias_desc = with_bias ?
                create_md({ cd.oc }, data_type, p.bias_fmt.in) :
                create_md({}, data_type, p.bias_fmt.in);

        auto conv_desc = with_bias ?
                convolution_forward::desc(p.aprop_kind, p.aalgorithm, c_src_desc,
                        c_weights_desc, c_bias_desc, c_dst_desc,
                        { cd.strh, cd.strw }, { cd.padh, cd.padw }, { cd.padh, cd.padw },
                        padding_kind::zero) :
                convolution_forward::desc(p.aprop_kind, p.aalgorithm, c_src_desc,
                        c_weights_desc, c_dst_desc, { cd.strh, cd.strw }, { cd.strh, cd.strw },
                        { cd.padh, cd.padw }, padding_kind::zero);

        auto conv_prim_desc = convolution_forward::primitive_desc(conv_desc, eng);
        SHOW(" src   : fmt -->",conv_prim_desc.src_primitive_desc().desc().data.format);
        SHOW("         desc-->",conv_prim_desc.src_primitive_desc().desc().data);
        SHOW("          in -->",mkldnn_fmt2str((mkldnn_memory_format_t)p.src_fmt.in));
        SHOX("         exp -->",p.src_fmt.exp);
        ASSERT_TRUE(
                FmtIsExp(conv_prim_desc.src_primitive_desc().desc().data.format,
                        p.src_fmt.exp));
        SHOW("weights: fmt -->",conv_prim_desc.weights_primitive_desc().desc().data.format);
        SHOW("         desc-->",conv_prim_desc.weights_primitive_desc().desc().data);
        SHOX("         exp -->",p.weights_fmt.exp);
        ASSERT_TRUE(FmtIsExp(
                conv_prim_desc.weights_primitive_desc().desc().data.format,
                p.weights_fmt.exp));
        if (with_bias) {
            SHOW("  bias : fmt -->",conv_prim_desc.bias_primitive_desc().desc().data.format);
            SHOW("         desc-->",conv_prim_desc.bias_primitive_desc().desc().data);
            SHOX("         exp -->",p.bias_fmt.exp);
            ASSERT_TRUE(FmtIsExp(
                    conv_prim_desc.bias_primitive_desc().desc().data.format,
                    p.bias_fmt.exp));
        }
        SHOW("  dst  : fmt -->",conv_prim_desc.dst_primitive_desc().desc().data.format);
        SHOW("         desc-->",conv_prim_desc.dst_primitive_desc().desc().data);
        SHOX("         exp -->",p.dst_fmt.exp);
        ASSERT_TRUE(
                FmtIsExp(conv_prim_desc.dst_primitive_desc().desc().data.format,
                        p.dst_fmt.exp));
    }
};

using conv_any_fmt_test_float = convolution_any_fmt_test<float>;
using conv_any_fmt_test_params_float = conv_any_fmt_test_params;

TEST_P(conv_any_fmt_test_float, TestsConvolutionAnyFmt)
{
}
#define ENGINE engine::kind::cpu
#define ALG algorithm::convolution_direct
#define PROP_KIND prop_kind::forward

#define UNDEF fmt::format_undef
#define ANY_X      { fmt::any, { fmt::x, UNDEF, UNDEF } }
#define ANY_NCHW   { fmt::any, { fmt::nchw, UNDEF, UNDEF } }
#define ANY_OIHWxO { fmt::any, { fmt::oihw, fmt::Ohwi8o, UNDEF } }
#define ANY_OIHWxI { fmt::any, { fmt::nchw, fmt::oIhw8i, UNDEF } }
// added formats so gemm/ref impls also pass...
INSTANTIATE_TEST_CASE_P(TestConvolutionAnyFmtForward, conv_any_fmt_test_float,
    ::testing::Values(conv_any_fmt_test_params_float{ PROP_KIND, ENGINE, ALG,
    ANY_NCHW, ANY_OIHWxO, ANY_X, ANY_OIHWxI,
    /* src    weights     bias   dst    */
    { 2, 1, 4, 4, 4, 6, 4, 4, 3, 3, 1, 1, 1, 1 }/* conv sizes */ }));

#if !defined(TARGET_VANILLA)
// Typically jit-related to Intel SIMD register lengths
#define ANY_OHWIxO { fmt::any,   \
                   { fmt::Ohwi8o, fmt::Ohwi16o, fmt::Oihw16o } }
#define ANY_NCHWxC { fmt::any,   \
                   { fmt::nChw8c, fmt::nChw16c, UNDEF } }
#define ANY_OIHWxIxO { fmt::any, \
                     { fmt::oihw, fmt::OIhw8i8o, fmt::OIhw16i16o } }
#define ANY_GOIHWxIxO { fmt::any,\
                      { fmt::gOIhw8i8o, fmt::gOIhw16i16o, UNDEF } }

/* For now, these formats all require JIT (cpu/) code */
INSTANTIATE_TEST_CASE_P(
        TestConvolutionAlexnetAnyFmtForwardxlocked, conv_any_fmt_test_float,
        ::testing::Values(
                conv_any_fmt_test_params_float{ PROP_KIND, ENGINE, ALG,
                        ANY_NCHW, ANY_OHWIxO, ANY_X, ANY_NCHW,
                        { 2, 1, 3, 227, 227, 96, 55, 55, 11, 11, 0, 0, 4, 4 } },
                conv_any_fmt_test_params_float{ PROP_KIND, ENGINE, ALG,
                        ANY_NCHWxC, ANY_GOIHWxIxO, ANY_X, ANY_NCHWxC,
                        { 2, 2, 96, 27, 27, 256, 27, 27, 5, 5, 2, 2, 1, 1 } },
                conv_any_fmt_test_params_float{ PROP_KIND, ENGINE, ALG,
                        ANY_NCHWxC, ANY_OIHWxIxO, ANY_X, ANY_NCHWxC,
                        { 2, 1, 256, 13, 13, 384, 13, 13, 3, 3, 1, 1, 1, 1 } },
                conv_any_fmt_test_params_float{ PROP_KIND, ENGINE, ALG,
                        ANY_NCHWxC, ANY_GOIHWxIxO, ANY_X, ANY_NCHWxC,
                        { 2, 2, 384, 13, 13, 384, 13, 13, 3, 3, 1, 1, 1, 1 } },
                conv_any_fmt_test_params_float{ PROP_KIND, ENGINE, ALG,
                    ANY_NCHWxC, ANY_GOIHWxIxO, ANY_X, ANY_NCHWxC,
                    { 2, 2, 384, 13, 13, 256, 13, 13, 3, 3, 1, 1, 1, 1 } }));
#endif // TARGET_VANILLA

}
