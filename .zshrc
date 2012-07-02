export ZSH=$HOME/.oh-my-zsh

if [ -d "$ZSH" ]; then
  # Path to your oh-my-zsh configuration.
  ZSH=$HOME/.oh-my-zsh

  ZSH_THEME="robbyrussell"

  # Set to this to use case-sensitive completion
  # CASE_SENSITIVE="true"

  # Comment this out to disable weekly auto-update checks
  DISABLE_AUTO_UPDATE="true"

  # Uncomment following line if you want to disable colors in ls
  # DISABLE_LS_COLORS="true"

  # Uncomment following line if you want to disable autosetting terminal title.
  # DISABLE_AUTO_TITLE="true"

  # Uncomment following line if you want red dots to be displayed while waiting for completion
  # COMPLETION_WAITING_DOTS="true"

  plugins=(autojump cap compleat extract gem git history-substring-search jake knife lol npm nyan rake redis-cli sprunge ssh-agent vagrant vi-mode)

  . $ZSH/oh-my-zsh.sh
fi

export EDITOR="$(which mvim) -v"
if [ -n "$DISPLAY" ]; then
  BROWSER=$(which firefox)
else
  BROWSER=$(which lynx)
fi

export PATH=$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/sbin:$PATH:/usr/local/bin:$HOME/bin

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History.
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

unsetopt CLOBBER

# Don't show the current directory as "~rvm_rvmrc_cwd".
unsetopt auto_name_dirs

# Incremental backwards search for vi-mode.
bindkey -M vicmd '?' history-incremental-search-backward

[[ -s $HOME/.aliases ]]                       && . $HOME/.aliases
[[ -s $HOME/.functions ]]                     && . $HOME/.functions
[[ -s $HOME/.rvm/scripts/rvm ]]               && . $HOME/.rvm/scripts/rvm
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator
