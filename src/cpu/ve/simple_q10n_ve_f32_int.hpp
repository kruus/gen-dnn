/*******************************************************************************
* Copyright 2020 NEC Labs America LLC
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

#ifndef CPU_VE_SIMPLE_Q10N_VEC_F32_U8_HPP
#define CPU_VE_SIMPLE_Q10N_VEC_F32_U8_HPP
#include "cpu/ve/simple_q10n_vec.hpp"

/** \file TEMPORARY q10n specialization for f32 to u8 round(saturate) */

namespace dnnl {
namespace impl {
namespace cpu {

template <>
struct qzv_a1b0<float, int32_t, void>
{
    typedef int32_t out_t;
    // impl ALMOST applies to uint32_t
    // - except vector op vcvt.w.s ONLY cvts to int32
    // (would need to shift, saturate, convert, unshift, for uint32_t)

    // nice: can inject constexpr immediates into extended asm

    // but cannot inject constexpr strings to lightly vary templated productions.
    // (so some proliferation of almost identical templates)

    void operator()(float const* in, int32_t *out, unsigned const len) {
        size_t const blk = MVL;
        // change to saturate, then round, like trunk
        //float constexpr lbound = (float)nstl::numeric_limits<int32_t>::lowest();
        //float constexpr ubound = (float)nstl::numeric_limits<int32_t>::max();
        NOVECTOR for (size_t i=0; i<len; i+=blk){
            size_t vl = (len-i > blk? blk: len-i);
#if 1 // new code, based on u8/s8 work
            {
                // if good alignments could use packed-vec-ops (and blk=512) XXX
                int a; // tmp 32-bit register for vfmax/vfmin
                asm("\t# VE_SATURATE_ROUND_FLOAT_TO_INT32\n\t"
                        "lvl %[vl]\n\t"
                        "vldu.nc %v63, 4, %[in]         # float in[]\n\t"
                        // lea can take a float constexpr immediate
                        "lea.sl  %[a], %[lowerBound]    # s32 lowerBound\n\t"
                        "vfmax.s %v63, %[a], %v63\n\t"
                        "lea.sl  %[a], %[upperBound]    # s32 upperBound\n\t"
                        "vfmin.s %v63, %[a], %v63       # s32-saturated in[]\n\t"
                        "vcvt.w.s.sx.rz %v62, %v63      # float-->int32 like nearbyintf\n\t"
                        "vstl %v62, 4, %[out]           # int32 lower half --> out[]\n\t"
                        : [a]"+r"(a)
                        , "=m"( /*dummy output*/ *(int (*)[vl]) &out[i] )
                        : [in]"r"(&in[i]), [vl]"r"(vl), [out]"r"(&out[i])
                        , "m"( /*dummy input*/ *(const float (*)[vl]) &in[i])
                        , [lowerBound]"i"((float)nstl::numeric_limits<out_t>::lowest())
                        , [upperBound]"i"((float)nstl::numeric_limits<out_t>::max())
                        : "%v62", "%v63"
                   );
            }
#else // old code
                    // cannot cvt to int then sat, because
                    // vcvt might give zero for over/underflow !!!
                    //
                    // moving lbound, ubound into asm helps
                    // reduce spill by a lot.
                    // --mode=C 0.91 ms, (was ~12 ms)
            // TODO mxcsr_roundv(float*, float lbound, float ubound, vl, int*) ??
            // (all in one asm construct)
#if 0 // essential ubound,lbound code
             lea.sl  %s55,-822083584  and s54
                     lea.sl  %s59,1325400064
            vldu.nc %v63,4,%s59
                    vfcmp.s %v62,%s55,%v63      # s55=s54= -something
                    vfmk.s.gt       %vm15,%v62
                    vbrdu   %v63,%s54,%vm15
                    vfcmp.s %v61,%s59,%v63
                    vfmk.s.lt       %vm15,%v61
                    vbrdu   %v63,%s51,%vm15
#endif
            asm("\t# VE_ROUND_FLOAT_TO_INT\n\t"
                    "lvl %[vl]\n\t"
                    "vldu.nc %v63, 4, %[in]\n\t"
                    "\n"
                    "# if too low, use (float) int32_t.lowet()\n\t"
                    "lea.sl  %s63,-822083584\n\t"
                    //"vfcmp.s %v62, %[lbound], %v63\n\t"
                    "vfcmp.s %v62, %s63, %v63\n\t"
                    "vfmk.s.gt %vm15, %v62\n\t"
                    //"lea.sl  %s62,-822083584\n\t"
                    //"vbrdu %v63, %[lbound2], %vm15\n\t"
                    "vbrdu %v63, %s63, %vm15\n\t"
                    "\n"
                    "# if too high, use (float) int32_t.max()\n\t"
                    "lea.sl  %s63,1325400064\n\t"
                    //"vfcmp.s %v62, %[ubound], %v63\n\t"
                    "vfcmp.s %v62, %s63, %v63\n\t"
                    "vfmk.s.lt %vm15, %v62\n\t"
                    //"vbrdu %v63, %[ubound2], %vm15\n\t"
                    //"lea.sl  %s62,1325400064\n\t"
                    "vbrdu %v63, %s63, %vm15\n\t"
                    "\n"
                    "# cvt float to int, like nearbyintf\n\t"
                    "vcvt.w.s.sx.rz %v62, %v63\n\t"
                    "vstl %v62, 4, %[out] # int32 output in lower half\n\t"
                    : "=m"( /*dummy output*/ *(int (*)[vl]) &out[i] )
                    : [in]"r"(&in[i]), [vl]"r"(vl), [out]"r"(&out[i])
                    //, [lbound]"r"(lbound), [ubound]"r"(ubound)
                    //, [lbound2]"r"(lbound), [ubound2]"r"(ubound)
                    , "m"( /*dummy input*/ *(const float (*)[vl]) &in[i])
                    : "%v62", "%v63", "%vm15"
                    , "%s63" //, "%s62"
               ); // still circa 10 ms (--mode=C); was 12 ms --mode=P
#endif
        }
    }
};

#if 0 // XXX untested
template <>
struct qzv_a1<float, int32_t, void>
{
    typedef int32_t out_t;
    void operator()(float const* in, int32_t *out,
            unsigned const len, float const beta) {
        size_t const blk = MVL;
        NOVECTOR for (size_t i=0; i<len; i+=blk){
            size_t vl = (len-i > blk? blk: len-i);
#if 1 // new code, based on u8/s8 work
            {
                int a; // tmp 32-bit register for vfmax/vfmin
                asm("\t# VE_SATURATE_ROUND_FLOAT_TO_INT32\n\t"
                        "lvl %[vl]\n\t"
                        "vldu.nc %v63, 4, %[in]          # load float in[]\n\t"
                        // to qzv_a1b0, add "scaled[i] = (float)in[i] + beta * out[i]"
                        "vldl       %v62, 4, %[out]      # load s32 out[]\n\t"
                        "vcvt.s.w   %v62, %v62           # and cvt to float\n\t"
                        //                               vvvv must be vec reg
                        "vfmad.s    %v63, %v62, %[beta], %v62\n\t" 
                        //                add   [--- mul ---]
                        "# v63 : scaled[i] = in[i] + beta * (float)out[i]\n\t"

                        // lea can take a float constexpr immediate
                        "lea.sl  %[a], %[lowerBound]    # s32 lowerBound\n\t"
                        "vfmax.s %v63, %[a], %v63\n\t"
                        "lea.sl  %[a], %[upperBound]    # s32 upperBound\n\t"
                        "vfmin.s %v63, %[a], %v63       # v63 : saturate to int32_t limits\n\t"
                        "vcvt.w.s.sx.rz %v62, %v63      # to int32_t like nearbyintf\n\t"
                        "vstl %v62, 4, %[out]           # int32 output in lower half\n\t"

                        : [a]"+r"(a)
                        , "=m"( /*dummy output*/ *(int (*)[vl]) &out[i] )
                        : [in]"r"(&in[i])
                        , [out]"r"(&out[i])
                        , [vl]"r"(vl)
                        , "m"( /*dummy input*/ *(const float (*)[vl]) &in[i])
                        , [lowerBound]"i"((float)nstl::numeric_limits<out_t>::lowest())
                        , [upperBound]"i"((float)nstl::numeric_limits<out_t>::max())
                        : "%v62", "%v63"
                   );
            }
#else // old code
                    // cannot cvt to int then sat, because
                    // vcvt might give zero for over/underflow !!!
                    //
                    // moving lbound, ubound into asm helps
                    // reduce spill by a lot.
                    // --mode=C 0.91 ms, (was ~12 ms)
            // TODO mxcsr_roundv(float*, float lbound, float ubound, vl, int*) ??
            // (all in one asm construct)
#if 0 // essential ubound,lbound code
             lea.sl  %s55,-822083584  and s54
                     lea.sl  %s59,1325400064
            vldu.nc %v63,4,%s59
                    vfcmp.s %v62,%s55,%v63      # s55=s54= -something
                    vfmk.s.gt       %vm15,%v62
                    vbrdu   %v63,%s54,%vm15
                    vfcmp.s %v61,%s59,%v63
                    vfmk.s.lt       %vm15,%v61
                    vbrdu   %v63,%s51,%vm15
#endif
            asm("\t# VE_ROUND_FLOAT_TO_INT\n\t"
                    "lvl %[vl]\n\t"
                    "vldu.nc %v63, 4, %[in]\n\t"
                    "\n"
                    "# if too low, use (float) int32_t.lowet()\n\t"
                    "lea.sl  %s63,-822083584\n\t"
                    //"vfcmp.s %v62, %[lbound], %v63\n\t"
                    "vfcmp.s %v62, %s63, %v63\n\t"
                    "vfmk.s.gt %vm15, %v62\n\t"
                    //"lea.sl  %s62,-822083584\n\t"
                    //"vbrdu %v63, %[lbound2], %vm15\n\t"
                    "vbrdu %v63, %s63, %vm15\n\t"
                    "\n"
                    "# if too high, use (float) int32_t.max()\n\t"
                    "lea.sl  %s63,1325400064\n\t"
                    //"vfcmp.s %v62, %[ubound], %v63\n\t"
                    "vfcmp.s %v62, %s63, %v63\n\t"
                    "vfmk.s.lt %vm15, %v62\n\t"
                    //"vbrdu %v63, %[ubound2], %vm15\n\t"
                    //"lea.sl  %s62,1325400064\n\t"
                    "vbrdu %v63, %s63, %vm15\n\t"
                    "\n"
                    "# cvt float to int, like nearbyintf\n\t"
                    "vcvt.w.s.sx.rz %v62, %v63\n\t"
                    "vstl %v62, 4, %[out] # int32 output in lower half\n\t"
                    : "=m"( /*dummy output*/ *(int (*)[vl]) &out[i] )
                    : [in]"r"(&in[i]), [vl]"r"(vl), [out]"r"(&out[i])
                    //, [lbound]"r"(lbound), [ubound]"r"(ubound)
                    //, [lbound2]"r"(lbound), [ubound2]"r"(ubound)
                    , "m"( /*dummy input*/ *(const float (*)[vl]) &in[i])
                    : "%v62", "%v63", "%vm15"
                    , "%s63" //, "%s62"
               ); // still circa 10 ms (--mode=C); was 12 ms --mode=P
#endif
        }
    }
};
#endif

#if 1
//template <>
//struct qzv_a1b0<float, uint8_t, void>
// float --> u8 or s8  : only difference is in saturation values

template <typename out_t>
struct qzv_a1b0<float, out_t,
        typename utils::enable_if<nstl::is_integral<out_t>::value
        && (sizeof(out_t) == 1)
        >::type>
{
    void operator()(float const* in, out_t *out, unsigned const len) {
        size_t const blk = MVL;
        // change to saturate, then round, like trunk
        // first convert to int32 all with vector ops
        int32_t sat[MVL] __attribute__((aligned(8))); // later might used packed ops?
        NOVECTOR for (size_t i=0; i<len; i+=blk){
            size_t const vl = (len-i > blk? blk: len-i);
            // saturate, then round (as nearbyintf) to
            // int32_t sat[] buffer with alignment 8
            {
                int a; // tmp 32-bit register for vfmax/vfmin
                // Nice:  Can inject float constexpr as immediate operand
                //        into extended asm (avoid excess registers)
                asm("\t# VE vector register saturate and round float --> int32_t\n\t"
                        "lvl %[vl]\n\t"
                        "vldu.nc %v63, 4, %[in]\n\t"
                        "\n"
                        //"vfmax.s %v63, %[lowerBound], %v63\n\t" I only in -64 to 63
                        // lea can take a full float immediate:
                        "lea.sl  %[a], %[lowerBound]\t\t# lowerBound e.g. 0.0f\n\t"
                        "vfmax.s %v63, %[a], %v63\n\t"
                        "lea.sl  %[a], %[upperBound]\t\t# upperBound e.g. 255.0f\n\t"
                        "vfmin.s %v63, %[a], %v63\n\t"
                        "vcvt.w.s.sx.rz %v62, %v63\t\t# float to int32, like nearbyintf\n\t"
                        "vstl %v62, 4, %[out] # int32 output in lower half\n\t"
                        : [a]"+r"(a)
                        , "=m"( /*dummy output*/ *(int (*)[vl]) &sat[0] )
                        : [in]"r"(&in[i]), [vl]"r"(vl), [out]"r"(&sat[0])
                        , "m"( /*dummy input*/ *(const float (*)[vl]) &in[i])
                        , [lowerBound]"i"((float)nstl::numeric_limits<out_t>::lowest())
                        , [upperBound]"i"((float)nstl::numeric_limits<out_t>::max())
                        : "%v62", "%v63"
                   );
            }

            {
                // Handle worst case of unknown out[] alignment.
                // The int32_t sat[] saturated buffer is 8-byte aligned.
                uint64_t a,b,c,d; // tmp registers
                uint32_t const* s = (uint32_t const*)(void const*)&sat[0];
                out_t *o = &out[i];
                int j = vl;
                // process big-blocks first, preserving s-align-8
                asm("# src-align-8, loop by 8s, copy LSBs to dst[] 1 byte at a time\n\t"
                        "brge.w     7, %[j], 2f\t\t# if 7 >= j, skip\n\t"
                        "\n1: # loop by 8s\n\t"
                        "  ld         %[tmp0],  0(,%[src])\n\t"
                        "  ld         %[tmp2],  8(,%[src])\n\t"
                        "  srl        %[tmp1], %[tmp0], 32\n\t"
                        "  srl        %[tmp3], %[tmp2], 32\n\t"
                        "  st1b       %[tmp0], 0(,%[dst])\n\t"
                        "  st1b       %[tmp2], 2(,%[dst])\n\t"
                        "  st1b       %[tmp1], 1(,%[dst])\n\t"
                        "  st1b       %[tmp3], 3(,%[dst])\n\t"
                        "  ld         %[tmp0], 16(,%[src])\n\t"
                        "  ld         %[tmp2], 24(,%[src])\n\t"
                        "  srl        %[tmp1], %[tmp0], 32\n\t"
                        "  srl        %[tmp3], %[tmp2], 32\n\t"
                        "adds.w.sx  %[j], -8, %[j]\t\t# j-=8\n\t"
                        "  st1b       %[tmp0], 4(,%[dst])\n\t"
                        "  st1b       %[tmp2], 6(,%[dst])\n\t"
                        "adds.l     %[src], 32, %[src]\t# s+=32\n\t"
                        "  st1b       %[tmp1], 5(,%[dst])\n\t"
                        "  st1b       %[tmp3], 7(,%[dst])\n\t"
                        "adds.l     %[dst],  8, %[dst]\t# o+=8\n\t"
                        "brlt.w     7, %[j], 1b\t# if 7 < j, keep going by 8s\n"
                        "    2: # by 8s done: assert(j<=7)\n"
                        //
                        "\tbrge.w     3, %[j], 3f\t# if 3 >= j, skip\n\t"
                        "  # 3<j : by 4, src-align-8 LSByte copy\n\t"
                        "  ld         %[tmp0], 0(,%[src])\n\t"
                        "  ld         %[tmp2], 8(,%[src])\n\t"
                        "  srl        %[tmp1], %[tmp0], 32\n\t"
                        "  srl        %[tmp3], %[tmp2], 32\n\t"
                        "  st1b       %[tmp0], 0(,%[dst])\n\t"
                        "  st1b       %[tmp2], 2(,%[dst])\n\t"
                        "adds.w.sx  %[j], -4, %[j]\t\t# j-=4\n\t"
                        "  st1b       %[tmp1], 1(,%[dst])\n\t"
                        "adds.l     %[src], 16, %[src]\t# s+=16\n\t"
                        "  st1b       %[tmp3], 3(,%[dst])\n\t"
                        "adds.l     %[dst],  4, %[dst]\t# o+=4\n"
                        "    3: # by 4 done: assert(j<=3)\n"
                        //
                        "\tbrge.w     1, %[j], 4f\t# if 1 >= j, skip\n\t"
                        "  # 1<j : by 2, src-align-8 LSByte copy\n\t"
                        "  ld         %[tmp0], 0(,%[src])\n\t"
                        "adds.w.sx  %[j], -2, %[j]\t\t# j-=2\n\t"
                        "  st1b       %[tmp0], 0(,%[dst])\n\t"
                        "  srl        %[tmp1], %[tmp0], 32\n\t"
                        "adds.l     %[src], 8, %[src]\t# s+=8\n\t"
                        "  st1b       %[tmp1], 1(,%[dst])\n\t"
                        "adds.l     %[dst],  2, %[dst]\t# o+=2\n"
                        "    4: # by 2 done: assert(j<=1); src-align still 8\n"
                        //
                        "brge.w     0, %[j], 5f\t# if 0 >= j, skip\n\t"
                        "  # j==1, by 1, src-align-8 LSByte copy\n\t"
                        "  ldl.zx     %[tmp0], 0(,%[src])\n\t"
                        "  st1b       %[tmp0], 0(,%[dst])\n\t"
                        "  #adds.w.sx  %[j], -1, %[j]\t# j-=1 don't care\n\t"
                        "  #adds.l     %[dst],  1, %[dst]\t# o+=1 don't care\n\t"
                        "  #adds.l     %[src], 4, %[src]\t# s+=4 don't care\n\t"
                        "    5: # done last 1-byte output\n\t"
                        //
                        : [tmp0]"=r"(a), [tmp1]"=r"(b)
                        , [tmp2]"=r"(c), [tmp3]"=r"(d)
                        , [j]"+r"(j), [src]"+r"(s), [dst]"+r"(o) //, m
                        :
                        :
                        );
            }
        }
    }
};
#endif

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,l0,\:4,N-s filetype=cpp
#endif // CPU_VE_SIMPLE_Q10N_VEC_F32_U8_HPP
