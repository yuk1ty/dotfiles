#!/usr/bin/env bash

brew update
brew upgrade

brew cask install iterm2
brew cask install alfred
brew cask install slack
brew cask install docker

# commands
brew install bat
brew install exa
brew install hexyl
brew install fd
brew install ripgrep
brew install procs

# tools
brew install make
brew install bazel
brew install gcc
brew install ansible
brew install jq

# kubernetes
brew install kubernetes-cli
brwe install kubesec

# languages
brew install go

# aws
brew install aws-iam-authenticator

# prompt
brew install starship

# others
brew install openssh

brew cleanup