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

    protected

    def initialize(hash, client)
      @hash = hash || {}
      @client = client
    end
  end
end
