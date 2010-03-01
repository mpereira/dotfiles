require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        install_file(file)
      else
        print "overwrite ~/.#{file}? [yNaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          install_file(file)
        when 'y'
          install_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      install_file(file)
    end
  end
end

def install_file(file)
  if File.directory?(file)
    if File.exists?("#{ENV['HOME']}/.#{file}")
      system %Q{cp -r #{file}/* "$HOME/.#{file}"}
    else
      system %Q{cp -r #{file} "$HOME/.#{file}"}
    end
  else
    system %Q{cp #{file} "$HOME/.#{file}"}
  end
  puts "installing ~/.#{file}"
end
