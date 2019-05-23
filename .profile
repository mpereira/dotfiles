export PATH="$PATH:/usr/local/bin"

OPT_LOCAL_BIN="/opt/local/bin"
[ -d "${OPT_LOCAL_BIN}" ] && export PATH="${PATH}:${OPT_LOCAL_BIN}"

# Postgres.
POSTGRES_BIN="/Applications/Postgres.app/Contents/Versions/latest/bin"
[ -d "${POSTGRES_BIN}" ] && export PATH="${PATH}:${POSTGRES_BIN}"

# CMake.
export PATH="$PATH:/Applications/CMake.app/Contents/bin"

# Python.
export PATH="$PATH:$HOME/Library/Python/3.7/bin" # from `pip install --user`.
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.7/bin" # from `pip install`

# Go.
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.go/bin"
export GOPATH="$HOME/.go"

# Rust.
export PATH="$PATH:$HOME/.cargo/bin"

# MacVim.
export PATH="$PATH:/Applications/MacVim.app/Contents/bin"

# Mesosphere.
export PATH="$PATH:$HOME/mesosphere/bin"

# GNU binaries without g prefix.
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# Emacs ansi-term doesn't set locale env variables.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

for completion_script in "$(brew --prefix)"/etc/bash_completion.d/*; do
  # shellcheck source=/dev/null
  [ -f "${completion_script}" ] && . "${completion_script}"
done

[ -f .aliases ] && . .aliases
