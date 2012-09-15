class Flickr
  class Note < Object
    self.attribute_values = {
      author:      [proc { {"id" => @hash.fetch("author"), "username" => @hash["authorname"]} }],
      coordinates: [proc { [@hash.fetch("x"), @hash.fetch("y")] }],
      width:       [proc { @hash.fetch("w") }],
      height:      [proc { @hash.fetch("h") }],
      content:     [proc { @hash.fetch("_content") }]
    }
  end
end
