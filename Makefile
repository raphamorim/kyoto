build:
	cargo build

read-file:
	make build && ./target/release/kyoto ./specs-tests/sum.kto

repl:
	make build && ./target/release/kyoto

lint:
	cargo fmt -- --check --color always
	cargo clippy --all-targets --all-features -- -D warnings

test:
	make lint
	RUST_BACKTRACE=full cargo test --release

docs-run:
	cd ./docs && cargo server --open

docs-build:
	cd ./docs && make build

all: build
