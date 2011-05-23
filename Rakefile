require 'rake'
require 'fileutils'
require 'erb'

desc "Copy dotfiles to your home directory"
task :install do
  backup_old_dotfiles if backup?
  remove_old_dotfiles
  install_dotfiles
end

def backup?
  ENV['BACKUP'] ? !(ENV['BACKUP'].downcase == 'no') : true
end

def entries(options = {})
  entries = `git ls-files`.split("\n") - %w[.gitignore Rakefile README.org]
  if options[:remove_erb_suffix]
    entries.map do |entry|
      File.join(File.dirname(entry), File.basename(entry, '.erb'))
    end
  else
    entries
  end
end

def create_subdirectories(entries, options)
  entries.select { |entry| File.split(entry).first != '.' }.each do |entry|
    $stderr.puts "mkdir -p #{File.join(options[:path], File.split(entry).first)}"
    FileUtils.mkdir_p(File.join(options[:path], File.split(entry).first))
  end
end

def backup_old_dotfiles
  backup_dir_path = "#{ENV['HOME']}/.dotfiles.bak-#{Time.now.strftime("%Y%m%d%k%M%S")}"
  $stderr.puts "mkdir #{backup_dir_path}"
  FileUtils.mkdir(backup_dir_path)
  create_subdirectories(entries, :path => backup_dir_path)
  entries(:remove_erb_suffix => true).each do |entry|
    old_entry_path = File.join(ENV['HOME'], entry)
    if File.exist?(old_entry_path)
      $stderr.puts "cp -r #{old_entry_path} #{File.join(backup_dir_path, File.split(entry))}"
      FileUtils.cp_r(old_entry_path, File.join(backup_dir_path, File.split(entry)))
    end
  end
end

def remove_old_dotfiles
  entries(:remove_erb_suffix => true).each do |entry|
    old_entry_path = File.join(ENV['HOME'], File.split(entry))
    $stderr.puts "rm -rf #{old_entry_path}"
    FileUtils.rm_rf(old_entry_path)
  end
end

def install_dotfiles
  create_subdirectories(entries, :path => ENV['HOME'])
  entries.each do |entry|
    if File.extname(entry) == '.erb'
      compiled_template_path = File.join(ENV['HOME'], File.dirname(entry), File.basename(entry, '.erb'))
      $stderr.puts "generating #{compiled_template_path} from template"
      File.open(compiled_template_path, 'w') do |file|
        file.write(ERB.new(File.read(entry), nil, '<>').result)
      end
    else
      destination = File.join(ENV['HOME'], File.split(entry).first)
      $stderr.puts "cp -r #{entry} #{destination}"
      FileUtils.cp_r(entry, destination)
    end
  end
end
