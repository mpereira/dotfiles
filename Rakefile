require 'rake'

desc "Install the dotfiles into the home directory"
task :install do
  $dest_dir = File.join(ENV['HOME'], 'ego', 'dotfiles', 'foo')

  Dir['*'].each do |entry|
    next if %w[Rakefile foo README].include? entry
    if File.exist?("#{$dest_dir}/.#{entry}")
      handle_replace(entry)
    else
      install(entry, true)
    end
  end
end

def ask_input(entry, dot_required = false)
  print "overwrite ~/.#{entry}? [ynq] "
  case $stdin.gets.chomp
  when 'y'
    replace(entry, dot_required)
  when 'q'
    exit
  else
    dot_or_not = dot_required ? '.' : ''
    puts "skipping ~/#{dot_or_not}#{entry}"
  end
end

def install(entry, dot_required = false)
  dot_or_not = dot_required ? '.' : ''
  puts "installing ~/#{dot_or_not}#{entry}"
  system %Q{cp -r #{entry} #{$dest_dir}/#{dot_or_not}#{entry}}
end

def remove(entry, dot_required = false)
  dot_or_not = dot_required ? '.' : ''
  if File.exist?("#{$dest_dir}/#{dot_or_not}#{entry}")
    dot_or_not = dot_required ? '.' : ''
    system %Q{rm -rf #{$dest_dir}/.#{entry}}
  end
end

def replace(entry, dot_required = false)
  remove(entry, dot_required)
  install(entry, dot_required)
end

def handle_replace(entry)
  if File.directory?(entry)
    Dir["#{entry}/*"].each do |sub_entry|
      ask_input(sub_entry, true)
    end
  else
    ask_input(entry, true)
  end
end
