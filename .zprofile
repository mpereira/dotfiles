export PATH=$PATH:/usr/local/bin

# Don't show the current directory as "~rvm_rvmrc_cwd".
unsetopt auto_name_dirs

[[ -s $HOME/.rvm/scripts/rvm ]] && . $HOME/.rvm/scripts/rvm
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator
