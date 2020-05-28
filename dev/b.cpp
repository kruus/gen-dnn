
#include <cstdint>
#include <iostream>
#include "assert.h"
using namespace std;



int main(int,char**){
    if(1){ // test operator/ for fastdiv in src/common/ve/memory_desc_wrapper_opt.hpp
        struct Magic { uint64_t mul; uint32_t add; uint32_t shr; };

        Magic m{1,2,3};
        uint64_t const mul = m.mul;
        uint64_t const xxx = *(uint64_t*)(&m.add);
        uint64_t add = (uint64_t)(uint32_t)xxx;
        uint64_t shr = xxx >> 32;
        assert( mul == 1 );
        assert( add == 2 );
        assert( shr == 3 );
    }
    cout<<"\nGoodbye! all OK!"<<endl;
    return 0;
}
// vim: et ts=4 sw=4 cindent cino+=+2s,l0,\:4,N-s
