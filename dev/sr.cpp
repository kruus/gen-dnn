
#include <iostream>
#include <iomanip>
#include <cstdint>
#include <array>

#include "src/common/math_utils.hpp"

using namespace dnnl::impl::math;
using namespace std;

inline long double srelu_fwd_gold(long double const s) {
    return log1pl(expl(s));
}
inline long double srelu_bwd_gold(long double const s) {
    long double one = 1.0;
    return one / (one + ::expl(-s));
}

int main(int,char**){
    int constexpr w=12;
#define W ' '<<setw(w)
#define X setw(4)
    // actually nc++ doesn't use vector exp when the exp is "inside" an expression,
    // and it does not vectorize calls to srelu fwd/bwd
    if(1){
        cout<<"\nsoft_relu fwd log(1+exp(x))\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                <<endl;
        float md=-FLT_MAX;
        for(int i=-90; i<91; ++i){
            long double g = srelu_fwd_gold(i);
            float f = soft_relu_fwd((float)i);
            float d = (float)(f-g);
            float r = (f-g)/g;
            cout<<X<<i
                    <<' '<<W<<g
                    <<' '<<W<<f
                    <<' '<<W<<d
                    <<' '<<W<<r
                    <<endl;
            if(abs(d) > md) md = abs(d);
        }
        cout<<" max |diff| "<<md<<endl;
    }
    if(1){
        cout<<"\nsoft_relu fwd log(1+exp(x)) (vec)\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                <<endl;
        //std::array<long double,200> g; // operator[] did not vetorize?
        //std::array<float,200> f;
        //std::array<float,200> d;
        //std::array<float,200> r;
        long double g[200];
        float f[200];
        float d[200];
        float r[200];
        float md=-FLT_MAX;
        for(int i=-90; i<91; ++i)
            g[90+i] = srelu_fwd_gold(i);
        for(int i=-90; i<91; ++i){
            f[90+i] = soft_relu_fwd((float)i);
            d[90+i] = (float)(f[90+i]-g[90+i]);
            r[90+i] = (f[90+i]-g[90+i])/g[90+i];
        }
        for(int i=-90; i<91; ++i){
            cout<<X<<i
                    <<' '<<W<<g[90+i]
                    <<' '<<W<<f[90+i]
                    <<' '<<W<<d[90+i]
                    <<' '<<W<<r[90+i]
                    <<endl;
            if(abs(d[90+i]) > md) md = abs(d[90+i]);
        }
        cout<<" max |diff| "<<md<<endl;
    }
    if(1){
        cout<<"\nsoft_relu bwd 1/(1+exp(-x))\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                <<endl;
        float md=-FLT_MAX;
        for(int i=-90; i<91; ++i){
            long double g = srelu_bwd_gold(i);
            float f = soft_relu_bwd((float)1.0f,(float)i);
            float d = (float)(f-g);
            float r = (f-g)/g;
            cout<<X<<i
                    <<' '<<W<<g
                    <<' '<<W<<f
                    <<' '<<W<<d
                    <<' '<<W<<r
                    <<endl;
            if(abs(d) > md) md = abs(d);
        }
        cout<<" max |diff| "<<md<<endl;
    }
    if(1){
        long double g[200];
        float f[200];
        float d[200];
        float r[200];
        float e[200]; // exp(x)
        float md=-FLT_MAX;
        cout<<"\nsoft_relu bwd 1/(1+exp(-x))\n"
                <<X<<"x"
                <<W<<"gold"
                <<W<<"math_utils"
                <<W<<"diff"
                <<W<<"rdiff"
                <<W<<"foo"
                <<endl;
        for(int i=-90; i<91; ++i)
            g[90+i] = srelu_bwd_gold(i);
        for(int i=-90; i<91; ++i){
            f[90+i] = soft_relu_bwd((float)1.0f,(float)i);
        }
        for(int i=-90; i<91; ++i){
            d[90+i] = (float)(f[90+i]-g[90+i]);
            r[90+i] = (f[90+i]-g[90+i])/g[90+i];
            e[90+i] = expf(i);
        }
        for(int i=-90; i<91; ++i){
            cout<<X<<i
                    <<' '<<W<<g[90+i]
                    <<' '<<W<<f[90+i]
                    <<' '<<W<<d[90+i]
                    <<' '<<W<<r[90+i]
                    <<' '<<W<<e[90+i]
                    <<endl;
            if(abs(d[90+i]) > md) md = abs(d[90+i]);
        }
        cout<<" max |diff| "<<md<<endl;
    }

    cout<<"\nGoodbye"<<endl;
    return 0;
}
// vim: et ts=4 sw=4 nopaste cindent cino=+2s,^=l0,\:0,N-s
