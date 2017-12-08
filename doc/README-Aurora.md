# SX-Aurora porting

## Prerequisites:

Aurora C and C++ compiler ncc and nc++ should be in $PATH. That means usually:
```
export PATH=/opt/nec/ve/bin:$PATH
```

Install the coreutils-arch-ve RPM.

Set the environment variable
```
export VE_NODE_NUMBER=0
```
such that the Aurora specific *arch* and *uname -p* located in /opt/nec/ve/bin return only the architecture string.

The NLC NEC Library Collection is expected to be in /opt/nec/ve/nlc/0.9.0. Currently this path is hardcoded in cmake/NLC.cmake.


## Building

```
CC=ncc CXX=nc++ ./build.sh -a
```

