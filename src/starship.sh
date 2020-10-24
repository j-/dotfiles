#!/bin/sh

if [ -z "$(command -v starship)" ]; then
  echo 'Starship not detected: https://starship.rs/'
  exit 1
fi

mkdir -p ~/.config
cp -i ./starship/starship.toml ~/.config
