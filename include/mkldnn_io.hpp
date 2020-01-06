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
#if 0
    /** output various 'C' enums */
#define CIO_OP(TYPENAME) \
    inline std::ostream& operator<<(std::ostream& os, mkldnn_##TYPENAME##_t const x){ \
        os<<mkldnn_name_##TYPENAME(x); \
        return os; \
    }

    CIO_OP(status)
    CIO_OP(data_type)
    CIO_OP(prop_kind)
    CIO_OP(primitive_kind)
    CIO_OP(alg_kind)
    CIO_OP(engine_kind)
    CIO_OP(query)
#else
    // new-style uses include/mkldnn_debug.h
#define CIO_OP(TYPENAME) inline std::ostream& operator<<(std::ostream& os, mkldnn_##TYPENAME##_t const x)
    CIO_OP(status)              { return os << mkldnn_status2str(x); }
    CIO_OP(data_type)           { return os << mkldnn_dt2str(x); }
    CIO_OP(prop_kind)           { return os << mkldnn_prop_kind2str(x); }
    CIO_OP(primitive_kind)      { return os << mkldnn_prim_kind2str(x); }
    CIO_OP(alg_kind)            { return os << mkldnn_alg_kind2str(x); }
    CIO_OP(engine_kind)         { return os << mkldnn_engine_kind2str(x); }
    // new addtional
    CIO_OP(format_kind)         { return os << mkldnn_fmt_kind2str(x); }
    CIO_OP(format_tag)          { return os << mkldnn_fmt_tag2str(x); }
    CIO_OP(rnn_flags)           { return os << mkldnn_rnn_flags2str(x); }
    CIO_OP(rnn_direction)       { return os << mkldnn_rnn_direction2str(x); }
    CIO_OP(scratchpad_mode)     { return os << mkldnn_scratchpad_mode2str(x); }
    // old-style
    CIO_OP(query)               { os << mkldnn_name_query(x); return os; } // query:FOO
#endif
#undef CIO_OP
    // ------------- more complex types ------------------
    std::ostream& operator<<(std::ostream& os, mkldnn_dims_t const dims) MKLDNN_API;
    std::ostream& operator<<(std::ostream& os, mkldnn_blocking_desc_t const& bd) MKLDNN_API;
    std::ostream& operator<<(std::ostream& os, mkldnn_memory_desc_t const& md) MKLDNN_API;

    /** print a primitive --- to print the impl name, get its query string
     * via \c mkldnn_name_primitive_impl(const_mkldnn_primitive_t &prim); */
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive const& prim) MKLDNN_API;
    /** print a 'typedef mkldnn_primitive* mkldn_primitive_t' */
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive_t const prim) MKLDNN_API;
    //std::ostream& operator<<(std::ostream& os, mkldnn_primitive_at_t const& prim) MKLDNN_API;
}//mkldnn::
#endif // MKLDNN_IO
#endif // MKLDNN_IO_HPP
