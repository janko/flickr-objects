module Flickr
  class Object
    class Photo

      class Note < Flickr::Object

        attribute :id,          String
        attribute :author,      Person
        attribute :coordinates, Array[Integer]
        attribute :width,       Integer
        attribute :height,      Integer
        attribute :content,     String

      end

    end
  end
end

require_relative "../attribute_locations/photo/note"
