build:
	cargo build

read-file:
	make build && ./target/release/kyoto ./specs-tests/sum.kto

repl:
	make build && ./target/release/kyoto

test:
	cargo test --release

docs-run:
	cd ./docs && cargo server --open

docs-build:
	cd ./docs && make build

all: build
