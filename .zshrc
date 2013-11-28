export ZSH=$HOME/.oh-my-zsh
export ECLIPSE_HOME=$HOME/.eclipse

if [ -d "$ZSH" ]; then
  ZSH=$HOME/.oh-my-zsh

  ZSH_THEME="mpereira"

  CASE_SENSITIVE="true"
  DISABLE_AUTO_UPDATE="true"

  plugins=(
    autojump
    command-not-found
    compleat
    cp
    debian
    docker
    extract
    gem
    git
    git-extras
    npm
    rake
    scala
    ssh-agent
    vagrant
    vi-mode
    zsh-syntax-highlighting
  )

  . $ZSH/oh-my-zsh.sh
fi

export EDITOR=$(which vim)
if [ -n "$DISPLAY" ]; then
  BROWSER=$(which firefox)
else
  BROWSER=$(which lynx)
fi

export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$ECLIPSE_HOME

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

# vi-mode stuff.
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a G end-of-buffer-or-history
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# 10ms delay to normal mode.
KEYTIMEOUT=1

[[ -s $HOME/.aliases ]]                       && . $HOME/.aliases
[[ -s $HOME/.functions ]]                     && . $HOME/.functions
[[ -s $HOME/.rvm/scripts/rvm ]]               && . $HOME/.rvm/scripts/rvm
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator

which vault > /dev/null && . "$(vault --initpath)"
