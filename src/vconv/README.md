#### vconv mkl-dnn convolution

This is a lightly modified gen-dnn subset supporting <B>convolution functions</B>.

gen-dnn is a port of mkl-dnn that can compile without x86 JIT,
and with some support for VE Aurora chip.

- depends also on libvgemm (included in libvconv.a, but not included in libvconv.so)
- API has been simplified, pointers named as in libvednn

- still have issue of libvednn lacking bias update during backward pass.

