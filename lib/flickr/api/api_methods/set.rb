class Flickr
  class Set
    class_api_method :create, "flickr.photosets.create"

    instance_api_method :add_photo,     "flickr.photosets.addPhoto",     aliases: [:add_video, :add_media]
    instance_api_method :delete,        "flickr.photosets.delete"
    instance_api_method :edit_photos,   "flickr.photosets.editPhotos",   aliases: [:edit_videos, :edit_media]
    instance_api_method :get_info!,     "flickr.photosets.getInfo"
    instance_api_method :get_photos,    "flickr.photosets.getPhotos",    aliases: [:get_videos, :get_media]
    instance_api_method :remove_photos, "flickr.photosets.removePhotos", aliases: [:remove_videos, :remove_media]
    instance_api_method :remove_photo,  "flickr.photosets.removePhoto",  aliases: [:remove_video, :remove_media]
  end
end
