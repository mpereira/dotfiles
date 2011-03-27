export PATH=$PATH:/usr/local/bin

# Don't show the current directory as "~rvm_rvmrc_cwd".
unsetopt auto_name_dirs

# Disable annoying beep.
xset b off

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
