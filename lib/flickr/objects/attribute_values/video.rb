class Flickr
  class Video < Media
    self.attribute_values = {
      ready?:              [->{ @hash["video"]["ready"] }],
      failed?:             [->{ @hash["video"]["failed"] }],
      pending?:            [->{ @hash["video"]["pending"] }],
      duration:            [->{ @hash["video"]["duration"] }],
      width:               [->{ @hash["video"]["width"] }],
      height:              [->{ @hash["video"]["height"] }],
      thumbnail_url:       [
                             ->(size){ @hash["url_#{SIZES[size]}"] },
                             ->(size){ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["source"] }
                           ],
      thumbnail_width:     [
                             ->(size){ @hash["width_#{SIZES[size]}"] },
                             ->(size){ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["width"] }
                           ],
      thumbnail_height:    [
                             ->(size){ @hash["height_#{SIZES[size]}"] },
                             ->(size){ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["height"] }
                           ],
      source_url:          [->{ @hash["size"].find { |hash| hash["label"] == "Video Player" }["source"] }],
      download_url:        [->{ @hash["size"].find { |hash| hash["label"] == "Site MP4" }["source"] }],
      mobile_download_url: [->{ @hash["size"].find { |hash| hash["label"] == "Mobile MP4" }["source"] }],
    )
  end
end
