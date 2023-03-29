#!/bin/zsh

set -e

brew install chezmoi
pushd ../
chezmoi apply
popd
