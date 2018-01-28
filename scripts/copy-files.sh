#!/bin/bash

if [[ "${#}" = 0 ]]; then
  echo "Usage: ${0} SOURCE DEST" >&2
  exit 1
fi

# Find all files (-type f) in dotfiles directory
# Use -mindepth to exclude the directory itself
# Copy them into the home directory (-i for safety)

find "${1}" \
  -mindepth 1 \
  -type f \
  -exec cp -i {} "${2}" \;
