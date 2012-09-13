class Flickr
  class Person < Object
    self.attribute_values = {
      id:          [proc {|hash| hash.fetch("nsid") }],
      nsid:        [proc {|hash| hash.fetch("id") }],
      real_name:   [proc {|hash| hash.fetch("realname") }],
      icon_server: [proc {|hash| hash.fetch("iconserver") }],
      icon_farm:   [proc {|hash| hash.fetch("iconfarm") }]
    }
  end
end
