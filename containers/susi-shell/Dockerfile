FROM debian:stable

RUN apt-get -y update && apt-get -y install libboost-system1.55 libboost-program-options1.55 libssl1.0.0 && apt-get clean

ADD susi-shell.deb /opt/susi-shell.deb
RUN dpkg -i /opt/susi-shell.deb

RUN ldconfig
