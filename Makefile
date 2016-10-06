all: docker build-susi-builder build-susi-arm-builder

docker: docker-cpp/susi-authenticator \
	docker-cpp/susi-cluster \
	docker-cpp/susi-core \
	docker-cpp/susi-duktape \
	docker-cpp/susi-leveldb \
	docker-cpp/susi-mqtt \
	docker-cpp/susi-shell \
	docker-go/github.com/SUSIproject/susi-mongodb \
	docker-go/github.com/trusch/boltplus/susi-boltplus \


debs: debs/susi-authenticator.deb \
	debs/susi-cluster.deb \
	debs/susi-core.deb \
	debs/libsusi.deb \
	debs/libbson.deb \
	debs/susi-duktape.deb \
	debs/susi-leveldb.deb \
	debs/susi-mqtt.deb \
	debs/susi-shell.deb

debs/%.deb:
	mkdir -p debs
	docker run -v $(shell pwd)/components/$(shell basename $@ .deb):/src trusch/susi-builder:stable
	cp components/$(shell basename $@ .deb)/build/*.deb debs/$(shell basename $@)

docker-cpp/%: debs/%.deb
	cp debs/$(shell basename $@).deb containers/$(shell basename $@)/
	docker build -t trusch/$(shell basename $@):$${TRAVIS_BRANCH:-latest} containers/$(shell basename $@)
	docker tag trusch/$(shell basename $@):$${TRAVIS_BRANCH:-latest} quay.io/trusch/$(shell basename $@):$${TRAVIS_BRANCH:-latest}

docker-go/%:
	mkdir -p /tmp/gopath
	GOPATH=/tmp/gopath go get -u -v $(shell echo $@ | cut -d/ -f 2-)
	cp /tmp/gopath/bin/$(shell basename $@) containers/$(shell basename $@)/
	docker build -t trusch/$(shell basename $@):$${TRAVIS_BRANCH:-latest} containers/$(shell basename $@)
	docker tag trusch/$(shell basename $@):$${TRAVIS_BRANCH:-latest} quay.io/trusch/$(shell basename $@):$${TRAVIS_BRANCH:-latest}

push-dockerhub: docker
	docker login -u=$${DOCKER_USERNAME} -p=$${DOCKER_PASSWORD}
	docker push trusch/susi-authenticator
	docker push trusch/susi-cluster
	docker push trusch/susi-core
	docker push trusch/susi-duktape
	docker push trusch/susi-leveldb
	docker push trusch/susi-mqtt
	docker push trusch/susi-shell
	docker push trusch/susi-mongodb
	docker push trusch/susi-boltplus

push-quayio: docker
	docker login -u=$${QUAYIO_USERNAME} -p=$${QUAYIO_PASSWORD} quay.io
	docker push quay.io/trusch/susi-authenticator
	docker push quay.io/trusch/susi-cluster
	docker push quay.io/trusch/susi-core
	docker push quay.io/trusch/susi-duktape
	docker push quay.io/trusch/susi-leveldb
	docker push quay.io/trusch/susi-mqtt
	docker push quay.io/trusch/susi-shell
	docker push quay.io/trusch/susi-mongodb
	docker push quay.io/trusch/susi-boltplus


build-susi-builder:
	docker build -t trusch/susi-builder:stable susi-builder
	docker push trusch/susi-builder:stable

build-susi-arm-builder:
	docker build -t trusch/susi-arm-builder:stable susi-arm-builder
	docker push trusch/susi-arm-builder:stable
