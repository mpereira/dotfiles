# ~/.irbrc
#
# setup: sudo gem install pp hirb wirble what_methods

require 'rubygems'

# prettier printing
require 'pp'

# tab completion
require 'irb/completion'

# neat method finder
require 'what_methods'

# loading hirb
require 'hirb'
Hirb.enable

# loading wirble
require 'wirble'
Wirble.init
Wirble.colorize

# save history between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# minimalist command prompt
IRB.conf[:PROMPT_MODE] = :SIMPLE

# method to clear the screen
def clear
  system 'clear'
  if ENV['RAILS_ENV']
    return "Rails environment: " + ENV['RAILS_ENV']
  end
end

alias c clear
