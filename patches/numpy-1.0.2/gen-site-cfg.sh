#!/bin/sh
cat > numpy/distutils/site.cfg <<HERE
[DEFAULT]
include_dirs = ${BUILDROOT}/include/clapack:${BUILDROOT}/include
library_dirs = ${BUILDROOT}/lib

[lapack]
lapack_libs = lapack, F77, I77

[blas]
blas_libs = blas, F77, I77
HERE
