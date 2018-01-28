#!/bin/bash

# Configure a new system

# Ensure all paths are relative to this script
HERE=$(dirname "${BASH_SOURCE}")

# Copy dotfiles from repo to ~
"${HERE}/copy-files.sh" "${HERE}/../src" "${HOME}"

# Ensure bin dir exists
mkdir -p "${HOME}/bin"

# Copy scripts from repo to ~/bin
"${HERE}/copy-files.sh" "${HERE}/../src/bin" "${HOME}/bin"

echo 'Finished'
echo 'Run `. ~/.bash_profile` to load profile now'
