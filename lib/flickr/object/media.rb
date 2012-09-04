class Flickr
  class Media < Object
    class << self
      def search(params = {})
      end
      api_method :search, "flickr.photos.search"
    end

    def get_info!(params = {})
    end
    api_method :get_info!, "flickr.photos.getInfo"
  end
end
