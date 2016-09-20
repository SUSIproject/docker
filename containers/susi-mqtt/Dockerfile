FROM debian:stable

RUN apt-get -y update && apt-get -y install libboost-system1.55 libboost-program-options1.55 libssl1.0.0 libmosquitto1 libmosquittopp1 && apt-get clean

ADD susi-mqtt.deb /opt/susi-mqtt.deb
RUN dpkg -i /opt/susi-mqtt.deb

RUN ldconfig
