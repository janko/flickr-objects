class Flickr
  class Tag < Object
    self.attribute_values = {
      author:       [->{ {"id" => @hash.fetch("author")} }],
      content:      [->{ @hash["_content"] }],
      machine_tag?: [->{ @hash["machine_tag"] }],
    }
  end
end
