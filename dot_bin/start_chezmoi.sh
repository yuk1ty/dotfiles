#!/bin/zsh

set -e

pushd ~

brew install chezmoi

chezmoi init git@github.com:yuk1ty/dotfiles.git

chezmoi apply

popd
