require "flickr/objects/attribute_values/note"

class Flickr
  class Note < Object

    attribute :id,          String
    attribute :author,      Person
    attribute :coordinates, Array(Integer)
    attribute :width,       Integer
    attribute :height,      Integer
    attribute :content,     String

  end
end
