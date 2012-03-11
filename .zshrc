# TODO: Ditch oh-my-zsh.

export ZSH="$HOME/.oh-my-zsh"
if [ -d "$ZSH" ]; then
  export ZSH_THEME="mpereira"
  plugins=(compleat git gem rails vi-mode)
  [[ -s "$ZSH/oh-my-zsh.sh" ]] && . "$ZSH/oh-my-zsh.sh"
fi

export EDITOR='mvim -v'
if [ -n "$DISPLAY" ]; then
  BROWSER=firefox
else
  BROWSER=lynx
fi

# History.
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

unsetopt CLOBBER

[[ -s "$HOME/.aliases" ]] && . "$HOME/.aliases"
[[ -s "$HOME/.functions" ]] && . "$HOME/.functions"
