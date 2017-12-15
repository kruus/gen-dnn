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

