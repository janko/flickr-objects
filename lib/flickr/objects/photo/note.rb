require_relative "../attribute_values/photo/note"

class Flickr
  class Photo::Note < Object

    attribute :id,          String
    attribute :author,      Person
    attribute :coordinates, Array[Integer]
    attribute :width,       Integer
    attribute :height,      Integer
    attribute :content,     String

  end
end
