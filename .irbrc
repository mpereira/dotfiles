# Tab completion
require 'irb/completion'

# Save history between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# Minimalist command prompt
IRB.conf[:PROMPT_MODE] = :SIMPLE

%w[rubygems interactive_editor what_methods].each do |gem|
  begin
    require gem
  rescue LoadError
    STDERR.puts $!
  end
end

# Loading awesome print
begin
  require 'ap'
rescue LoadError
  STDERR.puts $!
else
  IRB::Irb.class_eval do
    # Making awesome_print the default outputter
    def output_value
      ap @context.last_value
    end
  end
end

# Loading bond
begin
  require 'bond'
rescue LoadError
  STDERR.puts $!
else
  Bond.start
end

# Loading wirble
begin
  require 'wirble'
rescue LoadError
  STDERR.puts $!
else
  %w[init colorize].each { |m| Wirble.send(m) }
end

# Loading hirb
begin
  require 'hirb'
rescue LoadError
  STDERR.puts $!
else
  Hirb.enable
end

# Method to clear the screen
def clear; system 'clear'; end
alias c clear

class Object
  # Lists all methods that are exclusive to the object
  def local_methods
    self.methods - (self.class.superclass.instance_methods + Object.methods)
  end
end

module IRB::ExtendCommandBundle
  alias q irb_exit
end