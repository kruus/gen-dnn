#!/bin/bash
#S=ved B=build-$S I=install-$S; { rm -f $I; { make -C $B -j 16 install || make -C $B -j 1 install; } >& x.log  && VE_NODE_NUMBER=2 DNNL_VERBOSE=2 gdb --args $B/examples/cnn-inference-int8-cpp cpu; }

ENV=`which env`
TEST_ENV=()
#TEST_ENV+=(VE_PROGINF=DETAIL)

#VE_NODE_NUMBER=2 DNNL_VERBOSE=2 gdb -d src/common -d src/common/ve -d src/cpu -d src/cpu/ve -d include -d examples -s $B/src/libdnnl.so --args $*
BLD="build-ved"
LOG="f.log"
VERBOSE=-1
NODE=0
PRG=0
if [ "$VE_NODE_NUMBER" ]; then NODE="$VE_NODE_NUMBER"; fi
function usage
{
  echo "$0: Usage"
    awk '/^for arg in/{flag=1;next} /getopts/{flag=1;next} /^done/{flag=0} flag&&/^[^#]+) #/; flag&&/^ *# /' $0
    echo "Examples:"
    echo "  ./gdb.sh -N 2 -B build-ved -vvv -L f.log -- ls a*.cpp"
    echo "  ./gdb.sh -N 2 -B build-ved -vvv -L f.log ls a*.cpp   # same effect, (1st unrecognized option)"
    echo "Both above will log a gdb session for OneDNN binary (well an 'ls' command here)"
    echo " to rg.log and finally clean up control chars into a final g.log"
    echo ""
    echo "To debug api-c binary, with symbols and source:"
    echo "   ./gdb.sh -B build-ved -- build-ved/tests/api-c"
    exit 0
}
Options=("$@")
# Parse short options with bash getopts
while getopts "L:B:N:vh" arg; do
    #echo "arg = ${arg}, OPTIND = ${OPTIND}, OPTARG=${OPTARG}"
    case $arg in
      L) # [f.log] $LOG file [subdirs NOT supported].  "less -r r$LOG" to view colorized version
        if [ "${OPTARG}" ]; then LOG="${OPTARG}"; fi
        ;;
      B) # $BLD build directory
        if [ "${OPTARG}" ]; then BLD="${OPTARG}"; fi
        ;;
      N) # [0, or from environment] VE_NODE_NUMBER
        NODE="${OPTARG}"
        ;;
      p) # enable proginfo
	PRG=1
	;;
      v) # DNNL_VERBOSE = 0,1,2 if specified once, twice, thrice
        VERBOSE=$((VERBOSE+1))
        ;;
      h) # (--help)
        usage
        ;;
      :) echo "Error -${OPTARG} requires an argument."
	usage
	;;
      -) echo "End options"
	break;
	;;
      *) echo "Unrecognized option '$arg'"
	((OPTIND--)); break;
        ;;
    esac
done

echo "end up with OPTIND=$OPTIND"
echo "end up with Options=${Options[@]}"
Rest=${Options[@]:$OPTIND-1}
echo "remaining options: ${Rest[@]}"

if [ ! -d "${BLD}" ]; then
  echo ""
  echo "Error:  -B ${BLD}  ---  missing build directory?"
  echo ""
  usage
fi

# DNNL_VERBOSE?
if [ $VERBOSE -lt 0 -o $VERBOSE -gt 2 ]; then VERBOSE=2; fi
TEST_ENV+=(DNNL_VERBOSE=$VERBOSE)
TEST_ENV+=(VE_NODE_NUMBER=${NODE})
if [ ${PRG} -ne 0 ]; then TEST_ENV+=(VE_PROGINFO=DETAIL); fi

GDB_CMD='gdb -d src/common -d src/common/ve -d src/cpu -d src/cpu/ve -d include -d examples -s '"${BLD}/src/libdnnl.so"''

function decolorize # decolorize FILE [to stdout]
{
  sed -r 's/\x1B\[(([0-9]{1,3})?(;)?([0-9]{1,2})?)?[m,K,H,f,J]//g' "${1}" | tr -d '\r'
}
function comment
{
  echo "$*" | tee -a "r${LOG}"
}

if [ 0 -eq 1 ]; then # Debug version (no real gdb run)
	cmd="${TEST_ENV[@]} script r${LOG} --flush -c '{ ${GDB_CMD} --args ${Rest} ; echo bye; }'"
	comment "Command:"
	comment "  $cmd"
	exit 0
fi

echo "LOG = r${LOG} ---> final ${LOG}"
rm -f "r${LOG}"
{ >&2 echo; >&2 echo "test ${t}";
	# Example:
	#     script x.log -c '{ echo hi; echo bye; gdb --args ls; }'
	cmd="${TEST_ENV[@]} script r${LOG} --flush -c '{ ${GDB_CMD} --args ${Rest} ; echo bye; }'"
	>&2 echo $cmd
	eval $cmd
	>&2 echo "test ${t} done"
}
echo "LOG = r${LOG} ---> final ${LOG}"
pwd
ls -l r${LOG}
decolorize "r${LOG}" > "${LOG}"
# End
