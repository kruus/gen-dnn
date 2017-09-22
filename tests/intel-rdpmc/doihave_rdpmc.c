#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <sched.h>
#include <string.h>
#include <errno.h>
 
#define FATAL(fmt,args...) do {                \
    ERROR(fmt, ##args);                        \
    exit(1);                                   \
  } while (0)
 
#define ERROR(fmt,args...) \
    fprintf(stderr, fmt, ##args)
 
#define rdpmc(counter,low,high) \
     __asm__ __volatile__("rdpmc" \
        : "=a" (low), "=d" (high) \
        : "c" (counter))
 
int cpu, nr_cpus;
 
void handle ( int sig )
{
  FATAL("Ohoh!  cpu %d: caught %d\n", cpu, sig);
}
 
int main ( int argc, char *argv[] )
{
  nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
  for (cpu = 0; cpu < nr_cpus; cpu++) {
 
    pid_t pid = fork();
    if (pid == 0) {
      cpu_set_t cpu_set;
      CPU_ZERO(&cpu_set);
      CPU_SET(cpu, &cpu_set);
      if (sched_setaffinity(pid, sizeof(cpu_set), &cpu_set) < 0)
        FATAL("cannot set cpu affinity: %m\n");
 
      signal(SIGSEGV, &handle);
 
      unsigned int low, high;
      rdpmc(0, low, high);
 
      ERROR("cpu %d: low %u, high %u\n", cpu, low, high);
      break;
    }
  }
 
  return 0;
}
