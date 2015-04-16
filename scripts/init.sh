#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd );

# prompt user for name and email address
if [ -z "$GLOBAL_USERNAME" ]; then
	read -ep "Version control user name: " username;
	export GLOBAL_USERNAME="$username";
fi;
if [ -z "$GLOBAL_USEREMAIL" ]; then
	read -ep "Version control email: " useremail;
	export GLOBAL_USEREMAIL="$useremail";
fi;

TOCOPY=(
	.bash_aliases
	.bash_profile
	.bash_prompt
	.bashrc
	.functions
	.gitconfig
);

for FILE in "${TOCOPY[@]}"; do
	rm -f "$HOME/$FILE";
	ln -s "$DIR/$FILE" "$HOME/$FILE";
done;

# ensure global include file exists
gitconfig="$HOME/.gitconfig.local";
touch "$gitconfig";

# configure global include file
if which git > /dev/null; then
	git config --file="$gitconfig" user.name "$GLOBAL_USERNAME";
	git config --file="$gitconfig" user.email "$GLOBAL_USEREMAIL";
fi;

# move bin/ into PATH
mkdir -p ~/.path;
rm -rf ~/.path/dotfiles_bin;
ln -s "$DIR/bin" "$HOME/.path/dotfiles_bin";

source ~/.bashrc;
