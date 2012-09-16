class Flickr
  class Video < Media
    self.attribute_values = {
      ready?:   [->{ @hash["video"].fetch("ready") }],
      failed?:  [->{ @hash["video"].fetch("failed") }],
      pending?: [->{ @hash["video"].fetch("pending") }],
      duration: [->{ @hash["video"].fetch("duration") }],
      width:    [->{ @hash["video"].fetch("width") }],
      height:   [->{ @hash["video"].fetch("height") }],
    }
  end
end
