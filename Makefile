build:
	cargo build --release

build-nigthly:
	rustup run nigthly cargo build --release

s:
	make build && ./target/release/kyoto ./examples/sum.kto

start:
	./target/release/kyoto

dev:
	./target/debug/kyoto

test:
	cargo test --release

test-nigthly:
	rustup run nightly cargo test --release

docs-run:
	cd ./docs && cargo server --open

docs-build:
	cd ./docs && make build

all: build
