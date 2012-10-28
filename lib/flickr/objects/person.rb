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

    attribute :photos_url,           String, aliases: [:videos_url, :media_url]
    attribute :profile_url,          String
    attribute :mobile_url,           String

    attribute :first_photo_taken,    Time, aliases: [:first_video_taken, :first_media_taken]
    attribute :first_photo_uploaded, Time, aliases: [:first_video_uploaded, :first_media_uploaded]

    attribute :photos_count,         Integer, aliases: [:videos_count, :media_count]
    attribute :photo_views_count,    Integer, aliases: [:video_views_count, :media_views_count]

    attribute :path_alias,           String

    def buddy_icon_url
      if icon_farm
        if icon_server > 0 && id
          "http://farm#{icon_farm}.staticflickr.com/#{icon_server}/buddyicons/#{id}.jpg"
        else
          "http://www.flickr.com/images/buddyicon.jpg"
        end
      end
    end

  end
end
