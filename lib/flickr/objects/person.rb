require "flickr/objects/attribute_values/person"
require "flickr/api/person"

class Flickr
  class Person < Object

    attribute :id,          type: String, alias: [:nsid]
    attribute :real_name,   type: String
    attribute :location,    type: String
    attribute :icon_server, type: Integer
    attribute :icon_farm,   type: Integer
    attribute :username,    type: String

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
