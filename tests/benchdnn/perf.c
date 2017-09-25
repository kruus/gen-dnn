#include "perf.h"

#if defined(_WIN32) || defined(_SX)
static perf_t perf_ctx_unused = {.fd=0, .page_size=0, .addr = (void*)0 };
perf_t const* perf_begin() { return &perf_ctx_unused; }
void perf_end(perf_t const* perf_ctx) {}
#else // linux ...

/* This code was snarfed from linux kernel "perf" tools and it
 * sets things up so rdpmc doesn't hang. */
#include "perf_common.h"
#include "perf_cloexec.h"

#include <stdlib.h>
#include <signal.h>
#include <sys/mman.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <sys/wait.h>  // waitpid
#include <errno.h>
#include <stdio.h>
#include <time.h>
#include <linux/perf_event.h>
//#  include <asm/types.h>
typedef uint64_t u64;
typedef int64_t s64;
typedef __u32 u32;
typedef __s32 s32;
typedef __u16 u16;
typedef __s16 s16;
typedef __u8  u8;
typedef __s8  s8;
// ... tests/linux/types.h extensions
//#include "perf.h"
//#include "debug.h"
//#include "tests/tests.h"
//#include "arch-tests.h"
//#include <linux/compiler.h>
/* Optimization barrier */
/* The "volatile" is due to gcc bugs */
#define barrier() __asm__ __volatile__("": : :"memory")
//
#ifndef __maybe_unused
# define __maybe_unused         __attribute__((unused))
#endif
// ... linux/compiler.h in tests/include/
//#include <signal.h>
//#include <linux/a.out.h>        // page_size

#if 1
static u64 rdpmc(unsigned int counter)
{
	unsigned int low, high;

	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));

	return low | ((u64)high) << 32;
}

static u64 rdtsc(void)
{
	unsigned int low, high;

	asm volatile("rdtsc" : "=a" (low), "=d" (high));

	return low | ((u64)high) << 32;
}
#endif

static u64 mmap_read_self(void *addr)
{
	struct perf_event_mmap_page *pc = addr;
	u32 seq, idx, time_mult = 0, time_shift = 0;
	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;

	do {
		seq = pc->lock;
		barrier();

		enabled = pc->time_enabled;
		running = pc->time_running;

		if (enabled != running) {
			cyc = rdtsc();
			time_mult = pc->time_mult;
			time_shift = pc->time_shift;
			time_offset = pc->time_offset;
		}

		idx = pc->index;
		count = pc->offset;
		if (idx)
			count += rdpmc(idx - 1);

		barrier();
	} while (pc->lock != seq);

	if (enabled != running) {
		u64 quot, rem;

		quot = (cyc >> time_shift);
		rem = cyc & ((1 << time_shift) - 1);
		delta = time_offset + quot * time_mult +
			((rem * time_mult) >> time_shift);

		enabled += delta;
		if (idx)
			running += delta;

		quot = count / running;
		rem = count % running;
		count = quot * enabled + (rem * enabled) / running;
	}

	return count;
}

/*
 * If the RDPMC instruction faults then signal this back to the test parent task:
 */
static void segfault_handler(int sig __maybe_unused,
			     siginfo_t *info __maybe_unused,
			     void *uc __maybe_unused)
{
        fprintf(stderr, "Ohoh!  caught signal %d\n", sig);
	exit(-1);
}

static int __test__rdpmc(void)
{
	volatile int tmp = 0;
	u64 i, loops = 1000;
	int n;
	int fd;
	void *addr;
	struct perf_event_attr attr = {
		.type = PERF_TYPE_HARDWARE,
		.config = PERF_COUNT_HW_INSTRUCTIONS,
		.exclude_kernel = 1,
	};
	u64 delta_sum = 0;
        struct sigaction sa;
	char sbuf[STRERR_BUFSIZE];

	sigfillset(&sa.sa_mask);
	sa.sa_sigaction = segfault_handler;
	sigaction(SIGSEGV, &sa, NULL);

	fd = sys_perf_event_open(&attr, 0, -1, -1,
				 perf_event_open_cloexec_flag());
	if (fd < 0) {
		pr_err("Error: sys_perf_event_open() syscall returned "
		       "with %d (%s)\n", fd, STRERROR_R(errno, sbuf) );
		return -1;
	}

        long page_size = sysconf(_SC_PAGESIZE);
	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
	if (addr == (void *)(-1)) {
		pr_err("Error: mmap() syscall returned with (%s)\n",
		       STRERROR_R(errno, sbuf) );
		goto out_close;
	}

	for (n = 0; n < 6; n++) {
		u64 stamp, now, delta;

		stamp = mmap_read_self(addr);

		for (i = 0; i < loops; i++)
			tmp++;

		now = mmap_read_self(addr);
		loops *= 10;

		delta = now - stamp;
		pr_debug("%14d: %14Lu\n", n, (long long)delta);

		delta_sum += delta;
	}

	munmap(addr, page_size);
	pr_debug("   ");
out_close:
	close(fd);

	if (!delta_sum)
		return -1;

	return 0;
}

#if 0
//int test__rdpmc(void)
int verbose = 0;
int main(int argc __attribute__((unused)), char**argv __attribute__((unused)) )
{
	int status = 0;
	int wret = 0;
	int ret;
	int pid;

	pid = fork();
	if (pid < 0)
		return -1;

	if (!pid) {
		ret = __test__rdpmc();

		exit(ret);
	}

	wret = waitpid(pid, &status, 0);
	if (wret < 0 || status)
		return -1;

        fprintf(stdout," Good! rdpmc seems to have worked!\n");
	return 0;
}
#endif

perf_t const* perf_begin()
{
    int fd;
    void *addr = 0;
    perf_t* ret = 0;
    char sbuf[STRERR_BUFSIZE];
    struct perf_event_attr attr = {
        .type = PERF_TYPE_HARDWARE,
        .config = PERF_COUNT_HW_INSTRUCTIONS,
        .exclude_kernel = 1,
    };

    fd = sys_perf_event_open(&attr, 0, -1, -1,
                             perf_event_open_cloexec_flag());
    if (fd < 0) {
        pr_err("Error: sys_perf_event_open() syscall returned "
               "with %d (%s)\n", fd, STRERROR_R(errno, sbuf) );
        goto close_fd;
    }
    ret = malloc(sizeof(perf_t));
    if( ret == NULL ){
        pr_err("Out of memory");
        goto close_fd;
    }
    ret->fd = fd;
    ret->page_size = sysconf(_SC_PAGESIZE);
    ret->addr = mmap(NULL, ret->page_size, PROT_READ, MAP_SHARED, fd, 0);
    if (ret->addr == (void *)(-1)) {
        pr_err("Error: mmap() syscall returned with (%s)\n",
               STRERROR_R(errno, sbuf) );
        goto close_fd;
    }
    return ret;
close_fd:
    close(fd);
    ret = 0;
    return ret;
}
void perf_end(perf_t const* perf)
{
    if( perf != NULL ){
        munmap( perf->addr, perf->page_size );
        close( perf->fd );
    }
    free(perf);
}
#endif // linux ...
/* vim: set sw=4,et: */
