# gen-dnn (SX) Todo

General Goal:

- add pure-C++ impls for convolution/ lrn/ other layers for all MKLDNN_JIT_TYPES==0
  - These types have **no support** for any of the 8/16 interleaved layouts

**[+]** done
**[-]** won't do
**[ ]** open
**[w]** work in progress

- [+] primitive iteration and benchdnn:
      [pull request 135](https://github.com/01org/mkl-dnn/pull/135)
  - this allows me to develop new loops under benchdnn, and compare
    performance of all impls in an mkl-dnn engine.
- [w] port existing loop transforms into benchdnn first

- [ ] SX bench.sh should never compile, but just check for build stamp
      file, and if OK go through the standard -t (or -tt or -ttt) tests,
      so the "same thing" runs on intel/sx platform.  This will take a
      *long, long time* until I add dense specializations in for several
      ref implementations.  These addons will be only in `vanilla/`, since
      they are low on Intel's radar for the moment.
- [ ] *add* fast loops/gemms/eltwise into mkldnn see B.2 Option below
- [ ] Try SX Windograd (study: what is mkl-dnn overlapped tiles layout?)
- [ ] Try direct convolution w/ nChw128c layout

- [-] TARGET_FOO compile flag:
      [issue 136](https://github.com/01org/mkl-dnn/issues/136)
  - insufficient interest at the moment.
  - will maintain separate fork for generic platform
  - A side effect could involve some light restructuring to promote `mayiuse`,
    `Xbyak::util::Cpu` and `Xbyak::util::Clock` visibility into (at least)
    `src/mkldnn_utils.hpp` scope.

## Misc. notes

## A. benchdnn iterations

- add --mode=A (All) option (0x4) to bench_mode flags to run all
  available mkldnn implementations for the primitive (for convolutions)

## B. Add more C++/blas convolution impls

- We investigated fast SX impls for convolutions and some other layers in a
  FY16 project (in-house svn repository),
- so, for example, we know some convolutions that get about 80% efficiency
  using an excellent MathKeisan gemm (and a Caffe-style within-loop im2col
  workspace)
- also measured faster eltwise ops for SX.

### B.1 Option (no)
**simd/sx/ convolution code --> padding support --> mkldnn integration**

1. Revisit this project which has dozens of convolution impls and a timing rig
   and add **padded** convolution support.
   - these impls are only for forward and no minibatch, but I don't think the
     minibatch dimension is involved with the inner gemm, so this is ok.

2. Add **dilated** kernel support.

2. Add **biased** kernel support (this is like a layout modifier for kernel weights)

2. Select a few impls (k0_xx_yy and the gemmm ones) and port them to mkldnn,
   adding the backward impls.

3. Then add corresponding backwards impls

### B.2 Option (yes)
**mkldnn benchdnn --> add alt `ref` impls**

Here we *inspire* the  benchdnn loop modifications "by analogy" to the
experiments of `simd/sx/m0.cpp`, which has many impls for these dense data
layouts:

| ---        | ---    | --- |
| **LAYOUT** | mkldnn | simd/sx/m0.cpp |
| ---        | ---    | --- |
| image      | chw    | nIm * imr * imc |
| kernel     | oihw   | nKrn * kd * kr * kc |
| ---        | ---    | --- |

### Alternative SX impls (later)

For Intel, JIT direct convolution approach is faster than the gemm approach.
Intel <em>does not</em> proceed via a JIT gemm approach!

For SX, with image inputs having &gt; 128 channels, direct convolution with a
new <em>nChw128c</em> (or 256?) data layout might be very fast.  Other layers
may then need to support the new SX-interleaving layout to avoid frequent
reordering.

Winograd tilings should also be very efficient on SX.

