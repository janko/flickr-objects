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
  covered = Flickr.api_methods.keys.select { |key| all_methods.include?(key) }.count
  total = all_methods.count
  puts "#{covered}/#{total}"
end

task :key_exists do
  require "nokogiri"
  require "open-uri"

  seeked_key = ENV["KEY"]
  page = Nokogiri::HTML(open("http://www.flickr.com/api"))
  methods = page.search(:table).last.search(:td).last.search(:li).map { |li| li.at(:a).text }

  total = methods.count
  url = nil
  current = -1

  methods.each do |method|
    current += 1
    puts "#{current}/#{total}" if current % 10 == 0
    url = "http://www.flickr.com/services/api/#{method}.html"
    page = Nokogiri::HTML(open(url))
    keys = page.at(:dl).search(:dt).map { |dt| dt.at(:code).text }
    break if keys.include?(seeked_key)
  end

  if current == total
    puts "You're good, the key doesn't exist."
  else
    puts "Uh-oh, the key exists - it can be found here: #{url}"
  end
end
