class Flickr
  class Media < Object
    extend ApiCaller::ApiMethods

    self.class_api_methods = {
      search: "flickr.photos.search"
    }

    self.instance_api_methods = {
      get_info!: "flickr.photos.getInfo"
    }
  end
end
