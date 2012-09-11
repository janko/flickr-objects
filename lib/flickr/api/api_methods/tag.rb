class Flickr
  class Tag < Object
    self.instance_api_methods = {
      delete: "flickr.photos.removeTag"
    }
  end
end
