class Flickr
  class Media < Object
    self.class_api_methods = {
      search: "flickr.photos.search"
    }

    self.instance_api_methods = {
      add_tags:         "flickr.photos.addTags",
      get_info!:        "flickr.photos.getInfo",
      remove_tag:       "flickr.photos.removeTag",
      set_content_type: "flickr.photos.setContentType",
      set_tags:         "flickr.photos.setTags"
    }
  end
end
