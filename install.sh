#!/bin/sh

THIS=$(readlink -f "$0")
DIR=$(dirname "$THIS")

(
  cd "$DIR/src" || exit 1
  find . \
    -mindepth 1 \
    -maxdepth 1 \
    -type f \
    -exec {} \;
)
