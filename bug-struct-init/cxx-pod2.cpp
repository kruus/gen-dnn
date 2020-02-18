#include "cxx-pod.hpp"
#include <iostream>
using namespace std;
using namespace cxxpod;

namespace cxxpod {

char const* Big::name="Big"; // static member

int Big::test() {
    bool ret=true;              // true == no error
    SHOW(sizeof(AHxx));
    SHOW(sizeof(Bxx));
    SHOW(sizeof(Cxx));
    SHOW(sizeof(Big));
    if( !is_zero<AHxx>(&this->ah) ){
        cout<<" error: Big::ah not all zero!"<<endl;
        ret=false;
    }
    // We HAVE a constructor, and b and c are explicitly NOT intialized
    if( !is_zero<Bxx>(&this->b) ){
        cout<<" OK : Big::b is unset in supplied default constructor!"<<endl;
        //ret=false;
    }
    if( !is_zero<Cxx>(this->pc) ){
        cout<<" OK : Big::pc is unset in supplied default constructor!"<<endl;
        //ret=false;
    }
    if( nz_bytes((char const*)(&this->d[0]),sizeof(int)*16) > 0 ){
        cout<<" OK : Big::d[10] is unset in supplied default constructor!"<<endl;
        //ret=false;
    }
    return ret;
}
} // cxxpod::
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
