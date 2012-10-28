class Flickr
  class Person < Object
    self.attribute_values = {
      id:                   [->{ @hash["nsid"] }],
      nsid:                 [->{ id }],
      username:             [->{ @hash["username"]["_content"] }],
      real_name:            [->{ @hash["realname"] }, ->{ @hash["realname"]["_content"] }],
      icon_server:          [->{ @hash["iconserver"] }],
      icon_farm:            [->{ @hash["iconfarm"] }],
      has_pro_account?:     [->{ @hash["ispro"] }],
      location:             [->{ @hash["location"]["_content"] }],
      time_zone:            [->{ @hash["timezone"] }],
      description:          [->{ @hash["description"]["_content"] }],
      photos_url:           [->{ @hash["photosurl"]["_content"] }],
      profile_url:          [->{ @hash["profileurl"]["_content"] }],
      mobile_url:           [->{ @hash["mobileurl"]["_content"] }],
      first_photo_taken:    [->{ @hash["photos"]["firstdatetaken"]["_content"] }],
      first_photo_uploaded: [->{ @hash["photos"]["firstdate"]["_content"] }],
      photos_count:         [->{ @hash["photos"]["count"]["_content"] }],
      photo_views_count:    [->{ @hash["photos"]["views"]["_content"] }],
    }
  end
end
