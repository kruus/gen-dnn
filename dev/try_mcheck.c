#include <mcheck.h>
#include <stdlib.h>
#include <stdio.h>
#if 0
-- Try it
ncc --std=c11 try_mcheck.c -o try_mcheck &&
VE_NODE_NUMBER=2 MALLOC_TRACE=`pwd`/mtrace.log script -e -a -c ./try_mcheck
-- console output copied to file 'typescript'


It seems that mtrace and mcheck calls are completely ignored on VE
#endif

void mycallback(int mcheck_status)
{
    printf("abortfunc, mcheck_status=%d\n", mcheck_status);
    fflush(stdout);
}

int main(int argc, char *argv[])
{
    mtrace(); // NO EFFECT for VE
    int j, bogus;
    mcheck_pedantic( &mycallback );
    printf("Begin allocations\n"); fflush(stdout);
    for( j=0; j<2; ++j)
        bogus += (int)malloc(100); // memory leak
    void * mem = calloc(16,16); // mem leak
    //free(mem);
    //free(mem); // double-free -- on VE, causes
    //  "double free or corruption (top): 0x0000601000000520"
    //  with backtrace and memory map
    printf("\nGoodbye %d\n", (int)bogus); fflush(stdout);
    muntrace();
    exit(EXIT_SUCCESS);
}
