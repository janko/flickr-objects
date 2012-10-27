require_relative "attribute_values/set"
require "flickr/api/set"

class Flickr
  class Set < Object

    attribute :id,               String
    attribute :secret,           String
    attribute :server,           String
    attribute :farm,             Integer
    attribute :url,              String
    attribute :title,            String
    attribute :description,      String

    attribute :owner,            Person

    attribute :media_count,      Integer
    attribute :views_count,      Integer
    attribute :comments_count,   Integer
    attribute :photos_count,     Integer
    attribute :videos_count,     Integer

    attribute :permissions,      Permissions

    attribute :created_at,       Time
    attribute :updated_at,       Time

    attribute :primary_media_id, String
    attribute :primary_photo,    Photo
    attribute :primary_video,    Video

  end
end
