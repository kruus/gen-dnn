
#include <stddef.h> // size_t

int hash = 0; // print at exit to try avoiding over-optimization

// in separate file to avoid over-optimization
int clobberhash_impl(char * const p, size_t const psz){
    int nz=0;
    for(size_t i=0U; i<psz; ++i){
        if(p[i] == '\0') ++nz;
        hash = ((hash<<23)|(hash>>(32-23))) ^ (int)p[i];
        p[i] = 'a' + hash%26;
    }
    return nz;
}
