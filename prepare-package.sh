#!/bin/bash

cd ..
git clone https://github.com/swiftwasm/swiftwasm-package-sdk.git
mkdir swiftwasm-package-sdk/prebuilt
cd swiftwasm-package-sdk/prebuilt
wget http://releases.llvm.org/9.0.0/clang+llvm-9.0.0-x86_64-darwin-apple.tar.xz
cp ../../icu.tar.xz icu4c-wasi.tar.xz
cp ../../wasi-sdk.tar.gz wasi-sdk-prebuilt-linux.tar.gz
cd ../../swift