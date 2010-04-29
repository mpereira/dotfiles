test -f $HOME/.bashrc && . $HOME/.bashrc
test -f $HOME/.profile && . $HOME/.profile

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx
  logout
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm";
fi
