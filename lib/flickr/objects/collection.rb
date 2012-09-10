class Flickr
  class Collection < Array
    extend Flickr::Object::Attribute

    def initialize(collection, klass, client)
      objects = collection.map! { |hash| klass.new(hash, client) }
      super(objects)
    end
  end
end
