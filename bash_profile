test -f $HOME/.bashrc && . $HOME/.bashrc
test -f $HOME/.profile && . $HOME/.profile

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx 
  logout
fi
