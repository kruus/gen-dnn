/*******************************************************************************
* Copyright 2016-2020 Intel Corporation
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

#ifndef VE_REF_CONVOLUTION_UTIL_HPP
#define VE_REF_CONVOLUTION_UTIL_HPP

#include "cpu/ref_convolution.hpp"
#include "cpu/simple_q10n.hpp"

//#include "common/c_types_map.hpp"
//#include "common/dnnl_thread.hpp"
//#include "common/dnnl_traits.hpp"
//#include "common/math_utils.hpp"
//#include "common/type_helpers.hpp"


//#include "cpu/ve/hoist.hpp"     // nc++: hoist linear conditions out of loops

#ifndef NOVEC
#define NOVEC _Pragma("_NEC novector")
#endif

namespace dnnl {
namespace impl {
namespace cpu {

namespace {
//
// remap scalar offset calls uniformly via a 6-arg version.
// Set a function pointer to the "right version".
// Variants differ on which args are ignored before calling
// memory_desc_wrapper::off function
//
// NOT inline because purpose is to call via a fn ptr
// (easier-to-read code)
//
// mdw.off is a slow fn call anyway on VE, that eventually
// might be handled better by vectorizing the offset calc.
//
static inline dim_t offg5d(memory_desc_wrapper const& mdw,
        int const g, int const oc, int const ic,
        int const kd, int const kh, int const kw) {
    return mdw.off(g, oc, ic, kd, kh, kw);
}
static inline dim_t off5d(memory_desc_wrapper const& mdw,
        int const /*g*/, int const oc, int const ic,
        int const kd, int const kh, int const kw) {
    return mdw.off(oc, ic, kd, kh, kw);
};
static inline dim_t offg4d(memory_desc_wrapper const& mdw,
        int const g, int const oc, int const ic,
        int const /*kd*/, int const kh, int const kw) {
    return mdw.off(g, oc, ic, kh, kw);
};
static inline dim_t off4d(memory_desc_wrapper const& mdw,
        int const /*g*/, int const oc, int const ic,
        int const /*kd*/, int const kh, int const kw) {
    return mdw.off(oc, ic, kh, kw);
};
static inline dim_t offg3d(memory_desc_wrapper const& mdw,
        int const g, int const oc, int const ic,
        int const /*kd*/, int const /*kh*/, int const kw) {
    return mdw.off(g, oc, ic, kw);
};
static inline dim_t off3d(memory_desc_wrapper const& mdw,
        int const /*g*/, int const oc, int const ic,
        int const /*kd*/, int const /*kh*/, int const kw) {
    return mdw.off(oc, ic, kw);
};
static inline dim_t oops(memory_desc_wrapper const& mdw,
        int const /*g*/, int const /*oc*/, int const /*ic*/,
        int const /*kd*/, int const /*kh*/, int const /*kw*/) {
    assert(false);
    return dim_t{0};
};

template<typename RET, bool is_int_conv>
struct Cvt { // Full definition default for is_int_conv == true
    template<typename acc_data_t> inline
            static RET qs(acc_data_t const acc){
                return qz_a1b0<acc_data_t,RET>()(acc);
            }
    template<typename acc_data_t> inline 
            static RET rs(acc_data_t const acc){
                return round_and_saturate<RET>(acc);
            }
    // more efficient if you just need the acc_data_t version
    // Wait for later simple_q10n, which was rewritten!
    //template<typename acc_data_t>
    //        static acc_data_t acc_rs(acc_data_t const acc){
    //            return round_and_saturate<RET>(acc);
    //        }
    template<typename acc_data_t> inline 
            static RET int_sat(acc_data_t const acc){
                return saturate<RET>(acc);
            }
    template<typename acc_data_t> inline // default round, not nxcsr_round (slow on VE)
            static int int_rs(acc_data_t const acc){
                //return saturate<RET>((int)acc);
                int v = acc; // VE can vectorize if use this type
                int constexpr ret_bound_lo = (int)nstl::numeric_limits<RET>::lowest();
                int constexpr ret_bound_hi = (int)nstl::numeric_limits<RET>::max();
                if (v < ret_bound_lo) v = ret_bound_lo;
                if (v > ret_bound_hi) v = ret_bound_hi;
                return v;
            }
};
template<typename RET>
struct Cvt<RET, false/*is_int_conv*/> {
    template<typename acc_data_t> inline
            static RET qs(acc_data_t const acc) { // !is_int_conv
                return saturate<RET>(acc);
            }
    template<typename acc_data_t> inline
            static RET rs(acc_data_t const acc) { // !is_int_conv
                return saturate<RET>(acc);
            }
    template<typename acc_data_t> inline
            static RET int_sat(acc_data_t const acc){
                return acc;
            }
    template<typename acc_data_t> inline
            static acc_data_t int_rs(acc_data_t const acc){
                return acc;
            }
};

/** round_and_saturate behavior for integer outputs
 * but default-convert others.  float Nan/inf remain.
 * ex. sqrt(-ve) s.t. float remains as -NaN. */
template<typename out_t, typename in_t> inline 
    typename utils::enable_if<nstl::is_integral<out_t>::value, out_t>::type
    int_rs(in_t const in) {
        return round_and_saturate<out_t>(in);
    }

template<typename out_t, typename in_t> inline 
    typename utils::enable_if<!nstl::is_integral<out_t>::value, out_t>::type
    int_rs(in_t const in) {
        return in;
    }

}//anon::

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s
#endif // VE_REF_CONVOLUTION_UTIL_HPP
