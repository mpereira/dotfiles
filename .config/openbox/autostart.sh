[[ -s "$HOME/.wallpaper" ]] && feh --bg-scale $HOME/.wallpaper &> /dev/null &

(pidof mpd || mpd &)
(pidof mpdscribble || mpdscribble &)
(pypanel &)
(conky &)
(unclutter -keystroke -idle 2 -noevents &)
(thunar --daemon &)
(pytyle &)
(dropboxd &)
(urxvtd -q -o -f &)
(sleep 2 && yeahconsole &)
(synapse -s &)
(cd /opt/gmote/ && ./GmoteServer.sh &)
