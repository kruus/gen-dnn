#ifndef PERF_H
#define PERF_H
/** \file
 * perf_begin/end.
 * - Initialize tick-level timing.  (Inactive for now)
 *   - rdtsc / rdpmd / freq governor settings?
 *
 * Note: rdpmc performance counters in linux can be [safely] used,
 *       it seems, after mmaping as per kernel tools source code. */
#if defined(__cplusplus)
extern "C" {
#endif

typedef struct { int fd; long page_size; void* addr; } perf_t;
perf_t const* perf_begin();
void perf_end(perf_t const* perf_ctx);

#if defined(__cplusplus)
} // extern "C"
#endif

#endif /* PERF_H */
