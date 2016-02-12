#!/bin/bash

# From bash(1) man page

# A _login shell_ is one whose first character of argument zero is a -, or one
# started with the --login option.

# An _interactive shell_ is one started without non-option arguments and without
# the -c option whose standard input and error are both connected to terminals
# (as determined by isatty(3)), or one started with the -i option. PS1 is set
# and $- includes i if bash is interactive, allowing a shell script or a startup
# file to test this state.

# When an interactive shell that is not a login shell is started, bash reads and
# executes commands from ~/.bashrc, if that file exists. This may be inhibited
# by using the --norc option. The --rcfile file option will force bash to read
# and execute commands from file instead of ~/.bashrc.
