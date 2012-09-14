class Flickr
  class Person < Object
    self.attribute_values = {
      id:          [proc {|hash| hash.fetch("nsid") }, proc {|hash| hash.fetch("owner") }],
      username:    [proc {|hash| hash.fetch("ownername") }],
      real_name:   [proc {|hash| hash.fetch("realname") }],
      icon_server: [proc {|hash| hash.fetch("iconserver") }],
      icon_farm:   [proc {|hash| hash.fetch("iconfarm") }]
    }
  end
end
