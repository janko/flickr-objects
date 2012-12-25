class Flickr
  class Set < Object
    class_api_method :create, "flickr.photosets.create"
    class_api_method :delete, "flickr.photosets.delete"
    class_api_method :order,  "flickr.photosets.orderSets"

    instance_api_method :add_photo,         "flickr.photosets.addPhoto"
    instance_api_method :delete,            "flickr.photosets.delete"
    instance_api_method :edit_photos,       "flickr.photosets.editPhotos"
    instance_api_method :get_info!,         "flickr.photosets.getInfo"
    instance_api_method :get_photos,        "flickr.photosets.getPhotos"
    instance_api_method :remove_photos,     "flickr.photosets.removePhotos"
    instance_api_method :remove_photo,      "flickr.photosets.removePhoto"
    instance_api_method :edit_meta,         "flickr.photosets.editMeta"
    instance_api_method :reorder_photos,    "flickr.photosets.reorderPhotos"
    instance_api_method :set_primary_photo, "flickr.photosets.setPrimaryPhoto", aliases: [:primary_photo=]
  end
end
