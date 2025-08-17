#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export HISTSIZE=2500
export HISTCONTROL=ignoredups
export PATH="$HOME/.ghcup/bin:$PATH"

# pyenv shite
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias oh-come-on='/home/fi/dev/oh-come-on/bin/oh-come-on'
# alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias code='/home/fi/vscode.sh'

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=$HOME/dothate/dotnet-sdk-9.0.300-linux-x64
export PATH=$PATH:$HOME/dothate/dotnet-sdk-9.0.300-linux-x64

