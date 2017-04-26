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

- SX has no posix_memalign :(
- SX int is only 32-bit (even though you can use -size_t64)
- SX has many conversion warnings.
- SX link with libmkldnn.a ~ OK
- SX run FAILS -- segfault within ref_relu_fwd init during memory_desc_wrapper
  - is this related to 32-bit int issues?

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


## Intel(R) Math Kernel Library for Deep Neural Networks (Intel(R) MKL-DNN)
[![Apache License Version 2.0](https://img.shields.io/badge/license-Apache_2.0-green.svg)](LICENSE)
![v0.7 beta](https://img.shields.io/badge/v0.7-beta-orange.svg)

Intel(R) Math Kernel Library for Deep Neural Networks (Intel(R) MKL-DNN) is an
open source performance library for Deep Learning (DL) applications intended
for acceleration of DL frameworks on Intel(R) architecture. Intel(R) MKL-DNN
includes highly vectorized and threaded building blocks for implementation of
convolutional neural networks (CNN) with C and C++ interfaces. We created this
project to enable the DL community to innovate on Intel(R) processors.

Intel MKL-DNN includes functionality similar to [Intel(R) Math Kernel
Library (Intel(R) MKL) 2017](https://software.intel.com/en-us/intel-mkl), but is not
API compatible. We are investigating how to unify the APIs in future Intel MKL releases.

This release is a technical preview with functionality necessary to accelerate
bleeding edge image recognition topologies, including Cifar\*, AlexNet\*, VGG\*, 
GoogleNet\* and ResNet\*. As with any technical preview, APIs may change in future updates.

## License
Intel MKL-DNN is licensed under
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

## Documentation
The latest Intel MKL-DNN documentation is at [GitHub pages](http://01org.github.io/mkl-dnn/).

## Support
Please report issues and suggestions via
[GitHub issues](https://github.com/01org/mkl-dnn/issues) or start a topic on
[Intel MKL forum](https://software.intel.com/en-us/forums/intel-math-kernel-library).

## How to Contribute
We welcome community contributions to Intel MKL-DNN. If you have an idea how to improve the library:

* Share your proposal via
 [GitHub issues](https://github.com/01org/mkl-dnn/issues).

* Ensure you can build the product and run all the examples with your patch

* In the case of a larger feature, create a test

* Submit a [pull request](https://github.com/01org/mkl-dnn/pulls)

We will review your contribution and, if any additional fixes or modifications
are necessary, may provide feedback to guide you. When accepted, your pull
request will be merged into our internal and GitHub repositories.

## System Requirements
Intel MKL-DNN supports Intel(R) 64 architecture processors and is optimized for
* Intel(R) Xeon(R) processor E5-xxxx v3 (codename Haswell)
* Intel(R) Xeon(R) processor E5-xxxx v4 (codename Broadwell)
* Intel(R) Xeon Phi(TM) processor 72xx (codename Knights Landing)

Processors without Intel(R) Advanced Vector Extensions 2 (Intel(R) AVX2) are 
supported and will run reference code.

The software dependencies are:
* [Cmake](https://cmake.org/download/) 2.8.0 or later
* [Doxygen](http://www.stack.nl/~dimitri/doxygen/download.html#srcbin) 1.8.5 or later
* C++ compiler with C++11 standard support

The software was validated on RedHat\* Enterprise Linux 7 with
* GNU\* Compiler Collection 4.8
* GNU\* Compiler Collection 6.1
* Clang\* 3.8.0
* [Intel(R) C/C++ Compiler](https://software.intel.com/en-us/intel-parallel-studio-xe)
  16.0 or later

The implementation uses OpenMP\* 4.0 SIMD extensions. We recommend using
Intel(R) compiler for the best performance results.

## Installation
Download [Intel MKL-DNN source code](https://github.com/01org/mkl-dnn/archive/master.zip)
or clone the repository to your system

```
	git clone https://github.com/01org/mkl-dnn.git
```

Satisfy all hardware and software dependencies and ensure that the versions are correct before installing.
Intel MKL-DNN uses the optimized matrix-matrix multiplication (GEMM) function from Intel MKL. The dynamic 
library with this functionality is included win the repository. Before building the project, download the library
using the script provided:

```
	cd scripts && ./prepare_mkl.sh && cd ..
```

or download manually and unpack it to the `external` directory in the repository root.

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
