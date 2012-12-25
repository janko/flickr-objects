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
    sh "pry --require './spec/setup'"
  rescue LoadError
    sh "irb -r './spec/setup'"
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
