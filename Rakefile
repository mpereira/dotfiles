require 'rake'
require 'fileutils'
require 'erb'

desc 'Syncs dotfiles to your home directory'
task :sync do
  dotfile_paths = dotfiles
  template_paths = dotfile_paths.select { |path| erb?(path) }
  bootstrap_directories(dotfile_paths)
  compile_templates(template_paths)
  link_dotfiles(drop_erb_suffixes(dotfile_paths))
end

desc 'Removes symlinks from your home directory'
task :remove_symlinks do
  remove_symlinks(drop_erb_suffixes(dotfiles))
end

IGNORED_FILES = %w[.gitignore Rakefile README.md]
GIT_FILES = `git ls-files`.split("\n")

def erb?(path)
  File.file?(path) && File.extname(path) === '.erb'
end

def drop_erb_suffix(path)
  File.join(File.dirname(path), File.basename(path, '.erb'))
end

def drop_erb_suffixes(paths)
  paths.map { |path| erb?(path) ? drop_erb_suffix(path) : path }
end

def prepend_repo_path(path)
  File.join(Dir.pwd, path)
end

def prepend_home_path(path)
  File.join(ENV['HOME'], path)
end

def dotfiles(options = {})
  GIT_FILES - IGNORED_FILES
end

def compile_template(template_path)
  dotfile_path = drop_erb_suffix(template_path)
  puts "Compiling #{template_path} into #{dotfile_path}"
  File.open(dotfile_path, 'w') do |file|
    file.write(ERB.new(File.read(template_path), nil, '<>').result)
  end
end

def compile_templates(template_paths)
  template_paths.each { |template_path| compile_template(template_path) }
end

def link_dotfile(dotfile)
  repo_path = prepend_repo_path(dotfile)
  home_path = prepend_home_path(dotfile)
  if File.exists?(home_path)
    if File.symlink?(home_path)
      current_symlink_target = File.readlink(home_path)
      if current_symlink_target != repo_path
        puts "#{home_path} exists but points to #{current_symlink_target} " +
             "instead of #{repo_path}"
      end
    else
      puts "#{home_path} exists but it's not a symlink"
    end
  else
    puts "ln -s #{repo_path} #{home_path}"
    FileUtils.ln_s(repo_path, home_path)
  end
end

def remove_symlink(dotfile)
  path = prepend_home_path(dotfile)
  if File.exists?(path)
    puts "rm -r #{path}"
    FileUtils.rm_r(path)
  end
end

def remove_symlinks(dotfiles)
  dotfiles.each { |dotfile| remove_symlink(dotfile) }
end

def link_dotfiles(dotfiles)
  dotfiles.each { |dotfile| link_dotfile(dotfile) }
end

def bootstrap_directories(dotfiles)
  dotfiles.each do |dotfile|
    directory = File.dirname(prepend_home_path(dotfile))
    if File.exists?(directory)
      unless File.directory?(directory)
        puts "#{directory} but it's not a directory"
      end
    else
      puts "mkdir -p #{directory}"
      FileUtils.mkdir_p(directory)
    end
  end
end
