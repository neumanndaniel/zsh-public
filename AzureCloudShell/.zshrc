export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=powerlevel10k/powerlevel10k

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    colorize
    docker
    git
    golang
    helm
    history
    kubectl
    terraform
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.p10k.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

kubeoff() {
    typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|istioctl'
    p10k reload
}
kubeon() {
    unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
    p10k reload
}

#Autocomplete
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source /etc/bash_completion.d/azure-cli

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export GOPATH="$HOME/go"
