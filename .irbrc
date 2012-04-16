# Add all gems in the global gemset of the current ruby to the $LOAD_PATH so
# they can be used even in bundled ruby projects without declaring them in the
# Gemfile.
if defined?(::Bundler)
  global_gemset_path = ENV['GEM_PATH'].
                         split(':').
                         grep(/ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}@global/).
                         first

  if global_gemset_path
    $LOAD_PATH.concat(Dir.glob("#{global_gemset_path}/gems/*/lib"))
  else
    STDERR.puts 'Could not load gems from the current ruby\'s global gemset'
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

%w[rubygems irbtools irbtools/more].each do |gem|
  begin
    require gem
  rescue LoadError
    STDERR.puts $!
  end
end

Irbtools.welcome_message = ''

# Method to clear the screen
def clear; system 'clear'; end
alias c clear

class Object
  # Lists all methods that are exclusive to the object.
  def local_methods
    (methods - (self.class.superclass.instance_methods + Object.methods)).sort
  end
end

module IRB::ExtendCommandBundle
  alias q irb_exit
end

if defined?(ActiveRecord)
  ActiveRecord::Base.logger = Logger.new(STDOUT)

  def explain(query)
    query = query.to_sql if query.is_a?(ActiveRecord::Relation)

    ActiveRecord::Base
      .connection
      .execute('EXPLAIN ANALYZE #{query}')
      .to_a
      .each { |hash| puts hash['QUERY PLAN'] }

    nil
  end
end
