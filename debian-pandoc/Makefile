DOCKER ?= podman
IMG := "debian-pandoc"

all: clean build

.PHONY: clean
clean:
	$(DOCKER) rmi $(IMG):latest &>/dev/null || true

.PHONY: build
build: build
	$(DOCKER) build --pull=true --no-cache -t $(IMG):latest .

.PHONY: clean build
