require "flickr/client"
require "flickr/api_caller"

class Flickr
  include ApiCaller

  def initialize(*access_token)
    @access_token = access_token
  end

  def client
    @client ||= MethodsClient.new(@access_token)
  end

  def upload_client
    @upload_client ||= UploadClient.new(@access_token)
  end

  def self.client
    @client ||= MethodsClient.new(configuration.access_token)
  end

  def self.upload_client
    @upload_client ||= UploadClient.new(configuration.access_token)
  end
end

require "flickr/api/flickr"

class Flickr
  def self.map_interface(method, klass)
    define_method(method) do
      klass.tap do |klass|
        klass.instance_variable_set("@client", client)
      end
    end

    define_singleton_method(method) do
      klass.tap do |klass|
        klass.instance_variable_set("@client", client)
      end
    end
  end

  map_interface :photos,         Photo
  map_interface :people,         Person
  map_interface :sets,           Set
  map_interface :upload_tickets, UploadTicket
end
