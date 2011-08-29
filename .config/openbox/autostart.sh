[[ -s "$HOME/.wallpaper" ]] && feh --bg-scale $HOME/.wallpaper &> /dev/null &

(pypanel &)
(conky &)
(unclutter -idle 3 -noevents &)
(thunar --daemon &)
(pytyle &)
(dropboxd &)
(urxvtd -q -o -f &)
(yeahconsole &)
(cd /opt/gmote/ && ./GmoteServer.sh &)
