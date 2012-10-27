require "bundler/gem_tasks"
require "bundler/setup"
require "rspec/core/rake_task"

task :default => :spec

RSpec::Core::RakeTask.new

desc "Open the console with credentials (API key, secret etc.) already filled in"
task :console do
  begin
    require "pry"
    sh "pry --require 'flickr-objects' --require './spec/credentials'"
  rescue LoadError
    sh "irb -r 'flickr-objects' -r './spec/credentials'"
  end
end

task :methods_covered do
  require "nokogiri"
  require "open-uri"
  require "flickr-objects"

  page = Nokogiri::HTML(open("http://www.flickr.com/api"))
  all_methods = page.search(:table).last.search(:td).last.search(:li).map { |li| li.at(:a).text }
  covered = Flickr.api_methods.count
  total = all_methods.count
  puts "#{covered}/#{total}"
end
