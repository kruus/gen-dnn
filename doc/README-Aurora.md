# SX-Aurora porting

## Prerequisites:

Aurora C and C++ compiler ncc and nc++ should be in $PATH. That means usually:
```
export PATH=/opt/nec/ve/bin:$PATH
```

The environment variable NLC_BASE should point to the location of the NEC Numeric Library Collection, for example:

```
export NLC_BASE=/opt/nec/ve/nlc/0.9.0
```

The ```-proginf``` build option links with libveperf, which must be added to the linker path:

```
export LDFLAGS="-L/usr/uhome/aurora/mpc/pub/veperf/latest/lib"
or
export LDFLAGS="-L/opt/nec/ve/veperf/latest/lib"
```

## Building

```
CC=ncc CXX=nc++ ./build.sh -a
```

### New way:

*cmake* invoked with the ve.cmake TOOLCHAIN (as in *build.sh -a*) will set up
*ncc* directories by looking in standard locations, even if not in your PATH.

### git using shared accounts
Since there are multiple people working off the nlabhpg account, you should now
**git config user.name** and **git config user.email** *per git subdirectory*.

This insulates you from having all your commits blamed on someone else (whoever
last set the git global value).

### Example of updating b single build/asm file
(cd build/tests/benchdnn/ && make conv/sx_conv3.cpp.s)

New targets can be added as in tests/benchdnn/CmakeLists.txt
