export EDITOR=vim
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:cd:exit:q::hist:vim:c:clear:VGA:LVDS:..:ll:lla"

# use vi command mode
set -o vi

test -f $HOME/.functions && . $HOME/.functions
test -f $HOME/.alias && . $HOME/.alias

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# command prompt colors
# regular text colors
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
PURPLE='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

# bold text colors
BLACK_BOLD='\e[1;30m'
RED_BOLD='\e[1;31m'
GREEN_BOLD='\e[1;32m'
YELLOW_BOLD='\e[1;33m'
BLUE_BOLD='\e[1;34m'
PURPLE_BOLD='\e[1;35m'
CYAN_BOLD='\e[1;36m'
WHITE_BOLD='\e[1;37m'

# text underline colors
BLACK_UNDERLINE='\e[4;30m'
RED_UNDERLINE='\e[4;31m'
GREEN_UNDERLINE='\e[4;32m'
YELLOW_UNDERLINE='\e[4;33m'
BLUE_UNDERLINE='\e[4;34m'
PURPLE_UNDERLINE='\e[4;35m'
CYAN_UNDERLINE='\e[4;36m'
WHITE_UNDERLINE='\e[4;37m'

# text background colors
BLACK_BACKGROUND='\e[40m'
RED_BACKGROUND='\e[41m'
GREEN_BACKGROUND='\e[42m'
YELLOW_BACKGROUND='\e[43m'
BLUE_BACKGROUND='\e[44m'
PURPLE_BACKGROUND='\e[45m'
CYAN_BACKGROUND='\e[46m'
WHITE_BACKGROUND='\e[47m'

# colors reset
COLORS_RESET='\e[0m'

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\[$BLUE\]\W \[$RED\]\$( git_branch) \[$GREEN\]\$\[$COLORS_RESET\] "
