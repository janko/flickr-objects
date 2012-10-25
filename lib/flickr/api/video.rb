class Flickr
  class Video < Media
    def self.search(params = {})
      super(params.merge(media: "videos"))
    end
  end
end
