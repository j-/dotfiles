#!/bin/sh

# Configure a new system

# Ensure all paths are relative to this script
HERE=$(dirname "${BASH_SOURCE}")

# Copy dotfiles from repo to ~
(cd "${HERE}" && ./copy-files.sh ../src "${HOME}")

echo 'Finished'
echo 'Run `. ~/.bash_profile` to load profile now'
