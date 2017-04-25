#include "libspeed.hpp"

#include <iostream>
#include <iomanip>
using namespace std;

int main(int,char**)
{
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


