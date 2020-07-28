/*******************************************************************************
* Copyright 2016-2020 Intel Corporation, 2020 NEC Labs America
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

#ifndef COMMON_MEMORY_DESC_WRAPPER_OPT_HPP
#define COMMON_MEMORY_DESC_WRAPPER_OPT_HPP

#include <array>

#include "common/memory_desc_wrapper.hpp"
#include "common/dnnl_optimize.h" // VREG, ...
#include <sstream>
#ifndef NDEBUG
#include <iostream>
#endif

namespace dnnl {
namespace impl {

#ifndef MVL
#if defined(__ve)
#define MVL 256
#else // x86?
#define MVL 32
#endif
#endif

#if defined(__ve)
#define NOVEC_ _Pragma("_NEC novector")
#define VEC_ _Pragma("_NEC vector")
#else
#define NOVEC_
#define VEC_
#endif


/** memory-backed replacement for <TT>a set of vector registers</TT>.
 *
 * In assembler, this would be a set of vector registers where dim-wise
 * vectors could be selected by the VIDX register.
 *
 * In C++, these may still generate vector-load vector-store at entry/end
 * of code blocks. nc++ support for the old SX vreg/alloc_on_vreg
 * pragmas seems to have slipped.
 *
 * We use \c unsigned by default because many of the 'modulo' and 'division'
 * algs break with \c C rounding conventions.  "Arithmetic rounding"
 * (round toward -inf) is suitable for signed tensor indexing calcs.
 * OneDNN tends to use 'int', which will behave unexpectedly when
 * offsets/indices are negative.  OTOH, using \c int allows easy reverse
 * loops, like `for(int i=3; i>=0; --i);`.
 *
 * Choose \c Crd to match your arithmetic requirements.  Even if 32-bit might
 * suffice, Crd=uint64_t may reduce 32-to-64-bit conversions in inner loops.
 */
template<typename Crd = unsigned, unsigned MaxDims = DNNL_MAX_NDIMS>
struct CoordRegs {
    static constexpr unsigned MaxVl = MVL;
    static constexpr unsigned nd = MaxDims; // useful if "exactly sized" at compile time
    Crd vp[MaxDims][MaxVl];
};

/** Compile-time dim helper to produce coordinate vectors of compile-time
 * dimension.  This can represent vectors of coords produced from nested
 * for loops, batched to fit into your SIMD vector length.
 *
 * - init with arrays of lo[dim], hi[dim] nested-for-loop-limits
 * - produces batches of for-loop-coordinate "vectors" sized to
 *   fit in your SIMD length.
 * - can use '++' and 'operator bool' to produce all the simd-batched
 *   coords that the for loop would cover, in for loop order
 *
 * - intended as a use for physical-offset calculation to streamline
 *   memory_desc_wrapper_opt conversion of logical coords to physical
 *   offset (repecting complex memory blockings/padding).
 * - "logical" outputs are fully independent of any particular memory layout.
 *
 * Example:
 *
 * Representing ordering of `for(0..4) for(0..3) for(0..2)`,
 * ```
 * for(auto c = CoordsFor<3>{{0,0,0},{4,3,2}}; c; ++c)
 *     cout<<c.coord_str("c")<<endl;
 * ```
 * would, if your simd length were 7, produce coordinate output:
 * ```
 * c[3][vl=7]~{{0,0,0},{0,0,1},{0,1,0},{0,1,1},{0,2,0},{0,2,1},{1,0,0}}
 * c[3][vl=7]~{{1,0,1},{1,1,0},{1,1,1},{1,2,0},{1,2,1},{2,0,0},{2,0,1}}
 * c[3][vl=7]~{{2,1,0},{2,1,1},{2,2,0},{2,2,1},{3,0,0},{3,0,1},{3,1,0}}
 * c[3][vl=3]~{{3,1,1},{3,2,0},{3,2,1}}
 * ```
 * Memory order is transpose of coord-view printout, so initial c.vp[0] is
 * 7 contiguous values, {0,0,0,0,0,0,1}, six (3*2) zeros, then one.
 *
 * - Unfortunately, nc++ might not optimize away the memory and use
 * vector registers, as you would naturally do in JIT (or if vreg or
 * alloc_on_vreg pragmas worked).
 *
 * - also have runtime 'dim' version in dev/, if nec.
 */
template<unsigned dim, typename Crd = unsigned, typename Pos=size_t>
struct CoordsFor : public CoordRegs<Crd,dim> {
    typedef CoordRegs<Crd,dim> Base;
    typedef CoordsFor<dim,Crd,Pos> MyType;
    typedef Crd crd_t;
    typedef Pos pos_t;
    private:
    static typename std::array<Crd,dim> getspan(std::array<Crd,dim>& h, std::array<Crd,dim>& l) {
        static_assert( dim <= DNNL_MAX_NDIMS, "CoordsFor dimension unexpectedly large" );
        std::array<Crd,dim> ret;
        for(unsigned d=0U; d<dim; ++d) {
            ret[d] = h[d] - l[d];
        }
        return ret;
    }
    public:
    /// General constructor
    CoordsFor( std::array<Crd,dim>&& lo, std::array<Crd,dim>&& hi, size_t pos=0 )
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
            //std::cout<<" +CoordsFor "<<this->lim_str()<<std::endl;
        }

    // easy access to base().vp, for invoking memory_desc_wrapper_opt::vec_off_v,
    // which can bow be made a public member (with a few mods)
    Base const& base() const { return *this; }

    /// allow syntax `for(auto CoordsFor<2> c({h_st,w_st},{h_en,w_en}); c; ++c){}`
    /// VE: this might not be inlined, sometimes  (check .L diagnostics)
    operator bool() const { return vl > 0; }
    MyType& operator ++() { this->step(); return *this; }

    /// If get_vl(), then we have something in this->vp to process.
    /// Use `step()` which returns true and next batch (or false).
    unsigned get_vl()  const {return vl;}
    /// how many coords implied by for-loop limits?
    Pos get_sz()  const {return sz;}
    /// Within \c sz, at simd batch [pos..po+vl-1] are we at?
    Pos get_pos()  const {return pos;}
    /// In this class, `dim` is a compile-time template param
    unsigned constexpr get_dim() const {return dim;}
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
    /** unchecked */
    bool init(Pos start, Pos end) {
        assert( start <= end && end <= sz );
        sz = end;
        return init(start);
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
                (this->vp)[d][vl+i] = ilo[d] + mod;
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
    std::string lim_str(char const* pfx="CoordsFor") {
        std::ostringstream oss;
        oss<<pfx<<"[dim="<<dim<<"][vl="<<vl<<"]";
        for(unsigned d=0U; d<dim; ++d)
            oss<<",["<<ilo[d]<<","<<ihi[d]<<")";
        oss<<",pos="<<pos<<",sz="<<sz<<",vl="<<vl<<"}";
        return oss.str();
    }
    private: // VE: get_vl() was not inlining ???
    //unsigned dim;               ///< 0..DNNL_MAX_NDIMS
    unsigned vl;                ///< 0..MVL
    private:
    std::array<Crd,dim> ilo;
    std::array<Crd,dim> ihi;
    std::array<Crd,dim> span;
    Pos sz; // product of ihi-ilo for 0..dim-1
    Pos pos;
};

/** While \c CoordsFor has compile-time dim, \c CoordsForNd has runtime dim
 *
 * Example: 6 max dims, runtime dimensions like `for(0..4) for(0..3) for(0..2)`
 * ```
 * for(auto c = CoordsForNd<6,uint64_t,uint64_t>::mk(0,4,0,3,0,2); c; ++c)
 *     cout<<c.coord_str("CoordsForNd batch");
 * ```
 * As above, \c cf.vp type will be compatible with
 * \c memory_desc_wrapper_opt::VecPos
 */
template<unsigned MaxDims=DNNL_MAX_NDIMS, typename Crd = unsigned, typename Pos=size_t>
struct CoordsForNd : public CoordRegs<Crd,MaxDims> {
#define COORDSFORND_EXTEND 0 /*experimental feature, useless? */
    typedef CoordRegs<Crd,MaxDims> Base;
    typedef CoordsForNd<MaxDims,Crd,Pos> MyType;
    typedef Crd crd_t;
    typedef Pos pos_t;
    CoordsForNd() : dim(0), vl(0), ilo{0}, ihi{0}, sz(0), pos(0) {
        assert( dim <= MaxDims );
        static_assert(MaxDims <= DNNL_MAX_NDIMS, "unexpectedly large number dims");
    }
    // iter 0..dims[i] for 0<=i<nelems
    template<typename DIM_T, typename NDIMS_T>
    CoordsForNd(DIM_T const* d,  NDIMS_T const nd)
    : dim(nd), vl(0), ilo{0}, ihi{0}, sz(0), pos(0) {
        assert( nd <= MaxDims );
        static_assert(MaxDims <= DNNL_MAX_NDIMS, "unexpectedly large number dims");
        sz = Pos{1};
        ShortLoop() for(int i=0; i<dim; ++i){
            ilo[i] = Crd{0};
            ihi[i] = d[i];
            sz *= d[i];
        }
        // streamline generic init_nd code for pos=0, ilo[i]=0
        // pos = 0;
        vl = MVL;
        if(pos + vl > sz) vl = sz - pos;
        Pos carry[Base::MaxVl]; VREG(carry)
        ShortLoop() for(unsigned i=0U; i<vl; ++i)
            carry[i] = /*pos+*/ i;
        NOVEC_ for(unsigned d = dim; d--; ) {
            // TBD decide whether span is member or not XXX
            auto const span = ihi[d]; // - ilo[d];
            if(span <= 1){
                ShortLoop() for(unsigned i=0U; i<vl; ++i){ // VRspill
                    (this->vp)[d][i] = 0; //ilo[d];
                }
            } else {
                for(unsigned i=0U; i<vl; ++i){
                    (this->vp)[d][i] = /*ilo[d] +*/ carry[i] % span;
                    carry[i] = carry[i] / span;
                }
            }
        }
    }
    template<typename DIM_T, typename NDIMS_T>
    CoordsForNd(DIM_T const* d,  NDIMS_T const nd, Pos const start)
    : dim(nd), vl(0), ilo{0}, ihi{0}, sz(0), pos(0) {
        assert( nd <= MaxDims );
        static_assert(MaxDims <= DNNL_MAX_NDIMS, "unexpectedly large number dims");
        sz = Pos{1};
        ShortLoop() for(int i=0; i<dim; ++i){
            ilo[i] = Crd{0};
            ihi[i] = d[i];
            sz *= d[i];
        }
        this->init_nd(start);
    }
    template<typename DIM_T, typename NDIMS_T>
    CoordsForNd(DIM_T const* d,  NDIMS_T const nd, Pos const start, Pos const end)
    : dim(nd), vl(0), ilo{0}, ihi{0}, sz(0), pos(0) {
        assert( nd <= MaxDims );
        static_assert(MaxDims <= DNNL_MAX_NDIMS, "unexpectedly large number dims");
        sz = Pos{1};
        ShortLoop() for(int i=0; i<dim; ++i){
            ilo[i] = Crd{0};
            ihi[i] = d[i];
            sz *= d[i];
        }
        this->init_nd(start,end);
    }

    Base /* */& base() /* */ { return *this; }
    Base const& base() const { return *this; }
    operator bool() const { return vl > 0; }
    MyType& operator ++() { this->step(); return *this; }
    /// If get_vl(), then we have something in this->vp to process.
    /// Use `step()` which returns true and next batch (or false).
    unsigned get_vl()  const {return vl;}
    unsigned get_dim() const {return dim;}
    Pos get_sz() const {return sz;}
    Pos get_pos() const {return pos;}
    // TODO ex. if dim = 3: ((dim_t)(od-d_st) * (h_en-h_st) + (oh-h_st)) * (w_en-w_st) + (ow-w_st);
    // template<typename Coords...> Coords::pos_t pos_of(...) {...};
    /// unchecked lo for loop limit
    Crd get_lo(unsigned const dim)  const { return ilo[dim]; }
    Crd get_hi(unsigned const dim)  const { return ihi[dim]; }
    //int constexpr MVL = 32;
    private:
    unsigned dim;               ///< 0..DNNL_MAX_NDIMS
    public: // get_vl() sometimes was "vectorization obstuructive" ?
    unsigned vl;                ///< 0..MVL
    private:
    // now add "vl-wise" iteration:
    Crd ilo[MaxDims];
    Crd ihi[MaxDims];
    Pos sz; // product of ihi-ilo for 0..dim-1
    Pos pos;
    public:
    /** init at linear iter pos, shorten vl from MVL iif pos+vl "past end"
     * Note diff with off_l_vec API where a vector of `lin` values are input
     *
     * - input: dim, ilo[], ihi[], sz
     * - set up: pos, vp
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
     * - CoordsForNd<DIM_T,NDIMS_T> x(DIM_T const* d, NDIMS_T const nd) or other constructor
     *   - or auto cf = CoordsForNd<6>.mk(lo0,hi0,...) (up to 6 lo0,hi0 coords)
     * - x.init(Pos lin)
     *   - or x.init(Pos start, Pos end)
     *   - or x.init(vec_off_loops(l0,h0, l1,h1, ...) where every dim gets lo,hi args
     *   - or x.init_at(pos, lo0,hi0, lo1,hi1, ...)
     *   - or x.init_at(lo0,hi0, lo1,hi1, ...) (init at Pos 0);
     *   - `init` internally generate a CoordsVP, 1 vector register per coordinate
     * - `(bool)x` Does x have any more coords?
     * - `x.step()` generate next set of coordsVP, ret false if done
     *   - or `++x` if you don't need bool ret val (as in for loop)
     *
     * - x.vl is current vector length of each x.vp[0..get_dim()-1)][x.vl]
     * - x.pos goes from 0 to x.get_sz() = product of each hi_i-lo_i.
     *
     * streamlined API (ignore bool ip=is_pos_padded?)
     * - vec_off_iter( void(*f)(VecPos&), ip?, l0,h0, l1,h1, ...)
     *   - call "vector-of-coords" function f in simd-len batches
     * - vec_off_iter( void(*f)(uint32_t), ip?, l0,h0, l1,h1, ...)
     *   - call "global-physical-offset" function g in simd-len batches
     *   - internally call vec_off_v to get physical offsets
     */
    bool init_nd(Pos lin){
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
        Pos carry[Base::MaxVl]; VREG(carry)
        for(unsigned i=0U; i<vl; ++i) // VRspill
            carry[i] = pos+i;
        NOVEC_ for(unsigned d = dim; d--; ) {
            // TBD decide whether span is member or not XXX
            auto const span = ihi[d] - ilo[d];
            if(span <= 1){
                ShortLoop() for(unsigned i=0U; i<vl; ++i){ // VRspill
                    (this->vp)[d][i] = ilo[d];
                }
            } else {
                for(unsigned i=0U; i<vl; ++i){
                    (this->vp)[d][i] = ilo[d] + carry[i] % span;
                    carry[i] = carry[i] / span;
                }
            }
        }
        return true;
    }
    /** when parallelized over linear nelems, from 'start' to 'end-1',
     * generate coords by lowering linear 'sz' to 'end'.
     * \pre end <= get_sz() and 0<=start<end.
     * \return true if successful. */
    bool init_nd(Pos start, Pos end){
        assert( end <= sz ); // maybe always check?
        sz = end;
        return init_nd(start);
    }
    private:
#if COORDSFORND_EXTEND
    /** Maybe "extend" at linear iter pos, increasing existing vl up to MVL.
     * Keeps old set of vl coords. Possible to extend by zero new coords if vl==MVL already!
     * Check that `vl+sz<=MVL` if you need all coords to fit with no `step`.
     * \b Untested.
     * \return true iff some coords were be added.
     *
     * Idea: in some cases you might 'pack' sets of loops into a longer vector?
     * Problem: How to efficiently unpack/mask the sets later.
     * Problem: Also needs a setter for new ilo,ihi loop limits, ... extend_at
     */
    bool extend_at(Pos lin){
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
                (this->vp)[d][vl+i] = ilo[d] + mod;
            }
        }
        vl += addvl;
        return true;
    }
#endif // COORDSFORND_EXTEND
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
            return iter_range(d+1U, utils::forward<Args>(tuple)...);
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
            ShortLoop() for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d]; // VRrestore!
#if 0
            cout<<" init_at dim="<<dim;
            for(int d=0; d<dim; ++d){
                cout<<" ["<<ilo[d]<<","<<ihi[d]<<")";
            }
            cout<<" sz="<<sz<<" pos="<<pos<<endl;
#endif
            // calc first batch of coord vectors, ret true if have some
            return init_nd(pos);
        }
    /** init_at(0,lohi...) */
    template<typename... Args>
        inline bool init(Args &&... lohi) {
            return this->init_at( size_t{0}, utils::forward<Args>(lohi)...);
        }
    /** set next coord vectors at linear pos+vl.
     * \return true iff remaining iteration lenght vl > 0 */
    bool step(){
#ifndef NDEBUG
        if (pos < sz ) assert( vl > 0 );
#endif
        return pos < sz? init_nd(pos + vl): false;
    }
#if COORDSFORND_EXTEND
    /** extend(lohi...) */
    template<typename... Args>
        inline bool extend(Args &&... lohi) {
            auto old_dim = dim; // error if changed: revert to 'init' behavior
            this->iter_range(0, utils::forward<Args>(lohi)...);
            // calc total size (could be done within iter_range?)
            sz = Pos{1};
            for(unsigned d=0U; d<dim; ++d) sz *= ihi[d] - ilo[d];
            if (dim != old_dim) {
                printf(" warning: extend changed dimension -- treated as init\n");
                return init(0);
            }
            return extend_at(pos);
        }
#endif // COORDSFORND_EXTEND
    /** intended syntax --
     * for(auto c = CoordsForNd::mk(0,4,0,3,0,2); c; ++c) f(c.vp); */
    template<typename... Args>
    static CoordsForNd mk(Args &&... lohi){
        CoordsForNd ret;
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
        oss<<"}";
        return oss.str();
    }
    std::string lim_str(char const* pfx="CoordsForNd") {
        std::ostringstream oss;
        oss<<pfx<<"[dim="<<dim<<"][vl="<<vl<<"]";
        for(unsigned d=0U; d<dim; ++d)
            oss<<",["<<ilo[d]<<","<<ihi[d]<<")";
        oss<<",pos="<<pos<<",sz="<<sz<<",vl="<<vl<<"}";
        return oss.str();
    }
};


/** for VE vectorization [or scalar] */
// customize options for off_l and off_v
#define VEC 0 // allow vectorization over dims_t[], for scalar off_*

// fast-division option -- need to see if it is a real speedup
//  -- removed -- see memory_desc_wrapper_opt_dev.* to try it

//#define FD_VEC 0   /* try vectorizing fastdiv for vec_off_l routines */
// results: for 'noff' in vec_off_l <= 256, fastdiv is bad. (tried it in VEC_U32 section)
//          for vec_off_l >= 512, small improvement (not worth additional complexity)
// ** at best ** 4% speedup, but can be quite bad.
// LEAVE THIS OFF

#define VEC_U32 0 // check for u32 arithmetic in vec_off_* routines
// results: on VE, u32 and u64 arithmetic is essentially same speed
// maybe slightly good, but need to run benchdnn performace mode

#if 0
--softmax --axis=0 256x5555 (or 2560x555)
VEC     OFF_V   OFF_L   VOS     time    u64     vec_off(1)    | orig(*) 
0       0       0       0       365                           |  
0       0       0       1       365 --> 209 --> 8             | 1500
1       0       0       0       380                           |
1       0       0       1       380 --> 366                   |
0       1       0       0       455                           |
0       1       0       1       361 --> 231 -->               | 747
1       1       0       0       376                           |
1       1       0       1       349 --> 350                   |
(*) orig: set VE_FWD_GEN=0 in ref_softmax.cpp
(1) vec_off: set VECTOR_OFFSET_CALC* to 1 in ref_softmax.cpp
#endif

/** If the purpose of memory_desc_wrapper is to calculate offsets, this
 * optimization tries to speed up calls to `off_l` and `off_v`.
 *
 * On VE, when we have u64 / u32 division, we can replace `operator /` with a
 * faster unsigned multiply-add-shift sequence.
 *
 * - Assumption:
 *   - offset calculations actually can be done with \e unsigned division,
 *     i.e. `dims_t pos` values are >= 0.  I believe all the quantities
 *     for offset calculations are positive.  This is not true in other
 *     contexts (like convolution offsets, which must handle -ve values).
 * - Tradeoffs wrt memory_desc_wrapper:
 *   - Increased construction time \e once
 *   - Faster off_v (off_l) for non-huge tensors \e many times
 *
 * \note Use this object locally, as it redefines non-virtual base functions
 *
 * \note \b VE is \b limiting fastdiv to u32/u32 because we cannot get the
 *       high bits of u64 multiply.  But \b x86 can, and \e should extend
 *       fastdiv for u64/u32 (or u64/u64, if easier)
 *
 * \sa ve_fastdiv.h
 */
struct memory_desc_wrapper_opt : public memory_desc_wrapper {

    /** constructor which takes a reference to a constant underlying C memory
     * descriptor \param md */
    memory_desc_wrapper_opt(const memory_desc_t *md);
    memory_desc_wrapper_opt(const memory_desc_t &md);

    /** For efficiency, use VecPos so as to avoid 32-to-64-bit
     * conversion instructions during the address calculations.
     * \note VecPos32 would always suffice, with minimum memory.
     *
     * In principle we could have \b DNNL_MAX_NDIMS, but we actually
     * know that memory descriptors only use up to \b six coordinates
     * TODO \b six --> something like DNNL_MAX_MEMORY_DESC_DIMS ?
     *
     * \note twelve exactly allows for blocked versions of six-nested loops,
     * but we don't have such need in this class.  Is it an unspoken truth
     * that DNNL_MAX_MEMORY_DESC_DIMS will always be DNNL_MAX_NDIMS / 2?
     *
     * What's the current fmt (tag?) --> ndims mechanism?
     */
    using VecPos = CoordRegs<uint64_t, 6>;
    using VecPos32 = CoordRegs<uint32_t, 6>;
#if 0
    /** vec_off_l uses a work area to pass "as-if-dense" coords to vec_off_v.
     * Potentially could be a set of vector registers.
     * (Or just call vec_off_v directly if modified and made public) */
    struct VecPos {
        uint64_t vp[DNNL_MAX_NDIMS][MVL];
    };
    struct VecPos32 {
        // can VE use packed reg [2*MVL] ?
        //     NO! packed int reg ops NOT available
        uint32_t vp[DNNL_MAX_NDIMS][MVL];
    };
#endif

public: // fastdiv support (experimental)
    // optimize divisions by inner_block sizes, blk.inner_blks[iblk]

    // scalar version;  vector of structs might be better
    //struct Magic { uint64_t mul, add, shr, div; };
    struct Magic { uint64_t mul; uint32_t add; uint32_t shr; uint32_t div; };
    typedef std::array<Magic, DNNL_MAX_NDIMS> DimsFastDiv;

    // struct-of-vecs, for vec_off_* routines
    struct DimsFastDivVec {
        // VE should use uint64_t for all fastdiv ops ?
        uint64_t mul[DNNL_MAX_NDIMS];
        uint32_t add[DNNL_MAX_NDIMS];
        uint32_t shr[DNNL_MAX_NDIMS];
        uint32_t div[DNNL_MAX_NDIMS];
    };

private:
    /** scalar loops might toy with this fastdiv, which has a
     * small amount of vectorization over [< ~6] "dimension".
     */
    static DimsFastDiv init_fastdiv(dims_t const divisors, int const len);
    /** Initially tried fastdiv. but it is not a good use case.
     * - Where it could be good:
     *   a- long list of numerators and scalar divisor
     *   b- long list of varying divisors
     * - we are in case (a), but the magic divisors need loading
     *   and currently scalar : vector ops ratio is bad.
     * - would need inner loops <em>many MVL long</em> to perhaps be useful.
     */
    static DimsFastDivVec init_fastdiv_vec(dims_t const divisors, int const len);

    // opt, in case you need the 32-bit version of an original 64-bit divisor...
    // (also probably avail elsewhere -- choose one or make a helper class if useful)
    static inline constexpr uint32_t fdivisor(DimsFastDiv const& fd, int const d){
        return fd[d].div;
    }
    static inline constexpr uint32_t fdivisor(DimsFastDivVec const& fd, int const d){
        return fd.div[d];
    }

    friend constexpr uint64_t operator/(uint64_t top, memory_desc_wrapper_opt::Magic const& m);

    /** optimize u32/u32 division (ex by inner_block sizes, blk.inner_blks[iblk]).
     * \ret top / "divisor[d]" u32/u32 division via mul-add-shr, as ra 64-bit result. */
    template<typename INT>
    static inline constexpr uint64_t fdiv(INT const top, DimsFastDiv const& fd, int const d){
        return top / fd[d];
    }
    template<typename INT>
    static inline constexpr uint64_t fdiv(INT const top, DimsFastDivVec const& fd, int const d){
        return ((uint64_t)top * fd.mul[d] + fd.add[d]) >> fd.shr[d];
    }

public:

    /* vectorized offset section : additional API functions */

    void vec_off_l(dim_t const* const l_offsets, ///< vector of logical offsets [noff]
                   int const noff,               ///< any value OK (>1 beneficial on VE)
                   dim_t * p_offsets,            ///< output: physical offsets [noff]
                   bool is_pos_padded = false) const {
        assert(is_blocking_desc());
#define SHORT_ _Pragma("_NEC vector") _Pragma("_NEC shortloop") _Pragma("_NEC assume")
#ifndef NDEBUG
        // negative and out-of-bounds input l_offsets create nonsense outputs
        SHORT_ for(int i=0;i<noff;++i) {
               assert( l_offsets[i] >= 0 );
               //assert( l_offsets[i] < size_or_padded_size );
        }
#endif
        if (noff <= 1) {
            if (noff == 1) {
                // noff == 1 does not admit vectorization over channels,
                // so use default (might vectorize a little over dims)
                p_offsets[0] = off_l(l_offsets[0]);
                // return;
            }
        } else { // yes, vector routines make sense

            int const nd = ndims();

#if VEC_U32
            if (offsets_u32) {
                const auto dm32  = is_pos_padded ? padded_dims32: dims32;
                VecPos32 vp32; // tmp memory, to transfer vector content to vec_off_v
                // perhaps get rid of this by inlining, using up to 12 vec registers?
                for ( int lb = 0; lb < noff; lb += MVL ) { // XXX sometimes < MVL is faster/ lower latency
                    // vectorize over 'llen'
                    int llen = (noff-lb > MVL? MVL: noff-lb);
                    // load a vector register of logical offset inputs
                    uint32_t off[MVL];
                    _Pragma("_NEC vreg(off)");
                    SHORT_ for(int l=0; l<llen; ++l) off[l] = l_offsets[lb+l]; // VLD
                    // convert to coords [up to 12=DNNL_MAX_NDIMS]
                    NOVEC_ for (int d = 0; d < nd; ++d) { // reverse
                        const int rd = nd - 1 - d;        // dims
                        SHORT_ for(int l=0; l<llen; ++l) {   // l ~ logical offset
                            vp32.vp[rd][l] = off[l] % dm32[rd]; // still div,mul,sub
                            off[l] = off[l] / dm32[rd];         // store vec reg to vp32
                        }
                    }
                    // "dense-layout" coords in vp --> output p_offset
                    vec_off_vtmp(vp32, &p_offsets[lb], llen, is_pos_padded);
                    //      ^^^^  vp32 can be modified (it is temporary)
                }
            } else
#endif // VEC_U32
            {
                const auto dm  = is_pos_padded ? padded_dims(): dims();
                VecPos vp; // tmp memory, to transfer vector content to vec_off_v
                // perhaps get rid of this by inlining, using up to 12 vec registers?
                // based on noff, blocking < MVL? (if fast calc)
                for ( int lb = 0; lb < noff; lb += MVL ) {
                    // vectorize over 'llen'
                    int llen = (noff-lb > MVL? MVL: noff-lb);
                    // load a vector register of logical offset inputs
                    uint64_t off[MVL];
                    _Pragma("_NEC vreg(off)");
                    SHORT_ for(int l=0; l<llen; ++l) off[l] = l_offsets[lb+l];
                    // convert to coords [up to 12=DNNL_MAX_NDIMS]
                    NOVEC_ for (int d = 0; d < nd; ++d) {
                        const int rd = nd - 1 - d;          // reverse
                        // this loop vectorizes well, albeit u64 ops
                        SHORT_ for(int l=0; l<llen; ++l) { // l ~ logical offset
                            vp.vp[rd][l] = off[l] % dm[rd]; // does the right thing (div,mul,sub)
                            off[l] = off[l] / dm[rd];       // store vec reg to vp
                        }
                    }
                    // "dense-layout" coords in vp --> output p_offset
                    vec_off_vtmp(vp, &p_offsets[lb], llen, is_pos_padded);
                    //      ^^^^  vp32 can be modified (it is temporary)
                }
            }
#undef SHORT_
        }
        return;
    }
public:
    /** vector-of-physical-offsets version of \c off_v.
     * Now that we're public, \c vp_in is \c const.
     *
     * \note This only does a MVL-long section at a time
     * \note if is_pos_padded or inner_nblks, coords \c vp may be modified.
     *
     */
    void vec_off_v( VecPos const& vp_in,    // list of coords (from vec_off_l)
                      dim_t * p_offsets, // output physical offsets
                      int const noff,    // how many offsets in vp and p_offsets
                      bool is_pos_padded = false) const {
        assert(noff <= MVL);
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#if 0 && !defined(NDEBUG)
        unsigned nsame=0U;
        for (int i=0; i<blk.inner_nblks; ++i) {
            for (int j=i+1; j<blk.inner_nblks; ++j) {
                if (blk.inner_idxs[i] == blk.inner_idxs[j])
                    ++nsame;
            }
        }
        assert( nsame == 0U ); // inner_idxs[] MUST be distinct
#endif

#define Short_ PragmaQuote(_NEC vector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        assert( nd < 6 );
        VecPos vp;
        if (is_pos_padded) {
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp.vp[d][l] = vp_in.vp[d][l] + padded_offsets()[d];
               }
            }
        }else{
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp.vp[d][l] = vp_in.vp[d][l];
               }
            }
        }

        // phys[] : a vreg mirror of p_offsets[noff] output, until final vector store
        uint64_t phys[MVL];
        _Pragma("_NEC vreg(phys)")
        for(int l=0; l<noff; ++l)
            phys[l] = offset0();

        if (blk.inner_nblks > 0) {
            // Note: have a better VEC_U32 choice made in vec_off_l
            NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                VEC_ for(int l=0; l<noff; ++l) {
                    uint64_t const p = vp.vp[d][l] % (uint64_t)blk.inner_blks[iblk];
                    vp.vp[d][l] /= (uint64_t)blk.inner_blks[iblk];
                    phys[l] += p * ib_strides[iblk];
                }
            }
        }

        NOVEC_ for (int d = 0; d < nd; ++d) {
            uint64_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<noff; ++l) tmp[l] = vp.vp[d][l]; // VLD (nec.?)
            VEC_ for(int l=0; l<noff; ++l) {
                phys[l] += tmp[l] * (uint64_t)blk.strides[d];     // VMUL,VADD (extra vcopy)
            }
        }

        Short_ for(int l=0; l<noff; ++l)
            p_offsets[l] = phys[l]; // final vector store VST to output
#undef Short_
    }
public:
    /** vector-of-physical-offsets version of \c off_v.
     * Unlike \c off_v or \c vec_off_v, we may \e modify
     * our coords \c vp, to save memory.  This is a good option for
     * CoordsFor iteration, where '++' recalculates on basis of
     * linear pos and won't be confused if vp[][] data changes.
     *
     * \note This only does a MVL-long section at a time
     * \note if is_pos_padded or inner_nblks, coords \c vp may be modified.
     */
    void vec_off_vtmp( VecPos & vp,    // list of coords (from vec_off_l)
                      dim_t * p_offsets, // output physical offsets
                      int const noff,    // how many offsets in vp and p_offsets
                      bool is_pos_padded = false) const {
        assert(noff <= MVL);
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#if 0 && !defined(NDEBUG)
        unsigned nsame=0U;
        for (int i=0; i<blk.inner_nblks; ++i) {
            for (int j=i+1; j<blk.inner_nblks; ++j) {
                if (blk.inner_idxs[i] == blk.inner_idxs[j])
                    ++nsame;
            }
        }
        assert( nsame == 0U ); // inner_idxs[] MUST be distinct
#endif

#define Short_ PragmaQuote(_NEC vector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        assert( nd < 6 );
        if (is_pos_padded) {
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp.vp[d][l] += padded_offsets()[d];
               }
            }
        }

        // phys[] : a vreg mirror of p_offsets[noff] output, until final vector store
        uint64_t phys[MVL];
        _Pragma("_NEC vreg(phys)")
        for(int l=0; l<noff; ++l)
            phys[l] = offset0();

        if (blk.inner_nblks > 0) {
            // Note: have a better VEC_U32 choice made in vec_off_l
            NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                VEC_ for(int l=0; l<noff; ++l) {
                    uint64_t const p = vp.vp[d][l] % (uint64_t)blk.inner_blks[iblk];
                    vp.vp[d][l] /= (uint64_t)blk.inner_blks[iblk];
                    phys[l] += p * ib_strides[iblk];
                }
            }
        }

        NOVEC_ for (int d = 0; d < nd; ++d) {
            uint64_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<noff; ++l) tmp[l] = vp.vp[d][l]; // VLD (nec.?)
            VEC_ for(int l=0; l<noff; ++l) {
                phys[l] += tmp[l] * (uint64_t)blk.strides[d];     // VMUL,VADD (extra vcopy)
            }
        }

        Short_ for(int l=0; l<noff; ++l)
            p_offsets[l] = phys[l]; // final vector store VST to output
#undef Short_
    }

#if VEC_U32
public:
    void vec_off_v( VecPos32 const& vp_in, // list of coords (from vec_off_l)
                      dim_t * p_offsets,  // output physical offsets
                      int const noff,     // how many offsets in vp32 and p_offsets
                      bool is_pos_padded = false) const {
        assert(noff <= MVL);
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#ifndef NDEBUG
        unsigned nsame=0U;
        for (int i=0; i<blk.inner_nblks; ++i) {
            for (int j=i+1; j<blk.inner_nblks; ++j) {
                if (blk.inner_idxs[i] == blk.inner_idxs[j])
                    ++nsame;
            }
        }
        assert( nsame == 0U ); // inner_idxs[] MUST be distinct
#endif

#define Short_ PragmaQuote(_NEC vector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        assert( nd < 6 );
        VecPos32 vp32;
        if (is_pos_padded) {
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp32.vp[d][l] = vp_in.vp[d][l] + padded_offsets()[d];
               }
            }
        }else{
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp32.vp[d][l] = vp_in.vp[d][l];
               }
            }
        }

        //uint64_t phys_offset = offset0();
        // phys[] : vreg mirror of p_offsets[noff] output, until final vector store
        uint64_t phys[MVL];
        _Pragma("_NEC vreg(phys)")
        for(int l=0; l<noff; ++l)
            phys[l] = offset0();

        if (blk.inner_nblks > 0) {
            NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                VEC_ for(int l=0; l<noff; ++l) {
                    // ibs32 ~ blk.inner_blocks
                    uint32_t const p = vp32.vp[d][l] % ibs32[iblk];
                    vp32.vp[d][l] /= ibs32[iblk];
                    phys[l] += p * ib_strides32[iblk];
                }
            }
        }

        NOVEC_ for (int d = 0; d < nd; ++d) {
            uint32_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<noff; ++l) tmp[l] = vp32.vp[d][l]; // need vld??
            VEC_ for(int l=0; l<noff; ++l) {
                // VMUL,VADD (extra vcopy) XXX check for vec reduc?
                phys[l] += tmp[l] * blk_strides32[d];
            }
        }

        Short_ for(int l=0; l<noff; ++l)
            p_offsets[l] = phys[l]; // final vector store VST to output
#undef Short_
    }
public:
    void vec_off_vtmp( VecPos32 & vp32,         // list of coords (from vec_off_l)
                      dim_t * p_offsets, // output physical offsets
                      int const noff,    // how many offsets in vp32 and p_offsets
                      bool is_pos_padded = false) const {
        assert(noff <= MVL);
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#ifndef NDEBUG
        unsigned nsame=0U;
        for (int i=0; i<blk.inner_nblks; ++i) {
            for (int j=i+1; j<blk.inner_nblks; ++j) {
                if (blk.inner_idxs[i] == blk.inner_idxs[j])
                    ++nsame;
            }
        }
        assert( nsame == 0U ); // inner_idxs[] MUST be distinct
#endif

#define Short_ PragmaQuote(_NEC vector) PragmaQuote(_NEC nounroll)
        const int nd = ndims();
        assert( nd < 6 );
        if (is_pos_padded) {
            NOVEC_ ShortLoop() PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(6))//;
            for (int d = 0; d < nd; ++d) {
               VEC_ for(int l = 0; l < noff; ++l) {
                    vp32.vp[d][l] += padded_offsets32[d];
               }
            }
        }

        //uint64_t phys_offset = offset0();
        // phys[] : vreg mirror of p_offsets[noff] output, until final vector store
        uint64_t phys[MVL];
        _Pragma("_NEC vreg(phys)")
        for(int l=0; l<noff; ++l)
            phys[l] = offset0();

        if (blk.inner_nblks > 0) {
            NOVEC_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                VEC_ for(int l=0; l<noff; ++l) {
                    // ibs32 ~ blk.inner_blocks
                    uint32_t const p = vp32.vp[d][l] % ibs32[iblk];
                    vp32.vp[d][l] /= ibs32[iblk];
                    phys[l] += p * ib_strides32[iblk];
                }
            }
        }

        NOVEC_ for (int d = 0; d < nd; ++d) {
            uint32_t tmp[MVL];
            _Pragma("_NEC vreg(tmp)")
            VEC_ for(int l=0; l<noff; ++l) tmp[l] = vp32.vp[d][l]; // need vld??
            VEC_ for(int l=0; l<noff; ++l) {
                // VMUL,VADD (extra vcopy) XXX check for vec reduc?
                phys[l] += tmp[l] * blk_strides32[d];
            }
        }

        Short_ for(int l=0; l<noff; ++l)
            p_offsets[l] = phys[l]; // final vector store VST to output
#undef Short_
    }
#endif // VEC_U32

public:

    /* offset section : REPLACE non-virtual base class versions */

    /** returns physical offset by logical one. logical offset is represented by
     * an array \param pos. if \param is_pos_padded is true \param pos
     * represents the position in already padded area */
    dim_t off_v(const dims_t pos, bool is_pos_padded = false) const {
        assert(is_blocking_desc());
        const blocking_desc_t &blk = blocking_desc();
#if VEC==0
//#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll)
#else // VEC==1
#define Short_ PragmaQuote(_NEC loop_count(6)) IVDEP() ShortLoop()
#endif
        const int nd = ndims();
        uint64_t pos_copy[DNNL_MAX_NDIMS] = {0};
        Short_ for (int d = 0; d < nd; ++d)
            pos_copy[d] = pos[d] + (is_pos_padded ? 0 : padded_offsets()[d]);

        uint64_t phys_offset = offset0();

        if (blk.inner_nblks > 0) {
            Short_ for (int iblk = blk.inner_nblks - 1; iblk >= 0; --iblk) {
                const int d = blk.inner_idxs[iblk];
                uint64_t p;
                if (pos_copy[d] <= UINT32_MAX) {
                    p = (uint32_t)pos_copy[d] % (uint32_t)blk.inner_blks[iblk];
                    pos_copy[d] = (uint32_t)pos_copy[d] / (uint32_t)blk.inner_blks[iblk];
                } else {
                    p = pos_copy[d] % (uint64_t)blk.inner_blks[iblk];
                    pos_copy[d] /= (uint64_t)blk.inner_blks[iblk];
                }
                phys_offset += p * ib_strides[iblk];
            }
        }

        Short_ for (int d = 0; d < nd; ++d) {
            const uint64_t p = pos_copy[d];
            phys_offset += p * (uint64_t)blk.strides[d];
        }
#undef Short_
        return phys_offset;
    }


    bool all_dims_u32(bool const is_pos_padded = false) {
        bool all_u32 = true;
        const auto dm = is_pos_padded ? padded_dims(): dims();
        for (int d = 0; d < ndims(); ++d)
            if( (uint64_t)dm[d] > UINT32_MAX ) all_u32 = false;
        return all_u32;
    }

    dim_t off_l(dim_t l_offset, bool is_pos_padded = false) const {
        assert(is_blocking_desc());
        assert(l_offset >= 0);
        uint64_t pos[DNNL_MAX_NDIMS];

//#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC unroll(6)) PragmaQuote(_NEC loop_count(6))
#define Short_ PragmaQuote(_NEC novector) PragmaQuote(_NEC nounroll) PragmaQuote(_NEC loop_count(4))
        {
            int const nd = ndims();
            const auto dm  = is_pos_padded ? padded_dims(): dims();
            Short_ for (int rd = 0; rd < nd; ++rd) {
                const int d = nd - 1 - rd;
                const dim_t cur_dim = dm[d];
#if 1 // THIS IS GOOD FOR VE TOO XXX check ?
                /* switch to faster 32-bit division when possible. */
                if (l_offset <= INT32_MAX && cur_dim <= INT32_MAX) {
                    pos[d] = (int32_t)l_offset % (int32_t)cur_dim;
                    l_offset = (int32_t)l_offset / (int32_t)cur_dim;
                } else
#endif
                {
                    pos[d] = l_offset % cur_dim;
                    l_offset /= cur_dim;
                }
            }
        }
#undef Short_
        return off_v((dim_t*)pos, is_pos_padded);
    }

    // hide some other base class things (just in case)
    // following call off_v, and we want OUR version to be used:

    /** returns physical offset by logical one. logical offset is represented by
     * a tuple of indices (\param xn, ..., \param x1, \param x0) */
    template <typename... Args>
    dim_t off(Args... args) const {
        assert(sizeof...(args) == ndims());
        dims_t pos = {args...};
        return off_v(pos, false);
    }

    /** returns physical offset by logical one. logical offset is represented by
     * a tuple of indices (\param xn, ..., \param x1, \param x0) in already
     * padded area */
    template <typename... Args>
    dim_t off_padding(Args... args) const {
        assert(sizeof...(args) == ndims());
        dims_t pos = {args...};
        return off_v(pos, true);
    }

private:
    /** inner block strides (and various other) get precalculated */
    void set_ib_info();

    /** precalc inner block strides (load vec once vs inner multiplies) */
    uint64_t ib_strides[DNNL_MAX_NDIMS];

    /** quick test for uint32_t offset arithmetic */
    bool const offsets_u32;
    uint32_t blk_strides32[DNNL_MAX_NDIMS];     ///< blk.strides
    uint32_t padded_offsets32[DNNL_MAX_NDIMS];  ///< if is_pos_padded, padded_offset()[]

#if VEC_U32
    uint32_t ibs32[DNNL_MAX_NDIMS]; ///< inner blocking (always u32)
    uint32_t ib_strides32[DNNL_MAX_NDIMS]; ///< may be u32
#endif
    // all main dims usually, but not always, fit in uint32_t ...
    const bool dims_small;
    const bool padded_dims_small;
#if VEC_U32
    uint32_t padded_dims32[DNNL_MAX_NDIMS];
    uint32_t dims32[DNNL_MAX_NDIMS];
#endif
};

// support functions

inline constexpr uint64_t operator/(uint64_t top, memory_desc_wrapper_opt::Magic const& m){
#if defined(__ve)
    // depends on memory ordering -- this is OK for VE (reduce mem loads)
    uint64_t const xxx = *(uint64_t*)(&m.add);
    return (top * m.mul + (uint64_t)(uint32_t)xxx) >> (xxx>>32);
#else
    return ((top * m.mul + m.add) >> m.shr);
#endif
}

} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
#endif // COMMON_MEMORY_DESC_WRAPPER_OPT_HPP
