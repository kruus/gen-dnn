/** Copyright 2019 NEC Labs America
 * see LICENSE file */
/** \file
 * \c mkldnn_memory_desc_init demo. */
#include "mkldnn_desc_init.h"
#include "mkldnn_debug.h"
#include <stdio.h>

static inline void md_0xFF( mkldnn_memory_desc_t *md ){
    for(int i=0; i<sizeof(mkldnn_memory_desc_t); ++i)
        ((char*)md)[i] = 0xFF;
}

static void print_dims( mkldnn_dims_t dims ){ // int[TENSOR_MAX_DIMS]
    for(int i=0; i<TENSOR_MAX_DIMS; ++i){
        printf("%c%d",(i==0?'{':','), dims[i]);
    }
    printf("}");
}
static void print_strides( mkldnn_strides_t dims ){ // identical to mkldnn_dims_t
    for(int i=0; i<TENSOR_MAX_DIMS; ++i){
        printf("%c%lld",(i==0?'{':','), (long long int)dims[i]);
    }
    printf("}");
}
static void print_data_type( mkldnn_data_type_t data_type ){
    printf( data_type       == mkldnn_f32 ? "f32"
            : data_type == mkldnn_s32 ? "s32"
            : data_type == mkldnn_s16 ? "s16"
            : data_type == mkldnn_s8  ? "s8"
            : data_type == mkldnn_u8  ? "u8"
            : /*mkldnn_data_type_undef*/ "dt_undef" );

}
static void print_blocking( mkldnn_blocking_desc_t *blk ){
    printf("{");
    if(!blk){
        printf("NULL");
    }else{
        printf("block_dims="); print_dims(blk->block_dims);
        printf(",strides[0]="); print_strides(blk->strides[0]);
        printf(",strides[1]="); print_strides(blk->strides[1]);
        printf(",padding_dims="); print_dims(blk->padding_dims);
        printf(",offset_padding_to_data="); print_dims(blk->offset_padding_to_data);
        printf(",offset_padding=%lld",(long long int)(blk->offset_padding));
    }
    printf("}");
}
static void print_md_full( mkldnn_memory_desc_t *md ){
    printf(" mkldnn_memory_desc_t{");
    if(!md){
        printf("NULL");
    }else{
        printf(" mkldnn_memory_desc_t{ndims=%d", md->ndims);
        print_dims( md->dims );
        print_data_type( md->data_type );
        print_blocking( &md->layout_desc.blocking );
    }
    printf("}");
    fflush(stdout);
}
mkldnn_status_t mkmd(int const ndims, mkldnn_memory_format_t const fmt,
        char const* msg)
{    
    int const verbose=1;
    mkldnn_data_type_t dt=mkldnn_f32;
#if 0
    int const dims[12]={1,2,3,4,5,6,7,8,9,10,11,12};
#else
    int dims[(ndims<0? 0: ndims)];
    for(int i=0; i<ndims; ++i) dims[i]=i;
#endif
    if(verbose>0){
        printf("\n=== md_0xFF; %d-dim %s",ndims,mkldnn_fmt2str(fmt));
        if(msg) printf(" : %s",msg);
        printf("\n");
    }
    mkldnn_memory_desc_t md;
    md_0xFF(&md);
    if(verbose>1)
        printf(" about to call memory_desc_init\n"); fflush(stdout);
    mkldnn_status_t s = mkldnn_memory_desc_init(&md,
            ndims, dims, dt, fmt);
    if(s != mkldnn_success) printf("ERROR: status = %d\n",s);
    if(verbose>1)
        printf(" back from memory_desc_init\n"); fflush(stdout);
    print_md_full(&md);
    return s;
}
int main(int argc, char** argv){
    if(1){
        printf("\n=== md_0xFF\n");
        mkldnn_memory_desc_t md;
        md_0xFF(&md);
        print_md_full(&md);
    }
    mkmd(666/*don't care*/, mkldnn_format_undef,""); // zero_md(), all zeros (no garbage)
    mkmd(1, mkldnn_x,"");
    mkmd(4, mkldnn_nchw,"");
    //mkmd(0, mkldnn_x,""); // acceptable! returns zero_md() [all-zeroes]
    mkmd(0, mkldnn_nchw,""); // zero_md() [all-zeros]
    printf("\nGoodbye");
    return 0;
}
/* vim: set et ts=4 sw=4 cino=^=l0,\:0,N-s: */
