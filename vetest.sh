#!/bin/bash
# vim: et sw=2 ts=2 foldlevel=6
ENV=`which env`
TEST_ENV=()
# DNNL_VERBOSE 1:show exec  2:also show create times
TEST_ENV+=(DNNL_VERBOSE=1) # can override with -vvv
#TEST_ENV+=(VE_INIT_HEAP=ZERO)
#TEST_ENV+=(VE_ERRCTL_DEALLOCATE=MSG)
#TEST_ENV+=(VE_ERRCTL_DEALLOCATE=ERROR)
#TEST_ENV+=(VE_TRACEBACK=VERBOSE)
#TEST_ENV+=(VE_TRACEBACK=NONE)
TEST_ENV+=(VE_PROGINF=DETAIL)
#TEST_ENV+=(VE_ADVANCEOFF=YES)
#TEST_ENV+=(VE_LIMIT_OPT="--softs 262144 --hards=unlimited") # backslash issues?
#TEST_ENV+=(VE_OMP_STACKSIZE=1G)
#TEST_ENV+=(OMP_STACKSIZE=128M)
#TEST_ENV+=(OMP_STACKSIZE=32M)
#TEST_ENV+=(OMP_STACKSIZE=8M)

#TEST_ENV+=(--unset=OMP_DYNAMIC)
#TEST_ENV+=(--unset=VE_OMP_DYNAMIC)
#TEST_ENV+=(OMP_PROC_BIND=true)
#TEST_ENV+=(--unset=OMP_PROC_BIND)
#TEST_ENV+=(OMP_WAIT_POLICY=active)

# Use -t to control this
# In hung system (cannot alloc mem) -t 1 might run
#TEST_ENV+=(OMP_NUM_THREADS=1)

#function set_test_env # VAR NEWVAL  :   set (or add) VAR=NEWVAL to TEST_ENV
#{
#  _var="$1"
#  _newval="$2"
#  for _k in "${!TEST_ENV[@]}"; do # loop through all keys
#    _v="${TEST_ENV[${_k}]}" # a single value FOO=123
#    _vval="${_t##${_var}=}"
#    if [ "${_vval}" != "${_v}" ]; then # if it begins with "${_var}="
#      TEST_ENV[${_k}]="${_var}=${_newval}"
#      _ok="y"
#      return
#    fi
#  done
#  TEST_ENV+="${_var}=${_newval}"
#  ... oops, might have had '--unset=${_var}' to modify too
#}

ULIMIT=1048576 # 1 gig stack!
#ULIMIT=8192 # in 1024-byte increments
# cpu-tutorials-matmul-matmul-quantization-cpp like this ulimit
#ULIMIT=65536 # in 1024-byte increments (many will fail below this)
#ULIMIT=131072
#ULIMIT=262144 # mostly ok
#ULIMIT=unlimited

LOG="f.log"
BLD="build-ved4"
BUILD=0
# test failure in test_dnnl_threading; others look like random heap corruption
DEF_GTESTS='test_dnnl_threading test_inner_product_forward test_rnn_forward test_matmul test_convolution_backward_data_f32 test_convolution_backward_weights_f32 test_deconvolution'
# TODO GTESTS should really be an array of multiple tests (tests with options?)
# TODO add -R (ctests Require) and run via "ARGS='-R test_api' make -C $BLD test"
GTESTS=''
GTEST_FILTER='*'
EXAMPLES=''
REQUIRE=''
VERBOSE=-1
THREADS=0
OMP=-1
GDB=0
STRACE=''
LIST=0
NODE=0
TESTS=''
if [ "$VE_NODE_NUMBER" ]; then NODE="$VE_NODE_NUMBER"; fi
# Transform long options into short ones
for arg in "$@"; do
  shift
  if [ "$TESTS" ]; then
    BENCHDNN_ARGS="${BENCHDNN_ARGS} ${arg}"
  else
    case "$arg" in
      --gdb) # -G
        set -- "$@" "-G"
        ;;
      --filter) # -f
        set -- "$@" "-f"
        ;;
      --help) # -h
        set -- "$@" "-h"
        ;;
      --benchdnn) # precede with -B DIR; follow with verbatim benchdnn args
        TESTS="benchdnn"
        ;;
      *) set -- "$@" "$arg"
        ;;
    esac
  fi
done
function usage
{
  echo "$0: Usage"
    awk '/^for arg in/{flag=1;next} /getopts/{flag=1;next} /^done/{flag=0} flag&&/^[^#]+) #/; flag&&/^ *# /' $0
    echo "Examples:"
    echo "  quick rebuild + single gtest case"
    echo "    ./vetest.sh -B build-ved4 -q -g test_dnnl_threading -f '*for_nd.Para*/2'"
    echo "  list compiled examples and tests in -B build-dir"
    echo "    ./vetest.sh -B build-ved4 -l"
    echo "  run gdb on an existing example (./build-ved4/examples/getting-started-cpp)"
    echo "    ./vetest.sh -B build-ved4 -x getting-started-cpp -G"
    exit 0
}
# Parse short options with bash getopts
while getopts "L:B:T:x:g:f:R:N:t:u:vqGSlh" arg; do
    #echo "arg = ${arg}, OPTIND = ${OPTIND}, OPTARG=${OPTARG}"
    case $arg in
      L) # [f.log] $LOG file [subdirs NOT supported].  "less -r r$LOG" to view colorized version
        if [ "${OPTARG}" ]; then LOG="${OPTARG}"; fi
        ;;
      B) # $BLD build directory
        if [ "${OPTARG}" ]; then BLD="${OPTARG}"; fi
        ;;
      T) # search for test and run it
        TESTS="${TESTS} ${OPTARG}"
        ;;
      x) # add an 'example/' to run ex. -x primitives-softmax-cpp
        EXAMPLES="${EXAMPLES} ${OPTARG}"
        ;;
      g) # single gtest to run [default=preset set of tests]
        GTESTS="${GTESTS} ${OPTARG}"
        ;;
      f) # (--filter) gtest filter ex. -g test_matmul -f 'Generic_s8*'
        GTEST_FILTER=${OPTARG}
        ;;
      R) # run with ctest ARGS="-R pattern"
        REQUIRE="${OPTARG}"; GTESTS=''; EXAMPLES=''
        ;;
      N) # [0, or from environment] VE_NODE_NUMBER
        NODE="${OPTARG}"
        ;;
      t) # N OMP_NUM_THREADS [0]~unset
        THREADS="${OPTARG}"
        ;;
      u) # soft ulimit (kB)
        ULIMIT="${OPTARG}"
        ;;
      v) # DNNL_VERBOSE = 0,1,2 if specified once, twice, thrice
        VERBOSE=$((VERBOSE+1))
        ;;
      q) # quick rebuild of $BLD--> q.log
        BUILD=1
        ;;
      G) # (--gdb) run in gdb : requires -g single gtest name)
        GDB=1; STRACE='';
        ;;
      S) # (--strace) run under strace
        STRACE='strace'; GDB=0;
        ;;
      l) # list gtests and examples subdirectory of -B build directory
        LIST=1
        ;;
      h) # (--help)
        usage
        ;;
      *) echo "Unrecognized option '$arg'"
        usage
        ;;
    esac
done
#o) # OpenMp support [default -ooo]:
#  # once    | 0 | build SEQ (no omp support) (run
#  # twice   | 1 | omp support, but test with OMP_NUM_THREADS=1
#  # thrice  | 2 | [default] omp, test without specifying OMP_NUM_THREADS
#  OMP=$(( OMP + 1 ));
#  ;;
if [ "$GDB" = 1 -a -z "$GTESTS" -a -z "$EXAMPLES" ]; then
  echo "-G (--gdb) option requires a -g <test_foo> gtest test name"
  usage
fi
if [ ! -d "${BLD}" ]; then
  echo ""
  echo "Error:  -B ${BLD}  ---  missing build directory?"
  echo ""
  usage
fi
# ULIMIT (inherited by VE, since VE_LIMIT_OPT with spaces poses difficulty)
#ulimit -Hs unlimited # no perms
ulimit -Ss $ULIMIT
echo 'ulimit hard : '`ulimit -Hs`
echo 'ulimit soft : '`ulimit -Ss`
echo "NODE        : ${NODE}"
# VE_LIMIT_OPT is inherited from ulimit if unset
unset VE_LIMIT_OPT
# VE_LIMIT_OPT supercedes VE_STACK_LIMIT
# documentation: https://veos-sxarr-nec.github.io/doc/HowToExecuteVEprogram.txt
export VE_LIMIT_OPT="--softs $ULIMIT --hards unlimited"
rm -rf "r${LOG}"

# maybe incompatible with older VEOSLOG approach?
# (but maybe it gives you at least the PID?)
VEOSLOG=/var/opt/nec/ve/veos/veos${NODE}.log.0
if [ ! -f "${VEOSLOG}" ]; then
  VEOSLOG=""
  VE_EXEC=""
fi
if [ "$VE_EXEC" ]; then ve_exec --show-limit 2>&1 | tee "r${LOG}"; fi

# DNNL_VERBOSE?
if [ $VERBOSE -lt 0 -o $VERBOSE -gt 2 ]; then VERBOSE=2; fi
TEST_ENV+=(DNNL_VERBOSE=$VERBOSE)

# OMP_NUM_THREADS?
#if [ $OMP -lt 0 -o $OMP -gt 2 ]; then OMP=2; fi
#echo "OMP=${OMP}"
#if [ ${OMP} -eq 1 ]; then TEST_ENV+=(OMP_NUM_THREADS=1);
#else TEST_ENV+=(--unset=OMP_NUM_THREADS); TEST_ENV+=(--unset=VE_OMP_NUM_THREADS); fi
if [ "${THREADS}" = 0 ]; then
  TEST_ENV+=(--unset=OMP_NUM_THREADS)
  TEST_ENV+=(--unset=VE_OMP_NUM_THREADS)
else
  TEST_ENV+=(OMP_NUM_THREADS=${THREADS})
  TEST_ENV+=(VE_OMP_NUM_THREADS=${THREADS})
fi

# VE_NODE_NUMBER and VEOS debug mode
TEST_ENV+=(VE_NODE_NUMBER=${NODE})

if [ "debug log4c" -a "${VEOSLOG}" ]; then
  # following put ve_exec (etc.) logs in current directory, at DEBUG level
  if [ ! -d ve ]; then
    mkdir ve
  else
    # clear out old files a week or older -- ve/ can get huge
    find ve -maxdepth 1 -mtime +7 -type f -print0 | xargs -0 rm
  fi
  cat /etc/opt/nec/ve/veos/log4crc \
    | sed -e 's/INFO/DEBUG/;s/CRIT/DEBUG/;s/layout="ve"/layout="ve_debug"/' \
    > ./ve/log4crc
  # adjust according to desired debug level...
  #export LOG4C_RCPATH=`pwd`/ve # ---> ve_exec.log.PID under ve/
  export LOG4C_RCPATH=`pwd`
else
  unset LOG4C_RCPATH
fi

echo "${ENV} ${TEST_ENV[@]} <command>"
if [ ${LIST} -eq 1 ]; then
  for d in examples tests/gtests tests/benchdnn; do
    if [ -d "${BLD}/${d}" ]; then
      echo ""
      echo "Build subdir ${d}:"
      (cd "${BLD}/${d}" && find -maxdepth 1 -type f | sed 's/^..//;/[.]/d;/Makefile/d;s/^prim/0000/' | sort | sed 's/^0000/prim/' | column -c 120)
    fi
  done
  echo ""
  echo "make help -->"
  make -C "${BLD}" help | awk '/^... /{print $2}' | sort | column -c 120
  exit 0
fi
#----------------------- setup for tests
rm -f "r${LOG}"
rm -f typescript # we append /dev/tty raw output here.

#
# I am unable to set stack larger than 32768 ?
#

function options
{
  echo "Build dir      : ${BLD}"
  echo "quick rebuild? : ${BUILD}"
  if [ -z "${GTESTS}" -a -z "${EXAMPLES}" -a -z "${REQUIRE}" -a -z "${TESTS}" ]; then
    echo "Using default set of gtests"
    GTESTS="$DEF_GTESTS";
  else
    echo "gtests         : ${GTESTS}"
  fi
  echo "Raw log        : r${LOG}"
  echo "Final log      : ${LOG}"
}
function quickbuild
{
  # default BUILD=0 does nothing
  if [ "$BUILD" = "old" ]; then
    echo -n "Rebuilding : ./build.sh -avddddqq ..."
    { ./build.sh -avddddqq; echo "build.sh exit code $?"; } \
      >& q.log \
      && echo "YAY (see q.log)" || { echo "OHOH (see q.log)"; exit 1; }
  elif [ "$BUILD" = 1 ]; then
    echo -n "Rebuilding ${BLD} ... "
    { make -C "${BLD}" depend && make -C "${BLD}";
      echo "quick build exit code $?";
      sync;
    } >& q.log \
      && echo "YAY (see q.log)" || { echo "OHOH (see q.log)"; exit 1; }
  fi
}

function decolorize # decolorize FILE [to stdout]
{
  sed -r 's/\x1B\[(([0-9]{1,3})?(;)?([0-9]{1,2})?)?[m,K,H,f,J]//g' "${1}" | tr -d '\r'
}
function comment
{
  echo "$*" | tee -a "r${LOG}"
}
function errorcode
{
  return $*
}
function check_veoserr
{
  if [ "${VEOSLOG}" ]; then
    # if $rc==0, check from VEOSLINE on in VEOSLOG
    #            and set rc=1 for veos errors
    #VEOSNEW=`awk "NR>${VEOSLINE}" "${VEOSLOG}" | grep $pid`
    VEOSNEW=`awk "NR>${VEOSLINE}" "${VEOSLOG}"`
    echo "Basic VEOSNEW:"
    echo "${VEOSNEW}"
    VEOSNEW=`echo "${VEOSNEW}" | grep -v 'exception not served'` # ignorable errors
    if [ "${VEOSNEW}" ]; then >&2 echo "${VEOSNEW}"; fi
    if [ $rc == 0 ]; then
      >&2 echo "test return code seems ok... checking VEOS messages"
      # Surprisingly, can succeed with many
      #     veos.os_module.core ERROR 49734 Assign failed exception not served PID 99962
      # -type messages
      if [ ${pid} -ge 0 ]; then # we generated a ve_exec.log file, probably a real error
        VEOSNEW=`echo "${VEOSNEW}" | grep "${pid}"`
        echo "Pruned VEOSNEW (pid ${pid}):"
        echo "${VEOSNEW}"
        _errs=`echo "${VEOSNEW}" | grep 'ERROR'`
        if [ "${_errs}" ]; then rc=1; echo "${_errs}" >2; fi
      else # be more picky, "error while mapping memory" is fatal
        _errs=`echo "${VEOSNEW}" | grep 'error while mapping memory'`
        if [ "${_errs}" ]; then rc=1; echo "${_errs}" >2
        else echo "no VEOS memory mapping errors" >2
        fi
      fi
    fi
  fi
}
function runtest # runtest COMMAND [ARGS...] -- run in TEST_ENV & send console output to stdout
{
  # run COMMAND in TEST_ENV, returning exit status of COMMAND
  # what's seen on terminal goes to typescript
  #  so abort message that write to /dev/tty also end up in r${LOG}
  >&2 echo "Test: $*"
  echo 'ulimit : '`ulimit -s`
  echo "${ENV} ${TEST_ENV[@]} $*"
  if [ "${VEOSLOG}" ]; then
    mkdir -p ve
    mv -f ve_exec.log.* ve/
    sleep 1
    sync
    VEOSLINE=`cat "${VEOSLOG}" | wc -l`
    #VEOSLINE=`awk 'END{print NR}' ${VEOSLOG}`
    >&2 echo "VEOSLINE = ${VEOSLINE}, VEOSLOG = ${VEOSLOG}"
  fi
  sync
  # time for wall time of test?
  ${ENV} ${TEST_ENV[@]} GTEST_FILTER="${GTEST_FILTER}" script -e -a -c "${STRACE} $*"
  rc=$?
  if [ $(find . -name 've_exec.log.*' | wc -l) -eq 1 ]; then
    pid=`ls -1 ve_exec.log* | sed 's/.*log.//'`
  else
    pid=-1
  fi
  >&2 echo "runtest: ve_exec pid $pid rc $rc"
  check_veoserr # also set rc if veos could not map memory
  return $rc
}

#------------------ run some runtest ---------------------------
tests=0;
fail=0; strfail=''
ok=0; strok=''
# gtests accept --gtest_list_tests and --gtest_filter to run just specific tests
if [ $GDB = 0 ]; then # "" evaluates to false
  {
    >&2 options
    >&2 quickbuild
    for tt in $TESTS; do
      >&2 echo "tt = ${tt}..."
      t=''
      arg=''
      ts=`find "${BLD}" -name "${tt}"`; rc=$?
      >&2 echo "rc=$rc, ts = ${ts}"
      if [ "${ts}" ]; then        #if [ ! $rc = 0 ]; then
        # Select match that is file and executable
        for tx in $ts; do
          >&2 echo "tx in ts is $tx"
          if [ -f "${tx}" -a -x "${tx}" ]; then t="${tx}"; break; fi
        done
      else # Not found.  Is it a cpu-FOO target?
        # FOO is the real executable and 'cpu' is the argument
        tx=${tt##cpu-}   # Try removing a cpu- prefix
        if [ ! "$tx" = "$tt" ]; then
          t=`find "${BLD}" -name "${tx}"`
          arg="cpu"
          echo "switch to ${t} ${arg}"
        fi
      fi
      if [ "${tt}" == "benchdnn" ]; then
        >&2 echo "BENCHDNN_ARGS = ${BENCHDNN_ARGS}"
        arg="${BENCHDNN_ARGS}"
      fi
      >&2 echo "Found t arg = $t $arg"
      if [ -x "${t}" ]; then
        comment "test executable t = ${t}"
        tests=$(($tests+1))
        { >&2 echo; >&2 echo "test executable ${t} ${arg}";
          {
            runtest "${t}" ${arg}
          } \
            && { >&2 echo "OK gtest ${t}"; ok=$(($ok+1)); strok+=";${tt}"; } \
            || { >&2 echo "ERROR gtest ${t} exit code $?"; fail=$(($fail+1)); strfail+=";${tt}"; }
          >&2 echo  "test ${t} done"
        }
      elif [ ! -z "make target" ]; then
        # This way runs 'make $t', which builds and sometimes runs a test
        #   benchdnn targets build and run a test suite
        #   gtest targets are build-only (they run above be finding actual executable)
        >&2 echo "perhaps ${tt} is a 'make' target..."
        # this approach runs 'make' and some tests still get seg faults even
        # running one test at a time.
        makett=`make -C "${BLD}" help | grep -w "${tt}"`
        if [ $? = 0 ]; then
          >&2 echo "# There is a 'make help' target called ${tt}"
          >&2 echo "makett = ${makett}"
          tests=$(($tests+1))
          { >&2 echo; >&2 echo "test ${t} ${arg}";
            {
              runtest make -C ${BLD} ${tt}
            } \
              && { >&2 echo "OK gtest ${t}"; ok=$(($ok+1)); strok+=";${tt}"; } \
              || { >&2 echo "ERROR gtest ${t} exit code $?"; fail=$(($fail+1)); strfail+=";${tt}"; }
            >&2 echo "test ${t} done"
          }
        else
          echo "SKIPPED: ${tt}"
        fi
      elif [ -z "old-benchdnn-way" ]; then
        >&2 echo "look for command to run a benchdnn test suite..."
        # Searches for benchdnn command that 'make ${tt}' would run,
        # and run it without rebuild.
        makecmd=`make -C "${BLD}" -n "${tt}" | grep 'engine=' | awk '{sub(/.*&& /,""); print}'`
        #  Note: need to 'cd' to open "inputs/subdir/params" test spec files
        >&2 echo "makecmd: tt=${tt}"
        >&2 echo "${makecmd}"
        if [ "${makecmd}" ]; then
          tests=$(($tests+1))
          { >&2 echo; >&2 echo "test ${tt}";
            {
              pushd tests/benchdnn
              runtest ${makecmd}
              rc="$?"
              #popd
              #tac "r${LOG}" | awk '/^VEOSLINE/{print} //{exit}' | tac > "vetest.${tt}"
              ##cat "vetest.${tt}" # stdout ends up in r${LOG}

              #>&2 echo "runtest --> rc=${rc}"
              #VEOSNEW=`awk "NR>${VEOSLINE}" "${VEOSLOG}"`
              #if [ $rc == 0 ]; then
              #  >&2 echo "test return code seems ok... checking ${VEOSLOG}"
              #  ERRS=`echo "${VEOSNEW}" | grep 'ERROR'`
              #  #if [ -z "${ERRS}" ]; then
              #    #>&2 echo "test return code seems ok... checking tmp run output vetest.${tt}"
              #    ERRS+=`awk 'BEGIN{IGNORECASE=1}/ERROR/||/Segmentation/{print}' < "vetest.${tt}"`
              #  #fi
              #  if [ "$ERRS" ]; then
              #    rc=1
              #    >&2 echo "${ERRS}"
              #  fi
              #else
              #  >&2 echo "${VEOSNEW}"
              #fi

              #rm -f "vetest.${tt}"
              test $rc == 0
            } \
              && { >&2 echo "OK ${tt}"; ok=$(($ok+1)); strok+=";${tt}"; } \
              || { >&2 echo "ERROR ${tt} exit code $rc"; fail=$(($fail+1)); strfail+=";${tt}"; }
            >&2 echo "test ${tt} done"
          }
        else
          >&2 echo "SKIPPED: ${tt}"
        fi
      fi
    done
    for t in $GTESTS; do
      tests=$(($tests+1))
      { >&2 echo; >&2 echo "test ${t}";
        {
          runtest "${BLD}/tests/gtests/${t}"
        } \
          && { >&2 echo "OK gtest ${t}"; ok=$(($ok+1)); strok+=";${t}"; } \
          || { >&2 echo "ERROR gtest ${t} exit code $?"; fail=$(($fail+1)); strfail+=";${t}"; }
        >&2 echo "test ${t} done"
      }
    done
    for t in $EXAMPLES; do
      tests=$(($tests+1))
      { >&2 echo; >&2 echo "run ${BLD}/examples/${t}";
        {
          runtest "${BLD}/examples/${t}"
        } \
          && { >&2 echo "OK gtest ${t}"; ok=$(($ok+1)); strok+=";${t}"; } \
          || { >&2 echo "ERROR gtest ${t} exit code $?"; fail=$(($fail+1)); strfail+=";${t}"; }
        >&2 echo "test ${t} done"
      }
    done
    if [ "${REQUIRE}" ]; then
      tests=$(($tests+1))
      { >&2 echo; >&2 echo "ARGS='-R ${REQUIRE}' make -C '${BLD}' test";
        {
          ARGS="-R '${REQUIRE}'" runtest make -C "${BLD}" test
        } \
        && { >&2 echo "OK gtest ${t}"; ok=$(($ok+1)); strok+=";${t}"; } \
        || { >&2 echo "ERROR gtest ${t} exit code $?"; fail=$(($fail+1)); strfail+=";${t}"; }
        >&2 echo "test ${t} done"
      }
    fi
  } \
    2>&1 1>>"r${LOG}" 2> >(tee >(cat 1>&2)) # stdout+stderr-->LOG; stderr-->console
    #2>&1 1>>"${LOG}"
  # console shows just stderr summary, while
  # LOG also captures all decolorized console output of the test (incl abort msg)


elif [ $GDB = 1 ]; then # "" evaluates to false
  {
    options
    quickbuild
    # here we run gdb on "everything" (1 test) capturing /dev/tty session
    # with full abort / traceback info to r$LOG (later decolorized into $LOG)
    for t in $GTESTS; do
      tests=$(($tests+1))
      { >&2 echo; >&2 echo "test ${t}";
          #test0 "${BLD}/tests/gtests/${t}"
          # sample
          #     script typescript -c '{ echo hi; echo bye; gdb --args ls; }'
          cmd="script r${LOG} --flush -c '{ gdb --args ${BLD}/tests/gtests/${t}; echo bye; }'"
          >&2 echo $cmd
          eval $cmd
          >&2 echo "test ${t} done"
      }
    done
    for t in $EXAMPLES; do
      tests=$(($tests+1))
      { >&2 echo; >&2 echo "test ${t}";
          cmd="script r${LOG} --flush -c '{ gdb --args ${BLD}/examples/${t}; echo bye; }'"
          >&2 echo $cmd
          eval $cmd
          >&2 echo "test ${t} done"
      }
    done
  }
fi
if [ ${fail} -gt 0 ]; then
  comment "`ls -1 ve_exec.log*` --> ve/"
  mv -v ve_*.log* ve/ || echo "(no ve_*.log* in current dir)"
  comment "Common VE exit codes (${fail} failure[s]):"
  comment "    1 --> failed assertion"
  comment "  134 --> Unable to grow stack"
  comment "  137 --> free(): invalid pointer: 0x..., and backtrace"
  comment "  139 --> Segmentation fault: Address not mapped to object at 0x..."
fi
options
if [ ${ok} -gt 0 ]; then
  comment "PASSED: ${ok}" "`echo "$strok" | sed 's/;/\n    /g'`"
fi
if [ ${fail} -gt 0 ]; then
  comment "FAILED: ${fail}" "`echo "$strfail" | sed 's/^/\n    /g'`"
fi
comment "Summary: ${tests} tests; OK ${ok}   FAILED ${fail}" 
if [ $(( $ok + $fail )) -gt 0 ]; then
  comment "$((100 * $ok / $tests))% tests passed, ${fail} tests failed out of ${tests}"
fi
decolorize "r${LOG}" > "${LOG}"

#
# failed
#         24 - test_dnnl_threading (Failed)
#         37 - test_inner_product_forward (OTHER_FAULT)
#37: [ RUN      ] TestInnerProductForward/inner_product_test_float.TestsInnerProduct/1
#37: dnnl_verbose,create,cpu,inner_product,gemm:ref,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:bcda:f0 bia_f32::blocked:a:f0 dst_f32::blocked:ab:f0,,,mb2ic512ih2iw2oc48,0.14209
#37: dnnl_verbose,exec,cpu,inner_product,gemm:ref,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:bcda:f0 bia_f32::blocked:a:f0 dst_f32::blocked:ab:f0,,,mb2ic512ih2iw2oc48,1.15991
#37: test_inner_product_forward: malloc.c:2923: __libc_malloc: Assertion `!victim || ((((mchunkptr)((char*)(victim) - 2*(sizeof(size_t)))))->size & 0x2) || ar_ptr == (((((mchunkptr)((char*)(victim) - 2*(sizeof(size_t)))))->size & 0x4) ? ((heap_info *) ((unsigned long) (((mchunkptr)((char*)(victim) - 2*(sizeof(size_t))))) & ~((2 * (1LL << 30)) - 1)))->ar_ptr : &main_arena)' failed.                                        
#21/52 Test #37: test_inner_product_forward ....................***Exception: Other  2.02 sec
#
#         47 - test_convolution_backward_data_f32 (SEGFAULT)
#47: [ RUN      ] BackwardData_Simple_NCHW_CPU/convolution_test.TestConvolution/0
#47: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#31/52 Test #47: test_convolution_backward_data_f32 ............***Exception: SegFault  3.65 sec
#
#         48 - test_convolution_backward_weights_f32 (SEGFAULT)
#48: [ RUN      ] BackwardWeights_Simple_NCHW_CPU/convolution_test.TestConvolution/0
#48: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#32/52 Test #48: test_convolution_backward_weights_f32 .........***Exception: SegFault  4.29 sec
#
#         49 - test_deconvolution (SEGFAULT)
#49: [ RUN      ] SimpleSmall_NCHW_CPU/deconvolution_test_float.TestDeconvolution/0
#49: dnnl_verbose,info,verbose:2
#49: dnnl_verbose,info,DNNL v1.3.0 (commit 86e142dd5617a18f526b56acf0fc09e37b3012ce)
#49: dnnl_verbose,info,cpu,runtime:OpenMP
#49: dnnl_verbose,info,cpu,isa:Vanilla
#49: dnnl_verbose,info,gpu,runtime:none
#49: dnnl_verbose,create,cpu,convolution,ref:any,backward_data,src_f32::blocked:abcd:f0 wei_f32::blocked:bacd:f0 bia_f32::blocked:a:f0 dst_f32::blocked:abcd:f0,,alg:convolution_direct,mb2_ic4oc6_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.139893
#49: dnnl_verbose,create,cpu,deconvolution,ref:any,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:abcd:f0 bia_f32::blocked:a:f0 dst_f32::blocked:abcd:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,1.01392
#49: dnnl_verbose,exec,cpu,deconvolution,ref:any,forward_training,src_f32::blocked:abcd:f0 wei_f32::blocked:abcd:f0 bia_f32::blocked:a:f0 dst_f32::blocked:abcd:f0,,alg:deconvolution_direct,mb2_ic6oc4_ih4oh4kh3sh1dh0ph1_iw4ow4kw3sw1dw0pw1,0.937012
#49: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#33/52 Test #49: test_deconvolution ............................***Exception: SegFault  0.49 sec
#
#         59 - test_rnn_forward (SEGFAULT)
#59: [ RUN      ] TestRnn_CPU/rnn_forward_test_f32.TestsRnn/0
#59:  init strm @ 0x60fffff9a408
#...
#59:  init_tensor(src_iter...)DONE...
#59: Segmentation fault: Address not mapped to object at 0xfffffffffffffff8
#43/52 Test #59: test_rnn_forward ..............................***Exception: SegFault  0.48 sec
#
#         63 - test_matmul (OTHER_FAULT)
#63: [ RUN      ] Generic_s8s8s32/iface.TestsMatMul/5
#63: dnnl_verbose,create,cpu,matmul,matmul-gemm:ref,undef,src_s8::blocked:ba:f0 wei_s8::blocked:ab:f0 bia_f32::blocked:ab:f0 dst_s32::blocked:ab:f0,oscale:0:2;zero_points:'src:0:-2_wei:0:2';,,m10n20k2,0.172852
#63: dnnl_verbose,exec,cpu,matmul,matmul-gemm:ref,undef,src_s8::blocked:ba:f0 wei_s8::blocked:ab:f0 bia_f32::blocked:ab:f0 dst_s32::blocked:ab:f0,oscale:0:2;zero_points:'src:0:-2_wei:0:2';,,m10n20k2,0.477051
#47/52 Test #63: test_matmul ...................................***Exception: Other  0.63 sec
#
