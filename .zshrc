# maybe drop this
fpath+=~/.zsh/zsh-completions/src
# The following lines were added by compinstall

zstyle ':completion:*' list-colors ''
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
PS1='%F{cyan}[%n %F{magenta}%~%f%F{cyan}] '

HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_reduce_blanks

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey '^L' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^[[23~' beginning-of-line # cat -v
bindkey '^[[24~' end-of-line
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word

zmodload zsh/complist

zstyle ':completion:*' menu select=1
bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^L' vi-forward-char

alias ls='ls --color=auto -p'
alias grep='grep --color=auto'

export EDITOR=nvim
export SUDO_EDITOR=nvim
alias vim=nvim
