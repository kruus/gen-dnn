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
#ifndef CONV_TEST_DATA_HPP
#define CONV_TEST_DATA_HPP
#include "conv_test.hpp"

namespace conv {

struct test_data_t {
    /** how many TEST (loops-over-impls)? */
    unsigned loops;

    /** for each loop-over-impls, record time taken */
    double ms[get_nref_impls()];

    /** running total time per test impl */
    double ms_tot[get_nref_impls()];

    /** wins[N x N] is a count matrix where wins[i,j] increments if
     * impl i was faster than impl j  (else decrements).
     * A impl i completely dominates impl j iff wins[i,j] == loops. */
    int wins[get_nref_impls()*get_nref_impls()];
};

}//conv::
#endif // CONV_TEST_DATA_HPP
