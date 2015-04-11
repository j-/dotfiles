#!/bin/bash

if ! [ -f 'scripts/init.sh' ]; then
	echo 'Please run from dotfiles directory';
	test "${SHLVL}" == "1" && return || exit 0;
fi

rm -f "$HOME/.bashrc"       && ln -s "$PWD/.bashrc"       "$HOME/.bashrc"
rm -f "$HOME/.bash_profile" && ln -s "$PWD/.bash_profile" "$HOME/.bash_profile"
rm -f "$HOME/.bash_aliases" && ln -s "$PWD/.bash_aliases" "$HOME/.bash_aliases"

source ~/.bashrc