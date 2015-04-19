#!/bin/bash

SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ./src && pwd );
HOME_DIR=$(test ${#} -eq 0 && echo ${HOME} || echo ${1});

if [ ! -d "${HOME_DIR}" ]; then
	echo "Directory does not exist: ${HOME_DIR}";
	return 0;
fi;

# prompt user for name and email address
if [ -z "${GLOBAL_USERNAME}" ]; then
	read -ep "Version control user name: " username;
	export GLOBAL_USERNAME="${username}";
fi;
if [ -z "${GLOBAL_USEREMAIL}" ]; then
	read -ep "Version control email: " useremail;
	export GLOBAL_USEREMAIL="${useremail}";
fi;

TOCOPY=(
	.bash_aliases
	.bash_profile
	.bash_prompt
	.bashrc
	.functions
	.gitconfig
	.inputrc
);

for FILE in "${TOCOPY[@]}"; do
	rm -f "${HOME_DIR}/${FILE}";
	ln -s "${SOURCE_DIR}/${FILE}" "${HOME_DIR}/${FILE}";
done;

# ensure global include file exists
gitconfig="${HOME_DIR}/.gitconfig.local";
touch "${gitconfig}";

# configure global include file
if which git > /dev/null; then
	git config --file="${gitconfig}" user.name "${GLOBAL_USERNAME}";
	git config --file="${gitconfig}" user.email "${GLOBAL_USEREMAIL}";
fi;

# move bin/ into PATH
mkdir -p "${HOME_DIR}/.path";
rm -rf "${HOME_DIR}/.path/dotfiles_bin";
ln -s "${SOURCE_DIR}/bin" "${HOME_DIR}/.path/dotfiles_bin";

source "${HOME_DIR}/.bashrc";
