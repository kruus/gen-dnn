#include "cxx-pod.h"
#include "cxx-pod.hpp"
#include <assert.h>
#include <iostream>
using namespace std;

namespace test {
int test1(){
    auto z = zero_ah();
    int sum = sumah(&z);
    cout<<"test1:sum="<<sum<<endl; cout.flush();
    return sum;
}
int test2(){
    AH z;
    ahfill1z(22,&z); // this one uses AH({0}) to explicitly zero
    int sum = sumah(&z);
    cout<<"test2:sum="<<sum<<endl; cout.flush();
    return sum;
}
int test3(){
    AH z;
    ahfill2(1,&z);
    int sum = sumah(&z);
    cout<<"test3:sum="<<sum<<endl; cout.flush();
    return sumah(&z);
}
int test4(){
    AH z;
    ahfill1(22,&z); // uses AH() constructor
    int sum = sumah(&z);
    cout<<"test4:sum="<<sum<<endl; cout.flush();
    return sum;
}
int test5(){
    using namespace cxxpod;
    Big big;
    int status = big.test();
    cout<<"test 5 status="<<status<<endl;
    return status;
}
int test6(){
    using namespace cxxpod;
    cout<<" test6 begins by default constructing a Big"<<endl;
    Big big;
    int status = big.test();
    cout<<"test 6 status="<<status<<endl;
    assert( status == true  && "default-constructed Big must be all-zero");
    cout<<" writing to big.ah..."<<endl;
    int sum = ahfill1(2,&big.ah);
    cout<<"            big.ah sum is now "<<sum<<" vals "
            <<big.ah.a<<", "
            <<big.ah.b<<", "
            <<big.ah.c<<", "
            <<big.ah.d<<", "
            <<big.ah.e<<", "
            <<big.ah.f<<", "
            <<big.ah.g<<", "
            <<endl;
    status = big.test();
    cout<<"test 6 status="<<status<<" (expected big.ah bad)"<<endl;
    assert( status == false );
    cout<<" copying AHxx() into big.ah..."<<endl;
    big.ah = AHxx();
    status = big.test();
    cout<<"test 6 status="<<status<<endl;
    cout<<" copying AHxx{} into big.ah..."<<endl;
    big.ah = AHxx{};
    status = big.test();
    cout<<"test 6 FINAL status="<<status<<endl;
    return status;
}
}//test::
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
