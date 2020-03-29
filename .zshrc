eval "$(starship init zsh)"

setopt IGNOREEOF
export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

autoload -Uz compinit
compinit

setopt share_history

setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt correct

alias cat='bat'
alias ls='exa'
alias ll='exa -la'
alias grep='rg'
alias hex='hexyl'
alias prs='procs'
alias start='docker-compose -f ~/dotfiles/docker-compose.yml up -d'
alias start build='docker-compose -f ~/dotfiles/docker-compose.yml up --build -d'