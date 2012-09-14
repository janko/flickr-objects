require "flickr/objects/attribute_values/photo"

class Flickr
  class Photo < Media

    attribute :rotation, type: Integer

  end
end

require "flickr/api/photo"
