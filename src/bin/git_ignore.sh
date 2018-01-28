#!/bin/bash

# Add arguments to .gitignore, each on a new line

project_dir="$(git rev-parse --show-toplevel 2> /dev/null)"

if [ $? != 0 ]; then
  echo 'fatal: Not a git repository'
  exit 1
fi

local IFS
IFS=$'\n'
echo "${*}" >> "${project_dir}/.gitignore"
