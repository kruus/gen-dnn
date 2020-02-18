
#include "cxx-pod.h"

AH zero_ah(){
	auto ret = AH();
	return ret;
}

int ahfill1(int n, AH* ah){
    auto x = AH();
    x.a = n;
    x.b = n*x.a + 3;
    x.c = n*(x.a+x.b);
    x.d = x.a * x.b;
    x.e = x.c % x.a;
    x.f = x.e - x.d;
    x.g = 2*x.a;
    x.h = 3*x.f;
    if(n > 0){
        *ah = x;
    }else if(n<0) {
        *ah = zero_ah();
    }
    return ah->a + ah->b + ah->c + ah->d + ah->e + ah->f + ah->g + ah->h;
}
int ahfill1z(int n, AH* ah){
    auto x = AH({0});
    x.a = n;
    x.b = n*x.a + 3;
    x.c = n*(x.a+x.b);
    x.d = x.a * x.b;
    x.e = x.c % x.a;
    x.f = x.e - x.d;
    x.g = 2*x.a;
    x.h = 3*x.f;
    if(n > 0){
        *ah = x;
    }else if(n < 0){
        *ah = zero_ah();
    }
    return ah->a + ah->b + ah->c + ah->d + ah->e + ah->f + ah->g + ah->h;
}
int ahfill2(int n, AH* ah){
    auto x = AH({0});
    x.a = n;
    x.b = n;
    x.c = n;
    x.d = n;
    x.e = 2*n;
    x.f = 2*n;
    x.g = 2*n;
    x.h = 3*n;
    if(n > 0){
        *ah = x;
    }else if( n < 0){
        *ah = zero_ah();
    }
    return ah->a + ah->b + ah->c + ah->d + ah->e + ah->f + ah->g + ah->h;
}
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
