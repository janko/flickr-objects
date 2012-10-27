class Flickr
  class Video < Media
    self.attribute_values = {
      ready?:   [->{ @hash["video"]["ready"] }],
      failed?:  [->{ @hash["video"]["failed"] }],
      pending?: [->{ @hash["video"]["pending"] }],
      duration: [->{ @hash["video"]["duration"] }],
      width:    [->{ @hash["video"]["width"] }],
      height:   [->{ @hash["video"]["height"] }],
    }
  end
end
