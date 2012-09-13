class Flickr
  class Photo < Media
    self.attribute_values.update(
      rotation: [proc { |hash| hash.fetch("rotation") }]
    )
  end
end
