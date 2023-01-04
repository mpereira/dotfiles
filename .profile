#!/usr/bin/env bash

################################################################################
############################### IMPORTANT! #####################################
################################################################################
#
# From `man bash`:
#
#   When bash is invoked as an interactive login shell, or as a non-interactive
#   shell with the --login option, it first reads and executes commands from the
#   file /etc/profile, if that file exists. After reading that file, it looks
#   for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads
#   and executes commands from the first one that exists and is readable. The
#   --noprofile option may be used when the shell is started to inhibit this
#   behavior.
#
################################################################################
################################################################################
################################################################################

find_latest () {
  find "${1}" -maxdepth 1 -iname "${2}" 2>/dev/null | sort -Vr | head -1
}

path_append () {
  if [ -d "${1}" ] && [[ ":${PATH}:" != *":${1}:"* ]]; then
    export PATH="${PATH:+"${PATH}"}:${1}"
  fi
}

path_prepend () {
  if [ -d "${1}" ] && [[ ":${PATH}:" != *":${1}:"* ]]; then
    export PATH="${1}:${PATH:+"${PATH}"}"
  fi
}

# This needs to run before our appends and prepends, otherwise it will mess
# everything up.
#
# It sets up PATH based on /etc/paths and /etc/paths.d/*, and MANPATH based on
# /etc/manpaths and /etc/manpaths.d/*.
if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper -s)"
fi

# When prepending to PATH, later prepends will have higher priority.

path_append "/opt/local/bin" # What's using this?
path_prepend "/usr/local/bin"

# CMake.
path_prepend "/Applications/CMake.app/Contents/bin"

# Make.
path_prepend "$(brew --prefix)/opt/make/libexec/gnubin"

# Emacs.
latest_emacs="$(find_latest /Applications Emacs-*.app)"
path_prepend "${latest_emacs}/Contents/MacOS/bin"

# Neovim.
latest_neovim="$(find_latest /opt "nvim-*")"
path_prepend "${latest_neovim}/bin"

# MacVim.
path_prepend "/Applications/MacVim.app/Contents/bin"

# Ruby.
latest_ruby="$(find_latest "${HOME}/.gem/ruby" "*")"
path_prepend "${latest_ruby}/bin" # from `gem install --user-install $gem``

# Python 3.
# From `sudo pip3 install` or `python3 -m pip install`.
latest_python3_framework="$(find_latest /Library/Frameworks/Python.framework/Versions "3.*")"
path_prepend "${latest_python3_framework}/bin"

# From `pip3 install --user` or `python3 -m pip install --user`.
latest_python3="$(find_latest "${HOME}/Library/Python" "3.*")"
path_prepend "${latest_python3}/bin"

# LLVM.
latest_llvm="$(find_latest /usr/local/opt/llvm "*")"
if [ -d "${latest_llvm}" ]; then
  path_prepend "${latest_llvm}/bin"
  export LDFLAGS="-L${latest_llvm}/lib -Wl,-rpath,${latest_llvm}/lib"
  export CPPFLAGS="-I${latest_llvm}/include"
fi

# Go.
export GOROOT="/usr/local/go"
export GOPATH="${HOME}/go"
path_prepend "${GOPATH}/bin"
path_prepend "${GOROOT}/bin"

# Ghostscript.
latest_ghostscript="$(find_latest /usr/local/opt/ghostscript/ "*")"
path_prepend "${latest_ghostscript}/bin"

# Rust.
# shellcheck source=/dev/null
[ -f "${HOME}/.cargo/env" ] && . "${HOME}/.cargo/env"

# GraalVM.
latest_graalvm_app="$(find_latest /Applications "GraalVM-*.app")"
if [ -d "${latest_graalvm_app}" ]; then
  export GRAALVM_HOME="${latest_graalvm_app}/Contents/Home"
  # GraalVM has binaries like `node`, `npm`, `javac`, `jar`, so put it at the end
  # of $PATH so that they don't shadow other binaries.
  path_append "${GRAALVM_HOME}/bin"
fi

# Homebrew Cask: mactex-no-gui
latest_texlive="$(find_latest /usr/local/texlive "*")"
if [ -d "${latest_texlive}" ]; then
  path_prepend "${latest_texlive}/bin/x86_64-darwin"
fi

# GNU binaries without g prefix.
coreutils="/usr/local/opt/coreutils"
path_prepend "${coreutils}/libexec/gnubin"
coreutils_gnuman="${coreutils}/libexec/gnuman"
[ -d "${coreutils_gnuman}" ] && export MANPATH="${coreutils_gnuman}:${MANPATH}"

path_prepend "/usr/local/opt/gnu-getopt/bin"

# gettext.
path_prepend "/usr/local/opt/gettext/bin"
# For compilers to find gettext these might need to be set:
# export LDFLAGS="-L/usr/local/opt/gettext/lib"
# export CPPFLAGS="-I/usr/local/opt/gettext/include"

# kubebuilder.
path_prepend "/usr/local/kubebuilder/bin"

# Krew.
path_prepend "${KREW_ROOT:-${HOME}/.krew}/bin"

# Emacs ansi-term doesn't set locale env variables.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Completion.
for completion_script in "$(brew --prefix)"/etc/bash_completion.d/*; do
  # shellcheck source=/dev/null
  [ -f "${completion_script}" ] && . "${completion_script}"
done

git_completions_bash="/usr/local/git/contrib/completion/git-completion.bash"
# shellcheck source=/dev/null
[ -f "${git_completions_bash}" ] && . "${git_completions_bash}"

# Aliases.
# shellcheck source=/dev/null
[ -f .aliases ] && . .aliases

# Yarn.
path_prepend "${HOME}/.yarn/bin"
path_prepend "${HOME}/.config/yarn/global/node_modules/.bin"
