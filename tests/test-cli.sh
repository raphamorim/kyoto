#!/bin/sh

echo $SHELL

contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

throw_error() {
	echo "\n(!) Kyoto CLI test error: \n • expected $1"
	exit 1;	
}

CLI=$(./target/release/kyoto ./examples/sum.kto)

contains $CLI "Operator(\".\")" || throw_error "Operator(\".\")"
contains $CLI "Ident(\"saum\")" || throw_error "Ident(\"sum\")"
contains $CLI "Ident(\"log\")" || throw_error "Ident(\"log\")"