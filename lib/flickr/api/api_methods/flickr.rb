class Flickr
  self.class_api_methods = {
    get_contacts_photos: "flickr.photos.getContactsPhotos",
    get_contacts_videos: "flickr.photos.getContactsPhotos",
    get_contacts_media:  "flickr.photos.getContactsPhotos",
    test_login:          "flickr.test.login",
    test_echo:           "flickr.test.echo",
    test_null:           "flickr.test.null",
  }

  self.instance_api_methods = class_api_methods
end

Flickr.register_api_methods!
