# Credits: Myron Marston
#
# http://myronmars.to/n/dev-blog/2012/03/faster-test-boot-times-with-bundler-standalone

begin
  # use `bundle install --standalone' to get this...
  require_relative '../bundle/bundler/setup'
rescue LoadError
  # fall back to regular bundler if the developer hasn't bundled standalone
  require 'bundler'
  Bundler.setup
end
