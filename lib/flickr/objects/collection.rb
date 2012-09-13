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
    attribute :total_entries, Integer
    attribute :total_pages,   Integer

    def initialize(collection, klass, hash, client)
      objects = collection.map! { |hash| klass.new(hash, client) }
      super(objects)
      @hash = hash
    end

    def find(id)
      if block_given?
        super
      else
        super() {|object| object.id == id.to_s }
      end
    end
  end
end
