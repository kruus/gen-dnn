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

#include "cpu/simple_q10n.hpp" // also pulls ve/simple_q10n_vec.hpp

// For VE, separate this to force it as an extern.   Currently, there is
// always_inline, but no "no_inline" ??
void mxcsr_roundv(float const* const f, int * const out, unsigned const vl)
    ATTR_NO_MSAN
{
#if DNNL_X64
    FOR_vl out[i] = _mm_cvtss_si32(_mm_load_ss(&f)); // BAD! (laziness)
#elif defined(__ve)
#if 0
    FOR_vl out[i] = (int)nearbyintf(f[i]);
#else
    //cvt.[output form].[input form]...
    //float->int|long:  cvt.w.{s|d}{.s|.sx}{.NONE|.rp|.rm|.re|.ra}, %sx, {%sy|I}
    //                                  NONE ~ according to PSW
    //double->long:     cvt.l.d[.rd]
    //int->float:       cvt.{d.w|s.w|d.l}
    //float->flat:      cvt.{s|d|q}.{s|d|q}
    asm("lvl %[vl]\n"
        "vldu %v63, 4, %[f]\n\t"           // float 0:31
        "vcvt.w.s.sx.rz %v63, %v63\n\t"    // VFIX op --> int32 in 32:63 of v64
        "vstl %v63, 4, %[out]\n\t"         // [sx into 0:31] , store 32:63 to out
        "svob\n\t" // memory
     :                                        // outputs
     //: "=m"(*(const int (*)[])out)//  error: dummy output "must be modifiable"?*/
     : [f]"r"(f), [vl]"r"(vl), [out]"r"(out)  // inputs
     , "m"( /*dummy input*/ *(const float (*)[]) f)
     : "%v63", "memory"                // clobbers, %vl unknown
    );
    // expt: can I get rid of "memory" (causes many spills) ??
#define VE_ROUND_FLOAT_TO_INT(F,VL,OUT) \
    asm("\t# VE_ROUND_FLOAT_TO_INT(F,VL,OUT)\n\t" \
            "lvl %[vl]\n\t" \
            "vldu %v63, 4, %[f]\n\t" \
            "vcvt.w.s.sx.rz %v63, %v63\n\t" \
            "vstl %v63, 4, %[out]\n\t" \
            : "m"(*(const int (*)[]) OUT) \
            : [f]"r"(F), [vl]"r"(VL), [out]"r"(OUT), \
              "m"( /*dummy input*/ *(const float (*)[]) F) \
            : "%v63"  /*, "memory" causes many spills? */ \
       )
#if 1
    // double-check:
    if(0){
        assert(vl <= MVL );
        static int nerr=0;
        if (nerr < 50) {
            for(int i=0; i<vl; ++i){
                if (out[i] != nearbyintf(f[i])){
                    printf( " nerabyintf(%f)=%d, but vcvt-->%d\n",
                            f[i], (int)nearbyintf(f[i]), (int)out[i]);
                    ++nerr;
                }
                if (nerr > 10) break;
            }
        }
    }
#endif

#endif
#else
    FOR_vl out[i] = (int)nearbyintf(f[i]);
#endif
}

