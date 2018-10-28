#ifndef PERF_COMMON_H
#define PERF_COMMON_H
#if defined(_WIN32)
#elif defined(_SX)
#else // linux ...

#ifndef _GNU_SOURCE
#define _GNU_SOURCE // strerror_r return char*, sched_getcpu available, ...
#endif

#include <string.h>
#include <stdbool.h>
#include <stdarg.h>
#include <unistd.h>
#include <syscall.h>
#include <linux/types.h>
#include <linux/perf_event.h>

#define STRERR_BUFSIZE  128     /* For the buffer size of strerror_r */
// _GNU_SOURCE ...
#define STRERROR_R( ERRNO, STRERROR_BUF ) (strerror_r(ERRNO, STRERROR_BUF, sizeof(STRERROR_BUF)))
//#define STRERROR_R( STRERRR_BUF ) (strerror_r(ERRNO, STRERROR_BUF, sizeof(STRERROR_BUF)), STRERROR_BUF)

extern int verbose;
extern bool quiet, dump_trace;
extern int debug_ordered_events;
extern int debug_data_convert;

// debug stuff, from perf debug.h
#ifndef pr_fmt
#define pr_fmt(fmt) fmt
#endif
//
#define pr_err(fmt, ...) \
        eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
#define pr_warning(fmt, ...) \
        eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
#define pr_info(fmt, ...) \
        eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
#define pr_debug(fmt, ...) \
        eprintf(1, verbose, pr_fmt(fmt), ##__VA_ARGS__)
#define pr_debugN(n, fmt, ...) \
        eprintf(n, verbose, pr_fmt(fmt), ##__VA_ARGS__)
#define pr_debug2(fmt, ...) pr_debugN(2, pr_fmt(fmt), ##__VA_ARGS__)
#define pr_debug3(fmt, ...) pr_debugN(3, pr_fmt(fmt), ##__VA_ARGS__)
#define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
//
int eprintf(int level, int var, const char *fmt, ...) __attribute__((format(printf, 3, 4)));
int veprintf(int level, int var, const char *fmt, va_list args);

#ifndef likely
# define likely(x)              __builtin_expect(!!(x), 1)
#endif
//
#ifndef unlikely
# define unlikely(x)            __builtin_expect(!!(x), 0)
#endif

#define HAVE_ATTR_TEST 0
#if HAVE_ATTR_TEST
extern bool test_attr__enabled;
void test_attr__init(void);
void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
                     int fd, int group_fd, unsigned long flags);
#endif

static inline int
sys_perf_event_open(struct perf_event_attr *attr,
                      pid_t pid, int cpu, int group_fd,
                      unsigned long flags)
{
        int fd;

        fd = syscall(__NR_perf_event_open, attr, pid, cpu,
                     group_fd, flags);

#if HAVE_ATTR_TEST
        if (unlikely(test_attr__enabled))
                test_attr__open(attr, pid, cpu, fd, group_fd, flags);
#endif
        return fd;
}
#endif // linux ...
#endif /* PERF_COMMON_H */
