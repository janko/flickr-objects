class Flickr
  class Note < Object
    self.attribute_values = {
      author:      [->(h) { {"id" => h["author"], "username" => h["authorname"]} }],
      coordinates: [->(h) { [h["x"], h["y"]] }],
      width:       [->(h) { h["w"] }],
      height:      [->(h) { h["h"] }],
      content:     [->(h) { h["_content"] }]
    }
  end
end
