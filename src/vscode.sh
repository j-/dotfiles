#!/bin/sh

if [ -z "$(command -v code)" ]; then
  echo 'VS Code not detected: https://code.visualstudio.com/'
  exit 1
fi

# Windows
[ -n "$APPDATA" ] && \
[ -d "$APPDATA/Code/User" ] && \
cp -i ./vscode/settings.json "$APPDATA/Code/User"

# Mac
[ -d "$HOME/Library/Application Support/Code/User" ] && \
cp -i ./vscode/settings.json "$HOME/Library/Application Support/Code/User"
