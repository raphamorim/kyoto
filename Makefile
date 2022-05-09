debug ?=

ifdef debug
	release :=
	target :=debug
	extension :=debug
	$(info DEBUG: $(debug))
else
	release :=--release
	target :=release
	extension :=
endif

# build:
# 	cargo build $(release)

build:
	rustup run nightly cargo build $(release)

docker-build:
	docker build -t kyoto -f ./Dockerfile .

s:
	make build && ./target/release/kyoto ./examples/sum.kto

start:
	./target/release/kyoto

dev:
	./target/debug/kyoto

test-cli:
	sh ./tests/test-cli.sh

test:
	rustup run nightly cargo test $(release)

install:
	cp target/$(target)/kyoto ~/bin/kyoto-$(extension)

all: build install
 
help:
	@echo "usage: make kyoto [debug=1]"