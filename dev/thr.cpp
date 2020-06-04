
#include "common/dnnl_thread.hpp"
#include "common/dnnl_thread_parallel_nd.hpp"
#include "common/ve/dnnl_thread_parallel_nd_vec.hpp"
#include "common/dnnl_optimize.h"

#include <iostream>
#include <iomanip>
#include <sstream>
#include <array>
using namespace std;

using namespace dnnl::impl;

#define MVL 7
#define NOVEC_ PragmaQuote(_NEC novector)
// internal structs for off_v_vec :
struct VecPos {
    uint64_t vp[DNNL_MAX_NDIMS][MVL];
};
struct VecPos32 {
    uint32_t vp[DNNL_MAX_NDIMS][MVL];
};

/** For dense layouts:
 *
 * `iter_init(0, l0,h0, l1,h1, ...)` intiializes a first batch
 * of coords for `for(l0..h0) for(l1..h1)...`.
 *
 * `iter_step_nd()` gets the next batch of coords (or returns false)
 *
 * cf. memory desc, where we translate loff (linear logical offset) with
 * dense ranges [0,N),[0,C),[0,H),... first into padded ranges, and then
 * give padded "as if dense" coords to get physical "global" offsets.
 *
 * Sycl range is a bit better.
 * Want dims[0..dim] to be N,C,H, and define a subrange within each range.
 *
 * - memory_desc also supports
 *   - dims_init(N,C,H,...) to set dims and strides.
 *   - padded dims setting, global coords
 *
 * - here we have undpadded "dense" coords within some `iter_init` subrange
 *
 */
struct CoordsVP : public VecPos {
    CoordsVP()
        : dim(0), vl(0), ilo{0}, ihi{0}, sz(0), pos(0) {}
    CoordsVP(unsigned dim, unsigned vl)
        : dim(dim), vl(vl), ilo{0}, ihi{0}, sz(0), pos(0)
    {
        if (dim > DNNL_MAX_NDIMS){
            printf(" error: CoordsVP too high dim = %u",dim);
            dim = DNNL_MAX_NDIMS;
        }
        if (vl > MVL){
            printf(" error: CoordsVP too high vl = %u",vl);
            vl = MVL;
        }
        memset(&vp[0][0], 0, sizeof(vp));
    }
    int get_dim() const {return dim;}
    int get_vl()   const {return vl;}
    /// unchecked lo for loop limit
    int get_lo(unsigned const dim)  const { return ilo[dim]; }
    int get_hi(unsigned const dim)  const { return ihi[dim]; }
    private:
    unsigned dim;
    unsigned vl;
    // now add "vl-wise" iteration:
    unsigned ilo[DNNL_MAX_NDIMS];
    unsigned ihi[DNNL_MAX_NDIMS];
    size_t sz; // product of ihi-ilo for 0..dim-1
    size_t pos;
    public:
    void iter_init_1d(unsigned lo0, unsigned hi0){
        assert( hi0 >= lo0 );
        ilo[0] = lo0;
        ihi[0] = hi0;
        dim=1;
        sz = size_t{1};
        for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d];
        pos = 0;
        unsigned cnt0 = ilo[0] - 1;
        for(unsigned i=0U; i<vl; ++i){
            if(++cnt0 >= ihi[0]){
                cnt0 = ilo[0];
            }
            vp[0][i] = cnt0;
        }
    }
    void iter_init_2d(unsigned lo0, unsigned hi0, unsigned lo1, unsigned hi1){
        ilo[0] = lo0;
        ihi[0] = hi0;
        ilo[1] = lo1;
        ihi[1] = hi1;
        dim=2;
        sz = size_t{1};
        for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d];
        pos = 0;
        unsigned cnt0 = ilo[0];
        unsigned cnt1 = ilo[1] - 1;
        for(unsigned i=0U; i<vl; ++i){
            if(++cnt1 >= ihi[1]){
                cnt1 = ilo[1];
                if(++cnt0 >= ihi[0]){
                    cnt0 = ilo[0];
                }
            }
            vp[1][i] = cnt1;
            vp[0][i] = cnt0;
        }
    }
    /** init at linear iter pos,
     * adjust if pos+vl "past end"
     * Note diff with off_l_vec API where a vector of `lin` values are input
     * \return true iff remaining iteration length vl > 0.
     *
     * Once you have a span-relative coord, a global physical offset is:
     * - `coord_i*stride_i`
     *   - where strides are padded/not.
     * - we bypass the off_l_vec translation from linear-->coords
     *
     * - we can directly input our coords into vec_off_v 
     *
     * mdw API:
     * - vec_off_loops(l0,h0, l1,h1, ...) where every dim gets lo,hi args
     *   - internally generate a CoordsVP
     * - vec_off_loops_next() generate next coordsVP, ret false if done
     * - vec_off_loops_call( void(*f)(VecPos& vp) );
     *
     * streamlined API (ignore bool ip=is_pos_padded?)
     * - vec_off_iter( void(*f)(VecPos&), ip?, l0,h0, l1,h1, ...)
     *   - call "vector-of-coords" function f in simd-len batches
     * - vec_off_iter( void(*f)(uint32_t), ip?, l0,h0, l1,h1, ...)
     *   - call "global-physical-offset" function g in simd-len batches
     *   - internally call vec_off_v to get physical offsets
     */
    bool iter_set_nd(size_t lin){
        if(lin >= sz){
            //cout<<" lin="<<lin<<" > sz="<<sz<<endl;
            pos = sz;
            vl = 0;
            return false;
        }
        pos = lin;
        vl = MVL;
        if(pos + vl > sz){
            //cout<<" [pos+vl="<<pos<<"+"<<vl<<"] > [sz="<<sz<<"]"<<endl;
            vl = sz - pos;
        }
        assert( vl > 0 );
#if 0 // unvectorizable
        for(unsigned i=0U; i<vl; ++i){
            uint64_t carry = pos+i;
            uint64_t mod;
            for(unsigned d = 0; d<dim; ++d){
                auto const rd = dim - 1 - d;
                auto const span = ihi[rd] - ilo[rd];
                mod   = carry % span;
                carry = carry / span;
                vp[rd][i] = ilo[rd] + mod;
            }
        }
#else
        uint64_t carry[MVL];
        for(unsigned i=0U; i<vl; ++i)
            carry[i] = pos+i;
        NOVEC_ for(unsigned d = dim; d--; ) {
            auto const span = ihi[d] - ilo[d];
            for(unsigned i=0U; i<vl; ++i){
                vp[d][i] = ilo[d] + carry[i] % span;
                carry[i] = carry[i] / span;
            }
        }
#endif
        return true;
    }
    /** Maybe "extend" at linear iter pos, increasing existing vl up to MVL.
     * Keeps old set of vl coords. Possible to extend by zero new coords if vl==MVL already!
     * Check that `vl+sz<=MVL` if you need all coords to fit with no `step`.
     * Untested.
     * \return true iff some coords were be added. */
    bool iter_extend_nd(size_t lin){
        if(lin >= sz || vl >= MVL){
            return false;
        }
        pos = lin;
        auto addvl = sz - lin;
        assert( addvl > 0 );
        if (vl + addvl >= MVL) addvl = MVL - vl;
        for(unsigned i=0U; i<addvl; ++i){
            uint64_t carry = pos+i;
            uint64_t mod;
            for(unsigned d = dim; d--; ) {
                auto const span = ihi[d] - ilo[d];
                mod   = carry % span;
                carry = carry / span;
                vp[d][vl+i] = ilo[d] + mod;
            }
        }
        vl += addvl;
        return true;
    }
    /** set next coord vectors at linear pos+vl.
     * \return true iff remaining iteration lenght vl > 0 */
    bool iter_step_nd(){
        //cout<<" sz="<<sz<<" pos="<<pos<<"-->"<<pos+vl<<"?"<<endl;
        if( pos < sz ){
            assert( vl > 0 );
            //return iter_set_2d(pos + vl);
            return iter_set_nd(pos + vl);
        }
        return false;
    }
    /** educational */
    bool iter_set_1d(size_t lin){
        if(lin >= sz){
            //cout<<" lin="<<lin<<" > sz="<<sz<<endl;
            pos = sz;
            vl = 0;
            return false;
        }
        pos = lin;
        vl = MVL;
        if(pos + vl > sz){
            //cout<<" [pos+vl="<<pos<<"+"<<vl<<"] > [sz="<<sz<<"]"<<endl;
            vl = sz - pos;
        }
        assert( vl > 0 );
        for(unsigned i=0U; i<vl; ++i){
            vp[0][i] = ilo[0] + (pos+i) % (ihi[0]-ilo[0]);
        }
        return true;
    }
    bool iter_init_1d(size_t lin, unsigned lo0, unsigned hi0){
        assert( hi0 >= lo0 );
        ilo[0] = lo0;
        ihi[0] = hi0;
        dim=1;
        sz = size_t{1};
        for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d];
        //return iter_set_1d(lin);
        return iter_set_nd(lin);
    }
    /** educational */
    bool iter_step_1d(){
        //cout<<" sz="<<sz<<" pos="<<pos<<"-->"<<pos+vl<<"?"<<endl;
        if( pos < sz ){
            assert( vl > 0 );
            //return iter_set_1d(pos + vl);
            return iter_set_nd(pos + vl);
        }
        return false;
    }
    /** educational */
    bool iter_set_2d(size_t lin){
        if(lin >= sz){
            //cout<<" lin="<<lin<<" > sz="<<sz<<endl;
            pos = sz;
            vl = 0;
            return false;
        }
        pos = lin;
        vl = MVL;
        if(pos + vl > sz){
            //cout<<" [pos+vl="<<pos<<"+"<<vl<<"] > [sz="<<sz<<"]"<<endl;
            vl = sz - pos;
        }
        assert( vl > 0 );
        for(unsigned i=0U; i<vl; ++i){
            //cout<<" i="<<i<<"of"<<vl;
            auto carry = pos+i;
            auto mod = carry % (ihi[1] - ilo[1]);
            carry = carry / (ihi[1] - ilo[1]);
            //cout<<" mc1="<<mod<<","<<carry;
            vp[1][i] = ilo[1] + mod;
            //if (carry) {
                mod = carry % (ihi[0] - ilo[0]);
                carry = carry / (ihi[0] - ilo[0]);
                //cout<<" mc0="<<mod<<","<<carry;
                vp[0][i] = ilo[0] + mod;
            //}else{
            //    vp[0][i] = "unchanged"; // oops
            //}
            //cout<<endl;
        }
        return true;
    }
    bool iter_init_2d(size_t lin, unsigned lo0, unsigned hi0, unsigned lo1, unsigned hi1){
        assert( hi0 > lo0 );
        assert( hi1 > lo1 );
        ilo[0] = lo0;
        ihi[0] = hi0;
        ilo[1] = lo1;
        ihi[1] = hi1;
        dim=2;
        sz = size_t{1};
        for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d];
        cout<<"init sz="<<sz<<" lin pos "<<lin<<"..."<<endl;
        //return iter_set_2d(lin);
        return iter_set_nd(lin);
    }
    /** educational */
    bool iter_step_2d(){
        //cout<<" sz="<<sz<<" pos="<<pos<<"-->"<<pos+vl<<"?"<<endl;
        if( pos < sz ){
            assert( vl > 0 );
            //return iter_set_2d(pos + vl);
            return iter_set_nd(pos + vl);
        }
        return false;
    }
    private:
    inline bool iter_range(unsigned d) {
        dim = d;
        return true;
    }
    /** iter_range(0 [,lo,hi]...) initialize ilo[],ihi[] iter ranges for dim 0,1,... */
    template<typename LO, typename HI, typename... Args>
        inline bool iter_range(unsigned d , LO const lo, HI const hi, Args &&... tuple) {
            ilo[d] = (unsigned)lo;
            ihi[d] = (unsigned)hi;
            iter_range(d+1U, utils::forward<Args>(tuple)...);
        }
    public:
    /** generic nd init of nested sequential for loops.
     * Initialize `for(lo0..hi0) for(lo1..hi1) ...`
     * starting at linear entry `pos`.
     *
     * \arg pos linear entry (usually you use 0)
     * \arg for loop limits  as up to DNNL_MAX_NDIMS pairs.
     *
     * \ret true if some coords are now ready to use.
     *
     * Use iter_step_nd() to get the next batch of coords (if any).
     */
    template<typename T, typename LO, typename HI, typename... Args>
        inline bool iter_init(T const pos, LO const lo, HI const hi, Args &&... tuple) {
            iter_range(0,lo,hi,utils::forward<Args>(tuple)...);
            sz = size_t{1};
            for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d];
            cout<<" iter_init dim="<<dim;
            for(int d=0; d<dim; ++d){
                cout<<" ["<<ilo[d]<<","<<ihi[d]<<")";
            }
            cout<<" sz="<<sz<<endl;
            return iter_set_nd(pos);
        }
};

std::ostream& operator<<(std::ostream& os, CoordsVP const& c){
    auto const vl = c.get_vl();
    auto const dim = c.get_dim();
    os<<"crd["<<c.get_vl()<<"]{";
    for(unsigned v=0; v<vl; ++v){
        if(v < 5 || v > vl - 5){
            os<<(v>0? ",":"")<<"{";
            for(unsigned d=0; d<dim; ++d){
                os<<(d>0? ",":"")<<c.vp[d][v];
            }
            os<<"}";
        }else if(v==5) os<<"...";
    }
    os<<"}";
    return os;
}

/** generate "for-loop-coords".  This helper class does not know anything
 * about actual tensor dimension, which are assumed to contain the loop
 * lo,hi limits.
 *
 * This class allows "batching" the for-loop-coords into simd-coord vectors
 * (at most MVL-long), until all simd-coords have been generated.
 *
 * - Main routines:
 *   - `init(l0,h0, l1,h1, ...)` equiv. `init_at(0, l0,h0, l1,h1, ...)`
 *   - `operator bool()` equiv. `get_vl() > 0`  "we have some coords"
 *   - `step()`          ret true iff this->vp has something new for us
 *
 * - Internal quantity: `this->vp` register-like memory region
 *   - vp[DNNL_MAX_NDIMS][MVL]
 *   - a stand-in for what in assembler might be `get_dim() <= DNNL_MAX_NDIMS`
 *     SIMD registers.
 *
 * TBD:
 * `iter( void (*f)(VecPos const&), l0,h0, l1,h1, ... )`
 *
 * Ex. to iterate nchw over mb, c, [h_st,h_en), [w_st,w_en) (no bounds checks)
 * ```
 * iter( auto [&]f(VecPos& vp){printf(" batch!");},
 *       mb,mb+1, c,c+1, h_st,h_en, w_st,w_en );
 * ```
 *
 * Note: memory_desc knows how many dims, we must match exactly!
 */

/** memory-backed replacement for a set of vector registers.
 *
 * In assembler, this would be a set of vector registers where dim-wise
 * vectors could be selected by the VIDX register.
 *
 * In C++, these may still generate vector-load vector-store at entry/end
 * of code blocks. nc++ support for the old SX vreg/alloc_on_vreg
 * pragmas seems to have slipped.
 */
template<typename Crd = unsigned, unsigned MaxDims = DNNL_MAX_NDIMS>
struct CoordRegs {
    static unsigned constexpr MaxVl = MVL;
    Crd vp[MaxDims][MaxVl];
};
#if 0 /** ugly, don't know how many dims */
template<typename Crd = unsigned, unsigned MaxDims = DNNL_MAX_NDIMS>
std::ostream& operator<<( std::ostream& os, typename CoordRegs<Crd,MaxDims> const& cr ){
}
#endif
#if 0
// better with IO-wrapper function Vp(coordsVP2)
template<typename Crd = unsigned, unsigned MaxDims = DNNL_MAX_NDIMS>
std::ostream& operator<<( std::ostream& os,
        std::tuple< CoordRegs<Crd,MaxDims> const& /*cr*/,
        unsigned const /*dim*/, unsigned const /*vl*/ > const& c_dim_vl)
{
    auto const& c   = std::get<0>(c_dim_vl);
    auto const& dim = std::get<1>(c_dim_vl);
    auto const& vl  = std::get<2>(c_dim_vl);
    os<<"crd["<<vl<<"]{";
    for(unsigned v=0; v<vl; ++v){
        if(v < 5 || v > vl - 5){
            os<<(v>0? ",":"")<<"{";
            for(unsigned d=0; d<dim; ++d){
                os<<(d>0? ",":"")<<c.vp[d][v];
            }
            os<<"}";
        }else if(v==5) os<<"...";
    }
    os<<"}";
    return os;
}
#endif
/** here's a cleaned up "production version" beta.
 *
 * WHAT I DO NOT LIKE
 *
 * This class has runtime dim.  But initialization always "known" the dim,
 * so dim should really be a compile-time const.
 */
template<unsigned MaxDims=DNNL_MAX_NDIMS, typename Crd = unsigned, typename Pos=size_t>
struct CoordsVP2 : public CoordRegs<Crd,MaxDims> {
    typedef CoordRegs<Crd,MaxDims> Base;
    CoordsVP2() : dim(0), vl(0), ilo{0}, ihi{0}, sz(0), pos(0) {}

    Base const& base() const { return *this; }
    operator bool() const { return vl > 0; }
    operator ++() { this->step(); return *this; }

    /// If get_vl(), then we have something in this->vp to process.
    /// Use `step()` which returns true and next batch (or false).
    unsigned get_vl()  const {return vl;}
    unsigned get_dim() const {return dim;}
    /// unchecked lo for loop limit
    Crd get_lo(unsigned const dim)  const { return ilo[dim]; }
    Crd get_hi(unsigned const dim)  const { return ihi[dim]; }
    //int constexpr MVL = 32;
    private:
    unsigned dim;               ///< 0..DNNL_MAX_NDIMS
    unsigned vl;                ///< 0..MVL
    // now add "vl-wise" iteration:
    Crd ilo[MaxDims];
    Crd ihi[MaxDims];
    Pos sz; // product of ihi-ilo for 0..dim-1
    Pos pos;
    public:
    /** init at linear iter pos, shorten vl from MVL iif pos+vl "past end"
     * Note diff with off_l_vec API where a vector of `lin` values are input
     * \return true iff remaining iteration length vl > 0.
     *
     * Once you have a span-relative coord, a global physical offset is:
     * - `coord_i*stride_i`
     *   - where strides are padded/not.
     * - we bypass the off_l_vec translation from linear-->coords
     *
     * - we can directly input our coords into vec_off_v 
     *
     * mdw API:
     * - vec_off_loops(l0,h0, l1,h1, ...) where every dim gets lo,hi args
     *   - internally generate a CoordsVP
     * - vec_off_loops_next() generate next coordsVP, ret false if done
     * - vec_off_loops_call( void(*f)(VecPos& vp) );
     *
     * streamlined API (ignore bool ip=is_pos_padded?)
     * - vec_off_iter( void(*f)(VecPos&), ip?, l0,h0, l1,h1, ...)
     *   - call "vector-of-coords" function f in simd-len batches
     * - vec_off_iter( void(*f)(uint32_t), ip?, l0,h0, l1,h1, ...)
     *   - call "global-physical-offset" function g in simd-len batches
     *   - internally call vec_off_v to get physical offsets
     */
    bool iter_set(Pos lin){
        if(lin >= sz){
            //cout<<" lin="<<lin<<" > sz="<<sz<<endl;
            pos = sz;
            vl = 0;
            return false;
        }
        pos = lin;
        vl = MVL;
        if(pos + vl > sz){
            //cout<<" [pos+vl="<<pos<<"+"<<vl<<"] > [sz="<<sz<<"]"<<endl;
            vl = sz - pos;
        }
        assert( vl > 0 );
        Pos carry[Base::MaxVl];
        for(unsigned i=0U; i<vl; ++i)
            carry[i] = pos+i;
        NOVEC_ for(unsigned d = dim; d--; ) {
            auto const span = ihi[d] - ilo[d];
            for(unsigned i=0U; i<vl; ++i){
                (this->vp)[d][i] = ilo[d] + carry[i] % span;
                carry[i] = carry[i] / span;
            }
        }
        return true;
    }
    /** Maybe "extend" at linear iter pos, increasing existing vl up to MVL.
     * Keeps old set of vl coords. Possible to extend by zero new coords if vl==MVL already!
     * Check that `vl+sz<=MVL` if you need all coords to fit with no `step`.
     * \b Untested.
     * \return true iff some coords were be added.
     *
     * Idea: in some cases you might 'pack' sets of loops into a longer vector?
     * Problem: How to efficiently unpack/mask the sets later.
     */
    bool iter_extend(Pos lin){
        if(lin >= sz || vl >= MVL){
            return false;
        }
        pos = lin;
        auto addvl = sz - lin;
        assert( addvl > 0 );
        if (vl + addvl >= MVL) addvl = MVL - vl;
        for(unsigned i=0U; i<addvl; ++i){
            uint64_t carry = pos+i;
            uint64_t mod;
            for(unsigned d = dim; d--; ) {
                auto const span = ihi[d] - ilo[d];
                mod   = carry % span;
                carry = carry / span;
                vp[d][vl+i] = ilo[d] + mod;
            }
        }
        vl += addvl;
        return true;
    }
    /** set next coord vectors at linear pos+vl.
     * \return true iff remaining iteration lenght vl > 0 */
    bool step(){
#ifndef NDEBUG
        if (pos < sz ) assert( vl > 0 );
#endif
        return pos < sz? iter_set(pos + vl): false;
    }
    private:
    inline bool iter_range(unsigned d) {
        dim = d;
        return true;
    }
    /** iter_range(0 [,lo,hi]...) initializes ilo[],ihi[] iter ranges for dim 0,1,... */
    template<typename LO, typename HI, typename... Args>
        inline bool iter_range(unsigned d , LO const lo, HI const hi, Args &&... tuple) {
            ilo[d] = (unsigned)lo;
            ihi[d] = (unsigned)hi;
            // ? span[d] = ilo[d] - ihi[d];
            iter_range(d+1U, utils::forward<Args>(tuple)...);
        }
    public:
    /** generic init of nested sequential for loops.
     * Initialize `for(lo0..hi0) for(lo1..hi1) ...`
     * starting at linear entry `pos`.
     *
     * \arg pos linear entry (usually you use 0)
     * \arg for loop limits  as up to DNNL_MAX_NDIMS pairs.
     *
     * \ret true if some coords are now ready to use.
     *
     * Use iter_step_nd() to get the next batch of coords (if any).
     */
    template<typename T, typename LO, typename HI, typename... Args>
        inline bool init_at(T const pos, LO const lo, HI const hi, Args &&... tuple) {
            // store the dimensions
            iter_range(0,lo,hi,utils::forward<Args>(tuple)...);
            // calc total size (could be done within iter_range?)
            sz = Pos{1};
            for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d];
#if 0
            cout<<" init_at dim="<<dim;
            for(int d=0; d<dim; ++d){
                cout<<" ["<<ilo[d]<<","<<ihi[d]<<")";
            }
            cout<<" sz="<<sz<<" pos="<<pos<<endl;
#endif
            // calc first batch of coord vectors, ret true if have some
            return iter_set(pos);
        }
    /** init_at(0,lohi...) */
    template<typename... Args>
        inline bool init(Args &&... lohi) {
            this->init_at( size_t{0}, utils::forward<Args>(lohi)...);
        }
    /** intended syntax --
     * for(auto c = CoordsVP2::mk(0,4,0,3,0,2); c; ++c) f(c.vp); */
    template<typename... Args>
    static CoordsVP2 mk(Args &&... lohi){
        CoordsVP2 ret;
        ret.init(utils::forward<Args>(lohi)...);
        return ret;
    }
    /** terse output of current 'vp' coordinate vectors. */
    std::string coord_str(char const* pfx="crd") {
        std::ostringstream oss;
        auto const& c = base();
        oss<<pfx<<"["<<dim<<"][vl="<<vl<<"]~{";
        for(unsigned v=0; v<vl; ++v){
            if(v < 5 || v > vl - 5){
                oss<<(v>0? ",":"")<<"{";
                for(unsigned d=0; d<dim; ++d){
                    oss<<(d>0? ",":"")<<c.vp[d][v];
                }
                oss<<"}";
            }else if(v==5) oss<<"...";
        }
        oss<<"}\n";
        return oss.str();
    }
};

#if 0
template<unsigned MaxDims, typename Crd, typename Pos>
struct IoVp {
    IoVp( CoordsVP2<MaxDims,Crd,Pos> const& x ) : x(x) {}
    CoordsVP2<MaxDims,Crd,Pos> const& x;
};
#else
template<typename T>
struct IoVp {
    IoVp( T const& x ) : x(x) {}
    T const& x;
};
#endif

// better with IO-wrapper function Vp(coordsVP2)
template<typename T>
std::ostream& operator<<( std::ostream& os, IoVp<T> const& iovp )
{
    auto const& c   = iovp.x.base();
    auto const& dim = iovp.x.get_dim();
    auto const& vl  = iovp.x.get_vl();
    os<<"crd["<<vl<<"]{";
    for(unsigned v=0; v<vl; ++v){
        if(v < 5 || v > vl - 5){
            os<<(v>0? ",":"")<<"{";
            for(unsigned d=0; d<dim; ++d){
                os<<(d>0? ",":"")<<c.vp[d][v];
            }
            os<<"}";
        }else if(v==5) os<<"...";
    }
    os<<"}";
    return os;
}

/** here's a compile-time dim version */
template<unsigned dim, typename Crd = unsigned, typename Pos=size_t>
struct CoordsVP3 : public CoordRegs<Crd,dim> {
    typedef CoordRegs<Crd,dim> Base;
    private:
    static typename std::array<Crd,dim> getspan(std::array<Crd,dim>& h, std::array<Crd,dim>& l) {
        std::array<Crd,dim> ret;
        for(unsigned d=0U; d<dim; ++d) {
            ret[d] = h[d] - l[d];
        }
        return ret;
    }
    public:
    /// General constructor
    CoordsVP3( std::array<Crd,dim>&& lo, std::array<Crd,dim>&& hi, size_t pos=0 )
        : vl(0), ilo{lo}
        , ihi{hi} // maybe don't keep this ?
        , span{getspan(ihi,ilo)}
        , sz(1), pos(pos) {
            for(unsigned d=0U; d<dim; ++d) {
                //span[d] =  ihi[d] - ilo[d]; 
                sz *= ihi[d] - ilo[d];
            }
#ifndef NDEBUG
            for(unsigned d=0U; d<dim; ++d) assert( ihi[d] >= ilo[d] );
            // Following might be intentional, so not an error:
            //if (sz == 0) printf("Warning: zero-size CoordsVP3\n");
#endif
            init(pos); // expect pos=0
        }

    Base const& base() const { return *this; }
    operator bool() const { return vl > 0; }
    operator ++() { this->step(); return *this; }

    /// If get_vl(), then we have something in this->vp to process.
    /// Use `step()` which returns true and next batch (or false).
    unsigned get_vl()  const {return vl;}
    unsigned get_dim() const {return dim;}
    std::array<Crd,dim> const& get_lo() const { return ilo; }
    std::array<Crd,dim> const& get_hi() const { return ihi; }
    // unchecked lo for loop limit
    //Crd get_lo(unsigned const d)  const { return ilo[d]; }
    //Crd get_hi(unsigned const d)  const { return ihi[d]; }
    /** init at linear iter pos, shorten vl from MaxVl if pos+vl "past end".
     * Produces coord vectors in nested-for-loop-order.
     * Note diff with off_l_vec API where a vector of `lin` values are input.
     * \return true iff remaining iteration length vl > 0.
     */
    bool init(Pos lin){
        if(lin >= sz){
            //cout<<" lin="<<lin<<" > sz="<<sz<<endl;
            pos = sz;
            vl = 0;
            return false;
        }
        pos = lin;
        vl = MVL;
        if(pos + vl > sz){
            //cout<<" [pos+vl="<<pos<<"+"<<vl<<"] > [sz="<<sz<<"]"<<endl;
            vl = sz - pos;
        }
        assert( vl > 0 );
        Pos carry[Base::MaxVl]; VREG(carry); // it would be nice if this forced tmp vec reg!
        for(unsigned i=0U; i<vl; ++i)
            carry[i] = pos+i;
        NOVEC_ for(unsigned d = dim; d--; ) {
            auto const span = ihi[d] - ilo[d];
            for(unsigned i=0U; i<vl; ++i){
                (this->vp)[d][i] = ilo[d] + carry[i] % span;
                carry[i] = carry[i] / span;
            }
        }
        return true;
    }
    /** set next coord vectors at linear pos+vl.
     * \return true iff remaining iteration lenght vl > 0 */
    bool step(){
#ifndef NDEBUG
        if (pos < sz ) assert( vl > 0 );
#endif
        return pos < sz? init(pos + vl): false;
    }
    /** Maybe "extend" at linear iter pos, increasing existing vl up to MVL.
     * Keeps old set of vl coords. Possible to extend by zero new coords if vl==MVL already!
     * Check that `vl+sz<=MVL` if you need all coords to fit with no `step`.
     * \b Untested.
     * \return true iff some coords were be added.
     *
     * Idea: in some cases you might 'pack' sets of loops into a longer vector?
     * Problem: How to efficiently unpack/mask the sets later.
     */
    bool extend(Pos lin){
        if(lin >= sz || vl >= MVL){
            return false;
        }
        pos = lin;
        auto addvl = sz - lin;
        assert( addvl > 0 );
        if (vl + addvl >= MVL) addvl = MVL - vl;
        for(unsigned i=0U; i<addvl; ++i){
            uint64_t carry = pos+i;
            uint64_t mod;
            for(unsigned d = dim; d--; ) {
                auto const span = ihi[d] - ilo[d];
                mod   = carry % span;
                carry = carry / span;
                vp[d][vl+i] = ilo[d] + mod;
            }
        }
        vl += addvl;
        return true;
    }
    public:
    /** terse output of current 'vp' coordinate vectors. */
    std::string coord_str(char const* pfx="crd") {
        std::ostringstream oss;
        auto const& c = base();
        oss<<pfx<<"["<<dim<<"][vl="<<vl<<"]~{";
        for(unsigned v=0; v<vl; ++v){
            if(v < 5 || v > vl - 5){
                oss<<(v>0? ",":"")<<"{";
                for(unsigned d=0; d<dim; ++d){
                    oss<<(d>0? ",":"")<<c.vp[d][v];
                }
                oss<<"}";
            }else if(v==5) oss<<"...";
        }
        oss<<"}";
        return oss.str();
    }
    private:
    //unsigned dim;               ///< 0..DNNL_MAX_NDIMS
    unsigned vl;                ///< 0..MVL
    std::array<Crd,dim> ilo;
    std::array<Crd,dim> ihi;
    std::array<Crd,dim> span;
    Pos sz; // product of ihi-ilo for 0..dim-1
    Pos pos;
};


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
        CoordsVP c(3,8); // 3 dimensions, 8 coords
        cout<<"init CoordsVP: "<<c<<endl;
        c.iter_init_1d(0,5);
        cout<<"      1d(0,5): "<<c<<endl;
        c.iter_init_2d(0,2,0,3);
        cout<<"  2d(0,2,0,3): "<<c<<endl;
        cout<<"--- fancier iter ---"<<endl;
        bool ret;
        c.iter_init_1d(0,0,10);
#define iter_step_nd iter_step_nd
//#define iter_step_nd iter_step_1d/*educational version*/
        cout<<"    1d(0,0,10): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_1d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        ret = c.iter_init_1d(1,0,10);
        cout<<"    1d(1,0,10): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_1d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        ret = c.iter_init_1d(2,0,10);
        cout<<"    1d(2,0,10): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_1d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        c.iter_init_1d(-1,0,10);
        cout<<"    1d(-1,0,10): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_1d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        c.iter_init_1d(10,0,10);
        cout<<"    1d(10,0,10): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_1d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        c.iter_init_1d(11,0,10);
        cout<<"    1d(11,0,10): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_1d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        cout<<"--- fancier iter 2d ---"<<endl;
#undef iter_step_nd

#define iter_step_nd iter_step_nd
//#define iter_step_nd iter_step_2d/*educational version*/
        c.iter_init_2d(0,0,4,0,3);
        cout<<"    2d(0,0,4,0,3): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_2d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        ret = c.iter_init_2d(1,0,4,0,3);
        cout<<"    2d(1,0,4,0,3): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_2d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        ret = c.iter_init_2d(2,0,4,0,3);
        cout<<"    2d(2,0,4,0,3): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_2d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        ret = c.iter_init_2d(10,0,4,0,3);
        cout<<"    2d(10,0,4,0,3): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_2d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
        ret = c.iter_init_2d(12,0,4,0,3);
        cout<<"    2d(12,0,4,0,3): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_2d())) cout<<"          step: "<<c<<" ret "<<ret<<endl;
#undef iter_step_nd

        cout<<"--- nd templates ---"<<endl;
        ret = c.iter_init(1,0,4,0,3,0,2);
        cout<<"    nd(1,0,4,0,3,0,2): "<<c<<" ret "<<ret<<endl;
        while((ret=c.iter_step_nd())) cout<<"          step: "<<c<<" ret "<<ret<<endl;

        cout<<"... productions version, CoordsVP2 ..."<<endl;
        for(auto c = CoordsVP2<>::mk(0,4,0,3,0,2); c; ++c){
            //cout<<IoVp<decltype(c)>{c}<<endl;
            // more flexible:
            cout<<c.coord_str("c")<<endl;
        }


        cout<<"... productions version, CoordsVP3 ..."<<endl;
    // now just for(auto c = CoordsVP3({0,0,0},{4,3,2}); c; ++c) f(c.vp);
        { 
            auto c = CoordsVP3<3>{{0,0,0},{4,3,2}};
            cout<<c.coord_str("freshly constructed")<<endl;;
        }
        for(auto c = CoordsVP3<3>{{0,0,0},{4,3,2}}; c; ++c){
            cout<<c.coord_str("c")<<endl;
        }
    }
    cout<<"\nGoodbye"<<endl;
    return 0;
}
// vim: et ts=2 sw=2 cindent nopaste ai cino=^=l0,\:0,N-s
