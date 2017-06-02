# BRANCH for non-jit version of MKL-DNN, to ease porting API to non-Intel platforms

## Quickstart:

```
./build.sh -h         # help</BR>
Intel: ./build.sh -tt # build and run all tests (no jit)</BR>
           --> build/    and build.log
SX:    ./build.sh -ST # build for *S*X and *T*race cmake setup</BR>
           --> build-sx/ and build-sx.log
```

## Purpose

This branch builds a "TARGET_VANILLA" version of mkl-dnn that:

* can remove all Intel Jit stuff

* adds some i/o funcs (because I know I will have to debug sooner or later)

- Various build options added
  - build.sh -h
- defaults are:
  - "vanilla" C/C++, and
  - builds a RelWithDebug libmkldnn.so
  - creates an ROOTDIR/install/ directory with extensive doxygen docs.
    - browse at install/share/doc/mkldnn/reference/html/index.html
- So far, I have added some debug stuff, a build.sh to build original/vanilla
  - I plan to add some slightly faster C++ impls (because the reference ones
    seem to be "gold standard" readable impls, rather than trying hard to be
    fast)
- I might try some C++ versions of Winograd convolution, if I have time.
- There are no plans to put low-level impls for other chips into this public repo

### SX modifications

- SX cmake support is developed in subdirectory dev-cmake-sx
  - changes to SX platform spec go into a tarfile that get untarred in gen-dnn root dir
  - *** cmake-3.8 *** is OK, cmake-3.0 is not
    - because cmake-3.8 has a handy call to Platform/SX-Initialize that I require
  - ./build.sh -ST      SX, TRACE [cmake --trace]
    - ---> build-sx/ and build-sx.log

- SX Platform issues
  - SX has no posix_memalign :(
  - SX int is only 32-bit (even though you can use -size_t64)
  - SX has many conversion warnings.
  - linking now OK
  - most tests OK (some memory formats don't need support for non-JIT)

## Github repos

NECLA master is on

	snake10:/local/kruus/sx/sx-dnn,
Japan master is on /mnt/scatefs_bm_nfs/lab/nlabhpg/simd/gen-dnn
       or, for me  ~/wrk/simd/gen-dnn


There is also a github master,

    git+ssh://git@github.com/kruus/gen-dnn.git

which is being left out-of-date until a decision is made on whether SX support
should enter public domain.  For at least FY17 1st quarter we will target basic
functionality, implementing no "new" algorithms.
                                   
Later on, for fancier vectorizable "tiled" algs, we may initially want to keep
those impls private -- this can be done via and add-on library that "grafts"
the additional convolutions onto the existing "engine" lists of primitives.

### (snake10) and remotes (git remote -v)

- snake10 is the main devel repo.
  - Pull latest SX commits from Japan:
    - git pull japan master
  - Push snake10 (Intel) work to Japan:
    - snake10:$ git push japan master:necla  # push to a tmp branch
    - sapphire2:$ git merge necla            # merge from branch
    - sapphire2:$ git branch -d necla        # delete tmp branch
  - For public-domain SX work:
    - Pull from upstream:
      - git pull upstream master
    - Push to github (public repo):
      - git push

### upstream merges

- clone this mkl-dnn fork
  - git clone https://github.com/kruus/gen-dnn.git
- upstream merge, from within cloned fork:
  - git checkout master # in case you are on a branch
  - git pull https://github.com/01org/mkl-dnn.git
  - # ... resolve merge conflicts ...
  - git commit # use default message
  - git push # ... origin master ... update gen-dnn on Github.

## SX Performance

### SX segfault

- examples/simple-net-cpp and simple-net-c both segfault
- tests/api-io-c does not segfault (linker issue???)

```
dbx ./simple-net-c
(dbx) run
... (absentee space fault) in cpu_engine.is_dense__Q3_6mkldnn4impl19memory_desc_wrapperCFb at 0x4000cc03c
(dbx) where
*  0 cpu_engine.is_dense__Q3_6mkldnn4impl19memory_desc_wrapperCFb(this = 0x0000008000022fe0, with_padding = 0) at 0x4000cc03c
   1 cpu_engine.init__Q5_6mkldnn4impl3cpu50ref_relu_fwd_t__tm__28_XC18mkldnn_data_type_tL_1_14pd_tFv_15mkldnn_status_t(this = 0x00000004049961f0) at 0x4001eb1b4
   2 __CPR229__create__tm__77_Q5_6mkldnn4impl3cpu50ref_relu_fwd_t__tm__28_XC18mkldnn_data_type_tL_1_14pd_t__21mkldnn_primitive_descSFPPJ93JPCQ3_J18JJ25J9op_desc_tP13mkldnn_enginePCJ93J_15mkldnn_status_t(pd = 0x0000008000022470, adesc = 0x0000008000020cc0, engine = 0x0000000404291940, hint_fwd = (nil)) at 0x4000a22dc
   3 mkldnn_primitive_desc_iterator::operator++(this = 0x0000008000022460), line 53 in "primitive_iterator.cpp"
   4 mkldnn_primitive_desc_create(primitive_desc = 0x0000008000021cb8, c_op_desc = 0x0000008000020cc0, engine = 0x0000000404291940, hint_fwd_pd = (nil)), line 131 in "primitive_iterator.cpp"
   5 simple_net.simple_net(), line 252 in "simple_net.c"
   6 main(argc = 1, argv = 0x00000080000003f8), line 463 in "simple_net.c"
   7 _start(0x1, 0x80000003f8, 0x8000000408) at 0x4000005c4
```

### Convolution is abysmally slow

- Even though im2col gemm is there, `[guest@ps6s0000 tests]$ ./api-io-c` take "forever".
- sxftrace shows that ref_convolution code is running (not the im2col one)

```
Execution Date : Thu Jun  1 04:52:06 2017
Total CPU Time : 0:02'33"936 (153.936 sec.)


PROC.NAME  FREQUENCY  EXCLUSIVE       AVER.TIME     MOPS   MFLOPS V.OP  AVER.    VECTOR I-CACHE O-CACHE   BANK CONFLICT    ADB HIT
                      TIME[sec](  % )    [msec]                   RATIO V.LEN      TIME    MISS    MISS CPU PORT  NETWORK   ELEM.%

mkldnn::impl::memory_desc_wrapper::off_v(const int *, bool) const
           214291968   106.519( 69.2)     0.000   3454.2      9.0 94.70  62.5    71.585   0.000   0.026    0.000    7.314     0.00
void mkldnn::impl::cpu::_ref_convolution_fwd_t<false, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1>::execute_forward()::[lambda(float &, int, int, int, int, int) (instance 1)]::operator ()(float &, int, int, int, int, int) const
               92928    46.739( 30.4)     0.503    396.7      4.6  0.00   0.0     0.000   0.001   1.109    0.000    0.000     0.00
mkldnn::impl::memory_desc_wrapper::off_v(const int *, bool) const
              603668     0.302(  0.2)     0.001   3409.2      8.0 94.67  62.2     0.202   0.000   0.000    0.000    0.021     0.00
void mkldnn::impl::cpu::ref_lrn_fwd_t<(mkldnn_data_type_t)1>::execute_forward()::[lambda(float *, int, int, int, int) (instance 1)]::operator ()(float *, int, int, int, int) const
               86528     0.157(  0.1)     0.002    564.7     25.3  0.00   0.0     0.000   0.004   0.002    0.000    0.000     0.00
void mkldnn::impl::cpu::_ref_convolution_fwd_t<false, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1>::execute_forward()
                   1     0.091(  0.1)    90.938    241.6      2.0  0.00  24.0     0.000   0.000   0.023    0.000    0.000     0.00
product        86537     0.041(  0.0)     0.000   2384.3      0.0 89.40  68.0     0.026   0.000   0.000    0.000    0.001     0.00
void mkldnn::impl::cpu::ref_lrn_fwd_t<(mkldnn_data_type_t)1>::execute_forward()
                   1     0.030(  0.0)    29.816    319.2      0.0  0.00  18.0     0.000   0.000   0.000    0.000    0.000     0.00
test3              1     0.025(  0.0)    24.928    367.3     24.3  1.43 256.0     0.000   0.000   0.000    0.000    0.000     0.00
void mkldnn::impl::cpu::_ref_convolution_fwd_t<false, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1, (mkldnn_data_type_t)1>::execute_forward()::[lambda(unsigned long long) (instance 1)]::operator ()(unsigned long long) const
               92928     0.024(  0.0)     0.000    100.3      0.0  0.00   0.0     0.000   0.000   0.010    0.000    0.000     0.00
```

- `build-sx.log` shows the convolution loop is UNVECTORIZED, because src..[...off(..)] is
  doing a slow function call to calculate offsets for "any" generic src format.
- Why is SX not using the im2col gemm convolution?
  - OK, time to come back to Intel desktop and gdb the primitive settings (it should be nchw
    and I need to check if this format is supported for the gemm_convolution)

