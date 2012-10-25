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

    def buddy_icon_url
      if icon_farm
        if icon_server > 0 && id
          "http://farm{#{icon_farm}}.staticflickr.com/{#{icon_server}}/buddyicons/#{id}.jpg"
        else
          "http://www.flickr.com/images/buddyicon.jpg"
        end
      end
    end

  end
end
