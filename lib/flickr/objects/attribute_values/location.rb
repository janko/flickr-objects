class Flickr
  class Location < Object
    class Area < Object
      self.attribute_values = {
        name:   [proc { @hash.fetch("_content") }],
        woe_id: [proc { @hash.fetch("woeid") }]
      }
    end

    self.attribute_values = {
      woe_id: [proc { @hash.fetch("woeid") }]
    }
  end
end
