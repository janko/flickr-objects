class Flickr
  class Collection < Array
    extend Object::Attribute
  end
end

require "flickr/objects/attribute_values/collection"

class Flickr
  class Collection < Array

    attribute :current_page,  type: Integer
    attribute :per_page,      type: Integer
    attribute :total_pages,   type: Integer
    attribute :total_entries, type: Integer

    def initialize(collection, klass, hash, client)
      objects = collection.map! { |hash| klass.new(hash, client) }
      super(objects)
      @hash = hash
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
  end
end
