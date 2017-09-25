#ifndef MKLDNN_IO_HPP
#define MKLDNN_IO_HPP
#ifndef MKLDNN_IO
//#define MKLDNN_IO 0 // until namespace bugs fixed
#define MKLDNN_IO 1
#endif

#if ! MKLDNN_IO
#error "mkldnn_io.h not available"
#else
//#include "mkldnn.h"
#include "mkldnn_io.h"
// You will likely need the following include in .cpp codes :
//#include "primitive.hpp"

#include <iostream>

namespace mkldnn {
    /** output various 'C' enums */
#define CIO_OP(TYPENAME) \
    inline std::ostream& operator<<(std::ostream& os, mkldnn_##TYPENAME##_t const x){ \
        os<<mkldnn_name_##TYPENAME(x); \
        return os; \
    }

    CIO_OP(status)
        CIO_OP(data_type)
        CIO_OP(memory_format)
        CIO_OP(padding_kind)
        CIO_OP(prop_kind)
        CIO_OP(primitive_kind)
        CIO_OP(alg_kind)
        CIO_OP(batch_normalization_flag)
        CIO_OP(engine_kind)
        CIO_OP(stream_kind)
        CIO_OP(query)
#undef CIO_OP
    // ------------- more complex types ------------------
    std::ostream& operator<<(std::ostream& os, mkldnn_dims_t const dims);
    std::ostream& operator<<(std::ostream& os, mkldnn_strides_t const strides);
    std::ostream& operator<<(std::ostream& os, mkldnn_blocking_desc_t const& bd);
    std::ostream& operator<<(std::ostream& os, mkldnn_memory_desc_t const& md);

    std::ostream& operator<<(std::ostream& os, mkldnn_primitive const& prim);
    /** print a 'typedef mkldnn_primitive* mkldn_primitive_t' */
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive_t const prim);
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive_at_t const& prim);
}//mkldnn::
#endif // MKLDNN_IO
#endif // MKLDNN_IO_HPP
