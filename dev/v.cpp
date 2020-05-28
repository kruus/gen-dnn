
#include <cstdint>
#include <iostream>
#include <iomanip>

#include "assert.h"

#define MAXD 4
#define MVL 256

typedef uint64_t dim_t;
typedef dim_t dims_t[MAXD];    // max tensor dimensionality (DNNL_MAX_DIMS)
typedef dim_t offs_t[MVL];     // logical or physical offsets

typedef dim_t vpos_t[MAXD][MVL];

#define NOVEC_ _Pragma("_NEC novector")
#define VEC_ _Pragma("_NEC vector")
#define SHORT_ _Pragma("_NEC vector") _Pragma("_NEC shortloop") _Pragma("_NEC assume")
//#define SHORT_ _Pragma("_NEC shortloop")

template<typename T>
struct OV {
    OV(T const* v, int const sz) : v(v), sz(sz) {}
    T const* const v;
    int const sz;
};

template<typename T>
std::ostream& operator<<(std::ostream &os, OV<T> const& ov) {
    os<<" dims_t";
    char sep = '{';
    NOVEC_ for(int i=0; i<ov.sz; ++i){ os<<sep<<ov.v[i]; sep=','; }
    os<<'}';
    return os;
}

struct VecPos  {
    int npos;   // <= MVL
    int dims;   // <= MAXD
    vpos_t vp;  // vp[dim][pos]

    VecPos(int npos, int dims) : npos(npos), dims(dims) {
    }

    void coords(int const p, dims_t &ret){ // get p'th position coordinates
        for(int i=0; i<dims; ++i){
            ret[i] = vp[i][p];
        }
        for(int i=dims; i<MAXD; ++i){
            ret[i] = 0;
        }
    }

    // all our vp coords --> back to physical offset
    void vpos2phys(dims_t const& t, int const td, // tensor dims
                   dim_t *poff) const {
        assert(npos <= MVL);
        dim_t phys[MVL];
        _Pragma("_NEC vreg(phys)");
        for(int l=0; l<npos; ++l) phys[l] = 0;
        dim_t stride=1;
        NOVEC_ for(int d=dims-1; d>=0; --d) { // reverse dims
            dim_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<npos; ++l) tmp[l] = vp[d][l]; // VLD
            VEC_ for(int l=0; l<npos; ++l) {
                phys[l] += tmp[l] * stride;     // VMUL,VADD
                // (nc++ inserts an un-necessary vector copy)
            }
            stride *= t[d];
        }
        for(int l=0; l<npos; ++l) poff[l] = phys[l]; // VST
    }

    void l2pos(dims_t const& t, int const td, // tensor dims
               dim_t const* const loff, int const noff) // logical offsets
    {
        assert(td > 0 && td <= MAXD);
        assert(noff > 0 && noff <= MVL);
        dims = td;
        npos = noff;
        //std::cout<<" t["<<td<<"] = "<<OV<dim_t>{t,td}<<std::endl;
#if 0 // original
        //dims_t strides={0};
        //strides[td-1] = 1;
        //SHORT_ _Pragma("_NEC unroll(4)") for(int d=td-2; d>=0; --d) {
        //    strides[d] = strides[d+1] * t[d];
        //}

        offs_t off;
        offs_t rem;
        offs_t div;
        _Pragma("_NEC vreg(off)");
        _Pragma("_NEC vreg(rem)");
        _Pragma("_NEC vreg(div)");
        SHORT_ for(int i=0;i<noff;++i) off[i]=loff[i];
        //std::cout<<" loff["<<noff<<"] = "<<OV<dim_t>{loff,noff}<<std::endl;

        NOVEC_ for(int d=td-1; d>=0; --d) { // d ~ dimension (reverse order)
            auto const cur_dim = t[d];
            //std::cout<<" cur_dim="<<cur_dim<<std::endl;
            SHORT_ for(int l=0; l<noff; ++l) { // l ~ logical offset #
                //std::cout<<"         off="<<off[l];
                div[l] = off[l] / cur_dim;
                rem[l] = off[l] - div[l] * cur_dim;
                off[l] = div[l];
                //std::cout<<" div,rem="<<div[l]<<","<<rem[l];
                //std::cout<<" off="<<off[l];
                //std::cout<<std::endl;
            }
            SHORT_ for(int l=0; l<noff; ++l) {
                vp[d][l] = rem[l];
            }
        }
#if 0
        SHORT_ for(int l=0; l<noff; ++l) {
            dims_t pos={0};
            for(int d=0; d<td; ++d){
                pos[d] = vp[d][l];
            }
            std::cout<<" check l="<<l<<" pos="<<OV<dim_t>{pos,td}<<std::endl;
        }
#endif
#elif 0
        offs_t off;
        offs_t rem;
        offs_t div;
        _Pragma("_NEC vreg(off)");
        _Pragma("_NEC vreg(rem)");
        _Pragma("_NEC vreg(div)");
        SHORT_ for(int i=0;i<noff;++i) off[i]=loff[i];

        //NOVEC_ for(int d=td-1; d>=0; --d) { // d ~ dimension (reverse order)
        //    auto const cur_dim = t[d];
        //    SHORT_ for(int l=0; l<noff; ++l) { // l ~ logical offset #
        //        div[l] = off[l] / cur_dim;
        //        rem[l] = off[l] - div[l] * cur_dim;
        //        off[l] = div[l];
        //    }
        //    SHORT_ for(int l=0; l<noff; ++l) {
        //        vp[d][l] = rem[l];
        //    }
        //}
        //  Manual Unroll
        int cur_dim;
        int d;
#define UP  \
        div[l] = off[l] / cur_dim; \
        rem[l] = off[l] - div[l] * cur_dim; \
        off[l] = div[l]; \
        vp[d][l] = rem[l];
        switch(td){
          case(6):
              d = 5;
              cur_dim = t[d];
              SHORT_ for(int l=0; l<noff; ++l) {UP}
          case(5):
              d = 4;
              cur_dim = t[d];
              SHORT_ for(int l=0; l<noff; ++l) {UP}
          case(4):
              d = 3;
              cur_dim = t[d];
              SHORT_ for(int l=0; l<noff; ++l) {UP}
          case(3):
              d = 2;
              cur_dim = t[d];
              SHORT_ for(int l=0; l<noff; ++l) {UP}
          case(2):
              d = 1;
              cur_dim = t[d];
              SHORT_ for(int l=0; l<noff; ++l) {UP}
          case(1):
              d = 0;
              cur_dim = t[d];
              SHORT_ for(int l=0; l<noff; ++l) {UP}
          case(0):
          default:
              ;
        }
#elif 0
        offs_t off;
        offs_t rem;
        offs_t div;
        _Pragma("_NEC vreg(off)");
        _Pragma("_NEC vreg(rem)");
        _Pragma("_NEC vreg(div)");
        SHORT_ for(int i=0;i<noff;++i) off[i]=loff[i];

        //  Manual Unroll
        int cur_dim;
        int d;
#define UP  \
        div[l] = off[l] / cur_dim; \
        rem[l] = off[l] - div[l] * cur_dim; \
        off[l] = div[l]; \
        vp[d][l] = rem[l];
        if(td>=6){ d = 5; cur_dim = t[d];
            SHORT_ for(int l=0; l<noff; ++l) {UP}
        }
        if(td>=5) { d = 4; cur_dim = t[d];
            SHORT_ for(int l=0; l<noff; ++l) {UP}
        }
        if(td>=4) { d = 3; cur_dim = t[d];
            SHORT_ for(int l=0; l<noff; ++l) {UP}
        }
        if(td>=3) { d = 2; cur_dim = t[d];
            SHORT_ for(int l=0; l<noff; ++l) {UP}
        }
        if(td>=2) { d = 1; cur_dim = t[d];
            SHORT_ for(int l=0; l<noff; ++l) {UP}
        }
        if(td>=1) { d = 0; cur_dim = t[d];
            SHORT_ for(int l=0; l<noff; ++l) {UP}
        }
        // even though told shortloop, still tests for loop lim?
#elif 0
        offs_t off;
        offs_t rem;
        offs_t div;
        _Pragma("_NEC vreg(off)");
        _Pragma("_NEC vreg(rem)");
        _Pragma("_NEC vreg(div)");
        SHORT_ for(int i=0;i<noff;++i) off[i]=loff[i];

        //  Manual Unroll
        int cur_dim;
        int d;
        if(td<5) {
            if(td<3) {
                if(td==2) goto U2;
                goto U1; // assume range 1..MAXD
            }else{
                if(td==4) goto U4;
                goto U3;
            }
        }else{
            if(td==5) goto U5;
        }
#define UP  \
        div[l] = off[l] / cur_dim; \
        rem[l] = off[l] - div[l] * cur_dim; \
        off[l] = div[l]; \
        vp[d][l] = rem[l];
        //U6:
        d = 5; cur_dim = t[d];
        SHORT_ for(int l=0; l<noff; ++l) {UP}
U5:
        d = 4; cur_dim = t[d];
        SHORT_ for(int l=0; l<noff; ++l) {UP}
U4:
        d = 3; cur_dim = t[d];
        SHORT_ for(int l=0; l<noff; ++l) {UP}
U3:
        d = 2; cur_dim = t[d];
        SHORT_ for(int l=0; l<noff; ++l) {UP}
U2:
        d = 1; cur_dim = t[d];
        SHORT_ for(int l=0; l<noff; ++l) {UP}
U1:
        d = 0; cur_dim = t[d];
        SHORT_ for(int l=0; l<noff; ++l) {UP}
#else // well, if we cannot do really well, do something that inlines well
        offs_t off;
        offs_t rem;
        offs_t div;
        _Pragma("_NEC vreg(off)");
        _Pragma("_NEC vreg(rem)");
        _Pragma("_NEC vreg(div)");
        SHORT_ for(int i=0;i<noff;++i) off[i]=loff[i];

#define UP0 /* safer, but not needed */ \
        div[l] = off[l] / cur_dim; \
        rem[l] = off[l] - div[l] * cur_dim; \
        off[l] = div[l]; \
        vp[rd][l] = rem[l];
#define UP /* does the right thing */ \
        rem[l] = off[l] % cur_dim; \
        off[l] = off[l] / cur_dim; \
        vp[rd][l] = rem[l];
        NOVEC_ _Pragma("_NEC nounroll")
        for(int d=0; d<td; ++d) { // d ~ dimension
            int rd = td-1-d;     // reverse dim
            dim_t cur_dim = t[rd];
            SHORT_ for(int l=0; l<noff; ++l) { // l ~ logical offset #
                UP;
            }
            //--pt;
        }
        // still too many tests, branches and vl reloads with nc++
#endif
    }
};

using namespace std;
int main(int,char**){
    // tensor size
    int const tdims=3;
    dims_t t{1000,100,10};
    // offset (base 10) AAABBC ---> coords {AAA,BB,C}

    // logical offsets
    size_t const noff =5;
    dim_t loff[noff]={0, 123456, 999887, 987654, 987654321};
    // (last is out-of-range)

    // logical positions
    VecPos vp(noff,tdims);

    // set coords from vector of logical offsets
    //   vp has loff coordinate vectors of tdims dimension.
    vp.l2pos(t, tdims, &loff[0], noff);

    cout<<" logical positions [noff][tdims]\n";
    NOVEC_ for(int p=0; p<noff; ++p){
        dims_t p_coords;
        vp.coords(p, p_coords);
        cout<<" loff["<<p<<"] = "<<setw(10)<<loff[p]<<" --> "
            <<OV<dim_t>{p_coords,tdims}<<endl;
    }

    dim_t phys[noff];
    vp.vpos2phys(t, tdims, &phys[0]);
    cout<<" now coords --> back to physical offsets"<<std::endl;
    NOVEC_ for(int p=0; p<noff; ++p){
        cout<<" loff["<<p<<"] = "<<setw(10)<<loff[p]<<" --> "<<phys[p]<<endl;
    }


    cout<<"\nGoodbye"<<endl;
}
