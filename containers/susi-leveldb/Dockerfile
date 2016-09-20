FROM debian:stable

RUN apt-get -y update && apt-get -y install libboost-system1.55 libboost-program-options1.55 libssl1.0.0 libleveldb1 && apt-get clean

ADD susi-leveldb.deb /opt/susi-leveldb.deb
RUN dpkg -i /opt/susi-leveldb.deb

RUN ldconfig
