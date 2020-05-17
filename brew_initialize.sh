#!/usr/bin/env bash

update_brew() {
    echo "Start to update brew"
    brew update
    brew upgrade
    brew cask upgrade
    echo "Done!"
}

install_rust_wrap_commands() {
    # I love to use linux commands rewrite by Rust
    brew install bat
    brew install exa
    brew install hexyl
    brew install fd
    brew install ripgrep
    brew install procs
    brew tap cjbassi/ytop
    brew install ytop
}

install_mac_desktop_tools() {
    # install mac desktop apps
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
    brew cask install tableplus
    brew cask install slack
    brew cask install docker
    brew cask install chromium
    brew tap homebrew/cask-versions
    brew cask install google-chrome-canary
    brew cask install firefox
    brew cask install karabiner-elements
}

install_deveploer_tools() {
    # install developing tools
    brew install make
    brew install bazel
    brew install gcc
    brew install ansible
    brew install jq
    brew install peco
    brew install gibo
    brew install kubesec
    brew install kubernetes-cli
    brew install aws-iam-authenticator
    brew install openssh
    brew install filosottile/musl-cross/musl-cross
    brew install docker-compose
}

install_programming_languages() {
    # install programming languages
    brew install jenv
    brew install go
    brew install node
    brew install deno
    brew tap AdoptOpenJDK/openjdk
    brew cask install adoptopenjdk8
    brew cask install adoptopenjdk11
    brew cask install adoptopenjdk14
    brew cask install visualvm
    brew install sbt
    brew install pyenv
}

install_prompt_tools() {
    # install prompt tools
    brew install starship
}

after_installing() {
    brew cleanup
}

# main script
select VAR in update linuxcmd desktop developer programming_language prompt all exit
do
    if [ -z $VAR ]; then
        echo "Please input a number aside word"
        break
    fi

    if [ $VAR = update ]; then
        update_brew
        break
    elif [ $VAR = linuxcmd ]; then
        install_rust_wrap_commands
        break
    elif [ $VAR = desktop ]; then
        install_mac_desktop_tools
        break
    elif [ $VAR = developer ]; then
        install_deveploer_tools
        break
    elif [ $VAR = programming_language ]; then
        install_programming_languages
        break
    elif [ $VAR = prompt ]; then
        install_prompt_tools
        break
    elif [ $VAR = all ]; then
        update_brew
        install_rust_wrap_commands
        install_mac_desktop_tools
        install_deveploer_tools
        install_programming_languages
        install_prompt_tools
        break
    else
        echo "Unknown choice"
        break
    fi
done

after_installing
echo "Exit this shell"
