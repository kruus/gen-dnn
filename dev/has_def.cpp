
#include <iostream>
#include <iomanip>
#include <cstdint>
#include <type_traits>
#include <array>
#include <assert.h>
#include <limits>

using namespace std;

#define DNNL_SHORT_CIRCUIT_SELF_ASSIGN(other) \
    do { \
        if (this == &other) return *this; \
    } while (0)

#define DNNL_SHORT_CIRCUIT_SELF_COMPARISON(other) \
    do { \
        if (this == &other) return true; \
    } while (0)

#define DNNL_DISALLOW_COPY_AND_ASSIGN(T) \
    T(const T &) = delete; \
    T &operator=(const T &) = delete;

#define UNUSED(x) ((void)x)

#define IMPLICATION(cause, effect) (!(cause) || !!(effect))

namespace impl {

void *malloc(size_t size, int alignment){
    void * ret = ::malloc(size);
    UNUSED(alignment);
    return ret;
}
void free(void *p){
    ::free(p);
}

struct c_compatible {
    enum { default_alignment = 64 };
    static void *operator new(size_t sz) {
        return malloc(sz, default_alignment);
    }
    static void *operator new(size_t sz, void *p) {
        UNUSED(sz);
        return p;
    }
    static void *operator new[](size_t sz) {
        return malloc(sz, default_alignment);
    }
    static void operator delete(void *p) { free(p); }
    static void operator delete[](void *p) { free(p); }
};
}//impl::

namespace utils {
// Returns a value of type T by reinterpretting the representation of the input
// value (part of C++20).
//
// Provides a safe implementation of type punning.
//
// Constraints:
// - U and T must have the same size
// - U and T must be trivially copyable
template <typename T, typename U>
inline T bit_cast(const U &u) {
    static_assert(sizeof(T) == sizeof(U), "Bit-casting must preserve size.");
    // Use std::is_pod as older GNU versions do not support
    // std::is_trivially_copyable.
    static_assert(std::is_pod<T>::value, "T must be trivially copyable.");
    static_assert(std::is_pod<U>::value, "U must be trivially copyable.");

    T t;
    std::memcpy(&t, &u, sizeof(U));
    return t;
}

template <typename T, typename P>
constexpr bool one_of(T val, P item) {
    return val == item;
}
template <typename T, typename P, typename... Args>
constexpr bool one_of(T val, P item, Args... item_others) {
    return val == item || one_of(val, item_others...);
}

template <typename... Args>
inline bool any_null(Args... ptrs) {
    return one_of(nullptr, ptrs...);
}

template <typename T>
inline bool array_cmp(const T *a1, const T *a2, size_t size) {
    for (size_t i = 0; i < size; ++i)
        if (a1[i] != a2[i]) return false;
    return true;
}

template <typename T, typename U>
inline void array_set(T *arr, const U &val, size_t size) {
    for (size_t i = 0; i < size; ++i)
        arr[i] = static_cast<T>(val);
}

}//utils::

typedef int64_t dim_t;

/// Status values returned by the library functions.
typedef enum {
    /// The operation was successful
    dnnl_success = 0,
    /// The operation failed due to an out-of-memory condition
    dnnl_out_of_memory = 1,
    /// The operation failed because of incorrect function arguments
    dnnl_invalid_arguments = 2,
    /// The operation failed because requested functionality is not implemented
    dnnl_unimplemented = 3,
    /// Primitive iterator passed over last primitive descriptor
    dnnl_iterator_ends = 4,
    /// Primitive or engine failed on execution
    dnnl_runtime_error = 5,
    /// Queried element is not required for given primitive
    dnnl_not_required = 6,
} dnnl_status_t;

typedef dnnl_status_t status_t;

/// Hex representation for a **special** quiet NAN (!= NAN from math.h)
static const union {
    unsigned u;
    float f;
} DNNL_RUNTIME_F32_VAL_REP = {0x7fc000d0};
#define DNNL_RUNTIME_F32_VAL (DNNL_RUNTIME_F32_VAL_REP.f)


/** returns true if fp32 value denotes DNNL_RUNTIME_F32_VAL */
inline bool is_runtime_value(float val) {
    return utils::bit_cast<unsigned>(val) == DNNL_RUNTIME_F32_VAL_REP.u;
}

struct scales_t : public impl::c_compatible
{
#define DBG_SCALES 1
#if DBG_SCALES
#define MSG(STR) do { \
    printf(" %s:%lu,%d,%g",#STR,(long unsigned)count_,mask_,scales_[0]); \
    if (is_runtime_value(*scales_)) printf(" R"); \
    if (has_default_values()) printf(" D"); \
    printf("\n"); \
}while(0)
#else
#define MSG(STR) do {}while(0)
#endif
    scales_t() : count_(1), mask_(0), scales_(scales_buf_) {
        set(1.);
        assert( scales_[0] == 1.0 );
        assert( defined() );
        MSG(+scales_t());
    }
    scales_t(dim_t count, int mask, const float *scales)
        : scales_(scales_buf_) {
        set(count, mask, scales);
        MSG(+scales_t(count,mask,scales));
    }

    scales_t(const scales_t &rhs) : scales_t() {
        set(rhs.count_, rhs.mask_, rhs.scales_);
        MSG(+scales_t(const scales_t&));
    }

    ~scales_t() { cleanup(); }

    scales_t &operator=(const scales_t &rhs) {
        DNNL_SHORT_CIRCUIT_SELF_ASSIGN(rhs);
        status_t status = set(rhs.count_, rhs.mask_, rhs.scales_);
        assert(status == dnnl_status_t::dnnl_success);
        (void)status;
        MSG(+scales_t::operator=);
        return *this;
    }
#undef MSG
#undef DBG_SCALES

    bool operator==(const scales_t &rhs) const {
        bool ret = count_ == rhs.count_ && mask_ == rhs.mask_
                && !utils::any_null(scales_, rhs.scales_)
                && defined() == rhs.defined()
                && IMPLICATION(defined(),
                        utils::array_cmp(scales_, rhs.scales_, count_));
        return ret;
    }

    bool has_default_values() const {
        static_assert( std::numeric_limits<float>::is_iec559,
                " IEC559 states x {==,>,>=,<,<=} NaN is false; x!=NaN, true");
        // VE (Aurora) vfcp instruction does not test nan properly
        // This VIOLATES compiler claim to respect IEC 559/IEEE 754
        // **************************************
        //    VE BUG WORKAROUNDS HERE
        // **************************************
        //
        // First workaround:
//#pragma _NEC novector
        // (does using == instead of != "fix" the bug?)
        for (dim_t c = 0; c < count_; ++c) {
            //if (scales_[c] != 1.f) return false;
            //
            // alternate workaround (still allows vectorization)
            //
            if (!(scales_[c] == 1.f)) return false;
        }
        return true;
    }

    bool defined() const { return !is_runtime_value(scales_[0]); }

    status_t set(dim_t count, int mask, const float *scales);
    status_t set(float single_scale) { return this->set(1, 0, &single_scale); }

    dim_t count_;
    int mask_;
    float *scales_;

private:
    enum { scales_buf_size = 16 };
    float scales_buf_[scales_buf_size];

    void cleanup() {
        if (scales_ != scales_buf_ && scales_ != nullptr) impl::free(scales_);

        count_ = 1;
        mask_ = 0;
        scales_ = scales_buf_;
    }
};

status_t scales_t::set(dim_t count, int mask, const float *scales) {
    cleanup();

    count_ = count;
    mask_ = mask;

    if (is_runtime_value(*scales)) {
        scales_ = scales_buf_;
        scales_[0] = *scales;
    } else if (count_ == 1) {
        scales_ = scales_buf_;
        utils::array_set(scales_, scales[0], scales_buf_size);
    } else {
        scales_ = (float *)impl::malloc(count_ * sizeof(*scales_), 64);
        if (scales_ == nullptr) return dnnl_status_t::dnnl_out_of_memory;

        for (dim_t c = 0; c < count_; ++c)
            scales_[c] = scales[c];
    }

    return dnnl_status_t::dnnl_success;
}

struct A {
    A() : scales() {}
    void init(bool runtime, float const x=1.0f){
        if(!runtime){
            scales.set(x);
        }else{
            scales.set(DNNL_RUNTIME_F32_VAL);
        }
    }
    scales_t scales;
};

int main(int,char**){
    assert( DNNL_RUNTIME_F32_VAL != 1.0f );
    if(1){
        A a;
        assert( a.scales.defined() );
        assert( a.scales.has_default_values() );
        a.scales.set(2.0f);
        assert( a.scales.defined() );
        assert( !a.scales.has_default_values() );
        a.scales.set(DNNL_RUNTIME_F32_VAL);
        assert( !a.scales.defined() );
        assert( !a.scales.has_default_values() );
    }

    cout<<"\nGoodbye"<<endl;
    return 0;
}
// vim: et ts=4 sw=4 nopaste cindent cino=+2s,^=l0,\:0,N-s
