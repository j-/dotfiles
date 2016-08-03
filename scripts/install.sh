#!/bin/bash

# Configure a new system

# Ensure all paths are relative to this script
cd $(dirname "${0}")

# Copy dotfiles from repo to home dir
./copy-files.sh ../src "${HOME}"

echo 'Finished'
echo 'Run `. ~/.bash_profile` to load profile now'
