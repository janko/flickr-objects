class Flickr
  class Photo < Media
    self.attribute_values = attribute_values.merge(
      rotation:   [->{ @hash["rotation"] }],
      source_url: [
                    ->{ @hash["url_#{SIZES[size]}"] },
                    ->{ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["source"] }
                  ],
      height:     [
                    ->{ @hash["height_#{SIZES[size]}"] },
                    ->{ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["height"] }
                  ],
      width:      [
                    ->{ @hash["width_#{SIZES[size]}"] },
                    ->{ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["width"] }
                  ],
    )
  end
end
