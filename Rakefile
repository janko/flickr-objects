require "bundler"
Bundler.setup

Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new
task :default => :spec

desc "Open the console with credentials (API key, secret etc.) already filled in"
task :console do
  begin
    require "pry"
    sh "pry --require 'flickr-objects' --require './spec/setup'"
  rescue LoadError
    sh "irb -r 'flickr-objects' -r './spec/setup'"
  end
end

desc "Find out how many methods are covered"
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

desc "Create all the necessary files for a new Flickr object"
task :new_object do
  name = ENV["NAME"]
  camelized_name = name.split("_").map(&:capitalize).join

  filenames = [
    "lib/flickr/objects/#{name}.rb",
    "lib/flickr/objects/attribute_values/#{name}.rb",
    "lib/flickr/api/#{name}.rb",
    "lib/flickr/api/api_methods/#{name}.rb",
    "spec/flickr/objects/#{name}_spec.rb",
    "spec/flickr/api/#{name}_spec.rb",
  ]
  lib_content = <<-EOS
class Flickr
  class #{camelized_name} < Object
  end
end
  EOS
  spec_content = <<-EOS
require "spec_helper"

describe Flickr::#{camelized_name} do
end
  EOS

  ROOT = File.expand_path(File.dirname(__FILE__))
  filenames.each do |filename|
    full_path = File.join(ROOT, filename)

    unless File.exists?(full_path)
      if filename =~ /_spec\.rb$/
        File.open(full_path, "w") { |f| f.write(spec_content) }
      else
        File.open(full_path, "w") { |f| f.write(lib_content) }
      end
    end
  end
end

task :update_list do
  require "nokogiri"
  require "open-uri"
  require "flickr-objects"

  document = Nokogiri::HTML(open("http://www.flickr.com/services/api"))
  titles = document.search(:table)[1].search(:td)[1].search(:h3).map(&:text)
  methods = document.search(:table)[1].search(:td)[1].search(:ul).map { |ul| ul.search(:li).map(&:text) }

  hash = Hash[titles.zip(methods)]
  File.open("methods.md", "w") do |file|
    hash.each_with_index do |(title, methods), index|
      file.write("# #{title}\n\n")
      methods.each do |method|
        if Flickr.api_methods.keys.include?(method)
          file.write("* #{method}\n")
        else
          file.write("- #{method}\n")
        end
      end
      file.write("\n") if index < (hash.count - 1)
    end
  end
end
