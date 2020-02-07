#include "cxx-pod.hpp"
#include <iostream>
using namespace std;
using namespace cxxpod;

namespace cxxpod {

char const* Big::name="Big"; // static member

int Big::test() {
    bool ret=true;
    if( !is_zero<AHxx>(&this->ah) ){
        cout<<" error: Big::ah bad!"<<endl;
        ret=false;
    }
    if( !is_zero<Bxx>(&this->b) ){
        cout<<" error: Big::b bad!"<<endl;
        ret=false;
    }
    if( !is_zero<Cxx>(this->pc) ){
        cout<<" error: Big::pc bad!"<<endl;
        ret=false;
    }
    return ret;
}
} // cxxpod::
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
