/*******************************************************************************
* Copyright 2017 Intel Corporation, NEC Laboratories America LLC
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
#ifndef CONV_TEST_HPP
#define CONV_TEST_HPP
#include "conv.hpp"

namespace conv {
struct test_data_t; // fwd decl
}

struct test_stats {
    test_stats() : td(nullptr) { reset_all(); }
    void reset_all();
    void begin_impls();
    void update_impl(const conv::prb_t *p, res_t *r, int status,
                     benchdnn_timer_t const& tt, int imp);
    bool end_impls();           ///< return false if any impls were not PASSED.
    void prt();
    ~test_stats();
private:
    conv::test_data_t *td;
};

namespace conv {

extern conv_impls_t *conv_impls;

/** Which is the "first" test impl in loop-over-impls? */
size_t constexpr imp0 = 0U; // or 1 to skip the mkl-dnn original
static_assert( imp0 < get_nref_impls(), "Illegal imp0 start impl (imp0=0 should be safe)" );

}//conv::
#endif //CONV_TEST_HPP
