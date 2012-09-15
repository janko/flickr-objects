require "flickr/objects/attribute_values/location"

class Flickr
  class Location < Object

    class Area < Object
      attribute :name,     type: String
      attribute :place_id, type: String
      attribute :woe_id,   type: String
    end

    attribute :latitude,      type: Float
    attribute :longitude,     type: Float
    attribute :accuracy,      type: Integer
    attribute :context,       type: Integer
    attribute :place_id,      type: String
    attribute :woe_id,        type: String

    attribute :neighbourhood, type: Area
    attribute :locality,      type: Area
    attribute :county,        type: Area
    attribute :region,        type: Area
    attribute :country,       type: Area

  end
end
