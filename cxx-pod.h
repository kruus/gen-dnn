#ifndef CXX_POD_H
#define CXX_POD_H
#ifdef __cplusplus
extern "C" {
#endif
	struct AH {
		int a;
		int b;
		int c;
		int d;
		int e;
		int f;
		int g;
		int h;
	};

    struct B { int b[128]; };

    struct C { int c[128]; };

#ifdef __cplusplus
}//"C"
#endif

// various C++ functions
AH zero_ah();
int ahfill1(int n, AH* ah);
int ahfill1z(int n, AH* ah);
int ahfill2(int n, AH* ah);
int sumah(AH const* ah);

namespace test {
int test1();
int test2();
int test3();
int test4();
int test5();
int test6();
}//test::

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // CXX_POD_H
