IMG="debian-pandoc"

all: clean build

clean:
	docker rmi $(IMG):latest &>/dev/null || true

build: build
	docker build --pull=true --no-cache -t $(IMG):latest .

.PHONY: clean build
