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

#ifndef CPU_ENGINE_HPP
#define CPU_ENGINE_HPP

#include <assert.h>

#include "../common/engine.hpp"
#include "c_types_map.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

#define DECLARE_IMPL_LIST(kind) \
     IF_USE_KIND(kind, const engine_t::primitive_desc_create_f * \
             get_##kind##_impl_list( const kind##_desc_t *desc);)

DECLARE_IMPL_LIST(batch_normalization);
DECLARE_IMPL_LIST(binary);
DECLARE_IMPL_LIST(convolution);
DECLARE_IMPL_LIST(deconvolution);
DECLARE_IMPL_LIST(eltwise);
DECLARE_IMPL_LIST(inner_product);
DECLARE_IMPL_LIST(layer_normalization);
DECLARE_IMPL_LIST(lrn);
DECLARE_IMPL_LIST(logsoftmax);
DECLARE_IMPL_LIST(matmul);
DECLARE_IMPL_LIST(pooling);
DECLARE_IMPL_LIST(resampling);
DECLARE_IMPL_LIST(rnn);
DECLARE_IMPL_LIST(shuffle);
DECLARE_IMPL_LIST(softmax);

#undef DECLARE_IMPL_LIST

class cpu_engine_t : public engine_t {
public:
    cpu_engine_t()
        : engine_t(engine_kind::cpu, get_default_runtime(engine_kind::cpu)) {}

    /* implementation part */

    virtual status_t create_memory_storage(memory_storage_t **storage,
            unsigned flags, size_t size, void *handle) override;

    virtual status_t create_stream(stream_t **stream, unsigned flags) override;

    // concat, reorder and sum are "internal" impls
    virtual const concat_primitive_desc_create_f *
    get_concat_implementation_list() const override;
    virtual const reorder_primitive_desc_create_f *
    get_reorder_implementation_list(const memory_desc_t *src_md,
            const memory_desc_t *dst_md) const override;
    virtual const sum_primitive_desc_create_f *
    get_sum_implementation_list() const override;

    virtual const primitive_desc_create_f *get_implementation_list(
            const op_desc_t *desc) const override {
        static const primitive_desc_create_f empty_list[] = {nullptr};

#define CPU_ENGINE_LIST(kind) \
    IF_USE_KIND(kind, case primitive_kind::kind: \
        return get_##kind##_impl_list((const kind##_desc_t *)desc);)
        switch (desc->kind) {
            CPU_ENGINE_LIST(batch_normalization)
            CPU_ENGINE_LIST(binary)
            CPU_ENGINE_LIST(convolution)
            CPU_ENGINE_LIST(deconvolution)
            CPU_ENGINE_LIST(eltwise)
            CPU_ENGINE_LIST(inner_product)
            CPU_ENGINE_LIST(layer_normalization)
            CPU_ENGINE_LIST(lrn)
            CPU_ENGINE_LIST(logsoftmax)
            CPU_ENGINE_LIST(matmul)
            CPU_ENGINE_LIST(pooling)
            CPU_ENGINE_LIST(resampling)
            CPU_ENGINE_LIST(rnn)
            CPU_ENGINE_LIST(shuffle)
            CPU_ENGINE_LIST(softmax)
            default: assert(!"unknown primitive kind"); return empty_list;
        }
    }
#undef CPU_ENGINE_LIST
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

/** Often the following definition for INSTANCE_CREATOR is appropriate. */
#define DEFAULT_INSTANCE_CREATOR(...) \
    &primitive_desc_t::create<__VA_ARGS__::pd_t>,

/** Reference impls are always include in libdnnl.  It's OK to claim being
 * a ref impl if init() handles cases that actually require jit. */
#define INSTANCE_ref(...) INSTANCE_CREATOR(__VA_ARGS__)

/** Default allows x86 jit; N/A for vanilla or non-x86 builds.*/
#if TARGET_X86_JIT
#define INSTANCE(...) INSTANCE_CREATOR(__VA_ARGS__)
#else
#define INSTANCE(...)
#endif

/** For example, an implementation ONLY working for some non-x86 chip */
#if DNNL_ISA >= DNNL_ISA_VE && DNNL_ISA <= DNNL_ISA_VE_ALL
#define INSTANCE_ve(...) INSTANCE_CREATOR(__VA_ARGS__)
#else
#define INSTANCE_ve(...)
#endif

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif
