#ifndef CXX_POD_HPP
#define CXX_POD_HPP
#include "cxx-pod.h"

#include <cstddef>  // size_t
#include <iostream>

typedef AH AHxx;
typedef B Bxx;
typedef C Cxx;

template<typename T> inline
bool is_zero(T const* const t){
    using namespace std;
    char const* const p = reinterpret_cast<char const*>(t);
    size_t const psz = sizeof(T);
    size_t nz=0U;
    for(size_t i=0; i<psz; ++i){
        if( p[i] != '\0' ) ++nz;
    }
    cout<<" nonzerobytes(sizeof(T)="<<sizeof(T)<<")="<<nz;
    return nz>0;
}

namespace cxxpod {
struct Big {
    static char const* name; //="Big";
    Big()
            : ah(AHxx())
    {
        auto tmpc = Cxx();
        if(this->name[0] != 'B'){ // never
            tmpc.c[7] = 1234567;
        }
        pc = new Cxx(tmpc);
    }
    ~Big()
    {
        delete pc;
    }
    int test();
    AHxx ah;
    Bxx b;
    Cxx *pc;
};
}//cxxpod::

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // CXX_POD_HPP
