#!/bin/sh

# Windows
[ -d "$APPDATA/Code/User" ] && cp -i ./vscode/settings.json "$APPDATA/Code/User"

# Mac
[ -d "$HOME/Library/Application Support/Code/User" ] && cp -i ./vscode/settings.json "$HOME/Library/Application Support/Code/User"
