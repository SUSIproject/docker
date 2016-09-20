#!/bin/bash

docker build -t trusch/susi-builder:testing susi-builder
docker push trusch/susi-builder:testing

exit $?
