#!/bin/sh


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
    'list'|'ls') echo "${PATH}" | tr ':' $'\n';;
    # Print inputs in PATH format
    'make') echo "${*}";;
    # High priority PATH entries
    'prepend'|'add') PATH="${*}:${PATH}";;
    # Low priority PATH entries
    'append') PATH="${PATH}:${*}";;
    # Remove unwanted entries
    'remove'|'rm')
      IFS=$'\n'
      PATH=$(path make $(path ls | sed -e "s:^${1}$::m"))
      ;;
    # Replace the PATH entries
    'set') PATH="${*}";;
    # Remove PATH entirely
    'clear'|'unset') unset PATH;;
    # Output usage information
    'help')
      echo -n "\
Usage:
  ${FUNCNAME} help                  Show this message
  ${FUNCNAME} export                Echo current \$PATH (default)
  ${FUNCNAME} list, ls              List all entries on new lines
  ${FUNCNAME} make PATH...          Format arguments like \$PATH
  ${FUNCNAME} prepend, add PATH...  Add entries to start of \$PATH
  ${FUNCNAME} append PATH...        Add entries to end of \$PATH
  ${FUNCNAME} remove, rm PATH       Remove entries from \$PATH
  ${FUNCNAME} set PATH...           Replace entries in \$PATH
  ${FUNCNAME} unset, clear          Remove all entries from \$PATH
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

# Edit files without blocking
edit() {
  # Default argument is current directory
  $EDITOR "${@:-.}"
}

# Make directory and cd into it
mkd() {
  mkdir -p "${1}" && cd "${1}"
}

# Git shorthand. Outputs status when given no arguments.
g() {
  git "${@:-s}"
}


 ######   #######  ##     ## ########  ##       ######## ######## ########
##    ## ##     ## ###   ### ##     ## ##       ##          ##    ##
##       ##     ## #### #### ##     ## ##       ##          ##    ##
##       ##     ## ## ### ## ########  ##       ######      ##    ######
##       ##     ## ##     ## ##        ##       ##          ##    ##
##    ## ##     ## ##     ## ##        ##       ##          ##    ##
 ######   #######  ##     ## ##        ######## ########    ##    ########


# Import git completion on linux
if [ -f /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git
fi

# Make g shortcut behave the same way git does
if [ -n "$(command -v __git_complete)" ]; then
  __git_complete g __git_main
fi

# Autocomplete hostnames for scp, sftp, ssh
if [ -e ~/.ssh/config ]; then
  complete \
    -o default \
    -o nospace \
    -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d ' ' -f2- | tr ' ' $'\n')" \
    scp sftp ssh
fi
