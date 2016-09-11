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
    docker
    extract
    gem
    git
    git-extras
    zsh-syntax-highlighting # needs to load before history-substring-search.
    history-substring-search
    npm
    rake
    scala
    ssh-agent
    vagrant
    vi-mode
  )

  if [ -f /etc/lsb-release ]; then
    plugins+=debian
  fi

  . $ZSH/oh-my-zsh.sh
fi

# Sonian stuff.
export OPSCODE_USER=sonian_devs
export SONIAN_USER=murilo
export PATH=$PATH:$HOME/sonian/sonian-chef/bin
source ~/sonian/family-jewels/archiva.sh

export EDITOR="$(which mvim) -v"
if [ -n "$DISPLAY" ]; then
  BROWSER=$(which firefox)
else
  BROWSER=$(which lynx)
fi

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$ECLIPSE_HOME
export PATH=$PATH:$HOME/Library/Haskell/bin
export PATH=$PATH:/usr/local/Cellar/vimpc/HEAD/bin

# https://momentum.spindance.com/2015/08/problems-ruby-openssl-mac-os-x-10-10/
export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cacert.pem

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

# Zsh's history-beginning-search-backward is very close to Vim's C-x C-l
history-beginning-search-backward-then-append() {
  zle history-beginning-search-backward
  zle vi-add-eol
}
zle -N history-beginning-search-backward-then-append

# Delete all characters between a pair of characters. Mimics vim's "di" text object functionality
function delete-in {
  # Create locally-scoped variables we'll need
  local CHAR LCHAR RCHAR LSEARCH RSEARCH COUNT
  # Read the character to indicate which text object we're deleting
  read -k CHAR
  if [ "$CHAR" = "w" ]
  then
    # diw, delete the word
    # find the beginning of the word under the cursor
    zle vi-backward-word
    # set the left side of the delete region at this point
    LSEARCH=$CURSOR
    # find the end of the word under the cursor
    zle vi-forward-word
    # set the right side of the delete region at this point
    RSEARCH=$CURSOR
    # Set the BUFFER to everything except the word we are removing
    RBUFFER="$BUFFER[$RSEARCH+1,${#BUFFER}]"
    LBUFFER="$LBUFFER[1,$LSEARCH]"
    return
    # diw was unique. For everything else, we just have to define the
    # characters to the left and right of the cursor to be removed
  elif [ "$CHAR" = "(" ] || [ "$CHAR" = ")" ] || [ "$CHAR" = "b" ]
  then
    # di), delete inside of a pair of parenthesis
    LCHAR="("
    RCHAR=")"
  elif [ "$CHAR" = "[" ] || [ "$CHAR" = "]" ]
  then
    # di], delete inside of a pair of square brackets
    LCHAR="["
    RCHAR="]"
  elif [ $CHAR = "{" ] || [ $CHAR = "}" ] || [ "$CHAR" = "B" ]
  then
    # di}, delete inside of a pair of braces
    LCHAR="{"
    RCHAR="}"
  else
    # The character entered does not have a special definition.
    # Simply find the first instance to the left and right of the cursor.
    LCHAR="$CHAR"
    RCHAR="$CHAR"
  fi
  # Find the first instance of LCHAR to the left of the cursor and the
  # first instance of RCHAR to the right of the cursor, and remove everything in between.
  # Begin the search for the left-sided character directly the left of the cursor
  LSEARCH=${#LBUFFER}
  # Keep going left until we find the character or hit the beginning of the buffer
  while [ "$LSEARCH" -gt 0 ] && [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
  do
    LSEARCH=$(expr $LSEARCH - 1)
  done
  # If we hit the beginning of the command line without finding the character, abort
  if [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
  then
    return
  fi
  # start the search directly to the right of the cursor
  RSEARCH=0
  # Keep going right until we find the character or hit the end of the buffer
  while [ "$RSEARCH" -lt $(expr ${#RBUFFER} + 1 ) ] && [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
  do
    RSEARCH=$(expr $RSEARCH + 1)
  done
  # If we hit the end of the command line without finding the character, abort
  if [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
  then
    return
  fi
  # Set the BUFFER to everything except the text we are removing
  RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
  LBUFFER="$LBUFFER[1,$LSEARCH]"
}
zle -N delete-in

# Delete all characters between a pair of characters and then go to insert mode
# Mimics vim's "ci" text object functionality.
function change-in {
  zle delete-in
  zle vi-insert
}
zle -N change-in

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves. Mimics vim's "da" text object functionality
function delete-around {
  zle delete-in
  zle vi-backward-char
  zle vi-delete-char
  zle vi-delete-char
}
zle -N delete-around

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves and then go into insert mode. Mimics vim's "ca" text object functionality.
function change-around {
  zle delete-in
  zle vi-backward-char
  zle vi-delete-char
  zle vi-delete-char
  zle vi-insert
}
zle -N change-around

# https://github.com/pjg/dotfiles/blob/master/.zshrc
# # alt + arrows
# bindkey '[D' backward-word
# bindkey '[C' forward-word
# bindkey '^[[1;3D' backward-word
# bindkey '^[[1;3C' forward-word
# # ctrl + arrows
# bindkey '^[OD' backward-word
# bindkey '^[OC' forward-word
# bindkey '^[[1;5D' backward-word
# bindkey '^[[1;5C' forward-word
# # home / end
# bindkey '^[[1~' beginning-of-line
# bindkey '^[[4~' end-of-line
# # delete
# bindkey '^[[3~' delete-char
# # page up / page down
# bindkey '^[[5~' history-beginning-search-backward
# bindkey '^[[6~' history-beginning-search-forward
# # shift + tab
# bindkey '^[[Z' reverse-menu-complete
# # VI MODE KEYBINDINGS (ins mode)
# bindkey -M viins -s '^b' "←\n" # C-b move to previous directory (in history)
# bindkey -M viins -s '^f' "→\n" # C-f move to next directory (in history)
# bindkey -M viins '^k' kill-line
# bindkey -M viins '^r' history-incremental-pattern-search-backward
# bindkey -M viins '^s' history-incremental-pattern-search-forward
# bindkey -M viins '^y' yank
# bindkey -M viins '^w' backward-kill-word
# bindkey -M viins '^u' backward-kill-line
# bindkey -M viins '^h' backward-delete-char
# bindkey -M viins '^?' backward-delete-char
# bindkey -M viins '^_' undo
# bindkey -M viins '^x^l' history-beginning-search-backward-then-append
# bindkey -M viins '^x^r' redisplay
# bindkey -M viins '\eOH' beginning-of-line # Home
# bindkey -M viins '\eOF' end-of-line # End
# bindkey -M viins '\e[2~' overwrite-mode # Insert
# # VI MODE KEYBINDINGS (cmd mode)
# bindkey -M vicmd 'ca' change-around
# bindkey -M vicmd 'ci' change-in
# bindkey -M vicmd 'da' delete-around
# bindkey -M vicmd 'di' delete-in
# bindkey -M vicmd 'ga' what-cursor-position
# bindkey -M vicmd 'gg' beginning-of-history
# bindkey -M vicmd 'G ' end-of-history
# bindkey -M vicmd '^k' kill-line
# bindkey -M vicmd '^r' history-incremental-pattern-search-backward
# bindkey -M vicmd '^s' history-incremental-pattern-search-forward
# bindkey -M vicmd '^p' history-beginning-search-backward
# bindkey -M vicmd '^n' history-beginning-search-forward
# bindkey -M vicmd '^y' yank
# bindkey -M vicmd '^w' backward-kill-word
# bindkey -M vicmd '^u' backward-kill-line
# bindkey -M vicmd '/' vi-history-search-forward
# bindkey -M vicmd '?' vi-history-search-backward
# bindkey -M vicmd '^_' undo
# bindkey -M vicmd '\ef' forward-word # Alt-f
# bindkey -M vicmd '\eb' backward-word # Alt-b
# bindkey -M vicmd '\ed' kill-word # Alt-d
# bindkey -M vicmd '^p' history-beginning-search-backward # PageUp
# bindkey -M vicmd '^n' history-beginning-search-forward # PageDown

bindkey -M viins '^p' history-beginning-search-backward
bindkey -M viins '^n' history-beginning-search-forward
bindkey -M viins '^k' history-substring-search-up
bindkey -M viins '^j' history-substring-search-down

bindkey -M vicmd '?' history-incremental-search-backward

# vi-mode stuff.
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a G end-of-buffer-or-history
bindkey -a u undo
bindkey -a '^r' redo

# Edit command with vim.
autoload -U edit-command-line
zle -N edit-command-line
bindkey -a '^e' edit-command-line

# 10ms delay to normal mode.
KEYTIMEOUT=1

ZLE_RPROMPT_INDENT=0

# Display CPU usage stats for commands taking more than 10 seconds.
REPORTTIME=10

# Don't display RPROMPT for previously accepted lines; only display it next to
# current line.
# setopt transient_rprompt

[[ -s $HOME/.aliases ]] && . $HOME/.aliases
[[ -s $HOME/.functions ]] && . $HOME/.functions

which mux > /dev/null 2>&1 && . $HOME/.gem/ruby/*/gems/tmuxinator-*/completion/tmuxinator.zsh
which vault > /dev/null 2>&1 && . "$(vault --initpath)"
which chruby-exec > /dev/null 2>&1 && . /usr/local/opt/chruby/share/chruby/chruby.sh && chruby 2.1.3
