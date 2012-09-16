class Flickr
  class Photo < Media
    self.attribute_values.update(
      rotation:   [->{ @hash.fetch("rotation") }],
      source_url: [->{ @hash.fetch("url_#{size_abbr}") }],
      height:     [->{ @hash.fetch("height_#{size_abbr}") }],
      width:      [->{ @hash.fetch("width_#{size_abbr}") }]
    )
  end
end
