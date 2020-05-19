#ifndef TEST_INT8_A_CPP
#define TEST_INT8_A_CPP
//#include "stdlib.h" // --> sys/types.h with strange int8_t typedef (neither signed nor unsigned char)
//#include "stdint.h"
#include "stddef.h"
template<typename T>
int func(T const t);

#ifdef MAIN
#include <iostream>
using namespace std;
int main(int,char**){
    cout<<"func(unsigned char{0}) = "<<func((unsigned char)0)<<endl;
    cout<<"func(  signed char{0}) = "<<func((  signed char)0)<<endl;
    // on VE a library may defined unsigned char and signed char templates.
    // The common expectation is that int8_t be resolved to the signed char template
    // However,
    //   nc++ searches ONLY for the 'func<char>' version.
    // This is nonsense, since 'char' has no signed-ness,
    // whereas int8_t most definitely is a signed type.
    //
    // This leads to linking issues, where arithmetic functions definitely do not
    // wish to include a 'char' version of template functions !!!!!
    //
    // nc++ in sys/types.h defines a strange-looking int8_t which has the surprising
    // property of losing its signed-ness during templates
    //
    cout<<"func(       int8_t{0}) = "<<func((       int8_t)0)<<endl;
    //
    //  Error:
    //
    // nc++ -O3 -std=c++11 -Wall -g -DMAIN test_int8-a.cpp test_int8-b.o -o test_int8
    // /tmp/nccK3yaaa.o: In function `main':
    // /r/home/nlabhpg/kruus/vanilla-pull/test_int8-a.cpp:13: undefined reference to `int func<char>(char)'
    // make: *** [test_int8] Error 1
    //
    cout<<"\nGoodbye"<<endl;
}
#endif // MAIN
#endif // TEST_INT8_A_CPP
