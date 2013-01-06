class Flickr
  class Person::UploadStatus < Object
    class Month < Object
      self.attribute_values = {
        maximum:   [->{ @hash["maxkb"] / 1024 }],
        used:      [->{ @hash["usedkb"] / 1024 }],
        remaining: [->{ @hash["remainingkb"] / 1024 }],
      }
    end

    self.attribute_values = {
      current_month:      [->{ @hash["bandwidth"].slice("maxkb", "usedkb", "remainingkb") }],
      maximum_photo_size: [->{ @hash["filesize"]["maxmb"] }],
    }
  end
end
