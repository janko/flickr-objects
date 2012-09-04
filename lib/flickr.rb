require "flickr/configuration"
require "flickr/client"
require "flickr/api_caller"
require "flickr/api_methods"
require "flickr/object"

class Flickr
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
    reset_client
  end

  def self.reset_client
    @client = nil
  end

  def self.api_methods
    @api_methods ||= ApiMethods.new
  end
end

# The API part

class Flickr
  include ApiCaller

  # Override ApiCaller's self.client. This is the real client.
  def self.client
    @client ||= Client.new(configuration.access_token)
  end
end
