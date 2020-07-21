#include "cpu/ve/hoist.hpp"
#include <assert.h>
#include <iostream>
#include <vector>

using namespace std;

// 2D hoist also passes a simple verification program.
int main(int, char**){
    using dnnl::impl::cpu::hoist_ApiB;
    vector<int> low = {-100, -10, -5, -3, 0, 3, 5, 10, 100};
    vector<int> len = {0, 1, 3, 5, 10, 30};
    vector<int> aaa = {-4, 0, 4};
    vector<int> bbb = {1, 2, 4};
    vector<int> flow = {-8, 0, 8};
    vector<int> flen = {0, 4, 10, 20};
    vector<int> blow = {-5, -1, 0, 1, 5};
    vector<int> blen = {0, 1, 5, 10};
    vector<int> baaa = {-2, -1, 0, 1, 2};
    vector<int> bbbb = {1, 2, 4};
    vector<int> bflow = {-8, 0, 8};
    vector<int> bflen = {0, 4, 10};
    vector<int> stride = {1};
    // If stride is not 1, then would need extra work to
    // rewrite original loop with stride 1 (and change linear fn)
    // (not a trivial fixup)
    for(auto str: stride) for (auto lo: low) for (auto sz: len) 
    for (auto flo: flow) for (auto fsz: flen) for (auto a: aaa)
    for (auto b: bbb)
    {
        int hi = lo + sz;
        int fhi = flo + fsz;
        for(auto bstr: stride) for (auto blo: low) for (auto bsz: len) 
        for (auto bflo: bflow) for (auto bfsz: bflen) for (auto ba: aaa)
        for (auto bb: bbb)
        {
            int bhi = blo + bsz;
            int bfhi = bflo + bfsz;
            vector<int> gold;
            for(int i=lo; i<hi; i+=str) {
                for(int j=blo; j<bhi; j+=str) {
                    int const f = a + i * b; // linear fn of loop index
                    int const bf = ba + j * bb;
                    if (f >= flo && f < fhi && bf >= bflo && bf < bfhi) {
                        gold.push_back(i);
                        gold.push_back(j);
                    }
                }
            }
            vector<int> hoist;
            int sublo, subhi;
            hoist_ApiB(sublo,subhi, lo,hi, a,b, flo,fhi);
            int bsublo, bsubhi;
            hoist_ApiB(bsublo,bsubhi, blo,bhi, ba,bb, bflo,bfhi);
            for(int i=sublo; i<subhi; i+=str) {
                for(int j=bsublo; j<bsubhi; j+=str) {
                    int const f = a + i * b; // linear fn of loop index
                    int const bf = ba + j * bb;
                    assert( f >= flo && f < fhi );
                    assert( bf >= bflo && bf < bfhi );
                    hoist.push_back(i);
                    hoist.push_back(j);
                }
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
    cout<<"\nGoodbye!"<<endl;
}
