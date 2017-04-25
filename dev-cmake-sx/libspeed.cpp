
#include "libspeed.hpp"
//extern "C"
//{
//#include <cblas.h>
//}// namespace "C"
//#include <stdlib.h>

//#include <iostream>
//#include <iomanip>

using namespace std;

#if ! LIBSPD_INLINE_GEMV // I would like to explicitly instantiate into lib but do not know how, so ...
template<> 
    void gemv<float>( const enum CBLAS_ORDER order, const enum CBLAS_TRANSPOSE TransA,
            const int M, const int N,
            const float alpha, const float *A, const int lda,
            const float *X, const int incX,
            const float beta, float *Y, const int incY)
{
    //cout<<" lda = "<<lda<<endl;
    cblas_sgemv( order, TransA, M, N, alpha, A, lda, X, incX, beta, Y, incY );
}

template<>
    void gemv<double>( const enum CBLAS_ORDER order, const enum CBLAS_TRANSPOSE TransA,
            const int M, const int N,
            const double alpha, const double *A, const int lda,
            const double *X, const int incX,
            const double beta, double *Y, const int incY)
{
    cblas_dgemv( order, TransA, M, N, alpha, A, lda, X, incX, beta, Y, incY );
}
#endif //LIBSPD_INLINE_GEMV


#if ! LIBSPD_INLINE_TEST
// does NOT force instantiation into the library ... :(
template<> Timer blasDmatDvecMult<float>( int N, size_t reps, size_t steps, double maxtime );
#endif //LIBSPD_INLINE_TEST

double round( double x, double unit ){
    return uint64_t( (x + 0.5*unit)/unit ) * unit;
}

