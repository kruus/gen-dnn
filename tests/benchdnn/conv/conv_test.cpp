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
    if(td!=nullptr) {
        if( td->loops > 0 ){
            printf("TEST final stats:\n");
            this->prt();
        }
        delete td;
        td = nullptr;
    }
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
    td->impls_ok = true;
    // check... this->prt();
}
void test_stats::begin_impls(){
    for(unsigned i=0; i<TESTN; ++i){
        td->ms[i] = 0.0;
    }
    td->impls_ok = true;  // remains true iff all test comparisons pass
    //printf(" +impls_ok=%d ",td->impls_ok);
}
void test_stats::update_impl(const prb_t *p, res_t *r, int status,
        benchdnn_timer_t const& tt, int imp)
{
    char pstr[max_prb_len];
    prb2str(p, pstr);
    double ms_tot = tt.total_ms();
    double ms_avg = ms_tot / tt.times();
    double ops= tt.times() * p->ops;

    double ms = 1e-3*(long)(1e3*ms_avg+0.5);
    char bms[15]; int lms=15; int oms;
    {
      oms = snprintf(&bms[0], lms, "%.3f ms", ms);
      if( oms > 10 ) oms = snprintf(&bms[0], lms, "%.0f s", ms*1e-3);
    }

    char const* impname = get_ref_impls()[imp].name;
    const int ll2 = 28; char b2[ll2];
    {
      int l2=ll2;
      const int o2 = snprintf(&b2[0], l2, "Test%d %s ", imp, impname);
      snprintf(&b2[o2], ll2-o2, "%s", &bms[0]);
      for(int i=o2; i<ll2-oms-1; ++i) b2[i] = ' ';
      for(int i=0; i<oms; ++i) b2[ll2-oms+i-1] = bms[i];
      b2[ll2-1]='\0';
    }

    double mflops = ops*1.e-3/ms_tot; // ops*1.e-6 / (ms_tot * 1.e-3)
    print(0, "%s %s  %g ops %.3f MFlops %s %s\n",
          &b2[0],
          (status==OK? "CORRECT": "INCORRECT"),
          ops, mflops,
          dir2str(p->dir),
          pstr);
    td->ms[imp] = ms_tot;
    td->ops = p->ops;
    if (r->state==UNTESTED) r->state = PASSED;
    if (r->state!=PASSED) { td->impls_ok = false; /*printf(" !impls_ok ");*/ }
    //else printf(" ??impls_ok=%d ",(int)(td->impls_ok));
}
bool test_stats::end_impls(){
    ++td->loops;
    td->ops_tot += td->ops;
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
    return td->impls_ok;
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
        char const* impname = get_ref_impls()[i].name;
        printf("T:%-2u %-6s loops: %-3u speedup: %-6.3fx  wins: %-4d"
               "  tot_ms: %-8.3f  avg_ms: %.3f  avg speedup: %.3f x %.1f Mflops\n",
                i, impname, (unsigned)td->loops, td->ms[imp0] / td->ms[i],
                wins, td->ms_tot[i], td->ms_tot[i] / td->loops,
                td->ms_tot[imp0] / td->ms_tot[i],
                td->ops_tot *1.e-3 / td->ms_tot[i]);
    }
}

// vim: et ts=4 sw=4 cindent nopaste ai cino=^=l0,\:0,N-s
