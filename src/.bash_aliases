#!/bin/bash

# editor
alias edit='e';

# familiar windows commands
alias explore='open';
alias explorer='open';

# list files
alias ls='ls --almost-all --color=auto --file-type --human-readable -ov';
alias ll='ls';

# git misspellings
alias gti='git';
alias got='git';

# be polite
alias please='sudo $(fc -ln -1)';

# quiet
alias reset='reset -Q';

# changing directories
alias -- -='cd -'
alias ..='cd ..'
alias ~='cd ~'
