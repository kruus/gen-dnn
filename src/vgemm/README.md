#### Standalone version of vanilla, CBLAS extended_sgemm

This has pared-down headers and code providing a tiny subset
of mkl-dnn utilities and some generic re-useable functionality
for im2col-gemm using system CBLAS.

We port and/or simplify the API for:

- extended\_sgemm
- convolution via BLAS and extended\_sgemm

