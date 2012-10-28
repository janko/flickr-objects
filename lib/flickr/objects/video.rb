require_relative "attribute_values/video"
require "flickr/api/video"

class Flickr
  class Video < Media

    attribute :ready?,              Boolean
    attribute :failed?,             Boolean
    attribute :pending?,            Boolean

    attribute :duration,            Integer
    attribute :width,               Integer
    attribute :height,              Integer

    attribute :thumbnail_url,       String
    attribute :thumbnail_width,     Integer
    attribute :thumbnail_height,    Integer

    attribute :source_url,          String
    attribute :download_url,        String
    attribute :mobile_download_url, String

  end
end
