class Flickr
  class Note < Object
    self.attribute_values = {
      author:      [->{ {"id" => @hash.fetch("author"), "username" => @hash["authorname"]} }],
      coordinates: [->{ [@hash.fetch("x"), @hash.fetch("y")] }],
      width:       [->{ @hash["w"] }],
      height:      [->{ @hash["h"] }],
      content:     [->{ @hash["_content"] }],
    }
  end
end
