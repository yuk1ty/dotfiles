#!/usr/bin/env zsh

set -e

# Installation of k9s color scheme for macOS

if [ "$(uname)" != "Darwin" ]; then
    echo "This machine is not macOS!"
    exit 1
fi

ln -sf "${HOME}/.config/k9s/skin.yml" "${HOME}/Library/Application Support/k9s/skin.yml"
