require "flickr/helpers/core_ext"
require "flickr/configuration"

class Flickr
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
    @client = @upload_client = nil
    configuration
  end

  def self.api_methods
    @api_methods ||= Hash.new { |hash, key| hash[key] = [] }
  end

  def self.deprecation_warn(message)
    warn "[FLICKR OBJECTS] #{message}"
  end
end

require "flickr/objects"
require "flickr/api"
require "flickr/oauth"
