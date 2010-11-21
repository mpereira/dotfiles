export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="murilo"

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

bindkey -v

[[ -s "$HOME/.alias" ]] && . "$HOME/.alias"
[[ -s "$HOME/.functions" ]] && . "$HOME/.functions"
