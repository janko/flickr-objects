class Flickr
  class Person < Object
    self.attribute_values = {
      id:             [->{ @hash.fetch("nsid") }],
      nsid:           [->{ id }],
      real_name:      [->{ @hash.fetch("realname") }],
      icon_server:    [->{ @hash.fetch("iconserver") }],
      icon_farm:      [->{ @hash.fetch("iconfarm") }],
    }
  end
end
