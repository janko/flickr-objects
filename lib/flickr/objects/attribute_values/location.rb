class Flickr
  class Location < Object
    class Area < Object
      self.attribute_values = {
        name:   [->{ @hash["_content"] }],
        woe_id: [->{ @hash["woeid"] }],
      }
    end

    self.attribute_values = {
      woe_id: [->{ @hash["woeid"] }],
    }
  end
end
