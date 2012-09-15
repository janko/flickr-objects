class Flickr
  class Tag < Object
    self.attribute_values = {
      author:       [proc { {"id" => @hash.fetch("author")} }],
      content:      [proc { @hash.fetch("_content") }],
      machine_tag?: [proc { @hash.fetch("machine_tag") }]
    }
  end
end
