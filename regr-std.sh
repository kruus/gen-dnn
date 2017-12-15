#!/bin/bash
SXskip=""
if [ `uname -m` = "SX-ACE" ]; then
	SXskip="--skip-impl=sx2" # these are both extremely slow
fi
if [ $NLC_BASE ]; then
        THREADS=1
fi
./regr.sh $THREADS --dir=FWD_B A1 -nA1-FWD_B \
	&& ./regr.sh $THREADS --dir=BWD_D A1 -nA1-BWD_D \
	&& ./regr.sh $THREADS --dir=BWD_WB A1 -nA1-BWD_WB \
	&& ./regr.sh $THREADS --dir=FWD_B A3 -nA3-FWD_B \
	&& ./regr.sh $THREADS --dir=BWD_D A3 -nA3-BWD_D \
	&& ./regr.sh $THREADS --dir=BWD_WB A3 -nA3-BWD_WB \
	&& ./regr.sh $THREADS FWD \
	&& ./regr.sh $THREADS BWD_D \
	&& ./regr.sh $THREADS BWD_WB \
	&& ./regr.sh $THREADS ALL \
	&& ./regr.sh $THREADS ${SXskip} minifwd \
	&& ./regr.sh $THREADS ${SXskip} minibwd_d \
	&& ./regr.sh $THREADS ${SXskip} minibwd_w \
	&& echo YAY

