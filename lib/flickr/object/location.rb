module Flickr
  class Object

    class Location < Flickr::Object

      class Area < Flickr::Object

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

      attribute :indoors,       Boolean
      attribute :outdoors,      Boolean

      attribute :neighbourhood, Area
      attribute :locality,      Area
      attribute :county,        Area
      attribute :region,        Area
      attribute :country,       Area

    end

  end
end

require_relative "attribute_locations/location"
