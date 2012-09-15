class Flickr
  class Photo < Media
    self.attribute_values.update(
      rotation:   [proc { @hash.fetch("rotation") }],
      source_url: [proc { @hash.fetch("url_#{size_abbr}") }],
      height:     [proc { @hash.fetch("height_#{size_abbr}") }],
      width:      [proc { @hash.fetch("width_#{size_abbr}") }]
    )
  end
end
