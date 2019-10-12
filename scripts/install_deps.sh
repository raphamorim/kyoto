#!/bin/bash
OS=`uname -s`

# Mac OSX
install_deps_ox() {
    brew install llvm
}

install_deps_linux() {
    bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
}

if [ "$OS" = "Linux" ]; then
    install_deps_linux
elif [ "$OS" = "Darwin" ]; then
    install_deps_ox
else
    echo "Failed to identify this OS, trying with Linux install script..."
    install_deps_linux
fi
