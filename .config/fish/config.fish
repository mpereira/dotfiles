set fish_function_path $fish_function_path $HOME/.config/fish/plugin-foreign-env/functions

fenv source ~/.profile

# Aliases.
alias glances='sudo glances --process-short-name --hide-kernel-threads --byte'
alias gl='glances'
alias glweb='open http://localhost:61208'
alias lock='"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'
alias e='/Applications/Emacs.app/ --tty'

# Don't show greeting.
set fish_greeting

# Prompt.
function fish_prompt
  set last_status $status
  if test $last_status -gt 0
    set_color red; echo "$last_status ↵"
  end

  set_color green; echo -n (whoami)
  set_color normal; echo -n " at "
  set_color cyan; echo -n (hostname)
  set_color white; echo -n " in "
  set_color blue; echo (prompt_pwd)
  set_color normal; echo -n "\$ "
end
