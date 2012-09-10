require "bundler/gem_tasks"
require "rspec/core/rake_task"

task :default => :spec

RSpec::Core::RakeTask.new

desc "Open the console with credentials (API key, secret etc.) already filled in"
task :console do
  begin
    require 'pry'
    sh "pry --require 'flickr-objects' --require './spec/credentials'"
  rescue LoadError
    sh "irb -r 'flickr-objects' -r './spec/credentials'"
  end
end
