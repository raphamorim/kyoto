debug ?=

$(info DEBUG: $(debug))

ifdef debug
	release :=
	target :=debug
	extension :=debug
else
	release :=--release
	target :=release
	extension :=
endif

build:
	cargo build $(release)

docker-build:
	docker build -t kyoto -f ./Dockerfile .

start:
	./target/release/kyoto

dev:
	./target/debug/kyoto

install:
	cp target/$(target)/kyoto ~/bin/kyoto-$(extension)

all: build install
 
help:
	@echo "usage: make kyoto [debug=1]"