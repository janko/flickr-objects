class Flickr
  class Photo < Media
    def get_info!(params = {})
    end
    api_method :get_info!, "flickr.photos.getInfo"

    class << self
      def search(params = {})
      end
      api_method :search, "flickr.photos.search"
    end
  end
end
