# encoding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "flickr/version"

Gem::Specification.new do |gem|
  gem.name          = "flickr-objects"
  gem.version       = Flickr::VERSION

  gem.required_ruby_version = ">= 1.9.2"

  gem.description   = %q{This gem is an object-oriented wrapper for the Flickr API.}
  gem.summary       = gem.description
  gem.homepage      = "http://janko-m.github.com/flickr-objects"
  gem.authors       = ["Janko Marohnić"]
  gem.email         = ["janko.marohnic@gmail.com"]

  gem.license       = "MIT"

  gem.files         = Dir["README.md", "LICENSE", "lib/**/*"]
  gem.require_path  = "lib"

  gem.add_dependency "faraday", ">= 0.7.6"
  gem.add_dependency "faraday_middleware", ">= 0.8"
  gem.add_dependency "simple_oauth", "~> 0.1"
  gem.add_dependency "multi_xml", "~> 0.4"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 2"
  gem.add_development_dependency "vcr", ">= 2"
  gem.add_development_dependency "activesupport", ">= 3"
  gem.add_development_dependency "will_paginate", ">= 3"
  gem.add_development_dependency "kaminari", ">= 0.14"
  gem.add_development_dependency "capybara", ">= 2.1"
  gem.add_development_dependency "selenium-webdriver", ">= 2.35.1"
end
