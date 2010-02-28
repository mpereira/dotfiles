# starting applications
conky      &>/dev/null &
pypanel    &>/dev/null &
pulseaudio &>/dev/null &

# re-enable ctrl-alt-backspace killing screen feature
setxkbmap -option terminate:ctrl_alt_bksp &>/dev/null &
