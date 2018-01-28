#!/bin/bash

# Configure a new system

# Ensure all paths are relative to this script
HERE=$(dirname "${BASH_SOURCE}")

# Copy dotfiles from repo to home dir
"${HERE}/copy-files.sh" "${HERE}/../src" "${HOME}"

echo 'Finished'
echo 'Run `. ~/.bash_profile` to load profile now'
