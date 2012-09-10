class Flickr
  class Person < Object
    self.attribute_values = {
      id:          [->(h) { h["nsid"] }],
      nsid:        [->(h) { h["id"] }],
      real_name:   [->(h) { h["realname"] }],
      icon_server: [->(h) { h["iconserver"] }],
      icon_farm:   [->(h) { h["iconfarm"] }]
    }
  end
end
