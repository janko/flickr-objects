class Flickr
  class Location < Object

    class Area < Object
      attribute :name,     String
      attribute :place_id, String
      attribute :woe_id,   String
    end

    attribute :latitude,      Float
    attribute :longitude,     Float
    attribute :accuracy,      Integer
    attribute :context,       Integer
    attribute :place_id,      String
    attribute :woe_id,        String

    attribute :neighbourhood, Area
    attribute :locality,      Area
    attribute :county,        Area
    attribute :region,        Area
    attribute :country,       Area

  end
end
