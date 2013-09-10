module Flickr
  class Object
    class Photo

      class Tag < Flickr::Object

        attribute :id,           String
        attribute :author,       Person
        attribute :raw,          String
        attribute :content,      String
        attribute :machine_tag,  Boolean

        def to_s
          content
        end

      end

    end
  end
end

require_relative "../attribute_locations/photo/tag"
