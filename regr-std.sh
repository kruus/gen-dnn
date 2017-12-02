#!/bin/bash
./regr.sh --dir=FWD_B A1 -nA1-FWD_B \
	&& ./regr.sh --dir=BWD_D A1 -nA1-BWD_D \
	&& ./regr.sh --dir=BWD_WB A1 -nA1-BWD_WB \
	&& ./regr.sh --dir=FWD_B A3 -nA3-FWD_B \
	&& ./regr.sh --dir=BWD_D A3 -nA3-BWD_D \
	&& ./regr.sh --dir=BWD_WB A3 -nA3-BWD_WB \
	&& ./regr.sh FWD \
	&& ./regr.sh BWD_D \
	&& ./regr.sh BWD_WB \
	&& ./regr.sh ALL \
	&& ./regr.sh MINI \
	&& echo YAY

