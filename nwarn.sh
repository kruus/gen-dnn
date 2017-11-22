#!/bin/bash
# strip line number info0rmation from log files to compare
# build logs and debug cmake issues
# Example:
#   ./nln.sh build-sx.log > bb.log
if [ -f "$1" ]; then
  awk '/Unvectorized/{next}/incorrect ftrace/{next}/and ignored.$/{next}/clause simplified.$/{next}/fatil(/{echo "ERROR";echo "FATAL";print;next}//' "$1"
elif [ "$1" = "" ]; then
  awk '/Unvectorized/{next}/incorrect ftrace/{next}/and ignored.$/{next}/clause simplified.$/{next}/fatal(/{echo "ERROR";echo "FATAL";print;next}//'
else
  exit 1
fi
