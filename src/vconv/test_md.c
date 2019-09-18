#include "mkldnn_desc_init.h"
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
int main(int argc, char** argv){
    if(1){
        printf("\n=== md_0xFF\n");
        mkldnn_memory_desc_t md;
        md_0xFF(&md);
        print_md_full(&md);
    }
    if(1){
        printf("\n=== md_0xFF, then 'x' 1D tensor\n");
        mkldnn_memory_desc_t md;
        md_0xFF(&md);
        mkldnn_memory_format_t fmt = mkldnn_x;
        int ndims=1; // note: fmt and ndims MUST be compatible
        int dims[12]={1,2,3,4,5,6,7,8,9,10,11,12};
        //int dims[12]={1,0};
        mkldnn_data_type_t dt=mkldnn_f32;
        printf(" about to call memory_desc_init\n"); fflush(stdout);
        mkldnn_status_t s = mkldnn_memory_desc_init(&md, ndims, dims, dt, fmt );
        if(s != mkldnn_success){
            printf("ERROR: status = %d\n",s);
        }
        printf(" back from memory_desc_init\n"); fflush(stdout);
        print_md_full(&md);
    }
    printf("\nGoodbye");
    return 0;
}


