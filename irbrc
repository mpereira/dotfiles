# setup: sudo gem install pp hirb wirble what_methods

# tab completion
require 'irb/completion'

# save history between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# minimalist command prompt
IRB.conf[:PROMPT_MODE] = :SIMPLE

# load rubygems, pretty print and a neat method finder
%w[rubygems pp what_methods].each do |gem|
  begin
    require gem
  rescue LoadError
  end
end

# loading hirb
begin
  require 'hirb'
  Hirb.enable
rescue LoadError
end

# loading wirble
begin
  require 'wirble'
  %w[init colorize].each { |m| Wirble.send(m) }
rescue LoadError
end

# method to clear the screen
def clear
  system 'clear'
  if ENV['RAILS_ENV']
    return "Rails environment: " + ENV['RAILS_ENV']
  end
end

alias c clear
