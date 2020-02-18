#!/bin/bash
DNNLDIR=../dnnl
diff -bBrU4 ${DNNLDIR}/src/common src/common  > vsrc-common.diff
diff -bBrU4 ${DNNLDIR}/src/cpu    src/cpu     > vsrc-cpu.diff
diff -bBrU4 ${DNNLDIR}/include    include     > vinclude.diff
diff -bBrU4 ${DNNLDIR}/tests      tests       > vtests.diff
diff -bBrU4 ${DNNLDIR}/examples   examples    > vexamples.diff
