# Source unique env if available
if [ -e ~/env.sh ]; then
    source ~/env.sh
fi

# Source aliases
source ~/.aliases

# Use vscode as default editor
EDITOR_OLD="$EDITOR"
export EDITOR="code -w"

# Git Tings
autoload -Uz compinit && compinit # git autocompletion

################
# Prompt Setup #
################
# User Prompt and Color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Output git branch for current directory
function parse_git_branch() {
    out=$(git symbolic-ref --short HEAD 2> /dev/null | sed -n -e 's/\(.*\)/ \(\1\)/p')
    echo ${PC_GIT}${out}${PC_UNSET}
}

function host_sub() {
    [[ "$HOST" == "$LOCAL_HOSTNAME" ]] && out="local" || out="%m"
    echo ${PC_HOST}${out}${PC_UNSET}
}

P_BOLD=$'%B'
P_UNBOLD=$'%b'
PC_USR=$'%F{10}'
PC_HOST=$PC_USR
PC_DIR=$'%F{14}'
PC_GIT=$'%F{39}'
PC_UNSET=$'%f'

P_USR="${PC_USR}%n" # host will unset
P_DIR="${PC_DIR}%~${PC_UNSET}"
setopt PROMPT_SUBST
PROMPT='${P_BOLD}${P_USR}@$(host_sub):${P_DIR}$(parse_git_branch)${P_UNBOLD}%# '

# Go Dev Env Settings
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="$PATH:${GOPATH}/src"

# Docker + Colima Container Setup
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
