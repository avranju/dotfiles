#!/bin/bash

# update the system
sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt install build-essential git \
         cmake libssl-dev zsh fasd curl \
         pkg-config wget -y

# install oh-my-zsh
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# add plugins to zsh
sed -i -e 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# install github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
  sudo apt update && \
  sudo apt install gh -y

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# source rust env into current shell
# shellcheck disable=SC1091
source "$HOME/.cargo/env"

# install common rust tools
cargo install bat exa fd-find ripgrep tealdeer xh starship simple-http-server
tldr --update

# append starship config to .zshrc
# shellcheck disable=SC2016
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# add a bunch of aliases and exports to oh-my-zsh custom script
cat <<'EOF' >> ~/.oh-my-zsh/custom/my.zsh
# exa aliases
alias l="exa -lah"
alias ls="exa"

# cargo aliases
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cf="cargo fmt"

alias g=git
alias k=kubectl
alias kx=kubectx
alias kns=kubens
alias cls=clear
alias pe=print-expects

# fasd config
eval "$(fasd --init auto)"

# additional paths
export PATH="$PATH:/usr/local/go/bin:/home/avranju/go/bin:/home/avranju/.local/bin"

# cmd-tunnel-server config
export CMD_TUNNEL_SERVER=http://172.24.176.1:7786
alias cx=cmd-tunnel-client
alias cxc="cmd-tunnel-client cmd.exe /C"
alias cxg="cmd-tunnel-client git"
alias cxcb="cmd-tunnel-client cargo build"
alias cxcr="cmd-tunnel-client cargo run"
alias cxct="cmd-tunnel-client cargo test"

cxrg() {
  cmd-tunnel-client rg --type c --files-with-matches "$1" | awk -F '\' '{ print $NF }' | sort
}

# helix editor needs this to know that we support truecolor in the terminal
export COLORTERM=truecolor

EOF

# setup .gitconfig
cat <<'EOF' >> ~/.gitconfig
[alias]
        s = status
        l = log
        d = diff
        r = remote
        su = submodule update --init --recursive
        b = branch
        c = checkout
        lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative --all
[user]
	name = Raj Vengalil
	email = avranju@nerdworks.dev
[credential]
	helper = cache --timeout=3600

EOF
