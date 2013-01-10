require_relative "../attribute_values/photo/tag"

class Flickr
  class Photo::Tag < Object

    attribute :id,           String
    attribute :author,       Person
    attribute :raw,          String
    attribute :content,      String
    attribute :machine_tag?, Boolean

    def to_s
      content
    end

  end
end
