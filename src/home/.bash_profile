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


# Git convenience
alias add='git add'
alias add.='git add .'
alias good='git bisect good'
alias bad='git bisect bad'
alias abort='git_abort_continue abort'
alias continue='git_abort_continue continue'

# Quiet reset
alias reset='reset -Q'

# List files
alias ls='ls --almost-all --color=auto --file-type --human-readable -ov'

# Be polite
alias please='sudo $(fc -ln -1)'
alias thanks='sudo -k'

# From https://github.com/modernish/modernish#legibility-aliases
alias not='! '              # more legible synonym for '!'
alias so='[ "$?" -eq 0 ]'   # test preceding command's success with
                            # 'if so;' or 'if not so;'


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

# See https://github.com/awalGarg/curl-tap-sh
tap() {
  f="$(mktemp)"
  cat > "$f"
  $EDITOR "$f" > /dev/tty
  ee="$?"
  if [ "$ee" == "0" ]; then
    cat "$f"
    rm "$f"
  else
    rm "$f"
    echo "Editor exited with code $ee, and not success exit code" 1>&2
    exit "$ee"
  fi
}

# System might not have dig installed (i.e. Windows)
# List of services: http://unix.stackexchange.com/a/128088
get_public_ip() {
  curl -s http://whatismyip.akamai.com/
}

# Open the given path (or current dir) in a file explorer
open() {
  case "$(uname)" in
    # Convert unix path to Windows style, open in explorer
    'MINGW'*|'CYGWIN'*) explorer "$(cygpath --windows "${1:-.}")" || :;;
    'Linux') xdg-open ${*};;
    'Darwin'|*) /usr/bin/env open ${*};;
  esac
}

# Repeat $1, $2 number of times
repeat() {
  local PATTERN
  PATTERN="${1}"
  local TIMES
  TIMES="${2:-1}"
  while [ $TIMES -gt 0 ]; do
    echo -n "${PATTERN}"
    let TIMES-=1
  done
}

# Makes JavaScript development a bit easier
run() {
  npm run "${1:-start}" -s -- "${@:2}"
}


 ######   ##        #######  ########     ###    ##        ######
##    ##  ##       ##     ## ##     ##   ## ##   ##       ##    ##
##        ##       ##     ## ##     ##  ##   ##  ##       ##
##   #### ##       ##     ## ########  ##     ## ##        ######
##    ##  ##       ##     ## ##     ## ######### ##             ##
##    ##  ##       ##     ## ##     ## ##     ## ##       ##    ##
 ######   ########  #######  ########  ##     ## ########  ######


VISUAL="${EDITOR}"


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


#### ##    ## #### ########
 ##  ###   ##  ##     ##
 ##  ####  ##  ##     ##
 ##  ## ## ##  ##     ##
 ##  ##  ####  ##     ##
 ##  ##   ###  ##     ##
#### ##    ## ####    ##


# Start SSH Agent if it's not already running
if [ -z "${SSH_AGENT_PID}" ]; then
  eval "$(ssh-agent -s)" > /dev/null

  # Kill SSH Agent when terminal shuts down
  trap "kill ${SSH_AGENT_PID}; exit" INT TERM
fi

# Source local profile if it exists
if [ -e ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi


##        #######   ######     ###    ##
##       ##     ## ##    ##   ## ##   ##
##       ##     ## ##        ##   ##  ##
##       ##     ## ##       ##     ## ##
##       ##     ## ##       ######### ##
##       ##     ## ##    ## ##     ## ##
########  #######   ######  ##     ## ########


# Local configuration for this system goes here
. ~/.profile
path add /usr/local/bin
eval "$(starship init bash)"
