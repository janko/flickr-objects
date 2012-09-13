class Flickr
  class Note < Object
    self.attribute_values = {
      author:      [proc {|hash| {"id" => hash.fetch("author"), "username" => hash["authorname"]} }],
      coordinates: [proc {|hash| [hash.fetch("x"), hash.fetch("y")] }],
      width:       [proc {|hash| hash.fetch("w") }],
      height:      [proc {|hash| hash.fetch("h") }],
      content:     [proc {|hash| hash.fetch("_content") }]
    }
  end
end
