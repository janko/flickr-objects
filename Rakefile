require "bundler/gem_tasks"
require "rspec/core/rake_task"

task :default => :spec

RSpec::Core::RakeTask.new

desc "Open the console with credentials (API key, secret etc.) already filled in"
task :console do
  mkdir_p "tmp"
  File.open("tmp/credentials.rb", "w") do |f|
    f.write <<-CREDENTIALS
      Flickr.configure do |config|
        config.api_key = ENV['FLICKR_API_KEY']
        config.shared_secret = ENV['FLICKR_SHARED_SECRET']
        config.access_token_key = ENV['FLICKR_ACCESS_TOKEN']
        config.access_token_secret = ENV['FLICKR_ACCESS_SECRET']
      end
    CREDENTIALS
  end
  begin
    require 'pry'
    sh "pry --require 'flickr-objects' --require './tmp/credentials'"
  rescue LoadError
    sh "irb -r 'flickr-objects' -r './tmp/credentials'"
  end
  rm_rf "tmp"
end
