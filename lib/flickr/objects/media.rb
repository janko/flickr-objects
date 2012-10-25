require "flickr/objects/attribute_values/media"
require "flickr/api/media"
require "flickr/helpers/base_58"

class Flickr
  class Media < Object
    include Base58

    attribute :id,                   String
    attribute :secret,               String
    attribute :server,               String
    attribute :farm,                 Integer
    attribute :title,                String
    attribute :description,          String
    attribute :license,              Integer
    attribute :visibility,           Visibility
    attribute :safety_level,         Integer

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

    def safe?;       safety_level <= 1 end
    def moderate?;   safety_level == 2 end
    def restricted?; safety_level == 3 end

    def url
      "http://www.flickr.com/photos/#{owner.id}/#{id}/"
    end

    def short_url
      "http://flic.kr/p/#{to_base58(id)}"
    end
  end
end
