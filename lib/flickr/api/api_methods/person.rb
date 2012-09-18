class Flickr
  class Person < Object
    self.instance_api_methods = {
      get_public_photos_from_contacts: "flickr.photos.getContactsPublicPhotos",
      get_public_videos_from_contacts: "flickr.photos.getContactsPublicPhotos",
      get_public_media_from_contacts:  "flickr.photos.getContactsPublicPhotos",
    }

    self.class_api_methods = {}
  end
end

Flickr::Person.register_api_methods!
