#!/bin/bash

# Configure a new system

# Ensure all paths are relative to this script
cd $(dirname "${BASH_SOURCE}")

# Copy dotfiles from repo to home dir
./copy-files.sh ../src "${HOME}"
