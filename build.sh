#!/bin/bash

docker build -t trusch/susi-builder:stable susi-builder
docker push trusch/susi-builder:stable

exit $?
