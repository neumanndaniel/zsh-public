#!/bin/bash

set -e

if [[ $1 == "cloudshell" ]]; then
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Install oh-my-zsh and Powerlevel10k theme..."
    export CHSH="no"
    export RUNZSH="no"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Copy .zshrc into $HOME folder..."
    cp ./AzureCloudShell/.zshrc $HOME/.zshrc
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Copy .p10k.zsh into $HOME folder..."
    cp ./AzureCloudShell/.p10k.zsh $HOME/.p10k.zsh
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup .bashrc and copy .bashrc into $HOME folder..."
    mv $HOME/.bashrc $HOME/.bashrc_backup
    cp ./AzureCloudShell/.bashrc $HOME/.bashrc
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Copy .exrc into $HOME folder..."
    cp ./global/.exrc $HOME/.exrc
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Install zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Install zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Install and configure kubectx and kubens..."
    git clone https://github.com/ahmetb/kubectx.git $HOME/temp
    mkdir $HOME/bin || true
    cp $HOME/temp/kubectx $HOME/bin/kubectx
    cp $HOME/temp/kubens $HOME/bin/kubens
    mkdir -p $HOME/.oh-my-zsh/completions || true
    chmod -R 755 $HOME/.oh-my-zsh/completions
    cp $HOME/temp/completion/kubectx.zsh $HOME/.oh-my-zsh/completions/_kubectx.zsh
    cp $HOME/temp/completion/kubens.zsh $HOME/.oh-my-zsh/completions/_kubens.zsh
    rm -rf $HOME/temp
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Install and initialize krew..."
    (
      set -x; cd "$(mktemp -d)" &&
      curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
      tar zxvf krew.tar.gz &&
      KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
      "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
      "$KREW" update
    )
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
    kubectl krew update
    kubectl krew list
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Done. Run >>exit<< to restart your Azure Cloud Shell session..."
fi
