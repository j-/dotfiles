#!/bin/sh

mkdir -p "$APPDATA/Code/User"
find ./vscode \
  -mindepth 1 \
  -maxdepth 1 \
  -type f \
  -exec cp -i {} "$APPDATA/Code/User" \;
