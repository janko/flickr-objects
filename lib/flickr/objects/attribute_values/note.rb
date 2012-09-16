class Flickr
  class Note < Object
    self.attribute_values = {
      author:      [->{ {"id" => @hash.fetch("author"), "username" => @hash["authorname"]} }],
      coordinates: [->{ [@hash.fetch("x"), @hash.fetch("y")] }],
      width:       [->{ @hash.fetch("w") }],
      height:      [->{ @hash.fetch("h") }],
      content:     [->{ @hash.fetch("_content") }]
    }
  end
end
