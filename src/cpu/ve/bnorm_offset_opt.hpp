
#ifndef CPU_REF_BATCH_NORMALIZATION_HPP
#error "This header must be included *after* ref_batch_noarmalization.hpp"
#endif

#include "ve/memory_desc_wrapper_opt.hpp"

namespace dnnl {
namespace impl {
namespace cpu {

/** wip: Can I build a generic batch-nested-for-loop object whose
 * innermost object:
 *
 * - builds a 'dims' vector (of compile-time ndims)
 * - where each for loop variable is assigned to one of the dims
 *
 * ex: 2 dims should eventually look like:
 * ```
 * array<int,2> dims;
 * FOR(a,A) FOR(b,B) kernel(dims); // where dims = {a,b}
 * ```
 * or perhaps
 * ```
 * dims_t d={0}; FOR(a,A) FOR(b,B) kernel(d)`
 * ```
 *
 * Adding the missing magic, it might look like:
 * ```
 * Loops<int,int> for2(A,B); // A,B runtime loop limits
 * auto foo = [&](dims_t const& d) { kernel code };
 * for2.exec(foo);
 * ```
 *
 * The finel step is to BATCH the kernel invocations by MVL (compile-time)
 * followed by a \c for2.tail() call that does any remaining kernel invokes.
 *
 * After another step, adding vectorized Batcher, code could look like
 * ```
 * template<typename T, typename U> For(T const A, T const B); // var args!
 * typedef dim_t Vecdims[MAXDIMS][MVL]; // stack "vector register" area
 * auto foo = [&](Vecdims &vecdims, int vl=MVL) { vector kernel };
 * Batcher batcher<MVL>( foo ); // install vec kernel in batcher
 * // optimization: Batcher batcher<MVL>(foo_mvl, foo_tail);
 * Fors(A,B)(batcher);
 * ```
 * \c Fors constructs packages of MVL invoking foo(vecdims), followed by
 * possible tail foo(vecdims,tail_len).
 */
struct For_ndhw_base {
     For_ndhw_base() {}
};
