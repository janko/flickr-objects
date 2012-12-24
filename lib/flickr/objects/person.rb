require_relative "attribute_values/person"
require "flickr/api/person"

class Flickr
  class Person < Object

    attribute :id,                   String
    attribute :nsid,                 String
    attribute :username,             String
    attribute :real_name,            String
    attribute :location,             String
    attribute :time_zone,            Hash
    attribute :description,          String
    attribute :has_pro_account?,     Boolean

    attribute :icon_server,          Integer
    attribute :icon_farm,            Integer

    attribute :photos_url,           String
    attribute :profile_url,          String
    attribute :mobile_url,           String

    attribute :first_photo_taken,    Time
    attribute :first_photo_uploaded, Time

    attribute :photos_count,         Integer
    attribute :photo_views_count,    Integer

    attribute :path_alias,           String

    def buddy_icon_url
      if icon_farm && icon_server && id
        if icon_server > 0
          "http://farm#{icon_farm}.staticflickr.com/#{icon_server}/buddyicons/#{id}.jpg"
        else
          "http://www.flickr.com/images/buddyicon.jpg"
        end
      end
    end

  end
end
