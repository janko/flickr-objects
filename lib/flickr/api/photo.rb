require "flickr/api/api_methods/photo"

class Flickr
  class Photo < Media
    def self.search(params = {})
      super(params.merge(media: "photos"))
    end
  end
end
