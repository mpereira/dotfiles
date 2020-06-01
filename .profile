find_latest () {
  find "${1}" -maxdepth 1 -iname "${2}" 2>/dev/null | sort -nr | head -1
}

# When prepending to PATH, later prepends will have higher priority.

OPT_LOCAL_BIN="/opt/local/bin"
[ -d "${OPT_LOCAL_BIN}" ] && export PATH="${OPT_LOCAL_BIN}:${PATH}"

USR_LOCAL_BIN="/usr/local/bin"
[ -d "${USR_LOCAL_BIN}" ] && export PATH="${USR_LOCAL_BIN}:${PATH}"

# Postgres.
POSTGRES_BIN="/Applications/Postgres.app/Contents/Versions/latest/bin"
[ -d "${POSTGRES_BIN}" ] && export PATH="${PATH}:${POSTGRES_BIN}"

# CMake.
export PATH="${PATH}:/Applications/CMake.app/Contents/bin"

# Emacs.
latest_emacs="$(find_latest /Applications Emacs-*.app)"
[ -d "${latest_emacs}" ] && export PATH="${latest_emacs}/Contents/MacOS/bin:${PATH}"

# Ruby.
latest_ruby="$(find_latest "${HOME}/.gem/ruby" "*")"
[ -d "${latest_ruby}" ] && export PATH="${latest_ruby}/bin:${PATH}" # from `gem install --user-install $gem``

# Python 3.
# From `sudo pip3 install` or `python3 -m pip install`.
latest_python3_framework="$(find_latest /Library/Frameworks/Python.framework/Versions "3.*")"
[ -d "${latest_python3_framework}" ] && export PATH="${latest_python3_framework}/bin:${PATH}"

# From `pip3 install --user` or `python3 -m pip install --user`.
latest_python3="$(find_latest "${HOME}/Library/Python" "3.*")"
[ -d "${latest_python3}" ] && export PATH="${latest_python3}/bin:${PATH}"

# LLVM.
latest_llvm="$(find_latest /usr/local/opt/llvm "*")"
if [ -d "${latest_llvm}" ]; then
  export PATH="${latest_llvm}/bin:${PATH}"
  export LDFLAGS="-L${latest_llvm}/lib -Wl,-rpath,${latest_llvm}/lib"
  export CPPFLAGS="-I${latest_llvm}/include"
fi

# Go.
export GOROOT="/usr/local/go"
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"

# Ghostscript.
latest_ghostscript="$(find_latest /usr/local/opt/ghostscript/ "*")"
[ -d "${latest_ghostscript}" ] && export PATH="${latest_ghostscript}/bin/:${PATH}"

# Rust.
export PATH="${HOME}/.cargo/bin:${PATH}"

# GraalVM.
latest_graalvm_app="$(find_latest /Applications "GraalVM-*.app")"
[ -d "${latest_graalvm_app}" ] && export GRAALVM_HOME="${latest_graalvm_app}/Contents/Home"
# GraalVM has binaries like `node`, `npm`, `javac`, `jar`, so put it at the end
# of $PATH so that they don't shadow other binaries.
[ -d "${GRAALVM_HOME}" ] && export PATH="${PATH}:${GRAALVM_HOME}/bin"

# GNU binaries without g prefix.
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
export PATH="/usr/local/opt/gnu-getopt/bin:${PATH}"

# gettext.
export PATH="/usr/local/opt/gettext/bin:${PATH}"
# For compilers to find gettext these might need to be set:
# export LDFLAGS="-L/usr/local/opt/gettext/lib"
# export CPPFLAGS="-I/usr/local/opt/gettext/include"

# kubebuilder.
export PATH="/usr/local/kubebuilder/bin:${PATH}"

# Krew.
export PATH="${KREW_ROOT:-${HOME}/.krew}/bin:${PATH}"

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

# Yarn.
export PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"
