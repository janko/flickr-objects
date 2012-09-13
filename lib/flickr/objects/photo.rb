require "flickr/objects/attribute_values/photo"

class Flickr
  class Photo < Media

    attribute :rotation, Integer

  end
end

require "flickr/api/photo"
