class Flickr
  class Video < Media
    self.attribute_values = {
      ready?:           [->{ @hash["video"]["ready"] }],
      failed?:          [->{ @hash["video"]["failed"] }],
      pending?:         [->{ @hash["video"]["pending"] }],
      duration:         [->{ @hash["video"]["duration"] }],
      width:            [->{ @hash["video"]["width"] }],
      height:           [->{ @hash["video"]["height"] }],
      thumbnail_width:  [->(size){ @hash["width_#{SIZES[size]}"] }],
      thumbnail_height: [->(size){ @hash["height_#{SIZES[size]}"] }],
      thumbnail_url:    [->(size){ @hash["url_#{SIZES[size]}"] }],
    }
  end
end
