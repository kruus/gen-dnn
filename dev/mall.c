#include <malloc.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char**argv){
    int bogus=0;
    //size_t n=10U* 1024ULL*1024U*1024U;
    size_t n=1U* 1024ULL*1024U*1024U;
    //size_t n=128U* 1024ULL*1024U;
    char big0[n];
    memset( &big0[0], 1, n );
    char* big = (char*)malloc(n);
    if(big){
        printf("ok, malloc'ed %lu bytes\n", (long unsigned)n);
        for(size_t off=0; off<n; off+=1024){
            big[off] = '\0';
        }
        for(size_t off=1; off<n; off+=1024){
            bogus += (int)big[off] + (int)big0[off];
        }
    }else{
        printf("Could not malloc %lu bytes\n", (long unsigned)n);
    }
    free(big);
    printf("\nGoodbye - bogus=%d\n", bogus);
    return 0;
}
