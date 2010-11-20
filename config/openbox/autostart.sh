setxkbmap us -variant altgr-intl &> /dev/null &
setxkbmap -option terminate:ctrl_alt_bksp &> /dev/null &

sleep 1

{
  feh --bg-scale $HOME/.wallpaper &
  pypanel &
  conky &
} &> /dev/null &
