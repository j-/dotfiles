#!/bin/sh

mkdir -p ~/.config
find ./starship \
  -mindepth 1 \
  -maxdepth 1 \
  -type f \
  -exec cp -i {} ~/.config \;
