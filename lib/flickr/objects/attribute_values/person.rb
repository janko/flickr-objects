class Flickr
  class Person < Object
    self.attribute_values = {
      id:             [->{ @hash.fetch("nsid") }],
      nsid:           [->{ id }],
      real_name:      [->{ @hash.fetch("realname") }],
      icon_server:    [->{ @hash.fetch("iconserver") }],
      icon_farm:      [->{ @hash.fetch("iconfarm") }],
      buddy_icon_url: [
                        ->{
                          if icon_farm
                            if icon_server > 0 && id
                              "http://farm{#{icon_farm}}.staticflickr.com/{#{icon_server}}/buddyicons/#{id}.jpg"
                            else
                              "http://www.flickr.com/images/buddyicon.jpg"
                            end
                          end
                        }
                      ],
    }
  end
end
