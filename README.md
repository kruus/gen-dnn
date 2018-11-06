# Generic MKL-DNN

## Fork: mkl-dnn for other compilers (non-jit C/C++ only)

* A first step to ease porting the mkl-dnn API to non-Intel platforms
* *Other* compilers:
  * NEC SX,            sxcc compiler
  * NEC "Aurora" chip, ncc compiler
* This fork: [gen-dnn Github URL](https://github.com/necla-ml/gen-dnn)
* Upstream: [mkl-dnn Github URL](https://github.com/intel/mkl-dnn)

### Quickstart:

```
./build.sh -h      # help</BR>
./build.sh -tt     # Intel x86 build and run some tests (w/ jit)
                   # add 'v' for *vanilla* (no jit)
                   # --> build/    and build.log
# Platform Aurora:
# untar the ve*.tar.gz distro tarballs
./build.sh -adttT  # a:Aurora platform, d:debug compile, T:trace cmake decisions
                   # a=NEC Aurora; use S for NEC SX
```
This public branch reflects some work done on an internal git repository
porting mkl-dnn to:
- non-JIT cpu
- HPC-style cpu with 32-bit int, and
  - very long simd registers (128 to 512 floats per floating multiply-add)
- chip-specific compilers (sxcc,ncc)

Last merge with upstream was around v0.16 of mkl-dnn (~ Sept 2018)

*Beware*: This port is generic C/C++ code only, removing the x86 jit portions.
Many layers are not vectorized efficiently by gcc/sxcc/ncc.

Gemm convolutions on SX and Aurora attain about 60-75% of the chips
theoretical FLOPS/s.  For Aurora, higher efficiencies are available
for several primitives via a hand-coded VectorDNN library, but this
library is not integrated into gen-dnn.

We plan to develop some simple jit examples for convolutions on NEC's Aurora
chip. The jit operations may be slow, invoking the assembler or compiler as
required!

[Erik Kruus, NEC Labs America]

### Purpose

This branch builds a "TARGET_VANILLA" version of mkl-dnn that:

* can remove all Intel Jit stuff

* adds some i/o funcs (because I know I will have to debug sooner or later)
  * later mkl-dnn versions now provide better i/o (primitive name via query
    API, for example).

- Various build options added
  - build.sh -h #for latest settings
- defaults are:
  - "vanilla" C/C++, and
  - builds a RelWithDebug libmkldnn.so with `-d` option
  - creates an ROOTDIR/install/ directory with extensive doxygen docs.
    - browse at install/share/doc/mkldnn/reference/html/index.html
- So far, I have added some debug stuff, a build.sh to build original/vanilla
  - Some faster C++ impls were added for SX and Aurora
    - reference impls are "gold standard" readable impls,
      that favor code clarity over speed.

##### faster C/C++ ref impls

There are no low-level impls in the github gen-dnn repo.

For the NEC SX chip and sxcc compiler, we could get to ~ 45% chip efficiency
for some pure-C/C++ impls for the NEC SX chip.  This is still lower than
*im2col+gemm*.

For Aurora *none* of the reference impls (using ncc <= 0.5.2) was able to
attain significant chip efficiency, even though some ref impls yielded 100x
speedups wrt the [extremely slow] "gold standard" impl.  Only the *im2col+gemm*
was able to be efficient (typically 60-70% chip efficiency over a wide range of
convolutions).

- these alternate reference impl codes are available in
  - [github branch Mar072108-working](https://github.com/necla-ml/gen-dnn/tree/Mar072018-working)
  - Updating these impls to support *depth* would be a lot of work.
    - some of the loop re-orderings are not so easy to implement
    - their performance is highly dependent on compiler vectorization ability.
  - **takeaway**: Even if you try very hard to make vectorization opportunities
    *really obvious* for the compiler, compilers won't do what you want.
    - this is really bad for ncc, where I had enormous difficulty in getting
      the compiler to use the masked instructions of the chipset.
    - ... which is why we switched to llvm + intrinsics for Aurora to make
      a separate VectorDNN library of fast convolutions.  (non-jit, not yet
      publicly available, so not integrated into gen-dnn for Aurora yet).

### My notes: port to another CPU/platform (XX) modifications

- cmake support was developed in subdirectory dev-cmake-XX
  - now in subdirectory Platform/
  - ** cmake-3.8 ** is OK, cmake-3.0 is not
    - because cmake-3.8 has a handy call to Platform/XX-Initialize that I require

- Platform issues (comment here are mostly for SX port)
  - has no posix_memalign :(
  - int is only 32-bit (even though you can use -size_t64)
  - has many more precision/sign-related warnings about type-conversions
  - Non-SX-specific mods have mostly been accepted by [upstream mkl-dnn](https://github.com/01org/mkl-dnn)
    - Many warning-removal SX patches identical to those for the Windows mkl-dnn port.
  - For SX-specific details, see [README-SX](doc/README-SX.md)
  - For SX-Aurora-specific details, see [README-Aurora](doc/README-Aurora.md)

## Original [old] README.md ...

> Intel MKL-DNN repository migrated to [https://github.com/intel/mkl-dnn](https://github.com/intel/mkl-dnn).
> The old address will continue to be available and will redirect to the new repo.
> Please update your links.

# Intel(R) Math Kernel Library for Deep Neural Networks (Intel(R) MKL-DNN)
![v0.16 beta](https://img.shields.io/badge/v0.16-beta-orange.svg)

Intel(R) Math Kernel Library for Deep Neural Networks (Intel(R) MKL-DNN) is
an open source performance library for deep learning applications. The library
accelerates deep learning applications and framework on Intel(R) architecture. 
Intel(R) MKL-DNN contains vectorized and threaded building blocks which you can
use to implement deep neural networks (DNN) with C and C++ interfaces.

DNN functionality optimized for Intel architecture is also included in 
[Intel(R) Math Kernel Library (Intel(R) MKL)](https://software.intel.com/en-us/mkl/features/deep-neural-networks).
API in this implementation is not compatible with Intel MKL-DNN and does not
include certain new and experimental features.

This release contains performance critical functions that improve performance of
of the following deep learning topologies and variations of these.

| Application                               | Example topology
|:---                                       |:---
| Image recognition                         | AlexNet, VGG, GoogleNet, ResNet, MobileNet
| Image segmenation                         | FCN, SegNet, MaskRCNN, U-Net
| Volumetric segmentation                   | 3D-Unet
| Object detection                          | SSD, Faster R-CNN, Yolo
| Neural Machine Translation (experimental) | GNMT
| Speech Recognition (experimental)         | DeepSpeech
| Adversarial Networks                      | DCGAN, 3DGAN
| Reinforcement Learning                    | A3C

Intel MKL-DNN is used in the following software products:
* [Caffe\* Optimized for Intel Architecture](https://github.com/intel/caffe)
* [Chainer\*](https://chainer.org)
* [DeepBench](https://github.com/baidu-research/DeepBench)
* [PaddlePaddle\*](http://www.paddlepaddle.org)
* [Tensorflow\*](https://www.tensorflow.org)
* [Microsoft\* Cognitive Toolkit (CNTK)](https://www.microsoft.com/en-us/cognitive-toolkit/)
* [Apache\* MXNet](https://mxnet.apache.org/)
* [OpenVINO(TM) toolkit](https://software.intel.com/en-us/openvino-toolkit)
* [Intel(R) Nervana(TM) Graph](https://github.com/NervanaSystems/ngraph)
* [Menoh\*](https://github.com/pfnet-research/menoh)

## License
Intel MKL-DNN is licensed under
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0). This
software includes the following third party components:
* [Xbyak](https://github.com/herumi/xbyak) distributed under [3-clause BSD licence](src/cpu/xbyak/COPYRIGHT)
* [gtest](https://github.com/google/googletest) distributed under [3-clause BSD license](tests/gtests/gtest/LICENSE)

## Documentation
* [Introduction](https://intel.github.io/mkl-dnn) explains programming model
and basic concepts
* [Reference manual](https://intel.github.io/mkl-dnn/modules.html) provides
detailed functionality description
* [Examples](https://github.com/intel/mkl-dnn/tree/master/examples) 
demonstrate use of C and C++ APIs in simple topologies
* [Tutorial](https://software.intel.com/en-us/articles/intel-mkl-dnn-part-1-library-overview-and-installation) 
provides step by step installation instructions and an example walkthrough

## Support
Please submit your questions, feature requests and bug reports on
[GitHub issues](https://github.com/intel/mkl-dnn/issues) page.

**WARNING** The following functionality has preview status and might change
without prior notification in future releases:
* Convolutions with `s16` data type in source, weights or destination
* Convolutions and auxillary primitives for 3D spatial data
* RNN, LSTM and GRU primitives

## How to Contribute
We welcome community contributions to Intel MKL-DNN. If you have an idea how to improve the library:

* Share your proposal via
 [GitHub issues](https://github.com/intel/mkl-dnn/issues).
* Ensure you can build the product and run all the examples with your patch
* In the case of a larger feature, create a test
* Submit a [pull request](https://github.com/intel/mkl-dnn/pulls)

We will review your contribution and, if any additional fixes or modifications
are necessary, may provide feedback to guide you. When accepted, your pull
request will be merged the repository.

## System Requirements
Intel MKL-DNN supports Intel(R) 64 architecture and compatible architectures.
The library is optimized for the systems based on
* Intel Atom(R) processor with Intel(R) SSE4.1 support
* 4th, 5th, 6th and 7th generation Intel(R) Core processor
* Intel(R) Xeon(R) processor E5 v3 family (formerly Haswell)
* Intel Xeon processor E5 v4 family (formerly Broadwell)
* Intel Xeon Platinum processor family (formerly Skylake)
* Intel(R) Xeon Phi(TM) processor x200 product family (formerly Knights Landing)
* Intel Xeon Phi processor x205 product family (formerly Knights Mill)

and compatible processors.

The software dependencies are:
* [Cmake](https://cmake.org/download/) 2.8.0 or later
* [Doxygen](http://www.stack.nl/~dimitri/doxygen/download.html#srcbin) 1.8.5 or later
* C++ compiler with C++11 standard support

The software was validated on RedHat\* Enterprise Linux 7 with
* GNU\* Compiler Collection 4.8, 5.2, 6.1 and 7.2
* Clang\* 3.8.0
* [Intel(R) C/C++ Compiler](https://software.intel.com/en-us/intel-parallel-studio-xe)
  17.0 and 18.0

on Windows Server\* 2012 R2 with
* Microsoft\* Visual C++ 14.0 (Visual Studio 2015)
* [Intel(R) C/C++ Compiler](https://software.intel.com/en-us/intel-parallel-studio-xe)
  17.0 and 18.0

on macOS\* 10.13 (High Sierra) with
* Apple LLVM version 9.0.0 (XCode 9.0.0)
* [Intel C/C++ Compiler](https://software.intel.com/en-us/intel-parallel-studio-xe)
  18.0 (XCode 8.3.2)

The implementation uses OpenMP\* 4.0 SIMD extensions. We recommend using
Intel(R) Compiler for the best performance results.

## Installation
Download [Intel MKL-DNN source code](https://github.com/intel/mkl-dnn/archive/master.zip)
or clone the repository to your system

```
	git clone https://github.com/intel/mkl-dnn.git
```

Ensure that all software dependencies are in place and have at least minimal
supported version.

Intel MKL-DNN can take advantage of optimized
matrix-matrix multiplication (GEMM) function from Intel MKL. The dynamic
library with this functionality is included in the repository. If you choose 
to build Intel MKL-DNN with the binary dependency download Intel MKL small
libraries using provided script

###### Linux/macOS
```
	cd scripts && ./prepare_mkl.sh && cd ..
```

###### Windows
```
	cd scripts && call prepare_mkl.bat && cd ..
```

or manually from [GitHub release section](https://github.com/intel/mkl-dnn/releases)
and unpack it to the `external` directory in the repository root. 

You can choose to build Intel MKL-DNN without binary dependency. The resulting
version will be fully functional, however performance of certain convolution
shapes and sizes and inner product relying on SGEMM function may be suboptimal.

Intel MKL-DNN uses a CMake-based build system

```
	mkdir -p build && cd build && cmake .. && make
```

Intel MKL-DNN includes unit tests implemented using the googletest framework. To validate your build, run:

```
	make test
```

Documentation is provided inline and can be generated in HTML format with Doxygen:

```
	make doc
```

Documentation will reside in `build/reference/html` folder.

Finally,
```
	make install
```
will place the  header files, libraries and documentation in `/usr/local`. To change
the installation path, use the option `-DCMAKE_INSTALL_PREFIX=<prefix>` when invoking CMake.

## Linking your application
Intel MKL-DNN include several header files providing C and C++ APIs for 
the functionality and several dynamic libraries depending on how Intel MKL-DNN
was built. Intel OpenMP runtime and Intel MKL small libraries are not installed
for standalone Intel MKL-DNN build.

|File                   | Description
|:---                   |:---
|lib/libmkldnn.so       | Intel MKL-DNN dynamic library
|lib/libiomp5.so        | Intel OpenMP* runtime library
|lib/libmklml_gnu.so    | Intel MKL small library for GNU* OpenMP runtime
|lib/libmklml_intel.so  | Intel MKL small library for Intel(R) OpenMP runtime
|include/mkldnn.h       | C header
|include/mkldnn.hpp     | C++ header
|include/mkldnn_types.h | auxillary C header

Intel MKL-DNN uses OpenMP* for parallelism and requires an OpenMP runtime 
library to work. As different OpenMP runtimes may not be binary compatible
it's important to ensure that only one OpenMP runtime is used throughout the
application. Having more than one OpenMP runtime initialized may lead to
undefined behavior resulting in incorrect results or crashes.

Intel MKL-DNN library built with binary dependency will link against Intel OpenMP
runtime included with Intel MKL small libraries package. Intel OpenMP runtime
is binary compatible with GNU OpenMP and CLANG OpenMP runtimes and is 
recommended for the best performance results. Here are example linklines for 
GNU C++ compiler and Intel C++ compiler.
```
	g++ -std=c++11 -I${MKLDNNROOT}/include -L${MKLDNNROOT}/lib simple_net.cpp -lmkldnn -lmklml_intel -liomp5
```
```
	icpc -std=c++11 -qopenmp -I${MKLDNNROOT}/include -L${MKLDNNROOT}/lib simple_net.cpp -lmkldnn -lmklml_intel
```
Using GNU compiler with `-fopenmp` and `-liomp5` options will link the 
application with both Intel and GNU OpenMP runtime libraries. This will lead
to undefined behavior of the application.

Intel MKL-DNN library built standalone will use OpenMP runtime supplied by
the compiler, so as long as both the library and the application use the
same compiler correct OpenMP runtime will be used. 
```
	g++ -std=c++11 -fopenmp -I${MKLDNNROOT}/include -L${MKLDNNROOT}/lib simple_net.cpp -lmkldnn
```
```
	icpc -std=c++11 -qopenmp -I${MKLDNNROOT}/include -L${MKLDNNROOT}/lib simple_net.cpp -lmkldnn
```

--------

[Legal Information](doc/legal_information.md)
