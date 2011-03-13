setxkbmap us -variant altgr-intl
setxkbmap -option terminate:ctrl_alt_bksp
xmodmap $HOME/.Xmodmap

sleep 0.5

[[ -s "$HOME/.wallpaper" ]] && feh --bg-scale $HOME/.wallpaper &> /dev/null &

{
  pypanel &
  sleep 0.5
  conky &
  sleep 0.5
  unclutter &
  sleep 0.5
  thunar --daemon &
  sleep 0.5
  dropboxd &
  sleep 0.5
  pytyle &
} &> /dev/null &
