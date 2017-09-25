#ifndef MKLDNN_IO_H
#define MKLDNN_IO_H
/** \file
 * i/o utilities extending basic mkldnn API.
 */
#ifndef MKLDNN_IO
//#define MKLDNN_IO 0 // until namespace bugs fixed
#define MKLDNN_IO 1
#endif

#if ! MKLDNN_IO
#error "mkldnn_io.h not available"
#else
#include "mkldnn.h"

#ifdef __cplusplus
extern "C"
{
#endif

/** \defgroup enum --> char const* */
/** @{ */
// gcc want the function attribute MKLDNN_API **after** the function decl for funcs returning a pointer
#define NAMEENUM_T( TYPENAME ) char const* mkldnn_name_##TYPENAME ( mkldnn_##TYPENAME##_t const e ) MKLDNN_API;
//NAMEENUM_T(status);     /* --> char const* mkldnn_name_status( mkldnn_status_t const e ) */
char const* mkldnn_name_status( mkldnn_status_t const e ) MKLDNN_API;
NAMEENUM_T(data_type);
NAMEENUM_T(memory_format);
NAMEENUM_T(padding_kind);
NAMEENUM_T(prop_kind);
NAMEENUM_T(primitive_kind);
NAMEENUM_T(alg_kind);
NAMEENUM_T(batch_normalization_flag);
NAMEENUM_T(engine_kind); /* enum */
NAMEENUM_T(stream_kind);
NAMEENUM_T(query);
#undef NAMEENUM_T
/** @} */

/** \defgroup variably sized outputs
 * These work like \c sprintf.
 * \return eturn the number of chars required to fully print the string.
 */
/** @{ */
#define NAMEFUNC_T( TYPENAME ) int MKLDNN_API mkldnn_name_##TYPENAME ( mkldnn_##TYPENAME##_t const *, char * const buf, int len )
/** int[TENSOR_MAX_DIMS (already a ptr type) */
int MKLDNN_API mkldnn_name_dims( mkldnn_dims_t const dims, char *const buf, int len);
/** print \c dims with \c sz elements. */
int MKLDNN_API mkldnn_name_dims_sz( mkldnn_dims_t const dims, size_t sz, char *const buf, int len);
/** ptrdiff_t[TENSOR_MAX_DIMS (already a ptr type) */
int MKLDNN_API mkldnn_name_strides( mkldnn_strides_t const strides, char *const buf, int len);
/** print \c strides with \c sz elements. */
int MKLDNN_API mkldnn_name_strides_sz( mkldnn_strides_t const strides, size_t sz, char *const buf, int len);
int MKLDNN_API mkldnn_name_blocking_desc( mkldnn_blocking_desc_t const *bd, char * const buf, int len);
int MKLDNN_API mkldnn_name_memory_desc( mkldnn_memory_desc_t const *md, char * const buf, int len);
// now ways to print "C" structures
NAMEFUNC_T(convolution_desc);
NAMEFUNC_T(relu_desc);
NAMEFUNC_T(softmax_desc);
NAMEFUNC_T(pooling_desc);
NAMEFUNC_T(lrn_desc);
NAMEFUNC_T(batch_normalization_desc);
NAMEFUNC_T(inner_product_desc);
NAMEFUNC_T(convolution_relu_desc);
NAMEFUNC_T(primitive_at); // this is mostly opaque at C level (use C++ version for details)
#define NAMEFUNC_TPTR( TYPENAME ) int MKLDNN_API mkldnn_name_##TYPENAME ( mkldnn_##TYPENAME##_t const, char * const buf, int len )
NAMEFUNC_TPTR(primitive); // mkldnn_primitive_t is a ptr-to-opaque-type (mkldnn_primitive*)
#undef NAMEFUNC_TPTR
#undef NAMEFUNC_T
/* */
//#define NAMEFUNC( TYPENAME ) char const* mkldnn_name_##TYPENAME ( mkldnn_##TYPENAME const *e ) MKLDNN_API
//NAMEFUNC(primitive_at);
//#undef NAMEFUNC

#define NAMEFUNC_T2( SUFFIX, TYPENAME ) char const* mkldnn_name_##SUFFIX ( TYPENAME const e ) MKLDNN_API
/* opaque pointer types */
/* These can now refer to the C++ printing routines */
#if 0
NAMEFUNC_T2(op_desc, const_mkldnn_op_desc_t); // this is void*, so might be tough to print
NAMEFUNC_T2(primitive_desc_iterator, const_mkldnn_primitive_desc_iterator_t);
NAMEFUNC_T2(primitive_desc, const_mkldnn_primitive_desc_t);
NAMEFUNC_T2(primitive, const_mkldnn_primitive_t);
NAMEFUNC_T2(stream, const_mkldnn_stream_t);
#endif
#undef NAMEFUNC_T2
/** @} */

#ifdef __cplusplus
} // "C"
#endif

#endif // MKLDNN_IO
// vim: et ts=4 sw=4 cindent
#endif // MKLDNN_IO_H
