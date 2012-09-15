require "flickr/objects/attribute_values/video"
require "flickr/api/video"

class Flickr
  class Video < Media

    attribute :ready?,   type: Boolean
    attribute :failed?,  type: Boolean
    attribute :pending?, type: Boolean

    attribute :duration, type: Integer
    attribute :width,    type: Integer
    attribute :height,   type: Integer

    def thumbnail(size)
      @hash["url_#{size_abbr(size)}"]
    end
  end
end
