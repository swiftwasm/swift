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

install_icu() {
  ICU_URL="https://github.com/swiftwasm/icu4c-wasi/releases/download/0.5.0/icu4c-wasi.tar.xz"
  curl -L "$ICU_URL" | tar xz
  rm -rf "$BUILD_SDK_PATH/icu"
  mv icu_out "$BUILD_SDK_PATH/icu"
}

workdir=$(mktemp -d)
pushd "$workdir"

mkdir -p "$BUILD_SDK_PATH"

install_libxml2
install_icu
