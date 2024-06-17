# User Prompt and Color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
PROMPT="%B%F{10}%n@%m%f:%F{14}%~%f%b%# "

# Go Env Setup
export GOPATH=$HOME/go
export PATH=$PATH:${GOPATH}/bin

# Other Env setup
source ~/.aliases
