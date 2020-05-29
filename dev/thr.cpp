
#include "common/dnnl_thread.hpp"
#include "common/dnnl_thread_parallel_nd.hpp"
#include "common/ve/dnnl_thread_parallel_nd_vec.hpp"

#include <iostream>
#include <iomanip>
#include <sstream>
using namespace std;

using namespace dnnl::impl;

template<typename T>
void vprt(T* t, int const n) {
    if (n==0) cout<<"{}";
    else {
        char sep = '{';
        for (int i=0; i<n; ++i) {
            cout<<sep<<t[i];
            sep=',';
        }
        cout<<'}';
    }
}

inline bool my_nd_iterator_step() {
    return true;
}
template <typename U, typename W, typename... Args>
inline bool my_nd_iterator_step(U &x, const W &X, Args &&... tuple) {
    if (my_nd_iterator_step(utils::forward<Args>(tuple)...)) {
        cout<<" ++"<<x<<">="<<X<<"? ";
        if (++x >= X ){
            x = 0;
            return true;
        }
    }
    return false;
}

int main(int,char**){
    using namespace dnnl::impl::utils;
    {
#define SHOW(X) cout<<right<<setw(40)<<(#X)<<" : "<<X<<endl;
        SHOW(omp_get_max_threads());
        SHOW(omp_get_num_procs());
        SHOW(omp_get_num_threads());
        SHOW(omp_get_thread_num());
        SHOW(omp_in_parallel());
        int nthr = 8;
        omp_set_num_threads(8);
        cout<<" parallel region:\n";
#pragma omp parallel num_threads(nthr)
        {
#define SHOS(X) oss<<right<<setw(40)<<(#X)<<" : "<<X<<endl;
            ostringstream oss;
            oss<<" thr-"<<omp_get_thread_num()<<"-of-"<<omp_get_num_threads()<<"\n";
            //SHOS(omp_get_max_threads());
            //SHOS(omp_get_num_procs());
            //SHOS(omp_get_num_threads());
            //SHOS(omp_get_thread_num());
            //SHOS(omp_in_parallel());
            cout<<oss.str();
        }
        cout<<endl;
    }
    {
        // simple 1-d and 2-d "init" at various offsets
        dims_t d={0};
        // 1d count to 7
        nd_iterator_init(3,d[0],7); vprt(d,1); cout<<endl;
        // range<2,2> count
        nd_iterator_init(0,d[0],2,d[1],2); vprt(d,2); cout<<endl;
        nd_iterator_init(1,d[0],2,d[1],2); vprt(d,2); cout<<endl;
        nd_iterator_init(2,d[0],2,d[1],2); vprt(d,2); cout<<endl;
        nd_iterator_init(3,d[0],2,d[1],2); vprt(d,2); cout<<endl;
        // what does this do? overflow "as expected" --> {0,0}
        nd_iterator_init(4,d[0],2,d[1],2); vprt(d,2); cout<<endl;
        // AVOID -ve numbers (C / % do not round to -ve inf)
        nd_iterator_init(-1,d[0],2,d[1],2); vprt(d,2); cout<<endl;
    }
    // choose normal or verbose:
//#define my_nd_iterator_step nd_iterator_step
#define my_nd_iterator_step my_nd_iterator_step
    {
        dims_t d={0};
        nd_iterator_init(0,d[0],7);
        cout<<" init "; vprt(d,1); cout<<endl;
        for(int i=0; i<10; ++i){
            vprt(d,1);
            bool ret = my_nd_iterator_step(d[0],7);
            if (ret) cout<<" DONE! ";
            cout<<" step-->"<<ret<<' '; vprt(d,1); cout<<endl;
        }
    }
    {
        dims_t d={0};
        nd_iterator_init(0,d[0],3,d[1],2);
        cout<<" init "; vprt(d,2); cout<<endl;
        for(int i=0; i<10; ++i){
            vprt(d,2);
            bool ret = my_nd_iterator_step(d[0],3,d[1],2);
            if (ret) cout<<" DONE! ";
            cout<<" step-->"<<ret<<' '; vprt(d,2); cout<<endl;
        }
    }
    {
        // d[0], d[1], ... --> size_t *d, const int sz
        // dims {3,2} --> range<size_t>(...)  --> inplace iter(size_t* d, range<>)
        // the vector version then could be size_t dims[0..sz-1][MVL],
        // where iteration fills a set of <=MVL coords.
        // Each coord of d ---> vector register of up to MVL consecutive coords.
    }
    cout<<"\nGoodbye"<<endl;
    return 0;
}
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0,\:0,N-s
