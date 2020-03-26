#!/usr/bin/env bash

brew update
brew upgrade
brew cask upgrade

# platform
brew cask install slack
brew cask install docker
brew install docker-compose

# commands
brew install bat
brew install exa
brew install hexyl
brew install fd
brew install ripgrep
brew install procs

# mac tools
brew cask install alfred
brew cask install iterm2
brew cask install ngrok
brew cask install visual-studio-code
brew cask install adobe-creative-cloud
brew cask install caffeine
brew cask install intellij-idea
brew cask install clion
brew cask install goland
brew cask install datagrip

# development tools
brew install make
brew install bazel
brew install gcc
brew install ansible
brew install jq

# kubernetes
brew install kubernetes-cli
brwe install kubesec

# languages
brew install jenv
brew install go

# aws
brew install aws-iam-authenticator

# prompt
brew install starship

# others
brew install openssh
brew cask install chromium
brew cask install firefox
brew cask install firefoxnightly
brew cask install karabiner-elements

brew cleanup