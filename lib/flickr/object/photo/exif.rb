module Flickr
  class Object
    class Photo

      class Exif < Flickr::Object

        class Item < Object
          attribute :tagspace,    String
          attribute :tagspace_id, String
          attribute :tag,         String
          attribute :label,       String
          attribute :raw,         String
          attribute :clean,       String
        end

        attribute :items,  List[Item]

        ##
        # Fetches the item with the given label and grabs the value.
        #
        # @param label [String] Label of the exif data
        # @return [String]
        #
        def [](label)
          item = items.find { |item| item.label == label }
          item.clean || item.raw
        end

      end

    end
  end
end

require_relative "../attribute_locations/photo/exif"
