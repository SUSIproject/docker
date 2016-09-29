all: docker build-susi-builder build-susi-arm-builder

docker: docker/susi-authenticator \
	docker/susi-cluster \
	docker/susi-core \
	docker/susi-duktape \
	docker/susi-leveldb \
	docker/susi-mqtt \
	docker/susi-shell


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

docker/%: debs/%.deb
	cp debs/$(shell basename $@).deb containers/$(shell basename $@)/
	docker build -t trusch/$(shell basename $@) containers/$(shell basename $@)
	docker push trusch/$(shell basename $@)

build-susi-builder:
	docker build -t trusch/susi-builder:stable susi-builder
	docker push trusch/susi-builder:stable

build-susi-arm-builder:
	docker build -t trusch/susi-arm-builder:stable susi-arm-builder
	docker push trusch/susi-arm-builder:stable
