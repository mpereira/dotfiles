export ZSH=$HOME/.oh-my-zsh
export ECLIPSE_HOME=$HOME/.eclipse

$(boot2docker shellinit 2>&1 | grep export)

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

  if [ -f /etc/lsb-release ]; then
    plugins+=debian
  fi

  . $ZSH/oh-my-zsh.sh
fi

export EDITOR=$(which vim)
if [ -n "$DISPLAY" ]; then
  BROWSER=$(which firefox)
else
  BROWSER=$(which lynx)
fi

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$ECLIPSE_HOME
export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin
export PATH=$PATH:$HOME/Library/Haskell/bin
export PATH=$PATH:/usr/local/Cellar/vimpc/HEAD/bin

if [ "$(uname -s)" = 'Darwin' ]; then
  export PATH=$PATH:/opt/local/bin
fi

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

ZLE_RPROMPT_INDENT=0

[[ -s $HOME/.aliases ]] && . $HOME/.aliases
[[ -s $HOME/.functions ]] && . $HOME/.functions

. $HOME/.gem/ruby/*/gems/tmuxinator-*/completion/tmuxinator.zsh

which vault > /dev/null 2>&1 && . "$(vault --initpath)"
