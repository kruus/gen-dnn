#!/bin/bash
# vim: set ts=3 sw=3 et ai :
if [ -f summary-mini.txt ]; then rm -f summary-mini.txt; fi
for comp in ek musek snake10; do
   for pfx in minifwd minibwd_d minibwd_w; do
      file="${pfx}-${comp}.log"
      if [ -f "${file}" ]; then
         cat ${pfx}-${comp}.log | grep '^t:' | sed "s/^/${comp} /" \
            >> summary-mini.txt
      else
         echo "skipping ${file}"
      fi
   done
done
cat summary-mini.txt | sed 's/--dir=[^ ]*//' | sort -s -k11,12 -k1 | column -t \
   > sort1-mini.txt
echo "Created output files:"
ls -l summary-mini.txt sort1-mini.txt
