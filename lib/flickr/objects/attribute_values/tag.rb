class Flickr
  class Tag < Object
    self.attribute_values = {
      author:       [proc {|hash| {"id" => hash.fetch("author")} }],
      content:      [proc {|hash| hash.fetch("_content") }],
      machine_tag?: [proc {|hash| hash.fetch("machine_tag") }]
    }
  end
end
