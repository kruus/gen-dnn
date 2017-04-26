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

#ifndef UTILS_HPP
#define UTILS_HPP

#include <stddef.h>
#include <stdlib.h>
#include <assert.h>

#ifndef HAVE_POSIX_MEMALIGN
# if defined(_SX)
//  SX ** does not ** have memalign
# else
#  ifdef __GLIBC_PREREQ
#  if __GLIBC_PREREQ(2,3)
#  define HAVE_POSIX_MEMALIGN
#  endif
#  else
#  ifdef _POSIX_SOURCE
#  define HAVE_POSIX_MEMALIGN
#  endif
#  endif
# endif
#endif

#if 0 && defined(_SX) // posix_memalign compat...
#include <malloc.h>
#include <errno.h>
/* OHOH -- _SX does not even give us memalign
inline int posix_memalign(void **ptr, size_t align, size_t size) {
    bool ok=false;
    for(size_t i=sizeof(void*); i!=0; i*=2){
        if(align==i){
            ok=true;
            break;
        }
    }
    if(ok){
        int saved_errno=errno;
        void *p = memalign(align,size);
        if(p == nullptr){
            errno = saved_errno;
            return ENOMEM;
        }
        *ptr = p;
        return 0;
    }
    return EINVAL;
}
*/
#endif

namespace mkldnn {
namespace impl {

#define UNUSED(x) ((void)x)

#define CHECK(f) do { \
    status_t status = f; \
    if (status != status::success) \
    return status; \
} while (0)

namespace utils {

/* a bunch of std:: analogues to be compliant with any msvs version
 *
 * Rationale: msvs c++ (and even some c) headers contain special pragma that
 * injects msvs-version check into object files in order to abi-mismatches
 * during the static linking. This makes sense if e.g. std:: objects are passed
 * through between application and library, which is not the case for mkl-dnn
 * (since there is no any c++-rt dependent stuff, ideally...). */

/* SFINAE helper -- analogue to std::enable_if */
template<bool expr, class T = void> struct enable_if {};
template<class T> struct enable_if<true, T> { typedef T type; };

/* analogue std::conditional */
template <bool, typename, typename> struct conditional {};
template <typename T, typename F> struct conditional<true, T, F>
{ typedef T type; };
template <typename T, typename F> struct conditional<false, T, F>
{ typedef F type; };

template <bool, typename U, U, U> struct conditional_v {};
template <typename U, U t, U f> struct conditional_v<true, U, t, f>
{ static constexpr U value = t; };
template <typename U, U t, U f> struct conditional_v<false, U, t, f>
{ static constexpr U value = f; };

template <typename T> struct remove_reference { typedef T type; };
template <typename T> struct remove_reference<T&> { typedef T type; };
template <typename T> struct remove_reference<T&&> { typedef T type; };

template <typename T>
inline T&& forward(typename utils::remove_reference<T>::type &t)
{ return static_cast<T&&>(t); }
template <typename T>
inline T&& forward(typename utils::remove_reference<T>::type &&t)
{ return static_cast<T&&>(t); }

template <typename T>
inline T zero() { T zero = T(); return zero; }

template <typename T, typename P>
inline bool everyone_is(T val, P item) { return val == item; }
template <typename T, typename P, typename... Args>
inline bool everyone_is(T val, P item, Args... item_others) {
    return val == item && everyone_is(val, item_others...);
}

template <typename T, typename P>
inline bool one_of(T val, P item) { return val == item; }
template <typename T, typename P, typename... Args>
inline bool one_of(T val, P item, Args... item_others) {
    return val == item || one_of(val, item_others...);
}

template <typename... Args>
inline bool any_null(Args... ptrs) { return one_of(nullptr, ptrs...); }

inline bool implication(bool cause, bool effect) { return !cause || effect; }

template<typename T>
inline void array_copy(T *dst, const T *src, size_t size) {
    for (size_t i = 0; i < size; ++i) dst[i] = src[i];
}
template<typename T>
inline bool array_cmp(const T *a1, const T *a2, size_t size) {
    for (size_t i = 0; i < size; ++i) if (a1[i] != a2[i]) return false;
    return true;
}
template<typename T, typename U>
inline void array_set(T *arr, const U& val, size_t size) {
    for (size_t i = 0; i < size; ++i) arr[i] = val;
}

namespace product_impl {
template<size_t> struct int2type{};

template <typename T>
constexpr int product_impl(const T* arr, int2type<0>) { return arr[0]; }

template <typename T, size_t num>
inline T product_impl(const T* arr, int2type<num>) {
    return arr[0]*product_impl(arr+1, int2type<num-1>()); }
}

template <size_t num, typename T>
inline T array_product(const T* arr) {
    return product_impl::product_impl(arr, product_impl::int2type<num-1>());
}

template<typename T>
inline T array_product(const T *arr, size_t size) {
    T prod = 1;
    for (size_t i = 0; i < size; ++i) prod *= arr[i];
    return prod;
}

template <typename T, typename U>
inline typename remove_reference<T>::type div_up(const T a, const U b) {
    assert(b);
    return (a + b - 1) / b;
}

template <typename T, typename U>
inline T rnd_up(const T a, const U b) {
    return div_up(a, b) * b;
}

template <typename T, typename U, typename V>
inline U this_block_size(const T offset, const U max, const V block_size) {
    assert(offset < max);
    // TODO (Roma): can't use nstl::max() due to circular dependency... we
    // need to fix this
    const T block_boundary = offset + block_size;
    if (block_boundary > max)
        return max - offset;
    else
        return block_size;
}

template<typename T>
inline T nd_iterator_init(T start) { return start; }
template<typename T, typename U, typename W, typename... Args>
inline T nd_iterator_init(T start, U &x, const W &X, Args &&... tuple) {
    start = nd_iterator_init(start, utils::forward<Args>(tuple)...);
    x = static_cast<U>(start % static_cast<T>(X));  // ? do in "larger-of" type ?
    return start / static_cast<T>(X);
}

inline bool nd_iterator_step() { return true; }
template<typename U, typename W, typename... Args>
inline bool nd_iterator_step(U &x, const W &X, Args &&... tuple) {
    if (nd_iterator_step(utils::forward<Args>(tuple)...) ) {
        x = (x + 1) % X;
        return x == 0;
    }
    return false;
}

}

#if !defined(_SX)
inline void* malloc(size_t size, int alignment) {
    void *ptr;
    int rc = ::posix_memalign(&ptr, alignment, size);
    return (rc == 0) ? ptr : 0;
}
inline void free(void* p) { ::free(p); }
#else
#if 0
// Adapted from FFTW aligned malloc/free.  Assumes that malloc is at least
// sizeof(void*)-aligned. Allocated memory must be freed with free0.
inline int posix_memalign0(void **memptr, size_t alignment, size_t size)
{
    //#if defined(_SX)
    //    std::cout<<" align.h: posix_memalign0( (void**)memptr="<<(void*)memptr<<", alignment="<<alignment<<", size="<<size<<")"<<std::endl;
    //#endif
    if(alignment % sizeof (void *) != 0 || (alignment & (alignment - 1)) != 0)
        return EINVAL;
    void *p0=malloc(size+alignment);
    if(!p0) return ENOMEM;
    void *p=(void *)(((uintptr_t) p0+alignment)&~(alignment-1));
    *((void **) p-1)=p0;
    *memptr=p;
    return 0;
}

inline void free0(void *p)
{
    if(p) ::free(*((void **) p-1));
}
/** For SX, mkldnn::impl::malloc/free **MUST** be called in matching pairs */
inline void* malloc(size_t size, int alignment) {
    void *ptr;
    int rc = posix_memalign0(&ptr, alignment, size);
    return (rc == 0) ? ptr : 0;
}
inline void free(void* p) { free0(p); }
#else
/** SX -> std malloc and free, instead of aligning pointers.
 * Until I am sure that we do not use these pointers in mkldnn.hpp
 * shared pointers, we had better err on side of compatibility.
 *
 * (i.e. match with _malloc/_free lambdas in mkldnn.hpp)
 *
 * \p alignment arg ignored.
 */
inline void* malloc(size_t size, int /*alignment*/) { return ::malloc(size); }
inline void free(void* p) { ::free(p); }
#endif
#endif

struct c_compatible {
    enum { default_alignment = 64 };
    static void* operator new(size_t sz) {
        return malloc(sz, default_alignment);
    }
    static void* operator new(size_t sz, void* p) { UNUSED(sz); return p; }
    static void* operator new[](size_t sz) {
        return malloc(sz, default_alignment);
    }
    static void operator delete(void* p) { free(p); }
    static void operator delete[](void* p) { free(p); }
};

inline void yield_thread() { }

}
}

#endif

// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
