require "flickr/client"
require "flickr/api_caller"

# These are the original clients. They are injected into each Flickr object, in
# the similar manner as a facehugger injects the alien through victim's mouth.
class Flickr
  include ApiCaller

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

require "flickr/api/flickr"

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

  map_interface :media,  Media
  map_interface :photos, Photo
  map_interface :videos, Video
end
