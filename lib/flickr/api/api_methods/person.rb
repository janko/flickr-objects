class Flickr
  class Person < Object
    self.instance_api_methods = {
      get_contacts_public_photos: "flickr.photos.getContactsPublicPhotos",
      get_contacts_public_videos: "flickr.photos.getContactsPublicPhotos",
      get_contacts_public_media:  "flickr.photos.getContactsPublicPhotos",
    }

    self.class_api_methods = {}
  end
end

Flickr::Person.register_api_methods!
