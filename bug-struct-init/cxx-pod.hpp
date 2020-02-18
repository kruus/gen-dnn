#ifndef CXX_POD_HPP
#define CXX_POD_HPP
#include "cxx-pod.h"

#include <cstddef>  // size_t
#include <iostream>
#include <iomanip>
#define SHOW(STUFF) do{cout<<right<<setw(30)<<#STUFF<<left<<" "<<STUFF<<endl;}while(0)

extern std::ostream no_out;

inline std::ostream& check(bool cond, char const* str, char const* file, size_t line){
    if(cond){
        return no_out;
    }else{
        std::cout<<"\n"<<file<<":"<<line<<" failed check "<<str<<" ";
        return std::cout;
    }
}
#define EXPAND(...) __VA_ARGS__
#define CHECK(...) check((EXPAND(__VA_ARGS__)),#__VA_ARGS__,__FILE__,__LINE__)

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
    //cout<<" nonzerobytes(sizeof(T)="<<sizeof(T)<<")="<<nz;
    return nz==0;
}

inline size_t nz_bytes(char const* const p, size_t psz){
    size_t nz = 0U;
    for(size_t i=0; i<psz; ++i){
        if( p[i] != '\0' ) ++nz;
    }
    return nz;
}

template<typename T>
inline size_t nz_bytes(T const* const t){
    char const* const p = reinterpret_cast<char const*>(t);
    size_t const psz = sizeof(T);
    return nz_bytes(p, psz);
};

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
    int d[10]; // also uninitialized
};
}//cxxpod::

#endif // CXX_POD_HPP
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
