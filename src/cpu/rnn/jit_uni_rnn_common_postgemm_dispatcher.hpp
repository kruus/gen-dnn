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

#ifndef CPU_JIT_UNI_RNN_COMMON_POSTGEMM_DISPATCHER_HPP
#define CPU_JIT_UNI_RNN_COMMON_POSTGEMM_DISPATCHER_HPP
/** \file
 * This uni driver provides a full ref impl.
 */

#include "cpu_target.h"
#include "cpu_rnn_pd.hpp"
#include "rnn_utils.hpp"

#if TARGET_X86_JIT
#include "jit_uni_gru_cell_postgemm_1_bwd.hpp"
#include "jit_uni_gru_cell_postgemm_1_fwd.hpp"
#include "jit_uni_gru_cell_postgemm_2_bwd.hpp"
#include "jit_uni_gru_cell_postgemm_2_fwd.hpp"
#include "jit_uni_gru_lbr_cell_postgemm_bwd.hpp"
#include "jit_uni_gru_lbr_cell_postgemm_fwd.hpp"
#include "jit_uni_lstm_cell_postgemm_bwd.hpp"
#include "jit_uni_lstm_cell_postgemm_fwd.hpp"
#include "jit_uni_rnn_cell_postgemm_bwd.hpp"
#include "jit_uni_rnn_cell_postgemm_fwd.hpp"
#include "jit_uni_rnn_common_postgemm.hpp"
#endif // TARGET_X86_JIT

namespace dnnl {
namespace impl {
namespace cpu {

template <alg_kind_t alg_kind, prop_kind_t prop_kind>
float activation(float s, float alpha, float cliping);

template <prop_kind_t aprop, impl::data_type_t src_type,
        impl::data_type_t scratch_type>
struct rnn_postgemm_dispatcher {

    typedef typename prec_traits<src_type>::type src_data_t;
    typedef typename utils::conditional<src_type == data_type::u8, int32_t,
            float>::type acc_data_t;
    typedef typename utils::conditional<aprop == prop_kind::forward, acc_data_t,
            src_data_t>::type scratch_data_t;

    using class_name = rnn_postgemm_dispatcher<aprop, src_type, scratch_type>;
    typedef rnn_postgemm_sig((class_name::*postgemm_f));

    rnn_postgemm_dispatcher(
            const rnn_utils::rnn_conf_t &rnn, const rnn_pd_t *pd)
        : pd_(pd) {
#if TARGET_X86_JIT
        rnn_postgemm_ = nullptr;
        rnn_postgemm_part2_ = nullptr;
#endif // TARGET_X86_JIT

        // add check if in testing mode
        if (pd->attr()->rnn_tparams_.test_mode_) {
            auto ngates = utils::map(pd->cell_kind(), 0, alg_kind::vanilla_rnn,
                    1, alg_kind::vanilla_lstm, 4, alg_kind::vanilla_gru, 3,
                    alg_kind::lbr_gru, 3);
            assert(pd->attr()->rnn_tparams_.ngates_ == ngates);
            MAYBE_UNUSED(ngates);
        }

#if TARGET_X86_JIT
        bool const jit_path
                = utils::one_of(pd->desc()->prop_kind,
                          prop_kind::forward_inference,
                          prop_kind::forward_training, prop_kind::backward)
                && !pd->attr()->rnn_tparams_.test_mode_;

        bool const jit_fwd = jit_path
                && utils::one_of(pd->desc()->prop_kind,
                        prop_kind::forward_inference,
                        prop_kind::forward_training)
                && utils::one_of(src_type, data_type::f32, data_type::u8,
                        data_type::bf16);
        bool const jit_bwd = jit_path
                && utils::one_of(pd->desc()->prop_kind, prop_kind::backward)
                && utils::one_of(src_type, data_type::f32, data_type::bf16);
#endif // TARGET_X86_JIT

        switch (pd->cell_kind()) {
            case alg_kind::vanilla_lstm:
                // ref path
                postgemm_func = &class_name::lstm_postgemm;
#if TARGET_X86_JIT
                if (jit_fwd) {
                    if (mayiuse(avx512_core))
                        rnn_postgemm_ = new jit_uni_lstm_cell_postgemm_fwd<
                                avx512_core, src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(avx2))
                        rnn_postgemm_ = new jit_uni_lstm_cell_postgemm_fwd<avx2,
                                src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(sse41))
                        rnn_postgemm_
                                = new jit_uni_lstm_cell_postgemm_fwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                }
                if (jit_bwd) {
                    if (mayiuse(avx512_core))
                        rnn_postgemm_ = new jit_uni_lstm_cell_postgemm_bwd<
                                avx512_core, src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(avx2))
                        rnn_postgemm_ = new jit_uni_lstm_cell_postgemm_bwd<avx2,
                                src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(sse41))
                        rnn_postgemm_
                                = new jit_uni_lstm_cell_postgemm_bwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                }
#endif // TARGET_X86_JIT
                break;
            case alg_kind::vanilla_rnn:
                // ref path
                postgemm_func = &class_name::rnn_postgemm;
                switch (pd->activation_kind()) {
                    case alg_kind::eltwise_relu:
                        activation_func
                                = &activation<alg_kind::eltwise_relu, aprop>;
                        break;
                    case alg_kind::eltwise_tanh:
                        activation_func
                                = &activation<alg_kind::eltwise_tanh, aprop>;
                        break;
                    case alg_kind::eltwise_logistic:
                        activation_func
                                = &activation<alg_kind::eltwise_logistic,
                                        aprop>;
                        break;
                    default: assert(!"Unsupported activation function"); break;
                }
#if TARGET_X86_JIT
                if (jit_fwd) {
                    if (mayiuse(avx512_core))
                        rnn_postgemm_
                                = new jit_uni_rnn_cell_postgemm_fwd<avx512_core,
                                        src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(avx2))
                        rnn_postgemm_ = new jit_uni_rnn_cell_postgemm_fwd<avx2,
                                src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(sse41))
                        rnn_postgemm_ = new jit_uni_rnn_cell_postgemm_fwd<sse41,
                                src_type, scratch_type>(rnn, pd);
                }
                if (jit_bwd) {
                    if (mayiuse(avx512_core))
                        rnn_postgemm_
                                = new jit_uni_rnn_cell_postgemm_bwd<avx512_core,
                                        src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(avx2))
                        rnn_postgemm_ = new jit_uni_rnn_cell_postgemm_bwd<avx2,
                                src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(sse41))
                        rnn_postgemm_ = new jit_uni_rnn_cell_postgemm_bwd<sse41,
                                src_type, scratch_type>(rnn, pd);
                }
#endif // TARGET_X86_JIT
                break;
            case alg_kind::vanilla_gru:
                // ref path
                postgemm_func = &class_name::gru_part1_postgemm;
                postgemm_part2_func = &class_name::gru_part2_postgemm;
#if TARGET_X86_JIT
                // jitted path
                if (jit_fwd) {
                    if (mayiuse(avx512_core)) {
                        rnn_postgemm_ = new jit_uni_gru_cell_postgemm_part1_fwd<
                                avx512_core, src_type, scratch_type>(rnn, pd);
                        rnn_postgemm_part2_
                                = new jit_uni_gru_cell_postgemm_part2_fwd<
                                        avx512_core, src_type, scratch_type>(
                                        rnn, pd);
                    } else if (mayiuse(avx2)) {
                        rnn_postgemm_
                                = new jit_uni_gru_cell_postgemm_part1_fwd<avx2,
                                        src_type, scratch_type>(rnn, pd);
                        rnn_postgemm_part2_
                                = new jit_uni_gru_cell_postgemm_part2_fwd<avx2,
                                        src_type, scratch_type>(rnn, pd);
                    } else if (mayiuse(sse41)) {
                        rnn_postgemm_
                                = new jit_uni_gru_cell_postgemm_part1_fwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                        rnn_postgemm_part2_
                                = new jit_uni_gru_cell_postgemm_part2_fwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                    }
                }
                if (jit_bwd) {
                    if (mayiuse(avx512_core)) {
                        rnn_postgemm_ = new jit_uni_gru_cell_postgemm_part1_bwd<
                                avx512_core, src_type, scratch_type>(rnn, pd);
                        rnn_postgemm_part2_
                                = new jit_uni_gru_cell_postgemm_part2_bwd<
                                        avx512_core, src_type, scratch_type>(
                                        rnn, pd);
                    } else if (mayiuse(avx2)) {
                        rnn_postgemm_
                                = new jit_uni_gru_cell_postgemm_part1_bwd<avx2,
                                        src_type, scratch_type>(rnn, pd);
                        rnn_postgemm_part2_
                                = new jit_uni_gru_cell_postgemm_part2_bwd<avx2,
                                        src_type, scratch_type>(rnn, pd);
                    } else if (mayiuse(sse41)) {
                        rnn_postgemm_
                                = new jit_uni_gru_cell_postgemm_part1_bwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                        rnn_postgemm_part2_
                                = new jit_uni_gru_cell_postgemm_part2_bwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                    }
                }
#endif // TARGET_X86_JIT
                break;
            case alg_kind::lbr_gru:
                // ref path
                postgemm_func = &class_name::gru_lbr_postgemm;
#if TARGET_X86_JIT
                if (jit_fwd) {
                    if (mayiuse(avx512_core))
                        rnn_postgemm_ = new jit_uni_gru_lbr_cell_postgemm_fwd<
                                avx512_core, src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(avx2))
                        rnn_postgemm_
                                = new jit_uni_gru_lbr_cell_postgemm_fwd<avx2,
                                        src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(sse41))
                        rnn_postgemm_
                                = new jit_uni_gru_lbr_cell_postgemm_fwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                }
                if (jit_bwd) {
                    if (mayiuse(avx512_core))
                        rnn_postgemm_ = new jit_uni_gru_lbr_cell_postgemm_bwd<
                                avx512_core, src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(avx2))
                        rnn_postgemm_
                                = new jit_uni_gru_lbr_cell_postgemm_bwd<avx2,
                                        src_type, scratch_type>(rnn, pd);
                    else if (mayiuse(sse41))
                        rnn_postgemm_
                                = new jit_uni_gru_lbr_cell_postgemm_bwd<sse41,
                                        src_type, scratch_type>(rnn, pd);
                }
#endif // TARGET_X86_JIT
                break;
            default: assert(!"Unsupported algorithm kind"); break;
        }
#if TARGET_X86_JIT
        if (rnn_postgemm_) rnn_postgemm_->init(src_type);
        if (rnn_postgemm_part2_) rnn_postgemm_part2_->init(src_type);
#endif // TARGET_X86_JIT
    }

    ~rnn_postgemm_dispatcher() {
#if TARGET_X86_JIT
        delete rnn_postgemm_;
        delete rnn_postgemm_part2_;
#endif // TARGET_X86_JIT
    }

    rnn_postgemm_sig(unpoison) {
        // XXX (rsdubtso): This is a big hammer that unpoinsons everything
        // that a postgemm may touch to avoid writing per-cell-kind
        // versions of unpoisoning code. This must be removed alongside with
        // the big unpoison_outputs() hammer in common/primitive.cpp.

        size_t states_nelems = rnn.states_nld * rnn.states_ws_ld;
        size_t gates_nelems = rnn.gates_nld * rnn.gates_ws_ld;

        if (utils::one_of(pd_->desc()->prop_kind, prop_kind::forward_inference,
                    prop_kind::forward_training)) {
            msan_unpoison(states_t_l_, sizeof(*states_t_l_) * states_nelems);
            msan_unpoison(states_t_l_copy_,
                    sizeof(*states_t_l_copy_) * states_nelems);
            if (rnn.is_training)
                msan_unpoison(ws_gates_, sizeof(*ws_gates_) * gates_nelems);
        } else {
            msan_unpoison(diff_states_t_l_,
                    sizeof(*diff_states_t_l_) * (rnn.n_states + 1)
                            * (rnn.n_iter + 1) * rnn.states_nld
                            * rnn.states_ws_ld);
            msan_unpoison(
                    scratch_gates_, sizeof(*scratch_gates_) * gates_nelems);
            msan_unpoison(
                    scratch_cell_, sizeof(*scratch_cell_) * states_nelems);
        }
    }

    // template <typename src_data_t, typename acc_data_t>
    rnn_postgemm_sig(execute) {
#if TARGET_X86_JIT
        if (rnn_postgemm_) {
            rnn_postgemm_->execute(rnn, cell_position, ws_gates_,
                    scratch_gates_, states_t_l_, c_states_t_l_, states_tm1_l_,
                    c_states_tm1_l_, diff_states_t_l_, diff_states_t_lp1_,
                    diff_states_tp1_l_, weights_peephole_, bias_, ws_grid_,
                    scratch_cell_, states_t_l_copy_);
            unpoison(rnn, cell_position, ws_gates_, scratch_gates_, states_t_l_,
                    c_states_t_l_, states_tm1_l_, c_states_tm1_l_,
                    diff_states_t_l_, diff_states_t_lp1_, diff_states_tp1_l_,
                    weights_peephole_, bias_, ws_grid_, scratch_cell_,
                    states_t_l_copy_);
        } else
#endif // TARGET_X86_JIT
            (this->*postgemm_func)(rnn, cell_position, ws_gates_,
                    scratch_gates_, states_t_l_, c_states_t_l_, states_tm1_l_,
                    c_states_tm1_l_, diff_states_t_l_, diff_states_t_lp1_,
                    diff_states_tp1_l_, weights_peephole_, bias_, ws_grid_,
                    scratch_cell_, states_t_l_copy_);
    }

    // template <typename src_data_t, typename acc_data_t>
    rnn_postgemm_sig(execute_part2) {
#if TARGET_X86_JIT
        if (rnn_postgemm_part2_) {
            rnn_postgemm_part2_->execute(rnn, cell_position, ws_gates_,
                    scratch_gates_, states_t_l_, c_states_t_l_, states_tm1_l_,
                    c_states_tm1_l_, diff_states_t_l_, diff_states_t_lp1_,
                    diff_states_tp1_l_, weights_peephole_, bias_, ws_grid_,
                    scratch_cell_, states_t_l_copy_);
            unpoison(rnn, cell_position, ws_gates_, scratch_gates_, states_t_l_,
                    c_states_t_l_, states_tm1_l_, c_states_tm1_l_,
                    diff_states_t_l_, diff_states_t_lp1_, diff_states_tp1_l_,
                    weights_peephole_, bias_, ws_grid_, scratch_cell_,
                    states_t_l_copy_);
        } else
#endif // TARGET_X86_JIT
            (this->*postgemm_part2_func)(rnn, cell_position, ws_gates_,
                    scratch_gates_, states_t_l_, c_states_t_l_, states_tm1_l_,
                    c_states_tm1_l_, diff_states_t_l_, diff_states_t_lp1_,
                    diff_states_tp1_l_, weights_peephole_, bias_, ws_grid_,
                    scratch_cell_, states_t_l_copy_);
    }

private:
    float (*activation_func)(float s, float alpha, float cliping);
    rnn_postgemm_sig(rnn_postgemm);
    rnn_postgemm_sig(lstm_postgemm);
    rnn_postgemm_sig(gru_part1_postgemm);
    rnn_postgemm_sig(gru_part2_postgemm);
    rnn_postgemm_sig(gru_lbr_postgemm);

    const rnn_pd_t *pd_;
#if TARGET_X86_JIT
    jit_uni_rnn_postgemm *rnn_postgemm_;
    jit_uni_rnn_postgemm *rnn_postgemm_part2_;
#endif // TARGET_X86_JIT
    postgemm_f postgemm_func;
    postgemm_f postgemm_part2_func;

    DNNL_DISALLOW_COPY_AND_ASSIGN(rnn_postgemm_dispatcher);
};

using rnn_postgemm_fwd_f32_t = rnn_postgemm_dispatcher<prop_kind::forward,
        data_type::f32, data_type::f32>;
using rnn_postgemm_bwd_f32_t = rnn_postgemm_dispatcher<prop_kind::backward,
        data_type::f32, data_type::f32>;

using rnn_postgemm_fwd_bf16_t = rnn_postgemm_dispatcher<prop_kind::forward,
        data_type::bf16, data_type::f32>;
using rnn_postgemm_bwd_bf16_t = rnn_postgemm_dispatcher<prop_kind::backward,
        data_type::bf16, data_type::bf16>;

using rnn_postgemm_fwd_u8_t = rnn_postgemm_dispatcher<prop_kind::forward,
        data_type::u8, data_type::s32>;

} // namespace cpu
} // namespace impl
} // namespace dnnl

#endif
