#include "cloexec.h"
#include "common.h"
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/mman.h>
#include <linux/types.h>
#  include <stdbool.h>
#  include <stddef.h>
#  include <stdint.h>
#include <sys/wait.h>  // waitpid
#include <stdio.h>
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
#include <time.h>
#include <linux/perf_event.h>
#include <unistd.h>
//#include <linux/compiler.h>
/* Optimization barrier */
/* The "volatile" is due to gcc bugs */
#define barrier() __asm__ __volatile__("": : :"memory")
//
#ifndef __maybe_unused
# define __maybe_unused         __attribute__((unused))
#endif
// ... linux/compiler.h in tests/include/
#include <signal.h>
#include <linux/a.out.h>        // page_size

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

// rdpmc_instructions uses a "fixed-function" performance counter to return
// the count of retired instructions on the current core in the low-order
// 48 bits of an unsigned 64-bit integer.
unsigned long rdpmc_instructions()
{
   unsigned a, d, c;
 
   c = (1<<30);
   __asm__ volatile("rdpmc" : "=a" (a), "=d" (d) : "c" (c));
 
   return ((unsigned long)a) | (((unsigned long)d) << 32);;
}
 
// rdpmc_actual_cycles uses a "fixed-function" performance counter to return
// the count of actual CPU core cycles executed by the current core.  Core
// cycles are not accumulated while the processor is in the "HALT" state,
// which is used when the operating system has no task(s) to run on a
// processor core.
unsigned long rdpmc_actual_cycles()
{
   unsigned a, d, c;
 
   c = (1<<30)+1;
   __asm__ volatile("rdpmc" : "=a" (a), "=d" (d) : "c" (c));
 
   return ((unsigned long)a) | (((unsigned long)d) << 32);;
}
 
// rdpmc_reference_cycles uses a "fixed-function" performance counter to
// return the count of "reference" (or "nominal") CPU core cycles executed
// by the current core.  This counts at the same rate as the TSC, but does
// not count when the core is in the "HALT" state.  If a timed section of
// code shows a larger change in TSC than in rdpmc_reference_cycles, the
// processor probably spent some time in a HALT state.
unsigned long rdpmc_reference_cycles()
{
   unsigned a, d, c;
 
   c = (1<<30)+2;
   __asm__ volatile("rdpmc" : "=a" (a), "=d" (d) : "c" (c));
 
   return ((unsigned long)a) | (((unsigned long)d) << 32);;
}


static u64 mmap_read_self(void *addr)
{
    struct perf_event_mmap_page *pc = addr;
    u16 width = 0;
    u32 seq, idx, time_mult = 0, time_shift = 0;
    u64 count, pmc, cyc = 0, time_offset = 0, enabled, running, delta;
    int cap_user_time, cap_user_rdpmc;

    do {
        seq = pc->lock;
        barrier();

        enabled = pc->time_enabled;
        running = pc->time_running;
        cap_user_time  = pc->cap_user_time;
        cap_user_rdpmc = pc->cap_user_rdpmc;

        if (cap_user_time && enabled != running) {
            cyc = rdtsc();
            time_mult = pc->time_mult;
            time_shift = pc->time_shift;
            time_offset = pc->time_offset;
        }

        count = pc->offset;
        idx = pc->index;
        if (cap_user_rdpmc && idx){
            width = pc->pmc_width;
            pmc = rdpmc(idx - 1);
            //count += pmc;
        }

        barrier();
    } while (pc->lock != seq);

#if 1
    if (cap_user_rdpmc){ // sign extend the count?
        pmc <<= 64 - width;
        pmc >>= 64 - width; // signed shift right
    }
#endif
    count += pmc;

    if (cap_user_time && enabled != running) {
        // cap_user_time: scale rdtsc values to nanoseconds
        pr_debug(" cap_user_time! ");
        u64 quot, rem;

        quot = (cyc >> time_shift);
        rem = cyc & (((u64)1 << time_shift) - 1);
        delta = time_offset + quot * time_mult +
            ((rem * time_mult) >> time_shift);
        // delta is rdtsc in NANOSECONDS

        enabled += delta;       // optional? should this modify the pc instead?
        if (idx)
            running += delta;

        quot = count / running;
        rem = count % running;
        count = quot * enabled + (rem * enabled) / running;
        // count = delta; // for curiousity, it seems nanosecond time is OK
    }else{
        pr_debug(" idx %u cap_user_time=%d cap_user_rdpmc=%d",(unsigned)idx, cap_user_time, cap_user_rdpmc);
    }

    return count;
}

static int mmap_cap_user_time( void *addr )
{
    struct perf_event_mmap_page *pc = addr;
    int cap_user_time;
    u32 seq;

    do {
        seq = pc->lock;
        barrier();
        cap_user_time  = pc->cap_user_time;
        barrier();
    } while (pc->lock != seq);
    return cap_user_time;
}
// This uses the perf page to get rdtsc converted to ns, and avoids rdpmc
static u64 mmap_read_ns(void *addr)
{
    u32 time_mult = 0, time_shift = 0;
    u64 time_offset = 0, cyc, ns;

    {
        struct perf_event_mmap_page *pc = addr;
        // cap_user_time ==> can scale rdtsc values to nanoseconds
        // assert( mmap_cap_user_time(addr) );
        u32 seq;
        do {
            seq = pc->lock;
            barrier();
            time_mult   = pc->time_mult;
            time_shift  = pc->time_shift;
            time_offset = pc->time_offset;
            // cyc:  no cpuid, and not rdtscp !
            cyc = rdtsc();
            barrier();
        } while (pc->lock != seq);
    }
    {
        u64 quot, rem;
        quot = (cyc >> time_shift);
        rem = cyc & (((u64)1 << time_shift) - 1);
        ns = time_offset + quot * time_mult +
            ((rem * time_mult) >> time_shift);
    }
    return ns;
}

// The following DOES NOT WORK. (it tries to ignore enables/running and never do rdpmc)
static u64 mmap_read_tsc_ns_bad(void *addr)
{
    struct perf_event_mmap_page *pc = addr;
    u16 width = 0;
    u32 seq, idx, time_mult = 0, time_shift = 0;
    u64 count, pmc, cyc = 0, time_offset = 0, enabled, running, delta;
    int cap_user_time, cap_user_rdpmc;

    do {
        seq = pc->lock;
        barrier();

        enabled = pc->time_enabled;
        running = pc->time_running;
        idx     = pc->index;
        cap_user_time  = pc->cap_user_time;
        cap_user_rdpmc = pc->cap_user_rdpmc;

        cyc = rdtsc();
        if (cap_user_time /*&& enabled != running*/) {
            time_mult   = pc->time_mult;
            time_shift  = pc->time_shift;
            time_offset = pc->time_offset;
            {
                u64 quot, rem;

                quot = (cyc >> time_shift);
                rem = cyc & (((u64)1 << time_shift) - 1);
                delta = time_offset + quot * time_mult +
                    ((rem * time_mult) >> time_shift);

                pc->time_enabled += delta;       // not quite sure how this works
                if (idx)
                    pc->time_running += delta;
            }
        }
        barrier();
    } while (pc->lock != seq);
    count = delta;

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
    u64 delta_sum = 0;
    struct sigaction sa;
    char sbuf[STRERR_BUFSIZE];

    sigfillset(&sa.sa_mask);
    sa.sa_sigaction = segfault_handler;
    sigaction(SIGSEGV, &sa, NULL);

    {
        struct perf_event_attr attr = {
            .type = PERF_TYPE_HARDWARE,
            //.config = PERF_COUNT_HW_INSTRUCTIONS,
            .config = PERF_COUNT_HW_CPU_CYCLES,
            .exclude_kernel = 1,
        };
        fd = sys_perf_event_open(&attr, 0, -1, -1,
                                 perf_event_open_cloexec_flag());
        if (fd < 0) {
            pr_err("Error: sys_perf_event_open() syscall returned "
                   "with %d (%s)\n", fd,
                   strerror_r(errno, sbuf, sizeof(sbuf)));
            return -1;
        }
    }

#define USE_MMAP 2
#if USE_MMAP == 0
    // JUST this yields segfault
    u64 cyc0, cyc;
    for (n = 0; n < 6; n++) {
        cyc0 = rdpmc_actual_cycles();
        for (i = 0; i < loops; i++)
            tmp++;
        cyc = rdpmc_actual_cycles() - cyc0;
        loops *= 10;
        pr_debug("%14d: cyc=%-14Lu\n", n, (long long)cyc);
    }
#elif USE_MMAP == 1
    // even if never accesed, we must mmap it to avoid segfault for the rdpmc instruction.
    // Perhaps there is a simpler way? Some ioctl?
    long page_size = sysconf(_SC_PAGESIZE);
    addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
    if (addr == (void *)(-1)) {
        pr_err("Error: mmap() syscall returned with (%s)\n",
               strerror_r(errno, sbuf, sizeof(sbuf)));
        goto out_close;
    }
    u64 cyc0, cyc;
    for (n = 0; n < 6; n++) {
        cyc0 = rdpmc_actual_cycles();
        for (i = 0; i < loops; i++)
            tmp++;
        cyc = rdpmc_actual_cycles() - cyc0;
        loops *= 10;
        pr_debug("%14d: cyc=%-14Lu\n", n, (long long)cyc);
    }
    munmap(addr, page_size);
#elif USE_MMAP == 2
    // without regard to 'running', get segfault
    long page_size = sysconf(_SC_PAGESIZE);
    addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
    if (addr == (void *)(-1)) {
        pr_err("Error: mmap() syscall returned with (%s)\n",
               strerror_r(errno, sbuf, sizeof(sbuf)));
        goto out_close;
    }
    u64 cyc0, cyc;
    for (n = 0; n < 6; n++) {
        cyc0 = mmap_read_ns(addr);
        for (i = 0; i < loops; i++)
            tmp++;
        cyc = mmap_read_ns(addr) - cyc0;
        loops *= 10;
        pr_debug("%14d: nanoseconds=%-14Lu\n", n, (long long)cyc);
    }
    munmap(addr, page_size);
#else
    long page_size = sysconf(_SC_PAGESIZE);
    addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
    if (addr == (void *)(-1)) {
        pr_err("Error: mmap() syscall returned with (%s)\n",
               strerror_r(errno, sbuf, sizeof(sbuf)));
        goto out_close;
    }

    u64 const t0 = mmap_read_self(addr);
    u64 cyc0, cyc;
    for (n = 0; n < 6; n++) {
        u64 stamp, now, delta;

        stamp = mmap_read_self(addr);
        cyc0 = rdpmc_actual_cycles();

        for (i = 0; i < loops; i++)
            tmp++;

        now = mmap_read_self(addr);
        cyc = rdpmc_actual_cycles() - cyc0;

        loops *= 10;

        delta = now - stamp;
        pr_debug("%14d: stamp=%-14Lu now=%-14Lu delta=%14Lu cyc=%-14Lu\n",
                 n, (long long)(stamp-t0), (long long)(now-t0), (long long)delta, (long long)cyc);

        delta_sum += delta;
    }

    munmap(addr, page_size);
#endif
    pr_debug("   ");
out_close:
    close(fd);

    if (!delta_sum)
        return -1;

    return 0;
}

//int test__rdpmc(void)
int verbose = 1;
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
// vim: set ts=4 et ai:
