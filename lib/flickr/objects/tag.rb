require "flickr/objects/attribute_values/tag"

class Flickr
  class Tag < Object

    attribute :id,           type: String
    attribute :author,       type: Person
    attribute :raw,          type: String
    attribute :content,      type: String
    attribute :machine_tag?, type: Boolean

    def to_s
      content
    end

  end
end

require "flickr/api/tag"
