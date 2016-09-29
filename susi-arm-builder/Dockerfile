FROM kinsamanka/docker-qemu-chroot:jessie-base

RUN proot -r /opt/rootfs -q qemu-arm-static /bin/bash -c "\
  apt-get update; \
  apt-get upgrade -y; \
  apt-get install -y \
    cmake \
    make \
    g++ \
    libboost-system-dev \
    libboost-program-options-dev \
    libssl-dev \
    libleveldb-dev \
    libmosquitto-dev \
    libmosquittopp-dev; \
  apt-get -f -y install; \
  apt-get clean; \
"

ADD build.sh /bin/build.sh
ENTRYPOINT ["/bin/bash","/bin/build.sh"]
