class Flickr
  class UploadTicket < Object
    self.attribute_values = {
      status:  [->{ @hash["complete"] }],
      invalid: [->{ @hash["invalid"] || 0}],
      photo:   [->{ {"id" => @hash.fetch("photoid")} }],
    }
  end
end
