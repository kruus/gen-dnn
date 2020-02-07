
#define FOO2(x,y) 2
#define FOO3(x,y,z) 3
#define GET_MACRO(_1,_2,_3,NAME,...) NAME
#define FOO(...) GET_MACRO(__VA_ARGS__, FOO3, FOO2)(__VA_ARGS__)

static int a=FOO(x,y);
static int b=FOO(x,y,z);

#define ENABLE_OPT_PRAGMAS
#include "include/dnnl_types.h"
#include "build/include/dnnl_config.h"
#include "include/dnnl_os.h"
int foo(int x){
        PRAGMA_OMP() for(int i=0; i<5; ++i) x += i >>=1;
        PRAGMA_OMP(schedule(static,2) for(int i=0; i<500; ++i) x += i >>=1;
        return x;
}
