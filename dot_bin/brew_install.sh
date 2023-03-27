#!/bin/zsh

set -e

echo "Installing brew stuffs ..."
if [ "$(uname)" != "Darwin" ]; then
    echo "This machine is not macOS!"
    exit 1
fi

brew bundle --file ../Brewfile
