class Flickr
  class Tag < Object
    self.attribute_values = {
      author:       [->(h) { {"id" => h["author"]} }],
      content:      [->(h) { h["_content"] }],
      machine_tag?: [->(h) { h["machine_tag"] }]
    }
  end
end
