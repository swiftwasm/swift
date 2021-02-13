#!/bin/bash

set -eux

SOURCE_PATH="$( cd "$(dirname "$0")/../../../" && pwd  )"
BUILD_SDK_PATH="$SOURCE_PATH/build-sdk"

cd "$BUILD_SDK_PATH"

install_libxml2() {
  LIBXML2_URL="https://github.com/swiftwasm/libxml2-wasm/releases/download/1.0.0/libxml2-wasm32-unknown-wasi.tar.gz"
  curl -L "$LIBXML2_URL" | tar xz
  rm -rf "$BUILD_SDK_PATH/libxml2-wasm32-unknown-wasi"
  mv libxml2-wasm32-unknown-wasi "$BUILD_SDK_PATH/libxml2-wasm32-unknown-wasi"
}

workdir=$(mktemp -d)
pushd "$workdir"

mkdir -p "$BUILD_SDK_PATH"

install_libxml2

