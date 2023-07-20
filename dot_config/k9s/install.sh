#!/usr/bin/env zsh

set -e

# Installation of k9s color scheme for macOS

chezmoi cd
LOC=$(pwd)
export=LOC

if [ "$(uname)" != "Darwin" ]; then
    echo "This machine is not macOS!"
    exit 1
fi

ln -sf "${LOC}/k9s/skin.yml" "${HOME}/Library/Application Support/k9s/skin.yml"
