export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="murilasso"

plugins=(git rails)

[[ -s "$ZSH/oh-my-zsh.sh" ]] && . "$ZSH/oh-my-zsh.sh"

export EDITOR=vim
if [ -n "$DISPLAY" ]; then
  BROWSER=chromium
else
  BROWSER=lynx
fi

setopt histignoredups
setopt histignorespace
setopt noclobber
setopt share_history

bindkey -v

[[ -s "$HOME/.aliases" ]] && . "$HOME/.aliases"
[[ -s "$HOME/.functions" ]] && . "$HOME/.functions"
