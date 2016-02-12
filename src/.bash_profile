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
alias got='git'
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
  echo 'Command "'"${1}"'" not found'
  return 127
}

# Try and set the terminal's titlebar/tab text
set_terminal_title() {
  case "${TERM}" in
    xterm|cygwin)
      echo -ne "\e]2;${*}\a"
    ;;
    xterm-256color)
      echo -ne "\033]0;${*}\007"
    ;;
  esac
}

# List all PATH entries on new lines
path_list() {
  echo "${PATH}" |tr ':' $'\n'
}

# High priority PATH entries
path_prepend() {
  local IFS
  IFS=':'
  PATH="${*}:${PATH}"
}

# Low priority PATH entries
path_append() {
  local IFS
  IFS=':'
  PATH="${PATH}:${*}"
}

# Replace the PATH entries
path_set() {
  local IFS
  IFS=':'
  PATH="${*}"
}

# Output PATH as-is
path_export() {
  echo "${PATH}"
}

# Expose functions as a single command
path() {
  # No arguments given
  if [ "$#" = 0 ]; then
    # Print $PATH and exit
    path_export
    return
  fi

  local COMMAND
  COMMAND=$1
  shift

  case $COMMAND in
    'prepend')
      path_prepend "${@}"
    ;;
    'append')
      path_append "${@}"
    ;;
    'set')
      path_set "${@}"
    ;;
    'list')
      path_list
    ;;
    'help')
      echo -n "\
Usage:
  ${FUNCNAME} help             Show this message
  ${FUNCNAME} export           Echo current \$PATH (default)
  ${FUNCNAME} list             List all entries on new lines
  ${FUNCNAME} prepend PATH...  Add entries to start of \$PATH
  ${FUNCNAME} append PATH...   Add entries to end of \$PATH
  ${FUNCNAME} set PATH...      Replace entries in \$PATH
Example:
  ${FUNCNAME} set /usr/sbin /usr/bin /sbin /bin
  ${FUNCNAME} add ~/bin
"
    ;;
    *)
      path help >&2
      return 127
    ;;
  esac
}

# Sets prompt style. This prompt is quite simple, showing the exit status of the
# previous command, the username and hostname, and the current directory.
set_ps1() {
  # Get exit status of previous command
  EXIT="${?}"
  # Reset any existing formatting
  PS1='\e[0m'
  # New line
  PS1+='\n'
  # Print exit status
  if [ "${EXIT}" = 0 ]; then
    # Dim white
    PS1+='\e[30;1m''0''\e[0m'
  else
    # White
    PS1+="${EXIT}"
  fi
  # Space
  PS1+=' '
  # Detect type of user
  if [ "${UID}" = 0 ]; then
    # Red for root
    PS1+='\e[0;31m'
  elif sudo -n true &> /dev/null; then
    # Bright green for sudo
    PS1+='\e[1;32m'
  else
    # Green for other users
    PS1+='\e[0;32m'
  fi
  # Print username
  PS1+='\u'
  # Print @ in dim green
  PS1+='\e[32;1m''@'
  # Print hostname in green
  PS1+='\e[0;32m''\H'
  # Space
  PS1+=' '
  # Print current directory in magenta
  PS1+='\e[0;35m''\w'
  # Print $/# on new line
  PS1+='\e[0m''\n\$ '
}

# Edit files without blocking
edit() {
  # Default argument is current directory
  $EDITOR "${@:-.}"
}


 ######   ##        #######  ########     ###    ##        ######
##    ##  ##       ##     ## ##     ##   ## ##   ##       ##    ##
##        ##       ##     ## ##     ##  ##   ##  ##       ##
##   #### ##       ##     ## ########  ##     ## ##        ######
##    ##  ##       ##     ## ##     ## ######### ##             ##
##    ##  ##       ##     ## ##     ## ##     ## ##       ##    ##
 ######   ########  #######  ########  ##     ## ########  ######


# If set, the value is executed as a command prior to issuing each primary
# prompt
PROMPT_COMMAND=set_ps1

# Prioritise editors
if [ -n "$(command -v subl)" ]; then
  EDITOR='subl -aw'
elif [ -n "$(command -v nano)" ]; then
  EDITOR='nano'
fi


 ######  ##     ##  #######  ########  ########  ######
##    ## ##     ## ##     ## ##     ##    ##    ##    ##
##       ##     ## ##     ## ##     ##    ##    ##
 ######  ######### ##     ## ########     ##     ######
      ## ##     ## ##     ## ##           ##          ##
##    ## ##     ## ##     ## ##           ##    ##    ##
 ######  ##     ##  #######  ##           ##     ######


# Attempt to set all shell opts
# Ignore any failures
shopt -s \
  cdspell \
  checkwinsize \
  dirspell \
  dotglob \
  globstar \
  histappend \
  2&> /dev/null || :
