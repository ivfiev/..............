# maybe drop this
fpath+=~/.zsh/zsh-completions/src
# The following lines were added by compinstall

zstyle ':completion:*' list-colors ''
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit edit-command-line
zle -N edit-command-line

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
bindkey '^W' forward-word
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^[[23~' beginning-of-line # cat -v
bindkey '^[[24~' end-of-line
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward # ctrl+u, ctrl+a, ctrl+e
bindkey '^X^E' edit-command-line

zmodload zsh/complist

zstyle ':completion:*' menu select=1
bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^L' vi-forward-char

alias ls='ls --color=auto -p'
alias grep='grep --color=auto'
alias cp='cp -v'
alias rm='rm -v'
alias mv='mv -v'
alias oh-come-on="/home/$USER/dev/oh-come-on/bin/oh-come-on"
alias pgitp="/home/$USER/dev/pgitp/pgitp.sh"

export PATH=$PATH:$HOME/.ghcup/bin

export EDITOR=nvim
export SUDO_EDITOR=nvim
alias vim=nvim


alias _fzf="fzf --style=full --color='border:#009999,scrollbar:#006666,pointer:#009999,bg+:#002222,marker:#00aaaa,prompt:#00aaaa' --layout=reverse"

ffv() {
  local arg="${1:-d}"
  if [ "$arg" = "d" ]; then
    local dir=$(fd . -H --exclude .git --no-ignore -t d | _fzf --preview='tree -C {}') || return 0
    [ -n "$dir" ] && nvim "$dir"
  elif [ "$arg" = "f" ]; then
    local file=$(_fzf -m --preview='bat --style=numbers --color=always {}') || return 0
    [ -n "$file" ] && (echo "$file" | xargs nvim)
  fi
}
alias ffvf='ffv f'
ffh() {
  local cmd=$(history 0 | tac | _fzf | sed 's/^[ 0-9]\+//') || return 0
  [ -n $cmd ] && print -z -- $cmd
}
ffd() {
  local arg="${1:-/home/$user}"
  local dir=$(fd . -H --exclude .git --no-ignore -t d "$arg" | _fzf --preview='tree -C {}') || return 0
  [ -n $dir ] && cd $dir
}
