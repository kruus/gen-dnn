#!/bin/bash
# vim: set ts=3 sw=3 et ai :
if [ -f summary-mini.txt ]; then rm -f summary-mini.txt; fi
for comp in ek musek snake10 sx; do
   for pfx in minifwd minibwd_d minibwd_w; do
      file="${pfx}-${comp}.log"
      threads=`awk '/omp_max_thr=/{sub(/.*omp_max_thr.*=/,"");sub(/[^0-9].*/,""); print;}' ${file}`
      if [ -f "${file}" ]; then
         cat ${pfx}-${comp}.log | grep '^t:' | sed "s/^/${comp} ${threads} /" \
            >> summary-mini.txt
      else
         echo "skipping ${file}"
      fi
   done
done
cat summary-mini.txt | sed 's/--dir=[^ ]*//' | sort -s -k11,12 -k1 | column -t \
   > sort1-mini.txt
cat summary-mini.txt | sed 's/--dir=[^ ]*//' | sort -s -k12 -k11 -k3 | column -t \
   > sort2-mini.txt
echo "Created output files:"
ls -l summary-mini.txt sort1-mini.txt sort2-mini.txt
