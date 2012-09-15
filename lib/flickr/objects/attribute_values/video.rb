class Flickr
  class Video < Media
    self.attribute_values = {
      ready?:   [proc { @hash["video"].fetch("ready") }],
      failed?:  [proc { @hash["video"].fetch("failed") }],
      pending?: [proc { @hash["video"].fetch("pending") }],
      duration: [proc { @hash["video"].fetch("duration") }],
      width:    [proc { @hash["video"].fetch("width") }],
      height:   [proc { @hash["video"].fetch("height") }],
    }
  end
end
