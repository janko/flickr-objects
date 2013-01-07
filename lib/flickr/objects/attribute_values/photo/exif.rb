class Flickr
  class Photo::Exif < Object
    class Item < Object
      self.attribute_values = {
        tagspace_id: [->{ @hash["tagspaceid"] }],
        raw:         [->{ @hash["raw"]["_content"] }],
        clean:       [->{ @hash["clean"]["_content"] }],
      }
    end

    self.attribute_values = {
      items: [->{ @hash["exif"] }],
    }
  end
end
