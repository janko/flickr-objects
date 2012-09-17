require "flickr/client"
require "flickr/api_caller"

class Flickr
  include ApiCaller
  attr_reader :access_token

  def initialize(*access_token)
    @access_token = access_token.flatten
  end

  clients = Module.new do
    def client
      (@client ||= MethodsClient.new(access_token)).for(self)
    end

    def upload_client
      @upload_client ||= UploadClient.new(access_token)
    end
  end

  include clients
  extend clients
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
