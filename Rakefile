# frozen_string_literal: false

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "timeout"
require "yard"

def shell(*args)
  puts "running: #{args.join(' ')}"
  system(args.join(" "))
end

task :clean do
  shell("rm -rf pkg/ tmp/ coverage/ doc/")
end

task gem: [:build] do
  shell("gem install pkg/*")
end

task permissions: [:clean] do
  # One traversal replaces a six-level glob chain that printed "No such file
  # or directory" for every level this project does not have, skipped dotfiles
  # entirely, and silently stopped at depth six. .git is pruned: its objects
  # have no business being group-readable.
  shell("find . -path ./.git -prune -o -type d -exec chmod o+rx,g+rx {} + -o -type f -exec chmod o+r,g+r {} +")
end

desc "Build the gem locally"
task build: :permissions

desc 'Generate YARD docs into ./doc'
YARD::Rake::YardocTask.new("docs") do |t|
  t.files = %w[lib/**/*.rb - README.md LICENSE.txt CHANGELOG.md docs/badge/coverage_badge.svg]
  t.options = ['--protected', '--private']
  t.options.unshift("--title", '"colored2: ANSI color any Ruby object"')
  t.after = -> do
    # correct the path to the badge in the docs
    system(%q[sed -i '' 's|<img src="docs|<img src="../docs|g' doc/index.html])
    exec("open doc/index.html")
  end if RUBY_PLATFORM =~ /darwin/
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec
