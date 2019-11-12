#/bin/bash

sudo apt update
sudo apt install \
  git ninja-build clang python \
  uuid-dev libicu-dev icu-devtools libbsd-dev \
  libedit-dev libxml2-dev libsqlite3-dev swig \
  libpython-dev libncurses5-dev pkg-config \
  libblocksruntime-dev libcurl4-openssl-dev \
  systemtap-sdt-dev tzdata rsync

export current_sha=`git rev-parse HEAD`
./utils/update-checkout --clone --scheme wasm
git checkout $current_sha
export sourcedir=$PWD/..
cd $sourcedir

wget -O install_cmake.sh "https://github.com/Kitware/CMake/releases/download/v3.15.3/cmake-3.15.3-Linux-x86_64.sh"
chmod +x install_cmake.sh
sudo mkdir -p /opt/cmake
sudo ./install_cmake.sh --skip-license --prefix=/opt/cmake
sudo ln -sf /opt/cmake/bin/* /usr/local/bin
cmake --version

wget -O wasi-sdk.tar.gz https://github.com/swiftwasm/wasi-sdk/releases/download/20190421.6/wasi-sdk-3.19gefb17cb478f9.m-linux.tar.gz
tar xfz wasi-sdk.tar.gz
mv wasi-sdk-3.19gefb17cb478f9+m/opt/wasi-sdk ./wasi-sdk

wget -O icu.tar.xz "https://github.com/swiftwasm/icu4c-wasi/releases/download/20190421.3/icu4c-wasi.tar.xz"
tar xf icu.tar.xz

cd swift
utils/build-script --release --wasm --verbose \
  --skip-build-benchmarks \
  --extra-cmake-options=" \
    -DSWIFT_SDKS='WASM;LINUX' \
    -DSWIFT_BUILD_SOURCEKIT=FALSE \
    -DSWIFT_ENABLE_SOURCEKIT_TESTS=FALSE \
    -DCMAKE_AR='$sourcedir/wasi-sdk/bin/llvm-ar' \
    -DCMAKE_RANLIB='$sourcedir/wasi-sdk/bin/llvm-ranlib' \
  " \
  --build-stdlib-deployment-targets "wasm-wasm32" \
  --build-swift-static-stdlib \
  --install-destdir="$sourcedir/install" \
  --install-prefix="/opt/swiftwasm-sdk" \
  --install-swift \
  --installable-package="$sourcedir/swiftwasm.tar.gz" \
  --llvm-targets-to-build "X86;WebAssembly" \
  --stdlib-deployment-targets "wasm-wasm32" \
  --wasm-icu-data "todo-icu-data" \
  --wasm-icu-i18n "$sourcedir/icu_out/lib" \
  --wasm-icu-i18n-include "$sourcedir/icu_out/include" \
  --wasm-icu-uc "$sourcedir/icu_out/lib" \
  --wasm-icu-uc-include "$sourcedir/icu_out/include" \
  --wasm-wasi-sdk "$sourcedir/wasi-sdk"
