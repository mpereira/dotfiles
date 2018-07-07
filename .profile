export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:$HOME/mesosphere/bin"
export PATH="$PATH:$HOME/Library/Python/2.7/bin"
export PATH="$PATH:$HOME/Library/Python/3.6/bin"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH="$PATH:/Applications/CMake.app/Contents/bin"
export GOPATH="$HOME/.go"

# coreutils binaries without g prefix.
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Emacs ansi-term doesn't set locale env variables.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
