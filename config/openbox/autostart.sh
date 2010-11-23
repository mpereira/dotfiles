setxkbmap us -variant altgr-intl
setxkbmap -option terminate:ctrl_alt_bksp

sleep 0.5

[[ -s "$HOME/.wallpaper" ]] && feh --bg-scale $HOME/.wallpaper &> /dev/null &

{
  pypanel &
  conky &
  unclutter &
} &> /dev/null &
