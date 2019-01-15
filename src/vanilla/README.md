After gen-dnn pull requests before around Jan 2018, the codebases were similar
enough to put most differences directly into src/cpu/XXX files.

This directory contains:

- symlinks for non-jit -DTARGET\_VANILLA files into ../cpu/
- a few copies of files with [temporary?] debug capability

Additional, alternate implementations might also be in this directory,
in which case cpu\_engine.cpp should be a different file from ../cpu/
