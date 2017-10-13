#!/bin/bash
diff -bBrU4 ../sx-dnn/src/common src/common  > vsrc-common.diff
diff -bBrU4 ../sx-dnn/src/cpu    src/cpu     > vsrc-cpu.diff
diff -bBrU4 ../sx-dnn/include    include     > vinclude.diff
diff -bBrU4 ../sx-dnn/tests      tests       > vtests.diff
