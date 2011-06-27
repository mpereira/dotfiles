[[ -s "$HOME/.wallpaper" ]] && feh --bg-scale $HOME/.wallpaper &> /dev/null &

sleep 0.5 && (pypanel) &
sleep 0.5 && (conky) &
sleep 0.5 && (unclutter -i 3 -noevents) &
sleep 0.5 && (thunar --daemon) &
sleep 0.5 && (pytyle) &
sleep 0.5 && (dropboxd) &
sleep 0.5 && (urxvtd -q -o -f) &
sleep 0.5 && (cd /opt/gmote/ && ./GmoteServer.sh) &
