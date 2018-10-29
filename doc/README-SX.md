## gen-dnn (SX) Quickstart
# BRANCH for non-jit version of MKL-DNN, to ease porting API to non-Intel platforms

Start with `./build.sh -h         # help</BR>`

```
./build.sh usage:
        t) # [0] increment test level: (1) examples, (2) tests (longer), ...
            # Apr-14-2017 build timings:
            # 0   : build    ~ ?? min  (jit), 1     min  (vanilla)
            # >=1 : examples ~  1 min  (jit), 13-16 mins (vanilla)
            # >=2 : test_*   ~ 10 mins (jit), 108   mins (vanilla)
            # >=3 : benchdnn (bench.sh) performance/correctness tests (long)
        v) # [yes] (vanilla C/C++ only: no src/cpu/ JIT assembler)
        j) # force Intel JIT (src/cpu/ JIT assembly code)
        d) # [no] debug release
        D) # [no] Doxygen-only : build documentation and then stop
        q) # quick: skip doxygen docs [default: run doxygen if build OK]
        Q) # really quick: skip build and doxygen docs [JUST run cmake and stop]
        p) # permissive: disable the FAIL_WITHOUT_MKL switch
        S) # SX cross-compile (size_t=64, built in build-sx/, NEW: default if $CC==sxcc)
        s) # SX cross-compile (size_t=32, built in build-sx/) DISCOURAGED
            # -s is NOT GOOD: sizeof(ptrdiff_t) is still 8 bytes!
        r) # reference impls only: no -DUSE_CBLAS compile flag (->no im2col gemm)
        w) # reduce compiler warnings
        W) # lots of compiler warnings (default)
        T) # cmake --trace
    h | *) # help
Example: time a full test run for a debug compilation --- time ./build.sh -dtt
         SX debug compile, quick (no doxygen)         --- time ./build.sh -Sdq
         *just* run cmake, for SX debug compile       ---      ./build.sh -SdQ
         *just* create doxygen docs                   ---      ./build.sh -D
Debug: Individual tests can be run like build-sx/tests/gtests/test_relu
```
| System | Example
|:------ |:--------
| Intel: | ./build.sh -tt # build and run all tests (no jit)
|        | --> build/    and build.log<
|        | ./build.sh -tt # build and run all tests (with jit)
| ---    | ---
| SX:    | ./build.sh -ST # build for <em>S</em>X and <em>T</em>race cmake setup
|        |   --> build-sx/ and build-sx.log
|  or    | ./build.sh -SdqT # debug build (no doxygen) for SX
| ---    | ---

- :new: -S is auto-detected if \$CC is the sxcc cross compiler.
  - SX cannot use -t (test) because you need to log in to the SX first
  - SX always does *vanilla* compile (non-jit)
  - SX begins with -T verbose cmake trace, since cmake support is incomplete.

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
  - *cmake-3.8* is OK, cmake-3.0 is not
    - because cmake-3.8 has a handy call to Platform/SX-Initialize that I require
  - ./build.sh -ST      SX, TRACE [cmake --trace]
    - ---> build-sx/ and build-sx.log

- SX Platform issues
  - SX has no posix_memalign :(
  - SX int is only 32-bit (even though you can use -size_t64)
  - SX has many conversion warnings.
  - linking now OK
  - most tests OK (some memory formats do not need support for non-JIT)
  - snprintf does not follow C99 conventions: it does not return "the length that would have been written"


## Github repos

NECLA master is on

	snake10:/local/kruus/sx/sx-dnn,
Japan master is on /mnt/scatefs_bm_nfs/lab/nlabhpg/simd/gen-dnn
       or, for me  ~/wrk/simd/gen-dnn


There is also a github master,
    git+ssh://git@github.com/necla-ml/gen-dnn.git

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
  - [NEW] with ssh RemoteForward set up in snake10:~/.ssh/config as
```
Host zoro # was japan17
  User nlabhpg
  HostName XXXXXXXXXXX
  RemoteForward 22222 localhost:22
```
    - and a zoro:~/.ssh/config of
```
host snake10
    User kruus
    Hostname localhost
    Port 22222
```
    - so that passwordless ssh to AND from snake10<-->zoro works, we can
    - zoro:$ `git remote add snake10 git+ssh://snake10/local/kruus/sx/sx-dnn`
    - and THEN:
      - `zoro:$ pull snake10 master` "just works"
  - For public-domain SX work:
    - Pull from upstream:
      - git pull upstream master
    - Push to github (public repo):
      - git push
  - If Japan git gets confused:
    - snake10:$ make gen-dnn.src.tar.gz
    - snake10:$ scp gen-dnn.src.tar.gz sapphire2:wrk/simd/gen-dnn/
    - sapphire2:$  # unpack, overwriting current sources
    - sapphire2:$ git status
    - sapphire2:$  # deleted files? new files?
    - sapphire2:$ ./build.sh -Sdq   # test
    - sapphire2:$  # ... until OK
    - sapphire2:$ git add -u; git commit

### upstream merges

- clone this mkl-dnn fork
  - git clone https://github.com/necla-ml/gen-dnn.git
    (or perhaps git+ssh://git@github.com/necla-ml/gen-dnn.git)
- upstream merge, from within cloned fork:
  - git checkout master # in case you are on a branch
  - git pull https://github.com/01org/mkl-dnn.git
  - # ... resolve merge conflicts ...
  - git commit # use default message
  - git push # ... origin master ... update gen-dnn on Github.

### SX cross-compile

- My own setup is like:
```
ssh japan       # setup in my .ssh/ssh.config to auto-navigate a chain of servers
. bashrc-local
cd wrk
. bashrc-sx
cd simd/gen-dnn
```
and then work on the mkl-dnn cross-compile stuff with _./build.sh -SdqT_ or something similar.

Remember to also test release mode, via _../buid.sh -Sq_ before rejoicing!
You might uncover even more segfaults in release mode.

### SX testing

Begin by making a writable directory for log files (e.g. from sapphire2 or zoro)
```
mkdir guest; chmod ugo+w guest
```
Then log in to the SX, start bash and cd to the project root (`~/tosx`, etc.)

- Just running a program in release mode can print nothing if assertions fail!
- recompile in debug mode `./build.sh -Sdq` to allow nicer tracing of issues (typically segfaults)

- `build-sx/tests/gtests/test_convolution\*` take a *long* time to run.
  - so you can do something like
```
( cd build-sx/tests/gtests; export C_PROGINF=DETAIL; for f in test_conv*; do echo '>>>> '"$f"; \
  ./$f --gtest_filter=*/0:*/1:*/2:*/3:*/4:*/5 2>&1 | tee "../../../guest/$f-test0-5.log"; done; \
)  2>&1 | tee guest/gtest-conv0-5.log
```
    to run a subset of the convolution tests.
  - or run the examples/ test programs and get run statistics:
```
for f in ./build-sx/examples/sim*; do echo ""; echo "%%% $f"; \
C_PROGINF=DETAIL ./$f 2>&1 | tee guest/`basename $f`.log; \
done
```

### SX debug

Logged in to SX, run in debugger:

```
$  dbx -I src/vanilla -I src/include -I src/common -I src/io -I examples ./build-sx/examples/simple-net-c
run # wait for failed assertion
where # note things in backtrace
up 2
print output_index # or maybe display to set a watchpoint on the variable
stop in cpu_engine.const_memory__Q4_6mkldnn4impl3cpu12cpu_memory_tCFUL
stop in ref_relu.input_memory__Q4_6mkldnn4impl3cpu15cpu_primitive_tCFUL
stop in execute_forward_dense__Q4_6mkldnn4impl3cpu50ref_relu_fwd_t__tm__28_XC18mkldnn_data_type_tL_1_1Fv_v
display ref_relu.input_memory__Q4_6mkldnn4impl3cpu15cpu_primitive_tCFUL.index
cpu_engine.const_memory__Q4_6mkldnn4impl3cpu12cpu_memory_tCFUL.output_index
run # try again
```
The first readable part is a function name, and the first mangled part is often a `this` name, for C++ functions.

Run a single test in the SX debugger (for debug build, under build-sxd)
```
[guest@ps6s0005 gen-dnn]$  dbx -I src/vanilla -I src/include -I src/common -I src/io -I examples -I tests -I tests/gtests ./build-sxd/tests/gtests/test_sum
```

Run part of a gtests test in the SX debugger (using release mode build-sx/)
```
[guest@ps6s0005 gen-dnn]$  dbx -I src/vanilla -I src/include -I src/common -I src/io -I examples -I tests -I tests/gtests -r ./build-sx/tests/gtests/test_convolution_relu_forward_f32 --gtest_filter=*/0
```
- The `-r` (run) allows dbx to pass --gtest_filter= option to the test program, instead of trying interpret it as a dbx option
- Even this subset takes quite some time to run!

### dbx example of debugging an SX segfault (now fixed)

- examples/simple-net-cpp and simple-net-c were both segfaulting
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

- Resolved by finding some workarounds (eventually!) for SX compiler bugs.
  - some bugs simple and fixed in next SX compiler versions.
- One bug I could not reduce to a simple test case:
  - rare erroneous struct initializations, with workaround to specify
    tailing zeros:
  - Buggy: *mystruct={1}* --> OK: *mystruct={1,0}*

## SX Performance

### Intel:

- ./build.sh -dq
- operf ./build/examples/simple-net-c
  - #This executes a gemm reference convolution
- opreport -l ./build/tests/simple-net-c ./build/src/libmkldnn.so.0

```
Using /local/kruus/sx/sx-dnn/oprofile_data/samples/ for samples directory.

WARNING! Some of the events were throttled. Throttling occurs when
the initial sample rate is too high, causing an excessive number of
interrupts.  Decrease the sampling frequency. Check the directory
/local/kruus/sx/sx-dnn/oprofile_data/samples/current/stats/throttled
for the throttled event names.

CPU: Intel Broadwell microarchitecture, speed 3600 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        image name               symbol name
30596    56.7833  libmkldnn.so.0.9.0       mkldnn::impl::memory_desc_wrapper::off_v(int const*, bool) const
6938     12.8763  libmkldnn.so.0.9.0       mkldnn::impl::cpu::ref_lrn_fwd_t<(mkldnn_data_type_t)1>::execute_forward()::{lambda(float*, int, int, int, int)#1}::operator()(float*, int, int, int, int) const
4133      7.6705  libmkldnn.so.0.9.0       unsigned long mkldnn::impl::memory_desc_wrapper::off<int, int, int, int>(int, int, int, int) const
3095      5.7440  libmkldnn.so.0.9.0       mkldnn::impl::memory_desc_wrapper::ndims() const
2673      4.9608  libmkldnn.so.0.9.0       mkldnn::impl::cpu::jit_gemm_convolution_utils::im2col(mkldnn::impl::cpu::any_gemm_conv_conf_t&, float const*, float*) [clone ._omp_fn.0]
2647      4.9126  libmkldnn.so.0.9.0       mkldnn::impl::memory_desc_wrapper::format() const
1612      2.9917  libmkldnn.so.0.9.0       mkldnn::impl::cpu::nchw_pooling_fwd_t<(mkldnn_data_type_t)1>::execute_forward()::{lambda(float*, int, int, int, int)#2}::operator()(float*, int, int, int, int) const
621       1.1525  libmkldnn.so.0.9.0       mkldnn::impl::memory_desc_wrapper::blocking_desc() const
486       0.9020  libmkldnn.so.0.9.0       mkldnn::impl::cpu::jit_gemm_convolution_utils::prepare_workspace(mkldnn::impl::cpu::any_gemm_conv_conf_t&, float**, bool, unsigned long)
276       0.5122  libmkldnn.so.0.9.0       mkldnn::impl::cpu::ref_relu_fwd_t<(mkldnn_data_type_t)1>::execute_forward_dense() [clone ._omp_fn.0]
241       0.4473  libmkldnn.so.0.9.0       mkldnn::impl::cpu::_gemm_convolution_fwd_t<false, false, (mkldnn::impl::cpu::cpu_isa_t)0>::execute_forward() [clone ._omp_fn.1]
195       0.3619  libmkldnn.so.0.9.0       mkldnn::impl::cpu::ref_lrn_fwd_t<(mkldnn_data_type_t)1>::execute_forward() [clone ._omp_fn.0]
195       0.3619  libmkldnn.so.0.9.0       mkldnn::impl::lrn_fwd_pd_t::desc() const
105       0.1949  libmkldnn.so.0.9.0       std::pow(float, float)
52        0.0965  libmkldnn.so.0.9.0       mkldnn::impl::cpu::nchw_pooling_fwd_t<(mkldnn_data_type_t)1>::execute_forward() [clone ._omp_fn.0]
12        0.0223  libmkldnn.so.0.9.0       mkldnn::impl::nstl::numeric_limits<float>::lowest()
1         0.0019  libmkldnn.so.0.9.0       mkldnn::impl::cpu::_gemm_convolution_fwd_t<false, false, (mkldnn::impl::cpu::cpu_isa_t)0>::pd_t::~pd_t()
1         0.0019  libmkldnn.so.0.9.0       mkldnn_name_memory_desc
1         0.0019  libmkldnn.so.0.9.0       mkldnn_primitive** std::__copy_move_a2<true, mkldnn_primitive**, mkldnn_primitive**>(mkldnn_primitive**, mkldnn_primitive**, mkldnn_primitive**)
1         0.0019  libmkldnn.so.0.9.0       std::_Vector_base<mkldnn_primitive const*, std::allocator<mkldnn_primitive const*> >::_M_get_Tp_allocator()
1         0.0019  libmkldnn.so.0.9.0       std::vector<mkldnn_primitive_at_t, std::allocator<mkldnn_primitive_at_t> >::size() const
```

### SX Convolution with mkl-dnn ref impls is slow (just like on Intel)

- ref impl is slow "as expected" (function call in innermost loop)
- newer im2col gemm also slow (im2col has function call in innermost loop)

- Possibilities:
  - is_dense specializations for ref and im2col
  - alt C loops embedding im2col operations within loop
  - may try: direct convolution, with a layout like nChw128c
  - may try: Winograd (also should be very nice for massively-SIMD machines)
  - we had some faster SX gemm-based convolutions in another codebase,
    - for convolutions without dilations.

Here's a sample sxftrace for mkldnn ref convolution 

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

### SX status

- benchdnn now running on SX
- now can use new queries to print algorithm name!
- SX is slow because im2col is a *ref* implementation
  that doesn't allow good loop optimizations
  - This needs to be special-cased for "nice" layouts.

- We have now switched focus to getting the generic mkl-dnn framework ready for
use on the NEC Aurora chip.
- See [README-Aurora](README-Aurora.md)

