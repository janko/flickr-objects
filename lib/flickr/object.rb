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

    def self.new_list(hashes, client, list_hash)
      List.new(hashes.map { |hash| new(hash, client) }, list_hash)
    end

    def inspect
      attribute_values = {}
      self.class.attributes.each do |name|
        attribute_values[name] = send(name) unless send(name).nil?
      end
      class_name = self.class.name
      "#<#{class_name}: #{attribute_values.map { |k, v| "#{k}=#{v.inspect}" }.join(" ")}>"
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
