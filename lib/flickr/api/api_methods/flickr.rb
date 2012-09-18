class Flickr
  self.class_api_methods = {
    get_photos_from_contacts: "flickr.photos.getContactsPhotos",
    get_videos_from_contacts: "flickr.photos.getContactsPhotos",
    get_media_from_contacts:  "flickr.photos.getContactsPhotos",
    test_login:               "flickr.test.login",
    test_echo:                "flickr.test.echo",
    test_null:                "flickr.test.null",
  }

  self.instance_api_methods = class_api_methods
end

Flickr.register_api_methods!
