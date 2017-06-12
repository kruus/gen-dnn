
#include <iostream>
#include <iomanip>
#include <string>
#include <map>
#include <cstddef>      // size_t
#include <cstdint>
#include <random.h>
using namespace std;

int main(int,char**){
    map<string,int> sz; // sizeof returns 'int'
#define SETSZ(TYPE) do{ sz[string(#TYPE)] = sizeof(TYPE); }while(0)
    SETSZ(bool); SETSZ(char); SETSZ(short); SETSZ(int); SETSZ(long); SETSZ(long long); SETSZ(float); SETSZ(double); SETSZ(long double);
    SETSZ(ptrdiff_t); SETSZ(size_t); 
    //SETSZ(ssize_t); // ptrdiff_t is typically OK for signed size_t
    if(!(sizeof(ptrdiff_t) == sizeof(size_t))){
       cout<<"OHOH: ptrdiff_t cannot be used as the signed counterpart of size_t"<<endl;
    }
    SETSZ(intptr_t); SETSZ(void*);
    cout<<"sizeof(basic types):"<<endl;
#define T(TYPE) #TYPE<<'|'
#define S(TYPE) setw(static_cast<int>(string(#TYPE).size()))<<sz[#TYPE]<<'|'
    // Note: setw takes an 'int', but size() returns unsigned size_t, so sxc++ warns about precision loss
    cout<<T(bool)<<T(char)<<T(short)<<T(int)<<T(long)<<T(long long)<<T(float)<<T(double)<<T(long double)<<T(ptrdiff_t)<<T(size_t)<<T(intptr_t)<<T(void*)<<endl;
    cout<<S(bool)<<S(char)<<S(short)<<S(int)<<S(long)<<S(long long)<<S(float)<<S(double)<<S(long double)<<S(ptrdiff_t)<<S(size_t)<<S(intptr_t)<<S(void*)<<endl;
    //
#define STDSZ(INT,N) SETSZ(INT##N##_t); SETSZ(INT##_least##N##_t); SETSZ(INT##_fast##N##_t);
    STDSZ(int,8); STDSZ(int,16); STDSZ(int,32); STDSZ(int,64);
#define O(INT,N) left<<setw(8)<<string(#INT #N "_t ")<<right<<sz[#INT #N "_t"]<<" [least,fast: "<<sz[#INT "_least" #N "_t"]<<","<<sz[#INT "_fast" #N "_t"]<<"]"
    cout<<O(int,8)<<endl;
    cout<<O(int,16)<<endl;
    cout<<O(int,32)<<endl;
    cout<<O(int,64)<<endl;
    // array sizes;
    {
        short arr[10];
        cout<<" sizeof(" "short" "[10]) is "<<sizeof(arr)<<endl; // 20 bytes, as expected, on SX
    }
    // signed conversion: sxc++ static_cast were added to avoid warnings
    int a=rand();
    unsigned b=a;
    size_t c=a;
    cout<<" rand int="<<a<<" unsigned="<<b<<" size_t="<<c<<endl;
    for(int i=0; i<1; ++i){
        int j=i+c;                      // sxc++ -size_t64 : "conversion may change the value"
        cout<<"int j=int+size_t: "<<j<<endl;
        int i=b;
        cout<<"int i=unsigned;   "<<i<<endl;
        size_t l=a+j;
        cout<<"size_t l=int+int;   "<<l<<endl;
        float f=13.13f;
        i=static_cast<int>(f); // sxc++ "conversion may change the value"
        cout<<" int i = float("<<f<<") : "<<i<<endl;
        uint8_t un8;
        un8 = static_cast<uint8_t>(f);
        cout<<" uint8_t un8 = float("<<f<<") : "<<un8<<endl;
        unsigned big=2333444555U;
        f=static_cast<unsigned>(big); //sxc++ "conversion may change the value"
        cout<<" float f = unsigned("<<big<<") : "<<f<<endl;
        uint16_t big16=55111U;
        f=big16; // OK -- no warning.
        cout<<" float f = uint16_t("<<big16<<") : "<<f<<endl;
    }
}



