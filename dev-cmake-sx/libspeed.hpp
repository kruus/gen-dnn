#ifndef LIBSPEED_HPP
#define LIBSPEED_HPP
extern "C"
{
#include <cblas.h>
}// namespace "C"
#include <stdint.h>
#include <sys/time.h>
#include <stdlib.h>
#include <iostream>

class Timer {
    public:
        Timer()
            : runTime(0.0), rt_n(0U), rt_sum(0.0), rt_sumsqr(0.0), rt_min(0.0)
        {}
        void clear() {
            runTime=0.0; rt_n=0U; rt_sum=0.0; rt_sumsqr=0.0; rt_min=0.0;
        }
        void start() {
            gettimeofday(&tvStart,NULL);
        }
        void end() {
            gettimeofday(&tvEnd,NULL);
            runTime = (tvEnd.tv_sec-tvStart.tv_sec)
                + (tvEnd.tv_usec-tvStart.tv_usec)/(1000*1000.0);
            ++rt_n;
            if(rt_n==1U || runTime < rt_min) rt_min = runTime;
            rt_sum += runTime;
            rt_sumsqr += runTime*runTime;
        }
        ~Timer() { std::cout<<" ~T"<<static_cast<int>(this->bogus*1.e-12)<<' '; }
        double last() const { return runTime; }
        double min()  const { return rt_min; }
        double avg() const { return rt_sum/rt_n; }
        uint64_t samples() const { return rt_n; }
        //double stdev() const { return ...; }
    public: // a convenient spot to update things (try to gaurd against compiler over-optimization)
        double volatile bogus;
    private:
        struct timeval tvStart, tvEnd;
        double runTime;
        // time stats
        uint64_t rt_n;
        double rt_sum;
        double rt_sumsqr;
        double rt_min;
};

/** y = alpha * A * x + beta * y */
template< typename T >
void gemv( const CBLAS_ORDER order, const CBLAS_TRANSPOSE TransA,
        const int M, const int N,
        const T alpha, const T *A, const int lda,
        const T *X, const int incX,
        const T beta, T *Y, const int incY);

#ifndef LIBSPD_INLINE_GEMV
#define LIBSPD_INLINE_GEMV 1
#endif
#if LIBSPD_INLINE_GEMV
template<> inline 
    void gemv( const CBLAS_ORDER order, const CBLAS_TRANSPOSE TransA,
            const int M, const int N,
            const float alpha, const float *A, const int lda,
            const float *X, const int incX,
            const float beta, float *Y, const int incY)
{
    //cout<<" lda = "<<lda<<endl;
    cblas_sgemv( order, TransA, M, N, alpha, A, lda, X, incX, beta, Y, incY );
}
template<> inline
    void gemv( const CBLAS_ORDER order, const CBLAS_TRANSPOSE TransA,
            const int M, const int N,
            const double alpha, const double *A, const int lda,
            const double *X, const int incX,
            const double beta, double *Y, const int incY)
{
    cblas_dgemv( order, TransA, M, N, alpha, A, lda, X, incX, beta, Y, incY );
}
#endif


/** init with randoms */
template< typename FLOAT >
inline void init( FLOAT* const x, size_t cnt ){
    while(cnt--)
        x[cnt] = static_cast<FLOAT>(0.5 + drand48());
}
/** init with const value */
template< typename FLOAT >
inline void init( FLOAT* const x, size_t cnt, FLOAT const value ){
    while(cnt--)
        x[cnt] = value;
}

#ifndef LIBSPD_INLINE_TEST
#define LIBSPD_INLINE_TEST 1
#endif
#if LIBSPD_INLINE_TEST
/** \p N      size of matrix and vector
 * \p reps    size of outer loop
 * \p steps   batch size of inner loop (between timer reads)
 * \p maxtime can stop testing after this many seconds
 */
template< typename T >
inline Timer
blasDmatDvecMult( int N, size_t reps, size_t steps, double maxtime )
{
    //T * mat = new T[ N*N ]; T * vec = new T[ N ]; T * res = new T[ N ];
    T* mat = (T*)malloc( N*N*sizeof(T) );
    T* vec = (T*)malloc( N  *sizeof(T) );
    T* res = (T*)malloc( N  *sizeof(T) );
    init<T>( mat, N*N );
    init<T>( vec, N );
    init<T>( res, N, T(0.0) );

    // prep caches (untimed)
    gemv<T>( CblasRowMajor, CblasNoTrans, N, N,
            T(1.0), mat,N,   vec,1,   T(0.0), res,1 );

    Timer timer;
    for(size_t rep=0UL, rr=0U; rep<reps; ++rep )
    {
        timer.start();
        for( size_t step=0UL; step<steps; ++step ) {
            //gemv( CblasRowMajor, CblasNoTrans, N, N, element_t(1),
            //              A.data(), A.spacing(), a.data(), 1, element_t(0), b.data(), 1 );
            //gemv( CblasRowMajor, CblasNoTrans, N, N,
            //        T(1.0),mat,N,  vec,1,  T(0.0),res,1 );
            //
            //cblas_sgemv( order, TransA, M, N, alpha, A, lda, X, incX, beta, Y, incY );
            cblas_sgemv( CblasRowMajor, CblasNoTrans, N, N, 1.0, mat, N, vec, 1, 0.0, res, 1 );
            // more heavy-handed data mods (not strictly nec here)
            // Guard against compiler recognizing that calls/result are never used.
            rr=(rr+1U)%N;
            vec[rr] += 1.e-6;
            timer.bogus += static_cast<double>(res[rr]);
        }
        timer.end();

        if( timer.last() > maxtime )
            break;
    }

    const double minTime( timer.min() );
    const double avgTime( timer.avg() );
    //if( minTime * ( 1.0 + timer.stddev()*0.01 ) < avgTime )
    //    std::cerr << " BLAS kernel 'dmatdvecmult': Time deviation too large!!!\n";
    //delete[] mat; delete[] vec; delete[] res;
    free(mat); free(vec); free(res);

    return timer;
};
#endif // LIBSPD_INLINE_TEST

/** this one always goes into the library. OK, so something works. */
double round( double x, double unit );

#endif // LIBSPEED_HPP
