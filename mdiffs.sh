#!/bin/bash
diff -NbBrU4 ../../mkl-dnn/src/common src/common  > msrc-common.diff
diff -NbBrU4 ../../mkl-dnn/src/cpu    src/cpu     > msrc-cpu.diff
diff -NbBrU4 ../../mkl-dnn/include    include     > minclude.diff
diff -NbBrU4 ../../mkl-dnn/tests      tests       > mtests.diff
