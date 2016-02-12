#!/bin/bash

# From bash(1) man page

# A _login shell_ is one whose first character of argument zero is a -, or one
# started with the --login option.

# An _interactive shell_ is one started without non-option arguments and without
# the -c option whose standard input and error are both connected to terminals
# (as determined by isatty(3)), or one started with the -i option. PS1 is set
# and $- includes i if bash is interactive, allowing a shell script or a startup
# file to test this state.

# When bash is invoked as an interactive login shell, or as a non-interactive
# shell with the --login option, it first reads and executes commands from the
# file /etc/profile, if that file exists. After reading that file, it looks for
# ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads and
# executes commands from the first one that exists and is readable. The
# --noprofile option may be used when the shell is started to inhibit this
# behavior.


   ###    ##       ####    ###     ######  ########  ######
  ## ##   ##        ##    ## ##   ##    ## ##       ##    ##
 ##   ##  ##        ##   ##   ##  ##       ##       ##
##     ## ##        ##  ##     ##  ######  ######    ######
######### ##        ##  #########       ## ##             ##
##     ## ##        ##  ##     ## ##    ## ##       ##    ##
##     ## ######## #### ##     ##  ######  ########  ######


# Git misspellings
alias gti='git'
alias gto='git'
alias gut='git'
alias gt='git'

# Quiet reset
alias reset='reset -Q'

# List files
alias ls='ls --almost-all --color=auto --file-type --human-readable -ov'

# Changing directories
alias -- -='cd -'
alias ..='cd ..'
alias ~='cd ~'


######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######


# Called by bash whenever an invalid command is executed
command_not_found_handle() {
  echo 'Command "'"$1"'" not found'
  return 127
}

# Try and set the terminal's titlebar/tab text
set_terminal_title() {
  case "$TERM" in
    xterm|cygwin) echo -ne "\e]2;$*\a";;
    xterm-256color) echo -ne "\033]0;$*\007";;
  esac
}
