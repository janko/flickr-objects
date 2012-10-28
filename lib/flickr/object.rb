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

      children << child
      Object.children << child if self != Object
    end

    def self.find(id)
      new({"id" => id}, client)
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

    protected

    def initialize(hash, client)
      @hash = hash || {}
      @client = client
    end
  end
end
