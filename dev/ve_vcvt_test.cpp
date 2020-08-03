#include <cstdio>
#include <cstdint>
#include <cstdlib>

using namespace std;

void foo(int i) {
    printf("%d\n",i);
}
#if 0
// "parameter cannot be declared constexpr"
void foo(int constexpr i) {
    printf("%d\n",i+2);
}
#endif
#if 0
// redefinition
constexpr void foo(int const i) {
    printf("%d\n",i+2);
}
#endif
int main(int,char*){
    //char const* comment = "# hello";
    //asm(comment);  expected an asm string :(
    foo(0);
    int i[8] = {-2,-1,0,1,2,3,4,5};
    float f[8] = {-2,-1,0,1,2,3,4,5};
    int ii[8] = {0};
    float ff[8] = {0};
    int constexpr vl = 8;
    // converting i[] --> float ff[] (expect to match f[])
    // what's the correct v{ld|st}{u|l} setting for vcvt int32 --> float?
    asm("lvl %[vl]\n\t"
        "vldl           %v63, %[in_stride], %[int32_in]   # v63 <-- *(int32_t*)int32_in\n\t"
        "vcvt.s.w       %v62, %v63                        # int32_t --> float v62\n\t"
        "vstu           %v62, %[out_stride], %[out_float] # v62 --> *(float*)out_float\n\t"
        : "=m"( /*dummy output*/ *(float (*)[8]) &ff[0] )
        : "m"( /*dummy input*/ *(const int32_t (*)[vl]) &i[0])
        , [int32_in]"r"(&i[0])
        , [vl]"i"(vl)
        //, [byte_stride]"i"(1*sizeof(int32_t)) // only for tiny stride
        , [in_stride]"r"(1*sizeof(int32_t)) // in general
        , [out_stride]"r"(1*sizeof(float)) // in general
        , [out_float]"r"(&ff[0])
        : "%v63", "%v62"
       );
    if(1){
        int nerr=0;
        for(int v=0; v<vl; ++v){
            if (ff[v] != f[v]) {
                printf(" oops, vec float(%d) gave %f\n", i[v], ff[v]);
                ++nerr;
            }
        }
        if (nerr) {
            exit(1);
        }
    }
}

