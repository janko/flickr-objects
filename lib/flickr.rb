require "flickr/configuration"

class Flickr
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
    @client = nil
  end

  ROOT = File.expand_path(File.dirname(__FILE__))
end

class Flickr
  def self.api_methods
    @api_methods ||= Hash.new { |hash, key| hash[key] = [] }
  end
end

require "flickr/client"

# These are the original clients. They are injected into each Flickr object, in
# the similar manner as a facehugger injects the alien through victim's mouth.
class Flickr
  def initialize(*access_token)
    @client = Client.new(access_token.flatten)
  end

  def client
    @client.for(self)
  end

  def self.client
    (@client ||= Client.new(configuration.access_token)).for(self)
  end
end

class Flickr
  def self.map_interface(method, klass)
    define_method(method) do
      klass.dup.tap do |klass|
        klass.instance_variable_set("@client", client)
      end
    end

    define_singleton_method(method) do
      klass.dup.tap do |klass|
        klass.instance_variable_set("@client", client)
      end
    end
  end
end

require "flickr/api"
