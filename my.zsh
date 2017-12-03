# Put this file in ~/.oh-my-zsh/custom and ohmyzsh will automatically process it

alias g=git
alias dp="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.RunningFor}}'"
alias dpp="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}'"

export PATH=$PATH:/opt/firefox:/opt/dex-v0.6

# nvs settings
export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"

# use latest node
nvs use latest

export PATH=$PATH:/home/avranju/bin

# added by Anaconda3 installer
export PATH="/home/avranju/anaconda3/bin:$PATH"

# Initialize fasd
eval "$(fasd --init auto)"

