#!/bin/bash
diff -bBrU4 ../../mkl-dnn/src/common src/common  > msrc-common.diff
diff -bBrU4 ../../mkl-dnn/src/cpu    src/cpu     > msrc-cpu.diff
diff -bBrU4 ../../mkl-dnn/include    include     > minclude.diff
diff -bBrU4 ../../mkl-dnn/tests      tests       > mtests.diff
diff -bBrU4 src/cpu                  src/vanilla > cpu-vanilla.diff
git diff mkldnn/master include src/common src/cpu tests > mkldnn.diff
