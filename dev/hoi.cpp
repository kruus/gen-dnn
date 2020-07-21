#include "cpu/ve/hoist.hpp"
#include <assert.h>
#include <iostream>
#include <vector>

using namespace std;

int main(int, char**){
    using dnnl::impl::cpu::hoist_ApiB;
    vector<int> low = {-100, -10, -5, -3, 0, 3, 5, 10, 100};
    vector<int> len = {0, 1, 3, 5, 10, 100};
    vector<int> aaa = {-4, 0, 4};
    vector<int> bbb = {1, 2, 4};
    vector<int> flow = {-8, 0, 8};
    vector<int> flen = {0, 4, 10, 20};
    vector<int> stride = {1};
    // If stride is not 1, then would need extra work to
    // rewrite original loop with stride 1 (and change linear fn)
    // (not a trivial fixup)
    for(auto str: stride) for (auto lo: low) for (auto sz: len) {
        int hi = lo + sz;
        for (auto flo: flow) for (auto fsz: flen) {
            int fhi = flo + fsz;
            for (auto a: aaa) for (auto b: bbb) {
                vector<int> gold;
                for(int i=lo; i<hi; i+=str) {
                    int const f = a + i*b; // linear fn of loop index
                    if (f >= flo && f < fhi){
                        gold.push_back(i);
                        assert( f >= flo && f < fhi );
                    }
                }
                vector<int> hoist;
                int sublo, subhi;
                int realhi = hi;
                hoist_ApiB(sublo,subhi, lo,realhi, a,b, flo,fhi);
                for(int i=sublo; i<subhi; i+=str) {
                    int const f = a + i*b; // linear fn of loop index
                    assert( f >= flo && f < fhi );
                    hoist.push_back(i);
                }
                int err = 0;
                if (gold.size() != hoist.size()) ++err;
                for(int j=0; j<gold.size(); ++j){
                    if (gold[j] != hoist[j]) ++err;
                }
                if (err) {
                    if (str != 1) {
                        cout<<"Note: stride!=1 should expect error"<<endl;
                    }
                    cout<<"Run: for(i="<<lo<<"; i<"<<hi<<"; i+="<<str<<")"
                        <<" with f="<<a<<"+i*"<<b<<" in ["<<flo<<","<<fhi<<")"
                        <<" --> for i in ["<<sublo<<","<<subhi<<")"<<endl;
                    cout<<"  gold={";
                    for(int j=0; j<gold.size(); ++j) cout<<" "<<gold[j];
                    cout<<" }"<<endl;
                    cout<<" hoist={";
                    for(int j=0; j<hoist.size(); ++j) cout<<" "<<hoist[j];
                    cout<<" }"<<endl;
                    exit(1);
                }
            }
        }
    }
    cout<<"\nGoodbye!"<<endl;
}
