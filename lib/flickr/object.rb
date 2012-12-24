require "flickr/object/attribute"
require "flickr/api_caller"

class Flickr
  class Object
    def self.children
      @children ||= []
    end

    def self.inherited(child)
      child.send(:extend, Attribute)
      child.send(:include, ApiCaller)

      Object.children << child
    end

    def self.find(id)
      new({"id" => id}, client)
    end

    def self.new_collection(hashes, client, collection_hash)
      Collection.new(hashes.map { |hash| new(hash, client) }, collection_hash)
    end

    def inspect
      attribute_values = {}
      self.class.attributes.each do |name|
        attribute_values[name] = send(name) unless send(name).nil?
      end
      class_name = self.class.name
      id = "0x%x" % (object_id << 1)
      "#<#{class_name}:#{id} #{attribute_values.map { |k, v| "#{k}=#{v.inspect}" }.join(" ")}>"
    end

    def ==(other)
      if (self.respond_to?(:id) && self.id) && (other.respond_to?(:id) && other.id)
        id == other.id
      else
        super
      end
    end

    protected

    def initialize(hash, client)
      @hash = hash || {}
      @client = client
    end
  end
end
