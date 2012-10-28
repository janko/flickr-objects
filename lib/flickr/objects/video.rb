require_relative "attribute_values/video"
require "flickr/api/video"

class Flickr
  class Video < Media

    attribute :ready?,           Boolean
    attribute :failed?,          Boolean
    attribute :pending?,         Boolean

    attribute :duration,         Integer
    attribute :width,            Integer
    attribute :height,           Integer

    attribute :thumbnail_width,  Integer
    attribute :thumbnail_height, Integer
    attribute :thumbnail_url,    String

  end
end
