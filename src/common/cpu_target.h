/*******************************************************************************
* Copyright 2020 NEC Labs America
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
#ifndef CPU_TARGET_H
#define CPU_TARGET_H
/** \file
 * extra build-time cpu/isa macros, based dnnl_config.h ONLY.
 * Some appear frequently, so short 0/1 values are preferred.
 * \sa dnnl_config.h */
#include "dnnl_config.h"

#if 0 // OLD WAY
// TARGET_cpu[_subtype] 0/1 values establish uniform names based on
// CMAKE_SYSTEM_PROCESSOR and DNNL_ISA build option.
/// default build always is TARGET_X86_JIT
#define TARGET_X86_JIT DNNL_TARGET_X86_JIT
/// VANILLA "ref impls" build is a new option (equiv DNNL_X86_64?)
#define TARGET_X86 DNNL_TARGET_X86
/// A cross-compile target, uniform name for defined(__ve)
#define TARGET_VE DNNL_TARGET_VE
#else
#if defined(DNNL_AARCH64)
#define TARGET_AARCH64 1
#define TARGET_X86_JIT 0
#define TARGET_X86 0
#define TARGET_VE 0
#elif defined(DNNL_ARCH_VE) || defined(DNNL_VE) || defined(__ve)
#define TARGET_AARCH64 0
#define TARGET_X86_JIT 0
#define TARGET_X86 0
#define TARGET_VE 1
#elif defined(DNNL_X64)
#define TARGET_AARCH64 0
#define TARGET_X86_JIT 1
#define TARGET_X86 1
#define TARGET_VE 0
#elif defined(DNNL_ARCH_GENERIC)
#define TARGET_AARCH64 0
#define TARGET_X86_JIT 0
#define TARGET_X86 0
#define TARGET_VE 0
#endif
#endif

// Implies presence of intel intrinsics header.
#if defined(__x86_64__) || defined(_M_X64)
#define DNNL_X86_64
#endif

// other common variables come from cmakedefine
#if defined(DNNL_USE_MKL) && !defined(USE_MKL)
#define USE_MKL DNNL_USE_MKL
#endif
#if defined(DNNL_USE_CBLAS) && !defined(USE_CBLAS)
#define USE_CBLAS DNNL_USE_CBLAS
#endif

// expand to code [or nothing] depending on 0/1 flag USE_kind
//#define IF_USE_KIND0(kind, ...)
//#define IF_USE_KIND1(kind, ...) __VA_ARGS__
//#define IF_USE_KIND(kind, ...) CONCAT2(IF_USE_KIND, USE_##kind)(kind, __VA_ARGS__)
//#endif

#endif // CPU_TARGET_H
