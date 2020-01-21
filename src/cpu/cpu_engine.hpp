/*******************************************************************************
* Copyright 2016-2019 Intel Corporation
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

#include "dnnl.h"
#include "cpu_isa_traits.hpp" // set JITFUNCS preprocessor symbol

#include "../common/engine.hpp"
#include "c_types_map.hpp"


// oops SX VERBOSE_PRIMITIVE_CREATE uses unsupported c++1 features???
#if defined(_SX)
#undef VERBOSE_PRIMITIVE_CREATE
#define VERBOSE_PRIMITIVE_CREATE 0
#endif
#if DNNL_ISA == DNNL_ISA_VANILLA
#undef VERBOSE_PRIMITIVE_CREATE
#define VERBOSE_PRIMITIVE_CREATE 1
#endif

#ifndef VERBOSE_PRIMITIVE_CREATE
#if defined(NDEBUG)
/** Debug --- see every impl that was skipped as we iterate to find
 * an acceptable impl. This can be quite verbose.
 *
 * In particularly, with mods to various init() functions, you can use
 * this flag to also print out precisely why an impl was skipped.
 *
 * \deprecated Easier to dnnl_set_verbose(2) in cpu_engine constructor (see below)
 */
#define VERBOSE_PRIMITIVE_CREATE 0/*release mode compile*/
#else
// debug output here can be extremely lengthy for some tests, ex. "no-FOO" for every impl in cpu_engine list
#define VERBOSE_PRIMITIVE_CREATE 1
#endif
#endif


namespace dnnl {
namespace impl {
namespace cpu {

class cpu_engine_t : public engine_t {
public:
    cpu_engine_t()
        : engine_t(engine_kind::cpu, get_default_runtime(engine_kind::cpu)) {}

    /* implementation part */

    virtual status_t create_memory_storage(memory_storage_t **storage,
            unsigned flags, size_t size, void *handle) override;

    virtual status_t create_stream(stream_t **stream, unsigned flags) override;

    virtual const concat_primitive_desc_create_f *
    get_concat_implementation_list() const override;
    virtual const reorder_primitive_desc_create_f *
    get_reorder_implementation_list() const override;
    virtual const sum_primitive_desc_create_f *
    get_sum_implementation_list() const override;
    virtual const primitive_desc_create_f *
    get_implementation_list() const override;
};

class cpu_engine_factory_t : public engine_factory_t {
public:
    virtual size_t count() const override { return 1; }
    virtual status_t engine_create(
            engine_t **engine, size_t index) const override {
        assert(index == 0);
        *engine = new cpu_engine_t();
        return status::success;
    };
};

} // namespace cpu
} // namespace impl
} // namespace dnnl

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif
