setxkbmap us -variant altgr-intl &> /dev/null &
setxkbmap -option terminate:ctrl_alt_bksp &> /dev/null &

sleep 0.5

[[ -s "$HOME/.wallpaper" ]] && feh --bg-scale $HOME/.wallpaper &> /dev/null &

{
  pypanel &
  conky &
} &> /dev/null &
