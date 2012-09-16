require "flickr/objects/attribute_values/person"
require "flickr/api/person"

class Flickr
  class Person < Object

    attribute :id,             String
    attribute :nsid,           String
    attribute :username,       String
    attribute :real_name,      String
    attribute :location,       String

    attribute :icon_server,    Integer
    attribute :icon_farm,      Integer
    attribute :buddy_icon_url, String

  end
end
