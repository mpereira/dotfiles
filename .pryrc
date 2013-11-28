Pry.editor = 'vim'

Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil

Pry.prompt = proc do |context, _, _|
  "(◊ #{RUBY_VERSION} #{context.to_s == 'main' ? '~' : context}) "
end

Pry.config.ls.heading_color          = :purple

Pry.config.ls.constant_color         = :yellow
Pry.config.ls.global_var_color       = :red
Pry.config.ls.private_method_color   = :bright_black
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.pry_var_color          = :bright_black
Pry.config.ls.public_method_color    = :green
