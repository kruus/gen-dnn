/*******************************************************************************
 * Copyright 2020 NEC Labs America, Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not
* use this file except in compliance with the License.  You may obtain a copy
* of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
* WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
* License for the specific language governing permissions and limitations under
* the License.
*******************************************************************************/
/** \file handle various compiler/os retrictions.
 *
 * handle minor compiler/os peculiarities.
 *
 */
#ifndef DNNL_OS_H
#define DNNL_OS_H

#if defined(__ve)
#define strnlen strnlen_s
#endif

// How is the restrict keyword handled? (disallow it as you encounter errors, please)
#if defined(_SX) // deprecated
#elif defined(__ve)
// restrict is allowed
//#   ifndef __restrict
//#   define __restrict restrict /* ve/musl/include/stdlib.h uses __restrict !!! */
//#   endif
#elif defined(__INTEL_COMPILER) || defined(__GNUC__)
//#define restrict /*no-restrict*/
#elif defined(WIN32)
// ???
#else
// ???
#endif // restrict keyword handling

// Any restrictions on the alignas attribute?
#ifdef __ve
#   define alignas(x) alignas((x) > 16 ? 16 : (x))
#endif

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
#endif // DNNL_OS_H
