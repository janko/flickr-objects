require_relative "../attribute_values/photo/exif"

class Flickr
  class Photo::Exif < Object
    class Item < Object
      attribute :tagspace,    String
      attribute :tagspace_id, String
      attribute :tag,         String
      attribute :label,       String
      attribute :raw,         String
      attribute :clean,       String
    end

    attribute :camera, String
    attribute :items,  Array[Item]

    def [](label)
      item = items.find { |item| item.label == label }
      item.clean || item.raw
    end
  end
end
