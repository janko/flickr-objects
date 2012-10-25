class Flickr
  class Photo < Media
    self.attribute_values.update(
      rotation:   [->{ @hash.fetch("rotation") }],
      source_url: [->{ @hash.fetch("url_#{SIZES[size]}") }],
      height:     [->{ @hash.fetch("height_#{SIZES[size]}") }],
      width:      [->{ @hash.fetch("width_#{SIZES[size]}") }],
    )
  end
end
