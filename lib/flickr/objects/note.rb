require "flickr/objects/attribute_values/note"

class Flickr
  class Note < Object

    attribute :id,          type: String
    attribute :author,      type: Person
    attribute :coordinates, type: Array(Integer)
    attribute :width,       type: Integer
    attribute :height,      type: Integer
    attribute :content,     type: String

  end
end
