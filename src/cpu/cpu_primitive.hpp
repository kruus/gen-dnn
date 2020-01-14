/*******************************************************************************
* Copyright 2019 Intel Corporation
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

#ifndef CPU_PRIMITIVE_HPP
#define CPU_PRIMITIVE_HPP

#if 0 // BIG CHANGES for dnnl v1.1.0
#include "mkldnn.h"

#include "c_types_map.hpp"
#include "memory_tracking.hpp"
#include "primitive.hpp"
#include "primitive_exec_types.hpp"
#include "scratchpad.hpp"

#include <type_traits>

#define ARG_TYPE(t) \
    typename std::remove_cv<typename std::remove_pointer<t>::type>::type

#define CTX_IN_MEM(type, arg) \
    static_cast<const ARG_TYPE(type) *>(CTX_IN_STORAGE(arg).data_handle())

#define CTX_OUT_MEM(type, arg) \
    static_cast<ARG_TYPE(type) *>(CTX_OUT_STORAGE(arg).data_handle())

namespace mkldnn {
namespace impl {
namespace cpu {

struct cpu_primitive_t: public primitive_t {
    cpu_primitive_t(const primitive_desc_t *pd,
            bool use_global_scratchpad = false)
        : primitive_t(pd)
        , scratchpad_buffer_(nullptr)
        , global_scratchpad_(nullptr)
    {
        const size_t scratchpad_size =
            this->pd()->scratchpad_size(scratchpad_mode::library);

        if (scratchpad_size) {
            if (use_global_scratchpad)
                global_scratchpad_ = create_scratchpad(scratchpad_size);
            else
                scratchpad_buffer_ = malloc(scratchpad_size, 64);
    }
    }

    virtual ~cpu_primitive_t() {
        delete global_scratchpad_;
        free(scratchpad_buffer_);
    }

protected:
    memory_tracking::grantor_t scratchpad(const exec_ctx_t &ctx) const {
        void *ptr = nullptr;
        if (pd()->attr()->scratchpad_mode_ == scratchpad_mode::user) {
            ptr = CTX_OUT_MEM(void *, MKLDNN_ARG_SCRATCHPAD);
        } else {
            ptr = global_scratchpad_
                ? global_scratchpad_->get() : scratchpad_buffer_;
        }

        return pd()->scratchpad_registry().grantor(ptr);
    }

private:
    void *scratchpad_buffer_;
    scratchpad_t *global_scratchpad_;
};

}
}
}

#else // dnnl v1.1.0

#include <assert.h>

#include "dnnl_types.h"

#include "common/c_types_map.hpp"
#include "common/primitive_attr.hpp"
#include "common/primitive_exec_types.hpp"
#include "common/utils.hpp"
#include "common/z_magic.hpp"

#define DEFINE_SCALES_BUFFER(scales) \
    alignas(16) float CONCAT2(scales, _buf16)[16] = {0}; \
    const float *scales; \
    if (pd()->attr()->output_scales_.defined()) { \
        scales = pd()->attr()->output_scales_.scales_; \
    } else { \
        scales = CTX_IN_MEM(const float *, DNNL_ARG_ATTR_OUTPUT_SCALES); \
        if (scales == nullptr) return status::invalid_arguments; \
        const auto scales_d = ctx.memory_mdw(DNNL_ARG_ATTR_OUTPUT_SCALES); \
        bool ok = scales_d.data_type() == data_type::f32 \
                && scales_d.ndims() == 1; \
        if (!ok) return status::invalid_arguments; \
        if (scales_d.dims()[0] == 1) { \
            utils::array_set(CONCAT2(scales, _buf16), scales[0], 16); \
            scales = CONCAT2(scales, _buf16); \
        } \
    } \
    MAYBE_UNUSED(scales);

#define DEFINE_ZERO_POINTS_BUFFER(zero_points_ptr, mem_arg) \
    const int32_t *zero_points_ptr \
            = pd()->attr()->zero_points_.defined(mem_arg) \
            ? pd()->attr()->zero_points_.get(mem_arg) \
            : CTX_IN_MEM( \
                    const int32_t *, DNNL_ARG_ATTR_ZERO_POINTS | mem_arg); \
    if (zero_points_ptr == nullptr) return status::invalid_arguments; \
    MAYBE_UNUSED(zero_points_ptr);

#define DEFINE_ZERO_POINT_VALUE(zero_point, mem_arg) \
    int32_t zero_point = 0; \
    if (pd()->attr()->zero_points_.defined(mem_arg)) { \
        const bool is_common = pd()->attr()->zero_points_.common(mem_arg); \
        assert(is_common && "expect common zero point"); \
        if (!is_common) return status::runtime_error; \
        zero_point = *pd()->attr()->zero_points_.get(mem_arg); \
    } else { \
        const auto zero_points_d \
                = ctx.memory_mdw(DNNL_ARG_ATTR_ZERO_POINTS | mem_arg); \
        bool ok = zero_points_d.data_type() == data_type::s32 \
                && zero_points_d.ndims() == 1 && zero_points_d.dims()[0] == 1; \
        if (!ok) return status::invalid_arguments; \
        const int32_t *zero_points_ptr = CTX_IN_MEM( \
                const int32_t *, DNNL_ARG_ATTR_ZERO_POINTS | mem_arg); \
        if (zero_points_ptr == nullptr) return status::invalid_arguments; \
        zero_point = *zero_points_ptr; \
    } \
    MAYBE_UNUSED(zero_point);
#endif // dnnl v1.1+ version

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // CPU_PRIMITIVE_HPP
