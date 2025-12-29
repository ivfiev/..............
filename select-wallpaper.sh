choice=$(fd . -t f "/home/$USER/Wallpapers" | awk '{print "img:"$1":text:"$1}' | wofi --show dmenu -i -M fuzzy --cache-file=/dev/null | awk -F':text:' '{print $2}')
swww img $choice --transition-type fade --resize stretch --outputs DP-1
