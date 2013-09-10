module Flickr
  class Object

    class Location

      Area.attributes.add_locations(
        name: [
          -> { @attributes["_content"] },
        ],
        woe_id: [
          -> { @attributes["woeid"] },
        ],
      )

      attributes.add_locations(
        woe_id: [
          -> { @attributes["woeid"] },
        ],
        indoors: [
          -> { context == 1 },
        ],
        outdoors: [
          -> { context == 2 },
        ],
      )
    end

  end
end
