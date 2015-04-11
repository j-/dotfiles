#!/bin/bash

if ! [ -f 'scripts/init.sh' ]; then
	echo 'Please run from dotfiles directory';
	test "${SHLVL}" == "1" && return || exit 0;
fi

TOCOPY=(.bashrc .bash_profile .bash_aliases);
for FILE in "${TOCOPY[@]}"; do
	rm -f "$HOME/$FILE"
	ln -s "$PWD/$FILE" "$HOME/$FILE"
done

# move bin/ into PATH
mkdir -p ~/.path
rm -rf ~/.path/dotfiles_bin
ln -s "$PWD/bin" "$HOME/.path/dotfiles_bin"

source ~/.bashrc