# frozen_string_literal: false

require 'bundler'
require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => e
  warn "Error loading rspec task: #{e.message}"
  exit 1
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)
rescue LoadError => e
  warn "Error loading rubocop task: #{e.message}"
  exit 1
end

task default: [:spec, :rubocop]

def shell(*args)
  puts "running: #{args.join(' ')}"
  system(args.join(' '))
end

desc 'Clean up any temp or coverage files.'
task :clean do
  shell('rm -rf pkg/ tmp/ coverage/ ' )
end

desc 'Install the gem locally from the pkg/*.gem file'
task gem: [:build] do
  shell('gem install pkg/*')
end

desc 'Ensure permissions are not an issue'
task permissions: [:clean] do
  shell("find . -type f -exec chmod 644 {} \\;")
  shell("find . -type d -exec chmod 755 {} \\;")
  shell("find bin -type f -exec chmod 755 {} \\; 2>/dev/null")
  shell("find exe -type f -exec chmod 755 {} \\; 2>/dev/null")
  shell("pwd -P && mkdir pkg && chmod -R g+r,g+x,o+r,o+x pkg")
end

desc 'Builds the gem into the pkg/ folder'
task build: :permissions
