#!/bin/bash
# strip line number info0rmation from log files to compare
# build logs and debug cmake issues
# Example:
#   ./nln.sh build-sx.log > bb.log
if [ -f "$1" ]; then
  gawk '/^[^ ]*\([0-9]*\):/ {gsub(/\([0-9]*\):/,":",$1); print; next} //{print}' "$1"
else
exit 1
fi
