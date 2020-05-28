#!/bin/bash
rm -f 
tries=0
oops=0
ok=0
rm -f mk.log
for i in `seq 1 100`; do
	tries=$(( $tries + 1 ))
	make VERBOSE=1 >> mk.log 2>&1 \
	&& { ok=$(($ok+1)); echo "$i OK"; } \
	|| { oops=$(($oops+1)); echo "$i OOPS"; }
done
echo "make logs --> mk.log"
echo "tries   $tries"
echo "oops    $oops"
echo "ok      $ok"
