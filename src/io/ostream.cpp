
#include "mkldnn_io.hpp"

#include <iostream>

namespace mkldnn {

#define BUFLEN 2048
    std::ostream& operator<<(std::ostream& os, mkldnn_dims_t const dims){
        char buf[BUFLEN];
        mkldnn_name_dims(dims,buf,BUFLEN);
        os<<buf;
        return os;
    }
    std::ostream& operator<<(std::ostream& os, mkldnn_strides_t const strides){
        char buf[BUFLEN];
        mkldnn_name_strides(strides,buf,BUFLEN);
        os<<buf;
        return os;
    }
    std::ostream& operator<<(std::ostream& os, mkldnn_blocking_desc_t const& bd){
        char buf[BUFLEN];
        mkldnn_name_blocking_desc(&bd,buf,BUFLEN);
        os<<buf;
        return os;
    }
    std::ostream& operator<<(std::ostream& os, mkldnn_memory_desc_t const& md){
        char buf[BUFLEN];
        mkldnn_name_memory_desc(&md,buf,BUFLEN);
        os<<buf;
        return os;
    }
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive_t const prim) {
        os<<" primitive{kind="<<prim->kind();
        return os;
    }
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive_at_t const& prim) {
        os<<prim.primitive;
        os<<",output_index="<<prim.output_index;
        return os;
    }

}//mkldnn::
