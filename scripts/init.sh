#!/bin/bash

if ! [ -f 'scripts/init.sh' ]; then
	echo 'Please run from dotfiles directory';
	test "${SHLVL}" == "1" && return || exit 0;
fi

# prompt user for name and email address
if [ -z "$GLOBAL_USERNAME" ]; then
	read -ep "Version control user name: " username;
	export GLOBAL_USERNAME="$username"
fi;
if [ -z "$GLOBAL_USEREMAIL" ]; then
	read -ep "Version control email: " useremail;
	export GLOBAL_USEREMAIL="$useremail"
fi;

TOCOPY=(.bashrc .bash_profile .bash_aliases .gitconfig);
for FILE in "${TOCOPY[@]}"; do
	rm -f "$HOME/$FILE"
	ln -s "$PWD/$FILE" "$HOME/$FILE"
done

# configure git
if which git > /dev/null; then
	git config --global user.name "$GLOBAL_USERNAME"
	git config --global user.email "$GLOBAL_USEREMAIL"
fi;

# move bin/ into PATH
mkdir -p ~/.path
rm -rf ~/.path/dotfiles_bin
ln -s "$PWD/bin" "$HOME/.path/dotfiles_bin"

source ~/.bashrc