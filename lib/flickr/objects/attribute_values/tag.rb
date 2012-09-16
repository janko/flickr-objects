class Flickr
  class Tag < Object
    self.attribute_values = {
      author:       [->{ {"id" => @hash.fetch("author")} }],
      content:      [->{ @hash.fetch("_content") }],
      machine_tag?: [->{ @hash.fetch("machine_tag") }]
    }
  end
end
