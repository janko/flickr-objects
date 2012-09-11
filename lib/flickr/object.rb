require "flickr/object/attribute"

class Flickr
  class Object
    class << self
      attr_accessor :children
    end
    self.children = []

    def self.inherited(child)
      child.send(:extend, Attribute)
      child.send(:include, ApiCaller)

      self.children << child
      child.children = []
    end

    def self.new_collection(collection)
      Collection.new(collection, self.class, client)
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
