#!/bin/bash

proot -r /opt/rootfs -q qemu-arm-static /bin/bash -c "
rm -r /src/build; \
mkdir -p /src/build; \
cd /src/build; \
cmake ..; \
make -j8 package; \
"

exit $?
