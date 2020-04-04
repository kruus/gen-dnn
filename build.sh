#!/bin/bash
# vim: et ts=4 sw=4 ai
ORIGINAL_CMD="$0 $*"
DOTEST=0
DODEBUG=0
DODOC="y"
DOJUSTDOC=0
DOWARN=""
BUILDOK="y"
SIZE_T=64 # or 64, for -s or -S SX compile
JOBS="-j$(grep -c processor /proc/cpuinfo)"
CMAKETRACE=""
USE_MKL=0
USE_CBLAS=0
USE_CACHE=0 # enable primitive cache?
QUICK=0
DOGCC_VER=0
NEC_FTRACE=0
DOTARGET="x"
BFLOAT16="x"
RNN="x"
OMP="y"
ULIMIT=65536 # ulimit is in 1024-byte blocks
ENV=`which env`

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
while getopts ":m:hvjatTdDqQPFbBrRoOwW1567iMrcC" arg; do
    #echo "arg = ${arg}, OPTIND = ${OPTIND}, OPTARG=${OPTARG}"
    case $arg in
        m) # -mISA "machine", ISA=[ALL] | VANILLA | ANY? ... (prefer j|a|gj|ga)
            ISA="${OPTARG}"
            # check for valid ISA string values XXX
            ;;
        v) # force Intel x86 JIT compile for VANILLA generic architecture
            ISA=VANILLA
            ;;
        j) # force Intel x86 compile JIT (default FULL x86 build)
            if [ ! "${DOTARGET}" == "x" ]; then echo "-j no good: already have -${DOTARGET}"; usage; fi
            DOTARGET="j";
            ;;
        a) # NEC Aurora VE, full features
            if [ ! "${DOTARGET}" == "x" ]; then echo "-a no good: already have -${DOTARGET}"; usage; fi
            DOTARGET="a"; SIZE_T=64;
            JOBS="-j8" # -j1 to avoid SIGSEGV in ccom
            if [ `uname -n` = "zoro" ]; then JOBS="-j8"; fi
            ;;
        t) # [0] increment test level: (1) examples, (2) tests (longer), ...
            # Apr-14-2017 build timings:
            # 0   : build    ~ ?? min  (jit), 1     min  (vanilla)
            # >=1 : examples ~  1 min  (jit), 13-16 mins (vanilla)
            # >=2 : test_*   ~ 10 mins (jit), 108   mins (vanilla)
            # >=3 : benchdnn quick performance/correctness tests
            # >=4 : benchdnn default build targets (very long)
            DOTEST=$(( DOTEST + 1 ))
            ;;
        T) # cmake --trace
            CMAKETRACE="--trace --debug-trycompile"
            ;;
        d) # cmake build mode: [0] : cmake Release build.
            # -d   : RelWithDebInfo
            # -dd  : Debug
            # -ddd : Debug and -O0
            DODEBUG=$(( DODEBUG + 1 ))
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
        P) # Primitive extra tracing verbosity, even for release build [option removed]
            VERBOSE_EXTRA="y"
            ;;
        F) # NEC Aurora VE or SX : add ftrace support (generate ftrace.out)
            NEC_FTRACE=1
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
        o) # no OpenMp
            OMP="n"
            ;;
        O) # with OpenMP
            OMP="y"
            ;;
        w) # reduce compiler warnings
            DOWARN=0
            ;;
        W) # lots of compiler warnings (default)
            DOWARN=1
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
        M) # try MKL [at own risk] option
            USE_MKL=1; USE_CBLAS=0
            ;;
        r) # reference impls only: no -DUSE_CBLAS compile flag (->no im2col gemm)
            USE_CBLAS=0; USE_MKL=0
            ;;
        c) # cache: support primitive caching
            USE_CACHE=1
            ;;
        C) # force -DUSE_CBLAS compile flag
            # x86: expect errors if not very careful about omp libs
            #      (or set OMP_NUM_THREADS=1)
            # non-x86: this *may* provide a speed boost if your platform has an
            #          optimized cblas library
            USE_CBLAS=1; USE_MKL=0
            ;;
    h | *) # help
            usage
            ;;
    esac
done
# if unspecified, autodetect target via $CC compiler variable
if [ "${DOTARGET}" == "x" ]; then
    if [ "${CC}" == "ncc" -a "${CXX}" == "nc++" ]; then
        echo "auto-detected '-a' Aurora compiler (ncc, nc++)"
        DOTARGET="a"; SIZE_T=64
        if [ -f vejit/include/vednn.h ]; then
            echo "auto-detected libvednn" # ISA=FULL
        else
            ISA=VANILLA
        fi
    else
        DOTARGET="j" # j for JIT (Intel assembler)
    fi
fi
if [ "${DOTARGET}" == "x" ]; then
    usage
fi

if [ ! "x${CC}" == "x" ]; then
    if [ ! "`which ${CC}`" ]; then
        if [ -x ${CC} ]; then
            echo "Using specific compiler version: ${CC}";
        else
            echo "./build.sh: CC=${CC} , but did not find that compiler."
            exit -1
        fi
    fi
fi

if [ ${DOJUSTDOC} -gt 0 ]; then
    echo " JUST building doxygen docs"
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
    if [ "$ISA" == "VANILLA" ]; then BUILDDIR="${BUILDDIR}-ve"; INSTALLDIR="${INSTALLDIR}-ve";
    else BUILDDIR="${BUILDDIR}-vej"; INSTALLDIR="${INSTALLDIR}-vej";
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
        if [ "$ISA" == "VANILLA" ]; then BUILDDIR="${BUILDDIR}-gen"; INSTALLDIR="${INSTALLDIR}-gen";
        elif [ "$ISA" == "FULL" ]; then BUILDDIR="${BUILDDIR}-jit"; INSTALLDIR="${INSTALLDIR}-jit";
        else BUILDDIR="${BUILDDIR}-jit-${ISA}"; INSTALLDIR="${INSTALLDIR}-jit-${ISA}";
        fi
    fi
fi
if [ $DODEBUG -eq 1 ]; then BUILDDIR="${BUILDDIR}d"; INSTALLDIR="${INSTALLDIR}d"; fi
if [ $DODEBUG -gt 1 ]; then BUILDDIR="${BUILDDIR}d${DODEBUG}"; INSTALLDIR="${INSTALLDIR}d${DODEBUG}"; fi
if [ $NEC_FTRACE -gt 0 ]; then BUILDDIR="${BUILDDIR}F"; fi
if [ $USE_CBLAS -gt 0 ]; then BUILDDIR="${BUILDDIR}C"; fi
if [ "$BUILDDIR_SUFFIX" ]; then BUILDDIR="${BUILDDIR}${BUILDDIR_SUFFIX}"; fi
if [ "$BFLOAT16" = "y" ]; then BUILDDIR="${BUILDDIR}-bf16"; fi
if [ "$BFLOAT16" = "n" ]; then BUILDDIR="${BUILDDIR}-nobf16"; fi
if [ "$RNN" = "y" ]; then BUILDDIR="${BUILDDIR}-rnn"; fi
if [ "$RNN" = "n" ]; then BUILDDIR="${BUILDDIR}-nornn"; fi
if [ "${OMP}" = "n" ]; then BUILDDIR="${BUILDDIR}-seq"; INSTALLDIR="${INSTALLDIR}-seq"; fi

if [ $DOJUSTDOC -gt 0 ]; then
    echo " JUST building doxygen docs"
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

# Obtain INITIAL guesses for TESTRUNNER and VE_EXEC
if [ "" ]; then # old way (now we do not need ve_exec anymore)
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
    #export VE_PROGINF=YES;
    export VE_PROGINF=DETAIL;
    export C_PROGINF=YES;
    ulimit -s $ULIMIT
    echo 'ulimit : '`ulimit -s`
else
    unset VE_PROGINF
    unset C_PROGINF
fi

if [ "$DOTARGET" = "aXXX" ]; then
    echo "Warning: setting OMP_NUM_THREADS=1 for now"
    export OMP_NUM_THREADS=1; # for now XXX
else
    : #unset OMP_NUM_THREADS; # typically 1 thread per cpu
fi

export PATH
echo "PATH $PATH"
(
    echo "# vim: set ro ft=log:"
    echo "DOTARGET   $DOTARGET"
    echo "ISA        $ISA"
    echo "USE_MKL    $USE_MKL"
    echo "USE_CBLAS  $USE_CBLAS"
    echo "DOTEST     $DOTEST"
    echo "DODEBUG    $DODEBUG"
    echo "DODOC      $DODOC"
    echo "QUICK      $QUICK"
    echo "VERBOSE_EXTRA $VERBOSE_EXTRA"
    echo "BUILDDIR   ${BUILDDIR}"
    echo "INSTALLDIR ${INSTALLDIR}"
    echo "JOBS       ${JOBS}"
    ulimit -s $ULIMIT # 10.1.18 "When compiling a program which code size is large, the compiler aborts by SIGSEGV."
    echo 'ulimit : '`ulimit -s`
    if [ $QUICK -lt 2 ]; then
        mkdir "${BUILDDIR}"
    fi
    cd "${BUILDDIR}"
    function ccxx_flags {
        export CFLAGS="${CFLAGS} $*"
        export CXXFLAGS="${CXXFLAGS} $*"
        echo "ccxx_flags CFLAGS --> ${CFLAGS}"
    }
    if [ "${DOWARN}" = "1" ]; then
        DOWARNFLAGS=""
        if [ "$DOTARGET" = "s" ]; then DOWARNFLAGS="-wall"
        else DOWARNFLAGS="-Wall"; fi
        ccxx_flags "${DOWARNFLAGS}"
    fi
    OPT_FLAGS=
    CMAKEOPT="${CMAKEOPT} -DCMAKE_INSTALL_PREFIX=../${INSTALLDIR}"
    if [ $DODEBUG -eq 0 ]; then
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Release"
    elif [ $DODEBUG -eq 1 ]; then
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
    elif [ $DODEBUG -eq 2 ]; then
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Debug"
    else
        CMAKEOPT="${CMAKEOPT} -DCMAKE_BUILD_TYPE=Debug"
        OPT_FLAGS="-O0"
    fi
        OPT_FLAGS="${OPT_FLAGS} -O0"
    if [ ! x"${OPT_FLAGS}" = x"" ]; then ccxx_flags ${OPT_FLAGS}; fi
    if [ "${DOTARGET}" = "a" ]; then
        ccxx_flags -include stdint.h
        ccxx_flags -minit-stack=zero
        ccxx_flags -Wunknown-pragma
        ccxx_flags -report-all
        ccxx_flags -D_FORTIFY_SOURCE=1
    fi
    # Show build commands
    CMAKETRACE="${CMAKETRACE} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"
    CMAKEOPT="${CMAKEOPT} -DDNNL_VERBOSE=1"
    CMAKEOPT="${CMAKEOPT} -DDNNL_ISA=${ISA}"
    #if [ "$VERBOSE_EXTRA" == "y" -o "${DODEBUG}" == "y" ]; then
    #    # iterator print skipped impls if dnnl_get_verbose=3|4
    #    #CMAKEOPT="${CMAKEOPT} -DDNNL_VERBOSE=EXTRA"
    #    CMAKEOPT="${CMAKEOPT} -DDNNL_VERBOSE=1"
    #fi
    #
    # -b or -B : BFLOAT16 support override
    #
    if [ "${BFLOAT16}" = "n" ]; then
        CMAKEOPT="${CMAKEOPT} -DDNNL_ENABLE_BFLOAT16=0"
        echo "BFLOAT16 support OFF"
    elif [ "${BFLOAT16}" = "y" ]; then 
        CMAKEOPT="${CMAKEOPT} -DDNNL_ENABLE_BFLOAT16=1"
        echo "BFLOAT16 support ON"
    else
        echo "BFLOAT16 support = default"
    fi
    #
    # -r or -R : RNN support override
    #
    if [ "${RNN}" = "n" ]; then
        CMAKEOPT="${CMAKEOPT} -DDNNL_ENABLE_RNN=0"
        echo "RNN      support OFF"
    elif [ "${RNN}" = "y" ]; then 
        CMAKEOPT="${CMAKEOPT} -DDNNL_ENABLE_RNN=1"
        echo "RNN      support ON"
    else
        echo "RNN      support = default"
    fi
    #
    # -c : enable primitive cache
    #
    if [ ${USE_CACHE} -eq 0 ]; then
        CMAKEOPT="${CMAKEOPT} -DDNNL_ENABLE_PRIMITIVE_CACHE=0"
        echo "Primitive cache  OFF"
    else 
        CMAKEOPT="${CMAKEOPT} -DDNNL_ENABLE_PRIMITIVE_CACHE=1"
        echo "Primitive cache  ON"
    fi

    #
    # CMAKEOPT="" # allow user to pass flag, ex. CMAKEOPT='--trace -LAH' ./build.sh
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_SRC_CCXX_FLAGS"
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_EXAMPLE_CCXX_FLAGS"
    #CMAKEOPT="${CMAKEOPT} -DCMAKE_TEST_CCXX_FLAGS"
    #CMAKEOPT="${CMAKEOPT} -DDNNL_CPU_RUNTIME=OMP"    # def [OMP] TBB
    #CMAKEOPT="${CMAKEOPT} -DDNNL_GPU_RUNTIME=OCL"    # def [] OCL
    #CMAKEOPT="${CMAKEOPT} -DMKLDNN_WERROR=ON" # default OFF
    # REMOVED:
    #CMAKEOPT="${CMAKEOPT} -DDNNL_JIT_SUPPORT=${CPU}"    # default max jit for target cpu
    #if [ $USE_CBLAS -ne 0 ]; then
    #    CMAKEOPT="${CMAKEOPT} -DDNNL_CPU_EXTERNAL_GEMM=CBLAS" # default NONE
    #fi
    if [ $USE_MKL -ne 0 ]; then
        CMAKEOPT="${CMAKEOPT} -D_DNNL_USE_MKL=1"
        #CMAKEOPT="${CMAKEOPT} -DDNNL_CPU_EXTERNAL_GEMM=MKL" # default NONE
    fi
    if [ "$DOTARGET" == "a" ]; then
        TOOLCHAIN=../cmake/ve.cmake
        if [ ! -f "${TOOLCHAIN}" ]; then echo "Ohoh. ${TOOLCHAIN} not found?"; BUILDOK="n"; fi
        CMAKEOPT="${CMAKEOPT} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}"

        # adjust here for VE shared library and Openmp use
        #CMAKEOPT="${CMAKEOPT} -DUSE_SHAREDLIB=OFF" # deprecated
        #CMAKEOPT="${CMAKEOPT} -DDNNL_LIBRARY_TYPE=STATIC"
        #CMAKEOPT="${CMAKEOPT} -DDNNL_LIBRARY_TYPE=SHARED" # default

        # USE_OPENMP defaults to off, so force it on (VE openmp has improved)
        if [ "${OMP}" = "n" ]; then
            # CMAKEOPT="${CMAKEOPT} -DUSE_OPENMP=OFF"
            CMAKEOPT="${CMAKEOPT} -DDNNL_CPU_RUNTIME=SEQ"
        else
            # CMAKEOPT="${CMAKEOPT} -DUSE_OPENMP=ON"
            CMAKEOPT="${CMAKEOPT} -DDNNL_CPU_RUNTIME=OMP"
            #ccxx_flags -fopenmp # ?? -mparallel and -fopenmp both => -pthread
        fi
        # TODO proginf is not working automatically any more?
        # -proginf  : Run with 'export VE_PROGINF=YES' to get some stats output
        # ccxx_flags -proginf
        ccxx_flags -DCBLAS_LAYOUT=CBLAS_ORDER
        ccxx_flags -DDNNL_VALUE_INITIALIZATION_BUG # VE branch should test and set in dnnl_config.h
        ccxx_flags -pthread # for <atomic>, <mutex> headers
        if [ "$NEC_FTRACE" -eq 1 ]; then
            #ccxx_flags -ftrace
            # at some point above was sufficent (ve.cmake) set things
            # TODO have ve.cmake etc do this NICELY with a cmake option...
            VEPERF_DIR="/usr/uhome/aurora/mpc/pub/veperf/180218-ELF"
            VEPERF_INC_DIR="${VEPERF_DIR}/include"
            VEPERF_LIB_DIR="${VEPERF_DIR}/lib"
            ccxx_flags "-I${VEPERF_INC_DIR} -DFTRACE -ftrace"
            export LDFLAGS="${LDFLAGS} -L${VEPERF_LIB_DIR} -lveperf"
            #export LDFLAGS="${LDLIBS} -Wl,-rpath,${VEPERF_LIB_DIR}"
        fi
        # deprecated: use CMAKEOPT -DDNNL_ISA=VEJIT instead
        #CMAKEOPT="${CMAKEOPT} -DVEJIT=${VEJIT}"
        #ccxx_flags "-DVEJIT=${VEJIT}" # deprecated
        echo "Aurora CMAKEOPT = ${CMAKEOPT}"
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
        if [ "$NEC_FTRACE" -eq 1 ]; then ccxx_flags -ftrace demangled; fi

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
    # Remove leading whitespace from CMAKEENV (bash magic)
    shopt -s extglob; CMAKEENV=\""${CMAKEENV##*([[:space:]])}"\"; shopt -u extglob
    echo " CMAKEOPT   ${CMAKEOPT}"
    echo " CXXFLAGS   ${CXXFLAGS}"
    echo " CFLAGS     ${CFLAGS}"
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
            echo "# `pwd`"
            echo "# BUILD_CMD = ${BUILD_CMD}"
            { { ${BUILD_CMD} || ${BUILD_CMD_AGAIN}; } \
                && BUILDOK="y" || echo "build failed: ret code $?"; }
        else
            BUILD_CMD="${BUILD_CMD} VERBOSE=1"
            BUILD_CMD_AGAIN="${BUILD_CMD_AGAIN} VERBOSE=1"
            echo "# BUILD_CMD = ${BUILD_CMD}"
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
            cxxfiles=`(cd ../tests/benchdnn && ls -1 conv/*conv?.cpp conv/*.cxx)` || true
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
        echo "ISA       $ISA"
        echo "DOTEST    $DOTEST"
        echo "DODEBUG   $DODEBUG"
        echo "DODOC     $DODOC"
        if [ -f ./bash_help.inc ]; then # note: file was removed from Intel master
            source "./bash_help.inc" # we are already in ${BUILDDIR}
        fi
        if [ "${CMAKE_CROSSCOMPILING_EMULATOR}" ]; then
            VE_EXEC="${CMAKE_CROSSCOMPILING_EMULATOR}"
            # Use TESTRUNNER VE_EXEC for explicit targets,
            # But leave out VE_EXEC if executing 'make' within $BUILDDIR,
            # because 'make' tragets already supply VE_EXEC if needed.
        fi
        # Put one test here (maybe one you are currently debugging)
        TEST_ENV=(DNNL_VERBOSE=2)
        TEST_ENV+=(VE_INIT_HEAP=ZERO)
        TEST_ENV+=(VE_ERRCTL_DEALLOCATE=MSG)
        TEST_ENV+=(OMP_STACKSIZE=1G)
        TEST_ENV+=(VE_TRACEBACK=VERBOSE)
        TEST_ENV+=(VE_INIT_HEAP=ZERO)
        TEST_ENV+=(VE_PROGINF=DETAIL)
        #TEST_ENV+=(VE_ADVANCEOFF=YES)
        TEST_ENV+=(OMP_DYNAMIC=false)
        TEST_ENV+=(OMP_PROC_BIND=true)
        #TEST_ENV+=(OMP_WAIT_POLICY=active)
        { echo "api-c                   ...";
            ${ENV} ${TEST_ENV[@]} ${TESTRUNNER} ${VE_EXEC} tests/api-c \
                || xBUILDOK="n"; # do not stop tests on failure
        } 
        if [ $DOTEST -eq 13 ]; then # another short test, this one can fail too
            { echo "cpu-cnn-training-f32-c"
                ${ENV} ${TEST_ENV[@]} ${TESTRUNNER}  ${VE_EXEC} examples/cpu-cnn-training-f32-c \
                || xBUILDOK="n"; # do not stop tests on failure
            }
        fi
    fi
    if [ "$BUILDOK" == "y" -a "$DOTARGET" == "s" ]; then
        # not much to do for testing on sx (need to log in to run?)
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

echo 'ulimit : '`ulimit -s`
set +x
# after cmake we might have a better idea about ve_exec (esp. if PATH is not set properly)
if [ -f "${BUILDDIR}/bash_help.inc" ]; then # file was removed from mkl-dnnl ~ v1.x
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
echo "DOTARGET=${DOTARGET}, ISA=${ISA}, DODEBUG=${DODEBUG}, DOTEST=${DOTEST}, DODOC=${DODOC}"
LOGDIR="log-${DOTARGET}${ISA}-d${DODEBUG}t${DOTEST}${DODOC}"
if [ "$BUILDOK" == "y" ]; then # Install? Test?
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
        TEST_ENV=(DNNL_VERBOSE=2)
        TEST_ENV+=(VE_INIT_HEAP=ZERO)
        TEST_ENV+=(VE_ERRCTL_DEALLOCATE=MSG)
        TEST_ENV+=(OMP_STACKSIZE=1G)
        TEST_ENV+=(VE_TRACEBACK=VERBOSE)
        TEST_ENV+=(VE_INIT_HEAP=ZERO)
        TEST_ENV+=(VE_PROGINF=DETAIL)
        #TEST_ENV+=(VE_ADVANCEOFF=YES)
        TEST_ENV+=(OMP_DYNAMIC=false)
        TEST_ENV+=(OMP_PROC_BIND=true)
        #TEST_ENV+=(OMP_WAIT_POLICY=active)
        rm -f test1.log test2.log test3.log
        echo "Testing in ${BUILDDIR} ... test1"
        if [ $DOTEST -ge 1 ]; then
            ( echo "${ENV} ${TEST_ENV[@]} ARGS='-VV -E .*test_.*' ${TESTRUNNER} make VERBOSE=1 test"; \
                cd "${BUILDDIR}" && ${ENV} ${TEST_ENV[@]} ARGS='-VV -E .*test_.*' \
                ${TESTRUNNER} make VERBOSE=1 test \
            ) 2>&1 | tee "${BUILDDIR}/test1.log" || true
        fi
        if [ $DOTEST -ge 2 ]; then
            echo "Testing ... test2"
            (
                 echo "${ENV} ${TEST_ENV[@]} ARGS='-VV -R .*test_.*' ${TESTRUNNER} <commnad>";
                 cd "${BUILDDIR}" && ${ENV} ${TEST_ENV[@]} ARGS='-VV -N' \
                     ${TESTRUNNER} make test \
                     && ${ENV} ARGS='-VV -R .*test_.*' ${TEST_ENV[@]} ${TESTRUNNER}  make test \
                     ) 2>&1 | tee "${BUILDDIR}/test2.log" || true
        fi
        if [ $DOTEST -ge 3 ]; then # some [few] convolution timings (see that benchdnn runs)
            if [ -x ./bench.sh ]; then
                #DNNL_VERBOSE=2 BUILDDIR=${BUILDDIR} ${TESTRUNNER} ./bench.sh -q${DOTARGET} 2>&1 | tee "${BUILDDIR}/test3.log" || true
                # bench.sh quick convolution tests...
                BENCHDIR=${BUILDDIR}/tests/benchdnn
                { (cd ${BENCHDIR} && ./benchdnn --conv --mode=AC -v0 --cfg=f32 --dir=FWD_D --skip-impl="$SKIP" \
                        mb32_ic3ih44iw44_oc7oh10_kh11kw11_sh4sw4ph0pw0_nsmall1 \
                        mb32_ic3ih44kh3_oc7oh42_nsmall2 \
                  ) || { echo "Ohoh"; } ; \
                  (cd ${BENCHDIR} && ./benchdnn --conv --mode=AP -v0 --cfg=f32 --dir=FWD_D --skip-impl="$SKIP" \
                   mb32_ic3ih44iw44_oc7oh10_kh11kw11_sh4sw4ph0pw0_nsmall1 \
                   mb32_ic3ih44kh3_oc7oh42_nsmall2 \
                  ) || { echo "Ohoh"; } ; \
                } 2>&1 | tee ${BUILDDIR}/test3.log || true
            fi
        fi
        if [ $DOTEST -ge 4 ]; then # relevant CPU tests defined in tests/benchdnn/CMakeLists.txt
            # create list of relevant cmake benchdnn targets
            set +x
            if [ "$ISA" = "VANILLA" -o ! "$DOTARGET" = "j" ]; then
                # non-x86 and VANILLA build should skip bfloat16 benchdnn tests
                # Note: VANILLA: some test descriptions now comment out "--skip-impl"
                #       to allow non-jit tests to run. Check for ref impls using
                #       environment DNNL_VERBOSE>0.
                cmd="cd ${BUILDDIR} && make help | grep test_benchdnn.*cpu | sed 's/....//;/bf16/d;/bfloat16/d' | sort"
                echo "Running test_benchdnn.*cpu tests, without bfloat16 ones"
            else
                cmd="cd ${BUILDDIR} && make help | grep test_benchdnn.*cpu | sed 's/....//' | sort"
                echo "Running all test_benchdnn.*cpu tests"
            fi
            echo ${cmd};
            ( eval ${cmd}; )
            ( eval ${cmd}; ) > ${BUILDDIR}/bench.targets
            # run the relevant cmake benchdnn targets
            rm -f ${BUILDDIR}/bench.summary
            { while read -r bench_target; do
                # note default is --mode=C (correctness check)
                # can set BENCHDNN_ARGS="--mode=P' for other modes (e.g. performance, even slower)
                echo "${ENV} ${TEST_ENV[@]} make -C ${BUILDDIR} VERBOSE=1 ${bench_target} ..."
                ${ENV} ${TEST_ENV[@]} make -C ${BUILDDIR} VERBOSE=1 ${bench_target} \
                    | tee >(awk '/^tests:/{printf("%-20s %s\n","'${bench_target##test_benchdnn_}'",$0)}' \
                    >>${BUILDDIR}/bench.summary) \
                    | sed "s/^tests:/test:${bench_target}\\ntests:/"
                echo "Finished bench_target = ${bench_target}"
            done < ${BUILDDIR}/bench.targets; }
            # file "bench.summary", 1 line per test, copied to LOGDIR
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
echo "DOTARGET=${DOTARGET}, ISA=${ISA}, DODEBUG=${DODEBUG}, DOTEST=${DOTEST}, DODOC=${DODOC}"
if [ "${BUILDOK}" == "y" ]; then
    if [ $DOTEST -gt 0 ]; then
        echo "LOGDIR:       ${LOGDIR}" 2>&1 >> "${BUILDDIR}".log
    fi
    if [ $DOTEST -gt 0 ]; then
        if [ -d "${LOGDIR}" ]; then rm -rf "${LOGDIR}.bak"; mv -v "${LOGDIR}" "${LOGDIR}.bak"; fi
        mkdir ${LOGDIR}
        pwd -P
        ls "${BUILDDIR}/"*log
        for f in "${BUILDDIR}/"*log "${BUILDDIR}"/*summary doxygen.log; do
            if [ -f "${f}" ]; then cp -av "${f}" "${LOGDIR}/" || true; fi
        done
    fi
fi
echo "FINISHED:     $ORIGINAL_CMD" 2>&1 >> "${BUILDDIR}".log
# for a debug compile  --- FIXME
#(cd "${BUILDDIR}" && ARGS='-VV -R .*simple_training-net-cpp' /usr/bin/time -v make test) 2>&1 | tee test1-dbg.log
#(cd "${BUILDDIR}" && ARGS='-VV -R .*simple_training-net-cpp' valgrind make test) 2>&1 | tee test1-valgrind.log
#
# Return value is BUILDOK (so repeat-build scripts can stop on success)
if [ "${BUILDOK}" == "y" ]; then exit 0; fi
exit 1 # error

