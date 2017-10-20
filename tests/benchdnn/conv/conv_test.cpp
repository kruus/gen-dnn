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

#include "conv_test_data.hpp"

#define TESTN get_nref_impls()

using namespace conv;

static int const vdbg=99; // threshold verbose level for this file

test_stats::~test_stats() {
    print(vdbg,"%s","~test_stats()");
    if(td!=nullptr) delete td;
}

void test_stats::reset_all(){
    print(vdbg,"%s","+test_stats::reset_all");
    if( td == nullptr ){
        td = new test_data_t;
    }
    td->loops = 0U;
    for(unsigned i=imp0; i<TESTN; ++i){
        td->ms[i] = 0.0;
        td->ms_tot[i] = 0.0;
        for(unsigned j=imp0; j<TESTN; ++j){
            td->wins[i*TESTN+j] = 0U;
        }
    }
    // check... this->prt();
}
void test_stats::begin_impls(){
    for(unsigned i=0; i<TESTN; ++i){
        td->ms[i] = 0.0;
    }
}
void test_stats::update_impl(const prb_t *p, res_t *r, int status,
        benchdnn_timer_t const& tt, int imp)
{
    char pstr[max_prb_len];
    prb2str(p, pstr);
    print(0, "TEST #%-4lu time %-10.3f ms %s  %s %s\n",
          (unsigned long)imp,
          1e-3*(long)(1e3*tt.total_ms()+0.5),
          (status==OK? "CORRECT": "INCORRECT"),
          dir2str(p->dir),
          pstr);
    td->ms[imp] = tt.total_ms();
    if (r->state==UNTESTED) r->state = PASSED;
    if (status != OK) { ++benchdnn_stat.test_fail; r->state = FAILED; }
}
void test_stats::end_impls(){
    ++td->loops;
    for(unsigned i=imp0; i<TESTN; ++i){
        td->ms_tot[i] += td->ms[i];             // total ms per impl
        for(unsigned j=imp0; j<TESTN; ++j){
            if (td->ms[i] < td->ms[j]){
                ++td->wins[i*TESTN+j];          // impl vs impl dominance
            }else if (td->ms[i] > td->ms[j]) {
                --td->wins[i*TESTN+j];
            }
        }
    }
}
void test_stats::prt(){
    RT_ASSERT( td != nullptr );
    print(vdbg, "TESTN=%d get_nref_impls=%lu sizeof(wins)=%lu",
          (int)TESTN, (long unsigned)get_nref_impls(), (long unsigned)sizeof(td->wins));
    print(vdbg, "%c", '\n');
    for(unsigned i=imp0; i<TESTN; ++i){
        int wins=0;
        for(unsigned j=0; j<i; ++j){
            wins += td->wins[i*TESTN+j];
        }
        printf("T loops: %-3u impl:%u  speedup: %-6.3fx  wins: %-4d"
               "  tot_ms: %-8.3f  avg_ms: %.3f  avg speedup: %.3f x\n",
                (unsigned)td->loops, i, td->ms[imp0] / td->ms[i], wins,
                td->ms_tot[i], td->ms_tot[i] / td->loops,
                td->ms_tot[imp0] / td->ms_tot[i]);
    }
}

