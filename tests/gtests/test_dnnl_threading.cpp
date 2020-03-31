/*******************************************************************************
* Copyright 2018-2020 Intel Corporation
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

#include <vector>
#include <mutex>

#include "dnnl_test_common.hpp"
#include "gtest/gtest.h"

#define DEBUG 0

namespace dnnl {

TEST(test_parallel, Test) {
    impl::parallel(0, [&](int ithr, int nthr) {
        ASSERT_LE(0, ithr);
        ASSERT_LT(ithr, nthr);
        ASSERT_LE(nthr, dnnl_get_max_threads());
    });
}

typedef ptrdiff_t data_t;

struct nd_params_t {
    std::vector<ptrdiff_t> dims;
};
using np_t = nd_params_t;

namespace debug {
#if DEBUG
template <typename T>
void print_vec(const char *str, const T *vec, int size) {
    printf("%s", str);
    if (size <= 0)
        printf("EMPTY");
    else {
        char fmt[] = "{%d";
        for (int d = 0; d < size; ++d) {
            printf(fmt, (int)vec[d]);
            fmt[0] = ',';
        }
    }
    printf("}\n");
}
void print_np(np_t const &np) {
    print_vec(" np_t::dims", np.dims.data(), np.dims.size());
}
#else
template <typename T>
void print_vec(const char *, const T *, int) {}
void print_np(np_t const &np) {}
#endif
} // namespace debug

class test_nd : public ::testing::TestWithParam<nd_params_t> {
protected:
    virtual void SetUp() {
        p = ::testing::TestWithParam<decltype(p)>::GetParam();
        size = 1;
        for (auto &d : p.dims)
            size *= d;
        data.resize((size_t)size);
#if DEBUG
        printf(" size %lu ", (long)size);
        debug::print_np(p);
        debug::print_vec(" p.dims", p.dims.data(), p.dims.size());
        debug::print_vec(" data", data.data(), data.size());
#endif
    }

    void CheckID() {
        for (ptrdiff_t i = 0; i < size; ++i)
            ASSERT_EQ(data[i], i);
    }

    nd_params_t p;
    ptrdiff_t size;
    std::vector<data_t> data;
};

class test_for_nd : public test_nd {
protected:
#if DEBUG
    std::mutex ioMutex;
#endif
    void emit_for_nd(int ithr, int nthr)
    // no diff void emit_for_nd(int const& ithr, int const& nthr)
    {
#if DEBUG
#define CAT0(a, ...) a##__VA_ARGS__
#define CAT(a, ...) CAT0(a, __VA_ARGS__)
#define PRT1(x) << ' ' << x
#define PRT2(x, ...) << ' ' << x PRT1(__VA_ARGS__)
#define PRT3(x, ...) << ' ' << x PRT2(__VA_ARGS__)
#define PRT4(x, ...) << ' ' << x PRT3(__VA_ARGS__)
#define PRT5(x, ...) << ' ' << x PRT4(__VA_ARGS__)
#define PRT6(x, ...) << ' ' << x PRT5(__VA_ARGS__)
#define DECL(os) \
    std::ostringstream os
#define SHOW(os, ...) \
    do { \
        std::lock_guard<std::mutex> const lock(ioMutex); \
        os __VA_ARGS__; \
    } while (0)
#define COUT(os) \
    do { \
        std::lock_guard<std::mutex> const lock(ioMutex); \
        std::cout << os.str() << std::endl; \
        std::cout.flush(); \
    } while (0)
#else
#define DECL(os) \
    do { \
    } while (0)
#define SHOW(os, stuff) \
    do { \
    } while (0)
#define COUT(os) \
    do { \
    } while (0)
#endif
        DECL(os);
        SHOW(os, << " emit_for_nd(" << ithr << "/" << nthr << ")\n");
        COUT(os);

        switch ((int)p.dims.size()) {
            case 1:
                impl::for_nd(ithr, nthr, p.dims[0], [&](ptrdiff_t d0) {
                    ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                    data[d0] = d0;
                    SHOW(os, << " " << ithr << "/" << nthr << " d[]: " PRT1(d0)
                             << "\n");
                });
                break;
            case 2:
                impl::for_nd(ithr, nthr, p.dims[0], p.dims[1],
                        [&](ptrdiff_t d0, ptrdiff_t d1) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            const ptrdiff_t idx = d0 * p.dims[1] + d1;
                            SHOW(os, << " " << ithr << "/" << nthr
                                     << " d{" PRT2(d0, d1) << "}-->idx " << idx
                                     << "\n");
                            data[idx] = idx;
                        });
                break;
            case 3:
                impl::for_nd(ithr, nthr, p.dims[0], p.dims[1], p.dims[2],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            const ptrdiff_t idx
                                    = (d0 * p.dims[1] + d1) * p.dims[2] + d2;
                            SHOW(os, << " " << ithr << "/" << nthr
                                     << " d{" PRT3(d0, d1, d2) << "}-->idx "
                                     << idx << "\n");
                            data[idx] = idx;
                        });
                break;
            case 4:
                impl::for_nd(ithr, nthr, p.dims[0], p.dims[1], p.dims[2],
                        p.dims[3],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2,
                                ptrdiff_t d3) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            ASSERT_TRUE(0 <= d3 && d3 < p.dims[3]);
                            const ptrdiff_t idx
                                    = ((d0 * p.dims[1] + d1) * p.dims[2] + d2)
                                            * p.dims[3]
                                    + d3;
                            SHOW(os, << " " << ithr << "/" << nthr
                                     << " d{" PRT4(d0, d1, d2, d3) << "}-->idx "
                                     << idx << "\n");
                            data[idx] = idx;
                        });
                break;
            case 5:
                impl::for_nd(ithr, nthr, p.dims[0], p.dims[1], p.dims[2],
                        p.dims[3], p.dims[4],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2,
                                ptrdiff_t d3, ptrdiff_t d4) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            ASSERT_TRUE(0 <= d3 && d3 < p.dims[3]);
                            ASSERT_TRUE(0 <= d4 && d4 < p.dims[4]);
                            const ptrdiff_t idx
                                    = (((d0 * p.dims[1] + d1) * p.dims[2] + d2)
                                                      * p.dims[3]
                                              + d3)
                                            * p.dims[4]
                                    + d4;
                            SHOW(os, << " " << ithr << "/" << nthr
                                     << " d{" PRT5(d0, d1, d2, d3, d4)
                                     << "}-->idx " << idx << "\n");
                            data[idx] = idx;
                        });
                break;
            case 6:
                impl::for_nd(ithr, nthr, p.dims[0], p.dims[1], p.dims[2],
                        p.dims[3], p.dims[4], p.dims[5],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2,
                                ptrdiff_t d3, ptrdiff_t d4, ptrdiff_t d5) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            ASSERT_TRUE(0 <= d3 && d3 < p.dims[3]);
                            ASSERT_TRUE(0 <= d4 && d4 < p.dims[4]);
                            ASSERT_TRUE(0 <= d5 && d5 < p.dims[5]);
                            const ptrdiff_t idx
                                    = ((((d0 * p.dims[1] + d1) * p.dims[2] + d2)
                                                       * p.dims[3]
                                               + d3) * p.dims[4]
                                              + d4)
                                            * p.dims[5]
                                    + d5;
                            SHOW(os, << " " << ithr << "/" << nthr
                                     << " d{" PRT6(d0, d1, d2, d3, d4, d5)
                                     << "}-->idx " << idx << "\n");
                            data[idx] = idx;
                        });
                break;
            default: ASSERT_TRUE(false);
        }
        COUT(os);
    }
}; // namespace dnnl

TEST_P(test_for_nd, Sequential) {
    emit_for_nd(0, 1);
    CheckID();
}

TEST_P(test_for_nd, Parallel) {
#if 1
	impl::parallel(0, [&](int ithr, int nthr) {
            emit_for_nd(ithr, nthr);
            });

#else
#define PDEBUG 0 // 1 with print statements "fixes" the error
#if PDEBUG
    std::mutex parallelMutex;
    std::ostringstream oss;
    oss<<" TEST_P(test_for_nd, Parallel): ";
#endif
	impl::parallel(0, [&this](int pithr, int pnthr) {
#if PDEBUG
            do {
                std::lock_guard<std::mutex> const lock(parallelMutex);
                oss<<" "<<pithr<<"||"<<pnthr;
            }while(0);
#endif
            auto const pi=pithr;
            auto const pn=pnthr;
            this->emit_for_nd(pi, pn);
            });
#if PDEBUG
    std::cout << oss.str() << std::endl;
    debug::print_vec(" p.dims", p.dims.data(), p.dims.size());
    debug::print_vec(" data", data.data(), data.size());
#endif
#endif
    CheckID();
}

CPU_INSTANTIATE_TEST_SUITE_P(Case0, test_for_nd,
        ::testing::Values(np_t {{0}}, np_t {{1}}, np_t {{100}}, np_t {{0, 0}},
                np_t {{1, 2}}, np_t {{10, 10}}, np_t {{0, 1, 0}},
                np_t {{1, 2, 1}}, np_t {{4, 4, 10}}, np_t {{0, 3, 0, 1}},
                np_t {{1, 1, 2, 1}}, np_t {{4, 4, 5, 2}},
                np_t {{3, 0, 3, 0, 1}}, np_t {{2, 1, 1, 2, 1}},
                np_t {{4, 1, 4, 5, 2}}, np_t {{4, 3, 0, 3, 0, 1}},
                np_t {{2, 1, 3, 1, 2, 1}}, np_t {{4, 1, 4, 3, 2, 2}}));

class test_for_nd_with_diff_types : public test_nd {};
TEST_P(test_for_nd_with_diff_types, Test) {
    ASSERT_EQ(p.dims.size(), 2u);

    const int D0 = (int)p.dims[0];

    ASSERT_TRUE(p.dims[1] >= 0);
    const unsigned D1 = (unsigned)p.dims[1];

    impl::for_nd(0, 1, D0, D1, [&](int d0, unsigned d1) {
        ASSERT_TRUE(0 <= d0 && d0 < D0);
        ASSERT_TRUE(0u <= d1 && d1 < D1);
        const ptrdiff_t idx = (ptrdiff_t)d0 * (ptrdiff_t)D1 + (ptrdiff_t)d1;
        data[idx] = idx;
    });

    CheckID();
}
CPU_INSTANTIATE_TEST_SUITE_P(
        Case0, test_for_nd_with_diff_types, ::testing::Values(np_t {{4, 9}}));

class test_parallel_nd : public test_nd {
protected:
    void emit_parallel_nd() {
        switch ((int)p.dims.size()) {
            case 1:
                impl::parallel_nd(p.dims[0], [&](ptrdiff_t d0) {
                    ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                    data[d0] = d0;
                });
                break;
            case 2:
                impl::parallel_nd(
                        p.dims[0], p.dims[1], [&](ptrdiff_t d0, ptrdiff_t d1) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            const ptrdiff_t idx = d0 * p.dims[1] + d1;
                            data[idx] = idx;
                        });
                break;
            case 3:
                impl::parallel_nd(p.dims[0], p.dims[1], p.dims[2],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            const ptrdiff_t idx
                                    = (d0 * p.dims[1] + d1) * p.dims[2] + d2;
                            data[idx] = idx;
                        });
                break;
            case 4:
                impl::parallel_nd(p.dims[0], p.dims[1], p.dims[2], p.dims[3],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2,
                                ptrdiff_t d3) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            ASSERT_TRUE(0 <= d3 && d3 < p.dims[3]);
                            const ptrdiff_t idx
                                    = ((d0 * p.dims[1] + d1) * p.dims[2] + d2)
                                            * p.dims[3]
                                    + d3;
                            data[idx] = idx;
                        });
                break;
            case 5:
                impl::parallel_nd(p.dims[0], p.dims[1], p.dims[2], p.dims[3],
                        p.dims[4],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2,
                                ptrdiff_t d3, ptrdiff_t d4) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            ASSERT_TRUE(0 <= d3 && d3 < p.dims[3]);
                            ASSERT_TRUE(0 <= d4 && d4 < p.dims[4]);
                            const ptrdiff_t idx
                                    = (((d0 * p.dims[1] + d1) * p.dims[2] + d2)
                                                      * p.dims[3]
                                              + d3)
                                            * p.dims[4]
                                    + d4;
                            data[idx] = idx;
                        });
                break;
            case 6:
                impl::parallel_nd(p.dims[0], p.dims[1], p.dims[2], p.dims[3],
                        p.dims[4], p.dims[5],
                        [&](ptrdiff_t d0, ptrdiff_t d1, ptrdiff_t d2,
                                ptrdiff_t d3, ptrdiff_t d4, ptrdiff_t d5) {
                            ASSERT_TRUE(0 <= d0 && d0 < p.dims[0]);
                            ASSERT_TRUE(0 <= d1 && d1 < p.dims[1]);
                            ASSERT_TRUE(0 <= d2 && d2 < p.dims[2]);
                            ASSERT_TRUE(0 <= d3 && d3 < p.dims[3]);
                            ASSERT_TRUE(0 <= d4 && d4 < p.dims[4]);
                            ASSERT_TRUE(0 <= d5 && d5 < p.dims[5]);
                            const ptrdiff_t idx
                                    = ((((d0 * p.dims[1] + d1) * p.dims[2] + d2)
                                                       * p.dims[3]
                                               + d3) * p.dims[4]
                                              + d4)
                                            * p.dims[5]
                                    + d5;
                            data[idx] = idx;
                        });
                break;
            default: ASSERT_TRUE(false);
        }
    }
};

TEST_P(test_parallel_nd, Test) {
    emit_parallel_nd();
    CheckID();
}

CPU_INSTANTIATE_TEST_SUITE_P(Case, test_parallel_nd,
        ::testing::Values(np_t {{0}}, np_t {{1}}, np_t {{100}}, np_t {{0, 0}},
                np_t {{1, 2}}, np_t {{10, 10}}, np_t {{0, 1, 0}},
                np_t {{1, 2, 1}}, np_t {{4, 4, 10}}, np_t {{0, 3, 0, 1}},
                np_t {{1, 1, 2, 1}}, np_t {{4, 4, 5, 2}},
                np_t {{3, 0, 3, 0, 1}}, np_t {{2, 1, 1, 2, 1}},
                np_t {{4, 1, 4, 5, 2}}, np_t {{4, 3, 0, 3, 0, 1}},
                np_t {{2, 1, 3, 1, 2, 1}}, np_t {{4, 1, 4, 3, 2, 2}}));

} // namespace dnnl
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
