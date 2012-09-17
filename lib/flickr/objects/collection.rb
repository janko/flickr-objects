class Flickr
  class Collection < Array
    extend Object::Attribute
  end
end

require "flickr/objects/attribute_values/collection"

class Flickr
  class Collection < Array

    attribute :current_page,  Integer
    attribute :per_page,      Integer
    attribute :total_pages,   Integer
    attribute :total_entries, Integer

    def initialize(collection, klass, hash, client)
      unless klass == Media
        objects = collection.map! do |hash|
          klass.new(hash, client)
        end
      else
        objects = collection.map! do |hash|
          klass = Flickr.const_get(hash["media"].capitalize)
          klass.new(hash, client)
        end
      end

      @hash = hash
      super(objects)
    end

    def find(id = nil)
      if block_given?
        super
      else
        if id.is_a?(Array)
          ids = id.map(&:to_s)
          select {|object| ids.include?(object.id) }
        else
          super() {|object| object.id == id.to_s }
        end
      end
    end

    def select(*args, &block)
      self.dup.select!(*args, &block)
    end

    def select!(*args, &block)
      super
      self
    end
  end
end
