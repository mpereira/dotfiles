setxkbmap us -variant altgr-intl
setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option ctrl:nocaps

exec ck-launch-session dbus-launch openbox-session
