/*******************************************************************************
* Copyright 2016-2017 Intel Corporation
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

#ifndef CPU_ENGINE_HPP
#define CPU_ENGINE_HPP

#include <assert.h>

#include "mkldnn.h"

#include "c_types_map.hpp"
#include "../common/engine.hpp"

#ifndef VERBOSE_PRIMITIVE_CREATE
#if defined(NDEBUG)
/** Debug --- see every impl that was skipped as we iterate to find
 * an acceptable impl. This can be quite verbose.
 *
 * In particularly, with mods to various init() functions, you can use
 * this flag to also print out precisely why an impl was skipped.
 */
#define VERBOSE_PRIMITIVE_CREATE 0
#else
#define VERBOSE_PRIMITIVE_CREATE 0
#endif
#endif

// oops SX VERBOSE_PRIMITIVE_CREATE uses unsupported c++1 features???
#if defined(_SX)
#if defined(VERBOSE_PRIMITIVE_CREATE)
#undef VERBOSE_PRIMITIVE_CREATE
#endif
#define VERBOSE_PRIMITIVE_CREATE 0
#endif

#if defined(TARGET_VANILLA) && !defined(JITFUNCS)
/** In principle could have multiple TARGETS.
 * For example: VANILLA, and later perhaps SSE42, AVX2, AVX512.
 * Default is "compile everything".
 * These TARGETS can be set in cmake to generate reduced-functionality libmkldnn.
 * Which jit impls get included in the engine is capped by a single value.
 *
 *
 * For example, TARGET_VANILLA includes NO Intel JIT code at all, and is suitable
 * for [cross-]compiling for other platforms.
 *
 * \note TARGET_VANILLA impls are not *yet* optimized for speed! */
#define JITFUNCS 0
#endif

#ifndef JITFUNCS
/* default mkl-dnn compile works as usual, 100 means include all impls */
#define JITFUNCS 0
#endif

namespace mkldnn {
namespace impl {
namespace cpu {

class cpu_engine_t: public engine_t {
public:
    cpu_engine_t(): engine_t(engine_kind::cpu) {}

    virtual status_t submit(primitive_t *p, event_t *e,
            event_vector &prerequisites);

    /* implementation part */

    virtual status_t memory_primitive_desc_create(memory_pd_t **memory_pd,
            const memory_desc_t *memory_d);
    virtual status_t view_primitive_desc_create(view_pd_t **view_pd,
            const memory_pd_t *memory_pd, const dims_t dims,
            const dims_t offsets);

    virtual const concat_primitive_desc_create_f*
        get_concat_implementation_list() const;
    virtual const reorder_primitive_desc_create_f*
        get_reorder_implementation_list() const;
    virtual const sum_primitive_desc_create_f*
        get_sum_implementation_list() const;
    virtual const primitive_desc_create_f* get_implementation_list() const;
};

class cpu_engine_factory_t: public engine_factory_t {
public:
    virtual size_t count() const { return 1; }
    virtual engine_kind_t kind() const { return engine_kind::cpu; }
    virtual status_t engine_create(engine_t **engine, size_t index) const {
        assert(index == 0);
        *engine = new cpu_engine_t();
        return status::success;
    };
};

extern cpu_engine_factory_t engine_factory;

}
}
}

#endif

// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
