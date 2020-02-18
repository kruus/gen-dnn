#!/bin/bash
# vim: et ts=4 sw=4 ai
ORIGINAL_CMD="$0 $*"
DOTEST=0
DODEBUG="n"
DODOC="y"
DOJUSTDOC=0
DOWARN="y"
BUILDOK="y"
SIZE_T=64 # or 64, for -s or -S SX compile
JOBS="-j8"
CMAKETRACE=""
USE_MKL="n" # _MKLDNN_USE_MKL is deprecated in v1.0, -M to try it anyway
USE_CBLAS=0
QUICK=0
DOGCC_VER=0
NEC_FTRACE=0
DOTARGET="x"
VEJIT=0
BFLOAT16="x"
RNN="x"

# see dnnl_config.h ...
CPU_X86=1
CPU_VE=2
CPU_SX=3
#
CPU=-1
ISA="ALL"
usage() {
    echo "$0 usage:"
    #head -n 30 "$0" | grep "^[^#]*.)\ #"
    awk '/getopts/{flag=1;next} /^done/{flag=0} flag&&/^[^#]+) #/; flag&&/^ *# /' $0
    echo ""
    echo "Platform/Compiler: -v (vanilla) -j (x86 jit) -a (Aurora,ncc) -S (SX,sxcc)"
    echo "Example: time a full test run for a debug compilation --- time $0 -dtt"
    echo "         SX debug compile, quick (no doxygen)         --- time $0 -Sdq"
    echo "         *just* run cmake, for SX debug compile       ---      $0 -SdQ"
    echo "         *just* create doxygen docs                   ---      $0 -D"
    echo "Aurora : quick Aurora Ftrace Trace-Cmake)  --- $0 -qaFT"
    echo "         quick, quick: no cmake, just make --- $0 -qqa"
    echo "     see what cmake is doing, and create build.log"
    echo "         CMAKEOPT='--trace -LAH' ./build.sh -q >&/dev/null"
    echo " NEW: ./build.sh -aj for Aurora + vednn/jit compile (binary Aurora libvednn distro)"
    echo "Debug: Individual tests can be run like build-sx/tests/gtests/test_relu"
    echo "  We look at CC and CXX to try to guess -S or -a (SX or Aurora)"
    exit 0
}
while getopts ":hjgaSstvPdDqQTwWbF1567iMrCm:bBrR" arg; do
    #echo "arg = ${arg}, OPTIND = ${OPTIND}, OPTARG=${OPTARG}"
    case $arg in
        j) # force Intel x86 compile JIT (src/cpu/ JIT assembly code)
            if [ ! "${DOTARGET}" == "x" ]; then echo "-j no good: already have -${DOTARGET}"; usage; fi
            DOTARGET="j";
            ;;
        g) # force Intel x86 JIT compile for generic architecture
            if [ ! "${DOTARGET}" == "x" ]; then echo "-g no good: already have -${DOTARGET}"; usage; fi
            DOTARGET="g";
            ;;
        a) # NEC Aurora VE
            if [ ! "${DOTARGET}" == "x" ]; then echo "-a no good: already have -${DOTARGET}"; usage; fi
            DOTARGET="a"; SIZE_T=64;
            JOBS="-j8" # -j1 to avoid SIGSEGV in ccom
            if [ `uname -n` = "zoro" ]; then JOBS="-j8"; fi
            ;;
        S) # SX cross-compile (size_t=64, built in build-sx/, NEW: default if $CC==sxcc)
            if [ ! "${DOTARGET}" == "x" ]; then echo "-S no good: already have -${DOTARGET}"; usage; fi
            DOTARGET="s"; SIZE_T=64; JOBS="-j4"
            ;;
        s) # SX cross-compile (size_t=32, built in build-sx/) DISCOURAGED
            if [ ! "${DOTARGET}" == "x" ]; then echo "-s no good: already have -${DOTARGET}"; usage; fi
            # -s is NOT GOOD: sizeof(ptrdiff_t) is still 8 bytes!
            DOTARGET="s"; SIZE_T=32; JOBS="-j4"
            echo "*** WARNING ***"
            echo "-s --> -size_t32 compilation NOT SUPPORTED (-S is recommended)"
            echo "***************"
            ;;
        F) # NEC Aurora VE or SX : add ftrace support (generate ftrace.out)
            NEC_FTRACE=1
            ;;
        t) # [0] increment test level: (1) examples, (2) tests (longer), ...
            # Apr-14-2017 build timings:
            # 0   : build    ~ ?? min  (jit), 1     min  (vanilla)
            # >=1 : examples ~  1 min  (jit), 13-16 mins (vanilla)
            # >=2 : test_*   ~ 10 mins (jit), 108   mins (vanilla)
            # >=3 : benchdnn (bench.sh) performance/correctness tests (long)
            DOTEST=$(( DOTEST + 1 ))
            ;;
        v) # [yes] (vanilla C/C++ only: no src/cpu/ JIT assembler)
            if [ ! "${DOTARGET}" == "x" ]; then echo "-v no good: already have -${DOTARGET}"; usage; fi
            if [ -d src/vanilla ]; then DOTARGET="v"; fi
            ;;
        b) # no bfloat16 support or tests (not supported for x86 jit builds)
            BFLOAT16="n"
            ;;
        B) # add bfloat16 support and tests
            BFLOAT16="y"
            ;;
        r) # no rnn support or tests
            RNN="n"
            ;;
        R) # add rnn support and tests
            RNN="y"
            ;;
        P) # Primitive extra tracing verbosity, even for release build
            VERBOSE_PRIMITIVE_SKIP=y
            ;;
        d) # [no] debug release
            DODEBUG="y"
            ;;
        D) # [no] Doxygen-only : make doc (or doc-full with -DD) and stop. -q will reuse build/
            DOJUSTDOC=$(( DOJUSTDOC + 1 )); DOTARGET="invalid"
            ;;
        q) # quick: once, skip doxygen on OK build; twice, cd BUILDDIR && make
            QUICK=$((QUICK+1))
            ;;
        Q) # really quick: skip build and doxygen docs [JUST run cmake and stop]
            BUILDOK="n"; DODOC="n"
            ;;
        w) # reduce compiler warnings
            DOWARN=0
            ;;
        W) # lots of compiler warnings (default)
            DOWARN=1
            ;;
        T) # cmake --trace
            CMAKETRACE="--trace --debug-trycompile"
            ;;
        1) # make -j1 (default is usually -j8)
            JOBS="-j1"
            ;;
        5) # gcc-5, if found
            DOGCC_VER=5
            ;;
        6) # gcc-6, if found
            DOGCC_VER=6
            ;;
        7) # gcc-7, if found
            DOGCC_VER=7
            ;;
        i) # try using icc
            DOGCC_VER=icc
            ;;
        m) # -mISA "machine", ISA=[ALL]|VANILLA|ANY, SSE41|AVX|AVX2|AVX512..., VE...
            ISA="${OPTARG}"
            # check for valid ISA string values XXX
            ;;
        M) # try _MKLDNN_USE_MKL [deprecated] option
            USE_MKL="y"
            ;;
        r) # reference impls only: no -DUSE_CBLAS compile flag (->no im2col gemm)
            USE_CBLAS=0
            ;;
        C) # force -DUSE_CBLAS compile flag
            # x86: expect errors if not very careful about omp libs (or set OMP_NUM_THREADS=1)
            USE_CBLAS=1
            ;;
    h | *) # help
            usage
            ;;
    esac
done
# DOJIT controls -DDNNL_ISA=${ISA} cmake options (deprecated)
DOJIT=0
# if unspecified, autodetect target via $CC compiler variable
if [ "${DOTARGET}" == "x" ]; then
    if [ "${CC##sx}" == "sx" -o "${CXX##sx}" == "sx" ]; then
        DOTARGET="s" # s for SX (C/C++ code, cross-compile)
    elif [ "${CC}" == "ncc" -a "${CXX}" == "nc++" ]; then
        echo "auto-detected '-a' Aurora compiler (ncc, nc++)"
        # -1 ~ DOJIT; 7 ~ DOJIT
        DOTARGET="a"; DOJIT=-1; SIZE_T=64
        #if [ `uname -n` = "zoro" ]; then JOBS="-j8"; else JOBS="-j1"; fi
        if [ -f vejit/include/vednn.h ]; then VEJIT=100; echo "auto-detected libvednn"; fi
    elif [ -d src/vanilla ]; then
        DOTARGET="v" # v for vanilla (C/C++ code)
    else
        DOTARGET="j" # j for JIT (Intel assembler)
    fi
fi
if [ "${DOTARGET}" == "x" ]; then
    usage
fi

# deprecated (now use CMAKEOPT
if [ "${DOTARGET}" == "g" ]; then
    CPU=$(( ${CPU_X86} * 10 + 0 )) # x86 + 0 is no jit
elif [ "${DOTARGET}" == "j" ]; then
    CPU=$(( ${CPU_X86} * 10 + 6 )) # x86 + 5 is avx512 jit
elif [ "${DOTARGET}" == "a" ]; then
    CPU=$(( ${CPU_VE}  * 10 + 0 )) # VE | 0 is none
elif [ "${DOTARGET}" == "a" ]; then
    CPU=$(( ${CPU_VE}  * 10 + 1 )) # VE | 1 uses libvednn (jit?)
elif [ "${DOTARGET}" == "s" ]; then
    CPU=$(( ${CPU_SX} * 10 + 0 ))
elif [ "${DOTARGET}" == "v" ]; then
    # TARGET_VANILLA means "no x86 jit",
    # so cpu determined by compiler and compile flags
    CPU=-1
elif [ ${DOJUSTDOC} -gt 0 ]; then
    echo " JUST building doxygen docs"
else
    echo " ERROR: build.sh unknown cpu target : DOTARGET=${DOTARGET}"
    usage
fi
INSTALLDIR=install
BUILDDIR=build
#
# I have not yet tried icc.
# we MUST avoid the full MKL (omp issues) (mkldnn uses the mkl subset in external/)
#
#if [ "${MKLROOT}" != "" ]; then
#	module unload icc >& /dev/null || echo "module icc unloaded"
#	if [ "${MKLROOT}" != "" ]; then
#		echo "Please compile in an environment without MKLROOT"
#		exit -1;
#	fi
#	# export -n MKLROOT
#	# export MKL_THREADING_LAYER=INTEL # maybe ???
#fi
#     Now Ubuntu can install libmkl "somewhere" in your /opt/intel, and the FOOvar.sh script will set MKLROOT
#
#
#
if [ "$DOTARGET" == "s" ]; then DODOC="n"; DOTEST=0; INSTALLDIR='install-sx'; BUILDDIR='build-sx';
elif [ "$DOTARGET" == "a" ]; then
    DOJIT=-1
    if [ "$VEJIT" -gt 0 ]; then
        INSTALLDIR="${INSTALLDIR}-vej"; BUILDDIR="${BUILDDIR}-vej";
    fi
else #if [ "$DOTARGET" != "a" ]; then
    if [ "$DOGCC_VER" == "icc" ]; then
        echo "LOOKING for icc ... which icc = `which icc`"
        set -x
        if [ "x`which icc`" == "x" ]; then
            if true; then
                module load icc
                MKLROOT=""
                LD_LIBRARY_PATH=""
            else
                for d in \
                    /opt/intel/composer_xe_2015/bin \
                    /opt/intel/composer_xe_2015.3.187/bin \
                    /opt/intel/compilers_and_libraries/linux/bin/intel64/ \
                    ; \
                do
                    if [ -x "${d}/icc" ]; then
                        export PATH="${d}:${PATH}"
                        break;
                    fi
                done
            fi
        fi
        set +x
        export CXX=icpc; export CC=icc; export FC=ifort;
        BUILDDIR="${BUILDDIR}-icc"; INSTALLDIR="${INSTALLDIR}-icc"
    elif [ "$DOGCC_VER" -gt 0 ]; then
        if $(gcc-${DOGCC_VER} -v); then export CXX=g++-${DOGCC_VER}; export CC=gcc-${DOGCC_VER}; fi
    fi
    if [ "$DOTARGET" == "j" ]; then
        # 5 ~ JITFUNCS_AVX512 max support in engine
        DOJIT=5; INSTALLDIR="${INSTALLDIR}-jit-${ISA}"; BUILDDIR="${BUILDDIR}-jit-${ISA}";
    fi
    if [ "$DOTARGET" == "g" ]; then
        # -1 ~ JITFUNCS_NONE; 6 ~ JITFUNCS_VANILLA
        DOJIT=6
        INSTALLDIR="${INSTALLDIR}-gen"; BUILDDIR="${BUILDDIR}-gen";
        DOTARGET="j" # henceforth identical to -j
    fi
fi
if [ ! "x${CC}" == "x" -a ! "`which ${CC}`" ]; then
    if [ -x ${CC} ]; then
        echo "Using specific compiler version: ${CC}";
    else
        echo "./build.sh: CC=${CC} , but did not find that compiler."
        exit -1
    fi
fi

if [ "$DOTARGET" == "v" ]; then
    DOJIT=-1 # -1 ~ NONE; 7 ~ VE (or ANY or VE_COMMON?)
fi
if [ "$DODEBUG" == "y" ]; then INSTALLDIR="${INSTALLDIR}-dbg"; BUILDDIR="${BUILDDIR}d"; fi
if [ $NEC_FTRACE -gt 0 ]; then BUILDDIR="${BUILDDIR}F"; fi
if [ $USE_CBLAS -gt 0 ]; then BUILDDIR="${BUILDDIR}C"; fi
if [ "$BUILDDIR_SUFFIX" ]; then BUILDDIR="${BUILDDIR}${BUILDDIR_SUFFIX}"; fi
if [ "$BFLOAT16" = "y" ]; then BUILDDIR="${BUILDDIR}-bf16"; fi
if [ "$BFLOAT16" = "n" ]; then BUILDDIR="${BUILDDIR}-nobf16"; fi
if [ "$RNN" = "y" ]; then BUILDDIR="${BUILDDIR}-rnn"; fi
if [ "$RNN" = "n" ]; then BUILDDIR="${BUILDDIR}-nornn"; fi

if [ $DOJUSTDOC -gt 0 ]; then
    echo "DOJUSTDOC = ${DOJUSTDOC}"
    echo "QUICK     = ${QUICK}"
    if [ $DOJUSTDOC -eq 1 ]; then # old way Doxyfile
        (
        if [ ! -d build ]; then mkdir build; fi
        if [ ! -f build/Doxyfile ]; then
            # doxygen does not much care HOW to build, just WHERE
            (cd build && cmake -DCMAKE_INSTALL_PREFIX=../${INSTALLDIR} -DFAIL_WITHOUT_MKL=OFF ..)
        fi
        echo "Doxygen (please be patient) logging to doxygen.log"
        rm -f build/doc*stamp
        if [ $QUICK -le 0 ]; then
            rm -rf build/reference "${INSTALLDIR}/share/doc"
        fi
        #cd build \
            #&& make VERBOSE=1 doc \
            #&& cmake -DCOMPONENT=doc -P cmake_install.cmake
        (cd build && make VERBOSE=1 doc) # Doxygen.cmake custom target (not always available!)
        echo " Documentation built in build/reference/"
        echo " doxygen.log ends up in gen-dnn project root,"
        # ... install-doc target was remove in dnnl-v1.1 (or maybe earlier)
        #     can the cmake doc-full get additional docs from sub-cmakes ?
        #(cd build && make VERBOSE=1 install-doc) # Doxygen.cmake custom target
        #echo "Documentation installed under ${INSTALLDIR}/share/doc/"
        #  ... so just copy manually ...
        if [ -d build/reference ]; then
            echo " copying to INSTALLDIR..."
            mkdir --parents ${INSTALLDIR}/share/doc
            cp -uar build/reference ${INSTALLDIR}/share/doc/
            echo " You may browse API docs at"
            echo "    ${INSTALLDIR}/share/doc/reference/html/index.html"
        fi
        ) 2>&1 | tee doxygen.log
    else # full docs Doxyfile-cpu, via 'make doc-full' also documents internals
        (
        if [ ! -d build ]; then mkdir build; fi
        if [ ! -f build/Doxyfile ]; then
            # doxygen does not much care HOW to build, just WHERE
            (cd build && cmake -DCMAKE_INSTALL_PREFIX=../${INSTALLDIR} -DFAIL_WITHOUT_MKL=OFF ..)
        fi
        echo "Doxygen (please be patient) logging to doxygen-full.log"
        rm -f build/doc*stamp-full
        if [ $QUICK -le 0 ]; then
            rm -rf build/reference-full "${INSTALLDIR}/share/doc"
        fi
        #cd build \
            #&& make VERBOSE=1 doc \
            #&& cmake -DCOMPONENT=doc -P cmake_install.cmake
        (cd build && make VERBOSE=1 doc-full) # Doxygen.cmake custom target
        echo " Documentation built in build/reference-full/"
        echo " doxygen-full.log ends up in gen-dnn project root"
        if [ -d build/reference-full ]; then
            echo " copying to INSTALLDIR..."
            mkdir --parents ${INSTALLDIR}/share/doc
            cp -uar build/reference-full ${INSTALLDIR}/share/doc/
            echo " You may browse API docs at"
            echo "    ${INSTALLDIR}/share/doc/reference-full/html/index.html"
        fi
        ) 2>&1 | tee ../doxygen-full.log
    fi
    exit 0
fi
if [ $QUICK -gt 0 ]; then DODOC="n"; fi
if [ $QUICK -gt 1 ]; then
    if [ ! -f "${BUILDDIR}/Makefile" ]; then # running cmake is absolutely required
        QUICK=1
    fi
fi
timeoutPID() { # unused
    PID="$1"
    timeout="$2"
    interval=1
    delay=1
    (
        ((t = timeout))

        while ((t > 0)); do
            sleep $interval
            kill -0 $$ || exit 0
            ((t -= interval))
        done

        # Be nice, post SIGTERM first.
        # The exit 0 below will be executed if any preceeding command fails.
        kill -s SIGTERM $$ && kill -0 $$ || exit 0
        sleep $delay
        kill -s SIGKILL $$
    ) 2> /dev/null &
}
if [ -d "${BUILDDIR}" -a $QUICK -lt 2 ]; then
    rm -rf "${BUILDDIR}".bak && mv -v "${BUILDDIR}" "${BUILDDIR}".bak
    if [ -f "${BUILDDIR}.log" ]; then
       mv "${BUILDDIR}.log" "${BUILDDIR}".bak/
    fi
fi
if [ -d "$INSTALLDIR}" -a $QUICK -lt 2 ]; then
    rm -rf "$INSTALLDIR}".bak && mv -v "$INSTALLDIR}" "$INSTALLDIR}".bak
fi

# Obtain initial guesses for TESTRUNNER and VE_EXEC
if [ "" ]; then
    VE_EXEC=''
    TESTRUNNER=''
    if [ "$DOTARGET" = "a" ]; then
        export OMP_NUM_THREADS=1; # for now XXX
        if { ve_exec --version 2> /dev/null; } then
            # oops, this will not work for "${TESTRUNNER} make test"
            #TESTRUNNER="${TESTRUNNER} ve_exec"
            #echo "ve_exec! TESTRUNNER ${TESTRUNNER}"
            VE_EXEC=ve_exec
        else
            TESTRUNNER="echo Not-Running "
            echo "Aurora: ve_exec not found"
        fi
    fi
    if { /usr/bin/time -v echo Hello >& /dev/null; } then
        TESTRUNNER='/usr/bin/time -v'
    fi
    echo "TESTRUNNER ${TESTRUNNER}"
    echo "VE_EXEC    ${VE_EXEC}"
fi
#if [ "$NEC_FTRACE" -gt 0 ]; then
if [ "$DOTARGET" = "a" -o "$DOTARGET" = "s" ]; then
    #TESTRUNNER="VE_PROGINF=YES ${TESTRUNNER}" #works if used as bash -c ${TESTRUNNER}
    export VE_PROGINF=YES;
    export C_PROGINF=YES;
else
    unset VE_PROGINF
    unset C_PROGINF
fi

if [ "$DOTARGET" = "a" ]; then
    export OMP_NUM_THREADS=1; # for now XXX
fi

export PATH
echo "PATH $PATH"
(
    echo "# vim: set ro ft=log:"
    echo "DOTARGET   $DOTARGET"
    echo "DOJIT      $DOJIT"
    echo "USE_CBLAS  $USE_CBLAS"
    echo "USE_MKL    $USE_MKL"
    echo "VERBOSE_PRIMITIVE_SKIP $VERBOSE_PRIMITIVE_SKIP"
    echo "DOTEST     $DOTEST"
    echo "DODEBUG    $DODEBUG"
    echo "DODOC      $DODOC"
    echo "QUICK      $QUICK"
    echo "BUILDDIR   ${BUILDDIR}"
    echo "INSTALLDIR ${INSTALLDIR}"
    echo "JOBS       ${JOBS}"
    if [ $QUICK -lt 2 ]; then
        mkdir "${BUILDDIR}"
    fi
    cd "${BUILDDIR}"
    function ccxx_flags {
        export CFLAGS="${CFLAGS} $*"
        export CXXFLAGS="${CXXFLAGS} $*"
        echo "ccxx_flags CFLAGS --> ${CFLAGS}"
    }
    if [ "$VERBOSE_PRIMITIVE_SKIP" == "y" -o "${DODEBUG}" == "y" ]; then
        # iterator print skipped impls if dnnl_get_verbose=3|4
        CMAKEOPT="${CMAKEOPT} -DDNNL_VERBOSE=EXTRA"
    fi

    #
    # XXX replace following section with:
    # CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=${ISA}"
    #
    if [ $DOJIT = 6 ]; then # 6 ~ VANILLA
        CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=VANILLA"
    elif [ $DOJIT == 5 ]; then # 5 ~ AVX512, or ANY? ALL? (which? maybe use ANY|MAX XXX)
        : # default DNNL_ISA is ALL (for x86)
        #CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=ALL" 
        #CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=SSE41"
        CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=${ISA}"
    elif [ "${DOTARGET}" == "a" ]; then
        # default DNNL_ISA is ALL (for VE)
        CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=VANILLA"
        #CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=VEDNN"
        #CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=VEJIT"
        #CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=ALL""
    elif [ "${DOTARGET}" == "s" ]; then
        : # deprecated
    elif [ "${DOTARGET}" == "v" ]; then
        # TARGET_VANILLA means "no x86 jit",
        # so cpu determined by compiler and compile flags
        CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=VANILLA"
    elif [ ${DOJUSTDOC} -gt 0 ]; then
        echo " JUST building doxygen docs"
    else
        echo " ERROR: build.sh unknown cpu target : DOTARGET=${DOTARGET}"
        usage
    fi
    #
    # -b or -B : BFLOAT16 support override
    #
    if [ "${BFLOAT16}" = "n" ]; then
        CMAKEOPT="${CMAKEOPT} -DDNNL_BFLOAT16=0"
        echo "BFLOAT16 support OFF"
    elif [ "${BFLOAT16}" = "y" ]; then 
        CMAKEOPT="${CMAKEOPT} -DDNNL_BFLOAT16=1"
        echo "BFLOAT16 support ON"
    else
        echo "BFLOAT16 support = default"
    fi
    #
    # -r or -R : RNN support override
    #
    if [ "${RNN}" = "n" ]; then
        CMAKEOPT="${CMAKEOPT} -DDNNL_RNN=0"
        echo "RNN    support OFF"
    elif [ "${RNN}" = "y" ]; then 
        CMAKEOPT="${CMAKEOPT} -DDNNL_RNN=1"
        echo "RNN    support ON"
    else
        echo "RNN    support = default"
    fi

    #
    # CMAKEOPT="" # allow user to pass flag, ex. CMAKEOPT='--trace -LAH' ./build.sh
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_SRC_CCXX_FLAGS"
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_EXAMPLE_CCXX_FLAGS"
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_TEST_CCXX_FLAGS"
    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_=ON"  # def ON
    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_BUILD_EXAMPLES=ON"  # def ON
    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_BUILD_TESTS=ON"     # def ON
    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_BUILD_FOR_CI=OFF"   # def OFF
    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_CPU_RUNTIME=OMP"    # def [OMP] TBB
    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_GPU_RUNTIME=OCL"    # def [] OCL

    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_WERROR=ON" # default OFF

    # REMOVED:
    #CMAKEOPT="${CMAKEOPT} -DDNNL_JIT_SUPPORT=${CPU}"    # default max jit for target cpu

    if [ $USE_CBLAS -ne 0 ]; then
        CMAKEOPT="${CMAKEOPT} -DMKLDNN_USE_CBLAS=ON" # default OFF
    fi
    if [ $USE_MKL == "y" ]; then # deprecated in v1.0
        CMAKEOPT="${CMAKEOPT} -D_MKLDNN_USE_MKL=ON"
    fi
    if [ "$DOTARGET" == "a" ]; then
        TOOLCHAIN=../cmake/ve.cmake
        if [ ! -f "${TOOLCHAIN}" ]; then echo "Ohoh. ${TOOLCHAIN} not found?"; BUILDOK="n"; fi
        CMAKEOPT="${CMAKEOPT} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}"

        # adjust here for VE shared library and Openmp use
        #CMAKEOPT="${CMAKEOPT} -DUSE_SHAREDLIB=OFF" # deprecated
        CMAKEOPT="${CMAKEOPT} -DDNNL_LIBRARY_TYPE=STATIC"

        # USE_OPENMP defaults to off, so force it on (VE openmp has improved)
        if [ "a" == "z" ]; then
            CMAKEOPT="${CMAKEOPT} -DUSE_OPENMP=OFF"
        else
            CMAKEOPT="${CMAKEOPT} -DUSE_OPENMP=ON"
            # ?? -mparallel and -fopenmp both => -pthread
            export CFLAGS="${CFLAGS} -fopenmp"
            export CXXFLAGS="${CFLAGS} -fopenmp"
        fi
        # TODO proginf is not working automatically any more?
        # -proginf  : Run with 'export VE_PROGINF=YES' to get some stats output
        # export CFLAGS="${CFLAGS} -DCBLAS_LAYOUT=CBLAS_ORDER -proginf"
        # export CXXFLAGS="${CXXFLAGS} -DCBLAS_LAYOUT=CBLAS_ORDER -proginf"
        export CFLAGS="${CFLAGS} -DCBLAS_LAYOUT=CBLAS_ORDER"
        export CXXFLAGS="${CXXFLAGS} -DCBLAS_LAYOUT=CBLAS_ORDER"
        if [ "$NEC_FTRACE" -eq 1 ]; then
            #export CFLAGS="${CFLAGS} -ftrace"
            #export CXXFLAGS="${CXXFLAGS} -ftrace"
            # at some point above was sufficent (ve.cmake) set things
            # TODO have ve.cmake etc do this NICELY with a cmake option...
            VEPERF_DIR="/usr/uhome/aurora/mpc/pub/veperf/180218-ELF"
            VEPERF_INC_DIR="${VEPERF_DIR}/include"
            VEPERF_LIB_DIR="${VEPERF_DIR}/lib"
            export CFLAGS="${CFLAGS} -I${VEPERF_INC_DIR} -DFTRACE -ftrace"
            export CXXFLAGS="${CXXFLAGS} -I${VEPERF_INC_DIR} -DFTRACE -ftrace"
            export LDFLAGS="${LDFLAGS} -L${VEPERF_LIB_DIR} -lveperf"
            #export LDFLAGS="${LDLIBS} -Wl,-rpath,${VEPERF_LIB_DIR}"
        fi
        # deprecated: use CMAKEOPT -DDNNL_ISA=VEJIT instead
        #CMAKEOPT="${CMAKEOPT} -DVEJIT=${VEJIT}"

        #export CFLAGS="${CFLAGS} -DVEJIT=${VEJIT}"
        #export CXXFLAGS="${CXXFLAGS} -DVEJIT=${VEJIT}"
        echo "Aurora CMAKEOPT = ${CMAKEOPT}"
    fi
    if [ ${DOWARN} == 'y' ]; then
        DOWARNFLAGS=""
        if [ "$DOTARGET" == "s" ]; then DOWARNFLAGS="-wall"
        else DOWARNFLAGS="-Wall"; fi
        export CFLAGS="${CFLAGS} ${DOWARNFLAGS}"
        export CXXFLAGS="${CXXFLAGS} ${DOWARNFLAGS}"
    fi
    if [ "$DOTARGET" == "s" ]; then
        TOOLCHAIN=../cmake/sx.cmake
        if [ ! -f "${TOOLCHAIN}" ]; then echo "Ohoh. ${TOOLCHAIN} not found?"; BUILDOK="n"; fi
        CMAKEOPT="${CMAKEOPT} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}"
        CMAKEOPT="${CMAKEOPT} --debug-trycompile --trace -LAH" # long debug of cmake
        #  ... ohoh no easy way to include the spaces and expand variable properly ...
        #      Solution: do these changes within CMakeLists.txt
        #CMAKEOPT="${CMAKEOPT} -DCMAKE_C_FLAGS=-g\ -ftrace\ -Cdebug" # override Cvopt
        #SXOPT="${SXOPT} -DTARGET_VANILLA"
        SXOPT="${SXOPT} -D__STDC_LIMIT_MACROS"
        # __STDC_LIMIT_MACROS is a way to force definitions like INT8_MIN in stdint.h (cstdint)
        #    (it **should** be autmatic in C++11, imho)
        SXOPT="${SXOPT} -woff=1097 -woff=4038" # turn off warnings about not using attributes
        SXOPT="${SXOPT} -woff=1901"  # turn off sxcc warning defining arr[len0] for constant len0
        SXOPT="${SXOPT} -wnolongjmp" # turn off warnings about setjmp/longjmp (and tracing)

        SXOPT="${SXOPT} -Pauto -acct" # enable parallelization (and run with C_PROGINF=YES)
        #SXOPT="${SXOPT} -Pstack" # disable parallelization

        # Generate 'ftrace.out' profiling that can be displayed with ftrace++
        #  BUT not compatible with POSIX threads
        if [ "$NEC_FTRACE" -eq 1 ]; then
            export CFLAGS="${CFLAGS} -ftrace demangled"
            export CXXFLAGS="${CXXFLAGS} -ftrace demangled"
        fi

        # REMOVE WHEN FINISHED SX DEBUGGING
        SXOPT="${SXOPT} -g -traceback" # enable source code tracing ALWAYS

        export CFLAGS="${CFLAGS} -size_t${SIZE_T} -Kc99,gcc ${SXOPT}"
        # An object file that is generated with -Kexceptions and an object file
        # that is generated with -Knoexceptions must not be linked together. In
        # such conditions the exception may not be thrown correctly Therefore, do
        # not specify -Kexceptions if the program does not use the try, catch
        # and throw keywords.
        #export CXXFLAGS="${CXXFLAGS} -size_t${SIZE_T} -Kcpp11,gcc,rtti,exceptions ${SXOPT}"
        export CXXFLAGS="${CXXFLAGS} -size_t${SIZE_T} -Kcpp11,gcc,exceptions ${SXOPT}"
        #export CXXFLAGS="${CXXFLAGS} -size_t${SIZE_T} -Kcpp11,gcc,rtti"
    fi
    CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../${INSTALLDIR}"
    if [ "$DODEBUG" == "y" ]; then
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Debug"
    else
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Release"
        #CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
    fi
    # Remove leading whitespace from CMAKEENV (bash magic)
    shopt -s extglob; CMAKEENV=\""${CMAKEENV##*([[:space:]])}"\"; shopt -u extglob
    # Without MKL, unit tests take **forever**
    #    TODO: cblas / mathkeisan alternatives?
    if [ "$BUILDOK" == "y" ]; then
        BUILDOK="n"
        if [ "" ]; then # original, just use 'make' to build
            BUILD_CMD="make VERBOSE=1 ${JOBS}"
            BUILD_CMD_AGAIN="make VERBOSE=1"
        else # using cmake to build will propagate parallelism to sub-makes
            BUILD_CMD="cmake --build . -- ${JOBS}"
            BUILD_CMD_AGAIN="cmake --build . -- -j1"
            # could also use '-j 8' as a 'cmake --build' arg (oops, not supported in older cmake)
            # note also 'cmake --build' has '--clean-first' and '--target <tgt>' options
        fi
        if [ $QUICK -gt 1 ]; then
            rm -f ./stamp-BUILDOK
            echo '# rebuild in existing directory, WITHOUT rerunning cmake'
            pwd
            { { ${BUILD_CMD} || ${BUILD_CMD_AGAIN}; } \
                && BUILDOK="y" || echo "build failed: ret code $?"; }
        else
            BUILD_CMD="${BUILD_CMD} VERBOSE=1"
            BUILD_CMD_AGAIN="${BUILD_CMD_AGAIN} VERBOSE=1"
            rm -f ./stamp-BUILDOK ./CMakeCache.txt
            echo "CMAKEENV: ${CMAKEENV}"
            echo "CMAKEOPT: ${CMAKEOPT}"
            echo "CMAKETRACE: ${CMAKETRACE}"
            echo "${CMAKEENV}; cmake ${CMAKEOPT} ${CMAKETRACE} .."
            set -x
            # { if [ -nz "${CMAKEENV}" ]; then ${CMAKEENV}; fi; \
            { if [[ -n "${CMAKEENV}" && "${CMAKEENV}" != "\"\"" ]]; then ${CMAKEENV}; fi; \
                cmake ${CMAKEOPT} ${CMAKETRACE} .. \
                && make help \
                && { ${BUILD_CMD} || ${BUILD_CMD_AGAIN}; } \
                && BUILDOK="y" || echo "build failed: ret code $?"; }
            set +x
        fi
        if [ "$BUILDOK" == "y" ]; then
            # If you have some test convolutions in special-named files
            # make some assembly-source translations automatically...
            cxxfiles=`(cd ../tests/benchdnn && ls -1 conv/*conv?.cpp conv/*.cxx)`
            if [ "$cxxfiles" ]; then (
                cd tests/benchdnn && { for f in $cxxfiles; do
                if [ -f "${f}" ]; then
                    g=`basename "${f}" .cpp`; echo $f.s; make -j1 VERBOSE=1 conv/$f.s;
                fi; done; }
                ) || true
            else
                echo "No .s files to generate from test code in tests/benchdnn/conv"
            fi
            # maybe copy them into ../asm, for perusal?
            #pwd
            #ls -l ../asm || true
        fi

    else # skip the build, just run cmake ...
        echo "CMAKEENV   <${CMAKEENV}>"
        echo "CMAKEOPT   <${CMAKEOPT}>"
        echo "CMAKETRACE <${CMAKETRACE}>"
        echo "pwd        `pwd`"
        echo "PATH       $PATH"
        echo "CC         $CC"
        if [ ! "x${CC}" == "x" ]; then ${CC} -V; fi
        set -x
        { if [ ! "${CMAKEENV}" == '""' ]; then ${CMAKEENV}; fi; \
            cmake ${CMAKEOPT} ${CMAKETRACE} .. ; }
        set +x
    fi
    set -x
    if [ "$BUILDOK" == "y" -a ! "$DOTARGET" == "s" ]; then
        echo "DOTARGET  $DOTARGET"
        echo "DOJIT     $DOJIT"
        echo "DOTEST    $DOTEST"
        echo "DODEBUG   $DODEBUG"
        echo "DODOC     $DODOC"
        export DNNL_VERBOSE=7
        source "./bash_help.inc" # we are already in ${BUILDDIR}
        if [ "${CMAKE_CROSSCOMPILING_EMULATOR}" ]; then
            VE_EXEC="${CMAKE_CROSSCOMPILING_EMULATOR}"
            # Use TESTRUNNER VE_EXEC for explicit targets,
            # But leave out VE_EXEC if executing 'make' within $BUILDDIR,
            # because 'make' tragets already supply VE_EXEC if needed.
        fi
        # Whatever you are currently debugging (and is a quick sanity check) can go here
        #if [ -x tests/api-io-c ]; then
        #    { echo "api-io-c                ..."; ${TESTRUNNER} ${VE_EXEC} tests/api-io-c || BUILDOK="n"; }
        #else
            { echo "api-c                   ...";
                ${TESTRUNNER} ${VE_EXEC} tests/api-c \
                || xBUILDOK="n";
            } 
        #fi
        if [ $DOTEST -eq 0 -a $DOJIT -ge 0 ]; then
            # this is fast ONLY with JIT (< 5 secs vs > 5 mins)
            { echo "simple-training-net-cpp ...";
                ${TESTRUNNER}  ${VE_EXEC} examples/simple-training-net-cpp \
                || BUILDOK="n";
            }
        fi
    fi
    if [ "$BUILDOK" == "y" -a "$DOTARGET" == "s" ]; then
        # make SX build dirs all-writable so SX runs can store logs etc.
        #find "${BUILDDIR}" -type d -exec chmod o+w {} \;
        { cd ..; find "${BUILDDIR}" -type d -exec chmod o+w {} \; ; }
    fi
    if [ "$BUILDOK" == "y" ]; then # communicate this to build.sh script
        touch ./stamp-BUILDOK
        sync ./stamp-BUILDOK
        if [ "$DODOC" == "y" ]; then
            echo "Build OK... Doxygen (please be patient)"
            make VERBOSE=1 doc >& ../doxygen.log
        fi
    else
        rm -f ./stamp-BUILDOK
    fi
    set +x
) 2>&1 | tee "${BUILDDIR}".log
ls -l "${BUILDDIR}"
BUILDOK="n"; if [ -f "${BUILDDIR}/stamp-BUILDOK" ]; then BUILDOK="y"; fi

set +x
# after cmake we might have a better idea about ve_exec (esp. if PATH is not set properly)
if [ -f "${BUILDDIR}/bash_help.inc" ]; then
    # snarf some CMAKE variables
    source "${BUILDDIR}/bash_help.inc"
    TESTRUNNER=''
    if [ "${CMAKE_CROSSCOMPILING_EMULATOR}" ]; then
        VE_EXEC="${CMAKE_CROSSCOMPILING_EMULATOR}"
        if [ ! -x "${VE_EXEC}" ]; then
            TESTRUNNER="echo Not-Running "
            echo "cmake crosscompiling emulator, such as ve_exec, not available?"
        fi
    fi
fi
if { /usr/bin/time -v echo Hello >& /dev/null; } then
    TESTRUNNER='/usr/bin/time -v'
fi
# next is optional, for verbose primitive creation and run messages
TESTRUNNER="${TESTRUNNER}"
set -x
echo "TESTRUNNER ${TESTRUNNER}"
echo "VE_EXEC    ${VE_EXEC}"

echo "BUILDDIR   ${BUILDDIR}"
echo "INSTALLDIR ${INSTALLDIR}"
echo "DOTARGET=${DOTARGET}, DOJIT=${DOJIT}, DODEBUG=${DODEBUG}, DOTEST=${DOTEST}, DODOC=${DODOC}"
LOGDIR="log-${DOTARGET}${DOJIT}${DODEBUG}${DOTEST}${DODOC}"
if [ "$BUILDOK" == "y" ]; then
    set -x
    echo "BUILDOK !    QUICK=$QUICK"
    if [ $QUICK -lt 2 ]; then # make install ?
        (
        cd "${BUILDDIR}"
        # trouble with cmake COMPONENTs ...
        echo "Installing :"; make install;
        #if [ "$DODOC" == "y" ]; then { echo "Installing docs ..."; make install-doc; } fi
        ) 2>&1 >> "${BUILDDIR}".log || { echo "'make install' in ${BUILDDIR} had issues (ignored)"; }
    fi
    echo "Testing ?"
    if [ ! $DOTEST -eq 0 -a ! "$DOTARGET" == "s" ]; then # non-SX: -t might run some tests
        rm -f test1.log test2.log test3.log
        echo "Testing in ${BUILDDIR} ... test1"
        if [ true ]; then
            (cd "${BUILDDIR}" && ARGS='-VV -E .*test_.*' DNNL_VERBOSE=2 ${TESTRUNNER} make VERBOSE=1 test) 2>&1 | tee "${BUILDDIR}/test1.log" || true
        fi
        if [ $DOTEST -ge 2 ]; then
            echo "Testing ... test2"
            (cd "${BUILDDIR}" && ARGS='-VV -N' ${TESTRUNNER} make test \
            && ARGS='-VV -R .*test_.*' DNNL_VERBOSE=2 ${TESTRUNNER}  make test) 2>&1 | tee "${BUILDDIR}/test2.log" || true
        fi
        if [ $DOTEST -ge 3 ]; then
            if [ -x ./bench.sh ]; then
                DNNL_VERBOSE=2 BUILDDIR=${BUILDDIR} ${TESTRUNNER} ./bench.sh -q${DOTARGET} 2>&1 | tee "${BUILDDIR}/test3.log" || true
            fi
        fi
        echo "Tests done"
    fi
    if [ ! $DOTEST -eq 0 -a "$DOTARGET" == "s" ]; then
        echo 'SX testing should be done manually (ex. ~/tosx script to log in to SX)'
    fi
    set +x
else
    echo "Build NOT OK..."
fi

# maintain directories of "success" log files
echo "BUILDDIR   ${BUILDDIR}"
echo "INSTALLDIR ${INSTALLDIR}"
echo "DOTARGET=${DOTARGET}, DOJIT=${DOJIT}, DODEBUG=${DODEBUG}, DOTEST=${DOTEST}, DODOC=${DODOC}"
if [ "${BUILDOK}" == "y" ]; then
    if [ $DOTEST -gt 0 ]; then
        echo "LOGDIR:       ${LOGDIR}" 2>&1 >> "${BUILDDIR}".log
    fi
    if [ $DOTEST -gt 0 ]; then
        if [ -d "${LOGDIR}" ]; then rm -rf "${LOGDIR}.bak"; mv -v "${LOGDIR}" "${LOGDIR}.bak"; fi
        mkdir ${LOGDIR}
        pwd -P
        ls "${BUILDDIR}/"*log
        for f in "${BUILDDIR}/"*log doxygen.log; do
            if [ -f "${f}" ]; then cp -av "${f}" "${LOGDIR}/" || true; fi
        done
    fi
fi
echo "FINISHED:     $ORIGINAL_CMD" 2>&1 >> "${BUILDDIR}".log
# for a debug compile  --- FIXME
#(cd "${BUILDDIR}" && ARGS='-VV -R .*simple_training-net-cpp' /usr/bin/time -v make test) 2>&1 | tee test1-dbg.log
#(cd "${BUILDDIR}" && ARGS='-VV -R .*simple_training-net-cpp' valgrind make test) 2>&1 | tee test1-valgrind.log
