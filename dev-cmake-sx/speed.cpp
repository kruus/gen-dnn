/** \file
 * non-library test code. Just includes the library code, to reduce code duplication.
 */
#include "libspeed.hpp"

#include "libspeed.cpp"

int main(int,char**)
{
    cout<<" sizeof(int)     "<<sizeof(int)<<endl;
    cout<<" sizeof(size_t)  "<<sizeof(size_t)<<endl;
    cout<<" sizeof(ssize_t) "<<sizeof(ssize_t)<<endl;
    Timer t;
#define DMATDVEC_FLOAT( N, REP, STEP, MAXTIME ) do { \
    t = blasDmatDvecMult< float >( (N), (REP), (STEP), (MAXTIME) ); \
    cout<<" blasDmatDvecMult< float >( N="<<N<<", "<<REP<<", "<<STEP<<", "<<MAXTIME \
        <<"  min "<<round(1.e6*t.min()/STEP, 0.1) \
        <<"  avg "<<round(1.e6*t.avg()/STEP, 0.1) \
        <<" us"<<endl; \
}while(0)
    //DMATDVEC_FLOAT( 100, 100, 10, 10.0 );
    //DMATDVEC_FLOAT( 100, 100, 100, 10.0 );
    //DMATDVEC_FLOAT( 100, 100, 1000, 10.0 );
    //DMATDVEC_FLOAT( 100, 100, 10000, 10.0 );
    DMATDVEC_FLOAT( 10, 100, 10000, 10.0 );
    DMATDVEC_FLOAT( 100, 100, 1000, 10.0 );
    DMATDVEC_FLOAT( 1000, 50, 500, 10.0 );
    DMATDVEC_FLOAT( 10000, 50, 5, 10.0 );
    cout<<"\nGoodye"<<endl;
    return 0;
}


