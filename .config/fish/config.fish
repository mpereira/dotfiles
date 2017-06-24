set fish_function_path $fish_function_path $HOME/.config/fish/plugin-foreign-env/functions

fenv source ~/.profile

# Aliases.
alias glances='sudo glances --process-short-name --hide-kernel-threads --byte'
alias gl='glances'
alias glweb='open http://localhost:61208'
alias lock='"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'

# Sonian.
eval (chef shell-init fish)
