# dotfiles

## Installation

    $ . scripts/init.sh

## PATH

The `~/.path` directory is used as an easy way to define paths. Any directory
(or symbolic link to a directory) inside will be added to `$PATH`.

For example, to add `~/bin` to `$PATH`:

    $ ln -s ~/bin ~/.path/bin

`$PATH` will be updated next time `.bash_profile` is sourced.
