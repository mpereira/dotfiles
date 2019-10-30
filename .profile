export PATH="$PATH:/usr/local/bin"

OPT_LOCAL_BIN="/opt/local/bin"
[ -d "${OPT_LOCAL_BIN}" ] && export PATH="${PATH}:${OPT_LOCAL_BIN}"

# Postgres.
POSTGRES_BIN="/Applications/Postgres.app/Contents/Versions/latest/bin"
[ -d "${POSTGRES_BIN}" ] && export PATH="${PATH}:${POSTGRES_BIN}"

# CMake.
export PATH="$PATH:/Applications/CMake.app/Contents/bin"

# Python 3.
latest_python3="$(ls -drv $HOME/Library/Python/3.* | head -n1)"
latest_python3_framework="$(ls -drv /Library/Frameworks/Python.framework/Versions/3.* | head -n1)"
export PATH="$PATH:${latest_python3}/bin"           # from `pip3 install --user $egg`
export PATH="$PATH:${latest_python3_framework}/bin" # from `sudo pip3 install $egg`

# LLVM.
latest_llvm="$(ls -drv /usr/local/Cellar/llvm/* | head -n1)"
export PATH="$PATH:${latest_llvm}/bin"

# Go.
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"

# Ghostscript.
export PATH="$PATH:/usr/local/Cellar/ghostscript/9.26_1/bin/"

# Rust.
export PATH="$PATH:$HOME/.cargo/bin"

# MacVim.
export PATH="$PATH:/Applications/MacVim.app/Contents/bin"

# GraalVM.
latest_graalvm_app="$(ls -drv /Applications/GraalVM-*.app | head -n1)"
export GRAALVM_HOME="${latest_graalvm_app}/Contents/Home"
export PATH="$PATH:$GRAALVM_HOME/bin"

# Mesosphere.
export PATH="$PATH:$HOME/mesosphere/bin"

# GNU binaries without g prefix.
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# gettext.
export PATH="/usr/local/opt/gettext/bin:$PATH"
# For compilers to find gettext these might need to be set:
# export LDFLAGS="-L/usr/local/opt/gettext/lib"
# export CPPFLAGS="-I/usr/local/opt/gettext/include"

# Emacs ansi-term doesn't set locale env variables.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Completion.
for completion_script in "$(brew --prefix)"/etc/bash_completion.d/*; do
  # shellcheck source=/dev/null
  [ -f "${completion_script}" ] && . "${completion_script}"
done

. /usr/local/git/contrib/completion/git-completion.bash

# Aliases.
[ -f .aliases ] && . .aliases
