/*******************************************************************************
* Copyright 2019-2020 Intel Corporation
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

#include "dnnl_config.h"
#ifdef DNNL_ENABLE_PRIMITIVE_CACHE
#include "primitive_hashing.hpp"
#include "primitive_desc.hpp"
#include "type_helpers.hpp"
#include "utils.hpp"

// some primitives compare memory descriptors
#if USE_pooling
#include "pooling_pd.hpp"
#endif
#if USE_shuffle
#include "shuffle_pd.hpp"
#endif

namespace dnnl {
namespace impl {
namespace primitive_hashing {

key_t::key_t(const primitive_desc_t *pd, int impl_nthr)
    : primitive_kind_(pd->kind())
    , op_desc_(pd->op_desc())
    , attr_(pd->attr())
    , impl_id_(pd->impl_id())
    , impl_nthr_(impl_nthr) {
    init_mds(pd);
}

void key_t::init_mds(const primitive_desc_t *pd) {
    // Put only **relevant** memory descriptors to the list that might
    // affect the equality. The current cases are:
    // - Backward pooling and shuffle (rationale: implementation might depend
    //   on the fwd_hint_pd).
    //
    // Later this list can be extended. For instance, currently we don't store
    // convolution mds, because nthrs + op_desc (even with format=`any`) +
    // attributes fully define particular implementation.
    //
    // XXX: There is too much knowledge about in the internals...

    switch (primitive_kind_) {
#define NO_MDS_FOR_(kind) IF_USE_KIND(kind, \
        case primitive_kind::##kind##: { break; })
        NO_MDS_FOR_(batch_normalization)
        NO_MDS_FOR_(binary)
        NO_MDS_FOR_(concat)
        NO_MDS_FOR_(convolution)
        NO_MDS_FOR_(deconvolution)
        NO_MDS_FOR_(eltwise)
        NO_MDS_FOR_(gemm)
        NO_MDS_FOR_(inner_product)
        NO_MDS_FOR_(layer_normalization)
        NO_MDS_FOR_(logsoftmax)
        NO_MDS_FOR_(lrn)
        NO_MDS_FOR_(matmul)
#if USE_pooling
        case primitive_kind::pooling: {
            auto typed_pd = utils::downcast<const pooling_pd_t *>(pd);
            if (!typed_pd->is_fwd()) {
                mds.push_back(*typed_pd->diff_dst_md(0));
                mds.push_back(*typed_pd->diff_src_md(0));
            }
            break;
        }
#endif
        NO_MDS_FOR_(reorder)
        NO_MDS_FOR_(resampling)
        NO_MDS_FOR_(rnn)
#if USE_shuffle
        case primitive_kind::shuffle: {
            auto typed_pd = utils::downcast<const shuffle_pd_t *>(pd);
            if (!typed_pd->is_fwd()) {
                mds.push_back(*typed_pd->diff_dst_md(0));
                mds.push_back(*typed_pd->diff_src_md(0));
            }
            break;
        }
#endif
        NO_MDS_FOR_(sum)
        NO_MDS_FOR_(softmax)
        default: assert(!"unknown primitive_kind");
    }
#undef NO_MDS_FOR_
}

bool key_t::operator==(const key_t &rhs) const {
    DNNL_SHORT_CIRCUIT_SELF_COMPARISON(rhs);

    bool ret = true && primitive_kind_ == rhs.primitive_kind_
            && impl_id_ == rhs.impl_id_ && impl_nthr_ == rhs.impl_nthr_
            && mds.size() == rhs.mds.size() && *attr_ == *rhs.attr_;

    if (!ret) return false;

    switch (primitive_kind_) {
#define CAST_AND_COMPARE(kind) \
            ret = cast_and_compare<kind##_desc_t>(op_desc_, rhs.op_desc_);
#define CASE(kind) IF_USE_KIND(kind, \
        case primitive_kind::kind: CAST_AND_COMPARE(kind); break;)

        // NOTE: make sure that op_descs for all primitives are compared below
        CASE(batch_normalization)
        CASE(binary)
        CASE(concat)
        CASE(convolution)
        CASE(deconvolution)
        CASE(eltwise)
        CASE(gemm)
        CASE(inner_product)
        CASE(layer_normalization)
        CASE(logsoftmax)
        CASE(lrn)
        CASE(matmul)
        CASE(pooling)
        CASE(reorder)
        CASE(resampling)
        CASE(rnn)
        CASE(shuffle)
        CASE(sum)
        CASE(softmax)
        //case primitive_kind::batch_normalization:
        //    ret = cast_and_compare<batch_normalization_desc_t>(
        //            op_desc_, rhs.op_desc_);
        //    break;
        default: assert(!"unknown primitive_kind");
#undef CASE
#undef CAST_AND_COMPARE
    }

    if (!ret) return false;

    for (size_t i = 0; i < mds.size(); ++i)
        if (mds[i] != rhs.mds[i]) return false;

    return true;
}

} // namespace primitive_hashing
} // namespace impl
} // namespace dnnl
#endif // DNNL_ENABLE_PRIMITIVE_CACHE
