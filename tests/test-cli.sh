#!/bin/bash

throw_error() {
	echo "\n(!) Kyoto CLI test error: \n • expected $1"
	exit 1;	
}

CLI=$(./target/release/kyoto ./examples/sum.kto)

[[ $CLI == *"Operator(\".\")"* ]] && continue || throw_error "Operator(\".\")"
[[ $CLI == *"Ident(\"sum\")"* ]] && continue || throw_error "Ident(\"sum\")"
[[ $CLI == *"Ident(\"log\")"* ]] && continue || throw_error "Ident(\"log\")"
