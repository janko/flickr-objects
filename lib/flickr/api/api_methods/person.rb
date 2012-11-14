class Flickr
  class Person < Object
    class_api_method :find_by_email,    "flickr.people.findByEmail"
    class_api_method :find_by_username, "flickr.people.findByUsername"

    instance_api_method :get_info!,                       "flickr.people.getInfo"
    instance_api_method :get_photos,                      "flickr.people.getPhotos",               aliases: [:get_videos, :get_media]
    instance_api_method :get_public_photos,               "flickr.people.getPublicPhotos",         aliases: [:get_public_videos, :get_public_media]
    instance_api_method :get_public_photos_from_contacts, "flickr.photos.getContactsPublicPhotos", aliases: [:get_public_videos_from_contacts, :get_public_media_from_contacts]
    instance_api_method :get_sets,                        "flickr.photosets.getList"
  end
end
