HISTSIZE=10000
fc -R ~/.zsh_history
cmd=$(fc -ln 1 | tac | nl | sort -u -k 2 | sort -n | cut -f 2 | wofi --show dmenu --matching fuzzy)
if [ ${#cmd} -gt 1 ]; then
  wl-copy $cmd
  kitty --hold zsh -c "sleep 0.1; ydotool key 97:1 54:1 47:1 47:0 54:0 97:0"
fi

