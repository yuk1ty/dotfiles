eval "$(starship init zsh)"
eval "$(jenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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
alias gl='tig'
alias start='docker-compose -f ~/dotfiles/docker-compose.yml up -d'
alias awsc='ssh $(grep -w Host ~/.ssh/config | awk '\''{print $2}'\'' | peco)'
alias saml='saml2aws login -a conv-dev'

PATH=$PATH:/opt/riscv/bin
PATH="/usr/local/opt/llvm@10/bin:$PATH"
PATH="$HOME/.cabal/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# Checkout branches beglong to pull requests.
function peco-checkout-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N c-pr peco-checkout-pull-request

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/a14926/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/a14926/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh
# Wasmer
export WASMER_DIR="/Users/a14926/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
