export PATH=$PATH:/usr/local/bin
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

alias mplayer="/Applications/mplayer2.app/Contents/MacOS/mplayer-bin"
# Don't show the current directory as "~rvm_rvmrc_cwd".
unsetopt auto_name_dirs

export PATH=/usr/local/sbin:$PATH

[[ -s $HOME/.rvm/scripts/rvm ]] && . $HOME/.rvm/scripts/rvm
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator
