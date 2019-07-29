export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

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
    kube-ps1
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Autocomplete Azure CLI
autoload -U +X bashcompinit && bashcompinit
source /etc/bash_completion.d/azure-cli

export PATH=$PATH:$HOME/.linkerd2/bin:/usr/local/go/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export GOPATH="$HOME/go"
PROMPT=$PROMPT'$(kube_ps1) '
kubeoff -g
