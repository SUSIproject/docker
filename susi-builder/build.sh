#!/bin/bash

rm -r /src/build
mkdir -p /src/build
cd /src/build
cmake ..
make -j8 package

exit $?
