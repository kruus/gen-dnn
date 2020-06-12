#include <stdint.h>
#include <iostream>
#include <iomanip>
#include <vector>

using namespace std;
typedef uint64_t dim_t;

static dim_t constexpr stack_channels = 16384;

#ifndef MVL
#if defined(__ve)
#define MVL 256
#else
#define MVL 32
#endif
#endif

// Divide 'hi' up "somewhat loosely" around some target value
// (unlike vl suggestions, which MUST always partition <= MVL)
static inline dim_t stack_friendly_blksz(dim_t const hi){
#if 1
    dim_t ret = hi;
    if (hi > stack_channels) {
        ret = stack_channels;
        dim_t const nFull = hi/stack_channels;
        dim_t const rem   = hi%stack_channels;
        if (rem < stack_channels/4) {
            dim_t const nLoops = nFull + (rem!=0);
            ret = (hi+nLoops-1) / nLoops;
            //printf("+%d",(int)ret); // rough equipartition
            if (ret < stack_channels - MVL) {
                ret = (ret+MVL-1)/MVL*MVL;
                //printf("^%d",(int)ret); // round up
            }
        }
    }
#else // old code
    dim_t ret = hi;
    dim_t const nFull = hi/stack_channels;
    dim_t const rem   = hi%stack_channels;
    dim_t const nLoops = nFull + (rem!=0);
    if (hi > stack_channels)
    //if (hi > stack_channels && rem > stack_channels/2)
    //if (hi > stack_channels && rem > 128)
    {
        if (rem < stack_channels/4) {
            ret = (hi+nLoops-1) / nLoops;
            printf("+%d",(int)ret); // rough equipartition
            if (ret < stack_channels - 256) {
                printf("^%d",(int)ret); // rough equipartition
                ret = (ret+256-1)/256*256;
            }
        }else{
            ret = stack_channels;
        }
    }
    auto rem256 = ret % 256;
    if (hi > 256 && rem256 && rem256<32) { // low remainder?
        auto ret2 = (hi+nLoops) / (nLoops+1); // accept one more loop
        printf("-%d",(int)ret2);
        if( ret2%256 > rem256 ){
            printf("!");
            ret = ret2;
        }
    }
#endif
    if (ret > stack_channels) {
        dim_t const nFull = hi/stack_channels;
        dim_t const rem   = hi%stack_channels;
        dim_t const nLoops = nFull + (rem!=0);
        cout<<" ohoh: ret="<<ret<<" > stack_channels="<<stack_channels<<" !"
            <<" hi="<<hi<<" nFull="<<nFull<<" rem="<<rem<<" nLoops="<<nLoops
            <<endl;
    }
    return ret;
}
static show_blksz_once = false;
void show_blksz(){
    if (!show_blksz_once) {
        using namespace std;
        vector<dim_t> hi;
        for(dim_t i=1; i<10; ++i) hi.push_back(i);
        for(dim_t i=10; i<130; i+=10) hi.push_back(i);
        hi.push_back(125);
        hi.push_back(128);
        for(dim_t i=150; i<601; i+=25) hi.push_back(i);
        for(dim_t i=600; i<2000; i+=100) hi.push_back(i);
        for(dim_t i=2000; i<35000; i+=500) hi.push_back(i);
        cout<<" stack_friendly_blksz(dim_t const hi) :"<<endl;
        for(auto const h: hi){
            auto const b = stack_friendly_blksz(h);
            cout<<setw(15)<<h
                <<" : blksz b= "<<left<<setw(6)<<b
                <<" nFull="<<left<<setw(6)<<h/b
                <<" nRem="<<left<<setw(6)<<h%b
                <<" b/256="<<left<<setw(6)<<b/256
                <<" b%256="<<left<<setw(6)<<b%256
                <<right<<endl;
        }
        show_blksz_once = true;
    }
}

int main(int,char**){
    show_blksz();
    dim_t biggest = 0;
    dim_t i_big   = 0;
    for(dim_t i=1; i<10*stack_channels; ++i){
        auto const sz = stack_friendly_blksz(i);
        if (sz > biggest) {
            biggest = sz;
            i_big = i;
        }
    }
    cout<<" with stack_channels threshold = "<<stack_channels<<endl;
    cout<<" from i=1.."<<stack_channels<<" biggest suggestion was "
        <<biggest<<" at stack_friendly_blksz("<<i_big<<")"<<endl;

    cout<<" Goodbye\n"<<endl;
    return 0;
}
