
#include "mkldnn_io.hpp"
#include "primitive.hpp"

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
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive const& prim){
        // this is a pure virtual base class
        os<<" C ";
        os<<" "<<prim.kind()<<"@"<<(void*)&prim
            <<",inputs["<<prim.inputs().size()<<"]"
            <<",outputs["<<prim.outputs().size()<<"]"
            ;
        os.flush();
#if 1
        if(prim.kind() == mkldnn_memory){
            os<<" M:";
            for(size_t i=0; i<prim.inputs().size(); ++i){
                mkldnn_primitive_at_t const& x=prim.inputs()[i];
                os<<"\n             inputs["<<i<<"]=";
                os<<"{@"<<(void*)(x.primitive)<<",output_index="<<x.output_index<<"}";
#if 0
                os<<x;
#endif
                os.flush();
            }
            for(size_t i=0; i<prim.outputs().size(); ++i){
                os<<"\n             outputs["<<i<<"]="; os.flush();
                //mkldnn::impl::primitive_t const *x=prim.outputs()[i];
                if(i>=1U) {os<<" (break)"; break;}
                mkldnn_primitive const *x=prim.outputs()[i];
                os<<"@"<<(void*)x;
#if 0 // bombs on SX
                os<<*x;
#endif
                os.flush();
            }
        }
#endif
        return os;
    }
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive_t const prim) {
        if(prim==nullptr) os<<"mkldnn_primitive_t:NULL";
        else os << *prim;
        return os;
    }
    std::ostream& operator<<(std::ostream& os, mkldnn_primitive_at_t const& prim) {
        os<<" A ";
        mkldnn_primitive const &x = *prim.primitive;
        os<<x;
        os<<" B ";
        os<<",output_index="<<prim.output_index;
        return os;
    }

}//mkldnn::
