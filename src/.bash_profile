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

# Print current directory, replacing home dir with a tilde
short_pwd() {
  # If $PWD starts with $HOME, replace it with ~
  # Remove trailing slash
  echo "${PWD}/" | sed "s@^${HOME}/@~/@" | sed 's/\/$//'
}

# Read from or write to the $PATH global
path() {
  local COMMAND
  COMMAND="${1}"
  shift
  local IFS
  IFS=':'
  case $COMMAND in
    # Output PATH as-is
    ''|'export') echo "${PATH}";;
    # List all PATH entries on new lines
    'list') echo "${PATH}" | tr ':' $'\n';;
    # High priority PATH entries
    'prepend') PATH="${@}:${PATH}";;
    # Low priority PATH entries
    'append') PATH="${PATH}:${@}";;
    # Replace the PATH entries
    'set') PATH="${@}";;
    # Output usage information
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
    # Print help text and error out
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
  # Update shell title to match PWD
  set_terminal_title "$(short_pwd)"
}

# Edit files without blocking
edit() {
  # Default argument is current directory
  $EDITOR "${@:-.}"
}

# Add arguments to .gitignore, each on a new line
git_ignore() {
  local IFS
  IFS=$'\n'
  echo "${*}" >> .gitignore
}

# Log all commits since last working day
git_standup() {
  local CURRENT_USER
  CURRENT_USER="$(git config user.name)"
  local SINCE
  SINCE="$(test "$(date +%u)" -eq 1 && echo 'last friday' || echo 'yesterday')"
  # Log all commits made by the current user since yesterday (or last Friday if
  # today is Monday). Checks all branches, not just the current one. Also
  # accepts additional arguments (like `--until=midnight`). Do not quote the
  # argument expansion or git will expect additional parameters.
  git log \
    --author="${CURRENT_USER}" \
    --since="${SINCE}" \
    --all \
    ${*}
}

# System might not have dig installed (i.e. Windows)
# List of services: http://unix.stackexchange.com/a/128088
get_public_ip() {
  curl -s http://whatismyip.akamai.com/
}

# Make directory and cd into it
mkd() {
  mkdir -p "${1}" && cd "${1}"
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
