/* Copyright (c) 2019 by NEC Corporation
 * This file is based on code from the ve-jit project. */
#include "ve_fastdiv.h"

#ifdef __cpluscplus
extern "C" {
#endif

/** unsigned 32-bit log2, required for magic constant generation */
static inline uint32_t ulog2(uint32_t v) {
    uint32_t r, shift;
    r =     (v > 0xFFFF) << 4; v >>= r;
    shift = (v > 0xFF  ) << 3; v >>= shift; r |= shift;
    shift = (v > 0xF   ) << 2; v >>= shift; r |= shift;
    shift = (v > 0x3   ) << 1; v >>= shift; r |= shift;
    r |= (v >> 1);
    return r;
}

void vednn_fastdiv(struct ve_fastdiv *d, uint32_t divisor)
{
    uint32_t l, r, e;
    uint64_t m;

    d->_odiv = divisor;
    // Modifed [ejk]
    l = ulog2(divisor);
    if (divisor & (divisor - 1)) {      // non-power-of-two?
        m = 1ULL << (l + 32);
        d->mul = (uint32_t)(m / divisor);
        r = (uint32_t)m - d->mul * divisor;
        e = divisor - r;
        if (e < (1UL << l)) {
            ++d->mul;
            d->add = 0;
        } else {
            d->add = d->mul;
        }
        d->shift = 32+l;                // <-- VE mod
        // (x86 has fast register-half access, not needed for VE)
    } else {                            // power-of-two divisor
        //printf(" divisor=%u,l=%d\n",divisor,l);
        d->mul = 1;
        d->add = 0;
        d->shift = (divisor<=1? 0: l);
    }
}

/** fast division for 'small enough' unsigned numbers
 * without intermediates overflowing 64 bits.
 * see https://github.com/lemire/constantdivisionbenchmarks, "lkk" algorithm.
 * Issue #1 comments on 64-bit-only version similar to:
 */
#define FASTDIV_B 21 /* FASTDIV_B up to 21 is OK to keep all intermediates in 64-bit range */
#define FASTDIV_C (2*FASTDIV_B)
/* 23 zeros and rest (41 = FASTDIV_C-1) ones, nice for VE masked const. */
#define FASTDIV_CMASK ((UINT64_C(1)<<FASTDIV_C)-1)
#define FASTDIV_SAFEMAX ((1U<<FASTDIV_B)-1U)

void vednn_fastdiv_bounded(struct ve_fastdiv *d, uint32_t const divisor, uint32_t bound)
{
    uint32_t fastdiv_ops = 0U;
    vednn_fastdiv(d, divisor);
    if(d->mul   != 1U) ++fastdiv_ops;
    if(d->add   != 0U) ++fastdiv_ops;
    if(d->shift != 0U) ++fastdiv_ops;
    // Often the full-range method finds a 2-op method with d->add=0U
    // If not, try another method ok for 21-bit numerator and denominator
    //
    // Note that even if add is nonzero, we prefer a 2-op general method,
    // because a 32-bit mul (possible) is easier to load into VE scalar reg.
    if(fastdiv_ops==3 && bound>0U && bound <= FASTDIV_SAFEMAX){
        //uint64_t jj_M = computeM_uB(divisor); // 42-bit fastdiv_uB multiplier
        d->mul = FASTDIV_CMASK / divisor + 1;
        d->add = 0U;
        d->shift = 42U;
    }
}

#ifdef __cpluscplus
}//extern "C"
#endif
// vim: ts=4 sw=4 et cindent cino=^=l0,\:.5s,=-.5s,N-s,g.5s,b1 cinkeys=0{,0},0),\:,0#,!^F,o,O,e,0=break
