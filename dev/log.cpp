
#include <iostream>
#include <iomanip>
#include <cstdint>
#include <array>
#include <limits>

#include "src/common/math_utils.hpp"

using namespace dnnl::impl::math;
using namespace std;

inline long double log_fwd_gold(long double const s) {
    return logl(s);
}
inline long double log_bwd_gold(long double const s) {
    return 1.0 / s;
}

using namespace std;
#define NLF numeric_limits<float>

float f200(int i){
    float ret;
    if(i<0) i=0;
    if(i>=200) i=199;
    if(i<10){
        switch(i) {
        case(0): ret = NLF::min(); break;
        case(1): ret = NLF::lowest(); break;
        case(2): ret = NLF::max(); break;
        case(3): ret = NLF::epsilon(); break;
        case(4): ret = NLF::infinity(); break;
        case(5): ret = -NLF::infinity(); break;
        case(6): ret = NLF::quiet_NaN(); break;
        case(7): ret = NLF::signaling_NaN(); break;
        case(8): ret = NLF::denorm_min(); break;
        case(9): ret = 0; break;
        }
    }else if (i<20){
        ret = f200(i-10)+1.0f;
    }else if (i<30){
        ret = f200(i-20)+1.0f;
    }else if (i<40){
        ret = f200(i-30)*2.0f;
    }else{
        ret = ::expf( -2*(i-40-100) );
    }
    return ret;
}


int main(int,char**){
    int constexpr w=12;
#define W ' '<<setw(w)
#define X setw(w)
    // actually nc++ doesn't use vector exp when the exp is "inside" an expression,
    // and it does not vectorize calls to log fwd/bwd
    float x[200];
    for (int i=0; i<200; ++i){
        x[i] = f200(i);
        cout<<" i "<<i<<" x[i] "<<x[i]<<"\n";
    }
    if(1){
        cout<<"\nlog fwd log(x[i])\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                <<"\n";
        float md=-FLT_MAX;
        for (int i=0; i<200; ++i){
            long double g = log_fwd_gold(x[i]);
            float f = log_fwd(x[i]);
            float d = (float)(f-g);
            float r = (f-g)/g;
            cout<<X<<x[i]
                    <<' '<<W<<g
                    <<' '<<W<<f
                    <<' '<<W<<d
                    <<' '<<W<<r
                    <<"\n";
            if(abs(d) > md) md = abs(d);
        }
        cout<<" max |diff| "<<md<<"\n";
    }
    if(1){
        cout<<"\nlog fwd log(x[i]) (vec)\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                <<"\n";
        //std::array<long double,200> g; // operator[] did not vetorize?
        //std::array<float,200> f;
        //std::array<float,200> d;
        //std::array<float,200> r;
        long double g[200];
        float f[200];
        float d[200];
        float r[200];
        float md=-FLT_MAX;
        for(int i=0; i<200; ++i)
            g[i] = log_fwd_gold(x[i]);
        for (int i=0; i<200; ++i){
            f[i] = log_fwd(x[i]);
            d[i] = (float)(f[i]-g[i]);
            r[i] = (f[i]-g[i])/g[i];
        }
        for (int i=0; i<200; ++i){
            cout<<X<<x[i]
                    <<' '<<W<<g[i]
                    <<' '<<W<<f[i]
                    <<' '<<W<<d[i]
                    <<' '<<W<<r[i]
                    <<"\n";
            if(abs(d[i]) > md) md = abs(d[i]);
        }
        cout<<" max |diff| "<<md<<"\n";
    }
    if(1){
        cout<<"\nlog bwd 1/x)\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                <<"\n";
        float md=-FLT_MAX;
        for (int i=0; i<200; ++i){
            long double g = log_bwd_gold(x[i]);
            float f = log_bwd((float)1.0f,x[i]);
            float d = (float)(f-g);
            float r = (f-g)/g;
            cout<<X<<x[i]
                    <<' '<<W<<g
                    <<' '<<W<<f
                    <<' '<<W<<d
                    <<' '<<W<<r
                    <<"\n";
            if(abs(d) > md) md = abs(d);
        }
        cout<<" max |diff| "<<md<<"\n";
    }
    if(1){
        long double g[200];
        float f[200];
        float d[200];
        float r[200];
        //float e[200]; // exp(x[i])
        float md=-FLT_MAX;
        cout<<"\nlog bwd 1/x) VRCP?\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                //<<W<<"foo"
                <<"\n";
        for(int i=0; i<200; ++i)
            g[i] = log_bwd_gold(x[i]);
        for (int i=0; i<200; ++i){
            f[i] = log_bwd((float)1.0f,x[i]);
        }
        for (int i=0; i<200; ++i){
            d[i] = (float)(f[i]-g[i]);
            r[i] = (f[i]-g[i])/g[i];
            //e[i] = expf(x[i]);
        }
        for (int i=0; i<200; ++i){
            cout<<X<<x[i]
                    <<' '<<W<<g[i]
                    <<' '<<W<<f[i]
                    <<' '<<W<<d[i]
                    <<' '<<W<<r[i]
                    //<<' '<<W<<e[i]
                    <<"\n";
            if(abs(d[i]) > md) md = abs(d[i]);
        }
        cout<<" max |diff| "<<md<<"\n";
    }

    cout<<"\nGoodbye"<<"\n";
    return 0;
}
// vim: et ts=4 sw=4 nopaste cindent cino=+2s,^=l0,\:0,N-s
