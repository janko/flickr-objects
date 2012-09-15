class Flickr
  class Person < Object
    self.attribute_values = {
      id:          [proc { @hash.fetch("nsid") }],
      real_name:   [proc { @hash.fetch("realname") }],
      icon_server: [proc { @hash.fetch("iconserver") }],
      icon_farm:   [proc { @hash.fetch("iconfarm") }]
    }
  end
end
