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

bindkey -v
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

bindkey '^L' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^[[23~' beginning-of-line # cat -v
bindkey '^[[24~' end-of-line
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward # ctrl+u, ctrl+a, ctrl+e
bindkey '^Xe' edit-command-line

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

export FZF_DEFAULT_OPTS="--height=96% --style=full --color='border:#27a1b9,scrollbar:#27a1b9,pointer:#27a1b9,bg+:#002244,marker:#00cccc,prompt:#00cccc' --layout=reverse"

ffh() {
  local cmd=$(history 0 | tac | fzf | sed 's/^[ 0-9]\+//') || return 0
  if [[ -n "$cmd" ]]; then 
    BUFFER+="$cmd"
    CURSOR=$#BUFFER
  fi
  zle redisplay
}
zle -N ffh
bindkey '^Fh' ffh
ffd() {
  local dir="$(fd . -H --exclude .git --no-ignore -t d "/" | fzf -m --preview='tree -C {}')" || return 0
  if [[ -n "$dir" ]]; then
    BUFFER+=" ${dir//$'\n'/ }"
  fi
  zle redisplay
}
zle -N ffd
bindkey '^Fd' ffd
fff() {
  local filename=$(fd . -H --exclude .git --no-ignore -t f | fzf -m --preview-window=67% --preview="
  if [[ -n {} ]]; then
    f=\$(file -b {})
    if [[ \"\$f\" == *\" image\"* ]]; then
      cols=\$((\$COLUMNS / 3 * 2 - 3))
      chafa -f symbols --symbols=all --colors=full -s \"\${cols}x44\" {} 2>/dev/null
    elif [[ \"\$f\" == *\" text\"* ]]; then
      bat --style=numbers --color=always {}
    else
      echo \"\$f\"
    fi
  fi")
  if [ -n "$filename" ]; then 
    BUFFER+=" ${filename//$'\n'/ }"
  fi
  zle redisplay
}
zle -N fff
bindkey '^Ff' fff
