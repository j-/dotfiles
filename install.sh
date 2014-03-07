DIR=$(dirname $0)
rm -f "$HOME/.bashrc"       && ln -s "$DIR/bashrc"       "$HOME/.bashrc"
rm -f "$HOME/.bash_aliases" && ln -s "$DIR/bash_aliases" "$HOME/.bash_aliases"