# start applications
conky &> /dev/null &
pypanel &> /dev/null &

# set keyboard layout to us international
setxkbmap us -variant altgr-intl &> /dev/null &

# re-enable ctrl-alt-backspace killing screen feature
setxkbmap -option terminate:ctrl_alt_bksp &> /dev/null &
