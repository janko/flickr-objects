require "flickr/objects/attribute_values/media"
require "flickr/api/media"

class Flickr
  class Media < Object

    attribute :id,                   String
    attribute :secret,               String
    attribute :server,               String
    attribute :farm,                 Integer
    attribute :title,                String
    attribute :description,          String
    attribute :license,              Integer
    attribute :visibility,           Visibility

    attribute :safety_level,         Integer
    attribute :safe?,                Boolean
    attribute :moderate?,            Boolean
    attribute :restricted?,          Boolean

    attribute :owner,                Person

    attribute :uploaded_at,          Time
    attribute :posted_at,            Time
    attribute :taken_at,             Time
    attribute :taken_at_granularity, Integer
    attribute :updated_at,           Time

    attribute :views_count,          Integer
    attribute :comments_count,       Integer

    attribute :editability,          Permissions
    attribute :public_editability,   Permissions
    attribute :usage,                Permissions

    attribute :notes,                Array(Note)
    attribute :tags,                 Array(Tag)

    attribute :has_people?,          Boolean
    attribute :favorite?,            Boolean

    attribute :path_alias

    attribute :location,             Location
    attribute :location_visibility,  Visibility

    attribute :url,                  String
    attribute :short_url,            String

    attribute :largest_size,         String

    SIZES = {
      "Square 75"  => "sq",
      "Thumbnail"  => "t",
      "Square 150" => "q",
      "Small 240"  => "s",
      "Small 320"  => "n",
      "Medium 500" => "m",
      "Medium 640" => "z",
      "Medium 800" => "c",
      "Large 1024" => "l",
      "Large 1600" => "h",
      "Large 2048" => "k",
      "Original"   => "o"
    }
  end
end
