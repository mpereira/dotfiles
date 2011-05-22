export ZSH="$HOME/.oh-my-zsh"
if [ -d "$ZSH" ]; then
  export ZSH_THEME="mpereira"
  plugins=(compleat git gem rails vi-mode)
  [[ -s "$ZSH/oh-my-zsh.sh" ]] && . "$ZSH/oh-my-zsh.sh"
fi

export EDITOR=vim
if [ -n "$DISPLAY" ]; then
  BROWSER=firefox
else
  BROWSER=lynx
fi

setopt histignoredups
setopt histignorespace
setopt noclobber
setopt share_history

[[ -s "$HOME/.aliases" ]] && . "$HOME/.aliases"
[[ -s "$HOME/.functions" ]] && . "$HOME/.functions"
