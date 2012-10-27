require_relative "attribute_values/set"
require "flickr/api/set"

class Flickr
  class Set < Object

    attribute :id,  String
    attribute :url, String

  end
end
