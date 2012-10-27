class Flickr
  class Photo < Media
    self.attribute_values.update(
      rotation:   [->{ @hash["rotation"] }],
      source_url: [->{ @hash["url_#{SIZES[size]}"] }],
      height:     [->{ @hash["height_#{SIZES[size]}"] }],
      width:      [->{ @hash["width_#{SIZES[size]}"] }],
    )
  end
end
