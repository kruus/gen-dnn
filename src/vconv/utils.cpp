/*******************************************************************************
* Copyright 2018 Intel Corporation
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

#include <string.h>
#ifdef _WIN32
#include <malloc.h>
#include <windows.h>
#endif

#include "utils.hpp"

#if !UTILS_HPP_SMALLER
#if defined(__ve) || defined(SX)
#include <ieeefp.h>
#else
#include "xmmintrin.h"
#endif
#endif // !UTILS_HPP_SMALLER


namespace mkldnn {
namespace impl {

#if !UTILS_HPP_SMALLER
int mkldnn_getenv(char *value, const char *name, int length) {
    int result = 0;
    int last_idx = 0;
    if (length > 1) {
        int value_length = 0;
#ifdef _WIN32
        value_length = GetEnvironmentVariable(name, value, length);
        if (value_length >= length) {
            result = -value_length;
        } else {
            last_idx = value_length;
            result = value_length;
        }
#else
        char *buffer = getenv(name);
        if (buffer != NULL) {
            value_length = strlen(buffer);
            if (value_length >= length) {
                result = -value_length;
            } else {
                strncpy(value, buffer, value_length);
                last_idx = value_length;
                result = value_length;
            }
        }
#endif
    }
    value[last_idx] = '\0';
    return result;
}

static bool dump_jit_code;

bool mkldnn_jit_dump() {
    static bool initialized = false;
    if (!initialized) {
        const int len = 2;
        char env_dump[len] = {0};
        dump_jit_code =
            mkldnn_getenv(env_dump, "MKLDNN_JIT_DUMP", len) == 1
            && atoi(env_dump) == 1;
        initialized = true;
    }
    return dump_jit_code;
}

FILE *mkldnn_fopen(const char *filename, const char *mode) {
#ifdef _WIN32
    FILE *fp = NULL;
    return fopen_s(&fp, filename, mode) ? NULL : fp;
#else
    return fopen(filename, mode);
#endif
}

static THREAD_LOCAL unsigned int mxcsr_save;

#if defined(__ve)
// we use ieeefp.h functions ...
void set_rnd_mode(round_mode_t rnd_mode) {
    mxcsr_save = (unsigned int)fpgetround();
    enum fp_rnd want;
    switch(rnd_mode) {
    case round_mode::nearest: want = FP_RN; break;
    case round_mode::down: want = FP_RM; break;
    default: assert(!"unreachable");
    }
    if ((unsigned int)want != mxcsr_save)
        fpsetround(want);
}

void restore_rnd_mode() {
    fpsetround((enum fp_rnd)mxcsr_save);
}
#else
void set_rnd_mode(round_mode_t rnd_mode) {
    mxcsr_save = _mm_getcsr();
    unsigned int mxcsr = mxcsr_save & ~(3u << 13);
    switch (rnd_mode) {
    case round_mode::nearest: mxcsr |= (0u << 13); break;
    case round_mode::down: mxcsr |= (1u << 13); break;
    default: assert(!"unreachable");
    }
    if (mxcsr != mxcsr_save) _mm_setcsr(mxcsr);
}

void restore_rnd_mode() {
    _mm_setcsr(mxcsr_save);
}
#endif
#endif // !UTILS_HPP_SMALLER

#if 0
void *malloc(size_t size, int alignment) {
    void *ptr;

#ifdef _WIN32
    ptr = _aligned_malloc(size, alignment);
    int rc = ptr ? 0 : -1;
#else
    int rc = ::posix_memalign(&ptr, alignment, size);
#endif

    return (rc == 0) ? ptr : 0;
}

void free(void *p) {
#ifdef _WIN32
    _aligned_free(p);
#else
    ::free(p);
#endif
}
#else // force into library
extern void *malloc(size_t size, int alignment);
extern void free(void *p);
#endif

}
}
/* vim: set et ts=4 sw=4 cino=^=l0,\:0,N-s: */
