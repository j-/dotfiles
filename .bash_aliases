# editor
alias edit='e';

# open in file explorer
if [[ "$(uname)" == MINGW* ]]; then
	alias open='explorer';
fi;

# familiar windows commands
alias explore='open';
alias explorer='open';

# list files
alias ls='ls --almost-all --color=auto --file-type --human-readable -ov';
alias ll='ls';

# git misspellings
alias gti='git';
alias got='git';
