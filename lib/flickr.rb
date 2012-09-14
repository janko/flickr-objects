require "flickr/core_ext"
require "flickr/configuration"

class Flickr
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
    @client = nil
  end

  def self.api_methods
    @api_methods ||= Hash.new { |hash, key| hash[key] = [] }
  end
end

require "flickr/objects"
require "flickr/api"
