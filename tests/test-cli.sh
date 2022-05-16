#!/bin/sh

echo $SHELL

throw_error() {
	echo "\n(!) Kyoto CLI test error: \n • expected $1"
	exit 1;	
}

CLI=$(./target/release/kyoto ./examples/sum.kto)

echo $CLI | grep -q "Operator(\".\")" || throw_error "Operator(\".\")"
echo $CLI | grep -q "Ident(\"sum\")" || throw_error "Ident(\"sum\")"
echo $CLI | grep -q "Ident(\"log\")" || throw_error "Ident(\"log\")"