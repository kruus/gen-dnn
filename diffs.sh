#!/bin/bash
diff -bBrU4 src/common ../../mkl-dnn/src/common > src-common.diff
diff -bBrU4 src/cpu ../../mkl-dnn/src/cpu > src-cpu.diff
diff -bBrU4 include ../../mkl-dnn/include > include.diff
diff -bBrU4 src/cpu src/vanilla > vanilla.diff
