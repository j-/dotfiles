#!/bin/bash

if ! [ -f 'scripts/init.sh' ]; then
	echo 'Please run from dotfiles directory';
	test "${SHLVL}" == "1" && return || exit 0;
fi

rm -f "$HOME/.bashrc"       && ln -s "$PWD/.bashrc"       "$HOME/.bashrc"
rm -f "$HOME/.bash_profile" && ln -s "$PWD/.bash_profile" "$HOME/.bash_profile"
rm -f "$HOME/.bash_aliases" && ln -s "$PWD/.bash_aliases" "$HOME/.bash_aliases"

# move bin/ into PATH
mkdir -p ~/.path
rm -rf ~/.path/dotfiles_bin
ln -s "$PWD/bin" "$HOME/.path/dotfiles_bin"

source ~/.bashrc