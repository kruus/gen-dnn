
#include <iostream>
#include <iomanip>
#include <cstdint>
#include <array>
#include <limits>

#include "src/common/math_utils.hpp"

#define NOVEC_ _Pragma("__NEC novector")

using namespace dnnl::impl::math;
using namespace std;

inline long double sqrt_fwd_gold(long double const s) {
    return sqrtl(s);
}
inline long double sqrt_bwd_gold(long double const s) {
    return 0.5 / sqrtl(s);
}

// fast inv_sqrt, see https://cs.uwaterloo.ca/~m32rober/rsqrt.pdf
template <typename T, char iterations = 2> inline T inv_sqrt(T x) {
    static_assert(std::is_floating_point<T>::value, "T must be floating point");
    static_assert(iterations == 1 or iterations == 2, "itarations must equal 1 or 2");
    typedef typename std::conditional<sizeof(T) == 8, std::int64_t, std::int32_t>::type Tint;
    T y = x;
    T x2 = y * T{0.5};
    Tint i = *(Tint *)&y;
    i = (sizeof(T) == 8 ? 0x5fe6eb50c7b537a9 : 0x5f3759df) - (i >> 1);
    y = *(T *)&i;
    y = y * (T{1.5} - (x2 * y * y));
    if (iterations == 2)
        y = y * (T{1.5} - (x2 * y * y));
    return y;
}

using namespace std;
#define NLF numeric_limits<float>

float set_f200(int i){
    float ret;
    if(i<0) i=0;
    if(i>=200) i=199;
    if(i<10){
        switch(i) {
        case(0): ret = NLF::infinity(); break;
        case(1): ret = -NLF::infinity(); break;
        case(2): ret = NLF::denorm_min(); break;
        case(3): ret = 0; break;
        case(4): ret = NLF::quiet_NaN(); break;
        case(5): ret = NLF::signaling_NaN(); break;
        case(6): ret = NLF::lowest(); break;
        case(7): ret = NLF::min(); break;
        case(8): ret = NLF::max(); break;
        case(9): ret = NLF::epsilon(); break;
        }
    }else if (i<20){
        ret = set_f200(i-10)+1.0f;
    }else if (i<30){
        ret = set_f200(i-20)+1.0f;
    }else if (i<40){
        ret = set_f200(i-30)*2.0f;
    }else if (i<180){
        ret = ::expf( -2*(i-40-90) );
    }else{
        ret = -5 + 0.5 * (i-180);
    }
    return ret;
}

static int constexpr w=12;
#define W ' '<<setw(w)
#define X setw(w)
static void __attribute__((noinline))
    title(char const* msg){
        cout<<"\n"<<msg<<"\n"
                <<X<<"x"
                <<' '<<W<<"gold"
                <<' '<<W<<"math_utils"
                <<' '<<W<<"diff"
                <<' '<<W<<"rdiff"
                <<"\n";
    }
void __attribute__((noinline))
    out(float const x, long double const g, float const f, float & md ){
        float d = (float)(f-g);
        float r = (f-g)/g;
        cout<<X<<x
                <<' '<<W<<g
                <<' '<<W<<f
                <<' '<<W<<d
                <<' '<<W<<r
                <<"\n";
        if(abs(d) > md) md = abs(d);
    }

// to pass sized C-array by ref nicely:
using f200 = float[200];
using g200 = long double[200];

void __attribute__((noinline))
    out(f200 const& x, g200 const& g, f200 const& f){
        float md=-FLT_MAX;
        for(int i=0; i<200; ++i){
            float d = (f[i]-g[i]);
            float r = (f[i]-g[i])/g[i];
            cout<<X<<x[i]
                    <<' '<<W<<g[i]
                    <<' '<<W<<f[i]
                    <<' '<<W<<d
                    <<' '<<W<<r
                    <<"\n";
            if(abs(d) > md) md = abs(d);
        }
        cout<<" max |diff| "<<md<<"\n";
    }

static float x[200];
void __attribute__((noinline)) test1(){
    cout<<"\nsqrt fwd sqrt(x[i])\n" <<X<<"x" <<W<<"gold" <<W<<"math_utils" <<W<<"diff" <<W<<"rdiff" <<"\n";
    float md=-FLT_MAX;
    for (int i=0; i<200; ++i){
        long double g = sqrt_fwd_gold(x[i]);
        float f = sqrt_fwd(x[i]);
        out(x[i],g,f, md);
    }
    cout<<" max |diff| "<<md<<"\n";
}

void __attribute__((noinline)) test2(){
    cout<<"\nsqrt fwd sqrt(x[i]) (vec)\n" <<X<<"x" <<W<<"gold" <<W<<"math_utils" <<W<<"diff" <<W<<"rdiff" <<"\n";
    long double g[200];
    float f[200];
    for(int i=0; i<200; ++i)
        g[i] = sqrt_fwd_gold(x[i]);
    for (int i=0; i<200; ++i)
        f[i] = sqrt_fwd(x[i]);
        //f[i] = ::sqrtf(x[i]);
    out(x,g,f);
}
int main(int,char**){
    // actually nc++ doesn't use vector exp when the exp is "inside" an expression,
    // and it does not vectorize calls to sqrt fwd/bwd
    for (int i=0; i<200; ++i){
        x[i] = set_f200(i);
        cout<<" i "<<i<<" x[i] "<<x[i]<<"\n";
    }
#if 1
    test1();
    test2();
#endif
#if 1
    if(1){
        title("sqrt bwd 0.5/sqrt(x)");
        float md=-FLT_MAX;
        for (int i=0; i<200; ++i){
            long double g = sqrt_bwd_gold(x[i]);
            float f = sqrt_bwd((float)1.0f,x[i]);
            out(x[i],g,f, md);
        }
        cout<<" max |diff| "<<md<<"\n";
    }
    if(1){
        long double g[200];
        for(int i=0; i<200; ++i)
            g[i] = sqrt_bwd_gold(x[i]);
        title("sqrt bwd 0.5/sqrt(x)) VRSQRT?");
        float f[200];
        for (int i=0; i<200; ++i)
            // absolutely horrid:
            //    f[i] = sqrt_bwd(float{1.0},x[i]);
            // better:
            f[i] = float{1.0} * (1.0f / ::sqrtf(x[i]));
            // %s61 = 1056964608 = 0.5f 
            // %s62 = 1065353216 = 1.0f
            // (x) in %v63
            // --- vrsqrt.s %v62,%v63
            // (w) y = vrsqrt(x)
            // --- vfmul.s %v61,%v63,%v62
            // (a) y = x*w                  approx sqrt(x)
            // --- vfnmsb.s %v61,%s62,%v61,%v62 (%s62 is 1065353216 = 0.5f
            //                x   y    z    w   --> -y + z * w
            // (b) y = 1 - a*w              = 1 - x*w*w
            // --- vfmul.s %v61,%s61,%v61
            // (c) y = 0.5 * b              = 0.5 - 0.5*x*w*w
            // --- vfmad.s %v61,%v62,%v62,%v61
            // (d) y = w + c*w = w + 0.5*w + 0.5*x*w*w*w
            //          = 1.5*w - 0.5*x*w*w*w
            //          = (y/2) (3-x*y*y)  "official formula"
            // // summary
            // w = vrsqrt(x)
            // a = x*w
            // b = 1-a*w
            // c = 0.5b
            // d = w + c*w
            // // cf alt method (wikipedia)
            // y = vrsqrt(x)
            // a = x*y
            // h = 0.5*y
            // iter:
            // r = 0.5 - ah
            // x' = a + a*r   (close to sqrt(x))
            // h' = h + h*r   (close to 1/sqrt(x))
            // --- one less scalar const load, a,h can parallelize
            //
            // vfmul.s %[a], %[x], %[y]
            // vfmul.s %[h], %[half], %[y]
            // // iter:
            // vfnmsb.s %[r], %[half], %[a], %[h]
            // vfmad.s %[x], %[a], %[a], %[r]           # sqrt(x)
            // vfmad.s %[h], %[h], %[h], %[r]           # 1/sqrt(x)
            //
            // This way also gives path to x**(1.5) etc.
            // But should directly apply to get actual x**1.5 iteration formula!
            //
            // --- vstu %v61,4,%s60
            //
            //
        out(x,g,f);
    }
    if(1){
        long double g[200];
        for(int i=0; i<200; ++i)
            g[i] = sqrt_bwd_gold(x[i]);
        float f[200];
        title("sqrt bwd inv_sqrt as template");
        for (int i=0; i<200; ++i)
            f[i] = 0.5*inv_sqrt<float,2>(x[i]);
        out(x,g,f);
    }
#endif

    cout<<"\nGoodbye"<<"\n";
    return 0;
}
// vim: et ts=4 sw=4 nopaste cindent cino=+2s,^=l0,\:0,N-s
