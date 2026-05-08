DOCKER_USER ?= adamroberts91
IMAGE_NAME  ?= python-3-ffmpeg
VERSION     ?= 1.0.0
IMAGE       := $(DOCKER_USER)/$(IMAGE_NAME)

PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: build build-multi push tag-latest

build:
	docker build -t $(IMAGE):$(VERSION) -t $(IMAGE):latest .

build-multi: ## Build multi-arch image
	docker buildx build \
		--platform $(PLATFORMS) \
		-t $(IMAGE):$(VERSION) \
		-t $(IMAGE):latest \
		.

push:
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest

release: ## Build and push multi-arch image in one step
	docker buildx build \
		--platform $(PLATFORMS) \
		-t $(IMAGE):$(VERSION) \
		-t $(IMAGE):latest \
		--push \
		.

test:
	docker run --rm $(IMAGE):$(VERSION) python --version
	docker run --rm $(IMAGE):$(VERSION) uv --version
	docker run --rm --entrypoint ffmpeg $(IMAGE):$(VERSION) -version | head -1