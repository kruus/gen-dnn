#include "cxx-pod.h"
#include <assert.h>

#include <iostream>
using namespace std;

int sumah( AH const*ah ){
    return ah->a + ah->b + ah->c + ah->d + ah->e + ah->f + ah->g + ah->h;
}

int main(int,char**){
    using namespace test;

    test1();
    int a = test2();
    int b = test2();
    assert(a==b);
    AH z=zero_ah(); assert(sumah(&z) == 0);
    int c = test3();
    assert(c!=b);
    int d = test2();
    assert( d == a );
    z=zero_ah(); assert(sumah(&z) == 0);
    int e = test3();
    assert( e != d );
    auto f = zero_ah();
    assert( sumah(&f) == 0 );
    int g = ahfill1(-1,&f); // zeros
    assert( sumah(&f) == 0 );
    assert(g == 0);
    {
        AH z;
        ahfill1(2,&z);
        assert( sumah(&z) != a );
    }
    {
        AH z;
        ahfill1(22,&z);
        assert( sumah(&z) == a );
    }
    int h = test4();
    assert( h == a );
    int status = test5();
    cout<<"main: test5 "<<(status?"OK":"ERROR")<<endl;
    status = test6();
    cout<<"main: test6 "<<(status?"OK":"ERROR")<<endl;

    cout<<"\nGoodbye"<<endl;
}
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
