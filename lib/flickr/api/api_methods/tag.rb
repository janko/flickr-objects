class Flickr
  class Tag < Object
    self.instance_api_methods = {
      delete: "flickr.photos.removeTag"
    }

    self.class_api_methods = {}
  end
end

Flickr::Tag.register_api_methods!
