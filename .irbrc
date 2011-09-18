# Add all gems in the global gemset to the $LOAD_PATH so they can be used even
# in places like 'rails console'.
if defined?(::Bundler)
  global_gemset_path = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  unless global_gemset_path.to_s.empty?
    global_gem_paths = Dir.glob("#{global_gemset_path}/gems/*")
    global_gem_paths.each do |gem_path|
      $LOAD_PATH << "#{gem_path}/lib"
    end
  end
end

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
