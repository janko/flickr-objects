module Flickr
  class Object

    class Visibility < Flickr::Object

      attribute :public,   Boolean
      attribute :friends,  Boolean
      attribute :family,   Boolean
      attribute :contacts, Boolean

    end

  end
end

require_relative "attribute_locations/visibility"
