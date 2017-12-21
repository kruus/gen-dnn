// ivdep produce same code for all these simple loops :(
// try it out with GCC target instead...
void ignore_vec_dep0 (int *a, int k, int c, int m)
{
#pragma GCC ivdep
    for (int i = 0; i < m; i++)
        a[i] = a[i + k] * c;
}

//#pragma GCC target ("no-mmx,no-sse,no-sse2")
_Pragma("GCC target (\"no-mmx,no-sse,no-sse2\")")
void ignore_vec_dep0_plain (int *a, int k, int c, int m)
{
#pragma GCC ivdep
    for (int i = 0; i < m; i++)
        a[i] = a[i + k] * c;
}
_Pragma("GCC target (\"arch=core2\")")  // Note: this may not actually be runnable on your CPU

#define IVDEP1() _Pragma("GCC ivdep")
void ignore_vec_dep1 (int *a, int k, int c, int m)
{
    IVDEP1()
    for (int i = 0; i < m; i++)
        a[i] = a[i + k] * c;
}

#define IVDEP2()
void ignore_vec_dep2 (int *a, int k, int c, int m)
{
    IVDEP2()
    for (int i = 0; i < m; i++)
        a[i] = a[i + k] * c;
}

#if 1 // Produce SLOW version
//#define IVDEPx() _Pragma("GCC ivdep")
#define FAST() _Pragma("GCC target (\"arch=haswell\")")
#define SLOW() _Pragma("GCC target (\"no-mmx,no-sse,no-sse2\")")
#else
//#define IVDEPx()
#define FAST()
#define SLOW()
#endif
SLOW()
void ignore_vec_depx (int *a, int k, int c, int m)
{
    //IVDEPx()
    for (int i = 0; i < m; i++)
        a[i] = a[i + k] * c;
}
FAST()
#undef FAST
#undef SLOW

#if 0 // Produce FAST version
//#define IVDEPy() _Pragma("GCC ivdep")
#define FAST() _Pragma("GCC target (\"arch=core2\")")
#define SLOW() _Pragma("GCC target (\"no-mmx,no-sse,no-sse2\")")
#else
//#define IVDEPy()
#define FAST()
#define SLOW()
#endif
SLOW()
void ignore_vec_depy (int *a, int k, int c, int m)
{
    //IVDEPy()
    for (int i = 0; i < m; i++)
        a[i] = a[i + k] * c;
}
FAST()
#undef FAST
#undef SLOW

