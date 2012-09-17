require "flickr/core_ext"
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

  def self.method_missing(method, *args, &block)
    if configuration.respond_to?(method)
      configuration.send(method, *args, &block)
    else
      super
    end
  end
end

require "flickr/objects"
require "flickr/api"
