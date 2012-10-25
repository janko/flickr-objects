class Flickr
  class Location < Object
    class Area < Object
      self.attribute_values = {
        name:   [->{ @hash.fetch("_content") }],
        woe_id: [->{ @hash.fetch("woeid") }],
      }
    end

    self.attribute_values = {
      woe_id: [->{ @hash.fetch("woeid") }],
    }
  end
end
