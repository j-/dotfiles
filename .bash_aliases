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
alias ls='ls --color=auto';
alias ll='ls';

# git misspellings
alias gti='git';
alias got='git';