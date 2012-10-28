class Flickr
  class UploadTicket < Object
    self.attribute_values = {
      status:   [->{ @hash["complete"] }],
      invalid?: [->{ @hash["invalid"] || 0 }],
      media:    [->{ {"id" => @hash.fetch("photoid")} }],
      photo:    [->{ {"id" => @hash.fetch("photoid")} }],
      video:    [->{ {"id" => @hash.fetch("photoid")} }],
    }
  end
end
