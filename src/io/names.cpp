/** \file
 * implement C functions to print various things in mkldnn.h
 */
#include "mkldnn_io.h"
#include "mkldnn_io.hpp"

#include <cstdio> // snprintf
#include <cstring>
#include <cerrno>
#include <assert.h>     // debug mode array bounds check (silently trimmed in Release mode)
#include <sstream>

#ifdef __cplusplus
extern "C"
{
#endif

// nonexistent on SX
//using std::snprintf;    // C11 snprintf specifices C99 behavior (always return # chars that would have been written)

#define NAMEENUM_T( TYPENAME ) char const* mkldnn_name_##TYPENAME ( mkldnn_##TYPENAME##_t const e )
/*NAMEENUM_T(status){*/
char const* mkldnn_name_status( mkldnn_status_t const e ){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_success): ret = "status:success"; break;
      case(mkldnn_out_of_memory): ret = "status:out_of_memory"; break;
      case(mkldnn_try_again): ret = "status:try_again"; break;
      case(mkldnn_invalid_arguments): ret = "status:invalid_arguments"; break;
      case(mkldnn_not_ready): ret = "status:not_ready"; break;
      case(mkldnn_unimplemented): ret = "status:unimplemented"; break;
      case(mkldnn_iterator_ends): ret = "status:iterator_ends"; break;
      case(mkldnn_runtime_error): ret = "status:runtime_error"; break;
      case(mkldnn_not_required): ret = "status:not_required"; break;
    }
    return ret;
}
NAMEENUM_T(data_type){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_data_type_undef): ret = "data_type:undef"; break;
      case(mkldnn_f32): ret = "data_type:f32"; break;
      case(mkldnn_s32): ret = "data_type:s32"; break;
      case(mkldnn_s16): ret = "data_type:s16"; break;
      case(mkldnn_s8): ret = "data_type:s8"; break;
      case(mkldnn_u8): ret = "data_type:u8"; break;
    }
    return ret;
}
NAMEENUM_T(memory_format){
    char const * ret = "Huh?";
    switch(e){
    case(mkldnn_format_undef): ret = "memory_format:format_undef"; break;
    case(mkldnn_any): ret = "memory_format:any"; break;
    case(mkldnn_blocked): ret = "memory_format:blocked"; break;
    case(mkldnn_x): ret = "memory_format:x"; break;
    case(mkldnn_nc): ret = "memory_format:nc"; break;
    case(mkldnn_nchw): ret = "memory_format:nchw"; break;
    case(mkldnn_nhwc): ret = "memory_format:nhwc"; break;
    case(mkldnn_chwn): ret = "memory_format:chwn"; break;
    case(mkldnn_nChw8c): ret = "memory_format:nChw8c"; break;
    case(mkldnn_nChw16c): ret = "memory_format:nChw16c"; break;
    case(mkldnn_oi): ret = "memory_format:oi"; break;
    case(mkldnn_io): ret = "memory_format:io"; break;
    case(mkldnn_oihw): ret = "memory_format:oihw"; break;
    case(mkldnn_ihwo): ret = "memory_format:ihwo"; break;
#if 1 // defined(TARGET_JIT)
    case(mkldnn_OIhw8i8o): ret = "memory_format:OIhw8i8o"; break;
    case(mkldnn_OIhw16i16o): ret = "memory_format:OIhw16i16o"; break;
    case(mkldnn_OIhw8i16o2i): ret = "memory_format:OIhw8i16o2i"; break;
    case(mkldnn_OIhw8o8i): ret = "memory_format:OIhw8o8i"; break;
    case(mkldnn_OIhw16o16i): ret = "memory_format:OIhw16o16i"; break;
    case(mkldnn_Ohwi8o): ret = "memory_format:Ohwi8o"; break;
    case(mkldnn_Ohwi16o): ret = "memory_format:Ohwi16o"; break;
    case(mkldnn_OhIw16o4i): ret = "memory_format:OhIw16o4i"; break;
#endif
    case(mkldnn_goihw): ret = "memory_format:goihw"; break;
#if 1 // defined(TARGET_JIT)
    case(mkldnn_gOIhw8i8o): ret = "memory_format:gOIhw8i8o"; break;
    case(mkldnn_gOIhw16i16o): ret = "memory_format:gOIhw16i16o"; break;
    case(mkldnn_gOIhw8i16o2i): ret = "memory_format:gOIhw8i16o2i"; break;
    case(mkldnn_gOIhw8o8i): ret = "memory_format:gOIhw8o8i"; break;
    case(mkldnn_gOIhw16o16i): ret = "memory_format:gOIhw16o16i"; break;
    case(mkldnn_gOhwi8o): ret = "memory_format:gOIhwi8o"; break;
    case(mkldnn_gOhwi16o): ret = "memory_format:gOIhwi16o"; break;
    case(mkldnn_gOhIw16o4i): ret = "memory_format:gOhIw16o4i"; break;
#endif
    // dup case(mkldnn_oIhw8i): ret = "memory_format:oIhw8i"; break; // alias for nChw8c
    // dup case(mkldnn_oIhw16i): ret = "memory_format:oIhw16i"; break; // alias for nChw16c
    }
    return ret;
}
NAMEENUM_T(padding_kind){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_padding_zero): ret = "padding_kind:padding_zero"; break;
    }
    return ret;
}
NAMEENUM_T(prop_kind){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_prop_kind_undef): ret = "prop_kind:prop_kind_undef"; break;
      case(mkldnn_forward_training): ret = "prop_kind:forward_training"; break;
      case(mkldnn_forward_inference): ret = "prop_kind:forward_inference"; break;
      //case(mkldnn_forward_scoring): ret = "prop_kind:forward_scoring"; break;
      //case(mkldnn_forward): ret = "prop_kind:forward"; break;
      case(mkldnn_backward): ret = "prop_kind:backward"; break;
      case(mkldnn_backward_data): ret = "prop_kind:backward_data"; break;
      case(mkldnn_backward_weights): ret = "prop_kind:backward_weights"; break;
      case(mkldnn_backward_bias): ret = "prop_kind:backward_bias"; break;
    }
    return ret;
}
NAMEENUM_T(primitive_kind){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_undefined_primitive): ret = "primitive_kind:undefined_primitive"; break;
      case(mkldnn_memory): ret = "primitive_kind:memory"; break;
      case(mkldnn_view): ret = "primitive_kind:view"; break;
      case(mkldnn_reorder): ret = "primitive_kind:reorder"; break;
      case(mkldnn_concat): ret = "primitive_kind:concat"; break;
      case(mkldnn_concat_inplace): ret = "primitive_kind:concat_inplace"; break;
      case(mkldnn_sum): ret = "primitive_kind:sum"; break;
      case(mkldnn_convolution): ret = "primitive_kind:convolution"; break;
      case(mkldnn_relu): ret = "primitive_kind:relu"; break;
      case(mkldnn_softmax): ret = "primitive_kind:softmax"; break;
      case(mkldnn_pooling): ret = "primitive_kind:pooling"; break;
      case(mkldnn_lrn): ret = "primitive_kind:lrn"; break;
      case(mkldnn_batch_normalization): ret = "primitive_kind:batch_normalization"; break;
      case(mkldnn_inner_product): ret = "primitive_kind:inner_product"; break;
      case(mkldnn_convolution_relu): ret = "primitive_kind:convolution_relu"; break;
    }
    return ret;
}
NAMEENUM_T(alg_kind){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_convolution_direct): ret = "alg_kind:convolution_direct"; break;
      case(mkldnn_pooling_max): ret = "alg_kind:pooling_max"; break;
      case(mkldnn_pooling_avg_include_padding): ret = "alg_kind:pooling_avg+padding"; break;
      case(mkldnn_pooling_avg_exclude_padding): ret = "alg_kind:pooling_avg-padding"; break;
      //case(mkldnn_pooling_avg): ret = "alg_kind:pooling_avg"; break; // short for avg-padding
      case(mkldnn_lrn_across_channels): ret = "alg_kind:lrn_across_channels"; break;
      case(mkldnn_lrn_within_channel): ret = "alg_kind:lrn_within_channel"; break;
    }
    return ret;
}
NAMEENUM_T(batch_normalization_flag){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_use_global_stats): ret = "batch_normalization_flag:use_global_stats"; break;
      case(mkldnn_use_scaleshift): ret = "batch_normalization_flag:use_scaleshift"; break;
      //case(mkldnn_omit_stats): ret = "batch_normalization_flag:omit_stats"; break; /* duplicate */
    }
    return ret;
}
NAMEENUM_T(engine_kind){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_any_engine): ret = "engine_kind:any_engine"; break;
      case(mkldnn_cpu): ret = "engine_kind:cpu"; break;
    }
    return ret;
}
NAMEENUM_T(query){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_query_undef): ret = "query:undef"; break;

      case(mkldnn_query_engine): ret = "query:engine"; break;
      case(mkldnn_query_primitive_kind): ret = "query:primitive_kind"; break;

      case(mkldnn_query_num_of_inputs_s32): ret = "query:num_of_inputs_s32"; break;
      case(mkldnn_query_num_of_outputs_s32): ret = "query:num_of_outputs_s32"; break;

      case(mkldnn_query_time_estimate_f64): ret = "query:time_estimate_f64"; break;
      case(mkldnn_query_memory_consumption_s64): ret = "query:memory_consumption_s64"; break;
                                                 /* memory and op descriptor section */
      case(mkldnn_query_some_d): ret = "query:some_d"; break;
      case(mkldnn_query_memory_d): ret = "query:memory_d"; break;
      case(mkldnn_query_convolution_d): ret = "query:convolution_d"; break;
      case(mkldnn_query_relu_d): ret = "query:relu_d"; break;
      case(mkldnn_query_softmax_d): ret = "query:softmax_d"; break;
      case(mkldnn_query_pooling_d): ret = "query:pooling_d"; break;
      case(mkldnn_query_lrn_d): ret = "query:lrn_d"; break;
      case(mkldnn_query_batch_normalization_d): ret = "query:batch_normalization_d"; break;
      case(mkldnn_query_inner_product_d): ret = "query:inner_product_d"; break;
      case(mkldnn_query_convolution_relu_d): ret = "query:convolution_relu_d"; break;
                                             /* (memory) primitive descriptor section */
      case(mkldnn_query_some_pd): ret = "query:some_pd"; break;
      case(mkldnn_query_input_pd): ret = "query:input_pd"; break;
      case(mkldnn_query_output_pd): ret = "query:output_pd"; break;
      case(mkldnn_query_src_pd): ret = "query:src_pd"; break;
      case(mkldnn_query_diff_src_pd): ret = "query:diff_src_pd"; break;
      case(mkldnn_query_weights_pd): ret = "query:weights_pd"; break;
      case(mkldnn_query_diff_weights_pd): ret = "query:diff_weights_pd"; break;
      case(mkldnn_query_dst_pd): ret = "query:dst_pd"; break;
      case(mkldnn_query_diff_dst_pd): ret = "query:diff_dst_pd"; break;
      case(mkldnn_query_workspace_pd): ret = "query:workspace_pd"; break;
    }
    return ret;
}
NAMEENUM_T(stream_kind){
    char const * ret = "Huh?";
    switch(e){
      case(mkldnn_any_stream): ret = "stream_kind:any_stream"; break;
      case(mkldnn_eager): ret = "stream_kind:eager"; break;
      case(mkldnn_lazy): ret = "stream_kind:lazy"; break;
    }
    return ret;
}
#undef NAMEENUM



#define NAMEFUNC_T( TYPENAME, VAR ) int mkldnn_name_##TYPENAME ( mkldnn_##TYPENAME##_t const *VAR, char * const buf, int len )

#define NAMEFUNC_TPTR( TYPENAME, VAR ) int mkldnn_name_##TYPENAME ( mkldnn_##TYPENAME##_t const VAR, char * const buf, int len )

#define SCAN_LASTNZ( ARR, SZ ) do{lastnz= -1; for(int i=0; i<(SZ); ++i){ if( ARR[i] > 0 ){ lastnz=i; }}}while(0)

/** debug flag for SX compiler bug with -Cdebug or -Cnoopt */
// - C99 behavior always returns the # of chars that would have been written.
// - Format conversion errors MIGHT still return -ve (error), so these lib
//   functions will just *assert* that no conversion errors happen.
// - and release-mode will just do-nothing (just in case)
#define SNPRINTF_DBG 0

#if SNPRINTF_DBG
// paranoia: set NUL into last char explicitly (*all* snprintfs should do this already)
//#define CHKBUF do{ assert(n>0); printf(" n,ret,len_in,errno=%d,%d,%d,%d ",n,ret,len); ret+=n; if( n>len ){b[len-1]='\0'; len=0;} else {b+=n; len-=n;} printf("-->ret,len=%d,%d\n",ret,len);}while(0)
#define CHKBUF do{ \
    printf(" n,ret,len_in,errno=%d,%d,%d,%d ",n,ret,len,errno); \
    if(n<=0) printf(" **n<=0** "); \
    ret+=n; \
    char *b0=b; \
    if( n>len ){ printf(" n>len "); b[len-1]='\0'; len=0;} \
    else {b+=n; len-=n; if(b[0]!='\0')printf(" **no-NUL** "); b[0]='\0';} \
    long const off=b-b0; \
    printf("-->ret,off,len=%d,%ld,%d, written=<%s>[%lu]\n",ret,off,len,b0,(long unsigned)(strlen(b0))); \
    fflush(stdout); \
}while(0)
#define ARR_NZ( ARR, NSCAN, FMTSPEC ) do{ \
    int lastnz= -1; SCAN_LASTNZ( ARR, NSCAN ); \
    printf(" lastnz=%d",lastnz); fflush(stdout); \
    if(lastnz < 0){ \
        errno=0; printf("zeros-case"); fflush(stdout); int const n = snprintf(b,len, "ZEROS" ); CHKBUF; \
    }else{ \
        for(int i=0; i<=lastnz; ++i){ \
            printf("\nfmt=%s ARR[%d]=" FMTSPEC, "%c" FMTSPEC, i, ARR[i]); \
            {errno=0; int const n = snprintf(b,len, "%c" FMTSPEC,(i==0?'{':','),ARR[i]); CHKBUF;} \
        } \
        printf(" fmt=%s", "}"); \
        {errno=0; int const n = snprintf(b,len,"}"); CHKBUF;} \
    } \
}while(0)

#else // silent version of macros
#define CHKBUF do{ \
    assert(n>0); \
    ret+=n; \
    if( n>len ){ /*b[len-1]='\0';*/ len=0;} \
    else {b+=n; len-=n;} \
}while(0)
#define ARR_NZ( ARR, NSCAN, FMTSPEC ) do{ \
    int lastnz= -1; SCAN_LASTNZ( ARR, NSCAN ); \
    if(lastnz < 0){ \
        int const n = snprintf(b,len, "ZEROS" ); CHKBUF; \
    }else{ \
        for(int i=0; i<=lastnz; ++i){ \
            {int const n = snprintf(b,len, "%c" FMTSPEC,(i==0?'{':','),ARR[i]); CHKBUF;} \
        } \
        {int const n = snprintf(b,len,"}"); CHKBUF;} \
    } \
}while(0)
#endif


#if 0
int mkldnn_name_dims( mkldnn_dims_t const dims, char *const buf, int len){ /* no macro - mkldnn_dims_t is already a ptr */
#if DBG
    fflush(stdout);
    int const len0 = len;
    printf("\nlen0=%d   ",len0); fflush(stdout);
#endif
    int ret = 0;
    char * b = buf; b[0]='\0';
    printf(" A %s %d %d",buf,ret,len); fflush(stdout);
    {errno=0; int const n = snprintf(b,len, "dims:"); CHKBUF;}
    printf(" B %s %d %d",buf,ret,len); fflush(stdout);
    if(dims == nullptr){
        {errno=0; printf(" null-branch"); fflush(stdout); int const n = snprintf(b,len,"NULL"); CHKBUF;}
    }else{
        printf(" C %s %d %d",buf,ret,len); fflush(stdout);
#if 0
        int lastnz=-1;
        SCAN_LASTNZ( dims, TENSOR_MAX_DIMS );
        for(int i=0; i<=lastnz; ++i){
            {int const n = snprintf(b,len, "%c%d",(i==0?'{':','),dims[i]); CHKBUF;}
            printf(" X %s %d %d",buf,ret,len); fflush(stdout);
        }
        {printf(" buf[%d]...last-} n=snprintf(&buf[%ld],%d,\"}\")\n",len0,(long)(b-&buf[0]),len); fflush(stdout); int const n = snprintf(b,len,"}"); printf("--> returned %d\n",n); CHKBUF;}
#else
        ARR_NZ( dims, TENSOR_MAX_DIMS, "%d" );
        printf(" D %s %d %d",buf,ret,len); fflush(stdout);
#endif
    }
#if DBG
    printf(" ret,len0=%d,%d", ret, len0 );
    if( ret <= len0 ) printf(", buf[ret-1] <%d> ", static_cast<int>(buf[ret-1]));
    if( ret >= len0 ) printf(", buf[len0-1] <%d> ", static_cast<int>(buf[len0-1]));
    // not required. snprintf assures this is ok: if( ret >= len0 ){ printf(" --> NUL "); buf[len0-1] = '\0'; }
#endif
    return ret;
#undef DBG
}
#else
int mkldnn_name_dims( mkldnn_dims_t const dims, char *const buf, int len){ /* no macro - mkldnn_dims_t is already a ptr */
    int ret = 0;
    char * b = buf; b[0]='\0';
    {int const n = snprintf(b,len, "dims:"); CHKBUF;}
    if(dims == nullptr){
        {int const n = snprintf(b,len,"NULL"); CHKBUF;}
    }else{
        ARR_NZ( dims, TENSOR_MAX_DIMS, "%d" );
    }
    return ret;
}
#endif

int mkldnn_name_dims_sz( mkldnn_dims_t const dims, size_t sz, char *const buf, int len){ /* no macro - mkldnn_dims_t is already a ptr */
    int ret = 0;
    char * b = buf; b[0]='\0';
    if( sz > TENSOR_MAX_DIMS ){
        assert(sz <= TENSOR_MAX_DIMS);
        sz = TENSOR_MAX_DIMS;
    }
    {int const n = snprintf(b,len, "dims:"); CHKBUF;}
    if(dims == nullptr){
        {int const n = snprintf(b,len,"NULL"); CHKBUF;}
    }else{
        for(size_t i=0; i<sz; ++i){
            {int const n = snprintf(b,len, "%c%d",(i==0?'{':','),dims[i]); CHKBUF;}
        }
        {int const n = snprintf(b,len,"}"); CHKBUF;}
    }
    return ret;
}
int mkldnn_name_strides( mkldnn_strides_t const strides, char *const buf, int len){ /* no macro - mkldnn_strides_t is already a ptr */
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "strides:"); CHKBUF;}
    if(strides == nullptr){
        {int n = snprintf(b,len,"NULL"); CHKBUF;}
    }else{
        ARR_NZ( strides, TENSOR_MAX_DIMS, "%td" );
    }
    return ret;
}
int mkldnn_name_strides_sz( mkldnn_strides_t const strides, size_t sz, char *const buf, int len){ /* no macro - mkldnn_strides_t is already a ptr */
    assert(sz < TENSOR_MAX_DIMS);
    int ret = 0;
    char * b = buf;
    if( sz > TENSOR_MAX_DIMS ){
        assert(sz <= TENSOR_MAX_DIMS);
        sz = TENSOR_MAX_DIMS;
    }
    {int n = snprintf(b,len, "strides:"); CHKBUF;}
    if(strides == nullptr){
        {int n = snprintf(b,len,"NULL"); CHKBUF;}
    }else{
        for(size_t i=0; i<sz; ++i){
            {int n = snprintf(b,len, "%c%td",(i==0?'{':','),strides[i]); CHKBUF;}
        }
        {int n = snprintf(b,len,"}"); CHKBUF;}
    }
    return ret;
}
int mkldnn_name_blocking_desc( mkldnn_blocking_desc_t const *bd, char *const buf, int len){
    int ret=0;
    char * b = buf;
    {int n = snprintf(b,len, "blocking_desc:"); CHKBUF;}
    if(bd == nullptr){
        {int n = snprintf(b,len,"NULL"); CHKBUF;}
    }else{
        //int lastnz=-1;
        {int n = snprintf(b,len, "block_dims"); CHKBUF;}
        ARR_NZ( bd->block_dims, TENSOR_MAX_DIMS, "%d" );
        //
        {int n = snprintf(b,len, ",strides[0]"); CHKBUF;}
        ARR_NZ( bd->strides[0], TENSOR_MAX_DIMS, "%td" );
        //
        {int n = snprintf(b,len, ",strides[1]"); CHKBUF;}
        ARR_NZ( bd->strides[1], TENSOR_MAX_DIMS, "%td" );
        //
        {int n = snprintf(b,len, ",padding_dims"); CHKBUF;}
        ARR_NZ( bd->padding_dims, TENSOR_MAX_DIMS, "%d" );
    }
    return ret;
}
int mkldnn_name_memory_desc( mkldnn_memory_desc_t const *md, char * const buf, int len){
    int ret=0;
    char * b = buf;
    {int n = snprintf(b,len, "memory_desc:"); CHKBUF;}
    if(md == nullptr){
        {int n = snprintf(b,len,"NULL"); CHKBUF;}
    }else{
        {int n = snprintf(b,len, "%s,%d,%s,%s"
                          , mkldnn_name_primitive_kind(md->primitive_kind)
                          , md->ndims
                          , mkldnn_name_data_type(md->data_type)
                          , mkldnn_name_memory_format(md->format)
                         ); CHKBUF;}
        /* md->dims */
        {int n = snprintf(b,len, ",dims="); CHKBUF;}
#if 0 // wrong: mkl-dnn can leave garbage in higher dims
        {int n = mkldnn_name_dims( md->dims, b,len ); CHKBUF;}
#elif 1
        {int n = mkldnn_name_dims_sz( md->dims, md->ndims, b,len ); CHKBUF;} // added a new func
#else
        for(int i=0; i<md->ndims; ++i){
            {int n = snprintf(b,len, "%c%d",(i==0?'{':','),md->dims[i]); CHKBUF;}
        }
        {int n = snprintf(b,len, "}"); CHKBUF;}
#endif
        /* TODO: There is a REAL FUNCTION to do this correctly ! */
        if(md->format == mkldnn_blocked){ /* md->blocking  (optional: for memory formats that use them) */
            {int n = mkldnn_name_blocking_desc( &md->layout_desc.blocking, b, len ); CHKBUF; }
        }
    }
    return ret;
}



// // now ways to print "C" structures
NAMEFUNC_T(convolution_desc, cd){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "convolution_desc:"); CHKBUF;}
    if(cd == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_T(relu_desc,rc){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "relu_desc:"); CHKBUF;}
    if(rc == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_T(softmax_desc,sd){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "softmax_desc:"); CHKBUF;}
    if(sd == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_T(pooling_desc,pd){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "pooling_desc:"); CHKBUF;}
    if(pd == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_T(lrn_desc,lrnd){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "lrn_desc:"); CHKBUF;}
    if(lrnd == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_T(batch_normalization_desc,bnd){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "batch_normalization_desc:"); CHKBUF;}
    if(bnd == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_T(inner_product_desc,ipd){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "inner_product_desc:"); CHKBUF;}
    if(ipd == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_T(convolution_relu_desc,crd){
    int ret = 0;
    char * b = buf;
    {int n = snprintf(b,len, "convolution_relu_desc:"); CHKBUF;}
    if(crd == nullptr){
        {int n = snprintf(buf,len,"NULL"); CHKBUF;}
    }else{
    }
    return ret;
}
NAMEFUNC_TPTR(primitive,prim){
    // mkldnn_primitive_t prim is a pointer-to mkldnn_primitive
    // =  mkldnn::impl::primitive_t *
    // = mkldnn_primitive *  (a virtual base class)
    int ret = 0;
    char *b = buf;
    std::ostringstream oss;
    using mkldnn::operator<<;
    oss<<*prim;
    {int n=snprintf(b,len,"\nmkldnn_primitive_t:%s",oss.str().c_str()); CHKBUF;}
    return ret;
}
NAMEFUNC_T(primitive_at,prat){
    int ret = 0;
    char *b = buf;
    {int n = snprintf(b,len, "primitive_at:"); CHKBUF;}
    {int n = snprintf(b,len, "%p", (void*)prat->primitive); CHKBUF;}
    {int n = snprintf(b,len, ",output_index=%lu",(long unsigned)prat->output_index); CHKBUF;}
    {
        std::ostringstream oss;
        using mkldnn::operator<<;
        oss<<*prat->primitive;
        {int n=snprintf(b,len,"\n...primitive:%s",oss.str().c_str()); CHKBUF;}
    }
    return ret;
}
#undef NAMEFUNC_T
#define NAMEFUNC_T2( SUFFIX, TYPENAME ) char const* mkldnn_name_##SUFFIX ( TYPENAME const e )
// /* opaque pointer types */
// /* These can now refer to the C++ printing routines */
//NAMEFUNC_T2(primitive_desc_iterator, const_mkldnn_primitive_desc_iterator_t);
//NAMEFUNC_T2(primitive_desc, const_mkldnn_primitive_desc_t);
//NAMEFUNC_T2(primitive, const_mkldnn_primitive_t);
//NAMEFUNC_T2(stream, const_mkldnn_stream_t);
#undef NAMEFUNC_T2
#ifdef __cplusplus
} // "C"
#endif
